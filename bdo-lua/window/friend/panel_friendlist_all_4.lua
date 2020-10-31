function PaGlobal_FriendRequest_All:prepareOpen()
  if nil == Panel_Friend_RequestList_All and true == _ContentsGroup_NewUI_Friend_All then
    return
  end
  if false == Panel_FriendList_All:GetShow() then
    return
  end
  PaGlobal_FriendRequest_All._selectFriendIndex = -1
  PaGlobal_FriendRequest_All:updateList()
  PaGlobal_FriendList_All:hidePopupMenu()
  PaGlobal_FriendRequest_All:open()
end
function PaGlobal_FriendRequest_All:open()
  if nil == Panel_Friend_RequestList_All then
    return
  end
  Panel_Friend_RequestList_All:SetShow(true)
end
function PaGlobal_FriendRequest_All:prepareClose()
  if nil == Panel_Friend_RequestList_All then
    return
  end
  PaGlobal_FriendRequest_All:close()
end
function PaGlobal_FriendRequest_All:close()
  if nil == Panel_Friend_RequestList_All then
    return
  end
  Panel_Friend_RequestList_All:SetShow(false)
end
function PaGlobal_FriendRequest_All:updateList()
  if nil == Panel_Friend_RequestList_All then
    return
  end
  RequestFriendList_getFriendList()
  RequestFriendList_getAddFriendList()
  local listControl = PaGlobal_FriendRequest_All._ui.list2_request
  listControl:getElementManager():clearKey()
  local friendCount = RequestFriends_getAddFriendCount()
  for friendIndex = 0, friendCount - 1 do
    local addFriendInfo = RequestFriends_getAddFriendAt(friendIndex)
    if nil ~= addFriendInfo then
      listControl:getElementManager():pushKey(toInt64(0, friendIndex))
    end
  end
  if false == _ContentsGroup_RenewUI and false == _ContentsGroup_RemasterUI_Main_Alert then
    FGlobal_NewFriendAlertOff()
  end
end
function PaGlobal_FriendRequest_All_Close()
  if nil == Panel_Friend_RequestList_All then
    return
  end
  PaGlobal_FriendRequest_All:prepareClose()
end
function PaGlobal_FriendRequest_All_Open()
  if nil == Panel_Friend_RequestList_All then
    return
  end
  if PaGlobal_FriendList_All._tab._pcFriendTab == PaGlobal_FriendList_All._currentTab then
    PaGlobal_FriendRequest_All:prepareOpen()
  end
end
function PaGlobal_FriendRequest_All_OpenToggle()
  if false == Panel_Friend_RequestList_All:GetShow() then
    PaGlobal_FriendRequest_All_Open()
  else
    PaGlobal_FriendRequest_All_Close()
  end
end
function PaGlobal_FriendRequest_All_SetBasicPos()
  Panel_Friend_RequestList_All:SetPosX(Panel_FriendList_All:GetPosX() - Panel_Friend_RequestList_All:GetSizeX() - 10)
  Panel_Friend_RequestList_All:SetPosY(Panel_FriendList_All:GetPosY())
end
function PaGlobal_FriendRequest_All_List2EventControlCreate(control, key64)
  local index = Int64toInt32(key64)
  local addFriendInfo = RequestFriends_getAddFriendAt(index)
  if nil == addFriendInfo then
    return
  end
  local stc_BG = UI.getChildControl(control, "Static_BG")
  local btn_Ok = UI.getChildControl(control, "Button_Apply_PCUI")
  local btn_Refuse = UI.getChildControl(control, "Button_Dismiss_PCUI")
  local name = UI.getChildControl(control, "StaticText_Name")
  stc_BG:addInputEvent("Mouse_On", "PaGlobal_FriendRequest_All_Select(" .. index .. ")")
  if true == _ContentsGroup_UsePadSnapping then
    btn_Ok:SetShow(false)
    btn_Refuse:SetShow(false)
    control:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_FriendRequest_All_RefuseFriend(" .. index .. ")")
    control:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_FriendRequest_All_AcceptFriend(" .. index .. ")")
  else
    btn_Ok:addInputEvent("Mouse_LUp", "PaGlobal_FriendRequest_All_AcceptFriend(" .. index .. ")")
    btn_Refuse:addInputEvent("Mouse_LUp", "PaGlobal_FriendRequest_All_RefuseFriend(" .. index .. ")")
  end
  name:SetText(addFriendInfo:getName())
end
function PaGlobal_FriendRequest_All_AcceptFriend(index)
  if ToClient_isAddFriendAllowed() then
    requestFriendList_acceptFriend(index)
    PaGlobal_FriendList_All._groupListData._selectedGroupIndex = nil
    PaGlobal_FriendList_All._friendListData._selectedFriendIndex = nil
    PaGlobal_FriendList_All._listMoveIndex = nil
    PaGlobal_FriendRequest_All:updateList()
  else
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DONOTHAVE_PRIVILEGE")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    ToClient_showPrivilegeError()
  end
end
function PaGlobal_FriendRequest_All_RefuseFriend(index)
  requestFriendList_refuseFriend(index)
  PaGlobal_FriendRequest_All:updateList()
end
function PaGlobal_FriendRequest_All_Select(index)
  PaGlobal_FriendRequest_All._selectFriendIndex = index
end
function FromClient_FriendRequest_All_UpdateAddFriends()
  if nil == Panel_Friend_RequestList_All then
    return
  end
  PaGlobal_FriendRequest_All:updateList()
  if 0 < RequestFriends_getAddFriendCount() then
    PaGlobal_FriendRequest_All_Open()
  end
end
