-- Local instances of Global tables --
local PA = PersonalAssistant
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local _debugWindow = PADebugWindow

local _debugOutputWindow = PADebugOutputWindow
local _debugOutputWindowTimeline
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
    debugEditControl:InsertLine("ActiveProfile="..tostring(PA.activeProfile))
    debugEditControl:InsertLine("HasActiveProfile="..tostring(PAHF.hasActiveProfile()))

    -- Enabled addons
    debugEditControl:InsertLine("PA.Banking="..tostring(PA.Banking ~= nil))
    debugEditControl:InsertLine("PA.Junk="..tostring(PA.Junk ~= nil))
    debugEditControl:InsertLine("PA.Loot="..tostring(PA.Loot ~= nil))
    debugEditControl:InsertLine("PA.Mail="..tostring(PA.Mail ~= nil))
    debugEditControl:InsertLine("PA.Repair="..tostring(PA.Repair ~= nil))
    debugEditControl:InsertBreak()

    -- SavedVars
    debugEditControl:InsertLine(table.concat({"PABanking.SavedVars=", tostring(PA.Banking and istable(PA.Banking.SavedVars)), " - ", PA.SavedVars.Banking and PA.SavedVars.Banking.savedVarsVersion}))
    debugEditControl:InsertLine(table.concat({"PAJunk.SavedVars=", tostring(PA.Junk and istable(PA.Junk.SavedVars)), " - ", PA.SavedVars.Junk and PA.SavedVars.Junk.savedVarsVersion}))
    debugEditControl:InsertLine(table.concat({"PALoot.SavedVars=", tostring(PA.Loot and istable(PA.Loot.SavedVars)), " - ", PA.SavedVars.Loot and PA.SavedVars.Loot.savedVarsVersion}))
    debugEditControl:InsertLine(table.concat({"PAMail.SavedVars=", tostring(PA.Mail and istable(PA.Mail.SavedVars)), " - ", PA.SavedVars.Mail and PA.SavedVars.Mail.savedVarsVersion}))
    debugEditControl:InsertLine(table.concat({"PARepair.SavedVars=", tostring(PA.Repair and istable(PA.Repair.SavedVars)), " - ", PA.SavedVars.Repair and PA.SavedVars.Repair.savedVarsVersion}))
    debugEditControl:InsertBreak()

    -- Registered Events
    local registeredEventsSet = PA.EventManager.getAllReventsInSet()
    for key, value in pairs(registeredEventsSet) do
        debugEditControl:InsertLine(key.."="..tostring(value))
    end
    debugEditControl:InsertBreak()

    -- PARepair
    local PARepairSavedVars = PA.Repair.SavedVars
    debugEditControl:InsertLine("autoRepairEnabled="..tostring(PARepairSavedVars.autoRepairEnabled))
    debugEditControl:InsertLine(table.concat({"RepairEquipped.repairWithGold=", tostring(PARepairSavedVars.RepairEquipped.repairWithGold), " - ", tostring(PARepairSavedVars.RepairEquipped.repairWithGoldDurabilityThreshold)}))
    debugEditControl:InsertLine(table.concat({"RepairInventory.repairWithGold=", tostring(PARepairSavedVars.RepairInventory.repairWithGold), " - ", tostring(PARepairSavedVars.RepairInventory.repairWithGoldDurabilityThreshold)}))
    local PARMenuFunctions = PA.MenuFunctions.PARepair
    debugEditControl:InsertLine("PARMenuFunctions="..tostring(istable(PARMenuFunctions)))
    debugEditControl:InsertLine("getAutoRepairEnabledSetting="..tostring(PARMenuFunctions.getAutoRepairEnabledSetting()))
    debugEditControl:InsertLine("getRepairWithGoldSetting="..tostring(PARMenuFunctions.getRepairWithGoldSetting()))
    debugEditControl:InsertLine("getRepairInventoryWithGoldSetting="..tostring(PARMenuFunctions.getRepairInventoryWithGoldSetting()))
    debugEditControl:InsertBreak()

    local PAJMenuFunctions = PA.MenuFunctions.PAJunk
    debugEditControl:InsertLine("PAJMenuFunctions="..tostring(istable(PAJMenuFunctions)))
    debugEditControl:InsertLine("getAutoSellJunkSetting="..tostring(PAJMenuFunctions and PAJMenuFunctions.getAutoSellJunkSetting()))

    -- show the window
    _debugWindow:SetHidden(false)
end

-- ---------------------------------------------------------------------------------------------------------------------

local function printToDebugOutputWindow(text)
    _bufferDebugOutputControl:AddMessage(text, 1, 1, 1)
    _adjustSlider(_sliderDebugOutputControl, _bufferDebugOutputControl)
end

local function showDebugOutputWindow()
    if not _bufferDebugOutputControl then _bufferDebugOutputControl = _debugOutputWindow:GetNamedChild("Buffer") end
    if not _sliderDebugOutputControl then _sliderDebugOutputControl = _debugOutputWindow:GetNamedChild("Slider") end
    if not _debugOutputWindow.timeline then
        _debugOutputWindow.timeline = ANIMATION_MANAGER:CreateTimeline()
        _debugOutputWindow.animation = _debugOutputWindow.timeline:InsertAnimation(ANIMATION_ALPHA, _debugOutputWindow, 3000) -- fade delay
        _debugOutputWindow.animation:SetAlphaValues(1, 0)
        _debugOutputWindow.animation:SetDuration(500) -- duration
        _debugOutputWindow.timeline:PlayFromStart()
    end

    -- clear the bufferControl and then init it with some text
    _bufferDebugOutputControl:Clear()
    _bufferDebugOutputControl:AddMessage("PersonalAssistant Debug Output - "..os.date(), 1, 1/255*140, 0)

    _debugOutputWindow:SetHidden(false)
end

local function hideDebugOutputWindow()
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