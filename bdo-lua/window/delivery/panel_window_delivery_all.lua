PaGlobal_Delivery_All = {
  _ui = {
    stc_topBG = nil,
    _pc = {
      btn_close = nil,
      btn_question = nil,
      btn_receiveAll = nil,
      btn_delivery = nil
    },
    _console = {
      stc_LBkey = nil,
      stc_RBkey = nil,
      stc_LTkey = nil,
      stc_RTkey = nil,
      stc_bottomBG = nil,
      txt_recive = nil,
      txt_reciveAll = nil,
      txt_close = nil,
      txt_send = nil,
      txt_select = nil,
      txt_cancel = nil
    },
    stc_radioBtnBG = nil,
    radio_delivery = nil,
    radio_send = nil,
    stc_mainSelectBar = nil,
    stc_deliveryBG = nil,
    radio_transList = nil,
    radio_allTransList = nil,
    stc_subSelectBar = nil,
    stc_deliveryListBG = nil,
    list_delivery = nil,
    txt_empty = nil,
    stc_sendBG = nil,
    combo_destination = nil,
    combo_carriage = nil,
    txt_carriageCountValue = nil,
    txt_weightValue = nil,
    txt_possibleCountValue = nil,
    stc_feeBG = nil,
    txt_totalFeeValue = nil,
    stc_itemListBG = nil,
    stc_itemSlotTemplete = nil,
    stc_lockIcon = nil,
    stc_DescBG = nil,
    txt_desc = nil
  },
  slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createEnduranceIcon = true
  },
  config = {
    slotCount = 20,
    slotCols = 7,
    slotRows = 0,
    slotStartX = 0,
    slotStartY = 10,
    slotGap = 10
  },
  _preTransListClick = false,
  slots = Array.new(),
  slotBGs = Array.new(),
  usableCount = 0,
  _scrollIndex = -1,
  _selectDestination = -1,
  _selectDeliverer = -1,
  _selectWaypointKey = -1,
  _currentWaypointKey = -1,
  _adjustConsolePosY = 100,
  _originPanelPosY = 133,
  _originPanelSizeY = 0,
  _originBgSizeY = 0,
  _originDescBgSizeY = 0,
  _originSendBgSizeY = 0,
  _isDeliveyCheck = false,
  _isTransList = false,
  _selectCarriageKey = {},
  _initialize = false
}
runLua("UI_Data/Script/Window/Delivery/Panel_Window_Delivery_All_1.lua")
runLua("UI_Data/Script/Window/Delivery/Panel_Window_Delivery_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_DeliveryAll_luaLoadComplete")
function FromClient_DeliveryAll_luaLoadComplete()
  PaGlobal_Delivery_All:initialize()
end
