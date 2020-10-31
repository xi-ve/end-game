function PaGlobal_Lobby_ChatingMenu:initialize()
  if true == self._initialize then
    return
  end
  if nil == SA_Widget_Lobby_ChatingMenu then
    return
  end
  self._ui._Static_TapBG = UI.getChildControl(SA_Widget_Lobby_ChatingMenu, "Static_TapBG")
  self._ui._Frame_Friend = UI.getChildControl(SA_Widget_Lobby_ChatingMenu, "Frame_Friend")
  self._ui._Static_BottomMenuBG = UI.getChildControl(SA_Widget_Lobby_ChatingMenu, "Static_BottomMenuBG")
  self._ui._RadioButton_FriendTap = UI.getChildControl(self._ui._Static_TapBG, "RadioButton_FriendTap")
  self._ui._RadioButton_Chat = UI.getChildControl(self._ui._Static_TapBG, "RadioButton_Chat")
  self._ui._Frame_1_Content = UI.getChildControl(self._ui._Frame_Friend, "Frame_1_Content")
  self._ui._Frame_1_VerticalScroll = UI.getChildControl(self._ui._Frame_Friend, "Frame_1_VerticalScroll")
  self._ui._Frame_1_HorizontalScroll = UI.getChildControl(self._ui._Frame_Friend, "Frame_1_HorizontalScroll")
  self._ui._RadioButton_FriendsGroup_Template = UI.getChildControl(self._ui._Frame_1_Content, "RadioButton_FriendsGroup_Template")
  self._ui._RadioButton_FriendsList_Template = UI.getChildControl(self._ui._Frame_1_Content, "RadioButton_FriendsList_Template")
  self._ui._RadioButton_ChatGroupTemplate = UI.getChildControl(self._ui._Frame_1_Content, "RadioButton_ChatGroupTemplate")
  self._ui._StaticText_Chat_Sender = UI.getChildControl(self._ui._Frame_1_Content, "StaticText_Chat_Sender")
  self._ui._StaticText_Chat_Content = UI.getChildControl(self._ui._Frame_1_Content, "StaticText_Chat_Content")
  self._ui._Static_FriendProfileslot = UI.getChildControl(self._ui._RadioButton_FriendsList_Template, "Static_FriendProfileslot")
  self._ui._Static_FriendNoImage = UI.getChildControl(self._ui._RadioButton_FriendsList_Template, "Static_FriendNoImage")
  self._ui._Static_FriendProfile = UI.getChildControl(self._ui._RadioButton_FriendsList_Template, "Static_FriendProfile")
  self._ui._StaticText_FriendID = UI.getChildControl(self._ui._RadioButton_FriendsList_Template, "StaticText_FriendID")
  self._ui._StaticText_FriendOnline = UI.getChildControl(self._ui._RadioButton_FriendsList_Template, "StaticText_FriendOnline")
  self._ui._StaticText_MessageCountValue = UI.getChildControl(self._ui._RadioButton_FriendsList_Template, "StaticText_MessageCountValue")
  self._ui._Frame_1_VerticalScroll_UpButton = UI.getChildControl(self._ui._Frame_1_VerticalScroll, "Frame_1_VerticalScroll_UpButton")
  self._ui._Frame_1_VerticalScroll_DownButton = UI.getChildControl(self._ui._Frame_1_VerticalScroll, "Frame_1_VerticalScroll_DownButton")
  self._ui._Frame_1_VerticalScroll_CtrlButton = UI.getChildControl(self._ui._Frame_1_VerticalScroll, "Frame_1_VerticalScroll_CtrlButton")
  self._ui._Frame_1_HorizontalScroll_UpButton = UI.getChildControl(self._ui._Frame_1_HorizontalScroll, "Frame_1_HorizontalScroll_UpButton")
  self._ui._Frame_1_HorizontalScroll_DownButton = UI.getChildControl(self._ui._Frame_1_HorizontalScroll, "Frame_1_HorizontalScroll_DownButton")
  self._ui._Frame_1_HorizontalScroll_CtrlButton = UI.getChildControl(self._ui._Frame_1_HorizontalScroll, "Frame_1_HorizontalScroll_CtrlButton")
  self._ui._Button_Chat = UI.getChildControl(self._ui._Static_BottomMenuBG, "Button_Chat")
  self._ui._Static_ChatIcon = UI.getChildControl(self._ui._Button_Chat, "Static_ChatIcon")
  self._ui._StaticText_InviteIcon = UI.getChildControl(self._ui._Button_Chat, "StaticText_InviteIcon")
  self._ui._Button_Search = UI.getChildControl(self._ui._Static_BottomMenuBG, "Button_Search")
  self._ui._Static_SearchIcon = UI.getChildControl(self._ui._Button_Search, "Static_SearchIcon")
  self:registEventHandler()
  self:validate()
  self:prepareOpen()
  self._initialize = true
end
function PaGlobal_Lobby_ChatingMenu:registEventHandler()
  if nil == SA_Widget_Lobby_ChatingMenu then
    return
  end
end
function PaGlobal_Lobby_ChatingMenu:prepareOpen()
  if nil == SA_Widget_Lobby_ChatingMenu then
    return
  end
  PaGlobal_Lobby_ChatingMenu:open()
end
function PaGlobal_Lobby_ChatingMenu:open()
  if nil == SA_Widget_Lobby_ChatingMenu then
    return
  end
  SA_Widget_Lobby_ChatingMenu:SetShow(true)
end
function PaGlobal_Lobby_ChatingMenu:prepareClose()
  if nil == SA_Widget_Lobby_ChatingMenu then
    return
  end
  SA_Widget_Lobby_ChatingMenu:ClearUpdateLuaFunc()
  PaGlobal_Lobby_ChatingMenu:close()
end
function PaGlobal_Lobby_ChatingMenu:close()
  if nil == SA_Widget_Lobby_ChatingMenu then
    return
  end
  SA_Widget_Lobby_ChatingMenu:SetShow(false)
end
function PaGlobal_Lobby_ChatingMenu:update()
  if nil == SA_Widget_Lobby_ChatingMenu then
    return
  end
end
function PaGlobal_Lobby_ChatingMenu:validate()
  if nil == SA_Widget_Lobby_ChatingMenu then
    return
  end
  self._ui._Static_TapBG:isValidate()
  self._ui._Frame_Friend:isValidate()
  self._ui._Static_BottomMenuBG:isValidate()
  self._ui._RadioButton_FriendTap:isValidate()
  self._ui._RadioButton_Chat:isValidate()
  self._ui._Frame_1_Content:isValidate()
  self._ui._Frame_1_VerticalScroll:isValidate()
  self._ui._Frame_1_HorizontalScroll:isValidate()
  self._ui._RadioButton_FriendsGroup_Template:isValidate()
  self._ui._RadioButton_FriendsList_Template:isValidate()
  self._ui._RadioButton_ChatGroupTemplate:isValidate()
  self._ui._StaticText_Chat_Sender:isValidate()
  self._ui._StaticText_Chat_Content:isValidate()
  self._ui._Static_FriendProfileslot:isValidate()
  self._ui._Static_FriendNoImage:isValidate()
  self._ui._Static_FriendProfile:isValidate()
  self._ui._StaticText_FriendID:isValidate()
  self._ui._StaticText_FriendOnline:isValidate()
  self._ui._StaticText_MessageCountValue:isValidate()
  self._ui._Frame_1_VerticalScroll_UpButton:isValidate()
  self._ui._Frame_1_VerticalScroll_DownButton:isValidate()
  self._ui._Frame_1_VerticalScroll_CtrlButton:isValidate()
  self._ui._Frame_1_HorizontalScroll_UpButton:isValidate()
  self._ui._Frame_1_HorizontalScroll_DownButton:isValidate()
  self._ui._Frame_1_HorizontalScroll_CtrlButton:isValidate()
  self._ui._Button_Chat:isValidate()
  self._ui._Static_ChatIcon:isValidate()
  self._ui._StaticText_InviteIcon:isValidate()
  self._ui._Button_Search:isValidate()
  self._ui._Static_SearchIcon:isValidate()
end
