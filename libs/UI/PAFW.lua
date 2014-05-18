-- PersonalAssistant Framework

PAFW = {}
PAFW.lastAddedControl = {}

local wm = GetWindowManager()
local tlc = PersonalAssistantUI	-- name of the TopLevelControl (XML)

-- not required because of XML?
function PAFW:AddCloseButton(name, closeFunction)
    local closeButton = wm:CreateControl(name, PersonalAssistantUI, CT_BUTTON)
    closeButton:SetDimensions(28, 28)
    closeButton:SetAnchor(TOPRIGHT, PersonalAssistantUI, TOPRIGHT, 0 , 0)
    closeButton:SetState(BSTATE_NORMAL)
    closeButton:SetMouseOverBlendMode(0)
    closeButton:SetEnabled(true)
    closeButton:SetNormalTexture("/esoui/art/buttons/clearslot_down.dds")
    closeButton:SetMouseOverTexture("/esoui/art/buttons/clearslot_up.dds")
    closeButton:SetHandler("OnClicked", function(self) closeFunction() end)
	
--	PAFW.lastAddedControl = closeButton
end

function PAFW:AddTitle(name, text)
	local title = wm:CreateControl(name, PersonalAssistantUI, CT_LABEL)
    title:SetAnchor(TOPLEFT, PersonalAssistantUI, TOPLEFT, 0, 0)
    title:SetFont("ZoFontAnnounceMedium")
    title:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
    title:SetText(text)
	
	PAFW.lastAddedControl = title
end

function PAFW:AddTitleInfo(name, text)
    local titleInfo = wm:CreateControl(name, PersonalAssistantUI, CT_LABEL)
    titleInfo:SetAnchor(LEFT, PAFW.lastAddedControl, RIGHT, 10, 0)
    titleInfo:SetFont("ZoFontAnnounceMedium")
    titleInfo:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
    titleInfo:SetColor(0, 0.4, 0.6, 1);
    titleInfo:SetText(text)
	
--	PAFW.lastAddedControl = titleInfo
end

function PAFW:AddCategoryHeader(name, text)
    local divider = wm:CreateControl(name.."_Divider", PersonalAssistantUI, CT_TEXTURE)
	local width, _ = PersonalAssistantUI:GetDimensions()
    divider:SetDimensions(width, 5)
    divider:SetAnchor(TOPLEFT, PAFW.lastAddedControl, TOPLEFT, 0, 32)
    divider:SetTexture("/esoui/art/quest/questjournal_divider.dds")
	
	PAFW.lastAddedControl = titleInfo
	
    local header = wm:CreateControl(name, PersonalAssistantUI, CT_LABEL)
    header:SetAnchor(TOPLEFT, PAFW.lastAddedControl, TOPLEFT, 10, 40)
    header:SetFont("ZoFontAnnounceMedium")
    header:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
    header:SetColor(0, 0.4, 0.6, 1);
    header:SetText(text)
	
	PAFW.lastAddedControl = header
end