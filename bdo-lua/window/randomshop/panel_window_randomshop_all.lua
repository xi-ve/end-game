PaGlobal_RandowShop_All = {
  _ui = {
    stc_titleBg = nil,
    stc_mainBg = nil,
    stc_imageArea = nil,
    stc_itemSlot = nil,
    stc_reserveIcon = nil,
    stc_infoArea = nil,
    txt_money = nil,
    txt_myWp = nil,
    txt_itemName = nil,
    mtxt_reserveTime = nil,
    stc_selectMoneyBg = nil,
    radio_inven = nil,
    txt_invenMoney = nil,
    radio_warehouse = nil,
    txt_warehouseMoney = nil
  },
  _ui_pc = {
    stc_buttonAreaBg = nil,
    btn_close = nil,
    btn_question = nil,
    btn_reserve = nil,
    btn_other = nil,
    btn_buy = nil
  },
  _ui_console = {
    stc_guideAreaBg = nil,
    btn_guideOther = nil,
    btn_guideReserve = nil,
    btn_guideBuy = nil,
    btn_guideBack = nil,
    btn_guideDetail = nil
  },
  _territoryKeyToWaypointKey = {
    [0] = 1,
    [1] = 301,
    [2] = 601,
    [3] = 1101,
    [4] = 1301,
    [6] = 1623,
    [5] = 1395,
    [7] = 1649,
    [8] = 1691
  },
  _isReserveContentOpen = true,
  _shopTypeNum = nil,
  _priceRate = nil,
  _selectSlotNo = nil,
  _randomShopItemPrice = 0,
  _panelSizeY = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/RandomShop/Panel_Window_RandomShop_All_1.lua")
runLua("UI_Data/Script/Window/RandomShop/Panel_Window_RandomShop_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobalRandowShopAll_Init")
function FromClient_PaGlobalRandowShopAll_Init()
  PaGlobal_RandowShop_All:initialize()
end
