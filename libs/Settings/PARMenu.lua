PARMenu = {}

function PARMenu.createMenu(LAM, panel)
--	LAM:AddDescription(panel, "PAR_Header_Desc", "This module will help you to keep your items repaired if they reach your defined durability threshold.")	
    LAM:AddCheckbox(panel, "PAR_Enabled", "|cB0B0FFEnable Auto Repair|r", "Enable Auto Repair?",
                    function() return PA_SavedVars.Repair.enabled end,
                    function(val) PA_SavedVars.Repair.enabled = val end)
    LAM:AddCheckbox(panel, "PAR_Equipped_Enabled", "Repair equipped items", "Repair equipped items?",
                    function() return PA_SavedVars.Repair.equipped end,
                    function(val) PA_SavedVars.Repair.equipped = val end)
    LAM:AddSlider(panel, 'PAR_Equipped_Threshold', '- Durability threshold in %', 'Repair equipped items only if they are at or below the defined durability threshold.', 0, 100, 1,
					function() return PA_SavedVars.Repair.equippedThreshold end, 
					function(val) PA_SavedVars.Repair.equippedThreshold = val end)
    LAM:AddCheckbox(panel, "PAR_Backpack_Enabled", "Repair backpack items", "Repair items in you backpack?",
                    function() return PA_SavedVars.Repair.backpack end,
                    function(val) PA_SavedVars.Repair.backpack = val end)
    LAM:AddSlider(panel, 'PAR_Backpack_Threshold', '- Durability threshold in %', 'Repair items in the backpack only if they are at or below the defined durability threshold.', 0, 100, 1,
					function() return PA_SavedVars.Repair.backpackThreshold end, 
					function(val) PA_SavedVars.Repair.backpackThreshold = val end)
    LAM:AddCheckbox(panel, "PAR_HideNothingToRepair", "Hide 'Nothing to Repair' message", "Hide 'Nothing to Repair' message. You will still see a message if there is something to repair.",
                    function() return PA_SavedVars.Repair.hideNoRepairMsg end,
                    function(val) PA_SavedVars.Repair.hideNoRepairMsg = val end)
    LAM:AddCheckbox(panel, "PAR_HideAllMsg", "Hide ALL messages", "Silent-Mode: no message will be displayed. You also won't see your repair cost.",
                    function() return PA_SavedVars.Repair.hideAllMsg end,
                    function(val) PA_SavedVars.Repair.hideAllMsg = val end)
end