MenuHelper = {}

function MenuHelper.setDepositAll()
	MenuHelper.setDropdownsTo(PAC_ITEMTYPE_DEPOSIT)
end

function MenuHelper.setWithdrawalAll()
	MenuHelper.setDropdownsTo(PAC_ITEMTYPE_WITHDRAWAL)
end

function MenuHelper.setIgnoreAll()
	MenuHelper.setDropdownsTo(PAC_ITEMTYPE_IGNORE)
end

function MenuHelper.setDropdownsTo(itemTypeKey)
	local profileNo = PA_SavedVars.General.activeProfile
	for i = 0, #PAItemTypes do
		-- only if the itemType is enabled
		if PAItemTypes[i] ~= "" then
			PA_SavedVars.Banking[profileNo].ItemTypes[i] = itemTypeKey
		end
	end
end

function MenuHelper.loadProfile(profileText)
	-- first update the active profile in the savedVars
	PA_SavedVars.General.activeProfile = MenuHelper.getProfileNumberFromText(profileText)
end

function MenuHelper.renameProfile(profileText)
	PA_SavedVars.Profiles[PA_SavedVars.General.activeProfile].name = profileText
	ReloadUI()
end

function MenuHelper.loadProfileNumber(profileNumber)
	PA_SavedVars.General.activeProfile = profileNumber
end


-- --------------------------------------------------------------------------------------------------------

-- returns the matching dropdown-text based on the number that is behind it
function MenuHelper.getBankingTextFromNumber(number)
	local profileNo = PA_SavedVars.General.activeProfile
	local index = PA_SavedVars.Banking[profileNo].itemsJunkSetting
	-- if "number" is empty, it has to be the junkSetting
	if (number ~= nil) then
		index = PA_SavedVars.Banking[profileNo].ItemTypes[number]
	end
	
	if index == PAC_ITEMTYPE_DEPOSIT then
		return PAL.getResourceMessage("PAB_ItemType_Deposit")
	elseif index == PAC_ITEMTYPE_WITHDRAWAL then
		return PAL.getResourceMessage("PAB_ItemType_Withdrawal")
	elseif index == PAC_ITEMTYPE_INHERIT then
		return PAL.getResourceMessage("PAB_ItemType_Inherit")
	else
		return PAL.getResourceMessage("PAB_ItemType_None")
	end
end

-- returns the number behind the text, depending on the text
function MenuHelper.getBankingNumberFromText(text)
	if text == PAL.getResourceMessage("PAB_ItemType_Deposit") then
		return PAC_ITEMTYPE_DEPOSIT		-- = Deposit
	elseif text == PAL.getResourceMessage("PAB_ItemType_Withdrawal") then
		return PAC_ITEMTYPE_WITHDRAWAL	-- = Withdrawal
	elseif text == PAL.getResourceMessage("PAB_ItemType_Inherit") then
		return PAC_ITEMTYPE_INHERIT		-- = Inherit
	else
		return PAC_ITEMTYPE_IGNORE		-- = Ignore
	end
end

-- --------------------------------------------------------------------------------------------------------

-- returns the matching dropdown-text based on the number that is behind it
function MenuHelper.getOperatorTextFromNumber(number)
	local profileNo = PA_SavedVars.General.activeProfile
	local index = PA_SavedVars.Banking[profileNo].ItemTypesAdvanced[number].Key
	
	if index == PAC_OPERATOR_EQUAL then
		return PAL.getResourceMessage("REL_Equal")
	elseif index == PAC_OPERATOR_LESSTHAN then
		return PAL.getResourceMessage("REL_LessThan")
	elseif index == PAC_OPERATOR_LESSTAHNEQAL then
		return PAL.getResourceMessage("REL_LessThanEqual")
	elseif index == PAC_OPERATOR_GREATERTHAN then
		return PAL.getResourceMessage("REL_GreaterThan")
	elseif index == PAC_OPERATOR_GREATERTHANEQUAL then
		return PAL.getResourceMessage("REL_GreaterThanEqual")
	else
		return PAL.getResourceMessage("REL_None")
	end
end

-- returns the number behind the text, depending on the text
function MenuHelper.getOperatorNumberFromText(text)
	if text == PAL.getResourceMessage("REL_Equal") then
		return PAC_OPERATOR_EQUAL
	elseif text == PAL.getResourceMessage("REL_LessThan") then
		return PAC_OPERATOR_LESSTHAN
	elseif text == PAL.getResourceMessage("REL_LessThanEqual") then
		return PAC_OPERATOR_LESSTAHNEQAL
	elseif text == PAL.getResourceMessage("REL_GreaterThan") then
		return PAC_OPERATOR_GREATERTHAN
	elseif text == PAL.getResourceMessage("REL_GreaterThanEqual") then
		return PAC_OPERATOR_GREATERTHANEQUAL
	else
		return PAC_OPERATOR_NONE
	end
end

-- --------------------------------------------------------------------------------------------------------

-- returns the matching dropdown-text based on the number that is behind it
function MenuHelper.getStackTypeTextFromNumber(index)
	if index == PAB_STACKING_CONTINUE then
		return PAL.getResourceMessage("ST_MoveExistingFull")
	elseif index == PAB_STACKING_INCOMPLETE then
		return PAL.getResourceMessage("ST_FillIncompleteOnly")
	else
		return PAL.getResourceMessage("ST_MoveAllFull")
	end
end

-- returns the number behind the text, depending on the text
function MenuHelper.getStackTypeNumberFromText(text)
	if text == PAL.getResourceMessage("ST_MoveExistingFull") then
		return PAB_STACKING_CONTINUE
	elseif text == PAL.getResourceMessage("ST_FillIncompleteOnly") then
		return PAB_STACKING_INCOMPLETE
	else
		return PAB_STACKING_FULL
	end
end

-- --------------------------------------------------------------------------------------------------------

function MenuHelper.getProfileList()
	local profiles = {}
	for profileNo = 1, PAG_MAX_PROFILES do
		profiles[profileNo] = PA_SavedVars.Profiles[profileNo].name
	end
	return profiles
end

function MenuHelper.getProfileTextFromNumber(number)
	local profileNo = PA_SavedVars.General.activeProfile
	if (number ~= nil) then
		profileNo = number
	end
	
	return PA_SavedVars.Profiles[profileNo].name
end

function MenuHelper.getDefaultProfileName(profileNo)
	if profileNo == 2 then
		return PAL.getResourceMessage("PAG_Profile2")
	elseif profileNo == 3 then
		return PAL.getResourceMessage("PAG_Profile3")
	else
		return PAL.getResourceMessage("PAG_Profile1")
	end
end

function MenuHelper.getProfileNumberFromText(profileText)
	for profileNo = 1, PAG_MAX_PROFILES do
		if PA_SavedVars.Profiles[profileNo].name == profileText then
			return profileNo
		end
	end
	-- if nothing found, return 1
	return 1
end