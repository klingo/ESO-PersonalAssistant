local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PABanking Menu --
SafeAddString(SI_PA_MENU_BANKING_DESCRIPTION, "PABanking peut déplacer les devises, les matériaux d'artisanat, et d'autres objets entre l'inventaire et la banque", 1)

-- Currencies --
SafeAddString(SI_PA_MENU_BANKING_CURRENCY_HEADER, GetString(SI_INVENTORY_CURRENCIES), 1)
SafeAddString(SI_PA_MENU_BANKING_CURRENCY_ENABLE, table.concat({"Dépot/Retrait automatique des ", GetString(SI_INVENTORY_CURRENCIES)}), 1)
SafeAddString(SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP, "Minimum à garder sur soi", 1)
SafeAddString(SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP, "Maximum à garder sur soi", 1)

-- Crafting Items --
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_HEADER, "Objets d'artisanat", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ENABLE, "Dépot/Retrait automatique des objets d'artisanat", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ENABLE_T, "Activer la mise en banque ou le retrait automatique pour les objets d'Artisanat ?", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_DESCRIPTION, "Définir l'action à exécuter (dépose, retrait, aucune action) pour les matériaux d'artisanat", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ESOPLUS_DESC, "En tant que membre ESO Plus, the dépot/retrait de matériaux d'artisanat n'est pas utile puisqu'ils peuvent être tous transportés dans le sac d'artisanat", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE, "Changer tous les menus des objets d'artisanat en :", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE_T, "Changer tous les menus des objets d'artisanat précédents en 'Déposer en banque', 'Prendre dans le sac', ou 'Ne rien faire'", 1)

-- Advanced Items --
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_HEADER, "Objets spéciaux", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_ENABLE, "Dépot/Retrait automatique des objets spéciaux", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_ENABLE_T, "Activer la mise en banque ou le retrait automatique pour les objets spéciaux ?", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_DESCRIPTION, "Définir l'action à exécuter (dépose, retrait, aucune action) pour les objets spéciaux", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS, "Glyphes", 1) -- TODO: to be checked why this is not replacing the English text
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE, "Changer tous les menus des objets spéciaux en :", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE_T, "Changer tous les menus des objets spéciaux précédents en 'Déposer en banque', 'Prendre dans le sac', ou 'Ne rien faire'", 1)

SafeAddString(SI_PA_MENU_BANKING_ADVANCED_KNOWN_ITEMTYPE8, table.concat({PAC.ICONS.OTHERS.KNOWN.NORMAL, " Motifs connus"}), 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_KNOWN_ITEMTYPE29, table.concat({PAC.ICONS.OTHERS.KNOWN.NORMAL, " Recettes connues"}), 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_UNKNOWN_ITEMTYPE8, table.concat({PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " Motifs inconnus"}), 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_UNKNOWN_ITEMTYPE29, table.concat({PAC.ICONS.OTHERS.UNKNOWN.NORMAL, " Recettes inconnues"}), 1)

-- Individual Items --
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_HEADER, "Objets utilitaires", 1)
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_ENABLE, "Dépot/Retrait automatique des objets utilitaires", 1)
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_DISABLED_DESCRIPTION, table.concat({"Avec la mise en place des règles de mise en banque personnalisées, les anciens paramètres pour les “Objets utilitaires” ont été migrés vers ce nouveau système. ", GetString(SI_PA_MENU_RULES_HOW_TO_ADD_PAB), "\n\n", GetString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU)}), 1)

-- AvA Items --
SafeAddString(SI_PA_MENU_BANKING_AVA_HEADER, "Objets d'AcA", 1)
SafeAddString(SI_PA_MENU_BANKING_AVA_ENABLE, "Dépot/Retrait automatique des objets d'AcA", 1)
SafeAddString(SI_PA_MENU_BANKING_AVA_ENABLE_T, "Activer la mise en banque ou le retrait automatique pour les objets de Guerre d'Alliances ?", 1)
SafeAddString(SI_PA_MENU_BANKING_AVA_DESCRIPTION, "Définir la quantité d'Objets de Guerre d'Alliances (AcA) qui doit être conservée dans l'inventaire", 1)
SafeAddString(SI_PA_MENU_BANKING_AVA_OTHER_HEADER, "Autre", 1)

-- Other Settings --
SafeAddString(SI_PA_MENU_BANKING_OTHER_DEPOSIT_STACKING, "Règle d'empilement à la dépose", 1)
SafeAddString(SI_PA_MENU_BANKING_OTHER_DEPOSIT_STACKING_T, "Définir si tous les objets doivent être déposés, ou seulement quand il y a des piles existantes à compléter", 1)
SafeAddString(SI_PA_MENU_BANKING_OTHER_WITHDRAWAL_STACKING, "Règle d'empilement au retrait", 1)
SafeAddString(SI_PA_MENU_BANKING_OTHER_WITHDRAWAL_STACKING_T, "Définir si tous les objets doivent être retirés, ou seulement quand il y a des piles existantes à compléter", 1)

SafeAddString(SI_PA_MENU_BANKING_OTHER_AUTOSTACKBAGS, "Empiler les objets à l'ouverture de la banque", 1)
SafeAddString(SI_PA_MENU_BANKING_OTHER_AUTOSTACKBAGS_T, "Empiler automatiquement tous les objets dans la banque et l'inventaire à l'ouverture de la banque ? Cela permet une meilleure organisation", 1)

-- Generic definitions for any type --
SafeAddString(SI_PA_MENU_BANKING_ANY_CURRENCY_ENABLE, "Déposer/Retirer cette devise", 1) -- changed "les %s" because it wasn't working with "Or"

SafeAddString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK, "Quantité à conserver", 1)
SafeAddString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK_T, "Définir la quantité qui (basée sur l'opérateur mathématique) doit être conservée dans l'inventaire ou la banque", 1)

SafeAddString(SI_PA_MENU_BANKING_ANY_MINTOKEEP_T, "Quantité minimum de %s à conserver sur ce personnage ; si nécessaire en retirant de la banque", 1)
SafeAddString(SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T, "Quantité maximum de %s à conserver sur ce personnage ; tout surplus sera déposé en banque", 1)

SafeAddString(SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_W, "Ceci ne peut pas être annulé ; toutes les valeurs actuelles seront perdues", 1)


-- =================================================================================================================
-- == MAIN MENU TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PABanking --
SafeAddString(SI_PA_MAINMENU_BANKING_HEADER, "Règles de mise en banque", 1)

SafeAddString(SI_PA_MAINMENU_BANKING_HEADER_BAG, "Emplacement", 1)
SafeAddString(SI_PA_MAINMENU_BANKING_HEADER_OPERATOR, "Opérateur", 1)
SafeAddString(SI_PA_MAINMENU_BANKING_HEADER_AMOUNT, "Quantité", 1)
SafeAddString(SI_PA_MAINMENU_BANKING_HEADER_ITEM, "Objet ciblé par la règle", 1)
SafeAddString(SI_PA_MAINMENU_BANKING_HEADER_ACTIONS, "Gérer", 1)


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PABanking --
SafeAddString(SI_PA_CHAT_BANKING_WITHDRAWAL_COMPLETE, "%d %s retirés", 1)
SafeAddString(SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_SOURCE, "%d / %d %s retirés (La banque est vide)", 1)
SafeAddString(SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_TARGET, "%d / %d %s retirés (Pas assez d'espace sur le personnage)", 1)

SafeAddString(SI_PA_CHAT_BANKING_DEPOSIT_COMPLETE, "%d %s déposés", 1)
SafeAddString(SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_SOURCE, "%d / %d %s déposés (Plus rien sur le personnage)", 1)
SafeAddString(SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_TARGET, "%d / %d %s déposés (Pas assez d'espace en banque)", 1)

SafeAddString(SI_PA_CHAT_BANKING_ITEMS_MOVED_COMPLETE, "%d x %s déplacés vers %s", 1)
SafeAddString(SI_PA_CHAT_BANKING_ITEMS_MOVED_PARTIAL, "%d/%d x %s déplacés vers %s", 1)
SafeAddString(SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_OUTOFSPACE, "Impossible de déplacer %s vers %s. Pas assez d'espace !", 1)
SafeAddString(SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_BANKCLOSED, "Impossible de déplacer %s vers %s. La fenêtre a été fermée !", 1)
SafeAddString(SI_PA_CHAT_BANKING_ITEMS_SKIPPED_LWC, "Certains matériaux n'ont PAS été déposés pour éviter de potentielles interférences avec Dolgubon's Lazy Writ Crafter", 1)

SafeAddString(SI_PA_CHAT_BANKING_RULES_ADDED, table.concat({"La règle pour %s a été ", PAC.COLOR.ORANGE:Colorize("ajoutée"), " !"}), 1)
SafeAddString(SI_PA_CHAT_BANKING_RULES_UPDATED, table.concat({"La règle pour %s a été ", PAC.COLOR.ORANGE:Colorize("modifiée"), " !"}), 1)
SafeAddString(SI_PA_CHAT_BANKING_RULES_DELETED, table.concat({"La règle pour %s a été ", PAC.COLOR.ORANGE:Colorize("supprimée"), " !"}), 1)


-- =================================================================================================================
-- Language independent texts (do not need to be translated/copied to other languages ; except in French ;-P --

-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PABanking Menu --
SafeAddString(SI_PA_MENU_BANKING_CURRENCY_GOLD_HEADER, "pièces d'or", 1)