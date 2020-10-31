PaGlobal_CaveSeal_All = {
  _eType = {carve = 0, reset = 1},
  _ui = {
    _stc_title = nil,
    _btn_close = nil,
    _stc_subBg = nil,
    _txt_desc = nil,
    _list2 = nil,
    _pc = {_btn_seal = nil, _btn_unseal = nil},
    _console = {
      _stc_bottomBg = nil,
      _txt_key_A = nil,
      _txt_key_B = nil,
      _txt_key_X = nil,
      _txt_key_Y = nil
    }
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createEnduranceIcon = true
  },
  _slotList = {},
  _selectSlot = 0,
  _mouseOnSlot = 0,
  _inventoryTypeUseItem = 0,
  _slotNoUseItem = 0,
  _sealType = 0,
  _key_spanSize_Y = {x = 0, y = 0},
  _key_gapSize = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/CarveSeal/Panel_Window_CarveSeal_All_1.lua")
runLua("UI_Data/Script/Window/CarveSeal/Panel_Window_CarveSeal_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CaveSeal_All_Init")
function FromClient_CaveSeal_All_Init()
  PaGlobal_CaveSeal_All:initialize()
end
