function HandleEventMLUp_ShipEquipManagement_Close()
  PaGlobal_ShipEquipManagement:prepareClose()
end
function HandleEventMOn_ShipEquipManagement_EquipSlot(index, isShow)
  if nil == Panel_Window_ShipEquipManagement_ALL then
    return
  end
  Panel_Tooltip_Item_Show_GeneralNormal(index, "ServantShipEquipment", isShow)
end
function HandleEventScroll_ShipEquipManagement_MyInventory(isUp)
  if nil == Panel_Window_ShipEquipManagement_ALL then
    return
  end
  PaGlobal_ShipEquipManagement._startInvenSlotIndex = UIScroll.ScrollEvent(PaGlobal_ShipEquipManagement._ui._scroll_inventory, isUp, PaGlobal_ShipEquipManagement._config.slotRows, PaGlobal_ShipEquipManagement._maxCountInventory, PaGlobal_ShipEquipManagement._startInvenSlotIndex, PaGlobal_ShipEquipManagement._config.slotCols)
  PaGlobal_ShipEquipManagement:updateInventorySlots()
end
function HandleEventMOn_ShipEquipManagement_MyInventory(index, isShow)
  if nil == Panel_Window_ShipEquipManagement_ALL then
    return
  end
  Panel_Tooltip_Item_Show_GeneralNormal(index, "ShipEquipManagementInventory", isShow)
end
function HandleEventMRUp_ShipEquipManagement_UnEquipItem(slotNo)
  if nil == Panel_Window_ShipEquipManagement_ALL then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_ShipEquipManagement._servantActorKey)
  if nil == servantWrapper then
    return
  end
  local itemWrapper = servantWrapper:getEquipItem(slotNo)
  if nil == itemWrapper then
    return
  end
  servant_doUnequip(servantWrapper:getActorKeyRaw(), slotNo)
end
function HandleEventMRUp_ShipEquipManagement_EquipItem(slotNo)
  if nil == Panel_Window_ShipEquipManagement_ALL then
    return
  end
  local slot = PaGlobal_ShipEquipManagement._inventoryItemSlots[slotNo]
  if nil == slot then
    return nil
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_ShipEquipManagement._currentWhereType, slot.slotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if false == PaGlobal_ShipEquipManagement:isCheckEquipItem(itemSSW) then
    return
  end
  if 2 == itemSSW:get()._vestedType:getItemKey() and false == itemWrapper:get():isVested() then
    local function bindingItemUse()
      inventoryUseItem(PaGlobal_ShipEquipManagement._currentWhereType, slot.slotNo, nil, false)
    end
    local messageContent
    if itemSSW:isUserVested() then
      messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT_USERVESTED")
    else
      messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT")
    end
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_TITLE"),
      content = messageContent,
      functionYes = bindingItemUse,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
    return
  end
  inventoryUseItem(PaGlobal_ShipEquipManagement._currentWhereType, slot.slotNo, nil, false)
end
function FromClient_ShipEquipManagement_UpdateEquipSlot()
  PaGlobal_ShipEquipManagement:updateEquipSlots()
  PaGlobal_ShipEquipManagement:updateAvatarSlots()
end
function FromClient_ShipEquipManagement_UpdateMyInventory()
  if nil == Panel_Window_ShipEquipManagement_ALL or false == Panel_Window_ShipEquipManagement_ALL:GetShow() then
    return
  end
  PaGlobal_ShipEquipManagement:initScrollPos()
  PaGlobal_ShipEquipManagement:updateInventorySlots()
end
function FromClient_ShipEquipManagement_Resize()
  PaGlobal_ShipEquipManagement:resize()
end
function PaGlobal_ShipEquipManagement_GetActorKey()
  return PaGlobal_ShipEquipManagement._servantActorKey
end
function PaGlobal_ShipEquipManagement_GetInventoryItem(index)
  local slot = PaGlobal_ShipEquipManagement._inventoryItemSlots[index]
  if nil == slot or nil == slot.slotNo then
    return nil
  end
  return getInventoryItemByType(PaGlobal_ShipEquipManagement._currentWhereType, slot.slotNo)
end
function PaGlobal_ShipEquipManagement_ShowAni()
  if nil == Panel_Window_ShipEquipManagement_ALL or true == Panel_Window_ShipEquipManagement_ALL:GetShow() then
    return
  end
  if Panel_Window_ShipEquipManagement_ALL:IsShow() then
    Panel_Window_ShipEquipManagement_ALL:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
    local aniInfo1 = Panel_Window_ShipEquipManagement_ALL:addColorAnimation(0, 0.22, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
    aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
    aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
    aniInfo1:SetStartIntensity(3)
    aniInfo1:SetEndIntensity(1)
    aniInfo1.IsChangeChild = true
    aniInfo1:SetHideAtEnd(true)
    aniInfo1:SetDisableWhileAni(true)
  else
    UIAni.fadeInSCR_Down(Panel_Window_ShipEquipManagement_ALL)
    Panel_Window_ShipEquipManagement_ALL:SetShow(true, false)
  end
end
function PaGlobal_ShipEquipManagement_HideAni()
  if nil == Panel_Window_ShipEquipManagement_ALL or false == Panel_Window_ShipEquipManagement_ALL:GetShow() then
    return
  end
  Panel_Window_ShipEquipManagement_ALL:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Window_ShipEquipManagement_ALL:addColorAnimation(0, 0.22, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
