function Update_GuildJoinRequestSet_FrameEvent(deltatime)
  local self = PaGlobal_GuildJoinRequestSet
  self._ui._txt_time:SetText(tostring(""))
  local remainTime = ToClient_getRefreshGuildPRTime()
  if remainTime < 0 then
    return
  end
  local remainTimeText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_GUILDUPDATETIME", "time", convertStringFromDatetime(toInt64(0, remainTime)))
  self._ui._txt_time:SetText(remainTimeText)
end
function FromClient_updateGuildPRInfo(type)
  local self = PaGlobal_GuildJoinRequestSet
  if __eGuildPRType_Insert == type then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_GUILDCOMPLETE"))
  elseif __eGuildPRType_Update == type then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_GUILD_REFRESHGUILDLIST"))
  elseif __eGuildPRType_Delete == type then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_GUILDDELETECOMPLETE"))
  end
  self:updateText()
  PaGlobal_GuildJoinRequestSet:resizeByLeftTime()
end
