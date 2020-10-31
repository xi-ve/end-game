PaGlobal_EdanPass = {
  _ui = {
    stc_titlebg = nil,
    stc_title = nil,
    stc_count = nil,
    stc_speed = nil,
    btn_close = nil,
    list2_list = nil,
    btn_nodelist = {},
    btn_ok = nil
  },
  _btnSplitString = {},
  _list_size = 0,
  _regionkey_list = {},
  _count_list = {},
  _speed_list = {},
  _name_list = {},
  _selectedIndex = 0,
  _initialize = false,
  _edanPassListSize = 0,
  _selectedIndex = -1
}
runLua("UI_Data/Script/Widget/Dialogue/Panel_EdanPass_1.lua")
runLua("UI_Data/Script/Widget/Dialogue/Panel_EdanPass_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_EdanPass_Init")
function FromClient_PaGlobal_EdanPass_Init()
  PaGlobal_EdanPass:initialize()
end
