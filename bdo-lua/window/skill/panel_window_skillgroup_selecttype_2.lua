function PaGlobalFunc_SkillGroup_SelectType_Open(playerClassType, selectTreeType, skillNo)
  PaGlobal_SkillGroup._ui._btn_modify:SetCheck(false)
  PaGlobal_SkillGroup:updateEditMode(false)
  PaGlobal_SkillGroup_SelectType:setClass(playerClassType, selectTreeType, skillNo)
  PaGlobal_SkillGroup_SelectType:show()
end
function PaGlobalFunc_SkillGroup_SelectType_Close()
  PaGlobal_SkillGroup_SelectType:close()
end
function HandleEventLUp_SkillGroup_SelectType_StartDrag(skillNo)
  if Defines.UIMode.eUIMode_NpcDialog == GetUIMode() then
    return
  end
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  PaGlobal_SkillGroup._isDraggingFromTree = true
  if nil ~= skillLevelInfo and nil ~= skillTypeStaticWrapper then
    DragManager:setDragInfo(Panel_Window_SkillGroup, nil, skillLevelInfo._skillKey:get(), "Icon/" .. skillTypeStaticWrapper:getIconPath(), SkillGroup_GroundClick, nil)
    if false == PaGlobal_SkillGroup._isEditMode then
      PaGlobal_SkillGroup:HandleEventLUp_EditMode()
    end
  end
  PaGlobalFunc_SkillGroup_SelectType_Close()
end
