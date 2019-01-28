-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local L = PA.Localization

local function setPALHarvestDropdownsTo(itemTypeKey)
    for i = 1, #PALHarvestableItemTypes do
        -- only if the itemType is enabled
        if PALHarvestableItemTypes[i] ~= "" then
            PASV.Loot[PA.activeProfile].HarvestableItemTypes[PALHarvestableItemTypes[i]] = itemTypeKey
        end
    end
end

local function setPALLootDropdownsTo(itemTypeKey)
    for i = 1, #PALLootableItemTypes do
        -- only if the itemType is enabled
        if PALLootableItemTypes[i] ~= "" then
            PASV.Loot[PA.activeProfile].LootableItemTypes[PALLootableItemTypes[i]] = itemTypeKey
        end
    end
end

-- --------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------

local function getProfileList()
    local PASV = PA.SavedVars

    local profiles = {}
    for profileNo = 1, PAC.GENERAL.MAX_PROFILES do
        profiles[profileNo] = PASV.General[profileNo].name
    end

    if (PASV.Profile.activeProfile == nil) then
        profiles[PAC.GENERAL.NO_PROFILE_SELECTED_ID] = L.PAG_PleaseSelectProfile
    end

    return profiles
end

local function getProfileListValues()
    local PASV = PA.SavedVars

    local profileValues = {}
    for profileNo = 1, PAC.GENERAL.MAX_PROFILES do
        profileValues[profileNo] = profileNo
    end

    if (PASV.Profile.activeProfile == nil) then
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
    setPALHarvestDropdownsTo = setPALHarvestDropdownsTo,
    setPALLootDropdownsTo = setPALLootDropdownsTo,
    getProfileList = getProfileList,
    getProfileListValues = getProfileListValues,
    reloadProfileList = reloadProfileList
}
