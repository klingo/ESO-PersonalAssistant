local PAC = PersonalAssistant.Constants
local PACOStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAConsume Menu --
    SI_PA_MENU_CONSUME_DESCRIPTION = "PAConsume可以自动使用毒药、食品饮料和经验加成道具",

    -- auto poison --
    SI_PA_MENU_CONSUME_POISON_HEADER = "自动使用毒药",
    SI_PA_MENU_CONSUME_POISON_ENABLE = "开启自动使用毒药",
	SI_PA_MENU_CONSUME_POISON_ENABLE_T = "毒药耗尽时，脱战后自动使用背包中数量最多的毒药",
	
	-- auto consume food & exp --
	SI_PA_MENU_CONSUME_FOOD_HEADER = "开启自动使用食品饮料",
	SI_PA_MENU_CONSUME_EXP_HEADER = "开启自动使用经验加成道具",
	SI_PA_MENU_CONSUME_CURRENT_FOOD_BUFF = "当前角色食品饮料Buff: ",
	SI_PA_MENU_CONSUME_CURRENT_EXP_BUFF = "当前角色经验加成Buff: ",
    SI_PA_MENU_CONSUME_LABEL_ON = "自动使用",
    SI_PA_MENU_CONSUME_LABEL_OFF = "关闭自动使用",
	SI_PA_MENU_CONSUME_USE_NUMBER_FOOD = "进食(规定时间内)",
	SI_PA_MENU_CONSUME_USE_NUMBER_FOOD_T =  "当前Buff过期后下次进食的时间，使用0至600秒内的数字进行设置",
	SI_PA_MENU_CONSUME_USE_NUMBER_EXP = "经验加成(规定时间后)",
    	SI_PA_MENU_CONSUME_USE_NUMBER_EXP_T =  "当前Buff过期后下次使用道具的时间，使用0至600秒内的数字进行设置",
    SI_PA_MENU_CONSUME_TURN_OFF_FOOD = "暂停",
    SI_PA_MENU_CONSUME_TURN_OFF_FOOD_T = "暂停自动使用食品饮料",
    SI_PA_MENU_CONSUME_TURN_OFF_EXP = "暂停",
    SI_PA_MENU_CONSUME_TURN_OFF_EXP_T = "暂停自动使用经验加成道具",



    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAConsume poison--
    SI_PA_CHAT_CONSUME_POISON_MAIN = "主武器已经涂覆",
    SI_PA_CHAT_CONSUME_POISON_BACKUP = "副武器已经涂覆",
	
	-- PAConsume food & exp--
	SI_PA_CHAT_CONSUME_NO_FOOD = "尚未选择进食物品，右键背包中的食品饮料，选择自动进食选项",
	SI_PA_CHAT_CONSUME_AUTO_EATING_OFF_BUT = "自动进食已关闭，当前自动进食偏好为 <<1>>",
	SI_PA_CHAT_CONSUME_TO_ENABLE_EATING = "右键背包中的食品饮料，选择自动进食选项以开启自动进食",
	SI_PA_CHAT_CONSUME_LOOKS_LIKE = "<<1>>已添加菜单",
	SI_PA_CHAT_CONSUME_THIS_FOOD_WILL_BE_MINUTES = "当前食品饮料Buff过期后的<<1[/$d分钟内/$d分钟内]>>，将会自动使用",
	SI_PA_CHAT_CONSUME_THIS_FOOD_WILL_BE_SECONDS = "当前食品饮料Buff过期后的<<1[/$d秒前/$d秒内]>>，将会自动使用",
	SI_PA_CHAT_CONSUME_YOU_HAVE_ONLY = "背包中<<1>>仅剩余", -- "背包中<<1[$d/仅剩余 $d/仅剩余 $d]>>"
	SI_PA_CHAT_CONSUME_YOU_HAVE = "背包中剩余<<1>>",
	SI_PA_CHAT_CONSUME_WISH_STOP_EATING = "使用PAconsume菜单以暂停自动进食",
	
	SI_PA_CHAT_CONSUME_NO_EXP = "尚未选择经验加成道具. 右键背包中的经验加成道具，选择自动加成选项",
	SI_PA_CHAT_CONSUME_AUTO_EXPING_OFF_BUT = "自动加成已关闭，当前自动加成偏好为 <<1>>",
    SI_PA_CHAT_CONSUME_TO_ENABLE_EXPING = "右键背包中的经验加成道具，选择自动加成选项以开启自动加成",
    SI_PA_CHAT_CONSUME_THIS_EXP_WILL_BE_MINUTES = "当前经验加成Buff过期后的<<1[/$d分钟后/$d分钟后]>>，将会自动使用",
    SI_PA_CHAT_CONSUME_THIS_EXP_WILL_BE_SECONDS = "当前经验加成Buff过期后的<<1[/$d秒后/$d秒后]>>，将会自动使用",
    SI_PA_CHAT_CONSUME_WISH_STOP_EXPING = "使用PAconsume菜单以暂停自动加成",

    SI_PA_CHAT_CONSUME_FOOD_WILL_BE_CONSUMED = "当前食品饮料Buff过期后 <<1>> 秒自动进食",
    SI_PA_CHAT_CONSUME_EXP_WILL_BE_CONSUMED = "当前经验加成Buff过期后<<1>>秒自动使用加成道具",
    
	SI_PA_CHAT_CONSUME_HAS_BEEN_AUTOMATICALLY_CONSUMED = "已自动使用",
	SI_PA_CHAT_CONSUME_BUT_HAVE_ZERO = "已设置自动使用<<1>>，但当前背包中数量不足",

	SI_PA_CHAT_CONSUME_FOOD_EXPIRE_SECONDS = "当前食品饮料将会在<<1[$d 秒/$d 秒/$d 秒]内过期>>",
	SI_PA_CHAT_CONSUME_FOOD_EXPIRE_MINUTES = "当前食品饮料将会在<<1[$d 分钟/$d 分钟/$d 分钟]内过期>>",
	SI_PA_CHAT_CONSUME_EXP_EXPIRE_SECONDS = "当前经验加成将会在<<1[$d 秒/$d 秒/$d 秒]内过期>>",
	SI_PA_CHAT_CONSUME_EXP_EXPIRE_MINUTES = "当前经验加成将会在<<1[$d 分钟/$d 分钟/$d 分钟]内过期]>>",
	
	

}

for key, value in pairs(PACOStrings) do
    SafeAddString(_G[key], value, 1)
end
