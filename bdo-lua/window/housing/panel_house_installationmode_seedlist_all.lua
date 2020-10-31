PaGlobal_Farm_InstallationList_All = {
  _eTabType = {
    all = 0,
    seed = 1,
    material = 2
  },
  _eBasicType = {
    gatherSeed = 0,
    temperature = 1,
    humidity = 2,
    undergroundWater = 3,
    moisture = 4,
    health = 5
  },
  _eManageType = {
    scarecrow = 0,
    waterway = 1,
    pruning = 2,
    pestControl = 3,
    feed = 4,
    bugs = 5
  },
  _eHarvestType = {
    fruitHarvest = 0,
    harvest = 1,
    breedImprovement = 2
  },
  _eGuideTab = {crops = 0, livestock = 1},
  _ui = {
    _pc = {_btn_restoreAll = nil, _btn_exit = nil},
    _console = {
      _stc_LBKey = nil,
      _stc_RBKey = nil,
      _txt_closeKey = nil,
      _txt_selectKey = nil,
      _txt_buyKey = nil,
      _stc_consoleKeyBG = nil
    },
    _keyGuide = {
      _txt_RS_click = nil,
      _txt_RS_updown = nil,
      _txt_RS_leftright = nil,
      _txt_RS = nil,
      _txt_LS = nil,
      _txt_LB_RB = nil,
      _txt_LT_RT = nil,
      _txt_Y = nil,
      _txt_X = nil,
      _txt_A = nil,
      _txt_B = nil
    },
    _rdo_tabMenu = {},
    _stc_selectLine = nil,
    _edit_searchBox = nil,
    _txt_searchIcon = nil,
    _stc_itemListBg = nil,
    _stc_itemTemplete = nil,
    _scroll_itemList = nil,
    _stc_guideBg = nil,
    _rdo_basicButtons = {},
    _rdo_manageButtons = {},
    _rdo_harvestButtons = {},
    _frame_guideDescBg = nil,
    _frame_VScroll = nil,
    _frame_VScroll_Console = nil,
    _txt_descTitle = nil,
    _txt_desc = nil
  },
  _keyGuideString = {
    build = nil,
    install = nil,
    moveBuild = nil,
    changeWidthBuild = nil,
    changeHeightBuild = nil,
    zoomInOut = nil,
    changeCamMode = nil,
    zoomInOutAndHeight = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createCash = true,
    createCash = true
  },
  _slotUIPool = {},
  _itemSlotCol = 8,
  _itemSlotRow = 7,
  _startItemSlotIndex = 0,
  _maxItemDataCount = 0,
  _itemStartPos = {x = 0, y = 0},
  _deleteItemIdx = 0,
  _basicTitle = {},
  _basicDesc = {},
  _manageTitle = {},
  _manageDesc = {},
  _havestTitle = {},
  _havestDesc = {},
  _isConsole = false,
  _currentTabIndex = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_SeedList_All_1.lua")
runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_SeedList_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Farm_InstallationList_All_Init")
function FromClient_Farm_InstallationList_All_Init()
  PaGlobal_Farm_InstallationList_All:initialize()
end
