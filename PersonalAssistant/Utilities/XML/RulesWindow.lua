-- Local instances of Global tables --
local PA = PersonalAssistant

-- ---------------------------------------------------------------------------------------------------------------------

local _RulesWindowSceneName = "PersonalAssistantRulesWindowScene"
local _RulesWindowSceneGroupName = "PersonalAssistantRuleWindowSceneGroup"
local _RulesWindowDescriptor = "PersonalAssistantRules"
local _RulesWindowBankingTabDescriptor = "PersonalAssistantBankingRules"
local _RulesWindowJunkTabDescriptor = "PersonalAssistantJunkRules"

local window = PersonalAssistantRulesWindow
local BankingRulesTabControl = window:GetNamedChild("BankingRulesTab")
local JunkRulesTabControl = window:GetNamedChild("JunkRulesTab")

-- store tha last shown tab (for current game session only)
local _lastShownRulesTabDescriptor

-- ---------------------------------------------------------------------------------------------------------------------

local function _showPABankingRulesTab()
    BankingRulesTabControl:SetHidden(false)
    JunkRulesTabControl:SetHidden(true)
end

local function _showPAJunkRulesTab()
    BankingRulesTabControl:SetHidden(true)
    JunkRulesTabControl:SetHidden(false)
end

local function _getDefaultRulesTabDescriptor()
    if PA.Banking then return _RulesWindowBankingTabDescriptor end
    if PA.Junk then return _RulesWindowJunkTabDescriptor end
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
    local TITLE_FRAGMENT = ZO_SetTitleFragment:New(SI_PA_MAINMENU_RULES_HEADER)
    PA_RULES_SCENE:AddFragment(TITLE_FRAGMENT)

    -- Add the XML to the scene
    local PA_RULES_FRAGMENT = ZO_FadeSceneFragment:New(window, false, 0)
    PA_RULES_FRAGMENT:RegisterCallback("StateChange", function(oldState, newState)
        if newState == SCENE_FRAGMENT_SHOWING then
            d("SCENE_FRAGMENT_SHOWING")
        elseif newState == SCENE_FRAGMENT_SHOWN then
            d("SCENE_FRAGMENT_SHOWN")
        elseif newState == SCENE_FRAGMENT_HIDING then
            d("SCENE_FRAGMENT_HIDING")
        elseif newState == SCENE_FRAGMENT_HIDDEN then
            d("SCENE_FRAGMENT_HIDDEN")
            ClearMenu()
        end
    end )
    PA_RULES_SCENE:AddFragment(PA_RULES_FRAGMENT)
end

local function _createTabsForScene()
    -- Register Scenes and the group name
    SCENE_MANAGER:AddSceneGroup(_RulesWindowSceneGroupName, ZO_SceneGroup:New(_RulesWindowSceneName))

    local RulesModeMenuBar = window:GetNamedChild("ModeMenuBar")
    local RulesModeMenuBarLabel = RulesModeMenuBar:GetNamedChild("Label")

    -- if PABanking is enabled, add the corresponding tab
    if PA.Banking then
        local creationData = {
            activeTabText = SI_PA_MAINMENU_BANKING_HEADER,
            categoryName = SI_PA_MAINMENU_BANKING_HEADER,
            descriptor = _RulesWindowBankingTabDescriptor,
            normal = "esoui/art/inventory/inventory_tabicon_crafting_up.dds",
            pressed = "esoui/art/inventory/inventory_tabicon_crafting_down.dds",
            highlight = "esoui/art/inventory/inventory_tabicon_crafting_over.dds",
            disabled = "esoui/art/inventory/inventory_tabicon_crafting_disabled.dds",
            callback = function()
                _showPABankingRulesTab()
                RulesModeMenuBarLabel:SetText(GetString(SI_PA_MAINMENU_BANKING_HEADER))
                _lastShownRulesTabDescriptor = _RulesWindowBankingTabDescriptor
            end,
        }
        ZO_MenuBar_AddButton(RulesModeMenuBar, creationData)
    end

    -- if PAJunk is enabled, add the corresponding tab
    if PA.Junk then
        local creationData = {
            activeTabText = SI_PA_MAINMENU_JUNK_HEADER,
            categoryName = SI_PA_MAINMENU_JUNK_HEADER,
            descriptor = _RulesWindowJunkTabDescriptor,
            normal = "esoui/art/inventory/inventory_tabicon_junk_up.dds",
            pressed = "esoui/art/inventory/inventory_tabicon_junk_down.dds",
            highlight = "esoui/art/inventory/inventory_tabicon_junk_over.dds",
            disabled = "esoui/art/inventory/inventory_tabicon_junk_disabled.dds",
            callback = function()
                _showPAJunkRulesTab()
                RulesModeMenuBarLabel:SetText(GetString(SI_PA_MAINMENU_JUNK_HEADER))
                _lastShownRulesTabDescriptor = _RulesWindowJunkTabDescriptor
            end,
        }

        ZO_MenuBar_AddButton(RulesModeMenuBar, creationData)
    end
end

local function _initLibMainMenu()
    -- Create the LibMainMenu object
    PA.LMM2 = PA.LMM2 or LibMainMenu2 or LibStub("LibMainMenu-2.0")
    PA.LMM2:Init()

    -- Add to main menu
    local categoryLayoutInfo =
    {
        binding = "PA_RULES_MENU",
        categoryName = SI_BINDING_NAME_PA_RULES_MAIN_MENU,
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

    local RulesModeMenuBar = window:GetNamedChild("ModeMenuBar")
    ZO_MenuBar_SelectDescriptor(RulesModeMenuBar, _lastShownRulesTabDescriptor or _getDefaultRulesTabDescriptor())
end

-- ---------------------------------------------------------------------------------------------------------------------

local function initRulesMainMenu()
    -- at least either PABanking or PAJunk must be acttive to create the MainMenu entry
    if PA.Banking or PA.Junk then
        -- Create the Main Scene
        _createRulesWindowScene()

        -- Create tabs for the scenes
        _createTabsForScene()

        -- Init LibMainMenu
        _initLibMainMenu()

        -- hide the "duplicate" divider from the ModeMenu
        local RulesModeMenuDivider = window:GetNamedChild("ModeMenuDivider")
        RulesModeMenuDivider:SetHidden(true)
    else
        PA.debugln("Neither PABanking nor PAJunk is active; don't display MainMenu entry")
    end
end


-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.CustomDialogs = PA.CustomDialogs or {}
PA.CustomDialogs.initRulesMainMenu = initRulesMainMenu