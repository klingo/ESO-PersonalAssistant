-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACAddon = PAC.ADDON
local PARMenuChoices = PA.MenuChoices.choices.PARepair
local PARMenuChoicesValues = PA.MenuChoices.choicesValues.PARepair
local PARProfileManager = PA.ProfileManager.PARepair
local PARMenuDefaults = PA.MenuDefaults.PARepair
local PARMenuFunctions = PA.MenuFunctions.PARepair

-- =====================================================================================================================

-- Create the LibAddonMenu2 object
PA.LAM2 = PA.LAM2 or LibAddonMenu2 or LibStub("LibAddonMenu-2.0")

local PARepairPanelData = {
    type = "panel",
    name = PACAddon.NAME_RAW.REPAIR,
    displayName = PACAddon.NAME_DISPLAY.REPAIR,
    author = PACAddon.AUTHOR,
    version = PACAddon.VERSION_DISPLAY,
    website = PACAddon.WEBSITE,
    feedback = PACAddon.FEEDBACK,
    keywords = PACAddon.KEYWORDS.REPAIR,
    slashCommand = "/par",
    registerForRefresh = true,
    registerForDefaults = true,
}

local PARepairOptionsTable = setmetatable({}, { __index = table })
local PARepairProfileSubMenuTable = setmetatable({}, { __index = table })

local PARGoldEquippedSubmenuTable = setmetatable({}, { __index = table })
local PARRepairKitSubmenuTable = setmetatable({}, { __index = table })
local PARRechargeSubmenuTable = setmetatable({}, { __index = table })

local PARGoldInventorySubmenuTable = setmetatable({}, { __index = table })

-- =================================================================================================================

local function _createPARepairMenu()
    PARepairOptionsTable:insert({
        type = "submenu",
        name = PARProfileManager.getProfileSubMenuHeader,
        controls = PARepairProfileSubMenuTable
    })

    PARepairOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_REPAIR_DESCRIPTION),
    })

    PARepairOptionsTable:insert({
        type = "header",
        name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_REPAIR_EQUIPPED_HEADER))
    })

    PARepairOptionsTable:insert({
        type = "checkbox",
        name = PAC.COLOR.LIGHT_BLUE:Colorize(GetString(SI_PA_MENU_REPAIR_ENABLE)),
        getFunc = PARMenuFunctions.getAutoRepairEquippedEnabledSetting,
        setFunc = PARMenuFunctions.setAutoRepairEquippedEnabledSetting,
        disabled = PARProfileManager.isNoProfileSelected,
        default = PARMenuDefaults.autoRepairEnabled,
    })

    PARepairOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_REPAIR_GOLD_HEADER),
        icon = ZO_CURRENCIES_DATA[CURT_MONEY].keyboardTexture,
        controls = PARGoldEquippedSubmenuTable,
        disabledLabel = PARMenuFunctions.isRepairEquippedWithGoldMenuDisabled,
    })

    PARepairOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_HEADER),
        icon = PAC.ICONS.ITEMS.REPAIRKIT.PATH,
        controls = PARRepairKitSubmenuTable,
        disabledLabel = PARMenuFunctions.isRepairWithRepairKitMenuDisabled,
    })

    PARepairOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_REPAIR_RECHARGE_HEADER),
        icon = PAC.ICONS.ITEMS.SOULGEM.PATH,
        controls = PARRechargeSubmenuTable,
        disabledLabel = PARMenuFunctions.isRechargeWithSoulGemMenuDisabled,
    })

    -- ---------------------------------------------------------------------------------------------------------

    PARepairOptionsTable:insert({
        type = "header",
        name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_REPAIR_INVENTORY_HEADER))
    })

    PARepairOptionsTable:insert({
        type = "checkbox",
        name = PAC.COLOR.LIGHT_BLUE:Colorize(GetString(SI_PA_MENU_REPAIR_INVENTORY_ENABLE)),
        getFunc = PARMenuFunctions.getAutoRepairInventoryEnabledSetting,
        setFunc = PARMenuFunctions.setAutoRepairInventoryEnabledSetting,
        disabled = PARProfileManager.isNoProfileSelected,
        default = PARMenuDefaults.autoRepairInventoryEnabled,
    })

    PARepairOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_REPAIR_GOLD_HEADER),
        icon = ZO_CURRENCIES_DATA[CURT_MONEY].keyboardTexture,
        controls = PARGoldInventorySubmenuTable,
        disabledLabel = PARMenuFunctions.isRepairInventoryWithGoldMenuDisabled,
    })

    -- ---------------------------------------------------------------------------------------------------------

    PARepairOptionsTable:insert({
        type = "header",
        name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_OTHER_SETTINGS_HEADER))
    })

    PARepairOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_SILENT_MODE),
        getFunc = PARMenuFunctions.getSilentModeSetting,
        setFunc = PARMenuFunctions.setSilentModeSetting,
        disabled = PARMenuFunctions.isSilentModeDisabled,
        default = PARMenuDefaults.silentMode,
    })
end

-- =================================================================================================================

local function _createPARepairProfileSubMenuTable()
    PARepairProfileSubMenuTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_PROFILE_ACTIVE),
        tooltip = GetString(SI_PA_MENU_PROFILE_ACTIVE_T),
        choices = PARProfileManager.getProfileList(),
        choicesValues = PARProfileManager.getProfileListValues(),
        width = "half",
        getFunc = PARProfileManager.getActiveProfile,
        setFunc = PARProfileManager.setActiveProfile,
        reference = "PERSONALASSISTANT_REPAIR_PROFILEDROPDOWN"
    })

    PARepairProfileSubMenuTable:insert({
        type = "editbox",
        name = GetString(SI_PA_MENU_PROFILE_ACTIVE_RENAME),
        maxChars = 40,
        width = "half",
        getFunc = PARProfileManager.getActiveProfileName,
        setFunc = PARProfileManager.setActiveProfileName,
        disabled = PARProfileManager.isNoProfileSelected
    })

    PARepairProfileSubMenuTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_PROFILE_CREATE_NEW),
        width = "half",
        func = PARProfileManager.createNewProfile,
        disabled = PARProfileManager.hasMaxProfileCountReached
    })

    PARepairProfileSubMenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_PROFILE_CREATE_NEW_DESC),
        disabled = function() return not PARProfileManager.hasMaxProfileCountReached() end
    })

    PARepairProfileSubMenuTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PARepairProfileSubMenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_PROFILE_COPY_FROM_DESC),
        disabled = function() return PARProfileManager.hasOnlyOneProfile() or PARProfileManager.isNoProfileSelected() end,
    })

    PARepairProfileSubMenuTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_PROFILE_COPY_FROM),
        choices = PARProfileManager.getInactiveProfileList(),
        choicesValues = PARProfileManager.getInactiveProfileListValues(),
        width = "half",
        getFunc = function() return PA.Repair.selectedCopyProfile end,
        setFunc = function(value) PA.Repair.selectedCopyProfile = value end,
        disabled = function() return PARProfileManager.hasOnlyOneProfile() or PARProfileManager.isNoProfileSelected() end,
        reference = "PERSONALASSISTANT_REPAIR_PROFILEDROPDOWN_COPY"
    })

    PARepairProfileSubMenuTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM),
        width = "half",
        func = PARProfileManager.copySelectedProfile,
        isDangerous = true,
        warning = GetString(SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM_W),
        disabled = PARProfileManager.isNoCopyProfileSelected
    })

    PARepairProfileSubMenuTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PARepairProfileSubMenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_PROFILE_DELETE_DESC),
        disabled = PARProfileManager.hasOnlyOneProfile
    })

    PARepairProfileSubMenuTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_PROFILE_DELETE),
        choices = PARProfileManager.getInactiveProfileList(),
        choicesValues = PARProfileManager.getInactiveProfileListValues(),
        width = "half",
        getFunc = function() return PA.Repair.selectedDeleteProfile end,
        setFunc = function(value) PA.Repair.selectedDeleteProfile = value end,
        disabled = PARProfileManager.hasOnlyOneProfile,
        reference = "PERSONALASSISTANT_REPAIR_PROFILEDROPDOWN_DELETE"
    })

    PARepairProfileSubMenuTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_PROFILE_DELETE_CONFIRM),
        width = "half",
        func = PARProfileManager.deleteSelectedProfile,
        isDangerous = true,
        warning = GetString(SI_PA_MENU_PROFILE_DELETE_CONFIRM_W),
        disabled = PARProfileManager.isNoDeleteProfileSelected
    })
end

-- =================================================================================================================

local function _createPARGoldSubmenuTable()
    PARGoldEquippedSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_REPAIR_GOLD_ENABLE),
        tooltip = GetString(SI_PA_MENU_REPAIR_GOLD_ENABLE_T),
        getFunc = PARMenuFunctions.getRepairEquippedWithGoldSetting,
        setFunc = PARMenuFunctions.setRepairEquippedWithGoldSetting,
        disabled = PARMenuFunctions.isRepairEquippedWithGoldDisabled,
        default = PARMenuDefaults.RepairEquipped.repairWithGold,
    })

    PARGoldEquippedSubmenuTable:insert({
        type = "slider",
        name = GetString(SI_PA_MENU_REPAIR_GOLD_DURABILITY),
        tooltip = GetString(SI_PA_MENU_REPAIR_GOLD_DURABILITY_T),
        min = 0,
        max = 99,
        step = 1,
        getFunc = PARMenuFunctions.getRepairEquippedWithGoldDurabilityThresholdSetting,
        setFunc = PARMenuFunctions.setRepairEquippedWithGoldDurabilityThresholdSetting,
        disabled = PARMenuFunctions.isRepairEquippedWithGoldDurabilityThresholdDisabled,
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
        type = "dropdown",
        name = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_DEFAULT_KIT),
        tooltip = GetString(SI_PA_MENU_REPAIR_REPAIRKIT_DEFAULT_KIT_T),
        choices = PARMenuChoices.defaultRepairKit,
        choicesValues = PARMenuChoicesValues.defaultRepairKit,
        getFunc = PARMenuFunctions.getRepairDefaultRepairKitSetting,
        setFunc = PARMenuFunctions.setRepairDefaultRepairKitSetting,
        disabled = PARMenuFunctions.isRepairDefaultRepairKitDisabled,
        default = PARMenuDefaults.RepairEquipped.defaultRepairKit,
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
        default = PARMenuDefaults.RepairEquipped.lowRepairKitThreshold,
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
        type = "dropdown",
        name = GetString(SI_PA_MENU_REPAIR_RECHARGE_DEFAULT_GEM),
        tooltip = GetString(SI_PA_MENU_REPAIR_RECHARGE_DEFAULT_GEM_T),
        choices = PARMenuChoices.defaultSoulGem,
        choicesValues = PARMenuChoicesValues.defaultSoulGem,
        getFunc = PARMenuFunctions.getRechargeDefaultSoulGemSetting,
        setFunc = PARMenuFunctions.setRechargeDefaultSoulGemSetting,
        disabled = PARMenuFunctions.isRechargeDefaultSoulGemDisabled,
        default = PARMenuDefaults.RechargeWeapons.defaultSoulGem,
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

-- -----------------------------------------------------------------------------------------------------------------

local function _createPARGoldInventorySubmenuTable()
    PARGoldInventorySubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_REPAIR_GOLD_INVENTORY_ENABLE),
        tooltip = GetString(SI_PA_MENU_REPAIR_GOLD_INVENTORY_ENABLE_T),
        getFunc = PARMenuFunctions.getRepairInventoryWithGoldSetting,
        setFunc = PARMenuFunctions.setRepairInventoryWithGoldSetting,
        disabled = PARMenuFunctions.isRepairInventoryWithGoldDisabled,
        default = PARMenuDefaults.RepairInventory.repairWithGold,
    })

    PARGoldInventorySubmenuTable:insert({
        type = "slider",
        name = GetString(SI_PA_MENU_REPAIR_GOLD_INVENTORY_DURABILITY),
        tooltip = GetString(SI_PA_MENU_REPAIR_GOLD_INVENTORY_DURABILITY_T),
        min = 0,
        max = 99,
        step = 1,
        getFunc = PARMenuFunctions.getRepairInventoryWithGoldDurabilityThresholdSetting,
        setFunc = PARMenuFunctions.setRepairInventoryWithGoldDurabilityThresholdSetting,
        disabled = PARMenuFunctions.isRepairInventoryWithGoldDurabilityThresholdDisabled,
        default = PARMenuDefaults.RepairInventory.repairWithGoldDurabilityThreshold,
    })
end

-- =================================================================================================================

local function createOptions()
    _createPARepairMenu()

    _createPARepairProfileSubMenuTable()

    _createPARGoldSubmenuTable()
    _createPARRepairKitSubmenuTable()
    _createPARRechargeSubmenuTable()

    _createPARGoldInventorySubmenuTable()

    PA.LAM2:RegisterAddonPanel("PersonalAssistantRepairAddonOptions", PARepairPanelData)
    PA.LAM2:RegisterOptionControls("PersonalAssistantRepairAddonOptions", PARepairOptionsTable)
end

-- =====================================================================================================================
-- Export
PA.Repair = PA.Repair or {}
PA.Repair.createOptions = createOptions
