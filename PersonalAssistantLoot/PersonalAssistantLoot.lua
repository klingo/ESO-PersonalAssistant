-- Addon: PersonalAssistant.Loot
-- Developer: Klingo

PAL = {}
PAL.AddonName = "PersonalAssistantLoot"
PAL.AddonVersion = "1.0.0"

-- default values
PAL.Loot_Defaults = {}

-- init saved variables and register Addon
function PAL.initAddon(eventCode, addOnName)
    if addOnName ~= PAL.AddonName then
        return
    end

    -- addon load started - unregister event
    PAEM.UnregisterForEvent(PAL.AddonName, EVENT_ADD_ON_LOADED)
	
	-- initialize the default values
	PAL.initDefaults()

	-- gets values from SavedVars, or initialises with default values
    PA.savedVars.Loot = ZO_SavedVars:NewAccountWide("PersonalAssistantLoot_SavedVariables", 1, "Loot", PAL.Loot_Defaults)

    -- register PALoot
    ZO_PreHookHandler(RETICLE.interact, "OnEffectivelyShown", PAL.OnReticleTargetChanged)
    PAEM.RegisterForEvent(PAL.AddonName, EVENT_LOOT_UPDATED, PAL.OnLootUpdated)
end


-- init default values
function PAL.initDefaults()
    -- initialize the multi-profile structure
	for profileNo = 1, PAG_MAX_PROFILES do
	    -- -----------------------------------------------------
		-- default values for PALoot
        PAL.Loot_Defaults[profileNo] = {
            ItemTypes = {}
        }
        PAL.Loot_Defaults[profileNo].enabled = false
        PAL.Loot_Defaults[profileNo].lootGold = true
        PAL.Loot_Defaults[profileNo].lootItems = true
        PAL.Loot_Defaults[profileNo].hideItemLootMsg = false
        PAL.Loot_Defaults[profileNo].hideGoldLootMsg = false
        PAL.Loot_Defaults[profileNo].hideAllMsg = false

        -- default values for ItemTypes (only prepare defaults for enabled itemTypes)
        -- auto-loot=true, ignore=false
        for i = 1, #PALoItemTypes do
            if PALoItemTypes[i] ~= "" then
                PAL.Loot_Defaults[profileNo].ItemTypes[PALoItemTypes[i]] = 0
            end
        end
	end
end

PAEM.RegisterForEvent(PAL.AddonName, EVENT_ADD_ON_LOADED, PAL.initAddon)