-- Local instances of Global tables --
local PA = PersonalAssistant
local PASV = PA.SavedVars
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local _lastNoRepairKitWarningGameTime = 0

-- --------------------------------------------------------------------------------------------------------------------

local function _getRepairKitsIn(bagId)
    local repairKitItemIds = {}
    repairKitItemIds[44879] = {} -- Grand Repair Kit
--    individualItems[61079] = {} -- Crown Repair Kit

    local itemIdComparator = PAHF.getItemIdComparator(repairKitItemIds)
    local backpackBagCache = SHARED_INVENTORY:GenerateFullSlotData(itemIdComparator, bagId)

    local totalStackCount = 0
    for _, itemData in pairs(backpackBagCache) do
        totalStackCount = totalStackCount + itemData.stackCount
    end

    return backpackBagCache, totalStackCount
end

-- --------------------------------------------------------------------------------------------------------------------

local function RepairEquippedItemsWithRepairKits(eventCode, bagId, slotIndex, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    local PARepairSavedVars = PASV.Repair[PA.activeProfile]

    -- check if it is enabled
    if bagId == BAG_WORN and (PARepairSavedVars.RepairEquipped.repairWithRepairKit or PARepairSavedVars.RepairEquipped.repairWithCrownRepairKit) then
        local itemType = GetItemType(bagId, slotIndex)
        local hasDurability = DoesItemHaveDurability(bagId, slotIndex)
        -- check if it is repairable
        if hasDurability then
            local itemCondition = GetItemCondition(bagId, slotIndex)
            local repairKitThreshold = PARepairSavedVars.RepairEquipped.repairWithRepairKitThreshold
            -- check if it is below and would need to be repaired
            if itemCondition <= repairKitThreshold then
                local repairKitTable, totalRepairKitCount = _getRepairKitsIn(BAG_BACKPACK)
                if totalRepairKitCount > 0 then
                    local repairableAmount = GetAmountRepairKitWouldRepairItem(bagId, slotIndex, repairKitTable[#repairKitTable].bagId, repairKitTable[#repairKitTable].slotIndex)
                    local finalRepairPerc = itemCondition + repairableAmount

                    -- some debug information
                    PAHF.println("Want to repair: %s with: %s for %d from currently: %d/%d", GetItemName(bagId, slotIndex), repairKitTable[#repairKitTable].name, repairableAmount, itemCondition, 100)

                    -- actually repair the item
--                    RepairItemWithRepairKit(bagId, slotIndex, repairKitTable[#repairKitTable].bagId, repairKitTable[#repairKitTable].slotIndex)
                    totalRepairKitCount = totalRepairKitCount - 1

                    local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)
                    local iconString = "|t20:20:"..GetItemLinkInfo(itemLink).."|t "

                    -- TODO: Repair Chat Output
                end

                -- check remaining repair kits
                if totalRepairKitCount <= 10 and PARepairSavedVars.RepairEquipped.lowRepairKitWarning then
                    local gameTimeMilliseconds = GetGameTimeMilliseconds()
                    local gameTimeMillisecondsPassed = gameTimeMilliseconds - _lastNoRepairKitWarningGameTime
                    local gameTimeMinutesPassed = gameTimeMillisecondsPassed / 1000 / 60

                    if (gameTimeMinutesPassed >= 10) then
                        _lastNoRepairKitWarningGameTime = gameTimeMilliseconds

                        if totalRepairKitCount > 0 then
                            PAHF.println(SI_PA_REPAIR_REPAIRKIT_LOW_REPAIRKIT_COUNT, totalRepairKitCount)
                        else
                            PAHF.println(SI_PA_REPAIR_REPAIRKIT_NO_REPAIRKIT_COUNT)
                        end
                    end
                end
            end
        end
     end


--    GetAmountRepairKitWouldRepairItem(number Bag itemToRepairBagId, number itemToRepairSlotIndex, number Bag repairKitToConsumeBagId, number repairKitToConsumeSlotIndex)
--    Returns: number amountRepaired

--    RepairItemWithRepairKit(number Bag itemToRepairBagId, number itemToRepairSlotIndex, number Bag repairKitToConsumeBagId, number repairKitToConsumeSlotIndex)

end

-- Export
PA.Repair = PA.Repair or {}
PA.Repair.RepairEquippedItemsWithRepairKits = RepairEquippedItemsWithRepairKits