-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAEM = PA.EventManager
local PASV = PA.SavedVars
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

-- Local constants --
local AddonName = "PersonalAssistantRepair"
local Repair_Defaults = {}

-- ---------------------------------------------------------------------------------------------------------------------

-- only prints out PARepair texts if chatOutput is enabled
local function println(text, ...)
    if PASV.Repair[PA.activeProfile].chatOutput then
        PAHF.println(text, ...)
    end
end

-- init default values
local function initDefaults()
    local PAMenuDefaults = PA.MenuDefaults
    -- default values for PARepair
    for profileNo = 1, PAC.GENERAL.MAX_PROFILES do
        -- get default values from PAMenuDefaults
        Repair_Defaults[profileNo] = PAMenuDefaults.PARepair
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
    PASV.Repair = ZO_SavedVars:NewAccountWide("PersonalAssistantRepair_SavedVariables", 1, nil, Repair_Defaults)

    -- create the options with LAM-2
    PA.Repair.createOptions()
end

PAEM.RegisterForEvent(AddonName, EVENT_ADD_ON_LOADED, initAddon)

-- ---------------------------------------------------------------------------------------------------------------------

-- Export
PA.Repair = {
    AddonName = AddonName,
    println = println
}