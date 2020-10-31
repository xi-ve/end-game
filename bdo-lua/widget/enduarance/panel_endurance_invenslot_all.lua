PaGlobal_Endurance_InvenSlot_All = {
  _ui = {
    txt_InvenSlotIcon = nil,
    txt_InvenSlotText = nil,
    btn_RepairAutoNavi = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Widget/Enduarance/Panel_Endurance_InvenSlot_All_1.lua")
runLua("UI_Data/Script/Widget/Enduarance/Panel_Endurance_InvenSlot_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Endurance_InvenSlot_All_Init")
function FromClient_Endurance_InvenSlot_All_Init()
  PaGlobal_Endurance_InvenSlot_All:initialize()
end
