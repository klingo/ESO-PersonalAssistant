# PersonalAssistant
PersonalAssistant, an Addon for 'The Elder Scrolls Online'

***

## Download
http://www.esoui.com/downloads/info381-PersonalAssistant.html

***

## How to use
tbd


PersonalAssistant
PersonalAssistant.Banking
PersonalAssistant.Junk
PersonalAssistant.Loot
PersonalAssistant.Repair

***

## Development ToDo

#### General
* [ ] **(7)** Update Currency System
  * https://forums.elderscrollsonline.com/en/discussion/200789/imperial-city-api-patch-notes-change-log-live/p1
  * https://forums.elderscrollsonline.com/en/discussion/371967/update-16-api-patch-notes-change-log-pts#latest
* [ ] **(1)** Support ESO Plus Bags
  * BAG_VIRTUAL (Dark Brotherhood)
    * https://forums.elderscrollsonline.com/en/discussion/261946/dark-brotherhood-api-patch-notes-change-log-pts
  * BAG_SUBSCRIBER_BANK (Morrowind)
    * https://forums.elderscrollsonline.com/en/discussion/335644/update-14-api-patch-notes-change-log-pts
* [ ] **(8)** Check ItemLink Handling in HelperFunctions.lua
  * http://www.esoui.com/forums/showthread.php?t=2054
  * http://www.esoui.com/forums/showthread.php?t=1944
* [ ] **(3)** Check Singular/Plural formatting for HelperFunctions.lua
    * http://www.esoui.com/forums/showthread.php?p=7988
* [X] **(1)** Update to latest LAM version
* [X] **(1)** Make "PersonalAssistant" the top-level-Addon and move others as nested-Addons
  * https://wiki.esoui.com/Addon_Structure
* [ ] **(5)** Update Addon Manifest
  * https://wiki.esoui.com/Addon_manifest_(.txt)_format
  * AddOnVersion
  * Variable Expansion - $(language)
  
  
#### PABanking
* [ ] **(2)** PARepair: Add chat message when repairing with Repair Kits


#### PABanking
* [ ] **(1)** PABanking: Refactor regarding inventory-loop  
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
* [ ] **(1)** PABanking: Refactor regarding Item Movement  
    ```lua
    RequestMoveItem (number sourceBag, number sourceSlot, number destBag, number destSlot, number stackCount)
    ```
* [ ] **(3)** PABanking: Check new function for transferring currencies
    ```lua
    TransferCurrency(currencyType, amount, fromLocation, toLocation).
    ```
* [ ] **(4)** PABanking: Support Home Storage Banking Bags
    ```lua
    BAG_HOUSE_BANK_ONE through BAG_HOUSE_BANK_TEN
    GetBankingBag() – bankingBag.
    IsHouseBankBag(bag) – isHouseBankBag.
    GetCollectibleForHouseBankBag(houseBankBag) – collectibleId.
    GetCollectibleBankAccessBag(collectibleId) – houseBankBag.
    ```
* [ ] **(1)** PABanking: Crafting Material - Add buttons for Deposit/Withdraw/Ignore all
* [ ] **(1)** PABanking: Crafting Material - Add Jewelcrafting items
    ```lua
    ITEMTYPE_JEWELRYCRAFTING_BOOSTER
    ITEMTYPE_JEWELRYCRAFTING_MATERIAL
    ITEMTYPE_JEWELRYCRAFTING_RAW_BOOSTER
    ITEMTYPE_JEWELRYCRAFTING_RAW_MATERIAL
    ITEMTYPE_JEWELRY_RAW_TRAIT
    ITEMTYPE_JEWELRY_TRAIT
    ```
* [ ] **(1)** PABanking: Crafting Material - Add Furnishing items
    ```lua
    ITEMTYPE_FURNISHING
    ITEMTYPE_FURNISHING_MATERIAL 
    ```
* [ ] **(3)** PABanking: Common Item Types - Add Maps (utilizing SpeializedItemTypes)
* [ ] **(2)** PABanking: Advanced Item Types - Add Soul gems (empty / filled)
* [ ] **(3)** PABanking: Advanced Item Types - Add Repair Kits (only Grand?)
* [ ] **(2)** PABanking: Add option to select type of notifications
* [ ] **(4)** PABanking: Add summary after transaction completed


#### PALoot
* [ ] **(5)** PALoot: Loot other currencies than gold  - Still needed?!
    ```lua
    GetLootCurrency(number CurrencyType type)  
    Returns: number unownedCurrency, number ownedCurrency
  
    CURT_ALLIANCE_POINTS
    CURT_TELVAR_STONES
    ```
* [ ] **(8)** PALoot: Check global ESO settings for AutoLoot
    * http://cdn.esoui.com/forums/showthread.php?p=20437
        *  GetSettingBool(SETTING_TYPE_LOOT, LOOT_SETTING_AOE_LOOT)
        *  GetSettingBool(SETTING_TYPE_LOOT, LOOT_SETTING_AUTO_ADD_TO_CRAFT_BAG)
        *  GetSettingBool(SETTING_TYPE_LOOT, LOOT_SETTING_AUTO_LOOT)
        *  GetSettingBool(SETTING_TYPE_LOOT, LOOT_SETTING_AUTO_LOOT_STOLEN)
        *  GetSettingBool(SETTING_TYPE_LOOT, LOOT_SETTING_LOOT_HISTORY)
* [ ] **(1)** PALoot: Check if special message for Stealing is added?
* [ ] **(1)** PALoot: Harvestable Items - Add Jewelcrafting items


#### PAJunk
* [ ] **(3)** PAJunk: Add support for FCOItemSaver
  * http://www.esoui.com/downloads/info630-FCOItemSaver.html
  * www.esoui.com/forums/showthread.php?t=6987
* [ ] **(1)** PAJunk: Check if special message for marking as Trash/Ornate exists
* [ ] **(1)** PAJunk: Add option to select type of notifications
   
***

## Disclaimer

**Disclaimer:**
This Add-on is not created by, affiliated with or sponsored by ZeniMax Media Inc. or its affiliates. The Elder Scrolls® and related logos are registered trademarks or trademarks of ZeniMax Media Inc. in the United States and/or other countries. All rights reserved.
