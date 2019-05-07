local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk Menu --
SafeAddString(SI_PA_MENU_JUNK_DESCRIPTION, "PAJunk kann Gegenstände als Trödel markieren wenn unten auswählbare Bedingungen eintreffen; ausser wenn es gerade hergestellt oder aus aus einer Nachricht entnommen wurde", 1)

SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Aktiviere das Markieren als Trödel"}), 1)

SafeAddString(SI_PA_MENU_JUNK_TRASH_AUTOMARK, table.concat({"Markiere [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] Gegenstände"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_AUTOMARK_T, table.concat({"Automatisch Gegenstände vom Typ [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] als Trödel markieren?"}), 1)

SafeAddString(SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK, table.concat({"Markiere [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] Gegenstände"}), 1)
SafeAddString(SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK_T, table.concat({"Automatisch Gegenstände mit der Indikation [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] als Trödel markieren?"}), 1)

SafeAddString(SI_PA_MENU_JUNK_TREASURES_AUTOMARK, table.concat({"Markiere [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] Gegenstände"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TREASURES_AUTOMARK_T, table.concat({"Automatisch Gegenstände vom Typ [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] als Trödel markieren?"}), 1)

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