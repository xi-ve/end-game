PaGlobal_VoiceChat = {
  _ui = {stc_mainBG = nil, txt_userID = nil},
  _speaker = {},
  _userID = {},
  _gapX = 0,
  _gapY = 0,
  _MaxPoolCount = 10,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Voice/Console/Panel_Widget_VoiceChat_1.lua")
runLua("UI_Data/Script/Widget/Voice/Console/Panel_Widget_VoiceChat_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_VoiceChatInit")
function FromClient_PaGlobal_VoiceChatInit()
  PaGlobal_VoiceChat:initialize()
end
