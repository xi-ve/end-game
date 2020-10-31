PaGlobal_ServantUpgrade = {
  _ui = {
    _mainBg = UI.getChildControl(Panel_Window_ServantUpgrade, "Static_MainBg"),
    _titleBar = UI.getChildControl(Panel_Window_ServantUpgrade, "Static_TitleBG"),
    _btn_doUpgrade = UI.getChildControl(Panel_Window_ServantUpgrade, "Button_Try"),
    _btn_cancel = UI.getChildControl(Panel_Window_ServantUpgrade, "Button_Cancel"),
    _stateBg = UI.getChildControl(Panel_Window_ServantUpgrade, "Static_ReadyBG"),
    _progressGroup = UI.getChildControl(Panel_Window_ServantUpgrade, "Static_ProgressGroup"),
    _progressBg = UI.getChildControl(Panel_Window_ServantUpgrade, "Static_NewShipSlotBG_Progress")
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true
  },
  _isProgressing = false,
  _updateCompleteTime = 10
}
function FromClient_ServantUpgradeInit()
  local self = PaGlobal_ServantUpgrade
  self:init()
end
runLua("UI_Data/Script/Window/Servant/Panel_Window_ServantUpgrade_1.lua")
runLua("UI_Data/Script/Window/Servant/Panel_Window_ServantUpgrade_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ServantUpgradeInit")
