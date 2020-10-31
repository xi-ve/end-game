PaGlobal_GuildJoinRequestList_All = {
  _ui = {
    stc_titleBg = nil,
    _title = {
      txt_level = nil,
      txt_class = nil,
      txt_name = nil,
      txt_contribute = nil,
      txt_attck = nil,
      txt_awakeAttack = nil,
      txt_defence = nil
    },
    list2_request = nil,
    stc_bottomBg = nil,
    txt_desc = nil
  },
  _ui_pc = {btn_refresh = nil},
  _ui_console = {},
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildJoinRequest_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildJoinRequest_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildJoinRequestList_All_Init")
function FromClient_GuildJoinRequestList_All_Init()
  PaGlobal_GuildJoinRequestList_All:initialize()
end
