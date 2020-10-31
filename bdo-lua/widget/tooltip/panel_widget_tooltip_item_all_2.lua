function PaGlobalFunc_Tooltip_Item_All_Open()
  if nil == Panel_Widget_Tooltip_Item_All then
    return
  end
  PaGlobal_Tooltip_Item_All:prepareOpen()
end
function PaGlobalFunc_Tooltip_Item_All_Close()
  if nil == Panel_Widget_Tooltip_Item_All then
    return
  end
  Panel_Widget_Tooltip_Item_All:CloseUISubApp()
  PaGlobal_Tooltip_Item_All:prepareClose()
end
function PaGlobalFunc_Tooltip_Item_All_GetShow()
  if nil == Panel_Widget_Tooltip_Item_All then
    return
  end
  return Panel_Widget_Tooltip_Item_All:GetShow()
end
function PaGlobalFunc_Tooltip_Item_All_GetTarget()
  if nil == Panel_Widget_Tooltip_Item_All then
    return
  end
  return PaGlobal_Tooltip_Item_All
end
function HandleEventLUp_Tooltip_All_()
  if nil == Panel_Widget_Tooltip_Item_All then
    return
  end
end
function FromClient_Tooltip_All_(param1)
  if nil == Panel_Widget_Tooltip_Item_All then
    return
  end
end
