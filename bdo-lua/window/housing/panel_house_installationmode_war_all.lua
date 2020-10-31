PaGlobal_InstallationModeWar_All = {
  _ui = {_btn_close = nil},
  _initialize = false
}
runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_War_All_1.lua")
runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_War_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_InstallationModeWar_All_Init")
function FromClient_InstallationModeWar_All_Init()
  PaGlobal_InstallationModeWar_All:initialize()
end
