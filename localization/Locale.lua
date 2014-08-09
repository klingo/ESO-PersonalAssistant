PAL = {}
 
-- returns the localized text for a key
function PAL.getResourceMessage(key)

	if (PA_SavedVars.General.language == "" or PA_SavedVars.General.language == nil) then
		PA_SavedVars.General.language = GetCVar("language.2")
	end

	if PA_SavedVars.General.language == "de" then
		return ResourceBundle.de[key]
	elseif PA_SavedVars.General.language == "fr" then
		return ResourceBundle.fr[key]
	else
		return ResourceBundle.en[key]
	end
end