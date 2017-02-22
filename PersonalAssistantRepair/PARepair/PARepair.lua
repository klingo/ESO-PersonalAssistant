-- Module: PersonalAssistant.PARepair
-- Developer: Klingo


-- TODO: NON-VENDOR
-- use repairkits (after leaving combat)
-- yes/no, plus define threshold


-- TODO: NON-VENDOR
-- use soul gems to recharge weapon (after leaving combat)
-- yes/no, plus define threshold

-- =====================================================================================================================
-- =====================================================================================================================

-- repair all items that are below the given threshold for the bag
local function RepairItems(bagId, threshold)
    local bagCache = SHARED_INVENTORY:GetOrCreateBagCache(bagId)
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

        local bagName = PAHF.getBagNameAdjective(bagId)

        if notRepairedItems > 0 then
            -- at least one item was not repaired
            local missingGold = notRepairedItemsCost - currentMoney
            -- show output to chat (depending on setting)
            local repairPartialChatMode = PA.savedVars.Repair[PA.activeProfile].repairPartialChatMode
            if (repairPartialChatMode == PA_OUTPUT_TYPE_FULL) then PAHF.println(PALocale.getResourceMessage("PAR_PartialRepair_ChatMode_Full"), repairedItems, (repairedItems + notRepairedItems), bagName, repairCost, missingGold)
            elseif (repairPartialChatMode == PA_OUTPUT_TYPE_NORMAL) then PAHF.println(PALocale.getResourceMessage("PAR_PartialRepair_ChatMode_Normal"), repairCost, missingGold)
            elseif (repairPartialChatMode == PA_OUTPUT_TYPE_MIN) then PAHF.println(PALocale.getResourceMessage("PAR_PartialRepair_ChatMode_Min"), repairCost, missingGold)
            end -- PA_OUTPUT_TYPE_NONE => no chat output

        else
            -- all repairable itmes were repaired
            if repairedItems > 0 then
                -- show output to chat (depending on setting)
                local repairFullChatMode = PA.savedVars.Repair[PA.activeProfile].repairFullChatMode
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

-- =====================================================================================================================
-- =====================================================================================================================

function PAR.OnShopOpen()
    if (PAHF.hasActiveProfile()) then

        -- check if addon is enabled
        if PA.savedVars.Repair[PA.activeProfile].enabled then
            -- early check if there is something to repair
            if GetRepairAllCost() > 0 then
                -- check if equipped items shall be repaired
                if PA.savedVars.Repair[PA.activeProfile].repairEquipped then
                    RepairItems(BAG_WORN, PA.savedVars.Repair[PA.activeProfile].repairEquippedThreshold)
                end
                -- check if backpack items shall be repaired
                if PA.savedVars.Repair[PA.activeProfile].repairBackpack then
                    RepairItems(BAG_BACKPACK, PA.savedVars.Repair[PA.activeProfile].repairBackpackThreshrold)
                end
            end
        end
    end
end


function PAR.EventPlayerCombateState(_, inCombat)
    if (PAHF.hasActiveProfile()) then
        -- check if addon is enabled
        if PA.savedVars.Repair[PA.activeProfile].enabled then
            -- check if player is not dead
            if not PAHF.isPlayerDead() then

                -- Check and repair equipped items with repair kits
                if PA.savedVars.Repair[PA.activeProfile].repairEquippedWithKit then
                    PAR_Kit.RepairEquippedItemsWithKit()
                end

                -- Check and re-charged equipped weapons
                if PA.savedVars.Repair[PA.activeProfile].chargeWeapons then
                    PAR_Charge.ReChargeWeapons()
                end
            end
        end
    end
end

