-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PASV = PA.SavedVars
local PAEM = PA.EventManager

-- ---------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------
-- PAGeneral   activeProfile
---------------------------------
local function getPAGeneralActiveProfile()
    local activeProfile = PASV.Profile.activeProfile
    if (activeProfile == nil) then
        return PAC.GENERAL.NO_PROFILE_SELECTED_ID
    else
        return activeProfile
    end
end

local function setPAGeneralActiveProfile(profileNo)
    if (profileNo ~= nil and profileNo ~= PAC.GENERAL.NO_PROFILE_SELECTED_ID) then
        -- get the previously active prefoile first
        local prevProfile = PASV.Profile.activeProfile
        -- then save the new one
        PASV.Profile.activeProfile = profileNo
        PA.activeProfile = profileNo
        -- if the previous profile was the "no profile selected" one, refresh the dropdown values
        if (prevProfile == nil) then
            local PAMenuHelper = PA.MenuHelper
            PAMenuHelper.reloadProfileList()
        end
        -- also refresh all event registrations
        PAEM.RefreshAllEventRegistrations()
        -- and refresh all SavedVar references that are profile-specific
        PAEM.RefreshAllSavedVarReferences(profileNo)
    end
end

local function isDisabledPAGeneralNoProfileSelected()
    return (PA.activeProfile == nil)
end

-- ---------------------------------------------------------------------------------------------------------------------

local function isDisabled(savedVarsTable, ...)
    -- TODO: get rid of this function
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    local args = { ... }
    for _, tbl in ipairs(args) do
        -- return true when ANY setting is OFF
        if (#tbl == 1) then
            local attributeLevelOne = tbl[1]
            if (not savedVarsTable[PA.activeProfile][attributeLevelOne]) then return true end
        elseif (#tbl == 2) then
            local attributeLevelOne = tbl[1]
            local attributeLevelTwo = tbl[2]
            if (not savedVarsTable[PA.activeProfile][attributeLevelOne][attributeLevelTwo]) then return true end
        elseif (#tbl == 3) then
            local attributeLevelOne = tbl[1]
            local attributeLevelTwo = tbl[2]
            local attributeLevelThree = tbl[3]
            if (not savedVarsTable[PA.activeProfile][attributeLevelOne][attributeLevelTwo][attributeLevelThree]) then return true end
        else
            -- if either no table was sent, or more than 3; always return true (i.e. disabled)
            return true
        end
    end
    -- return false when ALL settings are ON
    return false
end

local function isDisabledDebug(savedVarsTable, ...)
    -- TODO: get rid of this function
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    local args = { ... }
    for _, tbl in ipairs(args) do
        -- return true when ANY setting is OFF
        if (#tbl == 1) then
            local attributeLevelOne = tbl[1]
            d(tostring(attributeLevelOne).."="..tostring(savedVarsTable[PA.activeProfile][attributeLevelOne]))
            if (not savedVarsTable[PA.activeProfile][attributeLevelOne]) then return true end
        elseif (#tbl == 2) then
            local attributeLevelOne = tbl[1]
            local attributeLevelTwo = tbl[2]
            d(tostring(attributeLevelOne).."."..tostring(attributeLevelTwo).."="..tostring(savedVarsTable[PA.activeProfile][attributeLevelOne][attributeLevelTwo]))
            if (not savedVarsTable[PA.activeProfile][attributeLevelOne][attributeLevelTwo]) then return true end
        elseif (#tbl == 3) then
            local attributeLevelOne = tbl[1]
            local attributeLevelTwo = tbl[2]
            local attributeLevelThree = tbl[3]
            d(tostring(attributeLevelOne).."."..tostring(attributeLevelTwo).."."..tostring(attributeLevelThree).."="..tostring(savedVarsTable[PA.activeProfile][attributeLevelOne][attributeLevelTwo][attributeLevelThree]))
            if (not savedVarsTable[PA.activeProfile][attributeLevelOne][attributeLevelTwo][attributeLevelThree]) then return true end
        else
            -- if either no table was sent, or more than 3; always return true (i.e. disabled)
            d("return true")
            return true
        end
    end
    -- return false when ALL settings are ON
    d("return false")
    return false
end


local function getValue(savedVarsTable, attributeTbl)
    -- TODO: get rid of this function
    if isDisabledPAGeneralNoProfileSelected() then return end
    if #attributeTbl > 0 then
        local newTableLevel = savedVarsTable[PA.activeProfile]
        for _, attribute in ipairs(attributeTbl) do
            newTableLevel = newTableLevel[attribute]
        end
        return newTableLevel
    else return end
end

local function setValue(savedVarsTable, value, attributeTbl)
    -- TODO: get rid of this function
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    if (#attributeTbl == 1) then
        local attributeLevelOne = attributeTbl[1]
        savedVarsTable[PA.activeProfile][attributeLevelOne] = value
    elseif (#attributeTbl == 2) then
        local attributeLevelOne = attributeTbl[1]
        local attributeLevelTwo = attributeTbl[2]
        savedVarsTable[PA.activeProfile][attributeLevelOne][attributeLevelTwo] = value
    elseif (#attributeTbl == 3) then
        local attributeLevelOne = attributeTbl[1]
        local attributeLevelTwo = attributeTbl[2]
        local attributeLevelThree = attributeTbl[3]
        savedVarsTable[PA.activeProfile][attributeLevelOne][attributeLevelTwo][attributeLevelThree] = value
    else return end
end

-- ---------------------------------------------------------------------------------------------------------------------

local function getValueV2(savedVarsTable, attributeTbl)
    if isDisabledPAGeneralNoProfileSelected() then return end
    if #attributeTbl > 0 then
        for _, attribute in ipairs(attributeTbl) do
            savedVarsTable = savedVarsTable[attribute]
        end
        return savedVarsTable
    else return end
end

local function setValueV2(savedVarsTable, value, attributeTbl)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
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
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
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


--------------------------------------------------------------------------
-- PAGeneral   activeProfileRename
---------------------------------
local function getPAGeneralActiveProfileRename()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.General[PA.activeProfile].name
end

local function setPAGeneralActiveProfileRename(profileName)
    if (profileName ~= nil and profileName ~= "") then
        local PAMenuHelper = PA.MenuHelper
        PASV.General[PA.activeProfile].name = profileName
        -- when profile was changed, reload the profile list
        PAMenuHelper.reloadProfileList()
    end
end

--------------------------------------------------------------------------
-- PAGeneral   welcomeMessage
---------------------------------
local function getPAGeneralWelcomeMessage()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.General[PA.activeProfile].welcome
end

local function setPAGeneralWelcomeMessage(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.General[PA.activeProfile].welcome = value
end

-- =====================================================================================================================

-- Export
PA.MenuFunctions = {
    PAGeneral = {
        isNoProfileSelected = isDisabledPAGeneralNoProfileSelected,

        getActiveProfile = getPAGeneralActiveProfile,
        setActiveProfile = setPAGeneralActiveProfile,

        getActiveProfileRename = getPAGeneralActiveProfileRename,
        setActiveProfileRename = setPAGeneralActiveProfileRename,

        getWelcomeMessageSetting = getPAGeneralWelcomeMessage,
        setWelcomeMessageSetting = setPAGeneralWelcomeMessage
    },
}

PA.MenuFunctions.isDisabledPAGeneralNoProfileSelected = isDisabledPAGeneralNoProfileSelected
PA.MenuFunctions.isDisabled = isDisabled
PA.MenuFunctions.isDisabledV2 = isDisabledV2
PA.MenuFunctions.getValue = getValue
PA.MenuFunctions.getValueV2 = getValueV2
PA.MenuFunctions.setValue = setValue
PA.MenuFunctions.setValueV2 = setValueV2