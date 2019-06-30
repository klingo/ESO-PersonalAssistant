-- Local instances of Global tables --
local PA = PersonalAssistant
local PAR = PA.Repair
local PAMF = PA.MenuFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local function getValue(...)
    return PAMF.getValue(PAR.SavedVars, ...)
end

local function setValue(value, ...)
    PAMF.setValue(PAR.SavedVars, value, ...)
end

local function setValueAndRefreshEvents(value, ...)
    PAMF.setValueAndRefreshEvents(PAR.SavedVars, value, ...)
end

local function isDisabled(...)
    return PAMF.isDisabled(PAR.SavedVars, ...)
end

local function isDisabledAll(...)
    return PAMF.isDisabledAll(PAR.SavedVars, ...)
end

-- =================================================================================================================

local PARepairMenuFunctions = {
    -- -----------------------------------------------------------------------------------
    -- REPAIR EQUIPPED
    -- -----------------------------
    getAutoRepairEquippedEnabledSetting = function() return getValue({"autoRepairEnabled"}) end,
    setAutoRepairEquippedEnabledSetting = function(value) setValueAndRefreshEvents(value, {"autoRepairEnabled"}) end,

    -- Repair with Gold --
    isRepairEquippedWithGoldMenuDisabled = function() return isDisabled({"autoRepairEnabled"}, {"RepairEquipped", "repairWithGold"}) end,
    isRepairEquippedWithGoldDisabled = function() return isDisabled({"autoRepairEnabled"}) end,
    getRepairEquippedWithGoldSetting = function() return getValue({"RepairEquipped", "repairWithGold"}) end,
    setRepairEquippedWithGoldSetting = function(value) setValueAndRefreshEvents(value, {"RepairEquipped", "repairWithGold"}) end,

    isRepairEquippedWithGoldDurabilityThresholdDisabled = function() return isDisabled({"autoRepairEnabled"}, {"RepairEquipped", "repairWithGold"}) end,
    getRepairEquippedWithGoldDurabilityThresholdSetting = function() return getValue({"RepairEquipped", "repairWithGoldDurabilityThreshold"}) end,
    setRepairEquippedWithGoldDurabilityThresholdSetting = function(value) setValue(value, {"RepairEquipped", "repairWithGoldDurabilityThreshold"}) end,

    -- Repair with Repair Kits --
    isRepairWithRepairKitMenuDisabled = function() return isDisabled({"autoRepairEnabled"}, {"RepairEquipped", "repairWithRepairKit"}) end,
    isRepairWithRepairKitDisabled = function() return isDisabled({"autoRepairEnabled"}) end,
    getRepairWithRepairKitSetting = function() return getValue({"RepairEquipped", "repairWithRepairKit"}) end,
    setRepairWithRepairKitSetting = function(value) setValueAndRefreshEvents(value, {"RepairEquipped", "repairWithRepairKit"}) end,

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

    -- Recharge with Soul Gems --
    isRechargeWithSoulGemMenuDisabled = function() return isDisabled({"autoRepairEnabled"}, {"RechargeWeapons", "useSoulGems"}) end,
    isRechargeWithSoulGemDisabled = function() return isDisabled({"autoRepairEnabled"}) end,
    getRechargeWithSoulGemSetting = function() return getValue({"RechargeWeapons", "useSoulGems"}) end,
    setRechargeWithSoulGemSetting = function(value) setValueAndRefreshEvents(value, {"RechargeWeapons", "useSoulGems"}) end,

    isLowSoulGemWarningDisabled = function() return isDisabled({"autoRepairEnabled"}, {"RechargeWeapons", "useSoulGems"}) end,
    getLowSoulGemWarningSetting = function() return getValue({"RechargeWeapons", "lowSoulGemWarning"}) end,
    setLowSoulGemWarningSetting = function(value) setValue(value, {"RechargeWeapons", "lowSoulGemWarning"}) end,

    isLowSoulGemThresholdDisabled = function() return isDisabled({"autoRepairEnabled"}, {"RechargeWeapons", "useSoulGems"}, {"RechargeWeapons", "lowSoulGemWarning"}) end,
    getLowSoulGemThresholdSetting = function() return getValue({"RechargeWeapons", "lowSoulGemThreshold"}) end,
    setLowSoulGemThresholdSetting = function(value) setValue(value, {"RechargeWeapons", "lowSoulGemThreshold"}) end,


    -- -----------------------------------------------------------------------------------
    -- REPAIR INVENTORY
    -- -----------------------------
    getAutoRepairInventoryEnabledSetting = function() return getValue({"autoRepairInventoryEnabled"}) end,
    setAutoRepairInventoryEnabledSetting = function(value) setValueAndRefreshEvents(value, {"autoRepairInventoryEnabled"}) end,

    -- Repair with Gold --
    isRepairInventoryWithGoldMenuDisabled = function() return isDisabled({"autoRepairInventoryEnabled"}, {"RepairInventory", "repairWithGold"}) end,
    isRepairInventoryWithGoldDisabled = function() return isDisabled({"autoRepairInventoryEnabled"}) end,
    getRepairInventoryWithGoldSetting = function() return getValue({"RepairInventory", "repairWithGold"}) end,
    setRepairInventoryWithGoldSetting = function(value) setValueAndRefreshEvents(value, {"RepairInventory", "repairWithGold"}) end,

    isRepairInventoryWithGoldDurabilityThresholdDisabled = function() return isDisabled({"autoRepairInventoryEnabled"}, {"RepairInventory", "repairWithGold"}) end,
    getRepairInventoryWithGoldDurabilityThresholdSetting = function() return getValue({"RepairInventory", "repairWithGoldDurabilityThreshold"}) end,
    setRepairInventoryWithGoldDurabilityThresholdSetting = function(value) setValue(value, {"RepairInventory", "repairWithGoldDurabilityThreshold"}) end,


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