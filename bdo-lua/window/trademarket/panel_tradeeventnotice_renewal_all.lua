PaGlobal_TradeEventNotice_All = {
  _ui = {
    _stc_TitleBG = nil,
    _stc_BackImage = nil,
    _btn_Close = nil,
    _chk_PopUp = nil,
    _stcText_TradeEvent = nil,
    _btn_TradeEvent_Navi = nil,
    _stc_TradeEventDescBG = nil,
    _stc_TradeEventDown = nil,
    _rdo_ShowIcon = nil,
    _rdo_ShowName = nil,
    _stcText_TerritorySupply = nil,
    _stc_TerritorySupplyBG1 = nil,
    _stcText_TerritorySupply_Town = nil,
    _stc_ItemSlotBG = nil,
    _stcText_TerritorySupplyAlert = nil,
    _stcText_TerritorySupply_ItemName = nil,
    _btn_Navi = nil,
    _stc_ConsoleGuide = nil,
    _stcText_Navi = nil,
    _stcText_Close = nil,
    _staticTextSupplyTownList = {},
    _btnSupplyNaviList = {},
    _staticSupplyBGList = {},
    _staticSupplyItemBGList = {},
    _staticSupplyItemList = {},
    _staticTextSupplyItemNameList = {}
  },
  _ETabState = {_icon = 0, _name = 1},
  _ETerritory = {
    _balenos = 0,
    _serendia = 1,
    _calpheon = 2,
    _media = 3,
    _valencia = 4,
    _margoria = 5,
    _kamasylvia = 6,
    _drigan = 7
  },
  _itemSlotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true
  },
  _tradeEventNpcRegionKey = {
    [40010] = 5,
    [40028] = 9,
    [40715] = 88,
    [41051] = 32,
    [41090] = 52,
    [42005] = 310,
    [42013] = 311,
    [42026] = 312,
    [42301] = 120,
    [43010] = 107,
    [44010] = 202,
    [44110] = 221,
    [40025] = 16,
    [41223] = 56,
    [43449] = 313,
    [50418] = 110,
    [50493] = 212
  },
  _supplyNpcRegionKey = {},
  _territoryName = {},
  _prevTab = _icon,
  _supplySpawnType = CppEnums.SpawnType.eSpawnType_TerritorySupply,
  _columnNum = 2,
  _nameColumnNum = 2,
  _territoryCount = 2,
  _maxItemCount = 6,
  _needTradeEventUpdate = true,
  _needSupplyUpdate = true,
  _lineGapY = nil,
  _supplyItemCount = {},
  _supplyItemKeyList = {},
  _stc_ListBG_OriginSizeY = nil,
  _isConsole = nil,
  _keyGuide = {},
  _initialize = false
}
runLua("UI_Data/Script/Window/Trademarket/Panel_TradeEventNotice_Renewal_All_1.lua")
runLua("UI_Data/Script/Window/Trademarket/Panel_TradeEventNotice_Renewal_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_TradeEventNotice_Init")
function FromClient_TradeEventNotice_Init()
  PaGlobal_TradeEventNotice_All:initialize()
end
