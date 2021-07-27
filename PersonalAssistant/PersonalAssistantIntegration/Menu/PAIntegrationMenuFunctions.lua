-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAI = PA.Integration
local PAMF = PA.MenuFunctions
local PAEM = PA.EventManager
local PAIProfileManager = PA.ProfileManager.PAIntegration

-- =====================================================================================================================

local isNoProfileSelected = PAIProfileManager.isNoProfileSelected

local function getValue(...)
    if isNoProfileSelected() then return end
    return PAMF.getValue(PAI.SavedVars, ...)
end

local function setValue(value, ...)
    if isNoProfileSelected() then return end
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

local function isDisabledAll(...)
    if isNoProfileSelected() then return true end
    return PAMF.isDisabledAll(PAI.SavedVars, ...)
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
    if isDisabledAll({"FCOItemSaver", "Locked", "preventAutoSell"}, {"FCOItemSaver", "Locked", "preventMoving"}) then return true end
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
-- PAIntegration    FCOIS.Locked                preventMoving
---------------------------------
local function isPAIntegrationFCOISLockedPreventMovingDisabled()
    if isNoProfileSelected() then return true end
    if not PA.Banking then return true end
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

--------------------------------------------------------------------------
-- PAIntegration    FCOIS.Deconstruction
---------------------------------
local function isPAIntegrationFCOISDeconstructionMenuDisabled()
    if isNoProfileSelected() then return true end
    if not PA.Banking then return true end
    if PAI.SavedVars.FCOItemSaver.Deconstruction.itemMoveMode == PAC.MOVE.IGNORE then return true end
    return false
end

--------------------------------------------------------------------------
-- PAIntegration    FCOIS.Deconstruction        itemMoveMode
---------------------------------
local function isPAIntegrationFCOISDeconstructionMarkedDisabled()
    if isNoProfileSelected() then return true end
    if not PA.Banking then return true end
    return false
end

--------------------------------------------------------------------------
-- PAIntegration    FCOIS.Improvement
---------------------------------
local function isPAIntegrationFCOISImprovementMenuDisabled()
    if isNoProfileSelected() then return true end
    if not PA.Banking then return true end
    if PAI.SavedVars.FCOItemSaver.Improvement.itemMoveMode == PAC.MOVE.IGNORE then return true end
    return false
end

--------------------------------------------------------------------------
-- PAIntegration    FCOIS.Improvement           itemMoveMode
---------------------------------
local function isPAIntegrationFCOISImprovementMarkedDisabled()
    if isNoProfileSelected() then return true end
    if not PA.Banking then return true end
    return false
end

--------------------------------------------------------------------------
-- PAIntegration    FCOIS.Research
---------------------------------
local function isPAIntegrationFCOISResearchMenuDisabled()
    if isNoProfileSelected() then return true end
    if not PA.Banking then return true end
    if PAI.SavedVars.FCOItemSaver.Research.itemMoveMode == PAC.MOVE.IGNORE then return true end
    return false
end

--------------------------------------------------------------------------
-- PAIntegration    FCOIS.Research              itemMoveMode
---------------------------------
local function isPAIntegrationFCOISResearchMarkedDisabled()
    if isNoProfileSelected() then return true end
    if not PA.Banking then return true end
    return false
end

--------------------------------------------------------------------------
-- PAIntegration    FCOIS.SellGuildStore
---------------------------------
local function isPAIntegrationFCOISSellGuildStoreMenuDisabled()
    if isNoProfileSelected() then return true end
    if not PA.Banking then return true end
    if PAI.SavedVars.FCOItemSaver.SellGuildStore.itemMoveMode == PAC.MOVE.IGNORE then return true end
    return false
end

--------------------------------------------------------------------------
-- PAIntegration    FCOIS.SellGuildStore        itemMoveMode
---------------------------------
local function isPAIntegrationFCOISSellGuildStoreMarkedDisabled()
    if isNoProfileSelected() then return true end
    if not PA.Banking then return true end
    return false
end

--------------------------------------------------------------------------
-- PAIntegration    FCOIS.Intricate
---------------------------------
local function isPAIntegrationFCOISIntricateMenuDisabled()
    if isNoProfileSelected() then return true end
    if not PA.Banking then return true end
    if PAI.SavedVars.FCOItemSaver.Intricate.itemMoveMode == PAC.MOVE.IGNORE then return true end
    return false
end

--------------------------------------------------------------------------
-- PAIntegration    FCOIS.Intricate             itemMoveMode
---------------------------------
local function isPAIntegrationFCOISIntricateMarkedDisabled()
    if isNoProfileSelected() then return true end
    if not PA.Banking then return true end
    return false
end

--------------------------------------------------------------------------
-- PAIntegration    FCOIS.GearSets
---------------------------------
local function isPAIntegrationFCOISGearSetsMenuDisabled()
    if isNoProfileSelected() then return true end
    if not PA.Banking then return true end
    -- TODO: check all gear sets 1..5
    return false
end

--------------------------------------------------------------------------
-- PAIntegration    FCOIS.DynamicIcons
---------------------------------
local function isPAIntegrationFCOISDynamicIconsMenuDisabled()
    if isNoProfileSelected() then return true end
    if not PA.Banking then return true end
    -- TODO: check all dynamic icons 1..30
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
    isFCOISLockedPreventMovingDisabled = isPAIntegrationFCOISLockedPreventMovingDisabled,
    getFCOISLockedPreventMovingSetting = function() return getValue({"FCOItemSaver", "Locked", "preventMoving"}) end,
    setFCOISLockedPreventMovingSetting = function(value) setValue(value, {"FCOItemSaver", "Locked", "preventMoving"}) end,

    isFCOISSellMenuDisabled = isPAIntegrationFCOISSellMenuDisabled,
    isFCOISSellAutoSellMarkedDisabled = isPAIntegrationFCOISSellAutoSellMarkedDisabled,
    getFCOISSellAutoSellMarkedSetting = function() return getValue({"FCOItemSaver", "Sell", "autoSellMarked"}) end,
    setFCOISSellAutoSellMarkedSetting = function(value) setValueAndRefreshEvents(value, {"FCOItemSaver", "Sell", "autoSellMarked"}) end,

    isFCOISDeconstructionMenuDisabled = isPAIntegrationFCOISDeconstructionMenuDisabled,
    isFCOISDeconstructionItemMoveModeDisabled = isPAIntegrationFCOISDeconstructionMarkedDisabled,
    getFCOISDeconstructionItemMoveModeSetting = function() return getValue({"FCOItemSaver", "Deconstruction", "itemMoveMode"}) end,
    setFCOISDeconstructionItemMoveModeSetting = function(value) setValue(value, {"FCOItemSaver", "Deconstruction", "itemMoveMode"}) end,

    isFCOISImprovementMenuDisabled = isPAIntegrationFCOISImprovementMenuDisabled,
    isFCOISImprovementItemMoveModeDisabled = isPAIntegrationFCOISImprovementMarkedDisabled,
    getFCOISImprovementItemMoveModeSetting = function() return getValue({"FCOItemSaver", "Improvement", "itemMoveMode"}) end,
    setFCOISImprovementItemMoveModeSetting = function(value) setValue(value, {"FCOItemSaver", "Improvement", "itemMoveMode"}) end,

    isFCOISResearchMenuDisabled = isPAIntegrationFCOISResearchMenuDisabled,
    isFCOISResearchItemMoveModeDisabled = isPAIntegrationFCOISResearchMarkedDisabled,
    getFCOISResearchItemMoveModeSetting = function() return getValue({"FCOItemSaver", "Research", "itemMoveMode"}) end,
    setFCOISResearchItemMoveModeSetting = function(value) setValue(value, {"FCOItemSaver", "Research", "itemMoveMode"}) end,

    isFCOISSellGuildStoreMenuDisabled = isPAIntegrationFCOISSellGuildStoreMenuDisabled,
    isFCOISSellGuildStoreItemMoveModeDisabled = isPAIntegrationFCOISSellGuildStoreMarkedDisabled,
    getFCOISSellGuildStoreItemMoveModeSetting = function() return getValue({"FCOItemSaver", "SellGuildStore", "itemMoveMode"}) end,
    setFCOISSellGuildStoreItemMoveModeSetting = function(value) setValue(value, {"FCOItemSaver", "SellGuildStore", "itemMoveMode"}) end,

    isFCOISIntricateMenuDisabled = isPAIntegrationFCOISIntricateMenuDisabled,
    isFCOISIntricateItemMoveModeDisabled = isPAIntegrationFCOISIntricateMarkedDisabled,
    getFCOISIntricateItemMoveModeSetting = function() return getValue({"FCOItemSaver", "Intricate", "itemMoveMode"}) end,
    setFCOISIntricateItemMoveModeSetting = function(value) setValue(value, {"FCOItemSaver", "Intricate", "itemMoveMode"}) end,

    isFCOISGearSetsMenuDisabled = isPAIntegrationFCOISGearSetsMenuDisabled,

    isFCOISDynamicIconsMenuDisabled = isPAIntegrationFCOISDynamicIconsMenuDisabled,

}

-- =====================================================================================================================
-- Export
PAMF.PAIntegration = PAIntegrationMenuFunctions