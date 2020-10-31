PaGlobal_SA_Widget_Looting_Equip = {
  _ui = {
    stc_topBg = nil,
    stc_gatherIcon = nil,
    txt_msg = nil,
    stc_equipBg = nil
  },
  _initialize = false,
  _maxEquipCount = 7,
  _curEquipCount = 0,
  _lootingEquipSlotList = {},
  _lootingEquipList = {
    equipBg = {},
    icon = {},
    name = {}
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createClassEquipBG = true,
    createCash = true
  },
  _itemGradeTexUV = {
    path = "ShadowArena/Contents/SA_Ingame_01.dds",
    [0] = {
      x1 = 48,
      x2 = 94,
      y1 = 243,
      y2 = 289
    },
    [1] = {
      x1 = 95,
      x2 = 141,
      y1 = 243,
      y2 = 289
    },
    [2] = {
      x1 = 142,
      x2 = 188,
      y1 = 243,
      y2 = 289
    },
    [3] = {
      x1 = 189,
      x2 = 235,
      y1 = 243,
      y2 = 289
    },
    [4] = {
      x1 = 236,
      x2 = 282,
      y1 = 243,
      y2 = 289
    }
  }
}
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Looting_Equip_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Looting_Equip_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_Looting_EquipInit")
function FromClient_SA_Widget_Looting_EquipInit()
  PaGlobal_SA_Widget_Looting_Equip:initialize()
end
