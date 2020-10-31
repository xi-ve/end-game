PaGlobal_SA_Widget_Quest = {
  _ui = {
    stc_questBG = nil,
    stc_questIcon = nil,
    txt_questTitle = nil,
    txt_questCondition = nil
  },
  _initialize = false,
  _successTextureUV = {
    _missionBG = {
      x1 = 1,
      y1 = 81,
      x2 = 331,
      y2 = 160
    },
    _icon = {
      x1 = 467,
      y1 = 161,
      x2 = 511,
      y2 = 205
    }
  },
  _progressMissionInfo = {},
  _templetePosOffsetY = 0,
  _templetePosGapY = 90,
  _missionCount = 0,
  _timer = 0,
  _lastUpdateTime = 0,
  _strMissionSuccess1 = PAGetString(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_MISSION_COMPLETE1"),
  _strMissionSuccess2 = PAGetString(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_MISSION_COMPLETE2"),
  _strMissionAccept = PAGetString(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_MISSION_MESSAGE_TITLE"),
  _isBlackSpirit = true
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Quest_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Quest_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_QuestInit")
function FromClient_SA_Widget_QuestInit()
  PaGlobal_SA_Widget_Quest:initialize()
end
