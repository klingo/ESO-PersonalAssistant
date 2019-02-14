-- Local instances of Global tables --
local PA = PersonalAssistant
local PAR = PA.Repair
local PAHF = PA.HelperFunctions
local PASVRepair = PA.SavedVars.Repair

-- ---------------------------------------------------------------------------------------------------------------------

-- TODO: NON-VENDOR
-- use repairkits (after leaving combat)
-- yes/no, plus define threshold


-- TODO: NON-VENDOR
-- use soul gems to recharge weapon (after leaving combat)
-- yes/no, plus define threshold

-- repair all items that are below the given threshold for the bag
local function RepairItems(bagId, threshold)
    local bagCache = SHARED_INVENTORY:GetOrCreateBagCache(bagId)

    if (bagCache) then
        local repairCost = 0
        local repairedItemCount = 0
        local notRepairedItemCount = 0
        local notRepairedItemsCost = 0
        local currentMoney = GetCurrentMoney()

        local PARepairSavedVars = PASVRepair[PA.activeProfile]

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
                            notRepairedItemCount = notRepairedItemCount + stackSize
                            notRepairedItemsCost = notRepairedItemsCost + itemRepairCost
                        else
                            -- sum up the total repair costs
                            repairCost = repairCost + itemRepairCost;
                            repairedItemCount = repairedItemCount + stackSize
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

        if notRepairedItemCount > 0 then
            -- at least one item was not repaired
            local missingGold = notRepairedItemsCost - currentMoney
            -- show output to chat (depending on setting)
            local repairPartialChatMode = PARepairSavedVars.repairPartialChatMode
            if (repairPartialChatMode == PA_OUTPUT_TYPE_FULL) then PAHF.println(GetString(PartialRepair_ChatMode_Full), repairedItemCount, (repairedItemCount + notRepairedItemCount), bagName, repairCost, missingGold)
            elseif (repairPartialChatMode == PA_OUTPUT_TYPE_NORMAL) then PAHF.println(GetString(PartialRepair_ChatMode_Normal), repairCost, missingGold)
            elseif (repairPartialChatMode == PA_OUTPUT_TYPE_MIN) then PAHF.println(GetString(PartialRepair_ChatMode_Min), repairCost, missingGold)
            end -- PA_OUTPUT_TYPE_NONE => no chat output

        else
            -- all repairable itmes were repaired
            if repairedItemCount > 0 then
                -- show output to chat (depending on setting)
                local repairFullChatMode = PARepairSavedVars.repairFullChatMode
                if (repairFullChatMode == PA_OUTPUT_TYPE_FULL) then PAHF.println(GetString(FullRepair_ChatMode_Full), bagName, repairCost)
                elseif (repairFullChatMode == PA_OUTPUT_TYPE_NORMAL) then PAHF.println(GetString(FullRepair_ChatMode_Normal), repairCost)
                elseif (repairFullChatMode == PA_OUTPUT_TYPE_MIN) then PAHF.println(GetString(FullRepair_ChatMode_Min), repairCost)
                end -- PA_OUTPUT_TYPE_NONE => no chat output
            else
                -- Nothing to Repair
            end
        end
    end
end

local function OnShopOpen()
    if (PAHF.hasActiveProfile()) then
        local PARepairSavedVars = PASVRepair[PA.activeProfile]
        -- check if addon is enabled
        if PARepairSavedVars.enabled then
            -- early check if there is something to repair
            if GetRepairAllCost() > 0 then
                -- check if equipped items shall be repaired
                if PARepairSavedVars.repairEquipped then
                    RepairItems(BAG_WORN, PARepairSavedVars.repairEquippedThreshold)
                end
                -- check if backpack items shall be repaired
--                if PARepairSavedVars.repairBackpack then
--                    RepairItems(BAG_BACKPACK, PARepairSavedVars.repairBackpackThreshrold)
--                end
            end
        end
    end
end


local function EventPlayerCombateState(_, inCombat)
    if (PAHF.hasActiveProfile()) then
        local PARepairSavedVars = PASVRepair[PA.activeProfile]
        -- check if addon is enabled
        if PARepairSavedVars.enabled then
            -- check if player is not dead
            if not PAHF.isPlayerDead() then

                -- Check and repair equipped items with repair kits
                if PARepairSavedVars.repairEquippedWithKit then
                    PAR.RepairEquippedItemsWithKit()
                end

                -- Check and re-charged equipped weapons
                if PARepairSavedVars.chargeWeapons then
                    PAR.ReChargeWeapons()
                end
            end
        end
    end
end

-- Export
PA.Repair = PA.Repair or {}
PA.Repair.OnShopOpen = OnShopOpen
PA.Repair.EventPlayerCombateState = EventPlayerCombateState