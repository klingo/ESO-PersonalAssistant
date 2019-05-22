-- Local instances of Global tables --
local PA = PersonalAssistant
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local LCM = LibCustomMenu or LibStub("LibCustomMenu")
local _hooksOnInventoryContextMenuInitialized = false


local function _addDynamicContextMenuEntries(itemLink, inventorySlot)

    -- TODO: check settings and prepare entrylist
    zo_callLater(function()
--        AddCustomMenuItem("Custom Menu Item", function() d("test") end)
--        ShowMenu(inventorySlot)

        local entries = {
            {
                label = "Mark as permanent junk",
                callback = function() d("Test 1") end,
            },
            {
                label = "-",
            },
            {
                label = "Add custom banking rule",
                callback = function() d("Test 2") end,
                disabled = function(rootMenu, childControl) return true end,
            }
        }
        --    ClearMenu()
        AddCustomSubMenuItem("PA Banking", entries)
    end, 50)
end

local function _getSlotTypeName(slotType)
    if slotType == SLOT_TYPE_ITEM then return "SLOT_TYPE_ITEM" end
    if slotType == SLOT_TYPE_CRAFT_BAG_ITEM then return "SLOT_TYPE_CRAFT_BAG_ITEM" end
    if slotType == SLOT_TYPE_EQUIPMENT then return "SLOT_TYPE_EQUIPMENT" end
    if slotType == SLOT_TYPE_BANK_ITEM then return "SLOT_TYPE_BANK_ITEM" end
    if slotType == SLOT_TYPE_GUILD_BANK_ITEM then return "SLOT_TYPE_GUILD_BANK_ITEM" end
    if slotType == SLOT_TYPE_TRADING_HOUSE_ITEM_RESULT then return "SLOT_TYPE_TRADING_HOUSE_ITEM_RESULT" end
    if slotType == SLOT_TYPE_TRADING_HOUSE_ITEM_LISTING then return "SLOT_TYPE_TRADING_HOUSE_ITEM_LISTING" end
    if slotType == SLOT_TYPE_TRADING_HOUSE_POST_ITEM then return "SLOT_TYPE_TRADING_HOUSE_POST_ITEM" end
    if slotType == SLOT_TYPE_REPAIR then return "SLOT_TYPE_REPAIR" end
    if slotType == SLOT_TYPE_CRAFTING_COMPONENT then return "SLOT_TYPE_CRAFTING_COMPONENT" end
    if slotType == SLOT_TYPE_PENDING_CRAFTING_COMPONENT then return "SLOT_TYPE_PENDING_CRAFTING_COMPONENT" end
    if slotType == SLOT_TYPE_TRADING_HOUSE_ITEM_RESULT then return "SLOT_TYPE_TRADING_HOUSE_ITEM_RESULT" end
    if slotType == SLOT_TYPE_TRADING_HOUSE_ITEM_LISTING then return "SLOT_TYPE_TRADING_HOUSE_ITEM_LISTING" end
    if slotType == SLOT_TYPE_LAUNDER then return "SLOT_TYPE_LAUNDER" end
    if slotType == SLOT_TYPE_LIST_DIALOG_ITEM then return "SLOT_TYPE_LIST_DIALOG_ITEM" end
    if slotType == SLOT_TYPE_LOOT then return "SLOT_TYPE_LOOT" end
    if slotType == SLOT_TYPE_MAIL_ATTACHMENT then return "SLOT_TYPE_MAIL_ATTACHMENT" end
    if slotType == SLOT_TYPE_MAIL_QUEUED_ATTACHMENT then return "SLOT_TYPE_MAIL_QUEUED_ATTACHMENT" end
    if slotType == SLOT_TYPE_MY_TRADE then return "SLOT_TYPE_MY_TRADE" end
    if slotType == SLOT_TYPE_PENDING_CHARGE then return "SLOT_TYPE_PENDING_CHARGE" end
    if slotType == SLOT_TYPE_PENDING_REPAIR then return "SLOT_TYPE_PENDING_REPAIR" end
    if slotType == SLOT_TYPE_PENDING_RETRAIT_ITEM then return "SLOT_TYPE_PENDING_RETRAIT_ITEM" end
    if slotType == SLOT_TYPE_QUEST_ITEM then return "SLOT_TYPE_QUEST_ITEM" end
    if slotType == SLOT_TYPE_SMITHING_BOOSTER then return "SLOT_TYPE_SMITHING_BOOSTER" end
    if slotType == SLOT_TYPE_SMITHING_BOOSTER then return "SLOT_TYPE_SMITHING_BOOSTER" end
    if slotType == SLOT_TYPE_SMITHING_STYLE then return "SLOT_TYPE_SMITHING_STYLE" end
    if slotType == SLOT_TYPE_SMITHING_TRAIT then return "SLOT_TYPE_SMITHING_TRAIT" end
    if slotType == SLOT_TYPE_STACK_SPLIT then return "SLOT_TYPE_STACK_SPLIT" end
    if slotType == SLOT_TYPE_STORE_BUY then return "SLOT_TYPE_STORE_BUY" end
    if slotType == SLOT_TYPE_STORE_BUYBACK then return "SLOT_TYPE_STORE_BUYBACK" end
    if slotType == SLOT_TYPE_THEIR_TRADE then return "SLOT_TYPE_THEIR_TRADE" end

    return tostring(slotType)
end

local function initHooksOnInventoryContextMenu()
    if not _hooksOnInventoryContextMenuInitialized then
        _hooksOnInventoryContextMenuInitialized = true
        ZO_PreHook('ZO_InventorySlot_ShowContextMenu',
            function(inventorySlot)
                -- TODO: if settings are turned ON, then
                local slotType = ZO_InventorySlot_GetType(inventorySlot)
                d("slotType=".._getSlotTypeName(slotType))
                if slotType == SLOT_TYPE_ITEM or slotType == SLOT_TYPE_BANK_ITEM or
                        slotType == SLOT_TYPE_GUILD_BANK_ITEM then
                    local bagId, slotIndex = ZO_Inventory_GetBagAndIndex(inventorySlot)
                    local itemLink = GetItemLink(bagId, slotIndex)
                    _addDynamicContextMenuEntries(itemLink, inventorySlot)
                end

    --            if slotType == SLOT_TYPE_TRADING_HOUSE_ITEM_RESULT then
    --                link = GetTradingHouseSearchResultItemLink(ZO_Inventory_GetSlotIndex(inventorySlot))
    --            end
    --            if slotType == SLOT_TYPE_TRADING_HOUSE_ITEM_LISTING then
    --                link = GetTradingHouseListingItemLink(ZO_Inventory_GetSlotIndex(inventorySlot))
    --            end

    --            SLOT_TYPE_TRADING_HOUSE_POST_ITEM
    --            SLOT_TYPE_REPAIR

    --            SLOT_TYPE_PENDING_CRAFTING_COMPONENT
    --            SLOT_TYPE_TRADING_HOUSE_ITEM_RESULT
    --            SLOT_TYPE_TRADING_HOUSE_ITEM_LISTING

    --            SLOT_TYPE_LAUNDER
    --            SLOT_TYPE_LIST_DIALOG_ITEM
    --            SLOT_TYPE_MAIL_ATTACHMENT
    --            SLOT_TYPE_MAIL_QUEUED_ATTACHMENT
    --            SLOT_TYPE_MY_TRADE
    --            SLOT_TYPE_PENDING_CHARGE
    --            SLOT_TYPE_PENDING_REPAIR
    --            SLOT_TYPE_PENDING_RETRAIT_ITEM
    --            SLOT_TYPE_QUEST_ITEM
    --            SLOT_TYPE_SMITHING_BOOSTER
    --            SLOT_TYPE_SMITHING_MATERIAL
    --            SLOT_TYPE_SMITHING_STYLE
    --            SLOT_TYPE_SMITHING_TRAIT
    --            SLOT_TYPE_STACK_SPLIT
    --            SLOT_TYPE_STORE_BUY
    --            SLOT_TYPE_STORE_BUYBACK
    --            SLOT_TYPE_THEIR_TRADE



                -- TODO: confirmed to be added to scope
                -- SLOT_TYPE_CRAFTING_COMPONENT                 crafting components & items to be deconstructed & improvements

                -- TODO: confirmed to be out of scope
                -- SLOT_TYPE_EQUIPMENT                          worn equipment
                -- SLOT_TYPE_LOOT                               loot window
                -- SLOT_TYPE_TRADING_HOUSE_ITEM_RESULT          trading house search results
            end
        )
    else
        PAHF.debuglnAuthor("Attempted to Re-Hook: [initHooksOnInventoryContextMenu]")
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.ItemContextMenu = {
    initHooksOnInventoryContextMenu = initHooksOnInventoryContextMenu
}
