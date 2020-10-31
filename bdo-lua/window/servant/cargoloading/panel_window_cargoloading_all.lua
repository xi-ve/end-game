PaGlobal_CargoLoading = {
  _eSlotType = {
    inventory = 0,
    servant = 1,
    loopCount = 1
  },
  _eMySlot = {
    myInven = 0,
    myWarehouse = 1,
    loopCount = 1
  },
  _ui = {
    _btn_close = nil,
    _rdo_MyBag = nil,
    _rdo_myWarehouse = nil,
    _stc_selectLine = nil,
    _stc_warehouseInvenBG = nil,
    _scroll_warehouse = nil,
    _chk_sortButton = nil,
    _txt_itemCount_warehouse = nil,
    _txt_myShip = nil,
    _stc_shipInvenBG = nil,
    _scroll_ship = nil,
    _progress_weightBar = nil,
    _txt_weightValue = nil,
    _txt_itemCount_ship = nil,
    _txt_guideBox = nil,
    _btn_confirm = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCooltime = true,
    createExpiration = true,
    createExpirationBG = true,
    createExpiration2h = true,
    createClassEquipBG = true,
    createEnduranceIcon = true,
    createCash = true,
    createBagIcon = true,
    createEnduranceIcon = true,
    createCheckBox = true
  },
  _config = {
    slotCount_w = 0,
    slotCount_s = 0,
    slotCols_w = 8,
    slotCols_s = 5,
    slotRows_w = 7,
    slotRows_s = 7,
    slotStartX = 10,
    slotStartY = 10,
    slotGapX = 50,
    slotGapY = 50
  },
  _blankSlots = nil,
  _slots = nil,
  _currentMySlotType = 0,
  _currentWaypointKey = 0,
  _currentRegionName = "",
  _startSlotIndex_warehouse = 0,
  _startSlotIndex_ship = 0,
  _maxCount_warehouse = 0,
  _maxCount_ship = 0,
  _startSlot_warehouse = 0,
  _startSlot_ship = 0,
  _servantActorKey = 0,
  _slotNilEffect = {},
  _clickedSlotType = nil,
  _rdoButtonsSizeX = nil,
  _isFirstSetting = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Servant/CargoLoading/Panel_Window_CargoLoading_ALL_1.lua")
runLua("UI_Data/Script/Window/Servant/CargoLoading/Panel_Window_CargoLoading_ALL_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CargoLoading_Init")
function FromClient_CargoLoading_Init()
  PaGlobal_CargoLoading:initialize()
end
