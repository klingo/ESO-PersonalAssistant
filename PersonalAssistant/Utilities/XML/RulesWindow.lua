-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
local PAEM = PA.EventManager

local PABankingRulesList = ZO_SortFilterList:Subclass()
PA.BankingRulesList = nil
local TYPE_ACTIVE_RULE = 1

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

-- =================================================================================================================
-- == GENERAL MAIN MENU SETUP == --
-- -----------------------------------------------------------------------------------------------------------------
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


-- =================================================================================================================
-- == PA BANKING RULES LIST == --
-- -----------------------------------------------------------------------------------------------------------------
PABankingRulesList.SORT_KEYS = {
    ["itemName"] = {},
    ["bagName"] = {tiebreaker="itemName"},
    ["mathOperator"] = {tiebreaker="itemName"},
    ["bagAmount"] = {tiebreaker="itemName"},
}

function PABankingRulesList:New()
    local rules = ZO_SortFilterList.New(self, BankingRulesTabControl)
    return rules
end

function PABankingRulesList:Initialize(control)
    -- initialize the SortFilterList
    ZO_SortFilterList.Initialize(self, control)
    -- set a text that is displayed when there are no entries
    self:SetEmptyText(GetString(SI_PA_SUBMENU_PAB_NO_RULES))
    -- default sorting key
    self.sortHeaderGroup:SelectHeaderByKey("item")
    ZO_SortHeader_OnMouseExit(BankingRulesTabControl:GetNamedChild("Headers"):GetNamedChild("ItemName"))
    -- define the datatype for this list and enable the highlighting
    ZO_ScrollList_AddDataType(self.list, TYPE_ACTIVE_RULE, "PersonalAssistantBankingRuleListRowTemplate", 36, function(control, data) self:SetupRuleRow(control, data) end)
    ZO_ScrollList_EnableHighlight(self.list, "ZO_ThinListHighlight")
    -- set up sorting function and refresh all data
    self.sortFunction = function(listEntry1, listEntry2) return ZO_TableOrderingFunction(listEntry1.data, listEntry2.data, self.currentSortKey, PABankingRulesList.SORT_KEYS, self.currentSortOrder) end
    self:RefreshData()
end

function PABankingRulesList:FilterScrollList()
    -- get the data of the scrollist and index it
    local scrollData = ZO_ScrollList_GetDataList(self.list)
    ZO_ClearNumericallyIndexedTable(scrollData)
    -- need to access it via the full-path becase the "RefreshAllSavedVarReferences" might not have been executed yet
    local PABCustomItemIds = PA.SavedVars.Banking[PA.activeProfile].Custom.ItemIds
    -- populate the table that is used as source for the list
    for _, moveConfig in pairs(PABCustomItemIds) do
        local bagName, operatorText = getBagNameAndOperatorTextFromOperatorId(moveConfig.operator)
        local rowData = {
            bagName = bagName,
            operator = moveConfig.operator, -- required to edit the rule
            mathOperator = operatorText, -- required to display the rule
            bagAmount = moveConfig.bagAmount,
            itemIcon = GetItemLinkInfo(moveConfig.itemLink),
            itemLink = moveConfig.itemLink,
            itemName = GetItemLinkName(moveConfig.itemLink)
        }
        -- "1" is to define a category per dataEntry (can be individually hidden)
        table.insert(scrollData, ZO_ScrollList_CreateDataEntry(TYPE_ACTIVE_RULE, rowData, 1))
    end
end

function PABankingRulesList:SortScrollList()
    -- get all data and sort it
    local scrollData = ZO_ScrollList_GetDataList(self.list)
    table.sort(scrollData, self.sortFunction)
end

function PABankingRulesList:SetupRuleRow(rowControl, rowData)
    local function onRowMouseEnter(rowControl)
        PA.BankingRulesList:Row_OnMouseEnter(rowControl)
        local delButtonControl = rowControl:GetNamedChild("DelButton")
        local editButtonControl = rowControl:GetNamedChild("EditButton")
        delButtonControl:SetHidden(false)
        editButtonControl:SetHidden(false)
    end
    local function onRowMouseExit(rowControl)
        PA.BankingRulesList:Row_OnMouseExit(rowControl)
        local delButtonControl = rowControl:GetNamedChild("DelButton")
        local editButtonControl = rowControl:GetNamedChild("EditButton")
        delButtonControl:SetHidden(true)
        editButtonControl:SetHidden(true)
    end
    local function onItemNameMouseEnter(itemNameControl)
        InitializeTooltip(ItemTooltip, itemNameControl, TOPRIGHT, -40, 0, TOPLEFT)
        ItemTooltip:SetLink(itemNameControl:GetText())
        -- Also trigger the Row-OnMouseEnter to keep the row-highlight when entering the itemName
        onRowMouseEnter(itemNameControl:GetParent())
    end
    local function onItemNameMouseExit(itemNameControl)
        ClearTooltip(ItemTooltip)
        -- Also trigger to Row-OnMouseExit because otherwise the row-highlight will not disappear when leaving the itemName
        onRowMouseExit(itemNameControl:GetParent())
    end
    local function onDeleteButtonMouseEnter(deleteButtonControl)
        ZO_Tooltips_ShowTextTooltip(deleteButtonControl, TOP, GetString(SI_PA_SUBMENU_PAB_DELETE_RULE_BUTTON))
        -- Also trigger the Row-OnMouseEnter to keep the row-highlight when entering the itemName
        onRowMouseEnter(deleteButtonControl:GetParent())
    end
    local function onDeleteButtonMouseExit(deleteButtonControl)
        ZO_Tooltips_HideTextTooltip()
        -- Also trigger to Row-OnMouseExit because otherwise the row-highlight will not disappear when leaving the itemName
        onRowMouseExit(deleteButtonControl:GetParent())
    end
    local function onEditButtonMouseEnter(editButtonControl)
        ZO_Tooltips_ShowTextTooltip(editButtonControl, TOP, GetString(SI_PA_SUBMENU_PAB_UPDATE_RULE_BUTTON))
        -- Also trigger the Row-OnMouseEnter to keep the row-highlight when entering the itemName
        onRowMouseEnter(editButtonControl:GetParent())
    end
    local function onEditButtonMouseExit(editButtonControl)
        ZO_Tooltips_HideTextTooltip()
        -- Also trigger to Row-OnMouseExit because otherwise the row-highlight will not disappear when leaving the itemName
        onRowMouseExit(editButtonControl:GetParent())
    end

    -- store the rowData on the control so it can be accessed from the sortFunction
    rowControl.data = rowData

    -- populate all data to the individual fields per row
    local bagNameControl = rowControl:GetNamedChild("BagName")
    bagNameControl:SetText(LocaleAwareToUpper(rowData.bagName))

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

    -- Setup the DELETE button per row
    local delButtonControl = rowControl:GetNamedChild("DelButton")
    delButtonControl:SetHandler("OnMouseEnter", onDeleteButtonMouseEnter)
    delButtonControl:SetHandler("OnMouseExit", onDeleteButtonMouseExit)
    delButtonControl:SetHandler("OnMouseDown", function(self)
        ZO_Tooltips_HideTextTooltip()
        PA.CustomDialogs.deletePABCustomRule(rowControl.data.itemLink)
    end)

    -- Setup the EDIT button per row
    local editButtonControl = rowControl:GetNamedChild("EditButton")
    editButtonControl:SetHandler("OnMouseEnter", onEditButtonMouseEnter)
    editButtonControl:SetHandler("OnMouseExit", onEditButtonMouseExit)
    editButtonControl:SetHandler("OnMouseDown", function(self)
        ZO_Tooltips_HideTextTooltip()
        PA.CustomDialogs.initPABAddCustomRuleUIDialog() -- make sure it has been initialized
        PA.CustomDialogs.showPABAddCustomRuleUIDIalog(rowControl.data.itemLink, rowData)
    end)

    -- the below two handlers only work if "PersonalAssistantBankingRuleListRowTemplate" is set to a <Button> control
    rowControl:SetHandler("OnMouseEnter", onRowMouseEnter)
    rowControl:SetHandler("OnMouseExit", onRowMouseExit)

    ZO_SortFilterList.SetupRow(self, rowControl, rowData)
end

function PABankingRulesList:InitHeaders()
    -- Initialise the headers
    local headers = BankingRulesTabControl:GetNamedChild("Headers")
    ZO_SortHeader_Initialize(headers:GetNamedChild("BagName"), GetString(SI_PA_MAINMENU_BANKING_HEADER_BAG), "bagName", ZO_SORT_ORDER_DOWN, TEXT_ALIGN_LEFT, "ZoFontHeader")
    ZO_SortHeader_Initialize(headers:GetNamedChild("MathOperator"), GetString(SI_PA_MAINMENU_BANKING_HEADER_OPERATOR), "mathOperator", ZO_SORT_ORDER_DOWN, TEXT_ALIGN_LEFT, "ZoFontHeader")
    ZO_SortHeader_Initialize(headers:GetNamedChild("BagAmount"), GetString(SI_PA_MAINMENU_BANKING_HEADER_AMOUNT), "bagAmount", ZO_SORT_ORDER_DOWN, TEXT_ALIGN_LEFT, "ZoFontHeader")
    ZO_SortHeader_Initialize(headers:GetNamedChild("ItemName"), GetString(SI_PA_MAINMENU_BANKING_HEADER_ITEM), "itemName", ZO_SORT_ORDER_DOWN, TEXT_ALIGN_LEFT, "ZoFontHeader")
    ZO_SortHeader_Initialize(headers:GetNamedChild("Actions"), GetString(SI_PA_MAINMENU_BANKING_HEADER_ACTIONS), NO_SORT_KEY, ZO_SORT_ORDER_DOWN, TEXT_ALIGN_RIGHT, "ZoFontHeader")
end

function PABankingRulesList:Refresh()
    self:RefreshData()
end

-- ---------------------------------------------------------------------------------------------------------------------

local baseInitDone = false

local function initPABankingRulesList()
--    PAEM.UnregisterForCallback("PersonalAssistant", EVENT_ADD_ON_LOADED, initPABankingRulesList, "InitPABankingRulesList")
    if PA.Banking then
        if not baseInitDone then
            baseInitDone = true
            PABankingRulesList:InitHeaders()
            PA.BankingRulesList = PABankingRulesList:New()
        end
        PA.BankingRulesList:Refresh()
    end
end

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
        window:GetNamedChild("ModeMenuDivider"):SetHidden(true)
    else
        PA.debugln("Neither PABanking nor PAJunk is active; don't display MainMenu entry")
    end
end


-- =================================================================================================================
-- == PA JUNK RULES LIST == --
-- -----------------------------------------------------------------------------------------------------------------
-- TODO: to be implemented


-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.CustomDialogs = PA.CustomDialogs or {}
PA.CustomDialogs.initRulesMainMenu = initRulesMainMenu

-- create the main menu entry with LMM-2
PAEM.RegisterForCallback("PersonalAssistant", EVENT_ADD_ON_LOADED, initPABankingRulesList, "InitPABankingRulesList")
