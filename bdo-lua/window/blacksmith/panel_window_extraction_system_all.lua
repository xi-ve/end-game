PaGlobal_Extraction_System_All = {
  _ui = {
    stc_extractableItemSlot = nil,
    stc_materialItemSlot = nil,
    stc_resultItmeSlot = nil,
    stc_resultMaterialItemSlot = nil,
    txt_leftBottomDesc = nil,
    btn_skipAni = nil,
    list2_extractableItem = nil
  },
  _ui_pc = {btn_close = nil, btn_extraction = nil},
  _ui_console = {
    stc_iconY_extraction = nil,
    stc_bottomGuideBg = nil,
    stc_iconX = nil,
    stc_iconA = nil,
    stc_iconB = nil
  },
  _initialize = false,
  _isConsole = false,
  _listControl = {},
  _systemCnt = 0,
  _equipCnt = 0,
  _equipNo = {},
  _itemInfo = {
    name = {},
    iconPath = {},
    slotNo = {},
    itemEnchantLevle = {},
    isExtractionEquip = {false}
  },
  _slotConfig = {
    createIcon = false,
    createBorder = false,
    createCount = true,
    createEnchant = true,
    createCash = false
  },
  _curSelectKey = nil,
  _preSelectKey = nil,
  _isAniStart = false,
  _isSkipAni = false,
  _delta_ani_time = 0,
  _const_ani_time = 3,
  _sound_ani_time = 1.8,
  _isSoundFX = false,
  _fromSlotOn = false,
  _extractableSlotNo = -1,
  _materialSlotNo = -1,
  _resultItemKey = nil,
  _resultMaterialKey = nil,
  _resultShowTime = 0,
  _selectedItemSlotNo = nil,
  _isEndExtraction = false
}
runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Extraction_System_All_1.lua")
runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Extraction_System_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Extraction_System_AllInit")
function FromClient_Extraction_System_AllInit()
  PaGlobal_Extraction_System_All:initialize()
end
