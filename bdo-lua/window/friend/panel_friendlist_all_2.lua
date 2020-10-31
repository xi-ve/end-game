function PaGlobal_FriendList_All:prepareOpen()
  if nil == Panel_FriendList_All and true == _ContentsGroup_NewUI_Friend_All then
    return
  end
  ToClient_updateAddFriendAllowed()
  RequestFriendList_getFriendList()
  RequestFriendList_getAddFriendList()
  if false == _ContentsGroup_RenewUI then
    PaGlobal_FriendList_All:loadOption()
  end
  PaGlobal_FriendList_All:updateTab()
  PaGlobal_FriendList_All:open()
end
function PaGlobal_FriendList_All:open()
  if nil == Panel_FriendList_All then
    return
  end
  Panel_FriendList_All:SetShow(true, true)
end
function PaGlobal_FriendList_All:prepareClose()
  if nil == Panel_FriendList_All then
    return
  end
  if true == PaGlobal_FriendList_All._ui.stc_SubFunctionBG:GetShow() then
    PaGlobal_FriendList_All._ui.stc_SubFunctionBG:SetShow(false)
    ToClient_padSnapSetTargetGroup(PaGlobal_FriendList_All._ui.stc_PopupFunctionBG)
    return
  elseif true == PaGlobal_FriendList_All._ui.stc_PopupFunctionBG:GetShow() then
    PaGlobal_FriendList_All:hidePopupMenu()
    return
  elseif true == PaGlobal_FriendList_All._ui.stc_XBFunctionBG:GetShow() then
    PaGlobal_FriendList_All:hidePopupMenu()
    return
  end
  PaGlobal_FriendList_All:clearGroupListData()
  PaGlobal_FriendList_All:clearFriendListData()
  PaGlobal_FriendList_All._groupListData._selectedGroupIndex = -1
  PaGlobal_FriendList_All._friendListData._selectedFriendIndex = -1
  PaGlobal_FriendList_All._listMoveIndex = nil
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  TooltipSimple_Hide()
  PaGlobal_FriendList_All:close()
end
function PaGlobal_FriendList_All:close()
  if nil == Panel_FriendList_All then
    return
  end
  Panel_FriendList_All:SetShow(false, true)
  Panel_FriendList_Add_All:SetShow(false)
  Panel_Friend_RequestList_All:SetShow(false)
  Panel_Friend_GroupRename_All:SetShow(false)
end
function PaGlobal_FriendList_All:clearGroupListData()
  _defaultGroupIndex = -1
  _partyplayGroupIndex = -1
  PaGlobal_FriendList_All._groupListData._uiGroups = {}
  PaGlobal_FriendList_All._groupListData._groupInfo = {}
  PaGlobal_FriendList_All._groupListData._groupCount = 0
end
function PaGlobal_FriendList_All:clearFriendListData()
  PaGlobal_FriendList_All._friendListData._uiFriends = {}
  PaGlobal_FriendList_All._friendListData._friendInfo = {}
end
function PaGlobal_FriendList_All:updateTab()
  if PaGlobal_FriendList_All._tab._consoleFriendTab == PaGlobal_FriendList_All._currentTab then
    PaGlobal_FriendList_All:updateFriendListForConsole()
    if true == _ContentsGroup_RenewUI then
      PaGlobal_FriendList_All._ui.rdo_PCFriend:SetFontColor(Defines.Color.C_FF585453)
      PaGlobal_FriendList_All._ui.rdo_ConsoleFriend:SetFontColor(Defines.Color.C_FFFFEDD4)
    end
  else
    PaGlobal_FriendList_All:updateFriendList()
    if true == _ContentsGroup_RenewUI then
      PaGlobal_FriendList_All._ui.rdo_PCFriend:SetFontColor(Defines.Color.C_FFFFEDD4)
      PaGlobal_FriendList_All._ui.rdo_ConsoleFriend:SetFontColor(Defines.Color.C_FF585453)
    end
  end
  if true == _ContentsGroup_UsePadSnapping then
    local firstFriend = PaGlobal_FriendList_All._ui.list2_Friend:GetContentByKey(0)
    if nil == firstFriend then
      PaGlobal_FriendList_All._currentKeyGuideType = PaGlobal_FriendList_All._keyGuideType._None
      PaGlobal_FriendList_All:updateKeyGuides()
    end
  end
end
function PaGlobal_FriendList_All:loadOption()
  local noticeSound = ToClient_RoadToggleSoundNotice() or false
  local noticeEffect = ToClient_RoadToggleEffectNotice() or false
  PaGlobal_FriendList_All._ui.chk_Sound:SetCheck(noticeSound)
  PaGlobal_FriendList_All._ui.chk_Effect:SetCheck(noticeEffect)
end
function PaGlobal_FriendList_All:updateKeyGuides()
  local Type = PaGlobal_FriendList_All._keyGuideType
  if Type._DefaultGroup == PaGlobal_FriendList_All._currentKeyGuideType then
    PaGlobal_FriendList_All._ui.txt_KeyGuide_X:SetShow(false)
    PaGlobal_FriendList_All._ui.txt_KeyGuide_Y:SetShow(true)
    PaGlobal_FriendList_All._ui.txt_KeyGuide_A:SetShow(true)
    PaGlobal_FriendList_All._ui.txt_KeyGuide_B:SetShow(true)
  elseif Type._Group == PaGlobal_FriendList_All._currentKeyGuideType then
    PaGlobal_FriendList_All._ui.txt_KeyGuide_X:SetShow(true)
    PaGlobal_FriendList_All._ui.txt_KeyGuide_Y:SetShow(true)
    PaGlobal_FriendList_All._ui.txt_KeyGuide_A:SetShow(true)
    PaGlobal_FriendList_All._ui.txt_KeyGuide_B:SetShow(true)
  elseif Type._Friend == PaGlobal_FriendList_All._currentKeyGuideType then
    PaGlobal_FriendList_All._ui.txt_KeyGuide_X:SetShow(false)
    PaGlobal_FriendList_All._ui.txt_KeyGuide_Y:SetShow(true)
    PaGlobal_FriendList_All._ui.txt_KeyGuide_A:SetShow(true)
    PaGlobal_FriendList_All._ui.txt_KeyGuide_B:SetShow(true)
  elseif Type._XBFriend == PaGlobal_FriendList_All._currentKeyGuideType then
    PaGlobal_FriendList_All._ui.txt_KeyGuide_X:SetShow(false)
    PaGlobal_FriendList_All._ui.txt_KeyGuide_Y:SetShow(false)
    PaGlobal_FriendList_All._ui.txt_KeyGuide_A:SetShow(true)
    PaGlobal_FriendList_All._ui.txt_KeyGuide_B:SetShow(true)
  elseif Type._Popup == PaGlobal_FriendList_All._currentKeyGuideType then
    PaGlobal_FriendList_All._ui.txt_KeyGuide_X:SetShow(false)
    PaGlobal_FriendList_All._ui.txt_KeyGuide_Y:SetShow(false)
    PaGlobal_FriendList_All._ui.txt_KeyGuide_A:SetShow(true)
    PaGlobal_FriendList_All._ui.txt_KeyGuide_B:SetShow(true)
  elseif Type._AddGroup == PaGlobal_FriendList_All._currentKeyGuideType then
    PaGlobal_FriendList_All._ui.txt_KeyGuide_X:SetShow(false)
    PaGlobal_FriendList_All._ui.txt_KeyGuide_Y:SetShow(true)
    PaGlobal_FriendList_All._ui.txt_KeyGuide_A:SetShow(true)
    PaGlobal_FriendList_All._ui.txt_KeyGuide_B:SetShow(true)
  elseif Type._None == PaGlobal_FriendList_All._currentKeyGuideType then
    PaGlobal_FriendList_All._ui.txt_KeyGuide_X:SetShow(false)
    if PaGlobal_FriendList_All._tab._pcFriendTab == PaGlobal_FriendList_All._currentTab then
      PaGlobal_FriendList_All._ui.txt_KeyGuide_Y:SetShow(true)
    else
      PaGlobal_FriendList_All._ui.txt_KeyGuide_Y:SetShow(false)
    end
    PaGlobal_FriendList_All._ui.txt_KeyGuide_A:SetShow(false)
    PaGlobal_FriendList_All._ui.txt_KeyGuide_B:SetShow(true)
  end
  local isLTShow = Type._Popup ~= PaGlobal_FriendList_All._currentKeyGuideType and PaGlobal_FriendList_All._tab._pcFriendTab == PaGlobal_FriendList_All._currentTab
  PaGlobal_FriendList_All._ui.txt_KeyGuide_LT:SetShow(isLTShow)
  local isLBShow = isLTShow and true == PaGlobal_FriendList_All._isPS4
  PaGlobal_FriendList_All._ui.txt_KeyGuide_LB:SetShow(isLBShow)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_FriendList_All._keyGuides, PaGlobal_FriendList_All._ui.stc_BottomBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_FriendList_All:updateFriendList()
  if nil == Panel_FriendList_All then
    return
  end
  local friendList = PaGlobal_FriendList_All._ui.list2_Friend
  local _groupListData = PaGlobal_FriendList_All._groupListData
  local _friendListData = PaGlobal_FriendList_All._friendListData
  PaGlobal_FriendList_All:clearGroupListData()
  PaGlobal_FriendList_All:clearFriendListData()
  friendList:getElementManager():clearKey()
  local mainElement = friendList:getElementManager():getMainElement()
  if true == _ContentsGroup_RenewUI then
    local pcFriendGroup = RequestFriends_getFriendGroupAt(0)
    local friendCount = pcFriendGroup:getFriendCount()
    for index = 0, friendCount - 1 do
      local treeElement = mainElement:createChild(toInt64(0, index))
      local friendInfo = pcFriendGroup:getFriendAt(index)
      _friendListData._friendInfo[index] = friendInfo
    end
  else
    local friendGroupCount = RequestFriends_getFriendGroupCount()
    local indexCnt = 0
    local groupIndexCnt = 0
    for groupIndex = 0, friendGroupCount - 1 do
      local friendGroup = RequestFriends_getFriendGroupAt(groupIndex)
      local treeElement = mainElement:createChild(toInt64(0, indexCnt))
      _groupListData._groupInfo[indexCnt] = friendGroup
      _groupListData._groupInfoByGroupIndex[groupIndex] = friendGroup
      _groupListData._groupCount = friendGroupCount
      indexCnt = indexCnt + 1
      groupIndexCnt = indexCnt
      if false == friendGroup:isHide() then
        local friendCount = friendGroup:getFriendCount()
        for friendIndex = 0, friendCount - 1 do
          local friendInfo = friendGroup:getFriendAt(friendIndex)
          local subTreeElement = treeElement:createChild(toInt64(0, indexCnt))
          _friendListData._friendInfo[indexCnt] = friendInfo
          indexCnt = indexCnt + 1
        end
      end
    end
    if PaGlobal_FriendList_All._MAX_GROUP_COUNT ~= friendGroupCount then
      mainElement:createChild(toInt64(0, indexCnt))
    end
  end
  friendList:getElementManager():refillKeyList()
  if nil ~= PaGlobal_FriendList_All._listMoveIndex then
    friendList:moveIndex(PaGlobal_FriendList_All._listMoveIndex)
  else
    friendList:moveIndex(0)
  end
end
function PaGlobal_FriendList_All:updateFriendListForConsole()
  if nil == Panel_FriendList_All then
    return
  end
  local friendList = PaGlobal_FriendList_All._ui.list2_Friend
  local _friendListData = PaGlobal_FriendList_All._friendListData
  PaGlobal_FriendList_All:clearGroupListData()
  PaGlobal_FriendList_All:clearFriendListData()
  friendList:getElementManager():clearKey()
  local mainElement = friendList:getElementManager():getMainElement()
  local friendCount = ToClient_InitializeXboxFriendForLua()
  for index = 0, friendCount - 1 do
    local treeElement = mainElement:createChild(toInt64(0, index))
    local friendInfo = ToClient_getXboxFriendInfoByIndex(index)
    _friendListData._friendInfo[index] = friendInfo
  end
  friendList:getElementManager():refillKeyList()
  if nil ~= PaGlobal_FriendList_All._listMoveIndex then
    friendList:moveIndex(PaGlobal_FriendList_All._listMoveIndex)
  else
    friendList:moveIndex(0)
  end
end
function PaGlobal_FriendList_All:groupMoveList()
  if nil == Panel_FriendList_All then
    return
  end
  local _friendListData = PaGlobal_FriendList_All._friendListData
  if nil == _friendListData._friendInfo[_friendListData._selectedFriendIndex] then
    PaGlobal_FriendList_All:hidePopupMenu()
    return
  end
  local moveGroupBG = PaGlobal_FriendList_All._ui.stc_SubFunctionBG
  local moveGroup = PaGlobal_FriendList_All._ui.stc_PopupFunctionList[PaGlobal_FriendList_All._popupFunction.GROUP_MOVE]
  PaGlobal_FriendList_All:groupMoveSetShow(true)
  moveGroupBG:SetPosX(PaGlobal_FriendList_All._ui.stc_PopupFunctionBG:GetPosX() - moveGroupBG:GetSizeX() - 10)
  moveGroupBG:SetPosY(PaGlobal_FriendList_All._ui.stc_PopupFunctionBG:GetPosY() + moveGroup:GetPosY())
end
function PaGlobal_FriendList_All:showXBMenu(index)
  if nil == Panel_FriendList_All then
    return
  end
  local XB_BG = PaGlobal_FriendList_All._ui.stc_XBFunctionBG
  XB_BG:SetShow(true)
  ToClient_padSnapSetTargetGroup(XB_BG)
  local control
  PaGlobal_FriendList_All._selectedXBFriendIndex = index
  if -1 ~= index then
    control = PaGlobal_FriendList_All._ui.list2_Friend:GetContentByKey(toInt64(0, index))
  end
  if nil ~= control then
    local posY = PaGlobal_FriendList_All._ui.list2_Friend:GetPosY() + control:GetPosY()
    XB_BG:SetPosY(posY)
    local posX = -XB_BG:GetSizeX() - 10
    XB_BG:SetPosX(posX)
  end
  PaGlobal_FriendList_All._currentKeyGuideType = PaGlobal_FriendList_All._keyGuideType._Popup
  PaGlobal_FriendList_All:updateKeyGuides()
end
function PaGlobal_FriendList_All:ShowXBoxProfile()
  local index = PaGlobal_FriendList_All._selectedXBFriendIndex
  local xboxFriendInfo = ToClient_getXboxFriendInfoByIndex(index)
  ToClient_showXboxFriendProfile(xboxFriendInfo:getXuid())
end
function PaGlobal_FriendList_All:SendXboxInvite()
  local index = PaGlobal_FriendList_All._selectedXBFriendIndex
  local xboxFriendInfo = ToClient_getXboxFriendInfoByIndex(index)
  ToClient_sendXboxInvite(xboxFriendInfo:getXuid(), "Hello!")
end
function PaGlobal_FriendList_All:isSelectFriendBlocked()
  if nil == Panel_FriendList_All then
    return
  end
  local userNo = PaGlobal_FriendList_All._friendListData._friendInfo[PaGlobal_FriendList_All._friendListData._selectedFriendIndex]:getUserNo()
  local groupNo = PaGlobal_FriendList_All._friendListData._friendInfo[PaGlobal_FriendList_All._friendListData._selectedFriendIndex]:getGroupNo()
  return RequestFriends_isBlockedFriend(userNo, groupNo)
end
function PaGlobal_FriendList_All:renameFriendGroup()
  if nil == Panel_FriendList_All then
    return
  end
  PaGlobal_Friend_GroupRename_All_Open(false)
  PaGlobal_FriendList_All._ui.stc_XBFunctionBG:SetShow(false)
end
function PaGlobal_FriendList_All:partyInvite()
  if nil == Panel_FriendList_All then
    return
  end
  local _friendListData = PaGlobal_FriendList_All._friendListData
  if nil == _friendListData._friendInfo[_friendListData._selectedFriendIndex] then
    PaGlobal_FriendList_All:hidePopupMenu()
    return
  end
  local userCharacterName = _friendListData._friendInfo[_friendListData._selectedFriendIndex]:getCharacterName()
  local isOnline = _friendListData._friendInfo[_friendListData._selectedFriendIndex]:isOnline()
  local isSelfPlayerPlayingPvPMatch = getSelfPlayer():isDefinedPvPMatch()
  if PaGlobal_FriendList_All:isSelectFriendBlocked() then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DONOTHAVE_PRIVILEGE")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  if nil ~= userCharacterName and "" ~= userCharacterName and false == isSelfPlayerPlayingPvPMatch then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERACTION_ACK_INVITE", "targetName", userCharacterName))
  end
  RequestParty_inviteCharacter(userCharacterName)
  PaGlobal_FriendList_All:hidePopupMenu()
end
function PaGlobal_FriendList_All:guildInvite()
  local _friendListData = PaGlobal_FriendList_All._friendListData
  if nil == _friendListData._friendInfo[_friendListData._selectedFriendIndex] then
    PaGlobal_FriendList_All:hidePopupMenu()
    return
  end
  local userCharacterName = _friendListData._friendInfo[_friendListData._selectedFriendIndex]:getCharacterName()
  local isOnline = _friendListData._friendInfo[_friendListData._selectedFriendIndex]:isOnline()
  local selfPlayer = getSelfPlayer()
  local selfActorKeyRaw = selfPlayer:getActorKey()
  local isGuildMaster = selfPlayer:isSpecialGuildMember(selfActorKeyRaw)
  if false == isGuildMaster then
    return
  end
  if false == isOnline then
    local messageBoxMemo = PAGetString(Defines.StringSheet_SymbolNo, "eErrNoGuildTeamBattleAttendCantAttach")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "FRIEND_TEXT_TITLE"),
      content = messageBoxMemo,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  local guildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil ~= guildInfo then
    if guildInfo:getJoinableMemberCount() <= guildInfo:getMemberCount() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INTERACTION_GUILDINVITE_CANNOTJOINNOMORE"))
      return
    end
    if nil ~= guildInfo:getMemberByUserNo() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_POPUP_ALREADY_JOIN_CLAN_OR_GUILD"))
      return
    end
  end
  if true == _ContentsGroup_NewUI_Guild_All then
    FromClient_GuildInfo_All_GuildInviteForGuildGrade(0, userCharacterName, 0)
  else
    FromClient_GuildMain_ResponseGuildInviteForGuild(0, userCharacterName, 0)
  end
end
function PaGlobal_FriendList_All:deleteFriend()
  if nil == Panel_FriendList_All then
    return
  end
  local _friendListData = PaGlobal_FriendList_All._friendListData
  if nil ~= _friendListData._friendInfo[_friendListData._selectedFriendIndex] then
    requestFriendList_deleteFriend(_friendListData._friendInfo[_friendListData._selectedFriendIndex]:getUserNo())
  end
  PaGlobal_FriendList_All._listMoveIndex = PaGlobal_FriendList_All._friendListData._selectedFriendIndex - 1
  PaGlobal_FriendList_All:hidePopupMenu()
end
function PaGlobal_FriendList_All:showPopupMenu(isShow)
  if nil == Panel_FriendList_All then
    return
  end
  local friendListData = PaGlobal_FriendList_All._friendListData
  local groupListData = PaGlobal_FriendList_All._groupListData
  local popupBG = PaGlobal_FriendList_All._ui.stc_PopupFunctionBG
  popupBG:SetShow(isShow)
  if isShow then
    local isOnline = friendListData._friendInfo[friendListData._selectedFriendIndex]:isOnline()
    local isMessage = RequestFriendList_isMessageList(friendListData._friendInfo[friendListData._selectedFriendIndex]:getUserNo())
    local isMessangerShow = false
    if false == isOnline and false == isMessage or true == _ContentsGroup_RenewUI then
      isMessangerShow = false
    else
      isMessangerShow = true
    end
    if true == _ContentsGroup_RenewUI then
      PaGlobal_FriendList_All._ui.stc_PopupFunctionList[PaGlobal_FriendList_All._popupFunction.PARTY_INVITE]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_INVITE"))
      local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
      if nil ~= myGuildInfo then
        local guildGrade = myGuildInfo:getGuildGrade()
        if 0 == guildGrade then
          PaGlobal_FriendList_All._ui.stc_PopupFunctionList[PaGlobal_FriendList_All._popupFunction.PARTY_INVITE]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_CLAN_INVITE"))
        end
      end
    end
    local isGroupMove = 2 <= groupListData._groupCount
    local control
    local index = friendListData._selectedFriendIndex
    if -1 ~= index then
      control = PaGlobal_FriendList_All._ui.list2_Friend:GetContentByKey(toInt64(0, index))
    end
    if nil ~= control then
      local posY = PaGlobal_FriendList_All._ui.list2_Friend:GetPosY() + control:GetPosY()
      popupBG:SetPosY(posY)
      local posX = -popupBG:GetSizeX() - 10
      popupBG:SetPosX(posX)
    end
    ToClient_padSnapSetTargetGroup(popupBG)
    ToClient_padSnapIgnoreGroupMove()
    PaGlobal_FriendList_All._ui.stc_PopupFunctionList[PaGlobal_FriendList_All._popupFunction.GROUP_MOVE]:SetShow(isGroupMove)
    PaGlobal_FriendList_All._ui.stc_PopupFunctionList[PaGlobal_FriendList_All._popupFunction.MESSANGER]:SetShow(isMessangerShow)
    local gapY = PaGlobal_FriendList_All._ui.stc_PopupFunctionList[0]:GetSizeY()
    local activeCount = 0
    for i = 0, PaGlobal_FriendList_All._MAX_FUNCTION_COUNT - 1 do
      stc_function = PaGlobal_FriendList_All._ui.stc_PopupFunctionList[i]
      if true == stc_function:GetShow() then
        stc_function:SetPosY(gapY * activeCount)
        activeCount = activeCount + 1
      end
    end
    popupBG:SetSize(popupBG:GetSizeX(), gapY * activeCount)
    PaGlobal_FriendList_All._currentKeyGuideType = PaGlobal_FriendList_All._keyGuideType._Popup
    PaGlobal_FriendList_All:updateKeyGuides()
    PaGlobal_FriendList_All._ui.stc_SubFunctionBG:SetShow(false)
  end
end
function PaGlobal_FriendList_All:hidePopupMenu()
  PaGlobal_FriendList_All._ui.stc_PopupFunctionBG:SetShow(false)
  PaGlobal_FriendList_All._ui.stc_SubFunctionBG:SetShow(false)
  PaGlobal_FriendList_All._ui.stc_XBFunctionBG:SetShow(false)
  if true == _ContentsGroup_UsePadSnapping then
    local index = 0
    if PaGlobal_FriendList_All._tab._pcFriendTab == PaGlobal_FriendList_All._currentTab then
      index = PaGlobal_FriendList_All._friendListData._selectedFriendIndex
    else
      index = PaGlobal_FriendList_All._selectedXBFriendIndex
    end
    local friendControl = PaGlobal_FriendList_All._ui.list2_Friend:GetContentByKey(toInt64(0, index))
    if nil ~= friendControl then
      local child = UI.getChildControl(friendControl, "Static_ChildBG")
      if nil ~= child then
        child:SetCheck(false)
      end
    end
    PaGlobal_FriendList_All._friendListData._selectedFriendIndex = -1
    PaGlobal_FriendList_All._selectedXBFriendIndex = -1
  end
end
function PaGlobal_FriendList_All:updateGroups()
  if nil == Panel_FriendList_All then
    return
  end
  local popupBG = PaGlobal_FriendList_All._ui.stc_SubFunctionBG
  local menuList = PaGlobal_FriendList_All._ui.stc_SubFunctionList
  local groupCount = PaGlobal_FriendList_All._groupListData._groupCount
  local buttonSizeX = PaGlobal_FriendList_All._ui.stc_function:GetSizeX()
  local buttonSizeY = PaGlobal_FriendList_All._ui.stc_function:GetSizeY()
  for index = 0, PaGlobal_FriendList_All._MAX_GROUP_COUNT - 1 do
    menuList[index]:SetShow(false)
  end
  local friendGroupNoPartyFriend = -2
  popupBG:SetSize(buttonSizeX, buttonSizeY * groupCount)
  local count = 0
  for groupIndex = 0, groupCount - 1 do
    local groupName = PaGlobal_FriendList_All._groupListData._groupInfoByGroupIndex[groupIndex]:getName()
    local groupNo = PaGlobal_FriendList_All._groupListData._groupInfoByGroupIndex[groupIndex]:getGroupNo()
    if groupNo ~= friendGroupNoPartyFriend then
      if groupName == "" then
        menuList[groupIndex]:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_GROUP_ETC"))
      else
        menuList[groupIndex]:SetText(groupName)
      end
      menuList[groupIndex]:SetShow(true)
      menuList[groupIndex]:SetPosY(buttonSizeY * count)
      menuList[groupIndex]:addInputEvent("Mouse_LUp", "PaGlobal_FriendList_All:moveGroupTo(" .. groupIndex .. ")")
      count = count + 1
    end
  end
end
function PaGlobal_FriendList_All:moveGroupTo(groupIndex)
  if nil == Panel_FriendList_All then
    return
  end
  local _friendListData = PaGlobal_FriendList_All._friendListData
  if nil == _friendListData._friendInfo[_friendListData._selectedFriendIndex] then
    PaGlobal_FriendList_All:hidePopupMenu()
    return
  end
  requestFriendList_moveGroup(_friendListData._friendInfo[_friendListData._selectedFriendIndex]:getUserNo(), PaGlobal_FriendList_All._groupListData._groupInfoByGroupIndex[groupIndex]:getGroupNo())
  _friendListData._selectedFriendIndex = nil
  PaGlobal_FriendList_All._listMoveIndex = nil
  PaGlobal_FriendList_All:hidePopupMenu()
end
function PaGlobal_FriendList_All:groupMoveSetShow(isShow)
  if nil == Panel_FriendList_All then
    return
  end
  PaGlobal_FriendList_All._ui.stc_SubFunctionBG:SetShow(isShow)
  if isShow then
    PaGlobal_FriendList_All:updateGroups()
    ToClient_padSnapSetTargetGroup(PaGlobal_FriendList_All._ui.stc_SubFunctionBG)
    ToClient_padSnapIgnoreGroupMove()
    PaGlobal_FriendList_All._currentKeyGuideType = PaGlobal_FriendList_All._keyGuideType._Popup
    PaGlobal_FriendList_All:updateKeyGuides()
  end
end
function PaGlobal_FriendList_All:messangerOpen()
  if nil == Panel_FriendList_All then
    return
  end
  local _friendListData = PaGlobal_FriendList_All._friendListData
  if nil == _friendListData._friendInfo[_friendListData._selectedFriendIndex] then
    PaGlobal_FriendList_All:hidePopupMenu()
    return
  end
  local userNo = _friendListData._friendInfo[_friendListData._selectedFriendIndex]:getUserNo()
  local userName = _friendListData._friendInfo[_friendListData._selectedFriendIndex]:getName()
  local isOnline = _friendListData._friendInfo[_friendListData._selectedFriendIndex]:isOnline()
  if PaGlobal_FriendList_All:isSelectFriendBlocked() then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DONOTHAVE_PRIVILEGE")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  RequestFriendList_OpenMessanger(userNo, userName, isOnline)
  PaGlobal_FriendList_All:hidePopupMenu()
end
function HandleEventRUp_FriendList_All_GroupRenameOpen(index)
  PaGlobal_FriendList_All._groupListData._selectedGroupIndex = index
  PaGlobal_FriendList_All._friendListData._selectedFriendIndex = nil
  PaGlobal_FriendList_All._listMoveIndex = index
  PaGlobal_Friend_GroupRename_All_Open(false)
end
function HandleEventRUp_FriendList_All_ShowPopup(index)
  PaGlobal_FriendList_All._groupListData._selectedGroupIndex = nil
  PaGlobal_FriendList_All._friendListData._selectedFriendIndex = index
  PaGlobal_FriendList_All._listMoveIndex = index
  PaGlobal_FriendList_All:showPopupMenu(true)
end
function HandleEventLUp_FriendList_All_MessangerOpen(index)
  PaGlobal_FriendList_All._groupListData._selectedGroupIndex = nil
  PaGlobal_FriendList_All._friendListData._selectedFriendIndex = index
  PaGlobal_FriendList_All._listMoveIndex = PaGlobal_FriendList_All._ui.list2_Friend:getCurrenttoIndex()
  PaGlobal_FriendList_All:messangerOpen()
  PaGlobal_FriendList_All:updateFriendList()
end
function PaGlobal_FriendList_Show_All()
  if nil == Panel_FriendList_All then
    return
  end
  PaGlobal_FriendList_All:prepareOpen()
  if 0 < RequestFriends_getAddFriendCount() then
    PaGlobal_FriendRequest_All_Open()
  end
end
function PaGlobal_FriendList_All_Close()
  if nil == Panel_FriendList_All then
    return
  end
  PaGlobal_FriendList_All:prepareClose()
end
function PaGlobal_FriendList_Hide_All()
  if nil == Panel_FriendList_All then
    return
  end
  PaGlobal_FriendList_All:hidePopupMenu()
  PaGlobal_FriendList_All:prepareClose()
end
function PaGlobal_FriendList_All_List2ControlCreate(control, key64)
  local index = Int64toInt32(key64)
  local parentBG = UI.getChildControl(control, "Static_ParentBG")
  local childBG = UI.getChildControl(control, "Static_ChildBG")
  local name = UI.getChildControl(control, "StaticText_Name")
  local addGroup = UI.getChildControl(control, "StaticText_AddGroup")
  local upIcon = UI.getChildControl(control, "Static_UpIcon")
  local downIcon = UI.getChildControl(control, "Static_DownIcon")
  local targetPlatformIcon = UI.getChildControl(control, "Static_PlatformIcon_ConsoleUI")
  local _groupListData = PaGlobal_FriendList_All._groupListData
  local _friendListData = PaGlobal_FriendList_All._friendListData
  local friendGroupNoDefault = -1
  local friendGroupNoPartyFriend = -2
  parentBG:SetShow(false)
  childBG:SetShow(false)
  upIcon:SetShow(false)
  downIcon:SetShow(false)
  control:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  parentBG:addInputEvent("Mouse_RUp", "")
  parentBG:setNotImpactScrollEvent(true)
  childBG:setNotImpactScrollEvent(true)
  if PaGlobal_FriendList_All._tab._pcFriendTab == PaGlobal_FriendList_All._currentTab then
    if true == _ContentsGroup_RenewUI then
      local pcFriendGroup = RequestFriends_getFriendGroupAt(0)
      local friendInfo = pcFriendGroup:getFriendAt(index)
      local friendName = friendInfo:getName()
      childBG:SetShow(true)
      addGroup:SetShow(false)
      name:SetShow(true)
      childBG:SetCheck(false)
      if index == PaGlobal_FriendList_All._friendListData._selectedFriendIndex then
        childBG:SetCheck(true)
      end
      local charcterName = friendInfo:getCharacterName()
      if true == ToClient_isPS4() then
        local psOnlineId = ToClient_getOnlineId(friendInfo:getUserNo())
        local selfPlayerPlatform = ToClient_getGamePlatformType()
        local friendPlatform = friendInfo:getPlatformType()
        if nil == psOnlineId or "" == psOnlineId or friendPlatform ~= selfPlayerPlatform then
          psOnlineId = "-"
        end
        if false == friendInfo:isOnline() then
          psOnlineId = "Not Login"
        end
        charcterName = psOnlineId
      end
      if false == friendInfo:isOnline() or true == friendInfo:isGhostMode() then
        local s64_lastLogoutTime = friendInfo:getLastLogoutTime_s64()
        friendName = friendName .. " " .. "(" .. convertStringFromDatetimeOverHourForFriends(s64_lastLogoutTime) .. ")"
      elseif -1 < friendInfo:getWp() and -1 < friendInfo:getExplorationPoint() then
        friendName = friendName .. " " .. "(" .. charcterName .. ", " .. PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_ONLINE") .. ")"
      else
        friendName = friendName .. " " .. "(" .. PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_ONLINE") .. ")"
      end
      control:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_FriendList_All_ShowPopup(" .. index .. ")")
      control:addInputEvent("Mouse_On", "PaGlobal_FriendList_All_SetSelectedFriendIndex()")
      name:SetText(friendName)
      if true == ToClient_isTotalGameClient() then
        PaGlobal_FriendList_All_CrossPlayIconSetting(targetPlatformIcon, friendInfo:getPlatformType(), name)
      end
    elseif nil ~= _groupListData._groupInfo[index] then
      local friendGroup = _groupListData._groupInfo[index]
      local treeElement = PaGlobal_FriendList_All._ui.list2_Friend:getElementManager():getByKey(key64)
      parentBG:SetShow(true)
      addGroup:SetShow(false)
      name:SetShow(true)
      if true == friendGroup:isHide() then
        downIcon:SetShow(true)
      else
        upIcon:SetShow(true)
      end
      if friendGroup:getGroupNo() == friendGroupNoDefault then
        name:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_GROUP_ETC"))
      elseif friendGroup:getGroupNo() == friendGroupNoPartyFriend then
        name:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_GROUP_PARTY"))
      else
        name:SetText(friendGroup:getName())
        if true == _ContentsGroup_UsePadSnapping then
          control:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventRUp_FriendList_All_GroupRenameOpen(" .. index .. ")")
        else
          parentBG:addInputEvent("Mouse_RUp", "HandleEventRUp_FriendList_All_GroupRenameOpen(" .. index .. ")")
        end
      end
      if true == _ContentsGroup_UsePadSnapping then
        control:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_FriendList_All_ToggleGroup(" .. index .. ")")
        control:addInputEvent("Mouse_On", "PaGlobal_FriendList_All_SetSelectedGroupIndex(" .. index .. ")")
      else
        parentBG:addInputEvent("Mouse_LUp", "PaGlobal_FriendList_All_ToggleGroup(" .. index .. ")")
      end
    elseif nil ~= _friendListData._friendInfo[index] then
      local friendInfo = _friendListData._friendInfo[index]
      local friendName = friendInfo:getName()
      childBG:SetShow(true)
      addGroup:SetShow(false)
      name:SetShow(true)
      local charcterName = friendInfo:getCharacterName()
      if false == friendInfo:isOnline() or true == friendInfo:isGhostMode() then
        local s64_lastLogoutTime = friendInfo:getLastLogoutTime_s64()
        friendName = friendName .. " " .. "(" .. convertStringFromDatetimeOverHourForFriends(s64_lastLogoutTime) .. ")"
      elseif -1 < friendInfo:getWp() and -1 < friendInfo:getExplorationPoint() then
        friendName = friendName .. " " .. "(" .. friendInfo:getCharacterName() .. ", " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. tostring(friendInfo:getLevel()) .. ") " .. tostring(friendInfo:getWp()) .. "/" .. tostring(friendInfo:getExplorationPoint())
      else
        friendName = friendName .. " " .. "(" .. PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_ONLINE") .. ")"
      end
      childBG:addInputEvent("Mouse_RUp", "HandleEventRUp_FriendList_All_ShowPopup(" .. index .. ")")
      if true == _ContentsGroup_UsePadSnapping then
        control:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_FriendList_All_ShowPopup(" .. index .. ")")
      else
        childBG:addInputEvent("Mouse_LUp", "HandleEventLUp_FriendList_All_MessangerOpen(" .. index .. ")")
      end
      name:SetText(friendName)
      local messageList = ToClient_GetFriendMessageListByUserNo(friendInfo:getUserNo())
      if nil ~= messageList then
        local messageCount = messageList:getMessageCount()
        if 0 < messageCount then
          name:SetText(name:GetText() .. " <PAColor0xFFD05D48>(" .. messageCount .. ")<PAOldColor>")
        end
      end
    else
      parentBG:SetShow(true)
      name:SetShow(false)
      addGroup:SetShow(true)
      addGroup:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_ADD_GROUP"))
      local totalSizeX = parentBG:GetSizeX()
      local addGroupSizeX = addGroup:GetSizeX() + addGroup:GetTextSizeX()
      local posX = parentBG:GetPosX() + (totalSizeX - addGroupSizeX) / 2
      addGroup:SetPosX(posX)
      parentBG:addInputEvent("Mouse_LUp", "PaGlobal_Friend_GroupRename_All_Open(true)")
    end
  elseif PaGlobal_FriendList_All._tab._consoleFriendTab == PaGlobal_FriendList_All._currentTab then
    childBG:SetShow(true)
    addGroup:SetShow(false)
    name:SetShow(true)
    childBG:SetCheck(false)
    if index == PaGlobal_FriendList_All._selectedXBFriendIndex then
      childBG:SetCheck(true)
    end
    local xboxFriendInfo = ToClient_getXboxFriendInfoByIndex(index)
    local isLogin = xboxFriendInfo:isOnline()
    local familyNameStr = xboxFriendInfo:getName()
    local friendName = xboxFriendInfo:getGamerTag()
    if true == isLogin then
      if nil == familyNameStr or "" == familyNameStr then
        friendName = friendName .. " (" .. PAGetString(Defines.StringSheet_GAME, "LUA_FRIENDLIST_NOTINGAME") .. ")"
      else
        friendName = friendName .. " (" .. familyNameStr .. ", " .. PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_ONLINE") .. ")"
      end
    else
      friendName = friendName .. " (" .. PAGetString(Defines.StringSheet_GAME, "LUA_FRIENDINFO_LOGOUT") .. ")"
    end
    name:SetText(friendName)
    if true == ToClient_isTotalGameClient() then
      PaGlobal_FriendList_All_CrossPlayIconSetting(targetPlatformIcon, xboxFriendInfo:getPlatformType(), name)
    end
    control:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_FriendList_All:showXBMenu(" .. index .. ")")
    control:addInputEvent("Mouse_On", "PaGlobal_FriendList_All_SetSelectedXBFriendIndex()")
  end
end
function PaGlobal_FriendList_All_CrossPlayIconSetting(targetPlatformIconControl, friendPlatformType, nameControl)
  targetPlatformIconControl:SetShow(false)
  if nil == friendPlatformType then
    return
  end
  if true == _ContentsGroup_ConsoleIntegration then
    targetPlatformIconControl:SetShow(true)
    local selfPlayerPlatform = ToClient_getGamePlatformType()
    if selfPlayerPlatform == friendPlatformType then
      if __eGAME_PLATFORM_TYPE_PS == selfPlayerPlatform then
        targetPlatformIconControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_ps.dds")
      elseif __eGAME_PLATFORM_TYPE_XB == selfPlayerPlatform then
        targetPlatformIconControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_xb.dds")
      end
    else
      targetPlatformIconControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_other.dds")
    end
    nameControl:SetPosX(targetPlatformIconControl:GetPosY() + targetPlatformIconControl:GetSizeX() + nameControl:GetSpanSize().x)
  end
end
function PaGlobal_FriendList_All_ToggleGroup(id)
  PaGlobal_FriendList_All:hidePopupMenu()
  PaGlobal_FriendList_All._groupListData._selectedGroupIndex = id
  PaGlobal_FriendList_All._friendListData._selectedFriendIndex = nil
  PaGlobal_FriendList_All._listMoveIndex = id
  requestFriendList_checkGroup(PaGlobal_FriendList_All._groupListData._groupInfo[PaGlobal_FriendList_All._groupListData._selectedGroupIndex]:getGroupNo())
end
function PaGlobal_FriendList_All_SetSelectedGroupIndex(index)
  if 0 ~= index then
    PaGlobal_FriendList_All._currentKeyGuideType = PaGlobal_FriendList_All._keyGuideType._Group
  else
    PaGlobal_FriendList_All._currentKeyGuideType = PaGlobal_FriendList_All._keyGuideType._DefaultGroup
  end
  PaGlobal_FriendList_All:updateKeyGuides()
end
function PaGlobal_FriendList_All_SetSelectedFriendIndex()
  PaGlobal_FriendList_All._currentKeyGuideType = PaGlobal_FriendList_All._keyGuideType._Friend
  PaGlobal_FriendList_All:updateKeyGuides()
end
function PaGlobal_FriendList_All_SetSelectedXBFriendIndex()
  PaGlobal_FriendList_All._currentKeyGuideType = PaGlobal_FriendList_All._keyGuideType._XBFriend
  PaGlobal_FriendList_All:updateKeyGuides()
end
function PaGlobal_FriendList_All_OnAddGroupBtn()
  PaGlobal_FriendList_All._currentKeyGuideType = PaGlobal_FriendList_All._keyGuideType._AddGroup
  PaGlobal_FriendList_All:updateKeyGuides()
end
function PaGlobal_FriendList_All_ClickAddFriendButton()
  if nil == Panel_FriendList_All then
    return
  end
  if false == ToClient_isAddFriendAllowed() then
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
  elseif PaGlobal_FriendList_All._tab._pcFriendTab == PaGlobal_FriendList_All._currentTab then
    if false == Panel_FriendList_Add_All:GetShow() then
      PaGlobal_AddFriend_All_Open()
    else
      PaGlobal_AddFriend_All_Close()
    end
  end
end
function PaGlobal_FriendList_All_ShowPSInviteDialog()
  ToClient_showInviteDialog()
end
function PaGlobal_FriendList_All_ChangeTab()
  if nil == Panel_FriendList_All then
    return
  end
  if PaGlobal_FriendList_All._tab._consoleFriendTab == PaGlobal_FriendList_All._currentTab then
    PaGlobal_FriendList_All._currentTab = PaGlobal_FriendList_All._tab._pcFriendTab
  else
    PaGlobal_FriendList_All._currentTab = PaGlobal_FriendList_All._tab._consoleFriendTab
  end
  _AudioPostEvent_SystemUiForXBOX(51, 6)
  PaGlobal_FriendList_All:hidePopupMenu()
  PaGlobal_FriendList_All:updateTab()
  ToClient_padSnapResetControl()
end
function FromClient_NotifyFriendMessage(msgType, strParam1, param1, param2)
  local msgStr = ""
  if 0 == msgType then
    if 1 == param1 then
      msgStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FRIENDS_NOTIFYFRIENDMESSAGE_LOGIN", "strParam1", strParam1)
    elseif 0 == msgType then
      msgStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FRIENDS_NOTIFYFRIENDMESSAGE_LOGOUT", "strParam1", strParam1)
    end
    Proc_ShowMessage_Ack(msgStr)
    PaGlobal_FriendList_All._listMoveIndex = PaGlobal_FriendList_All._ui.list2_Friend:getCurrenttoIndex()
    PaGlobal_FriendList_All:updateTab()
    FromClient_FriendListUpdateLogOnOffForMessanger(param2, param1)
  end
end
function FromClient_FriendDirectlyMessage(fromUserName)
  local directlyYes = function()
    ToClient_RquestDirectlyCompelte(true)
  end
  local directlyNo = function()
    ToClient_RquestDirectlyCompelte(false)
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "FRIEND_TEXT_TITLE"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_XBOX_FRIEND_MESSAGE", "userName", fromUserName),
    functionYes = directlyYes,
    functionNo = directlyNo,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_NoticeNewMessage_All(isSoundNotice, isEffectNotice)
  if nil == Panel_FriendList_All then
    return
  end
  if isEffectNotice and false == Panel_FriendList_All:GetShow() then
    UIMain_FriendListUpdate()
    if false == _ContentsGroup_RemasterUI_Main_Alert then
      UIMain_FriendsUpdate()
    end
  end
  if isSoundNotice then
    audioPostEvent_SystemUi(3, 11)
    _AudioPostEvent_SystemUiForXBOX(3, 11)
  end
end
function FromClient_FriendList_All_ResponseUpdateFriends()
  if nil == Panel_FriendList_All then
    return
  end
  if PaGlobal_FriendList_All._tab._consoleFriendTab == PaGlobal_FriendList_All._currentTab then
    PaGlobal_FriendList_All:updateFriendListForConsole()
  else
    PaGlobal_FriendList_All:updateFriendList()
  end
end
function FromClient_FriendList_All_CantFindFriendForXbox()
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "FRIEND_TEXT_TITLE"),
    content = PAGetString(Defines.StringSheet_SymbolNo, "eErrCantFindFriendForXbox"),
    functionYes = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_FriendList_All_ResponseFriendResult(fromUserName, isAccept)
  local messageStr = ""
  local isAlReadyXboxFriend = ToClient_isAlreadyXboxFriend()
  if true == isAccept then
    if true == isAlReadyXboxFriend then
      messageStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_XBOX_FRIEND_REQUEST_ACCEPT", "characterName", fromUserName)
      local messageBoxDataXX = {
        title = PAGetString(Defines.StringSheet_RESOURCE, "FRIEND_TEXT_TITLE"),
        content = messageStr,
        functionApply = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxDataXX)
      return
    else
      local XboxFriendAsyncCall = function()
        ToClient_addXboxFriendAsync()
      end
      messageStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_XBOX_FRIEND_REQUEST_ACCEPT_AND_XBOX_FRIEND", "characterName", fromUserName)
      local messageBoxDataXX = {
        title = PAGetString(Defines.StringSheet_RESOURCE, "FRIEND_TEXT_TITLE"),
        content = messageStr,
        functionYes = XboxFriendAsyncCall,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxDataXX)
      return
    end
  else
    messageStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_XBOX_FRIEND_REQUEST_REFUSE", "characterName", fromUserName)
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "FRIEND_TEXT_TITLE"),
    content = messageStr,
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_FriendList_All_ShowAni()
  audioPostEvent_SystemUi(1, 0)
  UIAni.AlphaAnimation(1, Panel_FriendList_All, 0, 0.15)
end
function PaGlobal_FriendList_All_HideAni()
  audioPostEvent_SystemUi(1, 1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_FriendList_All, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function PaGlobal_FriendList_All_SetStartPos()
  Panel_FriendList_All:ComputePos()
  PaGlobal_FriendList_All._panelOpenPosX = Panel_FriendList_All:GetPosX() + Panel_FriendList_All:GetSizeX()
  PaGlobal_FriendList_All._panelOpenPosY = Panel_FriendList_All:GetPosY()
end
function FromClient_FriendList_All_OnScreenResize()
  PaGlobal_FriendList_All_SetStartPos()
  PaGlobal_FriendRequest_All_SetBasicPos()
end
function PaGlobal_FriendList_All_ScaleResizingSetPosition()
  Panel_FriendList_All:SetPosX(PaGlobal_FriendList_All._panelOpenPosX - Panel_FriendList_All:GetSizeX())
  Panel_FriendList_All:SetPosY(PaGlobal_FriendList_All._panelOpenPosY)
end
function HandleEventLDown_FriendList_All_ScaleResizeStart()
  PaGlobal_FriendList_All._panelOpenPosX = Panel_FriendList_All:GetPosX() + Panel_FriendList_All:GetSizeX()
  PaGlobal_FriendList_All._panelOpenPosY = Panel_FriendList_All:GetPosY()
  PaGlobal_FriendList_All:hidePopupMenu()
  UI.PanelDynamicSacle_ResizeStart(Panel_FriendList_All)
  PaGlobal_FriendList_All._listMoveIndex = PaGlobal_FriendList_All._ui.list2_Friend:getCurrenttoIndex()
end
function HandleEventLPress_FriendList_All_ScaleResizing()
  UI.PanelDynamicSacle_ResizePressing_Reverse(Panel_FriendList_All)
  PaGlobal_FriendList_All:updateTab()
  PaGlobal_FriendList_All._ui.list2_Friend:requestUpdateVisible()
  PaGlobal_FriendList_All_ScaleResizingSetPosition()
end
function HandleEventLUp_FriendList_All_ScaleResizeEnd()
  UI.PanelDynamicSacle_ResizeEnd(Panel_FriendList_All)
end
