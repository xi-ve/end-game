PaGlobal_RandomBoxSelect_All = {
  _ui = {
    stc_title = nil,
    btn_Close = nil,
    stc_SubFrame = nil,
    stc_SelectRandomBoxBg = nil,
    rdo_Normal = nil,
    rdo_Speed = nil,
    rdo_Auto = nil,
    stc_DescBG = nil,
    txt_Desc = nil,
    btn_Start = nil,
    btn_Cancel = nil,
    stc_KeyGuide = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil,
    _gachaPanel = {
      coverThis = nil,
      pushSpace = nil,
      notify = nil,
      effectControl = nil
    }
  },
  rollMode = 0,
  maxSlotCount = 200,
  useSlotCount = 0,
  slotBGPool = {},
  slotPool = {},
  slot_PosYGap = 65,
  rouletteState = 0,
  rollSpeedInit = 20,
  rollSpeedCur = 0,
  rollSpeedMin = 1,
  rollSpeedAccel = 0,
  rollPos = 0.5,
  pickItemKey = nil,
  pickSlotIndex = 0,
  elapsTime = 0,
  resultShowTime = 0,
  soundPlayTime = 0,
  autoSelectTimeCheck = 0,
  autoEndTime = 30,
  autoSelectTime = 2,
  slotConfing = {
    createIcon = true,
    createBorder = true,
    createCash = true,
    createEnchant = true
  },
  _rouletteState = {
    eClose = 0,
    eRoll = 1,
    ePickAndSlow = 2,
    eResult = 3,
    eWaitContinue = 4
  },
  _ePanelType = {_modeSelect = 0, _roulette = 1},
  _initialize = false,
  _isConsole = false
}
runLua("UI_Data/Script/Widget/Gacha_Roulette/Panel_Gacha_Roulette_All_1.lua")
runLua("UI_Data/Script/Widget/Gacha_Roulette/Panel_Gacha_Roulette_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_RandomBoxSelectAllInit")
function FromClient_PaGlobal_RandomBoxSelectAllInit()
  PaGlobal_RandomBoxSelect_All:initialize()
end
