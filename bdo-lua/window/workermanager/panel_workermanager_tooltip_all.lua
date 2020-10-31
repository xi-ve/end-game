PaGlobal_WorkerManagerTooltip_All = {
  _ui = {
    txt_workerName = nil,
    stc_mainBg = nil,
    stc_skillBg = nil,
    stc_workerImgBg = nil,
    stc_workerImg = nil,
    stc_progressBg = nil,
    proegress_exp = nil,
    txt_level = nil,
    txt_exp = nil,
    txt_workSpeed = nil,
    txt_workSpeedVal = nil,
    txt_moveSpeed = nil,
    txt_moveSpeedVal = nil,
    txt_lucky = nil,
    txt_luckyVal = nil,
    txt_action = nil,
    txt_actionVal = nil,
    txt_town = nil,
    txt_advence = nil,
    stc_skillBoxBg = nil,
    stc_skillBoxDefault = nil,
    stc_skillSlotBg = nil,
    stc_skillSlot = nil,
    txt_skillName = nil,
    txt_skillDesc = nil
  },
  _ui_pc = {},
  _ui_console = {},
  _maxSkillCount = 7,
  _basePanelSizeY = 0,
  _baseMainBgSizeY = 0,
  _baseSkillBgSizeY = 0,
  _skill = {},
  _defaultSlot = {},
  _slotStartPosY = 0,
  _workerNoRaw = -1,
  _parentPanel = nil,
  _isRight = true,
  _isPlant = false,
  _worekrInfoTooltip = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/WorkerManager/Panel_WorkerManager_Tooltip_All_1.lua")
runLua("UI_Data/Script/Window/WorkerManager/Panel_WorkerManager_Tooltip_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_WorkerManagerTooltip_All_Init")
function FromClient_WorkerManagerTooltip_All_Init()
  PaGlobal_WorkerManagerTooltip_All:initialize()
end
