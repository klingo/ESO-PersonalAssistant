-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAB = PA.Banking
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local window = PABankingAddCustomRuleWindow

local OPERATOR_EQUALS = 1
local OPERATOR_LESSTHANOREQUAL = 3
local OPERATOR_GREATERTHANOREQUAL = 5

local MAXIMUM_AMOUNT = 10000

local _initDone = false
local _selectedBag, _selectedMathOperator, _selectedItemLink, _selectedAmount

local function _updateDescription()
    local descriptionLabelControl = window:GetNamedChild("DescriptionLabel")
    local bagName = PAHF.getBagName(_selectedBag)

    local function _getExactlyPreAndExplanationText()
        if _selectedBag == BAG_BANK then
            return table.concat({PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_BANK_EXACTLY_PRE, bagName, _selectedAmount), "\n", GetString(SI_PA_DIALOG_BANKING_EXPLANATION)})
        elseif _selectedBag == BAG_BACKPACK then
            return table.concat({PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_BACKPACK_EXACTLY_PRE, bagName, _selectedAmount), "\n", GetString(SI_PA_DIALOG_BANKING_EXPLANATION)})
        else
           return ""
        end
    end

    local function _getLessThanOrEqualPreAndExplanationText()
        if _selectedBag == BAG_BANK then
            return table.concat({PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_BANK_LESSTHANOREQUAL_PRE, bagName, _selectedAmount), "\n", GetString(SI_PA_DIALOG_BANKING_EXPLANATION)})
        elseif _selectedBag == BAG_BACKPACK then
            return table.concat({PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_BACKPACK_LESSTHANOREQUAL_PRE, bagName, _selectedAmount), "\n", GetString(SI_PA_DIALOG_BANKING_EXPLANATION)})
        else
            return ""
        end
    end

    local function _getGreaterThanOrEqualPreAndExplanationText()
        if _selectedBag == BAG_BANK then
            return table.concat({PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_BANK_GREATERTHANOREQUAL_PRE, bagName, _selectedAmount), "\n", GetString(SI_PA_DIALOG_BANKING_EXPLANATION)})
        elseif _selectedBag == BAG_BACKPACK then
            return table.concat({PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_BACKPACK_GREATERTHANOREQUAL_PRE, bagName, _selectedAmount), "\n", GetString(SI_PA_DIALOG_BANKING_EXPLANATION)})
        else
            return ""
        end
    end

    local function _getExactlyNothingText()
        if _selectedBag == BAG_BANK then
            return PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_BANK_EXACTLY_NOTHING, _selectedAmount, bagName)
        elseif _selectedBag == BAG_BACKPACK then
            return PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_BACKPACK_EXACTLY_NOTHING, _selectedAmount, bagName)
        else
            return ""
        end
    end

    local function _getExactlyDepositText()
        if _selectedBag == BAG_BANK then
            return PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_BANK_EXACTLY_DEPOSIT, 0, bagName, bagName, _selectedAmount)
        elseif _selectedBag == BAG_BACKPACK then
            return PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_BACKPACK_EXACTLY_DEPOSIT, 0, bagName, bagName, _selectedAmount)
        else
            return ""
        end
    end

    local function _getFromToDepositText(fromVal, toVal)
        if _selectedBag == BAG_BANK then
            return PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_BANK_FROM_TO_DEPOSIT, fromVal, toVal, bagName, bagName, _selectedAmount)
        elseif _selectedBag == BAG_BACKPACK then
            return PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_BACKPACK_FROM_TO_DEPOSIT, fromVal, toVal, bagName, bagName, _selectedAmount)
        else
            return ""
        end
    end

    local function _getFromToWithdrawText(fromVal, toVal)
        if _selectedBag == BAG_BANK then
            return PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_BANK_FROM_TO_WITHDRAW, fromVal, toVal, bagName, bagName, _selectedAmount)
        elseif _selectedBag == BAG_BACKPACK then
            return PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_BACKPACK_FROM_TO_WITHDRAW, fromVal, toVal, bagName, bagName, _selectedAmount)
        else
            return ""
        end
    end

    local function _getFromToNothingText(fromVal, toVal)
        if _selectedBag == BAG_BANK then
            return PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_BANK_FROM_TO_NOTHING, fromVal, toVal, bagName)
        elseif _selectedBag == BAG_BACKPACK then
            return PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_BACKPACK_FROM_TO_NOTHING, fromVal, toVal, bagName)
        else
            return ""
        end
    end


    if _selectedMathOperator == OPERATOR_EQUALS then
        local displayText = table.concat({_getExactlyPreAndExplanationText(), "\n"})
        if _selectedAmount == 0 then
            displayText = table.concat({displayText, _getExactlyNothingText(), "\n"});
        else
            if _selectedAmount == 1 then
                displayText = table.concat({displayText, _getExactlyDepositText(), "\n"});
            else
                displayText = table.concat({displayText, _getFromToDepositText(0, _selectedAmount - 1), "\n"});
            end
            displayText = table.concat({displayText, _getExactlyNothingText(), "\n"});
        end
        displayText = table.concat({displayText, _getFromToWithdrawText(_selectedAmount + 1, MAXIMUM_AMOUNT)});
        descriptionLabelControl:SetText(displayText)
    elseif _selectedMathOperator == OPERATOR_LESSTHANOREQUAL then
        local displayText = table.concat({_getLessThanOrEqualPreAndExplanationText(), "\n"})
        if _selectedAmount == 0 then
            displayText = table.concat({displayText, _getExactlyNothingText(), "\n"});
        else
            displayText = table.concat({displayText, _getFromToNothingText(0, _selectedAmount), "\n"});
        end
        displayText = table.concat({displayText, _getFromToDepositText(_selectedAmount + 1, MAXIMUM_AMOUNT)});
        descriptionLabelControl:SetText(displayText)
    elseif _selectedMathOperator == OPERATOR_GREATERTHANOREQUAL then
        local displayText = table.concat({_getGreaterThanOrEqualPreAndExplanationText(), "\n"})
        if _selectedAmount == 0 then
            displayText = table.concat({displayText, _getFromToNothingText(0, MAXIMUM_AMOUNT)});
        elseif _selectedAmount == 1 then
            displayText = table.concat({displayText, _getExactlyDepositText(), "\n"});
            displayText = table.concat({displayText, _getFromToNothingText(_selectedAmount, MAXIMUM_AMOUNT)});
        else
            displayText = table.concat({displayText, _getFromToDepositText(0, _selectedAmount - 1), "\n"});
            displayText = table.concat({displayText, _getFromToNothingText(_selectedAmount, MAXIMUM_AMOUNT)});
        end
        descriptionLabelControl:SetText(displayText)
    end
end


local DropdownRefs = {
    itemEntryBank = ZO_ComboBox:CreateItemEntry(LocaleAwareToUpper(GetString(SI_PA_NS_BAG_BANK)), function()
        _selectedBag = BAG_BANK
        -- update the description label
        _updateDescription();
    end ),
    itemEntryBackpack = ZO_ComboBox:CreateItemEntry(LocaleAwareToUpper(GetString(SI_PA_NS_BAG_BACKPACK)), function()
        _selectedBag = BAG_BACKPACK
        -- update the description label
        _updateDescription();
    end ),

    itemEntryEquals = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_REL_TEXT_OPERATOR1), function()
        _selectedMathOperator = OPERATOR_EQUALS
        -- update the description label
        _updateDescription();
    end ),
    itemEntryLessThanOrEqual = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_REL_TEXT_OPERATOR3), function()
        _selectedMathOperator = OPERATOR_LESSTHANOREQUAL
        -- update the description label
        _updateDescription();
    end ),
    itemEntryGreaterThanOrEqual = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_REL_TEXT_OPERATOR5), function()
        _selectedMathOperator = OPERATOR_GREATERTHANOREQUAL
        -- update the description label
        _updateDescription();
    end ),
}

-- ---------------------------------------------------------------------------------------------------------------------

local function _getBankingOperator()
    if _selectedBag == BAG_BANK then
        -- add 5 to the index because there are fife operators per bag (=, <, <=, >, >=)
        return _selectedMathOperator + 5
    else
        return _selectedMathOperator
    end
end

local function _getDropdownValuesFromBankingOperator(bankingOperator)
    local bagDropdownEntry = DropdownRefs.itemEntryEquals
    if bankingOperator == PAC.OPERATOR.BACKPACK_LESSTHANOREQUAL or bankingOperator == PAC.OPERATOR.BANK_LESSTHANOREQUAL then
        bagDropdownEntry = DropdownRefs.itemEntryLessThanOrEqual
    elseif bankingOperator == PAC.OPERATOR.BACKPACK_GREATERTHANOREQUAL or bankingOperator == PAC.OPERATOR.BANK_GREATERTHANOREQUAL then
        bagDropdownEntry = DropdownRefs.itemEntryGreaterThanOrEqual
    end

    if bankingOperator > 5 then
        return DropdownRefs.itemEntryBank, bagDropdownEntry
    else
        return DropdownRefs.itemEntryBackpack, bagDropdownEntry
    end
end

local function _addCustomRuleClicked(isUpdate)
    local amountEditBgControl = window:GetNamedChild("AmountEditBg")
    local amountEditControl = amountEditBgControl:GetNamedChild("AmountEdit")

    local bankingOperator = _getBankingOperator()
    local targetAmount = amountEditControl:GetText()
    local paItemId = PAHF.getPAItemLinkIdentifier(_selectedItemLink)

    local PABCustomPAItemIds = PA.Banking.SavedVars.Custom.PAItemIds
    -- only add the entry if it is an UPDATE case, or if it does not exist yet
    if not PAHF.isKeyInTable(PABCustomPAItemIds, paItemId) then
        PABCustomPAItemIds[paItemId] = {
            operator = bankingOperator,
            bagAmount = tonumber(targetAmount),
            itemLink = _selectedItemLink,
            ruleEnabled = true,
        }
        PAB.println(SI_PA_CHAT_BANKING_RULES_ADDED, _selectedItemLink:gsub("%|H0", "|H1"))
    elseif isUpdate then
        PABCustomPAItemIds[paItemId].operator = bankingOperator
        PABCustomPAItemIds[paItemId].bagAmount = tonumber(targetAmount)
        PABCustomPAItemIds[paItemId].itemLink = _selectedItemLink
        PAB.println(SI_PA_CHAT_BANKING_RULES_UPDATED, _selectedItemLink:gsub("%|H0", "|H1"))
    else
        PAB.debugln("ERROR; PAB rule already existing and this was NOT an update")
    end

    window:SetHidden(true)

    -- refresh the list (if it was initialized)
    if PA.BankingRulesList then PA.BankingRulesList:Refresh() end
end

-- ---------------------------------------------------------------------------------------------------------------------

local function deletePABCustomRule(itemLink)
    local PABCustomPAItemIds = PA.Banking.SavedVars.Custom.PAItemIds
    local paItemId = PAHF.getPAItemLinkIdentifier(itemLink)
    if PAHF.isKeyInTable(PABCustomPAItemIds, paItemId) then
        -- is in table, delete rule
        PABCustomPAItemIds[paItemId] = nil
        PAB.println(SI_PA_CHAT_BANKING_RULES_DELETED, itemLink:gsub("%|H0", "|H1"))
        window:SetHidden(true)

        -- refresh the list (if it was initialized)
        if PA.BankingRulesList then PA.BankingRulesList:Refresh() end
    else
        PAB.debugln("ERROR; PAB rule not existing, cannot be deleted")
    end
end

local function enablePABCustomRule(itemLink)
    local PABCustomPAItemIds = PA.Banking.SavedVars.Custom.PAItemIds
    local paItemId = PAHF.getPAItemLinkIdentifier(itemLink)
    if PAHF.isKeyInTable(PABCustomPAItemIds, paItemId) then
        -- is in table, enable rule
        PABCustomPAItemIds[paItemId].ruleEnabled = true
        PAB.println(SI_PA_CHAT_BANKING_RULES_ENABLED, itemLink:gsub("%|H0", "|H1"))

        -- refresh the list (if it was initialized)
        if PA.BankingRulesList then PA.BankingRulesList:Refresh() end
    else
        PAB.debugln("ERROR; PAB rule not existing, cannot be enabled")
    end
end

local function disablePABCustomRule(itemLink)
    local PABCustomPAItemIds = PA.Banking.SavedVars.Custom.PAItemIds
    local paItemId = PAHF.getPAItemLinkIdentifier(itemLink)
    if PAHF.isKeyInTable(PABCustomPAItemIds, paItemId) then
        -- is in table, disable rule
        PABCustomPAItemIds[paItemId].ruleEnabled = false
        PAB.println(SI_PA_CHAT_BANKING_RULES_DISABLED, itemLink:gsub("%|H0", "|H1"))

        -- refresh the list (if it was initialized)
        if PA.BankingRulesList then PA.BankingRulesList:Refresh() end
    else
        PAB.debugln("ERROR; PAB rule not existing, cannot be disabled")
    end
end

local function initPABAddCustomRuleUIDialog()
    if not _initDone then
        _initDone = true

        -- set generic handler for mouse exit (hide/clear tooltip)
        local itemControl = window:GetNamedChild("ItemControl")
        local itemLabelControl = itemControl:GetNamedChild("ItemLabel")
        itemLabelControl:SetHandler("OnMouseExit", function(self)
            ClearTooltip(ItemTooltip)
        end)

        -- initialize the disclaimer label
        local disclaimerLabelControl = window:GetNamedChild("DisclaimerLabel")
        disclaimerLabelControl:SetText(GetString(SI_PA_SUBMENU_PAB_DISCLAIMER))
        disclaimerLabelControl:SetDimensions(disclaimerLabelControl:GetTextDimensions())

        -- initialize the amount field
        local amountEditControl = window:GetNamedChild("AmountEditBg"):GetNamedChild("AmountEdit")
        amountEditControl:SetHandler("OnFocusLost", function(self)
            local value = tonumber(self:GetText())
            if type(value) == "number" then
                _selectedAmount = value
                _updateDescription();
            end
        end)

        -- initialize the dropdown for the bag selection (BANK vs BACKPACK)
        local bagDropdownControl = window:GetNamedChild("BagDropdown")
        bagDropdownControl.m_comboBox:AddItem(DropdownRefs.itemEntryBank)
        bagDropdownControl.m_comboBox:AddItem(DropdownRefs.itemEntryBackpack)
        -- define the default entry
        function bagDropdownControl:SelectDefault()
            bagDropdownControl.m_comboBox:SelectItem(DropdownRefs.itemEntryBackpack)
        end

        -- initialize the dropdown for the mathematical operator
        local mathOperatorDropdownControl = window:GetNamedChild("MathOperatorDropdown")
        mathOperatorDropdownControl.m_comboBox:AddItem(DropdownRefs.itemEntryEquals)
        mathOperatorDropdownControl.m_comboBox:AddItem(DropdownRefs.itemEntryLessThanOrEqual)
        mathOperatorDropdownControl.m_comboBox:AddItem(DropdownRefs.itemEntryGreaterThanOrEqual)
        -- define the default entry
        function mathOperatorDropdownControl:SelectDefault()
            mathOperatorDropdownControl.m_comboBox:SelectItem(DropdownRefs.itemEntryEquals)
        end

        -- initialize the localized buttons
        local addRuleButtonControl = window:GetNamedChild("AddRuleButton")
        local addRuleLabelControl = addRuleButtonControl:GetNamedChild("AddRuleLabel")
        addRuleLabelControl:SetText(GetString(SI_PA_SUBMENU_PAB_ADD_RULE_BUTTON))
        addRuleLabelControl:SetDimensions(addRuleLabelControl:GetTextDimensions())
        addRuleButtonControl:SetHandler("OnClicked", function()
            _addCustomRuleClicked(false)
        end)

        local updateRuleButtonControl = window:GetNamedChild("UpdateRuleButton")
        local updateRuleLabelControl = updateRuleButtonControl:GetNamedChild("UpdateRuleLabel")
        updateRuleLabelControl:SetText(GetString(SI_PA_SUBMENU_PAB_UPDATE_RULE_BUTTON))
        updateRuleLabelControl:SetDimensions(updateRuleLabelControl:GetTextDimensions())
        updateRuleButtonControl:SetHandler("OnClicked", function()
            _addCustomRuleClicked(true)
        end)

        local deleteRuleButtonControl = window:GetNamedChild("DeleteRuleButton")
        local deleteRuleLabelControl = deleteRuleButtonControl:GetNamedChild("DeleteRuleLabel")
        deleteRuleLabelControl:SetText(GetString(SI_PA_SUBMENU_PAB_DELETE_RULE_BUTTON))
        deleteRuleLabelControl:SetDimensions(deleteRuleLabelControl:GetTextDimensions())
        deleteRuleButtonControl:SetHandler("OnClicked", function()
            deletePABCustomRule(itemLabelControl:GetText())
        end)
    end
end

local function showPABAddCustomRuleUIDIalog(itemLink, existingRuleValues)
    local itemControl = window:GetNamedChild("ItemControl")
    local itemIconControl = itemControl:GetNamedChild("ItemTexture")
    local itemLabelControl = itemControl:GetNamedChild("ItemLabel")

    itemLabelControl:SetHandler('OnMouseEnter', function()
        InitializeTooltip(ItemTooltip, itemLabelControl)
        ItemTooltip:SetLink(itemLink)
    end)

    local itemIcon = GetItemLinkIcon(itemLink)
    itemIconControl:SetTexture(itemIcon)
    itemLabelControl:SetText(itemLink)

    local headerControl = window:GetNamedChild("Header")
    local bagDropdownControl = window:GetNamedChild("BagDropdown")
    local mathOperatorDropdownControl = window:GetNamedChild("MathOperatorDropdown")
    local amountEditBgControl = window:GetNamedChild("AmountEditBg")
    local amountEditControl = amountEditBgControl:GetNamedChild("AmountEdit")
    local addRuleButtonControl = window:GetNamedChild("AddRuleButton")
    local updateRuleButtonControl = window:GetNamedChild("UpdateRuleButton")
    local deleteRuleButtonControl = window:GetNamedChild("DeleteRuleButton")

    if existingRuleValues then
        headerControl:SetText(table.concat({PAC.COLORED_TEXTS.PAB, ": ", GetString(SI_PA_SUBMENU_PAB_EDIT_RULE)}))
        -- initialise with existing values
        local bagEntry, mathOperatorEntry = _getDropdownValuesFromBankingOperator(existingRuleValues.operator)
        _selectedAmount = existingRuleValues.bagAmount
        bagDropdownControl.m_comboBox:SelectItem(bagEntry)
        mathOperatorDropdownControl.m_comboBox:SelectItem(mathOperatorEntry)
        amountEditControl:SetText(existingRuleValues.bagAmount)
        -- show UPDATE/DELETE buttons, hide ADD button
        addRuleButtonControl:SetHidden(true)
        updateRuleButtonControl:SetHidden(false)
        deleteRuleButtonControl:SetHidden(false)
    else
        headerControl:SetText(table.concat({PAC.COLORED_TEXTS.PAB, ": ", GetString(SI_PA_SUBMENU_PAB_ADD_RULE)}))
        -- otherwise initialise default values
        _selectedAmount = PAC.BACKPACK_AMOUNT.DEFAULT
        bagDropdownControl:SelectDefault()
        mathOperatorDropdownControl:SelectDefault()
        amountEditControl:SetText(PAC.BACKPACK_AMOUNT.DEFAULT)
        -- show ADD button, hide UPDATE/DELETE buttons
        addRuleButtonControl:SetHidden(false)
        updateRuleButtonControl:SetHidden(true)
        deleteRuleButtonControl:SetHidden(true)
    end

    -- keep a reference to the itemLink
    _selectedItemLink = itemLink

    -- finally, show window
    window:SetHidden(false)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.CustomDialogs = PA.CustomDialogs or {}
PA.CustomDialogs.initPABAddCustomRuleUIDialog = initPABAddCustomRuleUIDialog
PA.CustomDialogs.showPABAddCustomRuleUIDIalog = showPABAddCustomRuleUIDIalog
PA.CustomDialogs.enablePABCustomRule = enablePABCustomRule
PA.CustomDialogs.disablePABCustomRule = disablePABCustomRule
PA.CustomDialogs.deletePABCustomRule = deletePABCustomRule