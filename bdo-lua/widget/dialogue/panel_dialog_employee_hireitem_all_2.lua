function PaGlobal_EmployeeHireItem_ShowToolTip(index)
  local self = PaGlobal_EmployeeHireItem_All
  local itemInfo = self._hireItemList[index]
  if nil == itemInfo then
    return
  end
  local control = self._ui.hireItem_List:GetContentByKey(index)
  local itemIcon = UI.getChildControl(control, "StaticText_BeforeTemplete")
  local npcDialogData = ToClient_GetCurrentDialogData()
  local exchangeItemInfo = npcDialogData:getCurrentDisplayExchangeWrapper():getItemExchangeByNpcStaticStatusWrapperAtIndex(itemInfo.exchangeIndex)
  local itemWrapper = exchangeItemInfo:getNeedItemStaticStatusWrapper()
  Panel_Tooltip_Item_Show(itemWrapper, itemIcon, true, false, nil)
end
function PaGlobal_EmployeeHireItem_HideToolTip()
  Panel_Tooltip_Item_hideTooltip()
end
