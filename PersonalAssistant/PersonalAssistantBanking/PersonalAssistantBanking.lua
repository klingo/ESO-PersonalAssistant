-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACAddon = PAC.ADDON
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

-- Local constants --
local AddonName = "PersonalAssistantBanking"

-- ---------------------------------------------------------------------------------------------------------------------

-- only prints out PABanking texts if silentMode is disabled
local function println(text, ...)
    if not PA.Banking.SavedVars.silentMode then
        PAHF.println(PA.Banking.chat, PAC.COLORED_TEXTS.PAB, text, ...)
    end
end

-- wrapper method that prefixes the addon shortname
local function debugln(text, ...)
    PAHF.debugln(PAC.COLORED_TEXTS_DEBUG.PAB, text, ...)
end

-- init saved variables and register Addon
local function initAddon(_, addOnName)
    if addOnName ~= AddonName then
        return
    end

    -- addon load started - unregister event
    PAEM.UnregisterForEvent(AddonName, EVENT_ADD_ON_LOADED)

    -- init LibChatMessage if running
    if PA.LibChatMessage then
        PA.Banking.chat = PA.LibChatMessage(PAC.COLORED_TEXTS.PAB, PAC.COLORED_TEXTS_DEBUG.PAB)
    end

    -- gets values from SavedVars, or initialises with default values
    PA.SavedVars.Banking = ZO_SavedVars:NewAccountWide("PersonalAssistantBanking_SavedVariables", PAC.ADDON.SAVED_VARS_VERSION.MAJOR.BANKING)

    -- sync profiles between PAGeneral and PABanking
    PAHF.syncLocalProfilesWithGlobal(PA.SavedVars.Banking, PA.MenuDefaults.PABanking)

    -- create the options with LAM-2
    PA.Banking.createOptions()

    -- Then fire the callback to initially set up the PABankingRules for the current profile
    PAEM.FireCallbacks("PersonalAssistant", EVENT_ADD_ON_LOADED, "InitPABankingRulesList")
end

PAEM.RegisterForEvent(AddonName, EVENT_ADD_ON_LOADED, initAddon)

-- ---------------------------------------------------------------------------------------------------------------------

-- Export
PA.Banking = {
    AddonName = AddonName,
    println = println,
    debugln = debugln
}