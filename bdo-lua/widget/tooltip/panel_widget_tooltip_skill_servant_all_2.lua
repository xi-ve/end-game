function PaGlobal_Tooltip_Skill_Servant_All_Open(actorKeyRaw, slot, isSlotIcon)
  if nil == Panel_Widget_Tooltip_Skill_Servant_All then
    return
  end
  PaGlobal_Tooltip_Skill_Servant_All:prepareOpen(actorKeyRaw, slot, isSlotIcon)
end
function PaGlobal_Tooltip_Skill_Servant_All_Close()
  if nil == Panel_Widget_Tooltip_Skill_Servant_All then
    return
  end
  PaGlobal_Tooltip_Skill_Servant_All:prepareClose()
end
function PaGlobal_Tooltip_Skill_Servant_All_GetShow()
  if nil == Panel_Widget_Tooltip_Skill_Servant_All then
    return
  end
  return Panel_Widget_Tooltip_Skill_Servant_All:GetShow()
end
