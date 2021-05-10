local PAC = PersonalAssistant.Constants
local PABStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking Menu --
    SI_PA_MENU_BANKING_DESCRIPTION = "PABanking kann Währungen, Handwerks- und andere Gegenstände für dich zwischen deinem Inventar und der Truhe hin und her schieben",

    -- Currencies --
    SI_PA_MENU_BANKING_CURRENCY_HEADER = GetString(SI_INVENTORY_CURRENCIES),
    SI_PA_MENU_BANKING_CURRENCY_ENABLE = table.concat({"Aktiviere Transaktionen für ", GetString(SI_INVENTORY_CURRENCIES)}),
    SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP = "Minimal im Inventar behalten",
    SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP = "Maximal im Inventar behalten",

    -- Crafting Items --
    SI_PA_MENU_BANKING_CRAFTING_HEADER = "Handwerks Gegenstände",
    SI_PA_MENU_BANKING_CRAFTING_ENABLE = "Aktiviere Transaktionen für Handwerks Gegenstände",
    SI_PA_MENU_BANKING_CRAFTING_ENABLE_T = "Aktiviere automatisches Einlagern und Entnehmen für die verschiedenen Handwerks Gegenstände?",
    SI_PA_MENU_BANKING_CRAFTING_DESCRIPTION = "Definiere ein individuelles Verhalten (Einlagern, Entnehmen, oder Nichts machen) für Handwerks Gegenstände",
    SI_PA_MENU_BANKING_CRAFTING_ESOPLUS_DESC = "Als ESO Plus-Mitglied ist das Einlagern/Entnehmen von Handwerksmaterialien nicht relevant da alle davon in unbeschränkter Menge im Handwerksbeutel verstaut werden können.",
    SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE = "Ändere alle obigen Dropdown-Listen nach",
    SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE_T = "Ändere alle obigen Handwerks Dropdown-Listen nach 'In Truhe einlagern', 'Ins Inventar entnehmen', oder 'Nichts machen'",

    -- Advanced Items --
    SI_PA_MENU_BANKING_ADVANCED_HEADER = "Spezielle Gegenstände",
    SI_PA_MENU_BANKING_ADVANCED_ENABLE = "Aktiviere Transaktionen für Spezielle Gegenstände",
    SI_PA_MENU_BANKING_ADVANCED_ENABLE_T = "Aktiviere automatisches Einlagern und Entnehmen für die verschiedenen Speziellen Gegenständen?",
    SI_PA_MENU_BANKING_ADVANCED_DESCRIPTION = "Definiere ein individuelles Verhalten (Einlagern, Entnehmen, oder Nichts machen) für spezielle Gegenstände",

    SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE = "Ändere alle obigen Dropdown-Listen nach",
    SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE_T = "Ändere alle obigen Speziellen Dropdown-Listen nach 'In Truhe einlagern', 'Ins Inventar entnehmen', oder 'Nichts machen'",

    SI_PA_MENU_BANKING_ADVANCED_KNOWN_ITEMTYPE8 = table.concat({PAC.ICONS.OTHERS.KNOWN.NORMAL, " Bekannte Stile"}),
    SI_PA_MENU_BANKING_ADVANCED_KNOWN_ITEMTYPE29 = table.concat({PAC.ICONS.OTHERS.KNOWN.NORMAL, " Bekannte Rezepte"}),
    SI_PA_MENU_BANKING_ADVANCED_UNKNOWN_ITEMTYPE8 = table.concat({PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " Unbekannte Stile"}),
    SI_PA_MENU_BANKING_ADVANCED_UNKNOWN_ITEMTYPE29 = table.concat({PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " Unbekannte Rezepte"}),

    -- Individual Items --
    SI_PA_MENU_BANKING_INDIVIDUAL_HEADER = "Einzelne Gegenstände",
    SI_PA_MENU_BANKING_INDIVIDUAL_DISABLED_DESCRIPTION = table.concat({"Mit der Einführung der benutzerdefinierten Banking Regeln wurden die \"Individuellen\" Einstellungen dorthin migriert. ", GetString(SI_PA_MENU_RULES_HOW_TO_ADD_PAB), "\n\n", GetString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU)}),

    -- AvA Items --
    SI_PA_MENU_BANKING_AVA_HEADER = "AvA Gegenstände",
    SI_PA_MENU_BANKING_AVA_ENABLE = "Aktiviere Transaktionen für AvA Gegenstände",
    SI_PA_MENU_BANKING_AVA_ENABLE_T = "Aktiviere automatisches Einlagern und Entnehmen für die verschiedenen Allianz versus Alliance (AvA) Gegenständen?",
    SI_PA_MENU_BANKING_AVA_DESCRIPTION = "Definiere die Menge der Allianz versus Alliance (AvA) Gegenstände die im Inventar behalten werden sollen",
    SI_PA_MENU_BANKING_AVA_OTHER_HEADER = "Anderes",

    -- Other Settings --
    SI_PA_MENU_BANKING_AUTO_ITEM_TRANSFER_EXECUTION = "Automatisch PABanking Gegenstände transferieren",
    SI_PA_MENU_BANKING_AUTO_ITEM_TRANSFER_EXECUTION_T = "Automatisch alle Gegenstände zwischen Inventar und Truhe transferieren wenn die Truhe geöffnet wird? Wenn deaktiviert, kann ein PABanking Transfer jederzeit bei geöffneter Bank manuell gestartet werden",

    SI_PA_MENU_BANKING_OTHER_DEPOSIT_STACKING = "Regel fürs Stapeln beim Einlagern",
    SI_PA_MENU_BANKING_OTHER_DEPOSIT_STACKING_T = "Definiere ob alle Gegenstände in die Truhe eingelagert werden sollen, oder nur wenn bereits Stapel bestehen die aufgefüllt werden können",
    SI_PA_MENU_BANKING_OTHER_WITHDRAWAL_STACKING = "Regel fürs Stapeln beim Entnehmen",
    SI_PA_MENU_BANKING_OTHER_WITHDRAWAL_STACKING_T = "Definiere ob alle Gegenstände ins Inventar entnommen werden sollen, oder nur wenn bereits Stapel bestehen die aufgefüllt werden können",

    SI_PA_MENU_BANKING_EXCLUDE_JUNK = "Verschiebe keine als Trödel markierte Gegenstände",

    SI_PA_MENU_BANKING_OTHER_AUTOSTACKBAGS = "Automatisch alle Gegenstände stapeln",
    SI_PA_MENU_BANKING_OTHER_AUTOSTACKBAGS_T = "Sollen automatisch alle Gegenstände im Inventar und in der Truhe gestapelt werden wenn die Truhe geöffnet wird? Ist hilfreich um alles besser organisiert zu halten",

    -- Generic definitions for any type --
    SI_PA_MENU_BANKING_ANY_CURRENCY_ENABLE = "%s einlagern/entnehmen",

    SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK = "Zu behaltende Menge",
    SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK_T = "Definiere die Menge welche (basierend auf dem mathematischen Operator) im Inventar oder der Bank behalten werden soll",

    SI_PA_MENU_BANKING_ANY_MINTOKEEP_T = "Minimale Menge an %s die immer im Inventar behalten werden soll; wenn notwendig wird fehlendes von der Truhe entnommen",
    SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T = "Maximale Menge an %s die immer im Inventar behalten werden soll; wenn notwendig wird alles darüber in die Truhe eingelagert",

    SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_W = "Dies kann nicht rückgängig gemacht werden; alle individuellen Einträge werden überschrieben",


    -- =================================================================================================================
    -- == MAIN MENU TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_PA_MAINMENU_BANKING_HEADER = "Banking Regeln",

    SI_PA_MAINMENU_BANKING_HEADER_CATEGORY = "K", -- First letter of "Kategorie"
    SI_PA_MAINMENU_BANKING_HEADER_BAG = "Ort",
    SI_PA_MAINMENU_BANKING_HEADER_RULE = "Regel",
    SI_PA_MAINMENU_BANKING_HEADER_AMOUNT = "Anzahl",
    SI_PA_MAINMENU_BANKING_HEADER_ITEM = "Gegenstand",
    SI_PA_MAINMENU_BANKING_HEADER_ACTIONS = "Aktionen",


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking Add Custom Rule Description --
    SI_PA_DIALOG_BANKING_BANK_EXACTLY_PRE = "In der %s sollen genau %d vom ausgewählten Gegenstand sein.",
    SI_PA_DIALOG_BANKING_BANK_LESSTHANOREQUAL_PRE = "In der %s sollen höchstens %d vom ausgewählten Gegenstand sein.",
    SI_PA_DIALOG_BANKING_BANK_GREATERTHANOREQUAL_PRE = "In der %s sollen mindestens %d vom ausgewählten Gegenstand sein.",
    SI_PA_DIALOG_BANKING_BANK_EXACTLY_NOTHING = "> %d in der %s hast => passiert nichts.",
    SI_PA_DIALOG_BANKING_BANK_EXACTLY_DEPOSIT = "> %d in der %s hast => transferiere Gegenstände in die %s bis dort %d sind.",
    SI_PA_DIALOG_BANKING_BANK_FROM_TO_NOTHING = "> %d - %d in der %s hast => passiert nichts.",
    SI_PA_DIALOG_BANKING_BANK_FROM_TO_DEPOSIT = "> %d - %d in der %s hast => transferiere Gegenstände in die %s bis dort %d sind.",
    SI_PA_DIALOG_BANKING_BANK_FROM_TO_WITHDRAW = "> %d - %d in der %s hast => transferiere Gegenstände aus der %s bis dort %d übrig sind.",

    SI_PA_DIALOG_BANKING_BACKPACK_EXACTLY_PRE = "Im %s sollen genau %d vom ausgewählten Gegenstand sein.",
    SI_PA_DIALOG_BANKING_BACKPACK_LESSTHANOREQUAL_PRE = "Im %s sollen höchstens %d vom ausgewählten Gegenstand sein.",
    SI_PA_DIALOG_BANKING_BACKPACK_GREATERTHANOREQUAL_PRE = "Im %s sollen mindestens %d vom ausgewählten Gegenstand sein.",
    SI_PA_DIALOG_BANKING_BACKPACK_EXACTLY_NOTHING = "> %d im %s hast => passiert nichts.",
    SI_PA_DIALOG_BANKING_BACKPACK_EXACTLY_DEPOSIT = "> %d im %s hast => transferiere Gegenstände in das %s bis dort %d sind.",
    SI_PA_DIALOG_BANKING_BACKPACK_FROM_TO_NOTHING = "> %d - %d im %s hast => passiert nichts.",
    SI_PA_DIALOG_BANKING_BACKPACK_FROM_TO_DEPOSIT = "> %d - %d im %s hast => transferiere Gegenstände in das %s bis dort %d sind.",
    SI_PA_DIALOG_BANKING_BACKPACK_FROM_TO_WITHDRAW = "> %d - %d im %s hast => transferiere Gegenstände aus dem %s bis dort %d übrig sind.",

    SI_PA_DIALOG_BANKING_EXPLANATION = "Das bedeutet, wenn du . . .",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_PA_CHAT_BANKING_FINISHED = "Transfer aller Gegenstände abgeschlossen",

    SI_PA_CHAT_BANKING_WITHDRAWAL_COMPLETE = "%s entnommen",
    SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_SOURCE = "%s / %s entnommen (Truhe ist leer)",
    SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_TARGET = "%s / %s entnommen (Nicht genug Platz im Inventar)",

    SI_PA_CHAT_BANKING_DEPOSIT_COMPLETE = "%s eingelagert",
    SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_SOURCE = "%s / %s eingelagert (Inventar ist leer)",
    SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_TARGET = "%s / %s eingelagert (Nicht genug Platz in Truhe)",

    SI_PA_CHAT_BANKING_ITEMS_MOVED_COMPLETE = "%d x %s in %s verschoben",
    SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_OUTOFSPACE = "%s konnte nicht in %s verschoben werden. Nicht genügend Platz!",
    SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_BANKCLOSED = "%s konnte nicht in %s verschoben werden. Fenster wurde geschlossen!",
    SI_PA_CHAT_BANKING_ITEMS_SKIPPED_LWC = "Manche Gegenstände wurden NICHT eingelagert um potentielle Überlagerungen mit Dolgubon's Lazy Writ Crafter zu vermeiden",

    SI_PA_CHAT_BANKING_RULES_ADDED = table.concat({"Regel für %s wurde ", PAC.COLOR.ORANGE:Colorize("hinzugefügt"), "!"}),
    SI_PA_CHAT_BANKING_RULES_UPDATED = table.concat({"Regel für %s wurde ", PAC.COLOR.ORANGE:Colorize("angepasst"), "!"}),
    SI_PA_CHAT_BANKING_RULES_DELETED = table.concat({"Regel für %s wurde ", PAC.COLOR.ORANGE:Colorize("gelöscht"), "!"}),
    SI_PA_CHAT_BANKING_RULES_ENABLED = table.concat({"Regel für %s wurde ", PAC.COLOR.ORANGE:Colorize("aktiviert"), "!"}),
    SI_PA_CHAT_BANKING_RULES_DISABLED = table.concat({"Regel für %s wurde ", PAC.COLOR.ORANGE:Colorize("deaktiviert"), "!"}),


    -- =================================================================================================================
    -- == KEY BINDINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_BINDING_NAME_PA_BANKING_EXECUTE_ITEM_TRANSFERS = "Starte PABanking",
    SI_BINDING_NAME_PA_BANKING_EXECUTE_ITEM_TRANSFERS_PENDING = "PABanking läuft...",
}

for key, value in pairs(PABStrings) do
    SafeAddString(_G[key], value, 1)
end
