function FromClient_TradeBiddingGame_All_GameStart(minGoal, maxGoal, tryCount, startDice)
  if nil == Panel_Dialog_Trade_BiddingGame_All then
    return
  end
  if true == Panel_NumberPad_IsPopUp() then
    Panel_NumberPad_Close()
  end
  if true == PaGlobal_TradeBiddingGame_All._isConsole then
    Panel_Dialog_Trade_BiddingGame_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  end
  SetUIMode(Defines.UIMode.eUIMode_TradeGame)
  PaGlobal_TradeBiddingGame_All:resetTradeGameInfo()
  PaGlobal_TradeBiddingGame_All._tradeGameSuccess = false
  PaGlobal_TradeBiddingGame_All._isTradeGameEnd = false
  PaGlobal_TradeBiddingGame_All._isLowDiceClicked = nil
  PaGlobal_TradeBiddingGame_All._currentDiceValue = startDice
  PaGlobal_TradeBiddingGame_All._minGoalValue = minGoal
  PaGlobal_TradeBiddingGame_All._maxGoalValue = maxGoal
  PaGlobal_TradeBiddingGame_All._tryCount = tryCount
  PaGlobal_TradeBiddingGame_All._tradeGameState = PaGlobal_TradeBiddingGame_All._enTradeGameState._Play
  PaGlobal_TradeBiddingGame_All._ui._stc_ScalePoll:EraseAllEffect()
  PaGlobal_TradeBiddingGame_All._ui._stc_ScaleArm:EraseAllEffect()
  PaGlobal_TradeBiddingGame_All._ui._txt_ProcessMsg:EraseAllEffect()
  PaGlobal_TradeBiddingGame_All._ui._btn_HighDice:SetShow(true)
  PaGlobal_TradeBiddingGame_All._ui._btn_LowDice:SetShow(true)
  PaGlobal_TradeBiddingGame_All._ui._txt_ResultMsg:SetShow(false)
  PaGlobal_TradeBiddingGame_All._ui._txt_ProcessMsg:SetShow(true)
  PaGlobal_TradeBiddingGame_All._ui._txt_ProcessMsg:SetFontColor(Defines.Color.C_FFDDC39E)
  PaGlobal_TradeBiddingGame_All._ui._txt_ProcessMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TRADEGAME_PROCESSMSG"))
  local remainCount = "<PAColor0xfff5ba3a>" .. tostring(PaGlobal_TradeBiddingGame_All._tryCount) .. "<PAOldColor>"
  PaGlobal_TradeBiddingGame_All._ui._txt_RetryCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEGAME_REMAINCOUNT", "tryCount", remainCount))
  if true == PaGlobal_TradeBiddingGame_All._isConsole then
    PaGlobal_TradeBiddingGame_All._ui._stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CONFIRM"))
    PaGlobalFunc_ConsoleKeyGuide_SetAlign({
      PaGlobal_TradeBiddingGame_All._ui._stc_KeyGuide_A,
      PaGlobal_TradeBiddingGame_All._ui._stc_KeyGuide_B
    }, PaGlobal_TradeBiddingGame_All._ui._stc_KeyGuide_Console, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  if 0 < startDice then
    PaGlobal_TradeBiddingGame_All._prevDiceResult = PaGlobal_TradeBiddingGame_All._enTradeGameResult._More
  else
    PaGlobal_TradeBiddingGame_All._prevDiceResult = PaGlobal_TradeBiddingGame_All._enTradeGameResult._Less
  end
  local startDegree = -30
  startDegree = PaGlobal_TradeBiddingGame_All._FIXED_DEGREE * startDice / 100
  PaGlobal_TradeBiddingGame_All._startRadian = startDegree * math.pi / 180
  PaGlobal_TradeBiddingGame_All._elapsedAngle = startDegree
  PaGlobal_TradeBiddingGame_All:moveControl(PaGlobal_TradeBiddingGame_All._startRadian)
  PaGlobal_TradeBiddingGame_All:open()
  FromClient_TradeBiddingGame_All_OnScreenResize()
end
function FromClient_TradeBiddingGame_All_GameResult(isSuccess)
  if nil == Panel_Dialog_Trade_BiddingGame_All then
    return
  end
  PaGlobal_TradeBiddingGame_All._tradeGameState = PaGlobal_TradeBiddingGame_All._enTradeGameState._Finish
  PaGlobal_TradeBiddingGame_All._ui._txt_ResultMsg:SetShow(true)
  if true == isSuccess then
    audioPostEvent_SystemUi(11, 8)
    _AudioPostEvent_SystemUiForXBOX(11, 8)
    PaGlobal_TradeBiddingGame_All._ui._txt_ProcessMsg:SetFontColor(PaGlobal_TradeBiddingGame_All._COLOR_SUCCESS)
    PaGlobal_TradeBiddingGame_All._ui._txt_ProcessMsg:SetText("\" " .. PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_ALL_RESULT_MSG_SUCCESS") .. " \"")
    PaGlobal_TradeBiddingGame_All._ui._txt_ResultMsg:SetFontColor(PaGlobal_TradeBiddingGame_All._COLOR_SUCCESS)
    PaGlobal_TradeBiddingGame_All._ui._txt_ResultMsg:useGlowFont(false)
    PaGlobal_TradeBiddingGame_All._ui._txt_ResultMsg:useGlowFont(true, "RealFont_35_Glow", PaGlobal_TradeBiddingGame_All._COLOR_GLOW_SUCCESS)
    PaGlobal_TradeBiddingGame_All._ui._txt_ResultMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_ALL_BARGAINING_SUCCESS"))
    PaGlobal_TradeBiddingGame_All._tradeGameSuccess = true
    if true == PaGlobal_TradeBiddingGame_All._isConsole then
      PaGlobal_TradeBiddingGame_All._ui._stc_KeyGuide_A:SetText(PaGlobal_TradeBiddingGame_All._ui._btn_SellAll:GetText())
      PaGlobalFunc_ConsoleKeyGuide_SetAlign({
        PaGlobal_TradeBiddingGame_All._ui._stc_KeyGuide_A,
        PaGlobal_TradeBiddingGame_All._ui._stc_KeyGuide_B
      }, PaGlobal_TradeBiddingGame_All._ui._stc_KeyGuide_Console, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
      Panel_Dialog_Trade_BiddingGame_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_TradeMyBasket_All_SellAll()")
      Panel_Dialog_Trade_MyBasket_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    else
      PaGlobal_TradeBiddingGame_All._ui._btn_SellAll:SetShow(true)
      PaGlobal_TradeBiddingGame_All._ui._btn_Retry:SetShow(false)
    end
    PaGlobalFunc_TradeMyBasket_All_UpdateMySellItem()
    PaGlobal_TradeBiddingGame_All._ui._stc_effectControl:AddEffect("fUI_Discount_Game_Success_01A", true, 0, 0)
  else
    audioPostEvent_SystemUi(11, 9)
    _AudioPostEvent_SystemUiForXBOX(11, 9)
    PaGlobal_TradeBiddingGame_All._ui._txt_ProcessMsg:SetFontColor(PaGlobal_TradeBiddingGame_All._COLOR_FAILED)
    PaGlobal_TradeBiddingGame_All._ui._txt_ProcessMsg:SetText("\" " .. PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_ALL_RESULT_MSG_FAIL") .. " \"")
    PaGlobal_TradeBiddingGame_All._tradeGameSuccess = false
    PaGlobal_TradeBiddingGame_All._ui._txt_ResultMsg:SetFontColor(PaGlobal_TradeBiddingGame_All._COLOR_FAILED)
    PaGlobal_TradeBiddingGame_All._ui._txt_ResultMsg:useGlowFont(false)
    PaGlobal_TradeBiddingGame_All._ui._txt_ResultMsg:useGlowFont(true, "RealFont_35_Glow", PaGlobal_TradeBiddingGame_All._COLOR_GLOW_FAILED)
    PaGlobal_TradeBiddingGame_All._ui._txt_ResultMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_ALL_BARGAINING_FAIL"))
    PaGlobal_TradeBiddingGame_All._ui._stc_effectControl:AddEffect("fUI_Discount_Game_fail_01A", false, 0, 0)
    if true == PaGlobal_TradeBiddingGame_All._isConsole then
      PaGlobal_TradeBiddingGame_All._ui._stc_KeyGuide_A:SetText(PaGlobal_TradeBiddingGame_All._ui._btn_Retry:GetText())
      PaGlobalFunc_ConsoleKeyGuide_SetAlign({
        PaGlobal_TradeBiddingGame_All._ui._stc_KeyGuide_A,
        PaGlobal_TradeBiddingGame_All._ui._stc_KeyGuide_B
      }, PaGlobal_TradeBiddingGame_All._ui._stc_KeyGuide_Console, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
      Panel_Dialog_Trade_BiddingGame_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLup_TradeBiddingGame_All_ResetBiddingGame()")
    else
      PaGlobal_TradeBiddingGame_All._ui._btn_SellAll:SetShow(false)
      PaGlobal_TradeBiddingGame_All._ui._btn_Retry:SetShow(true)
    end
  end
  PaGlobal_TradeBiddingGame_All._ui._txt_ResultMsg:SetVertexAniRun("Ani_Scale_New", true)
  PaGlobal_TradeBiddingGame_All._ui._txt_ResultMsg:AddEffect("fUI_TradeGame_Complete", true, 0, 0)
  PaGlobal_TradeBiddingGame_All._isTradeGameEnd = true
  PaGlobal_TradeBiddingGame_All._ui._btn_HighDice:SetShow(false)
  PaGlobal_TradeBiddingGame_All._ui._btn_LowDice:SetShow(false)
  Panel_Dialog_Trade_MarketItemList_All:SetIgnoreChild(false)
  Panel_Dialog_Trade_MyBasket_All:SetIgnoreChild(false)
end
function FromClient_TradeBiddingGame_All_RecieveDice(diceValue, gameResult)
  if nil == Panel_Dialog_Trade_BiddingGame_All then
    return
  end
  if PaGlobal_TradeBiddingGame_All._enTradeGameResult._NoTryCount == gameResult or PaGlobal_TradeBiddingGame_All._enTradeGameResult._None == gameResult then
    PaGlobal_TradeBiddingGame_All._tradeGameState = PaGlobal_TradeBiddingGame_All._enTradeGameState._Finish
    return
  end
  if PaGlobal_TradeBiddingGame_All._enTradeGameState._Play ~= PaGlobal_TradeBiddingGame_All._tradeGameState then
    return
  end
  PaGlobal_TradeBiddingGame_All._tryCount = PaGlobal_TradeBiddingGame_All._tryCount - 1
  local remainCount = "<PAColor0xfff5ba3a>" .. tostring(PaGlobal_TradeBiddingGame_All._tryCount) .. "<PAOldColor>"
  PaGlobal_TradeBiddingGame_All._ui._txt_RetryCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEGAME_REMAINCOUNT", "tryCount", remainCount))
  if PaGlobal_TradeBiddingGame_All._enTradeGameResult._Less == PaGlobal_TradeBiddingGame_All._prevDiceResult then
    PaGlobal_TradeBiddingGame_All._updownValue = 1
    PaGlobal_TradeBiddingGame_All._isRotateSwitch = true
  end
  if PaGlobal_TradeBiddingGame_All._enTradeGameResult._More == PaGlobal_TradeBiddingGame_All._prevDiceResult then
    PaGlobal_TradeBiddingGame_All._updownValue = -1
    PaGlobal_TradeBiddingGame_All._isRotateSwitch = true
  end
  PaGlobal_TradeBiddingGame_All._prevDiceResult = gameResult
  PaGlobal_TradeBiddingGame_All._elapsedAngle = PaGlobal_TradeBiddingGame_All._elapsedAngle + diceValue / 100 * PaGlobal_TradeBiddingGame_All._FIXED_DEGREE * PaGlobal_TradeBiddingGame_All._updownValue
  PaGlobal_TradeBiddingGame_All._applyRotateValue = PaGlobal_TradeBiddingGame_All._elapsedAngle * math.pi / 180
  PaGlobal_TradeBiddingGame_All._currentDiceValue = PaGlobal_TradeBiddingGame_All._currentDiceValue + diceValue * PaGlobal_TradeBiddingGame_All._updownValue
  local processText = ""
  if true == PaGlobal_TradeBiddingGame_All._isLowDiceClicked then
    if PaGlobal_TradeBiddingGame_All._currentDiceValue > -10 and PaGlobal_TradeBiddingGame_All._currentDiceValue < 10 then
      processText = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEGAME_DICELOWVALUE_1")
    elseif PaGlobal_TradeBiddingGame_All._currentDiceValue > -20 and PaGlobal_TradeBiddingGame_All._currentDiceValue < 20 then
      processText = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEGAME_DICELOWVALUE_2")
    elseif PaGlobal_TradeBiddingGame_All._currentDiceValue > -30 and PaGlobal_TradeBiddingGame_All._currentDiceValue < 30 then
      processText = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEGAME_DICELOWVALUE_3")
    elseif PaGlobal_TradeBiddingGame_All._currentDiceValue > -40 and PaGlobal_TradeBiddingGame_All._currentDiceValue < 40 then
      processText = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEGAME_DICELOWVALUE_4")
    elseif PaGlobal_TradeBiddingGame_All._currentDiceValue > -50 and PaGlobal_TradeBiddingGame_All._currentDiceValue < 50 then
      processText = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEGAME_DICELOWVALUE_5")
    elseif PaGlobal_TradeBiddingGame_All._currentDiceValue > -60 and PaGlobal_TradeBiddingGame_All._currentDiceValue < 60 then
      processText = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEGAME_DICELOWVALUE_6")
    else
      processText = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEGAME_NOINTEREST")
    end
  elseif PaGlobal_TradeBiddingGame_All._currentDiceValue > -10 and PaGlobal_TradeBiddingGame_All._currentDiceValue < 10 then
    processText = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEGAME_DICEHIGHVALUE_1")
  elseif PaGlobal_TradeBiddingGame_All._currentDiceValue > -20 and PaGlobal_TradeBiddingGame_All._currentDiceValue < 20 then
    processText = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEGAME_DICEHIGHVALUE_2")
  elseif PaGlobal_TradeBiddingGame_All._currentDiceValue > -30 and PaGlobal_TradeBiddingGame_All._currentDiceValue < 30 then
    processText = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEGAME_DICEHIGHVALUE_3")
  elseif PaGlobal_TradeBiddingGame_All._currentDiceValue > -40 and PaGlobal_TradeBiddingGame_All._currentDiceValue < 40 then
    processText = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEGAME_DICEHIGHVALUE_4")
  elseif PaGlobal_TradeBiddingGame_All._currentDiceValue > -50 and PaGlobal_TradeBiddingGame_All._currentDiceValue < 50 then
    processText = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEGAME_DICEHIGHVALUE_5")
  elseif PaGlobal_TradeBiddingGame_All._currentDiceValue > -60 and PaGlobal_TradeBiddingGame_All._currentDiceValue < 60 then
    processText = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEGAME_DICEHIGHVALUE_6")
  else
    processText = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEGAME_NOINTEREST")
  end
  PaGlobal_TradeBiddingGame_All._ui._txt_ProcessMsg:SetText("\" " .. processText .. " \"")
end
function FromClient_TradeBiddingGame_All_OnScreenResize()
  if nil == Panel_Dialog_Trade_BiddingGame_All or false == Panel_Dialog_Trade_BiddingGame_All:GetShow() then
    return
  end
  PaGlobal_TradeBiddingGame_All:onscreenResize()
end
function HandleEventLup_TradeBiddingGame_All_Close()
  if nil == Panel_Dialog_Trade_BiddingGame_All or false == Panel_Dialog_Trade_BiddingGame_All:GetShow() then
    return
  end
  PaGlobal_TradeBiddingGame_All:prepareClose()
end
function HandleEventLup_TradeBiddingGame_All_ResetBiddingGame()
  if nil == Panel_Dialog_Trade_BiddingGame_All or false == Panel_Dialog_Trade_BiddingGame_All:GetShow() then
    return
  end
  local talker = dialog_getTalker()
  if nil == talker then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local useStartSlot = inventorySlotNoUserStart()
  local invenUseSize = selfPlayer:get():getInventorySlotCount(true)
  local inventory = selfPlayer:get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
  local invenMaxSize = inventory:sizeXXX()
  local freeCount = inventory:getFreeCount()
  if invenUseSize - useStartSlot <= invenUseSize - freeCount - useStartSlot then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_SELLLIST_DONTPLAYGAME"))
    return
  end
  local wp = selfPlayer:getWp()
  if 0 >= PaGlobalFunc_TradeMyBasket_All_GetCurrentItemCount() then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_TRADEGAME_MSG_2")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_TRADEGAME_MSG_1"),
      content = messageBoxMemo,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  if wp < 5 then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_TRADEGAME_MSG_3")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_TRADEGAME_MSG_1"),
      content = messageBoxMemo,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  local function tradeGameRestartGo()
    if true == PaGlobal_TradeBiddingGame_All._isConsole then
      Panel_Dialog_Trade_BiddingGame_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
    end
    ToClient_TradeGameStart(talker:getActorKey())
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_TRADEGAME_MSG_4") .. " " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERRANDOMSELECT_NOWWP", "getWp", wp)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_TRADEGAME_MSG_1"),
    content = messageBoxMemo,
    functionYes = tradeGameRestartGo,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLup_TradeBiddingGame_All_LowDice()
  if nil == Panel_Dialog_Trade_BiddingGame_All or false == Panel_Dialog_Trade_BiddingGame_All:GetShow() then
    return
  end
  if PaGlobal_TradeBiddingGame_All._enTradeGameState._Play ~= PaGlobal_TradeBiddingGame_All._tradeGameState then
    return
  end
  if true == Panel_NumberPad_IsPopUp() then
    Panel_NumberPad_Close()
  end
  PaGlobal_TradeBiddingGame_All._isLowDiceClicked = true
  ToClient_TradeGameDice(PaGlobal_TradeBiddingGame_All._enTradeGameSwitchType._Small)
end
function HandleEventLup_TradeBiddingGame_All_HighDice()
  if nil == Panel_Dialog_Trade_BiddingGame_All or false == Panel_Dialog_Trade_BiddingGame_All:GetShow() then
    return
  end
  if PaGlobal_TradeBiddingGame_All._enTradeGameState._Play ~= PaGlobal_TradeBiddingGame_All._tradeGameState then
    return
  end
  if true == Panel_NumberPad_IsPopUp() then
    Panel_NumberPad_Close()
  end
  PaGlobal_TradeBiddingGame_All._isLowDiceClicked = false
  ToClient_TradeGameDice(PaGlobal_TradeBiddingGame_All._enTradeGameSwitchType._Large)
end
function PaGlobalFunc_TradeBiddingGame_All_ResetSuccess()
  if nil == Panel_Dialog_Trade_BiddingGame_All then
    return
  end
  PaGlobal_TradeBiddingGame_All._tradeGameSuccess = false
end
function PaGlobalFunc_TradeBiddingGame_All_IsSuccess()
  if nil == Panel_Dialog_Trade_BiddingGame_All then
    return
  end
  return PaGlobal_TradeBiddingGame_All._tradeGameSuccess
end
function PaGlobalFunc_TradeBiddingGame_All_MovePlateByPerFrame(deltaTime)
  if nil == Panel_Dialog_Trade_BiddingGame_All or false == Panel_Dialog_Trade_BiddingGame_All:GetShow() then
    return
  end
  if true == PaGlobal_TradeBiddingGame_All._isRotateSwitch then
    PaGlobal_TradeBiddingGame_All._deltaTimeElapsed = PaGlobal_TradeBiddingGame_All._deltaTimeElapsed + deltaTime * PaGlobal_TradeBiddingGame_All._updownValue
    local tempApplyAngle = PaGlobal_TradeBiddingGame_All._startRadian + PaGlobal_TradeBiddingGame_All._deltaTimeElapsed
    if true == PaGlobal_TradeBiddingGame_All._tradeGameSuccess then
      PaGlobal_TradeBiddingGame_All._applyRotateValue = 0
    end
    if 1 == PaGlobal_TradeBiddingGame_All._updownValue then
      if tempApplyAngle > PaGlobal_TradeBiddingGame_All._applyRotateValue then
        PaGlobal_TradeBiddingGame_All._isRotateSwitch = false
      end
    elseif tempApplyAngle < PaGlobal_TradeBiddingGame_All._applyRotateValue then
      PaGlobal_TradeBiddingGame_All._isRotateSwitch = false
    end
    if false == PaGlobal_TradeBiddingGame_All._isRotateSwitch and true == PaGlobal_TradeBiddingGame_All._tradeGameSuccess then
      tempApplyAngle = 0
    end
    PaGlobal_TradeBiddingGame_All:moveControl(tempApplyAngle)
  end
end
function PaGlobalFunc_TradeBiddingGame_All_Tooltip(type)
  if nil == type then
    TooltipSimple_Hide()
    return
  end
  local control, name
  if 0 == type then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEGAME_WARNNING_BARGAIN")
    control = PaGlobal_TradeBiddingGame_All._ui._btn_LowDice
  else
    name = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEGAME_STRONG_BARGAIN")
    control = PaGlobal_TradeBiddingGame_All._ui._btn_HighDice
  end
  if nil ~= control then
    TooltipSimple_Show(control, name, nil)
  end
end
