PaGlobal_Lobby_MainMenu = {
  _ui = {_playButton = nil, _partyButton = nil},
  _initialize = false,
  _isOpenLobbyMainUI = false
}
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_MainMenu_1.lua")
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_MainMenu_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_Lobby_MainMenu_Init")
function FromClient_luaLoadComplete_Lobby_MainMenu_Init()
  PaGlobal_Lobby_MainMenu:initialize()
end
