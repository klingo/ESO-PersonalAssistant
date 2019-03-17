-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAMenuHelper = PA.MenuHelper
local PAMenuFunctions = PA.MenuFunctions
local PAMenuDefaults = PA.MenuDefaults

local LAM2 = LibStub("LibAddonMenu-2.0")

local PAGeneralPanelData = {
    type = "panel",
    name = "PersonalAssistant",
    displayName = GetString(SI_PA_MENU_TITLE),
    author = "Klingo",
    version = PAC.ADDON_VERSION,
    website = "http://www.esoui.com/downloads/info381-PersonalAssistant",
    slashCommand = "/pa",
    registerForRefresh = true,
    registerForDefaults = true,
}

local PAGeneralOptionsTable = setmetatable({}, { __index = table })

-- ---------------------------------------------------------------------------------------------------------------------

local function createPAGeneralMenu()
    PAGeneralOptionsTable:insert({
        type = "header",
        name = GetString(SI_PA_MENU_GENERAL_HEADER)
    })

    PAGeneralOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_GENERAL_DESCRIPTION),
    })

    PAGeneralOptionsTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_GENERAL_ACTIVE_PROFILE),
        tooltip = GetString(SI_PA_MENU_GENERAL_ACTIVE_PROFILE_T),
        choices = PAMenuHelper.getProfileList(),
        choicesValues = PAMenuHelper.getProfileListValues(),
        width = "half",
        getFunc = PAMenuFunctions.PAGeneral.getActiveProfile,
        setFunc = PAMenuFunctions.PAGeneral.setActiveProfile,
        reference = "PERSONALASSISTANT_PROFILEDROPDOWN",
    })

    PAGeneralOptionsTable:insert({
        type = "editbox",
        name = GetString(SI_PA_MENU_GENERAL_ACTIVE_PROFILE_RENAME),
        tooltip = GetString(SI_PA_MENU_GENERAL_ACTIVE_PROFILE_RENAME_T),
        width = "half",
        getFunc = PAMenuFunctions.PAGeneral.getActiveProfileRename,
        setFunc = PAMenuFunctions.PAGeneral.setActiveProfileRename,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
    })

    PAGeneralOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_GENERAL_SHOW_WELCOME),
        tooltip = GetString(SI_PA_MENU_GENERAL_SHOW_WELCOME_T),
        getFunc = PAMenuFunctions.PAGeneral.getWelcomeMessageSetting,
        setFunc = PAMenuFunctions.PAGeneral.setWelcomeMessageSetting,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PAGeneral.welcomeMessage,
    })
end

-- =================================================================================================================

local function createOptions()
    -- Create and register the General Menu
    createPAGeneralMenu()
    LAM2:RegisterAddonPanel("PersonalAssistantAddonOptions", PAGeneralPanelData)
    LAM2:RegisterOptionControls("PersonalAssistantAddonOptions", PAGeneralOptionsTable)
end

-- Export
PA.MainMenu = {
    createOptions = createOptions
}
