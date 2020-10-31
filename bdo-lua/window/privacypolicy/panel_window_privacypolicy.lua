PaGlobal_PrivacyPolicy = {
  _ui = {_web_privacyPolicy = nil},
  _screenSizeX = nil,
  _screenSizeY = nil,
  _initialize = false,
  _isType = 0,
  _isLogin = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_PrivacyPolicy")
runLua("UI_Data/Script/Window/PrivacyPolicy/Panel_Window_PrivacyPolicy_1.lua")
runLua("UI_Data/Script/Window/PrivacyPolicy/Panel_Window_PrivacyPolicy_2.lua")
function FromClient_PrivacyPolicy()
  PaGlobal_PrivacyPolicy:initialize()
end
