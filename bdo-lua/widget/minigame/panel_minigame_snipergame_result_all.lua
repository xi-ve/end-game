PaGlobal_MiniGame_SniperGame_Result_All = {
  _ui = {
    stc_resultBg = nil,
    stc_deviationMark = nil,
    stc_impactPoint = nil,
    stc_resultCritical = nil,
    stc_resultMiss = nil,
    stc_resultHit = nil
  },
  _impactPosX = nil,
  _impactPosY = nil,
  _initialize = false
}
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SniperGame_Result_All_1.lua")
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SniperGame_Result_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MiniGame_SniperGame_Result_All_Init")
function FromClient_MiniGame_SniperGame_Result_All_Init()
  PaGlobal_MiniGame_SniperGame_Result_All:initialize()
end
