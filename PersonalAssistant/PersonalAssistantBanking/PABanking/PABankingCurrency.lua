-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PAC = PA.Constants
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local function withdrawCurrency(ccyAmountToWithdraw, currencyType)
    local ccyAmountOnBank = GetCurrencyAmount(currencyType, CURRENCY_LOCATION_BANK)
    local maxCcyTransfer = GetMaxCurrencyTransfer(currencyType, CURRENCY_LOCATION_BANK, CURRENCY_LOCATION_CHARACTER)
    local originalCcyAmountToWithdraw = ccyAmountToWithdraw

    -- check if all requested amount can be transfered; if not calculate the valid amount
    if (ccyAmountOnBank >= ccyAmountToWithdraw) then
        -- enough currency in SOURCE
        if (maxCcyTransfer >= ccyAmountToWithdraw) then
            -- enough space in TARGET --> FULL
            PAB.println(SI_PA_CHAT_BANKING_WITHDRAWAL_COMPLETE, ccyAmountToWithdraw, PAC.ICONS.CURRENCY[currencyType].SMALL)
        else
            -- not enough space in TARGET --> PARTIAL (limited by TARGET)
            ccyAmountToWithdraw = maxCcyTransfer
            PAB.println(SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_TARGET, ccyAmountToWithdraw, originalCcyAmountToWithdraw, PAC.ICONS.CURRENCY[currencyType].SMALL)
        end
    else
        -- not enough currency in SOURCE --> PARTIAL (limited by SOURCE)
        ccyAmountToWithdraw = ccyAmountOnBank
        PAB.println(SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_SOURCE, ccyAmountToWithdraw, originalCcyAmountToWithdraw, PAC.ICONS.CURRENCY[currencyType].SMALL)
    end

    -- actual WITHDRAWAL
    TransferCurrency(currencyType, ccyAmountToWithdraw, CURRENCY_LOCATION_BANK, CURRENCY_LOCATION_CHARACTER)
end


local function depositCurrency(ccyAmountToDeposit, currencyType)
    local ccyAmountOnCharacter = GetCurrencyAmount(currencyType, CURRENCY_LOCATION_CHARACTER) -- TODO: really needed?
    local maxCcyTransfer = GetMaxCurrencyTransfer(currencyType, CURRENCY_LOCATION_CHARACTER, CURRENCY_LOCATION_BANK)
    local originalCcyAmountToDeposit = ccyAmountToDeposit

    if (ccyAmountOnCharacter >= ccyAmountToDeposit) then
        -- enough currency in SOURCE
        if (maxCcyTransfer >= ccyAmountToDeposit) then
            -- enough space in TARGET --> FULL
            PAB.println(SI_PA_CHAT_BANKING_DEPOSIT_COMPLETE, ccyAmountToDeposit, PAC.ICONS.CURRENCY[currencyType].SMALL)
        else
            -- not enough space in TARGET --> PARTIAL (limited by TARGET)
            ccyAmountToDeposit = maxCcyTransfer
            PAB.println(SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_TARGET, ccyAmountToDeposit, originalCcyAmountToDeposit, PAC.ICONS.CURRENCY[currencyType].SMALL)
        end
    else
        -- not enough currency in SOURCE --> PARTIAL (limited by SOURCE)
        ccyAmountToDeposit = ccyAmountOnCharacter
        PAB.println(SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_SOURCE, ccyAmountToDeposit, originalCcyAmountToDeposit, PAC.ICONS.CURRENCY[currencyType].SMALL)
    end


    -- actual DEPOSIT
    TransferCurrency(currencyType, ccyAmountToDeposit, CURRENCY_LOCATION_CHARACTER, CURRENCY_LOCATION_BANK)
end


local function getChangeCcyAmount(currentCcyAmount, minToKeep, maxToKeep)
    -- Character has less than the minimum; positive amount returned (WITHDRAW)
    if currentCcyAmount < minToKeep then return (minToKeep - currentCcyAmount) end
    -- Character has more than the maximum; negative amount returned (DEPOSIT)
    if currentCcyAmount > maxToKeep then return (maxToKeep - currentCcyAmount) end
    -- if nothing returned yet; neither deposit nor withdraw is required
    return 0
end

-- ---------------------------------------------------------------------------------------------------------------------

local function depositOrWithdrawCurrencies()

    PAHF.debugln("PA.Banking.depositOrWithdrawCurrencies")

    local currencies = {
        {
            currencyType = CURT_MONEY,
            enabled = PAB.SavedVars.Currencies.goldTransaction,
            minToKeep = tonumber(PAB.SavedVars.Currencies.goldMinToKeep),
            maxToKeep = tonumber(PAB.SavedVars.Currencies.goldMaxToKeep),
        },
        {
            currencyType = CURT_ALLIANCE_POINTS,
            enabled = PAB.SavedVars.Currencies.alliancePointsTransaction,
            minToKeep = tonumber(PAB.SavedVars.Currencies.alliancePointsMinToKeep),
            maxToKeep = tonumber(PAB.SavedVars.Currencies.alliancePointsMaxToKeep),
        },
        {
            currencyType = CURT_TELVAR_STONES,
            enabled = PAB.SavedVars.Currencies.telVarTransaction,
            minToKeep = tonumber(PAB.SavedVars.Currencies.telVarMinToKeep),
            maxToKeep = tonumber(PAB.SavedVars.Currencies.telVarMaxToKeep),
        },
        {
            currencyType = CURT_WRIT_VOUCHERS,
            enabled = PAB.SavedVars.Currencies.writVouchersTransaction,
            minToKeep = tonumber(PAB.SavedVars.Currencies.writVouchersMinToKeep),
            maxToKeep = tonumber(PAB.SavedVars.Currencies.writVouchersMaxToKeep),
        },
    }

    for _, currency in pairs(currencies) do
        if (currency.enabled) then
            -- get the current amount of the currency on character
            local currentCcyAmount = GetCurrencyAmount(currency.currencyType, CURRENCY_LOCATION_CHARACTER)

            -- get the amount that needs to be transfered (either way)
            local changeCcyAmount = getChangeCcyAmount(currentCcyAmount, currency.minToKeep, currency.maxToKeep)

            -- act based on the to be transferred amount
            if (changeCcyAmount < 0) then
                -- deposit currency
                depositCurrency(changeCcyAmount * -1, currency.currencyType)
            elseif (changeCcyAmount > 0) then
                -- withdraw currency
                withdrawCurrency(changeCcyAmount, currency.currencyType)
            else
                -- no currency transaction required
            end
        end
    end
end



-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.depositOrWithdrawCurrencies = depositOrWithdrawCurrencies