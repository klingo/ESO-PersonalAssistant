-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
local PAMF = PA.MenuFunctions
local PASV = PA.SavedVars

-- ---------------------------------------------------------------------------------------------------------------------

-- NOTE: Filling up existing stacks can be done immediately; creating new stacks takes time (i.e. zo_callLater needed)

-- ---------------------------------------------------------------------------------------------------------------------

local function _doItemTransactions(fromBagCacheDeposit, toBagCacheDeposit, fromBagCacheWithdrawal, toBagCacheWithdrawal)
    -- prepare the table for the items that need a new stack created
    local toBeMovedItemsTable = {}
    local toBeMovedAgainTable = {}

    -- update the StacksAllowed options from the SavedVars
    local newDepositStacksAllowed = (PAMF.PABanking.getTransactionDepositStackingSetting() == PAC.STACKING.FULL)
    local newWithdrawalStacksAllowed = (PAMF.PABanking.getTransactionWithdrawalStackingSetting() == PAC.STACKING.FULL)

    -- automatically fills up existing stacks; and if new stacks are needed (and allowed), these are added to the table
    PAB.stackInTargetBagAndPopulateNotMovedItemsTable(fromBagCacheDeposit, toBagCacheDeposit, newDepositStacksAllowed, toBeMovedItemsTable)
    PAB.stackInTargetBagAndPopulateNotMovedItemsTable(fromBagCacheWithdrawal, toBagCacheWithdrawal, newWithdrawalStacksAllowed, toBeMovedItemsTable)

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

local function depositOrWithdrawCraftingItems()

    PAHF.debugln("PA.Banking.depositOrWithdrawCraftingItems")

    -- check if bankTransfer is already blocked
    if PAB.isBankTransferBlocked then return end
    PAB.isBankTransferBlocked = true

    -- prepare the table with itemTypes to deposit and withdraw
    local depositItemTypes = setmetatable({}, { __index = table })
    local withdrawItemTypes = setmetatable({}, { __index = table })

    -- fill up the table
    for itemType, moveMode in pairs(PASV.Banking[PA.activeProfile].Crafting.ItemTypesCrafting) do
        if (moveMode == PAC.MOVE.DEPOSIT) then
            depositItemTypes:insert(itemType)
        elseif (moveMode == PAC.MOVE.WITHDRAW) then
            withdrawItemTypes:insert(itemType)
        end
    end

    local depositComparator = PAB.getItemTypeComparator(depositItemTypes)
    local withdrawComparator = PAB.getItemTypeComparator(withdrawItemTypes)

    local toDepositBagCache = SHARED_INVENTORY:GenerateFullSlotData(depositComparator, BAG_BACKPACK)
    local toFillUpDepositBagCache = SHARED_INVENTORY:GenerateFullSlotData(depositComparator, BAG_BANK, BAG_SUBSCRIBER_BANK)

    local toWithdrawBagCache = SHARED_INVENTORY:GenerateFullSlotData(withdrawComparator, BAG_BANK, BAG_SUBSCRIBER_BANK)
    local toFillUpWithdrawBagCache = SHARED_INVENTORY:GenerateFullSlotData(withdrawComparator, BAG_BACKPACK)

    -- update the TransactionTimer option from the SavedVars; and trigger the itemTransactions
    PAB.updateTransactionInterval()
    _doItemTransactions(toDepositBagCache, toFillUpDepositBagCache, toWithdrawBagCache, toFillUpWithdrawBagCache)
end


-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.depositOrWithdrawCraftingItems = depositOrWithdrawCraftingItems