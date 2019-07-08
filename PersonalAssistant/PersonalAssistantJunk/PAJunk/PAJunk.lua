-- Local instances of Global tables --
local PA = PersonalAssistant
local PAJ = PA.Junk
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
local PAEM = PA.EventManager

-- ---------------------------------------------------------------------------------------------------------------------

local TREASURE_ITEM_TAGS = {
    A_MATTER_OF_LEISURE = {
        GetString(SI_PA_TREASURE_ITEM_TAG_DESC_TOYS),
        GetString(SI_PA_TREASURE_ITEM_TAG_DESC_DOLLS),
        GetString(SI_PA_TREASURE_ITEM_TAG_DESC_GAMES),
    },
    A_MATTER_OF_RESPECT = {
        GetString(SI_PA_TREASURE_ITEM_TAG_DESC_UTENSILS),
        GetString(SI_PA_TREASURE_ITEM_TAG_DESC_DRINKWARE),
        GetString(SI_PA_TREASURE_ITEM_TAG_DESC_DISHES_COOKWARE),
    },
    A_MATTER_OF_TRIBUTES = {
        GetString(SI_PA_TREASURE_ITEM_TAG_DESC_COSMETICS),
        GetString(SI_PA_TREASURE_ITEM_TAG_DESC_GROOMING),
    }
}

local SELL_FENCE_ITEMS_INTERVAL_MS = 25
local SELL_FENCE_CALL_LATER_FUNCTION_NAME = "CallLaterFunction_SellFence"

local GET_MONEY_AND_USED_SLOTS_INTERVAL_MS = 100
local GET_MONEY_AND_USED_SLOTS_TIMEOUT_MS = 1000
local CALL_LATER_FUNCTION_NAME = "CallLaterFunction_GetMoneyAndUsedSlots"

local function _getUniqueUpdateIdentifier()
    return CALL_LATER_FUNCTION_NAME
end

local function _getUniqueSellFenceUpdateIdentifier(bagId, slotIndex)
    return table.concat({SELL_FENCE_CALL_LATER_FUNCTION_NAME, tostring(bagId), tostring(slotIndex)})
end

local function _giveSoldJunkFeedback(moneyBefore, itemCountInBagBefore)
    -- before starting make sure any already registered UpdateEvent is unregistered to not run them in parallel
    local identifier = _getUniqueUpdateIdentifier()
    EVENT_MANAGER:UnregisterForUpdate(identifier)
    local startGameTime = GetGameTimeMilliseconds()
    -- now register for the interval
    EVENT_MANAGER:RegisterForUpdate(identifier, GET_MONEY_AND_USED_SLOTS_INTERVAL_MS,
        function()
            -- check what the difference in money is
            local currentMoney = GetCurrentMoney()
            local moneyDiff = currentMoney - moneyBefore;
            local numBagUsedSlots = GetNumBagUsedSlots(BAG_BACKPACK)
            local itemCountInBagDiff = itemCountInBagBefore - numBagUsedSlots
            local passedGameTime = GetGameTimeMilliseconds() - startGameTime

            if moneyDiff > 0 or itemCountInBagDiff > 0 or passedGameTime > GET_MONEY_AND_USED_SLOTS_TIMEOUT_MS then
                EVENT_MANAGER:UnregisterForUpdate(identifier)
                PAJ.debugln('_giveSoldJunkFeedback took approx. %d ms (-%d items, +%d gold)', passedGameTime, itemCountInBagDiff, moneyDiff)

                if itemCountInBagDiff > 0 then
                    -- at lesat one item was sold (although it might have been worthless)
                    if moneyDiff > 0 then
                        -- some valuable junk was sold
                        PAJ.println(SI_PA_CHAT_JUNK_SOLD_JUNK_INFO, moneyDiff)
                    else
                        -- only worthless junk was sold
                        PAJ.println(SI_PA_CHAT_JUNK_SOLD_JUNK_INFO, moneyDiff)
                    end
                else
                    -- no item was sold
                    if moneyDiff > 0 then
                        -- no item was sold, but money appeared out of nowhere
                        -- should not happen :D
                        PAJ.println(PAC.COLORED_TEXTS.PAJ .. "It's magic! You gained gold without selling junk... we're gonna be rich! (this is an error ;D)")
                    end
                end

                -- after JunkFeedback is given, try to trigger PARepair Callback in case it was registered (if PARepair is enabled)
                if PA.Repair then
                    PAEM.FireCallbacks(PA.Repair.AddonName, EVENT_OPEN_STORE, "OpenStore")
                end
            end
        end)
end

local function _markAsJunkIfPossible(bagId, slotIndex, successMessageKey, itemLink)
    PAJ.debugln("_markAsJunkIfPossible: %s", itemLink)
    -- Check if ESO allows the item to be marked as junk
    if CanItemBeMarkedAsJunk(bagId, slotIndex) then
        -- then check if the item is Bound; if yes don't mark it as junk (i.e. Kari's Hit List Relics)
        local isBound = IsItemLinkBound(itemLink)
        if not isBound then
            -- It is considered safe to mark the item as junk
            SetItemIsJunk(bagId, slotIndex, true)
            PlaySound(SOUNDS.INVENTORY_ITEM_JUNKED)

            -- make sure an itemLink is present
            if itemLink == nil then itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS) end

            -- prepare additional icons if needed
            local itemLinkExt = PAHF.getIconExtendedItemLink(itemLink)

            -- print provided success message
            PAJ.println(successMessageKey, itemLinkExt)

            return true -- marking junk was successful
        end
    else
        -- print failure message
        -- TODO: to be implemented

        return false -- was not marked as junk
    end
end

local function _canWeaponArmorJewelryBeMarkedAsJunk(savedVarsGroup, itemLink, itemQuality)
    if savedVarsGroup ~= nil and istable(savedVarsGroup) then
        local qualityThreshold = savedVarsGroup.autoMarkQualityThreshold
        if qualityThreshold ~= PAC.ITEM_QUALITY.DISABLED and itemQuality <= qualityThreshold then
            -- quality threshold would be reached, check other includes now
            local hasSet = GetItemLinkSetInfo(itemLink, false)
            if not hasSet or (hasSet and savedVarsGroup.autoMarkIncludingSets) then
                local canBeResearched = CanItemLinkBeTraitResearched(itemLink)
                if not canBeResearched or (canBeResearched and savedVarsGroup.autoMarkUnknownTraits) then
                    local isIntricateTtrait = PAHF.isItemLinkIntricateTraitType(itemLink)
                    if not isIntricateTtrait or (isIntricateTtrait and savedVarsGroup.autoMarkIntricateTrait) then
                        return true
                    end
                end
            end
        end
    end
    -- if unknown or no match, return false
    return false
end

local function _printFenceSellTransactionTimeoutMessage(resetTimeSeconds)
    local resetTimeHours = PAHF.round(resetTimeSeconds / 3600, 0)
    if resetTimeHours >= 1 then
        PAJ.println(SI_PA_CHAT_JUNK_FENCE_LIMIT_HOURS, resetTimeHours)
    else
        local resetTimeMinutes = PAHF.round(resetTimeSeconds / 60, 0)
        PAJ.println(SI_PA_CHAT_JUNK_FENCE_LIMIT_MINUTES, resetTimeMinutes)
    end
end

local function _sellStolenJunkToFence(bagCache, startIndex, moneyBefore, itemCountInBagBefore)
    if not PA.WindowStates.isFenceClosed then
        local totalSells, sellsUsedBefore = GetFenceSellTransactionInfo()
        -- Sell the (stolen) item which was marked as junk
        local sellStartGameTime = GetGameTimeMilliseconds()
        local itemDataToSell = bagCache[startIndex]
        local isBound = IsItemBound(itemDataToSell.bagId, itemDataToSell.slotIndex)
        -- check if item can be sold (i.e it is not bound)
        if not isBound then
            SellInventoryItem(itemDataToSell.bagId, itemDataToSell.slotIndex, itemDataToSell.stackCount)
            -- ---------------------------------------------------------------------------------------------------------
            -- Now "wait" until the item sell has been complete/confirmed, or the limit is reached (or until fence is closed!)
            local identifier = _getUniqueSellFenceUpdateIdentifier(itemDataToSell.bagId, itemDataToSell.slotIndex)
            EVENT_MANAGER:RegisterForUpdate(identifier, SELL_FENCE_ITEMS_INTERVAL_MS,
                function()
                    -- check if the item is still in the bag
                    local itemId = GetItemId(itemDataToSell.bagId, itemDataToSell.slotIndex)
                    local _, sellsUsed, resetTimeSeconds = GetFenceSellTransactionInfo()
                    if itemId <= 0 or sellsUsed > sellsUsedBefore or sellsUsed == totalSells or PA.WindowStates.isFenceClosed then
                        -- if item is gone, limit reached, or fence closed stop the interval
                        EVENT_MANAGER:UnregisterForUpdate(identifier)
                        local sellFinishGameTime = GetGameTimeMilliseconds()
                        PAHF.debuglnAuthor("totalSells=%d, sellsUsed=%d, resetTimeSeconds=%d, took %d ms", totalSells, sellsUsed, resetTimeSeconds, (sellFinishGameTime - sellStartGameTime))
                        if sellsUsed == totalSells then
                            -- limit reached! print a message and stop
                            _printFenceSellTransactionTimeoutMessage(resetTimeSeconds)
                            -- after limit is reached, also give feedback about the changes
                            _giveSoldJunkFeedback(moneyBefore, itemCountInBagBefore)
                        else
                            -- limit not yet reached, check if there are more items to be sold
                            local newStartIndex = startIndex + 1
                            if newStartIndex <= #bagCache then
                                -- yes, continue loop
                                _sellStolenJunkToFence(bagCache, newStartIndex, moneyBefore, itemCountInBagBefore)
                            else
                                -- no, finish loop; after everything is sold, give feedback about the changes
                                _giveSoldJunkFeedback(moneyBefore, itemCountInBagBefore)
                            end
                        end
                    end
                end)
            -- ---------------------------------------------------------------------------------------------------------
        else
            -- show message to player that Item cannot be sold because reasons ;)
--            local itemLink = GetItemLink(itemDataToSell.bagId, itemDataToSell.slotIndex, LINK_STYLE_BRACKETS)
--            PAJ.println(SI_PA_CHAT_JUNK_FENCE_ITEM_WORTHLESS, itemLink)
            -- if item cannot be sold; continue with the next (if there are more)
            local newStartIndex = startIndex + 1
            if newStartIndex <= #bagCache then
                -- yes, continue loop
                _sellStolenJunkToFence(bagCache, newStartIndex, moneyBefore, itemCountInBagBefore)
            else
                -- no, finish loop; after everything is sold, give feedback about the changes
                _giveSoldJunkFeedback(moneyBefore, itemCountInBagBefore)
            end
        end
    else
        -- if Fence has been closed, also display the feedback message
        _giveSoldJunkFeedback(moneyBefore, itemCountInBagBefore)
    end
end

local function _isTrashItemNotQuestExcluded(bagId, slotIndex)
    local PAJunkSavedVars = PAJ.SavedVars
    local itemId = GetItemId(bagId, slotIndex)
    -- check Quest: Nibbles and Bits
    if PAJunkSavedVars.Trash.excludeNibblesAndBits then
        for _, constItemId in pairs(PAC.JUNK.TRASH_ITEMIDS.NIBBLES_AND_BITS) do
            if itemId == constItemId then return false end
        end
    end
    -- check Quest: Morsels and Pecks
    if PAJunkSavedVars.Trash.excludeMorselsAndPecks then
        for _, constItemId in pairs(PAC.JUNK.TRASH_ITEMIDS.MORSELS_AND_PECKS) do
            if itemId == constItemId then return false end
        end
    end
    -- no match so far means that the trash items is NOT excluded
    return true
end

local function _isTreasureItemNotQuestExcluded(itemLink)
    local PAJunkSavedVars = PAJ.SavedVars
    local numItemTags = GetItemLinkNumItemTags(itemLink)
    for itemTagIndex = 1, numItemTags do
        local itemTagDescription, itemTagCategory = GetItemLinkItemTagInfo(itemLink, itemTagIndex)
        local itemTagDescriptionFmt = zo_strformat("<<1>>", itemTagDescription, 1)
        if itemTagCategory == TAG_CATEGORY_TREASURE_TYPE then
            -- check Quest: A Matter of Leisure
            if PAJunkSavedVars.Miscellaneous.excludeAMatterOfLeisure then
                for _, itemTagKey in pairs(TREASURE_ITEM_TAGS.A_MATTER_OF_LEISURE) do
                    if itemTagDescriptionFmt == itemTagKey then return false end
                end
            end
            -- check Quest: A Matter of Respect
            if PAJunkSavedVars.Miscellaneous.excludeAMatterOfRespect then
                for _, itemTagKey in pairs(TREASURE_ITEM_TAGS.A_MATTER_OF_RESPECT) do
                    if itemTagDescriptionFmt == itemTagKey then return false end
                end
            end
            -- check Quest: A Matter of Tributes
            if PAJunkSavedVars.Miscellaneous.excludeAMatterOfTributes then
                for _, itemTagKey in pairs(TREASURE_ITEM_TAGS.A_MATTER_OF_TRIBUTES) do
                    if itemTagDescriptionFmt == itemTagKey then return false end
                end
            end
        end
    end
    -- no match so far means that the trash items is NOT excluded
    return true
end

-- ---------------------------------------------------------------------------------------------------------------------

local function OnFenceOpen(eventCode, allowSell, allowLaunder)
    if PAHF.hasActiveProfile() then
        -- set the global variable to 'false'
        PA.WindowStates.isFenceClosed = false
        -- check if auto-sell is enabled
        if allowSell and PAJ.SavedVars.autoSellJunk then
            -- check if there is junk to sell (exclude stolen items = false)
            if HasAnyJunk(BAG_BACKPACK) then
                -- store current amount of money
                local moneyBefore = GetCurrentMoney();
                local itemCountInBagBefore = GetNumBagUsedSlots(BAG_BACKPACK)
                -- check if limit already reached
                local totalSells, sellsUsed, resetTimeSeconds = GetFenceSellTransactionInfo()
                if sellsUsed < totalSells then
                    -- limit not yet reached; get all items to loop through the stolen/junk ones
                    local stolenJunkComparator = PAHF.getStolenJunkComparator()
                    local bagCache = SHARED_INVENTORY:GenerateFullSlotData(stolenJunkComparator, BAG_BACKPACK)
                    if #bagCache > 0 then
                        -- after sellink junk, give feedback about the changes
                        _sellStolenJunkToFence(bagCache, 1, moneyBefore, itemCountInBagBefore)
                    end
                else
                    -- limit already reached when fence was opened; since nothing was sold no solJunkFeedback needed!
                    _printFenceSellTransactionTimeoutMessage(resetTimeSeconds)
                end
            end
        end
    end
end

local function OnShopOpen()
    if PAHF.hasActiveProfile() then
        -- set the global variable to 'false'
        PA.WindowStates.isStoreClosed = false
        -- check if auto-sell is enabled
        if PAJ.SavedVars.autoSellJunk then
            -- check if there is junk to sell (exclude stolen items = true)
            if HasAnyJunk(BAG_BACKPACK, true) then
                -- store current amount of money
                local moneyBefore = GetCurrentMoney();
                local itemCountInBagBefore = GetNumBagUsedSlots(BAG_BACKPACK)

                -- Sell all items marked as junk
                SellAllJunk()

                -- after calling SellAllJunk(), give feedback about the changes
                _giveSoldJunkFeedback(moneyBefore, itemCountInBagBefore)
            else
                -- if there is no junk, immediately fire the callback event for PARepair (if PARepair is enabled)
                if PA.Repair then
                    PAEM.FireCallbacks(PA.Repair.AddonName, EVENT_OPEN_STORE, "OpenStore")
                end
            end
        end
    end
end

local function OnStoreAndFenceClose()
    PA.WindowStates.isFenceClosed = true
    PA.WindowStates.isStoreClosed = true
end

local function OnMailboxOpen()
    PA.WindowStates.isMailboxClosed = false
end

local function OnMailboxClose()
    PA.WindowStates.isMailboxClosed = true
end

local function OnInventorySingleSlotUpdate(eventCode, bagId, slotIndex, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    if PAHF.hasActiveProfile() then
        -- only proceed, if neither the crafting window nor the mailbox are open (otherwise crafted/retrieved items could also be marked as junk)
        if not ZO_CraftingUtils_IsCraftingWindowOpen() and PA.WindowStates.isMailboxClosed then
            local PAJunkSavedVars = PAJ.SavedVars

            -- check if auto-marking is enabled and if the updated happened in the backpack and if the item is new
            if isNewItem and PAJunkSavedVars.autoMarkAsJunkEnabled and bagId == BAG_BACKPACK then
                -- get the itemLink (must use this function as GetItemLink returns all lower-case item-names) and itemType
                local itemLink = PAHF.getFormattedItemLink(bagId, slotIndex)
                local itemId = GetItemId(bagId, slotIndex)
                local itemType, specializedItemType = GetItemType(bagId, slotIndex)
                local itemQuality = GetItemQuality(bagId, slotIndex)
                local sellInformation = GetItemLinkSellInformation(itemLink)

                PAJ.debugln("OnInventorySingleSlotUpdate - Check if to be junked: %s", itemLink)

                -- first check for regular Trash
                if itemType == ITEMTYPE_TRASH or specializedItemType == SPECIALIZED_ITEMTYPE_TRASH then
                    if PAJunkSavedVars.Trash.autoMarkTrash then
                        if _isTrashItemNotQuestExcluded(bagId, slotIndex) then
                            _markAsJunkIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TRASH, itemLink)
                        else
                            PAHF.debuglnAuthor("Skipped %s becase needed for Quest", itemLink)
                        end
                    end
                -- check for weapons, aparrel and jewelry
                elseif itemType == ITEMTYPE_WEAPON or itemType == ITEMTYPE_ARMOR then
                    local itemTrait = GetItemTrait(bagId, slotIndex)
                    -- then check if it has the [Ornate] trait and can be marked as junk or not
                    if itemTrait == ITEM_TRAIT_TYPE_WEAPON_ORNATE and PAJunkSavedVars.Weapons.autoMarkOrnate or
                            itemTrait == ITEM_TRAIT_TYPE_ARMOR_ORNATE and PAJunkSavedVars.Armor.autoMarkOrnate or
                            itemTrait == ITEM_TRAIT_TYPE_JEWELRY_ORNATE and PAJunkSavedVars.Jewelry.autoMarkOrnate then
                        _markAsJunkIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_ORNATE, itemLink)
                    else
                        -- if it is NOT with [Ornate] trait, check more detailed the individual equipTypes
                        if itemType == ITEMTYPE_WEAPON and PAJunkSavedVars.Weapons.autoMarkQualityThreshold ~= PAC.ITEM_QUALITY.DISABLED then
                            -- handle WEAPONS
                            if _canWeaponArmorJewelryBeMarkedAsJunk(PAJunkSavedVars.Weapons, itemLink, itemQuality) then
                                _markAsJunkIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY, itemLink)
                            end
                        elseif itemType == ITEMTYPE_ARMOR then
                            local itemEquipType = GetItemLinkEquipType(itemLink)
                            if itemEquipType == EQUIP_TYPE_RING or itemEquipType == EQUIP_TYPE_NECK then
                                -- handle JEWELRY
                                if _canWeaponArmorJewelryBeMarkedAsJunk(PAJunkSavedVars.Jewelry, itemLink, itemQuality) then
                                    _markAsJunkIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY, itemLink)
                                end
                            else
                                -- handle APPAREL
                                if _canWeaponArmorJewelryBeMarkedAsJunk(PAJunkSavedVars.Armor, itemLink, itemQuality) then
                                    _markAsJunkIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY, itemLink)
                                end
                            end
                        end
                    end
                elseif itemType == ITEMTYPE_TREASURE and specializedItemType == SPECIALIZED_ITEMTYPE_TREASURE then
                    if PAJunkSavedVars.Miscellaneous.autoMarkTreasure then
                        if _isTreasureItemNotQuestExcluded(itemLink) then
                            _markAsJunkIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TREASURE, itemLink)
                        else
                            PAHF.debuglnAuthor("Skipped %s becase needed for Quest", itemLink)
                        end
                    end
                elseif (itemType == ITEMTYPE_GLYPH_ARMOR or itemType == ITEMTYPE_GLYPH_JEWELRY or itemType == ITEMTYPE_GLYPH_WEAPON) and
                        PAJunkSavedVars.Miscellaneous.autoMarkGlyphQualityThreshold ~= PAC.ITEM_QUALITY.DISABLED then
                    if itemQuality <= PAJunkSavedVars.Miscellaneous.autoMarkGlyphQualityThreshold then
                        _markAsJunkIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY, itemLink)
                    end
                elseif sellInformation == ITEM_SELL_INFORMATION_PRIORITY_SELL then
                    if PAJunkSavedVars.Collectibles.autoMarkSellToMerchant then
                        _markAsJunkIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_MERCHANT, itemLink)
                    end
                else
                    -- Lastly, check the custom rules
                    if PAJunkSavedVars.Custom.customItemsEnabled then
                       if PAHF.isKeyInTable(PAJunkSavedVars.Custom.ItemIds, itemId) then
                           local hasBeenMarked = _markAsJunkIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_PERMANENT, itemLink)
                           if hasBeenMarked then
                               PAJunkSavedVars.Custom.ItemIds[itemId].junkCount = PAJunkSavedVars.Custom.ItemIds[itemId].junkCount + stackCountChange
                               PAJunkSavedVars.Custom.ItemIds[itemId].lastJunk = GetTimeStamp()
                           end
                       end
                    end
                end
            end
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Junk = PA.Junk or {}
PA.Junk.OnFenceOpen = OnFenceOpen
PA.Junk.OnShopOpen = OnShopOpen
PA.Junk.OnStoreAndFenceClose = OnStoreAndFenceClose
PA.Junk.OnMailboxOpen = OnMailboxOpen
PA.Junk.OnMailboxClose = OnMailboxClose
PA.Junk.OnInventorySingleSlotUpdate = OnInventorySingleSlotUpdate
