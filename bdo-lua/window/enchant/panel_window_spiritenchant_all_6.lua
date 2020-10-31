function PaGlobalFunc_SpiritEnchant_All_Open()
  PaGlobal_SpiritEnchant_All:prepareOpen()
end
function PaGlobalFunc_SpiritEnchant_All_Close()
  if true == Panel_Window_EnchantStackConfirm_All:GetShow() and nil ~= Panel_Window_EnchantStackConfirm_All then
    PaGlobalFunc_EnchantStackConfirm_All_Close()
    return
  end
  if true == _ContentsGroup_FamilyStack and true == PaGlobalFunc_StackStorage_All_GetShow() then
    PaGlobalFunc_StackStorage_All_Close()
  end
  PaGlobal_SpiritEnchant_All:prepareClose()
  HandleEventLUp_DialogMain_All_BackClick()
end
function HandleEventLUp_SpiritEnchant_All_MainTabSelect(tabIdx)
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if nil == tabIdx or true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  PaGlobal_SpiritEnchant_All:setAnimationSkipButton()
  PaGlobal_SpiritEnchant_All:mainTabCheck(PaGlobal_SpiritEnchant_All._ui.btn_mainRadio[tabIdx], PaGlobal_SpiritEnchant_All._ui.stc_selectBar)
  PaGlobal_SpiritEnchant_All._currentMainTab = tabIdx
  if PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT == tabIdx then
    PaGlobal_SpiritEnchant_All._ui_enchant.stc_enchantBg:SetShow(true)
    PaGlobal_SpiritEnchant_All._ui_extraction.stc_extractionBg:SetShow(false)
    PaGlobal_SpiritEnchant_All:enchantTabOpen()
    PaGlobal_SpiritEnchant_All._ui_extraction.btn_subRadio[1]:SetCheck(false)
    PaGlobal_SpiritEnchant_All._ui_extraction.btn_subRadio[2]:SetCheck(false)
    PaGlobal_SpiritEnchant_All._ui_enchant.chk_skipAni:SetCheck(PaGlobal_SpiritEnchant_All._isEnchantAniSkip)
    if true == _ContentsGroup_FamilyStack then
      local slotSize = ToClient_GetFailCountSlotSize()
      if nil ~= slotSize and 0 < slotSize then
        PaGlobalFunc_StackStorage_All_Open()
      else
        PaGlobalFunc_StackStorage_All_Close()
      end
    end
  elseif PaGlobal_SpiritEnchant_All._MAIN_TAB.EXTRACTION == tabIdx then
    PaGlobal_SpiritEnchant_All._ui_enchant.stc_enchantBg:SetShow(false)
    PaGlobal_SpiritEnchant_All._ui_extraction.stc_extractionBg:SetShow(true)
    HandleEventLUp_SpiritEnchant_All_SubTabSelect(PaGlobal_SpiritEnchant_All._currentSubTab)
  elseif PaGlobal_SpiritEnchant_All._MAIN_TAB.CARPHRAS == tabIdx then
    PaGlobal_SpiritEnchant_All._ui_enchant.stc_enchantBg:SetShow(true)
    PaGlobal_SpiritEnchant_All._ui_extraction.stc_extractionBg:SetShow(false)
    PaGlobal_SpiritEnchant_All:caphrasOpen()
    PaGlobal_SpiritEnchant_All._ui_extraction.btn_subRadio[1]:SetCheck(false)
    PaGlobal_SpiritEnchant_All._ui_extraction.btn_subRadio[2]:SetCheck(false)
    PaGlobal_SpiritEnchant_All._ui_enchant.chk_skipAni:SetCheck(PaGlobal_SpiritEnchant_All._isCaphrasAniSkip)
    if true == _ContentsGroup_FamilyStack then
      PaGlobalFunc_StackStorage_All_Close()
    end
  end
  if true == PaGlobal_SpiritEnchant_All._isConsole then
    PaGlobalFunc_SpiritEnchant_All_ShowRstickKeyGuide(false)
  end
  PaGlobal_SpiritEnchant_All:resizePanel()
end
function HandleEventLUp_SpiritEnchant_All_SubTabSelect(tabIdx)
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if nil == tabIdx or true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  PaGlobal_SpiritEnchant_All:setAnimationSkipButton()
  PaGlobal_SpiritEnchant_All:subTabCheck(PaGlobal_SpiritEnchant_All._ui_extraction.btn_subRadio[tabIdx], PaGlobal_SpiritEnchant_All._ui_extraction.stc_selectBar)
  PaGlobal_SpiritEnchant_All._currentSubTab = tabIdx
  if PaGlobal_SpiritEnchant_All._SUB_TAB.DARK == tabIdx then
    PaGlobal_SpiritEnchant_All._ui_extraction.stc_imageDarkPredation:SetShow(true)
    PaGlobal_SpiritEnchant_All._ui_extraction.stc_imageSecretBook:SetShow(false)
    PaGlobal_SpiritEnchant_All:darkExtractionTabOpen()
    PaGlobal_SpiritEnchant_All._ui_extraction.chk_skipAni:SetCheck(PaGlobal_SpiritEnchant_All._isDarkAniSkip)
    if true == _ContentsGroup_FamilyStack then
      PaGlobalFunc_StackStorage_All_Close()
    end
  elseif PaGlobal_SpiritEnchant_All._SUB_TAB.BOOK == tabIdx then
    PaGlobal_SpiritEnchant_All._ui_extraction.stc_imageDarkPredation:SetShow(false)
    PaGlobal_SpiritEnchant_All._ui_extraction.stc_imageSecretBook:SetShow(true)
    PaGlobal_SpiritEnchant_All:bookExtractionTabOpen()
    PaGlobal_SpiritEnchant_All._ui_extraction.chk_skipAni:SetCheck(PaGlobal_SpiritEnchant_All._isBookAniSkip)
    if true == _ContentsGroup_FamilyStack then
      PaGlobalFunc_StackStorage_All_Close()
    end
  end
  PaGlobal_SpiritEnchant_All:resizePanel()
end
function HandleEventRUp_SpiritEnchant_All_ReleseTargetItem()
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  local itemWrapper = PaGlobalFunc_SpiritEnchant_All_GetItemWrapper()
  if nil ~= itemWrapper then
    local itemStatic = itemWrapper:getStaticStatus():get()
    if nil ~= itemStatic then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
    end
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_SpiritEnchant_All:clearEnchantSlot()
  PaGlobal_SpiritEnchant_All:enchantTabOpen()
  PaGlobal_SpiritEnchant_All:resizePanel()
end
function HandleEventRUp_SpiritEnchant_All_MaterialSlotRelease(slotPos)
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  if nil == PaGlobal_SpiritEnchant_All._materialItemSlotNo or nil == PaGlobal_SpiritEnchant_All._materialItemWhereType then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_SpiritEnchant_All:clearItemSlot(PaGlobal_SpiritEnchant_All._slotMateiralInfo[slotPos])
  PaGlobal_SpiritEnchant_All._materialItemSlotNo = nil
  PaGlobal_SpiritEnchant_All._materialItemWhereType = nil
  PaGlobal_SpiritEnchant_All:clearEnchantCheckBox()
  PaGlobal_SpiritEnchant_All:setHasMaterialItem()
end
function HandleEventLUp_SpiritEnchant_All_RadioCheckClick(flag)
  if PaGlobal_SpiritEnchant_All._currentMainTab ~= PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
    return
  end
  if true == PaGlobal_SpiritEnchant_All._ui_enchant.radio_enchantNormal:IsCheck() then
    PaGlobal_SpiritEnchant_All._isEnchantPerfect = false
  elseif true == PaGlobal_SpiritEnchant_All._ui_enchant.radio_enchantPerfect:IsCheck() then
    PaGlobal_SpiritEnchant_All._isEnchantPerfect = true
  end
  if nil ~= flag and false == PaGlobal_SpiritEnchant_All:CheckEnchantCheckbox(flag) then
    return
  end
  PaGlobal_SpiritEnchant_All:setHasMaterialItem()
  PaGlobal_SpiritEnchant_All:didsetEnchantTarget(true, true)
  PaGlobal_SpiritEnchant_All:setText_EnchantInfo()
  PaGlobal_SpiritEnchant_All:resizePanel()
end
function HandleEventLUp_SpiritEnchant_All_EnchantCheckClick()
  PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantForce:SetCheck(false)
  HandleEventLUp_SpiritEnchant_All_RadioCheckClick()
end
function HandleEventLUp_SpiritEnchant_All_EnchantApplyButton()
  if PaGlobal_SpiritEnchant_All._currentMainTab ~= PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
    return
  end
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    if false == PaGlobal_SpiritEnchant_All._isConsole then
      PaGlobal_SpiritEnchant_All._isClickCancle = true
      PaGlobal_SpiritEnchant_All._isAbleEnchant = true
      PaGlobal_SpiritEnchant_All:cancleEnchant()
      ToClient_StopLedDeviceAnimation(7)
    end
    return
  end
  if false == PaGlobal_SpiritEnchant_All._isAbleEnchant then
    return
  end
  local isForceEnchantCheck = PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantForce:IsCheck()
  local isPerfectEnchantCheck = PaGlobal_SpiritEnchant_All._ui_enchant.radio_enchantPerfect:IsCheck()
  if true == ToClient_isNeedCautionByStack(isForceEnchantCheck, isPerfectEnchantCheck) then
    if nil ~= Panel_Window_EnchantStackConfirm_All then
      PaGlobalFunc_EnchantStackConfirm_All_Open()
    end
  else
    PaGlobal_SpiritEnchant_All:enchantApplyButton()
  end
end
function HandleEventLUp_SpiritEnchant_All_EnchantApplyWithMyStackCount()
  if PaGlobal_SpiritEnchant_All._currentMainTab ~= PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
    return
  end
  PaGlobal_SpiritEnchant_All:willStartEnchant()
end
function HandleEventOnOut_SpiritEnchant_All_EquipSlotTooltip(isShow)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if true == PaGlobal_SpiritEnchant_All._slotEquip.slot.empty then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_SpiritEnchant_All._slotEquip.slot.inventoryType, PaGlobal_SpiritEnchant_All._slotEquip.slot.slotNo)
  if nil == itemWrapper then
    return
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    if PaGlobal_SpiritEnchant_All._isLastEnchant then
      Panel_Tooltip_Item_Show(itemWrapper, PaGlobal_SpiritEnchant_All._slotEquip.slot.icon, false, true, nil)
    else
      Panel_Tooltip_Item_Show_GeneralNormal(0, "Enchant", true)
    end
  end
end
function HandleEventOnOut_SpiritEnchant_All_MaterialTooltip(isShow)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if true == PaGlobal_SpiritEnchant_All._slotMateiralInfo[1].empty then
    return
  end
  local needSSW
  if nil ~= PaGlobal_SpiritEnchant_All._materialItemSlotNo then
    needSSW = getInventoryItemByType(PaGlobal_SpiritEnchant_All._materialItemWhereType, PaGlobal_SpiritEnchant_All._materialItemSlotNo)
    if nil == needSSW then
      return
    end
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_Show(needSSW, PaGlobal_SpiritEnchant_All._slotMateiralInfo[1].icon, false, true, nil)
    end
  else
    needSSW = PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getNeedItemStaticInformation()
    if nil == needSSW then
      return
    end
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_Show(needSSW, PaGlobal_SpiritEnchant_All._slotMateiralInfo[1].icon, true, false)
    end
  end
end
function HandleEventOnOut_SpiritEnchant_All_SubMaterialTooltip(isShow)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if true == PaGlobal_SpiritEnchant_All._slotMateiralInfo[2].empty then
    return
  end
  local currentNeedPerfectItemSSW = getInventoryItemByType(PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getCronItemWhereType(), PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getCronSlotNo())
  local currentPerfectSS
  if nil ~= currentNeedPerfectItemSSW then
    currentPerfectSS = currentNeedPerfectItemSSW:getStaticStatus()
  else
    currentPerfectSS = getItemEnchantStaticStatus(ItemEnchantKey(16080))
  end
  if nil == currentPerfectSS then
    return
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_Show(currentPerfectSS, PaGlobal_SpiritEnchant_All._slotMateiralInfo[2].icon, true, false)
  end
end
function HandleEventRUp_SpiritEnchant_All_CaphrasEquipRelease()
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  local itemWrapper = PaGlobalFunc_SpiritEnchant_All_GetItemWrapper()
  if nil ~= itemWrapper then
    local itemStatic = itemWrapper:getStaticStatus():get()
    if nil ~= itemStatic then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
    end
  end
  Panel_NumberPad_Show(false, Defines.s64_const.s64_0, 0, nil)
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_SpiritEnchant_All:clearCaphrasSlot()
  PaGlobal_SpiritEnchant_All:caphrasOpen()
end
function HandleEventLUp_SpiritEnchant_All_SelectCaphrasStone()
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  if nil == PaGlobal_SpiritEnchant_All._enchantInfo then
    return
  end
  if nil == PaGlobal_SpiritEnchant_All._grantItemSlotNo then
    return
  end
  local slotNo = PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getCaphRasSlotNo()
  local inventoryType = PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getCaphRasItemWhereType()
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  if nil ~= itemWrapper then
    PaGlobal_SpiritEnchant_All_RClickCaphrasItem(slotNo, itemWrapper, itemWrapper:get():getCount_s64(), inventoryType)
  end
end
function HandleEventOnOut_SpiritEnchant_All_CaphrasEquipSlotTooltip(isShow, isResult, isPromotion)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if nil == PaGlobal_SpiritEnchant_All._grantItemSlotNo and nil == PaGlobal_SpiritEnchant_All._grantItemWhereType then
    return
  end
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_SpiritEnchant_All._grantItemWhereType, PaGlobal_SpiritEnchant_All._grantItemSlotNo)
  if nil == itemWrapper then
    return
  end
  if true == isResult and true == isPromotion then
    local nextEnchantItemSSW = PaGlobal_SpiritEnchant_All:getNextEnchantItemSSW(itemWrapper)
    if nil == nextEnchantItemSSW then
      return
    end
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_Show(nextEnchantItemSSW, PaGlobal_SpiritEnchant_All._slotResult_Caphras.icon, true, false, nil)
    end
    return
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_Show(itemWrapper, PaGlobal_SpiritEnchant_All._slotResult_Caphras.icon, false, true, nil)
  end
end
function HandleEventOnOut_SpiritEnchant_All_CaphrasMaterialSlotTooltip(isShow)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if nil == PaGlobal_SpiritEnchant_All._grantItemSlotNo and nil == PaGlobal_SpiritEnchant_All._grantItemWhereType then
    return
  end
  if true == PaGlobal_SpiritEnchant_All._slotMaterial_Caphras.empty then
    return
  end
  local needSSW = ToClient_getPromotionEnchantItem()
  if nil == needSSW then
    return
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_Show(needSSW, PaGlobal_SpiritEnchant_All._slotMaterial_Caphras.icon, true, false)
  end
end
function HandleEventOnOut_SpiritEnchant_All_StackChangeTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  if false == _ContentsGroup_FamilyStack then
    return
  end
  local control = PaGlobal_SpiritEnchant_All._ui_enchant.btn_stackChange
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_STACKSTORAGE_TOOLTIP_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_STACKSTORAGE_TOOLTIP_DESC")
  local slotSize = ToClient_GetFailCountSlotSize()
  if 0 == slotSize then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_STACKSTORAGE_TOOLTIP_UNLOCK_DESC")
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_SpiritEnchant_All_CaphrasEnchantApplyButton()
  if PaGlobal_SpiritEnchant_All._currentMainTab ~= PaGlobal_SpiritEnchant_All._MAIN_TAB.CARPHRAS then
    return
  end
  PaGlobal_SpiritEnchant_All:caphrasEnchantApplyButton()
end
function PaGlobal_SpiritEnchant_All_InvenFilerCaphrasItem(slotNo, notUse_itemWrappers, whereType)
  local caphrasItemWrapper = getInventoryItemByType(whereType, slotNo)
  local protectItemSSW = ToClient_getPromotionEnchantItem()
  if nil ~= caphrasItemWrapper then
    local itemSSW = caphrasItemWrapper:getStaticStatus()
    local itemName = itemSSW:getName()
    if protectItemSSW:getName() == itemName then
      return false
    end
  end
  return true
end
function PaGlobal_SpiritEnchant_All_RClickCaphrasItem(slotNo, itemWrapper, Count, inventoryType)
  if PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  if itemWrapper:checkToValksItem() then
    if true == _ContentsGroup_NewUI_Inventory_All then
      PaGlobalFunc_Inventory_All_UseItemTargetSelf(inventoryType, slotNo, 0)
    else
      Inventory_UseItemTargetSelf(inventoryType, slotNo, 0)
    end
    return
  end
  PaGlobal_SpiritEnchant_All._isLastEnchant = false
  Panel_NumberPad_Show(true, itemWrapper:get():getCount_s64(), 0, PaGlobal_SpiritEnchant_All_SetCaphrasItemCount)
end
function PaGlobal_SpiritEnchant_All_SetCaphrasItemCount(inputNumber)
  PaGlobal_SpiritEnchant_All:clearItemSlot(PaGlobal_SpiritEnchant_All._slotMaterial_Caphras)
  PaGlobal_SpiritEnchant_All:setCaphrasEnchantMaterial(false, inputNumber)
end
function HandleEventLUp_SpiritEnchant_All_DarkPredationApplyButton()
  PaGlobal_SpiritEnchant_All:darkPredationApplyButton()
end
function HandleEventRUp_SpiritEnchant_All_DarkPredationItemRelease()
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  local itemWrapper = PaGlobalFunc_SpiritEnchant_All_GetItemWrapper()
  if nil ~= itemWrapper then
    local itemStatic = itemWrapper:getStaticStatus():get()
    if nil ~= itemStatic then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
    end
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_SpiritEnchant_All:clearDarkSlot()
  PaGlobal_SpiritEnchant_All:darkExtractionTabOpen()
end
function HandleEventOnOut_SpiritEnchant_All_DarkPredationTooltip(isShow)
  if false == isShow then
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_hideTooltip()
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
    return
  end
  if true == PaGlobal_SpiritEnchant_All._slotDarkItem.empty then
    return
  end
  local getItemSSW = getInventoryItemByType(PaGlobal_SpiritEnchant_All._grantItemWhereType, PaGlobal_SpiritEnchant_All._grantItemSlotNo)
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_Show(getItemSSW, PaGlobal_SpiritEnchant_All._slotDarkItem.icon, false, true)
  end
end
function HandleEventRUp_SpiritEnchant_All_BookItemRelease()
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  local itemWrapper = PaGlobalFunc_SpiritEnchant_All_GetItemWrapper()
  if nil ~= itemWrapper then
    local itemStatic = itemWrapper:getStaticStatus():get()
    if nil ~= itemStatic then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
    end
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_SpiritEnchant_All:clearBookSlot()
  PaGlobal_SpiritEnchant_All:bookExtractionTabOpen()
end
function HandleEventOnOut_SpiritEnchant_All_BookExtractionTooltip(controlType, isShow)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if 1 == controlType then
    if true == PaGlobal_SpiritEnchant_All._slotBookItem.empty then
      return
    end
    local itemWrapper = getInventoryItemByType(PaGlobal_SpiritEnchant_All._grantItemWhereType, PaGlobal_SpiritEnchant_All._grantItemSlotNo)
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_Show(itemWrapper, PaGlobal_SpiritEnchant_All._slotBookItem.icon, false, true, nil, nil, nil)
    end
  elseif 2 == controlType then
    if true == PaGlobal_SpiritEnchant_All._slotValksItem.empty then
      return
    end
    local failCount = getSelfPlayer():get():getEnchantFailCount()
    local itemFailCount = failCount
    local balksItemItemKey
    if 100 < itemFailCount then
      balksItemItemKey = itemFailCount + 288900
    else
      balksItemItemKey = itemFailCount + 17799
    end
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(balksItemItemKey))
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_Show(itemSSW, PaGlobal_SpiritEnchant_All._slotValksItem.icon, true, false, nil, nil, nil)
    end
  end
end
function HandleEventLUp_SpiritEnchant_All_BookExtractionApplyButton()
  PaGlobal_SpiritEnchant_All:bookExtractionApplyButton()
end
function HandlePadEventY_SpiritEnchant_All_EnchantApplyButton()
  HandleEventLUp_SpiritEnchant_All_EnchantApplyButton()
end
function HandlePadEventY_SpiritEnchant_All_CaphrasEnchantApplyButton()
  HandleEventLUp_SpiritEnchant_All_CaphrasEnchantApplyButton()
end
function HandlePadEventY_SpiritEnchant_All_DarkPredationApplyButton()
  PaGlobal_SpiritEnchant_All:darkPredationApplyButton()
end
function HandlePadEventY_SpiritEnchant_All_BookExtractionApplyButton()
  PaGlobal_SpiritEnchant_All:bookExtractionApplyButton()
end
function HandlePadEventLBRB_SpiritEnchant_All_MainMoveTab(isLeft)
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  local ableTabIdx = {}
  local ableIdx = 0
  local curIdx = 0
  for index = 1, #PaGlobal_SpiritEnchant_All._ui.btn_mainRadio do
    if true == PaGlobal_SpiritEnchant_All._ui.btn_mainRadio[index]:GetShow() then
      if PaGlobal_SpiritEnchant_All._currentMainTab == index then
        curIdx = ableIdx
      end
      ableTabIdx[ableIdx] = index
      ableIdx = ableIdx + 1
    end
  end
  if true == isLeft then
    if PaGlobal_SpiritEnchant_All._currentMainTab == ableTabIdx[0] then
      curIdx = ableIdx
    end
    HandleEventLUp_SpiritEnchant_All_MainTabSelect(ableTabIdx[curIdx - 1])
  else
    if PaGlobal_SpiritEnchant_All._currentMainTab == ableTabIdx[ableIdx - 1] then
      curIdx = -1
    end
    HandleEventLUp_SpiritEnchant_All_MainTabSelect(ableTabIdx[curIdx + 1])
  end
end
function HandlePadEventLTRT_SpiritEnchant_All_SubMoveTab(isLeft)
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  if PaGlobal_SpiritEnchant_All._currentMainTab ~= PaGlobal_SpiritEnchant_All._MAIN_TAB.EXTRACTION then
    return
  end
  if true == isLeft then
    if PaGlobal_SpiritEnchant_All._currentSubTab == 1 then
      PaGlobal_SpiritEnchant_All._currentSubTab = #PaGlobal_SpiritEnchant_All._ui_extraction.btn_subRadio + 1
    end
    HandleEventLUp_SpiritEnchant_All_SubTabSelect(PaGlobal_SpiritEnchant_All._currentSubTab - 1)
  else
    if PaGlobal_SpiritEnchant_All._currentSubTab == #PaGlobal_SpiritEnchant_All._ui_extraction.btn_subRadio then
      PaGlobal_SpiritEnchant_All._currentSubTab = 0
    end
    HandleEventLUp_SpiritEnchant_All_SubTabSelect(PaGlobal_SpiritEnchant_All._currentSubTab + 1)
  end
end
function HandlePadEventB_SpiritEnchant_All_OnPadB()
  if nil ~= Panel_Window_EnchantStackConfirm_All and true == Panel_Window_EnchantStackConfirm_All:GetShow() then
    PaGlobalFunc_EnchantStackConfirm_All_Close()
    return false
  end
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    if PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
      PaGlobal_SpiritEnchant_All._isClickCancle = true
      PaGlobal_SpiritEnchant_All._isAbleEnchant = true
      PaGlobal_SpiritEnchant_All:cancleEnchant()
      ToClient_StopLedDeviceAnimation(7)
    elseif PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.CARPHRAS then
      if true == PaGlobal_SpiritEnchant_All._isPossiblePromotion then
        PaGlobal_SpiritEnchant_All:cancleCaphrasPromotion()
      else
        PaGlobal_SpiritEnchant_All:cancleCaphrasEnchant()
      end
    elseif PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.EXTRACTION then
      if PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.DARK then
        PaGlobal_SpiritEnchant_All:cancleDarkPredation()
      elseif PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.BOOK then
        PaGlobal_SpiritEnchant_All:cancleBookExtraction()
      end
    end
    return false
  end
  if nil ~= PaGlobalFunc_SpiritEnchant_All_GetItemWrapper() or true == PaGlobal_SpiritEnchant_All._isLastEnchant then
    if PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
      HandleEventRUp_SpiritEnchant_All_ReleseTargetItem()
      return false
    elseif PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.CARPHRAS then
      HandleEventRUp_SpiritEnchant_All_CaphrasEquipRelease()
      return false
    elseif PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.EXTRACTION then
      if PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.DARK then
        HandleEventRUp_SpiritEnchant_All_DarkPredationItemRelease()
      elseif PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.BOOK then
        HandleEventRUp_SpiritEnchant_All_BookItemRelease()
      end
      return false
    end
  end
  PaGlobalFunc_SpiritEnchant_All_Close()
  return true
end
function HandlePadEventX_SpiritEnchant_All_EquipSlotTooltip()
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if true == PaGlobal_SpiritEnchant_All._slotEquip.slot.empty then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_SpiritEnchant_All._slotEquip.slot.inventoryType, PaGlobal_SpiritEnchant_All._slotEquip.slot.slotNo)
  if nil == itemWrapper then
    return
  end
  local invenPosX = 0
  if true == _ContentsGroup_NewUI_Inventory_All then
    invenPosX = Panel_Window_Inventory_All:GetPosX()
  else
    invenPosX = Panel_Window_Inventory:GetPosX()
  end
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, invenPosX - PaGlobal_SpiritEnchant_All._tooltipSpanX)
end
function HandlePadEventX_SpiritEnchant_All_MaterialTooltip()
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if true == PaGlobal_SpiritEnchant_All._slotMateiralInfo[1].empty then
    return
  end
  local invenPosX = 0
  if true == _ContentsGroup_NewUI_Inventory_All then
    invenPosX = Panel_Window_Inventory_All:GetPosX()
  else
    invenPosX = Panel_Window_Inventory:GetPosX()
  end
  local needSSW
  if nil ~= PaGlobal_SpiritEnchant_All._materialItemSlotNo then
    needSSW = getInventoryItemByType(PaGlobal_SpiritEnchant_All._materialItemWhereType, PaGlobal_SpiritEnchant_All._materialItemSlotNo)
    if nil == needSSW then
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, needSSW, Defines.TooltipTargetType.Item, invenPosX - PaGlobal_SpiritEnchant_All._tooltipSpanX)
  else
    needSSW = PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getNeedItemStaticInformation()
    if nil == needSSW then
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, needSSW, Defines.TooltipTargetType.Item, invenPosX - PaGlobal_SpiritEnchant_All._tooltipSpanX)
  end
end
function HandlePadEventX_SpiritEnchant_All_SubMaterialTooltip()
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if true == PaGlobal_SpiritEnchant_All._slotMateiralInfo[2].empty then
    return
  end
  local currentNeedPerfectItemSSW = getInventoryItemByType(PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getCronItemWhereType(), PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getCronSlotNo())
  local currentPerfectSS
  if nil ~= currentNeedPerfectItemSSW then
    currentPerfectSS = currentNeedPerfectItemSSW:getStaticStatus()
  else
    currentPerfectSS = getItemEnchantStaticStatus(ItemEnchantKey(16080))
  end
  if nil == currentPerfectSS then
    return
  end
  local invenPosX = 0
  if true == _ContentsGroup_NewUI_Inventory_All then
    invenPosX = Panel_Window_Inventory_All:GetPosX()
  else
    invenPosX = Panel_Window_Inventory:GetPosX()
  end
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, currentPerfectSS, Defines.TooltipTargetType.Item, invenPosX - PaGlobal_SpiritEnchant_All._tooltipSpanX)
end
function HandlePadEventX_SpiritEnchant_All_CaphrasEquipSlotTooltip(isResult, isPromotion)
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if nil == PaGlobal_SpiritEnchant_All._grantItemSlotNo and nil == PaGlobal_SpiritEnchant_All._grantItemWhereType then
    return
  end
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_SpiritEnchant_All._grantItemWhereType, PaGlobal_SpiritEnchant_All._grantItemSlotNo)
  if nil == itemWrapper then
    return
  end
  local invenPosX = 0
  if true == _ContentsGroup_NewUI_Inventory_All then
    invenPosX = Panel_Window_Inventory_All:GetPosX()
  else
    invenPosX = Panel_Window_Inventory:GetPosX()
  end
  if true == isResult and true == isPromotion then
    local nextEnchantItemSSW = PaGlobal_SpiritEnchant_All:getNextEnchantItemSSW(itemWrapper)
    if nil == nextEnchantItemSSW then
      return
    end
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_Show(nextEnchantItemSSW, PaGlobal_SpiritEnchant_All._slotResult_Caphras.icon, true, false, nil)
    else
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, nextEnchantItemSSW, Defines.TooltipTargetType.Item, invenPosX - PaGlobal_SpiritEnchant_All._tooltipSpanX)
    end
    return
  end
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, invenPosX - PaGlobal_SpiritEnchant_All._tooltipSpanX)
end
function HandlePadEventX_SpiritEnchant_All_CaphrasMaterialSlotTooltip()
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if nil == PaGlobal_SpiritEnchant_All._grantItemSlotNo and nil == PaGlobal_SpiritEnchant_All._grantItemWhereType then
    return
  end
  if true == PaGlobal_SpiritEnchant_All._slotMaterial_Caphras.empty then
    return
  end
  local needSSW = ToClient_getPromotionEnchantItem()
  if nil == needSSW then
    return
  end
  local invenPosX = 0
  if true == _ContentsGroup_NewUI_Inventory_All then
    invenPosX = Panel_Window_Inventory_All:GetPosX()
  else
    invenPosX = Panel_Window_Inventory:GetPosX()
  end
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, needSSW, Defines.TooltipTargetType.Item, invenPosX - PaGlobal_SpiritEnchant_All._tooltipSpanX)
end
function HandlePadEventX_SpiritEnchant_All_DarkPredationTooltip()
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if true == PaGlobal_SpiritEnchant_All._slotDarkItem.empty then
    return
  end
  local invenPosX = 0
  if true == _ContentsGroup_NewUI_Inventory_All then
    invenPosX = Panel_Window_Inventory_All:GetPosX()
  else
    invenPosX = Panel_Window_Inventory:GetPosX()
  end
  local getItemSSW = getInventoryItemByType(PaGlobal_SpiritEnchant_All._grantItemWhereType, PaGlobal_SpiritEnchant_All._grantItemSlotNo)
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, getItemSSW, Defines.TooltipTargetType.Item, invenPosX - PaGlobal_SpiritEnchant_All._tooltipSpanX)
end
function HandlePadEventX_SpiritEnchant_All_BookExtractionTooltip(controlType)
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local invenPosX = 0
  if true == _ContentsGroup_NewUI_Inventory_All then
    invenPosX = Panel_Window_Inventory_All:GetPosX()
  else
    invenPosX = Panel_Window_Inventory:GetPosX()
  end
  if 1 == controlType then
    if true == PaGlobal_SpiritEnchant_All._slotBookItem.empty then
      return
    end
    local itemWrapper = getInventoryItemByType(PaGlobal_SpiritEnchant_All._grantItemWhereType, PaGlobal_SpiritEnchant_All._grantItemSlotNo)
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, invenPosX - PaGlobal_SpiritEnchant_All._tooltipSpanX)
  elseif 2 == controlType then
    if true == PaGlobal_SpiritEnchant_All._slotValksItem.empty then
      return
    end
    local failCount = getSelfPlayer():get():getEnchantFailCount()
    local itemFailCount = failCount
    local balksItemItemKey
    if 100 < itemFailCount then
      balksItemItemKey = itemFailCount + 288900
    else
      balksItemItemKey = itemFailCount + 17799
    end
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(balksItemItemKey))
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, invenPosX - PaGlobal_SpiritEnchant_All._tooltipSpanX)
  end
end
function FromClient_SpiritEnchant_All_OnScreenResize()
  PaGlobal_SpiritEnchant_All:resize()
end
function FromClient_SpiritEnchant_All_UpdateEnchantFailCount()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if false == Panel_Window_StackExtraction_All:GetShow() then
    return
  end
  if PaGlobal_SpiritEnchant_All._currentMainTab ~= PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
    return
  end
  PaGlobal_SpiritEnchant_All:setEnchantFailCount()
  PaGlobal_SpiritEnchant_All:showEnchantDifficulty()
end
function FromClient_SpiritEnchant_All_EnchantFailCountUpResult(enchantFailCount, enchantFailCountUpRate, isSuccess)
  PaGlobal_SpiritEnchant_All:updateEnchantFailCount()
  if true == isSuccess then
    PaGlobal_SpiritEnchant_All:showEnchantResultNakMessage(true, PAGetString(Defines.StringSheet_GAME, "LUA_EATENCHANT_STACK_SUCCESS"))
    audioPostEvent_SystemUi(5, 99)
    _AudioPostEvent_SystemUiForXBOX(5, 99)
    audioPostEvent_SystemUi(5, 22)
    _AudioPostEvent_SystemUiForXBOX(5, 22)
    ToClient_BlackspiritEnchantSuccess()
  else
    PaGlobal_SpiritEnchant_All:showEnchantResultNakMessage(false, PAGetString(Defines.StringSheet_GAME, "LUA_EATENCHANT_STACK_FAIL"))
    audioPostEvent_SystemUi(5, 99)
    _AudioPostEvent_SystemUiForXBOX(5, 99)
    audioPostEvent_SystemUi(0, 7)
    _AudioPostEvent_SystemUiForXBOX(0, 7)
    audioPostEvent_SystemUi(5, 23)
    _AudioPostEvent_SystemUiForXBOX(5, 23)
    ToClient_BlackspiritEnchantCancel()
  end
end
function FromClient_SpiritEnchant_All_EnchantResultShow(resultType, mainWhereType, mainSlotNo, subWhereType, subSlotNo)
  PaGlobal_SpiritEnchant_All:enchantResult(resultType, mainWhereType, mainSlotNo, subWhereType, subSlotNo)
  PaGlobal_TutorialManager:handleEnchantResultShow(resultType, mainWhereType, mainSlotNo, subWhereType, subSlotNo)
  PaGlobal_SpiritEnchant_All._isStart = false
end
function FromClient_SpiritEnchant_All_CaphrasUpgradeItem(mainWhereType, mainSlotNo, variedCount)
  PaGlobal_SpiritEnchant_All:didCaphrasEnchant(mainWhereType, mainSlotNo, variedCount)
  PaGlobal_SpiritEnchant_All._isStart = false
  PaGlobal_SpiritEnchant_All._isAnimating = false
end
function FromClient_SpiritEnchant_All_CaphrasPromotionItem(mainWhereType, mainSlotNo)
  PaGlobal_SpiritEnchant_All:didCaphrasPromotion(mainWhereType, mainSlotNo)
  PaGlobal_SpiritEnchant_All:checkCaphrasMaterialItem()
  PaGlobal_SpiritEnchant_All._isStart = false
  PaGlobal_SpiritEnchant_All._isAnimating = false
  if true == _ContentsGroup_NewUI_Inventory_All then
    FromClient_Inventory_All_UpdateSlotDataByAddItem()
  else
    Inventory_updateSlotDatabyAddItem()
  end
end
function FromClient_SpiritEnchant_All_FailCountUpdate()
  PaGlobal_SpiritEnchant_All:darkPredationResult()
  PaGlobal_SpiritEnchant_All:darkExtractionTabOpen()
end
function FromClient_SpiritEnchant_All_ConvertEnchantFailCountToItemAck()
  audioPostEvent_SystemUi(5, 61)
  _AudioPostEvent_SystemUiForXBOX(5, 61)
  PaGlobal_SpiritEnchant_All:showEnchantResultNakMessage(true, PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANTCOUNTEXTRACTION_5"))
  if PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.NORMAL or PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
    PaGlobal_SpiritEnchant_All:setEnchantFailCount()
    PaGlobal_SpiritEnchant_All:showEnchantDifficulty()
  elseif PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.BOOK then
    PaGlobal_SpiritEnchant_All:bookExtractionTabOpen()
  end
end
function FromClient_SpiritEnchant_All_ConvertEnchantFailItemToCountAck()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANTCOUNTEXTRACTION_6"))
  if false == Panel_Window_StackExtraction_All:GetShow() then
    return
  end
  if PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.NORMAL or PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
    PaGlobal_SpiritEnchant_All:setEnchantFailCount()
    PaGlobal_SpiritEnchant_All:showEnchantDifficulty()
  elseif PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.BOOK then
    PaGlobal_SpiritEnchant_All:bookExtractionTabOpen()
  end
end
function FromClient_SpiritEnchant_All_ConvertEnchantFailItemToCount(fromWhereType, fromSlotNo)
  local function doItemUse()
    ToClient_ConvertEnchantFailItemToCount(fromWhereType, fromSlotNo)
  end
  local failCount = getSelfPlayer():get():getEnchantFailCount()
  local itemWrapper = getInventoryItemByType(fromWhereType, fromSlotNo)
  if 0 < failCount then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_VALKS_NOUSE")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANTCOUNTEXTRACTION_4"),
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    local messageBoxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ENCHANTCOUNTEXTRACTION_3", "failCount", failCount, "itemName", itemWrapper:getStaticStatus():getName())
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANTCOUNTEXTRACTION_4"),
      content = messageBoxMemo,
      functionYes = doItemUse,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function FromClient_SpiritEnchant_All_ConvertEnchantFailCountToItem(fromWhereType, fromSlotNo)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_SUMMON_BLACKSPIRIT"))
    return
  end
  local failCount = getSelfPlayer():get():getEnchantFailCount()
  if nil == failCount or failCount <= 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CANNOT_ENCHANT_EXTRACTION"))
    return
  end
  PaGlobal_SpiritEnchant_All:bookExtractionTabOpen()
end
function PaGlobalFunc_SpiritEnchant_All_ClearEnchantSlot()
  PaGlobal_SpiritEnchant_All:clearEnchantSlot()
end
function PaGlobalFunc_SpiritEnchant_All_IsDarkPredation()
  if PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.EXTRACTION and PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.DARK then
    return true
  end
  return false
end
function PaGlobalFunc_SpiritEnchant_All_GetTargetItem()
  return PaGlobal_SpiritEnchant_All._slotEquip
end
function PaGlobalFunc_SpiritEnchant_All_UpdateFuncNakAnimation(deltaTime)
  if false == PaGlobal_SpiritEnchant_All._isNakAnimating then
    return
  end
  PaGlobal_SpiritEnchant_All._nakAniTimeStamp = PaGlobal_SpiritEnchant_All._nakAniTimeStamp + deltaTime
  if PaGlobal_SpiritEnchant_All._nakElapsedTime <= PaGlobal_SpiritEnchant_All._nakAniTimeStamp then
    PaGlobal_SpiritEnchant_All._isNakAnimating = false
    PaGlobal_SpiritEnchant_All:stopEnchantResultNakMessage()
    if PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
      PaGlobal_SpiritEnchant_All:setCheckEnchantInfo(false, true)
    end
  end
  if nil == PaGlobal_SpiritEnchant_All._grantItemWhereType and nil == PaGlobal_SpiritEnchant_All._grantItemSlotNo then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_SpiritEnchant_All._grantItemWhereType, PaGlobal_SpiritEnchant_All._grantItemSlotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return
  end
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  if PaGlobal_SpiritEnchant_All._isConsole or CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() or 17 <= enchantLevel then
    if PaGlobal_SpiritEnchant_All._nakAniTimeStamp > 0.7 and false == PaGlobal_SpiritEnchant_All._isAnimating then
      if nil ~= PaGlobal_SpiritEnchant_All._materialItemWhereType and nil ~= PaGlobal_SpiritEnchant_All._materialItemSlotNo then
        PaGlobal_SpiritEnchant_All._isAbleEnchant = true
      else
        PaGlobal_SpiritEnchant_All._isAbleEnchant = false
      end
    else
      PaGlobal_SpiritEnchant_All._isAbleEnchant = false
    end
  end
end
function PaGlobalFunc_SpiritEnchant_All_UpdateFuncCheckAni(deltaTime)
  PaGlobalFunc_SpiritEnchant_All_UpdateFuncNakAnimation(deltaTime)
  PaGlobal_StackExtraction_All_UpdatePerFrame(deltaTime)
  if false == PaGlobal_SpiritEnchant_All._isAnimating or nil == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  local isEnchant = function()
    if PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT then
      return true
    end
    return false
  end
  local isCaphrasEnchant = function()
    if PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.CARPHRAS then
      return true
    end
    return false
  end
  local isDarkPredation = function()
    if PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.EXTRACTION and PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.DARK then
      return true
    end
    return false
  end
  local isBookExtraction = function()
    if PaGlobal_SpiritEnchant_All._currentMainTab == PaGlobal_SpiritEnchant_All._MAIN_TAB.EXTRACTION and PaGlobal_SpiritEnchant_All._currentSubTab == PaGlobal_SpiritEnchant_All._SUB_TAB.BOOK then
      return true
    end
    return false
  end
  PaGlobal_SpiritEnchant_All._animationTimeStamp = PaGlobal_SpiritEnchant_All._animationTimeStamp + deltaTime
  if PaGlobal_SpiritEnchant_All._startTime <= PaGlobal_SpiritEnchant_All._animationTimeStamp and false == PaGlobal_SpiritEnchant_All._isStart then
    if true == isEnchant() then
      PaGlobal_SpiritEnchant_All:startEnchant()
    elseif true == isCaphrasEnchant() then
      if true == PaGlobal_SpiritEnchant_All._isPossiblePromotion then
        PaGlobal_SpiritEnchant_All:startPromotionEnchant()
      else
        PaGlobal_SpiritEnchant_All:startCaphrasEnchant()
      end
    elseif true == isDarkPredation() then
      PaGlobal_SpiritEnchant_All:startdarkPredationItem()
    elseif true == isBookExtraction() then
      PaGlobal_SpiritEnchant_All:startBookExtraction()
    end
    PaGlobal_SpiritEnchant_All._isStart = true
  elseif PaGlobal_SpiritEnchant_All._effectTime <= PaGlobal_SpiritEnchant_All._animationTimeStamp then
    PaGlobal_SpiritEnchant_All._isAnimating = false
    if true == isDarkPredation() then
      PaGlobal_SpiritEnchant_All:setAsDarkPredationButton()
      PaGlobal_SpiritEnchant_All:clearDarkSlot()
      PaGlobal_SpiritEnchant_All._isStart = false
    elseif true == isCaphrasEnchant() then
      PaGlobal_SpiritEnchant_All._isStart = false
    elseif true == isBookExtraction() then
      PaGlobal_SpiritEnchant_All:setAsBookExtractionButton()
      PaGlobal_SpiritEnchant_All:clearBookSlot()
      PaGlobal_SpiritEnchant_All._isStart = false
    end
    if true == _ContentsGroup_NewUI_Dialog_All and nil ~= Panel_Npc_Dialog_All then
      Panel_Npc_Dialog_All:SetIgnoreChild(false)
    elseif nil ~= Panel_Npc_Dialog then
      Panel_Npc_Dialog:SetIgnoreChild(false)
    end
    PaGlobal_SpiritEnchant_All._ui_extraction.btn_subRadio[1]:SetIgnore(false)
    PaGlobal_SpiritEnchant_All._ui_extraction.btn_subRadio[2]:SetIgnore(false)
    for i = 1, #PaGlobal_SpiritEnchant_All._ui.btn_mainRadio do
      PaGlobal_SpiritEnchant_All._ui.btn_mainRadio[i]:SetIgnore(false)
    end
  else
    PaGlobal_SpiritEnchant_All._ui_enchant.radio_enchantNormal:SetIgnore(true)
    PaGlobal_SpiritEnchant_All._ui_enchant.radio_enchantPerfect:SetIgnore(true)
    PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantForce:SetIgnore(true)
    PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantCron:SetIgnore(true)
    PaGlobal_SpiritEnchant_All._ui_enchant.chk_skipAni:SetIgnore(true)
    PaGlobal_SpiritEnchant_All._ui_extraction.chk_skipAni:SetIgnore(true)
  end
end
function PaGlobal_StackExtraction_All_UpdatePerFrame(deltaTime)
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if false == Panel_Window_StackExtraction_All:GetShow() then
    return
  end
  PaGlobal_SpiritEnchant_All._familyStackDeltaTime = PaGlobal_SpiritEnchant_All._familyStackDeltaTime + deltaTime
  if PaGlobal_SpiritEnchant_All._familyStackDeltaTime < 1 then
    return
  end
  PaGlobal_SpiritEnchant_All._familyStackDeltaTime = 0
  local coolTime = ToClient_GetRemainSwapEnchantStackSlotCoolTime()
  if coolTime <= toInt64(0, 0) then
    PaGlobal_SpiritEnchant_All._ui_enchant.txt_stackCoolTime:SetShow(false)
    return
  end
  local expirationTimeString = convertStringFromDatetimeType2(coolTime)
  PaGlobal_SpiritEnchant_All._ui_enchant.txt_stackCoolTime:SetShow(true)
  PaGlobal_SpiritEnchant_All._ui_enchant.txt_stackCoolTime:SetText(expirationTimeString)
end
function PaGlobalFunc_SpiritEnchant_All_GetItemWrapper()
  if nil == PaGlobal_SpiritEnchant_All._grantItemWhereType or nil == PaGlobal_SpiritEnchant_All._grantItemSlotNo then
    return nil
  end
  return (getInventoryItemByType(PaGlobal_SpiritEnchant_All._grantItemWhereType, PaGlobal_SpiritEnchant_All._grantItemSlotNo))
end
function PaGlobalFunc_SpiritEnchant_All_SetItemEnchantTarget(slotNo, itemWrapper, inventoryType, resultType, isMonotone)
  PaGlobal_SpiritEnchant_All:setEnchantTarget(slotNo, itemWrapper, inventoryType, resultType, isMonotone)
end
function PaGlobalFunc_SpiritEnchant_All_SetMaterialItem(slotNo, itemWrapper, inventoryType)
  PaGlobal_SpiritEnchant_All:setMaterialItem(slotNo, itemWrapper, inventoryType)
end
function PaGlobalFunc_SpiritEnchant_All_SetItemCaphrasTarget(slotNo, itemWrapper, inventoryType)
  PaGlobal_SpiritEnchant_All:setCaphrasTarget(slotNo, itemWrapper, inventoryType, true, false)
end
function PaGlobalFunc_SpiritEnchant_All_SetItemDarkPredation(slotNo, itemWrapper, inventoryType)
  PaGlobal_SpiritEnchant_All:setDarkPredationItem(slotNo, itemWrapper, inventoryType)
end
function PaGlboalFunc_SpiritEnchant_All_SetItemBookExtraction(slotNo, itemWrapper, inventoryType)
  PaGlobal_SpiritEnchant_All:setBookExtractionItem(slotNo, itemWrapper, inventoryType)
end
function PaGlobalFunc_SpiritEnchant_All_CloseForEnchant()
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  PaGlobalFunc_SpiritEnchant_All_Close()
end
function PaGlobalFunc_SpiritEnchant_All_FilterForEnchantTarget(slotNo, notUse_itemWrappers, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  if true == itemWrapper:checkToValksItem() then
    return false
  end
  if true == ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    return true
  end
  return false == itemWrapper:checkToEnchantItem(false)
end
function PaGlobalFunc_SpiritEnchant_All_FilterForCaphrasEquipItem(slotNo, notUse_itemWrappers, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  if true == itemWrapper:checkToValksItem() then
    return false
  end
  if ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    return true
  end
  return false == itemWrapper:checkToUpgradeItem() and false == itemWrapper:isPossibleCronPromotion()
end
function PaGlobalFunc_SpiritEnchant_All_FilterForDarkPredationItem(slotNo, notUse_itemWrappers, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  local returnValue = true
  if true == ToClient_Inventory_AvailFeedItem(whereType, slotNo) then
    returnValue = false
  else
    returnValue = true
  end
  return returnValue
end
function PaGlobalFunc_SpiritEnchant_All_FilterForBookExtraction(slotNo, notUse_itemWrappers, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local failCount = getSelfPlayer():get():getEnchantFailCount()
  if CppEnums.ContentsEventType.ContentsType_ConvertEnchantFailCountToItem == itemSSW:get():getContentsEventType() then
    local maxEnchantParam = itemSSW:getContentsEventParam1()
    return failCount > maxEnchantParam
  else
    return true
  end
end
function PaGlobalFunc_SpiritEnchant_All_RClickForEnchantTargetItem(slotNo, itemWrapper, count, inventoryType)
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  if itemWrapper:checkToValksItem() then
    if true == _ContentsGroup_NewUI_Inventory_All then
      PaGlobalFunc_Inventory_All_UseItemTargetSelf(inventoryType, slotNo, 0)
    else
      Inventory_UseItemTargetSelf(inventoryType, slotNo, 0)
    end
    return
  end
  if PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT == PaGlobal_SpiritEnchant_All._currentMainTab then
    PaGlobalFunc_SpiritEnchant_All_SetItemEnchantTarget(slotNo, itemWrapper, inventoryType, nil, true)
  elseif PaGlobal_SpiritEnchant_All._MAIN_TAB.CARPHRAS == PaGlobal_SpiritEnchant_All._currentMainTab then
    PaGlobalFunc_SpiritEnchant_All_SetItemCaphrasTarget(slotNo, itemWrapper, inventoryType)
  elseif PaGlobal_SpiritEnchant_All._SUB_TAB.DARK == PaGlobal_SpiritEnchant_All._currentSubTab then
    PaGlobalFunc_SpiritEnchant_All_SetItemDarkPredation(slotNo, itemWrapper, inventoryType)
  else
    PaGlboalFunc_SpiritEnchant_All_SetItemBookExtraction(slotNo, itemWrapper, inventoryType)
  end
end
function PaGlobalFunc_SpiritEnchant_All_FilterForEnchantMaterial(slotNo, notUse_itemWrappers, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  if itemWrapper:checkToValksItem() then
    return false
  end
  if CppEnums.ItemWhereType.eCashInventory == whereType then
    return true
  end
  local returnValue = true
  if slotNo == getEnchantInformation():ToClient_getNeedNewPerfectItemSlotNo() then
    returnValue = false
  elseif slotNo ~= getEnchantInformation():ToClient_getNeedItemSlotNo() then
    returnValue = true
  else
    returnValue = false
    if PaGlobal_SpiritEnchant_All._slotEquip.slot.slotNo == slotNo and CppEnums.ItemWhereType.eInventory ~= whereType then
      returnValue = true
    end
  end
  if true == ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    returnValue = true
  end
  return returnValue
end
function PaGlobalFunc_SpiritEnchant_All_RClickForEnchantMaterial(slotNo, itemWrapper, Count, inventoryType)
  if true == PaGlobal_SpiritEnchant_All._isAnimating then
    return
  end
  if nil == slotNo or nil == inventoryType or nil == itemWrapper then
    return
  end
  if itemWrapper:checkToValksItem() then
    if true == _ContentsGroup_NewUI_Inventory_All then
      PaGlobalFunc_Inventory_All_UseItemTargetSelf(inventoryType, slotNo, 0, true)
    else
      Inventory_UseItemTargetSelf(inventoryType, slotNo, 0, true)
    end
    return
  end
  if PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT ~= PaGlobal_SpiritEnchant_All._currentMainTab then
    return
  end
  PaGlobal_SpiritEnchant_All:clearEnchantCheckBox()
  PaGlobalFunc_SpiritEnchant_All_SetMaterialItem(slotNo, itemWrapper, inventoryType)
end
function PaGlobalFunc_SpiritEnchant_All_GetIsAnimating()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  return PaGlobal_SpiritEnchant_All._isAnimating
end
function FromClient_SpiritEnchant_All_FamilyStack_Update()
  FromClient_SpiritEnchant_All_UpdateEnchantFailCount()
end
function PaGlobalFunc_SpiritEnchant_All_StackChangeEffect()
  PaGlobal_SpiritEnchant_All._ui_enchant.stc_stackChangeEffect:EraseAllEffect()
  PaGlobal_SpiritEnchant_All._ui_enchant.stc_stackChangeEffect:AddEffect("fUI_StackChange_Change_01A", false, 0, 0)
end
function PaGlobalFunc_SpiritEnchant_All_ShowRstickKeyGuide(isShow)
  PaGlobal_SpiritEnchant_All._ui_console.stc_rstick:SetShow(isShow)
  PaGlobal_SpiritEnchant_All._ui_console.stc_keyguideBg:ComputePos()
  local tempBtnGroup = {
    PaGlobal_SpiritEnchant_All._ui_console.stc_rstick,
    PaGlobal_SpiritEnchant_All._ui_console.stc_select,
    PaGlobal_SpiritEnchant_All._ui_console.stc_detail,
    PaGlobal_SpiritEnchant_All._ui_console.stc_cancle
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, PaGlobal_SpiritEnchant_All._ui_console.stc_keyguideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
