PAUI = {}

function PAUI.initUI()
	PAUI.UI = {}
	
	PAUI.cursor = false
	PAUI.menu = false
	
	-- Set the title of the main window
	PAUI.UI.WindowTitle = WINDOW_MANAGER:CreateControl("PersonalAssistant_WindowTitle", PersonalAssistantUI, CT_LABEL)
    PAUI.UI.WindowTitle:SetAnchor(TOPLEFT, PersonalAssistantUI, TOPLEFT, 0, 0)
    PAUI.UI.WindowTitle:SetFont("ZoFontAnnounceMedium")
    PAUI.UI.WindowTitle:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
    PAUI.UI.WindowTitle:SetText("|cFFD700P|rERSONAL|cFFD700A|rSSISTANT")
	
	-- Set the "sub title"
    PAUI.UI.WindowSubTitle = WINDOW_MANAGER:CreateControl("PersonalAssistant_WindowSubTitle", PersonalAssistantUI, CT_LABEL)
    PAUI.UI.WindowSubTitle:SetAnchor(LEFT, PAUI.UI.WindowTitle, RIGHT, 10, 0)
    PAUI.UI.WindowSubTitle:SetFont("ZoFontAnnounceMedium")
    PAUI.UI.WindowSubTitle:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
    PAUI.UI.WindowSubTitle:SetColor(0, 0.4, 0.6, 1);
    PAUI.UI.WindowSubTitle:SetText("v1.2.0")
	
	-- add a divider below the title
    PAUI.UI.TopDivider = WINDOW_MANAGER:CreateControl("PersonalAssistant_TopDivider", PersonalAssistantUI, CT_TEXTURE)
    PAUI.UI.TopDivider:SetDimensions(760, 5)
    PAUI.UI.TopDivider:SetAnchor(TOPLEFT, PersonalAssistantUI, TOPLEFT, 0, 32)
    PAUI.UI.TopDivider:SetTexture("/esoui/art/quest/questjournal_divider.dds")
	
    -- CREATE BUTTON FOR CLOSE ADDON AT TOP_RIGHT
    PAUI.UI.btnCloseAddonFrame = WINDOW_MANAGER:CreateControl("PersonalAssistant_ButtonCloseAddon", PersonalAssistantUI, CT_BUTTON)
    PAUI.UI.btnCloseAddonFrame:SetDimensions(28, 28)
    PAUI.UI.btnCloseAddonFrame:SetAnchor(TOPRIGHT, PersonalAssistantUI, TOPRIGHT, 0 , 0)
    PAUI.UI.btnCloseAddonFrame:SetState(BSTATE_NORMAL)
    PAUI.UI.btnCloseAddonFrame:SetMouseOverBlendMode(0)
    PAUI.UI.btnCloseAddonFrame:SetEnabled(true)
    PAUI.UI.btnCloseAddonFrame:SetNormalTexture("/esoui/art/buttons/clearslot_down.dds")
    PAUI.UI.btnCloseAddonFrame:SetMouseOverTexture("/esoui/art/buttons/clearslot_up.dds")
    PAUI.UI.btnCloseAddonFrame:SetHandler("OnClicked", function(self) PAUI.toggleWindow() end)
	
--	ZO_PreHookHandler(ZO_MainMenuCategoryBar, "OnShow", function()
--		CHAT_SYSTEM:AddMessage("onshow ZO_MainMenuCategoryBar")
--	end)
	
--	ZO_PreHookHandler(ZO_MainMenu, "OnShow2", function()
--		CHAT_SYSTEM:AddMessage("onshow ZO_MainMenu")
--	end)
end

function PAUI.toggleWindow()
--	EVENT_MANAGER:RegisterForEvent("EVENT_ACTION_LAYER_POPPED", EVENT_ACTION_LAYER_POPPED, PA.popped)
--	EVENT_MANAGER:RegisterForEvent("EVENT_ACTION_LAYER_PUSHED", EVENT_ACTION_LAYER_PUSHED, PA.pushed)
	
		SetGameCameraUIMode(true)
		
    if (PersonalAssistantUI:IsHidden()) then
	
	-- CHECK THIS!!!
	-- http://wiki.esoui.com/AddOn_Quick_Questions#Are_there_Keypress_events_that_we_can_tie_into.3F
	
		--  IsActionLayerActiveByName(string layerName) 
--		local layerCount = GetNumActionLayers()
		
--		for i = 1, layerCount do
--			local layerName, _ = GetActionLayerInfo(i)
--			CHAT_SYSTEM:AddMessage("Layer ("..tostring(i)..") : "..layerName)
--		end
		
--		CHAT_SYSTEM:AddMessage(tostring(IsActionLayerActiveByName("GameMenu")))
		-- PopActionLayer(12) 
--		CHAT_SYSTEM:AddMessage(tostring(IsActionLayerActiveByName("GameMenu")))
		--PopActionLayer()

--		ZO_SceneManager_ToggleGameMenuBinding()
		
--		if not ZO_MainMenuCategoryBar:IsHidden() then
--			ZO_SceneManager_ToggleUIModeBinding()				
--		end
		
--		if not CHAT_SYSTEM:IsMinimized() then
--			CHAT_SYSTEM:Minimize()
--		end
		
        PersonalAssistantUI:SetHidden(false)     -- Display the addon
		
--		EVENT_MANAGER:RegisterForEvent("PersonalAssistant_CameraChanged", EVENT_GAME_CAMERA_UI_MODE_CHANGED, PA.fixWindowDisplay)
		
		--CHAT_SYSTEM:AddMessage("enabled")
    else
--        SetGameCameraUIMode(false)

--		ZO_SceneManager_ToggleGameMenuBinding()
--		if(CHAT_SYSTEM:IsMinimized()) then
--			CHAT_SYSTEM:Maximize()
--		end
        PersonalAssistantUI:SetHidden(true)      -- Hide the addon
--		EVENT_MANAGER:UnregisterForEvent("PersonalAssistant_CameraChanged", EVENT_GAME_CAMERA_UI_MODE_CHANGED)
--		EVENT_MANAGER:UnregisterForEvent("EVENT_ACTION_LAYER_POPPED", EVENT_ACTION_LAYER_POPPED)
--		EVENT_MANAGER:UnregisterForEvent("EVENT_ACTION_LAYER_PUSHED", EVENT_ACTION_LAYER_PUSHED)
		--CHAT_SYSTEM:AddMessage("disabled222")
    end
end

-- ["EVENT_ACTION_LAYER_POPPED"] = 65549
-- ["EVENT_ACTION_LAYER_PUSHED"] = 65548 

-- ["MOUSE_CURSOR_UI_HAND"] = 6
-- ["SI_VIDEO_OPTIONS_INTERFACE"] = 12 


--function PA.fixWindowDisplay()
--	if not PersonalAssistantUI:IsHidden() then
--		if ZO_MainMenuCategoryBar:IsHidden() then
--			PersonalAssistantUI:SetHidden(true)
--			CHAT_SYSTEM:AddMessage("hidden")
--				EVENT_MANAGER:UnregisterForEvent("PersonalAssistant_CameraChanged", EVENT_GAME_CAMERA_UI_MODE_CHANGED)
--				CHAT_SYSTEM:AddMessage("disabled")
--		end
--	end 
--end

--function PA.popped(layerIndex, activeLayerIndex)
--	CHAT_SYSTEM:AddMessage("popped: "..tostring(layerIndex).."  "..tostring(activeLayerIndex))
--	if (activeLayerIndex == 6) then PA.cursor = false end
--	if (activeLayerIndex == 12) then PA.menu = false end
--end

--function PA.pushed(layerIndex, activeLayerIndex)
--	CHAT_SYSTEM:AddMessage("pushed: "..tostring(layerIndex).."  "..tostring(activeLayerIndex))
--	if (activeLayerIndex == 6) then PA.cursor = true end
--	if (activeLayerIndex == 12) then PA.menu = true end
--end