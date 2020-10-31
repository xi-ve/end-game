PaGlobal_SA_Widget_Lobby_BG = {
  _ui = {},
  _initialize = false
}
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_BG_1.lua")
runLua("UI_Data/Script/Instance//Lobby/SA_Widget_Lobby_BG_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_Lobby_BGInit")
function FromClient_SA_Widget_Lobby_BGInit()
  PaGlobal_SA_Widget_Lobby_BG:initialize()
end
