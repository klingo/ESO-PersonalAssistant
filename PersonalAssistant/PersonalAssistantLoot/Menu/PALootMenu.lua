-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACAddon = PAC.ADDON
local PALMenuChoices = PA.MenuChoices.choices.PALoot
local PALMenuChoicesValues = PA.MenuChoices.choicesValues.PALoot
local PALProfileManager = PA.ProfileManager.PALoot
local PALMenuDefaults = PA.MenuDefaults.PALoot
local PALMenuFunctions = PA.MenuFunctions.PALoot

-- =====================================================================================================================

-- Create the LibAddonMenu2 object
PA.LAM2 = PA.LAM2 or LibAddonMenu2 or LibStub("LibAddonMenu-2.0")

local PALootPanelData = {
    type = "panel",
    name = PACAddon.NAME_RAW.LOOT,
    displayName = PACAddon.NAME_DISPLAY.LOOT,
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
local PALootProfileSubMenuTable = setmetatable({}, { __index = table })

local PALLootRecipesSubmenuTable = setmetatable({}, { __index = table })
local PALLootStylesSubmenuTable = setmetatable({}, { __index = table })
local PALLootApparelWeaponsSubmenuTable = setmetatable({}, { __index = table })

local PALMarkRecipesSubmenuTable = setmetatable({}, { __index = table })
local PALMarkMotifsSubmenuTable = setmetatable({}, { __index = table })
local PALMarkApparelWeaponsSubmenuTable = setmetatable({}, { __index = table })

-- =================================================================================================================

local function _createPALootMenu()
    PALootOptionsTable:insert({
        type = "submenu",
        name = PALProfileManager.getProfileSubMenuHeader,
        controls = PALootProfileSubMenuTable
    })

    PALootOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_LOOT_DESCRIPTION),
    })

    PALootOptionsTable:insert({
        type = "header",
        name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_LOOT_EVENTS_HEADER))
    })

    PALootOptionsTable:insert({
        type = "checkbox",
        name = PAC.COLOR.LIGHT_BLUE:Colorize(GetString(SI_PA_MENU_LOOT_EVENTS_ENABLE)),
        getFunc = PALMenuFunctions.getLootEventsEnabledSetting,
        setFunc = PALMenuFunctions.setLootEventsEnabledSetting,
        disabled = PALProfileManager.isNoProfileSelected,
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
        name = GetString(SI_PA_MENU_LOOT_STYLES_HEADER),
        icon = PAC.ICONS.ITEMS.MOTIF.PATH,
        controls = PALLootStylesSubmenuTable,
        disabledLabel = PALMenuFunctions.isLootStylesMenuDisabled,
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
        type = "header",
        name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_LOOT_ICONS_HEADER))
    })

    PALootOptionsTable:insert({
        type = "checkbox",
        name = PAC.COLOR.LIGHT_BLUE:Colorize(GetString(SI_PA_MENU_LOOT_ICONS_ENABLE)),
        getFunc = PALMenuFunctions.getItemIconsEnabledSetting,
        setFunc = PALMenuFunctions.setItemIconsEnabledSetting,
        disabled = PALProfileManager.isNoProfileSelected,
        default = PALMenuDefaults.ItemIcons.itemIconsEnabled,
    })

    PALootOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_LOOT_ICONS_RECIPES_HEADER),
        icon = PAC.ICONS.ITEMS.RECIPE.PATH,
        controls = PALMarkRecipesSubmenuTable,
        disabledLabel = PALMenuFunctions.isMarkRecipesMenuDisabled,
    })

    PALootOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_LOOT_ICONS_STYLES_HEADER),
        icon = PAC.ICONS.ITEMS.MOTIF.PATH,
        controls = PALMarkMotifsSubmenuTable,
        disabledLabel = PALMenuFunctions.isMarkMotifsMenuDisabled,
    })

    PALootOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_HEADER),
        icon = PAC.ICONS.CRAFTBAG.WEAPON.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PALMarkApparelWeaponsSubmenuTable,
        disabledLabel = PALMenuFunctions.isMarkApparelWeaponsMenuDisabled,
    })

    -- only display if [InventoryGridView] or [GridList] is installed and active
    if _G["InventoryGridView"] ~= nil or _G["GridList"] then
        PALootOptionsTable:insert({
            type = "slider",
            name = GetString(SI_PA_MENU_LOOT_ICONS_SIZE_LIST),
            tooltip = GetString(SI_PA_MENU_LOOT_ICONS_SIZE_LIST_T),
            min = 8,
            max = 64,
            step = 1,
            width = "half",
            getFunc = PALMenuFunctions.getItemIconsSizeListSetting,
            setFunc = PALMenuFunctions.setItemIconsSizeListSetting,
            disabled = PALMenuFunctions.isItemIconsSizeListDisabled,
            default = PALMenuDefaults.ItemIcons.iconSizeRow,
        })

        PALootOptionsTable:insert({
            type = "slider",
            name = GetString(SI_PA_MENU_LOOT_ICONS_SIZE_GRID),
            tooltip = GetString(SI_PA_MENU_LOOT_ICONS_SIZE_GRID_T),
            min = 8,
            max = 64,
            step = 1,
            width = "half",
            getFunc = PALMenuFunctions.getItemIconsSizeGridSetting,
            setFunc = PALMenuFunctions.setItemIconsSizeGridSetting,
            disabled = PALMenuFunctions.isItemIconsSizeGridDisabled,
            default = PALMenuDefaults.ItemIcons.iconSizeGrid,
        })

        PALootOptionsTable:insert({
            type = "slider",
            name = GetString(SI_PA_MENU_LOOT_ICONS_X_OFFSET_LIST),
            tooltip = GetString(SI_PA_MENU_LOOT_ICONS_X_OFFSET_LIST_T),
            min = -380,
            max = 150,
            step = 1,
            width = "half",
            getFunc = PALMenuFunctions.getItemIconsXOffsetListSetting,
            setFunc = PALMenuFunctions.setItemIconsXOffsetListSetting,
            disabled = PALMenuFunctions.isItemIconsXOffsetListDisabled,
            default = PALMenuDefaults.ItemIcons.iconXOffsetList,
        })

        PALootOptionsTable:insert({
            type = "slider",
            name = GetString(SI_PA_MENU_LOOT_ICONS_X_OFFSET_GRID),
            tooltip = GetString(SI_PA_MENU_LOOT_ICONS_X_OFFSET_GRID_T),
            min = 0,
            max = 100,
            step = 1,
            width = "half",
            getFunc = PALMenuFunctions.getItemIconsXOffsetGridSetting,
            setFunc = PALMenuFunctions.setItemIconsXOffsetGridSetting,
            disabled = PALMenuFunctions.isItemIconsXOffsetGridDisabled,
            default = PALMenuDefaults.ItemIcons.iconXOffsetGrid,
        })

        PALootOptionsTable:insert({
            type = "slider",
            name = GetString(SI_PA_MENU_LOOT_ICONS_Y_OFFSET_LIST),
            tooltip = GetString(SI_PA_MENU_LOOT_ICONS_Y_OFFSET_LIST_T),
            min = -20,
            max = 20,
            step = 1,
            width = "half",
            getFunc = PALMenuFunctions.getItemIconsYOffsetListSetting,
            setFunc = PALMenuFunctions.setItemIconsYOffsetListSetting,
            disabled = PALMenuFunctions.isItemIconsYOffsetListDisabled,
            default = PALMenuDefaults.ItemIcons.iconYOffsetList,
        })

        PALootOptionsTable:insert({
            type = "slider",
            name = GetString(SI_PA_MENU_LOOT_ICONS_Y_OFFSET_GRID),
            tooltip = GetString(SI_PA_MENU_LOOT_ICONS_Y_OFFSET_GRID_T),
            min = -100,
            max = 0,
            step = 1,
            width = "half",
            getFunc = PALMenuFunctions.getItemIconsYOffsetGridSetting,
            setFunc = PALMenuFunctions.setItemIconsYOffsetGridSetting,
            disabled = PALMenuFunctions.isItemIconsYOffsetGridDisabled,
            default = PALMenuDefaults.ItemIcons.iconYOffsetGrid,
        })
    else
        -- regular list-view of items
        PALootOptionsTable:insert({
            type = "slider",
            name = GetString(SI_PA_MENU_LOOT_ICONS_SIZE_LIST),
            tooltip = GetString(SI_PA_MENU_LOOT_ICONS_SIZE_LIST_T),
            min = 8,
            max = 64,
            step = 1,
            getFunc = PALMenuFunctions.getItemIconsSizeListSetting,
            setFunc = PALMenuFunctions.setItemIconsSizeListSetting,
            disabled = PALMenuFunctions.isItemIconsSizeListDisabled,
            default = PALMenuDefaults.ItemIcons.iconSizeRow,
        })

        PALootOptionsTable:insert({
            type = "slider",
            name = GetString(SI_PA_MENU_LOOT_ICONS_X_OFFSET_LIST),
            tooltip = GetString(SI_PA_MENU_LOOT_ICONS_X_OFFSET_LIST_T),
            min = -380,
            max = 150,
            step = 1,
            width = "half",
            getFunc = PALMenuFunctions.getItemIconsXOffsetListSetting,
            setFunc = PALMenuFunctions.setItemIconsXOffsetListSetting,
            disabled = PALMenuFunctions.isItemIconsXOffsetListDisabled,
            default = PALMenuDefaults.ItemIcons.iconXOffsetList,
        })

        PALootOptionsTable:insert({
            type = "slider",
            name = GetString(SI_PA_MENU_LOOT_ICONS_Y_OFFSET_LIST),
            tooltip = GetString(SI_PA_MENU_LOOT_ICONS_Y_OFFSET_LIST_T),
            min = -20,
            max = 20,
            step = 1,
            width = "half",
            getFunc = PALMenuFunctions.getItemIconsYOffsetListSetting,
            setFunc = PALMenuFunctions.setItemIconsYOffsetListSetting,
            disabled = PALMenuFunctions.isItemIconsYOffsetListDisabled,
            default = PALMenuDefaults.ItemIcons.iconYOffsetList,
        })
    end

    PALootOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_ICONS_ANY_SHOW_TOOLTIP),
        getFunc = PALMenuFunctions.getItemIconsTooltipShownSetting,
        setFunc = PALMenuFunctions.setItemIconsTooltipShownSetting,
        disabled = PALMenuFunctions.isItemIconsTooltipShownDisabled,
        default = PALMenuDefaults.ItemIcons.iconTooltipShown,
    })

    -- ---------------------------------------------------------------------------------------------------------

    PALootOptionsTable:insert({
        type = "header",
        name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_OTHER_SETTINGS_HEADER))
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

local function _createPALootProfileSubMenuTable()
    PALootProfileSubMenuTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_PROFILE_ACTIVE),
        tooltip = GetString(SI_PA_MENU_PROFILE_ACTIVE_T),
        choices = PALProfileManager.getProfileList(),
        choicesValues = PALProfileManager.getProfileListValues(),
        width = "half",
        getFunc = PALProfileManager.getActiveProfile,
        setFunc = PALProfileManager.setActiveProfile,
        reference = "PERSONALASSISTANT_LOOT_PROFILEDROPDOWN"
    })

    PALootProfileSubMenuTable:insert({
        type = "editbox",
        name = GetString(SI_PA_MENU_PROFILE_ACTIVE_RENAME),
        maxChars = 40,
        width = "half",
        getFunc = PALProfileManager.getActiveProfileName,
        setFunc = PALProfileManager.setActiveProfileName,
        disabled = PALProfileManager.isNoProfileSelected
    })

    PALootProfileSubMenuTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_PROFILE_CREATE_NEW),
        width = "half",
        func = PALProfileManager.createNewProfile,
        disabled = PALProfileManager.hasMaxProfileCountReached
    })

    PALootProfileSubMenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_PROFILE_CREATE_NEW_DESC),
        disabled = PALProfileManager.hasMaxProfileCountReached
    })

    PALootProfileSubMenuTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PALootProfileSubMenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_PROFILE_COPY_FROM_DESC),
        disabled = function() return PALProfileManager.hasOnlyOneProfile() or PALProfileManager.isNoProfileSelected() end,
    })

    PALootProfileSubMenuTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_PROFILE_COPY_FROM),
        choices = PALProfileManager.getInactiveProfileList(),
        choicesValues = PALProfileManager.getInactiveProfileListValues(),
        width = "half",
        getFunc = function() return PA.Loot.selectedCopyProfile end,
        setFunc = function(value) PA.Loot.selectedCopyProfile = value end,
        disabled = function() return PALProfileManager.hasOnlyOneProfile() or PALProfileManager.isNoProfileSelected() end,
        reference = "PERSONALASSISTANT_LOOT_PROFILEDROPDOWN_COPY"
    })

    PALootProfileSubMenuTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM),
        width = "half",
        func = PALProfileManager.copySelectedProfile,
        isDangerous = true,
        warning = GetString(SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM_W),
        disabled = PALProfileManager.isNoCopyProfileSelected
    })

    PALootProfileSubMenuTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PALootProfileSubMenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_PROFILE_DELETE_DESC),
        disabled = PALProfileManager.hasOnlyOneProfile
    })

    PALootProfileSubMenuTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_PROFILE_DELETE),
        choices = PALProfileManager.getInactiveProfileList(),
        choicesValues = PALProfileManager.getInactiveProfileListValues(),
        width = "half",
        getFunc = function() return PA.Loot.selectedDeleteProfile end,
        setFunc = function(value) PA.Loot.selectedDeleteProfile = value end,
        disabled = PALProfileManager.hasOnlyOneProfile,
        reference = "PERSONALASSISTANT_LOOT_PROFILEDROPDOWN_DELETE"
    })

    PALootProfileSubMenuTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_PROFILE_DELETE_CONFIRM),
        width = "half",
        func = PALProfileManager.deleteSelectedProfile,
        isDangerous = true,
        warning = GetString(SI_PA_MENU_PROFILE_DELETE_CONFIRM_W),
        disabled = PALProfileManager.isNoDeleteProfileSelected
    })
end

-- =================================================================================================================

local function _createPALLootRecipesSubmenuTable()
    PALLootRecipesSubmenuTable:insert({
        type = "description",
        text = GetString(SI_PA_DISPLAY_A_MESSAGE_WHEN),
        disabled = PALMenuFunctions.isLootRecipesMenuDisabled,
    })

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

local function _createPALLootStylesSubmenuTable()
    PALLootStylesSubmenuTable:insert({
        type = "description",
        text = GetString(SI_PA_DISPLAY_A_MESSAGE_WHEN),
        disabled = PALMenuFunctions.isLootStylesMenuDisabled,
    })

    PALLootStylesSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG),
        tooltip = GetString(SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG_T),
        getFunc = PALMenuFunctions.getUnknownMotifMsgSetting,
        setFunc = PALMenuFunctions.setUnknownMotifMsgSetting,
        disabled = PALMenuFunctions.isUnknownMotifMsgDisabled,
        default = PALMenuDefaults.LootEvents.LootStyles.unknownMotifMsg,
    })

    PALLootStylesSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_STYLEPAGES_UNKNOWN_MSG),
        tooltip = GetString(SI_PA_MENU_LOOT_STYLEPAGES_UNKNOWN_MSG_T),
        getFunc = PALMenuFunctions.getUnknownStylePageMsgSetting,
        setFunc = PALMenuFunctions.setUnknownStylePageMsgSetting,
        disabled = PALMenuFunctions.isUnknownStylePageMsgDisabled,
        default = PALMenuDefaults.LootEvents.LootStyles.unknownStylePageMsg,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPALLootApparelWeaponsSubmenuTable()
    PALLootApparelWeaponsSubmenuTable:insert({
        type = "description",
        text = GetString(SI_PA_DISPLAY_A_MESSAGE_WHEN),
        disabled = PALMenuFunctions.isLootApparelWeaponsMenuDisabled,
    })

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

local function _createPALMarkRecipesSubmenuTable()
    PALMarkRecipesSubmenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MARK_WITH),
        disabled = PALMenuFunctions.isMarkRecipesMenuDisabled,
    })

    PALMarkRecipesSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_ICONS_RECIPE_SHOW_UNKNOWN),
        getFunc = PALMenuFunctions.getMarkUnknownRecipesSetting,
        setFunc = PALMenuFunctions.setMarkUnknownRecipesSetting,
        disabled = PALMenuFunctions.isMarkUnknownRecipesDisabled,
        default = PALMenuDefaults.ItemIcons.Recipes.showUnknownIcon,
    })

    PALMarkRecipesSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_ICONS_RECIPE_SHOW_KNOWN),
        getFunc = PALMenuFunctions.getMarkKnownRecipesSetting,
        setFunc = PALMenuFunctions.setMarkKnownRecipesSetting,
        disabled = PALMenuFunctions.isMarkKnownRecipesDisabled,
        default = PALMenuDefaults.ItemIcons.Recipes.showKnownIcon,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPALMarkMotifsSubmenuTable()
    PALMarkMotifsSubmenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MARK_WITH),
        disabled = PALMenuFunctions.isMarkMotifsMenuDisabled,
    })

    PALMarkMotifsSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_ICONS_MOTIFS_SHOW_UNKNOWN),
        getFunc = PALMenuFunctions.getMarkUnknownMotifsSetting,
        setFunc = PALMenuFunctions.setMarkUnknownMotifsSetting,
        disabled = PALMenuFunctions.isMarkUnknownMotifsDisabled,
        default = PALMenuDefaults.ItemIcons.Motifs.showUnknownIcon,
    })

    PALMarkMotifsSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_ICONS_MOTIFS_SHOW_KNOWN),
        getFunc = PALMenuFunctions.getMarkKnownMotifsSetting,
        setFunc = PALMenuFunctions.setMarkKnownMotifsSetting,
        disabled = PALMenuFunctions.isMarkKnownMotifsDisabled,
        default = PALMenuDefaults.ItemIcons.Motifs.showKnownIcon,
    })

    PALMarkMotifsSubmenuTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PALMarkMotifsSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_ICONS_STYLEPAGES_SHOW_UNKNOWN),
        getFunc = PALMenuFunctions.getMarkUnknownStylePageContainersSetting,
        setFunc = PALMenuFunctions.setMarkUnknownStylePageContainersSetting,
        disabled = PALMenuFunctions.isMarkUnknownStylePageContainersDisabled,
        default = PALMenuDefaults.ItemIcons.StylePageContainers.showUnknownIcon,
    })

    PALMarkMotifsSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_ICONS_STYLEPAGES_SHOW_KNOWN),
        getFunc = PALMenuFunctions.getMarkKnownStylePageContainersSetting,
        setFunc = PALMenuFunctions.setMarkKnownStylePageContainersSetting,
        disabled = PALMenuFunctions.isMarkKnownStylePageContainersDisabled,
        default = PALMenuDefaults.ItemIcons.StylePageContainers.showKnownIcon,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPALMarkApparelWeaponsSubmenuTable()
    PALMarkApparelWeaponsSubmenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MARK_WITH),
        disabled = PALMenuFunctions.isMarkApparelWeaponsMenuDisabled,
    })

    PALMarkApparelWeaponsSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SHOW_UNKNOWN),
        getFunc = PALMenuFunctions.getMarkUnknownApparelWeaponsSetting,
        setFunc = PALMenuFunctions.setMarkUnknownApparelWeaponsSetting,
        disabled = PALMenuFunctions.isMarkUnknownApparelWeaponsDisabled,
        default = PALMenuDefaults.ItemIcons.ApparelWeapons.showUnknownIcon,
    })

    PALMarkApparelWeaponsSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SHOW_KNOWN),
        getFunc = PALMenuFunctions.getMarkKnownApparelWeaponsSetting,
        setFunc = PALMenuFunctions.setMarkKnownApparelWeaponsSetting,
        disabled = PALMenuFunctions.isMarkKnownApparelWeaponsDisabled,
        default = PALMenuDefaults.ItemIcons.ApparelWeapons.showKnownIcon,
    })
end

-- =================================================================================================================

local function createOptions()
    _createPALootMenu()

    _createPALootProfileSubMenuTable()

    _createPALLootRecipesSubmenuTable()
    _createPALLootStylesSubmenuTable()
    _createPALLootApparelWeaponsSubmenuTable()

    _createPALMarkRecipesSubmenuTable()
    _createPALMarkMotifsSubmenuTable()
    _createPALMarkApparelWeaponsSubmenuTable()

    PA.LAM2:RegisterAddonPanel("PersonalAssistantLootAddonOptions", PALootPanelData)
    PA.LAM2:RegisterOptionControls("PersonalAssistantLootAddonOptions", PALootOptionsTable)
end

-- =====================================================================================================================
-- Export
PA.Loot = PA.Loot or {}
PA.Loot.createOptions = createOptions
