PaGlobal_Barter = {
  _ui = {
    _titleBar = UI.getChildControl(Panel_Window_Barter, "Static_TitleBg"),
    _normalBg = UI.getChildControl(Panel_Window_Barter, "Static_NormalGroup"),
    _specialBg = UI.getChildControl(Panel_Window_Barter, "Static_SpecialGroup"),
    _rdoBtnBg = UI.getChildControl(Panel_Window_Barter, "Static_RadioButtons"),
    _mainBg = UI.getChildControl(Panel_Window_Barter, "Static_MainBg")
  },
  _slotConfig = {
    createIcon = true,
    createEnchant = true,
    createBorder = true,
    createCount = true
  },
  _itemGradeColor = {
    [__eItemGradeNormal] = Defines.Color.C_FFFFFFFF,
    [__eItemGradeMagic] = 4284350320,
    [__eItemGradeRare] = 4283144191,
    [__eItemGradeUnique] = 4294953010,
    [__eItemGradeEpic] = 4294929408,
    [__eItemGradeTypeCount] = Defines.Color.C_FFFFFFFF
  },
  _updateCurrentTime = 0,
  _updatePastTime = 0,
  _totalMyItemWeight = 0,
  _totalNPCItemWeight = 0,
  _panelSizeX = 0,
  _panelSizeY = 0,
  _isLoadComplete = false
}
runLua("UI_Data/Script/Window/Exchange/Panel_Window_Barter_1.lua")
runLua("UI_Data/Script/Window/Exchange/Panel_Window_Barter_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_BarterInit")
function FromClient_BarterInit()
  local self = PaGlobal_Barter
  self:init()
end
