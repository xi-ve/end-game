function PaGlobal_ThornCastle_Member:initialize()
  if true == PaGlobal_ThornCastle_Member._initialize then
    return
  end
  self._ui._memberTemplate = UI.getChildControl(Panel_Widget_ThornCastle_Member, "Static_PartyMember_Template")
  PaGlobal_ThornCastle_Member:registEventHandler()
  PaGlobal_ThornCastle_Member:validate()
  PaGlobal_ThornCastle_Member._initialize = true
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_OthilitaDungeon) then
    PaGlobal_ThornCastle_Member:prepareOpen()
  end
end
function PaGlobal_ThornCastle_Member:createTeamUi()
  if nil == Panel_Widget_ThornCastle_Member then
    return
  end
  if true == self._isCreate then
    return
  end
  local teamUserCount = 5
  for userIndex = 0, teamUserCount - 1 do
    local temp = {}
    local gab = 5
    temp._memberBg = UI.cloneControl(self._ui._memberTemplate, Panel_Widget_ThornCastle_Member, "Static_Othilita_Team_List_" .. userIndex)
    temp._memberBg:SetPosY(self._ui._memberTemplate:GetPosY() + (temp._memberBg:GetSizeY() + gab) * userIndex)
    temp._hpBar = UI.getChildControl(temp._memberBg, "Progress2_Hp")
    temp._mpBar = UI.getChildControl(temp._memberBg, "Progress2_Mp")
    temp._classIcon = UI.getChildControl(temp._memberBg, "Static_ClassIcon")
    temp._leaderBg = UI.getChildControl(temp._memberBg, "Static_ClassIconLeaderBg")
    temp._level = UI.getChildControl(temp._memberBg, "StaticText_CharacterLevelValue")
    temp._name = UI.getChildControl(temp._memberBg, "StaticText_CharacterNameValue")
    temp._deadState = UI.getChildControl(temp._memberBg, "Static_DeadState")
    temp._point = UI.getChildControl(temp._memberBg, "StaticText_PointValue")
    temp._leaderBg:SetShow(false)
    self._teamMemberUi[userIndex] = temp
  end
  self:settingTeamUi()
  self._isCreate = true
  self._ui._memberTemplate:SetShow(false)
end
function PaGlobal_ThornCastle_Member:settingTeamUi()
  local teamUserCount = 5
  for userIndex = 0, teamUserCount - 1 do
    local memberData = RequestParty_getPartyMemberAt(userIndex)
    if nil ~= memberData then
      if true == memberData._isMaster then
        self._teamMemberUi[userIndex]._leaderBg:SetShow(true)
      end
      local isDead = 0 >= memberData._hp
      self._teamMemberUi[userIndex]._deadState:SetShow(isDead)
      self._teamMemberUi[userIndex]._hpBar:SetShow(not isDead)
      self._teamMemberUi[userIndex]._mpBar:SetShow(not isDead)
      self._teamMemberUi[userIndex]._hpBar:SetProgressRate(memberData._hp * 100 / memberData._maxHp)
      self._teamMemberUi[userIndex]._mpBar:SetProgressRate(memberData._mp * 100 / memberData._maxMp)
      local classType = memberData:classType()
      PaGlobalFunc_Util_ChangeTextureClass(self._teamMemberUi[userIndex]._classIcon, classType)
      self._teamMemberUi[userIndex]._level:SetText("Lv." .. tostring(memberData._level))
      self._teamMemberUi[userIndex]._name:SetText(memberData:name())
      self._teamMemberUi[userIndex]._point:SetText(tostring(memberData._instanceDungeonPoint) .. "P")
    else
      self._teamMemberUi[userIndex]._memberBg:SetShow(false)
    end
  end
end
function PaGlobal_ThornCastle_Member:updatePartyList()
  if nil == Panel_Widget_ThornCastle_Member then
    return
  end
  if false == Panel_Widget_ThornCastle_Member:GetShow() then
    PaGlobal_ThornCastle_Member:prepareOpen()
  end
  PaGlobal_ThornCastle_Member:settingTeamUi()
end
function PaGlobal_ThornCastle_Member:registEventHandler()
  if nil == Panel_Widget_ThornCastle_Member then
    return
  end
end
function PaGlobal_ThornCastle_Member:prepareOpen()
  if nil == Panel_Widget_ThornCastle_Member then
    return
  end
  if false == self._isCreate then
    self:createTeamUi()
  end
  PaGlobal_ThornCastle_Member:open()
end
function PaGlobal_ThornCastle_Member:open()
  if nil == Panel_Widget_ThornCastle_Member then
    return
  end
  Panel_Widget_ThornCastle_Member:SetShow(true)
end
function PaGlobal_ThornCastle_Member:prepareClose()
  if nil == Panel_Widget_ThornCastle_Member then
    return
  end
  PaGlobal_ThornCastle_Member:close()
end
function PaGlobal_ThornCastle_Member:close()
  if nil == Panel_Widget_ThornCastle_Member then
    return
  end
  Panel_Widget_ThornCastle_Member:SetShow(false)
end
function PaGlobal_ThornCastle_Member:update()
  if nil == Panel_Widget_ThornCastle_Member then
    return
  end
end
function PaGlobal_ThornCastle_Member:validate()
  if nil == Panel_Widget_ThornCastle_Member then
    return
  end
  self._ui._memberTemplate:isValidate()
end
