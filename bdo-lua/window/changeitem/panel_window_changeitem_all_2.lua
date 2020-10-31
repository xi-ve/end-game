function PaGlobalFunc_ChangeItem_All_Open(whereType, slotNo)
  PaGlobal_ChangeItem_All:prepareOpen(whereType, slotNo)
end
function PaGlobalFunc_ChangeItem_All_Close()
  PaGlobal_ChangeItem_All:prepareClose()
end
function HandleEventLUp_ChangeItem_All_Apply()
  PaGlobal_ChangeItem_All:applyChangeItem()
end
function HandleEventRUp_ChangeItem_All_InvenRClick(slotNo, itemWrapper, count_s64, inventoryType)
  if nil == slotNo or nil == itemWrapper then
    _PA_ASSERT_NAME(false, "slotNo \235\152\144\235\138\148 itemWrapper\234\176\128 \235\185\132\236\131\129\236\160\129\236\158\133\235\139\136\235\139\164.", "\236\160\149\236\167\128\237\152\156")
    return
  end
  PaGlobal_ChangeItem_All._selectedItemSlotNo = slotNo
  PaGlobal_ChangeItem_All._selectedItemWhereType = inventoryType
  PaGlobal_ChangeItem_All._elapsTime = 0
  PaGlobal_ChangeItem_All._equipSlot:clearItem()
  PaGlobal_ChangeItem_All._equipSlot:setItem(itemWrapper)
  PaGlobal_ChangeItem_All._ui_pc.btn_apply:SetMonoTone(false)
  PaGlobal_ChangeItem_All._ui_pc.btn_apply:SetEnable(true)
  PaGlobal_ChangeItem_All._ui_pc.btn_apply:SetIgnore(false)
  local itemKey = itemWrapper:get():getKey()
  local toItemWrapper = getExchangeItem(inventoryType, slotNo, PaGlobal_ChangeItem_All._materialItemWhereType, PaGlobal_ChangeItem_All._materialItemSlotNo)
  if nil ~= toItemWrapper then
    PaGlobal_ChangeItem_All._resultItemKey = toItemWrapper:get():getKey():getItemKey()
    PaGlobal_ChangeItem_All._resultSlot:clearItem()
    PaGlobal_ChangeItem_All._resultSlot:setItemByStaticStatus(toItemWrapper:getStaticStatus(), 1, nil, nil, true)
    PaGlobal_ChangeItem_All._resultSlot.icon:SetMonoTone(true)
    ToClient_padSnapSetTargetPanel(Panel_Window_ChangeItem_All)
    PaGlobal_ChangeItem_All:resize()
  end
end
function HandleEventOnOut_ChangeItem_All_IconOver(isShow, controlId)
  if false == isShow or nil == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local control
  if 0 == controlId then
    if nil == PaGlobal_ChangeItem_All._selectedItemWhereType or nil == PaGlobal_ChangeItem_All._selectedItemSlotNo then
      return
    end
    control = PaGlobal_ChangeItem_All._equipSlot.icon
    local itemWrapper = getInventoryItemByType(PaGlobal_ChangeItem_All._selectedItemWhereType, PaGlobal_ChangeItem_All._selectedItemSlotNo)
    Panel_Tooltip_Item_Show(itemWrapper, control, false, true, nil, nil, nil, nil, "WeaponChange", PaGlobal_ChangeItem_All._selectedItemSlotNo)
  elseif 1 == controlId then
    control = PaGlobal_ChangeItem_All._resultSlot.icon
    local toItemWrapper = getExchangeItem(PaGlobal_ChangeItem_All._selectedItemWhereType, PaGlobal_ChangeItem_All._selectedItemSlotNo, PaGlobal_ChangeItem_All._materialItemWhereType, PaGlobal_ChangeItem_All._materialItemSlotNo)
    if nil ~= toItemWrapper then
      local itemSSW = toItemWrapper:getStaticStatus()
      Panel_Tooltip_Item_Show(itemSSW, control, true, false, nil, nil, nil)
    end
  else
    return
  end
end
function PadEventXUp_ChangeItem_All_ItemToolTip(controlId)
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local control
  if 0 == controlId then
    if nil == PaGlobal_ChangeItem_All._selectedItemWhereType or nil == PaGlobal_ChangeItem_All._selectedItemSlotNo then
      return
    end
    control = PaGlobal_ChangeItem_All._equipSlot.icon
    local itemWrapper = getInventoryItemByType(PaGlobal_ChangeItem_All._selectedItemWhereType, PaGlobal_ChangeItem_All._selectedItemSlotNo)
    if nil ~= itemWrapper then
      if PaGlobal_ChangeItem_All._isConsole then
        PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0)
      else
        PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0)
      end
    end
  elseif 1 == controlId then
    control = PaGlobal_ChangeItem_All._resultSlot.icon
    local toItemWrapper = getExchangeItem(PaGlobal_ChangeItem_All._selectedItemWhereType, PaGlobal_ChangeItem_All._selectedItemSlotNo, PaGlobal_ChangeItem_All._materialItemWhereType, PaGlobal_ChangeItem_All._materialItemSlotNo)
    if nil ~= toItemWrapper then
      if PaGlobal_ChangeItem_All._isConsole then
        PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, toItemWrapper, Defines.TooltipTargetType.Item, 0)
      else
        local itemSSW = toItemWrapper:getStaticStatus()
        PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0)
      end
    end
  else
    return
  end
end
function HandleEventRUp_ChangeItem_All_EquipSlotClear()
  if nil == PaGlobal_ChangeItem_All._selectedItemWhereType or nil == PaGlobal_ChangeItem_All._selectedItemSlotNo then
    return
  end
  PaGlobal_ChangeItem_All:clearAllSlot()
end
function FromClient_UseItemExchangeToClass_ChangeItem_All(whereType, slotNo)
  PaGlobalFunc_ChangeItem_All_Open(whereType, slotNo)
end
function FromClient_UseItemExchangeToClassNotify_ChangeItem_All()
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(PaGlobal_ChangeItem_All._resultItemKey))
  if nil ~= itemSSW then
    local originString = "[" .. itemSSW:getName() .. "]"
    local itemString = PAGlobalFunc_ReturnAppliedItemColorTextForNewUI(originString, itemSSW)
    Proc_ShowMessage_Ack(itemString .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_CHANGEWEAPON_SUCCESS_CHANGEITEM"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHANGEWEAPON_SUCCESS_CHANGEITEM"))
  end
  Panel_Window_ChangeItem_All:ignorePadSnapUpdate(false)
  PaGlobal_ChangeItem_All._resultItemKey = nil
  PaGlobalFunc_ChangeItem_All_Close()
end
function PaGlobalFunc_ChangeItem_All_SetFilter(slotNo, itemWrapper, whereType)
  local itemKey = itemWrapper:get():getKey()
  local changeItemWrapper = getExchangeItem(whereType, slotNo, PaGlobal_ChangeItem_All._materialItemWhereType, PaGlobal_ChangeItem_All._materialItemSlotNo)
  if nil == changeItemWrapper then
    return true
  else
    local itemSSW = changeItemWrapper:getStaticStatus()
    local equipType = itemSSW:getEquipType()
    local itemWrapper = getInventoryItemByType(PaGlobal_ChangeItem_All._materialItemWhereType, PaGlobal_ChangeItem_All._materialItemSlotNo)
    local filterClassType = itemWrapper:getStaticStatus():getContentsEventParam1()
    local classType = getSelfPlayer():getClassType()
    local itemStaticStatus = getInventoryItemByType(whereType, slotNo):getStaticStatus()
    if -1 == filterClassType then
      if __eClassType_NinjaMan == classType then
        if 56 == equipType then
          return false
        end
      elseif __eClassType_Kunoichi == classType and 55 == equipType then
        return false
      end
      return itemStaticStatus:get()._usableClassType:isOn(classType)
    else
      if __eClassType_NinjaMan == filterClassType then
        if 56 == equipType then
          return false
        end
      elseif __eClassType_Kunoichi == filterClassType and 55 == equipType then
        return false
      end
      return itemStaticStatus:get()._usableClassType:isOn(filterClassType)
    end
  end
end
function PaGlobalFunc_ChangeItem_All_SetFilterIgnore()
  return true
end
function PaGlobalFunc_ChangeItem_All_updateTime(deltaTime)
  PaGlobal_ChangeItem_All._elapsTime = PaGlobal_ChangeItem_All._elapsTime + deltaTime
  if PaGlobal_ChangeItem_All._sound_ani_time < PaGlobal_ChangeItem_All._elapsTime and true == PaGlobal_ChangeItem_All._sound_ani_flag then
    if nil == PaGlobal_ChangeItem_All._selectedItemSlotNo or nil == PaGlobal_ChangeItem_All._selectedItemWhereType or false == PaGlobal_ChangeItem_All._doChange then
      return
    end
    audioPostEvent_SystemUi(5, 79)
    PaGlobal_ChangeItem_All._sound_ani_flag = false
  end
  if PaGlobal_ChangeItem_All._effect_ani_time < PaGlobal_ChangeItem_All._elapsTime then
    if nil == PaGlobal_ChangeItem_All._selectedItemSlotNo or nil == PaGlobal_ChangeItem_All._selectedItemWhereType or false == PaGlobal_ChangeItem_All._doChange then
      return
    end
    PaGlobal_ChangeItem_All._resultSlot.icon:AddEffect("UI_ItemEnchant01", false, -5, -5)
    exchangeItemToClass(PaGlobal_ChangeItem_All._selectedItemWhereType, PaGlobal_ChangeItem_All._selectedItemSlotNo, PaGlobal_ChangeItem_All._materialItemWhereType, PaGlobal_ChangeItem_All._materialItemSlotNo)
    PaGlobal_ChangeItem_All._doChange = false
    PaGlobal_ChangeItem_All._isChangeDoing = false
  end
  if PaGlobal_ChangeItem_All._effect_ani_time + 1 < PaGlobal_ChangeItem_All._elapsTime then
    PaGlobal_ChangeItem_All._elapsTime = 0
  end
end
function PaGlobalFunc_ChangeItem_All_ShowAni()
  UIAni.fadeInSCR_Down(Panel_Window_ChangeItem_All)
  local aniInfo1 = Panel_Window_ChangeItem_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_Window_ChangeItem_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_ChangeItem_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_ChangeItem_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_ChangeItem_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_ChangeItem_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobalFunc_ChangeItem_All_HideAni()
  Panel_Window_ChangeItem_All:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Window_ChangeItem_All, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
