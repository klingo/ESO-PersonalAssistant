-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PAC = PA.Constants
local PAEM = PA.EventManager
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local _writTable

local function _passesLazyWritCraftingCompatibilityCheck(itemType)
    if PAB.hasLazyWritCrafterAndShouldGrabEnabled() then
        -- 1
        if _writTable[CRAFTING_TYPE_BLACKSMITHING] and
                (itemType == ITEMTYPE_BLACKSMITHING_MATERIAL or itemType == ITEMTYPE_STYLE_MATERIAL) then
            return false
        -- 2
        elseif _writTable[CRAFTING_TYPE_CLOTHIER] and
                (itemType == ITEMTYPE_CLOTHIER_MATERIAL or itemType == ITEMTYPE_STYLE_MATERIAL) then
            return false
        -- 3
        elseif _writTable[CRAFTING_TYPE_ENCHANTING] and
                (itemType == ITEMTYPE_ENCHANTING_RUNE_ASPECT or itemType == ITEMTYPE_ENCHANTING_RUNE_ESSENCE or
                        itemType == ITEMTYPE_ENCHANTING_RUNE_POTENCY or itemType == ITEMTYPE_GLYPH_ARMOR or
                        itemType == ITEMTYPE_GLYPH_JEWELRY or itemType == ITEMTYPE_GLYPH_WEAPON) then
            return false
        -- 4
        elseif _writTable[CRAFTING_TYPE_ALCHEMY] and
                (itemType == ITEMTYPE_REAGENT or itemType == ITEMTYPE_POISON_BASE or itemType == ITEMTYPE_POTION_BASE or
                        itemType == ITEMTYPE_POTION or itemType == ITEMTYPE_POISON) then
            return false
        -- 5
        elseif _writTable[CRAFTING_TYPE_PROVISIONING] and
                (itemType == ITEMTYPE_INGREDIENT or itemType == ITEMTYPE_FOOD or itemType == ITEMTYPE_DRINK) then
            return false
        -- 6
        elseif _writTable[CRAFTING_TYPE_WOODWORKING] and
                (itemType == ITEMTYPE_WOODWORKING_MATERIAL or itemType == ITEMTYPE_STYLE_MATERIAL) then
            return false
        -- 7
        elseif _writTable[CRAFTING_TYPE_JEWELRYCRAFTING] and
                (itemType == ITEMTYPE_JEWELRYCRAFTING_MATERIAL or itemType == ITEMTYPE_STYLE_MATERIAL) then
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

local function depositOrWithdrawCraftingItems()

    PAB.debugln("==============================================================")
    PAB.debugln("PA.Banking.depositOrWithdrawCraftingItems (1)")

    if PAB.SavedVars.Crafting.craftingItemsEnabled and not IsESOPlusSubscriber() then
        -- get the writ quest table if LazyWritCrafter is enabled
        if WritCreater then
            _writTable = WritCreater.writSearch()
        end

        -- prepare the table with itemTypes to deposit and withdraw
        local depositItemTypes = setmetatable({}, { __index = table })
        local withdrawItemTypes = setmetatable({}, { __index = table })

        -- fill up the table
        for itemType, moveMode in pairs(PAB.SavedVars.Crafting.ItemTypes) do
            if moveMode == PAC.MOVE.DEPOSIT then
                if _passesLazyWritCraftingCompatibilityCheck(itemType) then
                    depositItemTypes:insert(itemType)
                else
                    PAB.hasSomeItemskippedForLWC = true
                    PAB.debugln("skip [%s] because of LWC compatibility", GetString("SI_ITEMTYPE", itemType))
                end
            elseif moveMode == PAC.MOVE.WITHDRAW then
                withdrawItemTypes:insert(itemType)
            end
        end

        local excludeJunk = PAB.SavedVars.excludeJunk
        local _, _, lockedPreventsMoving = PA.Libs.FCOItemSaver.getCurrentFCOISFlags()
        local depositComparator = PAHF.getItemTypeComparator(depositItemTypes, excludeJunk, true, lockedPreventsMoving)
        local withdrawComparator = PAHF.getItemTypeComparator(withdrawItemTypes, excludeJunk, true, lockedPreventsMoving)

        local toDepositBagCache = SHARED_INVENTORY:GenerateFullSlotData(depositComparator, BAG_BACKPACK)
        local toFillUpDepositBagCache = SHARED_INVENTORY:GenerateFullSlotData(depositComparator, PAHF.getBankBags())

        local toWithdrawBagCache = SHARED_INVENTORY:GenerateFullSlotData(withdrawComparator, PAHF.getBankBags())
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
PA.Banking.depositOrWithdrawCraftingItems = depositOrWithdrawCraftingItems