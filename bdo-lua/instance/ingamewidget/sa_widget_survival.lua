PaGlobal_SA_Widget_Survival = {
  _ui = {
    txt_survival_value1 = nil,
    txt_survival_value2 = nil,
    txt_survival_value = nil,
    txt_killValue = nil
  },
  _initialize = false,
  _maxPlayerCnt = 0,
  _curPlayerCnt = 0,
  _killCount = 0
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Survival_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Survival_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_SurvivalInit")
function FromClient_SA_Widget_SurvivalInit()
  PaGlobal_SA_Widget_Survival:initialize()
end
