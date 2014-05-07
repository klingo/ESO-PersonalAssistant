PA_SettingsMenu = {}

local LAM = LibStub("LibAddonMenu-1.0")

PA_SettingsMenu.CreateOptions = function()
    local PAPanel = LAM:CreateControlPanel("PA_Panel", "|cFFD700P|rersonal|cFFD700A|rssistant")
	
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