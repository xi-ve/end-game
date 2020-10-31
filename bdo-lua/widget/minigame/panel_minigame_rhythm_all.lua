PaGlobal_MiniGame_Rhythm_All = {
  _ui = {
    stc_rhythmBG = nil,
    stc_rhythmNote = nil,
    stc_rhythmCursor = nil,
    stc_mouseBody_L = nil,
    stc_mouseBody_R = nil,
    stc_mouseLeft_L = nil,
    stc_mouseLeft_R = nil,
    stc_mouseRight_L = nil,
    stc_mouseRight_R = nil,
    stc_keyguideBG = nil,
    txt_purposeText = nil,
    stc_resultGood = nil,
    stc_resultBad = nil
  },
  _rhythmQuestList = {
    [0] = {questGroup = 1001, questId = 7},
    {questGroup = 1001, questId = 53},
    {questGroup = 2001, questId = 58},
    {questGroup = 6505, questId = 3},
    {questGroup = 780, questId = 5}
  },
  _miniGameNo = 1101,
  _lineCount = 5,
  _cursorStartPos = 0,
  _cursorFixedValue = 5,
  _cursorIndex = 0,
  _culledSize = 7,
  _hideSize = 10,
  _noteSpeed = 90,
  _noteBuffer = {},
  _notePosBuffer = {},
  _bufferMax = 50,
  _bufferIndex = 1,
  _createTime = 0.5,
  _currentSumTime = 0,
  _questCheckTime = 0,
  _playingTime = 20,
  _isFailed = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Rhythm_All_1.lua")
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Rhythm_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Minigame_Rhythm_All_Init")
function FromClient_Minigame_Rhythm_All_Init()
  PaGlobal_MiniGame_Rhythm_All:initialize()
end
