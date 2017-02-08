PA_SettingsMenu = {}

local LAM2 = LibStub("LibAddonMenu-2.0")

local panelData = {
	 type = "panel",
	 name = "PersonalAssistant",
	 displayName = PAL.getResourceMessage("MMenu_Title"),
	 author = "Klingo",
	 version = PA.AddonVersion,
	 registerForRefresh  = true,
	 registerForDefaults = true,
}

local optionsTable = {}
local PABItemTypeSubmenuTable = {}
local PABItemTypeAdvancedSubmenuTable = {}
local PALoItemTypeSubmenuTable = {}


function PA_SettingsMenu.CreateOptions()

	-- create the menus with LAM-2
	PA_SettingsMenu.createPABItemSubMenu()
	PA_SettingsMenu.createPABItemAdvancedSubMenu()
    PA_SettingsMenu.createPALoItemSubMenu()
	PA_SettingsMenu.createMainMenu()
	
	-- and register it
	LAM2:RegisterAddonPanel("PersonalAssistantAddonOptions", panelData)
	LAM2:RegisterOptionControls("PersonalAssistantAddonOptions", optionsTable)
end

function PA_SettingsMenu.createMainMenu()

	local tableIndex = 1

	optionsTable[tableIndex] = {
		type = "header",
		name = PAL.getResourceMessage("PAGMenu_Header"),
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "dropdown",
		name = PAL.getResourceMessage("PAGMenu_ActiveProfile"),
		tooltip = PAL.getResourceMessage("PAGMenu_ActiveProfile_T"),
		--choices = {PAL.getResourceMessage("PAG_Profile1"), PAL.getResourceMessage("PAG_Profile2"), PAL.getResourceMessage("PAG_Profile3")},
		choices = MenuHelper.getProfileList(),
		getFunc = function() return MenuHelper.getProfileTextFromNumber() end,
		setFunc = function(value) MenuHelper.loadProfile(value) end,
		width = "half",
		default = PAL.getResourceMessage("PAG_Profile1"),
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "editbox",
		name = PAL.getResourceMessage("PAGMenu_ActiveProfileRename"),
		tooltip = PAL.getResourceMessage("PAGMenu_ActiveProfileRename_T"),
		getFunc = function() return PA_SavedVars.Profiles[PA_SavedVars.General.activeProfile].name end,
		setFunc = function(value) MenuHelper.renameProfile(tostring(value)) end,
		isMultiline = false,
		width = "half",
		warning = PAL.getResourceMessage("PAGMenu_ActiveProfileRename_W"),
		default = PA_SavedVars.Profiles[1].name,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "checkbox",
		name = PAL.getResourceMessage("PAGMenu_Welcome"),
		tooltip = PAL.getResourceMessage("PAGMenu_Welcome_T"),
		getFunc = function() return PA_SavedVars.General[PA_SavedVars.General.activeProfile].welcome end,
		setFunc = function(value) PA_SavedVars.General[PA_SavedVars.General.activeProfile].welcome = value end,
		default = true,
	}
	tableIndex = tableIndex + 1

    -- =================================================================================================================
	
	-- ------------------------ --
	-- PersonalAssistant Repair --
	-- ------------------------ --
	optionsTable[tableIndex] = {
		type = "header",
		name = PAL.getResourceMessage("PARMenu_Header"),
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "checkbox",
		name = PAL.getResourceMessage("PARMenu_Enable"),
		tooltip = PAL.getResourceMessage("PARMenu_Enable_T"),
		getFunc = function() return PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].enabled end,
		setFunc = function(value) PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].enabled = value end,
		default = true,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "checkbox",
		name = PAL.getResourceMessage("PARMenu_RepairEq"),
		tooltip = PAL.getResourceMessage("PARMenu_RepairEq_T"),
		getFunc = function() return PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].equipped end,
		setFunc = function(value) PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].equipped = value end,
		width = "half",
		disabled = function() return not PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].enabled end,
		default = true,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "slider",
		name = PAL.getResourceMessage("PARMenu_RepairEqDura"),
		tooltip = PAL.getResourceMessage("PARMenu_RepairEqDura_T"),
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
		name = PAL.getResourceMessage("PARMenu_RepairBa"),
		tooltip = PAL.getResourceMessage("PARMenu_RepairBa_T"),
		getFunc = function() return PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].backpack end,
		setFunc = function(value) PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].backpack = value end,
		width = "half",
		disabled = function() return not PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].enabled end,
		default = false,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "slider",
		name = PAL.getResourceMessage("PARMenu_RepairBaDura"),
		tooltip = PAL.getResourceMessage("PARMenu_RepairBaDura_T"),
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
		name = PAL.getResourceMessage("PARMenu_HideNoRepair"),
		tooltip = PAL.getResourceMessage("PARMenu_HideNoRepair_T"),
		getFunc = function() return PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].hideNoRepairMsg end,
		setFunc = function(value) PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].hideNoRepairMsg = value end,
		width = "half",
		disabled = function() return not PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].enabled end,
		default = false,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "checkbox",
		name = PAL.getResourceMessage("PARMenu_HideAll"),
		tooltip = PAL.getResourceMessage("PARMenu_HideAll_T"),
		getFunc = function() return PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].hideAllMsg end,
		setFunc = function(value) PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].hideAllMsg = value end,
		width = "half",
		disabled = function() return not PA_SavedVars.Repair[PA_SavedVars.General.activeProfile].enabled end,
		default = false,
	}
	tableIndex = tableIndex + 1

    -- =================================================================================================================

    -- ------------------------- --
    -- PersonalAssistant Banking --
    -- ------------------------- --
	optionsTable[tableIndex] = {
		type = "header",
		name = PAL.getResourceMessage("PABMenu_Header"),
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "checkbox",
		name = PAL.getResourceMessage("PABMenu_Enable"),
		tooltip = PAL.getResourceMessage("PABMenu_Enable_T"),
		getFunc = function() return PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled = value end,
		default = true,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "checkbox",
		name = PAL.getResourceMessage("PABMenu_DepGold"),
		tooltip = PAL.getResourceMessage("PABMenu_DepGold_T"),
		getFunc = function() return PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].gold end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].gold = value end,
		disabled = function() return not PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled end,
		default = true,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "editbox",
		name = PAL.getResourceMessage("PABMenu_DepInterval"),
		tooltip = PAL.getResourceMessage("PABMenu_DepInterval_T"),
		getFunc = function() return PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].goldDepositInterval end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].goldDepositInterval = tonumber(value) end,
		isMultiline = false,
		disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].gold) end,
		warning = PAL.getResourceMessage("PABMenu_DepInterval_W"),
		default = 300,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "slider",
		name = PAL.getResourceMessage("PABMenu_DepGoldPerc"),
		tooltip = PAL.getResourceMessage("PABMenu_DepGoldPerc_T"),
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
		name = PAL.getResourceMessage("PABMenu_DepGoldSteps"),
		tooltip = PAL.getResourceMessage("PABMenu_DepGoldSteps_T"),
		choices = {"1", "10", "100", "1000", "10000"},
		getFunc = function() return PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].goldTransactionStep end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].goldTransactionStep = value end,
		disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].gold) end,
		default = "1",
	}
	tableIndex = tableIndex + 1

	optionsTable[tableIndex] = {
		type = "editbox",
		name = PAL.getResourceMessage("PABMenu_DepGoldKeep"),
		tooltip = PAL.getResourceMessage("PABMenu_DepGoldKeep_T"),
		getFunc = function() return PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].goldMinToKeep end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].goldMinToKeep = tonumber(value) end,
		isMultiline = false,
		disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].gold) end,
		warning = PAL.getResourceMessage("PABMenu_DepGoldKeep_W"),
		default = "250",
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "checkbox",
		name = PAL.getResourceMessage("PABMenu_WitGoldMin"),
		tooltip = PAL.getResourceMessage("PABMenu_WitGoldMin_T"),
		getFunc = function() return PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].goldWithdraw end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].goldWithdraw = value end,
		disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].gold) end,
		default = false,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "checkbox",
		name = PAL.getResourceMessage("PABMenu_DepWitItem"),
		tooltip = PAL.getResourceMessage("PABMenu_DepWitItem_T"),
		getFunc = function() return PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].items end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].items = value end,
		disabled = function() return not PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled end,
		default = false,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "description",
		text = PAL.getResourceMessage("PABMenu_DepItemTypeDesc"),
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "submenu",
		name = PAL.getResourceMessage("PABMenu_DepItemType"),
		tooltip = PAL.getResourceMessage("PABMenu_DepItemType_T"),
		controls = PABItemTypeSubmenuTable,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "submenu",
		name = PAL.getResourceMessage("PABMenu_Advanced_DepItemType"),
		tooltip = PAL.getResourceMessage("PABMenu_Advanced_DepItemType_T"),
		controls = PABItemTypeAdvancedSubmenuTable,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "slider",
		name = PAL.getResourceMessage("PABMenu_DepItemTimerInterval"),
		tooltip = PAL.getResourceMessage("PABMenu_DepItemTimerInterval_T"),
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
		name = PAL.getResourceMessage("PABMenu_HideNoDeposit"),
		tooltip = PAL.getResourceMessage("PABMenu_HideNoDeposit_T"),
		getFunc = function() return PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].hideNoDepositMsg end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].hideNoDepositMsg = value end,
		width = "half",
		disabled = function() return not PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled end,
		default = false,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "checkbox",
		name = PAL.getResourceMessage("PABMenu_HideAll"),
		tooltip = PAL.getResourceMessage("PABMenu_HideAll_T"),
		getFunc = function() return PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].hideAllMsg end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].hideAllMsg = value end,
		width = "half",
		disabled = function() return not PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled end,
		default = false,
	}
	tableIndex = tableIndex + 1

    -- =================================================================================================================

    -- ---------------------- --
    -- PersonalAssistant Loot --
    -- ---------------------- --
	optionsTable[tableIndex] = {
		type = "header",
		name = PAL.getResourceMessage("PALoMenu_Header"),
	}
	tableIndex = tableIndex + 1

    optionsTable[tableIndex] = {
        type = "checkbox",
        name = PAL.getResourceMessage("PALoMenu_Enable"),
        tooltip = PAL.getResourceMessage("PALoMenu_Enable_T"),
        getFunc = function() return PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].enabled end,
        setFunc = function(value) PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].enabled = value end,
        default = false,
    }
    tableIndex = tableIndex + 1

    optionsTable[tableIndex] = {
        type = "checkbox",
        name = PAL.getResourceMessage("PALoMenu_LootGold"),
        tooltip = PAL.getResourceMessage("PALoMenu_LootGold_T"),
        getFunc = function() return PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].lootGold end,
        setFunc = function(value) PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].lootGold = value end,
        width = "half",
        disabled = function() return not PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].enabled end,
        default = true,
    }
    tableIndex = tableIndex + 1

    optionsTable[tableIndex] = {
        type = "checkbox",
        name = PAL.getResourceMessage("PALoMenu_LootItems"),
        tooltip = PAL.getResourceMessage("PALoMenu_LootItems_T"),
        getFunc = function() return PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].lootItems end,
        setFunc = function(value) PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].lootItems = value end,
        width = "half",
        disabled = function() return not PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].enabled end,
        default = true,
    }
    tableIndex = tableIndex + 1

    optionsTable[tableIndex] = {
        type = "description",
        text = PAL.getResourceMessage("PALoMenu_ItemTypeDesc"),
    }
    tableIndex = tableIndex + 1

    optionsTable[tableIndex] = {
        type = "submenu",
        name = PAL.getResourceMessage("PALoMenu_ItemType"),
        tooltip = PAL.getResourceMessage("PALoMenu_ItemType_T"),
        controls = PALoItemTypeSubmenuTable,
    }
    tableIndex = tableIndex + 1

    optionsTable[tableIndex] = {
        type = "checkbox",
        name = PAL.getResourceMessage("PALoMenu_HideGoldLoot"),
        tooltip = PAL.getResourceMessage("PALoMenu_HideGoldLoot_T"),
        getFunc = function() return PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].hideGoldLootMsg end,
        setFunc = function(value) PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].hideGoldLootMsg = value end,
        width = "half",
        disabled = function() return not (PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].lootGold) end,
        default = false,
    }
    tableIndex = tableIndex + 1

    optionsTable[tableIndex] = {
        type = "checkbox",
        name = PAL.getResourceMessage("PALoMenu_HideItemLoot"),
        tooltip = PAL.getResourceMessage("PALoMenu_HideItemLoot_T"),
        getFunc = function() return PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].hideItemLootMsg end,
        setFunc = function(value) PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].hideItemLootMsg = value end,
        width = "half",
        disabled = function() return not (PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].lootItems) end,
        default = false,
    }
    tableIndex = tableIndex + 1

    optionsTable[tableIndex] = {
        type = "checkbox",
        name = PAL.getResourceMessage("PALoMenu_HideAll"),
        tooltip = PAL.getResourceMessage("PALoMenu_HideAll_T"),
        getFunc = function() return PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].hideAllMsg end,
        setFunc = function(value) PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].hideAllMsg = value end,
        width = "half",
        disabled = function() return not PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].enabled end,
        default = false,
    }
    tableIndex = tableIndex + 1

end

function PA_SettingsMenu.createPABItemSubMenu()
	local tableIndex = 1
		
	PABItemTypeSubmenuTable[tableIndex] = {
		type = "dropdown",
		name = PAL.getResourceMessage("PABMenu_DepStackOnly"),
		tooltip = PAL.getResourceMessage("PABMenu_DepStackOnly_T"),
		choices = {PAL.getResourceMessage("ST_MoveAllFull"), PAL.getResourceMessage("ST_MoveExistingFull"), PAL.getResourceMessage("ST_FillIncompleteOnly")},
		getFunc = function() return MenuHelper.getStackTypeTextFromNumber(PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].itemsDepStackType) end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].itemsDepStackType = MenuHelper.getStackTypeNumberFromText(value) end,
		width = "half",
		disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].items) end,
		default = false,
	}
	tableIndex = tableIndex + 1
	
	PABItemTypeSubmenuTable[tableIndex] = {
		type = "dropdown",
		name = PAL.getResourceMessage("PABMenu_WitStackOnly"),
		tooltip = PAL.getResourceMessage("PABMenu_WitStackOnly_T"),
		choices = {PAL.getResourceMessage("ST_MoveAllFull"), PAL.getResourceMessage("ST_MoveExistingFull"), PAL.getResourceMessage("ST_FillIncompleteOnly")},
		getFunc = function() return MenuHelper.getStackTypeTextFromNumber(PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].itemsWitStackType) end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].itemsWitStackType = MenuHelper.getStackTypeNumberFromText(value) end,
		width = "half",
		disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].items) end,
		default = false,
	}
	tableIndex = tableIndex + 1
	
	PABItemTypeSubmenuTable[tableIndex] = {
		type = "header",
		name = PAL.getResourceMessage("PABMenu_ItemJunk_Header"),
	}
	tableIndex = tableIndex + 1
	
	PABItemTypeSubmenuTable[tableIndex] = {
		type = "dropdown",
		name = PAL.getResourceMessage("PABMenu_DepItemJunk"),
		tooltip = PAL.getResourceMessage("PABMenu_DepItemJunk_T"),
		choices = {PAL.getResourceMessage("PAB_ItemType_None"), PAL.getResourceMessage("PAB_ItemType_Deposit"), PAL.getResourceMessage("PAB_ItemType_Withdrawal"), PAL.getResourceMessage("PAB_ItemType_Inherit")},
		getFunc = function() return MenuHelper.getBankingTextFromNumber() end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].itemsJunkSetting = MenuHelper.getBankingNumberFromText(value) end,
		disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].items) end,
		default = PAL.getResourceMessage("PAB_ItemType_None"),
	}
	tableIndex = tableIndex + 1
	
	PABItemTypeSubmenuTable[tableIndex] = {
		type = "header",
		name = PAL.getResourceMessage("PABMenu_ItemType_Header"),
	}
    tableIndex = tableIndex + 1

	for i = 1, #PAItemTypes do
		-- only add if the itemType is enabled
		if PAItemTypes[i] ~= "" then
			PABItemTypeSubmenuTable[tableIndex] = {
				type = "dropdown",
				name = PAL.getResourceMessage(PAItemTypes[i]),
				tooltip = "",
				choices = {PAL.getResourceMessage("PAB_ItemType_None"), PAL.getResourceMessage("PAB_ItemType_Deposit"), PAL.getResourceMessage("PAB_ItemType_Withdrawal")},
				getFunc = function() return MenuHelper.getBankingTextFromNumber(PAItemTypes[i]) end,
				setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].ItemTypes[PAItemTypes[i]] = MenuHelper.getBankingNumberFromText(value) end,
				width = "half",
				disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].items) end,
				default = PAL.getResourceMessage("PAB_ItemType_None"),
			}
            tableIndex = tableIndex + 1

			-- i = index in table
			-- PAItemTypes[i] = unique constant number of itemType
		end
	end
	
	PABItemTypeSubmenuTable[tableIndex] = {
		type = "button",
		name = PAL.getResourceMessage("PABMenu_DepButton"),
		tooltip = PAL.getResourceMessage("PABMenu_DepButton_T"),
		func = function() MenuHelper.setDepositAll() end,
		disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].items) end,
    }
    tableIndex = tableIndex + 1

	PABItemTypeSubmenuTable[tableIndex] = {
		type = "button",
		name = PAL.getResourceMessage("PABMenu_WitButton"),
		tooltip = PAL.getResourceMessage("PABMenu_WitButton_T"),
		func = function() MenuHelper.setWithdrawalAll() end,
		disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].items) end,
    }
    tableIndex = tableIndex + 1

	PABItemTypeSubmenuTable[tableIndex] = {
		type = "button",
		name = PAL.getResourceMessage("PABMenu_IgnButton"),
		tooltip = PAL.getResourceMessage("PABMenu_IgnButton_T"),
		func = function() MenuHelper.setIgnoreAll() end,
		disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].items) end,
	}
end

function PA_SettingsMenu.createPABItemAdvancedSubMenu()
	local tableIndex = 1
	
	local advancedItemIndex = 0		-- 0 = Lockpick
	
	PABItemTypeAdvancedSubmenuTable[tableIndex] = {
		type = "header",
		name = PAL.getResourceMessage("PABMenu_Lockipck_Header"),
	}
	tableIndex = tableIndex + 1
	
	PABItemTypeAdvancedSubmenuTable[tableIndex] = {
		type = "dropdown",
		name = PAL.getResourceMessage("REL_Operator"),
		tooltip = "",
		choices = {PAL.getResourceMessage("REL_None"), PAL.getResourceMessage("REL_Equal"), PAL.getResourceMessage("REL_LessThanEqual"), PAL.getResourceMessage("REL_GreaterThanEqual")},
		-- choices = {PAL.getResourceMessage("REL_None"), PAL.getResourceMessage("REL_Equal"), PAL.getResourceMessage("REL_LessThan"), PAL.getResourceMessage("REL_LessThanEqual"), PAL.getResourceMessage("REL_GreaterThan"), PAL.getResourceMessage("REL_GreaterThanEqual")},
		getFunc = function() return MenuHelper.getOperatorTextFromNumber(advancedItemIndex) end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].ItemTypesAdvanced[advancedItemIndex].Key = MenuHelper.getOperatorNumberFromText(value) end,
		width = "half",
		disabled = function() return not (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].items) end,
		default = PAL.getResourceMessage("REL_None"),
	}
	tableIndex = tableIndex +1
	
	PABItemTypeAdvancedSubmenuTable[tableIndex] = {
		type = "editbox",
		name = PAL.getResourceMessage("PABMenu_Keep_in_Backpack"),
		tooltip = PAL.getResourceMessage("PABMenu_Keep_in_Backpack_T"),
		getFunc = function() return PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].ItemTypesAdvanced[advancedItemIndex].Value end,
		setFunc = function(value) PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].ItemTypesAdvanced[advancedItemIndex].Value = tonumber(value) end,
		isMultiline = false,
		width = "half",
		disabled = function() return (PA_SavedVars.Banking[PA_SavedVars.General.activeProfile].ItemTypesAdvanced[advancedItemIndex].Key == PAC_OPERATOR_NONE) end,
		default = 100,
	}
	tableIndex = tableIndex +1

end

function PA_SettingsMenu.createPALoItemSubMenu()
    local tableIndex = 1

    PALoItemTypeSubmenuTable[tableIndex] = {
        type = "header",
        name = PAL.getResourceMessage("PALoMenu_ItemType_Header"),
    }
    tableIndex = tableIndex + 1

    for i = 1, #PALoItemTypes do
        -- only add if the itemType is enabled
        if PALoItemTypes[i] ~= "" then
            PALoItemTypeSubmenuTable[tableIndex] = {
                type = "dropdown",
                name = PAL.getResourceMessage(PALoItemTypes[i]),
                tooltip = "",
                choices = {PAL.getResourceMessage("PALo_ItemType_None"), PAL.getResourceMessage("PALo_ItemType_Loot")},
                getFunc = function() return MenuHelper.getLootTextFromNumber(PALoItemTypes[i]) end,
                setFunc = function(value) PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].ItemTypes[PALoItemTypes[i]] = MenuHelper.getLootNumberFromText(value) end,
                width = "half",
                disabled = function() return not (PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].lootItems) end,
                default = PAL.getResourceMessage("PALo_ItemType_None"),
            }
            tableIndex = tableIndex + 1

            -- i = index in table
            -- PALoItemTypes[i] = unique constant number of itemType
        end
    end

    PALoItemTypeSubmenuTable[tableIndex] = {
        type = "button",
        name = PAL.getResourceMessage("PALoMenu_LootButton"),
        tooltip = PAL.getResourceMessage("PALoMenu_LootButton_T"),
        func = function() MenuHelper.setAutoLootAll() end,
        disabled = function() return not (PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].lootItems) end,
    }
    tableIndex = tableIndex + 1

    PALoItemTypeSubmenuTable[tableIndex] = {
        type = "button",
        name = PAL.getResourceMessage("PALoMenu_IgnButton"),
        tooltip = PAL.getResourceMessage("PALoMenu_IgnButton_T"),
        func = function() MenuHelper.setIgnoreLootAll() end,
        disabled = function() return not (PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].enabled and PA_SavedVars.Loot[PA_SavedVars.General.activeProfile].lootItems) end,
    }

end