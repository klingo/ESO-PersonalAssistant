PA_SettingsMenu = {}

local LAM2 = LibStub("LibAddonMenu-2.0")

local panelData = {
	 type = "panel",
	 name = "PersonalAssistant",
	 displayName = PALocale.getResourceMessage("MMenu_Title"),
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
		name = PALocale.getResourceMessage("PAGMenu_Header"),
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "dropdown",
		name = PALocale.getResourceMessage("PAGMenu_ActiveProfile"),
		tooltip = PALocale.getResourceMessage("PAGMenu_ActiveProfile_T"),
		--choices = {PALocale.getResourceMessage("PAG_Profile1"), PALocale.getResourceMessage("PAG_Profile2"), PALocale.getResourceMessage("PAG_Profile3")},
		choices = MenuHelper.getProfileList(),
		getFunc = function() return MenuHelper.getProfileTextFromNumber() end,
		setFunc = function(value) MenuHelper.loadProfile(value) end,
		width = "half",
		default = PALocale.getResourceMessage("PAG_Profile1"),
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "editbox",
		name = PALocale.getResourceMessage("PAGMenu_ActiveProfileRename"),
		tooltip = PALocale.getResourceMessage("PAGMenu_ActiveProfileRename_T"),
		getFunc = function() return PA.savedVars.Profiles[PA.savedVars.General.activeProfile].name end,
		setFunc = function(value) MenuHelper.renameProfile(tostring(value)) end,
		isMultiline = false,
		width = "half",
		warning = PALocale.getResourceMessage("PAGMenu_ActiveProfileRename_W"),
		default = PA.savedVars.Profiles[1].name,
	}
	tableIndex = tableIndex + 1
	
	optionsTable[tableIndex] = {
		type = "checkbox",
		name = PALocale.getResourceMessage("PAGMenu_Welcome"),
		tooltip = PALocale.getResourceMessage("PAGMenu_Welcome_T"),
		getFunc = function() return PA.savedVars.General[PA.savedVars.General.activeProfile].welcome end,
		setFunc = function(value) PA.savedVars.General[PA.savedVars.General.activeProfile].welcome = value end,
		default = true,
	}
	tableIndex = tableIndex + 1

    -- =================================================================================================================

    if (PAR) then
        -- ------------------------ --
        -- PersonalAssistant Repair --
        -- ------------------------ --
        optionsTable[tableIndex] = {
            type = "header",
            name = PALocale.getResourceMessage("PARMenu_Header"),
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PARMenu_Enable"),
            tooltip = PALocale.getResourceMessage("PARMenu_Enable_T"),
            getFunc = function() return PA.savedVars.Repair[PA.savedVars.General.activeProfile].enabled end,
            setFunc = function(value) PA.savedVars.Repair[PA.savedVars.General.activeProfile].enabled = value end,
            default = true,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PARMenu_RepairEq"),
            tooltip = PALocale.getResourceMessage("PARMenu_RepairEq_T"),
            getFunc = function() return PA.savedVars.Repair[PA.savedVars.General.activeProfile].equipped end,
            setFunc = function(value) PA.savedVars.Repair[PA.savedVars.General.activeProfile].equipped = value end,
            width = "half",
            disabled = function() return not PA.savedVars.Repair[PA.savedVars.General.activeProfile].enabled end,
            default = true,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "slider",
            name = PALocale.getResourceMessage("PARMenu_RepairEqDura"),
            tooltip = PALocale.getResourceMessage("PARMenu_RepairEqDura_T"),
            min = 0,
            max = 100,
            step = 1,
            getFunc = function() return PA.savedVars.Repair[PA.savedVars.General.activeProfile].equippedThreshold end,
            setFunc = function(value) PA.savedVars.Repair[PA.savedVars.General.activeProfile].equippedThreshold = value end,
            width = "half",
            disabled = function() return not (PA.savedVars.Repair[PA.savedVars.General.activeProfile].equipped and PA.savedVars.Repair[PA.savedVars.General.activeProfile].enabled) end,
            default = 75,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PARMenu_RepairBa"),
            tooltip = PALocale.getResourceMessage("PARMenu_RepairBa_T"),
            getFunc = function() return PA.savedVars.Repair[PA.savedVars.General.activeProfile].backpack end,
            setFunc = function(value) PA.savedVars.Repair[PA.savedVars.General.activeProfile].backpack = value end,
            width = "half",
            disabled = function() return not PA.savedVars.Repair[PA.savedVars.General.activeProfile].enabled end,
            default = false,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "slider",
            name = PALocale.getResourceMessage("PARMenu_RepairBaDura"),
            tooltip = PALocale.getResourceMessage("PARMenu_RepairBaDura_T"),
            min = 0,
            max = 100,
            step = 1,
            getFunc = function() return PA.savedVars.Repair[PA.savedVars.General.activeProfile].backpackThreshold end,
            setFunc = function(value) PA.savedVars.Repair[PA.savedVars.General.activeProfile].backpackThreshold = value end,
            width = "half",
            disabled = function() return not (PA.savedVars.Repair[PA.savedVars.General.activeProfile].backpack and PA.savedVars.Repair[PA.savedVars.General.activeProfile].enabled) end,
            default = 75,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PARMenu_HideNoRepair"),
            tooltip = PALocale.getResourceMessage("PARMenu_HideNoRepair_T"),
            getFunc = function() return PA.savedVars.Repair[PA.savedVars.General.activeProfile].hideNoRepairMsg end,
            setFunc = function(value) PA.savedVars.Repair[PA.savedVars.General.activeProfile].hideNoRepairMsg = value end,
            width = "half",
            disabled = function() return not PA.savedVars.Repair[PA.savedVars.General.activeProfile].enabled end,
            default = false,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PARMenu_HideAll"),
            tooltip = PALocale.getResourceMessage("PARMenu_HideAll_T"),
            getFunc = function() return PA.savedVars.Repair[PA.savedVars.General.activeProfile].hideAllMsg end,
            setFunc = function(value) PA.savedVars.Repair[PA.savedVars.General.activeProfile].hideAllMsg = value end,
            width = "half",
            disabled = function() return not PA.savedVars.Repair[PA.savedVars.General.activeProfile].enabled end,
            default = false,
        }
        tableIndex = tableIndex + 1
    end

    -- =================================================================================================================

    if (PAB) then
        -- ------------------------- --
        -- PersonalAssistant Banking --
        -- ------------------------- --
        optionsTable[tableIndex] = {
            type = "header",
            name = PALocale.getResourceMessage("PABMenu_Header"),
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PABMenu_Enable"),
            tooltip = PALocale.getResourceMessage("PABMenu_Enable_T"),
            getFunc = function() return PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled end,
            setFunc = function(value) PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled = value end,
            default = true,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PABMenu_DepGold"),
            tooltip = PALocale.getResourceMessage("PABMenu_DepGold_T"),
            getFunc = function() return PA.savedVars.Banking[PA.savedVars.General.activeProfile].gold end,
            setFunc = function(value) PA.savedVars.Banking[PA.savedVars.General.activeProfile].gold = value end,
            disabled = function() return not PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled end,
            default = true,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "editbox",
            name = PALocale.getResourceMessage("PABMenu_DepInterval"),
            tooltip = PALocale.getResourceMessage("PABMenu_DepInterval_T"),
            getFunc = function() return PA.savedVars.Banking[PA.savedVars.General.activeProfile].goldDepositInterval end,
            setFunc = function(value) PA.savedVars.Banking[PA.savedVars.General.activeProfile].goldDepositInterval = tonumber(value) end,
            isMultiline = false,
            disabled = function() return not (PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.General.activeProfile].gold) end,
            warning = PALocale.getResourceMessage("PABMenu_DepInterval_W"),
            default = 300,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "slider",
            name = PALocale.getResourceMessage("PABMenu_DepGoldPerc"),
            tooltip = PALocale.getResourceMessage("PABMenu_DepGoldPerc_T"),
            min = 1,
            max = 100,
            step = 1,
            getFunc = function() return PA.savedVars.Banking[PA.savedVars.General.activeProfile].goldDepositPercentage end,
            setFunc = function(value) PA.savedVars.Banking[PA.savedVars.General.activeProfile].goldDepositPercentage = value end,
            disabled = function() return not (PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.General.activeProfile].gold) end,
            default = 50,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "dropdown",
            name = PALocale.getResourceMessage("PABMenu_DepGoldSteps"),
            tooltip = PALocale.getResourceMessage("PABMenu_DepGoldSteps_T"),
            choices = {"1", "10", "100", "1000", "10000"},
            getFunc = function() return PA.savedVars.Banking[PA.savedVars.General.activeProfile].goldTransactionStep end,
            setFunc = function(value) PA.savedVars.Banking[PA.savedVars.General.activeProfile].goldTransactionStep = value end,
            disabled = function() return not (PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.General.activeProfile].gold) end,
            default = "1",
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "editbox",
            name = PALocale.getResourceMessage("PABMenu_DepGoldKeep"),
            tooltip = PALocale.getResourceMessage("PABMenu_DepGoldKeep_T"),
            getFunc = function() return PA.savedVars.Banking[PA.savedVars.General.activeProfile].goldMinToKeep end,
            setFunc = function(value) PA.savedVars.Banking[PA.savedVars.General.activeProfile].goldMinToKeep = tonumber(value) end,
            isMultiline = false,
            disabled = function() return not (PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.General.activeProfile].gold) end,
            warning = PALocale.getResourceMessage("PABMenu_DepGoldKeep_W"),
            default = "250",
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PABMenu_WitGoldMin"),
            tooltip = PALocale.getResourceMessage("PABMenu_WitGoldMin_T"),
            getFunc = function() return PA.savedVars.Banking[PA.savedVars.General.activeProfile].goldWithdraw end,
            setFunc = function(value) PA.savedVars.Banking[PA.savedVars.General.activeProfile].goldWithdraw = value end,
            disabled = function() return not (PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.General.activeProfile].gold) end,
            default = false,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PABMenu_DepWitItem"),
            tooltip = PALocale.getResourceMessage("PABMenu_DepWitItem_T"),
            getFunc = function() return PA.savedVars.Banking[PA.savedVars.General.activeProfile].items end,
            setFunc = function(value) PA.savedVars.Banking[PA.savedVars.General.activeProfile].items = value end,
            disabled = function() return not PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled end,
            default = false,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "description",
            text = PALocale.getResourceMessage("PABMenu_DepItemTypeDesc"),
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "submenu",
            name = PALocale.getResourceMessage("PABMenu_DepItemType"),
            tooltip = PALocale.getResourceMessage("PABMenu_DepItemType_T"),
            controls = PABItemTypeSubmenuTable,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "submenu",
            name = PALocale.getResourceMessage("PABMenu_Advanced_DepItemType"),
            tooltip = PALocale.getResourceMessage("PABMenu_Advanced_DepItemType_T"),
            controls = PABItemTypeAdvancedSubmenuTable,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "slider",
            name = PALocale.getResourceMessage("PABMenu_DepItemTimerInterval"),
            tooltip = PALocale.getResourceMessage("PABMenu_DepItemTimerInterval_T"),
            min = 200,
            max = 1000,
            step = 50,
            getFunc = function() return PA.savedVars.Banking[PA.savedVars.General.activeProfile].itemsTimerInterval end,
            setFunc = function(value) PA.savedVars.Banking[PA.savedVars.General.activeProfile].itemsTimerInterval = value end,
            disabled = function() return not (PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.General.activeProfile].items) end,
            default = 300,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PABMenu_HideNoDeposit"),
            tooltip = PALocale.getResourceMessage("PABMenu_HideNoDeposit_T"),
            getFunc = function() return PA.savedVars.Banking[PA.savedVars.General.activeProfile].hideNoDepositMsg end,
            setFunc = function(value) PA.savedVars.Banking[PA.savedVars.General.activeProfile].hideNoDepositMsg = value end,
            width = "half",
            disabled = function() return not PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled end,
            default = false,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PABMenu_HideAll"),
            tooltip = PALocale.getResourceMessage("PABMenu_HideAll_T"),
            getFunc = function() return PA.savedVars.Banking[PA.savedVars.General.activeProfile].hideAllMsg end,
            setFunc = function(value) PA.savedVars.Banking[PA.savedVars.General.activeProfile].hideAllMsg = value end,
            width = "half",
            disabled = function() return not PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled end,
            default = false,
        }
        tableIndex = tableIndex + 1
    end

    -- =================================================================================================================

    if (PAL) then
        -- ---------------------- --
        -- PersonalAssistant Loot --
        -- ---------------------- --
        optionsTable[tableIndex] = {
            type = "header",
            name = PALocale.getResourceMessage("PALoMenu_Header"),
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PALoMenu_Enable"),
            tooltip = PALocale.getResourceMessage("PALoMenu_Enable_T"),
            getFunc = function() return PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled end,
            setFunc = function(value) PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled = value end,
            default = false,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PALoMenu_LootGold"),
            tooltip = PALocale.getResourceMessage("PALoMenu_LootGold_T"),
            getFunc = function() return PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootGold end,
            setFunc = function(value) PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootGold = value end,
            width = "half",
            disabled = function() return not PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled end,
            default = true,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PALoMenu_LootItems"),
            tooltip = PALocale.getResourceMessage("PALoMenu_LootItems_T"),
            getFunc = function() return PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItems end,
            setFunc = function(value) PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItems = value end,
            width = "half",
            disabled = function() return not PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled end,
            default = true,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "description",
            text = PALocale.getResourceMessage("PALoMenu_ItemTypeDesc"),
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "submenu",
            name = PALocale.getResourceMessage("PALoMenu_ItemType"),
            tooltip = PALocale.getResourceMessage("PALoMenu_ItemType_T"),
            controls = PALoItemTypeSubmenuTable,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PALoMenu_HideGoldLoot"),
            tooltip = PALocale.getResourceMessage("PALoMenu_HideGoldLoot_T"),
            getFunc = function() return PA.savedVars.Loot[PA.savedVars.General.activeProfile].hideGoldLootMsg end,
            setFunc = function(value) PA.savedVars.Loot[PA.savedVars.General.activeProfile].hideGoldLootMsg = value end,
            width = "half",
            disabled = function() return not (PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootGold) end,
            default = false,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PALoMenu_HideItemLoot"),
            tooltip = PALocale.getResourceMessage("PALoMenu_HideItemLoot_T"),
            getFunc = function() return PA.savedVars.Loot[PA.savedVars.General.activeProfile].hideItemLootMsg end,
            setFunc = function(value) PA.savedVars.Loot[PA.savedVars.General.activeProfile].hideItemLootMsg = value end,
            width = "half",
            disabled = function() return not (PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItems) end,
            default = false,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PALoMenu_HideAll"),
            tooltip = PALocale.getResourceMessage("PALoMenu_HideAll_T"),
            getFunc = function() return PA.savedVars.Loot[PA.savedVars.General.activeProfile].hideAllMsg end,
            setFunc = function(value) PA.savedVars.Loot[PA.savedVars.General.activeProfile].hideAllMsg = value end,
            width = "half",
            disabled = function() return not PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled end,
            default = false,
        }
        tableIndex = tableIndex + 1
    end

    -- =================================================================================================================

    if (PAJ) then
        -- ------------------------- --
        -- PersonalAssistant Junk --
        -- ------------------------- --
        optionsTable[tableIndex] = {
            type = "header",
            name = PALocale.getResourceMessage("PAJMenu_Header"),
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PAJMenu_Enable"),
            tooltip = PALocale.getResourceMessage("PAJMenu_Enable_T"),
            getFunc = function() return PA.savedVars.Junk[PA.savedVars.General.activeProfile].enabled end,
            setFunc = function(value) PA.savedVars.Junk[PA.savedVars.General.activeProfile].enabled = value end,
            default = false,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PAJMenu_AutoSellJunk"),
            tooltip = PALocale.getResourceMessage("PAJMenu_AutoSellJunk_T"),
            getFunc = function() return PA.savedVars.Junk[PA.savedVars.General.activeProfile].autoSellJunk end,
            setFunc = function(value) PA.savedVars.Junk[PA.savedVars.General.activeProfile].autoSellJunk = value end,
            disabled = function() return not PA.savedVars.Junk[PA.savedVars.General.activeProfile].enabled end,
            default = true,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "description",
            text = PALocale.getResourceMessage("PAJMenu_ItemTypeDesc"),
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PAJMenu_AutoMarkTrash"),
            tooltip = PALocale.getResourceMessage("PAJMenu_AutoMarkTrash_T"),
            getFunc = function() return PA.savedVars.Junk[PA.savedVars.General.activeProfile].autoMarkTrash end,
            setFunc = function(value) PA.savedVars.Junk[PA.savedVars.General.activeProfile].autoMarkTrash = value end,
            disabled = function() return not PA.savedVars.Junk[PA.savedVars.General.activeProfile].enabled end,
            default = true,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PAJMenu_HideAll"),
            tooltip = PALocale.getResourceMessage("PAJMenu_HideAll_T"),
            getFunc = function() return PA.savedVars.Junk[PA.savedVars.General.activeProfile].hideAllMsg end,
            setFunc = function(value) PA.savedVars.Junk[PA.savedVars.General.activeProfile].hideAllMsg = value end,
            disabled = function() return not PA.savedVars.Junk[PA.savedVars.General.activeProfile].enabled end,
            default = false,
        }
        tableIndex = tableIndex + 1
    end
end


-- =================================================================================================================
-- =================================================================================================================


function PA_SettingsMenu.createPABItemSubMenu()
    if (PAB) then
        local activeProfile = PA.savedVars.General.activeProfile
        local tableIndex = 1

        PABItemTypeSubmenuTable[tableIndex] = {
            type = "dropdown",
            name = PALocale.getResourceMessage("PABMenu_DepStackOnly"),
            tooltip = PALocale.getResourceMessage("PABMenu_DepStackOnly_T"),
            choices = {PALocale.getResourceMessage("ST_MoveAllFull"), PALocale.getResourceMessage("ST_MoveExistingFull"), PALocale.getResourceMessage("ST_FillIncompleteOnly")},
            getFunc = function() return MenuHelper.getStackTypeTextFromNumber(PA.savedVars.Banking[PA.savedVars.General.activeProfile].itemsDepStackType) end,
            setFunc = function(value) PA.savedVars.Banking[PA.savedVars.General.activeProfile].itemsDepStackType = MenuHelper.getStackTypeNumberFromText(value) end,
            width = "half",
            disabled = function() return not (PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.General.activeProfile].items) end,
            default = false,
        }
        tableIndex = tableIndex + 1

        PABItemTypeSubmenuTable[tableIndex] = {
            type = "dropdown",
            name = PALocale.getResourceMessage("PABMenu_WitStackOnly"),
            tooltip = PALocale.getResourceMessage("PABMenu_WitStackOnly_T"),
            choices = {PALocale.getResourceMessage("ST_MoveAllFull"), PALocale.getResourceMessage("ST_MoveExistingFull"), PALocale.getResourceMessage("ST_FillIncompleteOnly")},
            getFunc = function() return MenuHelper.getStackTypeTextFromNumber(PA.savedVars.Banking[PA.savedVars.General.activeProfile].itemsWitStackType) end,
            setFunc = function(value) PA.savedVars.Banking[PA.savedVars.General.activeProfile].itemsWitStackType = MenuHelper.getStackTypeNumberFromText(value) end,
            width = "half",
            disabled = function() return not (PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.General.activeProfile].items) end,
            default = false,
        }
        tableIndex = tableIndex + 1

        PABItemTypeSubmenuTable[tableIndex] = {
            type = "header",
            name = PALocale.getResourceMessage("PABMenu_ItemJunk_Header"),
        }
        tableIndex = tableIndex + 1

        PABItemTypeSubmenuTable[tableIndex] = {
            type = "dropdown",
            name = PALocale.getResourceMessage("PABMenu_DepItemJunk"),
            tooltip = PALocale.getResourceMessage("PABMenu_DepItemJunk_T"),
            choices = {PALocale.getResourceMessage("PAB_ItemType_None"), PALocale.getResourceMessage("PAB_ItemType_Deposit"), PALocale.getResourceMessage("PAB_ItemType_Withdrawal"), PALocale.getResourceMessage("PAB_ItemType_Inherit")},
            getFunc = function() return MenuHelper.getBankingTextFromNumber() end,
            setFunc = function(value) PA.savedVars.Banking[PA.savedVars.General.activeProfile].itemsJunkSetting = MenuHelper.getBankingNumberFromText(value) end,
            disabled = function() return not (PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.General.activeProfile].items) end,
            default = PALocale.getResourceMessage("PAB_ItemType_None"),
        }
        tableIndex = tableIndex + 1

        PABItemTypeSubmenuTable[tableIndex] = {
            type = "header",
            name = PALocale.getResourceMessage("PABMenu_ItemType_Header"),
        }
        tableIndex = tableIndex + 1

        for i = 1, #PAItemTypes do
            -- only add if the itemType is enabled
            if PAItemTypes[i] ~= "" then
                PABItemTypeSubmenuTable[tableIndex] = {
                    type = "dropdown",
                    name = PALocale.getResourceMessage(PAItemTypes[i]),
                    tooltip = "",
                    choices = {PALocale.getResourceMessage("PAB_ItemType_None"), PALocale.getResourceMessage("PAB_ItemType_Deposit"), PALocale.getResourceMessage("PAB_ItemType_Withdrawal")},
                    getFunc = function() return MenuHelper.getBankingTextFromNumber(PAItemTypes[i]) end,
                    setFunc = function(value) PA.savedVars.Banking[PA.savedVars.General.activeProfile].ItemTypes[PAItemTypes[i]] = MenuHelper.getBankingNumberFromText(value) end,
                    width = "half",
                    disabled = function() return not (PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.General.activeProfile].items) end,
                    default = PALocale.getResourceMessage("PAB_ItemType_None"),
                }
                tableIndex = tableIndex + 1

                -- i = index in table
                -- PAItemTypes[i] = unique constant number of itemType
            end
        end

        PABItemTypeSubmenuTable[tableIndex] = {
            type = "button",
            name = PALocale.getResourceMessage("PABMenu_DepButton"),
            tooltip = PALocale.getResourceMessage("PABMenu_DepButton_T"),
            func = function() MenuHelper.setDepositAll() end,
            disabled = function() return not (PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.General.activeProfile].items) end,
        }
        tableIndex = tableIndex + 1

        PABItemTypeSubmenuTable[tableIndex] = {
            type = "button",
            name = PALocale.getResourceMessage("PABMenu_WitButton"),
            tooltip = PALocale.getResourceMessage("PABMenu_WitButton_T"),
            func = function() MenuHelper.setWithdrawalAll() end,
            disabled = function() return not (PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.General.activeProfile].items) end,
        }
        tableIndex = tableIndex + 1

        PABItemTypeSubmenuTable[tableIndex] = {
            type = "button",
            name = PALocale.getResourceMessage("PABMenu_IgnButton"),
            tooltip = PALocale.getResourceMessage("PABMenu_IgnButton_T"),
            func = function() MenuHelper.setIgnoreAll() end,
            disabled = function() return not (PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.General.activeProfile].items) end,
        }
    end
end


-- =================================================================================================================


function PA_SettingsMenu.createPABItemAdvancedSubMenu()
    if (PAB) then
        local activeProfile = PA.savedVars.General.activeProfile
        local tableIndex = 1

        local advancedItemIndex = 0		-- 0 = Lockpick

        PABItemTypeAdvancedSubmenuTable[tableIndex] = {
            type = "header",
            name = PALocale.getResourceMessage("PABMenu_Lockipck_Header"),
        }
        tableIndex = tableIndex + 1

        PABItemTypeAdvancedSubmenuTable[tableIndex] = {
            type = "dropdown",
            name = PALocale.getResourceMessage("REL_Operator"),
            tooltip = "",
            choices = {PALocale.getResourceMessage("REL_None"), PALocale.getResourceMessage("REL_Equal"), PALocale.getResourceMessage("REL_LessThanEqual"), PALocale.getResourceMessage("REL_GreaterThanEqual")},
            -- choices = {PALocale.getResourceMessage("REL_None"), PALocale.getResourceMessage("REL_Equal"), PALocale.getResourceMessage("REL_LessThan"), PALocale.getResourceMessage("REL_LessThanEqual"), PALocale.getResourceMessage("REL_GreaterThan"), PALocale.getResourceMessage("REL_GreaterThanEqual")},
            getFunc = function() return MenuHelper.getOperatorTextFromNumber(advancedItemIndex) end,
            setFunc = function(value) PA.savedVars.Banking[PA.savedVars.General.activeProfile].ItemTypesAdvanced[advancedItemIndex].Key = MenuHelper.getOperatorNumberFromText(value) end,
            width = "half",
            disabled = function() return not (PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.General.activeProfile].items) end,
            default = PALocale.getResourceMessage("REL_None"),
        }
        tableIndex = tableIndex +1

        PABItemTypeAdvancedSubmenuTable[tableIndex] = {
            type = "editbox",
            name = PALocale.getResourceMessage("PABMenu_Keep_in_Backpack"),
            tooltip = PALocale.getResourceMessage("PABMenu_Keep_in_Backpack_T"),
            getFunc = function() return PA.savedVars.Banking[PA.savedVars.General.activeProfile].ItemTypesAdvanced[advancedItemIndex].Value end,
            setFunc = function(value) PA.savedVars.Banking[PA.savedVars.General.activeProfile].ItemTypesAdvanced[advancedItemIndex].Value = tonumber(value) end,
            isMultiline = false,
            width = "half",
            disabled = function() return (PA.savedVars.Banking[PA.savedVars.General.activeProfile].ItemTypesAdvanced[advancedItemIndex].Key == PAC_OPERATOR_NONE) end,
            default = 100,
        }
        tableIndex = tableIndex +1
    end
end


-- =================================================================================================================


function PA_SettingsMenu.createPALoItemSubMenu()
    if (PAL) then
        local activeProfile = PA.savedVars.General.activeProfile
        local tableIndex = 1

        PALoItemTypeSubmenuTable[tableIndex] = {
            type = "header",
            name = PALocale.getResourceMessage("PALoMenu_ItemType_Header"),
        }
        tableIndex = tableIndex + 1

        for i = 1, #PALoItemTypes do
            -- only add if the itemType is enabled
            if PALoItemTypes[i] ~= "" then
                PALoItemTypeSubmenuTable[tableIndex] = {
                    type = "dropdown",
                    name = PALocale.getResourceMessage(PALoItemTypes[i]),
                    tooltip = "",
                    choices = {PALocale.getResourceMessage("PALo_ItemType_None"), PALocale.getResourceMessage("PALo_ItemType_Loot")},
                    getFunc = function() return MenuHelper.getLootTextFromNumber(PALoItemTypes[i]) end,
                    setFunc = function(value) PA.savedVars.Loot[PA.savedVars.General.activeProfile].ItemTypes[PALoItemTypes[i]] = MenuHelper.getLootNumberFromText(value) end,
                    width = "half",
                    disabled = function() return not (PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItems) end,
                    default = PALocale.getResourceMessage("PALo_ItemType_None"),
                }
                tableIndex = tableIndex + 1

                -- i = index in table
                -- PALoItemTypes[i] = unique constant number of itemType
            end
        end

        PALoItemTypeSubmenuTable[tableIndex] = {
            type = "button",
            name = PALocale.getResourceMessage("PALoMenu_LootButton"),
            tooltip = PALocale.getResourceMessage("PALoMenu_LootButton_T"),
            func = function() MenuHelper.setAutoLootAll() end,
            disabled = function() return not (PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItems) end,
        }
        tableIndex = tableIndex + 1

        PALoItemTypeSubmenuTable[tableIndex] = {
            type = "button",
            name = PALocale.getResourceMessage("PALoMenu_IgnButton"),
            tooltip = PALocale.getResourceMessage("PALoMenu_IgnButton_T"),
            func = function() MenuHelper.setIgnoreLootAll() end,
            disabled = function() return not (PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItems) end,
        }
    end
end