PaGlobal_Manufacture_Notify_All = {
  _ui = {
    stc_progressBG = nil,
    progress_manufacture = nil,
    txt_progressText = nil,
    stc_progressEffect = nil,
    txt_typeName = nil,
    txt_resultTitle = nil
  },
  _ui_template = {
    stc_resourceBG = nil,
    stc_resourceIcon = nil,
    txt_resourceItem = nil,
    stc_resultBG = nil,
    stc_resultIcon = nil,
    txt_resultItem = nil
  },
  _failMessage = {
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_FAILREASON1"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_FAILREASON2"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_FAILREASON3"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_FAILREASON4"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_FAILREASON5"),
    [6] = nil,
    [7] = PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_FAILREASON7"),
    [8] = PAGetString(Defines.StringSheet_GAME, "ALCHEMY_MANUFACTURE_INVENTORY_LEAST_ONE"),
    [9] = PAGetString(Defines.StringSheet_GAME, "ALCHEMY_MANUFACTURE_INVENTORY_WEIGHTOVER"),
    [10] = PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_WP_IS_LACK"),
    [11] = PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_FAILREASON_MASS")
  },
  _icon_ResourceBG = {},
  _icon_Resource = {},
  _item_Resource = {},
  _icon_ResultBG = {},
  _icon_Result = {},
  _item_Result = {},
  _data_Resource = {},
  _data_Result = {},
  _gapY = 20,
  _consoleGapY = 40,
  _defalutSpanY = 0,
  _failCount = 0,
  _successCount = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/Alchemy/Panel_Window_Manufacture_Notify_All_1.lua")
runLua("UI_Data/Script/Window/Alchemy/Panel_Window_Manufacture_Notify_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Manufacture_Notify_All_Init")
function FromClient_Manufacture_Notify_All_Init()
  PaGlobal_Manufacture_Notify_All:initialize()
end
