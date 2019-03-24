-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PARMenuFunctions = PA.MenuFunctions.PARepair
local PARMenuDefaults = PA.MenuDefaults.PARepair

local LAM2 = LibStub("LibAddonMenu-2.0")

local PARepairPanelData = {
    type = "panel",
    name = "PersonalAssistant Repair",
    displayName = GetString(SI_PA_MENU_TITLE),
    author = "Klingo",
    version = PAC.ADDON_VERSION,
    website = "http://www.esoui.com/downloads/info381-PersonalAssistant",
    slashCommand = "/par",
    registerForRefresh = true,
    registerForDefaults = true,
}

local PARepairOptionsTable = setmetatable({}, { __index = table })

local PARGoldSubmenuTable = setmetatable({}, { __index = table })
local PARRepairKitSubmenuTable = setmetatable({}, { __index = table })
local PARRechargeSubmenuTable = setmetatable({}, { __index = table })

-- =================================================================================================================

local function _createPARepairMenu()
    PARepairOptionsTable:insert({
        type = "header",
        name = GetString(SI_PA_MENU_REPAIR_HEADER)
    })

    PARepairOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_REPAIR_DESCRIPTION),
    })

    PARepairOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_REPAIR_ENABLE),
        getFunc = PARMenuFunctions.getAutoRepairEnabledSetting,
        setFunc = PARMenuFunctions.setAutoRepairEnabledSetting,
        disabled = PA.MenuFunctions.PAGeneral.isNoProfileSelected,
        default = PARMenuDefaults.autoRepairEnabled,
    })

    PARepairOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_REPAIR_GOLD_HEADER),
        controls = PARGoldSubmenuTable,
        disabled = PARMenuFunctions.isRepairWithGoldMenuDisabled,
    })

    PARepairOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_HEADER),
        controls = PARRepairKitSubmenuTable,
        disabled = PARMenuFunctions.isRepairWithRepairKitMenuDisabled,
    })

    PARepairOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_REPAIR_RECHARGE_HEADER),
        controls = PARRechargeSubmenuTable,
        disabled = PARMenuFunctions.isRechargeWithSoulGemMenuDisabled,
    })

    PARepairOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_SILENT_MODE),
        tooltip = GetString(SI_PA_MENU_SILENT_MODE_T),
        getFunc = PARMenuFunctions.getSilentModeSetting,
        setFunc = PARMenuFunctions.setSilentModeSetting,
        disabled = PARMenuFunctions.isSilentModeDisabled,
        default = PARMenuDefaults.silentMode,
    })
end

-- =================================================================================================================

local function _createPARGoldSubmenuTable()
    PARGoldSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_REPAIR_GOLD_ENABLE),
        tooltip = GetString(SI_PA_MENU_REPAIR_GOLD_ENABLE_T),
        getFunc = PARMenuFunctions.getRepairWithGoldSetting,
        setFunc = PARMenuFunctions.setRepairWithGoldSetting,
        disabled = PARMenuFunctions.isRepairWithGoldDisabled,
        default = PARMenuDefaults.RepairEquipped.repairWithGold,
    })

    PARGoldSubmenuTable:insert({
        type = "slider",
        name = GetString(SI_PA_MENU_REPAIR_GOLD_DURABILITY),
        tooltip = GetString(SI_PA_MENU_REPAIR_GOLD_DURABILITY_T),
        min = 0,
        max = 99,
        step = 1,
        getFunc = PARMenuFunctions.getRepairWithGoldDurabilityThresholdSetting,
        setFunc = PARMenuFunctions.setRepairWithGoldDurabilityThresholdSetting,
        disabled = PARMenuFunctions.isRepairWithGoldDurabilityThresholdDisabled,
        default = PARMenuDefaults.RepairEquipped.repairWithGoldDurabilityThreshold,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPARRepairKitSubmenuTable()
    PARRepairKitSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE),
        tooltip = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE_T),
        getFunc = PARMenuFunctions.getRepairWithRepairKitSetting,
        setFunc = PARMenuFunctions.setRepairWithRepairKitSetting,
        disabled = PARMenuFunctions.isRepairWithRepairKitDisabled,
        default = PARMenuDefaults.RepairEquipped.repairWithRepairKit,
    })

    PARRepairKitSubmenuTable:insert({
        type = "slider",
        name = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY),
        tooltip = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY_T),
        min = 0,
        max = 99,
        step = 1,
        getFunc = PARMenuFunctions.getRepairWithRepairKitDurabilityThresholdSetting,
        setFunc = PARMenuFunctions.setRepairWithRepairKitDurabilityThresholdSetting,
        disabled = PARMenuFunctions.isRepairWithRepairKitDurabilityThresholdDisabled,
        default = PARMenuDefaults.RepairEquipped.repairWithRepairKitThreshold,
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
    --        getFunc = PARMenuFunctions.getRepairWithCrownRepairKitSetting,
    --        setFunc = PARMenuFunctions.setRepairWithCrownRepairKitSetting,
    --        disabled = PARMenuFunctions.isRepairWithCrownRepairKitDisabled,
    --        default = PARMenuDefaults.RepairEquipped.repairWithCrownRepairKit,
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
    --        getFunc = PARMenuFunctions.getRepairWithCrownRepairKitDurabilityThresholdSetting,
    --        setFunc = PARMenuFunctions.setRepairWithCrownRepairKitDurabilityThresholdSetting,
    --        disabled = PARMenuFunctions.isRepairWithCrownRepairKitDurabilityThresholdDisabled,
    --        default = PARMenuDefaults.RepairEquipped.repairWithCrownRepairKitThreshold,
    --    })

    PARRepairKitSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING),
        tooltip = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING_T),
        width = "half",
        getFunc = PARMenuFunctions.getLowRepairKitWarningSetting,
        setFunc = PARMenuFunctions.setLowRepairKitWarningSetting,
        disabled = PARMenuFunctions.isLowRepairKitWarningDisabled,
        default = PARMenuDefaults.RepairEquipped.lowRepairKitWarning,
    })

    PARRepairKitSubmenuTable:insert({
        type = "slider",
        name = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD),
        tooltip = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD_T),
        min = 0,
        max = 200,
        step = 1,
        width = "half",
        getFunc = PARMenuFunctions.getLowRepairKitThresholdSetting,
        setFunc = PARMenuFunctions.setLowRepairKitThresholdSetting,
        disabled = PARMenuFunctions.isLowRepairKitThresholdDisabled,
        default = PARMenuDefaults.RechargeWeapons.lowRepairKitThreshold,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPARRechargeSubmenuTable()
    PARRechargeSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_REPAIR_RECHARGE_ENABLE),
        tooltip = GetString(SI_PA_MENU_REPAIR_RECHARGE_ENABLE_T),
        getFunc = PARMenuFunctions.getRechargeWithSoulGemSetting,
        setFunc = PARMenuFunctions.setRechargeWithSoulGemSetting,
        disabled = PARMenuFunctions.isRechargeWithSoulGemDisabled,
        default = PARMenuDefaults.RechargeWeapons.useSoulGems,
    })

    PARRechargeSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING),
        tooltip = GetString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING_T),
        width = "half",
        getFunc = PARMenuFunctions.getLowSoulGemWarningSetting,
        setFunc = PARMenuFunctions.setLowSoulGemWarningSetting,
        disabled = PARMenuFunctions.isLowSoulGemWarningDisabled,
        default = PARMenuDefaults.RechargeWeapons.lowSoulGemWarning,
    })

    PARRechargeSubmenuTable:insert({
        type = "slider",
        name = GetString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD),
        tooltip = GetString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD_T),
        min = 0,
        max = 200,
        step = 1,
        width = "half",
        getFunc = PARMenuFunctions.getLowSoulGemThresholdSetting,
        setFunc = PARMenuFunctions.setLowSoulGemThresholdSetting,
        disabled = PARMenuFunctions.isLowSoulGemThresholdDisabled,
        default = PARMenuDefaults.RechargeWeapons.lowSoulGemThreshold,
    })
end

-- =================================================================================================================

local function createOptions()
    _createPARepairMenu()

    _createPARGoldSubmenuTable()
    _createPARRepairKitSubmenuTable()
    _createPARRechargeSubmenuTable()

    LAM2:RegisterAddonPanel("PersonalAssistantRepairAddonOptions", PARepairPanelData)
    LAM2:RegisterOptionControls("PersonalAssistantRepairAddonOptions", PARepairOptionsTable)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Repair = PA.Repair or {}
PA.Repair.createOptions = createOptions
