PaGlobal_GuildDeposit_All = {
  _ui = {
    stc_titleArea = nil,
    btn_close = nil,
    stc_mainArea = nil,
    edit_deposit = nil,
    stc_descArea = nil,
    txt_desc = nil,
    stc_KeyguideBg = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil
  },
  _maxInputValue_s64 = nil,
  _inputValue_s64 = nil,
  _isConsole = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildDeposit_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildDeposit_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildDeposit_All_Init")
function FromClient_GuildDeposit_All_Init()
  PaGlobal_GuildDeposit_All:initialize()
end
