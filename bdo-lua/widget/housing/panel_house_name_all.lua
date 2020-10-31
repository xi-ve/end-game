PaGlobal_HouseName_All = {
  _eButtonType = {
    installMode = 0,
    installGift = 1,
    showRank = 2,
    underwear = 3,
    pet = 4,
    maid = 5
  },
  _ui = {
    _stc_deco_left = nil,
    _stc_deco_right = nil,
    _txt_houseName = nil,
    _txt_houseAddress = nil,
    _txt_houseScore = nil,
    _btn_installMode = nil,
    _btn_installGift = nil,
    _btn_showRank = nil,
    _chk_setUnderwear = nil,
    _chk_hidePet = nil,
    _chk_hideMaid = nil,
    _txt_noticeLighting = nil,
    _pc = {_stc_btnBg = nil},
    _console = {_stc_consoleKey = nil}
  },
  _isConsole = false,
  _prevPoint = 0,
  _isMyHouse = false,
  _updateWidgetTime = 0,
  _updateTime = 0,
  _isAlertHouseLighting = false,
  _defaultNameSizeX = 0,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Housing/Panel_House_Name_All_1.lua")
runLua("UI_Data/Script/Widget/Housing/Panel_House_Name_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_HouseName_All_Init")
function FromClient_HouseName_All_Init()
  PaGlobal_HouseName_All:initialize()
end
