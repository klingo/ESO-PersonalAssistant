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

local function isDisabledAll(...)
    return PAMF.isDisabledAll(PAL.SavedVars, ...)
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
    isLootMotifsMenuDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) or isDisabledAll({"LootEvents", "LootMotifs", "unknownMotifMsg"}, {"LootEvents", "LootMotifs", "unknownStylePageMsg"}) end,
    isUnknownMotifMsgDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getUnknownMotifMsgSetting = function() return getValue({"LootEvents", "LootMotifs", "unknownMotifMsg"}) end,
    setUnknownMotifMsgSetting = function(value) setValue(value, {"LootEvents", "LootMotifs", "unknownMotifMsg"}) end,
    isUnknownStylePageMsgDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getUnknownStylePageMsgSetting = function() return getValue({"LootEvents", "LootMotifs", "unknownStylePageMsg"}) end,
    setUnknownStylePageMsgSetting = function(value) setValue(value, {"LootEvents", "LootMotifs", "unknownStylePageMsg"}) end,

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

    -- ----------------------------------------------------------------------------------
    -- RECIPES SETTINGS
    -- -----------------------------
    isMarkRecipesMenuDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) or isDisabledAll({"ItemIcons", "Recipes", "showKnownIcon"}, {"ItemIcons", "Recipes", "showUnknownIcon"}) end,
    isMarkKnownRecipesDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getMarkKnownRecipesSetting = function() return getValue({"ItemIcons", "Recipes", "showKnownIcon"}) end,
    setMarkKnownRecipesSetting = function(value) setValue(value, {"ItemIcons", "Recipes", "showKnownIcon"}) PA.Loot.ItemIcons.refreshScrollListVisible() end,

    isMarkUnknownRecipesDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getMarkUnknownRecipesSetting = function() return getValue({"ItemIcons", "Recipes", "showUnknownIcon"})  end,
    setMarkUnknownRecipesSetting = function(value) setValue(value, {"ItemIcons", "Recipes", "showUnknownIcon"}) PA.Loot.ItemIcons.refreshScrollListVisible() end,

    -- ----------------------------------------------------------------------------------
    -- MOTIFS SETTINGS
    -- -----------------------------
    isMarkMotifsMenuDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) or isDisabledAll({"ItemIcons", "Motifs", "showKnownIcon"}, {"ItemIcons", "Motifs", "showUnknownIcon"}) end,
    isMarkKnownMotifsDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getMarkKnownMotifsSetting = function() return getValue({"ItemIcons", "Motifs", "showKnownIcon"}) end,
    setMarkKnownMotifsSetting = function(value) setValue(value, {"ItemIcons", "Motifs", "showKnownIcon"}) PA.Loot.ItemIcons.refreshScrollListVisible() end,

    isMarkUnknownMotifsDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getMarkUnknownMotifsSetting = function() return getValue({"ItemIcons", "Motifs", "showUnknownIcon"})  end,
    setMarkUnknownMotifsSetting = function(value) setValue(value, {"ItemIcons", "Motifs", "showUnknownIcon"}) PA.Loot.ItemIcons.refreshScrollListVisible() end,

    -- ----------------------------------------------------------------------------------
    -- APPAREL WEAPONS SETTINGS
    -- -----------------------------
    isMarkApparelWeaponsMenuDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) or isDisabledAll({"ItemIcons", "ApparelWeapons", "showKnownIcon"}, {"ItemIcons", "ApparelWeapons", "showUnknownIcon"}) end,
    isMarkKnownApparelWeaponsDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getMarkKnownApparelWeaponsSetting = function() return getValue({"ItemIcons", "ApparelWeapons", "showKnownIcon"}) end,
    setMarkKnownApparelWeaponsSetting = function(value) setValue(value, {"ItemIcons", "ApparelWeapons", "showKnownIcon"}) PA.Loot.ItemIcons.refreshScrollListVisible() end,

    isMarkUnknownApparelWeaponsDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getMarkUnknownApparelWeaponsSetting = function() return getValue({"ItemIcons", "ApparelWeapons", "showUnknownIcon"})  end,
    setMarkUnknownApparelWeaponsSetting = function(value) setValue(value, {"ItemIcons", "ApparelWeapons", "showUnknownIcon"}) PA.Loot.ItemIcons.refreshScrollListVisible() end,

    -- ----------------------------------------------------------------------------------

    isItemIconsTooltipShownDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getItemIconsTooltipShownSetting = function() return getValue({"ItemIcons", "iconTooltipShown"}) end,
    setItemIconsTooltipShownSetting = function(value) setValue(value, {"ItemIcons", "iconTooltipShown"}) PA.Loot.ItemIcons.refreshScrollListVisible() end,

    isItemIconsSizeRowDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getItemIconsSizeRowSetting = function() return getValue({"ItemIcons", "iconSizeRow"}) end,
    setItemIconsSizeRowSetting = function(value) setValue(value, {"ItemIcons", "iconSizeRow"}) PA.Loot.ItemIcons.refreshScrollListVisible() end,

    isItemIconsSizeGridDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getItemIconsSizeGridSetting = function() return getValue({"ItemIcons", "iconSizeGrid"}) end,
    setItemIconsSizeGridSetting = function(value) setValue(value, {"ItemIcons", "iconSizeGrid"}) PA.Loot.ItemIcons.refreshScrollListVisible() end,

    isItemIconsPositionDisabled = function() return isDisabled({"ItemIcons", "itemIconsEnabled"}) end,
    getItemIconsPositionSetting = function() return getValue({"ItemIcons", "iconPositionGrid"}) end,
    setItemIconsPositionSetting = function(value) setValue(value, {"ItemIcons", "iconPositionGrid"}) end,

    -- ----------------------------------------------------------------------------------

    isSilentModeDisabled = function() return isDisabled({"LootEvents", "lootEventsEnabled"}) end,
    getSilentModeSetting = function() return getValue({"silentMode"}) end,
    setSilentModeSetting = function(value) setValue(value, {"silentMode"}) end,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PAMF.PALoot = PALootMenuFunctions