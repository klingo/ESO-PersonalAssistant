-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions
local PAWProfileManager = PA.ProfileManager.PAWorker

-- =====================================================================================================================

-- Local constants --
local AddonName = "PersonalAssistantWorker"
PA.Worker = PA.Worker or {}
PA.Worker.selectedCopyProfile = nil -- init with nil, is populated when selected from dropdown
PA.Worker.selectedDeleteProfile = nil -- init with nil, is populated when selected from dropdown

-- ---------------------------------------------------------------------------------------------------------------------

-- only prints out PAWorker texts if silentMode is disabled
local function println(text, ...)
    if not PA.Worker.SavedVars.silentMode then
        PAHF.println(PA.Worker.chat, PAC.COLORED_TEXTS.PAW, text, ...)
    end
end

-- wrapper method that prefixes the addon shortname
local function debugln(text, ...)
    PAHF.debugln(PAC.ADDON.NAME_RAW.Worker, PAC.COLORED_TEXTS_DEBUG.PAW, text, ...)
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
        PA.Worker.chat = PA.LibChatMessage(PAC.COLORED_TEXTS.PAW, PAC.COLORED_TEXTS_DEBUG.PAW)
    end

    -- gets values from SavedVars, or initialises with default values
    local PASavedVars = PA.SavedVars
    PASavedVars.Worker = ZO_SavedVars:NewAccountWide("PersonalAssistantWorker_SavedVariables", PAC.ADDON.SAVED_VARS_VERSION.MAJOR.WORKER)

    -- apply any patches if needed
    PA.SavedVarsPatcher.applyPAWorkerPatchIfNeeded()

    -- init a default profile if none exist
    PAWProfileManager.initDefaultProfile()

    -- fix the active profile in case an invalid one is selected (because it was deleted from another character)
    PAWProfileManager.fixActiveProfile()

    -- get the active Profile
    local activeProfile = PAWProfileManager.getActiveProfile()
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        -- TODO: show message that no profile is selected?
    else
        -- a valid profile is selected and thus SavedVars for that profile can be pre-loaded
        PAEM.RefreshSavedVarReference.PAWorker()
        -- then also all the events can be initialised
        PAEM.RefreshEventRegistration.PAWorker()
    end
	
    -- create the options with LAM-2
    PA.Worker.createOptions()
end

PAEM.RegisterForEvent(AddonName, EVENT_ADD_ON_LOADED, initAddon)


-- =====================================================================================================================
-- Export
PA.Worker.AddonName = AddonName
PA.Worker.println = println
PA.Worker.debugln = debugln