local _panel = Panel_Window_ConsoleUIOffset
function ConsoleUIOffset:init()
  for idx = 0, ConsoleUIOffset._MAX_SQUREOUNT - 1 do
    ConsoleUIOffset._ui._squareTable[idx] = UI.getChildControl(_panel, "Static_Square" .. idx)
  end
  for idx = 0, ConsoleUIOffset._MAX_SQUREOUNT - 1 do
    ConsoleUIOffset._ui._currentSquareTable[idx] = UI.getChildControl(_panel, "Static_SquareRed" .. idx)
  end
  ConsoleUIOffset._ui.stc_informationDesc = UI.getChildControl(_panel, "Static_InformationDesc")
  ConsoleUIOffset._ui.txt_keyGuideA = UI.getChildControl(ConsoleUIOffset._ui.stc_BottomBg, "StaticText_A_ConsoleUI")
  ConsoleUIOffset._ui.txt_keyGuideB = UI.getChildControl(ConsoleUIOffset._ui.stc_BottomBg, "StaticText_B_ConsoleUI")
  self._ui.txt_Desc1 = UI.getChildControl(self._ui.stc_informationDesc, "StaticText_Desc1")
  self._ui.txt_Desc2 = UI.getChildControl(self._ui.stc_informationDesc, "StaticText_Desc2")
  self._ui.stc_BottomDesc = UI.getChildControl(_panel, "Static_BottomDesc")
  self._ui.txt_Desc3 = UI.getChildControl(self._ui.stc_BottomDesc, "StaticText_1")
  self._ui.stc_GuideImg = UI.getChildControl(_panel, "Static_GuideImage")
  Panel_Global_BlackBackGround:SetAlpha(0.7)
  ConsoleUIOffset:registEventHandler()
end
function ConsoleUIOffset:open()
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoingAlterOfBlood"))
    return
  end
  ConsoleUIOffset._currentOffset = ToClient_GetConsoleUIOffset()
  PaGlobal_ConsoleUIOffset_OnResize()
  ConsoleUIOffset:updateCurrentSquare()
  if nil ~= Panel_Lobby_UserSetting then
    Panel_Global_BlackBackGround:SetAlpha(0.9)
  else
    Panel_Global_BlackBackGround:SetAlpha(0.7)
  end
  _panel:RegisterUpdateFunc("PaGlobal_ConsoleUIOffset_PerframeUpdate")
  _panel:SetShow(true)
  local keyGuide = {
    ConsoleUIOffset._ui.txt_keyGuideA,
    ConsoleUIOffset._ui.txt_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui.stc_BottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_CENTER)
  ConsoleUIOffset._ui.stc_BottomBg:SetPosY(ConsoleUIOffset._ui.stc_BottomDesc:GetPosY() + ConsoleUIOffset._ui.txt_Desc3:GetTextSizeY() + 100)
end
function ConsoleUIOffset:close()
  if nil ~= Panel_Lobby_UserSetting then
    Panel_Global_BlackBackGround:SetAlpha(0.7)
  end
  _panel:SetShow(false)
end
function ConsoleUIOffset:update()
  local offsetWidthSize = getOriginScreenSizeX() * ConsoleUIOffset._currentOffset
  local offsetHeightSize = getOriginScreenSizeY() * ConsoleUIOffset._currentOffset
  ConsoleUIOffset._ui._squareTable[0]:SetPosXY(offsetWidthSize, offsetHeightSize)
  ConsoleUIOffset._ui._squareTable[1]:SetPosXY(getOriginScreenSizeX() - offsetWidthSize - 105, offsetHeightSize)
  ConsoleUIOffset._ui._squareTable[2]:SetPosXY(getOriginScreenSizeX() - offsetWidthSize - 105, getOriginScreenSizeY() - offsetHeightSize - 105)
  ConsoleUIOffset._ui._squareTable[3]:SetPosXY(offsetWidthSize, getOriginScreenSizeY() - offsetHeightSize - 105)
end
function ConsoleUIOffset:updateCurrentSquare()
  local offsetWidthSize = getOriginScreenSizeX() * ConsoleUIOffset._currentOffset
  local offsetHeightSize = getOriginScreenSizeY() * ConsoleUIOffset._currentOffset
  ConsoleUIOffset._ui._currentSquareTable[0]:SetPosXY(offsetWidthSize, offsetHeightSize)
  ConsoleUIOffset._ui._currentSquareTable[1]:SetPosXY(getOriginScreenSizeX() - offsetWidthSize - 105, offsetHeightSize)
  ConsoleUIOffset._ui._currentSquareTable[2]:SetPosXY(getOriginScreenSizeX() - offsetWidthSize - 105, getOriginScreenSizeY() - offsetHeightSize - 105)
  ConsoleUIOffset._ui._currentSquareTable[3]:SetPosXY(offsetWidthSize, getOriginScreenSizeY() - offsetHeightSize - 105)
end
function ConsoleUIOffset:registEventHandler()
  registerEvent("onScreenResize", "PaGlobal_ConsoleUIOffset_OnResize")
  _panel:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_ConsoleUIOffset_Confirm()")
  _panel:ignorePadSnapMoveToOtherPanel()
  _panel:SetOffsetIgnorePanel(true)
  PaGlobal_registerPanelOnBlackBackground(_panel)
end
function PaGlobal_ConsoleUIOffset_PerframeUpdate(deltaTime)
  ConsoleUIOffset:perframeUpdate(deltaTime)
end
function PaGlobal_ConsoleUIOffset_OnResize()
  _panel:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
  _panel:ComputePos()
  ConsoleUIOffset._ui.stc_informationDesc:ComputePos()
  ConsoleUIOffset:updateCurrentSquare()
  ConsoleUIOffset._ui.stc_BottomBg:ComputePos()
  ConsoleUIOffset._ui.stc_BottomDesc:ComputePos()
  ConsoleUIOffset._ui.stc_GuideImg:ComputePos()
  local keyGuidePosX = ConsoleUIOffset._ui._currentSquareTable[2]:GetPosX() + ConsoleUIOffset._ui._currentSquareTable[2]:GetSizeX() - ConsoleUIOffset._ui.stc_BottomBg:GetSpanSize().x - ConsoleUIOffset._ui.stc_BottomBg:GetSizeX()
  local keyGuidePosY = ConsoleUIOffset._ui._currentSquareTable[2]:GetPosY() + ConsoleUIOffset._ui._currentSquareTable[2]:GetSizeY() - ConsoleUIOffset._ui.stc_BottomBg:GetSpanSize().y - ConsoleUIOffset._ui.stc_BottomBg:GetSizeY()
  ConsoleUIOffset._ui.stc_BottomBg:SetPosY(ConsoleUIOffset._ui.stc_BottomDesc:GetPosY() + ConsoleUIOffset._ui.txt_Desc3:GetTextSizeY() + 100)
end
function ConsoleUIOffset:perframeUpdate(deltaTime)
  if isPadPressed(__eJoyPadInputType_RightStick_Up) then
    ConsoleUIOffset._currentOffset = ConsoleUIOffset._currentOffset - deltaTime * ConsoleUIOffset._scrollSpeed
  elseif isPadPressed(__eJoyPadInputType_RightStick_Down) then
    ConsoleUIOffset._currentOffset = ConsoleUIOffset._currentOffset + deltaTime * ConsoleUIOffset._scrollSpeed
  end
  if ConsoleUIOffset._currentOffset < 0 then
    ConsoleUIOffset._currentOffset = 0
  elseif ConsoleUIOffset._maxOffset < ConsoleUIOffset._currentOffset then
    ConsoleUIOffset._currentOffset = ConsoleUIOffset._maxOffset
  end
  ConsoleUIOffset:update()
end
function PaGlobal_ConsoleUIOffset_Confirm()
  ToClient_SetConsoleUIOffset(ConsoleUIOffset._currentOffset, 1 - 2 * ConsoleUIOffset._currentOffset)
  ConsoleUIOffset:close()
  if nil ~= Panel_Lobby_UserSetting then
    PaGlobalFunc_UserSetting_Open()
  end
end
