-- Module: PersonalAssistant.PABanking.Gold
-- Developer: Klingo

PAB_Gold = {}

function PAB_Gold.DepositGold(goldMinToKeep)
	-- check for numeric value, if not, use default value of 0
	local goldDepositInterval = 0
	if tonumber(PA_SavedVars.Banking.goldDepositInterval) ~= nil then
		goldDepositInterval = PA_SavedVars.Banking.goldDepositInterval
	end

	-- skip rest if deposit interval not reached
	if (GetDiffBetweenTimeStamps(GetTimeStamp(), PA_SavedVars.Banking.goldLastDeposit) < goldDepositInterval) then	
		return
	end
	
	-- calculate percentage amount to deposit
	local toDeposit = GetCurrentMoney() * (PA_SavedVars.Banking.goldDepositPercentage / 100)

	-- check if minim amount of gold to keep would be undercut
	if ((GetCurrentMoney() - toDeposit) < goldMinToKeep) then
		toDeposit = GetCurrentMoney() - goldMinToKeep
	end

	-- round (down) the amount to deposit depending on the deposit step
	toDeposit = (math.floor(toDeposit / PA_SavedVars.Banking.goldTransactionStep)) * PA_SavedVars.Banking.goldTransactionStep

	-- if a deposable amount is left, deposit it
	if (toDeposit > 0) then
		DepositMoneyIntoBank(toDeposit)
		PA_SavedVars.Banking.goldLastDeposit = GetTimeStamp()
		PAB.println(string.format("%d gold deposited.", toDeposit))
		
		return true		-- something was deposited
	else
		return false	-- nothing was deposited
	end
end

function PAB_Gold.WithdrawGold(goldMinToKeep)
	local toWithdraw = goldMinToKeep - GetCurrentMoney()
	local bankedMoney = GetBankedMoney()
	if (toWithdraw > 0 and bankedMoney > 0) then
		toWithdraw = math.floor(toWithdraw / PA_SavedVars.Banking.goldTransactionStep)
		if PA_SavedVars.Banking.goldTransactionStep > 1 then
			toWithdraw = toWithdraw + 1	-- in case of all steps > "1", increase by 1 to fix the roundUp
		end
		toWithdraw = toWithdraw * PA_SavedVars.Banking.goldTransactionStep
		
		if toWithdraw > bankedMoney then
			WithdrawMoneyFromBank(bankedMoney) 
			PAB.println(string.format("%d / %d gold withdrawn. (not enough gold in bank!)", bankedMoney, toWithdraw))
		else
			WithdrawMoneyFromBank(toWithdraw) 
			PAB.println(string.format("%d gold withdrawn.", toWithdraw))
		end
		
		return true		-- something was withdrawn
	elseif (toWithdraw > 0 and bankedMoney == 0) then
		PAB.println(string.format("%d / %d gold withdrawn. (not enough gold in bank!)", bankedMoney, toWithdraw))
		
		return true		-- something was withdrawn (or at least tried to do so)
	else
		return false	-- nothing was withdrawn
	end
end