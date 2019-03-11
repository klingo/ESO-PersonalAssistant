-- Local instances of Global tables --
local PA = PersonalAssistant
local PASV = PA.SavedVars
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
    setValue(PASV.Repair, value, {"autoRepairEnabled"})
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

-- =================================================================================================================

local PARepairMenuFunctions = {
    getAutoRepairEnabledSetting = function() return getValue(PASV.Repair, {"autoRepairEnabled"}) end,
    setAutoRepairEnabledSetting = setPARepairEnabled,

    isChatOutputDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}) end,
    getChatOutputSetting = function() return getValue(PASV.Repair, {"chatOutput"}) end,
    setChatOutputSetting = function(value) setValue(PASV.Repair, value, {"chatOutput"}) end,

    -- -----------------------------------------------------------------------------------
    -- REPAIR WITH GOLD
    -- -----------------------------
    isRepairWithGoldMenuDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}, {"RepairEquipped", "repairWithGold"}) end,
    isRepairWithGoldDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}) end,
    getRepairWithGoldSetting = function() return getValue(PASV.Repair, {"RepairEquipped", "repairWithGold"}) end,
    setRepairWithGoldSetting = function(value) setValue(PASV.Repair, value, {"RepairEquipped", "repairWithGold"}) end,

    isRepairWithGoldDurabilityThresholdDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}, {"RepairEquipped", "repairWithGold"}) end,
    getRepairWithGoldDurabilityThresholdSetting = function() return getValue(PASV.Repair, {"RepairEquipped", "repairWithGoldDurabilityThreshold"}) end,
    setRepairWithGoldDurabilityThresholdSetting = function(value) setValue(PASV.Repair, value, {"RepairEquipped", "repairWithGoldDurabilityThreshold"}) end,

    -- -----------------------------------------------------------------------------------
    -- REPAIR WITH REPAIR KITS
    -- -----------------------------
    isRepairWithRepairKitMenuDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}, {"RepairEquipped", "repairWithRepairKit"}) end,
    isRepairWithRepairKitDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}) end,
    getRepairWithRepairKitSetting = function() return getValue(PASV.Repair, {"RepairEquipped", "repairWithRepairKit"}) end,
    setRepairWithRepairKitSetting = function(value) setValue(PASV.Repair, value, {"RepairEquipped", "repairWithRepairKit"}) end,

    isRepairWithRepairKitDurabilityThresholdDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}, {"RepairEquipped", "repairWithRepairKit"}) end,
    getRepairWithRepairKitDurabilityThresholdSetting = function() return getValue(PASV.Repair, {"RepairEquipped", "repairWithRepairKitThreshold"}) end,
    setRepairWithRepairKitDurabilityThresholdSetting = function(value) setValue(PASV.Repair, value, {"RepairEquipped", "repairWithRepairKitThreshold"}) end,

    --        isRepairWithCrownRepairKitDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}) end,
    --        getRepairWithCrownRepairKitSetting = function() return getValue(PASV.Repair, {"RepairEquipped", "repairWithCrownRepairKit"}) end,
    --        setRepairWithCrownRepairKitSetting = function(value) setValue(PASV.Repair, value, {"RepairEquipped", "repairWithCrownRepairKit"}) end,
    --
    --        isRepairWithCrownRepairKitDurabilityThresholdDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}, {"RepairEquipped", "repairWithCrownRepairKit"}) end,
    --        getRepairWithCrownRepairKitDurabilityThresholdSetting = function() return getValue(PASV.Repair, {"RepairEquipped", "repairWithCrownRepairKitThreshold"}) end,
    --        setRepairWithCrownRepairKitDurabilityThresholdSetting = function(value) setValue(PASV.Repair, value, {"RepairEquipped", "repairWithCrownRepairKitThreshold"}) end,

    --        isLowRepairKitWarningDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}, {"RepairEquipped", "repairWithRepairKit"}, {"RepairEquipped", "repairWithCrownRepairKit"}) end,
    isLowRepairKitWarningDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}, {"RepairEquipped", "repairWithRepairKit"}) end,
    getLowRepairKitWarningSetting = function() return getValue(PASV.Repair, {"RepairEquipped", "lowRepairKitWarning"}) end,
    setLowRepairKitWarningSetting = function(value) setValue(PASV.Repair, value, {"RepairEquipped", "lowRepairKitWarning"}) end,

    -- TODO: Chat Mode

    -- -----------------------------------------------------------------------------------
    -- RECHARGE WITH SOUL GEMS
    -- -----------------------------
    isRechargeWithSoulGemMenuDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}, {"RechargeWeapons", "useSoulGems"}) end,
    isRechargeWithSoulGemDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}) end,
    getRechargeWithSoulGemSetting = function() return getValue(PASV.Repair, {"RechargeWeapons", "useSoulGems"}) end,
    setRechargeWithSoulGemSetting = function(value) setValue(PASV.Repair, value, {"RechargeWeapons", "useSoulGems"}) end,

    isLowSoulGemWarningDisabled = function() return isDisabled(PASV.Repair, {"autoRepairEnabled"}, {"RechargeWeapons", "useSoulGems"}) end,
    getLowSoulGemWarningSetting = function() return getValue(PASV.Repair, {"RechargeWeapons", "lowSoulGemWarning"}) end,
    setLowSoulGemWarningSetting = function(value) setValue(PASV.Repair, value, {"RechargeWeapons", "lowSoulGemWarning"}) end,
}

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PAMF.PARepair = PARepairMenuFunctions