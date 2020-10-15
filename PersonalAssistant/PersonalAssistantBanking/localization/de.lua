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

    -- Special Items --
    SI_PA_MENU_BANKING_SPECIAL_HEADER = "Spezielle Gegenstände",
    SI_PA_MENU_BANKING_SPECIAL_ENABLE = "Aktiviere Transaktionen für Spezielle Gegenstände",
    SI_PA_MENU_BANKING_SPECIAL_ENABLE_T = "Aktiviere automatisches Einlagern und Entnehmen für die verschiedenen Speziellen Gegenständen?",
    SI_PA_MENU_BANKING_SPECIAL_DESCRIPTION = "Definiere ein individuelles Verhalten (Einlagern, Entnehmen, oder Nichts machen) für spezielle Gegenstände",

    SI_PA_MENU_BANKING_SPECIAL_GLOBAL_MOVEMODE = "Ändere alle obigen Dropdown-Listen nach",
    SI_PA_MENU_BANKING_SPECIAL_GLOBAL_MOVEMODE_T = "Ändere alle obigen Speziellen Dropdown-Listen nach 'In Truhe einlagern', 'Ins Inventar entnehmen', oder 'Nichts machen'",

    SI_PA_MENU_BANKING_SPECIAL_KNOWN_ITEMTYPE8 = table.concat({PAC.ICONS.OTHERS.KNOWN.NORMAL, " Bekannte Stile"}),
    SI_PA_MENU_BANKING_SPECIAL_KNOWN_ITEMTYPE29 = table.concat({PAC.ICONS.OTHERS.KNOWN.NORMAL, " Bekannte Rezepte"}),
    SI_PA_MENU_BANKING_SPECIAL_UNKNOWN_ITEMTYPE8 = table.concat({PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " Unbekannte Stile"}),
    SI_PA_MENU_BANKING_SPECIAL_UNKNOWN_ITEMTYPE29 = table.concat({PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " Unbekannte Rezepte"}),

    -- Simple Banking Rules --
    SI_PA_MENU_BANKING_RULES_SIMPLE_HEADER = "Einfache Bank Regeln",
    SI_PA_MENU_BANKING_RULES_SIMPLE_DISABLED_DESCRIPTION = table.concat({GetString(SI_PA_MENU_RULES_HOW_TO_ADD_PAB), "\n\n", GetString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU)}),

    -- Advanced Banking Rules --
    SI_PA_MENU_BANKING_RULES_ADVANCED_HEADER = "Erweiterte Bank Regeln",
    SI_PA_MENU_BANKING_RULES_ADVANCED_DESCRIPTION = table.concat({"Erweiterte Bank Regeln ermöglichen das Erstellen von komplexen Regeln für Rüstungen, Schmuck, und Waffen um ganz spezifisch zu definieren welche in die Bank eingelagert, oder von dort entnommen werden sollen.\nDiese Regeln werden nach den einfachen Bank Regeln ausgeführt.", "\n\n", GetString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU)}),

    -- AvA Items --
    SI_PA_MENU_BANKING_AVA_HEADER = "AvA Gegenstände",
    SI_PA_MENU_BANKING_AVA_ENABLE = "Aktiviere Transaktionen für AvA Gegenstände",
    SI_PA_MENU_BANKING_AVA_ENABLE_T = "Aktiviere automatisches Einlagern und Entnehmen für die verschiedenen Allianz versus Alliance (AvA) Gegenständen?",
    SI_PA_MENU_BANKING_AVA_DESCRIPTION = "Definiere die Menge der Allianz versus Alliance (AvA) Gegenstände die im Inventar behalten werden sollen",
    SI_PA_MENU_BANKING_AVA_OTHER_HEADER = "Anderes",

    -- Other Settings --
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
    SI_PA_MAINMENU_BANKING_HEADER = "Einfache Bank Regeln",
    SI_PA_MAINMENU_BANKING_HEADER_BAG = "Ort",
    SI_PA_MAINMENU_BANKING_HEADER_RULE = "Regel",
    SI_PA_MAINMENU_BANKING_HEADER_AMOUNT = "Anzahl",
    SI_PA_MAINMENU_BANKING_HEADER_ITEM = "Gegenstand",
    SI_PA_MAINMENU_BANKING_HEADER_ACTIONS = "Aktionen",

    SI_PA_MAINMENU_BANKING_ADVANCED_HEADER = "Erweiterte Bank Regeln",
    SI_PA_MAINMENU_BANKING_ADVANCED_RULE_ID = "#",
    SI_PA_MAINMENU_BANKING_ADVANCED_BAG_ID = "<>",
    SI_PA_MAINMENU_BANKING_ADVANCED_RULE_SUMMARY = "Regel Zusammenfassung",
    SI_PA_MAINMENU_BANKING_ADVANCED_ACTIONS = "Aktionen",


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

    -- -----------------------------------------------------------------------------------------------------------------
    -- Simple Banking Rules --
    SI_PA_DIALOG_BANKING_SIMPLE_DISCLAIMER = "Anmerkung: Diese benutzerdefinierten Regeln werden erst berücksichtigt, wenn alle anderen automatischen Banking Regeln (Handwerks, Spezielle, und AvA Gegenstände) ausgeführt wurden.",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Advanced Banking Rules --
--    SI_PA_DIALOG_BANKING_ADVANCED_ITEM_ACTION = "Item Action",
--    SI_PA_DIALOG_BANKING_ADVANCED_ITEM_GROUP = "Item Group",
--    SI_PA_DIALOG_BANKING_ADVANCED_ITEM_QUALITIES = "Item Qualities",
--    SI_PA_DIALOG_BANKING_ADVANCED_ITEM_TYPES = "Item Types",
--    SI_PA_DIALOG_BANKING_ADVANCED_LEVEL_RANGE = "Level / Champion Point Range",
--    SI_PA_DIALOG_BANKING_ADVANCED_ITEM_TRAITS = "Item Traits",
--    SI_PA_DIALOG_BANKING_ADVANCED_TRAIT_TYPES = "Trait Types",
--    SI_PA_DIALOG_BANKING_ADVANCED_SET_ITEMS = "Set Items",
--    SI_PA_DIALOG_BANKING_ADVANCED_CRAFTED_ITEMS = "Crafted Items",
--
--    SI_PA_DIALOG_BANKING_ADVANCED_PLEASE_SELECT = "<Please Select>",
--    SI_PA_DIALOG_BANKING_ADVANCED_ITEM_GROUP_PLEASE_SELECT = "Please select an [Item Group] first...",
--
--    SI_PA_DIALOG_BANKING_ADVANCED_NONE = "None",
--    SI_PA_DIALOG_BANKING_ADVANCED_AVAILABLE = "Available",
--    SI_PA_DIALOG_BANKING_ADVANCED_SELECTED = "Selected",
--    SI_PA_DIALOG_BANKING_ADVANCED_ITEM_QUALITIES_ANY = "Any Quality",
--    SI_PA_DIALOG_BANKING_ADVANCED_ITEM_TYPES_ANY = "Any Item Type",
--    SI_PA_DIALOG_BANKING_ADVANCED_ITEM_TRAITS_NONE = "No Traits",
--
--    SI_PA_DIALOG_BANKING_ADVANCED_SET_ITEMS_ANY = "Any items (Set and NON-Set)",
--    SI_PA_DIALOG_BANKING_ADVANCED_SET_ITEMS_SET = "Only items part of a Set",
--    SI_PA_DIALOG_BANKING_ADVANCED_SET_ITEMS_NO_SET = "Only items NOT part of a Set",
--
--    SI_PA_DIALOG_BANKING_ADVANCED_CRAFTED_ITEMS_ANY = "Any items (crafted and NON-crafted)",
--    SI_PA_DIALOG_BANKING_ADVANCED_CRAFTED_ITEMS_CRAFTED = "Only crafted items",
--    SI_PA_DIALOG_BANKING_ADVANCED_CRAFTED_ITEMS_NOT_CRAFTED = "Only NON-crafted items",
--
--    SI_PA_DIALOG_BANKING_ADVANCED_TRAIT_TYPES_SELECTED = "Only selected traits",
--    SI_PA_DIALOG_BANKING_ADVANCED_TRAIT_TYPES_ANY = "Any items (known and unknown traits)",
--    SI_PA_DIALOG_BANKING_ADVANCED_TRAIT_TYPES_KNOWN = "Only items with known traits",
--    SI_PA_DIALOG_BANKING_ADVANCED_TRAIT_TYPES_UNKNOWN = "Only items with unknown traits",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Advanced Banking Rules - Rule Construction --
--    SI_PA_DIALOG_BANKING_ADVANCED_RULE_SUMMARY_DEPOSIT = "DEPOSIT %s to BANK",
--    SI_PA_DIALOG_BANKING_ADVANCED_RULE_SUMMARY_WITHDRAW = "WITHDRAW %s to BACKPACK",
--
--    SI_PA_DIALOG_BANKING_ADVANCED_RULE_OF_QUALITY = "of [%s] quality",
--    SI_PA_DIALOG_BANKING_ADVANCED_RULE_LEVEL = "Level",
--    SI_PA_DIALOG_BANKING_ADVANCED_RULE_CP = "CP",
--
--    SI_PA_DIALOG_BANKING_ADVANCED_RULE_SET = "[Set]",
--    SI_PA_DIALOG_BANKING_ADVANCED_RULE_NO_SET = "[Non-Set]",
--    SI_PA_DIALOG_BANKING_ADVANCED_RULE_CRAFTED = "[Crafted]",
--    SI_PA_DIALOG_BANKING_ADVANCED_RULE_NO_CRAFTED = "[Non-Crafted]",
--    SI_PA_DIALOG_BANKING_ADVANCED_RULE_KNOWN_TRAITS = "with [known] traits",
--    SI_PA_DIALOG_BANKING_ADVANCED_RULE_UNKNOWN_TRAITS = "with [unknown] traits",
--    SI_PA_DIALOG_BANKING_ADVANCED_RULE_NO_TRAITS = "with [no] traits",
--    SI_PA_DIALOG_BANKING_ADVANCED_RULE_SELECTED_TRAITS = "with [%s] trait",
--
--    SI_PA_DIALOG_BANKING_ADVANCED_RULE_ANY = "any",
--    SI_PA_DIALOG_BANKING_ADVANCED_RULE_AND = "and [%s]",
--    SI_PA_DIALOG_BANKING_ADVANCED_RULE_BETWEEN = "between [%s] and [%s]",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_PA_CHAT_BANKING_WITHDRAWAL_COMPLETE = "%s entnommen",
    SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_SOURCE = "%s / %s entnommen (Truhe ist leer)",
    SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_TARGET = "%s / %s entnommen (Nicht genug Platz im Inventar)",

    SI_PA_CHAT_BANKING_DEPOSIT_COMPLETE = "%s eingelagert",
    SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_SOURCE = "%s / %s eingelagert (Inventar ist leer)",
    SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_TARGET = "%s / %s eingelagert (Nicht genug Platz in Truhe)",

    SI_PA_CHAT_BANKING_ITEMS_MOVED_COMPLETE = "%d x %s in %s verschoben",
    SI_PA_CHAT_BANKING_ITEMS_MOVED_PARTIAL = "%d/%d x %s in %s verschoben",
    SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_OUTOFSPACE = "%s konnte nicht in %s verschoben werden. Nicht genügend Platz!",
    SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_BANKCLOSED = "%s konnte nicht in %s verschoben werden. Fenster wurde geschlossen!",
    SI_PA_CHAT_BANKING_ITEMS_SKIPPED_LWC = "Manche Gegenstände wurden NICHT eingelagert um potentielle Überlagerungen mit Dolgubon's Lazy Writ Crafter zu vermeiden",

    SI_PA_CHAT_BANKING_RULES_ADDED = table.concat({"Regel für %s wurde ", PAC.COLOR.ORANGE:Colorize("hinzugefügt"), "!"}),
    SI_PA_CHAT_BANKING_RULES_UPDATED = table.concat({"Regel für %s wurde ", PAC.COLOR.ORANGE:Colorize("angepasst"), "!"}),
    SI_PA_CHAT_BANKING_RULES_DELETED = table.concat({"Regel für %s wurde ", PAC.COLOR.ORANGE:Colorize("gelöscht"), "!"}),
    SI_PA_CHAT_BANKING_RULES_ENABLED = table.concat({"Regel für %s wurde ", PAC.COLOR.ORANGE:Colorize("aktiviert"), "!"}),
    SI_PA_CHAT_BANKING_RULES_DISABLED = table.concat({"Regel für %s wurde ", PAC.COLOR.ORANGE:Colorize("deaktiviert"), "!"}),

    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking Advanced Rules --
--    SI_PA_CHAT_BANKING_ADVANCED_RULES_ADDED = table.concat({"Rule #%d has been ", PAC.COLOR.ORANGE:Colorize("added"), "!"}),
--    SI_PA_CHAT_BANKING_ADVANCED_RULES_UPDATED = table.concat({"Rule #%d has been ", PAC.COLOR.ORANGE:Colorize("updated"), "!"}),
--    SI_PA_CHAT_BANKING_ADVANCED_RULES_DELETED = table.concat({"Rule #%d has been ", PAC.COLOR.ORANGE:Colorize("deleted"), "!"}),
--    SI_PA_CHAT_BANKING_ADVANCED_RULES_ENABLED = table.concat({"Rule #%d has been ", PAC.COLOR.ORANGE:Colorize("enabled"), "!"}),
--    SI_PA_CHAT_BANKING_ADVANCED_RULES_DISABLED = table.concat({"Rule #%d has been ", PAC.COLOR.ORANGE:Colorize("disabled"), "!"}),
--    SI_PA_CHAT_BANKING_ADVANCED_RULES_MOVED_UP = table.concat({"Rule #%d has been ", PAC.COLOR.ORANGE:Colorize("moved up"), " and is now Rule #%d!"}),
--    SI_PA_CHAT_BANKING_ADVANCED_RULES_MOVED_DOWN = table.concat({"Rule #%d has been ", PAC.COLOR.ORANGE:Colorize("moved down"), " and is now Rule #%d!"}),
}

for key, value in pairs(PABStrings) do
    SafeAddString(_G[key], value, 1)
end
