PaGlobal_GuildAllianceList_All = {
  _ui = {
    stc_LeftBg = nil,
    stc_Left = nil,
    stc_MarkBg = nil,
    stc_Mark = nil,
    txt_Name = nil,
    txt_Territory = nil,
    txt_MemberCount = nil,
    list2_GuildList = nil,
    stc_Bottom = nil,
    txt_TodayCommentTitle = nil,
    stc_RightBg = nil,
    txt_allianceInfoTitle = nil,
    stc_TitleBar = nil,
    txt_GradeBar = nil,
    txt_LevelBar = nil,
    txt_ClassBar = nil,
    txt_NameBar = nil,
    txt_GuildBar = nil,
    list2_member = nil,
    _list2UI = {},
    _chkBox = {}
  },
  _currentClickGuild = -1,
  _gradeString = {
    [0] = "LUA_GUILD_TEXT_GUILDMASTER",
    "LUA_GUILD_TEXT_GUILDSUBMASTER",
    "LUA_GUILD_TEXT_GUILDMEMBER",
    "LUA_GUILD_TEXT_SUPPLYOFFICER",
    "LUA_GUILD_TEXT_NEWBIE",
    "LUA_PANEL_GUILD_LIST_GRADE_ICON_VACATION_TOOLTIP"
  },
  _scrollData = {_pos = nil, _idx = nil},
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildAllianceList_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildAllianceList_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildAllianceList_All_Init")
function FromClient_GuildAllianceList_All_Init()
  PaGlobal_GuildAllianceList_All:initialize()
end
