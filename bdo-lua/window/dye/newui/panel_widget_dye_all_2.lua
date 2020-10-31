local self = PaGlobal_Dye_All
function InputMLUp_Dye_SelectCharacterType(idx)
  if idx >= self._maxTargetType or self._selected_CharacterTarget == idx then
    return
  end
  local prevIndex = self._selected_CharacterTarget
  local prevSelectEquipSlotNo = self._selected_EquipSlotNo
  self._selected_CharacterTarget = idx
  self._selected_EquipSlotNo = -1
  local bChangeSelectedCharacterType = ToClient_RequestSetTargetType(idx)
  if bChangeSelectedCharacterType then
    self._paletteShowAll = false
    self._isPearlPalette = false
    self._scrollStartIndex = 0
    self._ui.scroll_Ample:SetControlTop()
    Inventory_SetFunctor(PaGlobal_Dye_All_InventoryFilter, PaGlobal_Dye_All_Interaction_FromInventory, nil, nil)
    InputMLUp_Ample_SelectType(1, false, false)
    self:changeEquipIcon()
    self:updatePart()
    self:resetSelectedAmple()
    self:updateAmpleSlotList()
    self._selectedDyePart = {}
    self:resetToggle()
    self:setShowShyAwakenWeaponBtn(false)
    if self._isConsole then
      self._updateEquipForConsole = true
      FromClient_Dye_UpdateEquipList()
    end
  elseif self._isConsole then
    self._paletteShowAll = false
    self._isPearlPalette = false
    self._scrollStartIndex = 0
    self._ui.scroll_Ample:SetControlTop()
    Inventory_SetFunctor(PaGlobal_Dye_All_InventoryFilter, PaGlobal_Dye_All_Interaction_FromInventory, nil, nil)
    InputMLUp_Ample_SelectType(1, false, false)
    self:updatePart()
    self:resetSelectedAmple()
    self:updateAmpleSlotList()
    self._selectedDyePart = {}
    self:resetToggle()
    self._updateEquipForConsole = false
    FromClient_Dye_UpdateEquipList()
    self:changeEquipIcon()
    TooltipSimple_Hide()
    Panel_Tooltip_Item_hideTooltip()
  else
    self._selected_CharacterTarget = prevIndex
    self._selected_EquipSlotNo = prevSelectEquipSlotNo
  end
  self:setShowEnduaranceSlider()
  self:updateTargetIcon()
end
function InputMLUp_Dye_EquipPartReset(equipSlotNo, partId, slotId, uiIdx)
  ToClient_RequestClearUsedDyeingPalette(equipSlotNo, partId, slotId)
  self._selectedDyePart[equipSlotNo] = false
  self:updatePart()
  self:resetSelectedAmple()
  self:updateAmpleSlotList()
end
function InputMLUp_Dye_SelectEquipPart(partID, slotID, UIidx)
  ToClient_RequestSelectedDyeingPartSlot(self._selected_EquipSlotNo, partID, slotID)
  self._nowClickPartId = partID
  self._nowClickPartSlotId = slotID
end
function InputScroll_Dye_All_Ample_ScrollUpdate(isScrollUp)
  local movingValue = 2
  local prevStartIndex = self._scrollStartIndex
  self._scrollStartIndex = UIScroll.ScrollEvent(self._ui.scroll_Ample, isScrollUp, movingValue, self._scrollMaxRow, self._scrollStartIndex, 1)
  if prevStartIndex ~= self._scrollStartIndex then
    self:updateAmpleSlotList()
    ToClient_padSnapIgnoreGroupMove()
  end
end
function InputClicked_Dye_All_PressAmpleScroll()
  self._scrollStartIndex = math.ceil((self._scrollMaxRow - 2) * self._ui.scroll_Ample:GetControlPos())
  self:updateAmpleSlotList()
end
function InputMLUp_Ample_SelectType(index)
  local isShowAll = false
  local isPearl = false
  if 0 == index then
    isShowAll = true
    isPearl = false
  elseif 1 == index then
    isShowAll = false
    isPearl = false
  elseif 2 == index then
    isShowAll = true
    isPearl = true
  else
    return
  end
  local selfPlayer = getSelfPlayer()
  if isShowAll and isPearl then
    local dyeingPackageTime = selfPlayer:get():isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_DyeingPackage)
    if not dyeingPackageTime then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_MUST_ACTIVE_PEARLCOLOR"))
      PaGlobal_EasyBuy:Open(48)
      self:selectAmpleCategory(self._selected_AmpleCategory)
      return
    end
  end
  if isPearl ~= self._isPearlPalette then
    ToClient_RequestClearDyeingSlot(self._selected_EquipSlotNo)
    self._selectedDyePart = {}
    self._ampuleCountCheck = false
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DYE_NEW_PALETTE_PREVIEW_ACK"))
  end
  self._paletteShowAll = isShowAll
  self._scrollStartIndex = 0
  self._selectedCategoryIdx = 0
  self._isPearlPalette = isPearl
  self._selected_AmpleCategory = index
  self._ui.scroll_Ample:SetPosY(0)
  self:resetSelectedAmple()
  self:updateAmpleSlotList()
  self:selectAmpleCategory(self._selected_AmpleCategory)
end
function InputMOnOut_Dye_CategoryTooltip(isOn, ButtonIndex)
  local name = ""
  local desc, control
  if true == isOn then
    if 7 < ButtonIndex then
      if 8 == ButtonIndex then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_PALETTE_TAB_ALL")
      elseif 9 == ButtonIndex then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_PALETTE_TAB_MY")
      elseif 10 == ButtonIndex then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAUGE_DYEINGPACKEAGE_TITLE")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_PALETTE_TAB_MATERIAL_DESC_8")
      end
      control = self._rdo_AmpleCategory[ButtonIndex - 8]
      TooltipSimple_Show(control, name, desc)
    else
      control = self._rdo_Material[ButtonIndex]
      name = PAGetString(Defines.StringSheet_GAME, "LUA_PALETTE_TAB_MATERIAL_" .. ButtonIndex)
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_PALETTE_TAB_MATERIAL_DESC_" .. ButtonIndex)
      TooltipSimple_Show(control, name, desc)
    end
  else
    TooltipSimple_Hide()
  end
end
function InputMLUp_Dye_SelectMaterial(categoryIdx)
  self._nowPaletteCategoryIndex = categoryIdx
  self._scrollStartIndex = 0
  self._ui.scroll_Ample:SetControlTop()
  self._rdo_Material[categoryIdx]:SetCheck(true)
  self:resetSelectedAmple()
  self:updateAmpleSlotList()
end
function InputMLUp_Dye_SelectColor(dataIdx)
  local selectedColor
  if -1 == self._selected_EquipSlotNo then
    if nil ~= self._ampleSlot[dataIdx - self._scrollStartIndex * self._maxAmpuleColsCount] then
      self._ampleSlot[dataIdx - self._scrollStartIndex * self._maxAmpuleColsCount].btn:SetCheck(false)
    end
    return
  end
  if true == self._ui.chk_SelectAllPart:IsCheck() then
    local infoCount = ToClient_getDyeingTargetInformationCount()
    if 0 == infoCount then
      return
    end
    self._nowPaletteDataIndex = dataIdx
    for ii = 0, infoCount - 1 do
      self._nowClickPartId = self._partDyeInfo[ii][1]
      self._nowClickPartSlotId = self._partDyeInfo[ii][2]
      if -1 == self._nowClickPartId then
        return
      end
      local DyeingPaletteCategoryInfo = ToClient_requestGetPaletteCategoryInfo(self._nowPaletteCategoryIndex, self._paletteShowAll)
      local isDyeUI = true
      local ampuleCount = DyeingPaletteCategoryInfo:getCount(self._nowPaletteDataIndex, isDyeUI)
      local itemEnchantKey = DyeingPaletteCategoryInfo:getItemEnchantKey(self._nowPaletteDataIndex)
      if nil ~= itemEnchantKey then
        local itemEnchantSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
        local itemEnchantSS = itemEnchantSSW:get()
        selectedColor = getItemName(itemEnchantSS)
      end
      local convertCount = tostring(ampuleCount)
      convertCount = tonumber(convertCount)
      if 1 <= convertCount then
        self._ampuleCountCheck = false
      else
        self._ampuleCountCheck = true
        if true == self._isPearlPalette then
          self._ampuleCountCheck = false
        end
      end
      ToClient_RequestSelectedDyeingPalette(self._selected_EquipSlotNo, self._nowClickPartId, self._nowClickPartSlotId, self._nowPaletteCategoryIndex, self._nowPaletteDataIndex, self._paletteShowAll)
      if 0 < ToClient_RequestGetPartDyeingSlotCount(self._selected_EquipSlotNo, 0) then
        self._selectedDyePart[self._selected_EquipSlotNo] = true
      end
    end
  else
    self._nowPaletteDataIndex = dataIdx
    if -1 == self._nowClickPartId then
      if nil ~= self._ampleSlot[dataIdx - self._scrollStartIndex * self._maxAmpuleColsCount] then
        self._ampleSlot[dataIdx - self._scrollStartIndex * self._maxAmpuleColsCount].btn:SetCheck(false)
      end
      return
    end
    local DyeingPaletteCategoryInfo = ToClient_requestGetPaletteCategoryInfo(self._nowPaletteCategoryIndex, self._paletteShowAll)
    local isDyeUI = true
    local ampuleCount = DyeingPaletteCategoryInfo:getCount(self._nowPaletteDataIndex, isDyeUI)
    local itemEnchantKey = DyeingPaletteCategoryInfo:getItemEnchantKey(self._nowPaletteDataIndex)
    if nil ~= itemEnchantKey then
      local itemEnchantSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
      local itemEnchantSS = itemEnchantSSW:get()
      selectedColor = getItemName(itemEnchantSS)
    end
    local convertCount = tostring(ampuleCount)
    convertCount = tonumber(convertCount)
    if 1 <= convertCount then
      self._ampuleCountCheck = false
    else
      self._ampuleCountCheck = true
      if true == self._isPearlPalette then
        self._ampuleCountCheck = false
      end
    end
    ToClient_RequestSelectedDyeingPalette(self._selected_EquipSlotNo, self._nowClickPartId, self._nowClickPartSlotId, self._nowPaletteCategoryIndex, self._nowPaletteDataIndex, self._paletteShowAll)
    if 0 < ToClient_RequestGetPartDyeingSlotCount(self._selected_EquipSlotNo, 0) then
      self._selectedDyePart[self._selected_EquipSlotNo] = true
    end
  end
  Panel_Tooltip_Item_hideTooltip()
  self:updatePart()
  self:updateAmpleSlotList(self._nowPaletteDataIndex)
  if nil ~= selectedColor then
    self._ui.txt_SelectedAmple:SetShow(true)
    self._ui.txt_SelectedAmple:SetText(selectedColor)
  end
end
function InputMOnOut_Dye_AmpleColorTooltip(isShow, itemEnchantKey, UIIndex)
  if nil == self._ampleSlot[UIIndex] then
    return
  end
  local uiControl = self._ampleSlot[UIIndex].btn
  local itemEnchantSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
  local itemEnchantSS = itemEnchantSSW:get()
  local itemName = getItemName(itemEnchantSS)
  local desc
  if true == isShow then
    TooltipSimple_Show(uiControl, itemName, desc)
  else
    TooltipSimple_Hide()
  end
end
function InputMRUp_Dye_ClearEquipItemByEquipSlotNo(equipSlotNo, equipSlotIndex)
  Panel_Tooltip_Item_hideTooltip()
  ToClient_RequestClearDyeingTargetSlot(equipSlotNo)
  local removeCount = 0
  for key, value in pairs(self._selectedDyePart) do
    if value == equipSlotNo then
      removeCount = removeCount + 1
    end
  end
  for ii = 0, removeCount - 1 do
    table.remove(self._selectedDyePart, self._selectedDyePart[equipSlotNo])
  end
  self._equipSlot[equipSlotIndex].bg:SetColor(4286019447)
  if equipSlotNo == self._selected_EquipSlotNo then
    self._selected_EquipSlotNo = -1
    self:resetPart(true)
  end
end
function InputMOnOut_Dye_ShowEquipItemToolTip(isShow, equipSlotNo, slotIdx)
  if true == isShow then
    local itemWrapper = ToClient_RequestGetDyeingTargetItemWrapper(equipSlotNo)
    if nil ~= itemWrapper then
      local SlotIcon = self._equipSlot[slotIdx].icon
      Panel_Tooltip_Item_Show(itemWrapper, SlotIcon, false, true, nil, nil, nil, nil, "Dye", equipSlotNo)
    end
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function InputMLUp_Dye_SelectEquipItem(equipSlotNo, equipSlotIndex)
  for ii = 0, self._maxEquipSlotCount - 1 do
    if ii == equipSlotIndex then
      self._equipSlot[ii].bg:SetColor(4294967295)
    else
      self._equipSlot[ii].bg:SetColor(4286019447)
    end
  end
  if 29 == equipSlotNo and __eClassType_ShyWaman == self._classType then
    InputMLUp_Dye_SetAwakeWeaponAction(__eDyeingAwakenBattleActionIndex_Base)
    self:setShowShyAwakenWeaponBtn(true)
  else
    self:setShowShyAwakenWeaponBtn(false)
  end
  self._selected_EquipSlotNo = equipSlotNo
  ToClient_RequestSelectedEquipItem(equipSlotNo)
  local isWeaponEquip = false
  local isHideHelmet = self._toggleCheckValue[self._enumToggleType.Helmet]
  if (6 == equipSlotNo or 17 == equipSlotNo) and true == isHideHelmet then
    InputMLUp_Dye_SetToggle(self._enumToggleType.Helmet)
  end
  local underwearToggle = self._chk_ShowToggle[self._enumToggleType.Underwear]
  if true == underwearToggle:GetShow() then
    if 20 == equipSlotNo then
      underwearToggle:SetCheck(true)
    else
      underwearToggle:SetCheck(false)
    end
  end
  local avatarToggle = self._chk_ShowToggle[self._enumToggleType.Avatar]
  if true == avatarToggle:GetShow() then
    if 0 <= equipSlotNo and equipSlotNo <= 6 or 29 == equipSlotNo then
      avatarToggle:SetCheck(true)
    elseif 14 <= equipSlotNo and equipSlotNo <= 23 or 30 == equipSlotNo then
      avatarToggle:SetCheck(false)
    end
  end
  local awakenToggle = self._chk_ShowToggle[self._enumToggleType.AwakenWeapon]
  if true == awakenToggle:GetShow() then
    if 0 == equipSlotNo or 1 == equipSlotNo or 18 == equipSlotNo or 19 == equipSlotNo then
      isWeaponEquip = true
      if true == self._toggleCheckValue[self._enumToggleType.AwakenWeapon] then
        InputMLUp_Dye_SetToggle(self._enumToggleType.AwakenWeapon)
      end
    elseif 29 == equipSlotNo or 30 == equipSlotNo then
      isWeaponEquip = true
      if false == self._toggleCheckValue[self._enumToggleType.AwakenWeapon] then
        InputMLUp_Dye_SetToggle(self._enumToggleType.AwakenWeapon)
      end
    else
      isWeaponEquip = false
    end
  end
  if true == isWeaponEquip then
    if false == self._toggleCheckValue[self._enumToggleType.WarStance] then
      InputMLUp_Dye_SetToggle(self._enumToggleType.WarStance)
    end
  else
    if true == self._toggleCheckValue[self._enumToggleType.WarStance] then
      InputMLUp_Dye_SetToggle(self._enumToggleType.WarStance)
    end
    if true == self._toggleCheckValue[self._enumToggleType.AwakenWeapon] then
      InputMLUp_Dye_SetToggle(self._enumToggleType.AwakenWeapon)
    end
  end
  self._nowPaletteDataIndex = 1
  self._nowClickPartId = -1
  self._nowClickPartSlotId = -1
  self:resetPart(true)
  self:changeEquipIcon()
  self:updatePart()
  self:resetSelectedAmple()
  self:updateAmpleSlotList()
  InputMLUp_Dye_SetEndurance()
end
function InputMLUp_Dye_SetEndurance()
  local index = self._ui.slider_Enduarance:GetSelectIndex()
  ToClient_RequestChangeEndurance(index)
end
function InputMLUp_Dye_SetToggle(clickedType)
  if nil == self._toggleCheckValue[clickedType] then
    return
  end
  self._toggleCheckValue[clickedType] = not self._toggleCheckValue[clickedType]
  self._chk_ShowToggle[clickedType]:SetCheck(self._toggleCheckValue[clickedType])
  if clickedType == self._enumToggleType.Underwear then
    ToClient_RequestToggleShowUnderwear()
    InputMLUp_Dye_SetEndurance()
    if self._toggleCheckValue[self._enumToggleType.WarStance] then
      ToClient_RequestSetBattleView(true)
    end
  elseif clickedType == self._enumToggleType.Avatar then
    self._chk_ShowToggle[self._enumToggleType.Underwear]:SetCheck(false)
    ToClient_RequestToggleHideAvatar()
    self._selected_EquipSlotNo = -1
    self:changeEquipIcon()
    self:updatePart()
    self:updateAmpleSlotList()
  elseif clickedType == self._enumToggleType.Helmet then
    ToClient_RequestHideHelmet(not self._toggleCheckValue[clickedType])
  elseif clickedType == self._enumToggleType.FaceViewHair then
    ToClient_setFaceViewHair(self._toggleCheckValue[clickedType])
  elseif clickedType == self._enumToggleType.FaceGuard then
    ToClient_RequestHideBattleHelmet(self._toggleCheckValue[clickedType])
  elseif clickedType == self._enumToggleType.Cloak then
    ToClient_RequestHideCloak(self._toggleCheckValue[clickedType])
  elseif clickedType == self._enumToggleType.WarStance then
    ToClient_RequestSetBattleView(self._toggleCheckValue[clickedType])
  elseif clickedType == self._enumToggleType.AwakenWeapon then
    ToClient_SetAwakenWeaponShow(self._toggleCheckValue[clickedType])
  end
end
function InputMLUp_Dye_SetAwakeWeaponAction(actionIndex)
  if actionIndex == ToClient_GetAwakenWeaponActionIndex() then
    return
  end
  ToClient_SetAwakenWeaponActionIndex(actionIndex)
end
function InputMOnOut_Dye_SimpleTooltipCheckbutton(isShow, toggleType)
  if nil == getSelfPlayer() then
    return
  end
  local name, desc, control
  if self._enumToggleType.Underwear == toggleType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_SHOWUNDERWEAR")
  elseif self._enumToggleType.Avatar == toggleType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_HIDEAVATAR")
  elseif self._enumToggleType.Helmet == toggleType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_HIDEHELM")
  elseif self._enumToggleType.AwakenWeapon == toggleType then
    if __eClassType_ShyWaman == self._classType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SHY_AWAKENWEAPON_SHOW")
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_AWAKENWEAPON")
    end
  elseif self._enumToggleType.FaceViewHair == toggleType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_HIDHAIR")
  elseif self._enumToggleType.FaceGuard == toggleType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_OPENHELM")
  elseif self._enumToggleType.WarStance == toggleType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_TOOLTIP_WARSTANCE")
  elseif self._enumToggleType.Cloak == toggleType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIP_CLOAK_NAME")
  end
  control = self._chk_ShowToggle[toggleType]
  if isShow == true then
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function InputMOnOut_Dye_ShyWeaponTooltip(weaponType)
  local name, desc, control
  if __eDyeingAwakenBattleActionIndex_Lute == weaponType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DYE_SHY_LUTE")
    control = self._ui.btn_Tring
  elseif __eDyeingAwakenBattleActionIndex_Flute == weaponType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DYE_SHY_FLUTE")
    control = self._ui.btn_Tutu
  elseif __eDyeingAwakenBattleActionIndex_Djembe == weaponType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DYE_SHY_DJEMBE")
    control = self._ui.btn_Tokong
  end
  TooltipSimple_Show(control, name, desc)
end
function InputMLUp_Dye_DoDye()
  local _dyePartString = ""
  local equipSlotNo = self._selected_EquipSlotNo
  if true == self._ampuleCountCheck then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DYE_AMPULEALERT"))
    return
  end
  local function doDye()
    ToClient_RequestDye(self._isPearlPalette)
    PaGlobal_Dye_All_Close()
  end
  local function askDoDye()
    local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
    local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_DYENEW_SURE_DYE_THIS_PART", "partString", _dyePartString)
    local messageBoxData = {
      title = messageBoxTitle,
      content = messageBoxMemo,
      functionYes = doDye,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  local function alreadyPearlDye()
    local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_ALREADY_PEARLCOLOR")
    local messageBoxData = {
      title = messageBoxTitle,
      content = messageBoxMemo,
      functionYes = askDoDye,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  for index, value in pairs(self._selectedDyePart) do
    if "" == _dyePartString and true == self._selectedDyePart[index] then
      _dyePartString = "<" .. self.dyePartString[self._selected_CharacterTarget][index] .. ">"
    elseif true == self._selectedDyePart[index] then
      _dyePartString = _dyePartString .. ", <" .. self.dyePartString[self._selected_CharacterTarget][index] .. ">"
    end
  end
  if false == PaGlobal_Dye_All_IsSelectedEquipSlot() then
    if -1 == equipSlotNo then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DYE_FAIL1"))
    elseif -1 == self._nowClickPartSlotId and false == self._ui.chk_SelectAllPart:IsCheck() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DYE_FAIL2"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DYE_FAIL3"))
    end
    return
  end
  if self._isPearlPalette then
    local isAlreadyDye = ToClient_isAllreadyDyeing(equipSlotNo)
    if true == isAlreadyDye then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DYENEW_ALREADY_NORMALCOLOR"))
      return
    elseif "" == _dyePartString then
      doDye()
    else
      askDoDye()
    end
  else
    local isAlreadyPearlDye = ToClient_isExpirationDyeing(equipSlotNo)
    if true == isAlreadyPearlDye then
      alreadyPearlDye()
    elseif "" == _dyePartString then
      doDye()
    else
      askDoDye()
    end
  end
end
function FromClient_Dye_UpdateEquipList()
  local haveNormalEquip, haveAvartarEquip
  for idx, equipSlotWarraper in pairs(self._equipSlotIcon[self._selected_CharacterTarget]) do
    local fixedIndex = idx - 1
    local itemWrapper = ToClient_RequestGetDyeingTargetItemWrapper(equipSlotWarraper[1])
    local isDyeAble = false
    if nil ~= itemWrapper then
      isDyeAble = itemWrapper:isDyeable()
    end
    local UISlotItem = self._equipSlot[fixedIndex]
    if nil ~= UISlotItem then
      UISlotItem.icon:SetIgnore(true)
      UISlotItem.icon:addInputEvent("Mouse_LUp", "")
      UISlotItem.icon:addInputEvent("Mouse_RUp", "")
      UISlotItem.icon:addInputEvent("Mouse_On", "")
      UISlotItem.icon:addInputEvent("Mouse_Out", "")
      if true == isDyeAble and nil ~= itemWrapper and (not self._isConsole or false ~= self._updateEquipForConsole) then
        UISlotItem:setItem(itemWrapper)
        UISlotItem.icon:getBaseTexture():setUV(0, 0, 1, 1)
        UISlotItem.icon:setRenderTexture(UISlotItem.icon:getBaseTexture())
        UISlotItem.icon:SetIgnore(false)
        UISlotItem.icon:addInputEvent("Mouse_LUp", "InputMLUp_Dye_SelectEquipItem( " .. equipSlotWarraper[1] .. "," .. fixedIndex .. " ) ")
        UISlotItem.icon:addInputEvent("Mouse_RUp", "InputMRUp_Dye_ClearEquipItemByEquipSlotNo( " .. equipSlotWarraper[1] .. "," .. fixedIndex .. " ) ")
        UISlotItem.icon:addInputEvent("Mouse_On", "InputMOnOut_Dye_ShowEquipItemToolTip( true, " .. equipSlotWarraper[1] .. ", " .. fixedIndex .. " )")
        UISlotItem.icon:addInputEvent("Mouse_Out", "InputMOnOut_Dye_ShowEquipItemToolTip( false, " .. equipSlotWarraper[1] .. ", " .. fixedIndex .. " )")
      end
    end
  end
end
function FromClient_Dye_NotifyPearlCount()
  if not Panel_Widget_Dye_All:GetShow() then
    return
  end
  Inventory_updateSlotData()
  if nil ~= Panel_IngameCashShop_EasyPayment and Panel_IngameCashShop_EasyPayment:GetShow() then
    PaGlobal_EasyBuy_Close()
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DYE_NOTIFY_BUYGOODS"))
end
function FromClient_Dye_UpdateDyeingPartList()
  self:updatePart()
end
function PaGlobal_Dye_All_Close()
  if MessageBoxGetShow() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DYE_RENEW_HIDE_FIRSTHIDESYSTEM_ACK"))
    return
  end
  if false == Panel_Widget_Dye_All:GetShow() and false == Panel_Widget_CharacterController_All:GetShow() then
    return
  end
  PaGlobalFunc_FullScreenFade_RunAfterFadeIn(PaGlobal_Dye_All_CloseActual)
  Inventory_SetFunctor(nil, nil, nil, nil)
end
function PaGlobal_Dye_All_CloseFunction()
  messageBox_CloseButtonUp()
  if false == Panel_Widget_Dye_All:GetShow() and false == Panel_Widget_CharacterController_All:GetShow() then
    return
  end
  PaGlobalFunc_FullScreenFade_RunAfterFadeIn(PaGlobal_Dye_All_CloseActual)
end
function PaGlobal_Dye_All_CloseActual()
  PaGlobal_Dye_All:prepareClose()
end
function PaGlobal_Dye_All_Open()
  if nil == getSelfPlayer() then
    return
  end
  if not PaGlobal_Dye_All_IsShowable() then
    return
  end
  PaGlobalFunc_FullScreenFade_RunAfterFadeIn(PaGlobal_Dye_All_OpenActual)
  _AudioPostEvent_SystemUiForXBOX(1, 23)
  if false == self._isConsole then
    FGlobal_Hide_Tooltip_Work(nil, true)
  end
end
function PaGlobal_Dye_All_IsShowable()
  if isDeadInWatchingMode() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DYEOPENALERT_INDEAD"))
    return false
  end
  if isFlushedUI() then
    return false
  end
  if true == ToClient_getJoinGuildBattle() then
    return false
  end
  if true == ToClient_DyeingManagerIsShow() then
    return false
  end
  if false == ToClient_DyeingManagerIsShowable() then
    return false
  end
  if false == ToClient_IsAutoLevelUp() and not IsSelfPlayerWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_DYE"))
    return false
  end
  if selfPlayerIsInCompetitionArea() then
    return false
  end
  if true == ToClient_SniperGame_IsPlaying() then
    return false
  end
  return true
end
function PaGlobal_Dye_All_OpenActual()
  self:prepareOpen()
end
local ENUM_EQUIP = CppEnums.EquipSlotNoClient
function PaGlobal_Dye_All_IsDyeableEquipment(equipSlotNo)
  if PaGlobal_Dye_All_IsAvatar(equipSlotNo) then
    return true
  elseif PaGlobal_Dye_All_IsNormal(equipSlotNo) then
    return true
  elseif ENUM_EQUIP.eEquipSlotNoAvatarUnderwear == equipSlotNo and self._enumCharacterType.Character == self._selected_CharacterTarget then
    return true
  elseif (ENUM_EQUIP.eEquipSlotNoFaceDecoration1 == equipSlotNo or ENUM_EQUIP.eEquipSlotNoFaceDecoration2 == equipSlotNo or ENUM_EQUIP.eEquipSlotNoFaceDecoration3 == equipSlotNo) and self._enumCharacterType.Character == self._selected_CharacterTarget then
    return true
  end
  return false
end
function PaGlobal_Dye_All_IsAvatar(equipSlotNo)
  if self._enumCharacterType.Character == self._selected_CharacterTarget then
    if ENUM_EQUIP.eEquipSlotNoAvatarChest == equipSlotNo or ENUM_EQUIP.eEquipSlotNoAvatarGlove == equipSlotNo or ENUM_EQUIP.eEquipSlotNoAvatarBoots == equipSlotNo or ENUM_EQUIP.eEquipSlotNoAvatarHelm == equipSlotNo or ENUM_EQUIP.eEquipSlotNoAvatarWeapon == equipSlotNo or ENUM_EQUIP.eEquipSlotNoAvatarSubWeapon == equipSlotNo or ENUM_EQUIP.eEquipSlotNoAvatarAwakenWeapon == equipSlotNo then
      return true
    end
  elseif self._enumCharacterType.Horse == self._selected_CharacterTarget and (ENUM_EQUIP.eEquipSlotNoAvatarChest == equipSlotNo or ENUM_EQUIP.eEquipSlotNoAvatarGlove == equipSlotNo or ENUM_EQUIP.eEquipSlotNoAvatarBoots == equipSlotNo or ENUM_EQUIP.eEquipSlotNoAvatarHelm == equipSlotNo) then
    return true
  end
  return false
end
function PaGlobal_Dye_All_IsNormal(equipSlotNo)
  if 0 == self._selected_CharacterTarget then
    if ENUM_EQUIP.eEquipSlotNoRightHand == equipSlotNo or ENUM_EQUIP.eEquipSlotNoLeftHand == equipSlotNo or ENUM_EQUIP.eEquipSlotNoChest == equipSlotNo or ENUM_EQUIP.eEquipSlotNoGlove == equipSlotNo or ENUM_EQUIP.eEquipSlotNoBoots == equipSlotNo or ENUM_EQUIP.eEquipSlotNoHelm == equipSlotNo or ENUM_EQUIP.eEquipSlotNoAwakenWeapon == equipSlotNo then
      return true
    end
  elseif 1 == self._selected_CharacterTarget and (ENUM_EQUIP.eEquipSlotNoChest == equipSlotNo or ENUM_EQUIP.eEquipSlotNoGlove == equipSlotNo or ENUM_EQUIP.eEquipSlotNoBoots == equipSlotNo or ENUM_EQUIP.eEquipSlotNoHelm == equipSlotNo or ENUM_EQUIP.eEquipSlotNoBelt == equipSlotNo) then
    return true
  end
  return false
end
function PaGlobal_Dye_All_InventoryFilter(InvenSlotNo, itemWrapper, currentWhereType)
  if nil == itemWrapper then
    return true
  end
  local isServantUseable = itemWrapper:getStaticStatus():isUsableServant()
  if 0 == self._selected_CharacterTarget and isServantUseable then
    return true
  elseif (self._enumCharacterType.Horse == self._selected_CharacterTarget or self._enumCharacterType.Camel == self._selected_CharacterTarget or self._enumCharacterType.Tent == self._selected_CharacterTarget) and not isServantUseable then
    return true
  end
  if itemWrapper:isDyeable() then
    return false
  end
  local equipSlotNo = itemWrapper:getStaticStatus():getEquipSlotNo()
  if PaGlobal_Dye_All_IsDyeableEquipment(equipSlotNo) then
    if itemWrapper:isDyeable() then
      return false
    else
      return true
    end
  end
  return true
end
function PaGlobal_Dye_All_Reset_SetFunctor()
  Inventory_SetFunctor(PaGlobal_Dye_All_InventoryFilter, PaGlobal_Dye_All_Interaction_FromInventory, nil, nil)
end
function PaGlobal_Dye_All_Interaction_FromInventory(invenSlotNo, itemWrapper, count_s64, inventoryType)
  ToClient_RequestSetDyeTargetSlotByInventorySlotNo(Inventory_GetCurrentInventoryType(), invenSlotNo)
end
function PaGlobal_Dye_All_IsSelectedEquipSlot()
  if nil == self._selectedDyePart then
    return false
  end
  for index, value in pairs(self._selectedDyePart) do
    if true == self._selectedDyePart[index] then
      return true
    end
  end
  return false
end
function PaGlobal_Dye_All_OnPadB()
  if nil ~= Panel_Window_Palette_All and true == Panel_Window_Palette_All:GetShow() then
    PaGlobal_Palette_All_Close()
    return
  end
  PaGlobal_Dye_All_Close()
end
function InputLTRT_Dye_ChangeAmpleType(value)
  self._selected_AmpleCategory = self._selected_AmpleCategory + value
  if self._selected_AmpleCategory < 0 then
    self._selected_AmpleCategory = 2
  elseif self._selected_AmpleCategory > 2 then
    self._selected_AmpleCategory = 0
  end
  InputMLUp_Ample_SelectType(self._selected_AmpleCategory)
end
function InputMOn_Dye_SetShowKeyGuideX(isShow)
  self._ui_console.txt_KeyGuideX:SetShow(isShow)
  self:alignKeyGuide()
end
function InputLBRB_Dye_ChangeTarget(value)
  local newValue = self._selected_CharacterTarget
  newValue = newValue + value
  if self._enumCharacterType.Empty == newValue then
    newValue = newValue + value
  end
  if newValue < self._enumCharacterType.Character then
    newValue = self._enumCharacterType.Tent
  elseif newValue >= self._maxTargetType then
    newValue = self._enumCharacterType.Character
  end
  InputMLUp_Dye_SelectCharacterType(newValue)
end
