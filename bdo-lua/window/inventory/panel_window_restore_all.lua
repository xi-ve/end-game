PaGlobal_Restore_All = {
  _ui = {
    _stc_restoreNum = nil,
    _btn_close = nil,
    _btn_restore = nil,
    _list2 = nil
  },
  _ui_console = {
    _stc_keyGuideBg = nil,
    _stc_keyGuideA = nil,
    _stc_keyGuideB = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true
  },
  _selectSlotNo = nil,
  _restoreType = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Inventory/Panel_Window_Restore_All_1.lua")
runLua("UI_Data/Script/Window/Inventory/Panel_Window_Restore_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Restore_All_Init")
function FromClient_Restore_All_Init()
  PaGlobal_Restore_All:initialize()
end
