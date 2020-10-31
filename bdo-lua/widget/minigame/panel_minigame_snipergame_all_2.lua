function PaGlobal_MiniGame_SniperGame_All_Open()
  if nil == Panel_MiniGame_SniperGame_All then
    return
  end
  PaGlobal_MiniGame_SniperGame_All:prepareOpen()
end
function PaGlobal_MiniGame_SniperGame_All_Close()
  if nil == Panel_MiniGame_SniperGame_All or false == Panel_MiniGame_SniperGame_All:GetShow() then
    return
  end
  PaGlobal_MiniGame_SniperGame_All:prepareClose()
end
function PaGlobal_MiniGame_SniperGame_All_UpdatePerFrame(deltaTime)
  PaGlobal_MiniGame_SniperGame_All:UpdatePerFrame(deltaTime)
end
function PaGlobal_MiniGame_SniperGame_All_StartShootingAnimation(duration, scaleRate)
  if nil == Panel_MiniGame_SniperGame_All then
    return
  end
  local control = PaGlobal_MiniGame_SniperGame_All._ui._hole
  local anim1 = control:addMoveAnimation(0, duration, 4)
  anim1:SetStartPosition(control:GetPosX(), control:GetPosY())
  anim1:SetEndPosition(control:GetPosX() - control:GetSizeX() * scaleRate * 0.5, control:GetPosY() - control:GetSizeY() * scaleRate * 0.5)
  local anim2 = control:addScaleAnimation(0, duration, 4)
  anim2:SetStartScale(1)
  anim2:SetEndScale(1 + scaleRate)
end
function PaGlobal_MiniGame_SniperGame_All_StartAimMiniGame()
  if nil == Panel_MiniGame_SniperGame_All then
    return
  end
  PaGlobal_MiniGame_SniperGame_All._holeAniSpeed = 100
  PaGlobal_MiniGame_SniperGame_All._ui._crossHair:SetShow(true)
  PaGlobal_MiniGame_SniperGame_All._ui._deviationMark:SetShow(true)
end
function PaGlobal_MiniGame_SniperGame_All_EndAimMiniGame()
  if nil == Panel_MiniGame_SniperGame_All then
    return
  end
  PaGlobal_MiniGame_SniperGame_All._ui._crossHair:SetShow(false)
  PaGlobal_MiniGame_SniperGame_All._ui._deviationMark:SetShow(false)
  PaGlobal_MiniGame_SniperGame_All:setHoleTarget(getScreenSizeX() * 0.5, getScreenSizeY() * 0.5)
end
function PaGlobal_MiniGame_SniperGame_All_StartSearchMode(withAnimation)
  if nil == Panel_MiniGame_SniperGame_All then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  PaGlobal_MiniGame_SniperGame_All._ui._crossHair:SetShow(false)
  PaGlobal_MiniGame_SniperGame_All._ui._deviationMark:SetShow(false)
  PaGlobal_MiniGame_SniperGame_All._startAniIsPlaying = false
  FromClient_Minigame_SniperGame_All_OnScreenSize()
  PaGlobal_MiniGame_SniperGame_All:UpdatePerFrame(0)
  if withAnimation then
    PaGlobal_MiniGame_SniperGame_All_FadeOut()
  end
  PaGlobal_MiniGame_SniperGame_All._holeAniSpeed = 500
  PaGlobal_MiniGame_SniperGame_All:setHoleTarget(screenSizeX * 0.5, screenSizeY * 0.5)
  PaGlobal_MiniGame_SniperGame_All:prepareOpen()
end
function PaGlobal_MiniGame_SniperGame_All_FadeIn()
  if nil == Panel_MiniGame_SniperGame_All then
    return
  end
  PaGlobal_MiniGame_SniperGame_All:prepareOpen()
  PaGlobal_MiniGame_SniperGame_All._startAniIsPlaying = true
  PaGlobal_MiniGame_SniperGame_All._holeAniSpeed = 500
  PaGlobal_MiniGame_SniperGame_All._ui._hole:SetPosXY(getScreenSizeX() * 0.8 - PaGlobal_MiniGame_SniperGame_All._holeSize * 0.5, getScreenSizeY())
  PaGlobal_MiniGame_SniperGame_All._ui._hole:SetShow(true)
  PaGlobal_MiniGame_SniperGame_All._ui._hole:SetAlphaExtraChild(0)
  PaGlobal_MiniGame_SniperGame_All._ui._fadeCircle:SetAlpha(1)
  PaGlobal_MiniGame_SniperGame_All._ui._fadeCircle:ComputePos()
  PaGlobal_MiniGame_SniperGame_All._ui._fadeCircle:SetShow(true)
  PaGlobal_MiniGame_SniperGame_All:ShowFade()
  PaGlobal_MiniGame_SniperGame_All:FadeIn()
  PaGlobal_MiniGame_SniperGame_All._ui._breathContainer:SetShow(false)
  PaGlobal_MiniGame_SniperGame_All._lensDistortionPower = 1
end
function PaGlobal_MiniGame_SniperGame_All_FadeOut()
  if nil == Panel_MiniGame_SniperGame_All then
    return
  end
  PaGlobal_MiniGame_SniperGame_All._lensDistortionPower = 1.3
  PaGlobal_MiniGame_SniperGame_All:FadeOut()
  PaGlobal_MiniGame_SniperGame_All._ui._hole:SetAlphaExtraChild(1)
  PaGlobal_MiniGame_SniperGame_All._ui._fadeCircle:SetShow(false)
end
function FromClient_Minigame_SniperGame_All_OnScreenSize()
  if nil == Panel_MiniGame_SniperGame_All then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  Panel_MiniGame_SniperGame_All:SetSize(screenSizeX, screenSizeY)
  Panel_MiniGame_SniperGame_All:SetPosXY(0, 0)
  PaGlobal_MiniGame_SniperGame_All.centerX = Panel_MiniGame_SniperGame_All:GetSizeX() * 0.5
  PaGlobal_MiniGame_SniperGame_All.centerY = Panel_MiniGame_SniperGame_All:GetSizeY() * 0.5
  local holeSize = screenSizeY * 2.5
  PaGlobal_MiniGame_SniperGame_All._holeSize = screenSizeY * 2.5
  PaGlobal_MiniGame_SniperGame_All._ui._hole:SetSize(holeSize, holeSize)
  PaGlobal_MiniGame_SniperGame_All._ui._breathContainer:ComputePos()
  PaGlobal_MiniGame_SniperGame_All._ui._fade:SetSize(screenSizeX, screenSizeY)
  PaGlobal_MiniGame_SniperGame_All._ui._fade:SetPosXY(0, 0)
  PaGlobal_MiniGame_SniperGame_All._ui._fadeCircle:SetSize(screenSizeX * 1.3, screenSizeX * 1.3)
  PaGlobal_MiniGame_SniperGame_All._ui._blackboxes[1]:SetSize(screenSizeX + holeSize * 3, holeSize)
  PaGlobal_MiniGame_SniperGame_All._ui._blackboxes[2]:SetSize(holeSize, screenSizeY + holeSize * 3)
  PaGlobal_MiniGame_SniperGame_All._ui._blackboxes[3]:SetSize(screenSizeX + holeSize * 3, holeSize)
  PaGlobal_MiniGame_SniperGame_All._ui._blackboxes[4]:SetSize(holeSize, screenSizeY + holeSize * 3)
  PaGlobal_MiniGame_SniperGame_All._ui._blackboxes[1]:SetSpanSize(0, -(holeSize - 5))
  PaGlobal_MiniGame_SniperGame_All._ui._blackboxes[2]:SetSpanSize(-(holeSize - 5), 0)
  PaGlobal_MiniGame_SniperGame_All._ui._blackboxes[3]:SetSpanSize(0, -(holeSize - 5))
  PaGlobal_MiniGame_SniperGame_All._ui._blackboxes[4]:SetSpanSize(-(holeSize - 5), 0)
  PaGlobal_MiniGame_SniperGame_All._ui._blackboxes[1]:ComputePos()
  PaGlobal_MiniGame_SniperGame_All._ui._blackboxes[2]:ComputePos()
  PaGlobal_MiniGame_SniperGame_All._ui._blackboxes[3]:ComputePos()
  PaGlobal_MiniGame_SniperGame_All._ui._blackboxes[4]:ComputePos()
end
