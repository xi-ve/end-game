function FromClient_SimpleInventory_LoadCompleteSimpleItem(characterNo_s64)
  PaGlobal_SimpleInventory:open(characterNo_s64)
end
function HandleEventScroll_SimpleInventory(isUp)
  local self = PaGlobal_SimpleInventory
  self._currentIndex = UIScroll.ScrollEvent(self._ui._scroll, isUp, self._config._slotRows, self._config._inventoryMax, self._currentIndex, self._config._slotCols)
  self:updateSlot()
end
function HandleEventLUp_SimpleInventory_SortItem()
  PaGlobal_SimpleInventory:sortItem()
end
function HandleEventLUp_SimpleInventory_ChangeCharacter(isNext)
  local changeIndex = PaGlobal_SimpleInventory._selectedCharacterIndex
  if true == isNext then
    changeIndex = changeIndex + 1
  else
    changeIndex = changeIndex - 1
  end
  if changeIndex == PaGlobal_SimpleInventory._currentCharacterIndex then
    if true == isNext then
      changeIndex = changeIndex + 1
    else
      changeIndex = changeIndex - 1
    end
  end
  local data = getCharacterDataByIndex(changeIndex)
  if nil == data then
    return
  end
  PaGlobal_SimpleInventory:requestSimpleInventory(changeIndex)
end
function HandleEventOnOut_SimpleInventory_EquipmentTooltip(slotNo, isOn)
  Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "simpleEquipment", isOn, PaGlobal_SimpleInventory._selectedCharacterNo)
end
function HandleEventOnOut_SimpleInventory_EmptySlotTooltip(slotNo, isOn)
  local control = PaGlobal_SimpleInventory._ui.stc_blankSlotTooltip
  if nil == control then
    return
  end
  if true == isOn then
    local equipSlot = PaGlobal_SimpleInventory._equipSlot[slotNo]
    if nil == equipSlot then
      return
    end
    control:SetText(PaGlobal_SimpleInventory._slotNoIdToString[slotNo])
    if __eClassType_ShyWaman == PaGlobal_SimpleInventory._selectedCharacterClassType then
      if CppEnums.EquipSlotNo.awakenWeapon == slotNo then
        control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SHY_AWAKENWEAPON"))
      elseif CppEnums.EquipSlotNo.avatarAwakenWeapon == slotNo then
        control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SHY_AWAKENWEAPON_CASH"))
      end
    end
    local gap = 30
    control:SetSize(control:GetTextSizeX() + gap, control:GetSizeY())
    control:SetPosX(PaGlobal_SimpleInventory._ui.stc_circle:GetPosX() + equipSlot.icon:GetPosX() - control:GetTextSizeX())
    control:SetPosY(PaGlobal_SimpleInventory._ui.stc_circle:GetPosY() + equipSlot.icon:GetPosY())
    if control:GetPosX() < 0 then
      control:SetPosX(0)
    end
    control:SetShow(true)
  else
    control:SetShow(false)
  end
end
function PaGlobalFunc_SimpleInventory_ItemComparer(ii, jj)
  return Global_ItemComparer(ii, jj, PaGlobalFunc_SimpleInventory_GetSimpleItemWrapper, nil, true)
end
function PaGlobalFunc_SimpleInventory_GetInventoryType()
  return PaGlobal_SimpleInventory._itemWhereType
end
function PaGlobalFunc_SimpleInventory_GetSelectedCharacterNo()
  return PaGlobal_SimpleInventory._selectedCharacterNo
end
function PaGlobalFunc_SimpleInventory_GetSimpleItemWrapper(slotNo)
  return PaGlobal_SimpleInventory._invenWrapper:getSimpleItemWrapper(PaGlobalFunc_SimpleInventory_GetInventoryType(), slotNo)
end
function PaGlobalFunc_SimpleInventory_SelectInventoryForConsole(isLeft)
  if true == isLeft then
    PaGlobal_SimpleInventory._selectedTab = PaGlobal_SimpleInventory._selectedTab - 1
    if PaGlobal_SimpleInventory._selectedTab < 0 then
      PaGlobal_SimpleInventory._selectedTab = PaGlobal_SimpleInventory._maxTabCount - 1
    end
  else
    PaGlobal_SimpleInventory._selectedTab = PaGlobal_SimpleInventory._selectedTab + 1
    if PaGlobal_SimpleInventory._selectedTab >= PaGlobal_SimpleInventory._maxTabCount then
      PaGlobal_SimpleInventory._selectedTab = 0
    end
  end
  if 0 == PaGlobal_SimpleInventory._selectedTab then
    PaGlobal_SimpleInventory._ui._rdoBtn_inven:SetCheck(true)
    PaGlobal_SimpleInventory._ui._rdoBtn_cashInven:SetCheck(false)
    PaGlobal_SimpleInventory:selectInventroy(CppEnums.ItemWhereType.eInventory)
  else
    PaGlobal_SimpleInventory._ui._rdoBtn_inven:SetCheck(false)
    PaGlobal_SimpleInventory._ui._rdoBtn_cashInven:SetCheck(true)
    PaGlobal_SimpleInventory:selectInventroy(CppEnums.ItemWhereType.eCashInventory)
  end
end
function PaGlobalFunc_SimpleInventory_SortItemForConsole()
  PaGlobal_SimpleInventory._ui._btn_SortItem:SetCheck(not PaGlobal_SimpleInventory._ui._btn_SortItem:IsCheck())
  PaGlobal_SimpleInventory:updateSortKeyguide()
  PaGlobal_SimpleInventory:sortItem()
end
function PaGlobalFunc_SimpleInventory_ShowItemTooltipForConsole(itemEnchantKey)
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
  if nil ~= itemSSW then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
  PaGlobalFunc_FloatingTooltip_Close()
end
function PaGlobalFunc_SimpleInventory_ShowEquipItemTooltipForConsole(slotNo)
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  local equipItemWrapper = PaGlobal_SimpleInventory._equipWrapper:getSimpleEquipItemWrapper(slotNo)
  if nil == equipItemWrapper then
    return
  end
  local itemWrapper = equipItemWrapper:getItem()
  if nil ~= itemWrapper then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
  PaGlobalFunc_FloatingTooltip_Close()
end
function PAGlobalFunc_SimpleInventory_ShowCrystalInfoForConsole()
  if false == PaGlobal_SimpleInventory._isConsole then
    return
  end
  PaGlobal_InventoryEquip_Detail_Renew_Open_BySimpleInventory()
end
