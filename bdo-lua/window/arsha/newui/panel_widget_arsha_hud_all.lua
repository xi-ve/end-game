PaGlobal_Arsha_Hud_All = {
  _ui = {
    stc_teamHud = nil,
    txt_teamTime = nil,
    txt_personalRound = nil,
    txt_leftPoint = nil,
    txt_rightPoint = nil,
    txt_leftTeam = nil,
    txt_rightTeam = nil,
    stc_blueDotScore = nil,
    stc_redDotScore = nil,
    stc_aloneHud = nil,
    txt_aloneTime = nil,
    txt_lifeMember = nil,
    _scoreDot = {
      blue = {},
      red = {}
    }
  },
  _fightState = CppEnums.CompetitionFightState.eCompetitionFightState_Done,
  _matchType = CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round,
  _scoreDotMaxCnt = 10,
  _delayTime = 1,
  _competitionGameDeltaTime = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Widget_Arsha_Hud_All_1.lua")
runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Widget_Arsha_Hud_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Arsha_Hud_All_Init")
function FromClient_Arsha_Hud_All_Init()
  PaGlobal_Arsha_Hud_All:initialize()
end
