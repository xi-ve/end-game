PaGlobal_Composition_All = {
  _ui = {
    _txt_titleBar = nil,
    _btn_close = nil,
    _btn_refresh = nil,
    _webControl = nil
  },
  _web_basicPos = {x = 32, y = 83},
  _web_basicSize = {x = 1600, y = 800},
  _panel_basicSize = {x = 1664, y = 915},
  _initialize = false,
  _tempSaveTimer = 60,
  _updateTempSaveTime = 0
}
runLua("UI_Data/Script/Window/Composition/Panel_Composition_All_1.lua")
runLua("UI_Data/Script/Window/Composition/Panel_Composition_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Composition_All_Init")
function FromClient_Composition_All_Init()
  PaGlobal_Composition_All:initialize()
end
