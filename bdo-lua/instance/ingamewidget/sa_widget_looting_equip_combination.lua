PaGlobal_SA_Widget_Looting_Equip_Combination = {
  _ui = {
    stc_topBg = nil,
    stc_gatherIcon = nil,
    txt_msg = nil,
    stc_lootingBG = nil
  },
  _initialize = false,
  _maxCombinationCount = 1,
  _combinationItemCount = 3,
  _combinationList = {},
  _materialItemKey = nil,
  _isKeyUp = false,
  _slotConfig = {
    createIcon = true,
    createBorder = false,
    createCount = true,
    createClassEquipBG = true,
    createCash = true
  }
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Looting_Equip_Combination_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Looting_Equip_Combination_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_Looting_Equip_Combination_Init")
function FromClient_SA_Widget_Looting_Equip_Combination_Init()
  PaGlobal_SA_Widget_Looting_Equip_Combination:initialize()
end
