function PaGlobal_MiniGame_SniperGame_Result_All_Open()
  if nil == Panel_MiniGame_SniperGame_Result_All then
    return
  end
  PaGlobal_MiniGame_SniperGame_Result_All:prepareOpen()
end
function PaGlobal_MiniGame_SniperGame_Result_All_Close()
  if nil == Panel_MiniGame_SniperGame_Result_All or false == Panel_MiniGame_SniperGame_Result_All:GetShow() then
    return
  end
  PaGlobal_MiniGame_SniperGame_Result_All:prepareClose()
end
function PaGlobal_MiniGame_SniperGame_Result_All_ClearResult()
  if nil == Panel_MiniGame_SniperGame_Result_All then
    return
  end
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_impactPoint:SetShow(false)
  PaGlobal_MiniGame_SniperGame_Result_All:UpdateResultText(3, nil)
end
function PaGlobal_MiniGame_SniperGame_Result_All_UpdateShootResult(deviationDiameter, desiredScreenPos, hittedScreenPos, hitPartType)
  if nil == Panel_MiniGame_SniperGame_Result_All then
    return
  end
  PaGlobal_MiniGame_SniperGame_Result_All:UpdateBulletPos(false, deviationDiameter, desiredScreenPos, hittedScreenPos)
  PaGlobal_MiniGame_SniperGame_Result_All:UpdateResultText(1, hitPartType)
end
function PaGlobal_MiniGame_SniperGame_Result_All_UpdateMissResult(deviationDiameter, desiredScreenPos, hittedScreenPos)
  if nil == Panel_MiniGame_SniperGame_Result_All then
    return
  end
  local isBulletPosSet = PaGlobal_MiniGame_SniperGame_Result_All:UpdateBulletPos(true, deviationDiameter, desiredScreenPos, hittedScreenPos)
  if true == isBulletPosSet then
    PaGlobal_MiniGame_SniperGame_Result_All:UpdateResultText(2, nil)
  else
    PaGlobal_MiniGame_SniperGame_Result_All:UpdateResultText(3, nil)
  end
end
function FromClient_Minigame_SniperGame_Result_All_OnScreenSize()
  if nil == Panel_MiniGame_SniperGame_Result_All then
    return
  end
  Panel_MiniGame_SniperGame_Result_All:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_MiniGame_SniperGame_Result_All:SetPosXY(0, 0)
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultBg:ComputePos()
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_deviationMark:ComputePos()
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultCritical:ComputePos()
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultMiss:ComputePos()
  PaGlobal_MiniGame_SniperGame_Result_All._ui.stc_resultHit:ComputePos()
end
