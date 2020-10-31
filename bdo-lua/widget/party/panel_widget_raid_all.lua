PaGlobal_Raid_All = {
  _ui = {
    stc_raidBg = nil,
    txt_charInfo = nil,
    stc_hpBg = nil,
    progress_hp = nil,
    stc_deadBg = nil
  },
  _ui_pc = {
    btn_leave = nil,
    btn_orderIcon = nil,
    btn_ordersBg = nil,
    btn_setLeader = nil,
    btn_forceOut = nil
  },
  _partyMemberData = {},
  _partyMemberCount = 0,
  _uiPartyMemberList = {},
  _slotMouseIndex = 0,
  _isSlotMouseOn = false,
  _isMaster = false,
  _selectIndex = -1,
  _maxPartyMemberCount = 20,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Party/Panel_Widget_Raid_All_1.lua")
runLua("UI_Data/Script/Widget/Party/Panel_Widget_Raid_All_2.lua")
changePositionBySever(Panel_Widget_Raid_All, CppEnums.PAGameUIType.PAGameUIPanel_LargeParty, false, true, false)
registerEvent("FromClient_luaLoadCompleteLateUdpate", "FromClient_Widget_Raid_All_Init")
function FromClient_Widget_Raid_All_Init()
  PaGlobal_Raid_All:initialize()
end
