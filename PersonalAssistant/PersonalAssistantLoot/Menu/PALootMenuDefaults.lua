-- Local instances of Global tables --
local PA = PersonalAssistant

-- ---------------------------------------------------------------------------------------------------------------------

local PALootMenuDefaults = {

    LootEvents = {
        lootEventsEnabled = true,

        LootRecipes = {
            unknownRecipeMsg = true
        },

        LootMotifs = {
            unknownMotifMsg = true,
        },

        LootApparelWeapons = {
            unknownTraitMsg = true,
        },
    },

    ItemIcons = {
        itemIconsEnabled = true,
    },

    InventorySpace = {
        lowInventorySpaceWarning = true,
        lowInventorySpaceThreshold = 10,
    },

    silentMode = false,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PALoot = PALootMenuDefaults