-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAB = PA.Banking
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local window = PABankingAddCustomAdvancedRuleWindow

local _initDone = false
local _selectedItemGroup

local DropdownRefs = {
    anyPleaseSelect = ZO_ComboBox:CreateItemEntry("<Please Select>", function() -- TODO: extract
        _selectedItemGroup = ITEMFILTERTYPE_WEAPONS
    end ),

    itemGroupWeapons = ZO_ComboBox:CreateItemEntry(zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS)), function()
        _selectedItemGroup = ITEMFILTERTYPE_WEAPONS
    end ),
    itemGroupArmor = ZO_ComboBox:CreateItemEntry(zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR)), function()
        _selectedItemGroup = ITEMFILTERTYPE_ARMOR
    end ),
    itemGroupJewelry = ZO_ComboBox:CreateItemEntry(zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY)), function()
        _selectedItemGroup = ITEMFILTERTYPE_JEWELRY
    end ),
}

-- ---------------------------------------------------------------------------------------------------------------------

local function deletePABCustomAdvancedRule()

    -- TODO: add code

end

local function initPABAddCustomAdvancedRuleUIDialog()
    if not _initDone then
       _initDone = true

        -- TODO: add code

        local headerControl = window:GetNamedChild("Header")
        headerControl:SetText("Add new advanced rule") -- TODO: extract

        -- initialize the item group dropdown
        local itemGroupLabelControl = window:GetNamedChild("ItemGroupLabel")
        itemGroupLabelControl:SetText("Item Group") -- TODO: extract
        local itemGroupDropdownControl = window:GetNamedChild("ItemGroupDropdown")
        itemGroupDropdownControl.m_comboBox:AddItem(DropdownRefs.anyPleaseSelect)
        itemGroupDropdownControl.m_comboBox:AddItem(DropdownRefs.itemGroupWeapons)
        itemGroupDropdownControl.m_comboBox:AddItem(DropdownRefs.itemGroupArmor)
        itemGroupDropdownControl.m_comboBox:AddItem(DropdownRefs.itemGroupJewelry)
        -- define the default entry
        function itemGroupDropdownControl:SelectDefault()
            itemGroupDropdownControl.m_comboBox:SelectItem(DropdownRefs.anyPleaseSelect)
        end

        -- Get the ShifterBox Library
        PA.LibShifterBox = PA.LibShifterBox or LibShifterBox

        -- initialize the quality dropdown

        -- initialize the equipType dropdown(only for Armor)

        -- initialize the traitType dropdown


        -- TODO:  listbox

        local itemQualitiesShifterBox = PA.LibShifterBox(PAB.AddonName, "ItemQualities", window)
        itemQualitiesShifterBox:SetAnchor(TOPLEFT, itemGroupDropdownControl, BOTTOMLEFT, 0, 20)
        itemQualitiesShifterBox:SetDimensions(400, 180)
--        listBoxControl:SetHidden(false)


    end
end

local function showPABAddCustomAdvancedRuleUIDialog()

    -- TODO: add code


    -- finally, show window
    window:SetHidden(false)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.CustomDialogs = PA.CustomDialogs or {}
PA.CustomDialogs.deletePABCustomAdvancedRule = deletePABCustomAdvancedRule
PA.CustomDialogs.initPABAddCustomAdvancedRuleUIDialog = initPABAddCustomAdvancedRuleUIDialog
PA.CustomDialogs.showPABAddCustomAdvancedRuleUIDialog = showPABAddCustomAdvancedRuleUIDialog