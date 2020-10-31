PaGlobal_LevelupInfo = {
  _ui = {
    _stc_titleBar = UI.getChildControl(Panel_Levelup_Info, "Static_TitleBg"),
    _stc_statusBG = UI.getChildControl(Panel_Levelup_Info, "Static_StatBg"),
    _stc_LearnSkillBG = UI.getChildControl(Panel_Levelup_Info, "Static_LearnSkillBg"),
    _stc_LearnableSkillBG = UI.getChildControl(Panel_Levelup_Info, "Static_LearnableSkillBg"),
    _stc_unfold = UI.getChildControl(Panel_Levelup_Info, "Static_Unfold")
  },
  _slotCount = 0,
  _maxHp = 0,
  _maxMp = 0,
  _maxWeight = 0,
  _maxAtt = 0,
  _maxDef = 0,
  _uiData = {},
  _skillBG = {},
  _skillIcon = {},
  _skillName = {},
  _learnableSkillBG = {},
  _learnableSkillIcon = {},
  _learnableSkillName = {},
  slotConfig = {createCount = false},
  _isFoldCheck = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/LevelupInfo/Panel_Levelup_Info_1.lua")
runLua("UI_Data/Script/Window/LevelupInfo/Panel_Levelup_Info_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_LevelupInfoInit")
function FromClient_LevelupInfoInit()
  PaGlobal_LevelupInfo:initialize()
  PaGlobal_LevelupInfo:CurrentState()
end
