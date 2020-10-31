function PaGlobal_Widget_KillLog:initialize()
  if true == PaGlobal_Widget_KillLog._initialize then
    return
  end
  self._ui._stc_logBg = UI.getChildControl(Panel_Widget_KillLog, "Static_LogBg")
  self._ui._txt_log = UI.getChildControl(self._ui._stc_logBg, "StaticText_Log")
  self._ui._stc_logBg:SetShow(false)
  self._logPool._startPosition = float2(self._ui._stc_logBg:GetPosX(), self._ui._stc_logBg:GetPosY())
  self._logPool._offsetSizeY = self._ui._stc_logBg:GetSizeY() * 0.5 + 3
  self:initLogPool()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Widget_KillLog:registEventHandler()
  if nil == Panel_Widget_KillLog then
    return
  end
  registerEvent("onScreenResize", "FromClient_Widget_KillLog_OnScreenResize")
  registerEvent("FromClient_ApplyUISettingPanelInfo", "FromClient_Widget_KillLog_OnScreenResize")
end
function PaGlobal_Widget_KillLog:validate()
  if nil == Panel_Widget_KillLog then
    return
  end
  self._ui._stc_logBg:isValidate()
  self._ui._txt_log:isValidate()
end
function PaGlobal_Widget_KillLog:initLogPool()
  for i = 0, self._MAX_ROW - 1 do
    local log = {
      _stc_logBg = nil,
      _txt_log = nil,
      _isShow = false,
      _index = 0,
      _viewTime = 0,
      _animTime = 0,
      _isEnd = false
    }
    self._logPool._log[i] = log
    self._logPool._log[i]._stc_logBg = UI.cloneControl(self._ui._stc_logBg, Panel_Widget_KillLog, "Static_Log" .. i)
    self._logPool._log[i]._txt_log = UI.getChildControl(self._logPool._log[i]._stc_logBg, "StaticText_Log")
    self._logPool._log[i]._stc_logBg:SetShow(false)
  end
end
function PaGlobal_Widget_KillLog:addLogData(eLogType, attacker, attackee, guildName)
  local logData = {
    _attacker = attacker,
    _attackee = attackee,
    _guildName = guildName,
    _eLogType = eLogType
  }
  if true == Panel_Widget_KillLog:GetShow() then
    self._logDataList:push_back(logData)
  end
  Panel_Widget_KillLog:RegisterUpdateFunc("FromClient_Widget_KillLog_UpdatePerFrame")
end
function PaGlobal_Widget_KillLog:updateLogPerFrame(deltaTime)
  if false == self._isAnimating and 0 < self._logDataList:length() then
    local poolIndex = self:findLogPoolIndex()
    self:setShowLog(false, poolIndex)
    if -1 ~= poolIndex then
      local logData = self._logDataList:pop_front()
      self:addAllIndexing()
      self:addLog(logData, poolIndex)
      self:reposition()
    end
  end
  self:updateLogCheck(deltaTime)
  self:updateEndAnimationCheck(deltaTime)
  if true == self:isEndLog() then
    Panel_Widget_KillLog:ClearUpdateLuaFunc()
    return
  end
end
function PaGlobal_Widget_KillLog:addLog(logData, poolIndex)
  self._logPool._log[poolIndex]._txt_log:SetText(logData._attackee)
  self._logPool._log[poolIndex]._index = 0
  self._logPool._log[poolIndex]._viewTime = 0
  self._logPool._log[poolIndex]._animTime = 0
  self._logPool._log[poolIndex]._isEnd = false
  self:setShowLog(true, poolIndex)
  self:addStartAnimation(poolIndex)
end
function PaGlobal_Widget_KillLog:findLogPoolIndex()
  self._currentPoolIndex = self._currentPoolIndex + 1
  if self._currentPoolIndex > self._MAX_ROW - 1 then
    self._currentPoolIndex = 0
  end
  return self._currentPoolIndex
end
function PaGlobal_Widget_KillLog:isEndLog()
  for i = 0, self._MAX_ROW - 1 do
    if true == self._logPool._log[i]._isShow then
      return false
    end
  end
  return true
end
function PaGlobal_Widget_KillLog:addAllIndexing()
  for i = 0, self._MAX_ROW - 1 do
    if true == self._logPool._log[i]._isShow then
      self._logPool._log[i]._index = self._logPool._log[i]._index + 1
      if self._MAX_ROW <= self._logPool._log[i]._index then
        self:setShowLog(false, i)
      end
    end
  end
end
function PaGlobal_Widget_KillLog:reposition()
  for k, value in pairs(self._logPool._log) do
    local posY = self._logPool._startPosition.y + self._logPool._offsetSizeY * value._index
    value._stc_logBg:SetPosY(posY)
  end
end
function PaGlobal_Widget_KillLog:updateLogCheck(deltaTime)
  for i = 0, self._MAX_ROW - 1 do
    if true == self._logPool._log[i]._isShow then
      self._logPool._log[i]._viewTime = self._logPool._log[i]._viewTime + deltaTime
      if false == self._logPool._log[i]._isEnd and self._viewTime <= self._logPool._log[i]._viewTime then
        self._logPool._log[i]._isEnd = true
        self:addEndAnimation(i)
      end
    end
  end
end
function PaGlobal_Widget_KillLog:updateEndAnimationCheck(deltaTime)
  for i = 0, self._MAX_ROW - 1 do
    if true == self._logPool._log[i]._isShow then
      if true == self._logPool._log[i]._isEnd then
        self._logPool._log[i]._animTime = self._logPool._log[i]._animTime + deltaTime
      end
      if self._AnimTime <= self._logPool._log[i]._animTime then
        self:setShowLog(false, i)
      end
    end
  end
  if true == self._isAnimating then
    self._animatingTime = self._animatingTime + deltaTime
    if self._AnimTime < self._animatingTime then
      self._isAnimating = false
    end
  end
end
function PaGlobal_Widget_KillLog:setShowLog(isShow, poolIndex)
  self._logPool._log[poolIndex]._stc_logBg:ResetAndClearVertexAni()
  self._logPool._log[poolIndex]._txt_log:ResetAndClearVertexAni()
  self._logPool._log[poolIndex]._stc_logBg:SetShow(isShow)
  self._logPool._log[poolIndex]._txt_log:SetShow(isShow)
  self._logPool._log[poolIndex]._isShow = isShow
end
function PaGlobal_Widget_KillLog:addStartAnimation(poolIndex)
  local _log = self._logPool._log[poolIndex]
  local posY = self._logPool._startPosition.y + self._logPool._offsetSizeY * _log._index
  local moveAni = _log._stc_logBg:addMoveAnimation(0, self._AnimTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  moveAni:SetStartPosition(self._logPool._startPosition.x - 200, posY)
  moveAni:SetEndPosition(self._logPool._startPosition.x, posY)
  local colorAni = _log._stc_logBg:addColorAnimation(0, self._AnimTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  colorAni:SetStartColor(Defines.Color.C_00FFFFFF)
  colorAni:SetEndColor(3439329279)
  colorAni.IsChangeChild = false
  local colorAni1 = _log._txt_log:addColorAnimation(0, self._AnimTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  colorAni1:SetStartColor(Defines.Color.C_00FFFFFF)
  colorAni1:SetEndColor(Defines.Color.C_FFFFFFFF)
  audioPostEvent_SystemUi(24, 0)
  self._isAnimating = true
  self._animatingTime = 0
  _log._stc_logBg:AddEffect("fUI_Widget_KillLog_01A", false, 0, 0)
end
function PaGlobal_Widget_KillLog:addEndAnimation(poolIndex)
  local _log = self._logPool._log[poolIndex]
  local colorAni = _log._stc_logBg:addColorAnimation(0, self._AnimTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  colorAni:SetStartColor(3439329279)
  colorAni:SetEndColor(Defines.Color.C_00FFFFFF)
  colorAni.IsChangeChild = false
  local colorAni1 = _log._txt_log:addColorAnimation(0, self._AnimTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  colorAni1:SetStartColor(Defines.Color.C_FFFFFFFF)
  colorAni1:SetEndColor(Defines.Color.C_00FFFFFF)
end
function PaGlobal_Widget_KillLog:screenResize()
  Panel_Widget_KillLog:ComputePos()
  local isSaved = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_KillLog, 0, CppEnums.PanelSaveType.PanelSaveType_IsSaved)
  local relativePosX = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_KillLog, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionX)
  local relativePosY = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_KillLog, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionY)
  local initPosX = Panel_Widget_KillLog:GetPosX()
  local initPosY = Panel_Widget_KillLog:GetPosY()
  if relativePosX == -1 and relativePosY == -1 then
    changePositionBySever(Panel_Widget_KillLog, CppEnums.PAGameUIType.PAGameUIPanel_KillLog, true, true, false)
    FGlobal_InitPanelRelativePos(Panel_Widget_KillLog, initPosX, initPosY)
  elseif relativePosX == 0 and relativePosY == 0 then
    Panel_Widget_KillLog:SetPosX(initPosX)
    Panel_Widget_KillLog:SetPosY(initPosY)
  else
    Panel_Widget_KillLog:SetRelativePosX(relativePosX)
    Panel_Widget_KillLog:SetRelativePosY(relativePosY)
    Panel_Widget_KillLog:SetPosX(getOriginScreenSizeX() * relativePosX - Panel_Widget_KillLog:GetSizeX() * 0.5)
    Panel_Widget_KillLog:SetPosY(getOriginScreenSizeY() * relativePosY - Panel_Widget_KillLog:GetSizeY() * 0.5)
  end
  local isShow = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_KillLog, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow)
  if 0 < isSaved then
    if 0 == isShow then
      PaGlobal_Widget_KillLog:hideAllLog()
    end
    Panel_Widget_KillLog:SetShow(isShow)
  else
    Panel_Widget_KillLog:SetShow(true)
  end
end
function PaGlobal_Widget_KillLog:hideAllLog()
  for i = 0, self._MAX_ROW - 1 do
    self:setShowLog(false, i)
  end
end
