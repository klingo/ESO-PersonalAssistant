-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAMenuFunctions = PA.MenuFunctions
local PAMenuDefaults = PA.MenuDefaults

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
        getFunc = PAMenuFunctions.PAMail.getHirelingAutoMailEnabledSetting,
        setFunc = PAMenuFunctions.PAMail.setHirelingAutoMailEnabledSetting,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PAMail.hirelingAutoMailEnabled,
    })

    PAMailOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_MAIL_HIRELING_DELETE_EMPTYMAILS),
        tooltip = GetString(SI_PA_MENU_MAIL_HIRELING_DELETE_EMPTYMAILS_T),
        getFunc = PAMenuFunctions.PAMail.getHirelingDeleteEmptyMailsSetting,
        setFunc = PAMenuFunctions.PAMail.setHirelingDeleteEmptyMailsSetting,
        disabled = PAMenuFunctions.PAMail.isHirelingDeleteEmptyMailsDisabled,
        default = PAMenuDefaults.PAMail.hirelingDeleteEmptyMails,
    })

    PAMailOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_SILENT_MODE),
        tooltip = GetString(SI_PA_MENU_SILENT_MODE_T),
        getFunc = PAMenuFunctions.PAMail.getSilentModeSetting,
        setFunc = PAMenuFunctions.PAMail.setSilentModeSetting,
        disabled = PAMenuFunctions.PAMail.isSilentModeDisabled,
        default = PAMenuDefaults.PAMail.silentMode,
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
