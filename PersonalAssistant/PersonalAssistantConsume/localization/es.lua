local PAC = PersonalAssistant.Constants
local PACOStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAConsume Menu --
    SI_PA_MENU_CONSUME_DESCRIPTION = "PAConsume puede aplicar veneno, o consumir comida/bebida & pergamino de EXP",

    -- auto poison --
    SI_PA_MENU_CONSUME_POISON_HEADER = "Auto Aplicar Veneno",
    SI_PA_MENU_CONSUME_POISON_ENABLE = "Activar Auto Aplicar Veneno",
	SI_PA_MENU_CONSUME_POISON_ENABLE_T = "Auto aplicar tu mayor apilado de veneno después del combate si ya no hay mas en el arma",
	
	-- auto consume food & exp --
	SI_PA_MENU_CONSUME_FOOD_HEADER = "Auto Consume Comida/Bebida",
	SI_PA_MENU_CONSUME_EXP_HEADER = "Auto Consume Pergamino de EXP",
	SI_PA_MENU_CONSUME_CURRENT_FOOD_BUFF = "La reciente aura de comida para este personaje es: ",
	SI_PA_MENU_CONSUME_CURRENT_EXP_BUFF = "La reciente aura de EXP para este personaje es: ",
    SI_PA_MENU_CONSUME_LABEL_ON = "Consume Automáticamente",
    SI_PA_MENU_CONSUME_LABEL_OFF = "Para de Consumir Automáticamente",
	SI_PA_MENU_CONSUME_USE_NUMBER_FOOD = "Consumir (segundos antes)",
	SI_PA_MENU_CONSUME_USE_NUMBER_FOOD_T =  "Segundos para usar el aura de comida antes de que la reciente aura expire. Usa un numero entre 0 a 600 segundos para cambiar el tiempo de consumo de la comida.",
	SI_PA_MENU_CONSUME_USE_NUMBER_EXP = "Consumir (segundos después)",
    SI_PA_MENU_CONSUME_USE_NUMBER_EXP_T =  "Segundos para usar el aura de EXP después de que el aura expire. Usa un número entre 0 a 600 segundos para cambiar el tiempo de consumo del pergamino de EXP.",
    SI_PA_MENU_CONSUME_TURN_OFF_FOOD = "Suspender",
    SI_PA_MENU_CONSUME_TURN_OFF_FOOD_T = "Parar de consumir la comida/bebida por ahora",
    SI_PA_MENU_CONSUME_TURN_OFF_EXP = "Suspender",
    SI_PA_MENU_CONSUME_TURN_OFF_EXP_T = "Para de consumir el pergamino de EXP por ahora",



    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAConsume poison--
    SI_PA_CHAT_CONSUME_POISON_MAIN = "El arma principal ha sido imbuida con ",
    SI_PA_CHAT_CONSUME_POISON_BACKUP = "El arma secundaria ha sido imbuida con ",
	
	-- PAConsume food & exp--
	SI_PA_CHAT_CONSUME_NO_FOOD = "Ninguna comida ha sido seleccionada todavía. Abre el inventario, haz click derecho en la pila de comida o bebida que tu quieras, y elige la opción Consumir Automáticamente.",
	SI_PA_CHAT_CONSUME_AUTO_EATING_OFF_BUT = "El consumo de comida automático esta desactivado. Pero tienes seleccionado <<1>> como tu comida preferida.",
	SI_PA_CHAT_CONSUME_TO_ENABLE_EATING = "Para activar el consumo de comida automática para este personaje, abre el inventario, haz click derecho en el comida o bebida que tu quieras, y elige la opción Consumir Automáticamente.",
	SI_PA_CHAT_CONSUME_LOOKS_LIKE = "Parece que <<1>> esta en el menú.",
	SI_PA_CHAT_CONSUME_THIS_FOOD_WILL_BE_MINUTES = "Esto sera consumido <<1[cuando/$d minuto antes/$d minutos antes]>> tu comida reciente expire.",
	SI_PA_CHAT_CONSUME_THIS_FOOD_WILL_BE_SECONDS = "Esto sera consumido <<1[cuando/$d segundo antes/$d segundos antes]>> tu comida reciente expire.",
	SI_PA_CHAT_CONSUME_YOU_HAVE_ONLY = "Tienes solamente <<1>> en tu mochila.", -- "You have <<1[$d/only $d/only $d]>> left in your bag."
	SI_PA_CHAT_CONSUME_YOU_HAVE = "Te quedan <<1>> en tu mochila.",
	SI_PA_CHAT_CONSUME_WISH_STOP_EATING = "Si deseas detener el comer automático para este personaje, usa el menu PAconsume.",
	
	SI_PA_CHAT_CONSUME_NO_EXP = "Ningún pergamino de EXP ha sido seleccionada todavía. Open inventory, Abre el inventario, haz click derecho en la pila de pergaminos de EXP que tu quieras, y elige la opción Consumir Automáticamente.",
	SI_PA_CHAT_CONSUME_AUTO_EXPING_OFF_BUT = "El consumo de pergaminos de EXP esta desactivado. Pero tienes seleccionado <<1>> como tu pergamino de EXP favorito.",
    SI_PA_CHAT_CONSUME_TO_ENABLE_EXPING = "Para activar el consumo de pergaminos de EXP para este personaje abre el inventario, haz click derecho en el pergamino de EXP que tu quieras, y elige la opción Consumir Automáticamente.",
    SI_PA_CHAT_CONSUME_THIS_EXP_WILL_BE_MINUTES = "Esto sera consumido <<1[cuando/$d minuto después/$d minutos después]>> de que tu beneficio de EXP expire.",
    SI_PA_CHAT_CONSUME_THIS_EXP_WILL_BE_SECONDS = "Esto sera consumido <<1[cuando/$d segundo después/$d segundos después]>> de que tu beneficio de EXP expire.",
    SI_PA_CHAT_CONSUME_WISH_STOP_EXPING = "Si tu deseas parar automáticamente el consumo del pergamino de EXP para este personaje, usa el menu PAconsume.",

    SI_PA_CHAT_CONSUME_FOOD_WILL_BE_CONSUMED = "La comida será consumida <<1>> segundos antes de que la reciente comida expire.",
    SI_PA_CHAT_CONSUME_EXP_WILL_BE_CONSUMED = "El beneficio de EXP será consumida <<1>> segundos después de que beneficio de EXP expire.",
    
	SI_PA_CHAT_CONSUME_HAS_BEEN_AUTOMATICALLY_CONSUMED = " ha sido automáticamente consumido.",
	SI_PA_CHAT_CONSUME_BUT_HAVE_ZERO = "Tienes establecido <<1>> para Consumir Automáticamente pero tienes 0 en tu mochila.",

	SI_PA_CHAT_CONSUME_FOOD_EXPIRE_SECONDS = "Tu comida reciente expirará en <<1[$d segundos./$d segundo./$d segundos.]>>",
	SI_PA_CHAT_CONSUME_FOOD_EXPIRE_MINUTES = "Tu comida reciente expirará en <<1[$d minutos./$d minuto./$d minutos.]>>",
	SI_PA_CHAT_CONSUME_EXP_EXPIRE_SECONDS = "Tu beneficio de EXP expirará en <<1[$d segundos./$d segundo./$d segundos.]>>",
	SI_PA_CHAT_CONSUME_EXP_EXPIRE_MINUTES = "Tu beneficio de EXP expirará en <<1[$d minutos./$d minuto./$d minutos.]>>",
}

for key, value in pairs(PACOStrings) do
	SafeAddString(_G[key], value, 1)
end