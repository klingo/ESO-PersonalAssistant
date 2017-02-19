-- Module: PersonalAssistant.PARepair
-- Developer: Klingo

function PAR.OnShopOpen()
    if (PAHF.hasActiveProfile()) then
        local activeProfile = PA.savedVars.Profile.activeProfile

        -- check if addon is enabled
        if PA.savedVars.Repair[activeProfile].enabled then
            -- early check if there is something to repair
            if GetRepairAllCost() > 0 then
                -- check if equipped items shall be repaired
                if PA.savedVars.Repair[activeProfile].repairEquipped then
                    PAR.RepairItems(BAG_WORN, PA.savedVars.Repair[activeProfile].repairEquippedThreshold, activeProfile)
                end
                -- check if backpack items shall be repaired
                if PA.savedVars.Repair[activeProfile].repairBackpack then
                    PAR.RepairItems(BAG_BACKPACK, PA.savedVars.Repair[activeProfile].repairBackpackThreshrold, activeProfile)
                end
            end
        end
    end
end


-- repair all items that are below the given threshold for the bag
function PAR.RepairItems(bagId, threshold, activeProfile)
    local bagCache = SHARED_INVENTORY:GetBagCache(bagId)
    if (bagCache) then
        local repairCost = 0
        local repairedItems = 0
        local notRepairedItems = 0
        local notRepairedItemsCost = 0
        local currentMoney = GetCurrentMoney()

        -- loop through all items of the corresponding bagId
        for index, data in pairs(bagCache) do
            -- check first if the item has durability (and therefore is repairable)
            if DoesItemHaveDurability(bagId, index) then
                -- then compare it with the threshold
                if GetItemCondition(bagId, index) <= threshold then
                    local stackSize = GetSlotStackSize(bagId, index)
                    -- get the repair cost for that item and repair if possible
                    local itemRepairCost = GetItemRepairCost(bagId, index)
                    if itemRepairCost > 0 then
                        if (itemRepairCost > currentMoney) then
                            -- even though not enough money available, continue as maybe a cheaper item still can be repaired
                            notRepairedItems = notRepairedItems + stackSize
                            notRepairedItemsCost = notRepairedItemsCost + itemRepairCost
                        else
                            -- sum up the total repair costs
                            repairCost = repairCost + itemRepairCost;
                            repairedItems = repairedItems + stackSize
                            RepairItem(bagId, index)
                            -- currentMoney has to be manually calculated, as the "GetCurrentMoney()"
                            -- does not yet reflect the just made repairs
                            currentMoney = currentMoney - itemRepairCost
                        end
                    end
                end
            end
        end

        -- check if the msg-output shall be skipped

        local bagName = PAHF.getBagNameAdjective(bagId)

        if notRepairedItems > 0 then
            -- at least one item was not repaired
            local missingGold = notRepairedItemsCost - currentMoney
            -- show output to chat (depending on setting)
            local repairPartialChatMode = PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].repairPartialChatMode
            if (repairPartialChatMode == PA_OUTPUT_TYPE_FULL) then PAHF.println(PALocale.getResourceMessage("PAR_PartialRepair_ChatMode_Full"), repairedItems, (repairedItems + notRepairedItems), bagName, repairCost, missingGold)
            elseif (repairPartialChatMode == PA_OUTPUT_TYPE_NORMAL) then PAHF.println(PALocale.getResourceMessage("PAR_PartialRepair_ChatMode_Normal"), repairCost, missingGold)
            elseif (repairPartialChatMode == PA_OUTPUT_TYPE_MIN) then PAHF.println(PALocale.getResourceMessage("PAR_PartialRepair_ChatMode_Min"), repairCost, missingGold)
            end -- PA_OUTPUT_TYPE_NONE => no chat output

        else
            -- all repairable itmes were repaired
            if repairedItems > 0 then
                -- show output to chat (depending on setting)
                local repairFullChatMode = PA.savedVars.Repair[PA.savedVars.Profile.activeProfile].repairFullChatMode
                if (repairFullChatMode == PA_OUTPUT_TYPE_FULL) then PAHF.println(PALocale.getResourceMessage("PAR_FullRepair_ChatMode_Full"), bagName, repairCost)
                elseif (repairFullChatMode == PA_OUTPUT_TYPE_NORMAL) then PAHF.println(PALocale.getResourceMessage("PAR_FullRepair_ChatMode_Normal"), repairCost)
                elseif (repairFullChatMode == PA_OUTPUT_TYPE_MIN) then PAHF.println(PALocale.getResourceMessage("PAR_FullRepair_ChatMode_Min"), repairCost)
                end -- PA_OUTPUT_TYPE_NONE => no chat output
            else
                -- Nothing to Repair
            end
        end
    end
end