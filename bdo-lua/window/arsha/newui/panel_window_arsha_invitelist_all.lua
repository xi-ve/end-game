PaGlobal_Arsha_InviteList_All = {
  _ui = {
    stc_titleArea = nil,
    txt_title = nil,
    btn_close = nil,
    stc_mainBg = nil,
    stc_listTitleBg = nil,
    txt_titleLevel = nil,
    txt_titleClass = nil,
    txt_titleName = nil,
    txt_titleKind = nil,
    list2_invite = nil
  },
  _ui_console = {
    stc_keyGuideBg = nil,
    txt_keyGuideY = nil,
    txt_keyGuideX = nil,
    txt_keyGuideB = nil
  },
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_InviteList_All_1.lua")
runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_InviteList_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Arsha_InviteList_All_Init")
function FromClient_Arsha_InviteList_All_Init()
  PaGlobal_Arsha_InviteList_All:initialize()
end
