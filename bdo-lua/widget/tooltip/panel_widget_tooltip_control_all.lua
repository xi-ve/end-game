PaGlobal_Tooltip_Control_All = {
  _dataObject = {
    slotData = {},
    currentSlotNo = -1,
    currentSlotType = "",
    index = -1,
    isNormal = false,
    isSkill = false,
    itemMarket = false,
    inventory = false,
    equip = false,
    isTooltipClickOpen = false
  },
  _equipItemLock = {
    itemLock = false,
    equipment = false,
    itemAccNo = -1
  },
  _servantKindTypeString = {
    [0] = {
      [3] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_BARD"),
      [4] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_SADDLE"),
      [5] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_STIRRUP"),
      [6] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_HORSEHEAD"),
      [12] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_FOOT"),
      [14] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_ARMOR"),
      [15] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_STIRRUP"),
      [16] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_SADDLE"),
      [17] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_HORSE_AVATAR_FACE")
    },
    [1] = {
      [3] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_CORVER"),
      [4] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_TIRE"),
      [5] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_FLAG"),
      [6] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_INSIGNIA"),
      [13] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_LAMP"),
      [25] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_BODY"),
      [14] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_AVATAR_BODY"),
      [15] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_AVATAR_TIRE"),
      [16] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_AVATAR_FLAG"),
      [17] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_AVATAR_INSIGNIA"),
      [26] = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_DYEPART_CARRIAGE_AVATAR_CORVER")
    },
    [2] = {
      [3] = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_SHIPARMOR_25"),
      [4] = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_SHIPARMOR_4"),
      [5] = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_SHIPARMOR_5"),
      [6] = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_SHIPARMOR_6"),
      [25] = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_SHIPARMOR_3"),
      [14] = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_SHIPARMOR_25"),
      [15] = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_SHIPARMOR_4"),
      [16] = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_SHIPARMOR_5"),
      [26] = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_SHIPARMOR_3")
    },
    [3] = {
      [3] = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_SHIPARMOR_17"),
      [4] = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_SHIPARMOR_18"),
      [5] = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_SHIPARMOR_19"),
      [6] = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_SHIPARMOR_20"),
      [25] = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_SHIPARMOR_3"),
      [14] = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_SHIPARMOR_17"),
      [15] = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_SHIPARMOR_18"),
      [16] = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_SHIPARMOR_19"),
      [26] = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_SHIPARMOR_20")
    }
  },
  _isGrowthContents = _ContentsGroup_AlchemyStone,
  _isTotemContents = _ContentsGroup_AlchemyFigureHead,
  _isQuestBookContents = _ContentsGroup_QuestBook,
  _isExtractionCommon = _ContentsGroup_ExtractionCommon,
  _isExtractionJapan = _ContentsGroup_ExtractionJapan,
  _isItemLock = _ContentsGroup_ItemLock,
  _isCronStone = _ContentsGroup_CronStone,
  _isMaxEnchanterEnable = _ContentsGroup_MaxEnchanterEnable,
  _firstTradeInfoData = nil,
  _secondTradeInfoData = nil,
  _savedSlotNo = 0,
  _clothBagSlotNo = 0,
  _bagInWarehouse = nil,
  _linkItemTooltipParent = nil,
  _NORMALTOOLTIP = {},
  _EQUIPTOOLTIP = {},
  _LINKEDTOOLTIP = {},
  _LINKEDCLICKTOOLTIP = {},
  _initialize = false
}
runLua("UI_Data/Script/Widget/ToolTip/Panel_Widget_Tooltip_Control_All_1.lua")
runLua("UI_Data/Script/Widget/ToolTip/Panel_Widget_Tooltip_Control_All_2.lua")
runLua("UI_Data/Script/Widget/ToolTip/Panel_Widget_Tooltip_Control_All_3.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Tooltip_Control_All_Init")
function FromClient_Tooltip_Control_All_Init()
  PaGlobal_Tooltip_Control_All:initialize()
end
