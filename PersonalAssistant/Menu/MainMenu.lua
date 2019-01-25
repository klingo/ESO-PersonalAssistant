-- Local instances of Global tables --
local PA = PersonalAssistant
local PAMenuHelper = PA.MenuHelper
local PAMenuFunctions = PA.MenuFunctions
local PAMenuDefaults = PA.MenuDefaults
local PAMenuChoices = PA.MenuChoices
local L = PA.Localization

local LAM2 = LibStub("LibAddonMenu-2.0")

local panelData = {
    type = "panel",
    name = "PersonalAssistant",
    displayName = L.MMenu_Title,
    author = "Klingo",
    version = PA.AddonVersion,
    website = "http://www.esoui.com/downloads/info381-PersonalAssistant",
    slashCommand = "/pa",
    registerForRefresh = true,
    registerForDefaults = true,
}

local optionsTable = setmetatable({}, { __index = table })
local PABItemTypeMaterialSubmenuTable = setmetatable({}, { __index = table })
local PABItemTypeSubmenuTable = setmetatable({}, { __index = table })
local PABItemTypeAdvancedSubmenuTable = setmetatable({}, { __index = table })
local PALHarvestableItemSubmenuTable = setmetatable({}, { __index = table })
local PALLootableItemSubmenuTable = setmetatable({}, { __index = table })

-- =================================================================================================================

local function createMainMenu()
    optionsTable:insert({
        type = "header",
        name = L.PAGMenu_Header
    })

    optionsTable:insert({
        type = "dropdown",
        name = L.PAGMenu_ActiveProfile,
        tooltip = L.PAGMenu_ActiveProfile_T,
        choices = PAMenuHelper.getProfileList(),
        choicesValues = PAMenuHelper.getProfileListValues(),
        getFunc = PAMenuFunctions.PAGeneral.getActiveProfile,
        setFunc = PAMenuFunctions.PAGeneral.setActiveProfile,
        width = "half",
        reference = "PERSONALASSISTANT_PROFILEDROPDOWN",
    })

    optionsTable:insert({
        type = "editbox",
        name = L.PAGMenu_ActiveProfileRename,
        tooltip = L.PAGMenu_ActiveProfileRename_T,
        getFunc = PAMenuFunctions.PAGeneral.getActiveProfileRename,
        setFunc = PAMenuFunctions.PAGeneral.setActiveProfileRename,
        width = "half",
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
    })

    optionsTable:insert({
        type = "checkbox",
        name = L.PAGMenu_Welcome,
        tooltip = L.PAGMenu_Welcome_T,
        getFunc = PAMenuFunctions.PAGeneral.getWelcomeMessageSetting,
        setFunc = PAMenuFunctions.PAGeneral.setWelcomeMessageSetting,
        disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
        default = PAMenuDefaults.PAGeneral.welcomeMessage,
    })

    -- =================================================================================================================

    -- Check if PA Repair module is loaded
    if (PA.Repair) then
        -- ------------------------ --
        -- PersonalAssistant Repair --
        -- ------------------------ --
        optionsTable:insert({
            type = "header",
            name = L.PARMenu_Header
        })

        optionsTable:insert({
            type = "checkbox",
            name = L.PARMenu_Enable,
            tooltip = L.PARMenu_Enable_T,
            getFunc = PAMenuFunctions.PARepair.isEnabled,
            setFunc = PAMenuFunctions.PARepair.setIsEnabled,
            disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
            default = PAMenuDefaults.PARepair.enabled,
        })

        optionsTable:insert({
            type = "checkbox",
            name = L.PARMenu_RepairWornGold,
            tooltip = L.PARMenu_RepairWornGold_T,
            getFunc = PAMenuFunctions.PARepair.getRepairEquippedSetting,
            setFunc = PAMenuFunctions.PARepair.setRepairEquippedSetting,
            width = "half",
            disabled = PAMenuFunctions.PARepair.isRepairEquippedDisabled,
            default = PAMenuDefaults.PARepair.repairEquipped,
        })

        optionsTable:insert({
            type = "slider",
            name = L.PARMenu_RepairWornGoldDura,
            tooltip = L.PARMenu_RepairWornGoldDura_T,
            min = 0,
            max = 99,
            step = 1,
            getFunc = PAMenuFunctions.PARepair.getRepairEquippedThresholdSetting,
            setFunc = PAMenuFunctions.PARepair.setRepairEquippedThresholdSetting,
            width = "half",
            disabled = PAMenuFunctions.PARepair.isRepairEquippedThresholdDisabled,
            default = PAMenuDefaults.PARepair.repairEquippedThreshold,
        })

        optionsTable:insert({
            type = "checkbox",
            name = L.PARMenu_RepairWornKit,
            tooltip = L.PARMenu_RepairWornKit_T,
            getFunc = PAMenuFunctions.PARepair.getRepairEquippedWithKitSetting,
            setFunc = PAMenuFunctions.PARepair.setRepairEquippedWithKitSetting,
            width = "half",
            disabled = PAMenuFunctions.PARepair.isRepairEquippedWithKitDisabled,
            default = PAMenuDefaults.PARepair.repairEquippedWithKit,
        })

        optionsTable:insert({
            type = "slider",
            name = L.PARMenu_RepairWornKitDura,
            tooltip = L.PARMenu_RepairWornKitDura_T,
            min = 0,
            max = 99,
            step = 1,
            getFunc = PAMenuFunctions.PARepair.getRepairEquippedWithKitThresholdSetting,
            setFunc = PAMenuFunctions.PARepair.setRepairEquippedWithKitThresholdSetting,
            width = "half",
            disabled = PAMenuFunctions.PARepair.isRepairEquippedWithKitThresholdDisabled,
            default = PAMenuDefaults.PARepair.repairEquippedWithKitThreshold,
        })

        optionsTable:insert({
            type = "dropdown",
            name = L.PARMenu_RepairFullChatMode,
            tooltip = L.PARMenu_RepairFullChatMode_T,
            choices = PAMenuChoices.choices.PARepair.repairFullChatMode,
            choicesValues = PAMenuChoices.choicesValues.PARepair.repairFullChatMode,
            getFunc = PAMenuFunctions.PARepair.getRepairFullChatModeSetting,
            setFunc = PAMenuFunctions.PARepair.setRepairFullChatModeSetting,
            width = "half",
            disabled = PAMenuFunctions.PARepair.isRepairFullChatModeDisabled,
            default = PAMenuDefaults.PARepair.repairFullChatMode,
        })

        optionsTable:insert({
            type = "dropdown",
            name = L.PARMenu_RepairPartialChatMode,
            tooltip = L.PARMenu_RepairPartialChatMode_T,
            choices = PAMenuChoices.choices.PARepair.repairPartialChatMode,
            choicesValues = PAMenuChoices.choicesValues.PARepair.repairPartialChatMode,
            getFunc = PAMenuFunctions.PARepair.getRepairPartialChatModeSetting,
            setFunc = PAMenuFunctions.PARepair.setRepairPartialChatModeSetting,
            width = "half",
            disabled = PAMenuFunctions.PARepair.isRepairPartialChatModeDisabled,
            default = PAMenuDefaults.PARepair.repairPartialChatMode,
        })

        optionsTable:insert({
            type = "divider",
            alpha = 0.5,
        })

        optionsTable:insert({
            type = "checkbox",
            name = L.PARMenu_ChargeWeapons,
            tooltip = L.PARMenu_ChargeWeapons_T,
            getFunc = PAMenuFunctions.PARepair.getChargeWeaponsSetting,
            setFunc = PAMenuFunctions.PARepair.setChargeWeaponsSetting,
            width = "half",
            disabled = PAMenuFunctions.PARepair.isChargeWeaponsDisabled,
            default = PAMenuDefaults.PARepair.chargeWeapons,
        })

        optionsTable:insert({
            type = "slider",
            name = L.PARMenu_ChargeWeaponsDura,
            tooltip = L.PARMenu_ChargeWeaponsDura_T,
            min = 0,
            max = 99,
            step = 1,
            getFunc = PAMenuFunctions.PARepair.getChargeWeaponsThresholdSetting,
            setFunc = PAMenuFunctions.PARepair.setChargeWeaponsThresholdSetting,
            width = "half",
            disabled = PAMenuFunctions.PARepair.isChargeWeaponsThresholdDisabled,
            default = PAMenuDefaults.PARepair.chargeWeaponsThreshold,
        })

        -- chargin output-mode
        optionsTable:insert({
            type = "dropdown",
            name = L.PARMenu_ChargeWeaponsChatMode,
            tooltip = L.PARMenu_ChargeWeaponsChatMode_T,
            choices = PAMenuChoices.choices.PARepair.chargeWeaponsChatMode,
            choicesValues = PAMenuChoices.choicesValues.PARepair.chargeWeaponsChatMode,
            getFunc = PAMenuFunctions.PARepair.getChargeWeaponsChatModeSetting,
            setFunc = PAMenuFunctions.PARepair.setChargeWeaponsChatModeSetting,
            width = "half",
            disabled = PAMenuFunctions.PARepair.getIsChargeWeaponsChatModeEnabled,
            default = PAMenuDefaults.PARepair.chargeWeaponsChatMode,
        })

        -- soul gem alert

        -- soul gem amount for alert
    end

    -- =================================================================================================================

    -- Check if PA Banking module is loaded
    if (PA.Banking) then
        -- ------------------------- --
        -- PersonalAssistant Banking --
        -- ------------------------- --
        optionsTable:insert({
            type = "header",
            name = L.PABMenu_Header
        })

        optionsTable:insert({
            type = "checkbox",
            name = L.PABMenu_Enable,
            tooltip = L.PABMenu_Enable_T,
            getFunc = PAMenuFunctions.PABanking.enabled,
            setFunc = PAMenuFunctions.PABanking.enabled,
            disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
            default = PAMenuDefaults.PABanking.enabled,
        })

        optionsTable:insert({
            type = "checkbox",
            name = L.PABMenu_EnabledGold,
            tooltip = L.PABMenu_EnabledGold_T,
            getFunc = PAMenuFunctions.PABanking.enabledGold,
            setFunc = PAMenuFunctions.PABanking.enabledGold,
            disabled = PAMenuFunctions.disabled.PABanking.enabledGold,
            default = PAMenuDefaults.PABanking.enabledGold,
        })

        -- enabledGoldChatMode

        optionsTable:insert({
            type = "dropdown",
            name = L.PABMenu_GoldTransactionStep,
            tooltip = L.PABMenu_GoldTransactionStep_T,
            choices = PAMenuChoices.choices.PABanking.goldTransactionStep,
            choicesValues = PAMenuChoices.choicesValues.PABanking.goldTransactionStep,
            getFunc = PAMenuFunctions.PABanking.goldTransactionStep,
            setFunc = PAMenuFunctions.PABanking.goldTransactionStep,
            disabled = PAMenuFunctions.disabled.PABanking.goldTransactionStep,
            default = PAMenuDefaults.PABanking.goldTransactionStep,
        })

        optionsTable:insert({
            type = "editbox",
            name = L.PABMenu_GoldMinToKeep,
            tooltip = L.PABMenu_GoldMinToKeep_T,
            getFunc = PAMenuFunctions.PABanking.goldMinToKeep,
            setFunc = PAMenuFunctions.PABanking.goldMinToKeep,
            disabled = PAMenuFunctions.disabled.PABanking.goldMinToKeep,
            warning = L.PABMenu_GoldMinToKeep_W,
            default = PAMenuDefaults.PABanking.goldMinToKeep,
        })

        optionsTable:insert({
            type = "checkbox",
            name = L.PABMenu_WithdrawToMinGold,
            tooltip = L.PABMenu_WithdrawToMinGold_T,
            getFunc = PAMenuFunctions.PABanking.withdrawToMinGold,
            setFunc = PAMenuFunctions.PABanking.withdrawToMinGold,
            disabled = PAMenuFunctions.disabled.PABanking.withdrawToMinGold,
            default = PAMenuDefaults.PABanking.withdrawToMinGold,
        })

        optionsTable:insert({
            type = "divider",
            alpha = 0.5,
        })

        optionsTable:insert({
            type = "checkbox",
            name = L.PABMenu_EnabledItems,
            tooltip = L.PABMenu_EnabledItems_T,
            getFunc = PAMenuFunctions.PABanking.enabledItems,
            setFunc = PAMenuFunctions.PABanking.enabledItems,
            disabled = PAMenuFunctions.disabled.PABanking.enabledItems,
            default = PAMenuDefaults.PABanking.enabledItems,
        })

        -- enabledItemsChatMode

        optionsTable:insert({
            type = "description",
            text = L.PABMenu_DepItemTypeDesc
        })

        optionsTable:insert({
            type = "submenu",
            name = L.PABMenu_ItemTypeMaterialSubmenu,
            -- tooltip = L.PABMenu_ItemTypeMaterialSubmenu_T,
            controls = PABItemTypeMaterialSubmenuTable,
        })

        optionsTable:insert({
            type = "submenu",
            name = L.PABMenu_DepItemType,
            tooltip = L.PABMenu_DepItemType_T,
            controls = PABItemTypeSubmenuTable,
        })

        optionsTable:insert({
            type = "submenu",
            name = L.PABMenu_Advanced_DepItemType,
            tooltip = L.PABMenu_Advanced_DepItemType_T,
            controls = PABItemTypeAdvancedSubmenuTable,
        })

        optionsTable:insert({
            type = "slider",
            name = L.PABMenu_DepItemTimerInterval,
            tooltip = L.PABMenu_DepItemTimerInterval_T,
            min = 200,
            max = 1000,
            step = 50,
            getFunc = PAMenuFunctions.PABanking.depositTimerInterval,
            setFunc = PAMenuFunctions.PABanking.depositTimerInterval,
            disabled = PAMenuFunctions.disabled.PABanking.depositTimerInterval,
            default = PAMenuDefaults.PABanking.depositTimerInterval,
        })
    end

    -- =================================================================================================================

    -- Check if PA Loot module is loaded
    if (PA.Loot) then
        -- ---------------------- --
        -- PersonalAssistant Loot --
        -- ---------------------- --
        optionsTable:insert({
            type = "header",
            name = L.PALMenu_Header
        })

        optionsTable:insert({
            type = "checkbox",
            name = L.PALMenu_Enable,
            tooltip = L.PALMenu_Enable_T,
            getFunc = PAMenuFunctions.PALoot.isEnabled,
            setFunc = PAMenuFunctions.PALoot.setIsEnabled,
            disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
            default = PAMenuDefaults.PALoot.enabled,
        })

        optionsTable:insert({
            type = "checkbox",
            name = L.PALMenu_LootGold,
            tooltip = L.PALMenu_LootGold_T,
            getFunc = PAMenuFunctions.PALoot.isLootGoldEnabled,
            setFunc = PAMenuFunctions.PALoot.setIsLootGoldEnabled,
            width = "half",
            disabled = PAMenuFunctions.PALoot.isLootGoldDisabled,
            default = PAMenuDefaults.PALoot.lootGoldEnabled,
        })

        optionsTable:insert({
            type = "dropdown",
            name = L.PALMenu_LootGoldChatMode,
            tooltip = L.PALMenu_LootGoldChatMode_T,
            choices = PAMenuChoices.choices.PALoot.lootGoldChatMode,
            choicesValues = PAMenuChoices.choicesValues.PALoot.lootGoldChatMode,
            getFunc = PAMenuFunctions.PALoot.getLootGoldChatModeSetting,
            setFunc = PAMenuFunctions.PALoot.setLootGoldChatModeSetting,
            width = "half",
            disabled = PAMenuFunctions.PALoot.isLootGoldChatModeDisabled,
            default = PAMenuDefaults.PALoot.lootGoldChatMode,
        })

        optionsTable:insert({
            type = "checkbox",
            name = L.PALMenu_LootItems,
            tooltip = L.PALMenu_LootItems_T,
            getFunc = PAMenuFunctions.PALoot.getLootItemsSetting,
            setFunc = PAMenuFunctions.PALoot.setLootItemsSetting,
            width = "half",
            disabled = PAMenuFunctions.PALoot.isLootItemsDisabled,
            default = PAMenuDefaults.PALoot.lootItemsEnabled,
        })

        optionsTable:insert({
            type = "dropdown",
            name = L.PALMenu_LootItemsChatMode,
            tooltip = L.PALMenu_LootItemsChatMode_T,
            choices = PAMenuChoices.choices.PALoot.lootItemsChatMode,
            choicesValues = PAMenuChoices.choicesValues.PALoot.lootItemsChatMode,
            getFunc = PAMenuFunctions.PALoot.getLootItemsChatModeSetting,
            setFunc = PAMenuFunctions.PALoot.setLootItemsChatModeSetting,
            width = "half",
            disabled = PAMenuFunctions.PALoot.isLootItemsChatModeDisabled,
            default = PAMenuDefaults.PALoot.lootItemsChatMode,
        })

        optionsTable:insert({
            type = "checkbox",
            name = L.PALMenu_LootStolenItems,
            tooltip = L.PALMenu_LootStolenItems_T,
            getFunc = PAMenuFunctions.PALoot.getLootStolenItemsSetting,
            setFunc = PAMenuFunctions.PALoot.setLootStolenItemsSetting,
            width = "half",
            disabled = PAMenuFunctions.PALoot.isLootStolenItemsSettingDisabled,
            default = PAMenuDefaults.PALoot.lootStolenItemsEnabled,
        })

        optionsTable:insert({
            type = "submenu",
            name = L.PALMenu_HarvestableItems,
            tooltip = L.PALMenu_HarvestableItems_T,
            controls = PALHarvestableItemSubmenuTable,
        })

        optionsTable:insert({
            type = "submenu",
            name = L.PALMenu_LootableItems,
            tooltip = L.PALMenu_LootableItems_T,
            controls = PALLootableItemSubmenuTable,
        })
    end

    -- =================================================================================================================

    -- Check if PA Junk module is loaded
    if (PA.Junk) then
        -- ------------------------- --
        -- PersonalAssistant Junk --
        -- ------------------------- --
        optionsTable:insert({
            type = "header",
            name = L.PAJMenu_Header
        })

        optionsTable:insert({
            type = "checkbox",
            name = L.PAJMenu_Enable,
            tooltip = L.PAJMenu_Enable_T,
            getFunc = PAMenuFunctions.PAJunk.enabled,
            setFunc = PAMenuFunctions.PAJunk.enabled,
            disabled = PAMenuFunctions.PAGeneral.isNoProfileSelected,
            default = PAMenuDefaults.PAJunk.enabled,
        })

        optionsTable:insert({
            type = "checkbox",
            name = L.PAJMenu_AutoSellJunk,
            tooltip = L.PAJMenu_AutoSellJunk_T,
            getFunc = PAMenuFunctions.PAJunk.autoSellJunk,
            setFunc = PAMenuFunctions.PAJunk.autoSellJunk,
            disabled = PAMenuFunctions.disabled.PAJunk.autoSellJunk,
            default = PAMenuDefaults.PAJunk.autoSellJunk,
        })

        optionsTable:insert({
            type = "description",
            text = L.PAJMenu_ItemTypeDesc,
        })

        optionsTable:insert({
            type = "checkbox",
            name = L.PAJMenu_AutoMarkTrash,
            tooltip = L.PAJMenu_AutoMarkTrash_T,
            getFunc = PAMenuFunctions.PAJunk.autoMarkTrash,
            setFunc = PAMenuFunctions.PAJunk.autoMarkTrash,
            disabled = PAMenuFunctions.disabled.PAJunk.autoMarkTrash,
            default = PAMenuDefaults.PAJunk.autoMarkTrash,
        })

        optionsTable:insert({
            type = "checkbox",
            name = L.PAJMenu_AutoMarkOrnate,
            tooltip = L.PAJMenu_AutoMarkOrnate_T,
            getFunc = PAMenuFunctions.PAJunk.autoMarkOrnate,
            setFunc = PAMenuFunctions.PAJunk.autoMarkOrnate,
            disabled = PAMenuFunctions.disabled.PAJunk.autoMarkOrnate,
            default = PAMenuDefaults.PAJunk.autoMarkOrnate,
        })
    end
end

-- =================================================================================================================

local function createPABItemTypeMaterialSubmenuTable()
    -- Check if PA Banking module is loaded
    if (PA.Banking) then
        -- ------------------------- --
        -- PersonalAssistant Banking --
        -- ------------------------- --
        if (IsESOPlusSubscriber()) then
            -- In case of ESO Plus Subscription, only show a remark that Crafting Material Banking
            -- options are not available (--> Virtual Bag)

            PABItemTypeMaterialSubmenuTable:insert({
                type = "description",
                text = L.PABMenu_ItemTypeMaterialESOPlusDesc
            })

        else
            -- Regular player without ESO Plus Subscription
            for _, itemType in pairs(PABItemTypesMaterial) do
                PABItemTypeMaterialSubmenuTable:insert({
                    type = "dropdown",
                    name = PALocale.getResourceMessage(itemType),
                    choices = PAMenuChoices.choices.PABanking.itemMoveMode,
                    choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
                    -- TODO: choicesTooltips
                    getFunc = function() return PAMenuFunctions.PABanking.itemTypesMaterialMoveMode(itemType) end,
                    setFunc = function(value) PAMenuFunctions.PABanking.itemTypesMaterialMoveMode(itemType, value) end,
                    width = "half",
                    disabled = PAMenuFunctions.disabled.PABanking.itemTypesMaterialMoveMode,
                    -- default = PAC_ITEMTYPE_IGNORE,  -- TODO: extract?
                })
            end
        end
    end
end

-- =================================================================================================================

local function createPABItemSubMenu()
    -- Check if PA Banking module is loaded
    if (PA.Banking) then
        -- ------------------------- --
        -- PersonalAssistant Banking --
        -- ------------------------- --
        PABItemTypeSubmenuTable:insert({
            type = "dropdown",
            name = L.PABMenu_DepStackOnly,
            tooltip = L.PABMenu_DepStackOnly_T,
            choices = PAMenuChoices.choices.PABanking.stackingType,
            choicesValues = PAMenuChoices.choicesValues.PABanking.stackingType,
            -- TODO: choicesTooltips
            getFunc = PAMenuFunctions.PABanking.itemsDepStackType,
            setFunc = PAMenuFunctions.PABanking.itemsDepStackType,
            width = "half",
            disabled = PAMenuFunctions.disabled.PABanking.itemsDepStackType,
            default = PAMenuDefaults.PABanking.itemsDepStackType,
        })

        PABItemTypeSubmenuTable:insert({
            type = "dropdown",
            name = L.PABMenu_WitStackOnly,
            tooltip = L.PABMenu_WitStackOnly_T,
            choices = PAMenuChoices.choices.PABanking.stackingType,
            choicesValues = PAMenuChoices.choicesValues.PABanking.stackingType,
            getFunc = PAMenuFunctions.PABanking.itemsWitStackType,
            setFunc = PAMenuFunctions.PABanking.itemsWitStackType,
            width = "half",
            disabled = PAMenuFunctions.disabled.PABanking.itemsWitStackType,
            default = PAMenuDefaults.PABanking.itemsWitStackType,
        })

        PABItemTypeSubmenuTable:insert({
            type = "header",
            name = L.PABMenu_ItemType_Header
        })

        for _, itemType in pairs(PABItemTypes) do
            PABItemTypeSubmenuTable:insert({
                type = "dropdown",
                name = PALocale.getResourceMessage(itemType),
                choices = PAMenuChoices.choices.PABanking.itemMoveMode,
                choicesValues = PAMenuChoices.choicesValues.PABanking.itemMoveMode,
                -- TODO: choicesTooltips
                getFunc = function() return PAMenuFunctions.PABanking.itemTypesMoveMode(itemType) end,
                setFunc = function(value) PAMenuFunctions.PABanking.itemTypesMoveMode(itemType, value) end,
                width = "half",
                disabled = PAMenuFunctions.disabled.PABanking.itemTypesMoveMode,
                -- default = PAC_ITEMTYPE_IGNORE,  -- TODO: extract?
            })
        end

        PABItemTypeSubmenuTable:insert({
            type = "button",
            name = L.PABMenu_DepButton,
            tooltip = L.PABMenu_DepButton_T,
            func = PAMenuFunctions.func.PABanking.depositAllItemTypesButton,
            disabled = PAMenuFunctions.disabled.PABanking.depositAllItemTypesButton,
        })

        PABItemTypeSubmenuTable:insert({
            type = "button",
            name = L.PABMenu_WitButton,
            tooltip = L.PABMenu_WitButton_T,
            func = PAMenuFunctions.func.PABanking.withdrawAllItemTypesButton,
            disabled = PAMenuFunctions.disabled.PABanking.withdrawAllItemTypesButton,
        })

        PABItemTypeSubmenuTable:insert({
            type = "button",
            name = L.PABMenu_IgnButton,
            tooltip = L.PABMenu_IgnButton_T,
            func = PAMenuFunctions.func.PABanking.ignoreAllItemTypesButton,
            disabled = PAMenuFunctions.disabled.PABanking.ignoreAllItemTypesButton,
        })
    end
end

-- =================================================================================================================

local function createPABItemAdvancedSubMenu()
    -- Check if PA Banking module is loaded
    if (PA.Banking) then
        -- ------------------------- --
        -- PersonalAssistant Banking --
        -- ------------------------- --
        PABItemTypeAdvancedSubmenuTable:insert({
            type = "header",
            name = L.PABMenu_Lockipck_Header
        })

        for _, advancedItemType in pairs(PABItemTypesAdvanced) do
            PABItemTypeAdvancedSubmenuTable:insert({
                type = "dropdown",
                name = L.REL_Operator,
                choices = PAMenuChoices.choices.PABanking.mathOperator,
                choicesValues = PAMenuChoices.choicesValues.PABanking.mathOperator,
                -- TODO: choicesTooltips
                getFunc = function() return PAMenuFunctions.PABanking.advItemTypesOperator(advancedItemType) end,
                setFunc = function(value) PAMenuFunctions.PABanking.advItemTypesOperator(advancedItemType, value) end,
                width = "half",
                disabled = PAMenuFunctions.disabled.PABanking.advItemTypesOperator,
                default = L.REL_None, -- TODO: extract?
            })

            PABItemTypeAdvancedSubmenuTable:insert({
                type = "editbox",
                name = L.PABMenu_Keep_in_Backpack,
                tooltip = L.PABMenu_Keep_in_Backpack_T,
                getFunc = function() return PAMenuFunctions.PABanking.advItemTypesValue(advancedItemType) end,
                setFunc = function(value) PAMenuFunctions.PABanking.advItemTypesValue(advancedItemType, value) end,
                width = "half",
                disabled = PAMenuFunctions.disabled.PABanking.advItemTypesValue,
                default = 100, -- TODO: extract?
            })
        end
    end
end

-- =================================================================================================================

local function createPALHarvestableItemSubMenu()
    -- Check if PA Loot module is loaded
    if (PA.Loot) then
        -- ---------------------- --
        -- PersonalAssistant Loot --
        -- ---------------------- --
        PALHarvestableItemSubmenuTable:insert({
            type = "description",
            text = L.PALMenu_HarvestableItemsDesc
        })

        PALHarvestableItemSubmenuTable:insert({
            type = "header",
            name = L.PALMenu_HarvestableItems_Bait_Header
        })

        local baitChoices = PAMenuChoices.choices.PALoot.harvestableBaitLootMode
        local baitChoicesValues = PAMenuChoices.choicesValues.PALoot.harvestableBaitLootMode
        local baitChoicesTooltips = PAMenuChoices.choicesTooltips.PALoot.harvestableBaitLootMode
        if (IsESOPlusSubscriber()) then
            -- Override the values in case of ESO Plus (no option to "destroy" bait, as it directly goes to virtual bag)
            -- Removes the last entry from the dropdowns (option: loot & destroy)
            table.remove(baitChoices)
            table.remove(baitChoicesValues)
            table.remove(baitChoicesTooltips)
        end

        PALHarvestableItemSubmenuTable:insert({
            type = "dropdown",
            name = L.PALMenu_HarvestableItems_Bait,
            tooltip = L.PALMenu_HarvestableItems_Bait_T,
            choices = baitChoices,
            choicesValues = baitChoicesValues,
            choicesTooltips = baitChoicesTooltips,
            getFunc = PAMenuFunctions.PALoot.getHarvestableBaitLootModeSetting,
            setFunc = PAMenuFunctions.PALoot.setHarvestableBaitLootModeSetting,
            disabled = PAMenuFunctions.PALootgetIsHarvestableBaitLootModeEnabled,
            default = PAMenuDefaults.PALoot.harvestableBaitLootMode,
        })

        PALHarvestableItemSubmenuTable:insert({
            type = "header",
            name = L.PALMenu_HarvestableItems_Header
        })

        for index, itemType in pairs(PALHarvestableItemTypes) do
            PALHarvestableItemSubmenuTable:insert({
                type = "dropdown",
                name = L[itemType],
                choices = PAMenuChoices.choices.PALoot.itemTypesLootMode,
                choicesValues = PAMenuChoices.choicesValues.PALoot.itemTypesLootMode,
                choicesTooltips = PAMenuChoices.choicesTooltips.PALoot.itemTypesLootMode,
                getFunc = function() return PAMenuFunctions.PALoot.getHarvestableItemTypesLootModeSetting(itemType) end,
                setFunc = function(value) PAMenuFunctions.PALoot.setHarvestableItemTypesLootModeSetting(itemType, value) end,
                width = "half",
                disabled = PAMenuFunctions.PALoot.getIsHarvestableItemTypesLootModeEnabled,
                default = PAMenuDefaults.PALoot.harvestableItemTypesLootMode,
            })
        end

        PALHarvestableItemSubmenuTable:insert({
            type = "button",
            name = L.PALMenu_AutoLootAllButton,
            tooltip = L.PALMenu_AutoLootAllButton_T,
            func = PAMenuFunctions.PALoot.clickAutoLootAllHarvestableButton,
            disabled = PAMenuFunctions.PALoot.getIsAutoLootAllHarvestableButtonEnabled,
        })

        PALHarvestableItemSubmenuTable:insert({
            type = "button",
            name = L.PALMenu_IgnButton,
            tooltip = L.PALMenu_IgnButton_T,
            func = PAMenuFunctions.PALoot.getIsIgnoreAllHarvestableButtonEnabled,
            disabled = PAMenuFunctions.PALoot.clickIgnoreAllHarvestableButton,
        })
    end
end

-- =================================================================================================================

local function createPALLootableItemSubMenu()
    -- Check if PA Loot module is loaded
    if (PA.Loot) then
        -- ---------------------- --
        -- PersonalAssistant Loot --
        -- ---------------------- --
        PALLootableItemSubmenuTable:insert({
            type = "description",
            text = L.PALMenu_LootableItemsDesc
        })

        PALLootableItemSubmenuTable:insert({
            type = "header",
            name = L.PALMenu_LootableItems_Header
        })

        for index, itemType in pairs(PALLootableItemTypes) do
            PALLootableItemSubmenuTable:insert({
                type = "dropdown",
                name = L[itemType],
                choices = PAMenuChoices.choices.PALoot.itemTypesLootMode,
                choicesValues = PAMenuChoices.choicesValues.PALoot.itemTypesLootMode,
                choicesTooltips = PAMenuChoices.choicesTooltips.PALoot.itemTypesLootMode,
                getFunc = function() return PAMenuFunctions.PALoot.getLootableItemTypesLootModeSetting(itemType) end,
                setFunc = function(value) PAMenuFunctions.PALoot.setLootableItemTypesLootModeSetting(itemType, value) end,
                width = "half",
                disabled = PAMenuFunctions.PALoot.getIsLootableItemTypesLootModeEnabled,
                default = PAMenuDefaults.PALoot.lootableItemTypesLootMode,
            })
        end

        PALLootableItemSubmenuTable:insert({
            type = "divider",
            alpha = 0.5,
        })

        PALLootableItemSubmenuTable:insert({
            type = "dropdown",
            name = L.PALMenu_AutoLootLockpicks,
            choices = PAMenuChoices.choices.PALoot.itemTypesLootMode,
            choicesValues = PAMenuChoices.choicesValues.PALoot.itemTypesLootMode,
            choicesTooltips = PAMenuChoices.choicesTooltips.PALoot.itemTypesLootMode,
            getFunc = PAMenuFunctions.PALoot.getLockpickLootModeSetting,
            setFunc = PAMenuFunctions.PALoot.setLockpickLootModeSetting,
            width = "half",
            disabled = PAMenuFunctions.PALoot.getIsLockpickLootModeEnabled,
            default = PAMenuDefaults.PALoot.lockpickLootMode,
        })

        PALLootableItemSubmenuTable:insert({
            type = "dropdown",
            name = L.PALMenu_AutoLootQuestItems,
            choices = PAMenuChoices.choices.PALoot.itemTypesLootMode,
            choicesValues = PAMenuChoices.choicesValues.PALoot.itemTypesLootMode,
            choicesTooltips = PAMenuChoices.choicesTooltips.PALoot.itemTypesLootMode,
            getFunc = PAMenuFunctions.PALoot.getQuestItemsLootModeSetting,
            setFunc = PAMenuFunctions.PALoot.setQuestItemsLootModeSetting,
            width = "half",
            disabled = PAMenuFunctions.PALoot.getIsQuestItemsLootModeEnabled,
            default = PAMenuDefaults.PALoot.questItemsLootMode,
        })

        PALLootableItemSubmenuTable:insert({
            type = "button",
            name = L.PALMenu_AutoLootAllButton,
            tooltip = L.PALMenu_AutoLootAllButton_T,
            func = PAMenuFunctions.PALoot.clickAutoLootAllLootableButton,
            disabled = PAMenuFunctions.PALoot.getIsAutoLootAllLootableButtonEnabled,
        })

        PALLootableItemSubmenuTable:insert({
            type = "button",
            name = L.PALMenu_IgnButton,
            tooltip = L.PALMenu_IgnButton_T,
            func = PAMenuFunctions.PALoot.clickIgnoreAllLootableButton,
            disabled = PAMenuFunctions.PALoot.getIsIgnoreAllLootableButtonEnabled,
        })
    end
end

-- =================================================================================================================

local function createOptions()
    -- create main- and submenus with LAM-2
    createPABItemTypeMaterialSubmenuTable()
    createPABItemSubMenu()
    createPABItemAdvancedSubMenu()
    createPALHarvestableItemSubMenu()
    createPALLootableItemSubMenu()
    createMainMenu()

    -- and register it
    LAM2:RegisterAddonPanel("PersonalAssistantAddonOptions", panelData)
    LAM2:RegisterOptionControls("PersonalAssistantAddonOptions", optionsTable)
end


-- Export
PA.MainMenu = {
    createMainMenu = createMainMenu,
    createPABItemTypeMaterialSubmenuTable = createPABItemTypeMaterialSubmenuTable,
    createPABItemSubMenu = createPABItemSubMenu,
    createPABItemAdvancedSubMenu = createPABItemAdvancedSubMenu,
    createPALHarvestableItemSubMenu = createPALHarvestableItemSubMenu,
    createPALLootableItemSubMenu = createPALLootableItemSubMenu,
    createOptions = createOptions
}
