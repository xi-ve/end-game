function HandleEventLUp_EventNotifyContent_All_Close()
  PaGlobal_EventNotifyContent_All:prepareClose()
end
function HandleEventLUp_EventNotifyContent_All_PopupUI()
  if false == Panel_EventNotifyContent_All:IsUISubApp() then
    Panel_EventNotifyContent_All:OpenUISubApp()
    PaGlobal_EventNotifyContent_All._ui._btn_Sticker:SetCheck(true)
  else
    Panel_EventNotifyContent_All:CloseUISubApp()
    PaGlobal_EventNotifyContent_All._ui._btn_Sticker:SetCheck(false)
  end
  TooltipSimple_Hide()
end
function PaGlobal_EventNotifyContent_All_IsUISubApp()
  if nil == Panel_EventNotifyContent_All then
    return false
  end
  return Panel_EventNotifyContent_All:IsUISubApp()
end
function HandleEventOnOut_EventNotifyContent_All_PopupUITooltip(isShow)
  if nil == Panel_EventNotifyContent_All or false == isShow or nil == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
  local desc = ""
  if true == Panel_EventNotifyContent_All:IsUISubApp() then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
  else
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
  end
  TooltipSimple_Show(PaGlobal_EventNotifyContent_All._ui._btn_Sticker, name, desc)
end
function FromClient_EventNotifyContent_All_ExecuteLuaFuncByEvent(eventIndex)
  local url = PaGlobal_EventNotifyContent_All:getURL(eventIndex)
  local isType = false
  if isGameTypeTaiwan() or isGameTypeTR() or isGameTypeTH() or isGameTypeID() or isGameTypeRussia() then
    isType = true
  else
    isType = false
  end
  PaGlobal_EventNotifyContent_All:setWebURL(url, isType)
  PaGlobal_EventNotifyContent_All:prepareOpen()
end
function PaGloabl_EventNotifyContent_All_ShowAni()
  if nil == Panel_EventNotifyContent_All then
    return
  end
  UIAni.fadeInSCR_Down(Panel_EventNotifyContent_All)
  local aniInfo1 = Panel_EventNotifyContent_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_EventNotifyContent_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_EventNotifyContent_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_EventNotifyContent_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_EventNotifyContent_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_EventNotifyContent_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGloabl_EventNotifyContent_All_HideAni()
  if nil == Panel_EventNotifyContent_All then
    return
  end
  Panel_EventNotifyContent_All:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_EventNotifyContent_All, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function PaGlobal_EventNotifyContent_All_Close()
  PaGlobal_EventNotifyContent_All:prepareClose()
end
