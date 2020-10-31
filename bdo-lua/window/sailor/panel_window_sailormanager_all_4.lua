function PaGlobal_SailorRestore_All:initialize()
  if true == PaGlobal_SailorRestore_All._initialize then
    return
  end
  self._ui.stc_titleBG = UI.getChildControl(Panel_Window_SailorRestore_All, "Static_TitleBg")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBG, "Button_Win_Close_PCUI")
  self._ui.stc_sailorRestoreBG = UI.getChildControl(Panel_Window_SailorRestore_All, "Static_SailorRestoreBG")
  self._ui.stc_itemSlot = UI.getChildControl(self._ui.stc_sailorRestoreBG, "Static_Restore_Item_Icon_BG")
  self._ui.stc_itemBorder = UI.getChildControl(self._ui.stc_itemSlot, "Static_Restore_Item_Icon")
  self._ui.txt_itemCount = UI.getChildControl(self._ui.stc_itemSlot, "StaticText_Item_Count")
  self._ui.txt_itemRestoreValue = UI.getChildControl(self._ui.stc_itemSlot, "StaticText_Item_Restore_Value")
  self._ui.txt_sailorCount = UI.getChildControl(self._ui.stc_sailorRestoreBG, "StaticText_SailorCount")
  self._ui.txt_restoreLoyaltyValue = UI.getChildControl(self._ui.stc_sailorRestoreBG, "StaticText_RestoredLoyaltyValue")
  self._ui.txt_useItemCount = UI.getChildControl(self._ui.stc_sailorRestoreBG, "StaticText_UseItemCount")
  self._ui.btn_complete = UI.getChildControl(Panel_Window_SailorRestore_All, "Button_Complete")
  self._ui.btn_cancel = UI.getChildControl(Panel_Window_SailorRestore_All, "Button_Cancel")
  self._ui.stc_itemSlot:SetShow(false)
  UI.getChildControl(self._ui.stc_titleBG, "StaticText_TitleIcon"):SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILOR_WHOLE_RECOVERY"))
  UI.getChildControl(self._ui.stc_sailorRestoreBG, "StaticText_Restore_Item"):SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SEA_ITEM_USE_SELECT"))
  self._ui.btn_complete:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CONFIRM"))
  self._ui.btn_cancel:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_KEYGUIDE_CANCEL"))
  self._ui.txt_sailorCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EMPLOYEE_RESTORE_TARGET", "count", tostring(0)))
  self._ui.txt_restoreLoyaltyValue:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EMPLOYEE_RESTORE_VALUE", "value", tostring(0)))
  self._ui.txt_useItemCount:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ITEMCOUNT_LOYALTY_RECOVERY", "count", tostring(0), "value", tostring(0)))
  local count = 6
  for ii = 1, count do
    local slot = {
      base = {}
    }
    slot.bg = UI.createAndCopyBasePropertyControl(self._ui.stc_sailorRestoreBG, "Static_Restore_Item_Icon_BG", self._ui.stc_sailorRestoreBG, "Static_RestorItem_" .. ii)
    slot.bg:SetPosX(15 + 54 * (ii - 1))
    slot.bg:SetShow(false)
    slot.bg:SetIgnore(false)
    slot.bg:addInputEvent("Mouse_LUp", "HandlerEventLUp_SailorRestoreAll_SelectItem(" .. ii .. ")")
    SlotItem.new(slot.base, "SailorRestore_ItemSlot_" .. ii, ii, slot.bg, PaGlobal_SailorRestore_All.slotConfig)
    slot.base:createChild()
    slot.base.icon:SetIgnore(true)
    slot.selectIcon = UI.createAndCopyBasePropertyControl(self._ui.stc_itemSlot, "Static_Restore_Item_Icon", slot.bg, "Static_RestorItem_Border" .. ii)
    slot.selectIcon:SetShow(false)
    slot.base.value = UI.createAndCopyBasePropertyControl(self._ui.stc_itemSlot, "StaticText_Item_Restore_Value", slot.bg, "Static_RestorItem_Value" .. ii)
    table.insert(self._ui.itemSlot, slot)
  end
  PaGlobal_SailorRestore_All:registerEventHandler()
  PaGlobal_SailorRestore_All:validate()
  PaGlobal_SailorRestore_All._initialize = true
end
function PaGlobal_SailorRestore_All:registerEventHandler()
  if nil == Panel_Window_SailorRestore_All then
    return
  end
  self._ui.btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_SailorRestore_All:prepareClose()")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_SailorRestore_All:prepareClose()")
  self._ui.btn_complete:addInputEvent("Mouse_LUp", "HandlerEventLUp_SailorRestoreAll_Confirm()")
end
function PaGlobal_SailorRestore_All:slotClear()
  for _, slot in pairs(self._ui.itemSlot) do
    if nil ~= slot then
      slot.bg:SetShow(false)
    end
  end
end
function PaGlobal_SailorRestore_All:update()
  if nil == Panel_Window_SailorRestore_All then
    return
  end
  self:slotClear()
  local recoveryItemSize = ToClient_getRecoveryItemCount()
  local isExistItem = false
  for index = 1, recoveryItemSize do
    local recoveryItem = ToClient_GetRecoveryItemByIndex(index - 1, __eEmployeeLoyalismType_Loyalty)
    if nil ~= recoveryItem then
      isExistItem = true
    end
  end
  if false == isExistItem then
    Proc_ShowMessage_Ack_With_ChatType(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_NORECOVERYITEM"), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
    return
  end
  local restoreItemList = PaGlobal_SailorManager_All._ui.stc_restoreList
  self._loyaltyRestoreItemList = {}
  local realIndex = 1
  for index = 1, recoveryItemSize do
    local recoveryItem = ToClient_GetRecoveryItemByIndex(index - 1, __eEmployeeLoyalismType_Loyalty)
    if nil ~= recoveryItem then
      local restoreSlot = self._ui.itemSlot[realIndex]
      if nil == restoreSlot then
        _PA_SVC_LOG("\236\138\172\235\161\175\236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164. \236\132\160\236\155\144 \236\160\132\236\178\180 \236\182\169\236\132\177\235\143\132 \237\154\140\235\179\181 UI\236\160\149\236\131\129\235\143\153\236\158\145 \237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.")
        return
      end
      local recoveryItemKey = recoveryItem:get():getKey():getItemKey()
      local recoveryItemCount = recoveryItem:get():getCount_s64()
      local recoveryItemValue = ToClient_getRecoveryValue(__eEmployeeLoyalismType_Loyalty, recoveryItemKey)
      local itemStatic = recoveryItem:getStaticStatus()
      if nil == itemStatic then
        _PA_SVC_LOG("itemStatic \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164. \236\132\160\236\155\144 \236\160\132\236\178\180 \236\182\169\236\132\177\235\143\132 \237\154\140\235\179\181 UI\236\160\149\236\131\129\235\143\153\236\158\145 \237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.")
        return
      end
      restoreSlot.base.icon:ChangeTextureInfoName("icon/" .. itemStatic:getIconPath())
      restoreSlot.base.count:SetShow(true)
      restoreSlot.base.count:SetText(tostring(recoveryItemCount))
      restoreSlot.base.value:SetShow(true)
      restoreSlot.base.value:SetText("+" .. tostring(recoveryItemValue))
      restoreSlot.bg:SetShow(true)
      self._loyaltyRestoreItemList[realIndex] = {}
      self._loyaltyRestoreItemList[realIndex]._value = recoveryItemValue
      self._loyaltyRestoreItemList[realIndex]._count = recoveryItemCount
      realIndex = realIndex + 1
    end
  end
end
function PaGlobal_SailorRestore_All:setPanelPosition()
  if nil == Panel_Window_SailorRestore_All or nil == Panel_Window_SailorManager_All then
    return
  end
  local pos = float2()
  pos.x = Panel_Window_SailorManager_All:GetPosX() + Panel_Window_SailorManager_All:GetSizeX() + 15
  pos.y = Panel_Window_SailorManager_All:GetPosY()
  Panel_Window_SailorRestore_All:SetPosX(pos.x)
  Panel_Window_SailorRestore_All:SetPosY(pos.y)
end
function PaGlobal_SailorRestore_All:prepareOpen()
  if nil == Panel_Window_SailorRestore_All then
    return
  end
  PaGlobal_SailorRestore_All:setPanelPosition()
  PaGlobal_SailorRestore_All:slotClear()
  PaGlobal_SailorRestore_All:update()
  HandlerEventLUp_SailorRestoreAll_SelectItem(1)
  if true == Panel_Window_Sailor_Onboard_All:GetShow() then
    PaGlobal_SailorOnBoard_All:prepareClose()
  end
  PaGlobal_SailorRestore_All:open()
end
function PaGlobal_SailorRestore_All:restoringUpdate()
  self:update()
  HandlerEventLUp_SailorRestoreAll_SelectItem(self._selectItemIndex)
end
function PaGlobal_SailorRestore_All:open()
  if nil == Panel_Window_SailorRestore_All then
    return
  end
  Panel_Window_SailorRestore_All:SetShow(true)
end
function PaGlobal_SailorRestore_All:prepareClose()
  if nil == Panel_Window_SailorRestore_All then
    return
  end
  PaGlobal_SailorRestore_All:close()
end
function PaGlobal_SailorRestore_All:close()
  if nil == Panel_Window_SailorRestore_All then
    return
  end
  Panel_Window_SailorRestore_All:SetShow(false)
end
function PaGlobal_SailorRestore_All:validate()
  if nil == Panel_Window_SailorRestore_All then
    return
  end
end
function HandlerEventLUp_SailorRestoreAll_SelectItem(index)
  if nil == Panel_Window_SailorRestore_All then
    return
  end
  for i = 1, 6 do
    PaGlobal_SailorRestore_All._ui.itemSlot[i].selectIcon:SetShow(i == index)
  end
  PaGlobal_SailorRestore_All._selectItemIndex = index
  local restoreItem = PaGlobal_SailorRestore_All._loyaltyRestoreItemList[index]
  if nil == restoreItem then
    return
  end
  local usedCount = 0
  local sailorCount = 0
  local restoreValue = 0
  local restoreCount = 0
  PaGlobal_SailorRestore_All._totalRestoreValue = 0
  for _, sailorInfo in pairs(PaGlobal_SailorManager_All._sailorInfoList) do
    if nil ~= sailorInfo and __eEmployeeState_Escape ~= sailorInfo._state and sailorInfo._loyalty < sailorInfo._maxLoyalty then
      sailorCount = sailorCount + 1
      local needLoyalty = sailorInfo._maxLoyalty - sailorInfo._loyalty
      PaGlobal_SailorRestore_All._totalRestoreValue = PaGlobal_SailorRestore_All._totalRestoreValue + needLoyalty
      restoreCount = restoreCount + math.ceil(needLoyalty / restoreItem._value)
    end
  end
  if 0 < PaGlobal_SailorRestore_All._totalRestoreValue then
    usedCount = math.min(Int64toInt32(restoreCount), Int64toInt32(restoreItem._count))
    restoreValue = math.min(Int64toInt32(usedCount * restoreItem._value), Int64toInt32(PaGlobal_SailorRestore_All._totalRestoreValue))
  end
  PaGlobal_SailorRestore_All._ui.txt_sailorCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EMPLOYEE_RESTORE_TARGET", "count", tostring(sailorCount)))
  PaGlobal_SailorRestore_All._ui.txt_restoreLoyaltyValue:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EMPLOYEE_RESTORE_VALUE", "value", tostring(PaGlobal_SailorRestore_All._totalRestoreValue)))
  local string = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ITEMCOUNT_LOYALTY_RECOVERY", "count", tostring(usedCount), "value", tostring(usedCount * restoreItem._value))
  PaGlobal_SailorRestore_All._ui.txt_useItemCount:SetText(string)
end
function HandlerEventLUp_SailorRestoreAll_Confirm()
  if nil == Panel_Window_SailorRestore_All then
    return
  end
  for _, sailorInfo in pairs(PaGlobal_SailorManager_All._sailorInfoList) do
    if nil ~= sailorInfo and sailorInfo._loyalty < sailorInfo._maxLoyalty and __eEmployeeState_Escape ~= sailorInfo._state then
      ToClient_requestRecoveryEmployee(sailorInfo._sailorNo, PaGlobal_SailorRestore_All._selectItemIndex - 1, __eEmployeeLoyalismType_Loyalty, true)
    end
  end
end
function PaGlobal_SailorRestore_All:slotClear()
  for _, slot in pairs(self._ui.itemSlot) do
    if nil ~= slot then
      slot.bg:SetShow(false)
    end
  end
end
