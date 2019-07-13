local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk Menu --
SafeAddString(SI_PA_MENU_JUNK_DESCRIPTION, "PAJunk kann Gegenstände als Trödel markieren wenn unten auswählbare Bedingungen eintreffen; ausser wenn es gerade hergestellt oder aus aus einer Nachricht entnommen wurde", 1)

-- Standard Items --
SafeAddString(SI_PA_MENU_JUNK_STANDARD_ITEMS_HEADER, "Standard Gegenstände", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_ENABLE, "Aktiviere das Markieren als Trödel", 1)

SafeAddString(SI_PA_MENU_JUNK_TRASH_AUTOMARK, table.concat({"Markiere [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] Gegenstände"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_AUTOMARK_T, table.concat({"Automatisch Gegenstände vom Typ [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] als Trödel markieren?"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_ITEMS_DESC, table.concat({"Markiere [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] Gegenstände NICHT als Trödel wenn . . ."}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS, table.concat({"> für tägl. Quest ", PAC.COLOR.YELLOW:Colorize("Stückchen und Häppchen"), " benötigt"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS_T, table.concat({PAC.COLOR.YELLOW:Colorize("Quest in: "), PAC.COLOR.ORANGE:Colorize("Die Stadt der Uhrwerke"), "\nWenn EINgeschaltet werden folgende Plunder Gegenstände NICHT als Trödel markiert:\n[Panzer]\n[Verdorbenes Fell]\n[Daedrafetzen]"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS, table.concat({"> für tägl. Quest ", PAC.COLOR.YELLOW:Colorize("Bröckchen und Bisschen"), " benötigt"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS_T, table.concat({PAC.COLOR.YELLOW:Colorize("Quest in: "), PAC.COLOR.ORANGE:Colorize("Die Stadt der Uhrwerke"), "\nWenn EINgeschaltet werden folgende Plunder Gegenstände NICHT als Trödel markiert:\n[***Elemental Essence***]\n[***Supple Roots***]\n[Ektoplasma]"}), 1)-- TODO: itemnames

SafeAddString(SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK, table.concat({"Markiere [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] Gegenstände"}), 1)
SafeAddString(SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK_T, table.concat({"Automatisch Gegenstände mit der Indikation [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] als Trödel markieren?"}), 1)

SafeAddString(SI_PA_MENU_JUNK_TREASURES_AUTOMARK, table.concat({"Markiere [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] Gegenstände"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TREASURES_AUTOMARK_T, table.concat({"Automatisch Gegenstände vom Typ [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] als Trödel markieren?"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TREASURES_EXCLUDE_ITEMS_DESC, table.concat({"Markiere [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] Gegenstände NICHT als Trödel wenn . . ."}), 1)
SafeAddString(SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_LEISURE, table.concat({"> für tägl. Quest ", PAC.COLOR.YELLOW:Colorize("Eine Frage der Muße"), " benötigt"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_LEISURE_T, table.concat({PAC.COLOR.YELLOW:Colorize("Quest in: "), PAC.COLOR.ORANGE:Colorize("Die Stadt der Uhrwerke"), "\nWenn EINgeschaltet werden folgende Beute Gegenstände NICHT als Trödel markiert:\n[Kinderspielzeug]\n[Puppen]\n[Spiele]"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_RESPECT, table.concat({"> für tägl. Quest ", PAC.COLOR.YELLOW:Colorize("Eine Frage des Respekts"), " benötigt"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_RESPECT_T, table.concat({PAC.COLOR.YELLOW:Colorize("Quest in: "), PAC.COLOR.ORANGE:Colorize("Die Stadt der Uhrwerke"), "\nWenn EINgeschaltet werden folgende Beute Gegenstände NICHT als Trödel markiert:\n[Utensilien]\n[Trinkgefäße]\n[Teller und Kochgeschirr]"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_TRIBUTES, table.concat({"> für tägl. Quest ", PAC.COLOR.YELLOW:Colorize("Eine Frage des Tributs"), " benötigt"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_TRIBUTES_T, table.concat({PAC.COLOR.YELLOW:Colorize("Quest in: "), PAC.COLOR.ORANGE:Colorize("Die Stadt der Uhrwerke"), "\nWenn EINgeschaltet werden folgende Beute Gegenstände NICHT als Trödel markiert:\n[Kosmetika]\n[Körperpflegegegenstände]"}), 1)

-- Custom Items --
SafeAddString(SI_PA_MENU_JUNK_CUSTOM_ITEMS_HEADER, "Benutzerdefinierte Gegenstände", 1)
SafeAddString(SI_PA_MENU_JUNK_CUSTOM_ITEMS_DESCRIPTION, table.concat({GetString(SI_PA_MENU_RULES_HOW_TO_ADD_PAJ), "\n\n", GetString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU)}), 1)

-- Auto-Destroy --
SafeAddString(SI_PA_MENU_JUNK_AUTO_DESTORY_JUNK_HEADER, "Trödel direkt zerstören", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK, "Direktes Zerstören von wertlosem Trödel", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_T, "Wenn ein wertloser Gegenstand (Verkaufswert = 0g) eingesammelt wird der automatisch als Trödel markiert würde, dann wird wenn EINgeschaltet dieser Gegenstand stattdessen zerstört. Einmal zerstört kann der Gegenstand nicht zurückgeholt werden!", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_W, "ACHTUNG: Bitte beachte dass bei Verwendung von dieser Einstellung KEINE Sicherheitsfrage kommt ob der Gegenstand wirklich zerstört werden soll.\nEr wird einfach direkt zerstört!\nUnwiderruflich!\nNutzung erfolgt auf eigenes Risiko!", 1)

-- Other Settings --
SafeAddString(SI_PA_MENU_JUNK_AUTOSELL_JUNK, "Trödel direkt an Händler und Hehler verkaufen?", 1)

SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_HEADER, "Tastenkürzel", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_JUNK_ENABLE, "Tastenkürzel \"Als Trödel de- / markieren\" aktivieren", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_JUNK_SHOW, "Tastenkürzel \"Als Trödel de- / markieren\" anzeigen", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_ENABLE, "Tastenkürzel \"Gegenstand zerstören\" aktivieren", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_ENABLE_W, "ACHTUNG: Bitte beachte dass bei Verwendung von diesem Tastenkürzel KEINE Sicherheitsfrage kommt ob der Gegenstand wirklich zerstört werden soll.\nEr wird einfach direkt zerstört!\nUnwiderruflich!\nNutzung erfolgt auf eigenes Risiko!", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_SHOW, "Tastenkürzel \"Gegenstand zerstören\" anzeigen", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_EXCLUDE_DESCRIPTION, "Deaktiviere den \"Gegenstand zerstören\" Tastenkürzel wenn der Gegenstand . . .", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_QUALITY_THRESHOLD, "> von der ausgewählten oder höheren Qualität ist", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_UNKNOWN, "> gelernt/analysiert werden kann und unbekannt ist", 1)

-- General texts used across: Weapons, Armor, Jewelry
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD, "Markiere %s mit Qualität tiefer oder gleich", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD_T, "Automatisch %s als Trödel markieren wenn deren Qualität genau auf oder unter der ausgewählten Qualität liegt", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE, table.concat({"Markiere %s mit Eigenschaft [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "]"}), 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T, table.concat({"Automatisch %s mit der Eigenschaft [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "] (erhöhter Verkaufspreis) als Trödel markieren?"}), 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS, "Markiere auch %s von einem Set", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS_T, "Wenn AUSgeschaltet, dann werden nur %s die NICHT zu einem Set gehören als Trödel markiert", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_INTRICATE, table.concat({"Markiere auch %s mit Eigenschaft [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE),"]"}),1 )
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_INTRICATE_T, table.concat({"Wenn AUSgeschaltet, dann werden %s mit der Eigenschaft [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE),"] NICHT als Trödel markiert (unabhängig von der Qualität)"}), 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS, "Markiere %s mit unbekannten Eigenschaften", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T, "Wenn AUSgeschaltet, dann werden nur %s ohne Eigenschaften oder mit bereits analysierten Eigenschaften als Trödel markiert", 1)


-- =================================================================================================================
-- == MAIN MENU TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk --
SafeAddString(SI_PA_MAINMENU_JUNK_HEADER, "Trödel Regeln", 1)

SafeAddString(SI_PA_MAINMENU_JUNK_HEADER_ITEM, "Gegenstand", 1)
SafeAddString(SI_PA_MAINMENU_JUNK_HEADER_JUNK_COUNT, "Anzahl", 1)
SafeAddString(SI_PA_MAINMENU_JUNK_HEADER_LAST_JUNK, "Letzter Trödel", 1)
SafeAddString(SI_PA_MAINMENU_JUNK_HEADER_RULE_ADDED, "Regel erstellt", 1)
SafeAddString(SI_PA_MAINMENU_JUNK_HEADER_ACTIONS, "Aktionen", 1)

SafeAddString(SI_PA_MAINMENU_JUNK_ROW_NEVER_JUNKED, "niemals", 1)


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk --
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TRASH, table.concat({"%s als Trödel markiert (", PAC.COLOR.ORANGE:Colorize(GetString("SI_ITEMTYPE", ITEMTYPE_TRASH)), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_ORNATE, table.concat({"%s als Trödel markiert (", PAC.COLOR.ORANGE:Colorize(GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE)), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY, table.concat({"%s als Trödel markiert (", PAC.COLOR.ORANGE:Colorize("Qualität"), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_MERCHANT, table.concat({"%s als Trödel markiert (", PAC.COLOR.ORANGE:Colorize("Händler"), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TREASURE, table.concat({"%s als Trödel markiert (", PAC.COLOR.ORANGE:Colorize("Beute"), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_KEYBINDING, table.concat({"%s als Trödel markiert (", PAC.COLOR.ORANGE:Colorize("Manuell"), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_PERMANENT, table.concat({"%s als Trödel markiert (", PAC.COLOR.ORANGE:Colorize("Perm-Regel"), ")"}), 1)

SafeAddString(SI_PA_CHAT_JUNK_DESTROYED_KEYBINDING, table.concat({PAC.COLOR.ORANGE_RED:Colorize("Zerstört"), " %d x %s"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_DESTROYED_WORTHLESS, table.concat({PAC.COLOR.ORANGE_RED:Colorize("Zerstört"), " %d x %s (", PAC.COLOR.ORANGE:Colorize("Wertlos"), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_DESTROY_WORTHLESS_ON, table.concat({"Direktes Zerstören von wertlosem Trödel wurde ", PAC.COLOR.RED:Colorize("EIN"), "geschalten"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_DESTROY_WORTHLESS_OFF, table.concat({"Direktes Zerstören von wertlosem Trödel wurde ", PAC.COLOR.GREEN:Colorize("AUS"), "geschalten"}), 1)

SafeAddString(SI_PA_CHAT_JUNK_SOLD_ITEMS_INFO, "Gegenstände verkauft für %s", 1)
SafeAddString(SI_PA_CHAT_JUNK_FENCE_LIMIT_HOURS, table.concat({GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Bitte warte ~%d Stunden"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_FENCE_LIMIT_MINUTES, table.concat({GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Bitte warte ~%d Minuten"}), 1)
--SafeAddString(SI_PA_CHAT_JUNK_FENCE_ITEM_WORTHLESS, table.concat({"Kann %s nicht verkaufen. ", GetString("SI_STOREFAILURE", STORE_FAILURE_WORTHLESS_TO_FENCE)}), 1)

SafeAddString(SI_PA_CHAT_JUNK_RULES_ADDED, table.concat({"%s zur Liste permanenten Trödels ", PAC.COLOR.ORANGE:Colorize("hinzugefügt"), "!"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_RULES_DELETED, table.concat({"%s von der Liste permanenten Trödels ", PAC.COLOR.ORANGE:Colorize("entfernt"), "!"}), 1)


-- =================================================================================================================
-- == KEY BINDINGS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk --
SafeAddString(SI_BINDING_NAME_PA_JUNK_TOGGLE_ITEM, "Als Trödel de- / markieren", 1)
SafeAddString(SI_BINDING_NAME_PA_JUNK_DESTROY_ITEM, "Gegenstand zerstören", 1)


-- =================================================================================================================
-- == OTHER STRINGS == --
-- -----------------------------------------------------------------------------------------------------------------
-- Quest: "A Matter of Leisure"
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_TOYS, "Kinderspielzeug", 1)
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_DOLLS, "Puppen", 1)
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_GAMES, "Spiele", 1)

-- Quest: "A Matter of Respect"
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_UTENSILS, "Utensilien", 1)
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_DRINKWARE, "Trinkgefäße", 1)
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_DISHES_COOKWARE, "Teller und Kochgeschirr", 1)

-- Quest: "A Matter of Tributes"
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_COSMETICS, "Kosmetika", 1)
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_GROOMING, "Körperpflegegegenstände", 1)