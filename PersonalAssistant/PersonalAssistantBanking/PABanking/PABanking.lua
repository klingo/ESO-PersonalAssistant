-- Local instances of Global tables --
local PA = PersonalAssistant
local PASV = PA.SavedVars
local PAB = PA.Banking
local PAMF = PA.MenuFunctions
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

-- will be initialise from SavedVars upon triggering the module
local _transactionInterval

local function _requestMoveItem(sourceBag, sourceSlot, destBag, destSlot, stackCount)
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
local function _findFirstEmptySlotAndTargetBagFromSourceBag(sourceBagId)
    local targetBagId
    local targetSlotIndex

    -- try to find an empty slot in the target bag; based on the provided sourceBag
    if sourceBagId == BAG_BACKPACK then
        targetBagId = BAG_BANK
        targetSlotIndex = FindFirstEmptySlotInBag(targetBagId)
        if targetSlotIndex == nil then
            targetBagId = BAG_SUBSCRIBER_BANK
            targetSlotIndex = FindFirstEmptySlotInBag(targetBagId)
        end
    elseif sourceBagId == BAG_BANK or sourceBagId == BAG_SUBSCRIBER_BANK then
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
local function moveSecureItemsFromTo(toBeMovedItemsTable, startIndex, toBeMovedAgainTable)
    local fromBagItemData = toBeMovedItemsTable[startIndex]
    local targetBagId, firstEmptySlot = _findFirstEmptySlotAndTargetBagFromSourceBag(fromBagItemData.bagId)
    local itemLink = PAHF.getFormattedItemLink(fromBagItemData.bagId, fromBagItemData.slotIndex)
    if (targetBagId ~= nil and firstEmptySlot ~= nil) then
        if not PA.isBankClosed then
            local sourceStack, _ = GetSlotStackSize(fromBagItemData.bagId, fromBagItemData.slotIndex)
            -- in case there was a custom amount to be moved defined; overwrite the stack size
            local customStackToMove = fromBagItemData.customStackToMove
            if (customStackToMove ~= nil) then sourceStack = customStackToMove end
            PAHF.println("PAB_Items_MovedTo_Full", sourceStack, itemLink, PAHF.getBagName(targetBagId))
            _requestMoveItem(fromBagItemData.bagId, fromBagItemData.slotIndex, targetBagId, firstEmptySlot, sourceStack)

            local newStartIndex = startIndex + 1
            if newStartIndex <= #toBeMovedItemsTable then
                zo_callLater(function()
                    moveSecureItemsFromTo(toBeMovedItemsTable, newStartIndex, toBeMovedAgainTable)
                end, _transactionInterval)
            else
                -- loop completed; check if there are any items to be moved again (re-try)
                if (toBeMovedAgainTable ~= nil and #toBeMovedAgainTable > 0) then
                    -- if there are items left, try again
                    zo_callLater(function()
                        moveSecureItemsFromTo(toBeMovedAgainTable, 1, nil)
                    end, _transactionInterval)
                else
                    -- nothing else that can be moved; done
                    -- TODO: end message?
                    d("2) all done!")
                    PAB.isBankTransferBlocked = false
                    -- Execute the function queue
                    PAB.triggerNextTransactionFunction()
                end
            end
        else
            -- abort; dont continue
            PAHF.println("PAB_Items_MovedTo_BankClosed", itemLink, PAHF.getBagName(BAG_BANK))
            PAB.isBankTransferBlocked = false
        end
    else
        -- cannot move item because there is not enough space; put it on separate list to try again afterwards
        if (toBeMovedAgainTable ~= nil) then
            table.insert(toBeMovedAgainTable, fromBagItemData)
            local newStartIndex = startIndex + 1
            if newStartIndex <= #toBeMovedItemsTable then
                zo_callLater(function()
                    moveSecureItemsFromTo(toBeMovedItemsTable, newStartIndex, toBeMovedAgainTable)
                end, _transactionInterval)
            else
                -- loop completed;  try again with the items added to the re-try list
                zo_callLater(function()
                    moveSecureItemsFromTo(toBeMovedAgainTable, 1, nil)
                end, _transactionInterval)
            end
        else
            -- Abort; dont continue (even in 2nd run no transfer possible)
            PAHF.println("PAB_Items_MovedTo_OutOfSpace", itemLink, PAHF.getBagName(BAG_BANK))
            PAB.isBankTransferBlocked = false
            -- Execute the function queue
            PAB.triggerNextTransactionFunction()
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

-- Immediately moves items from source to target bag, if the same item exists in both locations (i.e. filling up existing
-- stacks). All items that either cannot be moved because there is no matching item in the target bag, or because the
-- existing stacks have already been filled up; these will be added to the [notMovedItemsTable] table. Provided that
-- [newStacksAllowed] is set to true; otherwise the table will be returned unchanged
local function stackInTargetBagAndPopulateNotMovedItemsTable(fromBagCache, toBagCache, newStacksAllowed, notMovedItemsTable, stackToMove)
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
                    local itemLink = PAHF.getFormattedItemLink(fromBagItemData.bagId, fromBagItemData.slotIndex)
                    local moveableStack = sourceStack
                    if stackToMove ~= nil then
                        -- only some of the stack can be moved; update the [moveableStack]
                        moveableStack = stackToMove
                    end
                    if moveableStack <= targetFreeStacks then
                        -- enough space to move all
                        PAHF.println("PAB_Items_MovedTo_Full", moveableStack, itemLink, PAHF.getBagName(toBagItemData.bagId))
                        _requestMoveItem(fromBagItemData.bagId, fromBagItemData.slotIndex, toBagItemData.bagId, toBagItemData.slotIndex, moveableStack)
                        isItemMoved = true
                        hasNoStacksLeft = true
                    else
                        -- not enough space, only fill up stack possible
                        PAHF.println("PAB_Items_MovedTo_Partial", targetFreeStacks, moveableStack, itemLink, PAHF.getBagName(toBagItemData.bagId))
                        _requestMoveItem(fromBagItemData.bagId, fromBagItemData.slotIndex, toBagItemData.bagId, toBagItemData.slotIndex, targetFreeStacks)
                        -- reduce the remaining amount that needs to be moved
                        stackToMove = stackToMove - targetFreeStacks
                        -- cannot be set to [isItemMoved = true] because there is still a remaining stack that needs to be moved
                    end
                end
            end
            -- stop loop if item was already moved and no stacks to be moved are left
            if isItemMoved and hasNoStacksLeft then break end
        end

        -- if the item could not be moved (because no further existing stack to fill up), add it to the notMoved table
        if not isItemMoved and newStacksAllowed then
            fromBagItemData.customStackToMove = stackToMove
            table.insert(notMovedItemsTable, fromBagItemData)
        end
    end
end


local function stackBank()
    if PASV.Banking[PA.activeProfile].autoStackBank then
        StackBag(BAG_BANK)
        StackBag(BAG_SUBSCRIBER_BANK)
    end
    -- Execute the function queue
    PAB.triggerNextTransactionFunction()
end

local function updateTransactionInterval()
    _transactionInterval = PAMF.PABanking.getTransactionInvervalSetting()
end


local function triggerNextTransactionFunction()
    -- Execute the function queue
    if #PAB.transactionFunctionQueue > 0 then
        -- remove the last entry from the list, and store it
        local functionToCall = table.remove(PAB.transactionFunctionQueue)
        -- call that function and pass on the remaining list of transactionFunctions
        functionToCall()
    end
end

local function getCombinedItemTypeSpecializedComparator(itemTypeList, spevializedItemTypeList)
    return function(itemData)
        for _, itemType in pairs(itemTypeList) do
            if itemType == itemData.itemType then return true end
        end
        for _, specializedItemType in pairs(spevializedItemTypeList) do
            if specializedItemType == itemData.specializedItemType then return true end
        end
        return false
    end
end

local function getItemTypeComparator(itemTypeList)
    return function(itemData)
        for _, itemType in pairs(itemTypeList) do
            if itemType == itemData.itemType then return true end
        end
        return false
    end
end


local function getItemIdComparator(itemIdList)
    return function(itemData)
        for itemId, _ in pairs(itemIdList) do
            if itemId == GetItemId(itemData.bagId, itemData.slotIndex)  then return true end
        end
        return false
    end
end


local function OnBankOpen()
    if (PAHF.hasActiveProfile()) then
        -- set the global variable to 'false'
        PA.isBankClosed = false

        -- check if gold deposit is enabled
        if PASV.Banking[PA.activeProfile].Currencies.currenciesEnabled then
            -- trigger the deposit and withdrawal of gold
            PAB.depositOrWithdrawCurrencies()
        end

        -- check if the different transactions are enabled and add them to the function queue (will be executed in REVERSE order)
        PAB.transactionFunctionQueue = {}
        table.insert(PAB.transactionFunctionQueue, stackBank)
        if PASV.Banking[PA.activeProfile].Advanced.advancedItemsEnabled then
            table.insert(PAB.transactionFunctionQueue, PAB.depositOrWithdrawAdvancedItems)
        end
        if PASV.Banking[PA.activeProfile].Individual.individualItemsEnabled then
            table.insert(PAB.transactionFunctionQueue, PAB.depositOrWithdrawIndividualItems)
        end
        if PASV.Banking[PA.activeProfile].Crafting.craftingItemsEnabled then
            table.insert(PAB.transactionFunctionQueue, PAB.depositOrWithdrawCraftingItems)
        end
        table.insert(PAB.transactionFunctionQueue, stackBank)

        -- Execute the function queue
        PAB.triggerNextTransactionFunction()
    end

    -- some debug statements
    PAHF.debugln("IsESOPlusSubscriber() = %s", tostring(IsESOPlusSubscriber()));
    PAHF.debugln("HasCraftBagAccess() = %s", tostring(HasCraftBagAccess()));
    PAHF.debugln("GetBagUseableSize(BAG_BACKPACK) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_BACKPACK), GetNumBagUsedSlots(BAG_BACKPACK), GetNumBagFreeSlots(BAG_BACKPACK));
    PAHF.debugln("GetBagUseableSize(BAG_BANK) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_BANK), GetNumBagUsedSlots(BAG_BANK), GetNumBagFreeSlots(BAG_BANK));
    PAHF.debugln("GetBagUseableSize(BAG_GUILDBANK) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_GUILDBANK), GetNumBagUsedSlots(BAG_GUILDBANK), GetNumBagFreeSlots(BAG_GUILDBANK));
    PAHF.debugln("GetBagUseableSize(BAG_SUBSCRIBER_BANK) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_SUBSCRIBER_BANK), GetNumBagUsedSlots(BAG_SUBSCRIBER_BANK), GetNumBagFreeSlots(BAG_SUBSCRIBER_BANK));
    PAHF.debugln("GetBagUseableSize(BAG_VIRTUAL) = %d   |   [%d used, %d free]", GetBagUseableSize(BAG_VIRTUAL), GetNumBagUsedSlots(BAG_VIRTUAL), GetNumBagFreeSlots(BAG_VIRTUAL));
    PAHF.debugln("GetNextVirtualBagSlotId() = %d", GetNextVirtualBagSlotId());
end

local function OnBankClose()
    -- set the global variable to 'true' so the bankClosing can be detected
    PA.isBankClosed = true
end


-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.OnBankOpen = OnBankOpen
PA.Banking.OnBankClose = OnBankClose
PA.Banking.updateTransactionInterval = updateTransactionInterval
PA.Banking.triggerNextTransactionFunction = triggerNextTransactionFunction
PA.Banking.getCombinedItemTypeSpecializedComparator = getCombinedItemTypeSpecializedComparator
PA.Banking.getItemTypeComparator = getItemTypeComparator
PA.Banking.getItemIdComparator = getItemIdComparator
PA.Banking.moveSecureItemsFromTo = moveSecureItemsFromTo
PA.Banking.stackInTargetBagAndPopulateNotMovedItemsTable = stackInTargetBagAndPopulateNotMovedItemsTable