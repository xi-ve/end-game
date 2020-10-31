PaGlobal_Lobby_CharacterSelect_FriendsSlot = {
  _ui = {
    _Static_SlotGroup = nil,
    _Button_Invite_1 = nil,
    _Button_Wait_1 = nil,
    _Button_Ready_1 = nil,
    _Button_Invite_2 = nil,
    _Button_Wait_2 = nil,
    _Button_Ready_2 = nil,
    _Button_Invite_3 = nil,
    _Button_Wait_3 = nil,
    _Button_Ready_3 = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_FriendsSlot_1.lua")
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_FriendsSlot_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_Lobby_CharacterSelect_FriendsSlot_Init")
function FromClient_luaLoadComplete_Lobby_CharacterSelect_FriendsSlot_Init()
  PaGlobal_Lobby_CharacterSelect_FriendsSlot:initialize()
end
