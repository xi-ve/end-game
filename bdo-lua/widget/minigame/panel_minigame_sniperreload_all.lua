PaGlobal_MiniGame_SniperReload_All = {
  _ui = {
    stc_BG = nil,
    stc_reloadMark = nil,
    stc_spaceBar = nil,
    txt_leftTime = nil,
    txt_desc = nil
  },
  _theta = 0,
  _markPosX = 50,
  _leftEndX = 80,
  _rightEndX = 410,
  _span = 165,
  _speed = 5,
  _leftSuccessX = 220,
  _rightSuccessX = 276,
  _piDouble = math.pi * 2,
  _inputLocked = false,
  _remainTime = 5,
  _initialize = false
}
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SniperReload_All_1.lua")
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SniperReload_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MiniGame_SniperReload_All_Init")
function FromClient_MiniGame_SniperReload_All_Init()
  PaGlobal_MiniGame_SniperReload_All:initialize()
end
