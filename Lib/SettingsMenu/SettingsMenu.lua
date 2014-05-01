PA_SettingsMenu = {}

local LAM = LibStub("LibAddonMenu-1.0")

PA_SettingsMenu.CreateOptions = function()
    local PAPanel = LAM:CreateControlPanel("PersonalAssistant_Options", "|cFFD700P|rersonal|cFFD700A|rssistant")
	
	-- PARepair
    LAM:AddHeader(PAPanel, "PersonalAssistant_Options_Header_AR", "|cFFD700PA R|repair")
    LAM:AddCheckbox(PAPanel, "PersonalAssistant_Options_AR_Enabled", "|cB0B0FFEnable Auto Repair|r", "Enable Auto Repair?",
                    function() return PA_SavedVars.Repair.enabled end,
                    function(val) PA_SavedVars.Repair.enabled = val end)
    LAM:AddCheckbox(PAPanel, "PersonalAssistant_Options_AR_Equipped", "Repair equipped items", "Repair equipped items?",
                    function() return PA_SavedVars.Repair.equipped end,
                    function(val) PA_SavedVars.Repair.equipped = val end)
    LAM:AddSlider(PAPanel, 'PersonalAssistant_Options_AR_Equipped_Threshold', '- Durability threshold in %', 'Repair equipped items only if they are at or below the defined durability threshold.', 0, 100, 1,
					function() return PA_SavedVars.Repair.equippedThreshold end, 
					function(val) PA_SavedVars.Repair.equippedThreshold = val end)
    LAM:AddCheckbox(PAPanel, "PersonalAssistant_Options_AR_Inventory", "Repair inventory items", "Repair inventory items?",
                    function() return PA_SavedVars.Repair.inventory end,
                    function(val) PA_SavedVars.Repair.inventory = val end)
    LAM:AddSlider(PAPanel, 'PersonalAssistant_Options_AR_Inventory_Threshold', '- Durability threshold in %', 'Repair items in the inventory only if they are at or below the defined durability threshold.', 0, 100, 1,
					function() return PA_SavedVars.Repair.inventoryThreshold end, 
					function(val) PA_SavedVars.Repair.inventoryThreshold = val end)
    LAM:AddCheckbox(PAPanel, "PersonalAssistant_Options_AR_HideNothingToRepair", "Hide 'Nothing to Repair' message", "Hide 'Nothing to Repair' message. You will still see a message if there is something to repair.",
                    function() return PA_SavedVars.Repair.hideNoRepairMsg end,
                    function(val) PA_SavedVars.Repair.hideNoRepairMsg = val end)
    LAM:AddCheckbox(PAPanel, "PersonalAssistant_Options_AR_HideAllMsg", "Hide ALL messages", "Silent-Mode: no message will be displayed. You also won't see your repair cost.",
                    function() return PA_SavedVars.Repair.hideAllMsg end,
                    function(val) PA_SavedVars.Repair.hideAllMsg = val end)
	
	-- PADeposit
	LAM:AddHeader(PAPanel, "PersonalAssistant_Options_Header_ABD", "|cFFD700PA D|reposit")
	LAM:AddCheckbox(PAPanel, "PersonalAssistant_Options_ABD_Enabled", "|cB0B0FFEnable Auto Bank Deposit|r", "Enable Auto Bank Deposit?",
				function() return PA_SavedVars.Deposit.enabled end,
				function(val) PA_SavedVars.Deposit.enabled = val end)
	LAM:AddCheckbox(PAPanel, "PersonalAssistant_Options_ABD_Gold", "Deposit Gold", "Auto deposit gold to bank?",
				function() return PA_SavedVars.Deposit.gold end,
				function(val) PA_SavedVars.Deposit.gold = val end)
	LAM:AddEditBox(PAPanel, "PersonalAssistant_Options_ABD_DepositInterval", "- Min interval between auto-deposits",  "Minimum time in seconds between two automatic gold deposits.", false,
				function () return PA_SavedVars.Deposit.depositInterval end,
				function(val) PA_SavedVars.Deposit.depositInterval = tonumber(val) end,
				true, "Invalid number --> No minimum interval between deposits.")
    LAM:AddSlider(PAPanel, 'PersonalAssistant_Options_ABD_DepositPercentage', "- Gold to deposit in %",  "Maximum percentage of your current gold to be deposited.", 1, 100, 1,
				function() return PA_SavedVars.Deposit.depositPercentage end, 
				function(val) PA_SavedVars.Deposit.depositPercentage = val end)
  	LAM:AddDropdown(PAPanel, "PersonalAssistant_Options_ABD_DepositStep", "- Deposit gold in steps of ", "In what steps shall gold be deposited?", {"1", "10", "100", "1000", "10000"}, 
				function() return PA_SavedVars.Deposit.depositStep end,
				function(val) PA_SavedVars.Deposit.depositStep = tonumber(val) end)
	LAM:AddEditBox(PAPanel, "PersonalAssistant_Options_ABD_MinGoldKeep", "- Min gold to keep on character",  "Minimum amount of gold to always keep on the character.", false,
				function () return PA_SavedVars.Deposit.minGoldToKeep end,
				function(val) PA_SavedVars.Deposit.minGoldToKeep = tonumber(val) end,
				true, "Invalid number --> No gold shall be kept on the character.")
    LAM:AddCheckbox(PAPanel, "PersonalAssistant_Options_ABD_HideNothingToDeposit", "Hide 'Nothing to Deposit' message", "Hide 'Nothing to Deposit' message. You will see a message if there is something to deposit, though.",
				function() return PA_SavedVars.Deposit.hideNoDepositMsg end,
				function(val) PA_SavedVars.Deposit.hideNoDepositMsg = val end)
    LAM:AddCheckbox(PAPanel, "PersonalAssistant_Options_ABD_HideAllMsg", "Hide ALL messages", "Silent-Mode: no message will be displayed. You also won't see your deposited gold/items.",
				function() return PA_SavedVars.Deposit.hideAllMsg end,
				function(val) PA_SavedVars.Deposit.hideAllMsg = val end)
				
--  |r |cFF2222[NYI]|r
	
	-- PAWithdraw
	LAM:AddHeader(PAPanel, "PersonalAssistant_Options_Header_ABW", "|cFFD700PA W|rithdrawal")
	LAM:AddCheckbox(PAPanel, "PersonalAssistant_Options_ABW_Enabled", "|cB0B0FFEnable Auto Bank Withdrawal|r |cFF2222[NYI]|r", "not yet implemented",
				function() return PA_SavedVars.Withdrawal.enabled end,
				function(val) PA_SavedVars.Withdrawal.enabled = val end)
end