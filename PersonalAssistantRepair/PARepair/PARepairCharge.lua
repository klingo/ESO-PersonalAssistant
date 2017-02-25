--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 19.02.2017
-- Time: 20:01
--

PAR_Charge = {}

-- =====================================================================================================================
-- =====================================================================================================================

local function GetSoulGemsIn(bagId)
    local bagCache = SHARED_INVENTORY:GetOrCreateBagCache(bagId)
    local gemTable = setmetatable({}, { __index = table })

    -- create a table with all soulgems
    for _, data in pairs(bagCache) do
        if (GetItemType(data.bagId, data.slotIndex) == ITEMTYPE_SOUL_GEM) then
            gemTable:insert({
--                bagId = data.bagId,
                slotIndex = data.slotIndex,
                itemName = data.name,
                itemLink = GetItemLink(data.bagId, data.slotIndex, LINK_STYLE_BRACKETS),
--                stackCount = data.stackCount,
                gemTier = GetSoulGemItemInfo(data.bagId, data.slotIndex),
                iconString = "|t20:20:"..data.iconFile.."|t ",
            })
        end
    end

    -- sort table based on the gemTiers
    table.sort(gemTable, function(a, b) return a.gemTier > b.gemTier end)

    return gemTable
end

-- =====================================================================================================================
-- =====================================================================================================================

function PAR_Charge.ReChargeWeapons()

    -- Check and re-charged equipped weapons
    if PA.savedVars.Repair[PA.activeProfile].chargeWeapons then

        local chargeThreshold = PA.savedVars.Repair[PA.activeProfile].chargeWeaponsThreshold
        local weaponsToCharge = setmetatable({}, { __index = table })

        -- based on the list of chargeable slots, check which ones really need to be charged
        for _, weaponSlot in pairs(PARWeaponSlots) do
            local charges, maxCharges = GetChargeInfoForItem(BAG_WORN, weaponSlot)
            local chargePerc = PAHF.round(1 / maxCharges * charges, 2)

            -- check if charge level of item is below threshold
            if ((chargePerc * 100) <= chargeThreshold) then
                local itemLink = GetItemLink(BAG_WORN, weaponSlot, LINK_STYLE_BRACKETS)
                local iconString = "|t20:20:"..GetItemLinkInfo(itemLink).."|t "
                weaponsToCharge:insert({weaponSlot = weaponSlot, charges = charges, maxCharges = maxCharges, chargePerc = chargePerc, itemLink = itemLink , iconString = iconString})
            end
        end

        -- are there weapons to charge?
        if (#weaponsToCharge > 0) then
            local gemTable = GetSoulGemsIn(BAG_BACKPACK)

            -- from the list of actually to be charged weapons, charge them
            for _, weapon in pairs(weaponsToCharge) do
                -- collect some additional information
                local chargeableAmount = GetAmountSoulGemWouldChargeItem(BAG_WORN, weapon.weaponSlot, BAG_BACKPACK, gemTable[#gemTable].slotIndex)
                local finalChargesPerc = 100
                if ((weapon.charges + chargeableAmount) < weapon.maxCharges) then
                    finalChargesPerc = PAHF.round(100 / weapon.maxCharges * (weapon.charges + chargeableAmount))
                end

                -- some debug information
                PAHF_DEBUG.debugln("Want to charge: %s with: %s for %d from currently: %d/%d", GetItemName(BAG_WORN, weapon.weaponSlot), gemTable[#gemTable].itemName, chargeableAmount, weapon.charges, weapon.maxCharges)

                -- inform the player
                PAHF.println("PAR_ReChargeWeapon_ChatMode_Full", weapon.itemLink, weapon.iconString, gemTable[#gemTable].itemLink, gemTable[#gemTable].iconString, weapon.chargePerc, finalChargesPerc)

                -- actually charge the item
                ChargeItemWithSoulGem(BAG_WORN, weapon.weaponSlot, BAG_BACKPACK, gemTable[#gemTable].slotIndex)
            end
        end

--        GetAmountSoulGemWouldChargeItem(number itemToChargeBagId, number itemToChargeSlotIndex, number soulGemToConsumeBagId, number soulGemToConsumeSlotIndex)
--        Returns: number chargeAmount
--
--        ChargeItemWithSoulGem(number itemToChargeBagId, number itemToChargeSlotIndex, number soulGemToConsumeBagId, number soulGemToConsumeSlotIndex)
--
--        IsItemSoulGem(number SoulGemType soulGemType, number bagId, number slotIndex)
--        Returns: boolean isSoulGem
--
--        GetSoulGemItemInfo(number bagId, number slotIndex)
--        Returns: number tier, number SoulGemType soulGemType
--
--        GetSoulGemInfo(number SoulGemType soulGemType, number targetLevel, boolean onlyInInventory)
--        Returns: string name, textureName icon, number stackCount, number ItemQuality quality

    end

end