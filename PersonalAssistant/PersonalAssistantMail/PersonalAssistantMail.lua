-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

-- Local constants --
local AddonName = "PersonalAssistantMail"
local Mail_Defaults = {}

-- ---------------------------------------------------------------------------------------------------------------------

-- only prints out PAMail texts if chatOutput is enabled
local function println(text, ...)
    if PA.Mail.SavedVars.chatOutput then
        PAHF.println(text, ...)
    end
end

-- init default values
local function initDefaults()
    local PAMenuDefaults = PA.MenuDefaults
    -- default values for PAMail
    for profileNo = 1, PAC.GENERAL.MAX_PROFILES do
        -- get default values from PAMenuDefaults
        Mail_Defaults[profileNo] = PAMenuDefaults.PAMail
    end
end

-- init saved variables and register Addon
local function initAddon(_, addOnName)
    if addOnName ~= AddonName then
        return
    end

    -- addon load started - unregister event
    PAEM.UnregisterForEvent(AddonName, EVENT_ADD_ON_LOADED)

    -- initialize the default values
    initDefaults()

    -- gets values from SavedVars, or initialises with default values
    PA.SavedVars.Mail = ZO_SavedVars:NewAccountWide("PersonalAssistantMail_SavedVariables", 1, nil, Mail_Defaults)

    -- create the options with LAM-2
    PA.Mail.createOptions()
end

PAEM.RegisterForEvent(AddonName, EVENT_ADD_ON_LOADED, initAddon)

-- ---------------------------------------------------------------------------------------------------------------------

-- Export
PA.Mail = {
    AddonName = AddonName,
    println = println
}