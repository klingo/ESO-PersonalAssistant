-- Local instances of Global tables --
local PA = PersonalAssistant
local PAJ = PA.Junk
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local _mouseOverBagId, _mouseOverSlotIndex, _mouseOverIsJunk, _mouseOverCanBeMarkedAsJunk, _mouseOverCanBeDestroyed

local keyBindSettings = {
    markUnmarkAsJunk = {
        isEnabled = false,
        isVisible = false,
    },
    destroyItemNoWarning = {
        isEnabled = false,
        isVisible = false,
    }
}

local PAJunkButtonGroup = {
    {
        name = "PAJunk_MarkUnmarkAsJunk",
        keybind = "PA_JUNK_TOGGLE_ITEM",
        callback = function() end, -- only called when directly clicked on keybind strip?
        visible = function() return keyBindSettings.markUnmarkAsJunk.isVisible end,
        enabled = function() return keyBindSettings.markUnmarkAsJunk.isEnabled end,
    },
    {
        name = GetString(SI_ITEM_ACTION_DESTROY),
        keybind = "PA_JUNK_DESTROY_ITEM",
        callback = function() end, -- only called when directly clicked on keybind strip?
        visible = function() return keyBindSettings.destroyItemNoWarning.isVisible end,
        enabled = function() return keyBindSettings.destroyItemNoWarning.isEnabled end,
    },
    alignment = KEYBIND_STRIP_ALIGN_RIGHT,
}

-- ---------------------------------------------------------------------------------------------------------------------

-- checks if the provided bagId is in scope for the Keybind Strip
local function _isBagIdInScope(bagId)
    return bagId == BAG_BACKPACK or bagId == BAG_BANK or bagId == BAG_SUBSCRIBER_BANK
    -- TODO: add BAG_HOUSE_BANK_ONE through BAG_HOUSE_BANK_THEN ?
end

local function _updateVisibleAndEnabledForKeybindStrip()
    -- update button names if necessary
    if _mouseOverIsJunk then
        PAJunkButtonGroup[1].name = GetString(SI_ITEM_ACTION_UNMARK_AS_JUNK)
    else
        PAJunkButtonGroup[1].name = GetString(SI_ITEM_ACTION_MARK_AS_JUNK)
    end
    -- then update enabled state
    if _mouseOverCanBeMarkedAsJunk then
        keyBindSettings.markUnmarkAsJunk.isEnabled = true
    end
    if _mouseOverCanBeDestroyed then
        keyBindSettings.destroyItemNoWarning.isEnabled = true
    end
    -- finally, display the buttons
    for _, settingTbl in pairs(keyBindSettings) do
        settingTbl.isVisible = true
    end
    -- and update the KeybindStrip
    KEYBIND_STRIP:UpdateKeybindButtonGroup(PAJunkButtonGroup)
end

local function _hideKeybindStrip()
    -- set isVisible=false and isEnabled=false for all settings
    for _, settingTbl in pairs(keyBindSettings) do
        settingTbl.isVisible = false
        settingTbl.isEnabled = false
    end
    -- and update the KeybindStrip
    KEYBIND_STRIP:UpdateKeybindButtonGroup(PAJunkButtonGroup)
end

local function _isItemAllowedToBeMarkedAsJunk(bagId, slotIndex)
    return CanItemBeMarkedAsJunk(bagId, slotIndex)
end

local function _isItemAllowedToBeDestroyed(bagId, slotIndex)
    if GetItemQuality(bagId, slotIndex) < ITEM_QUALITY_LEGENDARY then -- TODO: extract from savedvars
       if not IsItemPlayerLocked(bagId, slotIndex) then
           return true
       end
    end
    return false
end

-- ---------------------------------------------------------------------------------------------------------------------

-- store the important itemData information on MouseEnter
local function _onMouseEnter(itemControl)
    local itemData = itemControl.dataEntry.data
    _mouseOverBagId  = itemData.bagId
    _mouseOverSlotIndex = itemData.slotIndex
    _mouseOverIsJunk = itemData.isJunk
    _mouseOverCanBeMarkedAsJunk = _isItemAllowedToBeMarkedAsJunk(itemData.bagId, itemData.slotIndex)
    _mouseOverCanBeDestroyed = _isItemAllowedToBeDestroyed(itemData.bagId, itemData.slotIndex)
    -- update/show the Keybind Strip
    _updateVisibleAndEnabledForKeybindStrip()
end

-- clear the stored itemData information on MouseExit
local function _onMouseExit()
    _mouseOverBagId = nil
    _mouseOverSlotIndex = nil
    _mouseOverIsJunk = nil
    _mouseOverCanBeMarkedAsJunk = nil
    _mouseOverCanBeDestroyed = nil
    -- update/hide the Keybind Strip
    _hideKeybindStrip()
end

-- ---------------------------------------------------------------------------------------------------------------------

-- initialises the "OnMouseEnter" and "OnMouseExit" hooks, as well as adds creates Keybind Strip Button
local function initHooksOnInventoryItems()
    ZO_PreHook("ZO_InventorySlot_OnMouseEnter", function(inventorySlot)
        if inventorySlot.slotControlType == "listSlot" and _isBagIdInScope(inventorySlot.dataEntry.data.bagId) then
            _onMouseEnter(inventorySlot)
        end
    end)

    ZO_PreHook("ZO_InventorySlot_OnMouseExit", function(inventorySlot)
        if inventorySlot.slotControlType == "listSlot" and inventorySlot.dataEntry and _isBagIdInScope(inventorySlot.dataEntry.data.bagId) then
            _onMouseExit(inventorySlot)
        end
    end)

    KEYBIND_STRIP:AddKeybindButtonGroup(PAJunkButtonGroup)
end

local function toggleItemMarkedAsJunk()
    if _mouseOverBagId and _mouseOverSlotIndex and _mouseOverCanBeMarkedAsJunk then
        SetItemIsJunk(_mouseOverBagId, _mouseOverSlotIndex, not _mouseOverIsJunk)
        local itemLink = GetItemLink(_mouseOverBagId, _mouseOverSlotIndex, LINK_STYLE_BRACKETS)
        local itemLinkExt = PAHF.getIconExtendedItemLink(itemLink)
        if not _mouseOverIsJunk then
            PAJ.println(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_KEYBINDING, itemLinkExt)
            PlaySound(SOUNDS.INVENTORY_ITEM_JUNKED)
        else
            PlaySound(SOUNDS.INVENTORY_ITEM_UNJUNKED)
        end
    end
end

local function destroyItemNoWarning()
    if _mouseOverBagId and _mouseOverSlotIndex and _mouseOverCanBeDestroyed then
        local itemSoundCategory = GetItemSoundCategory(_mouseOverBagId, _mouseOverSlotIndex)
        DestroyItem(_mouseOverBagId, _mouseOverSlotIndex)
        PlayItemSound(itemSoundCategory, ITEM_SOUND_ACTION_DESTROY)
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Junk = PA.Junk or {}
PA.Junk.KeybindStrip = {
    initHooksOnInventoryItems = initHooksOnInventoryItems,
    toggleItemMarkedAsJunk = toggleItemMarkedAsJunk,
    destroyItemNoWarning = destroyItemNoWarning
}