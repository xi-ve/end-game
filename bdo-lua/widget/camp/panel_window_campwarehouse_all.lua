PaGlobal_CampWarehouse_All = {
  _ui = {
    stc_TopBG = nil,
    btn_Close = nil,
    stc_Weight = nil,
    txt_WeightVal = nil,
    stc_SlotBG = nil,
    stc_Slot = nil,
    stc_campSlotBGList = {},
    slot_campSlotList = {},
    stc_ProgressBG = nil,
    prg_Red = nil,
    prg_Yellow = nil,
    txt_ProgVal = nil
  },
  _playerActorKeyRaw = nil,
  _vehicleActorKeyRaw = nil,
  _vehicleActorType = nil,
  _campInvenIndexList = {},
  _campUsingSlotCount = nil,
  _campSlotCountMax = 16,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Camp/Panel_Window_CampWarehouse_All_1.lua")
runLua("UI_Data/Script/Widget/Camp/Panel_Window_CampWarehouse_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CampWarehouse_All_luaLoadComplete")
function FromClient_CampWarehouse_All_luaLoadComplete()
  PaGlobal_CampWarehouse_All:initialize()
end
