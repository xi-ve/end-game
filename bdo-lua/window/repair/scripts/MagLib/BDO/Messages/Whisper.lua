MagLib.BDO.Messages.Whisper = {}

MagLib.BDO.Messages.Whisper.sendWhisper = function(whisperCharacterName, msg)
	print("Sending \"" .. msg .. "\" to " .. whisperCharacterName)
	Infinity.BDO.Lua.Execute("chatting_sendMessage(\"" .. whisperCharacterName .. "\", \"" .. msg ..
                         		"\", CppEnums.ChatType.Private)")
end
------------------

local gotNewPrivateMessage = function(author, message)
	MagLib.Events.triggerEvent("Messages_ReceiveWhisper", {author = author, message = message})
end

local receivedNewPrivateMessage = function()
	local code = [[
      local count = ToClient_getChattingPanelCount()
      FromClient_ChatUpdate(true)
      for panelIndex = 0, count - 1 do
        local chatPanel = ToClient_getChattingPanel(panelIndex)
        local lastMessage = chatPanel:beginMessage(0)
        if lastMessage and lastMessage.chatType and lastMessage.chatType == CppEnums.ChatType.Private then
          return lastMessage:getSender(ToClient_getChatNameType()), lastMessage:getContent()
        end
      end
    ]]
	local author, message = Infinity.BDO.Lua.Execute(code)

	if author and message then
		gotNewPrivateMessage(author, message)
	else
		print(
			"ERROR: Failed to get PM Message. Ensure that at least one of your chat tabs (preferable the first one) has \"Whisper\" enabled!")
	end

end

MagLib.Events.addInGameEventHandler("FromClient_PrivateChatMessageUpdate", receivedNewPrivateMessage)
