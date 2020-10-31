local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
local UI_VT = CppEnums.VehicleType
local rowLine = 0
function ServantInventoryShowAni()
  UIAni.fadeInSCR_Down(Panel_Window_ServantInventory)
end
function ServantInventoryHideAni()
  Panel_Window_ServantInventory:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Window_ServantInventory:addColorAnimation(0, 0.22, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(16777215)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
local servantInventory = {
  _config = {
    item = {
      createIcon = true,
      createBorder = true,
      createCount = true,
      createEnchant = true,
      createCash = true,
      createEnduranceIcon = true
    },
    inventory = {
      startX = 15,
      startY = 60,
      gapY = 275
    },
    slot = {
      count = 41,
      column = 8,
      row = 0,
      startX = 12,
      startY = 40,
      gapX = 47,
      gapY = 47
    },
    inventoryCount = CppEnums.ServantType.Type_Count - 1
  },
  _buttonClose = nil,
  _buttonQuestion = nil,
  _txt_Title = nil,
  _inventory = Array.new(),
  _deleteSlotNo = nil,
  _s64_deleteCount = Defines.s64_const.s64_0,
  _targetActorKeyRaw = nil
}
function servantInventory:init()
  Panel_Window_ServantInventory:SetShow(false, false)
  Panel_Window_ServantInventory:setMaskingChild(true)
  Panel_Window_ServantInventory:ActiveMouseEventEffect(true)
  Panel_Window_ServantInventory:setGlassBackground(true)
  Panel_Window_ServantInventory:RegisterShowEventFunc(true, "ServantInventoryShowAni()")
  Panel_Window_ServantInventory:RegisterShowEventFunc(false, "ServantInventoryHideAni()")
  servantInventory._buttonClose = UI.getChildControl(Panel_Window_ServantInventory, "Button_Close")
  servantInventory._buttonQuestion = UI.getChildControl(Panel_Window_ServantInventory, "Button_Question")
  servantInventory._txt_Title = UI.getChildControl(Panel_Window_ServantInventory, "StaticText_Title")
  local slotConfig = self._config.slot
  local inventoryConfig = self._config.inventory
  local useStartSlot = inventorySlotNoUserStart()
  slotConfig.row = slotConfig.count / slotConfig.column
  for ii = 0, self._config.inventoryCount do
    local inventory = {}
    inventory._staticBG = UI.createAndCopyBasePropertyControl(Panel_Window_ServantInventory, "Static_BG", Panel_Window_ServantInventory, "ServantInventory_BG_" .. ii)
    inventory._staticTitle = UI.createAndCopyBasePropertyControl(Panel_Window_ServantInventory, "StaticText_SubTitle", inventory._staticBG, "ServantInventory_Title_" .. ii)
    inventory._staticCapacity = UI.createAndCopyBasePropertyControl(Panel_Window_ServantInventory, "StaticText_Capacity", inventory._staticBG, "ServantInventory_Capacity_" .. ii)
    inventory._staticMoney = UI.createAndCopyBasePropertyControl(Panel_Window_ServantInventory, "StaticText_Money", inventory._staticBG, "ServantInventory_StaticMoney_" .. ii)
    inventory._buttonMoney = UI.createAndCopyBasePropertyControl(Panel_Window_ServantInventory, "Button_Money", inventory._staticBG, "ServantInventory_ButtonMoney_" .. ii)
    inventory._iconWeight = UI.createAndCopyBasePropertyControl(Panel_Window_ServantInventory, "StaticIcon_Weight", inventory._staticBG, "ServantInventory_Weight_Icon_" .. ii)
    inventory._staticWeight = UI.createAndCopyBasePropertyControl(Panel_Window_ServantInventory, "StaticText_Weight", inventory._staticBG, "ServantInventory_Weight_Text_" .. ii)
    inventory._weightInventory = UI.createAndCopyBasePropertyControl(Panel_Window_ServantInventory, "Progress2_Weight", inventory._staticBG, "ServantInventory_Weight_Inventory_" .. ii)
    inventory._weightEquipment = UI.createAndCopyBasePropertyControl(Panel_Window_ServantInventory, "Progress2_Equipment", inventory._staticBG, "ServantInventory_Weight_Equip_" .. ii)
    inventory._weightMoney = UI.createAndCopyBasePropertyControl(Panel_Window_ServantInventory, "Progress2_Money", inventory._staticBG, "ServantInventory_Weight_Money_" .. ii)
    inventory._staticMoney:SetShow(false)
    inventory._buttonMoney:SetShow(false)
    inventory._slot = Array.new()
    inventory._type = nil
    inventory._actorKeyRaw = nil
    for jj = 0, slotConfig.count - 1 do
      local slotNo = jj + useStartSlot
      local slot = {}
      slot.empty = UI.createAndCopyBasePropertyControl(Panel_Window_ServantInventory, "Static_Slot", inventory._staticBG, "ServantInventory_Inventory_Empty_" .. ii .. "_" .. jj)
      slot.lock = UI.createAndCopyBasePropertyControl(Panel_Window_ServantInventory, "Static_LockedSlot", inventory._staticBG, "ServantInventory_Inventory_Lock_" .. ii .. "_" .. jj)
      slot.useless = UI.createAndCopyBasePropertyControl(Panel_Window_ServantInventory, "Static_UselessSlot", inventory._staticBG, "ServantInventory_Inventory_Useless_" .. ii .. "_" .. jj)
      slot.enchantText = UI.createAndCopyBasePropertyControl(Panel_Window_ServantInventory, "Static_Enchant", inventory._staticBG, "ServantInventory_Inventory_Enchant_" .. ii .. "_" .. jj)
      SlotItem.new(slot, "ItemIcon_" .. jj, jj, inventory._staticBG, self._config.item)
      slot:createChild()
      local column = jj % slotConfig.column
      local row = math.floor(jj / slotConfig.column)
      slot.empty:SetPosX(slotConfig.startX + slotConfig.gapX * column)
      slot.empty:SetPosY(slotConfig.startY + slotConfig.gapY * row)
      slot.lock:SetPosX(slotConfig.startX + slotConfig.gapX * column)
      slot.lock:SetPosY(slotConfig.startY + slotConfig.gapY * row)
      slot.useless:SetPosX(slotConfig.startX + slotConfig.gapX * column)
      slot.useless:SetPosY(slotConfig.startY + slotConfig.gapY * row)
      slot.icon:SetPosX(slotConfig.startX + slotConfig.gapX * column)
      slot.icon:SetPosY(slotConfig.startY + slotConfig.gapY * row)
      slot.enchantText:SetPosX(slotConfig.startX + slotConfig.gapX * column)
      slot.enchantText:SetPosY(slotConfig.startY + slotConfig.gapY * row)
      inventory._staticBG:SetChildIndex(slot.enchantText, 9999)
      slot.enchantText:SetSize(slot.icon:GetSizeX(), slot.icon:GetSizeY())
      slot.enchantText:SetTextHorizonCenter()
      slot.enchantText:SetTextVerticalCenter()
      slot.icon:SetIgnore(false)
      slot.icon:SetEnableDragAndDrop(true)
      slot.icon:SetAutoDisableTime(2)
      slot.icon:SetShow(true)
      slot.empty:SetShow(false)
      slot.lock:SetShow(false)
      slot.useless:SetShow(false)
      slot.enchantText:SetShow(false)
      slot.icon:addInputEvent("Mouse_LUp", "ServantInventory_DropHandler(" .. ii .. ", " .. slotNo .. ")")
      slot.icon:addInputEvent("Mouse_RUp", "ServantInventory_SlotRClick(" .. ii .. ", " .. slotNo .. ")")
      slot.icon:addInputEvent("Mouse_PressMove", "ServantInventory_SlotDrag(" .. ii .. ", " .. slotNo .. ")")
      slot.icon:addInputEvent("Mouse_On", "Panel_Tooltip_Item_Show_GeneralNormal(" .. slotNo .. ", \"servant_inventory\",true, " .. ii .. ")")
      slot.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralNormal(" .. slotNo .. ", \"servant_inventory\",false," .. ii .. ")")
      Panel_Tooltip_Item_SetPosition(slotNo, slot, "servant_inventory")
      inventory._slot[jj] = slot
    end
    inventory._staticBG:SetShow(true)
    inventory._staticTitle:SetShow(true)
    inventory._staticTitle:SetText(ii)
    inventory._buttonMoney:addInputEvent("Mouse_LUp", "ServantInventory_SlotRClick( " .. ii .. ", 0 )")
    self._inventory[ii] = inventory
  end
  registerCloseLuaEvent(Panel_Window_ServantInventory, PAUIRenderModeBitSet({
    Defines.CloseType.eCloseType_Escape
  }), "ServantInventory_Close()")
  servantInventory:registEventHandler()
end
function servantInventory:update()
  if nil == Panel_Window_ServantInventory then
    return
  end
  for ii = 0, self._config.inventoryCount do
    self:updateByIndex(ii)
  end
  local sizeY = 0
  local inventoryConfig = self._config.inventory
  for ii = 0, self._config.inventoryCount do
    local data = self._inventory[ii]
    if nil ~= data._actorKeyRaw then
      data._staticBG:SetPosY(inventoryConfig.startY + sizeY)
      sizeY = sizeY + data._staticBG:GetSizeY() + 10
    end
  end
  sizeY = sizeY + 55
  Panel_Window_ServantInventory:SetSize(Panel_Window_ServantInventory:GetSizeX(), sizeY)
end
function servantInventory:updateByIndex(index)
  local data = self._inventory[index]
  data._staticBG:SetShow(false)
  if nil == data._actorKeyRaw then
    return
  end
  local vehicleActorWrapper = getVehicleActor(data._actorKeyRaw)
  if nil == vehicleActorWrapper then
    return
  end
  local vehicleActor = vehicleActorWrapper:get()
  if nil == vehicleActor then
    return
  end
  local vehicleType = vehicleActor:getVehicleType()
  local titleStringKey = vehicleType == UI_VT.Type_CampingTent and "PANEL_SERVANTINVENTORY_TENT_TITLE" or "UI_SERVANTINVENTORY_TITLE"
  self._txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, titleStringKey))
  local inventory = vehicleActor:getInventory()
  if nil == inventory then
    return
  end
  local useStartSlot = inventorySlotNoUserStart()
  local fullCount = inventory:size() - useStartSlot
  local freeCount = inventory:getFreeCount()
  data._staticTitle:SetText(vehicleActorWrapper:getName())
  data._staticCapacity:SetText(tostring(fullCount - freeCount .. "/" .. fullCount))
  data._staticMoney:SetText(tostring(inventory:getMoney_s64()))
  local s64_weightMax = vehicleActor:getPossessableWeight_s64()
  local s64_weightAll = vehicleActor:getCurrentWeight_s64()
  local s64_weightInventory = inventory:getWeight_s64()
  local s64_weightMoney = inventory:getMoneyWeight_s64()
  local s64_weightEquip = Defines.s64_const.s64_0
  local s64_weightMoneyEquip = Defines.s64_const.s64_0
  local equip = vehicleActor:getEquipment()
  if nil ~= equip then
    s64_weightEquip = equip:getWeight_s64()
  end
  s64_weightMoneyEquip = s64_weightMoney + s64_weightEquip
  local s64_weightMax_div = s64_weightMax / Defines.s64_const.s64_100
  data._weightMoney:SetProgressRate(Int64toInt32(s64_weightMoney / s64_weightMax_div))
  data._weightEquipment:SetProgressRate(Int64toInt32(s64_weightMoneyEquip / s64_weightMax_div))
  data._weightInventory:SetProgressRate(Int64toInt32(s64_weightAll / s64_weightMax_div))
  local str_AllWeight = makeWeightString(s64_weightAll, 1)
  local str_MaxWeight = makeWeightString(s64_weightMax, 0)
  data._staticWeight:SetText(str_AllWeight .. " /" .. str_MaxWeight .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"))
  data._weightInventory:SetProgressRate(Int64toInt32(s64_weightAll / s64_weightMax_div))
  data._weightEquipment:SetProgressRate(Int64toInt32(s64_weightMoneyEquip / s64_weightMax_div))
  data._weightMoney:SetProgressRate(Int64toInt32(s64_weightMoney / s64_weightMax_div))
  for ii = 0, self._config.slot.count - 1 do
    local slot = data._slot[ii]
    slot.empty:SetShow(false)
    slot.lock:SetShow(false)
    slot.useless:SetShow(false)
    slot.icon:SetIgnore(true)
    if fullCount > ii then
      slot.empty:SetShow(true)
      slot.icon:SetIgnore(false)
    elseif fullCount <= ii then
      slot.useless:SetShow(true)
    end
    slot:clearItem()
  end
  for ii = 0, fullCount - 1 do
    local slot = data._slot[ii]
    local slotNo = ii + useStartSlot
    local itemWrapper = getServantInventoryItemBySlotNo(data._actorKeyRaw, slotNo)
    if nil ~= itemWrapper then
      slot:setItem(itemWrapper)
    end
  end
  local row = math.floor((fullCount - 1) / 8) + 1
  data._staticBG:SetSize(data._staticBG:GetSizeX(), 70 + 50 * row)
  data._staticTitle:ComputePos()
  data._staticCapacity:ComputePos()
  data._staticMoney:ComputePos()
  data._buttonMoney:ComputePos()
  data._iconWeight:ComputePos()
  data._staticWeight:ComputePos()
  data._weightInventory:ComputePos()
  data._weightEquipment:ComputePos()
  data._weightMoney:ComputePos()
  data._staticBG:SetShow(true)
  if true == _ContentsGroup_NewUI_ServantInfo_All then
    PaGlobal_VehicleInfo_All_InfoUpdate()
  else
    ServantInfo_Update()
  end
end
function servantInventory:clearActorKey()
  for ii = 0, self._config.inventoryCount do
    self._inventory[ii]._actorKeyRaw = nil
  end
end
function servantInventory:getInventoryCount()
  local count = 0
  for ii = 0, self._config.inventoryCount do
    local inventory = self._inventory[ii]
    if nil ~= inventory._actorKeyRaw then
      count = count + 1
    end
  end
  return count
end
function servantInventory:registMessageHandler()
  if false == _ContentsGroup_UsePadSnapping then
    registerEvent("FromClient_ServantInventoryOpenWithInventory", "ServantInventoryOpenWithInventory")
  end
  registerEvent("FromClient_ServantInventoryUpdate", "ServantInventory_updateSlotData")
  registerEvent("FromClient_UpdateCannonBallCount", "ServantInventory_updateSlotData")
  registerEvent("EventServantEquipmentUpdate", "ServantInventory_updateSlotData")
end
function servantInventory:registEventHandler()
  self._buttonClose:addInputEvent("Mouse_LUp", "ServantInventory_Close()")
  self._buttonQuestion:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelServantInventory\" )")
  PaGlobal_Util_RegistHelpTooltipEvent(self._buttonQuestion, "\"PanelServantInventory\"")
end
function ServantInventory_SlotRClick(index, slotNo)
  if ServantInventory_DropHandler(index, slotNo) then
    return
  end
  local self = servantInventory
  local type = self._inventory[index]._type
  local actorKeyRaw = self._inventory[index]._actorKeyRaw
  local vehicleActor = getVehicleActor(actorKeyRaw)
  if nil == vehicleActor then
    return
  end
  FGlobal_PopupMoveItem_Init(CppEnums.ItemWhereType.eServantInventory, slotNo, type, actorKeyRaw, true)
  local inventoryType = CppEnums.ItemWhereType.eServantInventory
  local itemWrapper = getServantInventoryItemBySlotNo(actorKeyRaw, slotNo)
  if nil ~= itemWrapper then
    local itemStatic = itemWrapper:getStaticStatus():get()
    if nil ~= itemStatic then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
    end
  end
end
function ServantInventory_SlotDrag(index, slotNo)
  local self = servantInventory
  self._targetActorKeyRaw = self._inventory[index]._actorKeyRaw
  local vehicleWrapper = getVehicleActor(self._targetActorKeyRaw)
  if nil == vehicleWrapper then
    return
  end
  local vehicle = vehicleWrapper:get()
  local inventory = vehicle:getInventory()
  if inventory:empty(slotNo) then
    return
  end
  local itemWrapper = getServantInventoryItemBySlotNo(self._targetActorKeyRaw, slotNo)
  if nil == itemWrapper then
    return
  end
  DragManager:setDragInfo(Panel_Window_ServantInventory, CppEnums.ItemWhereType.eServantInventory, slotNo, "Icon/" .. itemWrapper:getStaticStatus():getIconPath(), ServantInventory_GroundClick, self._targetActorKeyRaw)
end
function ServantInventory_GroundClick(whereType, slotNo)
  if true == _ContentsGroup_NewUI_Camp_All then
    if false == PaGlobalFunc_ServantInventory_GetShow() and false == PaGlobalFunc_CampWarehouse_All_GetShow() then
      return
    end
  elseif false == PaGlobalFunc_ServantInventory_GetShow() then
    return
  end
  local vehicleActorWrapper = getVehicleActor(servantInventory._targetActorKeyRaw)
  if nil == vehicleActorWrapper then
    return
  end
  local vehicleActor = vehicleActorWrapper:get()
  if nil == vehicleActor then
    return
  end
  if true == vehicleActor:isCannon() or true == vehicleActor:isGuildVehicle() then
    local luaDelete = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DELETE")
    local luaDeleteItemMsg = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINVENTORY_ONLYTRASH_INVENTORY")
    local messageContent = luaDeleteItemMsg
    local messageboxData = {
      title = luaDelete,
      content = messageContent,
      functionYes = ServantInventory_Delete_No,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
    return
  end
  if true == _ContentsGroup_NewUI_Inventory_All then
    local luaDeleteItemMsg = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ONLYTRASH_INVENTORY")
    local luaDelete = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DELETE")
    local messageContent = luaDeleteItemMsg
    local messageboxData = {
      title = luaDelete,
      content = messageContent,
      functionYes = ServantInventory_Delete_No,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
    PaGlobalFunc_Inventory_All_RunTrashBtnEffect()
  else
    local self = servantInventory
    local itemWrapper = getServantInventoryItemBySlotNo(self._targetActorKeyRaw, slotNo)
    if nil == itemWrapper then
      return
    end
    itemCount = itemWrapper:get():getCount_s64()
    itemName = itemWrapper:getStaticStatus():getName()
    if Defines.s64_const.s64_1 == itemCount then
      ServantInventory_GroundClick_Message(Defines.s64_const.s64_1, slotNo)
    else
      Panel_NumberPad_Show(true, itemCount, slotNo, ServantInventory_GroundClick_Message)
    end
  end
end
function ServantInventory_GroundClick_Message(s64_itemCount, slotNo)
  local self = servantInventory
  self._deleteSlotNo = slotNo
  self._s64_deleteCount = s64_itemCount
  local itemWrapper = getServantInventoryItemBySlotNo(self._targetActorKeyRaw, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemName = itemWrapper:getStaticStatus():getName()
  local luaDeleteItemMsg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DELETEITEM_MSG", "itemName", itemName, "itemCount", tostring(s64_itemCount))
  local luaDelete = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DELETE")
  local messageContent = luaDeleteItemMsg
  local messageboxData = {
    title = luaDelete,
    content = messageContent,
    functionYes = ServantInventory_Delete_Yes,
    functionNo = ServantInventory_Delete_No,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function ServantInventory_Delete_Yes()
  local self = servantInventory
  if nil == self._deleteSlotNo then
    return
  end
  local itemWrapper = getServantInventoryItemBySlotNo(self._targetActorKeyRaw, self._deleteSlotNo)
  if nil == itemWrapper then
    return
  end
  if itemWrapper:isCash() and false == itemWrapper:checkTimeover() and true == checkPaymentPassword() then
    PaymentPassword(ServantInventory_Delete_YesXXX)
    return
  end
  ServantInventory_Delete_YesXXX()
end
function ServantInventory_Delete_YesXXX()
  local self = servantInventory
  deleteItem(self._targetActorKeyRaw, CppEnums.ItemWhereType.eServantInventory, self._deleteSlotNo, self._s64_deleteCount)
  DragManager:clearInfo()
end
function ServantInventory_Delete_No()
  local self = servantInventory
  self._deleteSlotNo = nil
  self._s64_deleteCount = Defines.s64_const.s64_0
  DragManager:clearInfo()
  if true == _ContentsGroup_NewUI_Inventory_All then
    PaGlobalFunc_Inventory_All_ResetTrashBtnEffect()
  end
end
function ServantInventory_DropHandler(index, toSlotNo)
  local self = servantInventory
  if nil == DragManager.dragStartPanel then
    return false
  end
  if true == _ContentsGroup_NewUI_Camp_All and false == PaGlobalFunc_CampWarehouse_All_GetShow() and Panel_Window_CampWarehouse_All == DragManager.dragStartPanel then
    DragManager:clearInfo()
    return
  end
  if Panel_Window_ServantInventory == DragManager.dragStartPanel then
    DragManager:clearInfo()
    return
  end
  return (DragManager:itemDragMove(self._inventory[index]._type, self._inventory[index]._actorKeyRaw))
end
function ServantInventoryOpenWithInventory(actorKeyRaw)
  PaGlobalFunc_ServantInventory_CheckLoadUI()
  if true == _ContentsGroup_RenewUI_Inventory then
    PaGlobalFunc_InventoryInfo_Open(4)
    return
  end
  local self = servantInventory
  self:clearActorKey()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isFreeBattle = selfPlayer:get():isBattleGroundDefine()
  if true == isFreeBattle then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_FREEBATTLE_NOT_USE"))
    return
  end
  local vehicleActorWrapper = getVehicleActor(actorKeyRaw)
  if nil == vehicleActorWrapper then
    return
  end
  local vehicleActor = vehicleActorWrapper:get()
  if nil == vehicleActor then
    return
  end
  if true == _ContentsGroup_NewUI_Camp_All and true == PaGlobalFunc_CampWarehouse_All_GetShow() then
    PaGlobalFunc_CampWarehouse_All_Close()
  end
  local vehicleType = vehicleActor:getVehicleType()
  if not vehicleActor:isCannon() and not vehicleActor:isSiegeInstanceObject() and vehicleType ~= UI_VT.Type_Train and vehicleType ~= UI_VT.Type_CampingTent then
    ServantInventory_OpenAll()
  elseif vehicleType == UI_VT.Type_CampingTent then
    self._inventory[0]._actorKeyRaw = actorKeyRaw
    self._inventory[0]._type = CppEnums.MoveItemToType.Type_Vehicle
    if false == _ContentsGroup_NewUI_Camp_All then
      ServantInventory_Open()
    else
      PaGlobalFunc_CampWarehouse_All_Open(actorKeyRaw)
    end
  else
    self._inventory[0]._actorKeyRaw = actorKeyRaw
    self._inventory[0]._type = CppEnums.MoveItemToType.Type_Vehicle
    ServantInventory_Open()
  end
  if vehicleType == UI_VT.Type_CampingTent then
    self._txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTINVENTORY_TENT_TITLE"))
    self._buttonQuestion:SetShow(false)
    self._buttonQuestion:addInputEvent("Mouse_LUp", "")
  else
    self._txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_SERVANTINVENTORY_TITLE"))
    self._buttonQuestion:SetShow(false == _ContentsOption_CH_WepHelperControl)
    self._buttonQuestion:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelServantInventory\" )")
  end
  if vehicleType == UI_VT.Type_CampingTent and true == _ContentsGroup_NewUI_Camp_All then
    Inventory_SetFunctor(nil, FGlobal_PopupMoveItem_InitByInventory, PaGlobalFunc_CampWarehouse_All_Close, nil)
  else
    Inventory_SetFunctor(nil, FGlobal_PopupMoveItem_InitByInventory, ServantInventory_Close, nil)
  end
  InventoryWindow_Show()
  if true == _ContentsGroup_NewUI_Inventory_All then
    Panel_Window_ServantInventory:SetPosX(Panel_Window_Inventory_All:GetPosX() - Panel_Window_ServantInventory:GetSizeX() - 10)
    Panel_Window_ServantInventory:SetPosY(Panel_Window_Inventory_All:GetPosY())
  else
    Panel_Window_ServantInventory:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Window_ServantInventory:GetSizeX() - 10)
    Panel_Window_ServantInventory:SetPosY(Panel_Window_Inventory:GetPosY())
  end
end
function ServantInventory_updateSlotData()
  local self = servantInventory
  self:update()
end
function ServantInventory_GetActorKeyRawFromIndex(index)
  local self = servantInventory
  return self._inventory[index]._actorKeyRaw
end
function ServantInventory_getInventoryFromType(index)
  local self = servantInventory
  return self._inventory[index]
end
function ServantInventory_GetActorKeyRawFromDragManager()
  local self = servantInventory
  return self._targetActorKeyRaw
end
function ServantInventory_OpenAll()
  PaGlobalFunc_ServantInventory_CheckLoadUI()
  local self = servantInventory
  local index = 0
  for ii = 0, self._config.inventoryCount do
    if servant_checkDistance(ii) then
      local vehicle = getTemporaryInformationWrapper():getUnsealVehicle(ii)
      if nil ~= vehicle then
        local myvehicleinfo = stable_getServantByServantNo(vehicle:getServantNo())
        local hasRentOwnerFlag = false
        if nil ~= myvehicleinfo then
          hasRentOwnerFlag = Defines.s64_const.s64_0 < myvehicleinfo:getRentOwnerNo()
        end
        if 0 < vehicle:getInventory():size() and false == hasRentOwnerFlag and vehicle:getVehicleType() ~= UI_VT.Type_CampingTent then
          self._inventory[ii]._actorKeyRaw = vehicle:getActorKeyRaw()
          self._inventory[ii]._type = ii
          index = index + 1
        end
      end
    end
  end
  if 0 < index then
    ServantInventory_Open()
  end
  if true == PaGlobalFunc_ServantInventory_GetShow() then
    Inventory_SetFunctor(nil, FGlobal_PopupMoveItem_InitByInventory, nil, nil)
  end
  if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
    PaGlobalFunc_ClothInventory_All_Close()
  else
    ClothInventory_Close()
  end
end
function ServantInventory_Open()
  PaGlobalFunc_ServantInventory_CheckLoadUI()
  Panel_Window_ServantInventory:SetShow(true)
  if GetUIMode() == Defines.UIMode.eUIMode_NpcDialog then
    Panel_Window_ServantInventory:SetPosX(math.max(0, Panel_Window_Warehouse:GetPosX() - Panel_Window_ServantInventory:GetSizeX() - 250 - 10))
    Panel_Window_ServantInventory:SetPosY(Panel_Window_Warehouse:GetPosY())
  end
  servantInventory:update()
  if not PaGlobalFunc_ServantInventory_GetShow() then
    return Panel_Window_ServantInventory:SetShow(true)
  end
end
function ServantInventory_Close()
  if not PaGlobalFunc_ServantInventory_GetShow() then
    return
  end
  local self = servantInventory
  self:clearActorKey()
  local tooltipPanel
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if Panel_Widget_Tooltip_Item_All:GetShow() then
      Panel_Tooltip_Item_hideTooltip()
    end
  elseif Panel_Tooltip_Item:GetShow() then
    Panel_Tooltip_Item_hideTooltip()
  end
  reqCloseUI(Panel_Window_ServantInventory, false)
  if _ContentsGroup_NewUI_Camp_All then
    PaGlobalFunc_Camp_All_SetIsCamping(false)
  else
    PaGlobal_Camp:setIsCamping(false)
  end
  if not isFlushedUI() and not Panel_Window_Warehouse:GetShow() then
    Inventory_SetFunctor(nil, nil, nil, nil)
  end
end
function PaGlobalFunc_ServantInventory_CheckLoadUI()
  local rv = reqLoadUI("UI_Data/Window/Inventory/UI_Window_ServantInventory.XML", "Panel_Window_ServantInventory", Defines.UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    Defines.RenderMode.eRenderMode_Default,
    Defines.RenderMode.eRenderMode_Dialog
  }))
  if nil ~= rv and 0 ~= rv then
    Panel_Window_ServantInventory = rv
    rv = nil
    servantInventory:init()
  end
end
function PaGlobalFunc_ServantInventory_GetShow()
  if nil == Panel_Window_ServantInventory then
    return false
  end
  return Panel_Window_ServantInventory:GetShow()
end
servantInventory:registMessageHandler()
