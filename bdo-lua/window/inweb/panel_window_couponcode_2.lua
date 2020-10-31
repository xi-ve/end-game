function PaGlobalFunc_CouponCode_Open()
  if true == Panel_Window_CouponCode:GetShow() then
    return
  end
  PaGlobal_CouponCode:prepareOpen()
end
function PaGlobalFunc_CouponCode_Close()
  if false == Panel_Window_CouponCode:GetShow() then
    return
  end
  PaGlobal_CouponCode:prepareClose()
end
function PaGlobalFunc_CouponCode_ShowAni()
  UIAni.fadeInSCR_Down(Panel_Window_CouponCode)
  local aniInfo1 = Panel_Window_CouponCode:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_Window_CouponCode:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_CouponCode:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_CouponCode:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_CouponCode:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_CouponCode:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobalFunc_CouponCode_HideAni()
  audioPostEvent_SystemUi(13, 5)
  Panel_Window_CouponCode:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Window_CouponCode, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function FromClient_resetCoherentUIForCouponCode()
  if Panel_Window_CouponCode:GetShow() then
    TooltipSimple_Hide()
    PaGlobalFunc_CouponCode_Close()
  end
end
