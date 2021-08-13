-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions
local PAIProfileManager = PA.ProfileManager.PAIntegration

-- =====================================================================================================================

-- Local constants --
local AddonName = "PersonalAssistantIntegration"
PA.Integration = PA.Integration or {}
PA.Integration.selectedCopyProfile = nil -- init with nil, is populated when selected from dropdown
PA.Integration.selectedDeleteProfile = nil -- init with nil, is populated when selected from dropdown

-- ---------------------------------------------------------------------------------------------------------------------

-- only prints out PAIntegration texts if silentMode is disabled
local function println(text, ...)
    if not PA.Integration.SavedVars.silentMode then
        PAHF.println(PA.Integration.chat, PAC.COLORED_TEXTS.PAI, text, ...)
    end
end

-- wrapper method that prefixes the addon shortname
local function debugln(text, ...)
    PAHF.debugln(PAC.ADDON.NAME_RAW.INTEGRATION, PAC.COLORED_TEXTS_DEBUG.PAI, text, ...)
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
        PA.Integration.chat = PA.LibChatMessage(PAC.COLORED_TEXTS.PAI, PAC.COLORED_TEXTS_DEBUG.PAI)
    end

    -- gets values from SavedVars, or initialises with default values
    local PASavedVars = PA.SavedVars
    PASavedVars.Integration = ZO_SavedVars:NewAccountWide("PersonalAssistantIntegration_SavedVariables", PAC.ADDON.SAVED_VARS_VERSION.MAJOR.INTEGRATION)

    -- apply any patches if needed
    PA.SavedVarsPatcher.applyPAIntegrationPatchIfNeeded()

    -- init a default profile if none exist
    PAIProfileManager.initDefaultProfile()

    -- fix the active profile in case an invalid one is selected (because it was deleted from another character)
    PAIProfileManager.fixActiveProfile()

    -- get the active Profile
    local activeProfile = PAIProfileManager.getActiveProfile()
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        -- TODO: show message that no profile is selected?
    else
        -- a valid profile is selected and thus SavedVars for that profile can be pre-loaded
        PAEM.RefreshSavedVarReference.PAIntegration()
        -- then also all the events can be initialised
        PAEM.RefreshEventRegistration.PAIntegration()
    end

    -- create the options with LAM-2
    PA.Integration.createOptions()
end

PAEM.RegisterForEvent(AddonName, EVENT_ADD_ON_LOADED, initAddon)

-- =====================================================================================================================
-- Export
PA.Integration.AddonName = AddonName
PA.Integration.println = println
PA.Integration.debugln = debugln