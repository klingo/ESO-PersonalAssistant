-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PAC = PA.Constants
local PASV = PA.SavedVars
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local function _doItemTransactions(depositFromBagCache, depositToBagCache, withdrawalFromBagCache, withdrawalToBagCache)
    -- call the generic version
    PAB.doGenericItemTransactions(depositFromBagCache, depositToBagCache, withdrawalFromBagCache, withdrawalToBagCache)
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
    for itemType, moveConfig in pairs(PASV.Banking[PA.activeProfile].Advanced.ItemTypes) do
        if PASV.Banking[PA.activeProfile].Advanced.TransactionSettings[moveConfig.enabledSetting] then
            if (moveConfig.moveMode == PAC.MOVE.DEPOSIT) then
                depositItemTypes:insert(itemType)
            elseif (moveConfig.moveMode == PAC.MOVE.WITHDRAW) then
                withdrawItemTypes:insert(itemType)
            end
        end
    end
    for specializedItemType, moveConfig in pairs(PASV.Banking[PA.activeProfile].Advanced.SpecializedItemTypes) do
        if PASV.Banking[PA.activeProfile].Advanced.TransactionSettings[moveConfig.enabledSetting] then
            if (moveConfig.moveMode == PAC.MOVE.DEPOSIT) then
                depositSpecializedItemTypes:insert(specializedItemType)
            elseif (moveConfig.moveMode == PAC.MOVE.WITHDRAW) then
                withdrawSpezializedItemTypes:insert(specializedItemType)
            end
        end
    end

    local depositComparator = PAHF.getCombinedItemTypeSpecializedComparator(depositItemTypes, depositSpecializedItemTypes)
    local withdrawComparator = PAHF.getCombinedItemTypeSpecializedComparator(withdrawItemTypes, withdrawSpezializedItemTypes)

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
PA.Banking.depositOrWithdrawAdvancedItems = depositOrWithdrawAdvancedItems