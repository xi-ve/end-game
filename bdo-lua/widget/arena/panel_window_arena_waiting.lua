PaGlobal_Arena_Waiting = {
  _ui = {
    btn_close_pc = nil,
    txt_total = nil,
    txt_myTurn = nil,
    btn_refresh = nil,
    btn_close = nil,
    txt_desc = nil,
    stc_consoleBG = nil
  },
  _isConsole = ToClient_isConsole(),
  _initialize = false
}
runLua("UI_Data/Script/Widget/Arena/Panel_Window_Arena_Waiting_1.lua")
runLua("UI_Data/Script/Widget/Arena/Panel_Window_Arena_Waiting_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Arena_WaitingInit")
function FromClient_Arena_WaitingInit()
  PaGlobal_Arena_Waiting:initialize()
end
