PaGlobal_Levelup_Info_All = {
  _ui = {
    _stc_TitleBar = nil,
    _stc_MiddleDecoLine = nil,
    _stc_StatusBG = nil,
    _stc_LearnSkillBG = nil,
    _stc_LearnableSkillBG = nil,
    _stc_Unfold = nil,
    _stc_KeyGuid = nil,
    _stcText_TitleLevel = nil,
    _btn_Close_PC = nil,
    _stcText_MaxHpTitle = nil,
    _stcText_MaxHpValue = nil,
    _stc_HpArrow = nil,
    _stcText_IncreaseHpValue = nil,
    _stcText_MaxMpTitle = nil,
    _stcText_MaxMpValue = nil,
    _stc_MpArrow = nil,
    _stcText_IncreaseMpValue = nil,
    _stcText_WeightTitle = nil,
    _stcText_WeightValue = nil,
    _stc_WeightArrow = nil,
    _stcText_IncreaseWeightValue = nil,
    _stcText_AttTitle = nil,
    _stcText_IncreaseAttValue = nil,
    _stc_AttArrow = nil,
    _stcText_PreAttValue = nil,
    _stcText_DefTitle = nil,
    _stc_DefArrow = nil,
    _stcText_PreDefValue = nil,
    _stcText_IncreaseDefValue = nil,
    _stcText_LearnSkillTitle = nil,
    _stcText_LearnSkillNoSkill = nil,
    _stc_paging = nil,
    _btn_learnLeftArrow = nil,
    _btn_learnRightArrow = nil,
    _txt_page = nil,
    _btn_quickSlotGo = nil,
    _stc_LearnSkillArea = nil,
    _txt_learnSkillName = nil,
    _stc_learnSkillIcon = nil,
    _txt_learnSkillCommand = nil,
    _stcText_LearnableSkillTitle = nil,
    _stcText_LearnableNoSkill = nil,
    _frm_LearnableSkill = nil,
    _frm_LearnableSkillContent = nil,
    _frm_LearnableSkillScroll = nil,
    _stc_LearnableSkillArea = nil,
    _btn_Unfold = nil,
    stc_KeyGuide_Console = nil,
    stcText_Close_Console = nil
  },
  _maxHp = 0,
  _maxMp = 0,
  _maxWeight = 0,
  _maxAtt = 0,
  _maxDef = 0,
  _autoHideTime = 10,
  _showTime = 0,
  _mySkillPoint = 0,
  _learnableSkillBG = {},
  _defaultStatBGSizeY = nil,
  _isLearnSkill = false,
  _isLearnableSkill = false,
  _isLevelUp = false,
  _stc_LearnSkillBG_OriginSizeY = nil,
  _stc_LearnableSkillBG_OriginSizeY = nil,
  _frm_LearnSkill_OriginSizeY = nil,
  _frm_LearnableSkill_OriginSizeY = nil,
  _currentLearnSkillIndex = 0,
  _maxLearnSkillIndex = 0,
  _maxLearnableSkillCount = 0,
  _learnalbeSkillAreaSizeY = 0,
  _isOpened = true,
  _isFoldCheck = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/LevelupInfo/Panel_Window_LevelUp_Info_All_1.lua")
runLua("UI_Data/Script/Window/LevelupInfo/Panel_Window_LevelUp_Info_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "PaGlobal_Levelup_Info_All_Init")
function PaGlobal_Levelup_Info_All_Init()
  PaGlobal_Levelup_Info_All:initialize()
end