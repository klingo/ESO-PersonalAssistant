-- Local instances of Global tables --
local PA = PersonalAssistant

-- ---------------------------------------------------------------------------------------------------------------------

local _RulesWindowSceneName = "PersonalAssistantRulesWindowScene"
local _RulesWindowSceneGroupName = "PersonalAssistantRuleWindowSceneGroup"
local _RulesWindowDescriptor = "PersonalAssistantRules"
local _RulesWindowBankingDescriptor = "PersonalAssistantBankingRules"
local _RulesWindowJunkDescriptor = "PersonalAssistantJunkRules"

local BankingRulesControl = PersonalAssistantRulesWindow:GetNamedChild("BankingRules")
local JunkRulesControl = PersonalAssistantRulesWindow:GetNamedChild("JunkRules")

-- ---------------------------------------------------------------------------------------------------------------------

local function _usePABankingRulesWindow()
    BankingRulesControl:SetHidden(false)
    JunkRulesControl:SetHidden(true)
end

local function _usePAJunkRulesWindow()
    BankingRulesControl:SetHidden(true)
    JunkRulesControl:SetHidden(false)
end

local function _createRulesWindowScene()
    -- Main Scene
    local PA_RULES_SCENE = ZO_Scene:New(_RulesWindowSceneName, SCENE_MANAGER)

    -- Mouse standard position and background
    PA_RULES_SCENE:AddFragmentGroup(FRAGMENT_GROUP.MOUSE_DRIVEN_UI_WINDOW)
    PA_RULES_SCENE:AddFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_STANDARD_RIGHT_PANEL)

    -- Background Right, it will set ZO_RightPanelFootPrint and its stuff
    -- PABANKING_SCENE:AddFragment(RIGHT_PANEL_BG_FRAGMENT)
    PA_RULES_SCENE:AddFragment(RIGHT_BG_FRAGMENT)

    -- The sound to be played when opening the panel
    PA_RULES_SCENE:AddFragment(ZO_WindowSoundFragment:New(SOUNDS.BANK_WINDOW_OPEN, SOUNDS.BANK_WINDOW_CLOSE))

    -- The title fragment
    PA_RULES_SCENE:AddFragment(TITLE_FRAGMENT)

    -- Set Title
    ZO_CreateStringId("SI_PA_BANKING_MAIN_MENU_TITLE", "PersonalAssistant") -- TODO: extract - main title across all tabs
    local TITLE_FRAGMENT = ZO_SetTitleFragment:New(SI_PA_BANKING_MAIN_MENU_TITLE)
    PA_RULES_SCENE:AddFragment(TITLE_FRAGMENT)

    -- Add the XML to the scene
    local PA_RULES_FRAGMENT = ZO_FadeSceneFragment:New(PersonalAssistantRulesWindow, false, 0)
    PA_RULES_FRAGMENT:RegisterCallback("StateChange", function(oldState, newState)
        if newState == SCENE_FRAGMENT_SHOWING then
            d("SCENE_FRAGMENT_SHOWING")
        elseif newState == SCENE_FRAGMENT_SHOWN then
            d("SCENE_FRAGMENT_SHOWN")
        elseif newState == SCENE_FRAGMENT_HIDING then
            d("SCENE_FRAGMENT_HIDING")
        elseif newState == SCENE_FRAGMENT_HIDDEN then
            d("SCENE_FRAGMENT_HIDDEN")
        end
    end )
    PA_RULES_SCENE:AddFragment(PA_RULES_FRAGMENT)
end

local function _createTabsForScene()
    -- Register Scenes and the group name
    SCENE_MANAGER:AddSceneGroup(_RulesWindowSceneGroupName, ZO_SceneGroup:New(_RulesWindowSceneName))

    local PABModeMenuBarControl = PersonalAssistantRulesWindow:GetNamedChild("ModeMenuBar")
    local PABModeMenuBarLabelControl = PABModeMenuBarControl:GetNamedChild("Label")

    local function initPABankingRulesScene()
        local creationData = {
            activeTabText = SI_BINDING_NAME_PA_BANKING_RULES_MENU,
            categoryName = SI_BINDING_NAME_PA_BANKING_RULES_MENU,
            descriptor = _RulesWindowBankingDescriptor,
            normal = "esoui/art/inventory/inventory_tabicon_crafting_up.dds",
            pressed = "esoui/art/inventory/inventory_tabicon_crafting_down.dds",
            highlight = "esoui/art/inventory/inventory_tabicon_crafting_over.dds",
            disabled = "esoui/art/inventory/inventory_tabicon_crafting_disabled.dds",
            callback = function()
                -- TODO: save selection
                d("callback: PA Banking Rules")
                _usePABankingRulesWindow()
                PABModeMenuBarLabelControl:SetText(GetString(SI_BINDING_NAME_PA_BANKING_RULES_MENU))
            end,
        }
        ZO_MenuBar_AddButton(PABModeMenuBarControl, creationData)
    end

    local function initPAJunkRulesScene()
        local creationData = {
            activeTabText = SI_BINDING_NAME_PA_JUNK_RULES_MENU,
            categoryName = SI_BINDING_NAME_PA_JUNK_RULES_MENU,
            descriptor = _RulesWindowJunkDescriptor,
            normal = "esoui/art/inventory/inventory_tabicon_junk_up.dds",
            pressed = "esoui/art/inventory/inventory_tabicon_junk_down.dds",
            highlight = "esoui/art/inventory/inventory_tabicon_junk_over.dds",
            disabled = "esoui/art/inventory/inventory_tabicon_junk_disabled.dds",
            callback = function()
                -- TODO: save selection
                d("callback: PA Junk Rules")
                _usePAJunkRulesWindow()
                PABModeMenuBarLabelControl:SetText(GetString(SI_BINDING_NAME_PA_JUNK_RULES_MENU))
            end,
        }

        ZO_MenuBar_AddButton(PABModeMenuBarControl, creationData)
    end

    initPABankingRulesScene()
    initPAJunkRulesScene()
end

local function _initLibMainMenu()
    -- Create the LibMainMenu object
    PA.LMM2 = PA.LMM2 or LibMainMenu2 or LibStub("LibMainMenu-2.0")
    PA.LMM2:Init()

    -- Add to main menu
    local categoryLayoutInfo =
    {
        binding = "PA_RULES_MENU",
        categoryName = SI_BINDING_NAME_PA_RULES_MENU,
        callback = function(buttonData)
            if not SCENE_MANAGER:IsShowing(_RulesWindowSceneName) then
                SCENE_MANAGER:Show(_RulesWindowSceneName)
            else
                SCENE_MANAGER:ShowBaseScene()
            end
        end,
        visible = function(buttonData) return true end,

        normal = "esoui/art/inventory/inventory_tabicon_crafting_up.dds",
        pressed = "esoui/art/inventory/inventory_tabicon_crafting_down.dds",
        highlight = "esoui/art/inventory/inventory_tabicon_crafting_over.dds",
        disabled = "esoui/art/inventory/inventory_tabicon_crafting_disabled.dds",
    }

    PA.LMM2:AddMenuItem(_RulesWindowDescriptor, _RulesWindowSceneName, categoryLayoutInfo, nil)

    -- TODO: restore selection or descriptor
    local PABModeMenuBarControl = PersonalAssistantRulesWindow:GetNamedChild("ModeMenuBar")
    ZO_MenuBar_SelectDescriptor(PABModeMenuBarControl, _RulesWindowBankingDescriptor)
    --    ZO_MenuBar_SelectDescriptor(modeMenuBarControl, playerSettings.lastUsedTab or PotMaker.descriptorPotion)
end

-- ---------------------------------------------------------------------------------------------------------------------

local function initRulesMainMenu()
    -- Create the Main Scene
    _createRulesWindowScene()

    -- Create tabs for the scenes
    _createTabsForScene()

    -- Init LibMainMenu
    _initLibMainMenu()

    -- hide the "duplicate" divider
    PersonalAssistantRulesWindow:GetNamedChild("ModeMenuDivider"):SetHidden(true)
end


-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.CustomDialogs = PA.CustomDialogs or {}
PA.CustomDialogs.initRulesMainMenu = initRulesMainMenu