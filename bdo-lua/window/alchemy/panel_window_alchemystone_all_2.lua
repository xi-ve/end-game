function PaGlobalFunc_AlchemyStone_All_Open()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  PaGlobal_AlchemyStone_All:prepareOpen()
end
function PaGlobalFunc_AlchemyStone_All_Close()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  PaGlobal_AlchemyStone_All:prepareClose()
end
function HandleEventRUp_AlchemyStone_UnSetSlot(slotType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  if true == PaGlobal_AlchemyStone_All._isPushDoit then
    return
  end
  if PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE == PaGlobal_AlchemyStone_All._selectedTabIdx then
    PaGlobal_AlchemyStone_All:chargeTab_UnSetSlot(slotType)
  elseif PaGlobal_AlchemyStone_All._TAB_TYPE.EXP == PaGlobal_AlchemyStone_All._selectedTabIdx then
    PaGlobal_AlchemyStone_All:expTab_UnSetSlot(slotType)
  elseif PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE == PaGlobal_AlchemyStone_All._selectedTabIdx then
    PaGlobal_AlchemyStone_All:upgradeTab_UnSetSlot(slotType)
  elseif PaGlobal_AlchemyStone_All._TAB_TYPE.RANDOMOPTION == PaGlobal_AlchemyStone_All._selectedTabIdx then
    PaGlobal_AlchemyStone_All:randomOption_UnSetSlot(slotType)
  end
  PaGlobal_AlchemyStone_All._ui_pc.btn_apply:SetMonoTone(true)
  PaGlobal_AlchemyStone_All._ui_pc.btn_apply:SetEnable(false)
  PaGlobal_AlchemyStone_All._resultItemKey = {}
  PaGlobal_AlchemyStone_All._resultItemIndex = -1
  if nil ~= Panel_Tooltip_Item_hideTooltip then
    Panel_Tooltip_Item_hideTooltip()
  end
end
function HandleEventLUp_AlchemyStone_RandomSelect(selectType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  if true == PaGlobal_AlchemyStone_All._isPushDoit then
    return
  end
  PaGlobal_AlchemyStone_All:randomOption_Select(selectType)
end
function HandleEventOnOut_AlchemyStone_RandomOptionStatTooltip(isMosueUp, selectType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  PaGlobal_AlchemyStone_All:randomOption_StatTooltip(isMosueUp, selectType)
end
function HandleEventLUp_AlchemyStone_All_SelectTab(tabType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  PaGlobal_AlchemyStone_All:selectTab(tabType)
end
function HandleEventLUp_AlchemyStone_Doit()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  local doUpgrade = function()
    PaGlobal_AlchemyStone_All._isPushDoit = true
    Inventory_SetFunctor(PaGlobal_AlchemyStone_All_MaterialFilterAllNot, nil, nil, nil)
  end
  local tabType = PaGlobal_AlchemyStone_All._selectedTabIdx
  local itemWrapper = getInventoryItemByType(PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local itemGrade = itemSSW:getGradeType()
  local itemContentsParam2 = itemSSW:get()._contentsEventParam2
  local msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSGBOX_TITLE")
  local msgContent = ""
  if PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE == tabType then
    if PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty then
      return
    end
    if itemContentsParam2 + 1 <= Int64toInt32(PaGlobal_AlchemyStone_All._fromCount) then
      PaGlobal_AlchemyStone_All._isPushDoit = true
      Inventory_SetFunctor(PaGlobal_AlchemyStone_All_MaterialFilterAllNot, nil, nil, nil)
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_WARN_2"))
    end
  elseif PaGlobal_AlchemyStone_All._TAB_TYPE.EXP == tabType then
    if PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty then
      return
    end
    local alchemystoneExp = itemWrapper:getExperience() * 1.0E-4
    if 150 <= alchemystoneExp then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_EXPMAX_WARRING"))
      return
    end
    PaGlobal_AlchemyStone_All._isPushDoit = true
    Inventory_SetFunctor(PaGlobal_AlchemyStone_All_MaterialFilterAllNot, nil, nil, nil)
  elseif PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE == tabType then
    if PaGlobal_AlchemyStone_All._growthSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty then
      return
    end
    if 0 ~= checkToEvolveAlchemyStone() then
      return
    end
    if 3 == itemContentsParam2 or 4 == itemContentsParam2 then
      msgContent = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSGBOX_CONTENT1")
    elseif 5 == itemContentsParam2 or 6 == itemContentsParam2 then
      msgContent = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSGBOX_CONTENT2")
    elseif 7 == itemContentsParam2 then
      if itemGrade < 3 then
        msgContent = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSGBOX_CONTENT2")
      end
    else
      PaGlobal_AlchemyStone_All._isPushDoit = true
      Inventory_SetFunctor(PaGlobal_AlchemyStone_All_MaterialFilterAllNot, nil, nil, nil)
    end
    if "" ~= msgContent then
      local messageBoxData = {
        title = msgTitle,
        content = msgContent,
        functionYes = doUpgrade,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData, "middle")
    end
  elseif PaGlobal_AlchemyStone_All._TAB_TYPE.RANDOMOPTION == tabType then
    PaGlobal_AlchemyStone_All._isPushDoit = true
    Inventory_SetFunctor(PaGlobal_AlchemyStone_All_MaterialFilterAllNot, nil, nil, nil)
    PaGlobal_AlchemyStone_All._ui._random.stc_randomRadioGroup:SetMonoTone(true)
    PaGlobal_AlchemyStone_All._ui._random.radio_randomOptionSelect_1:SetEnable(false)
    PaGlobal_AlchemyStone_All._ui._random.radio_randomOptionSelect_2:SetEnable(false)
    PaGlobal_AlchemyStone_All._ui._random.radio_randomOptionSelect_3:SetEnable(false)
  end
  PaGlobal_AlchemyStone_All._ui.stc_CenterEffect:SetShow(true)
  PaGlobal_AlchemyStone_All._ui_pc.btn_apply:SetMonoTone(PaGlobal_AlchemyStone_All._isPushDoit)
  PaGlobal_AlchemyStone_All._ui_pc.btn_apply:SetEnable(true ~= PaGlobal_AlchemyStone_All._isPushDoit)
  audioPostEvent_SystemUi(1, 43)
  _AudioPostEvent_SystemUiForXBOX(1, 43)
end
function HandleEventOnOut_AlchemyStone_ResultItemTooltip(isShow, index)
  if nil == Panel_Window_AlchemyStone_All or true == _ContentsGroup_RenewUI_Tooltip then
    return
  end
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
  if nil ~= itemWrapper then
    local itemSSW = itemWrapper:getStaticStatus()
    local resultItemWrapper = getAlchemyEvolveItemStaticStatusWrapper(itemSSW:get()._key:getItemKey(), index)
    Panel_Tooltip_Item_Show(resultItemWrapper, PaGlobal_AlchemyStone_All._resultSlot[index].icon, true, false, nil, nil, nil)
  end
end
function HandlePadEventXUp_AlchemyStone_ResultItemTooltip(index)
  if nil == Panel_Window_AlchemyStone_All or false == _ContentsGroup_RenewUI_Tooltip then
    return
  end
  if nil ~= PaGlobalFunc_TooltipInfo_GetShow and true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
  if nil ~= itemWrapper then
    local itemSSW = itemWrapper:getStaticStatus()
    local resultItemWrapper = getAlchemyEvolveItemStaticStatusWrapper(itemSSW:get()._key:getItemKey(), index)
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, resultItemWrapper, Defines.TooltipTargetType.ItemWithoutCompare)
  end
end
function HandleEventOnOut_AlchemyStone_ItemToolTip(isShow, slotType)
  if nil == Panel_Window_AlchemyStone_All or true == _ContentsGroup_RenewUI_Tooltip then
    return
  end
  if true == isShow then
    local control, itemWrapper
    if slotType == PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE then
      control = PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE].icon
      if -1 ~= PaGlobal_AlchemyStone_All._toWhereType then
        itemWrapper = getInventoryItemByType(PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
        Panel_Tooltip_Item_Show(itemWrapper, control, false, true, nil, nil, nil)
      else
        return
      end
    else
      if PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE == PaGlobal_AlchemyStone_All._selectedTabIdx then
        if PaGlobal_AlchemyStone_All._growthSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty then
          return
        end
        control = PaGlobal_AlchemyStone_All._growthSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].icon
      elseif PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE == PaGlobal_AlchemyStone_All._selectedTabIdx or PaGlobal_AlchemyStone_All._TAB_TYPE.EXP == PaGlobal_AlchemyStone_All._selectedTabIdx then
        if PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty then
          return
        end
        control = PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].icon
      elseif PaGlobal_AlchemyStone_All._TAB_TYPE.RANDOMOPTION == PaGlobal_AlchemyStone_All._selectedTabIdx then
        if PaGlobal_AlchemyStone_All._randomSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty then
          return
        end
        control = PaGlobal_AlchemyStone_All._randomSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].icon
      end
      if -1 ~= PaGlobal_AlchemyStone_All._fromWhereType then
        itemWrapper = getInventoryItemByType(PaGlobal_AlchemyStone_All._fromWhereType, PaGlobal_AlchemyStone_All._fromSlotNo)
        Panel_Tooltip_Item_Show(itemWrapper, control, false, true, nil, nil, nil)
      else
        return
      end
    end
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function HandlePadEventXUp_AlchemyStone_ItemToolTip(slotType)
  if nil == Panel_Window_AlchemyStone_All or false == _ContentsGroup_RenewUI_Tooltip then
    return
  end
  if nil ~= PaGlobalFunc_TooltipInfo_GetShow and false == PaGlobalFunc_TooltipInfo_GetShow() then
    local control, itemWrapper
    if slotType == PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE then
      control = PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE].icon
      if -1 ~= PaGlobal_AlchemyStone_All._toWhereType then
        itemWrapper = getInventoryItemByType(PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
        PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare)
      else
        return
      end
    elseif slotType == PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT then
      if PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty then
        return
      end
      control = PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].icon
      if -1 ~= PaGlobal_AlchemyStone_All._fromWhereType then
        itemWrapper = getInventoryItemByType(PaGlobal_AlchemyStone_All._fromWhereType, PaGlobal_AlchemyStone_All._fromSlotNo)
        PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare)
      else
        return
      end
    elseif slotType == PaGlobal_AlchemyStone_All._SLOT_TYPE.BLACKSTONE then
      local itemWrapper
      itemWrapper = getInventoryItemByType(PaGlobal_AlchemyStone_All._fromWhereType, PaGlobal_AlchemyStone_All._blackStonSlotNo)
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare)
    end
  else
    PaGlobalFunc_TooltipInfo_Close()
  end
end
function HandleEventOnOut_AlchemyStone_CheckSlotType(isOn, slotType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  if true == isOn then
    PaGlobal_AlchemyStone_All._currentSlotType = slotType
  end
end
function HandlePadEventLBUp_MoveTab(direction)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  PaGlobal_AlchemyStone_All:Console_MoveTab(direction)
end
function HandlePadEventAUp_OpenInventory()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  PaGlobal_AlchemyStone_All:console_OpenInventory()
end
function FromClient_ItemUpgrade_All(itemwhereType, slotNo, exp)
  if nil == Panel_Window_AlchemyStone_All or not Panel_Window_AlchemyStone_All:GetShow() then
    return
  end
  if PaGlobal_AlchemyStone_All._TAB_TYPE.EXP ~= PaGlobal_AlchemyStone_All._selectedTabIdx then
    return
  end
  local itemWrapper = getInventoryItemByType(itemwhereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local tabType = PaGlobal_AlchemyStone_All._selectedTabIdx
  local itemName = itemWrapper:getStaticStatus():getName()
  local mainMsg = itemName .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DONE_EXP")
  PaGlobal_AlchemyStone_All._resultMsg = {
    main = mainMsg,
    sub = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_EXP") .. string.format("%.2f", itemWrapper:getExperience() / 10000) .. "%",
    addMsg = "Icon/" .. itemWrapper:getStaticStatus():getIconPath()
  }
  Proc_ShowMessage_Ack_For_RewardSelect(PaGlobal_AlchemyStone_All._resultMsg, 2.5, 33)
  PaGlobal_AlchemyStone_All._ui._recharge.progress_curExp:SetProgressRate(itemWrapper:getExperience() / 10000)
  local _exp = string.format("%.2f", itemWrapper:getExperience() / 10000)
  PaGlobal_AlchemyStone_All._ui._recharge.txt_expValue:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_EXPERIENCE", "exp", _exp))
  Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterMat, PaGlobalFunc_AlchemyStone_All_InvenMatRClick, nil, nil)
end
function FromClient_AlchemyRepair_All(whereType, slotNo)
  if nil == Panel_Window_AlchemyStone_All or not Panel_Window_AlchemyStone_All:GetShow() then
    return
  end
  local itemWrapper = getInventoryItemByType(whereType, Int64toInt32(slotNo))
  if nil ~= itemWrapper then
    local itemSSW = itemWrapper:getStaticStatus()
    local itemName = itemSSW:getName()
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_CHARGE_COMPLETE_ACK", "itemName", itemName))
    PaGlobal_AlchemyStone_All:clearData(true)
    Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterMat, PaGlobalFunc_AlchemyStone_All_InvenMatRClick, nil, nil)
    PaGlobal_AlchemyStone_All:UpdateStone(whereType, slotNo)
  end
end
function FromClient_StoneChange_All(whereType, slotNo)
  if nil == Panel_Window_AlchemyStone_All or not Panel_Window_AlchemyStone_All:GetShow() then
    return
  end
  if -1 == PaGlobal_AlchemyStone_All._selectedTabIdx then
    return
  end
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local itemName = itemSSW:getName()
  local itemKey = itemSSW:get()._key:getItemKey()
  msg = {
    main = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_DONE"),
    sub = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_DONE2", "itemName", itemName),
    addMsg = "Icon/" .. itemWrapper:getStaticStatus():getIconPath()
  }
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 2.5, 33)
  for index = 0, #PaGlobal_AlchemyStone_All._resultItemKey do
    if itemKey == PaGlobal_AlchemyStone_All._resultItemKey[index] then
      PaGlobal_AlchemyStone_All._resultItemIndex = index
    end
  end
  Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterStone, PaGlobalFunc_AlchemyStone_All_InvenStoneRClick, nil, nil)
end
function FromClient_StoneChangeFailedByDown_All(whereType, slotNo)
  if nil == Panel_Window_AlchemyStone_All or not Panel_Window_AlchemyStone_All:GetShow() then
    return
  end
  if -1 == PaGlobal_AlchemyStone_All._selectedTabIdx then
    return
  end
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemName = itemWrapper:getStaticStatus():getName()
  msg = {
    main = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_FAIL"),
    sub = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_FAIL2", "itemName", itemName),
    addMsg = "Icon/" .. itemWrapper:getStaticStatus():getIconPath()
  }
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 2.5, 33)
  Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterStone, PaGlobalFunc_AlchemyStone_All_InvenStoneRClick, nil, nil)
end
function FromClient_AlchemyEvolve_All(evolveType)
  if nil == Panel_Window_AlchemyStone_All or not Panel_Window_AlchemyStone_All:GetShow() then
    return
  end
  if -1 == PaGlobal_AlchemyStone_All._selectedTabIdx then
    return
  end
  local guideString = ""
  local resultString = ""
  if 0 == evolveType then
    guideString = "<PAColor0xffd05d48>" .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_UPGRADERESULT_0")
    resultString = "<PAColor0xffd05d48>" .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_EXPDOWN")
  elseif 1 == evolveType then
    guideString = "<PAColor0xffd05d48>" .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_UPGRADERESULT_1")
    resultString = "<PAColor0xffd05d48>" .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_STONEDESTROY")
  elseif 2 == evolveType then
    guideString = "<PAColor0xffd05d48>" .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_UPGRADERESULT_2")
    resultString = "<PAColor0xffd05d48>" .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_GRADEDOWN")
  elseif 3 == evolveType then
    guideString = "<PAColor0xffd8ad70>" .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_UPGRADERESULT_3")
    resultString = "<PAColor0xfff5ba3a>" .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_DONE")
  end
  guideString = guideString .. "<PAOldColor>"
  resultString = resultString .. "<PAOldColor>"
  PaGlobal_AlchemyStone_All._ui.txt_guideNormal:SetText(guideString)
  if evolveType < 3 then
    PaGlobal_AlchemyStone_All._ui._growth.txt_fail:SetText(resultString)
    PaGlobal_AlchemyStone_All._ui._growth.txt_fail:SetShow(true)
    PaGlobal_AlchemyStone_All._ui._growth.txt_fail:EraseAllEffect()
    PaGlobal_AlchemyStone_All._ui._growth.txt_fail:AddEffect("fUI_Alchemy_Development_Text_Fail_01A", false)
    audioPostEvent_SystemUi(5, 23)
    _AudioPostEvent_SystemUiForXBOX(5, 23)
  else
    PaGlobal_AlchemyStone_All._ui._growth.txt_success:SetText(resultString)
    PaGlobal_AlchemyStone_All._ui._growth.txt_success:SetShow(true)
    PaGlobal_AlchemyStone_All._ui._growth.txt_success:EraseAllEffect()
    PaGlobal_AlchemyStone_All._ui._growth.txt_success:AddEffect("fUI_Alchemy_Development_Text_Success_01A", false)
    audioPostEvent_SystemUi(5, 22)
    _AudioPostEvent_SystemUiForXBOX(5, 22)
  end
  Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterStone, PaGlobalFunc_AlchemyStone_All_InvenStoneRClick, nil, nil)
end
function AlchemyStone_onScreenResize()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  PaGlobal_AlchemyStone_All:resize()
end
function FromClient_RandomOption(optionSize)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  if -1 == PaGlobal_AlchemyStone_All._selectedTabIdx then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
  if nil == itemWrapper then
    return
  end
  Panel_AlchemyStone_All_StartRandomOptionTextAnimation(optionSize)
  PaGlobal_AlchemyStone_All:clearData(true)
end
function FromClient_ResponseRandomOptionFail()
  PaGlobal_AlchemyStone_All:clearData(false)
  Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterMat, PaGlobalFunc_AlchemyStone_All_InvenMatRClick, nil, nil)
end
function PaGlobalFunc_AlchemyStone_All_PreCheckOtherUI()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  if true == _ContentsGroup_NewUI_AlchemyFigureHead_All then
    if nil ~= Panel_AlchemyFigureHead_All and true == Panel_AlchemyFigureHead_All:GetShow() then
      PaGlobal_AlchemyFigureHead_All_Close()
    end
  elseif nil ~= Panel_AlchemyFigureHead and true == Panel_AlchemyFigureHead:GetShow() then
    FGlobal_AlchemyFigureHead_Close()
  end
  if not _ContentsGroup_RenewUI_Manufacture then
    if false == _ContentsGroup_NewUI_Manufacture_All then
      if true == Panel_Manufacture:GetShow() then
        Manufacture_Close()
      end
    elseif true == Panel_Window_Manufacture_All:GetShow() then
      PaGlobalFunc_Manufacture_All_Close()
    end
  end
  if nil ~= Panel_DyePalette and true == Panel_DyePalette:GetShow() then
    FGlobal_DyePalette_Close()
  end
end
function PaGlobalFunc_AlchemyStone_All_SetInvenFilterStone(slotNo, itemWrapper, count, inventoryType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  local returnValue = true
  if nil == itemWrapper or nil == itemWrapper:getStaticStatus() then
    return returnValue
  end
  local isAlchemyBellHeart = function(alchemyStoneType, contentsEventParam2)
    if 6 == alchemyStoneType or 7 == alchemyStoneType then
      return true
    end
    return false
  end
  if 32 == itemWrapper:getStaticStatus():get():getContentsEventType() then
    local alchemyStoneType = itemWrapper:getStaticStatus():get()._contentsEventParam1
    local contentsEventParam2 = itemWrapper:getStaticStatus():get()._contentsEventParam2
    if PaGlobal_AlchemyStone_All._selectedTabIdx == PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE then
      if true == isAlchemyBellHeart(alchemyStoneType, contentsEventParam2) then
        return true
      end
      if 7 == contentsEventParam2 then
        returnValue = true
      else
        returnValue = false
      end
      local isItemLocked = ToClient_Inventory_CheckItemLock(slotNo, inventoryType)
      if isItemLocked then
        returnValue = true
      end
    elseif PaGlobal_AlchemyStone_All._selectedTabIdx == PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE then
      if itemWrapper:get():getEndurance() == itemWrapper:get():getMaxEndurance() then
        returnValue = true
      else
        returnValue = false
      end
    elseif PaGlobal_AlchemyStone_All._selectedTabIdx == PaGlobal_AlchemyStone_All._TAB_TYPE.EXP then
      if true == isAlchemyBellHeart(alchemyStoneType, contentsEventParam2) then
        return true
      end
      returnValue = false
    elseif PaGlobal_AlchemyStone_All._selectedTabIdx == PaGlobal_AlchemyStone_All._TAB_TYPE.RANDOMOPTION then
      if true == itemWrapper:isRandomOptionTarget() then
        return false
      end
      returnValue = true
    end
  end
  return returnValue
end
function PaGlobal_AlchemyStone_All_MaterialFilterAllNot(slotNo, itemWrapper, count, inventoryType)
  return true
end
function PaGlobalFunc_AlchemyStone_All_InvenStoneRClick(slotNo, itemWrapper, count, inventoryType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  PaGlobal_AlchemyStone_All:invenStoneRClick(slotNo, itemWrapper, count, inventoryType)
end
function PaGlobalFunc_AlchemyStone_All_SetInvenFilterMat(slotNo, itemWrapper, count, inventoryType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  local returnValue = true
  if nil == itemWrapper then
    return returnValue
  end
  local staticStatus = itemWrapper:getStaticStatus()
  local key = itemWrapper:get():getKey()
  if nil == staticStatus or -1 == PaGlobal_AlchemyStone_All._selectedTabIdx then
    return returnValue
  end
  if PaGlobal_AlchemyStone_All._selectedTabIdx == PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE then
    if staticStatus:isAlchemyRepair(PaGlobal_AlchemyStone_All._selectedStoneType) then
      returnValue = false
    end
  elseif PaGlobal_AlchemyStone_All._selectedTabIdx == PaGlobal_AlchemyStone_All._TAB_TYPE.EXP then
    if staticStatus:isAlchemyUpgradeItem(PaGlobal_AlchemyStone_All._selectedStoneType) then
      returnValue = false
    end
  elseif PaGlobal_AlchemyStone_All._selectedTabIdx == PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE then
    if staticStatus:isAlchemyUpgradeMaterial(PaGlobal_AlchemyStone_All._selectedStoneItemKey) then
      if true == PaGlobal_AlchemyStone_All._isConsole and nil ~= key then
        PaGlobal_AlchemyStone_All._blackStonSlotNo = ToClient_InventoryGetSlotNo(key)
      end
      returnValue = false
    end
  elseif PaGlobal_AlchemyStone_All._selectedTabIdx == PaGlobal_AlchemyStone_All._TAB_TYPE.RANDOMOPTION and true == itemWrapper:isRandomOptionMaterial(PaGlobal_AlchemyStone_All._selectedStoneItemKey, PaGlobal_AlchemyStone_All._randomSourceKey) then
    returnValue = false
  end
  return returnValue
end
function PaGlobalFunc_AlchemyStone_All_InvenMatRClick(slotNo, itemWrapper, count, inventoryType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  PaGlobal_AlchemyStone_All:invenMatRClick(slotNo, itemWrapper, count, inventoryType)
end
function PaGlobalFunc_AlchemyStone_All_Use()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  local itemWrapper = ToClient_getEquipmentItem(CppEnums.EquipSlotNo.alchemyStone)
  if nil ~= itemWrapper and 0 < itemWrapper:get():getEndurance() then
    useAlchemyStone()
  end
end
function Panel_AlchemyStone_All_UpdateTime(deltaTime)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  if PaGlobal_AlchemyStone_All._isPushDoit then
    PaGlobal_AlchemyStone_All._elapsTime = PaGlobal_AlchemyStone_All._elapsTime + deltaTime
    local tabType = PaGlobal_AlchemyStone_All._selectedTabIdx
    if PaGlobal_AlchemyStone_All._elapsTime > 0 and false == PaGlobal_AlchemyStone_All._startEffectPlay then
      PaGlobal_AlchemyStone_All._ui_pc.btn_apply:SetMonoTone(true)
      PaGlobal_AlchemyStone_All._ui_pc.btn_apply:SetEnable(false)
      if PaGlobal_AlchemyStone_All._TAB_TYPE.RANDOMOPTION == tabType then
        PaGlobal_AlchemyStone_All._randomSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].icon:EraseAllEffect()
        PaGlobal_AlchemyStone_All._randomSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].icon:AddEffect("fUI_Alchemy_Unite_L_Slot_01A", false, 3, 0)
        PaGlobal_AlchemyStone_All._randomSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE].icon:EraseAllEffect()
        PaGlobal_AlchemyStone_All._randomSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE].icon:AddEffect("fUI_Alchemy_Unite_R_Slot_01A", false)
      else
        PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE].icon:EraseAllEffect()
        PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE].icon:AddEffect("fUI_Alchemy_Grind_R_Slot_01A", false, 3, 0)
        if PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE == tabType then
          PaGlobal_AlchemyStone_All._resultSlotBg[0]:AddEffect("fUI_Alchemy_Development_R_Slot_01A", false)
          PaGlobal_AlchemyStone_All._resultSlotBg[1]:AddEffect("fUI_Alchemy_Development_R_Slot_01A", false)
          PaGlobal_AlchemyStone_All._resultSlotBg[2]:AddEffect("fUI_Alchemy_Development_R_Slot_01A", false)
        else
          if PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE == tabType then
            PaGlobal_AlchemyStone_All._ui._recharge.txt_needCount:SetShow(false)
          end
          PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].icon:EraseAllEffect()
          PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].icon:AddEffect("fUI_Alchemy_Grind_L_Slot_01A", false)
        end
      end
      PaGlobal_AlchemyStone_All._startEffectPlay = true
      if PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE == tabType or PaGlobal_AlchemyStone_All._TAB_TYPE.EXP == tabType then
        audioPostEvent_SystemUi(5, 80)
        _AudioPostEvent_SystemUiForXBOX(5, 80)
      elseif PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE == tabType then
        audioPostEvent_SystemUi(5, 81)
        _AudioPostEvent_SystemUiForXBOX(5, 81)
      elseif PaGlobal_AlchemyStone_All._TAB_TYPE.RANDOMOPTION == tabType then
        audioPostEvent_SystemUi(5, 82)
        _AudioPostEvent_SystemUiForXBOX(5, 82)
      end
      if PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE == tabType then
        PaGlobal_AlchemyStone_All._ui._growth.stc_upgradeEffect:AddEffect("fUI_Alchemy_Development_L_Slot_01A", false)
      end
    end
    if PaGlobal_AlchemyStone_All._elapsTime > 1 and false == PaGlobal_AlchemyStone_All._contentEffectPlay then
      if PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE ~= tabType then
        PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT]:clearItem()
        PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty = true
      end
      PaGlobal_AlchemyStone_All._ui.stc_CenterEffect:EraseAllEffect()
      local effectName = ""
      if PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE == tabType then
        effectName = "fUI_Alchemy_Development_01A"
      elseif PaGlobal_AlchemyStone_All._TAB_TYPE.RANDOMOPTION == tabType then
        effectName = "fUI_Alchemy_Unite_01A"
      else
        effectName = "fUI_Alchemy_grind_01A"
      end
      PaGlobal_AlchemyStone_All._ui.stc_CenterEffect:AddEffect(effectName, false, 0, -30)
      PaGlobal_AlchemyStone_All._contentEffectPlay = true
    end
    if PaGlobal_AlchemyStone_All._elapsTime > 2.5 and false == PaGlobal_AlchemyStone_All._slotEffectPlay then
      if PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE == tabType then
        PaGlobal_AlchemyStone_All._growthSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE].icon:AddEffect("fUI_Alchemy_Stone_Upgrade02", false)
      end
      PaGlobal_AlchemyStone_All._slotEffectPlay = true
      if PaGlobal_AlchemyStone_All._ui.radio_Upgrade:IsCheck() then
        PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT]:clearItem()
        PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty = true
      end
    end
    if PaGlobal_AlchemyStone_All._elapsTime > 3 and false == PaGlobal_AlchemyStone_All._effectEnd then
      PaGlobal_AlchemyStone_All._effectEnd = true
    end
    if PaGlobal_AlchemyStone_All._elapsTime > 5 and PaGlobal_AlchemyStone_All._elapsTime < 9 then
      if PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE == tabType then
        alchemyRepair(PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo, PaGlobal_AlchemyStone_All._fromWhereType, PaGlobal_AlchemyStone_All._fromSlotNo, PaGlobal_AlchemyStone_All._fromCount)
        PaGlobal_AlchemyStone_All._elapsTime = 0
      elseif PaGlobal_AlchemyStone_All._TAB_TYPE.EXP == tabType then
        alchemyUpgrade(PaGlobal_AlchemyStone_All._fromWhereType, PaGlobal_AlchemyStone_All._fromSlotNo, PaGlobal_AlchemyStone_All._fromCount, PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
        PaGlobal_AlchemyStone_All._elapsTime = 0
        PaGlobal_AlchemyStone_All._isPushDoit = false
        Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterStone, PaGlobalFunc_AlchemyStone_All_InvenStoneRClick, nil, nil)
      elseif PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE == tabType then
        alchemyEvolve(PaGlobal_AlchemyStone_All._fromWhereType, PaGlobal_AlchemyStone_All._fromSlotNo, PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
        PaGlobal_AlchemyStone_All._elapsTime = 9
      elseif PaGlobal_AlchemyStone_All._TAB_TYPE.RANDOMOPTION == tabType and PaGlobal_AlchemyStone_All._elapsTime > 7 then
        requestRandomOption(PaGlobal_AlchemyStone_All._fromWhereType, PaGlobal_AlchemyStone_All._fromSlotNo, PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo, PaGlobal_AlchemyStone_All._randomSourceKey)
        PaGlobal_AlchemyStone_All._elapsTime = 0
        PaGlobal_AlchemyStone_All._isPushDoit = false
      end
    end
    if PaGlobal_AlchemyStone_All._elapsTime > 9.5 and false == PaGlobal_AlchemyStone_All._isUpgrade then
      if -1 < PaGlobal_AlchemyStone_All._resultItemIndex then
        PaGlobal_AlchemyStone_All._resultSlotBg[PaGlobal_AlchemyStone_All._resultItemIndex]:AddEffect("fUI_Alchemy_Development_Succes_Slot_01A", false)
      else
        PaGlobal_AlchemyStone_All._growthSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE].icon:AddEffect("fUI_Alchemy_Development_Fail_Slot_01A", false)
      end
      PaGlobal_AlchemyStone_All._isUpgrade = true
    end
    if PaGlobal_AlchemyStone_All._elapsTime > 12 and PaGlobal_AlchemyStone_All._isUpgrade then
      PaGlobal_AlchemyStone_All._ui._growth.stc_upgradeSlotBg:SetSize(PaGlobal_AlchemyStone_All._ui._growth.stc_upgradeSlotBg:GetSizeX(), PaGlobal_AlchemyStone_All._upgradeSlotBg_OriginSizeY)
      PaGlobal_AlchemyStone_All._ui._growth.stc_upgradeSlotBg:SetPosY(PaGlobal_AlchemyStone_All._upgradeSlotBg_OriginPosY)
      PaGlobal_AlchemyStone_All._ui._growth.txt_success:SetShow(false)
      PaGlobal_AlchemyStone_All._ui._growth.txt_fail:SetShow(false)
      PaGlobal_AlchemyStone_All._isPushDoit = false
      PaGlobal_AlchemyStone_All:clearData(false)
      Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterStone, PaGlobalFunc_AlchemyStone_All_InvenStoneRClick, nil, nil)
      PaGlobal_AlchemyStone_All._isUpgrade = false
      PaGlobal_AlchemyStone_All._elapsTime = 0
    end
  else
    PaGlobal_AlchemyStone_All._elapsTime = 0
    PaGlobal_AlchemyStone_All._isUpgrade = false
    PaGlobal_AlchemyStone_All._startEffectPlay = false
    PaGlobal_AlchemyStone_All._contentEffectPlay = false
  end
  if false == PaGlobal_AlchemyStone_All._isConsole then
    for idx = 1, #PaGlobal_AlchemyStone_All._radioTabs do
      PaGlobal_AlchemyStone_All._radioTabs[idx]:SetEnable(not PaGlobal_AlchemyStone_All._isPushDoit)
    end
  else
    PaGlobal_AlchemyStone_All._ui_console.stc_guideIconA:SetShow(not PaGlobal_AlchemyStone_All._isPushDoit)
    PaGlobal_AlchemyStone_All:setKeyGuideAlign()
  end
  Panel_AlchemyStone_All_UpdateRandomOptionTextAnimation(deltaTime)
end
function Panel_AlchemyStone_All_StartRandomOptionTextAnimation(optionSize)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  if 0 == optionSize then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
  if nil == itemWrapper then
    return
  end
  PaGlobal_AlchemyStone_All._randomStatList = {}
  for ii = 0, optionSize - 1 do
    local statType = itemWrapper:getRandomOptionType(ii)
    local statValue = math.floor(itemWrapper:getRandomOptionValue(ii) * 10 + 0.5) / 10
    local randomOptionTypeWrapper = ToClient_GetRandomOptionTypeByKey(statType)
    if nil ~= randomOptionTypeWrapper then
      local randomStat = {}
      randomStat._statType = statType
      randomStat._statValueStr = randomOptionTypeWrapper:getRandomOptionTypeName() .. " +" .. statValue
      randomStat._statValueStr = randomStat._statValueStr .. getUnitForRandomOption(randomStat._statType)
      randomStat._state = PaGlobal_AlchemyStone_All._RANDOM_OPTION_STATE.MOVE_STOP
      randomStat._isMax = false
      for jj = 1, 3 do
        local randomOptionKey = itemWrapper:getRandomOptionByIndex(jj - 1)
        local randomOptionWrapper = ToClient_GetRandomOptionByKey(randomOptionKey)
        if nil ~= randomOptionWrapper then
          local maxStatValue = math.floor(randomOptionWrapper:getOptionMaxValueByType(statType) * 10 + 0.5) / 10
          if statValue == maxStatValue then
            randomStat._isMax = true
          end
        end
      end
      table.insert(PaGlobal_AlchemyStone_All._randomStatList, randomStat)
    end
  end
  local sortFunc = function(a, b)
    return a._statType < b._statType
  end
  table.sort(PaGlobal_AlchemyStone_All._randomStatList, sortFunc)
  PaGlobal_AlchemyStone_All._isShowRandomOption = true
  PaGlobal_AlchemyStone_All._randomOptionElapsedTime = 0
  PaGlobal_AlchemyStone_All._isRandomOptionTextMoveFinishFlag = false
  for index = 1, #PaGlobal_AlchemyStone_All._randomStatList do
    PaGlobal_AlchemyStone_All._randomOptionText[index]:SetShow(false)
    local startPosX = PaGlobal_AlchemyStone_All._ui._random.txt_randomOption:GetPosX()
    PaGlobal_AlchemyStone_All._randomOptionText[index]:SetPosX(startPosX)
    local startPosY = PaGlobal_AlchemyStone_All._ui._random.txt_randomOption:GetPosY() + PaGlobal_AlchemyStone_All._randomOptionTextVerticleMoveDistance
    PaGlobal_AlchemyStone_All._randomOptionText[index]:SetPosY(startPosY)
  end
  PaGlobal_AlchemyStone_All._randomStatList[1]._state = PaGlobal_AlchemyStone_All._RANDOM_OPTION_STATE.MOVE_START
  PaGlobal_AlchemyStone_All._randomOptionText[1]:SetText(PaGlobal_AlchemyStone_All._randomStatList[1]._statValueStr)
end
function Panel_AlchemyStone_All_UpdateRandomOptionTextAnimation(deltaTime)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  if true == PaGlobal_AlchemyStone_All._isShowRandomOption then
    for index = 1, #PaGlobal_AlchemyStone_All._randomStatList do
      if PaGlobal_AlchemyStone_All._RANDOM_OPTION_STATE.MOVE_START == PaGlobal_AlchemyStone_All._randomStatList[index]._state then
        local originY = PaGlobal_AlchemyStone_All._randomOptionText[index]:GetPosY()
        local targetY = originY - PaGlobal_AlchemyStone_All._randomOptionTextVerticleMoveDistance * deltaTime * PaGlobal_AlchemyStone_All._randomOptionMoveSpeed
        local limitY = PaGlobal_AlchemyStone_All._ui._random.txt_randomOption:GetPosY()
        if false == PaGlobal_AlchemyStone_All._isRandomOptionTextWaitingFlag and targetY <= limitY + PaGlobal_AlchemyStone_All._randomOptionTextVerticleJumpDistance then
          PaGlobal_AlchemyStone_All._isRandomOptionTextWaitingFlag = true
          PaGlobal_AlchemyStone_All._ui._random.txt_randomOption:SetShow(true)
          if true == PaGlobal_AlchemyStone_All._randomStatList[index]._isMax then
            PaGlobal_AlchemyStone_All._randomOptionTextForEffect:AddEffect("fUI_Alchemy_Unite_Upgrade_01B", false)
            audioPostEvent_SystemUi(5, 84)
            _AudioPostEvent_SystemUiForXBOX(5, 84)
          else
            PaGlobal_AlchemyStone_All._randomOptionTextForEffect:AddEffect("fUI_Alchemy_Unite_Upgrade_01A", false)
            audioPostEvent_SystemUi(5, 83)
            _AudioPostEvent_SystemUiForXBOX(5, 83)
          end
        end
        if targetY <= limitY then
          targetY = limitY
        end
        if true == PaGlobal_AlchemyStone_All._isRandomOptionTextWaitingFlag then
          PaGlobal_AlchemyStone_All._randomOptionElapsedTime = PaGlobal_AlchemyStone_All._randomOptionElapsedTime + deltaTime
          for index2 = 1, index - 1 do
            local originY_2 = PaGlobal_AlchemyStone_All._randomOptionText[index2]:GetPosY()
            local targetY_2 = originY_2 - PaGlobal_AlchemyStone_All._randomOptionTextVerticleJumpDistance * deltaTime * PaGlobal_AlchemyStone_All._randomOptionJumpSpeed
            local limitY_2 = PaGlobal_AlchemyStone_All._ui._random.txt_randomOption:GetPosY() - PaGlobal_AlchemyStone_All._randomOptionTextVerticleJumpDistance * (index - index2)
            if targetY_2 <= limitY_2 then
              targetY_2 = limitY_2
            end
            PaGlobal_AlchemyStone_All._randomOptionText[index2]:SetPosY(targetY_2)
          end
          local textInterval = PaGlobal_AlchemyStone_All._randomOptionTextInterval
          if true == PaGlobal_AlchemyStone_All._randomStatList[index]._isMax then
            textInterval = textInterval + PaGlobal_AlchemyStone_All._randomOptionTextMaxStatAddInterval
          end
          if textInterval < PaGlobal_AlchemyStone_All._randomOptionElapsedTime then
            PaGlobal_AlchemyStone_All._randomOptionElapsedTime = 0
            PaGlobal_AlchemyStone_All._isRandomOptionTextWaitingFlag = false
            PaGlobal_AlchemyStone_All._randomStatList[index]._state = PaGlobal_AlchemyStone_All._RANDOM_OPTION_STATE.MOVE_STOP
            PaGlobal_AlchemyStone_All._randomOptionText[index]:SetShow(true)
            if index == #PaGlobal_AlchemyStone_All._randomStatList then
              PaGlobal_AlchemyStone_All._isRandomOptionTextMoveFinishFlag = true
              PaGlobal_AlchemyStone_All._randomOptionElapsedTime = 0
            else
              PaGlobal_AlchemyStone_All._randomStatList[index + 1]._state = PaGlobal_AlchemyStone_All._RANDOM_OPTION_STATE.MOVE_START
              PaGlobal_AlchemyStone_All._randomOptionText[index + 1]:SetText(PaGlobal_AlchemyStone_All._randomStatList[index + 1]._statValueStr)
            end
            PaGlobal_AlchemyStone_All._ui._random.txt_randomOption:SetText("")
          elseif textInterval - PaGlobal_AlchemyStone_All._randomOptionTextShowTime < PaGlobal_AlchemyStone_All._randomOptionElapsedTime then
            PaGlobal_AlchemyStone_All._ui._random.txt_randomOption:SetText(PaGlobal_AlchemyStone_All._randomOptionText[index]:GetText())
          end
        else
          PaGlobal_AlchemyStone_All._randomOptionText[index]:SetPosY(targetY)
        end
      end
    end
    if true == PaGlobal_AlchemyStone_All._isRandomOptionTextMoveFinishFlag then
      PaGlobal_AlchemyStone_All._randomOptionElapsedTime = PaGlobal_AlchemyStone_All._randomOptionElapsedTime + deltaTime
      if PaGlobal_AlchemyStone_All._randomOptionTextDuration < PaGlobal_AlchemyStone_All._randomOptionElapsedTime then
        Panel_AlchemyStone_All_EndRandomOptionTextAnimation()
      end
    end
  end
end
function Panel_AlchemyStone_All_EndRandomOptionTextAnimation()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  PaGlobal_AlchemyStone_All._isShowRandomOption = false
  for index = 1, #PaGlobal_AlchemyStone_All._randomOptionText do
    PaGlobal_AlchemyStone_All._randomOptionText[index]:SetShow(false)
  end
  PaGlobal_AlchemyStone_All._randomSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].icon:EraseAllEffect()
  PaGlobal_AlchemyStone_All._randomSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE].icon:EraseAllEffect()
  PaGlobal_AlchemyStone_All._ui._random.txt_randomOption:SetShow(false)
end
