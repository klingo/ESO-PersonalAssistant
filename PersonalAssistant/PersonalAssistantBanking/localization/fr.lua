local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PABanking Menu --
SafeAddString(SI_PA_MENU_BANKING_DESCRIPTION, "PABanking peut déplacer les devises, les matériaux d'artisanat, et d'autres objets entre l'inventaire et la banque", 1)

SafeAddString(SI_PA_MENU_BANKING_CURRENCY_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Dépot/Retrait automatique des ", GetString(SI_INVENTORY_CURRENCIES)}), 1)
SafeAddString(SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP, "Minimum à garder sur soi", 1)
SafeAddString(SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP, "Maximum à garder sur soi", 1)

SafeAddString(SI_PA_MENU_BANKING_CRAFTING, "Artisanat", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Dépot/Retrait automatique des objets d'Artisanat"}), 1) -- TODO: Need Takit to double-check! :)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ENABLE_T, "Activer la mise en banque ou le retrait automatique pour les objets d'Artisanat ?", 1) -- TODO: Need Takit to double-check! :)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_DESCRIPTION, "Définir l'action spécifique (dépose, retrait, aucune action) pour les matériaux d'artisanat", 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ESOPLUS_DESC, table.concat({PAC.COLORS.LIGHT_BLUE, "En tant que membre ESO Plus, the dépot/retrait de matériaux d'artisanat n'est pas utile puisqu'ils peuvent être tous transportés dans le sac d'artisanat"}), 1)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE, "Changer tous les menus des objets d'artisanat", 1) -- TODO: Need Takit to double-check! :)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE_T, "Changer tous les menus des objets d'artisanat précédent en 'Déposer en banque', 'Prendre dans le sac', ou 'Ne rien faire'", 1) -- TODO: Need Takit to double-check! :)

SafeAddString(SI_PA_MENU_BANKING_CRAFTING_BLACKSMITHING_ITEMS_ENABLE, table.concat({"Déposer/Retirer les ", GetString(SI_PA_MENU_BANKING_CRAFTING_BLACKSMITHING)}), 1) -- TODO: Need Takit! :)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_CLOTHING_ITEMS_ENABLE, table.concat({"Déposer/Retirer les ", GetString(SI_PA_MENU_BANKING_CRAFTING_CLOTHING)}), 1) -- TODO: Need Takit! :)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_WOODWORKING_ITEMS_ENABLE, table.concat({"Déposer/Retirer les ", GetString(SI_PA_MENU_BANKING_CRAFTING_WOODWORKING)}), 1) -- TODO: Need Takit! :)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_JEWELCRAFTING_ITEMS_ENABLE, table.concat({"Déposer/Retirer les ", GetString(SI_PA_MENU_BANKING_CRAFTING_JEWELCRAFTINGG)}), 1) -- TODO: Need Takit! :)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ALCHEMY_ITEMS_ENABLE, table.concat({"Déposer/Retirer les ", GetString(SI_PA_MENU_BANKING_CRAFTING_ALCHEMY)}), 1) -- TODO: Need Takit! :)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_ENCHANTING_ITEMS_ENABLE, table.concat({"Déposer/Retirer les ", GetString(SI_PA_MENU_BANKING_CRAFTING_ENCHANTING)}), 1) -- TODO: Need Takit! :)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_PROVISIONING_ITEMS_ENABLE, table.concat({"Déposer/Retirer les ", GetString(SI_PA_MENU_BANKING_CRAFTING_PROVISIONING)}), 1) -- TODO: Need Takit! :)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_STYLEMATERIALS_ITEMS_ENABLE, table.concat({"Déposer/Retirer les ", GetString(SI_PA_MENU_BANKING_CRAFTING_STYLEMATERIALS)}), 1) -- TODO: Need Takit! :)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_TRAITITEMS_ITEMS_ENABLE, table.concat({"Déposer/Retirer les ", GetString(SI_PA_MENU_BANKING_CRAFTING_TRAITITEMS)}), 1) -- TODO: Need Takit! :)
SafeAddString(SI_PA_MENU_BANKING_CRAFTING_FURNISHING_ITEMS_ENABLE, table.concat({"Déposer/Retirer les ", GetString(SI_PA_MENU_BANKING_CRAFTING_FURNISHING)}), 1) -- TODO: Need Takit! :)

SafeAddString(SI_PA_MENU_BANKING_ADVANCED, "Spécial", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Dépot/Retrait automatique des objets de spécial"}), 1) -- TODO: Need Takit to double-check! :)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_ENABLE_T, "Activer la mise en banque ou le retrait automatique pour les objets de spécial ?", 1) -- TODO: Need Takit to double-check! :)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_DESCRIPTION, "Définir l'action spécifique (dépose, retrait, aucune action) pour les objets spéciaux", 1)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS, "Glyphes", 1) -- TODO: to be checked why this is not replacing the English text
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE, "Changer tous les menus des objets de spécial", 1) -- TODO: Need Takit to double-check! :)
SafeAddString(SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE_T, "Changer tous les menus des objets de spécial précédent en 'Déposer en banque', 'Prendre dans le sac', ou 'Ne rien faire'", 1) -- TODO: Need Takit to double-check! :)

SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL, "Objets utilitaires", 1)
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Dépot/Retrait automatique des objets d'utilitaires"}), 1) -- TODO: Need Takit to double-check! :)
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_ENABLE_T, "Activer la mise en banque ou le retrait automatique pour les objets d'utilitaires ?", 1) -- TODO: Need Takit to double-check! :)
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_DESCRIPTION, "Définir l'action spécifique (dépose, retrait, aucune action) pour les objets utilitaires", 1)
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC, "Autre", 1)

SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK, "Quantité à conserver dans l'inventaire", 1)
SafeAddString(SI_PA_MENU_BANKING_INDIVIDUAL_KEEPINBACKPACK_T, "Définit la quantité qui (basée sur l'opérateur mathématique) doit être conservé dans l'inventaire", 1)

-- Generic definitions for any type --
SafeAddString(SI_PA_MENU_BANKING_ANY_TYPE_ENABLE, "Déposer/Retirer les %s", 1)

SafeAddString(SI_PA_MENU_BANKING_ANY_MINTOKEEP_T, "Quantité minimum de %s à conserver sur ce personnage ; si nécessaire en retirant de la banque", 1)
SafeAddString(SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T, "Quantité maximum de %s à conserver sur ce personnage ; tout surplus sera déposé en banque", 1)

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
