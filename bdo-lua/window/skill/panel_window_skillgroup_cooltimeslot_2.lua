function PaGlobalFunc_SkillGroup_CoolTimeSlot_Close()
  if nil == Panel_SkillGroup_CoolTimeSlot or false == Panel_SkillGroup_CoolTimeSlot:GetShow() then
    return
  end
  PaGlobal_SkillGroup_CoolTimeSlot:close()
end
function PaGlobal_SkillGroup_CoolTimeSlot_Toggle()
  if false == Panel_SkillGroup_CoolTimeSlot:GetShow() then
    PaGlobal_SkillGroup_CoolTimeSlot:open()
  else
    PaGlobal_SkillGroup_CoolTimeSlot:close()
  end
end
function FromClient_SkillGroupCoolTimeSlotUpdate()
  PaGlobal_SkillGroup_CoolTimeSlot:skillUpdate()
end
