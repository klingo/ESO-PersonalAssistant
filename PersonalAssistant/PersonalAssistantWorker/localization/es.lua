local PAC = PersonalAssistant.Constants
local PAWStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAWorker Menu --
    SI_PA_MENU_WORKER_DESCRIPTION = "PAWorker puede deconstruir objetos o refinar materiales automáticamente",
	
	SI_PA_MENU_WORKER_METICULOUS_ENABLE = "Checar 'Deconstrucción Meticulosa'",
	SI_PA_MENU_WORKER_METICULOUS_ENABLE_T = "Previene Deconstruir/Refinar si 'Deconstrucción Meticulosa' no esta equipado",
	SI_PA_MENU_WORKER_CHECK_EXTRACTION_ENABLE = "Checar Pasivas de 'Extracción'",
	SI_PA_MENU_WORKER_CHECK_EXTRACTION_ENABLE_T = "Previene Deconstruir/Refinar si la pasiva de extracción correspondiente a la habilidad de elaboración no esta al máximo",

    -- auto refine --
    SI_PA_MENU_WORKER_AUTOREFINE_HEADER = "Auto Refinar Materiales",
    SI_PA_MENU_WORKER_AUTOREFINE_ENABLE = "Activar Refinar Materiales",
	SI_PA_MENU_WORKER_AUTOREFINE_ENABLE_T = "Auto refina materiales",
	
	-- auto Deconstruct --
    SI_PA_MENU_WORKER_AUTODECONSTRUCT_HEADER = "Auto Deconstruye Objetos",
    SI_PA_MENU_WORKER_AUTODECONSTRUCT_ENABLE = "Activar Auto Deconstruye Objetos",
	SI_PA_MENU_WORKER_AUTODECONSTRUCT_ENABLE_T = "Auto deconstruye objetos",
	
	SI_PA_MENU_WORKER_PROTECT_BANK_ENABLE = "Proteger Objetos del Banco",
	SI_PA_MENU_WORKER_PROTECT_BANK_ENABLE_T = "2da protección para objetos del banco",
	
	SI_PA_MENU_WORKER_PROTECT_UNCOLLECTED_SET_ITEMS_ENABLE = "Proteger Objetos de Atuendos no Coleccionados",
	SI_PA_MENU_WORKER_PROTECT_UNCOLLECTED_SET_ITEMS_ENABLE_T = "Protege objetos de atuendos no coleccionados desde la auto-deconstrucción",
	
	-- auto research trait --
	SI_PA_MENU_WORKER_AUTORESEARCHTRAITS_HEADER = "Auto Investiga Rasgos",
    SI_PA_MENU_WORKER_AUTORESEARCHTRAITS_ENABLE = "Activar Auto Investiga Rasgos",
	SI_PA_MENU_WORKER_AUTORESEARCHTRAITS_ENABLE_T = "Auto Investiga Rasgos",
	
	-- General texts used across: Weapons, Armor, Jewelry
    SI_PA_MENU_WORKER_AUTOMARK_QUALITY_THRESHOLD = "Auto-Deconstruye %s con calidad igual o menor a:",
    SI_PA_MENU_WORKER_AUTOMARK_QUALITY_THRESHOLD_T = "Automáticamente deconstruye %s si son de la calidad seleccionada o menor",
    SI_PA_MENU_WORKER_AUTOMARK_INTRICATE = table.concat({"Auto-Deconstruye %s con el rasgo [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE),"]"}),
    SI_PA_MENU_WORKER_AUTOMARK_INTRICATE_T = table.concat({"Auto-Deconstruye %s con el rasgo [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE), "] (incrementa la Inspiración)?"}),
    SI_PA_MENU_WORKER_AUTOMARK_ORNATE = table.concat({"Auto-Deconstruct %s con el rasgo [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "]"}),
    SI_PA_MENU_WORKER_AUTOMARK_ORNATE_T = table.concat({"Automáticamente deconstruye %s con el rasgo [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "] (incrementa el valor de venta)?"}),
    SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_SETS = "También deconstruye %s que son parte de un Conjunto",
    SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_SETS_T = "Si esta INACTIVO, solamente %s que NO son pertenecen a un conjunto serán deconstruidos",
    SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_KNOWN_TRAITS = "También deconstruirá %s con Rasgo conocido",
    SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_KNOWN_TRAITS_T = "Si esta INACTIVO, solamente %s con sin Rasgo o Rasgo desconocido serán deconstruidos",
    SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_UNKNOWN_TRAITS = "También deconstruirá %s con Rasgo desconocido",
    SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T = "Si esta INACTIVO, solamente %s con sin Rasgo o Rasgo conocido serán deconstruidos",



    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAWorker deconstruct--
    SI_PA_CHAT_ITEM_DECONSTRUCTED = "%s ha sido deconstruido",
	SI_PA_CHAT_ITEM_REFINED = "%s ha sido refinado",
	SI_PA_CHAT_ITEM_RESEARCHED = "%s ha sido usado para investigar el rasgo %s (%s) para %s",
	SI_PA_CHAT_RESEARCH_FULL = "No pudo ser investigado el rasgo %s para %s porque hay %s/%s en investigación en uso",
	SI_PA_CHAT_RESEARCH_BUSY = "No pudo ser investigado el rasgo %s por que estas ya investigando otro rasgo para %s",
	SI_PA_CHAT_NO_METICULOUS = "Auto deconstruir/refinar esta bloqueado por que 'Deconstrucción Meticulosa' no esta equipado",
	SI_PA_CHAT_NO_EXTRACTION = "Auto deconstruir/refinar esta bloqueado por que %s no esta al máximo",
	SI_PA_CHAT_NO_EXTRACTION_FOR_ITEM = "%s no esta al máximo asi que %s no fue auto deconstruido",
    SI_PA_CHAT_CRAFTING_QUEST = "Auto deconstruir/refinar/investigar fue bloqueado por que tienes una misión de crafting en curso",

}

for key, value in pairs(PAWStrings) do
    SafeAddString(_G[key], value, 1)
end
