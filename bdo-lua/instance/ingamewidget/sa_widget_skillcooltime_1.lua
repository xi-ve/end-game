function PaGlobal_SA_Widget_SkillCooltime:initialize()
  if true == self._initialize then
    return
  end
  self:registEventHandler()
  self._ui.txt_coolTimeTitle = UI.getChildControl(Panel_SA_Widget_SkillCooltime, "StaticText_CoolTimeTitle")
  self:validate()
  if 0 < ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTime, 0, CppEnums.PanelSaveType.PanelSaveType_IsSaved) then
    Panel_SA_Widget_SkillCooltime:SetShow(ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTime, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow))
  end
  Panel_SA_CoolTime_Effect:SetShow(false, false)
  Panel_SA_Widget_SkillCooltime:SetShow(true)
  PaGlobal_SA_Widget_SkillCooltime_Reload()
  self._initialize = true
end
function PaGlobal_SA_Widget_SkillCooltime:registEventHandler()
  if nil == Panel_SA_Widget_SkillCooltime then
    return
  end
  registerEvent("onScreenResize", "FromClient_SA_Widget_SkillCooltime_ReSizePanel()")
  registerEvent("FromClient_RenderModeChangeState", "FromClient_SA_Widget_SkillCooltime_ReSizePanel()")
  registerEvent("EventSkillCooltime", "PaGlobal_SA_Widget_SkillCooltime_Add")
  Panel_SA_Widget_SkillCooltime:RegisterUpdateFunc("PaGlobal_SA_Widget_SkillCooltime_UpdatePerFrame")
  Panel_SA_CoolTime_Effect:RegisterShowEventFunc(true, "PaGlobal_SA_Widget_SkillCooltime_HideAni()")
end
function PaGlobal_SA_Widget_SkillCooltime:prepareOpen()
  if nil == Panel_SA_Widget_SkillCooltime then
    return
  end
  PaGlobal_SA_Widget_SkillCooltime:open()
end
function PaGlobal_SA_Widget_SkillCooltime:open()
  if nil == Panel_SA_Widget_SkillCooltime then
    return
  end
  Panel_SA_Widget_SkillCooltime:SetShow(true)
end
function PaGlobal_SA_Widget_SkillCooltime:prepareClose()
  if nil == Panel_SA_Widget_SkillCooltime then
    return
  end
  PaGlobal_SA_Widget_SkillCooltime:close()
end
function PaGlobal_SA_Widget_SkillCooltime:close()
  if nil == Panel_SA_Widget_SkillCooltime then
    return
  end
  Panel_SA_Widget_SkillCooltime:SetShow(false)
end
function PaGlobal_SA_Widget_SkillCooltime:createCooltimeSlot()
  self.slotCount = self.slotCount + 1
  local slot = {}
  SlotSkill.new(slot, self.slotCount, Panel_SA_Widget_SkillCooltime, self.slotConfig)
  slot.icon:SetIgnore(true)
  slot.iconBg = UI.createAndCopyBasePropertyControl(Panel_SA_Widget_SkillCooltime, "Static_Icon_GuildSkillBG", slot.icon, "GuildSkillCoolTimeBG_" .. self.slotCount)
  slot.iconBg:SetPosX(slot.icon:GetPosX() - 6)
  slot.iconBg:SetPosY(slot.icon:GetPosY() - 6)
  return slot
end
function PaGlobal_SA_Widget_SkillCooltime:getSlot()
  if 0 < self.slotPool:length() then
    return self.slotPool:pop_back()
  else
    return self:createCooltimeSlot()
  end
end
function PaGlobal_SA_Widget_SkillCooltime:validate()
  if nil == Panel_SA_Widget_SkillCooltime then
    return
  end
  self._ui.txt_coolTimeTitle:isValidate()
end
