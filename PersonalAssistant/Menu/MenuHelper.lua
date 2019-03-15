-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

-- --------------------------------------------------------------------------------------------------------

local function getProfileList()
    local PASavedVars = PA.SavedVars

    local profiles = {}
    for profileNo = 1, PAC.GENERAL.MAX_PROFILES do
        profiles[profileNo] = PASavedVars.General[profileNo].name
    end

    if (PASavedVars.Profile.activeProfile == nil) then
        profiles[PAC.GENERAL.NO_PROFILE_SELECTED_ID] = GetString(SI_PA_PLEASE_SELECT_PROFILE)
    end

    return profiles
end

local function getProfileListValues()
    local PASavedVars = PA.SavedVars

    local profileValues = {}
    for profileNo = 1, PAC.GENERAL.MAX_PROFILES do
        profileValues[profileNo] = profileNo
    end

    if (PASavedVars.Profile.activeProfile == nil) then
        profileValues[PAC.GENERAL.NO_PROFILE_SELECTED_ID] = PAC.GENERAL.NO_PROFILE_SELECTED_ID
    end

    return profileValues
end

local function reloadProfileList()
    local profiles = getProfileList()
    local profileValues = getProfileListValues()
    PERSONALASSISTANT_PROFILEDROPDOWN:UpdateChoices(profiles, profileValues)
    PERSONALASSISTANT_PROFILEDROPDOWN:UpdateValue()
end

-- --------------------------------------------------------------------------------------------------------

-- Export
PA.MenuHelper = {
    getProfileList = getProfileList,
    getProfileListValues = getProfileListValues,
    reloadProfileList = reloadProfileList
}
