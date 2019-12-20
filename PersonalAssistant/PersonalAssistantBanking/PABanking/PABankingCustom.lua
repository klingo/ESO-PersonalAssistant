-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
local PAEM = PA.EventManager

-- ---------------------------------------------------------------------------------------------------------------------

local function depositOrWithdrawCustomItems()

    PAB.debugln("PA.Banking.depositOrWithdrawCustomItems")

    if PAB.SavedVars.Custom.customItemsEnabled then

        -- check if bankTransfer is already blocked
        if PAB.isBankTransferBlocked then return end
        PAB.isBankTransferBlocked = true

        -- prepare and fill the table with all custom items that needs to be transferred
        local customItems = {}
        local itemIdTable = PAB.SavedVars.Custom.ItemIds
        for itemId, moveConfig in pairs(itemIdTable) do
            local operator = moveConfig.operator
            local ruleEnabled = moveConfig.ruleEnabled
            if ruleEnabled and operator ~= PAC.OPERATOR.NONE then
                customItems[itemId] = {
                    operator = operator,
                    targetBagStack = moveConfig.bagAmount
                }
            end
        end

        -- then get the matching data from the backpack and bank
        local excludeJunk = PAB.SavedVars.excludeJunk
        local itemIdComparator = PAHF.getItemIdComparator(customItems, excludeJunk)
        local backpackBagCache = SHARED_INVENTORY:GenerateFullSlotData(itemIdComparator, BAG_BACKPACK)
        local bankBagCache = SHARED_INVENTORY:GenerateFullSlotData(itemIdComparator, BAG_BANK, BAG_SUBSCRIBER_BANK)

        PAB.debugln("#backpackBagCache = "..tostring(#backpackBagCache))
        PAB.debugln("#bankBagCache = "..tostring(#bankBagCache))

        -- if there is at least one item to be deposited or withdrawn (and if LWC is one), just assume that it has to be blocked
        if PAB.hasLazyWritCrafterAndShouldGrabEnabled() and (#backpackBagCache > 0 or #bankBagCache > 0) then
            -- note down that potentially items were skipped
            PAB.hasSomeItemskippedForLWC = true
            -- unblock the banking transactions
            PAB.isBankTransferBlocked = false
            -- and continue with the next function in queue
            PAEM.executeNextFunctionInQueue(PAB.AddonName)
        else
            -- trigger the individual itemTransactions
            PAB.doIndividualItemTransactions(customItems, backpackBagCache, bankBagCache)
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