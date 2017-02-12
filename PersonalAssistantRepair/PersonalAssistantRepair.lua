-- Addon: PersonalAssistant.Repair
-- Developer: Klingo

PAR = {}
PAR.AddonVersion = "1.0.0"

-- default values
PAR.Repair_Defaults = {}

-- init saved variables and register Addon
function PAR.initAddon(eventCode, addOnName)
    if addOnName ~= "PersonalAssistantRepair" then
        return
    end
	
	-- initialize the default values
	PAR.initDefaults()

	-- gets values from SavedVars, or initialises with default values
	PAR.savedVars = ZO_SavedVars:NewAccountWide("PersonalAssistantRepair_SavedVariables", 1, "Repair", PAR.Repair_Defaults)

	-- register Event Dispatcher for: PARepair and PAJunk
	-- TODO: check how to handle this
    EVENT_MANAGER:RegisterForEvent("PersonalAssistantRepair", EVENT_OPEN_STORE, PAED.EventOpenStore)

	-- addon load complete - unregister event
	EVENT_MANAGER:UnregisterForEvent("PersonalAssistantRepair_AddonLoaded", EVENT_ADD_ON_LOADED)
end


-- init default values
function PAR.initDefaults()
	for profileNo = 1, PAG_MAX_PROFILES do
		-- initialize the multi-profile structure

        -- -----------------------------------------------------
		-- default values for PARepair
        PAR.Repair_Defaults[profileNo] = {}
        PAR.Repair_Defaults[profileNo].enabled = true
        PAR.Repair_Defaults[profileNo].equipped = true
        PAR.Repair_Defaults[profileNo].equippedThreshold = 75
        PAR.Repair_Defaults[profileNo].backpack = false
        PAR.Repair_Defaults[profileNo].backpackThreshold = 75
        PAR.Repair_Defaults[profileNo].hideNoRepairMsg = false
        PAR.Repair_Defaults[profileNo].hideAllMsg = false
	end
end

EVENT_MANAGER:RegisterForEvent("PersonalAssistantRepair_AddonLoaded", EVENT_ADD_ON_LOADED, PAR.initAddon)