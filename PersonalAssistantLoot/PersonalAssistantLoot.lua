-- Addon: PersonalAssistant.Loot
-- Developer: Klingo

PAL = {}
PAL.AddonName = "PersonalAssistantLoot"
PAL.AddonVersion = "1.0"

-- init default values
function PAL.initDefaults()
    -- initialize the multi-profile structure
    PAL.Loot_Defaults = {}
    -- -----------------------------------------------------
    -- default values for PALoot
    for profileNo = 1, PAG_MAX_PROFILES do
        PAL.Loot_Defaults[profileNo] = {
            HarvestableItemTypes = {},
            LootableItemTypes = {}
        }
        PAL.Loot_Defaults[profileNo].enabled = false
        PAL.Loot_Defaults[profileNo].lootGold = true
        PAL.Loot_Defaults[profileNo].lootItems = true
        PAL.Loot_Defaults[profileNo].hideItemLootMsg = false
        PAL.Loot_Defaults[profileNo].hideGoldLootMsg = false
        PAL.Loot_Defaults[profileNo].hideAllMsg = false

        -- default values for ItemTypes (only prepare defaults for enabled itemTypes)
        -- auto-loot=true, ignore=false
        for i = 1, #PALHarvestableItemTypes do
            if PALHarvestableItemTypes[i] ~= "" then
                PAL.Loot_Defaults[profileNo].HarvestableItemTypes[PALHarvestableItemTypes[i]] = PAC_ITEMTYPE_IGNORE
            end
        end

        for i = 1, #PALLootableItemTypes do
            if PALLootableItemTypes[i] ~= "" then
                PAL.Loot_Defaults[profileNo].LootableItemTypes[PALLootableItemTypes[i]] = PAC_ITEMTYPE_IGNORE
            end
        end
    end
end

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

PAEM.RegisterForEvent(PAL.AddonName, EVENT_ADD_ON_LOADED, PAL.initAddon)