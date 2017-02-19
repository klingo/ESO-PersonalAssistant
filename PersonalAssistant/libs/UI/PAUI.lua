PAUI = {}

local wm = WINDOW_MANAGER

function PAUI.initUI()
    PAUI.UI = {}

    PAUI.cursor = false
    PAUI.menu = false

    PAFW:AddCloseButton("PersonalAssistant_ButtonCloseAddon", PAUI.toggleWindow)
    -- Set the title and "subtitle" of the main window
    PAFW:AddTitle("PersonalAssistant_WindowTitle", PALocale.getResourceMessage("MMenu_Title"))
    PAFW:AddTitleInfo("PersonalAssistant_WindowSubTitle", PA.AddonVersion)

    -- add a divider below the title
    PAFW:AddCategoryHeader("PersonalAssistant_TopDivider", PALocale.getResourceMessage("PARMenu_Header"))

--    lam:AddCheckbox(PersonalAssistantUI, "test", "test 3", "guug", nil, nil)

--    ZO_PreHookHandler(ZO_MainMenuCategoryBar, "OnShow", function()
--        CHAT_SYSTEM:AddMessage("onshow ZO_MainMenuCategoryBar")
--    end)

--    ZO_PreHookHandler(ZO_MainMenu, "OnShow2", function()
--        CHAT_SYSTEM:AddMessage("onshow ZO_MainMenu")
--    end)
end

function PAUI.toggleWindow()
--    EVENT_MANAGER:RegisterForEvent("EVENT_ACTION_LAYER_POPPED", EVENT_ACTION_LAYER_POPPED, PA.popped)
--    EVENT_MANAGER:RegisterForEvent("EVENT_ACTION_LAYER_PUSHED", EVENT_ACTION_LAYER_PUSHED, PA.pushed)

--        http://www.esoui.com/forums/showthread.php?t=1453
--    local fragment = ZO_FadeSceneFragment:New( yourControl )     
--    SCENE_MANAGER:GetScene('hud'):AddFragment( fragment )
--    SCENE_MANAGER:GetScene('hudui'):AddFragment( fragment )

--     How to show/hide window using the SCENE_MANAGER
--    http://www.esoui.com/portal.php?&id=27&pageid=12


    if (PersonalAssistantUI:IsHidden()) then
    SetGameCameraUIMode(true)
    -- CHECK THIS!!!
    -- http://wiki.esoui.com/AddOn_Quick_Questions#Are_there_Keypress_events_that_we_can_tie_into.3F

        --  IsActionLayerActiveByName(string layerName)
--        local layerCount = GetNumActionLayers()

--        for i = 1, layerCount do
--            local layerName, _ = GetActionLayerInfo(i)
--            CHAT_SYSTEM:AddMessage("Layer ("..tostring(i)..") : "..layerName)
--        end

--        CHAT_SYSTEM:AddMessage(tostring(IsActionLayerActiveByName("GameMenu")))
        -- PopActionLayer(12)
--        CHAT_SYSTEM:AddMessage(tostring(IsActionLayerActiveByName("GameMenu")))
        --PopActionLayer()

        ZO_SceneManager_ToggleGameMenuBinding()

--        if not ZO_MainMenuCategoryBar:IsHidden() then
--            ZO_SceneManager_ToggleUIModeBinding()
--        end

--        if not CHAT_SYSTEM:IsMinimized() then
--            CHAT_SYSTEM:Minimize()
--        end

        PersonalAssistantUI:SetHidden(false)     -- Display the addon

--        EVENT_MANAGER:RegisterForEvent("PersonalAssistant_CameraChanged", EVENT_GAME_CAMERA_UI_MODE_CHANGED, PA.fixWindowDisplay)

        --CHAT_SYSTEM:AddMessage("enabled")
    else
        SetGameCameraUIMode(false)

        ZO_SceneManager_ToggleGameMenuBinding()
--        if(CHAT_SYSTEM:IsMinimized()) then
--            CHAT_SYSTEM:Maximize()
--        end
        PersonalAssistantUI:SetHidden(true)      -- Hide the addon
--        EVENT_MANAGER:UnregisterForEvent("PersonalAssistant_CameraChanged", EVENT_GAME_CAMERA_UI_MODE_CHANGED)
--        EVENT_MANAGER:UnregisterForEvent("EVENT_ACTION_LAYER_POPPED", EVENT_ACTION_LAYER_POPPED)
--        EVENT_MANAGER:UnregisterForEvent("EVENT_ACTION_LAYER_PUSHED", EVENT_ACTION_LAYER_PUSHED)
        --CHAT_SYSTEM:AddMessage("disabled222")
    end
end

-- ["EVENT_ACTION_LAYER_POPPED"] = 65549
-- ["EVENT_ACTION_LAYER_PUSHED"] = 65548 

-- ["MOUSE_CURSOR_UI_HAND"] = 6
-- ["SI_VIDEO_OPTIONS_INTERFACE"] = 12 


--function PA.fixWindowDisplay()
--    if not PersonalAssistantUI:IsHidden() then
--        if ZO_MainMenuCategoryBar:IsHidden() then
--            PersonalAssistantUI:SetHidden(true)
--            CHAT_SYSTEM:AddMessage("hidden")
--                EVENT_MANAGER:UnregisterForEvent("PersonalAssistant_CameraChanged", EVENT_GAME_CAMERA_UI_MODE_CHANGED)
--                CHAT_SYSTEM:AddMessage("disabled")
--        end
--    end
--end

--function PA.popped(layerIndex, activeLayerIndex)
--    CHAT_SYSTEM:AddMessage("popped: "..tostring(layerIndex).."  "..tostring(activeLayerIndex))
--    if (activeLayerIndex == 6) then PA.cursor = false end
--    if (activeLayerIndex == 12) then PA.menu = false end
--end

--function PA.pushed(layerIndex, activeLayerIndex)
--    CHAT_SYSTEM:AddMessage("pushed: "..tostring(layerIndex).."  "..tostring(activeLayerIndex))
--    if (activeLayerIndex == 6) then PA.cursor = true end
--    if (activeLayerIndex == 12) then PA.menu = true end
--end