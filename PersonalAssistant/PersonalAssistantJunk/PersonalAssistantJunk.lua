-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAEM = PA.EventManager
local PASV = PA.SavedVars

-- Local constants --
local AddonName = "PersonalAssistantJunk"
local Junk_Defaults = {}

-- ---------------------------------------------------------------------------------------------------------------------

-- init default values
local function initDefaults()
    local PAMenuDefaults = PA.MenuDefaults
    -- default values for PAJunk
    for profileNo = 1, PAC.GENERAL.MAX_PROFILES do
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
    PASV.Junk = ZO_SavedVars:NewAccountWide("PersonalAssistantJunk_SavedVariables", 1, "Junk", Junk_Defaults)
end

PAEM.RegisterForEvent(AddonName, EVENT_ADD_ON_LOADED, initAddon)

-- ---------------------------------------------------------------------------------------------------------------------

-- Export
PA.Junk = {
    AddonName = AddonName
}