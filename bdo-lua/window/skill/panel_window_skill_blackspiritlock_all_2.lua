function PaGlobalFunc_BlackSpiritSkillLock_All_Open(openType)
  PaGlobal_BlackSpiritSkillLock_All:prepareOpen(openType)
end
function PaGlobalFunc_BlackSpiritSkillLock_All_Close()
  PaGlobal_BlackSpiritSkillLock_All:prepareClose()
end
function PaGlobalFunc_BlackSpiritSkillLock_All_Toggle(openType)
  if false == Panel_Window_BlackSpiritSkillLock_All:GetShow() then
    PaGlobal_BlackSpiritSkillLock_All:prepareOpen(openType)
  else
    PaGlobal_BlackSpiritSkillLock_All:prepareClose()
  end
end
function HandleEventLUp_BlackSpiritSkillLock_All_LockAll()
  PaGlobal_BlackSpiritSkillLock_All:lockSkillAll()
end
function HandleEventLUp_BlackSpiritSkillLock_All_LockTarget(skillNo, index)
  PaGlobal_BlackSpiritSkillLock_All:lockSkillTarget(skillNo, index)
end
function HandleEventOnOut_BlackSpiritSkillLock_All_Tooltip(isShow, skillNo, key32)
  if false == isShow then
    Panel_SkillTooltip_Hide()
    return
  end
  local key64 = toInt64(0, key32)
  local content = PaGlobal_BlackSpiritSkillLock_All._ui.list2_skill:GetContentByKey(key64)
  local control = UI.getChildControl(content, "Static_SkillIcon")
  Panel_SkillTooltip_SetPosition(skillNo, control, "blackSpiritLock")
  Panel_SkillTooltip_Show(skillNo, false, "blackSpiritLock")
end
function PaGlobalFunc_BlackSpiritSkillLock_All_Update()
  ToClient_updateBlackSpiritSkill()
  PaGlobal_BlackSpiritSkillLock_All:setSkill()
end
function PaGlobalFunc_BlackSpiritSkillLock_All_ListUpdate(content, key)
  PaGlobal_BlackSpiritSkillLock_All:listUpdate(content, key)
end
