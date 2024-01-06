local PAC = PersonalAssistant.Constants
local PABStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking Menu --
    SI_PA_MENU_BANKING_DESCRIPTION = "PABanking可以自动存取货币、制造材料和其他物品",

    -- Currencies --
    SI_PA_MENU_BANKING_CURRENCY_HEADER = "货币",
    SI_PA_MENU_BANKING_CURRENCY_ENABLE = "启用货币存取",
    SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP = "当前角色最少余额",
    SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP = "当前角色最大余额",

    -- Crafting Items --
    SI_PA_MENU_BANKING_CRAFTING_HEADER = "制造材料",
    SI_PA_MENU_BANKING_CRAFTING_ENABLE = "启用制造材料存取",
    SI_PA_MENU_BANKING_CRAFTING_ENABLE_T = "为不同制造材料启用自动存取",
    SI_PA_MENU_BANKING_CRAFTING_DESCRIPTION = "为制造材料设置独立规则(存放, 移除 或 忽略) ",
    SI_PA_MENU_BANKING_CRAFTING_ESOPLUS_DESC = "作为ESO会员，无需启用制造材料存取功能",
    SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE = "将上列所有制造材料设置为",
    SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE_T = "将上列所有制造材料设置为'存放', '取出', or to '无动作'",

    -- Advanced Items --
    SI_PA_MENU_BANKING_ADVANCED_HEADER = "特殊物品",
    SI_PA_MENU_BANKING_ADVANCED_ENABLE = "启用特殊物品存取",
    SI_PA_MENU_BANKING_ADVANCED_ENABLE_T = "为不同特殊物品启用自动存取",
    SI_PA_MENU_BANKING_ADVANCED_DESCRIPTION = "为制造材料设置独立规则(存放, 移除或忽略)",

    SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE = "将上列所有特殊物品设置为",
    SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE_T = "将上列所有特殊物品设置为'存放', '取出', or to '无动作'",

    SI_PA_MENU_BANKING_ADVANCED_KNOWN_ITEMTYPE8 = table.concat({PAC.ICONS.OTHERS.KNOWN.NORMAL, "已知样式书"}),
    SI_PA_MENU_BANKING_ADVANCED_KNOWN_ITEMTYPE29 = table.concat({PAC.ICONS.OTHERS.KNOWN.NORMAL, "已知配方"}),
    SI_PA_MENU_BANKING_ADVANCED_UNKNOWN_ITEMTYPE8 = table.concat({PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "未知样式书"}),
    SI_PA_MENU_BANKING_ADVANCED_UNKNOWN_ITEMTYPE29 = table.concat({PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "未知配方"}),

    -- Individual Items --
    SI_PA_MENU_BANKING_INDIVIDUAL_HEADER = "自定义物品",
    SI_PA_MENU_BANKING_INDIVIDUAL_DISABLED_DESCRIPTION = table.concat({"在此进行自定义物品规则设置", GetString(SI_PA_MENU_RULES_HOW_TO_ADD_PAB), "\n\n", GetString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU)}),

    -- AvA Items --
    SI_PA_MENU_BANKING_AVA_HEADER = "攻城器具",
    SI_PA_MENU_BANKING_AVA_ENABLE = "启用攻城器具存取",
    SI_PA_MENU_BANKING_AVA_ENABLE_T = "为不同攻城器具启用自动存取",
    SI_PA_MENU_BANKING_AVA_DESCRIPTION = "设置背包中保留的攻城器具数量",
    SI_PA_MENU_BANKING_AVA_OTHER_HEADER = "其他",

    -- Other Settings --
    SI_PA_MENU_BANKING_AUTO_ITEM_TRANSFER_EXECUTION = "自动运行PABanking存取操作",
    SI_PA_MENU_BANKING_AUTO_ITEM_TRANSFER_EXECUTION_T = "当打开银行时自动运行所有物品存取操作，当关闭时，也可以在银行界面手动运行",

    SI_PA_MENU_BANKING_OTHER_DEPOSIT_STACKING = "存取规则",
    SI_PA_MENU_BANKING_OTHER_DEPOSIT_STACKING_T = "决定将是否将所有物品存放, 或仅存放银行中已存在物品",
    SI_PA_MENU_BANKING_OTHER_WITHDRAWAL_STACKING = "取出规则",
    SI_PA_MENU_BANKING_OTHER_WITHDRAWAL_STACKING_T = "决定将是否将所有物品取出, 或仅取出背包中已存在物品",

    SI_PA_MENU_BANKING_EXCLUDE_JUNK = "不移动标记为垃圾的物品",

    SI_PA_MENU_BANKING_OTHER_AUTOSTACKBAGS = "打开银行时自动堆叠所有物品",
    SI_PA_MENU_BANKING_OTHER_AUTOSTACKBAGS_T = "当打开银行时是否自动堆叠银行和背包中的所有物品来保持界面清爽",

    -- Generic definitions for any type --
    SI_PA_MENU_BANKING_ANY_CURRENCY_ENABLE = "存放/取出 %s",

    SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK = "持有数量",
    SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK_T = "决定该物品在银行和背包中的数量",

    SI_PA_MENU_BANKING_ANY_MINTOKEEP_T = "角色背包中最少拥有%s;当不足时从银行取出差额",
    SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T = "角色背包中最多拥有%s;超过的数量将存入银行",

    SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_W = "该操作无法撤销，所有选中的数据将无法恢复",

    -- Correct wrong language forms
    SI_PA_MENU_BANKING_ADVANCED_TROPHIES_TREASURE_MAPS_HEADER = table.concat({zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_TROPHY), 2), ":藏宝图"}),
    SI_PA_MENU_BANKING_ADVANCED_TROPHIES_SURVEY_REPORTS_HEADER = table.concat({zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_TROPHY), 2), ":调查报告"}),

    -- =================================================================================================================
    -- == MAIN MENU TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_PA_MAINMENU_BANKING_HEADER = "存取规则",

    SI_PA_MAINMENU_BANKING_HEADER_CATEGORY = "L", -- First letter of "Category"
    SI_PA_MAINMENU_BANKING_HEADER_BAG = "位置",
    SI_PA_MAINMENU_BANKING_HEADER_RULE = "规则",
    SI_PA_MAINMENU_BANKING_HEADER_AMOUNT = "数量",
    SI_PA_MAINMENU_BANKING_HEADER_ITEM = "物品",
    SI_PA_MAINMENU_BANKING_HEADER_ACTIONS = "动作",


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking Add Custom Rule Description --
    SI_PA_DIALOG_BANKING_BANK_EXACTLY_PRE = "%s的数量应当为%d",
    SI_PA_DIALOG_BANKING_BANK_LESSTHANOREQUAL_PRE = "%s最多数量为%d",
    SI_PA_DIALOG_BANKING_BANK_GREATERTHANOREQUAL_PRE = "%s最小数量为%d",
    SI_PA_DIALOG_BANKING_BANK_EXACTLY_NOTHING = "%s的数量>%d=>无操作",
    SI_PA_DIALOG_BANKING_BANK_EXACTLY_DEPOSIT = "%s的数量>%d=>将物品转移至%s直到数量为%d",
    SI_PA_DIALOG_BANKING_BANK_FROM_TO_NOTHING = "%s的数量> %d - %d=> 无操作",
    SI_PA_DIALOG_BANKING_BANK_FROM_TO_DEPOSIT = "%s的数量> %d - %d=> 将物品转移至%s直到数量为%d",
    SI_PA_DIALOG_BANKING_BANK_FROM_TO_WITHDRAW = "%s的数量> %d - %d=> 将物品转移出%s直到数量为%d",

    SI_PA_DIALOG_BANKING_BACKPACK_EXACTLY_PRE = "%s的数量应当为%d",
    SI_PA_DIALOG_BANKING_BACKPACK_LESSTHANOREQUAL_PRE = "%s最多数量为%d",
    SI_PA_DIALOG_BANKING_BACKPACK_GREATERTHANOREQUAL_PRE = "%s最小数量为%d",
    SI_PA_DIALOG_BANKING_BACKPACK_EXACTLY_NOTHING = "%s的数量>%d=>无操作",
    SI_PA_DIALOG_BANKING_BACKPACK_EXACTLY_DEPOSIT = "%s的数量>%d=>将物品转移至%s直到数量为%d",
    SI_PA_DIALOG_BANKING_BACKPACK_FROM_TO_NOTHING = "%s的数量> %d - %d=> 无操作",
    SI_PA_DIALOG_BANKING_BACKPACK_FROM_TO_DEPOSIT = "%s的数量> %d - %d=> 将物品转移至%s直到数量为%d",
    SI_PA_DIALOG_BANKING_BACKPACK_FROM_TO_WITHDRAW = "%s的数量> %d - %d=> 将物品转移出%s直到数量为%d",

    SI_PA_DIALOG_BANKING_EXPLANATION = "如果账户拥有 . . .",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_PA_CHAT_BANKING_FINISHED = "物品转移完毕",

    SI_PA_CHAT_BANKING_WITHDRAWAL_COMPLETE = "已取出%s",
    SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_SOURCE = "已取出%s / %s(银行无剩余)",
    SI_PA_CHAT_BANKING_WITHDRAWAL_PARTIAL_TARGET = "已取出%s / %s %s(背包已满)",

    SI_PA_CHAT_BANKING_DEPOSIT_COMPLETE = "已存入%s",
    SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_SOURCE = "已存入%s / %s(角色无剩余)",
    SI_PA_CHAT_BANKING_DEPOSIT_PARTIAL_TARGET = "已存入%s / %s(背包已满)",

    SI_PA_CHAT_BANKING_ITEMS_MOVED_COMPLETE = "%d x %s 已移动到 %s",
    SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_OUTOFSPACE = "无法将 %s 移动到 %s. 空间不足!",
    SI_PA_CHAT_BANKING_ITEMS_NOT_MOVED_BANKCLOSED = "无法将 %s 移动到 %s. 界面已关闭!",
    SI_PA_CHAT_BANKING_ITEMS_SKIPPED_LWC = "未防止干扰Dolgubon's Lazy Writ Crafter，部分物品未存入",

    SI_PA_CHAT_BANKING_RULES_ADDED = table.concat({"%s相关规则", PAC.COLOR.ORANGE:Colorize("已添加"), "!"}),
    SI_PA_CHAT_BANKING_RULES_UPDATED = table.concat({"%s相关规则", PAC.COLOR.ORANGE:Colorize("已更新"), "!"}),
    SI_PA_CHAT_BANKING_RULES_DELETED = table.concat({"%s相关规则", PAC.COLOR.ORANGE:Colorize("已删除"), "!"}),
    SI_PA_CHAT_BANKING_RULES_ENABLED = table.concat({"%s相关规则", PAC.COLOR.ORANGE:Colorize("已启用"), "!"}),
    SI_PA_CHAT_BANKING_RULES_DISABLED = table.concat({"%s相关规则", PAC.COLOR.ORANGE:Colorize("已禁止"), "!"}),


    -- =================================================================================================================
    -- == KEY BINDINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_BINDING_NAME_PA_BANKING_EXECUTE_ITEM_TRANSFERS = "运行PABanking",
    SI_BINDING_NAME_PA_BANKING_EXECUTE_ITEM_TRANSFERS_PENDING = "PABanking正在运行...",
}

for key, value in pairs(PABStrings) do
    SafeAddString(_G[key], value, 1)
end
