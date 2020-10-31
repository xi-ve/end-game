function FromClient_VoiceChat_UpdateSpeakerStatus(userId, isShow)
  if nil == Panel_Widget_Voice then
    return
  end
  PaGlobal_VoiceChat:updateSpearkStatus(userId, isShow)
end
function FromClient_VoiceChat_UpdateVoiceChatState()
  if nil == Panel_Widget_Voice then
    return
  end
  local guildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == guildInfo then
    Panel_Widget_Voice:SetShow(false)
    return
  end
  local myUserNo = getSelfPlayer():get():getUserNo()
  local memberCount = guildInfo:getMemberCount()
  for memberIdx = 0, memberCount - 1 do
    local memberInfo = guildInfo:getMember(memberIdx)
    if nil ~= memberInfo and myUserNo == memberInfo:getUserNo() then
      if memberInfo:isVoiceChatListen() then
        PaGlobal_VoiceChat:prepareOpen()
        break
      end
      PaGlobal_VoiceChat:prepareClose()
      break
    end
  end
end
function FromClient_VoiceChat_Open()
  if nil == Panel_Widget_Voice then
    return
  end
  PaGlobal_VoiceChat:prepareOpen()
end
function FromClient_VoiceChat_Close()
  if nil == Panel_Widget_Voice then
    return
  end
  PaGlobal_VoiceChat:prepareClose()
end
