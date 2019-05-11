local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk Menu --
SafeAddString(SI_PA_MENU_JUNK_DESCRIPTION, "PAJunk kann Gegenstände als Trödel markieren wenn unten auswählbare Bedingungen eintreffen; ausser wenn es gerade hergestellt oder aus aus einer Nachricht entnommen wurde", 1)

SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Aktiviere das Markieren als Trödel"}), 1)

SafeAddString(SI_PA_MENU_JUNK_TRASH_AUTOMARK, table.concat({"Markiere [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] Gegenstände"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_AUTOMARK_T, table.concat({"Automatisch Gegenstände vom Typ [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] als Trödel markieren?"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_ITEMS_DESC, table.concat({"Markiere [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] Gegenstände NICHT als Trödel wenn . . ."}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS, table.concat({"> für tägl. Quest ", PAC.COLOR.YELLOW:Colorize("Stückchen und Häppchen"), " benötigt"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS_T, table.concat({PAC.COLOR.YELLOW:Colorize("Quest in: "), PAC.COLOR.ORANGE:Colorize("Die Stadt der Uhrwerke"), "\nWenn EINgeschaltet werden folgende Plunder Gegenstände NICHT als Trödel markiert:\n[Panzer]\n[Verdorbenes Fell]\n[***Daedra Husks***]"}), 1) -- TODO: itemnames
SafeAddString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS, table.concat({"> für tägl. Quest ", PAC.COLOR.YELLOW:Colorize("Bröckchen und Bisschen"), " benötigt"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS_T, table.concat({PAC.COLOR.YELLOW:Colorize("Quest in: "), PAC.COLOR.ORANGE:Colorize("Die Stadt der Uhrwerke"), "\nWenn EINgeschaltet werden folgende Plunder Gegenstände NICHT als Trödel markiert:\n[***Elemental Essence***]\n[***Supple Roots***]\n[***Ectoplasm***]"}), 1)-- TODO: itemnames

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

SafeAddString(SI_PA_MENU_JUNK_AUTOSELL_JUNK, "Trödel direkt an Händler und Hehler verkaufen?", 1)

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
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk --
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TRASH, table.concat({PAC.COLORED_TEXTS.PAJ, "%s als Trödel markiert (", PAC.COLORS.ORANGE, GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), PAC.COLORS.DEFAULT, ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_ORNATE, table.concat({PAC.COLORED_TEXTS.PAJ, "%s als Trödel markiert (", PAC.COLORS.ORANGE, GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), PAC.COLORS.DEFAULT, ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY, table.concat({PAC.COLORED_TEXTS.PAJ, "%s als Trödel markiert (", PAC.COLORS.ORANGE, "Qualität", PAC.COLORS.DEFAULT, ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_MERCHANT, table.concat({PAC.COLORED_TEXTS.PAJ, "%s als Trödel markiert (", PAC.COLORS.ORANGE, "Händler", PAC.COLORS.DEFAULT, ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TREASURE, table.concat({PAC.COLORED_TEXTS.PAJ, "%s als Trödel markiert (", PAC.COLORS.ORANGE, "Beute", PAC.COLORS.DEFAULT, ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_KEYBINDING, table.concat({PAC.COLORED_TEXTS.PAJ, "%s als Trödel markiert (", PAC.COLORS.ORANGE, "Manuell", PAC.COLORS.DEFAULT, ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_SOLD_JUNK_INFO, table.concat({PAC.COLORED_TEXTS.PAJ, "Trödel verkauft für ", PAC.COLORS.GREEN, "%d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}), 1)
SafeAddString(SI_PA_CHAT_JUNK_FENCE_LIMIT_HOURS, table.concat({PAC.COLORED_TEXTS.PAJ, GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Bitte warte ~%d Stunden"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_FENCE_LIMIT_MINUTES, table.concat({PAC.COLORED_TEXTS.PAJ, GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Bitte warte ~%d Minuten"}), 1)


-- =================================================================================================================
-- == KEY BINDINGS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk --
SafeAddString(SI_BINDING_NAME_PA_JUNK_TOGGLE_ITEM, "Als Trödel de- / markieren", 1)


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