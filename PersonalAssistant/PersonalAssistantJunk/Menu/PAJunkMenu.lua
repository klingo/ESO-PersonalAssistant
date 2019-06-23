-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACAddon = PAC.ADDON
local PAHF = PA.HelperFunctions
local PAGMenuFunctions = PA.MenuFunctions.PAGeneral
local PAJMenuChoices = PA.MenuChoices.choices.PAJunk
local PAJMenuChoicesValues = PA.MenuChoices.choicesValues.PAJunk
local PAJMenuDefaults = PA.MenuDefaults.PAJunk
local PAJMenuFunctions = PA.MenuFunctions.PAJunk

-- Create the LibAddonMenu2 object
PA.LAM2 = PA.LAM2 or LibAddonMenu2 or LibStub("LibAddonMenu-2.0")

local PAJunkPanelData = {
    type = "panel",
    name = PACAddon.NAME_RAW.JUNK,
    displayName = PACAddon.NAME_DISPLAY.JUNK,
    author = PACAddon.AUTHOR,
    version = PACAddon.VERSION_DISPLAY,
    website = PACAddon.WEBSITE,
    feedback = PACAddon.FEEDBACK,
    keywords = PACAddon.KEYWORDS.JUNK,
    slashCommand = "/paj",
    registerForRefresh = true,
    registerForDefaults = true,
}

local PAJunkOptionsTable = setmetatable({}, { __index = table })

local PAJTrashSubMenu = setmetatable({}, { __index = table })
local PAJCollectiblesSubMenu = setmetatable({}, { __index = table })
local PAJMiscellaneousSubMenu = setmetatable({}, { __index = table })
local PAJWeaponsSubMenu = setmetatable({}, { __index = table })
local PAJArmorSubMenu = setmetatable({}, { __index = table })
local PAJJewelrySubMenu = setmetatable({}, { __index = table })

local PAJKeybindingsSubMenu = setmetatable({}, { __index = table })

-- =================================================================================================================

local function _createPAJunkMenu()
    PAJunkOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_JUNK_DESCRIPTION),
    })

    PAJunkOptionsTable:insert({
        type = "header",
        name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_JUNK_STANDARD_ITEMS_HEADER))
    })

    PAJunkOptionsTable:insert({
        type = "checkbox",
        name = PAC.COLOR.LIGHT_BLUE:Colorize(GetString(SI_PA_MENU_JUNK_AUTOMARK_ENABLE)),
        getFunc = PAJMenuFunctions.getAutoMarkAsJunkEnabledSetting,
        setFunc = PAJMenuFunctions.setAutoMarkAsJunkEnabledSetting,
        disabled = PAGMenuFunctions.isNoProfileSelected,
        default = PAJMenuDefaults.autoMarkAsJunkEnabled,
    })

    PAJunkOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_TRASH_HEADER),
        icon = PAC.ICONS.CRAFTBAG.JUNK.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PAJTrashSubMenu,
        disabledLabel = PAJMenuFunctions.isTrashMenuDisabled,
    })

    PAJunkOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_COLLECTIBLES_HEADER),
        icon = PAC.ICONS.CRAFTBAG.COLLECTIBLES.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PAJCollectiblesSubMenu,
        disabledLabel = PAJMenuFunctions.isCollectiblesMenuDisabled,
    })

    PAJunkOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_MISCELLANEOUS_HEADER),
        icon = PAC.ICONS.CRAFTBAG.MISCELLANEOUS.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PAJMiscellaneousSubMenu,
        disabledLabel = PAJMenuFunctions.isMiscellaneousMenuDisabled,
    })

    PAJunkOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_WEAPONS_HEADER),
        icon = PAC.ICONS.CRAFTBAG.WEAPON.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PAJWeaponsSubMenu,
        disabledLabel = PAJMenuFunctions.isWeaponsMenuDisabled,
    })

    PAJunkOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_ARMOR_HEADER),
        icon = PAC.ICONS.CRAFTBAG.ARMOR.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PAJArmorSubMenu,
        disabledLabel = PAJMenuFunctions.isArmorMenuDisabled,
    })

    PAJunkOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_JEWELRY_HEADER),
        icon = PAC.ICONS.CRAFTBAG.JEWELRY.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PAJJewelrySubMenu,
        disabledLabel = PAJMenuFunctions.isJewelryMenuDisabled,
    })

    PAJunkOptionsTable:insert({
        type = "header",
        name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_JUNK_CUSTOM_ITEMS_HEADER))
    })

    PAJunkOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_JUNK_CUSTOM_ITEMS_DESCRIPTION)
    })

    PAJunkOptionsTable:insert({
        type = "button",
        name = GetString(SI_PA_MAINMENU_JUNK_HEADER),
        func = PA.CustomDialogs.showPAJunkRulesMenu,
        disabled = PAGMenuFunctions.isNoProfileSelected,
    })

    PAJunkOptionsTable:insert({
        type = "header",
        name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_OTHER_SETTINGS_HEADER))
    })

    PAJunkOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_KEYBINDINGS_HEADER),
        icon = PAC.ICONS.OTHERS.KEY.PATH,
        iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
        controls = PAJKeybindingsSubMenu,
        disabledLabel = PAJMenuFunctions.isKeybindingsMenuDisabled,
    })

    PAJunkOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOSELL_JUNK),
        getFunc = PAJMenuFunctions.getAutoSellJunkSetting,
        setFunc = PAJMenuFunctions.setAutoSellJunkSetting,
        disabled = PAJMenuFunctions.isAutoSellJunkDisabled,
        default = PAJMenuDefaults.autoSellJunk,
    })

    PAJunkOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_SILENT_MODE),
        getFunc = PAJMenuFunctions.getSilentModeSetting,
        setFunc = PAJMenuFunctions.setSilentModeSetting,
        disabled = PAJMenuFunctions.isSilentModeDisabled,
        default = PAJMenuDefaults.silentMode,
    })
end

-- =================================================================================================================

local function _createPAJTrashSubMenu()
    PAJTrashSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_TRASH_AUTOMARK),
        tooltip = GetString(SI_PA_MENU_JUNK_TRASH_AUTOMARK_T),
        getFunc = PAJMenuFunctions.getTrashAutoMarkSetting,
        setFunc = PAJMenuFunctions.setTrashAutoMarkSetting,
        disabled = PAJMenuFunctions.isTrashAutoMarkDisabled,
        default = PAJMenuDefaults.Trash.autoMarkTrash,
    })

    PAJTrashSubMenu:insert({
        type = "divider",
        alpha = 0.2,
    })

    PAJTrashSubMenu:insert({
        type = "description",
        text = GetString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_ITEMS_DESC),
        disabled = PAJMenuFunctions.isExcludeNibblesAndBitsDisabled,
    })

    PAJTrashSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS),
        tooltip = GetString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS_T),
        getFunc = PAJMenuFunctions.getExcludeNibblesAndBitsSetting,
        setFunc = PAJMenuFunctions.setExcludeNibblesAndBitsSetting,
        disabled = PAJMenuFunctions.isExcludeNibblesAndBitsDisabled,
        default = PAJMenuDefaults.Trash.excludeNibblesAndBits,
    })

    PAJTrashSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS),
        tooltip = GetString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS_T),
        getFunc = PAJMenuFunctions.getExcludeMorselsAndPecksSetting,
        setFunc = PAJMenuFunctions.setExcludeMorselsAndPecksSetting,
        disabled = PAJMenuFunctions.isExcludeMorselsAndPecksDisabled,
        default = PAJMenuDefaults.Trash.excludeMorselsAndPecks,
    })

    -- TODO: mark junk food
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAJCollectiblesSubMenu()
    PAJCollectiblesSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK),
        tooltip = GetString(SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK_T),
        getFunc = PAJMenuFunctions.getAutoMarkSellToMerchantSetting,
        setFunc = PAJMenuFunctions.setAutoMarkSellToMerchantSetting,
        disabled = PAJMenuFunctions.isAutoMarkSellToMerchantDisabled,
        default = PAJMenuDefaults.Collectibles.autoMarkSellToMerchant,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAJMiscellaneousSubMenu()
    PAJMiscellaneousSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_TREASURES_AUTOMARK),
        tooltip = GetString(SI_PA_MENU_JUNK_TREASURES_AUTOMARK_T),
        getFunc = PAJMenuFunctions.getTreasureAutoMarkSetting,
        setFunc = PAJMenuFunctions.setTreasureAutoMarkSetting,
        disabled = PAJMenuFunctions.isTreasureAutoMarkDisabled,
        default = PAJMenuDefaults.Miscellaneous.autoMarkTreasure,
    })

    PAJMiscellaneousSubMenu:insert({
        type = "divider",
        alpha = 0.2,
    })

    PAJMiscellaneousSubMenu:insert({
        type = "description",
        text = GetString(SI_PA_MENU_JUNK_TREASURES_EXCLUDE_ITEMS_DESC),
        disabled = PAJMenuFunctions.isExcludeAMatterOfLeisureDisabled,
    })

    PAJMiscellaneousSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_LEISURE),
        tooltip = GetString(SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_LEISURE_T),
        getFunc = PAJMenuFunctions.getExcludeAMatterOfLeisureSetting,
        setFunc = PAJMenuFunctions.setExcludeAMatterOfLeisureSetting,
        disabled = PAJMenuFunctions.isExcludeAMatterOfLeisureDisabled,
        default = PAJMenuDefaults.Miscellaneous.excludeAMatterOfLeisure,
    })

    PAJMiscellaneousSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_RESPECT),
        tooltip = GetString(SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_RESPECT_T),
        getFunc = PAJMenuFunctions.getExcludeAMatterOfRespectSetting,
        setFunc = PAJMenuFunctions.setExcludeAMatterOfRespectSetting,
        disabled = PAJMenuFunctions.isExcludeAMatterOfRespectDisabled,
        default = PAJMenuDefaults.Miscellaneous.excludeAMatterOfRespect,
    })

    PAJMiscellaneousSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_TRIBUTES),
        tooltip = GetString(SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_TRIBUTES_T),
        getFunc = PAJMenuFunctions.getExcludeAMatterOfTributesSetting,
        setFunc = PAJMenuFunctions.setExcludeAMatterOfTributesSetting,
        disabled = PAJMenuFunctions.isExcludeAMatterOfTributesDisabled,
        default = PAJMenuDefaults.Miscellaneous.excludeAMatterOfTributes,
    })

    PAJMiscellaneousSubMenu:insert({
        type = "divider",
        alpha = 0.5,
    })

    PAJMiscellaneousSubMenu:insert({
        type = "dropdown",
        name = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD, GetString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS)),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD_T, GetString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS)),
        choices = PAJMenuChoices.qualityLevel,
        choicesValues = PAJMenuChoicesValues.qualityLevel,
        --        choicesTooltips = PAMenuChoices.choicesTooltips.PAJunk.qualityLevel,
        getFunc = PAJMenuFunctions.getGlyphsAutoMarkQualityTresholdSetting,
        setFunc = PAJMenuFunctions.setGlyphsAutoMarkQualityTresholdSetting,
        disabled = PAJMenuFunctions.isGlyphsAutoMarkQualityTresholdDisabled,
        default = PAJMenuDefaults.Miscellaneous.autoMarkGlyphQualityThreshold,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAJWeaponsSubMenu()
    local _typeName = zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS))
    PAJWeaponsSubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_ORNATE, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T, _typeName),
        getFunc = PAJMenuFunctions.getWeaponsAutoMarkOrnateSetting,
        setFunc = PAJMenuFunctions.setWeaponsAutoMarkOrnateSetting,
        disabled = PAJMenuFunctions.isWeaponsAutoMarkOrnateDisabled,
        default = PAJMenuDefaults.Weapons.autoMarkOrnate,
    })

    PAJWeaponsSubMenu:insert({
        type = "dropdown",
        name = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD_T, _typeName),
        choices = PAJMenuChoices.qualityLevel,
        choicesValues = PAJMenuChoicesValues.qualityLevel,
        --        choicesTooltips = PAMenuChoices.choicesTooltips.PAJunk.qualityLevel,
        getFunc = PAJMenuFunctions.getWeaponsAutoMarkQualityThresholdSetting,
        setFunc = PAJMenuFunctions.setWeaponsAutoMarkQualityThresholdSetting,
        disabled = PAJMenuFunctions.isWeaponsAutoMarkQualityThresholdDisabled,
        default = PAJMenuDefaults.Weapons.autoMarkQualityThreshold,
    })

    PAJWeaponsSubMenu:insert({
        type = "divider",
        alpha = 0.5,
    })

    PAJWeaponsSubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS_T, _typeName),
        getFunc = PAJMenuFunctions.getWeaponsIncludeSetItemsSetting,
        setFunc = PAJMenuFunctions.setWeaponsIncludeSetItemsSetting,
        disabled = PAJMenuFunctions.isWeaponsIncludeSetItemsDisabled,
        default = PAJMenuDefaults.Weapons.autoMarkIncludingSets,
    })

    PAJWeaponsSubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_INTRICATE, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_INTRICATE_T, _typeName),
        getFunc = PAJMenuFunctions.getWeaponsIncludeIntricateTraitSetting,
        setFunc = PAJMenuFunctions.setWeaponsIncludeIntricateTraitSetting,
        disabled = PAJMenuFunctions.isWeaponsIncludeIntricateTraitDisabled,
        default = PAJMenuDefaults.Weapons.autoMarkIntricateTrait,
    })

    PAJWeaponsSubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T, _typeName),
        getFunc = PAJMenuFunctions.getWeaponsIncludeUnknownTraitsSetting,
        setFunc = PAJMenuFunctions.setWeaponsIncludeUnknownTraitsSetting,
        disabled = PAJMenuFunctions.isWeaponsIncludeUnknownTraitsDisabled,
        default = PAJMenuDefaults.Weapons.autoMarkUnknownTraits,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAJArmorSubMenu()
    local _typeName = zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR))
    PAJArmorSubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_ORNATE, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T, _typeName),
        getFunc = PAJMenuFunctions.getArmorAutoMarkOrnateSetting,
        setFunc = PAJMenuFunctions.setArmorAutoMarkOrnateSetting,
        disabled = PAJMenuFunctions.isArmorAutoMarkOrnateDisabled,
        default = PAJMenuDefaults.Weapons.autoMarkOrnate,
    })

    PAJArmorSubMenu:insert({
        type = "dropdown",
        name = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD_T, _typeName),
        choices = PAJMenuChoices.qualityLevel,
        choicesValues = PAJMenuChoicesValues.qualityLevel,
        --        choicesTooltips = PAMenuChoices.choicesTooltips.PAJunk.qualityLevel,
        getFunc = PAJMenuFunctions.getArmorAutoMarkQualityThresholdSetting,
        setFunc = PAJMenuFunctions.setArmorAutoMarkQualityThresholdSetting,
        disabled = PAJMenuFunctions.isArmorAutoMarkQualityThresholdDisabled,
        default = PAJMenuDefaults.Armor.autoMarkQualityThreshold,
    })

    PAJArmorSubMenu:insert({
        type = "divider",
        alpha = 0.5,
    })

    PAJArmorSubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS_T, _typeName),
        getFunc = PAJMenuFunctions.getArmorIncludeSetItemsSetting,
        setFunc = PAJMenuFunctions.setArmorIncludeSetItemsSetting,
        disabled = PAJMenuFunctions.isArmorIncludeSetItemsDisabled,
        default = PAJMenuDefaults.Armor.autoMarkIncludingSets,
    })

    PAJArmorSubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_INTRICATE, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_INTRICATE_T, _typeName),
        getFunc = PAJMenuFunctions.getArmorIncludeIntricateTraitSetting,
        setFunc = PAJMenuFunctions.setArmorIncludeIntricateTraitSetting,
        disabled = PAJMenuFunctions.isArmorIncludeIntricateTraitDisabled,
        default = PAJMenuDefaults.Armor.autoMarkIntricateTrait,
    })

    PAJArmorSubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T, _typeName),
        getFunc = PAJMenuFunctions.getArmorIncludeUnknownTraitsSetting,
        setFunc = PAJMenuFunctions.setArmorIncludeUnknownTraitsSetting,
        disabled = PAJMenuFunctions.isArmorIncludeUnknownTraitsDisabled,
        default = PAJMenuDefaults.Armor.autoMarkUnknownTraits,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAJJewelrySubMenu()
    local _typeName = zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY))
    PAJJewelrySubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_ORNATE, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T, _typeName),
        getFunc = PAJMenuFunctions.getJewelryAutoMarkOrnateSetting,
        setFunc = PAJMenuFunctions.setJewelryAutoMarkOrnateSetting,
        disabled = PAJMenuFunctions.isJewelryAutoMarkOrnateDisabled,
        default = PAJMenuDefaults.Weapons.autoMarkOrnate,
    })

    PAJJewelrySubMenu:insert({
        type = "dropdown",
        name = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD_T, _typeName),
        choices = PAJMenuChoices.qualityLevel,
        choicesValues = PAJMenuChoicesValues.qualityLevel,
        --        choicesTooltips = PAMenuChoices.choicesTooltips.PAJunk.qualityLevel,
        getFunc = PAJMenuFunctions.getJewelryAutoMarkQualityThresholdSetting,
        setFunc = PAJMenuFunctions.setJewelryAutoMarkQualityThresholdSetting,
        disabled = PAJMenuFunctions.isJewelryAutoMarkQualityThresholdDisabled,
        default = PAJMenuDefaults.Jewelry.autoMarkQualityThreshold,
    })

    PAJJewelrySubMenu:insert({
        type = "divider",
        alpha = 0.5,
    })

    PAJJewelrySubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS_T, _typeName),
        getFunc = PAJMenuFunctions.getJewelryIncludeSetItemsSetting,
        setFunc = PAJMenuFunctions.setJewelryIncludeSetItemsSetting,
        disabled = PAJMenuFunctions.isJewelryIncludeSetItemsDisabled,
        default = PAJMenuDefaults.Jewelry.autoMarkIncludingSets,
    })

    PAJJewelrySubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_INTRICATE, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_INTRICATE_T, _typeName),
        getFunc = PAJMenuFunctions.getJewelryIncludeIntricateTraitSetting,
        setFunc = PAJMenuFunctions.setJewelryIncludeIntricateTraitSetting,
        disabled = PAJMenuFunctions.isJewelryIncludeIntricateTraitDisabled,
        default = PAJMenuDefaults.Jewelry.autoMarkIntricateTrait,
    })

    PAJJewelrySubMenu:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS, _typeName),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T, _typeName),
        getFunc = PAJMenuFunctions.getJewelryIncludeUnknownTraitsSetting,
        setFunc = PAJMenuFunctions.setJewelryIncludeUnknownTraitsSetting,
        disabled = PAJMenuFunctions.isJewelryIncludeUnknownTraitsDisabled,
        default = PAJMenuDefaults.Jewelry.autoMarkUnknownTraits,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAJKeybindingsSubMenu()
    PAJKeybindingsSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_JUNK),
--        tooltip = GetString(SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_JUNK_T),
        getFunc = PAJMenuFunctions.getKeybindingMarkUnmarkAsJunkSetting,
        setFunc = PAJMenuFunctions.setKeybindingMarkUnmarkAsJunkSetting,
        disabled = PAJMenuFunctions.isKeybindingMarkUnmarkAsJunkDisabled,
        default = PAJMenuDefaults.KeyBindings.showMarkUnmarkAsJunkKeybind,
    })

    PAJKeybindingsSubMenu:insert({
        type = "divider",
        alpha = 0.2,
    })

    PAJKeybindingsSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM),
--        tooltip = GetString(SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_T),
        warning = GetString(SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_W),
        getFunc = PAJMenuFunctions.getKeybindingDestroyItemSetting,
        setFunc = PAJMenuFunctions.setKeybindingDestroyItemSetting,
        disabled = PAJMenuFunctions.isKeybindingDestroyItemDisabled,
        default = PAJMenuDefaults.KeyBindings.showDestroyItemKeybind,
    })

    PAJKeybindingsSubMenu:insert({
        type = "description",
        text = GetString(SI_PA_MENU_JUNK_KEYBINDINGS_EXCLUDE_DESCRIPTION),
        disabled = PAJMenuFunctions.isDestroyItemQualityThresholdDisabled,
    })

    PAJKeybindingsSubMenu:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_QUALITY_THRESHOLD),
--        tooltip = GetString(SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_QUALITY_THRESHOLD_T),
        choices = PAJMenuChoices.qualityLevelReverse,
        choicesValues = PAJMenuChoicesValues.qualityLevelReverse,
        --        choicesTooltips = PAMenuChoices.choicesTooltips.PAJunk.qualityLevel,
        getFunc = PAJMenuFunctions.getDestroyItemQualityThresholdSetting,
        setFunc = PAJMenuFunctions.setDestroyItemQualityThresholdSetting,
        disabled = PAJMenuFunctions.isDestroyItemQualityThresholdDisabled,
        default = PAJMenuDefaults.KeyBindings.destroyItemQualityThreshold,
    })

    PAJKeybindingsSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_UNKNOWN),
--        tooltip = GetString(SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_UNKNOWN_T),
        getFunc = PAJMenuFunctions.getDestroyExcludeUnknownItemsSetting,
        setFunc = PAJMenuFunctions.setDestroyExcludeUnknownItemsSetting,
        disabled = PAJMenuFunctions.isDestroyExcludeUnknownItemsDisabled,
        default = PAJMenuDefaults.KeyBindings.destroyExcludeUnknownItems,
    })
end

-- =================================================================================================================

local function createOptions()
    _createPAJunkMenu()

    _createPAJTrashSubMenu()
    _createPAJCollectiblesSubMenu()
    _createPAJMiscellaneousSubMenu()
    _createPAJWeaponsSubMenu()
    _createPAJArmorSubMenu()
    _createPAJJewelrySubMenu()

    _createPAJKeybindingsSubMenu()

    PA.LAM2:RegisterAddonPanel("PersonalAssistantJunkAddonOptions", PAJunkPanelData)
    PA.LAM2:RegisterOptionControls("PersonalAssistantJunkAddonOptions", PAJunkOptionsTable)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Junk = PA.Junk or {}
PA.Junk.createOptions = createOptions
