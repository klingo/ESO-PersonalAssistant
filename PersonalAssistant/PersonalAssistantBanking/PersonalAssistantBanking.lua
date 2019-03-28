-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

-- Local constants --
local AddonName = "PersonalAssistantBanking"
local Banking_Defaults = {}

-- ---------------------------------------------------------------------------------------------------------------------

-- only prints out PABanking texts if silentMode is disabled
local function println(text, ...)
    if not PA.Banking.SavedVars.silentMode then
        PAHF.println(text, ...)
    end
end

-- init default values
local function initDefaults()
    local PAMenuDefaults = PA.MenuDefaults
    -- default values for PABanking
    for profileNo = 1, PAC.GENERAL.MAX_PROFILES do
        -- get default values from PAMenuDefaults
        Banking_Defaults[profileNo] = PAMenuDefaults.PABanking
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
    PA.SavedVars.Banking = ZO_SavedVars:NewAccountWide("PersonalAssistantBanking_SavedVariables", 2, nil, Banking_Defaults)

    -- create the options with LAM-2
    PA.Banking.createOptions()
end

PAEM.RegisterForEvent(AddonName, EVENT_ADD_ON_LOADED, initAddon)

-- ---------------------------------------------------------------------------------------------------------------------

-- Export
PA.Banking = {
    AddonName = AddonName,
    println = println
}