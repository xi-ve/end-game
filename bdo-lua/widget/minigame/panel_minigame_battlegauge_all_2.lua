function PaGlobal_MiniGame_BattleGauge_All_Open()
  if nil == Panel_MiniGame_Horse_Trained_All then
    return
  end
  PaGlobal_MiniGame_BattleGauge_All:prepareOpen()
end
function PaGlobal_MiniGame_BattleGauge_All_Close()
  if nil == Panel_MiniGame_Horse_Trained_All or false == Panel_MiniGame_Horse_Trained_All:GetShow() then
    return
  end
  PaGlobal_MiniGame_BattleGauge_All:prepareClose()
end
function PaGlobal_MiniGame_BattleGauge_All_StartGame()
  PaGlobal_MiniGame_BattleGauge_All._remainTime = 11
  PaGlobal_MiniGame_BattleGauge_All._currentPercent = 50
  PaGlobal_MiniGame_BattleGauge_All:setProgress(true)
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_middleLine:AddEffect("fUI_Repair01B", true, 0, 0)
  if true == PaGlobal_MiniGame_BattleGauge_All._isConsole then
    PaGlobal_MiniGame_BattleGauge_All._ui.txt_titleText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_XBOX1_BATTLEGAUGE_REPEAT_B"))
  else
    PaGlobal_MiniGame_BattleGauge_All._ui.txt_titleText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MINIGAME_BATTLEGAUGE_TXT_PURPOSE"))
  end
  local actionString = ""
  if getGamePadEnable() then
    PaGlobal_MiniGame_BattleGauge_All._ui.stc_keyguideB:SetShow(true)
    PaGlobal_MiniGame_BattleGauge_All._ui.stc_spacebar:SetShow(false)
  else
    actionString = keyCustom_GetString_ActionKey(PaGlobal_MiniGame_Timing_All._gameOptionActionKey.Jump)
    PaGlobal_MiniGame_BattleGauge_All._ui.txt_spacebarText:SetText(actionString)
  end
  PaGlobal_MiniGame_BattleGauge_All._ui.progress_myGauge:EraseAllEffect()
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_myGauge_head:EraseAllEffect()
  PaGlobal_MiniGame_BattleGauge_All_Open()
end
function PaGlobal_MiniGame_BattleGauge_All_EndGame()
  PaGlobal_MiniGame_BattleGauge_All_Close()
end
function PaGlobal_MiniGame_BattleGauge_All_GameUpdate(deltaTime)
  if true == PaGlobal_MiniGame_BattleGauge_All._isConsole then
    PaGlobal_MiniGame_BattleGauge_All._sumDeltaTime = PaGlobal_MiniGame_BattleGauge_All._sumDeltaTime + deltaTime * 35
  else
    PaGlobal_MiniGame_BattleGauge_All._sumDeltaTime = PaGlobal_MiniGame_BattleGauge_All._sumDeltaTime + deltaTime * 60
  end
  local number, underZero = math.modf(PaGlobal_MiniGame_BattleGauge_All._sumDeltaTime)
  PaGlobal_MiniGame_BattleGauge_All._sumDeltaTime = underZero
  PaGlobal_MiniGame_BattleGauge_All._currentPercent = PaGlobal_MiniGame_BattleGauge_All._currentPercent - number
  PaGlobal_MiniGame_BattleGauge_All:setProgress(false)
  PaGlobal_MiniGame_BattleGauge_All:endCheck(deltaTime)
  PaGlobal_MiniGame_BattleGauge_All:ballUpdate(deltaTime)
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_myGauge_head:AddEffect("fUI_Repair01B", true, 0, 0)
  local string_win = "Win"
  local string_lose = "Lose"
  if true == isGameTypeKR2() then
    string_win = "\230\136\144\229\138\159"
    string_lose = "\229\164\177\232\180\165"
  end
  if PaGlobal_MiniGame_BattleGauge_All._currentPercent >= 50 then
    PaGlobal_MiniGame_BattleGauge_All._ui.btn_currentResult:SetText(string_win)
    PaGlobal_MiniGame_BattleGauge_All._ui.btn_currentResult:SetFontColor(Defines.Color.C_FF3B6491)
  else
    PaGlobal_MiniGame_BattleGauge_All._ui.btn_currentResult:SetText(string_lose)
    PaGlobal_MiniGame_BattleGauge_All._ui.btn_currentResult:SetFontColor(Defines.Color.C_FFC95A40)
  end
end
function FromClient_Minigame_BattleGauge_All_OnScreenSize()
  if nil == Panel_MiniGame_Horse_Trained_All then
    return
  end
  Panel_MiniGame_Horse_Trained_All:ComputePos()
  Panel_MiniGame_Horse_Trained_All:SetPosX(getOriginScreenSizeX() / 2 - Panel_MiniGame_Horse_Trained_All:GetSizeX() / 2)
  Panel_MiniGame_Horse_Trained_All:SetPosY(getOriginScreenSizeY() / 2 - 250)
end
function FromClient_Minigame_BattleGauge_All_KeyPress(keyType)
  if true == PaGlobal_MiniGame_BattleGauge_All._isConsole then
    if __eQuickTimeEventPadType_B == keyType then
      _AudioPostEvent_SystemUiForXBOX(50, 0)
      PaGlobal_MiniGame_BattleGauge_All:gaugeUpdate()
    end
  elseif CppEnums.MiniGameKeyType.MiniGameKeyType_Space == keyType then
    PaGlobal_MiniGame_BattleGauge_All:gaugeUpdate()
  end
end
