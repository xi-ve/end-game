function PaGlobalFunc_Purification_All_Open()
  if nil == Panel_Purification_All or true == Panel_Purification_All:GetShow() then
    return
  end
  PaGlobal_Purification_All:prepareOpen()
end
function HandleEventLUp_Purification_All_Close()
  if nil == Panel_Purification_All or false == Panel_Purification_All:GetShow() then
    return
  end
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobal_Purification_All_OnPadB()
  end
  PaGlobal_Purification_All:prepareClose()
end
function PaGlobal_Purification_All_OnPadB()
  if true == PaGlobal_Purification_All._isAniStart then
    return false
  end
  if true == PaGlobal_Purification_All._fromSlotOn then
    HandleEventRUp_Purification_All_DataClear()
    return false
  else
    return true
  end
end
function FromClient_Purification_All_MoneyUpdate()
  if nil == Panel_Purification_All then
    return
  end
  PaGlobal_Purification_All:moneyUpdate()
end
function HandleEventLUp_Purification_All_CheckMoneyButton(value)
  if nil == Panel_Purification_All or false == Panel_Purification_All:GetShow() then
    return
  end
  PaGlobal_Purification_All:checkMoneyButton(value)
end
function HandleEventLUp_Purification_All_RequestPurification()
  if nil == Panel_Purification_All or false == Panel_Purification_All:GetShow() then
    return
  end
  PaGlobal_Purification_All:requestPurification()
end
function FromClient_Purification_All_List2Update(content, key)
  if nil == Panel_Purification_All or false == Panel_Purification_All:GetShow() then
    return
  end
  local key32 = Int64toInt32(key)
  local rdoBtn = UI.getChildControl(content, "RadioButton_EnchantEquipItem")
  local slotBg = UI.getChildControl(rdoBtn, "Static_ItemSlotBG")
  local iconBg = UI.getChildControl(slotBg, "Static_ItemIcon")
  local itemName = UI.getChildControl(slotBg, "StaticText_ItemName")
  local itemCount = UI.getChildControl(rdoBtn, "StaticText_ItemCnt")
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, key32)
  if nil == itemWrapper then
    rdoBtn:SetShow(false)
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  itemName:SetText(itemSSW:getName())
  PAGlobalFunc_SetItemTextColorForNewUI(itemName, itemSSW)
  rdoBtn:setNotImpactScrollEvent(true)
  itemCount:SetShow(false)
  local slot = {}
  SlotItem.reInclude(slot, "possibleItem", key32, iconBg, PaGlobal_Purification_All._slotConfig)
  slot:clearItem()
  slot:setItem(itemWrapper)
  rdoBtn:SetCheck(false)
  if true == PaGlobal_Purification_All._isConsole then
    if true == PaGlobal_Purification_All._isAniStart then
      rdoBtn:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
      rdoBtn:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
      rdoBtn:SetIgnore(true)
      rdoBtn:SetMonoTone(true)
    else
      rdoBtn:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Purification_All_SelectItem(" .. key32 .. ")")
      rdoBtn:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_Purification_All_ShowToolTipConsole(true, 2," .. key32 .. ")")
      rdoBtn:SetIgnore(false)
      rdoBtn:SetMonoTone(false)
    end
  else
    rdoBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Purification_All_SelectItem(" .. key32 .. ")")
    slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Purification_All_ShowToolTipPC(true, 2," .. key32 .. ")")
    slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Purification_All_ShowToolTipPC(false,2," .. key32 .. ")")
    rdoBtn:addInputEvent("Mouse_On", "HandleEventOnOut_Purification_All_ShowToolTipPC(true, 2," .. key32 .. ")")
    rdoBtn:addInputEvent("Mouse_Out", "HandleEventOnOut_Purification_All_ShowToolTipPC(false,2," .. key32 .. ")")
  end
end
function HandleEventLUp_Purification_All_SelectItem(slotNo)
  if nil == Panel_Purification_All then
    return
  end
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
  if nil == itemWrapper then
    return
  end
  local tempKey = itemWrapper:get():getKey()
  local staticStatus = itemWrapper:getStaticStatus()
  if nil == staticStatus or true == PaGlobal_Purification_All._isAniStart then
    return
  end
  if true == _ContentsGroup_UsePadSnapping and nil ~= PaGlobal_Purification_All._fromSlotIdx and PaGlobal_Purification_All._fromSlotIdx == slotNo then
    PaGlobal_Purification_All_OnPadB()
    return
  end
  PaGlobal_Purification_All._itemSlotBg_Icon:setItemByStaticStatus(staticStatus, Defines.s64_const.s64_1)
  PaGlobal_Purification_All._fromSlotIdx = slotNo
  PaGlobal_Purification_All._fromWhereType = CppEnums.ItemWhereType.eInventory
  PaGlobal_Purification_All._fromSlotOn = true
  PaGlobal_Purification_All._resultSlotOn = false
  PaGlobal_Purification_All._resultSlotIdx = -1
  PaGlobal_Purification_All._resultWhereType = -1
  local prevStatic = staticStatus:getPrevItemEnchantStaticStatus()
  PaGlobal_Purification_All._resultSlotBg_Icon:clearItem()
  if nil ~= prevStatic then
    PaGlobal_Purification_All._resultSlotBg_Icon:setItemByStaticStatus(prevStatic, Defines.s64_const.s64_1)
    PaGlobal_Purification_All._ui._stc_ResultSlotBg:SetMonoTone(true)
    if true == PaGlobal_Purification_All._isConsole then
      PaGlobal_Purification_All._ui._stc_ResultSlotBg:SetIgnore(true)
    end
  end
end
function PaGlobalFunc_Purification_All_RequestPurificationAni(delta)
  if nil == Panel_Purification_All or false == Panel_Purification_All:GetShow() then
    return
  end
  if false == PaGlobal_Purification_All._isAniStart then
    return
  end
  PaGlobal_Purification_All._ui._btn_CheckAniSkip:SetIgnore(true)
  PaGlobal_Purification_All._ui._btn_Radio_Inven:SetIgnore(true)
  PaGlobal_Purification_All._ui._btn_Radio_Ware:SetIgnore(true)
  PaGlobal_Purification_All._delta_ani_time = PaGlobal_Purification_All._delta_ani_time + delta
  local skipCheck = false
  if true == PaGlobal_Purification_All._ui._btn_CheckAniSkip:IsCheck() then
    skipCheck = true
  end
  if PaGlobal_Purification_All._CONST_ANI_TIME < PaGlobal_Purification_All._delta_ani_time or true == skipCheck then
    PaGlobal_Purification_All._delta_ani_time = 0
    ToClient_WeakenEncantByNpc(PaGlobal_Purification_All._fromWhereType, PaGlobal_Purification_All._fromSlotIdx, PaGlobal_Purification_All._moneyWhereType)
    if false == PaGlobal_Purification_All._isConsole then
      PaGlobal_Purification_All._ui._btn_Purify_Pc:SetIgnore(false)
    end
    PaGlobal_Purification_All._resultSlotIdx = PaGlobal_Purification_All._fromSlotIdx
    PaGlobal_Purification_All._resultWhereType = PaGlobal_Purification_All._fromWhereType
    PaGlobal_Purification_All._isAniStart = false
    Panel_Purification_All:ClearUpdateLuaFunc()
  end
end
function HandleEventOnOut_Purification_All_AniButtonTooltipPC(isShow)
  if nil == Panel_Purification_All or false == Panel_Purification_All:GetShow() or false == PaGlobal_Purification_All._isConsole then
    return
  end
  if true == isShow then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_PURIFICATION_TOOLTIP_NAME")
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SPRITENCHANT_SKIPENCHANT_TOOLTIP_DESC_CAPHRAS")
    TooltipSimple_Show(PaGlobal_Purification_All._ui._btn_CheckAniSkip, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventOnOut_Purification_All_ShowToolTipPC(isShow, tooltipType, slotIdxForList)
  if nil == Panel_Purification_All or true == PaGlobal_Purification_All._isConsole or false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemWrapper, control
  if 0 == tooltipType then
    if false == PaGlobal_Purification_All._fromSlotOn then
      return
    end
    itemWrapper = getInventoryItemByType(PaGlobal_Purification_All._fromWhereType, PaGlobal_Purification_All._fromSlotIdx)
    control = PaGlobal_Purification_All._ui._stc_ItemSlotBg
  elseif 1 == tooltipType then
    if false == PaGlobal_Purification_All._resultSlotOn then
      return
    end
    itemWrapper = getInventoryItemByType(PaGlobal_Purification_All._resultWhereType, PaGlobal_Purification_All._resultSlotIdx)
    control = PaGlobal_Purification_All._ui._stc_ResultSlotBg
  else
    itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotIdxForList)
    control = PaGlobal_Purification_All._ui._stc_ItemSlotBg
  end
  if nil == itemWrapper then
    return
  end
  Panel_Tooltip_Item_SetPosition(0, control, "Purification")
  Panel_Tooltip_Item_Show(itemWrapper, Panel_Purification_All, false, true, nil)
end
function HandleEventLUp_Purification_All_ShowToolTipConsole(isShow, tooltipType, slotIdxForList)
  if nil == Panel_Purification_All or false == PaGlobal_Purification_All._isConsole or false == isShow or PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local itemWrapper
  if 0 == tooltipType then
    if false == PaGlobal_Purification_All._fromSlotOn then
      return
    end
    itemWrapper = getInventoryItemByType(PaGlobal_Purification_All._fromWhereType, PaGlobal_Purification_All._fromSlotIdx)
  elseif 1 == tooltipType then
    if false == PaGlobal_Purification_All._resultSlotOn then
      return
    end
    itemWrapper = getInventoryItemByType(PaGlobal_Purification_All._resultWhereType, PaGlobal_Purification_All._resultSlotIdx)
  else
    itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotIdxForList)
  end
  if nil == itemWrapper then
    return
  end
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
end
function FromClient_Purification_All_Resize()
  if nil == Panel_Purification_All then
    return
  end
  PaGlobal_Purification_All:resize()
end
function HandleEventRUp_Purification_All_DataClear()
  if nil == Panel_Purification_All or false == Panel_Purification_All:GetShow() then
    return
  end
  if true == PaGlobal_Purification_All._isAniStart then
    return
  end
  PaGlobal_Purification_All:dataClear()
end
function FromClient_Purification_All_EnchantSuccess()
  if nil == Panel_Purification_All then
    return
  end
  PaGlobal_Purification_All:audioPostEvent(5, 16, PaGlobal_Purification_All._isConsole)
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PURIFICATION_SUCCESS"))
  PaGlobal_Purification_All._fromSlotOn = false
  PaGlobal_Purification_All._fromSlotIdx = -1
  PaGlobal_Purification_All._fromWhereType = -1
  PaGlobal_Purification_All._resultSlotOn = true
  PaGlobal_Purification_All._itemSlotBg_Icon:clearItem()
  PaGlobal_Purification_All._resultSlotBg_Icon:clearItem()
  PaGlobal_Purification_All._ui._stc_ResultSlotBg:SetMonoTone(false)
  PaGlobal_Purification_All._ui._btn_CheckAniSkip:SetIgnore(false)
  PaGlobal_Purification_All._ui._btn_Radio_Inven:SetIgnore(false)
  PaGlobal_Purification_All._ui._btn_Radio_Ware:SetIgnore(false)
  PaGlobal_Purification_All._ui._btn_Purify_Pc:SetIgnore(false)
  PaGlobal_Purification_All._ui._btn_Purify_Pc:SetMonoTone(false)
  local itemWrapper = getInventoryItemByType(PaGlobal_Purification_All._resultWhereType, PaGlobal_Purification_All._resultSlotIdx)
  if nil == itemWrapper then
    return
  end
  local staticStatus = itemWrapper:getStaticStatus()
  PaGlobal_Purification_All._resultSlotBg_Icon:setItemByStaticStatus(staticStatus, Defines.s64_const.s64_1)
  if true == PaGlobal_Purification_All._isConsole then
    PaGlobal_Purification_All._ui._stc_ResultSlotBg:SetIgnore(false)
    PaGlobal_Purification_All._ui._stc_ItemSlotBg:SetIgnore(false)
    PaGlobal_Purification_All._ui._stc_KeyGuide_Purify:SetShow(true)
    PaGlobal_Purification_All._ui._stc_KeyGuide_Detail:SetShow(true)
    PaGlobal_Purification_All._ui._stc_KeyGuide_Select:SetShow(false)
    Panel_Purification_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, " HandleEventLUp_Purification_All_RequestPurification() ")
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_Purification_All._keyGudieList, PaGlobal_Purification_All._ui._stc_Bottom_KeyGuides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  FromClient_Purification_All_MoneyUpdate()
  PaGlobal_Purification_All:update(true)
end
