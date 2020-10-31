PaGlobal_House_InstallationList_All = {
  _ui = {
    _stc_backGround = nil,
    _txt_titleText = nil,
    _rdo_tabMenu = {},
    _console = {
      _stc_LBKey = nil,
      _stc_RBKey = nil,
      _txt_tabTooltip = nil,
      _stc_tooltipArrow = nil,
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
    _combo_categoryType = nil,
    _edit_searchBox = nil,
    _txt_searchIcon = nil,
    _stc_itemListBg = nil,
    _stc_itemTemplete = nil,
    _scroll_itemList = nil,
    _pc = {
      _btn_resetFurniture = nil,
      _btn_exit = nil,
      _btn_buyAll = nil,
      _btn_resetAll = nil
    },
    _stc_cartItemListBg = nil,
    _stc_cartItemTemplete = nil,
    _scroll_cartItemList = nil,
    _txt_housingPointValue = nil,
    _txt_pearlPointValue = nil,
    _txt_priceValue = nil
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
  _eTabMenu = {
    All = 0,
    Goods = 1,
    Furniture = 2,
    BaseMaterial = 3,
    Tools = 4,
    Count = 5
  },
  _eCategory = {
    All = 0,
    AllFurniture = 1,
    Dresser = 2,
    Wardrobe = 3,
    Table = 4,
    Chair = 5,
    Bookcase = 6,
    Bed = 7,
    AllGoods = 8,
    OntheTable = 9,
    Floor = 10,
    Wall = 11,
    Ceiling = 12,
    AllBaseMaterial = 13,
    WallPaper = 14,
    FloorMaterial = 15,
    AllTools = 16,
    Cooking = 17,
    Alchemy = 18,
    Count = 19
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createCash = true,
    createCash = true
  },
  _categoryIndex = {},
  _categoryText = {},
  _categoryList = nil,
  _maxItemDataCount = 0,
  _startItemSlotIndex = 0,
  _slotUIPool = {},
  _itemSlotCol = 8,
  _itemSlotRow = 7,
  _itemStartPos = {x = 0, y = 0},
  _maxCartItemDataCount = 0,
  _startCartItemSlotIndex = 0,
  _slotUICartPool = {},
  _cartItemSlotCol = 8,
  _cartItemSlotRow = 5,
  _cartItemStartPos = {x = 0, y = 0},
  _isConsole = false,
  _currentTabIndex = 0,
  _currentItemIndex = 0,
  _deleteItemIdx = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_List_All_1.lua")
runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_List_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_House_InstallationList_All_Init")
function FromClient_House_InstallationList_All_Init()
  PaGlobal_House_InstallationList_All:initialize()
end
