--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 06.02.2017
-- Time: 20:00
--

PAL.alreadyHarvesting = false
PAL.alreadyFishing = false
PAL.alreadyLooting = false

function PAL.OnReticleTargetChanged()
    if (PAHF.hasActiveProfile()) then
        -- check if addon is enabled
        if PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled then
            local type = GetInteractionType()
            local active = IsPlayerInteractingWithObject()

            local isHarvesting = (active and (type == INTERACTION_HARVEST))
            local isFishing = (active and (type == INTERACTION_FISH))

            if (PAL.alreadyHarvesting) then
                if (not isHarvesting) then
                    -- stopped harvesting
                    PAL.alreadyHarvesting = false
                    PAHF_DEBUG.debugln("isHarvesting=%s   type=%s", tostring(isHarvesting), tostring(type))
                end
            else
                if (isHarvesting) then
                    -- started harvesting
                    PAL.alreadyHarvesting = true
                    PAHF_DEBUG.debugln("isHarvesting=%s   type=%s", tostring(isHarvesting), tostring(type))
                end
            end

            if (PAL.alreadyFishing) then
                if (not isFishing) then
                    -- stopped fishing
                    PAL.alreadyFishing = false
                    PAHF_DEBUG.debugln("isFishing=%s   type=%s", tostring(isFishing), tostring(type))
                end
            else
                if (isFishing) then
                    -- started fishing
                    PAL.alreadyFishing = true
                    PAHF_DEBUG.debugln("isFishing=%s   type=%s", tostring(isFishing), tostring(type))
                end
            end

            if (not isHarvesting and not isFishing) then
                if (type ~= INTERACTION_NONE) then
                    -- neither harvesting nor fishing => looting
                    -- TODO: check if really required?
                    PAL.alreadyLooting = isLooting
                    PAHF_DEBUG.debugln("new interactionType=%s with %s", tostring(type), GetUnitNameHighlightedByReticle())
                end
            end
        end
    end
end


function PAL.OnLootUpdated()
    if (PAHF.hasActiveProfile()) then
        local activeProfile = PA.savedVars.Profile.activeProfile

        -- check if addon is enabled
        if PA.savedVars.Loot[activeProfile].enabled then
            -- check if ItemLoot is enabled
            if PA.savedVars.Loot[activeProfile].lootItemsEnabled then
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

                    PAHF_DEBUG.debugln("itemType (%s): %s.", itemType, strItemType)
                    -- TODO: also check for stolen???

                    -- check if we are harvesting, auto-loot is only used for this case!
                    if (PAL.alreadyHarvesting or PAL.alreadyFishing) then
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
                            PAHF_DEBUG.debugln("itemType (%s): harvestableBaitLootMode=%s.", itemType, harvestableBaitLootMode)

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

                    else
                        -- not harvesting and not fishing, so most probably looting
                        PAHF_DEBUG.debugln("looting enemy? --> %s --> IsLooting()=%s", GetUnitNameHighlightedByReticle(), tostring(IsLooting()))
                        -- check for lootable item types (bait, provisioniug ingredients, and raw material)
                        for currItemType = 1, #PALLootableItemTypes do
                            -- check if the itemType is configured for auto-loot
                            if (PALLootableItemTypes[currItemType] == itemType) then
                                -- then check if it is set to Auto-Loot
                                if (PA.savedVars.Loot[activeProfile].LootableItemTypes[itemType] == PAC_ITEMTYPE_LOOT) then
                                    -- Loot the item
                                    LootItemById(lootId)
                                    itemLooted = true
                                end
                                break
                            end
                        end

                    end


                    -- check if an item was looted
                    if (itemLooted) then
                        -- show output to chat (depending on setting)
                        local lootItemsChatMode = PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsChatMode
                        if (lootItemsChatMode == PA_OUTPUT_TYPE_FULL) then PAHF.println(PALocale.getResourceMessage("PAL_Items_ChatMode_Full"), itemCount, itemLink, iconString)
                        elseif (lootItemsChatMode == PA_OUTPUT_TYPE_NORMAL) then PAHF.println(PALocale.getResourceMessage("PAL_Items_ChatMode_Normal"), itemCount, itemLink, iconString)
                        elseif (lootItemsChatMode == PA_OUTPUT_TYPE_MIN) then PAHF.println(PALocale.getResourceMessage("PAL_Items_ChatMode_Min"), itemCount, iconString)
                        end -- PA_OUTPUT_TYPE_NONE => no chat output
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
                    local lootGoldChatMode = PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootGoldChatMode
                    if (lootGoldChatMode == PA_OUTPUT_TYPE_FULL) then PAHF.println(PALocale.getResourceMessage("PAL_Gold_ChatMode_Full"), unownedMoney)
                    elseif (lootGoldChatMode == PA_OUTPUT_TYPE_NORMAL) then PAHF.println(PALocale.getResourceMessage("PAL_Gold_ChatMode_Normal"), unownedMoney)
                    elseif (lootGoldChatMode == PA_OUTPUT_TYPE_MIN) then PAHF.println(PALocale.getResourceMessage("PAL_Gold_ChatMode_Min"), unownedMoney)
                    end -- PA_OUTPUT_TYPE_NONE => no chat output
                end
            end
        end
    end
end


function PAL.OnInventorySingleSlotUpdate(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    if (PAHF.hasActiveProfile()) then
        local activeProfile = PA.savedVars.Profile.activeProfile

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
                            PAL.DestroyNumOfItems(BAG_BACKPACK, slotId, stackCountChange)
                        end
                    end
                end
            end
        end
    end
end


function PAL.DestroyNumOfItems(bagId, slotId, amountToDestroy)
    local itemDestroyed = false
    -- create the itemlink of the to be destroyed item
    local itemLink =  GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
    local icon =  GetItemLinkInfo(itemLink)
    local iconString = "|t20:20:"..icon.."|t "
    -- get the current size of item stack
    local stackSize = GetSlotStackSize(bagId, slotId)
    -- check if there were items before
    if (stackSize > amountToDestroy) then
        -- there already was a stack existing in the inventory, we shall only delete the new items
        local firstEmptySlot = FindFirstEmptySlotInBag(bagId)
        if (firstEmptySlot ~= nil) then
            -- there is a free slot to split the stack, go ahead!
            local result = CallSecureProtected("RequestMoveItem", bagId, slotId, bagId, firstEmptySlot, amountToDestroy)

            -- give it some time to actually move the item
            zo_callLater(function()
                if (result) then
                    -- item successfully moved to new empty stlot, destroy that now
                    DestroyItem(bagId, firstEmptySlot)
                    itemDestroyed = true
                else
                    -- could not move items, therefore cannot safely destroy item
                    PAHF.println(PALocale.getResourceMessage("PAL_ItemsDestroy_MoveFailed"), amountToDestroy, stackSize, itemLink, iconString)
                end
            end, 500)
        else
            -- no free slot available, cannot safely destroy item!
            PAHF.println(PALocale.getResourceMessage("PAL_ItemsDestroy_DestroyFailed"), amountToDestroy, stackSize, itemLink, iconString)
        end
    else
        -- destroy all items (since there were no existing before)
        DestroyItem(bagId, slotId)
        itemDestroyed = true
    end

    if (itemDestroyed) then
        PAHF_DEBUG.debugln("Item destroyed --> %d x %s      %d should remain in inventory", amountToDestroy, itemLink, stackSize - amountToDestroy)
        local lootItemsChatMode = PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsChatMode
        if (lootItemsChatMode == PA_OUTPUT_TYPE_FULL) then PAHF.println(PALocale.getResourceMessage("PAL_ItemsDestroy_Full"), amountToDestroy, itemLink, iconString)
        elseif (lootItemsChatMode == PA_OUTPUT_TYPE_NORMAL) then PAHF.println(PALocale.getResourceMessage("PAL_ItemsDestroy_Normal"), amountToDestroy, itemLink, iconString)
        elseif (lootItemsChatMode == PA_OUTPUT_TYPE_MIN) then PAHF.println(PALocale.getResourceMessage("PAL_ItemsDestroy_Min"), amountToDestroy, iconString)
        end -- PA_OUTPUT_TYPE_NONE => no chat output
    end
end
