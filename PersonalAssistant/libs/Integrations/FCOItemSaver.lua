-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
-- ---------------------------------------------------------------------------------------------------------------------

local SELL_MERCHANT_ITEMS_INTERVAL_MS = 25
local SELL_MERCHANT_CALL_LATER_FUNCTION_NAME = "CallLaterFunction_SellFence"


local function _getUniqueSellMerchantUpdateIdentifier(bagId, slotIndex)
    return table.concat({SELL_MERCHANT_CALL_LATER_FUNCTION_NAME, tostring(bagId), tostring(slotIndex)})
end

-- =================================================================================================================
-- == COMPARATORS == --
-- -----------------------------------------------------------------------------------------------------------------

local function _getMarkedForSellingNotLockedComparator()
    return function(itemData)
        -- first check if FCOIS is even running
        if not FCOIS then return false end
        -- then check if the item is stolen or ESO-locked (skip)
        if IsItemStolen(itemData.bagId, itemData.slotIndex) or IsItemPlayerLocked(itemData.bagId, itemData.slotIndex) then return false end
        -- now check if it was locked by FCOI
        local isMarkedAsLocked = FCOIS.IsMarked(itemData.bagId, itemData.slotIndex, FCOIS_CON_ICON_LOCK)
        if not isMarkedAsLocked then
            -- if not locked, check if marked for selling
            local isMarkedForSelling = FCOIS.IsMarked(itemData.bagId, itemData.slotIndex, FCOIS_CON_ICON_SELL)
            if isMarkedForSelling then
                local isVendorSellLocked = FCOIS.IsVendorSellLocked(itemData.bagId, itemData.slotIndex)
                if not isVendorSellLocked then
                    return true
                end
            end
        end
        return false
    end
end

-- =================================================================================================================

local function _sellItemToMerchant(bagCache, startIndex, totalSellPrice, totalSellCount)
    if not PA.WindowStates.isStoreClosed then
        local sellStartGameTime = GetGameTimeMilliseconds()
        local itemDataToSell = bagCache[startIndex]
        local _, stack, sellPrice = GetItemInfo(itemDataToSell.bagId, itemDataToSell.slotIndex)
        -- check if item can be sold (i.e it has a sell price)
        if sellPrice > 0 then
            SellInventoryItem(itemDataToSell.bagId, itemDataToSell.slotIndex, itemDataToSell.stackCount)
            -- ---------------------------------------------------------------------------------------------------------
            -- Now "wait" until the item sell has been complete/confirmed, or the limit is reached (or until fence is closed!)
            local identifier = _getUniqueSellMerchantUpdateIdentifier(itemDataToSell.bagId, itemDataToSell.slotIndex)
            EVENT_MANAGER:RegisterForUpdate(identifier, SELL_MERCHANT_ITEMS_INTERVAL_MS,
                function()
                    -- check if the item is still in the bag
                    local itemId = GetItemId(itemDataToSell.bagId, itemDataToSell.slotIndex)
                    if itemId <= 0 or PA.WindowStates.isStoreClosed then
                        -- if item is gone, or merchant closed stop the interval
                        EVENT_MANAGER:UnregisterForUpdate(identifier)
                        local sellFinishGameTime = GetGameTimeMilliseconds()
                        PAHF.debuglnAuthor("selling FCOIS item took %d ms", (sellFinishGameTime - sellStartGameTime))
                        totalSellPrice = totalSellPrice + sellPrice
                        totalSellCount = totalSellCount + 1
                        -- check if there are more items to be sold
                        local newStartIndex = startIndex + 1
                        if newStartIndex <= #bagCache then
                            -- yes, continue loop
                            _sellItemToMerchant(bagCache, newStartIndex, totalSellPrice, totalSellCount)
                        else
                            -- no, finish loop; after everything is sold, give feedback about the changes
--                            _giveSoldJunkFeedback(moneyBefore, itemCountInBagBefore)
                            -- TODO: to be implemented
                            df("FINISH: sold %d items for %d gold", totalSellCount, totalSellPrice)
                        end
                    end
                end)
            -- ---------------------------------------------------------------------------------------------------------
        else
            -- show message to player that Item cannot be sold because it's worthless
            local itemLink = GetItemLink(itemDataToSell.bagId, itemDataToSell.slotIndex, LINK_STYLE_BRACKETS)
            PA.Junk.println(SI_PA_CHAT_JUNK_FENCE_ITEM_WORTHLESS, itemLink)
            -- if item cannot be sold; continue with the next (if there are more)
            local newStartIndex = startIndex + 1
            if newStartIndex <= #bagCache then
                -- yes, continue loop
                _sellItemToMerchant(bagCache, newStartIndex, totalSellPrice, totalSellCount)
            else
                -- no, finish loop; after everything is sold, give feedback about the changes
--                _giveSoldJunkFeedback(moneyBefore, itemCountInBagBefore)
                -- TODO: to be implemented
                df("FINISH: sold %d items for %d gold", totalSellCount, totalSellPrice)
            end
        end


    else
        -- if Merchant has been closed, also display the feedback message
--        _giveSoldJunkFeedback(moneyBefore, itemCountInBagBefore)
        -- TODO: to be implemented
        df("CLOSED: sold %d items for %d gold", totalSellCount, totalSellPrice)
    end
end

-- =================================================================================================================

local function sellMarkedItemsAtMerchantIfPossible()
    local PAI = PA.Integration
    if PAI and FCOIS and PAI.SavedVars.FCOItemSaver.Sell.autoSellMarked then
        local fcoisCanBeSoldComparator = _getMarkedForSellingNotLockedComparator()
        local bagCache = SHARED_INVENTORY:GenerateFullSlotData(fcoisCanBeSoldComparator, BAG_BACKPACK)
        d("#bagCache = "..tostring(#bagCache))
        if #bagCache > 0 then
            _sellItemToMerchant(bagCache, 1, 0, 0)
        end
    end
end


-- -----------------------------------------------------------------------------------------------------------------
-- Export
PA.Libs = PA.Libs or {}
PA.Libs.FCOItemSaver = {
    sellMarkedItemsAtMerchantIfPossible = sellMarkedItemsAtMerchantIfPossible
}