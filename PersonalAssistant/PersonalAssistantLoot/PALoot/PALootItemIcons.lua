-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants

-- ---------------------------------------------------------------------------------------------------------------------

local CONTROL_NAME = "PALItemVisuals"

local function _isGridViewEnabled(control)
    -- check whether the inventory is displayed in a grid
    return control.isGrid or (control:GetWidth() - control:GetHeight() < 5) or (InventoryGridView and InventoryGridView.settings.vars.isGrid)
end

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

local function _getIargetIconPosition()
    local selectedIconPosition = PA.Loot.SavedVars.ItemIcons.iconPosition
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

local function _getGridViewIconPositionAndOffset()
    local selectedIconPosition = _getIargetIconPosition()
    local offsetX, offsetY
    if selectedIconPosition == TOPRIGHT or selectedIconPosition == BOTTOMRIGHT then offsetX = -4 else offsetX = 4 end
    if selectedIconPosition == BOTTOMLEFT or selectedIconPosition == BOTTOMRIGHT then offsetY = -4 else offsetY = 4 end
    return selectedIconPosition, offsetX, offsetY
end

-- ---------------------------------------------------------------------------------------------------------------------

local function _handleTooltips(control, tooltipText)
    -- enable tooltips on the control
    control:SetMouseEnabled(true)
    control:SetHandler("OnMouseEnter", function(self) ZO_Tooltips_ShowTextTooltip(self, TOP, tooltipText) end)
    control:SetHandler("OnMouseExit", function(self) ZO_Tooltips_HideTextTooltip() end)
end

local function _setItemIcon(control, icon, tooltipText, r, g, b, a)
    -- set the dimensions and the texture including provided rgba colors
    local iconSize = PA.Loot.SavedVars.ItemIcons.iconSize
    control:SetDimensions(iconSize, iconSize)
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
    local itemIconControl = parent:GetNamedChild(CONTROL_NAME)
    if not itemIconControl then
        itemIconControl = WINDOW_MANAGER:CreateControl(parent:GetName() .. CONTROL_NAME, parent, CT_TEXTURE)
        itemIconControl:SetDrawTier(DT_HIGH)
    end
    return itemIconControl
end

local function _addItemKnownOrUnknownVisuals(control, bagId, slotIndex, itemLink)
    local itemType = GetItemLinkItemType(itemLink)
    local itemFilterType = GetItemFilterTypeInfo(bagId, slotIndex)

    -- get either the already existing item control, or create a new one
    local itemIconControl = _getOrCreateItemControl(control)

    -- make sure the icon/control is hidded for non-recipes and non-motives (or if setting was disabled)
    if not _hasItemIconChecksPassed(itemType, itemFilterType) then
        itemIconControl:SetHidden(true)
        return
    end

    -- check for inventory grid view and set the anchors accordingly
    local isGridViewEnabled = _isGridViewEnabled(control)
    itemIconControl:ClearAnchors()
    if isGridViewEnabled then
        local iconPosition, offsetX, offsetY = _getGridViewIconPositionAndOffset()
        itemIconControl:SetAnchor(iconPosition, control, iconPosition, offsetX, offsetY)
    else
        local controlName = WINDOW_MANAGER:GetControlByName(control:GetName() .. 'Name')
        itemIconControl:SetAnchor(RIGHT, controlName, LEFT, -2, 0)
    end

    -- now set the icons to the controls (depending on itemType and if known or not)
    if itemType == ITEMTYPE_RECIPE then
        if IsItemLinkRecipeKnown(itemLink) then
            _setKnownItemIcon(itemIconControl)
        else
            _setUnknownItemIcon(itemIconControl)
        end
    elseif itemType == ITEMTYPE_RACIAL_STYLE_MOTIF then
        if IsItemLinkBook(itemLink) and IsItemLinkBookKnown(itemLink) then
            _setKnownItemIcon(itemIconControl)
        else
            _setUnknownItemIcon(itemIconControl)
        end
    elseif itemFilterType == ITEMFILTERTYPE_ARMOR or itemFilterType == ITEMFILTERTYPE_WEAPONS or itemFilterType == ITEMFILTERTYPE_JEWELRY then
        if CanItemLinkBeTraitResearched(itemLink) then
            _setUnknownItemIcon(itemIconControl)
        else
            _setKnownItemIcon(itemIconControl)
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

local function initHooksOnBags()
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

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Loot = PA.Loot or {}
PA.Loot.ItemVisuals = {
    initHooksOnBags = initHooksOnBags
}


-- TODO: HookTradeHouse             /   EVENT_TRADING_HOUSE_RESPONSE_RECEIVED
-- TODO: HookBuyback                /   EVENT_OPEN_STORE
-- TODO: InitKnown                  /   EVENT_RECIPE_LEARNED