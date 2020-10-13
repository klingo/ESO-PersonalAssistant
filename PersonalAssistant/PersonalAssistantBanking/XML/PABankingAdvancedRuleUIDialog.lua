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

local ITEM_SEPARATOR = ","
local SETTING_SEPARATOR = "/"
local GROUP_SEPARATOR = "\\"

-- selected values on the UI
local _loadedRuleId
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

local _selectedQualitiesCount
local _notSelectedQualitiesCount
local _selectedItemTypesCount
local _notSelectedItemTypesCount
local _selectedTraitsCount
local _notSelectedTraitsCount

-- shifterBox references
local _itemQualitiesShifterBox
local _itemTypesShifterBox
local _traitTypesShifterBox

-- others
local _twoHandedPrefix = table.concat({GetString("SI_WEAPONCONFIGTYPE", WEAPON_CONFIG_TYPE_TWO_HANDED), " "})

-- init setting
local _initDone = false
local _loadingInProgress = false

-- ---------------------------------------------------------------------------------------------------------------------

local function _getLocalizedItemTypes(itemTypes)
    local localizedItemTypes = {}
    for _, value in ipairs(itemTypes) do
        local itemTypeConfig = PAHF.split(value, "_", 2)
        local itemFilterType = tonumber(itemTypeConfig[1])
        local itemType = tonumber(itemTypeConfig[2])
        local itemTypeString
        if itemFilterType == ITEMFILTERTYPE_ARMOR then
            itemTypeString = GetString("SI_ARMORTYPE", itemType)
        elseif itemFilterType == ITEMFILTERTYPE_WEAPONS then
            itemTypeString = GetString("SI_WEAPONTYPE", itemType)
            if itemType == WEAPONTYPE_TWO_HANDED_AXE or itemType == WEAPONTYPE_TWO_HANDED_HAMMER or itemType == WEAPONTYPE_TWO_HANDED_SWORD then
                itemTypeString = _twoHandedPrefix..itemTypeString
            end
        elseif itemFilterType == ITEMFILTERTYPE_JEWELRY then
            itemTypeString = GetString("SI_EQUIPTYPE", itemType)
        end
        table.insert(localizedItemTypes, itemTypeString)
    end
    return localizedItemTypes
end

local function _getLocalizedQualities(qualities, isRawText)
    local localizedQualities = {}
    for _, value in ipairs(qualities) do
        local quality =  tonumber(value)
        if isRawText then
            table.insert(localizedQualities, GetString("SI_ITEMQUALITY", quality))
        else
            table.insert(localizedQualities, GetItemQualityColor(quality):Colorize(GetString("SI_ITEMQUALITY", quality)))
        end
    end
    return localizedQualities
end

local function _getLocalizedTraitTypes(traitTypes)
    local localizedTraitTypes = {}
    for _, value in ipairs(traitTypes) do
        local traitType =  tonumber(value)
        table.insert(localizedTraitTypes, GetString("SI_ITEMTRAITTYPE", traitType))
    end
    return localizedTraitTypes
end

local function _updateLocalRuleValues()
    local function _updateItemType()
        local selectedItemTypes = _itemTypesShifterBox:GetRightListEntries()
        local notSelectedItemTypes = _itemTypesShifterBox:GetLeftListEntries()
        _selectedItemTypesCount = 0
        _notSelectedItemTypesCount = 0
        _selectedItemTypes = nil
        for _ in pairs(notSelectedItemTypes) do _notSelectedItemTypesCount = _notSelectedItemTypesCount + 1 end
        for key, value in PAHF.orderedPairs(selectedItemTypes) do
            _selectedItemTypesCount = _selectedItemTypesCount + 1
            if _selectedItemTypes == nil then
                _selectedItemTypes = key
            else
                _selectedItemTypes = table.concat({_selectedItemTypes, ITEM_SEPARATOR, key})
            end
        end
    end

    local function _updateQuality()
        local selectedQualities = _itemQualitiesShifterBox:GetRightListEntries()
        local notSelectedQualities = _itemQualitiesShifterBox:GetLeftListEntries()
        _selectedQualitiesCount = 0
        _notSelectedQualitiesCount = 0
        _selectedQualities = nil
        for _ in pairs(notSelectedQualities) do _notSelectedQualitiesCount = _notSelectedQualitiesCount + 1 end
        for key, value in PAHF.orderedPairs(selectedQualities) do
            _selectedQualitiesCount = _selectedQualitiesCount + 1
            if _selectedQualities == nil then
                _selectedQualities = key
            else
                _selectedQualities = table.concat({_selectedQualities, ITEM_SEPARATOR, key})
            end
        end
    end

    local function _updateTraits()
        local selectedTraitTypes = _traitTypesShifterBox:GetRightListEntries()
        local notSelectedTraitTypes = _traitTypesShifterBox:GetLeftListEntries()
        _selectedTraitsCount = 0
        _notSelectedTraitsCount = 0
        _selectedTraits = nil
        for _ in pairs(notSelectedTraitTypes) do _notSelectedTraitsCount = _notSelectedTraitsCount + 1 end
        for key, value in PAHF.orderedPairs(selectedTraitTypes) do
            _selectedTraitsCount = _selectedTraitsCount + 1
            if _selectedTraits == nil then
                _selectedTraits = key
            else
                _selectedTraits = table.concat({_selectedTraits, ITEM_SEPARATOR, key})
            end
        end
    end

    local function _updateLevel()
        local itemLevelFromEdit = window:GetNamedChild("ItemLevelFromBg"):GetNamedChild("Edit")
        local itemLevelToEdit = window:GetNamedChild("ItemLevelToBg"):GetNamedChild("Edit")
        _selectedLevelFrom = tonumber(itemLevelFromEdit:GetText())
        _selectedLevelTo = tonumber(itemLevelToEdit:GetText())
    end

    _updateItemType()
    _updateQuality()
    _updateTraits()
    _updateLevel()
end

local function _convertLocalSettingsToRawSettings()
    return table.concat({
        -- GROUP: 1
        _selectedItemGroup, GROUP_SEPARATOR,
        -- GROUP: 2
        _selectedQualities, SETTING_SEPARATOR,
        _selectedQualitiesCount, SETTING_SEPARATOR,
        _notSelectedQualitiesCount, GROUP_SEPARATOR,
        -- GROUP: 3
        _selectedLevelFromType, SETTING_SEPARATOR,
        _selectedLevelFrom, GROUP_SEPARATOR,
        -- GROUP: 4
        _selectedLevelToType, SETTING_SEPARATOR,
        _selectedLevelTo, GROUP_SEPARATOR,
        -- GROUP: 5
        _selectedSetSetting, GROUP_SEPARATOR,
        -- GROUP: 6
        _selectedCraftedSetting, GROUP_SEPARATOR,
        -- GROUP: 7
        _selectedItemTypes, SETTING_SEPARATOR,
        _selectedItemTypesCount, SETTING_SEPARATOR,
        _notSelectedItemTypesCount, GROUP_SEPARATOR,
        -- GROUP: 8
        _selectedTraitSetting, SETTING_SEPARATOR,
        _selectedTraits, SETTING_SEPARATOR,
        _selectedTraitsCount, SETTING_SEPARATOR,
        _notSelectedTraitsCount
    })
end

local function _convertRawSettingsToLocalSettings(ruleSettingsRaw, returnAdditionalData)
    -- the the splitted main groups
    local mainGroupsSplit = PAHF.split(ruleSettingsRaw, GROUP_SEPARATOR, 8)

    -- GROUP: 1
    local itemGroup = mainGroupsSplit[1]

    if itemGroup == nil or itemGroup == "" then
        return itemGroup
    else
        -- GROUP: 1
        itemGroup = tonumber(itemGroup)
        -- GROUP: 2
        local qualitiesSplit = PAHF.split(mainGroupsSplit[2], SETTING_SEPARATOR, 3)
        local selectedQualities = PAHF.split(qualitiesSplit[1], ITEM_SEPARATOR)
        for key, value in pairs(selectedQualities) do
            selectedQualities[key] = tonumber(value) -- make sure its a number and not a string
        end
        local selectedQualitiesCount = tonumber(qualitiesSplit[2])
        local notSelectedQualitiesCount = tonumber(qualitiesSplit[3])
        -- GROUP: 3
        local levelFromSplit = PAHF.split(mainGroupsSplit[3], SETTING_SEPARATOR, 2)
        local levelFromType = tonumber(levelFromSplit[1])
        local levelFrom = tonumber(levelFromSplit[2])
        -- GROUP: 4
        local levelToSplit = PAHF.split(mainGroupsSplit[4], SETTING_SEPARATOR, 2)
        local levelToType = tonumber(levelToSplit[1])
        local levelTo = tonumber(levelToSplit[2])
        -- GROUP: 5
        local setSetting = tonumber(mainGroupsSplit[5])
        -- GROUP: 6
        local craftedSetting = tonumber(mainGroupsSplit[6])
        -- GROUP: 7
        local itemTypesSplit = PAHF.split(mainGroupsSplit[7], SETTING_SEPARATOR, 3)
        local selectedItemTypes = PAHF.split(itemTypesSplit[1], ITEM_SEPARATOR)
        local selectedItemTypesCount = tonumber(itemTypesSplit[2])
        local notSelectedItemTypesCount = tonumber(itemTypesSplit[3])
        -- GROUP: 8
        local traitTypesSplit = PAHF.split(mainGroupsSplit[8], SETTING_SEPARATOR, 4)
        local traitSetting = tonumber(traitTypesSplit[1])
        local selectedTraitTypes = PAHF.split(traitTypesSplit[2], ITEM_SEPARATOR)
        for key, value in pairs(selectedTraitTypes) do
            selectedTraitTypes[key] = tonumber(value) -- make sure its a number and not a string
        end
        local selectedTraitTypesCount = tonumber(traitTypesSplit[3])
        local notSelectedTraitTypesCount = tonumber(traitTypesSplit[4])

        if returnAdditionalData then
            return itemGroup, selectedQualities, selectedQualitiesCount, notSelectedQualitiesCount, levelFromType,
            levelFrom, levelToType, levelTo, setSetting, craftedSetting, selectedItemTypes, selectedItemTypesCount,
            notSelectedItemTypesCount, traitSetting, selectedTraitTypes, selectedTraitTypesCount, notSelectedTraitTypesCount
        else
            return itemGroup, selectedQualities, levelFromType, levelFrom, levelToType, levelTo, setSetting,
            craftedSetting, selectedItemTypes, traitSetting, selectedTraitTypes
        end
    end
end

local function getRuleSummaryFromRawSettings(ruleSettingsRaw, isRawText)
    local function _getItemTypeText(itemGroup, itemTypes, selectedCount, unselectedCount)
        local itemGroupString = zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", itemGroup))
        if selectedCount == 0 or unselectedCount == 0 then
            return table.concat({"[", itemGroupString, "]"})
        else
            local itemTypesString = _getLocalizedItemTypes(itemTypes)
            return table.concat({"[", PAHF.getCommaSeparatedOrList(itemTypesString), " ", itemGroupString, "]"})
        end
    end

    local function _getQualityText(qualities, selectedCount, unselectedCount)
        if selectedCount == 0 or unselectedCount == 0 then
            return nil
        else
            local qualitiesString = _getLocalizedQualities(qualities, isRawText)
            return table.concat({"of [", PAHF.getCommaSeparatedOrList(qualitiesString), "] quality"})  -- TODO: extract
        end
    end

    local function _getLevelText(levelFrom, levelFromType, levelTo, levelToType)
        local function _getSimpleLevelText(levelType, level)
            if levelType == LEVEL_NORMAL then
                return table.concat({"Level ", level})  -- TODO: extract
            else
                return table.concat({"CP ", level})  -- TODO: extract
            end
        end
        if levelFrom == levelTo and levelFromType == levelToType then
            -- from and to are the same
            return table.concat({"and [", _getSimpleLevelText(levelFromType, levelFrom), "]"})  -- TODO: extract
        elseif levelFrom == 1 and levelFromType == LEVEL_NORMAL and levelTo == 160 and levelToType == LEVEL_CHAMPION then
            -- from and to cover the full level-range
            return nil
        else
            local fromText = _getSimpleLevelText(levelFromType, levelFrom)
            local toText = _getSimpleLevelText(levelToType, levelTo)
            return table.concat({"between [", fromText, "] and [", toText, "]"})  -- TODO: extract
        end
    end

    local function _getSetText(setSetting)
        if setSetting == SET_IS_SET then
            return "[Set]"  -- TODO: extract
        elseif setSetting == SET_NO_SET then
            return "[Non-Set]"  -- TODO: extract
        end
        return nil
    end

    local function _getCraftedText(craftedSetting)
        if craftedSetting == CRAFTED_IS_CRAFTED then
            return "[Crafted]"  -- TODO: extract
        elseif craftedSetting == CRAFTED_NOT_CRAFTED then
            return "[Non-Crafted]"  -- TODO: extract
        end
        return nil
    end

    local function _getTraitText(traitSetting, traitTypes, selectedCount, unselectedCount)
        if traitSetting == TRAIT_KNOWN then
            return "with [known] traits" -- TODO: extract
        elseif traitSetting == TRAIT_UNKNOWN then
            return "with [unknown] traits"  -- TODO: extract
        elseif traitSetting == TRAIT_SELECTED then
            if selectedCount == 0 then
                return "with [no] traits"  -- TODO: extract
            elseif unselectedCount == 0 then
                return nil
            else
                local traitTypesString = _getLocalizedTraitTypes(traitTypes)
                return table.concat({"with [", PAHF.getCommaSeparatedOrList(traitTypesString), "] trait"})  -- TODO: extract
            end
        end
    end

    local itemGroup, selectedQualities, selectedQualitiesCount, notSelectedQualitiesCount, levelFromType,
        levelFrom, levelToType, levelTo, setSetting, craftedSetting, selectedItemTypes, selectedItemTypesCount,
        notSelectedItemTypesCount, traitSetting, selectedTraitTypes, selectedTraitTypesCount,
        notSelectedTraitTypesCount = _convertRawSettingsToLocalSettings(ruleSettingsRaw, true)

    if itemGroup == nil or itemGroup == "" then
        return "Please select an [Item Group] first..."   -- TODO: extract
    else
        local function _appendText(master, addedText)
            if addedText ~= nil then
                return table.concat({master, " ", addedText})
            end
            return master
        end

        -- get the combined texts
        local craftedText = _getCraftedText(craftedSetting)
        local setText = _getSetText(setSetting)
        local itemTypeText = _getItemTypeText(itemGroup, selectedItemTypes, selectedItemTypesCount, notSelectedItemTypesCount)
        local qualityText = _getQualityText(selectedQualities, selectedQualitiesCount, notSelectedQualitiesCount)
        local levelText = _getLevelText(levelFrom, levelFromType, levelTo, levelToType)
        local traitText = _getTraitText(traitSetting, selectedTraitTypes, selectedTraitTypesCount, notSelectedTraitTypesCount)
        local summaryText = "Any"   -- TODO: extract
        summaryText = _appendText(summaryText, craftedText)
        summaryText = _appendText(summaryText, setText)
        summaryText = _appendText(summaryText, itemTypeText)
        summaryText = _appendText(summaryText, qualityText)
        summaryText = _appendText(summaryText, levelText)
        summaryText = _appendText(summaryText, traitText)
        return summaryText
    end



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

local function _updateRuleSummary(ruleSettingsRaw)
    if ruleSettingsRaw == nil then
        _updateLocalRuleValues()
        ruleSettingsRaw = _convertLocalSettingsToRawSettings()
    end
    local ruleSummary = getRuleSummaryFromRawSettings(ruleSettingsRaw)
    local ruleSummaryTextControl = window:GetNamedChild("RuleSummaryText")
    ruleSummaryTextControl:SetText(ruleSummary)
end

local function _resetShifterBoxAndResetToLeft(shifterBox, selectCategory, enabled, keysToRightList)
    if selectCategory then shifterBox:ShowOnlyCategory(selectCategory) end
    shifterBox:MoveAllEntriesToLeftList()
    if keysToRightList ~= nil then
        d(keysToRightList)
        if istable(keysToRightList) then
            shifterBox:MoveEntriesToRightList(keysToRightList)
        else
            shifterBox:MoveEntryToRightList(keysToRightList)
        end
    end
    shifterBox:SetEnabled(enabled)
end

local function _setAllFieldsEnabled(enabled)
    _resetShifterBoxAndResetToLeft(_itemQualitiesShifterBox, nil, enabled)
    _resetShifterBoxAndResetToLeft(_itemTypesShifterBox, _selectedItemGroup, enabled)
    _resetShifterBoxAndResetToLeft(_traitTypesShifterBox, _selectedItemGroup, enabled and _selectedTraitSetting == TRAIT_SELECTED)

    local itemLevelFromButtonControl = window:GetNamedChild("ItemLevelFromButton")
    itemLevelFromButtonControl:SetEnabled(enabled)
    local itemLevelFromEditControl = window:GetNamedChild("ItemLevelFromBg"):GetNamedChild("Edit")
    itemLevelFromEditControl:SetEditEnabled(enabled)
    local itemLevelToButtonControl = window:GetNamedChild("ItemLevelToButton")
    itemLevelToButtonControl:SetEnabled(enabled)
    local itemLevelToEditControl = window:GetNamedChild("ItemLevelToBg"):GetNamedChild("Edit")
    itemLevelToEditControl:SetEditEnabled(enabled)
    local itemSetDropdownControl = window:GetNamedChild("ItemSetDropdown")
    itemSetDropdownControl.m_comboBox:SetEnabled(enabled)
    local itemCraftedDropdownControl = window:GetNamedChild("ItemCraftedDropdown")
    itemCraftedDropdownControl.m_comboBox:SetEnabled(enabled)
    local itemTraitDropdownControl = window:GetNamedChild("ItemTraitDropdown")
    itemTraitDropdownControl.m_comboBox:SetEnabled(enabled)
    local addRuleButtonControl = window:GetNamedChild("AddRuleButton")
    addRuleButtonControl:SetEnabled(enabled)
end

-- TODO: to be improved! use callback values to simplify the entries
local DropdownRefs = {
    itemGroupPleaseSelect = ZO_ComboBox:CreateItemEntry("<Please Select>", function(_, entryText, entry) -- TODO: extract
        _selectedItemGroup = nil
        _setAllFieldsEnabled(false)
        _updateRuleSummary()
    end ),
    itemGroupWeapons = ZO_ComboBox:CreateItemEntry(zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS)), function()
        _selectedItemGroup = ITEMFILTERTYPE_WEAPONS
        _setAllFieldsEnabled(true)
        _updateRuleSummary()
    end ),
    itemGroupArmor = ZO_ComboBox:CreateItemEntry(zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR)), function()
        _selectedItemGroup = ITEMFILTERTYPE_ARMOR
        _setAllFieldsEnabled(true)
        _updateRuleSummary()
    end ),
    itemGroupJewelry = ZO_ComboBox:CreateItemEntry(zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY)), function()
        _selectedItemGroup = ITEMFILTERTYPE_JEWELRY
        _setAllFieldsEnabled(true)
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
        [ITEM_FUNCTIONAL_QUALITY_TRASH] = GetItemQualityColor(ITEM_FUNCTIONAL_QUALITY_TRASH):Colorize(GetString("SI_ITEMQUALITY", ITEM_FUNCTIONAL_QUALITY_TRASH)),
        [ITEM_FUNCTIONAL_QUALITY_NORMAL] = GetItemQualityColor(ITEM_FUNCTIONAL_QUALITY_NORMAL):Colorize(GetString("SI_ITEMQUALITY", ITEM_FUNCTIONAL_QUALITY_NORMAL)),
        [ITEM_FUNCTIONAL_QUALITY_MAGIC] = GetItemQualityColor(ITEM_FUNCTIONAL_QUALITY_MAGIC):Colorize(GetString("SI_ITEMQUALITY", ITEM_FUNCTIONAL_QUALITY_MAGIC)),
        [ITEM_FUNCTIONAL_QUALITY_ARCANE] = GetItemQualityColor(ITEM_FUNCTIONAL_QUALITY_ARCANE):Colorize(GetString("SI_ITEMQUALITY", ITEM_FUNCTIONAL_QUALITY_ARCANE)),
        [ITEM_FUNCTIONAL_QUALITY_ARTIFACT] = GetItemQualityColor(ITEM_FUNCTIONAL_QUALITY_ARTIFACT):Colorize(GetString("SI_ITEMQUALITY", ITEM_FUNCTIONAL_QUALITY_ARTIFACT)),
        [ITEM_FUNCTIONAL_QUALITY_LEGENDARY] = GetItemQualityColor(ITEM_FUNCTIONAL_QUALITY_LEGENDARY):Colorize(GetString("SI_ITEMQUALITY", ITEM_FUNCTIONAL_QUALITY_LEGENDARY)),
    }
    itemQualitiesShifterBox:AddEntriesToLeftList(listData)
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
        [ITEMFILTERTYPE_ARMOR.."_"..ARMORTYPE_LIGHT] = GetString("SI_ARMORTYPE", ARMORTYPE_LIGHT),
        [ITEMFILTERTYPE_ARMOR.."_"..ARMORTYPE_MEDIUM] = GetString("SI_ARMORTYPE", ARMORTYPE_MEDIUM),
        [ITEMFILTERTYPE_ARMOR.."_"..ARMORTYPE_HEAVY] = GetString("SI_ARMORTYPE", ARMORTYPE_HEAVY),
    }
    itemTypesShifterBox:AddEntriesToLeftList(armorTypeData, false, ITEMFILTERTYPE_ARMOR)
    local weaponTypeData = {
        [ITEMFILTERTYPE_WEAPONS.."_"..WEAPONTYPE_AXE] = GetString("SI_WEAPONTYPE", WEAPONTYPE_AXE),
        [ITEMFILTERTYPE_WEAPONS.."_"..WEAPONTYPE_BOW] = GetString("SI_WEAPONTYPE", WEAPONTYPE_BOW),
        [ITEMFILTERTYPE_WEAPONS.."_"..WEAPONTYPE_DAGGER] = GetString("SI_WEAPONTYPE", WEAPONTYPE_DAGGER),
        [ITEMFILTERTYPE_WEAPONS.."_"..WEAPONTYPE_FIRE_STAFF] = GetString("SI_WEAPONTYPE", WEAPONTYPE_FIRE_STAFF),
        [ITEMFILTERTYPE_WEAPONS.."_"..WEAPONTYPE_FROST_STAFF] = GetString("SI_WEAPONTYPE", WEAPONTYPE_FROST_STAFF),
        [ITEMFILTERTYPE_WEAPONS.."_"..WEAPONTYPE_HAMMER] = GetString("SI_WEAPONTYPE", WEAPONTYPE_HAMMER),
        [ITEMFILTERTYPE_WEAPONS.."_"..WEAPONTYPE_HEALING_STAFF] = GetString("SI_WEAPONTYPE", WEAPONTYPE_HEALING_STAFF),
        [ITEMFILTERTYPE_WEAPONS.."_"..WEAPONTYPE_LIGHTNING_STAFF] = GetString("SI_WEAPONTYPE", WEAPONTYPE_LIGHTNING_STAFF),
        [ITEMFILTERTYPE_WEAPONS.."_"..WEAPONTYPE_SHIELD] = GetString("SI_WEAPONTYPE", WEAPONTYPE_SHIELD),
        [ITEMFILTERTYPE_WEAPONS.."_"..WEAPONTYPE_SWORD] = GetString("SI_WEAPONTYPE", WEAPONTYPE_SWORD),
        [ITEMFILTERTYPE_WEAPONS.."_"..WEAPONTYPE_TWO_HANDED_AXE] = _twoHandedPrefix..GetString("SI_WEAPONTYPE", WEAPONTYPE_TWO_HANDED_AXE),
        [ITEMFILTERTYPE_WEAPONS.."_"..WEAPONTYPE_TWO_HANDED_HAMMER] = _twoHandedPrefix..GetString("SI_WEAPONTYPE", WEAPONTYPE_TWO_HANDED_HAMMER),
        [ITEMFILTERTYPE_WEAPONS.."_"..WEAPONTYPE_TWO_HANDED_SWORD] = _twoHandedPrefix..GetString("SI_WEAPONTYPE", WEAPONTYPE_TWO_HANDED_SWORD),
    }
    itemTypesShifterBox:AddEntriesToLeftList(weaponTypeData, false, ITEMFILTERTYPE_WEAPONS)
    local jewelryTypeData = {
        [ITEMFILTERTYPE_JEWELRY.."_"..EQUIP_TYPE_NECK] = GetString("SI_EQUIPTYPE", EQUIP_TYPE_NECK),
        [ITEMFILTERTYPE_JEWELRY.."_"..EQUIP_TYPE_RING] = GetString("SI_EQUIPTYPE", EQUIP_TYPE_RING),
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

local function _setButtonTextures(control, buttonType)
    local textureTemplate
    if buttonType == LEVEL_NORMAL then
        textureTemplate = "/esoui/art/lfg/lfg_normaldungeon_%s.dds"
    elseif buttonType == LEVEL_CHAMPION then
        textureTemplate = "/esoui/art/lfg/lfg_championdungeon_%s.dds"
    end
    control:SetNormalTexture(textureTemplate:format("up"))
    control:SetPressedTexture(textureTemplate:format("down"))
    control:SetMouseOverTexture(textureTemplate:format("over"))
    control:SetDisabledTexture(textureTemplate:format("disabled"))
end

-- ---------------------------------------------------------------------------------------------------------------------

local function _addCustomAdvancedRuleClicked(isUpdate)
    local PABAdvancedRules = PA.Banking.SavedVars.AdvancedRules.Rules
    -- only add the entry if it is an UPDTE case, or if it does not exist yet
    if isUpdate or not PAHF.isKeyInTable(PABAdvancedRules, _loadedRuleId) then
        _updateLocalRuleValues() -- in case there were no changes done
        local ruleSettingsRaw = _convertLocalSettingsToRawSettings()
        if isUpdate then
            df("SAVE: %s", ruleSettingsRaw)
            PABAdvancedRules[_loadedRuleId].ruleRaw = ruleSettingsRaw
            -- TODO: chat message
            df(table.concat({"Rule number %d has been ", PAC.COLOR.ORANGE:Colorize("updated"), "!"}), _loadedRuleId)
        else
            table.insert(PABAdvancedRules, {
                ruleRaw = ruleSettingsRaw,
                ruleEnabled = true,
            })
            -- TODO: chat message
            df(table.concat({"Rule number %d has been ", PAC.COLOR.ORANGE:Colorize("added"), "!"}), #PABAdvancedRules)
        end
        window:SetHidden(true)

        -- refresh the list (if it was initialized)
        if PA.BankingAdvancedRulesList then PA.BankingAdvancedRulesList:Refresh() end
    else
        PAB.debugln("ERROR; PAB advanced rule already existing and this was NOT an update")
    end
end

local function initPABAddCustomAdvancedRuleUIDialog()
    if not _initDone then
       _initDone = true

        -- Get the ShifterBox Library
        PA.LibShifterBox = PA.LibShifterBox or LibShifterBox

        -- initialize the ItemGroup dropdown
        local itemGroupLabelControl = window:GetNamedChild("ItemGroupLabel")
        itemGroupLabelControl:SetText("Item Group") -- TODO: extract
        local itemGroupDropdownControl = window:GetNamedChild("ItemGroupDropdown")
        itemGroupDropdownControl.m_comboBox:AddItem(DropdownRefs.itemGroupPleaseSelect)
        itemGroupDropdownControl.m_comboBox:AddItem(DropdownRefs.itemGroupWeapons)
        itemGroupDropdownControl.m_comboBox:AddItem(DropdownRefs.itemGroupArmor)
        itemGroupDropdownControl.m_comboBox:AddItem(DropdownRefs.itemGroupJewelry)
        -- define the default entry
        function itemGroupDropdownControl:SelectDefault(ignoreCallback)
            itemGroupDropdownControl.m_comboBox:SelectItem(DropdownRefs.itemGroupPleaseSelect, ignoreCallback)
        end
        function itemGroupDropdownControl:SelectByKey(itemGroup)
            if itemGroup == ITEMFILTERTYPE_WEAPONS then
                itemGroupDropdownControl.m_comboBox:SelectItem(DropdownRefs.itemGroupWeapons, true)
            elseif itemGroup == ITEMFILTERTYPE_ARMOR then
                itemGroupDropdownControl.m_comboBox:SelectItem(DropdownRefs.itemGroupArmor, true)
            elseif itemGroup == ITEMFILTERTYPE_JEWELRY then
                itemGroupDropdownControl.m_comboBox:SelectItem(DropdownRefs.itemGroupJewelry, true)
            else
                self:SelectDefault(true)
            end
        end

        -- initialize the Quality shifterBox
        local itemQualityLabelControl = window:GetNamedChild("ItemQualityLabel")
        itemQualityLabelControl:SetText("Item Qualities") -- TODO: extract
        _itemQualitiesShifterBox = _createAndReturnItemQualitiesShifterBox()
        _itemQualitiesShifterBox:SetAnchor(TOPLEFT, itemQualityLabelControl, BOTTOMLEFT, 40, -5)
        _itemQualitiesShifterBox:SetDimensions(340, 200)
        _itemQualitiesShifterBox:RegisterCallback(PA.LibShifterBox.EVENT_ENTRY_MOVED, function() if not _loadingInProgress then _updateRuleSummary() end end)

        -- initialize the ItemType dropdown
        local itemTypeLabelControl = window:GetNamedChild("ItemTypeLabel")
        itemTypeLabelControl:SetText("Item Types") -- TODO: extract
        _itemTypesShifterBox = _createAndReturnItemTypesShifterBox()
        _itemTypesShifterBox:SetAnchor(TOPLEFT, itemTypeLabelControl, BOTTOMLEFT, 40, -5)
        _itemTypesShifterBox:SetDimensions(340, 200)
        _itemTypesShifterBox:RegisterCallback(PA.LibShifterBox.EVENT_ENTRY_MOVED, function() if not _loadingInProgress then _updateRuleSummary() end end)

        -- initialize the Level Range / Champion Point Range
        local itemLevelLabelControl = window:GetNamedChild("ItemLevelLabel")
        itemLevelLabelControl:SetText("Level / Champion Point Range") -- TODO: extract
        local itemLevelFromEdit = window:GetNamedChild("ItemLevelFromBg"):GetNamedChild("Edit")
        local itemLevelFromButton = window:GetNamedChild("ItemLevelFromButton")
        local itemLevelToEdit = window:GetNamedChild("ItemLevelToBg"):GetNamedChild("Edit")
        local itemLevelToButton = window:GetNamedChild("ItemLevelToButton")

        -- set editbox onfocuslost handlers
        itemLevelFromEdit:SetHandler("OnFocusLost", function(self)
            local value = tonumber(self:GetText())
            if type(value) == "number" then
                if value < 1 then
                    self:SetText(1)
                elseif value > 50 and _selectedLevelFromType == LEVEL_NORMAL then
                    self:SetText(50)
                    if _selectedLevelToType == LEVEL_NORMAL then itemLevelToEdit:SetText(50) end
                elseif value > 160 then
                    self:SetText(160)
                    if _selectedLevelToType == LEVEL_CHAMPION then itemLevelToEdit:SetText(160) end
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
                    self:SetText(1)
                    if _selectedLevelFromType == _selectedLevelToType then
                        itemLevelFromEdit:SetText(1)
                    end
                elseif value > 50 and _selectedLevelToType == LEVEL_NORMAL then
                    self:SetText(50)
                elseif value > 160 then
                    self:SetText(160)
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
                _setButtonTextures(self, _selectedLevelFromType)
                itemLevelFromEdit:SetText(1)

                -- check if other is NOT champion
                if _selectedLevelToType ~= LEVEL_CHAMPION then
                    _selectedLevelToType = LEVEL_CHAMPION
                    _setButtonTextures(itemLevelToButton, _selectedLevelToType)
                    itemLevelToEdit:SetText(1)
                end
            else
                -- switch FROM to NORMAL
                _selectedLevelFromType = LEVEL_NORMAL
                _setButtonTextures(self, _selectedLevelFromType)
                itemLevelFromEdit:SetText(50)
            end
            -- then update the ruleSummary
            _updateRuleSummary()
        end)
        itemLevelToButton:SetHandler("OnClicked", function(self)
            if _selectedLevelToType == LEVEL_NORMAL then
                _selectedLevelToType = LEVEL_CHAMPION
                _setButtonTextures(self, _selectedLevelToType)
                itemLevelToEdit:SetText(1)
            else
                _selectedLevelToType = LEVEL_NORMAL
                _setButtonTextures(self, _selectedLevelToType)
                itemLevelToEdit:SetText(50)

                -- check if other is NOT normal
                if _selectedLevelFromType ~= LEVEL_NORMAL then
                    _selectedLevelFromType = LEVEL_NORMAL
                    _setButtonTextures(itemLevelFromButton, _selectedLevelFromType)
                    itemLevelFromEdit:SetText(50)
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
        function itemSetDropdownControl:SelectByKey(setSetting)
            if setSetting == SET_IS_SET then
                itemSetDropdownControl.m_comboBox:SelectItem(DropdownRefs.setYes, true)
            elseif setSetting == SET_NO_SET then
                itemSetDropdownControl.m_comboBox:SelectItem(DropdownRefs.setNo, true)
            else
                self:SelectDefault(true)
            end
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
        function itemCraftedDropdownControl:SelectByKey(craftedSetting)
            if craftedSetting == CRAFTED_IS_CRAFTED then
                itemCraftedDropdownControl.m_comboBox:SelectItem(DropdownRefs.craftedYes, true)
            elseif craftedSetting == CRAFTED_NOT_CRAFTED then
                itemCraftedDropdownControl.m_comboBox:SelectItem(DropdownRefs.craftedNo, true)
            else
                self:SelectDefault(true)
            end
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
        function itemTraitDropdownControl:SelectByKey(traitSetting)
            if traitSetting == TRAIT_KNOWN then
                itemTraitDropdownControl.m_comboBox:SelectItem(DropdownRefs.traitKnown, true)
            elseif traitSetting == TRAIT_UNKNOWN then
                itemTraitDropdownControl.m_comboBox:SelectItem(DropdownRefs.traitUnknown, true)
            elseif traitSetting == TRAIT_SELECTED then
                itemTraitDropdownControl.m_comboBox:SelectItem(DropdownRefs.traitSelected, true)
            else
                self:SelectDefault(true)
            end
        end

        -- initialize the TraitType shifterBox
        local itemTraitTypeLabelControl = window:GetNamedChild("ItemTraitTypeLabel")
        itemTraitTypeLabelControl:SetText("Trait Types") -- TODO: extract
        _traitTypesShifterBox = _createAndReturnTraitTypesShifterBox()
        _traitTypesShifterBox:SetAnchor(TOPLEFT, itemTraitTypeLabelControl, BOTTOMLEFT, 40, -5)
        _traitTypesShifterBox:SetDimensions(340, 200)
        _traitTypesShifterBox:RegisterCallback(PA.LibShifterBox.EVENT_ENTRY_MOVED, function() if not _loadingInProgress then _updateRuleSummary() end end)

        -- initialize the RuleSummary
        local ruleSummaryLabelControl = window:GetNamedChild("RuleSummaryLabel")
        ruleSummaryLabelControl:SetText("Rule Summary") -- TODO: extract
        local ruleSummaryTextControl = window:GetNamedChild("RuleSummaryText")
        local customFont = string.format("$(%s)|$(KB_%s)|%s", "MEDIUM_FONT", 14, "soft-shadow-thin")
        ruleSummaryTextControl:SetFont(customFont)

        -- initialize the localized buttons
        local addRuleButtonControl = window:GetNamedChild("AddRuleButton")
        local addRuleLabelControl = addRuleButtonControl:GetNamedChild("AddRuleLabel")
        addRuleLabelControl:SetText(GetString(SI_PA_SUBMENU_PAB_ADD_RULE_BUTTON))
        addRuleLabelControl:SetDimensions(addRuleLabelControl:GetTextDimensions())
        addRuleButtonControl:SetHandler("OnClicked", function()
            _addCustomAdvancedRuleClicked(false)
        end)

        local updateRuleButtonControl = window:GetNamedChild("UpdateRuleButton")
        local updateRuleLabelControl = updateRuleButtonControl:GetNamedChild("UpdateRuleLabel")
        updateRuleLabelControl:SetText(GetString(SI_PA_SUBMENU_PAB_UPDATE_RULE_BUTTON))
        updateRuleLabelControl:SetDimensions(updateRuleLabelControl:GetTextDimensions())
        updateRuleButtonControl:SetHandler("OnClicked", function()
            _addCustomAdvancedRuleClicked(true)
        end)

        local deleteRuleButtonControl = window:GetNamedChild("DeleteRuleButton")
        local deleteRuleLabelControl = deleteRuleButtonControl:GetNamedChild("DeleteRuleLabel")
        deleteRuleLabelControl:SetText(GetString(SI_PA_SUBMENU_PAB_DELETE_RULE_BUTTON))
        deleteRuleLabelControl:SetDimensions(deleteRuleLabelControl:GetTextDimensions())
        deleteRuleButtonControl:SetHandler("OnClicked", function()
            deletePABCustomAdvancedRule(_loadedRuleId)
        end)
    end
end

local function showPABAddCustomAdvancedRuleUIDialog(existingRuleId)
    _loadingInProgress = true
    local headerControl = window:GetNamedChild("Header")
    local itemGroupDropdownControl = window:GetNamedChild("ItemGroupDropdown")
    local itemLevelFromEdit = window:GetNamedChild("ItemLevelFromBg"):GetNamedChild("Edit")
    local itemLevelFromButton = window:GetNamedChild("ItemLevelFromButton")
    local itemLevelToEdit = window:GetNamedChild("ItemLevelToBg"):GetNamedChild("Edit")
    local itemLevelToButton = window:GetNamedChild("ItemLevelToButton")
    local itemSetDropdownControl = window:GetNamedChild("ItemSetDropdown")
    local itemCraftedDropdownControl = window:GetNamedChild("ItemCraftedDropdown")
    local itemTraitDropdownControl = window:GetNamedChild("ItemTraitDropdown")
    local addRuleButtonControl = window:GetNamedChild("AddRuleButton")
    local updateRuleButtonControl = window:GetNamedChild("UpdateRuleButton")
    local deleteRuleButtonControl = window:GetNamedChild("DeleteRuleButton")

    _loadedRuleId = existingRuleId -- can be nil

    if existingRuleId then
        -- init with existing values
        headerControl:SetText(table.concat({PAC.COLORED_TEXTS.PAB, "Modify advanced rule"})) -- TODO: extract
        -- get rule settings
        local PABAdvancedRules = PA.SavedVars.Banking[PA.activeProfile].AdvancedRules.Rules
        local ruleSettingRaw = PABAdvancedRules[existingRuleId].ruleRaw

        df("LOAD: %s", ruleSettingRaw)

        _selectedItemGroup, _selectedQualities, _selectedQualitiesCount, _notSelectedQualitiesCount, _selectedLevelFromType,
        _selectedLevelFrom, _selectedLevelToType, _selectedLevelTo, _selectedSetSetting, _selectedCraftedSetting,
        _selectedItemTypes, _selectedItemTypesCount, _notSelectedItemTypesCount, _selectedTraitSetting, _selectedTraits,
        _selectedTraitsCount, _notSelectedTraitsCount = _convertRawSettingsToLocalSettings(ruleSettingRaw, true)

        -- load values on UI
        itemGroupDropdownControl:SelectByKey(_selectedItemGroup)
        d("111")
        _resetShifterBoxAndResetToLeft(_itemQualitiesShifterBox, nil, true, _selectedQualities)
        itemLevelFromEdit:SetText(_selectedLevelFrom)
        _setButtonTextures(itemLevelFromButton, _selectedLevelFromType)
        itemLevelToEdit:SetText(_selectedLevelTo)
        _setButtonTextures(itemLevelToButton, _selectedLevelToType)
        itemSetDropdownControl:SelectByKey(_selectedSetSetting)
        itemCraftedDropdownControl:SelectByKey(_selectedCraftedSetting)
        d("222")
        _resetShifterBoxAndResetToLeft(_itemTypesShifterBox, _selectedItemGroup, true, _selectedItemTypes)
        itemTraitDropdownControl:SelectByKey(_selectedTraitSetting)
        d("333")
        _resetShifterBoxAndResetToLeft(_traitTypesShifterBox, _selectedItemGroup, _selectedTraitSetting == TRAIT_SELECTED, _selectedTraits)

        _updateRuleSummary(ruleSettingRaw)

        -- show UPDATE/DELETE buttons, hide ADD button
        addRuleButtonControl:SetHidden(true)
        updateRuleButtonControl:SetHidden(false)
        deleteRuleButtonControl:SetHidden(false)
    else
        -- reset to default values
        headerControl:SetText(table.concat({PAC.COLORED_TEXTS.PAB, "Add new advanced rule"})) -- TODO: extract
        itemGroupDropdownControl:SelectDefault()
        itemSetDropdownControl:SelectDefault()
        itemCraftedDropdownControl:SelectDefault()
        itemTraitDropdownControl:SelectDefault()
        itemLevelFromEdit:SetText(1)
        _selectedLevelFromType = LEVEL_NORMAL
        _setButtonTextures(itemLevelFromButton, _selectedLevelFromType)
        itemLevelToEdit:SetText(160)
        _selectedLevelToType = LEVEL_CHAMPION
        _setButtonTextures(itemLevelToButton, _selectedLevelToType)

        -- show ADD button, hide UPDATE/DELETE buttons
        addRuleButtonControl:SetHidden(false)
        updateRuleButtonControl:SetHidden(true)
        deleteRuleButtonControl:SetHidden(true)
    end

    -- finally, show window
    window:SetHidden(false)
    _loadingInProgress = false
end

local function deletePABCustomAdvancedRule(ruleId)
    local PABAdvancedRules = PA.Banking.SavedVars.AdvancedRules.Rules
    if PAHF.isKeyInTable(PABAdvancedRules, ruleId) then
        -- is in table, delete rule
        table.remove(PABAdvancedRules, ruleId)
        -- TODO: chat message
        df(table.concat({"Rule number %d has been ", PAC.COLOR.ORANGE:Colorize("deleted"), "!"}), ruleId)
        window:SetHidden(true)

        -- refresh the list (if it was initialized)
        if PA.BankingAdvancedRulesList then PA.BankingAdvancedRulesList:Refresh() end
    else
        PAB.debugln("ERROR; PAB adavanced rule not existing, cannot be deleted")
    end
end

local function enablePABCustomAdvancedRule(existingRuleId)
    local PABAdvancedRules = PA.Banking.SavedVars.AdvancedRules.Rules
    if PAHF.isKeyInTable(PABAdvancedRules, existingRuleId) then
        -- is in table, enable rule
        PABAdvancedRules[existingRuleId].ruleEnabled = true
        -- TODO: chat message
        df(table.concat({"Rule number %d has been ", PAC.COLOR.ORANGE:Colorize("enabled"), "!"}), existingRuleId)

        -- refresh the list (if it was initialized)
        if PA.BankingAdvancedRulesList then PA.BankingAdvancedRulesList:Refresh() end
    else
        PAB.debugln("ERROR; PAB advanced rule not existing, cannot be enabled")
    end
end

local function disablePABCustomAdvancedRule(existingRuleId)
    local PABAdvancedRules = PA.Banking.SavedVars.AdvancedRules.Rules
    if PAHF.isKeyInTable(PABAdvancedRules, existingRuleId) then
        -- is in table, disable rule
        PABAdvancedRules[existingRuleId].ruleEnabled = false
        -- TODO: chat message
        df(table.concat({"Rule number %d has been ", PAC.COLOR.ORANGE:Colorize("disabled"), "!"}), existingRuleId)

        -- refresh the list (if it was initialized)
        if PA.BankingAdvancedRulesList then PA.BankingAdvancedRulesList:Refresh() end
    else
        PAB.debugln("ERROR; PAB advanced rule not existing, cannot be disabled")
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.CustomDialogs = PA.CustomDialogs or {}
PA.CustomDialogs.getPABRuleSummaryFromRawSettings = getRuleSummaryFromRawSettings
PA.CustomDialogs.initPABAddCustomAdvancedRuleUIDialog = initPABAddCustomAdvancedRuleUIDialog
PA.CustomDialogs.showPABAddCustomAdvancedRuleUIDialog = showPABAddCustomAdvancedRuleUIDialog
PA.CustomDialogs.deletePABCustomAdvancedRule = deletePABCustomAdvancedRule
PA.CustomDialogs.enablePABCustomAdvancedRule = enablePABCustomAdvancedRule
PA.CustomDialogs.disablePABCustomAdvancedRule = disablePABCustomAdvancedRule

-- TODO: Edit reset top dropdown does not disable save button
-- TODO: Edit save without change does not work