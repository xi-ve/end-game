PaGlobal_Extraction_Costume_All = {
  _ui = {
    stc_leftTopDesc = nil,
    stc_extractableItemSlot = nil,
    stc_resultItmeSlot = nil,
    stc_leftBottomDesc = nil,
    btn_skipAni = nil,
    list2_extractableItem = nil,
    btn_valks = nil,
    btn_cron = nil,
    txt_extractionCnt = nil,
    stc_extractionImg = nil
  },
  _ui_pc = {
    btn_question = nil,
    btn_close = nil,
    btn_extraction = nil
  },
  _ui_console = {
    stc_bottomGuideBg = nil,
    stc_iconX = nil,
    stc_iconA = nil,
    stc_iconB = nil,
    btn_extraction = nil
  },
  _initialize = false,
  _isConsole = false,
  _isValks = nil,
  _costumeCnt = 0,
  _equipCnt = 0,
  _equipNo = {},
  _itemInfo = {
    name = {},
    iconPath = {},
    whereType = {},
    slotNo = {},
    isExtractionEquip = {false}
  },
  _slotConfig = {
    createIcon = false,
    createBorder = false,
    createCount = true,
    createEnchant = true,
    createCash = false
  },
  _extractionCnt = 0,
  _extractionItem = {
    slotNo = {},
    whereType = {}
  },
  _fromSlotOn = false,
  _isAniStart = false,
  _isSkipAni = false,
  _isSoundFx = false,
  _delta_ani_time = 0,
  _const_ani_time = 3,
  _sound_ani_time = 2,
  _resultShowTime = 0,
  _isClose = false,
  _isExtraction = false,
  _selectedItemSlotNo = nil
}
runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Extraction_Costume_All_1.lua")
runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Extraction_Costume_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Extraction_Costume_AllInit")
function FromClient_Extraction_Costume_AllInit()
  PaGlobal_Extraction_Costume_All:initialize()
end
