PaGlobal_TradePriceRate_All = {
  _ui = {
    _btn_Close_PC = nil,
    _list2_Territory = nil,
    _list2_TerritoryContent = nil,
    _list2_TerritoryRadioBtn = nil,
    _stc_SelectedItemBg = nil,
    _icon_SelectedItem = nil,
    _txt_SelectedItemName = nil,
    _list2_PriceRate = nil,
    _list2_PriceRateContent = nil,
    _list2_PriceRateBg = nil,
    _list2_PriceRateRegionName = nil,
    _list2_PriceRatePrice = nil,
    _list2_PriceRateOriginPrice = nil,
    _list2_PriceRateGraphBg = nil,
    _list2_PriceRateCenterLine = nil,
    _list2_PriceRateLowestLine = nil,
    _list2_PriceRateHighestLine = nil,
    _list2_PriceRateCurrentPoint = nil,
    _grpahSlotGroup = {}
  },
  slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = false,
    createCash = true
  },
  _minPricePosY = 9999,
  _maxPricePosY = -9999,
  _minPricePosX = -1,
  _maxPricePosX = -1,
  _graphIntervalValue = 8,
  _slotCols = 3,
  _graphBackSizeY = 0,
  _trendIndex = nil,
  _initialize = false,
  _isConsole = false,
  _territoryCount = nil,
  _currentTerritoryIndex = nil,
  _maxGraphSlotCnt = 0
}
runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_PriceRate_All_1.lua")
runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_PriceRate_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_TradePriceRateAll_init")
function FromClient_TradePriceRateAll_init()
  PaGlobal_TradePriceRate_All:initialize()
end
