-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAW = PA.Worker
local PAMF = PA.MenuFunctions
local PAEM = PA.EventManager
local PARProfileManager = PA.ProfileManager.PAWorker
local PASavedVars = PA.SavedVars

-- =====================================================================================================================

local isNoProfileSelected = PARProfileManager.isNoProfileSelected

local function getValue(...)
    if isNoProfileSelected() then return end
    return PAMF.getValue(PAW.SavedVars, ...)
end

local function setValue(value, ...)
    if isNoProfileSelected() then return end
    PAMF.setValue(PAW.SavedVars, value, ...)
end

local function setValueAndRefreshEvents(value, ...)
    setValue(value, ...)
    PAEM.RefreshEventRegistration.PAWorker()
end

local function isDisabled(...)
    if isNoProfileSelected() then return true end
    return PAMF.isDisabled(PAW.SavedVars, ...)
end

local function isDisabledAll(...)
    if isNoProfileSelected() then return true end
    return PAMF.isDisabledAll(PAW.SavedVars, ...)
end

-- =================================================================================================================

--------------------------------------------------------------------------
-- PAWorker   Weapons
---------------------------------
local function isPAWorkerWeaponsMenuDisabled()
    if isDisabled({"autoDeconstructEnabled"}) then return true end
    if isDisabled({"Weapons", "autoMarkOrnate"}) and isDisabled({"Weapons", "autoMarkIntricateTrait"}) and getValue({"Weapons", "autoMarkQualityThreshold"}) == PAC.ITEM_QUALITY.DISABLED then
        return true
    end
    -- if no 'true' returned so far, return false now
    return false
end

--------------------------------------------------------------------------
-- PAWorker   Armor
---------------------------------
local function isPAWorkerArmorMenuDisabled()
    if isDisabled({"autoDeconstructEnabled"}) then return true end
    if isDisabled({"Armor", "autoMarkOrnate"}) and isDisabled({"Armor", "autoMarkIntricateTrait"}) and getValue({"Armor", "autoMarkQualityThreshold"}) == PAC.ITEM_QUALITY.DISABLED then
        return true
    end
    -- if no 'true' returned so far, return false now
    return false
end

--------------------------------------------------------------------------
-- PAWorker   Jewelry
---------------------------------
local function isPAWorkerJewelryMenuDisabled()
    if isDisabled({"autoDeconstructEnabled"}) then return true end
    if isDisabled({"Jewelry", "autoMarkOrnate"}) and isDisabled({"Jewelry", "autoMarkIntricateTrait"}) and getValue({"Jewelry", "autoMarkQualityThreshold"}) == PAC.ITEM_QUALITY.DISABLED then
        return true
    end
    -- if no 'true' returned so far, return false now
    return false
end

-- =================================================================================================================

local PAWorkerMenuFunctions = {

    getMeticulousDisassemblySetting = function() return getValue({"CheckMeticulousDisassembly"}) end,
    setMeticulousDisassemblySetting = function(value) setValue(value, {"CheckMeticulousDisassembly"}) end,

    -- -----------------------------------------------------------------------------------
    -- auto deconstruct
    -- -----------------------------
    getAutoDeconstructSetting = function() return getValue({"autoDeconstructEnabled"}) end,
    setAutoDeconstructSetting = function(value) setValueAndRefreshEvents(value, {"autoDeconstructEnabled"}) end,
	
	isProtectBankDisabled = function() return isDisabled({"autoDeconstructEnabled"}) end,
	getProtectBankSetting = function() return getValue({"ProtectBank"}) end,
    setProtectBankSetting = function(value) setValue(value, {"ProtectBank"}) end,
	
	isProtectUncollectedSetItemsDisabled = function() return isDisabled({"autoDeconstructEnabled"}) end,
	getProtectUncollectedSetItemsSetting = function() return getValue({"ProtectUncollectedSetItems"}) end,
    setProtectUncollectedSetItemsSetting = function(value) setValue(value, {"ProtectUncollectedSetItems"}) end,
	
	isWeaponsMenuDisabled = isPAWorkerWeaponsMenuDisabled,
    isWeaponsAutoMarkOrnateDisabled = function() return isDisabled({"autoDeconstructEnabled"}) end,
    getWeaponsAutoMarkOrnateSetting = function() return getValue({"Weapons", "autoMarkOrnate"}) end,
    setWeaponsAutoMarkOrnateSetting = function(value) setValue(value, {"Weapons", "autoMarkOrnate"}) end,
    isWeaponsAutoMarkQualityThresholdDisabled = function() return isDisabled({"autoDeconstructEnabled"}) end,
    getWeaponsAutoMarkQualityThresholdSetting = function() return getValue({"Weapons", "autoMarkQualityThreshold"}) end,
    setWeaponsAutoMarkQualityThresholdSetting = function(value) setValue(value, {"Weapons", "autoMarkQualityThreshold"}) end,
    isWeaponsIncludeSetItemsDisabled = isPAWorkerWeaponsMenuDisabled,
    getWeaponsIncludeSetItemsSetting = function() return getValue({"Weapons", "autoMarkIncludingSets"}) end,
    setWeaponsIncludeSetItemsSetting = function(value) setValue(value, {"Weapons", "autoMarkIncludingSets"}) end,
    isWeaponsIncludeIntricateTraitDisabled = function() return isDisabled({"autoDeconstructEnabled"}) end,
    getWeaponsIncludeIntricateTraitSetting = function() return getValue({"Weapons", "autoMarkIntricateTrait"}) end,
    setWeaponsIncludeIntricateTraitSetting = function(value) setValue(value, {"Weapons", "autoMarkIntricateTrait"}) end,
    isWeaponsIncludeKnownTraitsDisabled = isPAWorkerWeaponsMenuDisabled,
    getWeaponsIncludeKnownTraitsSetting = function() return getValue({"Weapons", "autoMarkKnownTraits"}) end,
    setWeaponsIncludeKnownTraitsSetting = function(value) setValue(value, {"Weapons", "autoMarkKnownTraits"}) end,
    isWeaponsIncludeUnknownTraitsDisabled = isPAWorkerWeaponsMenuDisabled,
    getWeaponsIncludeUnknownTraitsSetting = function() return getValue({"Weapons", "autoMarkUnknownTraits"}) end,
    setWeaponsIncludeUnknownTraitsSetting = function(value) setValue(value, {"Weapons", "autoMarkUnknownTraits"}) end,
	
    isArmorMenuDisabled = isPAWorkerArmorMenuDisabled,
    isArmorAutoMarkOrnateDisabled = function() return isDisabled({"autoDeconstructEnabled"}) end,
    getArmorAutoMarkOrnateSetting = function() return getValue({"Armor", "autoMarkOrnate"}) end,
    setArmorAutoMarkOrnateSetting = function(value) setValue(value, {"Armor", "autoMarkOrnate"}) end,
    isArmorAutoMarkQualityThresholdDisabled = function() return isDisabled({"autoDeconstructEnabled"}) end,
    getArmorAutoMarkQualityThresholdSetting = function() return getValue({"Armor", "autoMarkQualityThreshold"}) end,
    setArmorAutoMarkQualityThresholdSetting = function(value) setValue(value, {"Armor", "autoMarkQualityThreshold"}) end,
    isArmorIncludeSetItemsDisabled = isPAWorkerArmorMenuDisabled,
    getArmorIncludeSetItemsSetting = function() return getValue({"Armor", "autoMarkIncludingSets"}) end,
    setArmorIncludeSetItemsSetting = function(value) setValue(value, {"Armor", "autoMarkIncludingSets"}) end,
    isArmorIncludeIntricateTraitDisabled = function() return isDisabled({"autoDeconstructEnabled"}) end,
    getArmorIncludeIntricateTraitSetting = function() return getValue({"Armor", "autoMarkIntricateTrait"}) end,
    setArmorIncludeIntricateTraitSetting = function(value) setValue(value, {"Armor", "autoMarkIntricateTrait"}) end,
    isArmorIncludeKnownTraitsDisabled = isPAWorkerArmorMenuDisabled,
    getArmorIncludeKnownTraitsSetting = function() return getValue({"Armor", "autoMarkKnownTraits"}) end,
    setArmorIncludeKnownTraitsSetting = function(value) setValue(value, {"Armor", "autoMarkKnownTraits"}) end,
    isArmorIncludeUnknownTraitsDisabled = isPAWorkerArmorMenuDisabled,
    getArmorIncludeUnknownTraitsSetting = function() return getValue({"Armor", "autoMarkUnknownTraits"}) end,
    setArmorIncludeUnknownTraitsSetting = function(value) setValue(value, {"Armor", "autoMarkUnknownTraits"}) end,
	
    isJewelryMenuDisabled = isPAWorkerJewelryMenuDisabled,
    isJewelryAutoMarkOrnateDisabled = function() return isDisabled({"autoDeconstructEnabled"}) end,
    getJewelryAutoMarkOrnateSetting = function() return getValue({"Jewelry", "autoMarkOrnate"}) end,
    setJewelryAutoMarkOrnateSetting = function(value) setValue(value, {"Jewelry", "autoMarkOrnate"}) end,
    isJewelryAutoMarkQualityThresholdDisabled = function() return isDisabled({"autoDeconstructEnabled"}) end,
    getJewelryAutoMarkQualityThresholdSetting = function() return getValue({"Jewelry", "autoMarkQualityThreshold"}) end,
    setJewelryAutoMarkQualityThresholdSetting = function(value) setValue(value, {"Jewelry", "autoMarkQualityThreshold"}) end,
    isJewelryIncludeSetItemsDisabled = isPAWorkerJewelryMenuDisabled,
    getJewelryIncludeSetItemsSetting = function() return getValue({"Jewelry", "autoMarkIncludingSets"}) end,
    setJewelryIncludeSetItemsSetting = function(value) setValue(value, {"Jewelry", "autoMarkIncludingSets"}) end,
    isJewelryIncludeIntricateTraitDisabled = function() return isDisabled({"autoDeconstructEnabled"}) end,
    getJewelryIncludeIntricateTraitSetting = function() return getValue({"Jewelry", "autoMarkIntricateTrait"}) end,
    setJewelryIncludeIntricateTraitSetting = function(value) setValue(value, {"Jewelry", "autoMarkIntricateTrait"}) end,
    isJewelryIncludeKnownTraitsDisabled = isPAWorkerJewelryMenuDisabled,
    getJewelryIncludeKnownTraitsSetting = function() return getValue({"Jewelry", "autoMarkKnownTraits"}) end,
    setJewelryIncludeKnownTraitsSetting = function(value) setValue(value, {"Jewelry", "autoMarkKnownTraits"}) end,
    isJewelryIncludeUnknownTraitsDisabled = isPAWorkerJewelryMenuDisabled,
    getJewelryIncludeUnknownTraitsSetting = function() return getValue({"Jewelry", "autoMarkUnknownTraits"}) end,
    setJewelryIncludeUnknownTraitsSetting = function(value) setValue(value, {"Jewelry", "autoMarkUnknownTraits"}) end,
	
	isGlyphMenuDisabled = function() return isDisabled({"autoDeconstructEnabled"}) end,
    isGlyphsAutoMarkQualityTresholdDisabled = function() return isDisabled({"autoDeconstructEnabled"}) end,	
    getGlyphsAutoMarkQualityTresholdSetting = function() return getValue({"Miscellaneous", "autoMarkGlyphQualityThreshold"}) end,
    setGlyphsAutoMarkQualityTresholdSetting = function(value) setValue(value, {"Miscellaneous", "autoMarkGlyphQualityThreshold"}) end,

    -- -----------------------------------------------------------------------------------
    -- auto refine
    -- -----------------------------
    getAutoRefineSetting = function() return getValue({"autoRefineEnabled"}) end,
    setAutoRefineSetting = function(value) setValueAndRefreshEvents(value, {"autoRefineEnabled"}) end,
	
	isRefinableMaterialDisabled = function() return isDisabled({"autoRefineEnabled"}) end,
	getRefinableMaterialSetting = function(formatedValue) return getValue(formatedValue) end, 
	setRefinableMaterialSetting = function(value, formatedValue) setValue(value, formatedValue) end,
	
	AreRefineSubmenusDisabled = function() return isDisabled({"autoRefineEnabled"}) end,
	
	isCheckExtractionDisabled = function() return isDisabled({"autoRefineEnabled"}) end,
	getCheckExtractionSetting = function() return getValue({"checkExtraction"}) end,
	setCheckExtractionSetting = function(value) setValue(value, {"checkExtraction"}) end,
	
    -- -----------------------------------------------------------------------------------
    -- auto research trait
    -- -----------------------------	
    getAutoResearchTraitSetting = function() return getValue({"autoResearchTraitEnabled"}) end,
    setAutoResearchTraitSetting = function(value) setValueAndRefreshEvents(value, {"autoResearchTraitEnabled"}) end,	
	
 	isTraitDisabled = function() return isDisabled({"autoResearchTraitEnabled"}) end,
	getTraitSetting = function(formatedValue) return getValue(formatedValue) end, 
	setTraitSetting = function(value, formatedValue) setValue(value, formatedValue) end,
	
	AreTraitSubmenusDisabled = function() return isDisabled({"autoResearchTraitEnabled"}) end,   
	
    -- -----------------------------------------------------------------------------------
    -- SILENT MODE
    -- -----------------------------
    isSilentModeDisabled = function() return isDisabledAll({"autoRefineEnabled"}, {"autoDeconstructEnabled"}) end,
    getSilentModeSetting = function() return getValue({"silentMode"}) end,
    setSilentModeSetting = function(value) setValue(value, {"silentMode"}) end,

}

-- =====================================================================================================================
-- Export
PAMF.PAWorker = PAWorkerMenuFunctions
