function PaGlobal_MiniGame_Rhythm_Drum_All_Open()
  if nil == Panel_MiniGame_Rhythm_Drum_All then
    return
  end
  PaGlobal_MiniGame_Rhythm_Drum_All:prepareOpen()
end
function PaGlobal_MiniGame_Rhythm_Drum_All_Close()
  if nil == Panel_MiniGame_Rhythm_Drum_All or false == Panel_MiniGame_Rhythm_Drum_All:GetShow() then
    return
  end
  PaGlobal_MiniGame_Rhythm_Drum_All:prepareClose()
end
function PaGlobal_MiniGame_Rhythm_Drum_All_StartGame()
  Interaction_Close()
  PaGlobal_MiniGame_Rhythm_Drum_All._ui.stc_resultBad:SetShow(false)
  PaGlobal_MiniGame_Rhythm_Drum_All._cursorIndex = 2
  PaGlobal_MiniGame_Rhythm_Drum_All._isFailed = false
  PaGlobal_MiniGame_Rhythm_Drum_All._bufferIndex = 1
  PaGlobal_MiniGame_Rhythm_Drum_All._questCheckTime = 0
  for k, v in pairs(PaGlobal_MiniGame_Rhythm_Drum_All._noteBuffer) do
    PaGlobal_MiniGame_Rhythm_Drum_All:posSetting(v, 1)
  end
  PaGlobal_MiniGame_Rhythm_Drum_All._ui.stc_rhythmCursor:SetPosX(PaGlobal_MiniGame_Rhythm_Drum_All._cursorStartPos)
  PaGlobal_MiniGame_Rhythm_Drum_All_Open()
end
function PaGlobal_MiniGame_Rhythm_Drum_All_EndGame()
  PaGlobal_MiniGame_Rhythm_Drum_All_Close()
end
function PaGlobal_MiniGame_Rhythm_Drum_All_GameUpdate(deltaTime)
  PaGlobal_MiniGame_Rhythm_Drum_All._currentSumTime = PaGlobal_MiniGame_Rhythm_Drum_All._currentSumTime + deltaTime
  PaGlobal_MiniGame_Rhythm_Drum_All._questCheckTime = PaGlobal_MiniGame_Rhythm_Drum_All._questCheckTime + deltaTime
  local posOver = PaGlobal_MiniGame_Rhythm_Drum_All._ui.stc_rhythmBG:GetPosY() + PaGlobal_MiniGame_Rhythm_Drum_All._ui.stc_rhythmBG:GetSizeY() - PaGlobal_MiniGame_Rhythm_Drum_All._hideSize - PaGlobal_MiniGame_Rhythm_Drum_All._ui.stc_rhythmNote:GetSizeY() + 8
  local culledPos = PaGlobal_MiniGame_Rhythm_Drum_All._ui.stc_rhythmBG:GetPosY() + PaGlobal_MiniGame_Rhythm_Drum_All._ui.stc_rhythmBG:GetSizeY() - PaGlobal_MiniGame_Rhythm_Drum_All._culledSize - PaGlobal_MiniGame_Rhythm_Drum_All._ui.stc_rhythmNote:GetSizeY()
  for key, control in pairs(PaGlobal_MiniGame_Rhythm_Drum_All._noteBuffer) do
    control:SetPosY(control:GetPosY() + deltaTime * PaGlobal_MiniGame_Rhythm_Drum_All._noteSpeed)
    if culledPos < control:GetPosY() and nil ~= PaGlobal_MiniGame_Rhythm_Drum_All._notePosBuffer[key] and PaGlobal_MiniGame_Rhythm_Drum_All._notePosBuffer[key] == PaGlobal_MiniGame_Rhythm_Drum_All._cursorIndex + 1 and control:GetShow() then
      getSelfPlayer():get():SetMiniGameResult(1)
      control:SetShow(false)
      if PaGlobal_MiniGame_Rhythm_Drum_All._isFailed == false then
        audioPostEvent_SystemUi(11, 2)
        _AudioPostEvent_SystemUiForXBOX(11, 2)
        PaGlobal_MiniGame_Rhythm_Drum_All._ui.stc_resultBad:SetShow(true)
        PaGlobal_MiniGame_Rhythm_Drum_All._ui.stc_resultBad:ResetVertexAni()
        PaGlobal_MiniGame_Rhythm_Drum_All._ui.stc_resultBad:SetVertexAniRun("Bad_Ani_Start", true)
        PaGlobal_MiniGame_Rhythm_Drum_All._ui.stc_resultBad:SetVertexAniRun("Bad_Ani", true)
        PaGlobal_MiniGame_Rhythm_Drum_All._isFailed = true
        PaGlobal_MiniGame_Rhythm_Drum_All._questCheckTime = 0
      end
    elseif posOver < control:GetPosY() then
      local value = control:GetPosY() - posOver
      control:SetAlpha((PaGlobal_MiniGame_Rhythm_Drum_All._hideSize - value) / PaGlobal_MiniGame_Rhythm_Drum_All._hideSize)
      if value > PaGlobal_MiniGame_Rhythm_Drum_All._hideSize then
        control:SetShow(false)
      end
    end
  end
  local count = 0
  if PaGlobal_MiniGame_Rhythm_Drum_All._createTime < PaGlobal_MiniGame_Rhythm_Drum_All._currentSumTime then
    PaGlobal_MiniGame_Rhythm_Drum_All._currentSumTime = PaGlobal_MiniGame_Rhythm_Drum_All._currentSumTime - PaGlobal_MiniGame_Rhythm_Drum_All._createTime
    while (0 == count or 1 < math.random(0, 5)) and count < 2 do
      local targetControl = PaGlobal_MiniGame_Rhythm_Drum_All:getRhythm()
      targetControl:SetShow(true)
      count = count + 1
    end
  end
end
function PaGlobal_MiniGame_Rhythm_Drum_All_GaugeMove(isLeft)
  if nil == Panel_MiniGame_Rhythm_Drum_All or false == Panel_MiniGame_Rhythm_Drum_All:GetShow() then
    return
  end
  if true == isLeft then
    if false == PaGlobal_MiniGame_Rhythm_Drum_All._isConsole then
      PaGlobal_MiniGame_Rhythm_Drum_All._ui.stc_mouseLeft_L:ResetVertexAni()
      PaGlobal_MiniGame_Rhythm_Drum_All._ui.stc_mouseLeft_L:SetVertexAniRun("Ani_Color_Left", true)
    end
    PaGlobal_MiniGame_Rhythm_Drum_All._cursorIndex = PaGlobal_MiniGame_Rhythm_Drum_All._cursorIndex - 1
    if PaGlobal_MiniGame_Rhythm_Drum_All._cursorIndex < 0 then
      PaGlobal_MiniGame_Rhythm_Drum_All._cursorIndex = 0
    end
  else
    if false == PaGlobal_MiniGame_Rhythm_Drum_All._isConsole then
      PaGlobal_MiniGame_Rhythm_Drum_All._ui.stc_mouseRight_R:ResetVertexAni()
      PaGlobal_MiniGame_Rhythm_Drum_All._ui.stc_mouseRight_R:SetVertexAniRun("Ani_Color_Right", true)
    end
    PaGlobal_MiniGame_Rhythm_Drum_All._cursorIndex = PaGlobal_MiniGame_Rhythm_Drum_All._cursorIndex + 1
    if PaGlobal_MiniGame_Rhythm_Drum_All._cursorIndex > 4 then
      PaGlobal_MiniGame_Rhythm_Drum_All._cursorIndex = 4
    end
  end
  PaGlobal_MiniGame_Rhythm_Drum_All:rhythmCursorAlign()
end
function FromClient_Minigame_Rhythm_Drum_All_OnScreenSize()
  if nil == Panel_MiniGame_Rhythm_Drum_All then
    return
  end
  Panel_MiniGame_Rhythm_Drum_All:ComputePos()
  Panel_MiniGame_Rhythm_Drum_All:SetPosX(getOriginScreenSizeX() * 0.5 - Panel_MiniGame_Rhythm_Drum_All:GetSizeX() * 0.5)
  Panel_MiniGame_Rhythm_Drum_All:SetPosY(getOriginScreenSizeY() * 0.5 - 300)
end
function FromClient_Minigame_Rhythm_Drum_All_KeyPress(keyType)
  if PaGlobal_MiniGame_Rhythm_Drum_All._isFailed == true then
    return
  end
  if true == PaGlobal_MiniGame_Rhythm_Drum_All._isConsole then
    if __eQuickTimeEventPadType_LB == keyType then
      PaGlobal_MiniGame_Rhythm_Drum_All_GaugeMove(true)
    elseif __eQuickTimeEventPadType_RB == keyType then
      PaGlobal_MiniGame_Rhythm_Drum_All_GaugeMove(false)
    end
  elseif CppEnums.MiniGameKeyType.MiniGameKeyType_M0 == keyType then
    PaGlobal_MiniGame_Rhythm_Drum_All_GaugeMove(true)
  elseif CppEnums.MiniGameKeyType.MiniGameKeyType_M1 == keyType then
    PaGlobal_MiniGame_Rhythm_Drum_All_GaugeMove(false)
  end
end
