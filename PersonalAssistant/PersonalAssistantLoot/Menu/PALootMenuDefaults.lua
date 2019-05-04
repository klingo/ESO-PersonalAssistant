-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

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

        Recipes = {
            showKnownIcon = false,
            showUnknownIcon = true,
            showTooltip = true,
        },

        Motifs = {
            showKnownIcon = false,
            showUnknownIcon = true,
            showTooltip = true,
        },

        ApparelWeapons = {
            showKnownIcon = false,
            showUnknownIcon = true,
            showTooltip = true,
        },

        iconSizeRow = 16,
        iconSizeGrid = 16,
        iconPositionGrid = PAC.ICON_POSITION.AUTO,
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