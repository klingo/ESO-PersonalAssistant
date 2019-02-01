-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PASV = PA.SavedVars
local PAHF = PA.HelperFunctions
local L = PA.Localization

-- ---------------------------------------------------------------------------------------------------------------------

-- TODO: Assumption: Filling up existing stacks can be done immediately; creating new stacks takes time (i.e. zo_callLater needed)
-- TODO: This is confirmed!

local isBankTransferBlocked = false

local TIMER_TO_BE_REPLACED = 100

local function getComparator(itemTypeList)
    return function(itemData)
        for _, itemType in pairs(itemTypeList) do
            if itemType == itemData.itemType then return true end
        end
        return false
    end
end


-- Actually requests the move of an item
local function requestMoveItem(sourceBag, sourceSlot, destBag, destSlot, stackCount)
    if IsProtectedFunction("RequestMoveItem") then
        CallSecureProtected("RequestMoveItem", sourceBag, sourceSlot, destBag, destSlot, stackCount)
    else
        RequestMoveItem(sourceBag, sourceSlot, destBag, destSlot, stackCount)
    end
end


-- Given the sourceBagId, this function tries to find the first empty slot in a potential target bagId.
-- If the sourceBagId is the Backpack, the target will be either from Bank or SubscriberBank.
-- If the sourceBagId is the Bank or SubscriberBank, the target will always be the Backpack
-- If no empty slot can be found, the function returns: nil, nil
local function findFirstEmptySlotAndTargetBagFromSourceBag(sourceBagId)
    local targetBagId
    local targetSlotIndex

    -- try to find an empty slot in the target bag; based on the provided sourceBag
    if sourceBagId == BAG_BACKPACK then
        targetBagId = BAG_BANK
        targetSlotIndex = FindFirstEmptySlotInBag(targetBagId)
        if targetSlotIndex == nil then
            targetBagId = BAG_BAG_SUBSCRIBER_BANK
            targetSlotIndex = FindFirstEmptySlotInBag(targetBagId)
        end
    elseif sourceBagId == BAG_BANK or sourceBagId == BAG_BAG_SUBSCRIBER_BANK then
        targetBagId = BAG_BACKPACK
        targetSlotIndex = FindFirstEmptySlotInBag(targetBagId)
    end

    -- check if both values could be defined
    if targetBagId ~= nil and targetSlotIndex ~= nil then
        -- yes; valid empty sloud found; return information
        return targetBagId, targetSlotIndex
    end
    -- no; not enough space or bag not found; return nil, nil
    return nil, nil
end


-- Recursive function that tries to find new slots in the corresponding targetBags from the given list of itemDatas
-- The startIndex indicates from which item in the list the check for moving should be started
local function moveSecureItemsFromTo(notMovedTable, startIndex)
    local fromBagItemData = notMovedTable[startIndex]
    local targetBagId, firstEmptySlot = findFirstEmptySlotAndTargetBagFromSourceBag(fromBagItemData.bagId)
    if (targetBagId ~= nil and firstEmptySlot ~= nil) then
        local sourceStack, _ = GetSlotStackSize(fromBagItemData.bagId, fromBagItemData.slotIndex)

        d("2) move " .. sourceStack .. " x " .. fromBagItemData.name)
        requestMoveItem(fromBagItemData.bagId, fromBagItemData.slotIndex, targetBagId, firstEmptySlot, sourceStack)

        local newStartIndex = startIndex + 1
        if newStartIndex <= #notMovedTable then
            zo_callLater(function()
                moveSecureItemsFromTo(notMovedTable, newStartIndex)
            end, TIMER_TO_BE_REPLACED)
            -- timer = timer + PASV.Banking[PA.activeProfile].depositTimerInterval
            -- TODO: implement in UI+settings
        else
            d("2) all done!")
        end
    else
        d("2) cannot move " .. fromBagItemData.name .. " - not enough space")
        -- TODO: abort; dont continue
    end

end


-- Immediately moves items from source to target bag, if the same item exists in both locations (i.e. filling up existing
-- stacks). All items that either cannot be moved because there is no matching item in the target bag, or because the
-- existing stacks have already been filled up; these will be added to the [notMovedItemsTable] table. Provided that
-- [newStacksAllowed] is set to true; otherwise the table will be returned unchanged
local function stackInTargetBagAndPopulateNotMovedItemsTable(fromBagCache, toBagCache, newStacksAllowed, notMovedItemsTable)
    for _, fromBagItemData in pairs(fromBagCache) do
        local isItemMoved = false
        local hasNoStacksLeft = false
        for _, toBagItemData in pairs(toBagCache) do
            if fromBagItemData.itemInstanceId == toBagItemData.itemInstanceId then
                -- same itemInstanceId
                local targetStack, targetMaxStack = GetSlotStackSize(toBagItemData.bagId, toBagItemData.slotIndex)
                local targetFreeStacks = targetMaxStack - targetStack
                if targetFreeStacks > 0 then
                    local sourceStack, _ = GetSlotStackSize(fromBagItemData.bagId, fromBagItemData.slotIndex)
                    if sourceStack <= targetFreeStacks then
                        -- enough space to move all
                        d("1) move " .. sourceStack .. " x " .. fromBagItemData.name)
                        requestMoveItem(fromBagItemData.bagId, fromBagItemData.slotIndex, toBagItemData.bagId, toBagItemData.slotIndex, sourceStack)
                        isItemMoved = true
                        hasNoStacksLeft = true
                    else
                        -- not enough space, only fill up stack possible
                        d("1) move " .. targetFreeStacks .. "/" .. sourceStack .. " x " .. fromBagItemData.name)
                        requestMoveItem(fromBagItemData.bagId, fromBagItemData.slotIndex, toBagItemData.bagId, toBagItemData.slotIndex, targetFreeStacks)
                        isItemMoved = true
                    end
                end
            end
            -- stop loop if item was already moved and no stacks to be moved are left
            if isItemMoved and hasNoStacksLeft then break end
        end

        -- if the item could not be moved (because no further existing stack to fill up), add it to the notMoved table
        if not isItemMoved and newStacksAllowed then
            d("1) add "..fromBagItemData.name.." to notMovedTable")
            table.insert(notMovedItemsTable, fromBagItemData)
        end
    end
end


local function doItemTransactions(fromBagCacheDeposit, toBagCacheDeposit, fromBagCacheWithdraw, toBagCacheWithdraw, newStacksAllowed)
    -- prepare the table for the items that need a new stack created
    local notMovedItemsTable = {}

    -- automatically fills up existing stacks; and if new stacks are needed (and allowed), these are added to the table
    stackInTargetBagAndPopulateNotMovedItemsTable(fromBagCacheDeposit, toBagCacheDeposit, newStacksAllowed, notMovedItemsTable)
    stackInTargetBagAndPopulateNotMovedItemsTable(fromBagCacheWithdraw, toBagCacheWithdraw, newStacksAllowed, notMovedItemsTable)

    -- after initial run-through, go though all not yet moved items and look for free slots for them
    if newStacksAllowed and #notMovedItemsTable > 0 then
        moveSecureItemsFromTo(notMovedItemsTable, 1)
    else
        -- all stacking done; and no further items to be moved
        -- TODO: end message?
        d("1) all done!")
    end
end


local function doSameBagStacking(bagId)
    -- TODO: needed?
end


-- ---------------------------------------------------------------------------------------------------------------------

local function depositOrWithdrawCraftingItems()
    -- prepare the table with itemTypes to deposit and withdraw
    local depositItemTypes = setmetatable({}, { __index = table })
    local withdrawItemTypes = setmetatable({}, { __index = table })

    -- fill up the table
    for itemType, moveMode in pairs(PASV.Banking[PA.activeProfile].CraftingItemTypeMoves) do
        if (moveMode == PAC.MOVE.DEPOSIT) then
            depositItemTypes:insert(itemType)
        elseif (moveMode == PAC.MOVE.WITHDRAW) then
            withdrawItemTypes:insert(itemType)
        end
    end

    local depositComparator = getComparator(depositItemTypes)
    local withdrawComparator = getComparator(withdrawItemTypes)

    local toDepositBagCache = SHARED_INVENTORY:GenerateFullSlotData(depositComparator, BAG_BACKPACK)
    local toFillUpDepositBagCache = SHARED_INVENTORY:GenerateFullSlotData(depositComparator, BAG_BANK, BAG_SUBSCRIBER_BANK)

    local toWithdrawBagCache = SHARED_INVENTORY:GenerateFullSlotData(withdrawComparator, BAG_BANK, BAG_SUBSCRIBER_BANK)
    local toFillUpWithdrawBagCache = SHARED_INVENTORY:GenerateFullSlotData(withdrawComparator, BAG_BACKPACK)

    -- TODO: get parameter from Settings
    doItemTransactions(toDepositBagCache, toFillUpDepositBagCache, toWithdrawBagCache, toFillUpWithdrawBagCache, true)
end


-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.depositOrWithdrawCraftingItems = depositOrWithdrawCraftingItems