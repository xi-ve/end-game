PaGlobal_SA_Widget_ScoreBoard = {
  _ui = {
    stc_resultIcon = nil,
    stc_totalResultIcon = nil,
    stc_myRankBG = nil,
    stc_myCharIcon = nil,
    txt_myUserID = nil,
    txt_myRankValue = nil,
    txt_myKillValue = nil,
    stc_otherRankIcon = nil,
    list2_scoreList = nil,
    stc_winner = {}
  },
  _initialize = false,
  _maxWinnerPlayer = 3,
  _maxPlayerCount = 50,
  _isGameEnd = false,
  _wasObserverMode = false,
  _characterIconUV = {
    path = "shadowarena/basic/sa_character_00.dds",
    [52] = {
      x1 = 1,
      x2 = 171,
      y1 = 325,
      y2 = 405
    },
    [53] = {
      x1 = 1,
      x2 = 171,
      y1 = 244,
      y2 = 324
    },
    [55] = {
      x1 = 1,
      x2 = 171,
      y1 = 82,
      y2 = 162
    },
    [58] = {
      x1 = 1,
      x2 = 171,
      y1 = 1,
      y2 = 81
    },
    [60] = {
      x1 = 1,
      x2 = 171,
      y1 = 163,
      y2 = 243
    },
    [63] = {
      x1 = 1,
      x2 = 171,
      y1 = 406,
      y2 = 486
    }
  },
  _attackerName = nil
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Scoreboard_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Scoreboard_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_ScoreBoardInit")
function FromClient_SA_Widget_ScoreBoardInit()
  PaGlobal_SA_Widget_ScoreBoard:initialize()
end
