-- Local instances of Global tables --
local PA = PersonalAssistant
local PAR = PA.Repair
local PAEM = PA.EventManager
local PAMF = PA.MenuFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local getValue = PAMF.getValue
local setValue = PAMF.setValue
local isDisabled = PAMF.isDisabled

-- =================================================================================================================

--------------------------------------------------------------------------
-- PARepair   autoRepairEnabled
---------------------------------
local function setPARepairEnabled(value)
    setValue(PAR.SavedVars, value, {"autoRepairEnabled"})
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

-- =================================================================================================================

local PARepairMenuFunctions = {
    getAutoRepairEnabledSetting = function() return getValue(PAR.SavedVars, {"autoRepairEnabled"}) end,
    setAutoRepairEnabledSetting = setPARepairEnabled,

    isChatOutputDisabled = function() return isDisabled(PAR.SavedVars, {"autoRepairEnabled"}) end,
    getChatOutputSetting = function() return getValue(PAR.SavedVars, {"chatOutput"}) end,
    setChatOutputSetting = function(value) setValue(PAR.SavedVars, value, {"chatOutput"}) end,

    -- -----------------------------------------------------------------------------------
    -- REPAIR WITH GOLD
    -- -----------------------------
    isRepairWithGoldMenuDisabled = function() return isDisabled(PAR.SavedVars, {"autoRepairEnabled"}, {"RepairEquipped", "repairWithGold"}) end,
    isRepairWithGoldDisabled = function() return isDisabled(PAR.SavedVars, {"autoRepairEnabled"}) end,
    getRepairWithGoldSetting = function() return getValue(PAR.SavedVars, {"RepairEquipped", "repairWithGold"}) end,
    setRepairWithGoldSetting = function(value) setValue(PAR.SavedVars, value, {"RepairEquipped", "repairWithGold"}) end,

    isRepairWithGoldDurabilityThresholdDisabled = function() return isDisabled(PAR.SavedVars, {"autoRepairEnabled"}, {"RepairEquipped", "repairWithGold"}) end,
    getRepairWithGoldDurabilityThresholdSetting = function() return getValue(PAR.SavedVars, {"RepairEquipped", "repairWithGoldDurabilityThreshold"}) end,
    setRepairWithGoldDurabilityThresholdSetting = function(value) setValue(PAR.SavedVars, value, {"RepairEquipped", "repairWithGoldDurabilityThreshold"}) end,

    -- -----------------------------------------------------------------------------------
    -- REPAIR WITH REPAIR KITS
    -- -----------------------------
    isRepairWithRepairKitMenuDisabled = function() return isDisabled(PAR.SavedVars, {"autoRepairEnabled"}, {"RepairEquipped", "repairWithRepairKit"}) end,
    isRepairWithRepairKitDisabled = function() return isDisabled(PAR.SavedVars, {"autoRepairEnabled"}) end,
    getRepairWithRepairKitSetting = function() return getValue(PAR.SavedVars, {"RepairEquipped", "repairWithRepairKit"}) end,
    setRepairWithRepairKitSetting = function(value) setValue(PAR.SavedVars, value, {"RepairEquipped", "repairWithRepairKit"}) end,

    isRepairWithRepairKitDurabilityThresholdDisabled = function() return isDisabled(PAR.SavedVars, {"autoRepairEnabled"}, {"RepairEquipped", "repairWithRepairKit"}) end,
    getRepairWithRepairKitDurabilityThresholdSetting = function() return getValue(PAR.SavedVars, {"RepairEquipped", "repairWithRepairKitThreshold"}) end,
    setRepairWithRepairKitDurabilityThresholdSetting = function(value) setValue(PAR.SavedVars, value, {"RepairEquipped", "repairWithRepairKitThreshold"}) end,

    --        isRepairWithCrownRepairKitDisabled = function() return isDisabled(PAR.SavedVars, {"autoRepairEnabled"}) end,
    --        getRepairWithCrownRepairKitSetting = function() return getValue(PAR.SavedVars, {"RepairEquipped", "repairWithCrownRepairKit"}) end,
    --        setRepairWithCrownRepairKitSetting = function(value) setValue(PAR.SavedVars, value, {"RepairEquipped", "repairWithCrownRepairKit"}) end,
    --
    --        isRepairWithCrownRepairKitDurabilityThresholdDisabled = function() return isDisabled(PAR.SavedVars, {"autoRepairEnabled"}, {"RepairEquipped", "repairWithCrownRepairKit"}) end,
    --        getRepairWithCrownRepairKitDurabilityThresholdSetting = function() return getValue(PAR.SavedVars, {"RepairEquipped", "repairWithCrownRepairKitThreshold"}) end,
    --        setRepairWithCrownRepairKitDurabilityThresholdSetting = function(value) setValue(PAR.SavedVars, value, {"RepairEquipped", "repairWithCrownRepairKitThreshold"}) end,

    --        isLowRepairKitWarningDisabled = function() return isDisabled(PAR.SavedVars, {"autoRepairEnabled"}, {"RepairEquipped", "repairWithRepairKit"}, {"RepairEquipped", "repairWithCrownRepairKit"}) end,
    isLowRepairKitWarningDisabled = function() return isDisabled(PAR.SavedVars, {"autoRepairEnabled"}, {"RepairEquipped", "repairWithRepairKit"}) end,
    getLowRepairKitWarningSetting = function() return getValue(PAR.SavedVars, {"RepairEquipped", "lowRepairKitWarning"}) end,
    setLowRepairKitWarningSetting = function(value) setValue(PAR.SavedVars, value, {"RepairEquipped", "lowRepairKitWarning"}) end,

    -- TODO: Chat Mode

    -- -----------------------------------------------------------------------------------
    -- RECHARGE WITH SOUL GEMS
    -- -----------------------------
    isRechargeWithSoulGemMenuDisabled = function() return isDisabled(PAR.SavedVars, {"autoRepairEnabled"}, {"RechargeWeapons", "useSoulGems"}) end,
    isRechargeWithSoulGemDisabled = function() return isDisabled(PAR.SavedVars, {"autoRepairEnabled"}) end,
    getRechargeWithSoulGemSetting = function() return getValue(PAR.SavedVars, {"RechargeWeapons", "useSoulGems"}) end,
    setRechargeWithSoulGemSetting = function(value) setValue(PAR.SavedVars, value, {"RechargeWeapons", "useSoulGems"}) end,

    isLowSoulGemWarningDisabled = function() return isDisabled(PAR.SavedVars, {"autoRepairEnabled"}, {"RechargeWeapons", "useSoulGems"}) end,
    getLowSoulGemWarningSetting = function() return getValue(PAR.SavedVars, {"RechargeWeapons", "lowSoulGemWarning"}) end,
    setLowSoulGemWarningSetting = function(value) setValue(PAR.SavedVars, value, {"RechargeWeapons", "lowSoulGemWarning"}) end,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PAMF.PARepair = PARepairMenuFunctions