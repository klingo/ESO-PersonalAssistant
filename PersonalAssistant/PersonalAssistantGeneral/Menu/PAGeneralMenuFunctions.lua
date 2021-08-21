-- Local instances of Global tables --
local PA = PersonalAssistant
local PAMF = PA.MenuFunctions

-- =====================================================================================================================

local function getDebugValue(...)
    return PAMF.getValue(PA.SavedVars.Profile.Debug, ...)
end

local function setDebugValue(value, ...)
    PAMF.setValue(PA.SavedVars.Profile.Debug, value, ...)
end

local function getValue(...)
    return PAMF.getValue(PA.SavedVars.Profile.General, ...)
end

local function setValue(value, ...)
    PAMF.setValue(PA.SavedVars.Profile.General, value, ...)
end

local function isDisabled(...)
    return PAMF.isDisabled(PA.SavedVars.Profile.General, ...)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- PAGeneral   teleportToPrimaryHouse
---------------------------------
local function doPAGeneralTeleportToPrimaryHouse()
    local houseId = GetHousingPrimaryHouse()
    if houseId > 0 then
        if CanLeaveCurrentLocationViaTeleport() then
            local jumpOutside = getValue({"jumpOutside"})
            RequestJumpToHouse(houseId, jumpOutside)
        else
            PA.println(SI_PA_CHAT_GENERAL_TELEPORT_ZONE_PREVENTED)
        end
    else
        PA.println(SI_PA_CHAT_GENERAL_TELEPORT_NO_PRIMARY_HOUSE)
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- PADebug   libDebugLogger
---------------------------------
local function isPADebugLibDebugLoggerDisabled()
    return PA.LibDebugLogger == nil
end

-- ---------------------------------------------------------------------------------------------------------------------
-- PAProfile   debug
---------------------------------
local function setPAProfileDebugSetting(value)
    -- update SV value
    setDebugValue(value, { "debug"})
    -- update reference
    PA.debug = value
end

-- ---------------------------------------------------------------------------------------------------------------------
-- PAProfile    libDebugLogger
---------------------------------
local function setPADebugLibDebugLoggerSetting(value)
    setDebugValue(value, {"libDebugLogger"})
    -- toggle logger
    PA.logger:SetLibDebugLoggerEnabled(value)
    if PA.Banking then PA.Banking.logger:SetLibDebugLoggerEnabled(value) end
    if PA.Integration then PA.Integration.logger:SetLibDebugLoggerEnabled(value) end
    if PA.Junk then PA.Junk.logger:SetLibDebugLoggerEnabled(value) end
    if PA.Loot then PA.Loot.logger:SetLibDebugLoggerEnabled(value) end
    if PA.Repair then PA.Repair.logger:SetLibDebugLoggerEnabled(value) end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- PAProfile    personalAssistantLogger
---------------------------------
local function setPADebugPersonalAssistantLoggerSetting(value)
    setDebugValue(value, {"personalAssistantLogger"})
    -- toggle logger
    PA.logger:SetPersonalAssistantLoggerEnabled(value)
    if PA.Banking then PA.Banking.logger:SetPersonalAssistantLoggerEnabled(value) end
    if PA.Integration then PA.Integration.logger:SetPersonalAssistantLoggerEnabled(value) end
    if PA.Junk then PA.Junk.logger:SetPersonalAssistantLoggerEnabled(value) end
    if PA.Loot then PA.Loot.logger:SetPersonalAssistantLoggerEnabled(value) end
    if PA.Repair then PA.Repair.logger:SetPersonalAssistantLoggerEnabled(value) end

    -- showing when already shown causes problems; thus always hide it first ;)
    PA.DebugWindow.hideDebugOutputWindow()
    if value == true then
        PA.DebugWindow.showDebugOutputWindow()
    end
end

-- =====================================================================================================================
-- Export
PAMF.PAGeneral = {
    getWelcomeMessageSetting = function() return getValue({"welcomeMessage"}) end,
    setWelcomeMessageSetting = function(value) setValue(value, {"welcomeMessage"}) end,

    isTeleportToPrimaryHouseDisabled = function() return not CanLeaveCurrentLocationViaTeleport() end,
    teleportToPrimaryHouse = doPAGeneralTeleportToPrimaryHouse,

    getJumpOutsideSetting = function() return getValue({"jumpOutside"}) end,
    setJumpOutsideSetting = function(value) setValue(value, {"jumpOutside"}) end,

    isLibDebugLoggerDisabled = isPADebugLibDebugLoggerDisabled,
    getLibDebugLoggerSetting = function() return getDebugValue({"libDebugLogger"}) end,
    setLibDebugLoggerSetting = setPADebugLibDebugLoggerSetting,

    getPersonalAssistantLoggerSetting = function() return getDebugValue({"personalAssistantLogger"}) end,
    setPersonalAssistantLoggerSetting = setPADebugPersonalAssistantLoggerSetting,
}