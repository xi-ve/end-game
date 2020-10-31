function PaGlobal_Purification_All:initialize()
  if true == self._initailize or nil == Panel_Purification_All then
    return
  end
  self._ui._stc_Title = UI.getChildControl(Panel_Purification_All, "StaticText_Title")
  self._ui._btn_Close_Pc = UI.getChildControl(self._ui._stc_Title, "Button_Close_PCUI")
  self._ui._stc_DecoBg = UI.getChildControl(Panel_Purification_All, "Static_DecoBg")
  self._ui._stc_MainBg = UI.getChildControl(self._ui._stc_DecoBg, "Static_Bg")
  self._ui._stc_ItemSlotBg = UI.getChildControl(self._ui._stc_MainBg, "Static_ItemSlotBg")
  self._ui._stc_ResultSlotBg = UI.getChildControl(self._ui._stc_MainBg, "Static_ResultItemSlotBg")
  self._ui._stc_DescBg = UI.getChildControl(self._ui._stc_MainBg, "Static_Desc")
  self._ui._txt_EnchantBefore = UI.getChildControl(self._ui._stc_DescBg, "StaticText_Before")
  self._ui._txt_EnchantAfter = UI.getChildControl(self._ui._stc_DescBg, "StaticText_After")
  self._ui._stc_ArrowBg = UI.getChildControl(self._ui._stc_DescBg, "Static_ArrowBg")
  self._ui._txt_SubDesc = UI.getChildControl(self._ui._stc_DescBg, "StaticText_SubDesc")
  self._ui._stc_ButtonBG = UI.getChildControl(Panel_Purification_All, "Static_ButtonBG")
  self._ui._btn_Purify_Pc = UI.getChildControl(self._ui._stc_ButtonBG, "Button_Purification_PCUI")
  self._ui._stc_BottomBg = UI.getChildControl(self._ui._stc_ButtonBG, "Static_BottomBg")
  self._ui._stc_BottomDesc = UI.getChildControl(self._ui._stc_BottomBg, "StaticText_Desc")
  self._ui._btn_CheckAniSkip = UI.getChildControl(self._ui._stc_ButtonBG, "CheckButton_Skip")
  self._ui._btn_Radio_Inven = UI.getChildControl(self._ui._stc_ButtonBG, "RadioButton_InvenMoney")
  self._ui._txt_InvenMoney = UI.getChildControl(self._ui._btn_Radio_Inven, "StaticText_InvenMoney")
  self._ui._btn_Radio_Ware = UI.getChildControl(self._ui._stc_ButtonBG, "RadioButton_WarehouseMoney")
  self._ui._txt_WareMoney = UI.getChildControl(self._ui._btn_Radio_Ware, "StaticText_WarehouseMoney")
  self._ui._stc_Bottom_KeyGuides = UI.getChildControl(Panel_Purification_All, "Static_BottomButton_ConsoleUI")
  self._ui._stc_KeyGuide_Cancel = UI.getChildControl(self._ui._stc_Bottom_KeyGuides, "StaticText_KeyGuideCancel_ConsoleUI")
  self._ui._stc_KeyGuide_Select = UI.getChildControl(self._ui._stc_Bottom_KeyGuides, "StaticText_KeyGuideSelect_ConsoleUI")
  self._ui._stc_KeyGuide_Detail = UI.getChildControl(self._ui._stc_Bottom_KeyGuides, "StaticText_KeyGuide_Detail_ConsoleUI")
  self._ui._stc_KeyGuide_Purify = UI.getChildControl(self._ui._stc_Bottom_KeyGuides, "StaticText_KeyGuide_Purify_ConsoleUI")
  self._ui._list2_PossibleItem = UI.getChildControl(Panel_Purification_All, "List2_PossibleEquip")
  self._ui._list2_Content = UI.getChildControl(self._ui._list2_PossibleItem, "List2_1_Content")
  self._ui._list2_RdoBtn = UI.getChildControl(self._ui._list2_Content, "RadioButton_EnchantEquipItem")
  self._ui._list2_ItemSlot = UI.getChildControl(self._ui._list2_RdoBtn, "Static_ItemSlotBG")
  self._ui._list2_ItemIcon = UI.getChildControl(self._ui._list2_ItemSlot, "Static_ItemIcon")
  self._ui._txt_NoItem = UI.getChildControl(Panel_Purification_All, "StaticText_NoItem")
  self._ui._vscroll = self._ui._list2_PossibleItem:GetVScroll()
  self._itemSlotBg_Icon = {}
  SlotItem.new(self._itemSlotBg_Icon, "feeItem", nil, self._ui._stc_ItemSlotBg, self._slotConfig)
  self._itemSlotBg_Icon:createChild()
  self._itemSlotBg_Icon:clearItem()
  self._itemSlotBg_Icon.icon:SetHorizonCenter()
  self._itemSlotBg_Icon.icon:SetVerticalMiddle()
  self._resultSlotBg_Icon = {}
  SlotItem.new(self._resultSlotBg_Icon, "resultItem", nil, self._ui._stc_ResultSlotBg, self._slotConfig)
  self._resultSlotBg_Icon:createChild()
  self._resultSlotBg_Icon:clearItem()
  self._resultSlotBg_Icon.icon:SetHorizonCenter()
  self._resultSlotBg_Icon.icon:SetVerticalMiddle()
  local possibleIcon = {}
  SlotItem.new(possibleIcon, "possibleItem", nil, self._ui._list2_ItemIcon, self._slotConfig)
  possibleIcon:createChild()
  possibleIcon:clearItem()
  possibleIcon.icon:SetHorizonCenter()
  possibleIcon.icon:SetVerticalMiddle()
  self._keyGudieList = {
    self._ui._stc_KeyGuide_Detail,
    self._ui._stc_KeyGuide_Purify,
    self._ui._stc_KeyGuide_Select,
    self._ui._stc_KeyGuide_Cancel
  }
  self._ui._txt_SubDesc:SetTextMode(__eTextMode_AutoWrap)
  if 1 < self._ui._txt_SubDesc:GetLineCount() then
    self._ui._txt_EnchantBefore:SetPosY(self._ui._txt_SubDesc:GetTextSizeY() + 20)
    self._ui._txt_EnchantAfter:SetPosY(self._ui._txt_SubDesc:GetTextSizeY() + 20)
    self._ui._stc_ArrowBg:SetPosY(self._ui._txt_SubDesc:GetTextSizeY() + 23)
  end
  self._ui._txt_EnchantBefore:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PURIFICATION_ALL_ENCHANT_GRADE", "param", "15"))
  self._ui._txt_EnchantAfter:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PURIFICATION_ALL_ENCHANT_GRADE", "param", "14"))
  self._ui._stc_BottomDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_BottomDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PURIFICATION_ALL_DESC"))
  local textY = self._ui._stc_BottomDesc:GetTextSizeY()
  local bottomBgSizeY = self._ui._stc_BottomBg:GetSizeY()
  if textY > bottomBgSizeY then
    self._ui._stc_BottomBg:SetSize(self._ui._stc_BottomBg:GetSizeX(), textY + 20)
    self._ui._stc_BottomDesc:SetSize(self._ui._stc_BottomDesc:GetSizeX(), bottomBgSizeY - 20)
    local gap = bottomBgSizeY - self._ui._stc_BottomBg:GetSizeY()
    Panel_Purification_All:SetSize(Panel_Purification_All:GetSizeX(), Panel_Purification_All:GetSizeY() - gap)
    self._ui._list2_PossibleItem:SetSize(self._ui._list2_PossibleItem:GetSizeX(), self._ui._list2_PossibleItem:GetSizeY() - gap)
    self._ui._btn_Purify_Pc:SetPosY(self._ui._btn_Purify_Pc:GetPosY() - gap)
    self._ui._btn_Radio_Inven:SetPosY(self._ui._btn_Radio_Inven:GetPosY() - gap)
    self._ui._btn_Radio_Ware:SetPosY(self._ui._btn_Radio_Ware:GetPosY() - gap)
    Panel_Purification_All:ComputePos()
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._btn_Close_Pc:SetShow(not self._isConsole)
  self._ui._btn_Purify_Pc:SetShow(not self._isConsole)
  self._ui._stc_Bottom_KeyGuides:SetShow(self._isConsole)
  if true == self._isConsole then
    local btnSize = self._ui._btn_Purify_Pc:GetSizeY()
    Panel_Purification_All:SetSize(Panel_Purification_All:GetSizeX(), Panel_Purification_All:GetSizeY() - (btnSize + 10))
    self._ui._list2_PossibleItem:SetSize(self._ui._list2_PossibleItem:GetSizeX(), self._ui._list2_PossibleItem:GetSizeY() - (btnSize + 10))
    self._ui._stc_Bottom_KeyGuides:SetPosY(Panel_Purification_All:GetSizeY() - 10)
    self._ui._stc_Bottom_KeyGuides:SetSpanSize(self._ui._stc_Bottom_KeyGuides:GetSpanSize().x, -50)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGudieList, self._ui._stc_Bottom_KeyGuides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  self._ui._btn_Radio_Inven:SetCheck(true)
  PaGlobal_Purification_All:vaildate()
  PaGlobal_Purification_All:registerEventHandler()
end
function PaGlobal_Purification_All:registerEventHandler()
  if nil ~= Panel_Purification_All or true == self._initailize then
    registerEvent("onScreenResize", "FromClient_Purification_All_Resize()")
    registerEvent("EventWarehouseUpdate", "FromClient_Purification_All_MoneyUpdate()")
    registerEvent("FromClient_notifyWeakenEnchantSuccess", "FromClient_Purification_All_EnchantSuccess()")
    self._ui._list2_PossibleItem:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_Purification_All_List2Update")
    self._ui._list2_PossibleItem:createChildContent(__ePAUIList2ElementManagerType_List)
    if true == self._isConsole then
      Panel_Purification_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, " HandleEventLUp_Purification_All_RequestPurification() ")
      self._ui._btn_Radio_Inven:registerPadEvent(__eConsoleUIPadEvent_Up_A, " HandleEventLUp_Purification_All_CheckMoneyButton( true )")
      self._ui._btn_Radio_Ware:registerPadEvent(__eConsoleUIPadEvent_Up_A, " HandleEventLUp_Purification_All_CheckMoneyButton( false )")
      self._ui._btn_CheckAniSkip:addInputEvent("Mouse_Out", "HandleEventOnOut_Purification_All_AniButtonTooltipPC( false )")
      self._ui._stc_ItemSlotBg:registerPadEvent(__eConsoleUIPadEvent_Up_A, " HandleEventRUp_Purification_All_DataClear()")
      self._ui._stc_ItemSlotBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_Purification_All_ShowToolTipConsole( true, 0 )")
      self._ui._stc_ItemSlotBg:addInputEvent("Mouse_Out", "HandleEventLUp_Purification_All_ShowToolTipConsole( false )")
      self._ui._stc_ResultSlotBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_Purification_All_ShowToolTipConsole( true, 1 )")
      self._ui._stc_ResultSlotBg:addInputEvent("Mouse_Out", "HandleEventLUp_Purification_All_ShowToolTipConsole( false )")
    else
      self._ui._btn_Radio_Inven:addInputEvent("Mouse_LUp", " HandleEventLUp_Purification_All_CheckMoneyButton( true )")
      self._ui._btn_Radio_Ware:addInputEvent("Mouse_LUp", " HandleEventLUp_Purification_All_CheckMoneyButton( false )")
      self._ui._btn_Close_Pc:addInputEvent("Mouse_LUp", "HandleEventLUp_Purification_All_Close()")
      self._ui._btn_Purify_Pc:addInputEvent("Mouse_LUp", "HandleEventLUp_Purification_All_RequestPurification()")
      self._ui._btn_CheckAniSkip:addInputEvent("Mouse_On", "HandleEventOnOut_Purification_All_AniButtonTooltipPC( true )")
      self._ui._btn_CheckAniSkip:addInputEvent("Mouse_Out", "HandleEventOnOut_Purification_All_AniButtonTooltipPC( false )")
      self._itemSlotBg_Icon.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Purification_All_ShowToolTipPC( true, 0 )")
      self._itemSlotBg_Icon.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Purification_All_ShowToolTipPC( false )")
      self._itemSlotBg_Icon.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Purification_All_DataClear()")
      self._resultSlotBg_Icon.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Purification_All_ShowToolTipPC( true, 1 )")
      self._resultSlotBg_Icon.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Purification_All_ShowToolTipPC( false )")
    end
  end
end
function PaGlobal_Purification_All:prepareOpen()
  if nil == Panel_Purification_All or true == Panel_Purification_All:GetShow() then
    return
  end
  warehouse_requestInfoFromNpc()
  self._ui._list2_Content:SetShow(false)
  self._ui._txt_NoItem:SetShow(false)
  PaGlobal_Purification_All.slotList = {}
  self._ui._btn_Radio_Ware:SetCheck(false)
  self._ui._btn_Radio_Inven:SetCheck(true)
  self._ui._btn_CheckAniSkip:SetCheck(false)
  PaGlobalFunc_DialogMain_All_ShowToggle(false)
  PaGlobal_Purification_All:resize()
  PaGlobal_Purification_All:open()
  PaGlobal_Purification_All:checkMoneyButton(self._ui._btn_Radio_Inven:IsCheck())
  PaGlobal_Purification_All:dataClear()
  PaGlobal_Purification_All:moneyUpdate()
  PaGlobal_Purification_All:update()
  if true == self._isConsole then
    ToClient_padSnapSetTargetPanel(Panel_Window_Inventory)
    Panel_Purification_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Purification_All_RequestPurification()")
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGudieList, self._ui._stc_Bottom_KeyGuides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_Purification_All:update(scrollUpdate)
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  local invenSize = selfPlayer:getInventorySlotCount(false)
  local listCount = -1
  self._toIndex = self._ui._list2_PossibleItem:getCurrenttoIndex()
  self._scrollValue = self._ui._vscroll:GetControlPos()
  self._ui._list2_PossibleItem:getElementManager():clearKey()
  for idx = 0, invenSize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, idx)
    if nil ~= itemWrapper then
      local itemKey = itemWrapper:getStaticStatus():get()._key:get()
      if false == PaGlobal_Purification_All:filterPossibleItem(idx, itemWrapper) then
        self._ui._list2_PossibleItem:getElementManager():pushKey(toInt64(0, idx))
        listCount = listCount + 1
      end
    end
  end
  if listCount <= -1 then
    self._ui._txt_NoItem:SetShow(true)
    if true == self._isConsole then
      self._ui._btn_CheckAniSkip:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "ToClient_padSnapIgnoreGroupMove()")
      self._ui._btn_Radio_Inven:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "ToClient_padSnapIgnoreGroupMove()")
      self._ui._btn_Radio_Ware:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "ToClient_padSnapIgnoreGroupMove()")
    end
  else
    if true == self._isConsole then
      self._ui._btn_CheckAniSkip:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "")
      self._ui._btn_Radio_Inven:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "")
      self._ui._btn_Radio_Ware:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "")
    end
    ToClient_padSnapSetTargetGroup(self._ui._list2_PossibleItem)
    if scrollUpdate then
      self._ui._list2_PossibleItem:setCurrenttoIndex(self._toIndex)
      if false == self._ui._list2_PossibleItem:IsIgnoreVerticalScroll() then
        self._ui._vscroll:SetControlPos(self._scrollValue)
      end
    end
  end
end
function PaGlobal_Purification_All:filterPossibleItem(slotNo, notUse_itemWrappers)
  if nil == Panel_Purification_All then
    return
  end
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
  if nil == itemWrapper then
    return true
  end
  if ToClient_Inventory_CheckItemLock(slotNo, CppEnums.ItemWhereType.eInventory) then
    return true
  end
  if itemWrapper:isWeakenEnchantItem() then
    return false
  else
    return true
  end
end
function PaGlobal_Purification_All:open()
  if nil == Panel_Purification_All or true == Panel_Purification_All:GetShow() then
    return
  end
  Panel_Purification_All:SetShow(true)
end
function PaGlobal_Purification_All:dataClear()
  if nil == Panel_Purification_All then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  TooltipSimple_Hide()
  self._fromWhereType = -1
  self._fromSlotIdx = -1
  self._fromSlotOn = false
  self._resultWhereType = -1
  self._resultSlotIdx = -1
  self._resultSlotOn = false
  self._isAniStart = false
  self._delta_ani_time = 0
  if false == self._isConsole then
    self._ui._btn_Purify_Pc:SetIgnore(false)
    self._ui._btn_Purify_Pc:SetMonoTone(false)
  end
  self._ui._btn_Radio_Inven:SetIgnore(false)
  self._ui._btn_Radio_Ware:SetIgnore(false)
  self._ui._btn_CheckAniSkip:SetIgnore(false)
  self._itemSlotBg_Icon:clearItem()
  self._resultSlotBg_Icon:clearItem()
  self._ui._stc_ItemSlotBg:EraseAllEffect()
  self._ui._stc_ResultSlotBg:EraseAllEffect()
end
function PaGlobal_Purification_All:prepareClose()
  if nil == Panel_Purification_All or false == Panel_Purification_All:GetShow() then
    return
  end
  if true == self._isAniStart then
    self._isAniStart = false
    Panel_Purification_All:ClearUpdateLuaFunc()
  end
  self._ui._list2_PossibleItem:getElementManager():clearKey()
  PaGlobal_Purification_All:dataClear()
  Panel_Purification_All:ClearUpdateLuaFunc()
  if true == _ContentsGroup_NewUI_Inventory_All then
    PaGlobalFunc_Inventory_All_Close()
  else
    HandleClicked_InventoryWindow_Close()
  end
  PaGlobal_Purification_All:close()
  PaGlobalFunc_DialogMain_All_ShowToggle(true)
end
function PaGlobal_Purification_All:close()
  if nil == Panel_Purification_All or false == Panel_Purification_All:GetShow() then
    return
  end
  Panel_Purification_All:SetShow(false)
end
function PaGlobal_Purification_All:moneyUpdate()
  if nil == Panel_Purification_All or false == Panel_Purification_All:GetShow() then
    return
  end
  if nil ~= getSelfPlayer() then
    local invenMoney = getSelfPlayer():get():getInventory():getMoney_s64()
    local wareMoney = warehouse_moneyFromNpcShop_s64()
    self._ui._txt_WareMoney:SetText(makeDotMoney(wareMoney))
    self._ui._txt_InvenMoney:SetText(makeDotMoney(invenMoney))
  end
end
function PaGlobal_Purification_All:checkMoneyButton(value)
  if nil == Panel_Purification_All or false == Panel_Purification_All:GetShow() then
    return
  end
  if true == value then
    self._moneyWhereType = CppEnums.ItemWhereType.eInventory
  else
    self._moneyWhereType = CppEnums.ItemWhereType.eWarehouse
  end
end
function PaGlobal_Purification_All:requestPurification()
  if nil == Panel_Purification_All then
    return
  end
  if self._fromSlotIdx < 0 or 0 > self._fromWhereType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PURIFICATION_TARGET_EMPTY"))
    return
  end
  local function ConfirmPuri()
    local invenMoney = getSelfPlayer():get():getInventory():getMoney_s64()
    local wareMoney = warehouse_moneyFromNpcShop_s64()
    local fee = toInt64(0, self._purificationPrice)
    if invenMoney < fee and true == self._ui._btn_Radio_Inven:IsCheck() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "Lua_TradeMarket_Not_Enough_Money"))
      return
    elseif wareMoney < fee and true == self._ui._btn_Radio_Ware:IsCheck() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "Lua_TradeMarket_Not_Enough_Money"))
      return
    end
    Panel_Purification_All:RegisterUpdateFunc("PaGlobalFunc_Purification_All_RequestPurificationAni")
    self._delta_ani_time = 0
    self._isAniStart = true
    if true == PaGlobal_Purification_All._isConsole then
      self._ui._stc_ItemSlotBg:SetIgnore(true)
      self._ui._stc_KeyGuide_Purify:SetShow(false)
      self._ui._stc_KeyGuide_Detail:SetShow(false)
      Panel_Purification_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      self._ui._stc_KeyGuide_Select:SetShow(false)
      PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGudieList, self._ui._stc_Bottom_KeyGuides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
      PaGlobal_Purification_All._ui._list2_PossibleItem:requestUpdateVisible()
    end
    local skipCheck = false
    if true == self._ui._btn_CheckAniSkip:IsCheck() then
      skipCheck = true
    end
    if true == skipCheck then
      self._ui._stc_ResultSlotBg:AddEffect("fUI_Purification_02A", false, 0, 0)
    else
      self._ui._stc_ItemSlotBg:AddEffect("fUI_Purification_01A", false, 0, 0)
      self._ui._stc_ResultSlotBg:AddEffect("fUI_Purification_02A", false, 0, 0)
    end
    if false == self._isConsole then
      self._ui._btn_Purify_Pc:SetIgnore(true)
      self._ui._btn_Purify_Pc:SetMonoTone(true)
    end
    PaGlobal_Purification_All:audioPostEvent(5, 17, PaGlobal_Purification_All._isConsole)
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_PURIFICATION_ALERT"),
    functionYes = ConfirmPuri,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_Purification_All:audioPostEvent(idx, value, isConsole)
  if nil == Panel_Purification_All then
    return
  end
  if true == self._isConsole and true == isConsole then
    _AudioPostEvent_SystemUiForXBOX(idx, value)
  elseif false == self._isConsole and false == isConsole then
    audioPostEvent_SystemUi(idx, value)
  end
end
function PaGlobal_Purification_All:resize()
  if nil == Panel_Purification_All then
    return
  end
  local screenSizeX = getOriginScreenSizeX()
  local screenSizeY = getOriginScreenSizeY()
  local height = 20
  Panel_Purification_All:SetPosY(screenSizeY / 2 - Panel_Purification_All:GetSizeY() / 2 - height)
  Panel_Purification_All:SetPosX(screenSizeX / 2 - Panel_Purification_All:GetSizeX() / 2)
end
function PaGlobal_Purification_All:vaildate()
  if nil == Panel_Purification_All then
    return
  end
  self._ui._stc_Title:isValidate()
  self._ui._btn_Close_Pc:isValidate()
  self._ui._stc_MainBg:isValidate()
  self._ui._stc_ItemSlotBg:isValidate()
  self._ui._stc_ResultSlotBg:isValidate()
  self._ui._stc_DescBg:isValidate()
  self._ui._txt_EnchantBefore:isValidate()
  self._ui._txt_EnchantAfter:isValidate()
  self._ui._txt_SubDesc:isValidate()
  self._ui._btn_Purify_Pc:isValidate()
  self._ui._stc_KeyGuide_Detail:isValidate()
  self._ui._stc_BottomBg:isValidate()
  self._ui._stc_BottomDesc:isValidate()
  self._ui._btn_CheckAniSkip:isValidate()
  self._ui._btn_Radio_Inven:isValidate()
  self._ui._txt_InvenMoney:isValidate()
  self._ui._btn_Radio_Ware:isValidate()
  self._ui._txt_WareMoney:isValidate()
  self._ui._stc_Bottom_KeyGuides:isValidate()
  self._ui._stc_KeyGuide_Cancel:isValidate()
  self._ui._stc_KeyGuide_Select:isValidate()
  self._ui._stc_DecoBg:isValidate()
  self._ui._list2_PossibleItem:isValidate()
  self._ui._list2_Content:isValidate()
  self._ui._list2_RdoBtn:isValidate()
  self._ui._list2_ItemSlot:isValidate()
  self._ui._list2_ItemIcon:isValidate()
  self._ui._txt_NoItem:isValidate()
  self._initailize = true
end
