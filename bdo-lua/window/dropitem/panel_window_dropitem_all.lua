PaGlobal_DropItem_All = {
  groupType = {
    weapon = 0,
    armor = 1,
    acc = 2,
    etc = 3,
    loopCount = 3
  },
  _ui = {
    _stcText_Title = nil,
    _list2Region = nil,
    _stc_bottomDescBg = nil,
    _txt_bottomDesc = nil,
    _static_1 = nil,
    _stcText_SelectedRegionName = nil,
    _stcText_NeedAp = nil,
    _frame_DropItem = nil,
    _frame_Content = nil,
    _stc_itemGroupUi = {},
    _stc_slotTempleteBg = {},
    _scroll = nil,
    _stc_naviIcon = nil,
    _slotBg = {},
    _slot = {
      [0] = {},
      [1] = {},
      [2] = {},
      [3] = {}
    },
    _pc = {_btn_close = nil, _btn_autoNaviButton = nil},
    _console = {
      _stc_keyGuideBG = nil,
      _txt_selectKey = nil,
      _txt_closeKey = nil,
      _txt_wayPointKey = nil
    }
  },
  _slotConfig = {createIcon = true, createBorder = true},
  _keyGuides = nil,
  _itemKeyByType = {},
  _selectedRegionKey = nil,
  _maxSlot = 40,
  _panelSizeY = 0,
  _currentButton = nil,
  _isTargetChange = false,
  _isConsole = nil,
  _initialize = nil
}
runLua("UI_Data/Script/Window/DropItem/Panel_Window_Dropitem_All_1.lua")
runLua("UI_Data/Script/Window/DropItem/Panel_Window_Dropitem_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Panel_Window_Dropitem_All_Init")
function FromClient_Panel_Window_Dropitem_All_Init()
  PaGlobal_DropItem_All:initialize()
end
