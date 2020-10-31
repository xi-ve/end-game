function PaGlobal_TradeFunction_All:initialize()
  if true == PaGlobal_TradeFunction_All._initialize or nil == Panel_Dialog_Trade_Function_All then
    return
  end
  self._ui._rdo_Buy = UI.getChildControl(Panel_Dialog_Trade_Function_All, "RadioButton_Buy")
  self._ui._rdo_Sell = UI.getChildControl(Panel_Dialog_Trade_Function_All, "RadioButton_Sell")
  self._ui._rdo_Exit = UI.getChildControl(Panel_Dialog_Trade_Function_All, "RadioButton_Exit")
  self._ui._stc_KeyGuide_LB = UI.getChildControl(Panel_Dialog_Trade_Function_All, "Button_LB_ConsoleUI")
  self._ui._stc_KeyGuide_RB = UI.getChildControl(Panel_Dialog_Trade_Function_All, "Button_RB_ConsoleUI")
  self._ui._stc_SelectBar = UI.getChildControl(Panel_Dialog_Trade_Function_All, "Static_SelectBar")
  self._ui._stc_KeyGuide_A = UI.getChildControl(self._ui._stc_SelectBar, "Button_A_ConsoleUI")
  self._ui._stc_BigHandDesc = UI.getChildControl(Panel_Dialog_Trade_Function_All, "StaticText_Desc")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_KeyGuide_LB:SetShow(self._isConsole)
  self._ui._stc_KeyGuide_RB:SetShow(self._isConsole)
  self._ui._stc_KeyGuide_A:SetShow(false)
  self._ui._rdo_Exit:SetShow(not self._isConsole)
  self._ui._stc_BigHandDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_BigHandDesc:SetText(self._ui._stc_BigHandDesc:GetText())
  self._ui._tabGroups[self._ENUM_TAB_BUY] = self._ui._rdo_Buy
  self._ui._tabGroups[self._ENUM_TAB_SELL] = self._ui._rdo_Sell
  if false == self._isConsole then
    self._ui._tabGroups[2] = self._ui._rdo_Exit
  end
  PaGlobal_TradeFunction_All:validate()
  PaGlobal_TradeFunction_All:registerEventHandler()
end
function PaGlobal_TradeFunction_All:validate()
  if nil == Panel_Dialog_Trade_Function_All then
    return
  end
  self._ui._rdo_Buy:isValidate()
  self._ui._rdo_Sell:isValidate()
  self._ui._stc_KeyGuide_LB:isValidate()
  self._ui._stc_KeyGuide_RB:isValidate()
  self._ui._stc_SelectBar:isValidate()
  self._ui._stc_KeyGuide_A:isValidate()
  self._ui._stc_BigHandDesc:isValidate()
  self._initialize = true
end
function PaGlobal_TradeFunction_All:onScreenResize()
  if nil == Panel_Dialog_Trade_Function_All then
    return
  end
  Panel_Dialog_Trade_Function_All:SetSize(getScreenSizeX(), Panel_Dialog_Trade_Function_All:GetSizeY())
  Panel_Dialog_Trade_Function_All:ComputePos()
  self._ui._rdo_Buy:ComputePos()
  self._ui._rdo_Sell:ComputePos()
  self._ui._rdo_Exit:ComputePos()
  self._ui._stc_SelectBar:ComputePos()
  self._ui._stc_KeyGuide_RB:ComputePos()
  self._ui._stc_KeyGuide_LB:ComputePos()
end
function PaGlobal_TradeFunction_All:registerEventHandler()
  if nil == Panel_Dialog_Trade_Function_All or false == PaGlobal_TradeFunction_All._initialize then
    return
  end
  registerEvent("onScreenResize", "FromClient_TradeFunction_All_OnScreenResize()")
  registerEvent("EventNpcTradeShopUpdate", "PaGlobalFunc_TradeFunction_All_Open()")
  if false == self._isConsole then
    self._ui._rdo_Buy:addInputEvent("Mouse_LUp", "PaGlobalFunc_TradeFunction_All_ChangeTab( 0 )")
    self._ui._rdo_Sell:addInputEvent("Mouse_LUp", "PaGlobalFunc_TradeFunction_All_ChangeTab( 1 )")
    self._ui._rdo_Exit:addInputEvent("Mouse_LUp", "HandleEventLUp_TradeFunction_All_Close()")
  end
end
function PaGlobal_TradeFunction_All:prepareOpen()
  if nil == Panel_Dialog_Trade_MarketItemList_All or nil == Panel_Dialog_Trade_MyBasket_All or nil == Panel_Dialog_Trade_PriceRate_All or nil == Panel_Dialog_Trade_Tooltip_All or nil == Panel_Dialog_Trade_Function_All then
    return
  end
  if true == _ContentsGroup_NewUI_Dialog_All then
    if false == Panel_Npc_Dialog_All:GetShow() then
      return
    end
  elseif true == _ContentsGroup_RenewUI_Dailog then
    if true == PaGlobal_DialogMain_GetAlreadyClose() then
      return
    end
  elseif false == Panel_Npc_Dialog:GetShow() then
    return
  end
  local talker = dialog_getTalker()
  local npcActorproxy = talker:get()
  local npcPosition = npcActorproxy:getPosition()
  local npcRegionInfo = getRegionInfoByPosition(npcPosition)
  local npcTradeOriginRegion = npcRegionInfo:get():getTradeOriginRegion()
  local isNodeLink = checkSelfplayerNode(npcTradeOriginRegion._waypointKey, true)
  if true == self._isConsole and false == isNodeLink then
    local npcTradeNodeName = npcRegionInfo:getTradeExplorationNodeName()
    local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "Lua_WindowTradeMarket_NeedInvest", "npc_tradenodename", npcTradeNodeName)
    local messageBoxData = {
      title = "",
      content = messageBoxMemo,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  local characterStaticStatusWrapper = npcShop_getCurrentCharacterKeyForTrade()
  local characterStaticStatus = characterStaticStatusWrapper:get()
  if nil == characterStaticStatus or nil == characterStaticStatusWrapper then
    return
  end
  if true == characterStaticStatus:isTerritorySupplyMerchant() then
    local isTrading = false
    PaGlobal_TradeFunction_All:SetTerritoryCount()
    local supplyItemCount = 0
    for terrIndex = 0, self._territoryCount - 1 do
      supplyItemCount = ToClient_worldmap_getTradeSupplyCount(terrIndex)
      if 0 < supplyItemCount then
        isTrading = true
      end
    end
    if false == isTrading then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TRADEMARKET_EVENTINFO_NOTEVENT"))
      return
    end
  end
  if false == self._global._isTrading then
    local npcKey = dialog_getTalkNpcKey()
    if 0 == npcKey then
      return
    end
    openClientChangeScene(npcKey, 1)
    if nil ~= Panel_Dialog_Trade_BiddingGame_All then
      PaGlobalFunc_TradeBiddingGame_All_ResetSuccess()
    elseif nil ~= Panel_TradeGame then
      FGlobal_isTradeGameSuccess()
    end
    SetUIMode(Defines.UIMode.eUIMode_Trade)
    if true == _ContentsGroup_NewUI_Dialog_All then
      PaGlobalFunc_DialogMain_All_SetIgnoreShowDialog(true)
      PaGlobalFunc_DialogMain_All_ShowToggle(false)
    elseif true == self._isConsole then
      PaGlobalFunc_MainDialog_setIgnoreShowDialog(true)
      PaGlobalFunc_MainDialog_Close(false)
    else
      setIgnoreShowDialog(true)
      Panel_Npc_Dialog:SetShow(false, false)
    end
    self._currentTab = self._ENUM_TAB_BUY
    self._ui._rdo_Exit:SetCheck(false)
    self._ui._rdo_Sell:SetCheck(false)
    self._ui._stc_BigHandDesc:SetShow(false)
    PaGlobalFunc_TradeFunction_All_SetIsTrading(true)
    PaGlobalFunc_DialogIntimacy_All_Close()
    cutSceneCameraWaveMode(false)
    isNearActorEdgeShow(false)
    PaGlobal_TradeFunction_All:merchantCheck()
    PaGlobal_TradeFunction_All:onScreenResize()
    PaGlobal_TradeFunction_All:open()
    PaGlobal_TradeFunction_All:openOtherPanel(isNodeLink)
    PaGlobal_TradeFunction_All:update()
  end
end
function PaGlobal_TradeFunction_All:openOtherPanel(isNodeLink)
  if nil == Panel_Dialog_Trade_MarketItemList_All or nil == Panel_Dialog_Trade_MyBasket_All or nil == Panel_Dialog_Trade_PriceRate_All or nil == Panel_Dialog_Trade_Tooltip_All or nil == Panel_Dialog_Trade_Function_All then
    return
  end
  PaGlobalFunc_TradeMyBasket_All_Open()
  PaGlobalFunc_MarketItemList_All_Open()
  local npcSSW = npcShop_getCurrentCharacterKeyForTrade():get()
  local isFishingSupply = npcSSW:isFishSupplyMerchant()
  if false == isNodeLink and false == isFishingSupply then
    if nil ~= Panel_Dialog_Trade_NoLink_All then
      PaGlobalFunc_TradeNoLink_All_Open()
    end
    local isNPCNodeControl = getDialogButtonIndexByType(CppEnums.ContentsType.Contents_Explore)
    if -1 ~= isNPCNodeControl then
      PaGlobal_TradeNoLink_All_UpdatePanel(true)
    else
      PaGlobal_TradeNoLink_All_UpdatePanel(false)
    end
  end
end
function PaGlobal_TradeFunction_All:merchantCheck()
  if nil == Panel_Dialog_Trade_Function_All then
    return
  end
  local characterStaticStatusWrapper = npcShop_getCurrentCharacterKeyForTrade()
  local characterStaticStatus = characterStaticStatusWrapper:get()
  if nil == characterStaticStatusWrapper or nil == characterStaticStatus then
    return
  end
  if characterStaticStatus:isTerritorySupplyMerchant() then
    self._buyFromNPCOrSellToNPCOrAll = 2
    self._territorySupplyCheck = true
  elseif characterStaticStatus:isTerritoryTradeMerchant() then
    self._buyFromNPCOrSellToNPCOrAll = 1
    self._territorySupplyCheck = false
  elseif characterStaticStatus:isSupplyMerchant() or characterStaticStatus:isFishSupplyMerchant() or characterStaticStatus:isGuildSupplyShopMerchant() then
    self._buyFromNPCOrSellToNPCOrAll = 3
    if characterStaticStatus:isGuildSupplyShopMerchant() then
      self._territorySupplyCheck = false
    end
    self._territorySupplyCheck = true
  else
    self._buyFromNPCOrSellToNPCOrAll = 1
    self._territorySupplyCheck = false
  end
  PaGlobal_TradeFunction_All:bigHandCheck()
  if 1 == self._buyFromNPCOrSellToNPCOrAll then
    self._ui._rdo_Buy:SetShow(true)
    self._ui._rdo_Sell:SetShow(true)
    PaGlobal_TradeFunction_All._currentTab = PaGlobal_TradeFunction_All._ENUM_TAB_BUY
  else
    self._ui._rdo_Buy:SetShow(false)
    self._ui._rdo_Sell:SetShow(true)
    PaGlobal_TradeFunction_All._currentTab = PaGlobal_TradeFunction_All._ENUM_TAB_SELL
  end
  local count = 0
  local btnTable = {}
  for idx = 0, #self._ui._tabGroups do
    if true == self._ui._tabGroups[idx]:GetShow() then
      btnTable[count] = self._ui._tabGroups[idx]
      count = count + 1
    end
  end
  local sizeX = getScreenSizeX()
  local buttonSize = btnTable[0]:GetSizeX()
  local buttonGap = 30
  local startPosX = (getScreenSizeX() - (buttonSize * count + buttonGap * (count - 1))) / 2 + 60
  local posX = 0
  local jindex = 0
  for index = 0, count - 1 do
    posX = startPosX + buttonSize * jindex
    jindex = jindex + 1
    btnTable[index]:SetSpanSize(posX, 0)
  end
  self._ui._stc_KeyGuide_LB:SetShow(false)
  self._ui._stc_KeyGuide_RB:SetShow(false)
  local isKeyguideAvaliable = 0 < #btnTable
  if true == self._isConsole and true == isKeyguideAvaliable then
    self._ui._stc_KeyGuide_LB:SetShow(isKeyguideAvaliable)
    self._ui._stc_KeyGuide_RB:SetShow(isKeyguideAvaliable)
    self._ui._stc_KeyGuide_LB:SetSpanSize(btnTable[0]:GetSpanSize().x - 50, self._ui._stc_KeyGuide_LB:GetSpanSize().y)
    self._ui._stc_KeyGuide_RB:SetSpanSize(btnTable[#btnTable]:GetSpanSize().x + btnTable[#btnTable]:GetSizeX() - 10, self._ui._stc_KeyGuide_RB:GetSpanSize().y)
  end
  local currentTab = self._ui._tabGroups[PaGlobal_TradeFunction_All._currentTab]
  local selectBarPosX = currentTab:GetSpanSize().x + self._ui._stc_SelectBar:GetSizeX() / 2 + 10
  self._ui._stc_SelectBar:SetSpanSize(selectBarPosX, self._ui._stc_SelectBar:GetSpanSize().y)
  self._ui._tabGroups[PaGlobal_TradeFunction_All._currentTab]:SetCheck(true)
end
function PaGlobal_TradeFunction_All:bigHandCheck()
  if nil == Panel_Dialog_Trade_Function_All then
    return
  end
  local bigHand = 1000000 ~= getSelfPlayer():get():getlTradeItemCountRate()
  self._ui._stc_BigHandDesc:SetShow(bigHand)
  self._ui._stc_BigHandDesc:SetPosX(Panel_Dialog_Trade_MarketItemList_All:GetSizeX() + 30)
end
function PaGlobal_TradeFunction_All:open()
  if nil == Panel_Dialog_Trade_Function_All then
    return
  end
  Panel_Dialog_Trade_Function_All:SetShow(true)
end
function PaGlobal_TradeFunction_All:update()
  if nil == Panel_Dialog_Trade_Function_All then
    return
  end
  if -1 ~= PaGlobal_TradeFunction_All._currentTab then
    PaGlobalFunc_MarketItemList_All_ChangeTab(PaGlobal_TradeFunction_All._currentTab)
    PaGlobalFunc_TradeMyBasket_All_TabChange(PaGlobal_TradeFunction_All._currentTab)
  end
end
function PaGlobal_TradeFunction_All:prepareClose()
  if nil == Panel_Dialog_Trade_Function_All then
    return
  end
  if MessageBoxGetShow() then
    return
  end
  if true == Panel_Dialog_Trade_PriceRate_All:GetShow() then
    HandleEventLUp_TradePriceRate_All_Close()
    return
  end
  if nil ~= Panel_Dialog_Trade_BiddingGame_All then
    if true == Panel_Dialog_Trade_BiddingGame_All:GetShow() then
      HandleEventLup_TradeBiddingGame_All_Close()
      return
    end
  elseif nil ~= Panel_TradeGame and true == Panel_TradeGame:GetShow() then
    Fglobal_TradeGame_Close()
    return
  end
  if nil ~= Panel_Dialog_Trade_BiddingGame_All then
    PaGlobalFunc_TradeBiddingGame_All_ResetSuccess()
  elseif nil ~= Panel_TradeGame then
    FGlobal_isTradeGameSuccess()
  end
  PaGlobal_TradeFunction_All:closeOtherPanel()
  PaGlobal_TradeFunction_All:close()
  PaGlobal_TradeFunction_All._currentTab = -1
  cutSceneCameraWaveMode(true)
  isNearActorEdgeShow(true)
  PaGlobalFunc_TradeFunction_All_SetIsTrading(false)
  local mainCameraName = Dialog_getMainSceneCameraName()
  changeCameraScene(mainCameraName, 0.5)
  SetUIMode(Defines.UIMode.eUIMode_NpcDialog)
  if true == _ContentsGroup_NewUI_Dialog_All then
    PaGlobalFunc_DialogMain_All_ShowToggle(true)
    PaGlobalFunc_DialogIntimacy_All_Open()
  elseif true == PaGlobal_TradeFunction_All._isConsole then
    PaGlobalFunc_MainDialog_setIgnoreShowDialog(false)
    PaGlobalFunc_MainDialog_ReOpen(false)
  else
    setIgnoreShowDialog(false)
    Panel_Npc_Dialog:SetShow(true, false)
  end
  local npcKey = dialog_getTalkNpcKey()
  if 0 ~= npcKey then
    closeClientChangeScene(npcKey)
  else
    UI.ASSERT("PaGlobal_TradeFunction_All : NPC Key \236\132\164\236\160\149\236\157\180 \235\144\152\236\150\180\236\158\136\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!!")
  end
  PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
end
function PaGlobal_TradeFunction_All:close()
  if nil == Panel_Dialog_Trade_Function_All then
    return
  end
  Panel_Dialog_Trade_Function_All:SetShow(false)
end
function PaGlobal_TradeFunction_All:closeOtherPanel()
  if nil == Panel_Dialog_Trade_MarketItemList_All or nil == Panel_Dialog_Trade_MyBasket_All or nil == Panel_Dialog_Trade_PriceRate_All or nil == Panel_Dialog_Trade_Tooltip_All or nil == Panel_Dialog_Trade_NoLink_All then
    return
  end
  PaGlobalFunc_MarketItemList_All_Close()
  PaGlobalFunc_TradeMarketItemToolTip_All_Hide()
  HandleEventLUp_TradeMyBasket_All_Close()
  PaGlobalFunc_TradeNoLink_All_Close()
  if nil ~= Panel_Dialog_Trade_BiddingGame_All then
    HandleEventLup_TradeBiddingGame_All_Close()
  else
    Fglobal_TradeGame_Close()
  end
  InventoryWindow_Close()
  Panel_Tooltip_Item_hideTooltip()
  TooltipSimple_Hide()
end
function PaGlobal_TradeFunction_All:SetTerritoryCount()
  if ToClient_IsContentsGroupOpen("6") then
    self._territoryCount = 8
  elseif ToClient_IsContentsGroupOpen("260") then
    self._territoryCount = 7
  elseif ToClient_IsContentsGroupOpen("83") then
    self._territoryCount = 6
  elseif ToClient_IsContentsGroupOpen("4") then
    self._territoryCount = 5
  elseif ToClient_IsContentsGroupOpen("3") then
    self._territoryCount = 4
  elseif ToClient_IsContentsGroupOpen("2") then
    self._territoryCount = 3
  else
    self._territoryCount = 2
  end
end
