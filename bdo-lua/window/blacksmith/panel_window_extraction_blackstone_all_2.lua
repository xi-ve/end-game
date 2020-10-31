function PaGlobal_Extraction_Blackstone_All_Open()
  PaGlobal_Extraction_Blackstone_All:prepareOpen()
end
function PaGlobal_Extraction_Blackstone_All_Close()
  PaGlobal_Extraction_Blackstone_All:clear()
  HandleEventRUp_Extraction_Blackstone_All_ClearItemSlot()
  PaGlobal_Extraction_Blackstone_All:prepareClose()
end
function HandleEventLUp_Extraction_Blackstone_All_SkipAniButton()
  if false == PaGlobal_Extraction_Blackstone_All._isAniSkip then
    PaGlobal_Extraction_Blackstone_All._ui.btn_skipAni:SetCheck(true)
    PaGlobal_Extraction_Blackstone_All._isAniSkip = true
  else
    PaGlobal_Extraction_Blackstone_All._ui.btn_skipAni:SetCheck(false)
    PaGlobal_Extraction_Blackstone_All._isAniSkip = false
  end
end
function HandleEventLUp_Extraction_Blackstone_All_ExtractionButton()
  local messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_ENCHANTSTONE_ALL_EXTRACTIONCONFIRM")
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = messageContent,
    functionYes = function()
      PaGlobal_Extraction_Blackstone_All._ui.btn_skipAni:SetIgnore(true)
      PaGlobal_Extraction_Blackstone_All._ui.list2_extractableItem:SetEnable(false)
      PaGlobal_Extraction_Blackstone_All._ui_pc.btn_extraction:SetEnable(false)
      Panel_Window_Extraction_EnchantStone_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      PaGlobal_Extraction_Blackstone_All._isAniStart = true
      PaGlobal_Extraction_Blackstone_All._isSoundFx = true
      if false == PaGlobal_Extraction_Blackstone_All._isAniSkip then
        audioPostEvent_SystemUi(5, 70)
        _AudioPostEvent_SystemUiForXBOX(5, 70)
        PaGlobal_Extraction_Blackstone_All._ui.stc_effectCircle:EraseAllEffect()
        PaGlobal_Extraction_Blackstone_All._ui.stc_effectCircle:AddEffect("fUI_BlackExtract_01A", false, 0, 0)
      end
      Panel_Window_Extraction_EnchantStone_All:RegisterUpdateFunc("PaGlobal_Extraction_Blackstone_All_UpdateAni")
    end,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_Extraction_Blackstone_All_equipmentItem(equipNo)
  UI.ASSERT_NAME(nil ~= equipNo, "HandleEventLUp_Extraction_Blackstone_All_equipmentItem\236\157\152 equipNo nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if false == _ContentsGroup_RenewUI_InventoryEquip then
    if true == _ContentsGroup_NewUI_Equipment_All then
      HandleEventRUp_Equipment_All_EquipSlotRClick(equipNo)
    else
      Equipment_RClick(equipNo)
    end
  else
    InputMRUp_InventoryInfo_EquipSlot(equipNo)
  end
  PaGlobal_Extraction_Blackstone_All._lastIndex = PaGlobal_Extraction_Blackstone_All._ui.list2_extractableItem:getCurrenttoIndex()
end
function HandleEventLUp_Extraction_Blackstone_All_SelectListItem(key)
  if false == PaGlobal_Extraction_Blackstone_All._isConsole then
    HandleEventLUp_Extraction_Blackstone_All_BlackstoneItem(key)
  else
    local slotNo = PaGlobal_Extraction_Blackstone_All._itemInfo.slotNo[key]
    if PaGlobal_Extraction_Blackstone_All._selectedItemSlotNo == slotNo then
      HandleEventRUp_Extraction_Blackstone_All_ClearItemSlot()
      PaGlobal_Extraction_Blackstone_All._ui.list2_extractableItem:requestUpdateVisible()
    else
      HandleEventLUp_Extraction_Blackstone_All_BlackstoneItem(key)
    end
    PaGlobal_Extraction_Blackstone_All_ShowDetailKeyGuide(true, key)
  end
end
function HandleEventLUp_Extraction_Blackstone_All_BlackstoneItem(key)
  UI.ASSERT_NAME(nil ~= key, "andleEventLUp_Extraction_Blackstone_All_BlackstoneItem\236\157\152 key nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  for index = 1, PaGlobal_Extraction_Blackstone_All._blackStoneCnt do
    PaGlobal_Extraction_Blackstone_All._itemInfo.isExtractionEquip[index] = false
  end
  local slotNo = PaGlobal_Extraction_Blackstone_All._itemInfo.slotNo[key]
  local itemWrapper = getInventoryItemByType(0, slotNo)
  PaGlobal_Extraction_Blackstone_All:setExtractionIcon(slotNo, itemWrapper)
  PaGlobal_Extraction_Blackstone_All._itemInfo.isExtractionEquip[key] = true
  PaGlobal_Extraction_Blackstone_All._curSelectKey = key
  PaGlobal_Extraction_Blackstone_All._selectedItemSlotNo = slotNo
  PaGlobal_Extraction_Blackstone_All._targetSlotNo = slotNo
  PaGlobal_Extraction_Blackstone_All_ChangeHammerIcon()
end
function HandleEventLUp_Extraction_Blackstone_All_ListControlCreate(control, key)
  UI.ASSERT_NAME(nil ~= control, "HandleEventLUp_Extraction_Caphras_All_ListControlCreate\236\157\152 control nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= key, "HandleEventLUp_Extraction_Caphras_All_ListControlCreate\236\157\152 key nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  local key_32 = Int64toInt32(key)
  local btn_item = UI.getChildControl(control, "RadioButton_ExtractableItem")
  btn_item:SetCheck(false)
  local itemSlotBg = UI.getChildControl(btn_item, "Static_ItemSlotBG")
  local itemIcon = UI.getChildControl(itemSlotBg, "Static_ItemIcon")
  local itemText = UI.getChildControl(btn_item, "StaticText_ItemName")
  local text_equipment = UI.getChildControl(btn_item, "StaticText_Equipment")
  local hammerIcon = UI.getChildControl(btn_item, "Static_Hammer")
  local itemEnchant = UI.getChildControl(itemIcon, "Static_Text_Slot_Enchant_value")
  if nil == PaGlobal_Extraction_Blackstone_All._equipNo[key_32] then
    if false == PaGlobal_Extraction_Blackstone_All._isConsole then
      itemIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Blackstone_All_BlackstoneItem(" .. key_32 .. ")")
      itemIcon:addInputEvent("Mouse_On", "PaGlobal_Extraction_Blackstone_All_ShowListToolTip(" .. PaGlobal_Extraction_Blackstone_All._itemInfo.slotNo[key_32] .. ",true,false)")
      itemIcon:addInputEvent("Mouse_Out", "PaGlobal_Extraction_Blackstone_All_ShowListToolTip(" .. PaGlobal_Extraction_Blackstone_All._itemInfo.slotNo[key_32] .. ",false,false)")
    else
      btn_item:addInputEvent("Mouse_On", "PaGlobal_Extraction_Blackstone_All_ShowDetailKeyGuide(true," .. key_32 .. ")")
      btn_item:addInputEvent("Mouse_Out", "PaGlobal_Extraction_Blackstone_All_ShowDetailKeyGuide(false)")
      btn_item:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_Extraction_Blackstone_All_ShowListToolTip(" .. PaGlobal_Extraction_Blackstone_All._itemInfo.slotNo[key_32] .. ",nil,false)")
    end
    btn_item:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Blackstone_All_SelectListItem(" .. key_32 .. ")")
    text_equipment:SetShow(false)
    hammerIcon:SetShow(false)
  else
    if false == PaGlobal_Extraction_Blackstone_All._isConsole then
      itemIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Blackstone_All_equipmentItem(" .. PaGlobal_Extraction_Blackstone_All._equipNo[key_32] .. ")")
      itemIcon:addInputEvent("Mouse_On", "PaGlobal_Extraction_Blackstone_All_ShowListToolTip(" .. PaGlobal_Extraction_Blackstone_All._equipNo[key_32] .. ",true,true)")
      itemIcon:addInputEvent("Mouse_Out", "PaGlobal_Extraction_Blackstone_All_ShowListToolTip(" .. PaGlobal_Extraction_Blackstone_All._equipNo[key_32] .. ",false,true)")
    else
      btn_item:addInputEvent("Mouse_On", "PaGlobal_Extraction_Blackstone_All_ShowDetailKeyGuide(true" .. key_32 .. ")")
      btn_item:addInputEvent("Mouse_Out", "PaGlobal_Extraction_Blackstone_All_ShowDetailKeyGuide(false)")
      btn_item:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_Extraction_Blackstone_All_ShowListToolTip(" .. PaGlobal_Extraction_Blackstone_All._equipNo[key_32] .. ",nil,true)")
    end
    btn_item:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Blackstone_All_equipmentItem(" .. PaGlobal_Extraction_Blackstone_All._equipNo[key_32] .. ")")
    text_equipment:SetShow(true)
    hammerIcon:SetShow(false)
  end
  PaGlobal_Extraction_Blackstone_All._listControl[key_32] = control
  local itemName = PaGlobal_Extraction_Blackstone_All._itemInfo.name[key_32]
  local itemIconPath = PaGlobal_Extraction_Blackstone_All._itemInfo.iconPath[key_32]
  if nil ~= PaGlobal_Extraction_Blackstone_All._itemInfo.itemEnchantLevle[key_32] then
    itemEnchant:SetText(PaGlobal_Extraction_Blackstone_All._itemInfo.itemEnchantLevle[key_32])
  end
  if true == PaGlobal_Extraction_Blackstone_All._itemInfo.isExtractionEquip[key_32] then
    hammerIcon:SetShow(true)
    btn_item:SetCheck(true)
  end
  itemIcon:ChangeTextureInfoName("icon/" .. itemIconPath)
  itemText:SetText(itemName)
  local itemWrapper
  if nil == PaGlobal_Extraction_Blackstone_All._equipNo[key_32] then
    itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, PaGlobal_Extraction_Blackstone_All._itemInfo.slotNo[key_32])
  else
    itemWrapper = ToClient_getEquipmentItem(PaGlobal_Extraction_Blackstone_All._equipNo[key_32])
  end
  if nil ~= itemWrapper then
    PAGlobalFunc_SetItemTextColorForNewUI(itemText, itemWrapper:getStaticStatus())
  end
end
function HandleEventRUp_Extraction_Blackstone_All_ClearItemSlot()
  if true == PaGlobal_Extraction_Blackstone_All._isAniStart or nil == Panel_Window_Extraction_EnchantStone_All then
    return
  end
  if nil == PaGlobal_Extraction_Blackstone_All._listControl[1] then
    return
  end
  PaGlobal_Extraction_Blackstone_All:clear()
  for index = 1, PaGlobal_Extraction_Blackstone_All._blackStoneCnt do
    PaGlobal_Extraction_Blackstone_All._itemInfo.isExtractionEquip[index] = false
  end
  PaGlobal_Extraction_Blackstone_All._ui.list2_extractableItem:requestUpdateVisible()
  if false == PaGlobal_Extraction_Blackstone_All._isConsole then
    Panel_Tooltip_Item_hideTooltip()
  else
    PaGlobalFunc_TooltipInfo_Close()
  end
end
function FromClient_Extraction_Blackstone_All_ReSizePanel()
  if false == PaGlobal_Extraction_Blackstone_All._isConsole then
    PaGlobal_Extraction_Blackstone_All._ui_pc.btn_question:ComputePos()
    PaGlobal_Extraction_Blackstone_All._ui_pc.btn_close:ComputePos()
    PaGlobal_Extraction_Blackstone_All._ui_pc.btn_extraction:ComputePos()
  else
  end
  PaGlobal_Extraction_Blackstone_All._ui.stc_extractionSlot:ComputePos()
  PaGlobal_Extraction_Blackstone_All._ui.stc_resultSlot:ComputePos()
  PaGlobal_Extraction_Blackstone_All._ui.stc_leftBottomDese:ComputePos()
  PaGlobal_Extraction_Blackstone_All._ui.btn_skipAni:ComputePos()
  PaGlobal_Extraction_Blackstone_All._ui.list2_extractableItem:ComputePos()
  PaGlobal_Extraction_Blackstone_All._ui.stc_effectCircle:ComputePos()
  PaGlobal_Extraction_Blackstone_All._ui.txt_noItem:ComputePos()
end
function FromClient_Extraction_Blackstone_All_ExtractionEnchant_Success()
  PaGlobal_Extraction_Blackstone_All._currentTime = 0
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_Extraction_Blackstone_All_ResultShow()
  PaGlobal_Extraction_Blackstone_All:clear()
  PaGlobal_Extraction_Blackstone_All:updateExtractionList()
end
function PaGlobal_Extraction_Blackstone_All_CheckResultMsgShowTime(DeltaTime)
  PaGlobal_Extraction_Blackstone_All._extractionEnchantStone_ResultShowTime = PaGlobal_Extraction_Blackstone_All._extractionEnchantStone_ResultShowTime + DeltaTime
  if PaGlobal_Extraction_Blackstone_All._extractionEnchantStone_ResultShowTime > 3 and true == Panel_Window_Extraction_Result:GetShow() then
    Panel_Window_Extraction_Result:SetShow(false)
  end
  if PaGlobal_Extraction_Blackstone_All._extractionEnchantStone_ResultShowTime > 5 then
    PaGlobal_Extraction_Blackstone_All._extractionEnchantStone_ResultShowTime = 0
    Panel_Window_Extraction_Result:ClearUpdateLuaFunc()
  end
end
function PaGlobal_Extraction_Blackstone_All_ResultShow()
  PaGlobal_ExtractionResult:resetChildControl()
  PaGlobal_ExtractionResult:resetAnimation()
  if false == PaGlobal_ExtractionResult:getShow() then
    audioPostEvent_SystemUi(3, 2)
    _AudioPostEvent_SystemUiForXBOX(3, 2)
    if true == PaGlobal_Extraction_Blackstone_All._isWeapon then
      local blackStoneSSW = getItemEnchantStaticStatus(ItemEnchantKey(16001))
      PaGlobal_ExtractionResult:showResultMessage(PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_ENCHANTSTONE_RESULTMSG"), blackStoneSSW:getName(), blackStoneSSW)
    else
      local blackStoneSSW = getItemEnchantStaticStatus(ItemEnchantKey(16002))
      PaGlobal_ExtractionResult:showResultMessage(PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_ENCHANTSTONE_RESULTMSG"), blackStoneSSW:getName(), blackStoneSSW)
    end
  end
  PaGlobal_Extraction_Blackstone_All._extractionEnchantStone_ResultShowTime = 0
  Panel_Window_Extraction_Result:RegisterUpdateFunc("PaGlobal_Extraction_Blackstone_All_CheckResultMsgShowTime")
  PaGlobal_TutorialManager:handleExtractionEnchantStoneResultShow()
end
function PaGlobal_Extraction_Blackstone_All_ChangeHammerIcon()
  if nil == PaGlobal_Extraction_Blackstone_All._curSelectKey then
    return
  end
  if nil == PaGlobal_Extraction_Blackstone_All._preSelectKey then
    PaGlobal_Extraction_Blackstone_All._preSelectKey = PaGlobal_Extraction_Blackstone_All._curSelectKey
  end
  local btn_item = UI.getChildControl(PaGlobal_Extraction_Blackstone_All._listControl[PaGlobal_Extraction_Blackstone_All._preSelectKey], "RadioButton_ExtractableItem")
  local hammerIcon = UI.getChildControl(btn_item, "Static_Hammer")
  hammerIcon:SetShow(false)
  btn_item = UI.getChildControl(PaGlobal_Extraction_Blackstone_All._listControl[PaGlobal_Extraction_Blackstone_All._curSelectKey], "RadioButton_ExtractableItem")
  hammerIcon = UI.getChildControl(btn_item, "Static_Hammer")
  hammerIcon:SetShow(true)
  PaGlobal_Extraction_Blackstone_All._preSelectKey = PaGlobal_Extraction_Blackstone_All._curSelectKey
end
function PaGlobal_Extraction_Blackstone_All_ShowDetailKeyGuide(isShow, key)
  PaGlobal_Extraction_Blackstone_All._ui_console.btn_detail:SetShow(isShow)
  if false == isShow then
    PaGlobal_Extraction_Blackstone_All._ui_console.btn_select:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
  else
    local slotNo = PaGlobal_Extraction_Blackstone_All._itemInfo.slotNo[key]
    if PaGlobal_Extraction_Blackstone_All._selectedItemSlotNo == slotNo then
      PaGlobal_Extraction_Blackstone_All._ui_console.btn_select:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
    else
      PaGlobal_Extraction_Blackstone_All._ui_console.btn_select:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
    end
  end
  PaGlobal_Extraction_Blackstone_All_KeyGuidePosUpdate()
end
function PaGlobal_Extraction_Blackstone_All_KeyGuidePosUpdate()
  local keyGuides = {
    PaGlobal_Extraction_Blackstone_All._ui_console.btn_detail,
    PaGlobal_Extraction_Blackstone_All._ui_console.btn_select,
    PaGlobal_Extraction_Blackstone_All._ui_console.btn_close
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, PaGlobal_Extraction_Blackstone_All._ui_console.stc_bottomBtn, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_Extraction_Blackstone_All_ShowListToolTip(idx, isShow, isEquip)
  local itemWrapper
  if true == isEquip then
    itemWrapper = ToClient_getEquipmentItem(idx)
  else
    itemWrapper = getInventoryItemByType(0, idx)
  end
  if nil == itemWrapper then
    return
  end
  if false == PaGlobal_Extraction_Blackstone_All._isConsole then
    if true == isShow then
      Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_Extraction_EnchantStone_All, false, true, nil)
    else
      Panel_Tooltip_Item_hideTooltip()
    end
  else
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function PaGlobal_Extraction_Blackstone_All_ShowToolTip(isShow)
  if false == PaGlobal_Extraction_Blackstone_All._fromSlotOn then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_Extraction_Blackstone_All._fromWhereType, PaGlobal_Extraction_Blackstone_All._fromSlotNo)
  if nil == itemWrapper then
    return
  end
  if false == PaGlobal_Extraction_Blackstone_All._isConsole and false == PaGlobal_Extraction_Blackstone_All._ui._icon_items.empty then
    if true == isShow then
      Panel_Tooltip_Item_SetPosition(0, PaGlobal_Extraction_Blackstone_All._ui.stc_extractionSlot, "Purification")
      Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_Extraction_EnchantStone_All, false, true, nil)
    else
      Panel_Tooltip_Item_hideTooltip()
    end
  else
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function PaGlobal_Extraction_Blackstone_All_ResultShowToolTip(isShow)
  if false == PaGlobal_Extraction_Blackstone_All._fromSlotOn then
    return
  end
  local itemWrapper
  if true == PaGlobal_Extraction_Blackstone_All._isWeapon then
    itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(16001))
  else
    itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(16002))
  end
  if nil == itemWrapper then
    return
  end
  if false == PaGlobal_Extraction_Blackstone_All._isConsole and false == PaGlobal_Extraction_Blackstone_All._ui._icon_result.empty then
    if true == isShow then
      Panel_Tooltip_Item_SetPosition(0, PaGlobal_Extraction_Blackstone_All._ui.stc_resultSlot, "Purification")
      Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_Extraction_EnchantStone_All, true, false)
    else
      Panel_Tooltip_Item_hideTooltip()
    end
  else
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function PaGlobal_Extraction_Blackstone_All_UpdateList()
  if nil == Panel_Window_Extraction_EnchantStone_All or false == Panel_Window_Extraction_EnchantStone_All:GetShow() then
    return
  end
  PaGlobal_Extraction_Blackstone_All:updateExtractionList()
  if nil ~= PaGlobal_Extraction_Blackstone_All._lastIndex then
    PaGlobal_Extraction_Blackstone_All._ui.list2_extractableItem:moveIndex(PaGlobal_Extraction_Blackstone_All._lastIndex)
  end
end
function PaGlobal_Extraction_Blackstone_All_UpdateAni(delta)
  if nil == Panel_Window_Extraction_EnchantStone_All or false == PaGlobal_Extraction_Blackstone_All._isAniStart then
    return
  end
  PaGlobal_Extraction_Blackstone_All._currentTime = PaGlobal_Extraction_Blackstone_All._currentTime + delta
  if PaGlobal_Extraction_Blackstone_All._sound_ani_time < PaGlobal_Extraction_Blackstone_All._currentTime and true == PaGlobal_Extraction_Blackstone_All._isSoundFx and false == PaGlobal_Extraction_Blackstone_All._isAniSkip then
    audioPostEvent_SystemUi(5, 71)
    _AudioPostEvent_SystemUiForXBOX(5, 71)
    PaGlobal_Extraction_Blackstone_All._isSoundFx = false
  end
  if PaGlobal_Extraction_Blackstone_All._maxTime < PaGlobal_Extraction_Blackstone_All._currentTime or true == PaGlobal_Extraction_Blackstone_All._isAniSkip then
    PaGlobal_Extraction_Blackstone_All._currentTime = 0
    local itemWrapper = getInventoryItemByType(0, PaGlobal_Extraction_Blackstone_All._fromSlotNo)
    if nil ~= itemWrapper then
      ToClient_ExtractBlackStone(CppEnums.ItemWhereType.eInventory, PaGlobal_Extraction_Blackstone_All._targetSlotNo)
      FGlobal_MiniGame_RequestExtraction()
      PaGlobal_TutorialManager:handleApplyExtractionEnchantStone()
      Panel_Window_Extraction_EnchantStone_All:ClearUpdateLuaFunc()
    end
    if false == PaGlobal_Extraction_Blackstone_All._isConsole then
      PaGlobal_Extraction_Blackstone_All._ui_pc.btn_extraction:SetEnable(false)
      PaGlobal_Extraction_Blackstone_All._ui_pc.btn_extraction:SetMonoTone(false)
    else
      Panel_Window_Extraction_EnchantStone_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      PaGlobal_Extraction_Blackstone_All._ui_console.btn_extraction:SetMonoTone(false)
    end
    PaGlobal_Extraction_Blackstone_All._isAniStart = false
    PaGlobal_Extraction_Blackstone_All:updateExtractionList()
  end
end
function PaGlobal_Extraction_Blackstone_All_ShowAni()
  if nil == Panel_Window_Extraction_EnchantStone_All then
    return
  end
end
function PaGlobal_Extraction_Blackstone_All_HideAni()
  if nil == Panel_Window_Extraction_EnchantStone_All then
    return
  end
end
