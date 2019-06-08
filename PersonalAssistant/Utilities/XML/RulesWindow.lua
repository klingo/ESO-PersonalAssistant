-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAHF = PA.HelperFunctions

local PABankingRulesList = ZO_SortFilterList:Subclass()

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

local function getBagNameAndOperatorTextFromOperatorId(operatorId)
    local operator = operatorId
    local bagName = PAHF.getBagName(BAG_BACKPACK)
    if operatorId >= PAC.OPERATOR.BANK_EQUAL then
        -- BAG = Bank
        bagName = PAHF.getBagName(BAG_BANK)
        operator = operatorId - 5
    end
    local operatorText = GetString("SI_PA_REL_OPERATOR", operator)
    return bagName, operatorText
end

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
            ClearTooltip(ItemTooltip)
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


-- --------------------------------------------------------------

local TYPE_ACTIVE_RULE = 1


function PABankingRulesList:UpdateScrollList()
    local scrollList = self.RecentScrollList
    local dataList = ZO_ScrollList_GetDataList(scrollList)

    ZO_ScrollList_Clear(scrollList)

    local PABCustomItemIds = PA.Banking.SavedVars.Custom.ItemIds
    for _, moveConfig in pairs(PABCustomItemIds) do
        local bagName, operatorText = getBagNameAndOperatorTextFromOperatorId(moveConfig.operator)
        d("bagName="..tostring(bagName))
        d("operatorText="..tostring(operatorText))
        local rowData = {
            bagName = bagName,
            mathOperator = operatorText,
            bagAmount = moveConfig.bagAmount,
            itemIcon = GetItemLinkInfo(moveConfig.itemLink),
            itemLink = moveConfig.itemLink,
        }
        dataList[#dataList + 1] = ZO_ScrollList_CreateDataEntry(TYPE_ACTIVE_RULE, rowData, 1) -- TODO: "1" is to define a category per dataEntry (can be hidden)
    end

    ZO_ScrollList_Commit(scrollList)
end

function PABankingRulesList:InitScrollList()
    local function onRowMouseEnter(rowControl)
--        hideRowHighlight(rowControl, false)
    end
    local function onRowMouseExit(rowControl)
--        hideRowHighlight(rowControl, true)
    end
    local function onItemNameMouseEnter(rowControl)
        InitializeTooltip(ItemTooltip, rowControl)
        ItemTooltip:SetLink(rowControl:GetText())
    end
    local function onItemNameMouseExit(rowControl)
        ClearTooltip(ItemTooltip)
    end

    local function setupDataRow(rowControl, rowData, scrollList)
        local bagNameControl = rowControl:GetNamedChild("BagName")
        bagNameControl:SetText(rowData.bagName)

        local mathOperatorControl = rowControl:GetNamedChild("MathOperator")
        mathOperatorControl:SetText(rowData.mathOperator)

        local bagAmountControl = rowControl:GetNamedChild("BagAmount")
        bagAmountControl:SetText(rowData.bagAmount)

        local itemIconControl = rowControl:GetNamedChild("ItemIcon")
        itemIconControl:SetTexture(rowData.itemIcon)

        local itemNameControl = rowControl:GetNamedChild("ItemName")
        itemNameControl:SetText(rowData.itemLink)
        itemNameControl:SetHandler("OnMouseEnter", onItemNameMouseEnter)
        itemNameControl:SetHandler("OnMouseExit", onItemNameMouseExit)

        rowControl:SetHandler("OnMouseEnter", onRowMouseEnter)
        rowControl:SetHandler("OnMouseExit", onRowMouseExit)
    end

--    ZO_SortFilterList.InitializeSortFilterList(self, BankingRulesTabControl)
--    self:SetAlternateRowBackgrounds(true)
--    self:SetAutomaticallyColorRows(true)
--    self:SetEmptyText("No custom rules defined") -- TODO: add localization

--    local list = ZO_SortFilterList:New(BankingRulesTabControl, PersonalAssistantRulesWindowBankingRulesTabList)
--    list:SetAlternateRowBackgrounds(true)
--    list:SetAutomaticallyColorRows(false)
--    list:SetEmptyText("No custom rules defined") -- TODO: add localization

    ZO_ScrollList_AddDataType(self.RecentScrollList, TYPE_ACTIVE_RULE, "PersonalAssistantBankingRuleListRowTemplate", 36, setupDataRow)

    -- does this even work?
    ZO_ScrollList_EnableHighlight(self.RecentScrollList, "ZO_ThinListHighlight")
end

function PABankingRulesList:InitHeaders()
    -- Initialise the headers
    local headers = BankingRulesTabControl:GetNamedChild("Headers")
    ZO_SortHeader_Initialize(headers:GetNamedChild("BagName"), GetString(SI_PA_MAINMENU_BANKING_HEADER_BAG), NO_SORT_KEY, ZO_SORT_ORDER_DOWN, TEXT_ALIGN_LEFT, "ZoFontHeader")
    ZO_SortHeader_Initialize(headers:GetNamedChild("MathOperator"), GetString(SI_PA_MAINMENU_BANKING_HEADER_OPERATOR), NO_SORT_KEY, ZO_SORT_ORDER_DOWN, TEXT_ALIGN_LEFT, "ZoFontHeader")
    ZO_SortHeader_Initialize(headers:GetNamedChild("BagAmount"), GetString(SI_PA_MAINMENU_BANKING_HEADER_AMOUNT), NO_SORT_KEY, ZO_SORT_ORDER_DOWN, TEXT_ALIGN_LEFT, "ZoFontHeader")
    ZO_SortHeader_Initialize(headers:GetNamedChild("ItemName"), GetString(SI_PA_MAINMENU_BANKING_HEADER_ITEM), NO_SORT_KEY, ZO_SORT_ORDER_DOWN, TEXT_ALIGN_LEFT, "ZoFontHeader")
    ZO_SortHeader_Initialize(headers:GetNamedChild("Actions"), GetString(SI_PA_MAINMENU_BANKING_HEADER_ACTIONS), NO_SORT_KEY, ZO_SORT_ORDER_DOWN, TEXT_ALIGN_LEFT, "ZoFontHeader")
end

function PABankingRulesList:SetupControls()
    local function RulesStateChange(oldState, newState)
        if newState == SCENE_FRAGMENT_SHOWING then
            d("UpdateScrollList()")
            self:UpdateScrollList()
        end
    end

    local headersControl = BankingRulesTabControl:GetNamedChild("Headers")

    self.RecentScrollList = WINDOW_MANAGER:CreateControlFromVirtual("$(parent)List", BankingRulesTabControl, "ZO_ScrollList")
    self.RecentScrollList:SetAnchor(TOPLEFT, headersControl, BOTTOMLEFT, 40, 0)
    self.RecentScrollList:SetAnchor(BOTTOMRIGHT, BankingRulesTabControl, BOTTOMRIGHT, 0, 0)

    self.rulesScene = SCENE_MANAGER:GetScene(_RulesWindowSceneName)
    self.rulesScene:RegisterCallback("StateChange", RulesStateChange)
end

function PABankingRulesList:Initialize()
    self:SetupControls()
    self:InitScrollList()
    self:InitHeaders()
end

-- --------------------------------------------------------------

local function _initPABankingRulesTab()
    -- Initialise the headers
    local headers = BankingRulesTabControl:GetNamedChild("Headers")
    -- TODO: add localization
    ZO_SortHeader_Initialize(headers:GetNamedChild("BagName"), "BagName", NO_SORT_KEY, ZO_SORT_ORDER_DOWN, TEXT_ALIGN_LEFT, "ZoFontHeader")
    ZO_SortHeader_Initialize(headers:GetNamedChild("MathOperator"), "MathOperator", NO_SORT_KEY, ZO_SORT_ORDER_DOWN, TEXT_ALIGN_LEFT, "ZoFontHeader")
    ZO_SortHeader_Initialize(headers:GetNamedChild("BagAmount"), "BagAmount", NO_SORT_KEY, ZO_SORT_ORDER_DOWN, TEXT_ALIGN_LEFT, "ZoFontHeader")
    ZO_SortHeader_Initialize(headers:GetNamedChild("ItemName"), "ItemName", NO_SORT_KEY, ZO_SORT_ORDER_DOWN, TEXT_ALIGN_LEFT, "ZoFontHeader")
    ZO_SortHeader_Initialize(headers:GetNamedChild("Actions"), "Actions", NO_SORT_KEY, ZO_SORT_ORDER_DOWN, TEXT_ALIGN_LEFT, "ZoFontHeader")

    -- Then initialise the sortable list
    local list = ZO_SortFilterList:New(BankingRulesTabControl, PersonalAssistantRulesWindowBankingRulesTabList)
    list:SetAlternateRowBackgrounds(true)
    list:SetAutomaticallyColorRows(false)
    list:SetEmptyText("No custom rules defined") -- TODO: add localization

    local function EnterRow(control)
        -- TODO: Todo
    end

    local function ExitRow(control)
        -- TODO: Todo
    end

    local ACTIVE_RULE = 1
    ZO_ScrollList_AddDataType(list.list, ACTIVE_RULE, "PersonalAssistantBankingRuleListRowTemplate", 36, function(control, data)
        list:SetupRow(control, data)
        control:SetHandler("OnMouseEnter", EnterRow)
        control:SetHandler("OnMouseExit", ExitRow)

        local bagNameControl = control:GetNamedChild("BagName")
        bagNameControl:SetText("Test BagName")

        local mathOperatorControl = control:GetNamedChild("MathOperator")
        mathOperatorControl:SetText("==")

        local bagAmountControl = control:GetNamedChild("BagAmount")
        bagAmountControl:SetText("100")

        local itemIconControl = control:GetNamedChild("ItemIcon")
        itemIconControl:SetTexture("EsoUI/Art/Miscellaneous/wait_icon.dds")

        local itemNameControl = control:GetNamedChild("ItemName")
        itemNameControl:SetText("Super Duper Item Name")
    end)
    ZO_ScrollList_EnableHighlight(list.list, "ZO_ThinListHighlight")

    -- populate the SrollList's rows
    function list.FilterScollList(list)
        local scrollData = ZO_ScrollList_GetDataList(list.list)
        ZO_ClearNumericallyIndexedTable(scrollData)

        -- TODO: add DATA
        local dataEntry = {

        }
        table.insert(scrollData, ZO_ScrollList_CreateDataEntry(ACTIVE_RULE, dataEntry))
    end


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

        if PA.Banking then
--            _initPABankingRulesTab()
            PABankingRulesList:Initialize()
        end

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