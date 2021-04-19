local PAC = PersonalAssistant.Constants
local PAJStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk Menu --
    SI_PA_MENU_JUNK_DESCRIPTION = "PAJunk kann Gegenstände als Trödel markieren wenn unten auswählbare Bedingungen eintreffen; ausser wenn es gerade hergestellt oder aus aus einer Nachricht entnommen wurde",

    -- Standard Items --
    SI_PA_MENU_JUNK_STANDARD_ITEMS_HEADER = "Standard Gegenstände",
    SI_PA_MENU_JUNK_AUTOMARK_ENABLE = "Aktiviere das Markieren als Trödel",
    SI_PA_MENU_JUNK_AUTOMARK_ENABLE_T = "Betrifft nur 'Standard Gegenstände'. Benutzerdefinierte Regeln zum Markieren als Trödel sind davon nicht betroffen und müssen individuell deaktiviert werden wenn diese nicht mehr ausgeführt werden sollen.",

    SI_PA_MENU_JUNK_TRASH_AUTOMARK = table.concat({"Markiere [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] Gegenstände"}),
    SI_PA_MENU_JUNK_TRASH_AUTOMARK_T = table.concat({"Automatisch Gegenstände vom Typ [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] als Trödel markieren?"}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_ITEMS_DESC = table.concat({"Markiere [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] Gegenstände NICHT als Trödel wenn . . ."}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS = table.concat({"> für tägl. Quest ", PAC.COLOR.YELLOW:Colorize("Stückchen und Häppchen"), " benötigt"}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quest in: "), PAC.COLOR.ORANGE:Colorize("Die Stadt der Uhrwerke"), "\nWenn EINgeschaltet werden folgende Plunder Gegenstände NICHT als Trödel markiert:\n[Panzer]\n[Verdorbenes Fell]\n[Daedrafetzen]"}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS = table.concat({"> für tägl. Quest ", PAC.COLOR.YELLOW:Colorize("Bröckchen und Bisschen"), " benötigt"}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quest in: "), PAC.COLOR.ORANGE:Colorize("Die Stadt der Uhrwerke"), "\nWenn EINgeschaltet werden folgende Plunder Gegenstände NICHT als Trödel markiert:\n[Elementare Essenz]\n[Biegsame Wurzel]\n[Ektoplasma]"}),

    SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK = table.concat({"Markiere [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] Gegenstände"}),
    SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK_T = table.concat({"Automatisch Gegenstände mit der Indikation [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] als Trödel markieren?"}),
    SI_PA_MENU_JUNK_COLLECTIBLES_EXCLUDE_ITEMS_DESC = table.concat({"Markiere [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] Gegenstände NICHT als Trödel wenn . . ."}),
    SI_PA_MENU_JUNK_COLLECTIBLES_EXCLUDE_RARE_FISH = table.concat({"> [", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_COLLECTIBLE_RARE_FISH), "] für ", PAC.COLOR.YELLOW:Colorize("Fischgunstfestmahl"), " benötigt"}),
    SI_PA_MENU_JUNK_COLLECTIBLES_EXCLUDE_RARE_FISH_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quest während: "), PAC.COLOR.ORANGE:Colorize("Neujahrsfest"), " welches im Winter stattfindet\nWenn EINgeschaltet wird [", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_COLLECTIBLE_RARE_FISH),"] NICHT als Trödel markiert"}),

    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_AUTOMARK = table.concat({"Markiere [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] Gegenstände"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_AUTOMARK_T = table.concat({"Automatisch Gegenstände vom Typ [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] als Trödel markieren?"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_ITEMS_DESC = table.concat({"[", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] NICHT zerstören oder als Trödel markieren wenn . . ."}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_LEISURE = table.concat({"> für tägl. Quest ", PAC.COLOR.YELLOW:Colorize("Eine Frage der Muße"), " benötigt"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_LEISURE_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quest in: "), PAC.COLOR.ORANGE:Colorize("Die Stadt der Uhrwerke"), "\nWenn EINgeschaltet werden folgende Beute Gegenstände NICHT als Trödel markiert:\n[Kinderspielzeug]\n[Puppen]\n[Spiele]"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_RESPECT = table.concat({"> für tägl. Quest ", PAC.COLOR.YELLOW:Colorize("Eine Frage des Respekts"), " benötigt"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_RESPECT_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quest in: "), PAC.COLOR.ORANGE:Colorize("Die Stadt der Uhrwerke"), "\nWenn EINgeschaltet werden folgende Beute Gegenstände NICHT als Trödel markiert:\n[Utensilien]\n[Trinkgefäße]\n[Teller und Kochgeschirr]"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_TRIBUTES = table.concat({"> für tägl. Quest ", PAC.COLOR.YELLOW:Colorize("Eine Frage des Tributs"), " benötigt"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_TRIBUTES_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quest in: "), PAC.COLOR.ORANGE:Colorize("Die Stadt der Uhrwerke"), "\nWenn EINgeschaltet werden folgende Beute Gegenstände NICHT als Trödel markiert:\n[Kosmetika]\n[Körperpflegegegenstände]"}),

    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_THE_COVETOUS_COUNTESS = table.concat({"> für tägl. Quest ", PAC.COLOR.YELLOW:Colorize("Die gierige Gräfin"), " benötigt"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_THE_COVETOUS_COUNTESS_T = table.concat({PAC.COLOR.YELLOW:Colorize("Quest für: "), PAC.COLOR.ORANGE:Colorize("Diebesgilde"), "\nWenn EINgeschaltet werden folgende Beute Gegenstände NICHT als Trödel markiert:\n[Kosmetika]\n[Trockenwaren]\n[Schmuckstücke]\n\n[Trinkgefäße]\n[Utensilien]\n[Teller und Kochgeschirr]\n\n[Spiele]\n[Puppen]\n[Statuen]\n\n[Schriften] & [Schreiberbedarf]\n[Karten]\n\n[Ritualgegenstände]\n[Kuriositäten]"}),

    -- Stolen Items --
    SI_PA_MENU_JUNK_AUTOMARK_STOLEN_HEADER = "Gestohlene Gegenstände",
    SI_PA_MENU_JUNK_ACTION_STOLEN_PLACEHOLDER = "Markiere gestohlene [%s]",

    -- Custom Items --
    SI_PA_MENU_JUNK_CUSTOM_ITEMS_HEADER = "Benutzerdefinierte Gegenstände",
    SI_PA_MENU_JUNK_CUSTOM_ITEMS_DESCRIPTION = table.concat({GetString(SI_PA_MENU_RULES_HOW_TO_ADD_PAJ), "\n\n", GetString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU)}),

    -- Quest Items --
    SI_PA_MENU_JUNK_QUEST_ITEMS_HEADER = "Zu schützende Quest Gegenstände",
    SI_PA_MENU_JUNK_QUEST_CLOCKWORK_CITY_HEADER = "Die Stadt der Uhrwerke",
    SI_PA_MENU_JUNK_QUEST_THIEVES_GUILD_HEADER = "Diebesgilde",
    SI_PA_MENU_JUNK_QUEST_NEW_LIFE_FESTIVAL_HEADER = "Neujahrsfest",

    -- Auto-Sell --
    SI_PA_MENU_JUNK_AUTO_SELL_JUNK_HEADER = "Trödel direkt verkaufen",

    -- Auto-Destroy --
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_HEADER = "Trödel direkt zerstören",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK = "Direktes Zerstören von Trödel",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_T = "Wenn ein Gegenstand eingesammelt wird der automatisch als Trödel markiert würde, und einen Verkaufswert sowie eine Qualität hat die genau auf oder unter dem Schwellenwert liegt, dann wird wenn EINgeschaltet dieser Gegenstand stattdessen zerstört. Einmal zerstört kann der Gegenstand nicht zurückgeholt werden!",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_W = "ACHTUNG: Bitte beachte dass bei Verwendung von dieser Einstellung KEINE Sicherheitsfrage kommt ob der Gegenstand wirklich zerstört werden soll.\nEr wird einfach direkt zerstört!\nUnwiderruflich!\nNutzung erfolgt auf eigenes Risiko!",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_MAX_VALUE_THRESHOLD = "WENN Verkaufswert genau auf oder unter [...] liegt",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_MAX_VALUE_THRESHOLD_T = "Nur Gegenstände deren Verkaufswert auf oder unter dem eingegeben Schwellenwert liegen werden automatisch zerstört. Wenn ein Gegenstand einmal zerstört ist, kann dies nicht mehr rückgängig gemacht werden!",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_MAX_QUALITY_THRESHOLD = "UND die Qualität genau auf oder unter [...] liegt",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_MAX_QUALITY_THRESHOLD_T = "Nur Gegenstände deren Qualität auf oder unter der ausgewählten Qualität liegen werden automatisch zerstört. Wenn ein Gegenstand einmal zerstört ist, kann dies nicht mehr rückgängig gemacht werden!",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_EXCLUSION_DISCLAIMER = "Ausnahme: Alle Arten von 'unbekannten' Gegenständen (Rezepte, Stile, Stilseiten, Eigenschaften, ...) werden nie automatisch zerstört, selbst wenn die Kriterien des Verkaufswertes und der Qualität erfüllt wären",

    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK = "Direktes Zerstören von gestohlenem Trödel",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_T = "Wenn ein Gegenstand gestohlen wird der automatisch als Trödel markiert würde, und einen Verkaufswert sowie eine Qualität hat die genau auf oder unter dem Schwellenwert liegt, dann wird wenn EINgeschaltet dieser Gegenstand stattdessen zerstört. Einmal zerstört kann der Gegenstand nicht zurückgeholt werden!",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_MAX_VALUE_THRESHOLD = "WENN Verkaufswert genau auf oder unter [...] liegt",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_MAX_VALUE_THRESHOLD_T = "Nur gestohlene Gegenstände deren Qualität auf oder unter der ausgewählten Qualität liegen werden automatisch zerstört. Wenn ein Gegenstand einmal zerstört ist, kann dies nicht mehr rückgängig gemacht werden!",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_MAX_QUALITY_THRESHOLD = "UND die Qualität genau auf oder unter [...] liegt",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_MAX_QUALITY_THRESHOLD_T = "Nur gestohlene Gegenstände deren Qualität auf oder unter der ausgewählten Qualität liegen werden automatisch zerstört. Wenn ein Gegenstand einmal zerstört ist, kann dies nicht mehr rückgängig gemacht werden!",

    -- Other Settings --
    SI_PA_MENU_JUNK_MAILBOX_IGNORE = "Aus Nachrichten nie als Trödel markieren",
    SI_PA_MENU_JUNK_MAILBOX_IGNORE_T = "Aus Nachrichten entnommene Gegenstände sollen nie als Trödel markiert werden",
    SI_PA_MENU_JUNK_CRAFTED_IGNORE = "An Stationen hergestellt nie als Trödel markieren",
    SI_PA_MENU_JUNK_CRAFTED_IGNORE_T = "An Handwerksstationen selber hergestellte Gegenstände sollen nie als Trödel markiert werden",
    SI_PA_MENU_JUNK_AUTOSELL_JUNK = "Trödel direkt an Händler und Hehler verkaufen?",
    SI_PA_MENU_JUNK_AUTOSELL_JUNK_PIRHARRI = "Auch an Pirharri verkaufen? (Schmuggler Gehilfe)",
    SI_PA_MENU_JUNK_AUTOSELL_JUNK_PIRHARRI_W = "Im Gegensatz zu anderen Schmugglern behält Pirharri 35% des Profits für sich selbst",

    SI_PA_MENU_JUNK_KEYBINDINGS_HEADER = "Tastenkürzel",
    SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_JUNK_ENABLE = "Tastenkürzel \"Als Trödel markieren\" aktivieren",
    SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_JUNK_SHOW = "Tastenkürzel \"Als Trödel markieren\" anzeigen",
    SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_PERM_JUNK_ENABLE = "Tastenkürzel \"Als perm. Trödel markieren\" aktivieren",
    SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_PERM_JUNK_SHOW = "Tastenkürzel \"Als perm. Trödel markieren\" anzeigen",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_ENABLE = "Tastenkürzel \"Gegenstand zerstören\" aktivieren",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_ENABLE_W = "ACHTUNG: Bitte beachte dass bei Verwendung von diesem Tastenkürzel KEINE Sicherheitsfrage kommt ob der Gegenstand wirklich zerstört werden soll.\nEr wird einfach direkt zerstört!\nUnwiderruflich!\nNutzung erfolgt auf eigenes Risiko!",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_SHOW = "Tastenkürzel \"Gegenstand zerstören\" anzeigen",
    SI_PA_MENU_JUNK_KEYBINDINGS_EXCLUDE_DESCRIPTION = "Deaktiviere den \"Gegenstand zerstören\" Tastenkürzel wenn der Gegenstand . . .",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_QUALITY_THRESHOLD = "> von der ausgewählten oder höheren Qualität ist",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_UNKNOWN = "> gelernt/analysiert werden kann und unbekannt ist",

    -- General texts used across: Weapons, Armor, Jewelry
    SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD = "Markiere %s mit Qualität tiefer oder gleich",
    SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD_T = "Automatisch %s als Trödel markieren wenn deren Qualität genau auf oder unter der ausgewählten Qualität liegt",
    SI_PA_MENU_JUNK_AUTOMARK_ORNATE = table.concat({"Markiere %s mit Eigenschaft [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "]"}),
    SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T = table.concat({"Automatisch %s mit der Eigenschaft [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "] (erhöhter Verkaufspreis) als Trödel markieren?"}),
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS = "Markiere auch %s von einem Set",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS_T = "Wenn AUSgeschaltet, dann werden nur %s die NICHT zu einem Set gehören als Trödel markiert",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_INTRICATE = table.concat({"Markiere auch %s mit Eigenschaft [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE),"]"}),
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_INTRICATE_T = table.concat({"Wenn AUSgeschaltet, dann werden %s mit der Eigenschaft [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE),"] NICHT als Trödel markiert (unabhängig von der Qualität)"}),
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_KNOWN_TRAITS = "Markiere %s mit bekannten Eigenschaften",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_KNOWN_TRAITS_T = "Wenn AUSgeschaltet, dann werden nur %s ohne Eigenschaften oder mit noch nicht analysierten Eigenschaften als Trödel markiert",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS = "Markiere %s mit unbekannten Eigenschaften",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T = "Wenn AUSgeschaltet, dann werden nur %s ohne Eigenschaften oder mit bereits analysierten Eigenschaften als Trödel markiert",


    -- =================================================================================================================
    -- == MAIN MENU TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    SI_PA_MAINMENU_JUNK_HEADER = "Trödel Regeln",

    SI_PA_MAINMENU_JUNK_HEADER_ITEM = "Gegenstand",
    SI_PA_MAINMENU_JUNK_HEADER_JUNK_COUNT = "Anzahl",
    SI_PA_MAINMENU_JUNK_HEADER_LAST_JUNK = "Letzter Trödel",
    SI_PA_MAINMENU_JUNK_HEADER_RULE_ADDED = "Regel erstellt",
    SI_PA_MAINMENU_JUNK_HEADER_ACTIONS = "Aktionen",

    SI_PA_MAINMENU_JUNK_ROW_NEVER_JUNKED = "niemals",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TRASH = table.concat({"%s als Trödel markiert (", PAC.COLOR.ORANGE:Colorize(GetString("SI_ITEMTYPE", ITEMTYPE_TRASH)), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_ORNATE = table.concat({"%s als Trödel markiert (", PAC.COLOR.ORANGE:Colorize(GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE)), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY = table.concat({"%s als Trödel markiert (", PAC.COLOR.ORANGE:Colorize("Qualität"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_MERCHANT = table.concat({"%s als Trödel markiert (", PAC.COLOR.ORANGE:Colorize("Händler"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TREASURE = table.concat({"%s als Trödel markiert (", PAC.COLOR.ORANGE:Colorize("Beute"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_KEYBINDING = table.concat({"%s als Trödel markiert (", PAC.COLOR.ORANGE:Colorize("Manuell"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN = table.concat({"%s als Trödel markiert (", PAC.COLOR.ORANGE:Colorize("Gestohlen"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_PERMANENT = table.concat({"%s als Trödel markiert (", PAC.COLOR.ORANGE:Colorize("Perm-Regel"), ")"}),

    SI_PA_CHAT_JUNK_DESTROYED_KEYBINDING = table.concat({PAC.COLOR.ORANGE_RED:Colorize("Zerstört"), " %d x %s"}),
    SI_PA_CHAT_JUNK_DESTROYED_ALWAYS = table.concat({PAC.COLOR.ORANGE_RED:Colorize("Zerstört"), " %d x %s (", PAC.COLOR.ORANGE:Colorize("Immer"), ")"}),
    SI_PA_CHAT_JUNK_DESTROYED_CRITERIA_MATCH = table.concat({PAC.COLOR.ORANGE_RED:Colorize("Zerstört"), " %d x %s (Verkaufswert: %s)"}),

    SI_PA_CHAT_JUNK_DESTROY_ON = table.concat({"Direktes Zerstören von Trödel wurde ", PAC.COLOR.RED:Colorize("EIN"), "geschalten"}),
    SI_PA_CHAT_JUNK_DESTROY_OFF = table.concat({"Direktes Zerstören von Trödel wurde ", PAC.COLOR.GREEN:Colorize("AUS"), "geschalten"}),
    SI_PA_CHAT_JUNK_DESTROY_STOLEN_ON = table.concat({"Direktes Zerstören von gestohlenem Trödel wurde ", PAC.COLOR.RED:Colorize("EIN"), "geschalten"}),
    SI_PA_CHAT_JUNK_DESTROY_STOLEN_OFF = table.concat({"Direktes Zerstören von gestohlenem Trödel wurde ", PAC.COLOR.GREEN:Colorize("AUS"), "geschalten"}),

    SI_PA_CHAT_JUNK_SOLD_ITEMS_INFO = "Gegenstände verkauft für %s",
    SI_PA_CHAT_JUNK_FENCE_LIMIT_HOURS = table.concat({GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Bitte warte ~%d Stunden"}),
    SI_PA_CHAT_JUNK_FENCE_LIMIT_MINUTES = table.concat({GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Bitte warte ~%d Minuten"}),
    SI_PA_CHAT_JUNK_FENCE_ITEM_WORTHLESS = table.concat({"Kann %s nicht verkaufen. ", GetString("SI_STOREFAILURE", STORE_FAILURE_WORTHLESS_TO_FENCE)}),
    SI_PA_CHAT_JUNK_CANNOT_SELL_ITEM = "Kann %s nicht verkaufen",

    SI_PA_CHAT_JUNK_RULES_ADDED = table.concat({"%s zur Liste permanenten Trödels ", PAC.COLOR.ORANGE:Colorize("hinzugefügt"), "!"}),
    SI_PA_CHAT_JUNK_RULES_DELETED = table.concat({"%s von der Liste permanenten Trödels ", PAC.COLOR.ORANGE:Colorize("entfernt"), "!"}),


    -- =================================================================================================================
    -- == KEY BINDINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- Addon Keybindings menu --
    SI_BINDING_NAME_PA_JUNK_TOGGLE_ITEM = "Als Trödel markieren",
    SI_BINDING_NAME_PA_JUNK_PERMANENT_TOGGLE_ITEM = "Als permanenten Trödel markieren",
    SI_BINDING_NAME_PA_JUNK_DESTROY_ITEM = "Gegenstand zerstören",

    -- Actual keybindings --
    SI_PA_ITEM_ACTION_MARK_AS_PERM_JUNK = "Als perm. Trödel markieren",
    SI_PA_ITEM_ACTION_UNMARK_AS_PERM_JUNK = "Nicht mehr als perm. Trödel markieren",


    -- =================================================================================================================
    -- == OTHER STRINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- Quest: "A Matter of Leisure"
    SI_PA_TREASURE_ITEM_TAG_DESC_TOYS = "Kinderspielzeug",
    SI_PA_TREASURE_ITEM_TAG_DESC_DOLLS = "Puppen",
    SI_PA_TREASURE_ITEM_TAG_DESC_GAMES = "Spiele",

    -- Quest: "A Matter of Respect"
    SI_PA_TREASURE_ITEM_TAG_DESC_UTENSILS = "Utensilien",
    SI_PA_TREASURE_ITEM_TAG_DESC_DRINKWARE = "Trinkgefäße",
    SI_PA_TREASURE_ITEM_TAG_DESC_DISHES_COOKWARE = "Teller und Kochgeschirr",

    -- Quest: "A Matter of Tributes"
    SI_PA_TREASURE_ITEM_TAG_DESC_COSMETICS = "Kosmetika",
    SI_PA_TREASURE_ITEM_TAG_DESC_GROOMING = "Körperpflegegegenstände",

    -- Quest: "The Covetous Countess" (only additional tags)
    SI_PA_TREASURE_ITEM_TAG_DESC_LINENS = "Trockenwaren",
    SI_PA_TREASURE_ITEM_TAG_DESC_ACCESSORIES = "Schmuckstücke",
    SI_PA_TREASURE_ITEM_TAG_DESC_STATUES = "Statuen",
    SI_PA_TREASURE_ITEM_TAG_DESC_WRITINGS = "Schriften",
    SI_PA_TREASURE_ITEM_TAG_DESC_SCRIVENER = "Schreiberbedarf",
    SI_PA_TREASURE_ITEM_TAG_DESC_MAPS = "Karten",
    SI_PA_TREASURE_ITEM_TAG_DESC_RITUAL_OBJECTS = "Ritualgegenstände",
    SI_PA_TREASURE_ITEM_TAG_DESC_ODDITIES = "Kuriositäten",

    -- OTHERS: Not yet used
    SI_PA_TREASURE_ITEM_TAG_DESC_INSTRUMENTS = "Musikinstrumente",
    SI_PA_TREASURE_ITEM_TAG_DESC_ARTWORK = "Kunstwerke",
    SI_PA_TREASURE_ITEM_TAG_DESC_DECOR = "Wanddekor",
    SI_PA_TREASURE_ITEM_TAG_DESC_TRIFLES_ORNAMENTS = "Kleinigkeiten und Zierden",
    SI_PA_TREASURE_ITEM_TAG_DESC_DEVICES = "Geräte",
    SI_PA_TREASURE_ITEM_TAG_DESC_SMITHING = "Schmiedeausrüstung",
    SI_PA_TREASURE_ITEM_TAG_DESC_TOOLS = "Werkzeuge",
    SI_PA_TREASURE_ITEM_TAG_DESC_MEDICAL_SUPPLIES = "Medizinische Vorräte",
    SI_PA_TREASURE_ITEM_TAG_DESC_CURIOSITIES = "Magische Kuriositäten",
    SI_PA_TREASURE_ITEM_TAG_DESC_FURNISHINGS = "Möblierung",
    SI_PA_TREASURE_ITEM_TAG_DESC_LIGHTS = "Lichtquellen",
}

for key, value in pairs(PAJStrings) do
    SafeAddString(_G[key], value, 1)
end
