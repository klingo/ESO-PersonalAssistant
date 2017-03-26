--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 06.02.2017
-- Time: 20:00
--

local alreadyHarvesting = false
local alreadyFishing = false
local alreadyOnLootUpdated = false

-- =====================================================================================================================
-- =====================================================================================================================

local function DestroyNumOfItems(bagId, slotId, amountToDestroy)
    local itemDestroyed = false
    -- create the itemlink of the to be destroyed item
    local itemLink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
    local icon = GetItemLinkInfo(itemLink)
    local iconString = "|t20:20:" .. icon .. "|t "
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
        local lootItemsChatMode = PA.savedVars.Loot[PA.activeProfile].lootItemsChatMode
        if (lootItemsChatMode == PA_OUTPUT_TYPE_FULL) then PAHF.println(PALocale.getResourceMessage("PAL_ItemsDestroy_Full"), amountToDestroy, itemLink, iconString)
        elseif (lootItemsChatMode == PA_OUTPUT_TYPE_NORMAL) then PAHF.println(PALocale.getResourceMessage("PAL_ItemsDestroy_Normal"), amountToDestroy, itemLink, iconString)
        elseif (lootItemsChatMode == PA_OUTPUT_TYPE_MIN) then PAHF.println(PALocale.getResourceMessage("PAL_ItemsDestroy_Min"), amountToDestroy, iconString)
        end -- PA_OUTPUT_TYPE_NONE => no chat output
    end
end

local function isLockpick(itemName)
end



local function LootGold()
    -- is there even gold to loot?
    local unownedMoney = GetLootMoney()
    if (unownedMoney > 0) then
        -- Loot the gold
        LootMoney()
        -- show output to chat (depending on setting)
        local lootGoldChatMode = PA.savedVars.Loot[PA.activeProfile].lootGoldChatMode
        if (lootGoldChatMode == PA_OUTPUT_TYPE_FULL) then PAHF.println(PALocale.getResourceMessage("PAL_Gold_ChatMode_Full"), unownedMoney)
        elseif (lootGoldChatMode == PA_OUTPUT_TYPE_NORMAL) then PAHF.println(PALocale.getResourceMessage("PAL_Gold_ChatMode_Normal"), unownedMoney)
        elseif (lootGoldChatMode == PA_OUTPUT_TYPE_MIN) then PAHF.println(PALocale.getResourceMessage("PAL_Gold_ChatMode_Min"), unownedMoney)
        end -- PA_OUTPUT_TYPE_NONE => no chat output
    end
end


local function LootItemIfAllowed(lootId, isItemStolen)
    -- TODO: CHECK FOR FREE SLOT!

    -- if item is NOT stolen, looting is allowed
    if (not isItemStolen) then
        LootItemById(lootId)
        return true
    end

    -- if item IS stolen, but looting stolen items is enabled, looting is allowed
    if (isItemStolen and PA.savedVars.Loot[PA.activeProfile].lootStolenItemsEnabled) then
        LootItemById(lootId)
        return true
    end

    -- in all other cases return 'false'
    return false
end


-- =====================================================================================================================
-- =====================================================================================================================

-- TODO: might not be needed anymore
function PAL.OnReticleTargetChanged()
    local type = GetInteractionType()
    local active = IsPlayerInteractingWithObject()

    alreadyHarvesting = (active and (type == INTERACTION_HARVEST))
    alreadyFishing = (active and (type == INTERACTION_FISH))
end


function PAL.OnLootUpdated()
    if (PAHF.hasActiveProfile()) then

        -- check if addon is enabled
        if PA.savedVars.Loot[PA.activeProfile].enabled then

            -- check if there isn't already a OnLootUpdate running
            if (not alreadyOnLootUpdated) then
                alreadyOnLootUpdated = true

                -- check if ItemLoot is enabled
                if PA.savedVars.Loot[PA.activeProfile].lootItemsEnabled then
                    -- get number of lootable items
                    local lootCount = GetNumLootItems()

                    -- loop through all of them
                    for i = lootCount, 1, -1 do
                        local lootId, itemName, icon, itemCount, _, _, isQuest, isStolen = GetLootItemInfo(i)
                        local iconString = "|t20:20:" .. icon .. "|t "
                        local itemLink = GetLootItemLink(lootId, LINK_STYLE_BRACKETS)
                        local itemType = GetItemLinkItemType(itemLink)
                        local strItemType = PALocale.getResourceMessage(itemType)
                        local itemLooted = false
                        local suffixDesc = ""

                        PAHF_DEBUG.debugln("% s--> itemType (%s): %s. isQuest=%s isStolen=%s", itemLink, itemType, strItemType, tostring(isQuest), tostring(isStolen))

                        -- check for ores, herbs, wood etc
                        for currItemType = 1, #PALHarvestableItemTypes do
                            -- check if the itemType is configured for auto-loot
                            if (PALHarvestableItemTypes[currItemType] == itemType) then
                                -- then check if it is set to Auto-Loot
                                if (PA.savedVars.Loot[PA.activeProfile].HarvestableItemTypes[itemType] == PAC_ITEMTYPE_LOOT) then
                                    -- Loot the item
                                    itemLooted = LootItemIfAllowed(lootId, isStolen)
                                end
                                break
                            end
                        end

                        -- check for bait
                        -- TODO: double check this setting as it is integrated into lootable item types as well
                        if (itemType == ITEMTYPE_LURE) then
                            local harvestableBaitLootMode = PAMenu_Functions.getFunc.PALoot.harvestableBaitLootMode()
                            PAHF_DEBUG.debugln("itemType (%s): harvestableBaitLootMode=%s.", itemType, harvestableBaitLootMode)

                            if (harvestableBaitLootMode ~= PAC_ITEMTYPE_IGNORE) then
                                -- Loot the item
                                itemLooted = LootItemIfAllowed(lootId, isStolen)
                                if (harvestableBaitLootMode == PAC_ITEMTYPE_DESTROY) then
                                    -- Also destroy it (set itemLooted to false in this case)
                                    itemLooted = false
                                end
                            end
                        end

                        -- check for lootable item types (bait, provisioniug ingredients, and raw material)
                        for currItemType = 1, #PALLootableItemTypes do
                            -- check if the itemType is configured for auto-loot
                            if (PALLootableItemTypes[currItemType] == itemType) then
                                -- then check if it is set to Auto-Loot
                                if (PA.savedVars.Loot[PA.activeProfile].LootableItemTypes[itemType] == PAC_ITEMTYPE_LOOT) then
                                    -- Loot the item
                                    itemLooted = LootItemIfAllowed(lootId, isStolen)

                                    -- if item was a recipe that is unknown, add a suffix description
                                    if (itemType == ITEMTYPE_RECIPE and not IsItemLinkRecipeKnown(itemLink)) then
                                        suffixDesc = PALocale.getResourceMessage("PAL_RecipeUnknown_Suffix")
                                    end
                                end
                                break
                            end
                        end

                        -- check for QuestItems
                        if (isQuest) then
                            -- check if QuestItems are set to Auto-Loot
                            if PA.savedVars.Loot[PA.activeProfile].questItemsLootMode == PAC_ITEMTYPE_LOOT then
                                -- Loot the item
                                itemLooted = LootItemIfAllowed(lootId, isStolen)

                                PAHF_DEBUG.debugln("itemName (%s)   itemLink (%s)   itemType (%s)   strItemType (%s)", itemName, itemLink, itemType, strItemType)
                            end
                        end

                        -- check for Lockpicks
                        if (icon == PAC_ICON_LOCKPICK_PATH) then
                            -- check if Lockpicks are set to Auto-Loot
                            if PA.savedVars.Loot[PA.activeProfile].lockpickLootMode == PAC_ITEMTYPE_LOOT then
                                -- Loot the item
                                itemLooted = LootItemIfAllowed(lootId, isStolen)

                                PAHF_DEBUG.debugln("itemName (%s)   itemLink (%s)   itemType (%s)   strItemType (%s)", itemName, itemLink, itemType, strItemType)
                            end
                        end


                        -- check if an item was looted
                        if (itemLooted) then
                            -- check if ItemLink is empty (i.e. its a quest item), then replace it with a regular String
                            if (itemLink == nil or itemLink == "") then
                                itemLink = PAC_COL_WHITE .. "[" .. itemName .. "]"
                            end

                            -- show output to chat (depending on setting)
                            local lootItemsChatMode = PA.savedVars.Loot[PA.activeProfile].lootItemsChatMode
                            if (lootItemsChatMode == PA_OUTPUT_TYPE_FULL) then PAHF.println(PALocale.getResourceMessage("PAL_Items_ChatMode_Full"), itemCount, itemLink, iconString, suffixDesc)
                            elseif (lootItemsChatMode == PA_OUTPUT_TYPE_NORMAL) then PAHF.println(PALocale.getResourceMessage("PAL_Items_ChatMode_Normal"), itemCount, itemLink, iconString, suffixDesc)
                            elseif (lootItemsChatMode == PA_OUTPUT_TYPE_MIN) then PAHF.println(PALocale.getResourceMessage("PAL_Items_ChatMode_Min"), itemCount, iconString, suffixDesc)
                            end -- PA_OUTPUT_TYPE_NONE => no chat output
                        end
                    end
                end

                -- check if GoldLoot is enabled
                if PA.savedVars.Loot[PA.activeProfile].lootGoldEnabled then
                    -- Loot gold
                    LootGold()
                end

                alreadyOnLootUpdated = false

            else
                PAHF_DEBUG.debugln("PAL.OnLootUpdate() already running")
            end
        end
    end
end


function PAL.OnInventorySingleSlotUpdate(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    if (PAHF.hasActiveProfile()) then

        -- check if addon is enabled
        if PA.savedVars.Loot[PA.activeProfile].enabled then
            -- check if ItemLoot is enabled
            if PA.savedVars.Loot[PA.activeProfile].lootItemsEnabled then
                -- check if the updated happened in the backpack
                if (bagId == BAG_BACKPACK) then
                    -- only proceed if the update was triggered while harvesting (i.e. not from looting chests, wasps, mobs, etc)
                    if (alreadyHarvesting) then
                        -- get the itemType
                        local itemType = GetItemType(BAG_BACKPACK, slotId)
                        -- check if it is bait, and if bait is set to be destroyed
                        if ((itemType == ITEMTYPE_LURE) and (PAMenu_Functions.getFunc.PALoot.harvestableBaitLootMode() == PAC_ITEMTYPE_DESTROY)) then
                            DestroyNumOfItems(BAG_BACKPACK, slotId, stackCountChange)
                        end
                    end
                end
            end
        end
    end
end
