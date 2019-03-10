-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

-- ---------------------------------------------------------------------------------------------------------------------

local PARepairMenuDefaults = {
    autoRepairEnabled = true,
    chatOutput = true,

    -- ---------------------------------------------

    RepairEquipped = {
        repairWithGold = true,
        repairWithGoldDurabilityThreshold = 75,
        repairWithGoldChatMode = PAC.CHATMODE.OUTPUT_NORMAL,

        repairWithRepairKit = false,
        repairWithRepairKitThreshold = 25,
        repairWithRepairKitChatMode = PAC.CHATMODE.OUTPUT_NORMAL,

        repairWithCrownRepairKit = false,
        repairWithCrownRepairKitThreshold = 25,
        repairWithCrownRepairKitChatMode = PAC.CHATMODE.OUTPUT_NORMAL,

        lowRepairKitWarning = true,
    },

    -- ---------------------------------------------

    RechargeWeapons = {
        useSoulGems = false,
        chargeWeaponsChatMode = PAC.CHATMODE.OUTPUT_NORMAL,
        lowSoulGemWarning = true,
    },
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.MenuDefaults = PA.MenuDefaults or {}
PA.MenuDefaults.PARepair = PARepairMenuDefaults