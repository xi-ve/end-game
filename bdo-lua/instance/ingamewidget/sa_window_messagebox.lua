PaGlobal_SA_Window_MessageBox = {
  _ui = {
    stc_exitBG = nil,
    txt_content = nil,
    stc_buttons = nil,
    btn_yes = nil,
    btn_no = nil,
    btn_close = nil
  },
  _currentMessageBoxData = nil,
  _originPanelSizeY = nil,
  _originContentSizeY = nil,
  _functionKeyUse = true,
  _elapsedTime = 0,
  _initialize = false
}
MessageBox = {}
MessageData = {
  content = nil,
  functionYes = nil,
  functionNo = nil,
  isTimeCount = false,
  countTime = 10,
  timeString = nil,
  isStartTimer = nil,
  afterFunction = nil
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Window_MessageBox_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Window_MessageBox_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Window_MessageBox_Init")
function FromClient_SA_Window_MessageBox_Init()
  PaGlobal_SA_Window_MessageBox:initialize()
end
