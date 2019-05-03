-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACAddon = PAC.ADDON
local PALMenuFunctions = PA.MenuFunctions.PALoot
local PALMenuDefaults = PA.MenuDefaults.PALoot

local LAM2 = LibAddonMenu2 or LibStub("LibAddonMenu-2.0")

local PALootPanelData = {
    type = "panel",
    name = PACAddon.NAME_RAW.LOOT,
    displayName = PACAddon.NAME_DISPLAY,
    author = PACAddon.AUTHOR,
    version = PACAddon.VERSION_DISPLAY,
    website = PACAddon.WEBSITE,
    feedback = PACAddon.FEEDBACK,
    keywords = PACAddon.KEYWORDS.LOOT,
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
        name = GetString(SI_PA_MENU_LOOT_EVENTS_ENABLE),
        getFunc = PALMenuFunctions.getLootEventsEnabledSetting,
        setFunc = PALMenuFunctions.setLootEventsEnabledSetting,
        disabled = PA.MenuFunctions.PAGeneral.isNoProfileSelected,
        default = PALMenuDefaults.LootEvents.lootEventsEnabled,
    })

    PALootOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_LOOT_RECIPES_HEADER),
        icon = PAC.ICONS.ITEMS.RECIPE.PATH,
        controls = PALLootRecipesSubmenuTable,
        disabledLabel = PALMenuFunctions.isLootRecipesMenuDisabled,
    })

    PALootOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_LOOT_MOTIFS_HEADER),
        icon = PAC.ICONS.ITEMS.MOTIF.PATH,
        controls = PALLootMotifsSubmenuTable,
        disabledLabel = PALMenuFunctions.isLootMotifsMenuDisabled,
    })

    PALootOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_LOOT_APPARELWEAPONS_HEADER),
        icon = PAC.ICONS.CRAFTBAG.WEAPON.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PALLootApparelWeaponsSubmenuTable,
        disabledLabel = PALMenuFunctions.isLootApparelWeaponsMenuDisabled,
    })

    PALootOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING),
        tooltip = GetString(SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING_T),
        width = "half",
        getFunc = PALMenuFunctions.getLowInventorySpaceWarningSetting,
        setFunc = PALMenuFunctions.setLowInventorySpaceWarningSetting,
        disabled = PALMenuFunctions.isLowInventorySpaceWarningDisabled,
        default = PALMenuDefaults.InventorySpace.lowInventorySpaceWarning,
    })

    PALootOptionsTable:insert({
        type = "slider",
        name = GetString(SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD),
        tooltip = GetString(SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD_T),
        min = 0,
        max = GetBagSize(BAG_BACKPACK),
        step = 1,
        width = "half",
        getFunc = PALMenuFunctions.getLowInventorySpaceThresholdSetting,
        setFunc = PALMenuFunctions.setLowInventorySpaceThresholdSetting,
        disabled = PALMenuFunctions.isLowInventorySpaceThresholdDisabled,
        default = PALMenuDefaults.InventorySpace.lowInventorySpaceThreshold,
    })

    -- ---------------------------------------------------------------------------------------------------------

    PALootOptionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PALootOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_ICONS_ENABLE),
        getFunc = PALMenuFunctions.getItemIconsEnabledSetting,
        setFunc = PALMenuFunctions.setItemIconsEnabledSetting,
        disabled = PA.MenuFunctions.PAGeneral.isNoProfileSelected,
        default = PALMenuDefaults.ItemIcons.itemIconsEnabled,
    })

    -- TODO: add new settings


    -- ---------------------------------------------------------------------------------------------------------

    PALootOptionsTable:insert({
        type = "divider",
        alpha = 0.5,
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
        default = PALMenuDefaults.LootEvents.LootRecipes.unknownRecipeMsg,
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
        default = PALMenuDefaults.LootEvents.LootMotifs.unknownMotifMsg,
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
        default = PALMenuDefaults.LootEvents.LootApparelWeapons.unknownTraitMsg,
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
