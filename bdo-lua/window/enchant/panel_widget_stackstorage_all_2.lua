function PaGlobalFunc_StackStorage_All_Open()
  PaGlobal_StackStorage_All:prepareOpen()
end
function PaGlobalFunc_StackStorage_All_Close()
  PaGlobal_StackStorage_All:prepareClose()
end
function PaGlobalFunc_StackStorage_All_Toggle()
  if true == Panel_Widget_StackStorage_All:GetShow() then
    PaGlobalFunc_StackStorage_All_Close()
  else
    PaGlobalFunc_StackStorage_All_Open()
  end
end
function PaGlobalFunc_StackStorage_All_GetShow()
  return Panel_Widget_StackStorage_All:GetShow()
end
function PaGlobalFunc_StackStorage_All_Update()
  PaGlobal_StackStorage_All:update()
end
function PaGlobal_StackStorage_All_UpdatePerFrame(deltaTime)
  if false == PaGlobal_StackStorage_All._aniStart then
    return
  end
  local isRight = PaGlobal_StackStorage_All._isRightAni
  local endIndex = PaGlobal_StackStorage_All._defaultCount + 1
  if 1 > PaGlobal_StackStorage_All._aniTime then
    PaGlobal_StackStorage_All._aniTime = PaGlobal_StackStorage_All._aniTime + deltaTime * 4
    for index = 0, endIndex do
      local slot = PaGlobal_StackStorage_All._ui._slot[index]
      local position = PaGlobal_StackStorage_All._defaultPosition
      if nil ~= slot then
        local diffX = 0
        local diffY = 0
        local showAni = true
        if true == isRight then
          if endIndex == index then
            showAni = false
            slot.bg:SetAlphaExtraChild(0)
          elseif 0 == index then
            slot.bg:SetAlphaExtraChild(PaGlobal_StackStorage_All._aniTime)
          elseif endIndex - 1 == index then
            slot.bg:SetAlphaExtraChild(1 - PaGlobal_StackStorage_All._aniTime)
          else
            slot.bg:SetAlphaExtraChild(1)
          end
          if true == showAni then
            diffX = position[index + 1].x - position[index].x
            diffY = position[index + 1].y - position[index].y
          end
        else
          if 0 == index then
            showAni = false
            slot.bg:SetAlphaExtraChild(0)
          elseif 1 == index then
            slot.bg:SetAlphaExtraChild(1 - PaGlobal_StackStorage_All._aniTime)
          elseif endIndex == index then
            slot.bg:SetAlphaExtraChild(PaGlobal_StackStorage_All._aniTime)
          else
            slot.bg:SetAlphaExtraChild(1)
          end
          if true == showAni then
            diffX = position[index - 1].x - position[index].x
            diffY = position[index - 1].y - position[index].y
          end
        end
        if true == showAni then
          local currentPosX = position[index].x + diffX * PaGlobal_StackStorage_All._aniTime
          local currentPosY = position[index].y + diffY * PaGlobal_StackStorage_All._aniTime
          if true == isRight then
            if currentPosX > position[index + 1].x then
              currentPosX = position[index + 1].x
              currentPosY = position[index + 1].y
            end
          elseif currentPosX < position[index - 1].x then
            currentPosX = position[index - 1].x
            currentPosY = position[index - 1].y
          end
          slot.bg:SetSpanSize(currentPosX, currentPosY)
          slot.bg:ComputePosAllChild()
        end
      end
    end
  else
    PaGlobal_StackStorage_All._aniStart = false
    PaGlobal_StackStorage_All._aniTime = 0
    if true == isRight then
      for index = endIndex, 0, -1 do
        local slot = PaGlobal_StackStorage_All._ui._slot[index]
        local temp
        if nil ~= slot then
          if endIndex == index then
            temp = slot[endIndex]
          elseif 0 == index then
            slot[index] = temp
          else
            slot[index] = slot[index - 1]
          end
        end
      end
      PaGlobal_StackStorage_All._startSlotNo = PaGlobal_StackStorage_All._startSlotNo - 1
    else
      for index = 0, endIndex do
        local slot = PaGlobal_StackStorage_All._ui._slot[index]
        local temp
        if nil ~= slot then
          if 0 == index then
            temp = slot[0]
          elseif endIndex == index then
            slot[index] = temp
          else
            slot[index] = slot[index + 1]
          end
        end
      end
      PaGlobal_StackStorage_All._startSlotNo = PaGlobal_StackStorage_All._startSlotNo + 1
    end
    PaGlobal_StackStorage_All:resize()
    PaGlobalFunc_StackStorage_All_Update()
  end
end
function HandleEventLUp_StackStorage_All_ChangeFailCountSlot(uiIndex, changeSlotNo)
  if false == _ContentsGroup_FamilyStack then
    return
  end
  if nil == changeSlotNo then
    return
  end
  if true == PaGlobalFunc_SpiritEnchant_All_GetIsAnimating() then
    return
  end
  if toInt64(0, 0) < ToClient_GetRemainSwapEnchantStackSlotCoolTime() then
    return
  end
  ToClient_RequestSwapEnchantStackSlot(changeSlotNo)
  audioPostEvent_SystemUi(5, 34)
  _AudioPostEvent_SystemUiForXBOX(5, 34)
  if nil == uiIndex then
    return
  end
  local slot = PaGlobal_StackStorage_All._ui._slot[uiIndex]
  if nil == slot then
    return
  end
  slot.clickEffect:EraseAllEffect()
  slot.clickEffect:AddEffect("fUI_StackChange_Click_01A", false, 0, 0)
  PaGlobalFunc_SpiritEnchant_All_StackChangeEffect()
end
function HandleEventOnOut_StackStorage_All_ShowDetail(uiIndex, slotNo, isShow)
  if nil == uiIndex or nil == slotNo then
    return
  end
  local slot = PaGlobal_StackStorage_All._ui._slot[uiIndex]
  if nil == slot then
    return
  end
  local failCount = ToClient_GetSlotFailCount(slotNo)
  local valksCount = ToClient_GetSlotValksCount(slotNo)
  slot.overEffect:EraseAllEffect()
  if true == isShow then
    slot.failValue:SetShow(true)
    slot.valksValue:SetShow(true)
    slot.totalValue:SetShow(false)
    slot.failValue:SetText(failCount)
    slot.valksValue:SetText(valksCount)
    slot.overEffect:AddEffect("fUI_StackChange_MouseOver_01A", true, 0, 0)
  else
    slot.failValue:SetShow(false)
    slot.valksValue:SetShow(false)
    slot.totalValue:SetShow(true)
    local bonusStackCount = getEnchantInformation():ToClient_getBonusStackCount()
    local totalCount = failCount + valksCount + bonusStackCount
    slot.totalValue:SetText(totalCount)
  end
  if true == PaGlobal_StackStorage_All._isConsole then
    PaGlobalFunc_SpiritEnchant_All_ShowRstickKeyGuide(isShow)
  end
end
function HandleEventOnOut_StackStorage_All_EraseOverEffect(uiIndex)
  if nil == uiIndex then
    return
  end
  local slot = PaGlobal_StackStorage_All._ui._slot[uiIndex]
  if nil == slot then
    return
  end
  slot.overEffect:EraseAllEffect()
end
function HandleEventScroll_StackStorage_All_ChangeStartSlot(isUp)
  if true == PaGlobalFunc_SpiritEnchant_All_GetIsAnimating() then
    return
  end
  local slotSize = ToClient_GetFailCountSlotSize()
  local isChanged = false
  if true == isUp then
    if 0 < PaGlobal_StackStorage_All._startSlotNo then
      isChanged = true
    end
  elseif nil ~= slotSize then
    local endSlotNo = PaGlobal_StackStorage_All._startSlotNo + PaGlobal_StackStorage_All._defaultCount - 1
    if slotSize > endSlotNo then
      isChanged = true
    end
    if endSlotNo >= PaGlobal_StackStorage_All._maxSlotCount - 1 then
      isChanged = false
    end
  end
  if true == isChanged then
    audioPostEvent_SystemUi(5, 35)
    _AudioPostEvent_SystemUiForXBOX(5, 35)
    PaGlobalFunc_StackStorage_All_Update()
    PaGlobal_StackStorage_All._aniStart = true
    PaGlobal_StackStorage_All._isRightAni = isUp
    for index = 1, 2 do
      local slotIndex = 0
      local slotNo = 0
      if 1 == index then
        slotIndex = 0
        slotNo = PaGlobal_StackStorage_All._startSlotNo - 1
      else
        slotIndex = PaGlobal_StackStorage_All._defaultCount + 1
        slotNo = PaGlobal_StackStorage_All._startSlotNo + PaGlobal_StackStorage_All._defaultCount
      end
      local slot = PaGlobal_StackStorage_All._ui._slot[slotIndex]
      if nil ~= slot then
        slot.bg:SetSpanSize(PaGlobal_StackStorage_All._defaultPosition[slotIndex].x, PaGlobal_StackStorage_All._defaultPosition[slotIndex].y)
        slot.bg:ComputePosAllChild()
        slot.bg:SetAlphaExtraChild(0)
        if 0 <= slotNo and slotSize >= slotNo then
          local failCount = ToClient_GetSlotFailCount(slotNo)
          local valksCount = ToClient_GetSlotValksCount(slotNo)
          local bonusStackCount = getEnchantInformation():ToClient_getBonusStackCount()
          local totalCount = failCount + valksCount + bonusStackCount
          slot.totalValue:SetText(totalCount)
          slot.totalValue:SetShow(true)
        end
      end
    end
    for index = 0, PaGlobal_StackStorage_All._defaultCount + 1 do
      local slot = PaGlobal_StackStorage_All._ui._slot[index]
      if nil ~= slot then
        slot.overEffect:EraseAllEffect()
      end
    end
  end
end
function FromClient_StackStorage_All_OnScreenResize()
  if nil == Panel_Widget_StackStorage_All or false == Panel_Widget_StackStorage_All:GetShow() then
    return
  end
  PaGlobal_StackStorage_All:resize()
end
