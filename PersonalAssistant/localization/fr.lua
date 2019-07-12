local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- Welcome Messages --
SafeAddString(SI_PA_WELCOME_NO_SUPPORT, table.concat({PAC.COLORS.DEFAULT, " à votre service !   -   La traduction pour le language [%s] n'est pas (encore) disponible"}), 1)
SafeAddString(SI_PA_WELCOME_SUPPORT, table.concat({PAC.COLORS.DEFAULT, " à votre service !"}), 1)
SafeAddString(SI_PA_WELCOME_PLEASE_SELECT_PROFILE, table.concat({PAC.COLORS.DEFAULT, " vous souhaite la bienvenue ! Pour commencer, veuillez aller dans les réglages d'extensions (ou taper ",PAC.COLORS.WHITE,"/pa", PAC.COLORS.DEFAULT, ") afin de sélectionner un profil. Merci :-)"}), 1)

SafeAddString(SI_PA_LAM_OUTDATED, table.concat({PAC.COLORS.ORANGE_RED, " nécessite une version plus récente de '", PAC.COLORS.WHITE, "LibAddonMenu-2.0", PAC.COLORS.ORANGE_RED, "' que celle qui est installée actuellement. Merci de télécharger et faire la mise à jour vers la dernière version sur ", PAC.COLORS.WHITE, "http://esoui.com"}), 1)


-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
SafeAddString(SI_PA_MENU_GENERAL_DESCRIPTION, "PersonalAssistant est un ensemble de fonctionnalités diverses qui ont pour but de vous rendre le jeu ESO plus agréable", 1)

-- Profiles --
SafeAddString(SI_PA_MENU_PROFILE_HEADER, "Profils", 1)
SafeAddString(SI_PA_MENU_PROFILE_PLEASE_SELECT, "<Sélectionner un profil>", 1)
SafeAddString(SI_PA_MENU_PROFILE_ACTIVE, "Profil actif", 1)
SafeAddString(SI_PA_MENU_PROFILE_ACTIVE_T, "Selectionner le profil actif pour PersonalAssistant. Il chargera automatiquement tous les paramètres stockés sous ce profil, et enregistrera les changements au même endroit.", 1)
SafeAddString(SI_PA_MENU_PROFILE_ACTIVE_RENAME, "Renommer le profil actif", 1)

-- Integrations --

-- General --
SafeAddString(SI_PA_MENU_GENERAL_SHOW_WELCOME, "Afficher le message d'accueil", 1)
SafeAddString(SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE, table.concat({PAC.ICONS.OTHERS.HOME.NORMAL, " Aller à la maison"}), 1)
SafeAddString(SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE_W, "Si la position actuelle permet un voyage rapide, cela lancera la téléportation vers votre maison primaire !", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Rules Menu --
SafeAddString(SI_PA_MENU_RULES_HOW_TO_ADD_PAB, "Pour créer une nouvelle règle de dépôt ou retrait d'objets, il suffit de cliquer droit sur un objet dans votre inventaire ou en banque, et de sélectionner dans le menu contextuel :\n> PA Banking > Ajouter une nouvelle règle", 1)
SafeAddString(SI_PA_MENU_RULES_HOW_TO_ADD_PAJ, "Pour créer une nouvelle règle de mise aux rebuts permanente, il suffit de cliquer droit sur un objet dans votre inventaire ou en banque, et de sélectionner dans le menu contextuel :\n> PA Junk > Marquer en tant que rebut permanent", 1)
SafeAddString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU, "Toutes les règles actives peuvent être retrouvées en cliquant sur l'icône qui se trouve dans le menu principal, en tapant ", PAC.COLOR.YELLOW:Colorize("/parules"), " ou en cliquant sur ce bouton :", 1)
SafeAddString(SI_PA_MENU_RULES_HOW_TO_CREATE, "Comment créer de nouvelles règles?", 1)

SafeAddString(SI_PA_MENU_DANGEROUS_SETTING, "ATTENTION : Paramètres dangereux ! Utilisez à vos risques et périls !", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Generic Menu --
SafeAddString(SI_PA_MENU_OTHER_SETTINGS_HEADER, "Autres paramètres", 1)

SafeAddString(SI_PA_MENU_SILENT_MODE, "Mode silencieux (Ne RIEN afficher dans le chat)", 1)

SafeAddString(SI_PA_MENU_NOT_YET_IMPLEMENTED, "Pas encore implémenté !", 1)


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAGeneral --
SafeAddString(SI_PA_CHAT_GENERAL_ACTIVE_PROFILE_ACTIVE, table.concat({PAC.COLORS.DEFAULT, " profil actif: ", PAC.COLORS.ORANGE_RED, "%s"}), 1)


-- =================================================================================================================
-- == OTHER STRINGS FOR MENU == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAGeneral --
SafeAddString(SI_PA_PROFILE, "Profil", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Name Spaces --
SafeAddString(SI_PA_NS_BAG_EQUIPMENT, "Équipement", 1) -- not required so far
SafeAddString(SI_PA_NS_BAG_BACKPACK, "Inventaire", 1)
SafeAddString(SI_PA_NS_BAG_BANK, "Banque", 1)
SafeAddString(SI_PA_NS_BAG_SUBSCRIBER_BANK, "Sac d'artisanat", 1)
SafeAddString(SI_PA_NS_BAG_UNKNOWN, "Inconnu", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- ItemTypes (Custom Singluar/Plural definition) --
SafeAddString(SI_PA_ITEMTYPE4, "<<1[Nourriture/Nourriture]>>", 1)
SafeAddString(SI_PA_ITEMTYPE5, "<<1[Trophées/Trophées]>>", 1)
SafeAddString(SI_PA_ITEMTYPE7, "<<1[Potion/Potions]>>", 1)
SafeAddString(SI_PA_ITEMTYPE8, "<<1[Motif/Motifs]>>", 1)
SafeAddString(SI_PA_ITEMTYPE12, "<<1[Boisson/Boissons]>>", 1)
SafeAddString(SI_PA_ITEMTYPE19, "<<1[Pierre d'Âme/Pierres d'Âme]>>", 1)
SafeAddString(SI_PA_ITEMTYPE22, "<<1[Crochetage/Crochetages]>>", 1)
SafeAddString(SI_PA_ITEMTYPE29, "<<1[Recette/Recettes]>>", 1)
SafeAddString(SI_PA_ITEMTYPE30, "<<1[Poison/Poisons]>>", 1)
SafeAddString(SI_PA_ITEMTYPE34, "<<1[Objet de collection/Objets de collection]>>", 1)
SafeAddString(SI_PA_ITEMTYPE60, "<<1[Commande de maître/Commandes de maître]>>", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Master Writs based on CraftingType (Custom definition) --
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE0, table.concat({"Autres commandes (", GetString("SI_ENCHANTMENTSEARCHCATEGORYTYPE", ENCHANTMENT_SEARCH_CATEGORY_OTHER), ")"}), 1)
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE1, "Commande de forge scellée", 1)
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE2, "Commande scellée de couture", 1)
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE3, "Commande d'enchantement scellée", 1)
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE4, "Commande scellée d'alchimie", 1)
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE5, "Commande scellée de cuisine", 1)
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE6, "Commande de travail du bois scellée", 1)
SafeAddString(SI_PA_MASTERWRIT_CRAFTINGTYPE7, "Commande scellée de joaillier", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- PABanking --
SafeAddString(SI_PA_BANKING_MOVE_MODE_DONOTHING, "Ne rien faire", 1)
SafeAddString(SI_PA_BANKING_MOVE_MODE_TOBANK, "Déposer en banque", 1)
SafeAddString(SI_PA_BANKING_MOVE_MODE_TOBACKPACK, "Prendre dans le sac", 1)

SafeAddString(SI_PA_MENU_BANKING_ADVANCED_INTRICATE_ITEMS, "Objets complexes", 1)

SafeAddString(SI_PA_MENU_BANKING_REPAIRKIT, "Nécessaires de réparation", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Operators --
SafeAddString(SI_PA_REL_OPERATOR_T, "Sélectionner l'opérateur mathématique pour cet objet", 1)
SafeAddString(SI_PA_REL_BACKPACK_EQUAL, "INVENTAIRE ==", 1)
SafeAddString(SI_PA_REL_BACKPACK_LESSTHAN, "INVENTAIRE <", 1) -- not used so far
SafeAddString(SI_PA_REL_BACKPACK_LESSTHANEQUAL, "INVENTAIRE <=", 1)
SafeAddString(SI_PA_REL_BACKPACK_GREATERTHAN, "INVENTAIRE >", 1) -- not used so far
SafeAddString(SI_PA_REL_BACKPACK_GREATERTHANEQUAL, "INVENTAIRE >=", 1)
SafeAddString(SI_PA_REL_BANK_EQUAL, "BANQUE ==", 1)
SafeAddString(SI_PA_REL_BANK_LESSTHAN, "BANQUE <", 1) -- not used so far
SafeAddString(SI_PA_REL_BANK_LESSTHANOREQUAL, "BANQUE <=", 1)
SafeAddString(SI_PA_REL_BANK_GREATERTHAN, "BANQUE >", 1) -- not used so far
SafeAddString(SI_PA_REL_BANK_GREATERTHANOREQUAL, "BANQUE >=", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Operator Tooltip --
SafeAddString(SI_PA_REL_BACKPACK_EQUAL_T, "INVENTAIRE égal (=)", 1)
SafeAddString(SI_PA_REL_BACKPACK_LESSTHAN_T, "INVENTAIRE inférieur à (<)", 1) -- not used so far
SafeAddString(SI_PA_REL_BACKPACK_LESSTHANOREQUAL_T, "INVENTAIRE inférieur ou égal à (<=)", 1)
SafeAddString(SI_PA_REL_BACKPACK_GREATERTHAN_T, "INVENTAIRE supérieur à (>)", 1) -- not used so far
SafeAddString(SI_PA_REL_BACKPACK_GREATERTHANOREQUAL_T, "INVENTAIRE supérieur ou égal à (>=)", 1)
SafeAddString(SI_PA_REL_BANK_EQUAL_T, "BANQUE égal (=)", 1)
SafeAddString(SI_PA_REL_BANK_LESSTHAN_T, "BANQUE inférieur à (<)", 1) -- not used so far
SafeAddString(SI_PA_REL_BANK_LESSTHANOREQUAL_T, "BANQUE inférieur ou égal à (<=)", 1)
SafeAddString(SI_PA_REL_BANK_GREATERTHAN_T, "BANQUE supérieur à (>)", 1) -- not used so far
SafeAddString(SI_PA_REL_BANK_GREATERTHANOREQUAL_T, "BANQUE supérieur ou égal à (>=)", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Stacking types --
SafeAddString(SI_PA_ST_MOVE_FULL, "Tout déplacer", 1)
SafeAddString(SI_PA_ST_MOVE_INCOMPLETE_STACKS_ONLY, "N'ajouter qu'aux piles existantes", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Icon Positions --
SafeAddString(SI_PA_POSITION_AUTO, "Automatique", 1)
SafeAddString(SI_PA_POSITION_TOPLEFT, "Haut gauche", 1)
SafeAddString(SI_PA_POSITION_TOPRIGHT, "Haut droite", 1)
SafeAddString(SI_PA_POSITION_BOTTOMLEFT, "Bas gauche", 1)
SafeAddString(SI_PA_POSITION_BOTTOMRIGHT, "Bas droite", 1)


-- =================================================================================================================
-- == CUSTOM SUB MENU == --
-- -----------------------------------------------------------------------------------------------------------------
SafeAddString(SI_PA_SUBMENU_PAB_ADD_RULE, "Ajouter une nouvelle règle", 1)
SafeAddString(SI_PA_SUBMENU_PAB_EDIT_RULE, "Éditer une règle", 1)
SafeAddString(SI_PA_SUBMENU_PAB_DELETE_RULE, "Supprimer une règle", 1)
SafeAddString(SI_PA_SUBMENU_PAB_ADD_RULE_BUTTON, "Ajouter", 1)
SafeAddString(SI_PA_SUBMENU_PAB_UPDATE_RULE_BUTTON, "Sauvegarder", 1)
SafeAddString(SI_PA_SUBMENU_PAB_DELETE_RULE_BUTTON, "Supprimer", 1)
SafeAddString(SI_PA_SUBMENU_PAB_NO_RULES, "Aucune règle de mise en banque définie", 1)
SafeAddString(SI_PA_SUBMENU_PAB_DISCLAIMER, "Note: Ces règles de mise en banque seront exécutées après toutes les autres règles de mise en banque automatiques (Artisanat, Spécial, Objets AvA).", 1)

SafeAddString(SI_PA_SUBMENU_PAJ_MARK_PERM_JUNK, "Marquer en tant que rebut permanent", 1)
SafeAddString(SI_PA_SUBMENU_PAJ_UNMARK_PERM_JUNK, "Ne plus marquer en tant que rebut permanent", 1)
SafeAddString(SI_PA_SUBMENU_PAJ_NO_RULES, "Aucune règle de mise aux rebuts définie", 1)


-- =================================================================================================================
-- == KEY BINDINGS == --
-- -----------------------------------------------------------------------------------------------------------------
SafeAddString(SI_KEYBINDINGS_CATEGORY_PA_PROFILES, "|cFFD700P|rersonal|cFFD700A|rssistant Profils", 1)
SafeAddString(SI_KEYBINDINGS_CATEGORY_PA_MENU, "Menu de |cFFD700P|rersonal|cFFD700A|rssistant", 1)

SafeAddString(SI_BINDING_NAME_PA_RULES_MAIN_MENU, "Règles de PersonalAssistant", 1)
SafeAddString(SI_BINDING_NAME_PA_RULES_TOGGLE_WINDOW, "Afficher/Cacher le menu des règles de mise en banque et aux rebuts", 1)

SafeAddString(SI_KEYBINDINGS_PA_LOAD_PROFILE, "Activer le profil", 1)


-- =================================================================================================================
-- Overriding the ItemFilterTypes because they are wrong in French --
-- -----------------------------------------------------------------------------------------------------------------
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_CLOTHING, "Coûture", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ENCHANTING, "Enchantement", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_FURNISHING, "Ameublement", 1)
