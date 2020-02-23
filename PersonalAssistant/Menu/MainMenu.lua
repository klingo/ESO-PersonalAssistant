-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACAddon = PAC.ADDON
local PAMenuHelper = PA.MenuHelper
local PAGMenuFunctions = PA.MenuFunctions.PAGeneral
local PAGMenuDefaults = PA.MenuDefaults.PAGeneral

-- Create the LibAddonMenu2 object
PA.LAM2 = PA.LAM2 or LibAddonMenu2 or LibStub("LibAddonMenu-2.0")

local PAGeneralPanelData = {
    type = "panel",
    name = PACAddon.NAME_RAW.GENERAL,
    displayName = PACAddon.NAME_DISPLAY.GENERAL,
    author = PACAddon.AUTHOR,
    version = PACAddon.VERSION_DISPLAY,
    website = PACAddon.WEBSITE,
    feedback = PACAddon.FEEDBACK,
    keywords = PACAddon.KEYWORDS.GENERAL,
    slashCommand = "/pa",
    registerForRefresh = true,
    registerForDefaults = true,
}

local PAGeneralOptionsTable = setmetatable({}, { __index = table })

-- ---------------------------------------------------------------------------------------------------------------------

local function createPAGeneralMenu()
    PAGeneralOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_GENERAL_DESCRIPTION),
    })

    PAGeneralOptionsTable:insert({
        type = "header",
        name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_PROFILE_HEADER))
    })

    PAGeneralOptionsTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_PROFILE_ACTIVE),
        tooltip = GetString(SI_PA_MENU_PROFILE_ACTIVE_T),
        choices = PAMenuHelper.getProfileList(),
        choicesValues = PAMenuHelper.getProfileListValues(),
        width = "half",
        getFunc = PAGMenuFunctions.getActiveProfile,
        setFunc = PAGMenuFunctions.setActiveProfile,
        reference = "PERSONALASSISTANT_PROFILEDROPDOWN",
    })

    PAGeneralOptionsTable:insert({
        type = "editbox",
        name = GetString(SI_PA_MENU_PROFILE_ACTIVE_RENAME),
        width = "half",
        getFunc = PAGMenuFunctions.getActiveProfileRename,
        setFunc = PAGMenuFunctions.setActiveProfileRename,
        disabled = PAGMenuFunctions.isNoProfileSelected,
    })

    PAGeneralOptionsTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_PROFILE_CREATE_NEW),
        width = "half",
        func = PAGMenuFunctions.createNewProfile,
        disabled = PAGMenuFunctions.hasMaxProfileCountReached
    })

    PAGeneralOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_PROFILE_CREATE_NEW_DESC),
        disabled = function() return not PAGMenuFunctions.hasMaxProfileCountReached() end
    })

    PAGeneralOptionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PAGeneralOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_PROFILE_COPY_FROM_DESC),
        disabled = function() return PAGMenuFunctions.hasOnlyOneProfile() or PAGMenuFunctions.isNoProfileSelected() end,
    })

    PAGeneralOptionsTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_PROFILE_COPY_FROM),
        choices = PAMenuHelper.getInactiveProfileList(),
        choicesValues = PAMenuHelper.getInactiveProfileListValues(),
        width = "half",
        getFunc = function() return PA.selectedCopyProfile end,
        setFunc = function(value) PA.selectedCopyProfile = value end,
        disabled = function() return PAGMenuFunctions.hasOnlyOneProfile() or PAGMenuFunctions.isNoProfileSelected() end,
        reference = "PERSONALASSISTANT_PROFILEDROPDOWN_COPY",
    })

    PAGeneralOptionsTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM),
        width = "half",
        func = PAGMenuFunctions.copySelectedProfile,
        isDangerous = true,
        warning = GetString(SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM_W),
        disabled = PAGMenuFunctions.isNoCopyProfileSelected,
    })

    PAGeneralOptionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PAGeneralOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_PROFILE_DELETE_DESC),
        disabled = PAGMenuFunctions.hasOnlyOneProfile,
    })

    PAGeneralOptionsTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_PROFILE_DELETE),
        choices = PAMenuHelper.getInactiveProfileList(),
        choicesValues = PAMenuHelper.getInactiveProfileListValues(),
        width = "half",
        getFunc = function() return PA.selectedDeleteProfile end,
        setFunc = function(value) PA.selectedDeleteProfile = value end,
        disabled = PAGMenuFunctions.hasOnlyOneProfile,
        reference = "PERSONALASSISTANT_PROFILEDROPDOWN_DELETE",
    })

    PAGeneralOptionsTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_PROFILE_DELETE_CONFIRM),
        width = "half",
        func = PAGMenuFunctions.deleteSelectedProfile,
        isDangerous = true,
        warning = GetString(SI_PA_MENU_PROFILE_DELETE_CONFIRM_W),
        disabled = PAGMenuFunctions.isNoDeleteProfileSelected,
    })

    PAGeneralOptionsTable:insert({
        type = "header",
        name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_OTHER_SETTINGS_HEADER))
    })

    PAGeneralOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_GENERAL_SHOW_WELCOME),
        getFunc = PAGMenuFunctions.getWelcomeMessageSetting,
        setFunc = PAGMenuFunctions.setWelcomeMessageSetting,
        disabled = PAGMenuFunctions.isNoProfileSelected,
        default = PAGMenuDefaults.welcomeMessage,
    })

    local houseId = GetHousingPrimaryHouse()
    if houseId then
        PAGeneralOptionsTable:insert({
            type = "button",
            name = GetString(SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE),
            width = "half",
            func = PAGMenuFunctions.teleportToPrimaryHouse,
            disabled = PAGMenuFunctions.isTeleportToPrimaryHouseDisabled,
            isDangerous = true,
            warning = GetString(SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE_W),
        })
    end

    -- register additional buttons to switch between languages (only for Addon author)
    if GetUnitName("player") == PACAddon.AUTHOR then
        PAGeneralOptionsTable:insert({
            type = "button",
            name = "English",
            func = function() SetCVar("language.2", "en") end,
            isDangerous = true,
            warning = "The Game language will be changed to English!",
        })

        PAGeneralOptionsTable:insert({
            type = "button",
            name = "German",
            func = function() SetCVar("language.2", "de") end,
            isDangerous = true,
            warning = "The Game language will be changed to German!",
        })

        PAGeneralOptionsTable:insert({
            type = "button",
            name = "French",
            func = function() SetCVar("language.2", "fr") end,
            isDangerous = true,
            warning = "The Game language will be changed to French!",
        })

        PAGeneralOptionsTable:insert({
            type = "button",
            name = "Russian",
            func = function() SetCVar("language.2", "ru") end,
            isDangerous = true,
            warning = "The Game language will be changed to Russian! (inofficial)",
        })
    end
end

-- =================================================================================================================

local function createOptions()
    -- first check for the latest version of the LAM2-submenu widget that is needed for disabledLabel
    local lamSubmenuVersion = PA.LAM2.widgets.submenu or 0
    if lamSubmenuVersion < 13 then
        zo_callLater(function() PA.println(SI_PA_LAM_OUTDATED) end, 5000)
    end

    -- Create and register the General Menu
    createPAGeneralMenu()
    PA.LAM2:RegisterAddonPanel("PersonalAssistantAddonOptions", PAGeneralPanelData)
    PA.LAM2:RegisterOptionControls("PersonalAssistantAddonOptions", PAGeneralOptionsTable)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.General = PA.General or {}
PA.General.createOptions = createOptions
