PaGlobal_GuildWarInfoSmall_All = {
  _ui = {
    stc_ComboBox = nil,
    stc_TitleBg = nil,
    btn_Big = nil,
    btn_Close = nil,
    btn_Reload = nil,
    stc_BlackBg = nil,
    stc_NoWarBg = nil,
    txt_NowarTitle = nil,
    txt_NowarResult = nil,
    stc_NoOccupyBg = nil,
    stc_NoOccupyIcon = nil,
    stc_DefenceBg = nil,
    list_OffenceGuild = nil,
    list_Scroll = nil,
    btn_Ctrl = nil
  },
  _defenceGuildInfo = nil,
  _offenceGuildInfo = nil,
  _defenceGuildNo = nil,
  _selectedTerritoryKey = nil,
  _isSeigeBeing = false,
  _originPanelSizeY = 0,
  _MAXTERRIROTYCOUNT = 5,
  _reloadTimer = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/GuildWarInfo/Panel_GuildWarInfoSmall_All_1.lua")
runLua("UI_Data/Script/Window/GuildWarInfo/Panel_GuildWarInfoSmall_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildWarInfoSmall_All_Init")
function FromClient_GuildWarInfoSmall_All_Init()
  PaGlobal_GuildWarInfoSmall_All:initialize()
end
