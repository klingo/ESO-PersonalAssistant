local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PABanking Menu --
--SafeAddString(SI_PA_MENU_BANKING_DESCRIPTION, "tbd", 1)

SafeAddString(SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP, "Minimal im Inventar behalten", 1)
SafeAddString(SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP, "Maximal im Inventar behalten", 1)

--SafeAddString(SI_PA_MENU_BANKING_CRAFTING, "tbd", 1)
--SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ESOPLUS_DESC, "tbd", 1)

SafeAddString(SI_PA_MENU_BANKING_ADVANCED, "Spezielle", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS, "Glyphen", 1) -- TODO: figure out why this does not overwrite the English one

SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL, "Einzelne", 1)
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC, "Anderes", 1)

SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK, "Im Inventar zu behaltende Menge", 1)
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK_T, "Definiere die Menge welche (basierend auf dem mathematischen Operator) im Inventar behalten werden soll", 1)

-- Generic definitions for any type --
SafeAddString(SI_PA_MENU_BANKING_ANY_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Aktiviere Transaktionen für %s"}), 1)
SafeAddString(SI_PA_MENU_BANKING_ANY_ITEMS_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Aktiviere Transaktionen für %s Gegenstände"}), 1)
SafeAddString(SI_PA_MENU_BANKING_ANY_ITEMS_ENABLE_T, "Aktiviere automatisches Einlagern und Entnehmen für die verschiedenen %sn Gegenständen", 1)

SafeAddString(SI_PA_MENU_BANKING_ANY_DESCRIPTION, "Definiere ein individuelles Verhalten (Einlagern, Entnehmen, oder Nichts machen) für %s Gegenstände", 1)
SafeAddString(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE, "%s einlagern/entnehmen", 1)
SafeAddString(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE, "%s Gegenstände einlagern/entnehmen", 1)

SafeAddString(SI_PA_MENU_BANKING_ANY_MINTOKEEP_T, "Minimale Menge an %s die immer im Inventar behalten werden soll; wenn notwendig wird fehlendes von der Truhe entnommen", 1)
SafeAddString(SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T, "Maximale Menge an %s die immer im Inventar behalten werden soll; wenn notwendig wird alles darüber in die Truhe eingelagert", 1)

SafeAddString(SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE, "Ändere alle obigen Dropdown-Listen nach", 1)
--SafeAddString(SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_T, "tbd", 1)
SafeAddString(SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_W, "Dies kann nicht rückgängig gemacht werden; alle individuellen Einträge werden überschrieben", 1)

SafeAddString(SI_PA_MENU_BANKING_DEPOSIT_STACKING, "Regel fürs Stapeln beim Einlagern", 1)
--SafeAddString(SI_PA_MENU_BANKING_DEPOSIT_STACKING_T, "tbd", 1)
SafeAddString(SI_PA_MENU_BANKING_WITHDRAWAL_STACKING, "Regel fürs Stapeln beim Entnehmen", 1)
--SafeAddString(SI_PA_MENU_BANKING_WITHDRAWAL_STACKING_T, "tbd", 1)

SafeAddString(SI_PA_MENU_BANKING_TRANSACTION_INTERVAL, "Intervall zwischen einzelnen Transaktionen (in ms)", 1)
SafeAddString(SI_PA_MENU_BANKING_TRANSACTION_INTERVAL_T, "Die Zeit in Millisekunden zwischen zwei aufeinanderfolgenden Transaktionen von Gegenständen. Wenn zu viele Verschiebungen fehlschlagen kann versucht werden diesen Wert zu erhöhen.", 1)

SafeAddString(SI_PA_MENU_BANKING_AUTOSTACKBAGS, "Automatisch alle Gegenstände stapeln", 1)
SafeAddString(SI_PA_MENU_BANKING_AUTOSTACKBAGS_T, "Sollen automatisch alle Gegenstände im Inventar und in der Truhe gestapelt werden wenn die Truhe geöffnet wird? Ist hilfreich um alles besser organisiert zu halten", 1)


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PABanking --
SafeAddString(SI_PA_CHAT_BANKING_WITHDRAWAL_COMPLETE, table.concat({PAC.COLORED_TEXTS.PAB, "%d %s entnommen"}), 1)
SafeAddString(SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_SOURCE, table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s entnommen (Truhe ist leer)"}), 1)
SafeAddString(SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_TARGET, table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s entnommen (Nicht genug Platz im Inventar)"}), 1)

SafeAddString(SI_PA_CHAT_BANKING_DEPOSIT_COMPLETE, table.concat({PAC.COLORED_TEXTS.PAB, "%d %s eingelagert"}), 1)
SafeAddString(SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_SOURCE, table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s eingelagert (Inventar ist leer)"}), 1)
SafeAddString(SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_TARGET, table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s eingelagert (Nicht genug Platz in Truhe)"}), 1)

SafeAddString(SI_PA_CHAT_BANKING_ITEMS_MOVED_COMPLETE, table.concat({PAC.COLORED_TEXTS.PAB, "%d x %s in %s verschoben"}), 1)
SafeAddString(SI_PA_CHAT_BANKING_ITEMS_MOVED_PARTIAL, table.concat({PAC.COLORED_TEXTS.PAB, "%d/%d x %s in %s verschoben"}), 1)
SafeAddString(SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_OUTOFSPACE, table.concat({PAC.COLORED_TEXTS.PAB, "%s konnte nicht in %s verschoben werden. Nicht genügend Platz!"}), 1)
SafeAddString(SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_BANKCLOSED, table.concat({PAC.COLORED_TEXTS.PAB, "%s konnte nicht in %s verschoben werden. Fenster wurde geschlossen!"}), 1)
