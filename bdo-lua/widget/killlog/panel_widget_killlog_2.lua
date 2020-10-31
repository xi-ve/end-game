function FromClient_Widget_KillLog_UpdatePerFrame(deltaTime)
  PaGlobal_Widget_KillLog:updateLogPerFrame(deltaTime)
end
function FromClient_Widget_KillLog_OnScreenResize()
  PaGlobal_Widget_KillLog:screenResize()
end
function PaGlobal_Widget_KillLog_AddLog(logType, attacker, attackee, guildName)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local name = selfPlayer:getName()
  local originalName = selfPlayer:getOriginalName()
  local nickName = selfPlayer:getUserNickname()
  if true == _ContentsGroup_NameTypeEqually then
    local nameType = ToClient_getChatNameType()
    if __eChatNameType_NickName == nameType then
      if attacker ~= nickName then
        return
      end
    elseif attacker ~= name and attacker ~= originalName then
      return
    end
  elseif attacker ~= name and attacker ~= originalName then
    return
  end
  PaGlobal_Widget_KillLog:addLogData(logType, attacker, attackee, guildName)
end
function testtest()
  local rand = math.random(0, 100000)
  PaGlobal_Widget_KillLog_AddLog(PaGlobal_Widget_KillLog._eLogType.guildWar, getSelfPlayer():getName(), "[GM] \235\157\188\235\139\136\234\179\160_" .. tostring(rand), "\234\179\160\235\139\136\236\157\152\236\135\188\237\140\140\236\156\132\236\151\144\236\157\152")
end
