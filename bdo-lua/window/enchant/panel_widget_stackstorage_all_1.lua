function PaGlobal_StackStorage_All:initialize()
  if true == PaGlobal_StackStorage_All._initialize then
    return
  end
  self._ui.stc_ringBG = UI.getChildControl(Panel_Widget_StackStorage_All, "Static_RingBG")
  self._ui.btn_left = UI.getChildControl(Panel_Widget_StackStorage_All, "Button_Left")
  self._ui.btn_right = UI.getChildControl(Panel_Widget_StackStorage_All, "Button_Right")
  self._ui.template_slot = UI.getChildControl(Panel_Widget_StackStorage_All, "Button_Slot")
  for index = 0, self._defaultCount + 1 do
    local slot = {}
    slot.bg = UI.cloneControl(self._ui.template_slot, self._ui.stc_ringBG, "Button_Slot" .. index)
    slot.totalValue = UI.getChildControl(slot.bg, "StaticText_CurrentValue")
    slot.failValue = UI.getChildControl(slot.bg, "StaticText_BaseValue")
    slot.valksValue = UI.getChildControl(slot.bg, "StaticText_ValksValue")
    slot.overEffect = UI.getChildControl(slot.bg, "Static_Over_Effect")
    slot.clickEffect = UI.getChildControl(slot.bg, "Static_Click_Effect")
    slot.lockSlot = UI.getChildControl(slot.bg, "Static_LockSlot")
    self._ui._slot[index] = slot
    if 0 == index or self._defaultCount + 1 == index then
      slot.bg:SetAlphaExtraChild(0)
    end
  end
  self._ui.template_slot:SetShow(false)
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_StackStorage_All:registEventHandler()
  PaGlobal_StackStorage_All:validate()
  PaGlobal_StackStorage_All._initialize = true
end
function PaGlobal_StackStorage_All:registEventHandler()
  if nil == Panel_Widget_StackStorage_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_StackStorage_All_OnScreenResize")
  registerEvent("FromClient_ResponseEnchantStackSlotList", "PaGlobalFunc_StackStorage_All_Update")
  registerEvent("FromClient_ResponseExpandEnchantStackSlotCount", "PaGlobalFunc_StackStorage_All_Update")
  self._ui.btn_left:addInputEvent("Mouse_LUp", "HandleEventScroll_StackStorage_All_ChangeStartSlot(true)")
  self._ui.btn_right:addInputEvent("Mouse_LUp", "HandleEventScroll_StackStorage_All_ChangeStartSlot(false)")
  for index = 0, self._defaultCount + 1 do
    if false == self._isConsole then
      self._ui._slot[index].bg:addInputEvent("Mouse_UpScroll", "HandleEventScroll_StackStorage_All_ChangeStartSlot(true)")
      self._ui._slot[index].bg:addInputEvent("Mouse_DownScroll", "HandleEventScroll_StackStorage_All_ChangeStartSlot(false)")
      self._ui._slot[index].lockSlot:addInputEvent("Mouse_UpScroll", "HandleEventScroll_StackStorage_All_ChangeStartSlot(true)")
      self._ui._slot[index].lockSlot:addInputEvent("Mouse_DownScroll", "HandleEventScroll_StackStorage_All_ChangeStartSlot(false)")
      self._ui._slot[index].lockSlot:addInputEvent("Mouse_LUp", "PaGlobal_EasyBuy:Open(82)")
    else
      self._ui._slot[index].bg:registerPadEvent(__eConsoleUIPadEvent_RStickLeft, "HandleEventScroll_StackStorage_All_ChangeStartSlot(true)")
      self._ui._slot[index].bg:registerPadEvent(__eConsoleUIPadEvent_RStickRight, "HandleEventScroll_StackStorage_All_ChangeStartSlot(false)")
    end
    self._ui._slot[index].lockSlot:addInputEvent("Mouse_On", "HandleEventOnOut_StackStorage_All_EraseOverEffect(" .. index .. ")")
  end
end
function PaGlobal_StackStorage_All:resize()
  Panel_Widget_StackStorage_All:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Widget_StackStorage_All:ComputePos()
  self._ui.stc_ringBG:ComputePos()
  self._ui.btn_left:ComputePos()
  self._ui.btn_right:ComputePos()
  for index = 0, self._defaultCount + 1 do
    self._ui._slot[index].bg:SetSpanSize(self._defaultPosition[index].x, self._defaultPosition[index].y)
    self._ui._slot[index].bg:ComputePosAllChild()
  end
end
function PaGlobal_StackStorage_All:prepareOpen()
  if nil == Panel_Widget_StackStorage_All then
    return
  end
  audioPostEvent_SystemUi(5, 32)
  _AudioPostEvent_SystemUiForXBOX(5, 32)
  self._aniTime = 0
  self._aniStart = false
  Panel_Widget_StackStorage_All:RegisterUpdateFunc("PaGlobal_StackStorage_All_UpdatePerFrame")
  PaGlobal_StackStorage_All:resize()
  PaGlobal_StackStorage_All:update()
  PaGlobal_StackStorage_All:open()
end
function PaGlobal_StackStorage_All:open()
  if nil == Panel_Widget_StackStorage_All then
    return
  end
  Panel_Widget_StackStorage_All:SetShow(true)
end
function PaGlobal_StackStorage_All:prepareClose()
  if nil == Panel_Widget_StackStorage_All then
    return
  end
  Panel_Widget_StackStorage_All:ClearUpdateLuaFunc()
  PaGlobal_StackStorage_All:close()
end
function PaGlobal_StackStorage_All:close()
  if nil == Panel_Widget_StackStorage_All then
    return
  end
  Panel_Widget_StackStorage_All:SetShow(false)
end
function PaGlobal_StackStorage_All:update()
  local slotSize = ToClient_GetFailCountSlotSize()
  if nil == slotSize then
    return
  end
  for index = 0, self._defaultCount + 1 do
    local slot = self._ui._slot[index]
    if nil ~= slot then
      if 0 == index or self._defaultCount + 1 == index then
        slot.bg:SetIgnore(true)
        slot.lockSlot:SetIgnore(true)
        slot.bg:SetAlphaExtraChild(0)
      else
        slot.bg:SetIgnore(false)
        slot.lockSlot:SetIgnore(false)
        slot.bg:SetAlphaExtraChild(1)
      end
      local currentSlotNo = self._startSlotNo + index - 1
      if slotSize <= currentSlotNo then
        slot.lockSlot:SetShow(true)
        slot.bg:addInputEvent("Mouse_LUp", "")
        slot.bg:addInputEvent("Mouse_On", "")
        slot.bg:addInputEvent("Mouse_Out", "")
      elseif 0 <= currentSlotNo then
        slot.lockSlot:SetShow(false)
        slot.bg:addInputEvent("Mouse_LUp", "HandleEventLUp_StackStorage_All_ChangeFailCountSlot(" .. index .. ", " .. currentSlotNo .. ")")
        slot.bg:addInputEvent("Mouse_On", "HandleEventOnOut_StackStorage_All_ShowDetail(" .. index .. ", " .. currentSlotNo .. ", true)")
        slot.bg:addInputEvent("Mouse_Out", "HandleEventOnOut_StackStorage_All_ShowDetail(" .. index .. ", " .. currentSlotNo .. ", false)")
        local failCount = ToClient_GetSlotFailCount(currentSlotNo)
        local valksCount = ToClient_GetSlotValksCount(currentSlotNo)
        local bonusStackCount = getEnchantInformation():ToClient_getBonusStackCount()
        local totalCount = failCount + valksCount + bonusStackCount
        slot.totalValue:SetText(totalCount)
        slot.totalValue:SetShow(true)
      end
      slot.overEffect:EraseAllEffect()
      slot.failValue:SetShow(false)
      slot.valksValue:SetShow(false)
    end
  end
  self:updateArrowButton(slotSize)
end
function PaGlobal_StackStorage_All:updateArrowButton(slotSize)
  if 0 == self._startSlotNo then
    self._ui.btn_left:SetShow(false)
  else
    self._ui.btn_left:SetShow(true)
  end
  local endSlotNo = self._startSlotNo + self._defaultCount - 1
  if slotSize <= endSlotNo then
    self._ui.btn_right:SetShow(false)
  else
    self._ui.btn_right:SetShow(true)
  end
  if endSlotNo >= self._maxSlotCount - 1 then
    self._ui.btn_right:SetShow(false)
  end
end
function PaGlobal_StackStorage_All:validate()
  if nil == Panel_Widget_StackStorage_All then
    return
  end
  self._ui.template_slot:isValidate()
end
