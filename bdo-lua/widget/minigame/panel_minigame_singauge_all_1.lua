function PaGlobal_SinGauge_All:initialize()
  if true == PaGlobal_SinGauge_All._initialize then
    return
  end
  self._ui._stc_sinGaugeBg = UI.getChildControl(Panel_MiniGame_SinGauge_All, "Static_SinGaugeBG")
  self._ui._progress_gaugeBar = UI.getChildControl(Panel_MiniGame_SinGauge_All, "Progress2_SinGauge")
  self._ui._progress_barHead = UI.getChildControl(self._ui._progress_gaugeBar, "Progress2_1_Bar_Head")
  self._ui._progress_gaugeBarEffect = UI.getChildControl(Panel_MiniGame_SinGauge_All, "Static_SinGaugeEffect")
  local stc_redLine = UI.getChildControl(Panel_MiniGame_SinGauge_All, "Static_RedLine")
  self._ui._stc_gaugeLine = UI.getChildControl(stc_redLine, "Static_SinGaugeLine_1")
  self._ui._stc_spaceBar = UI.getChildControl(Panel_MiniGame_SinGauge_All, "Static_SpaceBar")
  self._ui._txt_space = UI.getChildControl(self._ui._stc_spaceBar, "StaticText_1")
  self._ui._stc_spaceBarEffect = UI.getChildControl(Panel_MiniGame_SinGauge_All, "Static_SpaceBar_Eff")
  self._ui._stc_keyguideA = UI.getChildControl(Panel_MiniGame_SinGauge_All, "StaticText_A_ConsoleUI")
  self._ui._stc_resultPerfect = UI.getChildControl(Panel_MiniGame_SinGauge_All, "Static_Result_Perfect")
  self._ui._stc_resultGood = UI.getChildControl(Panel_MiniGame_SinGauge_All, "Static_Result_Good")
  self._ui._stc_resultBad = UI.getChildControl(Panel_MiniGame_SinGauge_All, "Static_Result_Bad")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_spaceBar:SetShow(not self._isConsole)
  self._ui._stc_keyguideA:SetShow(self._isConsole)
  PaGlobal_SinGauge_All:registEventHandler()
  PaGlobal_SinGauge_All:validate()
  PaGlobal_SinGauge_All._initialize = true
end
function PaGlobal_SinGauge_All:registEventHandler()
  if nil == Panel_MiniGame_SinGauge_All then
    return
  end
  if true == self._isConsole then
    registerEvent("EventActionMiniGamePadDownOnce", "PaGlobal_SinGauge_All_KeyPress")
  end
end
function PaGlobal_SinGauge_All:prepareOpen()
  if nil == Panel_MiniGame_SinGauge_All then
    return
  end
  self._ui._stc_spaceBarEffect:AddEffect("UI_Fishing_Aura01", false, 0, 0)
  self._ui._stc_resultBad:SetShow(false)
  self._ui._stc_resultGood:SetShow(false)
  self._ui._stc_resultPerfect:SetShow(false)
  self:reposition()
  self._gaugeState = self._eGaugeState._rightProgress
  self._gaugeTripCount = 0
  self._progressValue = 0
  self._prevTickCount = getTickCount32()
  Panel_MiniGame_SinGauge_All:RegisterUpdateFunc("Panel_Minigame_UpdateFunc")
  PaGlobal_SinGauge_All:open()
end
function PaGlobal_SinGauge_All:open()
  if nil == Panel_MiniGame_SinGauge_All then
    return
  end
  Panel_MiniGame_SinGauge_All:SetShow(true)
end
function PaGlobal_SinGauge_All:prepareClose()
  if nil == Panel_MiniGame_SinGauge_All then
    return
  end
  self._ui._progress_gaugeBarEffect:EraseAllEffect()
  self._gaugeState = self._eGaugeState._wait
  PaGlobal_SinGauge_All:close()
end
function PaGlobal_SinGauge_All:close()
  if nil == Panel_MiniGame_SinGauge_All then
    return
  end
  Panel_MiniGame_SinGauge_All:SetShow(false)
end
function PaGlobal_SinGauge_All:validate()
  if nil == Panel_MiniGame_SinGauge_All then
    return
  end
end
function PaGlobal_SinGauge_All:startGame()
  local actionString = ""
  if getGamePadEnable() then
    actionString = keyCustom_GetString_ActionPad(self._gameOptionActionKey.Jump)
  else
    actionString = keyCustom_GetString_ActionKey(self._gameOptionActionKey.Jump)
  end
  self._ui._txt_space:SetText(actionString)
  if true == self._isConsole then
    math.randomseed(getTickCount32())
  else
    math.randomseed(os.time())
  end
  self._gaugeSpeed = 0.88 + math.random(0, 200) * 0.001 + getSelfPlayer():get():getFishGrade() * 0.03
  self:prepareOpen()
end
function PaGlobal_SinGauge_All:endGame()
  self:prepareClose()
end
function PaGlobal_SinGauge_All:gameFail()
  if self._eGaugeState._wait == self._gaugeState then
    return
  end
  if nil == getSelfPlayer() then
    return
  end
  audioPostEvent_SystemUi(11, 7)
  self:finishState()
  getSelfPlayer():get():SetMiniGameResult(0)
  self._ui._stc_resultBad:ResetVertexAni()
  self._ui._stc_resultBad:SetVertexAniRun("Bad_Ani", true)
  self._ui._stc_resultBad:SetVertexAniRun("Bad_ScaleAni", true)
  self._ui._stc_resultBad:SetVertexAniRun("Bad_AniEnd", true)
  self._ui._stc_resultBad:SetShow(true)
end
function PaGlobal_SinGauge_All:gameSuccess(isPerfect)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if true == isPerfect then
    audioPostEvent_SystemUi(11, 0)
    audioPostEvent_SystemUi(11, 13)
    selfPlayer:get():SetMiniGameResult(3)
    self:finishState()
    self._ui._stc_resultPerfect:ResetVertexAni()
    self._ui._stc_resultPerfect:SetVertexAniRun("Perfect_Ani", true)
    self._ui._stc_resultPerfect:SetVertexAniRun("Perfect_ScaleAni", true)
    self._ui._stc_resultPerfect:SetVertexAniRun("Perfect_AniEnd", true)
    self._ui._stc_resultPerfect:SetShow(true)
  else
    audioPostEvent_SystemUi(11, 0)
    audioPostEvent_SystemUi(11, 13)
    selfPlayer:get():SetMiniGameResult(11)
    self:finishState()
    self._ui._stc_resultGood:ResetVertexAni()
    self._ui._stc_resultGood:SetVertexAniRun("Good_Ani", true)
    self._ui._stc_resultGood:SetVertexAniRun("Good_ScaleAni", true)
    self._ui._stc_resultGood:SetVertexAniRun("Good_AniEnd", true)
    self._ui._stc_resultGood:SetShow(true)
  end
end
function PaGlobal_SinGauge_All:updateGauge()
  if self._eGaugeState._wait == self._gaugeState then
    return
  end
  local currentTick = getTickCount32()
  local deltaTick = currentTick - self._prevTickCount
  local deltaTime = deltaTick * 0.001 * self._gaugeSpeed
  if self._eGaugeState._rightProgress == self._gaugeState then
    self._progressValue = self._progressValue + (self._progressValue + 1) * 10 * deltaTime
    if self._maxProgressValue < self._progressValue then
      self._progressValue = self._maxProgressValue
      self._gaugeState = self._eGaugeState._leftProgress
    end
  elseif self._eGaugeState._leftProgress == self._gaugeState then
    self._progressValue = self._progressValue - (self._progressValue + 1) * 2 * deltaTime
    if self._progressValue < self._minProgressValue then
      self._progressValue = self._minProgressValue
      self._gaugeState = self._eGaugeState._rightProgress
      self._gaugeTripCount = self._gaugeTripCount + 1
    end
  end
  self._ui._progress_gaugeBar:SetProgressRate(self._progressValue)
  self._prevTickCount = currentTick
  if self._checkTripCount == self._gaugeTripCount then
    self:gameFail()
  end
end
function PaGlobal_SinGauge_All:keyPress(keyType)
  if self._eGaugeState._wait == self._gaugeState then
    return
  end
  local isKeyPress = false
  if true == self._isConsole then
    if __eQuickTimeEventPadType_A == keyType then
      isKeyPress = true
    end
  elseif CppEnums.MiniGameKeyType.MiniGameKeyType_Space == keyType then
    isKeyPress = true
  end
  if true == isKeyPress then
    self._ui._progress_gaugeBar:SetProgressRate(self._progressValue)
    if self._maxProgressValue == self._progressValue then
      self:gameSuccess(true)
    elseif self._ui._stc_gaugeLine:GetPosX() < self._ui._progress_barHead:GetPosX() then
      self:gameSuccess(false)
    else
      self:gameFail()
    end
  end
end
function PaGlobal_SinGauge_All:reposition()
  Panel_MiniGame_SinGauge_All:SetPosX((getOriginScreenSizeX() - Panel_MiniGame_SinGauge_All:GetSizeX()) * 0.5)
  Panel_MiniGame_SinGauge_All:SetPosY(getOriginScreenSizeY() * 0.3 + Panel_MiniGame_SinGauge_All:GetSizeY() * 1.8)
end
function PaGlobal_SinGauge_All:finishState()
  self._gaugeState = self._eGaugeState._wait
end
