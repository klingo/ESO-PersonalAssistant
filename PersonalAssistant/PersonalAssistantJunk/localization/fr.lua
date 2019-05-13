local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk Menu --
SafeAddString(SI_PA_MENU_JUNK_DESCRIPTION, "PAJunk peut marquer des objets comme rebuts s'ils remplissent l'une des conditions possible ; exceptés s'ils ont été fait en artisanat ou récupérés du courrier", 1)

SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Marquer automatiquement comme rebuts"}), 1)

SafeAddString(SI_PA_MENU_JUNK_TRASH_AUTOMARK, table.concat({"Marquer les objets [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "]"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_AUTOMARK_T, table.concat({"Marquer les objets de type [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] comme rebuts ?"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_ITEMS_DESC, table.concat({"Ne PAS marquer comme rebuts les objets de type [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] si nécessaire . . ."}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS, table.concat({"> pour la quête journalière ", PAC.COLOR.YELLOW:Colorize("Petites bouchées")}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS_T, table.concat({PAC.COLOR.YELLOW:Colorize("Quête dans: "), PAC.COLOR.ORANGE:Colorize("La Cité mécanique"), "\nSi l'option est active, les objets camelote suivants ne seront PAS marqués comme rebuts:\n[Carapace]\n[Peau Infâme]\n[Enveloppe de Daedra]"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS, table.concat({"> pour la quête journalière ", PAC.COLOR.YELLOW:Colorize("Morceaux de choix")}), 1)
SafeAddString(SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS_T, table.concat({PAC.COLOR.YELLOW:Colorize("Quête dans: "), PAC.COLOR.ORANGE:Colorize("La Cité mécanique"), "\nSi l'option est active, les objets camelote suivants ne seront PAS marqués comme rebuts:\n[***Elemental Essence***]\n[***Supple Roots***]\n[Ectoplasme]"}), 1)-- TODO: itemnames

SafeAddString(SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK, table.concat({"Marquer les objets [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "]"}), 1)
SafeAddString(SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK_T, table.concat({"Marquer automatiquement les objets avec l'indicateur [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "] comme rebuts ?"}), 1)

SafeAddString(SI_PA_MENU_JUNK_TREASURES_AUTOMARK, table.concat({"Marquer les objets [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "]"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TREASURES_AUTOMARK_T, table.concat({"Marquer les objets de type [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] comme rebuts ?"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TREASURES_EXCLUDE_ITEMS_DESC, table.concat({"Ne PAS marquer comme rebuts les objets de type [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "] si nécessaire . . ."}), 1)
SafeAddString(SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_LEISURE, table.concat({"> pour la quête journalière ", PAC.COLOR.YELLOW:Colorize("Une affaire de loisirs")}), 1)
SafeAddString(SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_LEISURE_T, table.concat({PAC.COLOR.YELLOW:Colorize("Quête dans: "), PAC.COLOR.ORANGE:Colorize("La Cité mécanique"), "\nSi l'option est active, les objets trésor suivants ne seront PAS marqués comme rebuts:\n[Jouets d'enfants]\n[Poupées]\n[Jeux]"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_RESPECT, table.concat({"> pour la quête journalière ", PAC.COLOR.YELLOW:Colorize("Une histoire de respect")}), 1)
SafeAddString(SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_RESPECT_T, table.concat({PAC.COLOR.YELLOW:Colorize("Quête dans: "), PAC.COLOR.ORANGE:Colorize("La Cité mécanique"), "\nSi l'option est active, les objets trésor suivants ne seront PAS marqués comme rebuts:\n[Ustensiles]\n[Récipients à boire]\n[Plats et moules]"}), 1)
SafeAddString(SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_TRIBUTES, table.concat({"> pour la quête journalière ", PAC.COLOR.YELLOW:Colorize("Une affaire de tributs")}), 1)
SafeAddString(SI_PA_MENU_JUNK_TREASURES_EXCLUDE_A_MATTER_OF_TRIBUTES_T, table.concat({PAC.COLOR.YELLOW:Colorize("Quête dans: "), PAC.COLOR.ORANGE:Colorize("La Cité mécanique"), "\nSi l'option est active, les objets trésor suivants ne seront PAS marqués comme rebuts:\n[Produits cosmétiques]\n[Ustensiles de toilette]"}), 1)

SafeAddString(SI_PA_MENU_JUNK_AUTOSELL_JUNK, "Vente automatique aux marchands et receleurs", 1)

-- General texts used across: Weapons, Armor, Jewelry
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD, "Marquer les %s de qualité inférieure ou égale à", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD_T, "Marquer automatiquement comme rebuts les %s de qualité inférieure ou égale à celle sélectionnée", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE, table.concat({"Marquer les %s [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "]"}), 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T, table.concat({"Marquer automatiquement comme rebuts les %s avec le trait [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "] (prix de vente accru) ?"}), 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS, "Marquer même les %s d'un ensemble", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS_T, "Si désactivé, seuls les objets %s qui ne font PAS partie d'un ensemble seront marqués comme rebuts", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_INTRICATE, table.concat({"Marquer même les %s [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE), "]"}), 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_INTRICATE_T, table.concat({"Si désactivé, les %s [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE), "] ne seront PAS marqués comme rebuts (indépendamment de leur qualité)."}), 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS, "Marquer même les %s avec un trait inconnu", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T, "Si désactivé, seuls les objets %s sans traits ou au traits connus seront marqués comme rebuts", 1)


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk --
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TRASH, table.concat({PAC.COLORED_TEXTS.PAJ, "%s mis aux rebuts (", PAC.COLORS.ORANGE, GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), PAC.COLORS.DEFAULT, ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_ORNATE, table.concat({PAC.COLORED_TEXTS.PAJ, "%s mis aux rebuts (", PAC.COLORS.ORANGE, GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), PAC.COLORS.DEFAULT, ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY, table.concat({PAC.COLORED_TEXTS.PAJ, "%s mis aux rebuts (", PAC.COLORS.ORANGE, "qualité", PAC.COLORS.DEFAULT, ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_MERCHANT, table.concat({PAC.COLORED_TEXTS.PAJ, "%s mis aux rebuts (", PAC.COLORS.ORANGE, "Marchand", PAC.COLORS.DEFAULT, ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TREASURE, table.concat({PAC.COLORED_TEXTS.PAJ, "%s mis aux rebuts (", PAC.COLORS.ORANGE, "Trésor", PAC.COLORS.DEFAULT, ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_KEYBINDING, table.concat({PAC.COLORED_TEXTS.PAJ, "%s mis aux rebuts (", PAC.COLORS.ORANGE, "Manuel", PAC.COLORS.DEFAULT, ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_SOLD_JUNK_INFO, table.concat({PAC.COLORED_TEXTS.PAJ, "Vente des objets aux rebuts pour ", PAC.COLORS.GREEN, "%d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}), 1)
SafeAddString(SI_PA_CHAT_JUNK_FENCE_LIMIT_HOURS, table.concat({PAC.COLORED_TEXTS.PAJ, GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Veuillez attendre ~%d heures"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_FENCE_LIMIT_MINUTES, table.concat({PAC.COLORED_TEXTS.PAJ, GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Veuillez attendre ~%d minutes"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_FENCE_ITEM_WORTHLESS, table.concat({PAC.COLORED_TEXTS.PAJ, "Ne peut pas vendre %s. ", GetString("SI_STOREFAILURE", STORE_FAILURE_WORTHLESS_TO_FENCE)}), 1) -- TODO: to be verified by TAKIT


-- =================================================================================================================
-- == KEY BINDINGS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk --
SafeAddString(SI_BINDING_NAME_PA_JUNK_TOGGLE_ITEM, "Mettre aux / Sortir des rebuts", 1)


-- =================================================================================================================
-- == OTHER STRINGS == --
-- -----------------------------------------------------------------------------------------------------------------
-- Quest: "A Matter of Leisure"
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_TOYS, "Jouets d'enfants", 1)
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_DOLLS, "Poupées", 1)
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_GAMES, "Jeux", 1)

-- Quest: "A Matter of Respect"
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_UTENSILS, "Ustensiles", 1)
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_DRINKWARE, "Récipients à boire", 1)
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_DISHES_COOKWARE, "Plats et moules", 1)

-- Quest: "A Matter of Tributes"
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_COSMETICS, "Produits cosmétiques", 1)
SafeAddString(SI_PA_TREASURE_ITEM_TAG_DESC_GROOMING, "Ustensiles de toilette", 1)