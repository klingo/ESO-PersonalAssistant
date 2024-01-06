local PAIStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration Menu --
    SI_PA_MENU_INTEGRATION_DESCRIPTION = "PAIntegration可以整合PersonalAssistant插件与其他第三方插件，例如Dolgubon's Lazy Writ Crafter、FCO ItemSaver等",
    SI_PA_MENU_INTEGRATION_NOTHING_AVAILABLE = "当前未安装/启用任何PAIntegration支持的插件",

    -- Character Knowledge --
    --SI_PA_MENU_INTEGRATION_CK_CHARACTER = "当选中角色已知，则认为该知识已知",
    --SI_PA_MENU_INTEGRATION_CK_ENABLE = "启用Character Knowledge整合",
    --SI_PA_MENU_INTEGRATION_CK_ENABLE_T = table.concat({"使用Character Knowledge来决定", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " or ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), "已知"}),
    --SI_PA_MENU_INTEGRATION_CK_INITIALIZING ="Character Knowledge正在启用...",
	
    -- Dolgubon's Lazy Writ Crafter --
    SI_PA_MENU_INTEGRATION_LWC_COMPATIBILITY = "整合Dolgubon's Lazy Writ Crafter",
    SI_PA_MENU_INTEGRATION_LWC_COMPATIBILITY_T = "当拥有制造委托任务，且启用Dolgubon's Lazy Writ Crafter取出相关物品选项时，相关物品在‘存入银行’设置中将被忽略以避免取出后立即存入",

    -- FCO ItemSaver --
    SI_PA_MENU_INTEGRATION_FCOIS_LOCKED_PREVENT_SELLING = "禁止自动出售上锁的物品",
    SI_PA_MENU_INTEGRATION_FCOIS_LOCKED_PREVENT_MOVING = "禁止移动上锁的物品",
    SI_PA_MENU_INTEGRATION_FCOIS_LOCKED_PREVENT_MOVING_T = "启用后，FCO ItemSaver上锁的物品不会被存入银行，也不会被取出",
    SI_PA_MENU_INTEGRATION_FCOIS_SELL_AUTOSELL_MARKED = "在商人、销赃贩自动出售标记的物品",
    SI_PA_MENU_INTEGRATION_FCOIS_ITEM_MOVE_MARKED = "当打开银行时是否移动标记的物品",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration --


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration Menu --
    SI_PA_MENU_INTEGRATION_PAB_REQUIRED = "当PABanking启用时显示额外设置",
    SI_PA_MENU_INTEGRATION_PAJ_REQUIRED = "当PAJunk启用时显示额外设置",

    SI_PA_MENU_INTEGRATION_MORE_TO_COME = "跟多FCO ItemSaver相关支持会在未来添加",
}

for key, value in pairs(PAIStrings) do
    SafeAddString(_G[key], value, 1)
end