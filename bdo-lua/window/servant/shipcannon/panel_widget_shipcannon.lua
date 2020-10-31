PaGlobal_ShipCannon = {
  _eCannon = {
    all = 0,
    left = 1,
    right = 2,
    loopCount = 2
  },
  _eCooltime = {
    one = 1,
    two = 2,
    three = 3,
    ready = 4,
    loopCount = 4
  },
  _ui = {
    _progress_powerGauge = nil,
    _stc_cooltimes = nil,
    _stc_cannonReady = nil,
    _txt_bulletCount = nil
  },
  currentPower = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/Servant/ShipCannon/Panel_Widget_ShipCannon_1.lua")
runLua("UI_Data/Script/Window/Servant/ShipCannon/Panel_Widget_ShipCannon_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ShipCannonInit")
function FromClient_ShipCannonInit()
  PaGlobal_ShipCannon:initialize()
end
