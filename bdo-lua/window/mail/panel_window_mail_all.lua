PaGlobal_Window_Mail_All = {
  _ui = {
    stc_topBG = nil,
    txt_pageNumber = nil,
    btn_selectAll = nil,
    txt_mailCount = nil,
    stc_centerBG = nil,
    btn_mail = nil,
    _mail = {}
  },
  _ui_pc = {
    btn_close = nil,
    btn_question = nil,
    btn_prePage = nil,
    btn_nextPage = nil,
    btn_selectDelect = nil,
    btn_allRecieve = nil,
    btn_QNA = nil
  },
  _ui_console = {
    stc_leftIcon = nil,
    stc_rightIcon = nil,
    stc_bottomBG = nil,
    txt_keyGuideA = nil,
    txt_keyGuideX = nil,
    txt_keyGuideB = nil,
    txt_keyGuideY = nil,
    txt_keyGuideLS = nil,
    txt_keyGuideRS = nil
  },
  _mailData = {},
  _selectedMail = {},
  _rowMax = 8,
  _row_PosY_Gap = 2,
  _Page_Total = 1,
  _Page_Current = 1,
  _maxMailCount = 0,
  _mailControlPadding = 5,
  _isSelectAll = false,
  _isWithReward = true,
  _initialize = false,
  _isConsole = false
}
runLua("UI_Data/Script/Window/Mail/Panel_Window_Mail_All_1.lua")
runLua("UI_Data/Script/Window/Mail/Panel_Window_Mail_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Window_Mail_AllInit")
if false == _ContentsGroup_UsePadSnapping then
  registerEvent("FromClient_luaLoadComplete", "FromClient_Window_MailDetail_AllInit")
end
function FromClient_Window_Mail_AllInit()
  PaGlobal_Window_Mail_All:initialize()
end
