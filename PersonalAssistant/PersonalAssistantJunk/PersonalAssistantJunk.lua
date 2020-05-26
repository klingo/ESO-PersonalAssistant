-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACAddon = PAC.ADDON
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

-- Local constants --
local AddonName = "PersonalAssistantJunk"
local Junk_Defaults = {}

-- ---------------------------------------------------------------------------------------------------------------------

-- only prints out PAJunk texts if silentMode is disabled
local function println(text, ...)
    if not PA.Junk.SavedVars.silentMode then
        PAHF.println(PA.Junk.chat, PAC.COLORED_TEXTS.PAJ, text, ...)
    end
end

-- wrapper method that prefixes the addon shortname
local function debugln(text, ...)
    PAHF.debugln(PAC.COLORED_TEXTS_DEBUG.PAJ, text, ...)
end

-- init default values
local function initDefaults()
    -- GLOBAL default values for PAJunk
    Junk_Defaults.savedVarsVersion = PACAddon.SAVED_VARS_VERSION.MINOR
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
        PA.Junk.chat = PA.LibChatMessage(PAC.COLORED_TEXTS.PAJ, PAC.COLORED_TEXTS_DEBUG.PAJ)
    end

    -- gets values from SavedVars, or initialises with default values
    PA.SavedVars.Junk = ZO_SavedVars:NewAccountWide("PersonalAssistantJunk_SavedVariables", PAC.ADDON.SAVED_VARS_VERSION.MAJOR.JUNK, nil, Junk_Defaults)

    -- sync profiles between PAGeneral and PAJunk
    PAHF.syncLocalProfilesWithGlobal(PA.SavedVars.Junk, PA.MenuDefaults.PAJunk)

    -- create the options with LAM-2
    PA.Junk.createOptions()

    -- Then fire the callback to initially set up the PABankingRules for the current profile
    PAEM.FireCallbacks("PersonalAssistant", EVENT_ADD_ON_LOADED, "InitPAJunkRulesList")
end

PAEM.RegisterForEvent(AddonName, EVENT_ADD_ON_LOADED, initAddon)

-- ---------------------------------------------------------------------------------------------------------------------

-- Export
PA.Junk = {
    AddonName = AddonName,
    println = println,
    debugln = debugln
}