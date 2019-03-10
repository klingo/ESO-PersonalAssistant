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
local PALootOptionsTable = setmetatable({}, { __index = table })
local PAMailOptionsTable = setmetatable({}, { __index = table })
local PARepairOptionsTable = setmetatable({}, { __index = table })

local PARGoldSubmenuTable = setmetatable({}, { __index = table })
local PARRepairKitSubmenuTable = setmetatable({}, { __index = table })
local PARRechargeSubmenuTable = setmetatable({}, { __index = table })

local PALLootRecipesSubmenuTable = setmetatable({}, { __index = table })
local PALLootMotifsSubmenuTable = setmetatable({}, { __index = table })
local PALLootApparelWeaponsSubmenuTable = setmetatable({}, { __index = table })

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

local function createOptions()
    -- Create and register the General Menu
    createPAGeneralMenu()
    LAM2:RegisterAddonPanel("PersonalAssistantAddonOptions", panelData)
    LAM2:RegisterOptionControls("PersonalAssistantAddonOptions", optionsTable)

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
