function PaGlobalFunc_Tooltip_Item_LinkedItem_All_Open()
  if nil == Panel_Widget_Tooltip_Item_LinkedItem_All then
    return
  end
  PaGlobal_Tooltip_Item_LinkedItem_All:prepareOpen()
end
function PaGlobalFunc_Tooltip_Item_LinkedItem_All_Close()
  if nil == Panel_Widget_Tooltip_Item_LinkedItem_All then
    return
  end
  PaGlobal_Tooltip_Item_LinkedItem_All:prepareClose()
end
function PaGlobalFunc_Tooltip_Item_LinkedItem_All_GetShow()
  if nil == Panel_Widget_Tooltip_Item_LinkedItem_All then
    return
  end
  return Panel_Widget_Tooltip_Item_LinkedItem_All:GetShow()
end
function PaGlobalFunc_Tooltip_Item_LinkedItem_All_GetTarget()
  if nil == Panel_Widget_Tooltip_Item_LinkedItem_All then
    return
  end
  return PaGlobal_Tooltip_Item_LinkedItem_All
end
function HandleEventLUp_Tooltip_Item_LinkedItem_All_HideTooltip()
  if nil == Panel_Widget_Tooltip_Item_LinkedItem_All then
    return
  end
  if Defines.CloseType.eCloseType_Attacked == getCurrentCloseType() then
    return
  end
  if PaGlobalFunc_Tooltip_Item_LinkedItem_All_GetShow() then
    PaGlobalFunc_Tooltip_Item_LinkedItem_All_Close()
  end
  PaGlobal_Tooltip_Control_All._firstTradeInfoData = nil
  PaGlobal_Tooltip_Control_All._secondTradeInfoData = nil
end
function FromClient_ContentsName_updateAppleList(param1)
  if nil == Panel_Widget_Tooltip_Item_LinkedItem_All then
    return
  end
end
