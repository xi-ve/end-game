PaGlobal_LoginPassword_All = {
  _state = {
    _type_CreatePassword = 0,
    _type_Reconfirm = 1,
    _type_Authentic = 2
  },
  _ui = {
    _txt_titleImport = nil,
    _txt_displayNum = nil,
    _chk_showNum = nil,
    _btn_backImport = nil,
    _btn_clearImport = nil,
    _btn_applyImport = nil,
    _btn_cancelImport = nil,
    _btn_numSlots = nil
  },
  _numSlotMax = 10,
  _stateType = 0,
  _initialize = false
}
runLua("UI_Data/Script/UI_Lobby/Panel_Login_Password_All_1.lua")
runLua("UI_Data/Script/UI_Lobby/Panel_Login_Password_All_2.lua")
registerEvent("FromClient_luaLoadCompleteLateUdpate", "FromClient_LoginPassward_All_Init")
function FromClient_LoginPassward_All_Init()
  PaGlobal_LoginPassword_All:initialize()
end
