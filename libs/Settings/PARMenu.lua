PARMenu = {}

function PARMenu.createMenu(LAM, panel)
    LAM:AddCheckbox(panel, "PAR_Enabled", PA.getResourceMessage("PARMenu_Enable"), PA.getResourceMessage("PARMenu_Enable_T"),
                    function() return PA_SavedVars.Repair.enabled end,
                    function(val) PA_SavedVars.Repair.enabled = val end)
    LAM:AddCheckbox(panel, "PAR_Equipped_Enabled", PA.getResourceMessage("PARMenu_RepairEq"), PA.getResourceMessage("PARMenu_RepairEq_T"),
                    function() return PA_SavedVars.Repair.equipped end,
                    function(val) PA_SavedVars.Repair.equipped = val end)
    LAM:AddSlider(panel, "PAR_Equipped_Threshold", PA.getResourceMessage("PARMenu_RepairEqDura"), PA.getResourceMessage("PARMenu_RepairEqDura_T"), 0, 100, 1,
					function() return PA_SavedVars.Repair.equippedThreshold end, 
					function(val) PA_SavedVars.Repair.equippedThreshold = val end)
    LAM:AddCheckbox(panel, "PAR_Backpack_Enabled", PA.getResourceMessage("PARMenu_RepairBa"), PA.getResourceMessage("PARMenu_RepairBa_T"),
                    function() return PA_SavedVars.Repair.backpack end,
                    function(val) PA_SavedVars.Repair.backpack = val end)
    LAM:AddSlider(panel, "PAR_Backpack_Threshold", PA.getResourceMessage("PARMenu_RepairBaDura"), PA.getResourceMessage("PARMenu_RepairBaDura_T"), 0, 100, 1,
					function() return PA_SavedVars.Repair.backpackThreshold end, 
					function(val) PA_SavedVars.Repair.backpackThreshold = val end)
    LAM:AddCheckbox(panel, "PAR_HideNothingToRepair", PA.getResourceMessage("PARMenu_HideNoRepair"), PA.getResourceMessage("PARMenu_HideNoRepair_T"),
                    function() return PA_SavedVars.Repair.hideNoRepairMsg end,
                    function(val) PA_SavedVars.Repair.hideNoRepairMsg = val end)
    LAM:AddCheckbox(panel, "PAR_HideAllMsg", PA.getResourceMessage("PARMenu_HideAll"), PA.getResourceMessage("PARMenu_HideAll_T"),
                    function() return PA_SavedVars.Repair.hideAllMsg end,
                    function(val) PA_SavedVars.Repair.hideAllMsg = val end)
end