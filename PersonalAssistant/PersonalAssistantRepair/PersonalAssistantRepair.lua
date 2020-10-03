-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACAddon = PAC.ADDON
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

-- Local constants --
local AddonName = "PersonalAssistantRepair"
local Repair_Defaults = {}

-- ---------------------------------------------------------------------------------------------------------------------

-- only prints out PARepair texts if silentMode is disabled
local function println(text, ...)
    if not PA.Repair.SavedVars.silentMode then
        PAHF.println(PA.Repair.chat, PAC.COLORED_TEXTS.PAR, text, ...)
    end
end

-- wrapper method that prefixes the addon shortname
local function debugln(text, ...)
    PAHF.debugln(PAC.COLORED_TEXTS_DEBUG.PAR, text, ...)
end

-- init default values
local function initDefaults()
    local PASavedVars = PA.SavedVars
    local PAMenuDefaults = PA.MenuDefaults
    -- default values for PARepair
    if PASavedVars.General.profileCounter == 0 and PASavedVars.General[1] == nil then
        -- get default values from PAMenuDefaults
        Repair_Defaults[1] = PAMenuDefaults.PARepair
        Repair_Defaults.savedVarsVersion = PACAddon.SAVED_VARS_VERSION.MINOR
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
        PA.Repair.chat = PA.LibChatMessage(PAC.COLORED_TEXTS.PAR, PAC.COLORED_TEXTS_DEBUG.PAR)
    end

    -- gets values from SavedVars, or initialises with default values
    PA.SavedVars.Repair = ZO_SavedVars:NewAccountWide("PersonalAssistantRepair_SavedVariables", PAC.ADDON.SAVED_VARS_VERSION.MAJOR.REPAIR, nil, Repair_Defaults)

    -- sync profiles between PAGeneral and PARepair
    PAHF.syncLocalProfilesWithGlobal(PA.SavedVars.Repair, PA.MenuDefaults.PARepair)

    -- create the options with LAM-2
    PA.Repair.createOptions()
end

PAEM.RegisterForEvent(AddonName, EVENT_ADD_ON_LOADED, initAddon)

-- ---------------------------------------------------------------------------------------------------------------------

-- Export
PA.Repair = {
    AddonName = AddonName,
    println = println,
    debugln = debugln
}