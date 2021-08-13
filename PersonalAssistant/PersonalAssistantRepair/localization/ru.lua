local PAC = PersonalAssistant.Constants
local PARStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair Menu --
    SI_PA_MENU_REPAIR_DESCRIPTION = "PARepair ремонтирует ваши доспехи и перезаряжает оружие за вас, будь то у торговца или в полевых условиях",

    -- Equipped Items --
    SI_PA_MENU_REPAIR_EQUIPPED_HEADER = "Экипированные предметы",
    SI_PA_MENU_REPAIR_ENABLE = "Включить восстановление экипировки",

    SI_PA_MENU_REPAIR_GOLD_HEADER = table.concat({"Ремонт за ", GetCurrencyName(CURT_MONEY)}),
    SI_PA_MENU_REPAIR_GOLD_ENABLE = table.concat({"Ремонтировать за ", GetCurrencyName(CURT_MONEY)}),
    SI_PA_MENU_REPAIR_GOLD_ENABLE_T = "Все экипированные предметы с прочностью ниже или равной указанной будут автоматически отремонтированы при посещении торговца",
    SI_PA_MENU_REPAIR_GOLD_DURABILITY = "Порог прочности %",
    SI_PA_MENU_REPAIR_GOLD_DURABILITY_T = "Экипированные предметы ремонтируются только если их прочность ниже или равна указанной",

    SI_PA_MENU_REPAIR_REPAIRKIT_HEADER = table.concat({"Ремонт за ", GetString(SI_PA_MENU_BANKING_REPAIRKIT)}),
    SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE = table.concat({"Использовать ", GetString(SI_PA_MENU_BANKING_REPAIRKIT)}),
    SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE_T = "Все предметы с прочностью ниже или равной указанной будут автоматически отремонтированы в полевых условиях",
    --SI_PA_MENU_REPAIR_REPAIRKIT_DEFAULT_KIT = "",
    --SI_PA_MENU_REPAIR_REPAIRKIT_DEFAULT_KIT_T = "",
    SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY = "Порог прочности %",
    SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY_T = "Предметы ремонтируются только если их прочность ниже или равна указанной",
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING = table.concat({"Сообщать что заканчиваются ", GetString(SI_PA_MENU_BANKING_REPAIRKIT)}),
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING_T = table.concat({"Сообщать в чат что заканчиваются ", GetString(SI_PA_MENU_BANKING_REPAIRKIT), ". Если количество упало до нуля, предупреждать раз в 10 минут."}),
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD = "Порог количества",
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD_T = table.concat({"Если ", GetString(SI_PA_MENU_BANKING_REPAIRKIT), " упали менее данного порога, сообщение об этом будет показано в окне чата"}),

    SI_PA_MENU_REPAIR_RECHARGE_HEADER = table.concat({"Заряжать оружие за ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2)}),
    SI_PA_MENU_REPAIR_RECHARGE_ENABLE = table.concat({"Использовать ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2)}),
    SI_PA_MENU_REPAIR_RECHARGE_ENABLE_T = "Заряжать экипированное оружие, когда уровень его зарядки достигает нуля.",
    SI_PA_MENU_REPAIR_RECHARGE_DEFAULT_GEM = "Камни душ по умолчанию",
    SI_PA_MENU_REPAIR_RECHARGE_DEFAULT_GEM_T = "Камни душ которые будут использованы первыми для зарядки оружия.",
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING = table.concat({"Сообщать что заканчиваются ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2)}),
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING_T = table.concat({"Сообщать в чат, что заканчиваются ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), ". Если количество упало до нуля, предупреждать раз в 10 минут."}),
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD = "Порог количества",
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD_T = table.concat({"Если ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), " упали менее данного порога, сообщение об этом будет показано в окне чата"}),

    -- Inventory Items --
    SI_PA_MENU_REPAIR_INVENTORY_HEADER = "Предметы в инвентаре",
    SI_PA_MENU_REPAIR_INVENTORY_ENABLE = "Ремонтировать предметы в инвентаре",

    SI_PA_MENU_REPAIR_GOLD_INVENTORY_ENABLE = table.concat({"Ремонтировать за ", GetCurrencyName(CURT_MONEY)}),
    SI_PA_MENU_REPAIR_GOLD_INVENTORY_ENABLE_T = "Все предметы в инвентаре с прочностью ниже или равной указанной будут автоматически отремонтированы при посещении торговца",
    SI_PA_MENU_REPAIR_GOLD_INVENTORY_DURABILITY = "Порог прочности %",
    SI_PA_MENU_REPAIR_GOLD_INVENTORY_DURABILITY_T = "Предметы в инвентаре ремонтируются только если их прочность ниже или равна указанной",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair --
    SI_PA_CHAT_REPAIR_SUMMARY_FULL = "Восстановлено экипированное за %s",
    SI_PA_CHAT_REPAIR_SUMMARY_PARTIAL = "Восстановлено экипированное за %s (%s не хватило)",

    SI_PA_CHAT_REPAIR_SUMMARY_INVENTORY_FULL = "Восстановлено в инвентаре за %s",
    SI_PA_CHAT_REPAIR_SUMMARY_INVENTORY_PARTIAL = "Восстановлено в инвентаре за %s (%s не хватило)",

    SI_PA_CHAT_REPAIR_REPAIRKIT_REPAIRED = table.concat({"Восстановлено %s ", PAC.COLORS.WHITE, "(%d%%)", PAC.COLORS.DEFAULT, " за %s"}),
    --SI_PA_CHAT_REPAIR_REPAIRKIT_REPAIRED_ALL = table.concat({""}),
}

for key, value in pairs(PARStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end
