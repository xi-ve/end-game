function PaGlobal_Manufacture_All:resetGrindJewelSetting()
  PaGlobal_Manufacture_All._noneStackItemList = Array.new()
  PaGlobal_Manufacture_All._noneStackItemCheck = false
  PaGlobal_Manufacture_All._hasNoneStackItem = false
  PaGlobal_Manufacture_All._selectedWarehouseItemKey = -1
  PaGlobal_Manufacture_All._selectedWarehouseItemSlotNo = -1
  PaGlobal_Manufacture_All.targetWarehouseSlotNo = -1
  PaGlobal_Manufacture_All._ui.chk_identicalItem:SetCheck(false)
  PaGlobal_Manufacture_All._ui.chk_identicalItem:SetShow(false)
  PaGlobal_Manufacture_All._canRepeat = false
end
function PaGlobal_Manufacture_All:updateSlot()
  PaGlobal_Manufacture_All._ui.stc_circle:EraseAllEffect()
  local inventory = Inventory_GetCurrentInventory()
  if nil == inventory then
    return
  end
  local invenSize = inventory:size()
  local slot
  local slotNo = 0
  for ii = 0, PaGlobal_Manufacture_All._slotMaxCount - 1 do
    slot = PaGlobal_Manufacture_All._ui._slotList[ii]
    slotNo = PaGlobal_Manufacture_All._materialSlotNoList[ii]
    if nil == slot then
      return
    end
    slot.icon:SetShow(false)
    slot.icon:addInputEvent("Mouse_On", "")
    slot.icon:addInputEvent("Mouse_Out", "")
    if nil ~= slotNo and invenSize >= slotNo then
      local itemWrapper
      if CppEnums.ItemWhereType.eWarehouse == PaGlobal_Manufacture_All._materialItemWhereType then
        if _ContentsGroup_NewUI_WareHouse_All then
          itemWrapper = PaGlobal_Warehouse_All_GetWarehouseWarpper():getItem(slotNo)
        else
          itemWrapper = Warehouse_GetWarehouseWarpper():getItem(slotNo)
        end
      else
        itemWrapper = getInventoryItemByType(PaGlobal_Manufacture_All._materialItemWhereType, slotNo)
      end
      if nil ~= itemWrapper then
        slot:setItemByStaticStatus(itemWrapper:getStaticStatus(), itemWrapper:get():getCount_s64())
        slot.icon:SetShow(true)
        slot.icon:AddEffect("fUI_ItemInstall_Produce", false, 0, 0)
        slot.iconBG:addInputEvent("Mouse_On", "HandleEventOnOut_Manufacture_All_MaterialTooltip(true, " .. ii .. " )")
        slot.iconBG:addInputEvent("Mouse_Out", "HandleEventOnOut_Manufacture_All_MaterialTooltip(false, " .. ii .. " )")
        PaGlobal_Manufacture_All._ui.stc_circle:AddEffect("fUI_Process_01A", false, 0, 0)
        PaGlobal_Manufacture_All._materialSlotNoListItemIn[ii] = true
        local isStack = itemWrapper:getStaticStatus():isStackable()
        if isStack then
          PaGlobal_Manufacture_All._ui.chk_identicalItem:SetCheck(false)
          PaGlobal_Manufacture_All._ui.chk_identicalItem:SetShow(false)
          PaGlobal_Manufacture_All._canRepeat = false
        end
      else
        PaGlobal_Manufacture_All._materialSlotNoList[ii] = PaGlobal_Manufacture_All._defaultSlotNo
        PaGlobal_Manufacture_All._materialSlotNoListItemIn[ii] = false
      end
    end
  end
  local isEnable = false
  for i = 0, PaGlobal_Manufacture_All._maxActionBtn - 1 do
    if true == PaGlobal_Manufacture_All._listAction[i]._radioBtn:IsCheck() then
      isEnable = true
    end
  end
  if false == PaGlobal_Manufacture_All._isConsole then
    PaGlobal_Manufacture_All._ui.btn_manufacture:SetShow(isEnable)
  end
  Inventory_updateSlotData()
end
function PaGlobal_Manufacture_All:clearList()
  PaGlobal_Manufacture_All:setKnowledgeDesc("")
  PaGlobal_Manufacture_All._ui.list2_knowledgeList:getElementManager():clearKey()
end
function PaGlobal_Manufacture_All:updateList()
  PaGlobal_Manufacture_All._ui.list2_knowledgeList:getElementManager():clearKey()
  PaGlobal_Manufacture_All._selectIndex = -1
  PaGlobal_Manufacture_All:clearList()
  local count = getCountAlchemyKnowledge()
  if true == ToClient_IsContentsGroupOpen("597") then
    if PaGlobal_Manufacture_All.MANUFACTURE_TYPE.RGCOOK == PaGlobal_Manufacture_All._actionIndex then
      PaGlobal_Manufacture_All._startKnowledgeIndex = 22
    elseif PaGlobal_Manufacture_All.MANUFACTURE_TYPE.RGALCHEMY == PaGlobal_Manufacture_All._actionIndex then
      PaGlobal_Manufacture_All._startKnowledgeIndex = 19
    else
      PaGlobal_Manufacture_All._startKnowledgeIndex = 0
    end
  else
    PaGlobal_Manufacture_All._startKnowledgeIndex = 0
  end
  for index = PaGlobal_Manufacture_All._startKnowledgeIndex, count - 1 do
    PaGlobal_Manufacture_All._ui.list2_knowledgeList:getElementManager():pushKey(toInt64(0, index))
  end
end
function PaGlobal_Manufacture_All:clearMaterial()
  audioPostEvent_SystemUi(10, 3)
  local defaultSlotNo = PaGlobal_Manufacture_All._defaultSlotNo
  PaGlobal_Manufacture_All._materialSlotNoList = {
    [0] = defaultSlotNo,
    defaultSlotNo,
    defaultSlotNo,
    defaultSlotNo,
    defaultSlotNo
  }
  PaGlobal_Manufacture_All._materialSlotNoListItemIn = {
    [0] = false,
    false,
    false,
    false
  }
  PaGlobal_Manufacture_All._usingInstallationType = CppEnums.InstallationType.TypeCount
  PaGlobal_Manufacture_All._usingSlotCount = 0
  for ii = 0, PaGlobal_Manufacture_All._slotMaxCount - 1 do
    PaGlobal_Manufacture_All._ui._pointList[ii]:SetShow(false)
  end
  PaGlobal_Manufacture_All._ui.txt_manufactureName:SetText("")
  PaGlobal_Manufacture_All:updateSlot()
end
function PaGlobal_Manufacture_All:updateMaterial(slotCount)
  local slotCount = PaGlobal_Manufacture_All._usingSlotCount
  local inventory = getSelfPlayer():get():getInventory()
  local invenSize = inventory:size()
  for ii = 0, slotCount - 1 do
    if nil ~= PaGlobal_Manufacture_All._materialSlotNoList[ii] and invenSize >= PaGlobal_Manufacture_All._materialSlotNoList[ii] then
      local itemWrapper = getInventoryItemByType(PaGlobal_Manufacture_All._materialItemWhereType, PaGlobal_Manufacture_All._materialSlotNoList[ii])
      if nil ~= itemWrapper then
        PaGlobal_Manufacture_All._ui._slotList[ii]:setItemByStaticStatus(itemWrapper:getStaticStatus(), itemWrapper:get():getCount_s64())
      end
    end
  end
end
function PaGlobal_Manufacture_All:updateSlotWarehouse()
  PaGlobal_Manufacture_All._ui.stc_circle:EraseAllEffect()
  local warehouseSize = 0
  local warehouseWrapper
  if _ContentsGroup_NewUI_WareHouse_All then
    warehouseWrapper = PaGlobal_Warehouse_All_GetWarehouseWarpper()
  else
    warehouseWrapper = Warehouse_GetWarehouseWarpper()
  end
  if nil == warehouseWrapper then
    return
  end
  warehouseSize = warehouseWrapper:getUseMaxCount()
  local slot
  local slotNo = 0
  for ii = 0, PaGlobal_Manufacture_All._slotMaxCount - 1 do
    slot = PaGlobal_Manufacture_All._ui._slotList[ii]
    slotNo = PaGlobal_Manufacture_All._materialSlotNoList[ii]
    slot.icon:SetShow(false)
    slot.icon:addInputEvent("Mouse_On", "")
    slot.icon:addInputEvent("Mouse_Out", "")
    if nil ~= slotNo and warehouseSize >= slotNo then
      local itemWrapper = warehouseWrapper:getItem(slotNo)
      if nil ~= itemWrapper then
        slot:setItemByStaticStatus(itemWrapper:getStaticStatus(), itemWrapper:get():getCount_s64())
        slot.icon:SetShow(true)
        slot.icon:AddEffect("fUI_ItemInstall_Produce", false, 0, 0)
        slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Manufacture_All_MaterialTooltip(true, " .. ii .. " )")
        slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Manufacture_All_MaterialTooltip(false, " .. ii .. " )")
        PaGlobal_Manufacture_All._ui.stc_circle:AddEffect("UI_ItemInstall_ProduceRing", false, 0, 0)
        PaGlobal_Manufacture_All._materialSlotNoListItemIn[ii] = true
      else
        PaGlobal_Manufacture_All._materialSlotNoList[ii] = PaGlobal_Manufacture_All._defaultSlotNo
        PaGlobal_Manufacture_All._materialSlotNoListItemIn[ii] = false
      end
    end
  end
  local isEnable = false
  for i = 0, PaGlobal_Manufacture_All._maxActionBtn - 1 do
    if true == PaGlobal_Manufacture_All._listAction[i]._radioBtn:IsCheck() then
      isEnable = true
    end
  end
  if false == PaGlobal_Manufacture_All._isConsole then
    PaGlobal_Manufacture_All._ui.btn_manufacture:SetShow(isEnable)
  end
  if _ContentsGroup_NewUI_WareHouse_All then
    PaGlobal_Warehouse_All_UpdateSlotData()
  else
    Warehouse_updateSlotData()
  end
end
function PaGlobal_Manufacture_All:hasNoneStackItem(slotNo)
  if nil == slotNo then
    return
  end
  PaGlobal_Manufacture_All._hasNoneStackItem = false
  PaGlobal_Manufacture_All._selectedWarehouseItemSlotNo = slotNo
  local warehouseWrapper = warehouse_get(PaGlobal_Manufacture_All._waypointKey_ByWareHouse)
  local useMaxCount = warehouseWrapper:getUseMaxCount()
  local selectedItemWrapper = warehouseWrapper:getItem(slotNo)
  if nil == selectedItemWrapper then
    return
  end
  PaGlobal_Manufacture_All._selectedWarehouseItemKey = selectedItemWrapper:get():getKey():getItemKey()
  local hasNoneStackItemCount = 0
  for ii = 1, useMaxCount - 1 do
    local itemWrapper = warehouseWrapper:getItem(ii)
    if nil ~= itemWrapper then
      local itemKey = itemWrapper:get():getKey():getItemKey()
      if PaGlobal_Manufacture_All._selectedWarehouseItemKey == itemKey and not selectedItemWrapper:getStaticStatus():isStackable() and slotNo ~= ii then
        hasNoneStackItemCount = hasNoneStackItemCount + 1
      end
    end
  end
  if 0 < hasNoneStackItemCount then
    PaGlobal_Manufacture_All._hasNoneStackItem = true
    if false == PaGlobal_Manufacture_All._isConsole then
      PaGlobal_Manufacture_All._ui.chk_identicalItem:SetCheck(false)
      PaGlobal_Manufacture_All._ui.chk_identicalItem:SetShow(true)
    else
      PaGlobal_Manufacture_All._canRepeat = true
    end
  end
end
function PaGlobal_Manufacture_All:checkEquipCrystal()
  for ii = 0, PaGlobal_Manufacture_All._slotMaxCount - 1 do
    slot = PaGlobal_Manufacture_All._ui._slotList[ii]
    slotNo = PaGlobal_Manufacture_All._materialSlotNoList[ii]
    if nil == slot then
      return false
    end
    if nil == slotNo then
      return false
    end
    local itemWrapper = getInventoryItemByType(PaGlobal_Manufacture_All._materialItemWhereType, slotNo)
    if nil == itemWrapper then
      return false
    end
    local maxCount = itemWrapper:get():getUsableItemSocketCount()
    for sock_idx = 1, maxCount do
      local itemStaticWrapper = itemWrapper:getPushedItem(sock_idx - 1)
      if nil ~= itemStaticWrapper then
        return true
      end
    end
  end
  return false
end
function PaGlobal_Manufacture_All:checkCrystal(itemWrapper)
  if nil == itemWrapper then
    return false
  end
  local maxCount = itemWrapper:get():getUsableItemSocketCount()
  for sock_idx = 1, maxCount do
    local itemStaticWrapper = itemWrapper:getPushedItem(sock_idx - 1)
    if nil ~= itemStaticWrapper then
      return true
    end
  end
  return false
end
function PaGlobal_Manufacture_All:updateUsingSlotCount(index)
  PaGlobal_Manufacture_All._usingSlotCount = PaGlobal_Manufacture_All.MANUFACTURE_INFO[index].slotCount
  if PaGlobal_Manufacture_All.MANUFACTURE_TYPE.FIREWOOD == index then
    if false == _ContentsGroup_OceanCurrent then
      PaGlobal_Manufacture_All._usingSlotCount = 1
    end
  elseif PaGlobal_Manufacture_All.MANUFACTURE_TYPE.HEAT == index then
    if true == _ContentsGroup_BlackStarWeapon then
      PaGlobal_Manufacture_All._usingSlotCount = 3
    end
    if true == _ContentsGroup_OceanCurrent then
      PaGlobal_Manufacture_All._usingSlotCount = 4
    end
    if true == _ContentsGroup_Othilita then
      PaGlobal_Manufacture_All._usingSlotCount = 5
    end
  elseif PaGlobal_Manufacture_All.MANUFACTURE_TYPE.COOK == index then
    if ToClient_IsContentsGroupOpen("327") then
      PaGlobal_Manufacture_All._usingSlotCount = 4
    elseif ToClient_IsContentsGroupOpen("228") then
      PaGlobal_Manufacture_All._usingSlotCount = 3
    end
  end
end
function PaGlobal_Manufacture_All:updateSlotPos()
  local posIndex = PaGlobal_Manufacture_All._usingSlotCount - 1
  if posIndex < 0 then
    return
  end
  local posArray = PaGlobal_Manufacture_All.SLOT_POSITION[posIndex]
  for ii = 0, posIndex do
    local pos = posArray[ii]
    PaGlobal_Manufacture_All._ui._pointList[ii]:SetPosX(pos[1])
    PaGlobal_Manufacture_All._ui._pointList[ii]:SetPosY(pos[2])
  end
end
function PaGlobal_Manufacture_All:showPointEffect()
  for ii = 0, PaGlobal_Manufacture_All._slotMaxCount - 1 do
    if ii < PaGlobal_Manufacture_All._usingSlotCount then
      PaGlobal_Manufacture_All._ui._pointList[ii]:SetShow(true)
      PaGlobal_Manufacture_All._ui._pointList[ii]:AddEffect("fUI_Light", true, 0, 0)
    else
      PaGlobal_Manufacture_All._ui._pointList[ii]:SetShow(false)
    end
  end
end
function PaGlobal_Manufacture_All:setGuildManufactureButton()
  if _ContentsGroup_GuildHouse then
    local houseWrapper = housing_getHouseholdActor_CurrentPosition()
    if nil ~= houseWrapper then
      local isMyGuildHouse = houseWrapper:isMyGuildHouse()
      if true == isMyGuildHouse then
        PaGlobal_Manufacture_All_SetButtonEnable(PaGlobal_Manufacture_All._listAction[12]._radioBtn, true, 12)
        return
      end
    end
  end
  PaGlobal_Manufacture_All_SetButtonEnable(PaGlobal_Manufacture_All._listAction[12]._radioBtn, false, 12)
end
function PaGlobal_Manufacture_All:setManufactureText(index)
  if nil == PaGlobal_Manufacture_All.MANUFACTURE_INFO[index] then
    return
  end
  if PaGlobal_Manufacture_All.MANUFACTURE_TYPE.REPAIRITEM == index then
    PaGlobal_Manufacture_All._ui.btn_manufacture:SetText(PAGetString(Defines.StringSheet_GAME, "ALCHEMY_MANUFACTURE_BTN_REPAIR"))
  else
    PaGlobal_Manufacture_All._ui.btn_manufacture:SetText(PAGetString(Defines.StringSheet_GAME, "ALCHEMY_MANUFACTURE_BTN_MANUFACTURE"))
  end
  PaGlobal_Manufacture_All._ui.txt_manufactureName:SetText(PaGlobal_Manufacture_All.MANUFACTURE_INFO[index].name)
end
function PaGlobal_Manufacture_All:updateCheckRadioButton(isClear)
  for i = 0, PaGlobal_Manufacture_All._maxActionBtn - 1 do
    if true == isClear then
      PaGlobal_Manufacture_All._listAction[i]._radioBtn:SetCheck(false)
    end
    PaGlobal_Manufacture_All:setRadioBtnFontColor(PaGlobal_Manufacture_All._listAction[i]._radioBtn)
  end
end
function PaGlobal_Manufacture_All:setRadioBtnFontColor(control)
  if control:IsChecked() then
    control:SetFontColor(Defines.Color.C_FFFFFFFF)
  else
    control:SetFontColor(Defines.Color.C_FFC4BEBE)
  end
end
function PaGlobal_Manufacture_All:refreshIsMassCheckButton(actionIndex)
  if true == _ContentsGroup_LifeStatManufacturing then
    local enableMassActionIndex = 0 <= actionIndex and actionIndex <= 5
    local isManufactureMassItemEquip = false
    local itemWrapper = ToClient_getEquipmentItem(CppEnums.EquipSlotNoClient.eEquipSlotNoSubTool)
    if itemWrapper ~= nil then
      local itemSSW = itemWrapper:getStaticStatus()
      if __ePlayerLifeStatType_Manufacture == itemSSW:getLifeStatMainType() and actionIndex + 1 == itemSSW:getLifeStatSubType() then
        isManufactureMassItemEquip = true
      end
    end
    if true == enableMassActionIndex and false == PaGlobal_Manufacture_All._isConsole then
      PaGlobal_Manufacture_All._ui.btn_massManufacture:SetShow(true)
      PaGlobal_Manufacture_All._ui.btn_manufacture:SetSize(PaGlobal_Manufacture_All._ui.btn_massManufacture:GetSizeX(), PaGlobal_Manufacture_All._ui.btn_manufacture:GetSizeY())
    else
      PaGlobal_Manufacture_All._ui.btn_massManufacture:SetShow(false)
      PaGlobal_Manufacture_All._ui.btn_manufacture:SetSize(PaGlobal_Manufacture_All._ui.btn_massManufacture:GetSizeX() * 2 + 10, PaGlobal_Manufacture_All._ui.btn_manufacture:GetSizeY())
    end
    if true == isManufactureMassItemEquip then
      PaGlobal_Manufacture_All._ui.btn_massManufacture:SetMonoTone(false)
      PaGlobal_Manufacture_All._ui.btn_massManufacture:addInputEvent("Mouse_LUp", "HandleEventLUp_Manufacture_All_RepeatAction(true)")
    else
      PaGlobal_Manufacture_All._ui.btn_massManufacture:SetMonoTone(true)
      PaGlobal_Manufacture_All._ui.btn_massManufacture:addInputEvent("Mouse_LUp", "HandleEventLUp_Manufacture_All_ImpossibleMassManufacture()")
    end
  else
    PaGlobal_Manufacture_All._ui.btn_massManufacture:SetShow(false)
  end
end
function PaGlobal_Manufacture_All:updateKnowledgeCount()
  local totalKnowledgeCount = ToClient_AlchemyGetCountAlchemyKnowledge()
  local learnedKnowledgeCount = 0
  local startIndex = 0
  if true == ToClient_IsContentsGroupOpen("597") then
    if PaGlobal_Manufacture_All.MANUFACTURE_TYPE.RGCOOK == PaGlobal_Manufacture_All._actionIndex then
      startIndex = 22
    elseif PaGlobal_Manufacture_All.MANUFACTURE_TYPE.RGALCHEMY == PaGlobal_Manufacture_All._actionIndex then
      startIndex = 19
    end
    if PaGlobal_Manufacture_All.MANUFACTURE_TYPE.RGCOOK == PaGlobal_Manufacture_All._actionIndex then
      totalKnowledgeCount = totalKnowledgeCount - 22
    elseif PaGlobal_Manufacture_All.MANUFACTURE_TYPE.RGALCHEMY == PaGlobal_Manufacture_All._actionIndex then
      totalKnowledgeCount = totalKnowledgeCount - 19
    end
  end
  for index = startIndex, totalKnowledgeCount - 1 do
    if isLearnMentalCardForAlchemy(getAlchemyKnowledge(index):getKey()) then
      learnedKnowledgeCount = learnedKnowledgeCount + 1
    end
  end
  PaGlobal_Manufacture_All._ui.txt_knowledgeCount:SetShow(true)
  PaGlobal_Manufacture_All._ui.txt_knowledgeCount:SetText("(" .. learnedKnowledgeCount .. " / " .. totalKnowledgeCount .. ")")
end
function PaGlobal_Manufacture_All:updateLifePoint()
  local lifeType = CppEnums.LifeExperienceType.manufacture
  local isSubLifeStat = 0 <= PaGlobal_Manufacture_All._actionIndex and PaGlobal_Manufacture_All._actionIndex <= 5
  if false == isSubLifeStat or true == PaGlobal_Manufacture_All._isConsole or isGameTypeKR2() then
    PaGlobal_Manufacture_All._ui.txt_lifeStatTitle:SetShow(false)
    PaGlobal_Manufacture_All._ui.txt_lifeStatValue:SetShow(false)
  else
    local subLifeStat = getSelfPlayer():get():getLifeStat(lifeType, PaGlobal_Manufacture_All._actionIndex + 1)
    PaGlobal_Manufacture_All._ui.txt_lifeStatValue:SetText(tostring(subLifeStat))
    PaGlobal_Manufacture_All._ui.txt_lifeStatTitle:SetShow(true)
    PaGlobal_Manufacture_All._ui.txt_lifeStatValue:SetShow(true)
  end
end
function PaGlobal_Manufacture_All:updateTabButtonPos()
  local tabCount = 0
  for index = 0, 13 do
    if true == PaGlobal_Manufacture_All._listAction[index]._radioBtn:GetShow() then
      tabCount = tabCount + 1
    end
  end
  local buttonSize = PaGlobal_Manufacture_All._listAction[0]._radioBtn:GetSizeX()
  local gap = 10
  local buttonAreaSize = buttonSize * tabCount + gap * (tabCount - 1)
  local startPos = (PaGlobal_Manufacture_All._ui.stc_radioButtonGroup:GetSizeX() - buttonAreaSize) * 0.5
  local showIndex = -1
  for index = 0, 13 do
    if true == PaGlobal_Manufacture_All._listAction[index]._radioBtn:GetShow() then
      showIndex = showIndex + 1
    end
    local posX = startPos + showIndex * (buttonSize + gap)
    PaGlobal_Manufacture_All._listAction[index]._radioBtn:SetSpanSize(posX, PaGlobal_Manufacture_All._listAction[index]._radioBtn:GetSpanSize().y)
  end
end
function PaGlobal_Manufacture_All:setAlignKeyGuide()
  local keyGuides = {
    PaGlobal_Manufacture_All._ui.stc_iconX,
    PaGlobal_Manufacture_All._ui.stc_iconA,
    PaGlobal_Manufacture_All._ui.stc_iconB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, PaGlobal_Manufacture_All._ui.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_Manufacture_All:getInsertedMaterialCount()
  local useSlotCount = 0
  for ii = 0, PaGlobal_Manufacture_All._usingSlotCount - 1 do
    if PaGlobal_Manufacture_All._defaultSlotNo ~= PaGlobal_Manufacture_All._materialSlotNoList[ii] then
      useSlotCount = useSlotCount + 1
    end
  end
  return useSlotCount
end
function PaGlobal_Manufacture_All:slotFullCheck()
  local useSlotCount = 0
  for ii = 0, PaGlobal_Manufacture_All._usingSlotCount - 1 do
    if PaGlobal_Manufacture_All._defaultSlotNo ~= PaGlobal_Manufacture_All._materialSlotNoList[ii] then
      useSlotCount = useSlotCount + 1
    end
  end
  if useSlotCount == PaGlobal_Manufacture_All._usingSlotCount then
    return true
  end
  return false
end
function PaGlobal_Manufacture_All:setKnowledgeDesc(text)
  if false == PaGlobal_Manufacture_All._isConsole then
    PaGlobal_Manufacture_All._ui.txt_knowledgeDesc:SetTextMode(__eTextMode_AutoWrap)
  else
    PaGlobal_Manufacture_All._ui.txt_knowledgeDesc:SetTextMode(__eTextMode_Limit_AutoWrap)
    PaGlobal_Manufacture_All._ui.txt_knowledgeDesc:setLineCountByLimitAutoWrap(5)
  end
  PaGlobal_Manufacture_All._ui.txt_knowledgeDesc:SetText(text)
  local frameContent = PaGlobal_Manufacture_All._ui.frame_knowledgeDesc:GetFrameContent()
  frameContent:SetSize(frameContent:GetSizeX(), PaGlobal_Manufacture_All._ui.txt_knowledgeDesc:GetSizeY())
  UIScroll.SetButtonSize(PaGlobal_Manufacture_All._ui.scroll_vertical, PaGlobal_Manufacture_All._ui.frame_knowledgeDesc:GetSizeY(), frameContent:GetSizeY() + 10)
  PaGlobal_Manufacture_All._ui.scroll_vertical:SetControlPos(0)
  PaGlobal_Manufacture_All._ui.frame_knowledgeDesc:UpdateContentScroll()
  PaGlobal_Manufacture_All._ui.frame_knowledgeDesc:UpdateContentPos()
end
