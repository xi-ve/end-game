PaGlobal_MentalGame_All = {
  _ui_left = {
    stc_leftBg = nil,
    txt_npcType = nil,
    txt_npcName = nil,
    txt_mission = nil,
    txt_tip = nil,
    txt_interest = nil,
    txt_impression = nil,
    stc_intimacyCircleProgressBg = nil,
    stc_intimacyCircleProgress = nil,
    stc_intimacyCirclePoint = nil,
    txt_imtimacyTitle = nil,
    stc_rewardIcon = nil,
    txt_reward = nil,
    txt_giftNotice = nil,
    stc_resultBg = nil,
    txt_result = nil
  },
  _ui_right = {
    stc_topBg = nil,
    txt_comment1 = nil,
    txt_comment2 = nil,
    stc_bottomDecoBg = nil,
    stc_circleLineBg = nil,
    btn_rightArrow = nil,
    btn_leftArrow = nil,
    stc_nowListBg = nil,
    stc_bottomBg = nil,
    stc_selectedNpc = nil,
    stc_mentalNpcIcon = nil,
    stc_mentalNpcName = nil,
    stc_listPoint = nil,
    stc_checkIcon = nil,
    stc_interestBg = nil,
    txt_interestTitle = nil,
    txt_mentalCount = nil,
    txt_intimacyGet = nil
  },
  _ui_select = {
    txt_addInterest = nil,
    stc_npcCircleProgress = nil,
    stc_successIcon = nil,
    stc_failedIcon = nil
  },
  _ui_tooltip = {
    txt_npcName = nil,
    txt_statusTitle = nil,
    txt_hitBase = nil,
    txt_hitBonus = nil,
    txt_valueBase = nil,
    txt_valueBonus = nil,
    txt_commentTitle = nil,
    txt_commentInterest = nil,
    txt_commentFavorable = nil,
    txt_nextBonusTitle = nil,
    txt_nextBonuse = nil
  },
  _ui_center = {stc_finishBg = nil, txt_finishResult = nil},
  _ui_pc = {
    stc_exitDesc = nil,
    btn_exit = nil,
    btn_try = nil,
    btn_continue = nil,
    btn_continueDesc = nil,
    btn_leave = nil,
    btn_leaveDesc = nil
  },
  _ui_console = {
    stc_keyGuideBg = nil,
    stc_guideIconB = nil,
    stc_guideIconA = nil,
    stc_guideIconY = nil,
    stc_guideIconX = nil,
    stc_guideIconRB = nil,
    stc_guideIconLB = nil
  },
  _ui_zodiac = {},
  _constValue = {
    interestValueMax = 1000,
    slotCountMax = 10,
    buffTypeString = {
      [0] = PAGetString(Defines.StringSheet_GAME, "MENTALGAME_BUFFTYPE_FAVOR"),
      [1] = PAGetString(Defines.StringSheet_GAME, "MENTALGAME_BUFFTYPE_INTERESTING"),
      [2] = PAGetString(Defines.StringSheet_GAME, "MENTALGAME_BUFFTYPE_DEMANDINGINTERESTING"),
      [3] = PAGetString(Defines.StringSheet_GAME, "MENTALGAME_BUFFTYPE_DEMANDINGFAVOR")
    },
    hideTime = 5,
    maxPlayCount = 3
  },
  _intimacyIcon = {
    [0] = {
      [1] = {
        texture = "Combine/ETC/Combine_ETC_IntimacyRing.dds",
        x1 = 1,
        y1 = 198,
        x2 = 28,
        y2 = 225
      },
      [2] = {
        texture = "Combine/ETC/Combine_ETC_IntimacyRing.dds",
        x1 = 29,
        y1 = 198,
        x2 = 56,
        y2 = 225
      },
      [3] = {
        texture = "Combine/ETC/Combine_ETC_IntimacyRing.dds",
        x1 = 57,
        y1 = 198,
        x2 = 84,
        y2 = 225
      }
    },
    [1] = {
      texture = "Combine/ETC/Combine_ETC_IntimacyRing.dds",
      x1 = 113,
      y1 = 198,
      x2 = 140,
      y2 = 225
    },
    [2] = {
      texture = "Combine/ETC/Combine_ETC_IntimacyRing.dds",
      x1 = 85,
      y1 = 198,
      x2 = 112,
      y2 = 225
    },
    [3] = {
      texture = "Combine/ETC/Combine_ETC_IntimacyRing.dds",
      x1 = 141,
      y1 = 198,
      x2 = 168,
      y2 = 225
    },
    [4] = {
      texture = "Renewal/Progress/Console_Progressbar_02.dds",
      x1 = 163,
      y1 = 448,
      x2 = 194,
      y2 = 479
    },
    [5] = {
      texture = "Renewal/UI_Icon/Console_Icon_00.dds",
      x1 = 231,
      y1 = 24,
      x2 = 205,
      y2 = 227
    }
  },
  _text = {
    hasMentalCardText = PAGetString(Defines.StringSheet_GAME, "LUA_INTIMACY_ALL_INFORMATION_HASMENTALCARD"),
    hasntMentalCardText = PAGetString(Defines.StringSheet_GAME, "LUA_INTIMACY_ALL_INFORMATION_HASNTMENTALCARD")
  },
  _operatorString = {
    [CppEnums.DlgCommonConditionOperatorType.Equal] = "",
    [CppEnums.DlgCommonConditionOperatorType.Large] = "<PAColor0xFFFF0000>\226\150\178<PAOldColor>",
    [CppEnums.DlgCommonConditionOperatorType.Small] = "<PAColor0xFF0000FF>\226\150\188<PAOldColor>"
  },
  _mentalGame_End = false,
  _gameStep = 0,
  _gamePlayCount = 0,
  _isConsole = false,
  _addIntimacy = 0,
  _bestPoint = 0,
  _animationIndex = 0,
  _hideDeltaTime = 0,
  _endTimechk = 0,
  _scrollPositionResult = 0,
  _scrollPosition = -5,
  _selectCardIndex = -1,
  _overKey = -1,
  _prevDragImageSizeX = 20,
  _prevDragImageSizeY = 20,
  _resultTextList = {},
  _centerUiList = {},
  _animationUIList = {},
  _animationList = {},
  _informationUI = {},
  _rightCardList = {},
  _circleKeyList = {},
  _giftIcon = {},
  _isRdown = false,
  _rMovePos = {x = 0, y = 0},
  _renderMode = RenderModeWrapper.new(100, {
    Defines.RenderMode.eRenderMode_MentalGame
  }, false),
  _mouseInputer = nil,
  _isViewTooltip = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Dialogue/Panel_MentalGame_All_1.lua")
runLua("UI_Data/Script/Widget/Dialogue/Panel_MentalGame_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MentalGame_All_Init")
function FromClient_MentalGame_All_Init()
  if true == _ContentsGroup_NewUI_MentalGame_All then
    PaGlobal_MentalGame_All:initialize()
  end
end
