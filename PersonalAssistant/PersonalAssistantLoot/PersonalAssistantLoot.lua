-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAEM = PA.EventManager
local PASV = PA.SavedVars

-- Local constants --
local AddonName = "PersonalAssistantLoot"
local Loot_Defaults = {}

-- ---------------------------------------------------------------------------------------------------------------------

-- init default values
local function initDefaults()
    local PAMenuDefaults = PA.MenuDefaults
    -- default values for PALoot
    for profileNo = 1, PAC.GENERAL.MAX_PROFILES do
        -- get default vlaues from PAMenuDefaults
        Loot_Defaults[profileNo] = PAMenuDefaults.PALoot

        -- default values for ItemTypes (only prepare defaults for enabled itemTypes)
        -- auto-loot=true, ignore=false
        for i = 1, #PALHarvestableItemTypes do
            if PALHarvestableItemTypes[i] ~= "" then
                Loot_Defaults[profileNo].HarvestableItemTypes[PALHarvestableItemTypes[i]] = PAC_ITEMTYPE_IGNORE
            end
        end

        for i = 1, #PALLootableItemTypes do
            if PALLootableItemTypes[i] ~= "" then
                Loot_Defaults[profileNo].LootableItemTypes[PALLootableItemTypes[i]] = PAC_ITEMTYPE_IGNORE
            end
        end
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
    PASV.Loot = ZO_SavedVars:NewAccountWide("PersonalAssistantLoot_SavedVariables", 1, "Loot", Loot_Defaults)
end

PAEM.RegisterForEvent(AddonName, EVENT_ADD_ON_LOADED, initAddon)

-- ---------------------------------------------------------------------------------------------------------------------

-- Export
PA.Loot = {
    AddonName = AddonName
}