-- Local instances of Global tables --
local PA = PersonalAssistant

-- ---------------------------------------------------------------------------------------------------------------------

local PALootMenuDefaults = {
    enabled = false,
    chatOutput = true,

    LootRecipes = {
        unknownRecipeMsg = true
    },

    LootMotifs = {
        unknownMotifMsg = true,
    },

    LootApparelWeapons = {
        unknownTraitMsg = true,
    }
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PALoot = PALootMenuDefaults