local PAC = PersonalAssistant.Constants
local PARStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair Menu --
    SI_PA_MENU_REPAIR_DESCRIPTION = "PARepair repairs your armor and recharges your weapons for you, be it at a merchant or out on the field",

    -- Equipped Items --
    SI_PA_MENU_REPAIR_EQUIPPED_HEADER = "Equipped Items",
    SI_PA_MENU_REPAIR_ENABLE = "Enable Auto Repair for Equipped Items",

    SI_PA_MENU_REPAIR_GOLD_HEADER = table.concat({"Repair with ", GetCurrencyName(CURT_MONEY)}),
    SI_PA_MENU_REPAIR_GOLD_ENABLE = table.concat({"Repair equipped Items with ", GetCurrencyName(CURT_MONEY), "?"}),
    SI_PA_MENU_REPAIR_GOLD_ENABLE_T = "When visiting a merchant, all equipped items that are at or below the defined threshold will automatically be repaired",
    SI_PA_MENU_REPAIR_GOLD_DURABILITY = "Durability threshold in %",
    SI_PA_MENU_REPAIR_GOLD_DURABILITY_T = "Repair equipped items only if they are at or below the defined durability threshold",

    SI_PA_MENU_REPAIR_REPAIRKIT_HEADER = table.concat({"Repair with ", GetString(SI_PA_MENU_BANKING_REPAIRKIT)}),
    SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE = table.concat({"Repair equipped Items with ", GetString(SI_PA_MENU_BANKING_REPAIRKIT), "?"}),
    SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE_T = "When out on the field, all equipped items that are at or below the defined threshold will automatically be repaired",
    SI_PA_MENU_REPAIR_REPAIRKIT_DEFAULT_KIT = "Default Repair Kit",
    SI_PA_MENU_REPAIR_REPAIRKIT_DEFAULT_KIT_T = "Your default repair kit will be used first when repairing items",
    SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY = "Durability threshold in %",
    SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY_T = "Repair equipped items only if they are at or below the defined durability threshold",
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING = table.concat({"Warn when low on ", GetString(SI_PA_MENU_BANKING_REPAIRKIT)}),
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING_T = table.concat({"Display a warning in the chat window if you are low on ", GetString(SI_PA_MENU_BANKING_REPAIRKIT), ". If you have none left, it will warn you once every 10 minutes at most."}),
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD = "Repair Kit threshold",
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD_T = table.concat({"If the remaining amount of ", GetString(SI_PA_MENU_BANKING_REPAIRKIT), " is below this threshold, a message is displayed in the chat window"}),

    SI_PA_MENU_REPAIR_RECHARGE_HEADER = table.concat({"Recharge Weapons with ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2)}),
    SI_PA_MENU_REPAIR_RECHARGE_ENABLE = table.concat({"Recharge equipped weapons with ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), "?"}),
    SI_PA_MENU_REPAIR_RECHARGE_ENABLE_T = "Re-Charge equipped weapons when their charge level reaches zero. It will first use the Soul Gems selected as default below.",
    SI_PA_MENU_REPAIR_RECHARGE_DEFAULT_GEM = "Default Soul Gem",
    SI_PA_MENU_REPAIR_RECHARGE_DEFAULT_GEM_T = "Your default soul gem will be used first when recharging weapons.",
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING = table.concat({"Warn when low on ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2)}),
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING_T = table.concat({"Display a warning in the chat window if you are low on ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), ". If you have none left, it will warn you once every 10 minutes at most."}),
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD = table.concat({GetString("SI_ITEMTYPE", ITEMTYPE_SOUL_GEM), " threshold"}),
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD_T = table.concat({"If the remaining amount of ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), " is below this threshold, a message is displayed in the chat window"}),

    -- Inventory Items --
    SI_PA_MENU_REPAIR_INVENTORY_HEADER = "Inventory Items",
    SI_PA_MENU_REPAIR_INVENTORY_ENABLE = "Enable Auto Repair for Inventory Items",

    SI_PA_MENU_REPAIR_GOLD_INVENTORY_ENABLE = table.concat({"Repair inventory Items with ", GetCurrencyName(CURT_MONEY), "?"}),
    SI_PA_MENU_REPAIR_GOLD_INVENTORY_ENABLE_T = "When visiting a merchant, all items in the inventory that are at or below the defined threshold will automatically be repaired",
    SI_PA_MENU_REPAIR_GOLD_INVENTORY_DURABILITY = "Durability threshold in %",
    SI_PA_MENU_REPAIR_GOLD_INVENTORY_DURABILITY_T = "Repair items in the inventory only if they are at or below the defined durability threshold",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair --
    SI_PA_CHAT_REPAIR_SUMMARY_FULL = "Repaired equipped items for %s",
    SI_PA_CHAT_REPAIR_SUMMARY_PARTIAL = "Repaired equipped items for %s (%s missing)",

    SI_PA_CHAT_REPAIR_SUMMARY_INVENTORY_FULL = "Repaired inventory items for %s",
    SI_PA_CHAT_REPAIR_SUMMARY_INVENTORY_PARTIAL = "Repaired inventory items for %s (%s missing)",

    SI_PA_CHAT_REPAIR_REPAIRKIT_REPAIRED = table.concat({"Repaired %s ", PAC.COLORS.WHITE, "(%d%%)", PAC.COLORS.DEFAULT, " with %s"}),
    SI_PA_CHAT_REPAIR_REPAIRKIT_REPAIRED_ALL = table.concat({"Repaired %s ", PAC.COLORS.WHITE, "(%d%%)", PAC.COLORS.DEFAULT, " and all other items with %s"}),
}

for key, value in pairs(PARStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end


local PARGenericStrings = {
    -- =================================================================================================================
    -- Language independent texts (do not need to be translated/copied to other languages --

    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_PA_CHAT_REPAIR_CHARGE_WEAPON = "%s (%d%% --> %d%%) - %s",
}

for key, value in pairs(PARGenericStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end
