ConsoleUIOffset = {
  _ui = {
    stc_BottomBg = UI.getChildControl(Panel_Window_ConsoleUIOffset, "Static_BottomBg"),
    _squareTable = {},
    _currentSquareTable = {},
    stc_informationDesc = nil,
    txt_keyGuideA = nil,
    txt_keyGuideB = nil,
    txt_Desc1 = nil,
    txt_Desc2 = nil,
    stc_BottomDesc = nil,
    txt_Desc3 = nil,
    stc_GuideImg = nil
  },
  _squareSizeTable = {},
  _MAX_SQUREOUNT = 4,
  _scrollSpeed = 0.2,
  _minOffset = 0,
  _maxOffset = 0.07,
  _currentOffset = 0
}
runLua("UI_Data/Script/Window/UI_Setting/Console/Panel_Window_ConsoleUIOffset_1.lua")
runLua("UI_Data/Script/Window/UI_Setting/Console/Panel_Window_ConsoleUIOffset_2.lua")
function PaGlobal_ConsoleUIOffset_Init()
  ConsoleUIOffset:init()
end
PaGlobal_ConsoleUIOffset_Init()
