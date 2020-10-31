function PaGlobal_Extraction_System_All:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self._originListSizeY = self._ui.list2_extractableItem:GetSizeY()
  self._originDescSizeY = self._ui.txt_leftBottomDesc:GetSizeY()
  self:SetUiSetting()
  self:setNotice()
  self._ui.list2_extractableItem:SetSize(self._ui.list2_extractableItem:GetSizeX(), self._ui.list2_extractableItem:GetSizeY())
  self._ui.list2_extractableItem:setNotImpactScrollEvent(true)
  self._ui._icon_items = {}
  SlotItem.new(self._ui._icon_items, "feeItem", nil, self._ui.stc_extractableItemSlot, self._slotConfig)
  self._ui._icon_items:createChild()
  self._ui._icon_items:clearItem()
  self._ui._icon_material = {}
  SlotItem.new(self._ui._icon_material, "resultItem", nil, self._ui.stc_materialItemSlot, self._slotConfig)
  self._ui._icon_material:createChild()
  self._ui._icon_material:clearItem()
  self._ui._icon_resultItem = {}
  SlotItem.new(self._ui._icon_resultItem, "resultItem", nil, self._ui.stc_resultItmeSlot, self._slotConfig)
  self._ui._icon_resultItem:createChild()
  self._ui._icon_resultItem:clearItem()
  self._ui._icon_resultMaterial = {}
  SlotItem.new(self._ui._icon_resultMaterial, "resultItem", nil, self._ui.stc_resultMaterialItemSlot, self._slotConfig)
  self._ui._icon_resultMaterial:createChild()
  self._ui._icon_resultMaterial:clearItem()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Extraction_System_All:controlAll_Init()
  if nil == Panel_Window_Extraction_System_All then
    return
  end
  local leftMainImgArea = UI.getChildControl(Panel_Window_Extraction_System_All, "Static_LeftMainImageArea")
  self._ui.txt_noMaterial = UI.getChildControl(leftMainImgArea, "StaticText_NeedMaterial")
  self._ui.stc_extractableItemSlot = UI.getChildControl(leftMainImgArea, "Static_ExtractionItemSlot")
  self._ui.stc_materialItemSlot = UI.getChildControl(leftMainImgArea, "Static_ExtractionMaterialItemSlot")
  self._ui.stc_resultItmeSlot = UI.getChildControl(leftMainImgArea, "Static_ExtractionResultItemSlot")
  self._ui.stc_resultMaterialItemSlot = UI.getChildControl(leftMainImgArea, "Static_ExtractionResultMaterialSlot")
  local leftBottomDescArea = UI.getChildControl(Panel_Window_Extraction_System_All, "Static_LeftBottomDescArea")
  self._ui.txt_leftBottomDesc = UI.getChildControl(leftBottomDescArea, "StaticText_LeftBottomDesc")
  local leftBottomBtnArea = UI.getChildControl(Panel_Window_Extraction_System_All, "Static_LeftBottomButtonArea")
  self._ui.btn_skipAni = UI.getChildControl(leftBottomBtnArea, "CheckButton_SkipAni")
  local rightArea = UI.getChildControl(Panel_Window_Extraction_System_All, "Static_RightArea")
  self._ui.list2_extractableItem = UI.getChildControl(rightArea, "List2_ExtractableItemList")
  self._ui.txt_leftBottomDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_leftBottomDesc:SetText(self._ui.txt_leftBottomDesc:GetText())
  self._ui.txt_noItem = UI.getChildControl(self._ui.list2_extractableItem, "StaticText_Desc")
end
function PaGlobal_Extraction_System_All:controlPc_Init()
  if nil == Panel_Window_Extraction_System_All then
    return
  end
  local titleArea = UI.getChildControl(Panel_Window_Extraction_System_All, "Static_TitlebarArea")
  self._ui_pc.btn_close = UI.getChildControl(titleArea, "Button_Close")
  local leftBottomBtnArea = UI.getChildControl(Panel_Window_Extraction_System_All, "Static_LeftBottomButtonArea")
  self._ui_pc.btn_extraction = UI.getChildControl(leftBottomBtnArea, "Button_Extraction")
end
function PaGlobal_Extraction_System_All:controlConsole_Init()
  if nil == Panel_Window_Extraction_System_All then
    return
  end
  local leftBottomBtnArea = UI.getChildControl(Panel_Window_Extraction_System_All, "Static_LeftBottomButtonArea")
  self._ui_console.stc_iconY_extraction = UI.getChildControl(leftBottomBtnArea, "Button_ConsoleButtonY")
  self._ui_console.stc_bottomGuideBg = UI.getChildControl(Panel_Window_Extraction_System_All, "Static_BottomConsoleButtons")
  self._ui_console.stc_iconX = UI.getChildControl(self._ui_console.stc_bottomGuideBg, "Button_Detail")
  self._ui_console.stc_iconA = UI.getChildControl(self._ui_console.stc_bottomGuideBg, "Button_Select")
  self._ui_console.stc_iconB = UI.getChildControl(self._ui_console.stc_bottomGuideBg, "Button_Cancel")
end
function PaGlobal_Extraction_System_All:SetUiSetting()
  if nil == Panel_Window_Extraction_System_All then
    return
  end
  if false == PaGlobal_Extraction_System_All._isConsole then
    self._ui_pc.btn_close:SetShow(true)
    self._ui_pc.btn_extraction:SetShow(true)
    self._ui_console.stc_iconY_extraction:SetShow(false)
    self._ui_console.stc_bottomGuideBg:SetShow(false)
  else
    self._ui_pc.btn_close:SetShow(false)
    self._ui_pc.btn_extraction:SetShow(false)
    self._ui_console.stc_iconY_extraction:SetShow(true)
    self._ui_console.stc_bottomGuideBg:SetShow(true)
    self._ui_console.stc_bottomGuideBg:SetPosY(Panel_Window_Extraction_System_All:GetSizeY())
    local keyGuides = {
      self._ui_console.stc_iconX,
      self._ui_console.stc_iconA,
      self._ui_console.stc_iconB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.stc_bottomGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    self._ui_console.stc_iconX:SetShow(false)
    Panel_Window_Extraction_System_All:ignorePadSnapMoveToOtherPanel()
  end
  FromClient_Extraction_System_All_ReSizePanel()
end
function PaGlobal_Extraction_System_All:registEventHandler()
  if nil == Panel_Window_Extraction_System_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Extraction_System_All_ReSizePanel()")
  self._ui.list2_extractableItem:registEvent(__ePAUIList2EventType_LuaChangeContent, "HandleEventLUp_Extraction_System_All_ListControlCreate")
  self._ui.list2_extractableItem:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_InventoryUpdate", "PaGlobal_Extraction_System_All_UpdateList")
  registerEvent("EventEquipmentUpdate", "PaGlobal_Extraction_System_All_UpdateList")
  registerEvent("FromClient_GetExtractResult", "FromClient_Extraction_System_All_GetExtractResult")
  if false == self._isConsole then
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Extraction_System_All_Close()")
    self._ui_pc.btn_extraction:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_System_All_Extraction()")
  else
    Panel_Window_Extraction_System_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Extraction_System_All_Extraction()")
  end
  self._ui.btn_skipAni:addInputEvent("Mouse_LUp", "HandleEventOn_Extraction_System_All_SkipAniButton()")
end
function PaGlobal_Extraction_System_All:prepareOpen()
  if nil == Panel_Window_Extraction_System_All then
    return
  end
  self._resultItemKey = nil
  self._resultMaterialKey = nil
  self._isEndExtraction = false
  self._lastIndex = 0
  self.updateExtractionList()
  self._ui_pc.btn_extraction:SetEnable(false)
  self._ui_pc.btn_extraction:SetMonoTone(true)
  Panel_Window_Extraction_System_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  self._ui_console.stc_iconY_extraction:SetMonoTone(true)
  self._ui.btn_skipAni:SetCheck(false)
  self._isSkipAni = false
  local posY = (getScreenSizeY() - Panel_Window_Extraction_System_All:GetSizeY() - Panel_Window_Extraction_All:GetSizeY()) * 0.5
  Panel_Window_Extraction_System_All:SetPosY(posY)
  PaGlobal_Extraction_System_All:open()
end
function PaGlobal_Extraction_System_All:open()
  if nil == Panel_Window_Extraction_System_All then
    return
  end
  Panel_Window_Extraction_System_All:SetShow(true)
end
function PaGlobal_Extraction_System_All:prepareClose()
  if nil == Panel_Window_Extraction_System_All then
    return
  end
  audioPostEvent_SystemUi(5, 99)
  _AudioPostEvent_SystemUiForXBOX(5, 99)
  Panel_Window_Extraction_System_All:ClearUpdateLuaFunc()
  PaGlobal_Extraction_System_All:close()
end
function PaGlobal_Extraction_System_All:close()
  if nil == Panel_Window_Extraction_System_All then
    return
  end
  Panel_Window_Extraction_System_All:SetShow(false)
end
function PaGlobal_Extraction_System_All:validate()
  if nil == Panel_Window_Extraction_System_All then
    return
  end
  self:allValidate()
  self:pcValidate()
  self:consoleValidate()
end
function PaGlobal_Extraction_System_All:allValidate()
  if nil == Panel_Window_Extraction_System_All then
    return
  end
  self._ui.stc_extractableItemSlot:isValidate()
  self._ui.stc_materialItemSlot:isValidate()
  self._ui.stc_resultItmeSlot:isValidate()
  self._ui.stc_resultMaterialItemSlot:isValidate()
  self._ui.txt_leftBottomDesc:isValidate()
  self._ui.btn_skipAni:isValidate()
  self._ui.list2_extractableItem:isValidate()
end
function PaGlobal_Extraction_System_All:pcValidate()
  if nil == Panel_Window_Extraction_System_All then
    return
  end
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.btn_extraction:isValidate()
end
function PaGlobal_Extraction_System_All:consoleValidate()
  if nil == Panel_Window_Extraction_System_All then
    return
  end
end
function PaGlobal_Extraction_System_All:updateExtractionList()
  if nil == Panel_Window_Extraction_System_All then
    return
  end
  PaGlobal_Extraction_System_All._ui.list2_extractableItem:getElementManager():clearKey()
  local whereType = CppEnums.ItemWhereType.eInventory
  local inventory = getSelfPlayer():get():getInventory(whereType)
  if nil == inventory then
    return
  end
  PaGlobal_Extraction_System_All._equipCnt = 0
  PaGlobal_Extraction_System_All._systemCnt = 0
  local EquipNoMin = CppEnums.EquipSlotNo.rightHand
  local EquipNoMax = CppEnums.EquipSlotNo.equipSlotNoCount
  local invenMaxSize = inventory:sizeXXX()
  for slotNo = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(whereType, slotNo)
    if false == PaGlobal_Extraction_System_All:fillter_ForSacrificeTarget(slotNo, itemWrapper, whereType) then
      PaGlobal_Extraction_System_All._systemCnt = PaGlobal_Extraction_System_All._systemCnt + 1
      PaGlobal_Extraction_System_All._equipNo[PaGlobal_Extraction_System_All._systemCnt] = nil
      PaGlobal_Extraction_System_All._ui.list2_extractableItem:getElementManager():pushKey(toInt64(0, PaGlobal_Extraction_System_All._systemCnt))
      local enchantLevel = itemWrapper:getStaticStatus():get()._key:getEnchantLevel()
      local enchantText = ""
      if 16 <= enchantLevel then
        enchantText = HighEnchantLevel_ReplaceString(enchantLevel) .. " "
      end
      PaGlobal_Extraction_System_All._itemInfo.name[PaGlobal_Extraction_System_All._systemCnt] = enchantText .. itemWrapper:getStaticStatus():getName()
      PaGlobal_Extraction_System_All._itemInfo.iconPath[PaGlobal_Extraction_System_All._systemCnt] = itemWrapper:getStaticStatus():getIconPath()
      PaGlobal_Extraction_System_All._itemInfo.slotNo[PaGlobal_Extraction_System_All._systemCnt] = slotNo
      local isEquipAble = itemWrapper:getStaticStatus():isEquipable()
      local isCash = itemWrapper:getStaticStatus():get():isCash()
      local isAccessory = CppEnums.ItemClassifyType.eItemClassify_Accessory == itemWrapper:getStaticStatus():getItemClassify()
      local balksCnt = itemWrapper:getStaticStatus():getExtractionCount_s64()
      local cronsCnt = itemWrapper:getStaticStatus():getCronCount_s64()
      if 0 < ToClient_getSpecialEnchantDisplayLevel(itemWrapper:getStaticStatus():get()._key) then
        enchantLevel = ToClient_getSpecialEnchantDisplayLevel(itemWrapper:getStaticStatus():get()._key)
        isAccessory = false
      end
      PaGlobal_Extraction_System_All._itemInfo.itemEnchantLevle[PaGlobal_Extraction_System_All._systemCnt] = PaGlobal_Extraction_System_All:getEnchantText(isEquipAble, isCash, isAccessory, balksCnt, cronsCnt, enchantLevel)
    end
  end
  for equipNo = EquipNoMin, EquipNoMax do
    local itemWrapper = ToClient_getEquipmentItem(equipNo)
    if false == PaGlobal_Extraction_System_All:fillter_ForSacrificeTarget(equipNo, itemWrapper, whereType, true) then
      PaGlobal_Extraction_System_All._systemCnt = PaGlobal_Extraction_System_All._systemCnt + 1
      PaGlobal_Extraction_System_All._equipCnt = PaGlobal_Extraction_System_All._equipCnt + 1
      PaGlobal_Extraction_System_All._ui.list2_extractableItem:getElementManager():pushKey(toInt64(0, PaGlobal_Extraction_System_All._systemCnt))
      PaGlobal_Extraction_System_All._equipNo[PaGlobal_Extraction_System_All._systemCnt] = equipNo
      local enchantLevel = itemWrapper:getStaticStatus():get()._key:getEnchantLevel()
      local enchantText = ""
      if 16 <= enchantLevel then
        enchantText = HighEnchantLevel_ReplaceString(enchantLevel) .. " "
      end
      PaGlobal_Extraction_System_All._itemInfo.name[PaGlobal_Extraction_System_All._systemCnt] = enchantText .. itemWrapper:getStaticStatus():getName()
      PaGlobal_Extraction_System_All._itemInfo.iconPath[PaGlobal_Extraction_System_All._systemCnt] = itemWrapper:getStaticStatus():getIconPath()
      local isEquipAble = itemWrapper:getStaticStatus():isEquipable()
      local isCash = itemWrapper:getStaticStatus():get():isCash()
      local isAccessory = CppEnums.ItemClassifyType.eItemClassify_Accessory == itemWrapper:getStaticStatus():getItemClassify()
      local balksCnt = itemWrapper:getStaticStatus():getExtractionCount_s64()
      local cronsCnt = itemWrapper:getStaticStatus():getCronCount_s64()
      if 0 < ToClient_getSpecialEnchantDisplayLevel(itemWrapper:getStaticStatus():get()._key) then
        enchantLevel = ToClient_getSpecialEnchantDisplayLevel(itemWrapper:getStaticStatus():get()._key)
        isAccessory = false
      end
      PaGlobal_Extraction_System_All._itemInfo.itemEnchantLevle[PaGlobal_Extraction_System_All._systemCnt] = PaGlobal_Extraction_System_All:getEnchantText(isEquipAble, isCash, isAccessory, balksCnt, cronsCnt, enchantLevel)
    end
  end
  for index = 1, PaGlobal_Extraction_System_All._systemCnt do
    PaGlobal_Extraction_System_All._itemInfo.isExtractionEquip[index] = false
  end
  if 0 == PaGlobal_Extraction_System_All._systemCnt then
    PaGlobal_Extraction_System_All._ui.txt_noItem:SetShow(true)
  else
    PaGlobal_Extraction_System_All._ui.txt_noItem:SetShow(false)
  end
end
function PaGlobal_Extraction_System_All:setExtractionIcon(itemWrapper, slotNo)
  UI.ASSERT_NAME(nil ~= itemWrapper, "PaGlobal_Extraction_System_All:setExtractionIcon\236\157\152 itemWrapper nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= slotNo, "PaGlobal_Extraction_System_All:setExtractionIcon\236\157\152 slotNo nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if nil == Panel_Window_Extraction_System_All then
    return
  end
  local itemKey = itemWrapper:get():getKey()
  local staticStatus = itemWrapper:getStaticStatus()
  local selfPlayerInventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
  if nil == selfPlayerInventory or nil == staticStatus or true == self._isAniStart then
    return
  end
  self._ui._icon_items:setItemByStaticStatus(staticStatus, Defines.s64_const.s64_1)
  self._extractableSlotNo = slotNo
  if false == self._isConsole then
    self._ui._icon_items.icon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_System_All_ShowListToolTip(false," .. self._extractableSlotNo .. ",true)")
    self._ui._icon_items.icon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_System_All_ShowListToolTip(false," .. self._extractableSlotNo .. ",false)")
    self._ui._icon_items.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Extraction_System_All_ClearItemSlot()")
  else
    self._ui._icon_items.icon:addInputEvent("Mouse_On", "PaGlobal_Extraction_System_All_ShowDetailKeyGuide(true)")
    self._ui._icon_items.icon:addInputEvent("Mouse_Out", "PaGlobal_Extraction_System_All_ShowDetailKeyGuide(false)")
    self._ui.stc_extractableItemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Extraction_System_All_ShowListToolTip(false," .. self._extractableSlotNo .. ",nil)")
    self._ui._icon_items.icon:addInputEvent("Mouse_LUp", "HandleEventRUp_Extraction_System_All_ClearItemSlot()")
  end
  local maxInvenSlotNo = 255
  local needItemKey = ToClient_ExtractNeedItemEnchantKey(itemKey)
  local needItemSlotNo = selfPlayerInventory:getSlot(needItemKey)
  local prevStatic = getItemEnchantStaticStatus(needItemKey)
  self._ui._icon_material:clearItem()
  self._ui.txt_noMaterial:SetShow(false)
  if prevStatic ~= nil then
    if maxInvenSlotNo == needItemSlotNo then
      local noticeText = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_EXTRACTIONSYSTEM_NEEDCATALYST", "itemName", prevStatic:getName())
      self._ui.txt_noMaterial:SetText(noticeText)
      self._ui.txt_noMaterial:SetShow(true)
      self._ui._icon_material:setItemByStaticStatus(prevStatic, 0)
      self._ui._icon_material.icon:SetMonoTone(true)
    else
      self._ui._icon_material:setItemByStaticStatus(prevStatic, 1)
      self._ui._icon_material.icon:SetMonoTone(false)
      self._materialSlotNo = needItemSlotNo
    end
    if false == self._isConsole then
      self._ui._icon_material.icon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_System_All_ShowToolTip(" .. needItemKey:getItemKey() .. ",true)")
      self._ui._icon_material.icon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_System_All_ShowToolTip(" .. needItemKey:getItemKey() .. ",false)")
      self._ui._icon_material.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Extraction_System_All_ClearItemSlot()")
    else
      self._ui._icon_material.icon:addInputEvent("Mouse_On", "PaGlobal_Extraction_System_All_ShowDetailKeyGuide(true)")
      self._ui._icon_material.icon:addInputEvent("Mouse_Out", "PaGlobal_Extraction_System_All_ShowDetailKeyGuide(false)")
      self._ui.stc_materialItemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Extraction_System_All_ShowToolTip(" .. needItemKey:getItemKey() .. ",nil)")
      self._ui._icon_material.icon:addInputEvent("Mouse_LUp", "HandleEventRUp_Extraction_System_All_ClearItemSlot()")
    end
  end
  self._resultItemKey = ToClient_ExtractToItemEnchantKey(itemKey, 0)
  self._ui._icon_resultItem:clearItem()
  self._ui._icon_resultItem:setItemByStaticStatus(getItemEnchantStaticStatus(self._resultItemKey))
  if false == self._isConsole then
    self._ui._icon_resultItem.icon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_System_All_ShowResultToolTip(true)")
    self._ui._icon_resultItem.icon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_System_All_ShowResultToolTip(false)")
  else
    self._ui._icon_resultItem.icon:addInputEvent("Mouse_On", "PaGlobal_Extraction_System_All_ShowDetailKeyGuide(true)")
    self._ui._icon_resultItem.icon:addInputEvent("Mouse_Out", "PaGlobal_Extraction_System_All_ShowDetailKeyGuide(false)")
    self._ui.stc_resultItmeSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Extraction_System_All_ShowResultToolTip()")
  end
  self._ui._icon_resultItem.icon:SetMonoTone(true)
  self._ui._icon_resultItem.count:SetShow(false)
  self._resultMaterialKey = ToClient_ExtractToItemEnchantKey(itemKey, 1)
  self._ui._icon_resultMaterial:clearItem()
  self._ui._icon_resultMaterial:setItemByStaticStatus(getItemEnchantStaticStatus(self._resultMaterialKey))
  if false == self._isConsole then
    self._ui._icon_resultMaterial.icon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_System_All_ShowToolTip(" .. self._resultMaterialKey:getItemKey() .. ",true)")
    self._ui._icon_resultMaterial.icon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_System_All_ShowToolTip(" .. self._resultMaterialKey:getItemKey() .. ",false)")
  else
    self._ui._icon_resultMaterial.icon:addInputEvent("Mouse_On", "PaGlobal_Extraction_System_All_ShowDetailKeyGuide(true)")
    self._ui._icon_resultMaterial.icon:addInputEvent("Mouse_Out", "PaGlobal_Extraction_System_All_ShowDetailKeyGuide(false)")
    self._ui.stc_resultMaterialItemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Extraction_System_All_ShowToolTip(" .. self._resultMaterialKey:getItemKey() .. ",nil)")
  end
  self._ui._icon_resultMaterial.icon:SetMonoTone(true)
  self._ui._icon_resultMaterial.count:SetShow(false)
  if -1 ~= self._extractableSlotNo and -1 ~= self._materialSlotNo and maxInvenSlotNo ~= needItemSlotNo then
    if false == self._isConsole then
      self._ui_pc.btn_extraction:SetEnable(true)
      self._ui_pc.btn_extraction:SetMonoTone(false)
    else
      Panel_Window_Extraction_System_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Extraction_System_All_Extraction()")
      self._ui_console.stc_iconY_extraction:SetMonoTone(false)
    end
  elseif false == self._isConsole then
    self._ui_pc.btn_extraction:SetEnable(false)
    self._ui_pc.btn_extraction:SetMonoTone(true)
  else
    Panel_Window_Extraction_System_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    self._ui_console.stc_iconY_extraction:SetMonoTone(true)
  end
  Panel_Tooltip_Item_hideTooltip()
  self._fromSlotOn = true
end
function PaGlobal_Extraction_System_All:fillter_ForSacrificeTarget(slotNo, itemWrapper, whereType, isEquip)
  if nil == itemWrapper then
    return true
  end
  if 0 < itemWrapper:getCronEnchantFailCount() then
    return true
  end
  if true == isEquip and true == ToClient_EquipSlot_CheckItemLock(slotNo, CppEnums.ItemWhereType.eEquip) then
    return true
  end
  if true == ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    return true
  end
  if true == ToClient_isExtractFromItem(itemWrapper:get():getKey()) then
    return false
  end
  return true
end
function PaGlobal_Extraction_System_All:clearAllSlot()
  if nil == Panel_Window_Extraction_System_All then
    return
  end
  self._ui._icon_items:clearItem()
  self._ui._icon_material:clearItem()
  self._ui._icon_resultItem:clearItem()
  self._ui._icon_resultMaterial:clearItem()
  self._ui._icon_items.icon:addInputEvent("Mouse_On", "")
  self._ui._icon_items.icon:addInputEvent("Mouse_Out", "")
  self._ui._icon_items.icon:SetIgnore(false)
  self._ui.stc_extractableItemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  self._ui._icon_material.icon:addInputEvent("Mouse_On", "")
  self._ui._icon_material.icon:addInputEvent("Mouse_Out", "")
  self._ui._icon_material.icon:SetIgnore(false)
  self._ui.stc_materialItemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  self._ui._icon_resultItem.icon:addInputEvent("Mouse_On", "")
  self._ui._icon_resultItem.icon:addInputEvent("Mouse_Out", "")
  self._ui.stc_resultItmeSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  self._ui._icon_resultMaterial.icon:addInputEvent("Mouse_On", "")
  self._ui._icon_resultMaterial.icon:addInputEvent("Mouse_Out", "")
  self._ui.stc_resultMaterialItemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  PaGlobal_Extraction_System_All_ShowDetailKeyGuide(false)
  self._ui.txt_noMaterial:SetShow(false)
  if true == self._isEndExtraction then
    self._resultItemKey = nil
    self._resultMaterialKey = nil
    self._isEndExtraction = false
  end
  self._isAniStart = false
  self._fromSlotOn = false
  self._extractableSlotNo = -1
  self._materialSlotNo = -1
  self._ui.btn_skipAni:SetIgnore(false)
  self._resultShowTime = 0
  self._delta_ani_time = 0
  self._curSelectKey = nil
  self._selectedItemSlotNo = nil
  if false == self._isConsole then
    self._ui_pc.btn_extraction:SetEnable(false)
    self._ui_pc.btn_extraction:SetMonoTone(true)
  else
    Panel_Window_Extraction_System_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    self._ui_console.stc_iconY_extraction:SetMonoTone(true)
  end
  self._ui.list2_extractableItem:SetEnable(true)
  Panel_Window_Extraction_System_All:ClearUpdateLuaFunc()
  Panel_Window_Extraction_Result:ClearUpdateLuaFunc()
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_Extraction_System_All:clearExtractionSlot()
  if nil == Panel_Window_Extraction_System_All then
    return
  end
  self._ui._icon_items:clearItem()
  self._ui._icon_material:clearItem()
  self._ui._icon_items.icon:addInputEvent("Mouse_On", "")
  self._ui._icon_items.icon:addInputEvent("Mouse_Out", "")
  self._ui._icon_items.icon:SetIgnore(false)
  self._ui.stc_extractableItemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  self._ui._icon_material.icon:addInputEvent("Mouse_On", "")
  self._ui._icon_material.icon:addInputEvent("Mouse_Out", "")
  self._ui._icon_material.icon:SetIgnore(false)
  self._ui.stc_materialItemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  self._isAniStart = false
  self._fromSlotOn = false
  if false == self._isConsole then
    self._ui_pc.btn_extraction:SetEnable(false)
    self._ui_pc.btn_extraction:SetMonoTone(true)
  else
    Panel_Window_Extraction_System_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    self._ui_console.stc_iconY_extraction:SetMonoTone(true)
  end
  self._ui.list2_extractableItem:SetEnable(true)
  if false == self._isConsole then
    Panel_Tooltip_Item_hideTooltip()
  else
    PaGlobalFunc_TooltipInfo_Close()
  end
  PaGlobal_Extraction_System_All._ui.stc_extractableItemSlot:EraseAllEffect()
  PaGlobal_Extraction_System_All._ui.stc_materialItemSlot:EraseAllEffect()
  PaGlobal_Extraction_System_All._ui.stc_resultItmeSlot:EraseAllEffect()
  PaGlobal_Extraction_System_All._ui.stc_resultMaterialItemSlot:EraseAllEffect()
end
function PaGlobal_Extraction_System_All:updateToolTip()
  if nil == Panel_Window_Extraction_System_All or nil == self._resultItemKey then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local slotNo = selfPlayer:get():getInventory():getSlot(PaGlobal_Extraction_System_All._resultItemKey)
  if 255 == slotNo then
    return
  end
  PaGlobal_Extraction_System_All._ui._icon_resultItem.icon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_System_All_ShowResultToolTip(true)")
  PaGlobal_Extraction_System_All._ui._icon_resultItem.icon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_System_All_ShowResultToolTip(false)")
end
function PaGlobal_Extraction_System_All:setNotice()
  if nil == Panel_Window_Extraction_System_All then
    return
  end
  local titleBarSizeY = UI.getChildControl(Panel_Window_Extraction_System_All, "Static_TitlebarArea"):GetSizeY()
  local imageAreaSizeY = UI.getChildControl(Panel_Window_Extraction_System_All, "Static_LeftMainImageArea"):GetSizeY()
  local btnAreaSizeY = UI.getChildControl(Panel_Window_Extraction_System_All, "Static_LeftBottomButtonArea"):GetSizeY()
  local sizeY = 0
  local padding = 20
  local rightArea = UI.getChildControl(Panel_Window_Extraction_System_All, "Static_RightArea")
  local leftBottomDescArea = UI.getChildControl(Panel_Window_Extraction_System_All, "Static_LeftBottomDescArea")
  if self._ui.txt_leftBottomDesc:GetTextSizeY() == self._ui.txt_leftBottomDesc:GetSizeY() then
    return
  elseif self._ui.txt_leftBottomDesc:GetTextSizeY() > self._ui.txt_leftBottomDesc:GetSizeY() then
    sizeY = self._ui.txt_leftBottomDesc:GetTextSizeY() - self._originDescSizeY
    self._ui.txt_leftBottomDesc:SetSize(self._ui.txt_leftBottomDesc:GetSizeX(), self._ui.txt_leftBottomDesc:GetTextSizeY())
    leftBottomDescArea:SetSize(leftBottomDescArea:GetSizeX(), self._ui.txt_leftBottomDesc:GetTextSizeY() + padding)
    local panelSizeY = titleBarSizeY + imageAreaSizeY + btnAreaSizeY + leftBottomDescArea:GetSizeY() + padding * 2
    Panel_Window_Extraction_System_All:SetSize(Panel_Window_Extraction_System_All:GetSizeX(), panelSizeY)
    self._ui_console.stc_bottomGuideBg:ComputePos()
    rightArea:SetSize(rightArea:GetSizeX(), rightArea:GetSizeY() + sizeY)
    self._ui.list2_extractableItem:SetSize(self._ui.list2_extractableItem:GetSizeX(), self._originListSizeY + sizeY)
  else
    sizeY = self._originDescSizeY - self._ui.txt_leftBottomDesc:GetTextSizeY()
    self._ui.txt_leftBottomDesc:SetSize(self._ui.txt_leftBottomDesc:GetSizeX(), self._ui.txt_leftBottomDesc:GetTextSizeY())
    leftBottomDescArea:SetSize(leftBottomDescArea:GetSizeX(), self._ui.txt_leftBottomDesc:GetTextSizeY() + padding)
    local panelSizeY = titleBarSizeY + imageAreaSizeY + btnAreaSizeY + leftBottomDescArea:GetSizeY() + padding * 2
    Panel_Window_Extraction_System_All:SetSize(Panel_Window_Extraction_System_All:GetSizeX(), panelSizeY)
    self._ui_console.stc_bottomGuideBg:ComputePos()
    rightArea:SetSize(rightArea:GetSizeX(), rightArea:GetSizeY() - sizeY)
    self._ui.list2_extractableItem:SetSize(self._ui.list2_extractableItem:GetSizeX(), self._originListSizeY - sizeY)
  end
  FromClient_Extraction_System_All_ReSizePanel()
  UI.getChildControl(Panel_Window_Extraction_System_All, "Static_LeftBottomButtonArea"):ComputePos()
end
function PaGlobal_Extraction_System_All:getEnchantText(isEquipable, isCash, isAccessory, balksCnt, cronsCnt, enchantLev)
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
