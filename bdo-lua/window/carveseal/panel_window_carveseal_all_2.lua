function HandleEventLUp_CaveSeal_All_Close()
  PaGlobal_CaveSeal_All:prepareClose()
end
function HandleEventLUp_CaveSeal_All_Select(selectIndex)
  PaGlobal_CaveSeal_All._selectSlot = selectIndex
end
function HandleEventLUp_CaveSeal_All_CarveSeal()
  local selectData = PaGlobal_CaveSeal_All._slotList[PaGlobal_CaveSeal_All._selectSlot]
  ToClient_CarveSealRequest(PaGlobal_CaveSeal_All._inventoryTypeUseItem, PaGlobal_CaveSeal_All._slotNoUseItem, selectData._invenType, selectData._slotNo, true)
end
function HandleEventLUp_CaveSeal_All_ResetSeal()
  local selectData = PaGlobal_CaveSeal_All._slotList[PaGlobal_CaveSeal_All._selectSlot]
  ToClient_CarveSealRequest(PaGlobal_CaveSeal_All._inventoryTypeUseItem, PaGlobal_CaveSeal_All._slotNoUseItem, selectData._invenType, selectData._slotNo, false)
end
function HandleEventOn_CaveSeal_All_TooltipShow(index)
  local slotdata = PaGlobal_CaveSeal_All._slotList[index]
  if nil == slotdata then
    return
  end
  local itemWrapper = getInventoryItemByType(slotdata._invenType, slotdata._slotNo)
  local control = PaGlobal_CaveSeal_All._ui._list2:GetContentByKey(toInt64(0, index))
  if nil == itemWrapper or nil == control then
    return
  end
  local itemSlot = UI.getChildControl(control, "Static_ItemSlotBg")
  Panel_Tooltip_Item_Show(itemWrapper:getStaticStatus(), itemSlot, true, false)
end
function HandleEventOut_CaveSeal_All_TooltipHide()
  Panel_Tooltip_Item_hideTooltip()
end
function HandleEventPad_CaveSeal_All_CarveAndSeal()
  if PaGlobal_CaveSeal_All._eType.carve == PaGlobal_CaveSeal_All._sealType then
    HandleEventLUp_CaveSeal_All_CarveSeal()
  elseif PaGlobal_CaveSeal_All._eType.reset == PaGlobal_CaveSeal_All._sealType then
    HandleEventLUp_CaveSeal_All_ResetSeal()
  end
end
function HandleEventOn_CaveSeal_All_Select(index)
  if nil == index then
    PaGlobal_CaveSeal_All._mouseOnSlot = nil
    return
  end
  PaGlobal_CaveSeal_All._mouseOnSlot = index
end
function HandleEventPad_CaveSeal_All_ShowDetail()
  if nil ~= Panel_Widget_Tooltip_Renew and PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if nil == PaGlobal_CaveSeal_All._mouseOnSlot then
    return
  end
  local slotdata = PaGlobal_CaveSeal_All._slotList[PaGlobal_CaveSeal_All._mouseOnSlot]
  if nil == slotdata then
    return
  end
  local itemWrapper = getInventoryItemByType(slotdata._invenType, slotdata._slotNo)
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0)
end
function FromClient_CaveSeal_All_CarveShow(inventoryType, slotNoSealItem)
  PaGlobal_CaveSeal_All._inventoryTypeUseItem = inventoryType
  PaGlobal_CaveSeal_All._slotNoUseItem = slotNoSealItem
  PaGlobal_CaveSeal_All:prepareOpen(PaGlobal_CaveSeal_All._eType.carve)
end
function FromClient_CaveSeal_All_CarveHide()
  PaGlobal_CaveSeal_All:prepareClose()
end
function FromClient_CaveSeal_All_ResetShow(inventoryType, slotNoReset)
  PaGlobal_CaveSeal_All._inventoryTypeUseItem = inventoryType
  PaGlobal_CaveSeal_All._slotNoUseItem = slotNoReset
  PaGlobal_CaveSeal_All:prepareOpen(PaGlobal_CaveSeal_All._eType.reset)
end
function FromClient_CaveSeal_All_ResetHide()
  PaGlobal_CaveSeal_All:prepareClose()
end
function FromClient_CaveSeal_All_UpdateList()
  if false == Panel_Window_CarveSeal_All:GetShow() then
    return
  end
  PaGlobal_CaveSeal_All:updateList(PaGlobal_CaveSeal_All._sealType)
end
function PaGloabl_CaveSeal_All_ShowAni()
  if nil == Panel_Window_CarveSeal_All then
    return
  end
end
function PaGloabl_CaveSeal_All_HideAni()
  if nil == Panel_Window_CarveSeal_All then
    return
  end
end
function PaGloabl_CaveSeal_All_Close()
  PaGlobal_CaveSeal_All:prepareClose()
end
function PaGlobal_CaveSeal_All_CreateListControl(control, key)
  PaGlobal_CaveSeal_All:createList(control, key)
end
function PaGlobal_CaveSeal_All_InventoryFilter(slotNo, itemWrapper)
  return true
end
