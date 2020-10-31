PaGlobal_Lobby_CharacterSelect_ItemShop = {
  _ui = {
    _static_MainBG = nil,
    _closeButton = nil,
    _stc_blackBG = nil,
    _frame = nil,
    _frameContent = nil,
    _frameName = nil,
    _itemList = {},
    _itemBG = {},
    _static_BottomBG = nil,
    _static_filterBG = nil,
    _static_ItemSlotGroup = nil,
    _static_PointGroup = nil,
    _staticText_PointValue = nil,
    _button_ItemSlotsBG = {},
    _button_ItemSlots = {},
    _button_ItemButtons = {},
    _itemIcons = {},
    _button_FilterButtons = {},
    _stc_Titlebars = {},
    _txt_notice = nil,
    _stc_nakMsg = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = false,
    createCount = true,
    createCooltime = false,
    createCooltimeText = false,
    createEnchant = false
  },
  _filterType = {
    ALL = 1,
    ITEM = 2,
    SUBSKILL = 3,
    MAGICSCROLL = 4
  },
  _itemType = {
    ITEM = 0,
    SUBSKILL = 1,
    MAGICSCROLL = 2
  },
  _slotTotalCount = {},
  _slotCurrentCount = {},
  _slotAreaSizeY = {},
  _selectedFilter = 1,
  _curAddItemCnt = 0,
  _selectedSlotNo = 0,
  _maxItemTypeCount = 3,
  _initialize = false
}
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_ItemShop_1.lua")
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_ItemShop_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_Lobby_CharacterSelect_ItemShop_Init")
function FromClient_luaLoadComplete_Lobby_CharacterSelect_ItemShop_Init()
  PaGlobal_Lobby_CharacterSelect_ItemShop:initialize()
end
