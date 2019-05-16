-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
local PAEM = PA.EventManager

-- ---------------------------------------------------------------------------------------------------------------------

local _writTable
local _someItemskippedForLWC = false

local function _passesLazyWritCraftingCompatibilityCheck(itemType)
    if WritCreater and WritCreater:GetSettings().shouldGrab and PAB.SavedVars.lazyWritCraftingCompatiblity then
        -- 3
        if _writTable[CRAFTING_TYPE_ENCHANTING] and (itemType == ITEMTYPE_GLYPH_ARMOR or itemType == ITEMTYPE_GLYPH_JEWELRY or itemType == ITEMTYPE_GLYPH_WEAPON) then
            return false
        -- 4
        elseif _writTable[CRAFTING_TYPE_ALCHEMY] and (itemType == ITEMTYPE_POTION or itemType == ITEMTYPE_POISON) then
            return false
        -- 5
        elseif _writTable[CRAFTING_TYPE_PROVISIONING] and (itemType == ITEMTYPE_FOOD or itemType == ITEMTYPE_DRINK) then
            return false
        end
    end
    -- either LazyWritCrafter is not installed/enabled, or the withdraw function is disabled; either way proceed
    return true
end

local function _doItemTransactions(depositFromBagCache, depositToBagCache, withdrawalFromBagCache, withdrawalToBagCache)
    -- call the generic version
    PAB.doGenericItemTransactions(depositFromBagCache, depositToBagCache, withdrawalFromBagCache, withdrawalToBagCache)
end

-- ---------------------------------------------------------------------------------------------------------------------

local function depositOrWithdrawAdvancedItems()

    PAHF.debugln("PA.Banking.depositOrWithdrawAdvancedItems")

    if PAB.SavedVars.Advanced.advancedItemsEnabled then
        -- check if bankTransfer is already blocked
        if PAB.isBankTransferBlocked then return end
        PAB.isBankTransferBlocked = true

        -- get the writ quest table if LazyWritCrafter is enabled
        if WritCreater then
            _writTable = WritCreater.writSearch()
        end

        -- prepare the table with itemTypes to deposit and withdraw
        local combinedDepositLists = {
            masterWritCraftingTypes = setmetatable({}, { __index = table })
        }
        local combinedWithdrawLists = {
            masterWritCraftingTypes = setmetatable({}, { __index = table })
        }
        local depositLearnableKnownItemTypes = setmetatable({}, { __index = table })
        local depositLearnableUnknownItemTypes = setmetatable({}, { __index = table })
        local depositItemTypes = setmetatable({}, { __index = table })
        local depositSpecializedItemTypes = setmetatable({}, { __index = table })
        local depositTraitItemTypes = setmetatable({}, { __index = table })
        local withdrawLearnableKnownItemTypes = setmetatable({}, { __index = table })
        local withdrawLearnableUnknownItemTypes = setmetatable({}, { __index = table })
        local withdrawItemTypes = setmetatable({}, { __index = table })
        local withdrawSpezializedItemTypes = setmetatable({}, { __index = table })
        local withdrawTraitItemTypes = setmetatable({}, { __index = table })

        -- fill up the table(s)
        for itemType, moveModeTbl in pairs(PAB.SavedVars.Advanced.LearnableItemTypes) do
            for knownUnknown, moveMode in pairs(moveModeTbl) do
                if moveMode == PAC.MOVE.DEPOSIT then
                    if knownUnknown == "Known" then
                        depositLearnableKnownItemTypes:insert(itemType)
                    else
                        depositLearnableUnknownItemTypes:insert(itemType)
                    end
                elseif moveMode == PAC.MOVE.WITHDRAW then
                    if knownUnknown == "Known" then
                        withdrawLearnableKnownItemTypes:insert(itemType)
                    else
                        withdrawLearnableUnknownItemTypes:insert(itemType)
                    end
                end
            end
        end
        for craftingType, moveMode in pairs(PAB.SavedVars.Advanced.MasterWritCraftingTypes) do
            if moveMode == PAC.MOVE.DEPOSIT then
                combinedDepositLists.masterWritCraftingTypes:insert(craftingType)
            elseif moveMode == PAC.MOVE.WITHDRAW then
                combinedWithdrawLists.masterWritCraftingTypes:insert(craftingType)
            end
        end
        for itemType, moveMode in pairs(PAB.SavedVars.Advanced.ItemTypes) do
            if moveMode == PAC.MOVE.DEPOSIT then
                if _passesLazyWritCraftingCompatibilityCheck(itemType) then
                    depositItemTypes:insert(itemType)
                else
                    _someItemskippedForLWC = true
                    PAHF.debugln("skip [%s] because of LWC compatibility", GetString("SI_ITEMTYPE", itemType))
                end
            elseif moveMode == PAC.MOVE.WITHDRAW then
                withdrawItemTypes:insert(itemType)
            end
        end
        for specializedItemType, moveMode in pairs(PAB.SavedVars.Advanced.SpecializedItemTypes) do
            if moveMode == PAC.MOVE.DEPOSIT then
                depositSpecializedItemTypes:insert(specializedItemType)
            elseif moveMode == PAC.MOVE.WITHDRAW then
                withdrawSpezializedItemTypes:insert(specializedItemType)
            end
        end
        for traitItemType, moveMode in pairs(PAB.SavedVars.Advanced.ItemTraitTypes) do
            if moveMode == PAC.MOVE.DEPOSIT then
                depositTraitItemTypes:insert(traitItemType)
            elseif moveMode == PAC.MOVE.WITHDRAW then
                withdrawTraitItemTypes:insert(traitItemType)
            end
        end

        -- if some items were skipped because of LWC; display a message
        if _someItemskippedForLWC then
            PAB.println(SI_PA_CHAT_BANKING_ITEMS_SKIPPED_LWC)
            _someItemskippedForLWC = false
        end

        -- TODO: refactor other lists into [combinedDepositLists] and [combinedWithdrawLists]
        local depositComparator = PAHF.getCombinedItemTypeSpecializedComparator(combinedDepositLists, depositLearnableKnownItemTypes, depositLearnableUnknownItemTypes, depositItemTypes, depositSpecializedItemTypes, depositTraitItemTypes)
        local withdrawComparator = PAHF.getCombinedItemTypeSpecializedComparator(combinedWithdrawLists, withdrawLearnableKnownItemTypes, withdrawLearnableUnknownItemTypes, withdrawItemTypes, withdrawSpezializedItemTypes, withdrawTraitItemTypes)

        local toDepositBagCache = SHARED_INVENTORY:GenerateFullSlotData(depositComparator, BAG_BACKPACK)
        local toFillUpDepositBagCache = SHARED_INVENTORY:GenerateFullSlotData(depositComparator, BAG_BANK, BAG_SUBSCRIBER_BANK)

        local toWithdrawBagCache = SHARED_INVENTORY:GenerateFullSlotData(withdrawComparator, BAG_BANK, BAG_SUBSCRIBER_BANK)
        local toFillUpWithdrawBagCache = SHARED_INVENTORY:GenerateFullSlotData(withdrawComparator, BAG_BACKPACK)

        -- trigger the itemTransactions
        _doItemTransactions(toDepositBagCache, toFillUpDepositBagCache, toWithdrawBagCache, toFillUpWithdrawBagCache)
    else
        -- else, continue with the next function in queue
        PAEM.executeNextFunctionInQueue(PAB.AddonName)
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.depositOrWithdrawAdvancedItems = depositOrWithdrawAdvancedItems