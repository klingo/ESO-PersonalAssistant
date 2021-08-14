-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions
local PALProfileManager = PA.ProfileManager.PALoot

-- =====================================================================================================================

-- Local constants --
local AddonName = "PersonalAssistantLoot"
PA.Loot = PA.Loot or {}
PA.Loot.selectedCopyProfile = nil -- init with nil, is populated when selected from dropdown
PA.Loot.selectedDeleteProfile = nil -- init with nil, is populated when selected from dropdown

-- ---------------------------------------------------------------------------------------------------------------------

-- only prints out PALoot texts if silentMode is disabled
local function println(text, ...)
    if not PA.Loot.SavedVars.silentMode then
        PAHF.println(PA.Loot.chat, PAC.COLORED_TEXTS.PAL, text, ...)
    end
end

-- wrapper method that prefixes the addon shortname
local function debugln(text, ...)
    PAHF.debugln(PAC.ADDON.NAME_RAW.LOOT, PAC.COLORED_TEXTS_DEBUG.PAL, text, ...)
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
        PA.Loot.chat = PA.LibChatMessage(PAC.COLORED_TEXTS.PAL, PAC.COLORED_TEXTS_DEBUG.PAL)
    end

    -- gets values from SavedVars, or initialises with default values
    local PASavedVars = PA.SavedVars
    PASavedVars.Loot = ZO_SavedVars:NewAccountWide("PersonalAssistantLoot_SavedVariables", PAC.ADDON.SAVED_VARS_VERSION.MAJOR.LOOT)

    -- apply any patches if needed
    PA.SavedVarsPatcher.applyPALootPatchIfNeeded()

    -- init a default profile if none exist
    PALProfileManager.initDefaultProfile()

    -- fix the active profile in case an invalid one is selected (because it was deleted from another character)
    PALProfileManager.fixActiveProfile()

    -- get the active Profile
    local activeProfile = PALProfileManager.getActiveProfile()
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        -- TODO: show message that no profile is selected?
    else
        -- a valid profile is selected and thus SavedVars for that profile can be pre-loaded
        PAEM.RefreshSavedVarReference.PALoot()
        -- then also all the events can be initialised
        PAEM.RefreshEventRegistration.PALoot()
    end

    -- create the options with LAM-2
    PA.Loot.createOptions()
end

PAEM.RegisterForEvent(AddonName, EVENT_ADD_ON_LOADED, initAddon)

-- =====================================================================================================================
-- Export
PA.Loot.AddonName = AddonName
PA.Loot.println = println
PA.Loot.debugln = debugln