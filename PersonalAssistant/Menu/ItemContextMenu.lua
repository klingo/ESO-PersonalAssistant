-- Local instances of Global tables --
local PA = PersonalAssistant
local PAHF = PA.HelperFunctions
local PAProfileManager = PA.ProfileManager

-- ---------------------------------------------------------------------------------------------------------------------

local _hooksOnInventoryContextMenuInitialized = false

local function _isBankingRuleNotAllowed(itemLink, bagId, slotIndex)
    local itemType = GetItemType(bagId, slotIndex)
    if itemType == ITEMTYPE_RACIAL_STYLE_MOTIF then return true end
    if itemType == ITEMTYPE_RECIPE then return true end
    if itemType == ITEMTYPE_MASTER_WRIT then return true end
    if itemType == ITEMTYPE_AVA_REPAIR then return true end
    if PAHF.isItemLinkCharacterBound(itemLink) then return true end
    -- TODO: add logic to also check other itemTypes that are already covered! --> Crafting Materials?
    return false
end

local function _addDynamicContextMenuEntries(itemLink, bagId, slotIndex)
    local paItemId = PAHF.getPAItemLinkIdentifier(itemLink)

    -- Add PABanking context menu entries
    if PAProfileManager.PABanking and PAProfileManager.PABanking.hasActiveProfile() then
        if PA.Banking and PA.Banking.SavedVars.Custom.customItemsEnabled then
            -- first make some checks whether banking rules are even allowed for this item
            if not _isBankingRuleNotAllowed(itemLink, bagId, slotIndex) then
                local PABCustomPAItemIds = PA.Banking.SavedVars.Custom.PAItemIds
                local isRuleExisting = PAHF.isKeyInTable(PABCustomPAItemIds, paItemId)
                local entries = {
                    {
                        label = GetString(SI_PA_SUBMENU_PAB_ADD_RULE),
                        callback = function()
                            PA.CustomDialogs.initPABAddCustomRuleUIDialog()
                            PA.CustomDialogs.showPABAddCustomRuleUIDIalog(itemLink)
                        end,
                        disabled = function() return isRuleExisting end,
                    },
                    {
                        label = GetString(SI_PA_SUBMENU_PAB_EDIT_RULE),
                        callback = function()
                            PA.CustomDialogs.initPABAddCustomRuleUIDialog()
                            PA.CustomDialogs.showPABAddCustomRuleUIDIalog(itemLink, PABCustomPAItemIds[paItemId])
                        end,
                        disabled = function() return not isRuleExisting end,
                    },
                    {
                        label = GetString(SI_PA_SUBMENU_PAB_DELETE_RULE),
                        callback = function()
                            PA.CustomDialogs.initPABAddCustomRuleUIDialog()
                            PA.CustomDialogs.deletePABCustomRule(itemLink)
                        end,
                        disabled = function() return not isRuleExisting end,
                    }
                }
                AddCustomSubMenuItem(GetString(SI_PA_SUBMENU_PAB), entries)
            end
        end
    end

    -- Add PAJunk context menu entries
    if PAProfileManager.PAJunk and PAProfileManager.PAJunk.hasActiveProfile() then
        if PA.Junk and PA.Junk.SavedVars.Custom.customItemsEnabled then
            local canBeMarkedAsJunk = PAHF.CanItemBeMarkedAsJunkExt(bagId, slotIndex)
            if canBeMarkedAsJunk then
                local PAJCustomPAItemIds = PA.Junk.SavedVars.Custom.PAItemIds
                local isRuleExisting = PAHF.isKeyInTable(PAJCustomPAItemIds, paItemId)
                local entries = {
                    {
                        label = GetString(SI_PA_SUBMENU_PAJ_MARK_PERM_JUNK),
                        callback = function()
                            PA.Junk.Custom.addItemLinkToPermanentJunk(itemLink)
                        end,
                        disabled = function() return isRuleExisting end,
                    },
                    {
                        label = GetString(SI_PA_SUBMENU_PAJ_UNMARK_PERM_JUNK),
                        callback = function()
                            PA.Junk.Custom.removeItemLinkFromPermanentJunk(itemLink)
                        end,
                        disabled = function() return not isRuleExisting end,
                    }
                }
                AddCustomSubMenuItem(GetString(SI_PA_SUBMENU_PAJ), entries)
            end
        end
    end
end

local function _getSlotTypeName(slotType)
    if slotType == SLOT_TYPE_TRADING_HOUSE_ITEM_LISTING then return "SLOT_TYPE_TRADING_HOUSE_ITEM_LISTING" end
    if slotType == SLOT_TYPE_TRADING_HOUSE_POST_ITEM then return "SLOT_TYPE_TRADING_HOUSE_POST_ITEM" end
    if slotType == SLOT_TYPE_PENDING_CRAFTING_COMPONENT then return "SLOT_TYPE_PENDING_CRAFTING_COMPONENT" end
    if slotType == SLOT_TYPE_LAUNDER then return "SLOT_TYPE_LAUNDER" end
    if slotType == SLOT_TYPE_LIST_DIALOG_ITEM then return "SLOT_TYPE_LIST_DIALOG_ITEM" end
    if slotType == SLOT_TYPE_MY_TRADE then return "SLOT_TYPE_MY_TRADE" end
    if slotType == SLOT_TYPE_PENDING_CHARGE then return "SLOT_TYPE_PENDING_CHARGE" end
    if slotType == SLOT_TYPE_PENDING_REPAIR then return "SLOT_TYPE_PENDING_REPAIR" end
    if slotType == SLOT_TYPE_PENDING_RETRAIT_ITEM then return "SLOT_TYPE_PENDING_RETRAIT_ITEM" end
    if slotType == SLOT_TYPE_SMITHING_BOOSTER then return "SLOT_TYPE_SMITHING_BOOSTER" end
    if slotType == SLOT_TYPE_SMITHING_BOOSTER then return "SLOT_TYPE_SMITHING_BOOSTER" end
    if slotType == SLOT_TYPE_SMITHING_STYLE then return "SLOT_TYPE_SMITHING_STYLE" end
    if slotType == SLOT_TYPE_SMITHING_TRAIT then return "SLOT_TYPE_SMITHING_TRAIT" end
    if slotType == SLOT_TYPE_STACK_SPLIT then return "SLOT_TYPE_STACK_SPLIT" end
    if slotType == SLOT_TYPE_THEIR_TRADE then return "SLOT_TYPE_THEIR_TRADE" end

    return tostring(slotType)
end

local function initHooksOnInventoryContextMenu(LCM)
    if (PAProfileManager.PABanking and PAProfileManager.PABanking.hasActiveProfile()) or
            (PAProfileManager.PAJunk and PAProfileManager.PAJunk.hasActiveProfile()) then
        if not _hooksOnInventoryContextMenuInitialized and (PA.Banking or PA.Junk) then
            _hooksOnInventoryContextMenuInitialized = true
            LCM:RegisterContextMenu(function(inventorySlot, slotActions)
                    local slotType = ZO_InventorySlot_GetType(inventorySlot)
                    if slotType == SLOT_TYPE_ITEM or slotType == SLOT_TYPE_BANK_ITEM then
                        local bagId, slotIndex = ZO_Inventory_GetBagAndIndex(inventorySlot)
                        local itemLink = GetItemLink(bagId, slotIndex)
                        _addDynamicContextMenuEntries(itemLink, bagId, slotIndex)
                        ShowMenu()
                    end

                    -- PA.println(_getSlotTypeName(slotType))

                    -- if slotType == SLOT_TYPE_TRADING_HOUSE_ITEM_LISTING then
                    --     link = GetTradingHouseListingItemLink(ZO_Inventory_GetSlotIndex(inventorySlot))
                    -- end

                    -- TODO: still to be checked if needed or not
                    -- SLOT_TYPE_TRADING_HOUSE_POST_ITEM
                    -- SLOT_TYPE_PENDING_CRAFTING_COMPONENT
                    -- SLOT_TYPE_TRADING_HOUSE_ITEM_LISTING
                    -- SLOT_TYPE_LAUNDER
                    -- SLOT_TYPE_LIST_DIALOG_ITEM
                    -- SLOT_TYPE_MY_TRADE
                    -- SLOT_TYPE_PENDING_CHARGE
                    -- SLOT_TYPE_PENDING_REPAIR
                    -- SLOT_TYPE_PENDING_RETRAIT_ITEM
                    -- SLOT_TYPE_SMITHING_BOOSTER
                    -- SLOT_TYPE_SMITHING_MATERIAL
                    -- SLOT_TYPE_SMITHING_STYLE
                    -- SLOT_TYPE_SMITHING_TRAIT
                    -- SLOT_TYPE_STACK_SPLIT
                    -- SLOT_TYPE_THEIR_TRADE


                    -- TODO: confirmed to be added to scope
                    -- SLOT_TYPE_ITEM                               inventory/backpack
                    -- SLOT_TYPE_BANK_ITEM                          bank


                    -- TODO: confirmed to be out of scope
                    -- SLOT_TYPE_EQUIPMENT                          worn equipment
                    -- SLOT_TYPE_LOOT                               loot window
                    -- SLOT_TYPE_CRAFT_BAG_ITEM                     craft bag
                    -- SLOT_TYPE_TRADING_HOUSE_ITEM_RESULT          trading house search results
                    -- SLOT_TYPE_STORE_BUY                          buying from store
                    -- SLOT_TYPE_STORE_BUYBACK                      buyback from store
                    -- SLOT_TYPE_REPAIR                             repair in store
                    -- SLOT_TYPE_QUEST_ITEM                         quest items
                    -- SLOT_TYPE_CRAFTING_COMPONENT                 crafting components & items to be deconstructed & improvements
                    -- SLOT_TYPE_MAIL_ATTACHMENT                    received mail attachments
                    -- SLOT_TYPE_MAIL_QUEUED_ATTACHMENT             attached items in mail to be sent
                    -- SLOT_TYPE_GUILD_BANK_ITEM                    guild bank
                end
            )
        else
            PAHF.debuglnAuthor("Attempted to Re-Hook: [initHooksOnInventoryContextMenu]")
        end
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.ItemContextMenu = {
    initHooksOnInventoryContextMenu = initHooksOnInventoryContextMenu
}
