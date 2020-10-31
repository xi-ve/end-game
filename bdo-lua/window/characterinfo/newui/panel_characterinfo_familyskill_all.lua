PaGlobal_CharInfoFamilySkill_All = {
  _ui = {
    prog2_Circle_point = nil,
    txt_FamSkillPoint = nil,
    txt_FamPercent = nil,
    txt_FamPoint = nil,
    txt_FamGrade = nil,
    txt_AP = nil,
    txt_DP = nil,
    txt_SpiritRecovery = nil,
    txt_ReduceTax = nil,
    btn_AllReset = nil,
    stc_Question = nil,
    txt_APUPTitle = nil,
    txt_DPUpTitle = nil,
    txt_SpiritTitle = nil,
    txt_TaxTitle = nil,
    stc_FrameBg = nil,
    stc_FrameContent = nil,
    btn_First_AP = nil,
    btn_First_DP = nil,
    btn_First_Spirit = nil,
    btn_First_Tax = nil,
    btn_Line_AP = nil,
    btn_Line_DP = nil,
    btn_Line_Spirit = nil,
    btn_Line_Tax = nil,
    stc_Console_Cursor = nil,
    stc_Frame_VertiScroll = nil,
    stc_KeyGuide_Console = nil,
    stc_KeyGuide_Y = nil,
    stc_KeyGuide_B = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_X = nil
  },
  btn_Table = {},
  _ePoint = {
    EXP = 1,
    POINT = 2,
    GRADE = 3,
    TOTALCOUNT = 3
  },
  _eTYPE = {
    AP = 0,
    DP = 1,
    SP = 2,
    TAX = 3,
    TOTALCOUNT = 4
  },
  _learnFamilySkillKey = nil,
  _familySkillDesc = "",
  _tooltipColIdx = nil,
  _tooltipRowIdx = nil,
  _maxSkillCount = 0,
  _btnGap = 93,
  _selfPlayer = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_FamilySkill_All_1.lua")
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_FamilySkill_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CharInfoFamilySkill_AllInit")
function FromClient_CharInfoFamilySkill_AllInit()
  PaGlobal_CharInfoFamilySkill_All:initialize()
end
