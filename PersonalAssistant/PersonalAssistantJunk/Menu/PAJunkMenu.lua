-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAMenuFunctions = PA.MenuFunctions
local PAMenuDefaults = PA.MenuDefaults
local PAMenuChoices = PA.MenuChoices

local LAM2 = LibStub("LibAddonMenu-2.0")

local PAJunkPanelData = {
    type = "panel",
    name = "PersonalAssistant Junk",
    displayName = GetString(SI_PA_MENU_TITLE),
    author = "Klingo",
    version = PAC.ADDON_VERSION,
    website = "http://www.esoui.com/downloads/info381-PersonalAssistant",
    slashCommand = "/pajunk",
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
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_ENABLE_T),
        getFunc = PAMenuFunctions.PAJunk.getAutoMarkAsJunkEnabledSetting,
        setFunc = PAMenuFunctions.PAJunk.setAutoMarkAsJunkEnabledSetting,
        disabled = PAMenuFunctions.PAJunk.isAutoMarkAsJunkDisabled,
        default = PAMenuDefaults.PAJunk.autoMarkAsJunkEnabled,
    })

    PAJunkOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_TRASH_HEADER),
        controls = PAJTrashSubMenu,
        disabled = PAMenuFunctions.PAJunk.isTrashMenuDisabled,
    })

    PAJunkOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_COLLECTIBLES_HEADER),
        controls = PAJCollectiblesSubMenu,
        disabled = PAMenuFunctions.PAJunk.isCollectiblesMenuDisabled,
    })

    PAJunkOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_WEAPONS_HEADER),
        controls = PAJWeaponsSubMenu,
        disabled = PAMenuFunctions.PAJunk.isWeaponsMenuDisabled,
    })

    PAJunkOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_ARMOR_HEADER),
        controls = PAJArmorSubMenu,
        disabled = PAMenuFunctions.PAJunk.isArmorMenuDisabled,
    })

    PAJunkOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_JUNK_JEWELRY_HEADER),
        controls = PAJJewelrySubMenu,
        disabled = PAMenuFunctions.PAJunk.isJewelryMenuDisabled,
    })

    PAJunkOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOSELL_JUNK),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOSELL_JUNK_T),
        getFunc = PAMenuFunctions.PAJunk.getAutoSellJunkSetting,
        setFunc = PAMenuFunctions.PAJunk.setAutoSellJunkSetting,
        disabled = PAMenuFunctions.PAJunk.isAutoSellJunkDisabled,
        default = PAMenuDefaults.PAJunk.autoSellJunk,
    })

    PAJunkOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_CHAT_OUTPUT_ENABLE),
        tooltip = GetString(SI_PA_MENU_CHAT_OUTPUT_ENABLE_T),
        getFunc = PAMenuFunctions.PAJunk.getChatOutputSetting,
        setFunc = PAMenuFunctions.PAJunk.setChatOutputSetting,
        disabled = PAMenuFunctions.PAJunk.isChatOutputDisabled,
        default = PAMenuDefaults.PAJunk.chatOutput,
    })
end

-- =================================================================================================================

local function _createPAJTrashSubMenu()
    PAJTrashSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_TRASH_AUTOMARK),
        tooltip = GetString(SI_PA_MENU_JUNK_TRASH_AUTOMARK_T),
        getFunc = PAMenuFunctions.PAJunk.getTrashAutoMarkSetting,
        setFunc = PAMenuFunctions.PAJunk.setTrashAutoMarkSetting,
        disabled = PAMenuFunctions.PAJunk.isTrashAutoMarkDisabled,
        default = PAMenuDefaults.PAJunk.Trash.autoMarkTrash,
    })

    -- TODO: mark junk food
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAJCollectiblesSubMenu()
    PAJCollectiblesSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK),
        tooltip = GetString(SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK_T),
        getFunc = PAMenuFunctions.PAJunk.getAutoMarkSellToMerchantSetting,
        setFunc = PAMenuFunctions.PAJunk.setAutoMarkSellToMerchantSetting,
        disabled = PAMenuFunctions.PAJunk.isAutoMarkSellToMerchantDisabled,
        default = PAMenuDefaults.PAJunk.Collectibles.autoMarkSellToMerchant,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAJWeaponsSubMenu()
    PAJWeaponsSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T),
        getFunc = PAMenuFunctions.PAJunk.getWeaponsAutoMarkOrnateSetting,
        setFunc = PAMenuFunctions.PAJunk.setWeaponsAutoMarkOrnateSetting,
        disabled = PAMenuFunctions.PAJunk.isWeaponsAutoMarkOrnateDisabled,
        default = PAMenuDefaults.PAJunk.Weapons.autoMarkOrnate,
    })

    PAJWeaponsSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_WEAPONS_AUTOMARK_QUALITY),
        tooltip = GetString(SI_PA_MENU_JUNK_WEAPONS_AUTOMARK_QUALITY_T),
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getWeaponsAutoMarkQualitySetting,
        setFunc = PAMenuFunctions.PAJunk.setWeaponsAutoMarkQualitySetting,
        disabled = PAMenuFunctions.PAJunk.isWeaponsAutoMarkQualityDisabled,
        default = PAMenuDefaults.PAJunk.Weapons.autoMarkQuality,
    })

    PAJWeaponsSubMenu:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_JUNK_WEAPONS_AUTOMARK_QUALITY_THRESHOLD),
        tooltip = GetString(SI_PA_MENU_JUNK_WEAPONS_AUTOMARK_QUALITY_THRESHOLD_T),
        choices = PAMenuChoices.choices.PAJunk.qualityLevel,
        choicesValues = PAMenuChoices.choicesValues.PAJunk.qualityLevel,
        --        choicesTooltips = PAMenuChoices.choicesTooltips.PAJunk.qualityLevel,
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getWeaponsAutoMarkQualityThresholdSetting,
        setFunc = PAMenuFunctions.PAJunk.setWeaponsAutoMarkQualityThresholdSetting,
        disabled = PAMenuFunctions.PAJunk.isWeaponsAutoMarkQualityThresholdDisabled,
        default = PAMenuDefaults.PAJunk.Weapons.autoMarkQualityThreshold,
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
        getFunc = PAMenuFunctions.PAJunk.getWeaponsIncludeSetItemsSetting,
        setFunc = PAMenuFunctions.PAJunk.setWeaponsIncludeSetItemsSetting,
        disabled = PAMenuFunctions.PAJunk.isWeaponsIncludeSetItemsDisabled,
        default = PAMenuDefaults.PAJunk.Weapons.autoMarkIncludingSets,
    })

    PAJWeaponsSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T),
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getWeaponsIncludeUnknownTraitsSetting,
        setFunc = PAMenuFunctions.PAJunk.setWeaponsIncludeUnknownTraitsSetting,
        disabled = PAMenuFunctions.PAJunk.isWeaponsIncludeUnknownTraitsDisabled,
        default = PAMenuDefaults.PAJunk.Weapons.autoMarkUnknownTraits,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAJArmorSubMenu()
    PAJArmorSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T),
        getFunc = PAMenuFunctions.PAJunk.getArmorAutoMarkOrnateSetting,
        setFunc = PAMenuFunctions.PAJunk.setArmorAutoMarkOrnateSetting,
        disabled = PAMenuFunctions.PAJunk.isArmorAutoMarkOrnateDisabled,
        default = PAMenuDefaults.PAJunk.Weapons.autoMarkOrnate,
    })

    PAJArmorSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_ARMOR_AUTOMARK_QUALITY),
        tooltip = GetString(SI_PA_MENU_JUNK_ARMOR_AUTOMARK_QUALITY_T),
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getArmorAutoMarkQualitySetting,
        setFunc = PAMenuFunctions.PAJunk.setArmorAutoMarkQualitySetting,
        disabled = PAMenuFunctions.PAJunk.isArmorAutoMarkQualityDisabled,
        default = PAMenuDefaults.PAJunk.Armor.autoMarkQuality,
    })

    PAJArmorSubMenu:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_JUNK_ARMOR_AUTOMARK_QUALITY_THRESHOLD),
        tooltip = GetString(SI_PA_MENU_JUNK_ARMOR_AUTOMARK_QUALITY_THRESHOLD_T),
        choices = PAMenuChoices.choices.PAJunk.qualityLevel,
        choicesValues = PAMenuChoices.choicesValues.PAJunk.qualityLevel,
        --        choicesTooltips = PAMenuChoices.choicesTooltips.PAJunk.qualityLevel,
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getArmorAutoMarkQualityThresholdSetting,
        setFunc = PAMenuFunctions.PAJunk.setArmorAutoMarkQualityThresholdSetting,
        disabled = PAMenuFunctions.PAJunk.isArmorAutoMarkQualityThresholdDisabled,
        default = PAMenuDefaults.PAJunk.Armor.autoMarkQualityThreshold,
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
        getFunc = PAMenuFunctions.PAJunk.getArmorIncludeSetItemsSetting,
        setFunc = PAMenuFunctions.PAJunk.setArmorIncludeSetItemsSetting,
        disabled = PAMenuFunctions.PAJunk.isArmorIncludeSetItemsDisabled,
        default = PAMenuDefaults.PAJunk.Armor.autoMarkIncludingSets,
    })

    PAJArmorSubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T),
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getArmorIncludeUnknownTraitsSetting,
        setFunc = PAMenuFunctions.PAJunk.setArmorIncludeUnknownTraitsSetting,
        disabled = PAMenuFunctions.PAJunk.isArmorIncludeUnknownTraitsDisabled,
        default = PAMenuDefaults.PAJunk.Armor.autoMarkUnknownTraits,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAJJewelrySubMenu()
    PAJJewelrySubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T),
        getFunc = PAMenuFunctions.PAJunk.getJewelryAutoMarkOrnateSetting,
        setFunc = PAMenuFunctions.PAJunk.setJewelryAutoMarkOrnateSetting,
        disabled = PAMenuFunctions.PAJunk.isJewelryAutoMarkOrnateDisabled,
        default = PAMenuDefaults.PAJunk.Weapons.autoMarkOrnate,
    })

    PAJJewelrySubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_JEWELRY_AUTOMARK_QUALITY),
        tooltip = GetString(SI_PA_MENU_JUNK_JEWELRY_AUTOMARK_QUALITY_T),
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getJewelryAutoMarkQualitySetting,
        setFunc = PAMenuFunctions.PAJunk.setJewelryAutoMarkQualitySetting,
        disabled = PAMenuFunctions.PAJunk.isJewelryAutoMarkQualityDisabled,
        default = PAMenuDefaults.PAJunk.Jewelry.autoMarkQuality,
    })

    PAJJewelrySubMenu:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_JUNK_JEWELRY_AUTOMARK_QUALITY_THRESHOLD),
        tooltip = GetString(SI_PA_MENU_JUNK_JEWELRY_AUTOMARK_QUALITY_THRESHOLD_T),
        choices = PAMenuChoices.choices.PAJunk.qualityLevel,
        choicesValues = PAMenuChoices.choicesValues.PAJunk.qualityLevel,
        --        choicesTooltips = PAMenuChoices.choicesTooltips.PAJunk.qualityLevel,
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getJewelryAutoMarkQualityThresholdSetting,
        setFunc = PAMenuFunctions.PAJunk.setJewelryAutoMarkQualityThresholdSetting,
        disabled = PAMenuFunctions.PAJunk.isJewelryAutoMarkQualityThresholdDisabled,
        default = PAMenuDefaults.PAJunk.Jewelry.autoMarkQualityThreshold,
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
        getFunc = PAMenuFunctions.PAJunk.getJewelryIncludeSetItemsSetting,
        setFunc = PAMenuFunctions.PAJunk.setJewelryIncludeSetItemsSetting,
        disabled = PAMenuFunctions.PAJunk.isJewelryIncludeSetItemsDisabled,
        default = PAMenuDefaults.PAJunk.Jewelry.autoMarkIncludingSets,
    })

    PAJJewelrySubMenu:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS),
        tooltip = GetString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T),
        width = "half",
        getFunc = PAMenuFunctions.PAJunk.getJewelryIncludeUnknownTraitsSetting,
        setFunc = PAMenuFunctions.PAJunk.setJewelryIncludeUnknownTraitsSetting,
        disabled = PAMenuFunctions.PAJunk.isJewelryIncludeUnknownTraitsDisabled,
        default = PAMenuDefaults.PAJunk.Jewelry.autoMarkUnknownTraits,
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
