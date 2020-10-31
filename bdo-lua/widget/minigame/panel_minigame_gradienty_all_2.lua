function PaGlobal_MiniGame_GradientY_All_Open()
  if nil == Panel_Minigame_GradientY_All then
    return
  end
  PaGlobal_MiniGame_GradientY_All:prepareOpen()
end
function PaGlobal_MiniGame_GradientY_All_Close()
  if nil == Panel_Minigame_GradientY_All or false == Panel_Minigame_GradientY_All:GetShow() then
    return
  end
  PaGlobal_MiniGame_GradientY_All:prepareClose()
end
function PaGlobal_MiniGame_GradientY_All_GaugeMove(isUp)
  if nil == Panel_Minigame_GradientY_All or false == Panel_Minigame_GradientY_All:GetShow() then
    return
  end
  local speedWeight = PaGlobal_MiniGame_GradientY_All._KeyTimeSpanMinWeight
  if PaGlobal_MiniGame_GradientY_All._lastKeyTime < PaGlobal_MiniGame_GradientY_All._sequenceKeyTimeSpan then
    speedWeight = Util.Math.Lerp(PaGlobal_MiniGame_GradientY_All._KeyTimeSpanMaxWeight, PaGlobal_MiniGame_GradientY_All._KeyTimeSpanMinWeight, PaGlobal_MiniGame_GradientY_All._lastKeyTime / PaGlobal_MiniGame_GradientY_All._sequenceKeyTimeSpan)
    PaGlobal_MiniGame_GradientY_All._lastKeyDirection = PaGlobal_MiniGame_GradientY_All._keyDirection.None
  end
  if true == isUp then
    PaGlobal_MiniGame_GradientY_All._lastKeyDirection = PaGlobal_MiniGame_GradientY_All._keyDirection.Up
    PaGlobal_MiniGame_GradientY_All._currentSpeed = PaGlobal_MiniGame_GradientY_All._currentSpeed - speedWeight
    PaGlobal_MiniGame_GradientY_All:showKeyUpAni()
  else
    PaGlobal_MiniGame_GradientY_All._lastKeyDirection = PaGlobal_MiniGame_GradientY_All._keyDirection.Down
    PaGlobal_MiniGame_GradientY_All._currentSpeed = PaGlobal_MiniGame_GradientY_All._currentSpeed + speedWeight
    PaGlobal_MiniGame_GradientY_All:showKeyDownAni()
  end
  PaGlobal_MiniGame_GradientY_All._lastKeyTime = 0
end
function PaGlobal_MiniGame_GradientY_All_StartGame()
  if true == PaGlobal_MiniGame_GradientY_All._isConsole then
    math.randomseed(getTickCount32())
  else
    math.randomseed(os.time())
  end
  local speed = math.random()
  PaGlobal_MiniGame_GradientY_All._currentSpeed = (speed - 0.35) / 1.6
  local centerPos = Panel_Minigame_GradientY_All:GetSizeY() / 2 - PaGlobal_MiniGame_GradientY_All._ui.stc_gaugeBar:GetSizeY() / 2
  PaGlobal_MiniGame_GradientY_All._ui.stc_gaugeBar:SetPosY(centerPos)
  PaGlobal_MiniGame_GradientY_All._lastKeyDirection = PaGlobal_MiniGame_GradientY_All._keyDirection.None
  PaGlobal_MiniGame_GradientY_All._lastKeyTime = 0
  PaGlobal_MiniGame_GradientY_All._currentPos = 0.5
  if true == PaGlobal_MiniGame_GradientY_All._isConsole then
    PaGlobal_MiniGame_GradientY_All._ui.stc_keyguideUpEff:SetShow(false)
    PaGlobal_MiniGame_GradientY_All._ui.stc_keyguideDownEff:SetShow(false)
  else
    PaGlobal_MiniGame_GradientY_All._ui.stc_keyUpEff:SetShow(false)
    PaGlobal_MiniGame_GradientY_All._ui.stc_keyDownEff:SetShow(false)
  end
  PaGlobal_MiniGame_GradientY_All_Open()
end
function PaGlobal_MiniGame_GradientY_All_EndGame()
  PaGlobal_MiniGame_GradientY_All_Close()
end
function PaGlobal_MiniGame_GradientY_All_GaugeBarMoveCalc(fDeltaTime)
  PaGlobal_MiniGame_GradientY_All._lastKeyTime = PaGlobal_MiniGame_GradientY_All._lastKeyTime + fDeltaTime
  local currentPos = PaGlobal_MiniGame_GradientY_All._currentPos + PaGlobal_MiniGame_GradientY_All._currentSpeed * fDeltaTime
  if currentPos < 0 then
    currentPos = 0
  elseif 1 < currentPos then
    currentPos = 1
  end
  if currentPos < 0.25 or 0.75 < currentPos then
    if false == PaGlobal_MiniGame_GradientY_All._ui.stc_resultBad:GetShow() then
      audioPostEvent_SystemUi(11, 2)
      _AudioPostEvent_SystemUiForXBOX(11, 2)
      PaGlobal_MiniGame_GradientY_All:showBadResultAni()
      if currentPos < 0.25 then
        getSelfPlayer():get():SetMiniGameResult(1)
      else
        getSelfPlayer():get():SetMiniGameResult(2)
      end
    end
  elseif false == PaGlobal_MiniGame_GradientY_All._ui.stc_resultGood:GetShow() then
    audioPostEvent_SystemUi(11, 1)
    _AudioPostEvent_SystemUiForXBOX(11, 1)
    PaGlobal_MiniGame_GradientY_All:showGoodResultAni()
  end
  PaGlobal_MiniGame_GradientY_All._currentPos = currentPos
  PaGlobal_MiniGame_GradientY_All._currentSpeed = PaGlobal_MiniGame_GradientY_All._currentSpeed - (0.5 - currentPos) * PaGlobal_MiniGame_GradientY_All._speedWeight * fDeltaTime
  PaGlobal_MiniGame_GradientY_All:setCurrentPosIcon()
end
function FromClient_Minigame_GradientY_All_OnScreenSize()
  if nil == Panel_Minigame_GradientY_All or false == Panel_Minigame_GradientY_All:GetShow() then
    return
  end
  Panel_Minigame_GradientY_All:ComputePos()
  PaGlobal_MiniGame_GradientY_All._ui.stc_gaugeBG:ComputePos()
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyUp:ComputePos()
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyUpEff:ComputePos()
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyDown:ComputePos()
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyDownEff:ComputePos()
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyguideUp:ComputePos()
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyguideDown:ComputePos()
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyguideUpEff:ComputePos()
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyguideDownEff:ComputePos()
  PaGlobal_MiniGame_GradientY_All._ui.stc_resultGood:ComputePos()
  PaGlobal_MiniGame_GradientY_All._ui.stc_resultBad:ComputePos()
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyGuide:ComputePos()
end
function FromClient_Minigame_GradientY_All_KeyPress(keyType)
  if false == PaGlobal_MiniGame_GradientY_All.isGradientYPlay then
    return
  end
  if true == PaGlobal_MiniGame_GradientY_All._isConsole then
    if __eQuickTimeEventPadType_B == keyType then
      PaGlobal_MiniGame_GradientY_All_GaugeMove(true)
    elseif __eQuickTimeEventPadType_A == keyType then
      PaGlobal_MiniGame_GradientY_All_GaugeMove(false)
    end
  elseif CppEnums.MiniGameKeyType.MiniGameKeyType_W == keyType then
    PaGlobal_MiniGame_GradientY_All_GaugeMove(true)
  elseif CppEnums.MiniGameKeyType.MiniGameKeyType_S == keyType then
    PaGlobal_MiniGame_GradientY_All_GaugeMove(false)
  end
end
