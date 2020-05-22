# PersonalAssistant
PersonalAssistant, an Add-on for '[The Elder Scrolls Online](https://www.elderscrollsonline.com/ "Home - The Elder Scrolls Online")'

***

## Download
You can always download the latest version here: http://www.esoui.com/downloads/info381-PersonalAssistant.html

***

## Roadmap

At the current time I do not have much time fo ESO, respectively my priorities lie elsewhere. Nonetheless, every now and then I find some time again to work on this addon.

On a higher level, this is the rough roadmap for PersonalAssistant:

| Release | Focus | Content                                                                                                     |
|---------|------------|-------------------------------------------------------------------------------------------------------------|
| 2.5.x   | PAGeneral  | - Refactoring profile management                                                                              |
| 2.6.x   | PABanking  | - Advanced transfer rules<br>- Additional FCOIS support<br>- Manual transfer button                               |
| 2.7.x   | PALoot     | - Track known recipes, traits and motifs across all characters<br>- Notify about group loots<br>- Auto-Laundering |
| 2.8.x   | PAWorker   | - Auto-Deconstruct Items                                                                                      |                                                                       |
 (subject to change)

***

## Addon Integration (callbacks)

PersonalAssistant has its own CallbackManager where you can register your own functions to be executed based on certain PA specific events.
You can un-/register your own callback function as follows:

```lua
-- define your own callback function with an optional parameter
local function myBankingCompleteFunction(myParam)
    df("PA Banking has been complete, this was my param: %s", tostring(myParam))
end

-- check if PersonalAssistant is running, then register the callback function
if _G["PersonalAssistant"] then
    local PACM = PA.CallbackManager
    PACM.RegisterExternalCallback(PACM.PA_BANKING_COMPLETE, myBankingCompleteFunction, "it works!")

    -- to unregister the callback function again
    PACM.UnregisterExternalCallback(PACM.PA_BANKING_COMPLETE, myBankingCompleteFunction)
end
```

The above would print out the followin in chat, once PABanking is done:

```PA Banking has been complete, this was my param: it works!```

At the moment, the following event(s) are supported:

| PA-EVENT | Description |
|---------------------|-----------|
| PA_BANKING_COMPLETE | Triggered when PABanking has completed all it's transactions at the Bank  |


**Important:** Make sure that you define PersonalAssistant as **OptionalDependsOn** in your addon manifest to ensure that it is loaded before your addon - otherwise the callback registration might not work.


## How to use
PersonalAssistant is an Add-on for '[The Elder Scrolls Online](https://www.elderscrollsonline.com/ "Home - The Elder Scrolls Online")' and consists of multiple nested Add-ons that can independently be turned on or off. The following section will explain in more detail how to use the different parts. 

#### PersonalAssistant
![alt text][pag-menu]

tbd

#### PersonalAssistant Banking
![alt text][pab-menu]

tbd

#### PersonalAssistant Integration
![alt text][pai-menu]

tbd

#### PersonalAssistant Junk
![alt text][paj-menu]

tbd

#### PersonalAssistant Loot
![alt text][pal-menu]

![alt text][pal-inventory]

tbd

#### PersonalAssistant Repair
![alt text][par-menu]

tbd




***

## Disclaimer

**Disclaimer:**
This Add-on is not created by, affiliated with or sponsored by ZeniMax Media Inc. or its affiliates. The Elder Scrolls® and related logos are registered trademarks or trademarks of ZeniMax Media Inc. in the United States and/or other countries. All rights reserved.


[pag-menu]: ./info/images/PAG.png "PersonalAssistant General Menu"
[pab-menu]: ./info/images/PAB.png "PersonalAssistant Banking Menu"
[pai-menu]: ./info/images/PAI.png "PersonalAssistant Integration Menu"
[paj-menu]: ./info/images/PAJ.png "PersonalAssistant Junk Menu"
[pal-menu]: ./info/images/PAL.png "PersonalAssistant Loot Menu"
[pal-inventory]: ./info/images/PAL_Inventory.png "PersonalAssistant Loot Inventory View"
[par-menu]: ./info/images/PAR.png "PersonalAssistant Repair Menu"