PADMenu = {}

function PADMenu.createMenu(LAM, panel)
--	LAM:AddDescription(PAPanel, "PAD_Header_Desc", "This module can automatically deposit gold (and soon items) to your bank, depending on you pre-defined settings.")	
	LAM:AddCheckbox(panel, "PAD_Enabled", "|cB0B0FFEnable Auto Bank Deposit|r", "Enable Auto Bank Deposit?",
				function() return PA_SavedVars.Deposit.enabled end,
				function(val) PA_SavedVars.Deposit.enabled = val end)
	LAM:AddCheckbox(panel, "PAD_Gold_Enabled", "Deposit Gold", "Auto deposit gold to bank?",
				function() return PA_SavedVars.Deposit.gold end,
				function(val) PA_SavedVars.Deposit.gold = val end)
	LAM:AddEditBox(panel, "PAD_Gold_DepositInterval", "- Min interval between deposits (sec)",  "Minimum time in seconds between two automatic gold deposits.", false,
				function () return PA_SavedVars.Deposit.depositInterval end,
				function(val) PA_SavedVars.Deposit.depositInterval = tonumber(val) end,
				true, "Invalid number --> No minimum interval between deposits.")
    LAM:AddSlider(panel, 'PAD_Gold_DepositPercentage', "- Gold to deposit in %",  "Maximum percentage of your current gold to be deposited.", 1, 100, 1,
				function() return PA_SavedVars.Deposit.depositPercentage end, 
				function(val) PA_SavedVars.Deposit.depositPercentage = val end)
  	LAM:AddDropdown(panel, "PAD_Gold_DepositStep", "- Deposit gold in steps of ", "In what steps shall gold be deposited?", {"1", "10", "100", "1000", "10000"}, 
				function() return PA_SavedVars.Deposit.depositStep end,
				function(val) PA_SavedVars.Deposit.depositStep = tonumber(val) end)
	LAM:AddEditBox(panel, "PAD_Gold_MinGoldKeep", "- Min gold to keep on character",  "Minimum amount of gold to always keep on the character.", false,
				function () return PA_SavedVars.Deposit.minGoldToKeep end,
				function(val) PA_SavedVars.Deposit.minGoldToKeep = tonumber(val) end,
				true, " number --> No gold shall be kept on the character.")
	LAM:AddCheckbox(panel, "PAD_Items_Enabled", "Deposit Items", "Auto deposit (stack up) items to bank?",
				function() return PA_SavedVars.Deposit.items end,
				function(val) PA_SavedVars.Deposit.items = val end)
				
	local PASubPanel = LAM:AddSubMenu(panel, "PA_Panel_Items_Deposit", "- Set items to deposit", "Open the sub-menu to define for each item type whether it shall be deposited or not.")
	PADMenu.createItemSubMenu(LAM, PASubPanel)
				
    LAM:AddCheckbox(panel, "PAD_HideNothingToDeposit", "Hide 'Nothing to Deposit' message", "Hide 'Nothing to Deposit' message. You will see a message if there is something to deposit, though.",
				function() return PA_SavedVars.Deposit.hideNoDepositMsg end,
				function(val) PA_SavedVars.Deposit.hideNoDepositMsg = val end)
    LAM:AddCheckbox(panel, "PAD_HideAllMsg", "Hide ALL messages", "Silent-Mode: no message will be displayed. You also won't see your deposited gold/items.",
				function() return PA_SavedVars.Deposit.hideAllMsg end,
				function(val) PA_SavedVars.Deposit.hideAllMsg = val end)
end

function PADMenu.createItemSubMenu(LAM, panel)	
	for i = 0, #PAItemTypes do
		-- only add if the itemType is enabled
		if PAItemTypes[i] ~= "" then
			LAM:AddCheckbox(panel, string.format("PAD_ItemTypes_Enabled_%s", i), PA.getResourceMessage(PAItemTypes[i]), "",
				function() return PA_SavedVars.Deposit.ItemTypes[i] end,
				function(val) PA_SavedVars.Deposit.ItemTypes[i] = val end)
		end
	end
end