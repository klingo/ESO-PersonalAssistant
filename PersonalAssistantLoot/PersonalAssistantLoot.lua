-- Addon: PersonalAssistant.Loot
-- Developer: Klingo

PAL = {}
PAL.AddonVersion = "1.0.0"

-- default values
PAL.Loot_Defaults = {}

-- init saved variables and register Addon
function PAL.initAddon(eventCode, addOnName)
    if addOnName ~= "PersonalAssistantLoot" then
        return
    end
	
	-- initialize the default values
	PAL.initDefaults()

	-- gets values from SavedVars, or initialises with default values
    PAL.savedVars = ZO_SavedVars:NewAccountWide("PersonalAssistantLoot_SavedVariables", 1, "Loot", PAL.Loot_Defaults)

    -- register PALoot
    ZO_PreHookHandler(RETICLE.interact, "OnEffectivelyShown", PAL.OnReticleTargetChanged)
    EVENT_MANAGER:RegisterForEvent("PersonalAssistantLoot", EVENT_LOOT_UPDATED, PAL.OnLootUpdated)
	
	-- addon load complete - unregister event
	EVENT_MANAGER:UnregisterForEvent("PersonalAssistantLoot_AddonLoaded", EVENT_ADD_ON_LOADED)
end


-- init default values
function PAL.initDefaults()
	for profileNo = 1, PAG_MAX_PROFILES do
		-- initialize the multi-profile structure

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

EVENT_MANAGER:RegisterForEvent("PersonalAssistantLoot_AddonLoaded", EVENT_ADD_ON_LOADED, PAL.initAddon)