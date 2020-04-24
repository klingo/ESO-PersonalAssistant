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

local SELL_MERCHANT_ITEMS_INTERVAL_MS = 25
local SELL_MERCHANT_CALL_LATER_FUNCTION_NAME = "CallLaterFunction_SellMerchant"

local GET_MONEY_AND_USED_SLOTS_INTERVAL_MS = 100
local GET_MONEY_AND_USED_SLOTS_TIMEOUT_MS = 1000
local CALL_LATER_FUNCTION_NAME = "CallLaterFunction_GetMoneyAndUsedSlots"

local function _getUniqueUpdateIdentifier()
    return CALL_LATER_FUNCTION_NAME
end

local function _getUniqueSellFenceUpdateIdentifier(bagId, slotIndex)
    return table.concat({SELL_FENCE_CALL_LATER_FUNCTION_NAME, tostring(bagId), tostring(slotIndex)})
end

local function _getUniqueSellMerchantUpdateIdentifier(bagId, slotIndex)
    return table.concat({SELL_MERCHANT_CALL_LATER_FUNCTION_NAME, tostring(bagId), tostring(slotIndex)})
end

local function _giveDelayedDiffSoldItemsFeedback(moneyBefore, itemCountInBagBefore)
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
                    -- at least one item was sold (although it might have been worthless(?))
                    local moneyDiffFmt = PAHF.getFormattedCurrency(moneyDiff)
                    if moneyDiff > 0 then
                        -- some valuable items were sold
                        PAJ.println(SI_PA_CHAT_JUNK_SOLD_ITEMS_INFO, moneyDiffFmt)
                    else
                        -- only worthless items were sold
                        PAJ.println(SI_PA_CHAT_JUNK_SOLD_ITEMS_INFO, moneyDiffFmt)
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

local function _giveImmediateSoldItemsFeedback(totalSellPrice, totalSellCount)
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
            PAJ.println(PAC.COLORED_TEXTS.PAJ .. "It's magic! You gained gold without selling junk... we're gonna be rich! (this is an error ;D)")
        end
    end

    -- after JunkFeedback is given, try to trigger PARepair Callback in case it was registered (if PARepair is enabled)
    if PA.Repair then
        PAEM.FireCallbacks(PA.Repair.AddonName, EVENT_OPEN_STORE, "OpenStore")
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

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

local function _markAsJunkIfPossible(bagId, slotIndex, successMessageKey, itemLink)
    PAJ.debugln("_markAsJunkIfPossible: %s", itemLink)
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

--- Depending on the itemAction, the item is marked as junk, destroyed or nothing happens
-- @param bagId the id of the bag where the item is
-- @param slotIndex the id of the slot where the item is
-- @param successJunkMessageKey the message key that should be printed when marked as junk
-- @param itemLink the itemLink string of the item
-- @param itemAction the action-code from PAC.ITEM_ACTION
-- @return true if the item was marked as junk or destroy, otherwise false
local function _markAsJunkOrDestroyIfPossible(bagId, slotIndex, successJunkMessageKey, itemLink, itemAction)
    PAJ.debugln("_markAsJunkOrDestroyIfPossible: %s", itemLink)
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

local function _printFenceSellTransactionTimeoutMessage(resetTimeSeconds)
    local resetTimeHours = PAHF.round(resetTimeSeconds / 3600, 0)
    if resetTimeHours >= 1 then
        PAJ.println(SI_PA_CHAT_JUNK_FENCE_LIMIT_HOURS, resetTimeHours)
    else
        local resetTimeMinutes = PAHF.round(resetTimeSeconds / 60, 0)
        PAJ.println(SI_PA_CHAT_JUNK_FENCE_LIMIT_MINUTES, resetTimeMinutes)
    end
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

-- ---------------------------------------------------------------------------------------------------------------------

local function _sellStolenItemToFence(bagCache, startIndex, totalSellPrice, totalSellCount)
    if not PA.WindowStates.isFenceClosed then
        local sellStartGameTime = GetGameTimeMilliseconds()
        local itemDataToSell = bagCache[startIndex]
        local bagId = itemDataToSell.bagId
        local slotIndex = itemDataToSell.slotIndex
        local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)
        local sellPriceStolen = GetItemSellValueWithBonuses(bagId, slotIndex)
        local sellInformation = GetItemLinkSellInformation(itemLink)
        if sellInformation == ITEM_SELL_INFORMATION_CANNOT_SELL then
            -- show message to player that Item cannot be sold because ESO says so
            PAJ.println(SI_PA_CHAT_JUNK_CANNOT_SELL_ITEM, itemLink)
            -- if item cannot be sold; continue with the next (if there are more)
            local newStartIndex = startIndex + 1
            if newStartIndex <= #bagCache then
                -- yes, continue loop
                _sellStolenItemToFence(bagCache, newStartIndex, totalSellPrice, totalSellCount)
            else
                -- no, finish loop; after everything is sold, give feedback about the changes
                _giveImmediateSoldItemsFeedback(totalSellPrice, totalSellCount)
            end
        elseif sellPriceStolen <= 0 then
            -- show message to player that Item cannot be sold because a Fence does not accept zero-value items
            PAJ.println(SI_PA_CHAT_JUNK_FENCE_ITEM_WORTHLESS, itemLink)
            -- if item cannot be sold; continue with the next (if there are more)
            local newStartIndex = startIndex + 1
            if newStartIndex <= #bagCache then
                -- yes, continue loop
                _sellStolenItemToFence(bagCache, newStartIndex, totalSellPrice, totalSellCount)
            else
                -- no, finish loop; after everything is sold, give feedback about the changes
                _giveImmediateSoldItemsFeedback(totalSellPrice, totalSellCount)
            end
        else
            -- item can be sold to the Fence; continue
            local stackCount = itemDataToSell.stackCount
            local totalSells, sellsUsedBefore = GetFenceSellTransactionInfo()
            SellInventoryItem(bagId, slotIndex, stackCount)
            -- ---------------------------------------------------------------------------------------------------------
            -- Now "wait" until the item sell has been complete/confirmed, or the limit is reached (or until fence is closed!)
            local identifier = _getUniqueSellFenceUpdateIdentifier(bagId, slotIndex)
            EVENT_MANAGER:RegisterForUpdate(identifier, SELL_FENCE_ITEMS_INTERVAL_MS,
                function()
                    -- check if the item is still in the bag
                    local itemId = GetItemId(bagId, slotIndex)
                    local _, sellsUsed, resetTimeSeconds = GetFenceSellTransactionInfo()
                    if itemId <= 0 or sellsUsed > sellsUsedBefore or sellsUsed == totalSells or PA.WindowStates.isFenceClosed then
                        -- if item is gone, limit reached, or fence closed stop the interval
                        EVENT_MANAGER:UnregisterForUpdate(identifier)
                        local sellFinishGameTime = GetGameTimeMilliseconds()
                        PAHF.debuglnAuthor("totalSells=%d, sellsUsed=%d, resetTimeSeconds=%d, took %d ms", totalSells, sellsUsed, resetTimeSeconds, (sellFinishGameTime - sellStartGameTime))
                        totalSellPrice = totalSellPrice + sellPriceStolen
                        totalSellCount = totalSellCount + 1
                        if sellsUsed == totalSells then
                            -- limit reached! print a message and stop
                            _printFenceSellTransactionTimeoutMessage(resetTimeSeconds)
                            -- after limit is reached, also give feedback about the changes
                            _giveImmediateSoldItemsFeedback(totalSellPrice, totalSellCount)
                        else
                            -- limit not yet reached, check if there are more items to be sold
                            local newStartIndex = startIndex + 1
                            if newStartIndex <= #bagCache then
                                -- yes, continue loop
                                _sellStolenItemToFence(bagCache, newStartIndex, totalSellPrice, totalSellCount)
                            else
                                -- no, finish loop; after everything is sold, give feedback about the changes
                                _giveImmediateSoldItemsFeedback(totalSellPrice, totalSellCount)
                            end
                        end
                    end
                end)
            -- ---------------------------------------------------------------------------------------------------------
        end
    else
        -- if Fence has been closed, also display the feedback message
        _giveImmediateSoldItemsFeedback(totalSellPrice, totalSellCount)
    end
end

local function _sellItemToMerchant(bagCache, startIndex, totalSellPrice, totalSellCount)
    if not PA.WindowStates.isStoreClosed then
        local sellStartGameTime = GetGameTimeMilliseconds()
        local itemDataToSell = bagCache[startIndex]
        local bagId = itemDataToSell.bagId
        local slotIndex = itemDataToSell.slotIndex
        local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)
        local sellInformation = GetItemLinkSellInformation(itemLink)
        if sellInformation == ITEM_SELL_INFORMATION_CANNOT_SELL then
            -- show message to player that Item cannot be sold because ESO says so
            PAJ.println(SI_PA_CHAT_JUNK_CANNOT_SELL_ITEM, itemLink)
            -- if item cannot be sold; continue with the next (if there are more)
            local newStartIndex = startIndex + 1
            if newStartIndex <= #bagCache then
                -- yes, continue loop
                _sellItemToMerchant(bagCache, newStartIndex, totalSellPrice, totalSellCount)
            else
                -- no, finish loop; after everything is sold, give feedback about the changes
                _giveImmediateSoldItemsFeedback(totalSellPrice, totalSellCount)
            end
        else
            local _, _, sellPrice = GetItemInfo(bagId, slotIndex)
            local stackCount = itemDataToSell.stackCount
            SellInventoryItem(bagId, slotIndex, stackCount)
            -- ---------------------------------------------------------------------------------------------------------
            -- Now "wait" until the item sell has been complete/confirmed, or the limit is reached (or until merchant is closed!)
            local identifier = _getUniqueSellMerchantUpdateIdentifier(bagId, slotIndex)
            EVENT_MANAGER:RegisterForUpdate(identifier, SELL_MERCHANT_ITEMS_INTERVAL_MS,
                function()
                    -- check if the item is still in the bag
                    local itemId = GetItemId(bagId, slotIndex)
                    if itemId <= 0 or PA.WindowStates.isStoreClosed then
                        -- if item is gone, or merchant closed stop the interval
                        EVENT_MANAGER:UnregisterForUpdate(identifier)
                        local sellFinishGameTime = GetGameTimeMilliseconds()
                        PAHF.debuglnAuthor("selling item took %d ms", (sellFinishGameTime - sellStartGameTime))
                        totalSellPrice = totalSellPrice + sellPrice
                        totalSellCount = totalSellCount + 1
                        -- check if there are more items to be sold
                        local newStartIndex = startIndex + 1
                        if newStartIndex <= #bagCache then
                            -- yes, continue loop
                            _sellItemToMerchant(bagCache, newStartIndex, totalSellPrice, totalSellCount)
                        else
                            -- no, finish loop; after everything is sold, give feedback about the changes
                            _giveImmediateSoldItemsFeedback(totalSellPrice, totalSellCount)
                        end
                    end
                end)
            -- ---------------------------------------------------------------------------------------------------------
        end
    else
        -- if Merchant has been closed, also display the feedback message
        _giveImmediateSoldItemsFeedback(totalSellPrice, totalSellCount)
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

local function _OnFenceOpenInternal(dynamicComparator)
    -- check if limit already reached
    local totalSells, sellsUsed, resetTimeSeconds = GetFenceSellTransactionInfo()
    if sellsUsed < totalSells then
        -- limit not yet reached; get all items to loop through the stolen/junk ones
        local bagCache = SHARED_INVENTORY:GenerateFullSlotData(dynamicComparator, BAG_BACKPACK)
        PAJ.debugln("_OnFenceOpenInternal.#bagCache = " .. tostring(#bagCache))
        if #bagCache > 0 then
            -- after sellink junk, give feedback about the changes
            _sellStolenItemToFence(bagCache, 1, 0, 0) -- startIndex = 1, totalSellPrice = 0, totalSellCount = 0
        end
    else
        -- limit already reached when fence was opened; since nothing was sold no soldJunkFeedback needed!
        _printFenceSellTransactionTimeoutMessage(resetTimeSeconds)
    end
end

local function _OnShopOpenInternal(dynamicComparator)
    -- get all items that can be sold
    local bagCache = SHARED_INVENTORY:GenerateFullSlotData(dynamicComparator, BAG_BACKPACK)
    PAJ.debugln("_OnShopOpenInternal.#bagCache = " .. tostring(#bagCache))
    if #bagCache > 0 then
        _sellItemToMerchant(bagCache, 1, 0, 0) -- startIndex = 1, totalSellPrice = 0, totalSellCount = 0
    end
end

local function _requiresIndividualFCOISItemCheck()
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

-- ---------------------------------------------------------------------------------------------------------------------

local function OnFenceOpen(eventCode, allowSell, allowLaunder)
    PAJ.debugln("PAJunk.OnFenceOpen")
    if PAHF.hasActiveProfile() then
        -- set the global variable to 'false'
        PA.WindowStates.isFenceClosed = false
        -- check if auto-sell is enabled
        if allowSell then
            local autoSellJunk = PAJ.SavedVars.autoSellJunk
            if _requiresIndividualFCOISItemCheck() then
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
        end
    end
end

local function OnShopOpen()
    PAJ.debugln("PAJunk.OnShopOpen")
    if PAHF.hasActiveProfile() then
        -- set the global variable to 'false'
        PA.WindowStates.isStoreClosed = false
        local autoSellJunk = PAJ.SavedVars.autoSellJunk
        if _requiresIndividualFCOISItemCheck() then
            -- both FCOIS and PAIntegration are running and at least one setting is turned on; take the extended logic
            PAJ.debugln("OnShopOpen with PAIntegration and FCOIS")
            local PAFCOISLib = PA.Libs.FCOItemSaver
            -- check if junk should be sold
            if autoSellJunk then
                -- checkf for junk AND FCOIS markings
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
                    -- store current amount of money
                    local moneyBefore = GetCurrentMoney();
                    local itemCountInBagBefore = GetNumBagUsedSlots(BAG_BACKPACK)
                    -- Sell all items marked as junk
                    SellAllJunk()
                    -- after calling SellAllJunk(), give feedback about the changes
                    _giveDelayedDiffSoldItemsFeedback(moneyBefore, itemCountInBagBefore)
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
        -- unless the mailbox setting is overriden
        local PAJunkSavedVars = PAJ.SavedVars
        if not ZO_CraftingUtils_IsCraftingWindowOpen() and (PA.WindowStates.isMailboxClosed or not PAJunkSavedVars.ignoreMailboxItems) then
            -- check if the updated happened in the backpack and if the item is new
            if isNewItem and bagId == BAG_BACKPACK then
                -- get the itemLink (must use this function as GetItemLink returns all lower-case item-names) and itemType
                local itemLink = PAHF.getFormattedItemLink(bagId, slotIndex)
                -- check if auto-marking is enabled for standard items
                if PAJunkSavedVars.autoMarkAsJunkEnabled then
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
                                    _markAsJunkOrDestroyIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN, itemLink, weaponAction)
                                end
                            elseif itemType == ITEMTYPE_ARMOR then
                                local itemEquipType = GetItemLinkEquipType(itemLink)
                                if itemEquipType == EQUIP_TYPE_RING or itemEquipType == EQUIP_TYPE_NECK then
                                    -- handle JEWELRY
                                    local jewelryAction = PAJunkSavedVars.Stolen.Jewelry.action
                                    if jewelryAction ~= PAC.ITEM_ACTION.NOTHING then
                                        _markAsJunkOrDestroyIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN, itemLink, jewelryAction)
                                    end
                                else
                                    -- handle APPAREL
                                    local armorAction = PAJunkSavedVars.Stolen.Armor.action
                                    if armorAction ~= PAC.ITEM_ACTION.NOTHING then
                                        _markAsJunkOrDestroyIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN, itemLink, armorAction)
                                    end
                                end
                            end
                        elseif itemType == ITEMTYPE_STYLE_MATERIAL and not (PAJunkSavedVars.Stolen.styleMaterialAction == PAC.ITEM_ACTION.NOTHING) then
                            local styleMaterialAction = PAJunkSavedVars.Stolen.styleMaterialAction
                            _markAsJunkOrDestroyIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN, itemLink, styleMaterialAction)
                        elseif (itemType == ITEMTYPE_ARMOR_TRAIT or itemType == ITEMTYPE_WEAPON_TRAIT or itemType == ITEMTYPE_JEWELRY_RAW_TRAIT or itemType == ITEMTYPE_JEWELRY_TRAIT)
                                and not (PAJunkSavedVars.Stolen.traitItemAction == PAC.ITEM_ACTION.NOTHING) then
                            local traitItemAction = PAJunkSavedVars.Stolen.traitItemAction
                            _markAsJunkOrDestroyIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN, itemLink, traitItemAction)
                        elseif itemType == ITEMTYPE_LURE and not (PAJunkSavedVars.Stolen.lureAction == PAC.ITEM_ACTION.NOTHING) then
                            local lureAction = PAJunkSavedVars.Stolen.lureAction
                            _markAsJunkOrDestroyIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN, itemLink, lureAction)
                        elseif itemType == ITEMTYPE_INGREDIENT and not (PAJunkSavedVars.Stolen.ingredientAction == PAC.ITEM_ACTION.NOTHING) then
                            local ingredientAction = PAJunkSavedVars.Stolen.ingredientAction
                            _markAsJunkOrDestroyIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN, itemLink, ingredientAction)
                        elseif itemType == ITEMTYPE_FOOD and not (PAJunkSavedVars.Stolen.foodAction == PAC.ITEM_ACTION.NOTHING) then
                            local foodAction = PAJunkSavedVars.Stolen.foodAction
                            _markAsJunkOrDestroyIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN, itemLink, foodAction)
                        elseif itemType == ITEMTYPE_DRINK and not (PAJunkSavedVars.Stolen.drinkAction == PAC.ITEM_ACTION.NOTHING) then
                            local drinkAction = PAJunkSavedVars.Stolen.drinkAction
                            _markAsJunkOrDestroyIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN, itemLink, drinkAction)
                        elseif itemType == ITEMTYPE_TREASURE and specializedItemType == SPECIALIZED_ITEMTYPE_TREASURE and not (PAJunkSavedVars.Stolen.treasureAction == PAC.ITEM_ACTION.NOTHING) then
                            local treasureAction = PAJunkSavedVars.Stolen.treasureAction
                            if _isTreasureItemNotQuestExcluded(itemLink) then
                                _markAsJunkOrDestroyIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TREASURE, itemLink, treasureAction)
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
                                    _markAsJunkIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TRASH, itemLink)
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
                        elseif (itemType == ITEMTYPE_GLYPH_ARMOR or itemType == ITEMTYPE_GLYPH_JEWELRY or itemType == ITEMTYPE_GLYPH_WEAPON) and
                                PAJunkSavedVars.Miscellaneous.autoMarkGlyphQualityThreshold ~= PAC.ITEM_QUALITY.DISABLED then
                            if itemQuality <= PAJunkSavedVars.Miscellaneous.autoMarkGlyphQualityThreshold then
                                _markAsJunkIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY, itemLink)
                            end
                        elseif sellInformation == ITEM_SELL_INFORMATION_PRIORITY_SELL then
                            if PAJunkSavedVars.Collectibles.autoMarkSellToMerchant then
                                if _isSellToMerchantItemNotQuestExcluded(specializedItemType, itemLink) then
                                    _markAsJunkIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_MERCHANT, itemLink)
                                else
                                    PAHF.debuglnAuthor("Skipped %s becase needed for Quest", itemLink)
                                end
                            end
                        elseif itemType == ITEMTYPE_TREASURE and specializedItemType == SPECIALIZED_ITEMTYPE_TREASURE then
                            if PAJunkSavedVars.Miscellaneous.autoMarkTreasure and _isTreasureItemNotQuestExcluded(itemLink) then
                                _markAsJunkIfPossible(bagId, slotIndex, SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TREASURE, itemLink)
                            else
                                PAHF.debuglnAuthor("Skipped %s because needed for Quest", itemLink)
                            end
                        end
                    end
                end

                -- -----------------------------------------------------------------------------------------------------
                -- any custom rules are always checked at the end
                if PAJunkSavedVars.Custom.customItemsEnabled then
                    local itemId = GetItemId(bagId, slotIndex)
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

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Junk = PA.Junk or {}
PA.Junk.OnFenceOpen = OnFenceOpen
PA.Junk.OnShopOpen = OnShopOpen
PA.Junk.OnStoreAndFenceClose = OnStoreAndFenceClose
PA.Junk.OnMailboxOpen = OnMailboxOpen
PA.Junk.OnMailboxClose = OnMailboxClose
PA.Junk.OnInventorySingleSlotUpdate = OnInventorySingleSlotUpdate
