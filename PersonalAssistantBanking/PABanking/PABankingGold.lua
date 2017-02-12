-- Module: PersonalAssistant.PABanking.Gold
-- Developer: Klingo

PAB_Gold = {}

function PAB_Gold.DepositGold(goldMinToKeep)
    local activeProfile = PA.savedVars.General.activeProfile

	-- check for numeric value, if not, use default value of 0
	local goldDepositInterval = 0
	if tonumber(PA.savedVars.Banking[activeProfile].goldDepositInterval) ~= nil then
		goldDepositInterval = PA.savedVars.Banking[activeProfile].goldDepositInterval
	end

	-- skip rest if deposit interval not reached
	if (GetDiffBetweenTimeStamps(GetTimeStamp(), PA.savedVars.Banking[activeProfile].goldLastDeposit) < goldDepositInterval) then
		return
	end
	
	-- calculate percentage amount to deposit
	local toDeposit = GetCurrentMoney() * (PA.savedVars.Banking[activeProfile].goldDepositPercentage / 100)

	-- check if minim amount of gold to keep would be undercut
	if ((GetCurrentMoney() - toDeposit) < goldMinToKeep) then
		toDeposit = GetCurrentMoney() - goldMinToKeep
	end

	-- round (down) the amount to deposit depending on the deposit step
	local goldTransactionStep = tonumber(PA.savedVars.Banking[activeProfile].goldTransactionStep)
	toDeposit = (math.floor(toDeposit / goldTransactionStep)) * goldTransactionStep

	-- if a deposable amount is left, deposit it
	if (toDeposit > 0) then
		DepositMoneyIntoBank(toDeposit)
		PA.savedVars.Banking[activeProfile].goldLastDeposit = GetTimeStamp()
		PAB.println("PAB_GoldDepositet", toDeposit, PAC_ICON_GOLD)
		
		return true		-- something was deposited
	else
		return false	-- nothing was deposited
	end
end

function PAB_Gold.WithdrawGold(goldMinToKeep)
	local toWithdraw = goldMinToKeep - GetCurrentMoney()
	local bankedMoney = GetBankedMoney()
	local goldTransactionStep = tonumber(PA.savedVars.Banking[PA.savedVars.General.activeProfile].goldTransactionStep)

	if (toWithdraw > 0 and bankedMoney > 0) then
		toWithdraw = math.floor(toWithdraw / goldTransactionStep)
		if goldTransactionStep > 1 then
			toWithdraw = toWithdraw + 1	-- in case of all steps > "1", increase by 1 to fix the roundUp
		end
		toWithdraw = toWithdraw * goldTransactionStep
		
		-- small fix in case no gold was on the char at all
		if ((toWithdraw - goldTransactionStep) >= goldMinToKeep) then
			toWithdraw = toWithdraw - goldTransactionStep
		end
		
		if toWithdraw > bankedMoney then
			WithdrawMoneyFromBank(bankedMoney) 
			PAB.println("PAB_GoldWithdrawnInsufficient", bankedMoney, toWithdraw, PAC_ICON_GOLD)
		else
			WithdrawMoneyFromBank(toWithdraw) 
			PAB.println("PAB_GoldWithdrawn", toWithdraw, PAC_ICON_GOLD)
		end
		
		return true		-- something was withdrawn
	elseif (toWithdraw > 0 and bankedMoney == 0) then
		PAB.println("PAB_GoldWithdrawnInsufficient", bankedMoney, toWithdraw, PAC_ICON_GOLD)
		
		return true		-- something was withdrawn (or at least tried to do so)
	else
		return false	-- nothing was withdrawn
	end
end