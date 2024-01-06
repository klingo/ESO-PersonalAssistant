local PAC = PersonalAssistant.Constants
local PARStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair Menu --
    SI_PA_MENU_REPAIR_DESCRIPTION = "PARepair可以自动维修装备和充能附魔",

    -- Equipped Items --
    SI_PA_MENU_REPAIR_EQUIPPED_HEADER = "已穿戴装备",
    SI_PA_MENU_REPAIR_ENABLE = "启用自动维修已穿戴装备",

    SI_PA_MENU_REPAIR_GOLD_HEADER = table.concat({"使用", GetCurrencyName(CURT_MONEY),"维修"}),
    SI_PA_MENU_REPAIR_GOLD_ENABLE = table.concat({"是否使用", GetCurrencyName(CURT_MONEY),"维修已穿戴装备"}),
    SI_PA_MENU_REPAIR_GOLD_ENABLE_T = "打开商店时自动维修所有耐久度低于设定阈值的已穿戴装备",
    SI_PA_MENU_REPAIR_GOLD_DURABILITY = "耐久度阈值%",
    SI_PA_MENU_REPAIR_GOLD_DURABILITY_T = "仅自动维修低于或定于该阈值的已穿戴装备",

    SI_PA_MENU_REPAIR_REPAIRKIT_HEADER = table.concat({"使用", GetString(SI_PA_MENU_BANKING_REPAIRKIT),"维修"}),
    SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE = table.concat({"是否使用", GetString(SI_PA_MENU_BANKING_REPAIRKIT),"维修已穿戴装备"}),
    SI_PA_MENU_REPAIR_REPAIRKIT_ENABLE_T = "当未打开商店时，是否使用修理包自动维修已穿戴装备",
    SI_PA_MENU_REPAIR_REPAIRKIT_DEFAULT_KIT = "默认修理包",
    SI_PA_MENU_REPAIR_REPAIRKIT_DEFAULT_KIT_T = "设定的默认修理包将优先用于维修装备",
    SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY = "耐久度阈值%",
    SI_PA_MENU_REPAIR_REPAIRKIT_DURABILITY_T = "仅自动维修低于或定于该阈值的已穿戴装备",
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING = table.concat({"数量不足警告", GetString(SI_PA_MENU_BANKING_REPAIRKIT)}),
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_WARNING_T = table.concat({"当", GetString(SI_PA_MENU_BANKING_REPAIRKIT), "数量少于阈值时，在聊天框警告"}),
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD = "默认修理包数量阈值",
    SI_PA_MENU_REPAIR_REPAIRKIT_LOW_KIT_THRESHOLD_T = table.concat({"当剩余", GetString(SI_PA_MENU_BANKING_REPAIRKIT), "数量少于阈值时，在聊天窗口警告"}),

    SI_PA_MENU_REPAIR_RECHARGE_HEADER = table.concat({"使用", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM),"充能", 2)}),
    SI_PA_MENU_REPAIR_RECHARGE_ENABLE = table.concat({"是否使用", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM),"充能武器附魔",2)}),
    SI_PA_MENU_REPAIR_RECHARGE_ENABLE_T = "当武器附魔能量为0时，自动使用默认灵魂石进行充能",
    SI_PA_MENU_REPAIR_RECHARGE_DEFAULT_GEM = "默认灵魂石",
    SI_PA_MENU_REPAIR_RECHARGE_DEFAULT_GEM_T = "设定的默认灵魂石将优先用于武器附魔充能",
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING = table.concat({"数量不足警告", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), "数量少于阈值时，在聊天框警告", 2)}),
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_WARNING_T = table.concat({"当", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2), "数量少于阈值时，在聊天框警告"}),
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD = "默认灵魂石数量阈值",
    SI_PA_MENU_REPAIR_RECHARGE_LOW_GEM_THRESHOLD_T = table.concat({"当剩余",zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_SOUL_GEM), 2),"数量少于阈值时，在聊天窗口警告"}),

    -- Inventory Items --
    SI_PA_MENU_REPAIR_INVENTORY_HEADER = "修理背包中的物品",
    SI_PA_MENU_REPAIR_INVENTORY_ENABLE = "启用自动维修背包中的物品",

    SI_PA_MENU_REPAIR_GOLD_INVENTORY_ENABLE = table.concat({"使用", GetCurrencyName(CURT_MONEY),"维修背包中的物品"}),
    SI_PA_MENU_REPAIR_GOLD_INVENTORY_ENABLE_T = "打开商店时自动维修所有耐久度低于设定阈值的背包中的物品",
    SI_PA_MENU_REPAIR_GOLD_INVENTORY_DURABILITY = "耐久度阈值%",
    SI_PA_MENU_REPAIR_GOLD_INVENTORY_DURABILITY_T = "仅自动维修低于或定于该阈值的背包中的装备",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PARepair --
    SI_PA_CHAT_REPAIR_SUMMARY_FULL = "维修已穿戴装备花费%s",
    SI_PA_CHAT_REPAIR_SUMMARY_PARTIAL = "В维修已穿戴装备花费%s(%s不足)",

    SI_PA_CHAT_REPAIR_SUMMARY_INVENTORY_FULL = "维修背包中的物品花费%s",
    SI_PA_CHAT_REPAIR_SUMMARY_INVENTORY_PARTIAL = "维修背包中的物品花费%%s (%s不足)",

    SI_PA_CHAT_REPAIR_REPAIRKIT_REPAIRED = table.concat({"维修%s", PAC.COLORS.WHITE, "(%d%%)", PAC.COLORS.DEFAULT, "花费%s"}),
    SI_PA_CHAT_REPAIR_REPAIRKIT_REPAIRED_ALL = table.concat({"维修%s ", PAC.COLORS.WHITE, "(%d%%)", PAC.COLORS.DEFAULT, "和其他物品共花费%s"}),
}

for key, value in pairs(PARStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end