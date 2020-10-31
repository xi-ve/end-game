PaGlobal_ServantCarriageLink_All = {
  _ui = {
    _stc_TitleBG = nil,
    _stc_TitleIcon = nil,
    _btn_Close_PC = nil,
    _btn_Question_PC = nil,
    _stc_MainBg = nil,
    _txt_NoCarriage = nil,
    _txt_NoHorse = nil,
    _stc_MouseGuideArea = nil,
    _txt_LClick = nil,
    _txt_RClick = nil,
    _list2_Carriage = nil,
    _list2_Carriage_Content = nil,
    _list2_Carriage_Slot = nil,
    _list2_NoEnduranceBg = nil,
    _list2_Carriage_CarriageIcon = nil,
    _list2_Carriage_Name = nil,
    _list2_Carriage_RegionName = nil,
    _list2_Carriage_SlotCount = nil,
    _list2_Carriage_VertiScroll = nil,
    _list2_Carriage_VertiScroll_Up = nil,
    _list2_Carriage_VertiScroll_Down = nil,
    _list2_Carriage_VertiScroll_Ctrl = nil,
    _List2_Carriage_HoriScroll = nil,
    _List2_Carriage_HoriScroll_Up = nil,
    _List2_Carriage_HoriScroll_Down = nil,
    _List2_Carriage_HoriScroll_Ctrl = nil,
    _list2_Horse = nil,
    _list2_Horse_Content = nil,
    _list2_Horse_HorseSlot = nil,
    _list2_Horse_IconBg = nil,
    _list2_Horse_Icon = nil,
    _list2_Horse_LinkIcon = nil,
    _list2_Horse_Leven_Name = nil,
    _list2_Horse_RegionName = nil,
    _list2_Horse_Tier = nil,
    _list2_Horse_State = nil,
    _list2_Horse_VertiScroll = nil,
    _list2_Horse_VertiScroll_Up = nil,
    _list2_Horse_VertiScroll_Down = nil,
    _list2_Horse_VertiScroll_Ctrl = nil,
    _List2_Horse_HoriScroll = nil,
    _List2_Horse_HoriScroll_Up = nil,
    _List2_Horse_HoriScroll_Down = nil,
    _List2_Horse_HoriScroll_Ctrl = nil,
    _btn_Link_PC = nil,
    _btn_Cancel_PC = nil,
    _stc_Bottom_KeyGuides = nil,
    _stc_KeyGuide_A = nil,
    _stc_KeyGuide_B = nil
  },
  _linkAbleHorse_List = {},
  _carriageBtn_List = {},
  _currentSelectedHorse = {},
  _currentSelectedHorseCount = 0,
  _currentCarriageIndex = nil,
  _currentCarriage = {
    _slotIdx = nil,
    _carriageNo = nil,
    _maxLinkAbleHorse = nil
  },
  _scrollPos = {
    _horseScrollPos = 0,
    _horseIdx = 0,
    _carriageScrollPos = 0,
    _carriageIdx = 0
  },
  _isConsole = false,
  _initailize = false
}
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantCarriageLink_All_1.lua")
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantCarriageLink_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ServantCarriageLink_All_Init")
function FromClient_ServantCarriageLink_All_Init()
  PaGlobal_ServantCarriageLink_All:initialize()
end
