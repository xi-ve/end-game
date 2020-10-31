function PaGlobalFunc_TradePriceRate_All_Open()
  if nil == Panel_Dialog_Trade_PriceRate_All or true == Panel_Dialog_Trade_PriceRate_All:GetShow() then
    return
  end
  PaGlobal_TradePriceRate_All:prepareOpen()
end
function HandleEventLUp_TradePriceRate_All_Close()
  if nil == Panel_Dialog_Trade_PriceRate_All or false == Panel_Dialog_Trade_PriceRate_All:GetShow() then
    return
  end
  PaGlobal_TradePriceRate_All:prepareClose()
end
function FromClient_TradePriceRate_All_List2UpdateRegionData(content, key)
  if nil == Panel_Dialog_Trade_PriceRate_All or false == Panel_Dialog_Trade_PriceRate_All:GetShow() then
    return
  end
  PaGlobal_TradePriceRate_All:list2UpdateRegionData(content, key)
end
function FromClient_TradePriceRate_All_List2UpdateGraphData(content, key)
  if nil == Panel_Dialog_Trade_PriceRate_All or false == Panel_Dialog_Trade_PriceRate_All:GetShow() then
    return
  end
  PaGlobal_TradePriceRate_All:list2UpdateGraphData(content, key)
end
function HandleEventLUp_TradePriceRate_All_ShowOtherTerritory(idx)
  if nil == idx or nil == Panel_Dialog_Trade_PriceRate_All then
    return
  end
  if nil ~= PaGlobal_TradePriceRate_All._ui._grpahSlotGroup then
    for index = 0, #PaGlobal_TradePriceRate_All._ui._grpahSlotGroup do
      if nil ~= PaGlobal_TradePriceRate_All._ui._grpahSlotGroup[index] then
        PaGlobal_TradePriceRate_All._ui._grpahSlotGroup[index].PriceRateBg:SetShow(false)
      end
    end
  end
  PaGlobal_TradePriceRate_All._currentTerritoryIndex = idx
  PaGlobal_TradePriceRate_All:pushKeyToGraphList2(idx, false)
end
function FromClient_TradePriceRate_All_UpdateGraph()
  if nil == Panel_Dialog_Trade_PriceRate_All or false == Panel_Dialog_Trade_PriceRate_All:GetShow() then
    return
  end
  local currentIdx = PaGlobal_TradePriceRate_All._currentTerritoryIndex
  if nil == self._ui._grpahSlotGroup then
    PaGlobal_TradePriceRate_All:pushKeyToGraphList2(currentIdx, false)
  else
    PaGlobal_TradePriceRate_All:pushKeyToGraphList2(currentIdx, true)
  end
end
function PaGlobalFunc_TardePriceRate_All_CalculateY(src, dest)
  if nil == Panel_Dialog_Trade_PriceRate_All or false == Panel_Dialog_Trade_PriceRate_All:GetShow() then
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
function PaGlobalFunc_TardePriceRate_All_ShowOpenGraphList(idx)
  PaGlobal_TradePriceRate_All._currentTerritoryIndex = idx
  PaGlobal_TradePriceRate_All:pushKeyToGraphList2(idx, false)
end
