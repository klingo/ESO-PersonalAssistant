-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAW = PA.Worker
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local function CanRefineItem(bagId, slotIndex) 
    -- ZOS function CanItemBeRefined is not used here because we already have a list

    -- FCOItemSaver support
	if not IsInGamepadPreferredMode() and FCOIS then -- Gamepad mode ist VERBOTEN mit FCOIS (not supported and causes UI errors)
		if FCOIS.IsRefinementLocked(bagId, slotIndex, nil) then -- protected, don't refine 
			return false
		end
	end	
	
	return true 
end

-- --------------------------------------------------------------------------------------------------------------------	


local function RoundToRequiredSmithingRefinementStackSize(number)
     return zo_min(math.floor(number/GetRequiredSmithingRefinementStackSize())* GetRequiredSmithingRefinementStackSize(), MAX_ITERATIONS_PER_DECONSTRUCTION)
end
-- --------------------------------------------------------------------------------------------------------------------		   
		   
local function DoubleCheckAndRefineThatMaterial(searchedItemId)
    
	local foundIt = false
	local bagId = BAG_BACKPACK
	local bagSlots = GetBagSize(bagId)
	local fakeItemLink = "|H0:item:"..searchedItemId..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
    local backpackCount, bankCount, craftBagCount = GetItemLinkStacks(fakeItemLink)	
    local totalCount = backpackCount + bankCount + craftBagCount
	
	
	for slotIndex = 0, bagSlots do
	    local itemId = GetItemId(bagId, slotIndex)
		if itemId == searchedItemId and CanRefineItem(bagId, slotIndex) then
		    -- now we can open the refine tab
		    if IsInGamepadPreferredMode() and SCENE_MANAGER:GetCurrentScene():GetName() ~= "gamepad_smithing_refine" then
			    SCENE_MANAGER:Show("gamepad_smithing_refine")
		    elseif ZO_MenuBar_GetSelectedDescriptor(SMITHING.modeBar) ~= SMITHING_MODE_REFINEMENT then
			    ZO_MenuBar_SelectDescriptor(SMITHING.modeBar, SMITHING_MODE_REFINEMENT, true, false) 
			end 
			
			-- select material
			if IsInGamepadPreferredMode() then
			   SMITHING_GAMEPAD.refinementPanel:AddItemToCraft(bagId, slotIndex)
			else
			    SMITHING.refinementPanel:AddItemToCraft(bagId, slotIndex) 
			end
			
			if PAW.currentCraftingStation == "None" then -- abort if goofy player removes from crafting station 
			    return
			end
			-- refine material
			if IsInGamepadPreferredMode() then
				SMITHING_GAMEPAD.refinementPanel:ExtractPartialStack(RoundToRequiredSmithingRefinementStackSize(totalCount))
			else
			    SMITHING.refinementPanel:ConfirmRefine() 
			end	
            local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)
			PAW.println(SI_PA_CHAT_ITEM_REFINED, itemLink)
			foundIt = true
			return
		end
	end
	
	if not foundIt then
        bagId = BAG_BANK
		bagSlots = GetBagSize(bagId)
		for slotIndex = 0, bagSlots do
			local itemId = GetItemId(bagId, slotIndex)
			if itemId == searchedItemId and CanRefineItem(bagId, slotIndex) then
				-- now we can open the refine tab
				if IsInGamepadPreferredMode() and SCENE_MANAGER:GetCurrentScene():GetName() ~= "gamepad_smithing_refine" then
					SCENE_MANAGER:Show("gamepad_smithing_refine")
				elseif ZO_MenuBar_GetSelectedDescriptor(SMITHING.modeBar) ~= SMITHING_MODE_REFINEMENT then
					ZO_MenuBar_SelectDescriptor(SMITHING.modeBar, SMITHING_MODE_REFINEMENT, true, false) 
				end 
				-- select material
				if IsInGamepadPreferredMode() then
				   SMITHING_GAMEPAD.refinementPanel:AddItemToCraft(bagId, slotIndex)
				else
					SMITHING.refinementPanel:AddItemToCraft(bagId, slotIndex) 
				end
				if PAW.currentCraftingStation == "None" then -- abort if goofy player removes from crafting station
					return
				end
				-- refine material
				if IsInGamepadPreferredMode() then
					SMITHING_GAMEPAD.refinementPanel:ExtractPartialStack(RoundToRequiredSmithingRefinementStackSize(totalCount))
				else
					SMITHING.refinementPanel:ConfirmRefine() 
				end	
                local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)
				PAW.println(SI_PA_CHAT_ITEM_REFINED, itemLink)
				foundIt = true
				return
			end
		end	
    end
	
	if not foundIt then
        bagId = BAG_VIRTUAL
        local slotIndex = GetNextVirtualBagSlotId(nil)
	    while slotIndex ~= nil do 
			local itemId = GetItemId(bagId, slotIndex)
			if itemId == searchedItemId and CanRefineItem(bagId, slotIndex) then
				-- now we can open the refine tab
				if IsInGamepadPreferredMode() and SCENE_MANAGER:GetCurrentScene():GetName() ~= "gamepad_smithing_refine" then
					SCENE_MANAGER:Show("gamepad_smithing_refine")
				elseif ZO_MenuBar_GetSelectedDescriptor(SMITHING.modeBar) ~= SMITHING_MODE_REFINEMENT then
					ZO_MenuBar_SelectDescriptor(SMITHING.modeBar, SMITHING_MODE_REFINEMENT, true, false) 
				end 
				-- select material
				if IsInGamepadPreferredMode() then
				   SMITHING_GAMEPAD.refinementPanel:AddItemToCraft(bagId, slotIndex)
				else
					SMITHING.refinementPanel:AddItemToCraft(bagId, slotIndex) 
				end
				if PAW.currentCraftingStation == "None" then -- abort if goofy player removes from crafting station
					return
				end
				-- refine material
				if IsInGamepadPreferredMode() then
					SMITHING_GAMEPAD.refinementPanel:ExtractPartialStack(RoundToRequiredSmithingRefinementStackSize(totalCount))
				else
					SMITHING.refinementPanel:ConfirmRefine() 
				end	
                local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)
				PAW.println(SI_PA_CHAT_ITEM_REFINED, itemLink)
                return 
			end
			slotIndex = GetNextVirtualBagSlotId(slotIndex)
		end	
    end
end

-- --------------------------------------------------------------------------------------------------------------------

function PAW.isbonusmaxed(bonus, searchedAbilityId, itemLink)
    local prog = GetNonCombatBonus(bonus) 

	if bonus == NON_COMBAT_BONUS_ENCHANTING_DECONSTRUCTION_UPGRADE then
	    if prog == 3 then
		   return true
		end
	elseif prog == 4 then
	       return true
	end
    
	if itemLink then
	    PAW.println(SI_PA_CHAT_NO_EXTRACTION_FOR_ITEM, GetAbilityName(searchedAbilityId), itemLink)
	else
	    PAW.println(SI_PA_CHAT_NO_EXTRACTION, GetAbilityName(searchedAbilityId))
	end	
    return false
end

-- --------------------------------------------------------------------------------------------------------------------

local function StartRefining(autoResearchTrait)
      
	  local checkExtraction = PAW.SavedVars.checkExtraction
	  
      local refinableItemsToCheck = {} -- itemIds of allowed refinable items per crafting station
      if PAW.currentCraftingStation == "JewelryCrafting" then
	        if checkExtraction and not PAW.isbonusmaxed(NON_COMBAT_BONUS_JEWELRYCRAFTING_EXTRACT_LEVEL, 103645) then
			   return
			end
	        refinableItemsToCheck = {135137, 135139, 135141, 135143, 135145, 135160, 135158, 135159, 139420, 139419, 139417, 139415, 139416, 139418} 
	  elseif PAW.currentCraftingStation == "Clothier" then
	        if checkExtraction and not PAW.isbonusmaxed(NON_COMBAT_BONUS_CLOTHIER_EXTRACT_LEVEL, 48195) then
			   return
			end
	        refinableItemsToCheck = {812, 4464, 23129, 23130, 23131, 33217, 33218, 33219, 33220, 71200, 793, 4448, 23095, 6020, 23097, 23142, 23143, 800, 4478, 71239, 64688, 57665, 64690, 121523, 130062, 130058, 121521, 121522, 69556, 59923, 75371, 81995, 81997, 76911}
	  elseif PAW.currentCraftingStation == "Blacksmithing" then
	        if checkExtraction and not PAW.isbonusmaxed(NON_COMBAT_BONUS_BLACKSMITHING_EXTRACT_LEVEL, 48165) then
			   return
			end
	         refinableItemsToCheck = {808, 5820, 23103, 23104, 23105, 4482, 23133, 23134, 23135, 71198, 64688, 57665, 64690, 121523, 130062, 130058, 121521, 121522, 69556, 59923, 75371, 81995, 81997, 76911}
	  elseif PAW.currentCraftingStation == "Woodworking" then
	        if checkExtraction and not PAW.isbonusmaxed(NON_COMBAT_BONUS_WOODWORKING_EXTRACT_LEVEL, 48180) then
			   return
			end
	         refinableItemsToCheck = {802, 521, 23117, 23118, 23119, 818, 4439, 23137, 23138, 71199, 64688, 57665, 64690, 121523, 130062, 130058, 121521, 121522, 69556, 59923, 75371, 81995, 81997, 76911}
	  end
	  
      local itemsToRefine = {} -- itemIds of refinable items allowed by settings with the sufficent stack amount picked from refinableItemsToCheck
	  for _, itemId in ipairs(refinableItemsToCheck) do
          local itemIdText = tostring(itemId)    	
          local itemLink = "|H0:item:"..itemIdText..":1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
          local backpackCount, bankCount, craftBagCount = GetItemLinkStacks(itemLink)	
          local totalCount = backpackCount + bankCount + craftBagCount		  
	      local formatedValue = {}
		        table.insert(formatedValue, "MaterialsToRefine")
		        table.insert(formatedValue, itemIdText)
          local enabled = PA.MenuFunctions.PAWorker.getRefinableMaterialSetting(formatedValue)
		  
		  if enabled and totalCount >= GetRequiredSmithingRefinementStackSize() then
		      table.insert(itemsToRefine, itemId)
          end  
	  end
      
	  if ZO_IsTableEmpty(itemsToRefine) then -- no items to refine, nothing to do, abort 
	     if autoResearchTrait then
		    PAW.StartResearchTrait()
		 end
	     return
	  end	
	  
      local whenToCallReasearchTrait = 1000	  
	  for key, searchedItemId in ipairs(itemsToRefine) do
		  local time = key * 1000 -- we call each mat 1 second later to avoid the confirm prompt between different refine materials & also because coming from deconstruct
		  if not PAW.hasDeconstructed then -- don't wait 1 second if there was no deconstruction before
		     time = time - 979 
		  end
		  zo_callLater(function() DoubleCheckAndRefineThatMaterial(searchedItemId) end, time)
		  whenToCallReasearchTrait = (key + 1) * 1000
      end
	  
	  if autoResearchTrait then
		 zo_callLater(function() PAW.StartResearchTrait() end, whenToCallReasearchTrait)  
	  end
	  
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Worker = PA.Worker or {}
PA.Worker.StartRefining = StartRefining
