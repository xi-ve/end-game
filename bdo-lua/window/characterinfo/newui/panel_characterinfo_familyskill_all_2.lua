function PaGlobalFunc_CharInfoFamilySkill_All_Update()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._familySkill) then
    return
  end
  PaGlobal_CharInfoFamilySkill_All:dataClear()
  PaGlobal_CharInfoFamilySkill_All:update()
end
function HandleEventLUp_CharInfoFamilySkill_All_applySkill(skillType, skillLevel)
  local isChecked = PaGlobal_CharInfoFamilySkill_All.btn_Table[skillLevel]._skillBtn[skillType]:IsCheck()
  PaGlobal_CharInfoFamilySkill_All.btn_Table[skillLevel]._skillBtn[skillType]:SetCheck(not isChecked)
  local familySkillWrapper = ToClient_GetFamilySkillWrapperByKindAndLevel(skillType, skillLevel)
  if nil == familySkillWrapper or false == familySkillWrapper:isSet() then
    return
  end
  local familySkillKey = familySkillWrapper:getFamilySkillKey()
  local rv = ToClient_RequestLearnFamilySkill(familySkillKey)
  if true == rv then
    PaGlobal_CharInfoFamilySkill_All._learnFamilySkillKey = familySkillKey
  end
end
function HandleEventLUp_CharInfoFamilySkill_All_resetSkill(skillType, skillLevel)
  local familySkillWrapper = ToClient_GetFamilySkillWrapperByKindAndLevel(skillType, skillLevel)
  if nil == familySkillWrapper or false == familySkillWrapper:isSet() then
    return
  end
  local familySkillKey = familySkillWrapper:getFamilySkillKey()
  local rv = ToClient_RequestClearFamilySkill(familySkillKey)
end
function HandleEventLUp_CharInfoFamilySkill_All_resetAllSkill()
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_EDANAMESSAGE_RESET_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_EDANAMESSAGE_RESET_DESC"),
    functionYes = ToClient_RequestAllClearFamilySkill,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_CharInfoFamilySkill_All_IgnoreCheckClick(btnLine, skillType)
  local isChecked = PaGlobal_CharInfoFamilySkill_All.btn_Table[btnLine]._skillBtn[skillType]:IsCheck()
  PaGlobal_CharInfoFamilySkill_All.btn_Table[btnLine]._skillBtn[skillType]:SetCheck(not isChecked)
end
function HandleEventOnOut_CharInfoFamilySkill_All_ShowQuestion(isShow)
  if false == isShow or nil == isShow then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(PaGlobal_CharInfoFamilySkill_All._ui.stc_Question, "", PaGlobal_CharInfoFamilySkill_All._familySkillDesc)
end
function HandleEventOnOut_CharInfoFamilySkill_All_ShowSkillTooltip(isShow, btnLine, skillType)
  if false == isShow or nil == btnLine or nil == skillType then
    TooltipSimple_Hide()
    return
  end
  local familySkillWrapper = ToClient_GetFamilySkillWrapperByKindAndLevel(skillType, btnLine)
  if nil == familySkillWrapper then
    return
  end
  local control = PaGlobal_CharInfoFamilySkill_All.btn_Table[btnLine]._skillBtn[skillType]
  local tooltipName = familySkillWrapper:getFamilySkillName()
  local tooltipDesc = familySkillWrapper:getFamilySkillDescription()
  local needPoint = familySkillWrapper:getNeedPoint()
  local skillkey = familySkillWrapper:getFamilySkillKey()
  if false == ToClient_IsLearnFamilySkill(skillkey) then
    tooltipDesc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FAMILYSKILL_TOOLTIP_NEEDPOINT", "point", needPoint) .. "\n" .. tooltipDesc
  end
  TooltipSimple_Show(control, tooltipName, tooltipDesc)
end
function FromClient_CharInfoFamilySkill_UpdateSkillExpAndPoint(isChangeExp, isChangePointOrGrade)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._familySkill) then
    return
  end
  local self = PaGlobal_Window_FamilySkill_Main
  PaGlobal_CharInfoFamilySkill_All:updatePointAndGrade()
  if true == isChangePointOrGrade then
    PaGlobal_CharInfoFamilySkill_All:update()
  end
end
function FromClient_CharInfoFamilySkill_UpdateFamilySkill()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._familySkill) then
    return
  end
  PaGlobal_CharInfoFamilySkill_All:update()
end
