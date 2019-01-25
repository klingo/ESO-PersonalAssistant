-- Addon: PersonalAssistant.Junk
-- Developer: Klingo

PAJ = {}
PAJ.AddonName = "PersonalAssistantJunk"
PAJ.AddonVersion = "1.0"

-- init default values
function PAJ.initDefaults()
    -- initialize the multi-profile structure
    PAJ.Junk_Defaults = {}
    -- -----------------------------------------------------
    -- default values for PAJunk
    for profileNo = 1, PAG_MAX_PROFILES do
        PAJ.Junk_Defaults[profileNo] = PAMenu_Defaults.defaultSettings.PAJunk
    end
end


-- init saved variables and register Addon
function PAJ.initAddon(_, addOnName)
    if addOnName ~= PAJ.AddonName then
        return
    end

    -- addon load started - unregister event
    local PAEM = PersonalAssistant.EventManager
    PAEM.UnregisterForEvent(PAJ.AddonName, EVENT_ADD_ON_LOADED)

    -- initialize the default values
    PAJ.initDefaults()

    -- gets values from SavedVars, or initialises with default values
    PA.savedVars.Junk = ZO_SavedVars:NewAccountWide("PersonalAssistantJunk_SavedVariables", 1, "Junk", PAJ.Junk_Defaults)
end

PAEM.RegisterForEvent(PAJ.AddonName, EVENT_ADD_ON_LOADED, PAJ.initAddon)