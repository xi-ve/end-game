PaGlobal_MusicShare_All = {
  _ui = {
    _txt_titleBar = nil,
    _btn_close = nil,
    _btn_refresh = nil,
    _webControl = nil
  },
  _web_basicPos = {x = 32, y = 83},
  _web_basicSize = {x = 1100, y = 630},
  _panel_basicSize = {x = 1164, y = 780},
  _initialize = false,
  _musicIndex = -1
}
runLua("UI_Data/Script/Window/Composition/Panel_MusicShare_All_1.lua")
runLua("UI_Data/Script/Window/Composition/Panel_MusicShare_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MusicShare_All_Init")
function FromClient_MusicShare_All_Init()
  PaGlobal_MusicShare_All:initialize()
end
