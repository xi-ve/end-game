function PaGlobal_NPCShop_ALL:initialize()
  self._ui._stc_TitleBg = UI.getChildControl(Panel_Dialog_NPCShop_All, "Static_Title_BG")
  self._ui._stc_SubBg = UI.getChildControl(Panel_Dialog_NPCShop_All, "Static_SubBg")
  self._ui._pc._btn_Close = UI.getChildControl(self._ui._stc_TitleBg, "Button_Close_PCUI")
  self._ui._pc._btn_Question = UI.getChildControl(self._ui._stc_TitleBg, "Button_Question_PCUI")
  self._ui._pc._stc_TabGroup = UI.getChildControl(Panel_Dialog_NPCShop_All, "StaticText_Tap_Group_PCUI")
  self._ui._pc._btn_Radio_Buy = UI.getChildControl(self._ui._pc._stc_TabGroup, "RadioButton_Tab_Buy")
  self._ui._pc._btn_Radio_Sell = UI.getChildControl(self._ui._pc._stc_TabGroup, "RadioButton_Tab_Sell")
  self._ui._pc._btn_Radio_Repurchase = UI.getChildControl(self._ui._pc._stc_TabGroup, "RadioButton_Tab_Repurchase")
  self._ui._pc._btn_Buy = UI.getChildControl(Panel_Dialog_NPCShop_All, "Button_Command_PCUI")
  self._ui._pc._btn_BuySome = UI.getChildControl(Panel_Dialog_NPCShop_All, "Button_BuySome_PCUI")
  self._ui._pc._btn_SellAll = UI.getChildControl(Panel_Dialog_NPCShop_All, "Button_SellAll_PCUI")
  self._ui._console._stc_TabGroup_Console = UI.getChildControl(Panel_Dialog_NPCShop_All, "StaticText_Tap_Group_ConsoleUI")
  self._ui._console._btn_TabGroup_LT = UI.getChildControl(self._ui._console._stc_TabGroup_Console, "Static_LT")
  self._ui._console._btn_TabGroup_RT = UI.getChildControl(self._ui._console._stc_TabGroup_Console, "Static_RT")
  self._ui._console._btn_Radio_Buy_Console = UI.getChildControl(self._ui._console._stc_TabGroup_Console, "RadioButton_Buy")
  self._ui._console._btn_Radio_Sell_Console = UI.getChildControl(self._ui._console._stc_TabGroup_Console, "RadioButton_Sell")
  self._ui._console._btn_Radio_Repurchase_Console = UI.getChildControl(self._ui._console._stc_TabGroup_Console, "RadioButton_Re_Buy")
  self._ui._console._stc_KeyGuide = UI.getChildControl(Panel_Dialog_NPCShop_All, "Static_Key_Guide_ConsoleUI")
  self._ui._console._stc_Key_Purchase = UI.getChildControl(self._ui._console._stc_KeyGuide, "StaticText_A_ConsoleUI")
  self._ui._console._stc_Key_Purchase_All = UI.getChildControl(self._ui._console._stc_KeyGuide, "StaticText_A2_ConsoleUI")
  self._ui._console._stc_Key_Detail = UI.getChildControl(self._ui._console._stc_KeyGuide, "StaticText_XForDetail_ConsoleUI")
  self._ui._console._stc_Key_Cancel = UI.getChildControl(self._ui._console._stc_KeyGuide, "StaticText_Cancel_ConsoleUI")
  self._ui._console._stc_Key_Scroll = UI.getChildControl(self._ui._console._stc_KeyGuide, "StaticText_Move_ConsoleUI")
  self._ui._stc_SelectBar = UI.getChildControl(Panel_Dialog_NPCShop_All, "Static_TapSelectBar")
  self._ui._list2_Item_List = UI.getChildControl(Panel_Dialog_NPCShop_All, "List2_ItemList")
  self._ui._list2_Content = UI.getChildControl(self._ui._list2_Item_List, "List2_1_Content")
  self._ui._list2_RdoBtn = UI.getChildControl(self._ui._list2_Content, "RadioButton_1")
  self._ui._btn_Radio_LeftTemplete = UI.getChildControl(self._ui._list2_Content, "RadioButton_1")
  self._ui._stc_ItemSlot_LeftTemplete = UI.getChildControl(self._ui._btn_Radio_LeftTemplete, "Static_Item_Slot")
  self._ui._btn_Radio_LeftTemplete:SetShow(false)
  self._ui._btn_Radio_RightTemplete = UI.getChildControl(self._ui._list2_Content, "RadioButton_2")
  self._ui._stc_ItemSlot_RightTemplete = UI.getChildControl(self._ui._btn_Radio_RightTemplete, "Static_Item_Slot")
  self._ui._btn_Radio_RightTemplete:SetShow(false)
  self._ui._stc_Scroll_Vertical = UI.getChildControl(self._ui._list2_Item_List, "List2_1_VerticalScroll")
  self._ui._stc_Scroll_Horizontal = UI.getChildControl(self._ui._list2_Item_List, "List2_1_HorizontalScroll")
  self._ui._stc_player_Silver = UI.getChildControl(Panel_Dialog_NPCShop_All, "Static_Silver")
  self._ui._btn_Check_Inven = UI.getChildControl(self._ui._stc_player_Silver, "Radiobutton_Inven")
  self._ui._btn_Check_Warehouse = UI.getChildControl(self._ui._stc_player_Silver, "Radiobutton_Warehouse")
  self._ui._txt_Silver_Inven = UI.getChildControl(self._ui._btn_Check_Inven, "StaticText_Inventory")
  self._ui._txt_Silver_Storage = UI.getChildControl(self._ui._btn_Check_Warehouse, "StaticText_Storage")
  self._ui._stc_Guild_Silver = UI.getChildControl(Panel_Dialog_NPCShop_All, "Static_GuildSilver")
  self._ui._btn_Check_Inven_Guild = UI.getChildControl(self._ui._stc_Guild_Silver, "CheckButton_Inven")
  self._ui._btn_Check_Warehouse_Guild = UI.getChildControl(self._ui._stc_Guild_Silver, "CheckButton_Storage")
  self._ui._txt_Silver_Inven_Guild = UI.getChildControl(self._ui._btn_Check_Inven_Guild, "StaticText_Inventory")
  self._ui._txt_Silver_Storage_Guild = UI.getChildControl(self._ui._btn_Check_Warehouse_Guild, "StaticText_Storage")
  self._isPadSnap = _ContentsGroup_UsePadSnapping
  self._isConsole = _ContentsGroup_RenewUI
  self._ui._btn_Check_Inven_Guild:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_GUILDMONEY"))
  self._ui._btn_Check_Warehouse_Guild:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_NPCSHOP_GUILDPRICELIMITED"))
  local itemImageLeftSlot = {}
  local itemImageRightSlot = {}
  SlotItem.new(itemImageLeftSlot, "Left_Item_Icon_", 0, self._ui._stc_ItemSlot_LeftTemplete, self._slotConfig)
  SlotItem.new(itemImageRightSlot, "Right_Item_Icon_", 0, self._ui._stc_ItemSlot_RightTemplete, self._slotConfig)
  itemImageLeftSlot:createChild()
  itemImageRightSlot:createChild()
  itemImageLeftSlot.icon:SetPosY(2)
  itemImageRightSlot.icon:SetPosY(2)
  itemImageLeftSlot.icon:SetPosX(2)
  itemImageRightSlot.icon:SetPosX(2)
  self._NPCSHOP_BUYBTN_POSX = self._ui._pc._btn_Radio_Buy:GetSpanSize().x
  self._NPCSHOP_SELLBTN_POSX = self._ui._pc._btn_Radio_Sell:GetSpanSize().x
  self._OriPanalPosY = Panel_Dialog_NPCShop_All:GetPosY()
  self._ui._console._stc_Key_Purchase_All:SetShow(false)
  self._keyGuideList = {
    self._ui._console._stc_Key_Scroll,
    self._ui._console._stc_Key_Detail,
    self._ui._console._stc_Key_Purchase,
    self._ui._console._stc_Key_Cancel
  }
  self._ui._console._stc_TabGroup_Console:SetShow(self._isPadSnap)
  self._ui._console._btn_TabGroup_RT:SetShow(self._isPadSnap)
  self._ui._console._btn_TabGroup_LT:SetShow(self._isPadSnap)
  self._ui._console._stc_KeyGuide:SetShow(self._isPadSnap)
  self._ui._pc._btn_Close:SetShow(not self._isPadSnap)
  self._ui._pc._btn_Question:SetShow(not self._isPadSnap)
  self._ui._pc._btn_Buy:SetShow(not self._isPadSnap)
  self._ui._pc._btn_BuySome:SetShow(not self._isPadSnap)
  self._ui._pc._btn_SellAll:SetShow(not self._isPadSnap)
  if true == self._isPadSnap then
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuideList, self._ui._console._stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    self._ui._stc_SubBg:SetSize(self._ui._stc_SubBg:GetSizeX(), self._ui._list2_Content:GetSizeY() * 7 + 2)
    local panelConsole = self._ui._stc_TitleBg:GetSizeY() + self._ui._console._stc_TabGroup_Console:GetSizeY() + self._ui._stc_SubBg:GetSizeY() + self._ui._btn_Check_Inven:GetSizeY() + 15
    Panel_Dialog_NPCShop_All:SetSize(Panel_Dialog_NPCShop_All:GetSizeX(), panelConsole)
    Panel_Dialog_NPCShop_All:ComputePos()
    self._ui._console._stc_KeyGuide:SetPosY(Panel_Dialog_NPCShop_All:GetSizeY() + Panel_Dialog_NPCShop_All:GetSpanSize().x - 5)
    self._CHKBTN_SIZEX_CONSOLE = self._ui._list2_RdoBtn:GetSizeX() - 10
    self._ui._btn_Check_Inven:SetSize(self._CHKBTN_SIZEX_CONSOLE, self._ui._btn_Check_Inven:GetSizeY())
    self._ui._btn_Check_Inven:SetPosY(self._ui._btn_Check_Inven:GetPosY() - 6)
    self._ui._btn_Check_Warehouse:SetSize(self._CHKBTN_SIZEX_CONSOLE, self._ui._btn_Check_Warehouse:GetSizeY())
    self._ui._btn_Check_Warehouse:SetPosX(Panel_Dialog_NPCShop_All:GetSizeX() / 2)
    self._ui._btn_Check_Warehouse:SetPosY(self._ui._btn_Check_Inven:GetPosY())
    self._ui._btn_Check_Inven_Guild:SetSize(self._CHKBTN_SIZEX_CONSOLE, self._ui._btn_Check_Inven_Guild:GetSizeY())
    self._ui._btn_Check_Inven_Guild:SetPosY(self._ui._btn_Check_Inven:GetPosY())
    self._ui._btn_Check_Warehouse_Guild:SetSize(self._CHKBTN_SIZEX_CONSOLE, self._ui._btn_Check_Warehouse_Guild:GetSizeY())
    self._ui._btn_Check_Warehouse_Guild:SetPosX(Panel_Dialog_NPCShop_All:GetSizeX() / 2)
    self._ui._btn_Check_Warehouse_Guild:SetPosY(self._ui._btn_Check_Inven:GetPosY())
    self._ui._txt_Silver_Inven:ComputePos()
    self._ui._txt_Silver_Storage:ComputePos()
    self._ui._txt_Silver_Inven_Guild:ComputePos()
    self._ui._txt_Silver_Storage_Guild:ComputePos()
  end
  PaGlobal_NPCShop_ALL:validate()
  PaGlobal_NPCShop_ALL:registerEventHandler()
  self._initialize = true
end
function PaGlobal_NPCShop_ALL:registerEventHandler()
  Panel_Dialog_NPCShop_All:RegisterShowEventFunc(true, "PaGlobalFunc_NPCShop_ALL_SetANI( true )")
  Panel_Dialog_NPCShop_All:RegisterShowEventFunc(false, "PaGlobalFunc_NPCShop_ALL_SetANI( false )")
  registerEvent("EventNpcShopUpdate", "FromClient_NPCShop_ALL_Open()")
  registerEvent("FromClient_InventoryUpdate", "FromClient_NPCShop_ALL_UpdateMoneyWithContent")
  registerEvent("EventWarehouseUpdate", "FromClient_NPCShop_ALL_UpdateMoneyWithContent")
  registerEvent("UpdateGuildPriceLimit", "PaGlobalFunc_NPCShop_ALL_UpdateMoney")
  registerEvent("onScreenResize", "FromClient_NPCShop_ALL_Resize")
  registerEvent("FromClient_NPCShop_ALL_UpdateBuyableCount", "FromClient_NPCShop_ALL_UpdateMoneyWithContent")
  self._ui._list2_Item_List:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_NPCShop_ALL_UpdateContent")
  self._ui._list2_Item_List:createChildContent(__ePAUIList2ElementManagerType_List)
  self._radioButton_Tab[0] = self._ui._pc._btn_Radio_Buy
  self._radioButton_Tab[1] = self._ui._pc._btn_Radio_Sell
  self._radioButton_Tab[2] = self._ui._pc._btn_Radio_Repurchase
  if true == self._isPadSnap then
    Panel_Dialog_NPCShop_All:registerPadEvent(__eConsoleUIPadEvent_LT, "PaGlobalFunc_NPCShop_ALL_ChangeTapByPad(-1)")
    Panel_Dialog_NPCShop_All:registerPadEvent(__eConsoleUIPadEvent_RT, "PaGlobalFunc_NPCShop_ALL_ChangeTapByPad(1)")
    Panel_Dialog_NPCShop_All:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleEventLUp_NPCShop_ALL_ScrollForPad( true )")
    Panel_Dialog_NPCShop_All:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleEventLUp_NPCShop_ALL_ScrollForPad( false )")
  else
    self._ui._pc._btn_Close:addInputEvent("Mouse_LUp", "HandleEventLUp_NPCShop_ALL_Close( true )")
    self._ui._pc._btn_Question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"NpcShop\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui._pc._btn_Question, "\"NpcShop\"")
    for index = 0, 2 do
      self._radioButton_Tab[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_NPCShop_ALL_TabButtonClick(" .. index .. ")")
    end
    self._ui._pc._btn_Buy:addInputEvent("Mouse_LUp", "HandleEventLUp_NPCShop_ALL_BuyOrSellItem()")
    self._ui._pc._btn_BuySome:addInputEvent("Mouse_LUp", "HandleEventLUp_NPCShop_ALL_BuySome()")
    self._ui._pc._btn_SellAll:addInputEvent("Mouse_LUp", "HandleEventLUp_NPCShop_ALL_SellItemAll()")
    self._ui._btn_Check_Inven:addInputEvent("Mouse_LUp", "HandleEventLUp_NPCShop_ALL_CheckBoxToggle( 0 )")
    self._ui._btn_Check_Warehouse:addInputEvent("Mouse_LUp", "HandleEventLUp_NPCShop_ALL_CheckBoxToggle( 1 )")
  end
end
function PaGlobal_NPCShop_ALL:prepareOpen()
  if nil == Panel_Dialog_NPCShop_All or true == Panel_Dialog_NPCShop_All:GetShow() then
    return
  end
  local talker = dialog_getTalker()
  if true == _ContentsGroup_NewUI_Camp_All then
    self._value._isCamping = PaGlobalFunc_Camp_All_GetIsCamping()
  else
    self._value._isCamping = PaGlobal_Camp:getIsCamping()
  end
  if nil == talker and (false == self._value._isCamping or nil == self._value._isCamping) then
    return
  end
  if false == self._value._isCamping then
    if false == npcShop_isShopContents() and false == npcShop_isGuildShopContents() then
      return
    end
    if Defines.UIMode.eUIMode_NpcDialog ~= GetUIMode() then
      return
    end
  end
  if false == self._value._isCamping or nil == self._value._isCamping then
    local actorProxyWrapper = getNpcActor(talker:getActorKey())
    if nil ~= actorProxyWrapper then
      local actorProxy = actorProxyWrapper:get()
      local characterStaticStatus = actorProxy:getCharacterStaticStatus()
      if true == characterStaticStatus:isTradeMerchant() then
        return
      end
    end
  end
  if true == _ContentsGroup_NewUI_TradeMarket_All then
    if nil ~= Panel_Dialog_Trade_Function_All then
      if true == PaGlobalFunc_TradeFunction_All_GetIsTrading() and nil ~= Panel_Dialog_Trade_Function_All then
        return
      end
    elseif true == global_IsTrading and nil ~= Panel_Window_TradeMarket then
      return
    end
  elseif true == global_IsTrading and nil ~= Panel_Window_TradeMarket then
    return
  end
  if nil ~= Panel_Npc_Intimacy_All and true == Panel_Npc_Intimacy_All:GetShow() then
    PaGlobalFunc_DialogIntimacy_All_Close()
  end
  self._value._currentTabIndex = self._ENUMTABINDEXBUY
  self._value._selectedSlotIndex = nil
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  PaGlobal_NPCShop_ALL:open(true)
  PaGlobal_NPCShop_ALL:update()
  PaGlobal_NPCShop_ALL:resize()
  PaGlobal_NPCShop_ALL:controlInit()
  PaGlobal_NPCShop_ALL:inventoryShow()
  Inventory_SetFunctor(PaGlobalFunc_NPCShop_ALL_IsExchangeItem, HandleEventRUp_NPCShop_ALL_InvenItemRClick, HandleEventLUp_NPCShop_ALL_Close, nil)
end
function PaGlobal_NPCShop_ALL:update()
  if nil == Panel_Dialog_NPCShop_All or false == Panel_Dialog_NPCShop_All:GetShow() then
    return
  end
  PaGlobal_NPCShop_ALL:pushKeyToList2(PaGlobal_NPCShop_ALL._value._currentTabIndex)
  PaGlobal_NPCShop_ALL:updateMoney()
  PaGlobal_NPCShop_ALL:checkInit()
end
function PaGlobal_NPCShop_ALL:pushKeyToList2()
  if nil == Panel_Dialog_NPCShop_All then
    return
  end
  if nil == self._value._currentTabIndex or self._value._currentTabIndex < self._ENUMTABINDEXBUY or self._value._currentTabIndex > self._ENUMTABINDEXREBUY then
    UI.ASSERT(false, " Panel_Dialog_NPCShop_All_1.lua / PaGlobal_NPCShop_ALL:pushKeyToList2()... self._value._currentTabIndex is wrong ")
    return
  end
  local currentItemSize = 0
  local isItemSizeChanged = false
  if self._ENUMTABINDEXBUY == self._value._currentTabIndex then
    currentItemSize = npcShop_getBuyCount()
  elseif self._ENUMTABINDEXSELL == self._value._currentTabIndex then
    currentItemSize = npcShop_getSellCount()
  else
    currentItemSize = npcShop_getRepurchaseCount()
  end
  if currentItemSize ~= self._value._itemListSize then
    self._value._itemListSize = currentItemSize
    isItemSizeChanged = true
  end
  if self._value._lastTabIndex ~= self._value._currentTabIndex or true == isItemSizeChanged then
    PaGlobal_NPCShop_ALL._ui._list2_Item_List:getElementManager():clearKey()
    for ii = 0, currentItemSize do
      if 1 == ii % self._config._slotCols then
        PaGlobal_NPCShop_ALL._ui._list2_Item_List:getElementManager():pushKey(toInt64(0, ii))
      end
    end
  elseif self._value._lastTabIndex == self._value._currentTabIndex then
    if true == self._isPadSnap then
      if currentItemSize <= 0 then
        PaGlobal_NPCShop_ALL._ui._list2_Item_List:getElementManager():clearKey()
        for ii = 0, currentItemSize do
          if 1 == ii % self._config._slotCols then
            PaGlobal_NPCShop_ALL._ui._list2_Item_List:getElementManager():pushKey(toInt64(0, ii))
          end
        end
      else
        PaGlobal_NPCShop_ALL._ui._list2_Item_List:requestUpdateVisible()
      end
    else
      PaGlobal_NPCShop_ALL._ui._list2_Item_List:requestUpdateVisible()
    end
  end
  if self._currentScrollData._index ~= self._ui._list2_Item_List:getCurrenttoIndex() and 0 < self._currentScrollData._index then
    self._ui._list2_Item_List:setCurrenttoIndex(self._currentScrollData._index)
    self._ui._list2_Item_List:GetVScroll():SetControlPos(self._currentScrollData._scroll)
    self._currentScrollData._index = 0
    self._currentScrollData._scroll = 0
  end
  self._ui._pc._btn_Buy:SetText(self._tabString[self._value._currentTabIndex])
end
function PaGlobal_NPCShop_ALL:updateContentData(content, key)
  if nil == getSelfPlayer() then
    return
  end
  local key32 = Int64toInt32(key)
  local itemPrice_s64
  local inventory = getSelfPlayer():get():getInventory()
  for ii = 0, self._config._slotCols - 1 do
    local dataIndex = key32 + (ii - 1)
    local shopItemWrapper, s64_inventoryItemCount
    PaGlobal_NPCShop_ALL:createItem(content, dataIndex, ii + 1)
    if dataIndex < self._value._itemListSize then
      if self._ENUMTABINDEXBUY == self._value._currentTabIndex then
        shopItemWrapper = npcShop_getItemBuy(dataIndex)
      elseif self._ENUMTABINDEXSELL == self._value._currentTabIndex then
        shopItemWrapper = npcShop_getItemSell(dataIndex)
        s64_inventoryItemCount = inventory:getItemCount_s64(shopItemWrapper:getStaticStatus():get()._key)
      else
        shopItemWrapper = npcShop_getItemRepurchase(dataIndex)
      end
      if nil ~= shopItemWrapper then
        local shopItem = shopItemWrapper:get()
        if self._ENUMTABINDEXBUY == self._value._currentTabIndex then
          itemPrice_s64 = shopItem:getItemPriceWithOption()
          local isLimitedBuyableCount = shopItemWrapper:isLimitedBuyableCount()
          local remainingCount = shopItemWrapper:getRemainingCount()
          local resetType = shopItemWrapper:getResetType()
          local isLimitedByUser = shopItemWrapper:isLimitedByUser()
          local buyableMaxCount = shopItemWrapper:getBuyableMaxCount()
          _PA_LOG("\234\181\172\236\136\152\237\152\132", "buyableMaxCount : " .. tostring(buyableMaxCount))
          PaGlobal_NPCShop_ALL:setItem(dataIndex, shopItemWrapper:getStaticStatus(), shopItem.leftCount_s64, itemPrice_s64, s64_inventoryItemCount, shopItem:getItemUsablePeriod(), shopItem:getNeedIntimacy(), nil, isLimitedBuyableCount, remainingCount, resetType, isLimitedByUser, buyableMaxCount)
        elseif self._ENUMTABINDEXSELL == self._value._currentTabIndex then
          itemPrice_s64 = shopItem:getItemSellPriceWithOption()
          PaGlobal_NPCShop_ALL:setItem(dataIndex, shopItemWrapper:getStaticStatus(), shopItem.leftCount_s64, itemPrice_s64, s64_inventoryItemCount, shopItem:getItemUsablePeriod())
        else
          itemPrice_s64 = shopItem.price_s64
          PaGlobal_NPCShop_ALL:setItem(dataIndex, shopItemWrapper:getStaticStatus(), shopItem.leftCount_s64, itemPrice_s64, s64_inventoryItemCount, shopItem:getItemUsablePeriod(), shopItem:getNeedIntimacy())
        end
      end
    else
      local btn = UI.getChildControl(content, "RadioButton_" .. ii + 1)
      btn:SetShow(false)
    end
  end
  self._value._lastTabIndex = self._value._currentTabIndex
end
function PaGlobal_NPCShop_ALL:controlInit()
  if nil == Panel_Dialog_NPCShop_All then
    return
  end
  for ii = 0, 2 do
    if ii == self._value._currentTabIndex then
      self._radioButton_Tab[ii]:SetCheck(true)
      local selectBarSapnX = self._radioButton_Tab[ii]:GetSpanSize().x
      local selectBarSapnY = self._ui._stc_SelectBar:GetSpanSize().y
      self._ui._stc_SelectBar:SetSpanSize(selectBarSapnX, selectBarSapnY)
    else
      self._radioButton_Tab[ii]:SetCheck(false)
    end
  end
  PaGlobal_NPCShop_ALL:multiPurposeBtn_ShowToggle()
  local isSellAble = false
  local buyBtnSpanPosY = self._radioButton_Tab[self._ENUMTABINDEXREBUY]:GetSpanSize().y
  local talker = dialog_getTalker()
  if nil ~= talker then
    local actorProxyWrapper = getNpcActor(talker:getActorKey())
    if nil ~= actorProxyWrapper then
      local characterSSW = actorProxyWrapper:getCharacterStaticStatusWrapper()
      isSellAble = characterSSW:isSellingNormalShop()
      self._radioButton_Tab[self._ENUMTABINDEXSELL]:SetShow(isSellAble)
      self._radioButton_Tab[self._ENUMTABINDEXREBUY]:SetShow(isSellAble)
      if characterSSW:isSellingNormalShop() then
        self._radioButton_Tab[self._ENUMTABINDEXBUY]:SetSpanSize(self._NPCSHOP_BUYBTN_POSX, buyBtnSpanPosY)
      else
        self._radioButton_Tab[self._ENUMTABINDEXBUY]:SetSpanSize(self._NPCSHOP_SELLBTN_POSX, buyBtnSpanPosY)
      end
    end
  elseif self._value._isCamping then
    self._radioButton_Tab[self._ENUMTABINDEXSELL]:SetShow(not self._value._isCamping)
    self._radioButton_Tab[self._ENUMTABINDEXREBUY]:SetShow(not self._value._isCamping)
    self._radioButton_Tab[self._ENUMTABINDEXBUY]:SetSpanSize(self._NPCSHOP_SELLBTN_POSX, buyBtnSpanPosY)
  end
  if true == self._isPadSnap then
    self._ui._console._stc_Key_Purchase:SetText(self._tabString[self._value._currentTabIndex])
    self._ui._console._btn_TabGroup_RT:SetShow(isSellAble)
    self._ui._console._btn_TabGroup_LT:SetShow(isSellAble)
  end
  local selectBarSapnX = self._radioButton_Tab[self._value._currentTabIndex]:GetSpanSize().x
  local selectBarSapnY = self._ui._stc_SelectBar:GetSpanSize().y
  self._ui._stc_SelectBar:SetSpanSize(selectBarSapnX, selectBarSapnY)
end
function PaGlobal_NPCShop_ALL:open(showAni)
  if nil == Panel_Dialog_NPCShop_All or true == Panel_Dialog_NPCShop_All:GetShow() then
    return
  end
  PaGlobal_NPCShop_ALL:audioPostEvent(1, 0, false)
  if nil == showAni then
    Panel_Dialog_NPCShop_All:SetShow(true, false)
    return
  else
    Panel_Dialog_NPCShop_All:SetShow(true, showAni)
  end
end
function PaGlobal_NPCShop_ALL:resize()
  if nil == Panel_Dialog_NPCShop_All or false == Panel_Dialog_NPCShop_All:GetShow() then
    return
  end
  local isInvenOpen = false
  local invenSizeX = 0
  local invenPosX = 0
  if true == _ContentsGroup_NewUI_Inventory_All then
    isInvenOpen = Panel_Window_Inventory_All:GetShow()
    invenSizeX = Panel_Window_Inventory_All:GetSizeX()
    invenPosX = Panel_Window_Inventory_All:GetPosX()
  else
    isInvenOpen = Panel_Window_Inventory:GetShow()
    invenSizeX = Panel_Window_Inventory:GetSizeX()
    invenPosX = Panel_Window_Inventory:GetPosX()
  end
  if true == isInvenOpen then
    local screenSizeX = getScreenSizeX()
    local screenSizeY = getScreenSizeY()
    local startPosX = screenSizeX - invenSizeX - 60 - Panel_Dialog_NPCShop_All:GetSizeX()
    if screenSizeY <= 800 then
      Panel_Dialog_NPCShop_All:SetPosY(screenSizeY / 2 - Panel_Dialog_NPCShop_All:GetSizeY() / 2 - 30)
    else
      Panel_Dialog_NPCShop_All:SetPosY(screenSizeY / 2 - Panel_Dialog_NPCShop_All:GetSizeY() / 2 - 100)
    end
    Panel_Dialog_NPCShop_All:ComputePos()
    self._pos._toolTipPosX = Panel_Dialog_NPCShop_All:GetPosX() + Panel_Dialog_NPCShop_All:GetSizeX() + Panel_Dialog_NPCShop_All:GetSpanSize().x
    self._pos._toolTipPosY = Panel_Dialog_NPCShop_All:GetPosY() + self._ui._list2_Item_List:GetPosY()
  end
  if true == self._isPadSnap then
    Panel_Dialog_NPCShop_All:SetPosX(invenPosX - Panel_Dialog_NPCShop_All:GetSizeX() - 50)
    Panel_Dialog_NPCShop_All:SetPosY(self._OriPanalPosY - (self._ui._console._stc_KeyGuide:GetSizeY() + 10) - 30)
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuideList, self._ui._console._stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_NPCShop_ALL:setAni(switch)
  if nil == Panel_Dialog_NPCShop_All then
    return
  end
  if true == switch then
    PaGlobal_NPCShop_ALL:audioPostEvent(1, 1, true)
    Panel_Dialog_NPCShop_All:SetAlpha(0)
    Panel_Dialog_NPCShop_All:ResetVertexAni()
    local alphaAni = Panel_Dialog_NPCShop_All:addColorAnimation(0, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
    alphaAni:SetStartColorBySafe(PAUIColorType(Panel_Dialog_NPCShop_All:GetAlpha() * 255, 255, 255, 255))
    alphaAni:SetEndColorBySafe(PAUIColorType(255, 255, 255, 255))
  else
    local ani1 = UIAni.AlphaAnimation(0, Panel_Dialog_NPCShop_All, 0, 0.15)
    ani1:SetHideAtEnd(true)
  end
end
function PaGlobal_NPCShop_ALL:prepareClose(showAni)
  if nil == Panel_Dialog_NPCShop_All or false == Panel_Dialog_NPCShop_All:GetShow() then
    return
  end
  self._currentScrollData._index = 0
  self._currentScrollData._scroll = 0
  self._ui._list2_Item_List:getElementManager():clearKey()
  self._value._lastTabIndex = nil
  self._value._currentTabIndex = nil
  self._createdItemSlot = {}
  self._value._itemListSize = 0
  Panel_Tooltip_Item_hideTooltip()
  Inventory_SetFunctor(nil, nil, nil, nil)
  InventoryWindow_Close()
  if true == showAni and false == self._value._isCamping then
    ReqeustDialog_retryTalk()
  end
  if true == _ContentsGroup_NewUI_Camp_All then
    if PaGlobalFunc_Camp_All_GetIsCamping() then
      InventoryWindow_Close()
      PaGlobal_Camp_All:open()
    end
  elseif PaGlobal_Camp:getIsCamping() then
    InventoryWindow_Close()
    PaGlobal_Camp:open()
  end
  if nil ~= Panel_Npc_Intimacy_All then
    PaGlobalFunc_DialogIntimacy_All_Open()
  end
  if nil ~= Panel_Npc_Dialog_All then
    PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  end
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  PaGlobal_NPCShop_ALL:close(showAni)
  if true == _ContentsGroup_NewUI_Camp_All then
    if nil ~= Panel_Window_Camp_All then
      if self._value._isCamping then
        ToClient_openCampingInfo()
      end
      PaGlobalFunc_Camp_All_SetIsCamping(false)
    end
  elseif nil ~= Panel_Window_Camp then
    PaGlobal_Camp:setIsCamping(false)
  end
  PaGlobalFunc_NPCShop_ALL_SetIsCamping(false)
  ToClient_SetShowDialogFlag(false)
end
function PaGlobal_NPCShop_ALL:close(showAni)
  if nil == Panel_Dialog_NPCShop_All or false == Panel_Dialog_NPCShop_All:GetShow() then
    return
  end
  PaGlobal_NPCShop_ALL:audioPostEvent(1, 1, _ContentsGroup_RenewUI)
  if nil == showAni then
    Panel_Dialog_NPCShop_All:SetShow(false, false)
    return
  else
    Panel_Dialog_NPCShop_All:SetShow(false, showAni)
  end
end
function PaGlobal_NPCShop_ALL:tabButtonClick(idx)
  if nil == Panel_Dialog_NPCShop_All or false == Panel_Dialog_NPCShop_All:GetShow() then
    return
  end
  self._currentScrollData._index = 0
  self._currentScrollData._scroll = 0
  Panel_Tooltip_Item_hideTooltip()
  for ii = 0, 2 do
    if ii == idx then
      self._radioButton_Tab[ii]:SetCheck(true)
      local selectBarSapnX = self._radioButton_Tab[ii]:GetSpanSize().x
      local selectBarSapnY = self._ui._stc_SelectBar:GetSpanSize().y
      self._ui._stc_SelectBar:SetSpanSize(selectBarSapnX, selectBarSapnY)
    else
      self._radioButton_Tab[ii]:SetCheck(false)
    end
  end
  if true == self._isPadSnap then
    self._ui._console._stc_Key_Purchase:SetText(self._tabString[idx])
  end
  if idx ~= self._value._currentTabIndex then
    self._value._selectedSlotIndex = nil
    self._value._lastTabIndex = self._value._currentTabIndex
    self._value._currentTabIndex = idx
    if self._ENUMTABINDEXREBUY == idx then
      ToClient_NpcShop_UpdateRepurchaseList()
    elseif false == self._ui._stc_Scroll_Vertical:GetShow() then
      self._ui._stc_Scroll_Vertical:SetEnable(true)
      self._ui._stc_Scroll_Vertical:SetMonoTone(false, false)
      self._ui._stc_Scroll_Vertical:SetShow(true)
    end
    PaGlobal_NPCShop_ALL:pushKeyToList2()
  end
  PaGlobal_NPCShop_ALL:multiPurposeBtn_ShowToggle()
  PaGlobal_NPCShop_ALL:checkInit()
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuideList, self._ui._console._stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_NPCShop_ALL:updateMoney()
  if true == _ContentsGroup_InvenUpdateCheck and false == Panel_Window_NpcShop:GetShow() then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isGuildFlag = npcShop_isGuildShopContents()
  local hasWareHouseFlag = ToClient_HasWareHouseFromNpc()
  self._ui._stc_player_Silver:SetShow(not isGuildFlag)
  self._ui._stc_Guild_Silver:SetShow(isGuildFlag)
  if true == isGuildFlag then
    local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
    if nil ~= myGuildListInfo then
      self._ui._btn_Check_Inven_Guild:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_NPCSHOP_GUILDPRICELIMITED"))
      self._ui._btn_Check_Warehouse_Guild:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_GUILDMONEY"))
      if false == getSelfPlayer():get():isGuildMaster() and true == getSelfPlayer():get():getGuildIsPriceLimit() then
        self._ui._txt_Silver_Inven_Guild:SetText(makeDotMoney(getSelfPlayer():get():getGuildPriceLimit()))
      else
        self._ui._txt_Silver_Inven_Guild:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_USEGUILDFUNDS_UNLIMITED"))
      end
      self._ui._txt_Silver_Storage_Guild:SetText(makeDotMoney(myGuildListInfo:getGuildBusinessFunds_s64()))
    end
  else
    self._ui._txt_Silver_Inven:SetText(makeDotMoney(getSelfPlayer():get():getInventory():getMoney_s64()))
    self._ui._txt_Silver_Storage:SetText(makeDotMoney(warehouse_moneyFromNpcShop_s64()))
    self._ui._btn_Check_Warehouse:SetShow(hasWareHouseFlag)
    self._ui._txt_Silver_Storage:SetShow(hasWareHouseFlag)
  end
end
function PaGlobal_NPCShop_ALL:updateMoneyWithContent()
  if nil == Panel_Dialog_NPCShop_All or false == Panel_Dialog_NPCShop_All:GetShow() then
    return
  end
  PaGlobal_NPCShop_ALL:updateMoney()
  PaGlobal_NPCShop_ALL:pushKeyToList2()
end
function PaGlobal_NPCShop_ALL:buySome()
  if nil == self._value._selectedSlotIndex or nil == getSelfPlayer() then
    return
  end
  local shopItemWrapper = npcShop_getItemBuy(self._value._selectedSlotIndex)
  local shopItem = shopItemWrapper:get()
  local itemEnchantStaticStatus = shopItemWrapper:getStaticStatus():get()
  local money_s64 = getSelfPlayer():get():getInventory():getMoney_s64()
  local s32_allWeight = Int64toInt32(getSelfPlayer():get():getCurrentWeight_s64())
  local s32_maxWeight = Int64toInt32(getSelfPlayer():get():getPossessableWeight_s64())
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if self._ui._btn_Check_Warehouse:IsCheck() then
    money_s64 = warehouse_moneyFromNpcShop_s64()
  end
  if true == npcShop_isGuildShopContents() then
    if not PaGlobal_NPCShop_ALL:guildCheckByBuy() then
      return
    end
    money_s64 = myGuildListInfo:getGuildBusinessFunds_s64()
    if money_s64 < shopItem:getItemPriceWithOption() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_NPCSHOP_GUILDPRICELIMITED_NOMONEY"))
      return
    end
  end
  if true == _ContentsGroup_Barter and true == itemEnchantStaticStatus:isTradePrice() then
    local priceItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eMoneyInventory, __eInventoryMoneyType_Shell)
    money_s64 = toInt64(0, 0)
    if nil ~= priceItemWrapper then
      money_s64 = priceItemWrapper:get():getCount_s64()
    end
  end
  if money_s64 < shopItem:getItemPriceWithOption() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "Lua_TradeMarket_Not_Enough_Money"))
    return
  end
  local s64_maxMoneyNumber = money_s64 / shopItem:getItemPriceWithOption()
  local s64_maxWeightNumber = Defines.s64_const.s64_0
  local itemWeight = itemEnchantStaticStatus._weight
  if true == npcShop_isGuildShopContents() and s64_maxMoneyNumber > toInt64(0, 1000) then
    s64_maxMoneyNumber = toInt64(0, 1000)
  end
  if s32_allWeight < s32_maxWeight then
    s64_maxWeightNumber = toInt64(0, math.floor((s32_maxWeight - s32_allWeight) / itemWeight))
  end
  if Int64toInt32(s64_maxMoneyNumber) < Int64toInt32(s64_maxWeightNumber) or Int64toInt32(s64_maxWeightNumber) < 0 then
    s64_maxWeightNumber = s64_maxMoneyNumber
  end
  if 0 < shopItem:getNeedIntimacy() then
    local talker = dialog_getTalker()
    local intimacyValue = talker:getIntimacy()
    local reduceIntimacyValue = math.abs(shopItem:getItemIntimacy())
    local maxNumber = toInt64(0, math.floor(intimacyValue / reduceIntimacyValue))
    if 0 == reduceIntimacyValue then
      s64_maxMoneyNumber = toInt64(0, 0)
    elseif maxNumber < s64_maxMoneyNumber then
      s64_maxMoneyNumber = maxNumber
    end
    if s64_maxWeightNumber > maxNumber then
      s64_maxWeightNumber = maxNumber
    end
  end
  if nil ~= shopItemWrapper and true == shopItemWrapper:isLimitedBuyableCount() then
    local remainingCount = shopItemWrapper:getRemainingCount()
    s64_maxMoneyNumber = toInt64(0, remainingCount)
    s64_maxWeightNumber = nil
  end
  if true == self._isPadSnap then
    if true == shopItemWrapper:getStaticStatus():get():isStackableXXX() then
      Panel_NumberPad_Show(true, s64_maxMoneyNumber, nil, HandleEventLUp_NPCShop_ALL_BuyOrSellItem, nil, nil, nil, nil, s64_maxWeightNumber)
      Panel_NumberPad_SetType("NpcShop_BuySome")
    else
      PaGlobal_NPCShop_ALL:buyOrSellItem()
    end
  else
    Panel_NumberPad_Show(true, s64_maxMoneyNumber, param, HandleEventLUp_NPCShop_ALL_BuyOrSellItem, nil, nil, nil, nil, s64_maxWeightNumber)
    Panel_NumberPad_SetType("NpcShop_BuySome")
  end
end
function PaGlobal_NPCShop_ALL:sellItemAll()
  if nil == self._value._selectedSlotIndex or nil == getSelfPlayer() then
    return
  end
  local selectedIndex = self._value._selectedSlotIndex
  local shopItemWrapper = npcShop_getItemSell(selectedIndex)
  if nil == shopItemWrapper then
    return
  end
  local shopItem = shopItemWrapper:get()
  local inventory = getSelfPlayer():get():getInventory()
  local shopItemSSW = npcShop_getItemWrapperByShopSlotNo(selectedIndex)
  local s64_inventoryItemCount = inventory:getItemCount_s64(shopItemWrapper:getStaticStatus():get()._key)
  local itemCount = Int64toInt32(s64_inventoryItemCount)
  local pricePiece = Int64toInt32(shopItemSSW:getSellPriceCalculate(shopItem:getItemPriceOption()))
  local totalPrice = pricePiece * itemCount
  local toWhereType = CppEnums.ItemWhereType.eInventory
  local itemSSW = npcShop_getItemWrapperByShopSlotNo(selectedIndex)
  local shopItemEndurance = itemSSW:get():getEndurance()
  local isSocketed = false
  local itemKeyForTradeInfo = shopItemWrapper:getStaticStatus():get()._key:get()
  local tradeMasterInfo = getItemMarketMasterByItemEnchantKey(itemKeyForTradeInfo)
  if npcShop_isGuildShopContents() then
    toWhereType = CppEnums.ItemWhereType.eGuildWarehouse
  elseif self._ui._btn_Check_Warehouse:IsCheck() then
    toWhereType = CppEnums.ItemWhereType.eWarehouse
  end
  local function SellMessageShow()
    if true == self._isPadSnap then
      Panel_NumberPad_Show(true, s64_inventoryItemCount, selectedIndex, PaGlobalFunc_NPCShop_ALL_ConfirmSellAll)
    else
      PaGlobalFunc_NPCShop_ALL_ConfirmSellAll(itemCount, selectedIndex)
    end
  end
  local function sellAllDoit()
    local socketMaxCount = ToClient_GetMaxItemSocketCount()
    for jewelIndex = 0, socketMaxCount - 1 do
      local itemEnchantSSW = itemSSW:getPushedItem(jewelIndex)
      if nil ~= itemEnchantSSW then
        isSocketed = true
      end
    end
    if true == isSocketed then
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_SELL_ALERT_1")
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_SELL_ALERT_2"),
        content = messageBoxMemo,
        functionYes = SellMessageShow,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    else
      SellMessageShow()
    end
  end
  local function checkItemMarket()
    if true == isGameTypeKR2() then
      sellAllDoit()
    elseif false ~= itemSSW:isDisplayWorldMarket() and 0 ~= shopItemEndurance then
      if true == _ContentsGroup_RenewUI_ItemMarketPlace_Only then
        local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_ITEMMARKET_USE_MSGMEMO")
        local messageBoxData = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_SELL_ALERT_2"),
          content = messageBoxMemo,
          functionYes = sellAllDoit,
          functionNo = MessageBox_Empty_function,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageBoxData)
      else
        sellAllDoit()
      end
    else
      sellAllDoit()
    end
  end
  local itemWrapper = npcShop_getItemWrapperByShopSlotNo(selectedIndex)
  if nil ~= itemWrapper then
    local checkMaxEndurance = itemWrapper:get():getMaxEndurance()
    local originalPrice = sellPrice
    if nil ~= itemWrapper:getStaticStatus() and nil ~= itemWrapper:getStaticStatus():get() then
      checkMaxEndurance = itemWrapper:getStaticStatus():get():getMaxEndurance()
      originalPrice = Int64toInt32(itemWrapper:getStaticStatus():get()._originalPrice_s64)
    end
    if 1000 < originalPrice and (false == itemWrapper:isMaxEndurance() or itemWrapper:get():getMaxEndurance() ~= checkMaxEndurance) then
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_MAX_ENDURANCE_MESSAGE")
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_SELL_ALERT_2"),
        content = messageBoxMemo,
        functionYes = checkItemMarket,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    else
      checkItemMarket()
    end
  else
    checkItemMarket()
  end
end
function PaGlobal_NPCShop_ALL:inventoryShow()
  if nil == Panel_Dialog_NPCShop_All then
    return
  end
  if false == self._isConsole and true == _ContentsGroup_RenewUI_ItemMarketPlace_Only and true == Panel_Window_MarketPlace_WalletInventory:GetShow() then
    PaGlobalFunc_MarketWallet_ForceClose()
  end
  InventoryWindow_Show()
  PaGlobal_NPCShop_ALL:audioPostEvent(1, 0, false)
end
function PaGlobal_NPCShop_ALL:checkInit()
  if true == npcShop_isGuildShopContents() then
    return
  end
  if self._ui._btn_Check_Inven:IsCheck() then
    return
  end
  if ToClient_HasWareHouseFromNpc() then
    self._ui._txt_Silver_Storage:SetShow(true)
    self._ui._btn_Check_Warehouse:SetShow(true)
    if toInt64(0, 0) == warehouse_moneyFromNpcShop_s64() then
      self._ui._btn_Check_Inven:SetCheck(true)
      self._ui._btn_Check_Warehouse:SetCheck(false)
    else
      self._ui._btn_Check_Inven:SetCheck(false)
      self._ui._btn_Check_Warehouse:SetCheck(true)
    end
  else
    self._ui._txt_Silver_Storage:SetShow(false)
    self._ui._btn_Check_Warehouse:SetShow(false)
    self._ui._btn_Check_Inven:SetCheck(true)
    self._ui._btn_Check_Warehouse:SetCheck(false)
  end
end
function PaGlobal_NPCShop_ALL:setIsCamping(isCamping)
  if nil == Panel_Dialog_NPCShop_All then
    return
  end
  self._value._isCamping = isCamping
end
function PaGlobal_NPCShop_ALL:buyOrSellItem(inputNumber)
  if nil == self._value._selectedSlotIndex or nil == getSelfPlayer() then
    return
  end
  local fromWhereType = CppEnums.ItemWhereType.eInventory
  local toWhereType = CppEnums.ItemWhereType.eInventory
  local isCamping = self._value._isCamping
  local selectedIndex = self._value._selectedSlotIndex
  local selectedSlot = self._createdItemSlot[selectedIndex]
  if self._ui._btn_Check_Warehouse:IsCheck() then
    fromWhereType = CppEnums.ItemWhereType.eWarehouse
    toWhereType = CppEnums.ItemWhereType.eWarehouse
  end
  if self._ENUMTABINDEXBUY == self._value._currentTabIndex then
    self._value._inputNumber = inputNumber
    local buyCount = inputNumber
    local shopItemWrapper = npcShop_getItemBuy(selectedIndex)
    local shopItemPrice = shopItemWrapper:get():getItemPriceWithOption()
    local myInvenMoney = getSelfPlayer():get():getInventory():getMoney_s64()
    local myWarehouseMoney = warehouse_moneyFromNpcShop_s64()
    local hasIntimacy = shopItemWrapper:getStaticStatus():hasMenatlCardKey()
    local shopItem = shopItemWrapper:get()
    local selectItemName = shopItemWrapper:getStaticStatus():getName()
    local totalPrice = shopItemPrice * inputNumber
    if true == _ContentsGroup_Barter and true == shopItemWrapper:getStaticStatus():isTradePrice() then
      fromWhereType = CppEnums.ItemWhereType.eMoneyInventory
      local priceItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eMoneyInventory, __eInventoryMoneyType_Shell)
      myInvenMoney = toInt64(0, 0)
      if nil ~= priceItemWrapper then
        myInvenMoney = priceItemWrapper:get():getCount_s64()
      end
    end
    if true == hasIntimacy then
      return
    end
    if nil == buyCount then
      buyCount = toInt64(0, 1)
    end
    if npcShop_isGuildShopContents() then
      fromWhereType = CppEnums.ItemWhereType.eGuildWarehouse
      if not PaGlobal_NPCShop_ALL:guildCheckByBuy() then
        return
      end
      local selfPlayer = getSelfPlayer()
      if nil ~= selfPlayer and false == selfPlayer:get():isGuildMaster() then
        local isPriceLimit = selfPlayer:get():getGuildIsPriceLimit()
        local myGuildPriceLimit = selfPlayer:get():getGuildPriceLimit()
        if Panel_NumberPad_IsPopUp() and Panel_NumberPad_IsType("NpcShop_BuySome") then
          if true == isPriceLimit and totalPrice > myGuildPriceLimit then
            Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_NPCSHOP_GUILDPRICELIMITED_NOMONEY"))
            return
          end
        elseif true == isPriceLimit and shopItemPrice > myGuildPriceLimit then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_NPCSHOP_GUILDPRICELIMITED_NOMONEY"))
          return
        end
      end
    end
    if Panel_NumberPad_IsPopUp() and Panel_NumberPad_IsType("NpcShop_BuySome") then
      local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_BUY_ALERT_TITLE")
      local contentString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_NPCSHOP_BUY_ALERT_1", "item", tostring(selectItemName), "number", tostring(buyCount), "price", makeDotMoney(totalPrice))
      if true == _ContentsGroup_Barter and true == shopItemWrapper:getStaticStatus():isTradePrice() then
        contentString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_NPCSHOP_BUY_ALERT_SEACOIN", "item", selectItemName, "number", tostring(buyCount), "price", makeDotMoney(totalPrice))
      end
      local messageboxData = {
        title = titleString,
        content = contentString,
        functionYes = PaGlobalFunc_NPCShop_ALL_ConfirmBuySome,
        functionCancel = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      if toInt64(0, 499) < toInt64(0, buyCount) or toInt64(0, 99999) < toInt64(0, totalPrice) then
        MessageBox.showMessageBox(messageboxData)
      else
        npcShop_doBuy(selectedIndex, buyCount, fromWhereType, 0, isCamping)
        Panel_NumberPad_Close()
      end
    else
      local rv = 0
      rv = npcShop_doBuy(selectedIndex, 1, fromWhereType, 0, isCamping)
      local shopItemKey = shopItemWrapper:getStaticStatus():get()._key:getItemKey()
      if 30000 <= shopItemKey and shopItemKey < 40000 and 0 == rv then
        if self._ui._btn_Check_Warehouse:IsCheck() and shopItemPrice < myInvenMoney then
          selectedSlot.btn:SetIgnore(true)
          selectedSlot.icon.icon:SetMonoTone(true, true)
          selectedSlot.price:SetMonoTone(true, true)
          selectedSlot.desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_ALREADYHASINTIMACY"))
        elseif true == self._ui._btn_Check_Warehouse:IsCheck() and shopItemPrice < myWarehouseMoney then
          selectedSlot.btn:SetIgnore(true)
          selectedSlot.icon.icon:SetMonoTone(true, true)
          selectedSlot.price:SetMonoTone(true, true)
          selectedSlot.desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_ALREADYHASINTIMACY"))
        end
      end
    end
  elseif self._ENUMTABINDEXSELL == self._value._currentTabIndex then
    do
      local shopItemWrapper = npcShop_getItemSell(selectedIndex)
      if nil == shopItemWrapper:get() then
        self._value._selectedSlotIndex = nil
        return
      end
      local shopItem = shopItemWrapper:get()
      local shopItemSSW = npcShop_getItemWrapperByShopSlotNo(selectedIndex)
      local shopItemEndurance = shopItemSSW:get():getEndurance()
      local pricePiece = Int64toInt32(shopItemSSW:getSellPriceCalculate(shopItem:getItemPriceOption()))
      local itemKeyForTradeInfo = shopItemWrapper:getStaticStatus():get()._key:get()
      local tradeMasterInfo = getItemMarketMasterByItemEnchantKey(itemKeyForTradeInfo)
      local inventory = getSelfPlayer():get():getInventory()
      local s64_inventoryItemCount = inventory:getItemCount_s64(shopItemWrapper:getStaticStatus():get()._key)
      local itemCount32 = Int64toInt32(s64_inventoryItemCount)
      local s64_remainingTime = getLeftSecond_s64(shopItemSSW:getExpirationDate())
      if true == _ContentsGroup_Barter and true == shopItemWrapper:getStaticStatus():isTradePrice() then
        toWhereType = CppEnums.ItemWhereType.eMoneyInventory
      end
      if npcShop_isGuildShopContents() then
        if not PaGlobal_NPCShop_ALL:guildCheckByBuy() then
          return
        end
        toWhereType = CppEnums.ItemWhereType.eGuildWarehouse
      end
      local function sellConfirm()
        npcShop_doSellByItemNo(selectedIndex, 1, toWhereType, isCamping)
        if nil == self._value._sellingItemKey then
          self._value._sellingItemKey = itemKeyForTradeInfo
        end
        if itemCount32 <= 1 or self._value._sellingItemKey ~= itemKeyForTradeInfo then
          self._value._selectedSlotIndex = nil
          self._value._sellingItemKey = nil
        end
        if true == Panel_NumberPad_IsPopUp() then
          Panel_NumberPad_Close()
        end
      end
      local function sellDoit()
        local itemSSW = npcShop_getItemWrapperByShopSlotNo(selectedIndex)
        if nil == itemSSW then
          return
        end
        local isSocketed = false
        local socketMaxCount = ToClient_GetMaxItemSocketCount()
        for jewelIndex = 0, socketMaxCount - 1 do
          local itemEnchantSSW = itemSSW:getPushedItem(jewelIndex)
          if nil ~= itemEnchantSSW then
            isSocketed = true
          end
        end
        if true == isSocketed then
          local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_SELL_ALERT_1")
          local messageBoxData = {
            title = PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_SELL_ALERT_2"),
            content = messageBoxMemo,
            functionYes = sellConfirm,
            functionNo = MessageBox_Empty_function,
            priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
          }
          MessageBox.showMessageBox(messageBoxData)
        else
          sellConfirm()
        end
        if CppEnums.ItemWhereType.eWarehouse == toWhereType and Defines.s64_const.s64_0 ~= s64_remainingTime then
          Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEMMARKET_ITEMSET_MONEYFORWAREHOUSE_ACK", "getMoney", makeDotMoney(pricePiece)), 6)
        end
      end
      local function checkItemMarket()
        if true == isGameTypeKR2() then
          sellDoit()
        elseif false ~= shopItemSSW:isDisplayWorldMarket() and 0 ~= shopItemEndurance then
          local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_ITEMMARKET_USE_MSGMEMO")
          local messageBoxData = {
            title = PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_SELL_ALERT_2"),
            content = messageBoxMemo,
            functionYes = sellDoit,
            functionNo = MessageBox_Empty_function,
            priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
          }
          MessageBox.showMessageBox(messageBoxData)
        else
          sellDoit()
        end
      end
      local itemWrapper = npcShop_getItemWrapperByShopSlotNo(selectedIndex)
      if nil ~= itemWrapper then
        local checkMaxEndurance = itemWrapper:get():getMaxEndurance()
        local originalPrice = sellPrice
        if nil ~= itemWrapper:getStaticStatus() and nil ~= itemWrapper:getStaticStatus():get() then
          checkMaxEndurance = itemWrapper:getStaticStatus():get():getMaxEndurance()
          originalPrice = Int64toInt32(itemWrapper:getStaticStatus():get()._originalPrice_s64)
        end
        if 1000 < originalPrice and (false == itemWrapper:isMaxEndurance() or itemWrapper:get():getMaxEndurance() ~= checkMaxEndurance) then
          local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_MAX_ENDURANCE_MESSAGE")
          local messageBoxData = {
            title = PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_SELL_ALERT_2"),
            content = messageBoxMemo,
            functionYes = checkItemMarket,
            functionNo = MessageBox_Empty_function,
            priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
          }
          MessageBox.showMessageBox(messageBoxData)
        else
          checkItemMarket()
        end
      else
        checkItemMarket()
      end
    end
  elseif self._ENUMTABINDEXREBUY == self._value._currentTabIndex then
    local shopItemWrapper = npcShop_getItemRepurchase(selectedIndex)
    if nil == shopItemWrapper then
      selectedSlot.btn:SetIgnore(true)
      self._value._selectedSlotIndex = nil
      return
    end
    if true == _ContentsGroup_Barter and true == shopItemWrapper:getStaticStatus():isTradePrice() then
      fromWhereType = CppEnums.ItemWhereType.eMoneyInventory
    end
    npcShop_doRepurchase(selectedIndex, fromWhereType, isCamping)
  end
  PaGlobal_NPCShop_ALL._currentScrollData._index = PaGlobal_NPCShop_ALL._ui._list2_Item_List:getCurrenttoIndex()
  PaGlobal_NPCShop_ALL._currentScrollData._scroll = PaGlobal_NPCShop_ALL._ui._list2_Item_List:GetVScroll():GetControlPos()
end
function PaGlobal_NPCShop_ALL:guildCheckByBuy()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DIALOGUE_NPCSHOP_GUILD1"))
    return false
  end
  local guildGrade = myGuildInfo:getGuildGrade()
  if 0 == guildGrade then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DIALOGUE_NPCSHOP_GUILD2"))
    return false
  end
  if nil == getSelfPlayer() then
    return
  end
  return true
end
function PaGlobal_NPCShop_ALL:audioPostEvent(idx, value, isConsole)
  if nil == Panel_Dialog_NPCShop_All then
    return
  end
  if true == self._isPadSnap and true == isConsole then
    _AudioPostEvent_SystemUiForXBOX(idx, value)
  elseif false == self._isPadSnap and false == isConsole then
    audioPostEvent_SystemUi(idx, value)
  end
end
function PaGlobal_NPCShop_ALL:changeTapByPad(idx)
  if nil == Panel_Dialog_NPCShop_All or false == Panel_Dialog_NPCShop_All:GetShow() or false == self._isPadSnap then
    return
  end
  PaGlobal_NPCShop_ALL:audioPostEvent(51, 7, true)
  local activeTabCount = 0
  for _, v in pairs(self._radioButton_Tab) do
    if nil ~= v and v:GetShow() then
      activeTabCount = activeTabCount + 1
    end
  end
  if 1 == activeTabCount then
    return
  end
  local resultTab = self._value._currentTabIndex + idx
  if resultTab <= -1 then
    resultTab = 2
  elseif 3 <= resultTab then
    resultTab = 0
  else
    PaGlobal_NPCShop_ALL:tabButtonClick(resultTab)
    return
  end
  PaGlobal_NPCShop_ALL:tabButtonClick(resultTab)
end
function PaGlobal_NPCShop_ALL:ShowToolTipByPad(selectedIndex, show)
  if nil == Panel_Dialog_NPCShop_All or false == Panel_Dialog_NPCShop_All:GetShow() or false == self._isPadSnap or true == Panel_Widget_Tooltip_Renew:GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  self._value._selectedSlotIndex = selectedIndex
  if true == show then
    local shopItemWrapper
    if self._ENUMTABINDEXBUY == self._value._currentTabIndex then
      shopItemWrapper = npcShop_getItemBuy(selectedIndex)
    elseif self._ENUMTABINDEXSELL == self._value._currentTabIndex then
      shopItemWrapper = npcShop_getItemSell(selectedIndex)
    elseif self._ENUMTABINDEXREBUY == self._value._currentTabIndex then
      shopItemWrapper = npcShop_getItemRepurchase(selectedIndex)
    end
    if nil == shopItemWrapper then
      return
    end
    local itemSSW = shopItemWrapper:getStaticStatus()
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    PaGlobal_NPCShop_ALL:audioPostEvent(50, 0, true)
  else
    PaGlobalFunc_TooltipInfo_Close()
  end
end
function PaGlobal_NPCShop_ALL:multiPurposeBtn_ShowToggle()
  if nil == Panel_Dialog_NPCShop_All or true == self._isPadSnap then
    return
  end
  if self._ENUMTABINDEXBUY == self._value._currentTabIndex then
    self._ui._pc._btn_BuySome:SetShow(true)
    self._ui._pc._btn_SellAll:SetShow(false)
  elseif self._ENUMTABINDEXSELL == self._value._currentTabIndex then
    self._ui._pc._btn_SellAll:SetShow(true)
    self._ui._pc._btn_BuySome:SetShow(false)
  else
    self._ui._pc._btn_BuySome:SetShow(false)
    self._ui._pc._btn_SellAll:SetShow(false)
  end
end
function PaGlobal_NPCShop_ALL:onRSlotClicked(slotIdx)
  if nil == Panel_Dialog_NPCShop_All or false == Panel_Dialog_NPCShop_All:GetShow() or true == self.isConsole then
    return
  end
  PaGlobal_NPCShop_ALL:onSlotClicked(slotIdx)
  PaGlobal_NPCShop_ALL:buyOrSellItem()
  self._value._selectedSlotIndex = nil
end
function PaGlobal_NPCShop_ALL:InvenItemRClick(idx)
  if nil == Panel_Dialog_NPCShop_All or false == Panel_Dialog_NPCShop_All:GetShow() then
  end
  local itemWrapper = getInventoryItem(idx)
  local itemCount
  if nil ~= itemWrapper then
    itemCount = itemWrapper:get():getCount_s64()
    if Defines.s64_const.s64_1 == itemCount then
      PaGlobalFunc_NPCShop_ALL_InvenItemSell(1, idx)
    else
      Panel_NumberPad_Show(true, itemCount, idx, PaGlobalFunc_NPCShop_ALL_InvenItemSell)
    end
  end
end
function PaGlobal_NPCShop_ALL:InvenItemSell(itemCount, idx)
  if nil == idx or nil == Panel_Dialog_NPCShop_All or false == Panel_Dialog_NPCShop_All:GetShow() or true == self.isConsole then
    return
  end
  local playerWrapper = getSelfPlayer()
  if nil == playerWrapper then
    return
  end
  local e100Percent = 1000000
  local itemWrapper = getInventoryItem(idx)
  local itemSSW = itemWrapper:getStaticStatus()
  local itemEndurance = itemWrapper:get():getEndurance()
  local sellPrice_64 = itemWrapper:getSellPriceCalculate(e100Percent)
  local sellPrice_32 = Int64toInt32(sellPrice_64)
  local itemCount_32 = Int64toInt32(itemCount)
  local sellPrice = sellPrice_32 * itemCount_32
  local s64_remainingTime = getLeftSecond_s64(itemWrapper:getExpirationDate())
  local fromWhereType = CppEnums.ItemWhereType.eInventory
  local toWhereType = CppEnums.ItemWhereType.eInventory
  if npcShop_isGuildShopContents() then
    if not PaGlobal_NPCShop_ALL:guildCheckByBuy() then
      return
    end
    toWhereType = CppEnums.ItemWhereType.eGuildWarehouse
  else
    if self._ui._btn_Check_Warehouse:IsCheck() then
      toWhereType = CppEnums.ItemWhereType.eWarehouse
    else
      toWhereType = CppEnums.ItemWhereType.eInventory
    end
    if true == _ContentsGroup_Barter and true == itemSSW:get():isTradePrice() then
      toWhereType = CppEnums.ItemWhereType.eMoneyInventory
    end
  end
  local function sellConfirm()
    playerWrapper:get():requestSellItem(idx, itemCount, fromWhereType, toWhereType, self._value._isCamping)
    if CppEnums.ItemWhereType.eWarehouse == toWhereType and Defines.s64_const.s64_0 ~= s64_remainingTime then
      Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEMMARKET_ITEMSET_MONEYFORWAREHOUSE_ACK", "getMoney", makeDotMoney(sellPrice)), 6)
    end
    if true == Panel_NumberPad_IsPopUp() then
      Panel_NumberPad_Close()
    end
  end
  local function sellDoit()
    warehouse_requestInfo(getCurrentWaypointKey())
    local isSocketed = false
    local socketMaxCount = ToClient_GetMaxItemSocketCount()
    for jewelIndex = 0, socketMaxCount - 1 do
      local itemEnchantSSW = itemWrapper:getPushedItem(jewelIndex)
      if nil ~= itemEnchantSSW then
        isSocketed = true
      end
    end
    if true == isSocketed then
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_SELL_ALERT_1")
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_SELL_ALERT_2"),
        content = messageBoxMemo,
        functionYes = sellConfirm,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    else
      playerWrapper:get():requestSellItem(idx, itemCount, fromWhereType, toWhereType, self._value._isCamping)
    end
    if CppEnums.ItemWhereType.eWarehouse == toWhereType and Defines.s64_const.s64_0 ~= s64_remainingTime then
      Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEMMARKET_ITEMSET_MONEYFORWAREHOUSE_ACK", "getMoney", makeDotMoney(sellPrice)), 6)
    end
  end
  if false == _ContentsGroup_RenewUI_ItemMarketPlace_Only then
    sellDoit()
    return
  end
  local function checkItemMarket()
    if true == isGameTypeKR2() then
      sellDoit()
    elseif false ~= itemWrapper:isDisplayWorldMarket() and 0 ~= itemEndurance then
      if true == _ContentsGroup_RenewUI_ItemMarketPlace_Only then
        local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_ITEMMARKET_USE_MSGMEMO")
        local messageBoxData = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_SELL_ALERT_2"),
          content = messageBoxMemo,
          functionYes = sellDoit,
          functionNo = MessageBox_Empty_function,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageBoxData)
      end
    else
      sellDoit()
    end
  end
  if nil ~= itemWrapper then
    local checkMaxEndurance = itemWrapper:get():getMaxEndurance()
    local originalPrice = sellPrice
    if nil ~= itemWrapper:getStaticStatus() and nil ~= itemWrapper:getStaticStatus():get() then
      checkMaxEndurance = itemWrapper:getStaticStatus():get():getMaxEndurance()
      originalPrice = Int64toInt32(itemWrapper:getStaticStatus():get()._originalPrice_s64)
    end
    if 1000 < originalPrice and (false == itemWrapper:isMaxEndurance() or itemWrapper:get():getMaxEndurance() ~= checkMaxEndurance) then
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_MAX_ENDURANCE_MESSAGE")
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_SELL_ALERT_2"),
        content = messageBoxMemo,
        functionYes = checkItemMarket,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    else
      checkItemMarket()
    end
  else
    checkItemMarket()
  end
end
function PaGlobal_NPCShop_ALL:createItem(content, dataIndex, col)
  local item = {
    btn = nil,
    dataIndex = nil,
    text = nil,
    desc = nil,
    price = nil,
    slot = nil,
    icon = {},
    coinIcon = nil,
    isStackable = nil
  }
  item.btn = UI.getChildControl(content, "RadioButton_" .. col)
  item.dataIndex = dataIndex
  item.text = UI.getChildControl(item.btn, "StaticText_Name")
  item.desc = UI.getChildControl(item.btn, "StaticText_Desc")
  item.price = UI.getChildControl(item.btn, "StaticText_Price")
  item.slot = UI.getChildControl(item.btn, "Static_Item_Slot")
  item.coinIcon = UI.getChildControl(item.btn, "Static_PriceIcon")
  item.btn:setNotImpactScrollEvent(true)
  if false == item.btn:IsCheck() then
    item.btn:SetCheck(false)
  end
  if true == self._isPadSnap then
    item.btn:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_NPCShop_ALL_BuySomeOrSellByPad(" .. dataIndex .. ")")
    item.btn:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_NPCShop_ALL_ShowToolTipByPad(" .. dataIndex .. ", true )")
    item.btn:addInputEvent("Mouse_On", "PaGlobalFunc_NPCShop_ALL_ShowNameToolTip(" .. dataIndex .. ",true)")
    item.btn:addInputEvent("Mouse_Out", "PaGlobalFunc_NPCShop_ALL_ShowNameToolTip(" .. dataIndex .. ",false)")
  else
    item.btn:addInputEvent("Mouse_LUp", "HandleEventLUp_NPCShop_ALL_OnSlotClicked(" .. dataIndex .. ")")
    item.btn:addInputEvent("Mouse_RUp", "HandleEventLUp_NPCShop_ALL_OnRSlotClicked(" .. dataIndex .. ")")
    item.btn:addInputEvent("Mouse_On", "HandleEventOnOut_NPCShop_ALL_ShowToolTipByMouse(" .. dataIndex .. ",true)")
    item.btn:addInputEvent("Mouse_Out", "HandleEventOnOut_NPCShop_ALL_ShowToolTipByMouse(" .. dataIndex .. ",false)")
  end
  self._createdItemSlot[dataIndex] = item
end
function PaGlobal_NPCShop_ALL:setItem(dataIndex, itemStaticWrapper, s64_stackCount, s64_price, s64_invenCount, rentTime, Intimacy, disable, isLimitedBuyableCount, remainingCount, resetType, isLimitedByUser, buyableMaxCount)
  if nil == Panel_Dialog_NPCShop_All and nil == self._createdItemSlot[dataIndex] and nil == itemStaticWrapper then
    return
  end
  local npc
  local characterKey = 0
  local count = 0
  local intimacyValue = 0
  local createdSlot = self._createdItemSlot[dataIndex]
  if false == self._value._isCamping or nil == self._value._isCamping then
    npc = dialog_getTalker()
    characterKey = npc:getCharacterKey()
    count = getIntimacyInformationCount(characterKey)
    intimacyValue = npc:getIntimacy()
  end
  local enable = self._CONST.s64_0 ~= s64_stackCount and not disable
  local hasIntimacy = itemStaticWrapper:hasMenatlCardKey()
  createdSlot.text:SetTextMode(__eTextMode_Limit_AutoWrap)
  createdSlot.text:SetText(itemStaticWrapper:getName())
  createdSlot.price:SetText(makeDotMoney(s64_price))
  createdSlot.desc:SetFontColor(self._COLORCANBUY)
  if enable then
    PAGlobalFunc_SetItemTextColorForNewUI(createdSlot.text, itemStaticWrapper)
  else
    createdSlot.text:SetFontColor(self._UI_COLOR.C_FFAAAAAA)
  end
  createdSlot.btn:SetCheck(false)
  if self._ENUMTABINDEXBUY == self._value._currentTabIndex then
    if nil ~= self._value._selectedSlotIndex then
      if dataIndex == self._value._selectedSlotIndex then
        createdSlot.btn:SetCheck(true)
      else
        createdSlot.btn:SetCheck(false)
      end
    end
  elseif self._ENUMTABINDEXSELL == self._value._currentTabIndex then
    if nil ~= self._value._selectedSlotIndex then
      if dataIndex == self._value._selectedSlotIndex then
        createdSlot.btn:SetCheck(true)
      else
        createdSlot.btn:SetCheck(false)
      end
    end
  elseif self._ENUMTABINDEXREBUY == self._value._currentTabIndex and nil ~= self._value._selectedSlotIndex then
    if dataIndex == self._value._selectedSlotIndex then
      createdSlot.btn:SetCheck(true)
    else
      createdSlot.btn:SetCheck(false)
    end
  end
  if 0 == dataIndex % 2 or 0 == dataIndex then
    SlotItem.reInclude(createdSlot.icon, "Left_Item_Icon_", 0, createdSlot.slot, self._slotConfig)
  else
    SlotItem.reInclude(createdSlot.icon, "Right_Item_Icon_", 0, createdSlot.slot, self._slotConfig)
  end
  createdSlot.icon:setItemByStaticStatus(itemStaticWrapper)
  if false == self._isPadSnap then
    createdSlot.icon.icon:addInputEvent("Mouse_On", "HandleEventOnOut_NPCShop_ALL_ShowToolTipByMouse(" .. dataIndex .. ",true)")
    createdSlot.icon.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_NPCShop_ALL_ShowToolTipByMouse(" .. dataIndex .. ",false)")
  end
  Panel_Tooltip_Item_SetPosition(dataIndex, createdSlot.icon, "shop")
  if self._ENUMTABINDEXBUY == self._value._currentTabIndex and isLimitedBuyableCount then
    local stringId = ""
    if true == isLimitedByUser then
      stringId = "LUA_LIMITEDITEMSHOP_FAMILY_"
    else
      stringId = "LUA_LIMITEDITEMSHOP_CHARACTER_"
    end
    if 1 == resetType then
      stringId = stringId .. "DAY"
    elseif 2 == resetType then
      stringId = stringId .. "WEEK"
    elseif 3 == resetType then
      stringId = stringId .. "MONTH"
    end
    createdSlot.desc:SetText(PAGetStringParam2(Defines.StringSheet_GAME, stringId, "count", remainingCount, "max", buyableMaxCount))
  else
    local strCount = string.format("%d", Int64toInt32(s64_stackCount))
    if s64_stackCount < self._CONST.s64_0 then
      local itemType = itemStaticWrapper:getItemType()
      if self._ENUMTABINDEXSELL == self._value._currentTabIndex then
        if 17 == itemType then
          createdSlot.desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NPCSHOP_USELESSITEM"))
        else
          createdSlot.desc:SetText("")
        end
      elseif self._ENUMTABINDEXBUY == self._value._currentTabIndex then
        createdSlot.desc:SetText(PAGetString(Defines.StringSheet_GAME, "NPCSHOP_SOLDOUT"))
      end
      createdSlot.icon.icon:SetMonoTone(false, false)
      createdSlot.price:SetMonoTone(false, false)
      createdSlot.coinIcon:SetMonoTone(false, false)
      createdSlot.desc:SetMonoTone(false, false)
    else
      createdSlot.desc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "NPCSHOP_REMAIN_COUNT", "count", strCount))
    end
  end
  if nil ~= rentTime and 0 < rentTime then
    createdSlot.desc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEM_ABLE_RENTTIME", "itemRentTime", rentTime))
  end
  if nil == Intimacy then
    Intimacy = -1
  end
  local isBuyAbleByIntimacy = intimacyValue < Intimacy
  if 0 < Intimacy and (false == self._value._isCamping or nil == self._value._isCamping) then
    createdSlot.desc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "NPCSHOP_NEED_INTIMACY", "intimacy", Intimacy))
  end
  createdSlot.slot:SetMonoTone(isBuyAbleByIntimacy, isBuyAbleByIntimacy)
  createdSlot.price:SetMonoTone(isBuyAbleByIntimacy, isBuyAbleByIntimacy)
  createdSlot.coinIcon:SetMonoTone(isBuyAbleByIntimacy, isBuyAbleByIntimacy)
  createdSlot.desc:SetMonoTone(isBuyAbleByIntimacy, isBuyAbleByIntimacy)
  local craftType
  local lifeminLevel = 0
  craftType = itemStaticWrapper:get():getLifeExperienceType()
  lifeminLevel = itemStaticWrapper:get():getLifeMinLevel(craftType)
  if 0 < lifeminLevel then
    local myLifeLevel = getSelfPlayer():get():getLifeExperienceLevel(craftType)
    if lifeminLevel > myLifeLevel then
      createdSlot.desc:SetFontColor(self._COLORCANNOTBUY)
      createdSlot.desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_EQUIP_IMPOSSIBLE"))
    else
      createdSlot.desc:SetFontColor(self._COLORCANBUY)
      createdSlot.desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_EQUIP_POSSIBLE"))
    end
  end
  local itemStatic = itemStaticWrapper:get()
  createdSlot.isStackable = itemStatic:isStackableXXX()
  if nil ~= s64_invenCount and createdSlot.isStackable == true then
    local strCount = string.format("%d", Int64toInt32(s64_invenCount))
    createdSlot.desc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "NPCSHOP_HAVE_COUNT", "count", strCount))
  end
  createdSlot.icon.icon:SetMonoTone(hasIntimacy, hasIntimacy)
  createdSlot.price:SetMonoTone(hasIntimacy, hasIntimacy)
  createdSlot.coinIcon:SetMonoTone(hasIntimacy, hasIntimacy)
  if true == hasIntimacy then
    createdSlot.desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_ALREADYHASINTIMACY"))
  end
  local moneyItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, getMoneySlotNo())
  local myInvenMoney_s64 = toInt64(0, 0)
  if nil ~= moneyItemWrapper then
    myInvenMoney_s64 = moneyItemWrapper:get():getCount_s64()
  end
  local myWareHouseMoney_s64 = warehouse_moneyFromNpcShop_s64()
  if true == _ContentsGroup_Barter then
    createdSlot.coinIcon:SetSize(30, 30)
    createdSlot.coinIcon:SetSpanSize(415, 30)
    if true == itemStatic:isTradePrice() then
      createdSlot.coinIcon:SetSize(19, 19)
      createdSlot.coinIcon:SetSpanSize(420, 37)
      createdSlot.coinIcon:ChangeTextureInfoName("Combine/Icon/Combine_Cashshop_Icon_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(createdSlot.coinIcon, 101, 24, 120, 43)
      createdSlot.coinIcon:getBaseTexture():setUV(x1, y1, x2, y2)
      createdSlot.coinIcon:setRenderTexture(createdSlot.coinIcon:getBaseTexture())
      local priceItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eMoneyInventory, __eInventoryMoneyType_Shell)
      if true == _ContentsGroup_Barter then
        myInvenMoney_s64 = toInt64(0, 0)
        if nil ~= priceItemWrapper then
          myInvenMoney_s64 = priceItemWrapper:get():getCount_s64()
        end
      end
    else
      createdSlot.coinIcon:ChangeTextureInfoName("combine/icon/combine_basic_icon_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(createdSlot.coinIcon, 359, 103, 409, 153)
      createdSlot.coinIcon:getBaseTexture():setUV(x1, y1, x2, y2)
      createdSlot.coinIcon:setRenderTexture(createdSlot.coinIcon:getBaseTexture())
      createdSlot.coinIcon:SetSpanSize(415, 30)
    end
    createdSlot.coinIcon:ComputePos()
  end
  if npcShop_isGuildShopContents() then
    local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
    if nil ~= myGuildListInfo then
      if self._ENUMTABINDEXBUY == self._value._currentTabIndex and s64_price > myGuildListInfo:getGuildBusinessFunds_s64() then
        createdSlot.price:SetFontColor(self._COLORCANNOTBUY)
      else
        createdSlot.price:SetFontColor(self._COLORCANBUY)
      end
    else
      createdSlot.price:SetFontColor(self._COLORCANNOTBUY)
    end
  elseif self._ENUMTABINDEXBUY == self._value._currentTabIndex then
    local isBuy = true
    if true == _ContentsGroup_Barter and true == itemStatic:isTradePrice() then
      if s64_price > myInvenMoney_s64 then
        isBuy = false
      end
    elseif s64_price > myInvenMoney_s64 and s64_price > myWareHouseMoney_s64 then
      isBuy = false
    end
    if true == isBuy then
      createdSlot.price:SetFontColor(self._COLORCANBUY)
    else
      createdSlot.price:SetFontColor(self._COLORCANNOTBUY)
    end
  else
    createdSlot.price:SetFontColor(self._COLORCANBUY)
  end
  createdSlot.btn:SetShow(true)
  createdSlot.btn:SetIgnore(false)
end
function PaGlobal_NPCShop_ALL:onSlotClicked(slotIdx)
  if nil == Panel_Dialog_NPCShop_All or true == self._isPadSnap then
    return
  end
  if self._value._selectedSlotIndex ~= slotIdx then
    Panel_NumberPad_Show(false, Defines.s64_const.s64_0, 0, nil)
    if nil ~= self._value._sellingItemKey then
      self._value._sellingItemKey = nil
    end
  end
  if nil ~= slotIdx then
    self._value._selectedSlotIndex = slotIdx
    local isStackable = self._createdItemSlot[slotIdx].isStackable
    self._ui._pc._btn_BuySome:SetEnable(isStackable, isStackable)
    self._ui._pc._btn_BuySome:SetMonoTone(not isStackable, not isStackable)
    self._ui._pc._btn_SellAll:SetEnable(isStackable, isStackable)
    self._ui._pc._btn_SellAll:SetMonoTone(not isStackable, not isStackable)
  end
end
function PaGlobal_NPCShop_ALL:validate()
  if nil == Panel_Dialog_NPCShop_All then
    return
  end
  self._ui._stc_TitleBg:isValidate()
  self._ui._stc_SubBg:isValidate()
  self._ui._pc._btn_Close:isValidate()
  self._ui._pc._btn_Question:isValidate()
  self._ui._pc._stc_TabGroup:isValidate()
  self._ui._pc._btn_Radio_Buy:isValidate()
  self._ui._pc._btn_Radio_Sell:isValidate()
  self._ui._pc._btn_Radio_Repurchase:isValidate()
  self._ui._pc._btn_Buy:isValidate()
  self._ui._pc._btn_BuySome:isValidate()
  self._ui._pc._btn_SellAll:isValidate()
  self._ui._console._stc_TabGroup_Console:isValidate()
  self._ui._console._btn_TabGroup_LT:isValidate()
  self._ui._console._btn_TabGroup_RT:isValidate()
  self._ui._console._btn_Radio_Buy_Console:isValidate()
  self._ui._console._btn_Radio_Sell_Console:isValidate()
  self._ui._console._btn_Radio_Repurchase_Console:isValidate()
  self._ui._console._stc_KeyGuide:isValidate()
  self._ui._console._stc_Key_Purchase:isValidate()
  self._ui._console._stc_Key_Purchase_All:isValidate()
  self._ui._console._stc_Key_Detail:isValidate()
  self._ui._console._stc_Key_Cancel:isValidate()
  self._ui._stc_SelectBar:isValidate()
  self._ui._list2_Item_List:isValidate()
  self._ui._list2_Content:isValidate()
  self._ui._list2_RdoBtn:isValidate()
  self._ui._btn_Radio_LeftTemplete:isValidate()
  self._ui._stc_ItemSlot_LeftTemplete:isValidate()
  self._ui._btn_Radio_LeftTemplete:isValidate()
  self._ui._btn_Radio_RightTemplete:isValidate()
  self._ui._stc_ItemSlot_RightTemplete:isValidate()
  self._ui._btn_Radio_RightTemplete:isValidate()
  self._ui._stc_Scroll_Vertical:isValidate()
  self._ui._stc_Scroll_Horizontal:isValidate()
  self._ui._stc_player_Silver:isValidate()
  self._ui._btn_Check_Inven:isValidate()
  self._ui._btn_Check_Warehouse:isValidate()
  self._ui._txt_Silver_Inven:isValidate()
  self._ui._txt_Silver_Storage:isValidate()
  self._ui._stc_Guild_Silver:isValidate()
  self._ui._btn_Check_Inven_Guild:isValidate()
  self._ui._btn_Check_Warehouse_Guild:isValidate()
  self._ui._txt_Silver_Inven_Guild:isValidate()
  self._ui._txt_Silver_Storage_Guild:isValidate()
  self._ui._console._stc_Key_Scroll:isValidate()
end
