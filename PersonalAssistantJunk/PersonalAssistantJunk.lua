-- Addon: PersonalAssistant.Junk
-- Developer: Klingo

PAJ = {}
PAJ.AddonName = "PersonalAssistantJunk"
PAJ.AddonVersion = "1.0"

-- globla indicators of whether some processing is ongoing
PAJ.isJunkProcessing = false

-- init default values
function PAJ.initDefaults()
    -- initialize the multi-profile structure
    PAJ.Junk_Defaults = {}
    -- -----------------------------------------------------
    -- default values for PAJunk
    for profileNo = 1, PAG_MAX_PROFILES do
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


-- init saved variables and register Addon
function PA.initAddon(eventCode, addOnName)
    if addOnName ~= PAJ.AddonName then
        return
    end

    -- addon load started - unregister event
    PAEM.UnregisterForEvent(PAJ.AddonName, EVENT_ADD_ON_LOADED)
	
	-- initialize the default values
    PAJ.initDefaults()

	-- gets values from SavedVars, or initialises with default values
    PA.savedVars.Junk = ZO_SavedVars:NewAccountWide("PersonalAssistantJunk_SavedVariables", 1, "Junk", PAJ.Junk_Defaults)

    -- register PARepair (in correspondance with PAJunk)
    PAEM.RegisterForEvent(PAJ.AddonName, EVENT_OPEN_STORE, PAEM.EventOpenStore, "RepairJunkSharedEvent")
    PAEM.RegisterForEvent(PAJ.AddonName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, PAJ.OnInventorySingleSlotUpdate)
end

PAEM.RegisterForEvent(PAJ.AddonName, EVENT_ADD_ON_LOADED, PAJ.initAddon)