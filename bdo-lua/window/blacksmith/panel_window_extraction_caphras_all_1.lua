function PaGlobal_Extraction_Caphras_All:initialize()
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
  self._ui.list2_extractableItem:setNotImpactScrollEvent(true)
  self._ui._icon_items = {}
  SlotItem.new(self._ui._icon_items, "feeItem", nil, self._ui.stc_extractableItemSlot, self._slotConfig)
  self._ui._icon_items:createChild()
  self._ui._icon_items.icon:addInputEvent("Mouse_On", "PaGlobal_Extraction_Caphras_All_ShowToolTip(true)")
  self._ui._icon_items.icon:addInputEvent("Mouse_Out", "PaGlobal_Extraction_Caphras_All_ShowToolTip(false)")
  self._ui._icon_items.icon:addInputEvent("Mouse_RUp", "PaGlobal_Extraction_Caphras_All:ClearItemSlot()")
  self._ui._icon_items:clearItem()
  self._ui._icon_result = {}
  SlotItem.new(self._ui._icon_result, "resultItem", nil, self._ui.stc_resultItmeSlot, self._slotConfig)
  self._ui._icon_result:createChild()
  self._ui._icon_result.icon:addInputEvent("Mouse_On", "PaGlobal_Extraction_Caphras_All_ResultShowToolTip(true)")
  self._ui._icon_result.icon:addInputEvent("Mouse_Out", "PaGlobal_Extraction_Caphras_All_ResultShowToolTip(false)")
  self._ui._icon_result:clearItem()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Extraction_Caphras_All:controlAll_Init()
  if nil == Panel_Window_Extraction_Caphras_All then
    return
  end
  local leftTopArea = UI.getChildControl(Panel_Window_Extraction_Caphras_All, "Static_LeftTopImageArea")
  local extractionImage = UI.getChildControl(leftTopArea, "Static_ExtractionImage")
  self._ui.stc_extractableItemSlot = UI.getChildControl(extractionImage, "Static_ExtractableItemSlot")
  self._ui.stc_resultItmeSlot = UI.getChildControl(extractionImage, "Static_ResultItemSlot")
  self._ui.stc_moneyArea = UI.getChildControl(leftTopArea, "Static_MoneyArea")
  self._ui.stc_money = UI.getChildControl(self._ui.stc_moneyArea, "StaticText_Money")
  self._ui.stc_moneyIcon = UI.getChildControl(self._ui.stc_money, "StaticIcon_Money")
  local leftMiddleArea = UI.getChildControl(Panel_Window_Extraction_Caphras_All, "Static_LeftMiddleArea")
  self._ui.btn_inven = UI.getChildControl(leftMiddleArea, "RadioButton_Inven")
  self._ui.stc_invenMoney = UI.getChildControl(self._ui.btn_inven, "StaticText_MoneyValue")
  self._ui.btn_warehouse = UI.getChildControl(leftMiddleArea, "RadioButton_Warehouse")
  self._ui.stc_warehouseMoney = UI.getChildControl(self._ui.btn_warehouse, "StaticText_MoneyValue")
  local leftBottomArea = UI.getChildControl(Panel_Window_Extraction_Caphras_All, "Static_LeftBottomDescArea")
  self._ui.stc_noticeDesc = UI.getChildControl(leftBottomArea, "StaticText_Desc")
  local leftBottomButtonArea = UI.getChildControl(Panel_Window_Extraction_Caphras_All, "Static_LeftBottomButtonArea")
  self._ui.btn_aniSkip = UI.getChildControl(leftBottomButtonArea, "RadioButton_SkipAni")
  local rightArea = UI.getChildControl(Panel_Window_Extraction_Caphras_All, "Static_RightArea")
  self._ui.list2_extractableItem = UI.getChildControl(rightArea, "List2_ExtractableItemList")
  self._ui.txt_noItem = UI.getChildControl(self._ui.list2_extractableItem, "StaticText_Desc")
end
function PaGlobal_Extraction_Caphras_All:controlPc_Init()
  if nil == Panel_Window_Extraction_Caphras_All then
    return
  end
  local titleArea = UI.getChildControl(Panel_Window_Extraction_Caphras_All, "Static_TItlebarArea")
  self._ui_pc.btn_close = UI.getChildControl(titleArea, "Button_Close")
  local leftBottomArea = UI.getChildControl(Panel_Window_Extraction_Caphras_All, "Static_LeftBottomButtonArea")
  self._ui_pc.btn_extraction = UI.getChildControl(leftBottomArea, "Button_Extraction")
end
function PaGlobal_Extraction_Caphras_All:controlConsole_Init()
  if nil == Panel_Window_Extraction_Caphras_All then
    return
  end
  self._ui_console.stc_bottom = UI.getChildControl(Panel_Window_Extraction_Caphras_All, "Static_BottomConsoleButtons")
  local leftBottomArea = UI.getChildControl(Panel_Window_Extraction_Caphras_All, "Static_LeftBottomButtonArea")
  self._ui_console.btn_extraction = UI.getChildControl(leftBottomArea, "Button_ConsoleY")
  self._ui_console.btn_detail = UI.getChildControl(self._ui_console.stc_bottom, "Button_Detail")
  self._ui_console.btn_select = UI.getChildControl(self._ui_console.stc_bottom, "Button_Select")
  self._ui_console.btn_close = UI.getChildControl(self._ui_console.stc_bottom, "Button_Cancel")
end
function PaGlobal_Extraction_Caphras_All:SetUiSetting()
  if nil == Panel_Window_Extraction_Caphras_All then
    return
  end
  if false == self._isConsole then
    self._ui_console.stc_bottom:SetShow(false)
    self._ui_console.btn_extraction:SetShow(false)
    self._ui_pc.btn_close:SetShow(true)
    self._ui_pc.btn_extraction:SetShow(true)
  else
    self._ui_pc.btn_close:SetShow(false)
    self._ui_pc.btn_extraction:SetShow(false)
    self._ui_console.stc_bottom:SetShow(true)
    self._ui_console.btn_extraction:SetShow(true)
    self._ui_console.stc_bottom:SetPosY(Panel_Window_Extraction_Caphras_All:GetSizeY())
    local keyGuides = {
      self._ui_console.btn_detail,
      self._ui_console.btn_select,
      self._ui_console.btn_close
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.stc_bottom, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    self._ui_console.btn_detail:SetShow(false)
    Panel_Window_Extraction_Caphras_All:ignorePadSnapMoveToOtherPanel()
  end
end
function PaGlobal_Extraction_Caphras_All:registEventHandler()
  if nil == Panel_Window_Extraction_Caphras_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Extraction_Caphras_All_ReSizePanel()")
  self._ui.list2_extractableItem:registEvent(__ePAUIList2EventType_LuaChangeContent, "HandleEventLUp_Extraction_Caphras_All_ListControlCreate")
  self._ui.list2_extractableItem:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_InventoryUpdate", "PaGlobal_Extraction_Caphras_All_UpdateList")
  registerEvent("EventEquipmentUpdate", "PaGlobal_Extraction_Caphras_All_UpdateList")
  registerEvent("EventWarehouseUpdate", "FromClient_Extraction_Caphras_All_EventWarehouseUpdate")
  registerEvent("FromClient_ExtracCaphrasItem", "FromClient_Extraction_Caphras_All_ExtracCaphrasItem")
  if false == self._isConsole then
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Extraction_Caphras_All_Close()")
    self._ui_pc.btn_extraction:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Caphras_All_ExtractionButton()")
  else
    Panel_Window_Extraction_Caphras_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Extraction_Caphras_All_ExtractionButton()")
  end
  self._ui.btn_inven:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Caphras_All_ClickMoneyWhereType(true)")
  self._ui.btn_warehouse:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Caphras_All_ClickMoneyWhereType(false)")
  self._ui.btn_aniSkip:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_Caphras_All_SkipAniButton()")
end
function PaGlobal_Extraction_Caphras_All:openUiSetting()
  if nil == Panel_Window_Extraction_Caphras_All then
    return
  end
  if false == PaGlobal_Extraction_Caphras_All._isConsole then
    PaGlobal_Extraction_Caphras_All._ui_pc.btn_extraction:SetEnable(false)
    PaGlobal_Extraction_Caphras_All._ui_pc.btn_extraction:SetMonoTone(true)
  else
    PaGlobal_Extraction_Caphras_All._ui_console.btn_extraction:SetEnable(false)
    PaGlobal_Extraction_Caphras_All._ui_console.btn_extraction:SetMonoTone(true)
    Panel_Window_Extraction_Caphras_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  end
  PaGlobal_Extraction_Caphras_All:setMyMoney()
  PaGlobal_Extraction_Caphras_All:setExtractionPrice(0, 0)
  if nil ~= PaGlobal_Extraction_Caphras_All._caphrasCnt then
    for index = 1, PaGlobal_Extraction_Caphras_All._caphrasCnt do
      PaGlobal_Extraction_Caphras_All._itemInfo.isExtractionEquip[index] = false
    end
  end
  PaGlobal_Extraction_Caphras_All._lastIndex = 0
  PaGlobal_Extraction_Caphras_All._scrollIdx = 0
  PaGlobal_Extraction_Caphras_All:updateExtractionList()
  PaGlobal_Extraction_Caphras_All._ui._icon_result:clearItem()
  PaGlobal_Extraction_Caphras_All._ui._icon_items:clearItem()
  PaGlobal_Extraction_Caphras_All._isSkipAni = false
  PaGlobal_Extraction_Caphras_All._ui.btn_aniSkip:SetCheck(false)
  PaGlobal_Extraction_Caphras_All:Clear()
  PaGlobal_Extraction_Caphras_All._preSelectKey = nil
  PaGlobal_Extraction_Caphras_All._curSelectKey = nil
  PaGlobal_Extraction_Caphras_All._listControl = {}
  PaGlobal_Extraction_Caphras_All:updateExtractionList()
  PaGlobal_Extraction_Caphras_All._moneyWhereType = CppEnums.ItemWhereType.eInventory
  PaGlobal_Extraction_Caphras_All._ui.btn_inven:SetCheck(true)
  PaGlobal_Extraction_Caphras_All._ui.btn_warehouse:SetCheck(false)
  PaGlobal_Extraction_Caphras_All._isNoMoney = false
end
function PaGlobal_Extraction_Caphras_All:prepareOpen()
  if nil == Panel_Window_Extraction_Caphras_All then
    return
  end
  self.openUiSetting()
  local posY = (getScreenSizeY() - Panel_Window_Extraction_Caphras_All:GetSizeY() - Panel_Window_Extraction_All:GetSizeY()) * 0.5
  Panel_Window_Extraction_Caphras_All:SetPosY(posY)
  PaGlobal_Extraction_Caphras_All:open()
end
function PaGlobal_Extraction_Caphras_All:open()
  if nil == Panel_Window_Extraction_Caphras_All then
    return
  end
  Panel_Window_Extraction_Caphras_All:SetShow(true)
end
function PaGlobal_Extraction_Caphras_All:prepareClose()
  if nil == Panel_Window_Extraction_Caphras_All then
    return
  end
  Panel_Window_Extraction_Caphras_All:ClearUpdateLuaFunc()
  audioPostEvent_SystemUi(5, 99)
  _AudioPostEvent_SystemUiForXBOX(5, 99)
  PaGlobal_Extraction_Caphras_All:close()
end
function PaGlobal_Extraction_Caphras_All:close()
  if nil == Panel_Window_Extraction_Caphras_All then
    return
  end
  Panel_Window_Extraction_Caphras_All:SetShow(false)
end
function PaGlobal_Extraction_Caphras_All:validate()
  if nil == Panel_Window_Extraction_Caphras_All then
    return
  end
  self:allValidate()
  self:pcValidate()
  self:consoleValidate()
end
function PaGlobal_Extraction_Caphras_All:allValidate()
  if nil == Panel_Window_Extraction_Caphras_All then
    return
  end
  self._ui.stc_extractableItemSlot:isValidate()
  self._ui.stc_resultItmeSlot:isValidate()
  self._ui.stc_moneyArea:isValidate()
  self._ui.stc_moneyIcon:isValidate()
  self._ui.stc_money:isValidate()
  self._ui.btn_inven:isValidate()
  self._ui.stc_invenMoney:isValidate()
  self._ui.btn_warehouse:isValidate()
  self._ui.stc_warehouseMoney:isValidate()
  self._ui.stc_noticeDesc:isValidate()
  self._ui.btn_aniSkip:isValidate()
end
function PaGlobal_Extraction_Caphras_All:pcValidate()
  if nil == Panel_Window_Extraction_Caphras_All then
    return
  end
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.btn_extraction:isValidate()
end
function PaGlobal_Extraction_Caphras_All:consoleValidate()
  if nil == Panel_Window_Extraction_Caphras_All then
    return
  end
  self._ui_console.stc_bottom:isValidate()
  self._ui_console.btn_select:isValidate()
  self._ui_console.btn_close:isValidate()
  self._ui_console.btn_extraction:isValidate()
end
function PaGlobal_Extraction_Caphras_All:updateExtractionList()
  if nil == Panel_Window_Extraction_Caphras_All then
    return
  end
  self._ui.list2_extractableItem:getElementManager():clearKey()
  local whereType = CppEnums.ItemWhereType.eInventory
  local inventory = getSelfPlayer():get():getInventory(whereType)
  if nil == inventory then
    return
  end
  self._equipCnt = 0
  self._caphrasCnt = 0
  local EquipNoMin = CppEnums.EquipSlotNo.rightHand
  local EquipNoMax = CppEnums.EquipSlotNo.equipSlotNoCount
  local invenMaxSize = inventory:sizeXXX()
  for slotNo = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(whereType, slotNo)
    if false == PaGlobal_Extraction_Caphras_All:filterCaphrasItem(slotNo, itemWrapper, whereType) then
      self._caphrasCnt = self._caphrasCnt + 1
      self._equipNo[self._caphrasCnt] = nil
      self._ui.list2_extractableItem:getElementManager():pushKey(toInt64(0, self._caphrasCnt))
      local enchantLevel = itemWrapper:getStaticStatus():get()._key:getEnchantLevel()
      local enchantText = ""
      if 16 <= enchantLevel then
        enchantText = HighEnchantLevel_ReplaceString(enchantLevel) .. " "
      end
      self._itemInfo.name[self._caphrasCnt] = enchantText .. itemWrapper:getStaticStatus():getName()
      self._itemInfo.iconPath[self._caphrasCnt] = itemWrapper:getStaticStatus():getIconPath()
      self._itemInfo.slotNo[self._caphrasCnt] = slotNo
      local isEquipAble = itemWrapper:getStaticStatus():isEquipable()
      local isCash = itemWrapper:getStaticStatus():get():isCash()
      local isAccessory = CppEnums.ItemClassifyType.eItemClassify_Accessory == itemWrapper:getStaticStatus():getItemClassify()
      local balksCnt = itemWrapper:getStaticStatus():getExtractionCount_s64()
      local cronsCnt = itemWrapper:getStaticStatus():getCronCount_s64()
      if 0 < ToClient_getSpecialEnchantDisplayLevel(itemWrapper:getStaticStatus():get()._key) then
        enchantLevel = ToClient_getSpecialEnchantDisplayLevel(itemWrapper:getStaticStatus():get()._key)
        isAccessory = false
      end
      self._itemInfo.itemEnchantLevle[self._caphrasCnt] = PaGlobal_Extraction_Caphras_All:getEnchantText(isEquipAble, isCash, isAccessory, balksCnt, cronsCnt, enchantLevel)
    end
  end
  for equipNo = EquipNoMin, EquipNoMax do
    local itemWrapper = ToClient_getEquipmentItem(equipNo)
    if false == PaGlobal_Extraction_Caphras_All:filterCaphrasItem(equipNo, itemWrapper, whereType, true) then
      self._caphrasCnt = self._caphrasCnt + 1
      self._equipCnt = self._equipCnt + 1
      self._ui.list2_extractableItem:getElementManager():pushKey(toInt64(0, self._caphrasCnt))
      self._equipNo[self._caphrasCnt] = equipNo
      local enchantLevel = itemWrapper:getStaticStatus():get()._key:getEnchantLevel()
      local enchantText = ""
      if 16 <= enchantLevel then
        enchantText = HighEnchantLevel_ReplaceString(enchantLevel) .. " "
      end
      self._itemInfo.name[self._caphrasCnt] = enchantText .. itemWrapper:getStaticStatus():getName()
      self._itemInfo.iconPath[self._caphrasCnt] = itemWrapper:getStaticStatus():getIconPath()
      local isEquipAble = itemWrapper:getStaticStatus():isEquipable()
      local isCash = itemWrapper:getStaticStatus():get():isCash()
      local isAccessory = CppEnums.ItemClassifyType.eItemClassify_Accessory == itemWrapper:getStaticStatus():getItemClassify()
      local balksCnt = itemWrapper:getStaticStatus():getExtractionCount_s64()
      local cronsCnt = itemWrapper:getStaticStatus():getCronCount_s64()
      if 0 < ToClient_getSpecialEnchantDisplayLevel(itemWrapper:getStaticStatus():get()._key) then
        enchantLevel = ToClient_getSpecialEnchantDisplayLevel(itemWrapper:getStaticStatus():get()._key)
        isAccessory = false
      end
      self._itemInfo.itemEnchantLevle[self._caphrasCnt] = PaGlobal_Extraction_Caphras_All:getEnchantText(isEquipAble, isCash, isAccessory, balksCnt, cronsCnt, enchantLevel)
    end
  end
  for index = 1, self._caphrasCnt do
    self._itemInfo.isExtractionEquip[index] = false
  end
  local contentCount = self._ui.list2_extractableItem:getElementManager():getSize()
  if 0 == Int64toInt32(contentCount) then
    self._ui.txt_noItem:SetShow(true)
    self._ui.list2_extractableItem:SetIgnore(true)
  else
    self._ui.txt_noItem:SetShow(false)
    self._ui.list2_extractableItem:SetIgnore(false)
  end
end
function PaGlobal_Extraction_Caphras_All:filterCaphrasItem(slotNo, itemWrapper, whereType, isEquip)
  if nil == itemWrapper then
    return true
  end
  if true == isEquip and true == ToClient_EquipSlot_CheckItemLock(slotNo, CppEnums.ItemWhereType.eEquip) then
    return true
  end
  if true == ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    return true
  end
  return false == itemWrapper:isExtractionCaphras()
end
function PaGlobal_Extraction_Caphras_All:setMyMoney()
  if nil == Panel_Window_Extraction_Caphras_All then
    return
  end
  warehouse_requestInfoFromNpc()
  local invenMoney = getSelfPlayer():get():getInventory():getMoney_s64()
  local warehouseMoney = warehouse_moneyFromNpcShop_s64()
  self._ui.stc_invenMoney:SetText(makeDotMoney(invenMoney))
  self._ui.stc_invenMoney:SetSize(self._ui.stc_invenMoney:GetTextSizeX(), self._ui.stc_invenMoney:GetSizeY())
  self._ui.stc_warehouseMoney:SetText(makeDotMoney(warehouseMoney))
  self._ui.stc_warehouseMoney:SetSize(self._ui.stc_warehouseMoney:GetTextSizeX(), self._ui.stc_warehouseMoney:GetSizeY())
  self._invenMoney = invenMoney
  self._warehouseMoney = warehouseMoney
  self._ui.stc_invenMoney:ComputePos()
  self._ui.stc_warehouseMoney:ComputePos()
end
function PaGlobal_Extraction_Caphras_All:setExtractionPrice(caphraCnt, price)
  UI.ASSERT_NAME(nil ~= price, "PaGlobal_Extraction_Caphras_All:setExtractionPrice\236\157\152 price nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= caphraCnt, "PaGlobal_Extraction_Caphras_All:setExtractionPrice\236\157\152 caphraCnt nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if nil == Panel_Window_Extraction_Caphras_All then
    return
  end
  local unitPrice = ToClient_GetCaphrasExtractionPrice()
  local moneyText = caphraCnt .. " X " .. makeDotMoney(unitPrice) .. " = "
  self._ui.stc_money:SetText(moneyText .. makeDotMoney(price) .. PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_MONEY"))
  self._ui.stc_money:SetSize(self._ui.stc_money:GetTextSizeX(), self._ui.stc_money:GetSizeY())
  self._extractionPrice = price
  local iconPosX = self._ui.stc_money:GetTextSizeX() + self._ui.stc_money:GetSpanSize().x + 5
  self._ui.stc_moneyIcon:SetSpanSize(iconPosX, self._ui.stc_moneyIcon:GetSpanSize().y)
  self._ui.stc_moneyArea:ComputePos()
  self._ui.stc_money:ComputePos()
  self._ui.stc_moneyIcon:ComputePos()
end
function PaGlobal_Extraction_Caphras_All:setNotice()
  if nil == Panel_Window_Extraction_Caphras_All then
    return
  end
  self._ui.stc_noticeDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_noticeDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_CAPHRAS_DESC"))
  if self._ui.stc_noticeDesc:GetTextSizeX() > self._ui.stc_noticeDesc:GetSizeX() then
    local sizeY = self._ui.stc_noticeDesc:GetTextSizeX() - self._ui.stc_noticeDesc:GetSizeX()
    self._ui.stc_noticeDesc:SetSize(self._ui.stc_noticeDesc:GetSizeX(), self._ui.stc_noticeDesc:GetSizeY() + sizeY)
    local leftBottomArea = UI.getChildControl(Panel_Window_Extraction_Caphras_All, "Static_LeftBottomDescArea")
    leftBottomArea:SetSize(leftBottomArea:GetSizeX(), leftBottomArea:GetSizeY() + sizeY)
    local rightArea = UI.getChildControl(Panel_Window_Extraction_Caphras_All, "Static_RightArea")
    rightArea:SetSize(rightArea:GetSizeX(), rightArea:GetSizeY() + sizeY)
    Panel_Window_Extraction_Caphras_All:SetSize(Panel_Window_Extraction_Caphras_All:GetSizeX() + Panel_Window_Extraction_Caphras_All:GetSizeY() + sizeY)
  end
end
function PaGlobal_Extraction_Caphras_All:setExtractionIcon(slotNo, itemWrapper)
  if nil == Panel_Window_Extraction_Caphras_All or nil == itemWrapper then
    return
  end
  local tempKey = itemWrapper:get():getKey()
  local staticStatus = itemWrapper:getStaticStatus()
  local isCaphrasCount = itemWrapper:getExtractCaphrasCount()
  local isCaphrasPrice = itemWrapper:getExtractCaphrasPrice()
  if nil == staticStatus or true == self._isAniStart then
    return
  end
  self._ui._icon_items:setItemByStaticStatus(staticStatus, Defines.s64_const.s64_1)
  if toInt64(0, 0) == isCaphrasCount then
    isCaphrasCount = toInt64(0, 1)
  end
  self._savedCount = isCaphrasCount
  self._fromSlotNo = slotNo
  self._fromWhereType = CppEnums.ItemWhereType.eInventory
  self._fromSlotOn = true
  self._resultSlotOn = false
  self._resultSlotNo = -1
  self._resultWhereType = -1
  local prevStatic = getItemEnchantStaticStatus(ItemEnchantKey(721003))
  self._ui._icon_result:clearItem()
  if prevStatic ~= nil then
    self._ui._icon_result:setItemByStaticStatus(prevStatic, isCaphrasCount)
    self:setExtractionPrice(Int64toInt32(isCaphrasCount), isCaphrasPrice)
  end
  if false == self._isConsole then
    self._ui_pc.btn_extraction:SetEnable(true)
    self._ui_pc.btn_extraction:SetMonoTone(false)
  else
    self._ui_console.btn_extraction:SetEnable(true)
    self._ui_console.btn_extraction:SetMonoTone(false)
    Panel_Window_Extraction_Caphras_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Extraction_Caphras_All_ExtractionButton()")
  end
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_Extraction_Caphras_All:Clear()
  if nil == Panel_Window_Extraction_Caphras_All then
    return
  end
  self._fromSlotNo = -1
  self._fromWhereType = -1
  self._resultSlotNo = -1
  self._resultWhereType = -1
  self._fromSlotOn = false
  self._resultSlotOn = false
  self._ui._icon_items:clearItem()
  self._ui._icon_result:clearItem()
  self._ui.btn_aniSkip:SetIgnore(false)
  self._delta_ani_time = 0
  self._isAniStart = false
  if false == self._isConsole then
    self._ui_pc.btn_extraction:SetEnable(false)
    self._ui_pc.btn_extraction:SetMonoTone(true)
  else
    self._ui_console.btn_extraction:SetEnable(false)
    self._ui_console.btn_extraction:SetMonoTone(true)
    Panel_Window_Extraction_Caphras_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  end
  self._ui.list2_extractableItem:SetEnable(true)
  Panel_Tooltip_Item_hideTooltip()
  self._ui.stc_extractableItemSlot:EraseAllEffect()
  self._ui.stc_resultItmeSlot:EraseAllEffect()
end
function PaGlobal_Extraction_Caphras_All:ClearItemSlot()
  if nil == Panel_Window_Extraction_Caphras_All then
    return
  end
  if true == self._isAniStart then
    return
  end
  self._fromSlotNo = -1
  self._fromWhereType = -1
  self._fromSlotOn = false
  self._ui._icon_items:clearItem()
  if false == self._resultSlotOn then
    self._ui._icon_result:clearItem()
  end
  if false == self._isConsole then
    self._ui_pc.btn_extraction:SetEnable(false)
    self._ui_pc.btn_extraction:SetMonoTone(true)
  else
    self._ui_console.btn_extraction:SetEnable(false)
    self._ui_console.btn_extraction:SetMonoTone(true)
    Panel_Window_Extraction_Caphras_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  end
  if nil == self._listControl[1] then
    return
  end
  for index = 1, self._caphrasCnt do
    self._itemInfo.isExtractionEquip[index] = false
    if nil ~= self._listControl[index] then
      local btn = UI.getChildControl(self._listControl[index], "RadioButton_ExtractableItem")
      btn:SetCheck(false)
    end
  end
  local btn = UI.getChildControl(self._listControl[1], "RadioButton_ExtractableItem")
  btn:SetCheck(true)
  self._ui.list2_extractableItem:requestUpdateVisible()
  if CppEnums.ItemWhereType.eInventory == self._moneyWhereType then
    self._ui.btn_inven:SetCheck(true)
  else
    self._ui.btn_warehouse:SetCheck(true)
  end
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_Extraction_Caphras_All:getEnchantText(isEquipable, isCash, isAccessory, balksCnt, cronsCnt, enchantLev)
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
