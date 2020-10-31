PaGlobal_GuildWarScore_All = {
  _ui = {
    txt_Title = nil,
    btn_Close = nil,
    list_GuildWarfare = nil,
    list_Content = nil,
    txt_IconHelper = nil,
    stc_KeyGuide = nil
  },
  _guildScoreInfo = {},
  _selectedGuildNo = 0,
  _MAXTITLECOUNT = 8,
  _isConsole = _ContentsGroup_UsePadSnapping,
  _initialize = false
}
runLua("UI_Data/Script/Window/GuildWarInfo/Panel_GuildWarScore_All_1.lua")
runLua("UI_Data/Script/Window/GuildWarInfo/Panel_GuildWarScore_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildWarScore_All_Init")
function FromClient_GuildWarScore_All_Init()
  PaGlobal_GuildWarScore_All:initialize()
end
