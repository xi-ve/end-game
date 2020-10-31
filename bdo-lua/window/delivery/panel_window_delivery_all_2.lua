function HandleEventLUp_DeliveryAll_MainRadioButton(isDelivery)
  if nil == Panel_Window_Delivery_All then
    return
  end
  TooltipSimple_Hide()
  PaGlobal_Delivery_All:updateMainRadioButton(isDelivery)
end
function HandleEventPad_DeliveryAll_LBRB(isDelivery)
  if isDelivery == PaGlobal_Delivery_All._isDeliveyCheck then
    isDelivery = not isDelivery
  end
  TooltipSimple_Hide()
  HandleEventLUp_DeliveryAll_MainRadioButton(isDelivery)
end
function HandleEventLUp_DeliveryAll_SubRadioButton(isTransList)
  if nil == Panel_Window_Delivery_All then
    return
  end
  PaGlobal_Delivery_All:updateSubRadioButton(isTransList)
end
function HandleEventPad_DeliveryAll_LTRT(isTransList)
  if isTransList == PaGlobal_Delivery_All._isTransList then
    isTransList = not isTransList
  end
  HandleEventLUp_DeliveryAll_SubRadioButton(isTransList)
end
function HandleEventLUp_DeliveryAll_Receive(delivererIndex, itemIndex)
  if nil == Panel_Window_Delivery_All then
    return
  end
  local delivererInfo = ToClient_NewDeliveryGetDeliverer(delivererIndex)
  if nil ~= delivererInfo then
    local itemNo = delivererInfo:getDeliveryItemNo(itemIndex)
    ToClient_NewDeliveryItemRecieveReq(PaGlobal_Delivery_All._currentWaypointKey, itemNo:get())
  end
end
function HandleEventLUp_DeliveryAll_ReceiveAll()
  if nil == Panel_Window_Delivery_All then
    return
  end
  ToClient_NewDeliveryItemRecieveAllReq(PaGlobal_Delivery_All._currentWaypointKey)
end
function HandleEventLUp_DeliveryAll_Cancel(delivererIndex, itemIndex)
  local delivererInfo = ToClient_NewDeliveryGetDeliverer(delivererIndex)
  if nil == delivererInfo then
    return
  end
  local itemNo = delivererInfo:getDeliveryItemNo(itemIndex)
  ToClient_NewDeliveryItemCancelReq(itemNo:get())
end
function HandleEventMO_DeliveryAll_ItemTooltipShow(delivererIndex, itemIndex, isOn)
  if false == isOn then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local key = itemIndex * 10 + delivererIndex
  local contents = PaGlobal_Delivery_All._ui.list_delivery:GetContentByKey(toInt64(0, key))
  if nil == contents then
    return
  end
  local itemIcon = UI.getChildControl(contents, "Static_SlotBg")
  local delivererInfo = ToClient_NewDeliveryGetDeliverer(delivererIndex)
  if nil == delivererInfo then
    return
  end
  local itemNo = delivererInfo:getDeliveryItemNo(itemIndex)
  local itemWrapper = delivererInfo:getDeliveryItemWrapper(itemIndex)
  Panel_Tooltip_Item_Show(itemWrapper, itemIcon, false, true, nil, nil, true, nil, "Delivery", itemNo:get())
end
function HandleEventPad_DeliveryAll_PadEventY()
  PaGlobal_Delivery_All:updateRegisterPadEvent_Y()
end
function PaGlobalFunc_DeliveryAll_CreateDeliveryList(content, key)
  if nil == Panel_Window_Delivery_All then
    return
  end
  PaGlobal_Delivery_All:deliveryInformation_CreateDeliveryList(content, key)
end
function DeliveryRequest_PushPackingItem(warehouseSlotNo, s64_count)
  if nil == Panel_Window_Delivery_All then
    return
  end
  if false == PaGlobal_Delivery_All._ui.radio_send:IsCheck() then
    return
  end
  if s64_count < Defines.s64_const.s64_1 then
    return
  end
  local selectedCarriageIndex = PaGlobal_Delivery_All._selectCarriageKey[PaGlobal_Delivery_All._selectDeliverer]
  if -1 == PaGlobal_Delivery_All._selectDeliverer or 0 == PaGlobal_Delivery_All.usableCount then
    local messageboxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
    local messageboxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DELIVERYNEW_SELECT_CARRIAGE")
    local messageboxData = {
      title = messageboxTitle,
      content = messageboxMemo,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
    return
  end
  warehouse_requestInfo(DeliveryInformation_WaypointKey())
  if true == _ContentsGroup_NewDelivery then
    ToClient_NewDeliveryPushPack(selectedCarriageIndex, warehouseSlotNo, s64_count)
  else
    delivery_pushPack(warehouseSlotNo, s64_count)
  end
  PaGlobal_Delivery_All:sendRequest_Update()
  if _ContentsGroup_NewUI_WareHouse_All then
    FromClient_Warehouse_All_Update()
  else
    FromClient_WarehouseUpdate()
  end
end
function HandleEventLUp_DeliveryAll_ShowToWaypointKey()
  if nil == Panel_Window_Delivery_All then
    return
  end
  if true == PaGlobal_Delivery_All._ui.combo_destination:isClicked() then
    HandleEventLUp_DeliveryAll_SelectToWaypointKey()
  end
  PaGlobal_Delivery_All._ui.combo_destination:ToggleListbox()
  ToClient_padSnapRefreshTarget(PaGlobal_Delivery_All._ui.combo_destination)
end
function HandleEventLUp_DeliveryAll_SelectToWaypointKey()
  if nil == Panel_Window_Delivery_All then
    return
  end
  local waypointKeyList = ToClient_NewDeliveryGetListWaypointKey(DeliveryInformation_WaypointKey())
  if nil ~= waypointKeyList then
    local comboBox = PaGlobal_Delivery_All._ui.combo_destination
    local selectIndex = comboBox:GetSelectIndex()
    PaGlobal_Delivery_All._selectDestination = selectIndex
    local waypoint = waypointKeyList:atPointer(selectIndex)
    if nil ~= waypoint then
      PaGlobal_Delivery_All._selectWaypointKey = waypointKeyList:atPointer(selectIndex):getWaypointKey()
      PaGlobal_Delivery_All:sendRequest_Update()
      PaGlobal_Delivery_All:sendRequest_updateCarriage(PaGlobal_Delivery_All._selectWaypointKey)
    end
  end
end
function HandleEventLUp_DeliveryAll_ShowToDeliverer()
  if nil == Panel_Window_Delivery_All then
    return
  end
  if true == PaGlobal_Delivery_All._ui.combo_carriage:isClicked() then
    HandleEnvetLUp_DeliveryRequest_SelectToDeliverer()
  end
  PaGlobal_Delivery_All._ui.combo_carriage:ToggleListbox()
  ToClient_padSnapRefreshTarget(PaGlobal_Delivery_All._ui.combo_carriage)
end
function HandleEnvetLUp_DeliveryRequest_SelectToDeliverer()
  if nil == Panel_Window_Delivery_All then
    return
  end
  local comboBox = PaGlobal_Delivery_All._ui.combo_carriage
  local selectIndex = comboBox:GetSelectIndex()
  local deliverer = ToClient_NewDeliveryGetWaitingDeliverer(PaGlobal_Delivery_All._selectCarriageKey[selectIndex])
  if nil == deliverer then
    return
  end
  PaGlobal_Delivery_All._selectDeliverer = selectIndex
  PaGlobal_Delivery_All:sendRequest_Update()
end
function HandleEventLUp_DeliveryAll_SendCheckNode()
  if nil == Panel_Window_Delivery_All then
    return
  end
  local packingItemCount = ToClient_NewDeliveryGetPackCount()
  if packingItemCount < 1 then
    return
  end
  local selectedDestination = PaGlobal_Delivery_All._selectDestination
  local selectedCarriage = PaGlobal_Delivery_All._selectDeliverer
  if -1 == selectedDestination then
    local messageboxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
    local messageboxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DELIVERY_REQUEST_PLZSELECT_DESTINATION")
    local messageboxData = {
      title = messageboxTitle,
      content = messageboxMemo,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
    return
  elseif -1 == selectedCarriage or 0 == PaGlobal_Delivery_All.usableCount then
    local messageboxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
    local messageboxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DELIVERYNEW_SELECT_CARRIAGE")
    local messageboxData = {
      title = messageboxTitle,
      content = messageboxMemo,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
    return
  end
  if false == ToClient_NewDeliveryIsLinkedWaypoint(DeliveryInformation_WaypointKey(), PaGlobal_Delivery_All._selectWaypointKey) then
    local messageboxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_DELIVERY_REQUEST_NOTLINKEDWAYPOINT_TITLE")
    local messageboxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DELIVERY_REQUEST_NOTLINKEDWAYPOINT_MSG")
    local messageboxData = {
      title = messageboxTitle,
      content = messageboxMemo,
      functionYes = PaGlobal_DeliveryAll_Send,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
    return
  end
  PaGlobal_DeliveryAll_Send()
end
function PaGlobal_DeliveryAll_Send()
  if nil == Panel_Window_Delivery_All then
    return
  end
  local selectedCarriage = PaGlobal_Delivery_All._selectCarriageKey[PaGlobal_Delivery_All._selectDeliverer]
  ToClient_NewDeliveryItemAddReq(DeliveryInformation_WaypointKey(), PaGlobal_Delivery_All._selectWaypointKey, selectedCarriage)
end
function HandleEventRUp_DeliveryAll_SlotRClick(slotNo)
  UI.ASSERT_NAME(nil ~= slotNo, "HandleEventRUp_DeliveryAll_SlotRClick slotNo nil", "\235\172\184\236\158\165\237\153\152")
  if nil == Panel_Window_Delivery_All then
    return
  end
  if true == PaGlobal_Delivery_All._ui.radio_send:IsCheck() then
    if true == _ContentsGroup_NewDelivery then
      ToClient_NewDeliveryPopPack(slotNo)
    else
      delivery_popPack(slotNo)
    end
    PaGlobal_Delivery_All:sendRequest_Update()
    if _ContentsGroup_NewUI_WareHouse_All then
      FromClient_Warehouse_All_Update()
    else
      FromClient_WarehouseUpdate()
    end
  end
end
function HandleEventPad_DeliveryAll_IconTooltip(index)
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local itemWrapper = ToClient_NewDeliveryGetPackItemBySlotNo(ii)
  if nil ~= itemWrapper then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    PaGlobalFunc_FloatingTooltip_Close()
  end
end
function HandleEventOn_DeliveryAll_IconTooltip(isShow, index)
  if true == _ContentsGroup_RenewUI_Tooltip then
    if false == isShow then
      return
    end
    local slot = PaGlobal_Delivery_All.slots[index]
    local itemWrapper = ToClient_NewDeliveryGetPackItemBySlotNo(index)
    if nil ~= itemWrapper then
      PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemSSWrapper, itemWrapper:getStaticStatus(), Defines.TooltipTargetType.Item, slot.base.icon)
    end
  else
    Panel_Tooltip_Item_Show_GeneralNormal(index, "DeliveryRequest", isShow)
  end
end
function DeliveryInformation_OpenPanelFromWorldmap(waypointKey)
  if nil == Panel_Window_Delivery_All or true == Panel_Window_Delivery_All:GetShow() then
    return
  end
  PaGlobal_Delivery_All._currentWaypointKey = waypointKey
  PaGlobal_Delivery_All:prepareOpen()
  PaGlobal_Warehouse_All_TownListCheck()
  local warehousePanelPosX = getScreenSizeX() - Panel_Window_Warehouse:GetSizeX() - 10
  Panel_Window_Warehouse:SetVerticalMiddle()
  Panel_Window_Warehouse:SetHorizonLeft()
  Panel_Window_Warehouse:SetSpanSize(warehousePanelPosX, Panel_Window_Warehouse:GetSpanSize().y)
  Panel_Window_Delivery_All:SetPosX(Panel_Window_Warehouse:GetPosX() - Panel_Window_Delivery_All:GetSizeX() - 10)
end
function DeliveryInformation_OpenPanelFromDialog()
  if nil == Panel_Window_Delivery_All or nil == Panel_Window_Warehouse then
    return
  end
  PaGlobal_Delivery_All._currentWaypointKey = getCurrentWaypointKey()
  if true == _ContentsGroup_NewUI_WareHouse_All then
    PaGlobal_Warehouse_All_OpenPanelFromDialogWithoutInventory(getCurrentWaypointKey(), CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc)
  else
    Warehouse_OpenPanelFromDialogWithoutInventory(getCurrentWaypointKey(), CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc)
  end
  Panel_Window_Delivery_All:SetPosX(Panel_Window_Warehouse:GetPosX() - Panel_Window_Delivery_All:GetSizeX() - 10)
  PaGlobal_Delivery_All:prepareOpen()
  local warehousePanelPosX = Panel_Window_Delivery_All:GetPosX() + Panel_Window_Delivery_All:GetSizeX() + 10
  Panel_Window_Warehouse:SetVerticalMiddle()
  Panel_Window_Warehouse:SetHorizonLeft()
  Panel_Window_Warehouse:SetPosX(warehousePanelPosX)
  Panel_Window_Warehouse:SetPosY(Panel_Window_Delivery_All:GetPosY())
end
function DeliveryInformation_WaypointKey()
  if nil == Panel_Window_Delivery_All then
    return
  end
  return PaGlobal_Delivery_All._currentWaypointKey
end
function PaGlobalFunc_PanelDelivery_GetShow()
  if nil == Panel_Window_Delivery_All then
    return false
  else
    return Panel_Window_Delivery_All:GetShow()
  end
end
function DeliveryRequestWindow_Close()
  if nil == Panel_Window_Delivery_All then
    return
  end
  PaGlobal_Delivery_All:prepareClose()
end
function PaGlobalFunc_DeliveryAll_GetReadyforSend()
  return PaGlobal_Delivery_All._ui.radio_send:IsCheck()
end
function DeliveryInformation_UpdateSlotData()
  if nil == Panel_Window_Delivery_All or false == Panel_Window_Delivery_All:IsShow() then
    return
  end
  if false == PaGlobal_Delivery_All._isDeliveyCheck then
    return
  end
  PaGlobal_Delivery_All._scrollIndex = PaGlobal_Delivery_All._ui.list_delivery:getCurrenttoIndex()
  PaGlobal_Delivery_All._ui.list_delivery:getElementManager():clearKey()
  PaGlobal_Delivery_All:deliveryInformation_UpdateSlot()
end
function FromClient_DeliveryAll_DeliveryReceiveItemClear()
  if nil == PaGlobal_Delivery_All then
    return
  end
  PaGlobal_Delivery_All._scrollIndex = PaGlobal_Delivery_All._ui.list_delivery:getCurrenttoIndex()
  PaGlobal_Delivery_All:deliveryInformation_UpdateSlot()
end
function FromClient_DeliveryAll_InActiveDeleteButton()
  if nil == PaGlobal_Delivery_All then
    return
  end
  PaGlobal_Delivery_All:deliveryInformation_UpdateSlot()
end
function FromClient_DeliveryAll_DeliveryRequestItemClear()
  if nil == PaGlobal_Delivery_All then
    return
  end
  PaGlobal_Delivery_All:sendRequest_Update()
end
function FromClient_Warehouse_All_OnScreenResize()
  if nil == Panel_Window_Delivery_All or false == Panel_Window_Delivery_All:GetShow() then
    return
  end
  Panel_Window_Delivery_All:ComputePos()
  if true == PaGlobal_Delivery_All._isConsole then
    Panel_Window_Delivery_All:SetPosY(PaGlobal_Delivery_All._originPanelPosY - PaGlobal_Delivery_All._adjustConsolePosY)
  end
end
function HandleEventOnOut_DeliveryAll_Tooltip(key, isTrue, ui)
  if true == isTrue then
    local control = PaGlobal_Delivery_All._ui.list_delivery
    local contents = control:GetContentByKey(toInt64(0, key))
    if nil ~= contents then
      local control
      if 0 == ui then
        control = UI.getChildControl(contents, "StaticText_Title_CariageType")
      elseif 1 == ui then
        control = UI.getChildControl(contents, "StaticText_ArrivalTownName")
      else
        control = UI.getChildControl(contents, "StaticText_StartTownName")
      end
      if nil ~= control then
        TooltipSimple_Show(control, "", control:GetText())
      end
    end
  else
    TooltipSimple_Hide()
  end
end
function HandleEventOn_DeliveryAll_ConsoleTooltip(key)
  local control = PaGlobal_Delivery_All._ui.list_delivery
  local contents = control:GetContentByKey(toInt64(0, key))
  local carriageControl = UI.getChildControl(contents, "StaticText_Title_CariageType")
  local arrivalControl = UI.getChildControl(contents, "StaticText_ArrivalTownName")
  local StartControl = UI.getChildControl(contents, "StaticText_StartTownName")
  local text = StartControl:GetText() .. " > " .. arrivalControl:GetText() .. "\n" .. carriageControl:GetText()
  TooltipSimple_Show(control, "", text)
end
