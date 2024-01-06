-- Local instances of Global tables --

 local LCK = LibCharacterKnowledge
 local PA = PersonalAssistant


-- ---------------------------------------------------------------------------------------------------------------------

local function _GetCharacter(name)
    if LCK == nil then LCK = LibCharacterKnowledge end -- workaround 27/11/2022
    for _,v in ipairs(LCK.GetCharacterList()) do
        if v.name == name then
            return v
        end
    end
end


-- ---------------------------------------------------------------------------------------------------------------------

local function GetCharacterNames()
    if LCK == nil then LCK = LibCharacterKnowledge end -- workaround 27/11/2022
    local characterNames = {}
    for _,v in ipairs(LCK.GetCharacterList()) do
        table.insert(characterNames, v.name)
    end
    return characterNames
end

local function IsInstalled()
    return LibCharacterKnowledge
end

local function IsEnabled()
    if PA == nil then PA = PersonalAssistant end -- workaround 08/06/2023 
	if PA and PA.Integration and PA.Integration.SavedVars and PA.Integration.SavedVars.CharacterKnowledge then
        return PA.Integration.SavedVars.CharacterKnowledge.enabled
	else
        return false	
	end   
end

local function IsKnown(itemLink)
    if LCK == nil then LCK = LibCharacterKnowledge end -- workaround 27/11/2022
    local character = _GetCharacter(PA.Integration.SavedVars.CharacterKnowledge.characterName)
    local knowledge = LCK.GetItemKnowledgeForCharacter(itemLink, nil, character.id)
    if knowledge == LCK.KNOWLEDGE_KNOWN then
        return true
    elseif knowledge == LCK.KNOWLEDGE_UNKNOWN then
        return false
    else
        PA.debugln("knowledge of " .. itemLink .. " to " .. character.name .. " is " .. knowledge)
    end
    return nil
end

local function RegisterForInitializationCallback(executableFunction)
    if LCK == nil then LCK = LibCharacterKnowledge end -- workaround 27/11/2022
    LCK.RegisterForCallback(PA.Integration.AddonName, LCK.EVENT_INITIALIZED, executableFunction)
end


-- ---------------------------------------------------------------------------------------------------------------------
-- Export

PA.Libs = PA.Libs or {}
PA.Libs.CharacterKnowledge = {
    GetCharacterNames = GetCharacterNames,
    IsInstalled = IsInstalled,
    IsEnabled = IsEnabled,
    IsKnown = IsKnown,
    RegisterForInitializationCallback = RegisterForInitializationCallback
}