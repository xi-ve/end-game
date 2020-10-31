function PaGlobal_ShipEquipManagement:initialize()
  if true == PaGlobal_ShipEquipManagement._initialize then
    return
  end
  local stc_titleBarBG = UI.getChildControl(Panel_Window_ShipEquipManagement_ALL, "Static_TitleBarBG")
  self._ui._btn_close = UI.getChildControl(stc_titleBarBG, "Button_Close")
  local stc_equipBG = UI.getChildControl(Panel_Window_ShipEquipManagement_ALL, "Static_EuipBG")
  local stc_equipSlotGroup = UI.getChildControl(stc_equipBG, "Static_EquipSlotGroup")
  self._ui._stc_equipSlotGroup = stc_equipSlotGroup
  self._ui._stc_equipSlots = {}
  for k, v in pairs(self._equipSlotNo) do
    self._ui._stc_equipSlots[v] = UI.getChildControl(stc_equipSlotGroup, self._equipSlotID[v])
  end
  self._ui._txt_equipEffectDesc = UI.getChildControl(stc_equipBG, "StaticText_EquipEffectDesc")
  local stc_avatarBG = UI.getChildControl(Panel_Window_ShipEquipManagement_ALL, "Static_AvatarBG")
  local stc_avatarSlotGroup = UI.getChildControl(stc_avatarBG, "Static_AvatarSlotGroup")
  self._ui._stc_avatarSlotGroup = stc_avatarSlotGroup
  self._ui._stc_avatarSlots = {}
  for k, v in pairs(self._avatarSlotNo) do
    self._ui._stc_avatarSlots[v] = UI.getChildControl(stc_avatarSlotGroup, self._avatarSlotID[v])
  end
  self._ui._txt_avatarEffectDesc = UI.getChildControl(stc_avatarBG, "StaticText_AvatarEffectDesc")
  local stc_myInventory = UI.getChildControl(Panel_Window_ShipEquipManagement_ALL, "Static_MyInventory")
  local stc_radioBtn = UI.getChildControl(stc_myInventory, "Static_RadioButtons")
  self._ui._radio_myBag = UI.getChildControl(stc_radioBtn, "RadioButton_MyBag")
  self._ui._radio_pearlBag = UI.getChildControl(stc_radioBtn, "RadioButton_MyPearlBag")
  self._ui._stc_selectLine = UI.getChildControl(stc_radioBtn, "Static_SelctLine")
  local stc_inventoryBG = UI.getChildControl(stc_myInventory, "Static_Inventory_BG")
  self._ui._stc_inventoryBG = stc_inventoryBG
  self._ui._stc_inventorySlot = UI.getChildControl(stc_inventoryBG, "Static_ShipInventorySlot")
  self._ui._scroll_inventory = UI.getChildControl(stc_inventoryBG, "Scroll_1_VerticalScroll")
  local stc_weight = UI.getChildControl(stc_myInventory, "Static_Weight")
  self._ui._progress_weightBar = UI.getChildControl(stc_weight, "Progress2_WeightBar")
  self._ui._txt_weightValue = UI.getChildControl(stc_weight, "StaticText_WeightValue")
  self._ui._btn_confirm = UI.getChildControl(Panel_Window_ShipEquipManagement_ALL, "Button_Confirm")
  self._ui._stc_inventorySlot:SetShow(false)
  self:initTab()
  self._useStartSlot = inventorySlotNoUserStart()
  self:createEquipSlots()
  self:createAvatarItemSlots()
  self:createIventorySlots()
  PaGlobal_ShipEquipManagement:registEventHandler()
  PaGlobal_ShipEquipManagement:validate()
  PaGlobal_ShipEquipManagement._initialize = true
end
function PaGlobal_ShipEquipManagement:registEventHandler()
  if nil == Panel_Window_ShipEquipManagement_ALL then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "HandleEventMLUp_ShipEquipManagement_Close()")
  self._ui._btn_confirm:addInputEvent("Mouse_LUp", "HandleEventMLUp_ShipEquipManagement_Close()")
  self._ui._radio_myBag:addInputEvent("Mouse_LUp", "FromClient_ShipEquipManagement_UpdateMyInventory()")
  self._ui._radio_pearlBag:addInputEvent("Mouse_LUp", "FromClient_ShipEquipManagement_UpdateMyInventory()")
  registerEvent("EventServantEquipItem", "FromClient_ShipEquipManagement_UpdateEquipSlot")
  registerEvent("EventServantEquipmentUpdate", "FromClient_ShipEquipManagement_UpdateEquipSlot")
  registerEvent("FromClient_InventoryUpdate", "FromClient_ShipEquipManagement_UpdateMyInventory")
  registerEvent("onScreenResize", "FromClient_ShipEquipManagement_Resize")
  Panel_Window_ShipEquipManagement_ALL:RegisterShowEventFunc(true, "PaGlobal_ShipEquipManagement_ShowAni()")
  Panel_Window_ShipEquipManagement_ALL:RegisterShowEventFunc(false, "PaGlobal_ShipEquipManagement_HideAni()")
end
function PaGlobal_ShipEquipManagement:prepareOpen(servantActorKey)
  if nil == Panel_Window_ShipEquipManagement_ALL then
    return
  end
  self:resize()
  self:initScrollPos()
  self:initTab()
  self._servantActorKey = servantActorKey
  if false == self:update() then
    return
  end
  self._ui._stc_equipSlots[self._contractSlotNum]:SetShow(self:isBigShip(servantActorKey))
  PaGlobal_ShipEquipManagement:open()
end
function PaGlobal_ShipEquipManagement:open()
  if nil == Panel_Window_ShipEquipManagement_ALL then
    return
  end
  Panel_Window_ShipEquipManagement_ALL:SetShow(true)
end
function PaGlobal_ShipEquipManagement:prepareClose()
  if nil == Panel_Window_ShipEquipManagement_ALL then
    return
  end
  self._servantActorKey = 0
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_ShipEquipManagement:close()
end
function PaGlobal_ShipEquipManagement:close()
  if nil == Panel_Window_ShipEquipManagement_ALL then
    return
  end
  Panel_Window_ShipEquipManagement_ALL:SetShow(false)
end
function PaGlobal_ShipEquipManagement:update()
  if nil == Panel_Window_ShipEquipManagement_ALL then
    return
  end
  if false == self:updateEquipSlots() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoWhrafIsFar"))
    return false
  end
  if false == self:updateAvatarSlots() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoWhrafIsFar"))
    return false
  end
  if false == self:updateInventorySlots() then
    return false
  end
end
function PaGlobal_ShipEquipManagement:validate()
  if nil == Panel_Window_ShipEquipManagement_ALL then
    return
  end
  self._ui._btn_close:isValidate()
  self._ui._stc_equipSlotGroup:isValidate()
  for i = 1, #self._equipSlotNo do
    self._ui._stc_equipSlots[self._equipSlotNo[i]]:isValidate()
  end
  self._ui._txt_equipEffectDesc:isValidate()
  self._ui._stc_avatarSlotGroup:isValidate()
  for i = 1, #self._avatarSlotNo do
    self._ui._stc_avatarSlots[self._avatarSlotNo[i]]:isValidate()
  end
  self._ui._txt_avatarEffectDesc:isValidate()
  self._ui._stc_inventoryBG:isValidate()
  self._ui._stc_inventorySlot:isValidate()
  self._ui._scroll_inventory:isValidate()
  self._ui._progress_weightBar:isValidate()
  self._ui._txt_weightValue:isValidate()
  self._ui._btn_confirm:isValidate()
end
function PaGlobal_ShipEquipManagement:createEquipSlots()
  if nil ~= self._equipItemSlots then
    return
  end
  local index = 0
  self._equipItemSlots = {}
  for i = 1, #self._equipSlotNo do
    index = self._equipSlotNo[i]
    local slot = {}
    SlotItem.new(slot, "Slot_ShipEquip_" .. index, index, self._ui._stc_equipSlots[index], self._slotConfig)
    slot:createChild()
    slot.icon:addInputEvent("Mouse_On", "HandleEventMOn_ShipEquipManagement_EquipSlot(" .. index .. ", true)")
    slot.icon:addInputEvent("Mouse_Out", "HandleEventMOn_ShipEquipManagement_EquipSlot(" .. index .. ", false)")
    Panel_Tooltip_Item_SetPosition(index, slot, "ServantShipEquipment")
    slot.icon:addInputEvent("Mouse_RUp", "HandleEventMRUp_ShipEquipManagement_UnEquipItem(" .. index .. ")")
    self._equipItemSlots[index] = slot
  end
end
function PaGlobal_ShipEquipManagement:createAvatarItemSlots()
  if nil ~= self._avatarItemSlots then
    return
  end
  local index = 0
  self._avatarItemSlots = {}
  for i = 1, #self._avatarSlotNo do
    index = self._avatarSlotNo[i]
    local slot = {}
    SlotItem.new(slot, "Slot_ShipAvatar_" .. index, index, self._ui._stc_avatarSlots[index], self._slotConfig)
    slot:createChild()
    slot.icon:addInputEvent("Mouse_On", "HandleEventMOn_ShipEquipManagement_EquipSlot(" .. index .. ", true)")
    slot.icon:addInputEvent("Mouse_Out", "HandleEventMOn_ShipEquipManagement_EquipSlot(" .. index .. ", false)")
    Panel_Tooltip_Item_SetPosition(index, slot, "ServantShipEquipment")
    slot.icon:addInputEvent("Mouse_RUp", "HandleEventMRUp_ShipEquipManagement_UnEquipItem(" .. index .. ")")
    self._avatarItemSlots[index] = slot
  end
end
function PaGlobal_ShipEquipManagement:createIventorySlots()
  if nil ~= self._inventoryItemSlots then
    return
  end
  self._invenSlotBG = {}
  self._inventoryItemSlots = {}
  self._config.slotRows = math.floor(self._config.slotCount / self._config.slotCols)
  UIScroll.InputEvent(self._ui._scroll_inventory, "HandleEventScroll_ShipEquipManagement_MyInventory")
  UIScroll.InputEventByControl(self._ui._stc_inventoryBG, "HandleEventScroll_ShipEquipManagement_MyInventory")
  for ii = 0, self._config.slotCount - 1 do
    self._invenSlotBG[ii] = UI.createAndCopyBasePropertyControl(self._ui._stc_inventoryBG, "Static_ShipInventorySlot", self._ui._stc_inventoryBG, "Static_ShipInvenSlot_" .. ii)
    self._invenSlotBG[ii]:SetPosX(self._config.slotStartX + self._config.slotGapX * (ii % self._config.slotCols))
    self._invenSlotBG[ii]:SetPosY(self._config.slotStartY + self._config.slotGapY * math.floor(ii / self._config.slotCols))
    self._invenSlotBG[ii]:SetIgnore(true)
    self._invenSlotBG[ii]:SetShow(true)
    local slot = {}
    SlotItem.new(slot, "Slot_ShipInven_" .. ii, ii, self._invenSlotBG[ii], self._slotConfig)
    slot:createChild()
    UIScroll.InputEventByControl(slot.icon, "HandleEventScroll_ShipEquipManagement_MyInventory")
    slot.icon:addInputEvent("Mouse_On", "HandleEventMOn_ShipEquipManagement_MyInventory(" .. ii .. ", true)")
    slot.icon:addInputEvent("Mouse_Out", "HandleEventMOn_ShipEquipManagement_MyInventory(" .. ii .. ", false)")
    Panel_Tooltip_Item_SetPosition(ii, slot, "ShipEquipManagementInventory")
    slot.icon:addInputEvent("Mouse_RUp", "HandleEventMRUp_ShipEquipManagement_EquipItem(" .. ii .. ")")
    self._inventoryItemSlots[ii] = slot
  end
end
function PaGlobal_ShipEquipManagement:updateEquipSlots()
  local servantWrapper = getServantInfoFromActorKey(self._servantActorKey)
  if nil == servantWrapper then
    return false
  end
  local index = 0
  for i = 1, #self._equipSlotNo do
    index = self._equipSlotNo[i]
    self._equipItemSlots[index]:clearItem()
    local itemWrapper = servantWrapper:getEquipItem(index)
    if nil ~= itemWrapper then
      self._equipItemSlots[index]:setItem(itemWrapper)
      self._equipItemSlots[index].icon:SetShow(true)
    else
      self._equipItemSlots[index].icon:SetShow(false)
    end
  end
  return true
end
function PaGlobal_ShipEquipManagement:updateAvatarSlots()
  local servantWrapper = getServantInfoFromActorKey(self._servantActorKey)
  if nil == servantWrapper then
    return false
  end
  local index = 0
  for i = 1, #self._avatarSlotNo do
    index = self._avatarSlotNo[i]
    self._avatarItemSlots[index]:clearItem()
    local itemWrapper = servantWrapper:getEquipItem(index)
    if nil ~= itemWrapper then
      self._avatarItemSlots[index]:setItem(itemWrapper)
      self._avatarItemSlots[index].icon:SetShow(true)
    else
      self._avatarItemSlots[index].icon:SetShow(false)
    end
  end
  return true
end
function PaGlobal_ShipEquipManagement:updateInventorySlots()
  if nil == getSelfPlayer() or nil == getSelfPlayer():get() then
    return false
  end
  local useStartSlot = inventorySlotNoUserStart()
  if self._ui._radio_myBag:IsCheck() then
    self._currentWhereType = CppEnums.ItemWhereType.eInventory
  elseif self._ui._radio_pearlBag:IsCheck() then
    self._currentWhereType = CppEnums.ItemWhereType.eCashInventory
  end
  self:repositionSelectLine()
  local selfPlayer = getSelfPlayer():get()
  local inventory = selfPlayer:getInventoryByType(self._currentWhereType)
  local s64_allWeight = selfPlayer:getCurrentWeight_s64()
  local s64_maxWeight = selfPlayer:getPossessableWeight_s64()
  local s64_allWeight_div = s64_allWeight / Defines.s64_const.s64_100
  local s64_maxWeight_div = s64_maxWeight / Defines.s64_const.s64_100
  self._ui._progress_weightBar:SetProgressRate(Int64toInt32(s64_allWeight / s64_maxWeight_div))
  self._ui._txt_weightValue:SetText(makeWeightString(s64_allWeight, 1) .. " / " .. makeWeightString(s64_maxWeight, 0) .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"))
  local invenUseSize = selfPlayer:getInventorySlotCount(true)
  self._maxCountInventory = inventory:sizeXXX()
  local slotNoList = Array.new()
  slotNoList:fill(useStartSlot, self._maxCountInventory - 1)
  UIScroll.SetButtonSize(self._ui._scroll_inventory, self._config.slotCount, self._maxCountInventory - 1)
  local slotList = self._inventoryItemSlots
  for ii = 0, self._config.slotCount - 1 do
    local slot = slotList[ii]
    slot:clearItem()
    slot.icon:SetEnable(true)
    if false == _ContentsGroup_NewDelivery then
      slot.icon:SetMonoTone(true)
    end
  end
  for ii = 0, self._config.slotCount - 1 do
    local slot = slotList[ii]
    local slotNo = slotNoList[1 + ii + self._startInvenSlotIndex]
    slot.slotNo = slotNo
    slot.icon:EraseAllEffect()
    local row = math.floor(ii / self._config.slotCols)
    local column = ii % self._config.slotCols
    slot.icon:SetMonoTone(false)
    slot.count:SetShow(false)
    if nil == slot.slotNo then
      slot:clearItem()
    else
      local itemWrapper = getInventoryItemByType(self._currentWhereType, slotNo)
      if nil ~= itemWrapper then
        slot:setItem(itemWrapper, slotNo, nil, nil)
        slot.isEmpty = false
        if false == self:isCheckEquipItem(itemWrapper:getStaticStatus()) then
          slot.icon:SetMonoTone(true)
        end
      end
    end
    slot.icon:SetEnableDragAndDrop(true)
  end
  return true
end
function PaGlobal_ShipEquipManagement:isCheckEquipItem(itemSSW)
  if nil == itemSSW then
    return false
  end
  local itemSS = itemSSW:get()
  if nil == itemSS then
    return false
  end
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_ShipEquipManagement._servantActorKey)
  if nil == servantWrapper then
    return false
  end
  local servantKind = servantWrapper:getServantKind()
  local servantKindSub = servantWrapper:getServantKindSub()
  if false == itemSS:isServantTypeUsable(servantKind, servantKindSub) then
    return false
  end
  return itemSSW:isUsableServant()
end
function PaGlobal_ShipEquipManagement:resize()
  if nil == Panel_Window_ShipEquipManagement_ALL then
    return
  end
  Panel_Window_ShipEquipManagement_ALL:ComputePos()
end
function PaGlobal_ShipEquipManagement:repositionSelectLine()
  if CppEnums.ItemWhereType.eInventory == self._currentWhereType then
    self._ui._stc_selectLine:SetPosX(self._ui._radio_myBag:GetPosX())
  elseif CppEnums.ItemWhereType.eCashInventory == self._currentWhereType then
    self._ui._stc_selectLine:SetPosX(self._ui._radio_pearlBag:GetPosX())
  end
end
function PaGlobal_ShipEquipManagement:initScrollPos()
  self._startInvenSlotIndex = 0
  self._ui._scroll_inventory:SetControlTop()
  self._ui._scroll_inventory:SetControlPos(0)
end
function PaGlobal_ShipEquipManagement:initTab()
  self._ui._radio_myBag:SetCheck(true)
  self._ui._radio_pearlBag:SetCheck(false)
end
function PaGlobal_ShipEquipManagement:isBigShip(actorKeyRaw)
  local servantWrapper = getServantInfoFromActorKey(actorKeyRaw)
  if nil == servantWrapper then
    return false
  end
  local vehicleType = servantWrapper:getVehicleType()
  if CppEnums.VehicleType.Type_Boat == vehicleType or CppEnums.VehicleType.Type_Raft == vehicleType or CppEnums.VehicleType.Type_FishingBoat == vehicleType or CppEnums.VehicleType.Type_FastShip == vehicleType then
    return false
  end
  return true
end
