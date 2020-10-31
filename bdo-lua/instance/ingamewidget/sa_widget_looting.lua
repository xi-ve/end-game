PaGlobal_SA_Widget_Looting = {
  _ui = {stc_lootingBG = nil},
  _initialize = false,
  _itemLooting = {},
  _maxLootingCnt = 4,
  _currentIndex = 1,
  _firstSlotPosY = 0,
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
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Looting_1.lua")
runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Looting_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SA_Widget_LootingInit")
function FromClient_SA_Widget_LootingInit()
  PaGlobal_SA_Widget_Looting:initialize()
end
