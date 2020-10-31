function StartAutoQA1()
  ToClient_qaresetTimerJobList()
  ToClient_qaRegisterTimerForQA(100, "TargetWindow_ShowToggle(10)")
  ToClient_qaRegisterTimerForQA(1000, "close_WindowPanelList()")
end
function StartAutoQA2()
  ToClient_qaresetTimerJobList()
  ToClient_qaRegisterTimerForQA(2000, "ToClient_qaTeleport(217738, -1702, -1)")
  ToClient_qaRegisterTimerForQA(20000, "TargetWindow_ShowToggle(10)")
end
function StartAutoQA3()
  ToClient_qaresetTimerJobList()
  ToClient_qaRegisterTimerForQA(100, "PaGlobal_AutoQASupport:writeLogFile('startTest')")
  ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(19923, 0, 10)")
  for itemKey = 792, 795 do
    ToClient_qaRegisterTimerForQA(20, "ToClient_qaCreateItem(" .. itemKey .. ", 0, 10)")
  end
  ToClient_qaRegisterTimerForQA(500, "saveItemSlotForQA(0, 19923)")
  ToClient_qaRegisterTimerForQA(500, "PaGlobal_AutoQASupport:writeLogFile( '\235\150\161\234\181\173\236\157\152\236\138\172\235\161\175 : ' .. getItemSlotForQA())")
  ToClient_qaRegisterTimerForQA(500, "PaGlobal_AutoQASupport:writeLogFile('endTest')")
  ToClient_qaRegisterTimerForQA(500, "Proc_ShowMessage_Ack('\237\133\140\236\138\164\237\138\184\234\176\128 \235\129\157\235\130\172\236\138\181\235\139\136\235\139\164.')")
end
function StartAutoQA4()
  ToClient_qaRegisterTimerForQA(100, "TargetWindow_ShowToggle(11)")
  ToClient_qaRegisterTimerForQA(2500, "HandleEventLUp_DialogMain_All_FuncButton(2)")
  ToClient_qaRegisterTimerForQA(2500, "PaGlobal_SpiritEnchant_All:setCheckFunc('SkipAni', true)")
  ToClient_qaRegisterTimerForQA(5000, "_PA_LOG('\236\157\180\235\139\164\237\152\156', PaGlobal_SpiritEnchant_All:getCronCount() )")
  ToClient_qaRegisterTimerForQA(5000, "_PA_LOG('\236\157\180\235\139\164\237\152\156', PaGlobal_SpiritEnchant_All:getPerfectCount() )")
end
function saveItemSlotForQA(whereType, itemKey)
  PaGlobal_AutoQASupport._itemSlot = PaGlobal_AutoQASupport:getInvenSlotByItemKey(whereType, itemKey)
  if PaGlobal_AutoQASupport._itemSlot == -1 then
  end
end
function getItemSlotForQA()
  return PaGlobal_AutoQASupport._itemSlot
end
function Inventory_SlotRClick_ForQA(time, slotNo)
  if true == _ContentsGroup_NewUI_Inventory_All then
    ToClient_qaRegisterTimerForQA(time, "HandleEventRUp_Inventory_All_SlotRClick(" .. slotNo .. ")")
  else
    ToClient_qaRegisterTimerForQA(time, "Inventory_SlotRClick(" .. slotNo .. ")")
  end
end
QA_BlackSpirit = {
  _enhance = {
    _weaponKey = 10010,
    _weaponMat1Key = 16001,
    _weaponMat2Key = 16004,
    _weaponLevel = -1,
    _weaponMaxEndurance = -1,
    _weaponMat1Count = -1,
    _weaponMat2Count = -1,
    _weaponLevelNext = -1,
    _weaponMaxEnduranceNext = -1,
    _weaponMat1CountNext = -1,
    _weaponMat2CountNext = -1,
    _armorKey = 11017,
    _armorMat1Key = 16002,
    _armorMat2Key = 16005,
    _armorLevel = -1,
    _armorMaxEndurance = -1,
    _armorMat1Count = -1,
    _armorMat2Count = -1,
    _armorLevelNext = -1,
    _armorMaxEnduranceNext = -1,
    _armorMat1CountNext = -1,
    _armorMat2CountNext = -1,
    _accKey = 12031,
    _accMat1Key = 12031,
    _accLevel = -1,
    _accMaxEndurance = -1,
    _accLevelNext = -1,
    _accMaxEnduranceNext = -1,
    _cronKey = 16080,
    _isCronApplied = false,
    _cronCount = -1,
    _cronCountNext = -1,
    _failCount = -1,
    _valksCount = -1,
    _bonusCount = -1,
    _failCountNext = -1,
    _valksCountNext = -1,
    _bonusCountNext = -1,
    _isSuccess = false,
    _isFail = false,
    _isForceEnhance = false
  },
  _caphras = {
    caphrasItemKey = 10010,
    caphrasStoneKey = 721003,
    capMaxEndurance = -1,
    capMaxEnduranceNext = -1,
    caphrasStoneCount = -1,
    caphrasStoneCountNext = -1,
    caphrasStoneNeedCount = -1,
    caphrasLevel = -1,
    caphrasLevelNext = -1
  }
}
function QA_BlackSpirit:caphras()
  ToClient_qaresetTimerJobList()
  loadBlackSpirit()
  ToClient_qaRegisterTimerForQA(2500, "HandleEventLUp_DialogMain_All_FuncButton(2)")
  ToClient_qaRegisterTimerForQA(500, "HandleEventLUp_SpiritEnchant_All_MainTabSelect(2)")
  ToClient_qaRegisterTimerForQA(500, "PaGlobal_SpiritEnchant_All:setCheckFunc('SkipAni', true)")
  ToClient_qaRegisterTimerForQA(500, "PaGlobal_Inventory_UnCheckAutoSort()")
  ToClient_qaRegisterTimerForQA(1000, "ToClient_qaCreateItem(10010,20,1)")
  saveItemSlotForQA(CppEnums.ItemWhereType.eInventory, 10010)
  local targetSlotNo = getItemSlotForQA()
  Inventory_SlotRClick_ForQA(1000, targetSlotNo)
  saveItemSlotForQA(CppEnums.ItemWhereType.eInventory, 721003)
  local capstoneSlotNo = getItemSlotForQA()
  Inventory_SlotRClick_ForQA(1000, capstoneSlotNo)
  if false == _ContentsGroup_NewUI_NumberPad_All then
    ToClient_qaRegisterTimerForQA(1000, "Panel_NumberPad_ButtonAllSelect_Mouse_Click(0)")
    ToClient_qaRegisterTimerForQA(1000, "Panel_NumberPad_ButtonConfirm_Mouse_Click()")
  else
    ToClient_qaRegisterTimerForQA(1000, "HandleEventLUp_NumberPad_All_AllButton_Click(0)")
    ToClient_qaRegisterTimerForQA(1000, "HandleEventLUp_NumberPad_All_ConfirmButton_Click()")
  end
  ToClient_qaRegisterTimerForQA(1000, "HandleEventLUp_SpiritEnchant_All_CaphrasEnchantApplyButton()")
end
function QA_BlackSpirit:checkCaphrasMaterial()
  if self._enhance._weaponMat1CountNext < 1 or 1 > self._enhance._weaponMat2CountNext then
    if self._enhance._weaponMat1CountNext < 1 then
      ToClient_qaCreateItem(self._enhance._weaponMat1Key, 0, 1)
    end
    if 1 > self._enhance._weaponMat2CountNext then
      ToClient_qaCreateItem(self._enhance._weaponMat2Key, 0, 1)
    end
    ToClient_qaRegisterTimerForQA(1000, "QA_BlackSpirit:enhanceWeaponStart()")
  else
    if PaGlobal_AutoQASupport._enchantResult._resultType == 5 then
      local enchantWeaponKey = self._enhance._weaponKey
      saveItemSlotForQA(CppEnums.ItemWhereType.eInventory, enchantWeaponKey)
      local targetSlotNo = getItemSlotForQA()
      Inventory_SlotRClick_ForQA(1000, targetSlotNo)
    end
    ToClient_qaRegisterTimerForQA(500, "QA_BlackSpirit:enhanceWeaponStart()")
  end
end
function QA_BlackSpirit:enhance()
  PaGlobal_AutoQASupport._enchantResult._resultType = -1
  ToClient_qaresetTimerJobList()
  loadBlackSpirit()
  ToClient_qaRegisterTimerForQA(500, "ToClient_qaCreateItem(" .. self._enhance._weaponKey .. ",0,1)")
  ToClient_qaRegisterTimerForQA(500, "ToClient_qaCreateItem(" .. self._enhance._armorKey .. ",0,1)")
  ToClient_qaRegisterTimerForQA(2500, "HandleEventLUp_DialogMain_All_FuncButton(2)")
  ToClient_qaRegisterTimerForQA(500, "QA_BlackSpirit:checkWeaponMaterial()")
end
function QA_BlackSpirit:checkWeaponMaterial()
  if self._enhance._weaponMat1CountNext < 1 or 1 > self._enhance._weaponMat2CountNext then
    if self._enhance._weaponMat1CountNext < 1 then
      ToClient_qaCreateItem(self._enhance._weaponMat1Key, 0, 1)
    end
    if 1 > self._enhance._weaponMat2CountNext then
      ToClient_qaCreateItem(self._enhance._weaponMat2Key, 0, 1)
    end
    ToClient_qaRegisterTimerForQA(1000, "QA_BlackSpirit:enhanceWeaponStart()")
  else
    if PaGlobal_AutoQASupport._enchantResult._resultType == 5 then
      local enchantWeaponKey = self._enhance._weaponKey
      saveItemSlotForQA(CppEnums.ItemWhereType.eInventory, enchantWeaponKey)
      local targetSlotNo = getItemSlotForQA()
      Inventory_SlotRClick_ForQA(1000, targetSlotNo)
    end
    ToClient_qaRegisterTimerForQA(500, "QA_BlackSpirit:enhanceWeaponStart()")
  end
end
function QA_BlackSpirit:checkArmorMaterial()
  if self._enhance._armorMat1CountNext < 1 or 1 > self._enhance._armorMat2CountNext then
    if self._enhance._armorMat1CountNext < 1 then
      ToClient_qaCreateItem(self._enhance._armorMat1Key, 0, 1)
    end
    if 1 > self._enhance._armorMat2CountNext then
      ToClient_qaCreateItem(self._enhance._armorMat2Key, 0, 1)
    end
    ToClient_qaRegisterTimerForQA(1000, "QA_BlackSpirit:enhanceArmorStart()")
  else
    if PaGlobal_AutoQASupport._enchantResult._resultType == 5 then
      local enchantArmorKey = self._enhance._armorKey
      saveItemSlotForQA(CppEnums.ItemWhereType.eInventory, enchantArmorKey)
      local targetSlotNo = getItemSlotForQA()
      Inventory_SlotRClick_ForQA(1000, targetSlotNo)
    end
    ToClient_qaRegisterTimerForQA(500, "QA_BlackSpirit:enhanceArmorStart()")
  end
end
function QA_BlackSpirit:checkForceWeaponBS()
  local needPerfectCount = PaGlobal_SpiritEnchant_All:getPerfectCount()
  if needPerfectCount > self._enhance._weaponMat1Count then
    ToClient_qaCreateItem(self._enhance._weaponMat1Key, 0, needPerfectCount - self._enhance._weaponMat1Count)
  end
  HandleEventRUp_SpiritEnchant_All_ReleseTargetItem()
end
function QA_BlackSpirit:checkForceArmorBS()
  local needPerfectCount = PaGlobal_SpiritEnchant_All:getPerfectCount()
  if needPerfectCount > self._enhance._armorMat1Count then
    ToClient_qaCreateItem(self._enhance._armorMat1Key, 0, needPerfectCount - self._enhance._armorMat1Count)
  end
  HandleEventRUp_SpiritEnchant_All_ReleseTargetItem()
end
function QA_BlackSpirit:checkCronStone()
  local needCronCount = PaGlobal_SpiritEnchant_All:getCronCount()
  if needCronCount > self._enhance._cronCount then
    ToClient_qaCreateItem(self._enhance._cronKey, 0, needCronCount - self._enhance._cronCount)
  end
  HandleEventRUp_SpiritEnchant_All_ReleseTargetItem()
end
function QA_BlackSpirit:enhanceWeaponStart()
  ToClient_qaRegisterTimerForQA(0, "HandleEventLUp_SpiritEnchant_All_MainTabSelect(1)")
  ToClient_qaRegisterTimerForQA(100, "PaGlobal_Inventory_UnCheckAutoSort()")
  if PaGlobal_AutoQASupport._enchantResult._resultType == -1 then
    if self._enhance._isCronApplied == false then
      if self._enhance._isForceEnhance == false then
        PaGlobal_AutoQASupport:writeLogFile("[\235\172\180\234\184\176 \236\157\188\235\176\152 \234\176\149\237\153\148] \237\133\140\236\138\164\237\138\184 \236\139\156\236\158\145", true)
        Proc_ShowMessage_Ack("\235\172\180\234\184\176 \236\157\188\235\176\152 \234\176\149\237\153\148 \236\139\156\236\158\145")
      end
    elseif self._enhance._weaponLevel < 17 then
      PaGlobal_AutoQASupport:writeLogFile("[\235\172\180\234\184\176 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\133\140\236\138\164\237\138\184 \236\139\156\236\158\145", true)
      Proc_ShowMessage_Ack("\235\172\180\234\184\176 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148 \236\139\156\236\158\145")
    end
  end
  local enchantWeaponKey = self._enhance._weaponKey
  saveItemSlotForQA(CppEnums.ItemWhereType.eInventory, enchantWeaponKey)
  local targetSlotNo = getItemSlotForQA()
  PaGlobal_SpiritEnchant_All:setCheckFunc("SkipAni", true)
  if targetSlotNo == nil then
    ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \234\176\149\237\153\148\237\149\160 \235\172\180\234\184\176\235\165\188 \236\176\190\235\138\148\235\141\176 \236\139\164\237\140\168\237\149\152\236\152\128\236\138\181\235\139\136\235\139\164.")
  else
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, targetSlotNo + 2)
    self._enhance._weaponLevel = itemWrapper:get():getKey():getEnchantLevel()
    self._enhance._weaponMaxEndurance = itemWrapper:get():getMaxEndurance()
    self._enhance._weaponMat1Count = QA_ItemStackCount(self._enhance._weaponMat1Key)
    self._enhance._weaponMat2Count = QA_ItemStackCount(self._enhance._weaponMat2Key)
    self._enhance._cronCount = QA_ItemStackCount(self._enhance._cronKey)
    self._enhance._failCount = getEnchantInformation():ToClient_getFailCount()
    self._enhance._valksCount = getEnchantInformation():ToClient_getValksCount()
    self._enhance._bonusCount = getEnchantInformation():ToClient_getBonusStackCount()
    if self._enhance._weaponLevel == 20 then
      ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \235\143\153 \236\158\165\235\185\132\235\138\148 \234\176\149\237\153\148\237\149\160 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164. \236\158\172\236\132\164\236\160\149\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.")
    elseif self._enhance._weaponLevel > 20 or 0 > self._enhance._weaponLevel or self._enhance._weaponLevel == nil then
      ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \237\149\180\235\139\185 \236\158\165\235\185\132\236\157\152 \236\158\165\235\185\132 \235\160\136\235\178\168\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.")
    elseif self._enhance._isCronApplied == true then
      if self._enhance._weaponLevel < 17 then
        ToClient_qaRegisterTimerForQA(100, "deleteItem(" .. getSelfPlayer():getActorKey() .. "," .. CppEnums.ItemWhereType.eInventory .. "," .. targetSlotNo .. "+2,1)")
        ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(" .. self._enhance._weaponKey .. ",17,1)")
        self._enhance._weaponLevel = 17
        self._enhance._weaponMaxEndurance = 100
        ToClient_qaRegisterTimerForQA(500, "QA_BlackSpirit:enhanceWeaponStart()")
      else
        self._enhance._failCount = 100
        ToClient_qaRegisterTimerForQA(100, "ToClient_qaResetEnchantFailCount()")
        ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(17899,0,1)")
        ToClient_qaRegisterTimerForQA(1000, "ToClient_qaUseInventoryItem(17899,0)")
        ToClient_qaRegisterTimerForQA(100, "messageBox_YesButtonUp()")
        Inventory_SlotRClick_ForQA(100, targetSlotNo)
        ToClient_qaRegisterTimerForQA(100, "QA_BlackSpirit:checkCronStone()")
        Inventory_SlotRClick_ForQA(100, targetSlotNo)
        ToClient_qaRegisterTimerForQA(100, "PaGlobal_SpiritEnchant_All:setCheckFunc('Cron', true)")
        ToClient_qaRegisterTimerForQA(1000, "QA_BlackSpirit:enhanceWeapon()")
      end
    else
      if self._enhance._failCount >= 50 then
        self._enhance._failCount = 0
        ToClient_qaRegisterTimerForQA(100, "ToClient_qaResetEnchantFailCount()")
      end
      Inventory_SlotRClick_ForQA(100, targetSlotNo)
      ToClient_qaRegisterTimerForQA(100, "QA_BlackSpirit:enhanceWeapon()")
    end
  end
end
function QA_BlackSpirit:enhanceWeapon()
  self._enhance._cronCount = QA_ItemStackCount(self._enhance._cronKey)
  ToClient_qaRegisterTimerForQA(100, "HandleEventLUp_SpiritEnchant_All_EnchantApplyButton()")
  ToClient_qaRegisterTimerForQA(100, "messageBox_YesButtonUp()")
  if self._enhance._isForceEnhance == false then
    ToClient_qaRegisterTimerForQA(2500, "QA_BlackSpirit:checkWeaponEnchantResult()")
  else
    ToClient_qaRegisterTimerForQA(2500, "QA_BlackSpirit:forceWeaponEnhanceResult()")
  end
end
function QA_BlackSpirit:checkWeaponEnchantResult()
  local enchantWeaponKey = self._enhance._weaponKey
  saveItemSlotForQA(CppEnums.ItemWhereType.eInventory, enchantWeaponKey)
  local targetSlotNo = getItemSlotForQA()
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, targetSlotNo + 2)
  self._enhance._weaponLevelNext = itemWrapper:get():getKey():getEnchantLevel()
  self._enhance._weaponMaxEnduranceNext = itemWrapper:get():getMaxEndurance()
  self._enhance._weaponMat1CountNext = QA_ItemStackCount(self._enhance._weaponMat1Key)
  self._enhance._weaponMat2CountNext = QA_ItemStackCount(self._enhance._weaponMat2Key)
  self._enhance._cronCountNext = QA_ItemStackCount(self._enhance._cronKey)
  self._enhance._failCountNext = getEnchantInformation():ToClient_getFailCount()
  self._enhance._valksCountNext = getEnchantInformation():ToClient_getValksCount()
  self._enhance._bonusCountNext = getEnchantInformation():ToClient_getBonusStackCount()
  if false == self._enhance._isCronApplied then
    if self._enhance._weaponLevel < 7 then
      if PaGlobal_AutoQASupport._enchantResult._resultType == 0 then
        if self._enhance._weaponLevel + 1 ~= self._enhance._weaponLevelNext then
          ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \236\149\136\236\160\132\234\176\149\237\153\148 \234\178\176\234\179\188\234\176\128 \236\132\177\234\179\181\236\157\180\236\167\128\235\167\140 \234\176\149\237\153\148 \235\160\136\235\178\168\236\157\180 \236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\152\172\235\157\188\234\176\128\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.")
        elseif self._enhance._failCountNext ~= self._enhance._failCount then
          ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \236\149\136\236\160\132\234\176\149\237\153\148 \236\157\180\237\155\132 \235\176\156\237\129\172\236\138\164\236\157\152 \236\161\176\236\150\184 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
        elseif self._enhance._valksCountNext ~= self._enhance._valksCount then
          ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \236\149\136\236\160\132\234\176\149\237\153\148 \236\157\180\237\155\132 \235\176\156\237\129\172\236\138\164\236\157\152 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
        elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
          ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \236\149\136\236\160\132\234\176\149\237\153\148 \236\157\180\237\155\132 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
        elseif self._enhance._weaponMaxEnduranceNext ~= self._enhance._weaponMaxEndurance then
          ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \236\149\136\236\160\132\234\176\149\237\153\148 \236\157\180\237\155\132 \234\176\149\237\153\148\234\176\128 \236\132\177\234\179\181\237\149\152\236\152\128\236\167\128\235\167\140 \237\149\180\235\139\185 \236\158\165\235\185\132\236\157\152 \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
        elseif self._enhance._weaponMat1Count == self._weaponMat1CountNext and self._enhance._weaponMat2Count == self._weaponMat2CountNext then
          ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \234\176\149\237\153\148\234\176\128 \236\167\132\237\150\137\235\144\152\236\151\136\236\156\188\235\130\152 \234\176\149\237\153\148\236\158\172\235\163\140\236\157\152 \236\150\145\236\157\180 \235\179\128\237\149\152\236\167\128 \236\149\138\236\149\152\235\139\164!")
        else
          Proc_ShowMessage_Ack("\235\172\180\234\184\176 \234\176\149\237\153\148 \236\132\177\234\179\181")
          self._enhance._isSuccess = true
        end
      else
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \236\149\136\236\160\132\234\176\149\237\153\148 \234\181\172\234\176\132\236\158\132\236\151\144\235\143\132 \235\182\136\234\181\172\237\149\152\234\179\160 \234\176\149\237\153\148\234\178\176\234\179\188\234\176\128 \236\160\149\236\131\129\236\160\129\236\157\180\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164. ( resultType : " .. PaGlobal_AutoQASupport._enchantResult._resultType .. " ) \236\132\177\234\179\181\236\151\172\235\182\128\236\157\152 \237\153\149\236\157\184\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.")
      end
    elseif PaGlobal_AutoQASupport._enchantResult._resultType == -1 then
      ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \234\176\149\237\153\148 \234\178\176\234\179\188 \236\160\128\236\158\165\236\151\144 \236\139\164\237\140\168\237\150\136\236\138\181\235\139\136\235\139\164. resultType \237\153\149\236\157\184 \237\149\132\236\154\148")
    elseif PaGlobal_AutoQASupport._enchantResult._resultType == 0 then
      if self._enhance._weaponLevel + 1 ~= self._enhance._weaponLevelNext then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \234\176\149\237\153\148 \234\178\176\234\179\188\234\176\128 \236\132\177\234\179\181\236\157\180\236\167\128\235\167\140 \234\176\149\237\153\148 \235\160\136\235\178\168\236\157\180 \236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\152\172\235\157\188\234\176\128\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._failCountNext ~= 0 then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \235\176\156\237\129\172\236\138\164\236\157\152 \236\161\176\236\150\184 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\132\164\236\160\149\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._valksCountNext ~= 0 then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \235\176\156\237\129\172\236\138\164\236\157\152 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\132\164\236\160\149\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._weaponMaxEnduranceNext ~= self._enhance._weaponMaxEndurance then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \234\176\149\237\153\148\234\176\128 \236\132\177\234\179\181\237\149\152\236\152\128\236\167\128\235\167\140 \237\149\180\235\139\185 \236\158\165\235\185\132\236\157\152 \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._weaponMat1Count == self._weaponMat1CountNext and self._enhance._weaponMat2Count == self._weaponMat2CountNext then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \234\176\149\237\153\148\234\176\128 \236\167\132\237\150\137\235\144\152\236\151\136\236\156\188\235\130\152 \234\176\149\237\153\148\236\158\172\235\163\140\236\157\152 \236\150\145\236\157\180 \235\179\128\234\178\189\235\144\152\236\167\128 \236\149\138\236\149\152\235\139\164?")
      else
        Proc_ShowMessage_Ack("\235\172\180\234\184\176 \234\176\149\237\153\148 \236\132\177\234\179\181")
        self._enhance._isSuccess = true
      end
    elseif PaGlobal_AutoQASupport._enchantResult._resultType == 2 then
      if self._enhance._weaponLevel <= 16 then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] 16\234\176\149(\236\158\165)\236\157\180\237\149\152 \235\172\180\234\184\176\236\157\184\235\141\176 17\234\176\149(\234\180\145)\236\157\180\236\131\129 \236\158\165\235\185\132\236\157\152 \236\139\164\237\140\168 \234\178\176\234\179\188\234\176\128 \235\130\152\236\153\148\235\139\164.")
      elseif self._enhance._weaponLevel >= 20 or self._enhance._weaponLevel == nil then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \235\172\180\234\184\176 \235\160\136\235\178\168\236\157\180 \235\185\132\236\160\149\236\131\129\236\157\180\235\139\164.")
      else
        if self._enhance._weaponMaxEnduranceNext < 10 then
          ToClient_qaRegisterTimerForQA(100, "deleteItem(" .. getSelfPlayer():getActorKey() .. "," .. CppEnums.ItemWhereType.eInventory .. "," .. targetSlotNo .. "+2,1)")
          ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(" .. self._enhance._weaponKey .. "," .. self._enhance._weaponLevelNext .. ",1)")
        end
        Proc_ShowMessage_Ack("\234\176\149\237\153\148 \236\139\164\237\140\168 \237\155\132 \235\160\136\235\178\168 \237\149\152\235\157\189")
        _PA_LOG("AutoQA", "\234\176\149\237\153\148 \236\139\164\237\140\168 \237\155\132 \235\160\136\235\178\168 \237\149\152\235\157\189")
        self._enhance._isFail = true
      end
    elseif PaGlobal_AutoQASupport._enchantResult._resultType == 3 then
      if self._enhance._weaponLevel > 16 or self._enhance._weaponLevel - 1 == self._enhance._weaponLevelNext then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \234\180\145 \236\157\180\236\131\129 \236\158\165\235\185\132\236\151\144\236\132\156 \235\130\152\236\153\128\236\132\160 \236\149\136 \235\144\160 \234\178\176\234\179\188\236\158\133\235\139\136\235\139\164. \234\176\149\237\153\148\235\139\168\234\179\132\234\176\128 \235\150\168\236\150\180\236\167\128\236\167\128 \236\149\138\236\149\152\235\138\148\236\167\128 \237\153\149\236\157\184\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164.")
      elseif self._enhance._weaponLevel <= 16 and self._enhance._weaponLevel ~= self._enhance._weaponLevelNext then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \236\139\164\237\140\168\237\149\180\235\143\132 \234\176\149\237\153\148\236\136\152\236\185\152\234\176\128 \235\150\168\236\150\180\236\167\128\236\167\128 \236\149\138\236\149\132\236\149\188 \237\149\160 \234\176\149\237\153\148\236\157\184\235\141\176 \234\176\149\237\153\148\236\136\152\236\185\152\234\176\128 \235\150\168\236\150\180\236\161\140\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._failCountNext < self._enhance._failCount then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \234\176\149\237\153\148\236\151\144 \236\139\164\237\140\168\237\149\152\236\152\128\235\138\148\235\141\176 \234\176\149\237\153\148 \236\138\164\237\131\157\236\157\180 \235\130\180\235\160\164\234\176\148\235\139\164.")
      elseif self._enhance._valksCountNext ~= self._enhance._valksCount then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \234\176\149\237\153\148\236\151\144 \236\139\164\237\140\168\237\149\152\236\152\128\235\138\148\235\141\176 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
      elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._weaponMaxEnduranceNext >= self._enhance._weaponMaxEndurance then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \234\176\149\237\153\148\236\151\144 \236\139\164\237\140\168\237\149\152\236\152\128\235\138\148\235\141\176 \236\181\156\235\140\128\235\130\180\234\181\172\235\143\132\234\176\128 \234\185\142\236\157\180\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._weaponMat1Count == self._weaponMat1CountNext and self._enhance._weaponMat2Count == self._weaponMat2CountNext then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \234\176\149\237\153\148\234\176\128 \236\167\132\237\150\137\235\144\152\236\151\136\236\156\188\235\130\152 \234\176\149\237\153\148\236\158\172\235\163\140\236\157\152 \236\150\145\236\157\180 \235\179\128\234\178\189\235\144\152\236\167\128 \236\149\138\236\149\152\235\139\164?")
      elseif self._enhance._cronCount ~= self._enhance._cronCountNext then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\156\236\136\152\234\176\128 \236\164\132\236\150\180\235\147\164\236\167\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164?")
      else
        if self._enhance._weaponMaxEnduranceNext == 0 then
          ToClient_qaRegisterTimerForQA(100, "deleteItem(" .. getSelfPlayer():getActorKey() .. "," .. CppEnums.ItemWhereType.eInventory .. "," .. targetSlotNo .. "+2,1)")
          ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(" .. self._enhance._weaponKey .. "," .. self._enhance._weaponLevelNext .. ",1)")
        end
        Proc_ShowMessage_Ack("\235\172\180\234\184\176 \234\176\149\237\153\148 \236\139\164\237\140\168")
        self._enhance._isFail = true
      end
    elseif PaGlobal_AutoQASupport._enchantResult._resultType == 5 then
      if self._enhance._weaponLevel ~= self._enhance._weaponLevelNext then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \234\176\149\237\153\148\236\136\152\236\185\152\234\176\128 \235\139\172\235\157\188\236\160\184 \236\158\136\235\139\164")
      elseif self._enhance._failCountNext ~= self._enhance._failCount then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148[ \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \234\176\149\237\153\148\236\138\164\237\131\157\236\157\180 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
      elseif self._enhance._valksCountNext ~= self._enhance._valksCount then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148[ \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
      elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148[ \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
      elseif self._enhance._weaponMaxEndurance ~= self._enhance._weaponMaxEnduranceNext then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132\234\176\128 \235\139\172\235\157\188\236\160\184 \236\158\136\235\139\164")
      elseif self._enhance._weaponMat1Count ~= self._enhance._weaponMat1CountNext or self._enhance._weaponMat2Count ~= self._enhance._weaponMat2CountNext then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \234\176\149\237\153\148\236\158\172\235\163\140 \234\176\156\236\136\152\234\176\128 \235\139\172\235\157\188\236\160\184 \236\158\136\235\139\164")
      elseif self._enhance._cronCount ~= self._enhance._cronCountNext then
        ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\156\236\136\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164?")
      else
        Proc_ShowMessage_Ack("\235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177")
        ToClient_qaRegisterTimerForQA(100, "HandleEventRUp_SpiritEnchant_All_ReleseTargetItem()")
        ToClient_qaRegisterTimerForQA(100, "deleteItem(" .. getSelfPlayer():getActorKey() .. "," .. CppEnums.ItemWhereType.eInventory .. "," .. targetSlotNo .. "+2,1)")
        ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(" .. self._enhance._weaponKey .. "," .. self._enhance._weaponLevel .. ",1)")
      end
    elseif PaGlobal_AutoQASupport._enchantResult._resultType == 1 then
      _PA_LOG("AutoQA", "resultType : " .. PaGlobal_AutoQASupport._enchantResult._resultType)
      ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \236\149\133\236\132\184\236\132\156\235\166\172 \234\176\149\237\153\148\234\176\128 \236\149\132\235\139\140\235\141\176 \236\149\133\236\132\184\236\132\156\235\166\172 \234\178\176\234\179\188(\234\176\149\237\153\148 \236\139\164\237\140\168 \237\155\132 \237\140\140\234\180\180)\234\176\128 \235\130\152\236\153\148\236\138\181\235\139\136\235\139\164.")
    elseif PaGlobal_AutoQASupport._enchantResult._resultType == 4 then
      ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157\236\157\132 \236\130\172\236\154\169\237\149\152\236\167\128 \236\149\138\236\149\152\236\156\188\235\130\152 \237\129\172\235\161\160\236\132\157 \234\178\176\234\179\188\234\176\146\236\157\180 \235\130\152\236\153\148\236\138\181\235\139\136\235\139\164. \237\153\149\236\157\184\237\149\180\235\180\144\236\149\188 \237\149\169\235\139\136\235\139\164.")
    else
      ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \236\158\152\235\170\187\235\144\156 resultType! \236\131\136\235\161\156 \236\182\148\234\176\128\235\144\156 \234\178\131\236\157\184\234\176\128..")
    end
  elseif PaGlobal_AutoQASupport._enchantResult._resultType == -1 then
    ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \234\176\149\237\153\148 \234\178\176\234\179\188 \236\160\128\236\158\165\236\151\144 \236\139\164\237\140\168\237\150\136\236\138\181\235\139\136\235\139\164. resultType \237\153\149\236\157\184 \237\149\132\236\154\148")
  elseif PaGlobal_AutoQASupport._enchantResult._resultType == 0 then
    if self._enhance._weaponLevel + 1 ~= self._enhance._weaponLevelNext then
      ErrorHandler("[\235\172\180\234\184\176 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148 \234\178\176\234\179\188\234\176\128 \236\132\177\234\179\181\236\157\180\236\167\128\235\167\140 \234\176\149\237\153\148 \235\160\136\235\178\168\236\157\180 \236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\152\172\235\157\188\234\176\128\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._failCountNext ~= 0 then
      ErrorHandler("[\235\172\180\234\184\176 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \235\176\156\237\129\172\236\138\164\236\157\152 \236\161\176\236\150\184 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\132\164\236\160\149\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._valksCountNext ~= 0 then
      ErrorHandler("[\235\172\180\234\184\176 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \235\176\156\237\129\172\236\138\164\236\157\152 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\132\164\236\160\149\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
      ErrorHandler("[\235\172\180\234\184\176 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._weaponMaxEnduranceNext ~= self._enhance._weaponMaxEndurance then
      ErrorHandler("[\235\172\180\234\184\176 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \234\176\149\237\153\148\234\176\128 \236\132\177\234\179\181\237\149\152\236\152\128\236\167\128\235\167\140 \237\149\180\235\139\185 \236\158\165\235\185\132\236\157\152 \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._weaponMat1Count == self._weaponMat1CountNext and self._enhance._weaponMat2Count == self._weaponMat2CountNext then
      ErrorHandler("[\235\172\180\234\184\176 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148\234\176\128 \236\167\132\237\150\137\235\144\152\236\151\136\236\156\188\235\130\152 \234\176\149\237\153\148\236\158\172\235\163\140\236\157\152 \236\150\145\236\157\180 \235\179\128\234\178\189\235\144\152\236\167\128 \236\149\138\236\149\152\235\139\164?")
    elseif self._enhance._cronCount <= self._enhance._cronCountNext then
      ErrorHandler("[\235\172\180\234\184\176 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\156\236\136\152\234\176\128 \236\164\132\236\150\180\235\147\164\236\167\128 \236\149\138\236\149\152\235\139\164.")
    else
      Proc_ShowMessage_Ack("\237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148 \236\132\177\234\179\181")
      self._enhance._isSuccess = true
    end
  elseif PaGlobal_AutoQASupport._enchantResult._resultType == 4 then
    if self._enhance._weaponLevel > 16 and self._enhance._weaponLevel ~= self._enhance._weaponLevelNext then
      ErrorHandler("[\235\172\180\234\184\176 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148\234\176\128 \236\167\132\237\150\137\235\144\152\236\151\136\236\156\188\235\130\152, \236\139\164\237\140\168 \237\155\132 \236\158\165\235\185\132\235\160\136\235\178\168\236\157\180 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
    elseif self._enhance._weaponLevel <= 16 and self._enhance._weaponLevel ~= self._enhance._weaponLevelNext then
      ErrorHandler("[\235\172\180\234\184\176 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148\234\176\128 \236\167\132\237\150\137\235\144\152\236\151\136\236\156\188\235\130\152, \236\139\164\237\140\168\237\149\180\235\143\132 \234\176\149\237\153\148\236\136\152\236\185\152\234\176\128 \235\150\168\236\150\180\236\167\128\236\167\128 \236\149\138\236\149\132\236\149\188 \237\149\160 \234\176\149\237\153\148\236\151\144\236\132\156 \234\176\149\237\153\148\236\136\152\236\185\152\234\176\128 \235\150\168\236\150\180\236\161\140\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._failCountNext ~= self._enhance._failCount then
      ErrorHandler("[\235\172\180\234\184\176 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148\235\157\188 \236\139\164\237\140\168 \236\139\156 \236\138\164\237\131\157\236\157\180 \236\156\160\236\167\128\235\144\152\236\150\180\236\149\188 \237\149\152\235\138\148\235\141\176 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164!")
    elseif self._enhance._valksCountNext ~= self._enhance._valksCount then
      ErrorHandler("[\235\172\180\234\184\176 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148\236\151\144 \236\139\164\237\140\168\237\149\152\236\152\128\235\138\148\235\141\176 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
    elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
      ErrorHandler("[\235\172\180\234\184\176 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148 \236\157\180\237\155\132 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._weaponMaxEnduranceNext >= self._enhance._weaponMaxEndurance then
      ErrorHandler("[\235\172\180\234\184\176 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148\236\151\144 \236\139\164\237\140\168\237\149\152\236\152\128\235\138\148\235\141\176 \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132\234\176\128 \234\185\142\236\157\180\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._weaponMat1Count == self._weaponMat1CountNext and self._enhance._weaponMat2Count == self._weaponMat2CountNext then
      ErrorHandler("[\235\172\180\234\184\176 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148\234\176\128 \236\167\132\237\150\137\235\144\152\236\151\136\236\156\188\235\130\152 \234\176\149\237\153\148\236\158\172\235\163\140\236\157\152 \236\150\145\236\157\180 \235\179\128\234\178\189\235\144\152\236\167\128 \236\149\138\236\149\152\235\139\164?")
    elseif self._enhance._cronCount <= self._enhance._cronCountNext then
      ErrorHandler("[\235\172\180\234\184\176 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\156\236\136\152\234\176\128 \236\164\132\236\150\180\235\147\164\236\167\128 \236\149\138\236\149\152\235\139\164?")
    else
      if self._enhance._weaponMaxEnduranceNext < 10 or self._enhance._weaponLevel < 17 or self._enhance._weaponLevel == 20 then
        ToClient_qaRegisterTimerForQA(100, "deleteItem(" .. getSelfPlayer():getActorKey() .. "," .. CppEnums.ItemWhereType.eInventory .. "," .. targetSlotNo .. "+2,1)")
        ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(" .. self._enhance._weaponKey .. "," .. self._enhance._weaponLevelNext .. ",1)")
      end
      Proc_ShowMessage_Ack("\237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148 \236\139\164\237\140\168")
      self._enhance._isFail = true
    end
  elseif PaGlobal_AutoQASupport._enchantResult._resultType == 5 then
    if self._enhance._weaponLevel ~= self._enhance._weaponLevelNext then
      ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \234\176\149\237\153\148\236\136\152\236\185\152\234\176\128 \235\139\172\235\157\188\236\160\184 \236\158\136\235\139\164")
    elseif self._enhance._failCountNext ~= self._enhance._failCount then
      ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148[ \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \234\176\149\237\153\148\236\138\164\237\131\157\236\157\180 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
    elseif self._enhance._valksCountNext ~= self._enhance._valksCount then
      ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148[ \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
    elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
      ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148[ \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
    elseif self._enhance._weaponMaxEndurance ~= self._enhance._weaponMaxEnduranceNext then
      ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132\234\176\128 \235\139\172\235\157\188\236\160\184 \236\158\136\235\139\164")
    elseif self._enhance._weaponMat1Count ~= self._enhance._weaponMat1CountNext or self._enhance._weaponMat2Count ~= self._enhance._weaponMat2CountNext then
      ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \234\176\149\237\153\148\236\158\172\235\163\140 \234\176\156\236\136\152\234\176\128 \235\139\172\235\157\188\236\160\184 \236\158\136\235\139\164")
    elseif self._enhance._cronCount ~= self._enhance._cronCountNext then
      ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\156\236\136\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164?")
    else
      Proc_ShowMessage_Ack("\235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177")
      ToClient_qaRegisterTimerForQA(100, "HandleEventRUp_SpiritEnchant_All_ReleseTargetItem()")
      ToClient_qaRegisterTimerForQA(100, "deleteItem(" .. getSelfPlayer():getActorKey() .. "," .. CppEnums.ItemWhereType.eInventory .. "," .. targetSlotNo .. "+2,1)")
      ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(" .. self._enhance._weaponKey .. "," .. self._enhance._weaponLevel .. ",1)")
    end
  elseif PaGlobal_AutoQASupport._enchantResult._resultType == 1 or PaGlobal_AutoQASupport._enchantResult._resultType == 2 then
    _PA_LOG("AutoQA", "resultType : " .. PaGlobal_AutoQASupport._enchantResult._resultType)
    ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \236\149\133\236\132\184\236\132\156\235\166\172 \234\176\149\237\153\148\234\176\128 \236\149\132\235\139\140\235\141\176 \236\149\133\236\132\184\236\132\156\235\166\172 \234\176\149\237\153\148 \234\178\176\234\179\188\234\176\128 \235\130\152\236\153\148\236\138\181\235\139\136\235\139\164.")
  elseif PaGlobal_AutoQASupport._enchantResult._resultType == 4 then
    ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157\236\157\132 \236\130\172\236\154\169\237\149\152\236\167\128 \236\149\138\236\149\152\236\156\188\235\130\152 \237\129\172\235\161\160\236\132\157 \234\178\176\234\179\188\234\176\146\236\157\180 \235\130\152\236\153\148\236\138\181\235\139\136\235\139\164. \237\153\149\236\157\184\237\149\180\235\180\144\236\149\188 \237\149\169\235\139\136\235\139\164.")
  else
    ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \236\158\152\235\170\187\235\144\156 resultType! \236\131\136\235\161\156 \236\182\148\234\176\128\235\144\156 \234\178\131\236\157\184\234\176\128..")
  end
  if true == self._enhance._isSuccess and true == self._enhance._isFail then
    self._enhance._weaponLevel = -1
    self._enhance._weaponLevelNext = -1
    self._enhance._isSuccess = false
    self._enhance._isFail = false
    if self._enhance._isCronApplied == false then
      PaGlobal_AutoQASupport:writeLogFile("[\235\172\180\234\184\176 \236\157\188\235\176\152 \234\176\149\237\153\148] \237\133\140\236\138\164\237\138\184 \236\162\133\235\163\140", true)
      self._enhance._isCronApplied = true
      PaGlobal_AutoQASupport._enchantResult._resultType = -1
      ToClient_qaRegisterTimerForQA(100, "QA_BlackSpirit:checkWeaponMaterial()")
    else
      PaGlobal_AutoQASupport:writeLogFile("[\235\172\180\234\184\176 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\133\140\236\138\164\237\138\184 \236\162\133\235\163\140", true)
      self._enhance._isCronApplied = false
      PaGlobal_AutoQASupport._enchantResult._resultType = -1
      ToClient_qaRegisterTimerForQA(100, "QA_BlackSpirit:forceEnhanceWeaponStart()")
    end
  else
    self._enhance._weaponLevel = self._enhance._weaponLevelNext
    ToClient_qaRegisterTimerForQA(500, "QA_BlackSpirit:checkWeaponMaterial()")
  end
end
function QA_BlackSpirit:forceEnhanceWeaponStart()
  self._enhance._isForceEnhance = true
  ToClient_qaRegisterTimerForQA(0, "HandleEventLUp_SpiritEnchant_All_MainTabSelect(1)")
  ToClient_qaRegisterTimerForQA(100, "PaGlobal_Inventory_UnCheckAutoSort()")
  local enchantWeaponKey = self._enhance._weaponKey
  saveItemSlotForQA(CppEnums.ItemWhereType.eInventory, enchantWeaponKey)
  local targetSlotNo = getItemSlotForQA()
  PaGlobal_SpiritEnchant_All:setCheckFunc("SkipAni", true)
  if targetSlotNo == nil then
    PaGlobal_AutoQASupport:writeLogFile("[\235\172\180\234\184\176 \234\176\149\236\160\156 \234\176\149\237\153\148] \237\133\140\236\138\164\237\138\184 \236\139\156\236\158\145", true)
    ErrorHandler("[\235\172\180\234\184\176 \234\176\149\236\160\156 \234\176\149\237\153\148] \234\176\149\236\160\156 \234\176\149\237\153\148\237\149\160 \235\172\180\234\184\176\235\165\188 \236\176\190\235\138\148\235\141\176 \236\139\164\237\140\168\237\149\152\236\152\128\236\138\181\235\139\136\235\139\164.")
  else
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, targetSlotNo + 2)
    self._enhance._weaponLevel = itemWrapper:get():getKey():getEnchantLevel()
    self._enhance._weaponMaxEndurance = itemWrapper:get():getMaxEndurance()
    self._enhance._weaponMat1Count = QA_ItemStackCount(self._enhance._weaponMat1Key)
    self._enhance._weaponMat2Count = QA_ItemStackCount(self._enhance._weaponMat2Key)
    self._enhance._cronCount = QA_ItemStackCount(self._enhance._cronKey)
    self._enhance._failCount = getEnchantInformation():ToClient_getFailCount()
    self._enhance._valksCount = getEnchantInformation():ToClient_getValksCount()
    self._enhance._bonusCount = getEnchantInformation():ToClient_getBonusStackCount()
    if self._enhance._weaponLevel > 14 or self._enhance._weaponLevel < 7 or self._enhance._weaponMaxEndurance ~= 100 then
      ToClient_qaRegisterTimerForQA(100, "deleteItem(" .. getSelfPlayer():getActorKey() .. "," .. CppEnums.ItemWhereType.eInventory .. "," .. targetSlotNo .. "+2,1)")
      ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(" .. self._enhance._weaponKey .. "," .. math.random(7, 14) .. ",1)")
      ToClient_qaRegisterTimerForQA(100, "QA_BlackSpirit:forceEnhanceWeaponStart()")
    elseif self._enhance._weaponLevel > 20 or 0 > self._enhance._weaponLevel or self._enhance._weaponLevel == nil then
      ErrorHandler("[\235\172\180\234\184\176 \234\176\149\236\160\156 \234\176\149\237\153\148] \237\149\180\235\139\185 \236\158\165\235\185\132\236\157\152 \236\158\165\235\185\132 \235\160\136\235\178\168\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.")
    else
      PaGlobal_AutoQASupport:writeLogFile("[\235\172\180\234\184\176 \234\176\149\236\160\156 \234\176\149\237\153\148] \237\133\140\236\138\164\237\138\184 \236\139\156\236\158\145", true)
      Proc_ShowMessage_Ack("\235\172\180\234\184\176 \234\176\149\236\160\156 \234\176\149\237\153\148 \236\139\156\236\158\145")
      Inventory_SlotRClick_ForQA(100, targetSlotNo)
      ToClient_qaRegisterTimerForQA(1000, "QA_BlackSpirit:checkForceWeaponBS()")
      Inventory_SlotRClick_ForQA(100, targetSlotNo)
      ToClient_qaRegisterTimerForQA(100, "PaGlobal_SpiritEnchant_All:setCheckFunc('Force', true)")
      ToClient_qaRegisterTimerForQA(100, "QA_BlackSpirit:enhanceWeapon()")
    end
  end
end
function QA_BlackSpirit:forceWeaponEnhanceResult()
  local enchantWeaponKey = self._enhance._weaponKey
  saveItemSlotForQA(CppEnums.ItemWhereType.eInventory, enchantWeaponKey)
  local targetSlotNo = getItemSlotForQA()
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, targetSlotNo + 2)
  self._enhance._weaponLevelNext = itemWrapper:get():getKey():getEnchantLevel()
  self._enhance._weaponMaxEnduranceNext = itemWrapper:get():getMaxEndurance()
  self._enhance._weaponMat1CountNext = QA_ItemStackCount(self._enhance._weaponMat1Key)
  self._enhance._weaponMat2CountNext = QA_ItemStackCount(self._enhance._weaponMat2Key)
  self._enhance._cronCountNext = QA_ItemStackCount(self._enhance._cronKey)
  self._enhance._failCountNext = getEnchantInformation():ToClient_getFailCount()
  self._enhance._valksCountNext = getEnchantInformation():ToClient_getValksCount()
  self._enhance._bonusCountNext = getEnchantInformation():ToClient_getBonusStackCount()
  if PaGlobal_AutoQASupport._enchantResult._resultType == -1 then
    ErrorHandler("[\235\172\180\234\184\176 \234\176\149\236\160\156 \234\176\149\237\153\148] \234\176\149\237\153\148 \234\178\176\234\179\188 \236\160\128\236\158\165\236\151\144 \236\139\164\237\140\168\237\150\136\236\138\181\235\139\136\235\139\164. resultType \237\153\149\236\157\184 \237\149\132\236\154\148")
  elseif PaGlobal_AutoQASupport._enchantResult._resultType == 0 then
    if self._enhance._weaponLevel + 1 ~= self._enhance._weaponLevelNext then
      ErrorHandler("[\235\172\180\234\184\176 \234\176\149\236\160\156 \234\176\149\237\153\148] \234\176\149\236\160\156 \234\176\149\237\153\148 \237\155\132 \234\176\149\237\153\148 \236\132\177\234\179\181\236\157\180\236\167\128\235\167\140 \234\176\149\237\153\148 \235\160\136\235\178\168\236\157\180 \236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\152\172\235\157\188\234\176\128\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._failCountNext ~= self._enhance._failCount then
      ErrorHandler("[\235\172\180\234\184\176 \234\176\149\236\160\156 \234\176\149\237\153\148] \234\176\149\236\160\156 \234\176\149\237\153\148 \236\157\180\237\155\132 \235\176\156\237\129\172\236\138\164\236\157\152 \236\161\176\236\150\184 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._valksCountNext ~= self._enhance._valksCount then
      ErrorHandler("[\235\172\180\234\184\176 \234\176\149\236\160\156 \234\176\149\237\153\148] \234\176\149\236\160\156 \234\176\149\237\153\148 \236\157\180\237\155\132 \235\176\156\237\129\172\236\138\164\236\157\152 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
      ErrorHandler("[\235\172\180\234\184\176 \234\176\149\236\160\156 \234\176\149\237\153\148] \234\176\149\236\160\156 \234\176\149\237\153\148 \236\157\180\237\155\132 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._weaponMaxEndurance <= self._enhance._weaponMaxEnduranceNext then
      ErrorHandler("[\235\172\180\234\184\176 \234\176\149\236\160\156 \234\176\149\237\153\148] \234\176\149\236\160\156 \234\176\149\237\153\148 \236\157\180\237\155\132 \237\149\180\235\139\185 \236\158\165\235\185\132\236\157\152 \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132\234\176\128 \236\164\132\236\150\180\235\147\164\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._weaponMat1Count == self._weaponMat1CountNext and self._enhance._weaponMat2Count == self._weaponMat2CountNext then
      ErrorHandler("[\235\172\180\234\184\176 \234\176\149\236\160\156 \234\176\149\237\153\148] \234\176\149\236\160\156 \234\176\149\237\153\148 \236\157\180\237\155\132 \234\176\149\237\153\148\236\158\172\235\163\140\236\157\152 \236\150\145\236\157\180 \235\179\128\234\178\189\235\144\152\236\167\128 \236\149\138\236\149\152\235\139\164?")
    elseif self._enhance._cronCount ~= self._enhance._cronCountNext then
      ErrorHandler("[\235\172\180\234\184\176 \234\176\149\236\160\156 \234\176\149\237\153\148] \234\176\149\236\160\156 \234\176\149\237\153\148 \236\157\180\237\155\132 \237\129\172\235\161\160\236\132\157 \234\176\156\236\136\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
    else
      PaGlobal_AutoQASupport._enchantResult._resultType = -1
      self._enhance._isForceEnhance = false
      Proc_ShowMessage_Ack("\234\176\149\236\160\156 \234\176\149\237\153\148 \236\132\177\234\179\181")
      PaGlobal_AutoQASupport:writeLogFile("[\235\172\180\234\184\176 \234\176\149\236\160\156 \234\176\149\237\153\148] \237\133\140\236\138\164\237\138\184 \236\162\133\235\163\140", true)
      ToClient_qaResetEnchantFailCount()
      ToClient_qaRegisterTimerForQA(100, "QA_BlackSpirit:checkArmorMaterial()")
    end
  elseif PaGlobal_AutoQASupport._enchantResult._resultType == 5 then
    ToClient_qaRegisterTimerForQA(100, "deleteItem(" .. getSelfPlayer():getActorKey() .. "," .. CppEnums.ItemWhereType.eInventory .. "," .. targetSlotNo .. "+2,1)")
    ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(" .. self._enhance._weaponKey .. "," .. self._enhance._weaponLevelNext .. ",1)")
  else
    ErrorHandler("[\235\172\180\234\184\176 \234\176\149\237\153\148] \234\176\149\236\160\156 \234\176\149\237\153\148 \234\178\176\234\179\188\234\176\146\236\157\180 \236\132\177\234\179\181\236\157\180 \236\149\132\235\139\136\235\139\164. \235\185\132\236\160\149\236\131\129 \236\131\129\237\153\169" .. "resultType: " .. PaGlobal_AutoQASupport._enchantResult._resultType)
    ToClient_qaRegisterTimerForQA(100, "ToClient_qaResetEnchantFailCount()")
  end
end
function QA_BlackSpirit:enhanceArmorStart()
  ToClient_qaRegisterTimerForQA(0, "HandleEventLUp_SpiritEnchant_All_MainTabSelect(1)")
  ToClient_qaRegisterTimerForQA(100, "PaGlobal_Inventory_UnCheckAutoSort()")
  if PaGlobal_AutoQASupport._enchantResult._resultType == -1 then
    if self._enhance._isCronApplied == false then
      if self._enhance._isForceEnhance == false then
        PaGlobal_AutoQASupport:writeLogFile("[\235\176\169\236\150\180\234\181\172 \236\157\188\235\176\152 \234\176\149\237\153\148] \237\133\140\236\138\164\237\138\184 \236\139\156\236\158\145", true)
        Proc_ShowMessage_Ack("\235\176\169\236\150\180\234\181\172 \236\157\188\235\176\152 \234\176\149\237\153\148 \236\139\156\236\158\145")
      end
    elseif self._enhance._armorLevel < 17 then
      PaGlobal_AutoQASupport:writeLogFile("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\133\140\236\138\164\237\138\184 \236\139\156\236\158\145", true)
      Proc_ShowMessage_Ack("\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148 \236\139\156\236\158\145")
    end
  end
  local enchantArmorKey = self._enhance._armorKey
  saveItemSlotForQA(CppEnums.ItemWhereType.eInventory, enchantArmorKey)
  local targetSlotNo = getItemSlotForQA()
  PaGlobal_SpiritEnchant_All:setCheckFunc("SkipAni", true)
  if targetSlotNo == nil then
    ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148\237\149\160 \235\176\169\236\150\180\234\181\172\235\165\188 \236\176\190\235\138\148\235\141\176 \236\139\164\237\140\168\237\149\152\236\152\128\236\138\181\235\139\136\235\139\164.")
  else
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, targetSlotNo + 2)
    self._enhance._armorLevel = itemWrapper:get():getKey():getEnchantLevel()
    self._enhance._armorMaxEndurance = itemWrapper:get():getMaxEndurance()
    self._enhance._armorMat1Count = QA_ItemStackCount(self._enhance._armorMat1Key)
    self._enhance._armorMat2Count = QA_ItemStackCount(self._enhance._armorMat2Key)
    self._enhance._cronCount = QA_ItemStackCount(self._enhance._cronKey)
    self._enhance._failCount = getEnchantInformation():ToClient_getFailCount()
    self._enhance._valksCount = getEnchantInformation():ToClient_getValksCount()
    self._enhance._bonusCount = getEnchantInformation():ToClient_getBonusStackCount()
    if self._enhance._armorLevel == 20 then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \235\143\153 \236\158\165\235\185\132\235\138\148 \234\176\149\237\153\148\237\149\160 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164. \236\158\172\236\132\164\236\160\149\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.")
    elseif self._enhance._armorLevel > 20 or 0 > self._enhance._armorLevel or self._enhance._armorLevel == nil then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \237\149\180\235\139\185 \236\158\165\235\185\132\236\157\152 \236\158\165\235\185\132 \235\160\136\235\178\168\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.")
    elseif self._enhance._isCronApplied == true then
      if self._enhance._armorLevel < 17 then
        ToClient_qaRegisterTimerForQA(100, "deleteItem(" .. getSelfPlayer():getActorKey() .. "," .. CppEnums.ItemWhereType.eInventory .. "," .. targetSlotNo .. "+2,1)")
        ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(" .. self._enhance._armorKey .. ",17,1)")
        self._enhance._armorLevel = 17
        self._enhance._armorMaxEndurance = 100
        ToClient_qaRegisterTimerForQA(500, "QA_BlackSpirit:enhanceArmorStart()")
      else
        self._enhance._failCount = 100
        ToClient_qaRegisterTimerForQA(100, "ToClient_qaResetEnchantFailCount()")
        ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(17899,0,1)")
        ToClient_qaRegisterTimerForQA(1000, "ToClient_qaUseInventoryItem(17899,0)")
        ToClient_qaRegisterTimerForQA(100, "messageBox_YesButtonUp()")
        Inventory_SlotRClick_ForQA(100, targetSlotNo)
        ToClient_qaRegisterTimerForQA(100, "QA_BlackSpirit:checkCronStone()")
        Inventory_SlotRClick_ForQA(100, targetSlotNo)
        ToClient_qaRegisterTimerForQA(100, "PaGlobal_SpiritEnchant_All:setCheckFunc('Cron', true)")
        ToClient_qaRegisterTimerForQA(1000, "QA_BlackSpirit:enhanceArmor()")
      end
    else
      if self._enhance._failCount >= 50 then
        self._enhance._failCount = 0
        ToClient_qaRegisterTimerForQA(100, "ToClient_qaResetEnchantFailCount()")
      end
      Inventory_SlotRClick_ForQA(100, targetSlotNo)
      ToClient_qaRegisterTimerForQA(100, "QA_BlackSpirit:enhanceArmor()")
    end
  end
end
function QA_BlackSpirit:enhanceArmor()
  self._enhance._cronCount = QA_ItemStackCount(self._enhance._cronKey)
  ToClient_qaRegisterTimerForQA(100, "HandleEventLUp_SpiritEnchant_All_EnchantApplyButton()")
  ToClient_qaRegisterTimerForQA(100, "messageBox_YesButtonUp()")
  if self._enhance._isForceEnhance == false then
    ToClient_qaRegisterTimerForQA(2500, "QA_BlackSpirit:checkArmorEnchantResult()")
  else
    ToClient_qaRegisterTimerForQA(2500, "QA_BlackSpirit:forceArmorEnhanceResult()")
  end
end
function QA_BlackSpirit:checkArmorEnchantResult()
  local enchantArmorKey = self._enhance._armorKey
  saveItemSlotForQA(CppEnums.ItemWhereType.eInventory, enchantArmorKey)
  local targetSlotNo = getItemSlotForQA()
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, targetSlotNo + 2)
  self._enhance._armorLevelNext = itemWrapper:get():getKey():getEnchantLevel()
  self._enhance._armorMaxEnduranceNext = itemWrapper:get():getMaxEndurance()
  self._enhance._armorMat1CountNext = QA_ItemStackCount(self._enhance._armorMat1Key)
  self._enhance._armorMat2CountNext = QA_ItemStackCount(self._enhance._armorMat2Key)
  self._enhance._cronCountNext = QA_ItemStackCount(self._enhance._cronKey)
  self._enhance._failCountNext = getEnchantInformation():ToClient_getFailCount()
  self._enhance._valksCountNext = getEnchantInformation():ToClient_getValksCount()
  self._enhance._bonusCountNext = getEnchantInformation():ToClient_getBonusStackCount()
  if false == self._enhance._isCronApplied then
    if self._enhance._armorLevel < 5 then
      if PaGlobal_AutoQASupport._enchantResult._resultType == 0 then
        if self._enhance._armorLevel + 1 ~= self._enhance._armorLevelNext then
          ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\149\136\236\160\132\234\176\149\237\153\148 \234\178\176\234\179\188\234\176\128 \236\132\177\234\179\181\236\157\180\236\167\128\235\167\140 \234\176\149\237\153\148 \235\160\136\235\178\168\236\157\180 \236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\152\172\235\157\188\234\176\128\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.")
        elseif self._enhance._failCountNext ~= self._enhance._failCount then
          ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\149\136\236\160\132\234\176\149\237\153\148 \236\157\180\237\155\132 \235\176\156\237\129\172\236\138\164\236\157\152 \236\161\176\236\150\184 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
        elseif self._enhance._valksCountNext ~= self._enhance._valksCount then
          ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\149\136\236\160\132\234\176\149\237\153\148 \236\157\180\237\155\132 \235\176\156\237\129\172\236\138\164\236\157\152 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
        elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
          ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\149\136\236\160\132\234\176\149\237\153\148 \236\157\180\237\155\132 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
        elseif self._enhance._armorMaxEnduranceNext ~= self._enhance._armorMaxEndurance then
          ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\149\136\236\160\132\234\176\149\237\153\148 \236\157\180\237\155\132 \234\176\149\237\153\148\234\176\128 \236\132\177\234\179\181\237\149\152\236\152\128\236\167\128\235\167\140 \237\149\180\235\139\185 \236\158\165\235\185\132\236\157\152 \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
        elseif self._enhance._armorMat1Count == self._armorMat1CountNext and self._enhance._armorMat2Count == self._armorMat2CountNext then
          ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148\234\176\128 \236\167\132\237\150\137\235\144\152\236\151\136\236\156\188\235\130\152 \234\176\149\237\153\148\236\158\172\235\163\140\236\157\152 \236\150\145\236\157\180 \235\179\128\237\149\152\236\167\128 \236\149\138\236\149\152\235\139\164!")
        else
          Proc_ShowMessage_Ack("\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148 \236\132\177\234\179\181")
          self._enhance._isSuccess = true
        end
      else
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\149\136\236\160\132\234\176\149\237\153\148 \234\181\172\234\176\132\236\158\132\236\151\144\235\143\132 \235\182\136\234\181\172\237\149\152\234\179\160 \234\176\149\237\153\148\234\178\176\234\179\188\234\176\128 \236\160\149\236\131\129\236\160\129\236\157\180\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164. ( resultType : " .. PaGlobal_AutoQASupport._enchantResult._resultType .. " ) \236\132\177\234\179\181\236\151\172\235\182\128\236\157\152 \237\153\149\236\157\184\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.")
      end
    elseif PaGlobal_AutoQASupport._enchantResult._resultType == -1 then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148 \234\178\176\234\179\188 \236\160\128\236\158\165\236\151\144 \236\139\164\237\140\168\237\150\136\236\138\181\235\139\136\235\139\164. resultType \237\153\149\236\157\184 \237\149\132\236\154\148")
    elseif PaGlobal_AutoQASupport._enchantResult._resultType == 0 then
      if self._enhance._armorLevel + 1 ~= self._enhance._armorLevelNext then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148 \234\178\176\234\179\188\234\176\128 \236\132\177\234\179\181\236\157\180\236\167\128\235\167\140 \234\176\149\237\153\148 \235\160\136\235\178\168\236\157\180 \236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\152\172\235\157\188\234\176\128\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._failCountNext ~= 0 then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \235\176\156\237\129\172\236\138\164\236\157\152 \236\161\176\236\150\184 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\132\164\236\160\149\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._valksCountNext ~= 0 then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \235\176\156\237\129\172\236\138\164\236\157\152 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\132\164\236\160\149\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._armorMaxEnduranceNext ~= self._enhance._armorMaxEndurance then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \234\176\149\237\153\148\234\176\128 \236\132\177\234\179\181\237\149\152\236\152\128\236\167\128\235\167\140 \237\149\180\235\139\185 \236\158\165\235\185\132\236\157\152 \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._armorMat1Count == self._armorMat1CountNext and self._enhance._armorMat2Count == self._armorMat2CountNext then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148\234\176\128 \236\167\132\237\150\137\235\144\152\236\151\136\236\156\188\235\130\152 \234\176\149\237\153\148\236\158\172\235\163\140\236\157\152 \236\150\145\236\157\180 \235\179\128\234\178\189\235\144\152\236\167\128 \236\149\138\236\149\152\235\139\164?")
      else
        Proc_ShowMessage_Ack("\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148 \236\132\177\234\179\181")
        self._enhance._isSuccess = true
      end
    elseif PaGlobal_AutoQASupport._enchantResult._resultType == 2 then
      if self._enhance._armorLevel <= 16 then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] 16\234\176\149(\236\158\165)\236\157\180\237\149\152 \235\176\169\236\150\180\234\181\172\236\157\184\235\141\176 17\234\176\149(\234\180\145)\236\157\180\236\131\129 \236\158\165\235\185\132\236\157\152 \236\139\164\237\140\168 \234\178\176\234\179\188\234\176\128 \235\130\152\236\153\148\235\139\164.")
      elseif self._enhance._armorLevel >= 20 or self._enhance._armorLevel == nil then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \235\176\169\236\150\180\234\181\172 \235\160\136\235\178\168\236\157\180 \235\185\132\236\160\149\236\131\129\236\157\180\235\139\164.")
      else
        if self._enhance._armorMaxEnduranceNext < 10 then
          ToClient_qaRegisterTimerForQA(100, "deleteItem(" .. getSelfPlayer():getActorKey() .. "," .. CppEnums.ItemWhereType.eInventory .. "," .. targetSlotNo .. "+2,1)")
          ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(" .. self._enhance._armorKey .. "," .. self._enhance._armorLevelNext .. ",1)")
        end
        Proc_ShowMessage_Ack("\234\176\149\237\153\148 \236\139\164\237\140\168 \237\155\132 \235\160\136\235\178\168 \237\149\152\235\157\189")
        _PA_LOG("AutoQA", "\234\176\149\237\153\148 \236\139\164\237\140\168 \237\155\132 \235\160\136\235\178\168 \237\149\152\235\157\189")
        self._enhance._isFail = true
      end
    elseif PaGlobal_AutoQASupport._enchantResult._resultType == 3 then
      if self._enhance._armorLevel > 16 or self._enhance._armorLevel - 1 == self._enhance._armorLevelNext then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\180\145 \236\157\180\236\131\129 \236\158\165\235\185\132\236\151\144\236\132\156 \235\130\152\236\153\128\236\132\160 \236\149\136 \235\144\160 \234\178\176\234\179\188\236\158\133\235\139\136\235\139\164. \234\176\149\237\153\148\235\139\168\234\179\132\234\176\128 \235\150\168\236\150\180\236\167\128\236\167\128 \236\149\138\236\149\152\235\138\148\236\167\128 \237\153\149\236\157\184\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164.")
      elseif self._enhance._armorLevel <= 16 and self._enhance._armorLevel ~= self._enhance._armorLevelNext then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\139\164\237\140\168\237\149\180\235\143\132 \234\176\149\237\153\148\236\136\152\236\185\152\234\176\128 \235\150\168\236\150\180\236\167\128\236\167\128 \236\149\138\236\149\132\236\149\188 \237\149\160 \234\176\149\237\153\148\236\157\184\235\141\176 \234\176\149\237\153\148\236\136\152\236\185\152\234\176\128 \235\150\168\236\150\180\236\161\140\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._failCountNext < self._enhance._failCount then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148\236\151\144 \236\139\164\237\140\168\237\149\152\236\152\128\235\138\148\235\141\176 \234\176\149\237\153\148 \236\138\164\237\131\157\236\157\180 \235\130\180\235\160\164\234\176\148\235\139\164.")
      elseif self._enhance._valksCountNext ~= self._enhance._valksCount then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148\236\151\144 \236\139\164\237\140\168\237\149\152\236\152\128\235\138\148\235\141\176 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
      elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._armorMaxEnduranceNext >= self._enhance._armorMaxEndurance then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148\236\151\144 \236\139\164\237\140\168\237\149\152\236\152\128\235\138\148\235\141\176 \236\181\156\235\140\128\235\130\180\234\181\172\235\143\132\234\176\128 \234\185\142\236\157\180\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._armorMat1Count == self._armorMat1CountNext and self._enhance._armorMat2Count == self._armorMat2CountNext then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148\234\176\128 \236\167\132\237\150\137\235\144\152\236\151\136\236\156\188\235\130\152 \234\176\149\237\153\148\236\158\172\235\163\140\236\157\152 \236\150\145\236\157\180 \235\179\128\234\178\189\235\144\152\236\167\128 \236\149\138\236\149\152\235\139\164?")
      elseif self._enhance._cronCount ~= self._enhance._cronCountNext then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\156\236\136\152\234\176\128 \236\164\132\236\150\180\235\147\164\236\167\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164?")
      else
        if self._enhance._armorMaxEnduranceNext == 0 then
          ToClient_qaRegisterTimerForQA(100, "deleteItem(" .. getSelfPlayer():getActorKey() .. "," .. CppEnums.ItemWhereType.eInventory .. "," .. targetSlotNo .. "+2,1)")
          ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(" .. self._enhance._armorKey .. "," .. self._enhance._armorLevelNext .. ",1)")
        end
        Proc_ShowMessage_Ack("\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148 \236\139\164\237\140\168")
        self._enhance._isFail = true
      end
    elseif PaGlobal_AutoQASupport._enchantResult._resultType == 5 then
      if self._enhance._armorLevel ~= self._enhance._armorLevelNext then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \234\176\149\237\153\148\236\136\152\236\185\152\234\176\128 \235\139\172\235\157\188\236\160\184 \236\158\136\235\139\164")
      elseif self._enhance._failCountNext ~= self._enhance._failCount then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148[ \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \234\176\149\237\153\148\236\138\164\237\131\157\236\157\180 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
      elseif self._enhance._valksCountNext ~= self._enhance._valksCount then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148[ \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
      elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148[ \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
      elseif self._enhance._armorMaxEndurance ~= self._enhance._armorMaxEnduranceNext then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132\234\176\128 \235\139\172\235\157\188\236\160\184 \236\158\136\235\139\164")
      elseif self._enhance._armorMat1Count ~= self._enhance._armorMat1CountNext or self._enhance._armorMat2Count ~= self._enhance._armorMat2CountNext then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \234\176\149\237\153\148\236\158\172\235\163\140 \234\176\156\236\136\152\234\176\128 \235\139\172\235\157\188\236\160\184 \236\158\136\235\139\164")
      elseif self._enhance._cronCount ~= self._enhance._cronCountNext then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\156\236\136\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164?")
      else
        Proc_ShowMessage_Ack("\235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177")
        ToClient_qaRegisterTimerForQA(100, "HandleEventRUp_SpiritEnchant_All_ReleseTargetItem()")
        ToClient_qaRegisterTimerForQA(100, "deleteItem(" .. getSelfPlayer():getActorKey() .. "," .. CppEnums.ItemWhereType.eInventory .. "," .. targetSlotNo .. "+2,1)")
        ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(" .. self._enhance._armorKey .. "," .. self._enhance._armorLevel .. ",1)")
      end
    elseif PaGlobal_AutoQASupport._enchantResult._resultType == 1 then
      _PA_LOG("AutoQA", "resultType : " .. PaGlobal_AutoQASupport._enchantResult._resultType)
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\149\133\236\132\184\236\132\156\235\166\172 \234\176\149\237\153\148\234\176\128 \236\149\132\235\139\140\235\141\176 \236\149\133\236\132\184\236\132\156\235\166\172 \234\178\176\234\179\188(\234\176\149\237\153\148 \236\139\164\237\140\168 \237\155\132 \237\140\140\234\180\180)\234\176\128 \235\130\152\236\153\148\236\138\181\235\139\136\235\139\164.")
    elseif PaGlobal_AutoQASupport._enchantResult._resultType == 4 then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157\236\157\132 \236\130\172\236\154\169\237\149\152\236\167\128 \236\149\138\236\149\152\236\156\188\235\130\152 \237\129\172\235\161\160\236\132\157 \234\178\176\234\179\188\234\176\146\236\157\180 \235\130\152\236\153\148\236\138\181\235\139\136\235\139\164. \237\153\149\236\157\184\237\149\180\235\180\144\236\149\188 \237\149\169\235\139\136\235\139\164.")
    else
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\158\152\235\170\187\235\144\156 resultType! \236\131\136\235\161\156 \236\182\148\234\176\128\235\144\156 \234\178\131\236\157\184\234\176\128..")
    end
  elseif PaGlobal_AutoQASupport._enchantResult._resultType == -1 then
    ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148 \234\178\176\234\179\188 \236\160\128\236\158\165\236\151\144 \236\139\164\237\140\168\237\150\136\236\138\181\235\139\136\235\139\164. resultType \237\153\149\236\157\184 \237\149\132\236\154\148")
  elseif PaGlobal_AutoQASupport._enchantResult._resultType == 0 then
    if self._enhance._armorLevel + 1 ~= self._enhance._armorLevelNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148 \234\178\176\234\179\188\234\176\128 \236\132\177\234\179\181\236\157\180\236\167\128\235\167\140 \234\176\149\237\153\148 \235\160\136\235\178\168\236\157\180 \236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\152\172\235\157\188\234\176\128\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._failCountNext ~= 0 then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \235\176\156\237\129\172\236\138\164\236\157\152 \236\161\176\236\150\184 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\132\164\236\160\149\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._valksCountNext ~= 0 then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \235\176\156\237\129\172\236\138\164\236\157\152 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\132\164\236\160\149\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._armorMaxEnduranceNext ~= self._enhance._armorMaxEndurance then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \234\176\149\237\153\148\234\176\128 \236\132\177\234\179\181\237\149\152\236\152\128\236\167\128\235\167\140 \237\149\180\235\139\185 \236\158\165\235\185\132\236\157\152 \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._armorMat1Count == self._armorMat1CountNext and self._enhance._armorMat2Count == self._armorMat2CountNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148\234\176\128 \236\167\132\237\150\137\235\144\152\236\151\136\236\156\188\235\130\152 \234\176\149\237\153\148\236\158\172\235\163\140\236\157\152 \236\150\145\236\157\180 \235\179\128\234\178\189\235\144\152\236\167\128 \236\149\138\236\149\152\235\139\164?")
    elseif self._enhance._cronCount <= self._enhance._cronCountNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\156\236\136\152\234\176\128 \236\164\132\236\150\180\235\147\164\236\167\128 \236\149\138\236\149\152\235\139\164.")
    else
      Proc_ShowMessage_Ack("\237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148 \236\132\177\234\179\181")
      self._enhance._isSuccess = true
    end
  elseif PaGlobal_AutoQASupport._enchantResult._resultType == 4 then
    if self._enhance._armorLevel > 16 and self._enhance._armorLevel ~= self._enhance._armorLevelNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148\234\176\128 \236\167\132\237\150\137\235\144\152\236\151\136\236\156\188\235\130\152, \236\139\164\237\140\168 \237\155\132 \236\158\165\235\185\132\235\160\136\235\178\168\236\157\180 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
    elseif self._enhance._armorLevel <= 16 and self._enhance._armorLevel ~= self._enhance._armorLevelNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148\234\176\128 \236\167\132\237\150\137\235\144\152\236\151\136\236\156\188\235\130\152, \236\139\164\237\140\168\237\149\180\235\143\132 \234\176\149\237\153\148\236\136\152\236\185\152\234\176\128 \235\150\168\236\150\180\236\167\128\236\167\128 \236\149\138\236\149\132\236\149\188 \237\149\160 \234\176\149\237\153\148\236\151\144\236\132\156 \234\176\149\237\153\148\236\136\152\236\185\152\234\176\128 \235\150\168\236\150\180\236\161\140\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._failCountNext ~= self._enhance._failCount then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148\235\157\188 \236\139\164\237\140\168 \236\139\156 \236\138\164\237\131\157\236\157\180 \236\156\160\236\167\128\235\144\152\236\150\180\236\149\188 \237\149\152\235\138\148\235\141\176 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164!")
    elseif self._enhance._valksCountNext ~= self._enhance._valksCount then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148\236\151\144 \236\139\164\237\140\168\237\149\152\236\152\128\235\138\148\235\141\176 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
    elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148 \236\157\180\237\155\132 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._armorMaxEnduranceNext >= self._enhance._armorMaxEndurance then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148\236\151\144 \236\139\164\237\140\168\237\149\152\236\152\128\235\138\148\235\141\176 \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132\234\176\128 \234\185\142\236\157\180\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._armorMat1Count == self._armorMat1CountNext and self._enhance._armorMat2Count == self._armorMat2CountNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148\234\176\128 \236\167\132\237\150\137\235\144\152\236\151\136\236\156\188\235\130\152 \234\176\149\237\153\148\236\158\172\235\163\140\236\157\152 \236\150\145\236\157\180 \235\179\128\234\178\189\235\144\152\236\167\128 \236\149\138\236\149\152\235\139\164?")
    elseif self._enhance._cronCount <= self._enhance._cronCountNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\156\236\136\152\234\176\128 \236\164\132\236\150\180\235\147\164\236\167\128 \236\149\138\236\149\152\235\139\164?")
    else
      if self._enhance._armorMaxEnduranceNext < 10 or self._enhance._armorLevel < 17 or self._enhance._armorLevel == 20 then
        ToClient_qaRegisterTimerForQA(100, "deleteItem(" .. getSelfPlayer():getActorKey() .. "," .. CppEnums.ItemWhereType.eInventory .. "," .. targetSlotNo .. "+2,1)")
        ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(" .. self._enhance._armorKey .. "," .. self._enhance._armorLevelNext .. ",1)")
      end
      Proc_ShowMessage_Ack("\237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148 \236\139\164\237\140\168")
      self._enhance._isFail = true
    end
  elseif PaGlobal_AutoQASupport._enchantResult._resultType == 5 then
    if self._enhance._armorLevel ~= self._enhance._armorLevelNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \234\176\149\237\153\148\236\136\152\236\185\152\234\176\128 \235\139\172\235\157\188\236\160\184 \236\158\136\235\139\164")
    elseif self._enhance._failCountNext ~= self._enhance._failCount then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148[ \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \234\176\149\237\153\148\236\138\164\237\131\157\236\157\180 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
    elseif self._enhance._valksCountNext ~= self._enhance._valksCount then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148[ \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
    elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148[ \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
    elseif self._enhance._armorMaxEndurance ~= self._enhance._armorMaxEnduranceNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132\234\176\128 \235\139\172\235\157\188\236\160\184 \236\158\136\235\139\164")
    elseif self._enhance._armorMat1Count ~= self._enhance._armorMat1CountNext or self._enhance._armorMat2Count ~= self._enhance._armorMat2CountNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \234\176\149\237\153\148\236\158\172\235\163\140 \234\176\156\236\136\152\234\176\128 \235\139\172\235\157\188\236\160\184 \236\158\136\235\139\164")
    elseif self._enhance._cronCount ~= self._enhance._cronCountNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\156\236\136\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164?")
    else
      Proc_ShowMessage_Ack("\235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177")
      ToClient_qaRegisterTimerForQA(100, "HandleEventRUp_SpiritEnchant_All_ReleseTargetItem()")
      ToClient_qaRegisterTimerForQA(100, "deleteItem(" .. getSelfPlayer():getActorKey() .. "," .. CppEnums.ItemWhereType.eInventory .. "," .. targetSlotNo .. "+2,1)")
      ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(" .. self._enhance._armorKey .. "," .. self._enhance._armorLevel .. ",1)")
    end
  elseif PaGlobal_AutoQASupport._enchantResult._resultType == 1 or PaGlobal_AutoQASupport._enchantResult._resultType == 2 then
    _PA_LOG("AutoQA", "resultType : " .. PaGlobal_AutoQASupport._enchantResult._resultType)
    ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\149\133\236\132\184\236\132\156\235\166\172 \234\176\149\237\153\148\234\176\128 \236\149\132\235\139\140\235\141\176 \236\149\133\236\132\184\236\132\156\235\166\172 \234\176\149\237\153\148 \234\178\176\234\179\188\234\176\128 \235\130\152\236\153\148\236\138\181\235\139\136\235\139\164.")
  elseif PaGlobal_AutoQASupport._enchantResult._resultType == 4 then
    ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157\236\157\132 \236\130\172\236\154\169\237\149\152\236\167\128 \236\149\138\236\149\152\236\156\188\235\130\152 \237\129\172\235\161\160\236\132\157 \234\178\176\234\179\188\234\176\146\236\157\180 \235\130\152\236\153\148\236\138\181\235\139\136\235\139\164. \237\153\149\236\157\184\237\149\180\235\180\144\236\149\188 \237\149\169\235\139\136\235\139\164.")
  else
    ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\158\152\235\170\187\235\144\156 resultType! \236\131\136\235\161\156 \236\182\148\234\176\128\235\144\156 \234\178\131\236\157\184\234\176\128..")
  end
  if true == self._enhance._isSuccess and true == self._enhance._isFail then
    self._enhance._armorLevel = -1
    self._enhance._armorLevelNext = -1
    self._enhance._isSuccess = false
    self._enhance._isFail = false
    if self._enhance._isCronApplied == false then
      PaGlobal_AutoQASupport:writeLogFile("[\235\176\169\236\150\180\234\181\172 \236\157\188\235\176\152 \234\176\149\237\153\148] \237\133\140\236\138\164\237\138\184 \236\162\133\235\163\140", true)
      self._enhance._isCronApplied = true
      PaGlobal_AutoQASupport._enchantResult._resultType = -1
      ToClient_qaRegisterTimerForQA(100, "QA_BlackSpirit:checkArmorMaterial()")
    else
      PaGlobal_AutoQASupport:writeLogFile("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\133\140\236\138\164\237\138\184 \236\162\133\235\163\140", true)
      self._enhance._isCronApplied = false
      PaGlobal_AutoQASupport._enchantResult._resultType = -1
      ToClient_qaRegisterTimerForQA(100, "QA_BlackSpirit:forceEnhanceArmorStart()")
    end
  else
    self._enhance._armorLevel = self._enhance._armorLevelNext
    ToClient_qaRegisterTimerForQA(500, "QA_BlackSpirit:checkArmorMaterial()")
  end
end
function QA_BlackSpirit:forceEnhanceArmorStart()
  self._enhance._isForceEnhance = true
  ToClient_qaRegisterTimerForQA(0, "HandleEventLUp_SpiritEnchant_All_MainTabSelect(1)")
  ToClient_qaRegisterTimerForQA(100, "PaGlobal_Inventory_UnCheckAutoSort()")
  local enchantArmorKey = self._enhance._armorKey
  saveItemSlotForQA(CppEnums.ItemWhereType.eInventory, enchantArmorKey)
  local targetSlotNo = getItemSlotForQA()
  PaGlobal_SpiritEnchant_All:setCheckFunc("SkipAni", true)
  if targetSlotNo == nil then
    PaGlobal_AutoQASupport:writeLogFile("[\235\176\169\236\150\180\234\181\172 \234\176\149\236\160\156 \234\176\149\237\153\148] \237\133\140\236\138\164\237\138\184 \236\139\156\236\158\145", true)
    ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\236\160\156 \234\176\149\237\153\148] \234\176\149\236\160\156 \234\176\149\237\153\148\237\149\160 \235\176\169\236\150\180\234\181\172\235\165\188 \236\176\190\235\138\148\235\141\176 \236\139\164\237\140\168\237\149\152\236\152\128\236\138\181\235\139\136\235\139\164.")
  else
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, targetSlotNo + 2)
    self._enhance._armorLevel = itemWrapper:get():getKey():getEnchantLevel()
    self._enhance._armorMaxEndurance = itemWrapper:get():getMaxEndurance()
    self._enhance._armorMat1Count = QA_ItemStackCount(self._enhance._armorMat1Key)
    self._enhance._armorMat2Count = QA_ItemStackCount(self._enhance._armorMat2Key)
    self._enhance._cronCount = QA_ItemStackCount(self._enhance._cronKey)
    self._enhance._failCount = getEnchantInformation():ToClient_getFailCount()
    self._enhance._valksCount = getEnchantInformation():ToClient_getValksCount()
    self._enhance._bonusCount = getEnchantInformation():ToClient_getBonusStackCount()
    if self._enhance._armorLevel > 14 or self._enhance._armorLevel < 7 or self._enhance._armorMaxEndurance ~= 100 then
      ToClient_qaRegisterTimerForQA(100, "deleteItem(" .. getSelfPlayer():getActorKey() .. "," .. CppEnums.ItemWhereType.eInventory .. "," .. targetSlotNo .. "+2,1)")
      ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(" .. self._enhance._armorKey .. "," .. math.random(7, 14) .. ",1)")
      ToClient_qaRegisterTimerForQA(100, "QA_BlackSpirit:forceEnhanceArmorStart()")
    elseif self._enhance._armorLevel > 20 or 0 > self._enhance._armorLevel or self._enhance._armorLevel == nil then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\236\160\156 \234\176\149\237\153\148] \237\149\180\235\139\185 \236\158\165\235\185\132\236\157\152 \236\158\165\235\185\132 \235\160\136\235\178\168\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.")
    else
      PaGlobal_AutoQASupport:writeLogFile("[\235\176\169\236\150\180\234\181\172 \234\176\149\236\160\156 \234\176\149\237\153\148] \237\133\140\236\138\164\237\138\184 \236\139\156\236\158\145", true)
      Proc_ShowMessage_Ack("\235\176\169\236\150\180\234\181\172 \234\176\149\236\160\156 \234\176\149\237\153\148 \236\139\156\236\158\145")
      Inventory_SlotRClick_ForQA(100, targetSlotNo)
      ToClient_qaRegisterTimerForQA(1000, "QA_BlackSpirit:checkForceArmorBS()")
      Inventory_SlotRClick_ForQA(100, targetSlotNo)
      ToClient_qaRegisterTimerForQA(100, "PaGlobal_SpiritEnchant_All:setCheckFunc('Force', true)")
      ToClient_qaRegisterTimerForQA(100, "QA_BlackSpirit:enhanceArmor()")
    end
  end
end
function QA_BlackSpirit:forceArmorEnhanceResult()
  local enchantArmorKey = self._enhance._armorKey
  saveItemSlotForQA(CppEnums.ItemWhereType.eInventory, enchantArmorKey)
  local targetSlotNo = getItemSlotForQA()
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, targetSlotNo + 2)
  self._enhance._armorLevelNext = itemWrapper:get():getKey():getEnchantLevel()
  self._enhance._armorMaxEnduranceNext = itemWrapper:get():getMaxEndurance()
  self._enhance._armorMat1CountNext = QA_ItemStackCount(self._enhance._armorMat1Key)
  self._enhance._armorMat2CountNext = QA_ItemStackCount(self._enhance._armorMat2Key)
  self._enhance._cronCountNext = QA_ItemStackCount(self._enhance._cronKey)
  self._enhance._failCountNext = getEnchantInformation():ToClient_getFailCount()
  self._enhance._valksCountNext = getEnchantInformation():ToClient_getValksCount()
  self._enhance._bonusCountNext = getEnchantInformation():ToClient_getBonusStackCount()
  if PaGlobal_AutoQASupport._enchantResult._resultType == -1 then
    ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\236\160\156 \234\176\149\237\153\148] \234\176\149\237\153\148 \234\178\176\234\179\188 \236\160\128\236\158\165\236\151\144 \236\139\164\237\140\168\237\150\136\236\138\181\235\139\136\235\139\164. resultType \237\153\149\236\157\184 \237\149\132\236\154\148")
  elseif PaGlobal_AutoQASupport._enchantResult._resultType == 0 then
    if self._enhance._armorLevel + 1 ~= self._enhance._armorLevelNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\236\160\156 \234\176\149\237\153\148] \234\176\149\236\160\156 \234\176\149\237\153\148 \237\155\132 \234\176\149\237\153\148 \236\132\177\234\179\181\236\157\180\236\167\128\235\167\140 \234\176\149\237\153\148 \235\160\136\235\178\168\236\157\180 \236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\152\172\235\157\188\234\176\128\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._failCountNext ~= self._enhance._failCount then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\236\160\156 \234\176\149\237\153\148] \234\176\149\236\160\156 \234\176\149\237\153\148 \236\157\180\237\155\132 \235\176\156\237\129\172\236\138\164\236\157\152 \236\161\176\236\150\184 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._valksCountNext ~= self._enhance._valksCount then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\236\160\156 \234\176\149\237\153\148] \234\176\149\236\160\156 \234\176\149\237\153\148 \236\157\180\237\155\132 \235\176\156\237\129\172\236\138\164\236\157\152 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\236\160\156 \234\176\149\237\153\148] \234\176\149\236\160\156 \234\176\149\237\153\148 \236\157\180\237\155\132 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._armorMaxEndurance <= self._enhance._armorMaxEnduranceNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\236\160\156 \234\176\149\237\153\148] \234\176\149\236\160\156 \234\176\149\237\153\148 \236\157\180\237\155\132 \237\149\180\235\139\185 \236\158\165\235\185\132\236\157\152 \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132\234\176\128 \236\164\132\236\150\180\235\147\164\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._armorMat1Count == self._armorMat1CountNext and self._enhance._armorMat2Count == self._armorMat2CountNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\236\160\156 \234\176\149\237\153\148] \234\176\149\236\160\156 \234\176\149\237\153\148 \236\157\180\237\155\132 \234\176\149\237\153\148\236\158\172\235\163\140\236\157\152 \236\150\145\236\157\180 \235\179\128\234\178\189\235\144\152\236\167\128 \236\149\138\236\149\152\235\139\164?")
    elseif self._enhance._cronCount ~= self._enhance._cronCountNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\236\160\156 \234\176\149\237\153\148] \234\176\149\236\160\156 \234\176\149\237\153\148 \236\157\180\237\155\132 \237\129\172\235\161\160\236\132\157 \234\176\156\236\136\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
    else
      self._enhance._isForceEnhance = false
      Proc_ShowMessage_Ack("\234\176\149\236\160\156 \234\176\149\237\153\148 \236\132\177\234\179\181")
      PaGlobal_AutoQASupport:writeLogFile("[\235\176\169\236\150\180\234\181\172 \234\176\149\236\160\156 \234\176\149\237\153\148] \237\133\140\236\138\164\237\138\184 \236\162\133\235\163\140", true)
      ToClient_qaResetEnchantFailCount()
    end
  elseif PaGlobal_AutoQASupport._enchantResult._resultType == 5 then
    ToClient_qaRegisterTimerForQA(100, "deleteItem(" .. getSelfPlayer():getActorKey() .. "," .. CppEnums.ItemWhereType.eInventory .. "," .. targetSlotNo .. "+2,1)")
    ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(" .. self._enhance._armorKey .. "," .. self._enhance._armorLevelNext .. ",1)")
  else
    ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\236\160\156 \234\176\149\237\153\148 \234\178\176\234\179\188\234\176\146\236\157\180 \236\132\177\234\179\181\236\157\180 \236\149\132\235\139\136\235\139\164. \235\185\132\236\160\149\236\131\129 \236\131\129\237\153\169" .. "resultType: " .. PaGlobal_AutoQASupport._enchantResult._resultType)
    ToClient_qaRegisterTimerForQA(100, "ToClient_qaResetEnchantFailCount()")
  end
end
function QA_BlackSpirit:enhanceArmorStart()
  ToClient_qaRegisterTimerForQA(0, "HandleEventLUp_SpiritEnchant_All_MainTabSelect(1)")
  ToClient_qaRegisterTimerForQA(100, "PaGlobal_Inventory_UnCheckAutoSort()")
  if PaGlobal_AutoQASupport._enchantResult._resultType == -1 then
    if self._enhance._isCronApplied == false then
      if self._enhance._isForceEnhance == false then
        PaGlobal_AutoQASupport:writeLogFile("[\235\176\169\236\150\180\234\181\172 \236\157\188\235\176\152 \234\176\149\237\153\148] \237\133\140\236\138\164\237\138\184 \236\139\156\236\158\145", true)
        Proc_ShowMessage_Ack("\235\176\169\236\150\180\234\181\172 \236\157\188\235\176\152 \234\176\149\237\153\148 \236\139\156\236\158\145")
      end
    elseif self._enhance._armorLevel < 2 then
      PaGlobal_AutoQASupport:writeLogFile("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\133\140\236\138\164\237\138\184 \236\139\156\236\158\145", true)
      Proc_ShowMessage_Ack("\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148 \236\139\156\236\158\145")
    end
  end
  local enchantArmorKey = self._enhance._armorKey
  saveItemSlotForQA(CppEnums.ItemWhereType.eInventory, enchantArmorKey)
  local targetSlotNo = getItemSlotForQA()
  PaGlobal_SpiritEnchant_All:setCheckFunc("SkipAni", true)
  if targetSlotNo == nil then
    ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148\237\149\160 \235\176\169\236\150\180\234\181\172\235\165\188 \236\176\190\235\138\148\235\141\176 \236\139\164\237\140\168\237\149\152\236\152\128\236\138\181\235\139\136\235\139\164.")
  else
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, targetSlotNo + 2)
    self._enhance._armorLevel = itemWrapper:get():getKey():getEnchantLevel()
    self._enhance._armorMaxEndurance = itemWrapper:get():getMaxEndurance()
    self._enhance._armorMat1Count = QA_ItemStackCount(self._enhance._armorMat1Key)
    self._enhance._armorMat2Count = QA_ItemStackCount(self._enhance._armorMat2Key)
    self._enhance._cronCount = QA_ItemStackCount(self._enhance._cronKey)
    self._enhance._failCount = getEnchantInformation():ToClient_getFailCount()
    self._enhance._valksCount = getEnchantInformation():ToClient_getValksCount()
    self._enhance._bonusCount = getEnchantInformation():ToClient_getBonusStackCount()
    if self._enhance._armorLevel == 20 then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \235\143\153 \236\158\165\235\185\132\235\138\148 \234\176\149\237\153\148\237\149\160 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164. \236\158\172\236\132\164\236\160\149\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.")
    elseif self._enhance._armorLevel > 20 or 0 > self._enhance._armorLevel or self._enhance._armorLevel == nil then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \237\149\180\235\139\185 \236\158\165\235\185\132\236\157\152 \236\158\165\235\185\132 \235\160\136\235\178\168\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.")
    elseif self._enhance._isCronApplied == true then
      if self._enhance._armorLevel < 17 then
        ToClient_qaRegisterTimerForQA(100, "deleteItem(" .. getSelfPlayer():getActorKey() .. "," .. CppEnums.ItemWhereType.eInventory .. "," .. targetSlotNo .. "+2,1)")
        ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(" .. self._enhance._armorKey .. ",17,1)")
        self._enhance._armorLevel = 17
        self._enhance._armorMaxEndurance = 100
        ToClient_qaRegisterTimerForQA(500, "QA_BlackSpirit:enhanceArmorStart()")
      else
        self._enhance._failCount = 100
        ToClient_qaRegisterTimerForQA(100, "ToClient_qaResetEnchantFailCount()")
        ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(17899,0,1)")
        ToClient_qaRegisterTimerForQA(1000, "ToClient_qaUseInventoryItem(17899,0)")
        ToClient_qaRegisterTimerForQA(100, "messageBox_YesButtonUp()")
        Inventory_SlotRClick_ForQA(100, targetSlotNo)
        ToClient_qaRegisterTimerForQA(100, "QA_BlackSpirit:checkCronStone()")
        Inventory_SlotRClick_ForQA(100, targetSlotNo)
        ToClient_qaRegisterTimerForQA(100, "PaGlobal_SpiritEnchant_All:setCheckFunc('Cron', true)")
        ToClient_qaRegisterTimerForQA(1000, "QA_BlackSpirit:enhanceArmor()")
      end
    else
      if self._enhance._failCount >= 50 then
        self._enhance._failCount = 0
        ToClient_qaRegisterTimerForQA(100, "ToClient_qaResetEnchantFailCount()")
      end
      Inventory_SlotRClick_ForQA(100, targetSlotNo)
      ToClient_qaRegisterTimerForQA(100, "QA_BlackSpirit:enhanceArmor()")
    end
  end
end
function QA_BlackSpirit:enhanceArmor()
  self._enhance._cronCount = QA_ItemStackCount(self._enhance._cronKey)
  ToClient_qaRegisterTimerForQA(100, "HandleEventLUp_SpiritEnchant_All_EnchantApplyButton()")
  ToClient_qaRegisterTimerForQA(100, "messageBox_YesButtonUp()")
  if self._enhance._isForceEnhance == false then
    ToClient_qaRegisterTimerForQA(1000, "QA_BlackSpirit:checkArmorEnchantResult()")
  else
    ToClient_qaRegisterTimerForQA(2000, "QA_BlackSpirit:forceArmorEnhanceResult()")
  end
end
function QA_BlackSpirit:checkArmorEnchantResult()
  local enchantArmorKey = self._enhance._armorKey
  saveItemSlotForQA(CppEnums.ItemWhereType.eInventory, enchantArmorKey)
  local targetSlotNo = getItemSlotForQA()
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, targetSlotNo + 2)
  self._enhance._armorLevelNext = itemWrapper:get():getKey():getEnchantLevel()
  self._enhance._armorMaxEnduranceNext = itemWrapper:get():getMaxEndurance()
  self._enhance._armorMat1CountNext = QA_ItemStackCount(self._enhance._armorMat1Key)
  self._enhance._armorMat2CountNext = QA_ItemStackCount(self._enhance._armorMat2Key)
  self._enhance._cronCountNext = QA_ItemStackCount(self._enhance._cronKey)
  self._enhance._failCountNext = getEnchantInformation():ToClient_getFailCount()
  self._enhance._valksCountNext = getEnchantInformation():ToClient_getValksCount()
  self._enhance._bonusCountNext = getEnchantInformation():ToClient_getBonusStackCount()
  if false == self._enhance._isCronApplied then
    if self._enhance._armorLevel < 5 then
      if PaGlobal_AutoQASupport._enchantResult._resultType == 0 then
        if self._enhance._armorLevel + 1 ~= self._enhance._armorLevelNext then
          ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\149\136\236\160\132\234\176\149\237\153\148 \234\178\176\234\179\188\234\176\128 \236\132\177\234\179\181\236\157\180\236\167\128\235\167\140 \234\176\149\237\153\148 \235\160\136\235\178\168\236\157\180 \236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\152\172\235\157\188\234\176\128\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.")
        elseif self._enhance._failCountNext ~= self._enhance._failCount then
          ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\149\136\236\160\132\234\176\149\237\153\148 \236\157\180\237\155\132 \235\176\156\237\129\172\236\138\164\236\157\152 \236\161\176\236\150\184 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
        elseif self._enhance._valksCountNext ~= self._enhance._valksCount then
          ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\149\136\236\160\132\234\176\149\237\153\148 \236\157\180\237\155\132 \235\176\156\237\129\172\236\138\164\236\157\152 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
        elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
          ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\149\136\236\160\132\234\176\149\237\153\148 \236\157\180\237\155\132 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
        elseif self._enhance._armorMaxEnduranceNext ~= self._enhance._armorMaxEndurance then
          ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\149\136\236\160\132\234\176\149\237\153\148 \236\157\180\237\155\132 \234\176\149\237\153\148\234\176\128 \236\132\177\234\179\181\237\149\152\236\152\128\236\167\128\235\167\140 \237\149\180\235\139\185 \236\158\165\235\185\132\236\157\152 \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
        elseif self._enhance._armorMat1Count == self._armorMat1CountNext and self._enhance._armorMat2Count == self._armorMat2CountNext then
          ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148\234\176\128 \236\167\132\237\150\137\235\144\152\236\151\136\236\156\188\235\130\152 \234\176\149\237\153\148\236\158\172\235\163\140\236\157\152 \236\150\145\236\157\180 \235\179\128\237\149\152\236\167\128 \236\149\138\236\149\152\235\139\164!")
        else
          Proc_ShowMessage_Ack("\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148 \236\132\177\234\179\181")
          self._enhance._isSuccess = true
        end
      else
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\149\136\236\160\132\234\176\149\237\153\148 \234\181\172\234\176\132\236\158\132\236\151\144\235\143\132 \235\182\136\234\181\172\237\149\152\234\179\160 \234\176\149\237\153\148\234\178\176\234\179\188\234\176\128 \236\160\149\236\131\129\236\160\129\236\157\180\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164. ( resultType : " .. PaGlobal_AutoQASupport._enchantResult._resultType .. " ) \236\132\177\234\179\181\236\151\172\235\182\128\236\157\152 \237\153\149\236\157\184\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.")
      end
    elseif PaGlobal_AutoQASupport._enchantResult._resultType == -1 then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148 \234\178\176\234\179\188 \236\160\128\236\158\165\236\151\144 \236\139\164\237\140\168\237\150\136\236\138\181\235\139\136\235\139\164. resultType \237\153\149\236\157\184 \237\149\132\236\154\148")
    elseif PaGlobal_AutoQASupport._enchantResult._resultType == 0 then
      if self._enhance._armorLevel + 1 ~= self._enhance._armorLevelNext then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148 \234\178\176\234\179\188\234\176\128 \236\132\177\234\179\181\236\157\180\236\167\128\235\167\140 \234\176\149\237\153\148 \235\160\136\235\178\168\236\157\180 \236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\152\172\235\157\188\234\176\128\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._failCountNext ~= 0 then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \235\176\156\237\129\172\236\138\164\236\157\152 \236\161\176\236\150\184 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\132\164\236\160\149\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._valksCountNext ~= 0 then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \235\176\156\237\129\172\236\138\164\236\157\152 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\132\164\236\160\149\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._armorMaxEnduranceNext ~= self._enhance._armorMaxEndurance then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \234\176\149\237\153\148\234\176\128 \236\132\177\234\179\181\237\149\152\236\152\128\236\167\128\235\167\140 \237\149\180\235\139\185 \236\158\165\235\185\132\236\157\152 \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._armorMat1Count == self._armorMat1CountNext and self._enhance._armorMat2Count == self._armorMat2CountNext then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148\234\176\128 \236\167\132\237\150\137\235\144\152\236\151\136\236\156\188\235\130\152 \234\176\149\237\153\148\236\158\172\235\163\140\236\157\152 \236\150\145\236\157\180 \235\179\128\234\178\189\235\144\152\236\167\128 \236\149\138\236\149\152\235\139\164?")
      else
        Proc_ShowMessage_Ack("\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148 \236\132\177\234\179\181")
        self._enhance._isSuccess = true
      end
    elseif PaGlobal_AutoQASupport._enchantResult._resultType == 2 then
      if self._enhance._armorLevel <= 16 then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] 16\234\176\149(\236\158\165)\236\157\180\237\149\152 \235\176\169\236\150\180\234\181\172\236\157\184\235\141\176 17\234\176\149(\234\180\145)\236\157\180\236\131\129 \236\158\165\235\185\132\236\157\152 \236\139\164\237\140\168 \234\178\176\234\179\188\234\176\128 \235\130\152\236\153\148\235\139\164.")
      elseif self._enhance._armorLevel >= 20 or self._enhance._armorLevel == nil then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \235\176\169\236\150\180\234\181\172 \235\160\136\235\178\168\236\157\180 \235\185\132\236\160\149\236\131\129\236\157\180\235\139\164.")
      else
        if self._enhance._armorMaxEnduranceNext < 10 then
          ToClient_qaRegisterTimerForQA(100, "deleteItem(" .. getSelfPlayer():getActorKey() .. "," .. CppEnums.ItemWhereType.eInventory .. "," .. targetSlotNo .. "+2,1)")
          ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(" .. self._enhance._armorKey .. "," .. self._enhance._armorLevelNext .. ",1)")
        end
        Proc_ShowMessage_Ack("\234\176\149\237\153\148 \236\139\164\237\140\168 \237\155\132 \235\160\136\235\178\168 \237\149\152\235\157\189")
        _PA_LOG("AutoQA", "\234\176\149\237\153\148 \236\139\164\237\140\168 \237\155\132 \235\160\136\235\178\168 \237\149\152\235\157\189")
        self._enhance._isFail = true
      end
    elseif PaGlobal_AutoQASupport._enchantResult._resultType == 3 then
      if self._enhance._armorLevel > 16 or self._enhance._armorLevel - 1 == self._enhance._armorLevelNext then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\180\145 \236\157\180\236\131\129 \236\158\165\235\185\132\236\151\144\236\132\156 \235\130\152\236\153\128\236\132\160 \236\149\136 \235\144\160 \234\178\176\234\179\188\236\158\133\235\139\136\235\139\164. \234\176\149\237\153\148\235\139\168\234\179\132\234\176\128 \235\150\168\236\150\180\236\167\128\236\167\128 \236\149\138\236\149\152\235\138\148\236\167\128 \237\153\149\236\157\184\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164.")
      elseif self._enhance._armorLevel <= 16 and self._enhance._armorLevel ~= self._enhance._armorLevelNext then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\139\164\237\140\168\237\149\180\235\143\132 \234\176\149\237\153\148\236\136\152\236\185\152\234\176\128 \235\150\168\236\150\180\236\167\128\236\167\128 \236\149\138\236\149\132\236\149\188 \237\149\160 \234\176\149\237\153\148\236\157\184\235\141\176 \234\176\149\237\153\148\236\136\152\236\185\152\234\176\128 \235\150\168\236\150\180\236\161\140\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._failCountNext < self._enhance._failCount then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148\236\151\144 \236\139\164\237\140\168\237\149\152\236\152\128\235\138\148\235\141\176 \234\176\149\237\153\148 \236\138\164\237\131\157\236\157\180 \235\130\180\235\160\164\234\176\148\235\139\164.")
      elseif self._enhance._valksCountNext ~= self._enhance._valksCount then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148\236\151\144 \236\139\164\237\140\168\237\149\152\236\152\128\235\138\148\235\141\176 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
      elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._armorMaxEnduranceNext >= self._enhance._armorMaxEndurance then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148\236\151\144 \236\139\164\237\140\168\237\149\152\236\152\128\235\138\148\235\141\176 \236\181\156\235\140\128\235\130\180\234\181\172\235\143\132\234\176\128 \234\185\142\236\157\180\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.")
      elseif self._enhance._armorMat1Count == self._armorMat1CountNext and self._enhance._armorMat2Count == self._armorMat2CountNext then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148\234\176\128 \236\167\132\237\150\137\235\144\152\236\151\136\236\156\188\235\130\152 \234\176\149\237\153\148\236\158\172\235\163\140\236\157\152 \236\150\145\236\157\180 \235\179\128\234\178\189\235\144\152\236\167\128 \236\149\138\236\149\152\235\139\164?")
      elseif self._enhance._cronCount ~= self._enhance._cronCountNext then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\156\236\136\152\234\176\128 \236\164\132\236\150\180\235\147\164\236\167\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164?")
      else
        if self._enhance._armorMaxEnduranceNext == 0 then
          ToClient_qaRegisterTimerForQA(100, "deleteItem(" .. getSelfPlayer():getActorKey() .. "," .. CppEnums.ItemWhereType.eInventory .. "," .. targetSlotNo .. "+2,1)")
          ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(" .. self._enhance._armorKey .. "," .. self._enhance._armorLevelNext .. ",1)")
        end
        Proc_ShowMessage_Ack("\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148 \236\139\164\237\140\168")
        self._enhance._isFail = true
      end
    elseif PaGlobal_AutoQASupport._enchantResult._resultType == 5 then
      if self._enhance._armorLevel ~= self._enhance._armorLevelNext then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \234\176\149\237\153\148\236\136\152\236\185\152\234\176\128 \235\139\172\235\157\188\236\160\184 \236\158\136\235\139\164")
      elseif self._enhance._failCountNext ~= self._enhance._failCount then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148[ \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \234\176\149\237\153\148\236\138\164\237\131\157\236\157\180 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
      elseif self._enhance._valksCountNext ~= self._enhance._valksCount then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148[ \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
      elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148[ \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
      elseif self._enhance._armorMaxEndurance ~= self._enhance._armorMaxEnduranceNext then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132\234\176\128 \235\139\172\235\157\188\236\160\184 \236\158\136\235\139\164")
      elseif self._enhance._armorMat1Count ~= self._enhance._armorMat1CountNext or self._enhance._armorMat2Count ~= self._enhance._armorMat2CountNext then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \234\176\149\237\153\148\236\158\172\235\163\140 \234\176\156\236\136\152\234\176\128 \235\139\172\235\157\188\236\160\184 \236\158\136\235\139\164")
      elseif self._enhance._cronCount ~= self._enhance._cronCountNext then
        ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\156\236\136\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164?")
      else
        Proc_ShowMessage_Ack("\235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177")
        ToClient_qaRegisterTimerForQA(100, "HandleEventRUp_SpiritEnchant_All_ReleseTargetItem()")
        ToClient_qaRegisterTimerForQA(100, "deleteItem(" .. getSelfPlayer():getActorKey() .. "," .. CppEnums.ItemWhereType.eInventory .. "," .. targetSlotNo .. "+2,1)")
        ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(" .. self._enhance._armorKey .. "," .. self._enhance._armorLevel .. ",1)")
      end
    elseif PaGlobal_AutoQASupport._enchantResult._resultType == 1 then
      _PA_LOG("AutoQA", "resultType : " .. PaGlobal_AutoQASupport._enchantResult._resultType)
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\149\133\236\132\184\236\132\156\235\166\172 \234\176\149\237\153\148\234\176\128 \236\149\132\235\139\140\235\141\176 \236\149\133\236\132\184\236\132\156\235\166\172 \234\178\176\234\179\188(\234\176\149\237\153\148 \236\139\164\237\140\168 \237\155\132 \237\140\140\234\180\180)\234\176\128 \235\130\152\236\153\148\236\138\181\235\139\136\235\139\164.")
    elseif PaGlobal_AutoQASupport._enchantResult._resultType == 4 then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157\236\157\132 \236\130\172\236\154\169\237\149\152\236\167\128 \236\149\138\236\149\152\236\156\188\235\130\152 \237\129\172\235\161\160\236\132\157 \234\178\176\234\179\188\234\176\146\236\157\180 \235\130\152\236\153\148\236\138\181\235\139\136\235\139\164. \237\153\149\236\157\184\237\149\180\235\180\144\236\149\188 \237\149\169\235\139\136\235\139\164.")
    else
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\158\152\235\170\187\235\144\156 resultType! \236\131\136\235\161\156 \236\182\148\234\176\128\235\144\156 \234\178\131\236\157\184\234\176\128..")
    end
  elseif PaGlobal_AutoQASupport._enchantResult._resultType == -1 then
    ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \234\176\149\237\153\148 \234\178\176\234\179\188 \236\160\128\236\158\165\236\151\144 \236\139\164\237\140\168\237\150\136\236\138\181\235\139\136\235\139\164. resultType \237\153\149\236\157\184 \237\149\132\236\154\148")
  elseif PaGlobal_AutoQASupport._enchantResult._resultType == 0 then
    if self._enhance._armorLevel + 1 ~= self._enhance._armorLevelNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148 \234\178\176\234\179\188\234\176\128 \236\132\177\234\179\181\236\157\180\236\167\128\235\167\140 \234\176\149\237\153\148 \235\160\136\235\178\168\236\157\180 \236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\152\172\235\157\188\234\176\128\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._failCountNext ~= 0 then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \235\176\156\237\129\172\236\138\164\236\157\152 \236\161\176\236\150\184 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\132\164\236\160\149\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._valksCountNext ~= 0 then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \235\176\156\237\129\172\236\138\164\236\157\152 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \236\132\164\236\160\149\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._armorMaxEnduranceNext ~= self._enhance._armorMaxEndurance then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148 \236\157\180\237\155\132 \234\176\149\237\153\148\234\176\128 \236\132\177\234\179\181\237\149\152\236\152\128\236\167\128\235\167\140 \237\149\180\235\139\185 \236\158\165\235\185\132\236\157\152 \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._armorMat1Count == self._armorMat1CountNext and self._enhance._armorMat2Count == self._armorMat2CountNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148\234\176\128 \236\167\132\237\150\137\235\144\152\236\151\136\236\156\188\235\130\152 \234\176\149\237\153\148\236\158\172\235\163\140\236\157\152 \236\150\145\236\157\180 \235\179\128\234\178\189\235\144\152\236\167\128 \236\149\138\236\149\152\235\139\164?")
    elseif self._enhance._cronCount <= self._enhance._cronCountNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\156\236\136\152\234\176\128 \236\164\132\236\150\180\235\147\164\236\167\128 \236\149\138\236\149\152\235\139\164.")
    else
      Proc_ShowMessage_Ack("\237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148 \236\132\177\234\179\181")
      self._enhance._isSuccess = true
    end
  elseif PaGlobal_AutoQASupport._enchantResult._resultType == 4 then
    if self._enhance._armorLevel > 16 and self._enhance._armorLevel ~= self._enhance._armorLevelNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148\234\176\128 \236\167\132\237\150\137\235\144\152\236\151\136\236\156\188\235\130\152, \236\139\164\237\140\168 \237\155\132 \236\158\165\235\185\132\235\160\136\235\178\168\236\157\180 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
    elseif self._enhance._armorLevel <= 16 and self._enhance._armorLevel ~= self._enhance._armorLevelNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148\234\176\128 \236\167\132\237\150\137\235\144\152\236\151\136\236\156\188\235\130\152, \236\139\164\237\140\168\237\149\180\235\143\132 \234\176\149\237\153\148\236\136\152\236\185\152\234\176\128 \235\150\168\236\150\180\236\167\128\236\167\128 \236\149\138\236\149\132\236\149\188 \237\149\160 \234\176\149\237\153\148\236\151\144\236\132\156 \234\176\149\237\153\148\236\136\152\236\185\152\234\176\128 \235\150\168\236\150\180\236\161\140\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._failCountNext ~= self._enhance._failCount then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148\235\157\188 \236\139\164\237\140\168 \236\139\156 \236\138\164\237\131\157\236\157\180 \236\156\160\236\167\128\235\144\152\236\150\180\236\149\188 \237\149\152\235\138\148\235\141\176 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164!")
    elseif self._enhance._valksCountNext ~= self._enhance._valksCount then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148\236\151\144 \236\139\164\237\140\168\237\149\152\236\152\128\235\138\148\235\141\176 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
    elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148 \236\157\180\237\155\132 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\185\132\236\160\149\236\131\129\236\160\129\236\156\188\235\161\156 \235\179\128\234\178\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._armorMaxEnduranceNext >= self._enhance._armorMaxEndurance then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148\236\151\144 \236\139\164\237\140\168\237\149\152\236\152\128\235\138\148\235\141\176 \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132\234\176\128 \234\185\142\236\157\180\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.")
    elseif self._enhance._armorMat1Count == self._armorMat1CountNext and self._enhance._armorMat2Count == self._armorMat2CountNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \234\176\149\237\153\148\234\176\128 \236\167\132\237\150\137\235\144\152\236\151\136\236\156\188\235\130\152 \234\176\149\237\153\148\236\158\172\235\163\140\236\157\152 \236\150\145\236\157\180 \235\179\128\234\178\189\235\144\152\236\167\128 \236\149\138\236\149\152\235\139\164?")
    elseif self._enhance._cronCount <= self._enhance._cronCountNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\156\236\136\152\234\176\128 \236\164\132\236\150\180\235\147\164\236\167\128 \236\149\138\236\149\152\235\139\164?")
    else
      if self._enhance._armorMaxEnduranceNext < 10 or self._enhance._armorLevel < 17 or self._enhance._armorLevel == 20 then
        ToClient_qaRegisterTimerForQA(100, "deleteItem(" .. getSelfPlayer():getActorKey() .. "," .. CppEnums.ItemWhereType.eInventory .. "," .. targetSlotNo .. "+2,1)")
        ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(" .. self._enhance._armorKey .. "," .. self._enhance._armorLevelNext .. ",1)")
      end
      Proc_ShowMessage_Ack("\237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148 \236\139\164\237\140\168")
      self._enhance._isFail = true
    end
  elseif PaGlobal_AutoQASupport._enchantResult._resultType == 5 then
    if self._enhance._armorLevel ~= self._enhance._armorLevelNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \234\176\149\237\153\148\236\136\152\236\185\152\234\176\128 \235\139\172\235\157\188\236\160\184 \236\158\136\235\139\164")
    elseif self._enhance._failCountNext ~= self._enhance._failCount then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148[ \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \234\176\149\237\153\148\236\138\164\237\131\157\236\157\180 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
    elseif self._enhance._valksCountNext ~= self._enhance._valksCount then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148[ \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \236\153\184\236\185\168 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
    elseif self._enhance._bonusCountNext ~= self._enhance._bonusCount then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148[ \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \236\152\129\234\181\172 \236\158\165\235\185\132 \234\176\149\237\153\148 \237\153\149\235\165\160 \236\136\152\236\185\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164.")
    elseif self._enhance._armorMaxEndurance ~= self._enhance._armorMaxEnduranceNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132\234\176\128 \235\139\172\235\157\188\236\160\184 \236\158\136\235\139\164")
    elseif self._enhance._armorMat1Count ~= self._enhance._armorMat1CountNext or self._enhance._armorMat2Count ~= self._enhance._armorMat2CountNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\181\156\235\140\128 \235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177\236\156\188\235\161\156 \234\176\149\237\153\148 \236\167\132\237\150\137\236\157\180 \235\167\137\237\152\128\236\158\136\235\138\148\235\141\176 \234\176\149\237\153\148\236\158\172\235\163\140 \234\176\156\236\136\152\234\176\128 \235\139\172\235\157\188\236\160\184 \236\158\136\235\139\164")
    elseif self._enhance._cronCount ~= self._enhance._cronCountNext then
      ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157 \234\176\156\236\136\152\234\176\128 \235\179\128\234\178\189\235\144\152\236\151\136\235\139\164?")
    else
      Proc_ShowMessage_Ack("\235\130\180\234\181\172\235\143\132 \235\182\128\236\161\177")
      ToClient_qaRegisterTimerForQA(100, "HandleEventRUp_SpiritEnchant_All_ReleseTargetItem()")
      ToClient_qaRegisterTimerForQA(100, "deleteItem(" .. getSelfPlayer():getActorKey() .. "," .. CppEnums.ItemWhereType.eInventory .. "," .. targetSlotNo .. "+2,1)")
      ToClient_qaRegisterTimerForQA(100, "ToClient_qaCreateItem(" .. self._enhance._armorKey .. "," .. self._enhance._armorLevel .. ",1)")
    end
  elseif PaGlobal_AutoQASupport._enchantResult._resultType == 1 or PaGlobal_AutoQASupport._enchantResult._resultType == 2 then
    _PA_LOG("AutoQA", "resultType : " .. PaGlobal_AutoQASupport._enchantResult._resultType)
    ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\149\133\236\132\184\236\132\156\235\166\172 \234\176\149\237\153\148\234\176\128 \236\149\132\235\139\140\235\141\176 \236\149\133\236\132\184\236\132\156\235\166\172 \234\176\149\237\153\148 \234\178\176\234\179\188\234\176\128 \235\130\152\236\153\148\236\138\181\235\139\136\235\139\164.")
  elseif PaGlobal_AutoQASupport._enchantResult._resultType == 4 then
    ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \237\129\172\235\161\160\236\132\157\236\157\132 \236\130\172\236\154\169\237\149\152\236\167\128 \236\149\138\236\149\152\236\156\188\235\130\152 \237\129\172\235\161\160\236\132\157 \234\178\176\234\179\188\234\176\146\236\157\180 \235\130\152\236\153\148\236\138\181\235\139\136\235\139\164. \237\153\149\236\157\184\237\149\180\235\180\144\236\149\188 \237\149\169\235\139\136\235\139\164.")
  else
    ErrorHandler("[\235\176\169\236\150\180\234\181\172 \234\176\149\237\153\148] \236\158\152\235\170\187\235\144\156 resultType! \236\131\136\235\161\156 \236\182\148\234\176\128\235\144\156 \234\178\131\236\157\184\234\176\128..")
  end
  if true == self._enhance._isSuccess and true == self._enhance._isFail then
    self._enhance._armorLevel = -1
    self._enhance._armorLevelNext = -1
    self._enhance._isSuccess = false
    self._enhance._isFail = false
    if self._enhance._isCronApplied == false then
      PaGlobal_AutoQASupport:writeLogFile("[\235\176\169\236\150\180\234\181\172 \236\157\188\235\176\152 \234\176\149\237\153\148] \237\133\140\236\138\164\237\138\184 \236\162\133\235\163\140", true)
      self._enhance._isCronApplied = true
      PaGlobal_AutoQASupport._enchantResult._resultType = -1
      ToClient_qaRegisterTimerForQA(100, "QA_BlackSpirit:checkArmorMaterial()")
    else
      PaGlobal_AutoQASupport:writeLogFile("[\235\176\169\236\150\180\234\181\172 \237\129\172\235\161\160\236\132\157 \234\176\149\237\153\148] \237\133\140\236\138\164\237\138\184 \236\162\133\235\163\140", true)
      self._enhance._isCronApplied = false
      PaGlobal_AutoQASupport._enchantResult._resultType = -1
      ToClient_qaRegisterTimerForQA(100, "QA_BlackSpirit:forceEnhanceArmorStart()")
    end
  else
    self._enhance._armorLevel = self._enhance._armorLevelNext
    ToClient_qaRegisterTimerForQA(500, "QA_BlackSpirit:checkArmorMaterial()")
  end
end
