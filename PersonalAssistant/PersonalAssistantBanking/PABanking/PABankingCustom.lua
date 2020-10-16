-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
local PAEM = PA.EventManager

-- ---------------------------------------------------------------------------------------------------------------------

local function _doItemTransactions(depositFromBagCache, withdrawalFromBagCache)
    -- call the generic version
    PAB.doGenericItemTransactions(depositFromBagCache, {}, withdrawalFromBagCache, {})
end

-- ---------------------------------------------------------------------------------------------------------------------

local function depositOrWithdrawSimpleBankingRules()
    PAB.debugln("PA.Banking.depositOrWithdrawSimpleBankingRules")

    -- currently this is always 'true' (cannot be disabled)
    if PAB.SavedVars.Custom.customItemsEnabled then

        -- check if bankTransfer is already blocked
        if PAB.isBankTransferBlocked then return end
        PAB.isBankTransferBlocked = true

        -- prepare and fill the table with all custom items that needs to be transferred
        local customPAItems = {}
        local paItemIdTable = PAB.SavedVars.Custom.PAItemIds
        for paItemId, moveConfig in pairs(paItemIdTable) do
            local operator = moveConfig.operator
            local ruleEnabled = moveConfig.ruleEnabled
            if ruleEnabled and operator ~= PAC.OPERATOR.NONE then
                customPAItems[paItemId] = {
                    operator = operator,
                    targetBagStack = moveConfig.bagAmount
                }
            end
        end

        -- then get the matching data from the backpack and bank
        local excludeJunk = PAB.SavedVars.excludeJunk
        local paItemIdComparator = PAHF.getPAItemIdComparator(customPAItems, excludeJunk)
        local backpackBagCache = SHARED_INVENTORY:GenerateFullSlotData(paItemIdComparator, BAG_BACKPACK)
        local bankBagCache = SHARED_INVENTORY:GenerateFullSlotData(paItemIdComparator, BAG_BANK, BAG_SUBSCRIBER_BANK)

        PAB.debugln("#backpackBagCache = "..tostring(#backpackBagCache))
        PAB.debugln("#bankBagCache = "..tostring(#bankBagCache))

        -- if there is at least one item to be deposited or withdrawn (and if LWC is on), just assume that it has to be blocked
        if PAB.hasLazyWritCrafterAndShouldGrabEnabled() and (#backpackBagCache > 0 or #bankBagCache > 0) then
            -- note down that potentially items were skipped
            PAB.hasSomeItemskippedForLWC = true
            -- unblock the banking transactions
            PAB.isBankTransferBlocked = false
            -- and continue with the next function in queue
            PAEM.executeNextFunctionInQueue(PAB.AddonName)
        else
            -- trigger the individual itemTransactions
            PAB.doIndividualItemTransactions(customPAItems, backpackBagCache, bankBagCache, true)
        end
    else
        -- else, continue with the next function in queue
        PAEM.executeNextFunctionInQueue(PAB.AddonName)
    end
end

local function depositOrWithdrawAdvancedBankingRules()
    PAB.debugln("PA.Banking.depositOrWithdrawAdvancedBankingRules")

    -- currently this is always 'true' (cannot be disabled)
    if PAB.SavedVars.AdvancedRules.advancedRulesEnabled then
        -- check if bankTransfer is already blocked
        if PAB.isBankTransferBlocked then return end
        PAB.isBankTransferBlocked = true

        -- prepare and fill the table with all custom items that needs to be transferred
        local advancedBankingRulesDepositTable = {}
        local advancedBankingRulesWithdrawTable = {}
        local PABAdvancedRules = PA.Banking.SavedVars.AdvancedRules.Rules
        for _, ruleSetting in ipairs(PABAdvancedRules) do
            if ruleSetting.ruleEnabled then
                local ruleComparatorEntry = PA.CustomDialogs.getPABRuleComparatorEntryFromRawSettings(ruleSetting.ruleRaw)
                if ruleComparatorEntry.itemAction == BAG_BACKPACK then
                    table.insert(advancedBankingRulesDepositTable, ruleComparatorEntry)
                elseif ruleComparatorEntry.itemAction == BAG_BANK then
                    table.insert(advancedBankingRulesWithdrawTable, ruleComparatorEntry)
                end
            end
        end

        PAB.debugln("#advancedBankingRulesDepositTable = "..tostring(#advancedBankingRulesDepositTable))
        PAB.debugln("#advancedBankingRulesWithdrawTable = "..tostring(#advancedBankingRulesWithdrawTable))

        -- then get the matching data from the backpack and bank
        local excludeJunk = PAB.SavedVars.excludeJunk

        local depositComparator = PAHF.getAdvancedBankingRulesComparator(advancedBankingRulesDepositTable, excludeJunk)
        local withdrawComparator = PAHF.getAdvancedBankingRulesComparator(advancedBankingRulesWithdrawTable, excludeJunk)

        local toDepositBagCache = SHARED_INVENTORY:GenerateFullSlotData(depositComparator, BAG_BACKPACK)
        local toWithdrawBagCache = SHARED_INVENTORY:GenerateFullSlotData(withdrawComparator, BAG_BANK, BAG_SUBSCRIBER_BANK)

        -- if there is at least one item to be deposited or withdrawn (and if LWC is on), just assume that it has to be blocked
        if PAB.hasLazyWritCrafterAndShouldGrabEnabled() and (#toDepositBagCache > 0 or #toWithdrawBagCache > 0) then
            -- note down that potentially items were skipped
            PAB.hasSomeItemskippedForLWC = true
            -- unblock the banking transactions
            PAB.isBankTransferBlocked = false
            -- and continue with the next function in queue
            PAEM.executeNextFunctionInQueue(PAB.AddonName)
        else
            -- trigger the itemTransactions
            _doItemTransactions(toDepositBagCache, toWithdrawBagCache)
        end
    else
        -- else, continue with the next function in queue
        PAEM.executeNextFunctionInQueue(PAB.AddonName)
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.depositOrWithdrawSimpleBankingRules = depositOrWithdrawSimpleBankingRules
PA.Banking.depositOrWithdrawAdvancedBankingRules = depositOrWithdrawAdvancedBankingRules