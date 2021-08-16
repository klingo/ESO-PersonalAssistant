-- Local instances of Global tables --
local PA = PersonalAssistant

-- ---------------------------------------------------------------------------------------------------------------------

local GetTimeString = GetTimeString
local GetGameTimeMilliseconds = GetGameTimeMilliseconds
local ostime = os.time

local _debugWindow = PADebugWindow

local _debugOutputWindow = PADebugOutputWindow
local _bufferDebugOutputControl
local _sliderDebugOutputControl

local function _adjustSlider(sliderControl, bufferControl)
    local numHistoryLines = bufferControl:GetNumHistoryLines()
    local numVisibleLines = bufferControl:GetNumVisibleLines()
    local _, sliderMax = sliderControl:GetMinMax()
    local sliderValue = sliderControl:GetValue()

    -- update the maxValue of the slider to the number of total history lines
    sliderControl:SetMinMax(0, numHistoryLines)

    -- if slider was already at the max (i.e. at the bottom), keep it there
    if sliderValue == sliderMax then
        sliderControl:SetValue(numHistoryLines)
    end

    -- hide slider if all lines are visible
    if numHistoryLines > numVisibleLines then
        sliderControl:SetHidden(false)
    else
        sliderControl:SetHidden(true)
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

local function showStaticDebugInformationWindow()
    local debugBgControl = _debugWindow:GetNamedChild("DebugBg")
    local debugEditControl = debugBgControl:GetNamedChild("DebugEdit")

    function debugEditControl:InsertLine(text)
        debugEditControl:InsertText("\n"..text)
    end
    function debugEditControl:InsertBreak()
        debugEditControl:InsertText("\n------------------------------------------------")
    end

    -- First reset
    debugEditControl:SetText("")

    -- Add header
    debugEditControl:InsertText("PersonalAssistant Debug Information - "..os.date())
    debugEditControl:InsertBreak()

    -- Active profile
    if PA.ProfileManager.PABanking then
        debugEditControl:InsertLine("PA.Banking.activeProfile="..tostring(PA.ProfileManager.PABanking.hasActiveProfile()).." ("..tostring(PA.ProfileManager.PABanking.getActiveProfile())..")")
    end
    if PA.ProfileManager.PAIntegration then
        debugEditControl:InsertLine("PA.Integration.activeProfile="..tostring(PA.ProfileManager.PAIntegration.hasActiveProfile()).." ("..tostring(PA.ProfileManager.PAIntegration.getActiveProfile())..")")
    end
    if PA.ProfileManager.PAJun then
        debugEditControl:InsertLine("PA.Junk.activeProfile="..tostring(PA.ProfileManager.PAJunk.hasActiveProfile()).." ("..tostring(PA.ProfileManager.PAJunk.getActiveProfile())..")")
    end
    if PA.ProfileManager.PALoot then
        debugEditControl:InsertLine("PA.Loot.activeProfile="..tostring(PA.ProfileManager.PALoot.hasActiveProfile()).." ("..tostring(PA.ProfileManager.PALoot.getActiveProfile())..")")
    end
    if PA.ProfileManager.PARepair then
        debugEditControl:InsertLine("PA.Repair.activeProfile="..tostring(PA.ProfileManager.PARepair.hasActiveProfile()).." ("..tostring(PA.ProfileManager.PARepair.getActiveProfile())..")")
    end

    -- Enabled addons
    debugEditControl:InsertLine("PA.General="..tostring(PA.General ~= nil))
    debugEditControl:InsertLine("PA.Banking="..tostring(PA.Banking ~= nil))
    debugEditControl:InsertLine("PA.Integration="..tostring(PA.Integration ~= nil))
    debugEditControl:InsertLine("PA.Junk="..tostring(PA.Junk ~= nil))
    debugEditControl:InsertLine("PA.Loot="..tostring(PA.Loot ~= nil))
    debugEditControl:InsertLine("PA.Mail="..tostring(PA.Mail ~= nil))
    debugEditControl:InsertLine("PA.Repair="..tostring(PA.Repair ~= nil))
    debugEditControl:InsertBreak()

    -- SavedVars
    debugEditControl:InsertLine(table.concat({"PAGeneral.SavedVars=", tostring(PA.General and istable(PA.General.SavedVars)), " - ", PA.SavedVars.General and PA.SavedVars.General.savedVarsVersion}))
    debugEditControl:InsertLine(table.concat({"PABanking.SavedVars=", tostring(PA.Banking and istable(PA.Banking.SavedVars)), " - ", PA.SavedVars.Banking and PA.SavedVars.Banking.savedVarsVersion}))
    debugEditControl:InsertLine(table.concat({"PAIntegration.SavedVars=", tostring(PA.Integration and istable(PA.Integration.SavedVars)), " - ", PA.SavedVars.Integration and PA.SavedVars.Integration.savedVarsVersion}))
    debugEditControl:InsertLine(table.concat({"PAJunk.SavedVars=", tostring(PA.Junk and istable(PA.Junk.SavedVars)), " - ", PA.SavedVars.Junk and PA.SavedVars.Junk.savedVarsVersion}))
    debugEditControl:InsertLine(table.concat({"PALoot.SavedVars=", tostring(PA.Loot and istable(PA.Loot.SavedVars)), " - ", PA.SavedVars.Loot and PA.SavedVars.Loot.savedVarsVersion}))
    debugEditControl:InsertLine(table.concat({"PAMail.SavedVars=", tostring(PA.Mail and istable(PA.Mail.SavedVars)), " - ", PA.SavedVars.Mail and PA.SavedVars.Mail.savedVarsVersion}))
    debugEditControl:InsertLine(table.concat({"PARepair.SavedVars=", tostring(PA.Repair and istable(PA.Repair.SavedVars)), " - ", PA.SavedVars.Repair and PA.SavedVars.Repair.savedVarsVersion}))
    debugEditControl:InsertBreak()

    -- Global values
    debugEditControl:InsertLine("PA.playerName="..tostring(PA.playerName))
    debugEditControl:InsertLine("PA.alliance="..tostring(PA.alliance))
    debugEditControl:InsertLine("ALLIANCE_ALDMERI_DOMINION="..tostring(PA.alliance == ALLIANCE_ALDMERI_DOMINION))
    debugEditControl:InsertLine("ALLIANCE_EBONHEART_PACT="..tostring(PA.alliance == ALLIANCE_EBONHEART_PACT))
    debugEditControl:InsertLine("ALLIANCE_DAGGERFALL_COVENANT="..tostring(PA.alliance == ALLIANCE_DAGGERFALL_COVENANT))
    debugEditControl:InsertLine("ALLIANCE_NONE="..tostring(PA.alliance == ALLIANCE_NONE))
    debugEditControl:InsertBreak()

    -- Registered Events
    local registeredEventsSet = PA.EventManager.getAllEventsInSet()
    for key, value in pairs(registeredEventsSet) do
        debugEditControl:InsertLine(key.."="..tostring(value))
    end
    debugEditControl:InsertBreak()

    -- PARepair
    local PARepairSavedVars = PA.Repair.SavedVars
    if PARepairSavedVars ~= nil then
        debugEditControl:InsertLine("autoRepairEnabled="..tostring(PARepairSavedVars.autoRepairEnabled))
        debugEditControl:InsertLine(table.concat({"RepairEquipped.repairWithGold=", tostring(PARepairSavedVars.RepairEquipped.repairWithGold), " - ", tostring(PARepairSavedVars.RepairEquipped.repairWithGoldDurabilityThreshold)}))
        debugEditControl:InsertLine(table.concat({"RepairInventory.repairWithGold=", tostring(PARepairSavedVars.RepairInventory.repairWithGold), " - ", tostring(PARepairSavedVars.RepairInventory.repairWithGoldDurabilityThreshold)}))
    end
    local PARMenuFunctions = PA.MenuFunctions.PARepair
    debugEditControl:InsertLine("PARMenuFunctions="..tostring(istable(PARMenuFunctions)))
    debugEditControl:InsertLine("getAutoRepairEquippedEnabledSetting="..tostring(PARMenuFunctions.getAutoRepairEquippedEnabledSetting() or ""))
    debugEditControl:InsertLine("getRepairEquippedWithGoldSetting="..tostring(PARMenuFunctions.getRepairEquippedWithGoldSetting() or ""))
    debugEditControl:InsertLine("getAutoRepairInventoryEnabledSetting="..tostring(PARMenuFunctions.getAutoRepairInventoryEnabledSetting() or ""))
    debugEditControl:InsertLine("getRepairInventoryWithGoldSetting="..tostring(PARMenuFunctions.getRepairInventoryWithGoldSetting() or ""))
    debugEditControl:InsertBreak()

    local PAJMenuFunctions = PA.MenuFunctions.PAJunk
    debugEditControl:InsertLine("PAJMenuFunctions="..tostring(istable(PAJMenuFunctions)))
    debugEditControl:InsertLine("getAutoSellJunkSetting="..tostring(PAJMenuFunctions and PAJMenuFunctions.getAutoSellJunkSetting()))

    -- show the window
    _debugWindow:SetHidden(false)
end

-- ---------------------------------------------------------------------------------------------------------------------

local _initDone = false
local _preInitTextQueue = {}

local _lastMillisecondEntry

local function printToDebugOutputWindow(addonName, text)
    if _bufferDebugOutputControl then
        local timeString = GetTimeString()
        local currMillisecondEntry = GetGameTimeMilliseconds()
        table.insert(PA.SavedVars.General.Debug, {
            [1] = ostime(),
            [2] = timeString,
            [3] = currMillisecondEntry - _lastMillisecondEntry,
            [4] = addonName,
            [5] = text,
        })
        _lastMillisecondEntry = currMillisecondEntry
        -- add timestamp
        text = string.format("%s %s", timeString, text)
        _bufferDebugOutputControl:AddMessage(text, 1, 1, 1)
        _adjustSlider(_sliderDebugOutputControl, _bufferDebugOutputControl)
    else
        -- if buffer, for whatever reason is not initialized yet, add text to queue
        table.insert(_preInitTextQueue, text)
    end
end

local function _initDebugOutputWindow()
    if not _initDone then
        _initDone = true
        -- make sure it's properly initialized
        if PA.SavedVars.General.Debug == nil then PA.SavedVars.General.Debug = {} end
        _lastMillisecondEntry = GetGameTimeMilliseconds()
        _bufferDebugOutputControl = _debugOutputWindow:GetNamedChild("Buffer")
        _sliderDebugOutputControl = _debugOutputWindow:GetNamedChild("Slider")
        _debugOutputWindow.timeline = ANIMATION_MANAGER:CreateTimeline()
        _debugOutputWindow.animation = _debugOutputWindow.timeline:InsertAnimation(ANIMATION_ALPHA, _debugOutputWindow, 3000) -- fade delay
        _debugOutputWindow.animation:SetAlphaValues(1, 0)
        _debugOutputWindow.animation:SetDuration(500) -- duration
        _debugOutputWindow.timeline:PlayFromStart()
    end
end

local function showDebugOutputWindow()
    _initDebugOutputWindow()
    _debugOutputWindow:SetHidden(false)
    -- init the bufferControl with some text and the current os-date/time
    _bufferDebugOutputControl:Clear()
    printToDebugOutputWindow("DEBUG-START", table.concat({"|cFFA500", "PersonalAssistant Debug Output - ", os.date(), "|r"}))
    -- empty the queue if something was added
    while #_preInitTextQueue > 0 do
        local text = table.remove(_preInitTextQueue)
        printToDebugOutputWindow("PRE-INIT-QUEUE", text)
    end
end

local function hideDebugOutputWindow(skipSVLogClearWhenDisable)
    -- clear debug log
    if not skipSVLogClearWhenDisable then
        PA.SavedVars.General.Debug = {}
    end
    _debugOutputWindow:SetHidden(true)
    PA.toggleDebug(false)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.DebugWindow = {
    showStaticDebugInformationWindow = showStaticDebugInformationWindow,
    printToDebugOutputWindow = printToDebugOutputWindow,
    showDebugOutputWindow = showDebugOutputWindow,
    hideDebugOutputWindow = hideDebugOutputWindow
}