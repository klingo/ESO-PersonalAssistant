-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
local PAEM = PA.EventManager

-- ---------------------------------------------------------------------------------------------------------------------

local _writTable

local function _passesLazyWritCraftingCompatibilityCheck(itemType)
    if PAB.hasLazyWritCrafterAndShouldGrabEnabled() then
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

    PAB.debugln("==============================================================")
    PAB.debugln("PA.Banking.depositOrWithdrawAdvancedItems (2)")

    if PAB.SavedVars.Advanced.advancedItemsEnabled then
        -- get the writ quest table if LazyWritCrafter is enabled
        if WritCreater then
            _writTable = WritCreater.writSearch()
        end

        -- prepare the table with itemTypes to deposit and withdraw
        local combinedDepositLists = {
            learnableKnownItemTypes = setmetatable({}, { __index = table }),
            learnableUnknownItemTypes = setmetatable({}, { __index = table }),
            masterWritCraftingTypes = setmetatable({}, { __index = table }),
            holidayWrits  = setmetatable({}, { __index = table }),
            itemTypes = setmetatable({}, { __index = table }),
            specializedItemTypes = setmetatable({}, { __index = table }),
            surveyMaps = setmetatable({}, { __index = table }),
            itemTraitTypes = setmetatable({}, { __index = table }),
        }
        local combinedWithdrawLists = {
            learnableKnownItemTypes = setmetatable({}, { __index = table }),
            learnableUnknownItemTypes = setmetatable({}, { __index = table }),
            masterWritCraftingTypes = setmetatable({}, { __index = table }),
            holidayWrits  = setmetatable({}, { __index = table }),
            itemTypes = setmetatable({}, { __index = table }),
            specializedItemTypes = setmetatable({}, { __index = table }),
            surveyMaps = setmetatable({}, { __index = table }),
            itemTraitTypes = setmetatable({}, { __index = table }),
        }

        -- fill up the table(s)
        for itemType, moveModeTbl in pairs(PAB.SavedVars.Advanced.LearnableItemTypes) do
            for knownUnknown, moveMode in pairs(moveModeTbl) do
                if moveMode == PAC.MOVE.DEPOSIT then
                    if knownUnknown == "Known" then
                        combinedDepositLists.learnableKnownItemTypes:insert(itemType)
                    else
                        combinedDepositLists.learnableUnknownItemTypes:insert(itemType)
                    end
                elseif moveMode == PAC.MOVE.WITHDRAW then
                    if knownUnknown == "Known" then
                        combinedWithdrawLists.learnableKnownItemTypes:insert(itemType)
                    else
                        combinedWithdrawLists.learnableUnknownItemTypes:insert(itemType)
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
        for specializedItemType, moveMode in pairs(PAB.SavedVars.Advanced.HolidayWrits) do
            if moveMode == PAC.MOVE.DEPOSIT then
                combinedDepositLists.holidayWrits:insert(specializedItemType)
            elseif moveMode == PAC.MOVE.WITHDRAW then
                combinedWithdrawLists.holidayWrits:insert(specializedItemType)
            end
        end
        for itemType, moveMode in pairs(PAB.SavedVars.Advanced.ItemTypes) do
            if moveMode == PAC.MOVE.DEPOSIT then
                if _passesLazyWritCraftingCompatibilityCheck(itemType) then
                    combinedDepositLists.itemTypes:insert(itemType)
                else
                    PAB.hasSomeItemskippedForLWC = true
                    PAB.debugln("skip [%s] because of LWC compatibility", GetString("SI_ITEMTYPE", itemType))
                end
            elseif moveMode == PAC.MOVE.WITHDRAW then
                combinedWithdrawLists.itemTypes:insert(itemType)
            end
        end
        for specializedItemType, moveMode in pairs(PAB.SavedVars.Advanced.SpecializedItemTypes) do
            if moveMode == PAC.MOVE.DEPOSIT then
                combinedDepositLists.specializedItemTypes:insert(specializedItemType)
            elseif moveMode == PAC.MOVE.WITHDRAW then
                combinedWithdrawLists.specializedItemTypes:insert(specializedItemType)
            end
        end
        for itemFilterType, moveMode in pairs(PAB.SavedVars.Advanced.SpecializedItemTypes[SPECIALIZED_ITEMTYPE_TROPHY_SURVEY_REPORT]) do
            if moveMode == PAC.MOVE.DEPOSIT then
                combinedDepositLists.surveyMaps:insert(itemFilterType)
            elseif moveMode == PAC.MOVE.WITHDRAW then
                combinedWithdrawLists.surveyMaps:insert(itemFilterType)
            end
        end
        for itemTraitType, moveMode in pairs(PAB.SavedVars.Advanced.ItemTraitTypes) do
            if moveMode == PAC.MOVE.DEPOSIT then
                combinedDepositLists.itemTraitTypes:insert(itemTraitType)
            elseif moveMode == PAC.MOVE.WITHDRAW then
                combinedWithdrawLists.itemTraitTypes:insert(itemTraitType)
            end
        end

        local excludeJunk = PAB.SavedVars.excludeJunk
        local _, _, lockedPreventsMoving = PA.Libs.FCOItemSaver.getCurrentFCOISFlags()
        local depositComparator = PAHF.getCombinedItemTypeSpecializedComparator(combinedDepositLists, excludeJunk, true, lockedPreventsMoving)
        local withdrawComparator = PAHF.getCombinedItemTypeSpecializedComparator(combinedWithdrawLists, excludeJunk, true, lockedPreventsMoving)

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
PA.Banking.depositOrWithdrawAdvancedItems = depositOrWithdrawAdvancedItems