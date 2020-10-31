function PaGlobal_SA_Widget_Inventory:initialize()
  if true == PaGlobal_SA_Widget_Inventory._initialize then
    return
  end
  self:controlTopGroup_Init()
  self:controlEquipGroup_Init()
  self:controlInvenGroup_Init()
  self:registEventHandler()
  self:validate()
  self:createEquipSlot()
  self:setSymbolIcon()
  self:setEquipGroupInfo()
  self:createInvenFrame()
  self._ui.btn_all:SetCheck(true)
  Panel_SA_Widget_Inventory:ActiveMouseEventEffect(true)
  Panel_SA_Widget_Inventory:setMaskingChild(true)
  Panel_SA_Widget_Inventory:setGlassBackground(true)
  self._initialize = true
end
function PaGlobal_SA_Widget_Inventory:registEventHandler()
  if nil == Panel_SA_Widget_Inventory then
    return
  end
  registerEvent("onScreenResize", "FromClient_SA_Widget_Inventory_ReSizePanel()")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_SA_Widget_Inventory_Close()")
  registerEvent("EventEquipmentUpdate", "FromClient_SA_Widget_Inventory_UpdateEquipmentList")
  self._ui.btn_all:addInputEvent("Mouse_LUp", "HandleEventLUp_SA_Widget_Inventory_Filter()")
  self._ui.btn_equip:addInputEvent("Mouse_LUp", "HandleEventLUp_SA_Widget_Inventory_Filter(" .. CppEnums.ItemType.Equip .. ")")
  self._ui.btn_posion:addInputEvent("Mouse_LUp", "HandleEventLUp_SA_Widget_Inventory_Filter(" .. CppEnums.ItemType.Skill .. ")")
  for index = 0, 2 do
    self._ui.buttons[index]:addInputEvent("Mouse_On", "HandleEventOnOut_SA_Widget_Inventory_ShowMenuTooltip(" .. index .. ", true)")
    self._ui.buttons[index]:addInputEvent("Mouse_Out", "HandleEventOnOut_SA_Widget_Inventory_ShowMenuTooltip(" .. index .. ", false)")
  end
  registerEvent("FromClient_WeightChanged", "PaGlobal_SA_Widget_Inventory_UpdateInventory")
  registerEvent("FromClient_InventoryUpdate", "PaGlobal_SA_Widget_Inventory_UpdateInventory")
  registerEvent("EventUnEquipItemToInventory", "PaGlobal_SA_Widget_Inventory_UnequipItem")
  registerEvent("FromClient_InventoryUpdatebyAddItem", "PaGlobal_SA_Widget_Inventory_UdateSlotDatabyAddItem")
  registerEvent("FromClient_UpdateInventoryBag", "PaGlobal_SA_Widget_Inventory_UdateSlotDatabyAddItem")
  registerEvent("FromClient_UseItemAskFromOtherPlayer", "UseItemAskFromOtherPlayer")
  registerEvent("FromClient_ReviveToInstanceField", "FromClient_SA_Widget_Inventory_EventSelfPlayerRevive")
  registerEvent("FromClient_RenderModeChangeState", "renderModeChange_inventory_FlushRestoreFunc")
  registerEvent("FromClient_cursorOnOffSignal", "FromClient_cursorOnOffSignal")
  registerEvent("EventSelfPlayerDead", "FromClient_SA_Widget_Inventory_EventSelfPlayerDead")
  UIScroll.InputEvent(self._ui.frame_vScroll, "HandleEvent_SA_Widget_Inventory_Scroll")
  self._ui.frame_1:UpdateContentScroll()
  self._ui.frame_1:UpdateContentPos()
  self._ui.frame_vScroll:SetControlPos(0)
end
function PaGlobal_SA_Widget_Inventory:prepareOpen()
  if nil == Panel_SA_Widget_Inventory then
    return
  end
  if nil ~= Panel_SA_Widget_ESCMenu and true == Panel_SA_Widget_ESCMenu:GetShow() then
    PaGlobal_SA_Widget_ESCMenu_ShowToggle()
  end
  if true == self._isDeadPlayer then
    return
  end
  self._ui.btn_all:SetCheck(true)
  self._ui.btn_equip:SetCheck(false)
  self._ui.btn_posion:SetCheck(false)
  self.filterFunc = nil
  Panel_SA_Widget_Inventory:RegisterUpdateFunc("PaGlobal_SA_Widget_Inventory_RegisterUpdateFunc")
  PaGlobal_SA_Widget_Inventory_UpdateInventory()
  ToClient_ShowMouseCursor()
  PaGlobal_SA_Widget_Inventory:open()
end
function PaGlobal_SA_Widget_Inventory:open()
  if nil == Panel_SA_Widget_Inventory then
    return
  end
  Panel_SA_Widget_Inventory:SetShow(true)
end
function PaGlobal_SA_Widget_Inventory:prepareClose()
  if nil == Panel_SA_Widget_Inventory then
    return
  end
  Panel_SA_Widget_Inventory:ClearUpdateLuaFunc()
  HandleEventOnOut_SA_Widget_Inventory_ShowItemToolTip(false, nil, nil)
  ToClient_HideMouseCursor()
  PaGlobal_SA_Widget_Inventory:close()
end
function PaGlobal_SA_Widget_Inventory:close()
  if nil == Panel_SA_Widget_Inventory then
    return
  end
  Panel_SA_Widget_Inventory:SetShow(false)
end
function PaGlobal_SA_Widget_Inventory:updateInventory()
  local useStartSlot = inventorySlotNoUserStart()
  local isFiltered = false
  for index = 0, self._maxItemSlotCnt - 1 do
    self._inventoryItemSlot[index].icon:EraseAllEffect()
    self._inventoryItemSlot[index]:clearItem()
    self._ui.stc_invenItem[index]:ChangeTextureInfoName(self._itemIconUV.path)
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_invenItem[index], self._itemIconUV.x1, self._itemIconUV.y1, self._itemIconUV.x2, self._itemIconUV.y2)
    local slotNo = index + useStartSlot
    local itemWrapper = getInventoryItemByType(self._whereType, slotNo)
    local itemExist = false
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      self._inventoryItemSlot[index]:setItem(itemWrapper, slotNo)
      self._inventoryItemSlot[index].empty = false
      if itemSSW:getItemType() == CppEnums.ItemType.Equip then
        local itemGrade = itemSSW:getGradeType()
        self._ui.stc_invenItem[index]:ChangeTextureInfoName(self._itemGradeTexUV.path)
        x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_invenItem[index], self._itemGradeTexUV[itemGrade].x1, self._itemGradeTexUV[itemGrade].y1, self._itemGradeTexUV[itemGrade].x2, self._itemGradeTexUV[itemGrade].y2)
      end
      if nil ~= self.filterFunc then
        isFiltered = self.filterFunc(slotNo, itemWrapper, self._whereType)
      end
      self._inventoryItemSlot[index].icon:SetEnable(false == isFiltered)
      self._inventoryItemSlot[index].icon:SetMonoTone(isFiltered)
      self._inventoryItemSlot[index].icon:SetIgnore(isFiltered)
      if true == isFiltered then
        self._inventoryItemSlot[index].icon:SetAlpha(0.5)
        self._inventoryItemSlot[index].icon:EraseAllEffect()
      elseif nil ~= self.filterFunc then
        self._inventoryItemSlot[index].icon:AddEffect("UI_Inventory_Filtering", true, 0, 0)
        self._inventoryItemSlot[index].isFiltered = true
      else
        self._inventoryItemSlot[index].isFiltered = false
      end
      itemExist = true
      local isUsableClass
      if nil ~= itemSSW then
        if itemSSW:get():isWeapon() or itemSSW:get():isSubWeapon() or itemSSW:get():isAwakenWeapon() then
          local classType = getSelfPlayer():getClassType()
          isUsableClass = itemSSW:get()._usableClassType:isOn(classType)
        else
          isUsableClass = true
        end
      else
        isUsableClass = false
      end
      if false == itemSSW:get():isEquipable() then
        self._inventoryItemSlot[index].icon:SetColor(Defines.Color.C_FFFFFFFF)
      elseif true == isUsableClass then
        self._inventoryItemSlot[index].icon:SetColor(Defines.Color.C_FFFFFFFF)
      else
        self._inventoryItemSlot[index].icon:SetColor(Defines.Color.C_FFD20000)
      end
    end
    if false == itemExist then
      self._inventoryItemSlot[index]:clearItem()
      self._inventoryItemSlot[index].icon:SetEnable(true)
      self._inventoryItemSlot[index].icon:SetMonoTone(true)
      self._inventoryItemSlot[index].icon:SetIgnore(false)
      self._inventoryItemSlot[index].isEmpty = true
    end
    self._ui.stc_invenItem[index]:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_invenItem[index]:setRenderTexture(self._ui.stc_invenItem[index]:getBaseTexture())
  end
end
function PaGlobal_SA_Widget_Inventory:setTopGroupInfo()
  local txtAP, txtDP = PaGlobal_SA_MainFrame_GetCharacterInfoValue()
  if nil == txtAP or nil == txtDP then
    return
  end
  self._ui.txt_attValue:SetText(txtAP)
  self._ui.txt_dpValue:SetText(txtDP)
end
function PaGlobal_SA_Widget_Inventory:setEquipGroupInfo()
  for index = 0, self._maxEquipItem - 1 do
    self._equipItemSlot[index]:clearItem()
    local path = self._equipIconTexUV.path
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_equip[index], self._equipIconTexUV[index].x1, self._equipIconTexUV[index].y1, self._equipIconTexUV[index].x2, self._equipIconTexUV[index].y2)
    local itemWrapper = ToClient_getEquipmentItem(self._equipEnum[index])
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      self._equipItemSlot[index]:setItemByStaticStatus(itemSSW, Defines.s64_const.s64_1)
      local itemGrade = itemSSW:getGradeType()
      path = self._itemGradeTexUV.path
      x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_equip[index], self._itemGradeTexUV[itemGrade].x1, self._itemGradeTexUV[itemGrade].y1, self._itemGradeTexUV[itemGrade].x2, self._itemGradeTexUV[itemGrade].y2)
    end
    self._ui.stc_equip[index]:ChangeTextureInfoName(path)
    self._ui.stc_equip[index]:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_equip[index]:setRenderTexture(self._ui.stc_equip[index]:getBaseTexture())
  end
end
function PaGlobal_SA_Widget_Inventory:setSymbolIcon()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local classType = selfPlayer:getClassType()
  if nil == self._characterIconUV[classType] then
    return
  end
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_characterIcon, self._characterIconUV[classType].x1, self._characterIconUV[classType].y1, self._characterIconUV[classType].x2, self._characterIconUV[classType].y2)
  self._ui.stc_characterIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.stc_characterIcon:setRenderTexture(self._ui.stc_characterIcon:getBaseTexture())
  self._ui.stc_characterIcon:ComputePos()
end
function PaGlobal_SA_Widget_Inventory:unequipItem(whereType, slotNo)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus():get()
  if nil == itemSSW then
    return
  end
  local useStartSlot = inventorySlotNoUserStart()
  for index = 0, self._maxItemSlotCnt - 1 do
    if slotNo == useStartSlot + index then
      self._inventoryItemSlot[index].icon:AddEffect("fUI_Item_Clear", false, 0, 0)
    end
  end
  audioPostEvent_SystemUi(2, 0)
end
function PaGlobal_SA_Widget_Inventory:createEquipSlot()
  for index = 0, self._maxEquipItem - 1 do
    local equipItemSlot = {}
    SlotItem.new(equipItemSlot, "equipSlot", nil, self._ui.stc_equip[index], self.slotConfig_Equip)
    equipItemSlot:createChild()
    equipItemSlot:clearItem()
    self._equipItemSlot[index] = equipItemSlot
    self._equipItemSlot[index].icon:addInputEvent("Mouse_RUp", "Equipment_RClick(" .. self._equipEnum[index] .. ")")
    local whereType = CppEnums.ItemWhereType.eEquip
    self._equipItemSlot[index].icon:addInputEvent("Mouse_On", "HandleEventOnOut_SA_Widget_Inventory_ShowItemToolTip(true, " .. whereType .. ", " .. index .. ")")
    self._equipItemSlot[index].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SA_Widget_Inventory_ShowItemToolTip(false, " .. whereType .. ", " .. index .. ")")
  end
end
function PaGlobal_SA_Widget_Inventory:createInvenFrame()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local inventory = selfPlayer:get():getInventory(self._whereType)
  if nil == inventory then
    return
  end
  self._maxItemSlotCnt = inventory:sizeXXX()
  self._maxCol = math.floor(self._maxItemSlotCnt / self._maxRow)
  for index = 0, self._maxItemSlotCnt - 1 do
    local slotBG = UI.cloneControl(self._ui.stc_iconBG, self._ui.frame_Content, "Static_IconSlotBG_" .. index)
    slotBG:SetShow(true)
    self._ui.stc_invenItem[index] = UI.getChildControl(slotBG, "Static_IconSlot")
    local invenItemSlot = {}
    SlotItem.new(invenItemSlot, "invenSlot", nil, self._ui.stc_invenItem[index], self.slotConfig_Inven)
    invenItemSlot:createChild()
    invenItemSlot:clearItem()
    self._inventoryItemSlot[index] = invenItemSlot
    local posX = slotBG:GetPosX() + (slotBG:GetSizeX() + self._padding) * math.floor(index % self._maxRow)
    local posY = slotBG:GetPosY() + (slotBG:GetSizeY() + self._padding) * math.floor(index / self._maxRow)
    slotBG:SetPosXY(posX, posY)
    self._ui.stc_invenItem[index]:ComputePos()
    self._inventoryItemSlot[index].icon:ComputePos()
    self._inventoryItemSlot[index].icon:SetHorizonCenter()
    self._inventoryItemSlot[index].icon:SetVerticalMiddle()
    local whereType = CppEnums.ItemWhereType.eInstanceInventory
    self._inventoryItemSlot[index].icon:addInputEvent("Mouse_On", "HandleEventOnOut_SA_Widget_Inventory_ShowItemToolTip(true," .. whereType .. ", " .. index .. ")")
    self._inventoryItemSlot[index].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SA_Widget_Inventory_ShowItemToolTip(false," .. whereType .. ", " .. index .. ")")
    self._inventoryItemSlot[index].icon:addInputEvent("Mouse_RUp", "HandleEventRUp_SA_Widget_Inventory_RCllick(" .. index .. ")")
    self._inventoryItemSlot[index].icon:addInputEvent("Mouse_LDown", "HandleEventLDown_SA_Widget_Inventory_SlotLClick(" .. index .. ")")
    self._inventoryItemSlot[index].icon:addInputEvent("Mouse_LUp", "HandleEvent_SA_Widget_Inventory_DropHandler(" .. index .. ")")
    self._inventoryItemSlot[index].icon:addInputEvent("Mouse_PressMove", "HandleEvent_SA_Widget_Inventory_SlotDrag(" .. index .. ")")
    UIScroll.InputEventByControl(self._inventoryItemSlot[index].icon, "HandleEvent_SA_Widget_Inventory_Scroll")
    self._inventoryItemSlot[index].icon:SetAutoDisableTime(0.5)
    self._inventoryItemSlot[index].icon:SetEnableDragAndDrop(true)
  end
end
function PaGlobal_SA_Widget_Inventory:validate()
  if nil == Panel_SA_Widget_Inventory then
    return
  end
  self._ui.btn_close:isValidate()
  self._ui.txt_attValue:isValidate()
  self._ui.txt_dpValue:isValidate()
  self._ui.stc_equipBG:isValidate()
  self._ui.stc_characterIcon:isValidate()
  for index = 0, self._maxEquipItem - 1 do
    self._ui.stc_equip[index]:isValidate()
  end
  self._ui.stc_radioGroup:isValidate()
  self._ui.btn_all:isValidate()
  self._ui.btn_equip:isValidate()
  self._ui.btn_posion:isValidate()
  self._ui.frame_1:isValidate()
  self._ui.frame_Content:isValidate()
  self._ui.stc_iconBG:isValidate()
  self._ui.stc_iconSlot:isValidate()
  self._ui.frame_vScroll:isValidate()
end
function PaGlobal_SA_Widget_Inventory:controlTopGroup_Init()
  if nil == Panel_SA_Widget_Inventory then
    return
  end
  local topGroup = UI.getChildControl(Panel_SA_Widget_Inventory, "Static_TopGroup")
  self._ui.btn_close = UI.getChildControl(topGroup, "Button_CloseButton")
  local attBG = UI.getChildControl(topGroup, "StaticText_StatusAtt")
  self._ui.txt_attValue = UI.getChildControl(attBG, "StaticText_AttValue")
  local dpBG = UI.getChildControl(topGroup, "StaticText_StatusDp")
  self._ui.txt_dpValue = UI.getChildControl(dpBG, "StaticText_DPValue")
end
function PaGlobal_SA_Widget_Inventory:controlEquipGroup_Init()
  if nil == Panel_SA_Widget_Inventory then
    return
  end
  local equipGroup = UI.getChildControl(Panel_SA_Widget_Inventory, "Static_EquipGroup")
  self._ui.stc_equipBG = UI.getChildControl(equipGroup, "Static_EquipBG")
  self._ui.stc_characterIcon = UI.getChildControl(self._ui.stc_equipBG, "Static_Cha_Icon")
  for index = 0, self._maxEquipItem - 1 do
    local blackBG = UI.getChildControl(self._ui.stc_equipBG, "Static_PartsBG_" .. index)
    self._ui.stc_equip[index] = UI.getChildControl(blackBG, "Static_Parts_" .. index)
  end
end
function PaGlobal_SA_Widget_Inventory:controlInvenGroup_Init()
  if nil == Panel_SA_Widget_Inventory then
    return
  end
  local invenGroup = UI.getChildControl(Panel_SA_Widget_Inventory, "Static_InventoryGroup")
  self._ui.stc_radioGroup = UI.getChildControl(invenGroup, "Static_Inven_RadioBTNGroup")
  self._ui.btn_all = UI.getChildControl(self._ui.stc_radioGroup, "RadioButton_ALL")
  self._ui.btn_equip = UI.getChildControl(self._ui.stc_radioGroup, "RadioButton_Equip")
  self._ui.btn_posion = UI.getChildControl(self._ui.stc_radioGroup, "RadioButton_Posion")
  self._ui.buttons[0] = self._ui.btn_all
  self._ui.buttons[1] = self._ui.btn_equip
  self._ui.buttons[2] = self._ui.btn_posion
  self._ui.frame_1 = UI.getChildControl(invenGroup, "Frame_1")
  self._ui.frame_Content = UI.getChildControl(self._ui.frame_1, "Frame_1_Content")
  self._ui.stc_iconBG = UI.getChildControl(self._ui.frame_Content, "Static_IconSlotBG")
  self._ui.stc_iconBG:SetShow(false)
  self._ui.stc_iconSlot = UI.getChildControl(self._ui.stc_iconBG, "Static_IconSlot")
  self._ui.frame_vScroll = UI.getChildControl(self._ui.frame_1, "Frame_1_VerticalScroll")
end
