-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAJ = PA.Junk
local PAMF = PA.MenuFunctions
local PAEM = PA.EventManager
local PAJProfileManager = PA.ProfileManager.PAJunk

-- =====================================================================================================================

local isNoProfileSelected = PAJProfileManager.isNoProfileSelected

local function getValue(...)
    if isNoProfileSelected() then return end
    return PAMF.getValue(PAJ.SavedVars, ...)
end

local function setValue(value, ...)
    if isNoProfileSelected() then return end
    PAMF.setValue(PAJ.SavedVars, value, ...)
end

local function setValueAndRefreshEvents(value, ...)
    setValue(value, ...)
    PAEM.RefreshEventRegistration.PAJunk()
end

local function isDisabled(...)
    if isNoProfileSelected() then return true end
    return PAMF.isDisabled(PAJ.SavedVars, ...)
end

local function isDisabledAll(...)
    if isNoProfileSelected() then return true end
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
    if isDisabled({"Weapons", "autoMarkOrnate"}) and getValue({"Weapons", "autoMarkQualityThreshold"}) == PAC.ITEM_QUALITY.DISABLED then
        return true
    end
    -- if no 'true' returned so far, return false now
    return false
end

--------------------------------------------------------------------------
-- PAJunk   Weapons         includeXYZ
---------------------------------
local function isPAJunkWeaponsIncludesDisabled()
    if isDisabled({"autoMarkAsJunkEnabled"}) then return true end
    if tonumber(getValue({"Weapons", "autoMarkQualityThreshold"})) == PAC.ITEM_QUALITY.DISABLED then return true end
    -- if no 'true' returned so far, return false now
    return false
end

--------------------------------------------------------------------------
-- PAJunk   Armor
---------------------------------
local function isPAJunkArmorMenuDisabled()
    if isDisabled({"autoMarkAsJunkEnabled"}) then return true end
    if isDisabled({"Armor", "autoMarkOrnate"}) and getValue({"Armor", "autoMarkQualityThreshold"}) == PAC.ITEM_QUALITY.DISABLED then
        return true
    end
    -- if no 'true' returned so far, return false now
    return false
end

--------------------------------------------------------------------------
-- PAJunk   Armor           includeXYZ
---------------------------------
local function isPAJunkArmorIncludesDisabled()
    if isDisabled({"autoMarkAsJunkEnabled"}) then return true end
    if tonumber(getValue({"Armor", "autoMarkQualityThreshold"})) == PAC.ITEM_QUALITY.DISABLED then return true end
    -- if no 'true' returned so far, return false now
    return false
end

--------------------------------------------------------------------------
-- PAJunk   Jewelry
---------------------------------
local function isPAJunkJewelryMenuDisabled()
    if isDisabled({"autoMarkAsJunkEnabled"}) then return true end
    if isDisabled({"Jewelry", "autoMarkOrnate"}) and getValue({"Jewelry", "autoMarkQualityThreshold"}) == PAC.ITEM_QUALITY.DISABLED then
        return true
    end
    -- if no 'true' returned so far, return false now
    return false
end

--------------------------------------------------------------------------
-- PAJunk   Jewelry         includeXYZ
---------------------------------
local function isPAJunkJewelryIncludesDisabled()
    if isDisabled({"autoMarkAsJunkEnabled"}) then return true end
    if tonumber(getValue({"Jewelry", "autoMarkQualityThreshold"})) == PAC.ITEM_QUALITY.DISABLED then return true end
    -- if no 'true' returned so far, return false now
    return false
end

--------------------------------------------------------------------------
-- PAJunk   QuestProtection         ClockworkCity
---------------------------------
local function isPAJunkClockworkCityMenuDisabled()
    return (isDisabledAll({"QuestProtection", "ClockworkCity", "excludeNibblesAndBits"}, {"QuestProtection", "ClockworkCity", "excludeMorselsAndPecks"})) and
            (isDisabledAll({"QuestProtection", "ClockworkCity", "excludeAMatterOfLeisure"}, {"QuestProtection", "ClockworkCity", "excludeAMatterOfRespect"}, {"QuestProtection", "ClockworkCity", "excludeAMatterOfTributes"}))
end

--------------------------------------------------------------------------
-- PAJunk   QuestProtection.ClockworkCity         excludeNibblesAndBits/excludeMorselsAndPecks
---------------------------------
local function isPAJunkExcludeTrashDescriptionDisabled()
    return isDisabledAll({"QuestProtection", "ClockworkCity", "excludeNibblesAndBits"}, {"QuestProtection", "ClockworkCity", "excludeMorselsAndPecks"})
end

--------------------------------------------------------------------------
-- PAJunk   QuestProtection.ClockworkCity         excludeAMatterOfLeisure/excludeAMatterOfRespect/excludeAMatterOfTributes
---------------------------------
local function isPAJunkExcludeTreasuresDescriptionDisabled()
    return isDisabledAll({"QuestProtection", "ClockworkCity", "excludeAMatterOfLeisure"}, {"QuestProtection", "ClockworkCity", "excludeAMatterOfRespect"}, {"QuestProtection", "ClockworkCity", "excludeAMatterOfTributes"})
end

--------------------------------------------------------------------------
-- PAJunk   QuestProtection         ThievesGuild
---------------------------------
local function isPAJunkThievesGuildMenuDisabled()
    if isDisabled({"autoMarkAsJunkEnabled"}) then return true end
    if ((isDisabled({"Miscellaneous", "autoMarkTreasure"}) and getValue({"Stolen", "treasureAction"})) or isDisabledAll({"QuestProtection", "ThievesGuild", "excludeTheCovetousCountess"})) then
        return true
    end
    -- if no 'true' returned so far, return false now
    return false
end

--------------------------------------------------------------------------
-- PAJunk   QuestProtection         NewLifeFestival
---------------------------------
local function isPAJunkNewLifeFestivalMenuDisabled()
    if isDisabled({"autoMarkAsJunkEnabled"}) then return true end
    if (isDisabled({"Collectibles", "autoMarkSellToMerchant"}) or isDisabledAll({"QuestProtection", "NewLifeFestival", "excludeRareFish"})) then
        return true
    end
    -- if no 'true' returned so far, return false now
    return false
end

--------------------------------------------------------------------------
-- PAJunk   QuestProtection.NewLifeFestival         excludeRareFish
---------------------------------
local function isPAJunkNewLifeFestivalExcludeDisabled()
    if isDisabled({"autoMarkAsJunkEnabled"}) then return true end
    if isDisabled({"Collectibles", "autoMarkSellToMerchant"}) then
        return true
    end
    -- if no 'true' returned so far, return false now
    return false
end

--------------------------------------------------------------------------
-- PAJunk   Stolen
---------------------------------
local function isPAJunkStolenMenuDisabled()
    if isDisabled({"autoMarkAsJunkEnabled"}) then return true end
    return isDisabledAll({"Stolen", "trash"}, {"Stolen", "weapons"}, {"Stolen", "apparels"}, {"Stolen", "jewelries"},
                         {"Stolen", "styleMaterials"}, {"Stolen", "traitItems"}, {"Stolen", "lures"}, {"Stolen", "ingredients"},
                         {"Stolen", "food"}, {"Stolen", "drinks"}, {"Stolen", "solvents"}, {"Stolen", "treasures"})
end

--------------------------------------------------------------------------
-- PAJunk   AutoDestroy     destroyJunk
---------------------------------
local function setPAJunkAutoDestroyJunkSetting(value)
    if isNoProfileSelected() then return end
    setValue(value, {"AutoDestroy", "destroyJunk"})
    if tostring(value) == "true" then
        PAJ.println(SI_PA_CHAT_JUNK_DESTROY_ON)
    else
        PAJ.println(SI_PA_CHAT_JUNK_DESTROY_OFF)
    end
end

--------------------------------------------------------------------------
-- PAJunk   AutoDestroy     destroyStolenJunk
---------------------------------
local function setPAJunkAutoDestroyStolenJunkSetting(value)
    if isNoProfileSelected() then return end
    setValue(value, {"AutoDestroy", "destroyStolenJunk"})
    if tostring(value) == "true" then
        PAJ.println(SI_PA_CHAT_JUNK_DESTROY_STOLEN_ON)
    else
        PAJ.println(SI_PA_CHAT_JUNK_DESTROY_STOLEN_OFF)
    end
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

    isCollectiblesMenuDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}, {"Collectibles", "autoMarkSellToMerchant"}) end,
    isAutoMarkSellToMerchantDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getAutoMarkSellToMerchantSetting = function() return getValue({"Collectibles", "autoMarkSellToMerchant"}) end,
    setAutoMarkSellToMerchantSetting = function(value) setValue(value, {"Collectibles", "autoMarkSellToMerchant"}) end,

    isMiscellaneousMenuDisabled = isPAJunkMiscellaneousMenuDisabled,
    isAutoMarkTreasuresDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getAutoMarkTreasuresSetting = function() return getValue({"Miscellaneous", "autoMarkTreasure"}) end,
    setAutoMarkTreasuresSetting = function(value) setValue(value, {"Miscellaneous", "autoMarkTreasure"}) end,
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
    isWeaponsIncludeSetItemsDisabled = isPAJunkWeaponsIncludesDisabled,
    getWeaponsIncludeSetItemsSetting = function() return getValue({"Weapons", "autoMarkIncludingSets"}) end,
    setWeaponsIncludeSetItemsSetting = function(value) setValue(value, {"Weapons", "autoMarkIncludingSets"}) end,
    isWeaponsIncludeIntricateTraitDisabled = isPAJunkWeaponsIncludesDisabled,
    getWeaponsIncludeIntricateTraitSetting = function() return getValue({"Weapons", "autoMarkIntricateTrait"}) end,
    setWeaponsIncludeIntricateTraitSetting = function(value) setValue(value, {"Weapons", "autoMarkIntricateTrait"}) end,
    isWeaponsIncludeKnownTraitsDisabled = isPAJunkWeaponsIncludesDisabled,
    getWeaponsIncludeKnownTraitsSetting = function() return getValue({"Weapons", "autoMarkKnownTraits"}) end,
    setWeaponsIncludeKnownTraitsSetting = function(value) setValue(value, {"Weapons", "autoMarkKnownTraits"}) end,
    isWeaponsIncludeUnknownTraitsDisabled = isPAJunkWeaponsIncludesDisabled,
    getWeaponsIncludeUnknownTraitsSetting = function() return getValue({"Weapons", "autoMarkUnknownTraits"}) end,
    setWeaponsIncludeUnknownTraitsSetting = function(value) setValue(value, {"Weapons", "autoMarkUnknownTraits"}) end,

    isArmorMenuDisabled = isPAJunkArmorMenuDisabled,
    isArmorAutoMarkOrnateDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getArmorAutoMarkOrnateSetting = function() return getValue({"Armor", "autoMarkOrnate"}) end,
    setArmorAutoMarkOrnateSetting = function(value) setValue(value, {"Armor", "autoMarkOrnate"}) end,
    isArmorAutoMarkQualityThresholdDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getArmorAutoMarkQualityThresholdSetting = function() return getValue({"Armor", "autoMarkQualityThreshold"}) end,
    setArmorAutoMarkQualityThresholdSetting = function(value) setValue(value, {"Armor", "autoMarkQualityThreshold"}) end,
    isArmorIncludeSetItemsDisabled = isPAJunkArmorIncludesDisabled,
    getArmorIncludeSetItemsSetting = function() return getValue({"Armor", "autoMarkIncludingSets"}) end,
    setArmorIncludeSetItemsSetting = function(value) setValue(value, {"Armor", "autoMarkIncludingSets"}) end,
    isArmorIncludeIntricateTraitDisabled = isPAJunkArmorIncludesDisabled,
    getArmorIncludeIntricateTraitSetting = function() return getValue({"Armor", "autoMarkIntricateTrait"}) end,
    setArmorIncludeIntricateTraitSetting = function(value) setValue(value, {"Armor", "autoMarkIntricateTrait"}) end,
    isArmorIncludeKnownTraitsDisabled = isPAJunkArmorIncludesDisabled,
    getArmorIncludeKnownTraitsSetting = function() return getValue({"Armor", "autoMarkKnownTraits"}) end,
    setArmorIncludeKnownTraitsSetting = function(value) setValue(value, {"Armor", "autoMarkKnownTraits"}) end,
    isArmorIncludeUnknownTraitsDisabled = isPAJunkArmorIncludesDisabled,
    getArmorIncludeUnknownTraitsSetting = function() return getValue({"Armor", "autoMarkUnknownTraits"}) end,
    setArmorIncludeUnknownTraitsSetting = function(value) setValue(value, {"Armor", "autoMarkUnknownTraits"}) end,

    isJewelryMenuDisabled = isPAJunkJewelryMenuDisabled,
    isJewelryAutoMarkOrnateDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getJewelryAutoMarkOrnateSetting = function() return getValue({"Jewelry", "autoMarkOrnate"}) end,
    setJewelryAutoMarkOrnateSetting = function(value) setValue(value, {"Jewelry", "autoMarkOrnate"}) end,
    isJewelryAutoMarkQualityThresholdDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getJewelryAutoMarkQualityThresholdSetting = function() return getValue({"Jewelry", "autoMarkQualityThreshold"}) end,
    setJewelryAutoMarkQualityThresholdSetting = function(value) setValue(value, {"Jewelry", "autoMarkQualityThreshold"}) end,
    isJewelryIncludeSetItemsDisabled = isPAJunkJewelryIncludesDisabled,
    getJewelryIncludeSetItemsSetting = function() return getValue({"Jewelry", "autoMarkIncludingSets"}) end,
    setJewelryIncludeSetItemsSetting = function(value) setValue(value, {"Jewelry", "autoMarkIncludingSets"}) end,
    isJewelryIncludeIntricateTraitDisabled = isPAJunkJewelryIncludesDisabled,
    getJewelryIncludeIntricateTraitSetting = function() return getValue({"Jewelry", "autoMarkIntricateTrait"}) end,
    setJewelryIncludeIntricateTraitSetting = function(value) setValue(value, {"Jewelry", "autoMarkIntricateTrait"}) end,
    isJewelryIncludeKnownTraitsDisabled = isPAJunkJewelryIncludesDisabled,
    getJewelryIncludeKnownTraitsSetting = function() return getValue({"Jewelry", "autoMarkKnownTraits"}) end,
    setJewelryIncludeKnownTraitsSetting = function(value) setValue(value, {"Jewelry", "autoMarkKnownTraits"}) end,
    isJewelryIncludeUnknownTraitsDisabled = isPAJunkJewelryIncludesDisabled,
    getJewelryIncludeUnknownTraitsSetting = function() return getValue({"Jewelry", "autoMarkUnknownTraits"}) end,
    setJewelryIncludeUnknownTraitsSetting = function(value) setValue(value, {"Jewelry", "autoMarkUnknownTraits"}) end,

    isClockworkCityMenuDisabled = isPAJunkClockworkCityMenuDisabled,
    isExcludeTrashDescriptionDisabled = isPAJunkExcludeTrashDescriptionDisabled,
    isExcludeNibblesAndBitsDisabled = function() return isDisabled() end, -- currently always enabled (due to potential custom rules)
    getExcludeNibblesAndBitsSetting = function() return getValue({"QuestProtection", "ClockworkCity", "excludeNibblesAndBits"}) end,
    setExcludeNibblesAndBitsSetting = function(value) setValue(value, {"QuestProtection", "ClockworkCity", "excludeNibblesAndBits"}) end,
    isExcludeMorselsAndPecksDisabled = function() return isDisabled() end, -- currently always enabled (due to potential custom rules)
    getExcludeMorselsAndPecksSetting = function() return getValue({"QuestProtection", "ClockworkCity", "excludeMorselsAndPecks"}) end,
    setExcludeMorselsAndPecksSetting = function(value) setValue(value, {"QuestProtection", "ClockworkCity", "excludeMorselsAndPecks"}) end,

    isExcludeTreasuresDescriptionDisabled = isPAJunkExcludeTreasuresDescriptionDisabled, -- TODO: check stolen treasures
    isExcludeAMatterOfLeisureDisabled = function() return isDisabled() end, -- currently always enabled (due to potential custom rules)
    getExcludeAMatterOfLeisureSetting = function() return getValue({"QuestProtection", "ClockworkCity", "excludeAMatterOfLeisure"}) end,
    setExcludeAMatterOfLeisureSetting = function(value) setValue(value, {"QuestProtection", "ClockworkCity", "excludeAMatterOfLeisure"}) end,
    isExcludeAMatterOfRespectDisabled = function() return isDisabled() end, -- currently always enabled (due to potential custom rules)
    getExcludeAMatterOfRespectSetting = function() return getValue({"QuestProtection", "ClockworkCity", "excludeAMatterOfRespect"}) end,
    setExcludeAMatterOfRespectSetting = function(value) setValue(value, {"QuestProtection", "ClockworkCity", "excludeAMatterOfRespect"}) end,
    isExcludeAMatterOfTributesDisabled = function() return isDisabled() end, -- currently always enabled (due to potential custom rules)
    getExcludeAMatterOfTributesSetting = function() return getValue({"QuestProtection", "ClockworkCity", "excludeAMatterOfTributes"}) end,
    setExcludeAMatterOfTributesSetting = function(value) setValue(value, {"QuestProtection", "ClockworkCity", "excludeAMatterOfTributes"}) end,

    isThievesGuildMenuDisabled = isPAJunkThievesGuildMenuDisabled,
    isExcludeTheCovetousCountessDisabled = function() return isDisabled() end, -- currently always enabled (due to potential custom rules)
    getExcludeTheCovetousCountessSetting = function() return getValue({"QuestProtection", "ThievesGuild", "excludeTheCovetousCountess"}) end,
    setExcludeTheCovetousCountessSetting = function(value) setValue(value, {"QuestProtection", "ThievesGuild", "excludeTheCovetousCountess"}) end,

    isNewLifeFestivalMenuDisabled = isPAJunkNewLifeFestivalMenuDisabled,
    isExcludeRareFishDisabled = isPAJunkNewLifeFestivalExcludeDisabled,
    getExcludeRareFishSetting = function() return getValue({"QuestProtection", "NewLifeFestival", "excludeRareFish"}) end,
    setExcludeRareFishSetting = function(value) setValue(value, {"QuestProtection", "NewLifeFestival", "excludeRareFish"}) end,

    isStolenMenuDisabled = isPAJunkStolenMenuDisabled,
    isStolenTrashDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getStolenTrashSetting = function() return getValue({"Stolen", "trash"}) end,
    setStolenTrashSetting = function(value) setValue(value, {"Stolen", "trash"}) end,
    isStolenWeaponsDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getStolenWeaponsSetting = function() return getValue({"Stolen", "weapons"}) end,
    setStolenWeaponsSetting = function(value) setValue(value, {"Stolen", "weapons"}) end,
    isStolenApparelsDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getStolenApparelsSetting = function() return getValue({"Stolen", "apparels"}) end,
    setStolenApparelsSetting = function(value) setValue(value, {"Stolen", "apparels"}) end,
    isStolenJewelriesDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getStolenJewelriesSetting = function() return getValue({"Stolen", "jewelries"}) end,
    setStolenJewelriesSetting = function(value) setValue(value, {"Stolen", "jewelries"}) end,
    isStolenStyleMaterialsDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getStolenStyleMaterialsSetting = function() return getValue({"Stolen", "styleMaterials"}) end,
    setStolenStyleMaterialsSetting = function(value) setValue(value, {"Stolen", "styleMaterials"}) end,
    isStolenTraitItemsDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getStolenTraitItemsSetting = function() return getValue({"Stolen", "traitItems"}) end,
    setStolenTraitItemsSetting = function(value) setValue(value, {"Stolen", "traitItems"}) end,
    isStolenLuresDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getStolenLuresSetting = function() return getValue({"Stolen", "lures"}) end,
    setStolenLuresSetting = function(value) setValue(value, {"Stolen", "lures"}) end,
    isStolenIngredientsDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getStolenIngredientsSetting = function() return getValue({"Stolen", "ingredients"}) end,
    setStolenIngredientsSetting = function(value) setValue(value, {"Stolen", "ingredients"}) end,
    isStolenFoodDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getStolenFoodSetting = function() return getValue({"Stolen", "food"}) end,
    setStolenFoodSetting = function(value) setValue(value, {"Stolen", "food"}) end,
    isStolenDrinksDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getStolenDrinksSetting = function() return getValue({"Stolen", "drinks"}) end,
    setStolenDrinksSetting = function(value) setValue(value, {"Stolen", "drinks"}) end,
    isStolenSolventsDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getStolenSolventsSetting = function() return getValue({"Stolen", "solvents"}) end,
    setStolenSolventsSetting = function(value) setValue(value, {"Stolen", "solvents"}) end,
    isStolenTreasuresDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getStolenTreasuresSetting = function() return getValue({"Stolen", "treasures"}) end,
    setStolenTreasuresSetting = function(value) setValue(value, {"Stolen", "treasures"}) end,

    -- ----------------------------------------------------------------------------------
    -- AUTO-DESTROY JUNK
    -- -----------------------------
    isDestroyJunkMenuDisabled = function() return isDisabled({"AutoDestroy", "destroyJunk"}) end,
    isAutoDestroyJunkDisabled = function() return isDisabled() end, -- currently always enabled
    getAutoDestroyJunkSetting = function() return getValue({"AutoDestroy", "destroyJunk"}) end,
    setAutoDestroyJunkSetting = setPAJunkAutoDestroyJunkSetting,
    isDestroyMaxValueThresholdDisabled = function() return isDisabled({"AutoDestroy", "destroyJunk"}) end,
    getDestroyMaxValueThresholdSetting = function() return getValue({"AutoDestroy", "destroyMaxValueThreshold"}) end,
    setDestroyMaxValueThresholdSetting = function(value) setValue(value, {"AutoDestroy", "destroyMaxValueThreshold"}) end,
    isDestroyMaxQualityThresholdDisabled = function() return isDisabled({"AutoDestroy", "destroyJunk"}) end,
    getDestroyMaxQualityThresholdSetting = function() return getValue({"AutoDestroy", "destroyMaxQualityThreshold"}) end,
    setDestroyMaxQualityThresholdSetting = function(value) setValue(value, {"AutoDestroy", "destroyMaxQualityThreshold"}) end,

    isDestroyStolenJunkMenuDisabled = function() return isDisabled({"AutoDestroy", "destroyStolenJunk"}) end,
    isAutoDestroyStolenJunkDisabled = function() return isDisabled() end, -- currently always enabled
    getAutoDestroyStolenJunkSetting = function() return getValue({"AutoDestroy", "destroyStolenJunk"}) end,
    setAutoDestroyStolenJunkSetting = setPAJunkAutoDestroyStolenJunkSetting,
    isDestroyMaxStolenValueThresholdDisabled = function() return isDisabled({"AutoDestroy", "destroyStolenJunk"}) end,
    getDestroyMaxStolenValueThresholdSetting = function() return getValue({"AutoDestroy", "destroyMaxStolenValueThreshold"}) end,
    setDestroyMaxStolenValueThresholdSetting = function(value) setValue(value, {"AutoDestroy", "destroyMaxStolenValueThreshold"}) end,
    isDestroyMaxStolenQualityThresholdDisabled = function() return isDisabled({"AutoDestroy", "destroyStolenJunk"}) end,
    getDestroyMaxStolenQualityThresholdSetting = function() return getValue({"AutoDestroy", "destroyMaxStolenQualityThreshold"}) end,
    setDestroyMaxStolenQualityThresholdSetting = function(value) setValue(value, {"AutoDestroy", "destroyMaxStolenQualityThreshold"}) end,

    isDestroyExclusionDisclaimerDisabled = function() return isDisabledAll({"AutoDestroy", "destroyJunk"}, {"AutoDestroy", "destroyStolenJunk"}) end,

    -- ----------------------------------------------------------------------------------
    -- KEYBINDINGS
    -- -----------------------------
    isKeybindingsMenuDisabled = function() return isDisabledAll({"KeyBindings", "enableMarkUnmarkAsJunkKeybind"}, {"KeyBindings", "enableDestroyItemKeybind"}) end,

    isKeybindingMarkUnmarkAsJunkDisabled = function() return isDisabled() end, -- currently always enabled
    getKeybindingMarkUnmarkAsJunkSetting = function() return getValue({"KeyBindings", "enableMarkUnmarkAsJunkKeybind"}) end,
    setKeybindingMarkUnmarkAsJunkSetting = function(value) setValueAndRefreshEvents(value, {"KeyBindings", "enableMarkUnmarkAsJunkKeybind"}) end,
    isKeybindingMarkUnmarkAsJunkShownDisabled = function() return isDisabled({"KeyBindings", "enableMarkUnmarkAsJunkKeybind"}) end,
    getKeybindingMarkUnmarkAsJunkShownSetting = function() return getValue({"KeyBindings", "showMarkUnmarkAsJunkKeybind"}) end,
    setKeybindingMarkUnmarkAsJunkShownSetting = function(value) setValue(value, {"KeyBindings", "showMarkUnmarkAsJunkKeybind"}) end,

    isKeybindingMarkUnmarkAsPermJunkDisabled = function() return isDisabled() end, -- currently always enabled
    getKeybindingMarkUnmarkAsPermJunkSetting = function() return getValue({"KeyBindings", "enableMarkUnmarkAsPermJunkKeybind"}) end,
    setKeybindingMarkUnmarkAsPermJunkSetting = function(value) setValueAndRefreshEvents(value, {"KeyBindings", "enableMarkUnmarkAsPermJunkKeybind"}) end,
    isKeybindingMarkUnmarkAsPermJunkShownDisabled = function() return isDisabled({"KeyBindings", "enableMarkUnmarkAsPermJunkKeybind"}) end,
    getKeybindingMarkUnmarkAsPermJunkShownSetting = function() return getValue({"KeyBindings", "showMarkUnmarkAsPermJunkKeybind"}) end,
    setKeybindingMarkUnmarkAsPermJunkShownSetting = function(value) setValue(value, {"KeyBindings", "showMarkUnmarkAsPermJunkKeybind"}) end,

    isKeybindingDestroyItemDisabled = function() return isDisabled() end, -- currently always enabled
    getKeybindingDestroyItemSetting = function() return getValue({"KeyBindings", "enableDestroyItemKeybind"}) end,
    setKeybindingDestroyItemSetting = function(value) setValueAndRefreshEvents(value, {"KeyBindings", "enableDestroyItemKeybind"}) end,
    isKeybindingDestroyItemShownDisabled = function() return isDisabled({"KeyBindings", "enableDestroyItemKeybind"}) end,
    getKeybindingDestroyItemShownSetting = function() return getValue({"KeyBindings", "showDestroyItemKeybind"}) end,
    setKeybindingDestroyItemShownSetting = function(value) setValue(value, {"KeyBindings", "showDestroyItemKeybind"}) end,
    isDestroyItemQualityThresholdDisabled = function() return isDisabled({"KeyBindings", "enableDestroyItemKeybind"}) end,
    getDestroyItemQualityThresholdSetting = function() return getValue({"KeyBindings", "destroyItemQualityThreshold"}) end,
    setDestroyItemQualityThresholdSetting = function(value) setValue(value, {"KeyBindings", "destroyItemQualityThreshold"}) end,
    isDestroyExcludeUnknownItemsDisabled = function() return isDisabled({"KeyBindings", "enableDestroyItemKeybind"}) end,
    getDestroyExcludeUnknownItemsSetting = function() return getValue({"KeyBindings", "destroyExcludeUnknownItems"}) end,
    setDestroyExcludeUnknownItemsSetting = function(value) setValue(value, {"KeyBindings", "destroyExcludeUnknownItems"}) end,

    -- ----------------------------------------------------------------------------------
    -- MAILBOX ITEMS
    -- -----------------------------
    isMailboxItemsIgnoredDisabled = function() return isDisabled() end, -- currently always enabled
    getMailboxItemsIgnoredSetting = function() return getValue({"ignoreMailboxItems"}) end,
    setMailboxItemsIgnoredSetting = function(value) setValue(value, {"ignoreMailboxItems"}) end,

    -- ----------------------------------------------------------------------------------
    -- CRAFTED ITEMS
    -- -----------------------------
    isCraftedItemsIgnoredDisabled = function() return isDisabled() end, -- currently always enabled
    getCraftedItemsIgnoredSetting = function() return getValue({"ignoreCraftedItems"}) end,
    setCraftedItemsIgnoredSetting = function(value) setValue(value, {"ignoreCraftedItems"}) end,

    -- ----------------------------------------------------------------------------------
    -- AUTO SELL JUNK
    -- -----------------------------
    isAutoSellJunkDisabled = function() return isDisabled() end, -- currently always enabled
    getAutoSellJunkSetting = function() return getValue({"autoSellJunk"}) end,
    setAutoSellJunkSetting = function(value) setValueAndRefreshEvents(value, {"autoSellJunk"}) end,
    isAutoSellJunkPirharriDisabled = function() return isDisabled({"autoSellJunk"}) end,
    getAutoSellJunkPirharriSetting = function() return getValue({"autoSellJunkPirharri"}) end,
    setAutoSellJunkPirharriSetting = function(value) setValueAndRefreshEvents(value, {"autoSellJunkPirharri"}) end,

    -- ----------------------------------------------------------------------------------
    -- SILENT MODE
    -- -----------------------------
    isSilentModeDisabled = function() return isDisabled() end, -- currently always enabled
    getSilentModeSetting = function() return getValue({"silentMode"}) end,
    setSilentModeSetting = function(value) setValue(value, {"silentMode"}) end,

}

-- =====================================================================================================================
-- Export
PAMF.PAJunk = PAJunkMenuFunctions