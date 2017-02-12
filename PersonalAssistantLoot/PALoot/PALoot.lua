--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 06.02.2017
-- Time: 20:00
--

PAL.alreadyHarvesting = false
PAL.alreadyFishing = false;

function PAL.OnReticleTargetChanged()
    -- check if addon is enabled
    if PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled then
        local type = GetInteractionType()
        local active = IsPlayerInteractingWithObject()
        local isHarvesting = (active and (type == INTERACTION_HARVEST))
        local isFishing = (active and (type == INTERACTION_FISH))


        if (PAL.alreadyHarvesting) then
            if (not isHarvesting) then
                -- stopped harvesting
                PAL.alreadyHarvesting = false
                -- DEBUG
                -- PAL.println("isHarvesting=%s   type=%s", tostring(isHarvesting), tostring(type))
            end
        else
            if (isHarvesting) then
                -- started harvesting
                PAL.alreadyHarvesting = true
                -- DEBUG
                -- PAL.println("isHarvesting=%s   type=%s", tostring(isHarvesting), tostring(type))
            end
        end

        if (PAL.alreadyFishing) then
            if (not isFishing) then
                -- stopped fishing
                PAL.alreadyFishing = false
                -- DEBUG
                -- PAL.println("isFishing=%s   type=%s", tostring(isFishing), tostring(type))
            end
        else
            if (isFishing) then
                -- started fishing
                PAL.alreadyFishing = true
                -- DEBUG
                -- PAL.println("isFishing=%s   type=%s", tostring(isFishing), tostring(type))
            end
        end

    end
end

function PAL.OnLootUpdated()
    local activeProfile = PA.savedVars.General.activeProfile

    -- check if addon is enabled
    if PA.savedVars.Loot[activeProfile].enabled then
        -- check if ItemLoot is enabled
        if PA.savedVars.Loot[activeProfile].lootItems then
            -- check if we are harvesting, auto-loot is only used for this case!
            if (PAL.alreadyHarvesting or PAL.alreadyFishing) then
                -- get number of lootable items
                local lootCount =  GetNumLootItems()

                -- loop through all of them
                for i = 1, lootCount do
                    local lootId, _, icon, itemCount = GetLootItemInfo(i)
                    local itemLink = GetLootItemLink(lootId, LINK_STYLE_BRACKETS)
                    local itemType = GetItemLinkItemType(itemLink)
                    local strItemType = PALocale.getResourceMessage(itemType)

                    -- DEBUG
                    -- PAL.println("itemType (%s): %s.", itemType, strItemType)

                    -- TODO: also check for stolen???

                    for currItemType = 1, #PALoItemTypes do
                        -- check if the itemType is configured for auto-loot
                        if (PALoItemTypes[currItemType] == itemType) then
                            -- then check if it is set to Auto-Loot
                            if (PA.savedVars.Loot[activeProfile].ItemTypes[itemType] == PAC_ITEMTYPE_LOOT) then
                                -- Loot the item
                                LootItemById(lootId)
                                if (not PA.savedVars.Loot[activeProfile].hideItemLootMsg) then
                                    local iconString = "|t16:16:"..icon.."|t "
                                    PAL.println(PALocale.getResourceMessage("PAL_ItemLooted"), itemCount, itemLink, iconString)
                                end
                            end
                            break
                        end
                    end
                end
            end
        end

        -- check if GoldLoot is enabled
        if PA.savedVars.Loot[activeProfile].lootGold then
            -- is there even gold to loot?
            local unownedMoney = GetLootMoney()
            if (unownedMoney > 0) then
                -- Loot the gold
                LootMoney()
                if (not PA.savedVars.Loot[activeProfile].hideGoldLootMsg) then
                    PAL.println(PALocale.getResourceMessage("PAL_GoldLooted"), unownedMoney, PAC_ICON_GOLD)
                end
            end
        end


        -- TODO: Loot other currencies:
        -- GetLootCurrency(number CurrencyType type)
        -- Returns: number unownedCurrency, number ownedCurrency

        -- LootCurrency(number CurrencyType type)

        -- CURT_ALLIANCE_POINTS
        -- CURT_MONEY
        -- CURT_NONE
        -- CURT_TELVAR_STONES
        -- CURT_WRIT_VOUCHERS

    end
end

function PAL.println(key, ...)
    if (not PA.savedVars.Loot[PA.savedVars.General.activeProfile].hideAllMsg) then
        local args = {...}
        PAHF.println(key, unpack(args))
    end
end

