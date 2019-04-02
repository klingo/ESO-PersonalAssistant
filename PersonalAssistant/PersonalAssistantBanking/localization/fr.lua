local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PABanking Menu --
SafeAddString(SI_PA_MENU_BANKING_DESCRIPTION, "PABanking peut déplacer les devises, les matériaux d'artisanat, et d'autres objets entre l'inventaire et la banque", 1)

SafeAddString(SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP, "Minimum à garder sur soi", 1)
SafeAddString(SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP, "Maximum à garder sur soi", 1)

SafeAddString(SI_PA_MENU_BANKING_CRAFTING, "Artisanat", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_DESCRIPTION, "Définir l'action spécifique (dépose, retrait, aucune action) pour les matériaux d'artisanat", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ESOPLUS_DESC, table.concat({PAC.COLORS.LIGHT_BLUE, "En tant que membre ESO Plus, the dépot/retrait de matériaux d'artisanat n'est pas utile puisqu'ils peuvent être tous transportés dans le sac d'artisanat"}), 1)

SafeAddString(SI_PA_MENU_BANKING_ADVANCED, "Spécial", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_DESCRIPTION, "Définir l'action spécifique (dépose, retrait, aucune action) pour les objets spéciaux", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS, "Glyphes", 1) -- TODO: to be checked why this is not replacing the English text

SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL, "Objets utilitaires", 1)
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_DESCRIPTION, "Définir l'action spécifique (dépose, retrait, aucune action) pour les objets utilitaires", 1)
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC, "Autre", 1)

SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK, "Quantité à conserver dans l'inventaire", 1)
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK_T, "Définit la quantité qui (basée sur l'opérateur mathématique) doit être conservé dans l'inventaire", 1)

-- Generic definitions for any type --
SafeAddString(SI_PA_MENU_BANKING_ANY_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Dépot/Retrait automatique des %s"}), 1)
SafeAddString(SI_PA_MENU_BANKING_ANY_ITEMS_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Dépot/Retrait automatique des objets d'%s"}), 1)
SafeAddString(SI_PA_MENU_BANKING_ANY_ITEMS_ENABLE_T, "Activer la mise en banque ou le retrait automatique pour les objets d'%s ?", 1)

SafeAddString(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE, "Déposer/Retirer les %s", 1)
SafeAddString(SI_PA_MENU_BANKING_ANY_TYPE_ITEMS_ENABLE, "Déposer/Retirer les matériaux de %s", 1)

SafeAddString(SI_PA_MENU_BANKING_ANY_MINTOKEEP_T, "Quantité minimum de %s à conserver sur ce personnage ; si nécessaire en retirant de la banque", 1)
SafeAddString(SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T, "Quantité maximum de %s à conserver sur ce personnage ; tout surplus sera déposé en banque", 1)

SafeAddString(SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE, "Changer tous les menus des objets d'%s", 1)
SafeAddString(SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_T, "Changer tous les menus des objets d'%s précédent en 'Déposer en banque', 'Prendre dans le sac', ou 'Ne rien faire'", 1)
SafeAddString(SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_W, "Ceci ne peut pas être annulé ; toutes les valeurs actuelles seront perdues", 1)

SafeAddString(SI_PA_MENU_BANKING_DEPOSIT_STACKING, "Règle d'empilement à la dépose", 1)
SafeAddString(SI_PA_MENU_BANKING_DEPOSIT_STACKING_T, "Définir si tous les objets doivent être déposés, ou seulement quand il y a des piles existantes à compléter", 1)
SafeAddString(SI_PA_MENU_BANKING_WITHDRAWAL_STACKING, "Règle d'empilement au retrait", 1)
SafeAddString(SI_PA_MENU_BANKING_WITHDRAWAL_STACKING_T, "Définir si tous les objets doivent être retirés, ou seulement quand il y a des piles existantes à compléter", 1)

SafeAddString(SI_PA_MENU_BANKING_TRANSACTION_INTERVAL, "Intervalle entre les déplacements (msecs)", 1)
SafeAddString(SI_PA_MENU_BANKING_TRANSACTION_INTERVAL_T, "Temps en millisecondes entre deux déplacements d'objets consécutifs. S'il y a des déplacements qui ne fonctionnent pas, pensez à augmenter cette valeur", 1)

SafeAddString(SI_PA_MENU_BANKING_AUTOSTACKBAGS, "Empiler les objets à l'ouverture de la banque", 1)
SafeAddString(SI_PA_MENU_BANKING_AUTOSTACKBAGS_T, "Empiler automatiquement tous les objets dans la banque et l'inventaire à l'ouverture de la banque ? Cela permet une meilleure organisation", 1)


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PABanking --
SafeAddString(SI_PA_CHAT_BANKING_WITHDRAWAL_COMPLETE, table.concat({PAC.COLORED_TEXTS.PAB, "%d %s retirés"}), 1)
SafeAddString(SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_SOURCE, table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s retirés (La banque est vide)"}), 1)
SafeAddString(SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_TARGET, table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s retirés (Pas assez d'espace sur le personnage)"}), 1)

SafeAddString(SI_PA_CHAT_BANKING_DEPOSIT_COMPLETE, table.concat({PAC.COLORED_TEXTS.PAB, "%d %s déposés"}), 1)
SafeAddString(SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_SOURCE, table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s déposés (Plus rien sur le personnage)"}), 1)
SafeAddString(SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_TARGET, table.concat({PAC.COLORED_TEXTS.PAB, "%d / %d %s déposés (Pas assez d'espace en banque)"}), 1)

SafeAddString(SI_PA_CHAT_BANKING_ITEMS_MOVED_COMPLETE, table.concat({PAC.COLORED_TEXTS.PAB, "%d x %s déplacés vers %s"}), 1)
SafeAddString(SI_PA_CHAT_BANKING_ITEMS_MOVED_PARTIAL, table.concat({PAC.COLORED_TEXTS.PAB, "%d/%d x %s déplacés vers %s"}), 1)
SafeAddString(SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_OUTOFSPACE, table.concat({PAC.COLORED_TEXTS.PAB, "Impossible de déplacer %s vers %s. Pas assez d'espace !"}), 1)
SafeAddString(SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_BANKCLOSED, table.concat({PAC.COLORED_TEXTS.PAB, "Impossible de déplacer %s vers %s. La fenêtre a été fermée !"}), 1)
