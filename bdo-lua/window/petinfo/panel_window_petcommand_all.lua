PaGlobal_PetCommand_All = {
  _playBtns = {},
  _actionBtns = {},
  _talentBtns = {},
  _getItemBtns = {},
  _targetPetIndex = nil,
  _isCommandAll = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetCommand_All_1.lua")
runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetCommand_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PetCommand_All_Init")
function FromClient_PetCommand_All_Init()
  PaGlobal_PetCommand_All:initialize()
end
