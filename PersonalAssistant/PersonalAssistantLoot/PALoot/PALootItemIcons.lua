-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAHF = PA.HelperFunctions

-- =====================================================================================================================

local KNOWN_UNKNOWN_CONTROL_NAME = "PALKnownUnknownItemIcons"
local SET_COLLECTION_CONTROL_NAME = "PALSetCollectionItemIcons"
local COMPANION_ITEM_CONTROL_NAME = "PALCompanionItemItemIcons"
local HOOK_BAGS = 1
local HOOK_TRADEHOUSE = 2
local HOOK_STORE = 3
local HOOK_CRAFTSTATION = 4
local HOOK_LOOT = 5

local _hooksOnBagsInitialized = false
local _hooksOnMerchantsAndBuybackInitialized = false
local _hooksOnCraftingStationsInitialized = false
local _hooksOnLootWindowInitialized = false

-- based on the control and hookType, checks if the current control is displayed in gridView or not (i.e. in rowView)
local function _isGridViewDisplay(control, hookType)
    -- if width and height is max 5 px apart, assume we are in grid view
    local isGridViewEnabled = control:GetWidth() - control:GetHeight() < 5
    return isGridViewEnabled and (hookType == HOOK_BAGS or hookType == HOOK_STORE)
end

-- only if this function returns 'true' any icon controls shall be added
local function _hasItemIconChecksPassed(itemType, specializedItemType, itemFilterType, itemLink)
    if PA.Loot.SavedVars.ItemIcons.itemIconsEnabled then
        if itemType == ITEMTYPE_RECIPE or itemType == ITEMTYPE_RACIAL_STYLE_MOTIF or
            itemFilterType == ITEMFILTERTYPE_ARMOR or itemFilterType == ITEMFILTERTYPE_WEAPONS or itemFilterType == ITEMFILTERTYPE_JEWELRY or
                specializedItemType == SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE or specializedItemType == SPECIALIZED_ITEMTYPE_COLLECTIBLE_STYLE_PAGE or specializedItemType == SPECIALIZED_ITEMTYPE_CONTAINER then
            -- Since Blackwood, we also need to check if the item is for the player (and not the companion)
            return PAHF.isItemLinkForCompanion(itemLink) == false
        end
    end
    return false
end

local function _hasItemSetCollectionIconChecksPassed(itemLink)
    if PA.Loot.SavedVars.ItemIcons.itemIconsEnabled and IsItemLinkSetCollectionPiece(itemLink) then
        -- Since Blackwood, we also need to check if the item is for the player (and not the companion)
        return PAHF.isItemLinkForCompanion(itemLink) == false
    end
    return false
end

local function _hasItemCompanionItemsIconChecksPassed(itemLink)
    return PA.Loot.SavedVars.ItemIcons.itemIconsEnabled and PAHF.isItemLinkForCompanion(itemLink)
end

-- ---------------------------------------------------------------------------------------------------------------------

-- returns the target icon size; depending on the parentControl and the hookType
local function _getKnownUnknownIconSize(parentControl, hookType)
    -- if gridView is enabled, and it is for the bags or buyback, then return the GRID size
    if _isGridViewDisplay(parentControl, hookType) then
        return PA.Loot.SavedVars.ItemIcons.iconSizeGrid
    end
    -- in all other cases return the ROW size
    return PA.Loot.SavedVars.ItemIcons.iconSizeList
end

-- returns the target icon size; depending on the parentControl and the hookType
local function _getSetCollectionIconSize(parentControl, hookType)
    -- if gridView is enabled, and it is for the bags or buyback, then return the GRID size
    if _isGridViewDisplay(parentControl, hookType) then
        return PA.Loot.SavedVars.ItemIcons.SetCollection.iconSizeGrid
    end
    -- in all other cases return the ROW size
    return PA.Loot.SavedVars.ItemIcons.SetCollection.iconSizeList
end

-- returns the target icon size; depending on the parentControl and the hookType
local function _getCompanionItemIconSize(parentControl, hookType)
    -- if gridView is enabled, and it is for the bags or buyback, then return the GRID size
    if _isGridViewDisplay(parentControl, hookType) then
        return PA.Loot.SavedVars.ItemIcons.CompanionItems.iconSizeGrid
    end
    -- in all other cases return the ROW size
    return PA.Loot.SavedVars.ItemIcons.CompanionItems.iconSizeList
end

-- returns the iconPosition and offsets for gridView
local function _getKnownUnknownGridViewIconPositionAndOffset()
    local offsetX = PA.Loot.SavedVars.ItemIcons.iconXOffsetGrid
    local offsetY = PA.Loot.SavedVars.ItemIcons.iconYOffsetGrid
    return BOTTOMLEFT, offsetX, offsetY
end

local function _getKnownUnknownListViewIconPositionAndOffset()
    local offsetX = PA.Loot.SavedVars.ItemIcons.iconXOffsetList
    local offsetY = PA.Loot.SavedVars.ItemIcons.iconYOffsetList
    return LEFT, RIGHT, offsetX, offsetY
end

-- returns the iconPosition and offsets for gridView
local function _getSetCollectionGridViewIconPositionAndOffset()
    local offsetX = PA.Loot.SavedVars.ItemIcons.SetCollection.iconXOffsetGrid
    local offsetY = PA.Loot.SavedVars.ItemIcons.SetCollection.iconYOffsetGrid
    return BOTTOMRIGHT, offsetX, offsetY
end

local function _getSetCollectionListViewIconPositionAndOffset()
    local offsetX = PA.Loot.SavedVars.ItemIcons.SetCollection.iconXOffsetList
    local offsetY = PA.Loot.SavedVars.ItemIcons.SetCollection.iconYOffsetList
    return LEFT, RIGHT, offsetX, offsetY
end

-- returns the iconPosition and offsets for gridView
local function _getCompanionItemGridViewIconPositionAndOffset()
    local offsetX = PA.Loot.SavedVars.ItemIcons.CompanionItems.iconXOffsetGrid
    local offsetY = PA.Loot.SavedVars.ItemIcons.CompanionItems.iconYOffsetGrid
    return BOTTOMLEFT, offsetX, offsetY
end

local function _getCompanionItemListViewIconPositionAndOffset()
    local offsetX = PA.Loot.SavedVars.ItemIcons.CompanionItems.iconXOffsetList
    local offsetY = PA.Loot.SavedVars.ItemIcons.CompanionItems.iconYOffsetList
    return LEFT, RIGHT, offsetX, offsetY
end

-- ---------------------------------------------------------------------------------------------------------------------

-- attaches a tooltip to the control
local function _handleTooltips(itemIconControl, tooltipText)
    if tooltipText and PA.Loot.SavedVars.ItemIcons.iconTooltipShown then
        -- enable tooltips on the control
        itemIconControl:SetMouseEnabled(true)
        itemIconControl:SetHandler("OnMouseEnter", function(self) ZO_Tooltips_ShowTextTooltip(self, TOP, tooltipText) end)
        itemIconControl:SetHandler("OnMouseExit", function(self) ZO_Tooltips_HideTextTooltip() end)
    else
        itemIconControl:SetMouseEnabled(false)
    end
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
local function _setKnownItemIcon(itemIconControl, iconSize, tooltipText)
    local red = 0.79    -- 202 (approx)
    local green = 0.79  -- 255 (approx)
    local blue = 0.79    -- 202 (approx)
    _setItemIcon(itemIconControl, PAC.ICONS.OTHERS.KNOWN.PATH, iconSize, tooltipText, red, green, blue, 0.4)
end

-- sets the "unknown" icon to the control, plus tooltip
local function _setUnknownItemIcon(itemIconControl, iconSize, tooltipText)
    local red = 0.4     -- 102
    local green = 1.0   -- 255
    local blue = 0.4     -- 102
    _setItemIcon(itemIconControl, PAC.ICONS.OTHERS.UNKNOWN.PATH, iconSize, tooltipText, red, green, blue, 1)
end

-- sets the "uncollected" icon to the control, plus tooltip
local function _setUncollectedSetItemIcon(itemIconControl, iconSize, tooltipText)
    local red = 0.4     -- 102
    local green = 0.925 -- 236 (approx)
    local blue = 1.0    -- 255
    _setItemIcon(itemIconControl, PAC.ICONS.OTHERS.UNCOLLECTED.PATH, iconSize, tooltipText, red, green, blue, 1)
end

-- sets the "companion item" icon to the control, plus tooltip
local function _setCompanionItemIcon(itemIconControl, iconSize, tooltipText)
    local red = 1.0     -- 255
    local green = 0.749 -- 191 (approx)
    local blue = 0      -- 0
    _setItemIcon(itemIconControl, PAC.ICONS.OTHERS.COMPANION.PATH, iconSize, tooltipText, red, green, blue, 1)
end

-- either returns the existing itemControl to be re-used, or creates a new one
local function _getOrCreateKnownUnknownItemControl(parent)
    local itemIconControl = parent:GetNamedChild(KNOWN_UNKNOWN_CONTROL_NAME)
    if not itemIconControl then
        itemIconControl = WINDOW_MANAGER:CreateControl(parent:GetName() .. KNOWN_UNKNOWN_CONTROL_NAME, parent, CT_TEXTURE)
        itemIconControl:SetDrawTier(DT_HIGH)
        itemIconControl:SetDrawLevel(1)
    end
    return itemIconControl
end

-- either returns the existing itemControl to be re-used, or creates a new one
local function _getOrCreateSetCollectionItemControl(parent)
    local itemIconControl = parent:GetNamedChild(SET_COLLECTION_CONTROL_NAME)
    if not itemIconControl then
        itemIconControl = WINDOW_MANAGER:CreateControl(parent:GetName() .. SET_COLLECTION_CONTROL_NAME, parent, CT_TEXTURE)
        itemIconControl:SetDrawTier(DT_HIGH)
        itemIconControl:SetDrawLevel(1)
    end
    return itemIconControl
end

-- either returns the existing itemControl to be re-used, or creates a new one
local function _getOrCreateCompanionItemControl(parent)
    local itemIconControl = parent:GetNamedChild(COMPANION_ITEM_CONTROL_NAME)
    if not itemIconControl then
        itemIconControl = WINDOW_MANAGER:CreateControl(parent:GetName() .. COMPANION_ITEM_CONTROL_NAME, parent, CT_TEXTURE)
        itemIconControl:SetDrawTier(DT_HIGH)
        itemIconControl:SetDrawLevel(1)
    end
    return itemIconControl
end

-- adds known/unknown icons if the itemLink matches the criteria
local function _addItemKnownOrUnknownVisuals(parentControl, itemLink, hookType)
    local itemType, specializedItemType = GetItemLinkItemType(itemLink)
    local itemFilterType = GetItemLinkFilterTypeInfo(itemLink)

    -- get either the already existing item control, or create a new one
    local itemIconControl = _getOrCreateKnownUnknownItemControl(parentControl)

    -- make sure the icon/control is hidden for non-recipes and non-motifs (or if setting was disabled)
    itemIconControl:SetHidden(true)

    -- then check if the pre-conditions are met, otherwise stop any further processing
    if not _hasItemIconChecksPassed(itemType, specializedItemType, itemFilterType, itemLink) then
        return
    end

    -- check for inventory grid view and set the anchors accordingly
    itemIconControl:ClearAnchors()
    if _isGridViewDisplay(parentControl, hookType) then
        local iconPosition, offsetX, offsetY = _getKnownUnknownGridViewIconPositionAndOffset()
        itemIconControl:SetAnchor(iconPosition, parentControl, iconPosition, offsetX, offsetY)
    else
        local controlName = WINDOW_MANAGER:GetControlByName(parentControl:GetName() .. 'Name')
        local iconPositionSelf, iconPositionParent, offsetX, offsetY = _getKnownUnknownListViewIconPositionAndOffset()
        itemIconControl:SetAnchor(iconPositionSelf, controlName, iconPositionParent, offsetX, offsetY)
    end

    -- then get the icon size
    local iconSize = _getKnownUnknownIconSize(parentControl, hookType)

    -- and start checking the SavedVars settings
    local PALootItemIconsSV = PA.Loot.SavedVars.ItemIcons

    -- get the 'learnable' status for the itemLink
    local learnableStatus = PAHF.getItemLinkLearnableStatus(itemLink)
    if learnableStatus == PAC.LEARNABLE.KNOWN then
        if (itemType == ITEMTYPE_RECIPE and PALootItemIconsSV.Recipes.showKnownIcon) or
                (itemType == ITEMTYPE_RACIAL_STYLE_MOTIF and PALootItemIconsSV.Motifs.showKnownIcon) then
            _setKnownItemIcon(itemIconControl, iconSize, GetString(SI_PA_ITEM_KNOWN))
        elseif ((itemFilterType == ITEMFILTERTYPE_ARMOR or itemFilterType == ITEMFILTERTYPE_WEAPONS or itemFilterType == ITEMFILTERTYPE_JEWELRY) and PALootItemIconsSV.ApparelWeapons.showKnownIcon) then
            local itemTraitType = GetItemLinkTraitType(itemLink)
            local traitName = GetString("SI_ITEMTRAITTYPE", itemTraitType)
            _setKnownItemIcon(itemIconControl, iconSize, table.concat({GetString(SI_PA_ITEM_KNOWN), ": ", PAC.COLORS.WHITE, traitName}))
        elseif ((specializedItemType == SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE or specializedItemType == SPECIALIZED_ITEMTYPE_COLLECTIBLE_STYLE_PAGE or specializedItemType == SPECIALIZED_ITEMTYPE_CONTAINER) and PALootItemIconsSV.StylePageContainers.showKnownIcon) then
            local containerCollectibleId = GetItemLinkContainerCollectibleId(itemLink)
            local collectibleName = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetCollectibleName(containerCollectibleId))
            _setKnownItemIcon(itemIconControl, iconSize, table.concat({GetString(SI_PA_ITEM_KNOWN), ": ", PAC.COLORS.WHITE, collectibleName}))
        end
    elseif learnableStatus == PAC.LEARNABLE.UNKNOWN then
        if (itemType == ITEMTYPE_RECIPE and PALootItemIconsSV.Recipes.showUnknownIcon) or
                (itemType == ITEMTYPE_RACIAL_STYLE_MOTIF and PALootItemIconsSV.Motifs.showUnknownIcon) then
            _setUnknownItemIcon(itemIconControl, iconSize, GetString(SI_PA_ITEM_UNKNOWN))
        elseif ((itemFilterType == ITEMFILTERTYPE_ARMOR or itemFilterType == ITEMFILTERTYPE_WEAPONS or itemFilterType == ITEMFILTERTYPE_JEWELRY) and PALootItemIconsSV.ApparelWeapons.showUnknownIcon) then
            local itemTraitType = GetItemLinkTraitType(itemLink)
            local traitName = GetString("SI_ITEMTRAITTYPE", itemTraitType)
            _setUnknownItemIcon(itemIconControl, iconSize, table.concat({GetString(SI_PA_ITEM_UNKNOWN), ": ", PAC.COLORS.WHITE, traitName}))
        elseif ((specializedItemType == SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE or specializedItemType == SPECIALIZED_ITEMTYPE_COLLECTIBLE_STYLE_PAGE or specializedItemType == SPECIALIZED_ITEMTYPE_CONTAINER) and PALootItemIconsSV.StylePageContainers.showUnknownIcon) then
            local containerCollectibleId = GetItemLinkContainerCollectibleId(itemLink)
            local collectibleName = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetCollectibleName(containerCollectibleId))
            _setUnknownItemIcon(itemIconControl, iconSize, table.concat({GetString(SI_PA_ITEM_UNKNOWN), ": ", PAC.COLORS.WHITE, collectibleName}))
        end
    end
end

local function _addSetCollectionVisuals(parentControl, itemLink, hookType)
    -- get either the already existing item control, or create a new one
    local itemIconControl = _getOrCreateSetCollectionItemControl(parentControl)

    -- make sure the icon/control is hidden for non-recipes and non-motifs (or if setting was disabled)
    itemIconControl:SetHidden(true)

    -- then check if the pre-conditions are met, otherwise stop any further processing
    if not _hasItemSetCollectionIconChecksPassed(itemLink) then
        return
    end

    -- check for inventory grid view and set the anchors accordingly
    itemIconControl:ClearAnchors()
    if _isGridViewDisplay(parentControl, hookType) then
        local iconPosition, offsetX, offsetY = _getSetCollectionGridViewIconPositionAndOffset()
        itemIconControl:SetAnchor(iconPosition, parentControl, iconPosition, offsetX, offsetY)
    else
        local controlName = WINDOW_MANAGER:GetControlByName(parentControl:GetName() .. 'Name')
        local iconPositionSelf, iconPositionParent, offsetX, offsetY = _getSetCollectionListViewIconPositionAndOffset()
        itemIconControl:SetAnchor(iconPositionSelf, controlName, iconPositionParent, offsetX, offsetY)
    end

    -- then get the icon size
    local iconSize = _getSetCollectionIconSize(parentControl, hookType)

    -- and start checking the SavedVars settings
    local PALootItemIconsSV = PA.Loot.SavedVars.ItemIcons

    -- get the 'isItemSetCollectionPieceUnlocked' status for the itemLink
    local isItemSetCollectionPieceUnlocked = IsItemSetCollectionPieceUnlocked(GetItemLinkItemId(itemLink))
    if not isItemSetCollectionPieceUnlocked and PALootItemIconsSV.SetCollection.showUncollectedIcon then
        local itemName = zo_strformat(SI_TOOLTIP_ITEM_NAME, GetItemLinkName(itemLink))
        _setUncollectedSetItemIcon(itemIconControl, iconSize, table.concat({GetString(SI_PA_ITEM_UNCOLLECTED), ": ", PAC.COLORS.WHITE, itemName}))
    end
end

local function _addCompanionItemVisuals(parentControl, itemLink, hookType)
    -- get either the already existing item control, or create a new one
    local itemIconControl = _getOrCreateCompanionItemControl(parentControl)

    -- make sure the icon/control is hidden for non-recipes and non-motifs (or if setting was disabled)
    itemIconControl:SetHidden(true)

    -- then check if the pre-conditions are met, otherwise stop any further processing
    if not _hasItemCompanionItemsIconChecksPassed(itemLink) then
        return
    end

    -- check for inventory grid view and set the anchors accordingly
    itemIconControl:ClearAnchors()
    if _isGridViewDisplay(parentControl, hookType) then
        local iconPosition, offsetX, offsetY = _getCompanionItemGridViewIconPositionAndOffset()
        itemIconControl:SetAnchor(iconPosition, parentControl, iconPosition, offsetX, offsetY)
    else
        local controlName = WINDOW_MANAGER:GetControlByName(parentControl:GetName() .. 'Name')
        local iconPositionSelf, iconPositionParent, offsetX, offsetY = _getCompanionItemListViewIconPositionAndOffset()
        itemIconControl:SetAnchor(iconPositionSelf, controlName, iconPositionParent, offsetX, offsetY)
    end

    -- then get the icon size
    local iconSize = _getCompanionItemIconSize(parentControl, hookType)

    -- and start checking the SavedVars settings
    local PALootItemIconsSV = PA.Loot.SavedVars.ItemIcons

    -- get the 'isItemLinkForCompanion' status for the itemLink
    local isItemCompanionItem = PAHF.isItemLinkForCompanion(itemLink)
    if isItemCompanionItem and PALootItemIconsSV.CompanionItems.showCompanionItemIcon then
        local itemTraitType = GetItemLinkTraitType(itemLink)
        local traitName = GetString("SI_ITEMTRAITTYPE", itemTraitType)
        _setCompanionItemIcon(itemIconControl, iconSize, table.concat({GetString(SI_PA_ITEM_COMPANION_ITEM), ": ", PAC.COLORS.WHITE, traitName}))
    end
end

local function _getOrCreateDataEntryItemLink(dataEntryData)
    if dataEntryData.itemLink == nil then
        dataEntryData.itemLink = GetItemLink(dataEntryData.bagId, dataEntryData.slotIndex)
    end
    return dataEntryData.itemLink
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

-- this function only needs to be initialized ONCE
local function initHooksOnBags()
    if not _hooksOnBagsInitialized then
        _hooksOnBagsInitialized = true
        for _, inventory in pairs(PLAYER_INVENTORY.inventories) do
            local listView = inventory.listView
            if listView and listView.dataTypes and listView.dataTypes[1] then
                ZO_PreHook(listView.dataTypes[1], "setupCallback", function(control, slot)
                    if not PA.Banking or not PA.Banking.isBankItemTransferBlocked then
                        local bagId = control.dataEntry.data.bagId
                        local slotIndex = control.dataEntry.data.slotIndex
                        local itemLink = _getOrCreateDataEntryItemLink(control.dataEntry.data)
                        _addItemKnownOrUnknownVisuals(control, itemLink, HOOK_BAGS)
                        _addSetCollectionVisuals(control, itemLink, HOOK_BAGS)
                        _addCompanionItemVisuals(control, itemLink, HOOK_BAGS)
                    end
                end)
            end
        end
    else
        PAHF.debuglnAuthor("Attempted to Re-Hook: [initHooksOnBags]")
    end
end

-- this function needs to be initialized everytime the TradeHouse is opened
local function initHooksOnTradeHouse()
    local isAlwaysKeyboardMode = PAHF.isAlwaysKeyboardMode()
    PA.Loot.debugln("initHooksOnTradeHouse | gamepadModeSetting = %d | isAlwaysKeyboardMode = %s", gamepadModeSetting, tostring(isAlwaysKeyboardMode))
    if isAlwaysKeyboardMode then
        ZO_PreHook(TRADING_HOUSE.searchResultsList.dataTypes[1], "setupCallback", function(...)
            local control = ...
            if control.slotControlType and control.slotControlType == 'listSlot' and control.dataEntry.data.slotIndex then
                local itemLink = GetTradingHouseSearchResultItemLink(control.dataEntry.data.slotIndex)
                _addItemKnownOrUnknownVisuals(control, itemLink, HOOK_TRADEHOUSE)
                _addSetCollectionVisuals(control, itemLink, HOOK_TRADEHOUSE)
                _addCompanionItemVisuals(control, itemLink, HOOK_TRADEHOUSE)
            end
        end)
        ZO_PreHook(TRADING_HOUSE.postedItemsList.dataTypes[2], "setupCallback", function(...)
            local control = ...
            if control.slotControlType and control.slotControlType == 'listSlot' and control.dataEntry.data.slotIndex then
                local itemLink = GetTradingHouseListingItemLink(control.dataEntry.data.slotIndex)
                _addItemKnownOrUnknownVisuals(control, itemLink, HOOK_TRADEHOUSE)
                _addSetCollectionVisuals(control, itemLink, HOOK_TRADEHOUSE)
                _addCompanionItemVisuals(control, itemLink, HOOK_TRADEHOUSE)
            end
        end)
    end
end

local function initHooksOnMerchantsAndBuyback()
    if not _hooksOnMerchantsAndBuybackInitialized then
        _hooksOnMerchantsAndBuybackInitialized = true
        ZO_PreHook(ZO_BuyBackList.dataTypes[1], "setupCallback", function(...)
            local control = ...
            if control.slotControlType and control.slotControlType == 'listSlot' and control.dataEntry.data.slotIndex then
                local itemLink = GetBuybackItemLink(control.dataEntry.data.slotIndex)
                _addItemKnownOrUnknownVisuals(control, itemLink, HOOK_STORE)
                _addSetCollectionVisuals(control, itemLink, HOOK_STORE)
                _addCompanionItemVisuals(control, itemLink, HOOK_STORE)
            end
        end)

        ZO_PreHook(ZO_StoreWindowList.dataTypes[1], "setupCallback", function(...)
            local control = ...
            if control.slotControlType and control.slotControlType == 'listSlot' and control.dataEntry.data.slotIndex then
                local itemLink = GetStoreItemLink(control.dataEntry.data.slotIndex)
                _addItemKnownOrUnknownVisuals(control, itemLink, HOOK_STORE)
                _addSetCollectionVisuals(control, itemLink, HOOK_STORE)
                _addCompanionItemVisuals(control, itemLink, HOOK_STORE)
            end
        end)
    else
        PAHF.debuglnAuthor("Attempted to Re-Hook: [initHooksOnMerchantsAndBuyback]")
    end
end

-- this function only needs to be initialized ONCE
local function initHooksOnCraftingStations()
    if not _hooksOnCraftingStationsInitialized then
        _hooksOnCraftingStationsInitialized = true
        ZO_PreHook(ZO_SmithingTopLevelDeconstructionPanelInventoryBackpack.dataTypes[1], "setupCallback", function(...)
            local control = ...
            if control.slotControlType and control.slotControlType == 'listSlot' and control.dataEntry.data.slotIndex then
                local bagId = control.dataEntry.data.bagId
                local slotIndex = control.dataEntry.data.slotIndex
                local itemLink = _getOrCreateDataEntryItemLink(control.dataEntry.data)
                _addItemKnownOrUnknownVisuals(control, itemLink, HOOK_CRAFTSTATION)
                _addSetCollectionVisuals(control, itemLink, HOOK_CRAFTSTATION)
                _addCompanionItemVisuals(control, itemLink, HOOK_CRAFTSTATION)
            end
        end)

        ZO_PreHook(ZO_SmithingTopLevelImprovementPanelInventoryBackpack.dataTypes[1], "setupCallback", function(...)
            local control = ...
            if control.slotControlType and control.slotControlType == 'listSlot' and control.dataEntry.data.slotIndex then
                local bagId = control.dataEntry.data.bagId
                local slotIndex = control.dataEntry.data.slotIndex
                local itemLink = _getOrCreateDataEntryItemLink(control.dataEntry.data)
                _addItemKnownOrUnknownVisuals(control, itemLink, HOOK_CRAFTSTATION)
                _addSetCollectionVisuals(control, itemLink, HOOK_CRAFTSTATION)
                _addCompanionItemVisuals(control, itemLink, HOOK_CRAFTSTATION)
            end
        end)

        ZO_PreHook(ZO_SmithingTopLevelRefinementPanelInventoryBackpack.dataTypes[1], "setupCallback", function(...)
            local control = ...
            if control.slotControlType and control.slotControlType == 'listSlot' and control.dataEntry.data.slotIndex then
                local bagId = control.dataEntry.data.bagId
                local slotIndex = control.dataEntry.data.slotIndex
                local itemLink = _getOrCreateDataEntryItemLink(control.dataEntry.data)
                _addItemKnownOrUnknownVisuals(control, itemLink, HOOK_CRAFTSTATION)
                _addSetCollectionVisuals(control, itemLink, HOOK_CRAFTSTATION)
                _addCompanionItemVisuals(control, itemLink, HOOK_CRAFTSTATION)
            end
        end)
    else
        PAHF.debuglnAuthor("Attempted to Re-Hook: [initHooksOnCraftingStations]")
    end
end

-- this function only needs to be initialized ONCE
local function initHooksOnLootWindow()
    if not _hooksOnLootWindowInitialized then
        _hooksOnLootWindowInitialized = true
        ZO_PreHook(ZO_LootAlphaContainerList.dataTypes[1], "setupCallback", function(...)
            local control = ...
            if control.slotControlType and control.slotControlType == 'listSlot' and control.dataEntry.data.lootId then
                local itemLink = GetLootItemLink(control.dataEntry.data.lootId)
                _addItemKnownOrUnknownVisuals(control, itemLink, HOOK_LOOT)
                _addSetCollectionVisuals(control, itemLink, HOOK_LOOT)
                _addCompanionItemVisuals(control, itemLink, HOOK_LOOT)
            end
        end)
    else
        PAHF.debuglnAuthor("Attempted to Re-Hook: [initHooksOnLootWindow]")
    end
end

local function initKnown()
    -- TODO: really needed/wanted?
    -- TODO: InitKnown                  /   EVENT_RECIPE_LEARNED / EVENT_STYLE_LEARNED / EVENT_TRAIT_LEARNED
end

-- =====================================================================================================================
-- Export
PA.Loot = PA.Loot or {}
PA.Loot.ItemIcons = {
    refreshScrollListVisible = refreshScrollListVisible,
    initHooksOnBags = initHooksOnBags,
    initHooksOnTradeHouse = initHooksOnTradeHouse,
    initHooksOnMerchantsAndBuyback = initHooksOnMerchantsAndBuyback,
    initHooksOnCraftingStations = initHooksOnCraftingStations,
    initHooksOnLootWindow = initHooksOnLootWindow,
}