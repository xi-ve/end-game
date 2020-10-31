function PaGlobal_Tooltip_Skill_Servant_All:initialize()
  if true == self._initialize then
    return
  end
  self._ui.txt_SkillName = UI.getChildControl(Panel_Widget_Tooltip_Skill_Servant_All, "Tooltip_Skill_Name")
  self._ui.stc_SkillIcon = UI.getChildControl(Panel_Widget_Tooltip_Skill_Servant_All, "Tooltip_Skill_Icon")
  self._ui.txt_SkillCommandDesc = UI.getChildControl(Panel_Widget_Tooltip_Skill_Servant_All, "StaticText_Description_Value")
  self._ui.txt_SkillDesc = UI.getChildControl(Panel_Widget_Tooltip_Skill_Servant_All, "StaticText_SkillDesc")
  self._ui.txt_SkillCondition_Title = UI.getChildControl(Panel_Widget_Tooltip_Skill_Servant_All, "StaticText_Condition_Title")
  self._ui.txt_SkillCondition_Value = UI.getChildControl(Panel_Widget_Tooltip_Skill_Servant_All, "StaticText_Condition_Value")
  self._ui.stc_DescBG = UI.getChildControl(Panel_Widget_Tooltip_Skill_Servant_All, "Static_DescBG")
  self._ui.txt_SkillName:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_SkillCommandDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_SkillDesc:SetTextMode(__eTextMode_AutoWrap)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Tooltip_Skill_Servant_All:registEventHandler()
  if nil == Panel_Widget_Tooltip_Skill_Servant_All then
    return
  end
end
function PaGlobal_Tooltip_Skill_Servant_All:prepareOpen(actorKeyRaw, slot, isSlotIcon)
  if nil == Panel_Widget_Tooltip_Skill_Servant_All then
    return
  end
  self:setTooltipData(actorKeyRaw, slot, isSlotIcon)
  self:open()
end
function PaGlobal_Tooltip_Skill_Servant_All:open()
  if nil == Panel_Widget_Tooltip_Skill_Servant_All then
    return
  end
  Panel_Widget_Tooltip_Skill_Servant_All:SetShow(true)
end
function PaGlobal_Tooltip_Skill_Servant_All:prepareClose()
  if nil == Panel_Widget_Tooltip_Skill_Servant_All then
    return
  end
  self:close()
end
function PaGlobal_Tooltip_Skill_Servant_All:close()
  if nil == Panel_Widget_Tooltip_Skill_Servant_All then
    return
  end
  Panel_Widget_Tooltip_Skill_Servant_All:SetShow(false)
end
function PaGlobal_Tooltip_Skill_Servant_All:validate()
  if nil == Panel_Widget_Tooltip_Skill_Servant_All then
    return
  end
  self._ui.txt_SkillName:isValidate()
  self._ui.stc_SkillIcon:isValidate()
  self._ui.txt_SkillCommandDesc:isValidate()
  self._ui.txt_SkillDesc:isValidate()
  self._ui.txt_SkillCondition_Title:isValidate()
  self._ui.txt_SkillCondition_Value:isValidate()
  self._ui.stc_DescBG:isValidate()
end
function PaGlobal_Tooltip_Skill_Servant_All:setTooltipData(skillWrapper, slot, isSlotIcon)
  if nil == skillWrapper then
    return
  end
  local skillIcon = skillWrapper:getIconPath()
  local skillName = skillWrapper:getName()
  local skillCommandDesc = skillWrapper:getDescription()
  local skillDesc = skillWrapper:getDescription2()
  local skillCondition = skillWrapper:getConditionDescription()
  self._ui.stc_SkillIcon:ChangeTextureInfoName("Icon/" .. skillIcon)
  self._ui.txt_SkillName:SetText(skillName)
  self._ui.txt_SkillCommandDesc:SetText(skillCommandDesc)
  self._ui.txt_SkillDesc:SetSize(self._ui.txt_SkillCommandDesc:GetSizeX(), self._ui.txt_SkillDesc:GetSizeY())
  self._ui.txt_SkillDesc:SetText(skillDesc)
  self._ui.txt_SkillDesc:SetPosXY(self._ui.txt_SkillCommandDesc:GetPosX(), self._ui.txt_SkillCommandDesc:GetPosY() + self._ui.txt_SkillCommandDesc:GetTextSizeY())
  self._ui.txt_SkillDesc:SetTextHorizonLeft()
  self._ui.txt_SkillDesc:SetTextVerticalTop()
  self._ui.txt_SkillDesc:SetShow(true)
  if "" ~= skillCondition then
    self._ui.txt_SkillCondition_Title:SetShow(true)
    self._ui.txt_SkillCondition_Title:SetText("<PAColor0xFFEEEEEE>" .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_TOOLTIP_NEED_BEFORE_RUN_SKILL") .. "<PAOldColor>")
    self._ui.txt_SkillCondition_Title:SetPosY(self._ui.txt_SkillDesc:GetPosY() + self._ui.txt_SkillDesc:GetTextSizeY() + 10)
    self._ui.txt_SkillCondition_Value:SetShow(true)
    self._ui.txt_SkillCondition_Value:SetText(skillCondition)
    self._ui.txt_SkillCondition_Value:SetPosY(self._ui.txt_SkillCondition_Title:GetPosY() + self._ui.txt_SkillCondition_Title:GetTextSizeY() + 10)
    self._ui.stc_DescBG:SetSize(self._ui.stc_DescBG:GetSizeX(), self._ui.txt_SkillDesc:GetTextSizeY() + self._ui.txt_SkillCondition_Title:GetTextSizeY() + self._ui.txt_SkillCondition_Value:GetTextSizeY() + 60)
  else
    self._ui.txt_SkillCondition_Title:SetShow(false)
    self._ui.txt_SkillCondition_Value:SetShow(false)
    self._ui.stc_DescBG:SetSize(self._ui.stc_DescBG:GetSizeX(), self._ui.txt_SkillCommandDesc:GetTextSizeY() + self._ui.txt_SkillDesc:GetTextSizeY() + 20)
  end
  Panel_Widget_Tooltip_Skill_Servant_All:SetSize(Panel_Widget_Tooltip_Skill_Servant_All:GetSizeX(), self._ui.stc_DescBG:GetPosY() + self._ui.stc_DescBG:GetSizeY() + 5)
  if self:isServantInfoGetShow() then
    if true == isSlotIcon then
      Panel_Widget_Tooltip_Skill_Servant_All:SetPosX(slot.icon:GetParentPosX() + slot.icon:GetSizeX() + 10)
      Panel_Widget_Tooltip_Skill_Servant_All:SetPosY(slot.icon:GetParentPosY())
    else
      Panel_Widget_Tooltip_Skill_Servant_All:SetPosX(slot:GetParentPosX() + slot:GetSizeX() + 10)
      Panel_Widget_Tooltip_Skill_Servant_All:SetPosY(slot:GetParentPosY())
    end
  elseif true == isSlotIcon then
    Panel_Widget_Tooltip_Skill_Servant_All:SetPosX(slot.icon:GetParentPosX() - Panel_Widget_Tooltip_Skill_Servant_All:GetSizeX() - 10)
    Panel_Widget_Tooltip_Skill_Servant_All:SetPosY(slot.icon:GetParentPosY())
  else
    Panel_Widget_Tooltip_Skill_Servant_All:SetPosX(slot:GetParentPosX() + slot:GetSizeX() + 10)
    Panel_Widget_Tooltip_Skill_Servant_All:SetPosY(slot:GetParentPosY())
  end
end
function PaGlobal_Tooltip_Skill_Servant_All:isServantInfoGetShow()
  if true == _ContentsGroup_NewUI_ServantInfo_All then
    return PaGlobal_VehicleInfo_All_GetPanelShow()
  else
    return Panel_Window_ServantInfo:GetShow()
  end
end
