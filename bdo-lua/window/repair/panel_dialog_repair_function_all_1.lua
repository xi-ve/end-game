function PaGlobal_RepairFunc_All:initialize()
  if true == PaGlobal_RepairFunc_All._initialize then
    return
  end
  self:controlAll_Init()
  self:controlConsole_Init()
  self:controlOtherPanel_Init()
  self:controlSetShow()
  self:luckyRepair_Set()
  if repair_SetRepairMode ~= nil then
    repair_SetRepairMode(false)
  end
  PaGlobal_RepairFunc_All:registEventHandler()
  PaGlobal_RepairFunc_All:validate()
  PaGlobal_RepairFunc_All._initialize = true
end
function PaGlobal_RepairFunc_All:controlAll_Init()
  if nil == Panel_Dialog_Repair_Function_All then
    return
  end
  self._ui.radio_btn[self._BTN_ENUM.GUILD] = UI.getChildControl(Panel_Dialog_Repair_Function_All, "RadioButton_Function_Guild")
  self._ui.radio_btn[self._BTN_ENUM.SHIP] = UI.getChildControl(Panel_Dialog_Repair_Function_All, "RadioButton_Function_Ship")
  self._ui.radio_btn[self._BTN_ENUM.HORSE] = UI.getChildControl(Panel_Dialog_Repair_Function_All, "RadioButton_Function_Horse")
  self._ui.radio_btn[self._BTN_ENUM.MAXENDURANCE] = UI.getChildControl(Panel_Dialog_Repair_Function_All, "RadioButton_Function_MaxEndurance")
  self._ui.radio_btn[self._BTN_ENUM.EQUIPMENT] = UI.getChildControl(Panel_Dialog_Repair_Function_All, "RadioButton_Function_Equipment")
  self._ui.radio_btn[self._BTN_ENUM.INVENTORYALL] = UI.getChildControl(Panel_Dialog_Repair_Function_All, "RadioButton_Function_InventoryAll")
  self._ui.radio_btn[self._BTN_ENUM.INVENTORY] = UI.getChildControl(Panel_Dialog_Repair_Function_All, "RadioButton_Function_Inventory")
  self._ui.radio_btn[self._BTN_ENUM.EXIT] = UI.getChildControl(Panel_Dialog_Repair_Function_All, "RadioButton_Function_Exit")
  self._ui.radio_btn[self._BTN_ENUM.GUILD]:SetTextMode(__eTextMode_AutoWrap)
  self._ui.radio_btn[self._BTN_ENUM.SHIP]:SetTextMode(__eTextMode_AutoWrap)
  self._ui.radio_btn[self._BTN_ENUM.HORSE]:SetTextMode(__eTextMode_AutoWrap)
  self._ui.radio_btn[self._BTN_ENUM.MAXENDURANCE]:SetTextMode(__eTextMode_AutoWrap)
  self._ui.radio_btn[self._BTN_ENUM.EQUIPMENT]:SetTextMode(__eTextMode_AutoWrap)
  self._ui.radio_btn[self._BTN_ENUM.INVENTORYALL]:SetTextMode(__eTextMode_AutoWrap)
  self._ui.radio_btn[self._BTN_ENUM.INVENTORY]:SetTextMode(__eTextMode_AutoWrap)
  self._ui.radio_btn[self._BTN_ENUM.EXIT]:SetTextMode(__eTextMode_AutoWrap)
  self._ui.radio_btn[self._BTN_ENUM.GUILD]:SetText(self._ui.radio_btn[self._BTN_ENUM.GUILD]:GetText())
  self._ui.radio_btn[self._BTN_ENUM.SHIP]:SetText(self._ui.radio_btn[self._BTN_ENUM.SHIP]:GetText())
  self._ui.radio_btn[self._BTN_ENUM.HORSE]:SetText(self._ui.radio_btn[self._BTN_ENUM.HORSE]:GetText())
  self._ui.radio_btn[self._BTN_ENUM.MAXENDURANCE]:SetText(self._ui.radio_btn[self._BTN_ENUM.MAXENDURANCE]:GetText())
  self._ui.radio_btn[self._BTN_ENUM.EQUIPMENT]:SetText(self._ui.radio_btn[self._BTN_ENUM.EQUIPMENT]:GetText())
  self._ui.radio_btn[self._BTN_ENUM.INVENTORYALL]:SetText(self._ui.radio_btn[self._BTN_ENUM.INVENTORYALL]:GetText())
  self._ui.radio_btn[self._BTN_ENUM.INVENTORY]:SetText(self._ui.radio_btn[self._BTN_ENUM.INVENTORY]:GetText())
  self._ui.radio_btn[self._BTN_ENUM.EXIT]:SetText(self._ui.radio_btn[self._BTN_ENUM.EXIT]:GetText())
  self._ui.stc_selectLine = UI.getChildControl(Panel_Dialog_Repair_Function_All, "Static_SelectedLine")
  self._ui.stc_cursor = UI.getChildControl(Panel_Dialog_Repair_Function_All, "Static_Cursor")
end
function PaGlobal_RepairFunc_All:controlConsole_Init()
  if nil == Panel_Dialog_Repair_Function_All then
    return
  end
  self._ui_console.stc_iconLB = UI.getChildControl(Panel_Dialog_Repair_Function_All, "Button_LB_ConsoleUI")
  self._ui_console.stc_iconRB = UI.getChildControl(Panel_Dialog_Repair_Function_All, "Button_RB_ConsoleUI")
  self._ui_console.stc_iconA = UI.getChildControl(Panel_Dialog_Repair_Function_All, "Button_A_ConsoleUI")
  Panel_Dialog_Repair_Function_All:ignorePadSnapMoveToOtherPanel()
end
function PaGlobal_RepairFunc_All:controlOtherPanel_Init()
  if true == _ContentsGroup_RenewUI_InventoryEquip then
    return
  end
  if false == _ContentsGroup_RenewUI_InventoryEquip then
    if true == _ContentsGroup_NewUI_Equipment_All then
      self._otherPanel._uiRepairMessageBG = UI.getChildControl(Panel_Window_Equipment_All, "Static_Repair_Message")
      self._otherPanel._uiRepairInven = UI.getChildControl(PaGlobal_Equipment_All._ui.stc_bottomButtonArea, "Static_Text_Money")
      self._otherPanel._uiRepairWareHouse = UI.getChildControl(PaGlobal_Equipment_All._ui.stc_bottomButtonArea, "Static_Text_Money2")
      self._otherPanel._uiRepairInvenMoney = UI.getChildControl(PaGlobal_Equipment_All._ui.stc_bottomButtonArea, "RadioButton_Icon_Money")
      self._otherPanel._uiRepairWareHouseMoney = UI.getChildControl(PaGlobal_Equipment_All._ui.stc_bottomButtonArea, "RadioButton_Icon_Money2")
    else
      self._otherPanel._uiRepairMessageBG = UI.getChildControl(Panel_Equipment, "Static_Repair_Message")
      self._otherPanel._uiRepairInven = UI.getChildControl(Panel_Equipment, "Static_Text_Money")
      self._otherPanel._uiRepairWareHouse = UI.getChildControl(Panel_Equipment, "Static_Text_Money2")
      self._otherPanel._uiRepairInvenMoney = UI.getChildControl(Panel_Equipment, "RadioButton_Icon_Money")
      self._otherPanel._uiRepairWareHouseMoney = UI.getChildControl(Panel_Equipment, "RadioButton_Icon_Money2")
    end
  else
    self._otherPanel._uiRepairMessageBG = UI.getChildControl(Panel_Window_Inventory, "Static_Repair_Message")
    self._otherPanel._uiRepairInven = UI.getChildControl(Panel_Window_Inventory, "Static_Text_Money")
    self._otherPanel._uiRepairWareHouse = UI.getChildControl(Panel_Window_Inventory, "Static_Text_Money2")
    self._otherPanel._uiRepairInvenMoney = UI.getChildControl(Panel_Window_Inventory, "RadioButton_Icon_Money")
    self._otherPanel._uiRepairWareHouseMoney = UI.getChildControl(Panel_Window_Inventory, "RadioButton_Icon_Money2")
  end
  self._otherPanel._uiRepairInvenMoney:SetText(self._otherPanel._uiRepairInvenMoney:GetText())
  self._otherPanel._uiRepairWareHouseMoney:SetText(self._otherPanel._uiRepairWareHouseMoney:GetText())
  self._uiRepairInvenMoneyTextSizeX = self._otherPanel._uiRepairInvenMoney:GetTextSizeX()
  self._uiRepairWareHouseMoneyTextSizeX = self._otherPanel._uiRepairWareHouseMoney:GetTextSizeX()
  self._uiRepairValueDefaultSpanX = self._otherPanel._uiRepairInven:GetSpanSize().x
  if self._uiRepairInvenMoneyTextSizeX > self._uiRepairWareHouseMoneyTextSizeX then
    self._uiRepairTextSizeX = self._uiRepairInvenMoneyTextSizeX
  else
    self._uiRepairTextSizeX = self._uiRepairWareHouseMoneyTextSizeX
  end
  self._otherPanel._uiRepairInvenMoney:SetEnableArea(0, 0, self._otherPanel._uiRepairInvenMoney:GetTextSizeX() + 30, 25)
  self._otherPanel._uiRepairWareHouseMoney:SetEnableArea(0, 0, self._otherPanel._uiRepairWareHouseMoney:GetTextSizeX() + 30, 25)
  self._otherPanel._repairMessage = UI.getChildControl(self._otherPanel._uiRepairMessageBG, "StaticText_Repair_Message")
  self._otherPanel._repairMessageJP = UI.getChildControl(self._otherPanel._uiRepairMessageBG, "StaticText_Repair_MessageJP")
end
function PaGlobal_RepairFunc_All:controlSetShow()
  if nil == Panel_Dialog_Repair_Function_All then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  if false == self._isConsole then
    self._ui_console.stc_iconLB:SetShow(false)
    self._ui_console.stc_iconRB:SetShow(false)
    self._ui_console.stc_iconA:SetShow(false)
  else
    self._ui_console.stc_iconLB:SetShow(true)
    self._ui_console.stc_iconRB:SetShow(true)
    self._ui_console.stc_iconA:SetShow(true)
  end
  if getContentsServiceType() ~= CppEnums.ContentsServiceType.eContentsServiceType_Commercial then
    self._ui.radio_btn[self._BTN_ENUM.HORSE]:SetShow(false)
    self._ui.radio_btn[self._BTN_ENUM.SHIP]:SetShow(false)
  else
    self._ui.radio_btn[self._BTN_ENUM.HORSE]:SetShow(true)
    self._ui.radio_btn[self._BTN_ENUM.SHIP]:SetShow(true)
  end
  if true == self._isContentsEnable then
    self._ui.radio_btn[self._BTN_ENUM.GUILD]:SetShow(true)
  else
    self._ui.radio_btn[self._BTN_ENUM.GUILD]:SetShow(false)
  end
  if true == self._isConsole then
    self._ui.radio_btn[self._BTN_ENUM.INVENTORY]:SetShow(true)
  else
    self._ui.radio_btn[self._BTN_ENUM.INVENTORY]:SetShow(false)
  end
end
function PaGlobal_RepairFunc_All:luckyRepair_Set()
  if nil == Panel_LuckyRepair_Result then
    return
  end
  Panel_LuckyRepair_Result:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_LuckyRepair_Result:SetPosX(0)
  Panel_LuckyRepair_Result:SetPosY(0)
  Panel_LuckyRepair_Result:SetColor(Defines.Color.C_00FFFFFF)
  Panel_LuckyRepair_Result:SetIgnore(true)
  local tempSlot = {}
  local MSGBG = UI.getChildControl(Panel_LuckyRepair_Result, "LuckyRepair_BG")
  tempSlot.MSGBG = MSGBG
  local MSG = UI.getChildControl(Panel_LuckyRepair_Result, "LuckyRepair_MSG")
  tempSlot.MSG = MSG
  MSG:SetSize(getScreenSizeX(), 90)
  MSG:ComputePos()
  MSGBG:SetSize(getScreenSizeX() + 40, 90)
  MSGBG:SetPosX(-20)
  MSGBG:ComputePos()
  MSGBG:ResetVertexAni()
  MSGBG:SetVertexAniRun("Ani_Scale_0", true)
  self._luckyRepairMSG = tempSlot
end
function PaGlobal_RepairFunc_All:prepareOpen(eType)
  if nil == Panel_Dialog_Repair_Function_All then
    return
  end
  self._ui.stc_selectLine:SetShow(false)
  self._eRepairType = eType
  self._isCamping = self._eType._camp == self._eRepairType
  if true == _ContentsGroup_NewUI_Camp_All then
    PaGlobal_Camp_All:setIsCamping(self._isCamping)
  else
    PaGlobal_Camp:setIsCamping(self._isCamping)
  end
  SetUIMode(Defines.UIMode.eUIMode_Repair)
  repair_SetRepairMode(true)
  if true == _ContentsGroup_NewUI_Dialog_All then
    PaGlobalFunc_DialogMain_All_SetIgnoreShowDialog(true)
  elseif true == _ContentsGroup_RenewUI_Dailog then
    PaGlobalFunc_MainDialog_setIgnoreShowDialog(true)
  else
    setIgnoreShowDialog(true)
  end
  UIAni.fadeInSCR_Down(Panel_Dialog_Repair_Function_All)
  local invenPosY = 0
  if true == _ContentsGroup_NewUI_Inventory_All then
    if true == Panel_Window_Inventory_All:IsUISubApp() then
      invenPosY = Panel_Window_Inventory_All:GetScreenParentPosY()
    else
      invenPosY = Panel_Window_Inventory_All:GetPosY()
    end
  elseif true == Panel_Window_Inventory:IsUISubApp() then
    invenPosY = Panel_Window_Inventory:GetScreenParentPosY()
  else
    invenPosY = Panel_Window_Inventory:GetPosY()
  end
  if false == self._isConsole then
    Inventory_SetFunctor(PaGlobalFunc_RepairFunc_All_InvenFilter, PaGlobalFunc_RepairFunc_All_InvenRClick, PaGlobalFunc_RepairFunc_All_Close, nil)
    InventoryWindow_Show(true)
    if true == _ContentsGroup_NewUI_Equipment_All then
      Panel_Window_Equipment_All:SetPosY(invenPosY)
    else
      Panel_Equipment:SetPosY(invenPosY)
    end
  else
    InventoryWindow_Close()
  end
  if true == _ContentsGroup_NewUI_Inventory_All then
    PaGlobalFunc_Inventory_All_PosSave()
  else
    Inventory_PosSaveMemory()
  end
  if false == _ContentsGroup_RenewUI_InventoryEquip then
    if true == ToClient_HasWareHouseFromNpc() then
      if toInt64(0, 0) == warehouse_moneyFromNpcShop_s64() then
        self._otherPanel._uiRepairInvenMoney:SetCheck(true)
        self._otherPanel._uiRepairWareHouseMoney:SetCheck(false)
        self._otherPanel._uiRepairWareHouseMoney:SetShow(true)
        self._otherPanel._uiRepairWareHouse:SetShow(true)
      else
        self._otherPanel._uiRepairInvenMoney:SetCheck(false)
        self._otherPanel._uiRepairWareHouseMoney:SetCheck(true)
        self._otherPanel._uiRepairWareHouseMoney:SetShow(true)
        self._otherPanel._uiRepairWareHouse:SetShow(true)
      end
    else
      self._otherPanel._uiRepairInvenMoney:SetCheck(true)
      self._otherPanel._uiRepairWareHouseMoney:SetCheck(false)
      self._otherPanel._uiRepairWareHouseMoney:SetShow(false)
      self._otherPanel._uiRepairWareHouse:SetShow(false)
    end
  end
  PaGlobal_RepairFunc_All:update(true)
  PaGlobal_RepairFunc_All:resize()
  if true == self._isConsole then
    self._currentTabIndex = self._funcButtonCount
    PaGlobal_RepairFunc_All_MoveTab(1)
  end
  PaGlobal_RepairFunc_All:open()
end
function PaGlobal_RepairFunc_All:open()
  if nil == Panel_Dialog_Repair_Function_All then
    return
  end
  PaGlobal_RepairFunc_All:resize()
  Panel_Dialog_Repair_Function_All:SetShow(true)
end
function PaGlobal_RepairFunc_All:prepareClose()
  if nil == Panel_Dialog_Repair_Function_All then
    return
  end
  self._eRepairType = nil
  if true == self._isCamping then
    SetUIMode(Defines.UIMode.eUIMode_Default)
  else
    SetUIMode(Defines.UIMode.eUIMode_NpcDialog)
  end
  repair_SetRepairMode(false)
  if false == _ContentsGroup_NewUI_BlackSmith_All then
    PaGlobal_FixEquip:fixEquipExit()
  elseif nil ~= Panel_Window_Endurance_Recovery_All and true == Panel_Window_Endurance_Recovery_All:GetShow() then
    PaGlobal_Endurance_Recovery_All_Close()
  end
  if true == _ContentsGroup_NewUI_NpcShop_All then
    if nil ~= Panel_Dialog_NPCShop_All and false == PaGlobalFunc_NPCShop_ALL_GetShow() then
      PaGlobalFunc_NPCShop_ALL_SetIsCamping(false)
    end
  elseif nil ~= Panel_Window_NpcShop and false == Panel_Window_NpcShop:GetShow() then
    npcShop:setIsCamping(false)
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  if false == _ContentsGroup_RenewUI_InventoryEquip then
    self._otherPanel._uiRepairWareHouseMoney:SetShow(false)
    self._otherPanel._uiRepairWareHouse:SetShow(false)
  end
  InventoryWindow_Close()
  PaGlobal_RepairFunc_All:update(false)
  PaGlobal_RepairFunc_All:close()
  if false == self._isCamping then
    if true == _ContentsGroup_NewUI_Dialog_All then
      PaGlobalFunc_DialogMain_All_SetIgnoreShowDialog(false)
      HandleEventLUp_DialogMain_All_BackClick()
    elseif true == _ContentsGroup_RenewUI_Dailog then
      PaGlobalFunc_MainDialog_setIgnoreShowDialog(false)
    else
      setIgnoreShowDialog(false)
    end
  else
    ToClient_openCampingInfo()
  end
  PaGlobalFunc_RepairFunc_All_SetIsCamping(false)
  if true == _ContentsGroup_NewUI_Camp_All then
    PaGlobal_Camp_All:setIsCamping(false)
  else
    PaGlobal_Camp:setIsCamping(false)
  end
end
function PaGlobal_RepairFunc_All:close()
  if nil == Panel_Dialog_Repair_Function_All then
    return
  end
  Panel_Dialog_Repair_Function_All:SetShow(false)
end
function PaGlobal_RepairFunc_All:update(isShow)
  if nil == Panel_Dialog_Repair_Function_All then
    return
  end
  if not _ContentsGroup_RenewUI_InventoryEquip then
    if true == _ContentsGroup_NewUI_Equipment_All then
      PaGlobalFunc_Equipment_All_DirectPanelShow(isShow, true)
    else
      PaGlobal_Equipment_DirectPanelShow(isShow, true)
    end
    local equipmentPanelShow = false
    if true == _ContentsGroup_NewUI_Equipment_All then
      equipmentPanelShow = Panel_Window_Equipment_All:IsShow()
    else
      equipmentPanelShow = Panel_Equipment:IsShow()
    end
    if not equipmentPanelShow then
      self._otherPanel._uiRepairMessageBG:SetShow(false)
    end
  end
  PaGlobalFunc_RepairFunc_All_MoneyUpdate()
  if true == _ContentsGroup_NewUI_Dialog_All then
    if false == self._isCamping then
      if true == isShow then
        PaGlobalFunc_DialogMain_All_ShowToggle(false)
      else
        PaGlobalFunc_DialogMain_All_ShowToggle(true)
      end
    end
  elseif true == _ContentsGroup_RenewUI_Dailog then
    if true == isShow then
      PaGlobalFunc_MainDialog_Close()
    else
      PaGlobalFunc_MainDialog_ReOpen()
    end
  else
    Panel_Npc_Dialog:SetShow(not isShow)
  end
  if false == _ContentsGroup_RenewUI_InventoryEquip then
    if false == isGameTypeKorea() then
      self._otherPanel._uiRepairMessageBG:SetShow(isShow)
      self._otherPanel._uiRepairInven:SetShow(isShow)
      self._otherPanel._uiRepairInvenMoney:SetShow(isShow)
      if false == _ContentsGroup_RenewUI then
        if true == _ContentsGroup_NewUI_Equipment_All then
          PaGlobalFunc_Equipment_All_SetFunctionButtonHide(not isShow)
        else
          FGlobal_Equipment_SetFunctionButtonHide(not isShow)
        end
      end
      self._otherPanel._repairMessage:SetShow(false)
      self._otherPanel._repairMessageJP:SetShow(true)
      self._otherPanel._repairMessageJP:SetText(PAGetString(Defines.StringSheet_GAME, "REPAIR_SELECTITEM_TEXT"))
    else
      self._otherPanel._uiRepairMessageBG:SetShow(isShow)
      self._otherPanel._uiRepairInven:SetShow(isShow)
      self._otherPanel._uiRepairInvenMoney:SetShow(isShow)
      if false == _ContentsGroup_RenewUI_InventoryEquip then
        if true == _ContentsGroup_NewUI_Equipment_All then
          PaGlobalFunc_Equipment_All_SetFunctionButtonHide(not isShow)
        else
          FGlobal_Equipment_SetFunctionButtonHide(not isShow)
        end
      end
      self._otherPanel._repairMessageJP:SetShow(false)
      self._otherPanel._repairMessage:SetShow(true)
      self._otherPanel._repairMessage:SetText(PAGetString(Defines.StringSheet_GAME, "REPAIR_SELECTITEM_TEXT"))
    end
    PaGlobalFunc_RepairFunc_All_MoneySetPos()
  end
  if true == self._isCamping then
    self._ui.radio_btn[self._BTN_ENUM.HORSE]:SetIgnore(true)
    self._ui.radio_btn[self._BTN_ENUM.SHIP]:SetIgnore(true)
    self._ui.radio_btn[self._BTN_ENUM.GUILD]:SetIgnore(true)
    self._ui.radio_btn[self._BTN_ENUM.MAXENDURANCE]:SetIgnore(true)
    self._ui.radio_btn[self._BTN_ENUM.HORSE]:SetShow(false)
    self._ui.radio_btn[self._BTN_ENUM.SHIP]:SetShow(false)
    self._ui.radio_btn[self._BTN_ENUM.GUILD]:SetShow(false)
    self._ui.radio_btn[self._BTN_ENUM.MAXENDURANCE]:SetShow(false)
  else
    self._ui.radio_btn[self._BTN_ENUM.HORSE]:SetIgnore(false)
    self._ui.radio_btn[self._BTN_ENUM.SHIP]:SetIgnore(false)
    self._ui.radio_btn[self._BTN_ENUM.GUILD]:SetIgnore(false)
    self._ui.radio_btn[self._BTN_ENUM.MAXENDURANCE]:SetIgnore(false)
    self._ui.radio_btn[self._BTN_ENUM.HORSE]:SetShow(true)
    self._ui.radio_btn[self._BTN_ENUM.SHIP]:SetShow(true)
    self._ui.radio_btn[self._BTN_ENUM.MAXENDURANCE]:SetShow(true)
    if true == self._isContentsEnable then
      self._ui.radio_btn[self._BTN_ENUM.GUILD]:SetShow(true)
    else
      self._ui.radio_btn[self._BTN_ENUM.GUILD]:SetShow(false)
    end
  end
  for idx = 1, self._BTN_COUNT do
    self._ui.radio_btn[idx]:SetCheck(false)
  end
end
function PaGlobal_RepairFunc_All:validate()
  if nil == Panel_Dialog_Repair_Function_All then
    return
  end
  self._ui.radio_btn[self._BTN_ENUM.GUILD]:isValidate()
  self._ui.radio_btn[self._BTN_ENUM.SHIP]:isValidate()
  self._ui.radio_btn[self._BTN_ENUM.HORSE]:isValidate()
  self._ui.radio_btn[self._BTN_ENUM.MAXENDURANCE]:isValidate()
  self._ui.radio_btn[self._BTN_ENUM.EQUIPMENT]:isValidate()
  self._ui.radio_btn[self._BTN_ENUM.INVENTORYALL]:isValidate()
  self._ui.radio_btn[self._BTN_ENUM.INVENTORY]:isValidate()
  self._ui.radio_btn[self._BTN_ENUM.EXIT]:isValidate()
  self._ui.stc_selectLine:isValidate()
  self._ui.stc_cursor:isValidate()
  if false == _ContentsGroup_UsePadSnapping then
    self._otherPanel._uiRepairMessageBG:isValidate()
    self._otherPanel._uiRepairInven:isValidate()
    self._otherPanel._uiRepairWareHouse:isValidate()
    self._otherPanel._uiRepairInvenMoney:isValidate()
    self._otherPanel._uiRepairWareHouseMoney:isValidate()
    self._otherPanel._repairMessage:isValidate()
    self._otherPanel._repairMessageJP:isValidate()
  elseif false == _ContentsGroup_RenewUI_InventoryEquip then
    self._otherPanel._uiRepairMessageBG:isValidate()
    self._otherPanel._uiRepairInven:isValidate()
    self._otherPanel._uiRepairWareHouse:isValidate()
    self._otherPanel._uiRepairInvenMoney:isValidate()
    self._otherPanel._uiRepairWareHouseMoney:isValidate()
  end
end
function PaGlobal_RepairFunc_All:not_Enough_Money()
  local messageContent = PAGetString(Defines.StringSheet_GAME, "Lua_TradeMarket_Not_Enough_Money")
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = messageContent,
    functionYes = function()
      return
    end,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_RepairFunc_All:registEventHandler()
  if nil == Panel_Dialog_Repair_Function_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_RepairFunc_All_OnScreenEvent")
  registerEvent("FromClient_MaxEnduranceLuckyRepairEvent", "FromClient_RepairFunc_All_MaxEnduranceLuckyRepairEvent")
  registerEvent("EventWarehouseUpdate", "PaGlobalFunc_RepairFunc_All_MoneyUpdate")
  Panel_Dialog_Repair_Function_All:ActiveMouseEventEffect(true)
  if true == self._isConsole then
    Panel_Dialog_Repair_Function_All:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_RepairFunc_All_MoveTab(-1)")
    Panel_Dialog_Repair_Function_All:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobal_RepairFunc_All_MoveTab(1)")
    Panel_Dialog_Repair_Function_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_RepairFunc_All_SelectCurrentTab()")
  end
  self._ui.radio_btn[self._BTN_ENUM.GUILD]:addInputEvent("Mouse_LUp", "HandleEventLUp_RepairFunc_All_Guild()")
  self._ui.radio_btn[self._BTN_ENUM.SHIP]:addInputEvent("Mouse_LUp", "HandleEventLUp_RepairFunc_All_Ship()")
  self._ui.radio_btn[self._BTN_ENUM.HORSE]:addInputEvent("Mouse_LUp", "HandleEventLUp_RepairFunc_All_Horse()")
  self._ui.radio_btn[self._BTN_ENUM.MAXENDURANCE]:addInputEvent("Mouse_LUp", "HandleEventLUp_RepairFunc_All_MaxEndurance()")
  self._ui.radio_btn[self._BTN_ENUM.EQUIPMENT]:addInputEvent("Mouse_LUp", "HandleEventLUp_RepairFunc_All_Equipment()")
  self._ui.radio_btn[self._BTN_ENUM.INVENTORYALL]:addInputEvent("Mouse_LUp", "HandleEventLUp_RepairFunc_All_Inventory()")
  self._ui.radio_btn[self._BTN_ENUM.INVENTORY]:addInputEvent("Mouse_LUp", "HandleEventLUp_RepairFunc_All_InventoryOpen()")
  self._ui.radio_btn[self._BTN_ENUM.EXIT]:addInputEvent("Mouse_LUp", "PaGlobalFunc_RepairFunc_All_Close()")
end
function PaGlobal_RepairFunc_All:resize()
  if nil == Panel_Dialog_Repair_Function_All then
    return
  end
  local sizeX = getScreenSizeX()
  Panel_Dialog_Repair_Function_All:ComputePos()
  Panel_Dialog_Repair_Function_All:SetSize(sizeX, Panel_Dialog_Repair_Function_All:GetSizeY())
  Panel_LuckyRepair_Result:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_LuckyRepair_Result:SetPosX(0)
  Panel_LuckyRepair_Result:SetPosY(0)
  Panel_LuckyRepair_Result:SetColor(Defines.Color.C_00FFFFFF)
  Panel_LuckyRepair_Result:SetIgnore(true)
  self._luckyRepairMSG.MSGBG:SetSize(getScreenSizeX() + 40, 90)
  self._luckyRepairMSG.MSGBG:SetPosX(-20)
  self._luckyRepairMSG.MSGBG:ComputePos()
  self._luckyRepairMSG.MSG:SetSize(getScreenSizeX(), 90)
  self._luckyRepairMSG.MSG:ComputePos()
  self._luckyRepairMSG.MSGBG:ResetVertexAni()
  self._luckyRepairMSG.MSGBG:SetVertexAniRun("Ani_Scale_0", true)
  local showCount = 0
  local btnTable = {}
  local funcTable = {}
  if true == self._ui.radio_btn[self._BTN_ENUM.GUILD]:GetShow() then
    btnTable[showCount] = self._ui.radio_btn[self._BTN_ENUM.GUILD]
    funcTable[showCount] = HandleEventLUp_RepairFunc_All_Guild
    showCount = showCount + 1
  end
  if true == self._ui.radio_btn[self._BTN_ENUM.SHIP]:GetShow() then
    btnTable[showCount] = self._ui.radio_btn[self._BTN_ENUM.SHIP]
    funcTable[showCount] = HandleEventLUp_RepairFunc_All_Ship
    showCount = showCount + 1
  end
  if true == self._ui.radio_btn[self._BTN_ENUM.HORSE]:GetShow() then
    btnTable[showCount] = self._ui.radio_btn[self._BTN_ENUM.HORSE]
    funcTable[showCount] = HandleEventLUp_RepairFunc_All_Horse
    showCount = showCount + 1
  end
  if true == self._ui.radio_btn[self._BTN_ENUM.MAXENDURANCE]:GetShow() then
    btnTable[showCount] = self._ui.radio_btn[self._BTN_ENUM.MAXENDURANCE]
    funcTable[showCount] = HandleEventLUp_RepairFunc_All_MaxEndurance
    showCount = showCount + 1
  end
  if true == self._ui.radio_btn[self._BTN_ENUM.EQUIPMENT]:GetShow() then
    btnTable[showCount] = self._ui.radio_btn[self._BTN_ENUM.EQUIPMENT]
    funcTable[showCount] = HandleEventLUp_RepairFunc_All_Equipment
    showCount = showCount + 1
  end
  if true == self._ui.radio_btn[self._BTN_ENUM.INVENTORYALL]:GetShow() then
    btnTable[showCount] = self._ui.radio_btn[self._BTN_ENUM.INVENTORYALL]
    funcTable[showCount] = HandleEventLUp_RepairFunc_All_Inventory
    showCount = showCount + 1
  end
  if true == self._ui.radio_btn[self._BTN_ENUM.INVENTORY]:GetShow() then
    btnTable[showCount] = self._ui.radio_btn[self._BTN_ENUM.INVENTORY]
    funcTable[showCount] = HandleEventLUp_RepairFunc_All_InventoryOpen
    showCount = showCount + 1
  end
  if true == self._ui.radio_btn[self._BTN_ENUM.EXIT]:GetShow() then
    btnTable[showCount] = self._ui.radio_btn[self._BTN_ENUM.EXIT]
    funcTable[showCount] = PaGlobalFunc_RepairFunc_All_Close
    showCount = showCount + 1
  end
  self._funcButtonCount = showCount
  self._btnTable = btnTable
  self._funcTable = funcTable
  local funcButtonCount = showCount
  local buttonSize = self._ui.radio_btn[1]:GetSizeX()
  local startPosX = (sizeX - (buttonSize * funcButtonCount + (funcButtonCount - 1))) / 2
  local posX = 0
  local btnIdx = 0
  for idx = 1, self._BTN_COUNT do
    if true == self._ui.radio_btn[idx]:GetShow() then
      posX = startPosX + buttonSize * btnIdx
      btnIdx = btnIdx + 1
    end
    self._ui.radio_btn[idx]:SetPosX(posX)
  end
  if true == self._isConsole then
    local gap = 20
    self._ui_console.stc_iconLB:SetPosX(btnTable[0]:GetPosX() - self._ui_console.stc_iconLB:GetSizeX() - gap)
    self._ui_console.stc_iconRB:SetPosX(btnTable[showCount - 1]:GetPosX() + btnTable[showCount - 1]:GetSizeX() + gap)
  end
end
