function PaGlobal_Lobby_CharacterSelect_ItemShop_Open()
  if nil == PaGlobal_Lobby_CharacterSelect_ItemShop then
    return
  end
  for index = 1, __eeBattleRoyaleItemSlotCount do
    local itemKey = PaGlobal_Lobby_CharacterSelect_ItemSlot._itemData:GetItemKey(index - 1)
    if 0 ~= itemKey then
      PaGlobal_Lobby_CharacterSelect_ItemShop:SelectItem(itemKey, index)
      local itemCount = Int64toInt32(PaGlobal_Lobby_CharacterSelect_ItemSlot._itemData:GetItemCount(index - 1))
      PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemIcons[index].count:SetText(itemCount)
    end
  end
  PaGlobal_Lobby_CharacterSelect_ItemShop:update()
  PaGlobal_Lobby_CharacterSelect_ItemShop:prepareOpen()
end
function PaGlobal_Lobby_CharacterSelect_ItemShop_Close()
  if nil == PaGlobal_Lobby_CharacterSelect_ItemShop then
    return
  end
  PaGlobal_Lobby_CharacterSelect_ItemShop_GroundClick()
  TooltipSimple_Hide()
  PaGlobal_Lobby_CharacterSelect_ItemShop:prepareClose()
end
function HandleEventOnOut_Lobby_CharacterSelect_ItemShop_ShowItemTooltip(index, itemKey, isShow)
  local self = PaGlobal_Lobby_CharacterSelect_ItemShop
  local title = ""
  local desc = ""
  local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil ~= itemWrapper then
    title = itemWrapper:getName()
    desc = itemWrapper:getDescription()
  end
  if true == isShow then
    TooltipSimple_Show(self._ui._itemList[index].slotBG, title, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleEvnetRUp_Lobby_CharacterSelect_ItemShop_ReMoveItem(index)
  local itemCount = Int64toInt32(PaGlobal_Lobby_CharacterSelect_ItemSlot._itemData:GetItemCount(index - 1))
  local itemKey = PaGlobal_Lobby_CharacterSelect_ItemSlot._itemData:GetItemKey(index - 1)
  if 1 == itemCount then
    PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemIcons[index]:clearItem()
    PaGlobal_Lobby_CharacterSelect_ItemShop._ui._button_ItemButtons[index]:SetShow(true)
    PaGlobal_Lobby_CharacterSelect_ItemShop._curAddItemCnt = PaGlobal_Lobby_CharacterSelect_ItemShop._curAddItemCnt - 1
    itemKey = 0
    TooltipSimple_Hide()
    PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemIcons[index].icon:removeInputEvent("Mouse_On")
    PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemIcons[index].icon:removeInputEvent("Mouse_Out")
    PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemIcons[index].itemKey = nil
  end
  PaGlobal_Lobby_CharacterSelect_ItemSlot_SelectItem(index, itemKey, toInt64(0, itemCount - 1))
  PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemIcons[index].count:SetText(itemCount - 1)
  PaGlobal_Lobby_CharacterSelect_ItemShop:update()
  DragManager:clearInfo()
end
function HandleEventPressMove_Lobby_CharacterSelect_ItemShop_ShopDrag(itemKey)
  local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil ~= itemWrapper then
    DragManager:setDragInfo(SA_Widget_Lobby_CharacterSelect_ItemShop, nil, nil, "Icon/" .. itemWrapper:getIconPath(), nil, itemKey)
  end
end
function HandleEventPressMove_Lobby_CharacterSelect_ItemShop_SlotDrag(index)
  local itemKey = PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemIcons[index].itemKey
  local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil ~= itemWrapper then
    DragManager:setDragInfo(SA_Widget_Lobby_CharacterSelect_ItemShop, nil, index, "Icon/" .. itemWrapper:getIconPath(), nil, nil)
  end
end
function HandleEventLUp_Lobby_CharacterSelect_ItemShop_DropItem(index)
  if nil == DragManager.dragStartPanel then
    return false
  end
  if SA_Widget_Lobby_CharacterSelect_ItemShop == DragManager.dragStartPanel then
    if nil == DragManager.dragSlotInfo then
      if nil ~= DragManager.fromActorKeyRaw then
        PaGlobal_Lobby_CharacterSelect_ItemShop_SelectItem(DragManager.fromActorKeyRaw, index)
      end
    else
      PaGlobal_Lobby_CharacterSelect_ItemShop_SwapItem(DragManager.dragSlotInfo, index)
    end
  end
  DragManager:clearInfo()
  return true
end
function HandleEventLUp_Lobby_CharacterSelect_ItemShop_SelectFilter(index)
  if nil == SA_Widget_Lobby_CharacterSelect_ItemShop then
    return
  end
  PaGlobal_Lobby_CharacterSelect_ItemShop._selectedFilter = index
  PaGlobal_Lobby_CharacterSelect_ItemShop:update()
end
function PaGlobal_Lobby_CharacterSelect_ItemShop_SwapItem(fromIndex, toIndex)
  if fromIndex == toIndex then
    return
  end
  local fromItemKey = PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemIcons[fromIndex].itemKey
  local toItemKey = PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemIcons[toIndex].itemKey
  if fromItemKey == toItemKey then
    return
  end
  local fromItemCount = Int64toInt32(PaGlobal_Lobby_CharacterSelect_ItemSlot._itemData:GetItemCount(fromIndex - 1))
  local toItemCount = Int64toInt32(PaGlobal_Lobby_CharacterSelect_ItemSlot._itemData:GetItemCount(toIndex - 1))
  PaGlobal_Lobby_CharacterSelect_ItemSlot_SelectItem(toIndex, fromItemKey, fromItemCount)
  PaGlobal_Lobby_CharacterSelect_ItemShop:SelectItem(fromItemKey, toIndex)
  PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemIcons[toIndex].count:SetText(fromItemCount)
  if nil ~= toItemKey then
    PaGlobal_Lobby_CharacterSelect_ItemSlot_SelectItem(fromIndex, toItemKey, toItemCount)
    PaGlobal_Lobby_CharacterSelect_ItemShop:SelectItem(toItemKey, fromIndex)
    PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemIcons[fromIndex].count:SetText(toItemCount)
  else
    PaGlobal_Lobby_CharacterSelect_ItemSlot_SelectItem(fromIndex, 0, 0)
    PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemIcons[fromIndex]:clearItem()
    PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemIcons[fromIndex].icon:removeInputEvent("Mouse_On")
    PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemIcons[fromIndex].icon:removeInputEvent("Mouse_Out")
    PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemIcons[fromIndex].itemKey = nil
    PaGlobal_Lobby_CharacterSelect_ItemShop._ui._button_ItemButtons[fromIndex]:SetShow(true)
    PaGlobal_Lobby_CharacterSelect_ItemShop._curAddItemCnt = 0
    TooltipSimple_Hide()
  end
  PaGlobal_Lobby_CharacterSelect_ItemShop:update()
end
function PaGlobal_Lobby_CharacterSelect_ItemShop_SelectSlot(index)
  if nil == PaGlobal_Lobby_CharacterSelect_ItemShop then
    return
  end
  PaGlobal_Lobby_CharacterSelect_ItemShop._selectedSlotNo = index
  PaGlobal_Lobby_CharacterSelect_ItemShop:hideOtherSlot(index)
end
function PaGlobal_Lobby_CharacterSelect_ItemShop_SelectItem(itemKey, selectedIndex)
  if nil == PaGlobal_Lobby_CharacterSelect_ItemShop then
    return
  end
  DragManager:clearInfo()
  local hasItem, hasIndex = PaGlobal_Lobby_CharacterSelect_ItemShop:hasSameItem(itemKey)
  if true == hasItem then
    if true == PaGlobal_Lobby_CharacterSelect_ItemShop:hasPoint(itemKey) then
      PaGlobal_Lobby_CharacterSelect_ItemShop_SelectSameItem(hasIndex)
    end
    PaGlobal_Lobby_CharacterSelect_ItemSlot:update()
    return
  end
  if nil == selectedIndex then
    if false == PaGlobal_Lobby_CharacterSelect_ItemShop:isAbleAddSlotItem(itemKey) then
      return
    end
    PaGlobal_Lobby_CharacterSelect_ItemShop._curAddItemCnt = PaGlobal_Lobby_CharacterSelect_ItemShop._curAddItemCnt + 1
    local addIndex = PaGlobal_Lobby_CharacterSelect_ItemShop._curAddItemCnt
    for selectIndex = 1, __eeBattleRoyaleItemSlotCount do
      if true == PaGlobal_Lobby_CharacterSelect_ItemShop._ui._button_ItemButtons[selectIndex]:GetShow() then
        addIndex = selectIndex
        break
      end
    end
    PaGlobal_Lobby_CharacterSelect_ItemSlot_SelectItem(addIndex, itemKey, 1)
    PaGlobal_Lobby_CharacterSelect_ItemShop:SelectItem(itemKey, addIndex)
  elseif true == PaGlobal_Lobby_CharacterSelect_ItemShop:isFull() then
    if false == PaGlobal_Lobby_CharacterSelect_ItemShop:hasPoint(itemKey, selectedIndex) then
      return
    end
    PaGlobal_Lobby_CharacterSelect_ItemSlot_SelectItem(selectedIndex, itemKey, 1)
    PaGlobal_Lobby_CharacterSelect_ItemShop:SelectItem(itemKey, selectedIndex)
  else
    if false == PaGlobal_Lobby_CharacterSelect_ItemShop:isAbleAddSlotItem(itemKey) then
      return
    end
    local prevItemKey = PaGlobal_Lobby_CharacterSelect_ItemSlot:getItem(selectedIndex - 1)
    local prevItemCount = Int64toInt32(PaGlobal_Lobby_CharacterSelect_ItemSlot._itemData:GetItemCount(selectedIndex - 1))
    if 0 ~= prevItemKey then
      PaGlobal_Lobby_CharacterSelect_ItemSlot_SelectItem(selectedIndex, itemKey, 1)
      PaGlobal_Lobby_CharacterSelect_ItemShop:SelectItem(itemKey, selectedIndex)
      PaGlobal_Lobby_CharacterSelect_ItemShop._curAddItemCnt = PaGlobal_Lobby_CharacterSelect_ItemShop._curAddItemCnt + 1
      local addIndex = PaGlobal_Lobby_CharacterSelect_ItemShop._curAddItemCnt
      for selectIndex = 1, __eeBattleRoyaleItemSlotCount do
        if true == PaGlobal_Lobby_CharacterSelect_ItemShop._ui._button_ItemButtons[selectIndex]:GetShow() then
          addIndex = selectIndex
          break
        end
      end
      PaGlobal_Lobby_CharacterSelect_ItemSlot_SelectItem(addIndex, prevItemKey, prevItemCount)
      PaGlobal_Lobby_CharacterSelect_ItemShop:SelectItem(prevItemKey, addIndex)
      PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemIcons[addIndex].count:SetText(prevItemCount)
    else
      PaGlobal_Lobby_CharacterSelect_ItemShop._curAddItemCnt = PaGlobal_Lobby_CharacterSelect_ItemShop._curAddItemCnt + 1
      PaGlobal_Lobby_CharacterSelect_ItemSlot_SelectItem(selectedIndex, itemKey, 1)
      PaGlobal_Lobby_CharacterSelect_ItemShop:SelectItem(itemKey, selectedIndex)
    end
  end
  PaGlobal_Lobby_CharacterSelect_ItemShop:update()
end
function PaGlobal_Lobby_CharacterSelect_ItemShop_SelectSameItem(index)
  local itemDataIndex = index - 1
  local curItemCnt = Int64toInt32(PaGlobal_Lobby_CharacterSelect_ItemSlot._itemData:GetItemCount(itemDataIndex))
  PaGlobal_Lobby_CharacterSelect_ItemSlot._itemData:setItemCount(itemDataIndex, toInt64(0, curItemCnt + 1))
  PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemIcons[index].count:SetText(curItemCnt + 1)
  PaGlobal_Lobby_CharacterSelect_ItemShop:update()
end
function FromClient_Lobby_CharacterSelect_ItemShop_ReSizePanel()
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  PaGlobal_Lobby_CharacterSelect_ItemShop._ui._stc_blackBG:SetSize(screenSizeX, screenSizeY)
  PaGlobal_Lobby_CharacterSelect_ItemShop._ui._stc_blackBG:ComputePos()
  PaGlobal_Lobby_CharacterSelect_ItemShop._ui._static_MainBG:ComputePos()
  PaGlobal_Lobby_CharacterSelect_ItemShop._ui._closeButton:ComputePos()
  PaGlobal_Lobby_CharacterSelect_ItemShop._ui._frm_frame:ComputePos()
  PaGlobal_Lobby_CharacterSelect_ItemShop._ui._frm_frameContent:ComputePos()
  PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemBG[1]:ComputePos()
  PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemBG[2]:ComputePos()
  PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemBG[3]:ComputePos()
  PaGlobal_Lobby_CharacterSelect_ItemShop._ui._static_BottomBG:ComputePos()
  PaGlobal_Lobby_CharacterSelect_ItemShop._ui._static_ItemSlotGroup:ComputePos()
  PaGlobal_Lobby_CharacterSelect_ItemShop._ui._static_PointGroup:ComputePos()
  PaGlobal_Lobby_CharacterSelect_ItemShop._ui._staticText_PointValue:ComputePos()
  for index = 1, __eeBattleRoyaleItemSlotCount do
    PaGlobal_Lobby_CharacterSelect_ItemShop._ui._button_ItemSlotsBG[index]:ComputePos()
    PaGlobal_Lobby_CharacterSelect_ItemShop._ui._button_ItemSlots[index]:ComputePos()
    PaGlobal_Lobby_CharacterSelect_ItemShop._ui._button_ItemButtons[index]:ComputePos()
  end
  PaGlobal_Lobby_CharacterSelect_ItemShop._ui._stc_nakMsg:ComputePos()
end
function HandleEventOnOut_Lobby_CharacterSelect_ItemShop_ShowMenuTooltip(index, isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = ""
  if 1 == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "LUA_TEXT_SHADOWARENA_ITEMSHOP_MENU_ALL")
  elseif 2 == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "LUA_TEXT_SHADOWARENA_ITEMSHOP_MENU_2")
  elseif 3 == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "LUA_TEXT_SHADOWARENA_ITEMSHOP_MENU_1")
  elseif 4 == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "LUA_TEXT_SHADOWARENA_ITEMSHOP_MENU_3")
  else
    return
  end
  TooltipSimple_Show(PaGlobal_Lobby_CharacterSelect_ItemShop._ui._button_FilterButtons[index], name)
end
function PaGlobal_Lobby_CharacterSelect_ItemShop_GroundClick()
  DragManager:clearInfo()
end
