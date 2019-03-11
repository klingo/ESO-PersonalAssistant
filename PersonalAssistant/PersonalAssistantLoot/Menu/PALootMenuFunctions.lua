-- Local instances of Global tables --
local PA = PersonalAssistant
local PASV = PA.SavedVars
local PAEM = PA.EventManager
local PAMF = PA.MenuFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local isDisabledPAGeneralNoProfileSelected = PAMF.isDisabledPAGeneralNoProfileSelected
local getValue = PAMF.getValue
local setValue = PAMF.setValue
local isDisabled = PAMF.isDisabled

-- =================================================================================================================

--------------------------------------------------------------------------
-- PALoot   enabled
---------------------------------
local function getPALootEnabled()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    --    return (PASV.Loot[PA.activeProfile].enabled and not (GetSetting_Bool(SETTING_TYPE_LOOT, LOOT_SETTING_AUTO_LOOT)))
    return PASV.Loot[PA.activeProfile].enabled
end

local function setPALootEnabled(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].enabled = value
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

-- =================================================================================================================

local PALootMenuFunctions = {
    isEnabled = getPALootEnabled,
    setIsEnabled = setPALootEnabled,

    -- ----------------------------------------------------------------------------------
    -- RECIPES SETTINGS
    -- -----------------------------
    isLootRecipesMenuDisabled = function() return isDisabled(PASV.Loot, {"enabled"}, {"LootRecipes", "unknownRecipeMsg"}) end,
    isUnknownRecipeMsgDisabled = function() return isDisabled(PASV.Loot, {"enabled"}) end,
    getUnknownRecipeMsgSetting = function() return getValue(PASV.Loot, {"LootRecipes", "unknownRecipeMsg"}) end,
    setUnknownRecipeMsgSetting = function(value) setValue(PASV.Loot, value, {"LootRecipes", "unknownRecipeMsg"}) end,

    -- ----------------------------------------------------------------------------------
    -- MOTIFS SETTINGS
    -- -----------------------------
    isLootMotifsMenuDisabled = function() return isDisabled(PASV.Loot, {"enabled"}, {"LootMotifs", "unknownMotifMsg"}) end,
    isUnknownMotifMsgDisabled = function() return isDisabled(PASV.Loot, {"enabled"}) end,
    getUnknownMotifMsgSetting = function() return getValue(PASV.Loot, {"LootMotifs", "unknownMotifMsg"}) end,
    setUnknownMotifMsgSetting = function(value) setValue(PASV.Loot, value, {"LootMotifs", "unknownMotifMsg"}) end,

    -- ----------------------------------------------------------------------------------
    -- APPAREL WEAPONS SETTINGS
    -- -----------------------------
    isLootApparelWeaponsMenuDisabled = function() return isDisabled(PASV.Loot, {"enabled"}, {"LootApparelWeapons", "unknownTraitMsg"}) end,
    isUnknownTraitMsgDisabled = function() return isDisabled(PASV.Loot, {"enabled"}) end,
    getUnknownTraitMsgSetting = function() return getValue(PASV.Loot, {"LootApparelWeapons", "unknownTraitMsg"}) end,
    setUnknownTraitMsgSetting = function(value) setValue(PASV.Loot, value, {"LootApparelWeapons", "unknownTraitMsg"}) end,

    -- ----------------------------------------------------------------------------------

    isChatOutputDisabled = function() return isDisabled(PASV.Loot, {"enabled"}) end,
    getChatOutputSetting = function() return getValue(PASV.Loot, {"chatOutput"}) end,
    setChatOutputSetting = function(value) setValue(PASV.Loot, value, {"chatOutput"}) end,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PAMF.PALoot = PALootMenuFunctions