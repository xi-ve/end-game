PaGlobal_Lobby_CharacterSelect_Top = {
  _ui = {
    _Button_BackSpaceBG = nil,
    _Static_RightGroup = nil,
    _StaticText_BackSpaceArrow = nil,
    _StaticText_Point = nil,
    _Static_FunctionButtonGroup = nil,
    _Button_Min = nil,
    _Button_Close = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_Top_1.lua")
runLua("UI_Data/Script/Instance/Lobby/SA_Widget_Lobby_CharacterSelect_Top_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_Lobby_CharacterSelect_Top_Init")
function FromClient_luaLoadComplete_Lobby_CharacterSelect_Top_Init()
  PaGlobal_Lobby_CharacterSelect_Top:initialize()
end
