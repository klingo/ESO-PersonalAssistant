-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions
local PABProfileManager = PA.ProfileManager.PABanking

-- =====================================================================================================================

-- Local constants --
local AddonName = "PersonalAssistantBanking"
PA.Banking = PA.Banking or {}
PA.Banking.selectedCopyProfile = nil -- init with nil, is populated when selected from dropdown
PA.Banking.selectedDeleteProfile = nil -- init with nil, is populated when selected from dropdown

-- ---------------------------------------------------------------------------------------------------------------------

-- only prints out PABanking texts if silentMode is disabled
local function println(text, ...)
    if not PA.Banking.SavedVars.silentMode then
        PAHF.println(PA.Banking.chat, PAC.COLORED_TEXTS.PAB, text, ...)
    end
end

-- wrapper method that prefixes the addon shortname
local function debugln(text, ...)
    PAHF.debugln(PAC.ADDON.NAME_RAW.BANKING, PAC.COLORED_TEXTS_DEBUG.PAB, text, ...)
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
    local PASavedVars = PA.SavedVars
    PASavedVars.Banking = ZO_SavedVars:NewAccountWide("PersonalAssistantBanking_SavedVariables", PAC.ADDON.SAVED_VARS_VERSION.MAJOR.BANKING)

    -- apply any patches if needed
    PA.SavedVarsPatcher.applyPABankingPatchIfNeeded()

    -- init a default profile if none exist
    PABProfileManager.initDefaultProfile()

    -- fix the active profile in case an invalid one is selected (because it was deleted from another character)
    PABProfileManager.fixActiveProfile()

    -- get the active Profile
    local activeProfile = PABProfileManager.getActiveProfile()
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        -- TODO: show message that no profile is selected?
    else
        -- a valid profile is selected and thus SavedVars for that profile can be pre-loaded
        PAEM.RefreshSavedVarReference.PABanking()
        -- then also all the events can be initialised
        PAEM.RefreshEventRegistration.PABanking()
    end

    -- create the options with LAM-2
    PA.Banking.createOptions()

    -- Then fire the callback to initially set up the PABankingRules for the current profile
    PAEM.FireCallbacks("PersonalAssistant", EVENT_ADD_ON_LOADED, "InitPABankingRulesList")
end

PAEM.RegisterForEvent(AddonName, EVENT_ADD_ON_LOADED, initAddon)

-- =====================================================================================================================
-- Export
PA.Banking.AddonName = AddonName
PA.Banking.println = println
PA.Banking.debugln = debugln