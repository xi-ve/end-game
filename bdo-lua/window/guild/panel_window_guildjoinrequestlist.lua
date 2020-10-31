PaGlobal_GuildJoinRequestList = {
  _ui = {}
}
runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildJoinRequestList_1.lua")
runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildJoinRequestList_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildRequestListInit")
function FromClient_GuildJoinRequestListInit()
  local self = PaGlobal_GuildJoinRequestList
  self:init()
end
