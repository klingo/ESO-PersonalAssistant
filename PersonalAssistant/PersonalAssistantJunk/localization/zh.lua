local PAC = PersonalAssistant.Constants
local PAJStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk Menu --
    SI_PA_MENU_JUNK_DESCRIPTION = "PAJunk将标记符合规则的物品为垃圾，除非该物品为制造或从邮件取出",

    -- Standard Items --
    SI_PA_MENU_JUNK_STANDARD_ITEMS_HEADER = "标准物品",
    SI_PA_MENU_JUNK_AUTOMARK_ENABLE = "启用自动标记垃圾",
    SI_PA_MENU_JUNK_AUTOMARK_ENABLE_T = "仅适用于'标准物品'。自定义垃圾规则不适用于该规则，如果需要禁用请在自定义规则处设置",

    SI_PA_MENU_JUNK_TRASH_AUTOMARK = table.concat({"自动标记 [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "]"}),
    SI_PA_MENU_JUNK_TRASH_AUTOMARK_T = table.concat({"自动标记 [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] 为垃圾"}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_ITEMS_DESC = table.concat({"禁止标记 [", GetString("SI_ITEMTYPE", ITEMTYPE_TRASH), "] 为垃圾，如果. . ."}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS = table.concat({"> 日常任务需要 ", PAC.COLOR.YELLOW:Colorize("鱼饵")}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_NIBBLES_AND_BITS_T = table.concat({PAC.COLOR.YELLOW:Colorize("任务所需: "), PAC.COLOR.ORANGE:Colorize("发条城"), "\n启用后，相关物品不会被标记为垃圾:\n[Carapace]\n[Daedra Husks]"}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS = table.concat({"> 日常任务需要 ", PAC.COLOR.YELLOW:Colorize("Morsels and Pecks")}),
    SI_PA_MENU_JUNK_TRASH_EXCLUDE_MORSELS_AND_PECKS_T = table.concat({PAC.COLOR.YELLOW:Colorize("任务所需: "), PAC.COLOR.ORANGE:Colorize("发条城"), "\n启用后，相关物品不会被标记为垃圾:\n[Elemental Essence]\n[Supple Roots]\n[Ectoplasm]"}),

    SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK = table.concat({"自动标记[", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "]"}),
    SI_PA_MENU_JUNK_COLLECTIBLES_AUTOMARK_T = table.concat({"自动标记拥有特性 [", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "]的物品为垃圾."}),
    SI_PA_MENU_JUNK_COLLECTIBLES_EXCLUDE_ITEMS_DESC = table.concat({"禁止标记[", GetString("SI_ITEMSELLINFORMATION", ITEM_SELL_INFORMATION_PRIORITY_SELL), "]为垃圾，如果. . ."}),
    SI_PA_MENU_JUNK_COLLECTIBLES_EXCLUDE_RARE_FISH = table.concat({"> [", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_COLLECTIBLE_RARE_FISH), "]不会被标记为垃圾", PAC.COLOR.YELLOW:Colorize("Fish Boon Feast")}),
    SI_PA_MENU_JUNK_COLLECTIBLES_EXCLUDE_RARE_FISH_T = table.concat({PAC.COLOR.YELLOW:Colorize("活动任务: "), PAC.COLOR.ORANGE:Colorize("新生节"), "冬季时，\n如果启用, 所有[", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_COLLECTIBLE_RARE_FISH),"]不会标记为垃圾"}),

    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_AUTOMARK = table.concat({"自动标记[", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "]"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_AUTOMARK_T = table.concat({"自动标记 [", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "]为垃圾"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_ITEMS_DESC = table.concat({"禁止摧毁或标记[", GetString("SI_ITEMTYPE", ITEMTYPE_TREASURE), "]为垃圾，如果 . . ."}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_LEISURE = table.concat({">日常任务需要", PAC.COLOR.YELLOW:Colorize("A Matter of Leisure")}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_LEISURE_T = table.concat({PAC.COLOR.YELLOW:Colorize("任务所需: "), PAC.COLOR.ORANGE:Colorize("发条城"), "\n启用后，相关物品不会被标记为垃圾:\n[Children's Toys]\n[Dolls]\n[Games]"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_RESPECT = table.concat({">日常任务需要", PAC.COLOR.YELLOW:Colorize("A Matter of Respect")}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_RESPECT_T = table.concat({PAC.COLOR.YELLOW:Colorize("任务所需: "), PAC.COLOR.ORANGE:Colorize("发条城"), "\n启用后，相关物品不会被标记为垃圾:\n[Utensils]\n[Drinkware]\n[Dishes and Cookware]"}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_TRIBUTES = table.concat({"> 日常任务需要 ", PAC.COLOR.YELLOW:Colorize("A Matter of Tributes")}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_A_MATTER_OF_TRIBUTES_T = table.concat({PAC.COLOR.YELLOW:Colorize("任务所需: "), PAC.COLOR.ORANGE:Colorize("发条城"), "\n启用后，相关物品不会被标记为垃圾:\n[Cosmetics]\n[Grooming Items]"}),

    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_THE_COVETOUS_COUNTESS = table.concat({"> 日常任务需要 ", PAC.COLOR.YELLOW:Colorize("The Covetous Countess")}),
    SI_PA_MENU_JUNK_MISCELLANEOUS_TREASURES_EXCLUDE_THE_COVETOUS_COUNTESS_T = table.concat({PAC.COLOR.YELLOW:Colorize("任务所需: "), PAC.COLOR.ORANGE:Colorize("Thieves Guild"), "\n启用后，相关物品不会被标记为垃圾:\n[Cosmetics]\n[Dry Goods (Linens)]\n[Wardrobe Accessories]\n\n[Drinkware]\n[Utensils]\n[Dishes and Cookware]\n\n[Games]\n[Dolls]\n[Statues]\n\n[Writings] & [Scrivener Supplies]\n[Maps]\n\n[Ritual Objects]\n[Oddities]"}),

    -- Stolen Items --
    SI_PA_MENU_JUNK_AUTOMARK_STOLEN_HEADER = "偷取的物品",
    SI_PA_MENU_JUNK_ACTION_STOLEN_PLACEHOLDER = "%s",

    -- Custom Items --
    SI_PA_MENU_JUNK_CUSTOM_ITEMS_HEADER = "自定义物品",
    SI_PA_MENU_JUNK_CUSTOM_ITEMS_DESCRIPTION = table.concat({GetString(SI_PA_MENU_RULES_HOW_TO_ADD_PAJ), "\n\n", GetString(SI_PA_MENU_RULES_HOW_TO_FIND_MENU)}),

    -- Quest Items --
    SI_PA_MENU_JUNK_QUEST_ITEMS_HEADER = "保护任务用品",
    SI_PA_MENU_JUNK_QUEST_CLOCKWORK_CITY_HEADER = "发条城",
    SI_PA_MENU_JUNK_QUEST_THIEVES_GUILD_HEADER = "盗贼公会",
    SI_PA_MENU_JUNK_QUEST_NEW_LIFE_FESTIVAL_HEADER = "新生节",

    -- Auto-Sell --
    SI_PA_MENU_JUNK_AUTO_SELL_JUNK_HEADER = "自动出售垃圾",

    -- Auto-Destroy --
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_HEADER = "自动摧毁垃圾",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK = "启用自动摧毁垃圾",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_T = "当获取的物品符合自动标记为垃圾的条件，且销售价值或物品品质低于设定的阈值时，则自动摧毁。该操作不可逆转!",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_W = "警告：请注意启用该设置后，摧毁符合条件的物品不会要求您二次确认！\n该类物品将被直接摧毁!\n永久性!\n请自行承担后果!",

    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_JUNK_HEADER = "垃圾",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_MAX_VALUE_THRESHOLD = "当出售价值小于等于",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_MAX_VALUE_THRESHOLD_T = "仅自动摧毁销售价格小于或等于阈值的垃圾，一旦该物品被摧毁，无法找回!",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_MAX_QUALITY_THRESHOLD = "且物品品质小于或等于",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_MAX_QUALITY_THRESHOLD_T = "仅自动摧毁品质低于或等于阈值的垃圾，一旦该物品被摧毁，无法找回!",
    SI_PA_MENU_JUNK_AUTO_DESTROY_JUNK_EXCLUSION_DISCLAIMER = "例外：任何'未知'的物品（配方，样式书，样式书页等）永远不会被自动摧毁，即使符合销售价格和物品品质的阈值",

    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_JUNK_HEADER = "偷取的垃圾",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK = "启用自动摧毁偷取的垃圾",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_T = "当偷取的物品符合自动标记为垃圾的条件，且销售价值或物品品质低于设定的阈值时，则自动摧毁。该操作不可逆转!",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_MAX_VALUE_THRESHOLD = "当销赃价值小于等于",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_MAX_VALUE_THRESHOLD_T = "仅自动摧毁销赃价格小于或等于阈值的垃圾，一旦该物品被摧毁，无法找回!",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_MAX_QUALITY_THRESHOLD = "且物品品质小于或等于",
    SI_PA_MENU_JUNK_AUTO_DESTROY_STOLEN_JUNK_MAX_QUALITY_THRESHOLD_T = "仅自动摧毁品质小于或等于阈值的垃圾，一旦该物品被摧毁，无法找回!",

    -- Other Settings --
    SI_PA_MENU_JUNK_MAILBOX_IGNORE = "禁止标记通过邮件获取的物品为垃圾",
    SI_PA_MENU_JUNK_MAILBOX_IGNORE_T = "通过邮件获取的物品永远不会被标记为垃圾",
    SI_PA_MENU_JUNK_CRAFTED_IGNORE = "禁止标记玩家制造的物品为垃圾",
    SI_PA_MENU_JUNK_CRAFTED_IGNORE_T = "玩家制造的物品永远不会被标记为垃圾",
    SI_PA_MENU_JUNK_AUTOSELL_JUNK = "在商人或销赃处自动出售垃圾",
    SI_PA_MENU_JUNK_AUTOSELL_JUNK_PIRHARRI = "允许自动出售给销赃盟友",
    SI_PA_MENU_JUNK_AUTOSELL_JUNK_PIRHARRI_W = "销赃盟友会额外收取35%走私费用",

    SI_PA_MENU_JUNK_KEYBINDINGS_HEADER = "快捷键",
    SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_JUNK_ENABLE = "启用\"标记为垃圾\"快捷键",
    SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_JUNK_SHOW = "显示\"标记为垃圾\"快捷键",
    SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_PERM_JUNK_ENABLE = "启用\"永久标记为垃圾\"快捷键",
    SI_PA_MENU_JUNK_KEYBINDINGS_MARK_UNMARK_PERM_JUNK_SHOW = "显示\"永久标记为垃圾\"快捷键",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_ENABLE = "启用\"摧毁物品\"快捷键",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_ENABLE_W = "警告:注意通过该快捷键摧毁物品不会要求您二次确认！\n该物品将被直接摧毁!\n永久性!\n请自行承担后果!",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_ITEM_SHOW = "显示\"摧毁物品\"快捷键",
    SI_PA_MENU_JUNK_KEYBINDINGS_EXCLUDE_DESCRIPTION = "禁用\"摧毁物品\"快捷键，如果物品 . . .",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_QUALITY_THRESHOLD = "> 大于或等于设定的品质",
    SI_PA_MENU_JUNK_KEYBINDINGS_DESTROY_UNKNOWN = "> 可以被学习/研究",

    -- General texts used across: Weapons, Armor, Jewelry
    SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD = "自动标记 %s 小于或等于品质",
    SI_PA_MENU_JUNK_AUTOMARK_QUALITY_THRESHOLD_T = "自动标记%s为垃圾，如果小于或等于所选品质",
    SI_PA_MENU_JUNK_AUTOMARK_ORNATE = table.concat({"自动标记%s[", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "]特性"}),
    SI_PA_MENU_JUNK_AUTOMARK_ORNATE_T = table.concat({"自动标记%s[", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "]特性(increased sell price)为垃圾?"}),
    SI_PA_MENU_JUNK_AUTOMARK_INTRICATE = table.concat({"自动标记%s[", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE), "]特性"}),
    SI_PA_MENU_JUNK_AUTOMARK_INTRICATE_T = table.concat({"自动标记%s[", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE), "]特性(increased inspiration)为垃圾?"}),
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS = "自动标记%s套装物品",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_SETS_T = "如果关闭,仅%s不属于套装的物品将被标记为垃圾",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_KNOWN_TRAITS = "自动标记%s已知特性",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_KNOWN_TRAITS_T = "如果关闭, 仅%s无特性或未知特性物品会被标记为垃圾",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS = "标记%s未知特性",
    SI_PA_MENU_JUNK_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T = "如果关闭, 仅%s无特性或已知特性物品会被标记为垃圾",


    -- =================================================================================================================
    -- == MAIN MENU TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    SI_PA_MAINMENU_JUNK_HEADER = "垃圾标记规则",

    SI_PA_MAINMENU_JUNK_HEADER_ITEM = "物品",
    SI_PA_MAINMENU_JUNK_HEADER_JUNK_COUNT = "垃圾数量",
    SI_PA_MAINMENU_JUNK_HEADER_LAST_JUNK = "最近的垃圾",
    SI_PA_MAINMENU_JUNK_HEADER_RULE_ADDED = "已添加规则",
    SI_PA_MAINMENU_JUNK_HEADER_ACTIONS = "操作",

    SI_PA_MAINMENU_JUNK_ROW_NEVER_JUNKED = "绝不",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAJunk --
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TRASH = table.concat({"将%s移动至垃圾箱(", PAC.COLOR.ORANGE:Colorize(GetString("SI_ITEMTYPE", ITEMTYPE_TRASH)), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_ORNATE = table.concat({"将%s移动至垃圾箱(", PAC.COLOR.ORANGE:Colorize(GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE)), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_QUALITY = table.concat({"将%s移动至垃圾箱(", PAC.COLOR.ORANGE:Colorize("品质"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_MERCHANT = table.concat({"将%s移动至垃圾箱(", PAC.COLOR.ORANGE:Colorize("出售"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_TREASURE = table.concat({"将%s移动至垃圾箱(", PAC.COLOR.ORANGE:Colorize("宝藏"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_KEYBINDING = table.concat({"将%s移动至垃圾箱(", PAC.COLOR.ORANGE:Colorize("手动"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_STOLEN = table.concat({"将%s移动至垃圾箱(", PAC.COLOR.ORANGE:Colorize("偷取"), ")"}),
    SI_PA_CHAT_JUNK_MARKED_AS_JUNK_PERMANENT = table.concat({"将%s移动至垃圾箱(", PAC.COLOR.ORANGE:Colorize("永久规则"), ")"}),

    SI_PA_CHAT_JUNK_DESTROYED_KEYBINDING = table.concat({PAC.COLOR.ORANGE_RED:Colorize("摧毁"), " %d x %s"}),
    SI_PA_CHAT_JUNK_DESTROYED_ALWAYS = table.concat({PAC.COLOR.ORANGE_RED:Colorize("摧毁"), " %d x %s (", PAC.COLOR.ORANGE:Colorize("总是"), ")"}),
    SI_PA_CHAT_JUNK_DESTROYED_CRITERIA_MATCH = table.concat({PAC.COLOR.ORANGE_RED:Colorize("摧毁"), " %d x %s (出售价格: %s)"}),

    SI_PA_CHAT_JUNK_DESTROY_ON = table.concat({"自动摧毁垃圾已", PAC.COLOR.RED:Colorize("开启")}),
    SI_PA_CHAT_JUNK_DESTROY_OFF = table.concat({"自动摧毁垃圾已", PAC.COLOR.GREEN:Colorize("关闭")}),
    SI_PA_CHAT_JUNK_DESTROY_STOLEN_ON = table.concat({"自动摧毁偷取物品已", PAC.COLOR.RED:Colorize("开启")}),
    SI_PA_CHAT_JUNK_DESTROY_STOLEN_OFF = table.concat({"自动摧毁偷取物品已", PAC.COLOR.GREEN:Colorize("关闭")}),

    SI_PA_CHAT_JUNK_SOLD_ITEMS_INFO = "已%s价格出售物品",
    SI_PA_CHAT_JUNK_FENCE_LIMIT_HOURS = table.concat({GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), "请等待~%d小时"}),
    SI_PA_CHAT_JUNK_FENCE_LIMIT_MINUTES = table.concat({GetString("SI_STOREFAILURE", STORE_FAILURE_AT_FENCE_LIMIT), "请等待~%d分钟"}),
    SI_PA_CHAT_JUNK_FENCE_ITEM_WORTHLESS = table.concat({"无法出售%s. ", GetString("SI_STOREFAILURE", STORE_FAILURE_WORTHLESS_TO_FENCE)}),
    SI_PA_CHAT_JUNK_CANNOT_SELL_ITEM = "无法出售%s",

    SI_PA_CHAT_JUNK_RULES_ADDED = table.concat({"%s已", PAC.COLOR.ORANGE:Colorize("添加"), "永久垃圾列表!"}),
    SI_PA_CHAT_JUNK_RULES_DELETED = table.concat({"%s已", PAC.COLOR.ORANGE:Colorize("移除"), "永久垃圾垃圾!"}),


    -- =================================================================================================================
    -- == KEY BINDINGS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- Addon Keybindings menu --
    SI_BINDING_NAME_PA_JUNK_TOGGLE_ITEM = "标为垃圾",
    SI_BINDING_NAME_PA_JUNK_PERMANENT_TOGGLE_ITEM = "永久性标记为垃圾",
    SI_BINDING_NAME_PA_JUNK_DESTROY_ITEM = "摧毁",

    -- Actual keybindings --
    SI_PA_ITEM_ACTION_MARK_AS_PERM_JUNK = "永久性标为垃圾",
    SI_PA_ITEM_ACTION_UNMARK_AS_PERM_JUNK = "取消永久性标为垃圾",


    -- =================================================================================================================
    -- == OTHER STRINGS == --   !!! NEED TO BE AN EXACT MATCH WITH THE "TAG" ON THE ITEM !!!
    -- -----------------------------------------------------------------------------------------------------------------
    -- Quest: "A Matter of Leisure"
    SI_PA_TREASURE_ITEM_TAG_DESC_TOYS = "Children's Toys",
    SI_PA_TREASURE_ITEM_TAG_DESC_DOLLS = "Dolls",
    SI_PA_TREASURE_ITEM_TAG_DESC_GAMES = "Games",

    -- Quest: "A Matter of Respect"
    SI_PA_TREASURE_ITEM_TAG_DESC_UTENSILS = "Utensils",
    SI_PA_TREASURE_ITEM_TAG_DESC_DRINKWARE = "Drinkware",
    SI_PA_TREASURE_ITEM_TAG_DESC_DISHES_COOKWARE = "Dishes and Cookware",

    -- Quest: "A Matter of Tributes"
    SI_PA_TREASURE_ITEM_TAG_DESC_COSMETICS = "Cosmetics",
    SI_PA_TREASURE_ITEM_TAG_DESC_GROOMING = "Grooming Items",

    -- Quest: "The Covetous Countess" (only additional tags)
    SI_PA_TREASURE_ITEM_TAG_DESC_LINENS = "Dry Goods",
    SI_PA_TREASURE_ITEM_TAG_DESC_ACCESSORIES = "Wardrobe Accessories",
    SI_PA_TREASURE_ITEM_TAG_DESC_STATUES = "Statues",
    SI_PA_TREASURE_ITEM_TAG_DESC_WRITINGS = "Writings",
    SI_PA_TREASURE_ITEM_TAG_DESC_SCRIVENER = "Scrivener Supplies",
    SI_PA_TREASURE_ITEM_TAG_DESC_MAPS = "Maps",
    SI_PA_TREASURE_ITEM_TAG_DESC_RITUAL_OBJECTS = "Ritual Objects",
    SI_PA_TREASURE_ITEM_TAG_DESC_ODDITIES = "Oddities",

    -- OTHERS: Not yet used
    SI_PA_TREASURE_ITEM_TAG_DESC_INSTRUMENTS = "Musical Instruments",
    SI_PA_TREASURE_ITEM_TAG_DESC_ARTWORK = "Artwork",
    SI_PA_TREASURE_ITEM_TAG_DESC_DECOR = "Wall Décor",
    SI_PA_TREASURE_ITEM_TAG_DESC_TRIFLES_ORNAMENTS = "Trifles and Ornaments",
    SI_PA_TREASURE_ITEM_TAG_DESC_DEVICES = "Devices",
    SI_PA_TREASURE_ITEM_TAG_DESC_SMITHING = "Smithing Equipment",
    SI_PA_TREASURE_ITEM_TAG_DESC_TOOLS = "Tools",
    SI_PA_TREASURE_ITEM_TAG_DESC_MEDICAL_SUPPLIES = "Medical Supplies",
    SI_PA_TREASURE_ITEM_TAG_DESC_CURIOSITIES = "Magic Curiosities",
    SI_PA_TREASURE_ITEM_TAG_DESC_FURNISHINGS = "Furnishings",
    SI_PA_TREASURE_ITEM_TAG_DESC_LIGHTS = "Lights",


    -- =================================================================================================================
    -- PAJunk Menu --
    -- Fix wrong endings of headers and fix unused collectibles translation
    SI_PA_MENU_JUNK_COLLECTIBLES_HEADER = zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_COLLECTIBLE), 2),
    SI_PA_MENU_JUNK_WEAPONS_HEADER = zo_strformat(GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS), 1),
    SI_PA_MENU_JUNK_ARMOR_HEADER= zo_strformat(GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR),1 ),
    SI_PA_MENU_JUNK_JEWELRY_HEADER = zo_strformat(GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY), 1),
}

for key, value in pairs(PAJStrings) do
    SafeAddString(_G[key], value, 1)
end
