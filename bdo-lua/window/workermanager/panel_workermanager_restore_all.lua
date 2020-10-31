PaGlobal_WorkerManagerRestore_All = {
  _ui = {
    stc_titleBg = nil,
    txt_titleName = nil,
    stc_itemlistBg = nil,
    txt_itemlistGuide = nil,
    stc_itemIconBg = nil,
    stc_itemIcon = nil,
    stc_itemCnt = nil,
    stc_itemRetoreVal = nil,
    txt_workerCnt = nil,
    txt_restorePoint = nil,
    txt_possiblePoint = nil,
    stc_slider = nil,
    btn_slider = nil
  },
  _ui_pc = {
    btn_close = nil,
    btn_confirm = nil,
    btn_cancle = nil
  },
  _ui_console = {
    stc_keyguideBg = nil,
    stc_feedAll = nil,
    stc_confirm = nil,
    stc_close = nil
  },
  _workerListCount = 0,
  _workerArray = {},
  _workerNoRaw = -1,
  _restoreItemMaxCount = 6,
  _restoreItemHasCount = 0,
  _restoreItemSlot = {},
  _sliderStartIdx = 0,
  _selectedItemIdx = -1,
  _itemSelectList = {},
  _isContinue = false,
  _originPanelSizeY = 0,
  _titleText = {
    All = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORKERRESTOREALL_TITLE"),
    ONE = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORKERMANAGER_RESTORE_TITLE")
  },
  _guideText = {
    All = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORKERRESTOREALL_DESC_USEITEM"),
    PC = PAGetString(Defines.StringSheet_RESOURCE, "UI_WORLDMAP_TOWN_MANAGEWORKER_GUIDE_RESTOREALL"),
    CONSOLE = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORKERMANAGER_RESTORE_DESC")
  },
  _isConsole = false,
  _isPadSnap = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/WorkerManager/Panel_WorkerManager_Restore_All_1.lua")
runLua("UI_Data/Script/Window/WorkerManager/Panel_WorkerManager_Restore_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_WorkerManagerRestore_All_Init")
function FromClient_WorkerManagerRestore_All_Init()
  PaGlobal_WorkerManagerRestore_All:initialize()
end
