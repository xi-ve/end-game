PaGlobal_Extraction_All = {
  _ui = {
    btn_exit = nil,
    btn_system = nil,
    btn_cloth = nil,
    btn_crystal = nil,
    btn_caphras = nil,
    btn_enchantStone = nil,
    stc_selectLine = nil
  },
  _ui_pc = {},
  _ui_console = {
    btn_LB = nil,
    btn_RB = nil,
    btn_A = nil
  },
  _initialize = false,
  _isConsole = false,
  _screenX = nil,
  _screenY = nil,
  _btnTable = {},
  _funcTable = {},
  _funcButtonCount = 1,
  _currentTabIndex = 1
}
runLua("UI_Data/Script/Window/Extraction/Panel_Window_Extraction_All_1.lua")
runLua("UI_Data/Script/Window/Extraction/Panel_Window_Extraction_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Extraction_AllInit")
function FromClient_Extraction_AllInit()
  PaGlobal_Extraction_All:initialize()
end
