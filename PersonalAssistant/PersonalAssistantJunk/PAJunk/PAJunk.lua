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

local _tempItemCountInBagBefore
local _tempTotalMoneyDiff
local _tempBagCache
local _tempItemIndexToSellNext

local _sellStartGameTime


-- =====================================================================================================================
-- Internal functions
-- ---------------------------------------------------------------------------------------------------------------------

local function _resetTempValues()
    _tempItemCountInBagBefore = nil
    _tempTotalMoneyDiff = nil
    _tempBagCache = nil
    _tempItemIndexToSellNext = nil
end

local function _initTempValues(bagCache)
    _tempItemCountInBagBefore = GetNumBagUsedSlots(BAG_BACKPACK)
    _tempTotalMoneyDiff = 0
    if bagCache then
        _tempBagCache = bagCache
        _tempItemIndexToSellNext = 1
    end
end

--- Checks whether the item has any sell value or not
-- @param bagId the id of the bag where the item is
-- @param slotIndex the id of the slot where the item is
-- @return true if the item has zero sell value; otherwise false
local function _isItemWorthless(bagId, slotIndex)
    -- check if the item is stolen
    local isStolen = IsItemStolen(bagId, slotIndex)
    if isStolen then
        -- if stolen, get the sell price incl. haggling bonus
        local sellPriceStolen = GetItemSellValueWithBonuses(bagId, slotIndex)
        if sellPriceStolen == 0 then return true end
    else
        -- if not stolen, just get the regular sell price
        local _, _, sellPrice = GetItemInfo(bagId, slotIndex)
        if sellPrice == 0 then return true end
    end
end

local function _isWorthlessAndShouldBeDestroyed(bagId, slotIndex)
    local PAJunkSavedVars = PAJ.SavedVars
    -- first check if the setting to destroy worhtless items is turned on
    if PAJunkSavedVars.AutoDestroy.destroyWorthlessJunk then
        -- then check if the item is stolen
        return _isItemWorthless(bagId, slotIndex)
    end
    return false
end

local function _isTrashItemNotQuestExcluded(bagId, slotIndex)
    local PAJunkSavedVars = PAJ.SavedVars
    local itemId = GetItemId(bagId, slotIndex)
    -- check Quest: Nibbles and Bits
    if PAJunkSavedVars.QuestProtection.ClockworkCity.excludeNibblesAndBits then
        for _, constItemId in pairs(PAC.JUNK.TRASH_ITEMIDS.NIBBLES_AND_BITS) do
            if itemId == constItemId then return false end
        end
    end
    -- check Quest: Morsels and Pecks
    if PAJunkSavedVars.QuestProtection.ClockworkCity.excludeMorselsAndPecks then
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
            if PAJunkSavedVars.QuestProtection.ClockworkCity.excludeAMatterOfLeisure then
                for _, itemTagKey in pairs(TREASURE_ITEM_TAGS.A_MATTER_OF_LEISURE) do
                    if itemTagDescriptionFmt == itemTagKey then return false end
                end
            end
            -- check Quest: A Matter of Respect
            if PAJunkSavedVars.QuestProtection.ClockworkCity.excludeAMatterOfRespect then
                for _, itemTagKey in pairs(TREASURE_ITEM_TAGS.A_MATTER_OF_RESPECT) do
                    if itemTagDescriptionFmt == itemTagKey then return false end
                end
            end
            -- check Quest: A Matter of Tributes
            if PAJunkSavedVars.QuestProtection.ClockworkCity.excludeAMatterOfTributes then
                for _, itemTagKey in pairs(TREASURE_ITEM_TAGS.A_MATTER_OF_TRIBUTES) do
                    if itemTagDescriptionFmt == itemTagKey then return false end
                end
            end
        end
    end
    -- no match so far means that the trash item is NOT excluded
    return true
end

local function _isSellToMerchantItemNotQuestExcluded(specializedItemType, itemLink)
    local PAJunkSavedVars = PAJ.SavedVars
    if specializedItemType == SPECIALIZED_ITEMTYPE_COLLECTIBLE_RARE_FISH and PAJunkSavedVars.QuestProtection.NewLifeFestival.excludeRareFish and not IsItemLinkBound(itemLink) then
        return false
    end
    -- no match so far means that the SellToMerchant item is NOT excluded
    return true
end

local function _isIndividualFCOISItemCheckRequired()
    local PAI = PA.Integration
    if PAI and FCOIS then
        local PAIFCOISSavedVars = PAI.SavedVars.FCOItemSaver
        local autoSellMarked = PAIFCOISSavedVars.Sell.autoSellMarked
        local lockedPreventsAutoSell = PAIFCOISSavedVars.Locked.preventAutoSell
        -- if either FCOIS-Integration setting is turned on, return true
        return autoSellMarked or lockedPreventsAutoSell
    end
    -- in all other cases, it is not needed
    return false
end

local function _canWeaponArmorJewelryBeMarkedAsJunk(savedVarsGroup, itemLink, itemQuality)
    if savedVarsGroup ~= nil and istable(savedVarsGroup) then
        local qualityThreshold = savedVarsGroup.autoMarkQualityThreshold
        if qualityThreshold ~= PAC.ITEM_QUALITY.DISABLED and itemQuality <= qualityThreshold then
            -- quality threshold would be reached, check other includes now
            local hasSet = GetItemLinkSetInfo(itemLink, false)
            if not hasSet or (hasSet and savedVarsGroup.autoMarkIncludingSets) then
                local itemTraitType = GetItemLinkTraitType(itemLink)
                if itemTraitType == ITEM_TRAIT_TYPE_NONE then
                    -- if the item has passed the quality-check and the set-check, and has no traits then it can be marked as junk
                    return true
                else
                    local canBeResearched = CanItemLinkBeTraitResearched(itemLink)
                    if (not canBeResearched and savedVarsGroup.autoMarkKnownTraits) or (canBeResearched and savedVarsGroup.autoMarkUnknownTraits) then
                        local isIntricateTtrait = PAHF.isItemLinkIntricateTraitType(itemLink)
                        if not isIntricateTtrait or (isIntricateTtrait and savedVarsGroup.autoMarkIntricateTrait) then
                            return true
                        end
                    end
                end
            end
        end
    end
    -- if unknown or no match, return false
    return false
end

local function _markAsJunkOrDestroyIfWorthless(bagId, slotIndex, successMessageKey, itemLink)
    PAJ.debugln("_markAsJunkOrDestroyIfWorthless: %s", itemLink)
    -- Check if ESO allows the item to be marked as junk
    if CanItemBeMarkedAsJunk(bagId, slotIndex) then
        -- then check if the item can NOT be sold or if it is unique; if yes then don't mark it as junk
        local sellInformation = GetItemLinkSellInformation(itemLink)
        local isUnique = IsItemLinkUnique(itemLink)
        if sellInformation == ITEM_SELL_INFORMATION_CANNOT_SELL or isUnique then
            -- does not make sense to mark item as junks since it cannot be sold or is unique
            if _isWorthlessAndShouldBeDestroyed(bagId, slotIndex) then
                -- Item should be DESTROYED
                PAJ.debugln("_isWorthlessAndShouldBeDestroyed (1)")
                local itemSoundCategory = GetItemSoundCategory(bagId, slotIndex)
                local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)
                local itemLinkExt = PAHF.getIconExtendedItemLink(itemLink)
                local _, stackCount = GetItemInfo(bagId, slotIndex)
                -- execute main action
                DestroyItem(bagId, slotIndex)
                -- inform player
                PlayItemSound(itemSoundCategory, ITEM_SOUND_ACTION_DESTROY)
                PAJ.println(SI_PA_CHAT_JUNK_DESTROYED_WORTHLESS, stackCount, itemLinkExt)
                return true -- marking/destroying junk was successful
            end
            PAJ.debugln("NOT CanItemBeMarkedAsJunk/IsWorthlessAndShouldBeDestroyed isUnique="..tostring(isUnique).. " | sellInformation="..GetString("SI_ITEMSELLINFORMATION", sellInformation))
            return false -- was not marked as junk
        else
            -- It is considered safe to mark the item as junk (or to be destroyed?)
            if _isWorthlessAndShouldBeDestroyed(bagId, slotIndex) then
                -- Item should be DESTROYED
                PAJ.debugln("_isWorthlessAndShouldBeDestroyed (2)")
                local itemSoundCategory = GetItemSoundCategory(bagId, slotIndex)
                local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)
                local itemLinkExt = PAHF.getIconExtendedItemLink(itemLink)
                local _, stackCount = GetItemInfo(bagId, slotIndex)
                -- execute main action
                DestroyItem(bagId, slotIndex)
                -- inform player
                PlayItemSound(itemSoundCategory, ITEM_SOUND_ACTION_DESTROY)
                PAJ.println(SI_PA_CHAT_JUNK_DESTROYED_WORTHLESS, stackCount, itemLinkExt)

            else
                -- Item should be marked as JUNK
                PAJ.debugln("NOT _isWorthlessAndShouldBeDestroyed (3)")
                SetItemIsJunk(bagId, slotIndex, true)
                PlaySound(SOUNDS.INVENTORY_ITEM_JUNKED)
                -- make sure an itemLink is present
                if itemLink == nil then itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS) end
                -- prepare additional icons if needed
                local itemLinkExt = PAHF.getIconExtendedItemLink(itemLink)
                -- print provided success message
                PAJ.println(successMessageKey, itemLinkExt)
            end

            return true -- marking/destroying junk was successful
        end
    else
        -- print failure message
        -- TODO: to be implemented

        return false -- was not marked as junk
    end
end

local function _markAsJunkOrDestroyBasedOnItemAction(bagId, slotIndex, successJunkMessageKey, itemLink, itemAction)
    PAJ.debugln("_markAsJunkOrDestroyBasedOnItemAction: %s", itemLink)

    local function _markItemAsJunk(bagId, slotIndex, itemLink, successJunkMessageKey)
        PAJ.debugln("Mark Item As Junk")
        SetItemIsJunk(bagId, slotIndex, true)
        PlaySound(SOUNDS.INVENTORY_ITEM_JUNKED)
        -- make sure an itemLink is present
        if itemLink == nil then itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS) end
        -- prepare additional icons if needed
        local itemLinkExt = PAHF.getIconExtendedItemLink(itemLink)
        -- print provided success message
        PAJ.println(successJunkMessageKey, itemLinkExt)
    end

    local function _destroyItem(bagId, slotIndex, itemLink, itemAction)
        local itemSoundCategory = GetItemSoundCategory(bagId, slotIndex)
        local itemLinkExt = PAHF.getIconExtendedItemLink(itemLink)
        local _, stackCount = GetItemInfo(bagId, slotIndex)
        -- execute main action
        DestroyItem(bagId, slotIndex)
        -- inform player
        PlayItemSound(itemSoundCategory, ITEM_SOUND_ACTION_DESTROY)
        -- with a matching text
        if itemAction == PAC.ITEM_ACTION.DESTROY_ALWAYS then
            PAJ.debugln("Destroy Item Always")
            PAJ.println(SI_PA_CHAT_JUNK_DESTROYED_ALWAYS, stackCount, itemLinkExt)
        elseif itemAction == PAC.ITEM_ACTION.JUNK_DESTROY_WORTHLESS then
            PAJ.debugln("Destroy Item Worthless")
            PAJ.println(SI_PA_CHAT_JUNK_DESTROYED_WORTHLESS, stackCount, itemLinkExt)
        end
    end

    -- if item action is set to do nothing, stop immediately
    if itemAction == PAC.ITEM_ACTION.NOTHING then return false end
    -- if item is unique, also stop immediately (i.e. to avoid destroying Kari's Hit List items)
    if IsItemLinkUnique(itemLink) then return false end

    -- if item action is set to mark as junk, check if ESO allows that
    if itemAction == PAC.ITEM_ACTION.MARK_AS_JUNK then
        if CanItemBeMarkedAsJunk(bagId, slotIndex) then
            -- Item should be marked as JUNK
            _markItemAsJunk(bagId, slotIndex, itemLink, successJunkMessageKey)
            return true
        end
    else
        local isItemWorthless = _isItemWorthless(bagId, slotIndex)
        if itemAction == PAC.ITEM_ACTION.DESTROY_ALWAYS or (isItemWorthless and itemAction == PAC.ITEM_ACTION.JUNK_DESTROY_WORTHLESS) then
            -- Item should be DESTROYED
            _destroyItem(bagId, slotIndex, itemLink, itemAction)
            return true
        elseif not isItemWorthless and itemAction == PAC.ITEM_ACTION.JUNK_DESTROY_WORTHLESS then
            -- Item should be marked as JUNK
            _markItemAsJunk(bagId, slotIndex, itemLink, successJunkMessageKey)
            return true
        end
    end
    return false
end


-- =====================================================================================================================
-- Give feedback to the player about the changes in gold or when fence transaction limit will reset
-- ---------------------------------------------------------------------------------------------------------------------

local function _printSoldItemsMessageAndFireRepairCallbacks(totalSellPrice, totalSellCount)
    if totalSellCount > 0 then
        -- at least one item was sold (although it might have been worthless(?))
        local totalSellPriceFmt = PAHF.getFormattedCurrency(totalSellPrice)
        if totalSellPrice > 0 then
            -- some valuable items were sold
            PAJ.println(SI_PA_CHAT_JUNK_SOLD_ITEMS_INFO, totalSellPriceFmt)
        else
            -- only worthless items were sold
            PAJ.println(SI_PA_CHAT_JUNK_SOLD_ITEMS_INFO, totalSellPriceFmt)
        end
    else
        -- no item was sold
        if totalSellPrice > 0 then
            -- no item was sold, but money appeared out of nowhere
            -- should not happen :D
            PAJ.println(PAC.COLORED_TEXTS.PAJ .. ": It's magic! You gained gold without selling junk... we're gonna be rich! (this is an error ;D)")
        end
    end

    -- after JunkFeedback is given, try to trigger PARepair Callback in case it was registered (if PARepair is enabled)
    if PA.Repair then
        PAEM.FireCallbacks(PA.Repair.AddonName, EVENT_OPEN_STORE, "OpenStore")
    end
end

local function _printFenceSellTransactionResetMessage(resetTimeSeconds)
    local resetTimeHours = PAHF.round(resetTimeSeconds / 3600, 0)
    if resetTimeHours >= 1 then
        PAJ.println(SI_PA_CHAT_JUNK_FENCE_LIMIT_HOURS, resetTimeHours)
    else
        local resetTimeMinutes = PAHF.round(resetTimeSeconds / 60, 0)
        PAJ.println(SI_PA_CHAT_JUNK_FENCE_LIMIT_MINUTES, resetTimeMinutes)
    end
end

local function _stopSellingItemsAndContinue()
    -- first, unregister the events and give feedback
    PAEM.UnregisterForEvent(PAJ.AddonName, EVENT_MONEY_UPDATE, "StolenJunkSoldAtFenceMoneyUpdate")
    PAEM.UnregisterForEvent(PAJ.AddonName, EVENT_MONEY_UPDATE, "JunkSoldAtMerchantMoneyUpdate")

    -- then update the values for reporting in chat
    local totalSellCount = _tempItemCountInBagBefore - GetNumBagUsedSlots(BAG_BACKPACK)
    _printSoldItemsMessageAndFireRepairCallbacks(_tempTotalMoneyDiff, totalSellCount)

    -- reset the temporary values to 'nil' again
    _resetTempValues()
end

-- =====================================================================================================================
-- Recursive function for individually selling stolen junk items to Fences
-- ---------------------------------------------------------------------------------------------------------------------

local function _sellNextStolenItemToFence()
    local totalSells, sellsUsed, resetTimeSeconds = GetFenceSellTransactionInfo()
    if sellsUsed < totalSells then
        -- check if there even is an item to be sold
        if _tempItemIndexToSellNext <= #_tempBagCache then
            local itemDataToSell = _tempBagCache[_tempItemIndexToSellNext]
            local bagId = itemDataToSell.bagId
            local slotIndex = itemDataToSell.slotIndex
            local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)
            local sellPriceStolen = GetItemSellValueWithBonuses(bagId, slotIndex)
            local sellInformation = GetItemLinkSellInformation(itemLink)
            if sellInformation == ITEM_SELL_INFORMATION_CANNOT_SELL then
                -- show message to player that Item cannot be sold because ESO says so
                PAJ.println(SI_PA_CHAT_JUNK_CANNOT_SELL_ITEM, itemLink)
                -- if item cannot be sold; continue with the next (if there are more)
                _tempItemIndexToSellNext = _tempItemIndexToSellNext + 1
                _sellNextStolenItemToFence()
            elseif sellPriceStolen <= 0 then
                -- show message to player that Item cannot be sold because a Fence does not accept zero-value items
                PAJ.println(SI_PA_CHAT_JUNK_FENCE_ITEM_WORTHLESS, itemLink)
                -- if item cannot be sold; continue with the next (if there are more)
                _tempItemIndexToSellNext = _tempItemIndexToSellNext + 1
                _sellNextStolenItemToFence()
            else
                -- item can be sold and it is worth money, check if Fence window is still open
                if not PA.WindowStates.isFenceClosed then
                    local stackCount = itemDataToSell.stackCount
                    _sellStartGameTime = GetGameTimeMilliseconds()
                    SellInventoryItem(bagId, slotIndex, stackCount)
                else
                    -- if Fence has been closed prematurely, also display the feedback message
                    _stopSellingItemsAndContinue()
                end
            end
        else
            -- no more items to be sold, give feedback about the changes
            _stopSellingItemsAndContinue()
        end
    else
        -- limit reached! print a message and stop
        _printFenceSellTransactionResetMessage(resetTimeSeconds)
        -- after limit is reached, also give feedback about the changes
        _stopSellingItemsAndContinue()
    end
end

--- EVENT triggered when an individual stolen Junk item is sold at a Fence using ESO's SellInventoryItem() function
-- It gets registered when there are stolen junk items that can be sold individually to a Fence
-- @param eventCode the id of the event
-- @param newMoney  amount of gold AFTER single stolen junk item was sold
-- @param oldMoney amount of gold BEFORE single stolen junk item was sold
-- @param currencyChangeReason the id of the reason why currency got changed
local function _onStolenJunkSoldAtFenceMoneyUpdate(eventCode, newMoney, oldMoney, currencyChangeReason)
    -- TODO: also check if moneyDiff was positive (extra safety check?)
    if currencyChangeReason == CURRENCY_CHANGE_REASON_VENDOR then
        local sellFinishGameTime = GetGameTimeMilliseconds()
        local moneyDiff = newMoney - oldMoney
        PAHF.debuglnAuthor("selling item to Fence for %d gold took %d ms", moneyDiff, (sellFinishGameTime - _sellStartGameTime))

        -- update the total money diff
        _tempTotalMoneyDiff = _tempTotalMoneyDiff + moneyDiff

        -- since item has been sold; attempt to continue with the next one
        _tempItemIndexToSellNext = _tempItemIndexToSellNext + 1
        _sellNextStolenItemToFence()
    end
end

local function _OnFenceOpenInternal(dynamicComparator)
    -- check if limit already reached
    local totalSells, sellsUsed, resetTimeSeconds = GetFenceSellTransactionInfo()
    if sellsUsed < totalSells then
        -- limit not yet reached; get all items to loop through the stolen/junk ones
        local bagCache = SHARED_INVENTORY:GenerateFullSlotData(dynamicComparator, BAG_BACKPACK)
        PAJ.debugln("_OnFenceOpenInternal.#bagCache = " .. tostring(#bagCache))
        if #bagCache > 0 then
            -- first init the total money diff to '0' and get the item count in the backpack
            _initTempValues(bagCache)
            -- then since there are stolen junk items to be sold, register the event
            PAEM.RegisterForEvent(PAJ.AddonName, EVENT_MONEY_UPDATE, _onStolenJunkSoldAtFenceMoneyUpdate, "StolenJunkSoldAtFenceMoneyUpdate")
            -- finally, sell the first item (to trigger the event)
            _sellNextStolenItemToFence()
        end
    else
        -- limit already reached when fence was opened; since nothing was sold no soldJunkFeedback needed!
        _printFenceSellTransactionResetMessage(resetTimeSeconds)
        -- no further action needed here since not even a single item was sold
    end
end


-- =====================================================================================================================
-- Recursive function for individually selling junk items to Merchants
-- ---------------------------------------------------------------------------------------------------------------------

local function _sellNextItemToMerchant()
    -- check if there even is an item to be sold
    if _tempItemIndexToSellNext <= #_tempBagCache then
        local itemDataToSell = _tempBagCache[_tempItemIndexToSellNext]
        local bagId = itemDataToSell.bagId
        local slotIndex = itemDataToSell.slotIndex
        local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)
        local sellInformation = GetItemLinkSellInformation(itemLink)
        if sellInformation == ITEM_SELL_INFORMATION_CANNOT_SELL then
            -- show message to player that Item cannot be sold because ESO says so
            PAJ.println(SI_PA_CHAT_JUNK_CANNOT_SELL_ITEM, itemLink)
            -- if item cannot be sold; continue with the next (if there are more)
            _tempItemIndexToSellNext = _tempItemIndexToSellNext + 1
            _sellNextItemToMerchant()
        else
            -- item can be sold, check if Merchant window is still open
            if not PA.WindowStates.isStoreClosed then
                local _, _, sellPrice = GetItemInfo(bagId, slotIndex)
                local stackCount = itemDataToSell.stackCount
                _sellStartGameTime = GetGameTimeMilliseconds()
                SellInventoryItem(bagId, slotIndex, stackCount)
            else
                -- if Merchant has been closed prematurely, also display the feedback message
                _stopSellingItemsAndContinue()
            end
        end
    else
        -- no more items to be sold, give feedback about the changes
        _stopSellingItemsAndContinue()
    end
end

--- EVENT triggered when individual Junk item is sold at a Merchant using ESO's SellInventoryItem() function
-- It gets registered when there are junk items that can be sold individually to a Merchant
-- @param eventCode the id of the event
-- @param newMoney  amount of gold AFTER single stolen junk item was sold
-- @param oldMoney amount of gold BEFORE single stolen junk item was sold
-- @param currencyChangeReason the id of the reason why currency got changed
local function _onJunkSoldAtMerchantMoneyUpdate(eventCode, newMoney, oldMoney, currencyChangeReason)
    -- TODO: also check if moneyDiff was positive (extra safety check?)
    if currencyChangeReason == CURRENCY_CHANGE_REASON_VENDOR then
        local sellFinishGameTime = GetGameTimeMilliseconds()
        local moneyDiff = newMoney - oldMoney
        PAHF.debuglnAuthor("selling item to Merchant for %d gold took %d ms", moneyDiff, (sellFinishGameTime - _sellStartGameTime))

        -- update the total money diff
        _tempTotalMoneyDiff = _tempTotalMoneyDiff + moneyDiff

        -- since item has been sold; attempt to continue with the next one
        _tempItemIndexToSellNext = _tempItemIndexToSellNext + 1
        _sellNextItemToMerchant()
    end
end

local function _OnShopOpenInternal(dynamicComparator)
    -- get all items that can be sold
    local bagCache = SHARED_INVENTORY:GenerateFullSlotData(dynamicComparator, BAG_BACKPACK)
    PAJ.debugln("_OnShopOpenInternal.#bagCache = " .. tostring(#bagCache))
    if #bagCache > 0 then
        -- first init the total money diff to '0' and get the item count in the backpack
        _initTempValues(bagCache)
        -- then since there are  junk items to be sold, register the event
        PAEM.RegisterForEvent(PAJ.AddonName, EVENT_MONEY_UPDATE, _onJunkSoldAtMerchantMoneyUpdate, "JunkSoldAtMerchantMoneyUpdate")
        -- finally, sell the first item (to trigger the event)
        _sellNextItemToMerchant()
    end
end


-- =====================================================================================================================
-- Single function for selling all junk items at once to Merchants
-- ---------------------------------------------------------------------------------------------------------------------

--- EVENT triggered when all Junk is directly sold at a Merchant using ESO's internal SellAllJunk() function
-- It gets registered when all junk can be sold directly; therefore it is sufficient to just wait until it gets triggered once
-- @param eventCode the id of the event
-- @param newMoney  amount of gold AFTER all junk was sold
-- @param oldMoney amount of gold BEFORE all junk was sold
-- @param currencyChangeReason the id of the reason why currency got changed
local function _onAllJunkSoldMoneyUpdate(eventCode, newMoney, oldMoney, currencyChangeReason)
    PAJ.debugln("PAJunk._onAllJunkSoldMoneyUpdate(oldMoney = %d, newMoney = %d, reason = %d)", oldMoney, newMoney, currencyChangeReason)
    if currencyChangeReason == CURRENCY_CHANGE_REASON_VENDOR then
        -- event was triggered, can be unregistered again
        PAEM.UnregisterForEvent(PAJ.AddonName, EVENT_MONEY_UPDATE, "AllJunkSoldMoneyUpdate")

        -- update the values for reporting in chat
        _tempTotalMoneyDiff = newMoney - oldMoney
        local totalSellCount = _tempItemCountInBagBefore - GetNumBagUsedSlots(BAG_BACKPACK)
        _printSoldItemsMessageAndFireRepairCallbacks(_tempTotalMoneyDiff, totalSellCount)

        -- reset the temporary values to 'nil' again
        _resetTempValues()
    end
end


-- =====================================================================================================================
-- Public Event Triggers
-- ---------------------------------------------------------------------------------------------------------------------

local function OnStoreOrFenceClose()
    PA.WindowStates.isFenceClosed = true
    PA.WindowStates.isStoreClosed = true

    -- try to unregister all MONEY_UPDATE events; just in case
    PAEM.UnregisterForEvent(PAJ.AddonName, EVENT_MONEY_UPDATE, "AllJunkSoldMoneyUpdate")
    PAEM.UnregisterForEvent(PAJ.AddonName, EVENT_MONEY_UPDATE, "JunkSoldAtMerchantMoneyUpdate")
    PAEM.UnregisterForEvent(PAJ.AddonName, EVENT_MONEY_UPDATE, "StolenJunkSoldAtFenceMoneyUpdate")

    -- check if there are any sold items that have not been reported to the player yet (otherwise variable would be reset to 'nil')
    if _tempTotalMoneyDiff ~= nil and _tempTotalMoneyDiff > 0 then
        -- update the values for reporting in chat
        local totalSellCount = _tempItemCountInBagBefore - GetNumBagUsedSlots(BAG_BACKPACK)
        _printSoldItemsMessageAndFireRepairCallbacks(_tempTotalMoneyDiff, totalSellCount)

        -- reset the temporary values to 'nil' again
        _resetTempValues()
    end
end

local function OnFenceOpen(eventCode, allowSell, allowLaunder)
    PAJ.debugln("PAJunk.OnFenceOpen")
    if PAHF.hasActiveProfile() then
        -- set the global variable to 'false'
        PA.WindowStates.isFenceClosed = false
        -- check if selling is allowed at Fence
        if allowSell then
            local unitName = GetUnitName("interact")
            local isPirharri = string.find(unitName, "Pirharri") ~= nil
            local autoSellJunk = PAJ.SavedVars.autoSellJunk
            local autoSellJunkPirharri = PAJ.SavedVars.autoSellJunkPirharri
            PAJ.debugln("Fence Name = %s", unitName)
            -- fence must either NOT be Pirharri, or if it is Pirharri, the setting must be turned on
            if not isPirharri or (isPirharri and autoSellJunkPirharri) then
                if _isIndividualFCOISItemCheckRequired() then
                    -- both FCOIS and PAIntegration are running and at least one setting is turned on; take the extended logic
                    PAJ.debugln("OnFenceOpen with PAIntegration and FCOIS")
                    local PAFCOISLib = PA.Libs.FCOItemSaver
                    -- check if stolen junk should be sold
                    if autoSellJunk then
                        -- check for stolen junk AND FCOIS markings
                        local sellStolenJunkIncludingFCOISComparator = PAFCOISLib.getSellStolenJunkIncludingFCOISComparator()
                        _OnFenceOpenInternal(sellStolenJunkIncludingFCOISComparator)
                    else
                        -- check only for FCOIS markings
                        local sellStolenFCOISComparator = PAFCOISLib.getSellStolenFCOISComparator()
                        _OnFenceOpenInternal(sellStolenFCOISComparator)
                    end
                else
                    -- either FCOIS or PAIntegration is NOT running, or not setting is turned on; take the default logic
                    PAJ.debugln("OnFenceOpen withOUT PAIntegration and FCOIS")
                    if autoSellJunk then
                        -- check if there is junk to sell (exclude stolen items = false) - or if FCOIS and PAI are enabled
                        if HasAnyJunk(BAG_BACKPACK) then
                            local stolenJunkComparator = PAHF.getStolenJunkComparator()
                            _OnFenceOpenInternal(stolenJunkComparator)
                        end
                    end
                end
            else
                PAJ.debugln("Fence is isPirharri and autoSellJunkPirharri is turned OFF")
            end
        end
    end
end

local function OnShopOpen()
    PAJ.debugln("PAJunk.OnShopOpen")
    if PAHF.hasActiveProfile() then
        -- set the global variable to 'false'
        PA.WindowStates.isStoreClosed = false
        local autoSellJunk = PAJ.SavedVars.autoSellJunk
        if _isIndividualFCOISItemCheckRequired() then
            -- both FCOIS and PAIntegration are running and at least one setting is turned on; take the extended logic
            PAJ.debugln("OnShopOpen with PAIntegration and FCOIS")
            local PAFCOISLib = PA.Libs.FCOItemSaver
            -- check if junk should be sold
            if autoSellJunk then
                -- check for junk AND FCOIS markings
                local sellStolenJunkIncludingFCOISComparator = PAFCOISLib.getSellJunkIncludingFCOISComparator()
                _OnShopOpenInternal(sellStolenJunkIncludingFCOISComparator)
            else
                -- check only for FCOIS markings
                local sellFCOISComparator = PAFCOISLib.getSellFCOISComparator()
                _OnShopOpenInternal(sellFCOISComparator)
            end
        else
            -- either FCOIS or PAIntegration is NOT running, or not setting is turned on; take the default logic
            PAJ.debugln("OnShopOpen withOUT PAIntegration and FCOIS")
            if autoSellJunk then
                -- check if there is junk to sell (exclude stolen items = true)
                if HasAnyJunk(BAG_BACKPACK, true) then
                    -- first init the total money diff to '0' and get the item count in the backpack
                    _initTempValues()
                    -- Register an event to check when Junk was sold to the Merchant
                    PAEM.RegisterForEvent(PAJ.AddonName, EVENT_MONEY_UPDATE, _onAllJunkSoldMoneyUpdate, "AllJunkSoldMoneyUpdate")
                    -- Sell all items marked as junk
                    SellAllJunk()
                else
                    -- if there is no junk, immediately fire the callback event for PARepair (if PARepair is enabled)
                    if PA.Repair then
                        PAEM.FireCallbacks(PA.Repair.AddonName, EVENT_OPEN_STORE, "OpenStore")
                    end
                end
            end
        end
    end
end

local function OnMailboxOpen()
    PA.WindowStates.isMailboxClosed = false
end

local function OnMailboxClose()
    PA.WindowStates.isMailboxClosed = true
end

local function OnInventorySingleSlotUpdate(eventCode, bagId, slotIndex, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    if PAHF.hasActiveProfile() then
        -- only proceed it item is not already marked as junk
        local isJunk = IsItemJunk(bagId, slotIndex)
        if isJunk then return end
        -- then only further proceed, if item is not crafted at not coming from the mailbox (unless the corresponding settings are turned off)
        local PAJunkSavedVars = PAJ.SavedVars
        local itemLink = PAHF.getFormattedItemLink(bagId, slotIndex)
        local isCrafted = IsItemLinkCrafted(itemLink)
        if (not isCrafted or not PAJunkSavedVars.ignoreCraftedItems) and (PA.WindowStates.isMailboxClosed or not PAJunkSavedVars.ignoreMailboxItems) then
            -- check if the updated happened in the backpack and if the item is new
            if bagId == BAG_BACKPACK then
                local _marked = false
                -- check if auto-marking is enabled for standard items (standard items only marked as junk if 'new')
                if PAJunkSavedVars.autoMarkAsJunkEnabled and isNewItem then
                    local itemType, specializedItemType = GetItemType(bagId, slotIndex)
                    local isStolen = IsItemStolen(bagId, slotIndex)

                    PAJ.debugln("OnInventorySingleSlotUpdate - Check if to be junked: %s", itemLink)

                    if isStolen then
                        -- -------------------------------------------------------------------------------------------------
                        -- all rules for stolen items
                        if itemType == ITEMTYPE_WEAPON or itemType == ITEMTYPE_ARMOR then
                            -- heck the individual equipTypes
                            if itemType == ITEMTYPE_WEAPON then
                                -- handle WEAPONS
                                local weaponAction = PAJunkSavedVars.Stolen.Weapons.action
                                if weaponAction ~= PAC.ITEM_ACTION.NOTHING then
                                    _marked = _markAsJunkOrDestroyBasedOnItemAction(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN, itemLink, weaponAction)
                                end
                            elseif itemType == ITEMTYPE_ARMOR then
                                local itemEquipType = GetItemLinkEquipType(itemLink)
                                if itemEquipType == EQUIP_TYPE_RING or itemEquipType == EQUIP_TYPE_NECK then
                                    -- handle JEWELRY
                                    local jewelryAction = PAJunkSavedVars.Stolen.Jewelry.action
                                    if jewelryAction ~= PAC.ITEM_ACTION.NOTHING then
                                        _marked = _markAsJunkOrDestroyBasedOnItemAction(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN, itemLink, jewelryAction)
                                    end
                                else
                                    -- handle APPAREL
                                    local armorAction = PAJunkSavedVars.Stolen.Armor.action
                                    if armorAction ~= PAC.ITEM_ACTION.NOTHING then
                                        _marked = _markAsJunkOrDestroyBasedOnItemAction(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN, itemLink, armorAction)
                                    end
                                end
                            end
                        elseif (itemType == ITEMTYPE_TRASH or specializedItemType == SPECIALIZED_ITEMTYPE_TRASH) and not (PAJunkSavedVars.Stolen.trashAction == PAC.ITEM_ACTION.NOTHING) then
                            local trashAction = PAJunkSavedVars.Stolen.trashAction
                            _marked = _markAsJunkOrDestroyBasedOnItemAction(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN, itemLink, trashAction)
                        elseif itemType == ITEMTYPE_STYLE_MATERIAL and not (PAJunkSavedVars.Stolen.styleMaterialAction == PAC.ITEM_ACTION.NOTHING) then
                            local styleMaterialAction = PAJunkSavedVars.Stolen.styleMaterialAction
                            _marked = _markAsJunkOrDestroyBasedOnItemAction(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN, itemLink, styleMaterialAction)
                        elseif (itemType == ITEMTYPE_ARMOR_TRAIT or itemType == ITEMTYPE_WEAPON_TRAIT or itemType == ITEMTYPE_JEWELRY_RAW_TRAIT or itemType == ITEMTYPE_JEWELRY_TRAIT)
                                and not (PAJunkSavedVars.Stolen.traitItemAction == PAC.ITEM_ACTION.NOTHING) then
                            local traitItemAction = PAJunkSavedVars.Stolen.traitItemAction
                            _marked = _markAsJunkOrDestroyBasedOnItemAction(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN, itemLink, traitItemAction)
                        elseif itemType == ITEMTYPE_LURE and not (PAJunkSavedVars.Stolen.lureAction == PAC.ITEM_ACTION.NOTHING) then
                            local lureAction = PAJunkSavedVars.Stolen.lureAction
                            _marked = _markAsJunkOrDestroyBasedOnItemAction(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN, itemLink, lureAction)
                        elseif itemType == ITEMTYPE_INGREDIENT and not (PAJunkSavedVars.Stolen.ingredientAction == PAC.ITEM_ACTION.NOTHING) then
                            local ingredientAction = PAJunkSavedVars.Stolen.ingredientAction
                            _marked = _markAsJunkOrDestroyBasedOnItemAction(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN, itemLink, ingredientAction)
                        elseif itemType == ITEMTYPE_FOOD and not (PAJunkSavedVars.Stolen.foodAction == PAC.ITEM_ACTION.NOTHING) then
                            local foodAction = PAJunkSavedVars.Stolen.foodAction
                            _marked = _markAsJunkOrDestroyBasedOnItemAction(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN, itemLink, foodAction)
                        elseif itemType == ITEMTYPE_DRINK and not (PAJunkSavedVars.Stolen.drinkAction == PAC.ITEM_ACTION.NOTHING) then
                            local drinkAction = PAJunkSavedVars.Stolen.drinkAction
                            _marked = _markAsJunkOrDestroyBasedOnItemAction(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN, itemLink, drinkAction)
                        elseif (itemType == ITEMTYPE_POISON_BASE or itemType == ITEMTYPE_POTION_BASE) and not (PAJunkSavedVars.Stolen.solventAction == PAC.ITEM_ACTION.NOTHING) then
                            local solventAction = PAJunkSavedVars.Stolen.solventAction
                            _marked = _markAsJunkOrDestroyBasedOnItemAction(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN, itemLink, solventAction)
                        elseif itemType == ITEMTYPE_TREASURE and specializedItemType == SPECIALIZED_ITEMTYPE_TREASURE and not (PAJunkSavedVars.Stolen.treasureAction == PAC.ITEM_ACTION.NOTHING) then
                            local treasureAction = PAJunkSavedVars.Stolen.treasureAction
                            if _isTreasureItemNotQuestExcluded(itemLink) then
                                _marked = _markAsJunkOrDestroyBasedOnItemAction(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TREASURE, itemLink, treasureAction)
                            else
                                PAHF.debuglnAuthor("Skipped %s because needed for Quest", itemLink)
                            end
                        end
                    else
                        -- -------------------------------------------------------------------------------------------------
                        -- all rules for NOT stolen items
                        local sellInformation = GetItemLinkSellInformation(itemLink)
                        local itemQuality = GetItemFunctionalQuality(bagId, slotIndex)

                        if itemType == ITEMTYPE_TRASH or specializedItemType == SPECIALIZED_ITEMTYPE_TRASH then
                            if PAJunkSavedVars.Trash.autoMarkTrash then
                                if _isTrashItemNotQuestExcluded(bagId, slotIndex) then
                                    _marked = _markAsJunkOrDestroyIfWorthless(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TRASH, itemLink)
                                else
                                    PAHF.debuglnAuthor("Skipped %s becase needed for Quest", itemLink)
                                end
                            end
                        elseif itemType == ITEMTYPE_WEAPON or itemType == ITEMTYPE_ARMOR then
                            local itemTrait = GetItemTrait(bagId, slotIndex)
                            -- check if it has the [Ornate] trait and can be marked as junk or not
                            if itemTrait == ITEM_TRAIT_TYPE_WEAPON_ORNATE and PAJunkSavedVars.Weapons.autoMarkOrnate or
                                    itemTrait == ITEM_TRAIT_TYPE_ARMOR_ORNATE and PAJunkSavedVars.Armor.autoMarkOrnate or
                                    itemTrait == ITEM_TRAIT_TYPE_JEWELRY_ORNATE and PAJunkSavedVars.Jewelry.autoMarkOrnate then
                                _marked = _markAsJunkOrDestroyIfWorthless(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_ORNATE, itemLink)
                            else
                                -- if it is NOT with [Ornate] trait, check more detailed the individual equipTypes
                                if itemType == ITEMTYPE_WEAPON and PAJunkSavedVars.Weapons.autoMarkQualityThreshold ~= PAC.ITEM_QUALITY.DISABLED then
                                    -- handle WEAPONS
                                    if _canWeaponArmorJewelryBeMarkedAsJunk(PAJunkSavedVars.Weapons, itemLink, itemQuality) then
                                        _marked = _markAsJunkOrDestroyIfWorthless(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY, itemLink)
                                    end
                                elseif itemType == ITEMTYPE_ARMOR then
                                    local itemEquipType = GetItemLinkEquipType(itemLink)
                                    if itemEquipType == EQUIP_TYPE_RING or itemEquipType == EQUIP_TYPE_NECK then
                                        -- handle JEWELRY
                                        if _canWeaponArmorJewelryBeMarkedAsJunk(PAJunkSavedVars.Jewelry, itemLink, itemQuality) then
                                            _marked = _markAsJunkOrDestroyIfWorthless(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY, itemLink)
                                        end
                                    else
                                        -- handle APPAREL
                                        if _canWeaponArmorJewelryBeMarkedAsJunk(PAJunkSavedVars.Armor, itemLink, itemQuality) then
                                            _marked = _markAsJunkOrDestroyIfWorthless(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY, itemLink)
                                        end
                                    end
                                end
                            end
                        elseif (itemType == ITEMTYPE_GLYPH_ARMOR or itemType == ITEMTYPE_GLYPH_JEWELRY or itemType == ITEMTYPE_GLYPH_WEAPON) and
                                PAJunkSavedVars.Miscellaneous.autoMarkGlyphQualityThreshold ~= PAC.ITEM_QUALITY.DISABLED then
                            if itemQuality <= PAJunkSavedVars.Miscellaneous.autoMarkGlyphQualityThreshold then
                                _marked = _markAsJunkOrDestroyIfWorthless(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY, itemLink)
                            end
                        elseif sellInformation == ITEM_SELL_INFORMATION_PRIORITY_SELL then
                            if PAJunkSavedVars.Collectibles.autoMarkSellToMerchant then
                                if _isSellToMerchantItemNotQuestExcluded(specializedItemType, itemLink) then
                                    _marked = _markAsJunkOrDestroyIfWorthless(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_MERCHANT, itemLink)
                                else
                                    PAHF.debuglnAuthor("Skipped %s becase needed for Quest", itemLink)
                                end
                            end
                        elseif itemType == ITEMTYPE_TREASURE and specializedItemType == SPECIALIZED_ITEMTYPE_TREASURE then
                            if PAJunkSavedVars.Miscellaneous.autoMarkTreasure and _isTreasureItemNotQuestExcluded(itemLink) then
                                _marked = _markAsJunkOrDestroyIfWorthless(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TREASURE, itemLink)
                            else
                                PAHF.debuglnAuthor("Skipped %s because needed for Quest", itemLink)
                            end
                        end
                    end
                end

                -- -----------------------------------------------------------------------------------------------------
                -- any custom rules are always checked at the end
                if PAJunkSavedVars.Custom.customItemsEnabled then
                    -- check if item has not already been marked
                    if _marked == false then
                        local paItemId = PAHF.getPAItemIdentifier(bagId, slotIndex)
                        if PAHF.isKeyInTable(PAJunkSavedVars.Custom.PAItemIds, paItemId) then
                            local hasBeenMarked = _markAsJunkOrDestroyIfWorthless(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_PERMANENT, itemLink)
                            if hasBeenMarked then
                                PAJunkSavedVars.Custom.PAItemIds[paItemId].junkCount = PAJunkSavedVars.Custom.PAItemIds[paItemId].junkCount + stackCountChange
                                PAJunkSavedVars.Custom.PAItemIds[paItemId].lastJunk = GetTimeStamp()
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
PA.Junk.OnStoreOrFenceClose = OnStoreOrFenceClose
PA.Junk.OnFenceOpen = OnFenceOpen
PA.Junk.OnShopOpen = OnShopOpen
PA.Junk.OnMailboxOpen = OnMailboxOpen
PA.Junk.OnMailboxClose = OnMailboxClose
PA.Junk.OnInventorySingleSlotUpdate = OnInventorySingleSlotUpdate
