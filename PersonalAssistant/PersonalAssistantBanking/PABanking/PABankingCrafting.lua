-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PASV = PA.SavedVars
local PAHF = PA.HelperFunctions
local L = PA.Localization

-- ---------------------------------------------------------------------------------------------------------------------

local doneOnce = false


local function GetItemDataFilterComparator()
    return function(itemData)
--        if not doneOnce then
--            doneOnce = true
--            d(itemData)
--        end
--
--        itemData.bagId
--        itemData.slotIndex
--    itemData.specializedItemType
--    itemData.itemType
--    itemData.stolen
--    itemData.isJunk
--    itemData.filterType -- 23

--        d(itemData.itemType)

--        local itemFilterType = GetItemFilterTypeInfo(itemData.bagId, itemData.slotIndex)
--        d(itemFilterType)

--        return ZO_InventoryUtils_DoesNewItemMatchFilterType(itemData, ITEMFILTERTYPE_WOODWORKING)

        return itemData.itemType == ITEMTYPE_WOODWORKING_BOOSTER or itemData.itemType == ITEMTYPE_WOODWORKING_MATERIAL or itemData.itemType == ITEMTYPE_WOODWORKING_RAW_MATERIAL
    end

end



local function getComparator(itemTypeList)
    return function(itemData)
        for _, itemType in pairs(itemTypeList) do
            if itemType == itemData.itemType then return true end
        end
        return false
    end
end


local function moveItem(sourceBag, sourceSlot, destBag, destSlot, stackCount)
    if IsProtectedFunction("RequestMoveItem") then
        CallSecureProtected("RequestMoveItem", sourceBag, sourceSlot, destBag, destSlot, stackCount)
    else
        RequestMoveItem(sourceBag, sourceSlot, destBag, destSlot, stackCount)
    end
end


local function moveItemsFromTo(fromBagCache, toBagCache, newStacksAllowed)

    local notMovedTable = setmetatable({}, { __index = table })

    for _, fromBagItemData in pairs(fromBagCache) do
        local itemMoved = false

        for _, toBagItemData in pairs(toBagCache) do
            if fromBagItemData.itemInstanceId == toBagItemData.itemInstanceId then
                -- same itemInstanceId
                local targetStack, targetMaxStack = GetSlotStackSize(toBagItemData.bagId, toBagItemData.slotIndex)
                local targetFreeStacks = targetMaxStack - targetStack

                if targetFreeStacks > 0 then
                    local sourceStack, _ = GetSlotStackSize(fromBagItemData.bagId, fromBagItemData.slotIndex)
                    if sourceStack <= targetFreeStacks then
                        -- enough space to move all
                        moveItem(fromBagItemData.bagId, fromBagItemData.slotIndex, toBagItemData.bagId, toBagItemData.slotIndex, sourceStack)
                        itemMoved = true
                        d("move " .. sourceStack .. " x " .. fromBagItemData.name)
                    else
                        -- not enough space, only fill up stack possible
                        moveItem(fromBagItemData.bagId, fromBagItemData.slotIndex, toBagItemData.bagId, toBagItemData.slotIndex, targetFreeStacks)
                        itemMoved = true
                        d("move " .. targetFreeStacks .. "/" .. sourceStack .. " x " .. fromBagItemData.name)

                        if newStacksAllowed then
                            local firstEmptySlot = FindFirstEmptySlotInBag(toBagItemData.bagId)
                            if (firstEmptySlot ~= nil) then
                                local remainingStack = sourceStack - targetFreeStacks
                                moveItem(fromBagItemData.bagId, fromBagItemData.slotIndex, toBagItemData.bagId, firstEmptySlot, remainingStack)
                                d("move remaining " .. remainingStack .. "/" .. sourceStack .. " x " .. fromBagItemData.name)
                            end
                        end
                    end
                end
            end

            if itemMoved then break end
        end

        if not itemMoved then
            notMovedTable:insert(fromBagItemData)
        end
    end

    for _, toBagItemData in pairs(notMovedTable) do
        -- TODO: check if creating new stacks allowed
        d(toBagItemData.name)
    end




    -- TODO: open questions: how to find the correct bagId when creating new stacks?
end


local function depositCraftingItems(depositComparator, newStacksAllowed)
    local toDepositBagCache = SHARED_INVENTORY:GenerateFullSlotData(depositComparator, BAG_BACKPACK)
    local toFillUpBagCache = SHARED_INVENTORY:GenerateFullSlotData(depositComparator, BAG_BANK, BAG_SUBSCRIBER_BANK)
    moveItemsFromTo(toDepositBagCache, toFillUpBagCache, newStacksAllowed)
end

local function withdrawCraftingItems(withdrawComparator, newStacksAllowed)
    local toWithdrawBagCache = SHARED_INVENTORY:GenerateFullSlotData(withdrawComparator, BAG_BANK, BAG_SUBSCRIBER_BANK)
    local toFillUpBagCache = SHARED_INVENTORY:GenerateFullSlotData(withdrawComparator, BAG_BACKPACK)
    moveItemsFromTo(toWithdrawBagCache, toFillUpBagCache, newStacksAllowed)
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

    -- first try to deposit everything
    depositCraftingItems(depositComparator, true)

    -- then withdraw
    withdrawCraftingItems(withdrawComparator, false)

    -- finally try to deposit again (in case withdrawal freed up some space)
    -- TODO: how to check if still needed?
--    depositCraftingItems(depositComparator, false)
end


-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.depositOrWithdrawCraftingItems = depositOrWithdrawCraftingItems