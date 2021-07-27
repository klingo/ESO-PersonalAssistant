-- Local instances of Global tables --
local PA = PersonalAssistant

-- =====================================================================================================================

local PARepairMenuDefaults = {
    name = table.concat({GetString(SI_PA_PROFILE), " ", 1}),

    -- ---------------------------------------------
    autoRepairEnabled = true,
    autoRepairInventoryEnabled = false,

    -- ---------------------------------------------

    RepairEquipped = {
        repairWithGold = true,
        repairWithGoldDurabilityThreshold = 75,

        repairWithRepairKit = false,
        defaultRepairKit = DEFAULT_SOUL_GEM_CHOICE_GOLD,
        repairWithRepairKitThreshold = 10,
        lowRepairKitWarning = true,
        lowRepairKitThreshold = 10,
    },

    -- ---------------------------------------------

    RepairInventory = {
        repairWithGold = true,
        repairWithGoldDurabilityThreshold = 75,
    },

    -- ---------------------------------------------

    RechargeWeapons = {
        useSoulGems = false,
        defaultSoulGem = DEFAULT_SOUL_GEM_CHOICE_CROWN,
        lowSoulGemWarning = true,
        lowSoulGemThreshold = 10,
    },

    -- ---------------------------------------------

    silentMode = false,
}

-- =====================================================================================================================
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PARepair = PARepairMenuDefaults