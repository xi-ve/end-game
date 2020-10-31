function HandleEevnt_WareHouse_All_Search()
  if nil == Panel_Window_WareHouse_Search or true == Panel_Window_WareHouse_Search:GetShow() then
    return
  end
  if ToClient_WorldMapIsShow() then
    if nil ~= Panel_Window_Delivery_All and true == Panel_Window_Delivery_All:GetShow() then
      WorldMapPopupManager:popWantPanel(Panel_Window_Delivery_All)
    end
    if nil ~= Panel_Window_Barter_Search and true == Panel_Window_Barter_Search:GetShow() then
      WorldMapPopupManager:popWantPanel(Panel_Window_Barter_Search)
    end
    HandleEventLUp_WareHouse_Search_All_RunReset()
    WorldMapPopupManager:push(Panel_Window_WareHouse_Search, true)
  else
    PaGlobal_WareHouse_Search_All:prepareOpen()
  end
end
function PaGlobal_Warehouse_Search_All_Close()
  HandleEventLUp_WareHouse_Search_All_RunReset()
  ClearFocusEdit()
  PaGlobal_WareHouse_Search_All._isGuildWareHouse = false
  if ToClient_WorldMapIsShow() then
    WorldMapPopupManager:popWantPanel(Panel_Window_WareHouse_Search)
  else
    PaGlobal_WareHouse_Search_All:prepareClose()
  end
end
function HandleEventLUp_WareHouse_Search_All_ClickEdit()
  ClearFocusEdit()
  SetFocusEdit(PaGlobal_WareHouse_Search_All._ui.edit_Search)
end
function HandleEventLUp_WareHouse_Search_All_RunSearch()
  if false == _ContentsGroup_NewUI_WareHouse_Search_All then
    return
  end
  PaGlobal_WareHouse_Search_All._ui.txt_NoResult:SetShow(false)
  local searchStr = PaGlobal_WareHouse_Search_All._ui.edit_Search:GetEditText()
  PaGlobal_WareHouse_Search_All._curSearchString = searchStr
  if nil == searchStr or "" == searchStr then
    PaGlobal_WareHouse_Search_All:clearSearch()
    PaGlobal_WareHouse_Search_All._ui.txt_NoResult:SetShow(true)
    PaGlobal_WareHouse_Search_All._ui.edit_Search:SetEditText(PaGlobal_WareHouse_Search_All._curSearchString)
    return
  end
  if nil == PaGlobal_WareHouse_Search_All._curWayPointKey then
    PaGlobal_WareHouse_Search_All._curWayPointKey = getCurrentWaypointKey()
  end
  local regionInfoWrapper = ToClient_getRegionInfoWrapperByWaypoint(PaGlobal_WareHouse_Search_All._curWayPointKey)
  if nil == regionInfoWrapper then
    return
  end
  local regionName = regionInfoWrapper:getAreaName()
  local warehouseWrapper = warehouse_get(PaGlobal_WareHouse_Search_All._curWayPointKey)
  if true == PaGlobal_WareHouse_Search_All._isGuildWareHouse then
    warehouseWrapper = warehouse_getGuild()
    PaGlobal_WareHouse_Search_All._ui.stc_RegionName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_WAREHOUSE_SEARCH_ALL_GUILD"))
  else
    PaGlobal_WareHouse_Search_All._ui.stc_RegionName:SetText(regionName)
  end
  if nil == warehouseWrapper then
    PaGlobal_WareHouse_Search_All._ui.txt_NoResult:SetShow(true)
    PaGlobal_WareHouse_Search_All:clearSearch()
    PaGlobal_WareHouse_Search_All._ui.edit_Search:SetEditText(PaGlobal_WareHouse_Search_All._curSearchString)
    return
  end
  PaGlobal_WareHouse_Search_All._ui.txt_NoResult:SetShow(true)
  PaGlobal_WareHouse_Search_All:clearSearch()
  PaGlobal_WareHouse_Search_All._ui.edit_Search:SetEditText(PaGlobal_WareHouse_Search_All._curSearchString)
  PaGlobal_WareHouse_Search_All._ui.stc_RegionName:SetShow(true)
  local findItemCount = 0
  local findItemData = {}
  local itemCount = 0
  local useMaxCount = warehouseWrapper:getUseMaxCount()
  local maxCount = warehouseWrapper:getMaxCount()
  for itemSlotIndex = 1, maxCount - 1 do
    local itemWrapper = warehouseWrapper:getItem(itemSlotIndex)
    if nil ~= itemWrapper then
      local itemName = itemWrapper:getStaticStatus():getName()
      if stringSearch(itemName, searchStr) then
        local data = {
          itemIndex = nil,
          itemKey = nil,
          enchantLevel = nil,
          itemCount = 0,
          itemName = "",
          slotIndex = 0
        }
        findItemCount = findItemCount + 1
        data.itemKey = itemWrapper:get():getKey():getItemKey()
        data.itemCount = Int64toInt32(itemWrapper:get():getCount_s64())
        data.enchantLevel = itemWrapper:get():getKey():getEnchantLevel()
        data.itemName = itemName
        data.itemIndex = itemSlotIndex
        findItemData[findItemCount] = data
        PaGlobal_WareHouse_Search_All._ui.txt_NoResult:SetShow(false)
      end
    end
  end
  if 0 == findItemCount then
    PaGlobal_WareHouse_Search_All._ui.txt_NoResult:SetShow(true)
    PaGlobal_WareHouse_Search_All._ui.stc_RegionName:SetShow(false)
    PaGlobal_WareHouse_Search_All._ui.edit_Search:SetEditText(PaGlobal_WareHouse_Search_All._curSearchString)
    return
  end
  local slotIndex = 0
  local test = 0
  for index = 1, findItemCount do
    for checkIdx = 1, index do
      if 1 ~= index and findItemData[index].itemKey == findItemData[checkIdx].itemKey and findItemData[index].enchantLevel == findItemData[checkIdx].enchantLevel then
        findItemData[index].itemCount = findItemData[index].itemCount + findItemData[checkIdx].itemCount
        findItemData[checkIdx].itemCount = findItemData[index].itemCount
        if 0 ~= findItemData[checkIdx].slotIndex then
          PaGlobal_WareHouse_Search_All._itemSlot[findItemData[checkIdx].slotIndex].slot:updateCount(findItemData[index].itemCount)
          if 1 >= findItemData[index].itemCount then
            PaGlobal_WareHouse_Search_All._itemSlot[slotIndex].slot.count:SetShow(false)
          end
        end
        break
      elseif 1 == index or index - 1 == checkIdx then
        slotIndex = slotIndex + 1
        findItemData[index].slotIndex = slotIndex
        if nil == PaGlobal_WareHouse_Search_All._itemSlot[slotIndex] then
          local item = {
            count = 0,
            itemKey = nil,
            itemName = "",
            slotBG = nil,
            slot = nil
          }
          PaGlobal_WareHouse_Search_All._ui._icon_items = {}
          item.slotBG = UI.cloneControl(PaGlobal_WareHouse_Search_All._ui.stc_ItemSlotBg, PaGlobal_WareHouse_Search_All._ui.frameContent, "Static_ItemSlotBg_Template_" .. slotIndex)
          item.slot = SlotItem.new(PaGlobal_WareHouse_Search_All._ui._icon_items, "feeItem", nil, item.slotBG, PaGlobal_WareHouse_Search_All._slotConfig)
          item.slot:createChild()
          item.slot:clearItem()
          PaGlobal_WareHouse_Search_All._itemSlot[slotIndex] = item
          PaGlobal_WareHouse_Search_All._slotCount = PaGlobal_WareHouse_Search_All._slotCount + 1
        end
        local itemWrapper = warehouseWrapper:getItem(findItemData[index].itemIndex)
        if nil ~= itemWrapper then
          PaGlobal_WareHouse_Search_All._itemSlot[slotIndex].slot:setItemByStaticStatus(itemWrapper:getStaticStatus(), findItemData[index].itemCount)
          PaGlobal_WareHouse_Search_All._itemSlot[slotIndex].slot:updateCount(findItemData[index].itemCount)
          PaGlobal_WareHouse_Search_All._itemSlot[slotIndex].slotBG:SetShow(true)
          PaGlobal_WareHouse_Search_All._itemSlot[slotIndex].slot.enchantText:SetShow(true)
          PaGlobal_WareHouse_Search_All._itemSlot[slotIndex].slot.icon:addInputEvent("Mouse_On", "HandleEventOn_WareHouse_Search_All_ShowToolTip(true," .. findItemData[index].itemIndex .. ")")
          PaGlobal_WareHouse_Search_All._itemSlot[slotIndex].slot.icon:addInputEvent("Mouse_Out", "HandleEventOn_WareHouse_Search_All_ShowToolTip(false," .. findItemData[index].itemIndex .. ")")
          UIScroll.InputEventByControl(PaGlobal_WareHouse_Search_All._itemSlot[slotIndex].slot.icon, "HandleEvent_WareHouse_Search_All_Scroll")
        end
        break
      end
    end
  end
  for index = slotIndex + 1, PaGlobal_WareHouse_Search_All._slotCount do
    PaGlobal_WareHouse_Search_All._itemSlot[index].slotBG:SetShow(false)
  end
  local padding = 5
  local maxHorizon = 7
  PaGlobal_WareHouse_Search_All._maxRow = maxHorizon
  local vertical = 0
  for index = 1, slotIndex do
    local horizon = index
    if maxHorizon < horizon then
      horizon = index % maxHorizon
      vertical = math.floor(index / maxHorizon)
      if horizon == 0 then
        horizon = maxHorizon
        vertical = vertical - 1
        PaGlobal_WareHouse_Search_All._maxCol = vertical
      end
    end
    local posX = padding + (PaGlobal_WareHouse_Search_All._itemSlot[index].slotBG:GetSizeX() + padding) * (horizon - 1)
    local posY = padding * 3 + PaGlobal_WareHouse_Search_All._ui.stc_RegionName:GetSizeY() + (PaGlobal_WareHouse_Search_All._itemSlot[index].slotBG:GetSizeY() + padding) * vertical
    PaGlobal_WareHouse_Search_All._itemSlot[index].slotBG:SetPosX(posX)
    PaGlobal_WareHouse_Search_All._itemSlot[slotIndex].slot.icon:ComputePos()
    PaGlobal_WareHouse_Search_All._itemSlot[index].slotBG:SetPosY(posY)
    PaGlobal_WareHouse_Search_All._itemSlot[slotIndex].slot.icon:ComputePos()
  end
  PaGlobal_WareHouse_Search_All._maxSlotIndex = slotIndex
  HandleEvent_WareHouse_Search_All_Scroll(true)
  FromClient_Warehouse_All_Update()
  ClearFocusEdit()
end
function HandleEventLUp_WareHouse_Search_All_RunReset()
  PaGlobal_WareHouse_Search_All._curSearchString = nil
  PaGlobal_WareHouse_Search_All:clearSearch()
  if false == _ContentsGroup_UsePadSnapping then
    SetFocusEdit(PaGlobal_WareHouse_Search_All._ui.edit_Search)
  end
  Panel_Tooltip_Item_hideTooltip()
end
function HandleEventOn_WareHouse_Search_All_ShowToolTip(isShow, slotIndex)
  if true == isShow then
    local warehouseWrapper
    if true == PaGlobal_WareHouse_Search_All._isGuildWareHouse then
      warehouseWrapper = warehouse_getGuild()
    else
      local waypointKey = PaGlobal_WareHouse_Search_All._curWayPointKey
      if nil == waypointKey then
        return
      end
      warehouseWrapper = warehouse_get(waypointKey)
    end
    if nil == warehouseWrapper then
      return
    end
    local itemWrapper = warehouseWrapper:getItem(slotIndex)
    if nil == itemWrapper then
      return
    end
    Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_WareHouse_Search, false, true, nil)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function HandleEvent_WareHouse_Search_All_Scroll(isUp)
  if 0 == PaGlobal_WareHouse_Search_All._slotCount then
    return
  end
  local scrollControl = PaGlobal_WareHouse_Search_All._ui.verticalScroll
  local row = PaGlobal_WareHouse_Search_All._maxRow
  local col = PaGlobal_WareHouse_Search_All._maxCol
  local contentsCount = PaGlobal_WareHouse_Search_All._slotCount
  local startSlot = PaGlobal_WareHouse_Search_All._startSlotIndex
  UIScroll.SetButtonSize(scrollControl, contentsCount, contentsCount - startSlot)
  PaGlobal_WareHouse_Search_All._startSlotIndex = UIScroll.ScrollEvent(scrollControl, isUp, row, contentsCount, startSlot, col)
  PaGlobal_WareHouse_Search_All._ui.frame_Result:UpdateContentScroll()
  PaGlobal_WareHouse_Search_All._ui.frame_Result:UpdateContentPos()
end
function FromClient_WareHouse_Search_All_Update()
  if nil == PaGlobal_WareHouse_Search_All._curSearchString or "" == PaGlobal_WareHouse_Search_All._curSearchString then
    return
  end
  PaGlobal_WareHouse_Search_All._ui.edit_Search:SetEditText(PaGlobal_WareHouse_Search_All._curSearchString)
  HandleEventLUp_WareHouse_Search_All_RunSearch()
end
function PaGlobal_WareHouse_Search_All_SetCurrentWayPointKey(wayPointKey)
  PaGlobal_WareHouse_Search_All._curWayPointKey = wayPointKey
  HandleEventLUp_WareHouse_Search_All_RunReset()
end
function PaGlobal_WareHouse_Search_All_GetSearchString()
  if nil == PaGlobal_WareHouse_Search_All._curSearchString or "" == PaGlobal_WareHouse_Search_All._curSearchString then
    return nil
  end
  return PaGlobal_WareHouse_Search_All._curSearchString
end
function PaGlobal_WareHouse_Search_All_OpenGuildWareHouse()
  PaGlobal_WareHouse_Search_All._isGuildWareHouse = true
end
