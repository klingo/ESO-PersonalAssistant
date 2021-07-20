-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
local PAEM = PA.EventManager

-- ---------------------------------------------------------------------------------------------------------------------

local function _doItemTransactions(depositFromBagCache, depositToBagCache, withdrawalFromBagCache, withdrawalToBagCache)
    -- call the generic version
    PAB.doGenericItemTransactions(depositFromBagCache, depositToBagCache, withdrawalFromBagCache, withdrawalToBagCache)
end

-- ---------------------------------------------------------------------------------------------------------------------

local function depositOrWithdrawFCOISMarkedItems()

    PAB.debugln("==============================================================")
    PAB.debugln("PA.Banking.depositOrWithdrawFCOISMarkedItems (4)")

    if PA.Integration and PA.Libs.FCOItemSaver.isFCOISLoadedProperly() then
        local PAIFCOISSavedVars = PA.Integration.SavedVars.FCOItemSaver
        
        -- prepare the table with fcoisFlags to deposit and withdraw
        local depositFCOISFlags = setmetatable({}, { __index = table })
        local withdrawFCOISFlags = setmetatable({}, { __index = table })
        local _fcoisFlagStatus = {
            [FCOIS_CON_ICON_RESEARCH] = PAIFCOISSavedVars.Research.itemMoveMode,
            [FCOIS_CON_ICON_DECONSTRUCTION] = PAIFCOISSavedVars.Deconstruction.itemMoveMode,
            [FCOIS_CON_ICON_IMPROVEMENT] = PAIFCOISSavedVars.Improvement.itemMoveMode,
            [FCOIS_CON_ICON_SELL_AT_GUILDSTORE] = PAIFCOISSavedVars.SellGuildStore.itemMoveMode,
            [FCOIS_CON_ICON_INTRICATE] = PAIFCOISSavedVars.Intricate.itemMoveMode,
            [FCOIS_CON_ICON_GEAR_1] = PAIFCOISSavedVars.GearSets.itemMoveMode[1],
            [FCOIS_CON_ICON_GEAR_2] = PAIFCOISSavedVars.GearSets.itemMoveMode[2],
            [FCOIS_CON_ICON_GEAR_3] = PAIFCOISSavedVars.GearSets.itemMoveMode[3],
            [FCOIS_CON_ICON_GEAR_4] = PAIFCOISSavedVars.GearSets.itemMoveMode[4],
            [FCOIS_CON_ICON_GEAR_5] = PAIFCOISSavedVars.GearSets.itemMoveMode[5],
        }

        -- fill up the table
        for fcoisFlag, moveMode in pairs(_fcoisFlagStatus) do
            if moveMode == PAC.MOVE.DEPOSIT then
                depositFCOISFlags:insert(fcoisFlag)
            elseif moveMode == PAC.MOVE.WITHDRAW then
                withdrawFCOISFlags:insert(fcoisFlag)
            end
        end

        local depositComparator = PA.Libs.FCOItemSaver.getItemMoveFCOISComparator(depositFCOISFlags)
        local withdrawComparator = PA.Libs.FCOItemSaver.getItemMoveFCOISComparator(withdrawFCOISFlags)

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
PA.Banking.depositOrWithdrawFCOISMarkedItems = depositOrWithdrawFCOISMarkedItems