local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PARepair Menu --
SafeAddString(SI_PA_MENU_REPAIR_DESCRIPTION, "PARepair repariert deine getragene Ausrüstung und lädt Waffen für dich wieder auf, sei es beim Händler oder unterwegs.", 1)

-- Equipped Items --
SafeAddString(SI_PA_MENU_REPAIR_EQUIPPED_HEADER, "Getragene Ausrüstung", 1)
SafeAddString(SI_PA_MENU_REPAIR_ENABLE, "Automatische Reparatur getragener Ausrüstung", 1)

SafeAddString(SI_PA_MENU_REPAIR_GOLD_HEADER, table.concat({"Reparatur mit ", GetCurrencyName(CURT_MONEY)}), 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_ENABLE, table.concat({"Repariere Ausrüstung mit ", GetCurrencyName(CURT_MONEY), "?"}), 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_ENABLE_T, "Wenn ein Händler besucht wird, werden getragene Ausrüstungen automatisch repariert sofern deren Haltbarkeit genau auf oder unter dem definierten Schwellenwert liegt", 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_DURABILITY, "Haltbarkeitsschwelle in %", 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_DURABILITY_T, "Repariere getragene Ausrüstung nur wenn deren Haltbarkeit genau auf oder unter dem definierten Schwellenwert liegt", 1)

SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_HEADER, table.concat({"Reparatur mit ", GetString(SI_PA_MENU_BANKING_REPAIRKIT)}), 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE, table.concat({"Repariere Ausrüstung mit ", GetString(SI_PA_MENU_BANKING_REPAIRKIT), "?"}), 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE_T, "Unterwegs werden getragenen Ausrüstungen automatisch repariert wenn deren Haltbarkeit genau auf oder unter dem definierten Schwellenwert liegt", 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY, "Schwellenwert der Haltbarkeit in %", 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY_T, "Repariere getragene Gegenstände nur wenn deren Haltbarkeit genau auf oder unter dem definierten Schwellenwert liegt", 1)
--SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_ENABLE, "tbd", 1)
--SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_ENABLE_T, "tbd", 1)
--SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_DURABILITY, "tbd", 1)
--SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_DURABILITY_T, "tbd", 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING, "Warne wenn Reparaturmat. ausgehen", 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING_T, table.concat({"Zeige eine Warnung im Chatfenster an wenn dir die ", GetString(SI_PA_MENU_BANKING_REPAIRKIT), " ausgehen. Wenn du keine mehr hast wird maximal alle 10 Minuten eine Warnung angezeigt."}), 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD, "Schwellenwert für Reparaturmat.", 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD_T, table.concat({"Wenn die Anzahl verbleibender ", GetString(SI_PA_MENU_BANKING_REPAIRKIT), " auf oder unter diesen Schwellenwert fällt, ird eine Meldung im Chat ausgegeben"}), 1)

SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_HEADER, table.concat({"Waffen mit ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), "n aufladen"}), 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_ENABLE, table.concat({"Getragene Waffen mit ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), "n aufladen?"}), 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_ENABLE_T, "Getragene Waffen aufladen wenn deren Aufladung komplett aufgebraucht ist. Es werden zuerst die Seelensteine verwendet die unten als bevorzugt ausgewählt sind.", 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_DEFAULT_GEM, "Bevorzugte Seelensteine", 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_DEFAULT_GEM_T, "Legt fest, welche Seelensteine beim Aufladen einer Waffe zuerst verbraucht werden.", 1)
--SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_CHATMODE, "tbd", 1)
--SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_CHATMODE_T, "tbd", 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING, table.concat({"Warne wenn ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), " ausgehen"}), 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING_T, table.concat({"Zeige eine Warnung im Chatfenster an wenn dir die ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), " ausgehen. Wenn du keine mehr hast wird maximal alle 10 Minuten eine Warnung angezeigt."}), 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD, table.concat({"Schwellenwert für ", GetString("SI_ITEMTYPE", ITEMTYPE_SOUL_GEM)}), 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD_T, table.concat({"Wenn die Anzahl verbleibender ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), " auf oder unter diesen Schwellenwert fällt, wird eine Meldung im Chat ausgegeben"}), 1)

-- Inventory Items --
SafeAddString(SI_PA_MENU_REPAIR_INVENTORY_HEADER, "Inventar Ausrüstung", 1)
SafeAddString(SI_PA_MENU_REPAIR_INVENTORY_ENABLE, "Automatische Reparatur von Ausrüstung im Inventar", 1)

SafeAddString(SI_PA_MENU_REPAIR_GOLD_INVENTORY_ENABLE, table.concat({"Repariere Inventar mit ", GetCurrencyName(CURT_MONEY), "?"}), 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_INVENTORY_ENABLE_T, "Wenn ein Händler besucht wird, werden Ausrüstungen im Inventar automatisch repariert sofern deren Haltbarkeit genau auf oder unter dem definierten Schwellenwert liegt", 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_INVENTORY_DURABILITY, "Haltbarkeitsschwelle in %", 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_INVENTORY_DURABILITY_T, "Repariere Ausrüstung im Inventar nur wenn deren Haltbarkeit genau auf oder unter dem definierten Schwellenwert liegt", 1)


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PARepair --
SafeAddString(SI_PA_CHAT_REPAIR_SUMMARY_FULL, "Repariere getragene Ausrüstung für %s", 1)
SafeAddString(SI_PA_CHAT_REPAIR_SUMMARY_PARTIAL, "Repariere getragene Ausrüstung für %s (%s fehlend)", 1)

SafeAddString(SI_PA_CHAT_REPAIR_SUMMARY_INVENTORY_FULL, "Repariere Ausrüstung im Inventar für %s", 1)
SafeAddString(SI_PA_CHAT_REPAIR_SUMMARY_INVENTORY_PARTIAL, "Repariere Ausrüstung im Inventar für %s (%s fehlend)", 1)

SafeAddString(SI_PA_CHAT_REPAIR_REPAIRKIT_REPAIRED, table.concat({"Repariere %s ", PAC.COLORS.WHITE, "(%d%%)", PAC.COLORS.DEFAULT, " mit %s"}), 1)