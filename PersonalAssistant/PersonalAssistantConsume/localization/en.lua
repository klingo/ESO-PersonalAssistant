local PAC = PersonalAssistant.Constants
local PACOStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAConsume Menu --
    SI_PA_MENU_CONSUME_DESCRIPTION = "PAConsume can apply poison, or consume food/drink & EXP scrolls",

    -- auto poison --
    SI_PA_MENU_CONSUME_POISON_HEADER = "Auto Apply Poison",
    SI_PA_MENU_CONSUME_POISON_ENABLE = "Enable Auto Apply Poison",
	SI_PA_MENU_CONSUME_POISON_ENABLE_T = "Auto apply your most stacked poison after combat if there is no more on the weapon",
	
	-- auto consume food & exp --
	SI_PA_MENU_CONSUME_FOOD_HEADER = "Auto Consume Food/Drink",
	SI_PA_MENU_CONSUME_EXP_HEADER = "Auto Consume EXP Scrolls",
	SI_PA_MENU_CONSUME_CURRENT_FOOD_BUFF = "Current food buff for this character: ",
	SI_PA_MENU_CONSUME_CURRENT_EXP_BUFF = "Current EXP buff for this character: ",
    SI_PA_MENU_CONSUME_LABEL_ON = "Consume Automatically",
    SI_PA_MENU_CONSUME_LABEL_OFF = "Stop Consuming Automatically",
	SI_PA_MENU_CONSUME_USE_NUMBER_FOOD = "Buffer (seconds before)",
	SI_PA_MENU_CONSUME_USE_NUMBER_FOOD_T =  "Seconds to use food buff before the current buff expires. Use a number between 0 and 600 seconds to change food buffer time.",
	SI_PA_MENU_CONSUME_USE_NUMBER_EXP = "Buffer (seconds after)",
    SI_PA_MENU_CONSUME_USE_NUMBER_EXP_T =  "Seconds to use EXP buff after the current buff expires. Use a number between 0 and 600 seconds to change EXP buffer time.",
    SI_PA_MENU_CONSUME_TURN_OFF_FOOD = "Suspend",
    SI_PA_MENU_CONSUME_TURN_OFF_FOOD_T = "Stop consuming that food/drink for now",
    SI_PA_MENU_CONSUME_TURN_OFF_EXP = "Suspend",
    SI_PA_MENU_CONSUME_TURN_OFF_EXP_T = "Stop consuming that EXP buff for now",



    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAConsume poison--
    SI_PA_CHAT_CONSUME_POISON_MAIN = "Main weapon has been imbued with ",
    SI_PA_CHAT_CONSUME_POISON_BACKUP = "Backup weapon has been imbued with ",
	
	-- PAConsume food & exp--
	SI_PA_CHAT_CONSUME_NO_FOOD = "No food has been selected yet. Open inventory, right click on the food or drink stack you want, and choose the Consume Automatically option.",
	SI_PA_CHAT_CONSUME_AUTO_EATING_OFF_BUT = "Automatic eating is turned off. But you have selected <<1>> as your preferred food.",
	SI_PA_CHAT_CONSUME_TO_ENABLE_EATING = "To enable automatic eating for this character open inventory, right click on the food or drink you want, and choose the Consume Automatically option.",
	SI_PA_CHAT_CONSUME_LOOKS_LIKE = "Looks like <<1>> is on the menu.",
	SI_PA_CHAT_CONSUME_THIS_FOOD_WILL_BE_MINUTES = "This will be consumed  <<1[when/$d minute before/$d minutes before]>> your current food expires.",
	SI_PA_CHAT_CONSUME_THIS_FOOD_WILL_BE_SECONDS = "This will be consumed  <<1[when/$d second before/$d seconds before]>> your current food expires.",
	SI_PA_CHAT_CONSUME_YOU_HAVE_ONLY = "You have only <<1>> left in your bag.", -- "You have <<1[$d/only $d/only $d]>> left in your bag."
	SI_PA_CHAT_CONSUME_YOU_HAVE = "You have <<1>> left in your bag.",
	SI_PA_CHAT_CONSUME_WISH_STOP_EATING = "If you wish to stop automatic eating for this character, use the PAconsume menu.",
	
	SI_PA_CHAT_CONSUME_NO_EXP = "No EXP buff has been selected yet. Open inventory, right click on the EXP scroll stack you want, and choose the Consume Automatically option.",
	SI_PA_CHAT_CONSUME_AUTO_EXPING_OFF_BUT = "Automatic EXP buff consuming is turned off. But you have selected <<1>> as your preferred EXP.",
    SI_PA_CHAT_CONSUME_TO_ENABLE_EXPING = "To enable EXP buff consuming for this character open inventory, right click on the EXP scroll you want, and choose the Consume Automatically option.",
    SI_PA_CHAT_CONSUME_THIS_EXP_WILL_BE_MINUTES = "This will be consumed  <<1[when/$d minute after/$d minutes after]>> your current EXP buff expires.",
    SI_PA_CHAT_CONSUME_THIS_EXP_WILL_BE_SECONDS = "This will be consumed  <<1[when/$d second after/$d seconds after]>> your current EXP buff expires.",
    SI_PA_CHAT_CONSUME_WISH_STOP_EXPING = "If you wish to stop automatic EXP buff consuming for this character, , use the PAconsume menu.",

    SI_PA_CHAT_CONSUME_FOOD_WILL_BE_CONSUMED = "Food will be consumed <<1>> seconds before current food expires.",
    SI_PA_CHAT_CONSUME_EXP_WILL_BE_CONSUMED = "EXP buff will be consumed <<1>> seconds after current EXP buff expires.",
    
	SI_PA_CHAT_CONSUME_HAS_BEEN_AUTOMATICALLY_CONSUMED = " has been automatically consumed.",
	SI_PA_CHAT_CONSUME_BUT_HAVE_ZERO = "You have set <<1>> to Consume Automatically but have 0 in your bag.",

	SI_PA_CHAT_CONSUME_FOOD_EXPIRE_SECONDS = "Your current food will expire in <<1[$d seconds./$d second./$d seconds.]>>",
	SI_PA_CHAT_CONSUME_FOOD_EXPIRE_MINUTES = "Your current food will expire in <<1[$d minutes./$d minute./$d minutes.]>>",
	SI_PA_CHAT_CONSUME_EXP_EXPIRE_SECONDS = "Your current EXP buff will expire in <<1[$d seconds./$d second./$d seconds.]>>",
	SI_PA_CHAT_CONSUME_EXP_EXPIRE_MINUTES = "Your current EXP buff expire in <<1[$d minutes./$d minute./$d minutes.]>>",
	
	

}

for key, value in pairs(PACOStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end


local PACOGenericStrings = {
    -- =================================================================================================================
    -- Language independent texts (do not need to be translated/copied to other languages --

    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    --SI_PA_CHAT_Consume_CHARGE_WEAPON = "%s (%d%% --> %d%%) - %s",
}

for key, value in pairs(PACOGenericStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end
