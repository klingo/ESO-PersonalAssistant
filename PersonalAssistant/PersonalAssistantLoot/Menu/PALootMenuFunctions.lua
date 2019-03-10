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

    isChatOutputDisabled = function() return isDisabled(PASV.Loot, {"enabled"}) end,
    getChatOutputSetting = function() return getValue(PASV.Loot, {"chatOutput"}) end,
    setChatOutputSetting = function(value) setValue(PASV.Loot, value, {"chatOutput"}) end,

    -- ----------------------------------------------------------------------------------
    -- RECIPES SETTINGS
    -- -----------------------------
    isLootRecipesMenuDisabled = function() return isDisabled(PASV.Loot, {"enabled"}, {"LootRecipes", "enabled"}) end,
    isLootRecipesDisabled = function() return isDisabled(PASV.Loot, {"enabled"}) end,
    getLootRecipesSetting = function() return getValue(PASV.Loot, {"LootRecipes", "enabled"}) end,
    setLootRecipesSetting = function(value) setValue(PASV.Loot, value, {"LootRecipes", "enabled"}) end,

    isUnknownRecipeMsgDisabled = function() return isDisabled(PASV.Loot, {"enabled"}, {"LootRecipes", "enabled"}) end,
    getUnknownRecipeMsgSetting = function() return getValue(PASV.Loot, {"LootRecipes", "unknownRecipeMsg"}) end,
    setUnknownRecipeMsgSetting = function(value) setValue(PASV.Loot, value, {"LootRecipes", "unknownRecipeMsg"}) end,

    -- ----------------------------------------------------------------------------------
    -- MOTIFS SETTINGS
    -- -----------------------------
    isLootMotifsMenuDisabled = function() return isDisabled(PASV.Loot, {"enabled"}, {"LootMotifs", "enabled"}) end,
    isLootMotifsDisabled = function() return isDisabled(PASV.Loot, {"enabled"}) end,
    getLootMotifsSetting = function() return getValue(PASV.Loot, {"LootMotifs", "enabled"}) end,
    setLootMotifsSetting = function(value) setValue(PASV.Loot, value, {"LootMotifs", "enabled"}) end,

    isUnknownMotifMsgDisabled = function() return isDisabled(PASV.Loot, {"enabled"}, {"LootMotifs", "enabled"}) end,
    getUnknownMotifMsgSetting = function() return getValue(PASV.Loot, {"LootMotifs", "unknownMotifMsg"}) end,
    setUnknownMotifMsgSetting = function(value) setValue(PASV.Loot, value, {"LootMotifs", "unknownMotifMsg"}) end,

    -- ----------------------------------------------------------------------------------
    -- APPAREL WEAPONS SETTINGS
    -- -----------------------------
    isLootApparelWeaponsMenuDisabled = function() return isDisabled(PASV.Loot, {"enabled"}, {"LootApparelWeapons", "enabled"}) end,
    isLootApparelWeaponsDisabled = function() return isDisabled(PASV.Loot, {"enabled"}) end,
    getLootApparelWeaponsSetting = function() return getValue(PASV.Loot, {"LootApparelWeapons", "enabled"}) end,
    setLootApparelWeaponsSetting = function(value) setValue(PASV.Loot, value, {"LootApparelWeapons", "enabled"}) end,

    isUnknownTraitMsgDisabled = function() return isDisabled(PASV.Loot, {"enabled"}, {"LootApparelWeapons", "enabled"}) end,
    getUnknownTraitMsgSetting = function() return getValue(PASV.Loot, {"LootApparelWeapons", "unknownTraitMsg"}) end,
    setUnknownTraitMsgSetting = function(value) setValue(PASV.Loot, value, {"LootApparelWeapons", "unknownTraitMsg"}) end,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PAMF.PALoot = PALootMenuFunctions