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
    isEnabled = function() return getValue({"enabled"}) end,
    setIsEnabled = function(value) setValueAndRefreshEvents(value, {"enabled"}) end,

    -- ----------------------------------------------------------------------------------
    -- RECIPES SETTINGS
    -- -----------------------------
    isLootRecipesMenuDisabled = function() return isDisabled({"enabled"}, {"LootRecipes", "unknownRecipeMsg"}) end,
    isUnknownRecipeMsgDisabled = function() return isDisabled({"enabled"}) end,
    getUnknownRecipeMsgSetting = function() return getValue({"LootRecipes", "unknownRecipeMsg"}) end,
    setUnknownRecipeMsgSetting = function(value) setValue(value, {"LootRecipes", "unknownRecipeMsg"}) end,

    -- ----------------------------------------------------------------------------------
    -- MOTIFS SETTINGS
    -- -----------------------------
    isLootMotifsMenuDisabled = function() return isDisabled({"enabled"}, {"LootMotifs", "unknownMotifMsg"}) end,
    isUnknownMotifMsgDisabled = function() return isDisabled({"enabled"}) end,
    getUnknownMotifMsgSetting = function() return getValue({"LootMotifs", "unknownMotifMsg"}) end,
    setUnknownMotifMsgSetting = function(value) setValue(value, {"LootMotifs", "unknownMotifMsg"}) end,

    -- ----------------------------------------------------------------------------------
    -- APPAREL WEAPONS SETTINGS
    -- -----------------------------
    isLootApparelWeaponsMenuDisabled = function() return isDisabled({"enabled"}, {"LootApparelWeapons", "unknownTraitMsg"}) end,
    isUnknownTraitMsgDisabled = function() return isDisabled({"enabled"}) end,
    getUnknownTraitMsgSetting = function() return getValue({"LootApparelWeapons", "unknownTraitMsg"}) end,
    setUnknownTraitMsgSetting = function(value) setValue(value, {"LootApparelWeapons", "unknownTraitMsg"}) end,

    -- ----------------------------------------------------------------------------------

    isLowInventorySpaceWarningDisabled = function() return isDisabled({"enabled"}) end,
    getLowInventorySpaceWarningSetting = function() return getValue({"lowInventorySpaceWarning"}) end,
    setLowInventorySpaceWarningSetting = function(value) setValue(value, {"lowInventorySpaceWarning"}) end,

    isLowInventorySpaceThresholdDisabled = function() return isDisabled({"enabled"}, {"lowInventorySpaceWarning"}) end,
    getLowInventorySpaceThresholdSetting = function() return getValue({"lowInventorySpaceThreshold"}) end,
    setLowInventorySpaceThresholdSetting = function(value) setValue(value, {"lowInventorySpaceThreshold"}) end,

    isSilentModeDisabled = function() return isDisabled({"enabled"}) end,
    getSilentModeSetting = function() return getValue({"silentMode"}) end,
    setSilentModeSetting = function(value) setValue(value, {"silentMode"}) end,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PAMF.PALoot = PALootMenuFunctions