function HandleEventOn_SA_Widget_Looting_Equip_ShowGeneralToolTip(index, isOn)
  UI.ASSERT_NAME(nil ~= index, "HandleEventOn_SA_Widget_Looting_Equip_ShowGeneralToolTip\236\157\152 index nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= isOn, "HandleEventOn_SA_Widget_Looting_Equip_ShowGeneralToolTip\236\157\152 isOn nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
end
function HandleEventLUp_SA_Widget_Looting_Equip_EquipClick(whereType, slotNo)
  UI.ASSERT_NAME(nil ~= whereType, "HandleEventLUp_SA_Widget_Looting_Equip_EquipClick\236\157\152 whereType nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= slotNo, "HandleEventLUp_SA_Widget_Looting_Equip_EquipClick\236\157\152 slotNo nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if true == DragManager:isDragging() then
    DragManager:clearInfo()
    return
  end
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local equipType = itemWrapper:getStaticStatus():getEquipType()
  if 16 == equipType or 17 == equipType then
    local accSlotNo = PaGlobal_SA_Widget_Looting_Equip:getAccesoryWorseEquipment_Key(itemWrapper)
    inventoryUseItem(whereType, slotNo, accSlotNo, false)
  else
    inventoryUseItem(whereType, slotNo, nil, true)
  end
end
function FromClient_InventoryUpdate_BetterEquipment()
  PaGlobal_SA_Widget_Looting_Equip:updateBetterEquipment()
end
function PaGlobal_SA_Widget_Looting_Equip_EquipKeyUp()
  if nil ~= PaGlobal_SA_Widget_Looting_Equip._lootingEquipSlotList[1] then
    HandleEventLUp_SA_Widget_Looting_Equip_EquipClick(CppEnums.ItemWhereType.eInstanceInventory, PaGlobal_SA_Widget_Looting_Equip._lootingEquipSlotList[1])
  end
end
function PaGlobal_SA_Widget_Looting_Equip_GetAccesoryWorseEquipment_Key(itemWrapper)
  return PaGlobal_SA_Widget_Looting_Equip:getAccesoryWorseEquipment_Key(itemWrapper)
end
function PaGlobal_SA_Widget_Looting_Equip_ShowAni()
  if nil == Panel_SA_Looting_Equip then
    return
  end
  local panel = Panel_SA_Looting_Equip
  local moveAni = panel:addMoveAnimation(0, 0.2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  moveAni:SetStartPosition(panel:GetPosX() + 30, panel:GetPosY())
  moveAni:SetEndPosition(panel:GetPosX(), panel:GetPosY())
end
function PaGlobal_SA_Widget_Looting_Equip_HideAni()
  if nil == Panel_SA_Looting_Equip then
    return
  end
end
