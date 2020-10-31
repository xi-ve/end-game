PaGlobal_Dialogue_Itemtake_All = {
  _ui = {
    stc_titleBG = nil,
    txt_title = nil,
    stc_midBG = nil,
    stc_subFrameBG = nil,
    stc_itemIcon = nil,
    txt_Comment = nil,
    txt_itemName = nil,
    stc_line = nil,
    txt_needContribution = nil,
    txt_myContribution = nil,
    stc_territorymark = nil,
    txt_helpMsg = nil,
    stc_titleDeco = nil
  },
  _ui_pc = {btn_yes = nil, btn_no = nil},
  _ui_console = {
    stc_bottomBg = nil,
    stc_guideIconB = nil,
    stc_guideIconX = nil,
    stc_guideIconA = nil
  },
  _initialize = false,
  _isConsole = false,
  slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createCash = true
  },
  _currentDisplayData = nil,
  _selectedIndex = 0,
  _ICONPOSX = 0
}
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialogue_Itemtake_All_1.lua")
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialogue_Itemtake_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Dialogue_Itemtake_AllInit")
function FromClient_Dialogue_Itemtake_AllInit()
  PaGlobal_Dialogue_Itemtake_All:initialize()
end
