-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
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

    itemEntryEquals = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_REL_EQUAL), function()
        _selectedMathOperator = OPERATOR_EQUALS
    end ),
    itemEntryLessThanOrEqual = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_REL_LESSTHANOREQUAL), function()
        _selectedMathOperator = OPERATOR_LESSTHANOREQUAL
    end ),
    itemEntryGreaterThanOrEqual = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_REL_GREATERTHANOREQUAL), function()
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

-- ---------------------------------------------------------------------------------------------------------------------

local function initPABAddCustomRuleUIDialog()
    if not _initDone then
        _initDone = true

        -- set generic handler for mouse exit (hide/clear tooltip)
        local itemControl = window:GetNamedChild("ItemControl")
        local itemLabelControl = itemControl:GetNamedChild("ItemLabel")
        itemLabelControl:SetHandler("OnMouseExit", function(self)
            ClearTooltip(ItemTooltip)
        end)

        -- initialize the description label
        local descriptionLabelControl = window:GetNamedChild("DescriptionLabel")
        descriptionLabelControl:SetText("Add a custom banking rule") -- TODO: Add localization

        -- initialize the dropdown for the bag selection (BANK vs BACKPACK)
        local bagDropdownControl = window:GetNamedChild("BagDropdown")
        bagDropdownControl.m_comboBox:AddItem(DropdownRefs.itemEntryBank)
        bagDropdownControl.m_comboBox:AddItem(DropdownRefs.itemEntryBackpack)
        -- define the default entry
        function bagDropdownControl:SelectDefault()
            bagDropdownControl.m_comboBox:SelectItem(DropdownRefs.itemEntryBank)
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
        addRuleLabelControl:SetText("Add new rule") -- TODO: Add localization

        local updateRuleButtonControl = window:GetNamedChild("UpdateRuleButton")
        local updateRuleLabelControl = updateRuleButtonControl:GetNamedChild("UpdateRuleLabel")
        updateRuleLabelControl:SetText("Update rule") -- TODO: Add localization
        -- TODO: new button for DELETE RULE
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

    if existingRuleValues then
        -- initialise with existing values
        local bagEntry, mathOperatorEntry = _getDropdownValuesFromBankingOperator(existingRuleValues.operator)
        bagDropdownControl.m_comboBox:SelectItem(bagEntry)
        mathOperatorDropdownControl.m_comboBox:SelectItem(mathOperatorEntry)
        amountEditControl:SetText(existingRuleValues.bagAmount)
        -- show UPDATE button, hide ADD button
        addRuleButtonControl:SetHidden(true)
        updateRuleButtonControl:SetHidden(false)
    else
        -- otherwise initialise default values
        bagDropdownControl:SelectDefault()
        mathOperatorDropdownControl:SelectDefault()
        amountEditControl:SetText(PAC.BACKPACK_AMOUNT.DEFAULT)
        -- show ADD button, hide UPDATE button
        addRuleButtonControl:SetHidden(false)
        updateRuleButtonControl:SetHidden(true)
    end

    -- keep a reference to the itemLink
    _selectedItemLink = itemLink

    -- finally, show window
    window:SetHidden(false)
end

local function deletePABCustomRule(itemLink)
    local PABCustomItemIds = PA.Banking.SavedVars.Custom.ItemIds
    local itemId = GetItemLinkItemId(itemLink)
    if PAHF.isKeyInTable(PABCustomItemIds, itemId) then
        -- is in table, delete rule
        PABCustomItemIds[itemId] = nil
        -- TODO: confirmation message
        df("RULE deleted for %s", itemLink)
    else
        -- TODO: error, rule not existing
        d("ERROR; rule not existing, cannot be deleted")
    end
end

local function addCustomRuleClicked(isUpdate)
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
            bagAmount = targetAmount,
            itemLink = _selectedItemLink,
        }
        -- TODO: success message?
        df("RULE added/updated for %s", _selectedItemLink)
        window:SetHidden(true)
    else
        -- TODO: error, rule already existing
        d("ERROR; rule already existing")
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.CustomDialogs = PA.CustomDialogs or {}
PA.CustomDialogs.initPABAddCustomRuleUIDialog = initPABAddCustomRuleUIDialog
PA.CustomDialogs.showPABAddCustomRuleUIDIalog = showPABAddCustomRuleUIDIalog
PA.CustomDialogs.deletePABCustomRule = deletePABCustomRule
PA.CustomDialogs.addCustomRuleClicked = addCustomRuleClicked