local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PABanking Menu --
SafeAddString(SI_PA_MENU_BANKING_DESCRIPTION, "PABanking kann Währungen, Handwerks- und andere Gegenstände für dich zwischen deinem Inventar und der Truhe hin und her schieben", 1)

SafeAddString(SI_PA_MENU_BANKING_CURRENCY_HEADER, PAC.COLOR.YELLOW:Colorize(GetString(SI_INVENTORY_CURRENCIES)), 1)
SafeAddString(SI_PA_MENU_BANKING_CURRENCY_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Aktiviere Transaktionen für ", GetString(SI_INVENTORY_CURRENCIES)}), 1)
SafeAddString(SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP, "Minimal im Inventar behalten", 1)
SafeAddString(SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP, "Maximal im Inventar behalten", 1)

SafeAddString(SI_PA_MENU_BANKING_CRAFTING_HEADER, PAC.COLOR.YELLOW:Colorize("Handwerks Gegenstände"), 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Aktiviere Transaktionen für Handwerks Gegenstände"}), 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ENABLE_T, "Aktiviere automatisches Einlagern und Entnehmen für die verschiedenen Handwerks Gegenstände?", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_DESCRIPTION, "Definiere ein individuelles Verhalten (Einlagern, Entnehmen, oder Nichts machen) für Handwerks Gegenstände", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ESOPLUS_DESC, table.concat({PAC.COLORS.LIGHT_BLUE, "Als ESO Plus-Mitglied ist das Einlagern/Entnehmen von Handwerksmaterialien nicht relevant da alle davon in unbeschränkter Menge im Handwerksbeutel verstaut werden können."}), 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE, "Ändere alle obigen Dropdown-Listen nach", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE_T, "Ändere alle obigen Handwerks Dropdown-Listen nach 'In Truhe einlagern', 'Ins Inventar entnehmen', oder 'Nichts machen'", 1)

SafeAddString(SI_PA_MENU_BANKING_ADVANCED_HEADER, PAC.COLOR.YELLOW:Colorize("Spezielle Gegenstände"), 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Aktiviere Transaktionen für Spezielle Gegenstände"}), 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_ENABLE_T, "Aktiviere automatisches Einlagern und Entnehmen für die verschiedenen Speziellen Gegenständen?", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_DESCRIPTION, "Definiere ein individuelles Verhalten (Einlagern, Entnehmen, oder Nichts machen) für spezielle Gegenstände", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS, "Glyphen", 1) -- TODO: to be checked why this is not replacing the English text
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE, "Ändere alle obigen Dropdown-Listen nach", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE_T, "Ändere alle obigen Speziellen Dropdown-Listen nach 'In Truhe einlagern', 'Ins Inventar entnehmen', oder 'Nichts machen'", 1)

SafeAddString(SI_PA_MENU_BANKING_ADVANCED_KNOWN_ITEMTYPE8, table.concat({PAC.ICONS.OTHERS.KNOWN.NORMAL, " Bekannte Stile"}), 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_KNOWN_ITEMTYPE29, table.concat({PAC.ICONS.OTHERS.KNOWN.NORMAL, " Bekannte Rezepte"}), 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_UNKNOWN_ITEMTYPE8, table.concat({PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " Unbekannte Stile"}), 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_UNKNOWN_ITEMTYPE29, table.concat({PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " Unbekannte Rezepte"}), 1)

SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_HEADER, PAC.COLOR.YELLOW:Colorize("Einzelne Gegenstände"), 1)
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Aktiviere Transaktionen für Einzelne Gegenstände"}), 1)
--SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_DISABLED_DESCRIPTION, table.concat({"With the introduction of custom Banking rules, the \"Individual\" settings have been migrated to there.\nYou can find them via the icon in the top main menu that you can open with [Alt] key, with ", PAC.COLOR.YELLOW:Colorize("/parules"), " or by clicking on this button:"}), 1) -- TODO: Me

SafeAddString(SI_PA_MENU_BANKING_AVA_HEADER, PAC.COLOR.YELLOW:Colorize("AvA Gegenstände"), 1)
SafeAddString(SI_PA_MENU_BANKING_AVA_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Aktiviere Transaktionen für AvA Gegenstände"}), 1)
SafeAddString(SI_PA_MENU_BANKING_AVA_ENABLE_T, "Aktiviere automatisches Einlagern und Entnehmen für die verschiedenen Allianz versus Alliance (AvA) Gegenständen?", 1)
SafeAddString(SI_PA_MENU_BANKING_AVA_DESCRIPTION, "Definiere die Menge der Allianz versus Alliance (AvA) Gegenstände die im Inventar behalten werden sollen", 1)
SafeAddString(SI_PA_MENU_BANKING_AVA_OTHER_HEADER, "Anderes", 1)

SafeAddString(SI_PA_MENU_BANKING_OTHER_HEADER, PAC.COLOR.YELLOW:Colorize("Andere Einstellungen"), 1)
SafeAddString(SI_PA_MENU_BANKING_OTHER_LWC_COMPATIBILTY, "Kompatibilität mit Dolgubon's Lazy Writ Crafter", 1)
SafeAddString(SI_PA_MENU_BANKING_OTHER_LWC_COMPATIBILTY_T, "Wenn du aktive Schrieb Quests hast und 'Gegenstände entnehmen' in Dolgubon's Lazy Writ Crafter aktiviert ist, dann wird für diese Gegenstände  die 'In Truhe einlagern' Einstellung ignoriert. Dadurch sollen eben entnommene Gegenstände nicht wieder direkt eingelagert werden", 1)

SafeAddString(SI_PA_MENU_BANKING_OTHER_DEPOSIT_STACKING, "Regel fürs Stapeln beim Einlagern", 1)
SafeAddString(SI_PA_MENU_BANKING_OTHER_DEPOSIT_STACKING_T, "Definiere ob alle Gegenstände in die Truhe eingelagert werden sollen, oder nur wenn bereits Stapel bestehen die aufgefüllt werden können", 1)
SafeAddString(SI_PA_MENU_BANKING_OTHER_WITHDRAWAL_STACKING, "Regel fürs Stapeln beim Entnehmen", 1)
SafeAddString(SI_PA_MENU_BANKING_OTHER_WITHDRAWAL_STACKING_T, "Definiere ob alle Gegenstände ins Inventar entnommen werden sollen, oder nur wenn bereits Stapel bestehen die aufgefüllt werden können", 1)

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
--SafeAddString(SI_PA_MAINMENU_BANKING_HEADER, "Banking Rules", 1) -- TODO: Me

--SafeAddString(SI_PA_MAINMENU_BANKING_HEADER_BAG, "Location", 1) -- TODO: Me
--SafeAddString(SI_PA_MAINMENU_BANKING_HEADER_OPERATOR, "Operator", 1) -- TODO: Me
--SafeAddString(SI_PA_MAINMENU_BANKING_HEADER_AMOUNT, "Amount", 1) -- TODO: Me
--SafeAddString(SI_PA_MAINMENU_BANKING_HEADER_ITEM, "Item", 1) -- TODO: Me
--SafeAddString(SI_PA_MAINMENU_BANKING_HEADER_ACTIONS, "Actions", 1) -- TODO: Me


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PABanking --
SafeAddString(SI_PA_CHAT_BANKING_WITHDRAWAL_COMPLETE, "%d %s entnommen", 1)
SafeAddString(SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_SOURCE, "%d / %d %s entnommen (Truhe ist leer)", 1)
SafeAddString(SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_TARGET, "%d / %d %s entnommen (Nicht genug Platz im Inventar)", 1)

SafeAddString(SI_PA_CHAT_BANKING_DEPOSIT_COMPLETE, "%d %s eingelagert", 1)
SafeAddString(SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_SOURCE, "%d / %d %s eingelagert (Inventar ist leer)", 1)
SafeAddString(SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_TARGET, "%d / %d %s eingelagert (Nicht genug Platz in Truhe)", 1)

SafeAddString(SI_PA_CHAT_BANKING_ITEMS_MOVED_COMPLETE, "%d x %s in %s verschoben", 1)
SafeAddString(SI_PA_CHAT_BANKING_ITEMS_MOVED_PARTIAL, "%d/%d x %s in %s verschoben", 1)
SafeAddString(SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_OUTOFSPACE, "%s konnte nicht in %s verschoben werden. Nicht genügend Platz!", 1)
SafeAddString(SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_BANKCLOSED, "%s konnte nicht in %s verschoben werden. Fenster wurde geschlossen!", 1)
SafeAddString(SI_PA_CHAT_BANKING_ITEMS_SKIPPED_LWC, "Manche Gegenstände wurden NICHT eingelagert um potentielle Überlagerungen mit Dolgubon's Lazy Writ Crafter zu vermeiden", 1)

--SafeAddString(SI_PA_CHAT_BANKING_RULES_ADDED, table.concat({"Rule for %s has been ", PAC.COLOR.ORANGE:Colorize("added"), "!"}), 1) -- TODO: Me
--SafeAddString(SI_PA_CHAT_BANKING_RULES_UPDATED, table.concat({"Rule for %s has been ", PAC.COLOR.ORANGE:Colorize("updated"), "!"}), 1) -- TODO: Me
--SafeAddString(SI_PA_CHAT_BANKING_RULES_DELETED, table.concat({"Rule for %s has been ", PAC.COLOR.ORANGE:Colorize("deleted"), "!"}), 1) -- TODO: Me