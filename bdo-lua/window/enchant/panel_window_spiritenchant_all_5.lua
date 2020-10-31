function PaGlobal_SpiritEnchant_All:bookExtractionTabOpen()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  self:clearBookSlot()
  local failCount = self._enchantInfo:ToClient_getFailCount()
  local valksCount = self._enchantInfo:ToClient_getValksCount()
  local bonusCount = self._enchantInfo:ToClient_getBonusStackCount()
  self:setAsBookExtractionButton()
  self._ui_extraction.txt_valksValue:SetText("+ " .. valksCount)
  self._ui_extraction.txt_plusValue:SetText("+ " .. failCount)
  self._ui_extraction.txt_currentStack:SetText("+ " .. failCount + valksCount + bonusCount)
  self._ui_extraction.txt_resultStack:SetText("")
  self._ui_extraction.txt_extractionDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui_extraction.txt_extractionDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANTEXTRACTION_DESC"))
  self._ui_extraction.txt_extractionDesc:setPadding(CppEnums.Padding.ePadding_Left, 10)
  self._ui_extraction.txt_extractionDesc:setPadding(CppEnums.Padding.ePadding_Top, 5)
  self._ui_extraction.txt_extractionDesc:setPadding(CppEnums.Padding.ePadding_Right, 10)
  self._ui_extraction.txt_extractionDesc:setPadding(CppEnums.Padding.ePadding_Bottom, 5)
  self._ui_extraction.stc_arrowIcon:SetShow(false)
  self._ui_extraction.txt_resultStack:SetShow(false)
  self._ui_pc.btn_extractionGo:SetMonoTone(true)
  self._ui_pc.btn_extractionGo:SetShow(false == self._isConsole)
  self._failCountExtractEnable = false
  if true == self._isConsole then
    Panel_Window_StackExtraction_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandlePadEventY_SpiritEnchant_All_BookExtractionApplyButton()")
  else
    self._ui_pc.btn_extractionGo:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_BookExtractionApplyButton()")
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  Inventory_SetFunctor(PaGlobalFunc_SpiritEnchant_All_FilterForBookExtraction, PaGlobalFunc_SpiritEnchant_All_RClickForEnchantTargetItem, PaGlobalFunc_SpiritEnchant_All_CloseForEnchant, nil)
end
function PaGlobal_SpiritEnchant_All:clearBookSlot()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  self:clearItemSlot(self._slotBookItem)
  self:clearItemSlot(self._slotValksItem)
  self._ui_extraction.chk_skipAni:SetIgnore(false)
  self._enchantInfo = getEnchantInformation()
  self._enchantInfo:ToClient_clearData()
  self._ui_pc.btn_extractionGo:SetMonoTone(true)
  self._grantItemWhereType = nil
  self._grantItemSlotNo = nil
  if true == self._isConsole then
    Panel_Window_StackExtraction_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandlePadEventY_SpiritEnchant_All_BookExtractionApplyButton()")
  end
end
function PaGlobal_SpiritEnchant_All:setBookExtractionTarget(slotNo, itemWrapper, inventoryType)
  if true == self._isAnimating then
    return
  end
  if nil == slotNo or nil == itemWrapper or nil == inventoryType then
    return
  end
  self._isLastEnchant = false
  self:setItemToSlot(self._slotBookItem, slotNo, itemWrapper, inventoryType)
  if false == self._isConsole then
    self._slotBookItem.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_SpiritEnchant_All_BookItemRelease()")
  end
  self._grantItemSlotNo = slotNo
  self._grantItemWhereType = inventoryType
  local failCount = getSelfPlayer():get():getEnchantFailCount()
  if nil ~= self._enchantInfo then
    if 0 < failCount then
      self._ui_pc.btn_extractionGo:SetMonoTone(false)
      self._failCountExtractEnable = true
    else
      self._ui_pc.btn_extractionGo:SetMonoTone(true)
      self._failCountExtractEnable = false
    end
  else
    self._ui_pc.btn_extractionGo:SetMonoTone(true)
    self._failCountExtractEnable = false
  end
  if true == self._failCountExtractEnable then
    local balksItemItemKey
    local itemFailCount = failCount
    if 100 < itemFailCount then
      balksItemItemKey = itemFailCount + 288900
    else
      balksItemItemKey = itemFailCount + 17799
    end
    local balsksItemSSW = getItemEnchantStaticStatus(ItemEnchantKey(balksItemItemKey))
    if nil ~= balsksItemSSW then
      self._slotValksItem.icon:AddEffect("UI_Button_Hide", false, 0, 0)
      self._slotValksItem.empty = false
      self._slotValksItem.icon:SetMonoTone(false)
      self._slotValksItem:setItemByStaticStatus(balsksItemSSW, 1)
    end
  end
end
function PaGlobal_SpiritEnchant_All:setBookExtractionItem(slotNo, itemWrapper, inventoryType)
  if true == self._isAnimating then
    return
  end
  self._isLastEnchant = false
  self:clearBookSlot()
  self:setBookExtractionTarget(slotNo, itemWrapper, inventoryType)
end
function PaGlobal_SpiritEnchant_All:setAsBookExtractionButton()
  if false == self._isConsole then
    self._ui_pc.btn_extractionGo:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANTEXTRACTION_TITLE"))
  else
    self._ui_console.stc_exractionGoY:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANTEXTRACTION_TITLE"))
    self._ui_console.stc_exractionGoY:SetMonoTone(false)
    Panel_Window_StackExtraction_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandlePadEventY_SpiritEnchant_All_BookExtractionApplyButton()")
  end
end
function PaGlobal_SpiritEnchant_All:bookExtractionApplyButton()
  if true == self._isAnimating then
    if false == self._isConsole then
      self:cancleBookExtraction()
    end
    return
  end
  local failCount = getSelfPlayer():get():getEnchantFailCount()
  if true == self._slotBookItem.empty or 0 == failCount then
    return
  end
  local itemWrapper = getInventoryItemByType(self._grantItemWhereType, self._grantItemSlotNo)
  if nil == itemWrapper then
    return
  end
  local function goExtraction()
    if not self._ui_extraction.chk_skipAni:IsCheck() then
      self:startBookExtractionAnimation()
    else
      self:startBookExtraction()
    end
  end
  local failCount = getSelfPlayer():get():getEnchantFailCount()
  local enchantParam1 = itemWrapper:getStaticStatus():getContentsEventParam1()
  local messageBoxMemo = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_ENCHANTCOUNTEXTRACTION_MSGDESC", "enchantParam", enchantParam1, "failCount", failCount, "failCount2", failCount)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANTCOUNTEXTRACTION_MSGTITLE"),
    content = messageBoxMemo,
    functionYes = goExtraction,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_SpiritEnchant_All:cancleBookExtraction()
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
  self:removeBookExtractionEffect()
  self:setAsBookExtractionButton()
  audioPostEvent_SystemUi(5, 99)
  _AudioPostEvent_SystemUiForXBOX(5, 99)
  self._ui_extraction.chk_skipAni:SetIgnore(false)
  ToClient_BlackspiritEnchantCancel()
end
function PaGlobal_SpiritEnchant_All:removeBookExtractionEffect()
  self._ui_extraction.stc_imageSecretBook:EraseAllEffect()
end
function PaGlobal_SpiritEnchant_All:startBookExtractionAnimation()
  self._effectTime = self._originEffectTime
  self._startTime = self._effectTime - 1.5
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
  self._ui_extraction.stc_imageSecretBook:AddEffect("fUI_BlackBook_01A", false)
  self:setAsCancelButton()
  audioPostEvent_SystemUi(5, self._audio._book_idxB)
  _AudioPostEvent_SystemUiForXBOX(5, self._audio._book_idxB)
  self._animationTimeStamp = 0
  self._isAnimating = true
  self._isStart = false
end
function PaGlobal_SpiritEnchant_All:startBookExtraction()
  if nil == self._grantItemSlotNo or nil == self._grantItemWhereType then
    return
  end
  ToClient_ConvertEnchantFailCountToItem(self._grantItemWhereType, self._grantItemSlotNo)
end
