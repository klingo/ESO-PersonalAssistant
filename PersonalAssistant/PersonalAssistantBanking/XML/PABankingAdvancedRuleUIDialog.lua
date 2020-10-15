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
local _ruleCache = {}

-- shifterBox references
local _itemQualitiesShifterBox
local _itemTypesShifterBox
local _traitTypesShifterBox

-- others
local TWO_HANDED_PREFIX = table.concat({GetString("SI_WEAPONCONFIGTYPE", WEAPON_CONFIG_TYPE_TWO_HANDED), " "})

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
                itemTypeString = TWO_HANDED_PREFIX..itemTypeString
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

-- ---------------------------------------------------------------------------------------------------------------------

local function _updateItemTypeRuleCache()
    if not _loadingInProgress then
        local selectedItemTypes = _itemTypesShifterBox:GetRightListEntries()
        local notSelectedItemTypes = _itemTypesShifterBox:GetLeftListEntries()
        _ruleCache.itemTypesCount = 0
        _ruleCache.itemTypesNotCount = 0
        _ruleCache.itemTypes = {}
        for _ in pairs(notSelectedItemTypes) do _ruleCache.itemTypesNotCount = _ruleCache.itemTypesNotCount + 1 end
        for key, value in PAHF.orderedPairs(selectedItemTypes) do
            _ruleCache.itemTypesCount = _ruleCache.itemTypesCount + 1
            _ruleCache.itemTypes[_ruleCache.itemTypesCount] = key
        end
    end
end

local function _updateQualitiesRuleCache()
    if not _loadingInProgress then
        local selectedQualities = _itemQualitiesShifterBox:GetRightListEntries()
        local notSelectedQualities = _itemQualitiesShifterBox:GetLeftListEntries()
        _ruleCache.qualitiesCount = 0
        _ruleCache.qualitiesNotCount = 0
        _ruleCache.qualities = {}
        for _ in pairs(notSelectedQualities) do _ruleCache.qualitiesNotCount = _ruleCache.qualitiesNotCount + 1 end
        for key, value in PAHF.orderedPairs(selectedQualities) do
            _ruleCache.qualitiesCount = _ruleCache.qualitiesCount + 1
            _ruleCache.qualities[_ruleCache.qualitiesCount] = key
        end
    end
end

local function _updateTraitsRuleCache()
    if not _loadingInProgress then
        local selectedTraitTypes = _traitTypesShifterBox:GetRightListEntries()
        local notSelectedTraitTypes = _traitTypesShifterBox:GetLeftListEntries()
        _ruleCache.traitTypesCount = 0
        _ruleCache.traitTypesNotCount = 0
        _ruleCache.traitTypes = {}
        for _ in pairs(notSelectedTraitTypes) do _ruleCache.traitTypesNotCount = _ruleCache.traitTypesNotCount + 1 end
        for key, value in PAHF.orderedPairs(selectedTraitTypes) do
            _ruleCache.traitTypesCount = _ruleCache.traitTypesCount + 1
            _ruleCache.traitTypes[_ruleCache.traitTypesCount] = key
        end
    end
end

local function _updateLevelRuleCache()
    if not _loadingInProgress then
        local itemLevelFromEdit = window:GetNamedChild("ItemLevelFromBg"):GetNamedChild("Edit")
        local itemLevelToEdit = window:GetNamedChild("ItemLevelToBg"):GetNamedChild("Edit")
        _ruleCache.levelFrom = tonumber(itemLevelFromEdit:GetText())
        _ruleCache.levelTo = tonumber(itemLevelToEdit:GetText())
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

local function _convertLocalSettingsToRawSettings()
    -- GROUP: 1
    local group1 = table.concat({
        _ruleCache.itemAction, SETTING_SEPARATOR,
        _ruleCache.itemGroup, GROUP_SEPARATOR
    })
    -- GROUP: 2
    local group2 = table.concat({
        table.concat(_ruleCache.qualities, ITEM_SEPARATOR), SETTING_SEPARATOR,
        _ruleCache.qualitiesCount, SETTING_SEPARATOR,
        _ruleCache.qualitiesNotCount, GROUP_SEPARATOR,
    })
    -- GROUP: 3
    local group3 = table.concat({
        _ruleCache.levelFromType, SETTING_SEPARATOR,
        _ruleCache.levelFrom, GROUP_SEPARATOR,
    })
    -- GROUP: 4
    local group4 = table.concat({
        _ruleCache.levelToType, SETTING_SEPARATOR,
        _ruleCache.levelTo, GROUP_SEPARATOR,
    })
    -- GROUP: 5
    local group5 = table.concat({
        _ruleCache.setSetting, GROUP_SEPARATOR,
    })
    -- GROUP: 6
    local group6 = table.concat({
        _ruleCache.craftedSetting, GROUP_SEPARATOR,
    })
    -- GROUP: 7
    local group7 = table.concat({
        table.concat(_ruleCache.itemTypes, ITEM_SEPARATOR), SETTING_SEPARATOR,
        _ruleCache.itemTypesCount, SETTING_SEPARATOR,
        _ruleCache.itemTypesNotCount, GROUP_SEPARATOR,
    })
    -- GROUP: 8
    local group8 = table.concat({
        _ruleCache.traitSetting, SETTING_SEPARATOR,
        table.concat(_ruleCache.traitTypes, ITEM_SEPARATOR), SETTING_SEPARATOR,
        _ruleCache.traitTypesCount, SETTING_SEPARATOR,
        _ruleCache.traitTypesNotCount
    })
    return table.concat({group1, group2, group3, group4, group5, group6, group7, group8})
end

local function _convertRawSettingsToLocalSettings(ruleSettingsRaw)
    -- the the splitted main groups
    local mainGroupsSplit = PAHF.split(ruleSettingsRaw, GROUP_SEPARATOR, 8)

    -- GROUP:  1    (Item Action / Item Group)
    local itemSplit = PAHF.split(mainGroupsSplit[1], SETTING_SEPARATOR, 2)
    local itemAction = tonumber(itemSplit[1])
    local itemGroup = tonumber(itemSplit[2])

    if itemGroup == nil or itemGroup == "" or itemAction == nil or itemAction == "" then
        return
    else
        -- GROUP: 2     (Item Qualities)
        local qualitiesSplit = PAHF.split(mainGroupsSplit[2], SETTING_SEPARATOR, 3)
        local selectedQualities = PAHF.split(qualitiesSplit[1], ITEM_SEPARATOR)
        for key, value in pairs(selectedQualities) do
            selectedQualities[key] = tonumber(value) -- make sure its a number and not a string
        end
        local selectedQualitiesCount = tonumber(qualitiesSplit[2])
        local notSelectedQualitiesCount = tonumber(qualitiesSplit[3])
        -- GROUP: 3     (Level / Champion Point Range)
        local levelFromSplit = PAHF.split(mainGroupsSplit[3], SETTING_SEPARATOR, 2)
        local levelFromType = tonumber(levelFromSplit[1])
        local levelFrom = tonumber(levelFromSplit[2])
        -- GROUP: 4     (Level / Champion Point Range)
        local levelToSplit = PAHF.split(mainGroupsSplit[4], SETTING_SEPARATOR, 2)
        local levelToType = tonumber(levelToSplit[1])
        local levelTo = tonumber(levelToSplit[2])
        -- GROUP: 5     (Set Items)
        local setSetting = tonumber(mainGroupsSplit[5])
        -- GROUP: 6     (Crafted)
        local craftedSetting = tonumber(mainGroupsSplit[6])
        -- GROUP: 7     (Item Types)
        local itemTypesSplit = PAHF.split(mainGroupsSplit[7], SETTING_SEPARATOR, 3)
        local selectedItemTypes = PAHF.split(itemTypesSplit[1], ITEM_SEPARATOR)
        local selectedItemTypesCount = tonumber(itemTypesSplit[2])
        local notSelectedItemTypesCount = tonumber(itemTypesSplit[3])
        -- GROUP: 8     (Item Traits / Trait Types)
        local traitTypesSplit = PAHF.split(mainGroupsSplit[8], SETTING_SEPARATOR, 4)
        local traitSetting = tonumber(traitTypesSplit[1])
        local selectedTraitTypes = PAHF.split(traitTypesSplit[2], ITEM_SEPARATOR)
        for key, value in pairs(selectedTraitTypes) do
            selectedTraitTypes[key] = tonumber(value) -- make sure its a number and not a string
        end
        local selectedTraitTypesCount = tonumber(traitTypesSplit[3])
        local notSelectedTraitTypesCount = tonumber(traitTypesSplit[4])

        _ruleCache.itemAction = itemAction
        _ruleCache.itemGroup = itemGroup
        _ruleCache.qualities = selectedQualities
        _ruleCache.qualitiesCount = selectedQualitiesCount
        _ruleCache.qualitiesNotCount = notSelectedQualitiesCount
        _ruleCache.levelFromType = levelFromType
        _ruleCache.levelFrom = levelFrom
        _ruleCache.levelToType = levelToType
        _ruleCache.levelTo = levelTo
        _ruleCache.setSetting = setSetting
        _ruleCache.craftedSetting = craftedSetting
        _ruleCache.itemTypes = selectedItemTypes
        _ruleCache.itemTypesCount = selectedItemTypesCount
        _ruleCache.itemTypesNotCount = notSelectedItemTypesCount
        _ruleCache.traitSetting = traitSetting
        _ruleCache.traitTypes = selectedTraitTypes
        _ruleCache.traitTypesCount = selectedTraitTypesCount
        _ruleCache.traitTypesNotCount = notSelectedTraitTypesCount
    end
end

local function _resetRuleCache()
    _ruleCache = {
        ruleId = nil,
        itemAction = BAG_BANK,
        itemGroup = nil,
        levelFrom = 1, -- init value
        levelFromType = LEVEL_NORMAL, -- init value
        levelTo = 160, -- init value
        levelToType = LEVEL_CHAMPION, -- init value
        setSetting = SET_ANY,
        craftedSetting = CRAFTED_ANY,
        qualities = {},
        qualitiesCount = 0,
        qualitiesNotCount = nil,
        traitSetting = TRAIT_ANY,
        traitTypes = {},
        traitTypesCount = 0,
        traitTypesNotCount = nil,
        itemTypes = {},
        itemTypesCount = 0,
        itemTypesNotCount = nil,
    }
end

-- ---------------------------------------------------------------------------------------------------------------------

local function getRuleSummaryFromLocalSettings(includeRawSummary)
    local function _getRuleSummaryWithItemAction(itemAction, ruleSummary)
        if itemAction == BAG_BANK then
            return PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_ADVANCED_RULE_SUMMARY_DEPOSIT, ruleSummary)
        elseif itemAction == BAG_BACKPACK then
            return PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_ADVANCED_RULE_SUMMARY_WITHDRAW, ruleSummary)
        end
        return ruleSummary
    end

    local function _getItemTypeText(itemGroup, itemTypes, selectedCount, unselectedCount)
        local itemGroupString = zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", itemGroup))
        if selectedCount == 0 or unselectedCount == 0 then
            return table.concat({"[", itemGroupString, "]"})    -- TODO: to be extracted?
        else
            local itemTypesString = _getLocalizedItemTypes(itemTypes)
            return table.concat({"[", PAHF.getCommaSeparatedOrList(itemTypesString), " ", itemGroupString, "]"})    -- TODO: to be extracted?
        end
    end

    local function _getQualityText(qualities, selectedCount, unselectedCount)
        if selectedCount == 0 or unselectedCount == 0 then
            return nil
        else
            local qualitiesString = _getLocalizedQualities(qualities)
            return PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_ADVANCED_RULE_OF_QUALITY, PAHF.getCommaSeparatedOrList(qualitiesString))
        end
    end
    local function _getQualityTextRaw(qualities, selectedCount, unselectedCount)
        if selectedCount == 0 or unselectedCount == 0 then
            return nil
        else
            local qualitiesString = _getLocalizedQualities(qualities, true)
            return PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_ADVANCED_RULE_OF_QUALITY, PAHF.getCommaSeparatedOrList(qualitiesString))
        end
    end

    local function _getLevelText(levelFrom, levelFromType, levelTo, levelToType)
        local function _getSimpleLevelText(levelType, level)
            if levelType == LEVEL_NORMAL then
                return table.concat({GetString(SI_PA_DIALOG_BANKING_ADVANCED_RULE_LEVEL), " ", level})
            else
                return table.concat({GetString(SI_PA_DIALOG_BANKING_ADVANCED_RULE_CP), " ", level})
            end
        end
        if levelFrom == levelTo and levelFromType == levelToType then
            -- from and to are the same
            return PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_ADVANCED_RULE_AND, _getSimpleLevelText(levelFromType, levelFrom))
        elseif levelFrom == 1 and levelFromType == LEVEL_NORMAL and levelTo == 160 and levelToType == LEVEL_CHAMPION then
            -- from and to cover the full level-range
            return nil
        else
            local fromText = _getSimpleLevelText(levelFromType, levelFrom)
            local toText = _getSimpleLevelText(levelToType, levelTo)
            return PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_ADVANCED_RULE_AND, fromText, toText)
        end
    end

    local function _getSetText(setSetting)
        if setSetting == SET_IS_SET then
            return GetString(SI_PA_DIALOG_BANKING_ADVANCED_RULE_SET)
        elseif setSetting == SET_NO_SET then
            return GetString(SI_PA_DIALOG_BANKING_ADVANCED_RULE_NO_SET)
        end
        return nil
    end

    local function _getCraftedText(craftedSetting)
        if craftedSetting == CRAFTED_IS_CRAFTED then
            return GetString(SI_PA_DIALOG_BANKING_ADVANCED_RULE_CRAFTED)
        elseif craftedSetting == CRAFTED_NOT_CRAFTED then
            return GetString(SI_PA_DIALOG_BANKING_ADVANCED_RULE_NO_CRAFTED)
        end
        return nil
    end

    local function _getTraitText(traitSetting, traitTypes, selectedCount, unselectedCount)
        if traitSetting == TRAIT_KNOWN then
            return GetString(SI_PA_DIALOG_BANKING_ADVANCED_RULE_KNOWN_TRAITS)
        elseif traitSetting == TRAIT_UNKNOWN then
            return GetString(SI_PA_DIALOG_BANKING_ADVANCED_RULE_UNKNOWN_TRAITS)
        elseif traitSetting == TRAIT_SELECTED then
            if selectedCount == 0 then
                return GetString(SI_PA_DIALOG_BANKING_ADVANCED_RULE_NO_TRAITS)
            elseif unselectedCount == 0 then
                return nil
            else
                local traitTypesString = _getLocalizedTraitTypes(traitTypes)
                return PAHF.getFormattedKey(SI_PA_DIALOG_BANKING_ADVANCED_RULE_SELECTED_TRAITS, PAHF.getCommaSeparatedOrList(traitTypesString))
            end
        end
    end

    if _ruleCache.itemGroup == nil or _ruleCache.itemGroup == "" then
        return GetString(SI_PA_DIALOG_BANKING_ADVANCED_ITEM_GROUP_PLEASE_SELECT)
    else
        local function _appendText(master, addedText)
            if addedText ~= nil then
                return table.concat({master, " ", addedText})
            end
            return master
        end
        local function _appendAllTexts(starterText, craftedText, setText, itemTypeText, qualityText, levelText, traitText)
            local summaryText = starterText
            summaryText = _appendText(summaryText, craftedText)
            summaryText = _appendText(summaryText, setText)
            summaryText = _appendText(summaryText, itemTypeText)
            summaryText = _appendText(summaryText, qualityText)
            summaryText = _appendText(summaryText, levelText)
            summaryText = _appendText(summaryText, traitText)
            return summaryText
        end

        -- get the combined texts
        local craftedText = _getCraftedText(_ruleCache.craftedSetting)
        local setText = _getSetText(_ruleCache.setSetting)
        local itemTypeText = _getItemTypeText(_ruleCache.itemGroup, _ruleCache.itemTypes, _ruleCache.itemTypesCount, _ruleCache.itemTypesNotCount)
        local qualityText = _getQualityText(_ruleCache.qualities, _ruleCache.qualitiesCount, _ruleCache.qualitiesNotCount)
        local qualityTextRaw = _getQualityTextRaw(_ruleCache.qualities, _ruleCache.qualitiesCount, _ruleCache.qualitiesNotCount)
        local levelText = _getLevelText(_ruleCache.levelFrom, _ruleCache.levelFromType, _ruleCache.levelTo, _ruleCache.levelToType)
        local traitText = _getTraitText(_ruleCache.traitSetting, _ruleCache.traitTypes, _ruleCache.traitTypesCount, _ruleCache.traitTypesNotCount)

        local summaryText = _appendAllTexts(GetString(SI_PA_DIALOG_BANKING_ADVANCED_RULE_ANY), craftedText, setText, itemTypeText, qualityText, levelText, traitText)
        local summaryTextFull = _getRuleSummaryWithItemAction(_ruleCache.itemAction, summaryText)

        if includeRawSummary then
            local summaryTextRaw = _appendAllTexts(GetString(SI_PA_DIALOG_BANKING_ADVANCED_RULE_ANY), craftedText, setText, itemTypeText, qualityTextRaw, levelText, traitText)
            local summaryTextRawFull = _getRuleSummaryWithItemAction(_ruleCache.itemAction, summaryTextRaw)
            return {
                summary = summaryTextFull,
                summaryRaw = summaryTextRawFull
            }
        else
            return {
                summary = summaryTextFull
            }
        end
    end
end

local function getRuleSummaryFromRawSettings(ruleSettingsRaw, includeRawSummary)
    _resetRuleCache()
    _convertRawSettingsToLocalSettings(ruleSettingsRaw)
    return getRuleSummaryFromLocalSettings(includeRawSummary)
end

local function _updateRuleSummary()
    if not _loadingInProgress then
        local ruleSummary = getRuleSummaryFromLocalSettings()
        local ruleSummaryTextControl = window:GetNamedChild("RuleSummaryText")
        ruleSummaryTextControl:SetText(ruleSummary.summary)
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

local function _resetShifterBoxAndResetToLeft(shifterBox, selectCategory, enabled, keysToRightList)
    if selectCategory then shifterBox:ShowOnlyCategory(selectCategory) end
    shifterBox:MoveAllEntriesToLeftList()
    if istable(keysToRightList) then
        shifterBox:MoveEntriesToRightList(keysToRightList)
    elseif not keysToRightList == nil then
        shifterBox:MoveEntryToRightList(keysToRightList)
    end
    shifterBox:SetEnabled(enabled)
end

local function _setAllFieldsEnabled(enabled)
    _resetShifterBoxAndResetToLeft(_itemQualitiesShifterBox, nil, enabled)
    _resetShifterBoxAndResetToLeft(_itemTypesShifterBox, _ruleCache.itemGroup, enabled)
    _resetShifterBoxAndResetToLeft(_traitTypesShifterBox, _ruleCache.itemGroup, enabled and _ruleCache.traitSetting == TRAIT_SELECTED)

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
    local updateRuleButtonControl = window:GetNamedChild("UpdateRuleButton")
    updateRuleButtonControl:SetEnabled(enabled)
end

-- TODO: to be improved! use callback values to simplify the entries
local DropdownRefs = {
    itemActionDepositoToBank = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_BANKING_MOVE_MODE_TOBANK), function(_, entryText, entry)
        _ruleCache.itemAction = BAG_BANK
        _updateRuleSummary()
    end ),
    itemActionWithdrawToBackpack = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_BANKING_MOVE_MODE_TOBACKPACK), function(_, entryText, entry)
        _ruleCache.itemAction = BAG_BACKPACK
        _updateRuleSummary()
    end ),

    itemGroupPleaseSelect = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_DIALOG_BANKING_ADVANCED_PLEASE_SELECT), function(_, entryText, entry)
        _ruleCache.itemGroup = nil
        _setAllFieldsEnabled(false)
        _updateRuleSummary()
    end ),
    itemGroupWeapons = ZO_ComboBox:CreateItemEntry(zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS)), function()
        _ruleCache.itemGroup = ITEMFILTERTYPE_WEAPONS
        _setAllFieldsEnabled(true)
        _updateRuleSummary()
    end ),
    itemGroupArmor = ZO_ComboBox:CreateItemEntry(zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR)), function()
        _ruleCache.itemGroup = ITEMFILTERTYPE_ARMOR
        _setAllFieldsEnabled(true)
        _updateRuleSummary()
    end ),
    itemGroupJewelry = ZO_ComboBox:CreateItemEntry(zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY)), function()
        _ruleCache.itemGroup = ITEMFILTERTYPE_JEWELRY
        _setAllFieldsEnabled(true)
        _updateRuleSummary()
    end ),

    setBoth = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_DIALOG_BANKING_ADVANCED_SET_ITEMS_ANY), function()
        _ruleCache.setSetting = SET_ANY
        _updateRuleSummary()
    end ),
    setYes = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_DIALOG_BANKING_ADVANCED_SET_ITEMS_SET), function()
        _ruleCache.setSetting = SET_IS_SET
        _updateRuleSummary()
    end ),
    setNo = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_DIALOG_BANKING_ADVANCED_SET_ITEMS_NO_SET), function()
        _ruleCache.setSetting = SET_NO_SET
        _updateRuleSummary()
    end ),

    craftedBoth = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_DIALOG_BANKING_ADVANCED_CRAFTED_ITEMS_ANY), function()
        _ruleCache.craftedSetting = CRAFTED_ANY
        _updateRuleSummary()
    end ),
    craftedYes = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_DIALOG_BANKING_ADVANCED_CRAFTED_ITEMS_CRAFTED), function()
        _ruleCache.craftedSetting = CRAFTED_IS_CRAFTED
        _updateRuleSummary()
    end ),
    craftedNo = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_DIALOG_BANKING_ADVANCED_CRAFTED_ITEMS_NOT_CRAFTED), function()
        _ruleCache.craftedSetting = CRAFTED_NOT_CRAFTED
        _updateRuleSummary()
    end ),

    traitSelected = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_DIALOG_BANKING_ADVANCED_TRAIT_TYPES_SELECTED), function()
        _ruleCache.traitSetting = TRAIT_SELECTED
        _resetShifterBoxAndResetToLeft(_traitTypesShifterBox, _ruleCache.itemGroup, true)
        _updateRuleSummary()
    end ),
    traitBoth = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_DIALOG_BANKING_ADVANCED_TRAIT_TYPES_ANY), function()
        _ruleCache.traitSetting = TRAIT_ANY
        _traitTypesShifterBox:SetEnabled(false)
        _updateRuleSummary()
    end ),
    traitKnown = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_DIALOG_BANKING_ADVANCED_TRAIT_TYPES_KNOWN), function()
        _ruleCache.traitSetting = TRAIT_KNOWN
        _traitTypesShifterBox:SetEnabled(false)
        _updateRuleSummary()
    end ),
    traitUnknown = ZO_ComboBox:CreateItemEntry(GetString(SI_PA_DIALOG_BANKING_ADVANCED_TRAIT_TYPES_UNKNOWN), function()
        _ruleCache.traitSetting = TRAIT_UNKNOWN
        _traitTypesShifterBox:SetEnabled(false)
        _updateRuleSummary()
    end ),
}

local function _createAndReturnItemQualitiesShifterBox()
    local shifterBoxSettings = {
        sortBy = "key",
        leftList = {
            title = GetString(SI_PA_DIALOG_BANKING_ADVANCED_AVAILABLE),
            emptyListText = GetString(SI_PA_DIALOG_BANKING_ADVANCED_NONE),
        },
        rightList = {
            title = GetString(SI_PA_DIALOG_BANKING_ADVANCED_SELECTED),
            emptyListText = GetString(SI_PA_DIALOG_BANKING_ADVANCED_ITEM_QUALITIES_ANY),
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
    local shifterBoxSettings = {
        leftList = {
            title = GetString(SI_PA_DIALOG_BANKING_ADVANCED_AVAILABLE),
            emptyListText = GetString(SI_PA_DIALOG_BANKING_ADVANCED_NONE),
        },
        rightList = {
            title = GetString(SI_PA_DIALOG_BANKING_ADVANCED_SELECTED),
            emptyListText = GetString(SI_PA_DIALOG_BANKING_ADVANCED_ITEM_TYPES_ANY)
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
        [ITEMFILTERTYPE_WEAPONS.."_"..WEAPONTYPE_TWO_HANDED_AXE] = TWO_HANDED_PREFIX..GetString("SI_WEAPONTYPE", WEAPONTYPE_TWO_HANDED_AXE),
        [ITEMFILTERTYPE_WEAPONS.."_"..WEAPONTYPE_TWO_HANDED_HAMMER] = TWO_HANDED_PREFIX..GetString("SI_WEAPONTYPE", WEAPONTYPE_TWO_HANDED_HAMMER),
        [ITEMFILTERTYPE_WEAPONS.."_"..WEAPONTYPE_TWO_HANDED_SWORD] = TWO_HANDED_PREFIX..GetString("SI_WEAPONTYPE", WEAPONTYPE_TWO_HANDED_SWORD),
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
    local shifterBoxSettings = {
        leftList = {
            title = GetString(SI_PA_DIALOG_BANKING_ADVANCED_AVAILABLE),
            emptyListText = GetString(SI_PA_DIALOG_BANKING_ADVANCED_NONE),
        },
        rightList = {
            title = GetString(SI_PA_DIALOG_BANKING_ADVANCED_SELECTED),
            emptyListText = GetString(SI_PA_DIALOG_BANKING_ADVANCED_ITEM_TRAITS_NONE)
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
    if isUpdate or not PAHF.isKeyInTable(PABAdvancedRules, _ruleCache.ruleId) then
        local ruleSettingsRaw = _convertLocalSettingsToRawSettings()
        if isUpdate then
            df("UPDATE: %s", ruleSettingsRaw)
            PABAdvancedRules[_ruleCache.ruleId].ruleRaw = ruleSettingsRaw
            PAB.println(SI_PA_CHAT_BANKING_ADVANCED_RULES_UPDATED, _ruleCache.ruleId)
        else
            df("CREATE: %s", ruleSettingsRaw)
            table.insert(PABAdvancedRules, {
                ruleRaw = ruleSettingsRaw,
                ruleEnabled = true,
            })
            PAB.println(SI_PA_CHAT_BANKING_ADVANCED_RULES_ADDED, #PABAdvancedRules)
        end
        window:SetHidden(true)

        -- refresh the list (if it was initialized)
        if PA.BankingAdvancedRulesList then PA.BankingAdvancedRulesList:Refresh() end
    else
        PAB.debugln("ERROR; PAB advanced rule already existing and this was NOT an update")
    end
end

local function deletePABCustomAdvancedRule(ruleId)
    local PABAdvancedRules = PA.Banking.SavedVars.AdvancedRules.Rules
    if PAHF.isKeyInTable(PABAdvancedRules, ruleId) then
        -- is in table, delete rule
        table.remove(PABAdvancedRules, ruleId)
        PAB.println(SI_PA_CHAT_BANKING_ADVANCED_RULES_DELETED, ruleId)
        window:SetHidden(true)

        -- refresh the list (if it was initialized)
        if PA.BankingAdvancedRulesList then PA.BankingAdvancedRulesList:Refresh() end
    else
        PAB.debugln("ERROR; PAB adavanced rule not existing, cannot be deleted")
    end
end

local function initPABAddCustomAdvancedRuleUIDialog()
    if not _initDone then
       _initDone = true

        -- Get the ShifterBox Library
        PA.LibShifterBox = PA.LibShifterBox or LibShifterBox

        -- init the rule cache
        _resetRuleCache()

        -- initialize the ItemAction dropdown
        local itemActionLabelControl = window:GetNamedChild("ItemActionLabel")
        itemActionLabelControl:SetText(GetString(SI_PA_DIALOG_BANKING_ADVANCED_ITEM_ACTION))
        local itemActionDropdownControl = window:GetNamedChild("ItemActionDropdown")
        itemActionDropdownControl.m_comboBox:AddItem(DropdownRefs.itemActionDepositoToBank)
        itemActionDropdownControl.m_comboBox:AddItem(DropdownRefs.itemActionWithdrawToBackpack)
        -- define the default entry
        function itemActionDropdownControl:SelectDefault(ignoreCallback)
            itemActionDropdownControl.m_comboBox:SelectItem(DropdownRefs.itemActionDepositoToBank, ignoreCallback)
        end
        function itemActionDropdownControl:SelectByKey(itemAction)
            if itemAction == BAG_BANK then
                itemActionDropdownControl.m_comboBox:SelectItem(DropdownRefs.itemActionDepositoToBank, true)
            elseif itemAction == BAG_BACKPACK then
                itemActionDropdownControl.m_comboBox:SelectItem(DropdownRefs.itemActionWithdrawToBackpack, true)
            else
                self:SelectDefault(true)
            end
        end

        -- initialize the ItemGroup dropdown
        local itemGroupLabelControl = window:GetNamedChild("ItemGroupLabel")
        itemGroupLabelControl:SetText(GetString(SI_PA_DIALOG_BANKING_ADVANCED_ITEM_GROUP))
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
        itemQualityLabelControl:SetText(GetString(SI_PA_DIALOG_BANKING_ADVANCED_ITEM_QUALITIES))
        _itemQualitiesShifterBox = _createAndReturnItemQualitiesShifterBox()
        _itemQualitiesShifterBox:SetAnchor(TOPLEFT, itemQualityLabelControl, BOTTOMLEFT, 40, -5)
        _itemQualitiesShifterBox:SetDimensions(360, 200)
        _itemQualitiesShifterBox:RegisterCallback(PA.LibShifterBox.EVENT_ENTRY_MOVED, function()
            _updateQualitiesRuleCache()
            _updateRuleSummary()
        end)

        -- initialize the ItemType dropdown
        local itemTypeLabelControl = window:GetNamedChild("ItemTypeLabel")
        itemTypeLabelControl:SetText(GetString(SI_PA_DIALOG_BANKING_ADVANCED_ITEM_TYPES))
        _itemTypesShifterBox = _createAndReturnItemTypesShifterBox()
        _itemTypesShifterBox:SetAnchor(TOPLEFT, itemTypeLabelControl, BOTTOMLEFT, 40, -5)
        _itemTypesShifterBox:SetDimensions(380, 200)
        _itemTypesShifterBox:RegisterCallback(PA.LibShifterBox.EVENT_ENTRY_MOVED, function()
            _updateItemTypeRuleCache()
            _updateRuleSummary()
        end)

        -- initialize the Level Range / Champion Point Range
        local itemLevelLabelControl = window:GetNamedChild("ItemLevelLabel")
        itemLevelLabelControl:SetText(GetString(SI_PA_DIALOG_BANKING_ADVANCED_LEVEL_RANGE))
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
                elseif value > 50 and _ruleCache.levelFromType == LEVEL_NORMAL then
                    self:SetText(50)
                    if _ruleCache.levelToType == LEVEL_NORMAL then
                        itemLevelToEdit:SetText(50)
                    end
                elseif value > 160 then
                    self:SetText(160)
                    if _ruleCache.levelToType == LEVEL_CHAMPION then
                        itemLevelToEdit:SetText(160)
                    end
                else
                    -- value is in valid range - check if it clashes other value
                    local otherValue = tonumber(itemLevelToEdit:GetText())
                    if type(otherValue) == "number" then
                        if _ruleCache.levelFromType == _ruleCache.levelToType and value > otherValue then
                            itemLevelToEdit:SetText(value)
                        end
                    end
                end
                _updateLevelRuleCache()
                -- then update the ruleSummary
                _updateRuleSummary()
            end
        end)
        itemLevelToEdit:SetHandler("OnFocusLost", function(self)
            local value = tonumber(self:GetText())
            if type(value) == "number" then
                if value < 1 then
                    self:SetText(1)
                    if _ruleCache.levelFromType == _ruleCache.levelToType then
                        itemLevelFromEdit:SetText(1)
                    end
                elseif value > 50 and _ruleCache.levelToType == LEVEL_NORMAL then
                    self:SetText(50)
                elseif value > 160 then
                    self:SetText(160)
                else
                    -- value is in valid range - check if it clashes other value
                    local otherValue = tonumber(itemLevelFromEdit:GetText())
                    if type(otherValue) == "number" then
                        if _ruleCache.levelFromType == _ruleCache.levelToType and otherValue > value then
                            itemLevelFromEdit:SetText(value)
                        end
                    end
                end
                _updateLevelRuleCache()
                -- then update the ruleSummary
                _updateRuleSummary()
            end
        end)

        -- set button onclick handlers
        itemLevelFromButton:SetHandler("OnClicked", function(self)
            -- first change the current button
            if _ruleCache.levelFromType == LEVEL_NORMAL then
                -- switch FROM to CHAMPION
                _setButtonTextures(self, LEVEL_CHAMPION)
                itemLevelFromEdit:SetText(1)
                _ruleCache.levelFromType = LEVEL_CHAMPION

                -- check if other is NOT champion
                if _ruleCache.levelToType ~= LEVEL_CHAMPION then
                    _setButtonTextures(itemLevelToButton, LEVEL_CHAMPION)
                    itemLevelToEdit:SetText(1)
                    _ruleCache.levelToType = LEVEL_CHAMPION
                end
            else
                -- switch FROM to NORMAL
                _setButtonTextures(self, LEVEL_NORMAL)
                itemLevelFromEdit:SetText(50)
                _ruleCache.levelFromType = LEVEL_NORMAL
            end
            _updateLevelRuleCache()
            -- then update the ruleSummary
            _updateRuleSummary()
        end)

        itemLevelToButton:SetHandler("OnClicked", function(self)
            if _ruleCache.levelToType == LEVEL_NORMAL then
                _setButtonTextures(self, LEVEL_CHAMPION)
                itemLevelToEdit:SetText(1)
                _ruleCache.levelToType = LEVEL_CHAMPION
            else
                _setButtonTextures(self, LEVEL_NORMAL)
                itemLevelToEdit:SetText(50)
                _ruleCache.levelToType = LEVEL_NORMAL

                -- check if other is NOT normal
                if _ruleCache.levelFromType ~= LEVEL_NORMAL then
                    _setButtonTextures(itemLevelFromButton, LEVEL_NORMAL)
                    itemLevelFromEdit:SetText(50)
                    _ruleCache.levelFromType = LEVEL_NORMAL
                end
            end
            _updateLevelRuleCache()
            -- then update the ruleSummary
            _updateRuleSummary()
        end)

        -- initialize the Set dropdown
        local itemSetLabelControl = window:GetNamedChild("ItemSetLabel")
        itemSetLabelControl:SetText(GetString(SI_PA_DIALOG_BANKING_ADVANCED_SET_ITEMS))
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
        itemCraftedLabelControl:SetText(GetString(SI_PA_DIALOG_BANKING_ADVANCED_CRAFTED_ITEMS))
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
        itemCrafterLabelControl:SetText(GetString(SI_PA_DIALOG_BANKING_ADVANCED_ITEM_TRAITS))
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
        itemTraitTypeLabelControl:SetText(GetString(SI_PA_DIALOG_BANKING_ADVANCED_TRAIT_TYPES))
        _traitTypesShifterBox = _createAndReturnTraitTypesShifterBox()
        _traitTypesShifterBox:SetAnchor(TOPLEFT, itemTraitTypeLabelControl, BOTTOMLEFT, 40, -5)
        _traitTypesShifterBox:SetDimensions(380, 200)
        _traitTypesShifterBox:RegisterCallback(PA.LibShifterBox.EVENT_ENTRY_MOVED, function()
            _updateTraitsRuleCache()
            _updateRuleSummary()
        end)

        -- initialize the RuleSummary
        local ruleSummaryLabelControl = window:GetNamedChild("RuleSummaryLabel")
        ruleSummaryLabelControl:SetText(GetString(SI_PA_MAINMENU_BANKING_ADVANCED_RULE_SUMMARY))
        local ruleSummaryTextControl = window:GetNamedChild("RuleSummaryText")
        local customFont = string.format("$(%s)|$(KB_%s)|%s", "MEDIUM_FONT", 14, "soft-shadow-thin")
        ruleSummaryTextControl:SetFont(customFont)

        -- initialize the localized buttons
        local addRuleButtonControl = window:GetNamedChild("AddRuleButton")
        local addRuleLabelControl = addRuleButtonControl:GetNamedChild("AddRuleLabel")
        addRuleLabelControl:SetText(GetString(SI_PA_RULES_GENERIC_ADD_RULE_BUTTON))
        addRuleLabelControl:SetDimensions(addRuleLabelControl:GetTextDimensions())
        addRuleButtonControl:SetHandler("OnClicked", function()
            _addCustomAdvancedRuleClicked(false)
        end)

        local updateRuleButtonControl = window:GetNamedChild("UpdateRuleButton")
        local updateRuleLabelControl = updateRuleButtonControl:GetNamedChild("UpdateRuleLabel")
        updateRuleLabelControl:SetText(GetString(SI_PA_RULES_GENERIC_UPDATE_RULE_BUTTON))
        updateRuleLabelControl:SetDimensions(updateRuleLabelControl:GetTextDimensions())
        updateRuleButtonControl:SetHandler("OnClicked", function()
            _addCustomAdvancedRuleClicked(true)
        end)

        local deleteRuleButtonControl = window:GetNamedChild("DeleteRuleButton")
        local deleteRuleLabelControl = deleteRuleButtonControl:GetNamedChild("DeleteRuleLabel")
        deleteRuleLabelControl:SetText(GetString(SI_PA_RULES_GENERIC_DELETE_RULE_BUTTON))
        deleteRuleLabelControl:SetDimensions(deleteRuleLabelControl:GetTextDimensions())
        deleteRuleButtonControl:SetHandler("OnClicked", function()
            deletePABCustomAdvancedRule(_ruleCache.ruleId)
        end)
    end
end

local function showPABAddCustomAdvancedRuleUIDialog(existingRuleId)
    _loadingInProgress = true
    local headerControl = window:GetNamedChild("Header")
    local itemActionDropdownControl = window:GetNamedChild("ItemActionDropdown")
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

    if existingRuleId then
        -- init with existing values
        headerControl:SetText(table.concat({PAC.COLORED_TEXTS.PAB, ": ", GetString(SI_PA_RULES_GENERIC_UPDATE_RULE)}))
        -- get rule settings
        local PABAdvancedRules = PA.SavedVars.Banking[PA.activeProfile].AdvancedRules.Rules
        local ruleSettingRaw = PABAdvancedRules[existingRuleId].ruleRaw

        df("LOAD: %s", ruleSettingRaw)
        _resetRuleCache() -- really needed?
        _ruleCache.ruleId = existingRuleId
        _convertRawSettingsToLocalSettings(ruleSettingRaw)

        -- load values on UI
        itemActionDropdownControl:SelectByKey(_ruleCache.itemAction)
        itemGroupDropdownControl:SelectByKey(_ruleCache.itemGroup)
        d("111")
        _resetShifterBoxAndResetToLeft(_itemQualitiesShifterBox, nil, true, _ruleCache.qualities)
        itemLevelFromEdit:SetText(_ruleCache.levelFrom)
        _setButtonTextures(itemLevelFromButton, _ruleCache.levelFromType)
        itemLevelToEdit:SetText(_ruleCache.levelTo)
        _setButtonTextures(itemLevelToButton, _ruleCache.levelToType)
        itemSetDropdownControl:SelectByKey(_ruleCache.setSetting)
        itemCraftedDropdownControl:SelectByKey(_ruleCache.craftedSetting)
        d("222")
        _resetShifterBoxAndResetToLeft(_itemTypesShifterBox, _ruleCache.itemGroup, true, _ruleCache.itemTypes)
        itemTraitDropdownControl:SelectByKey(_ruleCache.traitSetting)
        d("333")
        _resetShifterBoxAndResetToLeft(_traitTypesShifterBox, _ruleCache.itemGroup, _ruleCache.traitSetting == TRAIT_SELECTED, _ruleCache.traitTypes)

        -- show UPDATE/DELETE buttons, hide ADD button
        addRuleButtonControl:SetHidden(true)
        updateRuleButtonControl:SetHidden(false)
        updateRuleButtonControl:SetEnabled(true)
        deleteRuleButtonControl:SetHidden(false)
    else
        -- reset to default values
        headerControl:SetText(table.concat({PAC.COLORED_TEXTS.PAB, ": ", GetString(SI_PA_RULES_GENERIC_ADD_RULE)}))
        itemActionDropdownControl:SelectDefault()
        itemGroupDropdownControl:SelectDefault()
        itemSetDropdownControl:SelectDefault()
        itemCraftedDropdownControl:SelectDefault()
        itemTraitDropdownControl:SelectDefault()
        itemLevelFromEdit:SetText(1)
        _setButtonTextures(itemLevelFromButton, LEVEL_NORMAL)
        itemLevelToEdit:SetText(160)
        _setButtonTextures(itemLevelToButton, LEVEL_CHAMPION)

        -- reset the rule cache
        _resetRuleCache()

        -- show ADD button, hide UPDATE/DELETE buttons
        addRuleButtonControl:SetHidden(false)
        updateRuleButtonControl:SetHidden(true)
        deleteRuleButtonControl:SetHidden(true)
    end

    -- now update the Rule Summary
    _loadingInProgress = false
    _updateRuleSummary()

    -- and finally, show window
    window:SetHidden(false)
end

local function enablePABCustomAdvancedRule(existingRuleId)
    local PABAdvancedRules = PA.Banking.SavedVars.AdvancedRules.Rules
    if PAHF.isKeyInTable(PABAdvancedRules, existingRuleId) then
        -- is in table, enable rule
        PABAdvancedRules[existingRuleId].ruleEnabled = true
        PAB.println(SI_PA_CHAT_BANKING_ADVANCED_RULES_ENABLED, existingRuleId)

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
        PAB.println(SI_PA_CHAT_BANKING_ADVANCED_RULES_DISABLED, existingRuleId)

        -- refresh the list (if it was initialized)
        if PA.BankingAdvancedRulesList then PA.BankingAdvancedRulesList:Refresh() end
    else
        PAB.debugln("ERROR; PAB advanced rule not existing, cannot be disabled")
    end
end

local function moveUpPABCustomAdvancedRule(ruleId)
    if ruleId > 1 then
        local PABAdvancedRules = PA.Banking.SavedVars.AdvancedRules.Rules
        if PAHF.isKeyInTable(PABAdvancedRules, ruleId) then
            -- is in table, move rule up
            -- As of October 2020, ESO is based on LUA 5.1 which does not support "table.move" yet (LUA 5.3+)
            -- table.move(PABAdvancedRules, ruleId, ruleId - 1)
            table.insert(PABAdvancedRules, ruleId - 1, table.remove(PABAdvancedRules, ruleId))

            PAB.println(SI_PA_CHAT_BANKING_ADVANCED_RULES_MOVED_UP, ruleId, ruleId - 1)
            window:SetHidden(true)

            -- refresh the list (if it was initialized)
            if PA.BankingAdvancedRulesList then PA.BankingAdvancedRulesList:Refresh() end
        else
            PAB.debugln("ERROR; PAB adavanced rule not existing, cannot be moved UP")
        end
    end
end

local function moveDownPABCustomAdvancedRule(ruleId)
    -- currently it is not possible to check here if the ruleId is not the last one
    local PABAdvancedRules = PA.Banking.SavedVars.AdvancedRules.Rules
    if PAHF.isKeyInTable(PABAdvancedRules, ruleId) then
        -- is in table, move rule down
        -- As of October 2020, ESO is based on LUA 5.1 which does not support "table.move" yet (LUA 5.3+)
        -- table.move(PABAdvancedRules, ruleId, ruleId + 1)
        table.insert(PABAdvancedRules, ruleId + 1, table.remove(PABAdvancedRules, ruleId))

        PAB.println(SI_PA_CHAT_BANKING_ADVANCED_RULES_MOVED_DOWN, ruleId, ruleId + 1)
        window:SetHidden(true)

        -- refresh the list (if it was initialized)
        if PA.BankingAdvancedRulesList then PA.BankingAdvancedRulesList:Refresh() end
    else
        PAB.debugln("ERROR; PAB adavanced rule not existing, cannot be moved DOWN")
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
PA.CustomDialogs.moveUpPABCustomAdvancedRule = moveUpPABCustomAdvancedRule
PA.CustomDialogs.moveDownPABCustomAdvancedRule = moveDownPABCustomAdvancedRule
