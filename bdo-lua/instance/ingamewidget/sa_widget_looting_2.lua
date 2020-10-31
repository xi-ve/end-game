function PaGlobal_SA_Widget_Looting_ShowAni()
  if nil == Panel_SA_Looting then
    return
  end
  local panel = Panel_SA_Looting
  local moveAni = panel:addMoveAnimation(0, 0.2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  moveAni:SetStartPosition(panel:GetPosX() + 30, panel:GetPosY())
  moveAni:SetEndPosition(panel:GetPosX(), panel:GetPosY())
end
function PaGlobal_SA_Widget_Looting_HideAni()
  if nil == Panel_SA_Looting then
    return
  end
end
function PaGlobal_SA_Widget_Looting_AddCombinationResultItem(itemKey)
  if nil == Panel_SA_Looting then
    return
  end
  if nil == itemKey then
    return
  end
  FromClient_SA_Widget_Looting_Inventory_AddItem(itemKey, nil, Defines.s64_const.s64_1)
end
function FromClient_SA_Widget_Looting_ReSizePanel()
  if nil == Panel_SA_Looting then
    return
  end
  Panel_SA_Looting:ComputePos()
  PaGlobal_SA_Widget_Looting._ui.stc_lootingBG:ComputePos()
end
function FromClient_SA_Widget_Looting_Inventory_AddItem(itemKey, slotNo, itemCount)
  if nil == Panel_SA_Looting then
    return
  end
  local item = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil == item then
    return
  end
  local currentLog = PaGlobal_SA_Widget_Looting._itemLooting[PaGlobal_SA_Widget_Looting._currentIndex]
  if itemCount > toInt64(0, 1) then
    currentLog.itemName:SetText(item:getName() .. " \239\188\184 " .. tostring(itemCount))
  else
    currentLog.itemName:SetText(item:getName())
  end
  currentLog.itemIcon:setItemByStaticStatus(item, itemCount)
  currentLog.itemBG:SetShow(true)
  PaGlobal_SA_Widget_Looting_ShowAni()
  PaGlobal_SA_Widget_Looting:nameColorbyGrade(PaGlobal_SA_Widget_Looting._currentIndex, item)
  PaGlobal_SA_Widget_Looting:colorSlotBorder(currentLog.itemIcon.border, item)
  PaGlobal_SA_Widget_Looting:fadeIn(PaGlobal_SA_Widget_Looting._currentIndex, 0.2, 0)
  PaGlobal_SA_Widget_Looting:listUp()
  PaGlobal_SA_Widget_Looting._currentIndex = PaGlobal_SA_Widget_Looting._currentIndex - 1
  if PaGlobal_SA_Widget_Looting._currentIndex < 1 then
    PaGlobal_SA_Widget_Looting._currentIndex = PaGlobal_SA_Widget_Looting._maxLootingCnt - 1
  end
end
