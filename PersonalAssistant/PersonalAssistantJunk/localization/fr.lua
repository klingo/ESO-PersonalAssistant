local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk Menu --
SafeAddString(SI_PA_MENU_JUNK_DESCRIPTION, "PAJunk peut marquer des objets comme rebuts s'ils remplissent l'une des conditions possible ; exceptés s'ils ont été fait en artisanat ou récupérés du courrier", 1)

-- Standard Items --
SafeAddString(SI_PA_MENU_JUNK_STANDARD_ITEMS_HEADER, "Objets standards", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTOMARK_ENABLE, "Marquer automatiquement comme rebuts", 1)

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

-- Custom Items --
SafeAddString(SI_PA_MENU_JUNK_CUSTOM_ITEMS_HEADER, "Objets personnalisés", 1)
SafeAddString(SI_PA_MENU_JUNK_CUSTOM_ITEMS_DESCRIPTION, table.concat({GetString(SI_PA_MENU_RULES_HOW_TO_ADD_PAJ), "\n\n", GetString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU)}), 1)

-- Auto-Destroy --
SafeAddString(SI_PA_MENU_JUNK_AUTO_DESTORY_JUNK_HEADER, "Détruire automatiquement les rebuts", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK, "Détruire automatiquement les rebuts sans valeur", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_T, "Lors du butin, si un objet est mis aux rebuts et n'a aucune valeur (revente pour 0 pièce), il sera détruit si cette option est activée. Ceci ne peut être annulé !", 1)
SafeAddString(SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_W, "ATTENTION: Soyez conscient en utilisant cette option, il n'y a PAS de fenêtre de confirmation qui s'ouvrira pour permettre de confirmer que l'objet doit être vraiment détruit.\nIl sera immédiatement détruit !\nPour toujours !\nUtilisez à vos risques et périls !", 1)

-- Other Settings --
SafeAddString(SI_PA_MENU_JUNK_AUTOSELL_JUNK, "Vente/Recel auto. des rebuts aux marchands", 1)

SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_HEADER, "Commandes", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_JUNK_ENABLE, "Activer la commande \"Mettre aux / Sortir des rebuts\"", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_JUNK_SHOW, "Afficher la commande \"Mettre aux / Sortir des rebuts\"", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_ENABLE, "Activer la commande \"Détruire l'objet\"", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_ENABLE_W, "ATTENTION: Soyez conscient en utilisant cette commande, il n'y a PAS de fenêtre de confirmation qui s'ouvrira pour permettre de confirmer que l'objet doit être vraiment détruit.\nIl sera immédiatement détruit !\nPour toujours !\nUtilisez à vos risques et périls !", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_SHOW, "Afficher la commande \"Détruire l'objet\"", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_EXCLUDE_DESCRIPTION, "Désactiver la commande  \"Détruire l'objet\" si l'objet . . .", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_QUALITY_THRESHOLD, "> est de qualité supérieure ou égale à", 1)
SafeAddString(SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_UNKNOWN, "> peut-être appris/recherché et est inconnu", 1)

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
-- == MAIN MENU TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk --
SafeAddString(SI_PA_MAINMENU_JUNK_HEADER, "Règles de mise aux rebuts", 1)

SafeAddString(SI_PA_MAINMENU_JUNK_HEADER_ITEM, "Objet ciblé par la règle", 1)
SafeAddString(SI_PA_MAINMENU_JUNK_HEADER_JUNK_COUNT, "Nb. d'usages", 1)
SafeAddString(SI_PA_MAINMENU_JUNK_HEADER_LAST_JUNK, "Dernier usage", 1)
SafeAddString(SI_PA_MAINMENU_JUNK_HEADER_RULE_ADDED, "Créée depuis", 1)
SafeAddString(SI_PA_MAINMENU_JUNK_HEADER_ACTIONS, "Gérer", 1)

SafeAddString(SI_PA_MAINMENU_JUNK_ROW_NEVER_JUNKED, "Jamais", 1)


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk --
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TRASH, table.concat({"%s mis aux rebuts (", PAC.COLOR.ORANGE:Colorize(GetString("SI_ITEMTYPE", ITEMTYPE_TRASH)), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_ORNATE, table.concat({"%s mis aux rebuts (", PAC.COLOR.ORANGE:Colorize(GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE)), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY, table.concat({"%s mis aux rebuts (", PAC.COLOR.ORANGE:Colorize("qualité"), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_MERCHANT, table.concat({"%s mis aux rebuts (", PAC.COLOR.ORANGE:Colorize("Marchand"), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TREASURE, table.concat({"%s mis aux rebuts (", PAC.COLOR.ORANGE:Colorize("Trésor"), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_KEYBINDING, table.concat({"%s mis aux rebuts (", PAC.COLOR.ORANGE:Colorize("Manuel"), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_MARKED_AS_JUNK_PERMANENT, table.concat({"%s mis aux rebuts (", PAC.COLOR.ORANGE:Colorize("Rebut permanent"), ")"}), 1)

SafeAddString(SI_PA_CHAT_JUNK_DESTROYED_KEYBINDING, table.concat({PAC.COLOR.ORANGE_RED:Colorize("Détruit"), " %d x %s"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_DESTROYED_WORTHLESS, table.concat({PAC.COLOR.ORANGE_RED:Colorize("Détruit"), " %d x %s (", PAC.COLOR.ORANGE:Colorize("Sans valeur"), ")"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_DESTROY_WORTHLESS_ON, table.concat({"La destruction automatique des rebuts sans valeur a été changée en ", PAC.COLOR.RED:Colorize("OUI")}), 1)
SafeAddString(SI_PA_CHAT_JUNK_DESTROY_WORTHLESS_OFF, table.concat({"La destruction automatique des rebuts sans valeur a été changée en ", PAC.COLOR.GREEN:Colorize("NON")}), 1)

SafeAddString(SI_PA_CHAT_JUNK_SOLD_ITEMS_INFO, "Objets vendus pour %s", 1)
SafeAddString(SI_PA_CHAT_JUNK_FENCE_LIMIT_HOURS, table.concat({GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Veuillez attendre ~%d heures"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_FENCE_LIMIT_MINUTES, table.concat({GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), " Veuillez attendre ~%d minutes"}), 1)
--SafeAddString(SI_PA_CHAT_JUNK_FENCE_ITEM_WORTHLESS, table.concat({"Impossible de vendre %s. ", GetString("SI_STOREFAILURE", STORE_FAILURE_WORTHLESS_TO_FENCE)}), 1)

SafeAddString(SI_PA_CHAT_JUNK_RULES_ADDED, table.concat({"%s a été ", PAC.COLOR.ORANGE:Colorize("ajouté"), " à la liste des rebuts permanents!"}), 1)
SafeAddString(SI_PA_CHAT_JUNK_RULES_DELETED, table.concat({"%s a été ", PAC.COLOR.ORANGE:Colorize("retiré"), " de la liste des rebuts permanents!"}), 1)


-- =================================================================================================================
-- == KEY BINDINGS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAJunk --
SafeAddString(SI_BINDING_NAME_PA_JUNK_TOGGLE_ITEM, "Mettre aux / Sortir des rebuts", 1)
SafeAddString(SI_BINDING_NAME_PA_JUNK_DESTROY_ITEM, "Détruire l'objet", 1)


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