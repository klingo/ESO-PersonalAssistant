local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- Welcome Messages --
SafeAddString(SI_PA_WELCOME_NO_SUPPORT, table.concat({PAC.COLORED_TEXTS.PA, PAC.COLORS.DEFAULT, " à votre service !   -   La traduction pour le language [%s] n'est pas (encore) disponible"}), 1)
SafeAddString(SI_PA_WELCOME_SUPPORT, table.concat({PAC.COLORED_TEXTS.PA, PAC.COLORS.DEFAULT, " à votre service !"}), 1)
SafeAddString(SI_PA_WELCOME_PLEASE_SELECT_PROFILE, table.concat({PAC.COLORED_TEXTS.PA, PAC.COLORS.DEFAULT, " vous souhaite la bienvenue ! Pour commencer, veuillez aller dans les réglages d'extensions (ou taper ",PAC.COLORS.WHITE,"/pa", PAC.COLORS.DEFAULT, ") afin de sélectionner un profil. Merci :-)"}), 1)

-- Key Bindings
SafeAddString(SI_PA_KB_LOAD_PROFILE, "Activer le profil", 1)


-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PAGeneral Menu --
SafeAddString(SI_PA_MENU_GENERAL_DESCRIPTION, "PersonalAssistant est un ensemble de fonctionnalités diverses qui ont pour but de vous rendre le jeu ESO plus agréable", 1)

SafeAddString(SI_PA_PLEASE_SELECT_PROFILE, "<Sélectionner un profil>", 1)

SafeAddString(SI_PA_MENU_GENERAL_ACTIVE_PROFILE, "Profil actif", 1)
SafeAddString(SI_PA_MENU_GENERAL_ACTIVE_PROFILE_T, "Selectionner le profil actif pour PersonalAssistant. Il chargera automatiquement tous les paramètres stockés sous ce profil, et enregistrera les changements au même endroit.", 1)
SafeAddString(SI_PA_MENU_GENERAL_ACTIVE_PROFILE_RENAME, "Renommer le profil actif", 1)
SafeAddString(SI_PA_MENU_GENERAL_SHOW_WELCOME, "Afficher le message d'accueil", 1)

SafeAddString(SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE, table.concat({PAC.ICONS.OTHERS.HOME.NORMAL, " Aller à la maison"}), 1)
SafeAddString(SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE_W, "Si la position actuelle permet un voyage rapide, cela lancera la téléportation vers votre maison primaire !", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Generic Menu --
SafeAddString(SI_PA_MENU_SILENT_MODE, "Mode silencieux (désactiver TOUS les messages dans le chat)", 1)

SafeAddString(SI_PA_MENU_NOT_YET_IMPLEMENTED, "Pas encore implémenté !", 1)


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
-- PABanking --
SafeAddString(SI_PA_BANKING_MOVE_MODE_DONOTHING, "Ne rien faire", 1)
SafeAddString(SI_PA_BANKING_MOVE_MODE_TOBANK, "Déposer en banque", 1)
SafeAddString(SI_PA_BANKING_MOVE_MODE_TOBACKPACK, "Prendre dans le sac", 1)

SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT, "Nécessaires de réparation", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Operators --
SafeAddString(SI_PA_REL_OPERATOR_T, "Sélectionner l'opérateur mathématique pour cet objet", 1)
SafeAddString(SI_PA_REL_EQUAL, "égal (=)", 1)
SafeAddString(SI_PA_REL_LESSTHAN, "inférieur à (<)", 1) -- not required so far
SafeAddString(SI_PA_REL_LESSTHANEQUAL, "inférieur ou égal à (<=)", 1)
SafeAddString(SI_PA_REL_GREATERTHAN, "supérieur à (>)", 1) -- not required so far
SafeAddString(SI_PA_REL_GREATERTHANEQUAL, "supérieur ou égal à (>=)", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- Stacking types --
SafeAddString(SI_PA_ST_MOVE_FULL, "Tout déplacer", 1)
SafeAddString(SI_PA_ST_MOVE_INCOMPLETE_STACKS_ONLY, "N'ajouter qu'aux piles existantes", 1)

-- -----------------------------------------------------------------------------------------------------------------
-- PABanking - overriding the ItemFilterTypes because they are wrong in French --
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_CLOTHING, "Coûture", 1) -- TODO: Need Takit! :)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ENCHANTING, "Enchantement", 1) -- TODO: Need Takit! :)
