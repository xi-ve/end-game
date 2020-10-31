function PaGlobal_Arena_Battle:initialize()
  if true == self._initialize then
    return
  end
  local scoreBG = UI.getChildControl(Panel_Arena_Battle, "Static_ScoreBG")
  local progressBG_Left = UI.getChildControl(scoreBG, "Static_ProgressBG_Left")
  self._ui.progress_winnerHp = UI.getChildControl(progressBG_Left, "Progress2_1")
  self._ui.txt_win = UI.getChildControl(scoreBG, "StaticText_Win_LEFT")
  local progressBG_Right = UI.getChildControl(scoreBG, "Static_ProgressBG_Right")
  self._ui.progress_challengerHp = UI.getChildControl(progressBG_Right, "Progress2_1")
  self._ui.txt_winnerName = UI.getChildControl(Panel_Arena_Battle, "StaticText_LeftPlayer")
  self._ui.txt_challengerName = UI.getChildControl(Panel_Arena_Battle, "StaticText_RightPlayer")
  self._ui.txt_curPvPMaxTime = UI.getChildControl(Panel_Arena_Battle, "StaticText_Time")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Arena_Battle:registEventHandler()
  if nil == Panel_Arena_Battle then
    return
  end
  registerEvent("onScreenResize", "FromClient_Arena_Battle_ReSizePanel()")
  registerEvent("FromClient_NotifyBattleGroundPvPInfo", "FromClient_Arena_Battle_ChangeUserInfo()")
  registerEvent("FromClient_NotifyBattleGroundResult", "FromClient_Arena_Battle_NotifyBattleGroundResult")
  registerEvent("FromClient_NotifyBattleGroundPvPOrder", "FromClient_NotifyBattleGroundPvPOrder")
  registerEvent("FromClient_RenderModeChangeState", "FromClient_Arena_BattleRenderModeChangeState")
  registerEvent("FromClient_NotifyEnterBattleGround", "FromClient_NotifyEnterBattleGround")
end
function PaGlobal_Arena_Battle:prepareOpen()
  if nil == Panel_Arena_Battle then
    return
  end
  self:settingUserInfo()
  ToClient_requestBattleGroundPvPInfo()
  ToClient_requestBattleGroundPvPWaitionList()
  Panel_Arena_Battle:RegisterUpdateFunc("PaGlobal_Arena_Battle_UpdatePvPTime")
  PaGlobal_Arena_Waiting_Open()
  PaGlobal_Arena_Battle:open()
end
function PaGlobal_Arena_Battle:open()
  if nil == Panel_Arena_Battle then
    return
  end
  Panel_Arena_Battle:SetShow(true)
end
function PaGlobal_Arena_Battle:prepareClose()
  if nil == Panel_Arena_Battle then
    return
  end
  Panel_Arena_Battle:ClearUpdateLuaFunc()
  PaGlobal_Arena_Battle:close()
end
function PaGlobal_Arena_Battle:close()
  if nil == Panel_Arena_Battle then
    return
  end
  Panel_Arena_Battle:SetShow(false)
end
function PaGlobal_Arena_Battle:updatePvPTime(deleta)
  if nil == Panel_Arena_Battle then
    return
  end
  if false == ToClient_isPlayingBattleGroundPvP() then
    self._ui.txt_curPvPMaxTime:SetText("03:00")
    return
  end
  self._curPvPMaxTime = self._curPvPMaxTime - deleta
  if self._curPvPMaxTime < 0 then
    self._ui.txt_curPvPMaxTime:SetText("03:00")
  end
  local clockMinutes = math.floor(self._curPvPMaxTime / 60)
  local clockSeconds = math.floor(self._curPvPMaxTime % 60)
  local clockMinutesText = ""
  local clockSecondsText = ""
  if clockMinutes < 0 then
    clockMinutes = 0
  end
  if clockMinutes < 10 then
    clockMinutesText = "0" .. tostring(clockMinutes)
  else
    clockMinutesText = tostring(clockMinutes)
  end
  if clockSeconds < 0 then
    clockSeconds = 0
  end
  if clockSeconds < 10 then
    clockSecondsText = "0" .. tostring(clockSeconds)
  else
    clockSecondsText = tostring(clockSeconds)
  end
  local timeString = tostring(clockMinutesText) .. ":" .. tostring(clockSecondsText)
  self._ui.txt_curPvPMaxTime:SetText(timeString)
end
function PaGlobal_Arena_Battle:settingUserInfo()
  self._ui.progress_winnerHp:SetProgressRate(ToClient_getChampionPlayerHpRate())
  self._ui.txt_winnerName:SetText(ToClient_getChampionPlayerName())
  self._ui.progress_challengerHp:SetProgressRate(ToClient_getChallengerPlayerHpRate())
  self._ui.txt_challengerName:SetText(ToClient_getChallengerPlayerName())
  self._curPvPMaxTime = Int64toInt32(ToClient_getPvPMaxPlayTime()) / 1000
  local winCnt = ToClient_BattleGroundPvPWinCount()
  if 0 == winCnt then
    self._ui.txt_win:SetShow(false)
    return
  end
  self._ui.txt_win:SetShow(true)
  local winText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BATTLEGROUNPVPWIN_CNT", "count", winCnt)
  self._ui.txt_win:SetText(winText)
end
function PaGlobal_Arena_Battle:validate()
  if nil == Panel_Arena_Battle then
    return
  end
  self._ui.progress_winnerHp:isValidate()
  self._ui.progress_challengerHp:isValidate()
  self._ui.txt_winnerName:isValidate()
  self._ui.txt_challengerName:isValidate()
  self._ui.txt_curPvPMaxTime:isValidate()
  self._ui.txt_win:isValidate()
end
