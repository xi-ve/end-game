function PaGlobal_CaveSeal_All:initialize()
  if true == PaGlobal_CaveSeal_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local stc_titleBg = UI.getChildControl(Panel_Window_CarveSeal_All, "Static_TitleBg")
  self._ui._stc_title = UI.getChildControl(stc_titleBg, "Static_Text_Title")
  self._ui._btn_close = UI.getChildControl(stc_titleBg, "Button_Close")
  self._ui._stc_subBg = UI.getChildControl(Panel_Window_CarveSeal_All, "Static_SubBG")
  self._ui._txt_desc = UI.getChildControl(Panel_Window_CarveSeal_All, "StaticText_Desc")
  self._ui._list2 = UI.getChildControl(Panel_Window_CarveSeal_All, "List2_Item")
  local list2_content = UI.getChildControl(self._ui._list2, "List2_1_Content")
  local slot = {}
  local list2_itemslot = UI.getChildControl(list2_content, "Static_ItemSlotBg")
  SlotItem.new(slot, "CarveSeal_Slot_Icon_", 0, list2_itemslot, self._slotConfig)
  slot:createChild()
  self._ui._pc._btn_seal = UI.getChildControl(Panel_Window_CarveSeal_All, "Button_Seal_PCUI")
  self._ui._pc._btn_unseal = UI.getChildControl(Panel_Window_CarveSeal_All, "Button_Unseal_PCUI")
  self._ui._console._stc_bottomBg = UI.getChildControl(Panel_Window_CarveSeal_All, "Static_BottomBg_ConsoleUI")
  self._ui._console._txt_key_A = UI.getChildControl(self._ui._console._stc_bottomBg, "StaticText_A_ConsoleUI")
  self._ui._console._txt_key_B = UI.getChildControl(self._ui._console._stc_bottomBg, "StaticText_B_ConsoleUI")
  self._ui._console._txt_key_X = UI.getChildControl(self._ui._console._stc_bottomBg, "StaticText_X_ConsoleUI")
  self._ui._console._txt_key_Y = UI.getChildControl(self._ui._console._stc_bottomBg, "StaticText_Y_ConsoleUI")
  local span = self._ui._console._txt_key_Y:GetSpanSize()
  self._key_spanSize_Y.x = span.x
  self._key_spanSize_Y.y = span.y
  self._ui._console._txt_key_Y:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CARVESEAL_TITLE"))
  local caveTextSize = self._ui._console._txt_key_Y:GetTextSizeX()
  self._ui._console._txt_key_Y:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RESETSEAL_TITLE"))
  local resetTextSize = self._ui._console._txt_key_Y:GetTextSizeX()
  self._key_gapSize = resetTextSize - caveTextSize
  self._ui._console._stc_bottomBg:SetShow(self._isConsole)
  self._ui._pc._btn_seal:SetShow(false == self._isConsole)
  self._ui._pc._btn_unseal:SetShow(false == self._isConsole)
  self._ui._btn_close:SetShow(false == self._isConsole)
  PaGlobal_CaveSeal_All:initResize()
  PaGlobal_CaveSeal_All:registEventHandler()
  PaGlobal_CaveSeal_All:validate()
  PaGlobal_CaveSeal_All._initialize = true
end
function PaGlobal_CaveSeal_All:registEventHandler()
  if nil == Panel_Window_CarveSeal_All then
    return
  end
  self._ui._list2:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_CaveSeal_All_CreateListControl")
  self._ui._list2:createChildContent(__ePAUIList2ElementManagerType_List)
  if true == self._isConsole then
    Panel_Window_CarveSeal_All:registerPadEvent(__eConsoleUIPadEvent_Y, "HandleEventPad_CaveSeal_All_CarveAndSeal()")
    Panel_Window_CarveSeal_All:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventPad_CaveSeal_All_ShowDetail()")
    Panel_Window_CarveSeal_All:registerPadEvent(__eConsoleUIPadEvent_A, "")
  else
    self._ui._btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_CaveSeal_All_Close()")
    self._ui._pc._btn_seal:addInputEvent("Mouse_LUp", "HandleEventLUp_CaveSeal_All_CarveSeal()")
    self._ui._pc._btn_unseal:addInputEvent("Mouse_LUp", "HandleEventLUp_CaveSeal_All_ResetSeal()")
  end
  registerEvent("FromClient_CarveSeal_Show", "FromClient_CaveSeal_All_CarveShow")
  registerEvent("FromClinet_CarveSeal_Hide", "FromClient_CaveSeal_All_CarveHide")
  registerEvent("FromClient_ResetSealShow", "FromClient_CaveSeal_All_ResetShow")
  registerEvent("FromClient_ResetSealHide", "FromClient_CaveSeal_All_ResetHide")
  registerEvent("FromClient_InventoryUpdate", "FromClient_CaveSeal_All_UpdateList")
end
function PaGlobal_CaveSeal_All:prepareOpen(eType)
  if nil == Panel_Window_CarveSeal_All then
    return
  end
  self._selectSlot = 0
  self._sealType = eType
  self:updateInfo(self._sealType)
  self:updateButton(self._sealType)
  self:updateList(self._sealType)
  self._ui._list2:GetVScroll():SetControlPos(0)
  Inventory_SetFunctor(PaGlobal_CaveSeal_All_InventoryFilter, nil, nil, nil)
  if nil ~= Panel_Widget_Tooltip_Renew then
    PaGlobalFunc_TooltipInfo_Close()
  end
  PaGlobal_CaveSeal_All:open()
end
function PaGlobal_CaveSeal_All:open()
  if nil == Panel_Window_CarveSeal_All then
    return
  end
  Panel_Window_CarveSeal_All:SetShow(true)
end
function PaGlobal_CaveSeal_All:prepareClose()
  if nil == Panel_Window_CarveSeal_All then
    return
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  if nil ~= Panel_Widget_Tooltip_Renew then
    PaGlobalFunc_TooltipInfo_Close()
  end
  PaGlobal_CaveSeal_All:close()
end
function PaGlobal_CaveSeal_All:close()
  if nil == Panel_Window_CarveSeal_All then
    return
  end
  Panel_Window_CarveSeal_All:SetShow(false)
end
function PaGlobal_CaveSeal_All:validate()
  if nil == Panel_Window_CarveSeal_All then
    return
  end
end
function PaGlobal_CaveSeal_All:updateInfo(eType)
  if self._eType.carve == eType then
    self._ui._stc_title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CARVESEAL_TITLE"))
    self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CARVESEAL_DESC_1"))
    self._ui._console._txt_key_Y:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CARVESEAL_TITLE"))
    self._ui._console._txt_key_Y:SetSpanSize(self._key_spanSize_Y.x, self._key_spanSize_Y.y)
  elseif self._eType.reset == eType then
    self._ui._stc_title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RESETSEAL_TITLE"))
    self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CARVESEAL_DESC_2"))
    self._ui._console._txt_key_Y:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RESETSEAL_TITLE"))
    self._ui._console._txt_key_Y:SetSpanSize(self._key_spanSize_Y.x + self._key_gapSize, self._key_spanSize_Y.y)
  end
  local keyGuide = {
    self._ui._console._txt_key_Y,
    self._ui._console._txt_key_X,
    self._ui._console._txt_key_A,
    self._ui._console._txt_key_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._console._stc_bottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_CaveSeal_All:updateButton(eType)
  if false == self._isConsole then
    self._ui._pc._btn_seal:SetShow(self._eType.carve == eType)
    self._ui._pc._btn_unseal:SetShow(self._eType.reset == eType)
  end
end
function PaGlobal_CaveSeal_All:setButtonMonoton(isMonoton)
  self._ui._pc._btn_seal:SetIgnore(isMonoton)
  self._ui._pc._btn_unseal:SetIgnore(isMonoton)
  self._ui._pc._btn_seal:SetMonoTone(isMonoton)
  self._ui._pc._btn_unseal:SetMonoTone(isMonoton)
end
function PaGlobal_CaveSeal_All:updateList(eType)
  if nil == Panel_Window_CarveSeal_All then
    return
  end
  if nil == self._ui._list2:getElementManager() then
    return
  end
  self._slotList = {}
  self._ui._list2:getElementManager():clearKey()
  local listIndex = 0
  listIndex = self:setList(CppEnums.ItemWhereType.eInventory, listIndex)
  listIndex = self:setList(CppEnums.ItemWhereType.eCashInventory, listIndex)
  if 0 < listIndex then
    self:setButtonMonoton(false)
  else
    self:setButtonMonoton(true)
  end
end
function PaGlobal_CaveSeal_All:setList(inventoryType, listIndex)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer or nil == selfPlayer:get() then
    return
  end
  local inventory = selfPlayer:get():getInventory(inventoryType)
  if nil == inventory then
    return
  end
  local invenSize = selfPlayer:get():getInventorySlotCount(CppEnums.ItemWhereType.eCashInventory == inventoryType)
  local useStartSlot = inventorySlotNoUserStart()
  for slotNo = useStartSlot, invenSize - 1 do
    local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
    if nil ~= itemWrapper and true == self:isCheckSealdItem(itemWrapper) then
      self._slotList[listIndex] = {_invenType = inventoryType, _slotNo = slotNo}
      self._ui._list2:getElementManager():pushKey(toInt64(0, listIndex))
      listIndex = listIndex + 1
    end
  end
  return listIndex
end
function PaGlobal_CaveSeal_All:createList(control, key)
  local index = Int64toInt32(key)
  local slotdata = self._slotList[index]
  if nil == slotdata then
    _PA_LOG("\236\178\156\235\167\140\234\184\176", "PaGlobal_CaveSeal_All:createList nil == self._slotList[index] index = " .. tostring(index))
    return
  end
  local list2_radioButton = UI.getChildControl(control, "RadioButton_ItemList")
  local list2_itemslot = UI.getChildControl(control, "Static_ItemSlotBg")
  local list2_itemName = UI.getChildControl(control, "StaticText_ItemName")
  list2_radioButton:setNotImpactScrollEvent(true)
  local slot = {}
  SlotItem.reInclude(slot, "CarveSeal_Slot_Icon_", 0, list2_itemslot, self._slotConfig)
  slot:clearItem()
  slot.icon:SetIgnore(true)
  local itemWrapper = getInventoryItemByType(slotdata._invenType, slotdata._slotNo)
  slot:setItem(itemWrapper)
  local itemSSW = itemWrapper:getStaticStatus()
  list2_itemName:SetText(itemSSW:getName())
  list2_radioButton:addInputEvent("Mouse_On", "HandleEventOn_CaveSeal_All_Select(" .. index .. ")")
  list2_radioButton:addInputEvent("Mouse_LUp", "HandleEventLUp_CaveSeal_All_Select(" .. index .. ")")
  list2_radioButton:SetCheck(self._selectSlot == index)
  list2_itemslot:addInputEvent("Mouse_On", "HandleEventOn_CaveSeal_All_TooltipShow(" .. index .. ")")
  list2_itemslot:addInputEvent("Mouse_Out", "HandleEventOut_CaveSeal_All_TooltipHide()")
end
function PaGlobal_CaveSeal_All:isCheckSealdItem(itemWrapper)
  if PaGlobal_CaveSeal_All._eType.carve == PaGlobal_CaveSeal_All._sealType then
    return PaGlobal_CaveSeal_All:isCheckCarve(itemWrapper)
  elseif PaGlobal_CaveSeal_All._eType.reset == PaGlobal_CaveSeal_All._sealType then
    return PaGlobal_CaveSeal_All:isCheckReset(itemWrapper)
  end
end
function PaGlobal_CaveSeal_All:isCheckCarve(itemWrapper)
  if nil == itemWrapper then
    return false
  end
  local staticStatus = itemWrapper:getStaticStatus()
  if nil == staticStatus then
    return false
  end
  if itemWrapper:isSealed() then
    return false
  end
  return staticStatus:isPossibleCarveSeal()
end
function PaGlobal_CaveSeal_All:isCheckReset(itemWrapper)
  if nil == itemWrapper then
    return false
  end
  local isCash = itemWrapper:isCash()
  local isSeal = itemWrapper:isSealed()
  local isEquipable = itemWrapper:getStaticStatus():get():isEquipable()
  return false == isCash and true == isSeal and true == isEquipable
end
function PaGlobal_CaveSeal_All:initResize()
  if true == PaGlobal_CaveSeal_All._initialize then
    return
  end
  if true == self._isConsole then
    local minusSize = self._ui._pc._btn_seal:GetSizeY()
    local panelSizeY = Panel_Window_CarveSeal_All:GetSizeY() - minusSize
    Panel_Window_CarveSeal_All:SetSize(Panel_Window_CarveSeal_All:GetSizeX(), panelSizeY)
    local bgSizeY = self._ui._stc_subBg:GetSizeY() - minusSize
    self._ui._stc_subBg:SetSize(self._ui._stc_subBg:GetSizeX(), bgSizeY)
    self._ui._console._stc_bottomBg:ComputePos()
  end
end
