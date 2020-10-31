function PaGlobal_SpiritEnchant_All:enchantTabOpen()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  self._enchantInfo = getEnchantInformation()
  self._enchantInfo:ToClient_clearData()
  self:clearEnchantSlot()
  local failCount = self._enchantInfo:ToClient_getFailCount()
  local valksCount = self._enchantInfo:ToClient_getValksCount()
  local bonusCount = self._enchantInfo:ToClient_getBonusStackCount()
  self._ui_enchant.stc_image:SetShow(true)
  self._ui_enchant.stc_image2:SetShow(false)
  self._ui_enchant.stc_wingTop:SetShow(false)
  self._ui_enchant.stc_wingBottom:SetShow(false)
  self._ui_enchant.stc_buttonArea:SetShow(true)
  self._ui_enchant.radio_enchantNormal:SetShow(false)
  self._ui_enchant.radio_enchantPerfect:SetShow(false)
  self._ui_enchant.chk_enchantForce:SetShow(false)
  self._ui_enchant.chk_enchantCron:SetIgnore(true)
  self._ui_enchant.chk_enchantCron:SetMonoTone(true, true)
  self._ui_enchant.chk_skipAni:SetShow(true)
  self._ui_pc.btn_enchantGo:SetShow(false == self._isConsole)
  self._ui_enchant.txt_subTitle:SetShow(true)
  self._ui_enchant.txt_subTitleValue:SetShow(true)
  self._ui_enchant.txt_valks:SetShow(true)
  self._ui_enchant.txt_valksValue:SetShow(true)
  self._ui_enchant.txt_plus:SetShow(true)
  self._ui_enchant.txt_plusValue:SetShow(true)
  self._ui_pc.btn_enchantGo:SetMonoTone(true)
  self._isAbleEnchant = false
  self._ui_enchant.stc_bg:SetSize(self._ui_enchant.stc_bg:GetSizeX(), self._const.bottomBgMaxSizeY)
  self._ui_enchant.stc_bg:ComputePos()
  self._ui_enchant.stc_wingsInfo[1].count:SetShow(false)
  self._ui_enchant.radio_enchantNormal:SetCheck(true)
  self._ui_enchant.radio_enchantPerfect:SetCheck(false)
  self._ui_enchant.chk_enchantForce:SetCheck(false)
  self._ui_enchant.chk_enchantCron:SetCheck(false)
  self._ui_enchant.txt_enchantRate:SetShow(false)
  self._ui_enchant.txt_enchantDesc:SetSpanSize(self._ui_enchant.txt_enchantDesc:GetSpanSize().x, self._const.kindDescSpnaMidY)
  self._ui_enchant.txt_enchantDesc:ComputePos()
  self._ui_enchant.txt_enchantDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui_enchant.txt_enchantDesc:SetShow(false)
  self._ui_enchant.txt_enchantDesc:SetText("")
  self._ui_enchant.stc_noticeBar:SetShow(true)
  self._ui_enchant.stc_noticeBar:SetTextMode(__eTextMode_AutoWrap)
  self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_SETEQUIPMENT"))
  self._ui_enchant.txt_valksValue:SetText("+ " .. valksCount)
  self._ui_enchant.txt_plusValue:SetText("+ " .. failCount)
  self._ui_enchant.txt_subTitleValue:SetText("+ " .. failCount + valksCount + bonusCount)
  self:setText_NumOfCron(0, 0)
  self._isMaterialSlotMonotone = false
  if true == self._isConsole then
    Panel_Window_StackExtraction_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandlePadEventY_SpiritEnchant_All_EnchantApplyButton()")
  else
    self._ui_pc.btn_enchantGo:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_EnchantApplyButton()")
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  Inventory_SetFunctor(PaGlobalFunc_SpiritEnchant_All_FilterForEnchantTarget, PaGlobalFunc_SpiritEnchant_All_RClickForEnchantTargetItem, PaGlobalFunc_SpiritEnchant_All_CloseForEnchant, nil)
  self._randomEffectNum = 0
end
function PaGlobal_SpiritEnchant_All:clearEnchantSlot()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  self:clearItemSlot(self._slotEquip.slot)
  self:clearItemSlot(self._slotMateiralInfo[1])
  self:clearItemSlot(self._slotMateiralInfo[2])
  self:clearItemSlot(self._slotMateiralInfo[3])
  self:setAsEnchantButton()
  self._ui_enchant.radio_enchantNormal:SetIgnore(false)
  self._ui_enchant.radio_enchantPerfect:SetIgnore(false)
  self._ui_enchant.chk_enchantForce:SetIgnore(false)
  self._ui_enchant.chk_skipAni:SetIgnore(false)
  self._ui_enchant.chk_enchantCron:SetIgnore(true)
  self._ui_enchant.chk_enchantCron:SetMonoTone(true, true)
  self._grantItemWhereType = nil
  self._grantItemSlotNo = nil
  self._enchantInfo:ToClient_clearData()
  self._ui_enchant.txt_enchantRate:SetShow(false)
  self._isLastEnchant = false
end
function PaGlobal_SpiritEnchant_All:init_EnchantFrame()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  self._ui_enchant.stc_buttonArea:SetShow(true)
  self._ui_enchant.radio_enchantNormal:SetShow(false)
  self._ui_enchant.radio_enchantPerfect:SetShow(false)
  self._ui_enchant.chk_enchantForce:SetShow(false)
  self._ui_enchant.chk_enchantCron:SetShow(true)
  self._ui_enchant.txt_enchantDesc:SetShow(true)
  self._ui_enchant.txt_enchantDesc:SetText("")
  self._ui_enchant.chk_skipAni:SetShow(true)
  self._ui_pc.btn_enchantGo:SetShow(false == self._isConsole)
  self._ui_pc.btn_enchantGo:SetMonoTone(true)
  self._isAbleEnchant = false
  self._ui_enchant.stc_bg:SetSize(self._ui_enchant.stc_bg:GetSizeX(), self._const.bottomBgMidSizeY)
  self._ui_enchant.stc_bg:ComputePos()
  self._isWaitingServer = false
end
function PaGlobal_SpiritEnchant_All:showEnchantDifficulty()
  local rate = ToClient_getEnchantSuccessRate(self._ui_enchant.chk_enchantForce:IsCheck(), self._ui_enchant.radio_enchantPerfect:IsCheck(), __eEnchantFailCountSlotNo_Undefined)
  if -1 ~= rate then
    local enchantPercentString = string.format("%.2f", rate / CppDefine.e100Percent * 100)
    self._ui_enchant.txt_enchantRate:SetShow(true)
    self._ui_enchant.txt_enchantRate:SetText(enchantPercentString .. "%")
    self._currentEnchantRate = rate / CppDefine.e100Percent * 100
  else
    self._ui_enchant.txt_enchantRate:SetShow(false)
  end
end
function PaGlobal_SpiritEnchant_All:setEnchantFailCount()
  if nil == self._enchantInfo then
    self._enchantInfo = getEnchantInformation()
    self._enchantInfo:ToClient_clearData()
  end
  local failCount = self._enchantInfo:ToClient_getFailCount()
  local valksCount = self._enchantInfo:ToClient_getValksCount()
  local bonusStackCount = self._enchantInfo:ToClient_getBonusStackCount()
  local failCountUpRate = Int64toInt32(self._enchantInfo:ToClient_getFailCountUpRate())
  self._ui_enchant.txt_valksValue:SetText("+ " .. valksCount)
  self._ui_enchant.txt_plusValue:SetText("+ " .. failCount)
  self._ui_enchant.txt_subTitleValue:SetText("+ " .. failCount + valksCount + bonusStackCount)
end
function PaGlobal_SpiritEnchant_All:didsetEnchantTarget(isMonotone, isRadioClick)
  local itemWrapper = getInventoryItemByType(self._grantItemWhereType, self._grantItemSlotNo)
  if nil == itemWrapper then
    return
  end
  local enchantItemClassify = itemWrapper:getStaticStatus():getItemClassify()
  local enchantLevel = itemWrapper:get():getKey():getEnchantLevel()
  local enchantType = self._enchantInfo:ToClient_getEnchantType()
  local needCountForPerfectEnchant_s64 = self._enchantInfo:ToClient_getNeedCountForPerfectEnchant_s64()
  local cur_MaxEndura = self._enchantInfo:ToClient_getCurMaxEndura()
  local dec_MaxEndura = self._enchantInfo:ToClient_getDecMaxEndura()
  self._strForEnchantInfo._notChecked = self:getStr_EnchantInfo(cur_MaxEndura, dec_MaxEndura, enchantType)
  PaGlobal_SpiritEnchant_All:setCronEnchant()
  if needCountForPerfectEnchant_s64 > toInt64(0, 0) then
    self._ui_enchant.chk_enchantForce:SetShow(true)
    self._isShow_forceEnchant = true
    self._ui_enchant.chk_enchantForce:ComputePos()
    local enduranceDesc = self:getStr_EnchantInfo(cur_MaxEndura, dec_MaxEndura, enchantType, true)
    self._strForEnchantInfo._forcedChecked = enduranceDesc .. self:getStr_PerfectEnchantInfo(needCountForPerfectEnchant_s64, self._enchantInfo:ToClient_getDecMaxEnduraPerfect())
    if true == self._ui_enchant.chk_enchantForce:IsCheck() then
      self._ui_enchant.radio_enchantPerfect:SetCheck(false)
      self._ui_enchant.radio_enchantNormal:SetCheck(false)
    end
  else
    self._ui_enchant.chk_enchantForce:SetShow(false)
    self._ui_enchant.chk_enchantForce:SetCheck(false)
    self._isShow_forceEnchant = false
  end
  if 0 == self._enchantInfo:ToClient_checkIsValidDifficultEnchant() then
    self._ui_enchant.radio_enchantPerfect:SetShow(true)
    self._ui_enchant.radio_enchantNormal:SetShow(true)
    self._isShow_perfectEnchant = true
    self._ui_enchant.chk_enchantCron:SetIgnore(true)
    self._ui_enchant.chk_enchantCron:SetMonoTone(true, true)
    self._ui_enchant.stc_wingTop:SetShow(false)
    self._ui_enchant.stc_wingsInfo[2].slot:SetShow(false)
    self._ui_enchant.stc_wingsInfo[2].count:SetShow(false)
    self._isShow_cronEnchant = false
    self:setText_EnchantInfo()
  else
    self._ui_enchant.radio_enchantPerfect:SetShow(false)
    self._ui_enchant.radio_enchantNormal:SetShow(false)
    self._isShow_perfectEnchant = false
  end
  if true == self._isSetNewPerfectItemMaterial then
    self._isShow_cronEnchant = false
    self._isShow_forceEnchant = false
    self._isShow_perfectEnchant = false
    self._ui_enchant.chk_enchantCron:SetIgnore(true)
    self._ui_enchant.chk_enchantCron:SetMonoTone(true, true)
    self._ui_enchant.stc_wingTop:SetShow(false)
    self._ui_enchant.stc_wingsInfo[2].slot:SetShow(false)
    self._ui_enchant.stc_wingsInfo[2].count:SetShow(false)
    self:setText_NumOfCron(0, 0)
    self._ui_enchant.chk_enchantForce:SetShow(false)
    self._ui_enchant.chk_enchantForce:SetCheck(false)
    self._ui_enchant.radio_enchantPerfect:SetShow(false)
    self._ui_enchant.radio_enchantNormal:SetShow(false)
  end
  if true == self._isShow_forceEnchant or true == self._isShow_perfectEnchant then
    self._ui_enchant.stc_buttonArea:SetShow(true)
    self._ui_enchant.stc_bg:SetSize(self._ui_enchant.stc_bg:GetSizeX(), self._const.bottomBgOriSizeY)
    self._ui_enchant.stc_bg:ComputePos()
    self._ui_enchant.txt_enchantDesc:SetSpanSize(self._ui_enchant.txt_enchantDesc:GetSpanSize().x, self._const.kindDescSpnaMidY)
    self._ui_enchant.txt_enchantDesc:ComputePos()
  elseif true == self._isShow_cronEnchant then
    self._ui_enchant.stc_buttonArea:SetShow(true)
    self._ui_enchant.stc_bg:SetSize(self._ui_enchant.stc_bg:GetSizeX(), self._const.bottomBgMidSizeY)
    self._ui_enchant.stc_bg:ComputePos()
    self._ui_enchant.txt_enchantDesc:SetSpanSize(self._ui_enchant.txt_enchantDesc:GetSpanSize().x, self._const.kindDescSpnaMidY - self._ui_enchant.stc_buttonArea:GetSizeY())
    self._ui_enchant.txt_enchantDesc:ComputePos()
  else
    self._ui_enchant.stc_buttonArea:SetShow(true)
    self._ui_enchant.stc_bg:SetSize(self._ui_enchant.stc_bg:GetSizeX(), self._const.bottomBgMidSizeY)
    self._ui_enchant.stc_bg:ComputePos()
    self._ui_enchant.txt_enchantDesc:SetSpanSize(self._ui_enchant.txt_enchantDesc:GetSpanSize().x, self._const.kindDescSpnaMidY)
    self._ui_enchant.txt_enchantDesc:ComputePos()
  end
  if nil == isRadioClick then
    self:setCheckEnchantInfo(isMonotone)
  end
  if true == self._isMaterialSlotMonotone then
    self._ui_pc.btn_enchantGo:SetMonoTone(true)
    self._isAbleEnchant = false
  end
  self:setButtonAlign()
  self:resizePanel()
end
function PaGlobal_SpiritEnchant_All:setCronEnchant()
  local itemWrapper = getInventoryItemByType(self._grantItemWhereType, self._grantItemSlotNo)
  local enchantItemClassify = itemWrapper:getStaticStatus():getItemClassify()
  local enchantLevel = itemWrapper:get():getKey():getEnchantLevel()
  local enchantType = self._enchantInfo:ToClient_getEnchantType()
  local cur_MaxEndura = self._enchantInfo:ToClient_getCurMaxEndura()
  local dec_MaxEndura = self._enchantInfo:ToClient_getDecMaxEndura()
  local isStackLessBlackStone = itemWrapper:getStaticStatus():isNeedStackLessBlackStonForEnchant()
  if (16 < enchantLevel or 4 == enchantItemClassify) and false == isStackLessBlackStone and toInt64(0, 0) < self._enchantInfo:ToClient_getNeedCountForProtect_s64() and false == self._isSetNewPerfectItemMaterial then
    self._ui_enchant.chk_enchantCron:SetIgnore(false)
    self._ui_enchant.chk_enchantCron:SetMonoTone(false)
    self._ui_enchant.stc_wingTop:SetShow(true)
    self._ui_enchant.stc_wingsInfo[2].slot:SetShow(true)
    self._ui_enchant.stc_wingsInfo[2].count:SetShow(true)
    self._isShow_cronEnchant = true
    self:setText_NumOfCron(self._enchantInfo:ToClient_getCountProtecMaterial_s64(), self._enchantInfo:ToClient_getNeedCountForProtect_s64())
    local enduranceDesc = self:getStr_EnchantInfo(cur_MaxEndura, dec_MaxEndura, enchantType, true)
    self._strForEnchantInfo._cronChecked = enduranceDesc .. self:getStr_EnchantProtectInfo(enchantType)
  else
    self._ui_enchant.chk_enchantCron:SetIgnore(true)
    self._ui_enchant.chk_enchantCron:SetMonoTone(true, true)
    self._ui_enchant.stc_wingTop:SetShow(false)
    self._ui_enchant.stc_wingsInfo[2].slot:SetShow(false)
    self._ui_enchant.stc_wingsInfo[2].count:SetShow(false)
    self._isShow_cronEnchant = false
    self:setText_NumOfCron(0, 0)
  end
end
function PaGlobal_SpiritEnchant_All:setButtonAlign()
  local isButtonShow = {
    self._isShow_perfectEnchant,
    self._isShow_forceEnchant
  }
  local count = 0
  for ii = 1, 3 do
    if isButtonShow[ii] then
      count = count + 1
    end
  end
  if 0 == count then
    return
  end
  if self._isShow_perfectEnchant then
    count = count + 1
  end
  local standardSizeX = (590 - 5 * (count - 1)) / count
  local standardSizeY = self._ui_enchant.stc_buttonArea:GetSizeY()
  local standardPosX = self._ui_enchant.radio_enchantNormal:GetPosX()
  self._ui_enchant.radio_enchantNormal:SetSize(standardSizeX, standardSizeY)
  self._ui_enchant.radio_enchantPerfect:SetSize(standardSizeX, standardSizeY)
  self._ui_enchant.chk_enchantForce:SetSize(standardSizeX, standardSizeY)
  if self._isShow_perfectEnchant then
    self._ui_enchant.radio_enchantNormal:SetPosX(standardPosX)
    self._ui_enchant.radio_enchantPerfect:SetPosX(self._ui_enchant.radio_enchantNormal:GetPosX() + standardSizeX + 5)
    self._ui_enchant.chk_enchantForce:SetPosX(self._ui_enchant.radio_enchantPerfect:GetPosX() + standardSizeX + 5)
  elseif not self._isShow_forceEnchant then
  else
    self._ui_enchant.chk_enchantForce:SetPosX(standardPosX)
  end
end
function PaGlobal_SpiritEnchant_All:setCheckEnchantInfo(isMonotone, isReload)
  if true == isMonotone then
    return
  end
  if nil == self._materialItemSlotNo or nil == self._materialItemWhereType then
    self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_SETMATERIAL"))
    return
  end
  if 0 ~= self._enchantInfo:ToClient_setEnchantSlot(self._materialItemWhereType, self._materialItemSlotNo) and true ~= isReload then
    return
  end
  if nil == self._enchantInfo or nil == self._grantItemSlotNo or nil == self._grantItemWhereType then
    self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_SETEQUIPMENT"))
    self._ui_enchant.txt_enchantDesc:SetText("")
    return
  end
  if true == self._isSetNewPerfectItemMaterial then
    if 0 < self._enchantInfo:ToClient_getDecMaxEnduraNewPerfect() then
      local str = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NEWENCHANT_100PERCENT_PENALTY", "maxEndurance", tostring(self._enchantInfo:ToClient_getDecMaxEnduraNewPerfect()), "currentEndurance", tostring(self._enchantInfo:ToClient_getCurMaxEndura()))
      self._ui_enchant.stc_noticeBar:SetText(str)
    else
      self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_100PERCENT"))
    end
    self._ui_enchant.txt_enchantDesc:SetText("")
    self:showEnchantDifficulty()
  else
    self:setText_EnchantInfo()
  end
  if isReload then
    return
  end
  local itemWrapper = getInventoryItemByType(self._materialItemWhereType, self._materialItemSlotNo)
  self:setItemToSlot(self._slotMateiralInfo[1], self._materialItemSlotNo, itemWrapper, self._materialItemWhereType)
end
function PaGlobal_SpiritEnchant_All:setText_EnchantInfo()
  if true == self._isShow_forceEnchant and true == self._ui_enchant.chk_enchantForce:IsCheck() then
    self._ui_enchant.stc_noticeBar:SetText(self._strForEnchantInfo._forcedChecked)
  elseif true == self._isShow_cronEnchant and true == self._ui_enchant.chk_enchantCron:IsCheck() then
    self._ui_enchant.stc_noticeBar:SetText(self._strForEnchantInfo._cronChecked)
  else
    self._ui_enchant.stc_noticeBar:SetText(self._strForEnchantInfo._notChecked)
  end
  if nil == self._materialItemSlotNo or nil == self._materialItemWhereType or 0 == self._slotMateiralInfo[1].slotNo or __eTInventorySlotNoUndefined == self._slotMateiralInfo[1].inventoryType then
    self._ui_enchant.stc_noticeBar:SetText(self._ui_enchant.stc_noticeBar:GetText() .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_SETMATERIAL"))
  end
  local textSizeY = self._ui_enchant.stc_noticeBar:GetTextSizeY()
  local gabY = 10
  if self._originEnchnatNoticeBgSizeY < textSizeY + gabY then
    local addSizeY = textSizeY + gabY - self._originEnchnatNoticeBgSizeY
    self._ui_enchant.stc_noticeBar:SetSize(self._ui_enchant.stc_noticeBar:GetSizeX(), self._originEnchnatNoticeBgSizeY + addSizeY)
    self._ui_enchant.stc_noticeBar:SetPosY(self._originEnchnatNoticeBgPosY - addSizeY)
  else
    self._ui_enchant.stc_noticeBar:SetSize(self._ui_enchant.stc_noticeBar:GetSizeX(), self._originEnchnatNoticeBgSizeY)
    self._ui_enchant.stc_noticeBar:SetPosY(self._originEnchnatNoticeBgPosY)
  end
  self:setText_EnchantKindDesc()
end
function PaGlobal_SpiritEnchant_All:setText_EnchantKindDesc()
  if true == self._isShow_forceEnchant and true == self._ui_enchant.chk_enchantForce:IsCheck() then
    self._ui_enchant.txt_enchantDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_FORCEDENCHANTDESC"))
  elseif true == self._isShow_cronEnchant and true == self._ui_enchant.chk_enchantCron:IsCheck() then
    self._ui_enchant.txt_enchantDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_SAFTYENCHANTDESC"))
  elseif true == self._isShow_perfectEnchant then
    if true == self._ui_enchant.radio_enchantNormal:IsCheck() then
      self._ui_enchant.txt_enchantDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_DRASTICENCHANT_DESC"))
    elseif true == self._ui_enchant.radio_enchantPerfect:IsCheck() then
      self._ui_enchant.txt_enchantDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_METICULOUSENCHANT_DESC"))
    end
  else
    self._ui_enchant.txt_enchantDesc:SetText("")
  end
  self:resizePanel()
  self:showEnchantDifficulty()
end
function PaGlobal_SpiritEnchant_All:CheckEnchantCheckbox(flag)
  if nil == flag then
    return
  end
  if 1 == flag then
    self._ui_enchant.chk_enchantCron:SetCheck(false)
    if self._ui_enchant.radio_enchantPerfect:GetShow() then
      self._ui_enchant.radio_enchantPerfect:SetCheck(false)
      self._ui_enchant.radio_enchantNormal:SetCheck(false)
    end
    if false == self._ui_enchant.chk_enchantForce:IsCheck() then
      HandleEventLUp_SpiritEnchant_All_EnchantCheckClick()
      if false == self._isEnchantPerfect then
        self._ui_enchant.radio_enchantPerfect:SetCheck(false)
        self._ui_enchant.radio_enchantNormal:SetCheck(true)
      else
        self._ui_enchant.radio_enchantPerfect:SetCheck(true)
        self._ui_enchant.radio_enchantNormal:SetCheck(false)
      end
    end
    self:setHasMaterialItem()
    self:didsetEnchantTarget(true, nil)
    self:setText_EnchantInfo()
    self:resizePanel()
  elseif 2 == flag then
    self._ui_enchant.chk_enchantForce:SetCheck(false)
  end
  if nil == self._materialItemWhereType or nil == self._materialItemSlotNo then
    return false
  end
  self:setHasMaterialItem()
  return true
end
function PaGlobal_SpiritEnchant_All:clearEnchantCheckBox()
  PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantCron:SetCheck(false)
  PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantForce:SetCheck(false)
end
function PaGlobal_SpiritEnchant_All:setText_NumOfCron(cnt, needCnt)
  local currentNeedPerfectItemSSW = getInventoryItemByType(self._enchantInfo:ToClient_getCronItemWhereType(), self._enchantInfo:ToClient_getCronSlotNo())
  local currentPerfectSS
  if nil ~= currentNeedPerfectItemSSW then
    currentPerfectSS = currentNeedPerfectItemSSW:getStaticStatus()
  else
    currentPerfectSS = getItemEnchantStaticStatus(ItemEnchantKey(16080))
  end
  if cnt < needCnt then
    self:setItemToSlotMonoTone(self._slotMateiralInfo[2], currentPerfectSS, true)
    self._ui_enchant.stc_wingsInfo[2].count:SetText("<PAColor0xffff7383>" .. tostring(cnt) .. "<PAOldColor>")
  elseif true == self._ui_enchant.chk_enchantCron:IsCheck() then
    self:setItemToSlotMonoTone(self._slotMateiralInfo[2], currentPerfectSS, false)
    self._ui_enchant.stc_wingsInfo[2].count:SetText("<PAColor0xFF0FBFFF>" .. tostring(cnt) .. "<PAOldColor>")
  else
    self:setItemToSlotMonoTone(self._slotMateiralInfo[2], currentPerfectSS, true)
    self._ui_enchant.stc_wingsInfo[2].count:SetText(tostring(cnt))
  end
  if nil ~= currentPerfectSS then
    self._slotMateiralInfo[2]:setItemByStaticStatus(currentPerfectSS, needCnt)
  end
end
function PaGlobal_SpiritEnchant_All:setAsEnchantButton()
  if false == self._isConsole then
    self._ui_pc.btn_enchantGo:SetText(PAGetString(Defines.StringSheet_RESOURCE, "ENCHANT_TEXT_TITLE"))
  else
    self._ui_console.stc_enchantGoY:SetText(PAGetString(Defines.StringSheet_RESOURCE, "ENCHANT_TEXT_TITLE"))
    self._ui_console.stc_enchantGoY:SetMonoTone(false)
    Panel_Window_StackExtraction_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandlePadEventY_SpiritEnchant_All_EnchantApplyButton()")
  end
end
function PaGlobal_SpiritEnchant_All:setEnchantTarget(slotNo, itemWrapper, inventoryType, resultType, isMonotone)
  if true == self._isAnimating then
    return
  end
  if nil == slotNo or nil == itemWrapper or nil == inventoryType then
    return false
  end
  self:clearEnchantSlot()
  self:init_EnchantFrame()
  self._isLastEnchant = false
  self._isMaterialSlotMonotone = false
  local resultItemWrapper = getInventoryItemByType(inventoryType, slotNo)
  local itemSSW, enchantLevel
  if nil ~= resultItemWrapper then
    itemSSW = resultItemWrapper:getStaticStatus()
    enchantLevel = itemSSW:get()._key:getEnchantLevel()
  end
  self._enchantInfo = getEnchantInformation()
  self._enchantInfo:ToClient_clearData()
  if 0 ~= self._enchantInfo:ToClient_setEnchantSlot(inventoryType, slotNo) then
    self._isAbleEnchant = false
    self._ui_pc.btn_enchantGo:SetMonoTone(true)
    return false
  end
  self:setItemToSlot(self._slotEquip.slot, slotNo, itemWrapper, inventoryType, enchantLevel)
  self._grantItemSlotNo = slotNo
  self._grantItemWhereType = inventoryType
  local function ResetMaterial()
    self._grantItemSlotNo = slotNo
    self._grantItemWhereType = inventoryType
    self._materialItemSlotNo = nil
    self._materialItemWhereType = nil
    self._isSetNewPerfectItemMaterial = false
    self:clearItemSlot(self._slotMateiralInfo[1])
    self:clearItemSlot(self._slotMateiralInfo[2])
    self:clearItemSlot(self._slotMateiralInfo[3])
    self:didsetEnchantTarget(true, nil)
    Inventory_SetFunctor(PaGlobalFunc_SpiritEnchant_All_FilterForEnchantMaterial, PaGlobalFunc_SpiritEnchant_All_RClickForEnchantMaterial, PaGlobalFunc_SpiritEnchant_All_CloseForEnchant, nil)
  end
  if nil ~= resultType and 0 == resultType then
    if 15 == enchantLevel then
      ResetMaterial()
      return true
    end
    if 18 == enchantLevel and __eSeasonItemTypeUseSeasonCharacter == itemSSW:getSeasonItemType() then
      ResetMaterial()
      return true
    end
  end
  local equipType = itemWrapper:getStaticStatus():getItemClassify()
  local currentItemSSW = itemWrapper:getStaticStatus()
  local currentEnchantLevel = currentItemSSW:get()._key:getEnchantLevel()
  local isMaterialInit = false
  local isStackMaterial = false
  local materialItemWrapper
  if nil ~= self._materialItemWhereType and nil ~= self._materialItemSlotNo then
    materialItemWrapper = getInventoryItemByType(self._materialItemWhereType, self._materialItemSlotNo)
  end
  if nil ~= materialItemWrapper then
    isStackMaterial = materialItemWrapper:getStaticStatus():isStackable()
  else
    isMonotone = true
  end
  if CppEnums.ItemClassifyType.eItemClassify_Accessory == equipType and false == isStackMaterial then
    isMonotone = true
  end
  if true == isMonotone then
    self._prevMaterialSlotNo = nil
    self._currMaterialSlotNo = nil
    self._materialItemSlotNo = nil
    self._materialItemWhereType = nil
    self._isSetNewPerfectItemMaterial = false
    self:setHasMaterialItem()
  end
  self:didsetEnchantTarget(isMonotone, nil)
  self:showEnchantDifficulty()
  Inventory_SetFunctor(PaGlobalFunc_SpiritEnchant_All_FilterForEnchantMaterial, PaGlobalFunc_SpiritEnchant_All_RClickForEnchantMaterial, PaGlobalFunc_SpiritEnchant_All_CloseForEnchant, nil)
  return true
end
function PaGlobal_SpiritEnchant_All:setHasMaterialItem()
  if nil == self._grantItemSlotNo or nil == self._grantItemWhereType then
    return
  end
  local inventoryType = self._enchantInfo:ToClient_getNeedItemWhereType()
  local slotNo = self._enchantInfo:ToClient_getNeedItemSlotNo()
  if nil ~= self._prevMaterialSlotNo and nil ~= self._currMaterialSlotNo and self._currMaterialSlotNo ~= self._prevMaterialSlotNo then
    self._prevMaterialSlotNo = nil
    self._currMaterialSlotNo = nil
    self._materialItemSlotNo = nil
    self._materialItemWhereType = nil
    self._isMaterialSlotMonotone = false
    self:setNeedEnchantMaterial()
    return
  end
  self._prevMaterialSlotNo = slotNo
  if nil ~= self._materialItemSlotNo then
    slotNo = self._materialItemSlotNo
  end
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  self._isMaterialSlotMonotone = false
  if nil == itemWrapper then
    local enchantItemWrapper = getInventoryItemByType(self._grantItemWhereType, self._grantItemSlotNo)
    if nil ~= enchantItemWrapper then
      local itemSSW = enchantItemWrapper:getStaticStatus()
      local enchantLevel = itemSSW:get()._key:getEnchantLevel()
      local enchantAble = true
      if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() then
        if 5 == enchantLevel then
          enchantAble = false
        end
      elseif 20 == enchantLevel then
        enchantAble = false
      end
      if true == enchantAble then
        local needItemCount = enchantItemWrapper:getNeedEnchantItem(false)
        self._materialNeedCount = Int64toInt32(needItemCount)
      end
    end
    self:setNeedEnchantMaterial()
    return
  end
  self:setMaterialItem(slotNo, itemWrapper, inventoryType)
end
function PaGlobal_SpiritEnchant_All:setNeedEnchantMaterial()
  if nil == self._grantItemSlotNo or nil == self._grantItemWhereType then
    return
  end
  self:setItemToSlotMonoTone(self._slotMateiralInfo[1], self._enchantInfo:ToClient_getNeedItemStaticInformation(), true)
  local needCountForPerfectEnchant_s64 = self._enchantInfo:ToClient_getNeedCountForPerfectEnchant_s64()
  if self._isShow_forceEnchant and self._ui_enchant.chk_enchantForce:IsCheck() and needCountForPerfectEnchant_s64 > toInt64(0, 0) then
    self._slotMateiralInfo[1]:setItemByStaticStatus(self._enchantInfo:ToClient_getNeedItemStaticInformation(), self._enchantInfo:ToClient_getNeedCountForPerfectEnchant_s64())
  else
    self._slotMateiralInfo[1]:setItemByStaticStatus(self._enchantInfo:ToClient_getNeedItemStaticInformation(), self._materialNeedCount)
  end
  self._ui_enchant.stc_noticeBar:SetShow(true)
  self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_SETMATERIAL"))
  self._ui_pc.btn_enchantGo:SetMonoTone(true)
  self._isAbleEnchant = false
  self._enchantInfo:materialClearData()
end
function PaGlobal_SpiritEnchant_All:setMaterialItem(slotNo, itemWrapper, inventoryType)
  if true == self._isAnimating then
    return
  end
  if nil == slotNo or nil == itemWrapper or nil == inventoryType then
    return
  end
  self:setNeedEnchantMaterial()
  self:clearItemSlot(self._slotMateiralInfo[1])
  if slotNo == self._enchantInfo:ToClient_getNeedNewPerfectItemSlotNo() and inventoryType == self._enchantInfo:ToClient_getNeedNewPerfectItemWhereType() then
    self._isSetNewPerfectItemMaterial = true
  else
    self._isSetNewPerfectItemMaterial = false
  end
  self:setItemToSlot(self._slotMateiralInfo[1], slotNo, itemWrapper, inventoryType)
  if self._materialNeedCount > Int64toInt32(itemWrapper:get():getCount_s64()) then
    return
  end
  self._isAbleEnchant = true
  self._materialItemSlotNo = slotNo
  self._materialItemWhereType = inventoryType
  self._ui_pc.btn_enchantGo:SetMonoTone(false)
  self:didsetEnchantTarget(false)
  self:setCheckEnchantInfo(false)
end
function PaGlobal_SpiritEnchant_All:getStr_EnchantInfo(curMaxEndura, decEndura, enchantType, isChecked)
  local str = ""
  if enchantType == self._enum_EnchantType._safe then
    str = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_100PERCENT")
  else
    if true == self._isShow_perfectEnchant and true == self._ui_enchant.radio_enchantPerfect:IsCheck() then
      decEndura = decEndura * 0.8
    end
    local itemWrapper = getInventoryItemByType(self._grantItemWhereType, self._grantItemSlotNo)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      local enchantLevel = itemSSW:get()._key:getEnchantLevel()
      local isAccessory = CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() and false == ToClient_IsDeadGodEquip(itemSSW:get()._key:getItemKey())
      if false == isAccessory and 20 ~= enchantLevel then
        str = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_0", "maxEndurance", tostring(decEndura), "currentEndurance", tostring(curMaxEndura))
      end
      if nil == isChecked then
        if enchantType == self._enum_EnchantType._broken or enchantType == self._enum_EnchantType._downAndBroken then
          if "" == str then
            str = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_1")
          else
            str = str .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_1")
          end
        end
        if enchantType == self._enum_EnchantType._gradedown or enchantType == self._enum_EnchantType._downAndBroken then
          if "" == str then
            str = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_2")
          else
            str = str .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_2")
          end
        end
      end
      if 20 == enchantLevel then
        str = ""
      end
    end
  end
  return str
end
function PaGlobal_SpiritEnchant_All:getStr_EnchantProtectInfo(enchantType)
  if enchantType == self._enum_EnchantType._broken or enchantType == self._enum_EnchantType._downAndBroken then
    return "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_3") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_4")
  else
    return "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_5") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_4")
  end
end
function PaGlobal_SpiritEnchant_All:getStr_PerfectEnchantInfo(needCount, decEndura)
  local needItemWrapper = self._enchantInfo:ToClient_getNeedItemStaticInformation()
  local needItemName = ""
  if nil ~= needItemWrapper then
    needItemName = needItemWrapper:getName()
  end
  local itemWrapper = getInventoryItemByType(self._grantItemWhereType, self._grantItemSlotNo)
  if nil ~= itemWrapper then
    local itemSSW = itemWrapper:getStaticStatus()
    local enchantLevel = itemSSW:get()._key:getEnchantLevel()
    if 14 < enchantLevel then
      return "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_100PERCENT") .. "\n" .. PAGetStringParam3(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_PERFECTE_PANALTY", "ItemName", tostring(needItemName), "count", tostring(needCount), "endurance", tostring(decEndura))
    end
  end
  return "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_100PERCENT") .. "\n" .. PAGetStringParam3(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_PERFECTE_PANALTY", "ItemName", tostring(needItemName), "count", tostring(needCount), "endurance", tostring(decEndura))
end
function PaGlobal_SpiritEnchant_All:enchantApplyButton()
  local enchantAlert = false
  local failCount = self._enchantInfo:ToClient_getFailCount()
  local valksCount = self._enchantInfo:ToClient_getValksCount()
  local itemWrapper = getInventoryItemByType(self._grantItemWhereType, self._grantItemSlotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local isCronKey = itemSSW:getCronKey()
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  local isStackLessBlackStone = itemSSW:isNeedStackLessBlackStonForEnchant()
  local enchantType = self._enchantInfo:ToClient_getEnchantType()
  self._isAbleEnchant = false
  local goEnchant = function()
    PaGlobal_SpiritEnchant_All:willStartEnchant()
  end
  local function cancleEnchant()
    self._isAbleEnchant = true
  end
  if 0 == failCount + valksCount and false == isStackLessBlackStone then
    if nil ~= self._grantItemWhereType and nil ~= self._grantItemSlotNo then
      if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() then
        if 0 < enchantLevel then
          enchantAlert = true
        end
      elseif 15 < enchantLevel and enchantType ~= self._enum_EnchantType._safe then
        enchantAlert = true
      end
    end
    if true == self._isShow_forceEnchant and true == self._ui_enchant.chk_enchantForce:IsCheck() or true == self._isSetNewPerfectItemMaterial then
      enchantAlert = false
    end
    if 30 < self._currentEnchantRate then
      enchantAlert = false
    end
    if true == enchantAlert then
      local _title = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_MESSAGETITLE")
      local _content = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_MESSAGEDESC")
      local messageBoxData = {
        title = _title,
        content = _content,
        functionYes = goEnchant,
        functionNo = cancleEnchant,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      if false == self._isConsole then
        MessageBox.showMessageBox(messageBoxData, nil, false, false)
      else
        MessageBox.showMessageBox(messageBoxData, nil, false, true)
      end
    else
      goEnchant()
    end
  elseif 0 < itemWrapper:getCronEnchantFailCount() and 17 < enchantLevel and false == self._isSetNewPerfectItemMaterial and 0 ~= isCronKey then
    local _title = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_MESSAGETITLE")
    local _content = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_CRON_ENERGY_WARNING_DESC_CAPHRAS")
    local messageBoxData = {
      title = _title,
      content = _content,
      functionApply = goEnchant,
      functionCancel = cancleEnchant,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    if false == self._isConsole then
      MessageBox.showMessageBox(messageBoxData, nil, false, false)
    else
      MessageBox.showMessageBox(messageBoxData, nil, false, true)
    end
  else
    goEnchant()
  end
end
function PaGlobal_SpiritEnchant_All:cancleEnchant()
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
  self:removeEnchantEffect()
  self:setAsEnchantButton()
  self._ui_enchant.radio_enchantNormal:SetIgnore(false)
  self._ui_enchant.radio_enchantPerfect:SetIgnore(false)
  self._ui_enchant.chk_enchantForce:SetIgnore(false)
  self._ui_enchant.chk_skipAni:SetIgnore(false)
  local itemWrapper = getInventoryItemByType(self._grantItemWhereType, self._grantItemSlotNo)
  if nil ~= itemWrapper then
    local itemSSW = itemWrapper:getStaticStatus()
    if nil ~= itemSSW then
      local enchantLevel = itemSSW:get()._key:getEnchantLevel()
      self:setItemEnchantLevelEffect(self._slotEquip.slot, itemWrapper, enchantLevel)
      self:setCronEnchant()
    end
  end
  audioPostEvent_SystemUi(5, 99)
  _AudioPostEvent_SystemUiForXBOX(5, 99)
  ToClient_BlackspiritEnchantCancel()
end
function PaGlobal_SpiritEnchant_All:removeEnchantEffect()
  if nil ~= self._slotEquip.slot then
    self._slotEquip.slot.icon:EraseAllEffect()
  end
  if nil ~= self._slotMateiralInfo[1] then
    self._slotMateiralInfo[1].icon:EraseAllEffect()
  end
  if nil ~= self._slotMateiralInfo[2] then
    self._slotMateiralInfo[2].icon:EraseAllEffect()
  end
  if nil ~= self._ui_enchant.stc_wingTop then
    self._ui_enchant.stc_wingTop:EraseAllEffect()
  end
  if true == self._isClickCancle then
    self._ui_enchant.stc_image:EraseAllEffect()
    self._isClickCancle = false
  end
end
function PaGlobal_SpiritEnchant_All:willStartEnchant()
  if true == self._ui_enchant.chk_enchantCron:IsCheck() then
    if self._enchantInfo:ToClient_setPreventDownGradeItem() ~= 0 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_NOT_ENOUGH_CRONESTONE"))
      return
    end
  else
    self._enchantInfo:ToClient_clearPreventDownGradeItem()
  end
  if true == _ContentsGroup_FamilyStack and true == PaGlobalFunc_StackStorage_All_GetShow() then
    PaGlobalFunc_StackStorage_All_Close()
  end
  if false == self._ui_enchant.chk_skipAni:IsCheck() then
    self:startEnchantAnimation()
  else
    self:startEnchant()
  end
end
function PaGlobal_SpiritEnchant_All:startEnchantAnimation()
  self:addEnchantEffect()
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
  ToClient_StartLedDeviceAnimation(7)
end
function PaGlobal_SpiritEnchant_All:startEnchant()
  if false == Panel_Window_StackExtraction_All:GetShow() then
    return
  end
  local function isDifficulty()
    if true == self._ui_enchant.chk_enchantForce:IsCheck() then
      return false
    end
    return self._ui_enchant.radio_enchantPerfect:IsCheck()
  end
  self._enchantInfo:ToClient_doEnchant(self._ui_enchant.chk_enchantForce:IsCheck(), isDifficulty())
  self._isWaitingServer = true
  self:cancleEnchant()
end
function PaGlobal_SpiritEnchant_All:addEnchantEffect()
  local itemWrapper = getInventoryItemByType(self._grantItemWhereType, self._grantItemSlotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local isCronKey = itemSSW:getCronKey()
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  local isLastChallenge = false
  if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() then
    if 4 <= enchantLevel then
      isLastChallenge = true
    end
  elseif 19 <= enchantLevel then
    isLastChallenge = true
  end
  local audioIdx = 5
  local audioIdxB = self._audio._enchatNomal_idxB
  if true == isLastChallenge then
    local randomNum = math.random(1, 4)
    self._randomEffectNum = math.floor(randomNum)
    local randomEffect = self._enchantEffect[self._randomEffectNum]
    if nil == randomEffect then
      return
    end
    self._effectTime = randomEffect.effectTime
    self._ui_enchant.stc_image:AddEffect(randomEffect.effectName, true, 46, 3)
    self._slotMateiralInfo[1].icon:AddEffect("fUI_SpiritEnchant_Box_Glow_01A", true, 0, 0)
    audioIdxB = randomEffect.audioIndexB
  else
    self._effectTime = self._originEffectTime
    self._ui_enchant.stc_image:AddEffect("fUI_SpiritEnchant_01A", true, 46, 3)
    self._slotMateiralInfo[1].icon:AddEffect("fUI_SpiritEnchant_Box_Glow_01A", true, 0, 0)
  end
  if true == self._ui_enchant.chk_enchantCron:IsCheck() then
    self._slotMateiralInfo[2].icon:AddEffect("fUI_SpiritEnchant_Box_Glow_01A", true, 0, 0)
    self._ui_enchant.stc_wingTop:AddEffect("fUI_SpiritEnchant_ChroneStone_01A", true, 200, 16)
  end
  audioPostEvent_SystemUi(5, 6)
  _AudioPostEvent_SystemUiForXBOX(5, 6)
  audioPostEvent_SystemUi(audioIdx, audioIdxB)
  _AudioPostEvent_SystemUiForXBOX(audioIdx, audioIdxB)
  self._startTime = self._effectTime - 1.5
end
function PaGlobal_SpiritEnchant_All:enchantResult(resultType, mainWhereType, mainSlotNo, subWhereType, subSlotNo)
  self._isWaitingServer = false
  if resultType == self._enum_EnchantResult._error then
    ToClient_BlackspiritEnchantCancel()
    return
  end
  self:showEnchantResultEffect(resultType)
  self:clearEnchantSlot()
  if false == self:setEnchantTarget(mainSlotNo, getInventoryItemByType(mainWhereType, mainSlotNo), mainWhereType, resultType, false) then
    local itemWrapper = getInventoryItemByType(mainWhereType, mainSlotNo)
    local finalEnchantStr = ""
    self._isLastEnchant = false
    if true == _ContentsGroup_Caphras then
      finalEnchantStr = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_FINALENCHANT")
    end
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      local enchantLevel = itemSSW:get()._key:getEnchantLevel()
      if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() then
        if 5 == enchantLevel then
          self._ui_enchant.txt_enchantDesc:SetText("")
          self._isLastEnchant = true
        end
      elseif 20 == enchantLevel then
        self._ui_enchant.txt_enchantDesc:SetText(finalEnchantStr)
        self._isLastEnchant = true
      end
      if false == itemWrapper:checkToUpgradeItem() then
        self._ui_enchant.txt_enchantDesc:SetText("")
      end
    end
    if true == self._isLastEnchant then
      self:setItemToSlot(self._slotEquip.slot, mainSlotNo, itemWrapper, mainWhereType)
      self._materialItemWhereType = nil
      self._materialItemSlotNo = nil
      self:clearItemSlot(self._slotMateiralInfo[2])
      self:clearItemSlot(self._slotMateiralInfo[3])
      self._ui_enchant.stc_wingTop:SetShow(false)
      Inventory_SetFunctor(PaGlobalFunc_SpiritEnchant_All_FilterForEnchantTarget, PaGlobalFunc_SpiritEnchant_All_RClickForEnchantTargetItem, PaGlobalFunc_SpiritEnchant_All_CloseForEnchant, nil)
    else
      self:clearEnchantSlot()
      PaGlobal_SpiritEnchant_All:enchantTabOpen()
    end
  end
  if nil ~= self._prevMaterialSlotNo then
    self._currMaterialSlotNo = self._enchantInfo:ToClient_getNeedItemSlotNo()
  end
  self:setHasMaterialItem()
  self:showEnchantResultText(resultType, mainSlotNo, mainWhereType)
  self:resizePanel()
end
function PaGlobal_SpiritEnchant_All:showEnchantResultEffect(resultType)
  if resultType == self._enum_EnchantResult._success then
    audioPostEvent_SystemUi(5, 22)
    _AudioPostEvent_SystemUiForXBOX(5, 22)
    render_setChromaticBlur(40, 1)
    render_setPointBlur(0.05, 0.045)
    render_setColorBypass(0.85, 0.08)
    self._slotEquip.slot.icon:AddEffect("", false, -6, -6)
    self._slotEquip.slot.icon:AddEffect("", false, -6, -6)
    self:showEnchantResultNakMessage(true, PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_SUCCESSENCHANT"))
    ToClient_BlackspiritEnchantSuccess()
  else
    audioPostEvent_SystemUi(0, 7)
    _AudioPostEvent_SystemUiForXBOX(0, 7)
    if resultType == self._enum_EnchantResult._broken then
      audioPostEvent_SystemUi(5, 23)
      _AudioPostEvent_SystemUiForXBOX(5, 23)
    elseif resultType == self._enum_EnchantResult._gradedown then
      audioPostEvent_SystemUi(5, 23)
      _AudioPostEvent_SystemUiForXBOX(5, 23)
    elseif resultType == self._enum_EnchantResult._fail then
      audioPostEvent_SystemUi(5, 23)
      _AudioPostEvent_SystemUiForXBOX(5, 23)
    elseif resultType == self._enum_EnchantResult._failAndPrevent then
      audioPostEvent_SystemUi(5, 23)
      _AudioPostEvent_SystemUiForXBOX(5, 23)
    end
    self:showEnchantResultNakMessage(false, PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_FAILENCHANT"))
    ToClient_BlackspiritEnchantCancel()
  end
  self:didsetEnchantTarget(false)
end
function PaGlobal_SpiritEnchant_All:showEnchantResultNakMessage(resultType, msg)
  if nil == resultType or nil == msg then
    return
  end
  self._nakAniTimeStamp = 0
  self._isNakAnimating = true
  self._ui_enchant.stc_resultNak:SetShow(true)
  self._ui_enchant.stc_resultNak:SetText(msg)
  if PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT == PaGlobal_SpiritEnchant_All._currentMainTab then
    self._ui_enchant.stc_resultNak:SetSpanSize(self._ui_enchant.stc_resultNak:GetSpanSize().x, self._originNakSpanY)
  elseif PaGlobal_SpiritEnchant_All._MAIN_TAB.CARPHRAS == PaGlobal_SpiritEnchant_All._currentMainTab then
    self._ui_enchant.stc_resultNak:SetSpanSize(self._ui_enchant.stc_resultNak:GetSpanSize().x, self._originNakSpanY)
  elseif PaGlobal_SpiritEnchant_All._MAIN_TAB.EXTRACTION == PaGlobal_SpiritEnchant_All._currentMainTab then
    self._ui_enchant.stc_resultNak:SetSpanSize(self._ui_enchant.stc_resultNak:GetSpanSize().x, self._originNakSpanY + self._ui_extraction.stc_subTabBg:GetSizeY())
  end
  if true == resultType then
    self._ui_enchant.stc_resultNak:ChangeTextureInfoName("combine/frame/combine_frame_noticebar_quest.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui_enchant.stc_resultNak, 0, 0, 210, 110)
    self._ui_enchant.stc_resultNak:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui_enchant.stc_resultNak:setRenderTexture(self._ui_enchant.stc_resultNak:getBaseTexture())
    self._ui_enchant.stc_resultNak:SetFontColor(Defines.Color.C_FFFFEDD4)
  else
    self._ui_enchant.stc_resultNak:ChangeTextureInfoName("combine/frame/combine_frame_noticebar_quest.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui_enchant.stc_resultNak, 0, 111, 210, 221)
    self._ui_enchant.stc_resultNak:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui_enchant.stc_resultNak:setRenderTexture(self._ui_enchant.stc_resultNak:getBaseTexture())
    self._ui_enchant.stc_resultNak:SetFontColor(Defines.Color.C_FFE0E0E0)
  end
  self._ui_enchant.stc_resultNak:ResetAndClearVertexAni()
  local startAniInfo = self._ui_enchant.stc_resultNak:addColorAnimation(0, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  startAniInfo:SetStartColor(Defines.Color.C_00FFFFFF)
  startAniInfo:SetEndColor(Defines.Color.C_FFFFFFFF)
  startAniInfo.IsChangeChild = true
  local endAniInfo = self._ui_enchant.stc_resultNak:addColorAnimation(self._nakElapsedTime - 0.15, self._nakElapsedTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  endAniInfo:SetStartColor(Defines.Color.C_FFFFFFFF)
  endAniInfo:SetEndColor(Defines.Color.C_00FFFFFF)
  endAniInfo.IsChangeChild = true
end
function PaGlobal_SpiritEnchant_All:stopEnchantResultNakMessage()
  self._ui_enchant.stc_resultNak:SetShow(false)
end
function PaGlobal_SpiritEnchant_All:showEnchantResultText(resultType, mainSlotNo, mainWhereType)
  if resultType == self._enum_EnchantResult._success then
    self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_RESULT_0"))
    self._ui_enchant.stc_noticeBar:EraseAllEffect()
    self._ui_enchant.stc_noticeBar:AddEffect("UI_QustComplete01", false, 0, 0)
  elseif resultType == self._enum_EnchantResult._fail then
    local resultMsg = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_RESULT_1")
    local curEndurance = self._enchantInfo:ToClient_getCurMaxEndura()
    local currentEnduranceMsg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_RESULT_ENDURANCE", "curEndurance", curEndurance)
    self._ui_enchant.stc_noticeBar:SetText(resultMsg .. " " .. currentEnduranceMsg)
    self._ui_enchant.stc_noticeBar:EraseAllEffect()
    self._ui_enchant.stc_noticeBar:AddEffect("fUI_Enchant_Fail", false, 0, 0)
  elseif resultType == self._enum_EnchantResult._broken then
    self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_RESULT_2"))
    self._ui_enchant.stc_noticeBar:EraseAllEffect()
    self._ui_enchant.stc_noticeBar:AddEffect("fUI_Enchant_Fail", false, 0, 0)
  elseif resultType == self._enum_EnchantResult._gradedown then
    self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_RESULT_3"))
    self._ui_enchant.stc_noticeBar:EraseAllEffect()
    self._ui_enchant.stc_noticeBar:AddEffect("fUI_Enchant_Fail", false, 0, 0)
  elseif resultType == self._enum_EnchantResult._failAndPrevent then
    self._ui_enchant.stc_noticeBar:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_RESULT_4"))
    self._ui_enchant.stc_noticeBar:EraseAllEffect()
    self._ui_enchant.stc_noticeBar:AddEffect("fUI_Enchant_Fail", false, 0, 0)
  end
  self:showSuccessEffectByResult(resultType, mainSlotNo, mainWhereType)
end
function PaGlobal_SpiritEnchant_All:showSuccessEffectByResult(resultType, mainSlotNo, mainWhereType)
  if resultType == self._enum_EnchantResult._success then
    local itemWrapper = getInventoryItemByType(mainWhereType, mainSlotNo)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      local enchantLevel = itemSSW:get()._key:getEnchantLevel()
      if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() then
        if 5 == enchantLevel then
          self._slotEquip.slot.icon:AddEffect("fUI_SpiritEnchant_High_Success_01C", false, 1.7, -4)
        elseif 4 == enchantLevel then
          self._slotEquip.slot.icon:AddEffect("fUI_SpiritEnchant_High_Success_01B", false, 1.7, -4)
        else
          self._slotEquip.slot.icon:AddEffect("fUI_SpiritEnchant_High_Success_01A", true, 1.7, -4)
        end
      elseif 20 == enchantLevel then
        self._slotEquip.slot.icon:AddEffect("fUI_SpiritEnchant_High_Success_01C", false, 1.7, -4)
      elseif 19 == enchantLevel then
        self._slotEquip.slot.icon:AddEffect("fUI_SpiritEnchant_High_Success_01B", false, 1.7, -4)
      else
        self._slotEquip.slot.icon:AddEffect("fUI_SpiritEnchant_High_Success_01A", true, 1.7, -4)
      end
    end
  else
    self._slotEquip.slot.icon:AddEffect("", false, -6, -6)
  end
  if nil ~= self._materialItemWhereType and nil ~= self._materialItemSlotNo then
    local itemWrapper = getInventoryItemByType(self._materialItemWhereType, self._materialItemSlotNo)
    if nil ~= itemWrapper and self._materialNeedCount <= Int64toInt32(itemWrapper:get():getCount_s64()) and false == self._isMaterialSlotMonotone then
      self._ui_pc.btn_enchantGo:SetMonoTone(false)
      if 0 == self._enchantInfo:ToClient_getCurMaxEndura() then
        self._isAbleEnchant = false
        self._ui_pc.btn_enchantGo:SetMonoTone(true)
      elseif true ~= self._isConsole then
        self._isAbleEnchant = true
      end
    end
  end
end
function PaGlobal_SpiritEnchant_All:setCheckFunc(ButtonName, isOn)
  if true == isRealServiceMode() then
    return false
  end
  if nil == Panel_Window_StackExtraction_All then
    return false
  end
  if false == Panel_Window_StackExtraction_All:GetShow() then
    return false
  end
  if "Cron" == ButtonName then
    if true == isOn and false == self._ui_enchant.chk_enchantCron:IsIgnore() and true == self._isShow_cronEnchant then
      self._ui_enchant.chk_enchantCron:SetCheck(isOn)
    elseif false == isOn then
      self._ui_enchant.chk_enchantCron:SetCheck(isOn)
    else
      return false
    end
  elseif "SkipAni" == ButtonName then
    self._ui_enchant.chk_skipAni:SetCheck(isOn)
  else
    self._ui_enchant.chk_enchantForce:SetCheck(inOn)
  end
  return true
end
function PaGlobal_SpiritEnchant_All:getCronCount()
  if true == isRealServiceMode() then
    return -1
  end
  local enchantInfo = getEnchantInformation()
  if nil == enchantInfo then
    return -1
  end
  if toInt64(0, 0) <= enchantInfo:ToClient_getNeedCountForProtect_s64() then
    return Int64toInt32(enchantInfo:ToClient_getNeedCountForProtect_s64())
  end
  return -1
end
function PaGlobal_SpiritEnchant_All:getPerfectCount()
  if true == isRealServiceMode() then
    return -1
  end
  local enchantInfo = getEnchantInformation()
  if nil == enchantInfo then
    return -1
  end
  if toInt64(0, 0) <= enchantInfo:ToClient_getNeedCountForPerfectEnchant_s64() then
    return Int64toInt32(enchantInfo:ToClient_getNeedCountForPerfectEnchant_s64())
  end
  return -1
end
