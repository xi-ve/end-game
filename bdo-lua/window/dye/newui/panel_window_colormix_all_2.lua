function InputMLUp_ColorMix_All_MixColor()
  local slotList = PaGlobal_ColorMix._slotList
  if nil == slotList[1].itemWhereType or nil == slotList[2].itemWhereType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_COLORBALENCE_COMBINEDYEITEM"))
    return
  end
  ToClient_CombineDyeItem(slotList[1].itemWhereType, slotList[1].slotNo, slotList[2].itemWhereType, slotList[2].slotNo)
end
function InputMRUp_ColorMix_All_InvenRClick(slotNo, itemWrapper, itemCount, currentWhereType)
  local _slotList = PaGlobal_ColorMix._slotList
  if not _slotList[1].icon:GetShow() then
    _slotList[1]:setItemByStaticStatus(itemWrapper:getStaticStatus(), itemWrapper:get():getCount_s64())
    _slotList[1].icon:SetShow(true)
    _slotList[1].slotNo = slotNo
    _slotList[1].itemWhereType = currentWhereType
  elseif not _slotList[2].icon:GetShow() then
    if 1 == tonumber(_slotList[1].count:GetText()) and _slotList[1].slotNo == slotNo then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_COLORBALENCE_INVENRCLICK"))
      return
    end
    _slotList[2]:setItemByStaticStatus(itemWrapper:getStaticStatus(), itemWrapper:get():getCount_s64())
    _slotList[2].icon:SetShow(true)
    _slotList[2].slotNo = slotNo
    _slotList[2].itemWhereType = currentWhereType
  else
    if 1 == tonumber(_slotList[1].count:GetText()) and _slotList[1].slotNo == slotNo then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_COLORBALENCE_INVENRCLICK"))
      return
    end
    _slotList[2]:setItemByStaticStatus(itemWrapper:getStaticStatus(), itemWrapper:get():getCount_s64())
    _slotList[2].icon:SetShow(true)
    _slotList[2].slotNo = slotNo
    _slotList[2].itemWhereType = currentWhereType
  end
  PaGlobal_ColorMix._ui.stc_Arrow:SetColor(Defines.Color.C_FFFFFFFF)
  _slotList[3].icon:SetShow(false)
  _slotList[3]:clearItem()
end
function InputMRUp_ColorMix_All_SlotRClick(index)
  local _slotList = PaGlobal_ColorMix._slotList
  _slotList[index].icon:SetShow(false)
  _slotList[index]:clearItem()
  _slotList[index].itemWhereType = nil
  _slotList[index].slotNo = nil
  local tooltipPanel
  if true == _ContentsGroup_NewUI_Tooltip_All then
    tooltipPanel = Panel_Widget_Tooltip_Item_All
  else
    tooltipPanel = Panel_Tooltip_Item
  end
  if tooltipPanel:GetShow() then
    InputMOut_ColorMix_All_HideTooltip()
  end
end
function InputMLUp_ColorMix_All_DropHandler(index)
  if nil == DragManager.dragStartPanel then
    return false
  end
  local _slotList = PaGlobal_ColorMix._slotList
  local fromSlotNo = DragManager.dragSlotInfo
  local inventoryPanel
  if true == _ContentsGroup_NewUI_Inventory_All then
    inventoryPanel = Panel_Window_Inventory_All
  else
    inventoryPanel = Panel_Window_Inventory
  end
  if inventoryPanel == DragManager.dragStartPanel then
    local itemWrapper = getInventoryItemByType(DragManager.dragWhereTypeInfo, DragManager.dragSlotInfo)
    if nil == itemWrapper then
      return false
    end
    _slotList[index]:setItemByStaticStatus(itemWrapper:getStaticStatus(), itemWrapper:get():getCount_s64())
    _slotList[index].icon:SetShow(true)
    _slotList[index].slotNo = DragManager.dragSlotInfo
    _slotList[index].itemWhereType = DragManager.dragWhereTypeInfo
    _slotList[3].icon:SetShow(false)
    _slotList[3]:clearItem()
    DragManager:clearInfo()
    return true
  end
  return false
end
function InputMOn_ColorMix_All_ShowTooltip(index)
  local _slotList = PaGlobal_ColorMix._slotList
  if nil ~= _slotList and nil ~= _slotList[index].itemWhereType and nil ~= _slotList[index].slotNo then
    local itemWrapper = getInventoryItemByType(_slotList[index].itemWhereType, _slotList[index].slotNo)
    if nil ~= itemWrapper then
      Panel_Tooltip_Item_Show(itemWrapper:getStaticStatus(), _slotList[index].icon, true, false)
    end
  end
end
function InputMOn_ColorMix_All_SetKeyGuideX(index)
  local _slotList = PaGlobal_ColorMix._slotList
  PaGlobal_ColorMix._ui_console.stc_keyGuideX:SetShow(false)
  if nil ~= _slotList and nil ~= _slotList[index].itemWhereType and nil ~= _slotList[index].slotNo then
    local itemWrapper = getInventoryItemByType(_slotList[index].itemWhereType, _slotList[index].slotNo)
    if nil ~= itemWrapper then
      PaGlobal_ColorMix._ui_console.stc_keyGuideX:SetShow(true)
    end
  end
end
function InputMOut_ColorMix_All_HideTooltip()
  Panel_Tooltip_Item_hideTooltip()
end
function FromClient_ColorMix_All_SlotUpdate(itemWhereType, itemSlotNo)
  local itemWrapper
  local _slotList = PaGlobal_ColorMix._slotList
  for index = 1, PaGlobal_ColorMix._slotCount - 1 do
    itemWrapper = getInventoryItemByType(_slotList[index].itemWhereType, _slotList[index].slotNo)
    if nil ~= itemWrapper then
      _slotList[index]:setItemByStaticStatus(itemWrapper:getStaticStatus(), itemWrapper:get():getCount_s64())
    else
      _slotList[index].icon:SetShow(false)
      _slotList[index]:clearItem()
    end
  end
  itemWrapper = getInventoryItemByType(itemWhereType, itemSlotNo)
  if nil ~= itemWrapper then
    _slotList[3]:setItemByStaticStatus(itemWrapper:getStaticStatus(), 1)
    _slotList[3].icon:SetShow(true)
    _slotList[3].slotNo = itemSlotNo
    _slotList[3].itemWhereType = itemWhereType
    PaGlobal_ColorMix._ui.stc_Arrow:SetColor(itemWrapper:getStaticStatus():get():getItemColor())
    PaGlobal_Dye_All:updateAmpleSlotList()
    Inventory_updateSlotData()
  end
end
function FromClient_ColorMix_All_RestoreFlush(prevRenderModeList, nextRenderModeList)
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  if Panel_Window_ColorMix_All:GetShow() then
    Inventory_SetFunctor(PaGlobal_ColorMix_All_InvenFilter_IsDyeItem, InputMRUp_ColorMix_All_InvenRClick, PaGlobal_ColorMix_All_Clsoe, nil)
  end
end
function PaGlobal_ColorMix_All_Show()
  PaGlobal_ColorMix:prepareOpen()
end
function PaGlobal_ColorMix_All_Clsoe()
  PaGlobal_ColorMix:prepareClose()
end
function PaGlobal_ColorMix_All_InvenFilter_IsDyeItem(slotNo, itemWrapper, currentWhereType)
  if nil == itemWrapper then
    return true
  end
  local isAble = ToClient_IsDyeItem(currentWhereType, slotNo)
  return not isAble
end
function PaGlobal_ColorMix_ShowAni()
  Panel_Window_ColorMix_All:SetAlpha(0)
  UIAni.AlphaAnimation(1, Panel_Window_ColorMix_All, 0, 0.15)
  local scaleAni = Panel_Window_ColorMix_All:addScaleAnimation(0, 0.2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  scaleAni:SetStartScale(0.8)
  scaleAni:SetEndScale(1)
  scaleAni.AxisX = Panel_Window_ColorMix_All:GetPosX() / 2
  scaleAni.AxisY = Panel_Window_ColorMix_All:GetPosY() / 2
  scaleAni.IsChangeChild = true
end
function PaGlobal_ColorMix_HideAni()
  Panel_Window_ColorMix_All:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Window_ColorMix_All, 0, 0.12)
  aniInfo:SetHideAtEnd(true)
  local scaleAni2 = Panel_Window_ColorMix_All:addScaleAnimation(0, 0.12, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  scaleAni2:SetStartScale(1)
  scaleAni2:SetEndScale(0.8)
  scaleAni2.AxisX = Panel_Window_ColorMix_All:GetPosX() / 2
  scaleAni2.AxisY = Panel_Window_ColorMix_All:GetPosY() / 2
  scaleAni2.IsChangeChild = true
end
