function PaGlobalFunc_Tooltip_Control_All_Show(itemStaticStatus, uiBase, isSSW, isItemWrapper, chattingLinkedItem, index, isItemMarket, invenSlotNo, tooltipType, indexForNaming)
  if nil == Panel_Widget_Tooltip_Item_All then
    return
  end
  PaGlobal_Tooltip_Control_All:show(itemStaticStatus, uiBase, isSSW, isItemWrapper, chattingLinkedItem, index, isItemMarket, invenSlotNo, tooltipType, indexForNaming)
end
function PaGlobalFunc_Tooltip_Control_All_ShowLinkedItem(itemStaticStatus, uiBase, isSSW, isItemWrapper, chattingLinkedItem, isClicked)
  PaGlobal_Tooltip_Control_All._dataObject.itemMarket = nil
  PaGlobal_Tooltip_Control_All._dataObject.inventory = nil
  PaGlobal_Tooltip_Control_All._LINKEDTOOLTIP._ui.btn_closeBtn:SetIgnore(false)
  PaGlobal_Tooltip_Control_All._LINKEDCLICKTOOLTIP._ui.btn_closeBtn:SetIgnore(false)
  if isClicked then
    PaGlobal_Tooltip_Control_All:setTooltip(PaGlobal_Tooltip_Control_All._LINKEDCLICKTOOLTIP, itemStaticStatus, isSSW, isItemWrapper, chattingLinkedItem, index)
  else
    PaGlobal_Tooltip_Control_All:setTooltip(PaGlobal_Tooltip_Control_All._LINKEDTOOLTIP, itemStaticStatus, isSSW, isItemWrapper, chattingLinkedItem, index)
  end
  PaGlobal_Tooltip_Control_All:setPosition_LinkedItem(uiBase, isClicked)
end
function PaGlobalFunc_Tooltip_Control_All_ShowWithoutEndurance(itemStaticStatus, uiBase, isSSW, isItemWrapper, chattingLinkedItem, index, isItemMarket, invenSlotNo, TooltipType, indexForNaming)
  PaGlobalFunc_Tooltip_Control_All_Show(itemStaticStatus, uiBase, isSSW, isItemWrapper, chattingLinkedItem, index, isItemMarket, invenSlotNo, TooltipType, indexForNaming)
  PaGlobal_Tooltip_Control_All._NORMALTOOLTIP._ui.txt_useLimit_endurance:SetShow(false)
  PaGlobal_Tooltip_Control_All._NORMALTOOLTIP._ui.stc_useLimit_endurance_gage:SetShow(false)
  PaGlobal_Tooltip_Control_All._NORMALTOOLTIP._ui.progress_useLimit_endurance:SetShow(false)
  PaGlobal_Tooltip_Control_All._NORMALTOOLTIP._ui.progress_useLimit_maxEurance:SetShow(false)
  PaGlobal_Tooltip_Control_All._NORMALTOOLTIP._ui.txt_useLimit_endurance_value:SetShow(false)
  PaGlobal_Tooltip_Control_All._NORMALTOOLTIP._mainPanel:SetSize(PaGlobal_Tooltip_Control_All._NORMALTOOLTIP._mainPanel:GetSizeX(), PaGlobal_Tooltip_Control_All._NORMALTOOLTIP._mainPanel:GetSizeY() - 30)
end
function PaGlobalFunc_Tooltip_Control_All_Hide()
  if nil == Panel_Widget_Tooltip_Item_All then
    return
  end
  if Defines.CloseType.eCloseType_Attacked == getCurrentCloseType() then
    return
  end
  PaGlobal_Tooltip_Control_All:hide()
end
function PaGlobalFunc_Tooltip_Control_All_Refresh(posX, posY)
  if PaGlobal_Tooltip_Control_All._dataObject.currentSlotNo == -2 then
    return
  elseif PaGlobal_Tooltip_Control_All._dataObject.currentSlotNo ~= -1 then
    if PaGlobal_Tooltip_Control_All._dataObject.isNormal then
      PaGlobalFunc_Tooltip_Control_All_ShowGeneralNormal(PaGlobal_Tooltip_Control_All._dataObject.currentSlotNo, PaGlobal_Tooltip_Control_All._dataObject.currentSlotType, true, PaGlobal_Tooltip_Control_All._dataObject.index, posX, posY)
    else
      PaGlobalFunc_Tooltip_Control_All_ShowGeneralStatic(PaGlobal_Tooltip_Control_All._dataObject.currentSlotNo, PaGlobal_Tooltip_Control_All._dataObject.currentSlotType, true, PaGlobal_Tooltip_Control_All._dataObject.index)
    end
  else
    PaGlobalFunc_Tooltip_Control_All_Hide()
  end
end
function PaGlobalFunc_Tooltip_Control_All_InitPanel(panel, target)
  if nil == panel then
    return
  end
  PaGlobal_Tooltip_Control_All:initPanel(panel, target)
end
function PaGlobalFunc_Tooltip_Control_All_SetTextWrap(control)
  if nil == control then
    UI.ASSERT(false, "PaGlobalFunc_Tooltip_Control_All_SetTextWrap(control) , control nil")
    return
  end
  PaGlobal_Tooltip_Control_All:setTextWrap(control)
end
function PaGlobalFunc_Tooltip_Control_All_SetSlotData(slotNo, slot, slotType)
  if nil == PaGlobal_Tooltip_Control_All._dataObject.slotData[slotType] then
    PaGlobal_Tooltip_Control_All._dataObject.slotData[slotType] = {}
  end
  PaGlobal_Tooltip_Control_All._dataObject.slotData[slotType][slotNo] = slot
end
function PaGlobalFunc_Tooltip_Control_All_GetCurrentSlotType()
  return PaGlobal_Tooltip_Control_All._dataObject.currentSlotType
end
function PaGlobalFunc_Tooltip_Control_All_ShowGeneralNormal(slotNo, slotType, isOn, index, targetX, targetY, uiBase, addPosX, addPosY)
  if nil == slotNo then
    return
  end
  PaGlobal_Tooltip_Control_All:showGeneralNormal(slotNo, slotType, isOn, index, targetX, targetY, uiBase, addPosX, addPosY)
end
function PaGlobalFunc_Tooltip_Control_All_ShowGeneralStatic(slotNo, slotType, isOn, index, targetX, targetY)
  if nil == slotNo then
    return
  end
  PaGlobal_Tooltip_Control_All:showGeneralStatic(slotNo, slotType, isOn, index, targetX, targetY)
end
function FromClient_Tooltip_Control_All_ResponseTradePrice(price, key, enchantLevel)
  if nil == key or nil == enchantLevel then
    return
  end
  PaGlobal_Tooltip_Control_All:responseTradePrice(price, key, enchantLevel)
end
function Panel_Tooltip_Item_Show(itemStaticStatus, uiBase, isSSW, isItemWrapper, chattingLinkedItem, index, isItemMarket, invenSlotNo, TooltipType, indexForNaming)
  PaGlobalFunc_Tooltip_Control_All_Show(itemStaticStatus, uiBase, isSSW, isItemWrapper, chattingLinkedItem, index, isItemMarket, invenSlotNo, TooltipType, indexForNaming)
end
function Panel_Tooltip_Item_hideTooltip()
  PaGlobalFunc_Tooltip_Control_All_Hide()
end
function Panel_Tooltip_Item_GetCurrentSlotType()
  PaGlobalFunc_Tooltip_Control_All_GetCurrentSlotType()
end
function Panel_Tooltip_Item_Show_GeneralNormal(slotNo, slotType, isOn, index, targetX, targetY, uiBase, addPosX, addPosY)
  PaGlobalFunc_Tooltip_Control_All_ShowGeneralNormal(slotNo, slotType, isOn, index, targetX, targetY, uiBase, addPosX, addPosY)
end
function Panel_Tooltip_Item_Show_GeneralStatic(slotNo, slotType, isOn, index, posX, posY)
  PaGlobalFunc_Tooltip_Control_All_ShowGeneralStatic(slotNo, slotType, isOn, index, posX, posY)
end
function Panel_Tooltip_Item_SetPosition(slotNo, slot, slotType)
  PaGlobalFunc_Tooltip_Control_All_SetSlotData(slotNo, slot, slotType)
end
function Panel_Tooltip_Item_Refresh(posX, posY)
  PaGlobalFunc_Tooltip_Control_All_Refresh(posX, posY)
end
function Panel_Tooltip_Item_Show_ForChattingLinkedItem(itemStaticStatus, uiBase, isSSW, isItemWrapper, chattingLinkedItem, isClicked)
  PaGlobalFunc_Tooltip_Control_All_ShowLinkedItem(itemStaticStatus, uiBase, isSSW, isItemWrapper, chattingLinkedItem, isClicked)
end
function Panel_Tooltip_Item_chattingLinkedItem_hideTooltip()
  HandleEventLUp_Tooltip_Item_LinkedItem_All_HideTooltip()
end
function Panel_Tooltip_Item_chattingLinkedItemClick_hideTooltip()
  HandleEventLUp_Tooltip_Item_LinkedClickItem_All_HideTooltip()
end
function Panel_Tooltip_Item_Show_WithoutEndurance(itemStaticStatus, uiBase, isSSW, isItemWrapper, chattingLinkedItem, index, isItemMarket, invenSlotNo, TooltipType, indexForNaming)
  PaGlobalFunc_Tooltip_Control_All_ShowWithoutEndurance(itemStaticStatus, uiBase, isSSW, isItemWrapper, chattingLinkedItem, index, isItemMarket, invenSlotNo, TooltipType, indexForNaming)
end
