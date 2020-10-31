PaGlobal_Achievement_BookShelf_All = {
  _ui = {
    stc_TopArea = nil,
    stc_CenterArea = nil,
    stc_LeftArea = nil,
    stc_RightArea = nil,
    stc_FamilyWidget = nil,
    stc_BtnClose = nil,
    stc_Chapter = nil,
    stc_ChapterSlot = nil,
    stc_ChapterTitle = nil,
    txt_FamilyStatIcon = nil,
    txt_LeftTitle = nil,
    txt_BookShelfDesc = nil,
    txt_SelectedBookName = nil,
    frame_BookShelf = nil,
    frame_BookShelfContent = nil,
    btn_BookArea = nil,
    btn_BookTitle = nil,
    btn_BookGroup = nil,
    stc_EmptyGroup_1 = nil,
    stc_EmptyGroup_1_object = nil,
    stc_EmptyGroup_2 = nil,
    stc_EmptyGroup_2_object = nil,
    stc_EmptyGroup_3 = nil,
    stc_EmptyGroup_3_object_1 = nil,
    stc_EmptyGroup_3_object_2 = nil,
    stc_EmptyGroup_4 = nil,
    stc_EmptyGroup_4_object_1 = nil,
    stc_EmptyGroup_4_object_2 = nil,
    btn_BookArea_bookImage = nil,
    list2_BookChapterList = nil,
    stc_KeyGuide = nil
  },
  _journalChapterCnt = 0,
  _journalGroupCnt = 0,
  _selectedJournalGroup = 1,
  _selectedJournalChapter = -1,
  _journalControlList = {},
  _chapterControlList = {},
  _initialize = false,
  _journalGroupIndexList = {},
  _CHAPTER_ICON_CNT = 5,
  _BOOK_AREA_CNT = 4,
  _BOOK_POS_X = 15,
  _MAX_CALLING_COUNT = 20,
  _BOOK_POS_Y = {
    [0] = 32,
    [1] = 175,
    [2] = 316,
    [3] = 456
  },
  _bookAreaTextureKeyGroup = {
    [1] = {
      _cnt = 13,
      _cntGroup = {
        [1] = 4,
        [2] = 7,
        [3] = 9,
        [4] = 10,
        [5] = 11,
        [6] = 12,
        [7] = 13
      },
      _textureGroupKey = {
        [1] = 1,
        [2] = 4,
        [3] = 5,
        [4] = 2,
        [5] = 3,
        [6] = 6,
        [7] = 7
      }
    },
    [2] = {
      _cnt = 9,
      _cntGroup = {
        [1] = 9
      },
      _textureGroupKey = {
        [1] = 2
      }
    },
    [3] = {
      _cnt = 5,
      _cntGroup = {
        [1] = 1,
        [2] = 2,
        [3] = 3,
        [4] = 5
      },
      _textureGroupKey = {
        [1] = 6,
        [2] = 2,
        [3] = 3,
        [4] = 7
      }
    },
    [4] = {
      _cnt = 10,
      _cntGroup = {
        [1] = 2,
        [2] = 4,
        [3] = 7,
        [4] = 10
      },
      _textureGroupKey = {
        [1] = 7,
        [2] = 5,
        [3] = 4,
        [4] = 2
      }
    },
    [5] = {
      _cnt = 10,
      _cntGroup = {
        [1] = 2,
        [2] = 4,
        [3] = 7,
        [4] = 10
      },
      _textureGroupKey = {
        [1] = 4,
        [2] = 2,
        [3] = 6,
        [4] = 7
      }
    }
  },
  _bookTextureGroup = {
    [1] = {
      x1 = 0,
      y1 = 244,
      x2 = 21,
      y2 = 342,
      sizeX = 21,
      sizeY = 98
    },
    [2] = {
      x1 = 22,
      y1 = 244,
      x2 = 41,
      y2 = 342,
      sizeX = 19,
      sizeY = 98
    },
    [3] = {
      x1 = 42,
      y1 = 244,
      x2 = 41,
      y2 = 341,
      sizeX = 12,
      sizeY = 97
    },
    [4] = {
      x1 = 55,
      y1 = 244,
      x2 = 66,
      y2 = 341,
      sizeX = 11,
      sizeY = 97
    },
    [5] = {
      x1 = 67,
      y1 = 244,
      x2 = 75,
      y2 = 341,
      sizeX = 8,
      sizeY = 97
    },
    [6] = {
      x1 = 76,
      y1 = 244,
      x2 = 87,
      y2 = 341,
      sizeX = 11,
      sizeY = 97
    },
    [7] = {
      x1 = 88,
      y1 = 244,
      x2 = 105,
      y2 = 341,
      sizeX = 17,
      sizeY = 97
    }
  },
  _bookShelfTextureGroup = {
    [1] = {
      texture = "combine/etc/combine_etc_adventure_03.dds",
      x1 = 0,
      y1 = 0,
      x2 = 268,
      y2 = 598,
      panelSize = 790,
      frameSize = 268,
      contentSize = 208
    },
    [2] = {
      texture = "combine/etc/combine_etc_adventure_03.dds",
      x1 = 269,
      y1 = 0,
      x2 = 761,
      y2 = 598,
      panelSize = 1014,
      frameSize = 492,
      contentSize = 434
    },
    [3] = {
      texture = "combine/etc/combine_etc_adventure_04.dds",
      x1 = 0,
      y1 = 0,
      x2 = 719,
      y2 = 598,
      panelSize = 1241,
      frameSize = 719,
      contentSize = 660
    }
  },
  _eventJournalTitle = {
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_ADVENTURE_NOTICE_HALLOWEENEVENT"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_ADVENTURE_NOTICE_VALENTINEEVENT")
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/Achievement/Panel_Window_Achievement_BookShelf_All_1.lua")
runLua("UI_Data/Script/Window/Achievement/Panel_Window_Achievement_BookShelf_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Achievement_BookShelf_All_Init")
function FromClient_Achievement_BookShelf_All_Init()
  PaGlobal_Achievement_BookShelf_All:initialize()
end
