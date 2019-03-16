-- Local instances of Global tables --
local PA = PersonalAssistant
local PAJ = PA.Junk
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
    setValue(PAJ.SavedVars, value, {"autoMarkAsJunkEnabled"})
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

--------------------------------------------------------------------------
-- PAJunk   Weapons
---------------------------------
local function isPAJunkWeaponsMenuDisabled()
    if isDisabled(PAJ.SavedVars, {"autoMarkAsJunkEnabled"}) then return true end
    if isDisabled(PAJ.SavedVars, {"Weapons", "autoMarkOrnate"}) and isDisabled(PAJ.SavedVars, {"Weapons", "autoMarkQuality"}) then return true end
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
    if isDisabled(PAJ.SavedVars, {"autoMarkAsJunkEnabled"}) then return true end
    if isDisabled(PAJ.SavedVars, {"Armor", "autoMarkOrnate"}) and isDisabled(PAJ.SavedVars, {"Armor", "autoMarkQuality"}) then return true end
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
    if isDisabled(PAJ.SavedVars, {"autoMarkAsJunkEnabled"}) then return true end
    if isDisabled(PAJ.SavedVars, {"Jewelry", "autoMarkOrnate"}) and isDisabled(PAJ.SavedVars, {"Jewelry", "autoMarkQuality"}) then return true end
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
    getAutoMarkAsJunkEnabledSetting = function() return getValue(PAJ.SavedVars, {"autoMarkAsJunkEnabled"}) end,
    setAutoMarkAsJunkEnabledSetting = setPAJunkAutoMarkAsJunkEnabledSetting,

    isChatOutputDisabled = function() return false end, -- TODO: currently always enabled
    getChatOutputSetting = function() return getValue(PAJ.SavedVars, {"chatOutput"}) end,
    setChatOutputSetting = function(value) setValue(PAJ.SavedVars, value, {"chatOutput"}) end,

    -- ----------------------------------------------------------------------------------
    -- AUTO MARK JUNK
    -- -----------------------------
    isAutoMarkAsJunkMenuDisabled = function() return isDisabled(PAJ.SavedVars, {"autoMarkAsJunkEnabled"}) end,

    isTrashMenuDisabled = function() return isDisabled(PAJ.SavedVars, {"autoMarkAsJunkEnabled"}, {"Trash", "autoMarkTrash"}) end, -- TODO: to extend
    isTrashAutoMarkDisabled = function() return isDisabled(PAJ.SavedVars, {"autoMarkAsJunkEnabled"}) end,
    getTrashAutoMarkSetting = function() return getValue(PAJ.SavedVars, {"Trash", "autoMarkTrash"}) end,
    setTrashAutoMarkSetting = function(value) setValue(PAJ.SavedVars, value, {"Trash", "autoMarkTrash"}) end,

    isCollectiblesMenuDisabled = function() return isDisabled(PAJ.SavedVars, {"autoMarkAsJunkEnabled"}, {"Collectibles", "autoMarkSellToMerchant"}) end,
    isAutoMarkSellToMerchantDisabled = function() return isDisabled(PAJ.SavedVars, {"autoMarkAsJunkEnabled"}) end,
    getAutoMarkSellToMerchantSetting = function() return getValue(PAJ.SavedVars, {"Collectibles", "autoMarkSellToMerchant"}) end,
    setAutoMarkSellToMerchantSetting = function(value) setValue(PAJ.SavedVars, value, {"Collectibles", "autoMarkSellToMerchant"}) end,

    isWeaponsMenuDisabled = isPAJunkWeaponsMenuDisabled,
    isWeaponsAutoMarkOrnateDisabled = function() return isDisabled(PAJ.SavedVars, {"autoMarkAsJunkEnabled"}) end,
    getWeaponsAutoMarkOrnateSetting = function() return getValue(PAJ.SavedVars, {"Weapons", "autoMarkOrnate"}) end,
    setWeaponsAutoMarkOrnateSetting = function(value) setValue(PAJ.SavedVars, value, {"Weapons", "autoMarkOrnate"}) end,
    isWeaponsAutoMarkQualityDisabled = function() return isDisabled(PAJ.SavedVars, {"autoMarkAsJunkEnabled"}) end,
    getWeaponsAutoMarkQualitySetting = function() return getValue(PAJ.SavedVars, {"Weapons", "autoMarkQuality"}) end,
    setWeaponsAutoMarkQualitySetting = function(value) setValue(PAJ.SavedVars, value, {"Weapons", "autoMarkQuality"}) end,
    isWeaponsAutoMarkQualityThresholdDisabled = function() return isDisabled(PAJ.SavedVars, {"autoMarkAsJunkEnabled"}, {"Weapons", "autoMarkQuality"}) end,
    getWeaponsAutoMarkQualityThresholdSetting = function() return getValue(PAJ.SavedVars, {"Weapons", "autoMarkQualityThreshold"}) end,
    setWeaponsAutoMarkQualityThresholdSetting = function(value) setValue(PAJ.SavedVars, value, {"Weapons", "autoMarkQualityThreshold"}) end,
    isWeaponsIncludeSetItemsDisabled = isPAJunkWeaponsAdditionalSettingsDisabled,
    getWeaponsIncludeSetItemsSetting = function() return getValue(PAJ.SavedVars, {"Weapons", "autoMarkIncludingSets"}) end,
    setWeaponsIncludeSetItemsSetting = function(value) setValue(PAJ.SavedVars, value, {"Weapons", "autoMarkIncludingSets"}) end,
    isWeaponsIncludeUnknownTraitsDisabled = isPAJunkWeaponsAdditionalSettingsDisabled,
    getWeaponsIncludeUnknownTraitsSetting = function() return getValue(PAJ.SavedVars, {"Weapons", "autoMarkUnknownTraits"}) end,
    setWeaponsIncludeUnknownTraitsSetting = function(value) setValue(PAJ.SavedVars, value, {"Weapons", "autoMarkUnknownTraits"}) end,

    isArmorMenuDisabled = isPAJunkArmorMenuDisabled,
    isArmorAutoMarkOrnateDisabled = function() return isDisabled(PAJ.SavedVars, {"autoMarkAsJunkEnabled"}) end,
    getArmorAutoMarkOrnateSetting = function() return getValue(PAJ.SavedVars, {"Armor", "autoMarkOrnate"}) end,
    setArmorAutoMarkOrnateSetting = function(value) setValue(PAJ.SavedVars, value, {"Armor", "autoMarkOrnate"}) end,
    isArmorAutoMarkQualityDisabled = function() return isDisabled(PAJ.SavedVars, {"autoMarkAsJunkEnabled"}) end,
    getArmorAutoMarkQualitySetting = function() return getValue(PAJ.SavedVars, {"Armor", "autoMarkQuality"}) end,
    setArmorAutoMarkQualitySetting = function(value) setValue(PAJ.SavedVars, value, {"Armor", "autoMarkQuality"}) end,
    isArmorAutoMarkQualityThresholdDisabled = function() return isDisabled(PAJ.SavedVars, {"autoMarkAsJunkEnabled"}, {"Armor", "autoMarkQuality"}) end,
    getArmorAutoMarkQualityThresholdSetting = function() return getValue(PAJ.SavedVars, {"Armor", "autoMarkQualityThreshold"}) end,
    setArmorAutoMarkQualityThresholdSetting = function(value) setValue(PAJ.SavedVars, value, {"Armor", "autoMarkQualityThreshold"}) end,
    isArmorIncludeSetItemsDisabled = isPAJunkArmorAdditionalSettingsDisabled,
    getArmorIncludeSetItemsSetting = function() return getValue(PAJ.SavedVars, {"Armor", "autoMarkIncludingSets"}) end,
    setArmorIncludeSetItemsSetting = function(value) setValue(PAJ.SavedVars, value, {"Armor", "autoMarkIncludingSets"}) end,
    isArmorIncludeUnknownTraitsDisabled = isPAJunkArmorAdditionalSettingsDisabled,
    getArmorIncludeUnknownTraitsSetting = function() return getValue(PAJ.SavedVars, {"Armor", "autoMarkUnknownTraits"}) end,
    setArmorIncludeUnknownTraitsSetting = function(value) setValue(PAJ.SavedVars, value, {"Armor", "autoMarkUnknownTraits"}) end,

    isJewelryMenuDisabled = isPAJunkJewelryMenuDisabled,
    isJewelryAutoMarkOrnateDisabled = function() return isDisabled(PAJ.SavedVars, {"autoMarkAsJunkEnabled"}) end,
    getJewelryAutoMarkOrnateSetting = function() return getValue(PAJ.SavedVars, {"Jewelry", "autoMarkOrnate"}) end,
    setJewelryAutoMarkOrnateSetting = function(value) setValue(PAJ.SavedVars, value, {"Jewelry", "autoMarkOrnate"}) end,
    isJewelryAutoMarkQualityDisabled = function() return isDisabled(PAJ.SavedVars, {"autoMarkAsJunkEnabled"}) end,
    getJewelryAutoMarkQualitySetting = function() return getValue(PAJ.SavedVars, {"Jewelry", "autoMarkQuality"}) end,
    setJewelryAutoMarkQualitySetting = function(value) setValue(PAJ.SavedVars, value, {"Jewelry", "autoMarkQuality"}) end,
    isJewelryAutoMarkQualityThresholdDisabled = function() return isDisabled(PAJ.SavedVars, {"autoMarkAsJunkEnabled"}, {"Jewelry", "autoMarkQuality"}) end,
    getJewelryAutoMarkQualityThresholdSetting = function() return getValue(PAJ.SavedVars, {"Jewelry", "autoMarkQualityThreshold"}) end,
    setJewelryAutoMarkQualityThresholdSetting = function(value) setValue(PAJ.SavedVars, value, {"Jewelry", "autoMarkQualityThreshold"}) end,
    isJewelryIncludeSetItemsDisabled = isPAJunkJewelryAdditionalSettingsDisabled,
    getJewelryIncludeSetItemsSetting = function() return getValue(PAJ.SavedVars, {"Jewelry", "autoMarkIncludingSets"}) end,
    setJewelryIncludeSetItemsSetting = function(value) setValue(PAJ.SavedVars, value, {"Jewelry", "autoMarkIncludingSets"}) end,
    isJewelryIncludeUnknownTraitsDisabled = isPAJunkJewelryAdditionalSettingsDisabled,
    getJewelryIncludeUnknownTraitsSetting = function() return getValue(PAJ.SavedVars, {"Jewelry", "autoMarkUnknownTraits"}) end,
    setJewelryIncludeUnknownTraitsSetting = function(value) setValue(PAJ.SavedVars, value, {"Jewelry", "autoMarkUnknownTraits"}) end,

    -- ----------------------------------------------------------------------------------
    -- AUTO SELL JUNK
    -- -----------------------------
    isAutoSellJunkDisabled = function() return false end, -- TODO: currently always enabled
    getAutoSellJunkSetting = function() return getValue(PAJ.SavedVars, {"autoSellJunk"}) end,
    setAutoSellJunkSetting = function(value) setValue(PAJ.SavedVars, value, {"autoSellJunk"}) end,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PAMF.PAJunk = PAJunkMenuFunctions