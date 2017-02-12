-- Addon: PersonalAssistant.Junk
-- Developer: Klingo

PAJ = {}
PAJ.AddonVersion = "1.0.0"

-- default values
PAJ.Junk_Defaults = {}

-- globla indicators of whether some processing is ongoing
PAJ.isJunkProcessing = false

-- init saved variables and register Addon
function PA.initAddon(eventCode, addOnName)
    if addOnName ~= "PersonalAssistantJunk" then
        return
    end
	
	-- initialize the default values
    PAJ.initDefaults()

	-- gets values from SavedVars, or initialises with default values
    PAJ.savedVars = ZI_SavedVars:NewAccountWide("PersonalAssistantJunk_SavedVars", 1, "Junk", PAJ.Junk_Defaults)

    -- register PAJunk
    EVENT_MANAGER:RegisterForEvent("PersonalAssistantJunk", EVENT_INVENTORY_SINGLE_SLOT_UPDATE, PAJ.OnInventorySingleSlotUpdate)

	-- addon load complete - unregister event
	EVENT_MANAGER:UnregisterForEvent("PersonalAssistantJunk_AddonLoaded", EVENT_ADD_ON_LOADED)
end


-- init default values
function PAJ.initDefaults()
	for profileNo = 1, PAG_MAX_PROFILES do
		-- initialize the multi-profile structure

        -- -----------------------------------------------------
        -- default values for PAJunk
        PAJ.Junk_Defaults[profileNo] = {}
        PAJ.Junk_Defaults[profileNo].enabled = false
        PAJ.Junk_Defaults[profileNo].autoSellJunk = true
        PAJ.Junk_Defaults[profileNo].autoMarkTrash = true
        PAJ.Junk_Defaults[profileNo].hideAllMsg = false

        -- default values for ItemTypes (only prepare defaults for enabled itemTypes)
        -- auto-flag-as-junk=true, ignore=false
--        for i = 2, #PAJItemTypes do
--            if PAJItemTypes[i] ~= "" then
--                PA.Junk_Defaults[profileNo].ItemTypes[PAJItemTypes[i]] = 0
--            end
--        end
	end
end

EVENT_MANAGER:RegisterForEvent("PersonalAssistantJunk_AddonLoaded", EVENT_ADD_ON_LOADED, PAJ.initAddon)