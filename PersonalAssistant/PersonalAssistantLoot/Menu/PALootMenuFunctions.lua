-- Local instances of Global tables --
local PA = PersonalAssistant
local PAL = PA.Loot
local PAEM = PA.EventManager
local PAMF = PA.MenuFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local getValue = PAMF.getValue
local setValue = PAMF.setValue
local isDisabled = PAMF.isDisabled

-- =================================================================================================================

--------------------------------------------------------------------------
-- PALoot   enabled
---------------------------------
local function setPALootEnabled(value)
    setValue(PAL.SavedVars, value, {"enabled"})

    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

-- =================================================================================================================

local PALootMenuFunctions = {
    isEnabled = function() return getValue(PAL.SavedVars, {"enabled"}) end,
    setIsEnabled = setPALootEnabled,

    -- ----------------------------------------------------------------------------------
    -- RECIPES SETTINGS
    -- -----------------------------
    isLootRecipesMenuDisabled = function() return isDisabled(PAL.SavedVars, {"enabled"}, {"LootRecipes", "unknownRecipeMsg"}) end,
    isUnknownRecipeMsgDisabled = function() return isDisabled(PAL.SavedVars, {"enabled"}) end,
    getUnknownRecipeMsgSetting = function() return getValue(PAL.SavedVars, {"LootRecipes", "unknownRecipeMsg"}) end,
    setUnknownRecipeMsgSetting = function(value) setValue(PAL.SavedVars, value, {"LootRecipes", "unknownRecipeMsg"}) end,

    -- ----------------------------------------------------------------------------------
    -- MOTIFS SETTINGS
    -- -----------------------------
    isLootMotifsMenuDisabled = function() return isDisabled(PAL.SavedVars, {"enabled"}, {"LootMotifs", "unknownMotifMsg"}) end,
    isUnknownMotifMsgDisabled = function() return isDisabled(PAL.SavedVars, {"enabled"}) end,
    getUnknownMotifMsgSetting = function() return getValue(PAL.SavedVars, {"LootMotifs", "unknownMotifMsg"}) end,
    setUnknownMotifMsgSetting = function(value) setValue(PAL.SavedVars, value, {"LootMotifs", "unknownMotifMsg"}) end,

    -- ----------------------------------------------------------------------------------
    -- APPAREL WEAPONS SETTINGS
    -- -----------------------------
    isLootApparelWeaponsMenuDisabled = function() return isDisabled(PAL.SavedVars, {"enabled"}, {"LootApparelWeapons", "unknownTraitMsg"}) end,
    isUnknownTraitMsgDisabled = function() return isDisabled(PAL.SavedVars, {"enabled"}) end,
    getUnknownTraitMsgSetting = function() return getValue(PAL.SavedVars, {"LootApparelWeapons", "unknownTraitMsg"}) end,
    setUnknownTraitMsgSetting = function(value) setValue(PAL.SavedVars, value, {"LootApparelWeapons", "unknownTraitMsg"}) end,

    -- ----------------------------------------------------------------------------------

    isLowInventorySpaceWarningDisabled = function() return isDisabled(PAL.SavedVars, {"enabled"}) end,
    getLowInventorySpaceWarningSetting = function() return getValue(PAL.SavedVars, {"lowInventorySpaceWarning"}) end,
    setLowInventorySpaceWarningSetting = function(value) setValue(PAL.SavedVars, value, {"lowInventorySpaceWarning"}) end,

    isLowInventorySpaceThresholdDisabled = function() return isDisabled(PAL.SavedVars, {"enabled"}, {"lowInventorySpaceWarning"}) end,
    getLowInventorySpaceThresholdSetting = function() return getValue(PAL.SavedVars, {"lowInventorySpaceThreshold"}) end,
    setLowInventorySpaceThresholdSetting = function(value) setValue(PAL.SavedVars, value, {"lowInventorySpaceThreshold"}) end,

    isChatOutputDisabled = function() return isDisabled(PAL.SavedVars, {"enabled"}) end,
    getChatOutputSetting = function() return getValue(PAL.SavedVars, {"chatOutput"}) end,
    setChatOutputSetting = function(value) setValue(PAL.SavedVars, value, {"chatOutput"}) end,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PAMF.PALoot = PALootMenuFunctions