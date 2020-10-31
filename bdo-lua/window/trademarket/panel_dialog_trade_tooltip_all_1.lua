function PaGlobal_TradeMarketItemToolTip_All:initialize()
  if true == PaGlobal_TradeMarketItemToolTip_All._initialize then
    return
  end
  self._ui._stc_SlotBg = UI.getChildControl(Panel_Dialog_Trade_Tooltip_All, "Static_SlotBg")
  self._ui._txt_ItemName = UI.getChildControl(Panel_Dialog_Trade_Tooltip_All, "StaticText_ItemName")
  self._ui._stc_GraphBg = UI.getChildControl(Panel_Dialog_Trade_Tooltip_All, "Static_GraphBg")
  self._ui._stc_LowestPoint = UI.getChildControl(self._ui._stc_GraphBg, "Staic_LowestPoint")
  self._ui._stc_HighestPoint = UI.getChildControl(self._ui._stc_GraphBg, "Static_highestPoint")
  self._ui._stc_CurrentPoint = UI.getChildControl(self._ui._stc_GraphBg, "Static_currentPoint")
  self._ui._stc_CenterLine = UI.getChildControl(self._ui._stc_GraphBg, "Static_CenterLine")
  self._ui._txt_Weight = UI.getChildControl(Panel_Dialog_Trade_Tooltip_All, "StaticText_Weight")
  self._ui._txt_Desc = UI.getChildControl(Panel_Dialog_Trade_Tooltip_All, "StaticText_Desc")
  self._ui._txt_OriginalPrice = UI.getChildControl(Panel_Dialog_Trade_Tooltip_All, "StaticText_OriginalPrice")
  self._ui._txt_OriginalPriceValue = UI.getChildControl(Panel_Dialog_Trade_Tooltip_All, "StaticText_OriginalPriceValue")
  self._ui._originalTextSizeY = self._ui._txt_Weight:GetSizeY()
  self._ui._originalPanelSizeY = Panel_Dialog_Trade_Tooltip_All:GetSizeY()
  self._ui._originWeightText = self._ui._txt_Weight:GetPosY()
  local icon = {}
  SlotItem.new(icon, "ItemIcon_Tooltip", nil, self._ui._stc_SlotBg, self.slotConfig)
  icon:createChild()
  icon:clearItem()
  icon.icon:SetHorizonCenter()
  icon.icon:SetVerticalMiddle()
  PaGlobal_TradeMarketItemToolTip_All:validate()
  PaGlobal_TradeMarketItemToolTip_All._isConsole = _ContentsGroup_UsePadSnapping
end
function PaGlobal_TradeMarketItemToolTip_All:validate()
  if nil == Panel_Dialog_Trade_Tooltip_All then
    return
  end
  self._ui._stc_SlotBg:isValidate()
  self._ui._txt_ItemName:isValidate()
  self._ui._stc_GraphBg:isValidate()
  self._ui._stc_LowestPoint:isValidate()
  self._ui._stc_HighestPoint:isValidate()
  self._ui._stc_CurrentPoint:isValidate()
  self._ui._stc_CenterLine:isValidate()
  self._ui._txt_Weight:isValidate()
  self._ui._txt_Desc:isValidate()
  self._ui._txt_OriginalPrice:isValidate()
  self._ui._txt_OriginalPriceValue:isValidate()
  self._initialize = true
end
function PaGlobal_TradeMarketItemToolTip_All:registerEventHandler()
  if nil == Panel_Dialog_Trade_Tooltip_All or false == PaGlobal_TradeMarketItemToolTip_All._initialize then
    return
  end
  registerEvent("onScreenResize", "PaGlobal_TradeMarketItemToolTip_All_OnScreenReSize")
  registerEvent("EventNpcTradeShopGraphRefresh", "PaGlobalFunc_TradeMarketItemToolTip_All_GraphUpdate")
end
function PaGlobal_TradeMarketItemToolTip_All:setTooltipData()
  if nil == Panel_Dialog_Trade_Tooltip_All or nil == PaGlobal_TradeMarketItemToolTip_All._currentItemKey then
    return
  end
  local itemKey = self._currentItemKey
  local itemESSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  local tradeItemWrapper = npcShop_getTradeItem(itemKey)
  local intervalPosY = self._ui._stc_GraphBg:GetSizeY() / 2
  local priceCountSize = tradeItemWrapper:getGraphSize()
  local originalPrice64 = itemESSW:getOriginalPriceByInt64()
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
  self._ui._stc_GraphBg:ClearGraphList()
  self._ui._stc_GraphBg:SetGraphMode(true)
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
    if intervalPosY <= yPos then
      yPos = yPos - intervalPosY
    elseif intervalPosY >= yPos then
      yPos = intervalPosY - yPos
    else
      yPos = intervalPosY
    end
    drawPos.y = yPos
    self._ui._stc_GraphBg:AddGraphPos(drawPos)
    if self._maxPricePosY <= drawPos.y then
      self._maxPricePosX = drawPos.x
      self._maxPricePosY = drawPos.y
    end
    if self._minPricePosY > drawPos.y then
      self._minPricePosX = drawPos.x
      self._minPricePosY = drawPos.y
    end
  end
  self._ui._stc_GraphBg:interpolationGraph()
  self._ui._stc_CenterLine:ComputePos()
  self._ui._stc_CenterLine:SetShow(true)
  self._ui._stc_CurrentPoint:SetPosX(drawPos.x - self._ui._stc_CurrentPoint:GetSizeX() / 2)
  self._ui._stc_CurrentPoint:SetPosY(drawPos.y - self._ui._stc_CurrentPoint:GetSizeX() / 2)
  self._ui._stc_CurrentPoint:SetShow(tradeItemWrapper:isTradableItem())
  self._ui._stc_LowestPoint:SetShow(false)
  self._ui._stc_HighestPoint:SetShow(false)
  if 2 < priceCountSize then
    if drawPos.y ~= self._minPricePosY then
      local graphPosY = self._ui._stc_GraphBg:getinterpolationGraphValue(self._minPricePosX)
      self._minPricePosX = self._minPricePosX - self._ui._stc_LowestPoint:GetSizeX() / 2
      self._ui._stc_LowestPoint:SetPosX(self._minPricePosX)
      self._ui._stc_LowestPoint:SetPosY(graphPosY - self._ui._stc_LowestPoint:GetSizeY() / 2)
      self._ui._stc_LowestPoint:SetShow(true)
    end
    if drawPos.y ~= self._maxPricePosY then
      local graphPosY = self._ui._stc_GraphBg:getinterpolationGraphValue(self._maxPricePosX)
      self._maxPricePosX = self._maxPricePosX - self._ui._stc_HighestPoint:GetSizeX() / 2
      self._ui._stc_HighestPoint:SetPosX(self._maxPricePosX)
      self._ui._stc_HighestPoint:SetPosY(graphPosY - self._ui._stc_HighestPoint:GetSizeY() / 2)
      self._ui._stc_HighestPoint:SetShow(true)
    end
  end
end
function PaGlobal_TradeMarketItemToolTip_All:calculateY(src, dest)
  if nil == Panel_Dialog_Trade_Tooltip_All or false == Panel_Dialog_Trade_Tooltip_All:GetShow() then
    return
  end
  if src <= dest then
    dest = dest - src
  elseif src >= dest then
    dest = src - dest
  else
    dest = src
  end
  return dest
end
