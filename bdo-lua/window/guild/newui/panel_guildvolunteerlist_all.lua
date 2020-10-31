PaGlobal_GuildVolunteerList_All = {
  _ui = {
    stc_listTitleBg = nil,
    _title = {
      txt_grade = nil,
      txt_level = nil,
      txt_class = nil,
      txt_name = nil,
      txt_activity = nil,
      txt_contribute = nil,
      txt_voice = nil,
      txt_warGrade = nil,
      txt_contract = nil
    },
    _titleList = {},
    stc_framelistBg = nil,
    frame_list = nil,
    frame_content = nil,
    frame_vScroll = nil,
    frame_vScrollCtrl = nil,
    stc_listContent = nil,
    _volunteerList = {},
    stc_bottomBg = nil,
    txt_desc = nil,
    btn_hire = nil
  },
  _ui_pc = {
    stc_funcBg = nil,
    btn_activityCost = nil,
    stc_setVolumBg = nil,
    slider_listenVol = nil,
    slider_listenVolBtn = nil,
    chk_listenIcon = nil,
    txt_volumVal = nil,
    btn_setVolumClose = nil
  },
  _ui_console = {},
  _SortType = {
    GRADE = 0,
    LEVEL = 1,
    CLASS = 2,
    NAME = 3,
    APOINT = 4,
    CONTACT = 5,
    WPOINT = 6,
    WGRADE = 7,
    VOICE = 8,
    COUNT = 9
  },
  _contentOpen = {
    voice = ToClient_IsContentsGroupOpen("75") and false == _ContentsGroup_isPS4UI,
    warGrade = ToClient_IsContentsGroupOpen("388"),
    newSiegeRule = _ContentsGroup_NewSiegeRule
  },
  _isGuildMaster = false,
  _isGuildSubMaster = false,
  _listMaxCount = 150,
  _curClickVolunteerIdx = -1,
  _volunteerListData = {},
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildVolunteerList_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildVolunteerList_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildVolunteerList_All_Init")
function FromClient_GuildVolunteerList_All_Init()
  PaGlobal_GuildVolunteerList_All:initialize()
end
