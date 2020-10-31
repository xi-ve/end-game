function PaGlobal_TradeBiddingGame_All:initialize()
  if true == PaGlobal_TradeBiddingGame_All._initialize or nil == Panel_Dialog_Trade_BiddingGame_All then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._btn_Close = UI.getChildControl(Panel_Dialog_Trade_BiddingGame_All, "Button_Close")
  self._ui._stc_MainBg = UI.getChildControl(Panel_Dialog_Trade_BiddingGame_All, "Static_MainBg")
  self._ui._stc_ImageBg = UI.getChildControl(self._ui._stc_MainBg, "Static_ImageBg")
  self._ui._txt_ProcessMsg = UI.getChildControl(self._ui._stc_MainBg, "StaticText_ProcessMsg")
  self._ui._txt_RetryCount = UI.getChildControl(self._ui._stc_MainBg, "StaticText_RemainCount")
  self._ui._stc_ScalePoll = UI.getChildControl(self._ui._stc_MainBg, "Static_ScaleBalance_Poll")
  self._ui._stc_ScaleArm = UI.getChildControl(self._ui._stc_MainBg, "Static_ScaleBalance_Arm")
  self._ui._stc_ScalePlate_Left = UI.getChildControl(self._ui._stc_MainBg, "Static_ScaleBalance_Plate_Left")
  self._ui._stc_ScalePlate_Right = UI.getChildControl(self._ui._stc_MainBg, "Static_ScaleBalance_Plate_Right")
  self._ui._txt_ResultMsg = UI.getChildControl(self._ui._stc_MainBg, "StaticText_ResultMessage")
  self._ui._btn_LowDice = UI.getChildControl(Panel_Dialog_Trade_BiddingGame_All, "Button_TradeGame_LowDice")
  self._ui._txt_LowDiceDesc = UI.getChildControl(self._ui._btn_LowDice, "StaticText_ButtonDesc")
  self._ui._txt_LowDiceTitle = UI.getChildControl(self._ui._btn_LowDice, "StaticText_ButtonTitle")
  self._ui._btn_HighDice = UI.getChildControl(Panel_Dialog_Trade_BiddingGame_All, "Button_TradeGame_HighDice")
  self._ui._txt_HighDiceDesc = UI.getChildControl(self._ui._btn_HighDice, "StaticText_ButtonDesc")
  self._ui._txt_HighDiceTitle = UI.getChildControl(self._ui._btn_HighDice, "StaticText_ButtonTitle")
  self._ui._stc_DescBg = UI.getChildControl(Panel_Dialog_Trade_BiddingGame_All, "StaticText_DescBg")
  self._ui._txt_Desc = UI.getChildControl(self._ui._stc_DescBg, "StaticText_Desc")
  self._ui._btn_SellAll = UI.getChildControl(Panel_Dialog_Trade_BiddingGame_All, "Button_SellAll")
  self._ui._btn_Retry = UI.getChildControl(Panel_Dialog_Trade_BiddingGame_All, "Button_Retry")
  self._ui._stc_KeyGuide_Console = UI.getChildControl(Panel_Dialog_Trade_BiddingGame_All, "Static_BottomBG_ConsoleUI")
  self._ui._stc_KeyGuide_A = UI.getChildControl(self._ui._stc_KeyGuide_Console, "StaticText_A_ConsoleUI")
  self._ui._stc_KeyGuide_B = UI.getChildControl(self._ui._stc_KeyGuide_Console, "StaticText_B_ConsoleUI")
  self._ui._stc_effectControl = UI.getChildControl(self._ui._stc_MainBg, "Static_Effect")
  PaGlobal_TradeBiddingGame_All:validate()
  PaGlobal_TradeBiddingGame_All:registerEventHandler()
  self._ui._btn_HighDice:SetTextMode(__eTextMode_AutoWrap)
  self._ui._btn_HighDice:SetText("\"" .. PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_TRADEGAME_BUTTONTITLE2") .. "\"")
  self._ui._btn_LowDice:SetTextMode(__eTextMode_AutoWrap)
  self._ui._btn_LowDice:SetText("\"" .. PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_TRADEGAME_BUTTONTITLE1") .. "\"")
  self._ui._txt_ProcessMsg:SetTextMode(__eTextMode_AutoWrap)
  local desc = {
    [0] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TRADEGAME_DESC"),
    [1] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TRADEGAME_DESC1"),
    [2] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TRADEGAME_DESC2"),
    [3] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TRADEGAME_DESC3"),
    [4] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TRADEGAME_DESC4")
  }
  self._ui._txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_Desc:SetText(desc[0] .. "\n" .. desc[1] .. "\n" .. desc[2] .. "\n" .. desc[3] .. "\n" .. desc[4])
  local originSizeY = self._ui._txt_Desc:GetSizeY()
  self._ui._stc_DescBg:SetSize(self._ui._stc_DescBg:GetSizeX(), self._ui._txt_Desc:GetTextSizeY() + 10)
  self._ui._txt_Desc:SetSize(self._ui._txt_Desc:GetSizeX(), self._ui._txt_Desc:GetTextSizeY() + 10)
  local panelY = self._ui._btn_Close:GetSizeY() + self._ui._stc_ImageBg:GetSizeY() + self._ui._btn_LowDice:GetSizeY() + self._ui._stc_DescBg:GetSizeY() + 70
  Panel_Dialog_Trade_BiddingGame_All:SetSize(Panel_Dialog_Trade_BiddingGame_All:GetSizeX(), panelY)
  self._ui._stc_MainBg:SetSize(self._ui._stc_MainBg:GetSizeX(), panelY - (self._ui._btn_Close:GetSizeY() + 20))
  Panel_Dialog_Trade_BiddingGame_All:ComputePos()
  self._halfSizeX = self._ui._stc_ScalePlate_Right:GetSizeX() / 2
  self._leftStartPosX = self._ui._stc_ScalePlate_Left:GetPosX() + self._halfSizeX
  self._leftStartPosY = self._ui._stc_ScalePlate_Left:GetPosY()
  self._rightStartPosX = self._ui._stc_ScalePlate_Right:GetPosX() + self._halfSizeX
  self._rightStartPosY = self._ui._stc_ScalePlate_Right:GetPosY()
  self._centerPosX = self._ui._stc_ScaleArm:GetPosX() + self._ui._stc_ScaleArm:GetSizeX() / 2
  self._centerPosY = self._ui._stc_ScaleArm:GetPosY() + self._ui._stc_ScaleArm:GetSizeY() / 2
  self._ui._stc_KeyGuide_Console:SetShow(self._isConsole)
  self._ui._btn_Retry:SetShow(false)
  self._ui._btn_SellAll:SetShow(not self._isConsole)
  self._ui._btn_Close:SetShow(not self._isConsole)
  Panel_Dialog_Trade_BiddingGame_All:SetDragEnable(not self._isConsole)
  Panel_Dialog_Trade_BiddingGame_All:SetDragAll(not self._isConsole)
  if true == self._isConsole then
    self._ui._stc_KeyGuide_Console:SetPosY(Panel_Dialog_Trade_BiddingGame_All:GetSizeY() - 1)
    local key = {
      self._ui._stc_KeyGuide_A,
      self._ui._stc_KeyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(key, self._ui._stc_KeyGuide_Console, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_TradeBiddingGame_All:validate()
  if true == PaGlobal_TradeBiddingGame_All._initialize or nil == Panel_Dialog_Trade_BiddingGame_All then
    return
  end
  self._ui._btn_Close:isValidate()
  self._ui._stc_MainBg:isValidate()
  self._ui._stc_ImageBg:isValidate()
  self._ui._txt_ProcessMsg:isValidate()
  self._ui._txt_RetryCount:isValidate()
  self._ui._stc_ScalePoll:isValidate()
  self._ui._stc_ScaleArm:isValidate()
  self._ui._stc_ScalePlate_Left:isValidate()
  self._ui._stc_ScalePlate_Right:isValidate()
  self._ui._txt_ResultMsg:isValidate()
  self._ui._btn_LowDice:isValidate()
  self._ui._txt_LowDiceDesc:isValidate()
  self._ui._btn_HighDice:isValidate()
  self._ui._txt_HighDiceDesc:isValidate()
  self._ui._stc_DescBg:isValidate()
  self._ui._txt_Desc:isValidate()
  self._ui._btn_SellAll:isValidate()
  self._ui._btn_Retry:isValidate()
  self._ui._stc_KeyGuide_Console:isValidate()
  self._ui._stc_KeyGuide_A:isValidate()
  self._ui._stc_KeyGuide_B:isValidate()
  self._ui._stc_effectControl:isValidate()
  self._initialize = true
end
function PaGlobal_TradeBiddingGame_All:registerEventHandler()
  if false == PaGlobal_TradeBiddingGame_All._initialize or nil == Panel_Dialog_Trade_BiddingGame_All then
    return
  end
  registerEvent("FromClient_TradeGameStart", "FromClient_TradeBiddingGame_All_GameStart")
  registerEvent("FromClient_TradeGameResult", "FromClient_TradeBiddingGame_All_GameResult")
  registerEvent("FromClient_TradeGameReciveDice", "FromClient_TradeBiddingGame_All_RecieveDice")
  registerEvent("onScreenResize", "FromClient_TradeBiddingGame_All_OnScreenResize")
  if true == self._isConsole then
    self._ui._btn_LowDice:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLup_TradeBiddingGame_All_LowDice()")
    self._ui._btn_HighDice:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLup_TradeBiddingGame_All_HighDice()")
    Panel_Dialog_Trade_BiddingGame_All:ignorePadSnapMoveToOtherPanel()
  else
    self._ui._btn_SellAll:addInputEvent("Mouse_LUp", "HandleEventLUp_TradeMyBasket_All_SellAll()")
    self._ui._btn_Retry:addInputEvent("Mouse_LUp", "HandleEventLup_TradeBiddingGame_All_ResetBiddingGame()")
    self._ui._btn_LowDice:addInputEvent("Mouse_LUp", "HandleEventLup_TradeBiddingGame_All_LowDice()")
    self._ui._btn_HighDice:addInputEvent("Mouse_LUp", "HandleEventLup_TradeBiddingGame_All_HighDice()")
    self._ui._btn_Close:addInputEvent("Mouse_LUp", "HandleEventLup_TradeBiddingGame_All_Close()")
    Panel_Dialog_Trade_BiddingGame_All:addInputEvent("Mouse_On", "PaGlobalFunc_TradeBiddingGame_All_Tooltip()")
    self._ui._btn_LowDice:addInputEvent("Mouse_On", "PaGlobalFunc_TradeBiddingGame_All_Tooltip(0)")
    self._ui._btn_LowDice:addInputEvent("Mouse_Out", "PaGlobalFunc_TradeBiddingGame_All_Tooltip()")
    self._ui._btn_HighDice:addInputEvent("Mouse_On", "PaGlobalFunc_TradeBiddingGame_All_Tooltip(1)")
    self._ui._btn_HighDice:addInputEvent("Mouse_Out", "PaGlobalFunc_TradeBiddingGame_All_Tooltip()")
  end
end
function PaGlobal_TradeBiddingGame_All:resetTradeGameInfo()
  if nil == Panel_Dialog_Trade_BiddingGame_All then
    return
  end
  self._currentDiceValue = 0
  self._minGoalValue = 0
  self._maxGoalValue = 0
  self._updownValue = 1
  self._deltaTimeElapsed = 0
  self._ui._stc_ScaleArm:SetRotate(0)
  self._isRotateSwitch = false
  self._tradeGameSuccess = false
  if false == self._isConsole then
    self._ui._btn_SellAll:SetShow(false)
    self._ui._btn_Retry:SetShow(false)
  end
  self._tradeGameState = self._enTradeGameState._Finish
  self._prevDiceResult = self._enTradeGameResult._Less
end
function PaGlobal_TradeBiddingGame_All:open()
  if nil == Panel_Dialog_Trade_BiddingGame_All or true == Panel_Dialog_Trade_BiddingGame_All:GetShow() then
    return
  end
  Panel_Dialog_Trade_BiddingGame_All:SetShow(true)
end
function PaGlobal_TradeBiddingGame_All:prepareClose()
  if nil == Panel_Dialog_Trade_BiddingGame_All or false == Panel_Dialog_Trade_BiddingGame_All:GetShow() then
    return
  end
  TooltipSimple_Hide()
  SetUIMode(Defines.UIMode.eUIMode_Trade)
  PaGlobal_TradeBiddingGame_All:close()
end
function PaGlobal_TradeBiddingGame_All:close()
  if nil == Panel_Dialog_Trade_BiddingGame_All or false == Panel_Dialog_Trade_BiddingGame_All:GetShow() then
    return
  end
  Panel_Dialog_Trade_BiddingGame_All:SetShow(false)
end
function PaGlobal_TradeBiddingGame_All:onscreenResize()
  if nil == Panel_Dialog_Trade_BiddingGame_All or false == Panel_Dialog_Trade_BiddingGame_All:GetShow() then
    return
  end
  Panel_Dialog_Trade_BiddingGame_All:ComputePos()
end
function PaGlobal_TradeBiddingGame_All:moveControl(rateDeltaTime)
  if nil == Panel_Dialog_Trade_BiddingGame_All then
    return
  end
  PaGlobal_TradeBiddingGame_All._ui._stc_ScaleArm:SetRotate(rateDeltaTime)
  PaGlobal_TradeBiddingGame_All:rotatePlate(self._ui._stc_ScalePlate_Right, self._rightStartPosX, self._rightStartPosY, self._centerPosX, self._centerPosY, rateDeltaTime)
  PaGlobal_TradeBiddingGame_All:rotatePlate(self._ui._stc_ScalePlate_Left, self._leftStartPosX, self._leftStartPosY, self._centerPosX, self._centerPosY, rateDeltaTime)
end
function PaGlobal_TradeBiddingGame_All:rotatePlate(scaleControl, startPosX, startPosY, rotCenterPosX, rotCenterPosY, elpasedDeltaTime)
  if nil == Panel_Dialog_Trade_BiddingGame_All then
    return
  end
  if nil == scaleControl then
    return
  end
  local rotPosX = startPosX - rotCenterPosX
  local rotPosY = startPosY - rotCenterPosY
  local controlPosX = rotPosX * math.cos(elpasedDeltaTime) - rotPosY * math.sin(elpasedDeltaTime)
  local controlPosY = rotPosX * math.sin(elpasedDeltaTime) + rotPosY * math.cos(elpasedDeltaTime)
  scaleControl:SetPosX(controlPosX + rotCenterPosX - PaGlobal_TradeBiddingGame_All._halfSizeX)
  scaleControl:SetPosY(controlPosY + rotCenterPosY)
end
