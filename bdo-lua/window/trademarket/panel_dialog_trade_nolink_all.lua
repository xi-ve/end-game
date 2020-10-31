PaGlobal_TradeNoLink_All = {
  _ui = {_stc_Title = nil, _btn_Node = nil},
  _initialize = false,
  _isConsole = false
}
runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_NoLink_All_1.lua")
runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_NoLink_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Trade_NoLink_All_init")
function FromClient_Trade_NoLink_All_init()
  PaGlobal_TradeNoLink_All:initialize()
end
