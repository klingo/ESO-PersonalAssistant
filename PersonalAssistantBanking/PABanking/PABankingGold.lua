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
            currMoneyKeepDiff = currMoneyKeepDiff + transactionStep
        end
        -- afterwards, multiply (for all) the diff by the transactionStep
        currMoneyKeepDiff = currMoneyKeepDiff / transactionStep
        -- then round down
        currMoneyKeepDiff = PAHF.round(currMoneyKeepDiff)
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
        -- not enough gold to withdraw planned amount
        -- caclulcate minimum that can be withdrawn
        local goldTransactionStep = PA.savedVars.Banking[PA.activeProfile].goldTransactionStep
        local toWithdraw = getGoldChangeAmount(bankedMoney, 0, goldTransactionStep)
        -- actual WITHDRAWAL
        WithdrawMoneyFromBank(toWithdraw)
        PAHF.println("PAB_GoldWithdrawnInsufficient", bankedMoney, toWithdraw)
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


    -- currentMoney             175     175     495     495     340     4613    333     500
    -- goldMinToKeep            200     500     200     200     999      500    200     500
    -- goldTransactionStep      100     10      100       1       1      100   1000      10

    -- RESULT:                  100     330    -200    -295     654    -4100      0       0


-- goldMinToKeep - currentMoney  25     325    -295    -295     654    -4113   -133       0


    --     diff    step      result         addsub+     divstep     rounddown       multistep
    --       25     100         100         125          1.25        1              100
    --      325      10         330         335         33.5        33              330
    --     -295     100        -200        negative     -2.95       -2             -200
    --     -295       1        -295     step = 1 dont do!
    --      654       1         654     step = 1 dont do!
    --    -4113     100       -4100        negative    -41         -41            -4100
    --     -133    1000           0        negative     -0.133       0                0
    --        0      10           0        negative

    local goldChangeAmount = getGoldChangeAmount(currentMoney, goldMinToKeep, goldTransactionStep)

    if (goldChangeAmount < 0) then
        -- deposit money
        depositGold(currentMoney * -1)
    elseif (goldChangeAmount > 0 and withdrawToMinGold) then
        -- withdraw money
        withdrawGold(goldChangeAmount)
    else
        -- no change required
    end
end


-- =====================================================================================================================
-- =====================================================================================================================

function PAB_Gold.DepositGold(goldMinToKeep)

    -- check for numeric value, if not, use default value of 0
    local goldDepositInterval = 0
    if tonumber(PA.savedVars.Banking[PA.activeProfile].goldDepositInterval) ~= nil then
        goldDepositInterval = PA.savedVars.Banking[PA.activeProfile].goldDepositInterval
    end

    -- skip rest if deposit interval not reached
    if (GetDiffBetweenTimeStamps(GetTimeStamp(), PA.savedVars.Banking[PA.activeProfile].goldLastDeposit) < goldDepositInterval) then
        return
    end

    -- calculate percentage amount to deposit
    local toDeposit = GetCurrentMoney() * (PA.savedVars.Banking[PA.activeProfile].goldDepositPercentage / 100)

    -- check if minim amount of gold to keep would be undercut
    if ((GetCurrentMoney() - toDeposit) < goldMinToKeep) then
        toDeposit = GetCurrentMoney() - goldMinToKeep
    end

    -- round (down) the amount to deposit depending on the deposit step
    local goldTransactionStep = tonumber(PA.savedVars.Banking[PA.activeProfile].goldTransactionStep)
    toDeposit = (math.floor(toDeposit / goldTransactionStep)) * goldTransactionStep

    -- if a deposable amount is left, deposit it
    if (toDeposit > 0) then
        DepositMoneyIntoBank(toDeposit)
        PA.savedVars.Banking[PA.activeProfile].goldLastDeposit = GetTimeStamp()
        PAHF.println("PAB_GoldDeposited", toDeposit)

        return true        -- something was deposited
    else
        return false    -- nothing was deposited
    end
end

function PAB_Gold.WithdrawGold(goldMinToKeep)
    local toWithdraw = goldMinToKeep - GetCurrentMoney()
    local bankedMoney = GetBankedMoney()
    local goldTransactionStep = tonumber(PA.savedVars.Banking[PA.activeProfile].goldTransactionStep)

    if (toWithdraw > 0 and bankedMoney > 0) then
        toWithdraw = math.floor(toWithdraw / goldTransactionStep)
        if goldTransactionStep > 1 then
            toWithdraw = toWithdraw + 1    -- in case of all steps > "1", increase by 1 to fix the roundUp
        end
        toWithdraw = toWithdraw * goldTransactionStep

        -- small fix in case no gold was on the char at all
        if ((toWithdraw - goldTransactionStep) >= goldMinToKeep) then
            toWithdraw = toWithdraw - goldTransactionStep
        end

        if toWithdraw > bankedMoney then
            WithdrawMoneyFromBank(bankedMoney)
            PAHF.println("PAB_GoldWithdrawnInsufficient", bankedMoney, toWithdraw)
        else
            WithdrawMoneyFromBank(toWithdraw)
            PAHF.println("PAB_GoldWithdrawn", toWithdraw)
        end

        return true        -- something was withdrawn
    elseif (toWithdraw > 0 and bankedMoney == 0) then
        PAHF.println("PAB_GoldWithdrawnInsufficient", bankedMoney, toWithdraw)

        return true        -- something was withdrawn (or at least tried to do so)
    else
        return false    -- nothing was withdrawn
    end
end