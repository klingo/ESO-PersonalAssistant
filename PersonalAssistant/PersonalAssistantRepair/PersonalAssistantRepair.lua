-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions
local PARProfileManager = PA.ProfileManager.PARepair

-- =====================================================================================================================

-- Local constants --
local AddonName = "PersonalAssistantRepair"
PA.Repair = PA.Repair or {}
PA.Repair.selectedCopyProfile = nil -- init with nil, is populated when selected from dropdown
PA.Repair.selectedDeleteProfile = nil -- init with nil, is populated when selected from dropdown

-- ---------------------------------------------------------------------------------------------------------------------

-- only prints out PARepair texts if silentMode is disabled
local function println(text, ...)
    if not PA.Repair.SavedVars.silentMode then
        PAHF.println(PA.Repair.chat, PAC.COLORED_TEXTS.PAR, text, ...)
    end
end

-- wrapper method that prefixes the addon shortname
local function debugln(text, ...)
    PAHF.debugln(PAC.ADDON.NAME_RAW.REPAIR, PAC.COLORED_TEXTS_DEBUG.PAR, text, ...)
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
        PA.Repair.chat = PA.LibChatMessage(PAC.COLORED_TEXTS.PAR, PAC.COLORED_TEXTS_DEBUG.PAR)
    end

    -- gets values from SavedVars, or initialises with default values
    local PASavedVars = PA.SavedVars
    PASavedVars.Repair = ZO_SavedVars:NewAccountWide("PersonalAssistantRepair_SavedVariables", PAC.ADDON.SAVED_VARS_VERSION.MAJOR.REPAIR)

    -- apply any patches if needed
    PA.SavedVarsPatcher.applyPARepairPatchIfNeeded()

    -- init a default profile if none exist
    PARProfileManager.initDefaultProfile()

    -- fix the active profile in case an invalid one is selected (because it was deleted from another character)
    PARProfileManager.fixActiveProfile()

    -- get the active Profile
    local activeProfile = PARProfileManager.getActiveProfile()
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        -- TODO: show message that no profile is selected?
    else
        -- a valid profile is selected and thus SavedVars for that profile can be pre-loaded
        PAEM.RefreshSavedVarReference.PARepair()
        -- then also all the events can be initialised
        PAEM.RefreshEventRegistration.PARepair()
    end

    -- create the options with LAM-2
    PA.Repair.createOptions()
end

PAEM.RegisterForEvent(AddonName, EVENT_ADD_ON_LOADED, initAddon)

-- =====================================================================================================================
-- Export
PA.Repair.AddonName = AddonName
PA.Repair.println = println
PA.Repair.debugln = debugln