function FromClient_SA_Widget_Respon_Time_ReSizePanel()
  PaGlobal_SA_Widget_Respon_Time._ui.stc_responBG:ComputePos()
  PaGlobal_SA_Widget_Respon_Time._ui.txt_info:ComputePos()
  PaGlobal_SA_Widget_Respon_Time._ui.txt_time:ComputePos()
end
function FromClient_SA_Widget_Respon_Time_BattleRoyaleStateChanged(state)
  if __eBattleRoyaleState_Playing ~= state or PaGlobal_SA_Widget_Respon_Time._curTime >= 300 then
    return
  end
  PaGlobal_SA_Widget_Respon_Time_StartGame()
end
function PaGlobal_SA_Widget_Respon_Time_UpdateRespawnTime(delta)
  PaGlobal_SA_Widget_Respon_Time._timer = PaGlobal_SA_Widget_Respon_Time._timer + delta
  if PaGlobal_SA_Widget_Respon_Time._timer < PaGlobal_SA_Widget_Respon_Time._lastUpdateTime + 1 then
    return
  end
  if 0 == PaGlobal_SA_Widget_Respon_Time._brStartTime then
    local brStartTime = ToClient_BattleRoyaleStartTime()
    if nil == brStartTime then
      return
    end
    PaGlobal_SA_Widget_Respon_Time._brStartTime = Int64toInt32(brStartTime)
  end
  PaGlobal_SA_Widget_Respon_Time._lastUpdateTime = math.floor(PaGlobal_SA_Widget_Respon_Time._timer)
  local brStartTime = PaGlobal_SA_Widget_Respon_Time._brStartTime
  local serverUtcTime = getServerUtc64()
  local elapsedTime = 0
  if nil ~= brStartTime and nil ~= serverUtcTime then
    elapsedTime = 0
    serverUtcTime = Int64toInt32(serverUtcTime)
    if brStartTime ~= 0 then
      elapsedTime = serverUtcTime - brStartTime
    else
      return
    end
  end
  if elapsedTime < 0 then
    return
  end
  PaGlobal_SA_Widget_Respon_Time._curTime = elapsedTime
  if PaGlobal_SA_Widget_Respon_Time._curTime > 300 then
    PaGlobal_SA_Widget_Respon_Time:prepareClose()
    return
  end
  elapsedTime = PaGlobal_SA_Widget_Respon_Time._respawnTime - elapsedTime
  local clockMinutes = math.floor(elapsedTime / 60)
  local clockSeconds = elapsedTime % 60
  local clockMinutesText = ""
  local clockSecondsText = ""
  if clockMinutes < 0 then
    clockMinutes = 0
  end
  if clockMinutes < 10 then
    clockMinutesText = clockMinutesText .. "0" .. tostring(clockMinutes)
  else
    clockMinutesText = clockMinutesText .. tostring(clockMinutes)
  end
  if clockSeconds < 0 then
    clockSeconds = 0
  end
  if clockSeconds < 10 then
    clockSecondsText = clockSecondsText .. "0" .. tostring(clockSeconds)
  else
    clockSecondsText = clockSecondsText .. tostring(clockSeconds)
  end
  PaGlobal_SA_Widget_Respon_Time._ui.txt_time:SetText(clockMinutesText .. " : " .. clockSecondsText)
end
function PaGlobal_SA_Widget_Respon_Time_StartGame()
  local curtime = PaGlobal_SA_Widget_Respon_Time._curTime
  if nil == curtime or 300 <= curtime then
    return
  end
  PaGlobal_SA_Widget_Respon_Time:prepareOpen()
  PaGlobal_SA_Widget_Respon_Time._respawnTime = 300
  Panel_SA_Widget_Respon_Time:RegisterUpdateFunc("PaGlobal_SA_Widget_Respon_Time_UpdateRespawnTime")
end
function PaGlobal_SA_Widget_Respon_Time_ShowAni()
  if nil == Panel_SA_Widget_Respon_Time then
    return
  end
end
function PaGlobal_SA_Widget_Respon_Time_HideAni()
  if nil == Panel_SA_Widget_Respon_Time then
    return
  end
end
