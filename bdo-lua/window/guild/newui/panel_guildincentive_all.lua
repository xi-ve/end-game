PaGlobal_GuildIncentive_All = {
  _ui = {
    stc_backBg = nil,
    stc_titleBg = nil,
    txt_title = nil,
    txt_moneyAll = nil,
    txt_moneyFree = nil,
    stc_mainBg = nil,
    edit_money = nil,
    stc_descBg = nil,
    txt_desc = nil
  },
  _ui_pc = {btn_confirm = nil, btn_cancle = nil},
  _ui_console = {
    stc_keyGuideX = nil,
    stc_keyGuideBottomBg = nil,
    stc_keyGuideA = nil,
    stc_keyGuideB = nil
  },
  _configSize = {
    _panelY = 0,
    _mainBgY = 0,
    _backBgY = 0,
    _bottomY = 0
  },
  _moneyValue = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildIncentive_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildIncentive_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildIncentive_All_Init")
function FromClient_GuildIncentive_All_Init()
  PaGlobal_GuildIncentive_All:initialize()
end
