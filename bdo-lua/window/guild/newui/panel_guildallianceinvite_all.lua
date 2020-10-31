PaGlobal_GuildAllianceInvite_All = {
  _ui = {
    txt_miniDesc = nil,
    edit_searchGuild = nil,
    stc_listArea = nil,
    stc_guildTemplate = nil,
    guildInfo = {},
    btn_reset = nil,
    btn_createAlliance = nil,
    btn_cancel = nil,
    stc_descBG = nil,
    txt_desc = nil
  },
  _maxMemberCount = 100,
  _curMemberCount = 0,
  _minMemberCount = 10,
  _maxTaxRate = 100,
  _curTaxRate = 0,
  _maxAddGuildInfo = 10,
  _curAddGuildInfo = 1,
  _minGuildInfoCnt = 2,
  _memberCount = {},
  _taxRate = {},
  _taxRate_Default = {
    [0] = 0,
    [1] = 100,
    [2] = 20,
    [3] = 15,
    [4] = 15,
    [5] = 15,
    [6] = 14,
    [7] = 12,
    [8] = 11,
    [9] = 10,
    [10] = 10
  },
  _selectedGuildInfoIdx = nil,
  _defaultAllianceName = nil,
  _allianceName = "",
  _allianceMemberName = {},
  _changePanelSizeY = nil,
  _isInvite = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildAllianceInvite_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildAllianceInvite_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildAllianceInvite_All_Init")
function FromClient_GuildAllianceInvite_All_Init()
  PaGlobal_GuildAllianceInvite_All:initialize()
end
