PALocale = {}
 
-- returns the localized text for a key
function PALocale.getResourceMessage(key)

	if (PA.savedVars.General.language == nil or PA.savedVars.General.language == "") then
		PA.savedVars.General.language = GetCVar("language.2") or "en"
	end

	if PA.savedVars.General.language == "de" then
		return ResourceBundle.de[key]
	elseif PA.savedVars.General.language == "fr" then
		return ResourceBundle.fr[key]
	else
		return ResourceBundle.en[key]
	end
end