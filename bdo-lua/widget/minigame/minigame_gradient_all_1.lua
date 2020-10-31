function PaGlobal_MiniGame_Gradient_All:initialize()
  if nil == Panel_Minigame_Gradient_All or true == PaGlobal_MiniGame_Gradient_All._initialize then
    return
  end
  PaGlobal_MiniGame_Gradient_All._ui.stc_mouseBody_L = UI.getChildControl(Panel_Minigame_Gradient_All, "Static_MouseBody_L")
  PaGlobal_MiniGame_Gradient_All._ui.stc_mouseBody_R = UI.getChildControl(Panel_Minigame_Gradient_All, "Static_MouseBody_R")
  PaGlobal_MiniGame_Gradient_All._ui.stc_gaugeBG = UI.getChildControl(Panel_Minigame_Gradient_All, "Static_GaugeBG")
  PaGlobal_MiniGame_Gradient_All._ui.stc_gaugeBar = UI.getChildControl(Panel_Minigame_Gradient_All, "Static_GaugeBar")
  PaGlobal_MiniGame_Gradient_All._ui.stc_resultGood = UI.getChildControl(Panel_Minigame_Gradient_All, "Static_Result_Good")
  PaGlobal_MiniGame_Gradient_All._ui.stc_resultBad = UI.getChildControl(Panel_Minigame_Gradient_All, "Static_Result_Bad")
  PaGlobal_MiniGame_Gradient_All:registerEventHandler()
  PaGlobal_MiniGame_Gradient_All:validate()
  PaGlobal_MiniGame_Gradient_All._initialize = true
end
function PaGlobal_MiniGame_Gradient_All:registerEventHandler()
  if nil == Panel_Minigame_Gradient_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Minigame_Gradient_All_OnScreenSize")
  registerEvent("EventActionMiniGameKeyDownOnce", "FromClient_Minigame_Gradient_All_KeyPress")
end
function PaGlobal_MiniGame_Gradient_All:prepareOpen()
  if nil == Panel_Minigame_Gradient_All then
    return
  end
  Panel_Minigame_Gradient_All:RegisterUpdateFunc("Panel_Minigame_UpdateFunc")
  PaGlobal_MiniGame_Gradient_All.isGradientPlay = true
  PaGlobal_MiniGame_Gradient_All:open()
end
function PaGlobal_MiniGame_Gradient_All:open()
  if nil == Panel_Minigame_Gradient_All or true == Panel_Minigame_Gradient_All:GetShow() then
    return
  end
  Panel_Minigame_Gradient_All:SetShow(true)
end
function PaGlobal_MiniGame_Gradient_All:prepareClose()
  if nil == Panel_Minigame_Gradient_All or false == Panel_Minigame_Gradient_All:GetShow() then
    return
  end
  Panel_Minigame_Gradient_All:ClearUpdateLuaFunc()
  PaGlobal_MiniGame_Gradient_All.isGradientPlay = false
  PaGlobal_MiniGame_Gradient_All:close()
end
function PaGlobal_MiniGame_Gradient_All:close()
  if nil == Panel_Minigame_Gradient_All or false == Panel_Minigame_Gradient_All:GetShow() then
    return
  end
  Panel_Minigame_Gradient_All:SetShow(false)
end
function PaGlobal_MiniGame_Gradient_All:setCurrentPosIcon()
  local startPos = PaGlobal_MiniGame_Gradient_All._ui.stc_gaugeBG:GetPosX() - PaGlobal_MiniGame_Gradient_All._ui.stc_gaugeBar:GetSizeX() / 2
  local endPos = startPos + PaGlobal_MiniGame_Gradient_All._ui.stc_gaugeBG:GetSizeX()
  local controlPos = Util.Math.Lerp(startPos, endPos, PaGlobal_MiniGame_Gradient_All._currentPos)
  PaGlobal_MiniGame_Gradient_All._ui.stc_gaugeBar:SetPosX(controlPos)
end
function PaGlobal_MiniGame_Gradient_All:showGoodResultAni()
  local goodResult = PaGlobal_MiniGame_Gradient_All._ui.stc_resultGood
  local badResult = PaGlobal_MiniGame_Gradient_All._ui.stc_resultBad
  badResult:SetShow(false, true)
  goodResult:SetShow(true, true)
  goodResult:ResetVertexAni()
  goodResult:SetVertexAniRun("Good_Ani", true)
  goodResult:SetVertexAniRun("Good_ScaleAni", true)
end
function PaGlobal_MiniGame_Gradient_All:showBadResultAni()
  local goodResult = PaGlobal_MiniGame_Gradient_All._ui.stc_resultGood
  local badResult = PaGlobal_MiniGame_Gradient_All._ui.stc_resultBad
  badResult:SetShow(true, true)
  goodResult:SetShow(false, true)
  badResult:ResetVertexAni()
  badResult:SetVertexAniRun("Bad_Ani", true)
  badResult:SetVertexAniRun("Bad_ScaleAni", true)
end
function PaGlobal_MiniGame_Gradient_All:validate()
  if nil == Panel_Minigame_Gradient_All then
    return
  end
  PaGlobal_MiniGame_Gradient_All._ui.stc_mouseBody_L:isValidate()
  PaGlobal_MiniGame_Gradient_All._ui.stc_mouseBody_R:isValidate()
  PaGlobal_MiniGame_Gradient_All._ui.stc_gaugeBG:isValidate()
  PaGlobal_MiniGame_Gradient_All._ui.stc_gaugeBar:isValidate()
  PaGlobal_MiniGame_Gradient_All._ui.stc_resultGood:isValidate()
  PaGlobal_MiniGame_Gradient_All._ui.stc_resultBad:isValidate()
end
