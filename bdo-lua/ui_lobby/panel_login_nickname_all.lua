PaGlobal_LoginNickname_All = {
  _ui = {
    edit_Nickname = nil,
    btn_Apply = nil,
    txt_Desc_1 = nil,
    txt_Desc_2 = nil,
    txt_Desc_3 = nil,
    stc_Illust = nil,
    stc_consoleKeyGuide = nil,
    txt_targetEditKey = nil,
    txt_confirmKey = nil
  },
  _isConsole = false,
  _defaultEditSizeX = 0,
  _initialize = false
}
runLua("UI_Data/Script/UI_Lobby/Panel_Login_Nickname_All_1.lua")
runLua("UI_Data/Script/UI_Lobby/Panel_Login_Nickname_All_2.lua")
registerEvent("FromClient_luaLoadCompleteLateUdpate", "FromClient_LoginNickname_All_Init")
function FromClient_LoginNickname_All_Init()
  PaGlobal_LoginNickname_All:initialize()
end
