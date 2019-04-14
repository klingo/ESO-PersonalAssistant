local PAC = PersonalAssistant.Constants
local PARStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair Menu --
    SI_PA_MENU_REPAIR_DESCRIPTION = "PARepair repairs your armor and recharges your weapons for you, be it at a merchant or out on the field",

    SI_PA_MENU_REPAIR_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Enable Auto Repair for Equipped Items"}),

    SI_PA_MENU_REPAIR_GOLD_HEADER = table.concat({" ", PAC.ICONS.CURRENCY[CURT_MONEY].NORMAL, "  ", "Repair with ", GetCurrencyName(CURT_MONEY)}),
    SI_PA_MENU_REPAIR_GOLD_ENABLE = table.concat({"Repair equipped Items with ", GetCurrencyName(CURT_MONEY), "?"}),
    SI_PA_MENU_REPAIR_GOLD_ENABLE_T = "When visiting a merchant, all equipped items that are at or below the defined threshold will automatically be repaired",
    SI_PA_MENU_REPAIR_GOLD_DURABILITY = "Durability threshold in %",
    SI_PA_MENU_REPAIR_GOLD_DURABILITY_T = "Repair equipped items only if they are at or below the defined durability threshold",

    SI_PA_MENU_REPAIR_REPAIRKIT_HEADER = table.concat({" ", PAC.ICONS.ITEMS.REPAIRKIT.NORMAL, "  ", "Repair with ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT)}),
    SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE = table.concat({"Repair equipped Items with ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT), "?"}),
    SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE_T = "When out on the field, all equipped items that are at or below the defined threshold will automatically be repaired",
    SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY = "Durability threshold in %",
    SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY_T = "Repair equipped items only if they are at or below the defined durability threshold",
--    SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_ENABLE = table.concat({PAC.COLORS.LIGHT_BLUE, "Use Crown ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT), "?"}),
--    SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_ENABLE_T = "???",
--    SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_DURABILITY = "Avg. durability threshold in %",
--    SI_PA_MENU_REPAIR_REPAIRKIT_CROWN_DURABILITY_T = "Repair ALL equipped items only if they are on average at or below the defined durability threshold",
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING = table.concat({"Warn when low on ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT)}),
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING_T = table.concat({"Display a warning in the chat window if you are low on ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT), ". If you have none left, it will warn you once every 10 minutes at most."}),
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD = "Repair Kit threshold",
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD_T = table.concat({"If the remaining amount of ", GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT), " is below this threshold, a message is displayed in the chat window"}),

    SI_PA_MENU_REPAIR_RECHARGE_HEADER = table.concat({" ", PAC.ICONS.ITEMS.SOULGEM.NORMAL, "  ", "Recharge Weapons with ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2)}),
    SI_PA_MENU_REPAIR_RECHARGE_ENABLE = table.concat({"Recharge equipped weapons with ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), "?"}),
    SI_PA_MENU_REPAIR_RECHARGE_ENABLE_T = "Re-Charge equipped weapons when their charge level reaches zero. It will first use Crown Soul Gems and only afterwards regular Soul Gems.",
--    SI_PA_MENU_REPAIR_RECHARGE_CHATMODE = "Chat display after Recharge",
--    SI_PA_MENU_REPAIR_RECHARGE_CHATMODE_T = "How to display the information of a re-charged weaponin the chat window",
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING = table.concat({"Warn when low on ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2)}),
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING_T = table.concat({"Display a warning in the chat window if you are low on ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), ". If you have none left, it will warn you once every 10 minutes at most."}),
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD = table.concat({GetString("SI_ITEMTYPE", ITEMTYPE_SOUL_GEM), " threshold"}),
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD_T = table.concat({"If the remaining amount of ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), " is below this threshold, a message is displayed in the chat window"}),


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair --
    SI_PA_CHAT_REPAIR_SUMMARY_FULL = table.concat({PAC.COLORED_TEXTS.PAR, "Repaired equipped items for ", PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL}),
    SI_PA_CHAT_REPAIR_SUMMARY_PARTIAL = table.concat({PAC.COLORED_TEXTS.PAR, "Repaired equipped items for ", PAC.COLORS.RED, "- %d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, PAC.COLORS.DEFAULT, " (%d ", PAC.ICONS.CURRENCY[CURT_MONEY].SMALL, " missing)"}),

    SI_PA_CHAT_REPAIR_REPAIRKIT_REPAIRED = table.concat({PAC.COLORED_TEXTS.PAR, "Repaired %s ", PAC.COLORS.WHITE, "(%d%%)", PAC.COLORS.DEFAULT, " with %s"}),


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
}

for key, value in pairs(PARStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end


local PARGenericStrings = {
    -- =================================================================================================================
    -- Language independent texts (do not need to be translated/copied to other languages --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair Menu --
    SI_PA_MENU_REPAIR_HEADER = PAC.COLORED_TEXTS.PAR,


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_PA_CHAT_REPAIR_CHARGE_WEAPON = table.concat({PAC.COLORED_TEXTS.PAR, "%s (%d%% --> %d%%) - %s"}),
}

for key, value in pairs(PARGenericStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end
