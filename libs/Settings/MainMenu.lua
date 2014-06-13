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

local itemTypeSubmenuTable = {}

local optionsTable = {
	[1] = {
		type = "header",
		name = PA.getResourceMessage("PAGMenu_Header"),
	},
	[2] = {
		type = "checkbox",
		name = PA.getResourceMessage("PAGMenu_Welcome"),
		tooltip = PA.getResourceMessage("PAGMenu_Welcome_T"),
		getFunc = function() return PA_SavedVars.General.welcome end,
		setFunc = function(value) PA_SavedVars.General.welcome = value end,
		default = true,
	},
	[3] = {
		type = "header",
		name = PA.getResourceMessage("PARMenu_Header"),
	},
	[4] = {
		type = "checkbox",
		name = PA.getResourceMessage("PARMenu_Enable"),
		tooltip = PA.getResourceMessage("PARMenu_Enable_T"),
		getFunc = function() return PA_SavedVars.Repair.enabled end,
		setFunc = function(value) PA_SavedVars.Repair.enabled = value end,
		default = true,
	},
	[5] = {
		type = "checkbox",
		name = PA.getResourceMessage("PARMenu_RepairEq"),
		tooltip = PA.getResourceMessage("PARMenu_RepairEq_T"),
		getFunc = function() return PA_SavedVars.Repair.equipped end,
		setFunc = function(value) PA_SavedVars.Repair.equipped = value end,
		width = "half",
		disabled = function() return not PA_SavedVars.Repair.enabled end,
		default = true,
	},
	[6] = {
		type = "slider",
		name = PA.getResourceMessage("PARMenu_RepairEqDura"),
		tooltip = PA.getResourceMessage("PARMenu_RepairEqDura_T"),
		min = 0,
		max = 100,
		step = 1,
		getFunc = function() return PA_SavedVars.Repair.equippedThreshold end,
		setFunc = function(value) PA_SavedVars.Repair.equippedThreshold = value end,
		width = "half",		
		disabled = function() return not (PA_SavedVars.Repair.equipped and PA_SavedVars.Repair.enabled) end,
		default = 75,
	},
	[7] = {
		type = "checkbox",
		name = PA.getResourceMessage("PARMenu_RepairBa"),
		tooltip = PA.getResourceMessage("PARMenu_RepairBa_T"),
		getFunc = function() return PA_SavedVars.Repair.backpack end,
		setFunc = function(value) PA_SavedVars.Repair.backpack = value end,
		width = "half",
		disabled = function() return not PA_SavedVars.Repair.enabled end,
		default = false,
	},
	[8] = {
		type = "slider",
		name = PA.getResourceMessage("PARMenu_RepairBaDura"),
		tooltip = PA.getResourceMessage("PARMenu_RepairBaDura_T"),
		min = 0,
		max = 100,
		step = 1,
		getFunc = function() return PA_SavedVars.Repair.backpackThreshold end,
		setFunc = function(value) PA_SavedVars.Repair.backpackThreshold = value end,
		width = "half",		
		disabled = function() return not (PA_SavedVars.Repair.backpack and PA_SavedVars.Repair.enabled) end,
		default = 75,
	},
	[9] = {
		type = "checkbox",
		name = PA.getResourceMessage("PARMenu_HideNoRepair"),
		tooltip = PA.getResourceMessage("PARMenu_HideNoRepair_T"),
		getFunc = function() return PA_SavedVars.Repair.hideNoRepairMsg end,
		setFunc = function(value) PA_SavedVars.Repair.hideNoRepairMsg = value end,
		width = "half",
		disabled = function() return not PA_SavedVars.Repair.enabled end,
		default = false,
	},
	[10] = {
		type = "checkbox",
		name = PA.getResourceMessage("PARMenu_HideAll"),
		tooltip = PA.getResourceMessage("PARMenu_HideAll_T"),
		getFunc = function() return PA_SavedVars.Repair.hideAllMsg end,
		setFunc = function(value) PA_SavedVars.Repair.hideAllMsg = value end,
		width = "half",
		disabled = function() return not PA_SavedVars.Repair.enabled end,
		default = false,
	},
	[11] = {
		type = "header",
		name = PA.getResourceMessage("PABMenu_Header"),
	},
	[12] = {
		type = "checkbox",
		name = PA.getResourceMessage("PABMenu_Enable"),
		tooltip = PA.getResourceMessage("PABMenu_Enable_T"),
		getFunc = function() return PA_SavedVars.Banking.enabled end,
		setFunc = function(value) PA_SavedVars.Banking.enabled = value end,
		default = true,
	},
	[13] = {
		type = "checkbox",
		name = PA.getResourceMessage("PABMenu_DepGold"),
		tooltip = PA.getResourceMessage("PABMenu_DepGold_T"),
		getFunc = function() return PA_SavedVars.Banking.gold end,
		setFunc = function(value) PA_SavedVars.Banking.gold = value end,
		disabled = function() return not PA_SavedVars.Banking.enabled end,
		default = true,
	},
	[14] = {
		type = "editbox",
		name = PA.getResourceMessage("PABMenu_DepInterval"),
		tooltip = PA.getResourceMessage("PABMenu_DepInterval_T"),
		getFunc = function() return PA_SavedVars.Banking.goldDepositInterval end,
		setFunc = function(value) PA_SavedVars.Banking.goldDepositInterval = tonumber(value) end,
		isMultiline = false,
		disabled = function() return not (PA_SavedVars.Banking.enabled and PA_SavedVars.Banking.gold) end,
		warning = PA.getResourceMessage("PABMenu_DepInterval_W"),
		default = 300,
	},
	[15] = {
		type = "slider",
		name = PA.getResourceMessage("PABMenu_DepGoldPerc"),
		tooltip = PA.getResourceMessage("PABMenu_DepGoldPerc_T"),
		min = 1,
		max = 100,
		step = 1,
		getFunc = function() return PA_SavedVars.Banking.goldDepositPercentage end,
		setFunc = function(value) PA_SavedVars.Banking.goldDepositPercentage = value end,
		disabled = function() return not (PA_SavedVars.Banking.enabled and PA_SavedVars.Banking.gold) end,
		default = 50,
	},
	[16] = {
		type = "dropdown",
		name = PA.getResourceMessage("PABMenu_DepGoldSteps"),
		tooltip = PA.getResourceMessage("PABMenu_DepGoldSteps_T"),
		choices = {"1", "10", "100", "1000", "10000"},
		getFunc = function() return PA_SavedVars.Banking.goldTransactionStep end,
		setFunc = function(value) PA_SavedVars.Banking.goldTransactionStep = tonumber(value) end,
		disabled = function() return not (PA_SavedVars.Banking.enabled and PA_SavedVars.Banking.gold) end,
		default = "1",
	},
	[17] = {
		type = "editbox",
		name = PA.getResourceMessage("PABMenu_DepGoldKeep"),
		tooltip = PA.getResourceMessage("PABMenu_DepGoldKeep_T"),
		getFunc = function() return PA_SavedVars.Banking.goldMinToKeep end,
		setFunc = function(value) PA_SavedVars.Banking.goldMinToKeep = tonumber(value) end,
		isMultiline = false,
		disabled = function() return not (PA_SavedVars.Banking.enabled and PA_SavedVars.Banking.gold) end,
		warning = PA.getResourceMessage("PABMenu_DepGoldKeep_W"),
		default = "250",
	},
	[18] = {
		type = "checkbox",
		name = PA.getResourceMessage("PABMenu_WitGoldMin"),
		tooltip = PA.getResourceMessage("PABMenu_WitGoldMin_T"),
		getFunc = function() return PA_SavedVars.Banking.goldWithdraw end,
		setFunc = function(value) PA_SavedVars.Banking.goldWithdraw = value end,
		disabled = function() return not (PA_SavedVars.Banking.enabled and PA_SavedVars.Banking.gold) end,
		default = false,
	},
	[19] = {
		type = "checkbox",
		name = PA.getResourceMessage("PABMenu_DepWitItem"),
		tooltip = PA.getResourceMessage("PABMenu_DepWitItem_T"),
		getFunc = function() return PA_SavedVars.Banking.items end,
		setFunc = function(value) PA_SavedVars.Banking.items = value end,
		disabled = function() return not PA_SavedVars.Banking.enabled end,
		default = false,
	},
	[20] = {
		type = "submenu",
		name = PA.getResourceMessage("PABMenu_DepItemType"),
		tooltip = PA.getResourceMessage("PABMenu_DepItemType_T"),
		controls = itemTypeSubmenuTable,
	},
	[21] = {
		type = "slider",
		name = PA.getResourceMessage("PABMenu_DepItemTImerInterval"),
		tooltip = PA.getResourceMessage("PABMenu_DepItemTImerInterval_T"),
		min = 200,
		max = 1000,
		step = 50,
		getFunc = function() return PA_SavedVars.Banking.itemsTimerInterval end,
		setFunc = function(value) PA_SavedVars.Banking.itemsTimerInterval = value end,
		disabled = function() return not (PA_SavedVars.Banking.enabled and PA_SavedVars.Banking.items) end,
		default = 300,
	},
	[22] = {
		type = "checkbox",
		name = PA.getResourceMessage("PABMenu_HideNoDeposit"),
		tooltip = PA.getResourceMessage("PABMenu_HideNoDeposit_T"),
		getFunc = function() return PA_SavedVars.Banking.hideNoDepositMsg end,
		setFunc = function(value) PA_SavedVars.Banking.hideNoDepositMsg = value end,
		width = "half",
		disabled = function() return not PA_SavedVars.Banking.enabled end,
		default = false,
	},
	[23] = {
		type = "checkbox",
		name = PA.getResourceMessage("PABMenu_HideAll"),
		tooltip = PA.getResourceMessage("PABMenu_HideAll_T"),
		getFunc = function() return PA_SavedVars.Banking.hideAllMsg end,
		setFunc = function(value) PA_SavedVars.Banking.hideAllMsg = value end,
		width = "half",
		disabled = function() return not PA_SavedVars.Banking.enabled end,
		default = false,
	},
}


function PA_SettingsMenu.CreateOptions()
	-- first register the panel with LAM
    local PAPanel = LAM:CreateControlPanel("PA_Panel", PA.getResourceMessage("MMenu_Title"))

	PA_SettingsMenu.createItemSubMenu()
	
	LAM2:RegisterAddonPanel("PersonalAssistantAddonOptions", panelData)
	LAM2:RegisterOptionControls("PersonalAssistantAddonOptions", optionsTable)
	
	-- then delay the actual creation of the option items by 1 second to reduce the anchor overload at startup
	zo_callLater(function() PA_SettingsMenu.CreateOptionItems(PAPanel) end, 1000)
end

function PA_SettingsMenu.createItemSubMenu()

	itemTypeSubmenuTable[1] = {
		type = "header",
		name = PA.getResourceMessage("PABMenu_ItemJunk_Header"),
	}
	itemTypeSubmenuTable[2] = {
		type = "dropdown",
		name = PA.getResourceMessage("PABMenu_DepItemJunk"),
		tooltip = PA.getResourceMessage("PABMenu_DepItemJunk_T"),
		choices = {PA.getResourceMessage("PAB_ItemType_None"), PA.getResourceMessage("PAB_ItemType_Deposit"), PA.getResourceMessage("PAB_ItemType_Withdrawal"), PA.getResourceMessage("PAB_ItemType_Inherit")},
		getFunc = function() return PABMenu.getBankingTextFromNumber() end,
		setFunc = function(value) PA_SavedVars.Banking.itemsJunkSetting = PABMenu.getBankingNumberFromText(value) end,
		disabled = function() return not (PA_SavedVars.Banking.enabled and PA_SavedVars.Banking.items) end,
		default = PA.getResourceMessage("PAB_ItemType_None"),
		
	}
	itemTypeSubmenuTable[3] = {
		type = "header",
		name = PA.getResourceMessage("PABMenu_ItemType_Header"),
	}
	
	local innerIndex = 4
	for i = 0, #PAItemTypes do
		-- only add if the itemType is enabled
		if PAItemTypes[i] ~= "" then
			itemTypeSubmenuTable[innerIndex] = {
				type = "dropdown",
				name = PA.getResourceMessage(PAItemTypes[i]),
				tooltip = "",
				choices = {PA.getResourceMessage("PAB_ItemType_None"), PA.getResourceMessage("PAB_ItemType_Deposit"), PA.getResourceMessage("PAB_ItemType_Withdrawal")},
				getFunc = function() return PABMenu.getBankingTextFromNumber(i) end,
				setFunc = function(value) PA_SavedVars.Banking.ItemTypes[i] = PABMenu.getBankingNumberFromText(value) end,
				width = "half",
				disabled = function() return not (PA_SavedVars.Banking.enabled and PA_SavedVars.Banking.items) end,
				default = PA.getResourceMessage("PAB_ItemType_None"),
			}		
			innerIndex = innerIndex +1
		end
	end
	
	itemTypeSubmenuTable[innerIndex] = {
		type = "button",
		name = PA.getResourceMessage("PABMenu_DepButton"),
		tooltip = PA.getResourceMessage("PABMenu_DepButton_T"),
		func = function() PABMenu.setDepositAll() end,
		disabled = function() return not (PA_SavedVars.Banking.enabled and PA_SavedVars.Banking.items) end,
		warning = PA.getResourceMessage("PABMenu_DepButton_W")
	}
	itemTypeSubmenuTable[innerIndex + 1] = {
		type = "button",
		name = PA.getResourceMessage("PABMenu_WitButton"),
		tooltip = PA.getResourceMessage("PABMenu_WitButton_T"),
		func = function() PABMenu.setWithdrawalAll() end,
		disabled = function() return not (PA_SavedVars.Banking.enabled and PA_SavedVars.Banking.items) end,
		warning = PA.getResourceMessage("PABMenu_WitButton_W")
	}
	itemTypeSubmenuTable[innerIndex + 2] = {
		type = "button",
		name = PA.getResourceMessage("PABMenu_IgnButton"),
		tooltip = PA.getResourceMessage("PABMenu_IgnButton_T"),
		func = function() PABMenu.setIgnoreAll() end,
		disabled = function() return not (PA_SavedVars.Banking.enabled and PA_SavedVars.Banking.items) end,
		warning = PA.getResourceMessage("PABMenu_IgnButton_W")
	}
end

function PA_SettingsMenu.CreateOptionItems(PAPanel)

	-- PAGeneral
	LAM:AddHeader(PAPanel, "PAG_Header", PA.getResourceMessage("PAGMenu_Header"))
	LAM:AddCheckbox(PAPanel, "PA_Welcome_Enabled", PA.getResourceMessage("PAGMenu_Welcome"), PA.getResourceMessage("PAGMenu_Welcome_T"),
				function() return PA_SavedVars.General.welcome end,
				function(val) PA_SavedVars.General.welcome = val end)

	-- PARepair
    LAM:AddHeader(PAPanel, "PAR_Header", PA.getResourceMessage("PARMenu_Header"))
	PARMenu.createMenu(LAM, PAPanel)
	
	-- PABanking
	LAM:AddHeader(PAPanel, "PAB_Header", PA.getResourceMessage("PABMenu_Header"))
	PABMenu.createMenu(LAM, PAPanel)
end