function PaGlobal_SpiritEnchant_All:darkExtractionTabOpen()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  self._enchantInfo = getEnchantInformation()
  self._enchantInfo:ToClient_clearData()
  self:clearDarkSlot()
  local failCount = self._enchantInfo:ToClient_getFailCount()
  local valksCount = self._enchantInfo:ToClient_getValksCount()
  local bonusCount = self._enchantInfo:ToClient_getBonusStackCount()
  self._ui_extraction.txt_valksValue:SetText("+ " .. valksCount)
  self._ui_extraction.txt_plusValue:SetText("+ " .. failCount)
  self._ui_extraction.txt_currentStack:SetText("+ " .. failCount + valksCount + bonusCount)
  self._ui_extraction.txt_resultStack:SetText("")
  self._ui_extraction.txt_stackRate:SetText("")
  self._ui_extraction.txt_extractionDesc:SetTextMode(__eTextMode_AutoWrap)
  if false == self._isConsole then
    self._ui_extraction.txt_extractionDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_EATENCHANT_DESCRIPTION_FORSTACK"))
  elseif true == _ContentsGroup_EatEnchant and true == _ContentsGroup_EatStackEnchant then
    self._ui_extraction.txt_extractionDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_EATENCHANT_DESCRIPTION_FORSTACK"))
  else
    self._ui_extraction.txt_extractionDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_EATENCHANT_DESCRIPTION"))
  end
  self._ui_extraction.txt_extractionDesc:setPadding(CppEnums.Padding.ePadding_Left, 10)
  self._ui_extraction.txt_extractionDesc:setPadding(CppEnums.Padding.ePadding_Top, 5)
  self._ui_extraction.txt_extractionDesc:setPadding(CppEnums.Padding.ePadding_Right, 10)
  self._ui_extraction.txt_extractionDesc:setPadding(CppEnums.Padding.ePadding_Bottom, 5)
  self._ui_extraction.stc_arrowIcon:SetShow(false)
  self._ui_extraction.txt_resultStack:SetShow(false)
  self._ui_pc.btn_extractionGo:SetMonoTone(true)
  self._ui_pc.btn_extractionGo:SetShow(false == self._isConsole)
  if true == self._isConsole then
    Panel_Window_StackExtraction_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandlePadEventY_SpiritEnchant_All_DarkPredationApplyButton()")
  else
    self._ui_pc.btn_extractionGo:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_DarkPredationApplyButton()")
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  Inventory_SetFunctor(PaGlobalFunc_SpiritEnchant_All_FilterForDarkPredationItem, PaGlobalFunc_SpiritEnchant_All_RClickForEnchantTargetItem, PaGlobalFunc_SpiritEnchant_All_CloseForEnchant, nil)
end
function PaGlobal_SpiritEnchant_All:clearDarkSlot()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  self:clearItemSlot(self._slotDarkItem)
  self:setAsDarkPredationButton()
  self._grantItemWhereType = nil
  self._grantItemSlotNo = nil
  self._ui_extraction.txt_stackRate:SetText("")
  self._ui_extraction.txt_resultStack:SetText("")
  self._ui_extraction.stc_arrowIcon:SetShow(false)
  self._ui_extraction.txt_resultStack:SetShow(false)
  self._ui_pc.btn_extractionGo:SetMonoTone(true)
  self._ui_extraction.chk_skipAni:SetIgnore(false)
  if true == self._isConsole then
    Panel_Window_StackExtraction_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandlePadEventY_SpiritEnchant_All_DarkPredationApplyButton()")
  end
end
function PaGlobal_SpiritEnchant_All:setDarkPredationTarget(slotNo, itemWrapper, inventoryType, resultType, isMonotone)
  if true == self._isAnimating then
    return
  end
  self._enchantInfo = getEnchantInformation()
  self._enchantInfo:ToClient_clearData()
  if true ~= ToClient_Inventory_AvailFeedItem(inventoryType, slotNo) then
    return false
  end
  self:setItemToSlot(self._slotDarkItem, slotNo, itemWrapper, inventoryType)
  if false == self._isConsole then
    self._slotDarkItem.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_SpiritEnchant_All_DarkPredationItemRelease()")
  end
  self._grantItemSlotNo = slotNo
  self._grantItemWhereType = inventoryType
  local failCount = self._enchantInfo:ToClient_getFailCount()
  local valksCount = self._enchantInfo:ToClient_getValksCount()
  local bonusCount = self._enchantInfo:ToClient_getBonusStackCount()
  local getEnchantValue = 0
  if true == _ContentsGroup_EatStackEnchant then
    local rate = Int64toInt32(ToClient_getEnchantFailCountRateResult(inventoryType, slotNo))
    getEnchantValue = ToClient_getEnchantFailCountStackResult(inventoryType, slotNo)
    self._ui_extraction.stc_arrowIcon:SetShow(true)
    self._ui_extraction.txt_resultStack:SetShow(true)
    if 0 < rate then
      self._ui_extraction.txt_resultStack:SetText("+" .. tostring(failCount + 1 + valksCount + bonusCount))
      self._ui_extraction.txt_stackRate:SetText(string.format("%.1f", rate / CppDefine.e1Percent) .. "%")
      self._darkPredationRate = rate
    else
      self._ui_extraction.txt_resultStack:SetText("+" .. tostring(getEnchantValue + valksCount + bonusCount))
      self._ui_extraction.txt_stackRate:SetText("100%")
      self._darkPredationRate = 100
    end
    self._ui_pc.btn_extractionGo:SetMonoTone(false)
  else
    getEnchantValue = ToClient_Inventory_GetItemEnchantValue(inventoryType, slotNo)
    if 0 == failCount then
      self._ui_pc.btn_extractionGo:SetMonoTone(false)
    else
      self._ui_pc.btn_extractionGo:SetMonoTone(true)
    end
    self._ui_extraction.txt_stackRate:SetText("+" .. getEnchantValue)
  end
  self._darkPredationValue = getEnchantValue
  return true
end
function PaGlobal_SpiritEnchant_All:setDarkPredationItem(slotNo, itemWrapper, inventoryType)
  if true == self._isAnimating then
    return
  end
  self._isLastEnchant = false
  self:clearDarkSlot()
  self:setDarkPredationTarget(slotNo, itemWrapper, inventoryType, nil, true)
end
function PaGlobal_SpiritEnchant_All:setAsDarkPredationButton()
  if false == self._isConsole then
    self._ui_pc.btn_extractionGo:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_EATENCHANT"))
  else
    self._ui_console.stc_exractionGoY:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_EATENCHANT"))
    self._ui_console.stc_exractionGoY:SetMonoTone(false)
    Panel_Window_StackExtraction_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandlePadEventY_SpiritEnchant_All_DarkPredationApplyButton()")
  end
end
function PaGlobal_SpiritEnchant_All:darkPredationApplyButton()
  if self._isAnimating then
    if false == self._isConsole then
      self:cancleDarkPredation()
    end
    return
  else
    if true == self._slotDarkItem.empty then
      return
    end
    local failCount = self._enchantInfo:ToClient_getFailCount()
    local getEnchantValue = self._darkPredationValue
    local rate = self._darkPredationRate
    local msgTitle = ""
    local msgStr = ""
    local messageBoxData
    local function EatEnchant_ForMessageBox()
      if not self._ui_extraction.chk_skipAni:IsCheck() then
        self:startPredationAnimation()
      else
        self:startdarkPredationItem()
      end
    end
    if failCount == getEnchantValue then
      msgTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EATENCHANT_BUTTON_GETSTACK")
      msgStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EATENCHANT_STACK_MSGBOX", "percent", string.format("%.1f", rate / CppDefine.e1Percent))
    else
      msgTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RADIOBTNTITLE_3_EATENCHANT")
      msgStr = PAGetString(Defines.StringSheet_GAME, "LUA_EATENCHANT_MSGBOXTEXT")
    end
    messageBoxData = {
      title = msgTitle,
      content = msgStr,
      functionYes = EatEnchant_ForMessageBox,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function PaGlobal_SpiritEnchant_All:startPredationAnimation()
  self:addPredationEnchantEffect()
  self:setAsCancelButton()
  ToClient_BlackspiritEnchantStart()
  self._animationTimeStamp = 0
  self._isAnimating = true
  if true == _ContentsGroup_NewUI_Dialog_All and nil ~= Panel_Npc_Dialog_All then
    Panel_Npc_Dialog_All:SetIgnoreChild(true)
  elseif nil ~= Panel_Npc_Dialog then
    Panel_Npc_Dialog:SetIgnoreChild(true)
  end
  self._ui_extraction.btn_subRadio[1]:SetIgnore(true)
  self._ui_extraction.btn_subRadio[2]:SetIgnore(true)
  for i = 1, #self._ui.btn_mainRadio do
    self._ui.btn_mainRadio[i]:SetIgnore(true)
  end
  audioPostEvent_SystemUi(5, 6)
  _AudioPostEvent_SystemUiForXBOX(5, 6)
  audioPostEvent_SystemUi(5, self._audio._dark_idxB)
  _AudioPostEvent_SystemUiForXBOX(5, self._audio._dark_idxB)
end
function PaGlobal_SpiritEnchant_All:addPredationEnchantEffect()
  self._effectTime = self._originEffectTime
  self._startTime = self._effectTime - 1.5
  self._ui_extraction.stc_imageDarkPredation:EraseAllEffect()
  self._ui_extraction.stc_imageDarkPredation:AddEffect("fUI_DarkGluttony_01A", true, 0, 0)
end
function PaGlobal_SpiritEnchant_All:startdarkPredationItem()
  ToClient_Inventory_feedItem(self._grantItemWhereType, self._grantItemSlotNo)
end
function PaGlobal_SpiritEnchant_All:cancleDarkPredation()
  self._isAnimating = false
  if true == _ContentsGroup_NewUI_Dialog_All and nil ~= Panel_Npc_Dialog_All then
    Panel_Npc_Dialog_All:SetIgnoreChild(false)
  elseif nil ~= Panel_Npc_Dialog then
    Panel_Npc_Dialog:SetIgnoreChild(false)
  end
  self._ui_extraction.btn_subRadio[1]:SetIgnore(false)
  self._ui_extraction.btn_subRadio[2]:SetIgnore(false)
  for i = 1, #self._ui.btn_mainRadio do
    self._ui.btn_mainRadio[i]:SetIgnore(false)
  end
  self:removeDarkPredationEffect()
  self:setAsDarkPredationButton()
  audioPostEvent_SystemUi(5, 99)
  _AudioPostEvent_SystemUiForXBOX(5, 99)
  self._ui_extraction.chk_skipAni:SetIgnore(false)
  ToClient_BlackspiritEnchantCancel()
end
function PaGlobal_SpiritEnchant_All:removeDarkPredationEffect()
  self._ui_extraction.stc_imageDarkPredation:EraseAllEffect()
  self._slotDarkItem.icon:EraseAllEffect()
end
function PaGlobal_SpiritEnchant_All:darkPredationResult()
  if self._currentMainTab ~= self._MAIN_TAB.EXTRACTION or self._currentSubTab ~= self._SUB_TAB.DARK then
    return
  end
  local failCount = self._enchantInfo:ToClient_getFailCount()
  local valksCount = self._enchantInfo:ToClient_getValksCount()
  local bonusCount = self._enchantInfo:ToClient_getBonusStackCount()
  self._ui_extraction.txt_valksValue:SetText("+ " .. valksCount)
  self._ui_extraction.txt_plusValue:SetText("+ " .. failCount)
  self._ui_extraction.txt_currentStack:SetText("+ " .. failCount + valksCount + bonusCount)
  self:clearDarkSlot()
  self:setAsDarkPredationButton()
  if 100 == self._darkPredationRate then
    audioPostEvent_SystemUi(5, 22)
    _AudioPostEvent_SystemUiForXBOX(5, 22)
    PaGlobal_SpiritEnchant_All:showEnchantResultNakMessage(true, PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NEWENCHANT_RESULT_SUCCESSEATTING", "value", self._darkPredationValue))
    ToClient_BlackspiritEnchantSuccess()
  end
end
