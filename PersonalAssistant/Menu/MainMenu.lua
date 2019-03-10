-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
local PAMenuHelper = PA.MenuHelper
local PAMenuFunctions = PA.MenuFunctions
local PAMenuDefaults = PA.MenuDefaults
local PAMenuChoices = PA.MenuChoices

local LAM2 = LibStub("LibAddonMenu-2.0")

local panelData = {
    type = "panel",
    name = "PersonalAssistant",
    displayName = GetString(SI_PA_MENU_TITLE),
    author = "Klingo",
    version = PAC.ADDON_VERSION,
    website = "http://www.esoui.com/downloads/info381-PersonalAssistant",
    slashCommand = "/pa",
    registerForRefresh = true,
    registerForDefaults = true,
}

local PAJunkPanelData = {
    type = "panel",
    name = "PersonalAssistant Junk",
    displayName = GetString(SI_PA_MENU_TITLE),
    author = "Klingo",
    version = PAC.ADDON_VERSION,
    website = "http://www.esoui.com/downloads/info381-PersonalAssistant",
    slashCommand = "/pajunk",
    registerForRefresh = true,
    registerForDefaults = true,
}

local PALootPanelData = {
    type = "panel",
    name = "PersonalAssistant Loot",
    displayName = GetString(SI_PA_MENU_TITLE),
    author = "Klingo",
    version = PAC.ADDON_VERSION,
    website = "http://www.esoui.com/downloads/info381-PersonalAssistant",
    slashCommand = "/paloot",
    registerForRefresh = true,
    registerForDefaults = true,
}

local PAMailPanelData = {
    type = "panel",
    name = "PersonalAssistant Mail",
    displayName = GetString(SI_PA_MENU_TITLE),
    author = "Klingo",
    version = PAC.ADDON_VERSION,
    website = "http://www.esoui.com/downloads/info381-PersonalAssistant",
    slashCommand = "/pamail",
    registerForRefresh = true,
    registerForDefaults = true,
}

local PARepairPanelData = {
    type = "panel",
    name = "PersonalAssistant Repair",
    displayName = GetString(SI_PA_MENU_TITLE),
    author = "Klingo",
    version = PAC.ADDON_VERSION,
    website = "http://www.esoui.com/downloads/info381-PersonalAssistant",
    slashCommand = "/parepair",
    registerForRefresh = true,
    registerForDefaults = true,
}

local optionsTable = setmetatable({}, { __index = table })
local PAJunkOptionsTable = setmetatable({}, { __index = table })
local PALootOptionsTable = setmetatable({}, { __index = table })
local PAMailOptionsTable = setmetatable({}, { __index = table })
local PARepairOptionsTable = setmetatable({}, { __index = table })

local PARGoldSubmenuTable = setmetatable({}, { __index = table })
local PARRepairKitSubmenuTable = setmetatable({}, { __index = table })
local PARRechargeSubmenuTable = setmetatable({}, { __index = table })

local PALLootRecipesSubmenuTable = setmetatable({}, { __index = table })
local PALLootMotifsSubmenuTable = setmetatable({}, { __index = table })
local PALLootApparelWeaponsSubmenuTable = setmetatable({}, { __index = table })

local PAJTrashSubMenu = setmetatable({}, { __index = table })
local PAJWeaponsSubMenu = setmetatable({}, { __index = table })
local PAJArmorSubMenu = setmetatable({}, { __index = table })
local PAJJewelrySubMenu = setmetatable({}, { __index = table })


-- =================================================================================================================

local function createPAGeneralMenu()
    optionsTable:insert({
        type = "header",
        name = GetString(SI_PA_MENU_GENERAL_HEADER)
    })

    optionsTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_GENERAL_ACTIVE_PROFILE),
        tooltip = GetString(SI_PA_MENU_GENERAL_ACTIVE_PROFILE_T),
        choices = PAMenuHelper.getProfileList(),
        choicesValues = PAMenuHelper.getProfileListValues(),
        width = "half",
        getFunc = PAMenuFunctions.PAGeneral.getActiveProfile,
        setFunc = PAMenuFunctions.PAGeneral.setActiveProfile,
        reference = "PERSONALASSISTANT_PROFILEDROPDOWN",
    })

    optionsTable:insert({
        type = "editbox",
        name = GetString(SI_PA_MENU_GENERAL_ACTIVE_PROFILE_RENAME),
        tooltip = GetString(SI_PA_MENU_GENERAL_ACTIVE_PROFILE_RENAME_T),
        width = "half",
        getFunc = PAMenuFunctions.PAGeneral.getActiveProfileRename,
        setFunc = PAMenuFunctions.PAGeneral.setActiveProfileRename,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
    })

    optionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_GENERAL_SHOW_WELCOME),
        tooltip = GetString(SI_PA_MENU_GENERAL_SHOW_WELCOME_T),
        getFunc = PAMenuFunctions.PAGeneral.getWelcomeMessageSetting,
        setFunc = PAMenuFunctions.PAGeneral.setWelcomeMessageSetting,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PAGeneral.welcomeMessage,
    })
end

-- ---------------------------------------------------------------------------------------------------------------------

local function createPAJunkMenu()
    PAJunkOptionsTable:insert({
        type = "header",
        name = GetString(SI_PA_MENU_JUNK_HEADER)
    })

    PAJunkOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_JUNK_ITEMTYPE_DESCRIPTION),
    })

    PAJunkOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_ENABLE),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_ENABLE_T),
        getFunc = PAMenuFunctions.PAJunk.getAutoMarkAsJunkEnabledSetting,
        setFunc = PAMenuFunctions.PAJunk.setAutoMarkAsJunkEnabledSetting,
        disabled = PAMenuFunctions.PAJunk.isAutoMarkAsJunkDisabled,
        default = PAMenuDefaults.PAJunk.autoMarkAsJunkEnabled,
    })

    PAJunkOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_TRASH_HEADER),
        controls = PAJTrashSubMenu,
        disabled = PAMenuFunctions.PAJunk.isTrashMenuDisabled,
    })

    PAJunkOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_WEAPONS_HEADER),
        controls = PAJWeaponsSubMenu,
        disabled = PAMenuFunctions.PAJunk.isWeaponsMenuDisabled,
    })

    PAJunkOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_ARMOR_HEADER),
        controls = PAJArmorSubMenu,
        disabled = PAMenuFunctions.PAJunk.isArmorMenuDisabled,
    })

    PAJunkOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_JEWELRY_HEADER),
        controls = PAJJewelrySubMenu,
        disabled = PAMenuFunctions.PAJunk.isJewelryMenuDisabled,
    })

    PAJunkOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOSELL_JUNK),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOSELL_JUNK_T),
        getFunc = PAMenuFunctions.PAJunk.getAutoSellJunkSetting,
        setFunc = PAMenuFunctions.PAJunk.setAutoSellJunkSetting,
        disabled = PAMenuFunctions.PAJunk.isAutoSellJunkDisabled,
        default = PAMenuDefaults.PAJunk.autoSellJunk,
    })

    PAJunkOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_GENERAL_CHAT_OUTPUT_ENABLE),
        tooltip = GetString(SI_PA_MENU_GENERAL_CHAT_OUTPUT_ENABLE_T),
        getFunc = PAMenuFunctions.PAJunk.getChatOutputSetting,
        setFunc = PAMenuFunctions.PAJunk.setChatOutputSetting,
        disabled = PAMenuFunctions.PAJunk.isChatOutputDisabled,
        default = PAMenuDefaults.PAJunk.chatOutput,
    })
end

-- ---------------------------------------------------------------------------------------------------------------------

local function createPALootMenu()
    PALootOptionsTable:insert({
        type = "header",
        name = GetString(SI_PA_MENU_LOOT_HEADER)
    })

    PALootOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_ENABLE),
        tooltip = GetString(SI_PA_MENU_LOOT_ENABLE_T),
        getFunc = PAMenuFunctions.PALoot.isEnabled,
        setFunc = PAMenuFunctions.PALoot.setIsEnabled,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PALoot.enabled,
    })

    PALootOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_LOOT_LOOT_RECIPES_HEADER),
        controls = PALLootRecipesSubmenuTable,
        disabled = PAMenuFunctions.PALoot.isLootRecipesMenuDisabled,
    })

    PALootOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_LOOT_LOOT_MOTIFS_HEADER),
        controls = PALLootMotifsSubmenuTable,
        disabled = PAMenuFunctions.PALoot.isLootMotifsMenuDisabled,
    })

    PALootOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_LOOT_LOOT_APPARELWEAPONS_HEADER),
        controls = PALLootApparelWeaponsSubmenuTable,
        disabled = PAMenuFunctions.PALoot.isLootApparelWeaponsMenuDisabled,
    })

    PALootOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_GENERAL_CHAT_OUTPUT_ENABLE),
        tooltip = GetString(SI_PA_MENU_GENERAL_CHAT_OUTPUT_ENABLE_T),
        getFunc = PAMenuFunctions.PALoot.getChatOutputSetting,
        setFunc = PAMenuFunctions.PALoot.setChatOutputSetting,
        disabled = PAMenuFunctions.PALoot.isChatOutputDisabled,
        default = PAMenuDefaults.PALoot.chatOutput,
    })
end

-- ---------------------------------------------------------------------------------------------------------------------

local function createPAMailMenu()
    PAMailOptionsTable:insert({
        type = "header",
        name = GetString(SI_PA_MENU_MAIL_HEADER)
    })

    PAMailOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_MAIL_HIRELING_AUTOMAIL_ENABLE),
        tooltip = GetString(SI_PA_MENU_MAIL_HIRELING_AUTOMAIL_ENABLE_T),
        getFunc = PAMenuFunctions.PAMail.getHirelingAutoMailEnabledSetting,
        setFunc = PAMenuFunctions.PAMail.setHirelingAutoMailEnabledSetting,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PAMail.hirelingAutoMailEnabled,
    })

    PAMailOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_MAIL_HIRELING_DELETE_EMPTYMAILS),
        tooltip = GetString(SI_PA_MENU_MAIL_HIRELING_DELETE_EMPTYMAILS_T),
        getFunc = PAMenuFunctions.PAMail.getHirelingDeleteEmptyMailsSetting,
        setFunc = PAMenuFunctions.PAMail.setHirelingDeleteEmptyMailsSetting,
        disabled = PAMenuFunctions.PAMail.isHirelingDeleteEmptyMailsDisabled,
        default = PAMenuDefaults.PAMail.hirelingDeleteEmptyMails,
    })

    PAMailOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_GENERAL_CHAT_OUTPUT_ENABLE),
        tooltip = GetString(SI_PA_MENU_GENERAL_CHAT_OUTPUT_ENABLE_T),
        getFunc = PAMenuFunctions.PAMail.getChatOutputSetting,
        setFunc = PAMenuFunctions.PAMail.setChatOutputSetting,
        disabled = PAMenuFunctions.PAMail.isChatOutputDisabled,
        default = PAMenuDefaults.PAMail.chatOutput,
    })
end

-- ---------------------------------------------------------------------------------------------------------------------

local function createPARepairMenu()
    PARepairOptionsTable:insert({
        type = "header",
        name = GetString(SI_PA_MENU_REPAIR_HEADER)
    })

    PARepairOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_REPAIR_ENABLE),
        getFunc = PAMenuFunctions.PARepair.getAutoRepairEnabledSetting,
        setFunc = PAMenuFunctions.PARepair.setAutoRepairEnabledSetting,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PARepair.autoRepairEnabled,
    })

    PARepairOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_REPAIR_GOLD_HEADER),
        controls = PARGoldSubmenuTable,
        disabled = PAMenuFunctions.PARepair.isRepairWithGoldMenuDisabled,
    })

    PARepairOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_HEADER),
        controls = PARRepairKitSubmenuTable,
        disabled = PAMenuFunctions.PARepair.isRepairWithRepairKitMenuDisabled,
    })

    PARepairOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_REPAIR_RECHARGE_HEADER),
        controls = PARRechargeSubmenuTable,
        disabled = PAMenuFunctions.PARepair.isRechargeWithSoulGemMenuDisabled,
    })

    PARepairOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_GENERAL_CHAT_OUTPUT_ENABLE),
        tooltip = GetString(SI_PA_MENU_GENERAL_CHAT_OUTPUT_ENABLE_T),
        getFunc = PAMenuFunctions.PARepair.getChatOutputSetting,
        setFunc = PAMenuFunctions.PARepair.setChatOutputSetting,
        disabled = PAMenuFunctions.PARepair.isChatOutputDisabled,
        default = PAMenuDefaults.PARepair.chatOutput,
    })
end

-- =================================================================================================================

local function createPARGoldSubmenuTable()
    PARGoldSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_REPAIR_GOLD_ENABLE),
        tooltip = GetString(SI_PA_MENU_REPAIR_GOLD_ENABLE_T),
        getFunc = PAMenuFunctions.PARepair.getRepairWithGoldSetting,
        setFunc = PAMenuFunctions.PARepair.setRepairWithGoldSetting,
        disabled = PAMenuFunctions.PARepair.isRepairWithGoldDisabled,
        default = PAMenuDefaults.PARepair.RepairEquipped.repairWithGold,
    })

    PARGoldSubmenuTable:insert({
        type = "slider",
        name = GetString(SI_PA_MENU_REPAIR_GOLD_DURABILITY),
        tooltip = GetString(SI_PA_MENU_REPAIR_GOLD_DURABILITY_T),
        min = 0,
        max = 99,
        step = 1,
--        width = "half",
        getFunc = PAMenuFunctions.PARepair.getRepairWithGoldDurabilityThresholdSetting,
        setFunc = PAMenuFunctions.PARepair.setRepairWithGoldDurabilityThresholdSetting,
        disabled = PAMenuFunctions.PARepair.isRepairWithGoldDurabilityThresholdDisabled,
        default = PAMenuDefaults.PARepair.RepairEquipped.repairWithGoldDurabilityThreshold,
    })

    PARGoldSubmenuTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_REPAIR_CHATMODE),
        tooltip = GetString(SI_PA_MENU_REPAIR_CHATMODE_T),
        choices = PAMenuChoices.choices.PARepair.repairChatMode,
        choicesValues = PAMenuChoices.choicesValues.PARepair.repairChatMode,
--            width = "half",
        getFunc = PAMenuFunctions.PARepair.getRepairWithGoldChatModeSetting,
        setFunc = PAMenuFunctions.PARepair.setRepairWithGoldChatModeSetting,
        disabled = PAMenuFunctions.PARepair.isRepairWithGoldChatModeDisabled,
        default = PAMenuDefaults.PARepair.RepairEquipped.repairWithGoldChatMode,
    })

end

-- -----------------------------------------------------------------------------------------------------------------

local function createPARRepairKitSubmenuTable()
    PARRepairKitSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE),
        tooltip = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE_T),
        getFunc = PAMenuFunctions.PARepair.getRepairWithRepairKitSetting,
        setFunc = PAMenuFunctions.PARepair.setRepairWithRepairKitSetting,
        disabled = PAMenuFunctions.PARepair.isRepairWithRepairKitDisabled,
        default = PAMenuDefaults.PARepair.RepairEquipped.repairWithRepairKit,
    })

    PARRepairKitSubmenuTable:insert({
        type = "slider",
        name = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY),
        tooltip = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY_T),
        min = 0,
        max = 99,
        step = 1,
        getFunc = PAMenuFunctions.PARepair.getRepairWithRepairKitDurabilityThresholdSetting,
        setFunc = PAMenuFunctions.PARepair.setRepairWithRepairKitDurabilityThresholdSetting,
        disabled = PAMenuFunctions.PARepair.isRepairWithRepairKitDurabilityThresholdDisabled,
        default = PAMenuDefaults.PARepair.RepairEquipped.repairWithRepairKitThreshold,
    })


--    PARRepairKitSubmenuTable:insert({
--        type = "description",
--        text = GetString(SI_PA_MENU_NOT_YET_IMPLEMENTED)
--    })
--
--    PARRepairKitSubmenuTable:insert({
--        type = "checkbox",
--        name = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_ENABLE),
--        tooltip = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_ENABLE_T),
--        width = "half",
--        getFunc = PAMenuFunctions.PARepair.getRepairWithCrownRepairKitSetting,
--        setFunc = PAMenuFunctions.PARepair.setRepairWithCrownRepairKitSetting,
--        disabled = PAMenuFunctions.PARepair.isRepairWithCrownRepairKitDisabled,
--        default = PAMenuDefaults.PARepair.RepairEquipped.repairWithCrownRepairKit,
--    })
--
--    PARRepairKitSubmenuTable:insert({
--        type = "slider",
--        name = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_DURABILITY),
--        tooltip = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_DURABILITY_T),
--        min = 0,
--        max = 99,
--        step = 1,
--        width = "half",
--        getFunc = PAMenuFunctions.PARepair.getRepairWithCrownRepairKitDurabilityThresholdSetting,
--        setFunc = PAMenuFunctions.PARepair.setRepairWithCrownRepairKitDurabilityThresholdSetting,
--        disabled = PAMenuFunctions.PARepair.isRepairWithCrownRepairKitDurabilityThresholdDisabled,
--        default = PAMenuDefaults.PARepair.RepairEquipped.repairWithCrownRepairKitThreshold,
--    })

    PARRepairKitSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING),
        tooltip = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING_T),
        getFunc = PAMenuFunctions.PARepair.getLowRepairKitWarningSetting,
        setFunc = PAMenuFunctions.PARepair.setLowRepairKitWarningSetting,
        disabled = PAMenuFunctions.PARepair.isLowRepairKitWarningDisabled,
        default = PAMenuDefaults.PARepair.RepairEquipped.lowRepairKitWarning,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPARRechargeSubmenuTable()
    PARRechargeSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_REPAIR_RECHARGE_ENABLE),
        tooltip = GetString(SI_PA_MENU_REPAIR_RECHARGE_ENABLE_T),
        getFunc = PAMenuFunctions.PARepair.getRechargeWithSoulGemSetting,
        setFunc = PAMenuFunctions.PARepair.setRechargeWithSoulGemSetting,
        disabled = PAMenuFunctions.PARepair.isRechargeWithSoulGemDisabled,
        default = PAMenuDefaults.PARepair.RechargeWeapons.useSoulGems,
    })

    PARRechargeSubmenuTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_REPAIR_RECHARGE_CHATMODE),
        tooltip = GetString(SI_PA_MENU_REPAIR_RECHARGE_CHATMODE_T),
        choices = PAMenuChoices.choices.PARepair.chargeWeaponsChatMode,
        choicesValues = PAMenuChoices.choicesValues.PARepair.chargeWeaponsChatMode,
        getFunc = PAMenuFunctions.PARepair.getChargeWeaponsChatModeSetting,
        setFunc = PAMenuFunctions.PARepair.setChargeWeaponsChatModeSetting,
        disabled = PAMenuFunctions.PARepair.isChargeWeaponsChatModeDisabled,
        default = PAMenuDefaults.PARepair.RechargeWeapons.chargeWeaponsChatMode,
    })

    PARRechargeSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING),
        tooltip = GetString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING_T),
        getFunc = PAMenuFunctions.PARepair.getLowSoulGemWarningSetting,
        setFunc = PAMenuFunctions.PARepair.setLowSoulGemWarningSetting,
        disabled = PAMenuFunctions.PARepair.isLowSoulGemWarningDisabled,
        default = PAMenuDefaults.PARepair.RechargeWeapons.lowSoulGemWarning,
    })
end

-- =================================================================================================================



local function createPALLootRecipesSubmenuTable()
    PALLootRecipesSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_LOOT_RECIPES),
        tooltip = GetString(SI_PA_MENU_LOOT_LOOT_RECIPES_T),
        getFunc = PAMenuFunctions.PALoot.getLootRecipesSetting,
        setFunc = PAMenuFunctions.PALoot.setLootRecipesSetting,
        disabled = PAMenuFunctions.PALoot.isLootRecipesDisabled,
        default = PAMenuDefaults.PALoot.LootRecipes.enabled,
    })

    PALLootRecipesSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_UNKNOWN_RECIPE_MSG),
        tooltip = GetString(SI_PA_MENU_LOOT_UNKNOWN_RECIPE_MSG_T),
        getFunc = PAMenuFunctions.PALoot.getUnknownRecipeMsgSetting,
        setFunc = PAMenuFunctions.PALoot.setUnknownRecipeMsgSetting,
        disabled = PAMenuFunctions.PALoot.isUnknownRecipeMsgDisabled,
        default = PAMenuDefaults.PALoot.LootRecipes.unknownRecipeMsg,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPALLootMotifsSubmenuTable()
    PALLootMotifsSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_LOOT_MOTIFS),
        tooltip = GetString(SI_PA_MENU_LOOT_LOOT_MOTIFS_T),
        getFunc = PAMenuFunctions.PALoot.getLootMotifsSetting,
        setFunc = PAMenuFunctions.PALoot.setLootMotifsSetting,
        disabled = PAMenuFunctions.PALoot.isLootMotifsDisabled,
        default = PAMenuDefaults.PALoot.LootMotifs.enabled,
    })

    PALLootMotifsSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_UNKNOWN_MOTIF_MSG),
        tooltip = GetString(SI_PA_MENU_LOOT_UNKNOWN_MOTIF_MSG_T),
        getFunc = PAMenuFunctions.PALoot.getUnknownMotifMsgSetting,
        setFunc = PAMenuFunctions.PALoot.setUnknownMotifMsgSetting,
        disabled = PAMenuFunctions.PALoot.isUnknownMotifMsgDisabled,
        default = PAMenuDefaults.PALoot.LootMotifs.unknownMotifMsg,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function createPALLootApparelWeaponsSubmenuTable()
    PALLootApparelWeaponsSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_LOOT_APPARELWEAPONS),
        tooltip = GetString(SI_PA_MENU_LOOT_LOOT_APPARELWEAPONS_T),
        getFunc = PAMenuFunctions.PALoot.getLootApparelWeaponsSetting,
        setFunc = PAMenuFunctions.PALoot.setLootApparelWeaponsSetting,
        disabled = PAMenuFunctions.PALoot.isLootApparelWeaponsDisabled,
        default = PAMenuDefaults.PALoot.LootApparelWeapons.enabled,
    })
end

-- =================================================================================================================

local function createPAJTrashSubMenu()
    PAJTrashSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_TRASH_AUTOMARK),
        tooltip = GetString(SI_PA_MENU_JUNK_TRASH_AUTOMARK_T),
        getFunc = PAMenuFunctions.PAJunk.getTrashAutoMarkSetting,
        setFunc = PAMenuFunctions.PAJunk.setTrashAutoMarkSetting,
        disabled = PAMenuFunctions.PAJunk.isTrashAutoMarkDisabled,
        default = PAMenuDefaults.PAJunk.Trash.autoMarkTrash,
    })

    -- TODO: mark junk food
end

local function createPAJWeaponsSubMenu()
    PAJWeaponsSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T),
        getFunc = PAMenuFunctions.PAJunk.getWeaponsAutoMarkOrnateSetting,
        setFunc = PAMenuFunctions.PAJunk.setWeaponsAutoMarkOrnateSetting,
        disabled = PAMenuFunctions.PAJunk.isWeaponsAutoMarkOrnateDisabled,
        default = PAMenuDefaults.PAJunk.Weapons.autoMarkOrnate,
    })

    PAJWeaponsSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_WEAPONS_AUTOMARK_QUALITY),
        tooltip = GetString(SI_PA_MENU_JUNK_WEAPONS_AUTOMARK_QUALITY_T),
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getWeaponsAutoMarkQualitySetting,
        setFunc = PAMenuFunctions.PAJunk.setWeaponsAutoMarkQualitySetting,
        disabled = PAMenuFunctions.PAJunk.isWeaponsAutoMarkQualityDisabled,
        default = PAMenuDefaults.PAJunk.Weapons.autoMarkQuality,
    })

    PAJWeaponsSubMenu:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_JUNK_WEAPONS_AUTOMARK_QUALITY_THRESHOLD),
        tooltip = GetString(SI_PA_MENU_JUNK_WEAPONS_AUTOMARK_QUALITY_THRESHOLD_T),
        choices = PAMenuChoices.choices.PAJunk.qualityLevel,
        choicesValues = PAMenuChoices.choicesValues.PAJunk.qualityLevel,
        --        choicesTooltips = PAMenuChoices.choicesTooltips.PAJunk.qualityLevel,
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getWeaponsAutoMarkQualityThresholdSetting,
        setFunc = PAMenuFunctions.PAJunk.setWeaponsAutoMarkQualityThresholdSetting,
        disabled = PAMenuFunctions.PAJunk.isWeaponsAutoMarkQualityThresholdDisabled,
        default = PAMenuDefaults.PAJunk.Weapons.autoMarkQualityThreshold,
    })

    PAJWeaponsSubMenu:insert({
        type = "divider",
        alpha = 0.5,
    })

    PAJWeaponsSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS_T),
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getWeaponsIncludeSetItemsSetting,
        setFunc = PAMenuFunctions.PAJunk.setWeaponsIncludeSetItemsSetting,
        disabled = PAMenuFunctions.PAJunk.isWeaponsIncludeSetItemsDisabled,
        default = PAMenuDefaults.PAJunk.Weapons.autoMarkIncludingSets,
    })

    PAJWeaponsSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T),
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getWeaponsIncludeUnknownTraitsSetting,
        setFunc = PAMenuFunctions.PAJunk.setWeaponsIncludeUnknownTraitsSetting,
        disabled = PAMenuFunctions.PAJunk.isWeaponsIncludeUnknownTraitsDisabled,
        default = PAMenuDefaults.PAJunk.Weapons.autoMarkUnknownTraits,
    })
end

local function createPAJArmorSubMenu()
    PAJArmorSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T),
        getFunc = PAMenuFunctions.PAJunk.getArmorAutoMarkOrnateSetting,
        setFunc = PAMenuFunctions.PAJunk.setArmorAutoMarkOrnateSetting,
        disabled = PAMenuFunctions.PAJunk.isArmorAutoMarkOrnateDisabled,
        default = PAMenuDefaults.PAJunk.Weapons.autoMarkOrnate,
    })

    PAJArmorSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_ARMOR_AUTOMARK_QUALITY),
        tooltip = GetString(SI_PA_MENU_JUNK_ARMOR_AUTOMARK_QUALITY_T),
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getArmorAutoMarkQualitySetting,
        setFunc = PAMenuFunctions.PAJunk.setArmorAutoMarkQualitySetting,
        disabled = PAMenuFunctions.PAJunk.isArmorAutoMarkQualityDisabled,
        default = PAMenuDefaults.PAJunk.Armor.autoMarkQuality,
    })

    PAJArmorSubMenu:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_JUNK_ARMOR_AUTOMARK_QUALITY_THRESHOLD),
        tooltip = GetString(SI_PA_MENU_JUNK_ARMOR_AUTOMARK_QUALITY_THRESHOLD_T),
        choices = PAMenuChoices.choices.PAJunk.qualityLevel,
        choicesValues = PAMenuChoices.choicesValues.PAJunk.qualityLevel,
        --        choicesTooltips = PAMenuChoices.choicesTooltips.PAJunk.qualityLevel,
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getArmorAutoMarkQualityThresholdSetting,
        setFunc = PAMenuFunctions.PAJunk.setArmorAutoMarkQualityThresholdSetting,
        disabled = PAMenuFunctions.PAJunk.isArmorAutoMarkQualityThresholdDisabled,
        default = PAMenuDefaults.PAJunk.Armor.autoMarkQualityThreshold,
    })

    PAJArmorSubMenu:insert({
        type = "divider",
        alpha = 0.5,
    })

    PAJArmorSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS_T),
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getArmorIncludeSetItemsSetting,
        setFunc = PAMenuFunctions.PAJunk.setArmorIncludeSetItemsSetting,
        disabled = PAMenuFunctions.PAJunk.isArmorIncludeSetItemsDisabled,
        default = PAMenuDefaults.PAJunk.Armor.autoMarkIncludingSets,
    })

    PAJArmorSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T),
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getArmorIncludeUnknownTraitsSetting,
        setFunc = PAMenuFunctions.PAJunk.setArmorIncludeUnknownTraitsSetting,
        disabled = PAMenuFunctions.PAJunk.isArmorIncludeUnknownTraitsDisabled,
        default = PAMenuDefaults.PAJunk.Armor.autoMarkUnknownTraits,
    })
end

local function createPAJJewelrySubMenu()
    PAJJewelrySubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T),
        getFunc = PAMenuFunctions.PAJunk.getJewelryAutoMarkOrnateSetting,
        setFunc = PAMenuFunctions.PAJunk.setJewelryAutoMarkOrnateSetting,
        disabled = PAMenuFunctions.PAJunk.isJewelryAutoMarkOrnateDisabled,
        default = PAMenuDefaults.PAJunk.Weapons.autoMarkOrnate,
    })

    PAJJewelrySubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_JEWELRY_AUTOMARK_QUALITY),
        tooltip = GetString(SI_PA_MENU_JUNK_JEWELRY_AUTOMARK_QUALITY_T),
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getJewelryAutoMarkQualitySetting,
        setFunc = PAMenuFunctions.PAJunk.setJewelryAutoMarkQualitySetting,
        disabled = PAMenuFunctions.PAJunk.isJewelryAutoMarkQualityDisabled,
        default = PAMenuDefaults.PAJunk.Jewelry.autoMarkQuality,
    })

    PAJJewelrySubMenu:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_JUNK_JEWELRY_AUTOMARK_QUALITY_THRESHOLD),
        tooltip = GetString(SI_PA_MENU_JUNK_JEWELRY_AUTOMARK_QUALITY_THRESHOLD_T),
        choices = PAMenuChoices.choices.PAJunk.qualityLevel,
        choicesValues = PAMenuChoices.choicesValues.PAJunk.qualityLevel,
        --        choicesTooltips = PAMenuChoices.choicesTooltips.PAJunk.qualityLevel,
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getJewelryAutoMarkQualityThresholdSetting,
        setFunc = PAMenuFunctions.PAJunk.setJewelryAutoMarkQualityThresholdSetting,
        disabled = PAMenuFunctions.PAJunk.isJewelryAutoMarkQualityThresholdDisabled,
        default = PAMenuDefaults.PAJunk.Jewelry.autoMarkQualityThreshold,
    })

    PAJJewelrySubMenu:insert({
        type = "divider",
        alpha = 0.5,
    })

    PAJJewelrySubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS_T),
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getJewelryIncludeSetItemsSetting,
        setFunc = PAMenuFunctions.PAJunk.setJewelryIncludeSetItemsSetting,
        disabled = PAMenuFunctions.PAJunk.isJewelryIncludeSetItemsDisabled,
        default = PAMenuDefaults.PAJunk.Jewelry.autoMarkIncludingSets,
    })

    PAJJewelrySubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T),
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getJewelryIncludeUnknownTraitsSetting,
        setFunc = PAMenuFunctions.PAJunk.setJewelryIncludeUnknownTraitsSetting,
        disabled = PAMenuFunctions.PAJunk.isJewelryIncludeUnknownTraitsDisabled,
        default = PAMenuDefaults.PAJunk.Jewelry.autoMarkUnknownTraits,
    })
end

-- =================================================================================================================

local function createOptions()
    -- Create and register the General Menu
    createPAGeneralMenu()
    LAM2:RegisterAddonPanel("PersonalAssistantAddonOptions", panelData)
    LAM2:RegisterOptionControls("PersonalAssistantAddonOptions", optionsTable)

    -- Create and register the PAJunk Menu
    if PA.Junk then
        createPAJunkMenu()

        createPAJTrashSubMenu()
        createPAJWeaponsSubMenu()
        createPAJArmorSubMenu()
        createPAJJewelrySubMenu()

        LAM2:RegisterAddonPanel("PersonalAssistantJunkAddonOptions", PAJunkPanelData)
        LAM2:RegisterOptionControls("PersonalAssistantJunkAddonOptions", PAJunkOptionsTable)
    end

    -- Create and register the PALoot Menu
    if PA.Loot then
        createPALootMenu()

        createPALLootRecipesSubmenuTable()
        createPALLootMotifsSubmenuTable()
        createPALLootApparelWeaponsSubmenuTable()

        LAM2:RegisterAddonPanel("PersonalAssistantLootAddonOptions", PALootPanelData)
        LAM2:RegisterOptionControls("PersonalAssistantLootAddonOptions", PALootOptionsTable)
    end

    -- Create and register the PAMail Menu
    if PA.Mail then
        createPAMailMenu()

        LAM2:RegisterAddonPanel("PersonalAssistantMailAddonOptions", PAMailPanelData)
        LAM2:RegisterOptionControls("PersonalAssistantMailAddonOptions", PAMailOptionsTable)
    end

    -- Create and register the PARepair Menu
    if PA.Repair then
        createPARepairMenu()

        createPARGoldSubmenuTable()
        createPARRepairKitSubmenuTable()
        createPARRechargeSubmenuTable()

        LAM2:RegisterAddonPanel("PersonalAssistantRepairAddonOptions", PARepairPanelData)
        LAM2:RegisterOptionControls("PersonalAssistantRepairAddonOptions", PARepairOptionsTable)
    end
end


-- Export
PA.MainMenu = {
    createOptions = createOptions
}
