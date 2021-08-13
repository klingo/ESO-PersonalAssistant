-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PAC = PA.Constants
local PAMF = PA.MenuFunctions
local PAHF = PA.HelperFunctions
local PAEM = PA.EventManager

-- ---------------------------------------------------------------------------------------------------------------------

-- NOTE: Filling up existing stacks can be done immediately; creating new stacks takes time (i.e. delay required)

local MOVE_SECURE_ITEMS_INTERVAL_MS = 50
local CALL_LATER_FUNCTION_NAME = "CallLaterFunction_moveSecureItemsFromTo"

-- ---------------------------------------------------------------------------------------------------------------------

local function _getUniqueUpdateIdentifier(bagId, slotIndex)
    return table.concat({CALL_LATER_FUNCTION_NAME, tostring(bagId), tostring(slotIndex)})
end

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
        if targetSlotIndex == nil and IsESOPlusSubscriber() then
            targetBagId = BAG_SUBSCRIBER_BANK
            targetSlotIndex = FindFirstEmptySlotInBag(targetBagId)
        end
    elseif sourceBagId == BAG_BANK or (sourceBagId == BAG_SUBSCRIBER_BANK and IsESOPlusSubscriber()) then
        targetBagId = BAG_BACKPACK
        targetSlotIndex = FindFirstEmptySlotInBag(targetBagId)
    end

    -- check if both values could be defined
    if targetBagId ~= nil and targetSlotIndex ~= nil then
        -- yes; valid empty sloud found; return information
        return targetBagId, targetSlotIndex
    end
    -- no; not enough space or bag not found; return nil, nil
    return targetBagId, nil
end


-- Recursive function that tries to find new slots in the corresponding targetBags from the given list of itemDatas
-- The startIndex indicates from which item in the list the check for moving should be started
-- If [toBeMovedAgainTable] is NOT nil, then not moved items will be added to that list and re-tried afterwards
-- If [toBeMovedAgainTable] is nil, then failed moves will NOT be re-tried
local function _moveSecureItemsFromTo(toBeMovedItemsTable, startIndex, toBeMovedAgainTable)
    local fromBagItemData = toBeMovedItemsTable[startIndex]
    local targetBagId, firstEmptySlot = _findFirstEmptySlotAndTargetBagFromSourceBag(fromBagItemData.bagId)
    -- get the itemLink (must use this function as GetItemLink returns all lower-case item-names) and itemType
    local itemLink = PAHF.getFormattedItemLink(fromBagItemData.bagId, fromBagItemData.slotIndex)
    if targetBagId ~= nil and firstEmptySlot ~= nil then
        if not PA.WindowStates.isBankClosed then
            local sourceStack, _ = GetSlotStackSize(fromBagItemData.bagId, fromBagItemData.slotIndex)
            -- in case there was a custom amount to be moved defined; overwrite the stack size
            local customStackToMove = fromBagItemData.customStackToMove
            local customStackToMoveOriginal = fromBagItemData.customStackToMoveOriginal
            if customStackToMove ~= nil then sourceStack = customStackToMove end
            -- request the move of the item
            local moveStartGameTime = GetGameTimeMilliseconds()
            PAB.debugln("request to move %d x %s into new stack", sourceStack, itemLink)
            _requestMoveItem(fromBagItemData.bagId, fromBagItemData.slotIndex, targetBagId, firstEmptySlot, sourceStack)
            -- ---------------------------------------------------------------------------------------------------------
            -- Now "wait" until the item move has been complete/confirmed (or until bank is closed!)
            local identifier = _getUniqueUpdateIdentifier(fromBagItemData.bagId, fromBagItemData.slotIndex)
            EVENT_MANAGER:RegisterForUpdate(identifier, MOVE_SECURE_ITEMS_INTERVAL_MS,
                function()
                    -- check if the item has already "arrived" at its target bag/slot
                    local itemId = GetItemId(targetBagId, firstEmptySlot)
                    if itemId > 0 or PA.WindowStates.isBankClosed then
                        -- TODO: also check itemId for verification?
                        -- if item has arrived or bank window is closed stop the interval; in first case proceed with the next item
                        EVENT_MANAGER:UnregisterForUpdate(identifier)
                        local moveFinishGameTime = GetGameTimeMilliseconds()
                        PAB.debugln('Item transaction took approx. %d ms', moveFinishGameTime - moveStartGameTime)
                        -- check if the bank has been closed in the meanwhile
                        if PA.WindowStates.isBankClosed then
                            -- as per current observations, the transfer always finishes even if the bank has ben clsoed before verification
                            -- TODO: might need to be checked in more detail in future
                            -- if bank was closed, abort and dont continue
                        else
                            -- item move has been verified
                            local itemLinkExt = PAHF.getIconExtendedItemLink(itemLink)
                            PAB.println(SI_PA_CHAT_BANKING_ITEMS_MOVED_COMPLETE, sourceStack, itemLinkExt, PAHF.getBagName(targetBagId))

                            local newStartIndex = startIndex + 1
                            if newStartIndex <= #toBeMovedItemsTable then
                                _moveSecureItemsFromTo(toBeMovedItemsTable, newStartIndex, toBeMovedAgainTable)
                            else
                                -- loop completed; check if there are any items to be moved again (re-try)
                                if toBeMovedAgainTable ~= nil and #toBeMovedAgainTable > 0 then
                                    -- if there are items left, try again
                                    _moveSecureItemsFromTo(toBeMovedAgainTable, 1, nil)
                                else
                                    -- nothing else that can be moved; done
                                    -- TODO: end message?
                                    PAB.debugln("2) all done!")
                                    -- Execute the function queue
                                    PAEM.executeNextFunctionInQueue(PAB.AddonName)
                                end
                            end
                        end
                    end
                end)
            -- ---------------------------------------------------------------------------------------------------------
        else
            -- abort; dont continue
            PAB.println(SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_BANKCLOSED, itemLink, PAHF.getBagName(targetBagId))
        end
    else
        -- cannot move item because there is not enough space; put it on separate list to try again afterwards
        if toBeMovedAgainTable ~= nil then
            table.insert(toBeMovedAgainTable, fromBagItemData)
            local newStartIndex = startIndex + 1
            if newStartIndex <= #toBeMovedItemsTable then
                _moveSecureItemsFromTo(toBeMovedItemsTable, newStartIndex, toBeMovedAgainTable)
            else
                -- loop completed; try again with the items added to the re-try list
                _moveSecureItemsFromTo(toBeMovedAgainTable, 1, nil)
            end
        else
            -- Abort; dont continue (even in 2nd run no transfer possible)
            PAB.println(SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_OUTOFSPACE, itemLink, PAHF.getBagName(targetBagId))
            -- Execute the function queue
            PAEM.executeNextFunctionInQueue(PAB.AddonName)
        end
    end
end

local function _isSameItem(itemDataA, itemDataB)
    if itemDataA.itemInstanceId == itemDataB.itemInstanceId then
--        local itemLinkA = GetItemLink(itemDataA.bagId, itemDataA.slotIndex)
--        local itemLinkB = GetItemLink(itemDataB.bagId, itemDataB.slotIndex)
--        local boundStateItemA = select(21, ZO_LinkHandler_ParseLink(itemLinkA))
--        local boundStateItemB = select(21, ZO_LinkHandler_ParseLink(itemLinkB))
        local fromCrownStoreItemA = IsItemFromCrownStore(itemDataA.bagId, itemDataA.slotIndex)
        local fromCrownStoreItemB = IsItemFromCrownStore(itemDataB.bagId, itemDataB.slotIndex)
--        return boundStateItemA == boundStateItemB and fromCrownStoreItemA == fromCrownStoreItemB
        return fromCrownStoreItemA == fromCrownStoreItemB
    end
    return false
end

-- Immediately moves items from source to target bag, if the same item exists in both locations (i.e. filling up existing
-- stacks). All items that either cannot be moved because there is no matching item in the target bag, or because the
-- existing stacks have already been filled up; these will be added to the [notMovedItemsTable] table. Provided that
-- [newStacksAllowed] is set to true; otherwise the table will be returned unchanged
local function _stackInTargetBagAndPopulateNotMovedItemsTable(fromBagCache, toBagCache, newStacksAllowed, notMovedItemsTable, overruleStackToMove)
    for _, fromBagItemData in pairs(fromBagCache) do
        local isItemMoved = false
        local hasNoStacksLeft = false
        local skipItem = false

        local itemLink = GetItemLink(fromBagItemData.bagId, fromBagItemData.slotIndex, LINK_STYLE_BRACKETS)
        local sourceStack, sourceStackMaxSize = GetSlotStackSize(fromBagItemData.bagId, fromBagItemData.slotIndex)
        local stackToMove = overruleStackToMove or sourceStack
        PAB.debugln("try to move %d x %s from %s away", stackToMove, itemLink, PAHF.getBagName(fromBagItemData.bagId))

        for toBagCacheIndex, toBagItemData in pairs(toBagCache) do
            if _isSameItem(fromBagItemData, toBagItemData) then
                -- same itemInstanceId and same CrownStore source information
                local _, targetMaxStack = GetSlotStackSize(toBagItemData.bagId, toBagItemData.slotIndex)
                local targetStack = toBagItemData.stackCount -- cannot use [GetSlotStackSize] becuase it does not reflect changes after the bagCache is created
                local targetFreeStacks = targetMaxStack - targetStack
                if IsItemLinkUnique(itemLink) then
                    -- match was found, but since it is unique prevent any further move-attempts by skipping it
                    PAB.debugln("%s is uniqe and cannot be stacked - skip it!", itemLink)
                    skipItem = true
                    break
                elseif targetFreeStacks > 0 then
                    -- match was found, and item is not unique, check if there are free stacks
                    local moveableStack = stackToMove
                    local itemLinkExt = PAHF.getIconExtendedItemLink(itemLink)
                    if moveableStack <= targetFreeStacks then
                        -- enough space to move all
                        PAB.println(SI_PA_CHAT_BANKING_ITEMS_MOVED_COMPLETE, moveableStack, itemLinkExt, PAHF.getBagName(toBagItemData.bagId))
                        _requestMoveItem(fromBagItemData.bagId, fromBagItemData.slotIndex, toBagItemData.bagId, toBagItemData.slotIndex, moveableStack)
                        isItemMoved = true
                        hasNoStacksLeft = true
                        -- update the stackCount in the bagCache manually (since we don't want to completely re-generate it)
                        toBagCache[toBagCacheIndex].stackCount = targetStack + moveableStack
                    else
                        -- not enough space, only fill up stack possible
                        PAB.println(SI_PA_CHAT_BANKING_ITEMS_MOVED_COMPLETE, targetFreeStacks, itemLinkExt, PAHF.getBagName(toBagItemData.bagId))
                        _requestMoveItem(fromBagItemData.bagId, fromBagItemData.slotIndex, toBagItemData.bagId, toBagItemData.slotIndex, targetFreeStacks)
                        -- cannot be set to [isItemMoved = true] because there is still a remaining stack that needs to be moved
                        -- reduce the remaining amount that needs to be moved
                        stackToMove = stackToMove - targetFreeStacks
                        -- update the stackCount in the bagCache manually (since we don't want to completely re-generate it)
                        toBagCache[toBagCacheIndex].stackCount = targetStack + targetFreeStacks
                    end
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
                    if _isSameItem(prevBagItemData, fromBagItemData) and prevBagItemData.customStackToMove < sourceStackMaxSize then
                        local prevSourceFreeStack = sourceStackMaxSize - prevBagItemData.customStackToMove
                        if prevSourceFreeStack >= stackToMove and fromBagItemData.stackCount >= stackToMove then
                            -- stack everything
                            notMovedItemsTable[index].customStackToMove = notMovedItemsTable[index].customStackToMove + stackToMove
                            notMovedItemsTable[index].customStackToMoveOriginal = nil -- in case of internal stacking, reset the original amount
                            PAB.debugln("try to fully stack %d x %s", stackToMove, itemLink)
                            _requestMoveItem(fromBagItemData.bagId, fromBagItemData.slotIndex, prevBagItemData.bagId, prevBagItemData.slotIndex, stackToMove)
                            -- nothing left to be moved
                            stackToMove = 0
                            break
                        else
                            -- stack only partial
                            notMovedItemsTable[index].customStackToMove = notMovedItemsTable[index].customStackToMove + prevSourceFreeStack
                            notMovedItemsTable[index].customStackToMoveOriginal = nil -- in case of internal stacking, reset the original amount
                            PAB.debugln("try to partially stack %d x %s", prevSourceFreeStack, itemLink)
                            _requestMoveItem(fromBagItemData.bagId, fromBagItemData.slotIndex, prevBagItemData.bagId, prevBagItemData.slotIndex, prevSourceFreeStack)
                            -- partial left to be moved
                            stackToMove = stackToMove - prevSourceFreeStack
                        end
                    end
                end
            end

            -- if there is something left to be moved; add it to the list
            if stackToMove and stackToMove > 0 then
                fromBagItemData.customStackToMove = stackToMove
                fromBagItemData.customStackToMoveOriginal = sourceStack
                PAB.debugln("not moved: %d / %d x %s (need new stack)", stackToMove, sourceStack, itemLink)
                table.insert(notMovedItemsTable, fromBagItemData)
            end
        end
    end
end

local function _getBagCacheBasedOnItemOperator(backpackBagCache, bankBagCache, operator)
    if operator >= PAC.OPERATOR.BANK_EQUAL then
        -- operator 6 - 10 => rule set for the bank
        return bankBagCache, backpackBagCache
    else
        -- operator 1 - 5 => rule set for the backpack
        -- operator 0 => can be ignored since it must have been filtered out before!
        return backpackBagCache, bankBagCache
    end
end

local function _isOperatorSetoToEqualOrLess(operator)
    if operator == PAC.OPERATOR.BACKPACK_EQUAL then return true end
    if operator == PAC.OPERATOR.BACKPACK_LESSTHAN then return true end
    if operator == PAC.OPERATOR.BACKPACK_LESSTHANOREQUAL then return true end
    if operator == PAC.OPERATOR.BANK_EQUAL then return true end
    if operator == PAC.OPERATOR.BANK_LESSTHAN then return true end
    if operator == PAC.OPERATOR.BANK_LESSTHANOREQUAL then return true end
    return false
end

local function _isOperatorSetToEqualOrGreater(operator)
    if operator == PAC.OPERATOR.BACKPACK_EQUAL then return true end
    if operator == PAC.OPERATOR.BACKPACK_GREATERTHAN then return true end
    if operator == PAC.OPERATOR.BACKPACK_GREATERTHANOREQUAL then return true end
    if operator == PAC.OPERATOR.BANK_EQUAL then return true end
    if operator == PAC.OPERATOR.BANK_GREATERTHAN then return true end
    if operator == PAC.OPERATOR.BANK_GREATERTHANOREQUAL then return true end
    return false
end

-- ---------------------------------------------------------------------------------------------------------------------

local function doIndividualItemTransactions(individualItems, backpackBagCache, bankBagCache, isCustomPAItemIdList)
    -- prepare the table for the items that need a new stack created
    local toBeMovedItemsTable = {}
    local toBeMovedAgainTable = {}

    -- loop through all enabled individual Items
    for itemId, customItemData in pairs(individualItems) do
        local operator = customItemData.operator
        local targetBagStack = customItemData.targetBagStack
        local savedBagStack = 0

        -- depending on the operator (rule set for bank, or rule set for backpack), the configured and other bagcache might need to be switched
        local configuredBagCache, otherBagCache = _getBagCacheBasedOnItemOperator(backpackBagCache, bankBagCache, operator)

        -- and check for deposits (in reverse order, to start with incomplete stacks)
        --        for _, itemData in pairs(backpackBagCache) do
        for index = #configuredBagCache, 1, -1 do
            local itemData = configuredBagCache[index]
            local backpackItemId
            if isCustomPAItemIdList then
                backpackItemId = PAHF.getPAItemIdentifier(itemData.bagId, itemData.slotIndex)
            else
                backpackItemId = GetItemId(itemData.bagId, itemData.slotIndex)
            end
            if itemId == backpackItemId then
                local stack, _ = GetSlotStackSize(itemData.bagId, itemData.slotIndex)
                -- check if the limit is below what is currently in the backpack to see if deposit is needed
                if (_isOperatorSetoToEqualOrLess(operator)) and ((savedBagStack + stack) > targetBagStack) then
                    -- Deposit (full or partial)
                    local moveableStack = savedBagStack + stack - targetBagStack
                    savedBagStack = targetBagStack
                    local singleItemBagCache = {}
                    table.insert(singleItemBagCache, itemData)
                    PAB.debugln("Only deposit: "..tostring(moveableStack))
                    _stackInTargetBagAndPopulateNotMovedItemsTable(singleItemBagCache, otherBagCache, true, toBeMovedItemsTable, moveableStack)
                else
                    -- No deposit needed (yet)
                    savedBagStack = savedBagStack + stack
                end
            end
        end

        -- and withdrawals (in reverse order, to start with incomplete stacks)
        --        for _, itemData in pairs(bankBagCache) do
        for index = #otherBagCache, 1, -1 do
            local itemData = otherBagCache[index]
            local bankItemId
            if isCustomPAItemIdList then
                bankItemId = PAHF.getPAItemIdentifier(itemData.bagId, itemData.slotIndex)
            else
                bankItemId = GetItemId(itemData.bagId, itemData.slotIndex)
            end
            if itemId == bankItemId then
                local stack, _ = GetSlotStackSize(itemData.bagId, itemData.slotIndex)
                -- check if the limit is above what is currently in the backpack to see if withdrawal is needed
                if (_isOperatorSetToEqualOrGreater(operator)) and (savedBagStack < targetBagStack) then
                    -- Withdrawal (full or partial)
                    local moveableStack = targetBagStack - savedBagStack
                    if moveableStack > stack then
                        moveableStack = stack
                    end
                    savedBagStack = savedBagStack + moveableStack
                    local singleItemBagCache = {}
                    table.insert(singleItemBagCache, itemData)
                    PAB.debugln("Only withdraw: "..tostring(moveableStack))
                    _stackInTargetBagAndPopulateNotMovedItemsTable(singleItemBagCache, configuredBagCache, true, toBeMovedItemsTable, moveableStack)
                else
                    -- No withdrawal needed (anymore)
                end
            end
        end
    end

    -- after initial run-through, go though all not yet moved items and look for free slots for them
    if #toBeMovedItemsTable > 0 then
        _moveSecureItemsFromTo(toBeMovedItemsTable, 1, toBeMovedAgainTable)
    else
        -- all stacking done; and no further items to be moved
        -- TODO: end message?
        PAB.debugln("1) all done!")
        -- Execute the function queue
        PAEM.executeNextFunctionInQueue(PAB.AddonName)
    end
end

local function doGenericItemTransactions(depositFromBagCache, depositToBagCache, withdrawalFromBagCache, withdrawalToBagCache)
    -- prepare the table for the items that need a new stack created
    local toBeMovedItemsTable = {}
    local toBeMovedAgainTable = {}

    PAB.debugln("#toDepositBagCache = %d", #depositFromBagCache)
    PAB.debugln("#toWithdrawBagCache = %d", #withdrawalFromBagCache)

    -- update the StacksAllowed options from the SavedVars
    -- OPTIMIZE: Challenge this, as it does not make sense for Glyphs and Treasure Maps
    local newDepositStacksAllowed = (PAMF.PABanking.getTransactionDepositStackingSetting() == PAC.STACKING.FULL)
    local newWithdrawalStacksAllowed = (PAMF.PABanking.getTransactionWithdrawalStackingSetting() == PAC.STACKING.FULL)

    -- automatically fills up existing stacks; and if new stacks are needed (and allowed), these are added to the table
    _stackInTargetBagAndPopulateNotMovedItemsTable(depositFromBagCache, depositToBagCache, newDepositStacksAllowed, toBeMovedItemsTable)
    _stackInTargetBagAndPopulateNotMovedItemsTable(withdrawalFromBagCache, withdrawalToBagCache, newWithdrawalStacksAllowed, toBeMovedItemsTable)

    -- after initial run-through, go though all not yet moved items and look for free slots for them
    if #toBeMovedItemsTable > 0 then
        -- trigger the recursive loop to move items
        _moveSecureItemsFromTo(toBeMovedItemsTable, 1, toBeMovedAgainTable)
    else
        -- all stacking done; and no further items to be moved
        -- TODO: end message?
        PAB.debugln("1) all done!")
        -- Execute the function queue
        PAEM.executeNextFunctionInQueue(PAB.AddonName)
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.doIndividualItemTransactions = doIndividualItemTransactions
PA.Banking.doGenericItemTransactions = doGenericItemTransactions