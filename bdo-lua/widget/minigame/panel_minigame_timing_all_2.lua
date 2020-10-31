function PaGlobal_MiniGame_Timing_All_Open()
  if nil == Panel_MiniGame_Timing_All then
    return
  end
  PaGlobal_MiniGame_Timing_All:prepareOpen()
end
function PaGlobal_MiniGame_Timing_All_Close()
  if nil == Panel_MiniGame_Timing_All or false == Panel_MiniGame_Timing_All:GetShow() then
    return
  end
  PaGlobal_MiniGame_Timing_All:prepareClose()
end
function PaGlobal_MiniGame_Timing_All_StartGame()
  FromClient_Minigame_Timing_All_OnScreenSize()
  PaGlobal_MiniGame_Timing_All._ui.stc_horseIcon:SetShow(true)
  PaGlobal_MiniGame_Timing_All._ui.stc_jumpIcon:SetShow(false)
  local actionString = ""
  if getGamePadEnable() then
    actionString = keyCustom_GetString_ActionPad(PaGlobal_MiniGame_Timing_All._gameOptionActionKey.Jump)
    PaGlobalFunc_Util_ChangeKeyguideTexture(PaGlobal_MiniGame_Timing_All._ui.stc_keyguideA, __eActionInputType_Jump)
  else
    actionString = keyCustom_GetString_ActionKey(PaGlobal_MiniGame_Timing_All._gameOptionActionKey.Jump)
  end
  PaGlobal_MiniGame_Timing_All._ui.txt_spacebarText:SetText(actionString)
  if true == PaGlobal_MiniGame_Timing_All._isConsole then
    math.randomseed(getTickCount32())
  else
    math.randomseed(os.time())
  end
  PaGlobal_MiniGame_Timing_All._currentTimingValue = math.random(0, 100) / 100
  PaGlobal_MiniGame_Timing_All._currentProgressValue = 0
  PaGlobal_MiniGame_Timing_All._isUpTiming = true
  PaGlobal_MiniGame_Timing_All._isUpProgress = true
  PaGlobal_MiniGame_Timing_All._sumTime = 0
  PaGlobal_MiniGame_Timing_All._playMode = 1
  PaGlobal_MiniGame_Timing_All._isPressed = false
  PaGlobal_MiniGame_Timing_All._ui.txt_resultText:ResetVertexAni()
  PaGlobal_MiniGame_Timing_All._ui.txt_resultText:SetAlpha(0)
  PaGlobal_MiniGame_Timing_All._ui.txt_resultText:SetShow(false)
  PaGlobal_MiniGame_Timing_All._ui.stc_resultGood:SetShow(false)
  PaGlobal_MiniGame_Timing_All._ui.stc_resultBad:SetShow(false)
  PaGlobal_MiniGame_Timing_All_Open()
end
function PaGlobal_MiniGame_Timing_All_EndGame()
  PaGlobal_MiniGame_Timing_All_Close()
end
function PaGlobal_MiniGame_Timing_All_GameUpdate(deltaTime)
  if PaGlobal_MiniGame_Timing_All._playMode == 1 then
    PaGlobal_MiniGame_Timing_All:playingUpdate(deltaTime)
  elseif PaGlobal_MiniGame_Timing_All._playMode == 2 then
    PaGlobal_MiniGame_Timing_All:endTimeUpdate(deltaTime)
  end
end
function FromClient_Minigame_Timing_All_OnScreenSize()
  if nil == Panel_MiniGame_Timing_All then
    return
  end
  Panel_MiniGame_Timing_All:ComputePos()
  Panel_MiniGame_Timing_All:SetPosX(getScreenSizeX() / 2 + 200)
  Panel_MiniGame_Timing_All:SetPosY(getScreenSizeY() / 2 - 150)
end
function FromClient_Minigame_Timing_All_Freeze(keyType)
  if true == PaGlobal_MiniGame_Timing_All._isConsole and false == PaGlobal_MiniGame_Timing_All._isGameStart then
    return
  end
  local isKeyPressed = false
  if true == PaGlobal_MiniGame_Timing_All._isConsole then
    isKeyPressed = keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Jump)
  else
    isKeyPressed = CppEnums.MiniGameKeyType.MiniGameKeyType_Space == keyType
  end
  if true == isKeyPressed and Panel_MiniGame_Timing_All:IsShow() and false == PaGlobal_MiniGame_Timing_All._isPressed then
    local minValue = PaGlobal_MiniGame_Timing_All._ui.stc_timing:GetPosY() - PaGlobal_MiniGame_Timing_All._ui.progress_timing:GetPosY()
    local maxValue = minValue + PaGlobal_MiniGame_Timing_All._ui.stc_timing:GetSizeY()
    local checkPos = PaGlobal_MiniGame_Timing_All._ui.stc_timingProgress_head:GetPosY() + PaGlobal_MiniGame_Timing_All._ui.stc_timingProgress_head:GetSizeY() / 2
    PaGlobal_MiniGame_Timing_All._playMode = 2
    PaGlobal_MiniGame_Timing_All._sumTime = 0
    isWin = minValue <= checkPos and maxValue >= checkPos
    _AudioPostEvent_SystemUiForXBOX(50, 1)
    if isWin then
      audioPostEvent_SystemUi(11, 1)
      _AudioPostEvent_SystemUiForXBOX(11, 1)
      PaGlobal_MiniGame_Timing_All:endAnimation(PaGlobal_MiniGame_Timing_All._ui.txt_resultText, PaGlobal_MiniGame_Timing_All._ui.stc_resultGood, Defines.Color.C_FF96D4FC, PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_TIMING_GOODTIMING"), "Good")
      getSelfPlayer():get():SetMiniGameResult(0)
    else
      audioPostEvent_SystemUi(11, 2)
      _AudioPostEvent_SystemUiForXBOX(11, 2)
      PaGlobal_MiniGame_Timing_All:endAnimation(PaGlobal_MiniGame_Timing_All._ui.txt_resultText, PaGlobal_MiniGame_Timing_All._ui.stc_resultBad, Defines.Color.C_FFF26A6A, PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_ROPE_FAILED"), "Bad")
      getSelfPlayer():get():SetMiniGameResult(1)
    end
    PaGlobal_MiniGame_Timing_All._isPressed = true
  end
end
