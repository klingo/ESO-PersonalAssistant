local PAC = PersonalAssistant.Constants
local PAStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- Profile Settings --
    SI_PA_MENU_PROFILE_PLEASE_SELECT = "<选择配置文件>",
    SI_PA_MENU_PROFILE_ACTIVE = "正在使用的配置文件",
    SI_PA_MENU_PROFILE_ACTIVE_T = "选择后会自动加载该配置文件下所有储存的设置，并保存所有更改",
    SI_PA_MENU_PROFILE_ACTIVE_RENAME = "重命名正在使用的配置文件",

    -- Create Profiles --
    SI_PA_MENU_PROFILE_CREATE_NEW = "创建新配置文件",
    SI_PA_MENU_PROFILE_CREATE_NEW_DESC = table.concat({"注意: 最多可拥有 ", PAC.GENERAL.MAX_PROFILES, " 个配置文件"}),

    -- Copy Profiles --
    SI_PA_MENU_PROFILE_COPY_FROM_DESC = "从另一个配置文件中复制相关设置",
    SI_PA_MENU_PROFILE_COPY_FROM = "复制",
    SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM = "确认复制",
    SI_PA_MENU_PROFILE_COPY_FROM_CONFIRM_W = "该操作将会使选定配置文件的设置覆盖当前配置文件，是否确认操作？ \n\n注意: 仅已经激活的 PersonalAssistant模块设置会被覆盖",

    -- Delete Profiles --
    SI_PA_MENU_PROFILE_DELETE_DESC = "删除已存在的配置文件及SavedVariables数据",
    SI_PA_MENU_PROFILE_DELETE = "删除配置文件",
    SI_PA_MENU_PROFILE_DELETE_CONFIRM = "确认删除",
    SI_PA_MENU_PROFILE_DELETE_CONFIRM_W = "该操作将会删除所有角色的下的该配置文件，是否确认操作?",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Rules Menu --
    SI_PA_MENU_RULES_HOW_TO_ADD_PAB = "右键物品选择:\n> PA Banking > Add new rule创建相关存取规则",
    SI_PA_MENU_RULES_HOW_TO_ADD_PAJ = "右键物品选择:\n> PA Junk > Mark as permanent junk创建垃圾规则",
    SI_PA_MENU_RULES_HOW_TO_FIND_MENU = table.concat({"通过[Alt]键唤起的程序页面下图标查阅所有已创建规则", PAC.COLOR.YELLOW:Colorize("/parules"), "或通过点击该按键:"}),
    SI_PA_MENU_RULES_HOW_TO_CREATE = "如何创建新的规则?",

    SI_PA_MENU_DANGEROUS_SETTING = "警告: 下方设置具有危险性! 请自行承担后果!",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Generic Menu --
    SI_PA_MENU_OTHER_SETTINGS_HEADER = "其他设置",

    SI_PA_MENU_SILENT_MODE = "静默模式 (禁用所有聊天窗口提示)",

    SI_PA_MENU_NOT_YET_IMPLEMENTED = table.concat({PAC.COLORS.RED, "尚未完善"}),


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAGeneral --
    SI_PA_CHAT_GENERAL_NEW_PROFILE_CREATED = table.concat({"创建配置文件", PAC.COLOR.WHITE:Colorize("%s"), "创建并使用"}),
    SI_PA_CHAT_GENERAL_SELECTED_PROFILE_COPIED = table.concat({"配置文件设置", PAC.COLOR.WHITE:Colorize("%s"), "被", PAC.COLOR.ORANGE_RED:Colorize("复制"), "使用", PAC.COLOR.WHITE:Colorize("%s")}),
    SI_PA_CHAT_GENERAL_SELECTED_PROFILE_DELETED = table.concat({"选定的配置文", PAC.COLOR.WHITE:Colorize("%s"), "被", PAC.COLOR.ORANGE_RED:Colorize("删除")}),

    SI_PA_CHAT_GENERAL_TELEPORT_NO_PRIMARY_HOUSE = table.concat({"选择一个房屋作为", PAC.COLOR.ORANGE_RED:Colorize("家")}),
    SI_PA_CHAT_GENERAL_TELEPORT_ZONE_PREVENTED = table.concat({"当前位置", PAC.COLOR.ORANGE_RED:Colorize("禁止"), "传送回家"}),


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAGeneral --
    SI_PA_PROFILE = "角色配置",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Name Spaces --
    SI_PA_NS_BAG_EQUIPMENT = "", -- not required so far
    SI_PA_NS_BAG_BACKPACK = "背包",
    SI_PA_NS_BAG_BANK = "银行",
    SI_PA_NS_BAG_SUBSCRIBER_BANK = "ESO Plus银行",
    SI_PA_NS_BAG_VIRTUAL = "制造背包",
    SI_PA_NS_BAG_HOUSE_BANK = "房屋存储",
    SI_PA_NS_BAG_HOUSE_BANK_NR = "房屋存储 (%d)",
    SI_PA_NS_BAG_UNKNOWN = "未知",

    -- -----------------------------------------------------------------------------------------------------------------
    -- ItemTypes (Custom Singluar/Plural definition) --
    SI_PA_ITEMTYPE4 = "<<1[食品/食品]>>", -- ITEMTYPE_FOOD
    SI_PA_ITEMTYPE5 = "<<1[杂项/杂项]>>", -- ITEMTYPE_TROPHY
    SI_PA_ITEMTYPE7 = "<<1[药水/药水]>>", -- ITEMTYPE_POTION
    SI_PA_ITEMTYPE8 = "<<1[样式/样式]>>", -- ITEMTYPE_RACIAL_STYLE_MOTIF
    SI_PA_ITEMTYPE10 = "<<1[原材料/原材料]>>", -- ITEMTYPE_INGREDIENT
    SI_PA_ITEMTYPE12 = "<<1[饮料/饮料]>>", -- ITEMTYPE_DRINK
    SI_PA_ITEMTYPE16 = "<<1[鱼饵/鱼饵]>>", -- ITEMTYPE_LURE
    SI_PA_ITEMTYPE19 = "<<1[灵魂石/灵魂石]>>", -- ITEMTYPE_SOUL_GEM
    SI_PA_ITEMTYPE22 = "<<1[撬锁/撬锁]>>", -- NOTE: Lockpicks
    SI_PA_ITEMTYPE29 = "<<1[配方/配方]>>", -- ITEMTYPE_RECIPE
    SI_PA_ITEMTYPE30 = "<<1[毒药/毒药]>>", -- ITEMTYPE_POISON
    SI_PA_ITEMTYPE33 = "<<1[溶剂/溶剂]>>",
    SI_PA_ITEMTYPE34 = "<<1[可收藏/可收藏]>>", -- ITEMTYPE_COLLECTIBLE
    SI_PA_ITEMTYPE47 = "<<1[攻城器具/攻城器具]>>", -- NOTE: unused
    SI_PA_ITEMTYPE56 = "<<1[宝藏/宝藏]>>", -- ITEMTYPE_TREASURE
    SI_PA_ITEMTYPE60 = "<<1[大师委托/大师委托]>>", -- ITEMTYPE_MASTER_WRIT

    -- -----------------------------------------------------------------------------------------------------------------
    -- SpecializedItemTypes (Custom Singluar/Plural definition) --
    SI_PA_SPECIALIZEDITEMTYPE102 = "<<1[碎片/碎片]>>",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Master Writs based on CraftingType (Custom definition) --
    SI_PA_MASTERWRIT_CRAFTINGTYPE0 = table.concat({"其他委托 (", GetString("SI_ENCHANTMENTSEARCHCATEGORYTYPE", ENCHANTMENT_SEARCH_CATEGORY_OTHER), ")"}),
    SI_PA_MASTERWRIT_CRAFTINGTYPE1 = "密封铁匠委托",
    SI_PA_MASTERWRIT_CRAFTINGTYPE2 = "密封雕文委托",
    SI_PA_MASTERWRIT_CRAFTINGTYPE3 = "密封裁缝委托",
    SI_PA_MASTERWRIT_CRAFTINGTYPE4 = "密封炼金委托",
    SI_PA_MASTERWRIT_CRAFTINGTYPE5 = "密封烹饪委托",
    SI_PA_MASTERWRIT_CRAFTINGTYPE6 = "密封木工委托",
    SI_PA_MASTERWRIT_CRAFTINGTYPE7 = "密封珠宝委托",

    -- -----------------------------------------------------------------------------------------------------------------
    -- PABanking --
    SI_PA_BANKING_MOVE_MODE_DONOTHING = "不动作",
    SI_PA_BANKING_MOVE_MODE_TOBANK = "存入",
    SI_PA_BANKING_MOVE_MODE_TOBACKPACK = "取出",

    SI_PA_MENU_BANKING_ADVANCED_GLYPHS = "雕文",
    SI_PA_MENU_BANKING_ADVANCED_INTRICATE_ITEMS = "精巧物品",
    SI_PA_MENU_BANKING_ADVANCED_ORNATE_ITEMS = "华丽物品",

    SI_PA_MENU_BANKING_REPAIRKIT = "修理包",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Operators --
    SI_PA_REL_OPERATOR_T = "选择该物品的计算方式",
    SI_PA_REL_BACKPACK_EQUAL = "背包 ==",
    SI_PA_REL_BACKPACK_LESSTHAN = "背包 <", -- not used so far
    SI_PA_REL_BACKPACK_LESSTHANEQUAL = "背包 <=",
    SI_PA_REL_BACKPACK_GREATERTHAN = "背包 >", -- not used so far
    SI_PA_REL_BACKPACK_GREATERTHANEQUAL = "背包 >=",
    SI_PA_REL_BANK_EQUAL = "银行 ==",
    SI_PA_REL_BANK_LESSTHAN = "银行 <", -- not used so far
    SI_PA_REL_BANK_LESSTHANOREQUAL = "银行 <=",
    SI_PA_REL_BANK_GREATERTHAN = "银行 >", -- not used so far
    SI_PA_REL_BANK_GREATERTHANOREQUAL = "银行 >=",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Operator Tooltip --
    SI_PA_REL_BACKPACK_EQUAL_T = "背包数量等于 (==)",
    SI_PA_REL_BACKPACK_LESSTHAN_T = "背包数量小于 (<)", -- not used so far
    SI_PA_REL_BACKPACK_LESSTHANOREQUAL_T = "背包数量小于等于 (<=)",
    SI_PA_REL_BACKPACK_GREATERTHAN_T = "背包数量大于 (>)", -- not used so far
    SI_PA_REL_BACKPACK_GREATERTHANOREQUAL_T = "背包数量大于等于 (>=)",
    SI_PA_REL_BANK_EQUAL_T = "银行数量等于 (==)",
    SI_PA_REL_BANK_LESSTHAN_T = "银行数量小于 (<)", -- not used so far
    SI_PA_REL_BANK_LESSTHANOREQUAL_T = "银行数量小于等于 (<=)",
    SI_PA_REL_BANK_GREATERTHAN_T = "银行数量大于 (>)", -- not used so far
    SI_PA_REL_BANK_GREATERTHANOREQUAL_T = "银行数量大于等于 (>=)",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Text Operators --
    SI_PA_REL_TEXT_OPERATOR0 = "-",
    SI_PA_REL_TEXT_OPERATOR1 = "等于",
    SI_PA_REL_TEXT_OPERATOR2 = "少于", -- not used so far
    SI_PA_REL_TEXT_OPERATOR3 = "最多有",
    SI_PA_REL_TEXT_OPERATOR = "多于",-- not used so far
    SI_PA_REL_TEXT_OPERATOR5 = "最少有",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Stacking types --
    SI_PA_ST_MOVE_FULL = "移动所有物品", -- 0: Full deposit
    SI_PA_ST_MOVE_INCOMPLETE_STACKS_ONLY = "仅补充已有列表", -- 1: Fill existing stacks

    -- -----------------------------------------------------------------------------------------------------------------
    -- Icon Positions --
    SI_PA_POSITION_AUTO = "自动",
    SI_PA_POSITION_MANUAL = "手动",


    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    SI_PA_ITEM_ACTION_NOTHING = "不动作",
    SI_PA_ITEM_ACTION_LAUNDER = "洗白", -- not used so far
    SI_PA_ITEM_ACTION_MARK_AS_JUNK = "标记为垃圾",
    SI_PA_ITEM_ACTION_JUNK_DESTROY_WORTHLESS = "标记为垃圾，如果无价值则摧毁",
    SI_PA_ITEM_ACTION_DESTROY_ALWAYS = "总是摧毁",


    -- =================================================================================================================
    -- == CUSTOM SUB MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_PA_SUBMENU_PAB_ADD_RULE = "添加新规则",
    SI_PA_SUBMENU_PAB_EDIT_RULE = "修改规则",
    SI_PA_SUBMENU_PAB_DELETE_RULE = "删除规则",
    SI_PA_SUBMENU_PAB_ENABLE_RULE = "启用规则",
    SI_PA_SUBMENU_PAB_DISABLE_RULE = "禁用规则",
    SI_PA_SUBMENU_PAB_ADD_RULE_BUTTON = "添加",
    SI_PA_SUBMENU_PAB_UPDATE_RULE_BUTTON = "保存",
    SI_PA_SUBMENU_PAB_DELETE_RULE_BUTTON = "删除",
    SI_PA_SUBMENU_PAB_NO_RULES = "尚未指定存储规则",
    SI_PA_SUBMENU_PAB_DISCLAIMER = "声明: 自定义存储规则会在其他自动存储规则后运行(制造, 特殊, 攻城)",

    SI_PA_SUBMENU_PAJ_MARK_PERM_JUNK = "永久标记为垃圾",
    SI_PA_SUBMENU_PAJ_UNMARK_PERM_JUNK = "取消标记为永久垃圾",
    SI_PA_SUBMENU_PAJ_NO_RULES = "尚未定义永久垃圾",


    -- =================================================================================================================
    -- == KEY BINDINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_KEYBINDINGS_CATEGORY_PA_PROFILES = "|cFFD700P|rersonal|cFFD700A|rssistant 配置文件",
    SI_KEYBINDINGS_CATEGORY_PA_MENU = "|cFFD700P|rersonal|cFFD700A|rssistant 菜单",

    SI_BINDING_NAME_PA_RULES_MAIN_MENU = "PersonalAssistant 规则",
    SI_BINDING_NAME_PA_RULES_TOGGLE_WINDOW = "显示存取/垃圾规则菜单",
    SI_BINDING_NAME_PA_TRAVEL_TO_HOUSE = "传送到家",
}

for key, value in pairs(PAStrings) do
    SafeAddString(_G[key], value, 1)
end