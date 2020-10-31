function PaGlobal_MiniGame_GradientY_All:initialize()
  if nil == Panel_Minigame_GradientY_All or true == PaGlobal_MiniGame_GradientY_All._initialize then
    return
  end
  PaGlobal_MiniGame_GradientY_All._ui.stc_gaugeBG = UI.getChildControl(Panel_Minigame_GradientY_All, "Static_GradientY_BG")
  PaGlobal_MiniGame_GradientY_All._ui.stc_gaugeBar = UI.getChildControl(Panel_Minigame_GradientY_All, "Static_GradientY_Cur")
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyUp = UI.getChildControl(Panel_Minigame_GradientY_All, "Static_Key_Up")
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyUpEff = UI.getChildControl(Panel_Minigame_GradientY_All, "Static_Key_Up_Eff")
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyDown = UI.getChildControl(Panel_Minigame_GradientY_All, "Static_Key_Down")
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyDownEff = UI.getChildControl(Panel_Minigame_GradientY_All, "Static_Key_Down_Eff")
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyguideUp = UI.getChildControl(Panel_Minigame_GradientY_All, "Static_Keyguide_Up")
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyguideDown = UI.getChildControl(Panel_Minigame_GradientY_All, "Static_Keyguide_Down")
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyguideUpEff = UI.getChildControl(Panel_Minigame_GradientY_All, "Static_Keyguide_Up_Eff")
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyguideDownEff = UI.getChildControl(Panel_Minigame_GradientY_All, "Static_Keyguide_Down_Eff")
  PaGlobal_MiniGame_GradientY_All._ui.stc_resultGood = UI.getChildControl(Panel_Minigame_GradientY_All, "Static_Result_Good")
  PaGlobal_MiniGame_GradientY_All._ui.stc_resultBad = UI.getChildControl(Panel_Minigame_GradientY_All, "Static_Result_Bad")
  PaGlobal_MiniGame_GradientY_All._ui.txt_purposeText = UI.getChildControl(Panel_Minigame_GradientY_All, "StaticText_Purpose")
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyGuide = UI.getChildControl(Panel_Minigame_GradientY_All, "Static_KeyGuide")
  PaGlobal_MiniGame_GradientY_All._ui.txt_keyW = UI.getChildControl(PaGlobal_MiniGame_GradientY_All._ui.stc_keyGuide, "StaticText_W")
  PaGlobal_MiniGame_GradientY_All._ui.txt_keyA = UI.getChildControl(PaGlobal_MiniGame_GradientY_All._ui.stc_keyGuide, "StaticText_A")
  PaGlobal_MiniGame_GradientY_All._ui.txt_keyS = UI.getChildControl(PaGlobal_MiniGame_GradientY_All._ui.stc_keyGuide, "StaticText_S")
  PaGlobal_MiniGame_GradientY_All._ui.txt_keyD = UI.getChildControl(PaGlobal_MiniGame_GradientY_All._ui.stc_keyGuide, "StaticText_D")
  PaGlobal_MiniGame_GradientY_All._isConsole = _ContentsGroup_UsePadSnapping
  if true == PaGlobal_MiniGame_GradientY_All._isConsole then
    PaGlobal_MiniGame_GradientY_All._ui.stc_keyguideUp:SetShow(true)
    PaGlobal_MiniGame_GradientY_All._ui.stc_keyguideDown:SetShow(true)
    PaGlobal_MiniGame_GradientY_All._ui.stc_keyGuide:SetShow(false)
  else
    PaGlobal_MiniGame_GradientY_All._ui.stc_keyUp:SetShow(true)
    PaGlobal_MiniGame_GradientY_All._ui.stc_keyDown:SetShow(true)
  end
  PaGlobal_MiniGame_GradientY_All:registerEventHandler()
  PaGlobal_MiniGame_GradientY_All:validate()
  PaGlobal_MiniGame_GradientY_All._initialize = true
end
function PaGlobal_MiniGame_GradientY_All:registerEventHandler()
  if nil == Panel_Minigame_GradientY_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Minigame_GradientY_All_OnScreenSize")
  registerEvent("EventActionMiniGameKeyDownOnce", "FromClient_Minigame_GradientY_All_KeyPress")
  if true == PaGlobal_MiniGame_GradientY_All._isConsole then
    registerEvent("EventActionMiniGamePadDownOnce", "FromClient_Minigame_GradientY_All_KeyPress")
  end
end
function PaGlobal_MiniGame_GradientY_All:prepareOpen()
  if nil == Panel_Minigame_GradientY_All then
    return
  end
  if true == PaGlobal_MiniGame_GradientY_All._isConsole then
    PaGlobal_ConsoleQuickMenu:widgetClose()
  end
  Panel_Minigame_GradientY_All:RegisterUpdateFunc("Panel_Minigame_UpdateFunc")
  PaGlobal_MiniGame_GradientY_All.isGradientYPlay = true
  PaGlobal_MiniGame_GradientY_All:updateKeyText()
  PaGlobal_MiniGame_GradientY_All:open()
end
function PaGlobal_MiniGame_GradientY_All:open()
  if nil == Panel_Minigame_GradientY_All or true == Panel_Minigame_GradientY_All:GetShow() then
    return
  end
  Panel_Minigame_GradientY_All:SetShow(true)
end
function PaGlobal_MiniGame_GradientY_All:prepareClose()
  if nil == Panel_Minigame_GradientY_All or false == Panel_Minigame_GradientY_All:GetShow() then
    return
  end
  if true == PaGlobal_MiniGame_GradientY_All._isConsole then
    PaGlobal_ConsoleQuickMenu:widgetOpen()
  end
  Panel_Minigame_GradientY_All:ClearUpdateLuaFunc()
  PaGlobal_MiniGame_GradientY_All.isGradientYPlay = false
  PaGlobal_MiniGame_GradientY_All:close()
end
function PaGlobal_MiniGame_GradientY_All:close()
  if nil == Panel_Minigame_GradientY_All or false == Panel_Minigame_GradientY_All:GetShow() then
    return
  end
  Panel_Minigame_GradientY_All:SetShow(false)
end
function PaGlobal_MiniGame_GradientY_All:updateKeyText()
  if true == PaGlobal_MiniGame_GradientY_All._isConsole then
    PaGlobal_MiniGame_GradientY_All._ui.txt_purposeText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_XBOX1_GLOBALMANUAL_HORSEDROP_0"))
  else
    PaGlobal_MiniGame_GradientY_All._ui.txt_purposeText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MINIGAME_GRADIENT_Y_PURPOSE"))
  end
  PaGlobal_MiniGame_GradientY_All._ui.txt_keyW:SetText(keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_MoveFront))
  PaGlobal_MiniGame_GradientY_All._ui.txt_keyA:SetText(keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_MoveLeft))
  PaGlobal_MiniGame_GradientY_All._ui.txt_keyS:SetText(keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_MoveBack))
  PaGlobal_MiniGame_GradientY_All._ui.txt_keyD:SetText(keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_MoveRight))
end
function PaGlobal_MiniGame_GradientY_All:setCurrentPosIcon()
  local startPos = PaGlobal_MiniGame_GradientY_All._ui.stc_gaugeBG:GetPosY() - PaGlobal_MiniGame_GradientY_All._ui.stc_gaugeBar:GetSizeY() / 2
  local endPos = startPos + PaGlobal_MiniGame_GradientY_All._ui.stc_gaugeBG:GetSizeY()
  local controlPos = Util.Math.Lerp(startPos, endPos, PaGlobal_MiniGame_GradientY_All._currentPos)
  PaGlobal_MiniGame_GradientY_All._ui.stc_gaugeBar:SetPosY(controlPos)
end
function PaGlobal_MiniGame_GradientY_All:showGoodResultAni()
  local goodResult = PaGlobal_MiniGame_GradientY_All._ui.stc_resultGood
  local badResult = PaGlobal_MiniGame_GradientY_All._ui.stc_resultBad
  badResult:SetShow(false, true)
  goodResult:SetShow(true, true)
  goodResult:ResetVertexAni()
  goodResult:SetVertexAniRun("Good_Ani", true)
  goodResult:SetVertexAniRun("Good_ScaleAni", true)
end
function PaGlobal_MiniGame_GradientY_All:showBadResultAni()
  local goodResult = PaGlobal_MiniGame_GradientY_All._ui.stc_resultGood
  local badResult = PaGlobal_MiniGame_GradientY_All._ui.stc_resultBad
  badResult:SetShow(true, true)
  goodResult:SetShow(false, true)
  badResult:ResetVertexAni()
  badResult:SetVertexAniRun("Bad_Ani", true)
  badResult:SetVertexAniRun("Bad_ScaleAni", true)
end
function PaGlobal_MiniGame_GradientY_All:showKeyUpAni()
  local keyUp = PaGlobal_MiniGame_GradientY_All._ui.stc_keyUp
  local keyUp_Eff = PaGlobal_MiniGame_GradientY_All._ui.stc_keyUpEff
  if true == PaGlobal_MiniGame_GradientY_All._isConsole then
    keyUp = PaGlobal_MiniGame_GradientY_All._ui.stc_keyguideUp
    keyUp_Eff = PaGlobal_MiniGame_GradientY_All._ui.stc_keyguideUpEff
  end
  keyUp:ResetVertexAni()
  keyUp:SetVertexAniRun("Ani_Color_Up", true)
  keyUp_Eff:SetShow(true)
  keyUp_Eff:ResetVertexAni()
  keyUp_Eff:SetVertexAniRun("Ani_Color_UpEff", true)
end
function PaGlobal_MiniGame_GradientY_All:showKeyDownAni()
  local keyDown = PaGlobal_MiniGame_GradientY_All._ui.stc_keyDown
  local keyDown_Eff = PaGlobal_MiniGame_GradientY_All._ui.stc_keyDownEff
  if true == PaGlobal_MiniGame_GradientY_All._isConsole then
    keyDown = PaGlobal_MiniGame_GradientY_All._ui.stc_keyguideDown
    keyDown_Eff = PaGlobal_MiniGame_GradientY_All._ui.stc_keyguideDownEff
  end
  keyDown:ResetVertexAni()
  keyDown:SetVertexAniRun("Ani_Color_Down", true)
  keyDown_Eff:SetShow(true)
  keyDown_Eff:ResetVertexAni()
  keyDown_Eff:SetVertexAniRun("Ani_Color_DownEff", true)
end
function PaGlobal_MiniGame_GradientY_All:validate()
  if nil == Panel_Minigame_GradientY_All then
    return
  end
  PaGlobal_MiniGame_GradientY_All._ui.stc_gaugeBG:isValidate()
  PaGlobal_MiniGame_GradientY_All._ui.stc_gaugeBar:isValidate()
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyUp:isValidate()
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyUpEff:isValidate()
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyDown:isValidate()
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyDownEff:isValidate()
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyguideUp:isValidate()
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyguideDown:isValidate()
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyguideUpEff:isValidate()
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyguideDownEff:isValidate()
  PaGlobal_MiniGame_GradientY_All._ui.stc_resultGood:isValidate()
  PaGlobal_MiniGame_GradientY_All._ui.stc_resultBad:isValidate()
  PaGlobal_MiniGame_GradientY_All._ui.stc_keyGuide:isValidate()
end
