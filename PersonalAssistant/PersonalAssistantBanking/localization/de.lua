local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PABanking Menu --
SafeAddString(SI_PA_MENU_BANKING_DESCRIPTION, "PABanking kann Währungen, Handwerks- und andere Gegenstände für dich zwischen deinem Inventar und der Truhe hin und her schieben", 1)

-- Currencies --
SafeAddString(SI_PA_MENU_BANKING_CURRENCY_HEADER, GetString(SI_INVENTORY_CURRENCIES), 1)
SafeAddString(SI_PA_MENU_BANKING_CURRENCY_ENABLE, table.concat({"Aktiviere Transaktionen für ", GetString(SI_INVENTORY_CURRENCIES)}), 1)
SafeAddString(SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP, "Minimal im Inventar behalten", 1)
SafeAddString(SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP, "Maximal im Inventar behalten", 1)

-- Crafting Items --
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_HEADER, "Handwerks Gegenstände", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ENABLE, "Aktiviere Transaktionen für Handwerks Gegenstände", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ENABLE_T, "Aktiviere automatisches Einlagern und Entnehmen für die verschiedenen Handwerks Gegenstände?", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_DESCRIPTION, "Definiere ein individuelles Verhalten (Einlagern, Entnehmen, oder Nichts machen) für Handwerks Gegenstände", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ESOPLUS_DESC, "Als ESO Plus-Mitglied ist das Einlagern/Entnehmen von Handwerksmaterialien nicht relevant da alle davon in unbeschränkter Menge im Handwerksbeutel verstaut werden können.", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE, "Ändere alle obigen Dropdown-Listen nach", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE_T, "Ändere alle obigen Handwerks Dropdown-Listen nach 'In Truhe einlagern', 'Ins Inventar entnehmen', oder 'Nichts machen'", 1)

-- Advanced Items --
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_HEADER, "Spezielle Gegenstände", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_ENABLE, "Aktiviere Transaktionen für Spezielle Gegenstände", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_ENABLE_T, "Aktiviere automatisches Einlagern und Entnehmen für die verschiedenen Speziellen Gegenständen?", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_DESCRIPTION, "Definiere ein individuelles Verhalten (Einlagern, Entnehmen, oder Nichts machen) für spezielle Gegenstände", 1)

SafeAddString(SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE, "Ändere alle obigen Dropdown-Listen nach", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE_T, "Ändere alle obigen Speziellen Dropdown-Listen nach 'In Truhe einlagern', 'Ins Inventar entnehmen', oder 'Nichts machen'", 1)

SafeAddString(SI_PA_MENU_BANKING_ADVANCED_KNOWN_ITEMTYPE8, table.concat({PAC.ICONS.OTHERS.KNOWN.NORMAL, " Bekannte Stile"}), 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_KNOWN_ITEMTYPE29, table.concat({PAC.ICONS.OTHERS.KNOWN.NORMAL, " Bekannte Rezepte"}), 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_UNKNOWN_ITEMTYPE8, table.concat({PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " Unbekannte Stile"}), 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_UNKNOWN_ITEMTYPE29, table.concat({PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " Unbekannte Rezepte"}), 1)

-- Individual Items --
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_HEADER, "Einzelne Gegenstände", 1)
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_DISABLED_DESCRIPTION, table.concat({"Mit der Einführung der benutzerdefinierten Banking Regeln wurden die \"Individuellen\" Einstellungen dorthin migriert. ", GetString(SI_PA_MENU_RULES_HOW_TO_ADD_PAB), "\n\n", GetString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU)}), 1)

-- AvA Items --
SafeAddString(SI_PA_MENU_BANKING_AVA_HEADER, "AvA Gegenstände", 1)
SafeAddString(SI_PA_MENU_BANKING_AVA_ENABLE, "Aktiviere Transaktionen für AvA Gegenstände", 1)
SafeAddString(SI_PA_MENU_BANKING_AVA_ENABLE_T, "Aktiviere automatisches Einlagern und Entnehmen für die verschiedenen Allianz versus Alliance (AvA) Gegenständen?", 1)
SafeAddString(SI_PA_MENU_BANKING_AVA_DESCRIPTION, "Definiere die Menge der Allianz versus Alliance (AvA) Gegenstände die im Inventar behalten werden sollen", 1)
SafeAddString(SI_PA_MENU_BANKING_AVA_OTHER_HEADER, "Anderes", 1)

-- Other Settings --
SafeAddString(SI_PA_MENU_BANKING_OTHER_DEPOSIT_STACKING, "Regel fürs Stapeln beim Einlagern", 1)
SafeAddString(SI_PA_MENU_BANKING_OTHER_DEPOSIT_STACKING_T, "Definiere ob alle Gegenstände in die Truhe eingelagert werden sollen, oder nur wenn bereits Stapel bestehen die aufgefüllt werden können", 1)
SafeAddString(SI_PA_MENU_BANKING_OTHER_WITHDRAWAL_STACKING, "Regel fürs Stapeln beim Entnehmen", 1)
SafeAddString(SI_PA_MENU_BANKING_OTHER_WITHDRAWAL_STACKING_T, "Definiere ob alle Gegenstände ins Inventar entnommen werden sollen, oder nur wenn bereits Stapel bestehen die aufgefüllt werden können", 1)

SafeAddString(SI_PA_MENU_BANKING_EXCLUDE_JUNK, "Verschiebe keine als Trödel markierte Gegenstände", 1)

SafeAddString(SI_PA_MENU_BANKING_OTHER_AUTOSTACKBAGS, "Automatisch alle Gegenstände stapeln", 1)
SafeAddString(SI_PA_MENU_BANKING_OTHER_AUTOSTACKBAGS_T, "Sollen automatisch alle Gegenstände im Inventar und in der Truhe gestapelt werden wenn die Truhe geöffnet wird? Ist hilfreich um alles besser organisiert zu halten", 1)

-- Generic definitions for any type --
SafeAddString(SI_PA_MENU_BANKING_ANY_CURRENCY_ENABLE, "%s einlagern/entnehmen", 1)

SafeAddString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK, "Zu behaltende Menge", 1)
SafeAddString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK_T, "Definiere die Menge welche (basierend auf dem mathematischen Operator) im Inventar oder der Bank behalten werden soll", 1)

SafeAddString(SI_PA_MENU_BANKING_ANY_MINTOKEEP_T, "Minimale Menge an %s die immer im Inventar behalten werden soll; wenn notwendig wird fehlendes von der Truhe entnommen", 1)
SafeAddString(SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T, "Maximale Menge an %s die immer im Inventar behalten werden soll; wenn notwendig wird alles darüber in die Truhe eingelagert", 1)

SafeAddString(SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_W, "Dies kann nicht rückgängig gemacht werden; alle individuellen Einträge werden überschrieben", 1)


-- =================================================================================================================
-- == MAIN MENU TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PABanking --
SafeAddString(SI_PA_MAINMENU_BANKING_HEADER, "Banking Regeln", 1)

SafeAddString(SI_PA_MAINMENU_BANKING_HEADER_BAG, "Ort", 1)
SafeAddString(SI_PA_MAINMENU_BANKING_HEADER_OPERATOR, "Operator", 1)
SafeAddString(SI_PA_MAINMENU_BANKING_HEADER_AMOUNT, "Anzahl", 1)
SafeAddString(SI_PA_MAINMENU_BANKING_HEADER_ITEM, "Gegenstand", 1)
SafeAddString(SI_PA_MAINMENU_BANKING_HEADER_ACTIONS, "Aktionen", 1)


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PABanking --
SafeAddString(SI_PA_CHAT_BANKING_WITHDRAWAL_COMPLETE, "%s entnommen", 1)
SafeAddString(SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_SOURCE, "%s / %s entnommen (Truhe ist leer)", 1)
SafeAddString(SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_TARGET, "%s / %s entnommen (Nicht genug Platz im Inventar)", 1)

SafeAddString(SI_PA_CHAT_BANKING_DEPOSIT_COMPLETE, "%s eingelagert", 1)
SafeAddString(SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_SOURCE, "%s / %s eingelagert (Inventar ist leer)", 1)
SafeAddString(SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_TARGET, "%s / %s eingelagert (Nicht genug Platz in Truhe)", 1)

SafeAddString(SI_PA_CHAT_BANKING_ITEMS_MOVED_COMPLETE, "%d x %s in %s verschoben", 1)
SafeAddString(SI_PA_CHAT_BANKING_ITEMS_MOVED_PARTIAL, "%d/%d x %s in %s verschoben", 1)
SafeAddString(SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_OUTOFSPACE, "%s konnte nicht in %s verschoben werden. Nicht genügend Platz!", 1)
SafeAddString(SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_BANKCLOSED, "%s konnte nicht in %s verschoben werden. Fenster wurde geschlossen!", 1)
SafeAddString(SI_PA_CHAT_BANKING_ITEMS_SKIPPED_LWC, "Manche Gegenstände wurden NICHT eingelagert um potentielle Überlagerungen mit Dolgubon's Lazy Writ Crafter zu vermeiden", 1)

SafeAddString(SI_PA_CHAT_BANKING_RULES_ADDED, table.concat({"Regel für %s wurde ", PAC.COLOR.ORANGE:Colorize("hinzugefügt"), "!"}), 1)
SafeAddString(SI_PA_CHAT_BANKING_RULES_UPDATED, table.concat({"Regel für %s wurde ", PAC.COLOR.ORANGE:Colorize("angepasst"), "!"}), 1)
SafeAddString(SI_PA_CHAT_BANKING_RULES_DELETED, table.concat({"Regel für %s wurde ", PAC.COLOR.ORANGE:Colorize("gelöscht"), "!"}), 1)