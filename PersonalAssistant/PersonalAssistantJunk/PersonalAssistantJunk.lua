-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

-- Local constants --
local AddonName = "PersonalAssistantJunk"
local Junk_Defaults = {}

-- ---------------------------------------------------------------------------------------------------------------------

-- only prints out PAJunk texts if silentMode is disabled
local function println(text, ...)
    if not PA.Junk.SavedVars.silentMode then
        PAHF.println(text, ...)
    end
end

-- init default values
local function initDefaults()
    local PAMenuDefaults = PA.MenuDefaults
    -- default values for PAJunk
    for profileNo = 1, PAC.GENERAL.MAX_PROFILES do
        -- get default values from PAMenuDefaults
        Junk_Defaults[profileNo] = PAMenuDefaults.PAJunk
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

    -- gets values from SavedVars, or initialises with default values
    PA.SavedVars.Junk = ZO_SavedVars:NewAccountWide("PersonalAssistantJunk_SavedVariables", 2, nil, Junk_Defaults)

    -- create the options with LAM-2
    PA.Junk.createOptions()
end

PAEM.RegisterForEvent(AddonName, EVENT_ADD_ON_LOADED, initAddon)

-- ---------------------------------------------------------------------------------------------------------------------

-- Export
PA.Junk = {
    AddonName = AddonName,
    println = println
}