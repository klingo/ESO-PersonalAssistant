-- Local instances of Global tables --
local PA = PersonalAssistant

-- ---------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------
local window = PABankingAddCustomRuleWindow
local initDone = false


local function initPABAddCustomRuleUIDialog()
    if not initDone then
        initDone = true

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
        local itemEntryBank = ZO_ComboBox:CreateItemEntry(LocaleAwareToUpper(GetString(SI_PA_NS_BAG_BANK)), function()
            d("testomatoBANK")
            -- TODO: set selected
        end )
        local itemEntryBackpack = ZO_ComboBox:CreateItemEntry(LocaleAwareToUpper(GetString(SI_PA_NS_BAG_BACKPACK)), function()
            d("testomatoBACKPACK")
            -- TODO: set selected
        end )
        bagDropdownControl.m_comboBox:AddItem(itemEntryBank)
        bagDropdownControl.m_comboBox:AddItem(itemEntryBackpack)
        -- define the default entry
        function bagDropdownControl:SelectDefault()
            bagDropdownControl.m_comboBox:SelectItem(itemEntryBank)
        end

        -- initialize the dropdown for the mathematical operator
        local mathOperatorDropdownControl = window:GetNamedChild("MathOperatorDropdown")
        local itemEntryEquals = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_REL_EQUAL), function()
            d("==")
            -- TODO: set selected
        end )
        local itemEntryLessThanOrEqual = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_REL_LESSTHANOREQUAL), function()
            d("<=")
            -- TODO: set selected
        end )
        local itemEntryGreaterThanOrEqual = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_REL_GREATERTHANOREQUAL), function()
            d(">=")
            -- TODO: set selected
        end )
        mathOperatorDropdownControl.m_comboBox:AddItem(itemEntryEquals)
        mathOperatorDropdownControl.m_comboBox:AddItem(itemEntryLessThanOrEqual)
        mathOperatorDropdownControl.m_comboBox:AddItem(itemEntryGreaterThanOrEqual)
        -- define the default entry
        function mathOperatorDropdownControl:SelectDefault()
            mathOperatorDropdownControl.m_comboBox:SelectItem(itemEntryEquals)
        end
    end
end

local function showPABAddCustomRuleUIDIalog(itemLink)
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
    bagDropdownControl:SelectDefault()
    mathOperatorDropdownControl:SelectDefault()
    amountEditControl:SetText("100")

    -- finally, show window
    window:SetHidden(false)
end


-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.CustomDialogs = PA.CustomDialogs or {}
PA.CustomDialogs.initPABAddCustomRuleUIDialog = initPABAddCustomRuleUIDialog
PA.CustomDialogs.showPABAddCustomRuleUIDIalog = showPABAddCustomRuleUIDIalog