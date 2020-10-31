PaGlobal_BuildingBuff_All = {
  _ui = {
    _stc_Title = nil,
    _btn_Close = nil,
    _stc_SubFrame = nil,
    _list2 = nil,
    _stc_BottomGroup = nil,
    _txt_DescBG = nil,
    _rdo_Money = nil,
    _rdo_Money2 = nil,
    _txt_Money = nil,
    _txt_Money2 = nil,
    _txt_Title = nil,
    _stc_KeyGuide = nil
  },
  _maxPriceKey = 0,
  _keyCount = {},
  _buffCount = {},
  _limitControl = {},
  _limitControlName = {},
  _limitControlDesc = {},
  originPanelSizeY = 0,
  originBottomBGSizeY = 0,
  originDescSizeY = 0,
  originKeyGuidePosY = 0,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Camp/Panel_Window_Camp_VillaBuff_All_1.lua")
runLua("UI_Data/Script/Widget/Camp/Panel_Window_Camp_VillaBuff_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_BuildingBuff_All_luaLoadComplete")
function FromClient_BuildingBuff_All_luaLoadComplete()
  PaGlobal_BuildingBuff_All:initialize()
end
