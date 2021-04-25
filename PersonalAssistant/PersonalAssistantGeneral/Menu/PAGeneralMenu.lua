-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACAddon = PAC.ADDON
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

local function _createPAGeneralMenu()
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
        default = PAGMenuDefaults.welcomeMessage,
    })

    local houseId = GetHousingPrimaryHouse()
    if houseId then
        PAGeneralOptionsTable:insert({
            type = "header",
            name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_GENERAL_TELEPORT_HEADER)),
        })

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
            warning = "The Game language will be changed to Russian! (unofficial)",
        })
    end
end

-- =================================================================================================================

local function createOptions()
    _createPAGeneralMenu()

    PA.LAM2:RegisterAddonPanel("PersonalAssistantGeneralAddonOptions", PAGeneralPanelData)
    PA.LAM2:RegisterOptionControls("PersonalAssistantGeneralAddonOptions", PAGeneralOptionsTable)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.General = PA.General or {}
PA.General.createOptions = createOptions
