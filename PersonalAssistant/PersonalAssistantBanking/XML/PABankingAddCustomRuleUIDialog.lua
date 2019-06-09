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

local _initDone = false
local _selectedBag, _selectedMathOperator, _selectedItemLink

local DropdownRefs = {
    itemEntryBank = ZO_ComboBox:CreateItemEntry(LocaleAwareToUpper(GetString(SI_PA_NS_BAG_BANK)), function()
        _selectedBag = BAG_BANK
    end ),
    itemEntryBackpack = ZO_ComboBox:CreateItemEntry(LocaleAwareToUpper(GetString(SI_PA_NS_BAG_BACKPACK)), function()
        _selectedBag = BAG_BACKPACK
    end ),

    itemEntryEquals = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_REL_OPERATOR1), function()
        _selectedMathOperator = OPERATOR_EQUALS
    end ),
    itemEntryLessThanOrEqual = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_REL_OPERATOR3), function()
        _selectedMathOperator = OPERATOR_LESSTHANOREQUAL
    end ),
    itemEntryGreaterThanOrEqual = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_REL_OPERATOR5), function()
        _selectedMathOperator = OPERATOR_GREATERTHANOREQUAL
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
    local itemId = GetItemLinkItemId(_selectedItemLink)

    local PABCustomItemIds = PA.Banking.SavedVars.Custom.ItemIds
    -- only add the entry if it is an UPDATE case, or if it does not exist yet
    if isUpdate or not PAHF.isKeyInTable(PABCustomItemIds, itemId) then
        PABCustomItemIds[itemId] = {
            operator = bankingOperator,
            bagAmount = tonumber(targetAmount),
            itemLink = _selectedItemLink,
        }
        if isUpdate then
            PA.Banking.println(SI_PA_CHAT_BANKING_RULES_UPDATED, _selectedItemLink:gsub("%|H0", "|H1"))
        else
            PA.Banking.println(SI_PA_CHAT_BANKING_RULES_ADDED, _selectedItemLink:gsub("%|H0", "|H1"))
        end
        window:SetHidden(true)

        -- refresh the list (if it was initialized)
        if PA.BankingRulesList then PA.BankingRulesList:Refresh() end
    else
        PAB.debugln("ERROR; PAB already existing and this was NOT an update")
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

local function deletePABCustomRule(itemLink)
    local PABCustomItemIds = PA.Banking.SavedVars.Custom.ItemIds
    local itemId = GetItemLinkItemId(itemLink)
    if PAHF.isKeyInTable(PABCustomItemIds, itemId) then
        -- is in table, delete rule
        PABCustomItemIds[itemId] = nil
        PAB.println(SI_PA_CHAT_BANKING_RULES_DELETED, itemLink:gsub("%|H0", "|H1"))
        window:SetHidden(true)

        -- refresh the list (if it was initialized)
        if PA.BankingRulesList then PA.BankingRulesList:Refresh() end
    else
        PAB.debugln("ERROR; PAB rule not existing, cannot be deleted")
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
        addRuleButtonControl:GetNamedChild("AddRuleLabel"):SetText(GetString(SI_PA_SUBMENU_PAB_ADD_RULE_BUTTON))
        addRuleButtonControl:SetHandler("OnClicked", function()
            _addCustomRuleClicked(false)
        end)

        local updateRuleButtonControl = window:GetNamedChild("UpdateRuleButton")
        updateRuleButtonControl:GetNamedChild("UpdateRuleLabel"):SetText(GetString(SI_PA_SUBMENU_PAB_UPDATE_RULE_BUTTON))
        updateRuleButtonControl:SetHandler("OnClicked", function()
            _addCustomRuleClicked(true)
        end)

        local deleteRuleButtonControl = window:GetNamedChild("DeleteRuleButton")
        deleteRuleButtonControl:GetNamedChild("DeleteRuleLabel"):SetText(GetString(SI_PA_SUBMENU_PAB_DELETE_RULE_BUTTON))
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

    local bagDropdownControl = window:GetNamedChild("BagDropdown")
    local mathOperatorDropdownControl = window:GetNamedChild("MathOperatorDropdown")
    local amountEditBgControl = window:GetNamedChild("AmountEditBg")
    local amountEditControl = amountEditBgControl:GetNamedChild("AmountEdit")
    local addRuleButtonControl = window:GetNamedChild("AddRuleButton")
    local updateRuleButtonControl = window:GetNamedChild("UpdateRuleButton")
    local deleteRuleButtonControl = window:GetNamedChild("DeleteRuleButton")

    if existingRuleValues then
        -- initialise with existing values
        local bagEntry, mathOperatorEntry = _getDropdownValuesFromBankingOperator(existingRuleValues.operator)
        bagDropdownControl.m_comboBox:SelectItem(bagEntry)
        mathOperatorDropdownControl.m_comboBox:SelectItem(mathOperatorEntry)
        amountEditControl:SetText(existingRuleValues.bagAmount)
        -- show UPDATE/DELETE buttons, hide ADD button
        addRuleButtonControl:SetHidden(true)
        updateRuleButtonControl:SetHidden(false)
        deleteRuleButtonControl:SetHidden(false)
    else
        -- otherwise initialise default values
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
PA.CustomDialogs.deletePABCustomRule = deletePABCustomRule