local PAC = PersonalAssistant.Constants
local PALStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_PA_MENU_LOOT_DESCRIPTION = "PALoot将提示您获取的重要物品，例如未知的配方、样式书或特性物品",

    -- PALoot Loot Events --
    SI_PA_MENU_LOOT_EVENTS_HEADER = "拾取提示",
    SI_PA_MENU_LOOT_EVENTS_ENABLE = "启用拾取提示",

    -- Loot Recipes
    SI_PA_MENU_LOOT_RECIPES_HEADER = table.concat({"当拾取", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2)}),
    SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG = table.concat({"> ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), "尚未学习"}),
    SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG_T = table.concat({"不论何时拾取", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), "该角色未知，在聊天窗口提示"}),

    -- Loot Motifs & Style Pages
    SI_PA_MENU_LOOT_STYLES_HEADER = "拾取风格页",
    SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG = table.concat({"> ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), "尚未学习"}),
    SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG_T = table.concat({"不论何时拾取", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), "该角色未知，在聊天窗口提示"}),
    SI_PA_MENU_LOOT_STYLEPAGES_UNKNOWN_MSG = table.concat({"> ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), "尚未学习"}),
    SI_PA_MENU_LOOT_STYLEPAGES_UNKNOWN_MSG_T = table.concat({"不论何时拾取 ", GetString("SI_SPECIALIZEDITEMTYPE",PECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), "该角色未知，在聊天窗口提示"}),

    -- Loot Equipment (Apparel, Weapons & Jewelries)
    SI_PA_MENU_LOOT_APPARELWEAPONS_HEADER = "拾取装备",
    SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG = "> 装备特性未研究",
    SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG_T = table.concat({"当拾取 ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR), ", ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS), ",或", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY), "该角色未研究，在聊天窗口提示"}),
    SI_PA_MENU_LOOT_APPARELWEAPONS_UNCOLLECTED_MSG = "> 装备未收藏",
    SI_PA_MENU_LOOT_APPARELWEAPONS_UNCOLLECTED_MSG_T = table.concat({"当拾取 ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR), ", ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS), ",或", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_JEWELRY), "套装物品未收藏，在聊天窗口提示"}),

    -- Loot Companion Items
    SI_PA_MENU_LOOT_COMPANION_ITEMS_HEADER = table.concat({"拾取伙伴用品 ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_COMPANION)}),
    SI_PA_MENU_LOOT_COMPANION_ITEMS_QUALITY_THRESHOLD = table.concat({">当拾取", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_COMPANION),}),
    SI_PA_MENU_LOOT_COMPANION_ITEMS_QUALITY_THRESHOLD_T = table.concat({"当拾取", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_COMPANION), "品质大于或等于选定品质时，在聊天窗口提示"}),
   
   -- Auto Fillet common fish
    SI_PA_MENU_LOOT_AUTO_FILLET_HEADER = table.concat({"当拾取", GetString("SI_ITEMTYPE", ITEMTYPE_FISH)}),
    SI_PA_MENU_LOOT_AUTO_FILLET = "自动切片普通鱼类",
    SI_PA_MENU_LOOT_AUTO_FILLET_T = "自动切片普通鱼类获取鱼片和鱼子酱",


    -- Inventory space warning --
    SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING = "当背包位置不足时警告",
    SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING_T = "当背包位置不足时，在聊天窗口提示",
    SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD = "背包位置警告阈值",
    SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD_T = "当空余背包位置小于或等于阈值时，在聊天窗口提示",

    -- PALoot Mark Items --
    SI_PA_MENU_LOOT_ICONS_HEADER = "物品标记",
    SI_PA_MENU_LOOT_ICONS_ENABLE = "启用物品标记",
    SI_PA_MENU_LOOT_ICONS_ANY_SHOW_TOOLTIP = "显示标记提示",

    -- Mark Recipes --
    SI_PA_MENU_LOOT_ICONS_RECIPES_HEADER = table.concat({"标记", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2)}),
    SI_PA_MENU_LOOT_ICONS_RECIPE_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "当", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), "已知"}),
    SI_PA_MENU_LOOT_ICONS_RECIPE_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "当", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), "未学习"}),

    -- Mark Motifs and Style Page Containers --
    SI_PA_MENU_LOOT_ICONS_STYLES_HEADER = "标记样式书",
    SI_PA_MENU_LOOT_ICONS_MOTIFS_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "当 ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " 已知"}),
    SI_PA_MENU_LOOT_ICONS_MOTIFS_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "当 ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), "未学习"}),
    SI_PA_MENU_LOOT_ICONS_STYLEPAGES_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "当 ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), "已知"}),
    SI_PA_MENU_LOOT_ICONS_STYLEPAGES_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "当 ", GetString("SI_SPECIALIZEDITEMTYPE", SPECIALIZED_ITEMTYPE_CONTAINER_STYLE_PAGE), "未学习"}),

    -- Mark Equipment (Apparel, Weapons & Jewelries) --
    SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_HEADER = "标记装备",
    SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SHOW_KNOWN = table.concat({">", PAC.ICONS.OTHERS.KNOWN.NORMAL, "当装备特质已研究"}),
    SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SHOW_UNKNOWN = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "当装备特质尚未研究"}),
    SI_PA_MENU_LOOT_ICONS_APPARELWEAPONS_SET_UNCOLLECTED = table.concat({">", PAC.ICONS.OTHERS.UNKNOWN.NORMAL, "当套装装备尚未收集"}),

    -- Mark Companion Items --
    SI_PA_MENU_LOOT_ICONS_MARK_COMPANION_ITEMS_HEADER = table.concat({"标记 ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_COMPANION)}),
    SI_PA_MENU_LOOT_ICONS_MARK_COMPANION_ITEMS_SHOW_ALL = table.concat({">", PAC.ICONS.OTHERS.COMPANION.NORMAL, "当物品为伙伴用品时"}),

    -- Item Icon Positioning --
    SI_PA_MENU_LOOT_ICONS_POSITIONING_DESCRIPTION = "对物品标记的位置和大小进行设置",
    SI_PA_MENU_LOOT_ICONS_KNOWN_UNKNOWN_HEADER = "已知/未学习",
    SI_PA_MENU_LOOT_ICONS_SET_COLLECTION_HEADER = "未收藏装备",
    SI_PA_MENU_LOOT_ICONS_COMPANION_ITEMS_HEADER = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_COMPANION),
    --SI_PA_MENU_LOOT_ICONS_COMPANION_ITEMS_HEADER = GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_COMPANION),

    SI_PA_MENU_LOOT_ICONS_SIZE_LIST = "标记大小(列表显示模式)",
    SI_PA_MENU_LOOT_ICONS_SIZE_LIST_T = "调整当物品以列表显示时，已知/未学习标记的大小",
    SI_PA_MENU_LOOT_ICONS_SIZE_GRID = "标记大小(网格显示模式)",
    SI_PA_MENU_LOOT_ICONS_SIZE_GRID_T = "调整当物品以网格显示时，已知/未学习标记的大小",

    SI_PA_MENU_LOOT_ICONS_X_OFFSET_LIST = "标记X坐标位置(列表显示模式)",
    SI_PA_MENU_LOOT_ICONS_X_OFFSET_LIST_T = "调整当物品以列表显示时，调整已知/未学习标记的水平位置",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_LIST = "标记Y坐标位置(列表显示模式)",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_LIST_T = "调整当物品以列表显示时，调整已知/未学习标记的垂直位置",

    SI_PA_MENU_LOOT_ICONS_X_OFFSET_GRID = "标记X坐标位置(网格显示模式)",
    SI_PA_MENU_LOOT_ICONS_X_OFFSET_GRID_T = "调整当物品以网格显示时，调整已知/未学习标记的水平位置",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_GRID = "标记Y坐标位置(网格显示模式)",
    SI_PA_MENU_LOOT_ICONS_Y_OFFSET_GRID_T = "调整当物品以网格显示时，调整已知/未学习标记的垂直位置",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PALoot --
    SI_PA_CHAT_LOOT_RECIPE_UNKNOWN = table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s可", PAC.COLORS.ORANGE,"学习", PAC.COLORS.DEFAULT, "!"}),
    SI_PA_CHAT_LOOT_MOTIF_UNKNOWN = table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s可", PAC.COLORS.ORANGE,"学习", PAC.COLORS.DEFAULT, "!"}),
    SI_PA_CHAT_LOOT_TRAIT_UNKNOWN = table.concat({PAC.ICONS.OTHERS.UNKNOWN.SMALL, "%s的[", PAC.COLORS.ORANGE,"%s", PAC.COLORS.DEFAULT,"]特质可以研究!"}),
    SI_PA_CHAT_LOOT_SET_UNCOLLECTED = table.concat({PAC.ICONS.OTHERS.UNCOLLECTED.SMALL, "%s尚未收藏!"}),
    SI_PA_CHAT_LOOT_COMPANION_ITEM = table.concat({PAC.ICONS.OTHERS.COMPANION.SMALL, "%s伙伴装备", PAC.COLOR.WHITE:Colorize("%s"), "特质!"}),
	SI_PA_CHAT_LOOT_AUTO_FILLET = "%s被切片",

    SI_PA_PATTERN_INVENTORY_COUNT = table.concat({"%s背包<<1[", PAC.COLORS.WHITE,"无/仅有", PAC.COLORS.WHITE, "%d/仅有", PAC.COLORS.WHITE, "%d]>> %s<<1[背包位置/背包位置/背包位置]>>!"}),
    SI_PA_PATTERN_REPAIRKIT_COUNT = table.concat({"%s修理包<<1[", PAC.COLORS.WHITE,"无/仅有", PAC.COLORS.WHITE, "%d/仅有", PAC.COLORS.WHITE, "%d]>> %s<<1[修理包/修理包/修理包]>> left!"}),
    SI_PA_PATTERN_SOULGEM_COUNT = table.concat({"%s灵魂石<<1[", PAC.COLORS.WHITE,"无/仅有", PAC.COLORS.WHITE, "%d/仅有", PAC.COLORS.WHITE, "%d]>> %s<<1[灵魂石/灵魂石/灵魂石]>> left!"}),


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PALoot --
    SI_PA_DISPLAY_A_MESSAGE_WHEN = "聊天窗口提示. . .",
    SI_PA_MARK_WITH = "标记 . . .",
    SI_PA_ITEM_KNOWN = "已知",
    SI_PA_ITEM_UNKNOWN = "未学习",
    SI_PA_ITEM_UNCOLLECTED = "未收藏",
    --SI_PA_ITEM_COMPANION_ITEM = "伙伴装备"
}

for key, value in pairs(PALStrings) do
    SafeAddString(_G[key], value, 1)
end