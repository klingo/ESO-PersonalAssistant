-- Module: PersonalAssistant.PADeposit
-- Developer: Klingo

PAD = {}

function PAD.OnBankOpen()
	-- check if addon is enabled
	if PA_SavedVars.Deposit.enabled then
		-- check if gold deposit is activated
		if PA_SavedVars.Deposit.gold then
			-- check for numeric value, if not, use default value of 0
			local minGoldToKeep = 0
			if tonumber(PA_SavedVars.Deposit.minGoldToKeep) ~= nil then
				minGoldToKeep = PA_SavedVars.Deposit.minGoldToKeep
			end
			
			-- check if minim amount of gold to keep is exceeded
			if (GetCurrentMoney() > minGoldToKeep) then
				PAD.DepositGold(minGoldToKeep)
			end
		end
	end
end

function PAD.DepositGold(minGoldToKeep)
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
	else
		if PA_SavedVars.Deposit.hideNoDepositMsg == false then
			PAD.println("Nothing to deposit.")
		end
	end
end

function PAD.println(msg)
	if PA_SavedVars.Deposit.hideAllMsg then return end
    d("PADeposit: " .. msg)
end