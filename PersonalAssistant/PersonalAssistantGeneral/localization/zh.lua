local PAC = PersonalAssistant.Constants
local PAStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- Welcome Messages --
    SI_PA_WELCOME_NO_SUPPORT = "高飞为您服务!  -  [%s] 本地化服务尚不支持",
    SI_PA_WELCOME_SUPPORT = "高飞为您服务!",
    SI_PA_WELCOME_PLEASE_SELECT_PROFILE = table.concat({"欢迎使用，请进入插件设置配置文件以方便使用，谢谢:-)"}),


    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    SI_PA_MENU_GENERAL_DESCRIPTION = "PersonalAssistant是一个可以使您更方便体验ESO游戏内容的功能集合。\n\n各个功能模块均可以使用跨账户配置文件，也可以为每个角色选择各自的配置文件",

    -- -----------------------------------------------------------------------------------------------------------------
    -- General Settings --
    SI_PA_MENU_GENERAL_HEADER = "综合设置",
    SI_PA_MENU_GENERAL_SHOW_WELCOME = "显示欢迎信息",

    SI_PA_MENU_GENERAL_TELEPORT_HEADER = "家",
    SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE = table.concat({PAC.ICONS.OTHERS.HOME.NORMAL, "传送到家"}),
    SI_PA_MENU_GENERAL_TELEPORT_PRIMARY_HOUSE_W = "该设置可以使您传送到家",
    SI_PA_MENU_GENERAL_TELEPORT_OUTSIDE = "传送到家门口",
    SI_PA_MENU_GENERAL_TELEPORT_OUTSIDE_T = "如果关闭，将会传送到家内",

    -- -----------------------------------------------------------------------------------------------------------------
    -- Admin Settings --
    SI_PA_MENU_ADMIN_HEADER = "管理员设置",
}

for key, value in pairs(PAStrings) do
    SafeAddString(_G[key], value, 1)
end
