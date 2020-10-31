PaGlobal_LocalWarInfo_All = {
  _ui = {
    _stc_titleBG = nil,
    _stc_leftBG = nil,
    _list2_serverList = nil,
    _icon_Level = nil,
    _icon_AP = nil,
    _icon_DP = nil,
    _icon_AD = nil,
    _frame_desc = nil,
    _txt_MyLevel = nil,
    _txt_MyAp = nil,
    _txt_MyDp = nil,
    _txt_MyAdSum = nil,
    _txt_MyUnLimit = nil,
    _txt_MyChannel = nil,
    _txt_MyJoinMemberCount = nil,
    _txt_MyRemainTime = nil,
    _btn_MyJoin = nil,
    _rule = {
      _txt_title = nil,
      _stc_background = nil,
      _txt_content = {}
    },
    _reward = {
      _txt_title = nil,
      _stc_background = nil,
      _txt_content = {}
    },
    _explanation = {
      _txt_title = nil,
      _stc_background = nil,
      _txt_content = {}
    }
  },
  _ui_pc = {_btn_close = nil, _btn_help = nil},
  _ui_console = {
    _stc_keyguideBG = nil,
    _stc_keyguideA = nil,
    _stc_keyguideB = nil,
    _stc_keyguideY = nil
  },
  _posConfig = {
    _listStartPosY = 5,
    _iconStartPosY = 88,
    _listPosYGap = 45
  },
  _openDesc = -1,
  _maxRuleSize = 40,
  _ruleCount = 12,
  _maxRewardSize = 20,
  _rewardCount = 3,
  _maxExplanationSize = 30,
  _explanationCount = 5,
  _localWarServerCountLimit = 0,
  _rule_ani_SpeedTime = 5,
  _isGrouthLocalWar = ToClient_IsContentsGroupOpen("338"),
  _isConsole = _ContentsGroup_UsePadSnapping,
  _initialize = false
}
runLua("UI_Data/Script/Window/LocalWar/Panel_LocalWarInfo_All_1.lua")
runLua("UI_Data/Script/Window/LocalWar/Panel_LocalWarInfo_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_LocalWarInfo_All_Init")
function FromClient_luaLoadComplete_LocalWarInfo_All_Init()
  PaGlobal_LocalWarInfo_All:initialize()
end
