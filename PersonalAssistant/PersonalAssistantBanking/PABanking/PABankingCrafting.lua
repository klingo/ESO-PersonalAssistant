-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PAC = PA.Constants
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local function _doItemTransactions(depositFromBagCache, depositToBagCache, withdrawalFromBagCache, withdrawalToBagCache)
    -- call the generic version
    PAB.doGenericItemTransactions(depositFromBagCache, depositToBagCache, withdrawalFromBagCache, withdrawalToBagCache)
end

-- ---------------------------------------------------------------------------------------------------------------------

local function depositOrWithdrawCraftingItems()

    PAHF.debugln("PA.Banking.depositOrWithdrawCraftingItems")

    if PAB.SavedVars.Crafting.craftingItemsEnabled and not IsESOPlusSubscriber() then
        -- check if bankTransfer is already blocked
        if PAB.isBankTransferBlocked then return end
        PAB.isBankTransferBlocked = true

        -- prepare the table with itemTypes to deposit and withdraw
        local depositItemTypes = setmetatable({}, { __index = table })
        local withdrawItemTypes = setmetatable({}, { __index = table })

        -- fill up the table
        for itemType, moveConfig in pairs(PAB.SavedVars.Crafting.ItemTypes) do
            if PAB.SavedVars.Crafting.TransactionSettings[moveConfig.enabledSetting] then
                if moveConfig.moveMode == PAC.MOVE.DEPOSIT then
                    depositItemTypes:insert(itemType)
                elseif moveConfig.moveMode == PAC.MOVE.WITHDRAW then
                    withdrawItemTypes:insert(itemType)
                end
            end
        end

        local depositComparator = PAHF.getItemTypeComparator(depositItemTypes)
        local withdrawComparator = PAHF.getItemTypeComparator(withdrawItemTypes)

        local toDepositBagCache = SHARED_INVENTORY:GenerateFullSlotData(depositComparator, BAG_BACKPACK)
        local toFillUpDepositBagCache = SHARED_INVENTORY:GenerateFullSlotData(depositComparator, BAG_BANK, BAG_SUBSCRIBER_BANK)

        local toWithdrawBagCache = SHARED_INVENTORY:GenerateFullSlotData(withdrawComparator, BAG_BANK, BAG_SUBSCRIBER_BANK)
        local toFillUpWithdrawBagCache = SHARED_INVENTORY:GenerateFullSlotData(withdrawComparator, BAG_BACKPACK)

        -- trigger the itemTransactions
        _doItemTransactions(toDepositBagCache, toFillUpDepositBagCache, toWithdrawBagCache, toFillUpWithdrawBagCache)
    else
        -- else, continue with the next function in queue
        PAEM.executeNextFunctionInQueue(PAB.AddonName)
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.depositOrWithdrawCraftingItems = depositOrWithdrawCraftingItems