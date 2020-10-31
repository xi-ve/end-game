local Mail = {}
Mail.getMail = function(index)
	local code = [[
  local mail_Info = RequestMail_getMailAt(]] .. index .. [[ - 1)
  local sender_Name = mail_Info:getSender()
  local mail_Title = mail_Info:getTitle()
  local mail_No = mail_Info:getMailNo()
  local mail_isExistItem = mail_Info:isExistItem()
  local mail_getMailReceiveDate = mail_Info:getMailReceiveDate()
  return sender_Name, mail_Title, tostring(mail_No), mail_isExistItem, mail_getMailReceiveDate
  ]]
	local senderName, mailTitle, mailNo, mailHasItem, mailReceiveDate = Infinity.BDO.Lua.Execute(code)

	return {
		index = index,
		senderName = senderName,
		mailTitle = mailTitle,
		mailNo = mailNo,
		hasItem = mailHasItem,
		mailReceiveDate = mailReceiveDate
	}
end

Mail.getMailAmount = function()
	return Infinity.BDO.Lua.Execute("return RequestMail_mailCount()")
end
Mail.getAllMails = function()
	local mailCount = Mail.getMailAmount()
	local mails = {}
	for index = 1, mailCount do
		table.insert(mails, Mail.getMail(index))
	end
	return mails
end

Mail.deleteMail = function(mail)
	print("Delete mail")
	local mailAmount = MagLib.BDO.Mail.getMailAmount()
	Infinity.BDO.Lua.Execute("RequestMail_removeMail(" .. mail.mailNo .. ", false)")
end

Mail.isMailOpen = function()
	return Infinity.BDO.Lua.Execute("return Panel_Mail_Detail:GetShow()")
end

Mail.openMail = function(mail)
	print("Opening Mail")
	Infinity.BDO.Lua.Execute("Mail_Detail_Open(" .. mail.mailNo .. ")")
end

Mail.closeMail = function()
	print("Close Mail")
	Infinity.BDO.Lua.Execute("Mail_Detail_Close()")
end

Mail.getOpenMailItems = function(toWarehouse)
	print("Getting Mail Items")
	if toWarehouse == nil then
		toWarehouse = false
	end
	local code = [[
    local giftCount_s64 = RequestMail_getMailItemCount()
    local itemWhereType = CppEnums.ItemWhereType.eInventory
    if ]] .. tostring(toWarehouse) .. [[ then
    itemWhereType = CppEnums.ItemWhereType.eWarehouse
  end
  RequestMail_receiveMailItem(giftCount_s64, itemWhereType)
  ]]

	Infinity.BDO.Lua.Execute(code)
end

MagLib.BDO.Mail = Mail
