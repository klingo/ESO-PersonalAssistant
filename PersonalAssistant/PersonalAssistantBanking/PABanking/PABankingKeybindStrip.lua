-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking

-- ---------------------------------------------------------------------------------------------------------------------

local PABankingButtonGroup = {
    {
        name = "PABanking_ExecuteItemTransfers",
        keybind = "PA_BANKING_EXECUTE_ITEM_TRANSFERS",
        callback = function() PAB.executeBankingItemTransfers() end, -- only called when directly clicked on keybind strip
        visible = function() return true end, -- always visible
        enabled = function() return not PAB.isBankItemTransferBlocked end,
    },
    alignment = KEYBIND_STRIP_ALIGN_LEFT,
}

local function updateBankKeybindStrip()
    if KEYBIND_STRIP:HasKeybindButtonGroup(PABankingButtonGroup) then
        if PAB.isBankItemTransferBlocked then
            PABankingButtonGroup[1].name = GetString(SI_BINDING_NAME_PA_BANKING_EXECUTE_ITEM_TRANSFERS_PENDING)
        else
            PABankingButtonGroup[1].name = GetString(SI_BINDING_NAME_PA_BANKING_EXECUTE_ITEM_TRANSFERS)
        end
        KEYBIND_STRIP:UpdateKeybindButtonGroup(PABankingButtonGroup)
    end
end

local function onBankOpenShowKeybindStrip()
    if not KEYBIND_STRIP:HasKeybindButtonGroup(PABankingButtonGroup) then
        KEYBIND_STRIP:AddKeybindButtonGroup(PABankingButtonGroup)
        -- also update the keybindstrip with the proper names
        updateBankKeybindStrip()
    end
end

local function onBankCloseHideKeybindStrip()
    if KEYBIND_STRIP:HasKeybindButtonGroup(PABankingButtonGroup) then
        KEYBIND_STRIP:RemoveKeybindButtonGroup(PABankingButtonGroup)
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.KeybindStrip = {
    updateBankKeybindStrip = updateBankKeybindStrip,
    onBankOpenShowKeybindStrip = onBankOpenShowKeybindStrip,
    onBankCloseHideKeybindStrip = onBankCloseHideKeybindStrip,
}
