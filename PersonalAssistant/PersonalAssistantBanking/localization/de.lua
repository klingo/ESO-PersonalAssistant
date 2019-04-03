local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PABanking Menu --
SafeAddString(SI_PA_MENU_BANKING_DESCRIPTION, "PABanking kann Währungen, Handwerks- und andere Gegenstände für dich zwischen deinem Inventar und der Truhe hin und her schieben", 1)

SafeAddString(SI_PA_MENU_BANKING_CURRENCY_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Aktiviere Transaktionen für ", GetString(SI_INVENTORY_CURRENCIES)}), 1)
SafeAddString(SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP, "Minimal im Inventar behalten", 1)
SafeAddString(SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP, "Maximal im Inventar behalten", 1)

SafeAddString(SI_PA_MENU_BANKING_CRAFTING, "Handwerks", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Aktiviere Transaktionen für Handwerks Gegenstände"}), 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ENABLE_T, "Aktiviere automatisches Einlagern und Entnehmen für die verschiedenen Handwerks Gegenstände", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_DESCRIPTION, "Definiere ein individuelles Verhalten (Einlagern, Entnehmen, oder Nichts machen) für Handwerks Gegenstände", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ESOPLUS_DESC, table.concat({PAC.COLORS.LIGHT_BLUE, "Als ESO Plus-Mitglied ist das Einlagern/Entnehmen von Handwerksmaterialien nicht relevant da alle davon in unbeschränkter Menge im Handwerksbeutel verstaut werden können."}), 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE, "Ändere alle obigen Dropdown-Listen nach", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE_T, "Ändere alle obigen Handwerks Dropdown-Listen nach 'In Truhe einlagern', 'Ins Inventar entnehmen', oder 'Nichts machen'", 1)

SafeAddString(SI_PA_MENU_BANKING_CRAFTING_BLACKSMITHING_ITEMS_ENABLE, table.concat({GetString(SI_PA_MENU_BANKING_CRAFTING_BLACKSMITHING), " Gegenstände einlagern/entnehmen"}), 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_CLOTHING_ITEMS_ENABLE, table.concat({GetString(SI_PA_MENU_BANKING_CRAFTING_CLOTHING), " Gegenstände einlagern/entnehmen"}), 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_WOODWORKING_ITEMS_ENABLE, table.concat({GetString(SI_PA_MENU_BANKING_CRAFTING_WOODWORKING), " Gegenstände einlagern/entnehmen"}), 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_JEWELCRAFTING_ITEMS_ENABLE, table.concat({GetString(SI_PA_MENU_BANKING_CRAFTING_JEWELCRAFTING), " Gegenstände einlagern/entnehmen"}), 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ALCHEMY_ITEMS_ENABLE, table.concat({GetString(SI_PA_MENU_BANKING_CRAFTING_ALCHEMY), " Gegenstände einlagern/entnehmen"}), 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ENCHANTING_ITEMS_ENABLE, table.concat({GetString(SI_PA_MENU_BANKING_CRAFTING_ENCHANTING), " Gegenstände einlagern/entnehmen"}), 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_PROVISIONING_ITEMS_ENABLE, table.concat({GetString(SI_PA_MENU_BANKING_CRAFTING_PROVISIONING), " Gegenstände einlagern/entnehmen"}), 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_STYLEMATERIALS_ITEMS_ENABLE, table.concat({GetString(SI_PA_MENU_BANKING_CRAFTING_STYLEMATERIALS), " Gegenstände einlagern/entnehmen"}), 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_TRAITITEMS_ITEMS_ENABLE, table.concat({GetString(SI_PA_MENU_BANKING_CRAFTING_TRAITITEMS), " Gegenstände einlagern/entnehmen"}), 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_FURNISHING_ITEMS_ENABLE, table.concat({GetString(SI_PA_MENU_BANKING_CRAFTING_FURNISHING), " Gegenstände einlagern/entnehmen"}), 1)

SafeAddString(SI_PA_MENU_BANKING_ADVANCED, "Spezielle", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Aktiviere Transaktionen für Spezielle Gegenstände"}), 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_ENABLE_T, "Aktiviere automatisches Einlagern und Entnehmen für die verschiedenen Speziellen Gegenständen", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_DESCRIPTION, "Definiere ein individuelles Verhalten (Einlagern, Entnehmen, oder Nichts machen) für spezielle Gegenstände", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS, "Glyphen", 1) -- TODO: to be checked why this is not replacing the English text
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE, "Ändere alle obigen Dropdown-Listen nach", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE_T, "Ändere alle obigen Speziellen Dropdown-Listen nach 'In Truhe einlagern', 'Ins Inventar entnehmen', oder 'Nichts machen'", 1)

SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL, "Einzelne", 1)
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Aktiviere Transaktionen für Einzelne Gegenstände"}), 1)
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_ENABLE_T, "Aktiviere automatisches Einlagern und Entnehmen für die verschiedenen Einzelnen Gegenständen", 1)
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_DESCRIPTION, "Definiere ein individuelles Verhalten (Einlagern, Entnehmen, oder Nichts machen) für einzelne Gegenstände", 1)
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC, "Anderes", 1)

SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK, "Im Inventar zu behaltende Menge", 1)
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK_T, "Definiere die Menge welche (basierend auf dem mathematischen Operator) im Inventar behalten werden soll", 1)

-- Generic definitions for any type --
SafeAddString(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE, "%s einlagern/entnehmen", 1)

SafeAddString(SI_PA_MENU_BANKING_ANY_MINTOKEEP_T, "Minimale Menge an %s die immer im Inventar behalten werden soll; wenn notwendig wird fehlendes von der Truhe entnommen", 1)
SafeAddString(SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T, "Maximale Menge an %s die immer im Inventar behalten werden soll; wenn notwendig wird alles darüber in die Truhe eingelagert", 1)

SafeAddString(SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_W, "Dies kann nicht rückgängig gemacht werden; alle individuellen Einträge werden überschrieben", 1)

SafeAddString(SI_PA_MENU_BANKING_DEPOSIT_STACKING, "Regel fürs Stapeln beim Einlagern", 1)
SafeAddString(SI_PA_MENU_BANKING_DEPOSIT_STACKING_T, "Definiere ob alle Gegenstände in die Truhe eingelagert werden sollen, oder nur wenn bereits Stapel bestehen die aufgefüllt werden können", 1)
SafeAddString(SI_PA_MENU_BANKING_WITHDRAWAL_STACKING, "Regel fürs Stapeln beim Entnehmen", 1)
SafeAddString(SI_PA_MENU_BANKING_WITHDRAWAL_STACKING_T, "Definiere ob alle Gegenstände ins Inventar entnommen werden sollen, oder nur wenn bereits Stapel bestehen die aufgefüllt werden können", 1)

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
