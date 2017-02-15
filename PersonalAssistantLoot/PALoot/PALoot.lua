--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 06.02.2017
-- Time: 20:00
--

-- TODO
-- - handle Bait when looting (loot, loot'n'destroy, ignore)
-- - loot raw material from mobs

PAL.alreadyHarvesting = false
PAL.alreadyFishing = false
PAL.alreadyLooting = false

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
                if (PA.debug) then
                    PAL.println("isHarvesting=%s   type=%s", tostring(isHarvesting), tostring(type))
                end
            end
        else
            if (isHarvesting) then
                -- started harvesting
                PAL.alreadyHarvesting = true
                -- DEBUG
                if (PA.debug) then
                    PAL.println("isHarvesting=%s   type=%s", tostring(isHarvesting), tostring(type))
                end
            end
        end

        if (PAL.alreadyFishing) then
            if (not isFishing) then
                -- stopped fishing
                PAL.alreadyFishing = false
                -- DEBUG
                if (PA.debug) then
                    PAL.println("isFishing=%s   type=%s", tostring(isFishing), tostring(type))
                end
            end
        else
            if (isFishing) then
                -- started fishing
                PAL.alreadyFishing = true
                -- DEBUG
                if (PA.debug) then
                    PAL.println("isFishing=%s   type=%s", tostring(isFishing), tostring(type))
                end
            end
        end

        if (not isHarvesting and not isFishing) then
            if (type ~= INTERACTION_NONE) then

                PAL.alreadyLooting = isLooting

                if (PA.debug) then
                    PAL.println("new interactionType=%s with %s", tostring(type), GetUnitNameHighlightedByReticle())
                end
            end
        end

    end
end


function PAL.OnLootUpdated()
    local activeProfile = PA.savedVars.General.activeProfile

    -- check if addon is enabled
    if PA.savedVars.Loot[activeProfile].enabled then
        -- check if ItemLoot is enabled
        if PA.savedVars.Loot[activeProfile].lootItemsEnabled then
            -- check if we are harvesting, auto-loot is only used for this case!
            if (PAL.alreadyHarvesting or PAL.alreadyFishing) then
                -- get number of lootable items
                local lootCount =  GetNumLootItems()

                -- loop through all of them
                for i = 1, lootCount do
                    local lootId, _, icon, itemCount = GetLootItemInfo(i)
                    local iconString = "|t20:20:"..icon.."|t "
                    local itemLink = GetLootItemLink(lootId, LINK_STYLE_BRACKETS)
                    local itemType = GetItemLinkItemType(itemLink)
                    local strItemType = PALocale.getResourceMessage(itemType)

                    local itemLooted = false

                    -- DEBUG
                    if (PA.debug) then
                        PAL.println("itemType (%s): %s.", itemType, strItemType)
                    end

                    -- TODO: Handle BAIT
                    -- return PA.savedVars.Loot[PA.savedVars.General.activeProfile].harvestableBaitLootMode

                    -- TODO: also check for stolen???

                    -- check for ores, herbs, wood etc
                    for currItemType = 1, #PALHarvestableItemTypes do
                        -- check if the itemType is configured for auto-loot
                        if (PALHarvestableItemTypes[currItemType] == itemType) then
                            -- then check if it is set to Auto-Loot
                            if (PA.savedVars.Loot[activeProfile].HarvestableItemTypes[itemType] == PAC_ITEMTYPE_LOOT) then
                                -- Loot the item
                                LootItemById(lootId)
                                itemLooted = true
                            end
                            break
                        end
                    end

                    -- check for bait
                    if (itemType == ITEMTYPE_LURE) then
                        local harvestableBaitLootMode = PAMenu_Functions.getFunc.PALoot.harvestableBaitLootMode()

                        if (PA.debug) then
                            PAL.println("itemType (%s): harvestableBaitLootMode=%s.", itemType, harvestableBaitLootMode)
                        end

                        if (harvestableBaitLootMode ~= PAC_ITEMTYPE_IGNORE) then
                            -- Loot the item
                            LootItemById(lootId)
                            itemLooted = true
                            if (harvestableBaitLootMode == PAC_ITEMTYPE_DESTROY) then
                                -- Also destroy it (set itemLooted to false in this case)
                                itemLooted = false
                            end
                        end
                    end

                    -- check if an item was looted
                    if (itemLooted) then
                        -- show output to chat (depending on setting)
                        local lootItemsChatMode = PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItemsChatMode
                        if (lootItemsChatMode == PA_OUTPUT_TYPE_FULL) then PAL.println(PALocale.getResourceMessage("PAL_Items_ChatMode_Full"), itemCount, itemLink, iconString)
                        elseif (lootItemsChatMode == PA_OUTPUT_TYPE_NORMAL) then PAL.println(PALocale.getResourceMessage("PAL_Items_ChatMode_Normal"), itemCount, itemLink, iconString)
                        elseif (lootItemsChatMode == PA_OUTPUT_TYPE_MIN) then PAL.println(PALocale.getResourceMessage("PAL_Items_ChatMode_Min"), itemCount, iconString)
                        end -- PA_OUTPUT_TYPE_NONE => no chat output
                    end
                end
            else
                -- DEBUG
                if (PA.debug) then
                    PAL.println("looting enemy? --> %s --> IsLooting()=%s", GetUnitNameHighlightedByReticle(), tostring(IsLooting()))
                    -- examples:
                    -- torchbug / wasps
                    -- chests
                end
            end
        end

        -- check if GoldLoot is enabled
        if PA.savedVars.Loot[activeProfile].lootGoldEnabled then
            -- is there even gold to loot?
            local unownedMoney = GetLootMoney()
            if (unownedMoney > 0) then
                -- Loot the gold
                LootMoney()

                -- show output to chat (depending on setting)
                local lootGoldChatMode = PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootGoldChatMode
                if (lootGoldChatMode == PA_OUTPUT_TYPE_FULL) then PAL.println(PALocale.getResourceMessage("PAL_Gold_ChatMode_Full"), unownedMoney)
                elseif (lootGoldChatMode == PA_OUTPUT_TYPE_NORMAL) then PAL.println(PALocale.getResourceMessage("PAL_Gold_ChatMode_Normal"), unownedMoney)
                elseif (lootGoldChatMode == PA_OUTPUT_TYPE_MIN) then PAL.println(PALocale.getResourceMessage("PAL_Gold_ChatMode_Min"), unownedMoney)
                end -- PA_OUTPUT_TYPE_NONE => no chat output
            end
        end


        -- TODO: Loot other currencies:
        -- GetLootCurrency(number CurrencyType type)
        -- Returns: number unownedCurrency, number ownedCurrency

        -- LootCurrency(number CurrencyType type)

        -- CURT_ALLIANCE_POINTS
        -- CURT_TELVAR_STONES

    end
end


function PAL.OnInventorySingleSlotUpdate(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    local activeProfile = PA.savedVars.General.activeProfile

    -- check if addon is enabled
    if PA.savedVars.Loot[activeProfile].enabled then
        -- check if ItemLoot is enabled
        if PA.savedVars.Loot[activeProfile].lootItemsEnabled then
            -- check if the updated happened in the backpack
            if (bagId == BAG_BACKPACK) then
                -- only proceed if the update was triggered while harvesting (i.e. not from looting chests, wasps, mobs, etc)
                if (PAL.alreadyHarvesting) then
                    -- get the itemType
                    local itemType = GetItemType(BAG_BACKPACK, slotId)

                    -- check if it is bait, and if bait is set to be destroyed
                    if ((itemType == ITEMTYPE_LURE) and (PAMenu_Functions.getFunc.PALoot.harvestableBaitLootMode() == PAC_ITEMTYPE_DESTROY)) then

                        local itemLink =  GetItemLink(BAG_BACKPACK, slotId, LINK_STYLE_BRACKETS)

                        local stackSize, maxStacksize = GetSlotStackSize(BAG_BACKPACK, slotId)
                        if (stackSize > stackCountChange) then
                            -- there already was a stack existing in the inventory, we can only delete the new items
                            local firstEmptySlot = FindFirstEmptySlotInBag(BAG_BACKPACK)
                            if (firstEmptySlot ~= nil) then
                                -- there is a free slot to split the stack, go ahead!
                                -- TODO: copy to new stack and only destroy that?

                                local result = CallSecureProtected("RequestMoveItem", BAG_BACKPACK, slotId, BAG_BACKPACK, firstEmptySlot, stackCountChange)

                                -- give it some time to actually move the item
                                zo_callLater(function()
                                    if (result) then
                                        DestroyItem(BAG_BACKPACK, firstEmptySlot)

                                        -- DEBUG
                                        if (PA.debug) then
                                            PAL.println("Item destroyed --> %d x %s      %d should remain in inventory", stackCountChange, itemLink, stackSize - stackCountChange)
                                        end

                                    else
                                        -- could not move items
                                        -- TODO: log error

                                        -- DEBUG
                                        if (PA.debug) then
                                            PAL.println("cannot move Item! --> %s      %d/%d were looted", itemLink, stackCountChange, stackSize)
                                        end
                                    end
                                end, 500)
                            else
                                -- no free slot available, cannot safely destry item!
                                -- TODO: log error

                                -- DEBUG
                                if (PA.debug) then
                                    PAL.println("cannot destroy Item! --> %s      %d/%d were looted", itemLink, stackCountChange, stackSize)
                                end
                            end
                        else
                            -- destroy all items (since there were no existing before)
                            DestroyItem(BAG_BACKPACK, firstEmptySlot)

                            -- DEBUG
                            if (PA.debug) then
                                PAL.println("Item destroyed --> %s      %d were looted. nothing left in inventory", itemLink, stackCountChange)
                            end
                        end
                    end
                end
            end
        end
    end
end

function PAL.println(key, ...)
    local args = {...}
    PAHF.println(key, unpack(args))
end

