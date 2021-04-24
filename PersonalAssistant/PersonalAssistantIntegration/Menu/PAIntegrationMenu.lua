-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACAddon = PAC.ADDON
local PAIProfileManager = PA.ProfileManager.PAIntegration
local PAIMenuDefaults = PA.MenuDefaults.PAIntegration
local PAIMenuFunctions = PA.MenuFunctions.PAIntegration

-- =====================================================================================================================

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
local PAIntegrationProfileSubMenuTable = setmetatable({}, { __index = table })

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
        type = "submenu",
        name = PAIProfileManager.getProfileSubMenuHeader,
        controls = PAIntegrationProfileSubMenuTable
    })

    PAIntegrationOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_INTEGRATION_DESCRIPTION),
    })

    -- -----------------------------------------------------------------------------------------------------------------
    if not WritCreater and not FCOIS then
        -- inform player that there ar eno integrations available
        PAIntegrationOptionsTable:insert({
            type = "divider",
            alpha = 0.5,
        })

        PAIntegrationOptionsTable:insert({
            type = "description",
            text = PAC.COLOR.ORANGE:Colorize(GetString(SI_PA_MENU_INTEGRATION_NOTHING_AVAILABLE)),
        })
    end

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
            warning = PA.MenuFunctions.getTextIfRequiredAddonNotRunning(SI_PA_MENU_INTEGRATION_PAB_REQUIRED, PA.Banking),
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

        -- has a dependency to PAJunk
        if not PA.Junk then
            -- inform player about missing dependency
            PAIntegrationOptionsTable:insert({
                type = "description",
                text = GetString(SI_PA_MENU_INTEGRATION_FCOIS_PRECONDITION),
            })
        end

        PAIntegrationOptionsTable:insert({
            type = "submenu",
            name = table.concat({PAC.ICONS.FCOIS.LOCKED.LARGE, FCOIS_LOCALIZATION["options_icon1_tooltip_text"]}),
            controls = PAIFCOISLockedSubmenuTable,
            disabledLabel = PAIMenuFunctions.isFCOISLockedMenuDisabled,
        })

--        PAIntegrationOptionsTable:insert({
--            type = "submenu",
--            name = FCOIS_LOCALIZATION["options_icon3_tooltip_text"],
--            icon = PAC.ICONS.FCOIS.RESEARCH.PATH,
--            iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.LARGE,
--            controls = PAIFCOISResearchSubmenuTable,
--            disabledLabel = PAIMenuFunctions.isFCOISResearchMenuDisabled,
--        })

        PAIntegrationOptionsTable:insert({
            type = "submenu",
            name = table.concat({PAC.ICONS.FCOIS.SELL.LARGE, FCOIS_LOCALIZATION["options_icon5_tooltip_text"]}),
            controls = PAIFCOISSellSubmenuTable,
            disabledLabel = PAIMenuFunctions.isFCOISSellMenuDisabled,
        })

--        PAIntegrationOptionsTable:insert({
--            type = "submenu",
--            name = FCOIS_LOCALIZATION["options_icon9_tooltip_text"],
--            icon = PAC.ICONS.FCOIS.DECONSTRUCTION.PATH,
--            iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.LARGE,
--            controls = PAIFCOISDeconstructionSubmenuTable,
--            disabledLabel = PAIMenuFunctions.isFCOISDeconstructionMenuDisabled,
--        })
--
--        PAIntegrationOptionsTable:insert({
--            type = "submenu",
--            name = FCOIS_LOCALIZATION["options_icon10_tooltip_text"],
--            icon = PAC.ICONS.FCOIS.IMPROVEMENT.PATH,
--            iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.LARGE,
--            controls = PAIFCOISImprovementSubmenuTable,
--            disabledLabel = PAIMenuFunctions.isFCOISImprovementMenuDisabled,
--        })
--
--        PAIntegrationOptionsTable:insert({
--            type = "submenu",
--            name = table.concat({"  ", PAC.ICONS.FCOIS.SELL_AT_GUILDSTORE.LARGE, " ", FCOIS_LOCALIZATION["options_icon11_tooltip_text"]}),
--            controls = PAIFCOISSellGuildStoreSubmenuTable,
--            disabledLabel = PAIMenuFunctions.isFCOISSellGuildStoreMenuDisabled,
--        })
--
--        PAIntegrationOptionsTable:insert({
--            type = "submenu",
--            name = FCOIS_LOCALIZATION["options_icon12_tooltip_text"],
--            icon = PAC.ICONS.FCOIS.INTRICATE.PATH,
--            iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.LARGE,
--            controls = PAIFCOISIntricateSubmenuTable,
--            disabledLabel = PAIMenuFunctions.isFCOISIntricateMenuDisabled,
--        })

        PAIntegrationOptionsTable:insert({
            type = "description",
            text = GetString(SI_PA_MENU_INTEGRATION_MORE_TO_COME),
        })
    end
end

-- =================================================================================================================

local function _createPAIntegrationProfileSubMenuTable()
    PAIntegrationProfileSubMenuTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_PROFILE_ACTIVE),
        tooltip = GetString(SI_PA_MENU_PROFILE_ACTIVE_T),
        choices = PAIProfileManager.getProfileList(),
        choicesValues = PAIProfileManager.getProfileListValues(),
        width = "half",
        getFunc = PAIProfileManager.getActiveProfile,
        setFunc = PAIProfileManager.setActiveProfile,
        reference = "PERSONALASSISTANT_INTEGRATION_PROFILEDROPDOWN"
    })

    PAIntegrationProfileSubMenuTable:insert({
        type = "editbox",
        name = GetString(SI_PA_MENU_PROFILE_ACTIVE_RENAME),
        maxChars = 40,
        width = "half",
        getFunc = PAIProfileManager.getActiveProfileName,
        setFunc = PAIProfileManager.setActiveProfileName,
        disabled = PAIProfileManager.isNoProfileSelected
    })

    PAIntegrationProfileSubMenuTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_PROFILE_CREATE_NEW),
        width = "half",
        func = PAIProfileManager.createNewProfile,
        disabled = PAIProfileManager.hasMaxProfileCountReached
    })

    PAIntegrationProfileSubMenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_PROFILE_CREATE_NEW_DESC),
        disabled = function() return not PAIProfileManager.hasMaxProfileCountReached() end
    })

    PAIntegrationProfileSubMenuTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PAIntegrationProfileSubMenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_PROFILE_COPY_FROM_DESC),
        disabled = function() return PAIProfileManager.hasOnlyOneProfile() or PAIProfileManager.isNoProfileSelected() end,
    })

    PAIntegrationProfileSubMenuTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_PROFILE_COPY_FROM),
        choices = PAIProfileManager.getInactiveProfileList(),
        choicesValues = PAIProfileManager.getInactiveProfileListValues(),
        width = "half",
        getFunc = function() return PA.Integration.selectedCopyProfile end,
        setFunc = function(value) PA.Integration.selectedCopyProfile = value end,
        disabled = function() return PAIProfileManager.hasOnlyOneProfile() or PAIProfileManager.isNoProfileSelected() end,
        reference = "PERSONALASSISTANT_INTEGRATION_PROFILEDROPDOWN_COPY"
    })

    PAIntegrationProfileSubMenuTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM),
        width = "half",
        func = PAIProfileManager.copySelectedProfile,
        isDangerous = true,
        warning = GetString(SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM_W),
        disabled = PAIProfileManager.isNoCopyProfileSelected
    })

    PAIntegrationProfileSubMenuTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PAIntegrationProfileSubMenuTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_PROFILE_DELETE_DESC),
        disabled = PAIProfileManager.hasOnlyOneProfile
    })

    PAIntegrationProfileSubMenuTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_PROFILE_DELETE),
        choices = PAIProfileManager.getInactiveProfileList(),
        choicesValues = PAIProfileManager.getInactiveProfileListValues(),
        width = "half",
        getFunc = function() return PA.Integration.selectedDeleteProfile end,
        setFunc = function(value) PA.Integration.selectedDeleteProfile = value end,
        disabled = PAIProfileManager.hasOnlyOneProfile,
        reference = "PERSONALASSISTANT_INTEGRATION_PROFILEDROPDOWN_DELETE"
    })

    PAIntegrationProfileSubMenuTable:insert({
        type = "button",
        name = GetString(SI_PA_MENU_PROFILE_DELETE_CONFIRM),
        width = "half",
        func = PAIProfileManager.deleteSelectedProfile,
        isDangerous = true,
        warning = GetString(SI_PA_MENU_PROFILE_DELETE_CONFIRM_W),
        disabled = PAIProfileManager.isNoDeleteProfileSelected
    })
end

-- =================================================================================================================

local function _createPAIFCOISLockedSubmenuTable()
    PAIFCOISLockedSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_INTEGRATION_FCOIS_LOCKED_PREVENT_SELLING),
        warning = PA.MenuFunctions.getTextIfRequiredAddonNotRunning(SI_PA_MENU_INTEGRATION_PAJ_REQUIRED, PA.Junk),
        getFunc = PAIMenuFunctions.getFCOISLockedPreventAutoSellSetting,
        setFunc = PAIMenuFunctions.setFCOISLockedPreventAutoSellSetting,
        disabled = PAIMenuFunctions.isFCOISLockedPreventAutoSellDisabled,
        default = PAIMenuDefaults.FCOItemSaver.Locked.preventAutoSell,
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAIFCOISResearchSubmenuTable()

end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAIFCOISSellSubmenuTable()
    PAIFCOISSellSubmenuTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_INTEGRATION_FCOIS_SELL_AUTOSELL_MARKED),
        warning = PA.MenuFunctions.getTextIfRequiredAddonNotRunning(SI_PA_MENU_INTEGRATION_PAJ_REQUIRED, PA.Junk),
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

    _createPAIntegrationProfileSubMenuTable()

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

-- =====================================================================================================================
-- Export
PA.Integration = PA.Integration or {}
PA.Integration.createOptions = createOptions
