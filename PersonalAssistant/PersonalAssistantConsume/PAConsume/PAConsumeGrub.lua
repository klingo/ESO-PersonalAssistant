-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACO = PA.Consume
local PAHF = PA.HelperFunctions
local PASavedVars = PA.SavedVars

-- ---------------------------------------------------------------------------------------------------------------------

-- LibFoodDrinkBuff library
local LFDB = LIB_FOOD_DRINK_BUFF

-- local constants
local update_timer_period = 10000 -- milliseconds
local low_inventory_warning_threshold = 5 -- items
local player_unit_tag = "player"
local context_menu_delay = 50 -- milliseconds
local consumed_message_delay = 2000 -- milliseconds
local food_buffer_seconds_min = 0 -- seconds
local food_buffer_seconds_max = 600 -- seconds
local EXP_buffer_seconds_min = -600 -- seconds
local EXP_buffer_seconds_max = 0 -- seconds
local out_of_inventory_warning_frequency = 60 -- seconds
local update_sound = SOUNDS.DIALOG_ACCEPT

-- flags
local isEatOnNextUpdate = false
local isConsumeEXPOnNextUpdate = false
local lastOutOfInventoryWarningTime = GetFrameTimeSeconds()
local outOfFoodWarningCounter = 0
local outOfEXPWarningCounter = 0

-- --------------------------------------------------------------------------------------------------------------------

local function GetBackpackInventory(itemLink) -- Returns: number inventoryCount
	local inventoryCount = 0
	
	if itemLink == "" then return inventoryCount end

	-- get the character bag size
	local numSlots = GetBagSize(BAG_BACKPACK)
	
	-- iterate through backpack bag to find all matching items, and add their counts to the total
	for slotIndex = 0, numSlots do
		local slotItemLink = GetItemLink(BAG_BACKPACK, slotIndex, LINK_STYLE_BRACKETS)
		if slotItemLink == itemLink then
			local itemCount = GetItemTotalCount(BAG_BACKPACK, slotIndex)
			inventoryCount = inventoryCount + itemCount
		end
	end
	
	return inventoryCount
end

-- --------------------------------------------------------------------------------------------------------------------

local function ShowFoodSettingsInChat()
    local foodBufferMinutes = math.floor(PASavedVars.ConsumeCharacter.foodBufferSeconds / 60)
	
	if PASavedVars.ConsumeCharacter.foodLink == "" then
		PACO.println(GetString(SI_PA_CHAT_CONSUME_NO_FOOD))
		return
	end

	if not PASavedVars.ConsumeCharacter.isAutoEatFood then
		PACO.println(zo_strformat(GetString(SI_PA_CHAT_CONSUME_AUTO_EATING_OFF_BUT),PASavedVars.ConsumeCharacter.foodLink))
		PACO.println(GetString(SI_PA_CHAT_CONSUME_TO_ENABLE_EATING))
	else
		PACO.println(zo_strformat(GetString(SI_PA_CHAT_CONSUME_LOOKS_LIKE),PASavedVars.ConsumeCharacter.foodLink))

		if PASavedVars.ConsumeCharacter.foodBufferSeconds > 60 then
			PACO.println(zo_strformat(GetString(SI_PA_CHAT_CONSUME_THIS_FOOD_WILL_BE_MINUTES), foodBufferMinutes))
		else
			PACO.println(zo_strformat(GetString(SI_PA_CHAT_CONSUME_THIS_FOOD_WILL_BE_SECONDS), PASavedVars.ConsumeCharacter.foodBufferSeconds))
		end

		local remainingInventory = GetBackpackInventory(PASavedVars.ConsumeCharacter.foodLink)
		if remainingInventory <= low_inventory_warning_threshold and remainingInventory ~= 0 then
			PACO.println(zo_strformat(GetString(SI_PA_CHAT_CONSUME_YOU_HAVE_ONLY),remainingInventory))
		else
			PACO.println(zo_strformat(GetString(SI_PA_CHAT_CONSUME_YOU_HAVE),remainingInventory))
		end
		
		PACO.println(GetString(SI_PA_CHAT_CONSUME_WISH_STOP_EATING))
	end
end	

-- --------------------------------------------------------------------------------------------------------------------

local function ShowEXPSettingsInChat()
	local EXPBufferMinutes = math.floor(PASavedVars.ConsumeCharacter.EXPBufferSeconds / 60)
	
	if PASavedVars.ConsumeCharacter.EXPLink == "" then
		PACO.println(GetString(SI_PA_CHAT_CONSUME_NO_EXP))
		return
	end
	
	if not PASavedVars.ConsumeCharacter.isAutoConsumeEXP then
		PACO.println(zo_strformat(GetString(SI_PA_CHAT_CONSUME_AUTO_EXPING_OFF_BUT),PASavedVars.ConsumeCharacter.EXPLink))
		PACO.println(GetString(SI_PA_CHAT_CONSUME_TO_ENABLE_EXPING))
	else
		PACO.println(zo_strformat(GetString(SI_PA_CHAT_CONSUME_LOOKS_LIKE),PASavedVars.ConsumeCharacter.EXPLink)) 

		if PASavedVars.ConsumeCharacter.EXPBufferSeconds > 60 then
			PACO.println(zo_strformat(GetString(SI_PA_CHAT_CONSUME_THIS_EXP_WILL_BE_MINUTES), math.abs(EXPBufferMinutes)))
		else
			PACO.println(zo_strformat(GetString(SI_PA_CHAT_CONSUME_THIS_EXP_WILL_BE_SECONDS), math.abs(PASavedVars.ConsumeCharacter.EXPBufferSeconds)))
		end

		local remainingInventory = GetBackpackInventory(PASavedVars.ConsumeCharacter.EXPLink)
		if remainingInventory <= low_inventory_warning_threshold and remainingInventory ~= 0 then
			PACO.println(zo_strformat(GetString(SI_PA_CHAT_CONSUME_YOU_HAVE_ONLY),remainingInventory))
		else
			PACO.println(zo_strformat(GetString(SI_PA_CHAT_CONSUME_YOU_HAVE),remainingInventory))
		end
		
		PACO.println(GetString(SI_PA_CHAT_CONSUME_WISH_STOP_EXPING))
	end
	
end	

-- --------------------------------------------------------------------------------------------------------------------
	
local function SetFoodBufferSeconds(foodBufferSeconds)
	local oldBuffer = PASavedVars.ConsumeCharacter.foodBufferSeconds
	local newBuffer = tonumber(foodBufferSeconds)
	
	if type(newBuffer) == "number" then
		newBuffer = math.floor(newBuffer)
		if newBuffer >= food_buffer_seconds_min and newBuffer <= food_buffer_seconds_max then
			if newBuffer ~= oldBuffer then
				PASavedVars.ConsumeCharacter.foodBufferSeconds = newBuffer
				PlaySound(update_sound)				
			end
		end
	end
	
	PACO.println(zo_strformat(GetString(SI_PA_CHAT_CONSUME_FOOD_WILL_BE_CONSUMED),PASavedVars.ConsumeCharacter.foodBufferSeconds))
	
	-- if oldBuffer == PASavedVars.ConsumeCharacter.foodBufferSeconds then
		-- PACO.println("Use a number between " .. food_buffer_seconds_min .. " and " .. food_buffer_seconds_max .. " with " .. slash_command_change_food_buffer .. " to change food buffer time.")
	-- end
end

-- --------------------------------------------------------------------------------------------------------------------

local function SetEXPBufferSeconds(EXPBufferSeconds)
	local oldBuffer = PASavedVars.ConsumeCharacter.EXPBufferSeconds
	local newBuffer = tonumber(EXPBufferSeconds)
	
	if type(newBuffer) == "number" then
		newBuffer = math.floor(newBuffer)
		if newBuffer >= EXP_buffer_seconds_min and newBuffer <= EXP_buffer_seconds_max then
			if newBuffer ~= oldBuffer then
				PASavedVars.ConsumeCharacter.EXPBufferSeconds = newBuffer
				PlaySound(update_sound)				
			end
		end
	end
	
	PACO.println(zo_strformat(GetString(SI_PA_CHAT_CONSUME_EXP_WILL_BE_CONSUMED),math.abs(PASavedVars.ConsumeCharacter.EXPBufferSeconds)))
	
	-- if oldBuffer == PASavedVars.ConsumeCharacter.EXPBufferSeconds then
		-- PACO.println("Use a number between " .. EXP_buffer_seconds_min .. " and " .. EXP_buffer_seconds_max .. " with " .. slash_command_change_EXP_buffer .. " to change EXP buffer time.")
	-- end
end

-- --------------------------------------------------------------------------------------------------------------------

local function SetIsAutoEating(isAutoEating)

	-- only have to change anything if auto eating is already in the requested status
	if PASavedVars.ConsumeCharacter.isAutoEatFood ~= isAutoEating then

		-- if turning on, check to make sure foodLink has been set already
		if isAutoEating then
			if PASavedVars.ConsumeCharacter.foodLink == "" then
				PASavedVars.ConsumeCharacter.isAutoEatFood = false			
			else
				PASavedVars.ConsumeCharacter.isAutoEatFood = true
			end
		else
			PASavedVars.ConsumeCharacter.isAutoEatFood = false
		end

	end
	
	-- show the settings
	PlaySound(update_sound)
	ShowFoodSettingsInChat()
end

-- --------------------------------------------------------------------------------------------------------------------

local function SetIsAutoConsumingEXP(isAutoConsumingEXP)

	-- only have to change anything if auto eating is already in the requested status
	if PASavedVars.ConsumeCharacter.isAutoConsumeEXP ~= isAutoConsumingEXP then

		-- if turning on, check to make sure foodLink has been set already
		if isAutoConsumingEXP then
			if PASavedVars.ConsumeCharacter.EXPLink == "" then
				PASavedVars.ConsumeCharacter.isAutoConsumeEXP = false			
			else
				PASavedVars.ConsumeCharacter.isAutoConsumeEXP = true
			end
		else
			PASavedVars.ConsumeCharacter.isAutoConsumeEXP = false
		end

	end
	
	-- show the settings
	PlaySound(update_sound)
	ShowEXPSettingsInChat()
end

-- --------------------------------------------------------------------------------------------------------------------

local function IsEXPBuffActiveAndGetTimeLeft(unitTag)
  local numBuffs = GetNumBuffs(unitTag)
  local hasActiveEffects = numBuffs > 0
  local indexXPBuff = 0
  if hasActiveEffects then
    
	for i = 1, numBuffs do
	   
      local _,_,_,_,_,checkBuffTextureName,_,_,_,_,abilityID = GetUnitBuffInfo(unitTag, i)
	  -- ESO plus exp boost is 63601 (do not use)
	  
      if abilityID == 63570 or abilityID == 64210 or abilityID == 64630 or abilityID == 66776 or (abilityID >= 85501 and abilityID <= 85503) or abilityID == 88445 -- experience buffs  
	  or abilityID == 89683 or abilityID == 99462 or abilityID == 99463 -- experience buffs
	  or abilityID == 137733 -- Unknown, 'Alliance Skill Gain, Major'
	  or abilityID == 147466 -- Alliance War Skill Line Scroll aka 'Alliance Skill Gain'
	  or abilityID == 147467 -- Unknown, 'Alliance Skill Gain, Grand'
	  or abilityID == 147687 -- Colovian War Torte aka 'Alliance Skill Gain 50% Boost'
	  or abilityID == 147733 -- Molten War Torte? aka 'Alliance Skill Gain 100% Boost'
	  or abilityID == 147734 -- White-Gold War Torte? aka 'Alliance Skill Gain 150% Boost'
	  or abilityID == 147797 -- Unknown, 'Alliance Skill Gain 150% Boost'
	  then  
        -- checkBuffTextureName:find("ability_alchemy_001")
		indexXPBuff = i
	  elseif checkBuffTextureName:find("crownstore_consumable_entremet_cake") then  -- Colovian War Torte
	    indexXPBuff = i
	  elseif checkBuffTextureName:find("ava_skill_boost_food") then  -- Molten War Torte & White-Gold War Torte
	    indexXPBuff = i
      end
    end
	
    if indexXPBuff ~= 0 then
      local buffName, startTime, endTime = GetUnitBuffInfo(unitTag, indexXPBuff)
      local timeLeft = math.floor(((endTime * 1000.0) - GetFrameTimeMilliseconds())/1000)
      local Seconds = timeLeft
	 -- PACO.println("name: "..buffName.." Seconds: "..Seconds)
      return true, Seconds
    end
  end
  return false, 0
end

-- --------------------------------------------------------------------------------------------------------------------

local function IsExperienceDrink(bagId, slotIndex) -- Returns: boolean isExpDrink
	-- get the bag item's itemId
	local itemId = GetItemId(bagId, slotIndex)
	local itemTexture = GetItemInfo(bagId, slotIndex)

	-- check to see if the itemId matches any of the experience drinks, and return true if it does
	if		itemId == 64221		then return	true	-- Psijic Ambrosia
	elseif	itemId == 120076	then return	true	-- Aetherial Ambrosia
	elseif	itemId == 115027	then return	true	-- Mythic Aetherial Ambrosia
	elseif	itemId == 171323	then return	true	-- Colovian War Torte
	elseif	itemId == 171329	then return	true	-- Molten War Torte
	elseif	itemId == 171432	then return	true	-- White-Gold War Torte
	elseif itemTexture:find("experiencescroll") then return true -- Experience Scrolls
	else return false end
end

-- --------------------------------------------------------------------------------------------------------------------

local function IsValidFoodOrDrink(bagId, slotIndex) -- Returns: boolean isValidFood
	-- get the bag item's itemType
	local itemType = GetItemType(bagId, slotIndex)
	
	-- check to see if it's not a food or drink
	if not (itemType == ITEMTYPE_DRINK or itemType == ITEMTYPE_FOOD) then 
		return false
	end

	-- make sure it's not one of the experience drinks
	if IsExperienceDrink(bagId, slotIndex) then return false end
	
	return true
end

-- --------------------------------------------------------------------------------------------------------------------

local function AddContextMenuItem(rowControl)
	-- add a context menu item to select for automatic consumption if right clicking on a usable food or drink
	-- does not work in gamepad mode

	if IsValidFoodOrDrink(rowControl.bagId, rowControl.slotIndex) then
		local itemLink = GetItemLink(rowControl.bagId, rowControl.slotIndex, LINK_STYLE_BRACKETS)
		
		if (itemLink == PASavedVars.ConsumeCharacter.foodLink) and (PASavedVars.ConsumeCharacter.isAutoEatFood) then
		
		
            local entries = {
                    {
                        label = GetString(SI_PA_MENU_CONSUME_LABEL_OFF),
                        callback = function()
                                   SetIsAutoEating(false)
                        end,
                        disabled = false,
                    },
                } 

		    AddCustomSubMenuItem(GetString(SI_PA_SUBMENU_PACO), entries)
			
			-- AddCustomMenuItem(GetString(SI_PA_MENU_CONSUME_LABEL_OFF),
				-- function() 
					-- SetIsAutoEating(false)
				-- end, 
				-- MENU_ADD_OPTION_LABEL)
				
				
				
		else

            local entries = {
                    {
                        label = GetString(SI_PA_MENU_CONSUME_LABEL_ON),
                        callback = function()
                            	   PASavedVars.ConsumeCharacter.foodLink = itemLink
					               SetIsAutoEating(true)
					               outOfFoodWarningCounter = 0
                        end,
                        disabled = false,
                    },
                } 

		    AddCustomSubMenuItem(GetString(SI_PA_SUBMENU_PACO), entries)
		
			-- AddCustomSubMenuItem(GetString(SI_PA_MENU_CONSUME_LABEL_ON), 
				-- function()
					-- PASavedVars.ConsumeCharacter.foodLink = itemLink
					-- SetIsAutoEating(true)
					-- outOfFoodWarningCounter = 0
				-- end, 
				-- MENU_ADD_OPTION_LABEL)
				
		end
		
	elseif IsExperienceDrink(rowControl.bagId, rowControl.slotIndex) then
		local itemLink = GetItemLink(rowControl.bagId, rowControl.slotIndex, LINK_STYLE_BRACKETS)
		
		if (itemLink == PASavedVars.ConsumeCharacter.EXPLink) and (PASavedVars.ConsumeCharacter.isAutoConsumeEXP) then
		
            local entries = {
                    {
                        label = GetString(SI_PA_MENU_CONSUME_LABEL_OFF),
                        callback = function()
                                   SetIsAutoConsumingEXP(false)
                        end,
                        disabled = false,
                    },
                } 

		    AddCustomSubMenuItem(GetString(SI_PA_SUBMENU_PACO), entries)
			
			-- AddCustomMenuItem(GetString(SI_PA_MENU_CONSUME_LABEL_OFF), 
				-- function() 
					-- SetIsAutoConsumingEXP(false)
				-- end, 
				-- MENU_ADD_OPTION_LABEL)
				
				
		else
            local entries = {
                    {
                        label = GetString(SI_PA_MENU_CONSUME_LABEL_ON),
                        callback = function()
                                   PASavedVars.ConsumeCharacter.EXPLink = itemLink
					               SetIsAutoConsumingEXP(true)
					               outOfEXPWarningCounter = 0
                        end,
                        disabled = false,
                    },
                } 

		    AddCustomSubMenuItem(GetString(SI_PA_SUBMENU_PACO), entries)
			
			-- AddCustomMenuItem(GetString(SI_PA_MENU_CONSUME_LABEL_ON), 
				-- function()
					-- PASavedVars.ConsumeCharacter.EXPLink = itemLink
					-- SetIsAutoConsumingEXP(true)
					-- outOfEXPWarningCounter = 0
				-- end, 
				-- MENU_ADD_OPTION_LABEL)
				
		end
	end

	ShowMenu(self)
end



-- --------------------------------------------------------------------------------------------------------------------

local function AddContextMenuItemWithDelay(rowControl)
	zo_callLater(function() AddContextMenuItem(rowControl) end, context_menu_delay)
end

-- --------------------------------------------------------------------------------------------------------------------

local function CanUseItem(bagId, slotIndex) -- Returns: boolean canUseItem
	-- check that it's a usable item
	local usable, usableOnlyFromActionSlot = IsItemUsable(bagId, slotIndex)
	local canInteract = CanInteractWithItem(bagId, slotIndex)
	return usable and not usableOnlyFromActionSlot and canInteract
end

-- --------------------------------------------------------------------------------------------------------------------

local function TryUseFoodItem(bagId, slotIndex) -- Returns: boolean success
	-- make sure that what we're about to use really is a valid food item and is usable
	if IsValidFoodOrDrink(bagId, slotIndex) then
		if CanUseItem(bagId, slotIndex) then
			-- use the food item
			-- UseItem is protected, so CallSecureProtected is used to make the call
			local success = CallSecureProtected("UseItem", bagId, slotIndex)
			return success
		end
	end
end

-- --------------------------------------------------------------------------------------------------------------------

local function TryUseEXPItem(bagId, slotIndex) -- Returns: boolean success
	-- make sure that what we're about to use really is a valid exp item and is usable
	if IsExperienceDrink(bagId, slotIndex) then
		if CanUseItem(bagId, slotIndex) then
			-- use the exp item
			-- UseItem is protected, so CallSecureProtected is used to make the call
			local success = CallSecureProtected("UseItem", bagId, slotIndex)
			return success
		end
	end
end

-- --------------------------------------------------------------------------------------------------------------------

local function ShowLowInventoryWarning(itemLink)
	-- note: item count doesn't update quickly enough right after item is used, so this should be a delayed call if after item use
	-- calculate the remaining inventory for itemLink and show a warning if it's under the threshold
	local remainingInventory = GetBackpackInventory(itemLink)

	if remainingInventory <= low_inventory_warning_threshold then
		PACO.println(zo_strformat(GetString(SI_PA_CHAT_CONSUME_YOU_HAVE_ONLY), remainingInventory))
	end
end

-- --------------------------------------------------------------------------------------------------------------------

local function VerifyFoodConsumed() -- Returns: boolean wasConsumed
    LFDB = LFDB or LIB_FOOD_DRINK_BUFF
	-- load the LibFoodDrinkBuff library and get the player's current food buff status
	local isBuffActive, timeLeftInSeconds, abilityId = LFDB:IsFoodBuffActiveAndGetTimeLeft(player_unit_tag)

	-- make sure the food buff activated. if it has more than the max food buffer left, then it must be a new buff
	return isBuffActive and timeLeftInSeconds > food_buffer_seconds_max
end

-- --------------------------------------------------------------------------------------------------------------------

local function VerifyEXPConsumed() -- Returns: boolean wasConsumed
	
	local isBuffActive, timeLeftInSeconds = IsEXPBuffActiveAndGetTimeLeft(player_unit_tag)

	-- make sure the exp buff activated. if it has more than the max exp buffer left, then it must be a new buff
	return isBuffActive and timeLeftInSeconds > EXP_buffer_seconds_max
end

-- --------------------------------------------------------------------------------------------------------------------

local function ShowConsumedFoodMessage(itemLink)
	-- verify that food was consumed (in case useitem call failed without returning false), tell player, and warn if inventory is running out
	-- this should be called with a delay so inventory and buff information has time to update first
	if VerifyFoodConsumed() then
		-- show a message that the item was consumed
		PACO.println(""..itemLink .. GetString(SI_PA_CHAT_CONSUME_HAS_BEEN_AUTOMATICALLY_CONSUMED))
	
		ShowLowInventoryWarning(itemLink)
	end
end

-- --------------------------------------------------------------------------------------------------------------------

local function ShowConsumedEXPMessage(itemLink)
	-- verify that food was consumed (in case useitem call failed without returning false), tell player, and warn if inventory is running out
	-- this should be called with a delay so inventory and buff information has time to update first
	if VerifyEXPConsumed() then
		-- show a message that the item was consumed
		PACO.println(""..itemLink .. GetString(SI_PA_CHAT_CONSUME_HAS_BEEN_AUTOMATICALLY_CONSUMED))
	
		ShowLowInventoryWarning(itemLink)	
	
	end
end

-- --------------------------------------------------------------------------------------------------------------------

local function EatFood() -- Returns: boolean success
	-- get the character bag size
	local numSlots = GetBagSize(BAG_BACKPACK)
	
	-- iterate through bag to find the item that matches stored foodLink setting
	for slotIndex = 0, numSlots do
		local slotItemLink = GetItemLink(BAG_BACKPACK, slotIndex, LINK_STYLE_BRACKETS)
		if slotItemLink == PASavedVars.ConsumeCharacter.foodLink then
			local success = TryUseFoodItem(BAG_BACKPACK, slotIndex)
			if success then
				-- doesn't seem to update inventory quickly enough to get a correct low inventory count, so call the message with a delay
				zo_callLater(function() ShowConsumedFoodMessage(slotItemLink) end, consumed_message_delay)	
				return true
			else
				return false
			end
		end
	end
	
	-- item wasn't found
	-- get the player's current food buff status and warn in chat
	-- don't want to warn on every timer loop, so check the last warning time flag and the frequency first
	local currentFrameTimeSecs = GetFrameTimeSeconds()
	if currentFrameTimeSecs - lastOutOfInventoryWarningTime > 60 then
		lastOutOfInventoryWarningTime = currentFrameTimeSecs
	
	    LFDB = LFDB or LIB_FOOD_DRINK_BUFF
		-- load the LibFoodDrinkBuff library and get the player's current food buff status
		local isBuffActive, timeLeftInSeconds = LFDB:IsFoodBuffActiveAndGetTimeLeft(player_unit_tag)
		local timeLeftInMinutes = math.floor(timeLeftInSeconds / 60)
	
		PACO.println(zo_strformat(GetString(SI_PA_CHAT_CONSUME_BUT_HAVE_ZERO),PASavedVars.ConsumeCharacter.foodLink))
		
		outOfFoodWarningCounter = outOfFoodWarningCounter + 1
		if outOfFoodWarningCounter >= 10 then
		   SetIsAutoEating(false)
		   outOfFoodWarningCounter = 0
		end

		if isBuffActive then
			if timeLeftInSeconds < 60 then
				PACO.println(zo_strformat(GetString(SI_PA_CHAT_CONSUME_FOOD_EXPIRE_SECONDS), timeLeftInSeconds)) 
			else
				PACO.println(zo_strformat(GetString(SI_PA_CHAT_CONSUME_FOOD_EXPIRE_MINUTES), timeLeftInMinutes))
			end
		end
	end
end

-- --------------------------------------------------------------------------------------------------------------------

local function ConsumeEXP() -- Returns: boolean success
	-- get the character bag size
	local numSlots = GetBagSize(BAG_BACKPACK)
	
	-- iterate through bag to find the item that matches stored expLink setting
	for slotIndex = 0, numSlots do
		local slotItemLink = GetItemLink(BAG_BACKPACK, slotIndex, LINK_STYLE_BRACKETS)
		if slotItemLink == PASavedVars.ConsumeCharacter.EXPLink then
			local success = TryUseEXPItem(BAG_BACKPACK, slotIndex)
			if success then
				-- doesn't seem to update inventory quickly enough to get a correct low inventory count, so call the message with a delay
				zo_callLater(function() ShowConsumedEXPMessage(slotItemLink) end, consumed_message_delay)	
				return true
			else
				return false
			end
		end
	end
	
	-- item wasn't found
	-- get the player's current exp buff status and warn in chat
	-- don't want to warn on every timer loop, so check the last warning time flag and the frequency first
	local currentFrameTimeSecs = GetFrameTimeSeconds()
	if currentFrameTimeSecs - lastOutOfInventoryWarningTime > 60 then
		lastOutOfInventoryWarningTime = currentFrameTimeSecs
	
		-- load the LibFoodDrinkBuff library and get the player's current food buff status
		local isBuffActive, timeLeftInSeconds = IsEXPBuffActiveAndGetTimeLeft(player_unit_tag)
		local timeLeftInMinutes = math.floor(timeLeftInSeconds / 60)
	
		PACO.println(zo_strformat(GetString(SI_PA_CHAT_CONSUME_BUT_HAVE_ZERO),PASavedVars.ConsumeCharacter.EXPLink))
		
		outOfEXPWarningCounter = outOfEXPWarningCounter + 1
		if outOfEXPWarningCounter >= 10 then
		   SetIsAutoConsumingEXP(false)
		   outOfEXPWarningCounter = 0
		end

		if isBuffActive then
			if timeLeftInSeconds < 60 then
				PACO.println(zo_strformat(GetString(SI_PA_CHAT_CONSUME_EXP_EXPIRE_SECONDS), timeLeftInSeconds)) 
			else
				PACO.println(zo_strformat(GetString(SI_PA_CHAT_CONSUME_EXP_EXPIRE_MINUTES), timeLeftInMinutes))
			end
		end
	end
end

-- --------------------------------------------------------------------------------------------------------------------

local function IsUnitAbleToConsume(unitTag) -- Returns: boolean isAbleToUseFood / exp
	-- check for certain player statuses that make using food impossible or undesirable
	if IsUnitInCombat(unitTag) then return false
	elseif IsUnitDeadOrReincarnating(unitTag) then return false
	elseif IsUnitSwimming(unitTag) then return false
	elseif IsPlayerInteractingWithObject() then return false
	elseif IsScryingInProgress() then return false
	elseif IsDiggingGameActive() then return false
	elseif TRIBUTE_SCENE:IsShowing() then return false -- and TRIBUTE.gameFlowState ~= TRIBUTE_GAME_FLOW_STATE_INACTIVE 

	else return true end
end

-- --------------------------------------------------------------------------------------------------------------------

local function OnUpdateTimer() 
	-- exit immediately if automatic eating is turned off, no food or EXP is selected, or the player is currently in combat, dead, or in some other unvailable state
	if not PASavedVars.ConsumeCharacter.isAutoEatFood and not PASavedVars.ConsumeCharacter.isAutoConsumeEXP then return end
	if not IsUnitAbleToConsume(player_unit_tag) then return end
	if PASavedVars.ConsumeCharacter.foodLink == "" and PASavedVars.ConsumeCharacter.EXPLink == "" then return end
    
	LFDB = LFDB or LIB_FOOD_DRINK_BUFF
	
	-- get the player's current food buff status
	local isFoodBuffActive, foodTimeLeftInSeconds = LFDB:IsFoodBuffActiveAndGetTimeLeft(player_unit_tag)
	local isEXPBuffActive, EXPTimeLeftInSeconds = IsEXPBuffActiveAndGetTimeLeft(player_unit_tag)
	
	-- if not already food buffed, set a flag to eat on the next try and exit
	-- flag could prevent potential problem if this triggers between current buff fading and new one starting
	
	if PASavedVars.ConsumeCharacter.isAutoEatFood and PASavedVars.ConsumeCharacter.foodLink ~= "" then
		if not isFoodBuffActive then
			if isEatOnNextUpdate == nil or not isEatOnNextUpdate then
				isEatOnNextUpdate = true
			else
				isEatOnNextUpdate = false
				EatFood()
			end
		end
	end
	
	-- same with exp
	if PASavedVars.ConsumeCharacter.isAutoConsumeEXP and PASavedVars.ConsumeCharacter.EXPLink ~= "" then 
		if not isEXPBuffActive then
			if not isConsumeEXPOnNextUpdate then
				isConsumeEXPOnNextUpdate = true
			else
				isConsumeEXPOnNextUpdate = false
				ConsumeEXP()
			end
		end
	end

	-- eat if the current buff time is less than or equal to the buffer
	-- we don't want to eat all the food up immediately if the buffer gets set really high somehow, so validate that the buffer is in range first
	
	if PASavedVars.ConsumeCharacter.isAutoEatFood and PASavedVars.ConsumeCharacter.foodLink ~= "" then
		if isFoodBuffActive then
			isEatOnNextUpdate = false		-- clear the flag if we got this far in case they manually ate something while waiting for the next update
			local foodBuffer = PASavedVars.ConsumeCharacter.foodBufferSeconds
			if foodBuffer >= food_buffer_seconds_min and foodBuffer <= food_buffer_seconds_max then
				if foodTimeLeftInSeconds <= foodBuffer then
					EatFood()
				end
			else
				-- fix the buffer
				PASavedVars.ConsumeCharacter.foodBufferSeconds = 300
			end
		end
	end
	
		-- same with exp
	if PASavedVars.ConsumeCharacter.isAutoConsumeEXP and PASavedVars.ConsumeCharacter.EXPLink ~= "" then	
		if isEXPBuffActive then
			isConsumeEXPOnNextUpdate = false 	-- clear the flag if we got this far in case they manually ate something while waiting for the next update
			local EXPBuffer = PASavedVars.ConsumeCharacter.EXPBufferSeconds
			if EXPBuffer >= EXP_buffer_seconds_min and EXPBuffer <= EXP_buffer_seconds_max then
				if EXPTimeLeftInSeconds <= EXPBuffer then
					ConsumeEXP()
				end
			else
				-- fix the buffer
				PASavedVars.ConsumeCharacter.EXPBufferSeconds = -1
			end
		end
	end
end	

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Consume = PA.Consume or {}
PA.Consume.OnUpdateTimer = OnUpdateTimer
PA.Consume.AddContextMenuItemWithDelay = AddContextMenuItemWithDelay
PA.Consume.GetBackpackInventory = GetBackpackInventory
PA.Consume.SetFoodBufferSeconds = SetFoodBufferSeconds
PA.Consume.SetEXPBufferSeconds = SetEXPBufferSeconds
PA.Consume.SetIsAutoEating = SetIsAutoEating
PA.Consume.SetIsAutoConsumingEXP = SetIsAutoConsumingEXP