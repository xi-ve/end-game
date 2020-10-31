function PaGlobal_ServantUpgrade:init()
  self._ui._btn_close = UI.getChildControl(self._ui._titleBar, "Button_Close")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantUpgrade_Cancel()")
  self._ui._btn_doUpgrade:addInputEvent("Mouse_LUp", "PaGlobal_ServantUpgrade:doServantUpgrade()")
  self._ui._btn_cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantUpgrade_Cancel()")
  local newSlotBg = UI.getChildControl(self._ui._mainBg, "Static_NewShipSlotBG")
  local newSlot = {
    icon = nil,
    name = nil,
    kind = nil
  }
  newSlot.icon = UI.getChildControl(newSlotBg, "Static_NewShipSlotIcon")
  newSlot.name = UI.getChildControl(newSlotBg, "StaticText_TopDesc")
  newSlot.kind = UI.getChildControl(newSlotBg, "StaticText_NewShipKind")
  self._ui._newSlot = newSlot
  self._ui._fromMainItem = Array.new()
  for ii = 0, __eServantUpgradeMainFromItemCount - 1 do
    local slot = {
      bg = nil,
      icon = nil,
      slotIcon = {}
    }
    slot.bg = UI.getChildControl(self._ui._mainBg, "Static_EquipIcon" .. tostring(ii + 1) .. "_BG")
    slot.icon = UI.getChildControl(slot.bg, "Static_ItemSlot")
    SlotItem.new(slot.slotIcon, "MainItemIcon_" .. tostring(ii), ii, slot.icon, self._slotConfig)
    slot.slotIcon:createChild()
    slot.slotIcon.icon:SetPosY(1)
    slot.slotIcon.icon:addInputEvent("Mouse_On", "PaGlobal_ServantUpgrade:itemTooltip_Show(" .. ii .. ")")
    slot.slotIcon.icon:addInputEvent("Mouse_Out", "PaGlobal_ServantUpgrade:itemTooltip_Hide()")
    self._ui._fromMainItem[ii] = slot
  end
  self._ui._fromSubItem = Array.new()
  for ii = 0, __eServantUpgradeSubFromItemCount - 1 do
    local slot = {
      bg = nil,
      txt = nil,
      lock = nil,
      slotIcon = {}
    }
    slot.bg = UI.getChildControl(self._ui._mainBg, "Static_MaterialIcon" .. tostring(ii + 1) .. "_BG")
    slot.txt = UI.getChildControl(slot.bg, "StaticText_NeedItemCount")
    slot.lock = UI.getChildControl(slot.bg, "Static_LockIcon")
    SlotItem.new(slot.slotIcon, "SubItemIcon_" .. tostring(ii), ii, slot.bg, self._slotConfig)
    slot.slotIcon:createChild()
    slot.slotIcon.icon:addInputEvent("Mouse_On", "PaGlobal_ServantUpgrade:itemTooltip_Show(" .. __eServantUpgradeMainFromItemCount + ii .. ")")
    slot.slotIcon.icon:addInputEvent("Mouse_Out", "PaGlobal_ServantUpgrade:itemTooltip_Hide()")
    self._ui._fromSubItem[ii] = slot
  end
  self._ui._btn_prev = UI.getChildControl(self._ui._mainBg, "Button_DecoArroW_L")
  self._ui._btn_next = UI.getChildControl(self._ui._mainBg, "Button_DecoArrow_R")
  self._ui._btn_prev:addInputEvent("Mouse_LUp", "PaGlobal_ServantUpgrade:handleClickedPrevButton()")
  self._ui._btn_next:addInputEvent("Mouse_LUp", "PaGlobal_ServantUpgrade:handleClickedNextButton()")
  self._ui._txt_index = UI.getChildControl(self._ui._mainBg, "StaticText_SlotCount")
  self._ui._btn_upgradeInfo = UI.getChildControl(self._ui._mainBg, "Button_AdditionalInfo")
  self._ui._btn_upgradeInfo:addInputEvent("Mouse_LUp", "PaGlobal_ServantUpgrade:handleClickedUpgradeInfoButton()")
  self._ui._txt_ready = UI.getChildControl(self._ui._stateBg, "StaticText_ReadytoTry")
  self._ui._txt_notReady = UI.getChildControl(self._ui._stateBg, "StaticText_NotReadyyet")
  self._ui._progressBar = UI.getChildControl(self._ui._progressGroup, "Progress2_2")
  self._ui._txt_progressPct = UI.getChildControl(self._ui._progressGroup, "StaticText_Percent")
  self._ui._bigCircle = UI.getChildControl(self._ui._progressGroup, "Static_BigCircle")
  self._ui._smallCircle = UI.getChildControl(self._ui._progressGroup, "Static_SmallCircle")
  self._ui._txt_desc = UI.getChildControl(Panel_Window_ServantUpgrade, "StaticText_Desc")
  local origin_descY = self._ui._txt_desc:GetSizeY()
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPINFO_EXTEND_INFOSTRING"))
  local gapY = 5
  if origin_descY < self._ui._txt_desc:GetTextSizeY() + gapY then
    local addSizeY = self._ui._txt_desc:GetTextSizeY() + gapY - origin_descY
    self._ui._txt_desc:SetSize(self._ui._txt_desc:GetSizeX(), origin_descY + addSizeY)
    Panel_Window_ServantUpgrade:SetSize(Panel_Window_ServantUpgrade:GetSizeX(), Panel_Window_ServantUpgrade:GetSizeY() + addSizeY)
    self._ui._txt_desc:ComputePos()
    self._ui._btn_doUpgrade:ComputePos()
    self._ui._btn_cancel:ComputePos()
  end
  local progressSlot = {
    icon = nil,
    name = nil,
    kind = nil
  }
  progressSlot.icon = UI.getChildControl(self._ui._progressBg, "Static_NewShipSlotIcon")
  progressSlot.name = UI.getChildControl(self._ui._progressBg, "StaticText_TopDesc")
  progressSlot.kind = UI.getChildControl(self._ui._progressBg, "StaticText_NewShipKind")
  self._ui._progressSlot = progressSlot
end
function PaGlobal_ServantUpgrade:clear()
  self._servantNo_s64 = nil
  self._fromCharacterKey = nil
  self._toCharacterKey = nil
  self._toCharacterKeyList = nil
  self._selectIndex = 0
  self._maxIndex = 0
  self._isUpgradable = true
  ToClient_clearServantUpgradeSlotNoList()
  self:cancelClear()
  self._ui._bigCircle:SetVertexAniRun("Ani_Rotate_New", false)
  self._ui._smallCircle:SetVertexAniRun("Ani_Rotate_New", false)
end
function PaGlobal_ServantUpgrade:cancelClear()
  self._updateCurrentTime = 0
  self._isProgressing = false
  self._ui._txt_progressPct:SetText("")
  self._ui._progressBar:SetProgressRate(0)
  self._ui._mainBg:SetShow(true)
  self._ui._stateBg:SetShow(true)
  self._ui._btn_prev:SetShow(true)
  self._ui._btn_next:SetShow(true)
  self._ui._txt_index:SetShow(true)
  self._ui._progressGroup:SetShow(false)
  self._ui._progressBg:SetShow(false)
end
function PaGlobal_ServantUpgrade:open(servantNo_s64, fromCharacterKey, servantName)
  if false == _ContentsGroup_Barter then
    return
  end
  if true == Panel_Window_ServantUpgrade:GetShow() then
    return
  end
  local characterSSW = ToClient_GetCharacterStaticStatusWrapper(fromCharacterKey)
  if nil == characterSSW then
    return
  end
  self:clear()
  self._servantNo_s64 = servantNo_s64
  self._fromCharacterKey = fromCharacterKey
  self._ui._newSlot.name:SetText(servantName)
  self._ui._progressSlot.name:SetText(servantName)
  self._toCharacterKeyList = ToClient_servantUpgradeCharacterKeyList(self._fromCharacterKey)
  if nil == self._toCharacterKeyList then
    return
  end
  self._maxIndex = #self._toCharacterKeyList
  self:selectIndex(0)
  Panel_Window_ServantUpgrade:SetShow(true)
end
function PaGlobal_ServantUpgrade:close()
  PaGlobal_ServantUpgradeInfo:close()
  PaGlobal_ServantUpgrade:itemTooltip_Hide()
  Panel_Window_ServantUpgrade:ClearUpdateLuaFunc("Update_ServantUpgrade_ProgressBar")
  Panel_Window_ServantUpgrade:SetShow(false)
end
function PaGlobal_ServantUpgrade:doServantUpgrade()
  if true == self._isProgressing then
    return
  end
  if false == self._isUpgradable then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoInventoryNotEnoughItem"))
    return
  end
  if 0 < ToClient_GetEmployeeCountByServant(self._servantNo_s64) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantServantUpgradeEmployee"))
    return
  end
  local servantInfo = stable_getServantByServantNo(self._servantNo_s64)
  for _, v in pairs(PaGlobal_ShipInfo_All._equipSlotNo) do
    local itemWrapper = servantInfo:getEquipItem(v)
    if nil ~= itemWrapper then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoExistItemInVehicle"))
      return
    end
  end
  self._ui._mainBg:SetShow(false)
  self._ui._stateBg:SetShow(false)
  self._ui._btn_prev:SetShow(false)
  self._ui._btn_next:SetShow(false)
  self._ui._txt_index:SetShow(false)
  self._ui._progressGroup:SetShow(true)
  self._ui._progressBg:SetShow(true)
  self._ui._bigCircle:SetVertexAniRun("Ani_Rotate_New", true)
  self._ui._smallCircle:SetVertexAniRun("Ani_Rotate_New", true)
  self._isProgressing = true
  Panel_Window_ServantUpgrade:RegisterUpdateFunc("Update_ServantUpgrade_ProgressBar")
end
function PaGlobal_ServantUpgrade:progressBarUpdateComplete()
  Panel_Window_ServantUpgrade:ClearUpdateLuaFunc("Update_ServantUpgrade_ProgressBar")
  self._isProgressing = false
  self:close()
  ToClient_requestServantUpgrade(self._servantNo_s64, self._toCharacterKey)
end
function PaGlobal_ServantUpgrade:selectToServant(toCharacterKey)
  self._toCharacterKey = nil
  self._isUpgradable = true
  local characterSSW = ToClient_GetCharacterStaticStatusWrapper(toCharacterKey)
  if nil == characterSSW then
    return
  end
  local servantUpgradeWrapper = ToClient_ServantUpgradeStaticStatusWrapper(self._fromCharacterKey, toCharacterKey)
  if nil == servantUpgradeWrapper then
    return
  end
  local toWrapper = ToClient_FormStaticStatusWrapper(toCharacterKey)
  if nil ~= toWrapper then
    self._ui._newSlot.icon:ChangeTextureInfoName(toWrapper:getIcon1())
    self._ui._progressSlot.icon:ChangeTextureInfoName(toWrapper:getIcon1())
  end
  for ii = 0, __eServantUpgradeMainFromItemCount - 1 do
    self._ui._fromMainItem[ii].slotIcon.icon:SetMonoTone(false, false)
    local itemEnchantKey = servantUpgradeWrapper:getFromItemEnchantKey(ii)
    local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
    if nil ~= itemSSW then
      self._ui._fromMainItem[ii].slotIcon:setItemByStaticStatus(itemSSW)
      local slotNo = ToClient_InventoryGetSlotNo(itemEnchantKey)
      if __eTInventorySlotNoUndefined == slotNo then
        self._ui._fromMainItem[ii].slotIcon.icon:SetMonoTone(true, true)
        self._isUpgradable = false
      else
        ToClient_setServantUpgradeSlotNo(ii, slotNo)
      end
    end
  end
  for ii = 0, __eServantUpgradeSubFromItemCount - 1 do
    local index = __eServantUpgradeMainFromItemCount + ii
    self._ui._fromSubItem[ii].slotIcon.icon:SetMonoTone(true, true)
    local itemEnchantKey = servantUpgradeWrapper:getFromItemEnchantKey(index)
    local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
    if nil ~= itemSSW then
      local needItemCount_s64 = servantUpgradeWrapper:getFromItemCount(index)
      local myItemCount_s64 = toInt64(0, 0)
      self._ui._fromSubItem[ii].slotIcon:setItemByStaticStatus(itemSSW)
      local slotNo = ToClient_InventoryGetSlotNo(itemEnchantKey)
      if __eTInventorySlotNoUndefined ~= slotNo then
        local itemWrapper = getInventoryItem(slotNo)
        if nil ~= itemWrapper and false == itemWrapper:empty() then
          myItemCount_s64 = itemWrapper:getCount()
          if needItemCount_s64 <= myItemCount_s64 then
            self._ui._fromSubItem[ii].slotIcon.icon:SetMonoTone(false, false)
            ToClient_setServantUpgradeSlotNo(index, slotNo)
            myItemCount_s64 = needItemCount_s64
          else
            self._isUpgradable = false
          end
        else
          self._isUpgradable = false
        end
      else
        self._isUpgradable = false
      end
      if needItemCount_s64 <= myItemCount_s64 then
        self._ui._fromSubItem[ii].txt:SetFontColor(Defines.Color.C_FF83A543)
      else
        self._ui._fromSubItem[ii].txt:SetFontColor(Defines.Color.C_FFD05D48)
      end
      self._ui._fromSubItem[ii].txt:SetText(tostring(myItemCount_s64) .. "/" .. tostring(needItemCount_s64))
      self._ui._fromSubItem[ii].lock:SetShow(false)
    else
      self._ui._fromSubItem[ii].txt:SetText("")
      self._ui._fromSubItem[ii].slotIcon:clearItem()
      self._ui._fromSubItem[ii].lock:SetShow(true)
    end
  end
  if false == self._isUpgradable then
    self._ui._txt_ready:SetShow(false)
    self._ui._txt_notReady:SetShow(true)
    self._ui._btn_doUpgrade:SetMonoTone(true)
  else
    self._ui._txt_ready:SetShow(true)
    self._ui._txt_notReady:SetShow(false)
    self._ui._btn_doUpgrade:SetMonoTone(false)
  end
  self._toCharacterKey = toCharacterKey
  self._ui._newSlot.kind:SetText(characterSSW:getName())
  self._ui._progressSlot.kind:SetText(characterSSW:getName())
end
function PaGlobal_ServantUpgrade:itemTooltip_Show(index)
  local servantUpgradeWrapper = ToClient_ServantUpgradeStaticStatusWrapper(self._fromCharacterKey, self._toCharacterKey)
  if nil == servantUpgradeWrapper then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(servantUpgradeWrapper:getFromItemEnchantKey(index))
  if nil ~= itemSSW then
    local control
    if index < __eServantUpgradeMainFromItemCount then
      control = self._ui._fromMainItem[index].icon
    else
      control = self._ui._fromSubItem[index - __eServantUpgradeMainFromItemCount].slotIcon.icon
    end
    if nil ~= control then
      Panel_Tooltip_Item_Show(itemSSW, control, true)
    end
  end
end
function PaGlobal_ServantUpgrade:itemTooltip_Hide()
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_ServantUpgrade:selectIndex(index)
  if nil == self._toCharacterKeyList then
    return
  end
  if index < 0 or index > #self._toCharacterKeyList then
    return
  end
  self._selectIndex = index
  self:selectToServant(self._toCharacterKeyList[self._selectIndex]:get())
  self._ui._txt_index:SetText(tostring(self._selectIndex + 1) .. "/" .. tostring(self._maxIndex + 1))
  if self._maxIndex == 0 then
    self._ui._btn_prev:SetShow(false)
    self._ui._btn_next:SetShow(false)
  elseif index <= 0 then
    self._ui._btn_prev:SetShow(false)
    self._ui._btn_next:SetShow(true)
  elseif index >= self._maxIndex then
    self._ui._btn_prev:SetShow(true)
    self._ui._btn_next:SetShow(false)
  else
    self._ui._btn_prev:SetShow(true)
    self._ui._btn_next:SetShow(true)
  end
  if true == Panel_Window_ServantUpgradeInfo:GetShow() then
    PaGlobal_ServantUpgradeInfo:open(self._fromCharacterKey, self._toCharacterKey)
  end
end
function PaGlobal_ServantUpgrade:handleClickedPrevButton()
  local index = self._selectIndex - 1
  if index < 0 then
    index = 0
  end
  self:selectIndex(index)
end
function PaGlobal_ServantUpgrade:handleClickedNextButton()
  local index = self._selectIndex + 1
  if index > self._maxIndex then
    index = self._maxIndex
  end
  self:selectIndex(index)
end
function PaGlobal_ServantUpgrade:handleClickedUpgradeInfoButton()
  if false == Panel_Window_ServantUpgradeInfo:GetShow() then
    PaGlobal_ServantUpgradeInfo:open(self._fromCharacterKey, self._toCharacterKey)
  else
    PaGlobal_ServantUpgradeInfo:close()
  end
end
