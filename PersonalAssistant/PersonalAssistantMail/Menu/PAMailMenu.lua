-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAMMenuFunctions = PA.MenuFunctions.PAMail
local PAMMenuDefaults = PA.MenuDefaults.PAMail

local LAM2 = LibStub("LibAddonMenu-2.0")

local PAMailPanelData = {
    type = "panel",
    name = "PersonalAssistant Mail",
    displayName = GetString(SI_PA_MENU_TITLE),
    author = "Klingo",
    version = PAC.ADDON_VERSION,
    website = "http://www.esoui.com/downloads/info381-PersonalAssistant",
    slashCommand = "/pam",
    registerForRefresh = true,
    registerForDefaults = true,
}

local PAMailOptionsTable = setmetatable({}, { __index = table })

-- =================================================================================================================

local function _createPAMailMenu()
    PAMailOptionsTable:insert({
        type = "header",
        name = GetString(SI_PA_MENU_MAIL_HEADER)
    })

    PAMailOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_MAIL_DESCRIPTION),
    })

    PAMailOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_MAIL_HIRELING_AUTOMAIL_ENABLE),
        tooltip = GetString(SI_PA_MENU_MAIL_HIRELING_AUTOMAIL_ENABLE_T),
        getFunc = PAMMenuFunctions.getHirelingAutoMailEnabledSetting,
        setFunc = PAMMenuFunctions.setHirelingAutoMailEnabledSetting,
        disabled = PA.MenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMMenuDefaults.hirelingAutoMailEnabled,
    })

    PAMailOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_MAIL_HIRELING_DELETE_EMPTYMAILS),
        tooltip = GetString(SI_PA_MENU_MAIL_HIRELING_DELETE_EMPTYMAILS_T),
        getFunc = PAMMenuFunctions.getHirelingDeleteEmptyMailsSetting,
        setFunc = PAMMenuFunctions.setHirelingDeleteEmptyMailsSetting,
        disabled = PAMMenuFunctions.isHirelingDeleteEmptyMailsDisabled,
        default = PAMMenuDefaults.hirelingDeleteEmptyMails,
    })

    PAMailOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_SILENT_MODE),
        tooltip = GetString(SI_PA_MENU_SILENT_MODE_T),
        getFunc = PAMMenuFunctions.getSilentModeSetting,
        setFunc = PAMMenuFunctions.setSilentModeSetting,
        disabled = PAMMenuFunctions.isSilentModeDisabled,
        default = PAMMenuDefaults.silentMode,
    })
end

-- =================================================================================================================

local function createOptions()
    _createPAMailMenu()

    LAM2:RegisterAddonPanel("PersonalAssistantMailAddonOptions", PAMailPanelData)
    LAM2:RegisterOptionControls("PersonalAssistantMailAddonOptions", PAMailOptionsTable)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Mail = PA.Mail or {}
PA.Mail.createOptions = createOptions
