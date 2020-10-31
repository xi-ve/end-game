PaGlobal_ServantLookChange_All = {
  _ui = {
    _stc_Title = nil,
    _stc_Bg = nil,
    _comboBox_TierSelect_PC = nil,
    _comboBox_TierList_PC = nil,
    _comboBox_TierSelectScroll_PC = nil,
    _comboBox_TierSelectScroll_Up_PC = nil,
    _comboBox_TierSelectScroll_Down_PC = nil,
    _comboBox_TierSelectScroll_Ctrl_PC = nil,
    _comboBox_TierListBackBg_PC = nil,
    _comboBox_TierSelect_Console = nil,
    _comboBox_TierSelect_Button_Console = nil,
    _list2_Look = nil,
    _list2_Content = nil,
    _list2_Btn_Left = nil,
    _list2_Btn_Left_Img = nil,
    _list2_Btn_Right_Img = nil,
    _list2_Btn_Right = nil,
    _list2_VertiScroll = nil,
    _list2_VertiScroll_Up = nil,
    _list2_VertiScroll_Down = nil,
    _list2_VertiScroll_Ctrl = nil,
    _list2_HoriScroll = nil,
    _list2_HoriScroll_Up = nil,
    _list2_HoriScroll_Down = nil,
    _list2_HoriScroll_Ctrl = nil,
    _btn_ChangeLook = nil,
    _btn_ChangeSpecialLook = nil
  },
  _currentLookIndex = nil,
  _beforeSceneIndex = -1,
  _totalFormCount = nil,
  _currentServantNo = nil,
  _isConsole = false,
  _initailize = false
}
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantLookChange_All_1.lua")
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantLookChange_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ServantLookChange_All_Init")
function FromClient_ServantLookChange_All_Init()
  PaGlobal_ServantLookChange_All:initialize()
end
