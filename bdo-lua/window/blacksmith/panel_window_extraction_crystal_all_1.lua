function PaGlobal_Extraction_Crystal_All:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:setUiSetting()
  self:setNotice()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Extraction_Crystal_All:controlAll_Init()
  if nil == Panel_Window_Extraction_Crystal_All then
    return
  end
  local leftMainArea = UI.getChildControl(Panel_Window_Extraction_Crystal_All, "Static_LeftMainArea")
  local topDescArea = UI.getChildControl(leftMainArea, "Static_TopDescArea")
  self._ui.txt_leftTopDesc = UI.getChildControl(topDescArea, "StaticText_LeftTopDesc")
  self._ui.txt_leftTopDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_leftTopDesc:SetText(self._ui.txt_leftTopDesc:GetText())
  local leftMainArea = UI.getChildControl(Panel_Window_Extraction_Crystal_All, "Static_LeftMainArea")
  local bottomImageArea = UI.getChildControl(leftMainArea, "Static_BottomImageArea")
  local imagePartArea = UI.getChildControl(bottomImageArea, "Static_ImagePartArea")
  local crystalExtracimage = UI.getChildControl(imagePartArea, "Static_CrystalExtractImage")
  for idx = 1, 3 do
    self._ui.stc_crystalInfo[idx].stc_crystal = UI.getChildControl(crystalExtracimage, "Static_CrystalInfo" .. idx)
    self._ui.stc_crystalInfo[idx].txt_itemName = UI.getChildControl(self._ui.stc_crystalInfo[idx].stc_crystal, "StaticText_CrystalName")
    self._ui.stc_crystalInfo[idx].txt_crystalDesc = UI.getChildControl(self._ui.stc_crystalInfo[idx].stc_crystal, "StaticText_CrystalDesc")
    self._ui.stc_crystalInfo[idx].btn_extraction = UI.getChildControl(self._ui.stc_crystalInfo[idx].stc_crystal, "Button_Extraction")
    self._ui.stc_crystalInfo[idx].btn_delete_console = UI.getChildControl(self._ui.stc_crystalInfo[idx].stc_crystal, "Button_ConsoleButtonA")
    self._ui.stc_crystalInfo[idx].btn_extraction_console = UI.getChildControl(self._ui.stc_crystalInfo[idx].stc_crystal, "Button_ConsoleButtonY")
    local crystalSlotBg = UI.getChildControl(crystalExtracimage, "Static_CrystalItemSlotBG" .. idx)
    self._ui.stc_crystalInfo[idx].stc_itemSlot = UI.getChildControl(crystalSlotBg, "Static_" .. idx)
  end
  local rightTopArea = UI.getChildControl(Panel_Window_Extraction_Crystal_All, "Static_RightTopArea")
  self._ui.list2_extractableItem = UI.getChildControl(rightTopArea, "List2_ExtractableItemList")
  local rightBottomArea = UI.getChildControl(Panel_Window_Extraction_Crystal_All, "Static_RightBottomArea")
  self._ui.list2_materialItem = UI.getChildControl(rightBottomArea, "List2_ExtractionMaterialItemList")
  self._ui.stc_materialItemSlot = UI.getChildControl(crystalExtracimage, "Static_ExtractionHammerItemSlot")
  self._ui.stc_extractionItemSlot = UI.getChildControl(crystalExtracimage, "Static_MainEquipSlot")
  self._ui.stc_crystalExtractImage = UI.getChildControl(imagePartArea, "Static_CrystalExtractImage")
  self._ui.txt_noItem = UI.getChildControl(self._ui.list2_extractableItem, "StaticText_Desc")
end
function PaGlobal_Extraction_Crystal_All:controlPc_Init()
  if nil == Panel_Window_Extraction_Crystal_All then
    return
  end
  local titlebarArea = UI.getChildControl(Panel_Window_Extraction_Crystal_All, "Static_TitlebarArea")
  self._ui_pc.btn_question = UI.getChildControl(titlebarArea, "Button_Question")
  self._ui_pc.btn_close = UI.getChildControl(titlebarArea, "Button_Close")
end
function PaGlobal_Extraction_Crystal_All:controlConsole_Init()
  if nil == Panel_Window_Extraction_Crystal_All then
    return
  end
  self._ui_console.stc_guideBg = UI.getChildControl(Panel_Window_Extraction_Crystal_All, "Static_BottomConsoleButtons")
  self._ui_console.stc_iconX = UI.getChildControl(self._ui_console.stc_guideBg, "Button_Detail")
  self._ui_console.stc_iconA = UI.getChildControl(self._ui_console.stc_guideBg, "Button_Select")
  self._ui_console.stc_iconB = UI.getChildControl(self._ui_console.stc_guideBg, "Button_Cancel")
end
function PaGlobal_Extraction_Crystal_All:setUiSetting()
  if nil == Panel_Window_Extraction_Crystal_All then
    return
  end
  if false == PaGlobal_Extraction_Crystal_All._isConsole then
    self._ui_pc.btn_question:SetShow(true)
    self._ui_pc.btn_close:SetShow(true)
    self._ui_console.stc_guideBg:SetShow(false)
    for idx = 1, 3 do
      self._ui.stc_crystalInfo[idx].btn_extraction:SetShow(true)
      self._ui.stc_crystalInfo[idx].btn_delete_console:SetShow(false)
      self._ui.stc_crystalInfo[idx].btn_extraction_console:SetShow(false)
    end
  else
    self._ui_pc.btn_question:SetShow(false)
    self._ui_pc.btn_close:SetShow(false)
    self._ui_console.stc_guideBg:SetShow(true)
    for idx = 1, 3 do
      self._ui.stc_crystalInfo[idx].btn_extraction:SetShow(false)
      self._ui.stc_crystalInfo[idx].btn_delete_console:SetShow(true)
      self._ui.stc_crystalInfo[idx].btn_extraction_console:SetShow(true)
    end
    local keyGuides = {
      self._ui_console.stc_iconX,
      self._ui_console.stc_iconA,
      self._ui_console.stc_iconB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.stc_guideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    self._ui_console.stc_iconX:SetShow(false)
    Panel_Window_Extraction_Crystal_All:ignorePadSnapMoveToOtherPanel()
  end
  self._ui._icon_items = {}
  SlotItem.new(self._ui._icon_items, "feeItem", nil, self._ui.stc_extractionItemSlot, self._slotConfig)
  self._ui._icon_items:createChild()
  self._ui._icon_items:clearItem()
  self._ui._icon_materialItems = {}
  SlotItem.new(self._ui._icon_materialItems, "resultItem", nil, self._ui.stc_materialItemSlot, self._slotConfig)
  self._ui._icon_materialItems:createChild()
  self._ui._icon_materialItems:clearItem()
  self._ui._icon_crystalItems = {
    [1] = {},
    [2] = {},
    [3] = {}
  }
  for idx = 1, 3 do
    SlotItem.new(self._ui._icon_crystalItems[idx], "Socket_" .. idx, idx, self._ui.stc_crystalInfo[idx].stc_itemSlot, self._slotConfig)
    self._ui._icon_crystalItems[idx]:createChild()
    self._ui._icon_crystalItems[idx]:clearItem()
  end
  FromClient_Extraction_Crystal_All_ReSizePanel()
end
function PaGlobal_Extraction_Crystal_All:registEventHandler()
  if nil == Panel_Window_Extraction_Crystal_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Extraction_Crystal_All_ReSizePanel()")
  self._ui.list2_extractableItem:registEvent(__ePAUIList2EventType_LuaChangeContent, "HandleEventLUp_Extraction_Crystal_All_ExtractionListControlCreate")
  self._ui.list2_extractableItem:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list2_materialItem:registEvent(__ePAUIList2EventType_LuaChangeContent, "HandleEventLUp_Extraction_Crystal_All_MaterialListControlCreate")
  self._ui.list2_materialItem:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("EventEquipmentUpdate", "FromClient_Extraction_Crystal_All_UpdateList")
  if false == self._isConsole then
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Extraction_Crystal_All_Close()")
    self._ui_pc.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowExtractionCrystal\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui_pc.btn_question, "\"PanelWindowExtractionCrystal\"")
  else
  end
end
function PaGlobal_Extraction_Crystal_All:prepareOpen()
  if nil == Panel_Window_Extraction_Crystal_All then
    return
  end
  self:setOpenUisetting()
  PaGlobal_Extraction_Crystal_All_UpdateList()
  local posY = (getScreenSizeY() - Panel_Window_Extraction_Crystal_All:GetSizeY() - Panel_Window_Extraction_All:GetSizeY()) * 0.5
  Panel_Window_Extraction_Crystal_All:SetPosY(posY)
  PaGlobal_Extraction_Crystal_All:open()
end
function PaGlobal_Extraction_Crystal_All:open()
  if nil == Panel_Window_Extraction_Crystal_All then
    return
  end
  Panel_Window_Extraction_Crystal_All:SetShow(true)
end
function PaGlobal_Extraction_Crystal_All:prepareClose()
  if nil == Panel_Window_Extraction_Crystal_All then
    return
  end
  self:clearAllSlot()
  PaGlobal_Extraction_Crystal_All:close()
end
function PaGlobal_Extraction_Crystal_All:close()
  if nil == Panel_Window_Extraction_Crystal_All then
    return
  end
  Panel_Window_Extraction_Crystal_All:SetShow(false)
end
function PaGlobal_Extraction_Crystal_All:updateExtractionList()
  if nil == Panel_Window_Extraction_Crystal_All then
    return
  end
  self._ui.list2_extractableItem:getElementManager():clearKey()
  self._equipCnt = 0
  self._crystalCnt = 0
  local EquipNoMin = CppEnums.EquipSlotNo.rightHand
  local EquipNoMax = CppEnums.EquipSlotNo.equipSlotNoCount
  self._indexInvenEnd = -1
  self._indexCashInvenEnd = -1
  local listCount = 0
  local whereType = CppEnums.ItemWhereType.eInventory
  local inventory = getSelfPlayer():get():getInventory(whereType)
  if nil == inventory then
    return
  end
  local invenMaxSize = inventory:sizeXXX()
  for slotNo = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(whereType, slotNo)
    if false == self:filterInvenCrystalItem(slotNo, itemWrapper, CppEnums.ItemWhereType.eInventory) then
      self:setExtractionListInfo(false, slotNo, itemWrapper:getStaticStatus())
      listCount = listCount + 1
    end
  end
  self._indexInvenEnd = listCount
  local cashInven = getSelfPlayer():get():getCashInventory()
  if nil == cashInven then
    return
  end
  local cashInvenMaxSize = cashInven:sizeXXX()
  for slotNo = 0, cashInvenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, slotNo)
    if false == self:filterInvenCrystalItem(slotNo, itemWrapper, CppEnums.ItemWhereType.eCashInventory) then
      self:setExtractionListInfo(false, slotNo, itemWrapper:getStaticStatus())
      listCount = listCount + 1
    end
  end
  self._indexCashInvenEnd = listCount
  for equipNo = EquipNoMin, EquipNoMax do
    local itemWrapper = ToClient_getEquipmentItem(equipNo)
    if false == self:filterEquipCrystalItem(equipNo, itemWrapper) then
      self:setExtractionListInfo(true, equipNo, itemWrapper:getStaticStatus())
      listCount = listCount + 1
    end
  end
  if 0 == self._crystalCnt then
    self:clearAllSlot()
  end
  if 0 == listCount then
    self._ui.txt_noItem:SetShow(true)
  else
    self._ui.txt_noItem:SetShow(false)
  end
end
function PaGlobal_Extraction_Crystal_All:setExtractionListInfo(isEquip, num, itemSSW)
  UI.ASSERT_NAME(nil ~= isEquip, "PaGlobal_Extraction_Crystal_All:setExtractionListInfo\236\157\152 isEquip nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= num, "PaGlobal_Extraction_Crystal_All:setExtractionListInfo\236\157\152 num nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if nil == itemSSW then
    return
  end
  self._crystalCnt = self._crystalCnt + 1
  self._equipNo[self._crystalCnt] = nil
  if true == isEquip then
    self._equipCnt = self._equipCnt + 1
    self._equipNo[self._crystalCnt] = num
  end
  self._ui.list2_extractableItem:getElementManager():pushKey(toInt64(0, self._crystalCnt))
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  local enchantText = ""
  if 16 <= enchantLevel then
    enchantText = HighEnchantLevel_ReplaceString(enchantLevel) .. " "
  end
  self._extractionItemInfo.name[self._crystalCnt] = enchantText .. itemSSW:getName()
  self._extractionItemInfo.iconPath[self._crystalCnt] = itemSSW:getIconPath()
  self._extractionItemInfo.slotNo[self._crystalCnt] = num
  local isEquipAble = itemSSW:isEquipable()
  local isCash = itemSSW:get():isCash()
  local isAccessory = CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify()
  local balksCnt = itemSSW:getExtractionCount_s64()
  local cronsCnt = itemSSW:getCronCount_s64()
  if 0 < ToClient_getSpecialEnchantDisplayLevel(itemSSW:get()._key) then
    enchantLevel = ToClient_getSpecialEnchantDisplayLevel(itemSSW:get()._key)
    isAccessory = false
  end
  self._extractionItemInfo.itemEnchantLevle[self._crystalCnt] = self:getEnchantText(isEquipAble, isCash, isAccessory, balksCnt, cronsCnt, enchantLevel)
end
function PaGlobal_Extraction_Crystal_All:filterInvenCrystalItem(slotNo, itemWrapper, whereType)
  UI.ASSERT_NAME(nil ~= slotNo, "PaGlobal_Extraction_Crystal_All:filterInvenCrystalItem\236\157\152 slotNo nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if nil == itemWrapper then
    return true
  end
  local maxCount = itemWrapper:get():getUsableItemSocketCount()
  local blankSlot_Count = maxCount
  for sock_idx = 1, maxCount do
    local itemStaticWrapper = itemWrapper:getPushedItem(sock_idx - 1)
    if nil == itemStaticWrapper then
      blankSlot_Count = blankSlot_Count - 1
    end
  end
  if true == ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    return true
  end
  if true == itemWrapper:getStaticStatus():get():doHaveSocket() and 0 ~= blankSlot_Count then
    return false
  end
end
function PaGlobal_Extraction_Crystal_All:filterEquipCrystalItem(slotNo, itemWrapper)
  if nil == itemWrapper then
    return true
  end
  local maxCount = itemWrapper:get():getUsableItemSocketCount()
  local blankSlot_Count = maxCount
  for sock_idx = 1, maxCount do
    local itemStaticWrapper = itemWrapper:getPushedItem(sock_idx - 1)
    if nil == itemStaticWrapper then
      blankSlot_Count = blankSlot_Count - 1
    end
  end
  if true == ToClient_EquipSlot_CheckItemLock(slotNo, CppEnums.ItemWhereType.eEquip) then
    return true
  end
  if true == itemWrapper:getStaticStatus():get():doHaveSocket() and 0 ~= blankSlot_Count then
    return false
  end
end
function PaGlobal_Extraction_Crystal_All:updateMaterialList()
  if nil == Panel_Window_Extraction_Crystal_All then
    return
  end
  self._ui.list2_materialItem:getElementManager():clearKey()
  self._materialCnt = 0
  self:setMaterialListInfo(getSelfPlayer():get():getInventory():getSlot(self._materialEnchantKey.stuffCrystalExtraction), CppEnums.ItemWhereType.eInventory, getItemEnchantStaticStatus(self._materialEnchantKey.stuffCrystalExtraction))
  self:setMaterialListInfo(getSelfPlayer():get():getCashInventory():getSlot(self._materialEnchantKey.stuffBlackspirit), CppEnums.ItemWhereType.eCashInventory, getItemEnchantStaticStatus(self._materialEnchantKey.stuffBlackspirit))
  local whereType = CppEnums.ItemWhereType.eInventory
  local inventory = getSelfPlayer():get():getInventory(whereType)
  if nil == inventory then
    return
  end
  local invenMaxSize = inventory:sizeXXX()
  for slotNo = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(whereType, slotNo)
    if false == self:filterMaterialItem(slotNo, whereType, itemWrapper) then
      self:setMaterialListInfo(slotNo, whereType, itemWrapper:getStaticStatus())
    end
  end
  whereType = CppEnums.ItemWhereType.eCashInventory
  local cashInven = getSelfPlayer():get():getCashInventory()
  if nil == cashInven then
    return
  end
  local invenMaxSize = cashInven:sizeXXX()
  for slotNo = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(whereType, slotNo)
    if false == self:filterMaterialItem(slotNo, whereType, itemWrapper) then
      self:setMaterialListInfo(slotNo, whereType, itemWrapper:getStaticStatus())
    end
  end
end
function PaGlobal_Extraction_Crystal_All:setMaterialListInfo(slotNo, whereType, itemSSW)
  UI.ASSERT_NAME(nil ~= slotNo, "PaGlobal_Extraction_Crystal_All:setMaterialListInfo\236\157\152 slotNo nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= whereType, "PaGlobal_Extraction_Crystal_All:setMaterialListInfo\236\157\152 whereType nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if nil == itemSSW then
    return
  end
  self._materialCnt = self._materialCnt + 1
  self._ui.list2_materialItem:getElementManager():pushKey(toInt64(0, self._materialCnt))
  self._materialItemInfo.name[self._materialCnt] = itemSSW:getName()
  self._materialItemInfo.iconPath[self._materialCnt] = itemSSW:getIconPath()
  self._materialItemInfo.slotNo[self._materialCnt] = slotNo
  self._materialItemInfo.whereType[self._materialCnt] = whereType
  local itemCnt = 0
  if 255 ~= slotNo then
    itemCnt = Int64toInt32(getInventoryItemByType(whereType, slotNo):get():getCount_s64())
  end
  self._materialItemInfo.itemCnt[self._materialCnt] = itemCnt
  if true == self._materialItemInfo.isExtractionEquip[self._materialCnt] and 0 == self._materialItemInfo.itemCnt[self._materialCnt] then
    self:clearMaterialSlot()
  end
end
function PaGlobal_Extraction_Crystal_All:filterMaterialItem(slotNo, whereType, itemWrapper)
  if nil == itemWrapper then
    return
  end
  UI.ASSERT_NAME(nil ~= slotNo, "PaGlobal_Extraction_Crystal_All:filterMaterialItem\236\157\152 slotNo nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= whereType, "PaGlobal_Extraction_Crystal_All:filterMaterialItem\236\157\152 whereType nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if true == getSocketInformation():isExtractionSource(whereType, slotNo) then
    return
  end
end
function PaGlobal_Extraction_Crystal_All:setExtractionIcon(itemWrapper, slotNo)
  UI.ASSERT_NAME(nil ~= slotNo, "PaGlobal_Extraction_Crystal_All:setExtractionIcon\236\157\152 slotNo nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if nil == itemWrapper then
    self:clearAllSlot()
    return
  end
  local staticStatus = itemWrapper:getStaticStatus()
  if nil == staticStatus or true == self._isAniStart then
    return
  end
  local itemKey = itemWrapper:get():getKey()
  self._extractionKey = itemKey
  self._extractionSlotNo = slotNo
  local success = 0 == Socket_SetItemHaveSocket(PaGlobal_Extraction_Crystal_All._selectedWhereType, self._extractionSlotNo)
  if false == success then
    self:clearAllSlot()
    self._extractionKey = nil
    self._extractionSlotNo = 255
    return
  end
  self._ui._icon_items:clearItem()
  self._ui._icon_items:setItemByStaticStatus(staticStatus, Defines.s64_const.s64_1)
  self._ui._icon_items.icon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_Crystal_All_ShowListToolTip(false," .. self._extractionSlotNo .. "," .. PaGlobal_Extraction_Crystal_All._selectedWhereType .. ",true)")
  self._ui._icon_items.icon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_Crystal_All_ShowListToolTip(false," .. self._extractionSlotNo .. "," .. PaGlobal_Extraction_Crystal_All._selectedWhereType .. ",false)")
  self._ui._icon_items.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Extraction_Crystal_All_ClearAllSlot()")
  self:setCrystalSlotIcon(itemWrapper)
end
function PaGlobal_Extraction_Crystal_All:setCrystalSlotIcon(itemWrapper)
  if nil == itemWrapper then
    self:clearAllSlot()
    return
  end
  local maxCount = itemWrapper:get():getUsableItemSocketCount()
  local classType = getSelfPlayer():getClassType()
  local haveCrystal = false
  for ii = 1, maxCount do
    self._ui._icon_crystalItems[ii]:clearItem()
    self._ui.stc_crystalInfo[ii].isEmpty = true
    local itemStaticWrapper = itemWrapper:getPushedItem(ii - 1)
    if nil ~= itemStaticWrapper then
      self._ui.stc_crystalInfo[ii].txt_itemName:SetMonoTone(false)
      self._ui.stc_crystalInfo[ii].txt_crystalDesc:SetMonoTone(false)
      self._ui._icon_crystalItems[ii].icon:EraseAllEffect()
      local effectName = ""
      if 1 == ii then
        effectName = "fUI_BlackExtractCrystal_01A"
      elseif 2 == ii then
        effectName = "fUI_BlackExtractCrystal_01B"
      elseif 3 == ii then
        effectName = "fUI_BlackExtractCrystal_01C"
      end
      self._ui._icon_crystalItems[ii].icon:AddEffect(effectName, true, 0, 0)
      self._ui._icon_crystalItems[ii]:setItemByStaticStatus(itemStaticWrapper, 0)
      self._ui._icon_crystalItems[ii].icon:ComputePos()
      local text = itemStaticWrapper:getName()
      local desc = ""
      self._ui.stc_crystalInfo[ii].txt_itemName:SetText(text)
      self._ui.stc_crystalInfo[ii].txt_crystalDesc:SetTextMode(__eTextMode_Limit_AutoWrap)
      self._ui.stc_crystalInfo[ii].txt_crystalDesc:setLineCountByLimitAutoWrap(3)
      PAGlobalFunc_SetItemTextColorForNewUI(self._ui.stc_crystalInfo[ii].txt_itemName, itemStaticWrapper)
      local jewelSkillStaticWrapper = itemStaticWrapper:getSkillByIdx(classType)
      if nil ~= jewelSkillStaticWrapper then
        local descTable = ""
        for buffIdx = 0, jewelSkillStaticWrapper:getBuffCount() - 1 do
          local descCurrent = jewelSkillStaticWrapper:getBuffDescription(buffIdx)
          if nil == descCurrent or "" == descCurrent then
            break
          end
          descTable = descTable .. descCurrent .. "\n"
        end
        self._ui.stc_crystalInfo[ii].txt_crystalDesc:SetText(descTable)
        local itemKey = itemStaticWrapper:get()._key
        if false == self._isConsole then
          self._ui._icon_crystalItems[ii].icon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_Crystal_All_ShowToolTip(" .. itemKey:getItemKey() .. ",true)")
          self._ui._icon_crystalItems[ii].icon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_Crystal_All_ShowToolTip(" .. itemKey:getItemKey() .. ",false)")
          self._ui._icon_crystalItems[ii].icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Extraction_Crystal_All_RemoveCrystal(" .. ii .. ")")
        else
          self._ui._icon_crystalItems[ii].icon:addInputEvent("Mouse_On", "PaGlobal_Extraction_Crystal_All_ShowDetailKeyGuide(true, nil, " .. ii .. ")")
          self._ui._icon_crystalItems[ii].icon:addInputEvent("Mouse_Out", "PaGlobal_Extraction_Crystal_All_ShowDetailKeyGuide(false, nil, " .. ii .. ")")
          self._ui.stc_crystalInfo[ii].stc_itemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Extraction_Crystal_All_ShowToolTip(" .. itemKey:getItemKey() .. ",nil)")
          self._ui.stc_crystalInfo[ii].btn_delete_console:SetShow(true)
          self._ui.stc_crystalInfo[ii].stc_itemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_Extraction_Crystal_All_RemoveCrystal(" .. ii .. ")")
          self._ui.stc_crystalInfo[ii].btn_extraction_console:SetShow(true)
          self._ui.stc_crystalInfo[ii].btn_extraction_console:SetMonoTone(true)
          self._ui.stc_crystalInfo[ii].btn_extraction_console:SetEnable(false)
        end
        self._ui.stc_crystalInfo[ii].isEmpty = false
      end
      haveCrystal = true
    else
      self._ui.stc_crystalInfo[ii].txt_itemName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SOCKET_EMPTYSLOT"))
      self._ui.stc_crystalInfo[ii].txt_crystalDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_CRYSTAL_SLOT_EMPTY"))
      self._ui.stc_crystalInfo[ii].isEmpty = true
      self._ui._icon_crystalItems[ii].icon:EraseAllEffect()
      self._ui._icon_crystalItems[ii].icon:addInputEvent("Mouse_On", "PaGlobal_Extraction_Crystal_All_ShowDetailKeyGuide(false, nil, " .. ii .. ")")
      self._ui._icon_crystalItems[ii].icon:addInputEvent("Mouse_Out", "")
      if false == self._isConsole then
        self._ui._icon_crystalItems[ii].icon:addInputEvent("Mouse_RUp", "")
      else
        PaGlobal_Extraction_Crystal_All_ShowDetailKeyGuide(false, nil, ii)
        self._ui.stc_crystalInfo[ii].stc_itemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
      end
      self._ui.stc_crystalInfo[ii].btn_extraction_console:SetMonoTone(true)
      self._ui.stc_crystalInfo[ii].btn_extraction_console:SetEnable(false)
      self._ui.stc_crystalInfo[ii].stc_itemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      self._ui.stc_crystalInfo[ii].stc_itemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
    end
  end
  if false == haveCrystal then
    self:clearAllSlot()
  end
end
function PaGlobal_Extraction_Crystal_All:setMaterialSlotIcon(itemWrapper, whereType, slotNo)
  UI.ASSERT_NAME(nil ~= whereType, "PaGlobal_Extraction_Crystal_All:setMaterialSlotIcon\236\157\152 whereType nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= slotNo, "PaGlobal_Extraction_Crystal_All:setMaterialSlotIcon\236\157\152 slotNo nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if nil == itemWrapper or 255 == slotNo then
    self:clearMaterialSlot()
    return
  end
  local staticStatus = itemWrapper:getStaticStatus()
  if nil == staticStatus or true == self._isAniStart then
    return
  end
  local invenItem = getInventoryItemByType(whereType, slotNo)
  local itemCnt = 0
  if nil ~= invenItem then
    itemCnt = Int64toInt32(invenItem:get():getCount_s64())
  end
  self._ui._icon_materialItems:clearItem()
  self._ui._icon_materialItems:setItemByStaticStatus(staticStatus, itemCnt)
  local itemKey = itemWrapper:get():getKey()
  self._ui._icon_materialItems.icon:addInputEvent("Mouse_On", "HandleEventOn_Extraction_Crystal_All_ShowToolTip(" .. itemKey:getItemKey() .. ",true)")
  self._ui._icon_materialItems.icon:addInputEvent("Mouse_Out", "HandleEventOn_Extraction_Crystal_All_ShowToolTip(" .. itemKey:getItemKey() .. ",false)")
  self._ui._icon_materialItems.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Extraction_Crystal_All_MaterialItem()")
  self._stuffWhereType = whereType
  self._stuffSlotNo = slotNo
  getSocketInformation():isExtractionSource(self._stuffWhereType, self._stuffSlotNo)
  for idx = 1, 3 do
    if false == self._ui.stc_crystalInfo[idx].isEmpty then
      if false == self._isConsole then
        self._ui.stc_crystalInfo[idx].btn_extraction:SetMonoTone(false)
        self._ui.stc_crystalInfo[idx].btn_extraction:SetEnable(true)
        self._ui.stc_crystalInfo[idx].btn_extraction:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Crystal_All_ExtractionCrystal(" .. idx .. ")")
      else
        self._ui.stc_crystalInfo[idx].btn_extraction_console:SetShow(true)
        self._ui.stc_crystalInfo[idx].btn_extraction_console:SetMonoTone(false)
        self._ui.stc_crystalInfo[idx].btn_extraction_console:SetEnable(true)
        self._ui.stc_crystalInfo[idx].stc_itemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Extraction_Crystal_All_ExtractionCrystal(" .. idx .. ")")
      end
    elseif false == self._isConsole then
      self._ui.stc_crystalInfo[idx].btn_extraction:SetMonoTone(true)
      self._ui.stc_crystalInfo[idx].btn_extraction:SetEnable(false)
      self._ui.stc_crystalInfo[idx].btn_extraction:addInputEvent("Mouse_LUp", "")
    else
      self._ui.stc_crystalInfo[idx].btn_extraction_console:SetShow(false)
      self._ui.stc_crystalInfo[idx].btn_delete_console:SetShow(false)
    end
  end
end
function PaGlobal_Extraction_Crystal_All:clearExtractionSlot()
  self._ui._icon_items:clearItem()
  self._ui._icon_items.icon:addInputEvent("Mouse_On", "")
  self._ui._icon_items.icon:addInputEvent("Mouse_Out", "")
  for index = 1, self._crystalCnt do
    self._extractionItemInfo.isExtractionEquip[index] = false
  end
  self._selectedItemSlotNo = nil
  self._extractionKey = nil
  self._extractionSlotNo = 255
  getSocketInformation():clearData()
end
function PaGlobal_Extraction_Crystal_All:clearCrystalSlot()
  for idx = 1, 3 do
    self._ui._icon_crystalItems[idx]:clearItem()
    self._ui._icon_crystalItems[idx].icon:EraseAllEffect()
    self._ui._icon_crystalItems[idx].icon:addInputEvent("Mouse_On", "")
    self._ui._icon_crystalItems[idx].icon:addInputEvent("Mouse_Out", "")
    self._ui.stc_crystalInfo[idx].txt_itemName:SetText("")
    self._ui.stc_crystalInfo[idx].txt_crystalDesc:SetText("")
    self._ui.stc_crystalInfo[index].isEmpty = true
    if false == self._isConsole then
      self._ui.stc_crystalInfo[idx].btn_extraction:SetEnable(false)
      self._ui.stc_crystalInfo[idx].btn_extraction:SetMonoTone(true)
    else
    end
  end
end
function PaGlobal_Extraction_Crystal_All:clearMaterialSlot()
  self._ui._icon_materialItems:clearItem()
  self._ui._icon_materialItems.icon:addInputEvent("Mouse_On", "")
  self._ui._icon_materialItems.icon:addInputEvent("Mouse_Out", "")
  for index = 1, 3 do
    self._materialItemInfo.isExtractionEquip[index] = false
    if false == self._isConsole then
      self._ui.stc_crystalInfo[index].btn_extraction:SetEnable(false)
      self._ui.stc_crystalInfo[index].btn_extraction:SetMonoTone(true)
    elseif false == self._ui.stc_crystalInfo[index].isEmpty then
      self._ui.stc_crystalInfo[index].btn_extraction_console:SetMonoTone(true)
      self._ui.stc_crystalInfo[index].btn_extraction_console:SetEnable(false)
      self._ui.stc_crystalInfo[index].stc_itemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    else
      HandlePadEventOn_Extraction_Crystal_All_SocketOnTextureChange(index, false)
      self._ui.stc_crystalInfo[index].btn_extraction_console:SetShow(false)
      self._ui.stc_crystalInfo[index].btn_delete_console:SetShow(false)
    end
  end
  self._stuffWhereType = CppEnums.ItemWhereType.eInventory
  self._stuffSlotNo = 255
  self._selectedMaterialSlotNo = nil
  if false == self._isConsole then
    Panel_Tooltip_Item_hideTooltip()
  else
    PaGlobalFunc_TooltipInfo_Close()
  end
end
function PaGlobal_Extraction_Crystal_All:clearAllSlot()
  self:clearExtractionSlot()
  self:clearCrystalSlot()
  self:clearMaterialSlot()
  for index = 1, 3 do
    self._ui.stc_crystalInfo[index].btn_extraction_console:SetMonoTone(true)
    self._ui.stc_crystalInfo[index].btn_extraction_console:SetEnable(false)
    self._ui.stc_crystalInfo[index].stc_itemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    self._ui.stc_crystalInfo[index].btn_extraction_console:SetShow(false)
    self._ui.stc_crystalInfo[index].btn_delete_console:SetShow(false)
    self._ui.stc_crystalInfo[index].stc_itemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
    HandlePadEventOn_Extraction_Crystal_All_SocketOnTextureChange(index, false)
  end
end
function PaGlobal_Extraction_Crystal_All:validate()
  if nil == Panel_Window_Extraction_Crystal_All then
    return
  end
  self:allValidate()
  self:pcValidate()
  self:consoleValidate()
end
function PaGlobal_Extraction_Crystal_All:allValidate()
  if nil == Panel_Window_Extraction_Crystal_All then
    return
  end
  self._ui.txt_leftTopDesc:isValidate()
  self._ui.stc_materialItemSlot:isValidate()
  self._ui.stc_extractionItemSlot:isValidate()
  self._ui.list2_extractableItem:isValidate()
  self._ui.list2_materialItem:isValidate()
  self._ui.stc_crystalExtractImage:isValidate()
  for idx = 1, 3 do
    self._ui.stc_crystalInfo[idx].txt_itemName:isValidate()
    self._ui.stc_crystalInfo[idx].txt_crystalDesc:isValidate()
    self._ui.stc_crystalInfo[idx].btn_extraction:isValidate()
    self._ui.stc_crystalInfo[idx].stc_itemSlot:isValidate()
  end
end
function PaGlobal_Extraction_Crystal_All:pcValidate()
  if nil == Panel_Window_Extraction_Crystal_All then
    return
  end
  self._ui_pc.btn_question:isValidate()
  self._ui_pc.btn_close:isValidate()
end
function PaGlobal_Extraction_Crystal_All:consoleValidate()
  if nil == Panel_Window_Extraction_Crystal_All then
    return
  end
end
function PaGlobal_Extraction_Crystal_All:setOpenUisetting()
  for idx = 1, 3 do
    if false == self._isConsole then
      self._ui.stc_crystalInfo[idx].btn_extraction:SetEnable(false)
      self._ui.stc_crystalInfo[idx].btn_extraction:SetMonoTone(true)
    else
      self._ui.stc_crystalInfo[idx].btn_extraction_console:SetEnable(false)
      self._ui.stc_crystalInfo[idx].btn_extraction_console:SetMonoTone(true)
    end
    self._ui.stc_crystalInfo[idx].txt_itemName:SetText("")
    self._ui.stc_crystalInfo[idx].txt_crystalDesc:SetText("")
  end
  PaGlobal_Extraction_Crystal_All._lastIndex = 0
  getSocketInformation():clearData()
end
function PaGlobal_Extraction_Crystal_All:setNotice()
  if self._ui.txt_leftTopDesc:GetTextSizeY() > self._ui.txt_leftTopDesc:GetSizeY() then
    local sizeY = self._ui.txt_leftTopDesc:GetTextSizeY() - self._ui.txt_leftTopDesc:GetSizeY()
    self._ui.txt_leftTopDesc:SetSize(self._ui.txt_leftTopDesc:GetSizeX(), self._ui.txt_leftTopDesc:GetTextSizeY())
    Panel_Window_Extraction_Crystal_All:SetSize(Panel_Window_Extraction_Crystal_All:GetSizeX(), Panel_Window_Extraction_Crystal_All:GetSizeY() + sizeY)
    local rightBottomArea = UI.getChildControl(Panel_Window_Extraction_Crystal_All, "Static_RightBottomArea")
    rightBottomArea:SetSize(rightBottomArea:GetSizeX(), rightBottomArea:GetSizeY() + sizeY)
    self._ui.list2_materialItem:SetSize(self._ui.list2_materialItem:GetSizeX(), self._ui.list2_materialItem:GetSizeY() + sizeY)
    local leftMainArea = UI.getChildControl(Panel_Window_Extraction_Crystal_All, "Static_LeftMainArea")
    leftMainArea:SetSize(leftMainArea:GetSizeX(), leftMainArea:GetSizeY() + sizeY)
    local topDescArea = UI.getChildControl(leftMainArea, "Static_TopDescArea")
    topDescArea:SetSize(topDescArea:GetSizeX(), topDescArea:GetSizeY() + sizeY)
    rightBottomArea:ComputePos()
    leftMainArea:ComputePos()
    topDescArea:ComputePos()
    FromClient_Extraction_Crystal_All_ReSizePanel()
  end
end
function PaGlobal_Extraction_Crystal_All:getEnchantText(isEquipable, isCash, isAccessory, balksCnt, cronsCnt, enchantLev)
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
