-- Local instances of Global tables --
local PA = PersonalAssistant
local PAR = PA.Repair
local PAHF = PA.HelperFunctions
local PARProfileManager = PA.ProfileManager.PARepair

-- ---------------------------------------------------------------------------------------------------------------------

local _repairItemList

-- a comparator that returns all items that have durability, and that durability is below the provided threshold
local function _getItemHasDurabilityBelowThresholdComparator(threshold)
    return function(itemData)
        local bagId = itemData.bagId
        local slotIndex = itemData.slotIndex
        -- does item have durability?
        if DoesItemHaveDurability(bagId, slotIndex) then
            local itemCondition = GetItemCondition(bagId, slotIndex)
            -- is item durability below threshold?
            if itemCondition <= threshold then
                return true
            end
        end
        return false
    end
end

-- repair all items that are below the given threshold for the bag
local function _repairItems(bagId, threshold)
    local durabilityAndThresholdComparator = _getItemHasDurabilityBelowThresholdComparator(threshold)
    local bagCache = SHARED_INVENTORY:GenerateFullSlotData(durabilityAndThresholdComparator, bagId)

    if bagCache then
        local repairCost = 0
        local repairedItemCount = 0
        local notRepairedItemCount = 0
        local notRepairedItemsCost = 0
        local currentMoney = GetCurrentMoney()
        _repairItemList = {}

        -- loop through all items of the corresponding bagId
        for _, itemData in pairs(bagCache) do
            local slotIndex = itemData.slotIndex
            -- [DoesItemHaveDurability] and ItemCondition check are not necessary anymore (already done by comparator)
            -- get the repair cost for that item and repair if possible
            local itemRepairCost = GetItemRepairCost(bagId, slotIndex)
            if itemRepairCost > 0 then
                local itemCondition = GetItemCondition(bagId, slotIndex)
                local stackSize = GetSlotStackSize(bagId, slotIndex)
                if itemRepairCost > currentMoney then
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

        -- show output to chat
        local repairCostFmt = PAHF.getFormattedCurrency(repairCost * -1) -- to be converted to a negative amount
        if notRepairedItemCount > 0 then
            local missingGold = notRepairedItemsCost - currentMoney
            local missingGoldFmt = PAHF.getFormattedCurrency(missingGold, CURT_MONEY, true)
            if bagId == BAG_BACKPACK then
                PAR.println(SI_PA_CHAT_REPAIR_SUMMARY_INVENTORY_PARTIAL, repairCostFmt, missingGoldFmt)
            else
                PAR.println(SI_PA_CHAT_REPAIR_SUMMARY_PARTIAL, repairCostFmt, missingGoldFmt)
            end
        elseif repairedItemCount > 0 then
            if bagId == BAG_BACKPACK then
                PAR.println(SI_PA_CHAT_REPAIR_SUMMARY_INVENTORY_FULL, repairCostFmt)
            else
                PAR.println(SI_PA_CHAT_REPAIR_SUMMARY_FULL, repairCostFmt)
            end
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

local function OnShopOpen()
    PAR.debugln("PARepair.OnShopOpen")
    if PARProfileManager.hasActiveProfile() then
        -- check if store can repair and if there is something to repair
        if CanStoreRepair() and GetRepairAllCost() > 0 then
            local PARepairSavedVars = PAR.SavedVars
            -- check if equipped items shall be repaired
            if PARepairSavedVars.autoRepairEnabled and PARepairSavedVars.RepairEquipped.repairWithGold then
                _repairItems(BAG_WORN, PARepairSavedVars.RepairEquipped.repairWithGoldDurabilityThreshold)
            end
            -- check if backpack items shall be repaired
            if PARepairSavedVars.autoRepairInventoryEnabled and PARepairSavedVars.RepairInventory.repairWithGold then
                _repairItems(BAG_BACKPACK, PARepairSavedVars.RepairInventory.repairWithGoldDurabilityThreshold)
            end
        end
    end
end

-- Export
PA.Repair = PA.Repair or {}
PA.Repair.OnShopOpen = OnShopOpen