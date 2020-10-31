function HandleEventLUp_SA_MainFrame_SlotLClick(itemIdx)
  if nil == Panel_SA_MainFrame then
    return
  end
  if nil ~= getSelfPlayer() and CppEnums.ClassType.ClassType_Temp1 == getSelfPlayer():getClassType() or true == PaGlobal_SA_MainFrame._isGameEnd then
    return
  end
  if nil ~= DragManager.dragStartPanel then
    if Panel_SA_MainFrame == DragManager.dragStartPanel then
      PaGlobal_SA_MainFrame:swapSlotItem(DragManager.dragSlotInfo, itemIdx)
      return
    elseif Panel_SA_Widget_Inventory == DragManager.dragStartPanel then
      HandleEvent_SA_MainFrame_DropHandler(itemIdx)
      return
    end
  end
  PaGlobal_SA_MainFrame:useSubItem(itemIdx)
end
function HandleEventLUp_SA_MainFrame_SlotRClick(itemIdx)
  if nil == Panel_SA_MainFrame then
    return
  end
  PaGlobal_SA_MainFrame:clearItemSlot(itemIdx)
end
function HandleEvent_SA_MainFrame_DropHandler(index)
  if nil == Panel_SA_MainFrame then
    return
  end
  local useStartSlot = inventorySlotNoUserStart()
  local slotNo = useStartSlot + index
  if nil == DragManager.dragStartPanel then
    return false
  end
  local isRestricted = checkManufactureAction() or checkAlchemyAction()
  if true == isRestricted then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_CANT_REPOSITIONITEM"))
    return false
  end
  local hasEmptySlot = false
  local emptyIndex = 1
  for slotIndex = 1, PaGlobal_SA_MainFrame._value_item._maxItemCnt do
    if PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[slotIndex].empty then
      hasEmptySlot = true
      emptyIndex = slotIndex
      break
    end
  end
  local fromSlotNo = DragManager.dragSlotInfo
  local itemWrapper = getInventoryItemByType(Inventory_GetCurrentInventoryType(), fromSlotNo)
  if nil == itemWrapper then
    return
  end
  if CppEnums.ItemType.Skill ~= itemWrapper:getStaticStatus():getItemType() then
    DragManager:clearInfo()
    return
  end
  local addItemKey = itemWrapper:getStaticStatus():get()._key:getItemKey()
  local sameIndex = PaGlobal_SA_MainFrame:hasSameItemKey(addItemKey)
  if -1 == sameIndex then
    if false == hasEmptySlot then
      PaGlobal_SA_MainFrame:setItemSlotInfo(index, addItemKey)
    elseif nil ~= PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[index].itemKey then
      PaGlobal_SA_MainFrame:setItemSlotInfo(emptyIndex, PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[index].itemKey)
      PaGlobal_SA_MainFrame:setItemSlotInfo(index, addItemKey)
    else
      PaGlobal_SA_MainFrame:setItemSlotInfo(index, addItemKey)
    end
  elseif nil == PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[index].itemKey then
    PaGlobal_SA_MainFrame:setItemSlotInfo(index, addItemKey)
    PaGlobal_SA_MainFrame:setItemSlotInfo(sameIndex, nil)
  else
    PaGlobal_SA_MainFrame:setItemSlotInfo(sameIndex, PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[index].itemKey)
    PaGlobal_SA_MainFrame:setItemSlotInfo(index, addItemKey)
  end
  DragManager:clearInfo()
  return true
end
function HandleEventPressMove_SA_MainFrame_SlotDrag(index)
  if nil == Panel_SA_MainFrame then
    return
  end
  local itemKey = PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[index].itemKey
  local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil ~= itemWrapper then
    DragManager:setDragInfo(Panel_SA_MainFrame, nil, index, "Icon/" .. itemWrapper:getIconPath(), nil, nil)
  end
end
function FromClient_SA_MainFrame_EndGame()
  if nil == Panel_SA_MainFrame then
    return
  end
  PaGlobal_SA_MainFrame._isGameEnd = true
  Panel_SA_MainFrame:ClearUpdateLuaFunc()
end
function FromClient_SA_MainFrame_AddSkillItem(itemKey, slotNo, itemCount)
  if nil == Panel_SA_MainFrame then
    return
  end
  local hasEmpty, emptyIndex = PaGlobal_SA_MainFrame:hasEmptySlot()
  if nil == itemKey or -1 ~= PaGlobal_SA_MainFrame:hasSameItemKey(itemKey) or false == hasEmpty then
    return
  end
  local itemSSW
  if nil == slotNo then
    itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  else
    local itemWrapper = getInventoryItemByType(Inventory_GetCurrentInventoryType(), slotNo)
    if nil == itemWrapper then
      return
    end
    itemSSW = itemWrapper:getStaticStatus()
  end
  if nil == itemSSW then
    return
  end
  local itemType = itemSSW:getItemType()
  if CppEnums.ItemType.Skill ~= itemType then
    return
  end
  PaGlobal_SA_MainFrame:setItemSlotInfo(emptyIndex, itemKey)
end
function PaGlobal_SA_MainFrame_ShowSubItemToolTip(isShow, idx)
  if nil == Panel_SA_MainFrame then
    return
  end
  if nil == PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].itemKey or false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].itemKey))
  if nil == itemSSW then
    return
  end
  Panel_Tooltip_Item_Show(itemSSW, PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.icon, true, false)
end
function PaGlobal_SA_MainFrame_ItemSlotAddInputEvent()
  if nil == Panel_SA_MainFrame then
    return
  end
  for idx = 1, PaGlobal_SA_MainFrame._value_item._maxItemCnt do
    PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.icon:addInputEvent("Mouse_On", "PaGlobal_SA_MainFrame_ShowSubItemToolTip(true," .. idx .. ")")
    PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.icon:addInputEvent("Mouse_Out", "PaGlobal_SA_MainFrame_ShowSubItemToolTip(false," .. idx .. ")")
    PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.icon:addInputEvent("Mouse_PressMove", "HandleEventPressMove_SA_MainFrame_SlotDrag(" .. idx .. ")")
    PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_SA_MainFrame_SlotLClick(" .. idx .. ")")
    PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.icon:addInputEvent("Mouse_RUp", "HandleEventLUp_SA_MainFrame_SlotRClick(" .. idx .. ")")
  end
end
function PaGlobal_SA_MainFrame_UseSubItem(itemIdx)
  if nil == Panel_SA_MainFrame then
    return
  end
  PaGlobal_SA_MainFrame:useSubItem(itemIdx)
end
function PaGlobal_SA_MainFrame_IsSkillTypeItem()
  if nil == Panel_SA_MainFrame then
    return
  end
  return PaGlobal_SA_MainFrame._value_item._useSkillTypeItem
end
function PaGlobal_SA_MainFrame_SetUseSkillTypeItem(isUse)
  if nil == Panel_SA_MainFrame then
    return
  end
  PaGlobal_SA_MainFrame._value_item._useSkillTypeItem = isUse
end
function PaGlobal_SA_MainFrame_UpdateInventory()
  if nil == Panel_SA_MainFrame then
    return
  end
  PaGlobal_SA_MainFrame:updateInventoryItemData()
  for index = 1, PaGlobal_SA_MainFrame._value_item._maxItemCnt do
    PaGlobal_SA_MainFrame:setItemSlotInfo(index, PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[index].itemKey)
  end
end
function PaGlobal_SA_MainFrame_UpdateItemCoolTime(delta)
  if nil == Panel_SA_MainFrame then
    return
  end
  local isGameStart = 0 < Int64toInt32(ToClient_BattleRoyaleRemainTime())
  if false == isGameStart then
    return
  end
  local inventroyType = Inventory_GetCurrentInventoryType()
  local remainTime = 0
  local itemReuseTime = 0
  local realRemainTime = 0
  local initRemainTime = 0
  for idx = 1, PaGlobal_SA_MainFrame._value_item._maxItemCnt do
    if nil ~= PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx] and 0 < PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].itemCount then
      remainTime = 0
      itemReuseTime = 0
      realRemainTime = 0
      initRemainTime = 0
      if CppEnums.TInventorySlotNoUndefined ~= PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].inventoryIdx then
        remainTime = getItemCooltime(inventroyType, PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].inventoryIdx)
        itemReuseTime = getItemReuseCycle(inventroyType, PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].inventoryIdx) * 0.001
        realRemainTime = remainTime * itemReuseTime
        initRemainTime = realRemainTime - realRemainTime % 1 + 1
      end
      if 0 < remainTime then
        PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.cooltime:UpdateCoolTime(remainTime)
        PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.cooltime:SetShow(true)
        PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.cooltimeText:SetText(PaGlobal_SA_MainFrame_Time_Formatting_ShowTop(initRemainTime))
        if itemReuseTime >= initRemainTime then
          PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.cooltimeText:SetShow(true)
        else
          PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.cooltimeText:SetShow(false)
        end
      elseif PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.cooltime:GetShow() then
        PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.cooltime:SetShow(false)
        PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.cooltimeText:SetShow(false)
        audioPostEvent_SystemUi(2, 1)
      end
    else
      PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.icon:SetMonoTone(true)
      PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.cooltime:SetShow(false)
      PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.cooltimeText:SetShow(false)
    end
  end
end
function PaGlobal_SA_MainFrame:clearItemSlot(idx)
  if nil == Panel_SA_MainFrame then
    return
  end
  PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon:clearItem()
  PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].itemKey = nil
  PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].inventoryIdx = nil
  PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].itemCount = 0
  PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].empty = true
end
function PaGlobal_SA_MainFrame:updateInventoryItemData()
  if nil == Panel_SA_MainFrame then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  PaGlobal_SA_MainFrame._value_item._itemData = {}
  local inventroyType = Inventory_GetCurrentInventoryType()
  local inventroySize = selfPlayer:get():getInventorySlotCount(true) - 1
  for index = 1, inventroySize do
    local itemWrapper = getInventoryItemByType(inventroyType, index)
    if nil ~= itemWrapper and PaGlobal_SA_MainFrame._value_item._allowType == itemWrapper:getStaticStatus():getItemType() then
      local itemKey = itemWrapper:get():getKey():getItemKey()
      if nil == PaGlobal_SA_MainFrame._value_item._itemData[itemKey] then
        PaGlobal_SA_MainFrame._value_item._itemData[itemKey] = {}
      end
      PaGlobal_SA_MainFrame._value_item._itemData[itemKey].itemKey = itemKey
      PaGlobal_SA_MainFrame._value_item._itemData[itemKey]._count = Int64toInt32(itemWrapper:get():getCount_s64())
      PaGlobal_SA_MainFrame._value_item._itemData[itemKey].inventoryIdx = index
    end
  end
end
function PaGlobal_SA_MainFrame:initItemSlotInfo()
  if nil == Panel_SA_MainFrame then
    return
  end
  PaGlobal_SA_MainFrame:updateInventoryItemData()
  for index = 1, PaGlobal_SA_MainFrame._value_item._maxItemCnt do
    local itemKey = ToClient_GetItemKeyByIndex(index)
    if 0 ~= itemKey then
      if nil == PaGlobal_SA_MainFrame._value_item._itemData[itemKey] or 0 >= PaGlobal_SA_MainFrame._value_item._itemData[itemKey]._count then
        PaGlobal_SA_MainFrame:setSlotItemEmpty(index, itemKey)
      else
        PaGlobal_SA_MainFrame:setItemSlotInfo(index, itemKey)
      end
    end
  end
end
function PaGlobal_SA_MainFrame:setItemSlotInfo(idx, itemKey)
  if nil == Panel_SA_MainFrame then
    return
  end
  if nil == itemKey or PaGlobal_SA_MainFrame._value_item._skillBookItemKey == itemKey then
    PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon:clearItem()
    return
  end
  local inventroyType = Inventory_GetCurrentInventoryType()
  local itemWrapper
  if nil ~= PaGlobal_SA_MainFrame._value_item._itemData[itemKey] and nil ~= PaGlobal_SA_MainFrame._value_item._itemData[itemKey].inventoryIdx then
    PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].inventoryIdx = PaGlobal_SA_MainFrame._value_item._itemData[itemKey].inventoryIdx
    itemWrapper = getInventoryItemByType(inventroyType, PaGlobal_SA_MainFrame._value_item._itemData[itemKey].inventoryIdx)
  end
  if nil == itemWrapper then
    PaGlobal_SA_MainFrame:setSlotItemEmpty(idx, itemKey)
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon:clearItem()
  PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].empty = false
  PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].itemKey = itemKey
  PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].itemType = itemSSW:getItemType()
  local inventory = getSelfPlayer():get():getInventoryByType(inventroyType)
  local itemCount = Int64toInt32(inventory:getItemCount_s64(ItemEnchantKey(itemKey, 0)))
  PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].itemCount = itemCount
  PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon:setItemByStaticStatus(itemSSW, itemCount)
  PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.icon:SetMonoTone(false)
end
function PaGlobal_SA_MainFrame:setSlotItemEmpty(idx, itemKey)
  if nil == Panel_SA_MainFrame then
    return
  end
  if nil == itemKey or PaGlobal_SA_MainFrame._value_item._skillBookItemKey == itemKey then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil == itemSSW then
    return
  end
  PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon:clearItem()
  PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].empty = true
  PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].itemKey = itemKey
  PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon:setItemByStaticStatus(itemSSW)
  PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.icon:SetMonoTone(true)
end
function PaGlobal_SA_MainFrame:hasSameItemKey(itemKey)
  if nil == Panel_SA_MainFrame then
    return
  end
  local sameIndex = -1
  for index = 1, PaGlobal_SA_MainFrame._value_item._maxItemCnt do
    if nil ~= PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[index].itemKey and itemKey == PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[index].itemKey then
      return index
    end
  end
  return sameIndex
end
function PaGlobal_SA_MainFrame:hasEmptySlot()
  if nil == Panel_SA_MainFrame then
    return
  end
  for index = 1, PaGlobal_SA_MainFrame._value_item._maxItemCnt do
    if nil == PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[index] or true == PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[index].empty then
      return true, index
    end
  end
  return false
end
function PaGlobal_SA_MainFrame:useSubItem(itemIdx)
  if nil == Panel_SA_MainFrame then
    return
  end
  local inventroyType = Inventory_GetCurrentInventoryType()
  local isGameStart = 0 < Int64toInt32(ToClient_BattleRoyaleRemainTime())
  if false == isGameStart then
    inventoryUseItem(inventroyType, PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[itemIdx].inventoryIdx, nil, true)
    return
  end
  if 0 >= PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[itemIdx].itemCount then
    return
  end
  if isManufactureAction() or isDoingAction("ALCHEMYSYSTEM_COOK") or isDoingAction("ALCHEMYSYSTEM_ALCHEMY") then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_CANT_USEITEM"))
    return
  end
  if false == PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[itemIdx].slotIcon.cooltime:GetShow() then
    audioPostEvent_SystemUi(8, 2)
    _AudioPostEvent_SystemUiForXBOX(8, 2)
    if nil ~= PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[itemIdx].slotIcon.icon then
      PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[itemIdx].slotIcon.icon:EraseAllEffect()
      PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[itemIdx].slotIcon.icon:AddEffect("fUI_SkillButton01", false, 0, 0)
      PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[itemIdx].slotIcon.icon:AddEffect("UI_SkillButton01", false, 0, 0)
    end
  end
  if 0 >= PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[itemIdx].itemCount - 1 then
    PaGlobal_SA_MainFrame._isUseItem = true
    PaGlobal_SA_MainFrame_UpdateInventory()
  end
  inventoryUseItem(inventroyType, PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[itemIdx].inventoryIdx, nil, true)
  if CppEnums.ItemType.Skill == PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[itemIdx].itemType then
    PaGlobal_SA_MainFrame_SetUseSkillTypeItem(true)
  end
end
function PaGlobal_SA_MainFrame:swapSlotItem(fromIndex, toIndex)
  if nil == Panel_SA_MainFrame then
    return
  end
  if fromIndex == toIndex then
    return
  end
  local fromItemKey = PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[fromIndex].itemKey
  local toItemKey = PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[toIndex].itemKey
  if fromItemKey == toItemKey then
    return
  end
  if nil == toItemKey then
    PaGlobal_SA_MainFrame:setItemSlotInfo(toIndex, fromItemKey)
    PaGlobal_SA_MainFrame:clearItemSlot(fromIndex)
  else
    PaGlobal_SA_MainFrame:setItemSlotInfo(toIndex, fromItemKey)
    PaGlobal_SA_MainFrame:setItemSlotInfo(fromIndex, toItemKey)
  end
  DragManager:clearInfo()
end
function FromClient_SA_MainFrame_ItemResizePanel()
  if nil == Panel_SA_MainFrame then
    return
  end
  PaGlobal_SA_MainFrame._ui_item.stc_item:ComputePos()
  for idx = 1, PaGlobal_SA_MainFrame._value_item._maxItemCnt do
    PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slot:ComputePos()
    PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.icon:ComputePos()
    local posX = PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.icon:GetPosX()
    local posY = PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.icon:GetPosY()
    PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.icon:SetPosXY(posX, posY)
    PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.icon:SetHorizonCenter()
    PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.icon:SetVerticalMiddle()
  end
end
function PaGlobal_SA_MainFrame:itemValidate()
  if nil == Panel_SA_MainFrame then
    return
  end
  PaGlobal_SA_MainFrame._ui_item.stc_item:isValidate()
  for idx = 1, PaGlobal_SA_MainFrame._value_item._maxItemCnt do
    PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slot:isValidate()
  end
end
function PaGlobal_SA_MainFrame:itemInit()
  if nil == Panel_SA_MainFrame then
    return
  end
  PaGlobal_SA_MainFrame._ui_item.stc_item = UI.getChildControl(Panel_SA_MainFrame, "Static_Item")
  for idx = 1, PaGlobal_SA_MainFrame._value_item._maxItemCnt do
    local item = {
      slot = nil,
      slotIcon = {},
      itemKey = nil,
      inventoryIdx = nil,
      itemCount = 0,
      itemType = nil,
      empty = true
    }
    item.slot = UI.getChildControl(PaGlobal_SA_MainFrame._ui_item.stc_item, "Static_ItemSlot0" .. idx)
    SlotItem.new(item.slotIcon, "slotItem_" .. idx, idx, item.slot, PaGlobal_SA_MainFrame._value_item.slotConfig_Item)
    item.slotIcon:createChild()
    item.slotIcon.icon:SetEnableDragAndDrop(true)
    PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx] = item
    PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.icon:SetHorizonCenter()
    PaGlobal_SA_MainFrame._ui_item.stc_itemSlot[idx].slotIcon.icon:SetVerticalMiddle()
  end
  PaGlobal_SA_MainFrame:initItemSlotInfo()
end
