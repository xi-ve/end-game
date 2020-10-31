PaGlobal_BarterInfoRefresh = {
  _ui = {
    _btn_close = UI.getChildControl(Panel_Window_Barter_Refresh, "Button_Close"),
    _btn_apply = UI.getChildControl(Panel_Window_Barter_Refresh, "Button_Apply_PCUI"),
    _btn_cancel = UI.getChildControl(Panel_Window_Barter_Refresh, "Button_Cancel_PCUI")
  }
}
runLua("UI_Data/Script/Window/Exchange/Panel_Window_BarterInfoRefresh_1.lua")
runLua("UI_Data/Script/Window/Exchange/Panel_Window_BarterInfoRefresh_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_BarterInfoRefreshInit")
function FromClient_BarterInfoRefreshInit()
  local self = PaGlobal_BarterInfoRefresh
  self:init()
end
