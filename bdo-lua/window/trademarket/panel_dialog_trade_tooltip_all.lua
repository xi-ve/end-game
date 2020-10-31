PaGlobal_TradeMarketItemToolTip_All = {
  _ui = {
    _stc_SlotBg = nil,
    _txt_ItemName = nil,
    _stc_GraphBg = nil,
    _stc_LowestPoint = nil,
    _stc_HighestPoint = nil,
    _stc_CurrentPoint = nil,
    _stc_CenterLine = nil,
    _txt_Weight = nil,
    _txt_Desc = nil,
    _txt_OriginalPrice = nil,
    _txt_OriginalPriceValue = nil
  },
  slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = false,
    createCash = true
  },
  _tradeGraphMode = {eGraphMode_NormalShopGraph = 0, eGraphMode_TendGraph = 1},
  _originalTextSizeY = nil,
  _originalPanelSizeY = nil,
  _maxPricePosX = -1,
  _minPricePosX = -1,
  _maxPricePosY = 0,
  _minPricePosY = 9999999,
  _graphIntervalValue = 8,
  _currentItemKey = nil,
  _currentGraphMode = nil,
  _originWeightText = nil,
  _initialize = false,
  _isConsole = false
}
runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_Tooltip_All_1.lua")
runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_Tooltip_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_TradeTooltip_init")
function FromClient_TradeTooltip_init()
  PaGlobal_TradeMarketItemToolTip_All:initialize()
end
