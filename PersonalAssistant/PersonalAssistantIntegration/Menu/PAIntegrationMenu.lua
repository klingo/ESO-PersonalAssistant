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
local PAIFCOISGearSetsSubmenuTable = setmetatable({}, { __index = table })
local PAIFCOISDynamicIconsSubmenuTable = setmetatable({}, { __index = table })

local paBankingRequiredText = PA.MenuFunctions.getTextIfRequiredAddonNotRunning(SI_PA_MENU_INTEGRATION_PAB_REQUIRED, PA.Banking)
local paJunkRequiredText = PA.MenuFunctions.getTextIfRequiredAddonNotRunning(SI_PA_MENU_INTEGRATION_PAJ_REQUIRED, PA.Junk)

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
    if not WritCreater and not PA.Libs.FCOItemSaver.isFCOISLoadedProperly() then
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

        if PA.Banking then
            PAIntegrationOptionsTable:insert({
                type = "checkbox",
                name = GetString(SI_PA_MENU_INTEGRATION_LWC_COMPATIBILITY),
                tooltip = GetString(SI_PA_MENU_INTEGRATION_LWC_COMPATIBILITY_T),
                getFunc = PAIMenuFunctions.getLazyWritCrafterCompatibilitySetting,
                setFunc = PAIMenuFunctions.setLazyWritCrafterCompatibilitySetting,
                disabled = PAIMenuFunctions.isLazyWritCrafterCompatibilityDisabled,
                default = PAIMenuDefaults.LazyWritCrafter.compatibility,
            })
        else
            PAIntegrationOptionsTable:insert({
                type = "description",
                text = paBankingRequiredText
            })
        end
    end

    -- -----------------------------------------------------------------------------------------------------------------
    -- check if player has the addon [FCO ItemSaver]
    if PA.Libs.FCOItemSaver.isFCOISLoadedProperly() then
        -- try to get relevant FCOIS texts directly from FCOIS localization
        local FCOIS_LOCALIZATION = FCOIS.localizationVars.localizationAll[FCOIS.settingsVars.defaultSettings.language] or {}

        PAIntegrationOptionsTable:insert({
            type = "header",
            name = PAC.COLOR.YELLOW:Colorize(GetString(SI_PA_MENU_INTEGRATION_FCOIS_HEADER))
        })

        PAIntegrationOptionsTable:insert({
            type = "submenu",
            name = table.concat({PAC.ICONS.FCOIS.LOCKED.LARGE, FCOIS_LOCALIZATION["options_icon1_tooltip_text"]}),
            controls = PAIFCOISLockedSubmenuTable,
            disabledLabel = PAIMenuFunctions.isFCOISLockedMenuDisabled,
        })

        PAIntegrationOptionsTable:insert({
            type = "submenu",
            name = table.concat({PAC.ICONS.FCOIS.SELL.LARGE, FCOIS_LOCALIZATION["options_icon5_tooltip_text"]}),
            controls = PAIFCOISSellSubmenuTable,
            disabledLabel = PAIMenuFunctions.isFCOISSellMenuDisabled,
        })

        PAIntegrationOptionsTable:insert({
            type = "submenu",
            name = table.concat({PAC.ICONS.FCOIS.DECONSTRUCTION.LARGE, FCOIS_LOCALIZATION["options_icon9_tooltip_text"]}),
            controls = PAIFCOISDeconstructionSubmenuTable,
            disabledLabel = PAIMenuFunctions.isFCOISDeconstructionMenuDisabled,
        })

        PAIntegrationOptionsTable:insert({
            type = "submenu",
            name = table.concat({PAC.ICONS.FCOIS.IMPROVEMENT.LARGE, FCOIS_LOCALIZATION["options_icon10_tooltip_text"]}),
            controls = PAIFCOISImprovementSubmenuTable,
            disabledLabel = PAIMenuFunctions.isFCOISImprovementMenuDisabled,
        })

        PAIntegrationOptionsTable:insert({
            type = "submenu",
            name = table.concat({PAC.ICONS.FCOIS.RESEARCH.LARGE, FCOIS_LOCALIZATION["options_icon3_tooltip_text"]}),
            controls = PAIFCOISResearchSubmenuTable,
            disabledLabel = PAIMenuFunctions.isFCOISResearchMenuDisabled,
        })

        PAIntegrationOptionsTable:insert({
            type = "submenu",
            name = table.concat({"  ", PAC.ICONS.FCOIS.SELL_AT_GUILDSTORE.LARGE, " ", FCOIS_LOCALIZATION["options_icon11_tooltip_text"]}),
            controls = PAIFCOISSellGuildStoreSubmenuTable,
            disabledLabel = PAIMenuFunctions.isFCOISSellGuildStoreMenuDisabled,
        })

        PAIntegrationOptionsTable:insert({
            type = "submenu",
            name = table.concat({PAC.ICONS.FCOIS.INTRICATE.LARGE, FCOIS_LOCALIZATION["options_icon12_tooltip_text"]}),
            controls = PAIFCOISIntricateSubmenuTable,
            disabledLabel = PAIMenuFunctions.isFCOISIntricateMenuDisabled,
        })

        PAIntegrationOptionsTable:insert({
            type = "description",
            text = GetString(SI_PA_MENU_INTEGRATION_MORE_TO_COME),
        })

        -- Gear Sets 1..5
        --PAIntegrationOptionsTable:insert({
        --    type = "submenu",
        --    name = FCOIS_LOCALIZATION["options_icons_gears"],
        --    controls = PAIFCOISGearSetsSubmenuTable,
        --    disabledLabel = PAIMenuFunctions.isFCOISGearSetsMenuDisabled,
        --})

        -- Dynamic Icons 1..30
        --PAIntegrationOptionsTable:insert({
        --    type = "submenu",
        --    name = FCOIS_LOCALIZATION["options_icons_dynamic"],
        --    controls = PAIFCOISDynamicIconsSubmenuTable,
        --    disabledLabel = PAIMenuFunctions.isFCOISDynamicIconsMenuDisabled,
        --})
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
    if PA.Junk then
        PAIFCOISLockedSubmenuTable:insert({
            type = "checkbox",
            name = GetString(SI_PA_MENU_INTEGRATION_FCOIS_LOCKED_PREVENT_SELLING),
            getFunc = PAIMenuFunctions.getFCOISLockedPreventAutoSellSetting,
            setFunc = PAIMenuFunctions.setFCOISLockedPreventAutoSellSetting,
            disabled = PAIMenuFunctions.isFCOISLockedPreventAutoSellDisabled,
            default = PAIMenuDefaults.FCOItemSaver.Locked.preventAutoSell,
        })
    else
        PAIFCOISLockedSubmenuTable:insert({
            type = "description",
            text = paJunkRequiredText
        })
    end

    if PA.Banking then
        PAIFCOISLockedSubmenuTable:insert({
            type = "checkbox",
            name = GetString(SI_PA_MENU_INTEGRATION_FCOIS_LOCKED_PREVENT_MOVING),
            tooltip = GetString(SI_PA_MENU_INTEGRATION_FCOIS_LOCKED_PREVENT_MOVING_T),
            getFunc = PAIMenuFunctions.getFCOISLockedPreventMovingSetting,
            setFunc = PAIMenuFunctions.setFCOISLockedPreventMovingSetting,
            disabled = PAIMenuFunctions.isFCOISLockedPreventMovingDisabled,
            default = PAIMenuDefaults.FCOItemSaver.Locked.preventMoving,
        })
    else
        PAIFCOISLockedSubmenuTable:insert({
            type = "description",
            text = paBankingRequiredText
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAIFCOISResearchSubmenuTable()
    if PA.Banking then
        local PABMenuChoices = PA.MenuChoices.choices.PABanking
        local PABMenuChoicesValues = PA.MenuChoices.choicesValues.PABanking

        PAIFCOISResearchSubmenuTable:insert({
            type = "dropdown",
            name = GetString(SI_PA_MENU_INTEGRATION_FCOIS_ITEM_MOVE_MARKED),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = PAIMenuFunctions.getFCOISResearchItemMoveModeSetting,
            setFunc = PAIMenuFunctions.setFCOISResearchItemMoveModeSetting,
            disabled = PAIMenuFunctions.isFCOISResearchItemMoveModeDisabled,
            default = PAIMenuDefaults.FCOItemSaver.Research.itemMoveMode,
        })
    else
        PAIFCOISResearchSubmenuTable:insert({
            type = "description",
            text = paBankingRequiredText
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAIFCOISSellSubmenuTable()
    if PA.Junk then
        PAIFCOISSellSubmenuTable:insert({
            type = "checkbox",
            name = GetString(SI_PA_MENU_INTEGRATION_FCOIS_SELL_AUTOSELL_MARKED),
            getFunc = PAIMenuFunctions.getFCOISSellAutoSellMarkedSetting,
            setFunc = PAIMenuFunctions.setFCOISSellAutoSellMarkedSetting,
            disabled = PAIMenuFunctions.isFCOISSellAutoSellMarkedDisabled,
            default = PAIMenuDefaults.FCOItemSaver.Sell.autoSellMarked,
        })
    else
        PAIFCOISSellSubmenuTable:insert({
            type = "description",
            text = paJunkRequiredText
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAIFCOISDeconstructionSubmenuTable()
    if PA.Banking then
        local PABMenuChoices = PA.MenuChoices.choices.PABanking
        local PABMenuChoicesValues = PA.MenuChoices.choicesValues.PABanking

        PAIFCOISDeconstructionSubmenuTable:insert({
          type = "dropdown",
          name = GetString(SI_PA_MENU_INTEGRATION_FCOIS_ITEM_MOVE_MARKED),
          choices = PABMenuChoices.itemMoveMode,
          choicesValues = PABMenuChoicesValues.itemMoveMode,
          getFunc = PAIMenuFunctions.getFCOISDeconstructionItemMoveModeSetting,
          setFunc = PAIMenuFunctions.setFCOISDeconstructionItemMoveModeSetting,
          disabled = PAIMenuFunctions.isFCOISDeconstructionItemMoveModeDisabled,
          default = PAIMenuDefaults.FCOItemSaver.Deconstruction.itemMoveMode,
      })
    else
        PAIFCOISDeconstructionSubmenuTable:insert({
          type = "description",
          text = paBankingRequiredText
      })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAIFCOISImprovementSubmenuTable()
    if PA.Banking then
        local PABMenuChoices = PA.MenuChoices.choices.PABanking
        local PABMenuChoicesValues = PA.MenuChoices.choicesValues.PABanking

        PAIFCOISImprovementSubmenuTable:insert({
            type = "dropdown",
            name = GetString(SI_PA_MENU_INTEGRATION_FCOIS_ITEM_MOVE_MARKED),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = PAIMenuFunctions.getFCOISImprovementItemMoveModeSetting,
            setFunc = PAIMenuFunctions.setFCOISImprovementItemMoveModeSetting,
            disabled = PAIMenuFunctions.isFCOISImprovementItemMoveModeDisabled,
            default = PAIMenuDefaults.FCOItemSaver.Improvement.itemMoveMode,
        })
    else
        PAIFCOISImprovementSubmenuTable:insert({
            type = "description",
            text = paBankingRequiredText
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAIFCOISSellGuildStoreSubmenuTable()
    if PA.Banking then
        local PABMenuChoices = PA.MenuChoices.choices.PABanking
        local PABMenuChoicesValues = PA.MenuChoices.choicesValues.PABanking

        PAIFCOISSellGuildStoreSubmenuTable:insert({
            type = "dropdown",
            name = GetString(SI_PA_MENU_INTEGRATION_FCOIS_ITEM_MOVE_MARKED),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = PAIMenuFunctions.getFCOISSellGuildStoreItemMoveModeSetting,
            setFunc = PAIMenuFunctions.setFCOISSellGuildStoreItemMoveModeSetting,
            disabled = PAIMenuFunctions.isFCOISSellGuildStoreItemMoveModeDisabled,
            default = PAIMenuDefaults.FCOItemSaver.SellGuildStore.itemMoveMode,
        })
    else
        PAIFCOISSellGuildStoreSubmenuTable:insert({
            type = "description",
            text = paBankingRequiredText
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAIFCOISIntricateSubmenuTable()
    if PA.Banking then
        local PABMenuChoices = PA.MenuChoices.choices.PABanking
        local PABMenuChoicesValues = PA.MenuChoices.choicesValues.PABanking

        PAIFCOISIntricateSubmenuTable:insert({
            type = "dropdown",
            name = GetString(SI_PA_MENU_INTEGRATION_FCOIS_ITEM_MOVE_MARKED),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = PAIMenuFunctions.getFCOISIntricateItemMoveModeSetting,
            setFunc = PAIMenuFunctions.setFCOISIntricateItemMoveModeSetting,
            disabled = PAIMenuFunctions.isFCOISIntricateItemMoveModeDisabled,
            default = PAIMenuDefaults.FCOItemSaver.Intricate.itemMoveMode,
        })
    else
        PAIFCOISIntricateSubmenuTable:insert({
            type = "description",
            text = paBankingRequiredText
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAIFCOISGearSetsSubmenuTable()

end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPAIFCOISDynamicIconsSubmenuTable()

end

-- =================================================================================================================

local function createOptions()
    _createPAIntegrationMenu()

    _createPAIntegrationProfileSubMenuTable()

    if PA.Libs.FCOItemSaver.isFCOISLoadedProperly() then
        _createPAIFCOISLockedSubmenuTable()
        _createPAIFCOISResearchSubmenuTable()
        _createPAIFCOISSellSubmenuTable()
        _createPAIFCOISDeconstructionSubmenuTable()
        _createPAIFCOISImprovementSubmenuTable()
        _createPAIFCOISSellGuildStoreSubmenuTable()
        _createPAIFCOISIntricateSubmenuTable()
        _createPAIFCOISGearSetsSubmenuTable()
        _createPAIFCOISDynamicIconsSubmenuTable()
    end

    PA.LAM2:RegisterAddonPanel("PersonalAssistantIntegrationAddonOptions", PAIntegrationPanelData)
    PA.LAM2:RegisterOptionControls("PersonalAssistantIntegrationAddonOptions", PAIntegrationOptionsTable)
end

-- =====================================================================================================================
-- Export
PA.Integration = PA.Integration or {}
PA.Integration.createOptions = createOptions
