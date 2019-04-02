local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PARepair Menu --
SafeAddString(SI_PA_MENU_REPAIR_DESCRIPTION, "PARepair répare votre armure et recharge vos armes pour vous, à un marchand ou sur le champ de bataille", 1)

SafeAddString(SI_PA_MENU_REPAIR_ENABLE, table.concat({PAC.COLORS.LIGHT_BLUE, "Activer la réparation auto pour les objets équipés"}), 1)

SafeAddString(SI_PA_MENU_REPAIR_GOLD_HEADER, table.concat({" ", PAC.ICONS.CURRENCY[CURT_MONEY].NORMAL, "  ", "Réparer avec ", GetCurrencyName(CURT_MONEY)}), 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_ENABLE, table.concat({"Réparer les objets équipés avec ", GetCurrencyName(CURT_MONEY), " ?"}), 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_ENABLE_T, "En visitant un marchand, tous les objets équipés en dessous du seuil de durabilité défini seront automatiquement réparés", 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_DURABILITY, "Seuil de durabilité en %", 1)
SafeAddString(SI_PA_MENU_REPAIR_GOLD_DURABILITY_T, "Réparer les objets équipés que s'ils sont en-dessous du seuil de durabilité", 1)

SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_HEADER, table.concat({" ", PAC.ICONS.ITEMS.REPAIRKIT.NORMAL, "  ", "Réparer avec ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT)}), 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE, table.concat({"Réparer les objets équipés avec ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT), " ?"}), 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE_T, "Sur le champ de bataille, tous les objets équipés en dessous du seuil de durabilité défini seront automatiquement réparés", 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY, "Seuil de durabilité en %", 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY_T, "Réparer les objets équipés que s'ils sont en-dessous du seuil de durabilit", 1)
--SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_ENABLE, "tbd", 1) -- TODO: not yet used ingame
--SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_ENABLE_T, "tbd", 1) -- TODO: not yet used ingame
--SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_DURABILITY, "tbd", 1) -- TODO: not yet used ingame
--SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_DURABILITY_T, "tbd", 1) -- TODO: not yet used ingame
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING, table.concat({"Avertir quand il reste peu de ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT)}), 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING_T, table.concat({"Afficher un avertissement dans la fenêtre de chat s'il vous reste peu de ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT), ". Si vous n'en avez plus du tout, un rappel sera affiché au maximum toutes les 10 minutes."}), 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD, "Seuil de nécessaires de réparation", 1)
SafeAddString(SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD_T, table.concat({"Si la quantité restante de ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT), " est en dessous du seuil, un message sera affiché dans la fenêtre de chat"}), 1)

SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_HEADER, table.concat({" ", PAC.ICONS.ITEMS.SOULGEM.NORMAL, "  ", "Recharger les armes avec ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2)}), 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_ENABLE, table.concat({"Recharger les armes équipées avec ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), " ?"}), 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_ENABLE_T, "Re-Charge les armes équipées quand elles sont complétement déchargées. Cela utilisera d'abord des pierres d'âmes, puis ensuite des pierres d'âmes à couronne.", 1)
--SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_CHATMODE, "tbd", 1) -- TODO: not yet used ingame
--SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_CHATMODE_T, "tbd", 1) -- TODO: not yet used ingame
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING, table.concat({"Avertir quand peu de ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2)}), 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING_T, table.concat({"Afficher un avertissement dans la fenêtre de chat s'il vous reste peu de ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), ". Si vous n'en avez plus du tout, un rappel sera affiché au maximum toutes les 10 minutes."}), 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD, table.concat({"Seuil de ", GetString("SI_ITEMTYPE", ITEMTYPE_SOUL_GEM)}), 1)
SafeAddString(SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD_T, table.concat({"Si la quantité restante de ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), " est en dessous du seuil, un message sera affiché dans la fenêtre de chat"}), 1)

-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PARepair --
SafeAddString(SI_PA_CHAT_REPAIR_SUMMARY_FULL, table.concat({PAC.COLORED_TEXTS.PAR, "Réparation des objets équipés effectuée pour ", PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}), 1)
SafeAddString(SI_PA_CHAT_REPAIR_SUMMARY_PARTIAL, table.concat({PAC.COLORED_TEXTS.PAR, "Réparation des objets équipés effectuée pour ", PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, PAC.COLORS.DEFAULT, " (%d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, " manquant)"}), 1)

SafeAddString(SI_PA_CHAT_REPAIR_REPAIRKIT_REPAIRED, table.concat({PAC.COLORED_TEXTS.PAR, "Réparation de %s ", PAC.COLORS.WHITE, "(%d%%)", PAC.COLORS.DEFAULT, " effectuée avec %s"}), 1)