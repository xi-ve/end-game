function PaGlobal_ItemFilter_All:initialize()
  if true == PaGlobal_ItemFilter_All._initialize then
    return
  end
  self._ui._txt_title = UI.getChildControl(Panel_Window_ItemFilter_All, "Static_Text_Title")
  self._ui._btn_select = UI.getChildControl(Panel_Window_ItemFilter_All, "Button_Select")
  self._ui._btn_cancel = UI.getChildControl(Panel_Window_ItemFilter_All, "Button_Cancel")
  self._ui._stc_mainBG = UI.getChildControl(Panel_Window_ItemFilter_All, "Static_MainBG")
  self._ui._rdo_slotBG = UI.getChildControl(self._ui._stc_mainBG, "RadioButton_SlotBG")
  self._ui._txt_itemSpec = UI.getChildControl(Panel_Window_ItemFilter_All, "StaticText_ItemSpec")
  self._ui._stc_KeyGuideBG = UI.getChildControl(Panel_Window_ItemFilter_All, "Static_KeyGuide_Console")
  self._ui._txt_KeyGuideA = UI.getChildControl(self._ui._stc_KeyGuideBG, "StaticText_A_Console")
  self._ui._txt_KeyGuideB = UI.getChildControl(self._ui._stc_KeyGuideBG, "StaticText_B_Console")
  self._rdo_slots = {}
  self._itemSlots = {}
  self._ui._txt_itemSpec:SetTextMode(__eTextMode_AutoWrap)
  if true == _ContentsGroup_UsePadSnapping then
    self._ui._btn_cancel:SetShow(false)
    self._ui._btn_select:SetShow(false)
    local btnSizeY = self._ui._btn_select:GetSizeY()
    self._ui._txt_itemSpec:SetSpanSize(0, self._ui._txt_itemSpec:GetSpanSize().y - btnSizeY)
    self._ui._stc_KeyGuideBG:SetShow(true)
    PaGlobal_ItemFilter_All:setAlignKeyGuide()
  end
  PaGlobal_ItemFilter_All:registEventHandler()
  PaGlobal_ItemFilter_All:validate()
  PaGlobal_ItemFilter_All._initialize = true
end
function PaGlobal_ItemFilter_All:registEventHandler()
  if nil == Panel_Window_ItemFilter_All then
    return
  end
  if true == _ContentsGroup_UsePadSnapping then
    Panel_Window_ItemFilter_All:registerPadEvent(__eConsoleUIPadEvent_Up_B, "HandleEventMLUp_ItemFilter_Close()")
  else
    self._ui._btn_cancel:addInputEvent("Mouse_LUp", "HandleEventMLUp_ItemFilter_Close()")
    self._ui._btn_select:addInputEvent("Mouse_LUp", "HandleEventMLUp_ItemFilter_ItemUse()")
  end
  registerEvent("FromClient_InventoryUpdate", "FromClient_ItemFilter_All_UpdateInventory")
end
function PaGlobal_ItemFilter_All:prepareOpen(servantNo, isGuild, type)
  if nil == Panel_Window_ItemFilter_All then
    return
  end
  self._servantNo = servantNo
  self._eType = type
  self._isGuild = isGuild
  self:updateSlot(true)
  if true == _ContentsGroup_UsePadSnapping and #self._slotIdxList <= 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_NO_HAVE_ITEM"))
    return
  end
  Panel_Window_ItemFilter_All:ignorePadSnapMoveToOtherPanel()
  PaGlobal_ItemFilter_All:setAlignKeyGuide()
  PaGlobal_ItemFilter_All:open()
end
function PaGlobal_ItemFilter_All:open()
  if nil == Panel_Window_ItemFilter_All then
    return
  end
  Panel_Window_ItemFilter_All:SetShow(true)
end
function PaGlobal_ItemFilter_All:prepareClose()
  if nil == Panel_Window_ItemFilter_All then
    return
  end
  Panel_NumberPad_Show(false, Defines.s64_const.s64_0, 0, nil)
  PaGlobal_ItemFilter_All:close()
end
function PaGlobal_ItemFilter_All:close()
  if nil == Panel_Window_ItemFilter_All then
    return
  end
  Panel_Window_ItemFilter_All:SetShow(false)
end
function PaGlobal_ItemFilter_All:update()
  if nil == Panel_Window_ItemFilter_All then
    return
  end
end
function PaGlobal_ItemFilter_All:validate()
  if nil == Panel_Window_ItemFilter_All then
    return
  end
  self._ui._btn_select:isValidate()
  self._ui._btn_cancel:isValidate()
  self._ui._stc_mainBG:isValidate()
  self._ui._rdo_slotBG:isValidate()
  self._ui._txt_itemSpec:isValidate()
  self._ui._stc_KeyGuideBG:isValidate()
  self._ui._txt_KeyGuideA:isValidate()
  self._ui._txt_KeyGuideB:isValidate()
end
function PaGlobal_ItemFilter_All:setAlignKeyGuide()
  local keyGuides = {
    self._ui._txt_KeyGuideA,
    self._ui._txt_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_ItemFilter_All:updateSlot(isInit)
  if nil == getSelfPlayer() or nil == getSelfPlayer():get() then
    return
  end
  self._slotIdxList = Array.new()
  self:initRadioSlot()
  local selfPlayer = getSelfPlayer():get()
  local startSlot = inventorySlotNoUserStart()
  local useMaxCount = selfPlayer:getInventorySlotCount(false)
  for i = startSlot, useMaxCount - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, i)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      if nil ~= itemSSW and self._eType == itemSSW:getServantSupplyItemType() then
        local guildFliter = false
        if nil ~= itemSSW then
          if true == self._isGuild then
            guildFliter = true == itemSSW:isGuildStockable()
          else
            guildFliter = false == itemSSW:isGuildStockable()
          end
        end
        if true == guildFliter then
          local rdo_slot, slotItem = self:getRadioSlot()
          slotItem:setItem(itemWrapper, i, nil, nil)
          rdo_slot:SetShow(true)
          self._slotIdxList:push_back(i)
        end
      end
    end
  end
  if true == isInit then
    if nil ~= self._rdo_slots[1] and true == self._rdo_slots[1]:GetShow() then
      self._rdo_slots[1]:SetCheck(true)
    end
    self:updateItemSpecText(1)
  end
  if true == _ContentsGroup_UsePadSnapping then
    self:updateItemSpecText(self._currentSlotIndex)
  end
  self:resize(isInit)
end
function PaGlobal_ItemFilter_All:initRadioSlot()
  self._lastSlotIndex = 0
  for k, v in pairs(self._rdo_slots) do
    v:SetShow(false)
    v:SetCheck(false)
  end
end
function PaGlobal_ItemFilter_All:getCheckRadioIndex()
  for i = 1, #self._rdo_slots do
    if true == self._rdo_slots[i]:IsCheck() then
      return i
    end
  end
  return nil
end
function PaGlobal_ItemFilter_All:getRadioSlot()
  self._lastSlotIndex = self._lastSlotIndex + 1
  if nil == self._rdo_slots[self._lastSlotIndex] then
    self._rdo_slots[self._lastSlotIndex] = UI.cloneControl(self._ui._rdo_slotBG, self._ui._stc_mainBG, "RadioButton_SlotBG_" .. self._lastSlotIndex)
    local stc_slot = UI.getChildControl(self._rdo_slots[self._lastSlotIndex], "Static_Slot")
    local slot = {}
    SlotItem.new(slot, "ItemIcon_" .. self._lastSlotIndex, self._lastSlotIndex, stc_slot, self._slotConfig)
    slot:createChild()
    local index = self._lastSlotIndex - 1
    local row = math.floor(index / self._config.slotCols)
    local column = index % self._config.slotCols
    local posX = self._config.slotStartX + self._config.slotGapX * column
    local posY = self._config.slotStartY + self._config.slotGapY * row
    slot.icon:SetEnableDragAndDrop(true)
    slot.icon:SetAutoDisableTime(0.5)
    if true == _ContentsGroup_UsePadSnapping then
      self._rdo_slots[self._lastSlotIndex]:addInputEvent("Mouse_On", "HandleEventMLUp_ItemFilter_ItemSelect(" .. self._lastSlotIndex .. ")")
      self._rdo_slots[self._lastSlotIndex]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventMLUp_ItemFilter_ItemUse()")
    else
      slot.icon:addInputEvent("Mouse_On", "HandleEventMOn_ItemFilter_IconOver(" .. self._lastSlotIndex .. ")")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventMOut_ItemFilter_IconOut()")
      slot.icon:addInputEvent("Mouse_LUp", "HandleEventMLUp_ItemFilter_ItemSelect(" .. self._lastSlotIndex .. ")")
    end
    self._rdo_slots[self._lastSlotIndex]:SetPosX(posX)
    self._rdo_slots[self._lastSlotIndex]:SetPosY(posY)
    self._itemSlots[self._lastSlotIndex] = slot
  end
  return self._rdo_slots[self._lastSlotIndex], self._itemSlots[self._lastSlotIndex]
end
function PaGlobal_ItemFilter_All:resize()
  local lastIndex = self._lastSlotIndex
  if lastIndex <= 0 then
    lastIndex = 1
  end
  local row = math.floor((lastIndex - 1) / self._config.slotCols) + 1
  local itemSizeY = self._config.slotGapY * row
  local txtSizeY = self._ui._txt_itemSpec:GetTextSizeY()
  local btnSizeY = self._ui._btn_select:GetSizeY()
  local panelSizeY = 0
  if true == _ContentsGroup_UsePadSnapping then
    panelSizeY = itemSizeY + txtSizeY + self._ui._txt_title:GetSizeY() + 20
  else
    panelSizeY = itemSizeY + txtSizeY + btnSizeY + self._ui._txt_title:GetSizeY() + 20
  end
  self._ui._stc_mainBG:SetSize(self._ui._stc_mainBG:GetSizeX(), itemSizeY)
  self._ui._txt_itemSpec:SetSize(self._ui._txt_itemSpec:GetSizeX(), txtSizeY)
  Panel_Window_ItemFilter_All:SetSize(Panel_Window_ItemFilter_All:GetSizeX(), panelSizeY)
  self._ui._btn_select:ComputePos()
  self._ui._btn_cancel:ComputePos()
  self._ui._txt_itemSpec:ComputePos()
  self._ui._stc_KeyGuideBG:ComputePos()
end
function PaGlobal_ItemFilter_All:updateItemSpecText(selectIndex)
  local slotNo = PaGlobal_ItemFilter_All._slotIdxList[selectIndex]
  if nil == slotNo then
    self._ui._txt_itemSpec:SetShow(false)
    return
  end
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return
  end
  self._ui._txt_itemSpec:SetShow(true)
  local strText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEMFILTER_FOOD_DESC", "value", itemSSW:getServantSupplyItemValue())
  self._ui._txt_itemSpec:SetText(strText)
end
