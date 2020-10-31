PaGlobal_CharacterTag_All = {
  _ui = {
    stc_titleBg = nil,
    stc_topBg = nil,
    topDeco = {stc_bg = nil, stc_deco = nil},
    topEXP = {
      stc_bg = nil,
      stc_right = nil,
      stc_left = nil
    },
    mainImg1 = {
      stc_bg = nil,
      stc_img = nil,
      txt_name = nil,
      txt_lv = nil,
      stc_state = nil,
      txt_getExp = nil,
      txt_getSkillExp = nil
    },
    mainImg2 = {
      stc_bg = nil,
      stc_img = nil,
      txt_name = nil,
      txt_lv = nil,
      stc_state = nil,
      txt_getExp = nil,
      txt_getSkillExp = nil,
      stc_addIcon = nil
    },
    txt_tagAreaTitle = nil,
    txt_tagAreaValue = nil,
    chk_tagState = nil,
    chk_tagStateExp = nil,
    btn_takeEXP = nil,
    btn_charTAG = nil,
    btn_ItemCopy = nil,
    stc_eventDescBg = nil,
    txt_eventDesc = nil,
    stc_midBg = nil,
    stc_template = nil,
    stc_templateBorder = nil,
    stc_templateImage = nil,
    stc_templateSelect = nil,
    txt_templateLevel = nil,
    txt_templateState = nil,
    stc_templateOnline = nil,
    stc_scrollBg = nil,
    stc_descBg = nil,
    txt_desc = nil,
    characterList = {}
  },
  _ui_pc = {chk_popup = nil, btn_close = nil},
  _ui_console = {
    stc_keyGuideBg = nil,
    stc_keyConfirm = nil,
    stc_keyCancle = nil
  },
  LOCAL_DEFINE = {
    CHARSLOTCOLMAX = 6,
    CHARSLOTROWMAX = 2,
    CHARSLOTLISTMAX = 12,
    SCROLLVERTICAL = 270,
    NODUEL = -1
  },
  SHOW_TYPE = {
    NORMAL = 0,
    ARCHER_TAG = 1,
    TAKE_EXP = 2
  },
  _sideImg = {_page = -1, _index = -1},
  _selectCharaterSlot = {_Lv = -1, _ClassType = -1},
  _doTag = false,
  _requestCharacterKey = -1,
  _currentTagState = false,
  _selfCharTag = false,
  _maxCharacterCount = 0,
  _pageIndex = 0,
  _isPadSnap = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/CharacterTag/Panel_Window_CharacterTag_All_1.lua")
runLua("UI_Data/Script/Window/CharacterTag/Panel_Window_CharacterTag_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CharacterTag_All_Init")
function FromClient_CharacterTag_All_Init()
  PaGlobal_CharacterTag_All:initialize()
end
