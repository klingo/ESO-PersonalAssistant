local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk Menu --
SafeAddString(SI_PA_MENU_JUNK_DESCRIPTION, "PAJunk peut marquer des objets comme rebuts s'ils remplissent l'une des conditions possible ; exceptés s'ils ont été fait en artisanat ou récupérés du courrier", 1)

SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Marquer automatiquement comme rebuts"}), 1)

SafeAddString(SI_PA_MENU_JUNK_TRASH_AUTOMARK, table.concat({"Marquer les objets [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "]"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_AUTOMARK_T, table.concat({"Marquer les objets de type [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] comme rebuts ?"}), 1)

SafeAddString(SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK, table.concat({"Marquer les objets [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "]"}), 1)
SafeAddString(SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK_T, table.concat({"Marquer automatiquement les objets avec l'indicateur [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] comme rebuts ?"}), 1)

SafeAddString(SI_PA_MENU_JUNK_AUTOSELL_JUNK, "Vente automatique aux marchands et receleurs", 1)

-- General texts used across: Weapons, Armor, Jewelry
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD, "Marquer les %s de qualité inférieure ou égale à", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD_T, "Marquer automatiquement comme rebuts les %s de qualité inférieure ou égale à celle sélectionnée", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE, table.concat({"Marquer les %s [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "]"}), 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T, table.concat({"Marquer automatiquement comme rebuts les %s avec le trait [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "] (prix de vente accru) ?"}), 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS, "Marquer même s'il fait partie d'un ensemble", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS_T, "Si désactivé, seuls les objets %s qui ne font PAS partie d'un ensemble seront marqués comme rebuts", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS, "Marquer même s'il a un trait inconnu", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T, "Si désactivé, seuls les objets %s sans traits ou au traits connus seront marqués comme rebuts", 1)


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk --
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TRASH, table.concat({PAC.COLORED_TEXTS.PAJ, "%s mis aux rebuts (", PAC.COLORS.ORANGE, GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), PAC.COLORS.DEFAULT, ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_ORNATE, table.concat({PAC.COLORED_TEXTS.PAJ, "%s mis aux rebuts (", PAC.COLORS.ORANGE, GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), PAC.COLORS.DEFAULT, ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY, table.concat({PAC.COLORED_TEXTS.PAJ, "%s mis aux rebuts (", PAC.COLORS.ORANGE, "qualité", PAC.COLORS.DEFAULT, ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_MERCHANT, table.concat({PAC.COLORED_TEXTS.PAJ, "%s mis aux rebuts (", PAC.COLORS.ORANGE, "Marchand", PAC.COLORS.DEFAULT, ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_SOLD_JUNK_INFO, table.concat({PAC.COLORED_TEXTS.PAJ, "Vente des objets aux rebuts pour ", PAC.COLORS.GREEN, "%d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}), 1)
SafeAddString(SI_PA_CHAT_JUNK_FENCE_LIMIT_HOURS, table.concat({PAC.COLORED_TEXTS.PAJ, GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Veuillez attendre ~%d heures"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_FENCE_LIMIT_MINUTES, table.concat({PAC.COLORED_TEXTS.PAJ, GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Veuillez attendre ~%d minutes"}), 1)