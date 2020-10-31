function PaGloabl_ContentsName_ShowAni()
  if nil == Panel_Widget_FarmingTimer_All then
    return
  end
end
function PaGloabl_ContentsName_HideAni()
  if nil == Panel_Widget_FarmingTimer_All then
    return
  end
end
function PaGloabl_FarmingTimer_StartToggle()
  if nil == Panel_Widget_FarmingTimer_All then
    return
  end
  PaGlobal_FarmingTimer:startToggle()
end
function PaGloabl_FarmingTimer_Stop()
  if nil == Panel_Widget_FarmingTimer_All then
    return
  end
  PaGlobal_FarmingTimer:stopBtn()
end
function PaGloabl_FarmingTimer_Reset()
  if nil == Panel_Widget_FarmingTimer_All then
    return
  end
  PaGlobal_FarmingTimer:resetBtn()
end
function PaGloabl_FarmingTimer_Initialize()
  if nil == Panel_Widget_FarmingTimer_All then
    return
  end
  PaGlobal_FarmingTimer:initialize()
end
function PaGloabl_FarmingTimer_Open()
  if nil == Panel_Widget_FarmingTimer_All then
    return
  end
  if true == Panel_Widget_FarmingTimer_All:GetShow() then
    return
  end
  PaGlobal_FarmingTimer:prepareOpen()
end
function PaGloabl_FarmingTimer_Close()
  if nil == Panel_Widget_FarmingTimer_All then
    return
  end
  PaGlobal_FarmingTimer:prepareClose()
end
function PaGloabl_FarmingTimer_Popup()
  if nil == Panel_Widget_FarmingTimer_All then
    return
  end
  PaGlobal_FarmingTimer:popUp()
end
function PaGloabl_FarmingTimer_ShowIconToolTip(isShow, idx)
  if nil == Panel_Widget_FarmingTimer_All then
    return
  end
  PaGlobal_FarmingTimer:showIconToolTip(isShow, idx)
end
function PaGloabl_FarmingTimer_Report()
  if nil == Panel_Widget_FarmingTimer_All then
    return
  end
  PaGlobal_FarmingTimer:reportBtn()
end
function PaGlobalFunc_FarmingTimer_UpdatePerFrame(deltatime)
  if nil == Panel_Widget_FarmingTimer_All then
    return
  end
  PaGlobal_FarmingTimer:update(deltatime)
end
function PaGlobalFunc_FarmingTimer_GetTimer()
  if nil == Panel_Widget_FarmingTimer_All then
    return
  end
  return PaGlobal_FarmingTimer._lastUpdateTime
end
function PaGlobal_FarmingTimer_SetAllMoney(txtMoney)
  if nil == Panel_Widget_FarmingTimer_All then
    return
  end
  PaGlobal_FarmingTimer:setAllMoney(txtMoney)
end
function PaGlobal_FarmingTimer_IsGetShow()
  if nil == Panel_Widget_FarmingTimer_All then
    return false
  end
  return Panel_Widget_FarmingTimer_All:GetShow()
end
function PaGlobal_FarmingTimer_ForceOpen()
  if nil == Panel_Widget_FarmingTimer_All then
    return
  end
  PaGloabl_FarmingTimer_Open()
end
registerEvent("FromClient_luaLoadComplete", "PaGloabl_FarmingTimer_Initialize")
