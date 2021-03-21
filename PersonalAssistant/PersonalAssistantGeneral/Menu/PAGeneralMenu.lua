-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACAddon = PAC.ADDON
local PAGMenuFunctions = PA.MenuFunctions.PAGeneral
local PAGProfileManager = PA.ProfileManager.PAGeneral
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
local PAGeneralProfileSubMenuTable = setmetatable({}, { __index = table })

-- ---------------------------------------------------------------------------------------------------------------------

local function _createPAGeneralMenu()
    PAGeneralOptionsTable:insert({
        type = "submenu",
        name = PAGProfileManager.getProfileSubMenuHeader,
        controls = PAGeneralProfileSubMenuTable
    })

    PAGeneralOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_GENERAL_DESCRIPTION),
    })

    PAGeneralOptionsTable:insert({
        type = "header",
        name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_GENERAL_HEADER))
    })

    PAGeneralOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_GENERAL_SHOW_WELCOME),
        getFunc = PAGMenuFunctions.getWelcomeMessageSetting,
        setFunc = PAGMenuFunctions.setWelcomeMessageSetting,
        disabled = PAGProfileManager.isNoProfileSelected,
        default = PAGMenuDefaults.welcomeMessage,
    })

    -- TODO: new "Fast Travel" header

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

        PAGeneralOptionsTable:insert({
             type = "checkbox",
             name = GetString(SI_PA_MENU_GENERAL_TELEPORT_OUTSIDE),
             tooltip = GetString(SI_PA_MENU_GENERAL_TELEPORT_OUTSIDE_T),
             width = "half",
             getFunc = PAGMenuFunctions.getJumpOutsideSetting,
             setFunc = PAGMenuFunctions.setJumpOutsideSetting,
             disabled = PAGMenuFunctions.isTeleportToPrimaryHouseDisabled,
             default = PAGMenuDefaults.jumpOutside,
        })
    end

    -- register additional buttons to switch between languages (only for Addon author)
    if GetUnitName("player") == PACAddon.AUTHOR then
        PAGeneralOptionsTable:insert({
            type = "header",
            name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_ADMIN_HEADER))
        })

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

-- ---------------------------------------------------------------------------------------------------------------------

local function _createPAGeneralProfileSubMenu()
    PAGeneralProfileSubMenuTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_PROFILE_ACTIVE),
        tooltip = GetString(SI_PA_MENU_PROFILE_ACTIVE_T),
        choices = PAGProfileManager.getProfileList(),
        choicesValues = PAGProfileManager.getProfileListValues(),
        width = "half",
        getFunc = PAGProfileManager.getActiveProfile,
        setFunc = PAGProfileManager.setActiveProfile,
        reference = "PERSONALASSISTANT_GENERAL_PROFILEDROPDOWN"
    })

    PAGeneralProfileSubMenuTable:insert({
        type = "editbox",
        name = GetString(SI_PA_MENU_PROFILE_ACTIVE_RENAME),
        width = "half",
        getFunc = PAGProfileManager.getActiveProfileName,
        setFunc = PAGProfileManager.setActiveProfileName,
        disabled = PAGProfileManager.isNoProfileSelected
    })

    PAGeneralProfileSubMenuTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_PROFILE_CREATE_NEW),
        width = "half",
        func = PAGProfileManager.createNewProfile,
        disabled = PAGProfileManager.hasMaxProfileCountReached
    })

    PAGeneralProfileSubMenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_PROFILE_CREATE_NEW_DESC),
        disabled = PAGProfileManager.hasMaxProfileCountReached
    })

    PAGeneralProfileSubMenuTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PAGeneralProfileSubMenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_PROFILE_COPY_FROM_DESC),
        disabled = function() return PAGProfileManager.hasOnlyOneProfile() or PAGProfileManager.isNoProfileSelected() end,
    })

    PAGeneralProfileSubMenuTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_PROFILE_COPY_FROM),
        choices = PAGProfileManager.getInactiveProfileList(),
        choicesValues = PAGProfileManager.getInactiveProfileListValues(),
        width = "half",
        getFunc = function() return PA.General.selectedCopyProfile end,
        setFunc = function(value) PA.General.selectedCopyProfile = value end,
        disabled = function() return PAGProfileManager.hasOnlyOneProfile() or PAGProfileManager.isNoProfileSelected() end,
        reference = "PERSONALASSISTANT_GENERAL_PROFILEDROPDOWN_COPY"
    })

    PAGeneralProfileSubMenuTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM),
        width = "half",
        func = PAGProfileManager.copySelectedProfile,
        isDangerous = true,
        warning = GetString(SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM_W),
        disabled = PAGProfileManager.isNoCopyProfileSelected
    })

    PAGeneralProfileSubMenuTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PAGeneralProfileSubMenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_PROFILE_DELETE_DESC),
        disabled = PAGProfileManager.hasOnlyOneProfile
    })

    PAGeneralProfileSubMenuTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_PROFILE_DELETE),
        choices = PAGProfileManager.getInactiveProfileList(),
        choicesValues = PAGProfileManager.getInactiveProfileListValues(),
        width = "half",
        getFunc = function() return PA.General.selectedDeleteProfile end,
        setFunc = function(value) PA.General.selectedDeleteProfile = value end,
        disabled = PAGProfileManager.hasOnlyOneProfile,
        reference = "PERSONALASSISTANT_GENERAL_PROFILEDROPDOWN_DELETE"
    })

    PAGeneralProfileSubMenuTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_PROFILE_DELETE_CONFIRM),
        width = "half",
        func = PAGProfileManager.deleteSelectedProfile,
        isDangerous = true,
        warning = GetString(SI_PA_MENU_PROFILE_DELETE_CONFIRM_W),
        disabled = PAGProfileManager.isNoDeleteProfileSelected
    })
end

-- =================================================================================================================

local function createOptions()
    _createPAGeneralMenu()

    _createPAGeneralProfileSubMenu()

    PA.LAM2:RegisterAddonPanel("PersonalAssistantGeneralAddonOptions", PAGeneralPanelData)
    PA.LAM2:RegisterOptionControls("PersonalAssistantGeneralAddonOptions", PAGeneralOptionsTable)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.General = PA.General or {}
PA.General.createOptions = createOptions
