PaGlobal_SuccessionSkill = {
  classSuccessionSkill = {
    [__eClassType_Warrior] = ToClient_IsContentsGroupOpen("1367"),
    [__eClassType_ElfRanger] = ToClient_IsContentsGroupOpen("1368"),
    [__eClassType_Sorcerer] = ToClient_IsContentsGroupOpen("1369"),
    [__eClassType_Giant] = ToClient_IsContentsGroupOpen("1370"),
    [__eClassType_Tamer] = ToClient_IsContentsGroupOpen("1371"),
    [__eClassType_BladeMaster] = ToClient_IsContentsGroupOpen("1372"),
    [__eClassType_BladeMasterWoman] = ToClient_IsContentsGroupOpen("1373"),
    [__eClassType_Valkyrie] = ToClient_IsContentsGroupOpen("1374"),
    [__eClassType_WizardMan] = ToClient_IsContentsGroupOpen("1375"),
    [__eClassType_WizardWoman] = ToClient_IsContentsGroupOpen("1376"),
    [__eClassType_NinjaMan] = ToClient_IsContentsGroupOpen("1377"),
    [__eClassType_Kunoichi] = ToClient_IsContentsGroupOpen("1378"),
    [__eClassType_DarkElf] = ToClient_IsContentsGroupOpen("1379"),
    [__eClassType_Combattant] = ToClient_IsContentsGroupOpen("1380"),
    [__eClassType_Mystic] = ToClient_IsContentsGroupOpen("1382"),
    [__eClassType_Lhan] = ToClient_IsContentsGroupOpen("1381"),
    [__eClassType_RangerMan] = false,
    [__eClassType_ShyWaman] = false,
    [__eClassType_Guardian] = ToClient_IsContentsGroupOpen("1424"),
    [__eClassType_Hashashin] = ToClient_IsContentsGroupOpen("1451")
  },
  isSuccessionContentsOpen = false
}
function PaGlobal_SuccessionSkill:initalize()
  if false == _ContentsGroup_UISkillGroupTreeLayOut then
    if PaGlobal_SuccessionSkill_IsCheckOpenContents() then
      PaGlobal_Skill.radioButtons[PaGlobal_Skill.eTabIndex.succession]:SetShow(true)
    else
      PaGlobal_Skill.radioButtons[PaGlobal_Skill.eTabIndex.succession]:SetShow(false)
    end
  else
  end
end
function PaGlobal_SuccessionSkill_IsCheckOpenContents()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return false
  end
  if false == _ContentsGroup_Succession then
    return false
  end
  return PaGlobal_SuccessionSkill.classSuccessionSkill[selfPlayer:getClassType()]
end
