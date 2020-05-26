-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACAddon = PAC.ADDON
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

-- Local constants --
local AddonName = "PersonalAssistantLoot"
local Loot_Defaults = {}

-- ---------------------------------------------------------------------------------------------------------------------

-- only prints out PALoot texts if silentMode is disabled
local function println(text, ...)
    if not PA.Loot.SavedVars.silentMode then
        PAHF.println(PA.Loot.chat, PAC.COLORED_TEXTS.PAL, text, ...)
    end
end

-- wrapper method that prefixes the addon shortname
local function debugln(text, ...)
    PAHF.debugln(PAC.COLORED_TEXTS_DEBUG.PAL, text, ...)
end

-- init default values
local function initDefaults()
    local PAMenuDefaults = PA.MenuDefaults
    -- default values for PALoot
    Loot_Defaults.savedVarsVersion = PACAddon.SAVED_VARS_VERSION.MINOR
    for profileNo = 1, PAC.GENERAL.MAX_PROFILES do
        -- get default values from PAMenuDefaults
        Loot_Defaults[profileNo] = PAMenuDefaults.PALoot
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
        PA.Loot.chat = PA.LibChatMessage(PAC.COLORED_TEXTS.PAL, PAC.COLORED_TEXTS_DEBUG.PAL)
    end

    -- gets values from SavedVars, or initialises with default values
    PA.SavedVars.Loot = ZO_SavedVars:NewAccountWide("PersonalAssistantLoot_SavedVariables", PAC.ADDON.SAVED_VARS_VERSION.MAJOR.LOOT, nil, Loot_Defaults)

    -- create the options with LAM-2
    PA.Loot.createOptions()
end

PAEM.RegisterForEvent(AddonName, EVENT_ADD_ON_LOADED, initAddon)

-- ---------------------------------------------------------------------------------------------------------------------

-- Export
PA.Loot = {
    AddonName = AddonName,
    println = println,
    debugln = debugln
}