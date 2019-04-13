-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAR = PA.Repair
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local _lastNoRepairKitWarningGameTime = 0
local _repairKitCountPattern = GetString(SI_PA_PATTERN_REPAIRKIT_COUNT)

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
        itemData.itemLink = GetItemLink(itemData.bagId, itemData.slotIndex, LINK_STYLE_BRACKETS)
    end

    return backpackBagCache, totalStackCount
end

-- --------------------------------------------------------------------------------------------------------------------

local function RepairEquippedItemsWithRepairKits(eventCode, bagId, slotIndex, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    -- only proceed if player is not dead (since repairkits cannot be used then)
    if not PAHF.isPlayerDead then
        -- check if it is enabled
        local PARepairSavedVars = PAR.SavedVars
        if bagId == BAG_WORN and (PARepairSavedVars.RepairEquipped.repairWithRepairKit or PARepairSavedVars.RepairEquipped.repairWithCrownRepairKit) then
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

                        -- some debug information
                        PAHF.debugln("Want to repair: %s with: %s for %d from currently: %d/%d", GetItemName(bagId, slotIndex), repairKitTable[#repairKitTable].name, repairableAmount, itemCondition, 100)

                        -- actually repair the item
                        RepairItemWithRepairKit(bagId, slotIndex, repairKitTable[#repairKitTable].bagId, repairKitTable[#repairKitTable].slotIndex)
                        totalRepairKitCount = totalRepairKitCount - 1

                        local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)

                        PAR.println(GetString(SI_PA_CHAT_REPAIR_REPAIRKIT_REPAIRED), itemLink, itemCondition, repairKitTable[#repairKitTable].itemLink)
                    end

                    -- check remaining repair kits
                    local lowRepairKitThreshold = PARepairSavedVars.RepairEquipped.lowRepairKitThreshold
                    if totalRepairKitCount <= lowRepairKitThreshold and PARepairSavedVars.RepairEquipped.lowRepairKitWarning then
                        local formatted = zo_strformat(_repairKitCountPattern, totalRepairKitCount)

                        if totalRepairKitCount == 0 then
                            -- if no repair kits left, have a orange-red message (but only every 10 minutes)
                            local gameTimeMilliseconds = GetGameTimeMilliseconds()
                            local gameTimeMillisecondsPassed = gameTimeMilliseconds - _lastNoRepairKitWarningGameTime
                            local gameTimeMinutesPassed = gameTimeMillisecondsPassed / 1000 / 60
                            if gameTimeMinutesPassed >= 10 then
                                _lastNoRepairKitWarningGameTime = gameTimeMilliseconds
                                PAR.println(formatted, PAC.COLORS.ORANGE_RED, PAC.COLORS.ORANGE_RED)
                            end
                        elseif totalRepairKitCount <= lowRepairKitThreshold then
                            if totalRepairKitCount <= 5 then
                                -- if at or below 5 soul gems, have a orange message
                                PAR.println(formatted, PAC.COLORS.ORANGE, PAC.COLORS.ORANGE)
                            else
                                -- in all other cases, have a yellow message
                                PAR.println(formatted, PAC.COLORS.DEFAULT, PAC.COLORS.DEFAULT)
                            end
                        end
                    end
                end
            end
        end
    end
end

local function CheckAndRepairEquippedItemsWithRepairKits()
    -- only proceed if player is not dead (since repairkits cannot be used then)
    if not PAHF.isPlayerDead then
        local bagCache = SHARED_INVENTORY:GenerateFullSlotData(nil, BAG_WORN)
        for _, itemData in pairs(bagCache) do
            RepairEquippedItemsWithRepairKits(nil, itemData.bagId, itemData.slotIndex)
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Repair = PA.Repair or {}
PA.Repair.RepairEquippedItemsWithRepairKits = RepairEquippedItemsWithRepairKits
PA.Repair.CheckAndRepairEquippedItemsWithRepairKits = CheckAndRepairEquippedItemsWithRepairKits