PaGlobal_ServantOnlyList_All = {
  _ui = {
    _txt_Title = nil,
    _txt_ServantListTitle = nil,
    _txt_ServantListValue = nil,
    _list2_Servant = nil,
    _btn_Regist = nil,
    _stc_BlockBG = nil,
    _btn_Close = nil,
    _stc_Bottom_ConsoleKeyGuide = nil,
    _stc_KeyGuide_A = nil,
    _stc_KeyGuide_Y = nil,
    _stc_KeyGuide_B = nil
  },
  ENUM_MYLIST = 2,
  ENUM_MARKETLIST = 0,
  _servantTable = {},
  _matingSlotIdx = nil,
  _currentSelectIdx = nil,
  _isConsole = false,
  _initailize = false
}
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantOnlyList_All_1.lua")
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantOnlyList_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ServantOnlyList_All_Init")
function FromClient_ServantOnlyList_All_Init()
  PaGlobal_ServantOnlyList_All:initialize()
end
