function PaGlobal_Looting_All:initialize()
  if true == PaGlobal_Looting_All._initialize then
    return
  end
  self._ui._stc_bg = UI.getChildControl(Panel_Window_Looting_All, "Static_Money")
  self._ui._btn_lootAll = UI.getChildControl(Panel_Window_Looting_All, "Button_LootAll")
  self._ui._btn_cancel = UI.getChildControl(Panel_Window_Looting_All, "Button_Cancel")
  self._ui._btn_lootAllServant = UI.getChildControl(Panel_Window_Looting_All, "Button_LootAllToServant")
  self._defaultBgSize.x = self._ui._stc_bg:GetSizeX()
  self._defaultBgSize.y = self._ui._stc_bg:GetSizeY()
  self._defaultPanelSize.x = Panel_Window_Looting_All:GetSizeX()
  self._defaultPanelSize.y = Panel_Window_Looting_All:GetSizeY()
  Panel_Window_Looting_All:SetShow(false, false)
  Panel_Window_Looting_All:setMaskingChild(true)
  Panel_Window_Looting_All:ActiveMouseEventEffect(false)
  Panel_Window_Looting_All:setGlassBackground(true)
  self:initialize_Slot()
  PaGlobal_Looting_All:registEventHandler()
  PaGlobal_Looting_All:validate()
  PaGlobal_Looting_All._initialize = true
end
function PaGlobal_Looting_All:registEventHandler()
  if nil == Panel_Window_Looting_All then
    return
  end
  Panel_Window_Looting_All:RegisterShowEventFunc(true, "PaGloabl_Looting_All_ShowAni()")
  self._ui._btn_lootAll:addInputEvent("Mouse_LUp", "HandleEventLUp_Looting_All_LootAll(true)")
  self._ui._btn_cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_Looting_All_Cancel()")
  self._ui._btn_lootAllServant:addInputEvent("Mouse_LUp", "HandleEventLUp_Looting_All_ServantLootAll()")
  registerEvent("EventLootingWindowUpdate", "FromClient_Looting_All_Update")
  registerEvent("EventLootingCancel", "FromClient_Looting_All_Cancel")
end
function PaGlobal_Looting_All:prepareOpen()
  if nil == Panel_Window_Looting_All then
    return
  end
  if true == PaGloabl_Looting_All_GetShowPanel() then
    return
  end
  self._isSizeSetting = false
  PaGlobal_Looting_All:open()
end
function PaGlobal_Looting_All:open()
  if nil == Panel_Window_Looting_All then
    return
  end
  Panel_Window_Looting_All:SetShow(true, true)
end
function PaGlobal_Looting_All:prepareClose()
  if nil == Panel_Window_Looting_All then
    return
  end
  if false == PaGloabl_Looting_All_GetShowPanel() then
    return
  end
  self._isSizeSetting = false
  self:initSelectSlotNo()
  self._ui._btn_lootAll:ClearDisableTime()
  Panel_Tooltip_Item_hideTooltip()
  CheckChattingInput()
  looting_cancel()
  Panel_NumberPad_Close()
  PaGlobal_Looting_All:close()
end
function PaGlobal_Looting_All:close()
  if nil == Panel_Window_Looting_All then
    return
  end
  Panel_Window_Looting_All:SetShow(false, false)
end
function PaGlobal_Looting_All:validate()
  if nil == Panel_Window_Looting_All then
    return
  end
  self._ui._stc_bg:isValidate()
  self._ui._btn_lootAll:isValidate()
  self._ui._btn_cancel:isValidate()
  self._ui._btn_lootAllServant:isValidate()
end
function PaGlobal_Looting_All:initialize_Slot()
  self._slotBgBases = Array.new()
  self._slots = Array.new()
  for i = 1, self._config._slotCount do
    local row = math.floor((i - 1) / self._config._slotCols)
    local col = (i - 1) % self._config._slotCols
    local looting_SlotBGBase = UI.getChildControl(Panel_Window_Looting_All, "Static_Texture_Slot_Background")
    local slotBgBase = UI.cloneControl(looting_SlotBGBase, Panel_Window_Looting_All, "slot_Background_" .. i)
    local slotIconBase = UI.getChildControl(slotBgBase, "Static_SlotIcon")
    local looting_SlotBG = UI.createControl(__ePAUIControl_Static, Panel_Window_Looting_All, "looting_SlotBG_" .. i)
    CopyBaseProperty(slotIconBase, looting_SlotBG)
    local slotNo = i - 1
    local slot = {}
    SlotItem.new(slot, "Looting_item_" .. slotNo, slotNo, Panel_Window_Looting_All, self._slotConfig)
    slot:createChild()
    slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Looting_All_SelectSlot(" .. slotNo .. ")")
    slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Looting_All_SelectSlot(" .. slotNo .. ")")
    slot.icon:addInputEvent("Mouse_On", "Panel_Tooltip_Item_Show_GeneralNormal(" .. slotNo .. ", \"looting\",true)")
    slot.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralNormal(" .. slotNo .. ", \"looting\",false)")
    Panel_Tooltip_Item_SetPosition(slotNo, slot, "looting")
    local posX = self._config._slotBGStartX + self._config._slotGapX * col
    local posY = self._config._slotBGStartY + self._config._slotGapY * row + 3
    slotBgBase:SetPosX(posX)
    slotBgBase:SetPosY(posY)
    slotBgBase:SetShow(true)
    looting_SlotBG:SetShow(true)
    looting_SlotBG:SetIgnore(false)
    slot.icon:SetPosX(self._config._slotStartX + self._config._slotGapX * col)
    slot.icon:SetPosY(self._config._slotStartY + self._config._slotGapY * row + 3)
    slot.icon:SetIgnore(false)
    self._slotBgBases[i] = slotBgBase
    self._slots[i] = slot
  end
end
function PaGlobal_Looting_All:lootingUpdate(isEmpty)
  if true == _ContentsGroup_UsePadSnapping then
    looting_pickAllItemToPlayer()
    audioPostEvent_SystemUi(3, 9)
    _AudioPostEvent_SystemUiForXBOX(3, 9)
    return
  end
  self._ui._btn_lootAll:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LOOTING_BTN_GETALL"))
  if 1 == isEmpty then
    self:prepareClose()
  else
    self:prepareOpen()
  end
  local itemCount = 0
  for i = 1, self._config._slotCount do
    local slot = self._slots[i]
    local bgSlot = self._slotBgBases[i]
    local index = i - 1
    local itemWrapper = looting_getItem(index)
    if nil ~= itemWrapper then
      slot:setItem(itemWrapper)
      itemCount = itemCount + 1
    else
      if index == self._selectSlotNo then
        Panel_Tooltip_Item_Show_GeneralNormal(self._selectSlotNo, "looting", false)
      end
      slot:clearItem()
    end
    if false == self._isSizeSetting then
      bgSlot:SetShow(true)
      slot.icon:SetIgnore(false)
    end
  end
  if true == self._isSizeSetting then
    return
  end
  local rowCount = math.ceil(itemCount / self._config._slotCols)
  rowCount = math.max(rowCount, self._config._minslotRow)
  local slotBGSizeY = self._config._slotBGGap + self._config._slotGapY * rowCount
  local minusPannelSize = self._defaultBgSize.y - slotBGSizeY
  for i = self._config._slotCols * rowCount + 1, self._config._slotCount do
    self._slotBgBases[i]:SetShow(false)
    self._slots[i].icon:SetIgnore(true)
  end
  local panelSizeY = 0
  if true == looting_isPickItemToServant() then
    panelSizeY = self._defaultPanelSize.y - minusPannelSize
    self._ui._btn_lootAllServant:SetShow(true)
  else
    panelSizeY = self._defaultPanelSize.y - self._ui._btn_lootAllServant:GetSizeY() - minusPannelSize - 10
    self._ui._btn_lootAllServant:SetShow(false)
  end
  self._ui._stc_bg:SetSize(self._defaultBgSize.x, slotBGSizeY)
  Panel_Window_Looting_All:SetSize(self._defaultPanelSize.x, panelSizeY)
  self._ui._btn_lootAll:ComputePos()
  self._ui._btn_cancel:ComputePos()
  self._ui._btn_lootAllServant:ComputePos()
  self._isSizeSetting = true
end
function PaGlobal_Looting_All:selectItem(slotNo)
  self._selectSlotNo = slotNo
  local itemWrapper = looting_getItem(slotNo)
  if nil == itemWrapper then
    return
  end
  local s64_count = itemWrapper:get():getCount_s64()
  local itemKey = itemWrapper:get():getKey():getItemKey()
  local itemName = itemWrapper:getStaticStatus():getName()
  if 1 == itemKey then
    PaGlobal_Looting_All_LootSlotClick(s64_count, slotNo)
  else
    Panel_NumberPad_Show(true, s64_count, slotNo, PaGlobal_Looting_All_LootSlotClick)
  end
  audioPostEvent_SystemUi(3, 6)
  _AudioPostEvent_SystemUiForXBOX(3, 6)
end
function PaGlobal_Looting_All:initSelectSlotNo()
  self._selectSlotNo = self._SELECT_SLOTNO_INIT
end
