-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
local PAEM = PA.EventManager

-- ---------------------------------------------------------------------------------------------------------------------

local function depositOrWithdrawCustomItems()

    PAB.debugln("PA.Banking.depositOrWithdrawCustomItems (4)")

    if PAB.SavedVars.Custom.customItemsEnabled then

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

        -- if there is at least one item to be deposited or withdrawn (and if LWC is one), just assume that it has to be blocked
        if PAB.hasLazyWritCrafterAndShouldGrabEnabled() and (#backpackBagCache > 0 or #bankBagCache > 0) then
            -- note down that potentially items were skipped
            PAB.hasSomeItemskippedForLWC = true
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

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.depositOrWithdrawCustomItems = depositOrWithdrawCustomItems