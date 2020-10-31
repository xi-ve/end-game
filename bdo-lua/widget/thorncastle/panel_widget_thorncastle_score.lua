PaGlobal_ThornCastle_Score = {
  _ui = {
    _allyTeamSign = {},
    _teamSocre = {},
    _teamNameText = {},
    _timer
  },
  _initialize = false
}
runLua("UI_Data/Script/Widget/ThornCastle/Panel_Widget_ThornCastle_Score_1.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ThornCastle_ScoreInit")
function FromClient_ThornCastle_ScoreInit()
  PaGlobal_ThornCastle_Score:initialize()
end
