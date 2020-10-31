function HandleEventLUp_Warehouse_All_PopMoney()
  local slotNo = getMoneySlotNo()
  if nil == slotNo then
    return
  end
  if not PaGlobal_Warehouse_All_IsMoveItem() then
    return
  end
  HandleEventLUp_Warehouse_All_ItemXXX(slotNo)
end
function HandleEventRUp_Warehouse_All_Item(index)
  if HandleEventLUp_Warehouse_All_DropHandler(index) then
    return
  end
  if not PaGlobal_Warehouse_All_IsMoveItem() then
    return
  end
  local slotNo = PaGlobal_WareHouse_All._slots[index].slotNo
  if nil == slotNo then
    return
  end
  if true == _ContentsGroup_NewDelivery and true == PaGlobalFunc_PanelDelivery_GetShow() and false == PaGlobal_WareHouse_All:isDeliveryWindow() then
    return
  end
  local warehouseWrapper = PaGlobal_WareHouse_All:getWarehouse()
  local itemWrapper = warehouseWrapper:getItem(slotNo)
  if nil ~= itemWrapper then
    local itemStatic = itemWrapper:getStaticStatus():get()
    if nil ~= itemStatic then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
    end
  end
  if nil == PaGlobal_WareHouse_All.itemMarketRclickFunc and nil == PaGlobal_WareHouse_All.manufactureRclickFunc then
    HandleEventLUp_Warehouse_All_ItemXXX(slotNo)
  elseif nil ~= PaGlobal_WareHouse_All.manufactureRclickFunc then
    if nil ~= itemWrapper then
      PaGlobal_WareHouse_All.manufactureRclickFunc(slotNo, itemWrapper, itemWrapper:get():getCount_s64(), CppEnums.ItemWhereType.eWarehouse)
    end
  elseif nil ~= itemWrapper then
    PaGlobal_Warehouse_All_itemMarketRclickFunc(slotNo, itemWrapper, itemWrapper:get():getCount_s64())
  end
end
function HandleEventLUp_Warehouse_All_ItemXXX(slotNo)
  if nil == slotNo then
    return
  end
  local warehouseWrapper = PaGlobal_WareHouse_All:getWarehouse()
  local itemWrapper = warehouseWrapper:getItem(slotNo)
  if nil == itemWrapper then
    return
  end
  if true == _ContentsGroup_NewDelivery then
    local warehouseItemCount = Int64toInt32(itemWrapper:get():getCount_s64())
    local packItemCount = ToClient_NewDeliveryGetPackItemCountBySlotNo(slotNo)
    if true == PaGlobalFunc_PanelDelivery_GetShow() and true == PaGlobal_WareHouse_All:isDeliveryWindow() and warehouseItemCount == packItemCount then
      return
    end
    if 0 == warehouseItemCount then
      return
    end
  elseif Defines.s64_const.s64_0 == itemWrapper:get():getCount_s64() then
    return
  end
  FGlobal_PopupMoveItem_Init(nil, slotNo, CppEnums.MoveItemToType.Type_Warehouse, nil, true)
end
function HandleEventLUp_Warehouse_All_MarketRegistOpen(byMaid)
  local isOpenWarehouse = true
  Inventory_SetFunctor(nil, nil, nil, nil)
  FGlobal_ItemMarketRegistItem_Open(isOpenWarehouse, byMaid)
  PaGlobal_WareHouse_All.itemMarketFilterFunc = PaGlobal_Warehouse_All_itemMarketFilterFunc
  PaGlobal_WareHouse_All.itemMarketRclickFunc = PaGlobal_Warehouse_All_itemMarketRclickFunc
  Panel_Window_Warehouse:SetPosX(0)
  PaGlobal_WareHouse_All:update()
end
function HandleEventLUp_Warehouse_All_ManufactureOpen()
  if true == ToClient_SniperGame_IsPlaying() or true == Panel_Global_Manual:GetShow() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_PVPBATTLEGROUND_CONDITION_WAIT"))
    return
  end
  if true == _ContentsGroup_NewUI_Fishing_All then
    if true == PaGlobal_Fishing_All_GetShowPanel() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_PVPBATTLEGROUND_CONDITION_WAIT"))
      return
    end
    if true == PaGlobal_Fishing_All_GetFishingStart() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_FISHING_ACK"))
      return
    end
  else
    if true == Panel_Fishing:GetShow() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_PVPBATTLEGROUND_CONDITION_WAIT"))
      return
    end
    if true == MiniGame_Manual_Value_FishingStart then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_FISHING_ACK"))
      return
    end
  end
  PaGlobal_WareHouse_All_SearchMenuClose()
  if true == PaGlobal_WareHouse_All._isConsole then
    if false == _ContentsGroup_NewUI_Manufacture_All then
      PaGlobalFunc_ManufactureOpen(true)
      Panel_Window_Manufacture:SetPosX(10)
      PaGlobalFunc_Manufacture_SetFromWareHouse()
    else
      PaGlobalFunc_Manufacture_All_Open(nil, CppEnums.ItemWhereType.eWarehouse, true, nil, PaGlobal_WareHouse_All._currentWaypointKey)
      PaGlobalFunc_Manufacture_All_SetFromWareHouse()
    end
    if true == _ContentsGroup_NewUI_Dialog_All then
      PaGlobalFunc_DialogMain_All_ShowToggle(true)
      PaGlobalFunc_InterestKnowledge_All_Close()
    else
      PaGlobalFunc_MainDialog_Open()
    end
    PaGlobal_WareHouse_All:prepareClose()
  else
    PaGlobal_WareHouse_All:prepareClose()
    if false == _ContentsGroup_NewUI_Manufacture_All then
      Manufacture_Show(nil, CppEnums.ItemWhereType.eWarehouse, true, nil, PaGlobal_WareHouse_All._currentWaypointKey)
    else
      PaGlobalFunc_Manufacture_All_Open(nil, CppEnums.ItemWhereType.eWarehouse, true, nil, PaGlobal_WareHouse_All._currentWaypointKey)
    end
  end
end
function HandleEventLUp_Warehouse_All_ItemMarketClose()
  FGlobal_WareHouseItemMarketRegistItem_Close()
end
function HandleEventLUp_Warehouse_All_GuildWareHouseUpdate()
  warehouse_requestGuildWarehouseInfo()
end
function HandleEventLUp_Warehouse_All_GuildWareHouseHistory()
  ToClient_requestGuildWareHouseHistory()
end
function HandleEventLUp_Warehouse_All_LDownClick(index)
  local warehouseWrapper = PaGlobal_WareHouse_All:getWarehouse()
  if nil == warehouseWrapper then
    return
  end
  if nil == PaGlobal_WareHouse_All.savedWayPointKey then
    PaGlobal_WareHouse_All.savedWayPointKey = 0
  end
  local useStartSlot = 1
  local useMaxCount = warehouseWrapper:getUseMaxCount()
  local Execute_EasyBuy = function()
    PaGlobal_EasyBuy:Open(17, PaGlobal_WareHouse_All.savedWayPointKey)
  end
  if index == useMaxCount - useStartSlot - PaGlobal_WareHouse_All._startSlotIndex then
    local maxCount = warehouseWrapper:getMaxCount()
    local leftCount = maxCount - useMaxCount
    local messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_WAREHOUSE_EASYBUY") .. [[


]] .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WAREHOUSE_EXTENDABLECOUNT", "maxCount", maxCount - 1, "leftCount", leftCount)
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_CONFIRM"),
      content = messageContent,
      functionYes = Execute_EasyBuy,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  end
end
function HandleEvent_Warehouse_All_Scroll(isUp)
  local useStartSlot = 1
  local warehouseWrapper = PaGlobal_WareHouse_All:getWarehouse()
  if nil == warehouseWrapper then
    return
  end
  local scrollPos = PaGlobal_WareHouse_All._ui._scroll_warehouse:GetControlPos()
  if true == isUp and 0 == scrollPos then
    return
  elseif false == isUp and 1 == scrollPos then
    return
  end
  local maxSize = warehouseWrapper:getMaxCount() - useStartSlot + 6
  PaGlobal_WareHouse_All._startSlotIndex = UIScroll.ScrollEvent(PaGlobal_WareHouse_All._ui._scroll_warehouse, isUp, PaGlobal_WareHouse_All._config.slotRows, maxSize, PaGlobal_WareHouse_All._startSlotIndex, PaGlobal_WareHouse_All._config.slotCols)
  PaGlobal_WareHouse_All:update()
end
function HandleEventPMove_Warehouse_All_SlotDrag(index)
  local slotNo = PaGlobal_WareHouse_All._slots[index].slotNo
  if nil == slotNo then
    return
  end
  local warehouseWrapper = PaGlobal_WareHouse_All:getWarehouse()
  local itemWrapper = warehouseWrapper:getItem(slotNo)
  if nil == itemWrapper then
    return
  end
  if Defines.s64_const.s64_0 == itemWrapper:get():getCount_s64() then
    return
  end
  if true == _ContentsGroup_NewDelivery and true == PaGlobalFunc_PanelDelivery_GetShow() then
    return
  end
  DragManager:setDragInfo(Panel_Window_Warehouse, nil, slotNo, "Icon/" .. itemWrapper:getStaticStatus():getIconPath(), PaGlobal_Warehouse_All_GroundClick, nil)
end
function HandleEventLUp_Warehouse_All_DropHandler(index)
  if nil == DragManager.dragStartPanel then
    return false
  end
  if true == _ContentsGroup_NewDelivery and true == PaGlobalFunc_PanelDelivery_GetShow() then
    return false
  end
  return (DragManager:itemDragMove(CppEnums.MoveItemToType.Type_Warehouse, nil))
end
function HandleEventMOut_Warehouse_All_IconOut(index)
  local slot = PaGlobal_WareHouse_All._slots[index]
  for idx = 1, PaGlobal_WareHouse_All._maxFindItemCnt do
    if index == PaGlobal_WareHouse_All._findItemIdx[idx] then
      slot.icon:AddEffect("fUI_SearchItem_01A", true, 0, 0)
    end
  end
  if nil ~= PaGlobal_WareHouse_All._slotFilterEffect[index] then
    slot.icon:AddEffect("UI_Inventory_Filtering", true, 0, 0)
  end
  PaGlobal_WareHouse_All._tooltipSlotNo = nil
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_Show_GeneralNormal(index, "WareHouse", false)
  end
end
function HandleEventMOn_Warehouse_All_IconOver(index)
  local slot = PaGlobal_WareHouse_All._slots[index]
  slot.icon:EraseAllEffect()
  if PaGlobal_WareHouse_All._slotNilEffect[index] then
    slot.icon:EraseEffect(PaGlobal_WareHouse_All._slotNilEffect[index])
    PaGlobal_WareHouse_All._slotNilEffect[index] = slot.icon:AddEffect("UI_Inventory_EmptySlot", false, 0, 0)
  else
    PaGlobal_WareHouse_All._slotNilEffect[index] = slot.icon:AddEffect("UI_Inventory_EmptySlot", false, 0, 0)
  end
  if nil ~= PaGlobal_WareHouse_All._slotFilterEffect[index] then
    slot.icon:AddEffect("UI_Inventory_Filtering", true, 0, 0)
  end
  if true == PaGlobal_WareHouse_All._isConsole then
    local warehouseWrapper = PaGlobal_WareHouse_All:getWarehouse()
    if nil == warehouseWrapper then
      return
    end
    local itemWrapper = warehouseWrapper:getItem(slot.slotNo)
    if nil ~= itemWrapper and true == PaGlobal_Warehouse_All_IsMoveItem() then
      PaGlobal_WareHouse_All._buttonData.selectItem = true
      if CppEnums.WarehoouseFromType.eWarehoouseFromType_Manufacture == PaGlobal_WareHouse_All._fromType then
        PaGlobal_WareHouse_All._buttonData.selectItem = nil ~= PaGlobal_WareHouse_All._slotFilterEffect[index]
      end
    else
      PaGlobal_WareHouse_All._buttonData.selectItem = false
    end
    PaGlobal_WareHouse_All:updateButtonInfo()
    if true == _ContentsGroup_RenewUI_Tooltip and nil ~= itemWrapper then
      PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemSSWrapper, itemWrapper:getStaticStatus(), Defines.TooltipTargetType.Item, slot.icon)
    end
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    PaGlobal_WareHouse_All._tooltipSlotNo = slot.slotNo
    Panel_Tooltip_Item_Show_GeneralNormal(index, "WareHouse", true)
  end
end
function HandleEventLUp_WareHouse_All_CheckSort()
  audioPostEvent_SystemUi(0, 0)
  _AudioPostEvent_SystemUiForXBOX(0, 0)
  local isSorted = false
  if true == PaGlobal_WareHouse_All._isConsole then
    isSorted = not PaGlobal_WareHouse_All._isSorted
  else
    isSorted = PaGlobal_WareHouse_All._ui._pc._chk_itemSort:IsCheck()
  end
  ToClient_SetSortedWarehouse(isSorted)
  PaGlobal_WareHouse_All._isSorted = isSorted
  PaGlobal_WareHouse_All:updateSortText_console()
  FromClient_Warehouse_All_Update()
end
function HandleEventRUp_Warehouse_All_ShowDetailTooltip(index)
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local warehouseWrapper = PaGlobal_WareHouse_All:getWarehouse()
  if nil == warehouseWrapper then
    return
  end
  local slot = PaGlobal_WareHouse_All._slots[index]
  local itemWrapper = warehouseWrapper:getItem(slot.slotNo)
  if nil ~= itemWrapper then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    PaGlobalFunc_FloatingTooltip_Close()
  end
end
function HandleEventMOn_Warehouse_All_Hightlight(isShow, idx)
  local slot = PaGlobal_WareHouse_All._blankSlots[idx].empty
  if nil == slot then
    return
  end
  if true == isShow then
    local x1, y1, x2, y2 = setTextureUV_Func(slot, 46, 99, 90, 143)
    slot:getBaseTexture():setUV(x1, y1, x2, y2)
  else
    local x1, y1, x2, y2 = setTextureUV_Func(slot, 1, 99, 45, 143)
    slot:getBaseTexture():setUV(x1, y1, x2, y2)
  end
  slot:setRenderTexture(slot:getBaseTexture())
end
function HandleEventMOn_Warehouse_All_SetAKeyGuide(isShow)
  PaGlobal_WareHouse_All._buttonData.selectItem = isShow
  PaGlobal_WareHouse_All:updateButtonInfo()
end
function HandleEventLUp_WareHouse_All_OpenDelivery()
  PaGlobal_Warehouse_All_ReloadbyWaypointKey()
  DeliveryInformation_OpenPanelFromWorldmap(PaGlobal_WareHouse_All._currentWaypointKey)
end
function FromClient_Warehouse_All_Update()
  if false == PaGlobal_WareHouse_All_GetShow() then
    return
  end
  PaGlobal_WareHouse_All:update()
end
function FromClient_Warehouse_All_Close()
  PaGlobal_Warehouse_All_Close()
end
function FromClient_Warehouse_All_GuildUpdate(bForcedOpen, bForcedClose)
  if nil ~= Worldmap_Grand_GuildHouseControl and Worldmap_Grand_GuildHouseControl:GetShow() or Worldmap_Grand_GuildCraft:GetShow() then
    return
  end
  if true == _ContentsGroup_NewUI_NpcShop_All and nil ~= PaGlobalFunc_NPCShop_ALL_GetShow then
    if true == PaGlobalFunc_NPCShop_ALL_GetShow() then
      FromClient_NPCShop_ALL_PushKeyToList2()
      return
    end
  elseif true == _ContentsGroup_RenewUI_NpcShop then
    if PaGlobalFunc_Dialog_NPCShop_IsShow() then
      FromClient_Dialog_NPCShop_UpdateContent()
      return
    end
  elseif Panel_Window_NpcShop:IsShow() then
    NpcShop_UpdateContent()
    return
  end
  if false == bForcedOpen and false == PaGlobal_WareHouse_All_GetShow() then
    return
  end
  if true == bForcedClose then
    PaGlobal_Warehouse_All_Close()
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  local guildName = ""
  if nil ~= myGuildInfo then
    guildName = myGuildInfo:getName()
  end
  PaGlobal_WareHouse_All._currentWaypointKey = 0
  PaGlobal_WareHouse_All._fromType = CppEnums.WarehoouseFromType.eWarehoouseFromType_GuildHouse
  PaGlobal_WareHouse_All._currentRegionName = PAGetString(Defines.StringSheet_GAME, "Lua_WareHouse_CurrentRegionName")
  PaGlobal_WareHouse_All._ui._stc_title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WAREHOUSE_ALL_TITLE_GUILD", "guildName", guildName))
  PaGlobal_WareHouse_All:update()
  PaGlobal_WareHouse_All:initButtonData()
  PaGlobal_WareHouse_All._buttonData.guildUpdate = true
  PaGlobal_WareHouse_All:updateSortText_console()
  PaGlobal_WareHouse_All:searchMenuClose()
  if true == PaGlobal_WareHouse_All_GetShow() then
    return
  end
  local isInvenUISubApp = false
  if true == _ContentsGroup_NewUI_Inventory_All then
    isInvenUISubApp = Panel_Window_Inventory_All:IsUISubApp()
  else
    isInvenUISubApp = Panel_Window_Inventory:IsUISubApp()
  end
  if true == isInvenUISubApp then
    Panel_Window_Warehouse:ComputePos()
  elseif true == PaGlobal_WareHouse_All._isConsole then
    Panel_Window_Warehouse:ComputePos()
    Panel_Window_Warehouse:SetPosX((getOriginScreenSizeX() - Panel_Window_Warehouse:GetSizeX()) * 0.5)
  elseif true == _ContentsGroup_NewUI_Inventory_All then
    Panel_Window_Warehouse:SetPosX(Panel_Window_Inventory_All:GetPosX() - Panel_Window_Warehouse:GetSizeX())
    Panel_Window_Warehouse:SetPosY(Panel_Window_Inventory_All:GetPosY())
  else
    Panel_Window_Warehouse:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Window_Warehouse:GetSizeX())
    Panel_Window_Warehouse:SetPosY(Panel_Window_Inventory:GetPosY())
  end
  PaGlobal_Warehouse_All_SetIgnoreMoneyButton(true)
  Panel_Window_Warehouse:ChangeSpecialTextureInfoName("")
  PaGlobal_WareHouse_All:prepareOpen()
  PaGlobal_Warehouse_All_OpenWithInventory()
end
function FromClient_Warehouse_All_FurnitureUpdate()
  if false == _ContentsGroup_isFurnitureWarehouse then
    return
  end
  PaGlobal_WareHouse_All._currentWaypointKey = 0
  PaGlobal_WareHouse_All._fromType = CppEnums.WarehoouseFromType.eWarehoouseFromType_Furniture
  PaGlobal_WareHouse_All._currentRegionName = PAGetString(Defines.StringSheet_GAME, "Lua_WareHouse_FurnitureName")
  PaGlobal_WareHouse_All._ui._stc_title:SetText(PaGlobal_WareHouse_All._warehouseTitle)
  PaGlobal_WareHouse_All:update()
  if false == PaGlobal_WareHouse_All._isConsole then
    PaGlobal_WareHouse_All._ui._btn_itemMarketRegist:SetShow(false)
    PaGlobal_WareHouse_All._ui._btn_manufacture:SetShow(false)
    PaGlobal_WareHouse_All._ui._btn_deliveryInfomation:SetShow(false)
    PaGlobal_WareHouse_All._ui._btn_guildUpdate:SetShow(false)
    PaGlobal_WareHouse_All._ui._btn_guildLog:SetShow(false)
    PaGlobal_WareHouse_All._ui._txt_valueMoney:SetShow(false)
  end
  PaGlobal_WareHouse_All:initButtonData()
  PaGlobal_WareHouse_All:updateSortText_console()
  PaGlobal_WareHouse_All:searchMenuClose()
  PaGlobal_Warehouse_All_SetIgnoreMoneyButton(true)
  Panel_Window_Warehouse:ChangeSpecialTextureInfoName("")
  PaGlobal_WareHouse_All:open()
  local isInvenOpen = false
  if true == _ContentsGroup_NewUI_Inventory_All then
    isInvenOpen = Panel_Window_Inventory_All:IsShow()
  else
    isInvenOpen = Panel_Window_Inventory:IsShow()
  end
  if false == isInvenOpen then
    PaGlobal_Warehouse_All_OpenWithInventory(PaGlobal_Warehouse_All_FurnitureFilter)
    Panel_Window_Warehouse:SetPosX(10)
    Panel_Window_Warehouse:SetPosY(280)
  end
end
function FromClient_Warehouse_All_OpenByInstallation(actorKeyRaw, waypointKey)
  PaGlobal_WareHouse_All._installationActorKeyRaw = actorKeyRaw
  PaGlobal_Warehouse_All_OpenPanel(waypointKey, CppEnums.WarehoouseFromType.eWarehoouseFromType_Installation)
  PaGlobal_Warehouse_All_SetIgnoreMoneyButton(false)
  PaGlobal_Warehouse_All_OpenWithInventory()
end
function PaGloabl_WareHouse_All_ShowAni()
  if nil == Panel_Window_Warehouse then
    return
  end
  Panel_Window_Warehouse:SetAlpha(0)
  local ani = UIAni.AlphaAnimation(1, Panel_Window_Warehouse, 0, 0.15)
  ani.IsChangeChild = false
  audioPostEvent_SystemUi(1, 0)
end
function PaGloabl_WareHouse_All_HideAni()
  if nil == Panel_Window_Warehouse then
    return
  end
  Panel_Window_Warehouse:SetShowWithFade(__ePAUIAniType_FadeOut)
  local aniInfo1 = Panel_Window_Warehouse:addColorAnimation(0, 0.15, __ePAUIAnimAdvance_SinHalfPI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = false
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
  audioPostEvent_SystemUi(1, 0)
end
function PaGlobal_Warehouse_All_GetToolTipItemNo()
  local warehouseWrapper = PaGlobal_WareHouse_All:getWarehouse()
  if nil == warehouseWrapper then
    return nil
  end
  if nil == PaGlobal_WareHouse_All._tooltipSlotNo then
    return nil
  end
  return (warehouseWrapper:getItemNoBySlotNo(PaGlobal_WareHouse_All._tooltipSlotNo))
end
function PaGlobal_Warehouse_All_GetToolTipItemSlotNo()
  local warehouseWrapper = PaGlobal_WareHouse_All:getWarehouse()
  if nil == warehouseWrapper then
    return nil
  end
  return PaGlobal_WareHouse_All._tooltipSlotNo
end
function PaGlobal_Warehouse_All_GetToopTipItem()
  local warehouseWrapper = PaGlobal_WareHouse_All:getWarehouse()
  if nil == warehouseWrapper then
    return nil
  end
  if nil == PaGlobal_WareHouse_All._tooltipSlotNo then
    return nil
  end
  return (warehouseWrapper:getItem(PaGlobal_WareHouse_All._tooltipSlotNo))
end
function PaGlobal_Warehouse_All_GetItem(slotNo)
  local warehouseWrapper = PaGlobal_WareHouse_All:getWarehouse()
  if nil == warehouseWrapper then
    return nil
  end
  return (warehouseWrapper:getItem(slotNo))
end
function PaGlobal_Warehouse_All_UpdateSearchMenuWarehouse(waypointKey)
  PaGlobal_WareHouse_All._ui._list2_serchWareHouse:requestUpdateByKey(toInt64(0, waypointKey + PaGlobal_WareHouse_All._separatorNumber))
end
function PaGlobal_Warehouse_All_UpdateSearchMenuList(contents, key)
  local idx = Int64toInt32(key)
  local radioButton = UI.getChildControl(contents, "RadioButton_Territory")
  local warehouseName = UI.getChildControl(contents, "RadioButton_Town")
  local count = UI.getChildControl(contents, "StaticText_Capacity")
  radioButton:SetTextMode(__eTextMode_AutoWrap)
  warehouseName:SetTextMode(__eTextMode_AutoWrap)
  radioButton:SetPosX(5)
  warehouseName:SetPosX(6)
  warehouseName:SetShow(false)
  count:SetShow(false)
  if idx < PaGlobal_WareHouse_All._separatorNumber then
    local territoryName = PaGlobal_WareHouse_All._territoryNameInfo[idx]
    local territoryWarehouseCount = PaGlobal_WareHouse_All._warehouseInfo._territoryGroup[idx]._count
    radioButton:SetText(territoryName .. "(" .. territoryWarehouseCount .. ")")
    radioButton:addInputEvent("Mouse_LUp", "PaGlobal_Warehouse_All_SearchMenuTerritoryOpen(" .. idx .. ")")
    radioButton:addInputEvent("Mouse_On", "HandleEventMOn_Warehouse_All_SetAKeyGuide(false)")
    radioButton:SetShow(true)
    warehouseName:SetShow(false)
    count:SetShow(false)
    radioButton:SetCheck(idx == PaGlobal_WareHouse_All._selectIndex)
  else
    radioButton:SetShow(false)
    warehouseName:SetShow(true)
    local waypointKey = idx - PaGlobal_WareHouse_All._separatorNumber
    warehouseName:SetCheck(waypointKey == PaGlobal_WareHouse_All._selectWaypointKey)
    warehouseName:SetFontColor(Defines.Color.C_FFC4BEBE)
    local regionInfoWrapper = ToClient_getRegionInfoWrapperByWaypoint(waypointKey)
    warehouseName:SetText(regionInfoWrapper:getAreaName())
    local warehouseWrapper = warehouse_get(waypointKey)
    if nil == warehouseWrapper then
      return
    end
    local itemCount = warehouseWrapper:getSize()
    local useMaxCount = warehouseWrapper:getUseMaxCount()
    count:SetText("(" .. itemCount .. "/" .. useMaxCount - 1 .. ")")
    count:SetShow(true)
    if itemCount < useMaxCount - 1 then
      count:SetFontColor(Defines.Color.C_FFDDC39E)
    else
      count:SetFontColor(Defines.Color.C_FFD05D48)
    end
    warehouseName:addInputEvent("Mouse_LUp", "HandleEventLUp_WareHouse_All_OtherTownsWareHouse(" .. waypointKey .. ")")
    warehouseName:addInputEvent("Mouse_On", "HandleEventMOn_Warehouse_All_SetAKeyGuide(false)")
  end
end
function PaGlobal_Warehouse_All_OpenByMaidCheck()
  return PaGlobal_WareHouse_All:isMaid()
end
function PaGlobal_Warehouse_All_CurrentWaypointKey()
  return PaGlobal_WareHouse_All._currentWaypointKey
end
function PaGlobal_Warehouse_All_IsMoveItem()
  if not (not PaGlobal_WareHouse_All:isNpc() and not PaGlobal_WareHouse_All:isInstallation() and PaGlobal_WareHouse_All:isWorldMapNode()) or PaGlobal_WareHouse_All:isDeliveryWindow() or PaGlobal_WareHouse_All:isGuildHouse() or PaGlobal_WareHouse_All:isMaid() or PaGlobal_WareHouse_All:isFurnitureWareHouse() then
    return true
  end
  return false
end
function PaGlobal_Warehouse_All_UpdateInventoryBag(addFlag)
  if addFlag then
    PaGlobal_WareHouse_All:update()
  end
end
function PaGlobal_Warehouse_All_UpdateInventory()
  if false == PaGlobal_WareHouse_All_GetShow() then
    return
  end
  if true == _ContentsGroup_InvenUpdateCheck and false == PaGlobal_WareHouse_All_GetShow() then
    return
  end
  PaGlobal_WareHouse_All:update()
end
function PaGlobal_Warehouse_All_FurnitureFilter(slotNo, notUse_itemWrappers, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  if true == itemWrapper:getStaticStatus():isItemInstallation() then
    return false
  end
  return true
end
function PaGlobal_WareHouse_All_GetShow()
  if nil == Panel_Window_Warehouse then
    return false
  end
  return Panel_Window_Warehouse:GetShow()
end
function PaGlobal_Warehouse_All_ItemComparer(ii, jj)
  return Global_ItemComparer(ii, jj, PaGlobal_Warehouse_All_GetItem)
end
function PaGlobal_Warehouse_All_CheckBoxSet(slotNo)
  warehouse_checkSellToSystem(slotNo)
  local warehouseWrapper = PaGlobal_WareHouse_All:getWarehouse()
  local isCheck = warehouseWrapper:isSellToSystem(slotNo)
  PaGlobal_WareHouse_All._slots[slotNo - 1].checkBox:SetCheck(isCheck)
  PaGlobal_WareHouse_All:update()
end
function PaGlobal_Warehouse_All_itemMarketFilterFunc(slot, itemWrapper)
  if nil == itemWrapper then
    return true
  end
  local isAble = requestIsRegisterItemForItemMarket(itemWrapper:get():getKey())
  return not isAble
end
function PaGlobal_Warehouse_All_itemMarketRclickFunc(slotNo, itemWrapper, s64_count)
  if Defines.s64_const.s64_1 == s64_count then
    FGlobal_ItemMarketRegistItemFromInventory(1, slotNo, CppEnums.ItemWhereType.eWarehouse, PaGlobal_WareHouse_All._currentWaypointKey)
  else
    local masterInfo = getItemMarketMasterByItemEnchantKey(itemWrapper:get():getKey():get())
    if masterInfo ~= nil and s64_count > masterInfo:getMaxRegisterCount() then
      s64_count = masterInfo:getMaxRegisterCount()
    end
    Panel_NumberPad_Show(true, s64_count, slotNo, FGlobal_ItemMarketRegistItemFromInventory, nil, CppEnums.ItemWhereType.eWarehouse, nil, PaGlobal_WareHouse_All._currentWaypointKey)
  end
end
function PaGlobal_Warehouse_All_PushFromInventoryItem(s64_count, whereType, slotNo, fromActorKeyRaw)
  PaGlobal_WareHouse_All._targetActorKeyRaw = fromActorKeyRaw
  Panel_NumberPad_Show_MaxCount(true, s64_count, slotNo, PaGlobal_Warehouse_All_PushFromInventoryItemXXX, nil, whereType)
end
function PaGlobal_Warehouse_All_PushFromInventoryItemXXX(s64_count, slotNo, whereType)
  PaGlobal_WareHouse_All:pushFromInventoryItem(s64_count, slotNo, whereType)
end
function PaGlobal_Warehouse_All_PopToSomewhere(s64_count, slotNo, toActorKeyRaw)
  if nil == slotNo then
    return
  end
  PaGlobal_WareHouse_All._targetActorKeyRaw = toActorKeyRaw
  if PaGlobal_Warehouse_All_OpenByMaidCheck() then
    local warehouseWrapper = PaGlobal_WareHouse_All:getWarehouse()
    local itemWrapper = warehouseWrapper:getItem(slotNo)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      local weight = Int64toInt32(itemSSW:get()._weight) / 10000
      if false == itemSSW:isMoney() then
        if Int64toInt32(s64_count) < 0 then
          s64_count = toInt64(0, 2147483647)
        end
        s64_count = toInt64(0, math.min(math.floor(100 / weight), Int64toInt32(s64_count)))
      end
      if s64_count <= Defines.s64_const.s64_0 then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoMaidDeliveryCantHeavyItem"))
        return
      end
    end
  end
  Panel_NumberPad_Show(true, s64_count, slotNo, PaGlobal_Warehouse_All_PopToSomewhereXXX)
end
function PaGlobal_Warehouse_All_PopToSomewhereXXX(s64_count, slotNo)
  PaGlobal_WareHouse_All:popToSomewhere(s64_count, slotNo)
end
function PaGlobal_Warehouse_All_GroundClick(whereType, slotNo)
  if nil == slotNo then
    return
  end
  if false == Panel_Window_Warehouse:GetShow() then
    return
  end
  local warehouseWrapper = PaGlobal_WareHouse_All:getWarehouse()
  local itemWrapper = warehouseWrapper:getItem(slotNo)
  if nil == itemWrapper then
    return
  end
  s64_count = itemWrapper:get():getCount_s64()
  itemName = itemWrapper:getStaticStatus():getName()
  if Defines.s64_const.s64_1 == s64_count then
    PaGlobal_Warehouse_All_GroundClickMessage(Defines.s64_const.s64_1, slotNo)
  else
    Panel_NumberPad_Show(true, s64_count, slotNo, PaGlobal_Warehouse_All_GroundClickMessage)
  end
end
function PaGlobal_Warehouse_All_OtherWaypointKey(isWaypointKey)
  PaGlobal_WareHouse_All.savedWayPointKey = isWaypointKey
end
function PaGlobal_Warehouse_All_GroundClickMessage(s64_count, slotNo)
  PaGlobal_WareHouse_All._deleteSlotNo = slotNo
  PaGlobal_WareHouse_All._s64_deleteCount = s64_count
  local luaDeleteItemMsg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DELETEITEM_MSG", "itemName", itemName, "itemCount", tostring(s64_count))
  local luaDelete = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DELETE")
  local messageContent = luaDeleteItemMsg
  local messageboxData = {
    title = luaDelete,
    content = messageContent,
    functionYes = PaGlobal_Warehouse_All_DeleteYes,
    functionNo = PaGlobal_Warehouse_All_DeleteNo,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_Warehouse_All_DeleteYes()
  if nil == PaGlobal_WareHouse_All._deleteSlotNo then
    return
  end
  local warehouseWrapper = PaGlobal_WareHouse_All:getWarehouse()
  local itemWrapper = warehouseWrapper:getItem(PaGlobal_WareHouse_All._deleteSlotNo)
  if nil == itemWrapper then
    return
  end
  if itemWrapper:isCash() then
    PaymentPassword(PaGlobal_Warehouse_All_DeleteYesXXX)
    return
  end
  PaGlobal_Warehouse_All_DeleteYesXXX()
end
function PaGlobal_Warehouse_All_DeleteYesXXX()
  if PaGlobal_WareHouse_All:isNpc() then
    warehouse_deleteItemByNpc(PaGlobal_WareHouse_All._deleteSlotNo, PaGlobal_WareHouse_All._s64_deleteCount)
  elseif PaGlobal_WareHouse_All:isInstallation() then
    warehouse_deleteItemByInstallation(PaGlobal_WareHouse_All._installationActorKeyRaw, PaGlobal_WareHouse_All._deleteSlotNo, PaGlobal_WareHouse_All._s64_deleteCount)
  end
  PaGlobal_WareHouse_All._deleteSlotNo = nil
  PaGlobal_WareHouse_All._s64_deleteCount = Defines.s64_const.s64_0
  DragManager:clearInfo()
end
function PaGlobal_Warehouse_All_DeleteNo()
  PaGlobal_WareHouse_All._deleteSlotNo = nil
  PaGlobal_WareHouse_All._s64_deleteCount = Defines.s64_const.s64_0
end
function PaGlobal_Warehouse_All_SetIgnoreMoneyButton(setIgnore)
  if setIgnore == true then
    PaGlobal_WareHouse_All._ui._btn_money:SetIgnore(true)
    PaGlobal_WareHouse_All._buttonData.sendMoney = false
    Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  else
    PaGlobal_WareHouse_All._ui._btn_money:SetIgnore(false)
    PaGlobal_WareHouse_All._buttonData.sendMoney = true
    if CppEnums.WarehoouseFromType.eWarehoouseFromType_Manufacture == PaGlobal_WareHouse_All._fromType then
      PaGlobal_WareHouse_All._ui._console._txt_keyGuideSilver:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CONFIRM"))
      if true == _ContentsGroup_NewUI_Manufacture_All then
        Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Manufacture_All_RepeatAction(false)")
      else
        Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_ManufactureDo()")
      end
    else
      PaGlobal_WareHouse_All._ui._console._txt_keyGuideSilver:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WAREHOUSE_PUTOUTMONEY"))
      Panel_Window_Warehouse:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Warehouse_All_PopMoney()")
    end
  end
  PaGlobal_WareHouse_All:updateButtonInfo()
end
function PaGlobal_Warehouse_All_OpenPanelFromDialog()
  PaGlobal_WareHouse_All:openPanelFromDialog()
end
function PaGlobal_Warehouse_All_OpenPanelFromDialogWithoutInventory(waypointKey, fromType)
  PaGlobal_WareHouse_All:openPanelFromDialogWithoutInventory(waypointKey, fromType)
end
function PaGlobal_Warehouse_All_OpenPanelFromWorldmap(waypointKey, fromType)
  PaGlobal_WareHouse_All:openPanelFromWorldmap(waypointKey, fromType)
end
function PaGlobal_Warehouse_All_OpenPanelFromMaid()
  PaGlobal_WareHouse_All:openPanelFromMaid()
end
function PaGlobal_Warehouse_All_OpenPanel(waypointKey, fromType)
  PaGlobal_WareHouse_All:openPanel(waypointKey, fromType)
end
function PaGlobal_Warehouse_All_ReloadbyWaypointKey()
  warehouse_requestInfo(PaGlobal_WareHouse_All._currentWaypointKey)
end
function PaGlobal_Warehouse_All_OpenWithInventory(filterFunc)
  PaGlobal_WareHouse_All:openWithInventory(filterFunc)
end
function PaGlobal_Warehouse_All_OpenPanelFromManufacture()
  PaGlobal_WareHouse_All:openPanel(getCurrentWaypointKey(), CppEnums.WarehoouseFromType.eWarehoouseFromType_Manufacture)
end
function PaGlobal_Warehouse_All_Close()
  PaGlobal_WareHouse_All:prepareClose()
end
function PaGlobal_Warehouse_All_GetWarehouseWarpper()
  return PaGlobal_WareHouse_All:getWarehouse()
end
function PaGlobal_Warehouse_All_UpdateSlotData()
  FromClient_Warehouse_All_Update()
end
function PaGlobal_Warehouse_All_SetFunctor(filterFunc, rClickFunc)
  PaGlobal_WareHouse_All:setfunctor(filterFunc, rClickFunc)
end
function PaGlobal_Warehouse_All_ResetFilter()
  PaGlobal_WareHouse_All:resetFilter()
end
function PaGlobal_Warehouse_All_SearchMenuTerritoryOpen(territoryKey, isFirstOpen)
  PaGlobal_WareHouse_All:searchMenuTerritoryOpen(territoryKey, isFirstOpen)
end
function HandleEventLUp_WareHouse_All_OtherTownsWareHouse(waypointKey)
  PaGlobal_WareHouse_All:otherTownsWareHouse(waypointKey)
end
function PaGlobal_WareHouse_All_SearchMenuOpen()
  PaGlobal_WareHouse_All:searchMenuOpen()
end
function PaGlobal_WareHouse_All_SearchMenuClose()
  PaGlobal_WareHouse_All:searchMenuClose()
end
function PaGlobal_Warehouse_All_TownListCheck()
  PaGlobal_WareHouse_All:townListCheck()
end
