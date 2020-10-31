function PaGlobal_MiniGame_BattleGauge_All:initialize()
  if nil == Panel_MiniGame_Horse_Trained_All or true == PaGlobal_MiniGame_BattleGauge_All._initialize then
    return
  end
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_gaugeBG = UI.getChildControl(Panel_MiniGame_Horse_Trained_All, "Static_GaugeBG")
  PaGlobal_MiniGame_BattleGauge_All._ui.progress_myGauge = UI.getChildControl(Panel_MiniGame_Horse_Trained_All, "Progress2_MyGauge")
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_myGauge_head = UI.getChildControl(PaGlobal_MiniGame_BattleGauge_All._ui.progress_myGauge, "Progress2_MyBar_Head")
  PaGlobal_MiniGame_BattleGauge_All._ui.txt_titleText = UI.getChildControl(Panel_MiniGame_Horse_Trained_All, "StaticText_TitleText")
  PaGlobal_MiniGame_BattleGauge_All._ui.txt_remainTimeText = UI.getChildControl(Panel_MiniGame_Horse_Trained_All, "StaticText_RemainTimeText")
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_human = UI.getChildControl(Panel_MiniGame_Horse_Trained_All, "Static_MouseBody_L")
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_horse = UI.getChildControl(Panel_MiniGame_Horse_Trained_All, "Static_MouseBody_R")
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_currentPos = UI.getChildControl(Panel_MiniGame_Horse_Trained_All, "Slider_FakeProgressGuide")
  PaGlobal_MiniGame_BattleGauge_All._ui.btn_currentResult = UI.getChildControl(PaGlobal_MiniGame_BattleGauge_All._ui.stc_currentPos, "Slider_1_Button")
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_middleLine = UI.getChildControl(Panel_MiniGame_Horse_Trained_All, "Static_MiddleLine")
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_gong = UI.getChildControl(Panel_MiniGame_Horse_Trained_All, "Static_Gong")
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_spacebar = UI.getChildControl(Panel_MiniGame_Horse_Trained_All, "Static_SpaceBar")
  PaGlobal_MiniGame_BattleGauge_All._ui.txt_spacebarText = UI.getChildControl(PaGlobal_MiniGame_BattleGauge_All._ui.stc_spacebar, "StaticText_Space")
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_keyguideB = UI.getChildControl(Panel_MiniGame_Horse_Trained_All, "Static_Console_Control_BG")
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_resultSuccess = UI.getChildControl(Panel_MiniGame_Horse_Trained_All, "Static_Result_Success")
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_resultFailed = UI.getChildControl(Panel_MiniGame_Horse_Trained_All, "Static_Result_Failed")
  for k = 1, 50 do
    local ball = UI.createControl(__ePAUIControl_Static, PaGlobal_MiniGame_BattleGauge_All._ui.progress_myGauge, "ball_" .. tostring(k))
    CopyBaseProperty(PaGlobal_MiniGame_BattleGauge_All._ui.stc_gong, ball)
    PaGlobal_MiniGame_BattleGauge_All._ballGroup[k] = ball
    ball:SetPosY(7)
  end
  FromClient_Minigame_BattleGauge_All_OnScreenSize()
  PaGlobal_MiniGame_BattleGauge_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_MiniGame_BattleGauge_All:registerEventHandler()
  PaGlobal_MiniGame_BattleGauge_All:validate()
  PaGlobal_MiniGame_BattleGauge_All._initialize = true
end
function PaGlobal_MiniGame_BattleGauge_All:registerEventHandler()
  if nil == Panel_MiniGame_Horse_Trained_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Minigame_BattleGauge_All_OnScreenSize")
  registerEvent("EventActionMiniGameKeyDownOnce", "FromClient_Minigame_BattleGauge_All_KeyPress")
  if true == PaGlobal_MiniGame_BattleGauge_All._isConsole then
    registerEvent("EventActionMiniGamePadDownOnce", "FromClient_Minigame_BattleGauge_All_KeyPress")
  end
end
function PaGlobal_MiniGame_BattleGauge_All:prepareOpen()
  if nil == Panel_MiniGame_Horse_Trained_All then
    return
  end
  if true == PaGlobal_MiniGame_BattleGauge_All._isConsole then
    PaGlobal_ConsoleQuickMenu:widgetClose()
  end
  _AudioPostEvent_SystemUiForXBOX(50, 1)
  Panel_MiniGame_Horse_Trained_All:RegisterUpdateFunc("Panel_Minigame_UpdateFunc")
  PaGlobal_MiniGame_BattleGauge_All:open()
end
function PaGlobal_MiniGame_BattleGauge_All:open()
  if nil == Panel_MiniGame_Horse_Trained_All or true == Panel_MiniGame_Horse_Trained_All:GetShow() then
    return
  end
  Panel_MiniGame_Horse_Trained_All:SetShow(true)
end
function PaGlobal_MiniGame_BattleGauge_All:prepareClose()
  if nil == Panel_MiniGame_Horse_Trained_All or false == Panel_MiniGame_Horse_Trained_All:GetShow() then
    return
  end
  if true == PaGlobal_MiniGame_BattleGauge_All._isConsole then
    PaGlobal_ConsoleQuickMenu:widgetOpen()
  end
  Panel_MiniGame_Horse_Trained_All:ClearUpdateLuaFunc()
  PaGlobal_MiniGame_BattleGauge_All:close()
end
function PaGlobal_MiniGame_BattleGauge_All:close()
  if nil == Panel_MiniGame_Horse_Trained_All or false == Panel_MiniGame_Horse_Trained_All:GetShow() then
    return
  end
  Panel_MiniGame_Horse_Trained_All:SetShow(false)
end
function PaGlobal_MiniGame_BattleGauge_All:setProgress(isSetProgress)
  if PaGlobal_MiniGame_BattleGauge_All._currentPercent < 0 then
    PaGlobal_MiniGame_BattleGauge_All._currentPercent = 0
  elseif PaGlobal_MiniGame_BattleGauge_All._currentPercent > 100 then
    PaGlobal_MiniGame_BattleGauge_All._currentPercent = 100
  end
  PaGlobal_MiniGame_BattleGauge_All._ui.progress_myGauge:SetProgressRate(PaGlobal_MiniGame_BattleGauge_All._currentPercent)
  if isSetProgress then
    PaGlobal_MiniGame_BattleGauge_All._ui.progress_myGauge:SetCurrentProgressRate(PaGlobal_MiniGame_BattleGauge_All._currentPercent)
  end
  PaGlobal_MiniGame_BattleGauge_All:setCurrentPosIcon()
end
function PaGlobal_MiniGame_BattleGauge_All:setCurrentPosIcon()
  local startPos = PaGlobal_MiniGame_BattleGauge_All._ui.stc_gaugeBG:GetPosX() - PaGlobal_MiniGame_BattleGauge_All._ui.btn_currentResult:GetSizeX() / 2
  local endPos = startPos + PaGlobal_MiniGame_BattleGauge_All._ui.stc_gaugeBG:GetSizeX()
  local normalizedPercent = PaGlobal_MiniGame_BattleGauge_All._currentPercent / 100
  local controlPos = Util.Math.Lerp(startPos, endPos, normalizedPercent)
  PaGlobal_MiniGame_BattleGauge_All._ui.btn_currentResult:SetPosX(controlPos)
end
function PaGlobal_MiniGame_BattleGauge_All:ballUpdate(deltaTime)
  for _, value in pairs(PaGlobal_MiniGame_BattleGauge_All._ballGroup) do
    if value:GetShow() then
      value:SetPosX(value:GetPosX() + value:GetSizeX())
      if PaGlobal_MiniGame_BattleGauge_All._ui.progress_myGauge:GetSizeX() * PaGlobal_MiniGame_BattleGauge_All._currentPercent / 100 <= value:GetPosX() + value:GetSizeX() then
        value:SetShow(false)
      end
    end
  end
end
function PaGlobal_MiniGame_BattleGauge_All:endCheck(deltaTime)
  PaGlobal_MiniGame_BattleGauge_All._remainTime = PaGlobal_MiniGame_BattleGauge_All._remainTime - deltaTime
  local remainSec = math.floor(PaGlobal_MiniGame_BattleGauge_All._remainTime)
  if PaGlobal_MiniGame_BattleGauge_All._remainTime > 0 then
    PaGlobal_MiniGame_BattleGauge_All._ui.txt_remainTimeText:SetText(remainSec .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND"))
  elseif PaGlobal_MiniGame_BattleGauge_All._remainTime <= 0 then
    if PaGlobal_MiniGame_BattleGauge_All._currentPercent >= 50 then
      audioPostEvent_SystemUi(11, 1)
      _AudioPostEvent_SystemUiForXBOX(11, 1)
      getSelfPlayer():get():SetMiniGameResult(0)
    else
      audioPostEvent_SystemUi(11, 2)
      _AudioPostEvent_SystemUiForXBOX(11, 1)
      getSelfPlayer():get():SetMiniGameResult(3)
    end
    PaGlobal_MiniGame_BattleGauge_All_EndGame()
  end
end
function PaGlobal_MiniGame_BattleGauge_All:gaugeUpdate()
  if true == PaGlobal_MiniGame_BattleGauge_All._isConsole then
    PaGlobal_MiniGame_BattleGauge_All._currentPercent = PaGlobal_MiniGame_BattleGauge_All._currentPercent + 6
  else
    PaGlobal_MiniGame_BattleGauge_All._currentPercent = PaGlobal_MiniGame_BattleGauge_All._currentPercent + 4.8
  end
  PaGlobal_MiniGame_BattleGauge_All:setProgress(false)
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_spacebar:ResetVertexAni()
  PaGlobal_MiniGame_BattleGauge_All._ui.progress_myGauge:ResetVertexAni()
  PaGlobal_MiniGame_BattleGauge_All._ui.progress_myGauge:SetVertexAniRun("Ani_Color_myGaugeEff", true)
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_myGauge_head:EraseAllEffect()
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_myGauge_head:AddEffect("fUI_Repair01B", true, 0, 0)
  PaGlobal_MiniGame_BattleGauge_All._ballGroup[PaGlobal_MiniGame_BattleGauge_All._ball_Index]:SetShow(true)
  PaGlobal_MiniGame_BattleGauge_All._ballGroup[PaGlobal_MiniGame_BattleGauge_All._ball_Index]:SetPosX(0)
  PaGlobal_MiniGame_BattleGauge_All._ball_Index = PaGlobal_MiniGame_BattleGauge_All._ball_Index + 1
  if PaGlobal_MiniGame_BattleGauge_All._ball_Index > 50 then
    PaGlobal_MiniGame_BattleGauge_All._ball_Index = 1
  end
end
function PaGlobal_MiniGame_BattleGauge_All:validate()
  if nil == Panel_MiniGame_Horse_Trained_All then
    return
  end
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_gaugeBG:isValidate()
  PaGlobal_MiniGame_BattleGauge_All._ui.progress_myGauge:isValidate()
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_myGauge_head:isValidate()
  PaGlobal_MiniGame_BattleGauge_All._ui.txt_titleText:isValidate()
  PaGlobal_MiniGame_BattleGauge_All._ui.txt_remainTimeText:isValidate()
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_human:isValidate()
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_horse:isValidate()
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_currentPos:isValidate()
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_middleLine:isValidate()
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_gong:isValidate()
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_spacebar:isValidate()
  PaGlobal_MiniGame_BattleGauge_All._ui.txt_spacebarText:isValidate()
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_keyguideB:isValidate()
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_resultSuccess:isValidate()
  PaGlobal_MiniGame_BattleGauge_All._ui.stc_resultFailed:isValidate()
end
