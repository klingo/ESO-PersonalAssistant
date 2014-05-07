PAWMenu = {}

function PAWMenu.createMenu(LAM, panel)
	LAM:AddCheckbox(panel, "PAW_Enabled", "|cB0B0FFEnable Auto Bank Withdrawal|r |cFF2222[NYI]|r", "not yet implemented",
				function() return PA_SavedVars.Withdrawal.enabled end,
				function(val) PA_SavedVars.Withdrawal.enabled = val end)

	local PASubPanel = LAM:AddSubMenu(panel, "PA_Panel_Items_Withdrawal", "- Set items to withdraw", "Open the sub-menu to define for each item type whether it shall be withdrawed or not.")
	PAWMenu.createItemSubMenu(LAM, PASubPanel)
	
end

function PAWMenu.createItemSubMenu(LAM, panel)	
	for i = 0, #PAItemTypes do
		-- only add if the itemType is enabled
		if PAItemTypes[i] ~= "" then
			LAM:AddCheckbox(panel, string.format("PAW_ItemTypes_Enabled_%s", i), PA.getResourceMessage(PAItemTypes[i]), "",
				function() return PA_SavedVars.Withdrawal.ItemTypes[i] end,
				function(val) PA_SavedVars.Withdrawal.ItemTypes[i] = val end)
		end
	end
end