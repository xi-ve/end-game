PaGlobal_ReportAll = {
  _ui = {
    _stc_Title = nil,
    _btn_Close = nil,
    _stc_Main = nil,
    _rdo_Classifys = {},
    _edit_Contents = nil,
    _stc_ContentTitle = nil,
    _btn_Confirm = nil,
    _btn_Cancle = nil,
    _stc_Line = nil,
    _stc_NoTarget = nil
  },
  _value = {
    classifyCount = 10,
    selectedClassify = nil,
    selcetedHideCharater = ""
  },
  _string = {
    default = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDINFO_INPUT_EDITTEXT", "maxLength", 100)
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/Report/Panel_Window_ReportAll_1.lua")
runLua("UI_Data/Script/Window/Report/Panel_Window_ReportAll_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ReportAll_Init")
function FromClient_ReportAll_Init()
  PaGlobal_ReportAll:initialize()
end
