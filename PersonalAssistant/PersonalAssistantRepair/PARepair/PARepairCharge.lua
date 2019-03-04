-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
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

local function OnInventorySingleSlotUpdate(eventCode, bagId, slotIndex, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    local PARepairSavedVars = PASV.Repair[PA.activeProfile]

    -- check fi it is enabled
    if bagId == BAG_WORN and PARepairSavedVars.RechargeWeapons.useSoulGems then
        local itemType = GetItemType(bagId, slotIndex)
        local rechargeable = IsItemChargeable(bagId, slotIndex)
        -- check if it s a weapon and if it is chargeable
        if rechargeable and itemType == ITEMTYPE_WEAPON then
            local charges, maxCharges = GetChargeInfoForItem(bagId , slotIndex)
            if charges <= 0 then
                local gemTable, totalGemCount = _getSoulGemsIn(BAG_BACKPACK)
                if totalGemCount > 0 then
                    local chargeableAmount = GetAmountSoulGemWouldChargeItem(bagId, slotIndex, BAG_BACKPACK, gemTable[#gemTable].slotIndex)
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

                    -- show output to chat (depending on setting)
                    local chargeWeaponsChatMode = PARepairSavedVars.RechargeWeapons.chargeWeaponsChatMode
                    if (chargeWeaponsChatMode == PAC.CHATMODE.OUTPUT_MAX) then PAHF.println(GetString(SI_PA_REPAIR_CHARGE_CHATMODE_MAX), iconString, itemLink, chargePerc, finalChargesPerc, gemTable[#gemTable].iconString, gemTable[#gemTable].itemLink)
                    elseif (chargeWeaponsChatMode == PAC.CHATMODE.OUTPUT_NORMAL) then PAHF.println(GetString(SI_PA_REPAIR_CHARGE_CHATMODE_NORMAL), itemLink, chargePerc, finalChargesPerc, gemTable[#gemTable].itemLink)
                    elseif (chargeWeaponsChatMode == PAC.CHATMODE.OUTPUT_MIN) then PAHF.println(GetString(SI_PA_REPAIR_CHARGE_CHATMODE_MIN), gemTable[#gemTable].iconString, iconString, chargePerc, finalChargesPerc)
                    end -- PAC.CHATMODE.OUTPUT_NONE => no chat output
                end

                -- check remaining soul gems
                if totalGemCount <= 10 and PARepairSavedVars.RechargeWeapons.lowSoulGemWarning  then
                    local gameTimeMilliseconds = GetGameTimeMilliseconds()
                    local gameTimeMillisecondsPassed = gameTimeMilliseconds - _lastNoSoulGemWarningGameTime
                    local gameTimeMinutesPassed = gameTimeMillisecondsPassed / 1000 / 60

                    if (gameTimeMinutesPassed >= 10) then
                        _lastNoSoulGemWarningGameTime = gameTimeMilliseconds

                        if totalGemCount > 0 then
                            PAHF.println(SI_PA_REPAIR_CHARGE_LOW_GEM_COUNT, totalGemCount)
                        else
                            PAHF.println(SI_PA_REPAIR_CHARGE_NO_GEM_COUNT)
                        end
                    end
                end
            end
        end
    end
end


-- Export
PA.Repair = PA.Repair or {}
PA.Repair.OnInventorySingleSlotUpdate = OnInventorySingleSlotUpdate