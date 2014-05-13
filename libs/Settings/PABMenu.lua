PABMenu = {}

function PABMenu.createMenu(LAM, panel)
--	LAM:AddDescription(PAPanel, "PAB_Header_Desc", "This module can automatically deposit gold (and soon items) to your bank, depending on you pre-defined settings.")	
	LAM:AddCheckbox(panel, "PAB_Enabled", "|cB0B0FFEnable Auto Banking|r", "Enable Auto Bank Deposit and Withdrawal?",
				function() return PA_SavedVars.Banking.enabled end,
				function(val) PA_SavedVars.Banking.enabled = val end)
	LAM:AddCheckbox(panel, "PAB_Gold_Enabled", "Deposit Gold", "Auto deposit gold to bank?",
				function() return PA_SavedVars.Banking.gold end,
				function(val) PA_SavedVars.Banking.gold = val end)
	LAM:AddEditBox(panel, "PAB_Gold_DepositInterval", "- Min interval between deposits (sec)",  "Minimum time in seconds between two automatic gold deposits.", false,
				function () return PA_SavedVars.Banking.goldDepositInterval end,
				function(val) PA_SavedVars.Banking.goldDepositInterval = tonumber(val) end,
				true, "Invalid number --> No minimum interval between deposits.")
    LAM:AddSlider(panel, 'PAB_Gold_DepositPercentage', "- Gold to deposit in %",  "Maximum percentage of your current gold to be deposited.", 1, 100, 1,
				function() return PA_SavedVars.Banking.goldDepositPercentage end, 
				function(val) PA_SavedVars.Banking.goldDepositPercentage = val end)
  	LAM:AddDropdown(panel, "PAB_Gold_DepositStep", "- Gold transactions in steps of ", "In what steps shall gold be deposited and withdrawn?", {"1", "10", "100", "1000", "10000"}, 
				function() return PA_SavedVars.Banking.goldTransactionStep end,
				function(val) PA_SavedVars.Banking.goldTransactionStep = tonumber(val) end)
	LAM:AddEditBox(panel, "PAB_Gold_MinGoldKeep", "- Min gold to keep on character",  "Minimum amount of gold to always keep on the character.", false,
				function () return PA_SavedVars.Banking.goldMinToKeep end,
				function(val) PA_SavedVars.Banking.goldMinToKeep = tonumber(val) end,
				true, " number --> No gold shall be kept on the character.")
	LAM:AddCheckbox(panel, "PAB_Gold_WithdrawForGoldKeep", "- Withdraw gold if below minimum", "Automatically withdraw gold from the bank if there is less gold on the character than defined above?",
				function() return PA_SavedVars.Banking.goldWithdraw end,
				function(val) PA_SavedVars.Banking.goldWithdraw = val end)
	LAM:AddCheckbox(panel, "PAB_Items_Enabled", "Deposit and withdraw Items", "Auto deposit and/or withdraw items to and from the bank?",
				function() return PA_SavedVars.Banking.items end,
				function(val) PA_SavedVars.Banking.items = val end)
--	LAM:AddCheckbox(panel, "PAB_Items_Open_Hireling_Container", "- Open Hireling Chests before deposit", "Shall the chests sent to you by hirelings automatically be opened before the item deposit starts?",
--				function() return PA_SavedVars.Banking.openHirelingChest end,
--				function(val) PA_SavedVars.Banking.openHirelingChest = val end)
				
	local PASubPanel = LAM:AddSubMenu(panel, "PA_Panel_Items_DepositWithdraw", "- Set items to deposit/withdraw", "Open the sub-menu to define for each item type whether it shall be deposited, withdrew or ignored.")
	PABMenu.createItemSubMenu(LAM, PASubPanel)
	
	LAM:AddCheckbox(panel, "PAB_Items_Junk_Enabled", "- Deposit items marked as junk", "Shall items that are marked as junk be deposited to the bank as well?",
				function() return PA_SavedVars.Banking.itemsIncludeJunk end,
				function(val) PA_SavedVars.Banking.itemsIncludeJunk = val end)
				
    LAM:AddCheckbox(panel, "PAB_HideNothingToDeposit", "Hide 'Nothing to Deposit' message", "Hide 'Nothing to Deposit' message. You will see a message if there is something to deposit, though.",
				function() return PA_SavedVars.Banking.hideNoDepositMsg end,
				function(val) PA_SavedVars.Banking.hideNoDepositMsg = val end)
    LAM:AddCheckbox(panel, "PAB_HideAllMsg", "Hide ALL messages", "Silent-Mode: no message will be displayed. You also won't see your deposited gold/items.",
				function() return PA_SavedVars.Banking.hideAllMsg end,
				function(val) PA_SavedVars.Banking.hideAllMsg = val end)
end

-- creates the sub panel for selecting the individual item types
function PABMenu.createItemSubMenu(LAM, panel)	
	for i = 0, #PAItemTypes do
		-- only add if the itemType is enabled
		if PAItemTypes[i] ~= "" then
			LAM:AddDropdown(panel, string.format("PAB_ItemTypes_Enabled_%s", i), PA.getResourceMessage(PAItemTypes[i]), "", 
				{PA.getResourceMessage("ItemType_None"), PA.getResourceMessage("ItemType_Deposit"), PA.getResourceMessage("ItemType_Withdrawal")}, 
				function() return PABMenu.getBankingTextFromNumber(i) end,
				function(val) PA_SavedVars.Banking.ItemTypes[i] = PABMenu.getBankingNumberFromText(val) end)
		end
	end
	
	LAM:AddButton(panel, "PAB_ItemTypes_Deposit_All", "Deposit all", "Change all dropdown values to 'Deposit'? |cff0000(will force a ReloadUI)|r",
		function() PABMenu.depositAll() end, true, "Will force a ReloadUI.")
	LAM:AddButton(panel, "PAB_ItemTypes_Withdrawal_All", "Withdraw all", "Change all dropdown values to 'Withdraw'? |cff0000(will force a ReloadUI)|r",
		function() PABMenu.withdrawalAll() end, true, "Will force a ReloadUI.")
end

function PABMenu.depositAll()
	for i = 0, #PAItemTypes do
		-- only if the itemType is enabled
		if PAItemTypes[i] ~= "" then
			PA_SavedVars.Banking.ItemTypes[i] = PAC_ITEMTYPE_DEPOSIT
			ReloadUI()
		end
	end
end

function PABMenu.withdrawalAll()
	for i = 0, #PAItemTypes do
		-- only if the itemType is enabled
		if PAItemTypes[i] ~= "" then
			PA_SavedVars.Banking.ItemTypes[i] = PAC_ITEMTYPE_WITHDRAWAL
			ReloadUI()
		end
	end
end

-- returns the matching dropdown-text based on the number that is behind it
function PABMenu.getBankingTextFromNumber(number)
	local index = PA_SavedVars.Banking.ItemTypes[number]
	if index == PAC_ITEMTYPE_DEPOSIT then
		return PA.getResourceMessage("ItemType_Deposit")
	elseif index == PAC_ITEMTYPE_WITHDRAWAL then
		return PA.getResourceMessage("ItemType_Withdrawal")
	else
		return PA.getResourceMessage("ItemType_None")
	end
end

-- returns the number behind the text, depending on the text
function PABMenu.getBankingNumberFromText(text)
	if text == PA.getResourceMessage("ItemType_Deposit") then
		return PAC_ITEMTYPE_DEPOSIT		-- = Deposit
	elseif text == PA.getResourceMessage("ItemType_Withdrawal") then
		return PAC_ITEMTYPE_WITHDRAWAL	-- = Withdrawal
	else
		return PAC_ITEMTYPE_IGNORE		-- = Ignore
	end
end