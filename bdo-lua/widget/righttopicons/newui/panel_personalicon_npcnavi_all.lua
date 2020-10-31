PaGlobal_NpcNavi_All = {
  _ui = {
    stc_TitleArea = nil,
    stc_TopAreaBG = nil,
    stc_WareHouseBG = nil,
    stc_SearchBG = nil,
    tree_Npc = nil,
    tree_overStatic = nil,
    scroll = nil,
    edit_Serarch = nil,
    txt_ErrorText = nil,
    txt_Desc = nil
  },
  _ui_pc = {btn_Close = nil, btn_Search = nil},
  _ui_console = {
    stc_KeyGuideBG = nil,
    txt_KeyGuideA = nil,
    txt_KeyGuideB = nil,
    txt_KeyGuideDPadVer = nil,
    txt_KeyGuideDPadHor = nil
  },
  _warehouseCount = 8,
  _warehouseBtns = {},
  _territoryTownData = {
    [1] = {
      _x = 8489.57,
      _y = -7818.83,
      _z = 82973.3,
      _actorKey = 40044,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_WAREHOUSE_1"),
      _isOpen = true
    },
    [2] = {
      _x = 40853.2,
      _y = -3474.33,
      _z = -50928,
      _actorKey = 41013,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_WAREHOUSE_2"),
      _isOpen = true
    },
    [3] = {
      _x = -254083,
      _y = -2754.48,
      _z = -40846.4,
      _actorKey = 42138,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_WAREHOUSE_3"),
      _isOpen = ToClient_IsContentsGroupOpen("2")
    },
    [4] = {
      _x = 364177,
      _y = -4957.73,
      _z = -74140.1,
      _actorKey = 44019,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_WAREHOUSE_4"),
      _isOpen = ToClient_IsContentsGroupOpen("3")
    },
    [6] = {
      _x = -514130,
      _y = 8984.42,
      _z = -455421,
      _actorKey = 45555,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_WAREHOUSE_6"),
      _isOpen = ToClient_IsContentsGroupOpen("5")
    },
    [7] = {
      _x = -46455.86,
      _y = 22008.5,
      _z = -403908.03,
      _actorKey = 46008,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_WAREHOUSE_7"),
      _isOpen = ToClient_IsContentsGroupOpen("6")
    },
    [8] = {
      _x = -172548.02,
      _y = 19582.9,
      _z = -611631,
      _actorKey = 47008,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNAVI_WAREHOUSE_8"),
      _isOpen = ToClient_IsContentsGroupOpen("7")
    }
  },
  lazyUpdate = false,
  selectIndex = -1,
  treeGroupData = {},
  preLoadTextureKey = {},
  preLoadTextureKey_territory = {},
  cacheExecuteDialogData = {},
  filterText = "",
  isMouseOnPanel = false,
  isMouseOnTreeView = false,
  errorMessageShow = true,
  isChecked_AddEffect = 0,
  isChecked_EffectReset = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/RightTopIcons/NewUI/Panel_PersonalIcon_NpcNavi_All_1.lua")
runLua("UI_Data/Script/Widget/RightTopIcons/NewUI/Panel_PersonalIcon_NpcNavi_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_NpcNaviInit")
function FromClient_PaGlobal_NpcNaviInit()
  PaGlobal_NpcNavi_All:initialize()
end
