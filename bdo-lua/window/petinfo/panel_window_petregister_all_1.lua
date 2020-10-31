function PaGlobal_PetRegister_All:initialize()
  if true == PaGlobal_PetRegister_All._initialize then
    return
  end
  self._ui.stc_TitleBG = UI.getChildControl(Panel_Window_PetRegister_All, "Static_TitleBG")
  self._ui_pc.btn_Close = UI.getChildControl(self._ui.stc_TitleBG, "Button_CloseButton_PC")
  self._ui.stc_CenterBG = UI.getChildControl(Panel_Window_PetRegister_All, "Static_PetRegisterBG")
  self._ui.edit_Name = UI.getChildControl(self._ui.stc_CenterBG, "Edit_Naming")
  self._ui_console.txt_KeyGuideX = UI.getChildControl(self._ui.edit_Name, "Static_KeyX_Console")
  self._ui.stc_PetIconBG = UI.getChildControl(self._ui.stc_CenterBG, "Static_IconBack")
  self._ui.stc_PetIcon = UI.getChildControl(self._ui.stc_PetIconBG, "Static_Icon")
  self._ui.txt_RegistDesc = UI.getChildControl(self._ui.stc_CenterBG, "StaticText_Description")
  self._ui.stc_NamingPolicyBG = UI.getChildControl(Panel_Window_PetRegister_All, "Static_NamingPolicyBG")
  self._ui.txt_NamingPolicy = UI.getChildControl(self._ui.stc_NamingPolicyBG, "StaticText_NamingPolicy")
  self._ui_pc.stc_ButtonGroup = UI.getChildControl(Panel_Window_PetRegister_All, "Static_ButtonGroup")
  self._ui_pc.btn_Confirm = UI.getChildControl(self._ui_pc.stc_ButtonGroup, "Button_Yes")
  self._ui_pc.btn_Cancel = UI.getChildControl(self._ui_pc.stc_ButtonGroup, "Button_No")
  self._ui_console.stc_KeyGuideGroup = UI.getChildControl(Panel_Window_PetRegister_All, "Static_KeyGuide_Console")
  self._ui_console.txt_KeyGuideA = UI.getChildControl(self._ui_console.stc_KeyGuideGroup, "StaticText_Select_Console")
  self._ui_console.txt_KeyGuideB = UI.getChildControl(self._ui_console.stc_KeyGuideGroup, "StaticText_Exit_Console")
  self._isConsole = _ContentsGroup_UsePadSnapping
  local defaultDesc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_PETREGISTER_DESC_PARAM", "min", tostring(getGameServiceTypeNameMinLength()), "max", tostring(getGameServiceTypePetNameLength()))
  if isGameTypeRussia() then
    local russiaDesc = PAGetString(Defines.StringSheet_GAME, "LUA_RUS_CREATENAME_RULE")
    defaultDesc = defaultDesc .. "\n\226\128\187 " .. russiaDesc
  end
  self._ui.txt_RegistDesc:SetText(defaultDesc)
  self._ui.edit_Name:SetMaxInput(getGameServiceTypePetNameLength())
  PaGlobal_PetRegister_All:platformSetting()
  PaGlobal_PetRegister_All:resize()
  PaGlobal_PetRegister_All:registEventHandler()
  PaGlobal_PetRegister_All:validate()
  PaGlobal_PetRegister_All._initialize = true
end
function PaGlobal_PetRegister_All:platformSetting()
  if nil == Panel_Window_PetRegister_All then
    return
  end
  for _, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
  for _, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
  if self._isConsole then
    local keyGuides = {
      self._ui_console.txt_KeyGuideA,
      self._ui_console.txt_KeyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.stc_KeyGuideGroup, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
    Panel_Window_PetRegister_All:ignorePadSnapMoveToOtherPanel()
  end
end
function PaGlobal_PetRegister_All:resize()
  if nil == Panel_Window_PetRegister_All then
    return
  end
  local resType = getGameServiceResType()
  if true == _ContentsGroup_RenewUI then
    self._ui.txt_NamingPolicy:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_NamingPolicy:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHANGENAME_CONSOLE_TEXTBIND"))
    self._ui.stc_NamingPolicyBG:SetShow(true)
  else
    self._ui.stc_NamingPolicyBG:SetShow(false)
  end
  local totalNampingPolicySizeY = self._ui.txt_NamingPolicy:GetTextSizeY() + self._ui.txt_NamingPolicy:GetPosY()
  if totalNampingPolicySizeY > self._ui.stc_NamingPolicyBG:GetSizeY() then
    self._ui.stc_NamingPolicyBG:SetSize(self._ui.stc_NamingPolicyBG:GetSizeX(), totalNampingPolicySizeY + 10)
    self._ui.stc_NamingPolicyBG:ComputePos()
  end
  self._ui.txt_RegistDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_RegistDesc:SetText(self._ui.txt_RegistDesc:GetText())
  local totalDescSizeY = self._ui.txt_RegistDesc:GetTextSizeY() + self._ui.txt_RegistDesc:GetPosY()
  if totalDescSizeY > self._ui.stc_CenterBG:GetSizeY() then
    local addSize = totalDescSizeY - self._ui.stc_CenterBG:GetSizeY() + 10
    self._ui.stc_CenterBG:SetSize(self._ui.stc_CenterBG:GetSizeX(), self._ui.stc_CenterBG:GetSizeY() + addSize)
    Panel_Window_PetRegister_All:SetSize(Panel_Window_PetRegister_All:GetSizeX(), Panel_Window_PetRegister_All:GetSizeY() + addSize)
    Panel_Window_PetRegister_All:ComputePos()
    self._ui_pc.stc_ButtonGroup:ComputePos()
    self._ui_console.stc_KeyGuideGroup:ComputePos()
  end
end
function PaGlobal_PetRegister_All:registEventHandler()
  if nil == Panel_Window_PetRegister_All then
    return
  end
  registerEvent("FromClient_InputPetName", "FromClient_InputPetName_All")
  registerEvent("FromClient_PetAddSealedList", "FromClient_PetAddSealedList")
  registerEvent("onScreenResize", "FromClient_PetAddSealedList")
  if self._isConsole then
    Panel_Window_PetRegister_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_PetRegister_Register_All()")
    Panel_Window_PetRegister_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_PetRegister_ClearEdit_All()")
    self._ui.edit_Name:setXboxVirtualKeyBoardEndEvent("Input_PetRegister_KeyboardEnd_All")
  else
    self._ui_pc.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_PetRegister_All_Close()")
    self._ui_pc.btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobal_PetRegister_All_Close()")
    self._ui_pc.btn_Confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_PetRegister_Register_All()")
    self._ui.edit_Name:addInputEvent("Mouse_LUp", "HandleEventLUp_PetRegister_ClearEdit_All()")
    self._ui.edit_Name:RegistReturnKeyEvent("HandleEventLUp_PetRegister_Register_All()")
  end
end
function PaGlobal_PetRegister_All:prepareOpen()
  if nil == Panel_Window_PetRegister_All then
    return
  end
  if self._isConsole then
    if true == Panel_Window_PetRegister_All:GetShow() then
      self:prepareClose()
      return
    end
    PaGlobalFunc_InventoryInfo_Close()
  end
  PaGlobal_PetRegister_All:open()
end
function PaGlobal_PetRegister_All:open()
  if nil == Panel_Window_PetRegister_All then
    return
  end
  Panel_Window_PetRegister_All:SetShow(true)
end
function PaGlobal_PetRegister_All:prepareClose()
  if nil == Panel_Window_PetRegister_All then
    return
  end
  ClearFocusEdit()
  PaGlobal_PetRegister_All:close()
end
function PaGlobal_PetRegister_All:close()
  if nil == Panel_Window_PetRegister_All then
    return
  end
  Panel_Window_PetRegister_All:SetShow(false)
end
function PaGlobal_PetRegister_All:validate()
  if nil == Panel_Window_PetRegister_All then
    return
  end
  self._ui.stc_TitleBG:isValidate()
  self._ui_pc.btn_Close:isValidate()
  self._ui.stc_CenterBG:isValidate()
  self._ui.edit_Name:isValidate()
  self._ui_console.txt_KeyGuideX:isValidate()
  self._ui.stc_PetIconBG:isValidate()
  self._ui.stc_PetIcon:isValidate()
  self._ui.txt_RegistDesc:isValidate()
  self._ui.stc_NamingPolicyBG:isValidate()
  self._ui.txt_NamingPolicy:isValidate()
  self._ui_pc.stc_ButtonGroup:isValidate()
  self._ui_pc.btn_Confirm:isValidate()
  self._ui_pc.btn_Cancel:isValidate()
  self._ui_console.stc_KeyGuideGroup:isValidate()
  self._ui_console.txt_KeyGuideA:isValidate()
  self._ui_console.txt_KeyGuideB:isValidate()
end
function PaGlobal_PetRegister_All:inputPetName(fromWhereType, fromSlotNo)
  if nil == Panel_Window_PetRegister_All then
    return
  end
  self._fromWhereType = fromWhereType
  self._fromSlotNo = fromSlotNo
  local itemWrapper = getInventoryItemByType(fromWhereType, fromSlotNo)
  if nil == itemWrapper then
    return
  end
  local characterKey = itemWrapper:getStaticStatus():get()._contentsEventParam1
  local petRegisterPSS = ToClient_getPetStaticStatus(characterKey)
  local petIconPath = petRegisterPSS:getIconPath()
  self._ui.stc_PetIcon:ChangeTextureInfoNameAsync(petIconPath)
  if self._isConsole then
    local randomIndex = math.floor(math.random(0, self._config._defaultPetNameCount - 1))
    self._ui.edit_Name:SetEditText(self._config._defaultPetName[randomIndex], true)
  else
    self._ui.edit_Name:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_EDITBOX_COMMENT"), true)
  end
  self:prepareOpen()
end
function PaGlobal_PetRegister_All:clearEdit()
  if nil == Panel_Window_PetRegister_All then
    return
  end
  self._ui.edit_Name:SetEditText("", false)
  SetFocusEdit(self._ui.edit_Name)
end
function PaGlobal_PetRegister_All:registPet()
  if nil == Panel_Window_PetRegister_All then
    return
  end
  ClearFocusEdit()
  local petName = self._ui.edit_Name:GetEditText()
  local function confirm_Regist()
    local fromWhereType = PaGlobal_PetRegister_All._fromWhereType
    local fromSlotNo = PaGlobal_PetRegister_All._fromSlotNo
    ToClient_requestPetRegister(petName, fromWhereType, fromSlotNo)
    PaGlobal_PetRegister_All:prepareClose()
  end
  local cancle_Regist = function()
    PaGlobal_PetRegister_All:open()
  end
  PaGlobal_PetRegister_All:prepareClose()
  local messageBoxMemo = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_REGISTPET_CONTINUE")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PET_FUNCTION_REGISTERPET"),
    content = messageBoxMemo,
    functionYes = confirm_Regist,
    functionNo = cancle_Regist,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
