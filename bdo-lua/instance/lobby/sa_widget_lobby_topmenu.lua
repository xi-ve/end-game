PaGlobal_Lobby_TopMenu = {
  _ui = {
    _mainMenu = nil,
    _radioButton_Play = nil,
    _radioButton_Shop = nil,
    _radioButton_Rank = nil,
    _static_SelectBar_On = nil,
    _static_SelectBar_Off = nil,
    _myInfoBG = nil,
    _staticText_BlackPointValue = nil,
    _staticText_SilverValue = nil,
    _static_ProfileIcon_Noimage = nil,
    _static_ProfileIcon = nil,
    _staticText_UserID = nil,
    _staticText_OnLine = nil,
    _staticText_TierIcon = nil,
    _static_OptionBtnBG = nil,
    _button_Option = nil,
    _button_Minimization = nil,
    _button_Close = nil
  },
  _selectedState = {
    _HOME = 0,
    _PLAY = 1,
    _SHOP = 2
  },
  _initialize = false
}
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_TopMenu_1.lua")
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_TopMenu_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_Lobby_TopMenu_Init")
function FromClient_luaLoadComplete_Lobby_TopMenu_Init()
  PaGlobal_Lobby_TopMenu:initialize()
end
