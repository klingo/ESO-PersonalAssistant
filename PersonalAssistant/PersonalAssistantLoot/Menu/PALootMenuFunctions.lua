-- Local instances of Global tables --
local PA = PersonalAssistant
local PAL = PA.Loot
local PAMF = PA.MenuFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local function getValue(...)
    return PAMF.getValue(PAL.SavedVars, ...)
end

local function setValue(value, ...)
    PAMF.setValue(PAL.SavedVars, value, ...)
end

local function setValueAndRefreshEvents(value, ...)
    PAMF.setValueAndRefreshEvents(PAL.SavedVars, value, ...)
end

local function isDisabled(...)
    return PAMF.isDisabled(PAL.SavedVars, ...)
end

-- =================================================================================================================

local PALootMenuFunctions = {
    getLootEventsEnabledSetting = function() return getValue({"LootEvents", "lootEventsEnabled"}) end,
    setLootEventsEnabledSetting = function(value) setValueAndRefreshEvents(value, {"LootEvents", "lootEventsEnabled"}) end,

    -- ----------------------------------------------------------------------------------
    -- RECIPES SETTINGS
    -- -----------------------------
    isLootRecipesMenuDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}, {"LootEvents", "LootRecipes", "unknownRecipeMsg"}) end,
    isUnknownRecipeMsgDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getUnknownRecipeMsgSetting = function() return getValue({"LootEvents", "LootRecipes", "unknownRecipeMsg"}) end,
    setUnknownRecipeMsgSetting = function(value) setValue(value, {"LootEvents", "LootRecipes", "unknownRecipeMsg"}) end,

    -- ----------------------------------------------------------------------------------
    -- MOTIFS SETTINGS
    -- -----------------------------
    isLootMotifsMenuDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}, {"LootEvents", "LootMotifs", "unknownMotifMsg"}) end,
    isUnknownMotifMsgDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getUnknownMotifMsgSetting = function() return getValue({"LootEvents", "LootMotifs", "unknownMotifMsg"}) end,
    setUnknownMotifMsgSetting = function(value) setValue(value, {"LootEvents", "LootMotifs", "unknownMotifMsg"}) end,

    -- ----------------------------------------------------------------------------------
    -- APPAREL WEAPONS SETTINGS
    -- -----------------------------
    isLootApparelWeaponsMenuDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}, {"LootEvents", "LootApparelWeapons", "unknownTraitMsg"}) end,
    isUnknownTraitMsgDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getUnknownTraitMsgSetting = function() return getValue({"LootEvents", "LootApparelWeapons", "unknownTraitMsg"}) end,
    setUnknownTraitMsgSetting = function(value) setValue(value, {"LootEvents", "LootApparelWeapons", "unknownTraitMsg"}) end,

    -- ----------------------------------------------------------------------------------

    isLowInventorySpaceWarningDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getLowInventorySpaceWarningSetting = function() return getValue({"InventorySpace", "lowInventorySpaceWarning"}) end,
    setLowInventorySpaceWarningSetting = function(value) setValue(value, {"InventorySpace", "lowInventorySpaceWarning"}) end,

    isLowInventorySpaceThresholdDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}, {"InventorySpace", "lowInventorySpaceWarning"}) end,
    getLowInventorySpaceThresholdSetting = function() return getValue({"InventorySpace", "lowInventorySpaceThreshold"}) end,
    setLowInventorySpaceThresholdSetting = function(value) setValue(value, {"InventorySpace", "lowInventorySpaceThreshold"}) end,

    -- ----------------------------------------------------------------------------------

    getItemIconsEnabledSetting = function() return getValue({"ItemIcons", "itemIconsEnabled"}) end,
    setItemIconsEnabledSetting = function(value) setValue(value, {"ItemIcons", "itemIconsEnabled"}) end,

    isItemIconsSizeDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getItemIconsSizeSetting = function() return getValue({"ItemIcons", "iconSize"}) end,
    setItemIconsSizeSetting = function(value) setValue(value, {"ItemIcons", "iconSize"}) end,

    isItemIconsPositionDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getItemIconsPositionSetting = function() return getValue({"ItemIcons", "iconPosition"}) end,
    setItemIconsPositionSetting = function(value) setValue(value, {"ItemIcons", "iconPosition"}) end,

    -- ----------------------------------------------------------------------------------

    isSilentModeDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getSilentModeSetting = function() return getValue({"silentMode"}) end,
    setSilentModeSetting = function(value) setValue(value, {"silentMode"}) end,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PAMF.PALoot = PALootMenuFunctions