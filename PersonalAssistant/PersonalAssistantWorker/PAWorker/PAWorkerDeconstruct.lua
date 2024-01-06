-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAW = PA.Worker
local PAHF = PA.HelperFunctions
local PASavedVars = PA.SavedVars



-- ---------------------------------------------------------------------------------------------------------------------

local function _canWeaponArmorJewelryBeDeconstructed(savedVarsGroup, itemLink, itemQuality)
    if savedVarsGroup ~= nil and istable(savedVarsGroup) then
        local qualityThreshold = savedVarsGroup.autoMarkQualityThreshold
        if qualityThreshold ~= PAC.ITEM_QUALITY.DISABLED and itemQuality <= qualityThreshold then
            -- quality threshold would be reached, check other includes now
            local hasSet = GetItemLinkSetInfo(itemLink, false)
            if not hasSet or (hasSet and savedVarsGroup.autoMarkIncludingSets) then
                local itemTraitType = GetItemLinkTraitType(itemLink)
                if itemTraitType == ITEM_TRAIT_TYPE_NONE then
                    -- if the item has passed the quality-check and the set-check, and has no traits then it can be deconstructed
                    return true
                else
                    local canBeResearched = CanItemLinkBeTraitResearched(itemLink)
                    if (not canBeResearched and savedVarsGroup.autoMarkKnownTraits) or (canBeResearched and savedVarsGroup.autoMarkUnknownTraits) then
                        local isIntricateTtrait = PAHF.isItemLinkIntricateTraitType(itemLink)
                        if not isIntricateTtrait or (isIntricateTtrait and savedVarsGroup.autoMarkIntricateTrait) then
                            return true
                        end
                    end
                end
            end
        end
    end
    -- if unknown or no match, return false
    return false
end

-- --------------------------------------------------------------------------------------------------------------------

local function CanDeconstructItem(bagId, slotIndex)
    local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)
	if itemLink == "" or itemLink == nil then
		return false
	end
	
	local itemType, specializedItemType = GetItemType(bagId, slotIndex)
	local itemTrait = GetItemTrait(bagId, slotIndex)
	
	if PAW.currentCraftingStation == "Universal" and -- we check if extraction is maxed in the item's crafting skill type 
	(itemType == ITEMTYPE_WEAPON or itemType == ITEMTYPE_ARMOR or itemType == ITEMTYPE_GLYPH_ARMOR or itemType == ITEMTYPE_GLYPH_JEWELRY 
	or itemType == ITEMTYPE_GLYPH_WEAPON) then 
	   local checkExtraction = PAW.SavedVars.checkExtraction 
	   local craftingSkillType, _,_,_,_ = GetItemCraftingInfo(bagId, slotIndex)
	   local EquipmentFilterType = GetItemEquipmentFilterType(bagId, slotIndex)
	   if checkExtraction then
			if craftingSkillType == CRAFTING_TYPE_ENCHANTING then 
				if checkExtraction and not PAW.isbonusmaxed(NON_COMBAT_BONUS_ENCHANTING_DECONSTRUCTION_UPGRADE, 46769, itemLink) then
				   return false
				end
				
			elseif craftingSkillType == CRAFTING_TYPE_JEWELRYCRAFTING or EquipmentFilterType == EQUIPMENT_FILTER_TYPE_NECK or EquipmentFilterType == EQUIPMENT_FILTER_TYPE_RING then
					if not PAW.isbonusmaxed(NON_COMBAT_BONUS_JEWELRYCRAFTING_EXTRACT_LEVEL, 103645, itemLink) then
					   return false
					end
			
			elseif craftingSkillType == CRAFTING_TYPE_CLOTHIER or EquipmentFilterType == EQUIPMENT_FILTER_TYPE_LIGHT or EquipmentFilterType == EQUIPMENT_FILTER_TYPE_MEDIUM then
					if not PAW.isbonusmaxed(NON_COMBAT_BONUS_CLOTHIER_EXTRACT_LEVEL, 48195, itemLink) then
					   return false
					end
					
			elseif craftingSkillType == CRAFTING_TYPE_BLACKSMITHING or EquipmentFilterType == EQUIPMENT_FILTER_TYPE_HEAVY or EquipmentFilterType == EQUIPMENT_FILTER_TYPE_ONE_HANDED or EquipmentFilterType == EQUIPMENT_FILTER_TYPE_TWO_HANDED then
					if not PAW.isbonusmaxed(NON_COMBAT_BONUS_BLACKSMITHING_EXTRACT_LEVEL, 48165, itemLink) then
					   return  false
					end
			
			elseif craftingSkillType == CRAFTING_TYPE_WOODWORKING or EquipmentFilterType == EQUIPMENT_FILTER_TYPE_BOW or EquipmentFilterType == EQUIPMENT_FILTER_TYPE_DESTRO_STAFF or EquipmentFilterType == EQUIPMENT_FILTER_TYPE_RESTO_STAFF or EquipmentFilterType == EQUIPMENT_FILTER_TYPE_SHIELD then
					if not PAW.isbonusmaxed(NON_COMBAT_BONUS_WOODWORKING_EXTRACT_LEVEL, 48180, itemLink) then
					   return  false
					end
			end
       end		
	end
	
	-- FCOItemSaver support
	if not IsInGamepadPreferredMode() and FCOIS then -- Gamepad mode ist VERBOTEN mit FCOIS (not supported and causes UI errors)
		if FCOIS.IsDeconstructionLocked(bagId, slotIndex, nil) then -- protected, don't deconstruct 
			return false
		end
		
		-- Baertram, FCOIS author says the following is not reliable (using IsMarked) while this has been requested by users, what do we do? ^^!
		if FCOIS.IsMarked then 
			local isMarked, _ = FCOIS.IsMarked(bagId, slotIndex, {9}, nil) -- item doomed, deconstruct it!
			if isMarked then
			   return true
			end
		end
	end
	
	local PAWorkerSavedVars = PAW.SavedVars
	
	if PAWorkerSavedVars.ProtectUncollectedSetItems and IsItemLinkSetCollectionPiece(itemLink) then -- Don't deconstruct uncollected set items
		local setId = select(6, GetItemLinkSetInfo(itemLink, false))
		local slot = GetItemLinkItemSetCollectionSlot(itemLink)
		if not IsItemSetCollectionSlotUnlocked(setId, slot) then
			return false 
		end
	end
	
	local isCrafted = IsItemLinkCrafted(itemLink)
	if isCrafted then -- don't deconstruct crafted items 
	    return false 
	end
	
	local isReconstructed = IsItemReconstructed(bagId,slotIndex)
	if isReconstructed then -- don't deconstruct reonstructed items
	   return false
	end
	
	
	local isJunk = IsItemJunk(bagId,slotIndex)
	if isJunk and PA.Junk and PA.Junk.SavedVars and PA.Junk.SavedVars.autoSellJunk then -- junk is for selling to merchants if autoSellJunk is enabled
	   return false
	end

    local _, _, _, _, locked, _, itemStyleId, itemQuality, displayQuality = GetItemInfo(bagId, slotIndex)
    if locked or displayQuality == ITEM_DISPLAY_QUALITY_MYTHIC_OVERRIDE then -- exclude locked & Mythic items
       return false
	end
	
	-- here we filter the crafting stations
	local craftingSkillType = 999  
	if PAW.currentCraftingStation == "Universal" then 
	       craftingSkillType = nil
	elseif PAW.currentCraftingStation == "Clothier" then
	       craftingSkillType = CRAFTING_TYPE_CLOTHIER  
	elseif PAW.currentCraftingStation == "Blacksmithing" then
	       craftingSkillType = CRAFTING_TYPE_BLACKSMITHING
	elseif PAW.currentCraftingStation == "Woodworking" then
	       craftingSkillType = CRAFTING_TYPE_WOODWORKING
	elseif PAW.currentCraftingStation == "Enchanting" then
	       craftingSkillType = CRAFTING_TYPE_ENCHANTING
	elseif PAW.currentCraftingStation == "JewelryCrafting" then
	       craftingSkillType = CRAFTING_TYPE_JEWELRYCRAFTING
    end
    

    local meetRules = false

	if itemType == ITEMTYPE_WEAPON or itemType == ITEMTYPE_ARMOR then

		-- check if it has the [Ornate] trait and can be deconstructed or not
		if itemTrait == ITEM_TRAIT_TYPE_WEAPON_ORNATE and PAWorkerSavedVars.Weapons.autoMarkOrnate or
				itemTrait == ITEM_TRAIT_TYPE_ARMOR_ORNATE and PAWorkerSavedVars.Armor.autoMarkOrnate or
				itemTrait == ITEM_TRAIT_TYPE_JEWELRY_ORNATE and PAWorkerSavedVars.Jewelry.autoMarkOrnate then
			meetRules = true
		elseif 	itemTrait == ITEM_TRAIT_TYPE_WEAPON_INTRICATE and PAWorkerSavedVars.Weapons.autoMarkIntricateTrait or
                        itemTrait == ITEM_TRAIT_TYPE_ARMOR_INTRICATE and PAWorkerSavedVars.Armor.autoMarkIntricateTrait  or
                        itemTrait == ITEM_TRAIT_TYPE_JEWELRY_INTRICATE and PAWorkerSavedVars.Jewelry.autoMarkIntricateTrait then
			meetRules = true			
		else
			-- if it is NOT with [Ornate] or [intricate] trait, check more detailed the individual equipTypes
			if itemType == ITEMTYPE_WEAPON and PAWorkerSavedVars.Weapons.autoMarkQualityThreshold ~= PAC.ITEM_QUALITY.DISABLED then
				-- handle WEAPONS
				if _canWeaponArmorJewelryBeDeconstructed(PAWorkerSavedVars.Weapons, itemLink, itemQuality) then
					meetRules = true
				end
			elseif itemType == ITEMTYPE_ARMOR then
				local itemEquipType = GetItemLinkEquipType(itemLink)
				if itemEquipType == EQUIP_TYPE_RING or itemEquipType == EQUIP_TYPE_NECK then
					-- handle JEWELRY
					if _canWeaponArmorJewelryBeDeconstructed(PAWorkerSavedVars.Jewelry, itemLink, itemQuality) then
						meetRules = true
					end
				else
					-- handle APPAREL
					if _canWeaponArmorJewelryBeDeconstructed(PAWorkerSavedVars.Armor, itemLink, itemQuality) then
						meetRules = true
					end
				end
			end
		end
	elseif (itemType == ITEMTYPE_GLYPH_ARMOR or itemType == ITEMTYPE_GLYPH_JEWELRY or itemType == ITEMTYPE_GLYPH_WEAPON) and -- working
			PAWorkerSavedVars.Miscellaneous.autoMarkGlyphQualityThreshold ~= PAC.ITEM_QUALITY.DISABLED then
		if itemQuality <= PAWorkerSavedVars.Miscellaneous.autoMarkGlyphQualityThreshold then
			meetRules = true
		end
	end
	

    if CanItemBeDeconstructed(bagId, slotIndex, craftingSkillType) and meetRules then
	    -- we open the right tab if not already before continuing
	    if craftingSkillType == CRAFTING_TYPE_ENCHANTING then
		   if ZO_MenuBar_GetSelectedDescriptor(ENCHANTING.modeBar) ~= ENCHANTING_MODE_EXTRACTION then 
	          ZO_MenuBar_SelectDescriptor(ENCHANTING.modeBar, ENCHANTING_MODE_EXTRACTION, true, false)
           end			  
		elseif not craftingSkillType then

		   if IsInGamepadPreferredMode() and ZO_UniversalDeconstructionInventory_Gamepad:GetCurrentFilterType() ~= "all" then
		       local FILTERTYPE = ZO_GetUniversalDeconstructionFilterType('all')
		       UNIVERSAL_DECONSTRUCTION_GAMEPAD.deconstructionPanel:SetFilterType(FILTERTYPE.filter, FILTERTYPE)
		   end 

        else
		   if ZO_MenuBar_GetSelectedDescriptor(SMITHING.modeBar) ~= SMITHING_MODE_DECONSTRUCTION then
              ZO_MenuBar_SelectDescriptor(SMITHING.modeBar, SMITHING_MODE_DECONSTRUCTION, true, false) 
		   end
	   end
	    PAW.hasDeconstructed = true
	    return true
	else
        return false	
	end
end

-- --------------------------------------------------------------------------------------------------------------------

local function FilterThisBagAndAddToMessage(bagId)
	local bagSlots = GetBagSize(bagId)
	for slotIndex = 0, bagSlots do
		if CanDeconstructItem(bagId, slotIndex) then
 			local itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS)
			if AddItemToDeconstructMessage(bagId, slotIndex, 1) then
			   PAW.println(SI_PA_CHAT_ITEM_DECONSTRUCTED, itemLink)
			end  
		end
	end

end

-- --------------------------------------------------------------------------------------------------------------------

local function GetSmithingObject()
	if IsInGamepadPreferredMode() then
		if PAW.currentCraftingStation == "Universal" then
			return UNIVERSAL_DECONSTRUCTION_GAMEPAD
		else
			return SMITHING_GAMEPAD
		end
	else
		if PAW.currentCraftingStation == "Universal" then
			return UNIVERSAL_DECONSTRUCTION
		else
			return SMITHING
		end
	end
end
-- --------------------------------------------------------------------------------------------------------------------

local function IncludeBankedItems()
	local isBankIncluded = GetSmithingObject().deconstructionPanel.savedVars.includeBankedItemsChecked and not PA.MenuFunctions.PAWorker.getProtectBankSetting()
	return isBankIncluded
end

-- --------------------------------------------------------------------------------------------------------------------

local function StartDeconstructing(autoRefine, autoResearchTrait)

    PrepareDeconstructMessage()

	FilterThisBagAndAddToMessage(BAG_BACKPACK)
	
	if IncludeBankedItems() then
		-- ESO+ Bank
		if IsESOPlusSubscriber() then
			FilterThisBagAndAddToMessage(BAG_SUBSCRIBER_BANK)
		end
		-- Bank
		FilterThisBagAndAddToMessage(BAG_BANK)
	end

   SendDeconstructMessage()

   if autoRefine and PAW.currentCraftingStation ~= "Universal" and PAW.currentCraftingStation ~= "Enchanting" then -- once done we call autorefine
	   PAW.StartRefining(autoResearchTrait)
   elseif autoResearchTrait and PAW.currentCraftingStation ~= "Universal" and PAW.currentCraftingStation ~= "Enchanting" then -- if no autorefine we call autoResearchTrait
       PAW.StartResearchTrait()
   end
end	

-- ---------------------------------------------------------------------------------------------------------------------


local function HasAnyCraftingWrit()
	local anyFound = false

	for i=1 , GetNumJournalQuests() do
		if GetJournalQuestType(i) == QUEST_TYPE_CRAFTING then 
            anyFound = true
		end
	end
	
	return anyFound
end


-- ---------------------------------------------------------------------------------------------------------------------

local function StartCraftingInterraction(craftSkill, sameStation, craftMode, autoDeconstruct, autoRefine, autoResearchTrait) 
  
	if craftMode == CRAFTING_INTERACTION_MODE_UNIVERSAL_DECONSTRUCTION then
		PAW.currentCraftingStation = "Universal"
	elseif craftSkill == CRAFTING_TYPE_CLOTHIER then
		PAW.currentCraftingStation = "Clothier"
	elseif craftSkill == CRAFTING_TYPE_BLACKSMITHING then
		PAW.currentCraftingStation = "Blacksmithing"
	elseif craftSkill == CRAFTING_TYPE_WOODWORKING then
		PAW.currentCraftingStation = "Woodworking"
	elseif craftSkill == CRAFTING_TYPE_ENCHANTING then
		PAW.currentCraftingStation = "Enchanting"
	elseif craftSkill == CRAFTING_TYPE_JEWELRYCRAFTING then
		PAW.currentCraftingStation = "JewelryCrafting"
	else
        PAW.currentCraftingStation = "None"	
		PAW.hasDeconstructed = false 
	end
 
	
	if PAW.currentCraftingStation == "None" then -- not the right station or not (anymore) at a station so we abort
	    return 
	end

    -- if WritCreater and PAW.currentCraftingStation ~= "Universal" then -- Abort when Dolgubon's Lazy Writ Crafter needs to work except for universal deconstruction
	   -- local _, hasAny = WritCreater.writSearch()
	   -- if hasAny then
	      -- return
	   -- end	
    -- end

    if HasAnyCraftingWrit() and PAW.currentCraftingStation ~= "Universal" then  -- local check for any crafting quest ongoing and abort if true except for universal deconstruction
	   PAW.println(SI_PA_CHAT_CRAFTING_QUEST) 
	   return 
	end	
	
	if not autoDeconstruct and not autoRefine then -- autoDeconstruct and autoRefine are both off so we abort
	    if autoResearchTrait then
		   PAW.StartResearchTrait()
		end
    	return
	end
	
	-- Checks if meticulous disassembly skill is slotted
	if PAW.SavedVars.CheckMeticulousDisassembly then	
	    local Meticulous
		for index = 1, 12 do
			if GetSlotBoundId(index, HOTBAR_CATEGORY_CHAMPION) == 83 then
                Meticulous = true   
			end
		end
		if not Meticulous then
		   -- We wait 1 second for Jack Of All Trades to slot Meticulous Disassembly 
		   if JackOfAllTrades and JackOfAllTrades.savedVariables and JackOfAllTrades.savedVariables.enable and JackOfAllTrades.savedVariables.enable.meticulousDisassembly then	
			  zo_callLater(function() StartCraftingInterraction(craftSkill, sameStation, craftMode, autoDeconstruct, autoRefine) end, 1000) 
			  return
		   end		   
		
		   PAW.println(SI_PA_CHAT_NO_METICULOUS)
		   if autoResearchTrait then
		      PAW.StartResearchTrait()
		   end
		   return
		end
	end
	
	-- we check if extraction is maxed
	local checkExtraction = PAW.SavedVars.checkExtraction
	if PAW.currentCraftingStation == "Enchanting" then 
		if checkExtraction and not PAW.isbonusmaxed(NON_COMBAT_BONUS_ENCHANTING_DECONSTRUCTION_UPGRADE, 46769) then
		   return
		end
		
	elseif PAW.currentCraftingStation == "JewelryCrafting" then
	        if checkExtraction and not PAW.isbonusmaxed(NON_COMBAT_BONUS_JEWELRYCRAFTING_EXTRACT_LEVEL, 103645) then
			   	if autoResearchTrait then
		           PAW.StartResearchTrait()
		        end 
			   return
			end
	
	elseif PAW.currentCraftingStation == "Clothier" then
	        if checkExtraction and not PAW.isbonusmaxed(NON_COMBAT_BONUS_CLOTHIER_EXTRACT_LEVEL, 48195) then
			   	if autoResearchTrait then
		           PAW.StartResearchTrait()
		        end 
			   return
			end
			
	elseif PAW.currentCraftingStation == "Blacksmithing" then
	        if checkExtraction and not PAW.isbonusmaxed(NON_COMBAT_BONUS_BLACKSMITHING_EXTRACT_LEVEL, 48165) then
			   	if autoResearchTrait then
		           PAW.StartResearchTrait()
		        end 
			   return
			end
	
	elseif PAW.currentCraftingStation == "Woodworking" then
	        if checkExtraction and not PAW.isbonusmaxed(NON_COMBAT_BONUS_WOODWORKING_EXTRACT_LEVEL, 48180) then
			   if autoResearchTrait then
		          PAW.StartResearchTrait()
		       end 
			   return
			end
	end
	
    if not autoDeconstruct and autoRefine then -- Deconstruct is off but autorefine is on  
	   if PAW.currentCraftingStation ~= "Universal" and PAW.currentCraftingStation ~= "Enchanting" then -- ensure it is not universal deconstruction or enchanting before calling autorefine
	       PAW.StartRefining()
	   end
	   return 
	end
	
	StartDeconstructing(autoRefine, autoResearchTrait) -- everything else is good so we start deconstructing
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Worker = PA.Worker or {}
PA.Worker.StartCraftingInterraction = StartCraftingInterraction
