function PaGlobal_Lobby_CharacterSelect_InviteFriend:initialize()
  if true == self._initialize then
    return
  end
  if nil == SA_Widget_Lobby_CharacterSelect_InviteFriend then
    return
  end
  self._ui._Static_InviteGroup = UI.getChildControl(SA_Widget_Lobby_CharacterSelect_InviteFriend, "Static_InviteGroup")
  self._ui._Static_InviteMenu = UI.getChildControl(self._ui._Static_InviteGroup, "Static_InviteMenu")
  self._ui._Static_FriendsListGroup = UI.getChildControl(self._ui._Static_InviteGroup, "Static_FriendsListGroup")
  self._ui._RadioButton_AddFriend = UI.getChildControl(self._ui._Static_InviteMenu, "RadioButton_AddFriend")
  self._ui._RadioButton_AutoMating = UI.getChildControl(self._ui._Static_InviteMenu, "RadioButton_AutoMating")
  self._ui._Static_TitleBar = UI.getChildControl(self._ui._Static_FriendsListGroup, "Static_TitleBar")
  self._ui._List2_1 = UI.getChildControl(self._ui._Static_FriendsListGroup, "List2_1")
  self._ui._StaticText_FriendsListTitle = UI.getChildControl(self._ui._Static_TitleBar, "StaticText_FriendsListTitle")
  self._ui._Button_FriendsListClose = UI.getChildControl(self._ui._Static_TitleBar, "Button_FriendsListClose")
  self._ui._List2_1_Content = UI.getChildControl(self._ui._List2_1, "List2_1_Content")
  self._ui._List2_1_VerticalScroll = UI.getChildControl(self._ui._List2_1, "List2_1_VerticalScroll")
  self._ui._List2_1_HorizontalScroll = UI.getChildControl(self._ui._List2_1, "List2_1_HorizontalScroll")
  self._ui._RadioButton_1 = UI.getChildControl(self._ui._List2_1_Content, "RadioButton_1")
  self._ui._StaticText_Onoffline = UI.getChildControl(self._ui._RadioButton_1, "StaticText_Onoffline")
  self._ui._List2_1_VerticalScroll_UpButton = UI.getChildControl(self._ui._List2_1_VerticalScroll, "List2_1_VerticalScroll_UpButton")
  self._ui._List2_1_VerticalScroll_DownButton = UI.getChildControl(self._ui._List2_1_VerticalScroll, "List2_1_VerticalScroll_DownButton")
  self._ui._List2_1_VerticalScroll_CtrlButton = UI.getChildControl(self._ui._List2_1_VerticalScroll, "List2_1_VerticalScroll_CtrlButton")
  self._ui._List2_1_HorizontalScroll_UpButton = UI.getChildControl(self._ui._List2_1_HorizontalScroll, "List2_1_HorizontalScroll_UpButton")
  self._ui._List2_1_HorizontalScroll_DownButton = UI.getChildControl(self._ui._List2_1_HorizontalScroll, "List2_1_HorizontalScroll_DownButton")
  self._ui._List2_1_HorizontalScroll_CtrlButton = UI.getChildControl(self._ui._List2_1_HorizontalScroll, "List2_1_HorizontalScroll_CtrlButton")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Lobby_CharacterSelect_InviteFriend:registEventHandler()
  if nil == SA_Widget_Lobby_CharacterSelect_InviteFriend then
    return
  end
end
function PaGlobal_Lobby_CharacterSelect_InviteFriend:prepareOpen()
  if nil == SA_Widget_Lobby_CharacterSelect_InviteFriend then
    return
  end
  PaGlobal_Lobby_CharacterSelect_InviteFriend:open()
end
function PaGlobal_Lobby_CharacterSelect_InviteFriend:open()
  if nil == SA_Widget_Lobby_CharacterSelect_InviteFriend then
    return
  end
  SA_Widget_Lobby_CharacterSelect_InviteFriend:SetShow(true)
end
function PaGlobal_Lobby_CharacterSelect_InviteFriend:prepareClose()
  if nil == SA_Widget_Lobby_CharacterSelect_InviteFriend then
    return
  end
  SA_Widget_Lobby_CharacterSelect_InviteFriend:ClearUpdateLuaFunc()
  PaGlobal_Lobby_CharacterSelect_InviteFriend:close()
end
function PaGlobal_Lobby_CharacterSelect_InviteFriend:close()
  if nil == SA_Widget_Lobby_CharacterSelect_InviteFriend then
    return
  end
  SA_Widget_Lobby_CharacterSelect_InviteFriend:SetShow(false)
end
function PaGlobal_Lobby_CharacterSelect_InviteFriend:update()
  if nil == SA_Widget_Lobby_CharacterSelect_InviteFriend then
    return
  end
end
function PaGlobal_Lobby_CharacterSelect_InviteFriend:validate()
  if nil == SA_Widget_Lobby_CharacterSelect_InviteFriend then
    return
  end
  self._ui._Static_InviteGroup:isValidate()
  self._ui._Static_InviteMenu:isValidate()
  self._ui._Static_FriendsListGroup:isValidate()
  self._ui._RadioButton_AddFriend:isValidate()
  self._ui._RadioButton_AutoMating:isValidate()
  self._ui._Static_TitleBar:isValidate()
  self._ui._List2_1:isValidate()
  self._ui._StaticText_FriendsListTitle:isValidate()
  self._ui._Button_FriendsListClose:isValidate()
  self._ui._List2_1_Content:isValidate()
  self._ui._List2_1_VerticalScroll:isValidate()
  self._ui._List2_1_HorizontalScroll:isValidate()
  self._ui._RadioButton_1:isValidate()
  self._ui._StaticText_Onoffline:isValidate()
  self._ui._List2_1_VerticalScroll_UpButton:isValidate()
  self._ui._List2_1_VerticalScroll_DownButton:isValidate()
  self._ui._List2_1_VerticalScroll_CtrlButton:isValidate()
  self._ui._List2_1_HorizontalScroll_UpButton:isValidate()
  self._ui._List2_1_HorizontalScroll_DownButton:isValidate()
  self._ui._List2_1_HorizontalScroll_CtrlButton:isValidate()
end
