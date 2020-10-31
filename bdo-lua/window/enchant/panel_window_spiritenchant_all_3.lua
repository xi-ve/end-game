function PaGlobal_SpiritEnchant_All:caphrasOpen()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  self._enchantInfo = getEnchantInformation()
  self._enchantInfo:ToClient_clearData()
  self:clearCaphrasSlot()
  self._ui_enchant.stc_image:SetShow(false)
  self._ui_enchant.stc_noticeBar:SetShow(false)
  self._ui_enchant.stc_image2:SetShow(true)
  self._ui_enchant.stc_buttonArea:SetShow(false)
  self._ui_enchant.txt_subTitle:SetShow(false)
  self._ui_enchant.txt_subTitleValue:SetShow(false)
  self._ui_enchant.txt_valks:SetShow(false)
  self._ui_enchant.txt_valksValue:SetShow(false)
  self._ui_enchant.txt_plus:SetShow(false)
  self._ui_enchant.txt_plusValue:SetShow(false)
  self._ui_enchant.btn_Add:SetShow(false)
  self._ui_enchant.chk_skipAni:SetShow(true)
  self._ui_pc.btn_enchantGo:SetShow(not self._isConsole)
  self._isAbleCaphras = false
  self._ui_pc.btn_enchantGo:SetMonoTone(true)
  self._ui_enchant.stc_caphrasRightWing:SetShow(false)
  self._ui_enchant.stc_caphrasLeftWing:SetShow(false)
  self._ui_enchant.stc_caphrasLeftLine:SetShow(false)
  self._ui_enchant.stc_caphrasRightLine:SetShow(false)
  self._ui_enchant.progress_caphrasNextExp:SetProgressRate(0)
  self._ui_enchant.progress_caphrasCurExp:SetProgressRate(0)
  self._ui_enchant.stc_bg:SetShow(true)
  self._ui_enchant.stc_bg:SetSize(self._ui_enchant.stc_bg:GetSizeX(), self._const.bottomBgCaphrasSizeY)
  self._ui_enchant.txt_enchantDesc:SetSpanSize(self._ui_enchant.txt_enchantDesc:GetSpanSize().x, self._const.kindDescSpanTopY)
  self._ui_enchant.txt_enchantDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui_enchant.txt_enchantDesc:SetShow(true)
  self._ui_enchant.txt_enchantDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_CAPHRAS_BOTTOMDESC"))
  self._ui_enchant.txt_caphrasEffect:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRASEFFECT_CURRENT"))
  if true == self._isConsole then
    Panel_Window_StackExtraction_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandlePadEventY_SpiritEnchant_All_CaphrasEnchantApplyButton()")
  else
    self._ui_pc.btn_enchantGo:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_CaphrasEnchantApplyButton()")
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  Inventory_SetFunctor(PaGlobalFunc_SpiritEnchant_All_FilterForCaphrasEquipItem, PaGlobalFunc_SpiritEnchant_All_RClickForEnchantTargetItem, PaGlobalFunc_SpiritEnchant_All_CloseForEnchant, nil)
end
function PaGlobal_SpiritEnchant_All:clearCaphrasSlot()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  self:clearItemSlot(self._slotResult_Caphras)
  self:clearItemSlot(self._slotEquip_Caphras)
  self:clearItemSlot(self._slotMaterial_Caphras)
  self:setAsCaphrasEnchantButton()
  self._ui_enchant.stc_caphrasRightWing:SetShow(false)
  self._ui_enchant.stc_caphrasLeftWing:SetShow(false)
  self._ui_enchant.stc_caphrasLeftLine:SetShow(false)
  self._ui_enchant.stc_caphrasRightLine:SetShow(false)
  for idx = 1, self._caphrasStatsMaxCount do
    self._ui_enchant.txt_caphrasStatusTitleL[idx]:SetTextMode(__eTextMode_AutoWrap)
    self._ui_enchant.txt_caphrasStatusTitleR[idx]:SetTextMode(__eTextMode_AutoWrap)
    self._ui_enchant.txt_caphrasStatusTitleL[idx]:SetShow(false)
    self._ui_enchant.txt_caphrasStatusValueL[idx]:SetShow(false)
    self._ui_enchant.txt_caphrasStatusTitleR[idx]:SetShow(false)
    self._ui_enchant.txt_caphrasStatusValueR[idx]:SetShow(false)
  end
  self._ui_enchant.progress_caphrasNextExp:SetProgressRate(0)
  self._ui_enchant.progress_caphrasCurExp:SetProgressRate(0)
  self._ui_enchant.txt_caphrasCount:SetShow(false)
  self._isPossibleMaterial = false
  self._isPossiblePromotion = false
  self._isAbleCaphras = false
  self._ui_pc.btn_enchantGo:SetMonoTone(true)
  self._ui_enchant.chk_skipAni:SetIgnore(false)
  self._grantItemWhereType = nil
  self._grantItemSlotNo = nil
  if true == self._isConsole then
    Panel_Window_StackExtraction_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandlePadEventY_SpiritEnchant_All_CaphrasEnchantApplyButton()")
  end
end
function PaGlobal_SpiritEnchant_All:didSetCaphrasEnchantTarget(itemWrapper, isMonotone, isPromotion)
  local curLevel = self._enchantInfo:ToClient_getCurLevel()
  local maxLevel = self._enchantInfo:ToClient_getMaxLevel()
  self._isPossibleMaterial = false
  self._isPossiblePromotion = false
  self:setText_NextCaphrasStats()
  self:setText_CurCaphrasStats()
  self:setProgress_CaphrasStep()
  self:setCaphrasEnchantMaterial(isMonotone, 0)
  if true == isPromotion then
    self._isPossiblePromotion = false
    self:setAsCaphrasEnchantButton()
    self:checkCaphrasMaterialItem()
  else
    self:setAsCaphrasEnchantButton()
    if maxLevel == curLevel then
      if true == itemWrapper:isPossibleCronPromotion() then
        self._isPossiblePromotion = true
        self:setAsPromotionEnchantButton()
        self._isAbleCaphras = true
        self._ui_pc.btn_enchantGo:SetMonoTone(false)
      else
        self._isPossiblePromotion = false
        self._isAbleCaphras = false
        self._ui_pc.btn_enchantGo:SetMonoTone(true)
      end
    else
      self:checkCaphrasMaterialItem()
    end
    Inventory_SetFunctor(PaGlobal_SpiritEnchant_All_InvenFilerCaphrasItem, PaGlobal_SpiritEnchant_All_RClickCaphrasItem, PaGlobalFunc_SpiritEnchant_All_CloseForEnchant, nil)
  end
  if false == self._isConsole then
    self._slotResult_Caphras.icon:addInputEvent("Mouse_On", "HandleEventOnOut_SpiritEnchant_All_CaphrasEquipSlotTooltip(true, true)")
  end
  if self._isPossiblePromotion then
    local enchantItemWrapper = getInventoryItemByType(self._grantItemWhereType, self._grantItemSlotNo)
    if nil == enchantItemWrapper then
      return
    end
    local nextEnchantItemSSW = self:getNextEnchantItemSSW(enchantItemWrapper)
    if nil ~= nextEnchantItemSSW then
      self._slotResult_Caphras:setItemByStaticStatus(nextEnchantItemSSW)
      self._slotResult_Caphras.icon:SetMonoTone(false)
      if false == self._isConsole then
        self._slotResult_Caphras.icon:addInputEvent("Mouse_On", "HandleEventOnOut_SpiritEnchant_All_CaphrasEquipSlotTooltip(true, true, true)")
      end
    end
  end
end
function PaGlobal_SpiritEnchant_All:checkCaphrasMaterialItem()
  if true == self._isPossibleMaterial then
    self._isAbleCaphras = true
    self._ui_pc.btn_enchantGo:SetMonoTone(false)
  else
    self._isAbleCaphras = false
    self._ui_pc.btn_enchantGo:SetMonoTone(true)
  end
end
function PaGlobal_SpiritEnchant_All:setText_NextCaphrasStats()
  local curStack = self._enchantInfo:ToClient_getCurStack()
  local curLevel = self._enchantInfo:ToClient_getCurLevel()
  local maxLevel = self._enchantInfo:ToClient_getMaxLevel()
  if maxLevel == curLevel then
    self._ui_enchant.txt_caphrasNextStep:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_MAXLEVEL", "maxLevel", maxLevel))
    self._ui_enchant.txt_caphrasNextMaterialInfo:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_MAXLEVEL_DESC"))
    self._ui_enchant.stc_caphrasLeftWing:SetShow(true)
    self._ui_enchant.stc_caphrasLeftLine:SetShow(true)
  elseif curLevel < maxLevel then
    self._ui_enchant.txt_caphrasNextStep:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_NEXTLEVEL", "nextLevel", curLevel + 1))
    local itemWrapper = getInventoryItemByType(self._grantItemWhereType, self._grantItemSlotNo)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      local cronkey = itemSSW:getCronKey()
      local enchantLevel = itemSSW:get()._key:getEnchantLevel()
      local cronEnchantSSW = ToClient_GetCronEnchantWrapper(cronkey, enchantLevel, curLevel)
      local stats = {
        [1] = {
          str = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_ATTACK"),
          val = cronEnchantSSW:getAddedDD()
        },
        [2] = {
          str = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_HIT"),
          val = cronEnchantSSW:getAddedHIT()
        },
        [3] = {
          str = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_DODGE"),
          val = cronEnchantSSW:getAddedDV()
        },
        [4] = {
          str = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_DODGE"),
          val = cronEnchantSSW:getAddedHDV()
        },
        [5] = {
          str = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_REDUCE"),
          val = cronEnchantSSW:getAddedPV()
        },
        [6] = {
          str = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_REDUCE"),
          val = cronEnchantSSW:getAddedHPV()
        },
        [7] = {
          str = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_HP"),
          val = cronEnchantSSW:getAddedMaxHP()
        },
        [8] = {
          str = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_MP"),
          val = cronEnchantSSW:getAddedMaxMP()
        }
      }
      local statsCount = 1
      self._ui_enchant.stc_caphrasLeftWing:SetShow(false)
      self._ui_enchant.stc_caphrasLeftLine:SetShow(false)
      for idx = 1, self._caphrasStatsMaxCount do
        self._ui_enchant.txt_caphrasStatusTitleL[idx]:SetShow(false)
        self._ui_enchant.txt_caphrasStatusValueL[idx]:SetShow(false)
      end
      for idx = 1, #stats do
        if stats[idx].val > 0 then
          self._ui_enchant.txt_caphrasStatusTitleL[statsCount]:SetText(stats[idx].str)
          self._ui_enchant.txt_caphrasStatusValueL[statsCount]:SetText("+" .. tostring(stats[idx].val))
          if 1 ~= statsCount then
            if false == self._ui_enchant.txt_caphrasStatusTitleL[statsCount - 1]:IsAutoWrapText() and false == self._ui_enchant.txt_caphrasStatusTitleL[statsCount]:IsAutoWrapText() then
              self._ui_enchant.txt_caphrasStatusTitleL[statsCount]:SetPosY(self._ui_enchant.txt_caphrasStatusTitleL[statsCount - 1]:GetPosY() + 20)
              self._ui_enchant.txt_caphrasStatusValueL[statsCount]:SetPosY(self._ui_enchant.txt_caphrasStatusValueL[statsCount - 1]:GetPosY() + 20)
            else
              self._ui_enchant.txt_caphrasStatusTitleL[statsCount]:SetPosY(self._ui_enchant.txt_caphrasStatusTitleL[statsCount - 1]:GetPosY() + 30)
              self._ui_enchant.txt_caphrasStatusValueL[statsCount]:SetPosY(self._ui_enchant.txt_caphrasStatusValueL[statsCount - 1]:GetPosY() + 30)
            end
          end
          self._ui_enchant.txt_caphrasStatusTitleL[statsCount]:SetShow(true)
          self._ui_enchant.txt_caphrasStatusValueL[statsCount]:SetShow(true)
          statsCount = statsCount + 1
        end
        if statsCount >= self._caphrasStatsMaxCount then
          break
        end
      end
      if 1 ~= statsCount then
        self._ui_enchant.stc_caphrasLeftWing:SetShow(true)
        self._ui_enchant.stc_caphrasLeftLine:SetShow(true)
      end
      local previousLevelStack = self._enchantInfo:ToClient_getStackForLevel(curLevel - 1)
      if 0 == curLevel then
        previousLevelStack = 0
      end
      local nextLevelStack = self._enchantInfo:ToClient_getStackForLevel(curLevel)
      self:setText_NeedNextCaphras(curStack - previousLevelStack, self._enchantInfo:ToClient_getStackForLevel(curLevel) - previousLevelStack, nextLevelStack - curStack)
    end
  end
end
function PaGlobal_SpiritEnchant_All:setText_NeedNextCaphras(curStack, maxStack, nextStack)
  local rate = 0
  if maxStack ~= 0 then
    rate = curStack / maxStack * 100
  end
  if nil ~= nextStack then
    self._ui_enchant.txt_caphrasNextMaterialInfo:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_NEEDCOUNT", "needCount", nextStack))
  end
end
function PaGlobal_SpiritEnchant_All:setText_CurCaphrasStats()
  local curLevel = self._enchantInfo:ToClient_getCurLevel()
  self._ui_enchant.txt_caphrasCurStep:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_CURLEVEL", "curLevel", curLevel))
  local statsCount = 1
  local stats = {
    [1] = {
      str = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_ATTACK"),
      val = PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getAddedDD()
    },
    [2] = {
      str = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_HIT"),
      val = PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getAddedHIT()
    },
    [3] = {
      str = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_DODGE"),
      val = PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getAddedDV()
    },
    [4] = {
      str = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_DODGE"),
      val = PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getAddedHDV()
    },
    [5] = {
      str = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_REDUCE"),
      val = PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getAddedPV()
    },
    [6] = {
      str = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_REDUCE"),
      val = PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getAddedHPV()
    },
    [7] = {
      str = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_HP"),
      val = PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getAddedHP()
    },
    [8] = {
      str = PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_MP"),
      val = PaGlobal_SpiritEnchant_All._enchantInfo:ToClient_getAddedMP()
    }
  }
  self._ui_enchant.stc_caphrasRightWing:SetShow(true)
  self._ui_enchant.stc_caphrasRightLine:SetShow(true)
  for idx = 1, self._caphrasStatsMaxCount do
    self._ui_enchant.txt_caphrasStatusTitleR[idx]:SetShow(false)
    self._ui_enchant.txt_caphrasStatusValueR[idx]:SetShow(false)
    self._ui_enchant.txt_caphrasEffect:SetShow(false)
  end
  for idx = 1, #stats do
    if stats[idx].val > 0 then
      self._ui_enchant.txt_caphrasStatusTitleR[statsCount]:SetText(stats[idx].str)
      self._ui_enchant.txt_caphrasStatusValueR[statsCount]:SetText("+" .. tostring(stats[idx].val))
      if 1 ~= statsCount then
        if false == self._ui_enchant.txt_caphrasStatusTitleR[statsCount - 1]:IsAutoWrapText() and false == self._ui_enchant.txt_caphrasStatusTitleR[statsCount]:IsAutoWrapText() then
          self._ui_enchant.txt_caphrasStatusTitleR[statsCount]:SetPosY(self._ui_enchant.txt_caphrasStatusTitleR[statsCount - 1]:GetPosY() + 20)
          self._ui_enchant.txt_caphrasStatusValueR[statsCount]:SetPosY(self._ui_enchant.txt_caphrasStatusValueR[statsCount - 1]:GetPosY() + 20)
        else
          self._ui_enchant.txt_caphrasStatusTitleR[statsCount]:SetPosY(self._ui_enchant.txt_caphrasStatusTitleR[statsCount - 1]:GetPosY() + 30)
          self._ui_enchant.txt_caphrasStatusValueR[statsCount]:SetPosY(self._ui_enchant.txt_caphrasStatusValueR[statsCount - 1]:GetPosY() + 30)
        end
      end
      self._ui_enchant.txt_caphrasStatusTitleR[statsCount]:SetShow(true)
      self._ui_enchant.txt_caphrasStatusValueR[statsCount]:SetShow(true)
      statsCount = statsCount + 1
    end
    if statsCount >= self._caphrasStatsMaxCount then
      break
    end
  end
  if 1 ~= statsCount then
    self._ui_enchant.txt_caphrasEffect:SetShow(true)
  end
end
function PaGlobal_SpiritEnchant_All:setProgress_CaphrasStep()
  local curStack = self._enchantInfo:ToClient_getCurStack()
  local curLevel = self._enchantInfo:ToClient_getCurLevel()
  local maxLevel = self._enchantInfo:ToClient_getMaxLevel()
  local nextLevel = curLevel + 1
  if maxLevel < nextLevel then
    nextLevel = maxLevel
  end
  self._ui_enchant.progress_caphrasCurExp:SetProgressRate(curLevel / maxLevel * 100)
  self._ui_enchant.progress_caphrasNextExp:SetProgressRate(nextLevel / maxLevel * 100)
  local progressStartPosY = self._ui_enchant.progress_caphrasCurExp:GetPosY() + self._ui_enchant.progress_caphrasCurExp:GetSizeY()
  local progressSizeY = self._ui_enchant.progress_caphrasCurExp:GetSizeY()
  local rightLineHalfSizeY = self._ui_enchant.stc_caphrasRightLine:GetSizeY() / 2
  local leftLineHalfSizeY = self._ui_enchant.stc_caphrasLeftLine:GetSizeY() / 2
  local stepSizeY = progressSizeY / maxLevel
  local curProgressPosY = stepSizeY * curLevel
  local nextProgressPosY = stepSizeY * nextLevel
  local rightLinePosY = progressStartPosY - curProgressPosY - rightLineHalfSizeY
  local leftLinePosY = progressStartPosY - nextProgressPosY - leftLineHalfSizeY
  self._ui_enchant.stc_caphrasRightLine:SetPosY(rightLinePosY)
  self._ui_enchant.stc_caphrasLeftLine:SetPosY(leftLinePosY)
  self._ui_enchant.stc_caphrasRightWing:SetPosY(rightLinePosY - 20)
  self._ui_enchant.stc_caphrasLeftWing:SetPosY(leftLinePosY - 50)
end
function PaGlobal_SpiritEnchant_All:setCaphrasEnchantMaterial(isMonotone, count)
  local slotNo = self._enchantInfo:ToClient_getCaphRasSlotNo()
  local inventoryType = self._enchantInfo:ToClient_getCaphRasItemWhereType()
  local curStack = self._enchantInfo:ToClient_getCurStack()
  local curLevel = self._enchantInfo:ToClient_getCurLevel()
  local maxLevel = self._enchantInfo:ToClient_getMaxLevel()
  local nextLevelStack = self._enchantInfo:ToClient_getStackForLevel(curLevel)
  self._enchantInfo:materialClearData()
  local itemWrapper
  local itemCount = 0
  if false == isMonotone then
    itemWrapper = getInventoryItemByType(inventoryType, slotNo)
    if nil ~= itemWrapper then
      itemCount = Int64toInt32(itemWrapper:getCount())
      count = Int64toInt32(count)
    else
      isMonotone = true
    end
  end
  if true == isMonotone or 0 ~= self._enchantInfo:ToClient_setCronEnchantSlot(inventoryType, slotNo, count) then
    self:setItemToSlotMonoTone(self._slotMaterial_Caphras, ToClient_getPromotionEnchantItem(), true)
    self._ui_enchant.txt_caphrasCount:SetShow(false)
    self._enchantInfo:materialClearData()
    return
  end
  if nil == itemWrapper then
    return
  end
  self:clearItemSlot(self._slotMaterial_Caphras)
  self._ui_enchant.txt_caphrasCount:SetShow(true)
  if maxLevel == curLevel then
    self._ui_enchant.txt_caphrasCount:SetText(tostring(itemCount))
  else
    self._ui_enchant.txt_caphrasCount:SetText(tostring(count) .. "/" .. tostring(itemCount))
  end
  if itemCount >= count and curLevel < maxLevel and false == isMonotone then
    self:setItemToSlot(self._slotMaterial_Caphras, slotNo, itemWrapper, inventoryType)
    self._isPossibleMaterial = true
  else
    self:setItemToSlotMonoTone(self._slotMaterial_Caphras, itemWrapper:getStaticStatus(), true)
    self._isPossibleMaterial = false
  end
  self:checkCaphrasMaterialItem()
end
function PaGlobal_SpiritEnchant_All:setAsCaphrasEnchantButton()
  if false == self._isConsole then
    self._ui_pc.btn_enchantGo:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_APPLY_BUTTON_NORM_CAPHRAS"))
  else
    self._ui_console.stc_enchantGoY:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_APPLY_BUTTON_NORM_CAPHRAS"))
    self._ui_console.stc_enchantGoY:SetMonoTone(false)
    Panel_Window_StackExtraction_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandlePadEventY_SpiritEnchant_All_CaphrasEnchantApplyButton()")
  end
end
function PaGlobal_SpiritEnchant_All:setAsPromotionEnchantButton()
  if false == self._isConsole then
    self._ui_pc.btn_enchantGo:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_APPLY_BUTTON_MAX_CAPHRAS"))
  else
    self._ui_console.stc_enchantGoY:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_APPLY_BUTTON_MAX_CAPHRAS"))
    self._ui_console.stc_enchantGoY:SetMonoTone(false)
    Panel_Window_StackExtraction_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandlePadEventY_SpiritEnchant_All_CaphrasEnchantApplyButton()")
  end
end
function PaGlobal_SpiritEnchant_All:setCaphrasTarget(slotNo, itemWrapper, inventoryType, isMonotone, isPromotion)
  if nil == slotNo or nil == itemWrapper or nil == inventoryType then
    return false
  end
  self:clearCaphrasSlot()
  self._isLastEnchant = false
  self._enchantInfo = getEnchantInformation()
  self._enchantInfo:ToClient_clearData()
  if 0 ~= self._enchantInfo:ToClient_setCronEnchantSlot(inventoryType, slotNo, 0) then
    return false
  end
  self:setItemToSlot(self._slotEquip_Caphras, slotNo, itemWrapper, inventoryType)
  self:setItemToSlotMonoTone(self._slotResult_Caphras, itemWrapper:getStaticStatus(), true)
  if false == self._isConsole then
    self._slotEquip_Caphras.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_SpiritEnchant_All_CaphrasEquipRelease()")
    self._slotMaterial_Caphras.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_SelectCaphrasStone()")
  end
  self._grantItemSlotNo = slotNo
  self._grantItemWhereType = inventoryType
  self:didSetCaphrasEnchantTarget(itemWrapper, isMonotone, isPromotion)
end
function PaGlobal_SpiritEnchant_All:caphrasEnchantApplyButton()
  if true == self._isPossiblePromotion then
    if true == self._isAnimating then
      if false == self._isConsole then
        self:cancleCaphrasPromotion()
      end
      return
    else
      if false == self._isAbleCaphras then
        return
      end
      local function promotionConfirm()
        self:willStartPromotionEnchant()
      end
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_MESSAGETITLE"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PROMOTE_WARNING_CAPHRAS"),
        functionYes = promotionConfirm,
        functionNo = MessageBox_Empty_function
      }
      MessageBox.showMessageBox(messageBoxData)
    end
  elseif true == self._isAnimating then
    if false == self._isConsole then
      self:cancleCaphrasEnchant()
    end
    return
  else
    if false == self._isAbleCaphras then
      return
    end
    self:willStartCaphrasEnchant()
  end
end
function PaGlobal_SpiritEnchant_All:willStartCaphrasEnchant()
  if false == self._ui_enchant.chk_skipAni:IsCheck() then
    self:startCaphrasEnchantAnimation()
  else
    self:startCaphrasEnchant()
  end
end
function PaGlobal_SpiritEnchant_All:willStartPromotionEnchant()
  if false == self._ui_enchant.chk_skipAni:IsCheck() then
    self:startCaphrasEnchantAnimation()
  else
    self:startPromotionEnchant()
  end
end
function PaGlobal_SpiritEnchant_All:startCaphrasEnchantAnimation()
  self:addCaphrasEnchantEffect()
  self._effectTime = self._originEffectTime
  self._startTime = self._effectTime - 1.5
  self:setAsCancelButton()
  ToClient_BlackspiritEnchantStart()
  self._animationTimeStamp = 0
  self._isAnimating = true
  if true == _ContentsGroup_NewUI_Dialog_All and nil ~= Panel_Npc_Dialog_All then
    Panel_Npc_Dialog_All:SetIgnoreChild(true)
  elseif nil ~= Panel_Npc_Dialog then
    Panel_Npc_Dialog:SetIgnoreChild(true)
  end
  self._ui_extraction.btn_subRadio[1]:SetIgnore(true)
  self._ui_extraction.btn_subRadio[2]:SetIgnore(true)
  for i = 1, #self._ui.btn_mainRadio do
    self._ui.btn_mainRadio[i]:SetIgnore(true)
  end
  audioPostEvent_SystemUi(5, 6)
  _AudioPostEvent_SystemUiForXBOX(5, 6)
  audioPostEvent_SystemUi(5, self._audio._caphras_idxB)
  _AudioPostEvent_SystemUiForXBOX(5, self._audio._caphras_idxB)
end
function PaGlobal_SpiritEnchant_All:startCaphrasEnchant()
  self:setAsCaphrasEnchantButton()
  if true == Panel_Window_StackExtraction_All:GetShow() then
    self._enchantInfo:ToClient_doCronEnchant()
  end
  self:cancleCaphrasEnchant()
end
function PaGlobal_SpiritEnchant_All:startPromotionEnchant()
  self:setAsPromotionEnchantButton()
  if true == Panel_Window_StackExtraction_All:GetShow() then
    self._enchantInfo:ToClient_doCronPromotion()
  end
end
function PaGlobal_SpiritEnchant_All:addCaphrasEnchantEffect()
  local curLevel = self._enchantInfo:ToClient_getCurLevel()
  if 19 == curLevel then
    self._ui_enchant.stc_caphrasImage:EraseAllEffect()
    self._ui_enchant.stc_caphrasImage:AddEffect("fUI_ReinforcementCaphras_01B", true, 0, 0)
  else
    self._ui_enchant.stc_caphrasImage:EraseAllEffect()
    self._ui_enchant.stc_caphrasImage:AddEffect("fUI_ReinforcementCaphras_01A", true, 0, 0)
  end
end
function PaGlobal_SpiritEnchant_All:cancleCaphrasPromotion()
  self._isAnimating = false
  if true == _ContentsGroup_NewUI_Dialog_All and nil ~= Panel_Npc_Dialog_All then
    Panel_Npc_Dialog_All:SetIgnoreChild(false)
  elseif nil ~= Panel_Npc_Dialog then
    Panel_Npc_Dialog:SetIgnoreChild(false)
  end
  self._ui_extraction.btn_subRadio[1]:SetIgnore(false)
  self._ui_extraction.btn_subRadio[2]:SetIgnore(false)
  for i = 1, #self._ui.btn_mainRadio do
    self._ui.btn_mainRadio[i]:SetIgnore(false)
  end
  self:removeCaprhasEnchantEffect()
  self:setAsPromotionEnchantButton()
  audioPostEvent_SystemUi(5, 99)
  _AudioPostEvent_SystemUiForXBOX(5, 99)
  self._ui_enchant.chk_skipAni:SetIgnore(false)
  ToClient_BlackspiritEnchantCancel()
end
function PaGlobal_SpiritEnchant_All:cancleCaphrasEnchant()
  self._isAnimating = false
  if true == _ContentsGroup_NewUI_Dialog_All and nil ~= Panel_Npc_Dialog_All then
    Panel_Npc_Dialog_All:SetIgnoreChild(false)
  elseif nil ~= Panel_Npc_Dialog then
    Panel_Npc_Dialog:SetIgnoreChild(false)
  end
  self._ui_extraction.btn_subRadio[1]:SetIgnore(false)
  self._ui_extraction.btn_subRadio[2]:SetIgnore(false)
  for i = 1, #self._ui.btn_mainRadio do
    self._ui.btn_mainRadio[i]:SetIgnore(false)
  end
  self:removeCaprhasEnchantEffect()
  self:setAsCaphrasEnchantButton()
  audioPostEvent_SystemUi(5, 99)
  _AudioPostEvent_SystemUiForXBOX(5, 99)
  self._ui_enchant.chk_skipAni:SetIgnore(false)
  ToClient_BlackspiritEnchantCancel()
end
function PaGlobal_SpiritEnchant_All:removeCaprhasEnchantEffect()
  self._ui_enchant.stc_caphrasImage:EraseAllEffect()
  self._slotResult_Caphras.icon:EraseAllEffect()
  self._slotEquip_Caphras.icon:EraseAllEffect()
  self._slotMaterial_Caphras.icon:EraseAllEffect()
end
function PaGlobal_SpiritEnchant_All:didCaphrasEnchant(mainWhereType, mainSlotNo, variedCount)
  self:clearCaphrasSlot()
  self:setCaphrasTarget(mainSlotNo, getInventoryItemByType(mainWhereType, mainSlotNo), mainWhereType, true, false)
  self:showCaphrasEnchantEndEffect(variedCount)
end
function PaGlobal_SpiritEnchant_All:didCaphrasPromotion(mainWhereType, mainSlotNo)
  self:clearEnchantSlot()
  self:setCaphrasTarget(mainSlotNo, getInventoryItemByType(mainWhereType, mainSlotNo), mainWhereType, true, true)
  self:showCaphrasPromotionEndEffect()
end
function PaGlobal_SpiritEnchant_All:showCaphrasEnchantEndEffect(variedCount)
  audioPostEvent_SystemUi(5, 31)
  _AudioPostEvent_SystemUiForXBOX(5, 31)
  render_setChromaticBlur(40, 1)
  render_setPointBlur(0.05, 0.045)
  render_setColorBypass(0.85, 0.08)
  self:addEnchantSuccessEffectToItemSlot(self._slotEquip_Caphras.icon)
  self:showCaphrasEnchantResult(variedCount)
  ToClient_BlackspiritEnchantSuccess()
end
function PaGlobal_SpiritEnchant_All:showCaphrasPromotionEndEffect(variedCount)
  audioPostEvent_SystemUi(5, 31)
  _AudioPostEvent_SystemUiForXBOX(5, 31)
  render_setChromaticBlur(40, 1)
  render_setPointBlur(0.05, 0.045)
  render_setColorBypass(0.85, 0.08)
  self:addEnchantSuccessEffectToItemSlot(self._slotEquip_Caphras.icon)
  self:showPromotionResult()
  ToClient_BlackspiritEnchantSuccess()
end
function PaGlobal_SpiritEnchant_All:showCaphrasEnchantResult(variedCount)
  if nil == variedCount then
    return
  end
  PaGlobal_SpiritEnchant_All:showEnchantResultNakMessage(true, PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NEWENCHANT_RESULT_5_CAPHRAS", "count", tostring(variedCount)))
end
function PaGlobal_SpiritEnchant_All:showPromotionResult(variedCount)
  if nil == variedCount then
    return
  end
  PaGlobal_SpiritEnchant_All:showEnchantResultNakMessage(true, PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NEWENCHANT_RESULT_5_CAPHRAS", "count", tostring(variedCount)))
end
