PaGlobal_GuildMemberList_All = {
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
    stc_listAreaBg = nil,
    frame_list = nil,
    frame_content = nil,
    stc_listMember = nil,
    btn_contract = nil,
    stc_voiceListen = nil,
    stc_voiceTalk = nil,
    txt_contribute = nil,
    txt_activity = nil,
    txt_name = nil,
    txt_class = nil,
    txt_level = nil,
    stc_grade = nil,
    stc_guard = nil,
    btn_warGrade = nil,
    btn_warState = nil,
    scroll_vs = nil,
    scroll_vsCtrl = nil,
    stc_bottomAreaBg = nil,
    stc_guildFundBg = nil,
    txt_guildFund = nil,
    btn_getFund = nil,
    btn_deposit = nil,
    btn_warReward = nil,
    btn_guildFundManage = nil,
    btn_guildLifeFund = nil,
    _titlelist = {},
    _memberlist = {},
    _buttonlist = {}
  },
  _ui_pc = {
    stc_funcBg = nil,
    btn_func = nil,
    stc_setVolumBg = nil,
    slider_listenVol = nil,
    slider_listenVolBtn = nil,
    chk_icon = nil,
    txt_volumVal = nil,
    btn_setVolumClose = nil
  },
  _ui_console = {},
  _config = {
    listMaxCount = 150,
    collectionY = 90,
    collectionX = 45,
    voiceBgY = 110,
    gradeSpanX = 0
  },
  _contentOpen = {
    voice = ToClient_IsContentsGroupOpen("75") and false == _ContentsGroup_isPS4UI,
    warGrade = ToClient_IsContentsGroupOpen("388"),
    newSiegeRule = _ContentsGroup_NewSiegeRule
  },
  _MenuButtonType = {
    WHISPER = 0,
    APPOINT_COMMANDER = 1,
    CANCLE_APPOINT = 2,
    CHANGE_MASTER = 3,
    PROTECT_MEMBER = 4,
    CANCLE_PROTECT_MEMBER = 5,
    PARTY_INVITE = 6,
    SUPPLY = 7,
    DEPORTATION = 8,
    PRICELIMIT = 9,
    LARGEPARTY_INVITE = 10,
    COUNT = 11
  },
  _MenuButtonStr = {
    [0] = PAGetString(Defines.StringSheet_GAME, "CHATTING_TAB_WHISPER"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_2"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_3"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_0"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_4"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_5"),
    [6] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_6"),
    [7] = PAGetString(Defines.StringSheet_GAME, "GULD_BUTTON7"),
    [8] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_1"),
    [9] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_USEGUILDFUNDS_TITLE"),
    [10] = PAGetString(Defines.StringSheet_GAME, "LUA_LARGEPARTY_INVITE_MESSAGEBOX_TITLE")
  },
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
  _listSort = {
    [0] = false,
    [1] = false,
    [2] = false,
    [3] = false,
    [4] = false,
    [5] = false,
    [6] = false,
    [7] = false,
    [8] = nil
  },
  _GuildGrade = {
    CLAN = CppEnums.GuildGrade.GuildGrade_Clan,
    GUILD = CppEnums.GuildGrade.GuildGrade_Guild
  },
  _ContractType = {
    recontactable = 0,
    contacting = 1,
    expiration = 2
  },
  _siegeGradeCount = {
    grade1 = 0,
    grade2 = 0,
    grade3 = 0,
    grade4 = 0,
    grade5 = 0
  },
  _memberlistData = {},
  _memberUserNolist = {},
  _sortingFunc = {},
  _menuButtonSize = {},
  _selectIndex = 0,
  _selectSortType = -1,
  _selectUserNo = -1,
  _myGuildIndex = nil,
  _inputGuildDepositNum_s64 = toInt64(0, 0),
  _inputGuildDepositMaxNum_s64 = toInt64(0, 0),
  _setVol_selectedMemberIdx = 0,
  _setVol_selectedMemberVol = 0,
  _prevVoiceChatListen = false,
  _dailyPayWhereType = nil,
  _characterName = "",
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildMemberList_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildMemberList_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildMemberList_All_Init")
function FromClient_GuildMemberList_All_Init()
  PaGlobal_GuildMemberList_All:initialize()
end
