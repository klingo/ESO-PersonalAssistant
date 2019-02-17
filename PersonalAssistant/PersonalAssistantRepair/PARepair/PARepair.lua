-- Local instances of Global tables --
local PA = PersonalAssistant
local PAR = PA.Repair
local PASV = PA.SavedVars
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local _repairItemList

local function _handleFullReport(threshold, repairedItemCount, notRepairedItemCount, repairCost, missingGold)
    PAHF.println(SI_PA_REPAIR_CHATMODE_MAX_INTRO, threshold)
    -- in casee of full chat mode; it does not matter if full or partial repair was made
    for _, itemData in pairs(_repairItemList) do
        if itemData.repaired then
            PAHF.println(SI_PA_REPAIR_CHATMODE_MAX_REPAIRED, itemData.itemLink, itemData.itemCondition, itemData.repairCost)
        else
            PAHF.println(SI_PA_REPAIR_CHATMODE_MAX_NOT_REPAIRED, itemData.itemLink, itemData.itemCondition)
        end
    end
    if notRepairedItemCount > 0 then
        PAHF.println(SI_PA_REPAIR_CHATMODE_MAX_SUMMARY_PARTIAL, repairedItemCount, (repairedItemCount + notRepairedItemCount),repairCost, missingGold)
    elseif repairedItemCount > 0 then
        PAHF.println(SI_PA_REPAIR_CHATMODE_MAX_SUMMARY_FULL, repairedItemCount, (repairedItemCount + notRepairedItemCount), repairCost)
    else
        PAHF.println(SI_PA_REPAIR_CHATMODE_MAX_SUMMARY_NOTHING)
    end
end

local function _handleNormalReport(repairedItemCount, notRepairedItemCount, repairCost, missingGold)
    if notRepairedItemCount > 0 then
        PAHF.println(SI_PA_REPAIR_CHATMODE_NORMAL_SUMMARY_PARTIAL, repairCost, missingGold)
    elseif repairedItemCount > 0 then
        PAHF.println(SI_PA_REPAIR_CHATMODE_NORMAL_SUMMARY_FULL, repairCost)
    end
end

local function _handleMinimalReport(repairedItemCount, notRepairedItemCount, repairCost, missingGold)
    if notRepairedItemCount > 0 then
        PAHF.println(SI_PA_REPAIR_CHATMODE_MIN_SUMMARY_PARTIAL, repairCost, missingGold)
    elseif repairedItemCount > 0 then
        PAHF.println(SI_PA_REPAIR_CHATMODE_MIN_SUMMARY_FULL, repairCost)
    end

end


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
        _repairItemList = {}

        local PARepairSavedVars = PASV.Repair[PA.activeProfile]

        -- loop through all items of the corresponding bagId
        for slotIndex, data in pairs(bagCache) do
            -- check first if the item has durability (and therefore is repairable)
            if DoesItemHaveDurability(bagId, slotIndex) then
                -- then compare it with the threshold
                local itemCondition = GetItemCondition(bagId, slotIndex)
                if itemCondition <= threshold then
                    local stackSize = GetSlotStackSize(bagId, slotIndex)
                    -- get the repair cost for that item and repair if possible
                    local itemRepairCost = GetItemRepairCost(bagId, slotIndex)
                    if itemRepairCost > 0 then
                        if (itemRepairCost > currentMoney) then
                            -- even though not enough money available, continue as maybe a cheaper item still can be repaired
                            notRepairedItemCount = notRepairedItemCount + stackSize
                            notRepairedItemsCost = notRepairedItemsCost + itemRepairCost
                            -- add the item to the list as NOT repaired
                            table.insert(_repairItemList, {
                                itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS),
                                repairCost = itemRepairCost,
                                itemCondition = itemCondition,
                                repaired = false
                            })
                        else
                            -- sum up the total repair costs
                            repairCost = repairCost + itemRepairCost;
                            repairedItemCount = repairedItemCount + stackSize
                            RepairItem(bagId, slotIndex)
                            -- currentMoney has to be manually calculated, as the "GetCurrentMoney()"
                            -- does not yet reflect the just made repairs
                            currentMoney = currentMoney - itemRepairCost
                            -- add the item to the list as repaired
                            table.insert(_repairItemList, {
                                itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS),
                                repairCost = itemRepairCost,
                                itemCondition = itemCondition,
                                repaired = true
                            })
                        end
                    end
                end
            end
        end

        local repairChatMode = PARepairSavedVars.RepairEquipped.repairWithGoldChatMode
        local missingGold = notRepairedItemsCost - currentMoney

        -- based on the settings, handle the chat output
        if repairChatMode == PAC.CHATMODE.OUTPUT_MAX then
            _handleFullReport(threshold, repairedItemCount, notRepairedItemCount, repairCost, missingGold)
        elseif repairChatMode == PAC.CHATMODE.OUTPUT_NORMAL then
            _handleNormalReport(repairedItemCount, notRepairedItemCount, repairCost, missingGold)
        elseif repairChatMode == PAC.CHATMODE.OUTPUT_MIN then
            _handleMinimalReport(repairedItemCount, notRepairedItemCount, repairCost, missingGold)
        end
    end
end


local function OnShopOpen()
    if (PAHF.hasActiveProfile()) then
        local PARepairSavedVars = PASV.Repair[PA.activeProfile]
        -- check if addon is enabled
        if PARepairSavedVars.autoRepairEnabled then
            -- early check if there is something to repair
            if GetRepairAllCost() > 0 then
                -- check if equipped items shall be repaired
                if PARepairSavedVars.RepairEquipped.repairWithGold then
                    RepairItems(BAG_WORN, PARepairSavedVars.RepairEquipped.repairWithGoldDurabilityThreshold)
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
    if not inCombat then
        if (PAHF.hasActiveProfile()) then
            local PARepairSavedVars = PASV.Repair[PA.activeProfile]
            -- check if addon is enabled
            if PARepairSavedVars.enabled then
                -- check if player is not dead
                if not PAHF.isPlayerDead() then

                    -- Check and repair equipped items with repair kits
                    if PARepairSavedVars.RepairEquipped.repairWithRepairKit then
                        -- TODO: for testing purposes disabled
--                        PAR.RepairEquippedItemsWithKit()
                    end

                    -- Check and re-charged equipped weapons
                    if PARepairSavedVars.RechargeWeapons.useSoulGems then
                        PAR.ReChargeWeapons()
                    end
                end
            end
        end
    end
end

-- Export
PA.Repair = PA.Repair or {}
PA.Repair.OnShopOpen = OnShopOpen
PA.Repair.EventPlayerCombateState = EventPlayerCombateState