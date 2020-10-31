function PaGlobal_Endurance_Recovery_All:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:setNotice()
  self:SetUiSetting()
  self._ui.list2_recoveryList:SetSize(self._ui.list2_recoveryList:GetSizeX(), self._ui.list2_recoveryList:GetSizeY())
  self._ui.list2_materialList:SetSize(self._ui.list2_materialList:GetSizeX(), self._ui.list2_materialList:GetSizeY())
  self._ui.list2_recoveryList:setNotImpactScrollEvent(true)
  self._ui.list2_materialList:setNotImpactScrollEvent(true)
  self._ui._icon_items = {}
  SlotItem.new(self._ui._icon_items, "feeItem", nil, self._ui.stc_recoveryItemSlot, self._slotConfig)
  self._ui._icon_items:createChild()
  self._ui._icon_items:clearItem()
  self._ui._icon_cashItem = {}
  SlotItem.new(self._ui._icon_cashItem, "resultItem", nil, self._ui.stc_memoryItemSlot, self._slotConfig)
  self._ui._icon_cashItem:createChild()
  self._ui._icon_cashItem:clearItem()
  self._ui._icon_materialItem = {}
  SlotItem.new(self._ui._icon_materialItem, "resultItem", nil, self._ui.stc_meterialItemSlot, self._slotConfig)
  self._ui._icon_materialItem:createChild()
  self._ui._icon_materialItem:clearItem()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Endurance_Recovery_All:controlAll_Init()
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  local leftMainArea = UI.getChildControl(Panel_Window_Endurance_Recovery_All, "Static_LeftMainArea")
  local topDescArea = UI.getChildControl(leftMainArea, "Static_TopDescArea")
  self._ui.stc_leftTopDesc = UI.getChildControl(topDescArea, "StaticText_LeftTopDesc")
  local rightArea = UI.getChildControl(Panel_Window_Endurance_Recovery_All, "Static_RightTopArea")
  self._ui.list2_recoveryList = UI.getChildControl(rightArea, "List2_ExtractableItemList")
  local rightBottomArea = UI.getChildControl(Panel_Window_Endurance_Recovery_All, "Static_RightBottomArea")
  self._ui.list2_materialList = UI.getChildControl(rightBottomArea, "List2_ExtractionMaterialItemList")
  local leftBottomArea = UI.getChildControl(Panel_Window_Endurance_Recovery_All, "Static_LeftBottomArea")
  self._ui.btn_useCashItem = UI.getChildControl(leftBottomArea, "CheckButton_UseCash")
  self._ui.txt_useItemCount = UI.getChildControl(self._ui.btn_useCashItem, "StaticText_Count")
  local bottomImageArea = UI.getChildControl(leftMainArea, "Static_BottomImageArea")
  local imagePartArea = UI.getChildControl(bottomImageArea, "Static_ImagePartArea")
  local enduranceRecoveryImageArea = UI.getChildControl(imagePartArea, "Static_EnduranceRecoveryImage")
  self._ui.stc_recoveryItemSlot = UI.getChildControl(enduranceRecoveryImageArea, "Static_RecoveryIconSlot")
  self._ui.stc_memoryItemSlot = UI.getChildControl(enduranceRecoveryImageArea, "Static_MemoryItemSlot")
  self._ui.stc_meterialItemSlot = UI.getChildControl(enduranceRecoveryImageArea, "Static_DuplicationItemSlot")
  self._ui.txt_topGuide = UI.getChildControl(imagePartArea, "StaticText_TopGuide")
  self._ui.progress2_maxEndurance = UI.getChildControl(imagePartArea, "Progress2_Gray")
  self._ui.progress2_curEndurance = UI.getChildControl(imagePartArea, "Progress2_Red")
  self._ui.stc_enduranceValue = UI.getChildControl(imagePartArea, "StaticText_EnduranceValue")
  self._ui.txt_materialValue = UI.getChildControl(imagePartArea, "StaticText_Marterial")
  self._ui.txt_noItem = UI.getChildControl(rightArea, "StaticText_NoItem")
  local listContent = UI.getChildControl(self._ui.list2_recoveryList, "List2_1_Content")
  local btn_item = UI.getChildControl(listContent, "RadioButton_ExtractableItem")
  local itemSlotBg = UI.getChildControl(btn_item, "Static_ItemSlotBG")
  local itemIcon = UI.getChildControl(itemSlotBg, "Static_ItemIcon")
  local slot = {}
  SlotItem.new(slot, "Endurance_Recovery_All_TargetSlot_", 0, itemIcon, self._slotConfig)
  slot:createChild()
  slot.empty = true
  slot:clearItem()
  slot.icon:SetPosX(1)
  slot.icon:SetPosY(1)
  slot.border:SetSize(44, 44)
  listContent = UI.getChildControl(self._ui.list2_materialList, "List2_1_Content")
  btn_item = UI.getChildControl(listContent, "RadioButton_ExtractionMaterialItem")
  itemSlotBg = UI.getChildControl(btn_item, "Static_ItemSlotBG")
  itemIcon = UI.getChildControl(itemSlotBg, "Static_ItemIcon")
  slot = {}
  SlotItem.new(slot, "Endurance_Recovery_All_MaterialSlot_", 0, itemIcon, self._slotConfig)
  slot:createChild()
  slot.empty = true
  slot:clearItem()
  slot.icon:SetPosX(1)
  slot.icon:SetPosY(1)
  slot.border:SetSize(44, 44)
end
function PaGlobal_Endurance_Recovery_All:controlPc_Init()
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  local titlebarArea = UI.getChildControl(Panel_Window_Endurance_Recovery_All, "Static_TitlebarArea")
  self._ui_pc.btn_question = UI.getChildControl(titlebarArea, "Button_Question")
  self._ui_pc.btn_close = UI.getChildControl(titlebarArea, "Button_Close")
  local leftBotomArea = UI.getChildControl(Panel_Window_Endurance_Recovery_All, "Static_LeftBottomArea")
  self._ui_pc.btn_onceRecovery = UI.getChildControl(leftBotomArea, "Button_Once")
  self._ui_pc.btn_streamRecovery = UI.getChildControl(leftBotomArea, "Button_Stream")
end
function PaGlobal_Endurance_Recovery_All:controlConsole_Init()
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  self._ui_console.stc_guideBg = UI.getChildControl(Panel_Window_Endurance_Recovery_All, "Static_RIghtBottomConsole")
  self._ui_console.btn_iconX = UI.getChildControl(self._ui_console.stc_guideBg, "Button_Detail")
  self._ui_console.btn_iconA = UI.getChildControl(self._ui_console.stc_guideBg, "Button_Select")
  self._ui_console.btn_iconB = UI.getChildControl(self._ui_console.stc_guideBg, "Button_Cancel")
  local leftBotomArea = UI.getChildControl(Panel_Window_Endurance_Recovery_All, "Static_LeftBottomArea")
  self._ui_console.stc_buttonArea = UI.getChildControl(leftBotomArea, "Static_ConsoleButtonsArea")
  self._ui_console.btn_onceRecovery = UI.getChildControl(self._ui_console.stc_buttonArea, "Button_ConsoleButtonY2")
  self._ui_console.btn_streamRecovery = UI.getChildControl(self._ui_console.stc_buttonArea, "Static_ConsoleCombinationButtons")
end
function PaGlobal_Endurance_Recovery_All:SetUiSetting()
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  if false == PaGlobal_Endurance_Recovery_All._isConsole then
    self._ui_pc.btn_question:SetShow(true)
    self._ui_pc.btn_close:SetShow(true)
    self._ui_pc.btn_onceRecovery:SetShow(true)
    self._ui_pc.btn_streamRecovery:SetShow(true)
    self._ui_console.stc_buttonArea:SetShow(false)
    self._ui_console.btn_onceRecovery:SetShow(false)
    self._ui_console.btn_streamRecovery:SetShow(false)
    self._ui_console.stc_guideBg:SetShow(false)
  else
    self._ui_pc.btn_question:SetShow(false)
    self._ui_pc.btn_close:SetShow(false)
    self._ui_pc.btn_onceRecovery:SetShow(false)
    self._ui_pc.btn_streamRecovery:SetShow(false)
    self._ui_console.stc_buttonArea:SetShow(true)
    self._ui_console.btn_onceRecovery:SetShow(true)
    self._ui_console.btn_streamRecovery:SetShow(true)
    self._ui_console.stc_guideBg:SetShow(true)
    self._ui_console.stc_guideBg:SetPosY(Panel_Window_Endurance_Recovery_All:GetSizeY())
    local keyGuides = {
      self._ui_console.btn_iconX,
      self._ui_console.btn_iconA,
      self._ui_console.btn_iconB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.stc_guideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    self._ui_console.btn_iconX:SetShow(false)
    Panel_Window_Endurance_Recovery_All:ignorePadSnapMoveToOtherPanel()
  end
  FromClient_Endurance_Recovery_All_ReSizePanel()
end
function PaGlobal_Endurance_Recovery_All:registEventHandler()
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Endurance_Recovery_All_ReSizePanel()")
  self._ui.list2_recoveryList:registEvent(__ePAUIList2EventType_LuaChangeContent, "HandleEventLUp_Endurance_Recovery_All_RecoveryListControlCreate")
  self._ui.list2_recoveryList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list2_materialList:registEvent(__ePAUIList2EventType_LuaChangeContent, "HandleEventLUp_Endurance_Recovery_All_MaterialListControlCreate")
  self._ui.list2_materialList:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_InventoryUpdate", "FromClient_Endurance_Recovery_All_UpdateList")
  registerEvent("EventEquipmentUpdate", "FromClient_Endurance_Recovery_All_UpdateList")
  if false == self._isConsole then
    self._ui_pc.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelFixEquip\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui_pc.btn_question, "\"PanelFixEquip\"")
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Endurance_Recovery_All_Close()")
    self._ui_pc.btn_onceRecovery:addInputEvent("Mouse_LUp", "HandleEventLUp_Endurance_Recovery_All_OnceRecovery()")
    self._ui_pc.btn_streamRecovery:addInputEvent("Mouse_LUp", "HandleEventLUp_Endurance_Recovery_All_StreamRecovery()")
    self._ui_pc.btn_streamRecovery:addInputEvent("Mouse_On", "HandleEventOn_Endurance_Recovery_All_ShowCashItemToolTip(true,false)")
    self._ui_pc.btn_streamRecovery:addInputEvent("Mouse_Out", "HandleEventOn_Endurance_Recovery_All_ShowCashItemToolTip(false,false)")
  else
    Panel_Window_Endurance_Recovery_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventLUp_Endurance_Recovery_All_StreamRecovery()")
    Panel_Window_Endurance_Recovery_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Endurance_Recovery_All_OnceRecovery()")
  end
  self._ui.btn_useCashItem:addInputEvent("Mouse_LUp", "HandleEventLUp_Endurance_Recovery_All_CashItemBtn()")
  self._ui.btn_useCashItem:addInputEvent("Mouse_On", "HandleEventOn_Endurance_Recovery_All_ShowCashItemToolTip(true,true)")
  self._ui.btn_useCashItem:addInputEvent("Mouse_Out", "HandleEventOn_Endurance_Recovery_All_ShowCashItemToolTip(false,true)")
end
function PaGlobal_Endurance_Recovery_All:prepareOpen()
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  audioPostEvent_SystemUi(1, 0)
  _AudioPostEvent_SystemUiForXBOX(1, 0)
  self:openUiSetting()
  self:updateTopGuideText(self._eGuideType.selectItem)
  local posY = (getScreenSizeY() - Panel_Window_Endurance_Recovery_All:GetSizeY() - Panel_Dialog_Repair_Function_All:GetSizeY()) * 0.5
  Panel_Window_Endurance_Recovery_All:SetPosY(posY)
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  PaGlobal_Endurance_Recovery_All:open()
end
function PaGlobal_Endurance_Recovery_All:open()
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  Panel_Window_Endurance_Recovery_All:SetShow(true)
end
function PaGlobal_Endurance_Recovery_All:prepareClose()
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
  PaGlobal_Endurance_Recovery_All_CloseSetting()
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  PaGlobal_Endurance_Recovery_All:close()
end
function PaGlobal_Endurance_Recovery_All:close()
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  Panel_Window_Endurance_Recovery_All:SetShow(false)
end
function PaGlobal_Endurance_Recovery_All:validate()
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  self:allValidate()
  self:pcValidate()
  self:consoleValidate()
end
function PaGlobal_Endurance_Recovery_All:allValidate()
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  self._ui.stc_leftTopDesc:isValidate()
  self._ui.list2_recoveryList:isValidate()
  self._ui.list2_materialList:isValidate()
  self._ui.btn_useCashItem:isValidate()
  self._ui.txt_useItemCount:isValidate()
  self._ui.stc_recoveryItemSlot:isValidate()
  self._ui.stc_memoryItemSlot:isValidate()
  self._ui.stc_meterialItemSlot:isValidate()
  self._ui.progress2_maxEndurance:isValidate()
  self._ui.progress2_curEndurance:isValidate()
  self._ui.stc_enduranceValue:isValidate()
end
function PaGlobal_Endurance_Recovery_All:pcValidate()
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  self._ui_pc.btn_question:isValidate()
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.btn_onceRecovery:isValidate()
  self._ui_pc.btn_streamRecovery:isValidate()
end
function PaGlobal_Endurance_Recovery_All:consoleValidate()
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  self._ui_console.stc_guideBg:isValidate()
  self._ui_console.btn_iconA:isValidate()
  self._ui_console.btn_iconB:isValidate()
end
function PaGlobal_Endurance_Recovery_All:updateEnduranceList()
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  self:updateRecoveryList()
  self:updateMaterialList()
end
function PaGlobal_Endurance_Recovery_All:resetRecoveryListInfo()
  self._recoveryItemCnt = 0
  self._recoveryItemInfo.name = {}
  self._recoveryItemInfo.iconPath = {}
  self._recoveryItemInfo.slotNo = {}
  self._recoveryItemInfo.curEndurance = {}
  self._recoveryItemInfo.recoveryEndurance = {}
  self._recoveryItemInfo.maxendurance = {}
  self._recoveryItemInfo.itemEnchantLevle = {}
  self._recoveryItemInfo.isRecoveryEquip = {}
  self._equipCnt = 0
  self._equipNo = {}
end
function PaGlobal_Endurance_Recovery_All:updateRecoveryList()
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  self._ui.list2_recoveryList:getElementManager():clearKey()
  local whereType = CppEnums.ItemWhereType.eInventory
  local inventory = getSelfPlayer():get():getInventory(whereType)
  if nil == inventory then
    return
  end
  PaGlobal_Endurance_Recovery_All:resetRecoveryListInfo()
  local isEquip = false
  local invenMaxSize = inventory:size()
  for slotNo = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(whereType, slotNo)
    if nil ~= itemWrapper and true == itemWrapper:checkToRepairItemMaxEndurance() and nil ~= itemWrapper:getStaticStatus():get()._repairEnduranceCount then
      self:setRecoveryListInfo(isEquip, slotNo, itemWrapper)
    end
  end
  isEquip = true
  local EquipNoMin = CppEnums.EquipSlotNo.rightHand
  local EquipNoMax = CppEnums.EquipSlotNo.equipSlotNoCount
  for equipNo = EquipNoMin, EquipNoMax do
    local itemWrapper = ToClient_getEquipmentItem(equipNo)
    if nil ~= itemWrapper and true == itemWrapper:checkToRepairItemMaxEndurance() and nil ~= itemWrapper:getStaticStatus():get()._repairEnduranceCount then
      self:setRecoveryListInfo(isEquip, equipNo, itemWrapper)
    end
  end
  if 0 == self._recoveryItemCnt then
    self._ui.txt_noItem:SetShow(true)
    self._ui.list2_recoveryList:SetIgnore(true)
    self._ui.list2_recoveryList:SetShow(false)
  else
    self._ui.txt_noItem:SetShow(false)
    self._ui.list2_recoveryList:SetIgnore(false)
    self._ui.list2_recoveryList:SetShow(true)
  end
end
function PaGlobal_Endurance_Recovery_All:setRecoveryListInfo(isEquip, value, itemWrapper)
  UI.ASSERT_NAME(nil ~= value, "PaGlobal_Endurance_Recovery_All:setRecoveryListInfo\236\157\152 value nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if nil == itemWrapper then
    return
  end
  self._recoveryItemCnt = self._recoveryItemCnt + 1
  self._equipNo[self._recoveryItemCnt] = nil
  self._ui.list2_recoveryList:getElementManager():pushKey(toInt64(0, self._recoveryItemCnt))
  local enchantLevel = itemWrapper:getStaticStatus():get()._key:getEnchantLevel()
  local enchantText = ""
  if 16 <= enchantLevel then
    enchantText = HighEnchantLevel_ReplaceString(enchantLevel) .. " "
  end
  self._recoveryItemInfo.name[self._recoveryItemCnt] = enchantText .. itemWrapper:getStaticStatus():getName()
  self._recoveryItemInfo.iconPath[self._recoveryItemCnt] = itemWrapper:getStaticStatus():getIconPath()
  self._recoveryItemInfo.curEndurance[self._recoveryItemCnt] = itemWrapper:get():getEndurance()
  self._recoveryItemInfo.recoveryEndurance[self._recoveryItemCnt] = itemWrapper:get():getMaxEndurance()
  self._recoveryItemInfo.maxendurance[self._recoveryItemCnt] = itemWrapper:getStaticStatus():get():getMaxEndurance()
  if false == isEquip then
    self._recoveryItemInfo.slotNo[self._recoveryItemCnt] = value
  else
    self._equipCnt = self._equipCnt + 1
    self._equipNo[self._recoveryItemCnt] = value
  end
  local isEquipAble = itemWrapper:getStaticStatus():isEquipable()
  local isCash = itemWrapper:getStaticStatus():get():isCash()
  local isAccessory = CppEnums.ItemClassifyType.eItemClassify_Accessory == itemWrapper:getStaticStatus():getItemClassify()
  if 0 < ToClient_getSpecialEnchantDisplayLevel(itemWrapper:getStaticStatus():get()._key) then
    enchantLevel = ToClient_getSpecialEnchantDisplayLevel(itemWrapper:getStaticStatus():get()._key)
    isAccessory = false
  end
  local balksCnt = itemWrapper:getStaticStatus():getExtractionCount_s64()
  local cronsCnt = itemWrapper:getStaticStatus():getCronCount_s64()
  self._recoveryItemInfo.itemEnchantLevle[self._recoveryItemCnt] = self:getEnchantText(isEquipAble, isCash, isAccessory, balksCnt, cronsCnt, enchantLevel)
end
function PaGlobal_Endurance_Recovery_All:updateMaterialList()
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  self._ui.list2_materialList:getElementManager():clearKey()
  local whereType = CppEnums.ItemWhereType.eInventory
  local inventory = getSelfPlayer():get():getInventory(whereType)
  if nil == inventory then
    return
  end
  self._materialItemCnt = 0
  local invenMaxSize = inventory:size()
  for slotNo = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(whereType, slotNo)
    if false == self:filterMaterialItem(slotNo, whereType, itemWrapper) then
      self:setMaterialListInfo(slotNo, whereType, itemWrapper:getStaticStatus())
    end
  end
  if 0 == self._materialItemCnt then
    self._ui.list2_materialList:SetIgnore(true)
    self._ui.list2_materialList:SetShow(false)
  else
    self._ui.list2_materialList:SetIgnore(false)
    self._ui.list2_materialList:SetShow(true)
  end
end
function PaGlobal_Endurance_Recovery_All:filterMaterialItem(slotNo, whereType, itemWrapper)
  UI.ASSERT_NAME(nil ~= slotNo, "PaGlobal_Endurance_Recovery_All:filterMaterialItem\236\157\152 slotNo nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= whereType, "PaGlobal_Endurance_Recovery_All:filterMaterialItem\236\157\152 whereType nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if nil == itemWrapper then
    return true
  end
  if nil ~= self._repairItemKey and true == itemWrapper:checkToRepairItemMaxEnduranceWithMoneyAndItem(self._repairItemKey) and (self._recoveryItemSlotNo ~= slotNo or self._recoveryItemWhereType ~= whereType) then
    return false
  end
  return true
end
function PaGlobal_Endurance_Recovery_All:setMaterialListInfo(slotNo, whereType, itemSSW)
  UI.ASSERT_NAME(nil ~= slotNo, "PaGlobal_Endurance_Recovery_All:setMaterialListInfo\236\157\152 slotNo nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= whereType, "PaGlobal_Endurance_Recovery_All:setMaterialListInfo\236\157\152 whereType nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if nil == itemSSW then
    return
  end
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  local enchantText = ""
  if 16 <= enchantLevel then
    enchantText = HighEnchantLevel_ReplaceString(enchantLevel) .. " "
  end
  for index = 1, self._materialItemCnt do
    if self._materialItemInfo.name[index] == enchantText .. itemSSW:getName() then
      self._materialItemInfo.itemCnt[index] = self._materialItemInfo.itemCnt[index] + 1
      return
    end
  end
  self._materialItemCnt = self._materialItemCnt + 1
  self._ui.list2_materialList:getElementManager():pushKey(toInt64(0, self._materialItemCnt))
  self._materialItemInfo.name[self._materialItemCnt] = enchantText .. itemSSW:getName()
  self._materialItemInfo.iconPath[self._materialItemCnt] = itemSSW:getIconPath()
  self._materialItemInfo.slotNo[self._materialItemCnt] = slotNo
  local itemCnt = 0
  if 255 ~= slotNo then
    itemCnt = Int64toInt32(getInventoryItemByType(whereType, slotNo):get():getCount_s64())
  end
  self._materialItemInfo.itemCnt[self._materialItemCnt] = itemCnt
  local isEquipAble = itemSSW:isEquipable()
  local isCash = itemSSW:get():isCash()
  local isAccessory = CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify()
  if 0 < ToClient_getSpecialEnchantDisplayLevel(itemSSW:get()._key) then
    enchantLevel = ToClient_getSpecialEnchantDisplayLevel(itemSSW:get()._key)
    isAccessory = false
  end
  local balksCnt = itemSSW:getExtractionCount_s64()
  local cronsCnt = itemSSW:getCronCount_s64()
  self._materialItemInfo.itemEnchantLevle[self._materialItemCnt] = self:getEnchantText(isEquipAble, isCash, isAccessory, balksCnt, cronsCnt, enchantLevel)
end
function PaGlobal_Endurance_Recovery_All:setRecoveryIcon(itemWrapper, slotNo)
  UI.ASSERT_NAME(nil ~= itemWrapper, "PaGlobal_Endurance_Recovery_All:setRecoveryIcon\236\157\152 itemWrapper nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= slotNo, "PaGlobal_Endurance_Recovery_All:setRecoveryIcon\236\157\152 slotNo nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  if self._recoveryItemSlotNo ~= 255 and self._recoveryItemSlotNo ~= slotNo and true == self._isStreamRecovery then
    self:clearAllSlot()
    return
  end
  local staticStatus = itemWrapper:getStaticStatus()
  if nil == staticStatus or true == self._isAniStart then
    return
  end
  local itemKey = itemWrapper:get():getKey()
  self._repairItemKey = itemKey
  self._recoveryItemSlotNo = slotNo
  self._ui.progress2_maxEndurance:SetShow(true)
  self._ui.progress2_curEndurance:SetShow(true)
  local curEndurance = itemWrapper:get():getEndurance()
  local recoveryEndurance = itemWrapper:get():getMaxEndurance()
  local maxEndurance = itemWrapper:getStaticStatus():get():getMaxEndurance()
  if recoveryEndurance == maxEndurance then
    HandleEventRUp_Endurance_Recovery_All_ClearAllSlot()
    return
  end
  self._ui.progress2_maxEndurance:SetProgressRate(recoveryEndurance / maxEndurance * 100)
  self._ui.progress2_curEndurance:SetProgressRate(curEndurance / maxEndurance * 100)
  self:updateEnduranceValueText(self._ui.stc_enduranceValue, recoveryEndurance, maxEndurance)
  self:updateMaterialValueText(self._ui.txt_materialValue, recoveryEndurance, maxEndurance)
  self._ui._icon_items:setItemByStaticStatus(staticStatus, Defines.s64_const.s64_1)
  self._ui._icon_items.icon:addInputEvent("Mouse_On", "HandleEventOn_Endurance_Recovery_All_ShowListToolTip(false," .. self._recoveryItemSlotNo .. ",true)")
  self._ui._icon_items.icon:addInputEvent("Mouse_Out", "HandleEventOn_Endurance_Recovery_All_ShowListToolTip(false," .. self._recoveryItemSlotNo .. ",false)")
  self._ui._icon_items.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Endurance_Recovery_All_ClearAllSlot()")
  self:setCashItemIcon()
end
function PaGlobal_Endurance_Recovery_All:setCashItemIcon()
  local cashItemStaticStatus = getItemEnchantStaticStatus(self._materialEnchantKey.cashItem)
  local inventory = getSelfPlayer():get():getCashInventory()
  if nil == inventory then
    return
  end
  local cashItemCount = inventory:getItemCount_s64(cashItemStaticStatus:get()._key)
  self._ui._icon_cashItem.icon:addInputEvent("Mouse_On", "HandleEventOn_Endurance_Recovery_All_ShowToolTip(" .. self._materialEnchantKey.cashItem:getItemKey() .. ",true)")
  self._ui._icon_cashItem.icon:addInputEvent("Mouse_Out", "HandleEventOn_Endurance_Recovery_All_ShowToolTip(" .. self._materialEnchantKey.cashItem:getItemKey() .. ",false)")
  local eventItemStaticStauts = getItemEnchantStaticStatus(self._materialEnchantKey.eventItem)
  local eventItemCount = inventory:getItemCount_s64(eventItemStaticStauts:get()._key)
  self._useItemCount = Int64toInt32(cashItemCount) + Int64toInt32(eventItemCount)
  self._ui._icon_cashItem:setItemByStaticStatus(eventItemStaticStauts, Int64toInt32(self._useItemCount))
  self._ui.txt_useItemCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENDURANCE_RECOVERY_METERIALITEMCNT", "count", tostring(self._useItemCount)))
  if 0 == self._useItemCount then
    self._ui._icon_cashItem.icon:SetMonoTone(true)
    self._ui.btn_useCashItem:SetCheck(false)
    if true == self._isUseCashItem then
      self._isStreamRecovery = false
    end
    self._isUseCashItem = false
  else
    self._ui._icon_cashItem.icon:SetMonoTone(false)
  end
end
function PaGlobal_Endurance_Recovery_All:setMaterialIcon(itemWrapper)
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  if nil == itemWrapper then
    PaGlobal_Endurance_Recovery_All:clearMaterialSlot()
    return
  end
  local itemKey = itemWrapper:get():getKey()
  if nil == itemKey then
    return
  end
  local staticStatus = itemWrapper:getStaticStatus()
  if nil == staticStatus or true == self._isAniStart then
    return
  end
  self._materialItemKey = itemKey
  self._ui._icon_materialItem:clearItem()
  local itemSlot = getSelfPlayer():get():getInventory():getSlot(itemKey)
  if nil == itemSlot then
    return
  end
  local itemCnt = Int64toInt32(itemWrapper:get():getCount_s64())
  self._ui._icon_materialItem:setItemByStaticStatus(staticStatus, itemCnt)
  if false == self._isConsole then
    self._ui._icon_materialItem.icon:addInputEvent("Mouse_On", "HandleEventOn_Endurance_Recovery_All_ShowToolTip(" .. itemKey:getItemKey() .. ",true)")
    self._ui._icon_materialItem.icon:addInputEvent("Mouse_Out", "HandleEventOn_Endurance_Recovery_All_ShowToolTip(" .. itemKey:getItemKey() .. ",false)")
    self._ui._icon_materialItem.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Endurance_Recovery_All_ClearMaterialSlot()")
    self._ui_pc.btn_onceRecovery:SetEnable(true)
    self._ui_pc.btn_onceRecovery:SetMonoTone(false)
    self._ui_pc.btn_streamRecovery:SetMonoTone(false)
  else
    Panel_Window_Endurance_Recovery_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventLUp_Endurance_Recovery_All_StreamRecovery()")
    Panel_Window_Endurance_Recovery_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Endurance_Recovery_All_OnceRecovery()")
    self._ui_console.btn_onceRecovery:SetMonoTone(false)
    self._ui_console.btn_streamRecovery:SetMonoTone(false)
  end
  self._fromSlotOn = true
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_Endurance_Recovery_All:clearAllSlot()
  self._ui._icon_items:clearItem()
  self._ui._icon_materialItem:clearItem()
  self._ui._icon_items.icon:addInputEvent("Mouse_On", "")
  self._ui._icon_items.icon:addInputEvent("Mouse_Out", "")
  self._ui._icon_materialItem.icon:addInputEvent("Mouse_On", "")
  self._ui._icon_materialItem.icon:addInputEvent("Mouse_Out", "")
  self._fromSlotOn = false
  self._repairItemKey = nil
  self._recoveryItemSlotNo = 255
  self._materialItemKey = nil
  self._isStreamRecovery = false
  self._isRecovery = false
  self:setCashItemIcon()
  self._ui.progress2_maxEndurance:SetShow(false)
  self._ui.progress2_curEndurance:SetShow(false)
  self:updateEnduranceValueText(self._ui.stc_enduranceValue, 0, 0)
  self:updateMaterialValueText(self._ui.txt_materialValue, 0, 0)
  if false == self._isConsole then
    self._ui_pc.btn_onceRecovery:SetEnable(false)
    self._ui_pc.btn_onceRecovery:SetMonoTone(true)
    self._ui_pc.btn_streamRecovery:SetMonoTone(true)
  else
    Panel_Window_Endurance_Recovery_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "")
    Panel_Window_Endurance_Recovery_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    self._ui_console.btn_onceRecovery:SetMonoTone(true)
    self._ui_console.btn_streamRecovery:SetMonoTone(true)
  end
  for index = 1, self._recoveryItemCnt do
    self._recoveryItemInfo.isRecoveryEquip[index] = false
  end
  for index = 1, self._materialItemCnt do
    self._materialItemInfo.isMaterialEquip[index] = false
  end
  Panel_Tooltip_Item_hideTooltip()
  self:updateTopGuideText(self._eGuideType.selectItem)
end
function PaGlobal_Endurance_Recovery_All:clearMaterialSlot()
  self._ui._icon_materialItem:clearItem()
  self._ui._icon_materialItem.icon:addInputEvent("Mouse_On", "")
  self._ui._icon_materialItem.icon:addInputEvent("Mouse_Out", "")
  self._materialItemKey = nil
  self._isStreamRecovery = false
  self._selectedMaterialSlotNo = nil
  if false == self._isConsole then
    self._ui_pc.btn_onceRecovery:SetEnable(false)
    self._ui_pc.btn_onceRecovery:SetMonoTone(true)
    self._ui_pc.btn_streamRecovery:SetMonoTone(true)
  else
    Panel_Window_Endurance_Recovery_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "")
    Panel_Window_Endurance_Recovery_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    self._ui_console.btn_onceRecovery:SetMonoTone(true)
    self._ui_console.btn_streamRecovery:SetMonoTone(true)
  end
  for index = 1, self._materialItemCnt do
    self._materialItemInfo.isMaterialEquip[index] = false
  end
  self:updateMaterialList()
  self:updateTopGuideText(self._eGuideType.selectMaterial)
end
function PaGlobal_Endurance_Recovery_All:openUiSetting()
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  self._lastIndex = 0
  self:setCashItemIcon()
  for index = 1, self._recoveryItemCnt do
    self._recoveryItemInfo.isRecoveryEquip[index] = false
  end
  for index = 1, self._materialItemCnt do
    self._materialItemInfo.isMaterialEquip[index] = false
  end
  PaGlobal_Endurance_Recovery_All_UpdateList()
  if false == self._isConsole then
    self._ui_pc.btn_onceRecovery:SetEnable(false)
    self._ui_pc.btn_onceRecovery:SetMonoTone(true)
    self._ui_pc.btn_streamRecovery:SetMonoTone(true)
  else
    Panel_Window_Endurance_Recovery_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "")
    Panel_Window_Endurance_Recovery_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    self._ui_console.btn_onceRecovery:SetMonoTone(true)
    self._ui_console.btn_streamRecovery:SetMonoTone(true)
  end
  self._ui.progress2_maxEndurance:SetShow(false)
  self._ui.progress2_curEndurance:SetShow(false)
  self:updateEnduranceValueText(self._ui.stc_enduranceValue, 0, 0)
  self:updateMaterialValueText(self._ui.txt_materialValue, 0, 0)
  self._ui.btn_useCashItem:SetCheck(false)
  self._isUseCashItem = false
end
function PaGlobal_Endurance_Recovery_All:setNotice()
  if nil == Panel_Window_Endurance_Recovery_All then
    return
  end
  self._ui.stc_leftTopDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_leftTopDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FIXEQUIP_FIXHELP"))
  if self._ui.stc_leftTopDesc:GetTextSizeY() > self._ui.stc_leftTopDesc:GetSizeY() then
    local sizeY = self._ui.stc_leftTopDesc:GetTextSizeY() - self._ui.stc_leftTopDesc:GetSizeY()
    self._ui.stc_leftTopDesc:SetSize(self._ui.stc_leftTopDesc:GetSizeX(), self._ui.stc_leftTopDesc:GetTextSizeY())
    local leftMainArea = UI.getChildControl(Panel_Window_Endurance_Recovery_All, "Static_LeftMainArea")
    leftMainArea:SetSize(leftMainArea:GetSizeX(), leftMainArea:GetSizeY() + sizeY)
    local topDescArea = UI.getChildControl(leftMainArea, "Static_TopDescArea")
    topDescArea:SetSize(topDescArea:GetSizeX(), topDescArea:GetSizeY() + sizeY)
    local rightArea = UI.getChildControl(Panel_Window_Endurance_Recovery_All, "Static_RightBottomArea")
    rightArea:SetSize(rightArea:GetSizeX(), rightArea:GetSizeY() + sizeY)
    self._ui.list2_materialList:SetSize(self._ui.list2_materialList:GetSizeX(), self._ui.list2_materialList:GetSizeY() + sizeY)
    Panel_Window_Endurance_Recovery_All:SetSize(Panel_Window_Endurance_Recovery_All:GetSizeX(), Panel_Window_Endurance_Recovery_All:GetSizeY() + sizeY)
    UI.getChildControl(leftMainArea, "Static_HorizonLine"):ComputePos()
    UI.getChildControl(leftMainArea, "Static_BottomImageArea"):ComputePos()
    UI.getChildControl(Panel_Window_Endurance_Recovery_All, "Static_LeftBottomArea"):ComputePos()
    leftMainArea:ComputePos()
    topDescArea:ComputePos()
    FromClient_Endurance_Recovery_All_ReSizePanel()
  end
end
function PaGlobal_Endurance_Recovery_All:getEnchantText(isEquipable, isCash, isAccessory, balksCnt, cronsCnt, enchantLev)
  local enchantText = ""
  if true == isEquipable and 0 < enchantLev and enchantLev < 16 then
    enchantText = "+" .. tostring(enchantLev)
  elseif true == isEquipable and 16 == enchantLev then
    enchantText = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_1")
  elseif true == isEquipable and 17 == enchantLev then
    enchantText = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_2")
  elseif true == isEquipable and 18 == enchantLev then
    enchantText = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_3")
  elseif true == isEquipable and 19 == enchantLev then
    enchantText = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_4")
  elseif true == isEquipable and 20 == enchantLev then
    enchantText = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_5")
  else
    enchantText = ""
  end
  if true == isAccessory then
    if 1 == enchantLev then
      enchantText = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_1")
    elseif 2 == enchantLev then
      enchantText = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_2")
    elseif 3 == enchantLev then
      enchantText = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_3")
    elseif 4 == enchantLev then
      enchantText = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_4")
    elseif 5 == enchantLev then
      enchantText = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_5")
    end
  end
  if true == isCash then
    enchantText = ""
  end
  if false == isCash and nil ~= balksCnt and toInt64(0, 0) ~= balksCnt and nil ~= cronsCnt and toInt64(0, 0) ~= cronsCnt then
    enchantText = ""
  end
  return enchantText
end
function PaGlobal_Endurance_Recovery_All:updateTopGuideText(guideType)
  if self._eGuideType.selectItem == guideType then
    self._ui.txt_topGuide:SetShow(true)
    self._ui.txt_topGuide:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENDURANCE_RECOVERY_GUIDE_SELECTITEM"))
  elseif self._eGuideType.selectMaterial == guideType then
    self._ui.txt_topGuide:SetShow(true)
    self._ui.txt_topGuide:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENDURANCE_RECOVERY_GUIDE_SELECTMATERIAL"))
  elseif self._eGuideType.recovery == guideType then
    self._ui.txt_topGuide:SetShow(false)
  end
end
function PaGlobal_Endurance_Recovery_All:updateEnduranceValueText(control, recoveryEndurance, maxEndurance)
  local enduranceValue = recoveryEndurance .. "<PAColor0xFFA78E6A>" .. " (" .. maxEndurance .. ")" .. "<PAOldColor>"
  control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENDURANCE_RECOVERY_ENDURANCE_VALUE", "value", enduranceValue))
end
function PaGlobal_Endurance_Recovery_All:updateMaterialValueText(control, recoveryEndurance, maxEndurance)
  local materialValue = "<PAColor0xFF95D048>" .. maxEndurance - recoveryEndurance .. "<PAOldColor>"
  control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENDURANCE_RECOVERY_MATERIAL_VALUE", "value", materialValue))
end
function PaGlobal_Endurance_Recovery_All:getMaterialFirstItem(materialItemKey)
  local whereType = CppEnums.ItemWhereType.eInventory
  local inventory = getSelfPlayer():get():getInventory(whereType)
  if nil == inventory then
    return nil
  end
  local invenMaxSize = inventory:size()
  for slotNo = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(whereType, slotNo)
    if false == self:filterMaterialItem(slotNo, whereType, itemWrapper) and itemWrapper:get():getKey():getItemKey() == materialItemKey:getItemKey() then
      return slotNo
    end
  end
  return nil
end
