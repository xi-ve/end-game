function PaGlobal_SA_Widget_Inventory_Open()
  PaGlobal_SA_Widget_Inventory:prepareOpen()
  PaGlobal_SA_Widget_Inventory_ShowAni()
end
function PaGlobal_SA_Widget_Inventory_Close()
  PaGlobal_SA_Widget_Inventory:prepareClose()
end
function HandleEventLUp_SA_Widget_Inventory_Filter(itemType)
  if nil == itemType then
    PaGlobal_SA_Widget_Inventory.filterFunc = nil
  elseif CppEnums.ItemType.Equip == itemType then
    PaGlobal_SA_Widget_Inventory.filterFunc = PaGlobal_SA_Widget_Inventory_EquipFilter
  elseif CppEnums.ItemType.Skill == itemType then
    PaGlobal_SA_Widget_Inventory.filterFunc = PaGlobal_SA_Widget_Inventory_PosionFilter
  end
  PaGlobal_SA_Widget_Inventory_UpdateInventory()
end
function HandleEventOnOut_SA_Widget_Inventory_ShowItemToolTip(isShow, whereType, index)
  if Panel_SA_Window_MessageBox:GetShow() then
    return
  end
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if CppEnums.ItemWhereType.eInstanceInventory == whereType then
    local useStartSlot = inventorySlotNoUserStart()
    local slotNo = index + useStartSlot
    local itemWrapper = getInventoryItemByType(PaGlobal_SA_Widget_Inventory._whereType, slotNo)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      if nil == itemSSW then
        return
      end
      Panel_Tooltip_Item_Show(itemSSW, PaGlobal_SA_Widget_Inventory._inventoryItemSlot[index].icon, true, false)
    end
  elseif CppEnums.ItemWhereType.eEquip == whereType then
    local itemWrapper
    if index <= 1 then
      itemWrapper = ToClient_getEquipmentItem(index)
    else
      itemWrapper = ToClient_getEquipmentItem(index + 1)
    end
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      if nil == itemSSW then
        return
      end
      Panel_Tooltip_Item_Show(itemSSW, PaGlobal_SA_Widget_Inventory._equipItemSlot[index].icon, true, false)
    end
  end
end
function HandleEventLDown_SA_Widget_Inventory_SlotLClick(index)
  local useStartSlot = inventorySlotNoUserStart()
  local slotNo = useStartSlot + index
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local inventory = selfProxy:getInventory()
  local invenUseSize = selfProxy:getInventorySlotCount(true)
  if isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) then
    local itemWrapper = getInventoryItemByType(PaGlobal_SA_Widget_Inventory._whereType, slotNo)
    if nil ~= itemWrapper then
      if itemWrapper:getStaticStatus():isStackable() then
        Panel_NumberPad_Show(true, itemWrapper:get():getCount_s64(), slotNo, Inventory_ProcessThrowItem)
      else
        Inventory_ProcessThrowItem(1, slotNo)
      end
    end
  end
end
function HandleEvent_SA_Widget_Inventory_DropHandler(index)
  local useStartSlot = inventorySlotNoUserStart()
  local slotNo = useStartSlot + index
  if nil == DragManager.dragStartPanel then
    HandleEventLUp_SA_Widget_Inventory_LCllick(index)
    return false
  end
  local isRestricted = checkManufactureAction() or checkAlchemyAction()
  if true == isRestricted then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_CANT_REPOSITIONITEM"))
    return false
  end
  local fromSlotNo = DragManager.dragSlotInfo
  if Panel_SA_Widget_Inventory == DragManager.dragStartPanel then
    if DragManager.dragWhereTypeInfo == PaGlobal_SA_Widget_Inventory._whereType then
      inventory_swapItem(PaGlobal_SA_Widget_Inventory._whereType, DragManager.dragSlotInfo, slotNo)
    end
    DragManager:clearInfo()
  else
    return (DragManager:itemDragMove(CppEnums.MoveItemToType.Type_Player, getSelfPlayer():getActorKey()))
  end
  return true
end
function HandleEvent_SA_Widget_Inventory_SlotDrag(index)
  local useStartSlot = inventorySlotNoUserStart()
  local slotNo = useStartSlot + index
  if Panel_SA_Window_MessageBox:GetShow() then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_SA_Widget_Inventory._whereType, slotNo)
  if nil == itemWrapper then
    return
  else
    local itemSSW = itemWrapper:getStaticStatus()
    local itemType = itemSSW:getItemType()
    local isTradeItem = itemSSW:isTradeAble()
    DragManager:setDragInfo(Panel_SA_Widget_Inventory, PaGlobal_SA_Widget_Inventory._whereType, slotNo, "Icon/" .. itemWrapper:getStaticStatus():getIconPath(), PaGlobal_SA_Widget_Inventory_GroundClick, getSelfPlayer():getActorKey())
  end
end
function HandleEventRUp_SA_Widget_Inventory_RCllick(index, equipSlotNo)
  if Panel_SA_Window_MessageBox:GetShow() then
    return
  end
  local useStartSlot = inventorySlotNoUserStart()
  local slotNo = useStartSlot + index
  local itemWrapper = getInventoryItemByType(PaGlobal_SA_Widget_Inventory._whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  HandleEventRUp_SA_Widget_Inventory_SlotRClickXXX(slotNo, equipSlotNo, index)
end
function HandleEventLUp_SA_Widget_Inventory_LCllick(index)
  if Panel_SA_Window_MessageBox:GetShow() then
    return
  end
  local useStartSlot = inventorySlotNoUserStart()
  local slotNo = useStartSlot + index
  local itemWrapper = getInventoryItemByType(PaGlobal_SA_Widget_Inventory._whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemType = itemWrapper:getStaticStatus():getItemType()
  inventoryUseItem(PaGlobal_SA_Widget_Inventory._whereType, slotNo, nil, true)
  if CppEnums.ItemType.Skill == itemType then
    PaGlobal_SA_MainFrame_SetUseSkillTypeItem(true)
  end
end
function HandleEventRUp_SA_Widget_Inventory_SlotRClickXXX(slotNo, equipSlotNo, index)
  local selfProxy = getSelfPlayer():get()
  local itemWrapper = getInventoryItemByType(PaGlobal_SA_Widget_Inventory._whereType, slotNo)
  if nil ~= itemWrapper then
    PaGlobal_SA_Widget_Inventory_ItemThrow(slotNo)
  end
end
function HandleEvent_SA_Widget_Inventory_Scroll(isUp)
  local scrollControl = PaGlobal_SA_Widget_Inventory._ui.frame_vScroll
  local row = PaGlobal_SA_Widget_Inventory._maxRow
  local col = PaGlobal_SA_Widget_Inventory._maxCol
  local contentsCount = PaGlobal_SA_Widget_Inventory._maxRow
  local startSlot = PaGlobal_SA_Widget_Inventory._startSlotIndex
  UIScroll.SetButtonSize(scrollControl, contentsCount, contentsCount - startSlot)
  PaGlobal_SA_Widget_Inventory._startSlotIndex = UIScroll.ScrollEvent(scrollControl, isUp, row, contentsCount, startSlot, col)
  PaGlobal_SA_Widget_Inventory._ui.frame_1:UpdateContentScroll()
  PaGlobal_SA_Widget_Inventory._ui.frame_1:UpdateContentPos()
end
function HandleEventOnOut_SA_Widget_Inventory_ShowMenuTooltip(index, isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = ""
  if 0 == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "LUA_TEXT_SHADOWARENA_ITEMSHOP_MENU_ALL")
  elseif 1 == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "LUA_TOOLTIP_SHADOWARENA_INVENTORY_EQUIP")
  elseif 2 == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "LUA_TOOLTIP_SHADOWARENA_INVENTORY_ITEM")
  else
    return
  end
  TooltipSimple_Show(PaGlobal_SA_Widget_Inventory._ui.buttons[index], name)
end
function FromClient_SA_Widget_Inventory_EventSelfPlayerDead()
  PaGlobal_SA_Widget_Inventory._isDeadPlayer = true
end
function FromClient_SA_Widget_Inventory_EventSelfPlayerRevive()
  PaGlobal_SA_Widget_Inventory._isDeadPlayer = false
end
function FromClient_SA_Widget_Inventory_UpdateEquipmentList()
  PaGlobal_SA_Widget_Inventory:setEquipGroupInfo()
end
function FromClient_SA_Widget_Inventory_ReSizePanel()
  PaGlobal_SA_Widget_Inventory._ui.btn_close:ComputePos()
  PaGlobal_SA_Widget_Inventory._ui.txt_attValue:ComputePos()
  PaGlobal_SA_Widget_Inventory._ui.txt_dpValue:ComputePos()
  PaGlobal_SA_Widget_Inventory._ui.stc_equipBG:ComputePos()
  PaGlobal_SA_Widget_Inventory._ui.stc_characterIcon:ComputePos()
  for index = 0, PaGlobal_SA_Widget_Inventory._maxEquipItem - 1 do
    PaGlobal_SA_Widget_Inventory._ui.stc_equip[index]:ComputePos()
  end
  PaGlobal_SA_Widget_Inventory._ui.stc_radioGroup:ComputePos()
  PaGlobal_SA_Widget_Inventory._ui.btn_all:ComputePos()
  PaGlobal_SA_Widget_Inventory._ui.btn_equip:ComputePos()
  PaGlobal_SA_Widget_Inventory._ui.btn_posion:ComputePos()
  PaGlobal_SA_Widget_Inventory._ui.frame_1:ComputePos()
  PaGlobal_SA_Widget_Inventory._ui.frame_Content:ComputePos()
  PaGlobal_SA_Widget_Inventory._ui.stc_iconBG:ComputePos()
  PaGlobal_SA_Widget_Inventory._ui.stc_iconSlot:ComputePos()
  PaGlobal_SA_Widget_Inventory._ui.frame_vScroll:ComputePos()
  PaGlobal_SA_Widget_Inventory._ui.frame_1:UpdateContentScroll()
end
function PaGlobal_SA_Widget_Inventory_UpdateInventory()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  PaGlobal_SA_Widget_Inventory:updateInventory()
end
function PaGlobal_SA_Widget_Inventory_UdateSlotDatabyAddItem()
  if true == Panel_SA_Widget_Inventory:GetShow() then
    PaGlobal_SA_Widget_Inventory_UpdateInventory()
  end
end
function PaGlobal_SA_Widget_Inventory_UseItemAskFromOtherPlayer(fromName)
  local UseItemFromOtherPlayer_Yes = function()
    useItemFromOtherPlayer(true)
  end
  local UseItemFromOtherPlayer_No = function()
    useItemFromOtherPlayer(false)
  end
  local messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_USEITEM_MESSAGEBOX_REQUEST", "for_name", fromName)
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_USEITEM_MESSAGEBOX_TITLE"),
    content = messageboxMemo,
    functionYes = UseItemFromOtherPlayer_Yes,
    functionCancel = UseItemFromOtherPlayer_No,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_SA_Widget_Inventory_RenderModeChange_inventory_FlushRestoreFunc(prevRenderModeList, nextRenderModeList)
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
end
function PaGlobal_SA_Widget_Inventory_UnequipItem(whereType, slotNo)
  PaGlobal_SA_Widget_Inventory:unequipItem(whereType, slotNo)
end
function PaGlobal_SA_Widget_Inventory_SetTopGroupInfo()
  PaGlobal_SA_Widget_Inventory:setTopGroupInfo()
end
function PaGlobal_SA_Widget_Inventory_GroundClick(whereType, slotNo)
  if false == Panel_SA_Widget_Inventory:GetShow() or Panel_SA_Window_MessageBox:GetShow() then
    return
  end
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  PaGlobal_SA_Widget_Inventory_ItemThrow(slotNo)
end
function PaGlobal_SA_Widget_Inventory_Inventory_GroundClick_Message(s64_itemCount, slotNo, whereType, itemName)
  DragManager:clearInfo()
  local messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DELETE")
  local messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ONLYTRASH_INVENTORY")
  local messageboxData = {
    title = messageTitle,
    content = messageContent,
    functionYes = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_SA_Widget_Inventory_ItemThrow(slotNo)
  local itemWrapper = getInventoryItemByType(PaGlobal_SA_Widget_Inventory._whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemCount = itemWrapper:get():getCount_s64()
  if Defines.s64_const.s64_1 == itemCount then
    PaGlobal_SA_Widget_Inventory_ItemThrow_Check(Defines.s64_const.s64_1, slotNo, PaGlobal_SA_Widget_Inventory._whereType)
  else
    Panel_NumberPad_Show(true, itemCount, slotNo, PaGlobal_SA_Widget_Inventory_ItemThrow_Check, nil, PaGlobal_SA_Widget_Inventory._whereType)
  end
end
function PaGlobal_SA_Widget_Inventory_ItemThrow_Check(count, slotNo, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  local itemName = itemWrapper:getStaticStatus():getName()
  PaGlobal_SA_Widget_Inventory._deleteSlotNo = slotNo
  PaGlobal_SA_Widget_Inventory._deleteItemCount = count
  DragManager:clearInfo()
  local messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DELETE")
  local messageContent = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DELETEITEM_MSG", "itemName", itemName, "itemCount", tostring(count))
  local messageboxData = {
    title = messageTitle,
    content = messageContent,
    functionYes = PaGlobal_SA_Widget_Inventory_ItemThrow_Yes,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_SA_Widget_Inventory_ItemThrow_Yes()
  if nil == PaGlobal_SA_Widget_Inventory._deleteSlotNo or 0 == PaGlobal_SA_Widget_Inventory._deleteSlotNo then
    return
  end
  DragManager:clearInfo()
  ToClient_Inventory_ThrowItem(PaGlobal_SA_Widget_Inventory._deleteSlotNo, PaGlobal_SA_Widget_Inventory._deleteItemCount)
end
function PaGlobal_SA_Widget_Inventory_EquipFilter(slotNo, itemWrapper, whereType)
  local isfilter = true
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW:getItemType() == CppEnums.ItemType.Equip then
    isfilter = false
  end
  return isfilter
end
function PaGlobal_SA_Widget_Inventory_PosionFilter(slotNo, itemWrapper, whereType)
  local isfilter = true
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW:getItemType() == CppEnums.ItemType.Skill then
    isfilter = false
  end
  return isfilter
end
function Inventory_GetCurrentInventoryType()
  return PaGlobal_SA_Widget_Inventory._whereType
end
function Time_Formatting_ShowTop(second)
  if 3600 < second then
    local recalc_time = second / 3600
    local strHour = string.format("%d", Int64toInt32(recalc_time))
    return PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_HOUR", "time_hour", strHour)
  elseif 60 < second then
    local recalc_time = second / 60
    local strMinute = string.format("%d", Int64toInt32(recalc_time))
    return PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_MINUTE", "time_minute", strMinute)
  else
    local recalc_time = second
    local strSecond = string.format("%d", Int64toInt32(recalc_time))
    return PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_SECOND", "time_second", strSecond)
  end
end
function _inventory_updateSlot_compareSpec(whereType, slotNo, isAccessory)
  local selfPlayerWrapper = getSelfPlayer()
  local classType = selfPlayerWrapper:getClassType()
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  local equipItemWrapper = ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo())
  local offencePoint = (itemWrapper:getStaticStatus():getMinDamage(0) + itemWrapper:getStaticStatus():getMaxDamage(0)) / 2
  local defencePoint = itemWrapper:getStaticStatus():getDefence(0)
  local equipOffencePoint = 0
  local equipDefencePoint = 0
  local matchEquip = false
  local isEquip = itemWrapper:getStaticStatus():get()._usableClassType:isOn(classType)
  local isAwakenWeaponContentsOpen = PaGlobal_AwakenSkill.awakenWeapon[classType]
  if isEquip then
    local equipType = itemWrapper:getStaticStatus():getEquipType()
    local enum_class = CppEnums.ClassType
    local firstRingOffence = 0
    local firstRingDeffence = 0
    local secondRingOffence = 0
    local secondRingDeffence = 0
    local matchEquip = true
    if 16 == equipType or 17 == equipType then
      local accSlotNo = PaGlobal_SA_Widget_Looting_Equip_GetAccesoryWorseEquipment_Key(itemWrapper)
      local equipItemWrapper = ToClient_getEquipmentItem(accSlotNo)
      if nil ~= equipItemWrapper then
        equipOffencePoint = (equipItemWrapper:getStaticStatus():getMinDamage(0) + equipItemWrapper:getStaticStatus():getMaxDamage(0)) / 2
        equipDefencePoint = equipItemWrapper:getStaticStatus():getDefence()
        return offencePoint, defencePoint, equipOffencePoint, equipDefencePoint, matchEquip, true
      else
        return offencePoint, defencePoint, equipOffencePoint, equipDefencePoint, matchEquip, true
      end
    elseif 15 == equipType or 18 == equipType then
      equipItemWrapper = ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo())
      if nil ~= equipItemWrapper then
        equipOffencePoint = (ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo()):getStaticStatus():getMinDamage(0) + ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo()):getStaticStatus():getMaxDamage(0)) / 2
        equipDefencePoint = ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo()):getStaticStatus():getDefence()
        matchEquip = true
      else
        equipOffencePoint = 0
        equipDefencePoint = 0
        matchEquip = true
      end
      return offencePoint, defencePoint, equipOffencePoint, equipDefencePoint, matchEquip, true
    end
    equipItemWrapper = ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo())
    if nil ~= equipItemWrapper then
      equipDefencePoint = ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo()):getStaticStatus():getDefence(0)
      local attackType = selfPlayerWrapper:getMainAttckType()
      offencePoint = (itemWrapper:getStaticStatus():getMinDamage(attackType) + itemWrapper:getStaticStatus():getMaxDamage(attackType)) / 2
      equipOffencePoint = (ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo()):getStaticStatus():getMinDamage(attackType) + ToClient_getEquipmentItem(itemWrapper:getStaticStatus():getEquipSlotNo()):getStaticStatus():getMaxDamage(attackType)) / 2
      matchEquip = true
    else
      local attackType = selfPlayerWrapper:getMainAttckType()
      offencePoint = (itemWrapper:getStaticStatus():getMinDamage(attackType) + itemWrapper:getStaticStatus():getMaxDamage(attackType)) / 2
      matchEquip = true
    end
    isAccessory = false
    return offencePoint, defencePoint, equipOffencePoint, equipDefencePoint, matchEquip, isAccessory
  end
end
function PaGlobal_SA_Widget_Inventory_ShowAni()
  if nil == Panel_SA_Widget_Inventory then
    return
  end
  local panel = Panel_SA_Widget_Inventory
  local moveAni = panel:addMoveAnimation(0, 0.2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  moveAni:SetStartPosition(panel:GetPosX() + 100, panel:GetPosY())
  moveAni:SetEndPosition(panel:GetPosX(), panel:GetPosY())
  panel:CalcUIAniPos(moveAni)
end
function PaGlobal_SA_Widget_Inventory_HideAni()
  if nil == Panel_SA_Widget_Inventory then
    return
  end
end
function PaGlobal_SA_Widget_Inventory_RegisterUpdateFunc(delta)
  PaGlobal_SA_Widget_Inventory_UpdateItemCoolTime(delta)
end
function PaGlobal_SA_Widget_Inventory_UpdateItemCoolTime(delta)
  if nil == Panel_SA_Widget_Inventory then
    return
  end
  local isGameStart = 0 < Int64toInt32(ToClient_BattleRoyaleRemainTime())
  if false == isGameStart then
    return
  end
  local useStartSlot = inventorySlotNoUserStart()
  for index = 0, PaGlobal_SA_Widget_Inventory._maxItemSlotCnt - 1 do
    local slotNo = index + useStartSlot
    local itemWrapper = getInventoryItemByType(PaGlobal_SA_Widget_Inventory._whereType, slotNo)
    if nil ~= itemWrapper then
      local remainTime = getItemCooltime(PaGlobal_SA_Widget_Inventory._whereType, slotNo)
      local itemReuseTime = getItemReuseCycle(PaGlobal_SA_Widget_Inventory._whereType, slotNo) * 0.001
      local realRemainTime = remainTime * itemReuseTime
      local initRemainTime = realRemainTime - realRemainTime % 1 + 1
      if 0 < remainTime then
        PaGlobal_SA_Widget_Inventory._inventoryItemSlot[index].cooltime:UpdateCoolTime(remainTime)
        PaGlobal_SA_Widget_Inventory._inventoryItemSlot[index].cooltime:SetShow(true)
        PaGlobal_SA_Widget_Inventory._inventoryItemSlot[index].cooltimeText:SetText(PaGlobal_SA_MainFrame_Time_Formatting_ShowTop(initRemainTime))
        if itemReuseTime >= initRemainTime then
          PaGlobal_SA_Widget_Inventory._inventoryItemSlot[index].cooltimeText:SetShow(true)
        else
          PaGlobal_SA_Widget_Inventory._inventoryItemSlot[index].cooltimeText:SetShow(false)
        end
      elseif PaGlobal_SA_Widget_Inventory._inventoryItemSlot[index].cooltime:GetShow() then
        PaGlobal_SA_Widget_Inventory._inventoryItemSlot[index].cooltime:SetShow(false)
        PaGlobal_SA_Widget_Inventory._inventoryItemSlot[index].cooltimeText:SetShow(false)
      end
    else
      PaGlobal_SA_Widget_Inventory._inventoryItemSlot[index].cooltime:SetShow(false)
      PaGlobal_SA_Widget_Inventory._inventoryItemSlot[index].cooltimeText:SetShow(false)
    end
  end
end
