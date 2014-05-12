PA_SettingsMenu = {}

local LAM = LibStub("LibAddonMenu-1.0")

function PA_SettingsMenu.CreateOptions()
	-- first register the panel with LAM
    local PAPanel = LAM:CreateControlPanel("PA_Panel", "|cFFD700P|rersonal|cFFD700A|rssistant")
	
	-- then delay the actual creation of the option items by 1 second to reduce the anchor overload at startup
	zo_callLater(function() PA_SettingsMenu.CreateOptionItems(PAPanel) end, 1000)
end

function PA_SettingsMenu.CreateOptionItems(PAPanel)
	-- PARepair
    LAM:AddHeader(PAPanel, "PAR_Header", "|cFFD700PA R|repair")
	PARMenu.createMenu(LAM, PAPanel)
	
	-- PADeposit
	LAM:AddHeader(PAPanel, "PAD_Header", "|cFFD700PA D|reposit")
	PADMenu.createMenu(LAM, PAPanel)
	
	-- PAWithdraw
	-- LAM:AddHeader(PAPanel, "PAW_Header", "|cFFD700PA W|rithdrawal")
	-- PAWMenu.createMenu(LAM, PAPanel)
end