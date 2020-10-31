function PaGlobal_Menu_Remake:SetSubmenuHotKeyInfo()
  local _menuHotKeyTemp = {}
  _menuHotKeyTemp = {
    [1] = {
      hotKey = CppEnums.VirtualKeyCode.KeyCode_F12,
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_RECENTUSED"),
      subMenu = {},
      ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
      ddsGrid = {
        x1 = 173,
        y1 = 572,
        x2 = 228,
        y2 = 627
      },
      isContentOpen = nil
    },
    [2] = {
      hotKey = CppEnums.VirtualKeyCode.KeyCode_F1,
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_CATEGORY_1"),
      subMenu = {
        [1] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_HELP"),
          func = FGlobal_Panel_WebHelper_ShowToggle,
          isContentOpen = not PaGlobal_Menu_Remake._contentsGroup._isTestServer and not isGameTypeKR2(),
          index = 1,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 2,
            y1 = 457,
            x2 = 57,
            y2 = 512
          }
        },
        [2] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_PRODUCTION"),
          func = Panel_ProductNote_ShowToggle,
          isContentOpen = not PaGlobal_Menu_Remake._contentsGroup._isTestServer and _ContentsGroup_ProductNote,
          index = 2,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 344,
            y1 = 59,
            x2 = 399,
            y2 = 114
          }
        },
        [3] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_KEYBOARD_HELP"),
          func = FGlobal_KeyboardHelpShow,
          isContentOpen = true,
          index = 58,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 458,
            y1 = 173,
            x2 = 513,
            y2 = 228
          }
        },
        [4] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_LIFE_RANK"),
          func = PaGlobalFunc_Menu_All_LifeRanker_Open,
          isContentOpen = true,
          index = 46,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 458,
            y1 = 230,
            x2 = 513,
            y2 = 285
          }
        },
        [5] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_GUILD_RANK"),
          func = GuildRank_Web_Show,
          isContentOpen = not PaGlobal_Menu_Remake._contentsGroup._isTestServer and not isGameTypeKR2(),
          index = 47,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 173,
            y1 = 515,
            x2 = 228,
            y2 = 570
          }
        },
        [6] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_MONSTER_RANK"),
          func = FGlobal_MonsterRanking_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isMonsterRanking,
          index = 48,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 515,
            y1 = 401,
            x2 = 570,
            y2 = 456
          }
        },
        [7] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_VOLUNTEER_RANK"),
          func = PaGlobal_VolunteerRankWeb_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isBattleFieldVolunteer,
          index = 49,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 344,
            y1 = 515,
            x2 = 399,
            y2 = 570
          }
        },
        [8] = {
          title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALTARRANKWEB_TITLE"),
          func = PaGlobal_AltarRankWeb_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isAltarRankOpen,
          index = 84,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 458,
            y1 = 572,
            x2 = 513,
            y2 = 627
          }
        },
        [9] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_COPYRIGHT"),
          func = PaGlobal_Copyright_ShowWindow,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isCopyright,
          index = 29,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 572,
            y1 = 2,
            x2 = 627,
            y2 = 57
          }
        },
        [10] = {
          title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_KEYGUIDE_TITLE"),
          func = PaGlobalFunc_KeyGuidWindow_Open,
          isContentOpen = _ContentsGroup_RenewUI,
          index = 30,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_01.dds",
          ddsGrid = {
            x1 = 226,
            y1 = 2,
            x2 = 281,
            y2 = 57
          }
        }
      },
      ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
      ddsGrid = {
        x1 = 2,
        y1 = 457,
        x2 = 57,
        y2 = 512
      },
      isContentOpen = nil
    },
    [3] = {
      hotKey = CppEnums.VirtualKeyCode.KeyCode_F2,
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_CATEGORY_2"),
      subMenu = {
        [1] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_MYINFO"),
          func = HandleEventLUp_MenuRemake_Myinfo,
          isContentOpen = true,
          index = 7,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 59,
            y1 = 59,
            x2 = 114,
            y2 = 114
          }
        },
        [2] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_SKILL"),
          func = HandleEventLUp_MenuRemake_Skill,
          isContentOpen = ToClient_IsGrowStepOpen(__eGrowStep_skillWindow),
          index = 9,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 173,
            y1 = 2,
            x2 = 228,
            y2 = 57
          }
        },
        [3] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_INVENTORY"),
          func = HandleEventLUp_MenuRemake_Inventory,
          isContentOpen = true,
          index = 8,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 401,
            y1 = 59,
            x2 = 456,
            y2 = 114
          }
        },
        [4] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_MENTAL_KNOWLEDGE"),
          func = HandleEventLUp_MenuRemake_MentalKnowledge,
          isContentOpen = true,
          index = 24,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 173,
            y1 = 230,
            x2 = 228,
            y2 = 285
          }
        },
        [5] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_SELECT_CHARACTER"),
          func = Panel_GameExit_ClickSelectCharacter,
          isContentOpen = isGameTypeEnglish() or isGameServiceTypeDev(),
          index = 12,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 401,
            y1 = 2,
            x2 = 456,
            y2 = 57
          }
        },
        [6] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_BEAUTY"),
          func = HandleEventLUp_MenuRemake_Beauty,
          isContentOpen = CppEnums.ContentsServiceType.eContentsServiceType_Commercial == getContentsServiceType() and not PaGlobal_Menu_Remake._contentsGroup._isTestServer,
          index = 63,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 344,
            y1 = 116,
            x2 = 399,
            y2 = 171
          }
        },
        [7] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_DYE"),
          func = HandleEventLUp_MenuRemake_Dyeing,
          isContentOpen = true,
          index = 64,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 287,
            y1 = 401,
            x2 = 342,
            y2 = 456
          }
        },
        [8] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_COLORMIX"),
          func = PaGlobalFunc_Menu_All_ColorMix_Open,
          isContentOpen = true,
          index = 67,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 515,
            y1 = 287,
            x2 = 570,
            y2 = 342
          }
        },
        [9] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_ESCAPE"),
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          func = HandleEventLUp_MenuRemake_Escape,
          isContentOpen = nil,
          ddsGrid = {
            x1 = 572,
            y1 = 59,
            x2 = 627,
            y2 = 114
          },
          index = 76,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false
        },
        [10] = {
          title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERTAG_TITLE"),
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          func = PaGlobalFunc_CharacterTag_All_Open,
          isContentOpen = _ContentsGroup_NewUI_CharacterTag_All and _ContentsGroup_CharacterTag and _ContentsGroup_UsePadSnapping,
          ddsGrid = {
            x1 = 401,
            y1 = 2,
            x2 = 456,
            y2 = 57
          },
          index = 90,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false
        }
      },
      ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
      ddsGrid = {
        x1 = 59,
        y1 = 59,
        x2 = 114,
        y2 = 114
      },
      isContentOpen = nil
    },
    [4] = {
      hotKey = CppEnums.VirtualKeyCode.KeyCode_F3,
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_CATEGORY_5"),
      subMenu = {
        [1] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_CHALLENGE"),
          func = HandleEventLUp_MenuRemake_Present,
          isContentOpen = true,
          index = 26,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 515,
            y1 = 116,
            x2 = 570,
            y2 = 171
          }
        },
        [2] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_TOTAL_REWARD"),
          func = PaGlobalFunc_Menu_All_TotalReward_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isTotalReward,
          index = 27,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 515,
            y1 = 173,
            x2 = 570,
            y2 = 228
          }
        },
        [3] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_DAILYSTAMP"),
          func = PaGlobalFunc_Menu_All_DailyStamp_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._joinCheckOpen,
          isConditionOpen = not PaGlobal_Menu_Remake._contentsGroup._isTestServer and PaGlobal_Menu_Remake._conditionGroup._isDailyStampOpen,
          index = 31,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 59,
            y1 = 116,
            x2 = 114,
            y2 = 171
          }
        },
        [4] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_BLACKSPIRIT_ADVANTURE"),
          func = FGlobal_BlackSpiritAdventure_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isBlackSpiritAdventure and not PaGlobal_Menu_Remake._contentsGroup._isTestServer,
          index = 28,
          isNew = false,
          isHot = false,
          isEvent = true,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 116,
            y1 = 457,
            x2 = 171,
            y2 = 512
          }
        },
        [5] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_MAIL"),
          func = HandleEventUp_MenuRemake_Mail,
          isContentOpen = true,
          isNew = false,
          isHot = false,
          index = 73,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 2,
            y1 = 173,
            x2 = 57,
            y2 = 228
          }
        }
      },
      isContentOpen = nil,
      ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
      ddsGrid = {
        x1 = 515,
        y1 = 116,
        x2 = 570,
        y2 = 171
      }
    },
    [5] = {
      hotKey = CppEnums.VirtualKeyCode.KeyCode_F4,
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_CATEGORY_3"),
      subMenu = {
        [1] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_PEARLSHOP"),
          func = HandleEventLUp_MenuRemake_CashShop,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isPearlOpen,
          index = 14,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 515,
            y1 = 458,
            x2 = 570,
            y2 = 513
          }
        },
        [2] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_ITEMMARKET"),
          func = HandleEventLUp_MenuRemake_Market,
          isContentOpen = not _ContentsGroup_RenewUI_ItemMarketPlace_Only,
          index = 15,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 287,
            y1 = 2,
            x2 = 342,
            y2 = 57
          }
        },
        [3] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_MARKETPLACE"),
          func = PaGlobalFunc_Menu_All_MarketPlace_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isMarketPlaceOpen and false == isGameTypeKR2(),
          index = 68,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 287,
            y1 = 2,
            x2 = 342,
            y2 = 57
          }
        },
        [4] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_MASTERPIECT_AUCTION"),
          func = PaGlobalFunc_Menu_All_Masterpiece_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isMasterpieceOpen,
          index = 18,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 572,
            y1 = 116,
            x2 = 627,
            y2 = 171
          }
        }
      },
      ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
      ddsGrid = {
        x1 = 515,
        y1 = 458,
        x2 = 570,
        y2 = 513
      },
      isContentOpen = nil
    },
    [6] = {
      hotKey = CppEnums.VirtualKeyCode.KeyCode_F5,
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_CATEGORY_4"),
      subMenu = {
        [1] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_BLACKSPIRIT"),
          func = HandleEventLUp_MenuRemake_BlackSpirit,
          isContentOpen = true,
          index = 22,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 515,
            y1 = 230,
            x2 = 570,
            y2 = 285
          }
        },
        [2] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_ACHIEVEMENT_BOOKSHELF"),
          func = PaGlobalFunc_Menu_All_Achievement_All_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isAchievementBookshelfOpen and ToClient_IsGrowStepOpen(__eGrowStep_oldBook),
          index = 16,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 401,
            y1 = 515,
            x2 = 456,
            y2 = 570
          }
        },
        [3] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_WORLDMAP"),
          func = HandleEventLUp_MenuRemake_WorldMap,
          isContentOpen = true,
          index = 20,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 116,
            y1 = 2,
            x2 = 171,
            y2 = 51
          }
        },
        [4] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_DROPITEM"),
          func = PaGlobalFunc_Menu_All_DropItem_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isDropItemOpen,
          index = 3,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 2,
            y1 = 344,
            x2 = 57,
            y2 = 399
          }
        },
        [5] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_BOSS_ALERT"),
          func = PaGlobalFunc_Menu_All_BossAlert_Setting_Open,
          isConditionOpen = PaGlobal_Menu_Remake._conditionGroup._isBossAlert,
          isContentOpen = _ContetnsGroup_BossAlert,
          index = 4,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 458,
            y1 = 401,
            x2 = 513,
            y2 = 456
          }
        },
        [6] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_QUEST"),
          func = HandleEventLUp_MenuRemake_QuestHistory,
          isConditionOpen = PaGlobal_Menu_Remake._conditionGroup._isQuestOpen,
          isContentOpen = true,
          index = 23,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 59,
            y1 = 2,
            x2 = 114,
            y2 = 57
          }
        },
        [7] = {
          title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FARMINGTIMER_TITLE"),
          func = HandleEventLUp_MenuRemake_FarmingList,
          isContentOpen = _ContentsGroup_FarmingList,
          index = 38,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_01.dds",
          ddsGrid = {
            x1 = 114,
            y1 = 2,
            x2 = 169,
            y2 = 57
          }
        },
        [8] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_PERSONAL_MONSTER"),
          func = HandleEventLUp_PersonalMonster_All_Open,
          isContentOpen = _ContentsGroup_NodeBoss,
          index = 25,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 515,
            y1 = 59,
            x2 = 570,
            y2 = 114
          }
        }
      },
      ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
      ddsGrid = {
        x1 = 116,
        y1 = 2,
        x2 = 171,
        y2 = 57
      },
      isContentOpen = nil
    },
    [7] = {
      hotKey = CppEnums.VirtualKeyCode.KeyCode_F6,
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_CATEGORY_6"),
      subMenu = {
        [1] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_FISH_ENCYCLOPEDIA"),
          func = PaGlobalFunc_Menu_All_FishEncyclopedia_Open,
          isContentOpen = true,
          index = 5,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 401,
            y1 = 287,
            x2 = 456,
            y2 = 342
          }
        },
        [2] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_TRADEMARKET"),
          func = HandleEventLUp_MenuRemake_TradeEvent,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isTradeEventOpen and ToClient_IsGrowStepOpen(__eGrowStep_trade),
          index = 6,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 401,
            y1 = 173,
            x2 = 456,
            y2 = 228
          }
        },
        [3] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_MANUFACTURE"),
          func = HandleEventLUp_MenuRemake_Manufacture,
          isContentOpen = ToClient_IsGrowStepOpen(__eGrowStep_manufacture),
          index = 34,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 116,
            y1 = 59,
            x2 = 171,
            y2 = 114
          }
        },
        [4] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_WORKER"),
          func = PaGlobalFunc_Menu_All_WorkerManager_Open,
          isContentOpen = ToClient_IsGrowStepOpen(__eGrowStep_worker),
          index = 35,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 2,
            y1 = 230,
            x2 = 57,
            y2 = 285
          }
        },
        [5] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_MYHOUSE"),
          func = FGlobal_HousingList_Open,
          isContentOpen = ToClient_IsGrowStepOpen(__eGrowStep_worker),
          index = 36,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 344,
            y1 = 2,
            x2 = 399,
            y2 = 57
          }
        },
        [6] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_GARDEN_FIELD"),
          func = FGlobal_HarvestList_Open,
          isContentOpen = true,
          index = 37,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 287,
            y1 = 287,
            x2 = 342,
            y2 = 342
          }
        },
        [7] = {
          title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALCHEMYSTONE_TITLE"),
          func = PaGlobalFunc_Menu_All_AlchemyStone_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isAlchemyStoneEnble,
          index = 79,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 457,
            y1 = 2,
            x2 = 512,
            y2 = 57
          }
        },
        [8] = {
          title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INVENTORY_TOTEMBUTTON"),
          func = FGlobal_AlchemyFigureHead_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isAlchemyFigureHeadEnble,
          index = 80,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 458,
            y1 = 515,
            x2 = 513,
            y2 = 570
          }
        },
        [9] = {
          title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_TITLE"),
          func = HandlerEventLUp_SailorManager_All_OpenByESCMenu,
          isConditionOpen = PaGlobal_Menu_Remake._conditionGroup._isSailerOpen,
          isContentOpen = PaGlobal_Menu_Remake._isOceanCurrentOpen,
          index = 85,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 287,
            y1 = 572,
            x2 = 342,
            y2 = 627
          }
        },
        [10] = {
          title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BARTER_TITLE"),
          func = PaGlobal_BarterInfoSearch_Open,
          isContentOpen = PaGlobal_Menu_Remake._isOceanCurrentOpen,
          index = 86,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 230,
            y1 = 572,
            x2 = 285,
            y2 = 627
          }
        }
      },
      ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
      ddsGrid = {
        x1 = 2,
        y1 = 230,
        x2 = 57,
        y2 = 285
      },
      isContentOpen = nil
    },
    [8] = {
      hotKey = CppEnums.VirtualKeyCode.KeyCode_F7,
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_CATEGORY_7"),
      subMenu = {
        [1] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_LOCALWAR"),
          func = HandleEventLUp_MenuRemake_Localwar,
          isConditionOpen = PaGlobal_Menu_Remake._conditionGroup._isLocalwarOpen,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isLocalwarOpen and ToClient_IsGrowStepOpen(__eGrowStep_localWar),
          index = 39,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 401,
            y1 = 344,
            x2 = 456,
            y2 = 399
          }
        },
        [2] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_FREEFIGHT"),
          func = HandleEventLUp_MenuRemake_FreeFight,
          isConditionOpen = PaGlobal_Menu_Remake._conditionGroup._isFreeFight,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isFreeFight and ToClient_IsGrowStepOpen(__eGrowStep_freeFight),
          index = 21,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 230,
            y1 = 515,
            x2 = 285,
            y2 = 570
          }
        },
        [3] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_PERSONAL_BATTLE"),
          func = HandleEventLUp_MenuRemake_Personalbattle,
          isConditionOpen = PaGlobal_Menu_Remake._conditionGroup._isTeamDuelOpen,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isTeamDuelOpen and ToClient_IsGrowStepOpen(__eGrowStep_teamDuel),
          index = 41,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 287,
            y1 = 515,
            x2 = 342,
            y2 = 570
          }
        },
        [4] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_WAVE"),
          func = HandleEventLUp_MenuRemake_Wave,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isSavageOpen and ToClient_IsGrowStepOpen(__eGrowStep_savageDefence),
          index = 42,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 344,
            y1 = 344,
            x2 = 399,
            y2 = 399
          }
        },
        [5] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_COMPETITION"),
          func = HandleEventLUp_MenuRemake_Competitiongame,
          isConditionOpen = PaGlobal_Menu_Remake._conditionGroup._isContentsArsha,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isContentsArsha and ToClient_IsGrowStepOpen(__eGrowStep_arsha),
          index = 43,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 344,
            y1 = 230,
            x2 = 399,
            y2 = 285
          }
        },
        [6] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_SIEGE"),
          func = HandleEventLUp_MenuRemake_Siege,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isSiegeEnable and ToClient_IsGrowStepOpen(__eGrowStep_guildWarInfo),
          index = 44,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 116,
            y1 = 344,
            x2 = 171,
            y2 = 399
          }
        },
        [7] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BLOODALTAR_TITLE"),
          func = HandleEventLUp_MenuRemake_InfinityDefence,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isInfinityDefence,
          index = 83,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "combine/icon/combine_title_icon_00.dds",
          ddsGrid = {
            x1 = 515,
            y1 = 572,
            x2 = 570,
            y2 = 627
          }
        },
        [8] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_ARSHA_APPLYWEB"),
          func = HandleEventLUp_MenuRemake_ArshaApplyWeb,
          isContentOpen = _ContentsGroup_Arsha_ApplyWeb,
          index = 92,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "combine/icon/combine_title_icon_01.dds",
          ddsGrid = {
            x1 = 2,
            y1 = 2,
            x2 = 57,
            y2 = 57
          }
        },
        [9] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_THORNCASTLE_ESC_TITLE"),
          func = HandleEventLUp_MenuRemake_OthilitaDungeon,
          isContentOpen = _ContentsGroup_OthilitaDungeon,
          index = 94,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "combine/icon/combine_title_icon_01.dds",
          ddsGrid = {
            x1 = 2,
            y1 = 2,
            x2 = 57,
            y2 = 57
          }
        },
        [10] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_PVE_ARENA_TELEPORT_MSGTITLE"),
          func = HandleEventLUp_MenuRemake_ImmortalHell,
          isContentOpen = _ContentsGroup_isOepnImmortalHell or _ContentsGroup_isOpenImmortalHellForConsole,
          index = 95,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "combine/icon/combine_title_icon_01.dds",
          ddsGrid = {
            x1 = 226,
            y1 = 58,
            x2 = 281,
            y2 = 113
          }
        }
      },
      ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
      ddsGrid = {
        x1 = 401,
        y1 = 344,
        x2 = 456,
        y2 = 399
      },
      isContentOpen = nil
    },
    [9] = {
      hotKey = CppEnums.VirtualKeyCode.KeyCode_F8,
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_CATEGORY_8"),
      subMenu = {
        [1] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_FINDNPC"),
          func = PaGlobalFunc_Menu_All_NpcFind_Open,
          isContentOpen = true,
          index = 97,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 2,
            y1 = 401,
            x2 = 57,
            y2 = 456
          }
        },
        [2] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_MEMO"),
          func = PaGlobalFunc_Menu_All_Memo_Main_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isMemoOpen,
          index = 55,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 344,
            y1 = 401,
            x2 = 399,
            y2 = 456
          }
        },
        [3] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_PET"),
          func = PaGlobalFunc_Menu_All_PetList_Open,
          isConditionOpen = PaGlobal_Menu_Remake._conditionGroup._isPetOpen,
          isContentOpen = true,
          index = 10,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 116,
            y1 = 230,
            x2 = 171,
            y2 = 285
          }
        },
        [4] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_FAIRY"),
          func = HandleEventLUp_MenuRemake_Fairy,
          isConditionOpen = PaGlobal_Menu_Remake._conditionGroup._isFairyOpen,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isFairyOpen,
          index = 11,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 287,
            y1 = 344,
            x2 = 342,
            y2 = 399
          }
        },
        [5] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_MAID"),
          func = PaGlobalFunc_Menu_All_MaidList_Open,
          isConditionOpen = PaGlobal_Menu_Remake._conditionGroup._isMaidOpen,
          isContentOpen = _ContentsGroup_Maid,
          index = 17,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 59,
            y1 = 344,
            x2 = 114,
            y2 = 399
          }
        },
        [6] = {
          title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CAMP_TITLE"),
          func = HandleEventLUp_MenuRemake_Camp,
          isContentOpen = _ContentsGroup_isCamp,
          isConditionOpen = PaGlobal_Menu_Remake._conditionGroup._isCampOpen,
          index = 81,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 230,
            y1 = 344,
            x2 = 285,
            y2 = 399
          }
        }
      },
      ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
      ddsGrid = {
        x1 = 2,
        y1 = 401,
        x2 = 57,
        y2 = 456
      },
      isContentOpen = nil
    },
    [10] = {
      hotKey = CppEnums.VirtualKeyCode.KeyCode_F9,
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_CATEGORY_9"),
      subMenu = {
        [1] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_GUILD"),
          func = PaGlobalFunc_Menu_All_Guild_Open,
          isContentOpen = true,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 51,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 2,
            y1 = 287,
            x2 = 57,
            y2 = 342
          }
        },
        [2] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_FRIEND"),
          func = function()
            GlobalKeyBinder_MouseKeyMap(__eUiInputType_FriendList)
          end,
          isContentOpen = true,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 52,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 287,
            y1 = 173,
            x2 = 342,
            y2 = 228
          }
        },
        [3] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_FIND_PARTY"),
          func = PaGlobalFunc_Menu_All_PartyList_Show,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._partyListOpen,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 53,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 230,
            y1 = 116,
            x2 = 285,
            y2 = 171
          }
        },
        [4] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_SOCIAL_ACTION"),
          func = FGlobal_SocialAction_ShowToggle,
          isContentOpen = not _ContentsGroup_RenewUI,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 13,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 458,
            y1 = 458,
            x2 = 513,
            y2 = 513
          }
        },
        [5] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_BEAUTY_ALBUM"),
          func = HandleEventLUp_MenuRemake_BeautyAlbum,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._webAlbumOpen and not PaGlobal_Menu_Remake._contentsGroup._isTestServer,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 65,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 173,
            y1 = 457,
            x2 = 228,
            y2 = 512
          }
        },
        [6] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_CHATTING_FILTER"),
          func = FGlobal_ChattingFilterList_Open,
          isContentOpen = true,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 54,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 458,
            y1 = 344,
            x2 = 513,
            y2 = 399
          }
        },
        [7] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_TWITCH"),
          func = function()
            PaGlobal_Twitch:ShowWindow()
          end,
          isContentOpen = not PaGlobal_Menu_Remake._contentsGroup._isTestServer and false == isGameTypeKR2(),
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 56,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 116,
            y1 = 515,
            x2 = 171,
            y2 = 570
          }
        },
        [8] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_EXTRACTIONGAME"),
          func = PaGlobal_Steam_Redemption,
          isContentOpen = _ContentsGroup_SteamOpen,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 32,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 572,
            y1 = 173,
            x2 = 627,
            y2 = 228
          }
        },
        [9] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_EXPIRIENCE_WIKI"),
          func = PaGlobal_ExpirienceWiki_Open,
          isContentOpen = _ContentsGroup_ExpirienceWiki,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 77,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 458,
            y1 = 287,
            x2 = 513,
            y2 = 342
          }
        },
        [10] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_HOMEPAGE_TITLE2"),
          func = PaGlobal_Homepage_Open,
          isContentOpen = false == isGameTypeJapan(),
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 72,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 116,
            y1 = 572,
            x2 = 171,
            y2 = 627
          }
        },
        [11] = {
          title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SCREENSHOTALBUM_TITLE"),
          func = ScreenshotAlbum_Open,
          isContentOpen = ToClient_IsContentsGroupOpen("213"),
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 19,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 230,
            y1 = 457,
            x2 = 285,
            y2 = 512
          }
        },
        [12] = {
          title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_COMPOSITION_NAME"),
          func = PaGlobal_MusicBoard_All_Open,
          isContentOpen = _ContentsGroup_InstrumentPerformance,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = true,
          index = 78,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 401,
            y1 = 116,
            x2 = 456,
            y2 = 171
          }
        },
        [13] = {
          title = PAGetString(Defines.StringSheet_GAME, "CHATTING_CHANNEL"),
          func = PaGlobalFunc_ChannelChat_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isChannelChatOpen,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 87,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_01.dds",
          ddsGrid = {
            x1 = 58,
            y1 = 2,
            x2 = 113,
            y2 = 57
          }
        },
        [14] = {
          title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EXPIRIENCEWIKI_TITLE"),
          func = PaGlobal_ExpirienceWiki_All_Open,
          isContentOpen = _ContentsGroup_ExpirienceWiki_All and _ContentsGroup_ExpirienceWiki_KorVersion,
          isNew = not isGameTypeKorea(),
          isHot = isGameTypeKorea(),
          isEvent = false,
          isUpdate = false,
          index = 88,
          ddsUrl = "combine/icon/combine_title_icon_00.dds",
          ddsGrid = {
            x1 = 458,
            y1 = 287,
            x2 = 513,
            y2 = 342
          }
        },
        [15] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_ESC_EVENTMOVIE_JP"),
          func = PaGlobalFunc_MovieJapnaGlay25_Open,
          isContentOpen = isGameTypeJapan(),
          isNew = false,
          isHot = true,
          isEvent = false,
          isUpdate = false,
          index = 89,
          ddsUrl = "combine/Icon/Combine_Title_Icon_01.dds",
          ddsGrid = {
            x1 = 58,
            y1 = 58,
            x2 = 113,
            y2 = 113
          }
        }
      },
      ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
      ddsGrid = {
        x1 = 287,
        y1 = 173,
        x2 = 342,
        y2 = 228
      },
      isContentOpen = nil
    },
    [11] = {
      hotKey = CppEnums.VirtualKeyCode.KeyCode_F10,
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_CATEGORY_10"),
      subMenu = {
        [1] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_OPTION"),
          func = showGameOption,
          isContentOpen = true,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 57,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 59,
            y1 = 230,
            x2 = 114,
            y2 = 285
          }
        },
        [2] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_INTERFACE_EDIT"),
          func = FGlobal_UiSet_Open,
          isContentOpen = true,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 59,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 515,
            y1 = 2,
            x2 = 570,
            y2 = 57
          }
        },
        [3] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_SHORTCUT"),
          func = PaGlobalFunc_Menu_All_ButtonShorcurs_Open,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isButtonShortCut and false == _ContentsGroup_UsePadSnapping,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 60,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 287,
            y1 = 457,
            x2 = 342,
            y2 = 512
          }
        },
        [4] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_LANGUAGE"),
          func = FGlobal_GameOptionOpen,
          isContentOpen = isGameTypeEnglish() or isGameServiceTypeDev(),
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 61,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 572,
            y1 = 230,
            x2 = 627,
            y2 = 285
          }
        },
        [5] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_SAVE_SETTING"),
          func = PaGlobal_Panel_SaveSetting_Show,
          isContentOpen = not PaGlobal_Menu_Remake._contentsGroup._isTestServer,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 401,
            y1 = 401,
            x2 = 456,
            y2 = 456
          },
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 62
        },
        [6] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_GAMEEND"),
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          func = PaGlobalFunc_Menu_All_GameExit_Open,
          isContentOpen = nil,
          ddsGrid = {
            x1 = 2,
            y1 = 116,
            x2 = 57,
            y2 = 171
          },
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 74
        },
        [7] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_CHANGESERVER"),
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          func = PaGlobalFunc_Menu_All_ServerSelect_Open,
          isContentOpen = nil,
          ddsGrid = {
            x1 = 287,
            y1 = 230,
            x2 = 342,
            y2 = 285
          },
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 75
        },
        [8] = {
          title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUICKMENU_RINGMENUSETTING"),
          ddsUrl = "Combine/Icon/Combine_Title_Icon_01.dds",
          func = PaGlobalFunc_Menu_All_RingMenuSetting_Open,
          isContentOpen = _ContentsGroup_UsePadSnapping,
          ddsGrid = {
            x1 = 282,
            y1 = 2,
            x2 = 337,
            y2 = 57
          },
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 82
        }
      },
      ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
      ddsGrid = {
        x1 = 59,
        y1 = 230,
        x2 = 114,
        y2 = 285
      },
      isContentOpen = nil
    },
    [12] = {
      hotKey = CppEnums.VirtualKeyCode.KeyCode_F11,
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_CATEGORY_11"),
      subMenu = {
        [1] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_NOTICE"),
          func = HandleEventLUp_MenuRemake_Notice,
          isContentOpen = isGameTypeEnglish() and not PaGlobal_Menu_Remake._contentsGroup._isTestServer,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 40,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 457,
            y1 = 116,
            x2 = 512,
            y2 = 171
          }
        },
        [2] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_UPDATE"),
          func = HandleEventLUp_MenuRemake_Update,
          isContentOpen = (isGameTypeKorea() or isGameTypeTaiwan() or isGameTypeTR() or isGameTypeID() or isGameTypeTH() or isGameServiceTypeDev() or isGameTypeRussia()) and not PaGlobal_Menu_Remake._contentsGroup._isTestServer,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 69,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 59,
            y1 = 287,
            x2 = 114,
            y2 = 342
          }
        },
        [3] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_EVENT"),
          func = HandleEventLUp_MenuRemake_Event,
          isContentOpen = not isGameTypeKR2() and not isGameTypeEnglish() and not PaGlobal_Menu_Remake._contentsGroup._isTestServer,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 70,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 173,
            y1 = 401,
            x2 = 228,
            y2 = 456
          }
        },
        [4] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_KNOWN_ISSUE"),
          func = HandleEventLUp_MenuRemake_KnownIssue,
          isContentOpen = (isGameTypeKorea() or isGameTypeTaiwan() or isGameTypeTH() or isGameTypeID() or isGameTypeRussia() or isGameTypeTR()) and not PaGlobal_Menu_Remake._contentsGroup._isTestServer,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 71,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 515,
            y1 = 344,
            x2 = 570,
            y2 = 399
          }
        },
        [5] = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_MENU_BLACKDESERT_LAB"),
          func = HandleEventLUp_MenuRemake_BlackDesertLab,
          isContentOpen = PaGlobal_Menu_Remake._contentsGroup._isBlackDesertLab,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 96,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 59,
            y1 = 457,
            x2 = 114,
            y2 = 512
          }
        },
        [6] = {
          title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_REPORT_BUTTON"),
          func = PaGloabl_ReportAll_Open,
          isContentOpen = _ContentsGroup_NegativeUserReport,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 50,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_00.dds",
          ddsGrid = {
            x1 = 401,
            y1 = 572,
            x2 = 456,
            y2 = 627
          }
        },
        [7] = {
          title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RESTOREITEM_RECOVERYITEM_TITLE"),
          func = PaGlobalFunc_Restore_All_Open,
          isContentOpen = ToClient_IsContentsGroupOpen("579"),
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 45,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_01.dds",
          ddsGrid = {
            x1 = 394,
            y1 = 2,
            x2 = 449,
            y2 = 57
          }
        },
        [8] = {
          title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MAIL_MAIN_BTN_QNA"),
          func = HandleEventLUp_Mail_All_QNA,
          isContentOpen = CppEnums.CountryType.JPN_REAL ~= getGameServiceType() and CppEnums.CountryType.JPN_ALPHA ~= getGameServiceType() and false == isGameTypeKR2(),
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 33,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_01.dds",
          ddsGrid = {
            x1 = 338,
            y1 = 2,
            x2 = 393,
            y2 = 57
          }
        },
        [9] = {
          title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COUPON_INWEB"),
          func = PaGlobalFunc_CouponCode_Open,
          isContentOpen = _ContentsGroup_CouponCode,
          isNew = false,
          isHot = false,
          isEvent = false,
          isUpdate = false,
          index = 93,
          ddsUrl = "Combine/Icon/Combine_Title_Icon_01.dds",
          ddsGrid = {
            x1 = 562,
            y1 = 2,
            x2 = 617,
            y2 = 57
          }
        }
      },
      ddsUrl = "Combine/Icon/Combine_Title_Icon_01.dds",
      ddsGrid = {
        x1 = 450,
        y1 = 2,
        x2 = 505,
        y2 = 57
      },
      isContentOpen = nil
    }
  }
  PaGlobal_Menu_Remake._menuHotKey = {}
  for i = 1, #_menuHotKeyTemp do
    PaGlobal_Menu_Remake._menuHotKey[i] = {}
    PaGlobal_Menu_Remake._menuHotKey[i].hotKey = _menuHotKeyTemp[i].hotKey
    PaGlobal_Menu_Remake._menuHotKey[i].title = _menuHotKeyTemp[i].title
    PaGlobal_Menu_Remake._menuHotKey[i].subMenu = {}
    PaGlobal_Menu_Remake._menuHotKey[i].ddsUrl = _menuHotKeyTemp[i].ddsUrl
    PaGlobal_Menu_Remake._menuHotKey[i].ddsGrid = _menuHotKeyTemp[i].ddsGrid
    PaGlobal_Menu_Remake._menuHotKey[i].isContentOpen = _menuHotKeyTemp[i].isContentOpen
    PaGlobal_Menu_Remake._menuHotKey[i].isNew = false
    PaGlobal_Menu_Remake._menuHotKey[i].isHot = false
    PaGlobal_Menu_Remake._menuHotKey[i].isEvent = false
    PaGlobal_Menu_Remake._menuHotKey[i].isUpdate = false
    local subViewCnt = 0
    local subIndex = 1
    for k, v in ipairs(_menuHotKeyTemp[i].subMenu) do
      if (nil == v.isContentOpen or true == v.isContentOpen) and nil ~= v.func then
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex] = {}
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].title = v.title
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].func = v.func
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].isContentOpen = v.isContentOpen
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].isConditionOpen = v.isConditionOpen
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].index = v.index
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].ddsUrl = v.ddsUrl
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].ddsGrid = v.ddsGrid
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].isNew = v.isNew
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].isHot = v.isHot
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].isEvent = v.isEvent
        PaGlobal_Menu_Remake._menuHotKey[i].subMenu[subIndex].isUpdate = v.isUpdate
        if v.isNew then
          PaGlobal_Menu_Remake._menuHotKey[i].isNew = true
        end
        if v.isHot then
          PaGlobal_Menu_Remake._menuHotKey[i].isHot = true
        end
        if v.isEvent then
          PaGlobal_Menu_Remake._menuHotKey[i].isEvent = true
        end
        if v.isUpdate then
          PaGlobal_Menu_Remake._menuHotKey[i].isUpdate = true
        end
        if v.isContentOpen then
          subViewCnt = subViewCnt + 1
        end
        subIndex = subIndex + 1
      end
    end
    if 0 == subViewCnt and true == isGameTypeKR2() then
      PaGlobal_Menu_Remake._menuHotKey[i].isContentOpen = false
    end
  end
end
function PaGlobal_Menu_Remake:setMenuGrid(isMode)
  if true == isMode then
    PaGlobal_Menu_Remake._headerGrid = {
      normal = {
        x1 = 370,
        y1 = 42,
        x2 = 410,
        y2 = 82
      },
      on = {
        x1 = 411,
        y1 = 42,
        x2 = 451,
        y2 = 82
      },
      ddsUrl = "Combine/Btn/Combine_Btn_00.dds"
    }
    PaGlobal_Menu_Remake._menuGrid = {
      normal = {
        x1 = 480,
        y1 = 409,
        x2 = 510,
        y2 = 439
      },
      on = {
        x1 = 480,
        y1 = 440,
        x2 = 510,
        y2 = 470
      },
      click = {
        x1 = 480,
        y1 = 471,
        x2 = 510,
        y2 = 501
      },
      ddsUrl = "Combine/Frame/Combine_Frame_00.dds"
    }
    PaGlobal_Menu_Remake._subMenuGrid = {
      normal = {
        x1 = 460,
        y1 = 154,
        x2 = 490,
        y2 = 184
      },
      on = {
        x1 = 480,
        y1 = 440,
        x2 = 510,
        y2 = 470
      },
      ddsUrl = "Combine/Frame/Combine_Frame_00.dds"
    }
  else
    PaGlobal_Menu_Remake._headerGrid = {
      normal = {
        x1 = 370,
        y1 = 42,
        x2 = 410,
        y2 = 82
      },
      on = {
        x1 = 411,
        y1 = 42,
        x2 = 451,
        y2 = 82
      },
      ddsUrl = "Combine/Btn/Combine_Btn_00.dds"
    }
    PaGlobal_Menu_Remake._menuGrid = {
      normal = {
        x1 = 480,
        y1 = 409,
        x2 = 510,
        y2 = 439
      },
      on = {
        x1 = 480,
        y1 = 440,
        x2 = 510,
        y2 = 470
      },
      click = {
        x1 = 480,
        y1 = 471,
        x2 = 510,
        y2 = 501
      },
      ddsUrl = "Combine/Frame/Combine_Frame_00.dds"
    }
    PaGlobal_Menu_Remake._subMenuGrid = {
      normal = {
        x1 = 460,
        y1 = 154,
        x2 = 490,
        y2 = 184
      },
      on = {
        x1 = 480,
        y1 = 440,
        x2 = 510,
        y2 = 470
      },
      ddsUrl = "Combine/Frame/Combine_Frame_00.dds"
    }
  end
end
function PaGlobal_Menu_Remake:setMenuOpenWayBtn()
  if 0 == ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eMenuOpenWay) then
    local textureDDS = PaGlobal_Menu_Remake.DEFAULT_MENU_DDS
    PaGlobal_Menu_Remake._ui.btn_openway:ChangeTextureInfoName(textureDDS)
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Menu_Remake._ui.btn_openway, 23, 57, 43, 78)
    PaGlobal_Menu_Remake._ui.btn_openway:getBaseTexture():setUV(x1, y1, x2, y2)
    PaGlobal_Menu_Remake._ui.btn_openway:setRenderTexture(PaGlobal_Menu_Remake._ui.btn_openway:getBaseTexture())
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Menu_Remake._ui.btn_openway, 23, 79, 43, 100)
    PaGlobal_Menu_Remake._ui.btn_openway:getOnTexture():setUV(x1, y1, x2, y2)
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Menu_Remake._ui.btn_openway, 23, 101, 43, 122)
    PaGlobal_Menu_Remake._ui.btn_openway:getClickTexture():setUV(x1, y1, x2, y2)
  else
    local textureDDS = PaGlobal_Menu_Remake.DEFAULT_MENU_DDS
    PaGlobal_Menu_Remake._ui.btn_openway:ChangeTextureInfoName(textureDDS)
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Menu_Remake._ui.btn_openway, 44, 57, 64, 78)
    PaGlobal_Menu_Remake._ui.btn_openway:getBaseTexture():setUV(x1, y1, x2, y2)
    PaGlobal_Menu_Remake._ui.btn_openway:setRenderTexture(PaGlobal_Menu_Remake._ui.btn_openway:getBaseTexture())
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Menu_Remake._ui.btn_openway, 44, 79, 64, 100)
    PaGlobal_Menu_Remake._ui.btn_openway:getOnTexture():setUV(x1, y1, x2, y2)
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Menu_Remake._ui.btn_openway, 44, 101, 64, 122)
    PaGlobal_Menu_Remake._ui.btn_openway:getClickTexture():setUV(x1, y1, x2, y2)
  end
  PaGlobal_Menu_Remake:hideTooltip()
end
function PaGlobalFunc_Menu_All_PartyList_Show()
  if true == ToClient_IsInstanceRandomMatching() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_RANDOMMATCH_FAILACK"))
    return
  end
  if true == _ContentsGroup_NewUI_PartyFind_All then
    PaGlobalFunc_PartyList_All_Open()
  else
    FGlobal_PartyList_ShowToggle()
  end
end
function PaGlobalFunc_Menu_All_MaidList_Open()
  if true == _ContentsGroup_NewUI_Maid_All then
    PaGlobalFunc_MaidList_All_Open()
  else
    MaidList_Open()
  end
end
function PaGlobalFunc_Menu_All_DailyStamp_Open()
  if true == _ContentsGroup_NewUI_DailyStamp_All then
    PaGlobalFunc_DailyStamp_All_Open()
  else
    DailyStamp_ShowToggle()
  end
end
function PaGlobalFunc_Menu_All_WorkerManager_Open()
  if true == _ContentsGroup_NewUI_WorkerManager_All then
    PaGlobalFunc_WorkerManager_All_ShowToggle()
  else
    FGlobal_WorkerManger_ShowToggle()
  end
end
function PaGlobalFunc_Menu_All_Guild_Open()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_Guild)
end
function PaGlobalFunc_Menu_All_LifeRanker_Open()
  if false == _ContentsGroup_NewUI_LifeRanking_All then
    FGlobal_LifeRanking_Open()
  else
    PaGlobal_LifeRanking_Open_All()
  end
end
function PaGlobalFunc_Menu_All_Masterpiece_Open()
  if false == _ContentsGroup_NewUI_Masterpiece_Auction_All then
    FGlobal_MasterpieceAuction_OpenAuctionItemNotNpc()
  else
    PaGlobal_Masterpiece_Auction_All_ESCOpen()
  end
end
function PaGlobalFunc_Menu_All_BossAlert_Setting_Open()
  if false == _ContentsGroup_NewUI_BossAlert_SettingV2_All then
    PaGlobal_BossAlertSet_Show()
  else
    PaGlobal_BossAlert_SettingV2_All_Open()
  end
end
function PaGlobalFunc_Menu_All_FishEncyclopedia_Open()
  if false == _ContentsGroup_NewUI_FishEncyclopedia_All then
    FGlobal_FishEncyclopedia_Open()
  else
    PaGlobalFunc_FishEncyclopedia_All_Open()
  end
end
function PaGlobalFunc_Menu_All_DropItem_Open()
  if false == _ContentsGroup_NewUI_DropItem_All then
    PaGlobal_WorldDropItem:Open()
  else
    PaGlobalFunc_DropItem_All_Open()
  end
end
function PaGlobalFunc_Menu_All_ButtonShorcurs_Open()
  if true == _ContentsGroup_NewUI_ButtonShortcuts_All then
    PaGlobalFunc_ButtonShorcuts_All_Open()
  else
    FGlobal_ButtonShortcuts_Open()
  end
end
function PaGlobalFunc_Menu_All_GameExit_Open()
  if true == _ContentsGroup_NewUI_GameExit then
    PaGlobal_GameExit_All_ShowToggle(false)
  else
    GameExitShowToggle(false)
  end
end
function PaGlobalFunc_Menu_All_Memo_Main_Open()
  if false == _ContentsGroup_NewUI_Memo_All then
    PaGlobal_Memo:ListOpen()
  else
    PaGlobalFunc_Memo_Main_All_Open()
  end
end
function PaGlobalFunc_Menu_All_TotalReward_Open()
  if true == _ContentsGroup_NewUI_TotalReward_All then
    PaGlobal_TotalReward_All_Open()
  else
    PaGlobal_TotalReward_Open()
  end
end
function PaGlobalFunc_Menu_All_Achievement_All_Open()
  if true == _ContentsGroup_NewUI_Achievement_All then
    PaGlobalFunc_Achievement_BookShelf_All_Open()
  else
    PaGlobal_Achievement_BookShelf_Open()
  end
end
function PaGlobalFunc_Menu_All_AlchemyStone_Open()
  if true == _ContentsGroup_NewUI_AlchemyStone_All then
    PaGlobalFunc_AlchemyStone_All_Open()
  else
    FGlobal_AlchemyStone_Open()
  end
end
function PaGlobalFunc_Menu_All_RingMenuSetting_Open()
  FromClient_ConsoleQuickMenu_OpenCustomPage(2)
end
function PaGlobalFunc_Menu_All_MarketPlace_Open()
  if true == _ContentsGroup_RenewUI then
    PaGlobalFunc_MarketPlaceConsole_OpenByMenu()
  else
    PaGlobalFunc_MarketPlace_Open()
  end
end
function PaGlobalFunc_Menu_All_ServerSelect_Open()
  if true == _ContentsGroup_NewUI_ChannelSelect_All then
    PaGlobalFunc_ChannelSelect_All_Open()
  elseif true == _ContentsGroup_RenewUI then
    PaGlobalFunc_ServerSelect_Open()
  else
    FGlobal_ChannelSelect_Show()
  end
end
function PaGlobalFunc_Menu_All_PetList_Open()
  if true == _ContentsGroup_NewUI_Pet_All then
    PaGlobal_PetList_Toggle_All()
  else
    FGlobal_PetListNew_Toggle()
  end
end
function PaGlobalFunc_Menu_All_NpcFind_Open()
  if true == _ContentsGroup_NewUI_NpcNavi_All then
    PaGlobal_NpcNavi_All_ShowToggle()
  else
    NpcNavi_ShowToggle()
  end
end
function PaGlobalFunc_Menu_All_ColorMix_Open()
  if _ContentsGroup_NewUI_Dye_All then
    PaGlobal_ColorMix_All_Show()
  else
    Panel_ColorBalance_Show()
  end
end
function PaGlobalFunc_Menu_All_Othilita_Open()
  if true == _ContentsGroup_OthilitaDungeon then
  end
end
