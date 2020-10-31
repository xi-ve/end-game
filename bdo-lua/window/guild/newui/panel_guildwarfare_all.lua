PaGlobal_GuildWarfare_All = {
  _ui = {
    stc_TopBG = nil,
    txt_CharName = nil,
    stc_CommadCenter = nil,
    stc_Tower = nil,
    stc_Summons = nil,
    stc_CastleGate = nil,
    stc_Installation = nil,
    stc_Member = nil,
    stc_Death = nil,
    stc_KillBySiege = nil,
    txt_Sort = nil,
    stc_MainBG = nil,
    stc_LeftArea = nil,
    list2_Warfare = nil
  },
  _icons = {},
  _guildWarfareDataList = {},
  _isListDescSort = {},
  _selectedSortType = -1,
  _scrollData = {_pos = nil, _idx = nil},
  _initialize = false,
  _isConsole = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildWarfare_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildWarfare_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildWarfare_All_Init")
function FromClient_GuildWarfare_All_Init()
  PaGlobal_GuildWarfare_All:initialize()
end
