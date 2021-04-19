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

        iconTooltipShown = true,
        iconSizeRow = 16,
        iconSizeGrid = 16,
        iconXOffsetList = 0,
        iconYOffsetList = 0,
        iconXOffsetGrid = 2,
        iconYOffsetGrid = -2,

        SetCollection = {
            showUncollectedIcon = true,
            iconSizeRow = 16,
            iconSizeGrid = 16,
            iconXOffsetList = 20,
            iconYOffsetList = 0,
            iconXOffsetGrid = -2,
            iconYOffsetGrid = -2,
        }
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