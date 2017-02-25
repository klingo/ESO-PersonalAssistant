--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 25.02.2017
-- Time: 19:52
--

PAW = {}
PAW.AddonName = "PersonalAssistantWorker"
PAW.AddonVersion = "1.0"

-- init default values
function PAW.initDefaults()
    -- initialize the multi-profile structure
    PAW.Worker_Defaults = {}
    -- -----------------------------------------------------
    -- default values for PAWorker
    for profileNo = 1, PAG_MAX_PROFILES do
        PAW.Worker_Defaults[profileNo] = PAMenu_Defaults.defaultSettings.PAWorker
    end
end


-- init saved variables and register Addon
function PAW.initAddon(_, addOnName)
    if addOnName ~= PAB.AddonName then
        return
    end

    -- addon load started - unregister event
    PAEM.UnregisterForEvent(PAW.AddonName, EVENT_ADD_ON_LOADED)

    -- initialize the default values
    PAW.initDefaults()

    -- gets values from SavedVars, or initialises with default values
    PA.savedVars.Banking = ZO_SavedVars:NewAccountWide("PersonalAssistantWorker_SavedVariables", 1, "Worker", PAW.Worker_Defaults)
end

PAEM.RegisterForEvent(PAW.AddonName, EVENT_ADD_ON_LOADED, PAW.initAddon)