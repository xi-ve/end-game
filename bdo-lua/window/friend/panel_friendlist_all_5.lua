function PaGlobal_Friend_GroupRename_All:prepareOpen(isAdd)
  if nil == Panel_Friend_GroupRename_All then
    return
  end
  PaGlobal_Friend_GroupRename_All._isAddGroup = isAdd
  if true == isAdd then
    PaGlobal_Friend_GroupRename_All._ui.txt_title:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_ADD_GROUP"))
    PaGlobal_Friend_GroupRename_All._ui.edit_GroupName:SetEditText(PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_NEW_GROUPNAME"), true)
    PaGlobal_Friend_GroupRename_All._ui.txt_groupDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_FRIEND_ADDGROUPNAMEDESC"))
  else
    PaGlobal_Friend_GroupRename_All._ui.txt_title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "FRIEND_STCTXT_CHANGEGROUPNAME"))
    PaGlobal_Friend_GroupRename_All._ui.edit_GroupName:SetEditText("", true)
    PaGlobal_Friend_GroupRename_All._ui.txt_groupDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_FRIEND_GROUPNAMEDESC"))
  end
  if false == _ContentsGroup_RenewUI then
    PaGlobal_Friend_GroupRename_All_SetFocusEdit()
  else
  end
  ToClient_padSnapSetTargetPanel(Panel_Friend_GroupRename_All)
  PaGlobal_FriendList_All:hidePopupMenu()
  if true == Panel_FriendList_Add_All:GetShow() then
    PaGlobal_AddFriend_All_Close()
  end
  PaGlobal_Friend_GroupRename_All:open()
end
function PaGlobal_Friend_GroupRename_All:open()
  if nil == Panel_Friend_GroupRename_All then
    return
  end
  Panel_Friend_GroupRename_All:SetShow(true)
end
function PaGlobal_Friend_GroupRename_All:prepareClose()
  if nil == Panel_Friend_GroupRename_All then
    return
  end
  CheckChattingInput()
  PaGlobal_Friend_GroupRename_All:close()
end
function PaGlobal_Friend_GroupRename_All:close()
  if nil == Panel_Friend_GroupRename_All then
    return
  end
  Panel_Friend_GroupRename_All:SetShow(false)
end
function PaGlobal_Friend_GroupRename_All_Close()
  if nil == Panel_Friend_GroupRename_All then
    return
  end
  PaGlobal_Friend_GroupRename_All:prepareClose()
end
function PaGlobal_Friend_GroupRename_All_Open(isAdd)
  if nil == Panel_Friend_GroupRename_All then
    return
  end
  PaGlobal_Friend_GroupRename_All:prepareOpen(isAdd)
end
function PaGlobal_Friend_GroupRename_All_SetFocusEdit()
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  ClearFocusEdit()
  SetFocusEdit(PaGlobal_Friend_GroupRename_All._ui.edit_GroupName)
  PaGlobal_Friend_GroupRename_All._ui.edit_GroupName:SetEditText(PaGlobal_Friend_GroupRename_All._ui.edit_GroupName:GetEditText(), true)
end
function PaGlobal_Friend_GroupRename_All_EnterGroupName(str)
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  PaGlobal_Friend_GroupRename_All._ui.edit_GroupName:SetEditText(str, true)
  ClearFocusEdit()
end
function PaGlobal_Friend_GroupRename_All_Confirm()
  if true == PaGlobal_Friend_GroupRename_All._isAddGroup then
    PaGlobal_Friend_GroupRename_All_AddGroup()
  else
    PaGlobal_Friend_GroupRename_All_RenameGroup()
  end
end
function PaGlobal_Friend_GroupRename_All_RenameGroup()
  local _groupListData = PaGlobal_FriendList_All._groupListData
  local editText = PaGlobal_Friend_GroupRename_All._ui.edit_GroupName:GetEditText()
  if 0 <= _groupListData._selectedGroupIndex then
    local friendGroup = _groupListData._groupInfo[_groupListData._selectedGroupIndex]
    if editText == friendGroup:getName() then
      return
    end
    if "" == PeditText then
      return
    end
    requestFriendList_renameGroup(_groupListData._groupInfo[_groupListData._selectedGroupIndex]:getGroupNo(), editText)
  end
  PaGlobal_Friend_GroupRename_All:prepareClose()
end
function PaGlobal_Friend_GroupRename_All_AddGroup()
  local editText = PaGlobal_Friend_GroupRename_All._ui.edit_GroupName:GetEditText()
  local friendGroupCount = RequestFriends_getFriendGroupCount()
  for groupIndex = 0, friendGroupCount - 1 do
    local friendGroup = RequestFriends_getFriendGroupAt(groupIndex)
    if friendGroup:getName() == editText then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DUPLICATION_FRIEND_GROUP_NAME"))
      return
    end
  end
  requestFriendList_addFriendGroup(editText)
  PaGlobal_Friend_GroupRename_All:prepareClose()
end
