PA_SettingsMenu = {}

local LAM2 = LibStub("LibAddonMenu-2.0")

local panelData = {
    type = "panel",
    name = "PersonalAssistant",
    displayName = PALocale.getResourceMessage("MMenu_Title"),
    author = "Klingo",
    version = PA.AddonVersion,
    slashCommand = "/pa",
    registerForRefresh  = true,
    registerForDefaults = true,
}

local optionsTable = {}
local PABItemTypeSubmenuTable = {}
local PABItemTypeAdvancedSubmenuTable = {}
local PALHarvestableItemSubmenuTable = {}
local PALLootableItemSubmenuTable = {}


function PA_SettingsMenu.CreateOptions()

	-- create the menus with LAM-2
	PA_SettingsMenu.createPABItemSubMenu()
	PA_SettingsMenu.createPABItemAdvancedSubMenu()
    PA_SettingsMenu.createPALHarvestableItemSubMenu()
    PA_SettingsMenu.createPALLootableItemSubMenu()
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
		getFunc = function() return PA.savedVars.General[PA.savedVars.General.activeProfile].name end,
		setFunc = function(value) MenuHelper.renameProfile(tostring(value)) end,
		isMultiline = false,
		width = "half",
		warning = PALocale.getResourceMessage("PAGMenu_ActiveProfileRename_W"),
        -- requiresReload = true,
        -- does not work here, since not directly reloading after a name change causes many problems
        -- when changing other values that cannot be related to a specific profile anymore
		default = PA.savedVars.General[1].name,
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
            name = PALocale.getResourceMessage("PALMenu_Header"),
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PALMenu_Enable"),
            tooltip = PALocale.getResourceMessage("PALMenu_Enable_T"),
            getFunc = function() return PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled end,
            setFunc = function(value) PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled = value end,
            default = false,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PALMenu_LootGold"),
            tooltip = PALocale.getResourceMessage("PALMenu_LootGold_T"),
            getFunc = function() return PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootGold end,
            setFunc = function(value) PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootGold = value end,
            width = "half",
            disabled = function() return not PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled end,
            default = true,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "dropdown",
            name = PALocale.getResourceMessage("PALMenu_LootGoldChatMode"),
            tooltip = PALocale.getResourceMessage("PALMenu_LootGoldChatMode_T"),
            choices = {PAHF.getFormattedKey("PAL_Gold_ChatMode_None"), PAHF.getFormattedKey("PAL_Gold_ChatMode_Min", 123), PAHF.getFormattedKey("PAL_Gold_ChatMode_Normal", 123), PAHF.getFormattedKey("PAL_Gold_ChatMode_Full", 123)},
            choicesValues = {PA_OUTPUT_TYPE_NONE, PA_OUTPUT_TYPE_MIN, PA_OUTPUT_TYPE_NORMAL, PA_OUTPUT_TYPE_FULL},
            getFunc = function() return PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootGoldChatMode end,
            setFunc = function(value) PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootGoldChatMode = value end,
            width = "half",
            disabled = function() return not (PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootGold) end,
            default = PA_OUTPUT_TYPE_NORMAL,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "checkbox",
            name = PALocale.getResourceMessage("PALMenu_LootItems"),
            tooltip = PALocale.getResourceMessage("PALMenu_LootItems_T"),
            getFunc = function() return PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItems end,
            setFunc = function(value) PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItems = value end,
            width = "half",
            disabled = function() return not PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled end,
            default = true,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "dropdown",
            name = PALocale.getResourceMessage("PALMenu_LootItemsChatMode"),
            tooltip = PALocale.getResourceMessage("PALMenu_LootItemsChatMode_T"),
            choices = {PAHF.getFormattedKey("PAL_Items_ChatMode_None"), PAHF.getFormattedKey("PAL_Items_ChatMode_Min", 2, PAC_ICON_BANANAS), PAHF.getFormattedKey("PAL_Items_ChatMode_Normal", 2, PAC_ITEMCODE_BANANAS, PAC_ICON_BANANAS), PAHF.getFormattedKey("PAL_Items_ChatMode_Full", 2, PAC_ITEMCODE_BANANAS, PAC_ICON_BANANAS)},
            choicesValues = {PA_OUTPUT_TYPE_NONE, PA_OUTPUT_TYPE_MIN, PA_OUTPUT_TYPE_NORMAL, PA_OUTPUT_TYPE_FULL},
            getFunc = function() return PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItemsChatMode end,
            setFunc = function(value) PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItemsChatMode = value end,
            width = "half",
            disabled = function() return not (PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItems) end,
            default = PA_OUTPUT_TYPE_FULL,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "submenu",
            name = PALocale.getResourceMessage("PALMenu_HarvestableItems"),
            tooltip = PALocale.getResourceMessage("PALMenu_HarvestableItems_T"),
            controls = PALHarvestableItemSubmenuTable,
        }
        tableIndex = tableIndex + 1

        optionsTable[tableIndex] = {
            type = "submenu",
            name = PALocale.getResourceMessage("PALMenu_LootableItems"),
            tooltip = PALocale.getResourceMessage("PALMenu_LootableItems_T"),
            controls = PALLootableItemSubmenuTable,
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

        for i = 1, #PABItemTypes do
            -- only add if the itemType is enabled
            if PABItemTypes[i] ~= "" then
                PABItemTypeSubmenuTable[tableIndex] = {
                    type = "dropdown",
                    name = PALocale.getResourceMessage(PABItemTypes[i]),
                    tooltip = "",
                    choices = {PALocale.getResourceMessage("PAB_ItemType_None"), PALocale.getResourceMessage("PAB_ItemType_Deposit"), PALocale.getResourceMessage("PAB_ItemType_Withdrawal")},
                    getFunc = function() return MenuHelper.getBankingTextFromNumber(PABItemTypes[i]) end,
                    setFunc = function(value) PA.savedVars.Banking[PA.savedVars.General.activeProfile].ItemTypes[PABItemTypes[i]] = MenuHelper.getBankingNumberFromText(value) end,
                    width = "half",
                    disabled = function() return not (PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.General.activeProfile].items) end,
                    default = PALocale.getResourceMessage("PAB_ItemType_None"),
                }
                tableIndex = tableIndex + 1

                -- i = index in table
                -- PABItemTypes[i] = unique constant number of itemType
            end
        end

        PABItemTypeSubmenuTable[tableIndex] = {
            type = "button",
            name = PALocale.getResourceMessage("PABMenu_DepButton"),
            tooltip = PALocale.getResourceMessage("PABMenu_DepButton_T"),
            func = function() MenuHelper.setPABDepositAll() end,
            disabled = function() return not (PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.General.activeProfile].items) end,
        }
        tableIndex = tableIndex + 1

        PABItemTypeSubmenuTable[tableIndex] = {
            type = "button",
            name = PALocale.getResourceMessage("PABMenu_WitButton"),
            tooltip = PALocale.getResourceMessage("PABMenu_WitButton_T"),
            func = function() MenuHelper.setPABWithdrawalAll() end,
            disabled = function() return not (PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.General.activeProfile].items) end,
        }
        tableIndex = tableIndex + 1

        PABItemTypeSubmenuTable[tableIndex] = {
            type = "button",
            name = PALocale.getResourceMessage("PABMenu_IgnButton"),
            tooltip = PALocale.getResourceMessage("PABMenu_IgnButton_T"),
            func = function() MenuHelper.setPABIgnoreAll() end,
            disabled = function() return not (PA.savedVars.Banking[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.General.activeProfile].items) end,
        }
    end
end


-- =================================================================================================================


function PA_SettingsMenu.createPABItemAdvancedSubMenu()
    if (PAB) then
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


function PA_SettingsMenu.createPALHarvestableItemSubMenu()
    if (PAL) then
        local tableIndex = 1

        PALHarvestableItemSubmenuTable[tableIndex] = {
            type = "description",
            text = PALocale.getResourceMessage("PALMenu_HarvestableItemsDesc"),
        }
        tableIndex = tableIndex + 1

        PALHarvestableItemSubmenuTable[tableIndex] = {
            type = "header",
            name = PALocale.getResourceMessage("PALMenu_HarvestableItems_Header"),
        }
        tableIndex = tableIndex + 1

        for i = 1, #PALHarvestableItemTypes do
            -- only add if the itemType is enabled
            if PALHarvestableItemTypes[i] ~= "" then
                PALHarvestableItemSubmenuTable[tableIndex] = {
                    type = "dropdown",
                    name = PALocale.getResourceMessage(PALHarvestableItemTypes[i]),
                    tooltip = "",
                    choices = {PALocale.getResourceMessage("PAL_ItemType_None"), PALocale.getResourceMessage("PAL_ItemType_Loot")},
                    getFunc = function() return MenuHelper.getLootTextFromNumber(PALHarvestableItemTypes[i], PAL_TYPE_HARVEST) end,
                    setFunc = function(value) PA.savedVars.Loot[PA.savedVars.General.activeProfile].HarvestableItemTypes[PALHarvestableItemTypes[i]] = MenuHelper.getLootNumberFromText(value) end,
                    width = "half",
                    disabled = function() return not (PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItems) end,
                    default = PALocale.getResourceMessage("PAL_ItemType_None"),
                }
                tableIndex = tableIndex + 1

                -- i = index in table
                -- PALHarvestableItemTypes[i] = unique constant number of itemType
            end
        end

        PALHarvestableItemSubmenuTable[tableIndex] = {
            type = "button",
            name = PALocale.getResourceMessage("PALMenu_LootButton"),
            tooltip = PALocale.getResourceMessage("PALMenu_LootButton_T"),
            func = function() MenuHelper.setPALAutoLootAll(PAL_TYPE_HARVEST) end,
            disabled = function() return not (PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItems) end,
        }
        tableIndex = tableIndex + 1

        PALHarvestableItemSubmenuTable[tableIndex] = {
            type = "button",
            name = PALocale.getResourceMessage("PALMenu_IgnButton"),
            tooltip = PALocale.getResourceMessage("PALMenu_IgnButton_T"),
            func = function() MenuHelper.setPALIgnoreAll(PAL_TYPE_HARVEST) end,
            disabled = function() return not (PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItems) end,
        }
    end
end

-- =================================================================================================================

function PA_SettingsMenu.createPALLootableItemSubMenu()
    if (PAL) then
        local tableIndex = 1

        PALLootableItemSubmenuTable[tableIndex] = {
            type = "description",
            text = PALocale.getResourceMessage("PALMenu_LootableItemsDesc"),
        }
        tableIndex = tableIndex + 1

        PALLootableItemSubmenuTable[tableIndex] = {
            type = "header",
            name = PALocale.getResourceMessage("PALMenu_LootableItems_Header"),
        }
        tableIndex = tableIndex + 1

        for i = 1, #PALLootableItemTypes do
            -- only add if the itemType is enabled
            if PALLootableItemTypes[i] ~= "" then
                PALLootableItemSubmenuTable[tableIndex] = {
                    type = "dropdown",
                    name = PALocale.getResourceMessage(PALLootableItemTypes[i]),
                    tooltip = "",
                    choices = {PALocale.getResourceMessage("PAL_ItemType_None"), PALocale.getResourceMessage("PAL_ItemType_Loot")},
                    getFunc = function() return MenuHelper.getLootTextFromNumber(PALLootableItemTypes[i], PAL_TYPE_LOOT) end,
                    setFunc = function(value) PA.savedVars.Loot[PA.savedVars.General.activeProfile].LootableItemTypes[PALLootableItemTypes[i]] = MenuHelper.getLootNumberFromText(value) end,
                    width = "half",
                    disabled = function() return not (PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItems) end,
                    default = PALocale.getResourceMessage("PAL_ItemType_None"),
                }
                tableIndex = tableIndex + 1

                -- i = index in table
                -- PALLootableItemTypes[i] = unique constant number of itemType
            end
        end

        PALLootableItemSubmenuTable[tableIndex] = {
            type = "button",
            name = PALocale.getResourceMessage("PALMenu_LootButton"),
            tooltip = PALocale.getResourceMessage("PALMenu_LootButton_T"),
            func = function() MenuHelper.setPALAutoLootAll(PAL_TYPE_LOOT) end,
            disabled = function() return not (PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItems) end,
        }
        tableIndex = tableIndex + 1

        PALLootableItemSubmenuTable[tableIndex] = {
            type = "button",
            name = PALocale.getResourceMessage("PALMenu_IgnButton"),
            tooltip = PALocale.getResourceMessage("PALMenu_IgnButton_T"),
            func = function() MenuHelper.setPALIgnoreAll(PAL_TYPE_LOOT) end,
            disabled = function() return not (PA.savedVars.Loot[PA.savedVars.General.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.General.activeProfile].lootItems) end,
        }

    end
end