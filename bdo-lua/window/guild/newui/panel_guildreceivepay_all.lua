PaGlobal_GuildReceivePay_All = {
  _ui = {
    txt_pay = nil,
    btn_inven = nil,
    btn_warehouse = nil
  },
  paytype = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildReceivePay_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildReceivePay_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildReceivePay_AllInit")
function FromClient_GuildReceivePay_AllInit()
  PaGlobal_GuildReceivePay_All:initialize()
end
