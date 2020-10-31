function PaGlobalFunc_MentalGame_All_Open()
  PaGlobal_MentalGame_All:prepareOpen()
end
function PaGlobalFunc_MentalGame_All_Close()
  if 0 ~= PaGlobal_MentalGame_All._addIntimacy and _ContentsGroup_UsePadSnapping then
    HandleEventLDown_MentalGame_All_Leave()
    return
  end
  PaGlobal_MentalGame_All:prepareClose()
end
function HandleEventLDown_MentalGame_All_Try()
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  RequestMentalGame_startCard()
  DragManager:clearInfo()
  PaGlobal_MentalGame_All._centerUiList[mentalObject:getOrder(0)].circularProgress:SetProgressRate(100)
  PaGlobal_MentalGame_All._ui_pc.btn_try:SetShow(false)
  Panel_MentalGameTooltip_All:SetShow(false)
end
function HandleEventLDown_MentalGame_All_CardRotation(isLeft)
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  if true == isLeft then
    local totalCard = mentalObject:getCardCount()
    PaGlobal_MentalGame_All._scrollPositionResult = math.max(PaGlobal_MentalGame_All._scrollPositionResult - 5, 0)
  else
    local maxValue = mentalObject:getCardCount() - 5
    PaGlobal_MentalGame_All._scrollPositionResult = math.min(PaGlobal_MentalGame_All._scrollPositionResult + 5, maxValue)
  end
  PaGlobal_MentalGame_All:updateCardScrollButton()
end
function HandleEventLDown_MentalGame_All_Continue()
  PaGlobal_MentalGame_All._gameStep = 0
  PaGlobal_MentalGame_All._bestPoint = 0
  PaGlobal_MentalGame_All:gameStartInit()
  RequestMentalGame_restartCard()
end
function HandleEventUPY_MentalGame_All_Reset()
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  local count = mentalObject:getSlotCount()
  for index = 0, count do
    if mentalObject:getCardBySlotIndex(index) ~= nil then
      RequestMentalGame_clearSelectCard(index)
      _AudioPostEvent_SystemUiForXBOX(0, 2)
    end
  end
end
function HandleEventLDown_MentalGame_All_Leave()
  RequestMentalGame_endGame()
  local mentalStage = RequestMentalGame_getMentalStage()
  if false == mentalStage._isSuccess then
    PaGlobalFunc_MentealGame_All_EndUIProcess()
    return
  end
  PaGlobal_MentalGame_All._gameStep = 4
  PaGlobal_MentalGame_All:updateStateUIShow()
  PaGlobal_MentalGame_All._hideDeltaTime = 0
  PaGlobal_MentalGame_All._endTimechk = 0
  local talker = dialog_getTalker()
  local intimacy = 0
  if nil ~= talker then
    intimacy = talker:getIntimacy()
  end
  local addIntimacyValue = PaGlobal_MentalGame_All._addIntimacy
  local resultIntimacy = intimacy + addIntimacyValue
  local tempString = PAGetStringParam2(Defines.StringSheet_GAME, "MENTALGAME_AQUIRE_INTIMACY_POINT", "result", tostring(resultIntimacy), "point", tostring(addIntimacyValue))
  PaGlobal_MentalGame_All._ui_center.txt_finishResult:SetText(tempString)
  audioPostEvent_SystemUi(4, 3)
  _AudioPostEvent_SystemUiForXBOX(4, 3)
  PaGlobal_MentalGame_All._mentalGame_End = true
end
function HandleEventLDown_MentalGame_All_Card(cardIndex)
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  local cardWrapper = mentalObject:getCard(cardIndex)
  if nil == cardWrapper then
    return
  end
  if true == mentalObject:isSelectedCard(cardWrapper) then
    return
  end
  PaGlobal_MentalGame_All._selectCardIndex = cardIndex
  DragManager:setDragInfo(nil, nil, cardIndex, cardWrapper:getPicture(), nil, nil)
end
function HandleEventRDown_MentalGame_All_Card(cardIndex)
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  if cardIndex < mentalObject:getCardCount() and PaGlobal_MentalGame_All._gameStep < 2 then
    local value = mentalObject:getCard(cardIndex)
    if nil ~= value then
      local staticKey = value:getStaticStatus():getKey()
      if false == mentalObject:isSelectedCard(value) then
        RequestMentalGame_selectCardByKey(staticKey, 99)
        audioPostEvent_SystemUi(0, 2)
        _AudioPostEvent_SystemUiForXBOX(0, 2)
      elseif true == PaGlobal_MentalGame_All._isConsole then
        local getIndex = PaGlobal_MentalGame_All:getCheckApplyKeyIndex(cardIndex)
        if -1 ~= getIndex then
          RequestMentalGame_clearSelectCard(getIndex)
          _AudioPostEvent_SystemUiForXBOX(0, 2)
        end
      end
    end
    PaGlobal_MentalGame_All._selectCardIndex = -1
    DragManager:clearInfo()
  end
end
function HandleEventOnOut_MentalGame_All_CardOver(mouseOverKey, isInserted, isShow)
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobal_MentalGame_All._selectCardIndex = mouseOverKey
  end
  if PaGlobal_MentalGame_All._gameStep < 2 then
    if mouseOverKey == PaGlobal_MentalGame_All._overKey then
      if false == isShow then
        Panel_MentalGameTooltip_All:SetShow(false)
        PaGlobal_MentalGame_All._overKey = -1
      end
    elseif true == isShow then
      local targetUI
      local isSuccess = true
      if true == isInserted then
        isSuccess = PaGlobal_MentalGame_All:updateTooltipContext(mentalObject:getCardBySlotIndex(mouseOverKey), isInserted, mouseOverKey)
        if nil ~= PaGlobal_MentalGame_All._centerUiList[mouseOverKey] then
          targetUI = PaGlobal_MentalGame_All._centerUiList[mouseOverKey].panel
        end
      else
        isSuccess = PaGlobal_MentalGame_All:updateTooltipContext(mentalObject:getCard(mouseOverKey), isInserted, mouseOverKey)
        if nil ~= PaGlobal_MentalGame_All._rightCardList[mouseOverKey] and nil ~= PaGlobal_MentalGame_All._rightCardList[mouseOverKey].ui then
          targetUI = PaGlobal_MentalGame_All._rightCardList[mouseOverKey].ui.cardIcon
        end
      end
      if true == isSuccess then
        Panel_MentalGameTooltip_All:SetShow(true)
        PaGlobal_MentalGame_All._overKey = mouseOverKey
        if nil ~= targetUI then
          Panel_MentalGameTooltip_All:SetPosX(targetUI:GetParentPosX() - (Panel_MentalGameTooltip_All:GetSizeX() - 40))
          Panel_MentalGameTooltip_All:SetPosY(math.max(0, targetUI:GetParentPosY() - (Panel_MentalGameTooltip_All:GetSizeY() - 50)))
        end
      end
    end
  end
  PaGlobal_MentalGame_All._isViewTooltip = isShow
end
function HandleEventPad_MentalGame_All_CardOver(mouseOverKey, isInserted)
  HandleEventOnOut_MentalGame_All_CardOver(mouseOverKey, isInserted, not PaGlobal_MentalGame_All._isViewTooltip)
end
function HandleEventRUp_MentalGame_All_UpdateCenterSlot(key)
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  local value = mentalObject:getCard(PaGlobal_MentalGame_All._selectCardIndex)
  if PaGlobal_MentalGame_All._selectCardIndex < mentalObject:getCardCount() and nil ~= value then
    if false == mentalObject:isSelectedCard(value) then
      audioPostEvent_SystemUi(0, 2)
      _AudioPostEvent_SystemUiForXBOX(0, 2)
    end
    RequestMentalGame_clearSelectCard(key)
    local staticKey = value:getStaticStatus():getKey()
    RequestMentalGame_selectCardByKey(staticKey, key)
    PaGlobal_MentalGame_All._selectCardIndex = -1
    DragManager:clearInfo()
  else
    RequestMentalGame_clearSelectCard(key)
    HandleEventOnOut_MentalGame_All_CardOver(key, true, false)
  end
  if mentalObject:getCardBySlotIndex(key) ~= nil then
    audioPostEvent_SystemUi(0, 2)
    _AudioPostEvent_SystemUiForXBOX(0, 2)
  end
end
function HandleEventLDown_MentalGame_All_MouseInputer()
  PaGlobalFunc_MentalGame_All_SelectCardReset()
end
function HandleEventLUp_MentalGame_All_MouseInputer()
  PaGlobalFunc_MentalGame_All_SelectCardReset()
end
function HandleEventRDown_MentalGame_All_MouseInputer()
  PaGlobal_MentalGame_All._isRdown = true
  PaGlobal_MentalGame_All._rMovePos = {
    x = getMousePosX(),
    y = getMousePosY()
  }
  PaGlobalFunc_MentalGame_All_SelectCardReset()
end
function HandleEventRUp_MentalGame_All_MouseInputer()
  PaGlobal_MentalGame_All._isRdown = false
  PaGlobalFunc_MentalGame_All_SelectCardReset()
end
function HandleEventUpScroll_MentalGame_All_MouseInputer()
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  mentalObject:scaling(0.1)
end
function HandleEventDownScroll_MentalGame_All_MouseInputer()
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  mentalObject:scaling(-0.1)
end
function HandleEventOnOut_MentalGame_All_InformationUIFontAlpha(srcKey, dstKey, alpha, isOver)
  if nil == PaGlobal_MentalGame_All._informationUI[srcKey] or nil == PaGlobal_MentalGame_All._informationUI[srcKey][dstKey] then
    return
  end
  if isOver and 1 < gameStep then
    return
  end
  PaGlobal_MentalGame_All._informationUI[srcKey][dstKey].nameTag:SetFontAlpha(alpha)
end
function HandleOnOutEvent_MentalGame_All_GiftIconTooltip(isShow, index, rewardText)
  if nil == Panel_MentalGameLeft_All then
    return
  end
  if false == isShow then
    PaGlobal_MentalGame_All._ui_left.txt_giftNotice:SetShow(false)
    return
  end
  if nil == PaGlobal_MentalGame_All._giftIcon or nil == PaGlobal_MentalGame_All._giftIcon[index] then
    return
  end
  PaGlobal_MentalGame_All._ui_left.txt_giftNotice:SetText(rewardText)
  PaGlobal_MentalGame_All._ui_left.txt_giftNotice:SetSize(PaGlobal_MentalGame_All._ui_left.txt_giftNotice:GetTextSizeX() + 15, PaGlobal_MentalGame_All._ui_left.txt_giftNotice:GetSizeY())
  PaGlobal_MentalGame_All._ui_left.txt_giftNotice:SetPosX(getMousePosX())
  PaGlobal_MentalGame_All._ui_left.txt_giftNotice:SetPosY(getMousePosY() - 10)
  PaGlobal_MentalGame_All._ui_left.txt_giftNotice:SetShow(true)
end
function FromClient_MentalGame_All_onScreenResize()
  PaGlobal_MentalGame_All:resize()
end
function FromClient_MentalGame_All_startMentalGame()
  PaGlobalFunc_MentalGame_All_Open()
end
function FromClient_MentalGame_All_CloseFunctorRender()
  local isAllClose = PaGlobalFunc_CloseManager_GetisAllClose()
  local isClose = PaGlobal_MentalGame_All:endUIProcessMentalOnly(isAllClose)
  if false == isClose then
    return
  end
  SetUIMode(Defines.UIMode.eUIMode_Default)
  PaGlobal_MentalGame_All._renderMode:reset()
  if true == _ContentsGroup_NewUI_Dialog_All then
    PaGlobalFunc_DialogMain_All_ShowToggle(true)
  elseif true == _ContentsGroup_RenewUI_Dailog then
    PaGlobalFunc_MainDialog_Open()
    PaGlobalFunc_Dialog_Main_CloseNpcTalk()
  else
    Panel_Npc_Dialog:SetShow(true)
    dialog_CloseNpcTalk(true)
  end
  setShowNpcDialog(false)
  setShowLine(true)
  ToClient_PopDialogueFlush()
  PaGlobal_MentalGame_All._mouseInputer:SetAlpha(0)
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_CLOSE_DEFAULT")
end
function FromClient_MentalGame_All_UpdateStage(isNext)
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  local count = mentalObject:getSlotCount()
  for index = 0, count - 1 do
    local cardWrapper = mentalObject:getCardBySlotIndex(index)
    if nil ~= PaGlobal_MentalGame_All._centerUiList[index] and nil ~= PaGlobal_MentalGame_All._centerUiList[index].panel then
      local target = PaGlobal_MentalGame_All._centerUiList[index].panel
      if nil ~= cardWrapper then
        target:ChangeTextureInfoName(cardWrapper:getPicture())
      else
        target:ChangeTextureInfoName("")
      end
      target:SetShow(true)
    end
  end
  local minCardSlotCount = mentalObject:getMinCardSlotCount()
  local filledSlotCount = mentalObject:getFilledSlotCount()
  local selectNeedCount = minCardSlotCount - filledSlotCount
  PaGlobal_MentalGame_All._ui_right.txt_comment2:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DIALOG_MENTALGAME_ALL_NEEDSELECTCNT", "selectNeedCount", selectNeedCount))
  PaGlobal_MentalGame_All._ui_right.txt_mentalCount:SetText(tostring(filledSlotCount) .. "/" .. tostring(minCardSlotCount))
  if minCardSlotCount <= filledSlotCount then
    if 0 == PaGlobal_MentalGame_All._gameStep then
      PaGlobal_MentalGame_All._gameStep = 1
    end
  elseif 1 == PaGlobal_MentalGame_All._gameStep then
    PaGlobal_MentalGame_All._gameStep = 0
  end
  PaGlobal_MentalGame_All:removeCircleLineAndObject()
  PaGlobal_MentalGame_All:insertCircleLineAndObject()
  PaGlobal_MentalGame_All:updateState()
  PaGlobal_MentalGame_All:updateStateUIShow()
  PaGlobal_MentalGame_All:updateCardColor()
  PaGlobal_MentalGame_All:updateCardScrollButton()
  local cardCount = mentalObject:getCardCount()
  for index = 0, cardCount - 1 do
    local cardWrapper = mentalObject:getCard(index)
    if nil ~= PaGlobal_MentalGame_All._rightCardList[index] and nil ~= PaGlobal_MentalGame_All._rightCardList[index].ui and nil ~= PaGlobal_MentalGame_All._rightCardList[index].ui.cardIcon then
      PaGlobal_MentalGame_All._rightCardList[index].ui.cardIcon:SetMonoTone(mentalObject:isBanedCard(cardWrapper))
    end
  end
  if true == isNext then
    PaGlobal_MentalGame_All:updateNextTryEvent()
  end
end
function FromClient_MentalGame_All_TryCard()
  PaGlobal_MentalGame_All._gameStep = 2
  PaGlobal_MentalGame_All:maxPointUpdate()
end
function FromClient_MentalGame_All_EndStage(addedIntimacy)
  PaGlobal_MentalGame_All._gameStep = 3
  local mentalStage = RequestMentalGame_getMentalStage()
  PaGlobal_MentalGame_All:maxPointUpdate()
  if mentalStage._isSuccess then
    PaGlobal_MentalGame_All._addIntimacy = PaGlobal_MentalGame_All._addIntimacy + addedIntimacy
  else
    PaGlobal_MentalGame_All._addIntimacy = 0
  end
  local intimacyText = tostring(PaGlobal_MentalGame_All._addIntimacy)
  if 0 <= addedIntimacy then
    intimacyText = "+" .. intimacyText
  end
  if 0 == addIntimacy then
    PaGlobal_MentalGame_All._ui_pc.btn_leaveDesc:SetText(PAGetString(Defines.StringSheet_GAME, "MENTALGAME_INTIMACY_ACQUIRE_EMPTY"))
    PaGlobal_MentalGame_All._ui_right.txt_intimacyGet:SetText(PAGetString(Defines.StringSheet_GAME, "MENTALGAME_INTIMACY_ACQUIRE_EMPTY"))
  else
    PaGlobal_MentalGame_All._ui_pc.btn_leaveDesc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "MENTALGAME_INTIMACY_ACQUIRE", "count", intimacyText))
    PaGlobal_MentalGame_All._ui_right.txt_intimacyGet:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "MENTALGAME_INTIMACY_ACQUIRE", "count", intimacyText))
  end
  PaGlobal_MentalGame_All:updateState()
  PaGlobal_MentalGame_All:updateStateUIShow()
end
function FromClient_MentalGame_All_UpdateMatrix()
  PaGlobal_MentalGame_All:removeCircleLineAndObject()
  PaGlobal_MentalGame_All:insertCircleLineAndObject()
  PaGlobal_MentalGame_All:updateCenterUIPos(0)
end
function FromClient_MentalGame_All_HideByDead()
  local isClose = PaGlobal_MentalGame_All:endUIProcessMentalOnly(true)
  if false == isClose then
    return
  end
  PaGlobal_MentalGame_All._renderMode:reset()
  if true == _ContentsGroup_NewUI_Dialog_All then
    PaGlobalFunc_DialogMain_All_ShowToggle(true)
  elseif true == _ContentsGroup_RenewUI_Dailog then
    PaGlobalFunc_MainDialog_Open()
    PaGlobalFunc_Dialog_Main_CloseNpcTalk()
  else
    Panel_Npc_Dialog:SetShow(true)
    dialog_CloseNpcTalk(true)
  end
  setShowNpcDialog(false)
  setShowLine(true)
  ToClient_PopDialogueFlush()
  PaGlobal_MentalGame_All._mouseInputer:SetAlpha(0)
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_CLOSE_DEFAULT")
end
function FromClient_MentalGame_All_UpdatePosition(deltaTime)
  PaGlobal_MentalGame_All:updateCenterUIPos(deltaTime)
  PaGlobal_MentalGame_All:updateRotateProcess(deltaTime)
  PaGlobal_MentalGame_All:updateAnimationList(deltaTime)
  PaGlobal_MentalGame_All:updateCenterBackground()
  PaGlobal_MentalGame_All:updateRightUIPos(deltaTime, false)
end
function FromClient_MentalGame_All_UpdateHideTime(deltaTime)
  PaGlobal_MentalGame_All._hideDeltaTime = PaGlobal_MentalGame_All._hideDeltaTime + deltaTime
  if PaGlobal_MentalGame_All._constValue.hideTime <= PaGlobal_MentalGame_All._hideDeltaTime and PaGlobal_MentalGame_All._gameStep == 4 then
    PaGlobalFunc_MentealGame_All_EndUIProcess()
  end
end
function FromClient_MentalGame_All_UpdateEndTimer(deltaTime)
  PaGlobal_MentalGame_All._endTimechk = PaGlobal_MentalGame_All._endTimechk + deltaTime
  if PaGlobal_MentalGame_All._endTimechk > 5 and true == PaGlobal_MentalGame_All._mentalGame_End then
    PaGlobalFunc_MentealGame_All_EndUIProcess()
    PaGlobal_MentalGame_All._mentalGame_End = false
  end
  if PaGlobal_MentalGame_All._endTimechk > 6 then
    PaGlobal_MentalGame_All._endTimechk = 0
  end
end
function FromClient_MentalGame_All_ChangeTarget(fromControl, toControl)
  PaGlobal_MentalGame_All._isViewTooltip = false
  Panel_MentalGameTooltip_All:SetShow(false)
end
function PaGlobalFunc_MentalGame_All_PreClosePanel()
  if false == _ContentsGroup_NewUI_WorkerRandomSelect_All and nil ~= Panel_Window_WorkerRandomSelect then
    Panel_Window_WorkerRandomSelect:SetShow(false, false)
  elseif true == _ContentsGroup_NewUI_WorkerRandomSelect_All then
    HandleEventLUp_WorkerRandomSelect_All_Close()
  end
  if true == _ContentsGroup_NewUI_Dialog_All then
    PaGlobalFunc_DialogMain_All_ShowToggle(false)
  elseif true == _ContentsGroup_RenewUI_Dailog then
    PaGlobalFunc_MainDialog_Close(false)
  else
    Panel_Npc_Dialog:SetShow(false, false)
    FGlobal_ShowRewardList(false)
  end
  if true == _ContentsGroup_NewUI_Dialog_All then
    PaGlobal_Dialogue_Itemtake_All_Close()
  else
    Panel_Dialogue_Itemtake:SetShow(false)
  end
  if false == _ContentsGroup_RenewUI_Skill then
    HandleMLUp_SkillWindow_Close(true)
  end
  if true == _ContentsGroup_NewUI_NpcShop_All and nil ~= HandleEventLUp_NPCShop_ALL_Close then
    HandleEventLUp_NPCShop_ALL_Close()
  elseif true == _ContentsGroup_RenewUI_NpcShop then
    PaGlobalFunc_Dialog_NPCShop_Close()
  else
    NpcShop_WindowClose()
  end
end
function PaGlobalFunc_MentalGame_All_PosUpdateAnimation()
  local mentalObject = getMentalgameObject()
  if nil == mentalObject then
    return
  end
  local currentPoint = mentalObject:getInterestValue()
  PaGlobal_MentalGame_All._bestPoint = math.max(PaGlobal_MentalGame_All._bestPoint, currentPoint)
end
function PaGlobalFunc_MentalGame_All_FontalphaUpdateAnimation(key, value)
  if nil == key or nil == value then
    _PA_ASSERT_NAME(false, "fontalphaUpdateAnimation\236\157\152 \236\157\184\236\158\144\234\176\128 nil\236\158\133\235\139\136\235\139\164", "\236\160\149\236\167\128\237\152\156")
    return
  end
  local playTime = value.endTime - value.startTime
  local halfPlayTime = (value.endTime - value.startTime) / 2
  local inPlayDelta = value.deltaTime - value.startTime
  if value.startTime + halfPlayTime <= value.deltaTime then
    value.ui:SetFontAlpha((playTime - inPlayDelta) / halfPlayTime)
    value.ui:SetAlpha(inPlayDelta / halfPlayTime)
  else
    value.ui:SetFontAlpha(inPlayDelta / halfPlayTime)
    value.ui:SetAlpha(inPlayDelta / halfPlayTime)
  end
end
function PaGlobalFunc_MentalGame_All_SelectCardReset()
  PaGlobal_MentalGame_All._selectCardIndex = -1
  DragManager:clearInfo()
end
function PaGlobalFunc_MentealGame_All_EndUIProcess()
  PaGlobal_MentalGame_All._renderMode:reset()
  SetUIMode(Defines.UIMode.eUIMode_NpcDialog)
  local isClose = PaGlobal_MentalGame_All:endUIProcessMentalOnly(false)
  if false == isClose then
    return
  end
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_CLOSE_DEFAULT")
  if true == _ContentsGroup_NewUI_Dialog_All then
    PaGlobalFunc_DialogMain_All_MentalGameBtnWpUpdate()
    PaGlobalFunc_DialogMain_All_ShowToggle(true)
    HandleEventLUp_DialogMain_All_BackClick()
  elseif true == _ContentsGroup_RenewUI_Dailog then
    PaGlobalFunc_MainDialog_ReOpen()
  else
    FromClient_ShowDialog()
  end
end
