function PaGlobalFunc_DropItem_All_Open()
  if nil == Panel_Window_DropItem_All then
    return
  end
  PaGlobal_DropItem_All:prepareOpen()
end
function PaGlobalFunc_DropItem_All_Close()
  if nil == Panel_Window_DropItem_All then
    return
  end
  if true == PaGlobal_DropItem_All._isConsole then
    if true == PaGlobal_DropItem_All._isTargetChange then
      PaGlobalFunc_DropItem_All_ChangeToTarget()
    else
      PaGlobal_DropItem_All:prepareClose()
    end
  else
    PaGlobal_DropItem_All:prepareClose()
  end
end
function PaGlobalFunc_DropItem_All_UpdateRegionButton(content, key)
  if nil == Panel_Window_DropItem_All then
    return
  end
  local regionButton = UI.getChildControl(content, "RadioButton_RegionName")
  regionButton:SetTextMode(__eTextMode_AutoWrap)
  regionButton:setNotImpactScrollEvent(true)
  local regionKey = Int64toInt32(key)
  if PaGlobal_DropItem_All._selectedRegionKey == regionKey then
    regionButton:SetCheck(true)
  else
    regionButton:SetCheck(false)
  end
  local regionInfo = getRegionInfoWrapper(regionKey)
  if nil ~= regionInfo then
    local regionName = regionInfo:getAreaName()
    regionButton:SetText(regionName)
    regionButton:addInputEvent("Mouse_LUp", "HandleEventLUp_DropItem_All_SelectRegion(" .. regionKey .. ")")
    if true == PaGlobal_DropItem_All._isConsole then
      regionButton:addInputEvent("Mouse_On", "HandleEventOn_DropItem_All_SetIsTargetChange(false)")
    end
  end
end
function HandleEventLUp_DropItem_All_SelectRegion(regionKey)
  if nil == Panel_Window_DropItem_All then
    return
  end
  PaGlobal_DropItem_All:Select_Region(regionKey)
end
function HandleEventOn_DropItem_All_ItemTooltip_Show(typeIndex, slotIndex)
  if nil == Panel_Window_DropItem_All then
    return
  end
  PaGlobal_DropItem_All:ItemTooltip_Show(typeIndex, slotIndex)
end
function HandleEventOut_DropItem_All_ItemTooltip_Hide()
  if nil == Panel_Window_DropItem_All then
    return
  end
  PaGlobal_DropItem_All:ItemTooltip_Hide()
end
function HandleEventLUp_DropItem_All_SetNavi()
  if nil == Panel_Window_DropItem_All then
    return
  end
  PaGlobal_DropItem_All:SetNavi()
end
function HandleEventOn_DropItem_All_SetIsTargetChange(isSnapRight)
  if nil == Panel_Window_DropItem_All then
    return
  end
  if isSnapRight == PaGlobal_DropItem_All._isTargetChange then
    return
  end
  PaGlobal_DropItem_All._isTargetChange = isSnapRight
  PaGlobal_DropItem_All:updateConsoleKey(isSnapRight)
end
function HandleEventPad_DropItem_All_ShowDetailTooltip(typeIndex, slotIndex)
  if nil ~= Panel_Widget_Tooltip_Renew and PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local slot = PaGlobal_DropItem_All._ui._slot[typeIndex][slotIndex]
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(PaGlobal_DropItem_All._itemKeyByType[typeIndex][slotIndex + 1]))
  _PA_LOG("\236\178\156\235\167\140\234\184\176", "showDetail typeIndex = " .. tostring(typeIndex) .. " / slotIndex = " .. tostring(slotIndex) .. " / itemSSW = " .. tostring(itemSSW))
  if nil == itemSSW then
    return
  end
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  PaGlobalFunc_FloatingTooltip_Close()
end
function FromClient_DropItem_All_PanelResize()
  PaGlobal_DropItem_All:resize()
end
function PaGlobalFunc_DropItem_All_ChangeToTarget()
  if nil == Panel_Window_DropItem_All then
    return
  end
  ToClient_padSnapChangeToTarget(PaGlobal_DropItem_All._currentButton)
end
