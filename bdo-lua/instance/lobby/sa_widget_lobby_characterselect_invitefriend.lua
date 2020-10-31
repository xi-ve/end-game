PaGlobal_Lobby_CharacterSelect_InviteFriend = {
  _ui = {
    _Static_InviteGroup = nil,
    _Static_InviteMenu = nil,
    _Static_FriendsListGroup = nil,
    _RadioButton_AddFriend = nil,
    _RadioButton_AutoMating = nil,
    _Static_TitleBar = nil,
    _List2_1 = nil,
    _StaticText_FriendsListTitle = nil,
    _Button_FriendsListClose = nil,
    _List2_1_Content = nil,
    _List2_1_VerticalScroll = nil,
    _List2_1_HorizontalScroll = nil,
    _RadioButton_1 = nil,
    _StaticText_Onoffline = nil,
    _List2_1_VerticalScroll_UpButton = nil,
    _List2_1_VerticalScroll_DownButton = nil,
    _List2_1_VerticalScroll_CtrlButton = nil,
    _List2_1_HorizontalScroll_UpButton = nil,
    _List2_1_HorizontalScroll_DownButton = nil,
    _List2_1_HorizontalScroll_CtrlButton = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_InviteFriend_1.lua")
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_InviteFriend_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_Lobby_CharacterSelect_InviteFriend_Init")
function FromClient_luaLoadComplete_Lobby_CharacterSelect_InviteFriend_Init()
  PaGlobal_Lobby_CharacterSelect_InviteFriend:initialize()
end
