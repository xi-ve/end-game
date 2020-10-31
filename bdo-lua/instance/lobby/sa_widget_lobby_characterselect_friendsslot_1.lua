function PaGlobal_Lobby_CharacterSelect_FriendsSlot:initialize()
  if true == self._initialize then
    return
  end
  if nil == SA_Widget_Lobby_CharacterSelect_FriendsSlot then
    return
  end
  self._ui._Static_SlotGroup = UI.getChildControl(SA_Widget_Lobby_CharacterSelect_FriendsSlot, "Static_SlotGroup")
  self._ui._Button_Invite_1 = UI.getChildControl(self._ui._Static_SlotGroup, "Button_Invite_1")
  self._ui._Button_Wait_1 = UI.getChildControl(self._ui._Static_SlotGroup, "Button_Wait_1")
  self._ui._Button_Ready_1 = UI.getChildControl(self._ui._Static_SlotGroup, "Button_Ready_1")
  self._ui._Button_Invite_2 = UI.getChildControl(self._ui._Static_SlotGroup, "Button_Invite_2")
  self._ui._Button_Wait_2 = UI.getChildControl(self._ui._Static_SlotGroup, "Button_Wait_2")
  self._ui._Button_Ready_2 = UI.getChildControl(self._ui._Static_SlotGroup, "Button_Ready_2")
  self._ui._Button_Invite_3 = UI.getChildControl(self._ui._Static_SlotGroup, "Button_Invite_3")
  self._ui._Button_Wait_3 = UI.getChildControl(self._ui._Static_SlotGroup, "Button_Wait_3")
  self._ui._Button_Ready_3 = UI.getChildControl(self._ui._Static_SlotGroup, "Button_Ready_3")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Lobby_CharacterSelect_FriendsSlot:registEventHandler()
  if nil == SA_Widget_Lobby_CharacterSelect_FriendsSlot then
    return
  end
end
function PaGlobal_Lobby_CharacterSelect_FriendsSlot:prepareOpen()
  if nil == SA_Widget_Lobby_CharacterSelect_FriendsSlot then
    return
  end
  PaGlobal_Lobby_CharacterSelect_FriendsSlot:open()
end
function PaGlobal_Lobby_CharacterSelect_FriendsSlot:open()
  if nil == SA_Widget_Lobby_CharacterSelect_FriendsSlot then
    return
  end
  SA_Widget_Lobby_CharacterSelect_FriendsSlot:SetShow(true)
end
function PaGlobal_Lobby_CharacterSelect_FriendsSlot:prepareClose()
  if nil == SA_Widget_Lobby_CharacterSelect_FriendsSlot then
    return
  end
  SA_Widget_Lobby_CharacterSelect_FriendsSlot:ClearUpdateLuaFunc()
  PaGlobal_Lobby_CharacterSelect_FriendsSlot:close()
end
function PaGlobal_Lobby_CharacterSelect_FriendsSlot:close()
  if nil == SA_Widget_Lobby_CharacterSelect_FriendsSlot then
    return
  end
  SA_Widget_Lobby_CharacterSelect_FriendsSlot:SetShow(false)
end
function PaGlobal_Lobby_CharacterSelect_FriendsSlot:update()
  if nil == SA_Widget_Lobby_CharacterSelect_FriendsSlot then
    return
  end
end
function PaGlobal_Lobby_CharacterSelect_FriendsSlot:validate()
  if nil == SA_Widget_Lobby_CharacterSelect_FriendsSlot then
    return
  end
  self._ui._Static_SlotGroup:isValidate()
  self._ui._Button_Invite_1:isValidate()
  self._ui._Button_Wait_1:isValidate()
  self._ui._Button_Ready_1:isValidate()
  self._ui._Button_Invite_2:isValidate()
  self._ui._Button_Wait_2:isValidate()
  self._ui._Button_Ready_2:isValidate()
  self._ui._Button_Invite_3:isValidate()
  self._ui._Button_Wait_3:isValidate()
  self._ui._Button_Ready_3:isValidate()
end
