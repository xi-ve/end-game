function PaGlobal_TradeMyBasket_All:initialize()
  if true == PaGlobal_TradeMyBasket_All._initialize or nil == Panel_Dialog_Trade_MyBasket_All then
    return
  end
  self._ui._txt_Title = UI.getChildControl(Panel_Dialog_Trade_MyBasket_All, "StaticText_TradeBasketTitle")
  self._ui._list2_MyBasket = UI.getChildControl(Panel_Dialog_Trade_MyBasket_All, "List2_MyBasket")
  self._ui._list2_MyBasketContent = UI.getChildControl(self._ui._list2_MyBasket, "List2_1_Content")
  self._ui._stc_SlotBg_Template = UI.getChildControl(self._ui._list2_MyBasketContent, "Static_SlotBg")
  self._ui._stc_ItemIconBg_Template = UI.getChildControl(self._ui._list2_MyBasketContent, "Static_ItemBg")
  self._ui._txt_ItemName_Template = UI.getChildControl(self._ui._list2_MyBasketContent, "StaticText_ItemName")
  self._ui._txt_ItemPrice_Template = UI.getChildControl(self._ui._list2_MyBasketContent, "StaticText_Price")
  self._ui._btn_ItemCount_Template = UI.getChildControl(self._ui._list2_MyBasketContent, "StaticText_Count")
  self._ui._btn_ClearItem_Template = UI.getChildControl(self._ui._list2_MyBasketContent, "Button_Empty")
  self._ui._list2_MyItem = UI.getChildControl(Panel_Dialog_Trade_MyBasket_All, "List2_MyItem")
  self._ui._list2_MyItemContent = UI.getChildControl(self._ui._list2_MyItem, "List2_1_Content")
  self._ui._stc_MyItemSlotBg_Template = UI.getChildControl(self._ui._list2_MyItemContent, "Static_SlotBg")
  self._ui._stc_MyItemItemIconBg_Template = UI.getChildControl(self._ui._list2_MyItemContent, "Static_ItemBg")
  self._ui._txt_MyItemItemName_Template = UI.getChildControl(self._ui._list2_MyItemContent, "StaticText_ItemName")
  self._ui._txt_MyItemItemPrice_Template = UI.getChildControl(self._ui._list2_MyItemContent, "StaticText_Price")
  self._ui._btn_MyItemItemSell_Template = UI.getChildControl(self._ui._list2_MyItemContent, "Button_Sell")
  self._ui._txt_MyItemPeriod_Template = UI.getChildControl(self._ui._list2_MyItemContent, "StaticText_Period")
  self._ui._txt_MyItemProfit_Template = UI.getChildControl(self._ui._list2_MyItemContent, "StaticText_Profit")
  local originIcon = UI.getChildControl(self._ui._list2_MyItemContent, "Static_Origin")
  self._ui._txt_MyItemOrigin_Template = UI.getChildControl(originIcon, "StaticText_Origin")
  local distanceBonusIcon = UI.getChildControl(self._ui._list2_MyItemContent, "Static_DistanceBonus")
  self._ui._txt_MyItemDistanceBonus_Template = UI.getChildControl(distanceBonusIcon, "StaticText_DistanceBonus")
  self._ui._txt_MyItemTradeGame_Template = UI.getChildControl(self._ui._list2_MyItemContent, "StaticText_TradeGame")
  self._ui._stc_InvenBg = UI.getChildControl(Panel_Dialog_Trade_MyBasket_All, "Static_InvenBg")
  self._ui._rdo_Inven = UI.getChildControl(self._ui._stc_InvenBg, "RadioButton_Inven")
  self._ui._rdo_LandVehicle = UI.getChildControl(self._ui._stc_InvenBg, "RadioButton_LandVehicle")
  self._ui._rdo_SeaVehicle = UI.getChildControl(self._ui._stc_InvenBg, "RadioButton_SeaVehicle")
  self._ui._txt_InvenWeight = UI.getChildControl(self._ui._stc_InvenBg, "StaticText_InvenWeightValue")
  self._ui._txt_InvenSlotCount = UI.getChildControl(self._ui._stc_InvenBg, "StaticText_InvenSlotValue")
  self._ui._txt_LandWeight = UI.getChildControl(self._ui._stc_InvenBg, "StaticText_LandVehicleWeightValue")
  self._ui._txt_LandSlotCount = UI.getChildControl(self._ui._stc_InvenBg, "StaticText_LandVehicleSlotValue")
  self._ui._txt_SeaWeight = UI.getChildControl(self._ui._stc_InvenBg, "StaticText_SeaVehicleWeightValue")
  self._ui._txt_SeaSlotCount = UI.getChildControl(self._ui._stc_InvenBg, "StaticText_SeaVehicleSlotValue")
  self._ui._stc_MoneyBg = UI.getChildControl(Panel_Dialog_Trade_MyBasket_All, "Static_MoneyBg")
  self._ui._stc_NeedMoney = UI.getChildControl(self._ui._stc_MoneyBg, "StaticText_NeedMoneyTitle")
  self._ui._stc_Money = UI.getChildControl(self._ui._stc_MoneyBg, "StaticText_MoneyTitle")
  self._ui._txt_NeedMoney = UI.getChildControl(self._ui._stc_MoneyBg, "StaticText_NeedMoneyValue")
  self._ui._txt_Money = UI.getChildControl(self._ui._stc_MoneyBg, "StaticText_MoneyValue")
  self._ui._btn_BuyAll_PC = UI.getChildControl(Panel_Dialog_Trade_MyBasket_All, "Button_BuyAll")
  self._ui._btn_ClearALL_PC = UI.getChildControl(Panel_Dialog_Trade_MyBasket_All, "Button_EmptyAll")
  self._ui._btn_TradeGame_PC = UI.getChildControl(Panel_Dialog_Trade_MyBasket_All, "Button_TradeGame")
  self._ui._btn_SellALL_PC = UI.getChildControl(Panel_Dialog_Trade_MyBasket_All, "Button_SellAll")
  self._ui._txt_NoItem = UI.getChildControl(Panel_Dialog_Trade_MyBasket_All, "StaticText_NoItem")
  self._ui._stc_Keyguides = UI.getChildControl(Panel_Dialog_Trade_MyBasket_All, "Static_BottomBG_ConsoleUI")
  self._ui._stc_KeyGuide_A = UI.getChildControl(self._ui._stc_Keyguides, "StaticText_A_ConsoleUI")
  self._ui._stc_KeyGuide_B = UI.getChildControl(self._ui._stc_Keyguides, "StaticText_B_ConsoleUI")
  self._ui._stc_KeyGuide_X = UI.getChildControl(self._ui._stc_Keyguides, "StaticText_X_ConsoleUI")
  self._ui._stc_KeyGuide_Y = UI.getChildControl(self._ui._stc_Keyguides, "StaticText_Y_ConsoleUI")
  self._ui._txt_ItemName_Template:SetTextMode(__eTextMode_LimitText)
  self._ui._txt_MyItemItemName_Template:SetTextMode(__eTextMode_LimitText)
  local buyIcon = {}
  SlotItem.new(buyIcon, "MyBasketIcon", 0, self._ui._stc_ItemIconBg_Template, self.slotConfig)
  buyIcon:createChild()
  buyIcon:clearItem()
  buyIcon.icon:SetHorizonCenter()
  buyIcon.icon:SetVerticalMiddle()
  local sellIcon = {}
  SlotItem.new(sellIcon, "MySellItemIcon", 0, self._ui._stc_MyItemItemIconBg_Template, self.slotConfig)
  sellIcon:createChild()
  sellIcon:clearItem()
  sellIcon.icon:SetHorizonCenter()
  sellIcon.icon:SetVerticalMiddle()
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_TradeMyBasket_All:validate()
  PaGlobal_TradeMyBasket_All:registerEventHandler(self._isConsole)
  PaGlobal_TradeMyBasket_All:switchUI()
  PaGlobal_TradeMyBasket_All:onScreenResize()
end
function PaGlobal_TradeMyBasket_All:switchUI()
  self._ui._btn_ClearItem_Template:SetShow(not self._isConsole)
  self._ui._stc_Keyguides:SetShow(self._isConsole)
  self._ui._btn_ItemCount_Template:SetShow(not self._isConsole)
  self._ui._btn_ClearItem_Template:SetShow(not self._isConsole)
  self._ui._btn_MyItemItemSell_Template:SetShow(not self._isConsole)
  self._ui._btn_BuyAll_PC:SetShow(not self._isConsole)
  self._ui._btn_ClearALL_PC:SetShow(not self._isConsole)
  self._ui._btn_TradeGame_PC:SetShow(not self._isConsole)
  self._ui._btn_SellALL_PC:SetShow(not self._isConsole)
  if true == self._isConsole then
    self._ui._rdo_Inven:SetText("")
    self._ui._rdo_LandVehicle:SetText("")
    self._ui._rdo_SeaVehicle:SetText("")
    self._ui._txt_InvenWeight:SetSpanSize(self._ui._txt_InvenWeight:GetSpanSize().x - 20, self._ui._txt_InvenWeight:GetSpanSize().y)
    self._ui._txt_LandWeight:SetSpanSize(self._ui._txt_LandWeight:GetSpanSize().x - 20, self._ui._txt_LandWeight:GetSpanSize().y)
    self._ui._txt_SeaWeight:SetSpanSize(self._ui._txt_SeaWeight:GetSpanSize().x - 20, self._ui._txt_SeaWeight:GetSpanSize().y)
    local consoleTitleBar = UI.getChildControl(Panel_Dialog_Trade_MyBasket_All, "Static_TitleBar_ConsoleUI")
    consoleTitleBar:SetShow(true)
    self._ui._keyGuideTable[0] = self._ui._stc_KeyGuide_Y
    self._ui._keyGuideTable[1] = self._ui._stc_KeyGuide_X
    self._ui._keyGuideTable[2] = self._ui._stc_KeyGuide_A
    self._ui._keyGuideTable[3] = self._ui._stc_KeyGuide_B
    self._OriginKeyGuide_PosX = self._ui._stc_Keyguides:GetSizeX()
    PaGlobal_TradeMyBasket_All:setKeyGuides(false)
  end
end
function PaGlobal_TradeMyBasket_All:validate()
  if nil == Panel_Dialog_Trade_MyBasket_All then
    return
  end
  self._ui._list2_MyBasket:isValidate()
  self._ui._list2_MyBasketContent:isValidate()
  self._ui._stc_SlotBg_Template:isValidate()
  self._ui._stc_ItemIconBg_Template:isValidate()
  self._ui._txt_ItemName_Template:isValidate()
  self._ui._txt_ItemPrice_Template:isValidate()
  self._ui._btn_ItemCount_Template:isValidate()
  self._ui._btn_ClearItem_Template:isValidate()
  self._ui._list2_MyItem:isValidate()
  self._ui._list2_MyItemContent:isValidate()
  self._ui._stc_MyItemSlotBg_Template:isValidate()
  self._ui._stc_MyItemItemIconBg_Template:isValidate()
  self._ui._txt_MyItemItemName_Template:isValidate()
  self._ui._txt_MyItemItemPrice_Template:isValidate()
  self._ui._btn_MyItemItemSell_Template:isValidate()
  self._ui._txt_MyItemPeriod_Template:isValidate()
  self._ui._txt_MyItemProfit_Template:isValidate()
  self._ui._txt_MyItemOrigin_Template:isValidate()
  self._ui._txt_MyItemDistanceBonus_Template:isValidate()
  self._ui._txt_MyItemTradeGame_Template:isValidate()
  self._ui._stc_InvenBg:isValidate()
  self._ui._rdo_Inven:isValidate()
  self._ui._rdo_LandVehicle:isValidate()
  self._ui._rdo_SeaVehicle:isValidate()
  self._ui._txt_InvenWeight:isValidate()
  self._ui._txt_InvenSlotCount:isValidate()
  self._ui._txt_LandWeight:isValidate()
  self._ui._txt_LandSlotCount:isValidate()
  self._ui._txt_SeaWeight:isValidate()
  self._ui._txt_SeaSlotCount:isValidate()
  self._ui._stc_MoneyBg:isValidate()
  self._ui._stc_NeedMoney:isValidate()
  self._ui._stc_Money:isValidate()
  self._ui._txt_NeedMoney:isValidate()
  self._ui._txt_Money:isValidate()
  self._ui._btn_BuyAll_PC:isValidate()
  self._ui._btn_ClearALL_PC:isValidate()
  self._ui._btn_TradeGame_PC:isValidate()
  self._ui._btn_SellALL_PC:isValidate()
  self._ui._stc_KeyGuide_Y:isValidate()
  self._ui._stc_KeyGuide_A:isValidate()
  self._ui._stc_KeyGuide_B:isValidate()
  self._ui._stc_KeyGuide_X:isValidate()
  PaGlobal_TradeMyBasket_All._initialize = true
end
function PaGlobal_TradeMyBasket_All:onScreenResize()
  if nil == Panel_Dialog_Trade_MyBasket_All then
    return
  end
  local basketUI = PaGlobal_TradeMyBasket_All._ui
  local ScreenSizeY = getScreenSizeY()
  local gap = ScreenSizeY - (Panel_Dialog_Trade_MyBasket_All:GetSizeY() + Panel_Dialog_Trade_Function_All:GetSizeY())
  Panel_Dialog_Trade_MyBasket_All:SetSize(Panel_Dialog_Trade_MyBasket_All:GetSizeX(), Panel_Dialog_Trade_MyBasket_All:GetSizeY() + gap)
  self._ui._list2_MyBasket:SetSize(basketUI._list2_MyBasket:GetSizeX(), basketUI._list2_MyBasket:GetSizeY() + gap)
  self._ui._list2_MyItem:SetSize(basketUI._list2_MyItem:GetSizeX(), basketUI._list2_MyItem:GetSizeY() + gap)
  self._ui._stc_InvenBg:SetSpanSize(basketUI._stc_InvenBg:GetSpanSize().x, basketUI._stc_InvenBg:GetSpanSize().y + gap)
  self._ui._stc_MoneyBg:SetSpanSize(basketUI._stc_MoneyBg:GetSpanSize().x, basketUI._stc_MoneyBg:GetSpanSize().y + gap)
  self._ui._stc_Keyguides:ComputePos()
  self._ui._btn_BuyAll_PC:ComputePos()
  self._ui._btn_ClearALL_PC:ComputePos()
  self._ui._btn_TradeGame_PC:ComputePos()
  self._ui._btn_SellALL_PC:ComputePos()
end
function PaGlobal_TradeMyBasket_All:registerEventHandler(isConsole)
  if nil == Panel_Dialog_Trade_MyBasket_All or false == self._initialize then
    return
  end
  self._ui._list2_MyBasket:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_TradeMyBasket_All_List2UpdateMyBasket")
  self._ui._list2_MyBasket:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._list2_MyItem:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_TradeMyBasket_All_List2UpdateMyItem")
  self._ui._list2_MyItem:createChildContent(__ePAUIList2ElementManagerType_List)
  if false == isConsole then
    self._ui._btn_ClearALL_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_TradeMyBasket_All_ClearAllItem()")
    self._ui._btn_BuyAll_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_TradeMyBasket_All_BuyAll()")
    self._ui._btn_SellALL_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_TradeMyBasket_All_SellAll()")
    self._ui._btn_TradeGame_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_TradeMyBasket_All_BiddingGameStart()")
    self._ui._rdo_SeaVehicle:addInputEvent("Mouse_LUp", "HandleEventLup_TradeMyBasket_All_CarriageDataUpdate()")
    self._ui._rdo_LandVehicle:addInputEvent("Mouse_LUp", "HandleEventLup_TradeMyBasket_All_CarriageDataUpdate()")
    self._ui._rdo_Inven:addInputEvent("Mouse_LUp", "HandleEventLup_TradeMyBasket_All_CarriageDataUpdate()")
  else
    Panel_Dialog_Trade_MyBasket_All:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "PaGlobalFunc_TradeFunction_All_ChangeTabByPad( false )")
    Panel_Dialog_Trade_MyBasket_All:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "PaGlobalFunc_TradeFunction_All_ChangeTabByPad( true )")
    self._ui._rdo_Inven:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventPadPress_TradeBiddingGame_All_ClickRdoBtn(0)")
    self._ui._rdo_LandVehicle:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventPadPress_TradeBiddingGame_All_ClickRdoBtn(1)")
    self._ui._rdo_SeaVehicle:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventPadPress_TradeBiddingGame_All_ClickRdoBtn(2)")
    self._ui._rdo_Inven:addInputEvent("Mouse_On", "PaGlobalFunc_TradeMyBasket_All_SetInvenIconEvent( true )")
    self._ui._rdo_LandVehicle:addInputEvent("Mouse_On", "PaGlobalFunc_TradeMyBasket_All_SetInvenIconEvent( true )")
    self._ui._rdo_SeaVehicle:addInputEvent("Mouse_On", "PaGlobalFunc_TradeMyBasket_All_SetInvenIconEvent( true )")
    self._ui._rdo_Inven:addInputEvent("Mouse_Out", "PaGlobalFunc_TradeMyBasket_All_SetInvenIconEvent( false )")
    self._ui._rdo_LandVehicle:addInputEvent("Mouse_Out", "PaGlobalFunc_TradeMyBasket_All_SetInvenIconEvent( false )")
    self._ui._rdo_SeaVehicle:addInputEvent("Mouse_Out", "PaGlobalFunc_TradeMyBasket_All_SetInvenIconEvent( false )")
  end
  registerEvent("EventNpcShopUpdate", "PaGlobalFunc_TradeMyBasket_All_UpdateMySellItem()")
  registerEvent("EventNpcTradeShopGraphRefresh", "PaGlobalFunc_TradeMyBasket_All_UpdateMySellItem()")
  registerEvent("onScreenResize", "FromClient_TradeMyBasket_All_OnScreenResize()")
  registerEvent("FromClient_InventoryUpdate", "FromClient_TradeMyBasket_All_InventoryUpdate")
  registerEvent("FromClient_ServantInventoryUpdate", "FromClient_TradeMyBasket_All_CheckServant")
end
function PaGlobal_TradeMyBasket_All:dataClear()
  if nil == Panel_Dialog_Trade_MyBasket_All then
    return
  end
  self._buyRequest = false
  self._currentCartItemTable = {}
  self._currentSlotCount = 0
  self._ui._list2_MyBasket:getElementManager():clearKey()
  self._ui._list2_MyItem:getElementManager():clearKey()
  self._temporaryItemShopIdx = -1
  self._totalPrice = 0
  self._totalWeight = toInt64(0, 0)
  self._totalSlot = 0
  self._isNoLinkedNodeOne = false
  self._myItemTotalCount = -1
  self._myItemDataTable = {}
  self._realPriceList = {}
  self._currShopType = nil
  if true == self._ui._rdo_Inven:IsCheck() then
    self._ui._rdo_Inven:SetCheck(true)
    self._ui._rdo_LandVehicle:SetCheck(false)
    self._ui._rdo_SeaVehicle:SetCheck(false)
  elseif true == self._ui._rdo_LandVehicle:IsCheck() then
    self._ui._rdo_LandVehicle:SetCheck(true)
    self._ui._rdo_Inven:SetCheck(false)
    self._ui._rdo_SeaVehicle:SetCheck(false)
  else
    self._ui._rdo_SeaVehicle:SetCheck(true)
    self._ui._rdo_Inven:SetCheck(false)
    self._ui._rdo_LandVehicle:SetCheck(false)
  end
  self._vehicleStatus = self._ENUM_NO_VEHICLE
end
function PaGlobal_TradeMyBasket_All:prepareOpen()
  if nil == Panel_Dialog_Trade_MyBasket_All then
    return
  end
  local talker = dialog_getTalker()
  self._hasSellItem = false
  self._ui._btn_SellALL_PC:SetMonoTone(true, true)
  self._ui._btn_SellALL_PC:SetIgnore(true)
  self._ui._btn_TradeGame_PC:SetMonoTone(true, true)
  self._ui._btn_TradeGame_PC:SetIgnore(true)
  if nil ~= talker then
    self._ui._txt_NoItem:SetShow(false)
    local actorKeyRaw = talker:getActorKey()
    local actorProxyWrapper = getNpcActor(actorKeyRaw)
    local actorProxy = actorProxyWrapper:get()
    local characterStaticStatus = actorProxy:getCharacterStaticStatus()
    if false == characterStaticStatus:isSmuggleMerchant() then
      local mySellCount = npcShop_getSellCount()
      local vehicleSellCount = npcShop_getVehicleSellCount()
      local seaVehicleSellCount = 0
      if true == ToClient_IsContentsGroupOpen("576") and ToClient_IsContentsGroupOpen("504") then
        seaVehicleSellCount = npcShop_getShipSellCount()
      end
      local totalSellCount = mySellCount + vehicleSellCount + seaVehicleSellCount
      if 0 < totalSellCount then
        self._hasSellItem = true
        PaGlobalFunc_TradeFunction_All_ChangeTab(self._ENUM_TAB_SELL)
        self._ui._btn_SellALL_PC:SetMonoTone(false, false)
        self._ui._btn_SellALL_PC:SetIgnore(false)
        self._ui._btn_TradeGame_PC:SetMonoTone(false, false)
        self._ui._btn_TradeGame_PC:SetIgnore(false)
      end
    end
  end
  local characterStaticStatus = npcShop_getCurrentCharacterKeyForTrade():get()
  if nil == characterStaticStatus then
    return
  end
  local isFishSupplyMerchant = characterStaticStatus:isFishSupplyMerchant()
  local isSupplyMerchant = characterStaticStatus:isSupplyMerchant()
  if false == self._isConsole then
    if true == isFishSupplyMerchant or true == isSupplyMerchant then
      self._ui._btn_TradeGame_PC:SetShow(false)
    else
      self._ui._btn_TradeGame_PC:SetShow(true)
    end
  end
  self._list2ScrollData._scrollPos = 0
  self._list2ScrollData._currentIdx = 0
  PaGlobal_TradeMyBasket_All:dataClear()
  PaGlobal_TradeMyBasket_All:open()
  PaGlobal_TradeMyBasket_All:onScreenResize()
  if true == isSupplyMerchant then
    local characterStaticStatusWrapper = npcShop_getCurrentCharacterKeyForTrade()
    self._currShopType = characterStaticStatusWrapper:getTradeSupplyShopType()
  end
  if false == self._hasSellItem then
    PaGlobal_TradeMyBasket_All:update()
  end
  if false == ToClient_IsContentsGroupOpen("576") or false == ToClient_IsContentsGroupOpen("504") then
    self._ui._rdo_SeaVehicle:SetShow(false)
    self._ui._txt_SeaWeight:SetShow(false)
    self._ui._txt_SeaSlotCount:SetShow(false)
  else
    self._ui._rdo_SeaVehicle:SetShow(true)
    self._ui._txt_SeaWeight:SetShow(true)
    self._ui._txt_SeaSlotCount:SetShow(true)
  end
  self._ui._rdo_Inven:SetCheck(false)
  self._ui._rdo_SeaVehicle:SetCheck(false)
  self._ui._rdo_LandVehicle:SetCheck(false)
  if false == self._ui._rdo_LandVehicle:IsIgnore() then
    self._ui._rdo_LandVehicle:SetCheck(true)
  elseif false == self._ui._rdo_SeaVehicle:IsIgnore() then
    self._ui._rdo_SeaVehicle:SetCheck(true)
  else
    self._ui._rdo_Inven:SetCheck(true)
  end
end
function PaGlobal_TradeMyBasket_All:open()
  if nil == Panel_Dialog_Trade_MyBasket_All then
    return
  end
  Panel_Dialog_Trade_MyBasket_All:SetShow(true)
end
function PaGlobal_TradeMyBasket_All:update()
  if nil == Panel_Dialog_Trade_MyBasket_All then
    return
  end
  PaGlobal_TradeMyBasket_All:checkVehicle()
  PaGlobal_TradeMyBasket_All:myMoneyUpdate()
  PaGlobal_TradeMyBasket_All:inventoryUpdate()
  PaGlobal_TradeMyBasket_All:checkHasItem()
  PaGlobal_TradeMyBasket_All:updatePadXEvent()
end
function PaGlobal_TradeMyBasket_All:setKeyGuides(isLoyalFlag)
  if false == self._isConsole then
    return
  end
  if PaGlobalFunc_TradeFunction_All_GetCurrentTab() == self._ENUM_TAB_SELL then
    self._ui._stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TRADEMARKET_BTN_SELL"))
    self._ui._stc_KeyGuide_Y:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TRADEMARKET_BTN_TRADEGAMESTART"))
    self._ui._stc_KeyGuide_X:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TRADEMARKET_ITEMLIST_BTN_ALLTRADEITEMSELL"))
    local bigHand = 1000000 ~= getSelfPlayer():get():getlTradeItemCountRate()
    local isSuccess = PaGlobalFunc_TradeBiddingGame_All_IsSuccess()
    if true == isSuccess or true == bigHand or true == isLoyalFlag then
      self._ui._stc_KeyGuide_Y:SetShow(false)
    else
      self._ui._stc_KeyGuide_Y:SetShow(true)
    end
  else
    self._ui._stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_MARKETPLACE_KEYGUIDE_VALUECHANGE"))
    self._ui._stc_KeyGuide_Y:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TRADEMARKET_BASKET_EMPTYALL"))
    self._ui._stc_KeyGuide_X:SetText(PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_BTN_BUY"))
    self._ui._stc_KeyGuide_Y:SetShow(true)
  end
  local textSizeX = 0
  for idx = 0, #self._ui._keyGuideTable do
    if textSizeX <= self._ui._keyGuideTable[idx]:GetTextSizeX() + self._ui._keyGuideTable[idx]:GetTextSpan().x then
      textSizeX = self._ui._keyGuideTable[idx]:GetTextSizeX() + self._ui._keyGuideTable[idx]:GetTextSpan().x
    end
  end
  self._ui._stc_Keyguides:ComputePos()
  PaGlobalFunc_ConsoleKeyGuide_SetAlign({
    self._ui._stc_KeyGuide_Y,
    self._ui._stc_KeyGuide_X
  }, self._ui._stc_Keyguides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign({
    self._ui._stc_KeyGuide_A,
    self._ui._stc_KeyGuide_B
  }, self._ui._stc_Keyguides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_TradeMyBasket_All:checkHasItem()
  self._ui._txt_NoItem:SetShow(false)
  if PaGlobalFunc_TradeFunction_All_GetCurrentTab() == self._ENUM_TAB_SELL then
    local talker = dialog_getTalker()
    if nil ~= talker and 0 >= self._myItemTotalCount then
      local actorKeyRaw = talker:getActorKey()
      local actorProxyWrapper = getNpcActor(actorKeyRaw)
      local actorProxy = actorProxyWrapper:get()
      local characterStaticStatus = actorProxy:getCharacterStaticStatus()
      if characterStaticStatus:isTerritorySupplyMerchant() or characterStaticStatus:isTerritoryTradeMerchant() then
        self._ui._txt_NoItem:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_TRADEALL_NOROYALSUPPLY"))
      elseif characterStaticStatus:isSupplyMerchant() or characterStaticStatus:isFishSupplyMerchant() or characterStaticStatus:isGuildSupplyShopMerchant() then
        if characterStaticStatus:isFishSupplyMerchant() then
          self._ui._txt_NoItem:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_TRADEALL_NOFISH"))
        else
          self._ui._txt_NoItem:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_TRADEALL_NOOROYALPRODUCT"))
        end
      else
        self._ui._txt_NoItem:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_TRADEALL_NOTRADEITEM"))
      end
      self._ui._txt_NoItem:SetShow(true)
    end
  elseif 0 == self._totalSlot or toInt64(0, 0) == self._totalWeight then
    self._ui._txt_NoItem:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_TRADEALL_NOBASKET"))
    self._ui._txt_NoItem:SetShow(true)
  else
    self._ui._txt_NoItem:SetShow(false)
  end
end
function PaGlobal_TradeMyBasket_All:prepareClose()
  if nil == Panel_Dialog_Trade_MyBasket_All then
    return
  end
  PaGlobal_TradeMyBasket_All:dataClear()
  PaGlobal_TradeMyBasket_All:close()
end
function PaGlobal_TradeMyBasket_All:close()
  if nil == Panel_Dialog_Trade_MyBasket_All then
    return
  end
  Panel_Dialog_Trade_MyBasket_All:SetShow(false)
end
function PaGlobal_TradeMyBasket_All:updateMyBasketData(content, key)
  if nil == Panel_Dialog_Trade_MyBasket_All or nil == key then
    return
  end
  local slotIndex = Int64toInt32(key)
  local slotBg = UI.getChildControl(content, "Static_SlotBg")
  local iconBg = UI.getChildControl(content, "Static_ItemBg")
  local txt_itemName = UI.getChildControl(content, "StaticText_ItemName")
  local txt_itemPrice = UI.getChildControl(content, "StaticText_Price")
  local txt_itemCount = UI.getChildControl(content, "StaticText_Count")
  local btn_ClearPC = UI.getChildControl(content, "Button_Empty")
  btn_ClearPC:SetShow(not self._isConsole)
  btn_ClearPC:setRenderTexture(btn_ClearPC:getBaseTexture())
  if nil ~= self._currentCartItemTable[slotIndex] then
    local currentSlot = self._currentCartItemTable[slotIndex]
    local itemKey = currentSlot._itemKey
    local shopItemWrapper = npcShop_getTradeItem(itemKey)
    if nil == shopItemWrapper then
      return
    end
    local shopItemSS = shopItemWrapper:getStaticStatus()
    txt_itemName:SetText(tostring(currentSlot._itemName))
    if txt_itemName:GetSizeX() < txt_itemName:GetTextSizeX() then
      txt_itemName:addInputEvent("Mouse_On", "HandleEventOnOut_TradeMyBasket_All_LimitTextTooltip(" .. slotIndex .. ",true, true)")
      txt_itemName:addInputEvent("Mouse_Out", "HandleEventOnOut_TradeMyBasket_All_LimitTextTooltip(" .. slotIndex .. ",false)")
      txt_itemName:SetIgnore(false)
    end
    PAGlobalFunc_SetItemTextColorForNewUI(txt_itemName, shopItemSS)
    txt_itemPrice:SetText(makeDotMoney(currentSlot._itemPrice))
    txt_itemCount:SetText(tostring(currentSlot._count))
    local slotIcon = {}
    SlotItem.reInclude(slotIcon, "MyBasketIcon", currentSlot._itemKey, iconBg, self.slotConfig)
    slotIcon:setItemByStaticStatus(shopItemSS, itemCount)
    slotIcon.count:SetShow(true)
    slotIcon.count:SetText(tostring(currentSlot._count))
    if true == self._isConsole then
      slotBg:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_TradeMyBasket_All_ClearItem(" .. slotIndex .. ")")
      slotBg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_TradeMyBasket_All_ChangeItemCount(" .. slotIndex .. ")")
    else
      btn_ClearPC:addInputEvent("Mouse_LUp", "HandleEventLUp_TradeMyBasket_All_ClearItem(" .. slotIndex .. ")")
      txt_itemCount:addInputEvent("Mouse_LUp", "HandleEventLUp_TradeMyBasket_All_ChangeItemCount(" .. slotIndex .. ")")
      slotIcon.icon:addInputEvent("Mouse_On", "HandleEventOnOut_TradeMyBasket_All_ItemIconTooltip(" .. currentSlot._shopItemidx .. ",0)")
      slotIcon.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_TradeMyBasket_All_ItemIconTooltip()")
      slotBg:addInputEvent("Mouse_On", "HandleEventOnOut_TradeMyBasket_All_ItemIconTooltip(" .. currentSlot._shopItemidx .. ",0 )")
      slotBg:addInputEvent("Mouse_Out", "HandleEventOnOut_TradeMyBasket_All_ItemIconTooltip()")
      txt_itemPrice:addInputEvent("Mouse_On", "HandleEventOnOut_TradeMyBasket_All_SimpleTooltip(true ,0 ," .. slotIndex .. ")")
      txt_itemPrice:addInputEvent("Mouse_Out", "HandleEventOnOut_TradeMyBasket_All_SimpleTooltip()")
      Panel_Tooltip_Item_SetPosition(currentSlot._shopItemidx, slotIcon, "tradeMarket_Buy")
    end
  end
end
function PaGlobal_TradeMyBasket_All:getMyItem()
  if nil == Panel_Dialog_Trade_MyBasket_All then
    return
  end
  self._isNoLinkedNodeOne = false
  self._myItemTotalCount = 0
  self._ui._list2_MyItem:getElementManager():clearKey()
  self._myItemDataTable = {}
  self._realPriceList = {}
  local talker = dialog_getTalker()
  if nil ~= talker then
    local actorKeyRaw = talker:getActorKey()
    local actorProxyWrapper = getNpcActor(actorKeyRaw)
    local actorProxy = actorProxyWrapper:get()
    local characterStaticStatus = actorProxy:getCharacterStaticStatus()
    if true == characterStaticStatus:isSmuggleMerchant() then
      return
    end
  end
  if nil == getSelfPlayer() then
    return
  end
  PaGlobal_TradeMyBasket_All:checkVehicle()
  local characterStaticStatusWrapper = npcShop_getCurrentCharacterKeyForTrade()
  local characterStaticStatus = characterStaticStatusWrapper:get()
  local mySellCount = npcShop_getSellCount()
  local vehicleSellCount = 0
  local seaVehicleSellCount = 0
  local isAbleDistanceVehicle = getDistanceFromVehicle()
  local isAbleDistanceShip = getDistanceFromShip()
  if self._ENUM_ALL_VEHICLE == self._vehicleStatus then
    if true == isAbleDistanceVehicle and isAbleDistanceShip then
      vehicleSellCount = npcShop_getVehicleSellCount()
      seaVehicleSellCount = npcShop_getShipSellCount()
    end
  elseif self._ENUM_ALL_VEHICLE ~= self._vehicleStatus then
    if self._ENUM_LAND_VEHICLE == self._vehicleStatus then
      if true == isAbleDistanceVehicle then
        vehicleSellCount = npcShop_getVehicleSellCount()
      end
    elseif true == isAbleDistanceShip then
      seaVehicleSellCount = npcShop_getShipSellCount()
    end
  end
  local totalSellCount = mySellCount + vehicleSellCount + seaVehicleSellCount
  if totalSellCount <= 0 then
    self._myItemTotalCount = totalSellCount
    PaGlobal_TradeMyBasket_All:checkHasItem()
    self._ui._btn_SellALL_PC:SetMonoTone(true, true)
    self._ui._btn_SellALL_PC:SetIgnore(true)
    self._ui._btn_TradeGame_PC:SetMonoTone(true, true)
    self._ui._btn_TradeGame_PC:SetIgnore(true)
    return
  end
  self._myItemTotalCount = totalSellCount
  local myItemCount = 0
  local temporaryItemTable = {}
  local inventory = getSelfPlayer():get():getInventory()
  for itemIdx = 0, mySellCount - 1 do
    local shopItemWrapper = npcShop_getItemSell(itemIdx)
    if nil ~= shopItemWrapper then
      local tradeItemInfo = {
        _itemFromWhere = self._ENUM_INVENTORY,
        _shopSlotNo = itemIdx,
        _itemKey = shopItemWrapper:getStaticStatus():get()._key:get(),
        _isNodeLinked = false
      }
      temporaryItemTable[myItemCount] = tradeItemInfo
      myItemCount = myItemCount + 1
    end
  end
  local vehicleIndex = 0
  local servantInventorySize = 0
  local temporaryWrapper = getTemporaryInformationWrapper()
  local landServantInfo = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle)
  if nil ~= landServantInfo then
    local servantInventory = landServantInfo:getInventory()
    local isAbleDistance = getDistanceFromVehicle()
    local servantGoodsIdx = 0
    if nil ~= servantInventory and true == isAbleDistance then
      servantInventorySize = servantInventory:size()
      for invenIdx = 1, servantInventorySize - 1 do
        if not servantInventory:empty(invenIdx) then
          if vehicleSellCount <= servantGoodsIdx then
            break
          end
          local servantItemWrapper = npcShop_getVehicleSellItem(servantGoodsIdx)
          if nil == servantItemWrapper then
            break
          end
          local itemStaticStaus = servantItemWrapper:getStaticStatus()
          if true == itemStaticStaus:isForJustTrade() then
            local tradeItemInfo = {
              _itemFromWhere = self._ENUM_LAND_VEHICLE,
              _shopSlotNo = servantGoodsIdx,
              _itemKey = itemStaticStaus:get()._key:get(),
              _isNodeLinked = false
            }
            temporaryItemTable[myItemCount] = tradeItemInfo
            myItemCount = myItemCount + 1
            servantGoodsIdx = servantGoodsIdx + 1
          end
        end
      end
    end
  end
  if true == ToClient_IsContentsGroupOpen("576") and ToClient_IsContentsGroupOpen("504") then
    local seaServantInfo = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Ship)
    if nil ~= seaServantInfo then
      local servantInventory = seaServantInfo:getInventory()
      local isAbleDistance = getDistanceFromShip()
      local servantInventorySize = 0
      local servantGoodsIdx = 0
      if nil ~= servantInventory and true == isAbleDistance then
        servantInventorySize = servantInventory:size()
        for invenIdx = 1, servantInventorySize - 1 do
          if not servantInventory:empty(invenIdx) then
            if seaVehicleSellCount <= servantGoodsIdx then
              break
            end
            local servantItemWrapper = npcShop_getShipSellItem(servantGoodsIdx)
            if nil == servantItemWrapper then
              break
            end
            local itemStaticStaus = servantItemWrapper:getStaticStatus()
            if true == itemStaticStaus:isForJustTrade() then
              local tradeItemInfo = {
                _itemFromWhere = self._ENUM_SEA_VEHICLE,
                _shopSlotNo = servantGoodsIdx,
                _itemKey = itemStaticStaus:get()._key:get(),
                _isNodeLinked = false
              }
              temporaryItemTable[myItemCount] = tradeItemInfo
              myItemCount = myItemCount + 1
              servantGoodsIdx = servantGoodsIdx + 1
            end
          end
        end
      end
    end
  end
  local bigHand = 1000000 ~= getSelfPlayer():get():getlTradeItemCountRate()
  if nil ~= Panel_Dialog_Trade_BiddingGame_All then
    if true == PaGlobalFunc_TradeBiddingGame_All_IsSuccess() or true == bigHand then
      self._ui._btn_TradeGame_PC:SetEnable(false)
      self._ui._btn_TradeGame_PC:SetMonoTone(true)
      if true == self._isConsole then
        Panel_Dialog_Trade_MyBasket_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
        PaGlobal_TradeMyBasket_All._ui._stc_KeyGuide_Y:SetShow(false)
      end
    else
      self._ui._btn_TradeGame_PC:SetEnable(true)
      self._ui._btn_TradeGame_PC:SetMonoTone(false)
      if true == self._isConsole then
        local isFishSupplyMerchant = characterStaticStatus:isFishSupplyMerchant()
        local isSupplyMerchant = characterStaticStatus:isSupplyMerchant()
        local isLoyalFlag = true == isFishSupplyMerchant or true == isSupplyMerchant
        if false == isLoyalFlag then
          Panel_Dialog_Trade_MyBasket_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_TradeMyBasket_All_BiddingGameStart()")
          PaGlobal_TradeMyBasket_All._ui._stc_KeyGuide_Y:SetShow(true)
        end
      end
    end
  elseif nil ~= Panel_TradeGame then
    if true == isTradeGameSuccess() or true == bigHand then
      self._ui._btn_TradeGame_PC:SetEnable(false)
      self._ui._btn_TradeGame_PC:SetMonoTone(true)
    else
      self._ui._btn_TradeGame_PC:SetEnable(true)
      self._ui._btn_TradeGame_PC:SetMonoTone(false)
    end
  end
  for itemIdx = 0, myItemCount - 1 do
    local _slots = temporaryItemTable[itemIdx]
    local itemKey = _slots._itemKey
    local selfPlayer = getSelfPlayer()
    local inventory = selfPlayer:get():getInventory()
    local tradeItemWrapper = npcShop_getTradeItem(itemKey)
    local isSupplyMerchant = characterStaticStatus:isSupplyMerchant()
    local isFishSupplyMerchant = characterStaticStatus:isFishSupplyMerchant()
    local selfPlayerRegion = getRegionInfoByPosition(selfPlayer:get():getPosition())
    local selfPlayerPosition = selfPlayerRegion:get():getTradeOriginRegion():getWaypointInGamePosition()
    local bigHand = 1000000 ~= selfPlayer:get():getlTradeItemCountRate()
    local isExistTradeOrigin = true
    local profitItemGold = toInt64(0, 0)
    local f_sellRate = tradeItemWrapper:getSellPriceRate()
    local s64_inventoryItemCount = toInt64(0, 0)
    local s64_TradeItemNo = toInt64(0, 0)
    local itemValueType
    local invenType = 0
    local eServantType = CppEnums.ServantType.Type_Vehicle
    if self._ENUM_LAND_VEHICLE == _slots._itemFromWhere then
      landServantInfo = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle)
      if nil == landServantInfo then
        break
      end
      local landVehicleActorKey = landServantInfo:getActorKeyRaw()
      if nil == landVehicleActorKey then
        return
      end
      local landVehicleActorProxy = getVehicleActor(landVehicleActorKey)
      if nil == landVehicleActorProxy then
        return
      end
      local vehicleInven = landVehicleActorProxy:get():getInventory()
      s64_TradeItemNo = npcShop_getVehicleInvenItemNoByShopSlotNo(_slots._shopSlotNo)
      s64_inventoryItemCount = vehicleInven:getItemCountByItemNo_s64(s64_TradeItemNo)
      itemValueType = vehicleInven:getItemByItemNo(s64_TradeItemNo)
      invenType = 4
      eServantType = CppEnums.ServantType.Type_Vehicle
    elseif self._ENUM_SEA_VEHICLE == _slots._itemFromWhere then
      if true == ToClient_IsContentsGroupOpen("576") then
        seaServantInfo = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Ship)
        if nil == seaServantInfo then
          break
        end
        local seaVehicleActorKey = seaServantInfo:getActorKeyRaw()
        if nil == seaVehicleActorKey then
          return
        end
        local seaVehicleActorProxy = getVehicleActor(seaVehicleActorKey)
        if nil == seaVehicleActorProxy then
          return
        end
        local vehicleInven = seaVehicleActorProxy:get():getInventory()
        s64_TradeItemNo = npcShop_getShipInvenItemNoByShopSlotNo(_slots._shopSlotNo)
        s64_inventoryItemCount = vehicleInven:getItemCountByItemNo_s64(s64_TradeItemNo)
        itemValueType = vehicleInven:getItemByItemNo(s64_TradeItemNo)
        invenType = 4
        eServantType = CppEnums.ServantType.Type_Ship
      end
    elseif self._ENUM_INVENTORY == _slots._itemFromWhere then
      s64_TradeItemNo = npcShop_getItemNo(_slots._shopSlotNo)
      s64_inventoryItemCount = inventory:getItemCountByItemNo_s64(s64_TradeItemNo)
      itemValueType = inventory:getItemByItemNo(s64_TradeItemNo)
      invenType = 0
    end
    local regionInfo = itemValueType:getItemRegionInfo()
    local fromPosition = float3(0, 0, 0)
    if 0 ~= regionInfo._waypointKey then
      fromPosition = regionInfo:getWaypointInGamePosition()
    end
    if nil == tradeItemWrapper:get() then
      _PA_ASSERT(false, "npcShop_getTradeItem \234\176\128 nil \236\158\133\235\139\136\235\139\164!! : PaGlobal_TradeMarketGoods_CreateList")
      return
    end
    local expirationIndex
    local itemExpiration = itemValueType:getExpirationDate()
    if itemExpiration:isDefined() and false == itemExpiration:isIndefinite() then
      local s64_Time = itemExpiration:get_s64()
      local s64_remainTime = getLeftSecond_s64(itemExpiration)
      if Defines.s64_const.s64_0 == s64_remainTime then
        expirationIndex = 1
      else
        expirationIndex = 0
      end
    else
      expirationIndex = -1
    end
    local leftPeriod = FromClient_getTradeItemExpirationDate(itemExpiration, tradeItemWrapper:getStaticStatus():get()._expirationPeriod)
    if true == isFishSupplyMerchant and 300000 < leftPeriod then
      leftPeriod = 1000000
    end
    local displayPeriod = leftPeriod / self._CONST_CALCULATE_PERCENT_VALUE
    local realPrice = 0
    if false == isSupplyMerchant and false == isFishSupplyMerchant then
      if nil ~= Panel_Dialog_Trade_BiddingGame_All then
        realPrice = getCalculateTradeItemPrice(tradeItemWrapper:getTradeSellPrice(), tradeItemWrapper:getStaticStatus():getCommerceType(), fromPosition, selfPlayerPosition, tradeItemWrapper:getTradeGroupType(), characterStaticStatus:getTradeGroupType(), leftPeriod, PaGlobalFunc_TradeBiddingGame_All_IsSuccess() or bigHand)
      else
        realPrice = getCalculateTradeItemPrice(tradeItemWrapper:getTradeSellPrice(), tradeItemWrapper:getStaticStatus():getCommerceType(), fromPosition, selfPlayerPosition, tradeItemWrapper:getTradeGroupType(), characterStaticStatus:getTradeGroupType(), leftPeriod, isTradeGameSuccess() or bigHand)
      end
    else
      realPrice = tradeItemWrapper:getTradeSellPrice()
    end
    local fromToDistanceNavi = 0
    if 0 ~= regionInfo._waypointKey then
      fromToDistanceNavi = getFromToDistanceTradeShop()
    else
      isExistTradeOrigin = false
    end
    local bonusPercent = 0
    bonusPercent = math.floor(fromToDistanceNavi / 100 * FromClient_getTradeBonusPercent())
    bonusPercent = math.min(bonusPercent, FromClient_getTradeMaxDistancePercent())
    local desertBuffPercent = ToClient_TradeGroupFromToAddPercent(tradeItemWrapper:getTradeGroupType(), characterStaticStatus:getTradeGroupType())
    local desertBuffDistance = ToClient_TradeGroupFromToDistance(tradeItemWrapper:getTradeGroupType(), characterStaticStatus:getTradeGroupType())
    if not (100 < desertBuffPercent) or fromToDistanceNavi >= desertBuffDistance then
    else
    end
    local isLinkedNode = npcShop_CheckLinkedItemExplorationNode(_slots._shopSlotNo, invenType, eServantType)
    local isNodeFreeTrade = tradeItemWrapper:getStaticStatus():get():isNodeFreeTrade()
    if isNodeFreeTrade or isSupplyMerchant then
      isLinkedNode = true
    end
    if false == isLinkedNode then
      self._isNoLinkedNodeOne = true
      realPrice = Int64toInt32(tradeItemWrapper:getStaticStatus():get()._originalPrice_s64) * getNotLinkNodeSellPercent() / self._CONST_CALCULATE_PERCENT_VALUE / 100
      f_sellRate = getNotLinkNodeSellPercent() / self._CONST_CALCULATE_PERCENT_VALUE
      if false == isExistTradeOrigin then
        realPrice = Int64toInt32(tradeItemWrapper:getStaticStatus():get()._originalPrice_s64)
        f_sellRate = 100
      end
      profitItemGold = toInt64(0, realPrice) - itemValueType:getBuyingPrice()
    else
      profitItemGold = realPrice - itemValueType:getBuyingPrice()
    end
    if true == isSupplyMerchant or true == isFishSupplyMerchant then
      local profitRate = tradeItemWrapper:getSellPriceRate()
      if not isLinkedNode and true == isFishSupplyMerchant then
        profitRate = 30
      end
      local sellPrice = Int64toInt32(tradeItemWrapper:getStaticStatus():get()._originalPrice_s64)
      profitItemGold = sellPrice * profitRate / 100 * displayPeriod / 100
    end
    local itemData = {}
    itemData.itemKey = itemKey
    itemData.sellRate = f_sellRate
    itemData.realPrice = realPrice
    itemData.displayPeriod = displayPeriod
    itemData.bonusPercent = bonusPercent
    itemData.profitItemGold = profitItemGold
    itemData.leftCount = s64_inventoryItemCount
    itemData.itemFromWhere = _slots._itemFromWhere
    itemData.invenNum = _slots._shopSlotNo
    itemData.inventoryType = invenType
    self._myItemDataTable[itemIdx] = itemData
    self._realPriceList[itemIdx] = Int64toInt32(realPrice)
  end
  if 0 < totalSellCount then
    for sellItemIdx = 0, totalSellCount - 1 do
      if nil ~= self._myItemDataTable[sellItemIdx] then
        self._ui._list2_MyItem:getElementManager():pushKey(toInt64(0, sellItemIdx))
      end
    end
  end
  if self._list2ScrollData._currentIdx ~= self._ui._list2_MyItem:getCurrenttoIndex() and 0 < self._list2ScrollData._currentIdx then
    self._ui._list2_MyItem:setCurrenttoIndex(self._list2ScrollData._currentIdx)
    self._ui._list2_MyItem:GetVScroll():SetControlPos(self._list2ScrollData._scrollPos)
  end
end
function PaGlobal_TradeMyBasket_All:updateMyItemData(content, key)
  if nil == self._myItemDataTable or nil == key then
    return
  end
  local key32 = Int64toInt32(key)
  local itemData = self._myItemDataTable[key32]
  if nil == itemData then
    return
  end
  local tradeItemWrapper = npcShop_getTradeItem(itemData.itemKey)
  local itemSSW = tradeItemWrapper:getStaticStatus()
  local characterStaticStatusWrapper = npcShop_getCurrentCharacterKeyForTrade()
  local characterStaticStatus = characterStaticStatusWrapper:get()
  local isFishSupplyMerchant = characterStaticStatus:isFishSupplyMerchant()
  local isSupplyMerchant = characterStaticStatus:isSupplyMerchant()
  local isLoyalFlag = true == isFishSupplyMerchant or true == isSupplyMerchant
  local itemWrapper
  if 1 == itemData.itemFromWhere then
    itemWrapper = npcShop_getVehicleItemWrapper(itemData.invenNum)
  elseif 2 == itemData.itemFromWhere then
    itemWrapper = npcShop_getShipItemWrapper(itemData.invenNum)
  else
    itemWrapper = npcShop_getItemWrapperByShopSlotNo(itemData.invenNum)
  end
  local f_sellRate = itemData.sellRate
  local realPrice = itemData.realPrice
  local displayPeriod = itemData.displayPeriod
  local bonusPercent = itemData.bonusPercent
  local profitItemGold = itemData.profitItemGold
  local slotBg = UI.getChildControl(content, "Static_SlotBg")
  local itemIconBg = UI.getChildControl(content, "Static_ItemBg")
  local txt_ItemName = UI.getChildControl(content, "StaticText_ItemName")
  local txt_ItemPrice = UI.getChildControl(content, "StaticText_Price")
  local txt_Period = UI.getChildControl(content, "StaticText_Period")
  local txt_Profit = UI.getChildControl(content, "StaticText_Profit")
  local icon_Origin = UI.getChildControl(content, "Static_Origin")
  local txt_Origin = UI.getChildControl(icon_Origin, "StaticText_Origin")
  local icon_DistanceBonus = UI.getChildControl(content, "Static_DistanceBonus")
  local txt_DistanceBonus = UI.getChildControl(icon_DistanceBonus, "StaticText_DistanceBonus")
  local txt_TradeGame = UI.getChildControl(content, "StaticText_TradeGame")
  local btn_Sell = UI.getChildControl(content, "Button_Sell")
  btn_Sell:SetShow(not self._isConsole)
  local distanceBonusString = bonusPercent / self._CONST_CALCULATE_PERCENT_VALUE - bonusPercent / self._CONST_CALCULATE_PERCENT_VALUE % 1 .. "%"
  local str_sellRate = string.format("%.f", npcShop_GetTradeGraphRateOfPrice(itemData.itemKey))
  local str_sellRate_Value = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEMARKET_ALL_SELLRATES", "Percent", str_sellRate)
  if 100 < tonumber(tostring(str_sellRate)) then
    str_sellRate_Value = "<PAColor0xff76b24d>" .. str_sellRate_Value .. "\226\150\178<PAOldColor>"
  else
    str_sellRate_Value = "<PAColor0xff3b8bbe>" .. str_sellRate_Value .. "\226\150\188<PAOldColor>"
  end
  local itemIcon = {}
  SlotItem.reInclude(itemIcon, "MySellItemIcon", key32, itemIconBg, self.slotConfig)
  itemIcon:setItemByStaticStatus(itemSSW, itemWrapper:get():getCount_s64(), nil, nil, nil)
  itemIcon.count:SetShow(true)
  itemIcon.count:SetText(tostring(itemData.leftCount))
  if 1 == itemData.itemFromWhere or 2 == itemData.itemFromWhere then
    txt_ItemName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEMARKET_RIDE", "getName", itemSSW:getName()))
  else
    txt_ItemName:SetText(itemSSW:getName())
  end
  if txt_ItemName:GetSizeX() < txt_ItemName:GetTextSizeX() then
    txt_ItemName:SetTextMode(__eTextMode_LimitText)
    txt_ItemName:SetText(txt_ItemName:GetText())
    txt_ItemName:addInputEvent("Mouse_On", "HandleEventOnOut_TradeMyBasket_All_LimitTextTooltip(" .. key32 .. ",true, false)")
    txt_ItemName:addInputEvent("Mouse_Out", "HandleEventOnOut_TradeMyBasket_All_LimitTextTooltip(" .. key32 .. ",false)")
    txt_ItemName:SetIgnore(false)
  end
  PAGlobalFunc_SetItemTextColorForNewUI(txt_ItemName, itemSSW)
  txt_ItemPrice:ComputePos()
  if __eTradeSupplyShopType_Shell == self._currShopType then
    txt_ItemPrice:SetPosY(40)
    txt_ItemPrice:SetPosX(txt_ItemPrice:GetPosX() + 5)
  end
  txt_ItemPrice:SetText(makeDotMoney(Int64toInt32(realPrice)) .. " (" .. str_sellRate_Value .. ")")
  self:setMoneyTexture(txt_ItemPrice)
  txt_Period:SetText(tostring(displayPeriod) .. "%")
  if true == self._isConsole then
    txt_DistanceBonus:SetTextMode(__eTextMode_AutoWrap)
  else
    txt_DistanceBonus:SetTextMode(__eTextMode_LimitText)
  end
  txt_DistanceBonus:SetText(distanceBonusString)
  if true == characterStaticStatus:isSupplyMerchant() or true == characterStaticStatus:isFishSupplyMerchant() then
    txt_DistanceBonus:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_SELLLIST_NOTAPPLY"))
    icon_DistanceBonus:addInputEvent("Mouse_On", "HandleEventOnOut_TradeMyBasket_All_SimpleTooltip(true, 6," .. key32 .. ")")
    icon_DistanceBonus:addInputEvent("Mouse_Out", "HandleEventOnOut_TradeMyBasket_All_SimpleTooltip()")
  else
    icon_DistanceBonus:addInputEvent("Mouse_On", "HandleEventOnOut_TradeMyBasket_All_SimpleTooltip(true, 3," .. key32 .. ")")
    icon_DistanceBonus:addInputEvent("Mouse_Out", "HandleEventOnOut_TradeMyBasket_All_SimpleTooltip()")
  end
  if true == txt_DistanceBonus:IsLimitText() then
    txt_DistanceBonus:addInputEvent("Mouse_On", "HandleEventOnOut_TradeMyBasket_All_SimpleTooltip(true, 12," .. key32 .. ")")
    txt_DistanceBonus:addInputEvent("Mouse_Out", "HandleEventOnOut_TradeMyBasket_All_SimpleTooltip()")
  end
  local origin = itemWrapper:getProductionRegion()
  txt_Origin:SetText(origin)
  if txt_Origin:GetTextSizeX() > txt_Origin:GetSizeX() then
    txt_Origin:SetTextMode(__eTextMode_Limit_AutoWrap)
    txt_Origin:SetText(origin)
    if true == self._isConsole then
      txt_Origin:addInputEvent("Mouse_On", "HandleEventOnOut_TradeMyBasket_All_SimpleTooltip(true, 11," .. key32 .. ")")
      txt_Origin:addInputEvent("Mouse_Out", "HandleEventOnOut_TradeMyBasket_All_SimpleTooltip()")
    else
    end
  end
  if toInt64(0, profitItemGold) < toInt64(0, 0) then
    local profitItemGold_abs = toInt64(0, math.abs(Int64toInt32(profitItemGold)))
    txt_Profit:SetFontColor(Defines.Color.C_FFD20000)
    txt_Profit:SetText("-" .. makeDotMoney(profitItemGold_abs))
  else
    txt_Profit:SetFontColor(Defines.Color.C_FFFFCE22)
    txt_Profit:SetText(makeDotMoney(profitItemGold))
  end
  if nil ~= Panel_Dialog_Trade_BiddingGame_All then
    if true == PaGlobalFunc_TradeBiddingGame_All_IsSuccess() then
      txt_TradeGame:SetText("- " .. PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_ALL_BIDDINGGAME"))
      txt_TradeGame:SetShow(true)
      txt_TradeGame:SetFontColor(Defines.Color.C_FF83A543)
    else
      txt_TradeGame:SetShow(false)
    end
  elseif true == isTradeGameSuccess() then
    txt_TradeGame:SetText("- " .. PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_ALL_BIDDINGGAME"))
    txt_TradeGame:SetShow(true)
    txt_TradeGame:SetFontColor(Defines.Color.C_FF83A543)
  else
    txt_TradeGame:SetShow(false)
  end
  local mySellList = {
    _txt_ItemName = nil,
    _itemName = nil,
    _txt_ItemPrice = nil,
    _txt_Period = nil,
    _txt_Profit = nil,
    _txt_Origin = nil,
    _icon_Origin = nil,
    _txt_DistanceBonus = nil,
    _icon_DistanceBonus = nil,
    _txt_TradeGame = nil
  }
  mySellList._itemName = itemSSW:getName()
  mySellList._txt_ItemName = txt_ItemName
  mySellList._txt_ItemPrice = txt_ItemPrice
  mySellList._txt_Period = txt_Period
  mySellList._txt_Profit = txt_Profit
  mySellList._icon_Origin = icon_Origin
  mySellList._txt_Origin = txt_Origin
  mySellList._icon_DistanceBonus = icon_DistanceBonus
  mySellList._txt_DistanceBonus = txt_DistanceBonus
  mySellList._txt_TradeGame = txt_TradeGame
  self._myItemSlotTable[key32] = mySellList
  if false == self._isConsole then
    slotBg:addInputEvent("Mouse_LUp", "HandleEventLUp_TradeMyBasket_All_FindItemInSellList(" .. itemData.itemKey .. ")")
    btn_Sell:addInputEvent("Mouse_LUp", "HandleEventLUp_TradeMyBasket_All_SelectedItemSell(" .. key32 .. ")")
    if 1 ~= itemData.itemFromWhere and 2 ~= itemData.itemFromWhere then
      itemIcon.icon:addInputEvent("Mouse_On", "HandleEventOnOut_TradeMyBasket_All_ItemIconTooltip(" .. itemData.invenNum .. ",1 )")
      itemIcon.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_TradeMyBasket_All_ItemIconTooltip()")
      slotBg:addInputEvent("Mouse_On", "HandleEventOnOut_TradeMyBasket_All_ItemIconTooltip(" .. itemData.invenNum .. ",1 )")
      slotBg:addInputEvent("Mouse_Out", "HandleEventOnOut_TradeMyBasket_All_ItemIconTooltip()")
      Panel_Tooltip_Item_SetPosition(itemData.invenNum, itemIcon, "tradeMarket_Sell")
    else
      local tooltipType = 2
      if 2 == itemData.itemFromWhere then
        tooltipType = 3
      end
      itemIcon.icon:addInputEvent("Mouse_On", "HandleEventOnOut_TradeMyBasket_All_ItemIconTooltip(" .. itemData.invenNum .. "," .. tostring(tooltipType) .. " )")
      slotBg:addInputEvent("Mouse_On", "HandleEventOnOut_TradeMyBasket_All_ItemIconTooltip(" .. itemData.invenNum .. "," .. tostring(tooltipType) .. " )")
      itemIcon.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_TradeMyBasket_All_ItemIconTooltip()")
      slotBg:addInputEvent("Mouse_Out", "HandleEventOnOut_TradeMyBasket_All_ItemIconTooltip()")
      Panel_Tooltip_Item_SetPosition(itemData.invenNum, itemIcon, tostring(self._tooltipType[tooltipType]))
    end
    txt_Profit:addInputEvent("Mouse_On", "HandleEventOnOut_TradeMyBasket_All_SimpleTooltip(true, 1," .. key32 .. ")")
    txt_ItemPrice:addInputEvent("Mouse_On", "HandleEventOnOut_TradeMyBasket_All_SimpleTooltip(true, 0," .. key32 .. ")")
    icon_Origin:addInputEvent("Mouse_On", "HandleEventOnOut_TradeMyBasket_All_SimpleTooltip(true, 4," .. key32 .. ")")
    txt_Period:addInputEvent("Mouse_On", "HandleEventOnOut_TradeMyBasket_All_SimpleTooltip(true, 5," .. key32 .. ")")
    txt_Profit:addInputEvent("Mouse_Out", "HandleEventOnOut_TradeMyBasket_All_SimpleTooltip()")
    txt_ItemPrice:addInputEvent("Mouse_Out", "HandleEventOnOut_TradeMyBasket_All_SimpleTooltip()")
    icon_Origin:addInputEvent("Mouse_Out", "HandleEventOnOut_TradeMyBasket_All_SimpleTooltip()")
    txt_Period:addInputEvent("Mouse_Out", "HandleEventOnOut_TradeMyBasket_All_SimpleTooltip()")
  else
    slotBg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_TradeMyBasket_All_SelectedItemSell(" .. key32 .. ")")
  end
end
function PaGlobal_TradeMyBasket_All:myMoneyUpdate()
  if nil == getSelfPlayer() or nil == Panel_Dialog_Trade_MyBasket_All then
    return
  end
  self._totalPrice = 0
  if nil ~= self._currentCartItemTable and nil ~= self._currentSlotCount and 0 < self._currentSlotCount then
    for idx = 1, #self._currentCartItemTable do
      if nil ~= self._currentCartItemTable[idx] then
        local itemPrice = self._currentCartItemTable[idx]._itemPrice
        local itemCount = Int64toInt32(self._currentCartItemTable[idx]._count)
        local totalPrice = itemPrice * itemCount
        self._totalPrice = self._totalPrice + totalPrice
      end
    end
  end
  self._ui._txt_NeedMoney:SetText(makeDotMoney(self._totalPrice))
  self._ui._txt_Money:SetPosY(self._ui._stc_Money:GetPosY())
  if __eTradeSupplyShopType_Shell == self._currShopType then
    local shellValue = self:getShellValue()
    self._ui._txt_Money:SetText(makeDotMoney(shellValue))
  else
    self._ui._txt_Money:SetText(makeDotMoney(getSelfPlayer():get():getInventory():getMoney_s64()))
  end
  self:setMoneyTexture(self._ui._txt_Money)
end
function PaGlobal_TradeMyBasket_All:getShellValue()
  local shellValue = Defines.s64_const.s64_0
  if true == _ContentsGroup_Barter then
    local priceItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eMoneyInventory, __eInventoryMoneyType_Shell)
    if nil ~= priceItemWrapper then
      shellValue = priceItemWrapper:get():getCount_s64()
    end
  end
  return shellValue
end
function PaGlobal_TradeMyBasket_All:setMoneyTexture(control)
  if __eTradeSupplyShopType_Shell == self._currShopType then
    control:ChangeTextureInfoName("Combine/Icon/Combine_Cashshop_Icon_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 101, 24, 120, 43)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
    control:SetSize(20, 20)
  else
    control:ChangeTextureInfoName("combine/icon/combine_basic_icon_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 359, 103, 409, 153)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
    control:SetSize(35, 35)
  end
end
function PaGlobal_TradeMyBasket_All:inventoryUpdate(cartSlot, cartWeight)
  if nil == Panel_Dialog_Trade_MyBasket_All then
    return
  end
  if nil == cartSlot then
    cartSlot = 0
  end
  if nil == cartWeight then
    cartWeight = 0
  end
  local selfPlayerWrapper = getSelfPlayer()
  local selfPlayer = selfPlayerWrapper:get()
  local s64_equipmentWeight = selfPlayer:getEquipment():getWeight_s64()
  local s64_allWeight = selfPlayer:getCurrentWeight_s64()
  local s64_maxWeight = selfPlayer:getPossessableWeight_s64()
  local equipmentWeight = Int64toInt32(s64_equipmentWeight)
  local allWeight = Int64toInt32(s64_allWeight)
  local maxWeight = Int64toInt32(s64_maxWeight)
  local cartWeight = Int64toInt32(cartWeight)
  if true == self._ui._rdo_Inven:IsCheck() then
    allWeight = allWeight + cartWeight
  end
  local LT_TEXT = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT")
  local finalWeightText = "-"
  local useStartSlot = inventorySlotNoUserStart()
  local invenUseSize = getSelfPlayer():get():getInventorySlotCount(false)
  local inventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
  local invenMaxSize = inventory:sizeXXX()
  local freeCount = inventory:getFreeCount()
  local totalCurrentCount = invenUseSize - freeCount - useStartSlot
  local totalMaxCount = invenUseSize - useStartSlot
  local finalSlotText = "-"
  if totalMaxCount < totalCurrentCount + cartSlot then
    finalSlotText = "<PAColor0xffd05d48>" .. tostring(totalCurrentCount + cartSlot) .. "<PAOldColor>" .. "/" .. tostring(totalMaxCount)
  else
    finalSlotText = "<PAColor0xfff5ba3a>" .. tostring(totalCurrentCount + cartSlot) .. "<PAOldColor>" .. "/" .. tostring(totalMaxCount)
  end
  if maxWeight < allWeight then
    finalWeightText = "<PAColor0xffd05d48>" .. makeWeightString(allWeight, 1) .. "<PAOldColor>" .. "" .. LT_TEXT .. " / " .. makeWeightString(maxWeight, 0) .. " " .. LT_TEXT
  else
    finalWeightText = "<PAColor0xfff5ba3a>" .. makeWeightString(allWeight, 1) .. "<PAOldColor>" .. "" .. LT_TEXT .. " / " .. makeWeightString(maxWeight, 0) .. " " .. LT_TEXT
  end
  self._ui._txt_InvenWeight:SetText(finalWeightText)
  self._ui._txt_InvenSlotCount:SetText(finalSlotText)
end
function PaGlobal_TradeMyBasket_All:addCartInfo()
  self._totalWeight = toInt64(0, 0)
  self._totalSlot = 0
  if nil ~= self._currentCartItemTable and nil ~= self._currentSlotCount and 0 < self._currentSlotCount then
    for idx = 1, self._currentSlotCount do
      if nil ~= self._currentCartItemTable[idx] then
        local curWeight = self._currentCartItemTable[idx]._weight
        local curCount = Int64toInt32(self._currentCartItemTable[idx]._count)
        self._totalWeight = self._totalWeight + curWeight * toInt64(0, curCount)
        self._totalSlot = self._totalSlot + curCount
      end
    end
  end
  if self._totalWeight ~= toInt64(0, 0) or 0 == self._totalSlot then
    if true == self._ui._rdo_Inven:IsChecked() then
      PaGlobal_TradeMyBasket_All:inventoryUpdate(self._totalSlot, self._totalWeight)
      PaGlobal_TradeMyBasket_All:checkVehicle()
    else
      PaGlobal_TradeMyBasket_All:checkVehicle(self._totalSlot, self._totalWeight)
      PaGlobal_TradeMyBasket_All:inventoryUpdate()
    end
  end
  PaGlobal_TradeMyBasket_All:checkHasItem()
end
function PaGlobal_TradeMyBasket_All:checkVehicle(cartSlot, cartWeight)
  if nil == Panel_Dialog_Trade_MyBasket_All then
    return
  end
  local myLandVehicle = getTemporaryInformationWrapper()
  local landServantInfoWrapper = myLandVehicle:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle)
  local LT_TEXT = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT")
  if nil == cartSlot then
    cartSlot = 0
  end
  if nil == cartWeight then
    cartWeight = toInt64(0, 0)
  end
  self._ui._rdo_SeaVehicle:SetIgnore(true)
  self._ui._rdo_SeaVehicle:SetMonoTone(true)
  self._ui._txt_SeaWeight:SetText("-")
  self._ui._txt_SeaSlotCount:SetText("-")
  self._ui._txt_SeaWeight:SetFontColor(Defines.Color.C_FF988D83)
  self._ui._txt_SeaSlotCount:SetFontColor(Defines.Color.C_FF988D83)
  self._ui._rdo_LandVehicle:SetIgnore(true)
  self._ui._rdo_LandVehicle:SetMonoTone(true)
  self._ui._txt_LandWeight:SetText("-")
  self._ui._txt_LandSlotCount:SetText("-")
  self._ui._txt_LandWeight:SetFontColor(Defines.Color.C_FF988D83)
  self._ui._txt_LandSlotCount:SetFontColor(Defines.Color.C_FF988D83)
  self._vehicleStatus = self._ENUM_NO_VEHICLE
  if nil ~= landServantInfoWrapper then
    local landVehicleActorKeyRaw = myLandVehicle:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle):getActorKeyRaw()
    local isAbleDistance = getDistanceFromVehicle()
    if true == isAbleDistance then
      local vehicleActor = getVehicleActor(landVehicleActorKeyRaw)
      local servantActor = vehicleActor:get()
      local inventory = servantActor:getInventory()
      local maxInventorySlot = inventory:size() - 2
      local freeInventorySlot = 0
      if 0 < cartSlot and true == self._ui._rdo_LandVehicle:IsCheck() then
        freeInventorySlot = math.abs(maxInventorySlot - inventory:getFreeCount()) + cartSlot
      else
        freeInventorySlot = math.abs(maxInventorySlot - inventory:getFreeCount())
      end
      if Int64toInt32(maxInventorySlot) < Int64toInt32(freeInventorySlot) then
        self._ui._txt_LandSlotCount:SetText("<PAColor0xffd05d48>" .. tostring(freeInventorySlot) .. "<PAOldColor>" .. " / " .. tostring(maxInventorySlot))
      else
        self._ui._txt_LandSlotCount:SetText("<PAColor0xfff5ba3a>" .. tostring(freeInventorySlot) .. "<PAOldColor>" .. " / " .. tostring(maxInventorySlot))
      end
      local servantWrapper = myLandVehicle:getUnsealVehicleByActorKeyRaw(landVehicleActorKeyRaw)
      local total_weight = 0
      local total_weight_s64 = 0
      local max_weight_s64 = servantWrapper:getMaxWeight_s64()
      local invenWeight32 = Int64toInt32(servantWrapper:getInventoryWeight_s64())
      local equipWeight32 = Int64toInt32(servantWrapper:getEquipWeight_s64())
      local cartWeight32 = Int64toInt32(cartWeight)
      local max_weight = Int64toInt32(servantWrapper:getMaxWeight_s64())
      if cartWeight > toInt64(0, 0) and true == self._ui._rdo_LandVehicle:IsCheck() then
        total_weight = invenWeight32 + equipWeight32 + cartWeight32
      else
        total_weight = invenWeight32 + equipWeight32
      end
      if max_weight < total_weight then
        self._ui._txt_LandWeight:SetText("<PAColor0xffd05d48>" .. makeWeightString(total_weight, 1) .. "<PAOldColor>" .. LT_TEXT .. " / " .. makeWeightString(max_weight, 0) .. " " .. LT_TEXT)
      else
        self._ui._txt_LandWeight:SetText("<PAColor0xfff5ba3a>" .. makeWeightString(total_weight, 1) .. "<PAOldColor>" .. LT_TEXT .. " / " .. makeWeightString(max_weight, 0) .. " " .. LT_TEXT)
      end
      self._vehicleStatus = self._ENUM_LAND_VEHICLE
      self._ui._rdo_LandVehicle:SetIgnore(false)
      self._ui._rdo_LandVehicle:SetMonoTone(false)
      self._ui._txt_LandWeight:SetShow(true)
      self._ui._txt_LandWeight:SetFontColor(Defines.Color.C_FFDDC39E)
      self._ui._txt_LandSlotCount:SetFontColor(Defines.Color.C_FFDDC39E)
    else
      self._ui._txt_LandWeight:SetShow(false)
      self._ui._txt_LandSlotCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_ALL_SERVANT_NOT_NEAR"))
    end
  end
  if true == ToClient_IsContentsGroupOpen("576") and ToClient_IsContentsGroupOpen("504") then
    local seaServantInfoWrapper = myLandVehicle:getUnsealVehicle(CppEnums.ServantType.Type_Ship)
    if nil ~= seaServantInfoWrapper then
      local seaVehicleActorKeyRaw = myLandVehicle:getUnsealVehicle(CppEnums.ServantType.Type_Ship):getActorKeyRaw()
      local isAbleDistance = getDistanceFromShip()
      if true == isAbleDistance then
        local servantWrapper = getVehicleActor(seaVehicleActorKeyRaw)
        local servantActor = servantWrapper:get()
        local inventory = servantActor:getInventory()
        local useStartSlot = inventorySlotNoUserStart()
        local maxInventorySlot = inventory:size() - useStartSlot
        local freeInventorySlot = 0
        if 0 < cartSlot and true == self._ui._rdo_SeaVehicle:IsCheck() then
          freeInventorySlot = math.abs(maxInventorySlot - inventory:getFreeCount()) + cartSlot
        else
          freeInventorySlot = math.abs(maxInventorySlot - inventory:getFreeCount())
        end
        if Int64toInt32(maxInventorySlot) < Int64toInt32(freeInventorySlot) then
          self._ui._txt_SeaSlotCount:SetText("<PAColor0xffd05d48>" .. tostring(freeInventorySlot) .. "<PAOldColor>" .. " / " .. tostring(maxInventorySlot))
        else
          self._ui._txt_SeaSlotCount:SetText("<PAColor0xfff5ba3a>" .. tostring(freeInventorySlot) .. "<PAOldColor>" .. " / " .. tostring(maxInventorySlot))
        end
        local currentWeight = Int64toInt32(servantActor:getCurrentWeight_s64())
        local max_weight = Int64toInt32(servantActor:getPossessableWeight_s64())
        local cartWeight32 = Int64toInt32(cartWeight)
        local total_weight = 0
        if true == self._ui._rdo_SeaVehicle:IsCheck() and cartWeight > toInt64(0, 0) then
          total_weight = currentWeight + cartWeight32
        else
          total_weight = currentWeight
        end
        if max_weight < total_weight then
          self._ui._txt_SeaWeight:SetText("<PAColor0xffd05d48>" .. makeWeightString(total_weight, 1) .. "<PAOldColor>" .. LT_TEXT .. " / " .. makeWeightString(max_weight, 0) .. " " .. LT_TEXT)
        else
          self._ui._txt_SeaWeight:SetText("<PAColor0xfff5ba3a>" .. makeWeightString(total_weight, 1) .. "<PAOldColor>" .. LT_TEXT .. " / " .. makeWeightString(max_weight, 0) .. " " .. LT_TEXT)
        end
        self._ui._rdo_SeaVehicle:SetIgnore(false)
        self._ui._rdo_SeaVehicle:SetMonoTone(false)
        self._ui._txt_SeaWeight:SetShow(true)
        self._ui._txt_SeaWeight:SetFontColor(Defines.Color.C_FFDDC39E)
        self._ui._txt_SeaSlotCount:SetFontColor(Defines.Color.C_FFDDC39E)
        if self._ENUM_LAND_VEHICLE == self._vehicleStatus then
          self._vehicleStatus = self._ENUM_ALL_VEHICLE
        else
          self._vehicleStatus = self._ENUM_SEA_VEHICLE
        end
      else
        self._ui._txt_SeaWeight:SetShow(false)
        self._ui._txt_SeaSlotCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_ALL_SERVANT_NOT_NEAR"))
      end
    end
  end
end
function PaGlobal_TradeMyBasket_All:updatePadXEvent()
  if true == self._isConsole then
    local currentTab = PaGlobalFunc_TradeFunction_All_GetCurrentTab()
    if PaGlobal_TradeMyBasket_All._ENUM_TAB_SELL == currentTab then
      if 0 < self._myItemTotalCount then
        Panel_Dialog_Trade_MyBasket_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_TradeMyBasket_All_SellAll()")
      else
        Panel_Dialog_Trade_MyBasket_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
      end
    elseif PaGlobal_TradeMyBasket_All._ENUM_TAB_BUY == currentTab then
      if 0 < self._currentSlotCount then
        Panel_Dialog_Trade_MyBasket_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_TradeMyBasket_All_BuyAll()")
      else
        Panel_Dialog_Trade_MyBasket_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
      end
    end
  end
end
