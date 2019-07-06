-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAI = PA.Integration
local PAMD = PA.MenuDefaults
local PAMF = PA.MenuFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local isDisabledPAGeneralNoProfileSelected = PAMF.isDisabledPAGeneralNoProfileSelected

local function getValue(...)
    return PAMF.getValue(PAI.SavedVars, ...)
end

local function setValue(value, ...)
    PAMF.setValue(PAI.SavedVars, value, ...)
end

local function setValueAndRefreshEvents(value, ...)
    PAMF.setValueAndRefreshEvents(PAI.SavedVars, value, ...)
end

local function isDisabled(...)
    return PAMF.isDisabled(PAI.SavedVars, ...)
end

-- =================================================================================================================

--------------------------------------------------------------------------
-- PAIntegration    LazyWritCrafter             compatibility
---------------------------------
local function isPAIntegrationLazyWritCrafterCompatibilityDisabled()
    if isDisabledPAGeneralNoProfileSelected() then return end
    if not PA.Banking then return true end
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
    isFCOISLockedMenuDisabled = function() return true end, -- TODO: to be implemented


    isFCOISResearchMenuDisabled = function() return false end, -- TODO: to be implemented


    isFCOISSellMenuDisabled = function() return isDisabled({"FCOItemSaver", "Sell", "autoSellMarked"}) end,
    isFCOISSellAutoSellMarkedDisabled = function() return not istable(PA.Junk) end,
    getFCOISSellAutoSellMarkedSetting = function() return getValue({"FCOItemSaver", "Sell", "autoSellMarked"}) end,
    setFCOISSellAutoSellMarkedSetting = function(value) setValue(value, {"FCOItemSaver", "Sell", "autoSellMarked"}) end,

    isFCOISDeconstructionMenuDisabled = function() return true end, -- TODO: to be implemented


    isFCOISImprovementMenuDisabled = function() return true end, -- TODO: to be implemented


    isFCOISSellGuildStoreMenuDisabled = function() return true end, -- TODO: to be implemented


    isFCOISIntricateMenuDisabled = function() return true end, -- TODO: to be implemented


}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PAMF.PAIntegration = PAIntegrationMenuFunctions