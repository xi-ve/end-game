function FromClient_resetCoherentUIForEventNotify()
  if nil ~= Panel_EventNotify_All and Panel_EventNotify_All:GetShow() then
    TooltipSimple_Hide()
    PaGloabl_EventNotify_All_Close()
  end
end
function PaGloabl_EventNotify_All_ShowAni()
  if nil == Panel_EventNotify_All then
    return
  end
  UIAni.fadeInSCR_Down(Panel_EventNotify_All)
  local aniInfo1 = Panel_EventNotify_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_EventNotify_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_EventNotify_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_EventNotify_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_EventNotify_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_EventNotify_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGloabl_EventNotify_All_HideAni()
  if nil == Panel_EventNotify_All then
    return
  end
  Panel_EventNotify_All:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_EventNotify_All, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function PaGloabl_EventNotify_All_Close()
  PaGlobal_EventNotify_All:prepareClose()
end
function Panel_EventNotify_All_Open(isDo, isMenu)
  PaGlobal_EventNotify_All:prepareOpen(isDo, isMenu)
end
