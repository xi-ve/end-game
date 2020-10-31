PaGlobal_UseItem_All = {
  _ui = {
    _frame = nil,
    _frameContent = nil,
    _frameScroll = nil,
    _desc = nil,
    _copyItemSlotBG = nil,
    _copyItemSlot = nil
  },
  _ui_pc = {
    _btn_Yes = nil,
    _btn_No = nil,
    _btn_Close = nil
  },
  _ui_console = {
    _stc_ConsoleKeyBG = nil,
    _btn_Select = nil,
    _btn_Move = nil,
    _btn_Cancel = nil
  },
  _popupItem = {
    slotInfo = {},
    slotInfoBG = {},
    slotInfoForBuff = {},
    slotInfoForBuffBG = {},
    slotIndex = 0,
    selectWhereType = nil,
    selectSlotNo = nil,
    selectEquipNo = 0,
    totalRowCount = 0
  },
  _slotConfig = {
    createIcon = true,
    createBorder = false,
    createCount = true,
    createExpiration = false,
    createCash = true
  },
  _maxPopupSlotCount = 10,
  _baseSlotLineCount = 5,
  _descBG_sizeY = 0,
  _popupItemWrapper = nil,
  _isConsole = _ContentsGroup_UsePadSnapping,
  _initialize = false
}
runLua("UI_Data/Script/Window/MessageBox/Panel_UseItem_All_1.lua")
runLua("UI_Data/Script/Window/MessageBox/Panel_UseItem_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_UseItem_All_Init")
function FromClient_UseItem_All_Init()
  PaGlobal_UseItem_All:initialize()
end
