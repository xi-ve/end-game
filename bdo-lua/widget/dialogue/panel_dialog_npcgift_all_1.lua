function PaGlobal_DialogNpcGift_All:initialize()
  if true == PaGlobal_DialogNpcGift_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:controlSetShow()
  self._detailTextDescY = self._ui.txt_detailDesc:GetTextSizeY()
  self._detailDescY = self._ui.txt_detailDesc:GetSizeY()
  self._ui.txt_detailDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_detailDesc:SetText(self._ui.txt_detailDesc:GetText())
  if self._detailTextDescY < self._ui.txt_detailDesc:GetTextSizeY() + 10 then
    self._ui.txt_detailDesc:SetSize(self._ui.txt_detailDesc:GetSizeX(), self._ui.txt_detailDesc:GetTextSizeY() + 20)
    Panel_Dialog_NpcGift_All:SetSize(Panel_Dialog_NpcGift_All:GetSizeX(), Panel_Dialog_NpcGift_All:GetSizeY() + (self._ui.txt_detailDesc:GetSizeY() - self._detailDescY))
    self._ui_pc.btn_present:ComputePos()
    self._ui_pc.btn_confession:ComputePos()
    self._ui_console.stc_keyGuideBg:ComputePos()
  end
  if true == self._isConsole then
    local btn_sizeY = self._ui_pc.btn_present:GetSizeY()
    Panel_Dialog_NpcGift_All:SetSize(Panel_Dialog_NpcGift_All:GetSizeX(), Panel_Dialog_NpcGift_All:GetSizeY() - btn_sizeY - 10)
  end
  PaGlobal_DialogNpcGift_All:resize()
  PaGlobal_DialogNpcGift_All:registEventHandler()
  PaGlobal_DialogNpcGift_All:validate()
  PaGlobal_DialogNpcGift_All._initialize = true
end
function PaGlobal_DialogNpcGift_All:controlAll_Init()
  if nil == Panel_Dialog_NpcGift_All then
    return
  end
  self._ui.stc_titleBg = UI.getChildControl(Panel_Dialog_NpcGift_All, "StaticText_Interest_KnowledgeLine")
  self._ui.stc_mainBg = UI.getChildControl(Panel_Dialog_NpcGift_All, "Static_Bg")
  self._ui.stc_presentItemSlotBg = UI.getChildControl(self._ui.stc_mainBg, "Static_PresentItemSlot_BG")
  self._ui.stc_presentItemSlot = UI.getChildControl(self._ui.stc_mainBg, "Static_PresentItemSlot")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_mainBg, "StaticText_Desc")
  self._ui.stc_line = UI.getChildControl(self._ui.stc_mainBg, "Static_line")
  self._ui.txt_detailDesc = UI.getChildControl(Panel_Dialog_NpcGift_All, "StaticText_DetailDesc")
  self._ui.txt_interestItemTitle = UI.getChildControl(self._ui.stc_mainBg, "StaticText_InterestItemTitle")
  self._ui.stc_interestItemBg = UI.getChildControl(self._ui.stc_mainBg, "Static_InterestItemListBg")
  self._ui.list2_item = UI.getChildControl(Panel_Dialog_NpcGift_All, "List2_Item")
  self._ui.txt_NoItem = UI.getChildControl(self._ui.list2_item, "StaticText_NoItem")
  local listContent = UI.getChildControl(self._ui.list2_item, "List2_1_Content")
  local slot = {}
  local itemlistSlot = UI.getChildControl(listContent, "Static_ItemSlotBg")
  SlotItem.new(slot, "NpcGift_All_Slot_", 0, itemlistSlot, self._slotConfig)
  slot:createChild()
  slot.empty = true
  slot:clearItem()
  slot.icon:SetPosX(2)
  slot.icon:SetPosY(2)
  slot.border:SetSize(44, 44)
  self._slotPresentItem.icon = self._ui.stc_presentItemSlot
  SlotItem.new(self._slotPresentItem, "PresentItem", 0, self._ui.stc_presentItemSlot, self._slotConfig)
  self._slotPresentItem:createChild()
  self._slotPresentItem.empty = true
  self._slotPresentItem:clearItem()
  self._slotPresentItem.border:SetSize(46, 46)
  Panel_Tooltip_Item_SetPosition(0, Panel_Dialog_NpcGift_All, "NpcGift")
  for idx = 0, self._interestItemCount - 1 do
    local itemSlot = {}
    itemSlot.icon = UI.getChildControl(self._ui.stc_interestItemBg, "Static_InterestItemSlot" .. tostring(idx))
    SlotItem.new(itemSlot, "InteresetItemSlot_" .. tostring(idx), 0, Panel_Dialog_NpcGift_All, self._slotConfig)
    itemSlot:createChild()
    itemSlot.empty = true
    itemSlot:clearItem()
    itemSlot.border:SetSize(44, 44)
    Panel_Tooltip_Item_SetPosition(idx, itemSlot, "NpcIntertestGift")
    self._ui.stc_interestItemSlot[idx] = itemSlot
  end
end
function PaGlobal_DialogNpcGift_All:controlPc_Init()
  if nil == Panel_Dialog_NpcGift_All then
    return
  end
  self._ui_pc.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Close")
  self._ui_pc.btn_present = UI.getChildControl(Panel_Dialog_NpcGift_All, "Button_Present_PCUI")
  self._ui_pc.btn_confession = UI.getChildControl(Panel_Dialog_NpcGift_All, "Button_Confession_PCUI")
end
function PaGlobal_DialogNpcGift_All:controlConsole_Init()
  if nil == Panel_Dialog_NpcGift_All then
    return
  end
  self._ui_console.stc_keyGuideBg = UI.getChildControl(Panel_Dialog_NpcGift_All, "Static_BottomBG_ConsoleUI")
  self._ui_console.stc_guideIconB = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_B_ConsoleUI")
  self._ui_console.stc_guideIconX = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_X_ConsoleUI")
  self._ui_console.stc_guideIconY = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Y_ConsoleUI")
  self._ui_console.stc_guideIconA = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_A_ConsoleUI")
  self._ui_console.stc_guideIconLTY = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticTextLTY_ConsoleUI")
end
function PaGlobal_DialogNpcGift_All:controlSetShow()
  if nil == Panel_Dialog_NpcGift_All then
    return
  end
  if false == self._isConsole then
    self._ui_pc.btn_close:SetShow(true)
    self._ui_pc.btn_present:SetShow(true)
    self._ui_pc.btn_confession:SetShow(true)
    self._ui_console.stc_keyGuideBg:SetShow(false)
  else
    self._ui_pc.btn_close:SetShow(false)
    self._ui_pc.btn_present:SetShow(false)
    self._ui_pc.btn_confession:SetShow(false)
    self._ui_console.stc_keyGuideBg:SetShow(true)
  end
end
function PaGlobal_DialogNpcGift_All:prepareOpen()
  if nil == Panel_Dialog_NpcGift_All then
    return
  end
  HandleEventRUp_DialogNpcGift_All_PresentItemClear()
  PaGlobal_DialogNpcGift_All:update()
  PaGlobal_DialogNpcGift_All:open()
end
function PaGlobal_DialogNpcGift_All:open()
  if nil == Panel_Dialog_NpcGift_All then
    return
  end
  Panel_Dialog_NpcGift_All:SetShow(true)
end
function PaGlobal_DialogNpcGift_All:prepareClose()
  if nil == Panel_Dialog_NpcGift_All or false == Panel_Dialog_NpcGift_All:GetShow() then
    return
  end
  HandleEventRUp_DialogNpcGift_All_PresentItemClear()
  PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  PaGlobal_DialogNpcGift_All:close()
end
function PaGlobal_DialogNpcGift_All:close()
  if nil == Panel_Dialog_NpcGift_All then
    return
  end
  Panel_Dialog_NpcGift_All:SetShow(false)
end
function PaGlobal_DialogNpcGift_All:update()
  if nil == Panel_Dialog_NpcGift_All then
    return
  end
  self._slotPresentItem:clearItem()
  self._slotPresentItem.empty = true
  self._count = 0
  self._slotNo = 0
  local interestitemSize = ToClient_getInterestNpcGiftSize()
  for idx = 0, interestitemSize - 1 do
    self._ui.stc_interestItemSlot[idx]:clearItem()
    if idx == self._interestItemCount then
      break
    end
    local itemSS = ToClient_getInterestNpcGift(idx)
    if nil ~= itemSS then
      self:setItemToSlot(self._ui.stc_interestItemSlot[idx], itemSS, 1)
    end
  end
  self:updateList()
end
function PaGlobal_DialogNpcGift_All:updateList()
  if nil == Panel_Dialog_NpcGift_All then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  local invenSize = selfPlayer:getInventorySlotCount(false)
  self._ui.list2_item:getElementManager():clearKey()
  self._enableList = {}
  local listCount = -1
  for idx = 0, invenSize - 1 do
    local itemWrapper = getInventoryItemByType(self._whereType, idx)
    if nil ~= itemWrapper and true == self:filterEnableItem(idx, self._whereType, itemWrapper) then
      listCount = listCount + 1
      self._enableList[listCount] = idx
      self._ui.list2_item:getElementManager():pushKey(toInt64(0, listCount))
    end
  end
  if listCount <= -1 then
    self._ui.txt_NoItem:SetShow(true)
  else
    self._ui.txt_NoItem:SetShow(false)
  end
end
function PaGlobal_DialogNpcGift_All:validate()
  if nil == Panel_Dialog_NpcGift_All then
    return
  end
  self._ui.stc_titleBg:isValidate()
  self._ui.stc_mainBg:isValidate()
  self._ui.stc_presentItemSlotBg:isValidate()
  self._ui.stc_presentItemSlot:isValidate()
  self._ui.txt_desc:isValidate()
  self._ui.stc_line:isValidate()
  self._ui.txt_detailDesc:isValidate()
  self._ui.txt_interestItemTitle:isValidate()
  self._ui.stc_interestItemBg:isValidate()
  self._ui.list2_item:isValidate()
  self._ui.txt_NoItem:isValidate()
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.btn_present:isValidate()
  self._ui_pc.btn_confession:isValidate()
  self._ui_console.stc_keyGuideBg:isValidate()
  self._ui_console.stc_guideIconB:isValidate()
  self._ui_console.stc_guideIconX:isValidate()
  self._ui_console.stc_guideIconY:isValidate()
  self._ui_console.stc_guideIconA:isValidate()
  self._ui_console.stc_guideIconLTY:isValidate()
end
function PaGlobal_DialogNpcGift_All:registEventHandler()
  if nil == Panel_Dialog_NpcGift_All then
    return
  end
  registerEvent("onScreenResize", "FromeClient_DialogNpcGift_All_OnScrenResize")
  registerEvent("FromClient_VaryIntimacy_Dialog", "FromClient_DialogNpcGift_All_VaryIntimacyUpdate")
  registerEvent("FromClient_SuccessProposeToNpc", "FromClient_DialogNpcGift_All_SuccessProposeToNpc")
  if false == self._isConsole then
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_DialogNpcGift_All_Close()")
    self._ui_pc.btn_present:addInputEvent("Mouse_LUp", "HandleEventLUp_DialogNpcGift_All_PresentSend()")
    self._ui_pc.btn_confession:addInputEvent("Mouse_LUp", "HandleEventLUp_DialogNpcGift_All_Propose()")
    self._slotPresentItem.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_DialogNpcGift_All_PresentItemClear()")
    self._slotPresentItem.icon:addInputEvent("Mouse_On", "HandleEventOnOut_DialogNpcGift_All_PresentItemTooltip(true)")
    self._slotPresentItem.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_DialogNpcGift_All_PresentItemTooltip(false)")
    for idx = 0, self._interestItemCount - 1 do
      self._ui.stc_interestItemSlot[idx].icon:addInputEvent("Mouse_On", "HandleEventOnOut_DialogNpcGift_All_InterestItemTooltip(" .. idx .. ")")
      self._ui.stc_interestItemSlot[idx].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_DialogNpcGift_All_InterestItemTooltip()")
    end
  else
    Panel_Dialog_NpcGift_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventLUp_DialogNpcGift_All_Propose()")
    Panel_Dialog_NpcGift_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_DialogNpcGift_All_PresentSend()")
    for idx = 0, self._interestItemCount - 1 do
      self._ui.stc_interestItemSlot[idx].icon:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_DialogNpcGift_All_InterestItemTooltip(" .. idx .. ")")
      if false == _ContentsGroup_RenewUI_Tooltip then
        self._ui.stc_interestItemSlot[idx].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_DialogNpcGift_All_InterestItemTooltip()")
      end
    end
  end
  self._ui.list2_item:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_DialogNpcGift_All_UpdateItemList")
  self._ui.list2_item:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_DialogNpcGift_All:resize()
  if nil == Panel_Dialog_NpcGift_All then
    return
  end
  local keyGuides = {
    self._ui_console.stc_guideIconLTY,
    self._ui_console.stc_guideIconY,
    self._ui_console.stc_guideIconA,
    self._ui_console.stc_guideIconX,
    self._ui_console.stc_guideIconB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  Panel_Dialog_NpcGift_All:ComputePos()
  self._ui_pc.btn_present:ComputePos()
  self._ui_pc.btn_confession:ComputePos()
  self._ui_console.stc_keyGuideBg:ComputePos()
end
function PaGlobal_DialogNpcGift_All:setItemToSlot(uiSlot, itemSS, count)
  uiSlot.icon:EraseAllEffect()
  uiSlot.icon:AddEffect("UI_Button_Hide", false, 0, 0)
  uiSlot.empty = false
  uiSlot.icon:SetMonoTone(false)
  uiSlot:setItemByStaticStatus(itemSS, count, -1)
end
function PaGlobal_DialogNpcGift_All:filterEnableItem(slotNo, whereType, itemWrapper)
  if nil == itemWrapper then
    return false
  end
  if true == ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    return false
  end
  return true == itemWrapper:checkToGiveNpc()
end
