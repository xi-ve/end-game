function PaGlobal_MiniGame_Find_All_Open(col, row)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  PaGlobal_MiniGame_Find_All:prepareOpen(col, row)
end
function PaGlobal_MiniGame_Find_All_Close()
  if nil == Panel_MiniGame_Find_All or false == Panel_MiniGame_Find_All:GetShow() then
    return
  end
  PaGlobal_MiniGame_Find_All:prepareClose()
end
function PaGlobal_MiniGame_Find_All_Update(deltaTime)
  if PaGlobal_MiniGame_Find_All._tutorialOpen <= 0 then
    PaGlobal_MiniGame_Find_All:tutorialUpdate(deltaTime)
    return
  end
  PaGlobal_MiniGame_Find_All:noneStateUpdate(deltaTime)
  PaGlobal_MiniGame_Find_All:waitStateUpdate(deltaTime)
  PaGlobal_MiniGame_Find_All:damageSlotUpdate(deltaTime)
end
function HandleEventLUp_Minigame_Find_All_TutorialNextStep()
  if nil == Panel_MiniGame_Find_All then
    return
  end
  for index = 1, PaGlobal_MiniGame_Find_All._tutorialCount do
    PaGlobal_MiniGame_Find_All._ui._tutorial[index]._stc_BG:SetShow(false)
  end
  PaGlobal_MiniGame_Find_All._tutorialIndex = PaGlobal_MiniGame_Find_All._tutorialIndex + 1
  PaGlobal_MiniGame_Find_All._tutorialEffectShow = false
  PaGlobal_MiniGame_Find_All:bubbleShow()
end
function HandleEventLUp_Minigame_Find_All_AskGameClose()
  if PaGlobal_MiniGame_Find_All._state.None == PaGlobal_MiniGame_Find_All._gameState then
    PaGlobal_MiniGame_Find_All_Close()
  else
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_FIND_NOREWARDALERT"),
      functionYes = PaGlobal_MiniGame_Find_All_Close,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function HandleEventOnOut_Minigame_Find_All_CloseSlot(col, row, isOn)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  local slot = PaGlobal_MiniGame_Find_All._slots[col][row]
  if true == slot.isOpen then
    return
  end
  if true == isOn then
    slot.close:SetSize(PaGlobal_MiniGame_Find_All._curSlotSize + 4, PaGlobal_MiniGame_Find_All._curSlotSize + 4)
    slot.close:SetPosX(PaGlobal_MiniGame_Find_All._config._slotStartPosX + PaGlobal_MiniGame_Find_All._curSlotSize * col - 2)
    slot.close:SetPosY(PaGlobal_MiniGame_Find_All._config._slotStartPosY + PaGlobal_MiniGame_Find_All._curSlotSize * row - 2)
  else
    slot.close:SetSize(PaGlobal_MiniGame_Find_All._curSlotSize, PaGlobal_MiniGame_Find_All._curSlotSize)
    slot.close:SetPosX(PaGlobal_MiniGame_Find_All._config._slotStartPosX + PaGlobal_MiniGame_Find_All._curSlotSize * col)
    slot.close:SetPosY(PaGlobal_MiniGame_Find_All._config._slotStartPosY + PaGlobal_MiniGame_Find_All._curSlotSize * row)
  end
end
function HandleEventLUp_Minigame_Find_All_CloseSlot(col, row, clickType)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  local slot = PaGlobal_MiniGame_Find_All._slots[col][row]
  if true == slot.isOpen then
    return
  end
  if PaGlobal_MiniGame_Find_All._clickType.LClcik == clickType then
    audioPostEvent_SystemUi(11, 31)
    _AudioPostEvent_SystemUiForXBOX(11, 31)
  else
    audioPostEvent_SystemUi(11, 32)
    _AudioPostEvent_SystemUiForXBOX(11, 32)
    PaGlobal_MiniGame_Find_All._ui._txt_RClickCnt:AddEffect("fUI_Light", false, 5, 0)
    if 0 >= PaGlobal_MiniGame_Find_All._tmpRClickCount then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MINIGAME_FINDROOT_RCLICKCOUNTTITLE_1"))
      return
    end
  end
  ToClient_MiniGameFindClick(col, row, clickType)
end
function HandleEventOnOut_Minigame_Find_All_ShowItemTooltip(isShow, index)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  if false == isShow or true == PaGlobal_MiniGame_Find_All._isConsole and true == PaGlobalFunc_TooltipInfo_GetShow() then
    if true == PaGlobal_MiniGame_Find_All._isConsole then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  if nil == index then
    index = PaGlobal_MiniGame_Find_All._rewardIndex
  end
  local slot = PaGlobal_MiniGame_Find_All._rewardSlot[index]
  if nil == slot then
    return
  end
  if nil == slot.itemNo then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(slot.itemNo)
  if nil ~= itemSSW then
    if true == PaGlobal_MiniGame_Find_All._isConsole then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.ItemWithoutCompare, 0)
    else
      Panel_Tooltip_Item_SetPosition(index, slot, "minigameFindReward")
      Panel_Tooltip_Item_Show(itemSSW, PaGlobal_MiniGame_Find_All._rewardSlot[index].icon, true)
    end
  end
end
function HandleRSticEventUp_Minigame_Find_All_MoveScroll(isUp)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  local frame = PaGlobal_MiniGame_Find_All._ui._frame_desc
  local scroll = frame:GetVScroll()
  if true == isUp then
    scroll:ControlButtonUp()
  elseif false == isUp then
    scroll:ControlButtonDown()
  end
  frame:UpdateContentPos()
  frame:UpdateContentScroll()
end
function FromClient_Minigame_Find_All_SlotShowEmpty(col, row, uv0, uv1, uv2, uv3, imagePath)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  local slot = PaGlobal_MiniGame_Find_All._slots[col][row]
  local curSlotSize = PaGlobal_MiniGame_Find_All._curSlotSize
  local startPosX = PaGlobal_MiniGame_Find_All._config._slotStartPosX
  local startPosY = PaGlobal_MiniGame_Find_All._config._slotStartPosY
  slot.close:ChangeTextureInfoName(imagePath)
  local xx1, yy1, xx2, yy2 = setTextureUV_Func(slot.close, uv0, uv1, uv2, uv3)
  slot.close:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
  slot.close:setRenderTexture(slot.close:getBaseTexture())
  slot.isOpen = true
  slot.close:setOnMouseCursorType(__eMouseCursorType_Default)
  slot.close:setClickMouseCursorType(__eMouseCursorType_Default)
  slot.close:SetSize(curSlotSize, curSlotSize)
  slot.close:SetPosX(startPosX + curSlotSize * col)
  slot.close:SetPosY(startPosY + curSlotSize * row)
  slot.close:AddEffect("fUI_Minigame_Lbutton", false, 0, 0)
end
function FromClient_Minigame_Find_All_SlotShowMain(col, row)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  local slot = PaGlobal_MiniGame_Find_All._slots[col][row]
  if false == PaGlobal_MiniGame_Find_All._isMainLoad then
    PaGlobal_MiniGame_Find_All._ui._stc_flower:SetPosX(slot.close:GetPosX() - PaGlobal_MiniGame_Find_All._addSize / 2)
    PaGlobal_MiniGame_Find_All._ui._stc_flower:SetPosY(slot.close:GetPosY() - PaGlobal_MiniGame_Find_All._addSize / 2)
    PaGlobal_MiniGame_Find_All._ui._stc_flower:SetShow(true)
    PaGlobal_MiniGame_Find_All._isMainLoad = true
  end
  slot.close:SetEnable(false)
end
function FromClient_Minigame_Find_All_SlotShowMainTexture(mainColCnt, mainRowCnt, uv0, uv1, uv2, uv3, imagePath)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  PaGlobal_MiniGame_Find_All._mainColCnt = mainColCnt
  PaGlobal_MiniGame_Find_All._mainRowCnt = mainRowCnt
  local flowerControl = PaGlobal_MiniGame_Find_All._ui._stc_flower
  flowerControl:ChangeTextureInfoName(imagePath)
  local xx1, yy1, xx2, yy2 = setTextureUV_Func(flowerControl, uv0, uv1, uv2, uv3)
  flowerControl:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
  flowerControl:setRenderTexture(flowerControl:getBaseTexture())
end
function FromClient_Minigame_Find_All_SlotShowSub(col, row, uv0, uv1, uv2, uv3, imagePath, isSuccess)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  local slot = PaGlobal_MiniGame_Find_All._slots[col][row]
  slot.open:ChangeTextureInfoName(imagePath)
  local xx1, yy1, xx2, yy2 = setTextureUV_Func(slot.open, uv0, uv1, uv2, uv3)
  slot.open:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
  slot.open:setRenderTexture(slot.open:getBaseTexture())
  slot.open:SetShow(true)
  slot.open:AddEffect("fUI_Minigame_Lbutton", false, 0, 0)
  if false == isSuccess then
    slot.damage:ChangeTextureInfoName("New_UI_Common_forLua/Window/MiniGame/MiniGameFind_05.dds")
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(slot.damage, uv0, uv1, uv2, uv3)
    slot.damage:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
    slot.damage:setRenderTexture(slot.damage:getBaseTexture())
    slot.damage:SetShow(true)
    table.insert(PaGlobal_MiniGame_Find_All._damageSlot, slot.damage)
  end
end
function FromClient_Minigame_Find_All_SlotShowTrap(col, row, stoneType)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  local slot = PaGlobal_MiniGame_Find_All._slots[col][row]
  slot.open:ChangeTextureInfoName("New_UI_Common_forLua/Window/MiniGame/MiniGameFind_01.dds")
  if 0 == stoneType then
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(slot.open, 1, 295, 54, 348)
    slot.open:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
  else
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(slot.open, 1, 349, 54, 402)
    slot.open:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
  end
  slot.open:setRenderTexture(slot.open:getBaseTexture())
  slot.open:SetShow(true)
  slot.open:AddEffect("fUI_Minigame_Rbutton", false, 0, 0)
  audioPostEvent_SystemUi(11, 34)
  _AudioPostEvent_SystemUiForXBOX(11, 34)
end
function FromClient_Minigame_Find_All_DynamicInfo(damageRate, RClickCount, emptyCount, subObjCount, trapCount)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  local curPercent = damageRate / 10000
  if curPercent <= 0 then
    curPercent = 0
  end
  PaGlobal_MiniGame_Find_All:updateValue(curPercent, RClickCount, true, emptyCount, subObjCount, trapCount)
end
function FromClient_Minigame_Find_All_StaticInfo(damageRate, RClickCount, emptyCount, subObjCount, trapCount, gameCurDepth, gameLastDepth)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  local curPercent = damageRate / 10000
  if curPercent <= 0 then
    curPercent = 0
  end
  PaGlobal_MiniGame_Find_All:updateGameDepth(gameCurDepth, gameLastDepth)
  PaGlobal_MiniGame_Find_All:updateValue(curPercent, 0, false, emptyCount, subObjCount, trapCount)
end
function FromClient_Minigame_Find_All_DefaultImage(col, row, uv0, uv1, uv2, uv3, imagePath)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  local slot = PaGlobal_MiniGame_Find_All._slots[col][row].close
  slot:ChangeTextureInfoName(imagePath)
  local xx1, yy1, xx2, yy2 = setTextureUV_Func(slot, uv0, uv1, uv2, uv3)
  slot:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
  slot:setRenderTexture(slot:getBaseTexture())
end
function FromClient_Minigame_Find_All_SetShow(col, row)
  PaGlobal_MiniGame_Find_All:prepareOpen(col, row)
end
function FromClient_Minigame_Find_All_SetReward(rewardList)
  if nil == Panel_MiniGame_Find_All then
    return
  end
  if nil == rewardList then
    return
  end
  for ii = 0, #rewardList do
    local itemSSW = getItemEnchantStaticStatus(rewardList[ii])
    if nil ~= itemSSW then
      PaGlobal_MiniGame_Find_All._rewardSlot[ii]:setItemByStaticStatus(itemSSW)
      PaGlobal_MiniGame_Find_All._rewardSlot[ii].icon:SetShow(true)
      PaGlobal_MiniGame_Find_All._rewardSlot[ii].itemNo = rewardList[ii]
    end
  end
end
function FromClient_Minigame_Find_All_SetState(serverState, msgKey)
  PaGlobal_MiniGame_Find_All._gameState = serverState
  PaGlobal_MiniGame_Find_All._stateMsgKey = msgKey
  if serverState == PaGlobal_MiniGame_Find_All._state.None then
    PaGlobal_MiniGame_Find_All:endGame()
    PaGlobal_MiniGame_Find_All._readyToEndGame = true
  elseif serverState == PaGlobal_MiniGame_Find_All._state.Wait then
    PaGlobal_MiniGame_Find_All._readyToNextGame = true
  end
  PaGlobal_MiniGame_Find_All:updateStateText(serverState)
  PaGlobal_MiniGame_Find_All._curSec = 0
  Panel_MiniGame_MiniGameResult:SetShow(true)
end
