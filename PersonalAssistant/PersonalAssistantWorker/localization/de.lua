local PAC = PersonalAssistant.Constants
local PAWStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAWorker Menu --
    SI_PA_MENU_WORKER_DESCRIPTION = "PAWorker can deconstruct items or refine materials automatically",
	
	SI_PA_MENU_WORKER_METICULOUS_ENABLE = "Meticulous Disassembly Check",
	SI_PA_MENU_WORKER_METICULOUS_ENABLE_T = "Prevents Deconstructing/Refining if Meticulous Disassembly isn't slotted",
	SI_PA_MENU_WORKER_CHECK_EXTRACTION_ENABLE = "Extraction Passive Check",
	SI_PA_MENU_WORKER_CHECK_EXTRACTION_ENABLE_T = "Prevents Deconstructing/Refining if the extraction passive corresponding to the crafting skill isn't maxed",

    -- auto refine --
    SI_PA_MENU_WORKER_AUTOREFINE_HEADER = "Auto Refine Materials",
    SI_PA_MENU_WORKER_AUTOREFINE_ENABLE = "Enable Auto Refine Materials",
	SI_PA_MENU_WORKER_AUTOREFINE_ENABLE_T = "Auto refine materials",
	
	-- auto Deconstruct --
    SI_PA_MENU_WORKER_AUTODECONSTRUCT_HEADER = "Auto Deconstruct Items",
    SI_PA_MENU_WORKER_AUTODECONSTRUCT_ENABLE = "Enable Auto Deconstruct Items",
	SI_PA_MENU_WORKER_AUTODECONSTRUCT_ENABLE_T = "Auto Deconstruct Items",
	
	SI_PA_MENU_WORKER_PROTECT_BANK_ENABLE = "Protect Banked Items",
	SI_PA_MENU_WORKER_PROTECT_BANK_ENABLE_T = "2nd protection for banked items",
	
	-- auto research trait --
	SI_PA_MENU_WORKER_AUTORESEARCHTRAITS_HEADER = "Auto Research Traits",
    SI_PA_MENU_WORKER_AUTORESEARCHTRAITS_ENABLE = "Enable Auto Research Traits",
	SI_PA_MENU_WORKER_AUTORESEARCHTRAITS_ENABLE_T = "Auto Research Traits",
	
	
	-- General texts used across: Weapons, Armor, Jewelry
    SI_PA_MENU_WORKER_AUTOMARK_QUALITY_THRESHOLD = "Auto-Deconstruct %s with quality at or below",
    SI_PA_MENU_WORKER_AUTOMARK_QUALITY_THRESHOLD_T = "Automatically deconstruct %s if they are of the selected quality or lower",
    SI_PA_MENU_WORKER_AUTOMARK_INTRICATE = table.concat({"Auto-Deconstruct %s with [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE),"] trait"}),
    SI_PA_MENU_WORKER_AUTOMARK_INTRICATE_T = table.concat({"Automatically deconstruct %s with [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_INTRICATE), "] trait (increased Inspiration)?"}),
    SI_PA_MENU_WORKER_AUTOMARK_ORNATE = table.concat({"Auto-Deconstruct %s with [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "] trait"}),
    SI_PA_MENU_WORKER_AUTOMARK_ORNATE_T = table.concat({"Automatically deconstruct %s with [", GetString("SI_ITEMTRAITTYPE", ITEM_TRAIT_TYPE_ARMOR_ORNATE), "] trait (increased sell price)?"}),
    SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_SETS = "Also deconstruct %s that are part of a Set",
    SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_SETS_T = "If turned OFF, only %s that are NOT belonging to a set will be deconstructed",
    SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_KNOWN_TRAITS = "Also deconstruct %s with known Traits",
    SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_KNOWN_TRAITS_T = "If turned OFF, only %s with no Traits or unknown Traits will be deconstructed",
    SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_UNKNOWN_TRAITS = "Also deconstruct %s with unknown Traits",
    SI_PA_MENU_WORKER_AUTOMARK_INCLUDE_UNKNOWN_TRAITS_T = "If turned OFF, only %s with no Traits or known Traits will be deconstructed",



    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAWorker deconstruct--
    SI_PA_CHAT_ITEM_DECONSTRUCTED = "%s has been deconstructed",
	SI_PA_CHAT_ITEM_REFINED = "%s has been refined",
	SI_PA_CHAT_ITEM_RESEARCHED = "%s has been used to research the %s (%s) trait for %s",
	SI_PA_CHAT_ITEM_RESEARCHED = "%s has been used to research the %s (%s) trait for %s",
	SI_PA_CHAT_RESEARCH_FULL = "Could not research %s trait for %s because %s/%s research slots are in use",
	SI_PA_CHAT_NO_METICULOUS = "Auto deconstruct/refine is blocked because Meticulous Disassembly is not sloted",
	SI_PA_CHAT_NO_EXTRACTION = "Auto deconstruct/refine is blocked because %s is not maxed",
	SI_PA_CHAT_NO_EXTRACTION_FOR_ITEM = "%s is not maxed so %s wasn't auto deconstructed",
	SI_PA_CHAT_CRAFTING_QUEST = "Auto deconstruct/refine/research was blocked because you have an ongoing crafting quest",

}

for key, value in pairs(PAWStrings) do
    SafeAddString(_G[key], value, 1)
end

