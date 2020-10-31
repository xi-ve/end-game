function PaGlobal_SA_Widget_KillLog:initialize()
  if true == PaGlobal_SA_Widget_KillLog._initialize then
    return
  end
  self._ui.stc_killLogBG = UI.getChildControl(Panel_SA_KillLog, "Static_KillLogBG")
  self._ui.stc_killLogBG:SetShow(false)
  self:registEventHandler()
  self:validate()
  PaGlobal_SA_Widget_KillLog_Open()
  self:createKillLogControl()
  self._initialize = true
end
function PaGlobal_SA_Widget_KillLog:registEventHandler()
  if nil == Panel_SA_KillLog then
    return
  end
  registerEvent("onScreenResize", "FromClient_SA_Widget_Ingeraction_ReSizePanel")
  registerEvent("FromClient_BattleRoyaleKillLog", "FromClient_SA_Widget_KillLog_BattleRoyaleKillLog")
  Panel_SA_KillLog:RegisterUpdateFunc("PaGlobal_SA_Widget_KillLog_Update")
end
function PaGlobal_SA_Widget_KillLog:prepareOpen()
  if nil == Panel_SA_KillLog then
    return
  end
  PaGlobal_SA_Widget_KillLog:open()
end
function PaGlobal_SA_Widget_KillLog:open()
  if nil == Panel_SA_KillLog then
    return
  end
  Panel_SA_KillLog:SetShow(true)
end
function PaGlobal_SA_Widget_KillLog:prepareClose()
  if nil == Panel_SA_KillLog then
    return
  end
  PaGlobal_SA_Widget_KillLog:close()
end
function PaGlobal_SA_Widget_KillLog:close()
  if nil == Panel_SA_KillLog then
    return
  end
  Panel_SA_KillLog:SetShow(false)
end
function PaGlobal_SA_Widget_KillLog:update()
  if nil == Panel_SA_KillLog then
    return
  end
end
function PaGlobal_SA_Widget_KillLog:validate()
  if nil == Panel_SA_KillLog then
    return
  end
  self._ui.stc_killLogBG:isValidate()
end
function PaGlobal_SA_Widget_KillLog:createKillLogControl()
  for index = 0, self._maxKillLogCnt do
    local killLog = {
      stc_killLogBG = nil,
      stc_winnerIcon = nil,
      txt_verse = nil,
      stc_loserIcon = nil,
      txt_kill = nil,
      txt_killLog = nil,
      _isShow = false,
      _deltaTime = 0,
      _index = 0,
      _second = 0,
      _isAnimation = false,
      _startPos = float2(0, 0),
      _offsetSizeY = 0,
      _animTime = 0
    }
    killLog.stc_killLogBG = UI.cloneControl(self._ui.stc_killLogBG, Panel_SA_KillLog, "Static_KillLogBG" .. index)
    killLog.stc_winnerIcon = UI.getChildControl(killLog.stc_killLogBG, "Static_ClassIcon_Winner")
    killLog.txt_verse = UI.getChildControl(killLog.stc_killLogBG, "StaticText_ClassIcon_VS")
    killLog.stc_loserIcon = UI.getChildControl(killLog.stc_killLogBG, "Static_ClassIcon_Loser")
    killLog.txt_kill = UI.getChildControl(killLog.stc_killLogBG, "StaticText_KillLog")
    killLog.txt_killLog = UI.getChildControl(killLog.stc_killLogBG, "StaticText_Log")
    killLog._startPos.y = Panel_SA_KillLog:GetPosY()
    killLog._offsetSizeY = killLog.stc_killLogBG:GetSizeY() + 3
    self._killLog[index] = killLog
  end
end
function PaGlobal_SA_Widget_KillLog:updateTime(deltaTime)
  for idx = 0, self._maxKillLogCnt do
    if nil ~= self._killLog[idx] and false ~= self._killLog[idx]._isShow then
      self._killLog[idx]._deltaTime = self._killLog[idx]._deltaTime + deltaTime
      if self._maxViewTime < self._killLog[idx]._deltaTime then
        self._killLog[idx]._isShow = false
        self._killLog[idx]._deltaTime = 0
        self:reposition(idx)
      end
    end
  end
end
function PaGlobal_SA_Widget_KillLog:reposition(idx)
  if true == self._killLog[idx]._isShow then
    local posY = self._killLog[idx]._startPos.y + self._killLog[idx]._offsetSizeY * self._killLog[idx]._index
    self._killLog[idx].stc_killLogBG:SetPosY(posY)
  end
  self._killLog[idx].stc_killLogBG:SetShow(self._killLog[idx]._isShow)
  self:addStartAnimation(idx)
end
function PaGlobal_SA_Widget_KillLog:updateAddLog(deltaTime)
  if true == self._isAniCooltime then
    self._aniDeltaTime = self._aniDeltaTime + deltaTime
    if self._anitime < self._aniDeltaTime then
      self._isAniCooltime = false
      self._aniDeltaTime = 0
    end
    return
  end
  if 0 < self._dataList:length() then
    local data = self._dataList:pop_front()
    self:addLog(data)
    self._isAniCooltime = true
  end
end
function PaGlobal_SA_Widget_KillLog:addLog(data)
  if nil == data then
    return
  end
  self:addAllIndexing()
  local index = self:findWaitingLogIndex()
  self:addLogData(index, data)
  for idx = 0, self._maxKillLogCnt do
    self:reposition(idx)
  end
end
function PaGlobal_SA_Widget_KillLog:findWaitingLogIndex()
  for idx = 0, self._maxKillLogCnt do
    if false == self._killLog[idx]._isShow then
      return idx
    end
  end
  return 0
end
function PaGlobal_SA_Widget_KillLog:addAllIndexing()
  for idx = 0, self._maxKillLogCnt do
    if true == self._killLog[idx]._isShow then
      self._killLog[idx]._index = self._killLog[idx]._index + 1
      if self._maxKillLogCnt <= self._killLog[idx]._index then
        self._killLog[idx]._isShow = false
      end
    end
  end
end
function PaGlobal_SA_Widget_KillLog:addLogData(idx, data)
  if nil == idx or nil == data then
    return
  end
  local stringHead = ""
  if data.winnerName == data.loserName and data.winnerClassType == CppEnums.ClassType.ClassType_Temp1 then
    local attackerString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_ATTACKERSTRING2", "name", data.winnerName)
    self._killLog[idx].txt_kill:SetText("")
    self._killLog[idx].txt_killLog:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_KILLLOG_SUICIDE2", "name", attackerString))
  elseif 0 ~= data.winnerKey then
    local staticStatusWrapper = ToClient_GetCharacterStaticStatusWrapper(data.winnerKey)
    if nil == staticStatusWrapper then
      return
    end
    local winnerName = staticStatusWrapper:getName()
    local attackerString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_ATTACKERSTRING2", "name", winnerName)
    local attackeeString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_ATTACKERSTRING2", "name", data.loserName)
    self._killLog[idx].txt_kill:SetText("")
    self._killLog[idx].txt_killLog:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_KILLLOG_3", "attacker", attackerString, "attackee", attackeeString))
  else
    local attackerString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_ATTACKERSTRING2", "name", data.winnerName)
    local attackeeString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_ATTACKERSTRING2", "name", data.loserName)
    self._killLog[idx].txt_kill:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_KILLCOUNT2", "count", data.attacker_killCount))
    self._killLog[idx].txt_killLog:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_KILLLOG_3", "attacker", attackerString, "attackee", attackeeString))
  end
  self._killLog[idx]._isShow = true
  self._killLog[idx].stc_killLogBG:SetShow(true)
  self._killLog[idx]._deltaTime = 0
  self._killLog[idx]._index = 0
  self._killLog[idx]._isAnimation = false
end
function PaGlobal_SA_Widget_KillLog:addStartAnimation(idx)
  if nil == self._killLog[idx] or false == self._killLog[idx]._isShow or true == self._killLog[idx]._isAnimation then
    return
  end
  local panel = Panel_SA_KillLog
  local moveAni = panel:addMoveAnimation(0, 0.2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  local control = self._killLog[idx].stc_killLogBG
  local posX = control:GetPosX()
  moveAni:SetStartPosition(posX - 50, 0)
  moveAni:SetEndPosition(posX, 0)
  self._killLog[idx]._isAnimation = true
end
