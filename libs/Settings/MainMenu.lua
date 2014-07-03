PA_SettingsMenu = {}

local LAM = LibStub("LibAddonMenu-1.0")
local LAM2 = LibStub("LibAddonMenu-2.0")

local panelData = {
	 type = "panel",
	 name = "PersonalAssistant",
	 displayName = PA.getResourceMessage("MMenu_Title"),
	 author = "Klingo",
	 version = PA.AddonVersion,
	 registerForRefresh  = true,
	 registerForDefaults = true,
}

local optionsTable = {}
local itemTypeSubmenuTable = {}
local itemTypeAdvancedSubmenuTable = {}


function PA_SettingsMenu.CreateOptions()

	-- create the menus with LAM-2
	PA_SettingsMenu.createItemSubMenu()
	PA_SettingsMenu.createItemAdvancedSubMenu()
	PA_SettingsMenu.createMainMenu()
	
	-- and register it
	LAM2:RegisterAddonPanel("PersonalAssistantAddonOptions", panelData)
	LAM2:RegisterOptionControls("PersonalAssistantAddonOptions", optionsTable)
end

function PA_SettingsMenu.createMainMenu()

	local tableIndex = 1

	optionsTable[tableIndex] = {
		type = "header",
		name = PA.getResourceMessage("PAGMenu_Header"),
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "dropdown",
		name = PA.getResourceMessage("PAGMenu_ActiveProfile"),
		tooltip = PA.getResourceMessage("PAGMenu_ActiveProfile_T"),
		choices = {PA.getResourceMessage("PAG_Profile1"), PA.getResourceMessage("PAG_Profile2"), PA.getResourceMessage("PAG_Profile3")},
		getFunc = function() return MenuHelper.getProfileTextFromNumber() end,
		setFunc = function(value) MenuHelper.loadProfile(value) end,
		default = PA.getResourceMessage("PAG_Profile1"),
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "checkbox",
		name = PA.getResourceMessage("PAGMenu_Welcome"),
		tooltip = PA.getResourceMessage("PAGMenu_Welcome_T"),
		getFunc = function() return PA_SavedVars.General[PA_SavedVars.General.activeProfile].welcome end,
		setFunc = function(value) PA_SavedVars.General[PA_SavedVars.General.activeProfile].welcome = value end,
		default = true,
	}
	tableIndex = tableIndex + 1
	
	-- ------------------------ --
	-- PersonalAssistant Repair --
	-- ------------------------ --
	optionsTable[tableIndex] = {
		type = "header",
		name = PA.getResourceMessage("PARMenu_Header"),
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "checkbox",
		name = PA.getResourceMessage("PARMenu_Enable"),
		tooltip = PA.getResourceMessage("PARMenu_Enable_T"),
		getFunc = function() return PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].enabled end,
		setFunc = function(value) PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].enabled = value end,
		default = true,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "checkbox",
		name = PA.getResourceMessage("PARMenu_RepairEq"),
		tooltip = PA.getResourceMessage("PARMenu_RepairEq_T"),
		getFunc = function() return PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].equipped end,
		setFunc = function(value) PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].equipped = value end,
		width = "half",
		disabled = function() return not PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].enabled end,
		default = true,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "slider",
		name = PA.getResourceMessage("PARMenu_RepairEqDura"),
		tooltip = PA.getResourceMessage("PARMenu_RepairEqDura_T"),
		min = 0,
		max = 100,
		step = 1,
		getFunc = function() return PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].equippedThreshold end,
		setFunc = function(value) PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].equippedThreshold = value end,
		width = "half",		
		disabled = function() return not (PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].equipped and PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].enabled) end,
		default = 75,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "checkbox",
		name = PA.getResourceMessage("PARMenu_RepairBa"),
		tooltip = PA.getResourceMessage("PARMenu_RepairBa_T"),
		getFunc = function() return PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].backpack end,
		setFunc = function(value) PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].backpack = value end,
		width = "half",
		disabled = function() return not PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].enabled end,
		default = false,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "slider",
		name = PA.getResourceMessage("PARMenu_RepairBaDura"),
		tooltip = PA.getResourceMessage("PARMenu_RepairBaDura_T"),
		min = 0,
		max = 100,
		step = 1,
		getFunc = function() return PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].backpackThreshold end,
		setFunc = function(value) PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].backpackThreshold = value end,
		width = "half",		
		disabled = function() return not (PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].backpack and PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].enabled) end,
		default = 75,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "checkbox",
		name = PA.getResourceMessage("PARMenu_HideNoRepair"),
		tooltip = PA.getResourceMessage("PARMenu_HideNoRepair_T"),
		getFunc = function() return PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].hideNoRepairMsg end,
		setFunc = function(value) PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].hideNoRepairMsg = value end,
		width = "half",
		disabled = function() return not PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].enabled end,
		default = false,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "checkbox",
		name = PA.getResourceMessage("PARMenu_HideAll"),
		tooltip = PA.getResourceMessage("PARMenu_HideAll_T"),
		getFunc = function() return PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].hideAllMsg end,
		setFunc = function(value) PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].hideAllMsg = value end,
		width = "half",
		disabled = function() return not PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].enabled end,
		default = false,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "header",
		name = PA.getResourceMessage("PABMenu_Header"),
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "checkbox",
		name = PA.getResourceMessage("PABMenu_Enable"),
		tooltip = PA.getResourceMessage("PABMenu_Enable_T"),
		getFunc = function() return PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled = value end,
		default = true,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "checkbox",
		name = PA.getResourceMessage("PABMenu_DepGold"),
		tooltip = PA.getResourceMessage("PABMenu_DepGold_T"),
		getFunc = function() return PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].gold end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].gold = value end,
		disabled = function() return not PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled end,
		default = true,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "editbox",
		name = PA.getResourceMessage("PABMenu_DepInterval"),
		tooltip = PA.getResourceMessage("PABMenu_DepInterval_T"),
		getFunc = function() return PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].goldDepositInterval end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].goldDepositInterval = tonumber(value) end,
		isMultiline = false,
		disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].gold) end,
		warning = PA.getResourceMessage("PABMenu_DepInterval_W"),
		default = 300,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "slider",
		name = PA.getResourceMessage("PABMenu_DepGoldPerc"),
		tooltip = PA.getResourceMessage("PABMenu_DepGoldPerc_T"),
		min = 1,
		max = 100,
		step = 1,
		getFunc = function() return PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].goldDepositPercentage end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].goldDepositPercentage = value end,
		disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].gold) end,
		default = 50,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "dropdown",
		name = PA.getResourceMessage("PABMenu_DepGoldSteps"),
		tooltip = PA.getResourceMessage("PABMenu_DepGoldSteps_T"),
		choices = {"1", "10", "100", "1000", "10000"},
		getFunc = function() return PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].goldTransactionStep end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].goldTransactionStep = tonumber(value) end,
		disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].gold) end,
		default = "1",
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "editbox",
		name = PA.getResourceMessage("PABMenu_DepGoldKeep"),
		tooltip = PA.getResourceMessage("PABMenu_DepGoldKeep_T"),
		getFunc = function() return PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].goldMinToKeep end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].goldMinToKeep = tonumber(value) end,
		isMultiline = false,
		disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].gold) end,
		warning = PA.getResourceMessage("PABMenu_DepGoldKeep_W"),
		default = "250",
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "checkbox",
		name = PA.getResourceMessage("PABMenu_WitGoldMin"),
		tooltip = PA.getResourceMessage("PABMenu_WitGoldMin_T"),
		getFunc = function() return PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].goldWithdraw end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].goldWithdraw = value end,
		disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].gold) end,
		default = false,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "checkbox",
		name = PA.getResourceMessage("PABMenu_DepWitItem"),
		tooltip = PA.getResourceMessage("PABMenu_DepWitItem_T"),
		getFunc = function() return PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].items end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].items = value end,
		disabled = function() return not PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled end,
		default = false,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "description",
		text = PA.getResourceMessage("PABMenu_DepItemTypeDesc"),
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "submenu",
		name = PA.getResourceMessage("PABMenu_DepItemType"),
		tooltip = PA.getResourceMessage("PABMenu_DepItemType_T"),
		controls = itemTypeSubmenuTable,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "submenu",
		name = PA.getResourceMessage("PABMenu_Advanced_DepItemType"),
		tooltip = PA.getResourceMessage("PABMenu_Advanced_DepItemType_T"),
		controls = itemTypeAdvancedSubmenuTable,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "slider",
		name = PA.getResourceMessage("PABMenu_DepItemTimerInterval"),
		tooltip = PA.getResourceMessage("PABMenu_DepItemTimerInterval_T"),
		min = 200,
		max = 1000,
		step = 50,
		getFunc = function() return PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].itemsTimerInterval end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].itemsTimerInterval = value end,
		disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].items) end,
		default = 300,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "checkbox",
		name = PA.getResourceMessage("PABMenu_HideNoDeposit"),
		tooltip = PA.getResourceMessage("PABMenu_HideNoDeposit_T"),
		getFunc = function() return PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].hideNoDepositMsg end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].hideNoDepositMsg = value end,
		width = "half",
		disabled = function() return not PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled end,
		default = false,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "checkbox",
		name = PA.getResourceMessage("PABMenu_HideAll"),
		tooltip = PA.getResourceMessage("PABMenu_HideAll_T"),
		getFunc = function() return PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].hideAllMsg end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].hideAllMsg = value end,
		width = "half",
		disabled = function() return not PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled end,
		default = false,
	}
end

function PA_SettingsMenu.createItemSubMenu()
	local tableIndex = 1
	
	itemTypeSubmenuTable[tableIndex] = {
		type = "header",
		name = PA.getResourceMessage("PABMenu_ItemJunk_Header"),
	}
	tableIndex = tableIndex + 1
	
	itemTypeSubmenuTable[tableIndex] = {
		type = "dropdown",
		name = PA.getResourceMessage("PABMenu_DepItemJunk"),
		tooltip = PA.getResourceMessage("PABMenu_DepItemJunk_T"),
		choices = {PA.getResourceMessage("PAB_ItemType_None"), PA.getResourceMessage("PAB_ItemType_Deposit"), PA.getResourceMessage("PAB_ItemType_Withdrawal"), PA.getResourceMessage("PAB_ItemType_Inherit")},
		getFunc = function() return MenuHelper.getBankingTextFromNumber() end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].itemsJunkSetting = MenuHelper.getBankingNumberFromText(value) end,
		disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].items) end,
		default = PA.getResourceMessage("PAB_ItemType_None"),
	}
	tableIndex = tableIndex + 1
	
	itemTypeSubmenuTable[tableIndex] = {
		type = "header",
		name = PA.getResourceMessage("PABMenu_ItemType_Header"),
	}
	
	local innerIndex = tableIndex + 1
	for i = 0, #PAItemTypes do
		-- only add if the itemType is enabled
		if PAItemTypes[i] ~= "" then
			itemTypeSubmenuTable[innerIndex] = {
				type = "dropdown",
				name = PA.getResourceMessage(PAItemTypes[i]),
				tooltip = "",
				choices = {PA.getResourceMessage("PAB_ItemType_None"), PA.getResourceMessage("PAB_ItemType_Deposit"), PA.getResourceMessage("PAB_ItemType_Withdrawal")},
				getFunc = function() return MenuHelper.getBankingTextFromNumber(i) end,
				setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].ItemTypes[i] = MenuHelper.getBankingNumberFromText(value) end,
				width = "half",
				disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].items) end,
				default = PA.getResourceMessage("PAB_ItemType_None"),
			}		
			innerIndex = innerIndex +1
		end
	end
	
	itemTypeSubmenuTable[innerIndex] = {
		type = "button",
		name = PA.getResourceMessage("PABMenu_DepButton"),
		tooltip = PA.getResourceMessage("PABMenu_DepButton_T"),
		func = function() MenuHelper.setDepositAll() end,
		disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].items) end,
		warning = PA.getResourceMessage("PABMenu_DepButton_W")
	}
	itemTypeSubmenuTable[innerIndex + 1] = {
		type = "button",
		name = PA.getResourceMessage("PABMenu_WitButton"),
		tooltip = PA.getResourceMessage("PABMenu_WitButton_T"),
		func = function() MenuHelper.setWithdrawalAll() end,
		disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].items) end,
		warning = PA.getResourceMessage("PABMenu_WitButton_W")
	}
	itemTypeSubmenuTable[innerIndex + 2] = {
		type = "button",
		name = PA.getResourceMessage("PABMenu_IgnButton"),
		tooltip = PA.getResourceMessage("PABMenu_IgnButton_T"),
		func = function() MenuHelper.setIgnoreAll() end,
		disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].items) end,
		warning = PA.getResourceMessage("PABMenu_IgnButton_W")
	}
end

function PA_SettingsMenu.createItemAdvancedSubMenu()
end