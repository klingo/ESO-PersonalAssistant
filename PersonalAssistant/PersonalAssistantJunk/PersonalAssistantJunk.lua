-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions
local PAJProfileManager = PA.ProfileManager.PAJunk

-- =====================================================================================================================

-- Local constants --
local AddonName = "PersonalAssistantJunk"
PA.Junk = PA.Junk or {}
PA.Junk.selectedCopyProfile = nil -- init with nil, is populated when selected from dropdown
PA.Junk.selectedDeleteProfile = nil -- init with nil, is populated when selected from dropdown

-- ---------------------------------------------------------------------------------------------------------------------

-- only prints out PAJunk texts if silentMode is disabled
local function println(text, ...)
    if not PA.Junk.SavedVars.silentMode then
        PAHF.println(PA.Junk.chat, PAC.COLORED_TEXTS.PAJ, text, ...)
    end
end

-- wrapper method that prefixes the addon shortname
local function debugln(text, ...)
    PAHF.debugln(PAC.ADDON.NAME_RAW.JUNK, PAC.COLORED_TEXTS_DEBUG.PAJ, text, ...)
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
        PA.Junk.chat = PA.LibChatMessage(PAC.COLORED_TEXTS.PAJ, PAC.COLORED_TEXTS_DEBUG.PAJ)
    end

    -- gets values from SavedVars, or initialises with default values
    local PASavedVars = PA.SavedVars
    PASavedVars.Junk = ZO_SavedVars:NewAccountWide("PersonalAssistantJunk_SavedVariables", PAC.ADDON.SAVED_VARS_VERSION.MAJOR.JUNK)

    -- apply any patches if needed
    PA.SavedVarsPatcher.applyPAJunkPatchIfNeeded()

    -- init a default profile if none exist
    PAJProfileManager.initDefaultProfile()

    -- fix the active profile in case an invalid one is selected (because it was deleted from another character)
    PAJProfileManager.fixActiveProfile()

    -- get the active Profile
    local activeProfile = PAJProfileManager.getActiveProfile()
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        -- TODO: show message that no profile is selected?
    else
        -- a valid profile is selected and thus SavedVars for that profile can be pre-loaded
        PAEM.RefreshSavedVarReference.PAJunk()
        -- then also all the events can be initialised
        PAEM.RefreshEventRegistration.PAJunk()
    end

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