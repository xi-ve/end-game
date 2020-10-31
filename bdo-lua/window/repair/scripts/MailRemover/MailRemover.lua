MailRemover = { }
MailRemover.Running = false

function MailRemover.Start()
  MailRemover.Running = true
	    
end

function MailRemover.Stop()
  MailRemover.Running = false  
end

function MailRemover.OnPulse()
  if MailRemover.Running == false then
    return
  end
end

function MailRemover.OnRenderD2D()
end

function MailRemover.OnGuiDraw()
	MainWindow.DrawMainWindow()
end

function MailRemover.cleanMails()
	local mailCount = Infinity.BDO.Lua.Execute("return RequestMail_mailCount()")

	if mailCount == nil or mailCount <= 0 then
		return
	end

	local code =
	[[
		local mailCount = RequestMail_mailCount()
		local lastMailIndex = mailCount

		for index = 1, mailCount do
       
    		local mail_Info = RequestMail_getMailAt(index - 1)
    		local sender_Name = mail_Info:getSender()
    		local mail_Title = mail_Info:getTitle()
    		local mail_No = mail_Info:getMailNo()
    		local mail_isExistItem = mail_Info:isExistItem()
    		local mail_getMailReceiveDate = mail_Info:getMailReceiveDate()

    		if not mail_isExistItem then
    			RequestMail_removeMail(mail_No, index == lastMailIndex)
    		end
  		end
	]]

	Infinity.BDO.Lua.Execute(code)
end