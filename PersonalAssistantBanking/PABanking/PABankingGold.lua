-- Module: PersonalAssistant.PABanking.Gold
-- Developer: Klingo

PAB_Gold = {}

-- =====================================================================================================================
-- =====================================================================================================================

local function getGoldChangeAmount(currAmount, targetMinimum, transactionStep)
    local currMoneyKeepDiff = targetMinimum - currAmount

    -- only do additional caluclations if transaction step is > 1
    if (transactionStep > 1) then
        -- when the difference is positive, add the transactionStep to the diff
        if (currMoneyKeepDiff > 0) then
            -- since the diff-value is positive, we want do withdraw money
            currMoneyKeepDiff = currMoneyKeepDiff + transactionStep
        end
        -- afterwards, multiply (for all) the diff by the transactionStep
        currMoneyKeepDiff = currMoneyKeepDiff / transactionStep
        -- then round down
        currMoneyKeepDiff = PAHF.roundDown(currMoneyKeepDiff)
        -- and finally, multiply by the transactionStep
        currMoneyKeepDiff = currMoneyKeepDiff * transactionStep
    end

    return currMoneyKeepDiff
end


local function withdrawGold(goldChange)
    local bankedMoney = GetBankedMoney()

    if (bankedMoney >= goldChange) then
        -- actual WITHDRAWAL
        WithdrawMoneyFromBank(goldChange)
        PAHF.println("PAB_GoldWithdrawn", goldChange)
    else
        -- not enough gold to withdraw planned amount; caclulcate minimum that can be withdrawn
        local goldTransactionStep = PA.savedVars.Banking[PA.activeProfile].goldTransactionStep
        local toWithdraw = getGoldChangeAmount(bankedMoney, 0, goldTransactionStep) * -1
        -- actual WITHDRAWAL
        WithdrawMoneyFromBank(toWithdraw)
        PAHF.println("PAB_GoldWithdrawnInsufficient", toWithdraw, bankedMoney)
    end

end


local function depositGold(goldChange)
    -- actual DEPOSIT
    DepositMoneyIntoBank(goldChange)
    PAHF.println("PAB_GoldDeposited", goldChange)
end


-- =====================================================================================================================
-- =====================================================================================================================


function PAB_Gold.DepositWithdrawGold()

    local currentMoney = GetCurrentMoney()
    local goldMinToKeep = PA.savedVars.Banking[PA.activeProfile].goldMinToKeep
    local withdrawToMinGold = PA.savedVars.Banking[PA.activeProfile].withdrawToMinGold
    local goldTransactionStep = PA.savedVars.Banking[PA.activeProfile].goldTransactionStep

    -- calculate the exact amount
    local goldChangeAmount = getGoldChangeAmount(currentMoney, goldMinToKeep, goldTransactionStep)

    if (goldChangeAmount < 0) then
        -- deposit money
        depositGold(goldChangeAmount * -1)
    elseif (goldChangeAmount > 0 and withdrawToMinGold) then
        -- withdraw money
        withdrawGold(goldChangeAmount)
    else
        -- no change required
    end
end


-- =====================================================================================================================
-- =====================================================================================================================