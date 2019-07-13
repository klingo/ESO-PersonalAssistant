local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PARepair Menu --
SafeAddString(SI_PA_MENU_REPAIR_DESCRIPTION, "PARepair répare votre armure et recharge vos armes pour vous, à un marchand ou sur le champ de bataille", 1)

-- Equipped Items --
SafeAddString(SI_PA_MENU_REPAIR_EQUIPPED_HEADER, "Objets équipés", 1)
SafeAddString(SI_PA_MENU_REPAIR_ENABLE, "Activer la réparation auto pour les objets équipés", 1)

SafeAddString(SI_PA_MENU_REPAIR_GOLD_HEADER, table.concat({"Réparer avec de l'", GetCurrencyName(CURT_MONEY)}), 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_ENABLE, table.concat({"Réparer les objets équipés avec de l'or ?"}), 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_ENABLE_T, "En visitant un marchand, tous les objets équipés en dessous du seuil de durabilité défini seront automatiquement réparés", 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_DURABILITY, "Seuil de durabilité en %", 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_DURABILITY_T, "Réparer les objets équipés seulement s'ils sont en-dessous du seuil de durabilité", 1)

SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_HEADER, table.concat({"Réparer avec des ", GetString(SI_PA_MENU_BANKING_REPAIRKIT)}), 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE, table.concat({"Réparer les objets équipés avec des nécessaires"}), 1) -- GetString(SI_PA_MENU_BANKING_REPAIRKIT), " ?"}), 1) -- It was too long
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE_T, "Sur le champ de bataille, tous les objets équipés en dessous du seuil de durabilité défini seront automatiquement réparés", 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY, "Seuil de durabilité en %", 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY_T, "Réparer les objets équipés seulement s'ils sont en-dessous du seuil de durabilité", 1)
--SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_ENABLE, "tbd", 1) -- TODO: not yet used ingame
--SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_ENABLE_T, "tbd", 1) -- TODO: not yet used ingame
--SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_DURABILITY, "tbd", 1) -- TODO: not yet used ingame
--SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_DURABILITY_T, "tbd", 1) -- TODO: not yet used ingame
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING, "Avertir sur quantité restante faible", 1)-- table.concat({"Avertir quand il reste peu de ", GetString(SI_PA_MENU_BANKING_REPAIRKIT)}), 1) -- It was too long
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING_T, table.concat({"Afficher un avertissement dans la fenêtre de chat s'il vous reste peu de ", GetString(SI_PA_MENU_BANKING_REPAIRKIT), ". Si vous n'en avez plus du tout, un rappel sera affiché au maximum toutes les 10 minutes."}), 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD, "    Seuil de “quantité faible”", 1) -- spaces in the beginning are needed as otherwise the options are too close to each other
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD_T, table.concat({"Si la quantité restante de ", GetString(SI_PA_MENU_BANKING_REPAIRKIT), " est en dessous du seuil, un message sera affiché dans la fenêtre de chat"}), 1)

SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_HEADER, table.concat({"Recharger les armes avec des ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2)}), 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_ENABLE, table.concat({"Recharger les armes avec des pierres d'âme ?"}), 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_ENABLE_T, "Re-Charge les armes équipées quand elles sont complétement déchargées. Cela utilisera d'abord des pierres d'âmes à couronne, puis ensuite des pierres d'âmes.", 1)
--SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_CHATMODE, "tbd", 1) -- TODO: not yet used ingame
--SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_CHATMODE_T, "tbd", 1) -- TODO: not yet used ingame
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING, "Avertir si la quantité restante est faible", 1) -- table.concat({"Avertir quand peu de ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2)}), 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING_T, table.concat({"Afficher un avertissement dans la fenêtre de chat s'il vous reste peu de ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), ". Si vous n'en avez plus du tout, un rappel sera affiché au maximum toutes les 10 minutes."}), 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD, "    Seuil de “quantité faible”", 1) -- spaces in the beginning are needed as otherwise the options are too close to each other
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD_T, table.concat({"Si la quantité restante de ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), " est en dessous du seuil, un message sera affiché dans la fenêtre de chat"}), 1)

-- Inventory Items --
SafeAddString(SI_PA_MENU_REPAIR_INVENTORY_HEADER, "Objets dans l'inventaire", 1)
SafeAddString(SI_PA_MENU_REPAIR_INVENTORY_ENABLE, "Réparer automatiquement les objets dans l'inventaire", 1)

SafeAddString(SI_PA_MENU_REPAIR_GOLD_INVENTORY_ENABLE, "Réparer les objets dans l'inventaire avec de l'or ?", 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_INVENTORY_ENABLE_T, "En visitant un marchand, tous les objets dans l'inventaire en dessous du seuil de durabilité défini seront automatiquement réparés", 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_INVENTORY_DURABILITY, "Seuil de durabilité en %", 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_INVENTORY_DURABILITY_T, "Réparer les objets dans l'inventaire seulement s'ils sont en-dessous du seuil de durabilité", 1)


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PARepair --
SafeAddString(SI_PA_CHAT_REPAIR_SUMMARY_FULL, "Réparation des objets équipés effectuée pour %s", 1)
SafeAddString(SI_PA_CHAT_REPAIR_SUMMARY_PARTIAL, "Réparation des objets équipés effectuée pour %s (%s manquant)", 1)

SafeAddString(SI_PA_CHAT_REPAIR_SUMMARY_INVENTORY_FULL, "Réparation des objets dans l'inventaire effectuée pour %s", 1)
SafeAddString(SI_PA_CHAT_REPAIR_SUMMARY_INVENTORY_PARTIAL, "Réparation des objets dans l'inventaire effectuée pour %s (%s manquant)", 1)

SafeAddString(SI_PA_CHAT_REPAIR_REPAIRKIT_REPAIRED, table.concat({"Réparation de %s ", PAC.COLORS.WHITE, "(%d%%)", PAC.COLORS.DEFAULT, " effectuée avec %s"}), 1)