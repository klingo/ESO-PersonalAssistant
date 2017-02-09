--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 06.02.2017
-- Time: 20:00
--

PALo = {}

PALo.alreadyHarvesting = false
PALo.alreadyFishing = false;

function PALo.OnReticleTargetChanged()
    -- check if addon is enabled
    if PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled then
        local type = GetInteractionType()
        local active = IsPlayerInteractingWithObject()
        local isHarvesting = (active and (type == INTERACTION_HARVEST))
        local isFishing = (active and (type == INTERACTION_FISH))


        if (PALo.alreadyHarvesting) then
            if (not isHarvesting) then
                -- stopped harvesting
                PALo.alreadyHarvesting = false
                -- DEBUG
                -- PALo.println("isHarvesting=%s   type=%s", tostring(isHarvesting), tostring(type))
            end
        else
            if (isHarvesting) then
                -- started harvesting
                PALo.alreadyHarvesting = true
                -- DEBUG
                -- PALo.println("isHarvesting=%s   type=%s", tostring(isHarvesting), tostring(type))
            end
        end

        if (PALo.alreadyFishing) then
            if (not isFishing) then
                -- stopped fishing
                PALo.alreadyFishing = false
                -- DEBUG
                -- PALo.println("isFishing=%s   type=%s", tostring(isFishing), tostring(type))
            end
        else
            if (isFishing) then
                -- started fishing
                PALo.alreadyFishing = true
                -- DEBUG
                -- PALo.println("isFishing=%s   type=%s", tostring(isFishing), tostring(type))
            end
        end

    end
end

function PALo.OnLootUpdated()
    -- check if addon is enabled
    if PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].enabled then
        -- check if ItemLoot is enabled
        if PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].lootItems then
            -- check if we are harvesting, auto-loot is only used for this case!
            if (PALo.alreadyHarvesting or PALo.alreadyFishing) then
                -- get number of lootable items
                local lootCount =  GetNumLootItems()

                -- loop through all of them
                for i = 1, lootCount do
                    local lootId, _, _, itemCount = GetLootItemInfo(i)
                    local itemLink = GetLootItemLink(lootId, LINK_STYLE_BRACKETS)
                    local itemType = GetItemLinkItemType(itemLink)
                    local strItemType = PAL.getResourceMessage(itemType)

                    -- DEBUG
                    -- PALo.println("itemType (%s): %s.", itemType, strItemType)

                    -- TODO: also check for stolen???

                    for currItemType = 1, #PALoItemTypes do
                        -- check if the itemType is configured for auto-loot
                        if (PALoItemTypes[currItemType] == itemType) then
                            -- then check if it is set to Auto-Loot
                            if (PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].ItemTypes[itemType] == PAC_ITEMTYPE_LOOT) then
                                -- Loot the item
                                LootItemById(lootId)
                                if (not PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].hideItemLootMsg) then
                                    PALo.println(PAL.getResourceMessage("PALo_ItemLooted"), itemCount, itemLink)
                                end
                            end
                            break
                        end
                    end
                end
            end
        end

        -- check if GoldLoot is enabled
        if PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].lootGold then
            -- is there even gold to loot?
            local unownedMoney = GetLootMoney()
            if (unownedMoney > 0) then
                -- Loot the gold
                LootMoney()
                if (not PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].hideGoldLootMsg) then
                    PALo.println(PAL.getResourceMessage("PALo_GoldLooted"), unownedMoney)
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

function PALo.println(key, ...)
    if (not PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].hideAllMsg) then
        local args = {...}
        PA.println(key, unpack(args))
    end
end

