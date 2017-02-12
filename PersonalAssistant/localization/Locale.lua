PALocale = {}
 
-- returns the localized text for a key
function PALocale.getResourceMessage(key)

	if (PA.savedVars.General.language == nil or PA.savedVars.General.language == "") then
		PA.savedVars.General.language = GetCVar("language.2") or "en"
	end

    -- init variable
    local labelMsg

    if PA.savedVars.General.language == "de" then
        -- check if german and get text
        labelMsg = ResourceBundle.de[key]
    elseif PA.savedVars.General.language == "fr" then
        -- check if French and get text
        labelMsg = ResourceBundle.fr[key]
    end

    -- if German/French text is not existing, or if other language was set, get English text
    if (labelMsg == nil or labelMsg == "") then
        labelMsg = ResourceBundle.en[key]
    end

    return labelMsg
end