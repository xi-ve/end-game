function PaGlobal_TradePriceRate_All:initialize()
  if true == PaGlobal_TradePriceRate_All._initialize or nil == Panel_Dialog_Trade_PriceRate_All then
    return
  end
  self._ui._btn_Close_PC = UI.getChildControl(Panel_Dialog_Trade_PriceRate_All, "Button_Close")
  self._ui._list2_Territory = UI.getChildControl(Panel_Dialog_Trade_PriceRate_All, "List2_Territory")
  self._ui._list2_TerritoryContent = UI.getChildControl(self._ui._list2_Territory, "List2_1_Content")
  self._ui._list2_TerritoryRadioBtn = UI.getChildControl(self._ui._list2_TerritoryContent, "RadioButton_TerritoryName")
  self._ui._stc_SelectedItemBg = UI.getChildControl(Panel_Dialog_Trade_PriceRate_All, "Static_SelectItemBg")
  self._ui._icon_SelectedItem = UI.getChildControl(self._ui._stc_SelectedItemBg, "Static_ItemBg")
  self._ui._txt_SelectedItemName = UI.getChildControl(self._ui._stc_SelectedItemBg, "StaticText_ItemName")
  self._ui._list2_PriceRate = UI.getChildControl(Panel_Dialog_Trade_PriceRate_All, "List2_Rate")
  self._ui._list2_PriceRateContent = UI.getChildControl(self._ui._list2_PriceRate, "List2_1_Content")
  local contentBg = UI.getChildControl(self._ui._list2_PriceRateContent, "Static_ContentBg")
  self._ui._list2_PriceRateBg = UI.getChildControl(contentBg, "Static_Bg_Template_1")
  self._ui._list2_RegionName = UI.getChildControl(self._ui._list2_PriceRateBg, "StaticText_RegionName")
  self._ui._list2_Price = UI.getChildControl(self._ui._list2_PriceRateBg, "StaticText_Price")
  self._ui._list2_OriginPrice = UI.getChildControl(self._ui._list2_PriceRateBg, "StaticText_OriginalPrice")
  self._ui._list2_GraphBg = UI.getChildControl(self._ui._list2_PriceRateBg, "Static_GraphBg")
  self._ui._list2_CenterLine = UI.getChildControl(self._ui._list2_PriceRateBg, "Static_CenterLine")
  self._ui._list2_LowestLine = UI.getChildControl(self._ui._list2_PriceRateBg, "Staic_LowestPoint")
  self._ui._list2_HighestLine = UI.getChildControl(self._ui._list2_PriceRateBg, "Static_highestPoint")
  self._ui._list2_CurrentPoint = UI.getChildControl(self._ui._list2_PriceRateBg, "Static_currentPoint")
  local icon = {}
  SlotItem.new(icon, "CurrentTrendIcon", 0, self._ui._icon_SelectedItem, self.slotConfig)
  icon:createChild()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._btn_Close_PC:SetShow(not self._isConsole)
  PaGlobal_TradePriceRate_All:validate()
  PaGlobal_TradePriceRate_All:registerEventHandler()
end
function PaGlobal_TradePriceRate_All:validate()
  if nil == Panel_Dialog_Trade_PriceRate_All then
    return
  end
  self._ui._btn_Close_PC:isValidate()
  self._ui._list2_Territory:isValidate()
  self._ui._list2_TerritoryContent:isValidate()
  self._ui._list2_TerritoryRadioBtn:isValidate()
  self._ui._stc_SelectedItemBg:isValidate()
  self._ui._icon_SelectedItem:isValidate()
  self._ui._txt_SelectedItemName:isValidate()
  self._ui._list2_PriceRate:isValidate()
  self._ui._list2_PriceRateContent:isValidate()
  self._ui._list2_PriceRateBg:isValidate()
  self._ui._list2_RegionName:isValidate()
  self._ui._list2_Price:isValidate()
  self._ui._list2_OriginPrice:isValidate()
  self._ui._list2_GraphBg:isValidate()
  self._ui._list2_CenterLine:isValidate()
  self._ui._list2_LowestLine:isValidate()
  self._ui._list2_HighestLine:isValidate()
  self._ui._list2_CurrentPoint:isValidate()
  self._initialize = true
end
function PaGlobal_TradePriceRate_All:registerEventHandler()
  if nil == Panel_Dialog_Trade_PriceRate_All or false == self._initialize then
    return
  end
  self._ui._list2_Territory:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_TradePriceRate_All_List2UpdateRegionData")
  self._ui._list2_Territory:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._list2_PriceRate:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_TradePriceRate_All_List2UpdateGraphData")
  self._ui._list2_PriceRate:createChildContent(__ePAUIList2ElementManagerType_List)
  if false == self._isConsole then
    self._ui._btn_Close_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_TradePriceRate_All_Close()")
  else
    Panel_Dialog_Trade_PriceRate_All:ignorePadSnapMoveToOtherPanel()
  end
  registerEvent("FromClient_TrendInfoInShop", "PaGlobalFunc_TradePriceRate_All_Open")
  registerEvent("EventNpcShopUpdate", "FromClient_TradePriceRate_All_UpdateGraph")
  registerEvent("EventNpcTradeShopGraphRefresh", "FromClient_TradePriceRate_All_UpdateGraph")
end
function PaGlobal_TradePriceRate_All:prepareOpen()
  if nil == Panel_Dialog_Trade_PriceRate_All then
    return
  end
  self._territoryCount = self:getTerritoryCount()
  self._currentitemKey = PaGlobalFunc_MarketItemList_All_GetItemKeyForTrendPriceView()
  local itemESSW = getItemEnchantStaticStatus(ItemEnchantKey(self._currentitemKey))
  local icon = {}
  SlotItem.reInclude(icon, "CurrentTrendIcon", 0, self._ui._icon_SelectedItem, self.slotConfig)
  icon:setItemByStaticStatus(itemESSW)
  self._ui._txt_SelectedItemName:SetText(itemESSW:getName())
  PAGlobalFunc_SetItemTextColorForNewUI(self._ui._txt_SelectedItemName, itemESSW)
  Panel_Dialog_Trade_MarketItemList_All:SetIgnoreChild(true)
  Panel_Dialog_Trade_MyBasket_All:SetIgnoreChild(true)
  PaGlobal_TradePriceRate_All:open()
  PaGlobal_TradePriceRate_All:update()
end
function PaGlobal_TradePriceRate_All:open()
  if nil == Panel_Dialog_Trade_PriceRate_All then
    return
  end
  Panel_Dialog_Trade_PriceRate_All:SetShow(true)
end
function PaGlobal_TradePriceRate_All:update()
  if nil == Panel_Dialog_Trade_PriceRate_All then
    return
  end
  self._currentTerritoryIndex = -1
  self._ui._list2_Territory:getElementManager():clearKey()
  for idx = 0, self._territoryCount - 1 do
    local trendItemSizeInTerritory = ToClient_TrendTradeItemSize(idx)
    if 0 <= trendItemSizeInTerritory - 1 then
      self._ui._list2_Territory:getElementManager():pushKey(toInt64(0, idx))
    end
  end
end
function PaGlobal_TradePriceRate_All:getTerritoryCount()
  if nil == Panel_Dialog_Trade_PriceRate_All then
    return
  end
  if ToClient_IsContentsGroupOpen("6") then
    return 8
  elseif ToClient_IsContentsGroupOpen("260") then
    return 7
  elseif ToClient_IsContentsGroupOpen("83") then
    return 6
  elseif ToClient_IsContentsGroupOpen("4") then
    return 5
  elseif ToClient_IsContentsGroupOpen("3") then
    return 4
  elseif ToClient_IsContentsGroupOpen("2") then
    return 3
  else
    return 2
  end
end
function PaGlobal_TradePriceRate_All:list2UpdateRegionData(content, key)
  if nil == Panel_Dialog_Trade_PriceRate_All or false == Panel_Dialog_Trade_PriceRate_All:GetShow() then
    return
  end
  local rdo_territoryButton = UI.getChildControl(content, "RadioButton_TerritoryName")
  rdo_territoryButton:SetCheck(false)
  local territoryButtonIndex = Int64toInt32(key)
  local trendItemSizeInTerritory = ToClient_TrendTradeItemSize(territoryButtonIndex)
  if 0 <= trendItemSizeInTerritory - 1 then
    local territoryInfoWrapper = getTerritoryInfoWrapperByIndex(territoryButtonIndex)
    rdo_territoryButton:SetText(territoryInfoWrapper:getTerritoryName())
    rdo_territoryButton:SetShow(true)
    if false == self._isConsole then
      rdo_territoryButton:addInputEvent("Mouse_LUp", "HandleEventLUp_TradePriceRate_All_ShowOtherTerritory(" .. territoryButtonIndex .. ")")
    else
      rdo_territoryButton:registerPadEvent(__eConsoleUIPadEvent_A, "HandleEventLUp_TradePriceRate_All_ShowOtherTerritory(" .. territoryButtonIndex .. ")")
    end
    if nil == self._currentTerritoryIndex or -1 == self._currentTerritoryIndex then
      rdo_territoryButton:SetCheck(true)
      self._currentTerritoryIndex = territoryButtonIndex
      self:pushKeyToGraphList2(territoryButtonIndex, false)
    end
  else
    rdo_territoryButton:SetShow(false)
    rdo_territoryButton:SetCheck(false)
  end
end
function PaGlobal_TradePriceRate_All:pushKeyToGraphList2(territoryIdx, isUpdate)
  if nil == Panel_Dialog_Trade_PriceRate_All then
    return
  end
  local trendItemSizeInTerritory = ToClient_TrendTradeItemSize(territoryIdx)
  self._currentTerritoryIndexTrendItemCount = trendItemSizeInTerritory
  self._maxGraphSlotCnt = trendItemSizeInTerritory
  local territoryInfoWrapper = getTerritoryInfoWrapperByIndex(territoryIdx)
  if true == isUpdate then
    for itemCountInTerritory = 1, trendItemSizeInTerritory do
      if 1 == itemCountInTerritory % self._slotCols then
        self._ui._list2_PriceRate:requestUpdateByKey(toInt64(0, itemCountInTerritory))
      end
    end
  else
    self._ui._list2_PriceRate:getElementManager():clearKey()
    for itemCountInTerritory = 1, trendItemSizeInTerritory do
      if 1 == itemCountInTerritory % self._slotCols then
        self._ui._list2_PriceRate:getElementManager():pushKey(toInt64(0, itemCountInTerritory))
      end
    end
  end
end
function PaGlobal_TradePriceRate_All:list2UpdateGraphData(content, key)
  if nil == Panel_Dialog_Trade_PriceRate_All or nil == key then
    return
  end
  local key32 = Int64toInt32(key)
  for i = 0, self._slotCols - 1 do
    local slotIndex = key32 + i
    local graphSlot = {
      PriceRateBg = nil,
      RegionName = nil,
      Price = nil,
      OriginPrice = nil,
      graphBg = nil,
      CenterLine = nil,
      LowestLine = nil,
      HighestLine = nil,
      CurrentPoint = nil,
      tradeItemWrapper = nil
    }
    local contentBg = UI.getChildControl(content, "Static_ContentBg")
    graphSlot.PriceRateBg = UI.getChildControl(contentBg, "Static_Bg_Template_" .. i + 1)
    graphSlot.RegionName = UI.getChildControl(graphSlot.PriceRateBg, "StaticText_RegionName")
    graphSlot.Price = UI.getChildControl(graphSlot.PriceRateBg, "StaticText_Price")
    graphSlot.OriginPrice = UI.getChildControl(graphSlot.PriceRateBg, "StaticText_OriginalPrice")
    graphSlot.graphBg = UI.getChildControl(graphSlot.PriceRateBg, "Static_GraphBg")
    graphSlot.CenterLine = UI.getChildControl(graphSlot.PriceRateBg, "Static_CenterLine")
    graphSlot.LowestLine = UI.getChildControl(graphSlot.PriceRateBg, "Staic_LowestPoint")
    graphSlot.HighestLine = UI.getChildControl(graphSlot.PriceRateBg, "Static_highestPoint")
    graphSlot.CurrentPoint = UI.getChildControl(graphSlot.PriceRateBg, "Static_currentPoint")
    graphSlot.PriceRateBg:SetShow(false)
    self._ui._grpahSlotGroup[slotIndex] = graphSlot
    PaGlobal_TradePriceRate_All:setGraphSlot(slotIndex)
  end
end
function PaGlobal_TradePriceRate_All:setGraphSlot(slotIndex)
  if nil == Panel_Dialog_Trade_PriceRate_All or nil == slotIndex then
    return
  end
  if nil == self._ui._grpahSlotGroup then
    return
  end
  local graphSlot = self._ui._grpahSlotGroup[slotIndex]
  graphSlot.PriceRateBg:SetShow(false)
  local currentViewingItemKey = self._currentitemKey
  if nil ~= currentViewingItemKey then
    local trendItemSizeInTerritory = ToClient_TrendTradeItemSize(self._currentTerritoryIndex)
    if nil ~= trendItemSizeInTerritory then
      local tradeItemWrapper = ToClient_GetTrendTradeItemAt(self._currentTerritoryIndex, slotIndex - 1)
      if nil ~= tradeItemWrapper then
        graphSlot.tradeItemWrapper = tradeItemWrapper
        local itemSS = tradeItemWrapper:getStaticStatus()
        local itemKey = itemSS:get()._key
        graphSlot.slotIndex = slotIndex
        graphSlot.graphBg:ClearGraphList()
        local intervalPosY = self._graphBackSizeY / 2
        local originalPrice = itemSS:getOriginalPriceByInt64()
        graphSlot.OriginPrice:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEMARKETGRAPH_ORIGINALPRICE", "OriginalPrice", makeDotMoney(originalPrice)))
        local sellPrice = tradeItemWrapper:getTradeSellPrice()
        local sellRate = Int64toInt32(sellPrice) / Int64toInt32(originalPrice) * 100
        local str_sellRate = string.format("%.f", sellRate)
        local priceRate_Value = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEMARKET_ALL_SELLRATES", "Percent", tostring(str_sellRate))
        if 100 < tonumber(tostring(str_sellRate)) then
          priceRate_Value = "(<PAColor0xFF66CC33>" .. priceRate_Value .. "<PAOldColor>\226\150\178)"
        else
          priceRate_Value = "(<PAColor0xFF66CC33>" .. priceRate_Value .. "<PAOldColor>\226\150\188)"
        end
        local price = makeDotMoney(sellPrice) .. " " .. priceRate_Value
        graphSlot.Price:SetText(price)
        local trendItemRegion = tradeItemWrapper:getTrendRegionInfo()
        graphSlot.RegionName:SetText(trendItemRegion:getAreaName())
        local graphSize = tradeItemWrapper:getGraphSize()
        graphSlot.PriceRateBg:SetShow(true)
        PaGlobal_TradePriceRate_All:updateGrpah(slotIndex)
      end
    end
  end
end
function PaGlobal_TradePriceRate_All:updateGrpah(slotIndex)
  if nil == Panel_Dialog_Trade_PriceRate_All or nil == slotIndex then
    return
  end
  if nil == self._ui._grpahSlotGroup then
    return
  end
  local graphSlot = self._ui._grpahSlotGroup[slotIndex]
  local tradeItemWrapper = graphSlot.tradeItemWrapper
  local itemSS = tradeItemWrapper:getStaticStatus()
  local itemKey = itemSS:get()._key
  local intervalPosY = graphSlot.graphBg:GetSizeY() / 2
  local priceCountSize = tradeItemWrapper:getGraphSize()
  local originalPrice64 = itemSS:getOriginalPriceByInt64()
  local originalPrice = Int64toInt32(originalPrice64)
  local upperPrice = tradeItemWrapper:getUpperLimitPrice()
  local underprice = tradeItemWrapper:getUnderLimitPrice()
  local variablePrice
  self._minPricePosY = 9999
  self._maxPricePosY = -9999
  self._minPricePosX = -1
  self._maxPricePosX = -1
  local drawPos = tradeItemWrapper:getGraphPosAt(0)
  if nil == drawPos then
    return
  end
  self._minPricePosX = self._graphIntervalValue
  self._maxPricePosX = self._graphIntervalValue
  graphSlot.graphBg:ClearGraphList()
  graphSlot.graphBg:SetGraphMode(true)
  for count = 1, priceCountSize do
    drawPos = tradeItemWrapper:getGraphPosAt(count - 1)
    if drawPos.y > 100 then
      drawPos.y = 100
    end
    if drawPos.y < -100 then
      drawPos.y = -100
    end
    if 0 < drawPos.y then
      variablePrice = upperPrice - originalPrice
    else
      variablePrice = originalPrice - underprice
    end
    drawPos.x = self._graphIntervalValue * count
    local yPos = drawPos.y * intervalPosY / 100
    local pricePercent = drawPos.y
    local calculatePosY = PaGlobalFunc_TardePriceRate_All_CalculateY(intervalPosY, yPos)
    drawPos.y = calculatePosY
    graphSlot.graphBg:AddGraphPos(drawPos)
    if self._maxPricePosY <= drawPos.y then
      self._maxPricePosX = drawPos.x
      self._maxPricePosY = drawPos.y
    end
    if self._minPricePosY > drawPos.y then
      self._minPricePosX = drawPos.x
      self._minPricePosY = drawPos.y
    end
  end
  graphSlot.graphBg:interpolationGraph()
  graphSlot.CenterLine:SetPosX(graphSlot.graphBg:GetPosX())
  graphSlot.CenterLine:SetShow(true)
  graphSlot.CurrentPoint:SetPosX(graphSlot.graphBg:GetPosX() + drawPos.x - graphSlot.CurrentPoint:GetSizeX() / 2)
  graphSlot.CurrentPoint:SetPosY(graphSlot.graphBg:GetPosY() + drawPos.y - graphSlot.CurrentPoint:GetSizeX() / 2)
  graphSlot.CurrentPoint:SetShow(tradeItemWrapper:isTradableItem())
  graphSlot.LowestLine:SetShow(false)
  graphSlot.HighestLine:SetShow(false)
  if 2 < priceCountSize then
    if drawPos.y ~= self._minPricePosY then
      local graphPosY = graphSlot.graphBg:getinterpolationGraphValue(self._minPricePosX)
      self._minPricePosX = self._minPricePosX - graphSlot.LowestLine:GetSizeX() / 2
      graphSlot.LowestLine:SetPosX(graphSlot.graphBg:GetPosX() + self._minPricePosX)
      graphSlot.LowestLine:SetPosY(graphSlot.graphBg:GetPosY() + graphPosY - graphSlot.LowestLine:GetSizeY() / 2)
      graphSlot.LowestLine:SetShow(true)
    end
    if drawPos.y ~= self._maxPricePosY then
      local graphPosY = graphSlot.graphBg:getinterpolationGraphValue(self._maxPricePosX)
      self._maxPricePosX = self._maxPricePosX - graphSlot.HighestLine:GetSizeX() / 2
      graphSlot.HighestLine:SetPosX(graphSlot.graphBg:GetPosX() + self._maxPricePosX)
      graphSlot.HighestLine:SetPosY(graphSlot.graphBg:GetPosY() + graphPosY - graphSlot.HighestLine:GetSizeY() / 2)
      graphSlot.HighestLine:SetShow(true)
    end
  end
end
function PaGlobal_TradePriceRate_All:prepareClose()
  if nil == Panel_Dialog_Trade_PriceRate_All or false == Panel_Dialog_Trade_PriceRate_All:GetShow() then
    return
  end
  Panel_Dialog_Trade_MarketItemList_All:SetIgnoreChild(false)
  Panel_Dialog_Trade_MyBasket_All:SetIgnoreChild(false)
  self._ui._list2_PriceRate:getElementManager():clearKey()
  PaGlobal_TradePriceRate_All:close()
end
function PaGlobal_TradePriceRate_All:close()
  if nil == Panel_Dialog_Trade_PriceRate_All then
    return
  end
  Panel_Dialog_Trade_PriceRate_All:SetShow(false)
end
