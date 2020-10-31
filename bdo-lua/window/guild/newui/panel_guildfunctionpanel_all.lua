PaGlobal_GuildFunctionPanel_All = {
  _ui = {
    stc_TitleBg = nil,
    stc_MainBg = nil,
    btn_FucntionTemp = nil,
    stc_ConsoleKeyGuide = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil
  },
  _eFuncType = {
    showInfo = 0,
    recvPay = 1,
    renewAgreement = 2,
    modifySound = 3,
    inviteParty = 4,
    guildNotice = 5,
    guildIntro = 6,
    declareWar = 7,
    guildMark = 8,
    deportation = 9,
    changeMaster = 10,
    appointCommander = 11,
    cancelCommander = 12,
    leaveGuild = 13,
    disperseGuild = 14,
    showContract = 15,
    clanDeportation = 16,
    voiceOption = 17,
    funding = 18,
    protection = 19,
    cancelProtection = 20,
    disbandClan = 21,
    leaveClan = 22,
    nonParticipate = 23,
    participation = 24,
    joinReward = 25,
    joinMemberCount = 26,
    incentive = 27,
    appointSupply = 28,
    mandateMaster = 29,
    guildWareHouse = 30,
    inviteLargeParty = 31,
    protectionIncrease = 32,
    allyNotice = 33,
    allyMarkChange = 34,
    allydisperse = 35,
    allyNoticeReset = 36,
    payGuildTax = 37,
    payGuildTaxAllMember = 38,
    arshaAdminGet = 39
  },
  _btnString = {
    [0] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDFUNCTION_INFOBTN"),
    PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDFUNCTION_PAYBTN"),
    PAGetString(Defines.StringSheet_RESOURCE, "PANEL_AGREEMENTGUILDMASTER_BTN_PERIOD_RENEW"),
    PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDFUNCTION_SOUNDBTN"),
    PAGetString(Defines.StringSheet_RESOURCE, "INTERACTION_BTN_PARTY"),
    PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_LIST_NOTICE_TITLE"),
    PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_INTRODUCETITLE"),
    PAGetString(Defines.StringSheet_RESOURCE, "GUILD_BTN_LETSWAR"),
    PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDMARK_TITLE"),
    PAGetString(Defines.StringSheet_GAME, "GULD_BUTTON1"),
    PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_0"),
    PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_APPOINT_GUILDSUBMASTER"),
    PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_3"),
    PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_WITHDRAW_GUILD"),
    PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_DISPERSE_GUILD"),
    PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_SHOWCONTRACT"),
    PAGetString(Defines.StringSheet_GAME, "GULD_BUTTON1"),
    PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDFUNCTION_SOUNDBTN"),
    PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_USEGUILDFUNDS_TITLE"),
    PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_4"),
    PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_5"),
    PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLANLIST_BTN_CLANDISPERSAL"),
    PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLAN_LEAVE"),
    PAGetString(Defines.StringSheet_GAME, "LUA_SIEGE_NONPARTICIPANT"),
    PAGetString(Defines.StringSheet_GAME, "LUA_SIEGE_PARTICIPANT"),
    PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDLIST_BOTTOM_BUTTON_JOINREWARD"),
    PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_EXPAND_MAX_COUNT"),
    PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_INCENTIVE_TITLE"),
    PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_SUPPLYOFFICER_APPOINTMENT_TITLE"),
    PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMASTER_MANDATE_TOOLTIP_NAME"),
    PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_SIMPLETOOLTIP_WAREHOUSE"),
    PAGetString(Defines.StringSheet_RESOURCE, "INTERACTION_BTN_LARGEPARTY"),
    PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_HELP_PROTECTADD"),
    PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALLIANCEINFO_SAVENOTICE"),
    PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCE_ADDMARK_MESSAGEBOX_TITLE"),
    PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCEINFO_MESSAGE_DISBAND_TITLE"),
    PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALLIANCEINFO_RESETNOTICE"),
    PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDINFO_ALL_UNPAIDTAX"),
    PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MARKETPLACE_REGISTMONEY"),
    PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_SIMPLETOOLTIP_GETARSHAHOST")
  },
  _eOpenType = {
    INFO = 0,
    LIST = 1,
    ALLYINFO = 2
  },
  _menuCount = 15,
  _enabledBtnCount = 0,
  _originPanelSize = 0,
  _funcBtnTable = {},
  _openType = nil,
  _isSiegeParticipant = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildFunctionPanel_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildFunctionPanel_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildFunctionPanel_All_Init")
function FromClient_GuildFunctionPanel_All_Init()
  PaGlobal_GuildFunctionPanel_All:initialize()
end