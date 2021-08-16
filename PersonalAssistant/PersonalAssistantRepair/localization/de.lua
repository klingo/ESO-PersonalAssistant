local PAC = PersonalAssistant.Constants
local PARStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair Menu --
    SI_PA_MENU_REPAIR_DESCRIPTION = "PARepair repariert deine getragene Ausrüstung und lädt Waffen für dich wieder auf, sei es beim Händler oder unterwegs.",

    -- Equipped Items --
    SI_PA_MENU_REPAIR_EQUIPPED_HEADER = "Getragene Ausrüstung",
    SI_PA_MENU_REPAIR_ENABLE = "Automatische Reparatur getragener Ausrüstung",

    SI_PA_MENU_REPAIR_GOLD_HEADER = table.concat({"Reparatur mit ", GetCurrencyName(CURT_MONEY)}),
    SI_PA_MENU_REPAIR_GOLD_ENABLE = table.concat({"Repariere Ausrüstung mit ", GetCurrencyName(CURT_MONEY), "?"}),
    SI_PA_MENU_REPAIR_GOLD_ENABLE_T = "Wenn ein Händler besucht wird, werden getragene Ausrüstungen automatisch repariert sofern deren Haltbarkeit genau auf oder unter dem definierten Schwellenwert liegt",
    SI_PA_MENU_REPAIR_GOLD_DURABILITY = "Haltbarkeitsschwelle in %",
    SI_PA_MENU_REPAIR_GOLD_DURABILITY_T = "Repariere getragene Ausrüstung nur wenn deren Haltbarkeit genau auf oder unter dem definierten Schwellenwert liegt",

    SI_PA_MENU_REPAIR_REPAIRKIT_HEADER = table.concat({"Reparatur mit ", GetString(SI_PA_MENU_BANKING_REPAIRKIT)}),
    SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE = table.concat({"Repariere Ausrüstung mit ", GetString(SI_PA_MENU_BANKING_REPAIRKIT), "?"}),
    SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE_T = "Unterwegs werden getragenen Ausrüstungen automatisch repariert wenn deren Haltbarkeit genau auf oder unter dem definierten Schwellenwert liegt",
    SI_PA_MENU_REPAIR_REPAIRKIT_DEFAULT_KIT = "Bevorzugte Reparaturmaterialien",
    SI_PA_MENU_REPAIR_REPAIRKIT_DEFAULT_KIT_T = "Legt fest, welche Reparaturmaterialien beim Reparieren der Ausrüstung zuerst verbraucht werden.",
    SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY = "Schwellenwert der Haltbarkeit in %",
    SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY_T = "Repariere getragene Gegenstände nur wenn deren Haltbarkeit genau auf oder unter dem definierten Schwellenwert liegt",
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING = "Warne wenn Reparaturmat. ausgehen",
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING_T = table.concat({"Zeige eine Warnung im Chatfenster an wenn dir die ", GetString(SI_PA_MENU_BANKING_REPAIRKIT), " ausgehen. Wenn du keine mehr hast wird maximal alle 10 Minuten eine Warnung angezeigt."}),
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD = "Schwellenwert für Reparaturmat.",
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD_T = table.concat({"Wenn die Anzahl verbleibender ", GetString(SI_PA_MENU_BANKING_REPAIRKIT), " auf oder unter diesen Schwellenwert fällt, ird eine Meldung im Chat ausgegeben"}),

    SI_PA_MENU_REPAIR_RECHARGE_HEADER = table.concat({"Waffen mit ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), "n aufladen"}),
    SI_PA_MENU_REPAIR_RECHARGE_ENABLE = table.concat({"Getragene Waffen mit ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), "n aufladen?"}),
    SI_PA_MENU_REPAIR_RECHARGE_ENABLE_T = "Getragene Waffen aufladen wenn deren Aufladung komplett aufgebraucht ist. Es werden zuerst die Seelensteine verwendet die unten als bevorzugt ausgewählt sind.",
    SI_PA_MENU_REPAIR_RECHARGE_DEFAULT_GEM = "Bevorzugte Seelensteine",
    SI_PA_MENU_REPAIR_RECHARGE_DEFAULT_GEM_T = "Legt fest, welche Seelensteine beim Aufladen einer Waffe zuerst verbraucht werden.",
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING = table.concat({"Warne wenn ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), " ausgehen"}),
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING_T = table.concat({"Zeige eine Warnung im Chatfenster an wenn dir die ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), " ausgehen. Wenn du keine mehr hast wird maximal alle 10 Minuten eine Warnung angezeigt."}),
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD = table.concat({"Schwellenwert für ", GetString("SI_ITEMTYPE", ITEMTYPE_SOUL_GEM)}),
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD_T = table.concat({"Wenn die Anzahl verbleibender ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), " auf oder unter diesen Schwellenwert fällt, wird eine Meldung im Chat ausgegeben"}),

    -- Inventory Items --
    SI_PA_MENU_REPAIR_INVENTORY_HEADER = "Inventar Ausrüstung",
    SI_PA_MENU_REPAIR_INVENTORY_ENABLE = "Automatische Reparatur von Ausrüstung im Inventar",

    SI_PA_MENU_REPAIR_GOLD_INVENTORY_ENABLE = table.concat({"Repariere Inventar mit ", GetCurrencyName(CURT_MONEY), "?"}),
    SI_PA_MENU_REPAIR_GOLD_INVENTORY_ENABLE_T = "Wenn ein Händler besucht wird, werden Ausrüstungen im Inventar automatisch repariert sofern deren Haltbarkeit genau auf oder unter dem definierten Schwellenwert liegt",
    SI_PA_MENU_REPAIR_GOLD_INVENTORY_DURABILITY = "Haltbarkeitsschwelle in %",
    SI_PA_MENU_REPAIR_GOLD_INVENTORY_DURABILITY_T = "Repariere Ausrüstung im Inventar nur wenn deren Haltbarkeit genau auf oder unter dem definierten Schwellenwert liegt",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair --
    SI_PA_CHAT_REPAIR_SUMMARY_FULL = "Repariere getragene Ausrüstung für %s",
    SI_PA_CHAT_REPAIR_SUMMARY_PARTIAL = "Repariere getragene Ausrüstung für %s (%s fehlend)",

    SI_PA_CHAT_REPAIR_SUMMARY_INVENTORY_FULL = "Repariere Ausrüstung im Inventar für %s",
    SI_PA_CHAT_REPAIR_SUMMARY_INVENTORY_PARTIAL = "Repariere Ausrüstung im Inventar für %s (%s fehlend)",

    SI_PA_CHAT_REPAIR_REPAIRKIT_REPAIRED = table.concat({"Repariere %s ", PAC.COLORS.WHITE, "(%d%%)", PAC.COLORS.DEFAULT, " mit %s"}),
    SI_PA_CHAT_REPAIR_REPAIRKIT_REPAIRED_ALL = table.concat({"Repariere %s ", PAC.COLORS.WHITE, "(%d%%)", PAC.COLORS.DEFAULT, " und die restliche Ausrüstung mit %s"}),
}

for key, value in pairs(PARStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end
