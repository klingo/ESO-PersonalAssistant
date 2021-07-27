-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAR = PA.Repair
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local _lastNoRepairKitWarningGameTime = 0

local _repairKitItemIds = {
    [44879] = true,  -- Grand Repair Kit    Tier=6
    [61079] = true,  -- Crown Repair Kit    Tier=7
}

-- --------------------------------------------------------------------------------------------------------------------

local function _getRepairKitsIn(bagId)
    local itemIdComparator = PAHF.getItemIdComparator(_repairKitItemIds, true)
    local repairKitBagCache = SHARED_INVENTORY:GenerateFullSlotData(itemIdComparator, bagId)

    local repairKitTable = setmetatable({}, { __index = table })
    local totalRepairKitCount = 0

    -- create a table with all repairKits
    for _, data in pairs(repairKitBagCache) do
        -- check if it is a repair kits
        if IsItemRepairKit(data.bagId, data.slotIndex) then
            repairKitTable:insert({
                bagId = data.bagId,
                slotIndex = data.slotIndex,
                itemName = data.name,
                itemLink = GetItemLink(data.bagId, data.slotIndex, LINK_STYLE_BRACKETS),
--                stackCount = data.stackCount,
                repairKitTier = GetRepairKitTier(data.bagId, data.slotIndex),
                iconString = "|t20:20:"..data.iconFile.."|t ",
            })
            -- update the total repairKit count
            totalRepairKitCount = totalRepairKitCount + data.stackCount
        end
    end

    local PARepairSavedVars = PAR.SavedVars
    local defaultRepairKit = PARepairSavedVars.RepairEquipped.defaultRepairKit

    if defaultRepairKit == DEFAULT_SOUL_GEM_CHOICE_GOLD then
        -- sort table based on the repairKitTiers (lower tier first | regular = tier 6 | crown = tier 7)
        table.sort(repairKitTable, function(a, b) return a.repairKitTier < b.repairKitTier end)
    else
        -- sort table based on the repairKitTiers (higher tier first | crown = tier 7 | regular = tier 6 )
        table.sort(repairKitTable, function(a, b) return a.repairKitTier > b.repairKitTier end)
    end

    return repairKitTable, totalRepairKitCount
end

-- --------------------------------------------------------------------------------------------------------------------

local function RepairEquippedItemWithRepairKit(bagId, slotIndex)
    -- only proceed if player is not dead (since repairkits cannot be used then)
    if not PAHF.isPlayerDeadOrReincarnating() then
        -- check if it is enabled
        local PARepairSavedVars = PAR.SavedVars
        if bagId == BAG_WORN and PARepairSavedVars.RepairEquipped.repairWithRepairKit then
            local hasDurability = DoesItemHaveDurability(bagId, slotIndex)
            -- check if it is repairable
            if hasDurability then
                local itemCondition = GetItemCondition(bagId, slotIndex)
                local repairKitThreshold = PARepairSavedVars.RepairEquipped.repairWithRepairKitThreshold
                PAR.debugln("%s is at %d/%d", GetItemName(bagId, slotIndex), itemCondition, 100)
                -- check if it is below and would need to be repaired
                if itemCondition <= repairKitThreshold then
                    local repairKitTable, totalRepairKitCount = _getRepairKitsIn(BAG_BACKPACK)
                    if totalRepairKitCount > 0 then
                        local firstRepairKit = repairKitTable[1]
                        local repairableAmount = GetAmountRepairKitWouldRepairItem(bagId, slotIndex, firstRepairKit.bagId, firstRepairKit.slotIndex)
                        local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)

                        -- some debug information
                        PAR.debugln("Want to repair %s with %s for %d from %d/%d", itemLink, firstRepairKit.name, repairableAmount, itemCondition, 100)

                        -- actually repair the item
                        RepairItemWithRepairKit(bagId, slotIndex, firstRepairKit.bagId, firstRepairKit.slotIndex)
                        totalRepairKitCount = totalRepairKitCount - 1
                        PlaySound(SOUNDS.INVENTORY_ITEM_REPAIR)

                        -- show output to chat
                        PAR.println(SI_PA_CHAT_REPAIR_REPAIRKIT_REPAIRED, itemLink, itemCondition, firstRepairKit.itemLink)
                    end

                    -- check remaining repair kits
                    local lowRepairKitThreshold = PARepairSavedVars.RepairEquipped.lowRepairKitThreshold
                    if totalRepairKitCount <= lowRepairKitThreshold and PARepairSavedVars.RepairEquipped.lowRepairKitWarning then
                        local formatted = zo_strformat(GetString(SI_PA_PATTERN_REPAIRKIT_COUNT), totalRepairKitCount)

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
    else
        PAR.debugln("RepairEquippedItemWithRepairKit.isPlayerDeadOrReincarnating (caught!)")
    end
end

local function CheckAndRepairSingleEquippedItemWithRepairKit(eventCode, bagId, slotIndex, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    -- need to wait a little bit (e.g. 500ms) because this event is also triggered when dying, but [IsUnitDead("player")] still returns 'false' for a short amount of time
    -- because the durability loss (triggering this function) happens before the player actually is considered dead
    -- triggering a repair when dead can cause ESO to hang itself and force the player to the login screen
    zo_callLater(function() RepairEquippedItemWithRepairKit(bagId, slotIndex) end, 500)
end

local function CheckAndRepairAllEquippedItemsWithRepairKits()
    -- only proceed if player is not dead (since repairkits cannot be used then)
    if not PAHF.isPlayerDeadOrReincarnating() then
        local bagCache = SHARED_INVENTORY:GenerateFullSlotData(nil, BAG_WORN)
        for _, itemData in pairs(bagCache) do
            if DoesItemHaveDurability(itemData.bagId, itemData.slotIndex) then
                RepairEquippedItemWithRepairKit(itemData.bagId, itemData.slotIndex)
            end
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Repair = PA.Repair or {}
PA.Repair.CheckAndRepairSingleEquippedItemWithRepairKit = CheckAndRepairSingleEquippedItemWithRepairKit
PA.Repair.CheckAndRepairAllEquippedItemsWithRepairKits = CheckAndRepairAllEquippedItemsWithRepairKits