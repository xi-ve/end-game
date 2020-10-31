PaGlobal_ClanList_All = {
  _ui = {
    stc_title = nil,
    btn_question = nil,
    btn_close = nil,
    frame_clanList = nil,
    frameContent = nil,
    stc_menuBG = nil,
    btn_clanDispersal = nil,
    stc_titleBG = nil,
    txt_nameTitle = nil,
    template_memberBG = nil,
    template_grade = nil,
    template_level = nil,
    template_class = nil,
    template_name = nil,
    template_platformIcon = nil,
    template_button = nil,
    stc_bottomBG = nil,
    btn_keyGuideA = nil,
    btn_keyGuideB = nil,
    btn_keyGuideY = nil,
    btn_keyGuideX = nil,
    btn_setSubMaster = nil,
    btn_unsetSubMaster = nil,
    btn_kickClan = nil
  },
  _selectedMemberIdx = 0,
  _selectedMemberUserNo = 0,
  _listPool = {},
  _maxMemberCount = 15,
  _showFamilyName = true,
  _currentPadOnIndex = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/Panel_Window_ClanList_All_1.lua")
runLua("UI_Data/Script/Window/Guild/Panel_Window_ClanList_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ClanList_All_Init")
function FromClient_ClanList_All_Init()
  PaGlobal_ClanList_All:initialize()
end
