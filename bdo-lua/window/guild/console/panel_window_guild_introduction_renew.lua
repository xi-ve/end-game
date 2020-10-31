PaGlobal_GuildIntroduction = {
  _ui = {stc_CenterBG = nil, stc_BottomBG = nil},
  _maxActivityTypeCount = 7,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/Console/Panel_Window_Guild_Introduction_Renew_1.lua")
runLua("UI_Data/Script/Window/Guild/Console/Panel_Window_Guild_Introduction_Renew_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildIntroduction_Init")
function FromClient_GuildIntroduction_Init()
  PaGlobal_GuildIntroduction:initialize()
end
