MenuHelper = {}

-- PersonalAssistant Banking
function MenuHelper.setPABDepositAll()
	MenuHelper.setPABDropdownsTo(PAC_ITEMTYPE_DEPOSIT)
end

function MenuHelper.setPABWithdrawalAll()
	MenuHelper.setPABDropdownsTo(PAC_ITEMTYPE_WITHDRAWAL)
end

function MenuHelper.setPABIgnoreAll()
	MenuHelper.setPABDropdownsTo(PAC_ITEMTYPE_IGNORE)
end

-- PersonalAssistant Loot
function MenuHelper.setPALAutoLootAll(palType)
    if (palType == PAL_TYPE_HARVEST) then MenuHelper.setPALHarvestDropdownsTo(PAC_ITEMTYPE_LOOT) end
    if (palType == PAL_TYPE_LOOT) then MenuHelper.setPALLootDropdownsTo(PAC_ITEMTYPE_LOOT) end
end

function MenuHelper.setPALIgnoreAll(palType)
    if (palType == PAL_TYPE_HARVEST) then MenuHelper.setPALHarvestDropdownsTo(PAC_ITEMTYPE_IGNORE) end
    if (palType == PAL_TYPE_LOOT) then MenuHelper.setPALLootDropdownsTo(PAC_ITEMTYPE_IGNORE) end
end

-- --------------------------------------------------------------------------------------------------------

function MenuHelper.setPABDropdownsTo(itemTypeKey)
    local activeProfile = PA.savedVars.Profile.activeProfile
    for i = 1, #PABItemTypes do
        -- only if the itemType is enabled
        if PABItemTypes[i] ~= "" then
            PA.savedVars.Banking[activeProfile].ItemTypes[PABItemTypes[i]] = itemTypeKey
        end
    end
end

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

-- returns the matching dropdown-text based on the number that is behind it
function MenuHelper.getBankingTextFromNumber(number)
	local activeProfile = PA.savedVars.Profile.activeProfile
	local index = PA.savedVars.Banking[activeProfile].itemsJunkSetting
	-- if "number" is empty, it has to be the junkSetting
	if (number ~= nil) then
		index = PA.savedVars.Banking[activeProfile].ItemTypes[number]
	end

	if index == PAC_ITEMTYPE_DEPOSIT then
		return PALocale.getResourceMessage("PAB_ItemType_Deposit")
	elseif index == PAC_ITEMTYPE_WITHDRAWAL then
		return PALocale.getResourceMessage("PAB_ItemType_Withdrawal")
	elseif index == PAC_ITEMTYPE_INHERIT then
		return PALocale.getResourceMessage("PAB_ItemType_Inherit")
	else
		return PALocale.getResourceMessage("PAB_ItemType_None")
	end
end

-- returns the number behind the text, depending on the text
function MenuHelper.getBankingNumberFromText(text)
	if text == PALocale.getResourceMessage("PAB_ItemType_Deposit") then
		return PAC_ITEMTYPE_DEPOSIT		-- = Deposit
	elseif text == PALocale.getResourceMessage("PAB_ItemType_Withdrawal") then
		return PAC_ITEMTYPE_WITHDRAWAL	-- = Withdrawal
	elseif text == PALocale.getResourceMessage("PAB_ItemType_Inherit") then
		return PAC_ITEMTYPE_INHERIT		-- = Inherit
	else
		return PAC_ITEMTYPE_IGNORE		-- = Ignore
	end
end

-- --------------------------------------------------------------------------------------------------------

-- returns the matching dropdown-text based on the number that is behind it
function MenuHelper.getOperatorTextFromNumber(number)
	local activeProfile = PA.savedVars.Profile.activeProfile
	local index = PA.savedVars.Banking[activeProfile].ItemTypesAdvanced[number].Key

	if index == PAC_OPERATOR_EQUAL then
		return PALocale.getResourceMessage("REL_Equal")
	elseif index == PAC_OPERATOR_LESSTHAN then
		return PALocale.getResourceMessage("REL_LessThan")
	elseif index == PAC_OPERATOR_LESSTAHNEQAL then
		return PALocale.getResourceMessage("REL_LessThanEqual")
	elseif index == PAC_OPERATOR_GREATERTHAN then
		return PALocale.getResourceMessage("REL_GreaterThan")
	elseif index == PAC_OPERATOR_GREATERTHANEQUAL then
		return PALocale.getResourceMessage("REL_GreaterThanEqual")
	else
		return PALocale.getResourceMessage("REL_None")
	end
end

-- returns the number behind the text, depending on the text
function MenuHelper.getOperatorNumberFromText(text)
	if text == PALocale.getResourceMessage("REL_Equal") then
		return PAC_OPERATOR_EQUAL
	elseif text == PALocale.getResourceMessage("REL_LessThan") then
		return PAC_OPERATOR_LESSTHAN
	elseif text == PALocale.getResourceMessage("REL_LessThanEqual") then
		return PAC_OPERATOR_LESSTAHNEQAL
	elseif text == PALocale.getResourceMessage("REL_GreaterThan") then
		return PAC_OPERATOR_GREATERTHAN
	elseif text == PALocale.getResourceMessage("REL_GreaterThanEqual") then
		return PAC_OPERATOR_GREATERTHANEQUAL
	else
		return PAC_OPERATOR_NONE
	end
end

-- --------------------------------------------------------------------------------------------------------

-- returns the matching dropdown-text based on the number that is behind it
function MenuHelper.getStackTypeTextFromNumber(index)
	if index == PAB_STACKING_CONTINUE then
		return PALocale.getResourceMessage("ST_MoveExistingFull")
	elseif index == PAB_STACKING_INCOMPLETE then
		return PALocale.getResourceMessage("ST_FillIncompleteOnly")
	else
		return PALocale.getResourceMessage("ST_MoveAllFull")
	end
end

-- returns the number behind the text, depending on the text
function MenuHelper.getStackTypeNumberFromText(text)
	if text == PALocale.getResourceMessage("ST_MoveExistingFull") then
		return PAB_STACKING_CONTINUE
	elseif text == PALocale.getResourceMessage("ST_FillIncompleteOnly") then
		return PAB_STACKING_INCOMPLETE
	else
		return PAB_STACKING_FULL
	end
end

-- --------------------------------------------------------------------------------------------------------

-- returns the matching dropdown-text based on the number that is behind it
function MenuHelper.getLootTextFromNumber(number, lootType)
    local activeProfile = PA.savedVars.Profile.activeProfile
    local index
    if (lootType == PAL_TYPE_LOOT) then
        index = PA.savedVars.Loot[activeProfile].LootableItemTypes[number]
    elseif (lootType == PAL_TYPE_HARVEST) then
        index = PA.savedVars.Loot[activeProfile].HarvestableItemTypes[number]
    end

    if index == PAC_ITEMTYPE_LOOT then
        return PALocale.getResourceMessage("PAL_ItemType_AutoLoot")
    else
        return PALocale.getResourceMessage("PAL_ItemType_Ignore")
    end
end

-- returns the number behind the text, depending on the text
function MenuHelper.getLootNumberFromText(text)
    if text == PALocale.getResourceMessage("PAL_ItemType_AutoLoot") then
        return PAC_ITEMTYPE_LOOT		-- = Auto-Loot
    else
        return PAC_ITEMTYPE_IGNORE		-- = Ignore
    end
end

-- --------------------------------------------------------------------------------------------------------

function MenuHelper.getProfileList()
    local profiles = {}
	for profileNo = 1, PAG_MAX_PROFILES do
        PALogger.log("add profile no "..tostring(profileNo).." with name = "..tostring(PA.savedVars.General[profileNo].name))
		profiles[profileNo] = PA.savedVars.General[profileNo].name
    end

    local activeProfile = PA.savedVars.Profile.activeProfile
    if (activeProfile == nil or activeProfile == PAG_NO_PROFILE_SELECTED_ID) then
        PALogger.log("add profile no "..tostring(PAG_NO_PROFILE_SELECTED_ID).." with name = <Please select Profile>")
        profiles[PAG_NO_PROFILE_SELECTED_ID] = "<Please select Profile>" -- TODO: replace with Locale
    end

	return profiles
end

function MenuHelper.getProfileListValues()
    local profileValues = {}
    for profileNo = 1, PAG_MAX_PROFILES do
        profileValues[profileNo] = profileNo
    end

    local activeProfile = PA.savedVars.Profile.activeProfile
    if (activeProfile == nil or activeProfile == PAG_NO_PROFILE_SELECTED_ID) then
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

    if (profileNo == nil or profileNo == PAG_NO_PROFILE_SELECTED_ID) then
        PALogger.log("MenuHelper.getProfileTextFromNumber = <Please select Profile>")
        return "<Please select Profile>" -- TODO: replace with Locale
    end

    PALogger.log("MenuHelper.getProfileTextFromNumber = "..tostring(PA.savedVars.General[profileNo].name))

	return PA.savedVars.General[profileNo].name
end


function MenuHelper.getProfileNumberFromText(profileText)
    for profileNo = 1, PAG_MAX_PROFILES do
        if PA.savedVars.General[profileNo].name == profileText then
            return profileNo
        end
    end
    -- if nothing found, return 0
    return PAG_NO_PROFILE_SELECTED_ID -- TODO: change to profcount + 1?
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
		return "<Please select Profile>" -- TODO: replace with Locale
	end
end


-- --------------------------------------------------------------------------------------------------------

function MenuHelper.getActiveProfile()
    local activeProfile = PA.savedVars.Profile.activeProfile
    if (activeProfile == nil or activeProfile == "") then
        return PAG_NO_PROFILE_SELECTED_ID
    else
        return activeProfile
    end
end

function MenuHelper.loadProfile(profileNo)
    -- get the previously active prefoile first
    local prevProfile = PA.savedVars.Profile.activeProfile
    -- then save the new one
    PA.savedVars.Profile.activeProfile = profileNo
    PALogger.log("change activeProfile from -> "..tostring(prevProfile).." <- to -> "..tostring(profileNo).." <-")
    -- if the previous profile was the "no profile selected" one, refresh the dropdown values
    if (prevProfile == nil or prevProfile == PAG_NO_PROFILE_SELECTED_ID) then
        MenuHelper.reloadProfileList()
    end
end

function MenuHelper.renameProfile(profileText)
    if (profileText ~= nil and profileText ~= "") then
        PA.savedVars.General[PA.savedVars.Profile.activeProfile].name = profileText
        MenuHelper.reloadProfileList()
    end
end


