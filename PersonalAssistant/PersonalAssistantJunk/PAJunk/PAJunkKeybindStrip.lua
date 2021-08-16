-- Local instances of Global tables --
local PA = PersonalAssistant
local PAJ = PA.Junk
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local _mouseOverBagId, _mouseOverSlotIndex, _mouseOverStackCount, _mouseOverIsJunk

local function _isMarkUnmarkAsJunkVisible()
    if not (_mouseOverBagId and _mouseOverSlotIndex) then return false end
    local PAJSV = PA.Junk.SavedVars
    if PAJSV and PAJSV.KeyBindings.enableMarkUnmarkAsJunkKeybind and PAJSV.KeyBindings.showMarkUnmarkAsJunkKeybind then
        -- also return false when item is already marked as perm junk
        if PA.Junk.Custom.isItemPermanentJunk(_mouseOverBagId, _mouseOverSlotIndex) then
            return false
        end
        return PAHF.CanItemBeMarkedAsJunkExt(_mouseOverBagId, _mouseOverSlotIndex)
    end
    return false
end

local function _isMarkUnmarkAsJunkEnabled()
    if not (_mouseOverBagId and _mouseOverSlotIndex) then return false end
    local PAJSV = PA.Junk.SavedVars
    if PAJSV and PAJSV.KeyBindings.enableMarkUnmarkAsJunkKeybind then
        -- also return false when item is already marked as perm junk
        if PA.Junk.Custom.isItemPermanentJunk(_mouseOverBagId, _mouseOverSlotIndex) then
            return false
        end
        return PAHF.CanItemBeMarkedAsJunkExt(_mouseOverBagId, _mouseOverSlotIndex)
    end
    return false
end

local function _isMarkUnmarkAsPermJunkVisible()
    if not (_mouseOverBagId and _mouseOverSlotIndex) then return false end
    local PAJSV = PA.Junk.SavedVars
    if PAJSV and PAJSV.KeyBindings.enableMarkUnmarkAsPermJunkKeybind and PAJSV.KeyBindings.showMarkUnmarkAsPermJunkKeybind then
        return PAHF.CanItemBeMarkedAsJunkExt(_mouseOverBagId, _mouseOverSlotIndex)
    end
    return false
end

local function _isMarkUnmarkAsPermJunkEnabled()
    if not (_mouseOverBagId and _mouseOverSlotIndex) then return false end
    local PAJSV = PA.Junk.SavedVars
    if PAJSV and PAJSV.KeyBindings.enableMarkUnmarkAsPermJunkKeybind then
        return PAHF.CanItemBeMarkedAsJunkExt(_mouseOverBagId, _mouseOverSlotIndex)
    end
    return false
end

local function _isDestroyItemVisible()
    if not (_mouseOverBagId and _mouseOverSlotIndex) then return false end
    local PAJSV = PA.Junk.SavedVars
    return PAJSV and PAJSV.KeyBindings.enableDestroyItemKeybind and PAJSV.KeyBindings.showDestroyItemKeybind
end

local function _isDestroyItemEnabled()
    if not (_mouseOverBagId and _mouseOverSlotIndex) then return false end
    local PAJSV = PA.Junk.SavedVars
    if not PAJSV or not PAJSV.KeyBindings.enableDestroyItemKeybind then return false end

    if IsItemPlayerLocked(_mouseOverBagId, _mouseOverSlotIndex) then return false end
    if GetItemFunctionalQuality(_mouseOverBagId, _mouseOverSlotIndex) >= PAJSV.KeyBindings.destroyItemQualityThreshold then return false end

    if PAJSV.KeyBindings.destroyExcludeUnknownItems then
        local itemType, specializedItemType = GetItemType(_mouseOverBagId, _mouseOverSlotIndex)
        local itemLink = GetItemLink(_mouseOverBagId, _mouseOverSlotIndex)
        if itemType == ITEMTYPE_RECIPE then
            -- check for unknown recipes
            if not IsItemLinkRecipeKnown(itemLink) then return false end
        elseif itemType == ITEMTYPE_RACIAL_STYLE_MOTIF then
            -- check for unknown motifs
            if IsItemLinkBook(itemLink) and not IsItemLinkBookKnown(itemLink) then return false end
        elseif specializedItemType == SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE or specializedItemType == SPECIALIZED_ITEMTYPE_COLLECTIBLE_STYLE_PAGE then
            -- check for unknown style page containers
            local containerCollectibleId = GetItemLinkContainerCollectibleId(itemLink)
            local isValidForPlayer = IsCollectibleValidForPlayer(containerCollectibleId)
            local isUnlocked = IsCollectibleUnlocked(containerCollectibleId)
            if isValidForPlayer and not isUnlocked then return false end
        else
            -- check for unknown traits
            local itemFilterType = GetItemFilterTypeInfo(_mouseOverBagId, _mouseOverSlotIndex)
            if itemFilterType == ITEMFILTERTYPE_ARMOR or itemFilterType == ITEMFILTERTYPE_WEAPONS or itemFilterType == ITEMFILTERTYPE_JEWELRY then
                if CanItemLinkBeTraitResearched(itemLink) then return false end
            end
        end
    end

    -- if there was no reason to NOT have it enabled, return true
    return true
end

-- ---------------------------------------------------------------------------------------------------------------------

local PAJunkButtonGroup = {
    {
        name = "PAJunk_MarkUnmarkAsJunk",
        keybind = "PA_JUNK_TOGGLE_ITEM",
        callback = function() end, -- only called when directly clicked on keybind strip
        visible = function() return _isMarkUnmarkAsJunkVisible() end,
        enabled = function() return _isMarkUnmarkAsJunkEnabled() end,
    },
    {
        name = "PAJunk_MarkUnmarkAsPermJunk",
        keybind = "PA_JUNK_PERMANENT_TOGGLE_ITEM",
        callback = function() end, -- only called when directly clicked on keybind strip
        visible = function() return _isMarkUnmarkAsPermJunkVisible() end,
        enabled = function() return _isMarkUnmarkAsPermJunkEnabled() end,
    },
    {
        name = GetString(SI_ITEM_ACTION_DESTROY),
        keybind = "PA_JUNK_DESTROY_ITEM",
        callback = function() end, -- only called when directly clicked on keybind strip
        visible = function() return _isDestroyItemVisible() end,
        enabled = function() return _isDestroyItemEnabled() end,
    },
    alignment = KEYBIND_STRIP_ALIGN_RIGHT,
}

-- ---------------------------------------------------------------------------------------------------------------------

-- checks if the provided bagId is in scope for the Keybind Strip
local function _isBagIdInScope(bagId)
    return bagId == BAG_BACKPACK or bagId == BAG_BANK or (bagId == BAG_SUBSCRIBER_BANK and IsESOPlusSubscriber())
    -- TODO: add BAG_HOUSE_BANK_ONE through BAG_HOUSE_BANK_THEN ?
end

local function _updateKeybindStripButtonNames()
    -- check if item is permanent junk
    if PA.Junk.Custom.isItemPermanentJunk(_mouseOverBagId, _mouseOverSlotIndex) then
        -- YES, only show "unmark as perm. junk"
        PAJunkButtonGroup[2].name = GetString(SI_PA_ITEM_ACTION_UNMARK_AS_PERM_JUNK)
    else
        -- check if item is already marked as junk (and not marked as perm junk)
        if _mouseOverIsJunk then
            -- YES; show "unmark as junk" and "mark as perm. junk"
            PAJunkButtonGroup[1].name = GetString(SI_ITEM_ACTION_UNMARK_AS_JUNK)
            PAJunkButtonGroup[2].name = GetString(SI_PA_ITEM_ACTION_MARK_AS_PERM_JUNK)
        else
            -- YES; show "mark as junk" and "mark as perm. junk"
            PAJunkButtonGroup[1].name = GetString(SI_ITEM_ACTION_MARK_AS_JUNK)
            PAJunkButtonGroup[2].name = GetString(SI_PA_ITEM_ACTION_MARK_AS_PERM_JUNK)
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------

-- store the important itemData information on MouseEnter
local function _onMouseEnter(itemControl)
    local itemData = itemControl.dataEntry.data
    _mouseOverBagId  = itemData.bagId
    _mouseOverSlotIndex = itemData.slotIndex
    _mouseOverStackCount = itemData.stackCount
    _mouseOverIsJunk = itemData.isJunk
    -- update/show the Keybind Strip
    _updateKeybindStripButtonNames()
    KEYBIND_STRIP:UpdateKeybindButtonGroup(PAJunkButtonGroup)
end

-- clear the stored itemData information on MouseExit
local function _onMouseExit()
    _mouseOverBagId = nil
    _mouseOverSlotIndex = nil
    _mouseOverStackCount = nil
    _mouseOverIsJunk = nil
    -- update/hide the Keybind Strip
    KEYBIND_STRIP:UpdateKeybindButtonGroup(PAJunkButtonGroup)
end

-- ---------------------------------------------------------------------------------------------------------------------

-- initialises the "OnMouseEnter" and "OnMouseExit" hooks, as well as adds creates Keybind Strip Button
local function initHooksOnInventoryItems()
    if not KEYBIND_STRIP:HasKeybindButtonGroup(PAJunkButtonGroup) then
        ZO_PreHook("ZO_InventorySlot_OnMouseEnter", function(inventorySlot)
            if inventorySlot.slotControlType == "listSlot" and inventorySlot.dataEntry and _isBagIdInScope(inventorySlot.dataEntry.data.bagId) then
                _onMouseEnter(inventorySlot)
            end
        end)

        ZO_PreHook("ZO_InventorySlot_OnMouseExit", function(inventorySlot)
            if inventorySlot.slotControlType == "listSlot" and inventorySlot.dataEntry and _isBagIdInScope(inventorySlot.dataEntry.data.bagId) then
                _onMouseExit(inventorySlot)
            end
        end)
        -- TODO: Support Gamepad Mode
        -- In Gamepad Mode, "ZO_InventorySlot_DiscoverSlotActionsFromActionList" is called 3-4 times per item,
        -- and "ZO_InventorySlot_GetType" about 4 times as often - so not ideal but maybe better than nothing?

        KEYBIND_STRIP:AddKeybindButtonGroup(PAJunkButtonGroup)
    else
        PAHF.debuglnAuthor("Attempted to Re-Add PAJunkButtonGroup: [initHooksOnInventoryItems]")
    end
end

local function toggleItemMarkedAsJunk()
    if PA.Junk.SavedVars and PA.Junk.SavedVars.KeyBindings.enableMarkUnmarkAsJunkKeybind then
        if _mouseOverBagId and _mouseOverSlotIndex then
            if PAHF.CanItemBeMarkedAsJunkExt(_mouseOverBagId, _mouseOverSlotIndex) then
                -- if item is already marked as permanent junk; skip function
                if PA.Junk.Custom.isItemPermanentJunk(_mouseOverBagId, _mouseOverSlotIndex) then return end
                -- get item information
                local itemLink = GetItemLink(_mouseOverBagId, _mouseOverSlotIndex, LINK_STYLE_BRACKETS)
                local itemLinkExt = PAHF.getIconExtendedItemLink(itemLink)
                -- execute main action
                SetItemIsJunk(_mouseOverBagId, _mouseOverSlotIndex, not _mouseOverIsJunk)
                -- inform player
                if not _mouseOverIsJunk then
                    PAJ.println(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_KEYBINDING, itemLinkExt)
                    PlaySound(SOUNDS.INVENTORY_ITEM_JUNKED)
                else
                    PlaySound(SOUNDS.INVENTORY_ITEM_UNJUNKED)
                end
            else
                PAHF.debuglnAuthor("Item cannot be marked as junk")
            end
        end
    end
end

local function toggleItemMarkedAsPermanentJunk()
    if PA.Junk.SavedVars and PAJ.SavedVars.Custom.customItemsEnabled and
            PA.Junk.SavedVars.KeyBindings.enableMarkUnmarkAsPermJunkKeybind then
        if _mouseOverBagId and _mouseOverSlotIndex then
            if PAHF.CanItemBeMarkedAsJunkExt(_mouseOverBagId, _mouseOverSlotIndex) then
                -- get item information
                local itemLinkPlain = GetItemLink(_mouseOverBagId, _mouseOverSlotIndex)
                if PA.Junk.Custom.isItemLinkPermanentJunk(itemLinkPlain) then
                    -- delete the permanent junk rule
                    PA.Junk.Custom.removeItemLinkFromPermanentJunk(itemLinkPlain)
                else
                    -- create new permanent junk rule
                    PA.Junk.Custom.addItemLinkToPermanentJunk(itemLinkPlain)
                    -- if a junked item is marked as perm-junk, the keybind strip needs to be updated
                    _updateKeybindStripButtonNames()
                    KEYBIND_STRIP:UpdateKeybindButtonGroup(PAJunkButtonGroup)
                end
            else
                PAHF.debuglnAuthor("Item cannot be marked as permanent junk")
            end
        end
    end
end

local function destroyItemNoWarning()
    if PA.Junk.SavedVars and PA.Junk.SavedVars.KeyBindings.enableDestroyItemKeybind then
        if _mouseOverBagId and _mouseOverSlotIndex then
            if _isDestroyItemEnabled() then
                -- get item information
                local itemSoundCategory = GetItemSoundCategory(_mouseOverBagId, _mouseOverSlotIndex)
                local itemLink = GetItemLink(_mouseOverBagId, _mouseOverSlotIndex, LINK_STYLE_BRACKETS)
                local itemLinkExt = PAHF.getIconExtendedItemLink(itemLink)
                -- execute main action
                DestroyItem(_mouseOverBagId, _mouseOverSlotIndex)
                -- inform player
                PlayItemSound(itemSoundCategory, ITEM_SOUND_ACTION_DESTROY)
                PAJ.println(SI_PA_CHAT_JUNK_DESTROYED_KEYBINDING, _mouseOverStackCount, itemLinkExt)
            end
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Junk = PA.Junk or {}
PA.Junk.KeybindStrip = {
    initHooksOnInventoryItems = initHooksOnInventoryItems,
    toggleItemMarkedAsJunk = toggleItemMarkedAsJunk,
    toggleItemMarkedAsPermanentJunk = toggleItemMarkedAsPermanentJunk,
    destroyItemNoWarning = destroyItemNoWarning
}