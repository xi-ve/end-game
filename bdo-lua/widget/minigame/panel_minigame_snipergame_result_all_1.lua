function PaGlobal_MiniGame_SniperGame_Result_All:initialize()
  if nil == Panel_MiniGame_SniperGame_Result_All or true == PaGlobal_MiniGame_SniperGame_Result_All._initialize then
    return
  end
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultBg = UI.getChildControl(Panel_MiniGame_SniperGame_Result_All, "Static_Result_Bg")
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_deviationMark = UI.getChildControl(PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultBg, "Static_DeviationMark")
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_impactPoint = UI.getChildControl(PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_deviationMark, "Static_ImpactPoint")
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultCritical = UI.getChildControl(PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultBg, "StaticText_Critical")
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultMiss = UI.getChildControl(PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultBg, "StaticText_Miss")
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultHit = UI.getChildControl(PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultBg, "StaticText_Hit")
  PaGlobal_MiniGame_SniperGame_Result_All:registerEventHandler()
  PaGlobal_MiniGame_SniperGame_Result_All:validate()
  PaGlobal_MiniGame_SniperGame_Result_All._initialize = true
end
function PaGlobal_MiniGame_SniperGame_Result_All:registerEventHandler()
  if nil == Panel_MiniGame_SniperGame_Result_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Minigame_SniperGame_Result_All_OnScreenSize")
  Panel_MiniGame_SniperGame_Result_All:RegisterUpdateFunc("PaGlobal_MiniGame_SniperGame_Result_All_UpdatePerFrame")
end
function PaGlobal_MiniGame_SniperGame_Result_All:prepareOpen()
  if nil == Panel_MiniGame_SniperGame_Result_All then
    return
  end
  FromClient_Minigame_SniperGame_Result_All_OnScreenSize()
  PaGlobal_MiniGame_SniperGame_Result_All:open()
end
function PaGlobal_MiniGame_SniperGame_Result_All:open()
  if nil == Panel_MiniGame_SniperGame_Result_All or true == Panel_MiniGame_SniperGame_Result_All:GetShow() then
    return
  end
  Panel_MiniGame_SniperGame_Result_All:SetShow(true)
end
function PaGlobal_MiniGame_SniperGame_Result_All:prepareClose()
  if nil == Panel_MiniGame_SniperGame_Result_All or false == Panel_MiniGame_SniperGame_Result_All:GetShow() then
    return
  end
  PaGlobal_MiniGame_SniperGame_Result_All:close()
end
function PaGlobal_MiniGame_SniperGame_Result_All:close()
  if nil == Panel_MiniGame_SniperGame_Result_All or false == Panel_MiniGame_SniperGame_Result_All:GetShow() then
    return
  end
  Panel_MiniGame_SniperGame_Result_All:SetShow(false)
end
function PaGlobal_MiniGame_SniperGame_Result_All:validate()
  if nil == Panel_MiniGame_SniperGame_Result_All then
    return
  end
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultBg:isValidate()
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_deviationMark:isValidate()
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_impactPoint:isValidate()
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultCritical:isValidate()
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultMiss:isValidate()
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultHit:isValidate()
end
function PaGlobal_MiniGame_SniperGame_Result_All:UpdateResultText(resultType, hitPartType)
  if nil == Panel_MiniGame_SniperGame_Result_All then
    return
  end
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultCritical:SetShow(false)
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultMiss:SetShow(false)
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultHit:SetShow(false)
  if 1 == resultType then
    if 1 == hitPartType then
      PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultCritical:SetShow(true)
    elseif 2 == hitPartType then
      PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultHit:SetShow(true)
    elseif 3 == hitPartType then
      PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultHit:SetShow(true)
    else
      PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultMiss:SetShow(true)
    end
  elseif 2 == resultType then
    PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultMiss:SetShow(true)
  else
    PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultMiss:SetShow(true)
  end
end
function PaGlobal_MiniGame_SniperGame_Result_All:UpdateBulletPos(isMissed, deviationDiameter, desiredScreenPos, hittedScreenPos)
  if nil == Panel_MiniGame_SniperGame_Result_All then
    return
  end
  self._impactPosX = nil
  self._impactPosY = nil
  self._ui.stc_deviationMark:SetSize(deviationDiameter, deviationDiameter)
  self._ui.stc_deviationMark:ComputePos()
  local errX = hittedScreenPos.x - desiredScreenPos.x
  local errY = hittedScreenPos.y - desiredScreenPos.y
  local errLength = math.sqrt(errX * errX + errY * errY)
  local aimPaperRadius = self._ui.stc_resultBg:GetSizeX() / 2
  if errLength >= aimPaperRadius - 10 and true == isMissed then
    return false
  end
  self._impactPosX = (deviationDiameter - self._ui.stc_impactPoint:GetSizeX()) / 2 + errX
  self._impactPosY = (deviationDiameter - self._ui.stc_impactPoint:GetSizeY()) / 2 + errY
  self._ui.stc_impactPoint:SetPosXY(self._impactPosX, self._impactPosY)
  self._ui.stc_impactPoint:SetShow(true)
  return true
end
