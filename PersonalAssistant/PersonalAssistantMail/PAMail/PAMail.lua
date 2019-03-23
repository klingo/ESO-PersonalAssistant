-- Local instances of Global tables --
local PA = PersonalAssistant
local PAM = PA.Mail
local PAHF = PA.HelperFunctions
local PAEM = PA.EventManager

-- ---------------------------------------------------------------------------------------------------------------------

local hirelingMailSubjects = {}
table.insert(hirelingMailSubjects, GetString(SI_PA_MAIL_HIRELINGS_MAIL_SUBJECT_ENCHANTING))
table.insert(hirelingMailSubjects, GetString(SI_PA_MAIL_HIRELINGS_MAIL_SUBJECT_WOODWORKING))
table.insert(hirelingMailSubjects, GetString(SI_PA_MAIL_HIRELINGS_MAIL_SUBJECT_CLOTHING))
table.insert(hirelingMailSubjects, GetString(SI_PA_MAIL_HIRELINGS_MAIL_SUBJECT_BLACKSMITHING))
table.insert(hirelingMailSubjects, GetString(SI_PA_MAIL_HIRELINGS_MAIL_SUBJECT_PROVISIONING))

local function isMailSubjectFromHireling(mailSubject)
    return PAHF.isValueInTable(hirelingMailSubjects, mailSubject)
end

-- ---------------------------------------------------------------------------------------------------------------------

local function readHirelingMails()

    -- first thing to do is to unregister the "num unread changes" event to avoid re-triggering it
    PAEM.UnregisterForEvent(PAM.AddonName, EVENT_MAIL_NUM_UNREAD_CHANGED)

    PAHF.debugln("PA.Mail.readHirelingMails")
    d("PA.Mail.readHirelingMails")

    d(tostring(GetNumMailItems()))
    -- loop through all mails and get their details
    for i = 1, GetNumMailItems() do
        local mailId = GetNextMailId(mailId)
        d(tostring(mailId))

        -- get all details from mail
        local senderDisplayName, senderCharacterName, subject, icon, unread, fromSystem, fromCustomerService, returned, numAttachments, attachedMoney, codAmount, expiresInDays, secsSinceReceived = GetMailItemInfo(mailId)

--        if fromSystem and not fromCustomerService and unread and numAttachments > 0 and attachedMoney == 0 and isMailSubjectFromHireling(subject) then
        if fromSystem and not fromCustomerService and numAttachments > 0 and attachedMoney == 0 and isMailSubjectFromHireling(subject) then
            -- if yes, request to read the mail (i.e. get "access" to the attached items)
            d("read: "..tostring(mailId))
            RequestReadMail(mailId)
        end
    end

    -- afterwards, re-register the event
    PAEM.RegisterForEvent(PAM.AddonName, EVENT_MAIL_NUM_UNREAD_CHANGED, PAM.readHirelingMails)

end


local function takeAttachedItemsFromSingleMail(eventCode, mailId)
    local PAMailSavedVars = PAM.SavedVars

    PAHF.debugln("PA.Mail.takeAttachedItemsFromSingleMail")
    d("PA.Mail.takeAttachedItemsFromSingleMail")

    -- check if mailChecking is already blocked
    if PAM.isMailAlreadyChecking then return end
    PAM.isMailAlreadyChecking = true

    -- get all details from mail
    local senderDisplayName, senderCharacterName, subject, icon, unread, fromSystem, fromCustomerService, returned, numAttachments, attachedMoney, codAmount, expiresInDays, secsSinceReceived = GetMailItemInfo(mailId)

    --        if fromSystem and not fromCustomerService and unread and numAttachments > 0 and attachedMoney == 0 and isMailSubjectFromHireling(subject) then
    if fromSystem and not fromCustomerService and numAttachments > 0 and attachedMoney == 0 and isMailSubjectFromHireling(subject) then
        for attachIndex = 1, numAttachments do
            -- loot the items
            TakeMailAttachedItems(mailId)
            -- and inform player
            -- TODO: move this to [takeAttachedItemSuccess], or at least check there if it worked
            local mailItemLink = GetAttachedItemLink(mailId, attachIndex, LINK_STYLE_BRACKETS)
            -- TODO: add proper notifiction
            d(string.format("Received from Hireling Mail: %s", mailItemLink))
        end

        if PAMailSavedVars.hirelingDeleteEmptyMails then
            local numAttachmentsNow = GetMailAttachmentInfo(mailId)
            if numAttachmentsNow == 0 then
                -- TODO: check if [forceDelete] has to be change to 'true'
                zo_callLater(function() DeleteMail(mailId, false) end, 500)
            end
        end
    end

    -- unblock mail checking
    PAM.isMailAlreadyChecking = false
end


local function takeAttachedItemSuccess(eventCode, mailId)
    d("takeAttachedItemSuccess")
end


-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Mail = PA.Mail or {}
PA.Mail.takeAttachedItemsFromSingleMail = takeAttachedItemsFromSingleMail
PA.Mail.readHirelingMails = readHirelingMails
PA.Mail.takeAttachedItemSuccess = takeAttachedItemSuccess