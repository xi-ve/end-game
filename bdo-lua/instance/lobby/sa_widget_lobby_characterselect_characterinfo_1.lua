function PaGlobal_Lobby_CharacterSelect_CharacterInfo:initialize()
  if true == self._initialize then
    return
  end
  if nil == SA_Widget_Lobby_CharacterSelect_CharacterInfo then
    return
  end
  self._ui._Static_WinCount = UI.getChildControl(SA_Widget_Lobby_CharacterSelect_CharacterInfo, "Static_WinCount")
  self._ui._Static_CharacterInfo = UI.getChildControl(SA_Widget_Lobby_CharacterSelect_CharacterInfo, "Static_CharacterInfo")
  self._originCharacterInfoSizeY = self._ui._Static_CharacterInfo:GetSizeY()
  self._ui._Static_SkillInfo = UI.getChildControl(SA_Widget_Lobby_CharacterSelect_CharacterInfo, "Static_SkillInfo")
  self._ui._StaticText_WinIcon = UI.getChildControl(self._ui._Static_WinCount, "StaticText_WinIcon")
  self._ui._Static_StatGraph = UI.getChildControl(self._ui._Static_CharacterInfo, "Static_StatGraph")
  self._ui._StaticText_CharacterName = UI.getChildControl(self._ui._Static_CharacterInfo, "StaticText_CharacterName")
  self._ui._StaticText_ClassName = UI.getChildControl(self._ui._Static_CharacterInfo, "StaticText_ClassName")
  self._ui._StaticText_ClassStory = UI.getChildControl(self._ui._Static_CharacterInfo, "StaticText_ClassStory")
  self._storySpanSizeY = self._ui._StaticText_ClassStory:GetSpanSize().y
  self._textureIndex = 0
  self.slotConfig_Skill.template.effect = self._ui._Static_SkillInfo
  for index = 0, self._maxSkillCount do
    local skill = {slotBG = nil, slot = nil}
    local SkillBG = UI.getChildControl(self._ui._Static_SkillInfo, "Static_SkillSlotBG_" .. index)
    skill.slotBG = UI.getChildControl(SkillBG, "Static_SkillIconBG")
    skill.slot = SlotSkill.new(skill.slot, index, skill.slotBG, self.slotConfig_Skill)
    self._ui._Static_skillName[index] = UI.getChildControl(SkillBG, "StaticText_SkillIcon")
    self._ui._Static_skillDetail[index] = UI.getChildControl(SkillBG, "StaticText_SkillDetail")
    self._ui._Static_SkillSlot[index] = skill
    self._ui._Static_SkillSlot[index].slot.icon:SetHorizonCenter()
    self._ui._Static_SkillSlot[index].slot.icon:SetVerticalMiddle()
  end
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Lobby_CharacterSelect_CharacterInfo:registEventHandler()
  if nil == SA_Widget_Lobby_CharacterSelect_CharacterInfo then
    return
  end
  registerEvent("onScreenResize", "FromClient_PaGlobal_Lobby_CharacterSelect_CharacterInfo_ReSizePanel")
end
function PaGlobal_Lobby_CharacterSelect_CharacterInfo:prepareOpen()
  if nil == SA_Widget_Lobby_CharacterSelect_CharacterInfo then
    return
  end
  local nowSeason = ToClient_BattleRoyaleSeason()
  if nil == nowSeason then
    return
  end
  self._ui._StaticText_CharacterName:SetText("")
  self._ui._StaticText_WinIcon:SetText(self._winGame)
  self._ui._StaticText_WinIcon:ComputePos()
  self._ui._StaticText_ClassName:SetText(self._characterName)
  self._ui._StaticText_ClassName:SetSize(self._ui._StaticText_ClassName:GetTextSizeX(), self._ui._StaticText_ClassName:GetSizeY())
  self._ui._StaticText_ClassName:ComputePos()
  self._ui._StaticText_ClassStory:SetTextVerticalCenter()
  self._ui._StaticText_ClassStory:SetText(self._characterDesc)
  local sizeY = 0
  local padding = 20
  if self._ui._StaticText_ClassStory:GetTextSizeY() > self._ui._StaticText_ClassStory:GetSizeY() then
    local gap = self._ui._StaticText_ClassStory:GetTextSizeY() - self._ui._StaticText_ClassStory:GetSizeY() + padding
    self._ui._StaticText_ClassStory:SetSpanSize(self._ui._StaticText_ClassStory:GetSpanSize().x, self._ui._StaticText_ClassStory:GetSpanSize().y + padding)
    sizeY = self._originCharacterInfoSizeY + gap
  else
    self._ui._StaticText_ClassStory:SetSpanSize(self._ui._StaticText_ClassStory:GetSpanSize().x, self._storySpanSizeY)
    sizeY = self._originCharacterInfoSizeY
  end
  self._ui._Static_CharacterInfo:SetSize(self._ui._Static_CharacterInfo:GetSizeX(), sizeY)
  self._ui._Static_SkillInfo:SetSpanSize(self._ui._Static_SkillInfo:GetSpanSize().x, self._ui._Static_CharacterInfo:GetSizeY())
  self._ui._Static_SkillInfo:ComputePos()
  PaGlobal_Lobby_CharacterSelect_CharacterInfo:open()
end
function PaGlobal_Lobby_CharacterSelect_CharacterInfo:open()
  if nil == SA_Widget_Lobby_CharacterSelect_CharacterInfo then
    return
  end
  SA_Widget_Lobby_CharacterSelect_CharacterInfo:SetShow(true)
end
function PaGlobal_Lobby_CharacterSelect_CharacterInfo:prepareClose()
  if nil == SA_Widget_Lobby_CharacterSelect_CharacterInfo then
    return
  end
  SA_Widget_Lobby_CharacterSelect_CharacterInfo:ClearUpdateLuaFunc()
  PaGlobal_Lobby_CharacterSelect_CharacterInfo:close()
end
function PaGlobal_Lobby_CharacterSelect_CharacterInfo:close()
  if nil == SA_Widget_Lobby_CharacterSelect_CharacterInfo then
    return
  end
  SA_Widget_Lobby_CharacterSelect_CharacterInfo:SetShow(false)
end
function PaGlobal_Lobby_CharacterSelect_CharacterInfo:update()
  if nil == SA_Widget_Lobby_CharacterSelect_CharacterInfo then
    return
  end
end
function PaGlobal_Lobby_CharacterSelect_CharacterInfo:validate()
  if nil == SA_Widget_Lobby_CharacterSelect_CharacterInfo then
    return
  end
  self._ui._Static_WinCount:isValidate()
  self._ui._Static_CharacterInfo:isValidate()
  self._ui._Static_SkillInfo:isValidate()
  self._ui._StaticText_WinIcon:isValidate()
  self._ui._Static_StatGraph:isValidate()
  self._ui._StaticText_CharacterName:isValidate()
  self._ui._StaticText_ClassName:isValidate()
  self._ui._StaticText_ClassStory:isValidate()
  for index = 0, self._maxSkillCount do
    self._ui._Static_skillName[index]:isValidate()
    self._ui._Static_skillDetail[index]:isValidate()
    self._ui._Static_SkillSlot[index].slotBG:isValidate()
  end
end
function PaGlobal_Lobby_CharacterSelect_CharacterInfo:createSkillIcon()
  if nil == SA_Widget_Lobby_CharacterSelect_CharacterInfo then
    return
  end
  for index = 0, self._maxSkillCount do
    local skillKeyIndex = index - 1
    if 0 == index then
      skillKeyIndex = self._rClickSkillKey
    end
    local skillKey = ToClient_GetShadowArenaQuickSkillKey(self._nowSelectClassNo, skillKeyIndex)
    local skillNo = skillKey:getSkillNo()
    local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
    if nil == skillTypeStaticWrapper then
      return
    end
    self._ui._Static_SkillSlot[index].slot:setSkillTypeStatic(skillTypeStaticWrapper)
    self._ui._Static_SkillSlot[index].slot.icon:addInputEvent("Mouse_On", "HandleEventOn_Lobby_CharacterSelect_CharacterInfo_ShowToolTip(true," .. skillNo .. ")")
    self._ui._Static_SkillSlot[index].slot.icon:addInputEvent("Mouse_Out", "HandleEventOn_Lobby_CharacterSelect_CharacterInfo_ShowToolTip(false," .. skillNo .. ")")
    Panel_SkillTooltip_SetPosition(skillNo, self._ui._Static_SkillSlot[index].slot.icon, "LobbySkill")
  end
end
function PaGlobal_Lobby_CharacterSelect_CharacterInfo:setSkillName()
  if nil == SA_Widget_Lobby_CharacterSelect_CharacterInfo then
    return
  end
  local padding = 10
  for index = 0, self._maxSkillCount do
    local skillKeyIndex = index - 1
    if 0 == index then
      skillKeyIndex = self._rClickSkillKey
    end
    local skillKey = ToClient_GetShadowArenaQuickSkillKey(self._nowSelectClassNo, skillKeyIndex)
    local skillNo = skillKey:getSkillNo()
    local skillTypeStatic = getSkillTypeStaticStatus(skillNo)
    if nil ~= skillTypeStatic then
      local skillTitle = skillTypeStatic:getName()
      local skillDetail = ToClient_GetQuickSlotSkillDescription(skillNo)
      self._ui._Static_skillName[index]:SetText(skillTitle)
      self._ui._Static_skillName[index]:SetSize(self._ui._Static_skillName[index]:GetTextSizeX() + padding, self._ui._Static_skillName[index]:GetSizeY())
      self._ui._Static_skillName[index]:ComputePos()
      self._ui._Static_skillName[index]:addInputEvent("Mouse_On", "HandleEventOn_Lobby_CharacterSelect_CharacterInfo_ShowToolTip(true," .. skillNo .. "," .. index .. ")")
      self._ui._Static_skillName[index]:addInputEvent("Mouse_Out", "HandleEventOn_Lobby_CharacterSelect_CharacterInfo_ShowToolTip(false," .. skillNo .. "," .. index .. ")")
      Panel_SkillTooltip_SetPosition(skillNo, self._ui._Static_SkillSlot[index].slot.icon, "LobbySkill")
      self._ui._Static_skillDetail[index]:SetTextMode(CppEnums.TextMode.eTextMode_AutoWrap)
      self._ui._Static_skillDetail[index]:SetText(skillDetail)
      self._ui._Static_skillDetail[index]:ComputePos()
    end
  end
end
function PaGlobal_Lobby_CharacterSelect_CharacterInfo:resizePanel()
  if nil == SA_Widget_Lobby_CharacterSelect_CharacterInfo then
    return
  end
  SA_Widget_Lobby_CharacterSelect_CharacterInfo:ComputePos()
  self._ui._Static_WinCount:ComputePos()
  self._ui._Static_CharacterInfo:ComputePos()
  self._ui._Static_SkillInfo:ComputePos()
  self._ui._StaticText_WinIcon:ComputePos()
  self._ui._Static_StatGraph:ComputePos()
  self._ui._StaticText_CharacterName:ComputePos()
  self._ui._StaticText_ClassName:ComputePos()
  self._ui._StaticText_ClassStory:ComputePos()
  for index = 0, self._maxSkillCount do
    self._ui._Static_skillName[index]:ComputePos()
    self._ui._Static_skillDetail[index]:ComputePos()
    self._ui._Static_SkillSlot[index].slotBG:ComputePos()
    self._ui._Static_SkillSlot[index].slot.icon:ComputePos()
    self._ui._Static_SkillSlot[index].slot.icon:SetHorizonCenter()
    self._ui._Static_SkillSlot[index].slot.icon:SetVerticalMiddle()
  end
  self._originCharacterInfoSizeY = self._ui._Static_CharacterInfo:GetSizeY()
  self._storySpanSizeY = self._ui._StaticText_ClassStory:GetSpanSize().y
end
