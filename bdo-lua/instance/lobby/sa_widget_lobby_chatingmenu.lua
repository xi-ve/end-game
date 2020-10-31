PaGlobal_Lobby_ChatingMenu = {
  _ui = {
    _Static_TapBG = nil,
    _Frame_Friend = nil,
    _Static_BottomMenuBG = nil,
    _RadioButton_FriendTap = nil,
    _RadioButton_Chat = nil,
    _Frame_1_Content = nil,
    _Frame_1_VerticalScroll = nil,
    _Frame_1_HorizontalScroll = nil,
    _RadioButton_FriendsGroup_Template = nil,
    _RadioButton_FriendsList_Template = nil,
    _Static_FriendProfileslot = nil,
    _Static_FriendNoImage = nil,
    _Static_FriendProfile = nil,
    _StaticText_FriendID = nil,
    _StaticText_FriendOnline = nil,
    _StaticText_MessageCountValue = nil,
    _RadioButton_ChatGroupTemplate = nil,
    _StaticText_Chat_Sender = nil,
    _StaticText_Chat_Content = nil,
    _Frame_1_VerticalScroll_UpButton = nil,
    _Frame_1_VerticalScroll_DownButton = nil,
    _Frame_1_VerticalScroll_CtrlButton = nil,
    _Frame_1_HorizontalScroll_UpButton = nil,
    _Frame_1_HorizontalScroll_DownButton = nil,
    _Frame_1_HorizontalScroll_CtrlButton = nil,
    _Button_Chat = nil,
    _Static_ChatIcon = nil,
    _StaticText_InviteIcon = nil,
    _Button_Search = nil,
    _Static_SearchIcon = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_ChatingMenu_1.lua")
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_ChatingMenu_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_Lobby_ChatingMenu_Init")
function FromClient_luaLoadComplete_Lobby_ChatingMenu_Init()
  PaGlobal_Lobby_ChatingMenu:initialize()
end
