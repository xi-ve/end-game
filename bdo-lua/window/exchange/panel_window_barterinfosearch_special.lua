PaGlobal_BarterInfoSearch_Special = {
  _ui = {
    _titleBg = UI.getChildControl(Panel_Window_Barter_Search_Special, "Static_TitleBg"),
    _mainBg = UI.getChildControl(Panel_Window_Barter_Search_Special, "Static_MainBG"),
    _btn_cancel = UI.getChildControl(Panel_Window_Barter_Search_Special, "Button_Cancel"),
    _btn_giveUp = UI.getChildControl(Panel_Window_Barter_Search_Special, "Button_Skip")
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = true
  }
}
function FromClient_BarterInfoSearchSpecialInit()
  local self = PaGlobal_BarterInfoSearch_Special
  self:init()
end
runLua("UI_Data/Script/Window/Exchange/Panel_Window_BarterInfoSearch_Special_1.lua")
runLua("UI_Data/Script/Window/Exchange/Panel_Window_BarterInfoSearch_Special_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_BarterInfoSearchSpecialInit")
