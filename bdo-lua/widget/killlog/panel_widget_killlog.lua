PaGlobal_Widget_KillLog = {
  _eLogType = {
    normal = 0,
    guildWar = 1,
    siege = 2,
    localWar = 3
  },
  _ui = {_stc_logBg = nil, _txt_log = nil},
  _logPool = {
    _log = {},
    _startPosition = float2(0, 0),
    _offsetSizeY = float2(0, 0)
  },
  _currentPoolIndex = 0,
  _logDataList = Array.new(),
  _viewTime = 4,
  _AnimTime = 0.2,
  _isAnimating = false,
  _animatingTime = 0,
  _MAX_ROW = 10
}
runLua("UI_Data/Script/Widget/KillLog/Panel_Widget_KillLog_1.lua")
runLua("UI_Data/Script/Widget/KillLog/Panel_Widget_KillLog_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Widget_KillLogInit")
function FromClient_Widget_KillLogInit()
  PaGlobal_Widget_KillLog:initialize()
end
