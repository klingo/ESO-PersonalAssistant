-- Local instances of Global tables --
local PA = PersonalAssistant

-- ---------------------------------------------------------------------------------------------------------------------

local PALootMenuDefaults = {
    enabled = false,
    chatOutput = true,

    LootRecipes = {
        enabled = true,

        unknownRecipeMsg = true
    },

    LootMotifs = {
        enabled = true,

        unknownMotifMsg = true,
    },

    LootApparelWeapons = {
        enabled = true,

        unknownTraitMsg = true,
    }
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PALoot = PALootMenuDefaults