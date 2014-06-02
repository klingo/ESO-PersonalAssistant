PA_SettingsMenu = {}

local LAM = LibStub("LibAddonMenu-1.0")

function PA_SettingsMenu.CreateOptions()
	-- first register the panel with LAM
    local PAPanel = LAM:CreateControlPanel("PA_Panel", PA.getResourceMessage("MMenu_Title"))
	
	-- then delay the actual creation of the option items by 1 second to reduce the anchor overload at startup
	zo_callLater(function() PA_SettingsMenu.CreateOptionItems(PAPanel) end, 1000)
end

function PA_SettingsMenu.CreateOptionItems(PAPanel)

	-- PAGeneral
	LAM:AddHeader(PAPanel, "PAG_Header", PA.getResourceMessage("PAGMenu_Header"))
	LAM:AddCheckbox(PAPanel, "PA_Welcome_Enabled", PA.getResourceMessage("PAGMenu_Welcome"), PA.getResourceMessage("PAGMenu_Welcome_T"),
				function() return PA_SavedVars.General.welcome end,
				function(val) PA_SavedVars.General.welcome = val end)

	-- PARepair
    LAM:AddHeader(PAPanel, "PAR_Header", PA.getResourceMessage("PARMenu_Header"))
	PARMenu.createMenu(LAM, PAPanel)
	
	-- PABanking
	LAM:AddHeader(PAPanel, "PAB_Header", PA.getResourceMessage("PABMenu_Header"))
	PABMenu.createMenu(LAM, PAPanel)
end