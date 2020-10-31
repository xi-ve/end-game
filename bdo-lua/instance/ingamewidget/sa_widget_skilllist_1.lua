function PaGlobal_SA_Widget_SkillList:initialize()
  if true == self._initialize then
    return
  end
  for idx = 1, self._maxSkillCnt do
    self._ui.stc_skillBG[idx] = UI.getChildControl(Panel_SA_SkillList, "Static_Skill_0" .. idx)
  end
  self._SKILLBG_ORIGIN_SIZEY = self._ui.stc_skillBG[1]:GetSizeY()
  self._PANEL_ORIGIN_SIZEY = Panel_SA_SkillList:GetSizeY()
  self._ui.stc_skillUpgrade = UI.getChildControl(Panel_SA_SkillList, "Static_SkillUpgrade")
  self._ui.stc_upgradeNew = UI.getChildControl(self._ui.stc_skillUpgrade, "Static_Upgrade_New")
  self._ui.stc_ctrlIcon = UI.getChildControl(self._ui.stc_skillUpgrade, "StaticText_Ctrl")
  self._ui.stc_upgradeIcon = UI.getChildControl(self._ui.stc_skillUpgrade, "Static_UpgradeIcon")
  self._ui.txt_skillPoint = UI.getChildControl(self._ui.stc_skillUpgrade, "StaticText_SkillPoint")
  self:registEventHandler()
  self:validate()
  self:createControl()
  self:prepareOpen()
  self._initialize = true
  self._isOpen = true
  self._ui.stc_upgradeIcon:SetShow(false)
  self._ui.txt_skillPoint:SetShow(false)
  self._ui.stc_upgradeNew:SetShow(false)
end
function PaGlobal_SA_Widget_SkillList:registEventHandler()
  if nil == Panel_SA_SkillList then
    return
  end
  registerEvent("onScreenResize", "FromClient_SA_Widget_SkillList_ReSizePanel")
  registerEvent("EventlearnedSkill", "PaGlobal_SA_Widget_SkillList_ChangeSkillInfo")
  registerEvent("EventlearnedSkill", "PaGlobal_SA_Widget_SkillList_UpSkillLevel")
  registerEvent("FromClient_SelfPlayerCombatSkillPointChanged", "PaGlobal_SA_Widget_SkillList_ChangeSkillPoint")
  registerEvent("refreshQuickSlot_ack", "PaGlobal_SA_Widget_SkillList_ChangeSkillInfo")
  registerEvent("FromClient_InventoryUpdate", "PaGlobal_SA_Widget_SkillList_ChangeSkillInfo")
end
function PaGlobal_SA_Widget_SkillList:prepareOpen()
  if nil == Panel_SA_SkillList then
    return
  end
  self._isOpen = true
  for idx = 1, self._maxSkillCnt do
    PaGlobal_SA_Widget_SkillList_ChangeSkillLevel(idx)
  end
  PaGlobal_SA_Widget_SkillList_ChangeSkillPoint()
  PaGlobal_SA_Widget_SkillList:open()
end
function PaGlobal_SA_Widget_SkillList:open()
  if nil == Panel_SA_SkillList then
    return
  end
  Panel_SA_SkillList:SetShow(true)
end
function PaGlobal_SA_Widget_SkillList:prepareClose()
  if nil == Panel_SA_SkillList then
    return
  end
  PaGlobal_SA_Widget_SkillList:close()
end
function PaGlobal_SA_Widget_SkillList:close()
  if nil == Panel_SA_SkillList then
    return
  end
  Panel_SA_SkillList:SetShow(false)
end
function PaGlobal_SA_Widget_SkillList:update()
  if nil == Panel_SA_SkillList then
    return
  end
end
function PaGlobal_SA_Widget_SkillList:validate()
  if nil == Panel_SA_SkillList then
    return
  end
  for idx = 1, self._maxSkillCnt do
    self._ui.stc_skillBG[idx]:isValidate()
  end
  self._ui.stc_skillUpgrade:isValidate()
  self._ui.stc_ctrlIcon:isValidate()
  self._ui.stc_upgradeIcon:isValidate()
  self._ui.txt_skillPoint:isValidate()
  self._ui.stc_upgradeNew:isValidate()
end
function PaGlobal_SA_Widget_SkillList:createControl()
  for idx = 1, self._maxSkillCnt do
    local skill = {
      skillSlotBG = nil,
      skillCommandBG = nil,
      skillCommand = {},
      skillIcon = {},
      skillName = nil,
      skillLearningCondition = nil,
      skillLevel = nil,
      skillLev = 0,
      skillSlotUpgradeIcon = nil,
      skillUpIcon = nil,
      skillMaxIcon = nil,
      skillNo = -1,
      skillKey = nil,
      isUpdate = false
    }
    skill.skillSlotBG = UI.getChildControl(self._ui.stc_skillBG[idx], "Static_SkillList")
    skill.skillCommandBG = UI.getChildControl(skill.skillSlotBG, "Static_SkillCommand")
    self.slotConfig_Skill.template.effect = UI.getChildControl(skill.skillSlotBG, "Static_SkillIcon")
    for commandIdx = 1, 4 do
      skill.skillCommand[commandIdx] = UI.getChildControl(skill.skillCommandBG, "Static_SkillCommand_" .. commandIdx)
      skill.skillCommand[commandIdx]:SetShow(false)
    end
    skill.skillCommand[idx]:SetShow(true)
    local skillSlotIcon = UI.getChildControl(skill.skillSlotBG, "Static_SkillIcon")
    SlotSkill.new(skill.skillIcon, idx, skillSlotIcon, self.slotConfig_Skill)
    skill.skillName = UI.getChildControl(skill.skillSlotBG, "StaticText_SkillName")
    skill.skillLearningCondition = UI.getChildControl(skill.skillSlotBG, "StaticText_LearningCondition")
    skill.skillLevel = UI.getChildControl(skill.skillSlotBG, "Static_SkillLevel_LearenedIcon")
    skill.skillSlotUpgradeIcon = UI.getChildControl(skill.skillSlotBG, "Static_Upgrade_Icon")
    skill.skillUpIcon = UI.getChildControl(skill.skillSlotUpgradeIcon, "Static_Up")
    skill.skillMaxIcon = UI.getChildControl(skill.skillSlotUpgradeIcon, "Static_Max")
    local padding = 1
    self._skillSlot[idx] = skill
    self._skillSlot[idx].skillIcon.icon:ComputePos()
    local posX = self._skillSlot[idx].skillIcon.icon:GetPosX() + padding
    local posY = self._skillSlot[idx].skillIcon.icon:GetPosY() + padding
    self._skillSlot[idx].skillIcon.icon:SetPosXY(posX, posY)
    self._skillSlot[idx].skillSlotBG:addInputEvent("Mouse_LUp", "HandleEventLUp_SA_Widget_SkillList_LearnSkill(" .. idx .. ")")
    self._skillSlot[idx].skillIcon.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_SA_Widget_SkillList_LearnSkill(" .. idx .. ")")
    self:setSkillInfo(idx)
  end
end
function PaGlobal_SA_Widget_SkillList:setSkillInfo(idx)
  local quickSlotKey = idx - 1
  local quickSlotInfo = getQuickSlotItem(quickSlotKey)
  if nil == quickSlotInfo then
    return
  end
  local skillNo = quickSlotInfo._skillKey:getSkillNo()
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  if nil == skillTypeStaticWrapper then
    return
  end
  self._skillSlot[idx].skillName:SetTextMode(CppEnums.TextMode.eTextMode_AutoWrap)
  self._skillSlot[idx].skillName:SetText(skillTypeStaticWrapper:getName())
  self._skillSlot[idx].skillLearningCondition:SetTextMode(CppEnums.TextMode.eTextMode_AutoWrap)
  self._skillSlot[idx].skillLearningCondition:SetText(ToClient_GetQuickSlotSkillDescription(skillNo))
  self._skillSlot[idx].skillKey = quickSlotInfo._skillKey
  self._skillSlot[idx].skillIcon:setSkillTypeStatic(skillTypeStaticWrapper)
  self._skillSlot[idx].skillIcon.icon:addInputEvent("Mouse_On", "PaGlobal_SA_Widget_SkillList_ShowSkillTooltip(" .. quickSlotKey .. ", false, \"QuickSlot\")")
  self._skillSlot[idx].skillIcon.icon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
  local isLearned = ToClient_isLearnedSkill(skillNo)
  if true == isLearned then
    self._skillSlot[idx].skillIcon.icon:SetMonoTone(false)
  else
    self._skillSlot[idx].skillIcon.icon:SetMonoTone(true)
  end
end
function PaGlobal_SA_Widget_SkillList:changeSkillSlotTexture(flag, idx)
  if nil == PaGlobal_SA_Widget_SkillList._skillSlot then
    return
  end
  if nil == flag then
    PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillSlotBG:ChangeTextureInfoName("")
  else
    PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillSlotBG:ChangeTextureInfoName("shadowarena/contents/sa_ingame_02.dds")
    local x1, y1, x2, y2
    if 0 == flag then
      x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillSlotBG, 500, 1, 540, 41)
    elseif 1 == flag then
      x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillSlotBG, 541, 1, 581, 41)
    elseif 2 == flag then
      x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillSlotBG, 582, 1, 622, 41)
    end
    PaGlobal_SA_Widget_SkillList._skillSlot[idx].skillSlotBG:getBaseTexture():setUV(x1, y1, x2, y2)
  end
end
function PaGlobal_SA_Widget_SkillList:isFullSkill()
  for index = 1, PaGlobal_SA_Widget_SkillList._maxSkillCnt do
    if 3 > PaGlobal_SA_Widget_SkillList._skillSlot[index].skillLev then
      return false
    end
  end
  return true
end
