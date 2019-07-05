-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACAddon = PAC.ADDON
local PAHF = PA.HelperFunctions
local PAMenuHelper = PA.MenuHelper
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
        PAIntegrationOptionsTable:insert({
            type = "header",
            name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_INTEGRATION_FCOIS_HEADER))
        })
    end
end

-- =================================================================================================================

local function createOptions()
    _createPAIntegrationMenu()

    PA.LAM2:RegisterAddonPanel("PersonalAssistantIntegrationAddonOptions", PAIntegrationPanelData)
    PA.LAM2:RegisterOptionControls("PersonalAssistantIntegrationAddonOptions", PAIntegrationOptionsTable)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Integration = PA.Integration or {}
PA.Integration.createOptions = createOptions
