-- Local instances of Global tables --
local PA = PersonalAssistant
local PAR = PA.Repair
local PASV = PA.SavedVars
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local _lastNoSoulGemWarningGameTime = 0

-- --------------------------------------------------------------------------------------------------------------------

local function _getSoulGemsIn(bagId)
    local bagCache = SHARED_INVENTORY:GetOrCreateBagCache(bagId) -- TODO: updateto use soul-gem filtertpye
    local gemTable = setmetatable({}, { __index = table })
    local totalGemCount = 0

    -- create a table with all soulgems
    for _, data in pairs(bagCache) do
        -- check if it is a filled soulGem
        if (IsItemSoulGem(SOUL_GEM_TYPE_FILLED, data.bagId, data.slotIndex)) then
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

    -- sort table based on the gemTiers
    table.sort(gemTable, function(a, b) return a.gemTier > b.gemTier end)

    return gemTable, totalGemCount
end

-- ---------------------------------------------------------------------------------------------------------------------

local function RechargeEquippedWeaponsWithSoulGems(eventCode, bagId, slotIndex, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    local PARepairSavedVars = PASV.Repair[PA.activeProfile]

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
                    local chargeableAmount = GetAmountSoulGemWouldChargeItem(bagId, slotIndex, gemTable[#gemTable].bagId, gemTable[#gemTable].slotIndex)
                    local finalChargesPerc = 100
                    if ((charges + chargeableAmount) < maxCharges) then
                        finalChargesPerc = PAHF.round(100 / maxCharges * (charges + chargeableAmount))
                    end

                    -- some debug information
                    PAHF.debugln("Want to charge: %s with: %s for %d from currently: %d/%d", GetItemName(bagId, slotIndex), gemTable[#gemTable].itemName, chargeableAmount, charges, maxCharges)

                    -- actually charge the item
                    ChargeItemWithSoulGem(bagId, slotIndex, gemTable[#gemTable].bagId, gemTable[#gemTable].slotIndex)
                    totalGemCount = totalGemCount - 1

                    local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)
                    local iconString = "|t20:20:"..GetItemLinkInfo(itemLink).."|t "
                    local chargePerc = PAHF.round(100 / maxCharges * charges, 2)

                    -- show output to chat
                    PAR.println(GetString(SI_PA_CHAT_REPAIR_CHARGE_WEAPON), itemLink, chargePerc, finalChargesPerc, gemTable[#gemTable].itemLink)
                end

                -- check remaining soul gems
                if totalGemCount <= 10 and PARepairSavedVars.RechargeWeapons.lowSoulGemWarning then
                    local gameTimeMilliseconds = GetGameTimeMilliseconds()
                    local gameTimeMillisecondsPassed = gameTimeMilliseconds - _lastNoSoulGemWarningGameTime
                    local gameTimeMinutesPassed = gameTimeMillisecondsPassed / 1000 / 60

                    if (gameTimeMinutesPassed >= 10) then
                        _lastNoSoulGemWarningGameTime = gameTimeMilliseconds

                        if totalGemCount > 0 then
                            PAR.println(SI_PA_CHAT_REPAIR_CHARGE_LOW_GEM_COUNT, totalGemCount)
                        else
                            PAR.println(SI_PA_CHAT_REPAIR_CHARGE_NO_GEM_COUNT)
                        end
                    end
                end
            end
        end
    end
end


-- Export
PA.Repair = PA.Repair or {}
PA.Repair.RechargeEquippedWeaponsWithSoulGems = RechargeEquippedWeaponsWithSoulGems