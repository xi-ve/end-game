PaGlobal_Arsha_TeamChange_All = {
  _ui = {
    stc_titleArea = nil,
    txt_title = nil,
    stc_mainBg = nil,
    txt_desc = nil,
    rdo_teamA = nil,
    rdo_teamB = nil,
    rdo_teamW = nil
  },
  _ui_pc = {
    btn_close = nil,
    btn_apply = nil,
    btn_cancle = nil
  },
  _ui_console = {
    stc_keyGuideBg = nil,
    txt_keyGuideY = nil,
    txt_keyGuideA = nil,
    txt_keyGuideB = nil
  },
  _savedIdx = -1,
  _savedObserver = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_TeamChange_All_1.lua")
runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_TeamChange_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Arsha_TeamChange_All_Init")
function FromClient_Arsha_TeamChange_All_Init()
  PaGlobal_Arsha_TeamChange_All:initialize()
end
