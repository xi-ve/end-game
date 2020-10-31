PaGlobal_NpcNavi_Tooltip = {
  _ui = {
    txt_NpcName = nil,
    txt_NpcDesc = nil,
    txt_itemName = nil,
    stc_Icon = nil,
    txt_NeedExplorePoint = nil,
    txt_Description = nil,
    txt_NotFind = nil,
    stc_ProgressBG = nil,
    CircularProgress = nil,
    txt_FruitageValue = nil,
    stc_GiftIcon = nil
  },
  _currentNpcName = "",
  _initialize = false
}
runLua("UI_Data/Script/Widget/RightTopIcons/NewUI/Panel_Tooltip_NpcNavigation_All_1.lua")
runLua("UI_Data/Script/Widget/RightTopIcons/NewUI/Panel_Tooltip_NpcNavigation_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_NpcNavi_TooltipInit")
function FromClient_PaGlobal_NpcNavi_TooltipInit()
  PaGlobal_NpcNavi_Tooltip:initialize()
end
