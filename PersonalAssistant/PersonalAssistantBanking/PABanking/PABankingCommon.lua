-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PAC = PA.Constants
local PAMF = PA.MenuFunctions
local PAHF = PA.HelperFunctions
local PAEM = PA.EventManager

-- ---------------------------------------------------------------------------------------------------------------------

-- NOTE: Filling up existing stacks can be done immediately; creating new stacks takes time (i.e. zo_callLater needed)

local MOVE_SECURE_ITEMS_INTERVAL_MS = 50
local CALL_LATER_FUNCTION_NAME = "CallLaterFunction_moveSecureItemsFromTo"

-- ---------------------------------------------------------------------------------------------------------------------

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
-- If [toBeMovedAgainTable] is NOT nil, then not moved items will be added to that list and re-tried afterwards
-- If [toBeMovedAgainTable] is nil, then failed moves will NOT be re-tried
local function moveSecureItemsFromTo(toBeMovedItemsTable, startIndex, toBeMovedAgainTable)
    local fromBagItemData = toBeMovedItemsTable[startIndex]
    local targetBagId, firstEmptySlot = _findFirstEmptySlotAndTargetBagFromSourceBag(fromBagItemData.bagId)
    -- get the itemLink (must use this function as GetItemLink returns all lower-case item-names) and itemType
    local itemLink = PAHF.getFormattedItemLink(fromBagItemData.bagId, fromBagItemData.slotIndex)
    if targetBagId ~= nil and firstEmptySlot ~= nil then
        if not PA.isBankClosed then
            local sourceStack, _ = GetSlotStackSize(fromBagItemData.bagId, fromBagItemData.slotIndex)
            -- in case there was a custom amount to be moved defined; overwrite the stack size
            local customStackToMove = fromBagItemData.customStackToMove
            local customStackToMoveOriginal = fromBagItemData.customStackToMoveOriginal
            if customStackToMove ~= nil then sourceStack = customStackToMove end
            -- request the move of the item
            local moveStartGameTime = GetGameTimeMilliseconds()
            _requestMoveItem(fromBagItemData.bagId, fromBagItemData.slotIndex, targetBagId, firstEmptySlot, sourceStack)
            -- ---------------------------------------------------------------------------------------------------------
            -- Now "wait" until the item move has been complete/confirmed (or until bank is closed!)
            EVENT_MANAGER:RegisterForUpdate(CALL_LATER_FUNCTION_NAME, MOVE_SECURE_ITEMS_INTERVAL_MS,
                function()
                    -- check if the item has already "arrived" at its target bag/slot
                    local itemId = GetItemId(targetBagId, firstEmptySlot)
                    if itemId > 0 or PA.isBankClosed then
                        -- TODO: also check itemId for verification?
                        -- if item has arrived or bank window is closed stop the interval; in first case proceed with the next item
                        EVENT_MANAGER:UnregisterForUpdate(CALL_LATER_FUNCTION_NAME)
                        local moveFinishGameTime = GetGameTimeMilliseconds()
                        PAHF.debugln('Item transaction took approx. %d ms', moveFinishGameTime - moveStartGameTime)
                        -- check if the bank has been closed in the meanwhile
                        if PA.isBankClosed then
                            -- as per current observations, the transfer always finishes even if the bank has ben clsoed before verification
                            -- TODO: might need to be checked in more detail in future
                            -- if bank was closed, abort and dont continue
                            PAB.isBankTransferBlocked = false
                        else
                            -- item move has been verified
                            -- if there either was no original amount; or it is the same as the one to be moved, treat it as a complete move
                            if customStackToMoveOriginal == nil or customStackToMoveOriginal == customStackToMove then
                                PAB.println(SI_PA_CHAT_BANKING_ITEMS_MOVED_COMPLETE, sourceStack, itemLink, PAHF.getBagName(targetBagId))
                            else
                                PAB.println(SI_PA_CHAT_BANKING_ITEMS_MOVED_PARTIAL, sourceStack, customStackToMoveOriginal, itemLink, PAHF.getBagName(targetBagId))
                            end

                            local newStartIndex = startIndex + 1
                            if newStartIndex <= #toBeMovedItemsTable then
                                moveSecureItemsFromTo(toBeMovedItemsTable, newStartIndex, toBeMovedAgainTable)
                            else
                                -- loop completed; check if there are any items to be moved again (re-try)
                                if toBeMovedAgainTable ~= nil and #toBeMovedAgainTable > 0 then
                                    -- if there are items left, try again
                                    moveSecureItemsFromTo(toBeMovedAgainTable, 1, nil)
                                else
                                    -- nothing else that can be moved; done
                                    -- TODO: end message?
                                    PAHF.debugln("2) all done!")
                                    PAB.isBankTransferBlocked = false
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
            PAB.println(SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_BANKCLOSED, itemLink, PAHF.getBagName(BAG_BANK))
            PAB.isBankTransferBlocked = false
        end
    else
        -- cannot move item because there is not enough space; put it on separate list to try again afterwards
        if toBeMovedAgainTable ~= nil then
            table.insert(toBeMovedAgainTable, fromBagItemData)
            local newStartIndex = startIndex + 1
            if newStartIndex <= #toBeMovedItemsTable then
                moveSecureItemsFromTo(toBeMovedItemsTable, newStartIndex, toBeMovedAgainTable)
            else
                -- loop completed; try again with the items added to the re-try list
                moveSecureItemsFromTo(toBeMovedAgainTable, 1, nil)
            end
        else
            -- Abort; dont continue (even in 2nd run no transfer possible)
            PAB.println(SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_OUTOFSPACE, itemLink, PAHF.getBagName(BAG_BANK))
            PAB.isBankTransferBlocked = false
            -- Execute the function queue
            PAEM.executeNextFunctionInQueue(PAB.AddonName)
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

        local itemLink = GetItemLink(fromBagItemData.bagId, fromBagItemData.slotIndex, LINK_STYLE_BRACKETS)
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
                        PAB.println(SI_PA_CHAT_BANKING_ITEMS_MOVED_COMPLETE, moveableStack, itemLink, PAHF.getBagName(toBagItemData.bagId))
                        _requestMoveItem(fromBagItemData.bagId, fromBagItemData.slotIndex, toBagItemData.bagId, toBagItemData.slotIndex, moveableStack)
                        isItemMoved = true
                        hasNoStacksLeft = true
                        -- update the stackCount in the bagCache manually (since we don't want to completely re-generate it)
                        toBagCache[toBagCacheIndex].stackCount = targetStack + moveableStack
                    else
                        -- not enough space, only fill up stack possible
                        PAB.println(SI_PA_CHAT_BANKING_ITEMS_MOVED_PARTIAL, targetFreeStacks, moveableStack, itemLink, PAHF.getBagName(toBagItemData.bagId))
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
            if stackToMove and stackToMove > 0 then
                fromBagItemData.customStackToMove = stackToMove
                fromBagItemData.customStackToMoveOriginal = sourceStack
                PAHF.debugln("not moved: %d / %d x %s (need new stack)", stackToMove, sourceStack, itemLink)
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
        -- trigger the recursive loop to move items
        PAB.moveSecureItemsFromTo(toBeMovedItemsTable, 1, toBeMovedAgainTable)
    else
        -- all stacking done; and no further items to be moved
        -- TODO: end message?
        PAHF.debugln("1) all done!")
        PAB.isBankTransferBlocked = false
        -- Execute the function queue
        PAEM.executeNextFunctionInQueue(PAB.AddonName)
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.moveSecureItemsFromTo = moveSecureItemsFromTo
PA.Banking.stackInTargetBagAndPopulateNotMovedItemsTable = stackInTargetBagAndPopulateNotMovedItemsTable
PA.Banking.doGenericItemTransactions = doGenericItemTransactions