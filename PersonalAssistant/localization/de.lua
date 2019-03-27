local PAC = PersonalAssistant.Constants

-- =================================================================================================================
-- Welcome Messages --
SafeAddString(SI_PA_WELCOME_NO_SUPPORT, table.concat({PAC.COLORED_TEXTS.PA, PAC.COLORS.DEFAULT, " zu deinen Diensten!   -   für deine Sprache [%s] ist leider (noch) keine Lokalisierung verfügbar"}), 1)
SafeAddString(SI_PA_WELCOME_SUPPORT, table.concat({PAC.COLORED_TEXTS.PA, PAC.COLORS.DEFAULT, " zu deinen Diensten!"}), 1)
SafeAddString(SI_PA_WELCOME_PLEASE_SELECT_PROFILE, table.concat({PAC.COLORED_TEXTS.PA, PAC.COLORS.DEFAULT, " heisst dich willkommen! Um loslegen zu können, gehe bitte zu den Einstellungen der Erweiterung (oder verwende ",PAC.COLORS.WHITE,"/pa", PAC.COLORS.DEFAULT, ") und wählen ein Profil aus. Vielen Dank :-)"}), 1)

-- Key Bindings
SafeAddString(SI_PA_KB_LOAD_PROFILE, "Aktiviere Profil", 1)


-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAGeneral Menu --
SafeAddString(SI_PA_MENU_GENERAL_DESCRIPTION, "PersonalAssistant ist eine Sammlung diverser Funktionalitäten mit dem Ziel um deine Zeit in ESO noch angenehmenr zu machen", 1)

SafeAddString(SI_PA_PLEASE_SELECT_PROFILE, "<Bitte Profil wählen>", 1)

SafeAddString(SI_PA_MENU_GENERAL_ACTIVE_PROFILE, "Profil aktivieren", 1)
SafeAddString(SI_PA_MENU_GENERAL_ACTIVE_PROFILE_T, "Das aktuelle Profil für PersonalAssistant auswählen. Es werden automatisch alle Einstellungen von diesem Profil geladen und am gleichen Ort auch wieder abgespeichert.", 1)
SafeAddString(SI_PA_MENU_GENERAL_ACTIVE_PROFILE_RENAME, "Aktuelles Profil umbenennen", 1)
SafeAddString(SI_PA_MENU_GENERAL_ACTIVE_PROFILE_RENAME_T, "Das aktuelles Profil umbenennen", 1)
SafeAddString(SI_PA_MENU_GENERAL_SHOW_WELCOME, "Wilkommensmeldung anzeigen", 1)
SafeAddString(SI_PA_MENU_GENERAL_SHOW_WELCOME_T, "Zeige eine Willkommensmeldung von der Erweiterung an wenn es erfolgreich geladen werden konnte?", 1)

SafeAddString(SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE, table.concat({PAC.ICONS.OTHERS.HOME.NORMAL, " Zum Haus reisen"}), 1)
SafeAddString(SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE_W, "Wenn das aktuelle Gebiet das Reisen zulässt, wird damit die Transportation zu deinem primären Haus ausgelöst!", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Generic Menu --
SafeAddString(SI_PA_MENU_SILENT_MODE, "Ruhemodus (Deaktiviert ALLE Meldungen)", 1)
SafeAddString(SI_PA_MENU_SILENT_MODE_T, "Wenn der Ruhemodus aktiviert ist, werden von dieser Erweiterung keine Meldungen mehr im Chat angezeigt", 1)

SafeAddString(SI_PA_MENU_NOT_YET_IMPLEMENTED, table.concat({PAC.COLORS.RED, "Noch nicht implementiert!"}), 1)


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
SafeAddString(SI_PA_ITEMTYPE4, "<<1[Nahrung/Nahrungen]>>", 1)
SafeAddString(SI_PA_ITEMTYPE5, "<<1[Trophäe/Trophäen]>>", 1)
SafeAddString(SI_PA_ITEMTYPE7, "<<1[Trank/Tränke]>>", 1)
--SafeAddString(SI_PA_ITEMTYPE8, "<<1[tbd/tbd]>>", 1)
SafeAddString(SI_PA_ITEMTYPE12, "<<1[Getränk/Getränke]>>", 1)
SafeAddString(SI_PA_ITEMTYPE19, "<<1[Seelenstein/Seelensteine]>>", 1)
SafeAddString(SI_PA_ITEMTYPE22, "<<1[Dietrich/Dietriche]>>", 1)
SafeAddString(SI_PA_ITEMTYPE29, "<<1[Rezept/Rezepte]>>", 1)
SafeAddString(SI_PA_ITEMTYPE30, "<<1[Gift/Gifte]>>", 1)
SafeAddString(SI_PA_ITEMTYPE34, "<<1[Sammlung/Sammlungen]>>", 1)
--SafeAddString(SI_PA_ITEMTYPE60, "<<1[tbd/tbd]>>", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- PABanking --
SafeAddString(SI_PA_BANKING_MOVE_MODE_DONOTHING, "Nichts machen", 1)
SafeAddString(SI_PA_BANKING_MOVE_MODE_TOBANK, "In Bank deponieren", 1)
SafeAddString(SI_PA_BANKING_MOVE_MODE_TOBACKPACK, "Nach Inventar abheben", 1)

SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT, "Reparaturmaterialien", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Operators --
SafeAddString(SI_PA_REL_OPERATOR_T, "Wähle den mathematischen Operator für diesen Gegenstand", 1)
SafeAddString(SI_PA_REL_EQUAL, "gleich (=)", 1)
SafeAddString(SI_PA_REL_LESSTHAN, "kleiner als (<)", 1)
SafeAddString(SI_PA_REL_LESSTHANEQUAL, "kleiner/gleich als (<=)", 1)
SafeAddString(SI_PA_REL_GREATERTHAN, "grösser als (>)", 1)
SafeAddString(SI_PA_REL_GREATERTHANEQUAL, "grösser/gleich als (>=)", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Stacking types --
SafeAddString(SI_PA_ST_MOVE_FULL, "Verschiebe alles", 1)
SafeAddString(SI_PA_ST_MOVE_INCOMPLETE_STACKS_ONLY, "Nur Stapel auffüllen", 1)