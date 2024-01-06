local PAC = PersonalAssistant.Constants
local PAWStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAWorker Menu --
    SI_PA_MENU_WORKER_DESCRIPTION = "PAWorker может разбирать предметы или перерабатывать материалы в автоматическом режиме",

	SI_PA_MENU_WORKER_METICULOUS_ENABLE = "Тщательная проверка разборки",
	SI_PA_MENU_WORKER_METICULOUS_ENABLE_T = "Предотвращает деконструкцию/переработку, если не выбран слот «Тщательная разборка».",
	SI_PA_MENU_WORKER_CHECK_EXTRACTION_ENABLE = "Проверять навык извлечения",
	SI_PA_MENU_WORKER_CHECK_EXTRACTION_ENABLE_T = "Предотвращает деконструкцию/переработку, если навык извлечения, соответствующий производственному навыку, не максимизирован.",

    -- auto refine --
    SI_PA_MENU_WORKER_AUTOREFINE_HEADER = "Автоматическая переработка материалов",
    SI_PA_MENU_WORKER_AUTOREFINE_ENABLE = "Включить автоматическую переработку материалов",
	SI_PA_MENU_WORKER_AUTOREFINE_ENABLE_T = "Автоматическая переработка материалов",

	-- auto Deconstruct --
    SI_PA_MENU_WORKER_AUTODECONSTRUCT_HEADER = "Автоматический разбор предметов",
    SI_PA_MENU_WORKER_AUTODECONSTRUCT_ENABLE = "Включить автоматический разбор предметов",
	SI_PA_MENU_WORKER_AUTODECONSTRUCT_ENABLE_T = "Автоматический разбор предметов",

	SI_PA_MENU_WORKER_PROTECT_BANK_ENABLE = "Защищать предметы в банке",
	SI_PA_MENU_WORKER_PROTECT_BANK_ENABLE_T = "Дополнительная защита предметов в банке",

	SI_PA_MENU_WORKER_PROTECT_UNCOLLECTED_SET_ITEMS_ENABLE = "Защищать предметы не в коллекции",
	SI_PA_MENU_WORKER_PROTECT_UNCOLLECTED_SET_ITEMS_ENABLE_T = "Защищать части наборов отсутствующие в коллекции от автоматического разбора",

	-- auto research trait --
	SI_PA_MENU_WORKER_AUTORESEARCHTRAITS_HEADER = "Автоматическое изучение особенностей",
    SI_PA_MENU_WORKER_AUTORESEARCHTRAITS_ENABLE = "Включить автоматическое изучение особенностей",
	SI_PA_MENU_WORKER_AUTORESEARCHTRAITS_ENABLE_T = "Автоматическое изучение особенностей",


	-- General texts used across: Weapons, Armor, Jewelry
    SI_PA_MENU_WORKER_AUTOMARK_QUALITY_THRESHOLD = "Разбирать %s качества",
    SI_PA_MENU_WORKER_AUTOMARK_QUALITY_THRESHOLD_T = "Разбирать %s если их качество равно или ниже чем выбрано",
    SI_PA_MENU_WORKER_AUTOMARK_INTRICATE = table.concat({"Разбирать %s с особенностью [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE),"]"}),
    SI_PA_MENU_WORKER_AUTOMARK_INTRICATE_T = table.concat({"Автоматически разбирать %s с особенностью [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE), "] (повышенное вдохновение)?"}),
    SI_PA_MENU_WORKER_AUTOMARK_ORNATE = table.concat({"Разбирать %s с особенностью [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "]"}),
    SI_PA_MENU_WORKER_AUTOMARK_ORNATE_T = table.concat({"Автоматически разбирать %s с особенностью [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "] trait (увеличенная цена продажи)?"}),
    SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_SETS = "Также разбирать часть набора %s",
    SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_SETS_T = "Если отключено, будут деконструированы только %s, которые НЕ принадлежат набору.",
    SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_KNOWN_TRAITS = "Также разобрать %s с известными особенностями.",
    SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_KNOWN_TRAITS_T = "Если отключено, только %s без особенностей или с неизвестными особенностями будут деконструированы.",
    SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_UNKNOWN_TRAITS = "Также разобрать %s с неизвестными особенностями.",
    SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T = "Если отключено, только %s без особенностей или с известными особенностями будут деконструированы.",



    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAWorker deconstruct--
    SI_PA_CHAT_ITEM_DECONSTRUCTED = "Предмет %s был разобран",
	SI_PA_CHAT_ITEM_REFINED = "Предмет %s был переработан",
	SI_PA_CHAT_ITEM_RESEARCHED = "Предмет %s has been used to research the %s (%s) trait for %s",
	SI_PA_CHAT_RESEARCH_FULL = "Невозможно изучить особенность %s для %s поскольку %s/%s слотов исследованя занято",
	SI_PA_CHAT_NO_METICULOUS = "Автоматическая деконструкция/переработка заблокирована, поскольку «Тщательная разборка» не установлена.",
	SI_PA_CHAT_NO_EXTRACTION = "Автоматическая деконструкция/переработка заблокирована поскольку %s не максимального уровня",
	SI_PA_CHAT_NO_EXTRACTION_FOR_ITEM = "%s не максимизирован, поэтому %s не был автоматически разобран",
	SI_PA_CHAT_CRAFTING_QUEST = "Автоматическая деконструкция/переработка/исследование было заблокировано, поскольку у вас есть текущий производственный квест.",


}

for key, value in pairs(PAWStrings) do
    SafeAddString(_G[key], value, 1)
end

