PaGlobal_Arsha_TeamNameChange_All = {
  _ui = {
    stc_titleArea = nil,
    txt_title = nil,
    btn_close = nil,
    stc_subFrameBg = nil,
    txt_explain = nil,
    txt_teamA = nil,
    edit_teamA = nil,
    txt_teamB = nil,
    edit_teamB = nil,
    btn_confirm = nil
  },
  _ui_console = {
    stc_keyGuideBg = nil,
    txt_keyGuideY = nil,
    txt_keyGuideA = nil,
    txt_keyGuideB = nil
  },
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_TeamNameChange_All_1.lua")
runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_TeamNameChange_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Arsha_TeamNameChange_All_Init")
function FromClient_Arsha_TeamNameChange_All_Init()
  PaGlobal_Arsha_TeamNameChange_All:initialize()
end
