function HandleEventLUp_RandomBoxSelect_All_Open()
  PaGlobal_RandomBoxSelect_All:prepareOpen()
end
function HandleEventLUp_RandomBoxSelect_All_Close()
  PaGlobal_RandomBoxSelect_All:prepareClose()
end
function HandleEventPadPress_RandomBoxSelect_All_OnPressSpace()
  if nil == Panel_Gacha_Roulette or nil == Panel_RandomBoxSelect_All then
    return
  end
  if PaGlobal_RandomBoxSelect_All.rouletteState == PaGlobal_RandomBoxSelect_All._rouletteState.eRoll then
    HandleEventLUp_RandomBoxSelect_All_OnPressStop()
  elseif PaGlobal_RandomBoxSelect_All.rollMode == 1 and PaGlobal_RandomBoxSelect_All.rouletteState == PaGlobal_RandomBoxSelect_All._rouletteState.ePickAndSlow then
    PaGlobalFunc_RandomBoxSelect_All_ShowResult()
  elseif PaGlobal_RandomBoxSelect_All.rollMode == 1 and PaGlobal_RandomBoxSelect_All.rouletteState == PaGlobal_RandomBoxSelect_All._rouletteState.eResult then
    local isCanContinue = ToClient_IsCanContinueRandomBox()
    if PaGlobal_RandomBoxSelect_All.rollMode == 1 and isCanContinue then
      PaGlobal_RandomBoxSelect_All.rouletteState = PaGlobal_RandomBoxSelect_All._rouletteState.eWaitContinue
      ToClient_ContinueRandomBox()
    else
      PaGlobal_RandomBoxSelect_All:prepareClose()
    end
  end
end
function HandleEventLUp_RandomBoxSelect_All_OnPressSpace()
  if nil == Panel_Gacha_Roulette or nil == Panel_RandomBoxSelect_All then
    return
  end
  if PaGlobal_RandomBoxSelect_All.rouletteState == PaGlobal_RandomBoxSelect_All._rouletteState.eRoll then
    HandleEventLUp_RandomBoxSelect_All_OnPressStop()
  elseif PaGlobal_RandomBoxSelect_All.rouletteState == PaGlobal_RandomBoxSelect_All._rouletteState.ePickAndSlow then
    PaGlobalFunc_RandomBoxSelect_All_ShowResult()
  elseif PaGlobal_RandomBoxSelect_All.rouletteState == PaGlobal_RandomBoxSelect_All._rouletteState.eResult then
    local isCanContinue = ToClient_IsCanContinueRandomBox()
    if PaGlobal_RandomBoxSelect_All.rollMode == 1 and isCanContinue then
      PaGlobal_RandomBoxSelect_All.rouletteState = PaGlobal_RandomBoxSelect_All._rouletteState.eWaitContinue
      ToClient_ContinueRandomBox()
    else
    end
  end
end
function HandleEventLUp_RandomBoxSelect_All_OnPressEscape()
  if nil == Panel_Gacha_Roulette or nil == Panel_RandomBoxSelect_All then
    return
  end
  PaGlobal_RandomBoxSelect_All:close(PaGlobal_RandomBoxSelect_All._ePanelType._modeSelect)
  FromClient_RandomBoxSelect_All_Close()
end
function HandleEventLUp_RandomBoxSelect_All_OnPressStop()
  if nil == Panel_Gacha_Roulette or nil == Panel_RandomBoxSelect_All then
    return
  end
  if true == PaGlobal_RandomBoxSelect_All._isConsole and PaGlobal_RandomBoxSelect_All.rollMode == 0 and PaGlobal_RandomBoxSelect_All.elapsTime < 1.2 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GACHA_ROULETTE_NOTYETFUNCTION"))
    return
  end
  ToClient_StopRandomBox()
end
function HandleEventLUp_RandomBoxSelect_All_Start()
  PaGlobal_RandomBoxSelect_All:checkSelectMode()
  PaGlobal_RandomBoxSelect_All:close(PaGlobal_RandomBoxSelect_All._ePanelType._modeSelect)
  InventoryWindow_Close()
  PaGlobal_RandomBoxSelect_All:gatchaPanelOpen()
end
function HandleEventPadPress_RandomBoxSelect_All_CheckOption(idx)
  PaGlobal_RandomBoxSelect_All._ui.rdo_Normal:SetCheck(false)
  PaGlobal_RandomBoxSelect_All._ui.rdo_Speed:SetCheck(false)
  if 0 == idx then
    PaGlobal_RandomBoxSelect_All._ui.rdo_Normal:SetCheck(true)
  else
    PaGlobal_RandomBoxSelect_All._ui.rdo_Speed:SetCheck(true)
  end
end
function HandleEventLUp_RandomBoxSelect_All_ShowTooltip(isShow)
  if nil == isShow or false == isShow or nil == PaGlobal_RandomBoxSelect_All.pickItemKey then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemStaticStatusWrapper = getItemEnchantStaticStatus(PaGlobal_RandomBoxSelect_All.pickItemKey)
  local slotUi = PaGlobal_RandomBoxSelect_All.slotPool[PaGlobal_RandomBoxSelect_All.pickSlotIndex]
  if nil == itemStaticStatusWrapper then
    return
  end
  Panel_Tooltip_Item_Show(itemStaticStatusWrapper, slotUi.icon, true, false, nil)
end
function PaGlobalFunc_RandomBoxSelect_All_OnScreenResize()
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  Panel_RandomBoxSelect_All:SetPosX(screenX / 2 - Panel_RandomBoxSelect_All:GetSizeX() / 2)
  Panel_RandomBoxSelect_All:SetPosY(screenY / 2 - Panel_RandomBoxSelect_All:GetSizeY() / 2)
  Panel_Gacha_Roulette:SetPosX(screenX / 2 - Panel_Gacha_Roulette:GetSizeX() / 1.3)
  Panel_Gacha_Roulette:SetPosY(screenY / 2 - Panel_Gacha_Roulette:GetSizeY() * 1.1)
  if true == PaGlobal_RandomBoxSelect_All._isConsole then
    local uiOffset = ToClient_GetConsoleUIOffset()
    local resizedRatioX = screenX * uiOffset
    local resizedRatioY = screenY * uiOffset
    Panel_RandomBoxSelect_All:SetPosX(Panel_RandomBoxSelect_All:GetPosX() + resizedRatioX)
    Panel_RandomBoxSelect_All:SetPosY(Panel_RandomBoxSelect_All:GetPosY() + resizedRatioY)
    Panel_Gacha_Roulette:SetPosX(Panel_Gacha_Roulette:GetPosX() + resizedRatioX)
    Panel_Gacha_Roulette:SetPosY(Panel_Gacha_Roulette:GetPosY() + resizedRatioY)
  end
end
function PaGlobalFunc_RandomBoxSelect_All_GetShow()
  if nil == Panel_Gacha_Roulette or nil == Panel_RandomBoxSelect_All then
    return false
  end
  return Panel_Gacha_Roulette:IsShow() or Panel_RandomBoxSelect_All:IsShow()
end
function PaGlobalFunc_RandomBoxSelect_All_AniByDeltaTime(deltaT)
  if nil == Panel_Gacha_Roulette or nil == Panel_RandomBoxSelect_All then
    return
  end
  PaGlobal_RandomBoxSelect_All:aniByDeltaTime(deltaT)
end
function PaGlobalFunc_RandomBoxSelect_All_ShowResult()
  if nil == Panel_Gacha_Roulette or nil == Panel_RandomBoxSelect_All then
    return
  end
  if PaGlobal_RandomBoxSelect_All.rouletteState ~= PaGlobal_RandomBoxSelect_All._rouletteState.eClose then
    PaGlobal_RandomBoxSelect_All.rouletteState = PaGlobal_RandomBoxSelect_All._rouletteState.eResult
  end
  PaGlobal_RandomBoxSelect_All.resultShowTime = 0
  PaGlobal_RandomBoxSelect_All._ui._gachaPanel.effectControl:EraseAllEffect()
  local changeSlot = PaGlobal_RandomBoxSelect_All.slotPool[PaGlobal_RandomBoxSelect_All.pickSlotIndex]
  changeSlot.icon:addInputEvent("Mouse_On", "HandleEventLUp_RandomBoxSelect_All_ShowTooltip( true )")
  local itemWrapper = getItemEnchantStaticStatus(PaGlobal_RandomBoxSelect_All.pickItemKey)
  if PaGlobal_RandomBoxSelect_All.rouletteState ~= PaGlobal_RandomBoxSelect_All._rouletteState.eClose then
    SetUIMode(Defines.UIMode.eUIMode_Gacha_Roulette)
  end
  if nil == itemWrapper then
    UI.ASSERT(nil ~= itemWrapper, "itemWrapper is nil")
    return
  end
  local sendMsg = {
    main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GACHA_ROULETTE_GETITEM", "getName", itemWrapper:getName()),
    sub = "",
    addMsg = ""
  }
  Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(sendMsg, 3.5, 17)
  if ToClient_MessageResultRandomBox ~= nil then
    ToClient_MessageResultRandomBox()
    if false == _ContentsGroup_UsePadSnapping then
      InventoryWindow_Show()
    end
  end
  if PaGlobal_RandomBoxSelect_All.rouletteState ~= PaGlobal_RandomBoxSelect_All._rouletteState.eClose then
    SetUIMode(Defines.UIMode.eUIMode_Gacha_Roulette)
  end
end
function FromClient_RandomBoxSelect_All_Show()
  PaGlobal_RandomBoxSelect_All:dataClear()
  PaGlobal_RandomBoxSelect_All:prepareOpen()
  PaGlobalFunc_RandomBoxSelect_All_OnScreenResize()
end
function FromClient_RandomBoxSelect_All_SelectRandomItem(itemKey)
  if nil == Panel_Gacha_Roulette or nil == Panel_RandomBoxSelect_All then
    return
  end
  local itemWrapper = getItemEnchantStaticStatus(itemKey)
  PaGlobal_RandomBoxSelect_All.pickItemKey = itemKey
  PaGlobal_RandomBoxSelect_All.pickSlotIndex = math.floor(PaGlobal_RandomBoxSelect_All.rollPos) + math.floor(PaGlobal_RandomBoxSelect_All.useSlotCount / 2)
  PaGlobal_RandomBoxSelect_All.pickSlotIndex = PaGlobal_RandomBoxSelect_All.pickSlotIndex % PaGlobal_RandomBoxSelect_All.useSlotCount
  local changeSlot = PaGlobal_RandomBoxSelect_All.slotPool[PaGlobal_RandomBoxSelect_All.pickSlotIndex]
  changeSlot:clearItem()
  changeSlot:setItemByStaticStatus(itemWrapper, 1, -1)
  local totalMovePos = PaGlobal_RandomBoxSelect_All.useSlotCount * 0 + math.floor(PaGlobal_RandomBoxSelect_All.useSlotCount / 2) - 1
  while totalMovePos < PaGlobal_RandomBoxSelect_All.rollSpeedInit do
    totalMovePos = totalMovePos + PaGlobal_RandomBoxSelect_All.useSlotCount
  end
  local posDecimal = PaGlobal_RandomBoxSelect_All.rollPos - math.floor(PaGlobal_RandomBoxSelect_All.rollPos)
  if 0.7 < posDecimal then
    local posDecimalDelta = posDecimal - 0.7
    totalMovePos = totalMovePos - posDecimalDelta
  end
  PaGlobal_RandomBoxSelect_All.rollSpeedAccel = (PaGlobal_RandomBoxSelect_All.rollSpeedMin * PaGlobal_RandomBoxSelect_All.rollSpeedMin - PaGlobal_RandomBoxSelect_All.rollSpeedInit * PaGlobal_RandomBoxSelect_All.rollSpeedInit) / (2 * totalMovePos)
  PaGlobal_RandomBoxSelect_All.rouletteState = PaGlobal_RandomBoxSelect_All._rouletteState.ePickAndSlow
  PaGlobal_RandomBoxSelect_All._ui._gachaPanel.pushSpace:SetShow(false)
  PaGlobal_RandomBoxSelect_All._ui._gachaPanel.notify:SetShow(false)
end
function FromClient_RandomBoxSelect_All_Close()
  if PaGlobal_RandomBoxSelect_All.rouletteState ~= PaGlobal_RandomBoxSelect_All._rouletteState.ePickAndSlow then
    PaGlobal_RandomBoxSelect_All:prepareClose()
  end
end
