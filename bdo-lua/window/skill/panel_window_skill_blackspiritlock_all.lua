PaGlobal_BlackSpiritSkillLock_All = {
  _ui = {
    chk_lockAll = nil,
    stc_mainBg = nil,
    list2_skill = nil,
    stc_descBG = nil,
    txt_desc = nil,
    stc_titleBar = nil
  },
  _ui_pc = {btn_close = nil},
  _ui_console = {
    stc_bottomGuideBg = nil,
    stc_guideA = nil,
    stc_guideB = nil,
    stc_guideY = nil
  },
  _OPEN_TYPE = {
    BLACKSPIRIT = 0,
    REMASTER_BLACKSPIRIT = 1,
    SKILLWINDOW = 2,
    CONSOLE = 3
  },
  _uiSize = {descBgY = 0, panelY = 0},
  _sortByRage = {},
  _classType = nil,
  _skillCount = 0,
  _numsLocked = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_BlackSpiritLock_All_1.lua")
runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_BlackSpiritLock_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_BlackSpiritSkillLock_All_Init")
function FromClient_BlackSpiritSkillLock_All_Init()
  PaGlobal_BlackSpiritSkillLock_All:initialize()
end
