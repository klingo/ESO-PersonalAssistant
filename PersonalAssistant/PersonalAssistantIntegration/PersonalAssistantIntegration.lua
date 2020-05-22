-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACAddon = PAC.ADDON
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

-- Local constants --
local AddonName = "PersonalAssistantIntegration"
local Integration_Defaults = {}

-- ---------------------------------------------------------------------------------------------------------------------

-- only prints out PAIntegration texts if silentMode is disabled
local function println(text, ...)
    if not PA.Integration.SavedVars.silentMode then
        PAHF.println(PA.Integration.chat, PAC.COLORED_TEXTS.PAI, text, ...)
    end
end

-- wrapper method that prefixes the addon shortname
local function debugln(text, ...)
    local addonText = table.concat({PAC.COLORED_TEXTS_DEBUG.PAI, ": ", text})
    PAHF.debugln(addonText, ...)
end

-- init default values
local function initDefaults()
    local PAMenuDefaults = PA.MenuDefaults
    -- default values for PABanking
    Integration_Defaults.savedVarsVersion = PACAddon.SAVED_VARS_VERSION.MINOR
    for profileNo = 1, PAC.GENERAL.MAX_PROFILES do
        -- get default values from PAMenuDefaults
        Integration_Defaults[profileNo] = PAMenuDefaults.PAIntegration
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

    -- init LibChatMessage if running
    if PA.LibChatMessage then
        PA.Integration.chat = PA.LibChatMessage(PAC.COLORED_TEXTS.PAI, PAC.COLORED_TEXTS_DEBUG.PAI)
    end

    -- gets values from SavedVars, or initialises with default values
    PA.SavedVars.Integration = ZO_SavedVars:NewAccountWide("PersonalAssistantIntegration_SavedVariables", PAC.ADDON.SAVED_VARS_VERSION.MAJOR.INTEGRATION, nil, Integration_Defaults)

    -- create the options with LAM-2
    PA.Integration.createOptions()
end

PAEM.RegisterForEvent(AddonName, EVENT_ADD_ON_LOADED, initAddon)

-- ---------------------------------------------------------------------------------------------------------------------

-- Export
PA.Integration = {
    AddonName = AddonName,
    println = println,
    debugln = debugln
}