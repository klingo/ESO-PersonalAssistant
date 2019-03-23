-- Local instances of Global tables --
local PA = PersonalAssistant
local PAR = PA.Repair
local PAEM = PA.EventManager
local PAMF = PA.MenuFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local function getValue(...)
    return PAMF.getValue(PAR.SavedVars, ...)
end

local function setValue(value, ...)
    PAMF.setValue(PAR.SavedVars, value, ...)
end

local function isDisabled(...)
    return PAMF.isDisabled(PAR.SavedVars, ...)
end

-- =================================================================================================================

--------------------------------------------------------------------------
-- PARepair   autoRepairEnabled
---------------------------------
local function setPARepairEnabled(value)
    setValue(value, {"autoRepairEnabled"})
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

-- =================================================================================================================

local PARepairMenuFunctions = {
    getAutoRepairEnabledSetting = function() return getValue({"autoRepairEnabled"}) end,
    setAutoRepairEnabledSetting = setPARepairEnabled,

    -- -----------------------------------------------------------------------------------
    -- REPAIR WITH GOLD
    -- -----------------------------
    isRepairWithGoldMenuDisabled = function() return isDisabled({"autoRepairEnabled"}, {"RepairEquipped", "repairWithGold"}) end,
    isRepairWithGoldDisabled = function() return isDisabled({"autoRepairEnabled"}) end,
    getRepairWithGoldSetting = function() return getValue({"RepairEquipped", "repairWithGold"}) end,
    setRepairWithGoldSetting = function(value) setValue(value, {"RepairEquipped", "repairWithGold"}) end,

    isRepairWithGoldDurabilityThresholdDisabled = function() return isDisabled({"autoRepairEnabled"}, {"RepairEquipped", "repairWithGold"}) end,
    getRepairWithGoldDurabilityThresholdSetting = function() return getValue({"RepairEquipped", "repairWithGoldDurabilityThreshold"}) end,
    setRepairWithGoldDurabilityThresholdSetting = function(value) setValue(value, {"RepairEquipped", "repairWithGoldDurabilityThreshold"}) end,

    -- -----------------------------------------------------------------------------------
    -- REPAIR WITH REPAIR KITS
    -- -----------------------------
    isRepairWithRepairKitMenuDisabled = function() return isDisabled({"autoRepairEnabled"}, {"RepairEquipped", "repairWithRepairKit"}) end,
    isRepairWithRepairKitDisabled = function() return isDisabled({"autoRepairEnabled"}) end,
    getRepairWithRepairKitSetting = function() return getValue({"RepairEquipped", "repairWithRepairKit"}) end,
    setRepairWithRepairKitSetting = function(value) setValue(value, {"RepairEquipped", "repairWithRepairKit"}) end,

    isRepairWithRepairKitDurabilityThresholdDisabled = function() return isDisabled({"autoRepairEnabled"}, {"RepairEquipped", "repairWithRepairKit"}) end,
    getRepairWithRepairKitDurabilityThresholdSetting = function() return getValue({"RepairEquipped", "repairWithRepairKitThreshold"}) end,
    setRepairWithRepairKitDurabilityThresholdSetting = function(value) setValue(value, {"RepairEquipped", "repairWithRepairKitThreshold"}) end,

    --        isRepairWithCrownRepairKitDisabled = function() return isDisabled({"autoRepairEnabled"}) end,
    --        getRepairWithCrownRepairKitSetting = function() return getValue({"RepairEquipped", "repairWithCrownRepairKit"}) end,
    --        setRepairWithCrownRepairKitSetting = function(value) setValue(value, {"RepairEquipped", "repairWithCrownRepairKit"}) end,
    --
    --        isRepairWithCrownRepairKitDurabilityThresholdDisabled = function() return isDisabled({"autoRepairEnabled"}, {"RepairEquipped", "repairWithCrownRepairKit"}) end,
    --        getRepairWithCrownRepairKitDurabilityThresholdSetting = function() return getValue({"RepairEquipped", "repairWithCrownRepairKitThreshold"}) end,
    --        setRepairWithCrownRepairKitDurabilityThresholdSetting = function(value) setValue(value, {"RepairEquipped", "repairWithCrownRepairKitThreshold"}) end,

    isLowRepairKitWarningDisabled = function() return isDisabled({"autoRepairEnabled"}, {"RepairEquipped", "repairWithRepairKit"}) end,
    getLowRepairKitWarningSetting = function() return getValue({"RepairEquipped", "lowRepairKitWarning"}) end,
    setLowRepairKitWarningSetting = function(value) setValue(value, {"RepairEquipped", "lowRepairKitWarning"}) end,

    isLowRepairKitThresholdDisabled = function() return isDisabled({"autoRepairEnabled"}, {"RepairEquipped", "repairWithRepairKit"}, {"RepairEquipped", "lowRepairKitWarning"}) end,
    getLowRepairKitThresholdSetting = function() return getValue({"RepairEquipped", "lowRepairKitThreshold"}) end,
    setLowRepairKitThresholdSetting = function(value) setValue(value, {"RepairEquipped", "lowRepairKitThreshold"}) end,

    -- -----------------------------------------------------------------------------------
    -- RECHARGE WITH SOUL GEMS
    -- -----------------------------
    isRechargeWithSoulGemMenuDisabled = function() return isDisabled({"autoRepairEnabled"}, {"RechargeWeapons", "useSoulGems"}) end,
    isRechargeWithSoulGemDisabled = function() return isDisabled({"autoRepairEnabled"}) end,
    getRechargeWithSoulGemSetting = function() return getValue({"RechargeWeapons", "useSoulGems"}) end,
    setRechargeWithSoulGemSetting = function(value) setValue(value, {"RechargeWeapons", "useSoulGems"}) end,

    isLowSoulGemWarningDisabled = function() return isDisabled({"autoRepairEnabled"}, {"RechargeWeapons", "useSoulGems"}) end,
    getLowSoulGemWarningSetting = function() return getValue({"RechargeWeapons", "lowSoulGemWarning"}) end,
    setLowSoulGemWarningSetting = function(value) setValue(value, {"RechargeWeapons", "lowSoulGemWarning"}) end,

    isLowSoulGemThresholdDisabled = function() return isDisabled({"autoRepairEnabled"}, {"RechargeWeapons", "useSoulGems"}, {"RechargeWeapons", "lowSoulGemWarning"}) end,
    getLowSoulGemThresholdSetting = function() return getValue({"RechargeWeapons", "lowSoulGemThreshold"}) end,
    setLowSoulGemThresholdSetting = function(value) setValue(value, {"RechargeWeapons", "lowSoulGemThreshold"}) end,

    -- -----------------------------------------------------------------------------------
    -- SILENT MODE
    -- -----------------------------
    isSilentModeDisabled = function() return isDisabled({"autoRepairEnabled"}) end,
    getSilentModeSetting = function() return getValue({"silentMode"}) end,
    setSilentModeSetting = function(value) setValue(value, {"silentMode"}) end,

}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PAMF.PARepair = PARepairMenuFunctions