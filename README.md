# PersonalAssistant
PersonalAssistant, an Addon for 'The Elder Scrolls Online'

***

## Download
http://www.esoui.com/downloads/info381-PersonalAssistant.html

***

## How to use
tbd

***

## Development ToDo

#### General
* [ ] Update Currency System
  * https://forums.elderscrollsonline.com/en/discussion/200789/imperial-city-api-patch-notes-change-log-live/p1
  * https://forums.elderscrollsonline.com/en/discussion/371967/update-16-api-patch-notes-change-log-pts#latest
* [ ] Support ESO Plus Bags
  * BAG_VIRTUAL (Dark Brotherhood)
    * https://forums.elderscrollsonline.com/en/discussion/261946/dark-brotherhood-api-patch-notes-change-log-pts
  * BAG_SUBSCRIBER_BANK (Morrowind)
    * https://forums.elderscrollsonline.com/en/discussion/335644/update-14-api-patch-notes-change-log-pts
* [ ] Check ItemLink Handling in HelperFunctions.lua
  * http://www.esoui.com/forums/showthread.php?t=2054
  * http://www.esoui.com/forums/showthread.php?t=1944
* [ ] Check Singular/Plural formatting for HelperFunctions.lua
    * http://www.esoui.com/forums/showthread.php?p=7988
* [ ] Update to latest LAM version
* [ ] Make "PersonalAssistant" the top-level-Addon and move others as nested-Addons
  * https://wiki.esoui.com/Addon_Structure
* [ ] Update Addon Manifest
  * https://wiki.esoui.com/Addon_manifest_(.txt)_format
  * AddOnVersion
  * Variable Expansion - $(language)
  
  
#### PABanking
* [ ] PARepair: Add chat message when repairing with Repair Kits


#### PABanking
* [ ] PABanking: Refactor regarding inventory-loop  
    ```lua
    local bagSlots = SHARED_INVENTORY:GetBagCache(BAG_BACKPACK)
    if bagSlots then
        for index, data in pairs(bagSlots) do
            data.stolen
            data.isGemmable
            itemLink = GetItemLink(BAG_BACKPACK, index)
        end
    end
    ```
* [ ] PABanking: Refactor regarding Item Movement  
    ```lua
    RequestMoveItem (number sourceBag, number sourceSlot, number destBag, number destSlot, number stackCount)
    ```
* [ ] PABanking: Check new function for transferring currencies
    ```lua
    TransferCurrency(currencyType, amount, fromLocation, toLocation).
    ```
* [ ] PABanking: Support Home Storage Banking Bags
    ```lua
    BAG_HOUSE_BANK_ONE through BAG_HOUSE_BANK_TEN
    GetBankingBag() – bankingBag.
    IsHouseBankBag(bag) – isHouseBankBag.
    GetCollectibleForHouseBankBag(houseBankBag) – collectibleId.
    GetCollectibleBankAccessBag(collectibleId) – houseBankBag.
    ```
* [ ] PABanking: Crafting Material - Add buttons for Deposit/Withdraw/Ignore all
* [ ] PABanking: Crafting Material - Add Jewelcrafting items
    ```lua
    ITEMTYPE_JEWELRYCRAFTING_BOOSTER
    ITEMTYPE_JEWELRYCRAFTING_MATERIAL
    ITEMTYPE_JEWELRYCRAFTING_RAW_BOOSTER
    ITEMTYPE_JEWELRYCRAFTING_RAW_MATERIAL
    ITEMTYPE_JEWELRY_RAW_TRAIT
    ITEMTYPE_JEWELRY_TRAIT
    ```
* [ ] PABanking: Crafting Material - Add Furnishing items
    ```lua
    ITEMTYPE_FURNISHING
    ITEMTYPE_FURNISHING_MATERIAL 
    ```
* [ ] PABanking: Common Item Types - Add Maps (utilizing SpeializedItemTypes)
* [ ] PABanking: Advanced Item Types - Add Soul gems (empty / filled)
* [ ] PABanking: Advanced Item Types - Add Repair Kits (only Grand?)
* [ ] PABanking: Add option to select type of notifications
* [ ] PABanking: Add summary after transaction completed


#### PALoot
* [ ] PALoot: Loot other currencies than gold  - Still needed?!
    ```lua
    GetLootCurrency(number CurrencyType type)  
    Returns: number unownedCurrency, number ownedCurrency
  
    CURT_ALLIANCE_POINTS
    CURT_TELVAR_STONES
    ```
* [ ] PALoot: Check global ESO settings for AutoLoot
    * http://cdn.esoui.com/forums/showthread.php?p=20437
        *  GetSettingBool(SETTING_TYPE_LOOT, LOOT_SETTING_AOE_LOOT)
        *  GetSettingBool(SETTING_TYPE_LOOT, LOOT_SETTING_AUTO_ADD_TO_CRAFT_BAG)
        *  GetSettingBool(SETTING_TYPE_LOOT, LOOT_SETTING_AUTO_LOOT)
        *  GetSettingBool(SETTING_TYPE_LOOT, LOOT_SETTING_AUTO_LOOT_STOLEN)
        *  GetSettingBool(SETTING_TYPE_LOOT, LOOT_SETTING_LOOT_HISTORY)
* [ ] PALoot: Check if special message for Stealing is added?
* [ ] PALoot: Harvestable Items - Add Jewelcrafting items


#### PAJunk
* [ ] PAJunk: Add support for FCOItemSaver
  * http://www.esoui.com/downloads/info630-FCOItemSaver.html
  * www.esoui.com/forums/showthread.php?t=6987
* [ ] PAJunk: Check if special message for marking as Trash/Ornate exists
* [ ] PAJunk: Add option to select type of notifications
   
***

##Disclaimer

**Disclaimer:**
This Add-on is not created by, affiliated with or sponsored by ZeniMax Media Inc. or its affiliates. The Elder Scrolls® and related logos are registered trademarks or trademarks of ZeniMax Media Inc. in the United States and/or other countries. All rights reserved.
