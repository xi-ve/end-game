function PaGlobal_ServantRegist_All:initialize()
  if nil == Panel_Dialog_ServantRegist_All or true == self.initialize then
    return
  end
  self._defaultPanelSizeY = Panel_Dialog_ServantRegist_All:GetSizeY()
  self._ui._stc_Title = UI.getChildControl(Panel_Dialog_ServantRegist_All, "StaticText_Title")
  self._ui._pc._btn_Close = UI.getChildControl(Panel_Dialog_ServantRegist_All, "Button_Close")
  self._ui._stc_Bg = UI.getChildControl(Panel_Dialog_ServantRegist_All, "Static_Bg")
  self._ui._txt_Desc = UI.getChildControl(Panel_Dialog_ServantRegist_All, "StaticText_Desc")
  self._ui._stc_ItemSlotBg_1 = UI.getChildControl(Panel_Dialog_ServantRegist_All, "Static_ItemSlotBg_1")
  self._ui._stc_ItemSlotBg_2 = UI.getChildControl(Panel_Dialog_ServantRegist_All, "Static_ItemSlotBg_2")
  self._ui._stc_ItemSlotBg_3 = UI.getChildControl(Panel_Dialog_ServantRegist_All, "Static_ItemSlotBg_3")
  self._ui._stc_ItemSlotBg_4 = UI.getChildControl(Panel_Dialog_ServantRegist_All, "Static_ItemSlotBg_4")
  self._ui._stc_ItemSlotBg_5 = UI.getChildControl(Panel_Dialog_ServantRegist_All, "Static_ItemSlotBg_5")
  self._ui._stc_ItemSlotBg_6 = UI.getChildControl(Panel_Dialog_ServantRegist_All, "Static_ItemSlotBg_6")
  self._ui._stc_ItemSlotBg_7 = UI.getChildControl(Panel_Dialog_ServantRegist_All, "Static_ItemSlotBg_7")
  self._ui._pc._btn_Left = UI.getChildControl(Panel_Dialog_ServantRegist_All, "Button_Left")
  self._ui._pc._btn_Right = UI.getChildControl(Panel_Dialog_ServantRegist_All, "Button_Right")
  self._ui._txt_RegistItemName = UI.getChildControl(Panel_Dialog_ServantRegist_All, "StaticText_RegistItemName")
  self._ui._stc_EditNaming = UI.getChildControl(Panel_Dialog_ServantRegist_All, "Edit_Naming")
  self._ui._pc._stc_bottomBtn = UI.getChildControl(Panel_Dialog_ServantRegist_All, "Static_BottomButton")
  self._ui._pc._btn_Confirm = UI.getChildControl(self._ui._pc._stc_bottomBtn, "Button_Confirm")
  self._ui._pc._btn_Cancel = UI.getChildControl(self._ui._pc._stc_bottomBtn, "Button_Cancel")
  self._ui._txt_HpTitle = UI.getChildControl(Panel_Dialog_ServantRegist_All, "StaticText_HP")
  self._ui._txt_StaminaTitle = UI.getChildControl(Panel_Dialog_ServantRegist_All, "StaticText_SP")
  self._ui._txt_WeightTitle = UI.getChildControl(Panel_Dialog_ServantRegist_All, "StaticText_Weight")
  self._ui._txt_LifeSpanTitle = UI.getChildControl(Panel_Dialog_ServantRegist_All, "StaticText_Life")
  self._ui._txt_SpeedTitle = UI.getChildControl(Panel_Dialog_ServantRegist_All, "StaticText_Speed")
  self._ui._txt_AccelTitle = UI.getChildControl(Panel_Dialog_ServantRegist_All, "StaticText_Acc")
  self._ui._txt_TurnTitle = UI.getChildControl(Panel_Dialog_ServantRegist_All, "StaticText_Rotate")
  self._ui._txt_BrakeTitle = UI.getChildControl(Panel_Dialog_ServantRegist_All, "StaticText_Break")
  self._ui._txt_Hp = UI.getChildControl(Panel_Dialog_ServantRegist_All, "StaticText_HP_Val")
  self._ui._txt_Stamina = UI.getChildControl(Panel_Dialog_ServantRegist_All, "StaticText_SP_Val")
  self._ui._txt_Weight = UI.getChildControl(Panel_Dialog_ServantRegist_All, "StaticText_Weight_Val")
  self._ui._txt_LifeSpan = UI.getChildControl(Panel_Dialog_ServantRegist_All, "StaticText_Life_Val")
  self._ui._txt_Speed = UI.getChildControl(Panel_Dialog_ServantRegist_All, "StaticText_Speed_Val")
  self._ui._txt_Accel = UI.getChildControl(Panel_Dialog_ServantRegist_All, "StaticText_Acc_Val")
  self._ui._txt_Turn = UI.getChildControl(Panel_Dialog_ServantRegist_All, "StaticText_Rotate_Val")
  self._ui._txt_Brake = UI.getChildControl(Panel_Dialog_ServantRegist_All, "StaticText_Break_Val")
  self._ui._console._stc_LT_console = UI.getChildControl(Panel_Dialog_ServantRegist_All, "Static_LT_ConsoleUI")
  self._ui._console._stc_RT_console = UI.getChildControl(Panel_Dialog_ServantRegist_All, "Static_RT_ConsoleUI")
  self._ui._console._stc_bottomBg = UI.getChildControl(Panel_Dialog_ServantRegist_All, "Static_Bottombg")
  self._ui._console._stc_A_console = UI.getChildControl(self._ui._console._stc_bottomBg, "StaticText_ChangeName")
  self._ui._console._stc_X_console = UI.getChildControl(self._ui._console._stc_bottomBg, "StaticText_Confirm_ConsoleUI")
  self._ui._console._stc_B_console = UI.getChildControl(self._ui._console._stc_bottomBg, "StaticText_Cancel_ConsoleUI")
  for idx = 0, self._SHOWSLOTCOUNT - 1 do
    local slot = {}
    local parent = UI.getChildControl(Panel_Dialog_ServantRegist_All, "Static_ItemSlotBg_" .. tostring(idx + 1))
    local tempTable = {
      _slot = nil,
      _parent = nil,
      _itemData = nil
    }
    SlotItem.new(slot, "MapaeIcon_" .. idx + 1, idx + 1, parent, self.slotConfig)
    slot:createChild()
    tempTable._slot = slot
    tempTable._parent = parent
    self._itemSlotTable[idx] = tempTable
  end
  self._ui._txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_Desc:SetText(self._ui._txt_Desc:GetText())
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_ServantRegist_All:validate()
  PaGlobal_ServantRegist_All:isConsoleUI(self._isConsole)
  PaGlobal_ServantRegist_All:registerEventHandler(self._isConsole)
end
function PaGlobal_ServantRegist_All:registerEventHandler(isConsole)
  if nil == Panel_Dialog_ServantRegist_All or false == self._initialize then
    return
  end
  registerEvent("onScreenResize", "FromClient_ServantRegist_All_OnScreenResize")
  self._ui._stc_EditNaming:SetMaxInput(getGameServiceTypeServantNameLength())
  if false == isConsole then
    self._ui._pc._btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantRegist_All_Close()")
    self._ui._pc._btn_Left:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantRegist_All_PageChange(false)")
    self._ui._pc._btn_Right:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantRegist_All_PageChange(true)")
    Panel_Dialog_ServantRegist_All:SetDragEnable(true)
    Panel_Dialog_ServantRegist_All:SetDragAll(true)
    self._ui._stc_EditNaming:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantRegist_All_ClearEdit()")
    self._ui._stc_EditNaming:RegistReturnKeyEvent("PaGlobal_ServantRegist_All_RegistServantInputEnter()")
    self._ui._pc._btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantRegist_All_Close()")
    self._ui._pc._btn_Confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantRegist_All_RegisterServantConfirm()")
  else
    self._ui._stc_EditNaming:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_ServantRegist_All_ConfirmVirtualKeyBoard")
    Panel_Dialog_ServantRegist_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ServantRegist_All_RegisterServantConfirm()")
    Panel_Dialog_ServantRegist_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_ServantRegist_All_ClearEdit()")
    Panel_Dialog_ServantRegist_All:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "HandleEventLUp_ServantRegist_All_PageChange(false)")
    Panel_Dialog_ServantRegist_All:registerPadEvent(__eConsoleUIPadEvent_Up_RT, "HandleEventLUp_ServantRegist_All_PageChange(true)")
  end
end
function PaGlobal_ServantRegist_All:isConsoleUI(isConsole)
  if nil == Panel_Dialog_ServantRegist_All or false == self._initialize then
    return
  end
  local isPc = false == isConsole
  for k, v in pairs(self._ui._pc) do
    v:SetShow(isPc)
  end
  for k, v in pairs(self._ui._console) do
    v:SetShow(isConsole)
  end
  if false == isConsole then
  else
    local keyguide = {
      self._ui._console._stc_A_console,
      self._ui._console._stc_X_console,
      self._ui._console._stc_B_console
    }
    local btnSize = self._ui._pc._stc_bottomBtn:GetSizeY()
    Panel_Dialog_ServantRegist_All:SetSize(Panel_Dialog_ServantRegist_All:GetSizeX(), Panel_Dialog_ServantRegist_All:GetSizeY() - btnSize)
    self._ui._stc_Bg:SetSize(Panel_Dialog_ServantRegist_All:GetSizeX(), self._ui._stc_Bg:GetSizeY() - btnSize)
    self._ui._console._stc_bottomBg:ComputePos()
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui._console._stc_bottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_ServantRegist_All:prepareOpen()
  if nil == Panel_Dialog_ServantRegist_All or true == Panel_Dialog_ServantRegist_All:GetShow() then
    return
  end
  if nil == getSelfPlayer() then
    return
  end
  local inventory = getSelfPlayer():get():getInventory()
  if nil == inventory then
    return
  end
  self._maxInvenCount = inventory:size()
  if false == _ContentsGroup_RenewUI then
    self._ui._stc_EditNaming:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_EDITBOX_COMMENT"), true)
  else
    local randIndex = getRandomValue(1, #PaGlobal_ServantFunction_All._randomName_ForConsole)
    self._ui._stc_EditNaming:SetEditText(PaGlobal_ServantFunction_All._randomName_ForConsole[randIndex])
  end
  if CppEnums.ServantRegist.eEventType_Inventory ~= self._registerType then
    return
  else
    self._ui._stc_ItemSlotBg_1:SetShow(true)
    self._ui._stc_ItemSlotBg_2:SetShow(true)
    self._ui._stc_ItemSlotBg_3:SetShow(true)
    self._ui._stc_ItemSlotBg_4:SetShow(true)
    self._ui._stc_ItemSlotBg_5:SetShow(true)
    self._ui._stc_ItemSlotBg_6:SetShow(true)
    self._ui._stc_ItemSlotBg_7:SetShow(true)
    self._ui._pc._btn_Left:SetShow(true)
    self._ui._pc._btn_Right:SetShow(true)
    self._ui._txt_RegistItemName:SetShow(true)
  end
  self._currentSlotPage = 0
  self._maxPage = 0
  self._maxIndexConsole = 0
  self._currentIndexConsole = 0
  self._isEditing = false
  PaGlobal_ServantRegist_All._currentInvenType = nil
  PaGlobal_ServantRegist_All._currentInvenSlotNo = nil
  if true == self._isConsole then
    Panel_Dialog_ServantRegist_All:ignorePadSnapMoveToOtherPanel()
  end
  PaGlobal_ServantRegist_All:open()
  PaGlobal_ServantRegist_All:getMapaeIndex()
  FromClient_ServantRegist_All_OnScreenResize()
  PaGlobal_ServantRegist_All:update()
end
function PaGlobal_ServantRegist_All:open()
  if nil == Panel_Dialog_ServantRegist_All or true == Panel_Dialog_ServantRegist_All:GetShow() then
    return
  end
  Panel_Dialog_ServantRegist_All:SetShow(true)
end
function PaGlobal_ServantRegist_All:update()
  if nil == Panel_Dialog_ServantRegist_All or false == Panel_Dialog_ServantRegist_All:GetShow() then
    return
  end
  self._ui._txt_RegistItemName:SetShow(false)
  self._ui._pc._btn_Confirm:SetIgnore(true)
  self._ui._pc._btn_Confirm:SetMonoTone(true)
  if 0 >= self._totalSlotCount or nil == self._totalSlotCount then
    return
  end
  self._ui._txt_RegistItemName:SetShow(true)
  self._ui._pc._btn_Confirm:SetIgnore(false)
  self._ui._pc._btn_Confirm:SetMonoTone(false)
  local startIndex = self._currentSlotPage * self._SHOWSLOTCOUNT
  for itemSlotIndex = 0, self._SHOWSLOTCOUNT - 1 do
    if nil ~= self._itemSlotTable[itemSlotIndex] then
      self._itemSlotTable[itemSlotIndex]._slot:clearItem()
      self._itemSlotTable[itemSlotIndex]._slot.icon:SetIgnore(true)
      self._itemSlotTable[itemSlotIndex]._slot.icon:addInputEvent("Mouse_LUp", "")
      self._itemSlotTable[itemSlotIndex]._slot.icon:EraseAllEffect()
      self._itemSlotTable[itemSlotIndex]._itemData = nil
      local dataIndex = itemSlotIndex + startIndex
      if nil ~= self._mapaeInfoTable[dataIndex] then
        local itemWrapper = getInventoryItemByType(self._mapaeInfoTable[dataIndex]._inventoryType, self._mapaeInfoTable[dataIndex]._slotIdx)
        if nil ~= itemWrapper then
          self._itemSlotTable[itemSlotIndex]._slot:setItem(itemWrapper, self._mapaeInfoTable[dataIndex]._slotIdx)
          self._itemSlotTable[itemSlotIndex]._slot.icon:SetIgnore(false)
          self._itemSlotTable[itemSlotIndex]._itemData = self._mapaeInfoTable[dataIndex]
          if true == self._isConsole then
            self._itemSlotTable[itemSlotIndex]._slot.icon:addInputEvent("Mouse_On", "HandleEventLUp_ServantRegist_All_SelectMapae(" .. itemSlotIndex .. ")")
            self._itemSlotTable[itemSlotIndex]._slot.icon:addInputEvent("Mouse_LUp", "HandleEventPadUp_ServantRegist_All_ConfirmRegist()")
          else
            self._itemSlotTable[itemSlotIndex]._slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantRegist_All_SelectMapae(" .. itemSlotIndex .. ")")
          end
        end
      end
    end
  end
  HandleEventLUp_ServantRegist_All_SelectMapae(0)
end
function PaGlobal_ServantRegist_All:getMapaeIndex()
  if nil == Panel_Dialog_ServantRegist_All or false == Panel_Dialog_ServantRegist_All:GetShow() then
    return
  end
  local slotCount = 0
  self._totalSlotCount = 0
  for invenType = 1, 2 do
    local currentWhereType = CppEnums.ItemWhereType.eInventory
    if 2 == invenType then
      currentWhereType = CppEnums.ItemWhereType.eCashInventory
    end
    for slotIdx = inventorySlotNoUserStart(), self._maxInvenCount - 1 do
      local itemWrapper = getInventoryItemByType(currentWhereType, slotIdx)
      if nil ~= itemWrapper and GetUIMode() == Defines.UIMode.eUIMode_Stable and not PaGlobalFunc_ServantFunction_All_EffectFilter_Mapae(slotNo, itemWrapper) then
        local itemSS = itemWrapper:getStaticStatus()
        local mapaeInfo = {_slotIdx = nil, _inventoryType = nil}
        mapaeInfo._slotIdx = slotIdx
        mapaeInfo._inventoryType = currentWhereType
        self._mapaeInfoTable[slotCount] = mapaeInfo
        slotCount = slotCount + 1
      end
    end
  end
  self._totalSlotCount = slotCount
  if 0 < self._totalSlotCount then
    self._maxPage = math.floor((slotCount - 1) / self._SHOWSLOTCOUNT)
  end
end
function PaGlobal_ServantRegist_All:prepareClose()
  if nil == Panel_Dialog_ServantRegist_All or false == Panel_Dialog_ServantRegist_All:GetShow() then
    return
  end
  if false == _ContentsGroup_RenewUI then
    self._ui._stc_EditNaming:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_EDITBOX_COMMENT"), true)
  else
    local randIndex = getRandomValue(1, #PaGlobal_ServantFunction_All._randomName_ForConsole)
    self._ui._stc_EditNaming:SetEditText(PaGlobal_ServantFunction_All._randomName_ForConsole[randIndex])
  end
  for idx = 0, self._totalSlotCount do
    self._mapaeInfoTable[idx] = {}
  end
  self._mapaeInfoTable = {}
  for itemSlotIndex = 0, self._SHOWSLOTCOUNT - 1 do
    if nil ~= self._itemSlotTable then
      self._itemSlotTable[itemSlotIndex]._slot:clearItem()
      self._itemSlotTable[itemSlotIndex]._itemData = nil
    end
  end
  PaGlobal_ServantRegist_All._selectIdx = 0
  PaGlobalFunc_ServantRegist_All_ClearAllEffect()
  PaGlobal_ServantRegist_All:close()
end
function PaGlobal_ServantRegist_All:close()
  if nil == Panel_Dialog_ServantRegist_All or false == Panel_Dialog_ServantRegist_All:GetShow() then
    return
  end
  Panel_Dialog_ServantRegist_All:SetShow(false)
end
function PaGlobal_ServantRegist_All:validate()
  if nil == Panel_Dialog_ServantRegist_All then
    return
  end
  self._ui._stc_Title:isValidate()
  self._ui._pc._btn_Close:isValidate()
  self._ui._stc_Bg:isValidate()
  self._ui._txt_Desc:isValidate()
  self._ui._stc_ItemSlotBg_1:isValidate()
  self._ui._stc_ItemSlotBg_2:isValidate()
  self._ui._stc_ItemSlotBg_3:isValidate()
  self._ui._stc_ItemSlotBg_4:isValidate()
  self._ui._stc_ItemSlotBg_5:isValidate()
  self._ui._stc_ItemSlotBg_6:isValidate()
  self._ui._stc_ItemSlotBg_7:isValidate()
  self._ui._pc._btn_Left:isValidate()
  self._ui._pc._btn_Right:isValidate()
  self._ui._txt_RegistItemName:isValidate()
  self._ui._stc_EditNaming:isValidate()
  self._ui._pc._btn_Confirm:isValidate()
  self._ui._pc._btn_Cancel:isValidate()
  self._ui._txt_Hp:isValidate()
  self._ui._txt_Stamina:isValidate()
  self._ui._txt_Weight:isValidate()
  self._ui._txt_LifeSpan:isValidate()
  self._ui._txt_Speed:isValidate()
  self._ui._txt_Accel:isValidate()
  self._ui._txt_Turn:isValidate()
  self._ui._txt_Brake:isValidate()
  self._ui._txt_HpTitle:isValidate()
  self._ui._txt_StaminaTitle:isValidate()
  self._ui._txt_WeightTitle:isValidate()
  self._ui._txt_LifeSpanTitle:isValidate()
  self._ui._txt_SpeedTitle:isValidate()
  self._ui._txt_AccelTitle:isValidate()
  self._ui._txt_TurnTitle:isValidate()
  self._ui._txt_BrakeTitle:isValidate()
  self._ui._console._stc_LT_console:isValidate()
  self._ui._console._stc_RT_console:isValidate()
  self._ui._console._stc_bottomBg:isValidate()
  self._ui._console._stc_A_console:isValidate()
  self._ui._console._stc_X_console:isValidate()
  self._ui._console._stc_B_console:isValidate()
  self._initialize = true
end
