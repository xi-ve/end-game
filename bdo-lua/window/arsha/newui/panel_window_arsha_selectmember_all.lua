PaGlobal_Arsha_SelectMember_All = {
  _ui = {
    stc_titleArea = nil,
    txt_title = nil,
    stc_mainBg = nil,
    txt_titleLineBg = nil,
    txt_titleCheck = nil,
    txt_titleClass = nil,
    txt_titleLevel = nil,
    txt_titleName = nil,
    txt_titleState = nil,
    list2_member = nil,
    stc_bottomBg = nil,
    txt_ourTeamState = nil
  },
  _ui_pc = {btn_close = nil, btn_confirm = nil},
  _ui_console = {
    stc_keyGuideBG = nil,
    txt_keyGuideY = nil,
    txt_keyGuideA = nil
  },
  _attendUserNoTemp = toInt64(-1, -1),
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_SelectMember_All_1.lua")
runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_SelectMember_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Arsha_SelectMember_All_Init")
function FromClient_Arsha_SelectMember_All_Init()
  PaGlobal_Arsha_SelectMember_All:initialize()
end
