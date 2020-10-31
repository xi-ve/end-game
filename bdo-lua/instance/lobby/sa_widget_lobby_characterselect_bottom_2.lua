function PaGlobal_Lobby_CharacterSelect_Bottom_ReSizePanel()
  if nil == PaGlobal_Lobby_CharacterSelect_Bottom then
    return
  end
end
function PaGlobal_Lobby_CharacterSelect_Bottom_Open(mode)
  if nil == PaGlobal_Lobby_CharacterSelect_Bottom then
    return
  end
  PaGlobal_Lobby_CharacterSelect_Bottom:prepareOpen(mode)
end
function PaGlobal_Lobby_CharacterSelect_Bottom_Close()
  if nil == PaGlobal_Lobby_CharacterSelect_Bottom then
    return
  end
  PaGlobal_Lobby_CharacterSelect_Bottom:prepareClose()
end
function HandleEventLup_CharacterSelect_Bottom_Ready()
  if nil == SA_Widget_Lobby_CharacterSelect_Bottom then
    return
  end
  local selectedBettingKey = ToClient_GetBettingScoreKey(0)
  local characterSelectList = PaGlobal_Lobby_CharacterSelect_List
  if nil == characterSelectList then
    return
  end
  local characterSelectItemSlot = PaGlobal_Lobby_CharacterSelect_ItemSlot
  if nil == characterSelectItemSlot then
    return
  end
  local classNo = characterSelectList._nowSelectClassNo
  local itemData = characterSelectItemSlot._itemData
  itemData:setClassType(classNo)
  ToClient_SelectBattleRoyaleData(itemData)
  ToClient_BattleRoyaleJoinQueue(PaGlobal_Lobby_CharacterSelect_Bottom._selectedMode, selectedBettingKey)
end
function HandleEventLup_CharacterSelect_Bottom_ShowInvitePopUp(index)
  PaGlobal_Lobby_CharacterSelect_Bottom._ui.stc_invitePopUp:SetShow(true)
end
function HandleEventLup_CharacterSelect_Bottom_AnotherTeammateReady(index)
  local member = PaGlobal_Lobby_CharacterSelect_Bottom._ui.stc_member[index]
  local isShow = not member.stc_readyCheck:GetShow()
  member.stc_readyCheck:SetShow(isShow)
end
function HandleEventLup_CharacterSelect_Bottom_ShowFriendList()
  PaGlobal_Lobby_CharacterSelect_Bottom._ui.stc_invitePopUp:SetShow(false)
  PaGlobal_Lobby_CharacterSelect_Bottom._ui.stc_friendListPopup:SetShow(true)
end
function HandleEventLup_CharacterSelect_Bottom_CloseFriendList()
  PaGlobal_Lobby_CharacterSelect_Bottom._ui.stc_friendListPopup:SetShow(false)
end
function PaGlobal_Lobby_CharacterSelect_Bottom_UpdateFriendList(content, key)
  local groupIdx = highFromUint64(key)
  local friendIdx = lowFromUint64(key)
  local friendGroup = RequestFriends_getFriendGroupAt(groupIdx)
  if nil == friendGroup then
    return
  end
  local friend = friendGroup:getFriendAt(friendIdx)
  if nil == friend then
    return
  end
  local friendName = friend:getName()
  local friendButton = UI.getChildControl(content, "RadioButton_Friend_ID")
  friendButton:SetText(friendName)
  friendButton:addInputEvent("Mouse_LUp", "PaGlobal_Lobby_CharacterSelect_Bottom:inviteFriendAtParty(" .. tostring(groupIdx) .. ", " .. tostring(friendIdx) .. ")")
end
function PaGlobal_Lobby_CharacterSelect_Bottom_UpdatePartyMemberSlot()
  local isOpenLobbyMainUI = PaGlobal_Lobby_MainMenu._isOpenLobbyMainUI
  if nil ~= isOpenLobbyMainUI or true == isOpenLobbyMainUI then
    InitializeCharacterSelectMenu(__eBattleRoyaleMode_Team)
  end
  PaGlobal_Lobby_CharacterSelect_Bottom:updatePartyMemberSlot()
end
function PaGlobal_Lobby_CharacterSelect_Bottom_UpdatePerFrame(deltaTime)
  PaGlobal_Lobby_CharacterSelect_Bottom:CountUpdate(deltaTime)
  PaGlobal_Lobby_CharacterSelect_Bottom:CheckAllTeamReady(deltaTime)
end
