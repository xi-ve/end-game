PaGlobal_Memo_All = {
  _ui = {
    _stc_TitleBg = nil,
    _btn_Close = nil,
    _btn_AddMemo = nil,
    _btn_AllRemove = nil,
    _List2 = nil,
    _stcText_NoMemoAlert = nil
  },
  _id = {},
  _stickyMemoList = {},
  _currentFocusId = nil,
  _currentFocusContent = nil,
  _SaveMode = {
    TEXT = 0,
    SETTING = 1,
    ALL = 2
  },
  _memoTitleBG_OrgSizeX = 0,
  _removeMemoBtn_OrgPosX = 0,
  _BASE_LINE = 9,
  _MAX_LINE = 100,
  _MAX_TEXT = 2000,
  _orgMouseX = nil,
  _orgMouseY = nil,
  _orgPanelPosX = nil,
  _orgPanelSizeX = nil,
  _orgPanelSizeY = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/Memo/Panel_Window_Memo_Main_All_1.lua")
runLua("UI_Data/Script/Window/Memo/Panel_Window_Memo_Main_All_2.lua")
runLua("UI_Data/Script/Window/Memo/Panel_Window_Memo_Main_All_3.lua")
registerEvent("FromClient_luaLoadComplete", "PaGlobal_Memo_Main_Init")
function PaGlobal_Memo_Main_Init()
  PaGlobal_Memo_All:initialize()
end
