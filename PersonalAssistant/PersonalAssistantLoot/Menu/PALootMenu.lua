-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAMenuFunctions = PA.MenuFunctions
local PAMenuDefaults = PA.MenuDefaults

local LAM2 = LibStub("LibAddonMenu-2.0")

local PALootPanelData = {
    type = "panel",
    name = "PersonalAssistant Loot",
    displayName = GetString(SI_PA_MENU_TITLE),
    author = "Klingo",
    version = PAC.ADDON_VERSION,
    website = "http://www.esoui.com/downloads/info381-PersonalAssistant",
    slashCommand = "/paloot",
    registerForRefresh = true,
    registerForDefaults = true,
}

local PALootOptionsTable = setmetatable({}, { __index = table })

local PALLootRecipesSubmenuTable = setmetatable({}, { __index = table })
local PALLootMotifsSubmenuTable = setmetatable({}, { __index = table })
local PALLootApparelWeaponsSubmenuTable = setmetatable({}, { __index = table })

-- =================================================================================================================

local function _createPALootMenu()
    PALootOptionsTable:insert({
        type = "header",
        name = GetString(SI_PA_MENU_LOOT_HEADER)
    })

    PALootOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_LOOT_DESCRIPTION),
    })

    PALootOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_ENABLE),
        tooltip = GetString(SI_PA_MENU_LOOT_ENABLE_T),
        getFunc = PAMenuFunctions.PALoot.isEnabled,
        setFunc = PAMenuFunctions.PALoot.setIsEnabled,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PALoot.enabled,
    })

    PALootOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_LOOT_RECIPES_HEADER),
        controls = PALLootRecipesSubmenuTable,
        disabled = PAMenuFunctions.PALoot.isLootRecipesMenuDisabled,
    })

    PALootOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_LOOT_MOTIFS_HEADER),
        controls = PALLootMotifsSubmenuTable,
        disabled = PAMenuFunctions.PALoot.isLootMotifsMenuDisabled,
    })

    PALootOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_LOOT_APPARELWEAPONS_HEADER),
        controls = PALLootApparelWeaponsSubmenuTable,
        disabled = PAMenuFunctions.PALoot.isLootApparelWeaponsMenuDisabled,
    })

    PALootOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING),
        tooltip = GetString(SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING_T),
        getFunc = PAMenuFunctions.PALoot.getLowInventorySpaceWarningSetting,
        setFunc = PAMenuFunctions.PALoot.setLowInventorySpaceWarningSetting,
        disabled = PAMenuFunctions.PALoot.isLowInventorySpaceWarningDisabled,
        default = PAMenuDefaults.PALoot.lowInventorySpaceWarning,
    })

    PALootOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_CHAT_OUTPUT_ENABLE),
        tooltip = GetString(SI_PA_MENU_CHAT_OUTPUT_ENABLE_T),
        getFunc = PAMenuFunctions.PALoot.getChatOutputSetting,
        setFunc = PAMenuFunctions.PALoot.setChatOutputSetting,
        disabled = PAMenuFunctions.PALoot.isChatOutputDisabled,
        default = PAMenuDefaults.PALoot.chatOutput,
    })
end

-- =================================================================================================================

local function _createPALLootRecipesSubmenuTable()
    PALLootRecipesSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG),
        tooltip = GetString(SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG_T),
        getFunc = PAMenuFunctions.PALoot.getUnknownRecipeMsgSetting,
        setFunc = PAMenuFunctions.PALoot.setUnknownRecipeMsgSetting,
        disabled = PAMenuFunctions.PALoot.isUnknownRecipeMsgDisabled,
        default = PAMenuDefaults.PALoot.LootRecipes.unknownRecipeMsg,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPALLootMotifsSubmenuTable()
    PALLootMotifsSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG),
        tooltip = GetString(SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG_T),
        getFunc = PAMenuFunctions.PALoot.getUnknownMotifMsgSetting,
        setFunc = PAMenuFunctions.PALoot.setUnknownMotifMsgSetting,
        disabled = PAMenuFunctions.PALoot.isUnknownMotifMsgDisabled,
        default = PAMenuDefaults.PALoot.LootMotifs.unknownMotifMsg,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPALLootApparelWeaponsSubmenuTable()
    PALLootApparelWeaponsSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG),
        tooltip = GetString(SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG_T),
        getFunc = PAMenuFunctions.PALoot.getUnknownTraitMsgSetting,
        setFunc = PAMenuFunctions.PALoot.setUnknownTraitMsgSetting,
        disabled = PAMenuFunctions.PALoot.isUnknownTraitMsgDisabled,
        default = PAMenuDefaults.PALoot.LootApparelWeapons.unknownTraitMsg,
    })
end

-- =================================================================================================================

local function createOptions()
    _createPALootMenu()

    _createPALLootRecipesSubmenuTable()
    _createPALLootMotifsSubmenuTable()
    _createPALLootApparelWeaponsSubmenuTable()

    LAM2:RegisterAddonPanel("PersonalAssistantLootAddonOptions", PALootPanelData)
    LAM2:RegisterOptionControls("PersonalAssistantLootAddonOptions", PALootOptionsTable)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Loot = PA.Loot or {}
PA.Loot.createOptions = createOptions
