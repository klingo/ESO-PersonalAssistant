-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
-- ---------------------------------------------------------------------------------------------------------------------

-- =================================================================================================================
-- == COMPARATORS == --
-- -----------------------------------------------------------------------------------------------------------------

local function _getDynamicSellJunkIncludingFCOISComparator(autoSellMarked, mustBeStolen)
    return function(itemData)
        local isStolen = IsItemStolen(itemData.bagId, itemData.slotIndex)
        -- if item must be stolen but is not (or vice-versa) then exit comparator as it is not a valid combination
        if (mustBeStolen and not isStolen) or (not mustBeStolen and isStolen) then return false end

        local isJunk = IsItemJunk(itemData.bagId, itemData.slotIndex)
        -- if FCOIS is NOT running, then just return true if the item is junk (or false if not junk)
        if not FCOIS then return isJunk end

        -- if FCOIS is running, start checking for the FCOIS flags
        local isMarkedAsLocked = FCOIS.IsMarked(itemData.bagId, itemData.slotIndex, FCOIS_CON_ICON_LOCK)
        local isVendorSellLocked = FCOIS.IsVendorSellLocked(itemData.bagId, itemData.slotIndex)
        -- if it is locked by FCOIS, immediately return false as it should not be sold
        if isMarkedAsLocked or isVendorSellLocked then return false end
        -- item is NOT locked by FCOIS, if it is junk return true (default PA behaviour with FCOIS locks)
        if isJunk then return true end

        -- check if marked items should be sold or not
        if autoSellMarked then
            -- item is NOT locked by FCOIS and is NOT junk, but it is stolen; check if it is marked for selling
            local isMarkedForSelling = FCOIS.IsMarked(itemData.bagId, itemData.slotIndex, FCOIS_CON_ICON_SELL)
            -- if stolen and marked for selling, return true - otherwise false
            return (isStolen == mustBeStolen) and isMarkedForSelling
        end
        return false
    end
end

local function _getDynamicSellFCOISComparator(autoSellMarked, mustBeStolen)
    return function(itemData)
        -- if marked items should not be sold (or FCOIS is not running) then immediately stop here
        if not autoSellMarked or not FCOIS then return false end

        local isStolen = IsItemStolen(itemData.bagId, itemData.slotIndex)
        -- if item must be stolen but is not (or vice-versa) then exit comparator as it is not a valid combination
        if (mustBeStolen and not isStolen) or (not mustBeStolen and isStolen) then return false end

        -- if FCOIS is running, start checking for the FCOIS flags
        local isMarkedAsLocked = FCOIS.IsMarked(itemData.bagId, itemData.slotIndex, FCOIS_CON_ICON_LOCK)
        local isVendorSellLocked = FCOIS.IsVendorSellLocked(itemData.bagId, itemData.slotIndex)
        -- if it is locked by FCOIS, immediately return false as it should not be sold
        if isMarkedAsLocked or isVendorSellLocked then return false end

        -- item is NOT locked by FCOIS; check if it is marked for selling
        local isMarkedForSelling = FCOIS.IsMarked(itemData.bagId, itemData.slotIndex, FCOIS_CON_ICON_SELL)
        -- if stolen-check is passed and marked for selling, return true - otherwise false
        return (isStolen == mustBeStolen) and isMarkedForSelling
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

local function getSellStolenJunkIncludingFCOISComparator(autoSellMarked)
    return _getDynamicSellJunkIncludingFCOISComparator(autoSellMarked, true) -- mustBeStolen = true
end

local function getSellStolenFCOISComparator(autoSellMarked)
    return _getDynamicSellFCOISComparator(autoSellMarked, true) -- mustBeStolen = true
end

local function getSellJunkIncludingFCOISComparator(autoSellMarked)
    return _getDynamicSellJunkIncludingFCOISComparator(autoSellMarked, false) -- mustBeStolen = false
end

local function getSellFCOISComparator(autoSellMarked)
    return _getDynamicSellFCOISComparator(autoSellMarked, false) -- mustBeStolen = false
end

-- -----------------------------------------------------------------------------------------------------------------
-- Export
PA.Libs = PA.Libs or {}
PA.Libs.FCOItemSaver = {
    getSellStolenJunkIncludingFCOISComparator = getSellStolenJunkIncludingFCOISComparator,
    getSellStolenFCOISComparator = getSellStolenFCOISComparator,
    getSellJunkIncludingFCOISComparator = getSellJunkIncludingFCOISComparator,
    getSellFCOISComparator = getSellFCOISComparator,
}