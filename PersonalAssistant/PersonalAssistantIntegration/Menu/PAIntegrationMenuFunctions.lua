-- Local instances of Global tables --
local PA = PersonalAssistant
local PAI = PA.Integration
local PAMF = PA.MenuFunctions
local PAEM = PA.EventManager
local PAIProfileManager = PA.ProfileManager.PAIntegration

-- =====================================================================================================================

local isNoProfileSelected = PAIProfileManager.isNoProfileSelected

local function getValue(...)
    if isNoProfileSelected() then return true end
    return PAMF.getValue(PAI.SavedVars, ...)
end

local function setValue(value, ...)
    if isNoProfileSelected() then return true end
    PAMF.setValue(PAI.SavedVars, value, ...)
end

local function setValueAndRefreshEvents(value, ...)
    setValue(value, ...)
    PAEM.RefreshEventRegistration.PAIntegration()
end

local function isDisabled(...)
    if isNoProfileSelected() then return true end
    return PAMF.isDisabled(PAI.SavedVars, ...)
end

-- =================================================================================================================

--------------------------------------------------------------------------
-- PAIntegration    LazyWritCrafter             compatibility
---------------------------------
local function isPAIntegrationLazyWritCrafterCompatibilityDisabled()
    if isNoProfileSelected() then return true end
    if not PA.Banking then return true end
    return false
end

--------------------------------------------------------------------------
-- PAIntegration    FCOIS.Locked
---------------------------------
local function isPAIntegrationFCOISLockedMenuDisabled()
    if isNoProfileSelected() then return true end
    if not PA.Junk then return true end
    if isDisabled({"FCOItemSaver", "Locked", "preventAutoSell"}) then return true end
    return false
end

--------------------------------------------------------------------------
-- PAIntegration    FCOIS.Locked                preventAutoSell
---------------------------------
local function isPAIntegrationFCOISLockedPreventAutoSellDisabled()
    if isNoProfileSelected() then return true end
    if not PA.Junk then return true end
    return false
end

--------------------------------------------------------------------------
-- PAIntegration    FCOIS.Sell
---------------------------------
local function isPAIntegrationFCOISSellMenuDisabled()
    if isNoProfileSelected() then return true end
    if not PA.Junk then return true end
    if isDisabled({"FCOItemSaver", "Sell", "autoSellMarked"}) then return true end
    return false
end

--------------------------------------------------------------------------
-- PAIntegration    FCOIS.Sell                autoSellMarked
---------------------------------
local function isPAIntegrationFCOISSellAutoSellMarkedDisabled()
    if isNoProfileSelected() then return true end
    if not PA.Junk then return true end
    return false
end


-- =================================================================================================================
local PAIntegrationMenuFunctions = {
    -- ----------------------------------------------------------------------------------
    -- DOLGUBON'S LAZY WRIT CRAFTER
    -- -----------------------------
    isLazyWritCrafterCompatibilityDisabled = isPAIntegrationLazyWritCrafterCompatibilityDisabled,
    getLazyWritCrafterCompatibilitySetting = function() return getValue({"LazyWritCrafter", "compatibility"}) end,
    setLazyWritCrafterCompatibilitySetting = function(value) setValue(value, {"LazyWritCrafter", "compatibility"}) end,


    -- ----------------------------------------------------------------------------------
    -- FCO ITEMSAVER
    -- ----------------------------
    isFCOISLockedMenuDisabled = isPAIntegrationFCOISLockedMenuDisabled,
    isFCOISLockedPreventAutoSellDisabled = isPAIntegrationFCOISLockedPreventAutoSellDisabled,
    getFCOISLockedPreventAutoSellSetting = function() return getValue({"FCOItemSaver", "Locked", "preventAutoSell"}) end,
    setFCOISLockedPreventAutoSellSetting = function(value) setValueAndRefreshEvents(value, {"FCOItemSaver", "Locked", "preventAutoSell"}) end,

    isFCOISResearchMenuDisabled = function() return false end, -- TODO: to be implemented


    isFCOISSellMenuDisabled = isPAIntegrationFCOISSellMenuDisabled,
    isFCOISSellAutoSellMarkedDisabled = isPAIntegrationFCOISSellAutoSellMarkedDisabled,
    getFCOISSellAutoSellMarkedSetting = function() return getValue({"FCOItemSaver", "Sell", "autoSellMarked"}) end,
    setFCOISSellAutoSellMarkedSetting = function(value) setValueAndRefreshEvents(value, {"FCOItemSaver", "Sell", "autoSellMarked"}) end,

    isFCOISDeconstructionMenuDisabled = function() return true end, -- TODO: to be implemented


    isFCOISImprovementMenuDisabled = function() return true end, -- TODO: to be implemented


    isFCOISSellGuildStoreMenuDisabled = function() return true end, -- TODO: to be implemented


    isFCOISIntricateMenuDisabled = function() return true end, -- TODO: to be implemented


}

-- =====================================================================================================================
-- Export
PAMF.PAIntegration = PAIntegrationMenuFunctions