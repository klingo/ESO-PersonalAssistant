-- Local instances of Global tables --
local PA = PersonalAssistant
local PAM = PA.Mail
local PASV = PA.SavedVars
local PAHF = PA.HelperFunctions
local PAEM = PA.EventManager
local L = PA.Localization

-- ---------------------------------------------------------------------------------------------------------------------

local hirelingMailSubjects = {}
table.insert(hirelingMailSubjects, L.PAM_HirelingMailSubject_Enchanting)
table.insert(hirelingMailSubjects, L.PAM_HirelingMailSubject_Woodworking)
table.insert(hirelingMailSubjects, L.PAM_HirelingMailSubject_Clothing)
table.insert(hirelingMailSubjects, L.PAM_HirelingMailSubject_Blacksmithing)

local function isMailSubjectFromHireling(mailSubject)
    return PAHF.isValueInTable(hirelingMailSubjects, mailSubject)
end

-- ---------------------------------------------------------------------------------------------------------------------

local function checkMail()

    PAHF.debugln("PA.Mail.checkMail")

    -- check if mailChecking is already blocked
    if PAM.isMailAlreadyChecking then return end
    PAM.isMailAlreadyChecking = true

    local mailId

    -- loop through all mails and get their details
    for i = 1, GetNumMailItems() do
        mailId = GetNextMailId(mailId)

        -- get all details from mail
        local senderDisplayName, senderCharacterName, subject, icon, unread, fromSystem, fromCustomerService, returned, numAttachments, attachedMoney, codAmount, expiresInDays, secsSinceReceived = GetMailItemInfo(mailId)

        -- check if mail is from System, is unread, and if the Subject matches the known hireling mails
        if (fromSystem and unread and isMailSubjectFromHireling(subject)) then
            -- if yes, request to read the mail (i.e. get "access" to the attached items)
            RequestReadMail(mailId)
            for attachIndex = 1, numAttachments do
                -- loot the items
                TakeMailAttachedItems(mailId)
                -- and inform player
                local mailItemLink = GetAttachedItemLink(mailId, attachIndex, LINK_STYLE_BRACKETS)
                -- TODO: add proper notifiction
                d(string.format("Received from Hireling Mail: %s", mailItemLink))

                -- TODO: check if mail should be deleted (and do so)
                -- DeleteMail(id64 mailId, boolean forceDelete)
            end
        end
    end

    -- unblock mail checking
    PAM.isMailAlreadyChecking = false
end


-- does the same like [checkMail], except it also urnegisters the player-activated event
local function checkMailInitial()
    PAEM.UnregisterForEvent(PAM.AddonName, EVENT_PLAYER_ACTIVATED)
    d("checkMailInitial")
    checkMail()
end


-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Mail = PA.Mail or {}
PA.Mail.checkMailInitial = checkMailInitial
PA.Mail.checkMail = checkMail