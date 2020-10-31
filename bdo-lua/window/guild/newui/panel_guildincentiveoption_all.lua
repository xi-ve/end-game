PaGlobal_GuildIncentiveOption_All = {
  _ui = {
    stc_titleBg = nil,
    txt_title = nil,
    stc_backBg = nil,
    stc_listTitleBg = nil,
    _title = {
      txt_grade = nil,
      txt_name = nil,
      txt_activity = nil,
      txt_incentive = nil,
      txt_rade = nil
    },
    stc_listBg = nil,
    frame_list = nil,
    frame_content = nil,
    frame_vScroll = nil,
    frame_vScrollCtrl = nil,
    stc_listTemp = nil,
    stc_bottomBg = nil,
    stc_guildFundBg = nil,
    txt_guildFund = nil,
    _memberlist = {}
  },
  _ui_pc = {btn_close = nil, btn_getFunds = nil},
  _ui_console = {
    stc_keyGuideBg = nil,
    stc_keyGuideY = nil,
    stc_keyGuideA = nil,
    stc_keyGuideX = nil,
    stc_keyGuideB = nil
  },
  _configSize = {
    panelY = 0,
    bottomY = 0,
    descY = 0
  },
  _memberlistData = {},
  _isAllButton = {},
  _listSort = {name = false, ap = false},
  _selectSortType = -1,
  _listMaxCount = 150,
  _incentiveIdx = 0,
  _moneyValue = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildIncentiveOption_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildIncentiveOption_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildIncentiveOption_All_Init")
function FromClient_GuildIncentiveOption_All_Init()
  PaGlobal_GuildIncentiveOption_All:initialize()
end
