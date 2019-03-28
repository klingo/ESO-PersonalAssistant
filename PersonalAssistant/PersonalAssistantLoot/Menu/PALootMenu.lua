-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PALMenuFunctions = PA.MenuFunctions.PALoot
local PALMenuDefaults = PA.MenuDefaults.PALoot

local LAM2 = LibStub("LibAddonMenu-2.0")

local PALootPanelData = {
    type = "panel",
    name = "PersonalAssistant Loot",
    displayName = GetString(SI_PA_MENU_TITLE),
    author = "Klingo",
    version = PAC.ADDON_VERSION,
    website = "http://www.esoui.com/downloads/info381-PersonalAssistant",
    slashCommand = "/pal",
    registerForRefresh = true,
    registerForDefaults = true,
}

local PALootOptionsTable = setmetatable({}, { __index = table })

local PALLootRecipesSubmenuTable = setmetatable({}, { __index = table })
local PALLootMotifsSubmenuTable = setmetatable({}, { __index = table })
local PALLootApparelWeaponsSubmenuTable = setmetatable({}, { __index = table })

-- =================================================================================================================

local function _createPALootMenu()
    PALootOptionsTable:insert({
        type = "header",
        name = GetString(SI_PA_MENU_LOOT_HEADER)
    })

    PALootOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_LOOT_DESCRIPTION),
    })

    PALootOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_ENABLE),
        getFunc = PALMenuFunctions.isEnabled,
        setFunc = PALMenuFunctions.setIsEnabled,
        disabled = PA.MenuFunctions.PAGeneral.isNoProfileSelected,
        default = PALMenuDefaults.enabled,
    })

    PALootOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_LOOT_RECIPES_HEADER),
        controls = PALLootRecipesSubmenuTable,
        disabled = PALMenuFunctions.isLootRecipesMenuDisabled,
    })

    PALootOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_LOOT_MOTIFS_HEADER),
        controls = PALLootMotifsSubmenuTable,
        disabled = PALMenuFunctions.isLootMotifsMenuDisabled,
    })

    PALootOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_LOOT_APPARELWEAPONS_HEADER),
        controls = PALLootApparelWeaponsSubmenuTable,
        disabled = PALMenuFunctions.isLootApparelWeaponsMenuDisabled,
    })

    PALootOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING),
        tooltip = GetString(SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING_T),
        width = "half",
        getFunc = PALMenuFunctions.getLowInventorySpaceWarningSetting,
        setFunc = PALMenuFunctions.setLowInventorySpaceWarningSetting,
        disabled = PALMenuFunctions.isLowInventorySpaceWarningDisabled,
        default = PALMenuDefaults.lowInventorySpaceWarning,
    })

    PALootOptionsTable:insert({
        type = "slider",
        name = GetString(SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD),
        tooltip = GetString(SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD_T),
        min = 0,
        max = GetNumBagFreeSlots(BAG_BACKPACK) + GetNumBagUsedSlots(BAG_BACKPACK),
        step = 1,
        width = "half",
        getFunc = PALMenuFunctions.getLowInventorySpaceThresholdSetting,
        setFunc = PALMenuFunctions.setLowInventorySpaceThresholdSetting,
        disabled = PALMenuFunctions.isLowInventorySpaceThresholdDisabled,
        default = PALMenuDefaults.lowInventorySpaceThreshold,
    })

    PALootOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_SILENT_MODE),
        getFunc = PALMenuFunctions.getSilentModeSetting,
        setFunc = PALMenuFunctions.setSilentModeSetting,
        disabled = PALMenuFunctions.isSilentModeDisabled,
        default = PALMenuDefaults.silentMode,
    })
end

-- =================================================================================================================

local function _createPALLootRecipesSubmenuTable()
    PALLootRecipesSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG),
        tooltip = GetString(SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG_T),
        getFunc = PALMenuFunctions.getUnknownRecipeMsgSetting,
        setFunc = PALMenuFunctions.setUnknownRecipeMsgSetting,
        disabled = PALMenuFunctions.isUnknownRecipeMsgDisabled,
        default = PALMenuDefaults.LootRecipes.unknownRecipeMsg,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPALLootMotifsSubmenuTable()
    PALLootMotifsSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG),
        tooltip = GetString(SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG_T),
        getFunc = PALMenuFunctions.getUnknownMotifMsgSetting,
        setFunc = PALMenuFunctions.setUnknownMotifMsgSetting,
        disabled = PALMenuFunctions.isUnknownMotifMsgDisabled,
        default = PALMenuDefaults.LootMotifs.unknownMotifMsg,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPALLootApparelWeaponsSubmenuTable()
    PALLootApparelWeaponsSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG),
        tooltip = GetString(SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG_T),
        getFunc = PALMenuFunctions.getUnknownTraitMsgSetting,
        setFunc = PALMenuFunctions.setUnknownTraitMsgSetting,
        disabled = PALMenuFunctions.isUnknownTraitMsgDisabled,
        default = PALMenuDefaults.LootApparelWeapons.unknownTraitMsg,
    })
end

-- =================================================================================================================

local function createOptions()
    _createPALootMenu()

    _createPALLootRecipesSubmenuTable()
    _createPALLootMotifsSubmenuTable()
    _createPALLootApparelWeaponsSubmenuTable()

    LAM2:RegisterAddonPanel("PersonalAssistantLootAddonOptions", PALootPanelData)
    LAM2:RegisterOptionControls("PersonalAssistantLootAddonOptions", PALootOptionsTable)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Loot = PA.Loot or {}
PA.Loot.createOptions = createOptions
