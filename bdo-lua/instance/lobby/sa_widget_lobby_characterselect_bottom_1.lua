function PaGlobal_Lobby_CharacterSelect_Bottom:initialize()
  if true == self._initialize then
    return
  end
  if nil == SA_Widget_Lobby_CharacterSelect_Bottom then
    return
  end
  self._ui._Static_CountDownGroup = UI.getChildControl(SA_Widget_Lobby_CharacterSelect_Bottom, "Static_CountDownGroup")
  self._ui._StaticText_CountDown = UI.getChildControl(self._ui._Static_CountDownGroup, "StaticText_CountDown")
  self._ui._StaticText_CountDownInfo = UI.getChildControl(self._ui._Static_CountDownGroup, "StaticText_CountDown_Info")
  self._ui._Static_CountDownGaugeBG = UI.getChildControl(self._ui._Static_CountDownGroup, "Static_CountDownGaugeBG")
  self._ui._Progress2_CountDownGauge = UI.getChildControl(self._ui._Static_CountDownGroup, "Progress2_CountDownGauge")
  self._ui._Button_Ready = UI.getChildControl(self._ui._Static_CountDownGroup, "Button_Ready")
  self._ui._Progress2_1_Bar_Head = UI.getChildControl(self._ui._Progress2_CountDownGauge, "Progress2_1_Bar_Head")
  self._ui.stc_teamBG = UI.getChildControl(self._ui._Static_CountDownGroup, "Static_Team")
  self._ui.btn_teamReady = UI.getChildControl(self._ui.stc_teamBG, "Button_Team_Ready")
  self._ui.stc_invitePopUp = UI.getChildControl(self._ui._Static_CountDownGroup, "Static_Popup_Invite")
  self._ui.btn_inviteFriend = UI.getChildControl(self._ui.stc_invitePopUp, "RadioButton_Friend")
  self._ui.btn_autoMatch = UI.getChildControl(self._ui.stc_invitePopUp, "RadioButton_AutoMatch")
  self._ui.stc_friendListPopup = UI.getChildControl(self._ui._Static_CountDownGroup, "Static_Popup_Friend_List")
  self._ui.btn_friendListClose = UI.getChildControl(self._ui.stc_friendListPopup, "Button_Close")
  self._ui.list2_friendList = UI.getChildControl(self._ui.stc_friendListPopup, "List2_1")
  self._ui.list2_friendList:createChildContent(CppEnums.PAUIList2ElementManagerType.list)
  self._ui.list2_friendList:setNotImpactScrollEvent(true)
  self:initTeamControl()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Lobby_CharacterSelect_Bottom:registEventHandler()
  if nil == SA_Widget_Lobby_CharacterSelect_Bottom then
    return
  end
  self._ui._Button_Ready:addInputEvent("Mouse_LUp", "HandleEventLup_CharacterSelect_Bottom_Ready()")
  self._ui.btn_teamReady:addInputEvent("Mouse_LUp", "HandleEventLup_CharacterSelect_Bottom_Ready()")
  for teamIdx = 1, self._maxTeamCount do
    self._ui.stc_member[teamIdx].btn_add:addInputEvent("Mouse_LUp", "HandleEventLup_CharacterSelect_Bottom_ShowInvitePopUp(" .. tostring(teamIdx) .. ")")
    self._ui.stc_member[teamIdx].btn_ready:addInputEvent("Mouse_LUp", "HandleEventLup_CharacterSelect_Bottom_AnotherTeammateReady(" .. tostring(teamIdx) .. ")")
  end
  self._ui.btn_inviteFriend:addInputEvent("Mouse_LUp", "HandleEventLup_CharacterSelect_Bottom_ShowFriendList()")
  self._ui.btn_friendListClose:addInputEvent("Mouse_LUp", "HandleEventLup_CharacterSelect_Bottom_CloseFriendList()")
  self._ui.list2_friendList:registEvent(CppEnums.PAUIList2EventType.luaChangeContent, "PaGlobal_Lobby_CharacterSelect_Bottom_UpdateFriendList")
  registerEvent("FromClient_UpdatePartyMemberSlotOnlyForSA", "PaGlobal_Lobby_CharacterSelect_Bottom_UpdatePartyMemberSlot")
end
function PaGlobal_Lobby_CharacterSelect_Bottom:prepareOpen(mode)
  if nil == SA_Widget_Lobby_CharacterSelect_Bottom then
    return
  end
  self:updateFriendList()
  self._selectedMode = mode
  self._currentTeamCount = 0
  self._updateCount = 0
  self._ui._StaticText_CountDown:SetText(self._endCount)
  self:openUISetting()
  self:open()
  SA_Widget_Lobby_CharacterSelect_Bottom:RegisterUpdateFunc("PaGlobal_Lobby_CharacterSelect_Bottom_UpdatePerFrame")
end
function PaGlobal_Lobby_CharacterSelect_Bottom:open()
  if nil == SA_Widget_Lobby_CharacterSelect_Bottom then
    return
  end
  SA_Widget_Lobby_CharacterSelect_Bottom:SetShow(true)
end
function PaGlobal_Lobby_CharacterSelect_Bottom:prepareClose()
  if nil == SA_Widget_Lobby_CharacterSelect_Bottom then
    return
  end
  SA_Widget_Lobby_CharacterSelect_Bottom:ClearUpdateLuaFunc()
  self:close()
end
function PaGlobal_Lobby_CharacterSelect_Bottom:close()
  if nil == SA_Widget_Lobby_CharacterSelect_Bottom then
    return
  end
  SA_Widget_Lobby_CharacterSelect_Bottom:SetShow(false)
end
function PaGlobal_Lobby_CharacterSelect_Bottom:update()
  if nil == SA_Widget_Lobby_CharacterSelect_Bottom then
    return
  end
end
function PaGlobal_Lobby_CharacterSelect_Bottom:initTeamControl()
  for index = 1, self._maxTeamCount do
    local memberBG = UI.getChildControl(self._ui.stc_teamBG, "Static_Member_0" .. index)
    local inviteBG = UI.getChildControl(memberBG, "Static_Invite")
    local waitBG = UI.getChildControl(memberBG, "Static_Wait")
    local readyBG = UI.getChildControl(memberBG, "Static_Ready")
    local member = {
      stc_memberBG = memberBG,
      stc_inviteBG = inviteBG,
      btn_add = UI.getChildControl(inviteBG, "Button_Normal"),
      stc_add = UI.getChildControl(inviteBG, "Static_Add"),
      stc_waitBG = waitBG,
      btn_wait = UI.getChildControl(waitBG, "Button_Wait"),
      stc_waitIcon = UI.getChildControl(waitBG, "Static_Wait_Icon"),
      stc_readyBG = readyBG,
      btn_ready = UI.getChildControl(readyBG, "Button_Ready"),
      stc_characterImg = UI.getChildControl(readyBG, "Static_Character_Img"),
      stc_readyCheck = UI.getChildControl(memberBG, "Static_Ready_Check")
    }
    self._ui.stc_member[index] = member
  end
end
function PaGlobal_Lobby_CharacterSelect_Bottom:openUISetting()
  local isTeam = false
  if __eBattleRoyaleMode_Team == self._selectedMode then
    isTeam = true
  end
  for index = 1, self._maxTeamCount do
    self._ui.stc_member[index].stc_memberBG:SetShow(isTeam)
    self._ui.stc_member[index].stc_inviteBG:SetShow(isTeam)
    self._ui.stc_member[index].btn_add:SetShow(isTeam)
    self._ui.stc_member[index].stc_add:SetShow(isTeam)
    self._ui.stc_member[index].stc_waitBG:SetShow(false)
    self._ui.stc_member[index].btn_wait:SetShow(false)
    self._ui.stc_member[index].stc_waitIcon:SetShow(false)
    self._ui.stc_member[index].stc_readyBG:SetShow(false)
    self._ui.stc_member[index].btn_ready:SetShow(false)
    self._ui.stc_member[index].stc_characterImg:SetShow(false)
    self._ui.stc_member[index].stc_readyCheck:SetShow(false)
  end
  self._ui._StaticText_CountDown:SetShow(isTeam)
  self._ui._StaticText_CountDownInfo:SetShow(isTeam)
  self._ui.stc_teamBG:SetShow(isTeam)
  self._ui.btn_teamReady:SetShow(isTeam)
  self._ui.stc_friendListPopup:SetShow(false)
  self._ui._Button_Ready:SetShow(false == isTeam)
end
function PaGlobal_Lobby_CharacterSelect_Bottom:validate()
  if nil == SA_Widget_Lobby_CharacterSelect_Bottom then
    return
  end
  self._ui._Static_CountDownGroup:isValidate()
  self._ui._StaticText_CountDown:isValidate()
  self._ui._StaticText_CountDownInfo:isValidate()
  self._ui._Static_CountDownGaugeBG:isValidate()
  self._ui._Progress2_CountDownGauge:isValidate()
  self._ui._Button_Ready:isValidate()
  self._ui._Progress2_1_Bar_Head:isValidate()
  self._ui.stc_teamBG:isValidate()
  self._ui.btn_teamReady:isValidate()
  self._ui.stc_invitePopUp:isValidate()
  self._ui.btn_inviteFriend:isValidate()
  self._ui.btn_autoMatch:isValidate()
  self._ui.stc_friendListPopup:isValidate()
  self._ui.btn_friendListClose:isValidate()
  self._ui.list2_friendList:isValidate()
  for index = 1, self._maxTeamCount do
    self._ui.stc_member[index].stc_memberBG:isValidate()
    self._ui.stc_member[index].stc_inviteBG:isValidate()
    self._ui.stc_member[index].btn_add:isValidate()
    self._ui.stc_member[index].stc_add:isValidate()
    self._ui.stc_member[index].stc_waitBG:isValidate()
    self._ui.stc_member[index].btn_wait:isValidate()
    self._ui.stc_member[index].stc_waitIcon:isValidate()
    self._ui.stc_member[index].stc_readyBG:isValidate()
    self._ui.stc_member[index].btn_ready:isValidate()
    self._ui.stc_member[index].stc_characterImg:isValidate()
    self._ui.stc_member[index].stc_readyCheck:isValidate()
  end
end
function PaGlobal_Lobby_CharacterSelect_Bottom:updateFriendList()
  self._ui.list2_friendList:getElementManager():clearKey()
  local friendGroupCount = RequestFriends_getFriendGroupCount()
  for groupIdx = 0, friendGroupCount - 1 do
    local friendGroup = RequestFriends_getFriendGroupAt(groupIdx)
    if nil ~= friendGroup then
      local friendCount = friendGroup:getFriendCount()
      for friendIdx = 0, friendCount - 1 do
        self._ui.list2_friendList:getElementManager():pushKey(toUint64(groupIdx, friendIdx))
      end
    end
  end
end
function PaGlobal_Lobby_CharacterSelect_Bottom:changePartyMemberImg(memberIdx, partyMember)
  if nil == SA_Widget_Lobby_CharacterSelect_Bottom then
    return
  end
  if nil == partyMember then
    return
  end
  local class = partyMember:classType()
  local UVInfo = PaGlobal_Lobby_CharacterSelect_Bottom._characterIconUV[class]
  if nil == UVInfo then
    return
  end
  local member = PaGlobal_Lobby_CharacterSelect_Bottom._ui.stc_member[memberIdx]
  local x1, y1, x2, y2 = setTextureUV_Func(member.stc_characterImg, UVInfo.x1, UVInfo.y1, UVInfo.x2, UVInfo.y2)
  member.stc_characterImg:getBaseTexture():setUV(x1, y1, x2, y2)
  member.stc_characterImg:setRenderTexture(member.stc_characterImg:getBaseTexture())
end
function PaGlobal_Lobby_CharacterSelect_Bottom:updatePartyMemberSlot()
  if nil == SA_Widget_Lobby_CharacterSelect_Bottom then
    return
  end
  local partyMemberCount = RequestParty_getPartyMemberCount()
  local memberIdx = 1
  for idx = 1, partyMemberCount do
    if memberIdx > self._maxTeamCount then
      return
    end
    local isSelfPlayer = RequestParty_isSelfPlayer(idx)
    local partyMember = RequestParty_getPartyMemberAt(idx)
    if false == isSelfPlayer then
      if nil ~= partyMember then
        local name = partyMember:name()
        self._ui.stc_member[memberIdx].stc_inviteBG:SetShow(false)
        self._ui.stc_member[memberIdx].stc_waitBG:SetShow(false)
        self._ui.stc_member[memberIdx].stc_readyBG:SetShow(true)
        self._ui.stc_member[memberIdx].btn_ready:SetText(name)
        self._ui.stc_member[memberIdx].btn_ready:SetShow(true)
        self._ui.stc_member[memberIdx].stc_characterImg:SetShow(true)
        self.changePartyMemberImg(memberIdx, partyMember)
      else
        self._ui.stc_member[memberIdx].stc_inviteBG:SetShow(true)
        self._ui.stc_member[memberIdx].stc_waitBG:SetShow(false)
        self._ui.stc_member[memberIdx].stc_readyBG:SetShow(false)
        self._ui.stc_member[memberIdx].btn_ready:SetText("")
        self._ui.stc_member[memberIdx].btn_ready:SetShow(false)
        self._ui.stc_member[memberIdx].stc_characterImg:SetShow(false)
      end
      memberIdx = memberIdx + 1
    end
  end
end
function PaGlobal_Lobby_CharacterSelect_Bottom:inviteFriendAtParty(groupIdx, friendIdx)
  if nil == SA_Widget_Lobby_CharacterSelect_Bottom then
    return
  end
  PaGlobal_Lobby_CharacterSelect_Bottom._ui.stc_friendListPopup:SetShow(false)
  local friendGroup = RequestFriends_getFriendGroupAt(groupIdx)
  if nil == friendGroup then
    return
  end
  local friend = friendGroup:getFriendAt(friendIdx)
  if nil == friend then
    return
  end
  local friendUserNo = friend:getUserNo()
  ToClient_ShadowArenaJoinParty(friendUserNo)
end
function PaGlobal_Lobby_CharacterSelect_Bottom:CountUpdate(deltaTime)
  if nil == SA_Widget_Lobby_CharacterSelect_Bottom then
    return
  end
  if self._currentTeamCount < self._maxTeamCount then
    return
  end
  self._updateCount = self._updateCount + deltaTime
  local currentCount = self._endCount - self._updateCount
  self._ui._StaticText_CountDown:SetText(tostring(math.ceil(currentCount)))
  if currentCount <= 0 then
    SA_Widget_Lobby_CharacterSelect_Bottom:ClearUpdateLuaFunc()
    self._ui._StaticText_CountDown:SetShow(false)
    HandleEventLup_CharacterSelect_Bottom_Ready()
  end
end
function PaGlobal_Lobby_CharacterSelect_Bottom:CheckAllTeamReady(deltaTime)
  if nil == SA_Widget_Lobby_CharacterSelect_Bottom then
    return
  end
  self._currentReadyCount = 0
  for idx = 1, self._maxTeamCount do
    local member = self._ui.stc_member[idx]
    local isShow = member.stc_readyCheck:GetShow()
    if true == isShow then
      self._currentReadyCount = self._currentReadyCount + 1
    end
  end
  if self._currentReadyCount == self._maxTeamCount then
    SA_Widget_Lobby_CharacterSelect_Bottom:ClearUpdateLuaFunc()
    self._ui._StaticText_CountDown:SetShow(false)
    HandleEventLup_CharacterSelect_Bottom_Ready()
  end
end
