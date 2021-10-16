-- Local instances of Global tables --
local PA = PersonalAssistant
local PAHF = PA.HelperFunctions
-- ---------------------------------------------------------------------------------------------------------------------

local FCOIS

local function isFCOISLoadedProperly()
    if _G["FCOIS"] ~= nil and _G["FCOIS"].libsLoadedProperly then
        FCOIS = _G["FCOIS"]
        return true
    end
end

local function _isItemFCOISSellLocked(bagId, slotIndex)
    local isMarkedAsLocked = FCOIS.IsMarked(bagId, slotIndex, FCOIS_CON_ICON_LOCK)
    local isVendorSellLocked = FCOIS.IsVendorSellLocked(bagId, slotIndex)
    return isMarkedAsLocked or isVendorSellLocked
end

local function isItemFCOISMoveLocked(bagId, slotIndex)
    local isMarkedAsLocked = FCOIS.IsMarked(bagId, slotIndex, FCOIS_CON_ICON_LOCK)
    return isMarkedAsLocked
end

local function _hasItemPassedStolenCheck(mustBeStolen, bagId, slotIndex)
    local isStolen = IsItemStolen(bagId, slotIndex)
    return isStolen == mustBeStolen
end

local function getCurrentFCOISFlags()
    -- init flags with false
    local autoSellMarked = false
    local lockedPreventsAutoSell = false
    local lockedPreventsMoving = false
    -- if PAIntegration and FCOIS are running, update the flags with values from SavedVars
    if PA.Integration and isFCOISLoadedProperly() then
        local PAIFCOISSavedVars = PA.Integration.SavedVars.FCOItemSaver
        autoSellMarked = PAIFCOISSavedVars.Sell.autoSellMarked
        lockedPreventsAutoSell = PAIFCOISSavedVars.Locked.preventAutoSell
        lockedPreventsMoving = PAIFCOISSavedVars.Locked.preventMoving
    end
    return autoSellMarked, lockedPreventsAutoSell, lockedPreventsMoving
end

-- =================================================================================================================
-- == COMPARATORS == --
-- -----------------------------------------------------------------------------------------------------------------

local function _getDynamicSellJunkIncludingFCOISComparator(mustBeStolen)
    -- init flags
    local autoSellMarked, lockedPreventsAutoSell = getCurrentFCOISFlags()

    return function(itemData)
        local bagId = itemData.bagId
        local slotIndex = itemData.slotIndex

        -- if item must be stolen but is not (or vice-versa) then exit comparator as it is not a valid combination
        if not _hasItemPassedStolenCheck(mustBeStolen, bagId, slotIndex) then return false end

        if isFCOISLoadedProperly() then
            -- if FCOIS is running, check if the item is sell-locked (and locked prevents auto-sell)
            if _isItemFCOISSellLocked(bagId, slotIndex) and lockedPreventsAutoSell then return false end

            -- if FCOIS is running and item is NOT locked (or it is ignored), check if it is marked for selling
            local isMarkedForSelling = FCOIS.IsMarked(bagId, slotIndex, FCOIS_CON_ICON_SELL)
            if isMarkedForSelling and autoSellMarked then return true end
        end

        -- if FCOIS is NOT running, or if there was no match with the markings, just return true if the item is junk
        local isJunk = IsItemJunk(bagId, slotIndex)
        return isJunk
    end
end

local function _getDynamicSellFCOISComparator(mustBeStolen)
    -- init flags
    local autoSellMarked, lockedPreventsAutoSell = getCurrentFCOISFlags()

    return function(itemData)
        local bagId = itemData.bagId
        local slotIndex = itemData.slotIndex

        -- if item must be stolen but is not (or vice-versa) then exit comparator as it is not a valid combination
        if not _hasItemPassedStolenCheck(mustBeStolen, bagId, slotIndex) then return false end

        if isFCOISLoadedProperly() then
            -- if FCOIS is running, check if the item is sell-locked (and locked prevents auto-sell)
            if _isItemFCOISSellLocked(bagId, slotIndex) and lockedPreventsAutoSell then return false end

            -- if FCOIS is running and item is NOT locked (or it is ignored), check if it is marked for selling
            local isMarkedForSelling = FCOIS.IsMarked(bagId, slotIndex, FCOIS_CON_ICON_SELL)
            if isMarkedForSelling and autoSellMarked then return true end
        end

        -- if FCOIS is NOT running, or if there were was no match with the markings, return false
        return false
    end
end

local function _getDynamicItemMoveFCOISComparator(fcoisFlagList, excludeJunk, skipItemsWithCustomRule)
    -- init flags
    local _, _, lockedPreventsMoving = getCurrentFCOISFlags()

    return function(itemData)
        local bagId = itemData.bagId
        local slotIndex = itemData.slotIndex

        if #fcoisFlagList == 0 then return false end
        if IsItemJunk(bagId, slotIndex) and excludeJunk then return false end
        if IsItemStolen(bagId, slotIndex) then return false end
        if PAHF.isItemCharacterBound(itemData) then return false end
        if skipItemsWithCustomRule and PA.Banking.hasItemActiveCustomRule(bagId, slotIndex) then return false end

        if isFCOISLoadedProperly() then
            -- if FCOIS is running, check if the item is locked (and locked prevents moving)
            if isItemFCOISMoveLocked(bagId, slotIndex) and lockedPreventsMoving then return false end

            -- if FCOIS is running and item is NOT locked (or it is ignored), check if it is marked for moving
            for _, fcoisFlag in pairs(fcoisFlagList) do
                if FCOIS.IsMarked(bagId, slotIndex, fcoisFlag) then return true end
            end
        end

        -- if FCOIS is NOT running, or if there were was no match with the markings, return false
        return false
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

local function getSellStolenJunkIncludingFCOISComparator()
    return _getDynamicSellJunkIncludingFCOISComparator(true) -- mustBeStolen = true
end

local function getSellStolenFCOISComparator()
    return _getDynamicSellFCOISComparator(true) -- mustBeStolen = true
end

local function getSellJunkIncludingFCOISComparator()
    return _getDynamicSellJunkIncludingFCOISComparator(false) -- mustBeStolen = false
end

local function getSellFCOISComparator()
    return _getDynamicSellFCOISComparator(false) -- mustBeStolen = false
end

local function getItemMoveFCOISComparator(fcoisFlagList)
    return _getDynamicItemMoveFCOISComparator(fcoisFlagList, true, true)
end

-- -----------------------------------------------------------------------------------------------------------------
-- Export
PA.Libs = PA.Libs or {}
PA.Libs.FCOItemSaver = {
    isFCOISLoadedProperly = isFCOISLoadedProperly,
    isItemFCOISMoveLocked = isItemFCOISMoveLocked,
    getCurrentFCOISFlags = getCurrentFCOISFlags,
    getSellStolenJunkIncludingFCOISComparator = getSellStolenJunkIncludingFCOISComparator,
    getSellStolenFCOISComparator = getSellStolenFCOISComparator,
    getSellJunkIncludingFCOISComparator = getSellJunkIncludingFCOISComparator,
    getSellFCOISComparator = getSellFCOISComparator,
    getItemMoveFCOISComparator = getItemMoveFCOISComparator,
}