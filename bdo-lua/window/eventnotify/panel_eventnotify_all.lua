PaGlobal_EventNotify_All = {
  _ui = {
    _txt_titleBar = nil,
    _btn_close = nil,
    _btn_refresh = nil,
    _webControl = nil,
    _stc_keyGuideBG = nil,
    _stc_keyGuideB = nil
  },
  _web_basicPos = {x = 32, y = 83},
  _web_basicSize = {x = 636, y = 494},
  _web_englishPos = {x = 20, y = 65},
  _web_englishSize = {x = 810, y = 719},
  _panel_basicSize = {x = 656, y = 564},
  _panel_englishSize = {x = 830, y = 789},
  _initialize = false
}
runLua("UI_Data/Script/Window/EventNotify/Panel_EventNotify_All_1.lua")
runLua("UI_Data/Script/Window/EventNotify/Panel_EventNotify_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_EventNotify_All_Init")
function FromClient_EventNotify_All_Init()
  PaGlobal_EventNotify_All:initialize()
end
