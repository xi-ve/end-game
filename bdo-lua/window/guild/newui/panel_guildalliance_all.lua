PaGlobal_GuildAlliance_All = {
  _ui = {
    stc_Left = nil,
    stc_MarkBg = nil,
    stc_Mark = nil,
    txt_Name = nil,
    txt_Master = nil,
    txt_Member = nil,
    btn_Mark = nil,
    btn_Exit = nil,
    list2_AlliList = nil,
    stc_Right = nil,
    btn_SaveNotice = nil,
    btn_Reset = nil,
    edit_Notice = nil,
    stc_DescBg = nil,
    txt_Desc = nil,
    origin_DescBgY = nil,
    origin_DescTxtY = nil
  },
  _originPanelY = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildAlliance_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildAlliance_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildAlliance_All_Init")
function FromClient_GuildAlliance_All_Init()
  PaGlobal_GuildAlliance_All:initialize()
end
