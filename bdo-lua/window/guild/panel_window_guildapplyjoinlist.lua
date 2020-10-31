PaGlobal_GuildApplyJoinList = {
  _ui = {
    _stc_TitleArea = UI.getChildControl(Panel_Guild_ApplyJoinList, "Static_TItleArea"),
    _btn_close = nil,
    _stc_MainBG = UI.getChildControl(Panel_Guild_ApplyJoinList, "Static_MainBG"),
    _stc_guildList = nil,
    _txt_noGuildText = nil,
    _txt_guildName = nil,
    _btn_delete = nil
  },
  _maxJoinCount = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildApplyJoinList_1.lua")
runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildApplyJoinList_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildApplyJoinList")
function FromClient_GuildApplyJoinList()
  local self = PaGlobal_GuildApplyJoinList
  self:init()
end
