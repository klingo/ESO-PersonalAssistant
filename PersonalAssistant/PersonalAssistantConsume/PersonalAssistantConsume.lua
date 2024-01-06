-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions
local PACOProfileManager = PA.ProfileManager.PAConsume

-- =====================================================================================================================

-- Local constants --
local AddonName = "PersonalAssistantConsume"
PA.Consume = PA.Consume or {}
PA.Consume.selectedCopyProfile = nil -- init with nil, is populated when selected from dropdown
PA.Consume.selectedDeleteProfile = nil -- init with nil, is populated when selected from dropdown

-- ---------------------------------------------------------------------------------------------------------------------

-- only prints out PAConsume texts if silentMode is disabled
local function println(text, ...)
    if not PA.Consume.SavedVars.silentMode then
        PAHF.println(PA.Consume.chat, PAC.COLORED_TEXTS.PACO, text, ...)
    end
end

-- wrapper method that prefixes the addon shortname
local function debugln(text, ...)
    PAHF.debugln(PAC.ADDON.NAME_RAW.Consume, PAC.COLORED_TEXTS_DEBUG.PACO, text, ...)
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
        PA.Consume.chat = PA.LibChatMessage(PAC.COLORED_TEXTS.PACO, PAC.COLORED_TEXTS_DEBUG.PACO)
    end

    -- gets values from SavedVars, or initialises with default values
    local PASavedVars = PA.SavedVars
    PASavedVars.Consume = ZO_SavedVars:NewAccountWide("PersonalAssistantConsume_SavedVariables", PAC.ADDON.SAVED_VARS_VERSION.MAJOR.CONSUME)
	PASavedVars.ConsumeCharacter = ZO_SavedVars:NewCharacterIdSettings("PersonalAssistantConsume_SavedVariables", PAC.ADDON.SAVED_VARS_VERSION.MAJOR.CONSUME, nil, PA.MenuDefaults.PAConsumeCharacter)

    -- apply any patches if needed
    PA.SavedVarsPatcher.applyPAConsumePatchIfNeeded()

    -- init a default profile if none exist
    PACOProfileManager.initDefaultProfile()

    -- fix the active profile in case an invalid one is selected (because it was deleted from another character)
    PACOProfileManager.fixActiveProfile()

    -- get the active Profile
    local activeProfile = PACOProfileManager.getActiveProfile()
    if activeProfile == PAC.GENERAL.NO_PROFILE_SELECTED_ID then
        -- TODO: show message that no profile is selected?
    else
        -- a valid profile is selected and thus SavedVars for that profile can be pre-loaded
        PAEM.RefreshSavedVarReference.PAConsume()
        -- then also all the events can be initialised
        PAEM.RefreshEventRegistration.PAConsume()
    end
	
	-- start the timer for to check food & exp buffs
	EVENT_MANAGER:RegisterForUpdate(AddonName, 10000, PA.Consume.OnUpdateTimer)
	
	-- add context menu choice for food & exp buffs
	ZO_PreHook("ZO_InventorySlot_ShowContextMenu", PA.Consume.AddContextMenuItemWithDelay)

    -- create the options with LAM-2
    PA.Consume.createOptions()
end

PAEM.RegisterForEvent(AddonName, EVENT_ADD_ON_LOADED, initAddon)


-- =====================================================================================================================
-- Export
PA.Consume.AddonName = AddonName
PA.Consume.println = println
PA.Consume.debugln = debugln