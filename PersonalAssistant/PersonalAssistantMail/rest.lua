local function LootMailsCont()
    DEBUG("LootMailsCont")

    local body = false


    if CORE.currentMail.includeMail then
        body = API_ReadMail(CORE.currentMail.id)
        AddPlayerMailToHistory(CORE.currentMail.id, body)

        -- DEBUG
        CORE.loot.debug[#CORE.loot.debug].body = body
    end

    if CORE.currentMail.mailType == MAILTYPE_SIMPLE_PRE then
        body = (not body) and API_ReadMail(CORE.currentMail.id) or body

        -- DEBUG
        CORE.loot.debug[#CORE.loot.debug].body = body

        if IsSimplePost(body) then

            CORE.currentMail.mailType = MAILTYPE_SIMPLE

            -- DEBUG
            CORE.loot.debug[#CORE.loot.debug].mailType = MAILTYPE_SIMPLE

            if (CORE.currentMail.att > 0) then
                -- Fall through to loot items...
            elseif CORE.currentMail.money > 0 then
                -- loot money
                DEBUG("money id=" .. API_Id64ToString(CORE.currentMail.id))
                -- CORE.loot.mailCount = CORE.loot.mailCount + 1
                MailCount(MAILTYPE_SIMPLE)
                CORE.state = STATE_MONEY
                API_TakeMailAttachedMoney(CORE.currentMail.id)
                return
            elseif IsDeleteSimpleAfter() then
                -- delete
                DEBUG("delete id=" .. API_Id64ToString(CORE.currentMail.id))
                -- CORE.loot.mailCount = CORE.loot.mailCount + 1
                MailCount(MAILTYPE_SIMPLE)
                CORE.state = STATE_DELETE

                -- In case any other Addon or code wants to handle
                -- this event.  Don't deleted it till after all
                -- interested handlers have a chance to run....
                DelayedDeleteCmd()
                return
            else
                DEBUG("simple mail - Do not delete")
                CORE.skippedMails[zo_getSafeId64Key(CORE.currentMail.id)] = true
                CORE.currentMail = {}
                CancelMailReadTimer()
                LootMails()
                return
            end

        else
            -- Skip this mail...
            DEBUG("not simple id=" .. API_Id64ToString(CORE.currentMail.id))
            CORE.skippedMails[zo_getSafeId64Key(CORE.currentMail.id)] = true
            CORE.currentMail = {}

            CORE.state = STATE_LOOT
            LootMailsAgain()
            return
        end
    end

    if CORE.currentMail.att > 0 then
        -- Check if there is room to loot...
        if not IsRoomToLoot(CORE.currentMail.id, CORE.currentMail.att) then

            -- Unstore this mail
            CORE.loot.mails[zo_getSafeId64Key(CORE.currentMail.id)] = nil

            -- Skip it as room is not changing this run.
            CORE.skippedMails[zo_getSafeId64Key(CORE.currentMail.id)] = true
            CORE.currentMail = {}

            -- See if anything else is lootable.
            CORE.state = STATE_LOOT
            LootMailsAgain()
            return
        end

        --
        -- Loot Item....
        --

        -- CORE.loot.mailCount = CORE.loot.mailCount + 1
        MailCount(CORE.currentMail.mailType)

        -- Reading the attached items works better after reading the mail.
        CORE.currentItems = {}

        -- DEBUG
        CORE.loot.debug[#CORE.loot.debug].items = {}

        for i = 1, CORE.currentMail.att do
            local icon, stack, creator = API_GetAttachedItemInfo(CORE.currentMail.id, i)
            local link = API_GetAttachedItemLink(CORE.currentMail.id, i, LINK_STYLE_DEFAULT)

            DEBUG("  item: " .. link .. " icon: " .. icon)

            local mailId = CORE.currentMail.includeMail and CORE.currentMail.id or nil

            if link and (link ~= "") then
                table.insert(CORE.currentItems,
                    {
                        icon = icon,
                        stack = stack,
                        link = link,
                        mailType = CORE.currentMail.mailType,
                        subType = CORE.currentMail.subType,
                        id = mailId,
                        sdn = CORE.currentMail.sdn,
                        scn = CORE.currentMail.scn,
                    })
            else
                DEBUG("ERROR - item has no link")
            end

            -- DEBUG
            table.insert(CORE.loot.debug[#CORE.loot.debug].items,
                { icon, stack, creator, link })
        end

        CORE.state = STATE_ITEMS

        -- BUG: Why does this sometimes fail??? (FIXED)
        -- Work around: load the mail to be read first.
        API_TakeMailAttachedItems(CORE.currentMail.id)

    elseif CORE.currentMail.money > 0 then
        --
        -- Loot Money - this includes COD RECEIPT cases.
        --

        DEBUG("money id=" .. API_Id64ToString(CORE.currentMail.id))
        -- CORE.loot.mailCount = CORE.loot.mailCount + 1
        MailCount(CORE.currentMail.mailType)
        CORE.state = STATE_MONEY
        API_TakeMailAttachedMoney(CORE.currentMail.id)

    else

        -- Don't delete player mail with no loot.
        -- Is that the only way to get here?

        -- Unstore this mail
        CORE.loot.mails[zo_getSafeId64Key(CORE.currentMail.id)] = nil

        -- skip it...
        CORE.skippedMails[zo_getSafeId64Key(CORE.currentMail.id)] = true
        CORE.currentMail = {}

        CORE.state = STATE_LOOT
        LootMailsAgain()
    end
end




function CORE.Scan()

    if not (mailLooterOpen and (CORE.state == STATE_IDLE)) then
        d("Scan function can not run right now")
        return
    end

    local id = API_GetNextMailId(nil)

    local t = {}

    while id ~= nil do

        local _, _, subject, icon, unread, fromSystem, fromCustomerService, returned,
        numAttachments, attachedMoney, codAmount, expiresInDays, secsSinceReceived = API_GetMailItemInfo(id)

        numAttachments = numAttachments or 0
        attachedMoney = attachedMoney or 0

        local mailType, subType = GetMailType(id, subject, fromSystem, codAmount, returned,
            numAttachments, attachedMoney)

        d("mail id=" .. API_Id64ToString(id))
        d("-> subject='" .. subject .. "'")
        d("-> system=" .. tostring(fromSystem))
        d("-> custService=" .. tostring(fromCustomerService))
        d("-> returned=" .. tostring(returned))
        d("-> numAtt=" .. numAttachments .. " money=" .. attachedMoney .. " cod=" .. codAmount)
        d("-> mailType=" .. mailType)


        local items

        if numAttachments > 0 then
            items = {}
            GetMailAttachmentInfo(id)

            for i = 1, numAttachments do
                local icon, stack, cn, sp, meets = API_GetAttachedItemInfo(id, i)
                local link = API_GetAttachedItemLink(id, i, LINK_STYLE_BRACKETS)
                table.insert(items, { stack = stack, link = link })
            end
        end

        table.insert(t,
            {
                id = API_Id64ToString(id),
                subject = subject,
                system = fromSystem,
                returned = returned,
                mailType = mailType,
                subType = subType,
                money = attachedMoney,
                cod = codAmount,
                items = items,
            })

        id = API_GetNextMailId(id)
    end

    return t
end