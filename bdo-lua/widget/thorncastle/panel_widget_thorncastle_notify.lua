PaGlobal_ThornCastle_Summon_Notify = {
  _ui = {
    _textMain = {},
    _textSub = {},
    _smallIcon = {},
    _mediumIcon = {},
    _largeIcon = {},
    _portalIcon = {},
    _smallTextMain = {},
    _smallTextSub = {},
    _mediumTextMain = {},
    _mediumTextsub = {},
    _largeTextMain = {},
    _largeTextsub = {},
    _portalTextMain = {},
    _portalTextsub = {},
    _bossIcon = nil,
    _bossTextMain = nil,
    _pointText = nil
  },
  _showTime = 2.3,
  _initialize = false
}
ThornCastleSummonType = {
  SMALL = 0,
  MEDIUM = 1,
  LARGE = 2,
  PORTAL = 3,
  BOSS = 4
}
ThornCastleSummonTeamType = {FRIENDLY = 1, ENEMY = 2}
runLua("UI_Data/Script/Widget/ThornCastle/Panel_Widget_ThornCastle_Notify_1.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ThornCastle_Summon_NotifyInit")
function FromClient_ThornCastle_Summon_NotifyInit()
  PaGlobal_ThornCastle_Summon_Notify:initialize()
end
