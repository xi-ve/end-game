function PaGlobal_Restore_All:initialize()
  if true == PaGlobal_Restore_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local stc_title = UI.getChildControl(Panel_Window_Restore_All, "Static_Title")
  self._ui._btn_close = UI.getChildControl(stc_title, "Button_Close")
  self._ui._stc_restoreNum = UI.getChildControl(Panel_Window_Restore_All, "StaticText_RestoreNum")
  self._ui._btn_restore = UI.getChildControl(Panel_Window_Restore_All, "Button_Restore")
  self._ui._list2 = UI.getChildControl(Panel_Window_Restore_All, "List2_Item")
  local slot = {}
  local list2_content = UI.getChildControl(self._ui._list2, "List2_1_Content")
  local list2_btn_radio = UI.getChildControl(list2_content, "RadioButton_Item")
  local list2_itemslot = UI.getChildControl(list2_btn_radio, "Static_ItemSlot")
  SlotItem.new(slot, "Restore_Slot_Icon_", 0, list2_itemslot, self._slotConfig)
  slot:createChild()
  local policyDesc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_ITEM_RESTORATION_POLICY_DESC", "periodTime", __eRestoreItemPeriodTime, "maxCount", __eMaxRestoreItemCount, "resetDay", 1)
  if isGameTypeEnglish() then
    policyDesc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_ITEM_RESTORATION_POLICY_DESC_EN", "periodTime", __eRestoreItemPeriodTime, "maxCount", __eMaxRestoreItemCount, "resetDay", 1)
  else
    policyDesc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_ITEM_RESTORATION_POLICY_DESC", "periodTime", __eRestoreItemPeriodTime, "maxCount", __eMaxRestoreItemCount, "resetDay", 1)
  end
  self._ui.stc_descBg = UI.getChildControl(Panel_Window_Restore_All, "Static_DescBg")
  self._ui.stc_txtDesc = UI.getChildControl(self._ui.stc_descBg, "StaticText_Desc")
  self._ui.stc_subFrameBg = UI.getChildControl(Panel_Window_Restore_All, "Static_SubFrameBg")
  self._ui.stc_txtDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_txtDesc:SetText(policyDesc)
  if self._ui.stc_descBg:GetSizeY() < self._ui.stc_txtDesc:GetTextSizeY() + 5 then
    local addSizeY = self._ui.stc_txtDesc:GetTextSizeY() + 5 - self._ui.stc_descBg:GetSizeY()
    self._ui.stc_descBg:SetSize(self._ui.stc_descBg:GetSizeX(), self._ui.stc_descBg:GetSizeY() + addSizeY)
    self._ui.stc_subFrameBg:SetSize(self._ui.stc_subFrameBg:GetSizeX(), self._ui.stc_subFrameBg:GetSizeY() + addSizeY)
    Panel_Window_Restore_All:SetSize(Panel_Window_Restore_All:GetSizeX(), Panel_Window_Restore_All:GetSizeY() + addSizeY)
  end
  self._ui.stc_subFrameBg:ComputePos()
  self._ui.stc_descBg:ComputePos()
  self._ui.stc_txtDesc:ComputePos()
  self._ui_console._stc_keyGuideBg = UI.getChildControl(Panel_Window_Restore_All, "Static_KeyGuide_ConsoleUI")
  self._ui_console._stc_keyGuideA = UI.getChildControl(self._ui_console._stc_keyGuideBg, "StaticText_A_ConsoleUI")
  self._ui_console._stc_keyGuideB = UI.getChildControl(self._ui_console._stc_keyGuideBg, "StaticText_B_ConsoleUI")
  PaGlobal_Restore_All:registEventHandler()
  PaGlobal_Restore_All:validate()
  PaGlobal_Restore_All:controlSetShow()
  PaGlobal_Restore_All:consoleSetting()
  PaGlobal_Restore_All._initialize = true
end
function PaGlobal_Restore_All:registEventHandler()
  if nil == Panel_Window_Restore_All then
    return
  end
  self._ui._list2:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_Restore_All_CreateListControl")
  self._ui._list2:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_Restore_All_Close()")
  self._ui._btn_restore:addInputEvent("Mouse_LUp", "HandleEventLUp_Restore_All_Restore()")
  registerEvent("FromClient_Restore_All_UpdateList", "FromClient_Restore_All_UpdateList")
  registerEvent("FromClient_Restore_All_UpdateInfo", "FromClient_Restore_All_UpdateInfo")
  registerEvent("FromClient_Restore_All_ChangedRestoreReq", "FromClient_Restore_All_ChangedRestoreReq")
  if self._isConsole then
    registerEvent("onScreenResize", "FromClient_Restore_All_Reposition")
  end
end
function PaGlobal_Restore_All:prepareOpen(restoreType)
  if nil == Panel_Window_Restore_All then
    return
  end
  local invenCheck = false
  if true == _ContentsGroup_NewUI_Inventory_All then
    invenCheck = Panel_Window_Inventory_All:IsShow() and Panel_Window_Inventory_All:IsUISubApp()
  else
    invenCheck = Panel_Window_Inventory:IsShow() and Panel_Window_Inventory:IsUISubApp()
  end
  if true == invenCheck then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RESTORE_ITEM_DO_NOT_USE"))
    return
  end
  self._restoreType = restoreType
  self._selectSlotNo = nil
  self._ui._list2:GetVScroll():SetControlPos(0)
  self._ui._list2:setMinScrollBtnSize(float2(5, 50))
  self._ui._btn_restore:SetIgnore(true)
  self._ui._btn_restore:SetMonoTone(true)
  self:updateInfo()
  ToClient_RequestRestoreItemList(self._restoreType)
  ToClient_RequestResetRestoreItemUserInfo(self._restoreType)
  self:reposition()
  PaGlobal_Restore_All:open()
end
function PaGlobal_Restore_All:open()
  if nil == Panel_Window_Restore_All then
    return
  end
  Panel_Window_Restore_All:SetShow(true)
end
function PaGlobal_Restore_All:prepareClose()
  if nil == Panel_Window_Restore_All then
    return
  end
  PaGlobal_Restore_All:close()
end
function PaGlobal_Restore_All:close()
  if nil == Panel_Window_Restore_All then
    return
  end
  Panel_Window_Restore_All:SetShow(false)
end
function PaGlobal_Restore_All:validate()
  if nil == Panel_Window_Restore_All then
    return
  end
end
function PaGlobal_Restore_All:controlSetShow()
  if nil == Panel_Window_Restore_All then
    return
  end
  self._ui._btn_close:SetShow(not self._isConsole)
  self._ui._btn_restore:SetShow(not self._isConsole)
  self._ui_console._stc_keyGuideBg:SetShow(self._isConsole)
end
function PaGlobal_Restore_All:updateList()
  if nil == Panel_Window_Restore_All then
    return
  end
  if nil == self._ui._list2:getElementManager() then
    return
  end
  self._ui._list2:getElementManager():clearKey()
  self:setList()
end
function PaGlobal_Restore_All:updateInfo()
  if nil == Panel_Window_Restore_All then
    return
  end
  local restoreCount = ToClient_GetItemRestorationLimitCount(self._restoreType)
  local restoreCountString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ITEM_RESTORATION_LIMIT_COUNT", "count", restoreCount, "maxCount", __eMaxRestoreItemCount)
  self._ui._stc_restoreNum:SetText(restoreCountString)
end
function PaGlobal_Restore_All:updateRestoreButton()
  if nil == Panel_Window_Restore_All then
    return
  end
  local isRestoreReq = ToClient_IsRestoreReq()
  local isIgnore = isRestoreReq or nil == self._selectSlotNo
  self._ui._btn_restore:SetIgnore(isIgnore)
  self._ui._btn_restore:SetMonoTone(isIgnore)
end
function PaGlobal_Restore_All:setList()
  if nil == Panel_Window_Restore_All then
    return
  end
  self._selectSlotNo = nil
  self:updateRestoreButton()
  local listCount = ToClient_RequestRestoreItemListCount(self._restoreType)
  for ii = 0, listCount - 1 do
    self._ui._list2:getElementManager():pushKey(toInt64(0, ii))
  end
end
function PaGlobal_Restore_All:createList(control, key)
  local restoreType = self._restoreType
  local index = Int64toInt32(key)
  local itemSSW = ToClient_RequestRestoreItemEnchantStaticStatusWrapperAt(restoreType, index)
  if nil == itemSSW then
    return
  end
  local s64_stackCount = ToClient_RequestRestoreItemCountAt(restoreType, index)
  local list2_btn_radio = UI.getChildControl(control, "RadioButton_Item")
  local list2_itemslot = UI.getChildControl(list2_btn_radio, "Static_ItemSlot")
  local list2_itemname = UI.getChildControl(list2_btn_radio, "StaticText_ItemName")
  local list2_itemtime = UI.getChildControl(list2_btn_radio, "StaticText_ItemTime")
  list2_btn_radio:setNotImpactScrollEvent(true)
  list2_btn_radio:SetCheck(false)
  list2_btn_radio:addInputEvent("Mouse_LUp", "HandleEventLUp_Restore_All_Select(" .. tostring(index) .. ")")
  list2_itemslot:SetIgnore(true)
  local slot = {}
  SlotItem.reInclude(slot, "Restore_Slot_Icon_", 0, list2_itemslot, self._slotConfig)
  slot:clearItem()
  slot.icon:SetIgnore(true)
  slot:setItemByStaticStatus(itemSSW, s64_stackCount)
  local itemName = MakeUpItemNameWithEnchantLevel(restoreType, index)
  list2_itemname:SetText(itemName)
  local expirationTime = ToClient_GetRestoreItemExpirationTime(restoreType, index)
  local expirationTimeString = PAGetString(Defines.StringSheet_GAME, "LUA_ITEM_RESTORATION_EXPIRATION_TIME") .. " " .. convertStringFromDatetimeAll(expirationTime - getServerUtc64())
  list2_itemtime:SetText(expirationTimeString)
end
function PaGlobal_Restore_All:reposition()
  if false == self._isConsole then
    return
  end
  Panel_Window_Restore_All:ComputePos()
end
function PaGlobal_Restore_All:consoleSetting()
  if false == self._isConsole then
    return
  end
  local keyGuide = {
    self._ui_console._stc_keyGuideA,
    self._ui_console._stc_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui_console._stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  self._ui.stc_descBg:SetPosY(self._ui._btn_restore:GetPosY())
  local subSizeY = self._ui._btn_restore:GetSizeY()
  self._ui.stc_subFrameBg:SetSize(self._ui.stc_subFrameBg:GetSizeX(), self._ui.stc_subFrameBg:GetSizeY() - subSizeY)
  Panel_Window_Restore_All:SetSize(Panel_Window_Restore_All:GetSizeX(), Panel_Window_Restore_All:GetSizeY() - subSizeY)
  self._ui_console._stc_keyGuideBg:ComputePos()
  Panel_Window_Restore_All:SetVerticalMiddle()
  Panel_Window_Restore_All:SetHorizonCenter()
end
