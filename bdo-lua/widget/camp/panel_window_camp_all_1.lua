function PaGlobal_Camp_All:initialize()
  if true == PaGlobal_Camp_All._initialize then
    return
  end
  self._ui.stc_TitleBG = UI.getChildControl(Panel_Window_Camp_All, "Static_TitleBG")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_TitleBG, "Button_Win_Close")
  self._ui.btn_Guide = UI.getChildControl(self._ui.stc_TitleBG, "Button_Question")
  self._ui.stc_Unseal = UI.getChildControl(Panel_Window_Camp_All, "Static_Unseal")
  self._ui.stc_UnsealImg = UI.getChildControl(Panel_Window_Camp_All, "Static_UnsealCampImg")
  self._ui.btn_UnsealTent = UI.getChildControl(self._ui.stc_Unseal, "Button_UnsealTent")
  self._ui.stc_Bottom = UI.getChildControl(Panel_Window_Camp_All, "Static_Bottom")
  self._ui.btn_RemoteTent = UI.getChildControl(self._ui.stc_Bottom, "Button_RemoteSealTent")
  self._ui.btn_Villa = UI.getChildControl(self._ui.stc_Bottom, "Button_Menu_6")
  local nonActiveMenu = UI.getChildControl(self._ui.stc_Bottom, "StaticText_FunctionOff")
  local menuStr = UI.getChildControl(nonActiveMenu, "StaticText_Function")
  local needItemStr = UI.getChildControl(nonActiveMenu, "StaticText_NeedItem")
  self._ui.stc_slot = UI.getChildControl(Panel_Window_Camp_All, "Static_Slot")
  self._ui.slotBg = {
    [3] = UI.getChildControl(self._ui.stc_slot, "Static_ItemSlotBg_Warehouse"),
    [4] = UI.getChildControl(self._ui.stc_slot, "Static_ItemSlotBg_Repair"),
    [5] = UI.getChildControl(self._ui.stc_slot, "Static_ItemSlotBg_Shop"),
    [6] = UI.getChildControl(self._ui.stc_slot, "Static_TentSlotBg")
  }
  local slotTitle = {
    [3] = UI.getChildControl(self._ui.slotBg[3], "StaticText_Warehouse"),
    [4] = UI.getChildControl(self._ui.slotBg[4], "StaticText_Repair"),
    [5] = UI.getChildControl(self._ui.slotBg[5], "StaticText_Shop"),
    [6] = UI.getChildControl(self._ui.slotBg[6], "StaticText_Tent")
  }
  for index, value in pairs(self._config._slotNo) do
    local slot = {}
    SlotItem.new(slot, "CampEquip_" .. value, value, self._ui.slotBg[value], self._config._itemSlot)
    slot:createChild()
    if true == _ContentsGroup_UsePadSnapping then
      slot.icon:addInputEvent("Mouse_LUp", "HandleClickedLUp_Camp_All_AddEquipItem(" .. value .. ")")
    else
      slot.icon:addInputEvent("Mouse_RUp", "HandleClickedLUp_Camp_All_AddEquipItem(" .. value .. ")")
    end
    slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_Camp_All_ShowEquipItemTooltip(" .. value .. ", true)")
    slot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_Camp_All_ShowEquipItemTooltip(" .. value .. ", false)")
    self._itemSlots[value] = slot
    self._ui.slotAddBtn[value] = UI.getChildControl(self._ui.slotBg[value], "Static_Button_Add")
    slotTitle[value]:SetTextMode(__eTextMode_AutoWrap)
    slotTitle[value]:SetText(self._config._menuStr[value])
  end
  for index, value in pairs(self._config._menuNo) do
    self._ui.btn_Menu[value] = UI.getChildControl(self._ui.stc_Bottom, "Button_Menu_" .. value)
    self._ui.btn_Menu[value]:addInputEvent("Mouse_LUp", "HandleClickedLUp_Camp_All_OpenMenuFuction(" .. value .. ")")
    local tempNonActiveMenu = UI.createControl(__ePAUIControl_Static, self._ui.stc_Bottom, "NonActiveMenu_" .. tostring(value))
    CopyBaseProperty(nonActiveMenu, tempNonActiveMenu)
    tempNonActiveMenu:SetShow(true)
    tempNonActiveMenu:SetPosY(self._ui.btn_Menu[value]:GetPosY())
    local tempMenuStr = UI.createControl(__ePAUIControl_StaticText, tempNonActiveMenu, "FunctionText_" .. tostring(value))
    CopyBaseProperty(menuStr, tempMenuStr)
    local tempNeedItemStr = UI.createControl(__ePAUIControl_StaticText, tempNonActiveMenu, "NeedItemText_" .. tostring(value))
    CopyBaseProperty(needItemStr, tempNeedItemStr)
    tempMenuStr:SetText(self._config._menuStr[value])
    tempNeedItemStr:SetText(self._config._menuNonActiveStr[value])
    self._ui.nonActiveMenuBtn[value] = tempNonActiveMenu
  end
  self._panelSizeY = Panel_Window_Camp_All:GetSizeY()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Camp_All:registEventHandler()
  if nil == Panel_Window_Camp_All then
    return
  end
  self._ui.btn_RemoteTent:addInputEvent("Mouse_LUp", "HandleClickedLUp_Camp_All_RemoteTent()")
  self._ui.btn_UnsealTent:addInputEvent("Mouse_LUp", "HandleClickedLUp_Camp_All_UnsealTent()")
  self._ui.btn_Villa:addInputEvent("Mouse_LUp", "HandleClickedLUp_Camp_All_OpenVilla()")
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Camp_All_Close()")
  if false == _ContentsGroup_UsePadSnapping then
    self._ui.btn_RemoteTent:addInputEvent("Mouse_On", "PaGlobalFunc_Camp_All_ShowButtonTooltip(0, true)")
    self._ui.btn_RemoteTent:addInputEvent("Mouse_Out", "PaGlobalFunc_Camp_All_ShowButtonTooltip(0, false)")
    self._ui.btn_UnsealTent:addInputEvent("Mouse_On", "PaGlobalFunc_Camp_All_ShowButtonTooltip(1, true)")
    self._ui.btn_UnsealTent:addInputEvent("Mouse_Out", "PaGlobalFunc_Camp_All_ShowButtonTooltip(1, false)")
    self._ui.btn_Guide:addInputEvent("Mouse_On", "PaGlobalFunc_Camp_All_ShowButtonTooltip(2, true )")
    self._ui.btn_Guide:addInputEvent("Mouse_Out", "PaGlobalFunc_Camp_All_ShowButtonTooltip(2, false )")
  end
  registerEvent("FromClient_OpenCampingRepair", "FromClient_Camp_All_OpenCampingRepair")
  registerEvent("FromClient_OpenCampingShop", "FromClient_Camp_All_OpenCampingShop")
  registerEvent("FromClient_OpenCampingInfo", "FromClient_Camp_All_OpenByActorKeyRaw")
  registerEvent("EventServantEquipItem", "FromClient_Camp_All_EventServantEquipItem")
  registerEvent("EventServantEquipmentUpdate", "FromClient_Camp_All_CampingUpdate")
  registerEvent("FromClient_CampingTentSeal", "FromClient_Camp_All_CampingTentSeal")
  registerEvent("FromClient_CampingTentUnSeal", "FromClient_Camp_All_CampingUpdate")
  if _ContentsGroup_isCamp then
    self._ui.btn_UnsealTent:setButtonShortcuts("PANEL_SIMPLESHORTCUT_TENT_INSTALL")
    self._ui.btn_RemoteTent:setButtonShortcuts("PANEL_SIMPLESHORTCUT_TENT_UNINSTALL")
    self._ui.btn_Menu[3]:setButtonShortcuts("PANEL_SIMPLESHORTCUT_TENT_WAREHOUSE")
    self._ui.btn_Menu[4]:setButtonShortcuts("PANEL_SIMPLESHORTCUT_TENT_REPAIR")
    self._ui.btn_Menu[5]:setButtonShortcuts("PANEL_SIMPLESHORTCUT_TENT_STORE")
  end
end
function PaGlobal_Camp_All:prepareOpen()
  if nil == Panel_Window_Camp_All then
    return
  end
  self:setUI()
  self:open()
  ToClient_padSnapSetTargetPanel(Panel_Window_Camp_All)
end
function PaGlobal_Camp_All:open()
  if nil == Panel_Window_Camp_All then
    return
  end
  Panel_Window_Camp_All:SetShow(true)
end
function PaGlobal_Camp_All:prepareClose()
  if nil == Panel_Window_Camp_All then
    return
  end
  self._isCamping = false
  self:close()
end
function PaGlobal_Camp_All:close()
  if nil == Panel_Window_Camp_All then
    return
  end
  Panel_Window_Camp_All:SetShow(false)
end
function PaGlobal_Camp_All:update()
  if nil == Panel_Window_Camp_All then
    return
  end
  local isUnseal = ToClient_isCampingUnseal()
  for index, value in pairs(self._config._slotNo) do
    local slot = self._itemSlots[value]
    if isUnseal then
      local itemWrapper = ToClient_requestCampingEquipItem(value)
      if nil ~= itemWrapper then
        if 6 ~= value then
          self._ui.nonActiveMenuBtn[value]:SetShow(false)
          self._ui.btn_Menu[value]:SetShow(true)
        end
        self._config._isSetItem[value] = true
        slot:setItem(itemWrapper)
      else
        self._ui.slotAddBtn[value]:SetShow(false)
        if 6 ~= value then
          self._ui.nonActiveMenuBtn[value]:SetShow(true)
          self._ui.btn_Menu[value]:SetShow(false)
        end
        self._config._isSetItem[value] = false
        slot:clearItem()
      end
    else
      self._config._isSetItem[value] = false
      slot:clearItem()
    end
  end
  if isUnseal then
    Panel_Window_Camp_All:SetSize(Panel_Window_Camp_All:GetSizeX(), self._panelSizeY)
    Panel_Window_Camp_All:ComputePos()
    self._ui.stc_Unseal:SetShow(false)
    self._ui.btn_UnsealTent:SetShow(false)
    self._ui.stc_Bottom:SetShow(true)
    self._ui.stc_slot:SetShow(true)
    self._ui.stc_UnsealImg:SetShow(true)
  else
    self._ui.stc_Unseal:SetShow(true)
    self._ui.btn_UnsealTent:SetShow(true)
    self._ui.stc_Bottom:SetShow(false)
    self._ui.stc_slot:SetShow(false)
    self._ui.stc_UnsealImg:SetShow(true)
    Panel_Window_Camp_All:SetSize(Panel_Window_Camp_All:GetSizeX(), self._panelSizeY - self._ui.stc_Bottom:GetSizeY() + self._ui.stc_Unseal:GetSizeY() - 10)
    self._ui.stc_Unseal:SetPosY(self._ui.stc_Bottom:GetPosY())
    Panel_Window_Camp_All:ComputePos()
  end
end
function PaGlobal_Camp_All:setUI()
  if true == _ContentsGroup_UsePadSnapping then
    self._ui.btn_Close:SetShow(false)
    self._ui.btn_Guide:SetShow(false)
  else
    self._ui.btn_Close:SetShow(true)
    self._ui.btn_Guide:SetShow(true)
  end
  self:update()
end
function PaGlobal_Camp_All:validate()
  if nil == Panel_Window_Camp_All then
    return
  end
  self._ui.stc_TitleBG:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.stc_Unseal:isValidate()
  self._ui.stc_UnsealImg:isValidate()
  self._ui.btn_UnsealTent:isValidate()
  self._ui.stc_Bottom:isValidate()
  self._ui.btn_RemoteTent:isValidate()
  self._ui.btn_Villa:isValidate()
end
function PaGlobal_Camp_All:unsealTent()
  ToClient_requestServantUnsealCampingTent(0)
  self._isOpen = true
end
function PaGlobal_Camp_All:remoteTent()
  local hasTent = ToClient_requestCheckHasServantCampingTent()
  if false == hasTent then
    return
  end
  local FunctionYesRemoteSeal = function()
    ToClient_requestServantCompulsionSealCampingTent()
    PaGlobalFunc_Camp_All_Close()
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_CAMP_REMOTERESET_DESC")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_CAMP_REMOTERESET_TITLE"),
    content = messageBoxMemo,
    functionYes = FunctionYesRemoteSeal,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_Camp_All:openVilla()
  PaGlobalFunc_BuildingBuff_All_Open()
  PaGlobalFunc_Camp_All_Close()
end
function PaGlobal_Camp_All:openByActorKeyRaw(actorKeyRaw)
  self._actorKeyRaw = actorKeyRaw
end
function PaGlobal_Camp_All:openCampingRepair(flag)
  if true == _ContentsGroup_NewUI_RepairFunction_All then
    PaGlobalFunc_RepairFunc_All_Open(PaGlobal_RepairFunc_All._eType._camp)
  elseif true == _ContentsGroup_RenewUI then
    PaGlobalFunc_RepairInfo_Open()
  else
    PaGlobal_Repair:repair_OpenPanel(true, PaGlobal_Repair._eType._camp)
  end
end
function PaGlobal_Camp_All:changeEquipItem(slotNo)
  if 4 == slotNo or 5 == slotNo or 6 == slotNo then
    local slot = self._itemSlots[slotNo]
    if nil == slot then
      return
    end
    if nil == self._actorKeyRaw then
      return
    end
    local campWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
    if nil == campWrapper then
      return
    end
    local itemWrapper = campWrapper:getEquipItem(slotNo + 1)
    if nil == itemWrapper then
      return
    end
  end
end
function PaGlobal_Camp_All:unequipItem(slotNo)
  local campWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == campWrapper then
    return
  end
  local itemWrapper = campWrapper:getEquipItem(slotNo)
  if nil == itemWrapper then
    return
  end
  servant_doUnequip(campWrapper:getActorKeyRaw(), slotNo)
end
function PaGlobal_Camp_All:addEquipItem(slotNo)
  local isUnseal = ToClient_isCampingUnseal()
  local slot = self._itemSlots[slotNo]
  if isUnseal then
    local itemWrapper = ToClient_requestCampingEquipItem(slotNo)
    if nil ~= itemWrapper then
      self._config._isSetItem[slotNo] = true
      slot:setItem(itemWrapper)
    else
      self._config._isSetItem[slotNo] = false
      slot:clearItem()
    end
  else
    self._config._isSetItem[slotNo] = false
    slot:clearItem()
  end
  self:unequipItem(slotNo)
end
function PaGlobal_Camp_All:openMenuFuction(menuNo)
  if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_UsePadSnapping then
    PaGlobalFunc_ClothInventory_All_Close()
  else
    ClothInventory_Close()
  end
  if 3 == menuNo then
    ToClient_requestCampingInventoryOpen()
  elseif 4 == menuNo then
    ToClient_requestCampingRepairOpen()
  elseif 5 == menuNo then
    ToClient_requestCampingShopOpen()
  end
  ToClient_SetShowDialogFlag(true)
  self:prepareClose()
end
function PaGlobal_Camp_All:getIsCamping()
  return self._isCamping
end
function PaGlobal_Camp_All:setIsCamping(isCamping)
  self._isCamping = isCamping
end
