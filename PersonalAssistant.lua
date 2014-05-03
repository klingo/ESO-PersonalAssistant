-- Addon: PersonalAssistant
-- Version: 1.1.1
-- Developer: Klingo

-- colors
local colWhite = "|cFFFFFF"
local colYellow = "|cFFFF00"


-- default values for PARepair
local Repair_Defaults = 
{
	enabled = true,
	equipped = true,
	equippedThreshold = 75,
	inventory = false,
	inventoryThreshold = 75,
    hideNoRepairMsg = false,
    hideAllMsg = false
}

-- default values for PADeposit
local Deposit_Defaults =
{
	enabled = false,
	gold = true,
	depositPercentage = 50,
	depositStep = 1,
	depositInterval = 300,
	minGoldToKeep = 250,
	lastDeposit = 0,
	items = true,
    hideNoDepositMsg = false,
    hideAllMsg = false
}

-- default values for PAWithdraw
local Withdrawal_Defaults =
{
	enabled = false
}

-- init saved variables and register Addon
local function init(eventCode, addOnName)
    if addOnName ~= "PersonalAssistant" then
        return
    end
	
    PA_SavedVars.Repair = ZO_SavedVars:New("PersonalAssistant_SavedVariables", 1, "Repair", Repair_Defaults)
	PA_SavedVars.Deposit = ZO_SavedVars:New("PersonalAssistant_SavedVariables", 1, "Deposit", Deposit_Defaults)
	PA_SavedVars.Withdrawal = ZO_SavedVars:New("PersonalAssistant_SavedVariables", 1, "Withdrawal", Withdrawal_Defaults)
	
	PA_SettingsMenu.CreateOptions()

	-- register PARepair
    EVENT_MANAGER:RegisterForEvent("PersonalAssistant", EVENT_OPEN_STORE, PAR.OnShopOpen)
	
	-- register PADeposit
	EVENT_MANAGER:RegisterForEvent( "PersonalAssistant", EVENT_OPEN_BANK, PAD.OnBankOpen )
end

local function introduction()
	EVENT_MANAGER:UnregisterForEvent("PersonalAssistant", EVENT_PLAYER_ACTIVATED)
	d(colYellow .. "P" .. colWhite .. "ersonal"..colYellow.."A"..colWhite.."ssistant"..colYellow.." at your service!")
end

EVENT_MANAGER:RegisterForEvent("PersonalAssistant", EVENT_ADD_ON_LOADED, init)
EVENT_MANAGER:RegisterForEvent("PersonalAssistant", EVENT_PLAYER_ACTIVATED, introduction)