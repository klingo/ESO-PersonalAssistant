local PAC = PersonalAssistant.Constants
local PAStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- Profile Settings --
    SI_PA_MENU_PROFILE_PLEASE_SELECT = "<Bitte Profil wählen>",
    SI_PA_MENU_PROFILE_ACTIVE = "Aktives Profil",
    SI_PA_MENU_PROFILE_ACTIVE_T = "Das aktive Profil für PersonalAssistant auswählen. Es werden automatisch alle Einstellungen von diesem Profil geladen und am gleichen Ort auch wieder abgespeichert.",
    SI_PA_MENU_PROFILE_ACTIVE_RENAME = "Aktives Profil umbenennen",

    -- Create Profiles --
    SI_PA_MENU_PROFILE_CREATE_NEW = "Neues Profil erstellen",
    SI_PA_MENU_PROFILE_CREATE_NEW_DESC = table.concat({"Anmerkung: Du kannst maximal ", PAC.GENERAL.MAX_PROFILES, " Profile haben."}),

    -- Copy Profiles --
    SI_PA_MENU_PROFILE_COPY_FROM_DESC = "Kopiere die Einstellungen von einem bestehenden Profil in das derzeit aktive Profil.",
    SI_PA_MENU_PROFILE_COPY_FROM = "Profil kopieren",
    SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM = "Kopieren bestätigen",
    SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM_W = "Das wird die Einstellungen vom aktiven Profil mit den Einstellungen vom ausgewählten Profil ersetzen. Bist du dir sicher? \n\nAnmerkung: Nur Einstellungen von aktivierten PersonalAssistant Modulen werden kopiert",

    -- Delete Profiles --
    SI_PA_MENU_PROFILE_DELETE_DESC = "Lösche bestehende und nicht mehr benötigte Profile von der Datenbank um Platz zu sparen und die SavedVariables Datei aufzuräumen.",
    SI_PA_MENU_PROFILE_DELETE = "Profil löschen",
    SI_PA_MENU_PROFILE_DELETE_CONFIRM = "Löschen bestätigen",
    SI_PA_MENU_PROFILE_DELETE_CONFIRM_W = "Das wird das ausgewählte Profil für alle Charaktere löschen. Bist du dir sicher?",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Rules Menu --
    SI_PA_MENU_RULES_HOW_TO_ADD_PAB = "Um eine neue Regel für das Einlagern und Entnehmen zu erstellen, einfach per Rechtsklick auf einem Gegenstand im Inventar oder der Bank im Kontextmenü folgendes auswählen:\n> PA Banking > Neue Regel hinzufügen",
    SI_PA_MENU_RULES_HOW_TO_ADD_PAJ = "Um eine neue Regel für permanenten Trödel zu erstellen, einfach per Rechtsklick auf einem Gegenstand im Inventar oder der Bank im Kontextmenü folgendes auswählen:\n> PA Junk > Als permanenten Trödel markieren",
    SI_PA_MENU_RULES_HOW_TO_FIND_MENU = table.concat({"Alle aktiven Regeln können entweder via dem Icon im oberen Hauptmenü (das mit der [Alt] Taste geöffnet wird) gefunden werden, mit ", PAC.COLOR.YELLOW:Colorize("/parules"), " oder anhand dieses Buttons:"}),
    SI_PA_MENU_RULES_HOW_TO_CREATE = "Wie neue Regeln erstellen?",

    SI_PA_MENU_DANGEROUS_SETTING = "ACHTUNG: Riskante Einstellung! Verwendung auf eigenes Risiko!",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Generic Menu --
    SI_PA_MENU_OTHER_SETTINGS_HEADER = "Weitere Einstellungen",

    SI_PA_MENU_SILENT_MODE = "Ruhemodus (Deaktiviert ALLE Meldungen)",

    SI_PA_MENU_NOT_YET_IMPLEMENTED = table.concat({PAC.COLORS.RED, "Noch nicht implementiert!"}),


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAGeneral --
    SI_PA_CHAT_GENERAL_NEW_PROFILE_CREATED = table.concat({" neues Profil ", PAC.COLOR.WHITE:Colorize("%s"), " erstellt und aktiviert!"}),
    SI_PA_CHAT_GENERAL_SELECTED_PROFILE_COPIED = table.concat({" Einstellungen von Profil ", PAC.COLOR.WHITE:Colorize("%s"), " wurden in das aktive Profil ", PAC.COLOR.WHITE:Colorize("%s"), PAC.COLOR.ORANGE_RED:Colorize(" kopiert")}),
    SI_PA_CHAT_GENERAL_SELECTED_PROFILE_DELETED = table.concat({" ausgewähltes Profil ", PAC.COLOR.WHITE:Colorize("%s"), " wurde ", PAC.COLOR.ORANGE_RED:Colorize("gelöscht!")}),

    SI_PA_CHAT_GENERAL_TELEPORT_NO_PRIMARY_HOUSE = table.concat({"Du musst zuerst ein Haus als deinen ", PAC.COLOR.ORANGE_RED:Colorize("Hauptwohnsitz"), " festlegen"}),
    SI_PA_CHAT_GENERAL_TELEPORT_ZONE_PREVENTED = table.concat({"Dein aktueller Ort erlaubt ", PAC.COLOR.ORANGE_RED:Colorize("nicht"), " zu deinem Haus zu reisen"}),


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAGeneral --
    SI_PA_PROFILE = "Profil",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Name Spaces --
    --SI_PA_NS_BAG_EQUIPMENT = "tbd",
    SI_PA_NS_BAG_BACKPACK = "Inventar",
    SI_PA_NS_BAG_BANK = "Bank",
    SI_PA_NS_BAG_SUBSCRIBER_BANK = "ESO Plus Bank",
    SI_PA_NS_BAG_VIRTUAL = "Handwerksbeutel",
    SI_PA_NS_BAG_HOUSE_BANK = "Heimbank",
    SI_PA_NS_BAG_HOUSE_BANK_NR = "Heimbank (%d)",
    SI_PA_NS_BAG_UNKNOWN = "Unbekannt",

    -- -----------------------------------------------------------------------------------------------------------------
    -- ItemTypes (Custom Singluar/Plural definition) --
    SI_PA_ITEMTYPE4 = "<<1[Gericht/Gerichte]>>",
    SI_PA_ITEMTYPE5 = "<<1[Trophäe/Trophäen]>>",
    SI_PA_ITEMTYPE7 = "<<1[Trank/Tränke]>>",
    SI_PA_ITEMTYPE8 = "<<1[Stil/Stile]>>",
    SI_PA_ITEMTYPE10 = "<<1[Zutat/Zutaten]>>",
    SI_PA_ITEMTYPE12 = "<<1[Getränk/Getränke]>>",
    SI_PA_ITEMTYPE16 = "<<1[Köder/Köder]>>",
    SI_PA_ITEMTYPE19 = "<<1[Seelenstein/Seelensteine]>>",
    SI_PA_ITEMTYPE22 = "<<1[Dietrich/Dietriche]>>",
    SI_PA_ITEMTYPE29 = "<<1[Rezept/Rezepte]>>",
    SI_PA_ITEMTYPE30 = "<<1[Gift/Gifte]>>",
    SI_PA_ITEMTYPE33 = "<<1[Lösungsmittel/Lösungsmittel]>>",
    SI_PA_ITEMTYPE34 = "<<1[Sammlung/Sammlungen]>>",
--    SI_PA_ITEMTYPE47 = "<<1[]>>",
    SI_PA_ITEMTYPE56 = "<<1[Beute/Beuten]>>",
    SI_PA_ITEMTYPE60 = "<<1[Meisterschrieb/Meisterschriebe]>>",

    -- -----------------------------------------------------------------------------------------------------------------
    -- SpecializedItemTypes (Custom Singluar/Plural definition) --
    SI_PA_SPECIALIZEDITEMTYPE102 = "<<1[Fragment/Fragmente]>>",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Master Writs based on CraftingType (Custom definition) --
    SI_PA_MASTERWRIT_CRAFTINGTYPE0 = table.concat({"Andere Schriebe (", GetString("SI_ENCHANTMENTSEARCHCATEGORYTYPE", ENCHANTMENT_SEARCH_CATEGORY_OTHER), ")"}),
    SI_PA_MASTERWRIT_CRAFTINGTYPE1 = "Versiegelter Schmiedeschrieb",
    SI_PA_MASTERWRIT_CRAFTINGTYPE2 = "Versiegelter Schneiderschrieb",
    SI_PA_MASTERWRIT_CRAFTINGTYPE3 = "Versiegelter Verzauberungsschrieb",
    SI_PA_MASTERWRIT_CRAFTINGTYPE4 = "Versiegelter Alchemieschrieb",
    SI_PA_MASTERWRIT_CRAFTINGTYPE5 = "Versiegelter Versorgerschrieb",
    SI_PA_MASTERWRIT_CRAFTINGTYPE6 = "Versiegelter Schreinerschrieb",
    SI_PA_MASTERWRIT_CRAFTINGTYPE7 = "Versiegelter Schmuckhandwerksschrieb",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_PA_BANKING_MOVE_MODE_DONOTHING = "Nichts machen",
    SI_PA_BANKING_MOVE_MODE_TOBANK = "In Truhe einlagern",
    SI_PA_BANKING_MOVE_MODE_TOBACKPACK = "Ins Inventar entnehmen",

    SI_PA_MENU_BANKING_ADVANCED_GLYPHS = "Glyphen",
    SI_PA_MENU_BANKING_ADVANCED_INTRICATE_ITEMS = "Intrikate Gegenstände",

    SI_PA_MENU_BANKING_REPAIRKIT = "Reparaturmaterialien",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Operators --
    SI_PA_REL_OPERATOR_T = "Wähle den mathematischen Operator für diesen Gegenstand",
    SI_PA_REL_BACKPACK_EQUAL = "INVENTAR ==",
    SI_PA_REL_BACKPACK_LESSTHAN = "INVENTAR >", -- not used so far
    SI_PA_REL_BACKPACK_LESSTHANEQUAL = "INVENTAR <=",
    SI_PA_REL_BACKPACK_GREATERTHAN = "INVENTAR >)", -- not used so far
    SI_PA_REL_BACKPACK_GREATERTHANEQUAL = "INVENTAR >=",
    SI_PA_REL_BANK_EQUAL = "BANK ==",
    SI_PA_REL_BANK_LESSTHAN = "BANK <", -- not used so far
    SI_PA_REL_BANK_LESSTHANOREQUAL = "BANK <=",
    SI_PA_REL_BANK_GREATERTHAN = "BANK >", -- not used so far
    SI_PA_REL_BANK_GREATERTHANOREQUAL = "BANK >=",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Operator Tooltip --
    SI_PA_REL_BACKPACK_EQUAL_T = "INVENTAR gleich (=)",
    SI_PA_REL_BACKPACK_LESSTHAN_T = "INVENTAR kleiner als (<)", -- not used so far
    SI_PA_REL_BACKPACK_LESSTHANOREQUAL_T = "INVENTAR kleiner oder gleich als (<=)",
    SI_PA_REL_BACKPACK_GREATERTHAN_T = "INVENTAR grösser als (>)", -- not used so far
    SI_PA_REL_BACKPACK_GREATERTHANOREQUAL_T = "INVENTAR grösser oder gleich als (>=)",
    SI_PA_REL_BANK_EQUAL_T = "BANK gleich (=)",
    SI_PA_REL_BANK_LESSTHAN_T = "BANK kleiner als (<)", -- not used so far
    SI_PA_REL_BANK_LESSTHANOREQUAL_T = "BANK kleiner oder gleich als (<=)",
    SI_PA_REL_BANK_GREATERTHAN_T = "BANK grösser als (>)", -- not used so far
    SI_PA_REL_BANK_GREATERTHANOREQUAL_T = "BANK grösser oder gleich als (>=)",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Text Operators --
    SI_PA_REL_TEXT_OPERATOR0 = "-",
    SI_PA_REL_TEXT_OPERATOR1 = "hat genau",
    SI_PA_REL_TEXT_OPERATOR2 = "hat weniger als", -- not used so far
    SI_PA_REL_TEXT_OPERATOR3 = "hat höchstens",
    SI_PA_REL_TEXT_OPERATOR4 = "hat mehr als", -- not used so far
    SI_PA_REL_TEXT_OPERATOR5 = "hat mindestens",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Stacking types --
    SI_PA_ST_MOVE_FULL = "Verschiebe alles",
    SI_PA_ST_MOVE_INCOMPLETE_STACKS_ONLY = "Nur Stapel auffüllen",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Icon Positions --
    SI_PA_POSITION_AUTO = "Automatisch",
    SI_PA_POSITION_MANUAL = "Manuell",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    SI_PA_ITEM_ACTION_NOTHING = "Nichts machen",
    SI_PA_ITEM_ACTION_LAUNDER = "Beim Hehler schieben",
    SI_PA_ITEM_ACTION_MARK_AS_JUNK = "Als Trödel markieren",
    SI_PA_ITEM_ACTION_JUNK_DESTROY_WORTHLESS = "Trödel oder zerstören wenn wertlos",
    SI_PA_ITEM_ACTION_DESTROY_ALWAYS = "Immer zerstören",


    -- =================================================================================================================
    -- == CUSTOM SUB MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_PA_SUBMENU_PAB_ADD_RULE = "Neue Regel hinzufügen",
    SI_PA_SUBMENU_PAB_EDIT_RULE = "Regel bearbeiten",
    SI_PA_SUBMENU_PAB_DELETE_RULE = "Regel löschen",
    SI_PA_SUBMENU_PAB_ENABLE_RULE = "Regel aktivieren",
    SI_PA_SUBMENU_PAB_DISABLE_RULE = "Regel deaktivieren",
    SI_PA_SUBMENU_PAB_ADD_RULE_BUTTON = "Hinzufügen",
    SI_PA_SUBMENU_PAB_UPDATE_RULE_BUTTON = "Speichern",
    SI_PA_SUBMENU_PAB_DELETE_RULE_BUTTON = "Löschen",
    SI_PA_SUBMENU_PAB_NO_RULES = "Noch keine Banking Regeln definiert",
    SI_PA_SUBMENU_PAB_DISCLAIMER = "Anmerkung: Diese benutzerdefinierten Regeln werden erst berücksichtigt, wenn alle anderen automatischen Banking Regeln (Handwerks, Spezielle, und AvA Gegenstände) ausgeführt wurden.",

    SI_PA_SUBMENU_PAJ_MARK_PERM_JUNK = "Als permanenten Trödel markieren",
    SI_PA_SUBMENU_PAJ_UNMARK_PERM_JUNK = "Nicht mehr als permanenten Trödel markieren",
    SI_PA_SUBMENU_PAJ_NO_RULES = "Noch keine Regeln für permanenten Trödel definiert",


    -- =================================================================================================================
    -- == KEY BINDINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_KEYBINDINGS_CATEGORY_PA_PROFILES = "|cFFD700P|rersonal|cFFD700A|rssistant Profile",
    SI_KEYBINDINGS_CATEGORY_PA_MENU = "|cFFD700P|rersonal|cFFD700A|rssistant Menu",

    SI_BINDING_NAME_PA_RULES_MAIN_MENU = "PersonalAssistant Regeln",
    SI_BINDING_NAME_PA_RULES_TOGGLE_WINDOW = "Banking/Trödel Regelmenü ein-/ausblenden",
    SI_BINDING_NAME_PA_TRAVEL_TO_HOUSE = "Zum Hauptwohnsitz reisen",
}

for key, value in pairs(PAStrings) do
    SafeAddString(_G[key], value, 1)
end
