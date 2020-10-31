function HandleEventOnOut_Manufacture_Notify_All_ShowItemTooltip(isShow, index, isResult)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemKey, uiBase
  if isResult then
    itemKey = PaGlobal_Manufacture_Notify_All._data_Result[index]._key
    uiBase = PaGlobal_Manufacture_Notify_All._icon_ResultBG[index]
  elseif false == isResult then
    itemKey = PaGlobal_Manufacture_Notify_All._data_Resource[index]._key
    uiBase = PaGlobal_Manufacture_Notify_All._icon_ResourceBG[index]
  end
  if nil == itemKey or nil == uiBase then
    return
  end
  local staticStatusWrapper = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil == staticStatusWrapper then
    return
  end
  Panel_Tooltip_Item_Show(staticStatusWrapper, uiBase, true, false)
end
function PaGlobalFunc_Manufacture_Notify_All_CheckNotify()
  if true == Panel_Manufacture_Notify:GetShow() and 0 == #PaGlobal_Manufacture_Notify_All._data_Resource then
    Panel_Manufacture_Notify:SetShow(false)
  end
end
function PaGlobalFunc_Manufacture_Notify_All_IsManufactureChk(variableName, value)
  if variableName == "IsManufactureChk" then
    if value == 0 then
      Panel_Manufacture_Notify:SetShow(false)
      PaGlobal_Manufacture_Notify_All:clear()
    else
      Panel_Manufacture_Notify:SetShow(true)
      PaGlobal_Manufacture_Notify_All:SetPos()
      local manufactureName = PaGlobal_Manufacture_All_GetCurrentManufactureName()
      if nil ~= manufactureName then
        PaGlobal_Manufacture_Notify_All._ui.txt_typeName:SetText(manufactureName)
      end
      local materialItemWhereType = PaGlobal_Manufacture_All_GetCurrentMaterialWhereType()
      PaGlobalFunc_Manufacture_Notify_All_Progress_Update(materialItemWhereType)
    end
    CheckChattingInput()
  else
    Panel_Manufacture_Notify:SetShow(false)
    PaGlobal_Manufacture_Notify_All:clear()
  end
end
function PaGlobalFunc_Manufacture_Notify_All_Progress_Update(materialItemWhereType)
  local progressRate = 0
  local currentInventoryType = Inventory_GetCurrentInventoryType()
  for key, value in pairs(PaGlobal_Manufacture_Notify_All._data_Resource) do
    local index = key
    local _name = value._name
    local _originalCnt = value._originalCnt
    local _currentCnt = value._currentCnt
    local _iconPath = value._iconPath
    local _param = 0
    local _rate = 0
    if 0 ~= PaGlobal_Manufacture_Notify_All._successCount then
      _param = PaGlobal_Manufacture_Notify_All._successCount / math.floor(_originalCnt / ((_originalCnt - _currentCnt) / PaGlobal_Manufacture_Notify_All._successCount))
      _rate = math.floor(_param * 100)
    end
    PaGlobal_Manufacture_Notify_All:createResourceControl(index)
    PaGlobal_Manufacture_Notify_All._item_Resource[index]:SetText(_name .. " (" .. _currentCnt .. ")")
    PaGlobal_Manufacture_Notify_All._icon_Resource[index]:ChangeTextureInfoName(_iconPath)
    PaGlobal_Manufacture_Notify_All._item_Resource[index]:SetShow(true)
    PaGlobal_Manufacture_Notify_All._icon_Resource[index]:SetShow(true)
    PaGlobal_Manufacture_Notify_All._icon_ResourceBG[index]:SetShow(true)
    PaGlobal_Manufacture_Notify_All._icon_ResourceBG[index]:SetEnableArea(0, 0, PaGlobal_Manufacture_Notify_All._icon_ResourceBG[index]:GetSizeX() + PaGlobal_Manufacture_Notify_All._item_Resource[index]:GetTextSizeX(), PaGlobal_Manufacture_Notify_All._icon_ResourceBG[index]:GetSizeY())
    if progressRate < _rate and 0 < _rate then
      progressRate = _rate
    end
  end
  if 0 < PaGlobal_Manufacture_Notify_All._successCount then
    PaGlobal_Manufacture_Notify_All._ui.progress_manufacture:SetSmoothMode(true)
  end
  PaGlobal_Manufacture_Notify_All._ui.progress_manufacture:SetProgressRate(progressRate)
  PaGlobal_Manufacture_Notify_All._ui.txt_progressText:SetText(progressRate .. "%")
  for key, value in pairs(PaGlobal_Manufacture_Notify_All._data_Result) do
    local index = key
    local _name = value._name
    local _iconPath = value._iconPath
    local _currentCnt = value._currentCnt
    PaGlobal_Manufacture_Notify_All:createResultControl(index)
    PaGlobal_Manufacture_Notify_All._item_Result[index]:SetText(_name .. " (" .. _currentCnt .. ")")
    PaGlobal_Manufacture_Notify_All._icon_Result[index]:ChangeTextureInfoName(_iconPath)
    PaGlobal_Manufacture_Notify_All._item_Result[index]:SetShow(true)
    PaGlobal_Manufacture_Notify_All._icon_Result[index]:SetShow(true)
    PaGlobal_Manufacture_Notify_All._icon_ResultBG[index]:SetShow(true)
    PaGlobal_Manufacture_Notify_All._icon_ResultBG[index]:SetEnableArea(-PaGlobal_Manufacture_Notify_All._item_Result[index]:GetTextSizeX(), 0, PaGlobal_Manufacture_Notify_All._icon_ResultBG[index]:GetSizeX(), PaGlobal_Manufacture_Notify_All._icon_ResultBG[index]:GetSizeY())
  end
  if 0 < #PaGlobal_Manufacture_Notify_All._data_Result then
    PaGlobal_Manufacture_Notify_All._ui.txt_resultTitle:SetSpanSize(PaGlobal_Manufacture_Notify_All._ui.txt_resultTitle:GetSpanSize().x, PaGlobal_Manufacture_Notify_All._ui_template.txt_resultItem:GetSpanSize().y - PaGlobal_Manufacture_Notify_All._gapY * #PaGlobal_Manufacture_Notify_All._data_Result)
    PaGlobal_Manufacture_Notify_All._ui.txt_resultTitle:SetShow(true)
  else
    PaGlobal_Manufacture_Notify_All._ui.txt_resultTitle:SetShow(false)
  end
end
function PaGlobalFunc_Manufacture_Notify_All_ResponseResultItem(itemDynamicListWrapper, failReason)
  local size = itemDynamicListWrapper:getSize()
  if 0 < size then
    PaGlobal_Manufacture_Notify_All._failCount = 0
    PaGlobal_Manufacture_Notify_All._successCount = PaGlobal_Manufacture_Notify_All._successCount + 1
    for index = 0, size - 1 do
      local itemDynamicInformationWrapper = itemDynamicListWrapper:getElement(index)
      local ItemEnchantStaticStatusWrapper = itemDynamicInformationWrapper:getStaticStatus()
      local itemKey = ItemEnchantStaticStatusWrapper:get()._key:getItemKey()
      local s64_stackCount = Int64toInt32(itemDynamicInformationWrapper:getCount_s64())
      local idx
      local count = #PaGlobal_Manufacture_Notify_All._data_Result
      if 0 < count then
        for index = 1, count do
          if PaGlobal_Manufacture_Notify_All._data_Result[index]._key == itemKey then
            idx = index
          end
        end
      end
      if nil == idx then
        idx = #PaGlobal_Manufacture_Notify_All._data_Result + 1
        PaGlobal_Manufacture_Notify_All._data_Result[idx] = {}
        PaGlobal_Manufacture_Notify_All._data_Result[idx]._key = itemKey
        PaGlobal_Manufacture_Notify_All._data_Result[idx]._name = ItemEnchantStaticStatusWrapper:getName()
        PaGlobal_Manufacture_Notify_All._data_Result[idx]._iconPath = "Icon/" .. ItemEnchantStaticStatusWrapper:getIconPath()
        PaGlobal_Manufacture_Notify_All._data_Result[idx]._currentCnt = s64_stackCount
      else
        PaGlobal_Manufacture_Notify_All._data_Result[idx]._currentCnt = PaGlobal_Manufacture_Notify_All._data_Result[idx]._currentCnt + s64_stackCount
      end
    end
    local materialItemWhereType = PaGlobal_Manufacture_All_GetCurrentMaterialWhereType()
    for key, value in pairs(PaGlobal_Manufacture_Notify_All._data_Resource) do
      local itemWrapper
      local count = 0
      if CppEnums.ItemWhereType.eInventory == materialItemWhereType or CppEnums.ItemWhereType.eCashInventory == materialItemWhereType then
        itemWrapper = getInventoryItemByType(materialItemWhereType, value._slotNo)
      else
        local waypointKey = PaGlobal_Manufacture_All_GetCurrentWayPointKey()
        local warehouseWrapper = warehouse_get(waypointKey)
        itemWrapper = warehouseWrapper:getItem(value._slotNo)
      end
      if nil ~= itemWrapper then
        count = Int64toInt32(itemWrapper:get():getCount_s64())
      end
      value._currentCnt = count
    end
    PaGlobal_Manufacture_All_ResultGrindJewel()
  else
    local message
    if 6 ~= failReason then
      message = PaGlobal_Manufacture_Notify_All._failMessage[failReason]
    end
    if 2 == failReason or 8 == failReason or 9 == failReason or 10 == failReason then
      Manufacture_ClearValues()
    end
    if 1 == failReason or 2 == failReason or 8 == failReason or 9 == failReason or 10 == failReason then
      PaGlobal_Manufacture_All_ManufactureReOpen()
    end
    if 6 ~= failReason and nil ~= message then
      Proc_ShowMessage_Ack(message)
    end
    PaGlobal_Manufacture_Notify_All._failCount = PaGlobal_Manufacture_Notify_All._failCount + 1
    local isFailManufacture = PaGlobal_Manufacture_All_CheckManufactureFailCount(PaGlobal_Manufacture_Notify_All._failCount)
    if true == isFailManufacture then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "ALCHEMY_MANUFACTURE_DONT_THIS_WAY"))
      PaGlobal_Manufacture_Notify_All._failCount = 0
      PaGlobal_Manufacture_All_ManufactureReOpen()
    end
  end
end
function PaGlobalFunc_Manufacture_Notify_All_SetResourceData(slotNo, itemWrapper)
  local itemStaticWrapper = itemWrapper:getStaticStatus()
  local idx = #PaGlobal_Manufacture_Notify_All._data_Resource + 1
  PaGlobal_Manufacture_Notify_All._data_Resource[idx] = {}
  PaGlobal_Manufacture_Notify_All._data_Resource[idx]._slotNo = slotNo
  PaGlobal_Manufacture_Notify_All._data_Resource[idx]._key = itemStaticWrapper:get()._key:getItemKey()
  PaGlobal_Manufacture_Notify_All._data_Resource[idx]._name = itemStaticWrapper:getName()
  PaGlobal_Manufacture_Notify_All._data_Resource[idx]._iconPath = "Icon/" .. itemStaticWrapper:getIconPath()
  PaGlobal_Manufacture_Notify_All._data_Resource[idx]._originalCnt = Int64toInt32(itemWrapper:get():getCount_s64())
  PaGlobal_Manufacture_Notify_All._data_Resource[idx]._currentCnt = PaGlobal_Manufacture_Notify_All._data_Resource[idx]._originalCnt
end
function PaGlobalFunc_Manufacture_Notify_All_ResetCount()
  PaGlobal_Manufacture_Notify_All._failCount = 0
  PaGlobal_Manufacture_Notify_All._successCount = 0
end
