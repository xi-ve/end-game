PaGlobal_ServantSwiftResult_All = {
  _ui = {
    _stc_Horse_ToeHold = nil,
    _stc_Success = nil,
    _stc_Fail = nil
  },
  _effectControl = {},
  _controlCount = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantSwiftResult_All_1.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ServantSwiftResult_All_Init")
function FromClient_ServantSwiftResult_All_Init()
  PaGlobal_ServantSwiftResult_All:initialize()
end
