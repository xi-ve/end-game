PaGlobal_WorkerManagerChangeSkill_All = {
  _ui = {
    stc_titleBg = nil,
    stc_mainBg = nil,
    txt_notice = nil,
    stc_skillBg = nil,
    txt_exp = nil,
    radio_skillSlotBg = nil,
    stc_skillIconBg = nil,
    stc_skillIcon = nil,
    txt_skillName = nil,
    txt_skillDesc = nil
  },
  _ui_pc = {
    btn_close = nil,
    btn_confirm = nil,
    btn_cancle = nil
  },
  _ui_console = {
    stc_keyguideBg = nil,
    stc_confirm = nil,
    stc_close = nil
  },
  _baseNoticeSizeY = 0,
  _originPanelSizeY = 0,
  _maxSkillCount = 7,
  _skillList = {},
  _selectedSkillKeyRaw = nil,
  _selectedWorkerNoRaw = nil,
  _isConsole = false,
  _isPadSnap = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/WorkerManager/Panel_WorkerManager_ChangeSkill_All_1.lua")
runLua("UI_Data/Script/Window/WorkerManager/Panel_WorkerManager_ChangeSkill_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_WorkerManagerChangeSkill_All_Init")
function FromClient_WorkerManagerChangeSkill_All_Init()
  PaGlobal_WorkerManagerChangeSkill_All:initialize()
end
