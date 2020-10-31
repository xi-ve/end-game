function PaGlobal_CargoLoading:initialize()
  if true == PaGlobal_CargoLoading._initialize then
    return
  end
  local stc_titleBarBG = UI.getChildControl(Panel_Window_CargoLoading_ALL, "Static_TitleBarBG")
  self._ui._btn_close = UI.getChildControl(stc_titleBarBG, "Button_Close")
  local stc_myWarehouse = UI.getChildControl(Panel_Window_CargoLoading_ALL, "Static_MyWarehouse")
  local stc_rdoButtons = UI.getChildControl(stc_myWarehouse, "Static_RadioButtons")
  self._ui._rdo_MyBag = UI.getChildControl(stc_rdoButtons, "RadioButton_MyBag")
  self._ui._rdo_myWarehouse = UI.getChildControl(stc_rdoButtons, "RadioButton_MyWareHouse")
  self._ui._stc_selectLine = UI.getChildControl(stc_rdoButtons, "Static_SelctLine")
  local warehouseBG = UI.getChildControl(stc_myWarehouse, "Static_warehouseInven_BG")
  self._ui._stc_warehouseInvenBG = warehouseBG
  self._ui._scroll_warehouse = UI.getChildControl(warehouseBG, "List2_1_VerticalScroll")
  self._ui._chk_sortButton = UI.getChildControl(stc_myWarehouse, "CheckButton_Sort")
  self._ui._txt_itemCount_warehouse = UI.getChildControl(stc_myWarehouse, "StaticText_ItemCount")
  local stc_myShip = UI.getChildControl(Panel_Window_CargoLoading_ALL, "Static_MyShip")
  self._ui._txt_myShip = UI.getChildControl(stc_myShip, "StaticText_MyShip")
  local stc_shipBG = UI.getChildControl(stc_myShip, "Static_shipInven_BG")
  self._ui._stc_shipInvenBG = stc_shipBG
  self._ui._scroll_ship = UI.getChildControl(stc_shipBG, "List2_1_VerticalScroll")
  local stc_weight = UI.getChildControl(stc_myShip, "Static_Weight")
  self._ui._progress_weightBar = UI.getChildControl(stc_weight, "Progress2_WeightBar")
  self._ui._txt_weightValue = UI.getChildControl(stc_weight, "StaticText_WeightValue")
  self._ui._txt_itemCount_ship = UI.getChildControl(stc_myShip, "StaticText_ItemCount2")
  self._ui._txt_guideBox = UI.getChildControl(Panel_Window_CargoLoading_ALL, "StaticText_GuideBox")
  self._ui._txt_guideBox:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_guideBox:SetText(self._ui._txt_guideBox:GetText())
  if self._ui._txt_guideBox:GetTextSizeY() > self._ui._txt_guideBox:GetSizeY() then
    UI.setLimitTextAndAddTooltip(self._ui._txt_guideBox)
  end
  self._ui._btn_barterInfo = UI.getChildControl(Panel_Window_CargoLoading_ALL, "Button_1")
  self._ui._btn_confirm = UI.getChildControl(Panel_Window_CargoLoading_ALL, "Button_Confirm")
  self._blankSlots = {}
  self._slots = {}
  for i = self._eSlotType.inventory, self._eSlotType.loopCount do
    self._blankSlots[i] = Array.new()
    self._slots[i] = Array.new()
  end
  self._rdoButtonsSizeX = stc_rdoButtons:GetSizeX()
  self:initMyInventorySlot()
  self:initServantInventorySlot()
  self._isFirstSetting = false
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_CargoLoading:registEventHandler()
  if nil == Panel_Window_CargoLoading_ALL then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "HandleEventMLUp_CargoLoading_Close()")
  self._ui._btn_confirm:addInputEvent("Mouse_LUp", "HandleEventMLUp_CargoLoading_Close()")
  self._ui._chk_sortButton:addInputEvent("Mouse_LUp", "HandleEventMLUp_CargoLoading_CheckSort()")
  self._ui._rdo_MyBag:addInputEvent("Mouse_LUp", "HandleEventMLUp_CargoLoading_UpdateMySlot(" .. self._eMySlot.myInven .. ")")
  self._ui._rdo_myWarehouse:addInputEvent("Mouse_LUp", "HandleEventMLUp_CargoLoading_UpdateMySlot(" .. self._eMySlot.myWarehouse .. ")")
  self._ui._btn_barterInfo:addInputEvent("Mouse_LUp", "HandleEventMLUp_CargoLoading_ToggleBarterInfo()")
  self._ui._btn_barterInfo:addInputEvent("Mouse_On", "HandleEventMOn_CargoLoading_SimpleTooltip()")
  self._ui._btn_barterInfo:addInputEvent("Mouse_Out", "HandleEventMOut_CargoLoading_SimpleTooltip()")
  registerEvent("EventWarehouseUpdate", "FromClient_CargoLoading_UpdateMyInventorySlot")
  registerEvent("FromClient_WarehouseUpdate", "FromClient_CargoLoading_UpdateMyInventorySlot")
  registerEvent("FromClient_ServantInventoryUpdate", "FromClient_CargoLoading_UpdateServantinven")
  registerEvent("FromClient_InventoryUpdate", "FromClient_CargoLoading_UpdateMyInventorySlot")
  registerEvent("onScreenResize", "FromClient_CargoLoading_Resize")
end
function PaGlobal_CargoLoading:prepareOpen(servantActorKey)
  if nil == Panel_Window_CargoLoading_ALL then
    return
  end
  self:initSlotInfo_warehouse()
  self:initSlotInfo_ship()
  self:initTab()
  self:checkCurrentRegionWarehouse()
  self:resize()
  self._servantActorKey = servantActorKey
  if true == self._ui._rdo_MyBag:IsCheck() then
    self._currentMySlotType = self._eMySlot.myInven
  elseif true == self._ui._rdo_myWarehouse:IsCheck() then
    self._currentMySlotType = self._eMySlot.myWarehouse
  end
  self:repositionSelectLine()
  if false == self:update() then
    return
  end
  self:open()
end
function PaGlobal_CargoLoading:open()
  if false == _ContentsGroup_Barter then
    return
  end
  if nil == Panel_Window_CargoLoading_ALL then
    return
  end
  Panel_Window_CargoLoading_ALL:SetShow(true)
end
function PaGlobal_CargoLoading:prepareClose()
  if nil == Panel_Window_CargoLoading_ALL then
    return
  end
  if true == Panel_Window_Barter_Search:IsShow() and false == Panel_Window_Barter_Search:IsUISubApp() then
    PaGlobal_BarterInfoSearch:close()
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_CargoLoading:close()
end
function PaGlobal_CargoLoading:close()
  if nil == Panel_Window_CargoLoading_ALL then
    return
  end
  Panel_Window_CargoLoading_ALL:SetShow(false)
end
function PaGlobal_CargoLoading:update()
  if nil == Panel_Window_CargoLoading_ALL then
    return
  end
  if false == self:updateMyInventorySlot() then
    return false
  end
  if false == self:updateServantSlot() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoWhrafIsFar"))
    return false
  end
  return true
end
function PaGlobal_CargoLoading:validate()
  if nil == Panel_Window_CargoLoading_ALL then
    return
  end
  self._ui._btn_close:isValidate()
  self._ui._rdo_MyBag:isValidate()
  self._ui._rdo_myWarehouse:isValidate()
  self._ui._stc_warehouseInvenBG:isValidate()
  self._ui._scroll_warehouse:isValidate()
  self._ui._chk_sortButton:isValidate()
  self._ui._txt_itemCount_warehouse:isValidate()
  self._ui._txt_myShip:isValidate()
  self._ui._stc_shipInvenBG:isValidate()
  self._ui._scroll_ship:isValidate()
  self._ui._progress_weightBar:isValidate()
  self._ui._txt_weightValue:isValidate()
  self._ui._txt_itemCount_ship:isValidate()
  self._ui._btn_confirm:isValidate()
end
function PaGlobal_CargoLoading:initMyInventorySlot()
  if nil == Panel_Window_CargoLoading_ALL then
    return
  end
  local slotCols = self:getSlotCols(self._eSlotType.inventory)
  self._config.slotCount_w = self._config.slotRows_w * slotCols
  UIScroll.InputEvent(self._ui._scroll_warehouse, "HandleEventScroll_CargoLoading_WarehouseScroll")
  UIScroll.InputEventByControl(self._ui._stc_warehouseInvenBG, "HandleEventScroll_CargoLoading_WarehouseScroll")
  local blankSlotList = self._blankSlots[self._eSlotType.inventory]
  local slotList = self._slots[self._eSlotType.inventory]
  for ii = 0, self._config.slotCount_w - 1 do
    local blankSlot
    if nil == blankSlotList[ii] then
      local slot = {}
      slot.empty = UI.createAndCopyBasePropertyControl(self._ui._stc_warehouseInvenBG, "Static_ItemSlotBg_Template", self._ui._stc_warehouseInvenBG, "Warehouse_Slot_Base_" .. ii)
      UIScroll.InputEventByControl(slot.empty, "HandleEventScroll_CargoLoading_WarehouseScroll")
      local row = math.floor(ii / slotCols)
      local column = ii % slotCols
      slot.empty:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
      slot.empty:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
      slot.empty:SetShow(false)
      blankSlotList[ii] = slot
    end
    blankSlot = blankSlotList[ii]
    if nil == slotList[ii] then
      local slot = {}
      SlotItem.new(slot, "ItemIcon_" .. ii, ii, self._ui._stc_warehouseInvenBG, self._slotConfig)
      slot:createChild()
      local row = math.floor(ii / slotCols)
      local column = ii % slotCols
      slot.icon:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
      slot.icon:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
      slot.icon:SetEnableDragAndDrop(true)
      slot.icon:SetAutoDisableTime(0.5)
      slot.icon:addInputEvent("Mouse_On", "HandleEventMOn_CargoLoading_IconOver(" .. self._eSlotType.inventory .. ", " .. ii .. ")")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventMOut_CargoLoading_IconOut(" .. self._eSlotType.inventory .. ", " .. ii .. ")")
      UIScroll.InputEventByControl(slot.icon, "HandleEventScroll_CargoLoading_WarehouseScroll")
      slotList[ii] = slot
    end
    if nil ~= blankSlot then
      blankSlot.lock = UI.createAndCopyBasePropertyControl(self._ui._stc_warehouseInvenBG, "Static_ItemSlotBg_LockIcon", self._ui._stc_warehouseInvenBG, "Warehouse_Slot_Lock_" .. ii)
      blankSlot.plus = UI.createAndCopyBasePropertyControl(self._ui._stc_warehouseInvenBG, "Static_MultipleSelect", self._ui._stc_warehouseInvenBG, "Warehouse_Slot_Plus_" .. ii)
      blankSlot.onlyPlus = UI.createAndCopyBasePropertyControl(self._ui._stc_warehouseInvenBG, "Static_ItemSlotBg_Plus", self._ui._stc_warehouseInvenBG, "Warehouse_Slot_OnlyPlus_" .. ii)
      local row = math.floor(ii / slotCols)
      local column = ii % slotCols
      blankSlot.lock:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
      blankSlot.lock:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
      blankSlot.plus:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
      blankSlot.plus:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
      blankSlot.onlyPlus:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
      blankSlot.onlyPlus:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
      blankSlot.lock:SetShow(true)
      blankSlot.plus:SetShow(false)
      blankSlot.onlyPlus:SetShow(false)
    end
  end
end
function PaGlobal_CargoLoading:initServantInventorySlot()
  if nil == Panel_Window_CargoLoading_ALL then
    return
  end
  local slotCols = self:getSlotCols(self._eSlotType.servant)
  self._config.slotCount_s = self._config.slotRows_s * slotCols
  UIScroll.InputEvent(self._ui._scroll_ship, "HandleEventScroll_CargoLoading_ServantScroll")
  UIScroll.InputEventByControl(self._ui._stc_shipInvenBG, "HandleEventScroll_CargoLoading_ServantScroll")
  local blankSlotList = self._blankSlots[self._eSlotType.servant]
  local slotList = self._slots[self._eSlotType.servant]
  for ii = 0, self._config.slotCount_s - 1 do
    local blankSlot
    if nil == blankSlotList[ii] then
      local slot = {}
      slot.empty = UI.createAndCopyBasePropertyControl(self._ui._stc_shipInvenBG, "Static_ItemSlotBg_Template", self._ui._stc_shipInvenBG, "Warehouse_Slot_Base_" .. ii)
      UIScroll.InputEventByControl(slot.empty, "HandleEventScroll_CargoLoading_ServantScroll")
      local row = math.floor(ii / slotCols)
      local column = ii % slotCols
      slot.empty:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
      slot.empty:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
      slot.empty:SetShow(false)
      blankSlotList[ii] = slot
    end
    blankSlot = blankSlotList[ii]
    if nil == slotList[ii] then
      local slot = {}
      SlotItem.new(slot, "ItemIcon_" .. ii, ii, self._ui._stc_shipInvenBG, self._slotConfig)
      slot:createChild()
      local row = math.floor(ii / slotCols)
      local column = ii % slotCols
      slot.icon:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
      slot.icon:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
      slot.icon:SetEnableDragAndDrop(true)
      slot.icon:SetAutoDisableTime(0.5)
      slot.icon:addInputEvent("Mouse_On", "HandleEventMOn_CargoLoading_IconOver(" .. self._eSlotType.servant .. ", " .. ii .. ")")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventMOut_CargoLoading_IconOut(" .. self._eSlotType.servant .. ", " .. ii .. ")")
      UIScroll.InputEventByControl(slot.icon, "HandleEventScroll_CargoLoading_ServantScroll")
      slotList[ii] = slot
    end
    if nil ~= blankSlot then
      blankSlot.lock = UI.createAndCopyBasePropertyControl(self._ui._stc_shipInvenBG, "Static_ItemSlotBg_LockIcon", self._ui._stc_shipInvenBG, "Warehouse_Slot_Lock_" .. ii)
      blankSlot.plus = UI.createAndCopyBasePropertyControl(self._ui._stc_shipInvenBG, "Static_MultipleSelect", self._ui._stc_shipInvenBG, "Warehouse_Slot_Plus_" .. ii)
      blankSlot.onlyPlus = UI.createAndCopyBasePropertyControl(self._ui._stc_shipInvenBG, "Static_ItemSlotBg_Plus", self._ui._stc_shipInvenBG, "Warehouse_Slot_OnlyPlus_" .. ii)
      local row = math.floor(ii / slotCols)
      local column = ii % slotCols
      blankSlot.lock:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
      blankSlot.lock:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
      blankSlot.plus:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
      blankSlot.plus:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
      blankSlot.onlyPlus:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
      blankSlot.onlyPlus:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
      blankSlot.lock:SetShow(true)
      blankSlot.plus:SetShow(false)
      blankSlot.onlyPlus:SetShow(false)
    end
  end
end
function PaGlobal_CargoLoading:setCurrentWareHouse()
  self._currentWaypointKey = getCurrentWaypointKey()
  self._currentRegionName = getRegionNameByWaypointKey(self._currentWaypointKey)
  warehouse_requestInfo(self._currentWaypointKey)
end
function PaGlobal_CargoLoading:updateMyInventorySlot()
  if nil == Panel_Window_CargoLoading_ALL then
    return
  end
  self._currentWaypointKey = getCurrentWaypointKey()
  self._currentRegionName = getRegionNameByWaypointKey(self._currentWaypointKey)
  if nil ~= self._currentRegionName then
    self._ui._rdo_myWarehouse:SetText(self._currentRegionName)
  end
  local selfPlayerWrapper = getSelfPlayer()
  local classType = selfPlayerWrapper:getClassType()
  if nil == selfPlayerWrapper then
    PaGlobal_CargoLoading:initSlot(self._eSlotType.inventory)
    return false
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    PaGlobal_CargoLoading:initSlot(self._eSlotType.inventory)
    return false
  end
  self._ui._chk_sortButton:SetCheck(ToClient_IsSortedWarehouse())
  local useStartSlot = 0
  local itemCount = 0
  local useMaxCount = 0
  local freeCount = 0
  self._maxCount_warehouse = 0
  local inventory = PaGlobal_CargoLoading_GetCurrentInventory()
  local warehouseWrapper
  if self._eMySlot.myInven == self._currentMySlotType then
    self._startSlot_warehouse = inventorySlotNoUserStart()
    useStartSlot = self._startSlot_warehouse
    useMaxCount = selfPlayer:getInventorySlotCount(false) - useStartSlot
    freeCount = inventory:getFreeCount()
    itemCount = useMaxCount - freeCount
    self._maxCount_warehouse = inventory:sizeXXX()
  elseif self._eMySlot.myWarehouse == self._currentMySlotType then
    warehouseWrapper = self:getWarehouse()
    if nil == warehouseWrapper then
      PaGlobal_CargoLoading:initSlot(self._eSlotType.inventory)
      return false
    end
    self._startSlot_warehouse = 1
    useStartSlot = self._startSlot_warehouse
    itemCount = warehouseWrapper:getSize()
    useMaxCount = warehouseWrapper:getUseMaxCount() - useStartSlot
    freeCount = warehouseWrapper:getFreeCount()
    self._maxCount_warehouse = warehouseWrapper:getMaxCount()
  end
  local maxCount = self._maxCount_warehouse
  if itemCount > useMaxCount then
    self._ui._txt_itemCount_warehouse:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "Lua_WareHouse_OverCapacity", "HaveCount", tostring(itemCount), "FullCount", tostring(useMaxCount)))
  else
    self._ui._txt_itemCount_warehouse:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "Lua_WareHouse_Capacity", "HaveCount", tostring(itemCount), "FullCount", tostring(useMaxCount)))
  end
  local lootMaxCount = useMaxCount + useStartSlot
  local slotNoList = Array.new()
  slotNoList:fill(useStartSlot, lootMaxCount)
  if self._ui._chk_sortButton:IsCheck() then
    local sortList = Array.new()
    sortList:fill(1, lootMaxCount)
    sortList:quicksort(PaGlobal_CargoLoading_ItemComparer)
    for ii = 1, lootMaxCount do
      slotNoList[ii] = sortList[ii]
    end
  end
  local blankSlotList = self._blankSlots[self._eSlotType.inventory]
  local slotList = self._slots[self._eSlotType.inventory]
  for ii = 0, self._config.slotCount_w - 1 do
    local slot = blankSlotList[ii]
    slot.empty:SetShow(false)
    slot.lock:SetShow(false)
    slot.plus:SetShow(false)
    slot.onlyPlus:SetShow(false)
    if ii < useMaxCount - self._startSlotIndex_warehouse then
      slot.empty:SetShow(true)
    else
      slot.lock:SetShow(true)
    end
  end
  UIScroll.SetButtonSize(self._ui._scroll_warehouse, self._config.slotCount_w, maxCount)
  PaGlobal_CargoLoading:initSlot(self._eSlotType.inventory)
  local slotCols = self:getSlotCols(self._eSlotType.inventory)
  for ii = 0, self._config.slotCount_w - 1 do
    local slot = slotList[ii]
    local slotNo = slotNoList[1 + ii + self._startSlotIndex_warehouse]
    slot.slotNo = slotNo
    local row = math.floor(ii / slotCols)
    local column = ii % slotCols
    slot.icon:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
    slot.icon:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
    slot.icon:SetMonoTone(false)
    slot.count:SetShow(false)
    if nil == slot.slotNo then
      slot:clearItem()
      slot.icon:addInputEvent("Mouse_RUp", "")
    else
      local itemWrapper
      if self._eMySlot.myInven == self._currentMySlotType then
        itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
      elseif self._eMySlot.myWarehouse == self._currentMySlotType then
        itemWrapper = warehouseWrapper:getItem(slotNo)
      end
      if nil ~= itemWrapper then
        slot:setItem(itemWrapper, slotNo, nil, warehouseWrapper)
        Panel_Tooltip_Item_SetPosition(ii, slot, "CargoLoadingWarehouse")
        slot.icon:addInputEvent("Mouse_RUp", "HandleEventMRUp_CargoLoading_SlotRClick(" .. PaGlobal_CargoLoading._eSlotType.inventory .. ", " .. ii .. ")")
        local itemCountZero = false
        if true == _ContentsGroup_NewDelivery then
          local itemStatic = itemWrapper:getStaticStatus()
          if nil ~= itemStatic then
            local item = itemStatic:get()
            local itemCount = Int64toInt32(itemWrapper:get():getCount_s64())
            if self._eMySlot.myInven == self._currentMySlotType then
              if true == item._isStack then
                slot.count:SetText(tostring(itemCount))
              end
            elseif self._eMySlot.myWarehouse == self._currentMySlotType then
              local packListItemCount = ToClient_NewDeliveryGetPackItemCountBySlotNo(slotNo)
              local remainedItemCount = itemCount - packListItemCount
              if 0 == remainedItemCount then
                itemCountZero = true
              end
              if true == item._isStack then
                slot.count:SetText(tostring(remainedItemCount))
              end
            end
          end
        end
      else
        slot.icon:addInputEvent("Mouse_RUp", "")
      end
    end
    slot.icon:SetEnableDragAndDrop(true)
  end
end
function PaGlobal_CargoLoading:updateServantSlot()
  if nil == Panel_Window_CargoLoading_ALL then
    return
  end
  local vehicleActorWrapper = getVehicleActor(self._servantActorKey)
  if nil == vehicleActorWrapper then
    PaGlobal_CargoLoading:initSlot(self._eSlotType.servant)
    return false
  end
  local vehicleActor = vehicleActorWrapper:get()
  local inventory = vehicleActor:getInventory()
  if nil == inventory then
    PaGlobal_CargoLoading:initSlot(self._eSlotType.servant)
    return false
  end
  self._startSlot_ship = inventorySlotNoUserStart()
  local useStartSlot = self._startSlot_ship
  self._maxCount_ship = inventory:size()
  local useMaxCount = self._maxCount_ship - useStartSlot
  local freeCount = inventory:getFreeCount()
  local itemCount = useMaxCount - freeCount
  if useMaxCount < itemCount then
    self._ui._txt_itemCount_ship:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "Lua_WareHouse_OverCapacity", "HaveCount", tostring(itemCount), "FullCount", tostring(useMaxCount)))
  else
    self._ui._txt_itemCount_ship:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "Lua_WareHouse_Capacity", "HaveCount", tostring(itemCount), "FullCount", tostring(useMaxCount)))
  end
  local s64_weightMax = vehicleActor:getPossessableWeight_s64()
  local s64_weightAll = vehicleActor:getCurrentWeight_s64()
  local s64_weightMax_div = s64_weightMax / Defines.s64_const.s64_100
  local s64_weightAll_div = s64_weightAll / Defines.s64_const.s64_100
  local str_AllWeight = makeWeightString(s64_weightAll, 1)
  local str_MaxWeight = makeWeightString(s64_weightMax, 0)
  self._ui._txt_weightValue:SetText(str_AllWeight .. " / " .. str_MaxWeight .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"))
  self._ui._progress_weightBar:SetProgressRate(Int64toInt32(s64_weightAll / s64_weightMax_div))
  local slotNoList = Array.new()
  slotNoList:fill(useStartSlot, useMaxCount + 1)
  local blankSlotList = self._blankSlots[self._eSlotType.servant]
  local slotList = self._slots[self._eSlotType.servant]
  for ii = 0, self._config.slotCount_s - 1 do
    local slot = blankSlotList[ii]
    slot.empty:SetShow(false)
    slot.lock:SetShow(false)
    slot.plus:SetShow(false)
    slot.onlyPlus:SetShow(false)
    if ii < useMaxCount - self._startSlotIndex_ship then
      slot.empty:SetShow(true)
    else
      slot.lock:SetShow(true)
    end
  end
  UIScroll.SetButtonSize(self._ui._scroll_ship, self._config.slotCount_s, useMaxCount)
  PaGlobal_CargoLoading:initSlot(self._eSlotType.servant)
  local slotCols = self:getSlotCols(self._eSlotType.servant)
  for ii = 0, self._config.slotCount_s - 1 do
    local slot = slotList[ii]
    local slotNo = slotNoList[1 + ii + self._startSlotIndex_ship]
    slot.slotNo = slotNo
    local row = math.floor(ii / slotCols)
    local column = ii % slotCols
    slot.icon:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
    slot.icon:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
    slot.icon:SetMonoTone(false)
    slot.count:SetShow(false)
    if nil == slot.slotNo then
      slot:clearItem()
    else
      local itemWrapper = getServantInventoryItemBySlotNo(self._servantActorKey, slotNo)
      if nil ~= itemWrapper then
        slot:setItem(itemWrapper, slotNo, nil, nil)
        Panel_Tooltip_Item_SetPosition(ii, slot, "CargoLoadingServant")
        slot.icon:addInputEvent("Mouse_RUp", "HandleEventMRUp_CargoLoading_SlotRClick(" .. PaGlobal_CargoLoading._eSlotType.servant .. ", " .. ii .. ")")
        local itemCountZero = false
        if true == _ContentsGroup_NewDelivery then
          local itemStatic = itemWrapper:getStaticStatus()
          if nil ~= itemStatic then
            local item = itemStatic:get()
            local warehouseItemCount = Int64toInt32(itemWrapper:get():getCount_s64())
            local packListItemCount = ToClient_NewDeliveryGetPackItemCountBySlotNo(slotNo)
            local warehouseRemainedItemCount = warehouseItemCount - packListItemCount
            if 0 == warehouseRemainedItemCount then
              itemCountZero = true
            end
            if true == item._isStack then
              slot.count:SetText(tostring(warehouseRemainedItemCount))
            end
          end
        end
      end
    end
    slot.icon:SetEnableDragAndDrop(true)
  end
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_CargoLoading:initSlot(eSlotType)
  local slotList = self._slots[eSlotType]
  local slotCount = 0
  if self._eSlotType.inventory == eSlotType then
    slotCount = self._config.slotCount_w
  elseif self._eSlotType.servant == eSlotType then
    slotCount = self._config.slotCount_s
  end
  for ii = 0, slotCount - 1 do
    local slot = slotList[ii]
    if nil ~= slot then
      slot:clearItem()
      slot.icon:SetEnable(true)
      if false == _ContentsGroup_NewDelivery then
        slot.icon:SetMonoTone(true)
      end
    end
  end
end
function PaGlobal_CargoLoading:getWarehouse()
  local warehouseWrapper
  warehouseWrapper = warehouse_get(self._currentWaypointKey)
  return warehouseWrapper
end
function PaGlobal_CargoLoadding_GetTooltipWareHouseItem(index)
  local slot = PaGlobal_CargoLoading._slots[PaGlobal_CargoLoading._eSlotType.inventory]
  if nil == slot[index] then
    return nil
  end
  if PaGlobal_CargoLoading._eMySlot.myInven == PaGlobal_CargoLoading._currentMySlotType then
    return getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slot[index].slotNo)
  elseif PaGlobal_CargoLoading._eMySlot.myWarehouse == PaGlobal_CargoLoading._currentMySlotType then
    local warehouseWrapper = PaGlobal_CargoLoading:getWarehouse()
    if nil == warehouseWrapper then
      return nil
    end
    return warehouseWrapper:getItem(slot[index].slotNo)
  end
end
function PaGlobal_CargoLoading_GetTooltipServantItem(index)
  local slot = PaGlobal_CargoLoading._slots[PaGlobal_CargoLoading._eSlotType.servant]
  if nil == slot[index] then
    return nil
  end
  return getServantInventoryItemBySlotNo(PaGlobal_CargoLoading._servantActorKey, slot[index].slotNo)
end
function PaGlobal_CargoLoadding_GetWareHouseItem(slotNo)
  if PaGlobal_CargoLoading._eMySlot.myInven == PaGlobal_CargoLoading._currentMySlotType then
    return getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
  elseif PaGlobal_CargoLoading._eMySlot.myWarehouse == PaGlobal_CargoLoading._currentMySlotType then
    local warehouseWrapper = PaGlobal_CargoLoading:getWarehouse()
    if nil == warehouseWrapper then
      return nil
    end
    return warehouseWrapper:getItem(slotNo)
  end
end
function PaGlobal_CargoLoading_requestPopToInventory(s64_count, slotNo)
  if PaGlobal_CargoLoading._eSlotType.inventory == PaGlobal_CargoLoading._clickedSlotType then
    if PaGlobal_CargoLoading._eMySlot.myInven == PaGlobal_CargoLoading._currentMySlotType then
      local selfPlayer = getSelfPlayer()
      local selfActorKeyRaw = selfPlayer:getActorKey()
      moveInventoryItemFromActorToActor(selfActorKeyRaw, PaGlobal_CargoLoading._servantActorKey, CppEnums.ItemWhereType.eInventory, slotNo, s64_count)
    elseif PaGlobal_CargoLoading._eMySlot.myWarehouse == PaGlobal_CargoLoading._currentMySlotType then
      warehouse_popToInventoryByWharf(slotNo, s64_count, PaGlobal_CargoLoading._servantActorKey)
    end
  elseif PaGlobal_CargoLoading._eSlotType.servant == PaGlobal_CargoLoading._clickedSlotType then
    if PaGlobal_CargoLoading._eMySlot.myInven == PaGlobal_CargoLoading._currentMySlotType then
      local selfPlayer = getSelfPlayer()
      local selfActorKeyRaw = selfPlayer:getActorKey()
      moveInventoryItemFromActorToActor(PaGlobal_CargoLoading._servantActorKey, selfActorKeyRaw, CppEnums.ItemWhereType.eServantInventory, slotNo, s64_count)
    elseif PaGlobal_CargoLoading._eMySlot.myWarehouse == PaGlobal_CargoLoading._currentMySlotType then
      warehouse_pushFromInventoryItemByWharf(CppEnums.ItemWhereType.eServantInventory, slotNo, s64_count, PaGlobal_CargoLoading._servantActorKey)
    end
  end
end
function PaGlobal_CargoLoading_ItemComparer(ii, jj)
  return Global_ItemComparer(ii, jj, PaGlobal_CargoLoadding_GetWareHouseItem)
end
function PaGlobal_CargoLoading_GetCurrentInventory()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return nil
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return nil
  end
  return selfPlayer:getInventoryByType(CppEnums.ItemWhereType.eInventory)
end
function PaGlobal_CargoLoading:resize()
  if nil == Panel_Window_CargoLoading_ALL then
    return
  end
  Panel_Window_CargoLoading_ALL:ComputePos()
end
function PaGlobal_CargoLoading:checkCurrentRegionWarehouse()
  self._currentWaypointKey = getCurrentWaypointKey()
  self._currentRegionName = getRegionNameByWaypointKey(self._currentWaypointKey)
  local warehouseWrapper = self:getWarehouse()
  if nil == warehouseWrapper then
    self._ui._rdo_myWarehouse:SetShow(false)
    self._ui._rdo_MyBag:SetCheck(true)
    local posX = self._rdoButtonsSizeX / 2 - self._ui._rdo_MyBag:GetSizeX() / 2
    self._ui._rdo_MyBag:SetPosX(posX)
  else
    self._ui._rdo_myWarehouse:SetShow(true)
    self._ui._rdo_MyBag:ComputePos()
  end
end
function PaGlobal_CargoLoading:repositionSelectLine()
  if self._eMySlot.myInven == self._currentMySlotType then
    self._ui._stc_selectLine:SetPosX(self._ui._rdo_MyBag:GetPosX())
  elseif self._eMySlot.myWarehouse == self._currentMySlotType then
    self._ui._stc_selectLine:SetPosX(self._ui._rdo_myWarehouse:GetPosX())
  end
end
function PaGlobal_CargoLoading:initSlotInfo_warehouse()
  self._startSlotIndex_warehouse = 0
  self._ui._scroll_warehouse:SetControlTop()
  self._ui._scroll_warehouse:SetControlPos(0)
end
function PaGlobal_CargoLoading:initSlotInfo_ship()
  self._startSlotIndex_ship = 0
  self._ui._scroll_ship:SetControlTop()
  self._ui._scroll_ship:SetControlPos(0)
end
function PaGlobal_CargoLoading:initTab()
  if true == self._isFirstSetting then
    return
  end
  self._ui._rdo_MyBag:SetCheck(false)
  self._ui._rdo_myWarehouse:SetCheck(true)
  self._isFirstSetting = true
end
function PaGlobal_CargoLoading:getSlotCols(_eSlotType)
  if self._eSlotType.inventory == _eSlotType then
    return self._config.slotCols_w
  elseif self._eSlotType.servant == _eSlotType then
    return self._config.slotCols_s
  end
end
