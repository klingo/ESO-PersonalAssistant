-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACAddon = PAC.ADDON
local PAHF = PA.HelperFunctions
local PAMH = PA.MenuHelper
local PAGMenuFunctions = PA.MenuFunctions.PAGeneral
local PAIMenuChoices = PA.MenuChoices.choices.PAIntegration
local PAIMenuChoicesValues = PA.MenuChoices.choicesValues.PAIntegration
local PAIMenuChoiceTooltip = PA.MenuChoices.choicesTooltips.PAIntegration
local PAIMenuDefaults = PA.MenuDefaults.PAIntegration
local PAIMenuFunctions = PA.MenuFunctions.PAIntegration

-- Create the LibAddonMenu2 object
PA.LAM2 = PA.LAM2 or LibAddonMenu2 or LibStub("LibAddonMenu-2.0")

local PAIntegrationPanelData = {
    type = "panel",
    name = PACAddon.NAME_RAW.INTEGRATION,
    displayName = PACAddon.NAME_DISPLAY.INTEGRATION,
    author = PACAddon.AUTHOR,
    version = PACAddon.VERSION_DISPLAY,
    website = PACAddon.WEBSITE,
    feedback = PACAddon.FEEDBACK,
    keywords = PACAddon.KEYWORDS.INTEGRATION,
    slashCommand = "/pai",
    registerForRefresh = true,
    registerForDefaults = true,
}

local PAIntegrationOptionsTable = setmetatable({}, { __index = table })

local PAIFCOISLockedSubmenuTable = setmetatable({}, { __index = table })
local PAIFCOISResearchSubmenuTable = setmetatable({}, { __index = table })
local PAIFCOISSellSubmenuTable = setmetatable({}, { __index = table })
local PAIFCOISDeconstructionSubmenuTable = setmetatable({}, { __index = table })
local PAIFCOISImprovementSubmenuTable = setmetatable({}, { __index = table })
local PAIFCOISSellGuildStoreSubmenuTable = setmetatable({}, { __index = table })
local PAIFCOISIntricateSubmenuTable = setmetatable({}, { __index = table })


-- =================================================================================================================

local function _createPAIntegrationMenu()
    PAIntegrationOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_INTEGRATION_DESCRIPTION),
    })

    -- -----------------------------------------------------------------------------------------------------------------
    -- check if player has the addon [Dolgubon's Lazy Writ Crafter]
    if WritCreater then
        PAIntegrationOptionsTable:insert({
            type = "header",
            name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_INTEGRATION_LWC_HEADER))
        })

        -- has a dependency to PABanking
        if not PA.Banking then
            -- inform player about missing dependency
            PAIntegrationOptionsTable:insert({
                type = "description",
                text = GetString(SI_PA_MENU_INTEGRATION_LWC_PRECONDITION),
            })
        end

        PAIntegrationOptionsTable:insert({
            type = "checkbox",
            name = GetString(SI_PA_MENU_INTEGRATION_LWC_COMPATIBILITY),
            tooltip = GetString(SI_PA_MENU_INTEGRATION_LWC_COMPATIBILITY_T),
            getFunc = PAIMenuFunctions.getLazyWritCrafterCompatibilitySetting,
            setFunc = PAIMenuFunctions.setLazyWritCrafterCompatibilitySetting,
            disabled = PAIMenuFunctions.isLazyWritCrafterCompatibilityDisabled,
            default = PAIMenuDefaults.LazyWritCrafter.compatibility,
        })
    end

    -- -----------------------------------------------------------------------------------------------------------------
    -- check if player has the addon [FCO ItemSaver]
    if FCOIS then
        -- try to get relevant FCOIS texts directly from FCOIS localization
        local FCOIS_LOCALIZATION = FCOIS.localizationVars.localizationAll[FCOIS.settingsVars.defaultSettings.language] or {}

        PAIntegrationOptionsTable:insert({
            type = "header",
            name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_INTEGRATION_FCOIS_HEADER))
        })

        -- TODO: add note/disclaimer

        -- TODO: add description how the submenus work

        PAIntegrationOptionsTable:insert({
            type = "submenu",
            name = FCOIS_LOCALIZATION["options_icon1_tooltip_text"],
            icon = PAC.ICONS.FCOIS.LOCKED.PATH,
            iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.LARGE,
            controls = PAIFCOISLockedSubmenuTable,
            disabledLabel = PAIMenuFunctions.isFCOISLockedMenuDisabled,
        })

        PAIntegrationOptionsTable:insert({
            type = "submenu",
            name = FCOIS_LOCALIZATION["options_icon3_tooltip_text"],
            icon = PAC.ICONS.FCOIS.RESEARCH.PATH,
            iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.LARGE,
            controls = PAIFCOISResearchSubmenuTable,
            disabledLabel = PAIMenuFunctions.isFCOISResearchMenuDisabled,
        })

        PAIntegrationOptionsTable:insert({
            type = "submenu",
            name = FCOIS_LOCALIZATION["options_icon5_tooltip_text"],
            icon = PAC.ICONS.FCOIS.SELL.PATH,
            iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.LARGE,
            controls = PAIFCOISSellSubmenuTable,
            disabledLabel = PAIMenuFunctions.isFCOISSellMenuDisabled,
        })

        PAIntegrationOptionsTable:insert({
            type = "submenu",
            name = FCOIS_LOCALIZATION["options_icon9_tooltip_text"],
            icon = PAC.ICONS.FCOIS.DECONSTRUCTION.PATH,
            iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.LARGE,
            controls = PAIFCOISDeconstructionSubmenuTable,
            disabledLabel = PAIMenuFunctions.isFCOISDeconstructionMenuDisabled,
        })

        PAIntegrationOptionsTable:insert({
            type = "submenu",
            name = FCOIS_LOCALIZATION["options_icon10_tooltip_text"],
            icon = PAC.ICONS.FCOIS.IMPROVEMENT.PATH,
            iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.LARGE,
            controls = PAIFCOISImprovementSubmenuTable,
            disabledLabel = PAIMenuFunctions.isFCOISImprovementMenuDisabled,
        })

        PAIntegrationOptionsTable:insert({
            type = "submenu",
            name = FCOIS_LOCALIZATION["options_icon11_tooltip_text"],
            icon = ZO_CURRENCIES_DATA[CURT_MONEY].keyboardTexture,
            controls = PAIFCOISSellGuildStoreSubmenuTable,
            disabledLabel = PAIMenuFunctions.isFCOISSellGuildStoreMenuDisabled,
        })

        PAIntegrationOptionsTable:insert({
            type = "submenu",
            name = FCOIS_LOCALIZATION["options_icon12_tooltip_text"],
            icon = PAC.ICONS.FCOIS.INTRICATE.PATH,
            iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.LARGE,
            controls = PAIFCOISIntricateSubmenuTable,
            disabledLabel = PAIMenuFunctions.isFCOISIntricateMenuDisabled,
        })
    end
end

-- =================================================================================================================

local function _createPAIFCOISLockedSubmenuTable()

end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAIFCOISResearchSubmenuTable()

end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAIFCOISSellSubmenuTable()

    -- CHECKBOX -> auto sell at merchant and fences (treat the same way like Junk --> PAJunk required)

    PAIFCOISSellSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_INTEGRATION_FCOIS_SELL_AUTOSELL_MARKED),
        warning = PAMH.getTextIfRequiredAddonNotRunning(SI_PA_MENU_INTEGRATION_PAJ_REQUIRED, PA.Junk),
        getFunc = PAIMenuFunctions.getFCOISSellAutoSellMarkedSetting,
        setFunc = PAIMenuFunctions.setFCOISSellAutoSellMarkedSetting,
        disabled = PAIMenuFunctions.isFCOISSellAutoSellMarkedDisabled,
        default = PAIMenuDefaults.FCOItemSaver.Sell.autoSellMarked,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAIFCOISDeconstructionSubmenuTable()

end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAIFCOISImprovementSubmenuTable()

end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAIFCOISSellGuildStoreSubmenuTable()

end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAIFCOISIntricateSubmenuTable()

    --> DROPDOWN -> Do nothing, Deposit to Bank, Withdraw to backpack --> PABanking required

end

-- =================================================================================================================

local function createOptions()
    _createPAIntegrationMenu()

    if FCOIS then
        _createPAIFCOISLockedSubmenuTable()
        _createPAIFCOISResearchSubmenuTable()
        _createPAIFCOISSellSubmenuTable()
        _createPAIFCOISDeconstructionSubmenuTable()
        _createPAIFCOISImprovementSubmenuTable()
        _createPAIFCOISSellGuildStoreSubmenuTable()
        _createPAIFCOISIntricateSubmenuTable()
    end

    PA.LAM2:RegisterAddonPanel("PersonalAssistantIntegrationAddonOptions", PAIntegrationPanelData)
    PA.LAM2:RegisterOptionControls("PersonalAssistantIntegrationAddonOptions", PAIntegrationOptionsTable)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Integration = PA.Integration or {}
PA.Integration.createOptions = createOptions
