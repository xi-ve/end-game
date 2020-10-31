PaGlobal_ServantTransferList_All = {
  _ui = {
    _txt_Title = nil,
    _btn_Close_PC = nil,
    _stc_Bg = nil,
    _txt_Desc = nil,
    _txt_Count = nil,
    _list2_Servant = nil,
    _list2_Content = nil,
    _list2_Btn_List = nil,
    _list2_Verti_Scroll = nil,
    _list2_Verti_Scroll_Up = nil,
    _list2_Verti_Scroll_Down = nil,
    _list2_Verti_Scroll_Ctrl = nil,
    _list2_Hori_Scroll = nil,
    _list2_Hori_Scroll_Up = nil,
    _list2_Hori_Scroll_Down = nil,
    _list2_Hori_Scroll_Ctrl = nil,
    _stc_Bottom_KeyGuide = nil,
    _stc_Keyguide_A = nil,
    _stc_Keyguide_B = nil
  },
  _currentTitle = nil,
  _isConsole = false,
  _initailize = false
}
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantTransferList_All_1.lua")
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantTransferList_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ServantTransferList_All_Init")
function FromClient_ServantTransferList_All_Init()
  PaGlobal_ServantTransferList_All:initialize()
end
