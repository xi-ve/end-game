PaGlobal_ThornCastle_Member = {
  _ui = {_memberTemplate = nil},
  _teamMemberUi = {},
  _buffMaxCount = 4,
  _isCreate = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/ThornCastle/Panel_Widget_ThornCastle_Member_1.lua")
runLua("UI_Data/Script/Widget/ThornCastle/Panel_Widget_ThornCastle_Member_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ThornCastle_MemberInit")
function FromClient_ThornCastle_MemberInit()
  PaGlobal_ThornCastle_Member:initialize()
end
