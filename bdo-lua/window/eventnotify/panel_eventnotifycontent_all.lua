PaGlobal_EventNotifyContent_All = {
  _ui = {
    _btn_close = nil,
    _btn_Sticker = nil,
    _webControl = nil,
    _stc_keyGuideBG = nil,
    _stc_keyGuideB = nil
  },
  _webPos = {x = 20, y = 58},
  _webSize = {x = 817, y = 600},
  _initialize = false
}
runLua("UI_Data/Script/Window/EventNotify/Panel_EventNotifyContent_All_1.lua")
runLua("UI_Data/Script/Window/EventNotify/Panel_EventNotifyContent_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_EventNotifyContent_All_Init")
function FromClient_EventNotifyContent_All_Init()
  PaGlobal_EventNotifyContent_All:initialize()
end
