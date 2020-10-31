function HandleEventMouseOn_PetInfo_ActionToolTip_Show_All(action_idx, uiIdx)
  if PaGlobal_PetInfo_All._isConsole and Panel_Tooltip_SimpleText:GetShow() then
    TooltipSimple_Hide()
    return
  end
  local actionStaticStatus = ToClient_getPetActionStaticStatus(action_idx)
  if nil == actionStaticStatus then
    return
  end
  local actionIconPath = actionStaticStatus:getIconPath()
  local actionName = actionStaticStatus:getName()
  local actionDesc = actionStaticStatus:getDescription()
  local uiBase = PaGlobal_PetInfo_All._actionSlot[uiIdx]
  if "" == actionDesc then
    actionDesc = nil
  end
  TooltipSimple_Show(uiBase, actionName, actionDesc)
end
function HandleEventMouseOn_PetInfo_BaseSkillTooltip_Show_All(baseskillindex, uiIdx)
  if PaGlobal_PetInfo_All._isConsole and Panel_SkillTooltip_GetShow() then
    Panel_SkillTooltip_Hide()
    return
  end
  local skillStaticStatus = ToClient_getPetBaseSkillStaticStatus(baseskillindex)
  local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
  local petSkillNo = skillStaticStatus:getSkillNo()
  local uiBase = PaGlobal_PetInfo_All._skillSlot[uiIdx]
  Panel_SkillTooltip_Show(petSkillNo, false, "PetSkill")
end
function HandleEventMouseOn_PetInfo_SkillTooltip_Show_All(skill_idx, uiIdx)
  if PaGlobal_PetInfo_All._isConsole and Panel_SkillTooltip_GetShow() then
    Panel_SkillTooltip_Hide()
    return
  end
  local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(skill_idx)
  local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
  local petSkillNo = skillStaticStatus:getSkillNo()
  local uiBase = PaGlobal_PetInfo_All._skillSlot[uiIdx]
  Panel_SkillTooltip_Show(petSkillNo, false, "PetSkill")
end
function FromClient_PetInfo_Update_All()
  if Panel_Window_PetInfo_All:GetShow() then
    PaGlobal_PetInfo_All:update()
  end
end
function PaGlobal_PetInfo_Open_All(petNo_s64)
  if nil == Panel_Window_PetInfo_All then
    return
  end
  PaGlobal_PetInfo_All:prepareOpen(petNo_s64)
end
function PaGlobal_PetInfo_Close_All()
  if nil == Panel_Window_PetInfo_All then
    return
  end
  PaGlobal_PetInfo_All:prepareClose()
end
