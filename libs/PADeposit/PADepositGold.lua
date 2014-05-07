-- Module: PersonalAssistant.PADeposit.Gold
-- Developer: Klingo

PAD_Gold = {}

function PAD_Gold.DepositGold(minGoldToKeep)
	-- check for numeric value, if not, use default value of 0
	local depositInterval = 0
	if tonumber(PA_SavedVars.Deposit.depositInterval) ~= nil then
		depositInterval = PA_SavedVars.Deposit.depositInterval
	end
	
	-- skip rest if deposit interval not reached
	if (GetDiffBetweenTimeStamps(GetTimeStamp(), PA_SavedVars.Deposit.lastDeposit) < depositInterval) then	
		return
	end
	
	-- calculate percentage amount to deposit
	local toDeposit = GetCurrentMoney() * (PA_SavedVars.Deposit.depositPercentage / 100)

	-- check if minim amount of gold to keep would be undercut
	if ((GetCurrentMoney() - toDeposit) < minGoldToKeep) then
		toDeposit = GetCurrentMoney() - minGoldToKeep
	end

	-- round (down) the amount to deposit depending on the deposit step
	toDeposit = (math.floor(toDeposit / PA_SavedVars.Deposit.depositStep)) * PA_SavedVars.Deposit.depositStep

	-- if a deposable amount is left, deposit it
	if (toDeposit > 0) then
		DepositMoneyIntoBank(toDeposit)
		PA_SavedVars.Deposit.lastDeposit = GetTimeStamp()
		PAD.println(string.format("%d gold deposited.", toDeposit))
		
		return true		-- something was deposited
	else
		return false	-- nothing was deposited
	end
end