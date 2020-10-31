function PaGlobal_SA_Widget_Party:initialize()
  if true == PaGlobal_SA_Widget_Party._initialize then
    return
  end
  self._ui.stc_partyMeber = UI.getChildControl(Panel_SA_Widget_Party, "Static_PartyMember")
  self:createControl()
  self:initializeDate()
  PaGlobal_SA_Widget_Party:registEventHandler()
  PaGlobal_SA_Widget_Party:validate()
  PaGlobal_SA_Widget_Party._initialize = true
  PaGlobalFunc_SA_Widget_Party_Open()
end
function PaGlobal_SA_Widget_Party:registEventHandler()
  if nil == Panel_SA_Widget_Party then
    return
  end
  registerEvent("ResponseParty_createPartyList", "FromClient_SA_Widget_Party_CreatePartyList")
  registerEvent("ResponseParty_updatePartyList", "FromClient_SA_Widget_Party_UpdatePartyList")
  registerEvent("FromClient_RenderModeChangeState", "PaGlobalFunc_SA_Widget_Party_RenderModeChange")
end
function PaGlobal_SA_Widget_Party:prepareOpen()
  if nil == Panel_SA_Widget_Party then
    return
  end
  PaGlobal_SA_Widget_Party:open()
end
function PaGlobal_SA_Widget_Party:open()
  if nil == Panel_SA_Widget_Party then
    return
  end
  Panel_SA_Widget_Party:SetShow(true)
end
function PaGlobal_SA_Widget_Party:prepareClose()
  if nil == Panel_SA_Widget_Party then
    return
  end
  PaGlobal_SA_Widget_Party:close()
end
function PaGlobal_SA_Widget_Party:close()
  if nil == Panel_SA_Widget_Party then
    return
  end
  Panel_SA_Widget_Party:SetShow(false)
end
function PaGlobal_SA_Widget_Party:update()
  if nil == Panel_SA_Widget_Party then
    return
  end
end
function PaGlobal_SA_Widget_Party:validate()
  if nil == Panel_SA_Widget_Party then
    return
  end
  self._ui.stc_partyMeber:isValidate()
end
function PaGlobal_SA_Widget_Party:createControl()
  if nil == Panel_SA_Widget_Party then
    return
  end
  self._ui.stc_partyMeber:SetShow(false)
  local startPosY = self._ui.stc_partyMeber:GetPosY()
  for index = 1, self._maxPartyMemberCount do
    local info = {}
    info.control = UI.cloneControl(self._ui.stc_partyMeber, Panel_SA_Widget_Party, "Static_PartyMember_" .. index)
    info.control:SetIgnore(false)
    info.control:SetPosY(startPosY + (info.control:GetSizeY() + self._gabY) * (index - 1))
    info.stc_icon = UI.getChildControl(info.control, "Static_PartyMemberIcon_Ethan")
    info.txt_name = UI.getChildControl(info.control, "StaticText_PartyMemberName")
    info.stc_hpBg = UI.getChildControl(info.control, "Static_PartyMemberHP_BG")
    info.progress_hp = UI.getChildControl(info.control, "Progress2_PartyMemberHP")
    info.btn_mic = UI.getChildControl(info.control, "CheckButton_MIC")
    info.btn_headphone = UI.getChildControl(info.control, "CheckButton_Headphone")
    info._prev_CharacterValue_PosX = info.txt_name:GetPosX()
    info._prev_CharacterValue_PosY = info.txt_name:GetPosY()
    info._isBlackSpirit = false
    local colorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
    if 1 <= colorBlindMode then
      info.progress_hp:ChangeTextureInfoName("Renewal/Progress/Console_Progressbar_02.dds")
      local xx1, yy1, xx2, yy2 = setTextureUV_Func(info.progress_hp, 314, 483, 492, 492)
      info.progress_hp:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
      info.progress_hp:setRenderTexture(info.progress_hp:getBaseTexture())
    end
    self._partyMember[index] = info
    info.btn_mic:SetShow(false)
    info.btn_headphone:SetShow(false)
  end
  Panel_SA_Widget_Party:SetSize(Panel_SA_Widget_Party:GetSizeX(), (self._ui.stc_partyMeber:GetSizeY() + self._gabY) * self._maxPartyMemberCount)
  Panel_SA_Widget_Party:ComputePos()
end
function PaGlobal_SA_Widget_Party:initializeDate()
  if nil == Panel_SA_Widget_Party then
    return
  end
  changePositionBySever(Panel_SA_Widget_Party, CppEnums.PAGameUIType.PAGameUIPanel_Party, false, true, false)
  self._partyMemberCount = 0
  self._partyMemberData = {}
end
function PaGlobal_SA_Widget_Party:resetData()
  if nil == Panel_SA_Widget_Party or false == self._initialize then
    return
  end
  self._partyType = ToClient_GetPartyType()
  self._partyMemberCount = RequestParty_getPartyMemberCount()
  self._partyData = {}
end
function PaGlobal_SA_Widget_Party:resetPartyData()
  if nil == Panel_SA_Widget_Party or false == self._initialize then
    return
  end
  self._partyMemberData = {}
  for index = 1, self._maxPartyMemberCount do
    self._partyMember[index].control:SetShow(false)
  end
end
function PaGlobal_SA_Widget_Party:createPartyList()
  if nil == Panel_SA_Widget_Party or false == self._initialize then
    return
  end
  local partyMemberCount = RequestParty_getPartyMemberCount()
  if 1 < partyMemberCount then
    self._partyType = ToClient_GetPartyType()
    if false == isFlushedUI() then
      self:prepareOpen()
    end
    self:updatePartyList()
    self._partyMemberCount = partyMemberCount
  end
end
function PaGlobal_SA_Widget_Party:updatePartyList()
  if nil == Panel_SA_Widget_Party or false == self._initialize then
    return
  end
  local partyMemberCount = RequestParty_getPartyMemberCount()
  if true == Panel_SA_Widget_Party:GetShow() then
    self:resetPartyData()
    self:setPartyMember(partyMemberCount)
    self:setMemberTexture(partyMemberCount)
    if partyMemberCount <= 1 then
      self:prepareOpen()
    end
    self._partyMemberCount = partyMemberCount
  elseif false == Panel_SA_Widget_Party:GetShow() and 1 < partyMemberCount then
    self:createPartyList()
    self:prepareOpen()
  end
end
function PaGlobal_SA_Widget_Party:setPartyMember(partyMemberCount)
  UI.ASSERT_NAME(nil ~= partyMemberCount, "PaGlobal_SA_Widget_Party:setPartyMember\236\157\152 partyMemberCount nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if nil == Panel_SA_Widget_Party or partyMemberCount <= 1 then
    return
  end
  self._partyMemberData = {}
  for index = 0, partyMemberCount - 1 do
    local memberData = RequestParty_getPartyMemberAt(index)
    if nil == memberData then
      return
    end
    local partyMemberInfo = {}
    partyMemberInfo._index = index
    partyMemberInfo._isMaster = memberData._isMaster
    partyMemberInfo._isSelf = RequestParty_isSelfPlayer(index)
    partyMemberInfo._name = memberData:name()
    partyMemberInfo._class = memberData:classType()
    partyMemberInfo._level = memberData._level
    partyMemberInfo._currentHp = memberData._hp * 100
    partyMemberInfo._maxHp = memberData._maxHp
    partyMemberInfo._currentMp = memberData._mp * 100
    partyMemberInfo._maxMp = memberData._maxMp
    partyMemberInfo._distance = memberData:getExperienceGrade()
    table.insert(self._partyMemberData, partyMemberInfo)
  end
  local sortFunc = function(a, b)
    return a._isSelf
  end
  table.sort(self._partyMemberData, sortFunc)
end
function PaGlobal_SA_Widget_Party:setMemberTexture(partyMemberCount)
  UI.ASSERT_NAME(nil ~= partyMemberCount, "PaGlobal_SA_Widget_Party:setMemberTexture\236\157\152 partyMemberCount nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  for index = 1, partyMemberCount do
    if nil ~= self._partyMemberData[index] then
      local characterValue = self._partyMemberData[index]._name
      self._partyMember[index].control:SetShow(true)
      self._partyMember[index].txt_name:SetText(characterValue)
      self._partyMember[index].progress_hp:SetProgressRate(self._partyMemberData[index]._currentHp / self._partyMemberData[index]._maxHp)
      self:setBlackSpritMode(self._partyMember[index], self._partyMemberData[index]._class)
      if self._partyMemberData[index]._class ~= 2 then
        self:setClassIcon(self._partyMember[index]._static_ClassIcon, self._partyMemberData[index]._class)
        self:setStateIcon(self._partyMember[index], self._partyMemberData[index])
      end
    end
  end
  FromClient_SA_Widget_Party_ReSizePanel()
end
function PaGlobal_SA_Widget_Party:setBlackSpritMode(memberControl, class)
  UI.ASSERT_NAME(nil ~= memberControl, "PaGlobal_SA_Widget_Party:setBlackSpritMode\236\157\152 memberControl nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= class, "PaGlobal_SA_Widget_Party:setBlackSpritMode\236\157\152 class nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if CppEnums.ClassType.ClassType_Temp1 == class then
    if true ~= memberControl._isBlackSpirit then
      memberControl.stc_icon:SetShow(false)
      memberControl.stc_hpBg:SetShow(false)
      memberControl.progress_hp:SetShow(false)
      local posX = memberControl.stc_icon:GetPosX() - memberControl.txt_name:GetPosX() - 15
      local posY = memberControl.stc_icon:GetPosY() - memberControl.txt_name:GetPosY()
      memberControl.txt_name:SetPosY(posY)
      memberControl.txt_name:AddEffect("fN_DarkSpirit_Gage_01A", true, posX, 0)
      memberControl._isBlackSpirit = true
    end
  elseif true == memberControl._isBlackSpirit then
    memberControl.txt_name:EraseAllEffect()
    memberControl.txt_name:SetPosX(memberControl._prev_CharacterValue_PosX)
    memberControl.txt_name:SetPosY(memberControl._prev_CharacterValue_PosY)
    memberControl.stc_icon:SetShow(true)
    memberControl.stc_hpBg:SetShow(true)
    memberControl.progress_hp:SetShow(true)
    memberControl._isBlackSpirit = false
  end
end
function PaGlobal_SA_Widget_Party:setClassIcon(control, class)
  if nil == control or nil == class then
    return
  end
  local iconTexture = self._texUV[class]
  if nil == iconTexture then
    return
  end
  control:ChangeTextureInfoName(self._texUV.path)
  local x1, y1, x2, y2 = setTextureUV_Func(control, iconTexture.x1, iconTexture.y1, iconTexture.x2, iconTexture.y2)
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobal_SA_Widget_Party:setStateIcon(memberControl, partyData)
  if nil == memberControl or nil == partyData then
    return
  end
  local isDead = partyData._currentHp <= 0
  control = memberControl.progress_hp
  control:SetShow(false == isDead)
  control = memberControl.stc_hpBg
  control:SetShow(false == isDead)
  local posX = memberControl.txt_name:GetTextSizeX()
  posX = posX + memberControl.txt_name:GetPosX() + 10
  control:SetPosX(posX)
end
function PaGlobal_SA_Widget_Party:renderModeChange(prevRenderModeList, nextRenderModeList)
  UI.ASSERT_NAME(nil ~= prevRenderModeList, "PaGlobal_SA_Widget_Party:renderModeChange\236\157\152 prevRenderModeList nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= nextRenderModeList, "PaGlobal_SA_Widget_Party:renderModeChange\236\157\152 nextRenderModeList nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  if 1 <= RequestParty_getPartyMemberCount() then
    self:resetData()
    self:prepareClose()
  else
    PaGlobalFunc_SA_Widget_Party_Open()
  end
end
