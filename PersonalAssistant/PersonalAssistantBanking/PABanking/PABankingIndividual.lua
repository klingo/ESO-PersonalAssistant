-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PAC = PA.Constants
local PASV = PA.SavedVars
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local function _doItemTransactions(individualItems, backpackBagCache, bankBagCache)
    -- prepare the table for the items that need a new stack created
    local toBeMovedItemsTable = {}
    local toBeMovedAgainTable = {}

    -- loop through all enabled individual Items
    for itemId, customItemData in pairs(individualItems) do
        local operator = customItemData.operator
        local targetBackpackStack = customItemData.targetBackpackStack
        local savedBackpackStack = 0

        -- and check for deposits
        for _, itemData in pairs(backpackBagCache) do
            local backpackItemId = GetItemId(itemData.bagId, itemData.slotIndex)
            if (itemId == backpackItemId) then
                local stack, _ = GetSlotStackSize(itemData.bagId, itemData.slotIndex)
                if ((operator == PAC.OPERATOR.LESSTHANOREQUAL or operator == PAC.OPERATOR.EQUAL) and ((savedBackpackStack + stack) > targetBackpackStack)) then
                    -- Deposit (full or partial)
                    local moveableStack = savedBackpackStack + stack - targetBackpackStack
                    savedBackpackStack = targetBackpackStack
                    local singleItemBagCache = {}
                    table.insert(singleItemBagCache, itemData)
                    PAHF.debugln("Only deposit: "..tostring(moveableStack))
                    PAB.stackInTargetBagAndPopulateNotMovedItemsTable(singleItemBagCache, bankBagCache, true, toBeMovedItemsTable, moveableStack)
                else
                    -- No deposit needed (yet)
                    savedBackpackStack = savedBackpackStack + stack
                end
            end
        end

        -- and withdrawals
        for _, itemData in pairs(bankBagCache) do
            local bankItemId = GetItemId(itemData.bagId, itemData.slotIndex)
            if (itemId == bankItemId) then
                local stack, _ = GetSlotStackSize(itemData.bagId, itemData.slotIndex)
                if (operator == PAC.OPERATOR.GREATERTHANOREQUAL or operator == PAC.OPERATOR.EQUAL) then
                    if (savedBackpackStack < targetBackpackStack) then
                        -- Withdrawal (full or partial)
                        local moveableStack = targetBackpackStack - savedBackpackStack
                        if (moveableStack > stack) then
                            moveableStack = stack
                        end
                        savedBackpackStack = savedBackpackStack + moveableStack
                        local singleItemBagCache = {}
                        table.insert(singleItemBagCache, itemData)
                        PAHF.debugln("Only withdraw: "..tostring(moveableStack))
                        PAB.stackInTargetBagAndPopulateNotMovedItemsTable(singleItemBagCache, backpackBagCache, true, toBeMovedItemsTable, moveableStack)
                    else
                        -- No withdrawal needed (anymore)
                    end
                end
            end
        end
    end

    -- after initial run-through, go though all not yet moved items and look for free slots for them
    if #toBeMovedItemsTable > 0 then
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

local function depositOrWithdrawIndividualItems()

    PAHF.debugln("PA.Banking.depositOrWithdrawIndividualItems")

    -- check if bankTransfer is already blocked
    if PAB.isBankTransferBlocked then return end
    PAB.isBankTransferBlocked = true

    -- preapre and fill the table with all individual items that needs to be transferred
    local individualItems = {}
    local itemIdBackpackAmountTable = PASV.Banking[PA.activeProfile].Individual.ItemIdBackpackAmount
    local itemIdOperatorTable = PASV.Banking[PA.activeProfile].Individual.ItemIdOperator
    for itemId, targetBackpackStack in pairs(itemIdBackpackAmountTable) do
        local operator = itemIdOperatorTable[itemId]
        if operator ~= PAC.OPERATOR.NONE then
            individualItems[itemId] = {
                operator = operator,
                targetBackpackStack = targetBackpackStack
            }
        end
    end

    -- then get the matching data from the backpack and bank
    local itemIdComparator = PAB.getItemIdComparator(individualItems)
    local backpackBagCache = SHARED_INVENTORY:GenerateFullSlotData(itemIdComparator, BAG_BACKPACK)
    local bankBagCache = SHARED_INVENTORY:GenerateFullSlotData(itemIdComparator, BAG_BANK, BAG_SUBSCRIBER_BANK)

    -- update the TransactionTimer option from the SavedVars; and trigger the itemTransactions
    PAB.updateTransactionInterval()
    _doItemTransactions(individualItems, backpackBagCache, bankBagCache)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.depositOrWithdrawIndividualItems = depositOrWithdrawIndividualItems