function PaGlobal_Delivery_All:initialize()
  if true == PaGlobal_Delivery_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_topBG = UI.getChildControl(Panel_Window_Delivery_All, "Static_TopBg")
  self._ui._pc.btn_close = UI.getChildControl(self._ui.stc_topBG, "Button_Close_PCUI")
  self._ui._pc.btn_question = UI.getChildControl(self._ui.stc_topBG, "Button_Question_PCUI")
  self._ui.stc_radioBtnBG = UI.getChildControl(Panel_Window_Delivery_All, "Static_RadioButtonBg")
  self._ui.radio_delivery = UI.getChildControl(self._ui.stc_radioBtnBG, "RadioButton_Delivery")
  self._ui.radio_send = UI.getChildControl(self._ui.stc_radioBtnBG, "RadioButton_Send")
  self._ui._console.stc_LBkey = UI.getChildControl(self._ui.stc_radioBtnBG, "Static_LB_ConsoleUI")
  self._ui._console.stc_RBkey = UI.getChildControl(self._ui.stc_radioBtnBG, "Static_RB_ConsoleUI")
  self._ui.stc_mainSelectBar = UI.getChildControl(self._ui.stc_radioBtnBG, "Static_SelectBar")
  self._ui.stc_deliveryBG = UI.getChildControl(Panel_Window_Delivery_All, "Static_DeliveryBg")
  self._ui._console.stc_LTkey = UI.getChildControl(self._ui.stc_deliveryBG, "Static_LT_ConsoleUI")
  self._ui._console.stc_RTkey = UI.getChildControl(self._ui.stc_deliveryBG, "Static_RT_ConsoleUI")
  self._ui.radio_transList = UI.getChildControl(self._ui.stc_deliveryBG, "RadioButton_Tranlist")
  self._ui.radio_allTransList = UI.getChildControl(self._ui.stc_deliveryBG, "RadioButton_AllTranlist")
  self._ui.stc_subSelectBar = UI.getChildControl(self._ui.stc_deliveryBG, "Static_SelectBar")
  self._ui.stc_deliveryListBG = UI.getChildControl(Panel_Window_Delivery_All, "Static_DeliveryListBg")
  self._ui.list_delivery = UI.getChildControl(self._ui.stc_deliveryListBG, "List2_Delivery")
  self._ui.txt_empty = UI.getChildControl(self._ui.stc_deliveryListBG, "StaticText_Empty_List")
  self._ui._console.stc_bottomBG = UI.getChildControl(Panel_Window_Delivery_All, "Static_BottomBg_ConsoleUI")
  self._ui._console.txt_recive = UI.getChildControl(self._ui._console.stc_bottomBG, "StaticText_Receive_ConsoleUI")
  self._ui._console.txt_reciveAll = UI.getChildControl(self._ui._console.stc_bottomBG, "StaticText_ReceiveAll_ConsoleUI")
  self._ui._console.txt_close = UI.getChildControl(self._ui._console.stc_bottomBG, "Button_B_ConsoleUI")
  self._ui._console.txt_send = UI.getChildControl(self._ui._console.stc_bottomBG, "StaticText_Send_ConsoleUI")
  self._ui._console.txt_select = UI.getChildControl(self._ui._console.stc_bottomBG, "Button_A_ConsoleUI")
  self._ui._console.txt_cancel = UI.getChildControl(self._ui._console.stc_bottomBG, "StaticText_Cancel_ConsoleUI")
  self._ui._pc.btn_receiveAll = UI.getChildControl(Panel_Window_Delivery_All, "Button_ReceiveAll")
  self._ui.stc_sendBG = UI.getChildControl(Panel_Window_Delivery_All, "Static_SendBg")
  self._ui.combo_destination = UI.getChildControl(self._ui.stc_sendBG, "Combobox2_Destination")
  self._ui.combo_carriage = UI.getChildControl(self._ui.stc_sendBG, "Combobox2_CarriageSelect")
  self._ui.txt_carriageCountValue = UI.getChildControl(self._ui.stc_sendBG, "StaticText_CarriageCountValue")
  self._ui.txt_weightValue = UI.getChildControl(self._ui.stc_sendBG, "StaticText_WeightValue")
  self._ui.txt_possibleCountValue = UI.getChildControl(self._ui.stc_sendBG, "StaticText_PossibleCountValue")
  self._ui.stc_feeBG = UI.getChildControl(self._ui.stc_sendBG, "Static_FeeBg")
  self._ui.txt_totalFeeValue = UI.getChildControl(self._ui.stc_feeBG, "StaticText_TotalFeeValue")
  self._ui.stc_itemListBG = UI.getChildControl(self._ui.stc_sendBG, "Static_ItemListBg")
  self._ui.stc_itemSlotTemplete = UI.getChildControl(self._ui.stc_itemListBG, "Static_ItemSlotBgTemplate")
  self._ui.stc_lockIcon = UI.getChildControl(self._ui.stc_itemSlotTemplete, "Static_LockIcon")
  self._ui._pc.btn_delivery = UI.getChildControl(self._ui.stc_sendBG, "Button_Delivery")
  self._ui.stc_DescBG = UI.getChildControl(self._ui.stc_sendBG, "Static_DescBG")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_DescBG, "StaticText_Desc")
  local isPc = false == self._isConsole
  for k, v in pairs(self._ui._pc) do
    v:SetShow(isPc)
  end
  for k, v in pairs(self._ui._console) do
    v:SetShow(self._isConsole)
  end
  if true == self._isConsole then
    self._ui.stc_itemSlotTemplete:ChangeOnTextureInfoName("renewal/frame/console_frame_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_itemSlotTemplete, 50, 195, 94, 239)
    self._ui.stc_itemSlotTemplete:getOnTexture():setUV(x1, y1, x2, y2)
  end
  local list2_Content = UI.getChildControl(self._ui.list_delivery, "List2_Delivery_Content")
  local list2_ItemSlot = UI.getChildControl(list2_Content, "Static_SlotBg")
  local slot = {}
  SlotItem.new(slot, "Delivery_Slot_Icon_", 0, list2_ItemSlot, PaGlobal_Delivery_All.slotConfig)
  slot:createChild()
  local slotSizeX = self._ui.stc_itemSlotTemplete:GetSizeX()
  local slotSizeY = self._ui.stc_itemSlotTemplete:GetSizeY()
  local bgHalfSize = self._ui.stc_itemListBG:GetSizeX() * 0.5
  local iconColumsSizeX = (slotSizeX + self.config.slotGap) * self.config.slotCols * 0.5
  self.config.slotStartX = math.abs(bgHalfSize - iconColumsSizeX)
  self.config.slotRows = self.config.slotCount / self.config.slotCols
  for ii = 0, self.config.slotCount - 1 do
    self.slotBGs[ii] = UI.createControl(__ePAUIControl_Static, self._ui.stc_itemListBG, "StaticSlotBG_" .. ii)
    CopyBaseProperty(self._ui.stc_itemSlotTemplete, self.slotBGs[ii])
    local slot = {
      base = {},
      slotNo = ii,
      panel = Panel_Window_Delivery_All
    }
    local row = math.floor(slot.slotNo / self.config.slotCols)
    local col = slot.slotNo % self.config.slotCols
    self.slotBGs[ii]:SetPosX(self.config.slotStartX + (slotSizeX + self.config.slotGap) * col)
    self.slotBGs[ii]:SetPosY(self.config.slotStartY + (slotSizeY + self.config.slotGap) * row)
    self.slotBGs[ii]:SetShow(true)
    SlotItem.new(slot.base, "ItemSlot_" .. slot.slotNo, slot.slotNo, self.slotBGs[ii], self.slotConfig)
    slot.base:createChild()
    slot.base.icon:SetVerticalMiddle()
    slot.base.icon:SetHorizonCenter()
    if true == self._isConsole then
      slot.base.icon:addInputEvent("Mouse_LUp", "HandleEventRUp_DeliveryAll_SlotRClick(" .. ii .. ")")
      self.slotBGs[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventPad_DeliveryAll_IconTooltip(" .. ii .. ")")
    else
      slot.base.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_DeliveryAll_SlotRClick(" .. ii .. ")")
    end
    slot.base.icon:addInputEvent("Mouse_On", "HandleEventOn_DeliveryAll_IconTooltip(true, " .. ii .. ")")
    slot.base.icon:addInputEvent("Mouse_Out", "HandleEventOn_DeliveryAll_IconTooltip(false, " .. ii .. ")")
    Panel_Tooltip_Item_SetPosition(ii, slot.base, "DeliveryRequest")
    slot.base.icon:SetIgnore(false)
    slot.base.icon:SetShow(true)
    self.slots[ii] = slot
  end
  self._ui.stc_itemSlotTemplete:SetShow(false)
  local comboCarriage = self._ui.combo_carriage
  local comboDestination = self._ui.combo_destination
  Panel_Window_Delivery_All:SetChildIndex(comboCarriage, 999)
  Panel_Window_Delivery_All:SetChildIndex(comboDestination, 9999)
  comboCarriage:setListTextHorizonCenter()
  comboDestination:setListTextHorizonCenter()
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "Lua_DELIVERY_HELPDESC"))
  self._ui.txt_desc:SetSize(560, self._ui.txt_desc:GetTextSizeY() + 5)
  self._ui.txt_desc:ComputePos()
  PaGlobal_Delivery_All:registerEventHandler()
  PaGlobal_Delivery_All:validate()
  if true == self._isConsole then
    local buttonSizeY = self._ui._pc.btn_receiveAll:GetSizeY()
    Panel_Window_Delivery_All:SetSize(Panel_Window_Delivery_All:GetSizeX(), Panel_Window_Delivery_All:GetSizeY() - buttonSizeY)
    self._ui.stc_deliveryListBG:SetSize(self._ui.stc_deliveryListBG:GetSizeX(), self._ui.stc_deliveryListBG:GetSizeY() - buttonSizeY)
    self._ui.stc_sendBG:SetSize(self._ui.stc_sendBG:GetSizeX(), self._ui.stc_sendBG:GetSizeY() - buttonSizeY)
  end
  self._originPanelSizeY = Panel_Window_Delivery_All:GetSizeY()
  self._originBgSizeY = self._ui.stc_deliveryListBG:GetSizeY()
  self._originSendBgSizeY = self._ui.stc_sendBG:GetSizeY()
  self._originDescBgSizeY = self._ui.stc_DescBG:GetSizeY()
  PaGlobal_Delivery_All._initialize = true
end
function PaGlobal_Delivery_All:registerEventHandler()
  if false == self._isConsole then
    self._ui._pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Delivery_All:prepareClose()")
    self._ui._pc.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle(\"DeliveryRequest\")")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui._pc.btn_question, "\"DeliveryRequest\"")
    self._ui.radio_delivery:addInputEvent("Mouse_LUp", "HandleEventLUp_DeliveryAll_MainRadioButton(true)")
    self._ui.radio_send:addInputEvent("Mouse_LUp", "HandleEventLUp_DeliveryAll_MainRadioButton(false)")
    self._ui.radio_transList:addInputEvent("Mouse_LUp", "HandleEventLUp_DeliveryAll_SubRadioButton(true)")
    self._ui.radio_allTransList:addInputEvent("Mouse_LUp", "HandleEventLUp_DeliveryAll_SubRadioButton(false)")
    self._ui._pc.btn_receiveAll:addInputEvent("Mouse_LUp", "HandleEventLUp_DeliveryAll_ReceiveAll()")
    self._ui._pc.btn_delivery:addInputEvent("Mouse_LUp", "HandleEventLUp_DeliveryAll_SendCheckNode()")
  end
  self._ui.combo_carriage:addInputEvent("Mouse_LUp", "HandleEventLUp_DeliveryAll_ShowToDeliverer()")
  self._ui.combo_destination:addInputEvent("Mouse_LUp", "HandleEventLUp_DeliveryAll_ShowToWaypointKey()")
  self._ui.combo_carriage:GetListControl():AddSelectEvent("HandleEnvetLUp_DeliveryRequest_SelectToDeliverer()")
  self._ui.combo_destination:GetListControl():AddSelectEvent("HandleEventLUp_DeliveryAll_SelectToWaypointKey()")
  Panel_Window_Delivery_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventPad_DeliveryAll_LBRB(true)")
  Panel_Window_Delivery_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventPad_DeliveryAll_LBRB(false)")
  Panel_Window_Delivery_All:registerPadEvent(__eConsoleUIPadEvent_LT, "HandleEventPad_DeliveryAll_LTRT(true)")
  Panel_Window_Delivery_All:registerPadEvent(__eConsoleUIPadEvent_RT, "HandleEventPad_DeliveryAll_LTRT(false)")
  Panel_Window_Delivery_All:registerPadEvent(__eConsoleUIPadEvent_Y, "HandleEventPad_DeliveryAll_PadEventY()")
  self._ui.list_delivery:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_DeliveryAll_CreateDeliveryList")
  self._ui.list_delivery:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_MoveDeliveryItem", "DeliveryInformation_UpdateSlotData")
  registerEvent("FromClient_DeliveryReceiveItemClear", "FromClient_DeliveryAll_DeliveryReceiveItemClear")
  registerEvent("FromClient_InActiveDeleteButton", "FromClient_DeliveryAll_InActiveDeleteButton")
  registerEvent("FromClient_DeliveryRequestItemClear", "FromClient_DeliveryAll_DeliveryRequestItemClear")
  registerEvent("onScreenResize", "FromClient_Warehouse_All_OnScreenResize")
end
function PaGlobal_Delivery_All:deliveryInformation_Open()
  self:updateSubRadioButton(true)
  PaGlobal_Delivery_All._scrollIndex = 0
  ToClient_NewDeliveryClearPack()
  if _ContentsGroup_NewUI_WareHouse_All then
    FromClient_Warehouse_All_Update()
  else
    FromClient_WarehouseUpdate()
  end
end
function PaGlobal_Delivery_All:deliveryInformation_UpdateSlot()
  if nil == Panel_Window_Delivery_All then
    return
  end
  PaGlobal_Delivery_All._ui.txt_empty:SetShow(false)
  PaGlobal_Delivery_All._ui.list_delivery:getElementManager():clearKey()
  local delivererCount = ToClient_NewDeliveryGetDelivererCount()
  if true == PaGlobal_Delivery_All._isTransList then
    local regionKey = ToClient_NewDeliveryGetRegionKey(PaGlobal_Delivery_All._currentWaypointKey)
    local deliveryCount = ToClient_NewDeliveryListSizeByRegionKey(regionKey)
    if 0 == deliveryCount then
      PaGlobal_Delivery_All._ui.txt_empty:SetShow(true)
      return
    end
    for ii = 0, delivererCount - 1 do
      local delivererInfo = ToClient_NewDeliveryGetDeliverer(ii)
      if nil ~= delivererInfo then
        local currentTime = getServerUtc64()
        if regionKey:get() == delivererInfo:getFromRegionKey():get() then
          if true == delivererInfo:isCancelable(regionKey, currentTime) then
            local itemCount = delivererInfo:getDeliveryItemCount()
            for itemIdx = 0, itemCount - 1 do
              PaGlobal_Delivery_All._ui.list_delivery:getElementManager():pushKey(toInt64(0, itemIdx * 10 + ii))
            end
          end
        elseif regionKey:get() == delivererInfo:getToRegionKey():get() and true == delivererInfo:isReceivable(regionKey, currentTime) then
          local itemCount = delivererInfo:getDeliveryItemCount()
          for itemIdx = 0, itemCount - 1 do
            PaGlobal_Delivery_All._ui.list_delivery:getElementManager():pushKey(toInt64(0, itemIdx * 10 + ii))
          end
        end
      end
    end
  else
    local deliveryCount = ToClient_NewDeliveryListSize()
    if 0 == deliveryCount then
      PaGlobal_Delivery_All._ui.txt_empty:SetShow(true)
      return
    end
    for ii = 0, delivererCount - 1 do
      local delivererInfo = ToClient_NewDeliveryGetDeliverer(ii)
      if nil ~= delivererInfo then
        local itemCount = delivererInfo:getDeliveryItemCount()
        for itemIdx = 0, itemCount - 1 do
          PaGlobal_Delivery_All._ui.list_delivery:getElementManager():pushKey(toInt64(0, itemIdx * 10 + ii))
        end
      end
    end
  end
  PaGlobal_Delivery_All._ui.list_delivery:moveIndex(PaGlobal_Delivery_All._scrollIndex)
end
function PaGlobal_Delivery_All:deliveryInformation_CreateDeliveryList(content, key)
  local slotKey = Int64toInt32(key)
  local delivererIndex = slotKey % 10
  local itemIndex = math.floor(slotKey * 0.1)
  local currentTime = getServerUtc64()
  local regionKey = ToClient_NewDeliveryGetRegionKey(PaGlobal_Delivery_All._currentWaypointKey)
  local delivererInfo = ToClient_NewDeliveryGetDeliverer(delivererIndex)
  if nil == delivererInfo then
    return
  end
  local itemWrapper = delivererInfo:getDeliveryItemWrapper(itemIndex)
  if nil == itemWrapper then
    return
  end
  local contentsBG = UI.getChildControl(content, "Button_DeliverySlot")
  contentsBG:setNotImpactScrollEvent(true)
  if false == self._isConsole then
    contentsBG:SetIgnore(true)
  else
    contentsBG:SetIgnore(false)
  end
  local slot = {}
  local itemSlot = UI.getChildControl(content, "Static_SlotBg")
  itemSlot:SetShow(true)
  itemSlot:SetPosX(15)
  itemSlot:SetPosY(15)
  itemSlot:SetSize(45, 45)
  SlotItem.reInclude(slot, "Delivery_Slot_Icon_", 0, itemSlot, PaGlobal_Delivery_All.slotConfig)
  slot:setItem(itemWrapper)
  local departure = UI.getChildControl(content, "StaticText_StartTownName")
  departure:SetShow(true)
  departure:SetIgnore(false)
  departure:SetTextMode(__eTextMode_LimitText)
  departure:SetText(ToClient_regionKeyToName(delivererInfo:getFromRegionKey()))
  departure:SetPosX(75)
  departure:SetPosY(18)
  local arrow = UI.getChildControl(content, "StaticText_Arrow")
  arrow:SetShow(true)
  arrow:SetPosX(departure:GetPosX() + departure:GetTextSizeX() + 10)
  arrow:SetPosY(18)
  local destination = UI.getChildControl(content, "StaticText_ArrivalTownName")
  destination:SetShow(true)
  destination:SetIgnore(false)
  destination:SetTextMode(__eTextMode_LimitText)
  destination:SetText(ToClient_regionKeyToName(delivererInfo:getToRegionKey()))
  destination:SetPosX(arrow:GetPosX() + arrow:GetSizeX() + 10)
  destination:SetPosY(18)
  local carriageNumber = UI.getChildControl(content, "StaticText_Title_CariageType")
  local leftTime = delivererInfo:getRemainTime()
  carriageNumber:SetShow(true)
  carriageNumber:SetTextMode(__eTextMode_LimitText)
  if 0 ~= leftTime then
    carriageNumber:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_DELIVERY_REMAINTIME", "number", tostring(delivererIndex + 1) .. "", "time", Util.Time.timeFormatting_Minute(leftTime)))
  elseif 5 == delivererIndex then
    carriageNumber:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DELIVERYNEW_FIVENUMBER_CARRIAGE"))
  else
    carriageNumber:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DELIVERYNEW_NUMBEROF_CARRIAGE", "number", tostring(delivererIndex + 1)))
  end
  if true == self._isConsole then
    if true == carriageNumber:IsLimitText() or true == destination:IsLimitText() or true == departure:IsLimitText() then
      contentsBG:addInputEvent("Mouse_On", "HandleEventOn_DeliveryAll_ConsoleTooltip(" .. slotKey .. ")")
      contentsBG:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
    else
      contentsBG:addInputEvent("Mouse_On", "")
    end
  else
    if true == carriageNumber:IsLimitText() then
      carriageNumber:addInputEvent("Mouse_On", "HandleEventOnOut_DeliveryAll_Tooltip(" .. slotKey .. ", true, 0)")
      carriageNumber:addInputEvent("Mouse_Out", "HandleEventOnOut_DeliveryAll_Tooltip(" .. slotKey .. ", false)")
    end
    if true == destination:IsLimitText() then
      destination:addInputEvent("Mouse_On", "HandleEventOnOut_DeliveryAll_Tooltip(" .. slotKey .. ", true, 1)")
      destination:addInputEvent("Mouse_Out", "HandleEventOnOut_DeliveryAll_Tooltip(" .. slotKey .. ", false)")
    end
    if true == departure:IsLimitText() then
      departure:addInputEvent("Mouse_On", "HandleEventOnOut_DeliveryAll_Tooltip(" .. slotKey .. ", true, 2)")
      departure:addInputEvent("Mouse_Out", "HandleEventOnOut_DeliveryAll_Tooltip(" .. slotKey .. ", false)")
    end
  end
  local receive = UI.getChildControl(content, "Button_List2_Receive_PCUI")
  local cancel = UI.getChildControl(content, "Button_List2_Cancel_PCUI")
  local state = UI.getChildControl(content, "Button_State")
  receive:setNotImpactScrollEvent(true)
  cancel:setNotImpactScrollEvent(true)
  if true == PaGlobal_Delivery_All._isTransList then
    state:SetShow(false)
    receive:SetShow(false)
    cancel:SetShow(false)
    contentsBG:registerPadEvent(__eConsoleUIPadEvent_X, "")
    contentsBG:registerPadEvent(__eConsoleUIPadEvent_A, "")
    if true == delivererInfo:isCancelable(regionKey, currentTime) then
      if true == self._isConsole then
        contentsBG:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventLUp_DeliveryAll_Cancel(" .. delivererIndex .. ", " .. itemIndex .. ")")
      end
      cancel:SetShow(not self._isConsole)
    elseif true == delivererInfo:isReceivable(regionKey, currentTime) then
      if true == self._isConsole then
        contentsBG:registerPadEvent(__eConsoleUIPadEvent_A, "HandleEventLUp_DeliveryAll_Receive(" .. delivererIndex .. ", " .. itemIndex .. " )")
      end
      receive:SetShow(not self._isConsole)
    end
  else
    receive:SetShow(false)
    cancel:SetShow(false)
    state:SetShow(true)
    contentsBG:registerPadEvent(__eConsoleUIPadEvent_X, "")
    contentsBG:registerPadEvent(__eConsoleUIPadEvent_A, "")
    if true == delivererInfo:isCancelable(delivererInfo:getToRegionKey(), currentTime) then
      state:SetText(PAGetString(Defines.StringSheet_RESOURCE, "DELIVERY_INFORMATION_BTN_READY"))
    elseif true == delivererInfo:isReceivable(delivererInfo:getToRegionKey(), currentTime) then
      state:SetText(PAGetString(Defines.StringSheet_RESOURCE, "DELIVERY_INFORMATION_BTN_COMPLETE"))
    else
      state:SetText(PAGetString(Defines.StringSheet_RESOURCE, "DELIVERY_INFORMATION_BTN_ING"))
    end
  end
  receive:addInputEvent("Mouse_LUp", "HandleEventLUp_DeliveryAll_Receive(" .. delivererIndex .. ", " .. itemIndex .. " )")
  cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_DeliveryAll_Cancel(" .. delivererIndex .. ", " .. itemIndex .. ")")
  slot.icon:addInputEvent("Mouse_On", "HandleEventMO_DeliveryAll_ItemTooltipShow(" .. delivererIndex .. ", " .. itemIndex .. ", true)")
  slot.icon:addInputEvent("Mouse_Out", "HandleEventMO_DeliveryAll_ItemTooltipShow(" .. delivererIndex .. ", " .. itemIndex .. ", false)")
  if slotKey > PaGlobal_Delivery_All._scrollIndex then
    PaGlobal_Delivery_All._scrollIndex = slotKey - 8
  else
    PaGlobal_Delivery_All._scrollIndex = slotKey
  end
end
function PaGlobal_Delivery_All:sendRequest_Open()
  local carriageBox = self._ui.combo_carriage
  local destinationBox = self._ui.combo_destination
  carriageBox:DeleteAllItem()
  carriageBox:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DELIVERY_DELIVERER"))
  destinationBox:DeleteAllItem()
  destinationBox:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DELIVERY_SELECT_TO_REGION"))
  self._selectWaypointKey = -1
  self._selectDestination = -1
  self._selectDeliverer = -1
  self:sendRequest_UpdateDestination()
  self:sendRequest_updateCarriage()
  self._ui.txt_weightValue:SetText("0/0 " .. PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_TXT_LT"))
  PaGlobal_Delivery_All._ui.txt_possibleCountValue:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_DELIVERYNEW_PACKINGCOUNT", "packingCount", 0, "totalCount", 20))
  self._ui.txt_totalFeeValue:SetText("0")
  ToClient_NewDeliveryClearPack()
  PaGlobal_Delivery_All:sendRequest_clearSlot()
  if _ContentsGroup_NewUI_WareHouse_All then
    FromClient_Warehouse_All_Update()
  else
    FromClient_WarehouseUpdate()
  end
end
function PaGlobal_Delivery_All:sendRequest_Update()
  if nil == Panel_Window_Delivery_All then
    return
  end
  local delivererInfo, currentCount = nil, 0
  if -1 ~= self._selectCarriageKey[self._selectDeliverer] and nil ~= self._selectCarriageKey[self._selectDeliverer] then
    delivererInfo = ToClient_NewDeliveryGetDeliverer(self._selectCarriageKey[self._selectDeliverer])
    if nil ~= delivererInfo then
      currentCount = delivererInfo:getDeliveryItemCount()
    end
  end
  local selectedCarriageIndex = self._selectCarriageKey[self._selectDeliverer]
  if nil == selectedCarriageIndex then
    return
  end
  local totalPrice = Int64toInt32(Toclient_NewDeliveryGetPackItemTotalPrice(DeliveryInformation_WaypointKey(), self._selectWaypointKey, selectedCarriageIndex))
  local totalCount = currentCount + ToClient_NewDeliveryGetPackCount()
  self._ui.txt_possibleCountValue:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_DELIVERYNEW_PACKINGCOUNT", "packingCount", tostring(totalCount), "totalCount", 20))
  self._ui.txt_totalFeeValue:SetText("" .. makeDotMoney(totalPrice))
  self._ui.txt_carriageCountValue:ComputePos()
  self._ui.txt_weightValue:ComputePos()
  self._ui.txt_possibleCountValue:ComputePos()
  local maxCarriageWeight = ToClient_NewDeliveryGetMaxWeightPerCarriage(self._selectCarriageKey[self._selectDeliverer])
  if -1 ~= self._selectCarriageKey[self._selectDeliverer] then
    local remainWeight = ToClient_NewDeliveryGetRemainWeight(self._selectCarriageKey[self._selectDeliverer])
    self._ui.txt_weightValue:SetText(tostring(math.floor(remainWeight * 1.0E-4)) .. "/" .. tostring(maxCarriageWeight * 1.0E-4) .. PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_TXT_LT"))
  else
    self._ui.txt_weightValue:SetText("0/" .. tostring(maxCarriageWeight * 1.0E-4) .. PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_TXT_LT"))
  end
  self:sendRequest_clearSlot()
  for ii = 0, self.config.slotCount - 1 do
    local itemWrapper = ToClient_NewDeliveryGetPackItemBySlotNo(ii)
    if nil ~= itemWrapper then
      self.slots[ii].base:setItem(itemWrapper)
    end
  end
end
function PaGlobal_Delivery_All:sendRequest_UpdateDestination()
  if nil == Panel_Window_Delivery_All then
    return
  end
  local destinationBox = self._ui.combo_destination
  destinationBox:DeleteAllItem()
  local waypointKeyList = ToClient_NewDeliveryGetListWaypointKey(DeliveryInformation_WaypointKey(), false)
  if nil ~= waypointKeyList then
    local size = waypointKeyList:size()
    if 0 == size then
      destinationBox:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DELIVERY_NOT_CONNECT_REGION"))
      return
    end
    for ii = 0, size - 1 do
      destinationBox:AddItem(waypointKeyList:atPointer(ii):getName())
    end
  end
end
function PaGlobal_Delivery_All:sendRequest_updateCarriage(destination)
  if nil == Panel_Window_Delivery_All then
    return
  end
  local comboBox = self._ui.combo_carriage
  local selectedCarriageIndex = comboBox:GetSelectIndex()
  comboBox:DeleteAllItem()
  self._selectCarriageKey = {}
  local size = ToClient_NewDeliveryGetDelivererCount()
  PaGlobal_Delivery_All.usableCount = 0
  local isSaveSelected = true
  local index = 0
  for ii = 0, size - 1 do
    local delivererInfo = ToClient_NewDeliveryGetWaitingDeliverer(ii)
    local isView = false
    if nil ~= delivererInfo then
      if 0 < delivererInfo:getDeliveryItemCount() and nil ~= destination then
        local nowToRegionKey = getRegionInfoByRegionKey(delivererInfo:getToRegionKey()):getRegionKey()
        local nowFromRegionKey = getRegionInfoByRegionKey(delivererInfo:getFromRegionKey()):getRegionKey()
        local regionKey = ToClient_getRegionInfoWrapperByWaypoint(PaGlobal_Delivery_All._currentWaypointKey):getRegionKey()
        local destRegionKey = ToClient_getRegionInfoWrapperByWaypoint(destination):getRegionKey()
        if nowToRegionKey == destRegionKey and regionKey == nowFromRegionKey then
          isView = true
        else
          local selectedDelivererInfo = ToClient_NewDeliveryGetWaitingDeliverer(selectedCarriageIndex)
          if nil ~= selectedDelivererInfo and selectedDelivererInfo:getDeliveryIndex() == delivererInfo:getDeliveryIndex() and -1 ~= delivererInfo:getDeliveryIndex() then
            isSaveSelected = false
          end
        end
      else
        isView = true
      end
    end
    if true == isView then
      local str
      if 5 == ii then
        str = PAGetString(Defines.StringSheet_GAME, "LUA_DELIVERYNEW_FIVENUMBER_CARRIAGE")
      else
        str = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DELIVERYNEW_NUMBEROF_CARRIAGE", "number", tostring(ii + 1))
      end
      comboBox:AddItem(str)
      self._selectCarriageKey[index] = ii
      index = index + 1
      PaGlobal_Delivery_All.usableCount = PaGlobal_Delivery_All.usableCount + 1
    end
  end
  PaGlobal_Delivery_All._ui.txt_carriageCountValue:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DELIVERYNEW_REMAIN_SENDCOUNT", "count", tostring(PaGlobal_Delivery_All.usableCount)))
  if 0 == PaGlobal_Delivery_All.usableCount then
    PaGlobal_Delivery_All._selectDeliverer = -1
    comboBox:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DELIVERYNEW_NOT_CARRIAGE"))
  elseif nil ~= destination and true == isSaveSelected then
    comboBox:SetSelectItemIndex(selectedCarriageIndex)
    PaGlobal_Delivery_All._selectDeliverer = selectedCarriageIndex
  elseif false == isSaveSelected then
    PaGlobal_Delivery_All._selectDeliverer = -1
    comboBox:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DELIVERY_DELIVERER"))
  end
end
function PaGlobal_Delivery_All:sendRequest_clearSlot()
  if nil == Panel_Window_Delivery_All then
    return
  end
  for ii = 0, PaGlobal_Delivery_All.config.slotCount - 1 do
    PaGlobal_Delivery_All.slots[ii].base:clearItem()
  end
end
function PaGlobal_Delivery_All:prepareOpen()
  if nil == Panel_Window_Delivery_All then
    return
  end
  self:updateMainRadioButton(true)
  if true == _ContentsGroup_NewUI_WareHouse_All then
    PaGlobal_Warehouse_All_SetIgnoreMoneyButton(true)
  else
    Warehouse_SetIgnoreMoneyButton(true)
  end
  if ToClient_WorldMapIsShow() then
    if nil ~= Panel_Window_WareHouse_Search and true == Panel_Window_WareHouse_Search:GetShow() then
      WorldMapPopupManager:popWantPanel(Panel_Window_WareHouse_Search)
    end
    if nil ~= Panel_Window_Barter_Search and true == Panel_Window_Barter_Search:GetShow() then
      WorldMapPopupManager:popWantPanel(Panel_Window_Barter_Search)
    end
    WorldMapPopupManager:push(Panel_Window_Delivery_All, true)
  end
  PaGlobal_Delivery_All:open()
  FromClient_Warehouse_All_OnScreenResize()
end
function PaGlobal_Delivery_All:open()
  if nil == Panel_Window_Delivery_All then
    return
  end
  Panel_Window_Delivery_All:SetShow(true)
  if true == _ContentsGroup_NewUI_WareHouse_All then
    PaGlobal_Warehouse_All_TownListCheck()
  else
    FGlobal_WarehouseTownListCheck()
  end
end
function PaGlobal_Delivery_All:prepareClose()
  if nil == Panel_Window_Delivery_All then
    return
  end
  TooltipSimple_Hide()
  if true == self._ui.combo_destination:isClicked() then
    self._ui.combo_destination:ToggleListbox()
  end
  if true == self._ui.combo_carriage:isClicked() then
    self._ui.combo_carriage:ToggleListbox()
  end
  if true == _ContentsGroup_NewDelivery then
    ToClient_NewDeliveryClearPack()
  else
    clearDeliveryPack()
  end
  if ToClient_WorldMapIsShow() then
    if Panel_Window_Delivery_All:GetShow() then
      WorldMapPopupManager:popWantPanel(Panel_Window_Delivery_All)
    end
  elseif Panel_Window_Delivery_All:GetShow() then
    PaGlobal_Delivery_All:close()
  end
  if _ContentsGroup_NewUI_WareHouse_All then
    FromClient_Warehouse_All_Update()
  else
    FromClient_WarehouseUpdate()
  end
end
function PaGlobal_Delivery_All:close()
  if nil == Panel_Window_Delivery_All then
    return
  end
  Panel_Window_Delivery_All:SetShow(false)
end
function PaGlobal_Delivery_All:validate()
  self._ui.stc_topBG:isValidate()
  self._ui._pc.btn_close:isValidate()
  self._ui._pc.btn_question:isValidate()
  self._ui.stc_radioBtnBG:isValidate()
  self._ui.radio_delivery:isValidate()
  self._ui.radio_send:isValidate()
  self._ui._console.stc_LBkey:isValidate()
  self._ui._console.stc_RBkey:isValidate()
  self._ui.stc_mainSelectBar:isValidate()
  self._ui.stc_deliveryBG:isValidate()
  self._ui._console.stc_LTkey:isValidate()
  self._ui._console.stc_RTkey:isValidate()
  self._ui.radio_transList:isValidate()
  self._ui.radio_allTransList:isValidate()
  self._ui.stc_subSelectBar:isValidate()
  self._ui.stc_deliveryListBG:isValidate()
  self._ui.list_delivery:isValidate()
  self._ui.txt_empty:isValidate()
  self._ui._console.stc_bottomBG:isValidate()
  self._ui._console.txt_recive:isValidate()
  self._ui._console.txt_reciveAll:isValidate()
  self._ui._console.txt_close:isValidate()
  self._ui._console.txt_send:isValidate()
  self._ui._console.txt_select:isValidate()
  self._ui._console.txt_cancel:isValidate()
  self._ui._pc.btn_receiveAll:isValidate()
  self._ui.stc_sendBG:isValidate()
  self._ui.combo_destination:isValidate()
  self._ui.combo_carriage:isValidate()
  self._ui.txt_carriageCountValue:isValidate()
  self._ui.txt_weightValue:isValidate()
  self._ui.txt_possibleCountValue:isValidate()
  self._ui.stc_feeBG:isValidate()
  self._ui.txt_totalFeeValue:isValidate()
  self._ui.stc_itemListBG:isValidate()
  self._ui.stc_itemSlotTemplete:isValidate()
  self._ui.stc_lockIcon:isValidate()
  self._ui._pc.btn_delivery:isValidate()
  self._ui.stc_DescBG:isValidate()
  self._ui.txt_desc:isValidate()
end
function PaGlobal_Delivery_All:updateMainRadioButton(isDelivery)
  local btn_Delivery = self._ui.radio_delivery
  local btn_Send = self._ui.radio_send
  if true == PaGlobal_Delivery_All._ui.combo_destination:isClicked() then
    PaGlobal_Delivery_All._ui.combo_destination:ToggleListbox()
  end
  if true == PaGlobal_Delivery_All._ui.combo_carriage:isClicked() then
    PaGlobal_Delivery_All._ui.combo_carriage:ToggleListbox()
  end
  self._isDeliveyCheck = isDelivery
  btn_Delivery:SetCheck(isDelivery)
  btn_Send:SetCheck(false == isDelivery)
  local stc_Bar = self._ui.stc_mainSelectBar
  local barHalfSize = stc_Bar:GetSizeX() * 0.5
  local centerPos = float2()
  if true == isDelivery then
    local btnHalfSize = btn_Delivery:GetSizeX() * 0.5
    centerPos.x = btn_Delivery:GetPosX() + btnHalfSize - barHalfSize
    centerPos.y = stc_Bar:GetPosY()
    self:deliveryInformation_Open()
  else
    local btnHalfSize = btn_Send:GetSizeX() * 0.5
    centerPos.x = btn_Send:GetPosX() + btnHalfSize - barHalfSize
    centerPos.y = stc_Bar:GetPosY()
    self:sendRequest_Open()
    self._preTransListClick = false
  end
  self._ui.stc_mainSelectBar:SetPosX(centerPos.x)
  self._ui.stc_mainSelectBar:SetPosY(centerPos.y)
  self._ui.stc_sendBG:SetShow(false == isDelivery)
  self._ui.stc_deliveryBG:SetShow(isDelivery)
  self:setShowReceiveAllButton(isDelivery)
  self._ui.stc_deliveryListBG:SetShow(isDelivery)
  Panel_Window_Delivery_All:SetSize(Panel_Window_Delivery_All:GetSizeX(), self._originPanelSizeY)
  self._ui.stc_deliveryListBG:SetSize(self._ui.stc_deliveryListBG:GetSizeX(), self._originBgSizeY)
  if true == isDelivery then
    self._ui.stc_DescBG:SetSize(self._ui.stc_DescBG:GetSizeX(), self._originDescBgSizeY)
    self._ui.stc_sendBG:SetSize(self._ui.stc_sendBG:GetSizeX(), self._originSendBgSizeY)
    Panel_Window_Delivery_All:SetSize(Panel_Window_Delivery_All:GetSizeX(), self._originPanelSizeY)
  else
    local textSizeY = self._ui.txt_desc:GetTextSizeY()
    local gapY = 5
    if self._originDescBgSizeY < textSizeY + gapY then
      local addSize = textSizeY + gapY - self._originDescBgSizeY
      self._ui.stc_DescBG:SetSize(self._ui.stc_DescBG:GetSizeX(), self._originDescBgSizeY + addSize)
      self._ui.stc_sendBG:SetSize(self._ui.stc_sendBG:GetSizeX(), self._originSendBgSizeY + addSize)
      Panel_Window_Delivery_All:SetSize(Panel_Window_Delivery_All:GetSizeX(), self._originPanelSizeY + addSize)
    end
  end
  self._ui.stc_DescBG:ComputePos()
  self._ui.stc_sendBG:ComputePos()
  self._ui._pc.btn_delivery:ComputePos()
  self._ui._console.stc_bottomBG:ComputePos()
  self:updateConsoleKeyEnable()
end
function PaGlobal_Delivery_All:updateSubRadioButton(isTransList)
  if false == self._isDeliveyCheck then
    return
  end
  local btn_TransList = self._ui.radio_transList
  local btn_AllTransList = self._ui.radio_allTransList
  local stc_Bar = self._ui.stc_subSelectBar
  self._isTransList = isTransList
  btn_TransList:SetCheck(isTransList)
  btn_AllTransList:SetCheck(false == isTransList)
  local barHalfSize = stc_Bar:GetSizeX() * 0.5
  local centerPos = float2()
  if true == isTransList then
    local btnHalfSize = btn_TransList:GetSizeX() * 0.5
    centerPos.x = btn_TransList:GetPosX() + btnHalfSize - barHalfSize
    centerPos.y = stc_Bar:GetPosY()
  else
    local btnHalfSize = btn_AllTransList:GetSizeX() * 0.5
    centerPos.x = btn_AllTransList:GetPosX() + btnHalfSize - barHalfSize
    centerPos.y = stc_Bar:GetPosY()
  end
  self._scrollIndex = 0
  self:deliveryInformation_UpdateSlot()
  self._ui.stc_subSelectBar:SetPosX(centerPos.x)
  self._ui.stc_subSelectBar:SetPosY(centerPos.y)
  self:setShowReceiveAllButton(isTransList)
  if self._preTransListClick == isTransList then
    return
  end
  self._preTransListClick = isTransList
  local panelSizeY = 1
  local padding = 20
  if false == isTransList then
    self._ui.stc_deliveryListBG:SetSize(self._ui.stc_deliveryListBG:GetSizeX(), self._ui.list_delivery:GetSizeY())
    panelSizeY = self._originPanelSizeY - (self:getSizeYReceiveAllButton() + padding)
  else
    self._ui.stc_deliveryListBG:SetSize(self._ui.stc_deliveryListBG:GetSizeX(), self._ui.list_delivery:GetSizeY() + self:getSizeYReceiveAllButton() + padding)
    panelSizeY = self._originPanelSizeY
  end
  Panel_Window_Delivery_All:SetSize(Panel_Window_Delivery_All:GetSizeX(), panelSizeY)
  self._ui.stc_deliveryListBG:ComputePos()
  self._ui.list_delivery:ComputePos()
  self._ui._console.stc_bottomBG:ComputePos()
  self:updateConsoleKeyEnable()
end
function PaGlobal_Delivery_All:updateConsoleKeyEnable()
  if false == self._isConsole then
    return
  end
  local keyGuide
  if true == self._isDeliveyCheck then
    if true == self._isTransList then
      self._ui._console.txt_recive:SetShow(true)
      self._ui._console.txt_reciveAll:SetShow(true)
      self._ui._console.txt_cancel:SetShow(true)
      self._ui._console.txt_send:SetShow(false)
      self._ui._console.txt_select:SetShow(false)
      keyGuide = {
        self._ui._console.txt_recive,
        self._ui._console.txt_reciveAll,
        self._ui._console.txt_cancel,
        self._ui._console.txt_close
      }
    else
      self._ui._console.txt_recive:SetShow(false)
      self._ui._console.txt_reciveAll:SetShow(false)
      self._ui._console.txt_cancel:SetShow(false)
      self._ui._console.txt_send:SetShow(false)
      self._ui._console.txt_select:SetShow(false)
    end
  else
    self._ui._console.txt_recive:SetShow(false)
    self._ui._console.txt_reciveAll:SetShow(false)
    self._ui._console.txt_cancel:SetShow(false)
    self._ui._console.txt_send:SetShow(true)
    self._ui._console.txt_select:SetShow(true)
    keyGuide = {
      self._ui._console.txt_send,
      self._ui._console.txt_select,
      self._ui._console.txt_close
    }
  end
  self._ui._console.txt_close:SetShow(true)
  if nil ~= keyGuide then
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._console.stc_bottomBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_Delivery_All:setShowReceiveAllButton(isShow)
  if true == self._isConsole then
    return
  end
  self._ui._pc.btn_receiveAll:SetShow(isShow)
end
function PaGlobal_Delivery_All:getSizeYReceiveAllButton()
  if true == self._isConsole then
    return 0
  end
  return self._ui._pc.btn_receiveAll:GetSizeY()
end
function PaGlobal_Delivery_All:updateRegisterPadEvent_Y()
  if true == self._isDeliveyCheck then
    if true == self._isTransList then
      HandleEventLUp_DeliveryAll_ReceiveAll()
    end
  else
    HandleEventLUp_DeliveryAll_SendCheckNode()
  end
end
