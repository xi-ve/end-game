function PaGlobal_Extraction_Costume_All:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:setNotice()
  self:SetUiSetting()
  self._ui.list2_extractableItem:SetSize(self._ui.list2_extractableItem:GetSizeX(), self._ui.list2_extractableItem:GetSizeY())
  self._ui._icon_items = {}
  SlotItem.new(self._ui._icon_items, "feeItem", nil, self._ui.stc_extractableItemSlot, self._slotConfig)
  self._ui._icon_items:createChild()
  self._ui._icon_items:clearItem()
  self._ui._icon_result = {}
  SlotItem.new(self._ui._icon_result, "resultItem", nil, self._ui.stc_resultItmeSlot, self._slotConfig)
  self._ui._icon_result:createChild()
  self._ui._icon_result:clearItem()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Extraction_Costume_All:controlAll_Init()
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
  local leftMainArea = UI.getChildControl(Panel_Window_Extraction_Costume_All, "Static_LeftMainArea")
  self._ui.stc_leftTopDesc = UI.getChildControl(leftMainArea, "StaticText_LeftTopDesc")
  self._ui.stc_leftTopDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_leftTopDesc:SetText(self._ui.stc_leftTopDesc:GetText())
  local imageArea = UI.getChildControl(leftMainArea, "Static_ImageArea")
  self._ui.stc_extractableItemSlot = UI.getChildControl(imageArea, "Static_ExtractionItemSlot")
  self._ui.stc_resultItmeSlot = UI.getChildControl(imageArea, "Static_ExtractionResultSlot")
  local leftBottomArea = UI.getChildControl(Panel_Window_Extraction_Costume_All, "Static_LeftBottomDescArea")
  self._ui.stc_leftBottomDesc = UI.getChildControl(leftBottomArea, "StaticText_LeftBottomDesc")
  self._ui.stc_leftBottomDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_leftBottomDesc:SetText(self._ui.stc_leftBottomDesc:GetText())
  local rightArea = UI.getChildControl(Panel_Window_Extraction_Costume_All, "Static_RightArea")
  self._ui.list2_extractableItem = UI.getChildControl(rightArea, "List2_ExtractableItemList")
  local leftBtnArea = UI.getChildControl(Panel_Window_Extraction_Costume_All, "Static_LeftBottomButtonArea")
  self._ui.btn_skipAni = UI.getChildControl(leftBtnArea, "CheckButton_SkipAni")
  self._ui.btn_valks = UI.getChildControl(leftBtnArea, "RadioButton_Valks")
  self._ui.btn_cron = UI.getChildControl(leftBtnArea, "RadioButton_Cron")
  self._ui.stc_extractionImg = UI.getChildControl(imageArea, "Static_ExtractionImage")
  self._ui.txt_extractionCnt = UI.getChildControl(self._ui.stc_extractionImg, "StaticText_Count")
  self._ui.txt_noItem = UI.getChildControl(self._ui.list2_extractableItem, "StaticText_Desc")
end
function PaGlobal_Extraction_Costume_All:controlPc_Init()
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
  local titlebarArea = UI.getChildControl(Panel_Window_Extraction_Costume_All, "Static_TitlebarArea")
  self._ui_pc.btn_question = UI.getChildControl(titlebarArea, "Button_Question")
  self._ui_pc.btn_close = UI.getChildControl(titlebarArea, "Button_Close")
  self._ui_pc.btn_extraction = UI.getChildControl(Panel_Window_Extraction_Costume_All, "Button_Extraction")
end
function PaGlobal_Extraction_Costume_All:controlConsole_Init()
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
  local leftBtnArea = UI.getChildControl(Panel_Window_Extraction_Costume_All, "Static_LeftBottomButtonArea")
  self._ui_console.stc_bottomGuideBg = UI.getChildControl(Panel_Window_Extraction_Costume_All, "Static_BottomConsoleButtons")
  self._ui_console.stc_iconX = UI.getChildControl(self._ui_console.stc_bottomGuideBg, "Button_Detail")
  self._ui_console.stc_iconA = UI.getChildControl(self._ui_console.stc_bottomGuideBg, "Button_Select")
  self._ui_console.stc_iconB = UI.getChildControl(self._ui_console.stc_bottomGuideBg, "Button_Cancel")
  self._ui_console.btn_extraction = UI.getChildControl(Panel_Window_Extraction_Costume_All, "Button_ConsoleButtonY")
end
function PaGlobal_Extraction_Costume_All:SetUiSetting()
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
  if false == self._isConsole then
    self._ui_pc.btn_question:SetShow(true)
    self._ui_pc.btn_close:SetShow(true)
    self._ui_pc.btn_extraction:SetShow(true)
    self._ui_console.btn_extraction:SetShow(false)
    self._ui_console.stc_bottomGuideBg:SetShow(false)
  else
    self._ui_pc.btn_question:SetShow(false)
    self._ui_pc.btn_close:SetShow(false)
    self._ui_pc.btn_extraction:SetShow(false)
    self._ui_console.btn_extraction:SetShow(true)
    self._ui_console.stc_bottomGuideBg:SetShow(true)
    self._ui_console.btn_extraction:SetPosX((self._ui_pc.btn_extraction:GetSizeX() - self._ui_console.btn_extraction:GetSizeX() - self._ui_console.btn_extraction:GetTextSizeX()) * 0.5)
    self._ui_console.stc_bottomGuideBg:SetPosY(Panel_Window_Extraction_Costume_All:GetSizeY())
    local keyGuides = {
      self._ui_console.stc_iconX,
      self._ui_console.stc_iconA,
      self._ui_console.stc_iconB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.stc_bottomGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    self._ui_console.stc_iconX:SetShow(false)
    Panel_Window_Extraction_Costume_All:ignorePadSnapMoveToOtherPanel()
  end
  FromClient_Extraction_Costume_All_ReSizePanel()
end
function PaGlobal_Extraction_Costume_All:registEventHandler()
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Extraction_Costume_All_ReSizePanel()")
  self._ui.list2_extractableItem:registEvent(__ePAUIList2EventType_LuaChangeContent, "HandleEventLUp_Extraction_Costume_All_ListControlCreate")
  self._ui.list2_extractableItem:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_InventoryUpdate", "PaGlobal_Extraction_Costume_All_UpdateList")
  registerEvent("EventEquipmentUpdate", "PaGlobal_Extraction_Costume_All_UpdateList")
  registerEvent("FromClient_ExtractItemFromExtractionCount", "FromClient_Extraction_Costume_All_Extraction_SuccessMessage")
  if false == self._isConsole then
    self._ui_pc.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowExtractionEnchantStone\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui_pc.btn_question, "\"PanelWindowExtractionEnchantStone\"")
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Extraction_Costume_All_Close()")
    self._ui_pc.btn_extraction:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Costume_All_Extraction()")
  else
    Panel_Window_Extraction_Costume_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Extraction_Costume_All_Extraction()")
  end
  self._ui.btn_skipAni:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Costume_All_SkipAniButton()")
  self._ui.btn_valks:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Costume_All_ExtractionTypeValk()")
  self._ui.btn_cron:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Costume_All_ExtractionTypeCron()")
end
function PaGlobal_Extraction_Costume_All:prepareOpen()
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
  self._itemInfo.isExtractionEquip = {false}
  self._extractionItem = {
    slotNo = {},
    whereType = {}
  }
  self._extractionCnt = 0
  self._lastIndex = 0
  self._ui.txt_extractionCnt:SetText(self._extractionCnt)
  self.updateExtractionList()
  self._ui_pc.btn_extraction:SetEnable(false)
  self._ui_pc.btn_extraction:SetMonoTone(true)
  self._ui_console.btn_extraction:SetEnable(false)
  self._ui_console.btn_extraction:SetMonoTone(true)
  Panel_Window_Extraction_Costume_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  self._ui.btn_valks:SetCheck(false)
  self._ui.btn_cron:SetCheck(false)
  self._isValks = nil
  self._isClose = false
  self._ui.btn_skipAni:SetCheck(false)
  self._isSkipAni = false
  self._isExtraction = false
  local posY = (getScreenSizeY() - Panel_Window_Extraction_Costume_All:GetSizeY() - Panel_Window_Extraction_All:GetSizeY()) * 0.5
  Panel_Window_Extraction_Costume_All:SetPosY(posY)
  PaGlobal_Extraction_Costume_All:open()
end
function PaGlobal_Extraction_Costume_All:open()
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
  Panel_Window_Extraction_Costume_All:SetShow(true)
end
function PaGlobal_Extraction_Costume_All:prepareClose()
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
  audioPostEvent_SystemUi(5, 99)
  _AudioPostEvent_SystemUiForXBOX(5, 99)
  PaGlobal_Extraction_Costume_All:close()
end
function PaGlobal_Extraction_Costume_All:close()
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
  Panel_Window_Extraction_Costume_All:SetShow(false)
end
function PaGlobal_Extraction_Costume_All:validate()
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
  self:allValidate()
  self:pcValidate()
  self:consoleValidate()
end
function PaGlobal_Extraction_Costume_All:allValidate()
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
  self._ui.stc_leftTopDesc:isValidate()
  self._ui.stc_extractableItemSlot:isValidate()
  self._ui.stc_resultItmeSlot:isValidate()
  self._ui.stc_leftBottomDesc:isValidate()
  self._ui.btn_skipAni:isValidate()
  self._ui.btn_valks:isValidate()
  self._ui.btn_cron:isValidate()
  self._ui.txt_extractionCnt:isValidate()
  self._ui.stc_extractionImg:isValidate()
end
function PaGlobal_Extraction_Costume_All:pcValidate()
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
  self._ui_pc.btn_question:isValidate()
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.btn_extraction:isValidate()
end
function PaGlobal_Extraction_Costume_All:consoleValidate()
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
end
function PaGlobal_Extraction_Costume_All:updateExtractionList()
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
  PaGlobal_Extraction_Costume_All._ui.list2_extractableItem:getElementManager():clearKey()
  local whereType = CppEnums.ItemWhereType.eCashInventory
  local inventory = getSelfPlayer():get():getInventory(whereType)
  if nil == inventory then
    return
  end
  PaGlobal_Extraction_Costume_All._equipCnt = 0
  PaGlobal_Extraction_Costume_All._costumeCnt = 0
  local EquipNoMin = CppEnums.EquipSlotNo.rightHand
  local EquipNoMax = CppEnums.EquipSlotNo.equipSlotNoCount
  local invenMaxSize = inventory:sizeXXX()
  for slotNo = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(whereType, slotNo)
    if false == PaGlobal_Extraction_Costume_All:filerCostumeItem(itemWrapper) then
      PaGlobal_Extraction_Costume_All._costumeCnt = PaGlobal_Extraction_Costume_All._costumeCnt + 1
      PaGlobal_Extraction_Costume_All._equipNo[PaGlobal_Extraction_Costume_All._costumeCnt] = nil
      PaGlobal_Extraction_Costume_All._ui.list2_extractableItem:getElementManager():pushKey(toInt64(0, PaGlobal_Extraction_Costume_All._costumeCnt))
      PaGlobal_Extraction_Costume_All._itemInfo.name[PaGlobal_Extraction_Costume_All._costumeCnt] = itemWrapper:getStaticStatus():getName()
      PaGlobal_Extraction_Costume_All._itemInfo.iconPath[PaGlobal_Extraction_Costume_All._costumeCnt] = itemWrapper:getStaticStatus():getIconPath()
      PaGlobal_Extraction_Costume_All._itemInfo.slotNo[PaGlobal_Extraction_Costume_All._costumeCnt] = slotNo
      PaGlobal_Extraction_Costume_All._itemInfo.whereType[PaGlobal_Extraction_Costume_All._costumeCnt] = whereType
    end
  end
  whereType = CppEnums.ItemWhereType.eInventory
  inventory = getSelfPlayer():get():getInventory(whereType)
  if nil == inventory then
    return
  end
  invenMaxSize = inventory:sizeXXX()
  for slotNo = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(whereType, slotNo)
    if false == PaGlobal_Extraction_Costume_All:filerCostumeItem(itemWrapper) then
      PaGlobal_Extraction_Costume_All._costumeCnt = PaGlobal_Extraction_Costume_All._costumeCnt + 1
      PaGlobal_Extraction_Costume_All._equipNo[PaGlobal_Extraction_Costume_All._costumeCnt] = nil
      PaGlobal_Extraction_Costume_All._ui.list2_extractableItem:getElementManager():pushKey(toInt64(0, PaGlobal_Extraction_Costume_All._costumeCnt))
      PaGlobal_Extraction_Costume_All._itemInfo.name[PaGlobal_Extraction_Costume_All._costumeCnt] = itemWrapper:getStaticStatus():getName()
      PaGlobal_Extraction_Costume_All._itemInfo.iconPath[PaGlobal_Extraction_Costume_All._costumeCnt] = itemWrapper:getStaticStatus():getIconPath()
      PaGlobal_Extraction_Costume_All._itemInfo.slotNo[PaGlobal_Extraction_Costume_All._costumeCnt] = slotNo
      PaGlobal_Extraction_Costume_All._itemInfo.whereType[PaGlobal_Extraction_Costume_All._costumeCnt] = whereType
    end
  end
  whereType = CppEnums.ItemWhereType.eEquip
  for equipNo = EquipNoMin, EquipNoMax do
    local itemWrapper = ToClient_getEquipmentItem(equipNo)
    if false == PaGlobal_Extraction_Costume_All:filerCostumeItem(itemWrapper) then
      PaGlobal_Extraction_Costume_All._costumeCnt = PaGlobal_Extraction_Costume_All._costumeCnt + 1
      PaGlobal_Extraction_Costume_All._equipCnt = PaGlobal_Extraction_Costume_All._equipCnt + 1
      PaGlobal_Extraction_Costume_All._ui.list2_extractableItem:getElementManager():pushKey(toInt64(0, PaGlobal_Extraction_Costume_All._costumeCnt))
      PaGlobal_Extraction_Costume_All._equipNo[PaGlobal_Extraction_Costume_All._costumeCnt] = equipNo
      PaGlobal_Extraction_Costume_All._itemInfo.name[PaGlobal_Extraction_Costume_All._costumeCnt] = itemWrapper:getStaticStatus():getName()
      PaGlobal_Extraction_Costume_All._itemInfo.iconPath[PaGlobal_Extraction_Costume_All._costumeCnt] = itemWrapper:getStaticStatus():getIconPath()
      PaGlobal_Extraction_Costume_All._itemInfo.whereType[PaGlobal_Extraction_Costume_All._costumeCnt] = whereType
    end
  end
  if 0 == PaGlobal_Extraction_Costume_All._costumeCnt then
    PaGlobal_Extraction_Costume_All._ui.txt_noItem:SetShow(true)
  else
    PaGlobal_Extraction_Costume_All._ui.txt_noItem:SetShow(false)
  end
end
function PaGlobal_Extraction_Costume_All:filerCostumeItem(itemWrapper)
  if nil == itemWrapper then
    return true
  end
  local itemCount = itemWrapper:getStaticStatus():getExtractionCount_s64()
  if nil == itemCount then
    return true
  elseif Int64toInt32(itemCount) <= 0 then
    return true
  else
    return false
  end
end
function PaGlobal_Extraction_Costume_All:setExtractionIcon()
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
  if 0 == self._extractionCnt then
    self:clearAllSlot()
    return
  end
  local itemWrapper = getInventoryItemByType(self._extractionItem.whereType[1], self._extractionItem.slotNo[1])
  if nil == itemWrapper then
    self._ui._icon_items:clearItem()
    return
  end
  local itemKey = itemWrapper:get():getKey()
  local staticStatus = itemWrapper:getStaticStatus()
  self._ui._icon_items:setItemByStaticStatus(staticStatus, Defines.s64_const.s64_1)
  if false == self._isConsole then
    self._ui._icon_items.icon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_Costume_All_ShowToolTip(" .. itemKey:getItemKey() .. ",true)")
    self._ui._icon_items.icon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_Costume_All_ShowToolTip(" .. itemKey:getItemKey() .. ",false)")
    self._ui._icon_items.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Extraction_Costume_All_ClearItemSlot()")
  else
    self._ui._icon_items.icon:addInputEvent("Mouse_On", "PaGlobal_Extraction_Costume_All_ShowDetailKeyGuide(true)")
    self._ui._icon_items.icon:addInputEvent("Mouse_Out", "PaGlobal_Extraction_Costume_All_ShowDetailKeyGuide(false)")
    self._ui._icon_items.icon:addInputEvent("Mouse_LUp", "HandleEventRUp_Extraction_Costume_All_ClearItemSlot()")
    self._ui.stc_extractableItemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Extraction_Costume_All_ShowToolTip(nil,nil,nil,nil," .. itemKey:getItemKey() .. ")")
  end
  self._fromSlotOn = true
  self:setExtractionResultIcon()
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_Extraction_Costume_All:setExtractionResultIcon()
  if false == self._fromSlotOn then
    return
  end
  if nil == self._isValks then
    self:clearResultItemSlot()
    return
  end
  local resultItemStaticStatus, itemKey
  local count = 0
  if true == self._isValks then
    itemKey = ItemEnchantKey(17643)
  else
    itemKey = ItemEnchantKey(16080)
  end
  resultItemStaticStatus = getItemEnchantStaticStatus(itemKey)
  if nil == resultItemStaticStatus then
    return
  end
  if true == self._isValks then
    for index = 1, self._extractionCnt do
      local itemWrapper = getInventoryItemByType(self._extractionItem.whereType[index], self._extractionItem.slotNo[index])
      count = count + Int64toInt32(itemWrapper:getStaticStatus():getExtractionCount_s64())
    end
  else
    for index = 1, self._extractionCnt do
      local itemWrapper = getInventoryItemByType(self._extractionItem.whereType[index], self._extractionItem.slotNo[index])
      count = count + Int64toInt32(itemWrapper:getStaticStatus():getCronCount_s64())
    end
  end
  if false == self._isConsole then
    self._ui_pc.btn_extraction:SetEnable(true)
    self._ui_pc.btn_extraction:SetMonoTone(false)
  else
    self._ui_console.btn_extraction:SetEnable(true)
    self._ui_console.btn_extraction:SetMonoTone(false)
    Panel_Window_Extraction_Costume_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Extraction_Costume_All_Extraction()")
  end
  self._ui._icon_result:clearItem()
  self._ui._icon_result:setItemByStaticStatus(resultItemStaticStatus, count)
  if false == self._isConsole then
    self._ui._icon_result.icon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_Costume_All_ShowToolTip(" .. itemKey:getItemKey() .. ",true)")
    self._ui._icon_result.icon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_Costume_All_ShowToolTip(" .. itemKey:getItemKey() .. ",false)")
  else
    self._ui._icon_result.icon:addInputEvent("Mouse_On", "PaGlobal_Extraction_Costume_All_ShowDetailKeyGuide(true)")
    self._ui._icon_result.icon:addInputEvent("Mouse_Out", "PaGlobal_Extraction_Costume_All_ShowDetailKeyGuide(false)")
    self._ui.stc_resultItmeSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Extraction_Costume_All_ShowToolTip(nil,nil,nil,nil," .. itemKey:getItemKey() .. ")")
  end
end
function PaGlobal_Extraction_Costume_All:clearAllSlot()
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
  PaGlobal_Extraction_Costume_All:extractionButtonIgnore(false)
  self._ui._icon_items:clearItem()
  self._ui._icon_result:clearItem()
  self._ui._icon_items.icon:addInputEvent("Mouse_On", "")
  self._ui._icon_items.icon:addInputEvent("Mouse_Out", "")
  self._ui.stc_extractableItemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  self._ui._icon_result.icon:addInputEvent("Mouse_On", "")
  self._ui._icon_result.icon:addInputEvent("Mouse_Out", "")
  self._ui.stc_resultItmeSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  self._fromSlotOn = false
  self._isAniStart = false
  for index = 1, self._costumeCnt do
    if true == self._itemInfo.isExtractionEquip[index] then
      self._itemInfo.isExtractionEquip[index] = false
      self._ui.list2_extractableItem:requestUpdateByKey(toInt64(0, index))
    end
  end
  self._extractionItem = {
    slotNo = {},
    whereType = {}
  }
  self._extractionCnt = 0
  self._ui.txt_extractionCnt:SetText(self._extractionCnt)
  self._ui.btn_valks:SetIgnore(false)
  self._ui.btn_cron:SetIgnore(false)
  self._ui.stc_extractionImg:EraseAllEffect()
  if false == self._isConsole then
    self._ui_pc.btn_extraction:SetEnable(false)
    self._ui_pc.btn_extraction:SetMonoTone(true)
  else
    self._ui_console.btn_extraction:SetEnable(false)
    self._ui_console.btn_extraction:SetMonoTone(true)
    Panel_Window_Extraction_Costume_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  end
  if true == self._isExtraction then
    self:updateExtractionList()
    self._isExtraction = false
  end
  if false == self._isConsole then
    Panel_Tooltip_Item_hideTooltip()
  else
    PaGlobalFunc_TooltipInfo_Close()
  end
end
function PaGlobal_Extraction_Costume_All:clearResultItemSlot()
  self._ui._icon_result:clearItem()
  self._ui._icon_result.icon:addInputEvent("Mouse_On", "")
  self._ui._icon_result.icon:addInputEvent("Mouse_Out", "")
  self._fromSlotOn = false
  self._isAniStart = false
  if false == self._isConsole then
    self._ui_pc.btn_extraction:SetEnable(false)
    self._ui_pc.btn_extraction:SetMonoTone(true)
  else
    self._ui_console.btn_extraction:SetEnable(false)
    self._ui_console.btn_extraction:SetMonoTone(true)
    Panel_Window_Extraction_Costume_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  end
end
function PaGlobal_Extraction_Costume_All:extractionButtonIgnore(isIgnore)
  UI.ASSERT_NAME(nil ~= isIgnore, "PaGlobal_Extraction_Costume_All:extractionButtonIgnore\236\157\152 isIgnore nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  self._ui.btn_skipAni:SetIgnore(isIgnore)
  self._ui.list2_extractableItem:SetEnable(false == isIgnore)
end
function PaGlobal_Extraction_Costume_All:setNotice()
  if nil == Panel_Window_Extraction_Costume_All then
    return
  end
  if self._ui.stc_leftBottomDesc:GetTextSizeY() > self._ui.stc_leftBottomDesc:GetSizeY() then
    local sizeY = self._ui.stc_leftBottomDesc:GetTextSizeY() - self._ui.stc_leftBottomDesc:GetSizeY()
    self._ui.stc_leftBottomDesc:SetSize(self._ui.stc_leftBottomDesc:GetSizeX(), self._ui.stc_leftBottomDesc:GetTextSizeY())
    self._ui.stc_leftBottomDesc:SetSize(self._ui.stc_leftBottomDesc:GetSizeX(), self._ui.stc_leftBottomDesc:GetSizeY() + sizeY)
    Panel_Window_Extraction_Costume_All:SetSize(Panel_Window_Extraction_Costume_All:GetSizeX(), Panel_Window_Extraction_Costume_All:GetSizeY() + sizeY)
    local leftBottomArea = UI.getChildControl(Panel_Window_Extraction_Costume_All, "Static_LeftBottomDescArea")
    leftBottomArea:SetSize(leftBottomArea:GetSizeX(), leftBottomArea:GetSizeY() + sizeY)
    leftBottomArea:ComputePos()
    local leftBtnArea = UI.getChildControl(Panel_Window_Extraction_Costume_All, "Static_LeftBottomButtonArea")
    leftBtnArea:ComputePos()
    local rightArea = UI.getChildControl(Panel_Window_Extraction_Costume_All, "Static_RightArea")
    rightArea:SetSize(rightArea:GetSizeX(), rightArea:GetSizeY() + sizeY)
    rightArea:ComputePos()
    self._ui.list2_extractableItem:SetSize(self._ui.list2_extractableItem:GetSizeX(), self._ui.list2_extractableItem:GetSizeY() + sizeY)
  end
  FromClient_Extraction_Costume_All_ReSizePanel()
end
