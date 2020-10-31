function PaGlobal_PowerControl_All:initialize()
  if true == PaGlobal_PowerControl_All._initialize then
    return
  end
  self._ui._stc_gauge_BG_L = UI.getChildControl(Panel_MiniGame_PowerControl_All, "Static_PowerGauge_BG_L")
  self._ui._stc_gauge_BG_R = UI.getChildControl(Panel_MiniGame_PowerControl_All, "Static_PowerGauge_BG_R")
  self._ui._stc_danger_L = UI.getChildControl(Panel_MiniGame_PowerControl_All, "Static_Danger_L")
  self._ui._stc_danger_R = UI.getChildControl(Panel_MiniGame_PowerControl_All, "Static_Danger_R")
  self._ui._progress_gauge_L = UI.getChildControl(Panel_MiniGame_PowerControl_All, "Progress2_PowerGauge_L")
  self._ui._progress_gauge_R = UI.getChildControl(Panel_MiniGame_PowerControl_All, "Progress2_PowerGauge_R")
  self._ui._stc_gaugeDeco_L = UI.getChildControl(Panel_MiniGame_PowerControl_All, "Static_Cow_Deco_L")
  self._ui._stc_gaugeDeco_R = UI.getChildControl(Panel_MiniGame_PowerControl_All, "Static_Cow_Deco_R")
  self._ui._stc_milky_L = UI.getChildControl(Panel_MiniGame_PowerControl_All, "Static_MilkyLeft")
  self._ui._stc_milky_R = UI.getChildControl(Panel_MiniGame_PowerControl_All, "Static_MilkyRight")
  self._ui._stc_mouseBG = UI.getChildControl(Panel_MiniGame_PowerControl_All, "Static_PC_Control_BG")
  self._ui._stc_mouse_L = UI.getChildControl(self._ui._stc_mouseBG, "Static_L_Btn_L")
  self._ui._stc_mouse_R = UI.getChildControl(self._ui._stc_mouseBG, "Static_R_Btn_R")
  self._ui._stc_keyguideBG = UI.getChildControl(Panel_MiniGame_PowerControl_All, "Static_Console_Control_BG")
  self._ui._txt_gameTimer = UI.getChildControl(Panel_MiniGame_PowerControl_All, "StaticText_Timer")
  self._ui._txt_milkyRate = UI.getChildControl(Panel_MiniGame_PowerControl_All, "StaticText_MilkyRate")
  self._ui._stc_result_success = UI.getChildControl(Panel_MiniGame_PowerControl_All, "Static_Result_Success")
  self._ui._stc_result_failed = UI.getChildControl(Panel_MiniGame_PowerControl_All, "Static_Result_Failed")
  self._ui._progress_Milk = UI.getChildControl(Panel_MiniGame_PowerControl_All, "Progress2_Milk")
  PaGlobal_PowerControl_All._isConsole = _ContentsGroup_UsePadSnapping
  if true == PaGlobal_PowerControl_All._isConsole then
    self._ui._stc_mouseBG:SetShow(false)
    self._ui._stc_keyguideBG:SetShow(true)
  else
    self._ui._stc_mouseBG:SetShow(true)
    self._ui._stc_keyguideBG:SetShow(false)
  end
  PaGlobal_PowerControl_All:registEventHandler()
  PaGlobal_PowerControl_All:validate()
  PaGlobal_PowerControl_All._initialize = true
end
function PaGlobal_PowerControl_All:registEventHandler()
  if nil == Panel_MiniGame_PowerControl_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_PowerControl_All_OnScreenSize")
  if true == PaGlobal_PowerControl_All._isConsole then
    registerEvent("EventActionMiniGamePadDownOnce", "PaGloabl_PowerControl_All_OnKeyDown")
    registerEvent("EventActionMiniGamePadUp", "PaGloabl_PowerControl_All_OnKeyUp")
  end
end
function PaGlobal_PowerControl_All:prepareOpen()
  if nil == Panel_MiniGame_PowerControl_All then
    return
  end
  if true == Panel_MiniGame_PowerControl_All:GetShow() then
    return
  end
  self:initValue()
  local gameEndTimer = math.floor(self._gameEndTimer - 1)
  self._ui._txt_gameTimer:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAME_POWERCONTROL_REMAINTIME", "gameEndTimer", gameEndTimer))
  self._ui._txt_milkyRate:SetText("0 %")
  PaGlobal_PowerControl_All:open()
end
function PaGlobal_PowerControl_All:open()
  if nil == Panel_MiniGame_PowerControl_All then
    return
  end
  Panel_MiniGame_PowerControl_All:SetShow(true)
end
function PaGlobal_PowerControl_All:prepareClose()
  if nil == Panel_MiniGame_PowerControl_All then
    return
  end
  if false == Panel_MiniGame_PowerControl_All:GetShow() then
    return
  end
  getSelfPlayer():get():SetMiniGameResult(4)
  self._isGamePlaying = false
  if true == PaGlobal_PowerControl_All._isConsole then
    PaGlobal_ConsoleQuickMenu:widgetOpen()
  end
  Panel_MiniGame_PowerControl_All:ClearUpdateLuaFunc()
  PaGlobal_PowerControl_All:close()
end
function PaGlobal_PowerControl_All:close()
  if nil == Panel_MiniGame_PowerControl_All then
    return
  end
  Panel_MiniGame_PowerControl_All:SetShow(false)
end
function PaGlobal_PowerControl_All:update()
  if nil == Panel_MiniGame_PowerControl_All then
    return
  end
end
function PaGlobal_PowerControl_All:validate()
  if nil == Panel_MiniGame_PowerControl_All then
    return
  end
  self._ui._stc_gauge_BG_L:isValidate()
  self._ui._stc_gauge_BG_R:isValidate()
  self._ui._stc_danger_L:isValidate()
  self._ui._stc_danger_R:isValidate()
  self._ui._progress_gauge_L:isValidate()
  self._ui._progress_gauge_R:isValidate()
  self._ui._stc_gaugeDeco_L:isValidate()
  self._ui._stc_gaugeDeco_R:isValidate()
  self._ui._stc_milky_L:isValidate()
  self._ui._stc_milky_R:isValidate()
  self._ui._stc_mouse_L:isValidate()
  self._ui._stc_mouse_R:isValidate()
  self._ui._txt_gameTimer:isValidate()
  self._ui._txt_milkyRate:isValidate()
  self._ui._stc_result_success:isValidate()
  self._ui._stc_result_failed:isValidate()
  self._ui._progress_Milk:isValidate()
end
function PaGlobal_PowerControl_All:onKeyDown(keyType)
  if false == self._isGamePlaying then
    return
  end
  if true == PaGlobal_PowerControl_All._isConsole then
    if __eQuickTimeEventPadType_LT == keyType then
      self._ePressType_L = self._direction.left
    elseif __eQuickTimeEventPadType_RT == keyType then
      self._ePressType_R = self._direction.right
    end
  elseif CppEnums.MiniGameKeyType.MiniGameKeyType_M0 == keyType then
    self._ePressType_L = self._direction.left
  elseif CppEnums.MiniGameKeyType.MiniGameKeyType_M1 == keyType then
    self._ePressType_R = self._direction.right
  end
end
function PaGlobal_PowerControl_All:onKeyUp(keyType)
  if false == self._isGamePlaying then
    return
  end
  local inputLeft = false
  local inputRight = false
  if true == PaGlobal_PowerControl_All._isConsole then
    if __eQuickTimeEventPadType_LT == keyType then
      inputLeft = true
    elseif __eQuickTimeEventPadType_RT == keyType then
      inputRight = true
    end
  elseif CppEnums.MiniGameKeyType.MiniGameKeyType_M0 == keyType then
    inputLeft = true
  elseif CppEnums.MiniGameKeyType.MiniGameKeyType_M1 == keyType then
    inputRight = true
  end
  if true == inputLeft then
    audioPostEvent_SystemUi(11, 5)
    _AudioPostEvent_SystemUiForXBOX(11, 5)
    self._ePressType_L = self._direction.none
    self._directionType = self._direction.right
    self:setAlphaGroup(0.6, 1)
  elseif true == inputRight then
    audioPostEvent_SystemUi(11, 5)
    _AudioPostEvent_SystemUiForXBOX(11, 5)
    self._ePressType_R = self._direction.none
    self._directionType = self._direction.left
    self:setAlphaGroup(1, 0.6)
  end
end
function PaGlobal_PowerControl_All:initValue()
  self._ui._progress_gauge_L:SetProgressRate(100)
  self._ui._progress_gauge_R:SetProgressRate(100)
  self._leftMilkyRate = 100
  self._rightMilkyRate = 100
  self:setAlphaGroup(1, 0.6)
  self._ui._txt_gameTimer:SetShow(true)
  self._ui._stc_milky_L:SetShow(false)
  self._ui._stc_milky_R:SetShow(false)
  self._directionType = self._direction.left
  self._ePressType_L = self._direction.none
  self._ePressType_R = self._direction.none
  self._milkRate = 0
  self._gameEndTimer = 31
  self._endTimer = 0
  self._isFullMilk = false
  self._ui._progress_Milk:SetProgressRate(self._milkRate)
  self._ui._stc_result_success:SetShow(false)
  self._ui._stc_result_failed:SetShow(false)
  AddMiniGameKeyPress(CppEnums.MiniGameType.MiniGameType_14, PaGloabl_PowerControl_All_OnKeyDown)
  AddMiniGameKeyUp(CppEnums.MiniGameType.MiniGameType_14, PaGloabl_PowerControl_All_OnKeyUp)
end
function PaGlobal_PowerControl_All:gameStart()
  self._isGamePlaying = true
  if true == PaGlobal_PowerControl_All._isConsole then
    PaGlobal_ConsoleQuickMenu:widgetClose()
  end
  Panel_MiniGame_PowerControl_All:RegisterUpdateFunc("Panel_Minigame_UpdateFunc")
end
function PaGlobal_PowerControl_All:gameEnd()
  self:prepareClose()
end
function PaGlobal_PowerControl_All:gameResult(deltaTime)
  self._endTimer = self._endTimer + deltaTime
  local endTimer = math.floor(self._endTimer)
  self._gameEndTimer = 0
  self._ui._txt_gameTimer:SetText("")
  if self._milkRate == 100 and endTimer < 0.01 then
    self:gameSuccess()
  elseif self._milkRate <= 99 and endTimer < 0.01 then
    self:gameFailed()
  end
  if 2 <= endTimer then
    self:gameEnd()
  end
end
function PaGlobal_PowerControl_All:gameSuccess()
  if false == self._isGamePlaying then
    return
  end
  audioPostEvent_SystemUi(11, 13)
  _AudioPostEvent_SystemUiForXBOX(11, 13)
  ToClient_MinigameResult(1, true)
  FGlobal_MiniGame_PowerControl()
  self._isGamePlaying = false
  self._ui._txt_gameTimer:SetShow(false)
  getSelfPlayer():get():SetMiniGameResult(0)
  self._ui._stc_result_success:ResetVertexAni()
  self._ui._stc_result_success:SetVertexAniRun("Good_Ani", true)
  self._ui._stc_result_success:SetShow(true)
  self._ui._stc_milky_L:SetShow(false)
  self._ui._stc_milky_R:SetShow(false)
  self._isFullMilk = true
end
function PaGlobal_PowerControl_All:gameFailed()
  if false == self._isGamePlaying then
    return
  end
  audioPostEvent_SystemUi(11, 2)
  _AudioPostEvent_SystemUiForXBOX(11, 2)
  ToClient_MinigameResult(1, false)
  self._isGamePlaying = false
  self._directionType = self._direction.none
  self._ePressType_L = self._direction.none
  self._ePressType_R = self._direction.none
  self._ui._txt_gameTimer:SetShow(false)
  getSelfPlayer():get():SetMiniGameResult(1)
  self._ui._stc_result_failed:ResetVertexAni()
  self._ui._stc_result_failed:SetVertexAniRun("Bad_Ani", true)
  self._ui._stc_result_failed:SetShow(true)
  self._ui._stc_milky_L:SetShow(false)
  self._ui._stc_milky_R:SetShow(false)
end
function PaGlobal_PowerControl_All:updateRightMilky(value)
  self._rightMilkyRate = math.max(math.min(self._rightMilkyRate + value, 100), 0)
  self._ui._progress_gauge_R:SetProgressRate(self._rightMilkyRate)
  self._ui._stc_danger_L:SetAlpha(0.88 - self._leftMilkyRate * 0.01)
end
function PaGlobal_PowerControl_All:updateLeftMilky(value)
  self._leftMilkyRate = math.max(math.min(self._leftMilkyRate + value, 100), 0)
  self._ui._progress_gauge_L:SetProgressRate(self._leftMilkyRate)
  self._ui._stc_danger_R:SetAlpha(0.88 - self._rightMilkyRate * 0.01)
end
function PaGlobal_PowerControl_All:updatePerframe(deltaTime)
  self._gameEndTimer = self._gameEndTimer - deltaTime
  local gameEndTimer = math.floor(self._gameEndTimer)
  self._ui._txt_milkyRate:SetText(math.floor(self._milkRate) .. " %")
  if self._direction.left == self._ePressType_L and self._direction.left == self._directionType then
    self:updateLeftMilky(-110 * deltaTime)
    self:updateRightMilky(65 * deltaTime)
    self._milkRate = self._milkRate + 0.3 * (deltaTime * 60)
    self._ui._stc_mouse_L:ResetVertexAni()
    self._ui._stc_mouse_L:SetVertexAniRun("Ani_Color_Left", true)
    self._ui._stc_milky_L:SetShow(true)
    self._ui._stc_milky_R:SetShow(false)
    self._ui._progress_Milk:SetProgressRate(self._milkRate)
  elseif self._direction.right == self._ePressType_R and self._direction.right == self._directionType then
    self:updateRightMilky(-110 * deltaTime)
    self:updateLeftMilky(65 * deltaTime)
    self._milkRate = self._milkRate + 0.3 * (deltaTime * 60)
    self._ui._stc_mouse_R:ResetVertexAni()
    self._ui._stc_mouse_R:SetVertexAniRun("Ani_Color_Right", true)
    self._ui._stc_milky_L:SetShow(false)
    self._ui._stc_milky_R:SetShow(true)
    self._ui._progress_Milk:SetProgressRate(self._milkRate)
  else
    self:updateLeftMilky(65 * deltaTime)
    self:updateRightMilky(65 * deltaTime)
    self._ui._stc_milky_L:SetShow(false)
    self._ui._stc_milky_R:SetShow(false)
  end
  if true == self._isGamePlaying then
    self._ui._txt_gameTimer:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAME_POWERCONTROL_REMAINTIME", "gameEndTimer", gameEndTimer))
  end
  self._isFullMilk = false
  if self._milkRate >= 100 then
    self._milkRate = 100
    self._isFullMilk = true
  end
  if 1 >= self._leftMilkyRate or 1 >= self._rightMilkyRate then
    self:gameFailed()
  end
  if self._gameEndTimer <= 0 or true == self._isFullMilk then
    self:gameResult(deltaTime)
  end
end
function PaGlobal_PowerControl_All:setAlphaGroup(leftAlpha, rightAlpha)
  self._ui._stc_gauge_BG_L:SetAlpha(leftAlpha)
  self._ui._progress_gauge_L:SetAlpha(leftAlpha)
  self._ui._stc_gaugeDeco_L:SetAlpha(leftAlpha)
  self._ui._stc_gauge_BG_R:SetAlpha(rightAlpha)
  self._ui._progress_gauge_R:SetAlpha(rightAlpha)
  self._ui._stc_gaugeDeco_R:SetAlpha(rightAlpha)
end
