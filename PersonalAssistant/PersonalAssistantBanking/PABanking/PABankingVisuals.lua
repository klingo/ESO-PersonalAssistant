-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

-- ---------------------------------------------------------------------------------------------------------------------

local CONTROL_NAME = "PABVisual"

local function _isGridViewEnabled(control)
    -- check whether the inventory is displayed in a grid
    return control.isGrid or (control:GetWidth() - control:GetHeight() < 5) or (InventoryGridView and InventoryGridView.settings.vars.isGrid)
end

local function _handleTooltips(control, tooltipText)
    -- enable tooltips on the control
    control:SetMouseEnabled(true)
    control:SetHandler("OnMouseEnter", function(self) ZO_Tooltips_ShowTextTooltip(self, TOP, tooltipText) end)
    control:SetHandler("OnMouseExit", function(self) ZO_Tooltips_HideTextTooltip() end)
end

local function _setItemIcon(control, icon, tooltipText, r, g, b, a)
    -- set the dimensions and the texture including provided rgba colors
    control:SetDimensions(16, 16)
    control:SetTextureCoords(0.2, 0.8, 0.2, 0.8)
    control:SetTexture(icon)
    control:SetColor(r, g, b, a)
    control:SetHidden(false)
    -- if tooltipText is provided, also add tooltip
    if tooltipText then _handleTooltips(control, tooltipText) end
end

local function _setKnownItemIcon(control, tooltip)
    local red = 0.79    -- 202 (approx)
    local green = 0.79  -- 255 (approx)
    local blue= 0.79    -- 202 (approx)
    _setItemIcon(control, PAC.ICONS.OTHERS.KNOWN.PATH, "Already known", red, green, blue, 0.4)
end

local function _setUnknownItemIcon(control, tooltip)
    local red = 0.4     -- 102
    local green = 1.0   -- 255
    local blue= 0.4     -- 102
    _setItemIcon(control, PAC.ICONS.OTHERS.UNKNOWN.PATH, "Unknown", red, green, blue, 1)
end

local function _getOrCreateItemControl(parent)
    local pabVisualControl = parent:GetNamedChild(CONTROL_NAME)
    if not pabVisualControl then
        pabVisualControl = WINDOW_MANAGER:CreateControl(parent:GetName() .. CONTROL_NAME, parent, CT_TEXTURE)
        pabVisualControl:SetDrawTier(DT_HIGH)
    end
    return pabVisualControl
end

local function _addItemKnownOrUnknownVisuals(control, bagId, slotIndex, itemLink)
    local itemType = GetItemLinkItemType(itemLink)
    local itemFilterType = GetItemFilterTypeInfo(bagId, slotIndex)

    -- get either the already existing item control, or create a new one
    local pabVisualControl = _getOrCreateItemControl(control)

    -- make sure the icon/control is hidded for non-recipes and non-motives
    if itemType ~= ITEMTYPE_RECIPE and itemType ~= ITEMTYPE_RACIAL_STYLE_MOTIF and
            itemFilterType ~= ITEMFILTERTYPE_ARMOR and itemFilterType ~= ITEMFILTERTYPE_WEAPONS and
            itemFilterType ~= ITEMFILTERTYPE_JEWELRY then
        pabVisualControl:SetHidden(true)
        return
    end

    -- check for inventory grid view and set the anchors accordingly
    local isGridViewEnabled = _isGridViewEnabled(control)
    if isGridViewEnabled then
        pabVisualControl:SetAnchor(BOTTOMRIGHT, control, BOTTOMRIGHT, -4, -4)
    else
        local controlName = WINDOW_MANAGER:GetControlByName(control:GetName() .. 'Name')
        pabVisualControl:SetAnchor(RIGHT, controlName, LEFT, -2, 0)
    end

    -- now set the icons to the controls (depending on itemType and if known or not)
    if itemType == ITEMTYPE_RECIPE then
        if IsItemLinkRecipeKnown(itemLink) then
            _setKnownItemIcon(pabVisualControl)
        else
            _setUnknownItemIcon(pabVisualControl)
        end
    elseif itemType == ITEMTYPE_RACIAL_STYLE_MOTIF then
        if IsItemLinkBook(itemLink) and IsItemLinkBookKnown(itemLink) then
            _setKnownItemIcon(pabVisualControl)
        else
            _setUnknownItemIcon(pabVisualControl)
        end
    elseif itemFilterType == ITEMFILTERTYPE_ARMOR or itemFilterType == ITEMFILTERTYPE_WEAPONS or itemFilterType == ITEMFILTERTYPE_JEWELRY then
        if CanItemLinkBeTraitResearched(itemLink) then
            _setUnknownItemIcon(pabVisualControl)
        else
            _setKnownItemIcon(pabVisualControl)

        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

local function initVisualHooksOnBags()
    for _, v in pairs(PLAYER_INVENTORY.inventories) do
        local listView = v.listView
        if listView and listView.dataTypes and listView.dataTypes[1] then
            ZO_PreHook(listView.dataTypes[1], "setupCallback", function(control, slot)
                local bagId = control.dataEntry.data.bagId
                local slotIndex = control.dataEntry.data.slotIndex
                local itemLink = GetItemLink(bagId, slotIndex)
                _addItemKnownOrUnknownVisuals(control, bagId, slotIndex, itemLink)
            end)
        end
    end
end

-- TODO: do I need RefreshViews() ?


-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.Visuals = {
    initVisualHooksOnBags = initVisualHooksOnBags
}


-- TODO: HookTradeHouse             /   EVENT_TRADING_HOUSE_RESPONSE_RECEIVED
-- TODO: HookBuyback                /   EVENT_OPEN_STORE
-- TODO: InitKnown                  /   EVENT_RECIPE_LEARNED