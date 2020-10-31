PaGlobal_Invitation_All = {
  _eType = {invitation = 0},
  _ui = {
    btn_Close = nil,
    txt_Contents = nil,
    stc_keyGuideConsoleBg = nil,
    stc_keyGuideB = nil
  },
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Common/Panel_Window_Invitation_All_1.lua")
runLua("UI_Data/Script/Window/Common/Panel_Window_Invitation_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Invitation_All_Init")
function FromClient_Invitation_All_Init()
  PaGlobal_Invitation_All:initialize()
end
