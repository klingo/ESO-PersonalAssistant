local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- Language specific texts that need to be translated --

-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PARepair Menu --
SafeAddString(SI_PA_MENU_REPAIR_DESCRIPTION, "PARepair ремонтирует ваши доспехи и перезаряжает оружие за вас, будь то у торговца или в полевых условиях", 1)

-- Equipped Items --
SafeAddString(SI_PA_MENU_REPAIR_EQUIPPED_HEADER, "Экипированные предметы", 1)
SafeAddString(SI_PA_MENU_REPAIR_ENABLE, "Включить восстановление экипировки", 1)

SafeAddString(SI_PA_MENU_REPAIR_GOLD_HEADER, table.concat({"Ремонт за ", GetCurrencyName(CURT_MONEY)}), 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_ENABLE, table.concat({"Ремонтировать за ", GetCurrencyName(CURT_MONEY)}), 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_ENABLE_T, "Все экипированные предметы с прочностью ниже или равной указанной будут автоматически отремонтированы при посещении торговца", 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_DURABILITY, "Порог прочности %", 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_DURABILITY_T, "Экипированные предметы ремонтируются только если их прочность ниже или равна указанной", 1)

SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_HEADER, table.concat({"Ремонт за ", GetString(SI_PA_MENU_BANKING_REPAIRKIT)}), 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE, table.concat({"Использовать ", GetString(SI_PA_MENU_BANKING_REPAIRKIT)}), 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE_T, "Все предметы с прочностью ниже или равной указанной будут автоматически отремонтированы в полевых условиях", 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY, "Порог прочности %", 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY_T, "Предметы ремонтируются только если их прочность ниже или равна указанной", 1)
--    SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_ENABLE, table.concat({"Использовать кронные наборы ", GetString(SI_PA_MENU_BANKING_REPAIRKIT)}), 1)
--    SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_ENABLE_T, "???", 1)
--    SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_DURABILITY, "Средняя прочность %", 1)
--    SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_DURABILITY_T, "Вся экипировка ремонтируются только если её средняя прочность ниже или равна указанной", 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING, table.concat({"Сообщать что заканчиваются ", GetString(SI_PA_MENU_BANKING_REPAIRKIT)}), 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING_T, table.concat({"Сообщать в чат что заканчиваются ", GetString(SI_PA_MENU_BANKING_REPAIRKIT), ". Если количество упало до нуля, предупреждать раз в 10 минут."}), 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD, "Порог количества", 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD_T, table.concat({"Если ", GetString(SI_PA_MENU_BANKING_REPAIRKIT), " упали менее данного порога, сообщение об этом будет показано в окне чата"}), 1)

SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_HEADER, table.concat({"Заряжать оружие за ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2)}), 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_ENABLE, table.concat({"Использовать ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2)}), 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_ENABLE_T, "Заряжать экипированное оружие, когда уровень его зарядки достигает нуля. Сначала будут использоваться кронные камни душ и только потом обычные.", 1)
--    SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_CHATMODE, "Сообщение чата после зарядки", 1)
--    SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_CHATMODE_T, "Что показывать после зарядки экипированного оружия в окне чата", 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING, table.concat({"Сообщать что заканчиваются ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2)}), 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING_T, table.concat({"Сообщать в чат, что заканчиваются ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), ". Если количество упало до нуля, предупреждать раз в 10 минут."}), 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD, "Порог количества", 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD_T, table.concat({"Если ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), " упали менее данного порога, сообщение об этом будет показано в окне чата"}), 1)

-- Inventory Items --
SafeAddString(SI_PA_MENU_REPAIR_INVENTORY_HEADER, "Предметы в инвентаре", 1)
SafeAddString(SI_PA_MENU_REPAIR_INVENTORY_ENABLE, "Ремонтировать предметы в инвентаре", 1)

SafeAddString(SI_PA_MENU_REPAIR_GOLD_INVENTORY_ENABLE, table.concat({"Ремонтировать за ", GetCurrencyName(CURT_MONEY)}), 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_INVENTORY_ENABLE_T, "Все предметы в инвентаре с прочностью ниже или равной указанной будут автоматически отремонтированы при посещении торговца", 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_INVENTORY_DURABILITY, "Порог прочности %", 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_INVENTORY_DURABILITY_T, "Предметы в инвентаре ремонтируются только если их прочность ниже или равна указанной", 1)


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PARepair --
SafeAddString(SI_PA_CHAT_REPAIR_SUMMARY_FULL, "Восстановлено экипированное за %s", 1)
SafeAddString(SI_PA_CHAT_REPAIR_SUMMARY_PARTIAL, "Восстановлено экипированное за %s (%s не хватило)", 1)

SafeAddString(SI_PA_CHAT_REPAIR_SUMMARY_INVENTORY_FULL, "Восстановлено в инвентаре за %s", 1)
SafeAddString(SI_PA_CHAT_REPAIR_SUMMARY_INVENTORY_PARTIAL, "Восстановлено в инвентаре за %s (%s не хватило)", 1)

SafeAddString(SI_PA_CHAT_REPAIR_REPAIRKIT_REPAIRED, table.concat({"Восстановлено %s ", PAC.COLORS.WHITE, "(%d%%)", PAC.COLORS.DEFAULT, " за %s"}), 1)
