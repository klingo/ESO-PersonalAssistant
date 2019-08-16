-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAB = PA.Banking
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local window = PABankingAddCustomAdvancedRuleWindow


local LEVEL_NORMAL = 0
local LEVEL_CHAMPION = 1

local _selectedItemGroup
local _selectedLevelFromType
local _selectedLevelToType

local _itemSubGroupsShifterBox
local _itemQualitiesShifterBox
local _traitTypesShifterBox

local _initDone = false

local function _resetShifterBoxAndResetToLeft(shifterBox, selectCategory)
    if selectCategory then shifterBox:ShowOnlyCategory(selectCategory) end
    shifterBox:MoveAllEntriesToLeftList()
    shifterBox:SetEnabled(true)
end

local DropdownRefs = {
    anyPleaseSelect = ZO_ComboBox:CreateItemEntry("<Please Select>", function() -- TODO: extract
        _selectedItemGroup = nil
        _itemSubGroupsShifterBox:SetEnabled(false)
        _traitTypesShifterBox:SetEnabled(false)
    end ),

    itemGroupWeapons = ZO_ComboBox:CreateItemEntry(zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS)), function()
        _selectedItemGroup = ITEMFILTERTYPE_WEAPONS
        _resetShifterBoxAndResetToLeft(_itemSubGroupsShifterBox, ITEMFILTERTYPE_WEAPONS)
        _resetShifterBoxAndResetToLeft(_traitTypesShifterBox, ITEMFILTERTYPE_WEAPONS)
    end ),
    itemGroupArmor = ZO_ComboBox:CreateItemEntry(zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR)), function()
        _selectedItemGroup = ITEMFILTERTYPE_ARMOR
        _resetShifterBoxAndResetToLeft(_itemSubGroupsShifterBox, ITEMFILTERTYPE_ARMOR)
        _resetShifterBoxAndResetToLeft(_traitTypesShifterBox, ITEMFILTERTYPE_ARMOR)
    end ),
    itemGroupJewelry = ZO_ComboBox:CreateItemEntry(zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY)), function()
        _selectedItemGroup = ITEMFILTERTYPE_JEWELRY
        _resetShifterBoxAndResetToLeft(_itemSubGroupsShifterBox, ITEMFILTERTYPE_JEWELRY)
        _resetShifterBoxAndResetToLeft(_traitTypesShifterBox, ITEMFILTERTYPE_JEWELRY)
    end ),
}

local function _createAndReturnItemSubGroupsShifterBox()
    -- TODO: extract labels
    local itemSubGroupsShifterBox = PA.LibShifterBox(PAB.AddonName, "ItemSubGroups", window, "Available", "Selected", { emptyListText = "None" })
    local armorSubGroupData = {
        [ITEMFILTERTYPE_ARMOR..ARMORTYPE_LIGHT] = GetString("SI_ARMORTYPE", ARMORTYPE_LIGHT),
        [ITEMFILTERTYPE_ARMOR..ARMORTYPE_MEDIUM] = GetString("SI_ARMORTYPE", ARMORTYPE_MEDIUM),
        [ITEMFILTERTYPE_ARMOR..ARMORTYPE_HEAVY] = GetString("SI_ARMORTYPE", ARMORTYPE_HEAVY),
    }
    itemSubGroupsShifterBox:AddEntriesToLeftList(armorSubGroupData, false, ITEMFILTERTYPE_ARMOR)
    local twoHandedPrefix = table.concat({GetString("SI_WEAPONCONFIGTYPE", WEAPON_CONFIG_TYPE_TWO_HANDED), " "})
    local weaponSubGroupData = {
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
    itemSubGroupsShifterBox:AddEntriesToLeftList(weaponSubGroupData, false, ITEMFILTERTYPE_WEAPONS)
    local jewelrySubGroupData = {
        [ITEMFILTERTYPE_JEWELRY..EQUIP_TYPE_NECK] = GetString("SI_EQUIPTYPE", EQUIP_TYPE_NECK),
        [ITEMFILTERTYPE_JEWELRY..EQUIP_TYPE_RING] = GetString("SI_EQUIPTYPE", EQUIP_TYPE_RING),
    }
    itemSubGroupsShifterBox:AddEntriesToLeftList(jewelrySubGroupData, false, ITEMFILTERTYPE_JEWELRY)
    return itemSubGroupsShifterBox
end

local function _createAndReturnItemQualitiesShifterBox()
    -- TODO: extract labels
    local itemQualitiesShifterBox = PA.LibShifterBox(PAB.AddonName, "ItemQualities", window, "Available", "Selected", { sortBy = "key", emptyListText = "None" })
    local listData = {
        [ITEM_QUALITY_TRASH] = GetItemQualityColor(ITEM_QUALITY_TRASH):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_TRASH)),
        [ITEM_QUALITY_NORMAL] = GetItemQualityColor(ITEM_QUALITY_NORMAL):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_NORMAL)),
        [ITEM_QUALITY_MAGIC] = GetItemQualityColor(ITEM_QUALITY_MAGIC):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_MAGIC)),
        [ITEM_QUALITY_ARCANE] = GetItemQualityColor(ITEM_QUALITY_ARCANE):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_ARCANE)),
        [ITEM_QUALITY_ARTIFACT] = GetItemQualityColor(ITEM_QUALITY_ARTIFACT):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_ARTIFACT)),
        [ITEM_QUALITY_LEGENDARY] = GetItemQualityColor(ITEM_QUALITY_LEGENDARY):Colorize(GetString("SI_ITEMQUALITY", ITEM_QUALITY_LEGENDARY)),
    }
    itemQualitiesShifterBox:AddEntriesToLeftList(listData)
    return itemQualitiesShifterBox
end

local function _createAndReturnTraitTypesShifterBox()
    -- TODO: extract labels
    local traitTypesShifterBox = PA.LibShifterBox(PAB.AddonName, "TraitTypes", window, "Available", "Selected", { emptyListText = "None" })
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
    traitTypesShifterBox:AddEntryToLeftList(ITEM_TRAIT_TYPE_NONE, GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_NONE))
    return traitTypesShifterBox
end

local function _setButtonTextures(control, textureTemplate)
    control:SetNormalTexture(textureTemplate:format("up"))
    control:SetPressedTexture(textureTemplate:format("down"))
    control:SetMouseOverTexture(textureTemplate:format("over"))
    control:SetDisabledTexture(textureTemplate:format("disabled"))
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
        itemGroupDropdownControl.m_comboBox:AddItem(DropdownRefs.anyPleaseSelect)
        itemGroupDropdownControl.m_comboBox:AddItem(DropdownRefs.itemGroupWeapons)
        itemGroupDropdownControl.m_comboBox:AddItem(DropdownRefs.itemGroupArmor)
        itemGroupDropdownControl.m_comboBox:AddItem(DropdownRefs.itemGroupJewelry)
        -- define the default entry
        function itemGroupDropdownControl:SelectDefault()
            itemGroupDropdownControl.m_comboBox:SelectItem(DropdownRefs.anyPleaseSelect)
        end

        -- initialize the Quality shifterBox
        local itemQualityLabelControl = window:GetNamedChild("ItemQualityLabel")
        itemQualityLabelControl:SetText("Item Qualities") -- TODO: extract
        _itemQualitiesShifterBox = _createAndReturnItemQualitiesShifterBox()
        _itemQualitiesShifterBox:SetAnchor(TOPLEFT, itemQualityLabelControl, BOTTOMLEFT, 40, -5)
        _itemQualitiesShifterBox:SetDimensions(340, 200)

        -- initialize the ItemType dropdown
        local itemTypeLabelControl = window:GetNamedChild("ItemTypeLabel")
        itemTypeLabelControl:SetText("Item Types") -- TODO: extract
        _itemSubGroupsShifterBox = _createAndReturnItemSubGroupsShifterBox()
        _itemSubGroupsShifterBox:SetAnchor(TOPLEFT, itemTypeLabelControl, BOTTOMLEFT, 40, -5)
        _itemSubGroupsShifterBox:SetDimensions(340, 200)

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
        end)

        -- initialize the Set dropdown
        local itemSetLabelControl = window:GetNamedChild("ItemSetLabel")
        itemSetLabelControl:SetText("Set") -- TODO: extract

        -- initialize the Crafted dropdown
        local itemCrafterLabelControl = window:GetNamedChild("ItemCraftedLabel")
        itemCrafterLabelControl:SetText("Crafted") -- TODO: extract



        -- initialize the ItemTrait dropdown
        local itemCrafterLabelControl = window:GetNamedChild("ItemTraitLabel")
        itemCrafterLabelControl:SetText("Item Traits") -- TODO: extract

        -- initialize the TraitType shifterBox
        local itemTraitTypeLabelControl = window:GetNamedChild("ItemTraitTypeLabel")
        itemTraitTypeLabelControl:SetText("Trait Types") -- TODO: extract
        _traitTypesShifterBox = _createAndReturnTraitTypesShifterBox()
        _traitTypesShifterBox:SetAnchor(TOPLEFT, itemTraitTypeLabelControl, BOTTOMLEFT, 40, -5)
        _traitTypesShifterBox:SetDimensions(340, 200)


        _G["patest"] = _traitTypesShifterBox
        _G["tata"] = window

    end
end

local function showPABAddCustomAdvancedRuleUIDialog()
    -- init ItemGrooup dropdown
    local itemGroupDropdownControl = window:GetNamedChild("ItemGroupDropdown")
    itemGroupDropdownControl:SelectDefault()

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