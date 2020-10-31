PaGlobal_Menu_Renew = {
  _ui = {
    txt_btnBG = {},
    btn_icon = {},
    txt_hotKey = {},
    stc_newIcon = {},
    stc_hotIcon = {},
    stc_checkIcon = {},
    stc_important = {},
    _topBg = UI.getChildControl(Panel_Window_Menu_Renew, "Static_TopBg")
  },
  _xbox = {},
  _animationTable = {}
}
PaGlobal_Menu_Renew._xbox = {
  _siegeWarCall = 0,
  _busterCall = 1,
  _summonPartyCall = 2,
  _returnTown = 3,
  _keyGuide = 4,
  _escape = 5,
  _inven = 6,
  _manufacture = 7,
  _option = 8,
  _gameExit = 9,
  _blackSpirit = 10,
  _questInfo = 11,
  _skill = 12,
  _myInfo = 13,
  _knowledge = 14,
  _worldMap = 15,
  _guild = 16,
  _friend = 17,
  _ringMenu = 18,
  _cashShop = 19,
  _pet = 20,
  _beauty = 21,
  _beautyAlbum = 22,
  _partyRecruite = 23,
  _localWar = 24,
  _freeFight = 25,
  _couquestStatus = 26,
  _partySetting = 27,
  _platoonSetting = 28,
  _dailyStamp = 29,
  _craftingNote = 30,
  _tradeInfo = 31,
  _worldMarketPlace = 32,
  _personalMonster = 33,
  _mail = 34,
  _help = 35,
  _copyright = 36,
  _news = 37,
  _challengeReward = 38,
  _report = 39,
  _privacy = 40,
  _EULA = 41,
  _lifeRanking = 42,
  _blackSpiritSkillLock = 43,
  _bloodAltar = 44,
  _bloodAltarRank = 45,
  _bookShelf = 46,
  _alchemyStone = 47,
  _dropItem = 48,
  _alchemyFigureHead = 49,
  _arshaPvP = 50,
  _totalReward = 51,
  _immortalHell = 52,
  _count = 53
}
PaGlobal_Menu_Renew._categoryData = {
  [PaGlobal_Menu_Renew._xbox._siegeWarCall] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_WARCALL_TOOLTIP_NAME"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _isImportant = true,
    _isVisible = false,
    _x1 = 344,
    _y1 = 116,
    _x2 = 399,
    _y2 = 171
  },
  [PaGlobal_Menu_Renew._xbox._busterCall] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_BUSTERCALL_TOOLTIP_NAME"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _isImportant = true,
    _isVisible = false,
    _x1 = 116,
    _y1 = 173,
    _x2 = 171,
    _y2 = 228
  },
  [PaGlobal_Menu_Renew._xbox._summonPartyCall] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MENU_COMPASS_TITLE"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _isImportant = true,
    _isVisible = false,
    _x1 = 344,
    _y1 = 230,
    _x2 = 399,
    _y2 = 285
  },
  [PaGlobal_Menu_Renew._xbox._returnTown] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_RETURNSTONE_NAME"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _isImportant = true,
    _isVisible = false,
    _x1 = 287,
    _y1 = 230,
    _x2 = 342,
    _y2 = 285
  },
  [PaGlobal_Menu_Renew._xbox._help] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TERMSOFUSE_TITLE"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 2,
    _y1 = 344,
    _x2 = 57,
    _y2 = 399
  },
  [PaGlobal_Menu_Renew._xbox._escape] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_ESCAPE"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 59,
    _y1 = 2,
    _x2 = 114,
    _y2 = 57
  },
  [PaGlobal_Menu_Renew._xbox._option] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_OPTION"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 173,
    _y1 = 2,
    _x2 = 228,
    _y2 = 57
  },
  [PaGlobal_Menu_Renew._xbox._inven] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_BAG"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 116,
    _y1 = 2,
    _x2 = 171,
    _y2 = 57
  },
  [PaGlobal_Menu_Renew._xbox._gameExit] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_EXIT"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 230,
    _y1 = 2,
    _x2 = 285,
    _y2 = 57
  },
  [PaGlobal_Menu_Renew._xbox._blackSpirit] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_BLACKSPIRIT"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 287,
    _y1 = 2,
    _x2 = 342,
    _y2 = 57
  },
  [PaGlobal_Menu_Renew._xbox._questInfo] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_QUESTHISTORY"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 344,
    _y1 = 2,
    _x2 = 399,
    _y2 = 57
  },
  [PaGlobal_Menu_Renew._xbox._skill] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_SKILL"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 2,
    _y1 = 59,
    _x2 = 57,
    _y2 = 114
  },
  [PaGlobal_Menu_Renew._xbox._myInfo] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_MYINFO"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 59,
    _y1 = 59,
    _x2 = 114,
    _y2 = 114
  },
  [PaGlobal_Menu_Renew._xbox._knowledge] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_MENTALKNOWLEDGE"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 116,
    _y1 = 59,
    _x2 = 171,
    _y2 = 114
  },
  [PaGlobal_Menu_Renew._xbox._worldMap] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_WORLDMAP"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 173,
    _y1 = 59,
    _x2 = 228,
    _y2 = 114
  },
  [PaGlobal_Menu_Renew._xbox._guild] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_GUILD"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 230,
    _y1 = 59,
    _x2 = 285,
    _y2 = 114
  },
  [PaGlobal_Menu_Renew._xbox._friend] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_FRIENDLIST"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 287,
    _y1 = 59,
    _x2 = 342,
    _y2 = 114
  },
  [PaGlobal_Menu_Renew._xbox._ringMenu] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUICKMENU_RINGMENUSETTING"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 344,
    _y1 = 59,
    _x2 = 399,
    _y2 = 114
  },
  [PaGlobal_Menu_Renew._xbox._cashShop] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_UiCashShop"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 230,
    _y1 = 116,
    _x2 = 285,
    _y2 = 171
  },
  [PaGlobal_Menu_Renew._xbox._pet] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_PET"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 2,
    _y1 = 116,
    _x2 = 57,
    _y2 = 171
  },
  [PaGlobal_Menu_Renew._xbox._beauty] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_BEAUTY"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 59,
    _y1 = 116,
    _x2 = 114,
    _y2 = 171
  },
  [PaGlobal_Menu_Renew._xbox._beautyAlbum] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BEAUTYALBUM_TITLE"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 173,
    _y1 = 173,
    _x2 = 228,
    _y2 = 228
  },
  [PaGlobal_Menu_Renew._xbox._craftingNote] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PRODUCTNOTE_TITLE"),
    txt_hotKey = "",
    _isVisible = _ContentsGroup_RenewUI_ProductNote,
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 287,
    _y1 = 173,
    _x2 = 342,
    _y2 = 228
  },
  [PaGlobal_Menu_Renew._xbox._partyRecruite] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYLISTRECRUITE_TITLE"),
    txt_hotKey = "",
    _isVisible = ToClient_IsContentsGroupOpen("254"),
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 117,
    _y1 = 116,
    _x2 = 172,
    _y2 = 171
  },
  [PaGlobal_Menu_Renew._xbox._localWar] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_LIFERANKING_TAB_LOCALWAR"),
    txt_hotKey = "",
    _isVisible = ToClient_IsContentsGroupOpen("43"),
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 173,
    _y1 = 116,
    _x2 = 228,
    _y2 = 171
  },
  [PaGlobal_Menu_Renew._xbox._freeFight] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_FREEFIGHT"),
    txt_hotKey = "",
    _isVisible = ToClient_IsContentsGroupOpen("255"),
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 173,
    _y1 = 230,
    _x2 = 228,
    _y2 = 285
  },
  [PaGlobal_Menu_Renew._xbox._mail] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_MAIL_TITLE"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 287,
    _y1 = 116,
    _x2 = 342,
    _y2 = 171
  },
  [PaGlobal_Menu_Renew._xbox._keyGuide] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_KEYGUIDE_TITLE"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 59,
    _y1 = 400,
    _x2 = 114,
    _y2 = 455
  },
  [PaGlobal_Menu_Renew._xbox._partySetting] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_TITLE"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 230,
    _y1 = 344,
    _x2 = 285,
    _y2 = 399
  },
  [PaGlobal_Menu_Renew._xbox._platoonSetting] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LARGEPARTYSETTING_TITLE"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _isVisible = _ContentsGroup_LargeParty,
    _x1 = 287,
    _y1 = 344,
    _x2 = 342,
    _y2 = 399
  },
  [PaGlobal_Menu_Renew._xbox._dailyStamp] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DAILYSTAMP_NEWTITLE"),
    txt_hotKey = "",
    _isVisible = ToClient_IsContentsGroupOpen("1025"),
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 2,
    _y1 = 287,
    _x2 = 57,
    _y2 = 342
  },
  [PaGlobal_Menu_Renew._xbox._worldMarketPlace] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MARKETPLACE_TITLE"),
    txt_hotKey = "",
    _isVisible = ToClient_IsContentsGroupOpen("464"),
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 2,
    _y1 = 173,
    _x2 = 57,
    _y2 = 228
  },
  [PaGlobal_Menu_Renew._xbox._personalMonster] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PERSONALMONSTER_TITLE"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _isVisible = _ContentsGroup_Console_PersonalMonster,
    _x1 = 344,
    _y1 = 287,
    _x2 = 399,
    _y2 = 342
  },
  [PaGlobal_Menu_Renew._xbox._couquestStatus] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDWARINFO_TITLE"),
    txt_hotKey = "",
    _isVisible = ToClient_IsContentsGroupOpen("21"),
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 2,
    _y1 = 400,
    _x2 = 57,
    _y2 = 455
  },
  [PaGlobal_Menu_Renew._xbox._copyright] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_COPYRIGHT_TITLE"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 230,
    _y1 = 173,
    _x2 = 285,
    _y2 = 228
  },
  [PaGlobal_Menu_Renew._xbox._news] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MENU_NEWS_TITLE"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 344,
    _y1 = 173,
    _x2 = 399,
    _y2 = 228
  },
  [PaGlobal_Menu_Renew._xbox._challengeReward] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "UI_WIN_CHALLENGE_REWARD_TITLE"),
    txt_hotKey = "",
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 59,
    _y1 = 230,
    _x2 = 114,
    _y2 = 285
  },
  [PaGlobal_Menu_Renew._xbox._tradeInfo] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_TRADEMARKET"),
    txt_hotKey = "",
    _isVisible = ToClient_IsContentsGroupOpen("26"),
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 2,
    _y1 = 230,
    _x2 = 57,
    _y2 = 285
  },
  [PaGlobal_Menu_Renew._xbox._report] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAVAGEDEFENCE_RESULT_REPORT"),
    txt_hotKey = "",
    _isVisible = ToClient_isPS4(),
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 116,
    _y1 = 230,
    _x2 = 171,
    _y2 = 285
  },
  [PaGlobal_Menu_Renew._xbox._privacy] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MENU_PRIVACYPOLICY"),
    txt_hotKey = "",
    _isVisible = true,
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 2,
    _y1 = 344,
    _x2 = 57,
    _y2 = 399
  },
  [PaGlobal_Menu_Renew._xbox._EULA] = {
    _string = "EULA",
    txt_hotKey = "",
    _isVisible = true,
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 2,
    _y1 = 344,
    _x2 = 57,
    _y2 = 399
  },
  [PaGlobal_Menu_Renew._xbox._manufacture] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_MANUFACTURE_TITLE"),
    txt_hotKey = "",
    _isVisible = true,
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 59,
    _y1 = 344,
    _x2 = 114,
    _y2 = 399
  },
  [PaGlobal_Menu_Renew._xbox._lifeRanking] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LIFERANKING_TITLE"),
    txt_hotKey = "",
    _isVisible = _ContentsGroup_NewUI_LifeRanking_All,
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 116,
    _y1 = 344,
    _x2 = 171,
    _y2 = 399
  },
  [PaGlobal_Menu_Renew._xbox._blackSpiritSkillLock] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BLACKSPIRITLOCK_TITLE"),
    txt_hotKey = "",
    _isVisible = _ContentsGroup_NewUI_BlackSpiritSkillLock_All,
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 230,
    _y1 = 287,
    _x2 = 285,
    _y2 = 342
  },
  [PaGlobal_Menu_Renew._xbox._bloodAltar] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_BLOODALTAR_TITLE"),
    txt_hotKey = "",
    _isVisible = _ContentsGroup_Console_BloodAltar or _ContentsGroup_Origin_BloodAltar,
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 285,
    _y1 = 287,
    _x2 = 342,
    _y2 = 342
  },
  [PaGlobal_Menu_Renew._xbox._bloodAltarRank] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALTARRANKWEB_TITLE_FOR_ESCMENU"),
    txt_hotKey = "",
    _isVisible = _ContentsGroup_Console_BloodAltarRanking,
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 173,
    _y1 = 287,
    _x2 = 228,
    _y2 = 342
  },
  [PaGlobal_Menu_Renew._xbox._bookShelf] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_ACHIEVEMENT_BOOKSHELF"),
    txt_hotKey = "",
    _isVisible = _ContentsGroup_AchievementQuest and ToClient_IsGrowStepOpen(__eGrowStep_oldBook),
    _path = "Renewal/Button/Console_Btn_ESCMenu.dds",
    _x1 = 126,
    _y1 = 498,
    _x2 = 186,
    _y2 = 558
  },
  [PaGlobal_Menu_Renew._xbox._alchemyStone] = {
    _string = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_alchemyStone"),
    txt_hotKey = "",
    _isVisible = _ContentsGroup_NewUI_AlchemyStone_All and ToClient_IsContentsGroupOpen("35"),
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 116,
    _y1 = 400,
    _x2 = 171,
    _y2 = 455
  },
  [PaGlobal_Menu_Renew._xbox._dropItem] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_DROPITEM"),
    txt_hotKey = "",
    _isVisible = _ContentsGroup_NewUI_DropItem_All and _ContentsGroup_DropItem,
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 173,
    _y1 = 344,
    _x2 = 228,
    _y2 = 399
  },
  [PaGlobal_Menu_Renew._xbox._alchemyFigureHead] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INVENTORY_TOTEMBUTTON"),
    txt_hotKey = "",
    _isVisible = _ContentsGroup_NewUI_AlchemyFigureHead_All and _ContentsGroup_AlchemyFigureHead,
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 344,
    _y1 = 344,
    _x2 = 399,
    _y2 = 399
  },
  [PaGlobal_Menu_Renew._xbox._arshaPvP] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_COMPETITION"),
    txt_hotKey = "",
    _isVisible = _ContentsGroup_NewUI_Arsha_All and ToClient_IsGrowStepOpen(__eGrowStep_arsha) and _ContentsGroup_Arsha,
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 116,
    _y1 = 287,
    _x2 = 171,
    _y2 = 342
  },
  [PaGlobal_Menu_Renew._xbox._totalReward] = {
    _string = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TOTALREWARD_TITLE"),
    txt_hotKey = "",
    _isVisible = _ContentsGroup_NewUI_TotalReward_All and _ContentsGroup_TotalReward,
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 59,
    _y1 = 287,
    _x2 = 114,
    _y2 = 342
  },
  [PaGlobal_Menu_Renew._xbox._immortalHell] = {
    _string = PAGetString(Defines.StringSheet_GAME, "LUA_PVE_ARENA_TELEPORT_MSGTITLE"),
    txt_hotKey = "",
    _isVisible = _ContentsGroup_isOepnImmortalHell or _ContentsGroup_isOpenImmortalHellForConsole,
    _path = "Combine/Console/Combine_Console_ESCMenuIcon.dds",
    _x1 = 173,
    _y1 = 400,
    _x2 = 228,
    _y2 = 455
  }
}
function PaGlobal_Menu_Renew:ShowAni()
end
function PaGlobal_Menu_Renew:HideAni()
end
function PaGlobal_Menu_Renew:Init()
  Panel_Window_Menu_Renew:SetShow(false)
  Panel_Window_Menu_Renew:setGlassBackground(true)
  Panel_Window_Menu_Renew:ActiveMouseEventEffect(true)
  Panel_Window_Menu_Renew:RegisterShowEventFunc(true, "PaGlobal_Menu_Renew:ShowAni()")
  Panel_Window_Menu_Renew:RegisterShowEventFunc(false, "PaGlobal_Menu_Renew:HideAni()")
  local buttonTemplate = UI.getChildControl(Panel_Window_Menu_Renew, "StaticText_ButtonBg_Template")
  buttonTemplate:SetTextMode(__eTextMode_AutoWrap)
  for index = 0, self._xbox._count - 1 do
    self._ui.txt_btnBG[index] = UI.createAndCopyBasePropertyControl(Panel_Window_Menu_Renew, "StaticText_ButtonBg_Template", Panel_Window_Menu_Renew, "StaticText_ButtonBg_" .. index)
    self._ui.btn_icon[index] = UI.createAndCopyBasePropertyControl(buttonTemplate, "Button_MenuIcon", self._ui.txt_btnBG[index], "Button_MenuIcon")
    self._ui.txt_hotKey[index] = UI.createAndCopyBasePropertyControl(buttonTemplate, "StaticText_HotKey", self._ui.txt_btnBG[index], "StaticText_HotKey")
    self._ui.stc_newIcon[index] = UI.createAndCopyBasePropertyControl(buttonTemplate, "Static_NewIcon", self._ui.txt_btnBG[index], "Static_NewIcon")
    self._ui.stc_hotIcon[index] = UI.createAndCopyBasePropertyControl(buttonTemplate, "Static_HotIcon", self._ui.txt_btnBG[index], "Static_HotIcon")
    self._ui.stc_checkIcon[index] = UI.createAndCopyBasePropertyControl(buttonTemplate, "Static_CheckIcon", self._ui.txt_btnBG[index], "Static_CheckIcon")
    self._ui.stc_important[index] = UI.createAndCopyBasePropertyControl(buttonTemplate, "Static_Important", self._ui.txt_btnBG[index], "Static_Important")
    self._ui.txt_btnBG[index]:SetShow(false)
    self._ui.txt_hotKey[index]:SetShow(false)
    self._ui.stc_newIcon[index]:SetShow(false)
    self._ui.stc_hotIcon[index]:SetShow(false)
    self._ui.stc_checkIcon[index]:SetShow(false)
    self._ui.stc_important[index]:SetShow(false)
  end
  registerEvent("FromClient_ResponseBustCall", "FromClient_ResponseBustCall_Menu_Renew")
  registerEvent("FromClient_ResponseTeleportToSiegeTent", "FromClient_ResponseSiegeWarCall_Menu_Renew")
  registerEvent("FromClient_ResponseUseCompass", "FromClient_ResponseSummonPartyCall_Menu_Renew")
  registerEvent("ResponseParty_updatePartyList", "PaGlobalFunc_Menu_Renew_SummonPartyCallCheck")
  registerEvent("FromClient_ResponseUseReturnStone", "FromClient_ResponseUseReturnStone_Menu_Renew")
end
function PaGlobal_Menu_Renew:updateButtons()
  local selfPlayerWrraper = getSelfPlayer()
  if nil == selfPlayerWrraper then
    return
  end
  local selfPlayer = selfPlayerWrraper:get()
  if nil == selfPlayer then
    return
  end
  if selfPlayer:getLevel() < 7 or false == ToClient_IsContentsGroupOpen("1025") then
    self._categoryData[PaGlobal_Menu_Renew._xbox._dailyStamp]._isVisible = false
  else
    self._categoryData[PaGlobal_Menu_Renew._xbox._dailyStamp]._isVisible = true
  end
  local mailMenuIndex = 0
  local rewardMenuIndex = 0
  local visibleCount = 0
  local visibleButtons = {}
  for index = 0, self._xbox._count - 1 do
    self._ui.txt_btnBG[index]:SetShow(false)
    if false ~= self._categoryData[index]._isVisible then
      visibleButtons[#visibleButtons + 1] = index
      visibleCount = visibleCount + 1
    end
  end
  local index = 1
  while visibleCount > index * index do
    index = index + 1
  end
  local horizontalCount = math.max(4, index)
  self._animationTable = {}
  for ii = 1, #visibleButtons do
    local index = visibleButtons[ii]
    local uiIndex = ii - 1
    local categoryData = self._categoryData[index]
    if self._xbox._mail == index then
      mailMenuIndex = uiIndex
    elseif self._xbox._challengeReward == index then
      rewardMenuIndex = uiIndex
    end
    if false ~= self._categoryData[index]._isVisible then
      self._ui.txt_btnBG[uiIndex]:SetShow(true)
      self._ui.txt_btnBG[uiIndex]:SetText(categoryData._string)
      self._ui.txt_btnBG[uiIndex]:addInputEvent("Mouse_LUp", "PaGlobal_Menu_Renew:HandleClicked_MenuButton(" .. index .. ")")
      self._ui.txt_btnBG[uiIndex]:SetPosX(20 + uiIndex % horizontalCount * (self._ui.txt_btnBG[uiIndex]:GetSizeX() + 10))
      self._ui.txt_btnBG[uiIndex]:SetPosY(90 + math.floor(uiIndex / horizontalCount) * (self._ui.txt_btnBG[uiIndex]:GetSizeX() + 10))
      self._ui.btn_icon[uiIndex]:ChangeTextureInfoName(categoryData._path)
      local x1, y1, x2, y2 = setTextureUV_Func(self._ui.btn_icon[uiIndex], categoryData._x1, categoryData._y1, categoryData._x2, categoryData._y2)
      self._ui.btn_icon[uiIndex]:getBaseTexture():setUV(x1, y1, x2, y2)
      self._ui.btn_icon[uiIndex]:setRenderTexture(self._ui.btn_icon[uiIndex]:getBaseTexture())
      if categoryData._isImportant then
        self._animationTable[#self._animationTable + 1] = uiIndex
        self._ui.stc_important[uiIndex]:SetShow(true)
      else
        self._ui.stc_important[uiIndex]:SetShow(false)
      end
    else
      self._ui.txt_btnBG[uiIndex]:SetShow(false)
    end
  end
  local newMailFlag = RequestMail_getNewMailFlag()
  self._ui.stc_important[mailMenuIndex]:SetShow(newMailFlag)
  local rewardListCount = ToClient_GetChallengeRewardInfoCount()
  if 0 < rewardListCount then
    self._ui.stc_important[rewardMenuIndex]:SetShow(true)
  else
    self._ui.stc_important[rewardMenuIndex]:SetShow(false)
  end
  Panel_Window_Menu_Renew:SetSize((self._ui.txt_btnBG[0]:GetSizeX() + 10) * horizontalCount + 30, (self._ui.txt_btnBG[0]:GetSizeY() + 10) * math.ceil(visibleCount / horizontalCount) + 110)
  Panel_Window_Menu_Renew:ComputePos()
  self._ui._topBg:SetSize(Panel_Window_Menu_Renew:GetSizeX() - 8, self._ui._topBg:GetSizeY())
end
function PaGlobal_Menu_Renew:HandleClicked_MenuButton(index)
  if self._xbox._gameExit ~= index and nil ~= Panel_Window_QuestBranch and true == Panel_Window_QuestBranch:GetShow() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_NO_ENTER_BECAUSE_QUESTBRANCH"))
    return
  end
  if self._xbox._help == index then
    PaGlobal_PrivacyPolicy_Open(1, false)
  elseif self._xbox._busterCall == index then
    PaGlobal_Menu_Renew:busterCall()
  elseif self._xbox._siegeWarCall == index then
    PaGlobal_Menu_Renew:siegeWarCall()
  elseif self._xbox._summonPartyCall == index then
    PaGlobal_Menu_Renew:summonPartyCall()
  elseif self._xbox._returnTown == index then
    PaGlobal_Menu_Renew:returnTown()
  elseif self._xbox._escape == index then
    if ToClient_IsMyselfInArena() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_COMMON_ARLERT"))
      return
    elseif true == ToClient_getJoinGuildBattle() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_CANTDO_GUILDBATTLE"))
      return
    end
    _AudioPostEvent_SystemUiForXBOX(1, 41)
    local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MSGBOX_RESCUE")
    local messageBoxData = {
      title = messageBoxTitle,
      content = messageBoxMemo,
      functionYes = RescueExecute,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  elseif self._xbox._inven == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_Inventory)
  elseif self._xbox._option == index then
    showGameOption()
  elseif self._xbox._gameExit == index then
    if true == _ContentsGroup_NewUI_GameExit then
      PaGlobal_GameExit_All_ShowToggle(false)
    else
      GameExitShowToggle(false)
    end
  elseif self._xbox._blackSpirit == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_BlackSpirit)
  elseif self._xbox._questInfo == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_QuestHistory)
  elseif self._xbox._skill == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_Skill)
  elseif self._xbox._manufacture == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_Manufacture)
  elseif self._xbox._myInfo == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_PlayerInfo)
  elseif self._xbox._knowledge == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_MentalKnowledge)
  elseif self._xbox._worldMap == index then
    if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoingAlterOfBlood"))
      return
    end
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_WorldMap)
  elseif self._xbox._guild == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_Guild)
  elseif self._xbox._friend == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_FriendList)
  elseif self._xbox._ringMenu == index then
    FromClient_ConsoleQuickMenu_OpenCustomPage(2)
  elseif self._xbox._cashShop == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_CashShop)
  elseif self._xbox._pet == index then
    if true == _ContentsGroup_NewUI_Pet_All then
      PaGlobal_PetList_Toggle_All()
    else
      FGlobal_PetListNew_Toggle()
    end
  elseif self._xbox._beauty == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_BeautyShop)
  elseif self._xbox._beautyAlbum == index then
    if true == _ContentsGroup_RenewUI_BeautyAlbum then
      FGlobal_CustomizingAlbum_Show(false, CppEnums.ClientSceneState.eClientSceneStateType_InGame)
    end
  elseif self._xbox._craftingNote == index then
    Panel_ProductNote_ShowToggle()
  elseif self._xbox._partyRecruite == index then
    if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoingAlterOfBlood"))
      return
    end
    if true == _ContentsGroup_NewUI_PartyFind_All then
      PaGlobalFunc_PartyList_All_Open()
    else
      PaGlobalFunc_FindParty_Show()
    end
  elseif self._xbox._localWar == index then
    if getSelfPlayer():get():getLevel() < 7 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_LEVEL_LIMIT"))
      return
    end
    if true == _ContentsGroup_InstanceLocalWar then
      PaGlobal_LocalWarInfo_All_New_ESCMenuFunc()
    elseif true == _ContentsGroup_NewUI_LocalWar_All then
      PaGlobal_LocalWarInfo_All_ESCMenuFunc()
    else
      PaGlobalFunc_LocalWarInfo_Show()
    end
  elseif self._xbox._freeFight == index then
    PaGlobalFunc_FreeFight_Open()
  elseif self._xbox._mail == index then
    if false == _ContentsGroup_NewUI_Mail_All then
      Mail_Open()
    else
      PaGlobal_Window_Mail_All_Open()
    end
  elseif self._xbox._keyGuide == index then
    PaGlobalFunc_KeyGuidWindow_Open()
  elseif self._xbox._partySetting == index then
    if false == PaGlobalFunc_PartySetting_Open(CppEnums.PartyType.ePartyType_Normal) then
      return
    end
  elseif self._xbox._platoonSetting == index then
    if false == PaGlobalFunc_PartySetting_Open(CppEnums.PartyType.ePartyType_Large) then
      return
    end
  elseif self._xbox._dailyStamp == index then
    if true == _ContentsGroup_NewUI_DailyStamp_All then
      PaGlobalFunc_DailyStamp_All_Open()
    else
      PaGlobalFunc_DailyStamp_Open()
    end
  elseif self._xbox._worldMarketPlace == index then
    PaGlobalFunc_MarketPlaceConsole_OpenByMenu()
  elseif self._xbox._personalMonster == index then
    HandleEventLUp_PersonalMonster_All_Open()
  elseif self._xbox._couquestStatus == index then
    if true == _ContentsGroup_NewUI_GuildWarInfo_All then
      PaGlobalFunc_GuildWarInfo_All_Open()
    else
      PaGlobalFunc_GuildWarInfo_Open()
    end
  elseif self._xbox._copyright == index then
    PaGlobal_Copyright:open(0)
  elseif self._xbox._news == index then
    PaGlobalFunc_NewsBanner_Open()
  elseif self._xbox._challengeReward == index then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_PlayerInfo)
    if true == _ContentsGroup_NewUI_CharInfo_All then
      if nil ~= Panel_CharacterInfo_All then
        HandleEventLUp_ChracterInfo_All_ClickOtherTab(PaGlobal_CharInfo_All._TABINDEX._challenge)
        HandleEventLUp_CharInfoChallenge_All_ChallengeTabClick(5)
      end
    else
      PaGlobalFunc_SetCharacterChallengeInfo()
      PaGlobalFunc_SetCharacterChallengeInfoReward()
    end
  elseif self._xbox._tradeInfo == index then
    if true == _ContentsGroup_NewUI_TradeEventNotice_All then
      PaGlobalFunc_TradeEventNotice_Renewal_All_Open()
    else
      PaGlobal_TradeInformation:Show()
    end
  elseif self._xbox._report == index then
    PaGloabl_Report_Open()
  elseif self._xbox._privacy == index then
    PaGlobal_PrivacyPolicy_Open(0, false)
  elseif self._xbox._EULA == index then
    PaGlobal_Copyright:open(1)
  elseif self._xbox._lifeRanking == index then
    PaGlobal_LifeRanking_Open_All()
  elseif self._xbox._blackSpiritSkillLock == index then
    PaGlobalFunc_BlackSpiritSkillLock_All_Open(3)
  elseif self._xbox._bloodAltar == index then
    PaGlobal_HandleClicked_BloodAltar_Open()
  elseif self._xbox._bloodAltarRank == index then
    PaGlobal_AltarRankWeb_Open()
  elseif self._xbox._bookShelf == index then
    PaGlobalFunc_Achievement_BookShelf_All_Open()
  elseif self._xbox._alchemyStone == index then
    PaGlobalFunc_AlchemyStone_All_Open()
  elseif self._xbox._dropItem == index then
    PaGlobalFunc_DropItem_All_Open()
  elseif self._xbox._alchemyFigureHead == index then
    PaGlobal_AlchemyFigureHead_All_Open()
  elseif self._xbox._arshaPvP == index then
    PaGlobaFunc_Arsha_Reservation_All_ESCMenuFunc()
  elseif self._xbox._totalReward == index then
    PaGlobal_TotalReward_All_Open()
  elseif self._xbox._immortalHell == index then
    PaGlobalFunc_ImmortalHell()
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  Panel_Window_Menu_Close()
end
local setJumpAnimation = function(control)
  control:ResetVertexAni()
  local ImageMoveAni1 = control:addMoveAnimation(0, 0.2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_PI)
  ImageMoveAni1:SetStartPosition(control:GetPosX(), 20)
  ImageMoveAni1:SetEndPosition(control:GetPosX(), 26)
  ImageMoveAni1.IsChangeChild = true
  local scaleAni1 = control:addScaleAnimation(0, 0.2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_PI)
  scaleAni1:SetStartScale(1)
  scaleAni1:SetEndScale(0.9)
  scaleAni1.ScaleType = 2
  scaleAni1.IsChangeChild = true
  local ImageMoveAni2 = control:addMoveAnimation(0.201, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_PI)
  ImageMoveAni2:SetStartPosition(control:GetPosX(), 20)
  ImageMoveAni2:SetEndPosition(control:GetPosX(), 10)
  ImageMoveAni2.IsChangeChild = true
  control:CalcUIAniPos(ImageMoveAni2)
  local ImageMoveAni3 = control:addMoveAnimation(0.501, 0.7, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_PI)
  ImageMoveAni3:SetStartPosition(control:GetPosX(), 20)
  ImageMoveAni3:SetEndPosition(control:GetPosX(), 26)
  ImageMoveAni3.IsChangeChild = true
  local scaleAni2 = control:addScaleAnimation(0.501, 0.7, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_PI)
  scaleAni2:SetStartScale(1)
  scaleAni2:SetEndScale(0.9)
  scaleAni2.ScaleType = 2
  scaleAni2.IsChangeChild = true
end
local function reducedPerframe(deltaTime)
  local self = PaGlobal_Menu_Renew
  if nil == PaGlobal_Menu_Renew or nil == self._animationTable then
    return
  end
  for ii = 1, #self._animationTable do
    local uiIndex = self._animationTable[ii]
    setJumpAnimation(self._ui.stc_important[uiIndex])
  end
end
local accumulatedTime = 0
function PaGlobal_Menu_Renew_UpdatePerFrame(deltaTime)
  accumulatedTime = accumulatedTime + deltaTime
  if 1 < accumulatedTime then
    reducedPerframe(deltaTime)
    accumulatedTime = 0
  end
end
function RescueExecute()
  callRescue()
end
function Panel_Window_Menu_ShowToggle()
  local self = PaGlobal_Menu_Renew
  local isShow = Panel_Window_Menu_Renew:GetShow()
  if false == _ContentsGroup_NewUI_DeadMessage_All then
    if false == isShow and nil ~= Panel_DeadMessage_Renew and Panel_DeadMessage_Renew:GetShow() then
      return
    end
  elseif false == isShow and nil ~= Panel_DeadMessage_All and Panel_DeadMessage_All:GetShow() then
    return
  end
  Panel_Window_Menu_Renew:SetShow(not isShow)
  if not isShow then
    _AudioPostEvent_SystemUiForXBOX(53, 37)
    PaGlobal_Menu_Renew:updateButtons()
    for ii = 1, #self._animationTable do
      local uiIndex = self._animationTable[ii]
      setJumpAnimation(self._ui.stc_important[uiIndex])
    end
  end
end
function Panel_Window_Menu_Close()
  Panel_Window_Menu_Renew:SetShow(false)
  if _ContentsGroup_XB_Obt then
    local isInvenOpen = false
    if true == _ContentsGroup_NewUI_Inventory_All then
      isInvenOpen = Panel_Window_Inventory_All:IsShow()
    else
      isInvenOpen = Panel_Window_Inventory:IsShow()
    end
    PaGlobalFunc_PreOrder_Close(Panel_Window_Menu_Renew, isInvenOpen)
  end
end
function PaGlobal_Menu_Renew:ShowAni()
end
function PaGlobal_Menu_Renew:HideAni()
end
function FromClient_ResponseBustCall_Menu_Renew(sendType)
  local self = PaGlobal_Menu_Renew
  if 0 == sendType then
    local leftTime = Int64toInt32(getLeftSecond_TTime64(ToClient_GetGuildBustCallTime()))
    self._categoryData[self._xbox._busterCall]._isVisible = true
    luaTimer_AddEvent(PaGlobalFunc_Menu_Renew_BusterCallCheck, leftTime * 1000, false, 0)
  else
    self._categoryData[self._xbox._busterCall]._isVisible = false
  end
end
function PaGlobal_Menu_Renew:busterCall()
  local regionInfoWrapper = ToClient_getRegionInfoWrapperByPosition(ToClient_GetGuildBustCallPos())
  if nil == regionInfoWrapper then
    return
  end
  local areaName = regionInfoWrapper:getAreaName()
  local usableTime64 = ToClient_GetGuildBustCallTime()
  local descStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_BUSTERCALL_TOOLTIP_DESC_CONSOLE", "areaName", areaName, "time", convertStringFromDatetime(getLeftSecond_TTime64(usableTime64)))
  MessageBox.showMessageBox({
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_BUSTERCALL_TOOLTIP_NAME"),
    content = descStr,
    functionYes = PaGlobal_Menu_Renew_BusterCallConfirm,
    functionNo = MessageBox_Empty_function
  })
end
function PaGlobal_Menu_Renew_BusterCallConfirm()
  local self = PaGlobal_Menu_Renew
  self._categoryData[self._xbox._busterCall]._isVisible = false
  ToClient_RequestTeleportGuildBustCall()
end
function PaGlobalFunc_Menu_Renew_BusterCallCheck()
  local self = PaGlobal_Menu_Renew
  local leftTime = Int64toInt32(getLeftSecond_TTime64(ToClient_GetGuildBustCallTime()))
  self._categoryData[self._xbox._busterCall]._isVisible = 0 < leftTime
end
function FromClient_ResponseSiegeWarCall_Menu_Renew(sendType)
  local self = PaGlobal_Menu_Renew
  if 0 == sendType then
    local leftTime = Int64toInt32(getLeftSecond_TTime64(ToClient_GetTeleportToSiegeTentTime()))
    self._categoryData[self._xbox._siegeWarCall]._isVisible = true
    luaTimer_AddEvent(PaGlobalFunc_Menu_Renew_SiegeWarCallCheck, leftTime * 1000, false, 0)
  else
    self._categoryData[self._xbox._siegeWarCall]._isVisible = false
  end
end
function PaGlobal_Menu_Renew:siegeWarCall()
  local regionInfoWrapper = ToClient_getRegionInfoWrapperByPosition(ToClient_GetTeleportToSiegeTentPos())
  if nil == regionInfoWrapper then
    return
  end
  local areaName = regionInfoWrapper:getAreaName()
  local usableTime64 = ToClient_GetTeleportToSiegeTentTime()
  local descStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_BUSTERCALL_TOOLTIP_DESC_CONSOLE", "areaName", areaName, "time", convertStringFromDatetime(getLeftSecond_TTime64(usableTime64)))
  MessageBox.showMessageBox({
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_BUSTERCALL_TOOLTIP_NAME"),
    content = descStr,
    functionYes = PaGlobal_Menu_Renew_SiegeWarCallConfirm,
    functionNo = MessageBox_Empty_function
  })
end
function PaGlobal_Menu_Renew_SiegeWarCallConfirm()
  local self = PaGlobal_Menu_Renew
  self._categoryData[self._xbox._siegeWarCall]._isVisible = false
  ToClient_RequestTeleportToSiegeTentCall()
end
function PaGlobalFunc_Menu_Renew_SiegeWarCallCheck()
  local self = PaGlobal_Menu_Renew
  local leftTime = Int64toInt32(getLeftSecond_TTime64(ToClient_GetTeleportToSiegeTentTime()))
  self._categoryData[self._xbox._siegeWarCall]._isVisible = 0 < leftTime
  local minorSiegeWrapper = ToClient_GetCurrentMinorSiegeWrapper()
  if nil == minorSiegeWrapper then
    return
  end
  if false == minorSiegeWrapper:isSiegeBeing() then
    self._categoryData[self._xbox._siegeWarCall]._isVisible = false
  end
end
function FromClient_ResponseSummonPartyCall_Menu_Renew()
  local self = PaGlobal_Menu_Renew
  local partyActorKey = ToClient_GetCharacterActorKeyRawUseCompass()
  local playerActorKey = getSelfPlayer():getActorKey()
  if partyActorKey == playerActorKey then
    self._categoryData[self._xbox._summonPartyCall]._isVisible = false
  else
    local leftTime = Int64toInt32(ToClient_GetLeftUsableTeleportCompassTime())
    self._categoryData[self._xbox._summonPartyCall]._isVisible = true
    luaTimer_AddEvent(PaGlobalFunc_Menu_Renew_SummonPartyCallCheck, leftTime * 1000, false, 0)
  end
end
function PaGlobal_Menu_Renew:summonPartyCall()
  local partyActorKey = ToClient_GetCharacterActorKeyRawUseCompass()
  local playerActorKey = getSelfPlayer():getActorKey()
  local descStr = ""
  local partyLeaderName = ToClient_GetCharacterNameUseCompass()
  local usableTime64 = ToClient_GetLeftUsableTeleportCompassTime()
  if partyActorKey == playerActorKey then
    descStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPASS_DESC_1", "remainTime", convertStringFromDatetime(usableTime64))
  else
    descStr = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WIDGET_COMPASS_MESSAGEBOXDESC", "partyName", partyLeaderName, "partyName1", partyLeaderName, "remainTime", convertStringFromDatetime(usableTime64))
  end
  MessageBox.showMessageBox({
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMPASS_NAME"),
    content = descStr,
    functionYes = PaGlobal_Menu_Renew_SummonPartyCallConfirm,
    functionNo = MessageBox_Empty_function
  })
end
function PaGlobal_Menu_Renew_SummonPartyCallConfirm()
  local self = PaGlobal_Menu_Renew
  local leftTime_s64 = ToClient_GetLeftUsableTeleportCompassTime()
  local leftTime = Int64toInt32(leftTime_s64)
  if 0 < leftTime then
    if IsSelfPlayerWaitAction() then
      self._categoryData[self._xbox._summonPartyCall]._isVisible = false
      ToClient_RequestTeleportPosUseCompass()
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_NOTUSEALERT"))
    end
  end
end
function PaGlobalFunc_Menu_Renew_SummonPartyCallCheck()
  local self = PaGlobal_Menu_Renew
  local partyActorKey = ToClient_GetCharacterActorKeyRawUseCompass()
  local playerActorKey = getSelfPlayer():getActorKey()
  if partyActorKey == playerActorKey then
    self._categoryData[self._xbox._summonPartyCall]._isVisible = false
  else
    local partyMemeberCnt = RequestParty_getPartyMemberCount()
    if 0 < partyMemeberCnt then
      local leftTime = Int64toInt32(ToClient_GetLeftUsableTeleportCompassTime())
      self._categoryData[self._xbox._summonPartyCall]._isVisible = 0 < leftTime
    else
      self._categoryData[self._xbox._summonPartyCall]._isVisible = false
    end
  end
end
function FromClient_ResponseUseReturnStone_Menu_Renew()
  local self = PaGlobal_Menu_Renew
  PaGlobalFunc_Menu_Renew_ReturnTownCheck()
end
function PaGlobal_Menu_Renew:returnTown()
  local returnPos3D = ToClient_GetPosUseReturnStone()
  local regionInfo = getRegionInfoByPosition(returnPos3D)
  local regionName = ""
  if nil ~= regionInfo then
    regionName = regionInfo:getAreaName()
  end
  local returnTownRegionKey = ToClient_GetReturnStoneTownRegionKey()
  local usableTime64 = ToClient_GetLeftReturnStoneTime()
  local descStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_RETURNSTONE_DESC", "regionName", regionName, "remainTime", convertStringFromDatetime(usableTime64))
  MessageBox.showMessageBox({
    title = PAGetString(Defines.StringSheet_GAME, "LUA_RETURNSTONE_NAME"),
    content = descStr,
    functionYes = PaGlobal_Menu_Renew_ReturnTownConfirm,
    functionNo = MessageBox_Empty_function
  })
end
function PaGlobal_Menu_Renew_ReturnTownConfirm()
  local self = PaGlobal_Menu_Renew
  local remainTime_s64 = ToClient_GetLeftReturnStoneTime()
  local remainTime = Int64toInt32(remainTime_s64)
  local returnPos3D = ToClient_GetPosUseReturnStone()
  local regionInfo = getRegionInfoByPosition(returnPos3D)
  if 0 < remainTime then
    if IsSelfPlayerWaitAction() then
      ToClient_RequestTeleportPosUseReturnStone()
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_NOTUSEALERT"))
    end
  end
end
function PaGlobalFunc_Menu_Renew_ReturnTownCheck()
  local self = PaGlobal_Menu_Renew
  local usableTime64 = ToClient_GetLeftReturnStoneTime()
  local remainTime = Int64toInt32(usableTime64)
  if 0 < remainTime then
    if nil == self._returnTownTimerKey then
      self._returnTownTimerKey = luaTimer_AddEvent(PaGlobalFunc_Menu_Renew_ReturnTownCheck, remainTime * 1000, false, 0)
    end
    self._categoryData[self._xbox._returnTown]._isVisible = true
  else
    self._categoryData[self._xbox._returnTown]._isVisible = false
    self._returnTownTimerKey = nil
    self:updateButtons()
  end
end
function PaGlobal_Menu_Renew_Init()
  PaGlobal_Menu_Renew:Init()
  Panel_Window_Menu_Renew:RegisterUpdateFunc("PaGlobal_Menu_Renew_UpdatePerFrame")
  PaGlobalFunc_Menu_Renew_BusterCallCheck()
  PaGlobalFunc_Menu_Renew_SiegeWarCallCheck()
  PaGlobalFunc_Menu_Renew_SummonPartyCallCheck()
  PaGlobalFunc_Menu_Renew_ReturnTownCheck()
end
function PaGlobalFunc_FreeFight_Open()
  if nil == getSelfPlayer() then
    return
  end
  local player = getSelfPlayer():get()
  local maxHp = player:getMaxHp()
  local playerHp = player:getHp()
  if player:getLevel() < 50 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_FREEFIGHTALERT"))
    return
  end
  if false == _ContentsGroup_InstanceFreeBatttleField then
    local curChannelData = getCurrentChannelServerData()
    if true == curChannelData._isSiegeChannel then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BATTLEGROURND"))
      return
    end
    if true == ToClient_isSpecialCharacter() then
      if nil == player then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_FREEBATTLE_CANNOT_EXIT"))
        return
      end
      if true == player:isCompetitiococonDefined() then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoAnythingAfterCompetitionStart"))
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_FREEBATTLE_CANNOT_EXIT"))
      end
      return
    end
  end
  if ToClient_IsJoinPvpBattleGround() then
    local FunctionYesUnJoinPvpBattle = function()
      ToClient_UnJoinPvpBattleGround()
    end
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_PVPBATTLEGROUND_UNJOIN")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = messageBoxMemo,
      functionYes = FunctionYesUnJoinPvpBattle,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  elseif maxHp == playerHp then
    if false == IsSelfPlayerWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_PVPBATTLEGROUND_CONDITION_WAIT"))
      return
    end
    _AudioPostEvent_SystemUiForXBOX(1, 18)
    local FunctionYesJoinPvpBattle = function()
      ToClient_JoinPvpBattleGround(0)
    end
    if false == _ContentsGroup_InstanceFreeBatttleField then
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_PVPBATTLEGROUND_JOIN")
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
        content = messageBoxMemo,
        functionYes = FunctionYesJoinPvpBattle,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    else
      PaGlobalFunc_FreeBaettleField_All_Open()
    end
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_CHECKHP"))
  end
end
function PaGlobalFunc_ImmortalHell()
  if false == _ContentsGroup_isOepnImmortalHell and false == _ContentsGroup_isOpenImmortalHellForConsole then
    return
  end
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return true
  end
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  if nil == regionInfo then
    return true
  end
  local isPVEArenaZone = regionInfo:get():isPVEArenaZone()
  if true == isPVEArenaZone then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_PVE_ARENA_TELEPORT_MSGTITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_PVE_ARENA_TELEPORT_MSGOUT"),
      functionYes = ToClient_RequestLeaveImmortalHell,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_PVE_ARENA_TELEPORT_MSGTITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_PVE_ARENA_TELEPORT_MSGDESC"),
      functionYes = ToClient_RequestJoinImmortalHell,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
registerEvent("FromClient_luaLoadComplete", "PaGlobal_Menu_Renew_Init")
