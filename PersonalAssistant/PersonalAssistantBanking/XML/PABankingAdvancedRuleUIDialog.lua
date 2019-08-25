-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAB = PA.Banking
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local window = PABankingAddCustomAdvancedRuleWindow

-- constants for the UI
local LEVEL_NORMAL = 0
local LEVEL_CHAMPION = 1

local SET_NO_SET = 0
local SET_IS_SET = 1
local SET_ANY = 2

local CRAFTED_NOT_CRAFTED = 0
local CRAFTED_IS_CRAFTED = 1
local CRAFTED_ANY = 2

local TRAIT_UNKNOWN = 0
local TRAIT_KNOWN = 1
local TRAIT_ANY = 2
local TRAIT_SELECTED = 3

-- selected values on the UI
local _selectedItemGroup
local _selectedLevelFrom = 1 -- init value
local _selectedLevelFromType = LEVEL_NORMAL -- init value
local _selectedLevelTo = 160 -- init value
local _selectedLevelToType = LEVEL_CHAMPION -- init value
local _selectedSetSetting
local _selectedCraftedSetting
local _selectedTraitSetting
local _selectedQualities
local _selectedTraits
local _selectedItemTypes

-- shifterBox references
local _itemTypesShifterBox
local _itemQualitiesShifterBox
local _traitTypesShifterBox

-- init setting
local _initDone = false

-- ---------------------------------------------------------------------------------------------------------------------

local function _getRuleSummary()
    local function _getItemTypeText()
        local notSelectedItemTypes = _itemTypesShifterBox:GetLeftListEntries()
        local notSelectedCount = 0
        for _ in pairs(notSelectedItemTypes) do notSelectedCount = notSelectedCount + 1 end
        local selectedItemTypes = _itemTypesShifterBox:GetRightListEntries()
        local selectedCount = 0
        local itemTypes = {}
        for _, value in pairs(selectedItemTypes) do
            selectedCount = selectedCount + 1
            table.insert(itemTypes, value)
        end
        local itemGroupDropdownControl = window:GetNamedChild("ItemGroupDropdown")
        local selectedItemTextControl = itemGroupDropdownControl:GetNamedChild("SelectedItemText")
        local itemGroup = selectedItemTextControl:GetText()
        if selectedCount == 0 or notSelectedCount == 0 then
            return "["..itemGroup.."]"  -- TODO: extract
        else
            return "["..PAHF.getCommaSeparatedOrList(itemTypes).." "..itemGroup.."]"  -- TODO: extract
        end
    end

    local function _getQualityText()
        local notSelectedQualities = _itemQualitiesShifterBox:GetLeftListEntries()
        local notSelectedCount = 0
        for _ in pairs(notSelectedQualities) do notSelectedCount = notSelectedCount + 1 end
        local selectedQualities = _itemQualitiesShifterBox:GetRightListEntries()
        local selectedCount = 0
        local qualities = {}
        for key, value in PAHF.orderedPairs(selectedQualities) do
            selectedCount = selectedCount + 1
            table.insert(qualities, value)
        end
        if selectedCount == 0 or notSelectedCount == 0 then
            return nil
        else
            return "of ["..PAHF.getCommaSeparatedOrList(qualities).."] quality"  -- TODO: extract
        end
    end

    local function _getLevelText()
        local function _getSimpleLevelText(levelType, level)
            if levelType == LEVEL_NORMAL then
                return "Level "..level  -- TODO: extract
            else
                return "CP "..level  -- TODO: extract
            end
        end
        local itemLevelFromEdit = window:GetNamedChild("ItemLevelFromBg"):GetNamedChild("Edit")
        local itemLevelToEdit = window:GetNamedChild("ItemLevelToBg"):GetNamedChild("Edit")
        _selectedLevelFrom = tonumber(itemLevelFromEdit:GetText())
        _selectedLevelTo = tonumber(itemLevelToEdit:GetText())
        if _selectedLevelFrom == _selectedLevelTo and _selectedLevelFromType == _selectedLevelToType then
            -- from and to are the same
            return table.concat({"and [", _getSimpleLevelText(_selectedLevelFromType, _selectedLevelFrom), "]"})  -- TODO: extract
        elseif _selectedLevelFrom == "1" and _selectedLevelFromType == LEVEL_NORMAL and _selectedLevelTo == "160" and _selectedLevelToType == LEVEL_CHAMPION then
            -- from and to cover the full level-range
            return nil
        else
            local fromText = _getSimpleLevelText(_selectedLevelFromType, _selectedLevelFrom)
            local toText = _getSimpleLevelText(_selectedLevelToType, _selectedLevelTo)
            return table.concat({"between [", fromText, "] and [", toText, "]"})  -- TODO: extract
        end
    end

    local function _getSetText()
        if _selectedSetSetting == SET_IS_SET then
            return "[Set]"  -- TODO: extract
        elseif _selectedSetSetting == SET_NO_SET then
            return "[Non-Set]"  -- TODO: extract
        end
        return nil
    end

    local function _getCraftedText()
        if _selectedCraftedSetting == CRAFTED_IS_CRAFTED then
            return "[Crafted]"  -- TODO: extract
        elseif _selectedCraftedSetting == CRAFTED_NOT_CRAFTED then
            return "[Non-Crafted]"  -- TODO: extract
        end
        return nil
    end

    local function _getTraitText()
        if _selectedTraitSetting == TRAIT_KNOWN then
            return "with [known] traits" -- TODO: extract
        elseif _selectedTraitSetting == TRAIT_UNKNOWN then
            return "with [unknown] traits"  -- TODO: extract
        elseif _selectedTraitSetting == TRAIT_SELECTED then
            local notSelectedTraitTypes = _traitTypesShifterBox:GetLeftListEntries()
            local notSelectedCount = 0
            for _ in pairs(notSelectedTraitTypes) do notSelectedCount = notSelectedCount + 1 end
            local selectedTraitTypes = _traitTypesShifterBox:GetRightListEntries()
            local selectedCount = 0
            local traitTypes = {}
            for _, value in pairs(selectedTraitTypes) do
                selectedCount = selectedCount + 1
                table.insert(traitTypes, value)
            end
            if selectedCount == 0 then
                return "with [no] traits"  -- TODO: extract
            elseif notSelectedCount == 0 then
                return nil
            else
                return "with ["..PAHF.getCommaSeparatedOrList(traitTypes).."] trait"  -- TODO: extract
            end
        end
    end

    local function _getFormattedSummaryText()
        if _selectedItemGroup == nil then
            return "Please select an [Item Group] first..."   -- TODO: extract
        else
            local function _appendText(master, addedText)
                if addedText ~= nil then
                    return master.." "..addedText
                end
                return master
            end
            local craftedText = _getCraftedText()
            local setText = _getSetText()
            local itemTypeText = _getItemTypeText()
            local qualityText = _getQualityText()
            local levelText = _getLevelText()
            local traitText = _getTraitText()
            local summaryText = "Any"   -- TODO: extract
            summaryText = _appendText(summaryText, craftedText)
            summaryText = _appendText(summaryText, setText)
            summaryText = _appendText(summaryText, itemTypeText)
            summaryText = _appendText(summaryText, qualityText)
            summaryText = _appendText(summaryText, levelText)
            summaryText = _appendText(summaryText, traitText)
            return summaryText
        end
    end

    return _getFormattedSummaryText()


    -- TODO: come up with a logic for the rule summary :D

    -- SIMPLE:
    -- ANY weapons
    -- ANY apparels

    -- [Non-Crafted] [Non-Set] [Weapons] [of Normal, Fine, or Superior Quality] [with known Traits]
    -- [Crafted] [Set] [Light or Heavy Apparels] [of Epic or Legendary Quality] [with unknown Traits]
    -- [Non-Set] [Ring Jewelries] [of Legendary Quality] [with Arcane, Bloodthristy, or Healthy Trait]

    -- [Crafted] [Set] [Light or Heavy Apparels] [of Epic or Legendary Quality] and between [Level 5] and [CP 160] [with unknown Traits]
    -- [Crafted] [Set] [Light or Heavy Apparels] [of Epic or Legendary Quality] and between [CP 150] and [CP 160] [with unknown Traits]
    -- [Crafted] [Set] [Light or Heavy Apparels] [of Epic or Legendary Quality] and [CP 160] [with unknown Traits]

end

local function _getRuleSettingsTable()
    return {
        group = _selectedItemGroup,
        qualities = _selectedQualities,
        levelFrom = {
            type = _selectedLevelFromType,
            value = _selectedLevelFrom,
        },
        levelTo = {
            type = _selectedLevelToType,
            value = _selectedLevelTo,
        },
        set = _selectedSetSetting,
        crafted = _selectedCraftedSetting,
        types = _selectedItemTypes,
        traits = {
            type = _selectedTraitSetting,
            values = _selectedTraits,
        }
    }
end

local function _updateRuleSummary()
    local ruleSummary = _getRuleSummary()
    local ruleSummaryTextControl = window:GetNamedChild("RuleSummaryText")
    ruleSummaryTextControl:SetText(ruleSummary)
end

local function _resetShifterBoxAndResetToLeft(shifterBox, selectCategory, enabled)
    if selectCategory then shifterBox:ShowOnlyCategory(selectCategory) end
    shifterBox:MoveAllEntriesToLeftList()
    shifterBox:SetEnabled(enabled)
end

-- TODO: to be improved! use callback values to simplify the entries
local DropdownRefs = {
    itemGroupPleaseSelect = ZO_ComboBox:CreateItemEntry("<Please Select>", function(_, entryText, entry) -- TODO: extract
        _selectedItemGroup = nil
        _itemTypesShifterBox:SetEnabled(false)
        _traitTypesShifterBox:SetEnabled(false)
        local itemTraitDropdownControl = window:GetNamedChild("ItemTraitDropdown")
        itemTraitDropdownControl.m_comboBox:SetEnabled(false)
    end ),
    itemGroupWeapons = ZO_ComboBox:CreateItemEntry(zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS)), function()
        _selectedItemGroup = ITEMFILTERTYPE_WEAPONS
        _resetShifterBoxAndResetToLeft(_itemTypesShifterBox, ITEMFILTERTYPE_WEAPONS, true)
        _resetShifterBoxAndResetToLeft(_traitTypesShifterBox, ITEMFILTERTYPE_WEAPONS, _selectedTraitSetting == TRAIT_SELECTED)
        local itemTraitDropdownControl = window:GetNamedChild("ItemTraitDropdown")
        itemTraitDropdownControl.m_comboBox:SetEnabled(true)
        _updateRuleSummary()
    end ),
    itemGroupArmor = ZO_ComboBox:CreateItemEntry(zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR)), function()
        _selectedItemGroup = ITEMFILTERTYPE_ARMOR
        _resetShifterBoxAndResetToLeft(_itemTypesShifterBox, ITEMFILTERTYPE_ARMOR, true)
        _resetShifterBoxAndResetToLeft(_traitTypesShifterBox, ITEMFILTERTYPE_ARMOR, _selectedTraitSetting == TRAIT_SELECTED)
        local itemTraitDropdownControl = window:GetNamedChild("ItemTraitDropdown")
        itemTraitDropdownControl.m_comboBox:SetEnabled(true)
        _updateRuleSummary()
    end ),
    itemGroupJewelry = ZO_ComboBox:CreateItemEntry(zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY)), function()
        _selectedItemGroup = ITEMFILTERTYPE_JEWELRY
        _resetShifterBoxAndResetToLeft(_itemTypesShifterBox, ITEMFILTERTYPE_JEWELRY, true)
        _resetShifterBoxAndResetToLeft(_traitTypesShifterBox, ITEMFILTERTYPE_JEWELRY, _selectedTraitSetting == TRAIT_SELECTED)
        local itemTraitDropdownControl = window:GetNamedChild("ItemTraitDropdown")
        itemTraitDropdownControl.m_comboBox:SetEnabled(true)
        _updateRuleSummary()
    end ),

    setBoth = ZO_ComboBox:CreateItemEntry("Any items (Set and NON-Set)", function() -- TODO: extract
        _selectedSetSetting = SET_ANY
        _updateRuleSummary()
    end ),
    setYes = ZO_ComboBox:CreateItemEntry("Only items part of a Set", function() -- TODO: extract
        _selectedSetSetting = SET_IS_SET
        _updateRuleSummary()
    end ),
    setNo = ZO_ComboBox:CreateItemEntry("Only items NOT part of a Set", function() -- TODO: extract
        _selectedSetSetting = SET_NO_SET
        _updateRuleSummary()
    end ),

    craftedBoth = ZO_ComboBox:CreateItemEntry("Any items (crafted and NON-crafted)", function() -- TODO: extract
        _selectedCraftedSetting = CRAFTED_ANY
        _updateRuleSummary()
    end ),
    craftedYes = ZO_ComboBox:CreateItemEntry("Only crafted items", function() -- TODO: extract
        _selectedCraftedSetting = CRAFTED_IS_CRAFTED
        _updateRuleSummary()
    end ),
    craftedNo = ZO_ComboBox:CreateItemEntry("Only NON-crafted items", function() -- TODO: extract
        _selectedCraftedSetting = CRAFTED_NOT_CRAFTED
        _updateRuleSummary()
    end ),

    traitSelected = ZO_ComboBox:CreateItemEntry("Only selected traits", function() -- TODO: extract
        _selectedTraitSetting = TRAIT_SELECTED
        _resetShifterBoxAndResetToLeft(_traitTypesShifterBox, _selectedItemGroup, true)
        _updateRuleSummary()
    end ),
    traitBoth = ZO_ComboBox:CreateItemEntry("Any items (known and unknown traits)", function() -- TODO: extract
        _selectedTraitSetting = TRAIT_ANY
        _traitTypesShifterBox:SetEnabled(false)
        _updateRuleSummary()
    end ),
    traitKnown = ZO_ComboBox:CreateItemEntry("Only items with known traits", function() -- TODO: extract
        _selectedTraitSetting = TRAIT_KNOWN
        _traitTypesShifterBox:SetEnabled(false)
        _updateRuleSummary()
    end ),
    traitUnknown = ZO_ComboBox:CreateItemEntry("Only items with UNknown traits", function() -- TODO: extract
        _selectedTraitSetting = TRAIT_UNKNOWN
        _traitTypesShifterBox:SetEnabled(false)
        _updateRuleSummary()
    end ),
}

local function _createAndReturnItemQualitiesShifterBox()
    -- TODO: extract labels
    local shifterBoxSettings = {
        sortBy = "key",
        leftList = {
            title = "Available",
            emptyListText = "None",
        },
        rightList = {
            title = "Selected",
            emptyListText = "Any Quality",
        }
    }
    local itemQualitiesShifterBox = PA.LibShifterBox(PAB.AddonName, "ItemQualities", window, shifterBoxSettings)
    local listData = {
        [ITEM_QUALITY_TRASH] = GetItemQualityColor(ITEM_QUALITY_TRASH):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_TRASH)),
        [ITEM_QUALITY_NORMAL] = GetItemQualityColor(ITEM_QUALITY_NORMAL):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_NORMAL)),
        [ITEM_QUALITY_MAGIC] = GetItemQualityColor(ITEM_QUALITY_MAGIC):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_MAGIC)),
        [ITEM_QUALITY_ARCANE] = GetItemQualityColor(ITEM_QUALITY_ARCANE):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_ARCANE)),
        [ITEM_QUALITY_ARTIFACT] = GetItemQualityColor(ITEM_QUALITY_ARTIFACT):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_ARTIFACT)),
        [ITEM_QUALITY_LEGENDARY] = GetItemQualityColor(ITEM_QUALITY_LEGENDARY):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_LEGENDARY)),
    }
    itemQualitiesShifterBox:AddEntriesToLeftList(listData)
    _G["patest"] = itemQualitiesShifterBox
    return itemQualitiesShifterBox
end

local function _createAndReturnItemTypesShifterBox()
    -- TODO: extract labels
    local shifterBoxSettings = {
        leftList = {
            title = "Available",
            emptyListText = "None"
        },
        rightList = {
            title = "Selected",
            emptyListText = "Any Item Type"
        }
    }
    local itemTypesShifterBox = PA.LibShifterBox(PAB.AddonName, "ItemTypes", window, shifterBoxSettings)
    local armorTypeData = {
        [ITEMFILTERTYPE_ARMOR..ARMORTYPE_LIGHT] = GetString("SI_ARMORTYPE", ARMORTYPE_LIGHT),
        [ITEMFILTERTYPE_ARMOR..ARMORTYPE_MEDIUM] = GetString("SI_ARMORTYPE", ARMORTYPE_MEDIUM),
        [ITEMFILTERTYPE_ARMOR..ARMORTYPE_HEAVY] = GetString("SI_ARMORTYPE", ARMORTYPE_HEAVY),
    }
    itemTypesShifterBox:AddEntriesToLeftList(armorTypeData, false, ITEMFILTERTYPE_ARMOR)
    local twoHandedPrefix = table.concat({GetString("SI_WEAPONCONFIGTYPE", WEAPON_CONFIG_TYPE_TWO_HANDED), " "})
    local weaponTypeData = {
        [ITEMFILTERTYPE_WEAPONS..WEAPONTYPE_AXE] = GetString("SI_WEAPONTYPE", WEAPONTYPE_AXE),
        [ITEMFILTERTYPE_WEAPONS..WEAPONTYPE_BOW] = GetString("SI_WEAPONTYPE", WEAPONTYPE_BOW),
        [ITEMFILTERTYPE_WEAPONS..WEAPONTYPE_DAGGER] = GetString("SI_WEAPONTYPE", WEAPONTYPE_DAGGER),
        [ITEMFILTERTYPE_WEAPONS..WEAPONTYPE_FIRE_STAFF] = GetString("SI_WEAPONTYPE", WEAPONTYPE_FIRE_STAFF),
        [ITEMFILTERTYPE_WEAPONS..WEAPONTYPE_FROST_STAFF] = GetString("SI_WEAPONTYPE", WEAPONTYPE_FROST_STAFF),
        [ITEMFILTERTYPE_WEAPONS..WEAPONTYPE_HAMMER] = GetString("SI_WEAPONTYPE", WEAPONTYPE_HAMMER),
        [ITEMFILTERTYPE_WEAPONS..WEAPONTYPE_HEALING_STAFF] = GetString("SI_WEAPONTYPE", WEAPONTYPE_HEALING_STAFF),
        [ITEMFILTERTYPE_WEAPONS..WEAPONTYPE_LIGHTNING_STAFF] = GetString("SI_WEAPONTYPE", WEAPONTYPE_LIGHTNING_STAFF),
        [ITEMFILTERTYPE_WEAPONS..WEAPONTYPE_SHIELD] = GetString("SI_WEAPONTYPE", WEAPONTYPE_SHIELD),
        [ITEMFILTERTYPE_WEAPONS..WEAPONTYPE_SWORD] = GetString("SI_WEAPONTYPE", WEAPONTYPE_SWORD),
        [ITEMFILTERTYPE_WEAPONS..WEAPONTYPE_TWO_HANDED_AXE] = twoHandedPrefix..GetString("SI_WEAPONTYPE", WEAPONTYPE_TWO_HANDED_AXE),
        [ITEMFILTERTYPE_WEAPONS..WEAPONTYPE_TWO_HANDED_HAMMER] = twoHandedPrefix..GetString("SI_WEAPONTYPE", WEAPONTYPE_TWO_HANDED_HAMMER),
        [ITEMFILTERTYPE_WEAPONS..WEAPONTYPE_TWO_HANDED_SWORD] = twoHandedPrefix..GetString("SI_WEAPONTYPE", WEAPONTYPE_TWO_HANDED_SWORD),
    }
    itemTypesShifterBox:AddEntriesToLeftList(weaponTypeData, false, ITEMFILTERTYPE_WEAPONS)
    local jewelryTypeData = {
        [ITEMFILTERTYPE_JEWELRY..EQUIP_TYPE_NECK] = GetString("SI_EQUIPTYPE", EQUIP_TYPE_NECK),
        [ITEMFILTERTYPE_JEWELRY..EQUIP_TYPE_RING] = GetString("SI_EQUIPTYPE", EQUIP_TYPE_RING),
    }
    itemTypesShifterBox:AddEntriesToLeftList(jewelryTypeData, false, ITEMFILTERTYPE_JEWELRY)
    return itemTypesShifterBox
end

local function _createAndReturnTraitTypesShifterBox()
    -- TODO: extract labels
    local shifterBoxSettings = {
        leftList = {
            title = "Available",
            emptyListText = "None"
        },
        rightList = {
            title = "Selected",
            emptyListText = "No Traits"
        }
    }
    local traitTypesShifterBox = PA.LibShifterBox(PAB.AddonName, "TraitTypes", window, shifterBoxSettings)
    local armorTraitData = {
        [ITEM_TRAIT_TYPE_ARMOR_DIVINES] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_DIVINES),
        [ITEM_TRAIT_TYPE_ARMOR_IMPENETRABLE] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_IMPENETRABLE),
        [ITEM_TRAIT_TYPE_ARMOR_INFUSED] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INFUSED),
        [ITEM_TRAIT_TYPE_ARMOR_INTRICATE] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE),
        [ITEM_TRAIT_TYPE_ARMOR_NIRNHONED] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_NIRNHONED),
        [ITEM_TRAIT_TYPE_ARMOR_ORNATE] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE),
        [ITEM_TRAIT_TYPE_ARMOR_PROSPEROUS] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_PROSPEROUS),
        [ITEM_TRAIT_TYPE_ARMOR_REINFORCED] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_REINFORCED),
        [ITEM_TRAIT_TYPE_ARMOR_STURDY] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_STURDY),
        [ITEM_TRAIT_TYPE_ARMOR_TRAINING] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_TRAINING),
        [ITEM_TRAIT_TYPE_ARMOR_WELL_FITTED] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_WELL_FITTED),
    }
    traitTypesShifterBox:AddEntriesToLeftList(armorTraitData, false, ITEMFILTERTYPE_ARMOR)
    local jewelryTraitData = {
        [ITEM_TRAIT_TYPE_JEWELRY_ARCANE] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_JEWELRY_ARCANE),
        [ITEM_TRAIT_TYPE_JEWELRY_BLOODTHIRSTY] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_JEWELRY_BLOODTHIRSTY),
        [ITEM_TRAIT_TYPE_JEWELRY_HARMONY] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_JEWELRY_HARMONY),
        [ITEM_TRAIT_TYPE_JEWELRY_HEALTHY] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_JEWELRY_HEALTHY),
        [ITEM_TRAIT_TYPE_JEWELRY_INFUSED] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_JEWELRY_INFUSED),
        [ITEM_TRAIT_TYPE_JEWELRY_INTRICATE] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_JEWELRY_INTRICATE),
        [ITEM_TRAIT_TYPE_JEWELRY_ORNATE] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_JEWELRY_ORNATE),
        [ITEM_TRAIT_TYPE_JEWELRY_PROTECTIVE] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_JEWELRY_PROTECTIVE),
        [ITEM_TRAIT_TYPE_JEWELRY_ROBUST] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_JEWELRY_ROBUST),
        [ITEM_TRAIT_TYPE_JEWELRY_SWIFT] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_JEWELRY_SWIFT),
        [ITEM_TRAIT_TYPE_JEWELRY_TRIUNE] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_JEWELRY_TRIUNE),
    }
    traitTypesShifterBox:AddEntriesToLeftList(jewelryTraitData, false, ITEMFILTERTYPE_JEWELRY)
    local weaponTraitData = {
        [ITEM_TRAIT_TYPE_WEAPON_CHARGED] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_WEAPON_CHARGED),
        [ITEM_TRAIT_TYPE_WEAPON_DECISIVE] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_WEAPON_DECISIVE),
        [ITEM_TRAIT_TYPE_WEAPON_DEFENDING] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_WEAPON_DEFENDING),
        [ITEM_TRAIT_TYPE_WEAPON_INFUSED] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_WEAPON_INFUSED),
        [ITEM_TRAIT_TYPE_WEAPON_INTRICATE] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_WEAPON_INTRICATE),
        [ITEM_TRAIT_TYPE_WEAPON_NIRNHONED] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_WEAPON_NIRNHONED),
        [ITEM_TRAIT_TYPE_WEAPON_ORNATE] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_WEAPON_ORNATE),
        [ITEM_TRAIT_TYPE_WEAPON_POWERED] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_WEAPON_POWERED),
        [ITEM_TRAIT_TYPE_WEAPON_PRECISE] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_WEAPON_PRECISE),
        [ITEM_TRAIT_TYPE_WEAPON_SHARPENED] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_WEAPON_SHARPENED),
        [ITEM_TRAIT_TYPE_WEAPON_TRAINING] = GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_WEAPON_TRAINING),
    }
    traitTypesShifterBox:AddEntriesToLeftList(weaponTraitData, false, ITEMFILTERTYPE_WEAPONS)
--    traitTypesShifterBox:AddEntryToLeftList(ITEM_TRAIT_TYPE_NONE, GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_NONE))
    return traitTypesShifterBox
end

local function _setButtonTextures(control, textureTemplate)
    control:SetNormalTexture(textureTemplate:format("up"))
    control:SetPressedTexture(textureTemplate:format("down"))
    control:SetMouseOverTexture(textureTemplate:format("over"))
    control:SetDisabledTexture(textureTemplate:format("disabled"))
end

local function _onQualityEntryMoved(_, key, _, _, isDestListLeftList)
    local numKey = tonumber(key)
    if isDestListLeftList then
        -- moved to left - remove from list
        PAHF.removeValueFromIndexedTable(_selectedQualities, numKey)
        if #_selectedQualities == 0 then _selectedQualities = nil end
    else
        -- moved to right - add to list
        if _selectedQualities == nil then _selectedQualities = {} end
        table.insert(_selectedQualities, numKey)
    end
    _updateRuleSummary()
end

local function _onTraitEntryMoved(_, key, _, _, isDestListLeftList)
    local numKey = tonumber(key)
    if isDestListLeftList then
        -- moved to left - remove from list
        PAHF.removeValueFromIndexedTable(_selectedTraits, numKey)
        if #_selectedTraits == 0 then _selectedTraits = nil end
    else
        -- moved to right - add to list
        if _selectedTraits == nil then _selectedTraits = {} end
        table.insert(_selectedTraits, numKey)
    end
    _updateRuleSummary()
end

local function _onItemTypeEntryMoved(_, key, _, _, isDestListLeftList)
    local numKey = tonumber(key)
    if isDestListLeftList then
        -- moved to left - remove from list
        PAHF.removeValueFromIndexedTable(_selectedItemTypes, numKey)
        if #_selectedItemTypes == 0 then _selectedItemTypes = nil end
    else
        -- moved to right - add to list
        if _selectedItemTypes == nil then _selectedItemTypes = {} end
        table.insert(_selectedItemTypes, numKey)
    end
    _updateRuleSummary()
end


-- ---------------------------------------------------------------------------------------------------------------------

local function deletePABCustomAdvancedRule()

    -- TODO: add code

end

local function initPABAddCustomAdvancedRuleUIDialog()
    if not _initDone then
       _initDone = true

        -- Get the ShifterBox Library
        PA.LibShifterBox = PA.LibShifterBox or LibShifterBox

        local headerControl = window:GetNamedChild("Header")
        headerControl:SetText("Add new advanced rule") -- TODO: extract

        -- initialize the ItemGroup dropdown
        local itemGroupLabelControl = window:GetNamedChild("ItemGroupLabel")
        itemGroupLabelControl:SetText("Item Group") -- TODO: extract
        local itemGroupDropdownControl = window:GetNamedChild("ItemGroupDropdown")
        itemGroupDropdownControl.m_comboBox:AddItem(DropdownRefs.itemGroupPleaseSelect)
        itemGroupDropdownControl.m_comboBox:AddItem(DropdownRefs.itemGroupWeapons)
        itemGroupDropdownControl.m_comboBox:AddItem(DropdownRefs.itemGroupArmor)
        itemGroupDropdownControl.m_comboBox:AddItem(DropdownRefs.itemGroupJewelry)
        -- define the default entry
        function itemGroupDropdownControl:SelectDefault()
            itemGroupDropdownControl.m_comboBox:SelectItem(DropdownRefs.itemGroupPleaseSelect)
        end

        -- initialize the Quality shifterBox
        local itemQualityLabelControl = window:GetNamedChild("ItemQualityLabel")
        itemQualityLabelControl:SetText("Item Qualities") -- TODO: extract
        _itemQualitiesShifterBox = _createAndReturnItemQualitiesShifterBox()
        _itemQualitiesShifterBox:SetAnchor(TOPLEFT, itemQualityLabelControl, BOTTOMLEFT, 40, -5)
        _itemQualitiesShifterBox:SetDimensions(340, 200)
        _itemQualitiesShifterBox:RegisterCallback(PA.LibShifterBox.EVENT_ENTRY_MOVED, _onQualityEntryMoved)

        -- initialize the ItemType dropdown
        local itemTypeLabelControl = window:GetNamedChild("ItemTypeLabel")
        itemTypeLabelControl:SetText("Item Types") -- TODO: extract
        _itemTypesShifterBox = _createAndReturnItemTypesShifterBox()
        _itemTypesShifterBox:SetAnchor(TOPLEFT, itemTypeLabelControl, BOTTOMLEFT, 40, -5)
        _itemTypesShifterBox:SetDimensions(340, 200)
        _itemTypesShifterBox:RegisterCallback(PA.LibShifterBox.EVENT_ENTRY_MOVED, _onItemTypeEntryMoved)

        -- initialize the Level Range / Champion Point Range
        local itemLevelLabelControl = window:GetNamedChild("ItemLevelLabel")
        itemLevelLabelControl:SetText("Level / Champion Point Range") -- TODO: extract
        local itemLevelFromEdit = window:GetNamedChild("ItemLevelFromBg"):GetNamedChild("Edit")
        local itemLevelFromButton = window:GetNamedChild("ItemLevelFromButton")
        local itemLevelToEdit = window:GetNamedChild("ItemLevelToBg"):GetNamedChild("Edit")
        local itemLevelToButton = window:GetNamedChild("ItemLevelToButton")

        -- set default values
        itemLevelFromEdit:SetText("1")
        itemLevelToEdit:SetText("160")

        -- set editbox onfocuslost handlers
        itemLevelFromEdit:SetHandler("OnFocusLost", function(self)
            local value = tonumber(self:GetText())
            if type(value) == "number" then
                if value < 1 then
                    self:SetText("1")
                elseif value > 50 and _selectedLevelFromType == LEVEL_NORMAL then
                    self:SetText("50")
                    if _selectedLevelToType == LEVEL_NORMAL then itemLevelToEdit:SetText("50") end
                elseif value > 160 then
                    self:SetText("160")
                    if _selectedLevelToType == LEVEL_CHAMPION then itemLevelToEdit:SetText("160") end
                else
                    -- value is in valid range - check if it clashes other value
                    local otherValue = tonumber(itemLevelToEdit:GetText())
                    if type(otherValue) == "number" then
                        if _selectedLevelFromType == _selectedLevelToType and value > otherValue then
                            itemLevelToEdit:SetText(value)
                        end
                    end
                end
                -- then update the ruleSummary
                _updateRuleSummary()
            end
        end)
        itemLevelToEdit:SetHandler("OnFocusLost", function(self)
            local value = tonumber(self:GetText())
            if type(value) == "number" then
                if value < 1 then
                    self:SetText("1")
                    if _selectedLevelFromType == _selectedLevelToType then itemLevelFromEdit:SetText("1") end
                elseif value > 50 and _selectedLevelToType == LEVEL_NORMAL then
                    self:SetText("50")
                elseif value > 160 then
                    self:SetText("160")
                else
                    -- value is in valid range - check if it clashes other value
                    local otherValue = tonumber(itemLevelFromEdit:GetText())
                    if type(otherValue) == "number" then
                        if _selectedLevelFromType == _selectedLevelToType and otherValue > value then
                            itemLevelFromEdit:SetText(value)
                        end
                    end
                end
                -- then update the ruleSummary
                _updateRuleSummary()
            end
        end)

        -- set button onclick handlers
        itemLevelFromButton:SetHandler("OnClicked", function(self)
            -- first change the current button
            if _selectedLevelFromType == LEVEL_NORMAL then
                -- switch FROM to CHAMPION
                _selectedLevelFromType = LEVEL_CHAMPION
                _setButtonTextures(self, "/esoui/art/lfg/lfg_championdungeon_%s.dds")
                itemLevelFromEdit:SetText("1")

                -- check if other is NOT champion
                if _selectedLevelToType ~= LEVEL_CHAMPION then
                    _selectedLevelToType = LEVEL_CHAMPION
                    _setButtonTextures(itemLevelToButton, "/esoui/art/lfg/lfg_championdungeon_%s.dds")
                    itemLevelToEdit:SetText("1")
                end
            else
                -- switch FROM to NORMAL
                _selectedLevelFromType = LEVEL_NORMAL
                _setButtonTextures(self, "/esoui/art/lfg/lfg_normaldungeon_%s.dds")
                itemLevelFromEdit:SetText("50")
            end
            -- then update the ruleSummary
            _updateRuleSummary()
        end)
        itemLevelToButton:SetHandler("OnClicked", function(self)
            if _selectedLevelToType == LEVEL_NORMAL then
                _selectedLevelToType = LEVEL_CHAMPION
                _setButtonTextures(self, "/esoui/art/lfg/lfg_championdungeon_%s.dds")
                itemLevelToEdit:SetText("1")
            else
                _selectedLevelToType = LEVEL_NORMAL
                _setButtonTextures(self, "/esoui/art/lfg/lfg_normaldungeon_%s.dds")
                itemLevelToEdit:SetText("50")

                -- check if other is NOT normal
                if _selectedLevelFromType ~= LEVEL_NORMAL then
                    _selectedLevelFromType = LEVEL_NORMAL
                    _setButtonTextures(itemLevelFromButton, "/esoui/art/lfg/lfg_normaldungeon_%s.dds")
                    itemLevelFromEdit:SetText("50")
                end
            end
            -- then update the ruleSummary
            _updateRuleSummary()
        end)

        -- initialize the Set dropdown
        local itemSetLabelControl = window:GetNamedChild("ItemSetLabel")
        itemSetLabelControl:SetText("Set Items") -- TODO: extract
        local itemSetDropdownControl = window:GetNamedChild("ItemSetDropdown")
        itemSetDropdownControl.m_comboBox:AddItem(DropdownRefs.setBoth)
        itemSetDropdownControl.m_comboBox:AddItem(DropdownRefs.setYes)
        itemSetDropdownControl.m_comboBox:AddItem(DropdownRefs.setNo)
        -- define the default entry
        function itemSetDropdownControl:SelectDefault()
            itemSetDropdownControl.m_comboBox:SelectItem(DropdownRefs.setBoth)
        end

        -- initialize the Crafted dropdown
        local itemCraftedLabelControl = window:GetNamedChild("ItemCraftedLabel")
        itemCraftedLabelControl:SetText("Crafted") -- TODO: extract
        local itemCraftedDropdownControl = window:GetNamedChild("ItemCraftedDropdown")
        itemCraftedDropdownControl.m_comboBox:AddItem(DropdownRefs.craftedBoth)
        itemCraftedDropdownControl.m_comboBox:AddItem(DropdownRefs.craftedYes)
        itemCraftedDropdownControl.m_comboBox:AddItem(DropdownRefs.craftedNo)
        -- define the default entry
        function itemCraftedDropdownControl:SelectDefault()
            itemCraftedDropdownControl.m_comboBox:SelectItem(DropdownRefs.craftedBoth)
        end

        -- initialize the ItemTrait dropdown
        local itemCrafterLabelControl = window:GetNamedChild("ItemTraitLabel")
        itemCrafterLabelControl:SetText("Item Traits") -- TODO: extract
        local itemTraitDropdownControl = window:GetNamedChild("ItemTraitDropdown")
        itemTraitDropdownControl.m_comboBox:AddItem(DropdownRefs.traitBoth)
        itemTraitDropdownControl.m_comboBox:AddItem(DropdownRefs.traitKnown)
        itemTraitDropdownControl.m_comboBox:AddItem(DropdownRefs.traitUnknown)
        itemTraitDropdownControl.m_comboBox:AddItem(DropdownRefs.traitSelected)
        -- define the default entry
        function itemTraitDropdownControl:SelectDefault()
            itemTraitDropdownControl.m_comboBox:SelectItem(DropdownRefs.traitBoth)
        end

        -- initialize the TraitType shifterBox
        local itemTraitTypeLabelControl = window:GetNamedChild("ItemTraitTypeLabel")
        itemTraitTypeLabelControl:SetText("Trait Types") -- TODO: extract
        _traitTypesShifterBox = _createAndReturnTraitTypesShifterBox()
        _traitTypesShifterBox:SetAnchor(TOPLEFT, itemTraitTypeLabelControl, BOTTOMLEFT, 40, -5)
        _traitTypesShifterBox:SetDimensions(340, 200)
        _traitTypesShifterBox:RegisterCallback(PA.LibShifterBox.EVENT_ENTRY_MOVED, _onTraitEntryMoved)

        -- initialize the RuleSummary
        local ruleSummaryLabelControl = window:GetNamedChild("RuleSummaryLabel")
        ruleSummaryLabelControl:SetText("Rule Summary") -- TODO: extract
        local ruleSummaryTextControl = window:GetNamedChild("RuleSummaryText")
        local customFont = string.format("$(%s)|$(KB_%s)|%s", "MEDIUM_FONT", 14, "soft-shadow-thin")
        ruleSummaryTextControl:SetFont(customFont)
    end
end

local function showPABAddCustomAdvancedRuleUIDialog()
    -- init ItemGroup dropdown
    local itemGroupDropdownControl = window:GetNamedChild("ItemGroupDropdown")
    itemGroupDropdownControl:SelectDefault()
    -- init Set dropdown
    local itemSetDropdownControl = window:GetNamedChild("ItemSetDropdown")
    itemSetDropdownControl:SelectDefault()
    -- init Crafted dropdown
    local itemCraftedDropdownControl = window:GetNamedChild("ItemCraftedDropdown")
    itemCraftedDropdownControl:SelectDefault()
    -- init ItemTrait dropdown
    local itemTraitDropdownControl = window:GetNamedChild("ItemTraitDropdown")
    itemTraitDropdownControl:SelectDefault()

    _selectedLevelFromType = LEVEL_NORMAL
    _selectedLevelToType = LEVEL_CHAMPION

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

PA.GET = _getRuleSummary