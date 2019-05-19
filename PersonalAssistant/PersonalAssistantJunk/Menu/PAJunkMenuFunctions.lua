-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAJ = PA.Junk
local PAMF = PA.MenuFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local function getValue(...)
    return PAMF.getValue(PAJ.SavedVars, ...)
end

local function setValue(value, ...)
    PAMF.setValue(PAJ.SavedVars, value, ...)
end

local function setValueAndRefreshEvents(value, ...)
    PAMF.setValueAndRefreshEvents(PAJ.SavedVars, value, ...)
end

local function isDisabled(...)
    return PAMF.isDisabled(PAJ.SavedVars, ...)
end

local function isDisabledAll(...)
    return PAMF.isDisabledAll(PAJ.SavedVars, ...)
end

-- =================================================================================================================

--------------------------------------------------------------------------
-- PAJunk   Miscellaneous
---------------------------------
local function isPAJunkMiscellaneousMenuDisabled()
    if isDisabled({"autoMarkAsJunkEnabled"}) then return true end
    if isDisabled({"Miscellaneous", "autoMarkTreasure"}) then
        if tonumber(getValue({"Miscellaneous", "autoMarkGlyphQualityThreshold"})) == PAC.ITEM_QUALITY.DISABLED then return true end
    end
    -- if no 'true' returned so far, return false now
    return false
end

--------------------------------------------------------------------------
-- PAJunk   Weapons
---------------------------------
local function isPAJunkWeaponsMenuDisabled()
    if isDisabled({"autoMarkAsJunkEnabled"}) then return true end
    if isDisabledAll({"Weapons", "autoMarkOrnate"}, {"Weapons", "autoMarkIncludingSets"}, {"Weapons", "autoMarkIntricateTrait"}, {"Weapons", "autoMarkUnknownTraits"}) then
        if tonumber(getValue({"Weapons", "autoMarkQualityThreshold"})) == PAC.ITEM_QUALITY.DISABLED then return true end
    end
    -- if no 'true' returned so far, return false now
    return false
end

--------------------------------------------------------------------------
-- PAJunk   Armor
---------------------------------
local function isPAJunkArmorMenuDisabled()
    if isDisabled({"autoMarkAsJunkEnabled"}) then return true end
    if isDisabledAll({"Armor", "autoMarkOrnate"}, {"Armor", "autoMarkIncludingSets"}, {"Armor", "autoMarkIntricateTrait"}, {"Armor", "autoMarkUnknownTraits"}) then
        if tonumber(getValue({"Armor", "autoMarkQualityThreshold"})) == PAC.ITEM_QUALITY.DISABLED then return true end
    end
    -- if no 'true' returned so far, return false now
    return false
end

--------------------------------------------------------------------------
-- PAJunk   Jewelry
---------------------------------
local function isPAJunkJewelryMenuDisabled()
    if isDisabled({"autoMarkAsJunkEnabled"}) then return true end
    if isDisabledAll({"Jewelry", "autoMarkOrnate"}, {"Jewelry", "autoMarkIncludingSets"}, {"Jewelry", "autoMarkIntricateTrait"}, {"Jewelry", "autoMarkUnknownTraits"}) then
        if tonumber(getValue({"Jewelry", "autoMarkQualityThreshold"})) == PAC.ITEM_QUALITY.DISABLED then return true end
    end
    -- if no 'true' returned so far, return false now
    return false
end

-- =================================================================================================================

local PAJunkMenuFunctions = {
    getAutoMarkAsJunkEnabledSetting = function() return getValue({"autoMarkAsJunkEnabled"}) end,
    setAutoMarkAsJunkEnabledSetting = function(value) setValueAndRefreshEvents(value, {"autoMarkAsJunkEnabled"}) end,

    -- ----------------------------------------------------------------------------------
    -- AUTO MARK JUNK
    -- -----------------------------
    isAutoMarkAsJunkMenuDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,

    isTrashMenuDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}, {"Trash", "autoMarkTrash"}) end,
    isTrashAutoMarkDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getTrashAutoMarkSetting = function() return getValue({"Trash", "autoMarkTrash"}) end,
    setTrashAutoMarkSetting = function(value) setValue(value, {"Trash", "autoMarkTrash"}) end,
    isExcludeNibblesAndBitsDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}, {"Trash", "autoMarkTrash"}) end,
    getExcludeNibblesAndBitsSetting = function() return getValue({"Trash", "excludeNibblesAndBits"}) end,
    setExcludeNibblesAndBitsSetting = function(value) setValue(value, {"Trash", "excludeNibblesAndBits"}) end,
    isExcludeMorselsAndPecksDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}, {"Trash", "autoMarkTrash"}) end,
    getExcludeMorselsAndPecksSetting = function() return getValue({"Trash", "excludeMorselsAndPecks"}) end,
    setExcludeMorselsAndPecksSetting = function(value) setValue(value, {"Trash", "excludeMorselsAndPecks"}) end,

    isCollectiblesMenuDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}, {"Collectibles", "autoMarkSellToMerchant"}) end,
    isAutoMarkSellToMerchantDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getAutoMarkSellToMerchantSetting = function() return getValue({"Collectibles", "autoMarkSellToMerchant"}) end,
    setAutoMarkSellToMerchantSetting = function(value) setValue(value, {"Collectibles", "autoMarkSellToMerchant"}) end,

    isMiscellaneousMenuDisabled = isPAJunkMiscellaneousMenuDisabled,
    isTreasureAutoMarkDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getTreasureAutoMarkSetting = function() return getValue({"Miscellaneous", "autoMarkTreasure"}) end,
    setTreasureAutoMarkSetting = function(value) setValue(value, {"Miscellaneous", "autoMarkTreasure"}) end,
    isExcludeAMatterOfLeisureDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}, {"Miscellaneous", "autoMarkTreasure"}) end,
    getExcludeAMatterOfLeisureSetting = function() return getValue({"Miscellaneous", "excludeAMatterOfLeisure"}) end,
    setExcludeAMatterOfLeisureSetting = function(value) setValue(value, {"Miscellaneous", "excludeAMatterOfLeisure"}) end,
    isExcludeAMatterOfRespectDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}, {"Miscellaneous", "autoMarkTreasure"}) end,
    getExcludeAMatterOfRespectSetting = function() return getValue({"Miscellaneous", "excludeAMatterOfRespect"}) end,
    setExcludeAMatterOfRespectSetting = function(value) setValue(value, {"Miscellaneous", "excludeAMatterOfRespect"}) end,
    isExcludeAMatterOfTributesDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}, {"Miscellaneous", "autoMarkTreasure"}) end,
    getExcludeAMatterOfTributesSetting = function() return getValue({"Miscellaneous", "excludeAMatterOfTributes"}) end,
    setExcludeAMatterOfTributesSetting = function(value) setValue(value, {"Miscellaneous", "excludeAMatterOfTributes"}) end,
    isGlyphsAutoMarkQualityTresholdDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getGlyphsAutoMarkQualityTresholdSetting = function() return getValue({"Miscellaneous", "autoMarkGlyphQualityThreshold"}) end,
    setGlyphsAutoMarkQualityTresholdSetting = function(value) setValue(value, {"Miscellaneous", "autoMarkGlyphQualityThreshold"}) end,

    isWeaponsMenuDisabled = isPAJunkWeaponsMenuDisabled,
    isWeaponsAutoMarkOrnateDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getWeaponsAutoMarkOrnateSetting = function() return getValue({"Weapons", "autoMarkOrnate"}) end,
    setWeaponsAutoMarkOrnateSetting = function(value) setValue(value, {"Weapons", "autoMarkOrnate"}) end,
    isWeaponsAutoMarkQualityThresholdDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getWeaponsAutoMarkQualityThresholdSetting = function() return getValue({"Weapons", "autoMarkQualityThreshold"}) end,
    setWeaponsAutoMarkQualityThresholdSetting = function(value) setValue(value, {"Weapons", "autoMarkQualityThreshold"}) end,
    isWeaponsIncludeSetItemsDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getWeaponsIncludeSetItemsSetting = function() return getValue({"Weapons", "autoMarkIncludingSets"}) end,
    setWeaponsIncludeSetItemsSetting = function(value) setValue(value, {"Weapons", "autoMarkIncludingSets"}) end,
    isWeaponsIncludeIntricateTraitDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getWeaponsIncludeIntricateTraitSetting = function() return getValue({"Weapons", "autoMarkIntricateTrait"}) end,
    setWeaponsIncludeIntricateTraitSetting = function(value) setValue(value, {"Weapons", "autoMarkIntricateTrait"}) end,
    isWeaponsIncludeUnknownTraitsDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getWeaponsIncludeUnknownTraitsSetting = function() return getValue({"Weapons", "autoMarkUnknownTraits"}) end,
    setWeaponsIncludeUnknownTraitsSetting = function(value) setValue(value, {"Weapons", "autoMarkUnknownTraits"}) end,

    isArmorMenuDisabled = isPAJunkArmorMenuDisabled,
    isArmorAutoMarkOrnateDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getArmorAutoMarkOrnateSetting = function() return getValue({"Armor", "autoMarkOrnate"}) end,
    setArmorAutoMarkOrnateSetting = function(value) setValue(value, {"Armor", "autoMarkOrnate"}) end,
    isArmorAutoMarkQualityThresholdDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getArmorAutoMarkQualityThresholdSetting = function() return getValue({"Armor", "autoMarkQualityThreshold"}) end,
    setArmorAutoMarkQualityThresholdSetting = function(value) setValue(value, {"Armor", "autoMarkQualityThreshold"}) end,
    isArmorIncludeSetItemsDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getArmorIncludeSetItemsSetting = function() return getValue({"Armor", "autoMarkIncludingSets"}) end,
    setArmorIncludeSetItemsSetting = function(value) setValue(value, {"Armor", "autoMarkIncludingSets"}) end,
    isArmorIncludeIntricateTraitDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getArmorIncludeIntricateTraitSetting = function() return getValue({"Armor", "autoMarkIntricateTrait"}) end,
    setArmorIncludeIntricateTraitSetting = function(value) setValue(value, {"Armor", "autoMarkIntricateTrait"}) end,
    isArmorIncludeUnknownTraitsDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getArmorIncludeUnknownTraitsSetting = function() return getValue({"Armor", "autoMarkUnknownTraits"}) end,
    setArmorIncludeUnknownTraitsSetting = function(value) setValue(value, {"Armor", "autoMarkUnknownTraits"}) end,

    isJewelryMenuDisabled = isPAJunkJewelryMenuDisabled,
    isJewelryAutoMarkOrnateDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getJewelryAutoMarkOrnateSetting = function() return getValue({"Jewelry", "autoMarkOrnate"}) end,
    setJewelryAutoMarkOrnateSetting = function(value) setValue(value, {"Jewelry", "autoMarkOrnate"}) end,
    isJewelryAutoMarkQualityThresholdDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getJewelryAutoMarkQualityThresholdSetting = function() return getValue({"Jewelry", "autoMarkQualityThreshold"}) end,
    setJewelryAutoMarkQualityThresholdSetting = function(value) setValue(value, {"Jewelry", "autoMarkQualityThreshold"}) end,
    isJewelryIncludeSetItemsDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getJewelryIncludeSetItemsSetting = function() return getValue({"Jewelry", "autoMarkIncludingSets"}) end,
    setJewelryIncludeSetItemsSetting = function(value) setValue(value, {"Jewelry", "autoMarkIncludingSets"}) end,
    isJewelryIncludeIntricateTraitDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getJewelryIncludeIntricateTraitSetting = function() return getValue({"Jewelry", "autoMarkIntricateTrait"}) end,
    setJewelryIncludeIntricateTraitSetting = function(value) setValue(value, {"Jewelry", "autoMarkIntricateTrait"}) end,
    isJewelryIncludeUnknownTraitsDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getJewelryIncludeUnknownTraitsSetting = function() return getValue({"Jewelry", "autoMarkUnknownTraits"}) end,
    setJewelryIncludeUnknownTraitsSetting = function(value) setValue(value, {"Jewelry", "autoMarkUnknownTraits"}) end,

    -- ----------------------------------------------------------------------------------
    -- AUTO SELL JUNK
    -- -----------------------------
    isAutoSellJunkDisabled = function() return isDisabled() end, -- currently always enabled
    getAutoSellJunkSetting = function() return getValue({"autoSellJunk"}) end,
    setAutoSellJunkSetting = function(value) setValueAndRefreshEvents(value, {"autoSellJunk"}) end,

    -- ----------------------------------------------------------------------------------
    -- SILENT MODE
    -- -----------------------------
    isSilentModeDisabled = function() return isDisabled() end, -- currently always enabled
    getSilentModeSetting = function() return getValue({"silentMode"}) end,
    setSilentModeSetting = function(value) setValue(value, {"silentMode"}) end,

}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PAMF.PAJunk = PAJunkMenuFunctions