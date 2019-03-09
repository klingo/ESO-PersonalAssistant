-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PAC = PA.Constants
local PAMF = PA.MenuFunctions
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

-- NOTE: Filling up existing stacks can be done immediately; creating new stacks takes time (i.e. zo_callLater needed)

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
            local customStackToMoveOriginal = fromBagItemData.customStackToMoveOriginal
            if (customStackToMove ~= nil) then sourceStack = customStackToMove end
            -- if there either was no original amount; or it is the same as the one to be moved, treat it as a complete move
            if (customStackToMoveOriginal == nil or customStackToMoveOriginal == customStackToMove) then
                PAHF.println(SI_PA_BANKING_ITEMS_MOVED_COMPLETE, sourceStack, itemLink, PAHF.getBagName(targetBagId))
            else
                PAHF.println(SI_PA_BANKING_ITEMS_MOVED_PARTIAL, sourceStack, customStackToMoveOriginal, itemLink, PAHF.getBagName(targetBagId))
            end
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
                    PAHF.debugln("2) all done!")
                    PAB.isBankTransferBlocked = false
                    -- Execute the function queue
                    PAB.triggerNextTransactionFunction()
                end
            end
        else
            -- abort; dont continue
            PAHF.println(SI_PA_BANKING_ITEMS_NOT_MOVED_BANKCLOSED, itemLink, PAHF.getBagName(BAG_BANK))
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
            PAHF.println(SI_PA_BANKING_ITEMS_NOT_MOVED_OUTOFSPACE, itemLink, PAHF.getBagName(BAG_BANK))
            PAB.isBankTransferBlocked = false
            -- Execute the function queue
            PAB.triggerNextTransactionFunction()
        end
    end
end


-- Immediately moves items from source to target bag, if the same item exists in both locations (i.e. filling up existing
-- stacks). All items that either cannot be moved because there is no matching item in the target bag, or because the
-- existing stacks have already been filled up; these will be added to the [notMovedItemsTable] table. Provided that
-- [newStacksAllowed] is set to true; otherwise the table will be returned unchanged
local function stackInTargetBagAndPopulateNotMovedItemsTable(fromBagCache, toBagCache, newStacksAllowed, notMovedItemsTable, overruleStackToMove)
    for _, fromBagItemData in pairs(fromBagCache) do
        local isItemMoved = false
        local hasNoStacksLeft = false
        local skipItem = false

        local itemLink = PAHF.getFormattedItemLink(fromBagItemData.bagId, fromBagItemData.slotIndex)
        local sourceStack, sourceStackMaxSize = GetSlotStackSize(fromBagItemData.bagId, fromBagItemData.slotIndex)
        local stackToMove = overruleStackToMove or sourceStack
        PAHF.debugln("try to move %d x %s", stackToMove, itemLink)

        for toBagCacheIndex, toBagItemData in pairs(toBagCache) do
            if fromBagItemData.itemInstanceId == toBagItemData.itemInstanceId then
                -- same itemInstanceId
                local _, targetMaxStack = GetSlotStackSize(toBagItemData.bagId, toBagItemData.slotIndex)
                local targetStack = toBagItemData.stackCount -- cannot use [GetSlotStackSize] becuase it does not reflect changes after the bagCache is created
                local targetFreeStacks = targetMaxStack - targetStack
                if targetFreeStacks > 0 then
                    local moveableStack = stackToMove
                    if moveableStack <= targetFreeStacks then
                        -- enough space to move all
                        PAHF.println(SI_PA_BANKING_ITEMS_MOVED_COMPLETE, moveableStack, itemLink, PAHF.getBagName(toBagItemData.bagId))
                        _requestMoveItem(fromBagItemData.bagId, fromBagItemData.slotIndex, toBagItemData.bagId, toBagItemData.slotIndex, moveableStack)
                        isItemMoved = true
                        hasNoStacksLeft = true
                        -- update the stackCount in the bagCache manually (since we don't want to completely re-generate it)
                        toBagCache[toBagCacheIndex].stackCount = targetStack + moveableStack
                    else
                        -- not enough space, only fill up stack possible
                        PAHF.println(SI_PA_BANKING_ITEMS_MOVED_PARTIAL, targetFreeStacks, moveableStack, itemLink, PAHF.getBagName(toBagItemData.bagId))
                        _requestMoveItem(fromBagItemData.bagId, fromBagItemData.slotIndex, toBagItemData.bagId, toBagItemData.slotIndex, targetFreeStacks)
                        -- cannot be set to [isItemMoved = true] because there is still a remaining stack that needs to be moved
                        -- reduce the remaining amount that needs to be moved
                        stackToMove = stackToMove - targetFreeStacks
                        -- update the stackCount in the bagCache manually (since we don't want to completely re-generate it)
                        toBagCache[toBagCacheIndex].stackCount = targetStack + targetFreeStacks
                    end
                elseif IsItemLinkUnique(itemLink) then
                    -- match was found, but since it is unique prevent any further move-attempts by skipping it
                    skipItem = true
                    break
                end
            end
            -- stop loop if item was already moved and no stacks to be moved are left
            if isItemMoved and hasNoStacksLeft then break end
        end

        -- if the item could not be moved (because no further existing stack to fill up), add it to the notMoved table
        if not isItemMoved and not skipItem and newStacksAllowed then
            -- check if there are already not moved items; and if the current to be moved item is not a full stack
            if #notMovedItemsTable > 0 and stackToMove < sourceStackMaxSize then
                -- loop through all items already added to list
                for index, prevBagItemData in pairs(notMovedItemsTable) do
                    -- check if it is the same item and if there is some space left
                    if prevBagItemData.itemInstanceId == fromBagItemData.itemInstanceId and prevBagItemData.customStackToMove < sourceStackMaxSize then
                        local prevSourceFreeStack = sourceStackMaxSize - prevBagItemData.customStackToMove
                        if prevSourceFreeStack >= stackToMove and fromBagItemData.stackCount >= stackToMove then
                            -- stack everything
                            notMovedItemsTable[index].customStackToMove = notMovedItemsTable[index].customStackToMove + stackToMove
                            notMovedItemsTable[index].customStackToMoveOriginal = nil -- in case of internal stacking, reset the original amount
                            _requestMoveItem(fromBagItemData.bagId, fromBagItemData.slotIndex, prevBagItemData.bagId, prevBagItemData.slotIndex, stackToMove)
                            -- nothing left to be moved
                            stackToMove = 0
                            break
                        else
                            -- stack only partial
                            notMovedItemsTable[index].customStackToMove = notMovedItemsTable[index].customStackToMove + prevSourceFreeStack
                            notMovedItemsTable[index].customStackToMoveOriginal = nil -- in case of internal stacking, reset the original amount
                            _requestMoveItem(fromBagItemData.bagId, fromBagItemData.slotIndex, prevBagItemData.bagId, prevBagItemData.slotIndex, prevSourceFreeStack)
                            -- partial left to be moved
                            stackToMove = stackToMove - prevSourceFreeStack
                        end
                    end
                end
            end

            -- if there is something left to be moved; add it to the list
            if (stackToMove and stackToMove > 0) then
                fromBagItemData.customStackToMove = stackToMove
                fromBagItemData.customStackToMoveOriginal = sourceStack
                PAHF.debugln("not moved: %d / %d x %s", stackToMove, sourceStack, itemLink)
                table.insert(notMovedItemsTable, fromBagItemData)
            end
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

local function doGenericItemTransactions(depositFromBagCache, depositToBagCache, withdrawalFromBagCache, withdrawalToBagCache)
    -- prepare the table for the items that need a new stack created
    local toBeMovedItemsTable = {}
    local toBeMovedAgainTable = {}

    PAHF.debugln("#toDepositBagCache = "..tostring(#depositFromBagCache))
    PAHF.debugln("#toWithdrawBagCache = "..tostring(#withdrawalFromBagCache))

    -- update the StacksAllowed options from the SavedVars
    -- TODO: Challenge this, as it does not make sense for Glyphs and Treasure Maps
    local newDepositStacksAllowed = (PAMF.PABanking.getTransactionDepositStackingSetting() == PAC.STACKING.FULL)
    local newWithdrawalStacksAllowed = (PAMF.PABanking.getTransactionWithdrawalStackingSetting() == PAC.STACKING.FULL)

    -- automatically fills up existing stacks; and if new stacks are needed (and allowed), these are added to the table
    PAB.stackInTargetBagAndPopulateNotMovedItemsTable(depositFromBagCache, depositToBagCache, newDepositStacksAllowed, toBeMovedItemsTable)
    PAB.stackInTargetBagAndPopulateNotMovedItemsTable(withdrawalFromBagCache, withdrawalToBagCache, newWithdrawalStacksAllowed, toBeMovedItemsTable)

    -- after initial run-through, go though all not yet moved items and look for free slots for them
    if #toBeMovedItemsTable > 0 then
        -- update the TransactionTimer option from the SavedVars
        PA.transactionInterval = PAMF.PABanking.getTransactionInvervalSetting()
        -- and trigger the recursive loop to move items
        PAB.moveSecureItemsFromTo(toBeMovedItemsTable, 1, toBeMovedAgainTable)
    else
        -- all stacking done; and no further items to be moved
        -- TODO: end message?
        PAHF.debugln("1) all done!")
        PAB.isBankTransferBlocked = false
        -- Execute the function queue
        PAB.triggerNextTransactionFunction()
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

local function triggerNextTransactionFunction()
    -- Execute the function queue
    if #PAB.transactionFunctionQueue > 0 then
        -- remove the last entry from the list, and store it
        local functionToCall = table.remove(PAB.transactionFunctionQueue)
        -- call that function and pass on the remaining list of transactionFunctions
        zo_callLater(function() functionToCall() end, _transactionInterval)
    end
end

local function _isNotStolenOrStolenAndAllowed(itemData, isStolenAllowed)
    local isStolen = IsItemStolen(itemData.bagId, itemData.slotIndex)
    return not isStolen or (isStolen and isStolenAllowed)
end

local function getCombinedItemTypeSpecializedComparator(itemTypeList, spevializedItemTypeList, includeStolenItems)
    return function(itemData)
        for _, itemType in pairs(itemTypeList) do
            if itemType == itemData.itemType and _isNotStolenOrStolenAndAllowed(itemData, includeStolenItems) then return true end
        end
        for _, specializedItemType in pairs(spevializedItemTypeList) do
            if specializedItemType == itemData.specializedItemType and _isNotStolenOrStolenAndAllowed(itemData, includeStolenItems) then return true end
        end
        return false
    end
end

-- TODO: move to Helper Functions!
local function getItemTypeComparator(itemTypeList, includeStolenItems)
    return function(itemData)
        for _, itemType in pairs(itemTypeList) do
            if itemType == itemData.itemType and _isNotStolenOrStolenAndAllowed(itemData, includeStolenItems) then return true end
        end
        return false
    end
end


local function getItemIdComparator(itemIdList, includeStolenItems)
    return function(itemData)
        for itemId, _ in pairs(itemIdList) do
            if itemId == GetItemId(itemData.bagId, itemData.slotIndex) and _isNotStolenOrStolenAndAllowed(itemData, includeStolenItems) then return true end
        end
        return false
    end
end

local function updateTransactionInterval()
    _transactionInterval = PAMF.PABanking.getTransactionInvervalSetting()
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.moveSecureItemsFromTo = moveSecureItemsFromTo
PA.Banking.stackInTargetBagAndPopulateNotMovedItemsTable = stackInTargetBagAndPopulateNotMovedItemsTable
PA.Banking.doGenericItemTransactions = doGenericItemTransactions
PA.Banking.triggerNextTransactionFunction = triggerNextTransactionFunction
PA.Banking.getCombinedItemTypeSpecializedComparator = getCombinedItemTypeSpecializedComparator
PA.Banking.getItemTypeComparator = getItemTypeComparator
PA.Banking.getItemIdComparator = getItemIdComparator
PA.Banking.updateTransactionInterval = updateTransactionInterval