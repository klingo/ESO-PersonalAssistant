-- Local instances of Global tables --
local PA = PersonalAssistant

-- ---------------------------------------------------------------------------------------------------------------------

local function getValueV2(savedVarsTable, attributeTbl)
    if #attributeTbl > 0 then
        for _, attribute in ipairs(attributeTbl) do
            savedVarsTable = savedVarsTable[attribute]
        end
        return savedVarsTable
    else return end
end

local function setValueV2(savedVarsTable, value, attributeTbl)
    if #attributeTbl > 0 then
        for index, attribute in ipairs(attributeTbl) do
            if index < #attributeTbl then
                savedVarsTable = savedVarsTable[attribute]
            else
                savedVarsTable[attribute] = value
            end
        end
    else return end
end

local function isDisabledV2(savedVarsTable, ...)
    local args = { ... }
    for _, attributeTbl in ipairs(args) do
        -- return true when ANY setting is OFF
        local localSavedVarsTable = savedVarsTable
        if #attributeTbl > 0 then
            for _, attribute in ipairs(attributeTbl) do
                localSavedVarsTable = localSavedVarsTable[attribute]
            end
            if not localSavedVarsTable then return true end
        end
    end
    -- return false when ALL settings are ON (or no settings provided)
    return false
end

local function isDisabledAllV2(savedVarsTable, ...)
    local args = { ... }
    for _, attributeTbl in ipairs(args) do
        -- return false when ANY setting is ON
        local localSavedVarsTable = savedVarsTable
        if #attributeTbl > 0 then
            for _, attribute in ipairs(attributeTbl) do
                localSavedVarsTable = localSavedVarsTable[attribute]
            end
            if localSavedVarsTable then return false end
        end
    end
    -- return true when ALL settings are OFF (or no settings provided)
    return true
end

-- ---------------------------------------------------------------------------------------------------------------------

local function getTextIfRequiredAddonNotRunning(textKeyIfNotRunning, addonTableToCheck)
    if istable(addonTableToCheck) then return nil end
    return GetString(textKeyIfNotRunning)
end

-- =====================================================================================================================
-- Export
PA.MenuFunctions = {
    isDisabled = isDisabledV2,
    isDisabledAll = isDisabledAllV2,
    getValue = getValueV2,
    setValue = setValueV2,
    getTextIfRequiredAddonNotRunning = getTextIfRequiredAddonNotRunning
}