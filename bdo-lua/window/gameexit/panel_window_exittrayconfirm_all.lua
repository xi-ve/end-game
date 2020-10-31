PaGlobal_ExitTrayConfirm_All = {
  _ui = {
    stc_title = nil,
    stc_mainBg = nil,
    txt_gameExit = nil,
    txt_trayHelp = nil,
    chk_tray = nil,
    btn_confirm = nil,
    btn_cancle = nil
  },
  _openType = {EXIT = 0, TRAY = 1},
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/GameExit/Panel_Window_ExitTrayConfirm_All_1.lua")
runLua("UI_Data/Script/Window/GameExit/Panel_Window_ExitTrayConfirm_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ExitTrayConfirm_All_Init")
function FromClient_ExitTrayConfirm_All_Init()
  PaGlobal_ExitTrayConfirm_All:initialize()
end
