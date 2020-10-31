PaGlobal_MacroCheckQuiz_All = {
  _ui = {
    stc_TitleArea = nil,
    txt_Title = nil,
    stc_BottomLine = nil,
    txt_Question = nil,
    txt_LeftTime = nil,
    stc_ProgBg = nil,
    prog2_LeftTime = nil,
    stc_QuestionBg = nil,
    stc_WarningBg = nil,
    txt_Warning = nil,
    stc_AnswerPadTable = {},
    txt_CautionDesc = nil,
    btn_Apply = nil,
    stc_KeyGuideBg = nil,
    stc_KeyGuideY = nil
  },
  _string_QuizType = {
    [__eSecureCodeQuestionType_MaxHp] = PAGetString(Defines.StringSheet_GAME, "LUA_MACROCHECKQUIZ_QUIZ_TYPEMAXHP_TEXT"),
    [__eSecureCodeQuestionType_MaxMp] = PAGetString(Defines.StringSheet_GAME, "LUA_MACROCHECKQUIZ_QUIZ_TYPEMAXMP_TEXT"),
    [__eSecureCodeQuestionType_MaxWp] = PAGetString(Defines.StringSheet_GAME, "LUA_MACROCHECKQUIZ_QUIZ_QTYPEMAXWP_TEXT"),
    [__eSecureCodeQuestionType_MaxExplorePoint] = PAGetString(Defines.StringSheet_GAME, "LUA_MACROCHECKQUIZ_QUIZ_QTYPECONTRIBUTION_TEXT"),
    [__eeSecureCodeQuestionType_Level] = PAGetString(Defines.StringSheet_GAME, "LUA_MACROCHECKQUIZ_QUIZ_QTYPELEVEL_TEXT")
  },
  _maxQuestionCount = __eSecureCodeQuestion_TotalCount,
  _messageNo = 0,
  _logMessage = {},
  _limitTime = 180,
  _currentTime = 0,
  _playerName = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/MacroCheckQuiz/Panel_Window_MacroCheckQuiz_All_1.lua")
runLua("UI_Data/Script/Window/MacroCheckQuiz/Panel_Window_MacroCheckQuiz_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MacroCheckQuiz_All_Init")
function FromClient_MacroCheckQuiz_All_Init()
  PaGlobal_MacroCheckQuiz_All:initialize()
end
