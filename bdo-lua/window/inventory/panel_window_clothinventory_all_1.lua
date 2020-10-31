function PaGlobal_ClothInventory_All:initialize()
  if true == PaGlobal_ClothInventory_All._initialize then
    return
  end
  self:initControlAll()
  self:initControlPC()
  self:initControlConsole()
  self:setShowControl()
  self:setData()
  self:resizePanel()
  PaGlobal_ClothInventory_All:registEventHandler()
  PaGlobal_ClothInventory_All:validate()
  PaGlobal_ClothInventory_All._initialize = true
end
function PaGlobal_ClothInventory_All:initControlAll()
  self._ui.stc_BlackBg = UI.getChildControl(Panel_Window_ClothInventory_All, "Static_BG")
  self._ui.stc_TitleBg = UI.getChildControl(Panel_Window_ClothInventory_All, "Static_TitleBg")
  self._ui.stc_DescBg = UI.getChildControl(Panel_Window_ClothInventory_All, "Static_DescBg")
  self._ui.stc_SlotArea = UI.getChildControl(Panel_Window_ClothInventory_All, "Static_ItemSlotArea")
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_TitleBg, "StaticText_Title")
  self._ui.txt_Desc = UI.getChildControl(self._ui.stc_DescBg, "StaticText_Desc")
  self._ui.stc_SlotBg = UI.getChildControl(self._ui.stc_SlotArea, "Static_SlotBg_Template")
end
function PaGlobal_ClothInventory_All:initControlPC()
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_TitleBg, "Button_Close_PCUI")
  self._ui.btn_Question = UI.getChildControl(self._ui.stc_TitleBg, "Button_Question_PCUI")
  self._ui.btn_ChangeAll = UI.getChildControl(Panel_Window_ClothInventory_All, "Button_ChangeAll_PCUI")
end
function PaGlobal_ClothInventory_All:initControlConsole()
  self._ui.stc_KeyGuide = UI.getChildControl(Panel_Window_ClothInventory_All, "Static_KeyGuideBg_ConsoleUI")
end
function PaGlobal_ClothInventory_All:setShowControl()
  if _ContentsGroup_UsePadSnapping then
    self._ui.stc_KeyGuide:SetShow(true)
    self._ui.btn_Close:SetShow(false)
    self._ui.btn_Question:SetShow(false)
    self._ui.btn_ChangeAll:SetShow(false)
  else
    self._ui.stc_KeyGuide:SetShow(false)
    self._ui.btn_Close:SetShow(true)
    self._ui.btn_Question:SetShow(true)
    self._ui.btn_ChangeAll:SetShow(true)
  end
end
function PaGlobal_ClothInventory_All:setData()
  self._panelOriginSizeY = Panel_Window_ClothInventory_All:GetSizeY()
  self._slotBgOriginSizeY = self._ui.stc_SlotArea:GetSizeY()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.btn_Question:SetShow(false)
  local descStr = ""
  if _ContentsGroup_UsePadSnapping then
    descStr = PAGetString(Defines.StringSheet_GAME, "LUA_CLOTHINVENTORY_CONSOLE_DESC")
  else
    descStr = PAGetString(Defines.StringSheet_GAME, "LUA_CLOTHINVENTORY_DESC")
  end
  self._ui.txt_Desc:SetText(descStr)
  self:setKeyGuide()
end
function PaGlobal_ClothInventory_All:setKeyGuide()
  if false == _ContentsGroup_UsePadSnapping then
    return
  end
  local bottomKeyGuideY = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_Y_ConsoleUI")
  local bottomKeyGuideA = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_A_ConsoleUI")
  local bottomKeyGuideB = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_B_ConsoleUI")
  local keyGuideAlignY = {bottomKeyGuideY}
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideAlignY, self._ui.stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  if false == bottomKeyGuideY:GetShow() then
    bottomKeyGuideA:SetPosY(bottomKeyGuideY:GetPosY())
    bottomKeyGuideB:SetPosY(bottomKeyGuideY:GetPosY())
    Panel_Window_ClothInventory_All:registerPadEvent(__eConsoleUIPadEvent_Y, "")
  else
    bottomKeyGuideA:SetPosY(bottomKeyGuideY:GetPosY() + bottomKeyGuideY:GetTextSizeY() + 7)
    bottomKeyGuideB:SetPosY(bottomKeyGuideY:GetPosY() + bottomKeyGuideY:GetTextSizeY() + 7)
    Panel_Window_ClothInventory_All:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobalFunc_ClothInventory_All_ChangeAllItem()")
  end
  local keyGuideAlign = {bottomKeyGuideA, bottomKeyGuideB}
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideAlign, self._ui.stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_ClothInventory_All:resizePanel()
  local slotBgOriginSizeY = self._ui.stc_SlotArea:GetSizeY()
  local slotAreaGapSizeY = slotBgOriginSizeY - self._slotBgOriginSizeY
  local descGapSizeY = 0
  local descBgOriginSizeY = self._ui.stc_DescBg:GetSizeY()
  if self._ui.stc_DescBg:GetShow() then
    self._ui.stc_DescBg:SetSize(self._ui.stc_DescBg:GetSizeX(), self._ui.txt_Desc:GetTextSizeY() + 7)
    descGapSizeY = self._ui.stc_DescBg:GetSizeY() + 10
  else
    self._ui.stc_DescBg:ComputePos()
    descGapSizeY = 0
  end
  if _ContentsGroup_UsePadSnapping then
    Panel_Window_ClothInventory_All:SetSize(Panel_Window_ClothInventory_All:GetSizeX(), self._ui.stc_TitleBg:GetSizeY() + self._ui.stc_SlotArea:GetSizeY() + descGapSizeY - self._ui.btn_ChangeAll:GetSizeY() + 60)
    self._ui.stc_BlackBg:SetSize(self._ui.stc_BlackBg:GetSizeX(), Panel_Window_ClothInventory_All:GetSizeY())
    self._ui.stc_KeyGuide:SetPosY(self._ui.stc_BlackBg:GetPosY() + self._ui.stc_BlackBg:GetSizeY())
    Panel_Window_ClothInventory_All:SetPosY(getOriginScreenSizeY() / 3)
  else
    self._ui.stc_BlackBg:SetSize(self._ui.stc_BlackBg:GetSizeX(), self._ui.stc_SlotArea:GetPosY() + self._ui.stc_SlotArea:GetSizeY() + descGapSizeY + 10)
    Panel_Window_ClothInventory_All:ComputePos()
  end
end
function PaGlobal_ClothInventory_All:registEventHandler()
  if nil == Panel_Window_ClothInventory_All then
    return
  end
  Panel_Window_ClothInventory_All:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobalFunc_ClothInventory_All_ChangeAllItem()")
  if true == _ContentsGroup_RenewUI_Tooltip then
    Panel_Window_ClothInventory_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_ClothInventory_All_ShowDetailToolTip()")
  end
  PaGlobal_ClothInventory_All._ui.btn_ChangeAll:addInputEvent("Mouse_LUp", "PaGlobalFunc_ClothInventory_All_ChangeAllItem()")
  PaGlobal_ClothInventory_All._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_ClothInventory_All_Close()")
  registerEvent("FromClient_ShowInventoryBag", "FromClient_ClothInventory_All_ShowInventoryBag")
  registerEvent("FromClient_UpdateInventoryBag", "PaGlobalFunc_ClothInventory_All_UpdateInventoryBag")
  registerEvent("EventEquipItem", "PaGlobalFunc_ClothInventory_All_UpdateInventoryBag")
  registerEvent("EventUnEquipItemToInventory", "PaGlobalFunc_ClothInventory_All_UpdateInventoryBag")
end
function PaGlobal_ClothInventory_All:prepareOpen()
  if nil == Panel_Window_ClothInventory_All then
    return
  end
  if false == self._isConsole then
    PaGlobal_ClothInventory_All:setOpenPos()
  end
  PaGlobal_ClothInventory_All:open()
end
function PaGlobal_ClothInventory_All:open()
  if nil == Panel_Window_ClothInventory_All then
    return
  end
  Panel_Window_ClothInventory_All:SetShow(true)
end
function PaGlobal_ClothInventory_All:prepareClose()
  if nil == Panel_Window_ClothInventory_All then
    return
  end
  if false == Panel_Window_ClothInventory_All:GetShow() then
    return
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  if true == self._isConsole then
    PaGlobalFunc_FloatingTooltip_Close()
  end
  PaGlobal_ClothInventory_All:close()
end
function PaGlobal_ClothInventory_All:close()
  if nil == Panel_Window_ClothInventory_All then
    return
  end
  Panel_Window_ClothInventory_All:SetShow(false)
end
function PaGlobal_ClothInventory_All:update()
  if nil == Panel_Window_ClothInventory_All then
    return
  end
end
function PaGlobal_ClothInventory_All:validate()
  if nil == Panel_Window_ClothInventory_All then
    return
  end
  self._ui.stc_BlackBg:isValidate()
  self._ui.stc_TitleBg:isValidate()
  self._ui.stc_DescBg:isValidate()
  self._ui.stc_SlotArea:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.txt_Desc:isValidate()
  self._ui.stc_SlotBg:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.btn_Question:isValidate()
  self._ui.btn_ChangeAll:isValidate()
  self._ui.stc_KeyGuide:isValidate()
end
function PaGlobal_ClothInventory_All:setOpenPos()
  if true == _ContentsGroup_NewUI_Inventory_All then
    Panel_Window_ClothInventory_All:SetPosX(Panel_Window_Inventory_All:GetPosX() - Panel_Window_ClothInventory_All:GetSizeX() - 5)
    Panel_Window_ClothInventory_All:SetPosY(Panel_Window_Inventory_All:GetPosY() + 80)
  else
    Panel_Window_ClothInventory_All:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Window_ClothInventory_All:GetSizeX() - 5)
    Panel_Window_ClothInventory_All:SetPosY(Panel_Window_Inventory:GetPosY() + 80)
  end
end
function PaGlobal_ClothInventory_All:showInventoryBag(bagType, bagSize, fromWhereType, fromSlotNo)
  local titleStr = ""
  self._bagSize = bagSize
  self._inventoryBagType = bagType
  self._fromWhereType = fromWhereType
  self._fromSlotNo = fromSlotNo
  local bottomKeyGuideY = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_Y_ConsoleUI")
  if CppEnums.InventoryBagType.eInventoryBagType_Cash == bagType then
    bagType = CppEnums.ItemWhereType.eCashInventory
    titleStr = PAGetString(Defines.StringSheet_GAME, "LUA_CLOTHINVENTORY_PEARLTITLE_WITHOUTNAME")
    self._ui.stc_DescBg:SetShow(true)
    if false == self._isConsole then
      self._ui.btn_ChangeAll:SetShow(true)
    else
      bottomKeyGuideY:SetShow(true)
    end
  elseif CppEnums.InventoryBagType.eInventoryBagType_Equipment == bagType then
    bagType = CppEnums.ItemWhereType.eInventory
    titleStr = PAGetString(Defines.StringSheet_GAME, "LUA_CLOTHINVENTORY_TITLE_WITHOUTNAME")
    self._ui.stc_DescBg:SetShow(true)
    if false == self._isConsole then
      self._ui.btn_ChangeAll:SetShow(true)
    else
      bottomKeyGuideY:SetShow(true)
    end
  elseif CppEnums.InventoryBagType.eInventoryBagType_Misc == bagType then
    bagType = CppEnums.ItemWhereType.eInventory
    titleStr = PAGetString(Defines.StringSheet_GAME, "LUA_MISC_INVENTORY_TITLE_WITHOUTNAME")
    self._ui.stc_DescBg:SetShow(false)
    if false == self._isConsole then
      self._ui.btn_ChangeAll:SetShow(false)
    else
      bottomKeyGuideY:SetShow(false)
    end
  elseif CppEnums.InventoryBagType.eInventoryBagType_MiscForCash == bagType then
    bagType = CppEnums.ItemWhereType.eCashInventory
    titleStr = PAGetString(Defines.StringSheet_GAME, "LUA_MISC_INVENTORY_TITLE_WITHOUTNAME")
    self._ui.stc_DescBg:SetShow(false)
    if false == self._isConsole then
      self._ui.btn_ChangeAll:SetShow(false)
    else
      bottomKeyGuideY:SetShow(false)
    end
  end
  self._bagType = bagType
  self._ui.txt_Title:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Title:SetText(titleStr)
  local slotSize = self._ui.stc_SlotBg:GetSizeY()
  for index = 0, bagSize - 1 do
    if nil == self._slotBg[index] then
      self._slotBg[index] = UI.createControl(__ePAUIControl_Static, self._ui.stc_SlotArea, "ClothInventory_SlotBg_" .. index)
      CopyBaseProperty(self._ui.stc_SlotBg, self._slotBg[index])
      self._slotBg[index]:SetPosX(17 + index % 4 * (slotSize + 5))
      self._slotBg[index]:SetPosY(12 + math.floor(index / 4) * (slotSize + 5))
      self._slotBg[index]:SetShow(true)
      if nil == self._slot[index] then
        self._slot[index] = {}
        SlotItem.new(self._slot[index], "ClothInventory_", index, self._slotBg[index], self._config)
        self._slot[index]:createChild()
      end
    end
    local itemWrapper = getInventoryBagItemByType(fromWhereType, fromSlotNo, index)
    if nil ~= itemWrapper then
      self._slot[index]:setItem(itemWrapper, index)
      if _ContentsGroup_UsePadSnapping then
        self._slot[index].icon:addInputEvent("Mouse_LUp", "HandleEventRUp_ClothInventory_All_ClothInvenRClick(" .. fromWhereType .. ", " .. fromSlotNo .. ", " .. index .. ", " .. bagType .. ")")
      else
        self._slot[index].icon:addInputEvent("Mouse_RUp", "HandleEventRUp_ClothInventory_All_ClothInvenRClick(" .. fromWhereType .. ", " .. fromSlotNo .. ", " .. index .. ", " .. bagType .. ")")
      end
    else
      self._slot[index]:clearItem()
      self._slot[index].icon:removeInputEvent("Mouse_LUp")
      self._slot[index].icon:removeInputEvent("Mouse_RUp")
    end
    self._slot[index].icon:addInputEvent("Mouse_On", "PaGlobalFunc_ClothInventory_All_ShowFloatingTooltip(true, " .. fromWhereType .. ", " .. fromSlotNo .. ", " .. index .. ")")
    self._slot[index].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ClothInventory_All_ShowFloatingTooltip(false)")
  end
  for slotIndex = 0, #self._slotBg do
    self._slotBg[slotIndex]:SetShow(slotIndex < bagSize)
    self._slot[slotIndex].icon:SetShow(slotIndex < bagSize)
  end
  self._ui.stc_SlotArea:SetSize(self._ui.stc_SlotArea:GetSizeX(), math.ceil(bagSize / 4) * slotSize + math.ceil(bagSize / 4) * 5 + 20)
  self:setKeyGuide()
  self:resizePanel()
  self:prepareOpen()
  if false == self._isConsole then
    local panelSizeY = self._panelOriginSizeY
    if false == self._ui.stc_DescBg:GetShow() then
      panelSizeY = self._ui.stc_SlotArea:GetPosY() + self._ui.stc_SlotArea:GetSizeY() + 10
      Panel_Window_ClothInventory_All:SetSize(Panel_Window_ClothInventory_All:GetSizeX(), panelSizeY)
    else
      Panel_Window_ClothInventory_All:SetSize(Panel_Window_ClothInventory_All:GetSizeX(), self._ui.stc_BlackBg:GetSizeY() + self._ui.btn_ChangeAll:GetSizeY() + 20)
      self._ui.btn_ChangeAll:ComputePos()
    end
  end
  Inventory_SetFunctor(PaGloablFunc_ClothInventory_All_SetFilter, HandleEventRUp_ClothInventory_All_InvenRClick, nil, nil)
  Panel_Tooltip_Item_hideTooltip()
  if true == self._isConsole then
    PaGlobalFunc_FloatingTooltip_Close()
  end
end
function PaGlobal_ClothInventory_All:updateInventoryBag()
  for index = 0, self._bagSize - 1 do
    self._slot[index]:clearItem()
    local itemWrapper = getInventoryBagItemByType(self._fromWhereType, self._fromSlotNo, index)
    if nil ~= itemWrapper then
      self._slot[index]:setItem(itemWrapper, index)
      if _ContentsGroup_UsePadSnapping then
        self._slot[index].icon:addInputEvent("Mouse_LUp", "HandleEventRUp_ClothInventory_All_ClothInvenRClick(" .. self._fromWhereType .. ", " .. self._fromSlotNo .. ", " .. index .. ", " .. self._bagType .. ")")
      else
        self._slot[index].icon:addInputEvent("Mouse_RUp", "HandleEventRUp_ClothInventory_All_ClothInvenRClick(" .. self._fromWhereType .. ", " .. self._fromSlotNo .. ", " .. index .. ", " .. self._bagType .. ")")
      end
    else
      PaGlobal_ClothInventory_All._currSlotInfo.index = nil
      self._slot[index]:clearItem()
      self._slot[index].icon:removeInputEvent("Mouse_LUp")
      self._slot[index].icon:removeInputEvent("Mouse_RUp")
    end
    self._slot[index].icon:addInputEvent("Mouse_On", "PaGlobalFunc_ClothInventory_All_ShowFloatingTooltip(true, " .. self._fromWhereType .. ", " .. self._fromSlotNo .. ", " .. index .. ")")
    self._slot[index].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ClothInventory_All_ShowFloatingTooltip(false)")
  end
  if true == _ContentsGroup_NewUI_Inventory_All then
    PaGlobalFunc_Inventory_All_UpdateInventoryWeight()
  else
    FGlobal_UpdateInventoryWeight()
  end
end
