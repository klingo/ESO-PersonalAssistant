-- Local instances of Global tables --
local PA = PersonalAssistant
local PASV = PA.SavedVars
local PAEM = PA.EventManager
local PAMF = PA.MenuFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local getValue = PAMF.getValue
local setValue = PAMF.setValue
local isDisabled = PAMF.isDisabled

-- =================================================================================================================

--------------------------------------------------------------------------
-- PAJunk   autoMarkAsJunkEnabled
---------------------------------
local function setPAJunkAutoMarkAsJunkEnabledSetting(value)
    setValue(PASV.Junk, value, {"autoMarkAsJunkEnabled"})
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

--------------------------------------------------------------------------
-- PAJunk   Weapons
---------------------------------
local function isPAJunkWeaponsMenuDisabled()
    if isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}) then return true end
    if isDisabled(PASV.Junk, {"Weapons", "autoMarkOrnate"}) and isDisabled(PASV.Junk, {"Weapons", "autoMarkQuality"}) then return true end
    return false
end

--------------------------------------------------------------------------
-- PAJunk   Weapons     autoMarkAsJunkEnabled
---------------------------------
local function isPAJunkWeaponsAdditionalSettingsDisabled()
    -- same config like the menu overall
    return isPAJunkWeaponsMenuDisabled()
end

--------------------------------------------------------------------------
-- PAJunk   Armor
---------------------------------
local function isPAJunkArmorMenuDisabled()
    if isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}) then return true end
    if isDisabled(PASV.Junk, {"Armor", "autoMarkOrnate"}) and isDisabled(PASV.Junk, {"Armor", "autoMarkQuality"}) then return true end
    return false
end

--------------------------------------------------------------------------
-- PAJunk   Armor     autoMarkAsJunkEnabled
---------------------------------
local function isPAJunkArmorAdditionalSettingsDisabled()
    -- same config like the menu overall
    return isPAJunkArmorMenuDisabled()
end

--------------------------------------------------------------------------
-- PAJunk   Jewelry
---------------------------------
local function isPAJunkJewelryMenuDisabled()
    if isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}) then return true end
    if isDisabled(PASV.Junk, {"Jewelry", "autoMarkOrnate"}) and isDisabled(PASV.Junk, {"Jewelry", "autoMarkQuality"}) then return true end
    return false
end

--------------------------------------------------------------------------
-- PAJunk   Jewelry     autoMarkAsJunkEnabled
---------------------------------
local function isPAJunkJewelryAdditionalSettingsDisabled()
    -- same config like the menu overall
    return isPAJunkJewelryMenuDisabled()
end

-- =================================================================================================================

local PAJunkMenuFunctions = {
    getAutoMarkAsJunkEnabledSetting = function() return getValue(PASV.Junk, {"autoMarkAsJunkEnabled"}) end,
    setAutoMarkAsJunkEnabledSetting = setPAJunkAutoMarkAsJunkEnabledSetting,

    isChatOutputDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}) end,
    getChatOutputSetting = function() return getValue(PASV.Junk, {"chatOutput"}) end,
    setChatOutputSetting = function(value) setValue(PASV.Junk, value, {"chatOutput"}) end,

    -- ----------------------------------------------------------------------------------
    -- AUTO MARK JUNK
    -- -----------------------------
    isAutoMarkAsJunkMenuDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}) end,

    isTrashMenuDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}, {"Trash", "autoMarkTrash"}) end,  -- TODO: to extend
    isTrashAutoMarkDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}) end,
    getTrashAutoMarkSetting = function() return getValue(PASV.Junk, {"Trash", "autoMarkTrash"}) end,
    setTrashAutoMarkSetting = function(value) setValue(PASV.Junk, value, {"Trash", "autoMarkTrash"}) end,

    isWeaponsMenuDisabled = isPAJunkWeaponsMenuDisabled,
    isWeaponsAutoMarkOrnateDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}) end,
    getWeaponsAutoMarkOrnateSetting = function() return getValue(PASV.Junk, {"Weapons", "autoMarkOrnate"}) end,
    setWeaponsAutoMarkOrnateSetting = function(value) setValue(PASV.Junk, value, {"Weapons", "autoMarkOrnate"}) end,
    isWeaponsAutoMarkQualityDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}) end,
    getWeaponsAutoMarkQualitySetting = function() return getValue(PASV.Junk, {"Weapons", "autoMarkQuality"}) end,
    setWeaponsAutoMarkQualitySetting = function(value) setValue(PASV.Junk, value, {"Weapons", "autoMarkQuality"}) end,
    isWeaponsAutoMarkQualityThresholdDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}, {"Weapons", "autoMarkQuality"}) end,
    getWeaponsAutoMarkQualityThresholdSetting = function() return getValue(PASV.Junk, {"Weapons", "autoMarkQualityThreshold"}) end,
    setWeaponsAutoMarkQualityThresholdSetting = function(value) setValue(PASV.Junk, value, {"Weapons", "autoMarkQualityThreshold"}) end,
    isWeaponsIncludeSetItemsDisabled = isPAJunkWeaponsAdditionalSettingsDisabled,
    getWeaponsIncludeSetItemsSetting = function() return getValue(PASV.Junk, {"Weapons", "autoMarkIncludingSets"}) end,
    setWeaponsIncludeSetItemsSetting = function(value) setValue(PASV.Junk, value, {"Weapons", "autoMarkIncludingSets"}) end,
    isWeaponsIncludeUnknownTraitsDisabled = isPAJunkWeaponsAdditionalSettingsDisabled,
    getWeaponsIncludeUnknownTraitsSetting = function() return getValue(PASV.Junk, {"Weapons", "autoMarkUnknownTraits"}) end,
    setWeaponsIncludeUnknownTraitsSetting = function(value) setValue(PASV.Junk, value, {"Weapons", "autoMarkUnknownTraits"}) end,

    isArmorMenuDisabled = isPAJunkArmorMenuDisabled,
    isArmorAutoMarkOrnateDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}) end,
    getArmorAutoMarkOrnateSetting = function() return getValue(PASV.Junk, {"Armor", "autoMarkOrnate"}) end,
    setArmorAutoMarkOrnateSetting = function(value) setValue(PASV.Junk, value, {"Armor", "autoMarkOrnate"}) end,
    isArmorAutoMarkQualityDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}) end,
    getArmorAutoMarkQualitySetting = function() return getValue(PASV.Junk, {"Armor", "autoMarkQuality"}) end,
    setArmorAutoMarkQualitySetting = function(value) setValue(PASV.Junk, value, {"Armor", "autoMarkQuality"}) end,
    isArmorAutoMarkQualityThresholdDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}, {"Armor", "autoMarkQuality"}) end,
    getArmorAutoMarkQualityThresholdSetting = function() return getValue(PASV.Junk, {"Armor", "autoMarkQualityThreshold"}) end,
    setArmorAutoMarkQualityThresholdSetting = function(value) setValue(PASV.Junk, value, {"Armor", "autoMarkQualityThreshold"}) end,
    isArmorIncludeSetItemsDisabled = isPAJunkArmorAdditionalSettingsDisabled,
    getArmorIncludeSetItemsSetting = function() return getValue(PASV.Junk, {"Armor", "autoMarkIncludingSets"}) end,
    setArmorIncludeSetItemsSetting = function(value) setValue(PASV.Junk, value, {"Armor", "autoMarkIncludingSets"}) end,
    isArmorIncludeUnknownTraitsDisabled = isPAJunkArmorAdditionalSettingsDisabled,
    getArmorIncludeUnknownTraitsSetting = function() return getValue(PASV.Junk, {"Armor", "autoMarkUnknownTraits"}) end,
    setArmorIncludeUnknownTraitsSetting = function(value) setValue(PASV.Junk, value, {"Armor", "autoMarkUnknownTraits"}) end,

    isJewelryMenuDisabled = isPAJunkJewelryMenuDisabled,
    isJewelryAutoMarkOrnateDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}) end,
    getJewelryAutoMarkOrnateSetting = function() return getValue(PASV.Junk, {"Jewelry", "autoMarkOrnate"}) end,
    setJewelryAutoMarkOrnateSetting = function(value) setValue(PASV.Junk, value, {"Jewelry", "autoMarkOrnate"}) end,
    isJewelryAutoMarkQualityDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}) end,
    getJewelryAutoMarkQualitySetting = function() return getValue(PASV.Junk, {"Jewelry", "autoMarkQuality"}) end,
    setJewelryAutoMarkQualitySetting = function(value) setValue(PASV.Junk, value, {"Jewelry", "autoMarkQuality"}) end,
    isJewelryAutoMarkQualityThresholdDisabled = function() return isDisabled(PASV.Junk, {"autoMarkAsJunkEnabled"}, {"Jewelry", "autoMarkQuality"}) end,
    getJewelryAutoMarkQualityThresholdSetting = function() return getValue(PASV.Junk, {"Jewelry", "autoMarkQualityThreshold"}) end,
    setJewelryAutoMarkQualityThresholdSetting = function(value) setValue(PASV.Junk, value, {"Jewelry", "autoMarkQualityThreshold"}) end,
    isJewelryIncludeSetItemsDisabled = isPAJunkJewelryAdditionalSettingsDisabled,
    getJewelryIncludeSetItemsSetting = function() return getValue(PASV.Junk, {"Jewelry", "autoMarkIncludingSets"}) end,
    setJewelryIncludeSetItemsSetting = function(value) setValue(PASV.Junk, value, {"Jewelry", "autoMarkIncludingSets"}) end,
    isJewelryIncludeUnknownTraitsDisabled = isPAJunkJewelryAdditionalSettingsDisabled,
    getJewelryIncludeUnknownTraitsSetting = function() return getValue(PASV.Junk, {"Jewelry", "autoMarkUnknownTraits"}) end,
    setJewelryIncludeUnknownTraitsSetting = function(value) setValue(PASV.Junk, value, {"Jewelry", "autoMarkUnknownTraits"}) end,

    -- ----------------------------------------------------------------------------------
    -- AUTO SELL JUNK
    -- -----------------------------
    isAutoSellJunkDisabled = function() return false end, -- TODO: currently always enabled
    getAutoSellJunkSetting = function() return getValue(PASV.Junk, {"autoSellJunk"}) end,
    setAutoSellJunkSetting = function(value) setValue(PASV.Junk, value, {"autoSellJunk"}) end,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PAMF.PAJunk = PAJunkMenuFunctions