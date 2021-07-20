-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAR = PA.Repair
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local _lastNoSoulGemWarningGameTime = 0

local _soulGemItemTypes = setmetatable({}, { __index = table })
_soulGemItemTypes:insert(ITEMTYPE_SOUL_GEM)

-- --------------------------------------------------------------------------------------------------------------------

local function _getSoulGemsIn(bagId)
    local soulGemComparator = PAHF.getItemTypeComparator(_soulGemItemTypes)
    local soulGemBagCache = SHARED_INVENTORY:GenerateFullSlotData(soulGemComparator, bagId)

    local gemTable = setmetatable({}, { __index = table })
    local totalGemCount = 0

    -- create a table with all soulGems
    for _, data in pairs(soulGemBagCache) do
        -- check if it is a filled soulGem
        if IsItemSoulGem(SOUL_GEM_TYPE_FILLED, data.bagId, data.slotIndex) then
            gemTable:insert({
                bagId = data.bagId,
                slotIndex = data.slotIndex,
                itemName = data.name,
                itemLink = GetItemLink(data.bagId, data.slotIndex, LINK_STYLE_BRACKETS),
--                stackCount = data.stackCount,
                gemTier = GetSoulGemItemInfo(data.bagId, data.slotIndex),
                iconString = "|t20:20:"..data.iconFile.."|t ",
            })
            -- update the total gem count
            totalGemCount = totalGemCount + data.stackCount
        end
    end

    local PARepairSavedVars = PAR.SavedVars
    local defaultSoulGem = PARepairSavedVars.RechargeWeapons.defaultSoulGem

    if defaultSoulGem == DEFAULT_SOUL_GEM_CHOICE_GOLD then
        -- sort table based on the gemTiers (higher tier first | regular = tier 1 | crown = tier 0)
        table.sort(gemTable, function(a, b) return a.gemTier > b.gemTier end)
    else
        -- sort table based on the gemTiers (lower tier first | crown = tier 0 | regular = tier 1)
        table.sort(gemTable, function(a, b) return a.gemTier < b.gemTier end)
    end

    return gemTable, totalGemCount
end

-- ---------------------------------------------------------------------------------------------------------------------

local function RechargeEquippedWeaponsWithSoulGems(eventCode, bagId, slotIndex, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    local PARepairSavedVars = PAR.SavedVars

    -- check if it is enabled
    if bagId == BAG_WORN and PARepairSavedVars.RechargeWeapons.useSoulGems then
        local itemType = GetItemType(bagId, slotIndex)
        local rechargeable = IsItemChargeable(bagId, slotIndex)
        -- check if it s a weapon and if it is chargeable
        if rechargeable and itemType == ITEMTYPE_WEAPON then
            local charges, maxCharges = GetChargeInfoForItem(bagId , slotIndex)
            -- might need to be increased, because once it reaches 0; this event [INVENTORY_UPDATE_REASON_ITEM_CHARGE] is no longer triggered!
            if charges <= 1 then
                local gemTable, totalGemCount = _getSoulGemsIn(BAG_BACKPACK)
                if totalGemCount > 0 then
                    local firstSoulGem = gemTable[1]
                    local chargeableAmount = GetAmountSoulGemWouldChargeItem(bagId, slotIndex, firstSoulGem.bagId, firstSoulGem.slotIndex)
                    local finalChargesPerc = 100
                    if (charges + chargeableAmount) < maxCharges then
                        finalChargesPerc = PAHF.round(100 / maxCharges * (charges + chargeableAmount))
                    end

                    -- some debug information
                    PAR.debugln("Want to charge: %s with: %s for %d from currently: %d/%d", GetItemName(bagId, slotIndex), firstSoulGem.itemName, chargeableAmount, charges, maxCharges)

                    -- actually charge the item
                    ChargeItemWithSoulGem(bagId, slotIndex, firstSoulGem.bagId, firstSoulGem.slotIndex)
                    totalGemCount = totalGemCount - 1

                    local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)
                    local chargePerc = PAHF.round(100 / maxCharges * charges, 2)

                    -- show output to chat
                    PAR.println(SI_PA_CHAT_REPAIR_CHARGE_WEAPON, itemLink, chargePerc, finalChargesPerc, firstSoulGem.itemLink)
                end

                -- check remaining soul gems
                local lowSoulGemThreshold = PARepairSavedVars.RechargeWeapons.lowSoulGemThreshold
                if totalGemCount <= lowSoulGemThreshold and PARepairSavedVars.RechargeWeapons.lowSoulGemWarning then
                    local formatted = zo_strformat(GetString(SI_PA_PATTERN_SOULGEM_COUNT), totalGemCount)

                    if totalGemCount == 0 then
                        -- if no soul gems left, have a orange-red message (but only every 10 minutes)
                        local gameTimeMilliseconds = GetGameTimeMilliseconds()
                        local gameTimeMillisecondsPassed = gameTimeMilliseconds - _lastNoSoulGemWarningGameTime
                        local gameTimeMinutesPassed = gameTimeMillisecondsPassed / 1000 / 60
                        if gameTimeMinutesPassed >= 10 then
                            _lastNoSoulGemWarningGameTime = gameTimeMilliseconds
                            PAR.println(formatted, PAC.COLORS.ORANGE_RED, PAC.COLORS.ORANGE_RED)
                        end
                    elseif totalGemCount <= lowSoulGemThreshold then
                        if totalGemCount <= 5 then
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


-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Repair = PA.Repair or {}
PA.Repair.RechargeEquippedWeaponsWithSoulGems = RechargeEquippedWeaponsWithSoulGems
