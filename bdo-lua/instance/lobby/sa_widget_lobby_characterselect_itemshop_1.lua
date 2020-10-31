function PaGlobal_Lobby_CharacterSelect_ItemShop:initialize()
  if true == self._initialize then
    return
  end
  if nil == SA_Widget_Lobby_CharacterSelect_ItemShop then
    return
  end
  self._ui._static_MainBG = UI.getChildControl(SA_Widget_Lobby_CharacterSelect_ItemShop, "Static_MainBG")
  self._ui._closeButton = UI.getChildControl(self._ui._static_MainBG, "Button_CloseButton")
  self._ui._frm_frame = UI.getChildControl(self._ui._static_MainBG, "Frame_1")
  self._ui._frm_frameContent = self._ui._frm_frame:GetFrameContent()
  self._ui._frm_vScroll = self._ui._frm_frame:GetVScroll()
  for index = 1, self._maxItemTypeCount do
    self._ui._stc_Titlebars[index] = UI.getChildControl(self._ui._frm_frameContent, "Static_TitleBar_" .. index)
    self._ui._itemBG[index] = UI.getChildControl(self._ui._frm_frameContent, "Static_ItemSlotBG" .. index)
    self._ui._itemBG[index]:SetShow(false)
  end
  self._ui._static_BottomBG = UI.getChildControl(SA_Widget_Lobby_CharacterSelect_ItemShop, "Static_BottomBG")
  self._ui._static_ItemSlotGroup = UI.getChildControl(self._ui._static_BottomBG, "Static_ItemSlotGroup")
  self._ui._static_PointGroup = UI.getChildControl(self._ui._static_BottomBG, "Static_PointGroup")
  self._ui._staticText_PointValue = UI.getChildControl(self._ui._static_PointGroup, "StaticText_PointValue")
  for index = 1, __eeBattleRoyaleItemSlotCount do
    self._ui._button_ItemSlotsBG[index] = UI.getChildControl(self._ui._static_ItemSlotGroup, "Static_ItemSlotBG" .. index)
    self._ui._button_ItemSlots[index] = UI.getChildControl(self._ui._button_ItemSlotsBG[index], "Static_ItemSlot" .. index)
    self._ui._button_ItemButtons[index] = UI.getChildControl(self._ui._static_ItemSlotGroup, "Button_ItemSlot" .. index .. "_Empty")
    local slot = {}
    SlotItem.new(slot, "slotItem_" .. index, index, self._ui._button_ItemSlots[index], self._slotConfig)
    slot:createChild()
    slot:clearItem()
    self._ui._itemIcons[index] = slot
    self._ui._itemIcons[index].icon:addInputEvent("Mouse_RUp", "HandleEvnetRUp_Lobby_CharacterSelect_ItemShop_ReMoveItem(" .. index .. ")")
    self._ui._itemIcons[index].icon:addInputEvent("Mouse_PressMove", "HandleEventPressMove_Lobby_CharacterSelect_ItemShop_SlotDrag(" .. index .. ")")
    self._ui._itemIcons[index].icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Lobby_CharacterSelect_ItemShop_DropItem(" .. index .. ")")
    self._ui._itemIcons[index].icon:SetEnableDragAndDrop(true)
    self._ui._itemIcons[index].itemKey = nil
  end
  self._ui._static_filterBG = UI.getChildControl(SA_Widget_Lobby_CharacterSelect_ItemShop, "Static_TitleBG")
  for index = 1, self._maxItemTypeCount + 1 do
    self._ui._button_FilterButtons[index] = UI.getChildControl(self._ui._static_filterBG, "RadioButton_Tap_" .. index)
    self._ui._button_FilterButtons[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_Lobby_CharacterSelect_ItemShop_SelectFilter(" .. index .. ")")
    self._ui._button_FilterButtons[index]:addInputEvent("Mouse_On", "HandleEventOnOut_Lobby_CharacterSelect_ItemShop_ShowMenuTooltip(" .. index .. ", true)")
    self._ui._button_FilterButtons[index]:addInputEvent("Mouse_Out", "HandleEventOnOut_Lobby_CharacterSelect_ItemShop_ShowMenuTooltip(" .. index .. ", false)")
  end
  self._ui._stc_blackBG = UI.getChildControl(SA_Widget_Lobby_CharacterSelect_ItemShop, "Static_Black_BG")
  self._ui._stc_nakMsg = UI.getChildControl(SA_Widget_Lobby_CharacterSelect_ItemShop, "Static_NakMsg")
  self:registEventHandler()
  self:validate()
  self:createControl()
  FromClient_Lobby_CharacterSelect_ItemShop_ReSizePanel()
  self._initialize = true
end
function PaGlobal_Lobby_CharacterSelect_ItemShop:registEventHandler()
  if nil == SA_Widget_Lobby_CharacterSelect_ItemShop then
    return
  end
  registerEvent("onScreenResize", "FromClient_Lobby_CharacterSelect_ItemShop_ReSizePanel")
  self._ui._closeButton:addInputEvent("Mouse_LUp", "PaGlobal_Lobby_CharacterSelect_ItemShop_Close()")
  for index = 1, __eeBattleRoyaleItemSlotCount do
    self._ui._button_ItemSlotsBG[index]:addInputEvent("Mouse_LUp", "PaGlobal_Lobby_CharacterSelect_ItemShop_SelectSlot(" .. index .. ")")
    self._ui._button_ItemSlots[index]:addInputEvent("Mouse_LUp", "PaGlobal_Lobby_CharacterSelect_ItemShop_SelectSlot(" .. index .. ")")
    self._ui._button_ItemButtons[index]:addInputEvent("Mouse_LUp", "PaGlobal_Lobby_CharacterSelect_ItemShop_SelectSlot(" .. index .. ")")
  end
  self._ui._static_MainBG:addInputEvent("Mouse_LUp", "PaGlobal_Lobby_CharacterSelect_ItemShop_GroundClick()")
  self._ui._static_MainBG:addInputEvent("Mouse_RUp", "PaGlobal_Lobby_CharacterSelect_ItemShop_GroundClick()")
end
function PaGlobal_Lobby_CharacterSelect_ItemShop:prepareOpen()
  if nil == SA_Widget_Lobby_CharacterSelect_ItemShop then
    return
  end
  for index = 1, __eeBattleRoyaleItemSlotCount do
    local itemCount = Int64toInt32(PaGlobal_Lobby_CharacterSelect_ItemSlot._itemData:GetItemCount(index - 1))
    if 0 == itemCount then
      PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemIcons[index]:clearItem()
      PaGlobal_Lobby_CharacterSelect_ItemShop._ui._button_ItemButtons[index]:SetShow(true)
      PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemIcons[index].icon:removeInputEvent("Mouse_On")
      PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemIcons[index].icon:removeInputEvent("Mouse_Out")
      PaGlobal_Lobby_CharacterSelect_ItemShop._ui._itemIcons[index].itemKey = nil
    end
  end
  for emptySlotIndex = 1, __eeBattleRoyaleItemSlotCount do
    if true == self._ui._button_ItemButtons[emptySlotIndex]:GetShow() then
      self._curAddItemCnt = emptySlotIndex - 1
      break
    end
  end
  PaGlobal_Lobby_CharacterSelect_ItemShop:update()
  PaGlobal_Lobby_CharacterSelect_ItemShop:open()
end
function PaGlobal_Lobby_CharacterSelect_ItemShop:open()
  if nil == SA_Widget_Lobby_CharacterSelect_ItemShop then
    return
  end
  SA_Widget_Lobby_CharacterSelect_ItemShop:SetShow(true)
end
function PaGlobal_Lobby_CharacterSelect_ItemShop:prepareClose()
  if nil == SA_Widget_Lobby_CharacterSelect_ItemShop then
    return
  end
  SA_Widget_Lobby_CharacterSelect_ItemShop:ClearUpdateLuaFunc()
  PaGlobal_Lobby_CharacterSelect_ItemShop:close()
end
function PaGlobal_Lobby_CharacterSelect_ItemShop:close()
  if nil == SA_Widget_Lobby_CharacterSelect_ItemShop then
    return
  end
  SA_Widget_Lobby_CharacterSelect_ItemShop:SetShow(false)
end
function PaGlobal_Lobby_CharacterSelect_ItemShop:createControl()
  if nil == SA_Widget_Lobby_CharacterSelect_ItemShop then
    return
  end
  local itemCount = ToClient_ShadowArenaItemCount()
  for index = 1, itemCount do
    local xPos = (index - 1) % self._maxItemTypeCount + 1
    local yPos = math.floor((index - 1) / self._maxItemTypeCount)
    local slot = {}
    self._ui._itemList[index] = slot
    self._ui._itemList[index].slotBG = UI.cloneControl(self._ui._itemBG[xPos], self._ui._frm_frameContent, "Static_ItemSlotBG_" .. index)
    self._ui._itemList[index].icon = UI.getChildControl(self._ui._itemList[index].slotBG, "Static_ItemIconSlotBG")
    self._ui._itemList[index].name = UI.getChildControl(self._ui._itemList[index].slotBG, "StaticText_ItemNameText")
    self._ui._itemList[index].price = UI.getChildControl(self._ui._itemList[index].slotBG, "StaticText_ItemPriceValue")
    self._ui._itemList[index].slotBG:SetPosY(self._ui._itemBG[xPos]:GetPosY() + yPos * (self._ui._itemBG[xPos]:GetSizeY() + 5))
    self._ui._itemList[index].slotBG:SetShow(false)
    local brss = Toclient_getShadowArenaItem(index - 1)
    local typeNo = ToClient_GetBattleRoyaleItemTypeByKey(brss.itemKey)
    if nil == self._slotTotalCount[typeNo] then
      self._slotTotalCount[typeNo] = 1
      self._slotCurrentCount[typeNo] = 0
    else
      self._slotTotalCount[typeNo] = self._slotTotalCount[typeNo] + 1
    end
  end
end
function PaGlobal_Lobby_CharacterSelect_ItemShop:update()
  if nil == SA_Widget_Lobby_CharacterSelect_ItemShop then
    return
  end
  PaGlobal_Lobby_CharacterSelect_ItemShop:shopItemUpdate()
  PaGlobal_Lobby_CharacterSelect_ItemShop:titleBarUpdate()
  PaGlobal_Lobby_CharacterSelect_ItemShop:remainPointUpdate()
end
function PaGlobal_Lobby_CharacterSelect_ItemShop:shopItemUpdate()
  local itemCount = ToClient_ShadowArenaItemCount()
  for index = 1, itemCount do
    self._ui._itemList[index].slotBG:SetShow(false)
  end
  for typeNo = 0, self._maxItemTypeCount - 1 do
    if nil ~= self._slotTotalCount[typeNo] then
      self._slotAreaSizeY[typeNo] = math.ceil(self._slotTotalCount[typeNo] / self._maxItemTypeCount) * (self._ui._itemBG[1]:GetSizeY() + 5)
      self._slotCurrentCount[typeNo] = 0
    end
  end
  local filteredItemCount = 0
  for index = 1, itemCount do
    local brss = Toclient_getShadowArenaItem(index - 1)
    local itemWrapper
    if nil ~= brss then
      itemWrapper = getItemEnchantStaticStatus(brss.itemKey)
    end
    if true == PaGlobal_Lobby_CharacterSelect_ItemShop:filterShopItem(brss.itemKey, self._selectedFilter) then
      filteredItemCount = filteredItemCount + 1
      local typeNo = ToClient_GetBattleRoyaleItemTypeByKey(brss.itemKey)
      self._slotCurrentCount[typeNo] = self._slotCurrentCount[typeNo] + 1
      local usedIndex = filteredItemCount
      if PaGlobal_Lobby_CharacterSelect_ItemShop._filterType.ALL == self._selectedFilter then
        local startIndex = 0
        for index = 1, typeNo do
          startIndex = startIndex + self._slotTotalCount[index - 1]
        end
        usedIndex = startIndex + self._slotCurrentCount[typeNo]
      end
      self._ui._itemList[usedIndex].icon:ChangeTextureInfoNameAsync("Icon/" .. itemWrapper:getIconPath())
      self._ui._itemList[usedIndex].icon:getBaseTexture():setUV(0, 0, 1, 1)
      self._ui._itemList[usedIndex].icon:setRenderTexture(self._ui._itemList[usedIndex].icon:getBaseTexture())
      self._ui._itemList[usedIndex].name:SetText(itemWrapper:getName())
      self._ui._itemList[usedIndex].price:SetText(brss.needPoint)
      self._ui._itemList[usedIndex].slotBG:addInputEvent("Mouse_PressMove", "HandleEventPressMove_Lobby_CharacterSelect_ItemShop_ShopDrag(" .. brss.itemKey:getItemKey() .. ")")
      self._ui._itemList[usedIndex].slotBG:addInputEvent("Mouse_LUp", "PaGlobal_Lobby_CharacterSelect_ItemShop_SelectItem(" .. brss.itemKey:getItemKey() .. ")")
      self._ui._itemList[usedIndex].slotBG:addInputEvent("Mouse_On", "HandleEventOnOut_Lobby_CharacterSelect_ItemShop_ShowItemTooltip(" .. usedIndex .. "," .. brss.itemKey:getItemKey() .. ",true)")
      self._ui._itemList[usedIndex].slotBG:addInputEvent("Mouse_Out", "HandleEventOnOut_Lobby_CharacterSelect_ItemShop_ShowItemTooltip(" .. usedIndex .. "," .. brss.itemKey:getItemKey() .. ",false)")
      self._ui._itemList[usedIndex].slotBG:SetEnableDragAndDrop(true)
      PaGlobal_Lobby_CharacterSelect_ItemShop:setSlotPosition(usedIndex, typeNo)
      self._ui._itemList[usedIndex].slotBG:SetShow(true)
    end
  end
end
function PaGlobal_Lobby_CharacterSelect_ItemShop:setSlotPosition(slotIndex, typeNo)
  local xPos = (self._slotCurrentCount[typeNo] - 1) % self._maxItemTypeCount + 1
  local yPos = math.floor((self._slotCurrentCount[typeNo] - 1) / self._maxItemTypeCount)
  local addPosY = 0
  if PaGlobal_Lobby_CharacterSelect_ItemShop._filterType.ALL == self._selectedFilter then
    for index = 1, typeNo do
      addPosY = addPosY + PaGlobal_Lobby_CharacterSelect_ItemShop._slotAreaSizeY[index - 1] + self._ui._stc_Titlebars[1]:GetSizeY() + 20
    end
  end
  self._ui._itemList[slotIndex].slotBG:SetPosX(self._ui._itemBG[xPos]:GetPosX())
  self._ui._itemList[slotIndex].slotBG:SetPosY(self._ui._itemBG[xPos]:GetPosY() + yPos * (self._ui._itemBG[xPos]:GetSizeY() + 5) + addPosY)
end
function PaGlobal_Lobby_CharacterSelect_ItemShop:remainPointUpdate()
  local maxPoint = ToClient_getShadowArenaItemMaxPoint()
  local itemSlot = PaGlobal_Lobby_CharacterSelect_ItemSlot
  local usedPoint = 0
  if nil ~= PaGlobal_Lobby_CharacterSelect_ItemSlot then
    usedPoint = itemSlot:usedPoint()
  end
  self._ui._staticText_PointValue:SetText(tostring(maxPoint - usedPoint))
end
function PaGlobal_Lobby_CharacterSelect_ItemShop:titleBarUpdate()
  local titleBarSpanY = 0
  for index = 1, self._maxItemTypeCount do
    if PaGlobal_Lobby_CharacterSelect_ItemShop._filterType.ALL == self._selectedFilter then
      PaGlobal_Lobby_CharacterSelect_ItemShop._ui._stc_Titlebars[index]:SetShow(true)
      if 1 ~= index then
        titleBarSpanY = titleBarSpanY + PaGlobal_Lobby_CharacterSelect_ItemShop._slotAreaSizeY[index - 2] + PaGlobal_Lobby_CharacterSelect_ItemShop._ui._stc_Titlebars[1]:GetSizeY() + 20
      end
      PaGlobal_Lobby_CharacterSelect_ItemShop._ui._stc_Titlebars[index]:SetSpanSize(0, titleBarSpanY)
    elseif index == self._selectedFilter - 1 then
      PaGlobal_Lobby_CharacterSelect_ItemShop._ui._stc_Titlebars[index]:SetShow(true)
      PaGlobal_Lobby_CharacterSelect_ItemShop._ui._stc_Titlebars[index]:SetSpanSize(0, 0)
    else
      PaGlobal_Lobby_CharacterSelect_ItemShop._ui._stc_Titlebars[index]:SetShow(false)
    end
  end
end
function PaGlobal_Lobby_CharacterSelect_ItemShop:filterShopItem(itemKey, filter)
  local itemWrapper = getItemEnchantStaticStatus(itemKey)
  if nil == itemWrapper then
    return false
  end
  if PaGlobal_Lobby_CharacterSelect_ItemShop._filterType.ALL == filter then
    return true
  elseif PaGlobal_Lobby_CharacterSelect_ItemShop._filterType.SUBSKILL == filter then
    if PaGlobal_Lobby_CharacterSelect_ItemShop._itemType.SUBSKILL == ToClient_GetBattleRoyaleItemTypeByKey(itemKey) then
      return true
    else
      return false
    end
  elseif PaGlobal_Lobby_CharacterSelect_ItemShop._filterType.ITEM == filter then
    if PaGlobal_Lobby_CharacterSelect_ItemShop._itemType.ITEM == ToClient_GetBattleRoyaleItemTypeByKey(itemKey) then
      return true
    else
      return false
    end
  elseif PaGlobal_Lobby_CharacterSelect_ItemShop._filterType.MAGICSCROLL == filter then
    if PaGlobal_Lobby_CharacterSelect_ItemShop._itemType.MAGICSCROLL == ToClient_GetBattleRoyaleItemTypeByKey(itemKey) then
      return true
    else
      return false
    end
  end
  return false
end
function PaGlobal_Lobby_CharacterSelect_ItemShop:validate()
  if nil == SA_Widget_Lobby_CharacterSelect_ItemShop then
    return
  end
  self._ui._closeButton:isValidate()
end
function PaGlobal_Lobby_CharacterSelect_ItemShop:hideOtherSlot(selectedIndex)
  local itemSlots = PaGlobal_Lobby_CharacterSelect_ItemSlot
  if nil == itemSlots then
    return
  end
end
function PaGlobal_Lobby_CharacterSelect_ItemShop:SelectItem(selectedItemKey, index)
  local itemSlots = PaGlobal_Lobby_CharacterSelect_ItemSlot
  if nil == itemSlots then
    return
  end
  self._ui._button_ItemButtons[index]:SetShow(false)
  local staticStatus = getItemEnchantStaticStatus(ItemEnchantKey(selectedItemKey))
  if nil == staticStatus then
    return
  end
  self._ui._itemIcons[index]:clearItem()
  self._ui._itemIcons[index].itemKey = selectedItemKey
  self._ui._itemIcons[index]:setItemByStaticStatus(staticStatus, Defines.s64_const.s64_1)
  self._ui._itemIcons[index].count:SetShow(true)
  self._ui._itemIcons[index].count:SetText(tostring(Defines.s64_const.s64_1))
  self._ui._itemIcons[index].icon:addInputEvent("Mouse_On", "HandleEventOnOut_Lobby_CharacterSelect_ItemShop_ShowItemTooltip(" .. index .. "," .. selectedItemKey .. ",true)")
  self._ui._itemIcons[index].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Lobby_CharacterSelect_ItemShop_ShowItemTooltip(" .. index .. "," .. selectedItemKey .. ",false)")
  self:update()
end
function PaGlobal_Lobby_CharacterSelect_ItemShop:isAbleAddSlotItem(selectedItemKey)
  if __eeBattleRoyaleItemSlotCount <= self._curAddItemCnt then
    local maxItemtMsg = PAGetString(Defines.StringSheet_GAME, "LUA_SHADOWARENA_ITEMSHOP_MAXITEM")
    Proc_ShowMessage_Ack(maxItemtMsg, nil, self._ui._stc_nakMsg:GetPosX(), self._ui._stc_nakMsg:GetPosY(), nil, true)
    return false
  end
  return self:hasPoint(selectedItemKey)
end
function PaGlobal_Lobby_CharacterSelect_ItemShop:hasPoint(selectedItemKey, exceptIndex)
  local maxPoint = ToClient_getShadowArenaItemMaxPoint()
  local usedPoint = PaGlobal_Lobby_CharacterSelect_ItemSlot:usedPoint(exceptIndex)
  local remainPoint = maxPoint - usedPoint
  if remainPoint < ToClient_getShadowArenaItemPrice(ItemEnchantKey(selectedItemKey)) then
    local noPointMsg = PAGetString(Defines.StringSheet_GAME, "LUA_SHADOWARENA_ITEMSHOP_NOPOINT")
    Proc_ShowMessage_Ack(noPointMsg, nil, self._ui._stc_nakMsg:GetPosX(), self._ui._stc_nakMsg:GetPosY(), nil, true)
    return false
  end
  return true
end
function PaGlobal_Lobby_CharacterSelect_ItemShop:hasSameItem(selectedItemKey)
  for index = 1, __eeBattleRoyaleItemSlotCount do
    if selectedItemKey == PaGlobal_Lobby_CharacterSelect_ItemSlot._itemData:GetItemKey(index - 1) then
      return true, index
    end
  end
end
function PaGlobal_Lobby_CharacterSelect_ItemShop:isFull()
  for index = 1, __eeBattleRoyaleItemSlotCount do
    if 0 == PaGlobal_Lobby_CharacterSelect_ItemSlot._itemData:GetItemKey(index - 1) then
      return false
    end
  end
  return true
end
