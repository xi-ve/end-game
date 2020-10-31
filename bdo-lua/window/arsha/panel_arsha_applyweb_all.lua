PaGlobal_ArshaApplyWeb_All = {
  _ui = {
    _txt_titleBar = nil,
    _btn_close = nil,
    _webControl = nil,
    _btn_Refresh = nil
  },
  _web_basicPos = {x = 32, y = 83},
  _web_basicSize = {x = 800, y = 640},
  _web_englishPos = {x = 20, y = 65},
  _web_englishSize = {x = 810, y = 719},
  _panel_basicSize = {x = 700, y = 609},
  _panel_englishSize = {x = 850, y = 806},
  _initialize = false
}
runLua("UI_Data/Script/Window/Arsha/Panel_Arsha_ApplyWeb_All_1.lua")
runLua("UI_Data/Script/Window/Arsha/Panel_Arsha_ApplyWeb_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ArshaApplyWeb_All_Init")
function FromClient_ArshaApplyWeb_All_Init()
  PaGlobal_ArshaApplyWeb_All:initialize()
end
