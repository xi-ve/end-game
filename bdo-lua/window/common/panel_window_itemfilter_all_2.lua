function HandleEventMLUp_ItemFilter_Close()
  PaGlobal_ItemFilter_All:prepareClose()
end
function HandleEventMOn_ItemFilter_IconOver(index)
  local slotNo = PaGlobal_ItemFilter_All._slotIdxList[index]
  if nil == slotNo then
    return
  end
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
  if nil == itemWrapper then
    return
  end
  Panel_Tooltip_Item_Show(itemWrapper:getStaticStatus(), PaGlobal_ItemFilter_All._rdo_slots[index], true, false)
end
function HandleEventMOut_ItemFilter_IconOut()
  Panel_Tooltip_Item_hideTooltip()
end
function HandleEventMLUp_ItemFilter_ItemUse()
  local selectIndex
  if true == _ContentsGroup_UsePadSnapping then
    selectIndex = PaGlobal_ItemFilter_All._currentSlotIndex
  else
    selectIndex = PaGlobal_ItemFilter_All:getCheckRadioIndex()
  end
  if nil == selectIndex then
    return
  end
  local slotNo = PaGlobal_ItemFilter_All._slotIdxList[selectIndex]
  if nil == slotNo then
    return
  end
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return
  end
  local requestServantSupplyItem = function(s64_count, slotNo)
    ToClient_requestUseServantSupplyItem(PaGlobal_ItemFilter_All._servantNo, slotNo, s64_count)
  end
  local s64_count = itemWrapper:getCount()
  if s64_count > Defines.s64_const.s64_1 then
    Panel_NumberPad_Show(true, s64_count, slotNo, requestServantSupplyItem)
  else
    ToClient_requestUseServantSupplyItem(PaGlobal_ItemFilter_All._servantNo, slotNo, 1)
  end
end
function HandleEventMLUp_ItemFilter_ItemSelect(index)
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobal_ItemFilter_All._currentSlotIndex = index
  end
  local slotNo = PaGlobal_ItemFilter_All._slotIdxList[index]
  if nil == slotNo then
    return
  end
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
  if nil == itemWrapper then
    return
  end
  PaGlobal_ItemFilter_All:updateItemSpecText(index)
end
function PaGlobal_ItemFilter_All_Open(servantNo, isGuild, type)
  PaGlobal_ItemFilter_All:prepareOpen(servantNo, isGuild, type)
end
function FromClient_ItemFilter_All_UpdateInventory()
  if false == Panel_Window_ItemFilter_All:GetShow() then
    return
  end
  PaGlobal_ItemFilter_All:updateSlot(false)
end
