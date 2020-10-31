PaGlobal_Looting_All = {
  _ui = {
    _stc_bg = nil,
    _btn_lootAll = nil,
    _btn_cancel = nil,
    _btn_lootAllServant = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true
  },
  _config = {
    _slotCount = 24,
    _slotCols = 6,
    _minslotRow = 2,
    _slotBGStartX = 10,
    _slotBGStartY = 57,
    _slotStartX = 12,
    _slotStartY = 59,
    _slotGapX = 54,
    _slotGapY = 54,
    _slotBGGap = 12
  },
  _slotBgBases = nil,
  _slots = nil,
  _SELECT_SLOTNO_INIT = -1,
  _selectSlotNo = nil,
  _defaultBgSize = {x = 0, y = 0},
  _defaultPanelSize = {x = 0, y = 0},
  _isSizeSetting = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Looting/Panel_Window_Looting_All_1.lua")
runLua("UI_Data/Script/Window/Looting/Panel_Window_Looting_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Looting_All_Init")
function FromClient_Looting_All_Init()
  PaGlobal_Looting_All:initialize()
end
