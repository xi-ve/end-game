PaGlobal_Window_FamilySkill_Main = {
  _ui = {
    _skillPointTitleArray = {},
    _skillPointValueArray = {},
    _skillExpProgressBar = nil,
    _resetSkillButton = nil,
    _skillDescription = nil,
    _skillIconArray = {},
    _skillIconBgArray = {},
    _skillIconTextArray = {},
    _skillList = nil
  },
  _ePoint = {
    exp = 1,
    point = 2,
    grade = 3,
    count = 3
  },
  _initialize = false,
  _learnSkillKind = nil,
  _learnSkillLevel = nil
}
runLua("UI_Data/Script/Widget/EdanaContract/Panel_Window_Edana_Main_1.lua")
runLua("UI_Data/Script/Widget/EdanaContract/Panel_Window_Edana_Main_2.lua")
registerEvent("FromClient_UpdateFamilySkillExpAndPoint", "FromClient_UpdateFamilySkillExpAndPoint")
registerEvent("FromClient_UpdateFamilySkill", "FromClient_UpdateFamilySkill")
registerEvent("FromClient_UpdateFamilySkill", "FromClient_UI_CharacterInfo_Basic_AttackChanged")
registerEvent("FromClient_UpdateFamilySkill", "Equipment_updateSlotData")
