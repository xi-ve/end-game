function PaGlobalFunc_Socket_All_Open()
  PaGlobal_Socket_All:prepareOpen()
end
function PaGlobalFunc_Socket_All_Close()
  PaGlobal_Socket_All:prepareClose()
  HandleEventLUp_DialogMain_All_BackClick()
end
function HandleEventOnOut_Socket_All_ItemTooltip(isEquip, key, slotIdx, isShow)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if nil == slotIdx then
    return
  end
  if nil == Panel_Window_Socket_All then
    return
  end
  local itemWrapper
  if true == isEquip then
    itemWrapper = ToClient_getEquipmentItem(slotIdx)
  else
    local invenType = PaGlobalFunc_Socket_All_GetInvenType(key)
    itemWrapper = getInventoryItemByType(invenType, slotIdx)
  end
  if nil == itemWrapper then
    return
  end
  if false == PaGlobal_Socket_All._isConsole then
    Panel_Tooltip_Item_Show(itemWrapper, PaGlobal_Socket_All._slotIconList[key], false, true, nil)
  else
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventOnOut_Socket_All_SlotItemTooltip(itemKey, isShow, slotIndex)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if nil == itemKey or nil == slotIndex then
    return
  end
  if nil == Panel_Window_Socket_All then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if false == PaGlobal_Socket_All._isConsole then
    Panel_Tooltip_Item_Show(itemSSW, PaGlobal_Socket_All._ui.stc_crystalInfo[slotIndex].slot.icon, true, false)
  else
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventOnOut_Socket_All_EquipItemTooltip(key, slotIdx, isShow)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if nil == slotIdx then
    return
  end
  if nil == Panel_Window_Socket_All then
    return
  end
  local invenType = PaGlobalFunc_Socket_All_GetInvenType(key, true)
  local itemWrapper = getInventoryItemByType(invenType, slotIdx)
  if nil == itemWrapper then
    return
  end
  if false == PaGlobal_Socket_All._isConsole then
    Panel_Tooltip_Item_Show(itemWrapper, PaGlobal_Socket_All._equipItemSlotInfo.slot.icon, false, true, nil)
  else
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventLUp_Socket_All_SelectItem(slotIdx, key, isEquip)
  if nil == Panel_Window_Socket_All then
    return
  end
  local _key = Int64toInt32(key)
  local invenType = PaGlobalFunc_Socket_All_GetInvenType(_key)
  local itemWrapper = getInventoryItemByType(invenType, slotIdx)
  local socketInfo = getSocketInformation()
  if true == isEquip and false == PaGlobal_Socket_All._equipItemSlotInfo.empty then
    PaGlobal_Socket_All:clearAllSlots()
    getSocketInformation():popEquip()
  end
  local success = 0 == Socket_SetItemHaveSocket(invenType, slotIdx)
  if not success then
    PaGlobal_Socket_All:clearAllSlots()
    PaGlobalFunc_Socket_All_SetTab(PaGlobal_Socket_All._TAB.EQUIPMENT)
    return
  end
  local itemWrapper = getInventoryItemByType(invenType, slotIdx)
  local itemKey = itemWrapper:get():getKey():getItemKey()
  if nil == itemWrapper then
    UI.ASSERT(nil ~= itemWrapper, "ItemWrapper\234\176\128 nil ???")
    return
  end
  local itemStatic = itemWrapper:getStaticStatus():get()
  audioPostEvent_SystemItem(itemStatic._itemMaterial)
  if true == socketInfo._setEquipItem then
    PaGlobal_Socket_All._equipItemSlotInfo.empty = false
    PaGlobal_Socket_All._equipItemSlotInfo.slotNo = slotIdx
    PaGlobal_Socket_All._equipItemSlotInfo.slot:clearItem()
    PaGlobal_Socket_All._equipItemSlotInfo.slot:setItem(itemWrapper)
    PaGlobal_Socket_All._equipItemSlotInfo.slot.icon:SetShow(true)
    if false == PaGlobal_Socket_All._isConsole then
      PaGlobal_Socket_All._equipItemSlotInfo.slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Socket_All_EquipItemTooltip(" .. key .. ", " .. slotIdx .. ", true)")
      PaGlobal_Socket_All._equipItemSlotInfo.slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Socket_All_EquipItemTooltip(" .. key .. ", " .. slotIdx .. ", false)")
    end
    PaGlobal_Socket_All._selectKey = key
    PaGlobal_Socket_All:updateSocket()
    audioPostEvent_SystemUi(0, 16)
    _AudioPostEvent_SystemUiForXBOX(0, 16)
  else
    local rv = socketInfo:checkPushJewelToEmptySoket(invenType, slotIdx)
    PaGlobal_Socket_All._isItemLock = ToClient_Inventory_CheckItemLock(PaGlobal_Socket_All._equipItemSlotInfo.slotNo)
    if 0 == rv then
      local index = socketInfo._indexPush
      local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_SOCKET_INSERT_TITLE")
      local contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SOCKET_INSERT_MESSAGE", "socketNum", string.format("%d", index + 1), "itemName", itemWrapper:getStaticStatus():getName())
      local messageboxData = {
        title = titleString,
        content = contentString,
        functionYes = PaGlobalFunc_Socket_All_PushConfirm,
        functionCancel = PaGlobalFunc_Socket_All_PushDeny,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    end
  end
end
function HandleEventLUp_Socket_All_EquipmentRelese(slotNo)
  if nil == slotNo then
    UI.ASSERT_NAME(nil ~= slotNo, "slotNo\234\176\128 nil\236\157\180\235\169\180 \236\149\136\235\144\169\235\139\136\235\139\164", "\236\160\149\236\167\128\237\152\156")
    return
  end
  if false == _ContentsGroup_RenewUI then
    if true == _ContentsGroup_NewUI_Equipment_All then
      HandleEventRUp_Equipment_All_EquipSlotRClick(slotNo)
    else
      Equipment_RClick(slotNo)
    end
  else
    InputMRUp_InventoryInfo_EquipSlot(slotNo)
  end
end
function HandleEventRUp_Socket_All_SlotInit()
  Panel_Tooltip_Item_hideTooltip()
  local key = PaGlobal_Socket_All._selectKey
  if nil == key or nil == PaGlobal_Socket_All._whereType or nil == PaGlobal_Socket_All._equipList[key] then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_Socket_All._whereType, PaGlobal_Socket_All._equipList[key])
  if nil ~= itemWrapper then
    local itemStatic = itemWrapper:getStaticStatus():get()
    if nil ~= itemStatic then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
    end
  end
  getSocketInformation():popEquip()
  PaGlobal_Socket_All:clearAllSlots()
  PaGlobal_Socket_All._selectKey = -1
  PaGlobalFunc_Socket_All_SetTab(PaGlobal_Socket_All._TAB.EQUIPMENT)
end
function HandleEventRUp_Socket_All_RemoveCrystal(socketIndex)
  if true == PaGlobal_Socket_All._ui.stc_crystalInfo[socketIndex].empty then
    return
  end
  PaGlobal_Socket_All._indexPopSocket = socketIndex - 1
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_SOCKET_REMOVE_TITLE")
  local contentString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOCKET_REMOVE_MESSAGE", "socketNum", string.format("%d", socketIndex))
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = PaGlobalFunc_Socket_All_CrystalPop,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventPadB_Socket_All_Back()
  if nil == Panel_Window_Socket_All then
    return true
  end
  if -1 ~= PaGlobal_Socket_All._selectKey and PaGlobal_Socket_All._TAB.EQUIPMENT == PaGlobal_Socket_All._selectTab then
    HandleEventRUp_Socket_All_SlotInit()
    return false
  else
    Panel_Tooltip_Item_hideTooltip()
    PaGlobalFunc_Socket_All_Close()
    return true
  end
end
function HandleEventLBRB_Socket_All_MoveTab(value)
  if nil == Panel_Window_Socket_All then
    return true
  end
  PaGlobal_Socket_All._selectTab = PaGlobal_Socket_All._selectTab + value
  if PaGlobal_Socket_All._selectTab < 1 then
    PaGlobal_Socket_All._selectTab = 2
  elseif PaGlobal_Socket_All._selectTab > 2 then
    PaGlobal_Socket_All._selectTab = 1
  end
  PaGlobalFunc_Socket_All_SetTab(PaGlobal_Socket_All._selectTab)
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_Socket_All._ui.list2_item:moveTopIndex()
  ToClient_padSnapResetControl()
end
function HandlePadEventOn_Socket_All_SocketOnTextureChange(socketIndex, isOn)
  PaGlobal_Socket_All._ui_console.stc_delete:SetShow(false)
  if true == isOn and false == PaGlobal_Socket_All._ui.stc_crystalInfo[socketIndex].empty then
    PaGlobal_Socket_All._ui.stc_crystalInfoBg[socketIndex]:setRenderTexture(PaGlobal_Socket_All._ui.stc_crystalInfoBg[socketIndex]:getOnTexture())
    PaGlobal_Socket_All._ui_console.stc_delete:SetShow(true)
  else
    PaGlobal_Socket_All._ui.stc_crystalInfoBg[socketIndex]:setRenderTexture(PaGlobal_Socket_All._ui.stc_crystalInfoBg[socketIndex]:getBaseTexture())
  end
end
function FromClient_Socket_All_EventSocketResult()
  if nil == Panel_Window_Socket_All then
    return
  end
  if true == Panel_Window_Socket_All:GetShow() then
    PaGlobal_Socket_All:updateSocket()
    if PaGlobal_Socket_All._selectTab == PaGlobal_Socket_All._TAB.EQUIPMENT then
      PaGlobal_Socket_All:updateEquipList()
    elseif PaGlobal_Socket_All._selectTab == PaGlobal_Socket_All._TAB.CRYSCTAL then
      PaGlobal_Socket_All:updateCrystalList()
    end
  elseif false == _ContentsGroup_NewUI_BlackSmith_All then
    PaGlobal_ExtractionCrystal:result()
  else
    PaGlobal_Extraction_Crystal_All_Result()
  end
end
function FromCleint_Socket_All_onScreenResize()
  if nil == Panel_Window_Socket_All then
    return
  end
  Panel_Window_Socket_All:ComputePos()
end
function FromClient_Socket_All_UpdateEquipList()
  if false == Panel_Window_Socket_All:GetShow() then
    return
  end
  if PaGlobal_Socket_All._selectTab == PaGlobal_Socket_All._TAB.EQUIPMENT then
    PaGlobal_Socket_All:updateEquipList()
  end
end
function PaGlobalFunc_Socket_All_ShowAni()
  local aniInfo1 = Panel_Window_Socket_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.13)
  aniInfo1.AxisX = Panel_Window_Socket_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_Socket_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_Socket_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.13)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_Socket_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_Socket_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
  audioPostEvent_SystemUi(1, 0)
  _AudioPostEvent_SystemUiForXBOX(1, 0)
end
function PaGlobalFunc_Socket_All_HideAni()
  local socketHide = UIAni.AlphaAnimation(0, Panel_Window_Socket_All, 0, 0.2)
  socketHide:SetHideAtEnd(true)
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
end
function PaGlobalFunc_Socket_All_SetTab(tabIdx)
  if nil == Panel_Window_Socket_All then
    return
  end
  local tabControl
  if PaGlobal_Socket_All._TAB.EQUIPMENT == tabIdx then
    PaGlobal_Socket_All._selectTab = PaGlobal_Socket_All._TAB.EQUIPMENT
    PaGlobal_Socket_All:updateEquipList()
    tabControl = PaGlobal_Socket_All._ui.radio_tab[PaGlobal_Socket_All._TAB.EQUIPMENT]
  elseif PaGlobal_Socket_All._TAB.CRYSCTAL == tabIdx then
    PaGlobal_Socket_All._selectTab = PaGlobal_Socket_All._TAB.CRYSCTAL
    PaGlobal_Socket_All:updateCrystalList()
    tabControl = PaGlobal_Socket_All._ui.radio_tab[PaGlobal_Socket_All._TAB.CRYSCTAL]
  end
  if nil == tabControl then
    PaGlobal_Socket_All._ui.stc_selectBar:SetShow(false)
    return
  end
  tabControl:SetCheck(true)
  PaGlobal_Socket_All._ui.stc_selectBar:SetShow(true)
  PaGlobal_Socket_All._ui.stc_selectBar:SetPosX(tabControl:GetPosX() + tabControl:GetSizeX() / 2 - PaGlobal_Socket_All._ui.stc_selectBar:GetSizeX() / 2)
end
function PaGlobalFunc_Socket_All_GetInvenType(key, onlyEquip)
  if nil == Panel_Window_Socket_All then
    return nil
  end
  if nil == key then
    return nil
  end
  local _key = Int64toInt32(key)
  if PaGlobal_Socket_All._selectTab == PaGlobal_Socket_All._TAB.CRYSCTAL and true ~= onlyEquip then
    PaGlobal_Socket_All._whereType = CppEnums.ItemWhereType.eInventory
    return CppEnums.ItemWhereType.eInventory
  elseif _key <= PaGlobal_Socket_All._indexInvenEnd then
    PaGlobal_Socket_All._whereType = CppEnums.ItemWhereType.eInventory
    return CppEnums.ItemWhereType.eInventory
  elseif _key <= PaGlobal_Socket_All._indexCashInvenEnd then
    PaGlobal_Socket_All._whereType = CppEnums.ItemWhereType.eCashInventory
    return CppEnums.ItemWhereType.eCashInventory
  end
  return nil
end
function PaGlobalFunc_Socket_All_UpdateList(control, key)
  if nil == Panel_Window_Socket_All then
    return
  end
  local btn_list = UI.getChildControl(control, "RadioButton_ExtractableItem")
  local stc_itemSlotBg = UI.getChildControl(btn_list, "Static_ItemSlotBG")
  local stc_itemIcon = UI.getChildControl(stc_itemSlotBg, "Static_ItemIcon")
  local txt_name = UI.getChildControl(stc_itemSlotBg, "StaticText_ItemName")
  local stc_hammer = UI.getChildControl(btn_list, "Static_Hammer")
  local txt_equiped = UI.getChildControl(btn_list, "StaticText_Equip")
  local _key = Int64toInt32(key)
  local slotIdx = -1
  if PaGlobal_Socket_All._selectTab == PaGlobal_Socket_All._TAB.EQUIPMENT then
    if nil == PaGlobal_Socket_All._equipList[_key] then
      return
    end
    slotIdx = PaGlobal_Socket_All._equipList[_key]
  elseif PaGlobal_Socket_All._selectTab == PaGlobal_Socket_All._TAB.CRYSCTAL then
    if nil == PaGlobal_Socket_All._crystalList[_key] then
      return
    end
    slotIdx = PaGlobal_Socket_All._crystalList[_key]
  end
  local itemWrapper, itemKey
  local invenType = PaGlobalFunc_Socket_All_GetInvenType(key)
  if PaGlobal_Socket_All._selectTab == PaGlobal_Socket_All._TAB.CRYSCTAL then
    itemWrapper = getInventoryItemByType(invenType, slotIdx)
  elseif _key <= PaGlobal_Socket_All._indexInvenEnd then
    itemWrapper = getInventoryItemByType(invenType, slotIdx)
  elseif _key <= PaGlobal_Socket_All._indexCashInvenEnd then
    itemWrapper = getInventoryItemByType(invenType, slotIdx)
  else
    itemWrapper = ToClient_getEquipmentItem(slotIdx)
  end
  if nil == itemWrapper then
    return
  end
  local itemKey = itemWrapper:get():getKey():getItemKey()
  local itemSSW = itemWrapper:getStaticStatus()
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  local enchantText = ""
  if 16 <= enchantLevel then
    enchantText = HighEnchantLevel_ReplaceString(enchantLevel) .. " "
  end
  txt_name:SetTextMode(__eTextMode_AutoWrap)
  txt_name:SetText(enchantText .. itemWrapper:getStaticStatus():getName())
  PAGlobalFunc_SetItemTextColorForNewUI(txt_name, itemSSW)
  stc_hammer:SetShow(false)
  btn_list:SetCheck(false)
  txt_equiped:SetIgnore(true)
  txt_equiped:SetShow(false)
  btn_list:setNotImpactScrollEvent(true)
  local slot = {}
  SlotItem.reInclude(slot, "Socket_All_Slot_", 0, stc_itemIcon, PaGlobal_Socket_All._slotConfig)
  slot:clearItem()
  slot:setItem(itemWrapper)
  if false == PaGlobal_Socket_All._isConsole then
    slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Socket_All_ItemTooltip(false," .. _key .. "," .. slotIdx .. ", true)")
    slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Socket_All_ItemTooltip(false," .. _key .. "," .. slotIdx .. ", false)")
  else
    btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Socket_All_ItemTooltip(false," .. _key .. "," .. slotIdx .. ", true)")
  end
  PaGlobal_Socket_All._slotIconList[_key] = slot.icon
  if PaGlobal_Socket_All._selectTab == PaGlobal_Socket_All._TAB.EQUIPMENT then
    btn_list:SetMonoTone(false)
    if _key <= PaGlobal_Socket_All._indexCashInvenEnd then
      if false == PaGlobal_Socket_All._isConsole then
        btn_list:addInputEvent("Mouse_LUp", "HandleEventLUp_Socket_All_SelectItem(" .. slotIdx .. "," .. _key .. ", true)")
        slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Socket_All_SelectItem(" .. slotIdx .. "," .. _key .. ", true)")
      else
        btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Socket_All_SelectItem(" .. slotIdx .. "," .. _key .. ", true)")
      end
    else
      if false == PaGlobal_Socket_All._isConsole then
        slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Socket_All_EquipmentRelese(" .. slotIdx .. ")")
        btn_list:addInputEvent("Mouse_LUp", "HandleEventLUp_Socket_All_EquipmentRelese(" .. slotIdx .. ")")
        slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Socket_All_ItemTooltip(true," .. _key .. "," .. slotIdx .. ", true)")
        slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Socket_All_ItemTooltip(true," .. _key .. "," .. slotIdx .. ", false)")
      else
        btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Socket_All_EquipmentRelese(" .. slotIdx .. ")")
        btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Socket_All_ItemTooltip(true," .. _key .. "," .. slotIdx .. ", true)")
      end
      txt_equiped:SetShow(true)
    end
  elseif PaGlobal_Socket_All._selectTab == PaGlobal_Socket_All._TAB.CRYSCTAL then
    if false == PaGlobal_Socket_All._equipItemSlotInfo.empty then
      btn_list:SetMonoTone(false)
      if false == PaGlobal_Socket_All._isConsole then
        btn_list:addInputEvent("Mouse_LUp", "HandleEventLUp_Socket_All_SelectItem(" .. slotIdx .. "," .. _key .. ",false)")
        slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Socket_All_SelectItem(" .. slotIdx .. "," .. _key .. ",false)")
      else
        btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Socket_All_SelectItem(" .. slotIdx .. "," .. _key .. ",false)")
      end
    else
      btn_list:SetMonoTone(true)
      if false == PaGlobal_Socket_All._isConsole then
        slot.icon:addInputEvent("Mouse_LUp", "")
        btn_list:addInputEvent("Mouse_LUp", "")
      else
        btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
      end
    end
  end
end
function PaGlobalFunc_Socket_All_PushConfirm()
  if nil == Panel_Window_Socket_All then
    return
  end
  local socketInfo = getSocketInformation()
  local index = socketInfo._indexPush
  if false == PaGlobal_Socket_All._isItemLock then
    PaGlobal_Socket_All._ui.stc_crystalSlot[index + 1]:AddEffect("fUI_ItemJewel_01B", false, 0, 0)
  end
  Socket_ConfirmPushJewel(true)
  if false == PaGlobal_Socket_All._isItemLock then
    if index == 0 then
      audioPostEvent_SystemUi(5, 6)
      _AudioPostEvent_SystemUiForXBOX(5, 6)
    elseif index == 1 then
      audioPostEvent_SystemUi(5, 6)
      _AudioPostEvent_SystemUiForXBOX(5, 6)
    elseif index == 2 then
      audioPostEvent_SystemUi(5, 6)
      _AudioPostEvent_SystemUiForXBOX(5, 6)
    end
  end
  DragManager:clearInfo()
end
function PaGlobalFunc_Socket_All_PushDeny()
  Socket_ConfirmPushJewel(false)
end
function PaGlobalFunc_Socket_All_CrystalPop()
  audioPostEvent_SystemUi(5, 7)
  _AudioPostEvent_SystemUiForXBOX(5, 7)
  PaGlobal_Socket_All._ui.stc_crystalInfo[PaGlobal_Socket_All._indexPopSocket + 1].empty = true
  Socket_PopJewelFromSocket(PaGlobal_Socket_All._indexPopSocket, CppEnums.ItemWhereType.eCount, __eTInventorySlotNoUndefined)
end
