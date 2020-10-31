PaGlobal_GuildJoinRequestSet = {
  _ui = {
    _stc_title = UI.getChildControl(Panel_Guild_JoinRequestSet, "Static_TitleArea"),
    _btn_close = nil,
    _btn_update = UI.getChildControl(Panel_Guild_JoinRequestSet, "Button_Update"),
    _btn_cancel = UI.getChildControl(Panel_Guild_JoinRequestSet, "Button_Cancel"),
    _btn_showList = UI.getChildControl(Panel_Guild_JoinRequestSet, "Button_List"),
    _stc_selectBg = UI.getChildControl(Panel_Guild_JoinRequestSet, "Static_SelectBG"),
    _txt_time = nil,
    _originPanelSize = 0,
    _originDescSize = 0
  }
}
runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildJoinRequestSet_1.lua")
runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildJoinRequestSet_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildJoinRequestSetInit")
function FromClient_GuildJoinRequestSetInit()
  local self = PaGlobal_GuildJoinRequestSet
  self:init()
  Panel_Guild_JoinRequestSet:RegisterCloseLuaFunc(PAUIRenderModeBitSet({
    Defines.CloseType.eCloseType_Escape
  }), "PaGlobal_GuildJoinRequestSet:close()")
end
