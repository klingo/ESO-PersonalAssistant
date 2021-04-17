-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

-- =====================================================================================================================

local PALootMenuDefaults = {
    name = GetString(SI_PA_MENU_PROFILE_DEFAULT),

    -- ---------------------------------------------
    LootEvents = {
        lootEventsEnabled = true,

        LootRecipes = {
            unknownRecipeMsg = true
        },

        LootStyles = {
            unknownMotifMsg = true,
            unknownStylePageMsg = true,
        },

        LootApparelWeapons = {
            unknownTraitMsg = true,
        },
    },

    ItemIcons = {
        itemIconsEnabled = true,

        Recipes = {
            showKnownIcon = true,
            showUnknownIcon = true,
        },

        Motifs = {
            showKnownIcon = true,
            showUnknownIcon = true,
        },

        StylePageContainers = {
            showKnownIcon = true,
            showUnknownIcon = true,
        },

        ApparelWeapons = {
            showKnownIcon = true,
            showUnknownIcon = true,
        },

        iconPositionGrid = PAC.ICON_POSITION.AUTO,
        iconTooltipShown = true,
        iconSizeRow = 16,
        iconSizeGrid = 16,
        iconXOffsetList = 0,
        iconYOffsetList = 0,
        iconXOffsetGrid = 0,
        iconYOffsetGrid = 0,
    },

    InventorySpace = {
        lowInventorySpaceWarning = true,
        lowInventorySpaceThreshold = 10,
    },

    silentMode = false,
}

-- =====================================================================================================================
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PALoot = PALootMenuDefaults