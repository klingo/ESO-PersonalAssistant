-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

-- ---------------------------------------------------------------------------------------------------------------------

local CONTROL_NAME = "PALItemIcons"
local HOOK_BAGS = 1
local HOOK_TRADEHOUSE = 2
local HOOK_STORE = 3

-- based on the control and hookType, checks if the current control is displayed in gridView or not (i.e. in rowView)
local function _isGridViewDisplay(control, hookType)
    local isGridViewEnabled = control.isGrid or (control:GetWidth() - control:GetHeight() < 5) or (InventoryGridView and InventoryGridView.settings.vars.isGrid)
    return isGridViewEnabled and (hookType == HOOK_BAGS or hookType == HOOK_STORE)
end

-- only if this function returns 'true' any icon controls shall be added
local function _hasItemIconChecksPassed(itemType, itemFilterType)
    if PA.Loot.SavedVars.ItemIcons.itemIconsEnabled then
        if itemType == ITEMTYPE_RECIPE or itemType == ITEMTYPE_RACIAL_STYLE_MOTIF or
            itemFilterType == ITEMFILTERTYPE_ARMOR or itemFilterType == ITEMFILTERTYPE_WEAPONS or itemFilterType == ITEMFILTERTYPE_JEWELRY then
            return true
        end
    end
    return false
end

-- ---------------------------------------------------------------------------------------------------------------------

-- returns the selected iconPosition (if selected); or evaluates different addons and automatically choses the correct location
local function _getIargetIconPosition()
    local selectedIconPosition = PA.Loot.SavedVars.ItemIcons.iconPositionGrid
    if selectedIconPosition == PAC.ICON_POSITION.AUTO then
        if _G["ResearchAssistant"] == nil then
            -- no [ResearchAssistant] found; position TOPLEFT
            return TOPLEFT
        elseif _G["ESOMRL"] == nil then
            -- no [ESOMRL] found; position BOTTOMLEFT
            return BOTTOMLEFT
        else
            -- both addons found; position BOTTOMRIGHT
            return BOTTOMRIGHT
        end
    else
        return selectedIconPosition
    end
end

-- returns the target icon size; depending on the parentControl and the hookType
local function _getTargetIconSize(parentControl, hookType)
    -- if gridView is enabled, and it is for the bags or buyback, then return the GRID size
    if _isGridViewDisplay(parentControl, hookType) then
        return PA.Loot.SavedVars.ItemIcons.iconSizeGrid
    end
    -- in all other cases return the ROW size
    return PA.Loot.SavedVars.ItemIcons.iconSizeRow
end

-- returns the iconPosition and offsets for gridView
local function _getGridViewIconPositionAndOffset()
    local selectedIconPosition = _getIargetIconPosition()
    local offsetX, offsetY
    if selectedIconPosition == TOPRIGHT or selectedIconPosition == BOTTOMRIGHT then offsetX = -4 else offsetX = 4 end
    if selectedIconPosition == BOTTOMLEFT or selectedIconPosition == BOTTOMRIGHT then offsetY = -4 else offsetY = 4 end
    return selectedIconPosition, offsetX, offsetY
end

-- ---------------------------------------------------------------------------------------------------------------------

-- attaches a tooltip to the control
local function _handleTooltips(itemIconControl, tooltipText)
    -- enable tooltips on the control
    itemIconControl:SetMouseEnabled(true)
    itemIconControl:SetHandler("OnMouseEnter", function(self) ZO_Tooltips_ShowTextTooltip(self, TOP, tooltipText) end)
    itemIconControl:SetHandler("OnMouseExit", function(self) ZO_Tooltips_HideTextTooltip() end)
end

-- sets the icon to the provided control and handels tooltip if provided
local function _setItemIcon(itemIconControl, icon, iconSize, tooltipText, r, g, b, a)
    -- set the dimensions and the texture including provided rgba colors
    itemIconControl:SetDimensions(iconSize, iconSize)
    itemIconControl:SetTextureCoords(0.2, 0.8, 0.2, 0.8)
    itemIconControl:SetTexture(icon)
    itemIconControl:SetColor(r, g, b, a)
    itemIconControl:SetHidden(false)
    -- if tooltipText is provided, also add tooltip
    if tooltipText then _handleTooltips(itemIconControl, tooltipText) end
end

-- sets the "known" icon to the control, plus tooltip
local function _setKnownItemIcon(itemIconControl, iconSize, tooltip)
    local red = 0.79    -- 202 (approx)
    local green = 0.79  -- 255 (approx)
    local blue= 0.79    -- 202 (approx)
    _setItemIcon(itemIconControl, PAC.ICONS.OTHERS.KNOWN.PATH, iconSize, "Already known", red, green, blue, 0.4)
end

-- sets the "unknown" icon to the control, plus tooltip
local function _setUnknownItemIcon(itemIconControl, iconSize, tooltip)
    local red = 0.4     -- 102
    local green = 1.0   -- 255
    local blue= 0.4     -- 102
    _setItemIcon(itemIconControl, PAC.ICONS.OTHERS.UNKNOWN.PATH, iconSize, "Unknown", red, green, blue, 1)
end

-- either returns the existing itemControl to be re-used, or creates a new one
local function _getOrCreateItemControl(parent)
    local itemIconControl = parent:GetNamedChild(CONTROL_NAME)
    if not itemIconControl then
        itemIconControl = WINDOW_MANAGER:CreateControl(parent:GetName() .. CONTROL_NAME, parent, CT_TEXTURE)
        itemIconControl:SetDrawTier(DT_HIGH)
    end
    return itemIconControl
end

-- adds known/unknown icons if the itemLink matches the criteria
local function _addItemKnownOrUnknownVisuals(parentControl, itemLink, hookType)
    local itemType = GetItemLinkItemType(itemLink)
    local itemFilterType = GetItemLinkFilterTypeInfo(itemLink)

    -- get either the already existing item control, or create a new one
    local itemIconControl = _getOrCreateItemControl(parentControl)

    -- make sure the icon/control is hidded for non-recipes and non-motives (or if setting was disabled)
    if not _hasItemIconChecksPassed(itemType, itemFilterType) then
        itemIconControl:SetHidden(true)
        return
    end

    -- check for inventory grid view and set the anchors accordingly
    itemIconControl:ClearAnchors()
    if _isGridViewDisplay(parentControl, hookType) then
        local iconPosition, offsetX, offsetY = _getGridViewIconPositionAndOffset()
        itemIconControl:SetAnchor(iconPosition, parentControl, iconPosition, offsetX, offsetY)
    else
        local controlName = WINDOW_MANAGER:GetControlByName(parentControl:GetName() .. 'Name')
        itemIconControl:SetAnchor(RIGHT, controlName, LEFT, -2, 0)
    end

    -- then get the icon size
    local iconSize = _getTargetIconSize(parentControl, hookType)

    -- now set the icons to the controls (depending on itemType and if known or not)
    if itemType == ITEMTYPE_RECIPE then
        if IsItemLinkRecipeKnown(itemLink) then
            _setKnownItemIcon(itemIconControl, iconSize)
        else
            _setUnknownItemIcon(itemIconControl, iconSize)
        end
    elseif itemType == ITEMTYPE_RACIAL_STYLE_MOTIF then
        if IsItemLinkBook(itemLink) and IsItemLinkBookKnown(itemLink) then
            _setKnownItemIcon(itemIconControl, iconSize)
        else
            _setUnknownItemIcon(itemIconControl, iconSize)
        end
    elseif itemFilterType == ITEMFILTERTYPE_ARMOR or itemFilterType == ITEMFILTERTYPE_WEAPONS or itemFilterType == ITEMFILTERTYPE_JEWELRY then
        if CanItemLinkBeTraitResearched(itemLink) then
            _setUnknownItemIcon(itemIconControl, iconSize)
        else
            _setKnownItemIcon(itemIconControl, iconSize)
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

local function refreshScrollListVisible()
    ZO_ScrollList_RefreshVisible(ZO_PlayerInventoryList)
    ZO_ScrollList_RefreshVisible(ZO_PlayerBankBackpack)
    ZO_ScrollList_RefreshVisible(ZO_HouseBankBackpack)
    ZO_ScrollList_RefreshVisible(ZO_GuildBankBackpack)
    ZO_ScrollList_RefreshVisible(ZO_StoreWindowList)
    ZO_ScrollList_RefreshVisible(ZO_BuyBackList)
    if ZO_TradingHouseSearch:IsAtTradingHouse() then
        ZO_ScrollList_RefreshVisible(TRADING_HOUSE.searchResultsList)
        ZO_ScrollList_RefreshVisible(TRADING_HOUSE.postedItemsList)
    end
end

local function initHooksOnBags()
    for _, v in pairs(PLAYER_INVENTORY.inventories) do
        local listView = v.listView
        if listView and listView.dataTypes and listView.dataTypes[1] then
            ZO_PreHook(listView.dataTypes[1], "setupCallback", function(control, slot)
                local bagId = control.dataEntry.data.bagId
                local slotIndex = control.dataEntry.data.slotIndex
                local itemLink = GetItemLink(bagId, slotIndex)
                _addItemKnownOrUnknownVisuals(control, itemLink, HOOK_BAGS)
            end)
        end
    end
end

local function initHooksOnTradeHouse()
    ZO_PreHook(TRADING_HOUSE.searchResultsList.dataTypes[1], "setupCallback", function(...)
        local control = ...
        if control.slotControlType and control.slotControlType == 'listSlot' and control.dataEntry.data.slotIndex then
            local itemLink = GetTradingHouseSearchResultItemLink(control.dataEntry.data.slotIndex)
            _addItemKnownOrUnknownVisuals(control, itemLink, HOOK_TRADEHOUSE)
        end
    end)
    ZO_PreHook(TRADING_HOUSE.postedItemsList.dataTypes[2], "setupCallback", function(...)
        local control = ...
        if control.slotControlType and control.slotControlType == 'listSlot' and control.dataEntry.data.slotIndex then
            local itemLink = GetTradingHouseListingItemLink(control.dataEntry.data.slotIndex)
            _addItemKnownOrUnknownVisuals(control, itemLink, HOOK_TRADEHOUSE)
        end
    end)
end

local function initHooksOnMerchantsAndBuyback()
    ZO_PreHook(ZO_BuyBackList.dataTypes[1], "setupCallback", function(...)
        local control = ...
        if control.slotControlType and control.slotControlType == 'listSlot' and control.dataEntry.data.slotIndex then
            local itemLink = GetBuybackItemLink(control.dataEntry.data.slotIndex)
            _addItemKnownOrUnknownVisuals(control, itemLink, HOOK_STORE)
        end
    end)

    ZO_PreHook(ZO_StoreWindowList.dataTypes[1], "setupCallback", function(...)
        local control = ...
        if control.slotControlType and control.slotControlType == 'listSlot' and control.dataEntry.data.slotIndex then
            local itemLink = GetStoreItemLink(control.dataEntry.data.slotIndex)
            _addItemKnownOrUnknownVisuals(control, itemLink, HOOK_STORE)
        end
    end)
end

local function initKnown()
    -- TODO: really needed/wanted?
    -- TODO: InitKnown                  /   EVENT_RECIPE_LEARNED / EVENT_STYLE_LEARNED / EVENT_TRAIT_LEARNED
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Loot = PA.Loot or {}
PA.Loot.ItemIcons = {
    refreshScrollListVisible = refreshScrollListVisible,
    initHooksOnBags = initHooksOnBags,
    initHooksOnTradeHouse = initHooksOnTradeHouse,
    initHooksOnMerchantsAndBuyback = initHooksOnMerchantsAndBuyback,
}