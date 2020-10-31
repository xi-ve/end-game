PaGlobal_SkillGroup_Controller = {
  _ui = {
    _btn_playSkill = nil,
    _btn_cameraReset = nil,
    _stc_descBg = nil,
    _stc_skillIcon = nil,
    _txt_skillName = nil,
    _txt_skillDesc = nil,
    _txt_skillCommandDesc = nil,
    _txt_skillEffectDesc = nil,
    _txt_skillNeedResource = nil,
    _txt_requiredLevel = nil,
    _txt_requiredSkillPoint = nil,
    _txt_reuseCycle = nil
  },
  _fixedDescString = {
    _level = PAGetString(Defines.StringSheet_GAME, "LUA_CONSOLE_SKILL_REQUIRED_LEVEL_TITLE"),
    _skillPoint = PAGetString(Defines.StringSheet_GAME, "LUA_CONSOLE_SKILL_REQUIRED_SKILL_POINTS_TITLE"),
    _reuseCycle = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_COOLTIME_TITLE"),
    _needMantalString = "",
    _mantalString = ""
  },
  isLdown = false,
  isRdown = false,
  xMovePos = 0,
  yMovePos = 0,
  _selectSkillNo = 0,
  _isEditMode = false,
  isShowUI = true,
  _isConsole = false,
  _initialize = false,
  _isShowBlackSpiritSkill = false,
  _renderMode = nil
}
runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_Controller_1.lua")
runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_Controller_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SkillGroup_ControllerInit")
function FromClient_SkillGroup_ControllerInit()
  PaGlobal_SkillGroup_Controller:initialize()
end
