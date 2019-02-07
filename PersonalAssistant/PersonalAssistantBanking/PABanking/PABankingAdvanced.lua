-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PAC = PA.Constants
local PASV = PA.SavedVars
local PAHF = PA.HelperFunctions
local PAMF = PA.MenuFunctions

-- ---------------------------------------------------------------------------------------------------------------------




-- TODO: exact duplicate with PABankingCrafting (simplify?
local function _doItemTransactions(fromBagCacheDeposit, toBagCacheDeposit, fromBagCacheWithdrawal, toBagCacheWithdrawal)
    -- prepare the table for the items that need a new stack created
    local toBeMovedItemsTable = {}
    local toBeMovedAgainTable = {}

    -- update the StacksAllowed options from the SavedVars
    -- TODO: Challenge this, as it does not make sense for Glyphs and Treasure Maps
    local newDepositStacksAllowed = (PAMF.PABanking.getTransactionDepositStackingSetting() == PAC.STACKING.FULL)
    local newWithdrawalStacksAllowed = (PAMF.PABanking.getTransactionWithdrawalStackingSetting() == PAC.STACKING.FULL)

    -- automatically fills up existing stacks; and if new stacks are needed (and allowed), these are added to the table
    PAB.stackInTargetBagAndPopulateNotMovedItemsTable(fromBagCacheDeposit, toBagCacheDeposit, newDepositStacksAllowed, toBeMovedItemsTable)
    PAB.stackInTargetBagAndPopulateNotMovedItemsTable(fromBagCacheWithdrawal, toBagCacheWithdrawal, newWithdrawalStacksAllowed, toBeMovedItemsTable)



    -- TODO: DO STUFF HERE

    -- after initial run-through, go though all not yet moved items and look for free slots for them
    if #toBeMovedItemsTable > 0 then
        -- update the TransactionTimer option from the SavedVars
        PA.transactionInterval = PAMF.PABanking.getTransactionInvervalSetting()
        -- and trigger the recursive loop to move items
        PAB.moveSecureItemsFromTo(toBeMovedItemsTable, 1, toBeMovedAgainTable)
    else
        -- all stacking done; and no further items to be moved
        -- TODO: end message?
        d("1) all done!")
        PAB.isBankTransferBlocked = false
        -- Execute the function queue
        PAB.triggerNextTransactionFunction()
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

local function depositOrWithdrawAdvancedItems()

    PAHF.debugln("PA.Banking.depositOrWithdrawAdvancedItems")

    -- check if bankTransfer is already blocked
    if PAB.isBankTransferBlocked then return end
    PAB.isBankTransferBlocked = true

    -- prepare the table with itemTypes to deposit and withdraw
    local depositItemTypes = setmetatable({}, { __index = table })
    local depositSpecializedItemTypes = setmetatable({}, { __index = table })
    local withdrawItemTypes = setmetatable({}, { __index = table })
    local withdrawSpezializedItemTypes = setmetatable({}, { __index = table })

    -- fill up the table(s)
    for itemType, moveMode in pairs(PASV.Banking[PA.activeProfile].Advanced.ItemTypesAdvanced) do
        if (moveMode == PAC.MOVE.DEPOSIT) then
            depositItemTypes:insert(itemType)
        elseif (moveMode == PAC.MOVE.WITHDRAW) then
            withdrawItemTypes:insert(itemType)
        end
    end
    for specializedItemType, moveMode in pairs(PASV.Banking[PA.activeProfile].Advanced.ItemTypesSpecializedAdvanced) do
        if (moveMode == PAC.MOVE.DEPOSIT) then
            depositSpecializedItemTypes:insert(specializedItemType)
        elseif (moveMode == PAC.MOVE.WITHDRAW) then
            withdrawSpezializedItemTypes:insert(specializedItemType)
        end
    end

    local depositComparator = PAB.getCombinedItemTypeSpecializedComparator(depositItemTypes, depositSpecializedItemTypes)
    local withdrawComparator = PAB.getCombinedItemTypeSpecializedComparator(withdrawItemTypes, withdrawSpezializedItemTypes)

    local toDepositBagCache = SHARED_INVENTORY:GenerateFullSlotData(depositComparator, BAG_BACKPACK)
    local toFillUpDepositBagCache = SHARED_INVENTORY:GenerateFullSlotData(depositComparator, BAG_BANK, BAG_SUBSCRIBER_BANK)

    local toWithdrawBagCache = SHARED_INVENTORY:GenerateFullSlotData(withdrawComparator, BAG_BANK, BAG_SUBSCRIBER_BANK)
    local toFillUpWithdrawBagCache = SHARED_INVENTORY:GenerateFullSlotData(withdrawComparator, BAG_BACKPACK)


    d("#toDepositBagCache = "..tostring(#toDepositBagCache))
    d("#toWithdrawBagCache = "..tostring(#toWithdrawBagCache))

    -- update the TransactionTimer option from the SavedVars; and trigger the itemTransactions
    PAB.updateTransactionInterval()
    _doItemTransactions(toDepositBagCache, toFillUpDepositBagCache, toWithdrawBagCache, toFillUpWithdrawBagCache)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.depositOrWithdrawAdvancedItems = depositOrWithdrawAdvancedItems