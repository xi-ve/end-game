function PaGlobal_WareHouse_All:initialize()
  if true == PaGlobal_WareHouse_All._initialize then
    return
  end
  PaGlobal_WareHouse_All:close()
  Panel_Window_Warehouse:setMaskingChild(true)
  Panel_Window_Warehouse:setGlassBackground(true)
  local stc_topBg = UI.getChildControl(Panel_Window_Warehouse, "Static_TopBg")
  local stc_rightBg = UI.getChildControl(Panel_Window_Warehouse, "Static_RightBg")
  local stc_leftBg = UI.getChildControl(Panel_Window_Warehouse, "Static_LeftBg")
  local stc_bottomBg = UI.getChildControl(Panel_Window_Warehouse, "Static_BottomBg")
  self._ui._stc_title = UI.getChildControl(stc_topBg, "StaticText_Icon_WareHouse")
  self._ui._stc_decoBg = UI.getChildControl(stc_topBg, "Static_DecoBg")
  self._ui._txt_villageName = UI.getChildControl(stc_topBg, "StaticText_VillageNameValue")
  self._ui._txt_villageName:SetShow(false)
  self._ui._pc._btn_close = UI.getChildControl(stc_topBg, "Button_Close_PCUI")
  self._ui._pc._btn_question = UI.getChildControl(stc_topBg, "Button_Question_PCUI")
  self._ui._pc._chk_itemSort = UI.getChildControl(stc_rightBg, "CheckButton_ItemSort_PCUI")
  self._ui._pc._btn_Search = UI.getChildControl(stc_rightBg, "Button_Search")
  self._ui._console._txt_Search = UI.getChildControl(stc_rightBg, "StaticText_KeyGuide_RSClick_ConsoleUI")
  self._ui._console._txt_keyGuideSort = UI.getChildControl(stc_rightBg, "StaticText_LSClick_ConsoleUI")
  self._ui._console._txt_keyGuideClose = UI.getChildControl(stc_bottomBg, "StaticText_B")
  self._ui._console._txt_keyGuideSelect = UI.getChildControl(stc_bottomBg, "StaticText_A")
  self._ui._console._txt_keyGuideSilver = UI.getChildControl(stc_bottomBg, "StaticText_Y")
  self._ui._console._txt_keyGuideManufacture = UI.getChildControl(stc_bottomBg, "Button_Manufacture")
  self._ui._stc_moneyBg = UI.getChildControl(stc_rightBg, "Static_MoneyBg")
  self._ui._txt_moneyTitle = UI.getChildControl(self._ui._stc_moneyBg, "StaticText_MoneyTitle")
  self._ui._txt_assetTitle = UI.getChildControl(self._ui._stc_moneyBg, "StaticText_AssetTitle")
  self._ui._txt_valueMoney = UI.getChildControl(self._ui._stc_moneyBg, "StaticText_Value_Money")
  self._ui._txt_valueAsset = UI.getChildControl(self._ui._stc_moneyBg, "StaticText_Value_Asset")
  self._ui._txt_capacity = UI.getChildControl(stc_rightBg, "StaticText_Capacity")
  self._ui._btn_money = UI.getChildControl(self._ui._stc_moneyBg, "Button_Money")
  self._ui._btn_asset = UI.getChildControl(self._ui._stc_moneyBg, "Button_Asset")
  self._ui._stc_itemSlotFrame = UI.getChildControl(stc_rightBg, "Static_ItemSlotFrame")
  self._ui._stc_itemSlotBg = UI.getChildControl(self._ui._stc_itemSlotFrame, "Static_ItemSlotBg_Template")
  self._ui._stc_lockIcon = UI.getChildControl(self._ui._stc_itemSlotFrame, "Static_ItemSlotBg_LockIcon")
  self._ui._stc_multipleSelect = UI.getChildControl(self._ui._stc_itemSlotFrame, "Static_MultipleSelect")
  self._ui._scroll_warehouse = UI.getChildControl(stc_rightBg, "Scroll_Warehouse")
  self._ui._btn_deliveryInfomation = UI.getChildControl(stc_rightBg, "Button_DeliveryInformation")
  self._ui._btn_itemMarketRegist = UI.getChildControl(stc_rightBg, "Button_ItemMarketRegist")
  self._ui._btn_manufacture = UI.getChildControl(stc_rightBg, "Button_Manufacture")
  self._ui._btn_guildUpdate = UI.getChildControl(stc_rightBg, "Button_GuildUpdate")
  self._ui._btn_guildLog = UI.getChildControl(stc_rightBg, "Button_GuildLog")
  self._ui._list2_serchWareHouse = UI.getChildControl(stc_leftBg, "List2_WareHouse")
  self._ui._txt_notAvaliable = UI.getChildControl(stc_leftBg, "StaticText_NotAvaliable")
  self._ui._stc_topBg = stc_topBg
  self._ui._stc_rightBg = stc_rightBg
  self._ui._stc_leftBg = stc_leftBg
  self._ui._stc_bottomBg = stc_bottomBg
  self._ui._list2_serchWareHouse:changeAnimationSpeed(10)
  self._ui._list2_serchWareHouse:setMinScrollBtnSize(float2(10, 50))
  self._ui._list2_serchWareHouse:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_Warehouse_All_UpdateSearchMenuList")
  self._ui._list2_serchWareHouse:createChildContent(__ePAUIList2ElementManagerType_List)
  PaGlobal_WareHouse_All:SetShowSearchMenuWareHouse(false)
  self._isConsole = _ContentsGroup_UsePadSnapping
  local isPc = false == self._isConsole
  for k, control in pairs(self._ui._pc) do
    control:SetShow(isPc)
  end
  self._ui._btn_deliveryInfomation:SetShow(isPc)
  self._ui._btn_itemMarketRegist:SetShow(isPc)
  self._ui._btn_manufacture:SetShow(isPc)
  self._ui._btn_guildUpdate:SetShow(isPc)
  self._ui._btn_guildLog:SetShow(isPc)
  for k, control in pairs(self._ui._console) do
    control:SetShow(self._isConsole)
  end
  self._ui._stc_bottomBg:SetShow(self._isConsole)
  if true == self._isConsole then
    local sizeY = self._ui._btn_itemMarketRegist:GetSizeY()
    Panel_Window_Warehouse:SetSize(Panel_Window_Warehouse:GetSizeX(), Panel_Window_Warehouse:GetSizeY() - sizeY)
    self._ui._stc_leftBg:SetSize(self._ui._stc_leftBg:GetSizeX(), self._ui._stc_leftBg:GetSizeY() - sizeY)
    self._ui._stc_bottomBg:ComputePos()
    self._ui._stc_itemSlotBg:ChangeOnTextureInfoName("renewal/frame/console_frame_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_itemSlotBg, 50, 195, 94, 239)
    self._ui._stc_itemSlotBg:getOnTexture():setUV(x1, y1, x2, y2)
  end
  self._keyGuide = {
    self._ui._console._txt_keyGuideManufacture,
    self._ui._console._txt_keyGuideSilver,
    self._ui._console._txt_keyGuideSelect,
    self._ui._console._txt_keyGuideClose
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuide, self._ui._stc_bottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  if true == _ContentsGroup_NewUI_WareHouse_Search_All then
    if true == self._isConsole then
      self._ui._pc._btn_Search:SetShow(false)
      self._ui._console._txt_Search:SetShow(true)
    else
      self._ui._pc._btn_Search:SetShow(true)
      self._ui._console._txt_Search:SetShow(false)
    end
  else
    self._ui._pc._btn_Search:SetShow(false)
    self._ui._console._txt_Search:SetShow(false)
  end
  self._defaultRightBgSize.x = self._ui._stc_rightBg:GetSizeX()
  self._defaultRightBgSize.y = self._ui._stc_rightBg:GetSizeY()
  self._defaultMoneyBgSize.x = self._ui._stc_moneyBg:GetSizeX()
  self._defaultMoneyBgSize.y = self._ui._stc_moneyBg:GetSizeY()
  self._btnMarketRegistSizeX = self._ui._btn_itemMarketRegist:GetSizeX()
  self._btnMarketRegSpanSizeY = self._ui._btn_itemMarketRegist:GetSpanSize().y
  self._panelSizeY = Panel_Window_Warehouse:GetSizeY()
  self._assetTitlePosY = self._ui._txt_assetTitle:GetPosY()
  self._assetValuePosY = self._ui._txt_valueAsset:GetPosY()
  self._staticCapacityPosY = self._ui._txt_capacity:GetPosY()
  self._moneyValuePosY = self._ui._txt_valueMoney:GetPosY()
  self._config.slotRows = math.floor(self._config.slotCount / self._config.slotCols)
  self._ui._btn_itemMarketRegist:SetShow(false)
  if _ContentsGroup_RenewUI_ItemMarketPlace_Only then
    self._ui._btn_itemMarketRegist:addInputEvent("Mouse_LUp", "PaGlobalFunc_MarketWallet_Open(" .. CppEnums.ItemWhereType.eWarehouse .. ")")
  else
    self._ui._btn_itemMarketRegist:addInputEvent("Mouse_LUp", "HandleEventLUp_Warehouse_All_MarketRegistOpen()")
  end
  self._ui._scroll_warehouse:SetShow(true)
  self._ui._btn_manufacture:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WAREHOUSE_BTNTEXT_1"))
  self._ui._btn_itemMarketRegist:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WAREHOUSE_BTNTEXT_2"))
  self._ui._pc._chk_itemSort:SetText(self._ui._pc._chk_itemSort:GetText())
  self._ui._pc._chk_itemSort:SetEnableArea(0, 0, self._ui._pc._chk_itemSort:GetTextSizeX() + 30, 25)
  self._isSorted = ToClient_IsSortedWarehouse()
  self._ui._pc._chk_itemSort:SetCheck(self._isSorted)
  self:updateSortText_console()
  if true == _ContentsGroup_NewDelivery then
    self:update()
  end
  self._memoryPanelSizeX = 1010
  self:createSlot()
  PaGlobal_WareHouse_All:registEventHandler()
  PaGlobal_WareHouse_All:validate()
  if false == _ContentsGroup_NewUI_WareHouse_Search_All then
    self._ui._txt_capacity:SetSpanSize(15, 18)
  end
  PaGlobal_WareHouse_All._initialize = true
end
function PaGlobal_WareHouse_All:registEventHandler()
  if nil == Panel_Window_Warehouse then
    return
  end
  Panel_Window_Warehouse:RegisterShowEventFunc(true, "PaGloabl_WareHouse_All_ShowAni()")
  Panel_Window_Warehouse:RegisterShowEventFunc(false, "PaGloabl_WareHouse_All_HideAni()")
  self._ui._btn_manufacture:addInputEvent("Mouse_LUp", "HandleEventLUp_Warehouse_All_ManufactureOpen()")
  self._ui._btn_guildUpdate:addInputEvent("Mouse_LUp", "HandleEventLUp_Warehouse_All_GuildWareHouseUpdate()")
  self._ui._btn_guildLog:addInputEvent("Mouse_LUp", "HandleEventLUp_Warehouse_All_GuildWareHouseHistory()")
  UIScroll.InputEvent(self._ui._scroll_warehouse, "HandleEvent_Warehouse_All_Scroll")
  UIScroll.InputEventByControl(Panel_Window_Warehouse, "HandleEvent_Warehouse_All_Scroll")
  self._ui._pc._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Warehouse_All_Close()")
  self._ui._btn_money:addInputEvent("Mouse_LUp", "HandleEventLUp_Warehouse_All_PopMoney()")
  if true == _ContentsGroup_NewUI_WareHouse_Search_All then
    if true == self._isConsole then
      Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_RSClick, "HandleEevnt_WareHouse_All_Search()")
    else
      self._ui._pc._btn_Search:addInputEvent("Mouse_LUp", "HandleEevnt_WareHouse_All_Search()")
    end
  end
  self._ui._pc._btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"WareHouse\" )")
  PaGlobal_Util_RegistHelpTooltipEvent(self._ui._pc._btn_question, "\"WareHouse\"")
  self._ui._btn_deliveryInfomation:addInputEvent("Mouse_LUp", "HandleEventLUp_WareHouse_All_OpenDelivery()")
  self._ui._pc._chk_itemSort:addInputEvent("Mouse_LUp", "HandleEventLUp_WareHouse_All_CheckSort()")
  Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_LSClick, "HandleEventLUp_WareHouse_All_CheckSort()")
  registerEvent("FromClient_WarehouseOpenByInstallation", "FromClient_Warehouse_All_OpenByInstallation")
  registerEvent("EventWarehouseUpdate", "FromClient_Warehouse_All_Update")
  registerEvent("FromClient_WarehouseClose", "FromClient_Warehouse_All_Close")
  registerEvent("EventGuildWarehouseUpdate", "FromClient_Warehouse_All_GuildUpdate")
  registerEvent("FromClient_FurnitureWarehouseUpdate", "FromClient_Warehouse_All_FurnitureUpdate")
  registerEvent("FromClient_UpdateInventoryBag", "PaGlobal_Warehouse_All_UpdateInventoryBag")
  registerEvent("FromClient_InventoryUpdate", "PaGlobal_Warehouse_All_UpdateInventory")
  registerEvent("FromClient_WarehouseUpdate", "FromClient_Warehouse_All_Update")
  registerEvent("EventWarehouseUpdate", "PaGlobal_Warehouse_All_UpdateSearchMenuWarehouse")
end
function PaGlobal_WareHouse_All:prepareOpen()
  if nil == Panel_Window_Warehouse then
    return
  end
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  PaGlobal_WareHouse_All:open()
end
function PaGlobal_WareHouse_All:open()
  if nil == Panel_Window_Warehouse then
    return
  end
  Panel_Window_Warehouse:SetShow(true, true)
end
function PaGlobal_WareHouse_All:prepareClose()
  if nil == Panel_Window_Warehouse then
    return
  end
  if false == Panel_Window_Warehouse:GetShow() then
    return
  end
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  if true == _ContentsGroup_RenewUI_Delivery then
    if true == PaGlobalFunc_PanelDelivery_GetShow() then
      DeliveryRequestWindow_Close()
    end
  elseif true == _ContentsGroup_NewUI_Delivery_All then
    if Panel_Window_Delivery_All:GetShow() then
      PaGlobal_Delivery_All:prepareClose()
    end
  else
    if Panel_Window_Delivery_Information:GetShow() then
      DeliveryInformationWindow_Close()
    end
    if Panel_Window_Delivery_Request:GetShow() then
      DeliveryRequestWindow_Close()
    end
  end
  local isInvenOpen = false
  if true == _ContentsGroup_NewUI_Inventory_All then
    isInvenOpen = Panel_Window_Inventory_All:GetShow()
  else
    isInvenOpen = Panel_Window_Inventory:GetShow()
  end
  if true == isInvenOpen then
    if CppEnums.WarehoouseFromType.eWarehoouseFromType_Installation ~= PaGlobal_WareHouse_All._fromType and CppEnums.WarehoouseFromType.eWarehoouseFromType_Maid ~= PaGlobal_WareHouse_All._fromType then
      InventoryWindow_Close()
    else
      Inventory_SetFunctor(nil, nil, nil, nil)
    end
  end
  if true == _ContentsGroup_isAllWarehouse then
    PaGlobal_WareHouse_All:searchMenuClose()
  end
  PaGlobal_WareHouse_All._fromType = CppEnums.WarehoouseFromType.eWarehoouseFromType_Worldmap
  if nil ~= PaGlobal_WareHouse_All.itemMarketFilterFunc then
    PaGlobal_WareHouse_All.itemMarketFilterFunc = nil
    PaGlobal_WareHouse_All.itemMarketRclickFunc = nil
  end
  if nil ~= PaGlobal_WareHouse_All.manufactureRclickFunc then
    PaGlobal_WareHouse_All.manufactureFilterFunc = nil
    PaGlobal_WareHouse_All.manufactureRclickFunc = nil
  end
  if ToClient_WorldMapIsShow() then
    WorldMapPopupManager:pop()
  else
    PaGlobal_WareHouse_All:close()
  end
  Panel_Window_Warehouse:ChangeSpecialTextureInfoName("")
  local isManufactureOpen = false
  if true == _ContentsGroup_NewUI_Manufacture_All then
    if nil ~= Panel_Window_Manufacture_All then
      isManufactureOpen = Panel_Window_Manufacture_All:GetShow()
    end
  elseif self._isConsole then
    if nil ~= Panel_Window_Manufacture then
      isManufactureOpen = Panel_Window_Manufacture:GetShow()
    end
  elseif nil ~= Panel_Manufacture then
    isManufactureOpen = Panel_Manufacture:GetShow()
  end
  if nil ~= Panel_Window_MarketPlace_MyInventory and false == Panel_Window_MarketPlace_MyInventory:GetShow() and false == isManufactureOpen then
    PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  end
  if true == isManufactureOpen and self._isConsole then
    PaGlobalFunc_InterestKnowledge_All_Close()
  end
  if ToClient_CheckExistSummonMaid() then
    ToClient_CallHandlerMaid("_maidLogOut")
  end
  TooltipSimple_Hide()
end
function PaGlobal_WareHouse_All:close()
  if nil == Panel_Window_Warehouse then
    return
  end
  if nil ~= Panel_Window_WareHouse_Search and true == Panel_Window_WareHouse_Search:GetShow() then
    PaGlobal_Warehouse_Search_All_Close()
  end
  Panel_Window_Warehouse:SetShow(false, false)
end
function PaGlobal_WareHouse_All:update()
  if nil == Panel_Window_Warehouse then
    return
  end
  local warehouseWrapper = self:getWarehouse()
  if nil == warehouseWrapper then
    return
  end
  local addSizeY = 0
  if self:isNpc() then
    addSizeY = self.addSizeY
  end
  local useStartSlot = 1
  local itemCount = warehouseWrapper:getSize()
  local useMaxCount = warehouseWrapper:getUseMaxCount()
  local freeCount = warehouseWrapper:getFreeCount()
  local money_s64 = warehouseWrapper:getMoney_s64()
  local maxCount = warehouseWrapper:getMaxCount()
  if itemCount < useMaxCount - useStartSlot then
    self._ui._txt_capacity:SetFontColor(Defines.Color.C_FFDDC39E)
  else
    self._ui._txt_capacity:SetFontColor(Defines.Color.C_FFD05D48)
  end
  if itemCount > useMaxCount - useStartSlot then
    self._ui._txt_capacity:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "Lua_WareHouse_OverCapacity", "HaveCount", tostring(itemCount), "FullCount", tostring(useMaxCount - useStartSlot)))
  else
    self._ui._txt_capacity:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "Lua_WareHouse_Capacity", "HaveCount", tostring(itemCount), "FullCount", tostring(useMaxCount - useStartSlot)))
  end
  self._ui._txt_valueMoney:SetText(makeDotMoney(money_s64))
  local slotNoList = Array.new()
  slotNoList:fill(useStartSlot, maxCount - 1)
  if self._isSorted then
    local sortList = Array.new()
    sortList:fill(useStartSlot, useMaxCount - 1)
    sortList:quicksort(PaGlobal_Warehouse_All_ItemComparer)
    for ii = 1, useMaxCount - 1 do
      slotNoList[ii] = sortList[ii]
    end
  end
  self:updateInitSlot(useMaxCount, maxCount, useStartSlot)
  self:updateAssetManagement(slotNoList, useMaxCount, money_s64)
  self:updateSlot(slotNoList)
  if true == self:isGuildHouse() or true == self:isFurnitureWareHouse() then
    self._ui._txt_moneyTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ITEMMARKET_ICON_MONEY3"))
    self._ui._txt_assetTitle:SetShow(false)
    self._ui._txt_valueAsset:SetShow(false)
    self._ui._btn_asset:SetShow(false)
  else
    self._ui._txt_moneyTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ITEMMARKET_ICON_MONEY2"))
    self._ui._txt_assetTitle:SetShow(true)
    self._ui._txt_valueAsset:SetShow(true)
    self._ui._btn_asset:SetShow(true)
  end
  Panel_Tooltip_Item_hideTooltip()
  self:resizePanelChange(self:isNpc())
end
function PaGlobal_WareHouse_All:createSlot()
  local maxRowsIdx = self._config.slotRows - 1
  for ii = 0, self._config.slotCount - 1 do
    local blankSlot
    if nil == self._blankSlots[ii] then
      local slotNo = ii + 1
      local slot = {}
      slot.empty = UI.createAndCopyBasePropertyControl(self._ui._stc_itemSlotFrame, "Static_ItemSlotBg_Template", self._ui._stc_itemSlotFrame, "Warehouse_Slot_Base_" .. ii)
      UIScroll.InputEventByControl(slot.empty, "HandleEvent_Warehouse_All_Scroll")
      local row = math.floor(ii / self._config.slotCols)
      local column = ii % self._config.slotCols
      slot.empty:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
      slot.empty:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
      if true == _ContentsGroup_RenewUI_Tooltip then
        slot.empty:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventRUp_Warehouse_All_ShowDetailTooltip(" .. ii .. ", true)")
      end
      if true == self._isConsole then
        if 0 == row then
          slot.empty:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "HandleEvent_Warehouse_All_Scroll(true)")
        elseif maxRowsIdx == row then
          slot.empty:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "HandleEvent_Warehouse_All_Scroll(false)")
        end
      end
      self._blankSlots[ii] = slot
    end
    blankSlot = self._blankSlots[ii]
    if nil == self._slots[ii] then
      local slot = {}
      SlotItem.new(slot, "ItemIcon_" .. ii, ii, self._ui._stc_itemSlotFrame, self._slotConfig)
      slot:createChild()
      local row = math.floor(ii / self._config.slotCols)
      local column = ii % self._config.slotCols
      slot.icon:SetPosX(self._config.slotStartX + self._config.slotGapX * column + 1)
      slot.icon:SetPosY(self._config.slotStartY + self._config.slotGapY * row + 1)
      slot.icon:SetEnableDragAndDrop(true)
      slot.icon:SetAutoDisableTime(0.5)
      if true == self._isConsole then
        slot.icon:addInputEvent("Mouse_LUp", "HandleEventRUp_Warehouse_All_Item(" .. ii .. ")")
      else
        slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Warehouse_All_Item(" .. ii .. ")")
        slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Warehouse_All_DropHandler(" .. ii .. ")")
      end
      slot.icon:addInputEvent("Mouse_PressMove", "HandleEventPMove_Warehouse_All_SlotDrag(" .. ii .. ")")
      slot.icon:addInputEvent("Mouse_On", "HandleEventMOn_Warehouse_All_IconOver(" .. ii .. ")")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventMOut_Warehouse_All_IconOut(" .. ii .. ")")
      UIScroll.InputEventByControl(slot.icon, "HandleEvent_Warehouse_All_Scroll")
      Panel_Tooltip_Item_SetPosition(ii, slot, "WareHouse")
      self._slots[ii] = slot
    end
    if nil ~= blankSlot then
      blankSlot.lock = UI.createAndCopyBasePropertyControl(self._ui._stc_itemSlotFrame, "Static_ItemSlotBg_LockIcon", self._ui._stc_itemSlotFrame, "Warehouse_Slot_Lock_" .. ii)
      blankSlot.plus = UI.createAndCopyBasePropertyControl(self._ui._stc_itemSlotFrame, "Static_MultipleSelect", self._ui._stc_itemSlotFrame, "Warehouse_Slot_Plus_" .. ii)
      blankSlot.onlyPlus = UI.createAndCopyBasePropertyControl(self._ui._stc_itemSlotFrame, "Static_ItemSlotBg_Plus", self._ui._stc_itemSlotFrame, "Warehouse_Slot_OnlyPlus_" .. ii)
      local row = math.floor(ii / self._config.slotCols)
      local column = ii % self._config.slotCols
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
function PaGlobal_WareHouse_All:updateInitSlot(useMaxCount, maxCount, useStartSlot)
  for ii = 0, self._config.slotCount - 1 do
    local slot = self._blankSlots[ii]
    self._slots[ii].icon:SetShow(true)
    slot.empty:SetShow(true)
    slot.lock:SetShow(false)
    slot.plus:SetShow(false)
    slot.onlyPlus:SetShow(false)
    if ii < useMaxCount - useStartSlot - self._startSlotIndex then
      slot.empty:SetShow(true)
    elseif ii == useMaxCount - useStartSlot - self._startSlotIndex and ii < maxCount - useStartSlot - self._startSlotIndex then
      if self._slots[ii].icon:GetShow() then
        local isBuyalbe = false
        if self:isNpc() then
          for wIndex = 0, #self._warehouseProductWaypoint do
            if PaGlobal_Warehouse_All_CurrentWaypointKey() == self._warehouseProductWaypoint[wIndex] then
              isBuyalbe = true
              break
            end
          end
        end
        if isBuyalbe and false == self._isConsole and _ContentsGroup_EasyBuy then
          slot.onlyPlus:SetShow(true)
          slot.onlyPlus:addInputEvent("Mouse_LUp", "HandleEventLUp_Warehouse_All_LDownClick(" .. ii .. ")")
        else
          slot.lock:SetShow(true)
        end
      else
        slot.plus:SetShow(true)
      end
      Panel_Window_Warehouse:SetChildIndex(slot.plus, 15099)
      Panel_Window_Warehouse:SetChildIndex(slot.onlyPlus, 15100)
    elseif ii >= maxCount - useStartSlot - self._startSlotIndex then
      self._slots[ii].icon:SetShow(false)
      slot.empty:SetShow(false)
    else
      slot.lock:SetShow(true)
    end
  end
  UIScroll.SetButtonSize(self._ui._scroll_warehouse, self._config.slotCount, maxCount - useStartSlot)
  for ii = 0, self._config.slotCount - 1 do
    local slot = self._slots[ii]
    slot:clearItem()
    slot.icon:SetEnable(true)
    if false == _ContentsGroup_NewDelivery then
      slot.icon:SetMonoTone(true)
    end
  end
end
function PaGlobal_WareHouse_All:updateAssetManagement(slotNoList, useMaxCount, money_s64)
  if true == self:isGuildHouse() then
    return
  end
  local warehouseWrapper = self:getWarehouse()
  if nil == warehouseWrapper then
    return
  end
  self._myAsset = toInt64(0, 0)
  if 2 <= useMaxCount then
    for ii = 0, useMaxCount - 2 do
      local slotNo = slotNoList[1 + ii + 0]
      local itemWrapper = warehouseWrapper:getItem(slotNo)
      if nil ~= itemWrapper then
        local itemSSW = itemWrapper:getStaticStatus()
        local itemEnchantKey = itemSSW:get()._key:get()
        local itemCount_s64 = itemWrapper:get():getCount_s64()
        local npcSellPrice_s64 = itemSSW:get()._sellPriceToNpc_s64
        if true == _ContentsGroup_RenewUI_ItemMarketPlace_Only then
          local marketPriceByWarehouse = ToClient_getWorldMarketPriceToWareHouse(itemEnchantKey)
          if marketPriceByWarehouse > toInt64(0, 0) then
            self._myAsset = self._myAsset + marketPriceByWarehouse * itemCount_s64
          else
            self._myAsset = self._myAsset + npcSellPrice_s64 * itemCount_s64
          end
        else
          local tradeInfo
          local tradeSummaryInfo = getItemMarketSummaryInClientByItemEnchantKey(itemEnchantKey)
          local tradeMasterInfo = getItemMarketMasterByItemEnchantKey(itemEnchantKey)
          if nil ~= tradeSummaryInfo then
            tradeInfo = tradeSummaryInfo
          elseif nil ~= tradeMasterInfo then
            tradeInfo = tradeMasterInfo
          else
            tradeInfo = nil
          end
          if nil ~= tradeInfo then
            if nil ~= tradeSummaryInfo and toInt64(0, 0) ~= tradeSummaryInfo:getDisplayedTotalAmount() then
              self._myAsset = self._myAsset + (tradeInfo:getDisplayedLowestOnePrice() + tradeInfo:getDisplayedHighestOnePrice()) / toInt64(0, 2) * itemCount_s64
            else
              self._myAsset = self._myAsset + (tradeMasterInfo:getMinPrice() + tradeMasterInfo:getMaxPrice()) / toInt64(0, 2) * itemCount_s64
            end
          else
            self._myAsset = self._myAsset + npcSellPrice_s64 * itemCount_s64
          end
        end
      end
    end
  end
  self._ui._txt_assetTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WAREHOUSE_ASSETS"))
  self._ui._txt_valueAsset:SetText(makeDotMoney(self._myAsset + money_s64))
end
function PaGlobal_WareHouse_All:updateSlot(slotNoList)
  local warehouseWrapper = self:getWarehouse()
  if nil == warehouseWrapper then
    return
  end
  self._maxFindItemCnt = 0
  self._findItemIdx = {}
  for ii = 0, self._config.slotCount - 1 do
    local slot = self._slots[ii]
    local slotNo = slotNoList[1 + ii + self._startSlotIndex]
    slot.slotNo = slotNo
    slot.icon:EraseAllEffect()
    local row = math.floor(ii / self._config.slotCols)
    local column = ii % self._config.slotCols
    slot.icon:SetPosX(self._config.slotStartX + self._config.slotGapX * column + 1)
    slot.icon:SetPosY(self._config.slotStartY + self._config.slotGapY * row + 1)
    slot.icon:SetMonoTone(false)
    slot.count:SetShow(false)
    local itemExist = false
    if nil == slotNo then
      slot:clearItem()
      slot.icon:SetEnableDragAndDrop(false)
    else
      local itemWrapper = warehouseWrapper:getItem(slotNo)
      if nil ~= itemWrapper then
        slot:setItem(itemWrapper, slotNo, nil, warehouseWrapper)
        if true == _ContentsGroup_NewUI_WareHouse_Search_All then
          local itemName = itemWrapper:getStaticStatus():getName()
          local searchStr = PaGlobal_WareHouse_Search_All_GetSearchString()
          if nil ~= searchStr and stringSearch(itemName, searchStr) then
            slot.icon:AddEffect("fUI_SearchItem_01A", true, 0, 0)
            self._maxFindItemCnt = self._maxFindItemCnt + 1
            self._findItemIdx[self._maxFindItemCnt] = ii
          end
        end
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
          end
        end
        if nil ~= self.itemMarketFilterFunc then
          if false == self.itemMarketFilterFunc(slot.icon, itemWrapper) then
            if self._slotFilterEffect[ii] then
              slot.icon:EraseEffect(self._slotFilterEffect[ii])
              self._slotFilterEffect[ii] = nil
            end
            self._slotFilterEffect[ii] = slot.icon:AddEffect("UI_Inventory_Filtering", true, 0, 0)
            slot.icon:SetMonoTone(false)
            slot.icon:SetEnable(true)
            slot.icon:SetIgnore(false)
          else
            if self._slotFilterEffect[ii] then
              slot.icon:EraseEffect(self._slotFilterEffect[ii])
              self._slotFilterEffect[ii] = nil
            end
            slot.icon:SetMonoTone(true)
            slot.icon:SetEnable(false)
            slot.icon:SetIgnore(true)
          end
        elseif nil ~= self.manufactureFilterFunc then
          if false == self.manufactureFilterFunc(slot.slotNo, itemWrapper) then
            if self._slotFilterEffect[ii] then
              slot.icon:EraseEffect(self._slotFilterEffect[ii])
              self._slotFilterEffect[ii] = nil
            end
            self._slotFilterEffect[ii] = slot.icon:AddEffect("UI_Inventory_Filtering", true, 0, 0)
            slot.icon:SetMonoTone(false)
            slot.icon:SetEnable(true)
            slot.icon:SetIgnore(false)
          else
            if self._slotFilterEffect[ii] then
              slot.icon:EraseEffect(self._slotFilterEffect[ii])
              self._slotFilterEffect[ii] = nil
            end
            slot.icon:SetMonoTone(true)
            slot.icon:SetEnable(false)
            slot.icon:SetIgnore(true)
          end
        else
          if self._slotFilterEffect[ii] then
            slot.icon:EraseEffect(self._slotFilterEffect[ii])
            self._slotFilterEffect[ii] = nil
          end
          if true == _ContentsGroup_NewDelivery then
            if true == itemCountZero then
              slot.icon:SetMonoTone(true)
              slot.count:SetText("")
            else
              slot.icon:SetMonoTone(false)
            end
            slot.icon:SetEnable(true)
            slot.icon:SetIgnore(false)
          else
            slot.icon:SetMonoTone(false)
            slot.icon:SetEnable(true)
            slot.icon:SetIgnore(false)
          end
        end
        if nil == self.itemMarketFilterFunc then
          local packingCount_s64 = 0
          if true == _ContentsGroup_NewDelivery then
            packingCount_s64 = ToClient_NewDeliveryGetPackItemCountBySlotNo(slotNo)
          else
            packingCount_s64 = delivery_getPackItemCount(slotNo)
          end
          if Defines.s64_const.s64_0 == itemWrapper:get():getCount_s64() then
            slot.icon:SetMonoTone(true)
          else
            slot.count:SetShow(true)
          end
        end
        itemExist = true
        slot.checkBox:SetShow(false)
      else
        if nil ~= self._slotFilterEffect[ii] then
          slot.icon:EraseEffect(self._slotFilterEffect[ii])
          self._slotFilterEffect[ii] = nil
        end
        slot.icon:SetMonoTone(false)
        slot.icon:SetEnable(true)
        slot.icon:SetIgnore(false)
      end
    end
    if not itemExist then
      slot:clearItem()
      slot.icon:SetEnable(true)
      slot.icon:SetMonoTone(true)
      slot.icon:SetIgnore(false)
    end
    slot.icon:SetEnableDragAndDrop(self:isNpc() or self:isMaid())
  end
end
function PaGlobal_WareHouse_All:validate()
  if nil == Panel_Window_Warehouse then
    return
  end
  self._ui._pc._btn_close:isValidate()
  self._ui._pc._btn_question:isValidate()
  self._ui._pc._chk_itemSort:isValidate()
  self._ui._console._txt_keyGuideSort:isValidate()
  self._ui._console._txt_keyGuideClose:isValidate()
  self._ui._console._txt_keyGuideSelect:isValidate()
  self._ui._console._txt_keyGuideSilver:isValidate()
  self._ui._stc_decoBg:isValidate()
  self._ui._txt_villageName:isValidate()
  self._ui._txt_valueMoney:isValidate()
  self._ui._txt_valueAsset:isValidate()
  self._ui._txt_capacity:isValidate()
  self._ui._stc_itemSlotFrame:isValidate()
  self._ui._stc_itemSlotBg:isValidate()
  self._ui._stc_lockIcon:isValidate()
  self._ui._stc_multipleSelect:isValidate()
  self._ui._scroll_warehouse:isValidate()
  self._ui._btn_deliveryInfomation:isValidate()
  self._ui._btn_itemMarketRegist:isValidate()
  self._ui._btn_manufacture:isValidate()
  self._ui._txt_notAvaliable:isValidate()
  self._ui._list2_serchWareHouse:isValidate()
  self._ui._stc_topBg:isValidate()
  self._ui._stc_rightBg:isValidate()
  self._ui._stc_leftBg:isValidate()
  self._ui._stc_bottomBg:isValidate()
end
function PaGlobal_WareHouse_All:isNpc()
  return CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc == self._fromType
end
function PaGlobal_WareHouse_All:isInstallation()
  return CppEnums.WarehoouseFromType.eWarehoouseFromType_Installation == self._fromType
end
function PaGlobal_WareHouse_All:isWorldMapNode()
  return CppEnums.WarehoouseFromType.eWarehoouseFromType_Worldmap == self._fromType
end
function PaGlobal_WareHouse_All:isGuildHouse()
  return CppEnums.WarehoouseFromType.eWarehoouseFromType_GuildHouse == self._fromType
end
function PaGlobal_WareHouse_All:isMaid()
  return CppEnums.WarehoouseFromType.eWarehoouseFromType_Maid == self._fromType
end
function PaGlobal_WareHouse_All:isManufacture()
  return CppEnums.WarehoouseFromType.eWarehoouseFromType_Manufacture == self._fromType
end
function PaGlobal_WareHouse_All:isFurnitureWareHouse()
  if true == _ContentsGroup_isFurnitureWarehouse then
    return CppEnums.WarehoouseFromType.eWarehoouseFromType_Furniture == self._fromType
  else
    return false
  end
end
function PaGlobal_WareHouse_All:isDeliveryWindow()
  if true == _ContentsGroup_NewUI_Delivery_All then
    return PaGlobalFunc_PanelDelivery_GetShow()
  elseif true == self._isConsole then
    return Panel_Window_Delivery_Renew:GetShow()
  else
    return (Panel_Window_Delivery_Request:GetShow())
  end
end
function PaGlobal_WareHouse_All:getWarehouse()
  local warehouseWrapper
  if PaGlobal_WareHouse_All:isGuildHouse() then
    warehouseWrapper = warehouse_getGuild()
    if true == _ContentsGroup_NewUI_WareHouse_Search_All then
      PaGlobal_WareHouse_Search_All_OpenGuildWareHouse()
    end
  elseif PaGlobal_WareHouse_All:isFurnitureWareHouse() then
    warehouseWrapper = ToClient_getFurniturewarehouse()
  elseif 0 ~= self._currentWaypointKey then
    warehouseWrapper = warehouse_get(self._currentWaypointKey)
  end
  return warehouseWrapper
end
function PaGlobal_WareHouse_All:resizePanelChange(isNpc)
  local bigSizeY
  if isNpc then
    bigSizeY = self.addSizeY
    self._ui._txt_moneyTitle:SetShow(true)
  else
    bigSizeY = 0
    self._ui._txt_capacity:SetPosY(self._staticCapacityPosY + bigSizeY)
  end
  if not self:isGuildHouse() then
    Panel_Window_Warehouse:SetSize(Panel_Window_Warehouse:GetSizeX(), self._panelSizeY + bigSizeY)
    self._ui._stc_rightBg:SetSize(self._defaultRightBgSize.x, self._defaultRightBgSize.y)
    self._ui._stc_moneyBg:SetSize(self._defaultMoneyBgSize.x, self._defaultMoneyBgSize.y)
  else
    local moneybgSizeY = self._defaultMoneyBgSize.y * 0.6
    local halfSizeY = self._defaultMoneyBgSize.y - moneybgSizeY
    Panel_Window_Warehouse:SetSize(Panel_Window_Warehouse:GetSizeX(), self._panelSizeY - bigSizeY - halfSizeY)
    self._ui._stc_rightBg:SetSize(self._defaultRightBgSize.x, self._defaultRightBgSize.y - halfSizeY)
    self._ui._stc_moneyBg:SetSize(self._defaultMoneyBgSize.x, moneybgSizeY)
  end
  self._ui._stc_leftBg:ComputePos()
  self._ui._stc_bottomBg:ComputePos()
  self._ui._txt_assetTitle:SetPosY(self._assetTitlePosY + bigSizeY)
  self._ui._txt_valueAsset:SetPosY(self._assetValuePosY + bigSizeY)
  self._ui._txt_valueMoney:SetPosY(self._moneyValuePosY + bigSizeY)
  if false == self._isConsole and CppEnums.WarehoouseFromType.eWarehoouseFromType_Manufacture == self._fromType then
    Panel_Window_Warehouse:SetSize(Panel_Window_Warehouse:GetSizeX(), Panel_Window_Warehouse:GetSizeY() - self._ui._btn_itemMarketRegist:GetSizeY() - 5)
  end
  self._ui._btn_deliveryInfomation:ComputePos()
  self._ui._btn_itemMarketRegist:ComputePos()
  self._ui._btn_manufacture:ComputePos()
  self._ui._btn_guildUpdate:ComputePos()
  self._ui._btn_guildLog:ComputePos()
end
function PaGlobal_WareHouse_All:pushFromInventoryItem(s64_count, slotNo, whereType)
  if PaGlobal_WareHouse_All:isNpc() then
    warehouse_requestInfo(getCurrentWaypointKey())
    warehouse_pushFromInventoryItemByNpc(whereType, slotNo, s64_count, PaGlobal_WareHouse_All._targetActorKeyRaw)
  elseif PaGlobal_WareHouse_All:isInstallation() then
    warehouse_pushFromInventoryItemByInstallation(PaGlobal_WareHouse_All._installationActorKeyRaw, whereType, slotNo, s64_count, PaGlobal_WareHouse_All._targetActorKeyRaw)
  elseif PaGlobal_WareHouse_All:isGuildHouse() then
    warehouse_pushFromInventoryItemByGuildHouse(whereType, slotNo, s64_count, PaGlobal_WareHouse_All._targetActorKeyRaw)
  elseif PaGlobal_WareHouse_All:isFurnitureWareHouse() then
    ToClient_pushFromInventoryItemByFurnitureWarehouse(whereType, slotNo)
  elseif PaGlobal_WareHouse_All:isMaid() then
    local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
    if nil == regionInfo then
      return
    end
    local warehouseInMaid = checkMaid_WarehouseIn(true)
    if warehouseInMaid then
      warehouse_pushFromInventoryItemByMaid(whereType, slotNo, s64_count, PaGlobal_WareHouse_All._targetActorKeyRaw)
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_COOLTIME"))
    end
  end
end
function PaGlobal_WareHouse_All:popToSomewhere(s64_count, slotNo)
  if nil == slotNo then
    return
  end
  local invenIsShow = false
  if true == _ContentsGroup_RenewUI_InventoryEquip then
    invenIsShow = PaGlobalFunc_InventoryInfo_GetShow()
  elseif true == _ContentsGroup_NewUI_Inventory_All then
    invenIsShow = Panel_Window_Inventory_All:GetShow()
  else
    invenIsShow = Panel_Window_Inventory:GetShow()
  end
  if invenIsShow and GetUIMode() ~= Defines.UIMode.eUIMode_WorldMap then
    if self:isNpc() then
      warehouse_requestInfo(getCurrentWaypointKey())
      warehouse_popToInventoryByNpc(slotNo, s64_count, self._targetActorKeyRaw)
    elseif self:isInstallation() then
      warehouse_popToInventoryByInstallation(self._installationActorKeyRaw, slotNo, s64_count, self._targetActorKeyRaw)
    elseif self:isGuildHouse() then
      warehouse_popToInventoryByGuildHouse(slotNo, s64_count, self._targetActorKeyRaw)
    elseif self:isFurnitureWareHouse() then
      ToClient_popToInventoryByFurnitureWarehouse(slotNo)
    elseif self:isMaid() then
      local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
      if nil == regionInfo then
        return
      end
      local warehouseOutMaid = checkMaid_WarehouseOut(true)
      if warehouseOutMaid then
        warehouse_requestInfo(self._currentWaypointKey)
        warehouse_popToInventoryByMaid(slotNo, s64_count, self._targetActorKeyRaw)
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_COOLTIME"))
      end
    end
  elseif true == self:isDeliveryWindow() then
    DeliveryRequest_PushPackingItem(slotNo, s64_count)
  end
end
function PaGlobal_WareHouse_All:openPanelFromDialog()
  warehouse_clearSellToSystem()
  if true == _ContentsGroup_RenewUI_ItemMarketPlace_Only and PaGlobalFunc_MarketWallet_GetShow() then
    PaGlobalFunc_MarketWallet_ForceClose()
  end
  if true == _ContentsGroup_isAllWarehouse then
    PaGlobal_WareHouse_All:searchMenuOpen()
  end
  self:openPanel(getCurrentWaypointKey(), CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc)
  PaGlobal_Warehouse_All_SetIgnoreMoneyButton(false)
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local dialogSizeY = 0
  if true == _ContentsGroup_NewUI_Dialog_All then
    dialogSizeY = Panel_Npc_Dialog_All:GetSizeY()
  else
    dialogSizeY = Panel_Npc_Dialog:GetSizeY()
  end
  if not ToClient_WorldMapIsShow() then
    if true == self._isConsole then
      Panel_Window_Warehouse:SetVerticalTop()
      Panel_Window_Warehouse:SetHorizonRight()
      local basePosY = (screenSizeY - dialogSizeY) * 0.5 - Panel_Window_Warehouse:GetSizeY() * 0.5
      Panel_Window_Warehouse:SetSpanSize(self._invenSizeX, basePosY)
    else
      Panel_Window_Warehouse:SetVerticalMiddle()
      Panel_Window_Warehouse:SetHorizonRight()
      local basePosY = screenSizeY * 0.5 - Panel_Window_Warehouse:GetSizeY() * 0.5
      local posY = math.min(screenSizeY - dialogSizeY, basePosY + Panel_Window_Warehouse:GetSizeY()) - Panel_Window_Warehouse:GetSizeY()
      posY = math.max(0, posY)
      local spanSizeY = posY - basePosY
      Panel_Window_Warehouse:SetSpanSize(self._invenSizeX, spanSizeY)
    end
  end
  if true == self._isConsole then
    Panel_Window_Warehouse:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Window_Warehouse:GetSizeX() - 5)
  end
  self:openWithInventory()
  if PaGlobalFunc_ItemMarketRegistItem_GetShow() then
    FGlobal_ItemMarketRegistItem_Close()
  end
end
function PaGlobal_WareHouse_All:openPanelFromDialogWithoutInventory(waypointKey, fromType)
  self:openPanel(waypointKey, fromType)
  PaGlobal_Warehouse_All_SetIgnoreMoneyButton(true)
  if ToClient_WorldMapIsShow() then
    Panel_Window_Warehouse:SetVerticalMiddle()
    Panel_Window_Warehouse:SetHorizonRight()
    Panel_Window_Warehouse:SetSpanSize(10, 0)
  end
end
function PaGlobal_WareHouse_All:openPanelFromWorldmap(waypointKey, fromType)
  if ToClient_WorldMapIsShow() then
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_Window_Warehouse, true)
    Panel_Window_Warehouse:SetHorizonRight()
    Panel_Window_Warehouse:SetVerticalMiddle()
    Panel_Window_Warehouse:SetSpanSize(10, 0)
  end
  self:openPanel(waypointKey, fromType)
  PaGlobal_Warehouse_All_SetIgnoreMoneyButton(true)
  if false == PaGlobal_Warehouse_All_IsMoveItem() then
    DeliveryRequestWindow_Close()
    if false == _ContentsGroup_RenewUI_Delivery and false == _ContentsGroup_NewUI_Delivery_All then
      DeliveryInformationWindow_Close()
    end
  end
  if true == self._ui._btn_itemMarketRegist:GetShow() then
    self._ui._btn_itemMarketRegist:SetShow(false)
  end
  self._buttonData.marketRegist = false
end
function PaGlobal_WareHouse_All:openPanelFromMaid()
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  if nil == regionInfo then
    return
  end
  local regionInfoWrapper = getRegionInfoWrapper(regionInfo:getAffiliatedTownRegionKey())
  local plantWayKey = regionInfoWrapper:getPlantKeyByWaypointKey():getWaypointKey()
  local regionKey = regionInfoWrapper:getRegionKey()
  if ToClient_IsAccessibleRegionKey(regionKey) == false then
    plantWayKey = ToClient_GetOtherRegionKey_NeerByTownRegionKey()
    if 0 == plantWayKey then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CANTFIND_WAREHOUSE_INTERRITORY"))
      return
    end
  end
  self._currentWaypointKey = plantWayKey
  self:openPanel(plantWayKey, CppEnums.WarehoouseFromType.eWarehoouseFromType_Maid)
  PaGlobal_Warehouse_All_SetIgnoreMoneyButton(false)
  self:openWithInventory()
end
function PaGlobal_WareHouse_All:openPanel(waypointKey, fromType)
  self._currentWaypointKey = waypointKey
  self._fromType = fromType
  self._currentRegionName = getRegionNameByWaypointKey(self._currentWaypointKey)
  if self:isGuildHouse() or self:isFurnitureWareHouse() then
    self._ui._stc_title:SetText(self._warehouseTitle)
  else
    if true == _ContentsGroup_NewUI_WareHouse_Search_All then
      PaGlobal_WareHouse_Search_All_SetCurrentWayPointKey(self._currentWaypointKey)
    end
    self._ui._stc_title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WAREHOUSE_ALL_TITLE_VILLAGE", "vilageName", self._currentRegionName))
  end
  local isSorted = ToClient_IsSortedWarehouse()
  self._ui._pc._chk_itemSort:SetCheck(isSorted)
  self._isSorted = isSorted
  self:updateSortText_console()
  self:initButtonData()
  if self:isWorldMapNode() then
    local regionInfoWrapper = ToClient_getRegionInfoWrapperByWaypoint(waypointKey)
    if nil ~= regionInfoWrapper then
      if true == _ContentsGroup_NewDelivery and regionInfoWrapper:getRegionKey() ~= 821 and regionInfoWrapper:getRegionKey() ~= 694 and regionInfoWrapper:getRegionKey() ~= 693 then
        self._buttonData.delivery = true
      elseif regionInfoWrapper:get():hasDeliveryNpc() then
        self._buttonData.delivery = true
      end
    end
  end
  if true == _ContentsGroup_NewDelivery or true == _ContentsGroup_NewUI_Delivery_All then
    ToClient_NewDeliveryClearPack()
  else
    clearDeliveryPack()
  end
  self._buttonData.manufacture = false
  if (CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc == self._fromType or CppEnums.WarehoouseFromType.eWarehoouseFromType_Manufacture == self._fromType) and ToClient_isPossibleManufactureAtWareHouse() then
    if true == self._isConsole then
      local isManufactureOpen = false
      if false == _ContentsGroup_NewUI_Manufacture_All then
        isManufactureOpen = PaGlobalFunc_ManufactureCheckShow()
      else
        isManufactureOpen = Panel_Window_Manufacture_All:GetShow()
      end
      if false == isManufactureOpen and false == self:isDeliveryWindow() then
        self._buttonData.manufacture = true
      end
    else
      self._buttonData.manufacture = true
    end
  end
  local myRegionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local hasItemMarket = myRegionInfo:get():hasItemMarketNpc()
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  if false == self._isConsole then
    if hasItemMarket and nil ~= dialog_getTalker() and dialog_isTalking() and not self:isGuildHouse() then
      self._buttonData.marketRegist = true
    else
      self._buttonData.marketRegist = false
    end
  end
  self._buttonData.sendMoney = false
  if true == PaGlobal_Warehouse_All_IsMoveItem() and true == self._isConsole and false == self:isDeliveryWindow() then
    PaGlobal_Warehouse_All_SetIgnoreMoneyButton(false)
  end
  self._buttonData.guildUpdate = false
  self:resizePanelChange(self:isNpc())
  Panel_Window_Warehouse:ChangeSpecialTextureInfoName("")
  self:prepareOpen()
  self._startSlotIndex = 0
  self._ui._scroll_warehouse:SetControlTop()
  self._ui._scroll_warehouse:SetControlPos(0)
  warehouse_requestInfo(self._currentWaypointKey)
  PaGlobalFunc_InterestKnowledge_All_Close()
  self:update()
  self:updateButtonInfo()
  local stc_moneyBg = self._ui._stc_moneyBg
  if CppEnums.WarehoouseFromType.eWarehoouseFromType_Npc == self._fromType then
    if self._ui._btn_itemMarketRegist:GetShow() then
      if self._ui._btn_manufacture:GetShow() then
        local buttonSizeX = (stc_moneyBg:GetSizeX() - 10) * 0.5
        self._ui._btn_itemMarketRegist:SetSize(buttonSizeX, self._ui._btn_itemMarketRegist:GetSizeY())
        self._ui._btn_manufacture:SetSize(buttonSizeX, self._ui._btn_itemMarketRegist:GetSizeY())
        self._ui._btn_manufacture:SetSpanSize(10, self._btnMarketRegSpanSizeY + self.addSizeY)
        self._ui._btn_itemMarketRegist:SetSpanSize(buttonSizeX + 20, self._btnMarketRegSpanSizeY + self.addSizeY)
      else
        self._ui._btn_itemMarketRegist:SetSize(stc_moneyBg:GetSizeX(), self._ui._btn_itemMarketRegist:GetSizeY())
        self._ui._btn_itemMarketRegist:SetSpanSize(10, self._btnMarketRegSpanSizeY + self.addSizeY)
      end
    end
  else
    self._ui._btn_manufacture:SetShow(false)
    self._ui._btn_itemMarketRegist:SetShow(false)
  end
  self._ui._btn_manufacture:SetTextSpan((self._ui._btn_manufacture:GetSizeX() + 26) * 0.5 - self._ui._btn_manufacture:GetTextSizeX() * 0.5, self._ui._btn_manufacture:GetSizeY() * 0.5 - self._ui._btn_manufacture:GetTextSizeY() * 0.5)
  self._ui._btn_itemMarketRegist:SetTextSpan((self._ui._btn_itemMarketRegist:GetSizeX() + 26) * 0.5 - self._ui._btn_itemMarketRegist:GetTextSizeX() * 0.5, self._ui._btn_itemMarketRegist:GetSizeY() * 0.5 - self._ui._btn_itemMarketRegist:GetTextSizeY() * 0.5)
  if CppEnums.WarehoouseFromType.eWarehoouseFromType_Maid == fromType or CppEnums.WarehoouseFromType.eWarehoouseFromType_Installation == fromType then
    if true == self._isConsole then
      Panel_Window_Warehouse:SetPosX((getOriginScreenSizeX() - Panel_Window_Warehouse:GetSizeX()) * 0.5)
      Panel_Window_Warehouse:SetPosY((getOriginScreenSizeY() - Panel_Window_Warehouse:GetSizeY()) * 0.5)
    else
      if true == _ContentsGroup_NewUI_Inventory_All then
        Panel_Window_Warehouse:SetPosX(getScreenSizeX() - Panel_Window_Inventory_All:GetSizeX() - Panel_Window_Warehouse:GetSizeX() - Panel_Window_Inventory_All:GetSpanSize().x - 10)
      else
        Panel_Window_Warehouse:SetPosX(getScreenSizeX() - Panel_Window_Inventory:GetSizeX() - Panel_Window_Warehouse:GetSizeX())
      end
      Panel_Window_Warehouse:SetPosY(getScreenSizeY() * 0.5 - Panel_Window_Warehouse:GetSizeY() * 0.5)
    end
  elseif CppEnums.WarehoouseFromType.eWarehoouseFromType_Manufacture == fromType then
    if false == _ContentsGroup_NewUI_Manufacture_All then
      local checkBtn_ShowDetail = UI.getChildControl(Panel_Manufacture, "CheckButton_ShowDetail")
      local knowledgeBG = UI.getChildControl(Panel_Manufacture, "Static_FrameBG")
      local isKnowledgeOpened = checkBtn_ShowDetail:IsCheck()
      if false == isKnowledgeOpened then
        Panel_Window_Warehouse:SetPosX(Panel_Manufacture:GetPosX() + Panel_Manufacture:GetSizeX() + 0)
      else
        Panel_Window_Warehouse:SetPosX(Panel_Manufacture:GetPosX() + Panel_Manufacture:GetSizeX() + knowledgeBG:GetSizeX() + 30)
      end
      Panel_Window_Warehouse:SetPosY(Panel_Manufacture:GetPosY())
    else
      PaGlobal_Manufacture_All_OpenFromWareHouseSetPos()
      Panel_Window_Warehouse:SetPosX(Panel_Window_Manufacture_All:GetPosX() + Panel_Window_Manufacture_All:GetSizeX() + 10)
    end
  end
end
function PaGlobal_WareHouse_All:openWithInventory(filterFunc)
  if true == self._isConsole then
    local optionalEvent = {
      func = PaGlobalFunc_InventoryInfo_PopMoney,
      keyGuideString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WAREHOUSE_PUTINMONEY")
    }
    Inventory_SetFunctor(filterFunc, FGlobal_PopupMoveItem_InitByInventory, PaGlobal_Warehouse_All_Close, nil, optionalEvent)
  else
    Inventory_SetFunctor(filterFunc, FGlobal_PopupMoveItem_InitByInventory, PaGlobal_Warehouse_All_Close, nil)
  end
  InventoryWindow_Show()
  self._startSlotIndex = 0
  self._ui._scroll_warehouse:SetControlTop()
  if false == self._isConsole then
    ServantInventory_OpenAll()
    if true == _ContentsGroup_NewUI_Inventory_All then
      PaGlobalFunc_Inventory_All_InventorySetPosWithWarehouse()
    else
      FGlobal_InventorySetPos_WithWarehouse()
    end
  end
end
function PaGlobal_WareHouse_All:setfunctor(filterFunc, rClickFunc)
  if nil ~= filterFunc and "function" ~= type(filterFunc) then
    filterFunc = nil
    UI.ASSERT(false, "Param 1 must be Function type")
  end
  if nil ~= rClickFunc and "function" ~= type(rClickFunc) then
    rClickFunc = nil
    UI.ASSERT(false, "Param 2 must be Function type")
  end
  self.manufactureFilterFunc = filterFunc
  self.manufactureRclickFunc = rClickFunc
end
function PaGlobal_WareHouse_All:resetFilter()
  if true == _ContentsGroup_isAllWarehouse then
    PaGlobal_WareHouse_All:searchMenuOpen()
  end
  if nil ~= self.itemMarketFilterFunc then
    self.itemMarketFilterFunc = nil
    self.itemMarketRclickFunc = nil
  end
  self:update()
end
function PaGlobal_WareHouse_All:searchMenuTerritoryOpen(territoryKey, isFirstOpen)
  self._ui._list2_serchWareHouse:getElementManager():clearKey()
  for index = 0, self._maxTerritoryKeyCount - 1 do
    if nil ~= self._warehouseInfo._territoryGroup[index] then
      self._ui._list2_serchWareHouse:getElementManager():pushKey(toInt64(0, index))
      if index == territoryKey then
        if self._selectIndex == territoryKey then
          self._selectIndex = -2
        else
          local maxTerritoryWarehouseCount = self._warehouseInfo._territoryGroup[index]._count
          for wIndex = 1, maxTerritoryWarehouseCount do
            warehouse_requestInfo(self._warehouseInfo._territoryGroup[index][wIndex])
            local waypointKey = self._warehouseInfo._territoryGroup[index][wIndex] + self._separatorNumber
            self._ui._list2_serchWareHouse:getElementManager():pushKey(toInt64(0, waypointKey))
          end
          self._selectIndex = territoryKey
        end
      end
    end
  end
  if isFirstOpen then
    local currentWaypointKey = getCurrentWaypointKey()
    self._selectWaypointKey = currentWaypointKey
    self:otherTownsWareHouse(currentWaypointKey)
    return
  end
  if 0 <= self._selectIndex then
    self._selectWaypointKey = self._warehouseInfo._territoryGroup[self._selectIndex][1]
    self:otherTownsWareHouse(self._selectWaypointKey)
  end
end
function PaGlobal_WareHouse_All:otherTownsWareHouse(waypointKey)
  local isCurrentTownsWarehouse = waypointKey == getCurrentWaypointKey()
  if isCurrentTownsWarehouse then
    self:openPanelFromDialog()
  else
    self:openPanelFromWorldmap(waypointKey, CppEnums.WarehoouseFromType.eWarehoouseFromType_Worldmap)
    if true == _ContentsGroup_NewUI_Inventory_All then
      if Panel_Window_Inventory_All:IsUISubApp() then
        Panel_Window_Inventory_All:CloseUISubApp()
      end
      Panel_Window_Inventory_All:SetShow(false)
    else
      if Panel_Window_Inventory:IsUISubApp() then
        Panel_Window_Inventory:CloseUISubApp()
      end
      Panel_Window_Inventory:SetShow(false)
    end
    if false == _ContentsGroup_RenewUI_InventoryEquip then
      if true == _ContentsGroup_NewUI_Equipment_All then
        if Panel_Window_Equipment_All:IsUISubApp() then
          Panel_Window_Equipment_All:CloseUISubApp()
        end
        Panel_Window_Equipment_All:SetShow(false)
      else
        if Panel_Equipment:IsUISubApp() then
          Panel_Equipment:CloseUISubApp()
        end
        Panel_Equipment:SetShow(false)
      end
    end
  end
  PaGlobal_Warehouse_All_OtherWaypointKey(waypointKey)
  local beforeWaypointKey = self._selectWaypointKey
  self._selectWaypointKey = waypointKey
  if 0 < beforeWaypointKey then
    self._ui._list2_serchWareHouse:requestUpdateByKey(toInt64(0, beforeWaypointKey + self._separatorNumber))
  end
  self._ui._list2_serchWareHouse:requestUpdateByKey(toInt64(0, waypointKey + self._separatorNumber))
end
function PaGlobal_WareHouse_All:searchMenuOpen()
  if true == self._ui._stc_leftBg:GetShow() or not _ContentsGroup_isAllWarehouse then
    return
  end
  self:SetShowSearchMenuWareHouse(true)
  local warehouseCount = ToClient_FindWareHouse(getCurrentWaypointKey())
  if 0 == warehouseCount then
    return
  end
  local currentWaypointKey = getCurrentWaypointKey()
  local currnetRegionInfoWrapper = ToClient_getRegionInfoWrapperByWaypoint(currentWaypointKey)
  local currentTerritoryKey = currnetRegionInfoWrapper:getTerritoryKeyRaw()
  self._warehouseInfo._territoryCount = 0
  self._warehouseInfo._territoryGroup = {}
  for index = 0, warehouseCount - 1 do
    local waypointKey = ToClient_getWareHouseWaypointKey(index)
    local regionInfoWrapper = ToClient_getRegionInfoWrapperByWaypoint(waypointKey)
    local territoryKey = regionInfoWrapper:getTerritoryKeyRaw()
    if nil == self._warehouseInfo._territoryGroup[territoryKey] then
      self._warehouseInfo._territoryCount = self._warehouseInfo._territoryCount + 1
      self._warehouseInfo._territoryGroup[territoryKey] = {}
      self._warehouseInfo._territoryGroup[territoryKey]._count = 1
      self._warehouseInfo._territoryGroup[territoryKey][1] = waypointKey
      self._territoryNameInfo[territoryKey] = regionInfoWrapper:getTerritoryName()
    else
      self._warehouseInfo._territoryGroup[territoryKey]._count = self._warehouseInfo._territoryGroup[territoryKey]._count + 1
      self._warehouseInfo._territoryGroup[territoryKey][self._warehouseInfo._territoryGroup[territoryKey]._count] = waypointKey
    end
  end
  self._selectIndex = -1
  self._selectWaypointKey = -1
  self._ui._list2_serchWareHouse:getElementManager():clearKey()
  for index = 0, self._maxTerritoryKeyCount - 1 do
    if nil ~= self._warehouseInfo._territoryGroup[index] then
      self._ui._list2_serchWareHouse:getElementManager():pushKey(toInt64(0, index))
    end
  end
  self:searchMenuTerritoryOpen(currentTerritoryKey, true)
  self._ui._stc_leftBg:ComputePos()
end
function PaGlobal_WareHouse_All:searchMenuClose()
  if false == self._ui._stc_leftBg:GetShow() then
    return
  end
  self:SetShowSearchMenuWareHouse(false)
end
function PaGlobal_WareHouse_All:townListCheck()
  if ToClient_WorldMapIsShow() then
    return
  end
  if PaGlobalFunc_PanelDelivery_GetShow() or not _ContentsGroup_isAllWarehouse then
    self:SetShowSearchMenuWareHouse(false)
  else
    self:SetShowSearchMenuWareHouse(true)
  end
end
function PaGlobal_WareHouse_All:SetShowSearchMenuWareHouse(isShow)
  if isShow == self._ui._stc_leftBg:GetShow() then
    return
  end
  self._ui._stc_leftBg:SetShow(isShow)
  self._ui._txt_notAvaliable:SetShow(false)
  if true == isShow then
    Panel_Window_Warehouse:SetSize(self._beforePanelSizeX, Panel_Window_Warehouse:GetSizeY())
    self._ui._stc_topBg:SetSize(self._beforePanelSizeX, self._ui._stc_topBg:GetSizeY())
    self._ui._stc_bottomBg:SetSize(self._beforePanelSizeX, self._ui._stc_bottomBg:GetSizeY())
  else
    self._beforePanelSizeX = Panel_Window_Warehouse:GetSizeX()
    local sizeX = self._ui._stc_rightBg:GetSizeX()
    Panel_Window_Warehouse:SetSize(sizeX, Panel_Window_Warehouse:GetSizeY())
    self._ui._stc_topBg:SetSize(sizeX, self._ui._stc_topBg:GetSizeY())
    self._ui._stc_bottomBg:SetSize(sizeX, self._ui._stc_bottomBg:GetSizeY())
  end
  self._ui._stc_rightBg:ComputePos()
  self._ui._stc_decoBg:ComputePos()
  self._ui._txt_villageName:ComputePos()
  self._ui._pc._btn_close:ComputePos()
  self._ui._pc._btn_question:ComputePos()
end
function PaGlobal_WareHouse_All:updateSortText_console()
  if false == self._isConsole then
    return
  end
  if true == self._isSorted then
    self._ui._console._txt_keyGuideSort:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_KEYGUIDE_UNSORT"))
  else
    self._ui._console._txt_keyGuideSort:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_SORT"))
  end
end
function PaGlobal_WareHouse_All:updateButtonInfo()
  if true == self._isConsole then
    self._ui._console._txt_keyGuideSelect:SetShow(self._buttonData.selectItem)
    self._ui._console._txt_keyGuideSilver:SetShow(self._buttonData.sendMoney)
    self._ui._console._txt_keyGuideManufacture:SetShow(self._buttonData.manufacture)
    if true == self._buttonData.manufacture then
      Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "HandleEventLUp_Warehouse_All_ManufactureOpen()")
    else
      Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "")
    end
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuide, self._ui._stc_bottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  else
    self._ui._btn_itemMarketRegist:SetShow(self._buttonData.marketRegist)
    self._ui._btn_manufacture:SetShow(self._buttonData.manufacture)
    self._ui._btn_deliveryInfomation:SetShow(self._buttonData.delivery)
    self._ui._btn_guildUpdate:SetShow(self._buttonData.guildUpdate)
    self._ui._btn_guildLog:SetShow(self._buttonData.guildUpdate)
  end
end
function PaGlobal_WareHouse_All:initButtonData()
  self._buttonData.selectItem = false
  self._buttonData.marketRegist = false
  self._buttonData.manufacture = false
  self._buttonData.delivery = false
  self._buttonData.guildUpdate = false
  self._buttonData.sendMoney = false
end
