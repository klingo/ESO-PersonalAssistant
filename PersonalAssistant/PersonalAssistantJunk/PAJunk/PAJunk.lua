-- Local instances of Global tables --
local PA = PersonalAssistant
local PAJ = PA.Junk
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
local PAEM = PA.EventManager

-- ---------------------------------------------------------------------------------------------------------------------

local _isMailboxOpen = false

local GET_MONEY_AND_USED_SLOTS_INTERVAL_MS = 100
local GET_MONEY_AND_USED_SLOTS_TIMEOUT_MS = 1000
local CALL_LATER_FUNCTION_NAME = "CallLaterFunction_GetMoneyAndUsedSlots"

local function _getUniqueUpdateIdentifier()
    return CALL_LATER_FUNCTION_NAME
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
                PAHF.debugln('_giveSoldJunkFeedback took approx. %d ms (-%d items, +%d gold)', passedGameTime, itemCountInBagDiff, moneyDiff)

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
                    PAEM.FireCallbacks(PA.Repair.AddonName, EVENT_OPEN_STORE)
                end
            end
        end)
end


local function _markAsJunkIfPossible(bagId, slotIndex, successMessageKey, itemLink)
    -- Check if ESO allows the item to be marked as junk
    if CanItemBeMarkedAsJunk(bagId, slotIndex) then
        -- TODO: integrate FCOItemSaver?

        local playerLocked = IsItemPlayerLocked(bagId, slotIndex)
--        d("playerLocked="..tostring(playerLocked))

--        CanItemBePlayerLocked(number Bag bagId, number slotIndex)
--        Returns: boolean canBePlayerLocked
--
--        IsItemPlayerLocked(number Bag bagId, number slotIndex)
--        Returns: boolean playerLocked
--
--        SetItemIsPlayerLocked(number Bag bagId, number slotIndex, boolean playerLocked)

        -- It is considered safe to mark the item as junk now
        SetItemIsJunk(bagId, slotIndex, true)

        -- make sure an itemLink is present
        if itemLink == nil then itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS) end

        -- and check if it is stolen
        local itemStolen = IsItemLinkStolen(itemLink)

        -- print provided success message
        if itemStolen then
            local params = table.concat({itemLink, " ", PAC.ICONS.ITEMS.STOLEN.SMALL})
            PAJ.println(successMessageKey, params)
        else
            PAJ.println(successMessageKey, itemLink)
        end
    else
        -- print failure message
        -- TODO: to be implemented
    end
end

local function _isIntricateTraitType(itemTraitType)
    if itemTraitType == ITEM_TRAIT_TYPE_ARMOR_INTRICATE then return true end
    if itemTraitType == ITEM_TRAIT_TYPE_JEWELRY_INTRICATE then return true end
    if itemTraitType == ITEM_TRAIT_TYPE_WEAPON_INTRICATE then return true end
    return false
end

local function _hasAdditionalApparelChecksPassed(itemLink, itemType)
    local savedVarsGroup
    if itemType == ITEMTYPE_WEAPON then
        savedVarsGroup = "Weapons"
    elseif itemType == ITEMTYPE_ARMOR then
        local itemEquipType = GetItemLinkEquipType(itemLink)
        if itemEquipType == EQUIP_TYPE_RING or itemEquipType == EQUIP_TYPE_NECK then
            savedVarsGroup = "Jewelry"
        else
            savedVarsGroup = "Armor"
        end
    end

    if savedVarsGroup ~= nil then
        local PAJunkSavedVars = PAJ.SavedVars
        local PAJunkSavedVarsGroup = PAJunkSavedVars[savedVarsGroup]
        local hasSet = GetItemLinkSetInfo(itemLink, false)
        if not hasSet or (hasSet and PAJunkSavedVarsGroup.autoMarkIncludingSets) then
            local canBeResearched = CanItemLinkBeTraitResearched(itemLink)
            if not canBeResearched or (canBeResearched and PAJunkSavedVarsGroup.autoMarkUnknownTraits) then
                local itemTraitType = GetItemLinkTraitType(itemLink)
                local isIntricateTtrait = _isIntricateTraitType(itemTraitType)
                if not isIntricateTtrait or (isIntricateTtrait and PAJunkSavedVarsGroup.autoMarkIntricateTrait) then
                    return true
                end
            end
        end
    end

    return false -- if unknown, return false
end

-- ---------------------------------------------------------------------------------------------------------------------

local function OnFenceOpen(eventCode, allowSell, allowLaunder)
    if PAHF.hasActiveProfile() then
        -- check if auto-sell is enabled
        if allowSell and PAJ.SavedVars.autoSellJunk then
            -- check if there is junk to sell (exclude stolen items = false)
            if HasAnyJunk(BAG_BACKPACK) then
                -- store current amount of money
                local moneyBefore = GetCurrentMoney();
                local itemCountInBagBefore = GetNumBagUsedSlots(BAG_BACKPACK)
                -- get all items to loop through the stolen/junk ones
                local bagCache = SHARED_INVENTORY:GenerateFullSlotData(nil, BAG_BACKPACK)
                for _, itemData in pairs(bagCache) do
                    if itemData.stolen and itemData.isJunk then
                        local totalSells, sellsUsed, resetTimeSeconds = GetFenceSellTransactionInfo()
                        if sellsUsed == totalSells then
                            local resetTimeHours = PAHF.round(resetTimeSeconds / 3600, 0)
                            if resetTimeHours >= 1 then
                                PAJ.println(SI_PA_CHAT_JUNK_FENCE_LIMIT_HOURS, resetTimeHours)
                            else
                                local resetTimeMinutes = PAHF.round(resetTimeSeconds / 60, 0)
                                PAJ.println(SI_PA_CHAT_JUNK_FENCE_LIMIT_MINUTES, resetTimeMinutes)
                            end
                            break
                        end
                        -- Sell the (stolen) item which was marked as junk
                        SellInventoryItem(itemData.bagId, itemData.slotIndex, itemData.stackCount)
                    end
                end

                -- after calling SellAllJunk(), give feedback about the changes
                _giveSoldJunkFeedback(moneyBefore, itemCountInBagBefore)
            end
        end
    end
end

local function OnShopOpen()
    if PAHF.hasActiveProfile() then
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
                    PAEM.FireCallbacks(PA.Repair.AddonName, EVENT_OPEN_STORE)
                end
            end
        end
    end
end


local function OnMailboxOpen()
    _isMailboxOpen = true
end


local function OnMailboxClose()
    _isMailboxOpen = false
end


local function OnInventorySingleSlotUpdate(eventCode, bagId, slotIndex, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    if PAHF.hasActiveProfile() then
        -- only proceed, if neither the crafting window nor the mailbox are NOT open (otherwise crafted/retrieved items could also be marked as junk)
        if not ZO_CraftingUtils_IsCraftingWindowOpen() and not _isMailboxOpen then
            local PAJunkSavedVars = PAJ.SavedVars

            -- check if auto-marking is enabled and if the updated happened in the backpack and if the item is new
            if isNewItem and PAJunkSavedVars.autoMarkAsJunkEnabled and bagId == BAG_BACKPACK then
                -- get the itemLink (must use this function as GetItemLink returns all lower-case item-names) and itemType
                local itemLink = PAHF.getFormattedItemLink(bagId, slotIndex)
                local itemType, specializedItemType = GetItemType(bagId, slotIndex)

                -- first check for regular Trash
                if itemType == ITEMTYPE_TRASH or specializedItemType == SPECIALIZED_ITEMTYPE_TRASH then
                    if PAJunkSavedVars.Trash.autoMarkTrash then
                        _markAsJunkIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TRASH, itemLink)
                    end

                -- then check if it is not a Set, or if it is that the corresponding setting is enabled
                -- also check if it does not have unknown traits, or if the corresponding setting is enabled
                elseif _hasAdditionalApparelChecksPassed(itemLink, itemType) then
                    local itemTrait = GetItemTrait(bagId, slotIndex)
                    local itemQuality = GetItemQuality(bagId, slotIndex)
                    -- check for the different itemTypes and itemTraits
                    if itemTrait == ITEM_TRAIT_TYPE_WEAPON_ORNATE and PAJunkSavedVars.Weapons.autoMarkOrnate or
                            itemTrait == ITEM_TRAIT_TYPE_ARMOR_ORNATE and PAJunkSavedVars.Armor.autoMarkOrnate or
                            itemTrait == ITEM_TRAIT_TYPE_JEWELRY_ORNATE and PAJunkSavedVars.Jewelry.autoMarkOrnate then
                        _markAsJunkIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_ORNATE, itemLink)

                    elseif itemType == ITEMTYPE_WEAPON and PAJunkSavedVars.Weapons.autoMarkQualityThreshold ~= PAC.ITEM_QUALITY.DISABLED then
                        if itemQuality <= PAJunkSavedVars.Weapons.autoMarkQualityThreshold then
                            _markAsJunkIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY, itemLink)
                        end

                    elseif itemType == ITEMTYPE_ARMOR then
                        local itemEquipType = GetItemLinkEquipType(itemLink)
                        if itemEquipType == EQUIP_TYPE_RING or itemEquipType == EQUIP_TYPE_NECK then
                            -- Jewelry
                            if PAJunkSavedVars.Jewelry.autoMarkQualityThreshold ~= PAC.ITEM_QUALITY.DISABLED and itemQuality <= PAJunkSavedVars.Jewelry.autoMarkQualityThreshold then
                                _markAsJunkIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY, itemLink)
                            end

                        else
                            --Apparel
                            if PAJunkSavedVars.Armor.autoMarkQualityThreshold ~= PAC.ITEM_QUALITY.DISABLED and itemQuality <= PAJunkSavedVars.Armor.autoMarkQualityThreshold then
                                _markAsJunkIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY, itemLink)
                            end
                        end
                    end
                elseif itemType == ITEMTYPE_TREASURE and specializedItemType == SPECIALIZED_ITEMTYPE_TREASURE then
                    if PAJunkSavedVars.Miscellaneous.autoMarkTreasure then
                        _markAsJunkIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TREASURE, itemLink)
                    end
                else
                    local sellInformation = GetItemLinkSellInformation(itemLink)
                    if sellInformation == ITEM_SELL_INFORMATION_PRIORITY_SELL then
                        if PAJunkSavedVars.Collectibles.autoMarkSellToMerchant then
                            _markAsJunkIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_MERCHANT, itemLink)
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
PA.Junk.OnMailboxOpen = OnMailboxOpen
PA.Junk.OnMailboxClose = OnMailboxClose
PA.Junk.OnInventorySingleSlotUpdate = OnInventorySingleSlotUpdate
