function PaGlobal_Extraction_Costume_All_Open()
  PaGlobal_Extraction_Costume_All:prepareOpen()
end
function PaGlobal_Extraction_Costume_All_Close()
  PaGlobal_Extraction_Costume_All._isClose = true
  HandleEventRUp_Extraction_Costume_All_ClearItemSlot(true)
  PaGlobal_Extraction_Costume_All:prepareClose()
end
function HandleEventOn_Extraction_Costume_All_ShowToolTip(isEquip, idx, whereType, isShow, key)
  UI.ASSERT_NAME(nil ~= isEquip, "HandleEventOn_Extraction_Costume_All_ShowToolTip isEquip nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= idx, "HandleEventOn_Extraction_Costume_All_ShowToolTip idx nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
  local itemWrapper
  if true == isEquip then
    itemWrapper = ToClient_getEquipmentItem(idx)
  elseif nil == key then
    itemWrapper = getInventoryItemByType(whereType, idx)
  else
    itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(key))
  end
  if nil == itemWrapper then
    return
  end
  if false == PaGlobal_Extraction_Costume_All._isConsole then
    if true == isShow then
      Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_Extraction_Costume_All, false, true, nil)
    else
      Panel_Tooltip_Item_hideTooltip()
    end
  else
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    if nil == key then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    end
  end
end
function HandleEventLUp_Extraction_Costume_All_SkipAniButton()
  if false == PaGlobal_Extraction_Costume_All._isSkipAni then
    PaGlobal_Extraction_Costume_All._ui.btn_skipAni:SetCheck(true)
    PaGlobal_Extraction_Costume_All._isSkipAni = true
  else
    PaGlobal_Extraction_Costume_All._ui.btn_skipAni:SetCheck(false)
    PaGlobal_Extraction_Costume_All._isSkipAni = false
  end
end
function HandleEventLUp_Extraction_Costume_All_ListControlCreate(control, key)
  UI.ASSERT_NAME(nil ~= control, "HandleEventLUp_Extraction_Costume_All_ListControlCreate\236\157\152 control nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= key, "HandleEventLUp_Extraction_Costume_All_ListControlCreate\236\157\152 key nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  local key_32 = Int64toInt32(key)
  local btn_item = UI.getChildControl(control, "CheckButton_ExtractableItem")
  btn_item:SetCheck(false)
  local item_checkBtn = UI.getChildControl(btn_item, "CheckButton_Select")
  item_checkBtn:SetCheck(false)
  local btn_Equip = UI.getChildControl(btn_item, "Button_Equip")
  btn_Equip:SetTextMode(__eTextMode_AutoWrap)
  btn_Equip:SetText(btn_Equip:GetText())
  local itemSlotBg = UI.getChildControl(btn_item, "Static_ItemSlotBG")
  local itemIcon = UI.getChildControl(control, "Static_ItemIcon")
  local itemText = UI.getChildControl(itemSlotBg, "StaticText_ItemName")
  local hammerIcon = UI.getChildControl(btn_item, "Static_Hammer")
  hammerIcon:SetShow(false)
  local whereType = PaGlobal_Extraction_Costume_All._itemInfo.whereType[key_32]
  if nil == PaGlobal_Extraction_Costume_All._equipNo[key_32] then
    if false == PaGlobal_Extraction_Costume_All._isConsole then
      item_checkBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Costume_All_CostumeItem(" .. key_32 .. ")")
      itemIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Costume_All_CostumeItem(" .. key_32 .. ")")
      itemIcon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_Costume_All_ShowToolTip(false," .. PaGlobal_Extraction_Costume_All._itemInfo.slotNo[key_32] .. "," .. whereType .. ",true)")
      itemIcon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_Costume_All_ShowToolTip(false," .. PaGlobal_Extraction_Costume_All._itemInfo.slotNo[key_32] .. "," .. whereType .. ",false)")
    else
      btn_item:addInputEvent("Mouse_On", "PaGlobal_Extraction_Costume_All_ShowDetailKeyGuide(true," .. key_32 .. ")")
      btn_item:addInputEvent("Mouse_Out", "PaGlobal_Extraction_Costume_All_ShowDetailKeyGuide(false," .. key_32 .. ")")
      btn_item:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Extraction_Costume_All_ShowToolTip(false," .. PaGlobal_Extraction_Costume_All._itemInfo.slotNo[key_32] .. "," .. whereType .. ",nil)")
    end
    btn_item:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Costume_All_SelectListItem(" .. key_32 .. ")")
    local itemKey = getInventoryItemByType(whereType, PaGlobal_Extraction_Costume_All._itemInfo.slotNo[key_32])
    PAGlobalFunc_SetItemTextColorForNewUI(itemText, itemKey:getStaticStatus())
    btn_Equip:SetShow(false)
    btn_Equip:SetIgnore(true)
    btn_item:SetIgnore(false)
    item_checkBtn:SetIgnore(false)
    itemSlotBg:SetEnable(true)
  else
    if false == PaGlobal_Extraction_Costume_All._isConsole then
      itemIcon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_Costume_All_ShowToolTip(true," .. PaGlobal_Extraction_Costume_All._equipNo[key_32] .. "," .. whereType .. ",true)")
      itemIcon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_Costume_All_ShowToolTip(true," .. PaGlobal_Extraction_Costume_All._equipNo[key_32] .. "," .. whereType .. ",false)")
      itemIcon:addInputEvent("Mouse_LUp", "")
      btn_Equip:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Costume_All_EquipmentItem(" .. PaGlobal_Extraction_Costume_All._equipNo[key_32] .. ")")
      btn_item:SetIgnore(true)
    else
      btn_item:addInputEvent("Mouse_On", "PaGlobal_Extraction_Costume_All_ShowDetailKeyGuide(true," .. key_32 .. ")")
      btn_item:addInputEvent("Mouse_Out", "PaGlobal_Extraction_Costume_All_ShowDetailKeyGuide(false," .. key_32 .. ")")
      btn_item:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Extraction_Costume_All_ShowToolTip(true," .. PaGlobal_Extraction_Costume_All._equipNo[key_32] .. "," .. whereType .. ",nil)")
      btn_item:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Costume_All_EquipmentItem(" .. PaGlobal_Extraction_Costume_All._equipNo[key_32] .. ")")
    end
    local itemKey = ToClient_getEquipmentItem(PaGlobal_Extraction_Costume_All._equipNo[key_32])
    PAGlobalFunc_SetItemTextColorForNewUI(itemText, itemKey:getStaticStatus())
    btn_Equip:SetShow(true)
    btn_Equip:SetIgnore(false)
    item_checkBtn:SetIgnore(true)
    itemSlotBg:SetEnable(false)
  end
  local itemName = PaGlobal_Extraction_Costume_All._itemInfo.name[key_32]
  local itemIconPath = PaGlobal_Extraction_Costume_All._itemInfo.iconPath[key_32]
  itemText:SetTextMode(__eTextMode_AutoWrap)
  itemText:SetText(itemName)
  itemIcon:ChangeTextureInfoName("icon/" .. itemIconPath)
  if true == PaGlobal_Extraction_Costume_All._itemInfo.isExtractionEquip[key_32] then
    btn_item:SetCheck(true)
    item_checkBtn:SetCheck(true)
  end
end
function HandleEventRUp_Extraction_Costume_All_ClearItemSlot(noUpdateVisible)
  if false == PaGlobal_Extraction_Costume_All._isClose and true == PaGlobal_Extraction_Costume_All._isAniStart or nil == Panel_Window_Extraction_Costume_All then
    return
  end
  PaGlobal_Extraction_Costume_All._selectedItemSlotNo = nil
  PaGlobal_Extraction_Costume_All:clearAllSlot()
  if noUpdateVisible then
    return
  end
  PaGlobal_Extraction_Costume_All._ui.list2_extractableItem:requestUpdateVisible()
end
function HandleEventLUp_Extraction_Costume_All_Extraction()
  PaGlobal_Extraction_Costume_All._delta_ani_time = 0
  local resultItem = ""
  if true == PaGlobal_Extraction_Costume_All._isValks then
    resultItem = "<" .. getItemEnchantStaticStatus(ItemEnchantKey(17900)):getName() .. ">"
  else
    resultItem = "<" .. getItemEnchantStaticStatus(ItemEnchantKey(16080)):getName() .. ">"
  end
  local messageContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EXTRACTION_CLOTH_3", "resultItem", resultItem)
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "UI_WINDOW_EXTRACTION_CLOTH_TITLE"),
    content = messageContent,
    functionYes = function()
      PaGlobal_Extraction_Costume_All._delta_ani_time = 0
      PaGlobal_Extraction_Costume_All._isAniStart = true
      PaGlobal_Extraction_Costume_All._ui.btn_valks:SetIgnore(true)
      PaGlobal_Extraction_Costume_All._ui.btn_cron:SetIgnore(true)
      PaGlobal_Extraction_Costume_All._ui_pc.btn_extraction:SetEnable(false)
      PaGlobal_Extraction_Costume_All._ui_console.btn_extraction:SetEnable(false)
      Panel_Window_Extraction_Costume_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      PaGlobal_Extraction_Costume_All._ui.stc_extractionImg:EraseAllEffect()
      PaGlobal_Extraction_Costume_All._ui.stc_extractionImg:AddEffect("fUI_BlackExtractClothes_01A", false, 0, 0)
      Panel_Window_Extraction_Costume_All:RegisterUpdateFunc("PaGlobal_Extraction_Costume_All_UpdateExtractionAni")
      if false == PaGlobal_Extraction_Costume_All._isSkipAni then
        audioPostEvent_SystemUi(5, 74)
        _AudioPostEvent_SystemUiForXBOX(5, 74)
      end
      PaGlobal_Extraction_Costume_All:extractionButtonIgnore(true)
      PaGlobal_Extraction_Costume_All._isExtraction = true
      PaGlobal_Extraction_Costume_All._isSoundFx = true
    end,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_Extraction_Costume_All_SelectListItem(key)
  HandleEventLUp_Extraction_Costume_All_CostumeItem(key)
  PaGlobal_Extraction_Costume_All_ShowDetailKeyGuide(true, key)
end
function HandleEventLUp_Extraction_Costume_All_CostumeItem(key)
  UI.ASSERT_NAME(nil ~= key, "HandleEventLUp_Extraction_Costume_All_CostumeItem\236\157\152 key nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  local slotNo = PaGlobal_Extraction_Costume_All._itemInfo.slotNo[key]
  PaGlobal_Extraction_Costume_All._selectedItemSlotNo = slotNo
  if false == PaGlobal_Extraction_Costume_All._itemInfo.isExtractionEquip[key] or nil == PaGlobal_Extraction_Costume_All._itemInfo.isExtractionEquip[key] then
    PaGlobal_Extraction_Costume_All._extractionCnt = PaGlobal_Extraction_Costume_All._extractionCnt + 1
    PaGlobal_Extraction_Costume_All._extractionItem.slotNo[PaGlobal_Extraction_Costume_All._extractionCnt] = slotNo
    PaGlobal_Extraction_Costume_All._extractionItem.whereType[PaGlobal_Extraction_Costume_All._extractionCnt] = PaGlobal_Extraction_Costume_All._itemInfo.whereType[key]
    PaGlobal_Extraction_Costume_All._itemInfo.isExtractionEquip[key] = true
  else
    PaGlobal_Extraction_Costume_All._extractionCnt = PaGlobal_Extraction_Costume_All._extractionCnt - 1
    PaGlobal_Extraction_Costume_All._itemInfo.isExtractionEquip[key] = false
    local extractionItemSlotNoIndex = 1
    for index = 1, PaGlobal_Extraction_Costume_All._costumeCnt do
      if true == PaGlobal_Extraction_Costume_All._itemInfo.isExtractionEquip[index] then
        PaGlobal_Extraction_Costume_All._extractionItem.slotNo[extractionItemSlotNoIndex] = PaGlobal_Extraction_Costume_All._itemInfo.slotNo[index]
        PaGlobal_Extraction_Costume_All._extractionItem.whereType[extractionItemSlotNoIndex] = PaGlobal_Extraction_Costume_All._itemInfo.whereType[index]
        extractionItemSlotNoIndex = extractionItemSlotNoIndex + 1
      end
    end
  end
  PaGlobal_Extraction_Costume_All:setExtractionIcon()
  PaGlobal_Extraction_Costume_All._ui.txt_extractionCnt:SetText(PaGlobal_Extraction_Costume_All._extractionCnt)
  local uiControl = PaGlobal_Extraction_Costume_All._ui.list2_extractableItem:GetContentByKey(toInt64(0, key))
  if nil == uiControl then
    return
  end
  local btn_item = UI.getChildControl(uiControl, "CheckButton_ExtractableItem")
  local item_checkBtn = UI.getChildControl(btn_item, "CheckButton_Select")
  local isCheck = true == PaGlobal_Extraction_Costume_All._itemInfo.isExtractionEquip[key]
  item_checkBtn:SetCheck(isCheck)
  btn_item:SetCheck(isCheck)
end
function HandleEventLUp_Extraction_Costume_All_EquipmentItem(equipNo)
  UI.ASSERT_NAME(nil ~= equipNo, "HandleEventLUp_Extraction_Costume_All_equipmentItem\236\157\152 equipNo nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if false == _ContentsGroup_RenewUI_InventoryEquip then
    if true == _ContentsGroup_NewUI_Equipment_All then
      HandleEventRUp_Equipment_All_EquipSlotRClick(equipNo)
    else
      Equipment_RClick(equipNo)
    end
  else
    InputMRUp_InventoryInfo_EquipSlot(equipNo)
  end
  PaGlobal_Extraction_Costume_All._lastIndex = PaGlobal_Extraction_Costume_All._ui.list2_extractableItem:getCurrenttoIndex()
end
function HandleEventLUp_Extraction_Costume_All_ExtractionTypeValk()
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
  if false == PaGlobal_Extraction_Costume_All._isValks or nil == PaGlobal_Extraction_Costume_All._isValks then
    PaGlobal_Extraction_Costume_All._ui.btn_valks:SetCheck(true)
    PaGlobal_Extraction_Costume_All._ui.btn_cron:SetCheck(false)
    PaGlobal_Extraction_Costume_All._isValks = true
  else
    PaGlobal_Extraction_Costume_All._ui.btn_valks:SetCheck(false)
    PaGlobal_Extraction_Costume_All._ui.btn_cron:SetCheck(false)
    PaGlobal_Extraction_Costume_All._isValks = nil
  end
  PaGlobal_Extraction_Costume_All:setExtractionIcon()
end
function HandleEventLUp_Extraction_Costume_All_ExtractionTypeCron()
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
  if true == PaGlobal_Extraction_Costume_All._isValks or nil == PaGlobal_Extraction_Costume_All._isValks then
    PaGlobal_Extraction_Costume_All._ui.btn_valks:SetCheck(false)
    PaGlobal_Extraction_Costume_All._ui.btn_cron:SetCheck(true)
    PaGlobal_Extraction_Costume_All._isValks = false
  else
    PaGlobal_Extraction_Costume_All._ui.btn_valks:SetCheck(false)
    PaGlobal_Extraction_Costume_All._ui.btn_cron:SetCheck(false)
    PaGlobal_Extraction_Costume_All._isValks = nil
  end
  PaGlobal_Extraction_Costume_All:setExtractionIcon()
end
function FromClient_Extraction_Costume_All_ReSizePanel()
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
  if false == PaGlobal_Extraction_Costume_All._isConsole then
    PaGlobal_Extraction_Costume_All._ui_pc.btn_question:ComputePos()
    PaGlobal_Extraction_Costume_All._ui_pc.btn_close:ComputePos()
    PaGlobal_Extraction_Costume_All._ui_pc.btn_extraction:ComputePos()
  else
  end
  PaGlobal_Extraction_Costume_All._ui.stc_leftTopDesc:ComputePos()
  PaGlobal_Extraction_Costume_All._ui.stc_extractableItemSlot:ComputePos()
  PaGlobal_Extraction_Costume_All._ui.stc_resultItmeSlot:ComputePos()
  PaGlobal_Extraction_Costume_All._ui.stc_leftBottomDesc:ComputePos()
  PaGlobal_Extraction_Costume_All._ui.btn_skipAni:ComputePos()
  PaGlobal_Extraction_Costume_All._ui.btn_valks:ComputePos()
  PaGlobal_Extraction_Costume_All._ui.btn_cron:ComputePos()
  PaGlobal_Extraction_Costume_All._ui.txt_extractionCnt:ComputePos()
  PaGlobal_Extraction_Costume_All._ui.stc_extractionImg:ComputePos()
  PaGlobal_Extraction_Costume_All._ui.txt_noItem:ComputePos()
end
function FromClient_Extraction_Costume_All_Extraction_SuccessMessage()
  PaGlobal_ExtractionResult:resetChildControl()
  PaGlobal_ExtractionResult:resetAnimation()
  if false == PaGlobal_ExtractionResult:getShow() then
    audioPostEvent_SystemUi(3, 2)
    _AudioPostEvent_SystemUiForXBOX(3, 2)
    if true == PaGlobal_Extraction_Costume_All._isValks then
      local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(17643))
      if nil ~= itemSSW then
        PaGlobal_ExtractionResult:showResultMessage(itemSSW:getName(), PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_CLOTH_2"), itemSSW)
      else
        PaGlobal_ExtractionResult:showResultMessage(PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_CLOTH_2"))
      end
    else
      local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(16080))
      if nil ~= itemSSW then
        PaGlobal_ExtractionResult:showResultMessage(itemSSW:getName(), PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_CLOTH_2"), itemSSW)
      else
        PaGlobal_ExtractionResult:showResultMessage(PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_CLOTH_2"))
      end
    end
  end
  PaGlobal_Extraction_Costume_All._resultShowTime = 0
  Panel_Window_Extraction_Result:RegisterUpdateFunc("PaGlobal_Extraction_Costume_All_UpdateResultMsgShowTime")
end
function PaGlobal_Extraction_Costume_All_UpdateResultMsgShowTime(delta)
  PaGlobal_Extraction_Costume_All._resultShowTime = PaGlobal_Extraction_Costume_All._resultShowTime + delta
  if PaGlobal_Extraction_Costume_All._resultShowTime > 3 and true == Panel_Window_Extraction_Result:GetShow() then
    Panel_Window_Extraction_Result:SetShow(false)
  end
  if PaGlobal_Extraction_Costume_All._resultShowTime > 5 then
    ExtractionClothResult_TimerReset()
    Panel_Window_Extraction_Result:ClearUpdateLuaFunc()
  end
end
function PaGlobal_Extraction_Costume_All_UpdateExtractionAni(delta)
  if nil == Panel_Window_Extraction_Costume_All or false == PaGlobal_Extraction_Costume_All._isAniStart then
    return
  end
  PaGlobal_Extraction_Costume_All._delta_ani_time = PaGlobal_Extraction_Costume_All._delta_ani_time + delta
  if PaGlobal_Extraction_Costume_All._sound_ani_time < PaGlobal_Extraction_Costume_All._delta_ani_time and true == PaGlobal_Extraction_Costume_All._isSoundFx and false == PaGlobal_Extraction_Costume_All._isSkipAni then
    audioPostEvent_SystemUi(5, 75)
    _AudioPostEvent_SystemUiForXBOX(5, 75)
    PaGlobal_Extraction_Costume_All._isSoundFx = false
  end
  if PaGlobal_Extraction_Costume_All._const_ani_time < PaGlobal_Extraction_Costume_All._delta_ani_time or true == PaGlobal_Extraction_Costume_All._isSkipAni then
    PaGlobal_Extraction_Costume_All._delta_ani_time = 0
    for index = 1, PaGlobal_Extraction_Costume_All._extractionCnt do
      ToClient_RequestExtracItemFromExtractionCount(PaGlobal_Extraction_Costume_All._extractionItem.whereType[index], PaGlobal_Extraction_Costume_All._extractionItem.slotNo[index], PaGlobal_Extraction_Costume_All._isValks)
    end
    PaGlobal_Extraction_Costume_All._isAniStart = false
    PaGlobal_Extraction_Costume_All:clearAllSlot()
    Panel_Window_Extraction_Costume_All:ClearUpdateLuaFunc()
  end
end
function PaGlobal_Extraction_Costume_All_UpdateList()
  if nil == Panel_Window_Extraction_Costume_All or false == Panel_Window_Extraction_Costume_All:GetShow() then
    return
  end
  PaGlobal_Extraction_Costume_All:updateExtractionList()
  if nil ~= PaGlobal_Extraction_Costume_All._lastIndex then
    PaGlobal_Extraction_Costume_All._ui.list2_extractableItem:moveIndex(PaGlobal_Extraction_Costume_All._lastIndex)
  end
end
function PaGlobal_Extraction_Costume_All_ShowDetailKeyGuide(isShow, key)
  PaGlobal_Extraction_Costume_All._ui_console.stc_iconX:SetShow(isShow)
  if false == isShow then
    PaGlobal_Extraction_Costume_All._ui_console.stc_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
  else
    local control = PaGlobal_Extraction_Costume_All._ui.list2_extractableItem:GetContentByKey(toInt64(0, key))
    if nil == key or nil == control then
      PaGlobal_Extraction_Costume_All._ui_console.stc_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
    else
      local btn_item = UI.getChildControl(control, "CheckButton_ExtractableItem")
      if true == btn_item:IsCheck() then
        PaGlobal_Extraction_Costume_All._ui_console.stc_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
      else
        PaGlobal_Extraction_Costume_All._ui_console.stc_iconA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
      end
    end
  end
  PaGlobal_Extraction_Costume_All_KeyGuidePosUpdate()
end
function PaGlobal_Extraction_Costume_All_KeyGuidePosUpdate()
  local keyGuides = {
    PaGlobal_Extraction_Costume_All._ui_console.stc_iconX,
    PaGlobal_Extraction_Costume_All._ui_console.stc_iconA,
    PaGlobal_Extraction_Costume_All._ui_console.stc_iconB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, PaGlobal_Extraction_Costume_All._ui_console.stc_bottomGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_Extraction_Costume_All_ShowAni()
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
end
function PaGlobal_Extraction_Costume_All_HideAni()
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
end
