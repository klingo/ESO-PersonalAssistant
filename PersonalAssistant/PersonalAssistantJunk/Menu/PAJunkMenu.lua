-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAJMenuChoices = PA.MenuChoices.choices.PAJunk
local PAJMenuChoicesValues = PA.MenuChoices.choicesValues.PAJunk
local PAJMenuDefaults = PA.MenuDefaults.PAJunk
local PAJMenuFunctions = PA.MenuFunctions.PAJunk

local LAM2 = LibStub("LibAddonMenu-2.0")

local PAJunkPanelData = {
    type = "panel",
    name = "PersonalAssistant Junk",
    displayName = GetString(SI_PA_MENU_TITLE),
    author = "Klingo",
    version = PAC.ADDON_VERSION,
    website = "http://www.esoui.com/downloads/info381-PersonalAssistant",
    slashCommand = "/paj",
    registerForRefresh = true,
    registerForDefaults = true,
}

local PAJunkOptionsTable = setmetatable({}, { __index = table })

local PAJTrashSubMenu = setmetatable({}, { __index = table })
local PAJCollectiblesSubMenu = setmetatable({}, { __index = table })
local PAJWeaponsSubMenu = setmetatable({}, { __index = table })
local PAJArmorSubMenu = setmetatable({}, { __index = table })
local PAJJewelrySubMenu = setmetatable({}, { __index = table })

-- =================================================================================================================

local function _createPAJunkMenu()
    PAJunkOptionsTable:insert({
        type = "header",
        name = GetString(SI_PA_MENU_JUNK_HEADER)
    })

    PAJunkOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_JUNK_DESCRIPTION),
    })

    PAJunkOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_ENABLE),
        getFunc = PAJMenuFunctions.getAutoMarkAsJunkEnabledSetting,
        setFunc = PAJMenuFunctions.setAutoMarkAsJunkEnabledSetting,
        disabled = PAJMenuFunctions.isAutoMarkAsJunkDisabled,
        default = PAJMenuDefaults.autoMarkAsJunkEnabled,
    })

    PAJunkOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_TRASH_HEADER),
        controls = PAJTrashSubMenu,
        disabled = PAJMenuFunctions.isTrashMenuDisabled,
    })

    PAJunkOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_COLLECTIBLES_HEADER),
        controls = PAJCollectiblesSubMenu,
        disabled = PAJMenuFunctions.isCollectiblesMenuDisabled,
    })

    PAJunkOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_WEAPONS_HEADER),
        controls = PAJWeaponsSubMenu,
        disabled = PAJMenuFunctions.isWeaponsMenuDisabled,
    })

    PAJunkOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_ARMOR_HEADER),
        controls = PAJArmorSubMenu,
        disabled = PAJMenuFunctions.isArmorMenuDisabled,
    })

    PAJunkOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_JEWELRY_HEADER),
        controls = PAJJewelrySubMenu,
        disabled = PAJMenuFunctions.isJewelryMenuDisabled,
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

local function _createPAJWeaponsSubMenu()
    PAJWeaponsSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T),
        getFunc = PAJMenuFunctions.getWeaponsAutoMarkOrnateSetting,
        setFunc = PAJMenuFunctions.setWeaponsAutoMarkOrnateSetting,
        disabled = PAJMenuFunctions.isWeaponsAutoMarkOrnateDisabled,
        default = PAJMenuDefaults.Weapons.autoMarkOrnate,
    })

    PAJWeaponsSubMenu:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_JUNK_WEAPONS_AUTOMARK_QUALITY_THRESHOLD),
        tooltip = GetString(SI_PA_MENU_JUNK_WEAPONS_AUTOMARK_QUALITY_THRESHOLD_T),
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
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS_T),
        width = "half",
        getFunc = PAJMenuFunctions.getWeaponsIncludeSetItemsSetting,
        setFunc = PAJMenuFunctions.setWeaponsIncludeSetItemsSetting,
        disabled = PAJMenuFunctions.isWeaponsIncludeSetItemsDisabled,
        default = PAJMenuDefaults.Weapons.autoMarkIncludingSets,
    })

    PAJWeaponsSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T),
        width = "half",
        getFunc = PAJMenuFunctions.getWeaponsIncludeUnknownTraitsSetting,
        setFunc = PAJMenuFunctions.setWeaponsIncludeUnknownTraitsSetting,
        disabled = PAJMenuFunctions.isWeaponsIncludeUnknownTraitsDisabled,
        default = PAJMenuDefaults.Weapons.autoMarkUnknownTraits,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAJArmorSubMenu()
    PAJArmorSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T),
        getFunc = PAJMenuFunctions.getArmorAutoMarkOrnateSetting,
        setFunc = PAJMenuFunctions.setArmorAutoMarkOrnateSetting,
        disabled = PAJMenuFunctions.isArmorAutoMarkOrnateDisabled,
        default = PAJMenuDefaults.Weapons.autoMarkOrnate,
    })

    PAJArmorSubMenu:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_JUNK_ARMOR_AUTOMARK_QUALITY_THRESHOLD),
        tooltip = GetString(SI_PA_MENU_JUNK_ARMOR_AUTOMARK_QUALITY_THRESHOLD_T),
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
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS_T),
        width = "half",
        getFunc = PAJMenuFunctions.getArmorIncludeSetItemsSetting,
        setFunc = PAJMenuFunctions.setArmorIncludeSetItemsSetting,
        disabled = PAJMenuFunctions.isArmorIncludeSetItemsDisabled,
        default = PAJMenuDefaults.Armor.autoMarkIncludingSets,
    })

    PAJArmorSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T),
        width = "half",
        getFunc = PAJMenuFunctions.getArmorIncludeUnknownTraitsSetting,
        setFunc = PAJMenuFunctions.setArmorIncludeUnknownTraitsSetting,
        disabled = PAJMenuFunctions.isArmorIncludeUnknownTraitsDisabled,
        default = PAJMenuDefaults.Armor.autoMarkUnknownTraits,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAJJewelrySubMenu()
    PAJJewelrySubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T),
        getFunc = PAJMenuFunctions.getJewelryAutoMarkOrnateSetting,
        setFunc = PAJMenuFunctions.setJewelryAutoMarkOrnateSetting,
        disabled = PAJMenuFunctions.isJewelryAutoMarkOrnateDisabled,
        default = PAJMenuDefaults.Weapons.autoMarkOrnate,
    })

    PAJJewelrySubMenu:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_JUNK_JEWELRY_AUTOMARK_QUALITY_THRESHOLD),
        tooltip = GetString(SI_PA_MENU_JUNK_JEWELRY_AUTOMARK_QUALITY_THRESHOLD_T),
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
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS_T),
        width = "half",
        getFunc = PAJMenuFunctions.getJewelryIncludeSetItemsSetting,
        setFunc = PAJMenuFunctions.setJewelryIncludeSetItemsSetting,
        disabled = PAJMenuFunctions.isJewelryIncludeSetItemsDisabled,
        default = PAJMenuDefaults.Jewelry.autoMarkIncludingSets,
    })

    PAJJewelrySubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T),
        width = "half",
        getFunc = PAJMenuFunctions.getJewelryIncludeUnknownTraitsSetting,
        setFunc = PAJMenuFunctions.setJewelryIncludeUnknownTraitsSetting,
        disabled = PAJMenuFunctions.isJewelryIncludeUnknownTraitsDisabled,
        default = PAJMenuDefaults.Jewelry.autoMarkUnknownTraits,
    })
end

-- =================================================================================================================

local function createOptions()
    _createPAJunkMenu()

    _createPAJTrashSubMenu()
    _createPAJCollectiblesSubMenu()
    _createPAJWeaponsSubMenu()
    _createPAJArmorSubMenu()
    _createPAJJewelrySubMenu()

    LAM2:RegisterAddonPanel("PersonalAssistantJunkAddonOptions", PAJunkPanelData)
    LAM2:RegisterOptionControls("PersonalAssistantJunkAddonOptions", PAJunkOptionsTable)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Junk = PA.Junk or {}
PA.Junk.createOptions = createOptions
