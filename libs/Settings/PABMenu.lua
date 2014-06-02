PABMenu = {}

function PABMenu.createMenu(LAM, panel)
	LAM:AddCheckbox(panel, "PAB_Enabled", PA.getResourceMessage("PABMenu_Enable"), PA.getResourceMessage("PABMenu_Enable_T"),
				function() return PA_SavedVars.Banking.enabled end,
				function(val) PA_SavedVars.Banking.enabled = val end)
	LAM:AddCheckbox(panel, "PAB_Gold_Enabled", PA.getResourceMessage("PABMenu_DepGold"), PA.getResourceMessage("PABMenu_DepGold_T"),
				function() return PA_SavedVars.Banking.gold end,
				function(val) PA_SavedVars.Banking.gold = val end)
	LAM:AddEditBox(panel, "PAB_Gold_DepositInterval", PA.getResourceMessage("PABMenu_DepInterval"),  PA.getResourceMessage("PABMenu_DepInterval_T"), false,
				function () return PA_SavedVars.Banking.goldDepositInterval end,
				function(val) PA_SavedVars.Banking.goldDepositInterval = tonumber(val) end,
				true, PA.getResourceMessage("PABMenu_DepInterval_W"))
    LAM:AddSlider(panel, "PAB_Gold_DepositPercentage", PA.getResourceMessage("PABMenu_DepGoldPerc"),  PA.getResourceMessage("PABMenu_DepGoldPerc_T"), 1, 100, 1,
				function() return PA_SavedVars.Banking.goldDepositPercentage end, 
				function(val) PA_SavedVars.Banking.goldDepositPercentage = val end)
  	LAM:AddDropdown(panel, "PAB_Gold_DepositStep", PA.getResourceMessage("PABMenu_DepGoldSteps"), PA.getResourceMessage("PABMenu_DepGoldSteps_T"), {"1", "10", "100", "1000", "10000"}, 
				function() return PA_SavedVars.Banking.goldTransactionStep end,
				function(val) PA_SavedVars.Banking.goldTransactionStep = tonumber(val) end)
	LAM:AddEditBox(panel, "PAB_Gold_MinGoldKeep", PA.getResourceMessage("PABMenu_DepGoldKeep"),  PA.getResourceMessage("PABMenu_DepGoldKeep_T"), false,
				function () return PA_SavedVars.Banking.goldMinToKeep end,
				function(val) PA_SavedVars.Banking.goldMinToKeep = tonumber(val) end,
				true, PA.getResourceMessage("PABMenu_DepGoldKeep_W"))
	LAM:AddCheckbox(panel, "PAB_Gold_WithdrawForGoldKeep", PA.getResourceMessage("PABMenu_WitGoldMin"), PA.getResourceMessage("PABMenu_WitGoldMin_T"),
				function() return PA_SavedVars.Banking.goldWithdraw end,
				function(val) PA_SavedVars.Banking.goldWithdraw = val end)
	LAM:AddCheckbox(panel, "PAB_Items_Enabled", PA.getResourceMessage("PABMenu_DepWitItem"), PA.getResourceMessage("PABMenu_DepWitItem_T"),
				function() return PA_SavedVars.Banking.items end,
				function(val) PA_SavedVars.Banking.items = val end)
				
	local PASubPanel = LAM:AddSubMenu(panel, "PA_Panel_Items_DepositWithdraw", PA.getResourceMessage("PABMenu_DepItemType"), PA.getResourceMessage("PABMenu_DepItemType_T"))
	PABMenu.createItemSubMenu(LAM, PASubPanel)
	
	LAM:AddCheckbox(panel, "PAB_Items_Junk_Enabled", PA.getResourceMessage("PABMenu_DepItemJunk"), PA.getResourceMessage("PABMenu_DepItemJunk_T"),
				function() return PA_SavedVars.Banking.itemsIncludeJunk end,
				function(val) PA_SavedVars.Banking.itemsIncludeJunk = val end)
				
    LAM:AddCheckbox(panel, "PAB_HideNothingToDeposit", PA.getResourceMessage("PABMenu_HideNoDeposit"), PA.getResourceMessage("PABMenu_HideNoDeposit_T"),
				function() return PA_SavedVars.Banking.hideNoDepositMsg end,
				function(val) PA_SavedVars.Banking.hideNoDepositMsg = val end)
    LAM:AddCheckbox(panel, "PAB_HideAllMsg", PA.getResourceMessage("PABMenu_HideAll"), PA.getResourceMessage("PABMenu_HideAll_T"),
				function() return PA_SavedVars.Banking.hideAllMsg end,
				function(val) PA_SavedVars.Banking.hideAllMsg = val end)
end

-- creates the sub panel for selecting the individual item types
function PABMenu.createItemSubMenu(LAM, panel)

	for i = 0, #PAItemTypes do
		-- only add if the itemType is enabled
		if PAItemTypes[i] ~= "" then
			LAM:AddDropdown(panel, string.format("PAB_ItemTypes_Enabled_%s", i), PA.getResourceMessage(PAItemTypes[i]), "", 
				{PA.getResourceMessage("PAB_ItemType_None"), PA.getResourceMessage("PAB_ItemType_Deposit"), PA.getResourceMessage("PAB_ItemType_Withdrawal")}, 
				function() return PABMenu.getBankingTextFromNumber(i) end,
				function(val) PA_SavedVars.Banking.ItemTypes[i] = PABMenu.getBankingNumberFromText(val) end)
		end
	end

    LAM:AddSlider(panel, "PAB_Items_CallLater", PA.getResourceMessage("PABMenu_DepItemTImerInterval"),  PA.getResourceMessage("PABMenu_DepItemTImerInterval_T"), 200, 1000, 50,
				function() return PA_SavedVars.Banking.itemsTimerInterval end, 
				function(val) PA_SavedVars.Banking.itemsTimerInterval = val end)
	
	LAM:AddButton(panel, "PAB_ItemTypes_Deposit_All", PA.getResourceMessage("PABMenu_DepButton"), PA.getResourceMessage("PABMenu_DepButton_T"),
		function() PABMenu.setDepositAll() end, true, PA.getResourceMessage("PABMenu_DepButton_W"))
	LAM:AddButton(panel, "PAB_ItemTypes_Withdrawal_All", PA.getResourceMessage("PABMenu_WitButton"), PA.getResourceMessage("PABMenu_WitButton_T"),
		function() PABMenu.setWithdrawalAll() end, true, PA.getResourceMessage("PABMenu_WitButton_W"))
	LAM:AddButton(panel, "PAB_ItemTypes_Ignore_All", PA.getResourceMessage("PABMenu_IgnButton"), PA.getResourceMessage("PABMenu_IgnButton_T"),
		function() PABMenu.setIgnoreAll() end, true, PA.getResourceMessage("PABMenu_IgnButton_W"))
end

function PABMenu.setDepositAll()
	PABMenu.setDropdownsTo(PAC_ITEMTYPE_DEPOSIT)
end

function PABMenu.setWithdrawalAll()
	PABMenu.setDropdownsTo(PAC_ITEMTYPE_WITHDRAWAL)
end

function PABMenu.setIgnoreAll()
	PABMenu.setDropdownsTo(PAC_ITEMTYPE_IGNORE)
end

function PABMenu.setDropdownsTo(itemTypeKey)
	for i = 0, #PAItemTypes do
		-- only if the itemType is enabled
		if PAItemTypes[i] ~= "" then
			PA_SavedVars.Banking.ItemTypes[i] = itemTypeKey
			ReloadUI()
		end
	end
end

-- returns the matching dropdown-text based on the number that is behind it
function PABMenu.getBankingTextFromNumber(number)
	local index = PA_SavedVars.Banking.ItemTypes[number]
	if index == PAC_ITEMTYPE_DEPOSIT then
		return PA.getResourceMessage("PAB_ItemType_Deposit")
	elseif index == PAC_ITEMTYPE_WITHDRAWAL then
		return PA.getResourceMessage("PAB_ItemType_Withdrawal")
	else
		return PA.getResourceMessage("PAB_ItemType_None")
	end
end

-- returns the number behind the text, depending on the text
function PABMenu.getBankingNumberFromText(text)
	if text == PA.getResourceMessage("PAB_ItemType_Deposit") then
		return PAC_ITEMTYPE_DEPOSIT		-- = Deposit
	elseif text == PA.getResourceMessage("PAB_ItemType_Withdrawal") then
		return PAC_ITEMTYPE_WITHDRAWAL	-- = Withdrawal
	else
		return PAC_ITEMTYPE_IGNORE		-- = Ignore
	end
end