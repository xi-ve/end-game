function PaGlobalFunc_Tooltip_Item_Equip_All_Open()
  if nil == Panel_Widget_Tooltip_Item_Equip_All then
    return
  end
  PaGlobal_Tooltip_Item_Equip_All:prepareOpen()
end
function PaGlobalFunc_Tooltip_Item_Equip_All_Close()
  if nil == Panel_Widget_Tooltip_Item_Equip_All then
    return
  end
  Panel_Widget_Tooltip_Item_Equip_All:CloseUISubApp()
  PaGlobal_Tooltip_Item_Equip_All:prepareClose()
end
function PaGlobalFunc_Tooltip_Item_Equip_All_GetShow()
  if nil == Panel_Widget_Tooltip_Item_Equip_All then
    return
  end
  return Panel_Widget_Tooltip_Item_Equip_All:GetShow()
end
function PaGlobalFunc_Tooltip_Item_Equip_All_GetTarget()
  if nil == Panel_Widget_Tooltip_Item_Equip_All then
    return
  end
  return PaGlobal_Tooltip_Item_Equip_All
end
function HandleEventLUp_ContentsName_updateAppleList()
  if nil == Panel_ContentsName then
    return
  end
end
function FromClient_ContentsName_updateAppleList(param1)
  if nil == Panel_ContentsName then
    return
  end
end
