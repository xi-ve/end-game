PaGlobal_CharInfoChallenge_All = {
  _ui = {
    stc_KeyGuide_LT = nil,
    stc_KeyGuide_RT = nil,
    rdo_Object = nil,
    rdo_Time = nil,
    rdo_PCRoom = nil,
    rdo_Event = nil,
    rdo_PreComplete = nil,
    rdo_Complete = nil,
    stc_selectLine = nil,
    txt_CompleteTask = nil,
    txt_NotReceivedCount = nil,
    txt_PcroomTime = nil,
    stc_challBg = nil,
    stc_Challenge_Temp = nil,
    stc_Scroll = nil,
    stc_Scroll_Up = nil,
    stc_Scroll_Down = nil,
    stc_Scroll_Ctrl = nil,
    stc_KeyGuideBg = nil,
    stc_KeyGuide_X = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil,
    stc_Console_RewardBg = nil,
    stc_Console_BasicItem = {},
    stc_Console_SelectItem = {},
    rdo_Table = {},
    stc_RewardTable = {},
    stc_ExpTooltip = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createClassEquipBG = true,
    createCash = true
  },
  _currentSelected = {
    _challengeIdx = nil,
    _subItemIdx = nil,
    _tabIdx = 0
  },
  _eTAB = {
    OBJECT = 0,
    TIME = 1,
    PCROOM = 2,
    EVENT = 3,
    COMPLETE = 4,
    REWARD = 5
  },
  _originBaseSlotSize = 0,
  _originSpanSizeX = {},
  _currentTaskCount = 0,
  _scrollIdx = 0,
  _MAXTABCOUNT = 6,
  _MAXBGCOUNT = 4,
  _MAXBASESLOT = 6,
  _MAXSUBSLOT = 6,
  _selfPlayer = nil,
  _consoleUIIdx = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_Challenge_All_1.lua")
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_Challenge_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CharInfoChallenge_AllInit")
function FromClient_CharInfoChallenge_AllInit()
  PaGlobal_CharInfoChallenge_All:initialize()
end
