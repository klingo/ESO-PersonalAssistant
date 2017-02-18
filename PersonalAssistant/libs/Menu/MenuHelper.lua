MenuHelper = {}

function MenuHelper.setPALHarvestDropdownsTo(itemTypeKey)
	local activeProfile = PA.savedVars.Profile.activeProfile
	for i = 1, #PALHarvestableItemTypes do
		-- only if the itemType is enabled
		if PALHarvestableItemTypes[i] ~= "" then
			PA.savedVars.Loot[activeProfile].HarvestableItemTypes[PALHarvestableItemTypes[i]] = itemTypeKey
		end
	end
end

function MenuHelper.setPALLootDropdownsTo(itemTypeKey)
    local activeProfile = PA.savedVars.Profile.activeProfile
    for i = 1, #PALLootableItemTypes do
        -- only if the itemType is enabled
        if PALLootableItemTypes[i] ~= "" then
            PA.savedVars.Loot[activeProfile].LootableItemTypes[PALLootableItemTypes[i]] = itemTypeKey
        end
    end
end

-- --------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------

function MenuHelper.getProfileList()
    local profiles = {}
	for profileNo = 1, PAG_MAX_PROFILES do
		profiles[profileNo] = PA.savedVars.General[profileNo].name
    end

    local activeProfile = PA.savedVars.Profile.activeProfile
    if (activeProfile == nil) then
        profiles[PAG_NO_PROFILE_SELECTED_ID] = PALocale.getResourceMessage("PAG_PleaseSelectProfile")
    end

	return profiles
end

function MenuHelper.getProfileListValues()
    local profileValues = {}
    for profileNo = 1, PAG_MAX_PROFILES do
        profileValues[profileNo] = profileNo
    end

    local activeProfile = PA.savedVars.Profile.activeProfile
    if (activeProfile == nil) then
        profileValues[PAG_NO_PROFILE_SELECTED_ID] = PAG_NO_PROFILE_SELECTED_ID
    end

    return profileValues
end

function MenuHelper.reloadProfileList()
    local profiles = MenuHelper.getProfileList()
    local profileValues = MenuHelper.getProfileListValues()
    PERSONALASSISTANT_PROFILEDROPDOWN:UpdateChoices(profiles, profileValues)
    PERSONALASSISTANT_PROFILEDROPDOWN:UpdateValue()
end

-- --------------------------------------------------------------------------------------------------------

function MenuHelper.getProfileTextFromNumber(number)
	local profileNo = PA.savedVars.Profile.activeProfile
	if (number ~= nil) then
		profileNo = number
    end

    if (profileNo == nil) then
        return PALocale.getResourceMessage("PAG_PleaseSelectProfile")
    end

	return PA.savedVars.General[profileNo].name
end


function MenuHelper.getProfileNumberFromText(profileText)
    for profileNo = 1, PAG_MAX_PROFILES do
        if PA.savedVars.General[profileNo].name == profileText then
            return profileNo
        end
    end
    -- if nothing found
    return PAG_NO_PROFILE_SELECTED_ID
end

function MenuHelper.getDefaultProfileName(profileNo)
    if profileNo == 1 then
        return PALocale.getResourceMessage("PAG_Profile1")
	elseif profileNo == 2 then
		return PALocale.getResourceMessage("PAG_Profile2")
	elseif profileNo == 3 then
		return PALocale.getResourceMessage("PAG_Profile3")
	elseif profileNo == 4 then
		return PALocale.getResourceMessage("PAG_Profile4")
	elseif profileNo == 5 then
		return PALocale.getResourceMessage("PAG_Profile5")
	else
		return PALocale.getResourceMessage("PAG_PleaseSelectProfile")
	end
end

-- --------------------------------------------------------------------------------------------------------
