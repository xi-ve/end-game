function PaGlobal_Lobby_CharacterSelect_ItemSlot:initialize()
  if true == self._initialize then
    return
  end
  if nil == SA_Widget_Lobby_CharacterSelect_ItemSlot then
    return
  end
  self._itemData = BattleRoyaleLobbySelectedData()
  self._ui._Static_ItemSlotBG = UI.getChildControl(SA_Widget_Lobby_CharacterSelect_ItemSlot, "Static_ItemSlotBG")
  self._ui._Static_AvatarSlotBG = UI.getChildControl(SA_Widget_Lobby_CharacterSelect_ItemSlot, "Static_AvatarSlotBG")
  self._ui._Static_AvatarIcon = UI.getChildControl(self._ui._Static_AvatarSlotBG, "Static_ItemIcon")
  self._ui._btn_itemShop = UI.getChildControl(SA_Widget_Lobby_CharacterSelect_ItemSlot, "Button_ItemShop")
  local pointBG = UI.getChildControl(SA_Widget_Lobby_CharacterSelect_ItemSlot, "Static_Point")
  self._ui._txt_point = UI.getChildControl(pointBG, "StaticText_Number")
  for index = 1, __eeBattleRoyaleItemSlotCount do
    self._ui._Static_ItemSlot[index] = UI.getChildControl(self._ui._Static_ItemSlotBG, "Static_ItemSlot" .. tostring(index))
    self._ui._Radio_AvatarSlot[index] = UI.getChildControl(self._ui._Static_AvatarSlotBG, "RadioButton_AvatarSlot" .. tostring(index))
    local slot = {}
    SlotItem.new(slot, "slotItem_" .. index, index, self._ui._Static_ItemSlot[index], self._slotConfig)
    slot:createChild()
    slot:clearItem()
    self._ui._itemIcons[index] = slot
    self._ui._itemIcons[index].icon:SetHorizonCenter()
    self._ui._itemIcons[index].icon:SetVerticalMiddle()
  end
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Lobby_CharacterSelect_ItemSlot:registEventHandler()
  if nil == SA_Widget_Lobby_CharacterSelect_ItemSlot then
    return
  end
  self._ui._btn_itemShop:addInputEvent("Mouse_LUp", "HandleEventLup_Button_CharacterItemShop()")
end
function PaGlobal_Lobby_CharacterSelect_ItemSlot:prepareOpen()
  if nil == SA_Widget_Lobby_CharacterSelect_ItemSlot then
    return
  end
  ToClient_SetCharacterSelect_ItemSlot()
  PaGlobal_Lobby_CharacterSelect_ItemSlot:open()
end
function PaGlobal_Lobby_CharacterSelect_ItemSlot:open()
  if nil == SA_Widget_Lobby_CharacterSelect_ItemSlot then
    return
  end
  SA_Widget_Lobby_CharacterSelect_ItemSlot:SetShow(true)
end
function PaGlobal_Lobby_CharacterSelect_ItemSlot:prepareClose()
  if nil == SA_Widget_Lobby_CharacterSelect_ItemSlot then
    return
  end
  SA_Widget_Lobby_CharacterSelect_ItemSlot:ClearUpdateLuaFunc()
  PaGlobal_Lobby_CharacterSelect_ItemSlot:close()
end
function PaGlobal_Lobby_CharacterSelect_ItemSlot:close()
  if nil == SA_Widget_Lobby_CharacterSelect_ItemSlot then
    return
  end
  SA_Widget_Lobby_CharacterSelect_ItemSlot:SetShow(false)
end
function PaGlobal_Lobby_CharacterSelect_ItemSlot:update()
  if nil == SA_Widget_Lobby_CharacterSelect_ItemSlot then
    return
  end
  for ii = 1, __eeBattleRoyaleItemSlotCount do
    local itemKey = self._itemData:GetItemKey(ii - 1)
    local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
    if nil ~= itemWrapper then
      local itemCount = self._itemData:GetItemCount(ii - 1)
      self._ui._itemIcons[ii]:setItemByStaticStatus(itemWrapper, itemCount)
      self._ui._itemIcons[ii].count:SetShow(true)
      local itemCount = Int64toInt32(self._itemData:GetItemCount(ii - 1))
      self._ui._itemIcons[ii].count:SetText(itemCount)
      self._ui._itemIcons[ii].icon:addInputEvent("Mouse_On", "HandleEventOnOut_Lobby_CharacterSelect_ItemShop_ShowItemTooltip(" .. ii .. "," .. itemKey .. ",true)")
      self._ui._itemIcons[ii].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Lobby_CharacterSelect_ItemShop_ShowItemTooltip(" .. ii .. "," .. itemKey .. ",false)")
    else
      self._ui._itemIcons[ii].icon:removeInputEvent("Mouse_On")
      self._ui._itemIcons[ii].icon:removeInputEvent("Mouse_Out")
      self._ui._itemIcons[ii]:clearItem()
    end
  end
  self:setPointValue()
end
function PaGlobal_Lobby_CharacterSelect_ItemSlot:setPointValue()
  local maxPoint = ToClient_getShadowArenaItemMaxPoint()
  if nil == maxPoint then
    self._ui._txt_point:SetText("0")
    return
  end
  local usedPoint = self:usedPoint()
  self._ui._txt_point:SetText(tostring(maxPoint - usedPoint))
end
function PaGlobal_Lobby_CharacterSelect_ItemSlot:setItem(index, itemKey, count)
  self._itemData:SetItem(index, itemKey, count)
end
function PaGlobal_Lobby_CharacterSelect_ItemSlot:getItem(index)
  return self._itemData:GetItemKey(index)
end
function PaGlobal_Lobby_CharacterSelect_ItemSlot:isSetItem(index)
  return 0 ~= self._itemData:GetItemKey(index)
end
function PaGlobal_Lobby_CharacterSelect_ItemSlot:usedPoint(exceptIndex)
  local point = 0
  for ii = 1, __eeBattleRoyaleItemSlotCount do
    if ii ~= exceptIndex then
      point = point + ToClient_getShadowArenaItemPrice(ItemEnchantKey(self._itemData:GetItemKey(ii - 1))) * Int64toInt32(self._itemData:GetItemCount(ii - 1))
    end
  end
  return point
end
function PaGlobal_Lobby_CharacterSelect_ItemSlot:validate()
  if nil == SA_Widget_Lobby_CharacterSelect_ItemSlot then
    return
  end
  self._ui._Static_ItemSlotBG:isValidate()
  self._ui._Static_AvatarSlotBG:isValidate()
  self._ui._Static_AvatarIcon:isValidate()
  self._ui._btn_itemShop:isValidate()
  for index = 1, __eeBattleRoyaleItemSlotCount do
    self._ui._Static_ItemSlot[index]:isValidate()
    self._ui._Radio_AvatarSlot[index]:isValidate()
  end
end
