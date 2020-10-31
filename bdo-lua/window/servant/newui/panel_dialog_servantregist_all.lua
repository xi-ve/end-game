PaGlobal_ServantRegist_All = {
  _ui = {
    _stc_Title = nil,
    _stc_Bg = nil,
    _txt_Desc = nil,
    _stc_ItemSlotBg_1 = nil,
    _stc_ItemSlotBg_2 = nil,
    _stc_ItemSlotBg_3 = nil,
    _stc_ItemSlotBg_4 = nil,
    _stc_ItemSlotBg_5 = nil,
    _stc_ItemSlotBg_6 = nil,
    _stc_ItemSlotBg_7 = nil,
    _txt_RegistItemName = nil,
    _Edit_Naming = nil,
    _pc = {
      _btn_Close = nil,
      _btn_Left = nil,
      _btn_Right = nil,
      _stc_bottomBtn = nil,
      _btn_Confirm = nil,
      _btn_Cancel = nil
    },
    _console = {
      _stc_LT_console = nil,
      _stc_RT_console = nil,
      _stc_bottomBg = nil,
      _stc_X_console = nil,
      _stc_A_console = nil,
      _stc_B_console = nil
    },
    _txt_Hp = nil,
    _txt_Stamina = nil,
    _txt_Weight = nil,
    _txt_LifeSpan = nil,
    _txt_Speed = nil,
    _txt_Accel = nil,
    _txt_Turn = nil,
    _txt_Brake = nil
  },
  slotConfig = {
    createIcon = true,
    createBorder = true,
    createCash = true
  },
  _defaultPanelSizeY = 0,
  _currentInvenType = nil,
  _currentInvenSlotNo = nil,
  _registerType = nil,
  _maxInvenCount = nil,
  _SHOWSLOTCOUNT = 7,
  _mapaeInfoTable = {},
  _itemSlotTable = {},
  _isRegister = false,
  _totalSlotCount = nil,
  _currentSlotPage = nil,
  _currentIndexConsole = 0,
  _maxIndexConsole = 0,
  _maxPage = nil,
  _selectedSlotNo = nil,
  _selectIdx = 0,
  _isEditing = false,
  _isConsole = false,
  _initailize = false
}
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantRegist_All_1.lua")
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantRegist_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ServantRegist_All_Init")
function FromClient_ServantRegist_All_Init()
  PaGlobal_ServantRegist_All:initialize()
end
