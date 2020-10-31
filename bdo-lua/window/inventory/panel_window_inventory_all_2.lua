function PaGlobal_Inventory_All:changeMileageIcon()
  if false == _ContentsGroup_OceanCurrent then
    self._ui.stc_oceanIcon:SetShow(false)
    self._ui.txt_oceanValue:SetShow(false)
  end
  if false == _ContentsGroup_MileageShop then
    self._ui.stc_mileageIcon:SetShow(false)
    self._ui.txt_mileageValue:SetShow(false)
  else
    self:setMileageImage()
    self._ui.stc_mileageIcon:setRenderTexture(self._ui.stc_mileageIcon:getBaseTexture())
    self._ui.stc_mileageIcon:ComputePos()
  end
  self:updateMileageValue()
end
function PaGlobal_Inventory_All:setMileageImage()
  self._ui.stc_mileageIcon:ChangeTextureInfoName("Renewal/PcRemaster/Remaster_Cashshop_00.dds")
  if isGameTypeEnglish() or isGameTypeID() then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_mileageIcon, 32, 1, 62, 31)
    self._ui.stc_mileageIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif isGameTypeTR() then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_mileageIcon, 63, 1, 93, 31)
    self._ui.stc_mileageIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif isGameTypeKR2() then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_mileageIcon, 94, 1, 124, 31)
    self._ui.stc_mileageIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  else
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_mileageIcon, 1, 1, 31, 31)
    self._ui.stc_mileageIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  end
end
function PaGlobal_Inventory_All:updateMileageValue()
  local mileageValue = Defines.s64_const.s64_0
  local mileagelItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, getMileageSlotNo())
  if nil ~= mileagelItemWrapper then
    mileageValue = mileagelItemWrapper:get():getCount_s64()
  end
  self._ui.txt_mileageValue:SetText(makeDotMoney(mileageValue))
  if true == _ContentsGroup_OceanCurrent then
    mileageValue = Defines.s64_const.s64_0
    local priceItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eMoneyInventory, __eInventoryMoneyType_Shell)
    if nil ~= priceItemWrapper then
      mileageValue = priceItemWrapper:get():getCount_s64()
    end
    self._ui.txt_oceanValue:SetText(makeDotMoney(mileageValue))
  end
end
function PaGlobal_Inventory_All:updateMoney()
  local money = Defines.s64_const.s64_0
  local moneyItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, getMoneySlotNo())
  if nil ~= moneyItemWrapper then
    money = moneyItemWrapper:get():getCount_s64()
  end
  local pearl = Defines.s64_const.s64_0
  local pearlItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, getPearlSlotNo())
  if nil ~= pearlItemWrapper then
    pearl = pearlItemWrapper:get():getCount_s64()
  end
  PaGlobal_Inventory_All._ui.txt_moneyValue:SetText(makeDotMoney(money))
  PaGlobal_Inventory_All._ui.txt_pearlValue:SetText(makeDotMoney(pearl))
  PaGlobal_Inventory_All:changeSilverIcon(money)
end
function PaGlobal_Inventory_All:updateCapacity()
  local useStartSlot = inventorySlotNoUserStart()
  local invenUseSize = getSelfPlayer():get():getInventorySlotCount(not self._ui.rdo_normalInven:IsChecked())
  local inventory = Inventory_GetCurrentInventory()
  local freeCount = inventory:getFreeCount()
  local fontColor
  local leftCountPercent = (invenUseSize - freeCount - useStartSlot) / (invenUseSize - useStartSlot) * 100
  if 100 <= leftCountPercent then
    fontColor = "<PAColor0xFFF03838>"
  elseif 90 < leftCountPercent then
    fontColor = "<PAColor0xFFFF8957>"
  else
    fontColor = "<PAColor0xFFFFF3AF>"
  end
  PaGlobal_Inventory_All._ui.txt_capacity:SetText(fontColor .. tostring(invenUseSize - freeCount - useStartSlot) .. "/" .. tostring(invenUseSize - useStartSlot) .. "<PAOldColor>")
end
function PaGlobal_Inventory_All:updateSelectBar()
  if true == self._ui.rdo_normalInven:IsChecked() then
    self._ui.stc_selectbar:SetSpanSize(self._ui.rdo_normalInven:GetPosX() + (self._ui.rdo_normalInven:GetSizeX() - self._ui.stc_selectbar:GetSizeX()) * 0.5, self._ui.stc_selectbar:GetSpanSize().y)
  else
    self._ui.stc_selectbar:SetSpanSize(self._ui.rdo_pearlInven:GetPosX() + (self._ui.rdo_pearlInven:GetSizeX() - self._ui.stc_selectbar:GetSizeX()) * 0.5, self._ui.stc_selectbar:GetSpanSize().y)
  end
end
function PaGlobal_Inventory_All:changeSilverIcon(money)
  self._ui.stc_moneyIcon:ChangeTextureInfoName("Renewal/PcRemaster/Remaster_Icon_00.dds")
  self._ui.stc_moneyIcon:ChangeOnTextureInfoName("Renewal/PcRemaster/Remaster_Icon_00.dds")
  self._ui.stc_moneyIcon:ChangeClickTextureInfoName("Renewal/PcRemaster/Remaster_Icon_00.dds")
  if money >= toInt64(0, 100000) then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_moneyIcon, 258, 124, 288, 154)
    self._ui.stc_moneyIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(self._ui.stc_moneyIcon, 261, 155, 291, 185)
    self._ui.stc_moneyIcon:getOnTexture():setUV(xx1, yy1, xx2, yy2)
    local xxx1, yyy1, xxx2, yyy2 = setTextureUV_Func(self._ui.stc_moneyIcon, 261, 155, 291, 185)
    self._ui.stc_moneyIcon:getClickTexture():setUV(xxx1, yyy1, xxx2, yyy2)
  elseif money >= toInt64(0, 20000) then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_moneyIcon, 227, 124, 257, 154)
    self._ui.stc_moneyIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(self._ui.stc_moneyIcon, 230, 155, 260, 185)
    self._ui.stc_moneyIcon:getOnTexture():setUV(xx1, yy1, xx2, yy2)
    local xxx1, yyy1, xxx2, yyy2 = setTextureUV_Func(self._ui.stc_moneyIcon, 230, 155, 260, 185)
    self._ui.stc_moneyIcon:getClickTexture():setUV(xxx1, yyy1, xxx2, yyy2)
  elseif money >= toInt64(0, 5000) then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_moneyIcon, 196, 124, 226, 154)
    self._ui.stc_moneyIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(self._ui.stc_moneyIcon, 199, 155, 229, 185)
    self._ui.stc_moneyIcon:getOnTexture():setUV(xx1, yy1, xx2, yy2)
    local xxx1, yyy1, xxx2, yyy2 = setTextureUV_Func(self._ui.stc_moneyIcon, 199, 155, 229, 185)
    self._ui.stc_moneyIcon:getClickTexture():setUV(xxx1, yyy1, xxx2, yyy2)
  else
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_moneyIcon, 165, 124, 195, 154)
    self._ui.stc_moneyIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(self._ui.stc_moneyIcon, 168, 155, 198, 185)
    self._ui.stc_moneyIcon:getOnTexture():setUV(xx1, yy1, xx2, yy2)
    local xxx1, yyy1, xxx2, yyy2 = setTextureUV_Func(self._ui.stc_moneyIcon, 168, 155, 198, 185)
    self._ui.stc_moneyIcon:getClickTexture():setUV(xxx1, yyy1, xxx2, yyy2)
  end
  self._ui.stc_moneyIcon:setRenderTexture(self._ui.stc_moneyIcon:getBaseTexture())
  self._ui.stc_moneyIcon:setRenderTexture(self._ui.stc_moneyIcon:getOnTexture())
  self._ui.stc_moneyIcon:setRenderTexture(self._ui.stc_moneyIcon:getClickTexture())
end
function PaGlobal_Inventory_All:selectTabSound()
  if PaGlobal_Inventory_All._isFirstTab == true then
    PaGlobal_Inventory_All._isFirstTab = false
  else
    audioPostEvent_SystemUi(0, 0)
  end
end
function PaGlobal_Inventory_All:isRestricted()
  return checkManufactureAction() or checkAlchemyAction()
end
function PaGlobal_Inventory_All:changeWeightIcon(s64_allWeight, s64_maxWeight_div)
  if 80 <= Int64toInt32(s64_allWeight / s64_maxWeight_div) then
    self._ui.stc_weightIcon:SetColor(Defines.Color.C_FFD05D48)
  else
    self._ui.stc_weightIcon:SetColor(Defines.Color.C_FFFFEDD4)
  end
end
function PaGlobal_Inventory_All:potionAutoSetPosition(playerLevel, itemKey, currentWhereType, slotNo)
  if playerLevel <= 10 then
    if 502 == itemKey or 513 == itemKey or 514 == itemKey or 517 == itemKey or 518 == itemKey or 519 == itemKey or 524 == itemKey or 525 == itemKey or 528 == itemKey or 529 == itemKey or 530 == itemKey or 538 == itemKey or 551 == itemKey or 552 == itemKey or 553 == itemKey or 554 == itemKey or 555 == itemKey or 17568 == itemKey or 17569 == itemKey or 19932 == itemKey or 19933 == itemKey or 19934 == itemKey or 19935 == itemKey then
      FGlobal_Potion_InvenToQuickSlot(currentWhereType, slotNo, 0)
    elseif 503 == itemKey or 515 == itemKey or 516 == itemKey or 520 == itemKey or 521 == itemKey or 522 == itemKey or 526 == itemKey or 527 == itemKey or 531 == itemKey or 532 == itemKey or 533 == itemKey or 540 == itemKey or 561 == itemKey or 562 == itemKey or 563 == itemKey or 564 == itemKey or 565 == itemKey or 17570 == itemKey or 17571 == itemKey or 19936 == itemKey or 19937 == itemKey or 19938 == itemKey then
      FGlobal_Potion_InvenToQuickSlot(currentWhereType, slotNo, 1)
    end
  end
end
function PaGlobal_Inventory_All:findPuzzle()
  if self._ui.check_itemSort:IsCheck() then
    return
  end
  self:hidePuzzleControl()
  local whereType = Inventory_GetCurrentInventoryType()
  local isFind = findPuzzleAndReadyMake(whereType)
  if false == isFind then
    return
  end
  local count = getPuzzleSlotCount()
  for ii = 0, count - 1 do
    local puzzleSlotNo = getPuzzleSlotAt(ii)
    local showSlotIndex = puzzleSlotNo - 2 - PaGlobal_Inventory_All._startSlotIndex
    if 0 <= showSlotIndex and showSlotIndex < PaGlobal_Inventory_All.config.slotCount - 1 then
      if 0 == ii then
        self.slotEtcData[showSlotIndex].puzzleControl:SetShow(true)
        self._puzzleControlSlotNo = puzzleSlotNo
      end
      self.slots[showSlotIndex].icon:AddEffect("UI_Item_MineCraft", true, 0, 0)
    end
  end
end
function PaGlobal_Inventory_All:hidePuzzleControl()
  if nil ~= self._puzzleControlSlotNo then
    local showSlotIndex = self._puzzleControlSlotNo - 2 - PaGlobal_Inventory_All._startSlotIndex
    if 0 <= showSlotIndex and showSlotIndex < PaGlobal_Inventory_All.config.slotCount - 1 then
      self.slotEtcData[showSlotIndex].puzzleControl:SetShow(false)
    end
    PaGlobal_Inventory_All._ui.stc_puzzleNotice:SetShow(false)
    self._puzzleControlSlotNo = nil
  end
end
function PaGlobal_Inventory_All:findExchangeItemNPCbySlotNo(slotNo)
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local inventory = selfProxy:getInventory()
  if not inventory:empty(slotNo) then
    local itemWrapper = getInventoryItem(slotNo)
    if nil == itemWrapper then
      return
    end
    local itemSSW = itemWrapper:getStaticStatus()
    if nil == itemSSW then
      return
    end
    PaGlobal_Inventory_All:findExchangeItemNPC(itemSSW)
  end
end
function PaGlobal_Inventory_All:findExchangeItemNPC(itemSSW)
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local selfPosition = float3(selfProxy:getPositionX(), selfProxy:getPositionY(), selfProxy:getPositionZ())
  local itemKey = itemSSW:get()._key:get()
  local npcPosition = {}
  local minIndex = 0
  local minDistance = 0
  ToClient_DeleteNaviGuideByGroup(0)
  local count = itemSSW:getExchangeItemNPCInfoListCount()
  for index = 0, count - 1 do
    local spawnData = npcByCharacterKey_getNpcInfo(itemSSW:getCharacterKeyByIdx(index), itemSSW:getDialogIndexByIdx(index))
    if nil ~= spawnData then
      local npcPos = spawnData:getPosition()
      npcPosition[index] = npcPos
      local distance = Util.Math.calculateDistance(selfPosition, npcPos)
      if 0 == index then
        minDistance = distance
      elseif distance < minDistance then
        minIndex = index
        minDistance = distance
      end
    end
  end
  for ii = 0, count - 1 do
    if ii ~= minIndex and nil ~= npcPosition[ii] then
      worldmapNavigatorStart(float3(npcPosition[ii].x, npcPosition[ii].y, npcPosition[ii].z), NavigationGuideParam(), false, false, true)
    end
  end
  if nil ~= npcPosition[minIndex] then
    worldmapNavigatorStart(float3(npcPosition[minIndex].x, npcPosition[minIndex].y, npcPosition[minIndex].z), NavigationGuideParam(), false, false, true)
  end
  audioPostEvent_SystemUi(0, 14)
  selfProxy:setCurrentFindExchangeItemEnchantKey(itemKey)
end
function PaGlobal_Inventory_All:addEffectBlackStone(index, isFiltered, slotNo)
  local slot = self.slots[index]
  local itemWrapper = getInventoryItemByType(Inventory_GetCurrentInventoryType(), slotNo)
  local itemKey = itemWrapper:get():getKey():getItemKey()
  if 16001 == itemKey then
    if not isFiltered then
      slot.icon:AddEffect("fUI_DarkstoneAura01", true, 0, 0)
    end
    self._hasWeaponBlackStone = true
  elseif 16002 == itemKey then
    if not isFiltered then
      slot.icon:AddEffect("fUI_DarkstoneAura02", true, 0, 0)
    end
    self._hasArmorBlackStone = true
  end
end
function PaGlobal_Inventory_All:addEffectMapea(index, slotNo)
  local slot = self.slots[index]
  local itemWrapper = getInventoryItemByType(Inventory_GetCurrentInventoryType(), slotNo)
  if false == _ContentsGroup_NewUI_Servant_All then
    if GetUIMode() == Defines.UIMode.eUIMode_Stable and not EffectFilter_Mapae(slotNo, itemWrapper) then
      slot.icon:AddEffect("fUI_HorseNameCard01", true, 0, 0)
    end
  elseif GetUIMode() == Defines.UIMode.eUIMode_Stable and not PaGlobalFunc_ServantFunction_All_EffectFilter_Mapae(slotNo, itemWrapper) then
    slot.icon:AddEffect("fUI_HorseNameCard01", true, 0, 0)
  end
end
function PaGlobal_Inventory_All:getClassAttackType(classType)
  if __eClassType_Warrior == classType or __eClassType_Valkyrie == classType or __eClassType_Giant == classType or __eClassType_Kunoichi == classType or __eClassType_NinjaMan == classType or __eClassType_BladeMaster == classType or __eClassType_BladeMasterWoman == classType or __eClassType_Combattant == classType or __eClassType_Mystic == classType or __eClassType_Lhan == classType or __eClassType_ShyWaman == classType or __eClassType_Guardian == classType then
    return 0
  elseif __eClassType_ElfRanger == classType or __eClassType_RangerMan == classType then
    return 1
  elseif __eClassType_Sorcerer == classType or __eClassType_Tamer == classType or __eClassType_WizardMan == classType or __eClassType_WizardWoman == classType or __eClassType_DarkElf == classType or __eClassType_Hashashin == classType then
    return 2
  end
end
function PaGlobal_Inventory_All:setSlotNoList()
  if false == PaGlobal_Inventory_All._ui.check_itemSort:IsCheck() then
    return
  end
  local selfPlayer = getSelfPlayer():get()
  local isNormalInventory = PaGlobal_Inventory_All._ui.rdo_normalInven:IsChecked()
  selfPlayer:sortInventorySlotNo(isNormalInventory)
end
function PaGlobal_Inventory_All:setNewPearlTabEffect()
  PaGlobal_Inventory_All._ui.stc_pearlInvenEffect:EraseAllEffect()
  for ii = 0, PaGlobal_Inventory_All.INVEN_MAX_SLOTNO do
    if nil ~= PaGlobal_Inventory_All.newPearlItemData[ii] then
      PaGlobal_Inventory_All._ui.stc_pearlInvenEffect:AddEffect("fUI_NewItem_PearlTab_01A", true, 0, 0)
      return true
    end
  end
  return false
end
function PaGlobal_Inventory_All:setNewItemEffect()
  for ii = 0, PaGlobal_Inventory_All.config.slotCount - 1 do
    local slotNo = ii + 2 + PaGlobal_Inventory_All._startSlotIndex
    local isSorted = PaGlobal_Inventory_All._ui.check_itemSort:IsCheck()
    local isNormalInventory = PaGlobal_Inventory_All._ui.rdo_normalInven:IsChecked()
    if true == isSorted then
      local selfPlayerWrapper = getSelfPlayer()
      if nil == selfPlayerWrapper then
        return
      end
      local selfPlayer = selfPlayerWrapper:get()
      slotNo = selfPlayer:getRealInventorySlotNo(isNormalInventory, ii + PaGlobal_Inventory_All._startSlotIndex)
    end
    local currentWhereType = Inventory_GetCurrentInventoryType()
    local itemWrapper = getInventoryItemByType(currentWhereType, slotNo)
    if nil ~= itemWrapper then
      local slot = PaGlobal_Inventory_All.slots[ii]
      local itemEnchantKey = itemWrapper:get():getKey()
      if nil ~= slot and slotNo < PaGlobal_Inventory_All.INVEN_MAX_SLOTNO then
        if true == isNormalInventory and nil ~= PaGlobal_Inventory_All.newItemData[slotNo] then
          if itemEnchantKey:get() == PaGlobal_Inventory_All.newItemData[slotNo] then
            local newItemEffectSceneId = slot.icon:AddEffect("fUI_NewItem02", true, 0, 0)
            PaGlobal_Inventory_All.effectScene.newItem[slotNo] = newItemEffectSceneId
          end
        elseif false == isNormalInventory and nil ~= PaGlobal_Inventory_All.newPearlItemData[slotNo] and itemEnchantKey:get() == PaGlobal_Inventory_All.newPearlItemData[slotNo] then
          local newItemEffectSceneId = slot.icon:AddEffect("fUI_NewItem02", true, 0, 0)
          PaGlobal_Inventory_All.effectScene.newItem[slotNo] = newItemEffectSceneId
        end
      end
    end
  end
end
