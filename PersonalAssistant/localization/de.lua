local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- Welcome Messages --
SafeAddString(SI_PA_WELCOME_NO_SUPPORT, table.concat({PAC.COLORS.DEFAULT, "zu deinen Diensten!   -   für deine Sprache [%s] ist leider (noch) keine Lokalisierung verfügbar"}), 1)
SafeAddString(SI_PA_WELCOME_SUPPORT, table.concat({PAC.COLORS.DEFAULT, "zu deinen Diensten! Aktives Profil: ", PAC.COLOR.ORANGE_RED:Colorize("%s")}), 1)
SafeAddString(SI_PA_WELCOME_PLEASE_SELECT_PROFILE, table.concat({PAC.COLORS.DEFAULT, "heisst dich willkommen! Um loslegen zu können, gehe bitte zu den Einstellungen der Erweiterung (oder verwende ",PAC.COLORS.WHITE,"/pa", PAC.COLORS.DEFAULT, ") und wählen ein Profil aus. Vielen Dank :-)"}), 1)

SafeAddString(SI_PA_LAM_OUTDATED, table.concat({PAC.COLORS.ORANGE_RED, "benötigt eine aktuellere Version von '", PAC.COLORS.WHITE, "LibAddonMenu-2.0", PAC.COLORS.ORANGE_RED, "' als derzeit installiert ist. Bitte die neuste Version von ", PAC.COLORS.WHITE, "http://esoui.com", PAC.COLORS.ORANGE_RED, " herunterladen und diese verwenden"}), 1)


-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
SafeAddString(SI_PA_MENU_GENERAL_DESCRIPTION, "PersonalAssistant ist eine Sammlung diverser Funktionalitäten mit dem Ziel um deine Zeit in ESO noch angenehmenr zu machen", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- General Settings --
SafeAddString(SI_PA_MENU_GENERAL_HEADER, "Generelle Einstellungen", 1)
SafeAddString(SI_PA_MENU_GENERAL_SHOW_WELCOME, "Wilkommensmeldung anzeigen", 1)
SafeAddString(SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE, table.concat({PAC.ICONS.OTHERS.HOME.NORMAL, " Zum Haus reisen"}), 1)
SafeAddString(SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE_W, "Wenn das aktuelle Gebiet das Reisen zulässt, wird damit die Transportation zu deinem primären Haus ausgelöst!", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Profile Settings --
SafeAddString(SI_PA_MENU_PROFILE_HEADER, "Profile", 1)
SafeAddString(SI_PA_MENU_PROFILE_PLEASE_SELECT, "<Bitte Profil wählen>", 1)
SafeAddString(SI_PA_MENU_PROFILE_DEFAULT, "Standard Profil", 1)
SafeAddString(SI_PA_MENU_PROFILE_ACTIVE, "Aktives Profil", 1)
SafeAddString(SI_PA_MENU_PROFILE_ACTIVE_T, "Das aktive Profil für PersonalAssistant auswählen. Es werden automatisch alle Einstellungen von diesem Profil geladen und am gleichen Ort auch wieder abgespeichert.", 1)
SafeAddString(SI_PA_MENU_PROFILE_ACTIVE_RENAME, "Aktives Profil umbenennen", 1)

-- Create Profiles --
SafeAddString(SI_PA_MENU_PROFILE_CREATE_NEW, "Neues Profil erstellen", 1)
SafeAddString(SI_PA_MENU_PROFILE_CREATE_NEW_DESC, table.concat({"Anmerkung: Du kannst maximal ", PAC.GENERAL.MAX_PROFILES, " Profile haben."}), 1)

-- Copy Profiles --
SafeAddString(SI_PA_MENU_PROFILE_COPY_FROM_DESC, "Kopiere die Einstellungen von einem bestehenden Profil in das derzeit aktive Profil.", 1)
SafeAddString(SI_PA_MENU_PROFILE_COPY_FROM, "Profil kopieren", 1)
SafeAddString(SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM, "Kopieren bestätigen", 1)
SafeAddString(SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM_W, "Das wird die Einstellungen vom aktiven Profil mit den Einstellungen vom ausgewählten Profil ersetzen. Bist du dir sicher? \n\nAnmerkung: Nur Einstellungen von aktivierten PersonalAssistant Modulen werden kopiert", 1)

-- Delete Profiles --
SafeAddString(SI_PA_MENU_PROFILE_DELETE_DESC, "Lösche bestehende und nicht mehr benötigte Profile von der Datenbank um Platz zu sparen und die SavedVariables Datei aufzuräumen.", 1)
SafeAddString(SI_PA_MENU_PROFILE_DELETE, "Profil löschen", 1)
SafeAddString(SI_PA_MENU_PROFILE_DELETE_CONFIRM, "Löschen bestätigen", 1)
SafeAddString(SI_PA_MENU_PROFILE_DELETE_CONFIRM_W, "Das wird das ausgewählte Profil für alle Charaktere löschen. Bist du dir sicher?", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Admin Settings --
SafeAddString(SI_PA_MENU_ADMIN_HEADER, "Admin Einstellungen", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Rules Menu --
SafeAddString(SI_PA_MENU_RULES_HOW_TO_ADD_PAB, "Um eine neue Regel für das Einlagern und Entnehmen zu erstellen, einfach per Rechtsklick auf einem Gegenstand im Inventar oder der Bank im Kontextmenü folgendes auswählen:\n> PA Banking > Neue Regel hinzufügen", 1)
SafeAddString(SI_PA_MENU_RULES_HOW_TO_ADD_PAJ, "Um eine neue Regel für permanenten Trödel zu erstellen, einfach per Rechtsklick auf einem Gegenstand im Inventar oder der Bank im Kontextmenü folgendes auswählen:\n> PA Junk > Als permanenten Trödel markieren", 1)
SafeAddString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU, table.concat({"Alle aktiven Regeln können entweder via dem Icon im oberen Hauptmenü (das mit der [Alt] Taste geöffnet wird) gefunden werden, mit ", PAC.COLOR.YELLOW:Colorize("/parules"), " oder anhand dieses Buttons:"}), 1)
SafeAddString(SI_PA_MENU_RULES_HOW_TO_CREATE, "Wie neue Regeln erstellen?", 1)

SafeAddString(SI_PA_MENU_DANGEROUS_SETTING, "ACHTUNG: Riskante Einstellung! Verwendung auf eigenes Risiko!", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Generic Menu --
SafeAddString(SI_PA_MENU_OTHER_SETTINGS_HEADER, "Weitere Einstellungen", 1)

SafeAddString(SI_PA_MENU_SILENT_MODE, "Ruhemodus (Deaktiviert ALLE Meldungen)", 1)

SafeAddString(SI_PA_MENU_NOT_YET_IMPLEMENTED, table.concat({PAC.COLORS.RED, "Noch nicht implementiert!"}), 1)


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAGeneral --
SafeAddString(SI_PA_CHAT_GENERAL_NEW_PROFILE_CREATED, table.concat({" neues Profil ", PAC.COLOR.WHITE:Colorize("%s"), " erstellt und aktiviert!"}), 1)
SafeAddString(SI_PA_CHAT_GENERAL_SELECTED_PROFILE_COPIED, table.concat({" Einstellungen von Profil ", PAC.COLOR.WHITE:Colorize("%s"), " wurden in das aktive Profil ", PAC.COLOR.WHITE:Colorize("%s"), PAC.COLOR.ORANGE_RED:Colorize(" kopiert")}), 1)
SafeAddString(SI_PA_CHAT_GENERAL_SELECTED_PROFILE_DELETED, table.concat({" ausgewähltes Profil ", PAC.COLOR.WHITE:Colorize("%s"), " wurde ", PAC.COLOR.ORANGE_RED:Colorize("gelöscht!")}), 1)


-- =================================================================================================================
-- == OTHER STRINGS FOR MENU == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAGeneral --
SafeAddString(SI_PA_PROFILE, "Profil", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Name Spaces --
--SafeAddString(SI_PA_NS_BAG_EQUIPMENT, "tbd", 1)
SafeAddString(SI_PA_NS_BAG_BACKPACK, "Inventar", 1)
SafeAddString(SI_PA_NS_BAG_BANK, "Bank", 1)
SafeAddString(SI_PA_NS_BAG_SUBSCRIBER_BANK, "ESO Plus Bank", 1)
SafeAddString(SI_PA_NS_BAG_UNKNOWN, "Unbekannt", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- ItemTypes (Custom Singluar/Plural definition) --
SafeAddString(SI_PA_ITEMTYPE4, "<<1[Gericht/Gerichte]>>", 1)
SafeAddString(SI_PA_ITEMTYPE5, "<<1[Trophäe/Trophäen]>>", 1)
SafeAddString(SI_PA_ITEMTYPE7, "<<1[Trank/Tränke]>>", 1)
SafeAddString(SI_PA_ITEMTYPE8, "<<1[Stil/Stile]>>", 1)
SafeAddString(SI_PA_ITEMTYPE10, "<<1[Zutat/Zutaten]>>", 1)
SafeAddString(SI_PA_ITEMTYPE12, "<<1[Getränk/Getränke]>>", 1)
SafeAddString(SI_PA_ITEMTYPE16, "<<1[Köder/Köder]>>", 1)
SafeAddString(SI_PA_ITEMTYPE19, "<<1[Seelenstein/Seelensteine]>>", 1)
SafeAddString(SI_PA_ITEMTYPE22, "<<1[Dietrich/Dietriche]>>", 1)
SafeAddString(SI_PA_ITEMTYPE29, "<<1[Rezept/Rezepte]>>", 1)
SafeAddString(SI_PA_ITEMTYPE30, "<<1[Gift/Gifte]>>", 1)
SafeAddString(SI_PA_ITEMTYPE34, "<<1[Sammlung/Sammlungen]>>", 1)
SafeAddString(SI_PA_ITEMTYPE56, "<<1[Beute/Beuten]>>", 1)
SafeAddString(SI_PA_ITEMTYPE60, "<<1[Meisterschrieb/Meisterschriebe]>>", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Master Writs based on CraftingType (Custom definition) --
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE0, table.concat({"Andere Schriebe (", GetString("SI_ENCHANTMENTSEARCHCATEGORYTYPE", ENCHANTMENT_SEARCH_CATEGORY_OTHER), ")"}), 1)
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE1, "Versiegelter Schmiedeschrieb", 1)
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE2, "Versiegelter Schneiderschrieb", 1)
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE3, "Versiegelter Verzauberungsschrieb", 1)
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE4, "Versiegelter Alchemieschrieb", 1)
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE5, "Versiegelter Versorgerschrieb", 1)
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE6, "Versiegelter Schreinerschrieb", 1)
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE7, "Versiegelter Schmuckhandwerksschrieb", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- PABanking --
SafeAddString(SI_PA_BANKING_MOVE_MODE_DONOTHING, "Nichts machen", 1)
SafeAddString(SI_PA_BANKING_MOVE_MODE_TOBANK, "In Truhe einlagern", 1)
SafeAddString(SI_PA_BANKING_MOVE_MODE_TOBACKPACK, "Ins Inventar entnehmen", 1)

SafeAddString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS, "Glyphen", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_INTRICATE_ITEMS, "Intrikate Gegenstände", 1)

SafeAddString(SI_PA_MENU_BANKING_REPAIRKIT, "Reparaturmaterialien", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Operators --
SafeAddString(SI_PA_REL_OPERATOR_T, "Wähle den mathematischen Operator für diesen Gegenstand", 1)
SafeAddString(SI_PA_REL_BACKPACK_EQUAL, "INVENTAR ==", 1)
SafeAddString(SI_PA_REL_BACKPACK_LESSTHAN, "INVENTAR >", 1) -- not used so far
SafeAddString(SI_PA_REL_BACKPACK_LESSTHANEQUAL, "INVENTAR <=", 1)
SafeAddString(SI_PA_REL_BACKPACK_GREATERTHAN, "INVENTAR >)", 1) -- not used so far
SafeAddString(SI_PA_REL_BACKPACK_GREATERTHANEQUAL, "INVENTAR >=", 1)
SafeAddString(SI_PA_REL_BANK_EQUAL, "BANK ==", 1)
SafeAddString(SI_PA_REL_BANK_LESSTHAN, "BANK <", 1) -- not used so far
SafeAddString(SI_PA_REL_BANK_LESSTHANOREQUAL, "BANK <=", 1)
SafeAddString(SI_PA_REL_BANK_GREATERTHAN, "BANK >", 1) -- not used so far
SafeAddString(SI_PA_REL_BANK_GREATERTHANOREQUAL, "BANK >=", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Operator Tooltip --
SafeAddString(SI_PA_REL_BACKPACK_EQUAL_T, "INVENTAR gleich (=)", 1)
SafeAddString(SI_PA_REL_BACKPACK_LESSTHAN_T, "INVENTAR kleiner als (<)", 1) -- not used so far
SafeAddString(SI_PA_REL_BACKPACK_LESSTHANOREQUAL_T, "INVENTAR kleiner oder gleich als (<=)", 1)
SafeAddString(SI_PA_REL_BACKPACK_GREATERTHAN_T, "INVENTAR grösser als (>)", 1) -- not used so far
SafeAddString(SI_PA_REL_BACKPACK_GREATERTHANOREQUAL_T, "INVENTAR grösser oder gleich als (>=)", 1)
SafeAddString(SI_PA_REL_BANK_EQUAL_T, "BANK gleich (=)", 1)
SafeAddString(SI_PA_REL_BANK_LESSTHAN_T, "BANK kleiner als (<)", 1) -- not used so far
SafeAddString(SI_PA_REL_BANK_LESSTHANOREQUAL_T, "BANK kleiner oder gleich als (<=)", 1)
SafeAddString(SI_PA_REL_BANK_GREATERTHAN_T, "BANK grösser als (>)", 1) -- not used so far
SafeAddString(SI_PA_REL_BANK_GREATERTHANOREQUAL_T, "BANK grösser oder gleich als (>=)", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Text Operators --
SafeAddString(SI_PA_REL_TEXT_OPERATOR0, "-", 1)
SafeAddString(SI_PA_REL_TEXT_OPERATOR1, "hat genau", 1)
SafeAddString(SI_PA_REL_TEXT_OPERATOR2, "hat weniger als", 1) -- not used so far
SafeAddString(SI_PA_REL_TEXT_OPERATOR3, "hat höchstens", 1)
SafeAddString(SI_PA_REL_TEXT_OPERATOR4, "hat mehr als", 1) -- not used so far
SafeAddString(SI_PA_REL_TEXT_OPERATOR5, "hat mindestens", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Stacking types --
SafeAddString(SI_PA_ST_MOVE_FULL, "Verschiebe alles", 1)
SafeAddString(SI_PA_ST_MOVE_INCOMPLETE_STACKS_ONLY, "Nur Stapel auffüllen", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Icon Positions --
SafeAddString(SI_PA_POSITION_AUTO, "Automatisch", 1)
SafeAddString(SI_PA_POSITION_MANUAL, "Manuell", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk --
SafeAddString(SI_PA_ITEM_ACTION_NOTHING, "Nichts machen", 1)
SafeAddString(SI_PA_ITEM_ACTION_LAUNDER, "Beim Hehler schieben", 1)
SafeAddString(SI_PA_ITEM_ACTION_MARK_AS_JUNK, "Als Trödel markieren", 1)
SafeAddString(SI_PA_ITEM_ACTION_JUNK_DESTROY_WORTHLESS, "Trödel oder zerstören wenn wertlos", 1)
SafeAddString(SI_PA_ITEM_ACTION_DESTROY_ALWAYS, "Immer zerstören", 1)


-- =================================================================================================================
-- == CUSTOM SUB MENU == --
-- -----------------------------------------------------------------------------------------------------------------
SafeAddString(SI_PA_SUBMENU_PAB_ADD_RULE, "Neue Regel hinzufügen", 1)
SafeAddString(SI_PA_SUBMENU_PAB_EDIT_RULE, "Regel bearbeiten", 1)
SafeAddString(SI_PA_SUBMENU_PAB_DELETE_RULE, "Regel löschen", 1)
SafeAddString(SI_PA_SUBMENU_PAB_ENABLE_RULE, "Regel aktivieren", 1)
SafeAddString(SI_PA_SUBMENU_PAB_DISABLE_RULE, "Regel deaktivieren", 1)
SafeAddString(SI_PA_SUBMENU_PAB_ADD_RULE_BUTTON, "Hinzufügen", 1)
SafeAddString(SI_PA_SUBMENU_PAB_UPDATE_RULE_BUTTON, "Speichern", 1)
SafeAddString(SI_PA_SUBMENU_PAB_DELETE_RULE_BUTTON, "Löschen", 1)
SafeAddString(SI_PA_SUBMENU_PAB_NO_RULES, "Noch keine Banking Regeln definiert", 1)
SafeAddString(SI_PA_SUBMENU_PAB_DISCLAIMER, "Anmerkung: Diese benutzerdefinierten Regeln werden erst berücksichtigt, wenn alle anderen automatischen Banking Regeln (Handwerks, Spezielle, und AvA Gegenstände) ausgeführt wurden.", 1)

SafeAddString(SI_PA_SUBMENU_PAJ_MARK_PERM_JUNK, "Als permanenten Trödel markieren", 1)
SafeAddString(SI_PA_SUBMENU_PAJ_UNMARK_PERM_JUNK, "Als permanenten Trödel demarkieren", 1)
SafeAddString(SI_PA_SUBMENU_PAJ_NO_RULES, "Noch keine Regeln für Trödel definiert", 1)


-- =================================================================================================================
-- == KEY BINDINGS == --
-- -----------------------------------------------------------------------------------------------------------------
SafeAddString(SI_KEYBINDINGS_CATEGORY_PA_PROFILES, "|cFFD700P|rersonal|cFFD700A|rssistant Profile", 1)
SafeAddString(SI_KEYBINDINGS_CATEGORY_PA_MENU, "|cFFD700P|rersonal|cFFD700A|rssistant Menu", 1)

SafeAddString(SI_BINDING_NAME_PA_RULES_MAIN_MENU, "PersonalAssistant Regeln", 1)
SafeAddString(SI_BINDING_NAME_PA_RULES_TOGGLE_WINDOW, "Banking/Trödel Regelmenü ein-/ausblenden", 1)

