function PaGloabl_PowerControl_All_ShowAni()
  if nil == Panel_MiniGame_PowerControl_All then
    return
  end
end
function PaGloabl_PowerControl_All_HideAni()
  if nil == Panel_MiniGame_PowerControl_All then
    return
  end
end
function PaGloabl_PowerControl_All_OnKeyDown(keyType)
  PaGlobal_PowerControl_All:onKeyDown(keyType)
end
function PaGloabl_PowerControl_All_OnKeyUp(keyType)
  PaGlobal_PowerControl_All:onKeyUp(keyType)
end
function PaGlobal_PowerControl_All_UpdatePerframe(deltaTime)
  PaGlobal_PowerControl_All:updatePerframe(deltaTime)
end
function PaGlobal_PowerControl_All_GetShowPanel()
  if nil == Panel_MiniGame_PowerControl_All then
    return false
  end
  return Panel_MiniGame_PowerControl_All:GetShow()
end
function PaGlobal_PowerControl_All_GameOpen()
  PaGlobal_PowerControl_All:prepareOpen()
end
function PaGlobal_PowerControl_All_GameStart()
  PaGlobal_PowerControl_All:gameStart()
end
function PaGlobal_PowerControl_All_GameEnd()
  PaGlobal_PowerControl_All:gameEnd()
end
function FromClient_PowerControl_All_OnScreenSize()
  if nil == Panel_MiniGame_PowerControl_All then
    return
  end
  Panel_MiniGame_PowerControl_All:ComputePos()
  if true == PaGlobal_PowerControl_All._isConsole then
    Panel_MiniGame_PowerControl_All:SetPosX(getOriginScreenSizeX() * 0.5 - Panel_MiniGame_PowerControl_All:GetSizeX() * 0.5)
    Panel_MiniGame_PowerControl_All:SetPosY(-150)
  end
end
