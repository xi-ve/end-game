function PaGlobal_UseItem_All_Open()
  if nil == Panel_UseItem_All then
    return
  end
  PaGlobal_UseItem_All:prepareOpen()
end
function PaGlobal_UseItem_All_Close()
  if nil == Panel_UseItem_All then
    return
  end
  PaGlobal_UseItem_All:prepareClose()
end
function PaGlobal_UseItem_All_GetPopupItemWrapper()
  if nil == Panel_UseItem_All then
    return
  end
  return PaGlobal_UseItem_All._popupItemWrapper
end
function PaGlobal_UseItem_All_PopupItem(itemEnchatWrapper, whereType, slotNo, equipSlotNo)
  if nil == Panel_UseItem_All then
    return
  end
  PaGlobal_UseItem_All_Open()
  PaGlobal_UseItem_All:resetUIcontrol()
  PaGlobal_UseItem_All._popupItemWrapper = itemEnchatWrapper
  PaGlobal_UseItem_All._popupItem.selectWhereType = whereType
  PaGlobal_UseItem_All._popupItem.selectSlotNo = slotNo
  PaGlobal_UseItem_All._popupItem.selectEquipNo = equipSlotNo
  PaGlobal_UseItem_All:fillPopupUseItemData(itemEnchatWrapper)
end
function HandleEventLUp_UseItem_All_Close()
  if nil == Panel_UseItem_All then
    return
  end
  PaGlobal_UseItem_All_Close()
end
function HandleEventLUp_UseItem_All_UseItem()
  if nil == Panel_UseItem_All then
    return
  end
  PaGlobal_UseItem_All_Close()
  if true == _ContentsGroup_NewUI_Inventory_All then
    PaGlobalFunc_Inventory_All_UseItemTargetSelf(PaGlobal_UseItem_All._popupItem.selectWhereType, PaGlobal_UseItem_All._popupItem.selectSlotNo, PaGlobal_UseItem_All._popupItem.selectEquipNo)
  else
    Inventory_UseItemTargetSelf(PaGlobal_UseItem_All._popupItem.selectWhereType, PaGlobal_UseItem_All._popupItem.selectSlotNo, PaGlobal_UseItem_All._popupItem.selectEquipNo)
  end
end
function HandleEventLUp_UseItem_All_No()
  if nil == Panel_UseItem_All then
    return
  end
  PaGlobal_UseItem_All_Close()
end
function HandleEventOnOut_UseItem_All_ShowPopupBuffTooltip(isShow, idxBuff)
  if nil == Panel_UseItem_All then
    return
  end
  if false == isShow then
    TooltipCommon_Hide(idxBuff)
    return
  end
  local buffSSW = _popupItemWrapper:getPopupBuffStaticStatusWrapperAt(idxBuff - 1)
  if nil ~= buffSSW then
    TooltipCommon_Show(idxBuff, PaGlobal_UseItem_All._popupItem.slotInfoForBuff[idxBuff], buffSSW:getIconPath(), buffSSW:getDescription(), "")
  end
end
