-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
local PAEM = PA.EventManager

-- ---------------------------------------------------------------------------------------------------------------------

local function depositOrWithdrawAvAItems()

    PAHF.debugln("PA.Banking.depositOrWithdrawAvAItems")

    if PAB.SavedVars.AvA.avaItemsEnabled then
        -- check if bankTransfer is already blocked
        if PAB.isBankTransferBlocked then return end
        PAB.isBankTransferBlocked = true

        -- prepare and fill the table with all ava items that needs to be transferred
        local individualItems = {}
        local itemIdTable = PAB.SavedVars.AvA.ItemIds
        for itemId, moveConfig in pairs(itemIdTable) do
            local operator = moveConfig.operator
            if operator ~= PAC.OPERATOR.NONE then
                individualItems[itemId] = {
                    operator = operator,
                    targetBackpackStack = moveConfig.backpackAmount
                }
            end
        end

        -- then also check the crossAlliance ava items that need to be transferred
        local PACAllianceSiegeTable = PAC.BANKING_AVA.SIEGE[PA.alliance]
        for _, corssAlianceItemIdTable in pairs(PACAllianceSiegeTable) do
            for crossAllianceItemId, itemId in pairs(corssAlianceItemIdTable) do
                local moveConfig = PAB.SavedVars.AvA.CrossAllianceItemIds[crossAllianceItemId]
                local operator = moveConfig.operator
                if operator ~= PAC.OPERATOR.NONE then
                    individualItems[itemId] = {
                        operator = operator,
                        targetBackpackStack = moveConfig.backpackAmount
                    }
                end
            end
        end

        -- then get the matching data from the backpack and bank
        local itemIdComparator = PAHF.getItemIdComparator(individualItems)
        local backpackBagCache = SHARED_INVENTORY:GenerateFullSlotData(itemIdComparator, BAG_BACKPACK)
        local bankBagCache = SHARED_INVENTORY:GenerateFullSlotData(itemIdComparator, BAG_BANK, BAG_SUBSCRIBER_BANK)

        PAHF.debugln("#backpackBagCache = "..tostring(#backpackBagCache))
        PAHF.debugln("#bankBagCache = "..tostring(#bankBagCache))

        -- trigger the individual itemTransactions
        PAB.doIndividualItemTransactions(individualItems, backpackBagCache, bankBagCache)
    else
        -- else, continue with the next function in queue
        PAEM.executeNextFunctionInQueue(PAB.AddonName)
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.depositOrWithdrawAvAItems = depositOrWithdrawAvAItems