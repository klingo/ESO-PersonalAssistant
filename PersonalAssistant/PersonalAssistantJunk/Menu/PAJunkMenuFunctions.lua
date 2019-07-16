-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAJ = PA.Junk
local PAMF = PA.MenuFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local isDisabledPAGeneralNoProfileSelected = PAMF.isDisabledPAGeneralNoProfileSelected

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
    if tonumber(getValue({"Miscellaneous", "autoMarkGlyphQualityThreshold"})) == PAC.ITEM_QUALITY.DISABLED then return true end
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
    if isDisabledAll({"Armor", "autoMarkOrnate"}, {"Armor", "autoMarkIncludingSets"}, {"Armor", "autoMarkIntricateTrait"}, {"Armor", "autoMarkUnknownTraits"}) then
        if tonumber(getValue({"Armor", "autoMarkQualityThreshold"})) == PAC.ITEM_QUALITY.DISABLED then return true end
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
    if isDisabledAll({"Jewelry", "autoMarkOrnate"}, {"Jewelry", "autoMarkIncludingSets"}, {"Jewelry", "autoMarkIntricateTrait"}, {"Jewelry", "autoMarkUnknownTraits"}) then
        if tonumber(getValue({"Jewelry", "autoMarkQualityThreshold"})) == PAC.ITEM_QUALITY.DISABLED then return true end
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
-- PAJunk   Stolen
---------------------------------
local function isPAJunkStolenMenuDisabled()
    if isDisabled({"autoMarkAsJunkEnabled"}) then return true end
    if not (tonumber(getValue({"Stolen", "styleMaterialAction"})) == PAC.ITEM_ACTION.NOTHING) then return false end
    if not (tonumber(getValue({"Stolen", "traitItemAction"})) == PAC.ITEM_ACTION.NOTHING) then return false end
    if not (tonumber(getValue({"Stolen", "lureAction"})) == PAC.ITEM_ACTION.NOTHING) then return false end
    if not (tonumber(getValue({"Stolen", "ingredientAction"})) == PAC.ITEM_ACTION.NOTHING) then return false end
    if not (tonumber(getValue({"Stolen", "foodAction"})) == PAC.ITEM_ACTION.NOTHING) then return false end
    if not (tonumber(getValue({"Stolen", "drinkAction"})) == PAC.ITEM_ACTION.NOTHING) then return false end
    if not (tonumber(getValue({"Stolen", "Treasure", "action"})) == PAC.ITEM_ACTION.NOTHING) then return false end
    if not (tonumber(getValue({"Stolen", "Weapons", "action"})) == PAC.ITEM_ACTION.NOTHING) then return false end
    if not (tonumber(getValue({"Stolen", "Armor", "action"})) == PAC.ITEM_ACTION.NOTHING) then return false end
    if not (tonumber(getValue({"Stolen", "Jewelry", "action"})) == PAC.ITEM_ACTION.NOTHING) then return false end
    -- if no 'false' returned so far, return true now
    return true
end

--------------------------------------------------------------------------
-- PAJunk   Stolen      excludeAMatterOfLeisure/excludeAMatterOfRespect/excludeAMatterOfTributes
---------------------------------
local function isPAJunkStolenTreasureExcludeQuestsDisabled()
    if isDisabled({"autoMarkAsJunkEnabled"}) then return true end
    if tonumber(getValue({"Stolen", "Treasure", "action"})) == PAC.ITEM_ACTION.NOTHING then return true end
    -- if no 'true' returned so far, return false now
    return false
end

--------------------------------------------------------------------------
-- PAJunk   AutoDestroy     destroyWorthlessJunk
---------------------------------
local function setPAJunkAutoDestroyWorthlessJunkSetting(value)
    if isDisabledPAGeneralNoProfileSelected() then return end
    setValue(value, {"AutoDestroy", "destroyWorthlessJunk"})
    if tostring(value) == "true" then
        PAJ.println(SI_PA_CHAT_JUNK_DESTROY_WORTHLESS_ON)
    else
        PAJ.println(SI_PA_CHAT_JUNK_DESTROY_WORTHLESS_OFF)
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
    isJewelryIncludeUnknownTraitsDisabled = isPAJunkJewelryIncludesDisabled,
    getJewelryIncludeUnknownTraitsSetting = function() return getValue({"Jewelry", "autoMarkUnknownTraits"}) end,
    setJewelryIncludeUnknownTraitsSetting = function(value) setValue(value, {"Jewelry", "autoMarkUnknownTraits"}) end,

    isStolenMenuDisabled = isPAJunkStolenMenuDisabled,
    isStolenWeaponActionDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getStolenWeaponActionSetting = function() return getValue({"Stolen", "Weapons", "action"}) end,
    setStolenWeaponActionSetting = function(value) setValue(value, {"Stolen", "Weapons", "action"}) end,
    isStolenArmorActionDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getStolenArmorActionSetting = function() return getValue({"Stolen", "Armor", "action"}) end,
    setStolenArmorActionSetting = function(value) setValue(value, {"Stolen", "Armor", "action"}) end,
    isStolenJewelryActionDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getStolenJewelryActionSetting = function() return getValue({"Stolen", "Jewelry", "action"}) end,
    setStolenJewelryActionSetting = function(value) setValue(value, {"Stolen", "Jewelry", "action"}) end,
    isStolenStyleMaterialActionDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getStolenStyleMaterialActionSetting = function() return getValue({"Stolen", "styleMaterialAction"}) end,
    setStolenStyleMaterialActionSetting = function(value) setValue(value, {"Stolen", "styleMaterialAction"}) end,
    isStolenTraitItemActionDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getStolenTraitItemActionSetting = function() return getValue({"Stolen", "traitItemAction"}) end,
    setStolenTraitItemActionSetting = function(value) setValue(value, {"Stolen", "traitItemAction"}) end,
    isStolenLureActionDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getStolenLureActionSetting = function() return getValue({"Stolen", "lureAction"}) end,
    setStolenLureActionSetting = function(value) setValue(value, {"Stolen", "lureAction"}) end,
    isStolenIngredientActionDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getStolenIngredientActionSetting = function() return getValue({"Stolen", "ingredientAction"}) end,
    setStolenIngredientActionSetting = function(value) setValue(value, {"Stolen", "ingredientAction"}) end,
    isStolenFoodActionDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getStolenFoodActionSetting = function() return getValue({"Stolen", "foodAction"}) end,
    setStolenFoodActionSetting = function(value) setValue(value, {"Stolen", "foodAction"}) end,
    isStolenDrinkActionDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getStolenDrinkActionSetting = function() return getValue({"Stolen", "drinkAction"}) end,
    setStolenDrinkActionSetting = function(value) setValue(value, {"Stolen", "drinkAction"}) end,
    isStolenTreasureActionDisabled = function() return isDisabled({"autoMarkAsJunkEnabled"}) end,
    getStolenTreasureActionSetting = function() return getValue({"Stolen", "Treasure", "action"}) end,
    setStolenTreasureActionSetting = function(value) setValue(value, {"Stolen", "Treasure", "action"}) end,
    isExcludeAMatterOfLeisureDisabled = isPAJunkStolenTreasureExcludeQuestsDisabled,
    getExcludeAMatterOfLeisureSetting = function() return getValue({"Stolen", "Treasure", "excludeAMatterOfLeisure"}) end,
    setExcludeAMatterOfLeisureSetting = function(value) setValue(value, {"Stolen", "Treasure", "excludeAMatterOfLeisure"}) end,
    isExcludeAMatterOfRespectDisabled = isPAJunkStolenTreasureExcludeQuestsDisabled,
    getExcludeAMatterOfRespectSetting = function() return getValue({"Stolen", "Treasure", "excludeAMatterOfRespect"}) end,
    setExcludeAMatterOfRespectSetting = function(value) setValue(value, {"Stolen", "Treasure", "excludeAMatterOfRespect"}) end,
    isExcludeAMatterOfTributesDisabled = isPAJunkStolenTreasureExcludeQuestsDisabled,
    getExcludeAMatterOfTributesSetting = function() return getValue({"Stolen", "Treasure", "excludeAMatterOfTributes"}) end,
    setExcludeAMatterOfTributesSetting = function(value) setValue(value, {"Stolen", "Treasure", "excludeAMatterOfTributes"}) end,

    -- ----------------------------------------------------------------------------------
    -- AUTO-DESTROY JUNK
    -- -----------------------------
    isAutoDestroyWorthlessJunkDisabled = function() return isDisabled() end, -- currently always enabled
    getAutoDestroyWorthlessJunkSetting = function() return getValue({"AutoDestroy", "destroyWorthlessJunk"}) end,
    setAutoDestroyWorthlessJunkSetting = setPAJunkAutoDestroyWorthlessJunkSetting,

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