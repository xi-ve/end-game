PaGlobal_CharInfoLife_All = {
  _ui = {
    stc_life = {},
    stc_BottomDesc = nil,
    stc_Console_KeyGuideBg = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil,
    stc_KeyGuide_X = nil,
    stc_KeyGuide_Y = nil
  },
  _SUBLIFE_COLLECT_STRING = {
    [1] = "PANEL_CHARACTERINFO_RENEW_WATERING_TITLE",
    [2] = "PANEL_CHARACTERINFO_LIFEINFO_CRAFTTYPE_FELLING",
    [3] = "PANEL_CHARACTERINFO_LIFEINFO_CRAFTTYPE_SAP",
    [4] = "PANEL_CHARACTERINFO_LIFEINFO_CRAFTTYPE_HOMMY",
    [5] = "PANEL_CHARACTERINFO_LIFEINFO_CRAFTTYPE_SLAUGHTER",
    [6] = "PANEL_CHARACTERINFO_LIFEINFO_CRAFTTYPE_TANNING",
    [7] = "PANEL_CHARACTERINFO_LIFEINFO_CRAFTTYPE_MINING"
  },
  _SUBLIFE_MANUFACTURE = {
    [1] = "PANEL_CHARACTERINFO_LIFEINFO_CRAFTTYPE_SHAKING",
    [2] = "PANEL_CHARACTERINFO_LIFEINFO_CRAFTTYPE_GRIDING",
    [3] = "PANEL_CHARACTERINFO_LIFEINFO_CRAFTTYPE_FIREWOOD",
    [4] = "PANEL_CHARACTERINFO_LIFEINFO_CRAFTTYPE_DRYING",
    [5] = "PANEL_CHARACTERINFO_LIFEINFO_CRAFTTYPE_THINOUT",
    [6] = "PANEL_CHARACTERINFO_LIFEINFO_CRAFTTYPE_HEATING"
  },
  _LIFETYPE_COUNT = 12,
  _selfPlayer = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_Life_All_1.lua")
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_Life_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CharInfoLife_AllInit")
function FromClient_CharInfoLife_AllInit()
  PaGlobal_CharInfoLife_All:initialize()
end
