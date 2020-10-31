local IM = CppEnums.EProcessorInputMode
function PaGlobal_FairyRegister_All:initialize()
  if true == PaGlobal_FairyRegister_All._initialize then
    return
  end
  self._ui.stc_TitleBG = UI.getChildControl(Panel_Window_FairyRegister_All, "Static_TitleBG")
  self._ui_pc.btn_Close_pc = UI.getChildControl(self._ui.stc_TitleBG, "Button_CloseButton_PC")
  self._ui.stc_RegisterBG = UI.getChildControl(Panel_Window_FairyRegister_All, "Static_PetRegisterBG")
  self._ui.stc_IconBack = UI.getChildControl(self._ui.stc_RegisterBG, "Static_IconBack")
  self._ui.txt_StaticIconText = UI.getChildControl(self._ui.stc_IconBack, "StaticText_Icon_Title")
  self._ui.stc_NamingPolicyBG = UI.getChildControl(Panel_Window_FairyRegister_All, "Static_NamingPolicyBG")
  self._ui.txt_NamingPolicyDesc = UI.getChildControl(self._ui.stc_NamingPolicyBG, "StaticText_NamingPolicy")
  self._ui.stc_CenterBG = UI.getChildControl(Panel_Window_FairyRegister_All, "Static_PetRegisterBG")
  self._ui.edit_Name = UI.getChildControl(self._ui.stc_CenterBG, "Edit_Naming")
  self._ui_console.stc_KeyGuide_X = UI.getChildControl(self._ui.edit_Name, "Static_KeyX_Console")
  self._ui.stc_PetIconBG = UI.getChildControl(self._ui.stc_CenterBG, "Static_IconBack")
  self._ui.stc_PetIcon = UI.getChildControl(self._ui.stc_PetIconBG, "Static_Icon")
  self._ui.txt_Desc = UI.getChildControl(self._ui.stc_CenterBG, "StaticText_Description")
  self._ui.stc_BottomButtonBG = UI.getChildControl(Panel_Window_FairyRegister_All, "Static_ButtonGroup")
  self._ui_pc.btn_Yes_pc = UI.getChildControl(self._ui.stc_BottomButtonBG, "Button_Yes")
  self._ui_pc.btn_No_pc = UI.getChildControl(self._ui.stc_BottomButtonBG, "Button_No")
  self._ui.stc_BottomKeyGuide = UI.getChildControl(Panel_Window_FairyRegister_All, "Static_KeyGuide_Console")
  self._ui_console.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_BottomKeyGuide, "StaticText_Select_Console")
  self._ui_console.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_BottomKeyGuide, "StaticText_Exit_Console")
  self._ui.edit_Name:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_EDITBOX_COMMENT"), true)
  if _ContentsGroup_RenewUI then
    self._ui.txt_NamingPolicyDesc:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_NamingPolicyDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHANGENAME_CONSOLE_TEXTBIND"))
    self._ui.stc_NamingPolicyBG:SetShow(true)
  else
    self._ui.stc_NamingPolicyBG:SetShow(false)
  end
  self._ui.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  local defaultDesc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_FAIRYREGISTER_DESC_PARAM", "min", tostring(getGameServiceTypeNameMinLength()), "max", tostring(getGameServiceTypePetNameLength()))
  if isGameTypeRussia() then
    local russiaDesc = PAGetString(Defines.StringSheet_GAME, "LUA_RUS_CREATENAME_RULE")
    defaultDesc = defaultDesc .. "\n\226\128\187 " .. russiaDesc
  end
  self._ui.txt_Desc:SetText(defaultDesc)
  PaGlobal_FairyRegister_All:SetUiSetting()
  local keyGuides = {
    self._ui_console.stc_KeyGuide_A,
    self._ui_console.stc_KeyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_BottomKeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  PaGlobal_FairyRegister_All:registEventHandler()
  PaGlobal_FairyRegister_All:validate()
  PaGlobal_FairyRegister_All._initialize = true
end
function PaGlobal_FairyRegister_All:SetUiSetting()
  if nil == Panel_Window_FairyRegister_All then
    return
  end
  for _, value in pairs(self._ui_pc) do
    value:SetShow(not _ContentsGroup_UsePadSnapping)
  end
  for _, value in pairs(self._ui_console) do
    value:SetShow(_ContentsGroup_UsePadSnapping)
  end
  self._ui.txt_Desc:SetSize(self._ui.stc_CenterBG:GetSizeX(), self._ui.txt_Desc:GetTextSizeY())
  self._ui.stc_CenterBG:SetSize(self._ui.stc_CenterBG:GetSizeX(), self._ui.edit_Name:GetSizeY() + self._ui.txt_Desc:GetSizeY() + 80)
  Panel_Window_FairyRegister_All:SetSize(Panel_Window_FairyRegister_All:GetSizeX(), self._ui.stc_TitleBG:GetSizeY() + self._ui.stc_CenterBG:GetSizeY() + self._ui.stc_BottomButtonBG:GetSizeY())
  self._ui.stc_BottomButtonBG:SetPosY(self._ui.stc_CenterBG:GetPosY() + self._ui.stc_CenterBG:GetSizeY())
  self._ui.stc_BottomKeyGuide:SetPosY(self._ui.stc_BottomButtonBG:GetPosY() + self._ui.stc_BottomButtonBG:GetSizeY())
end
function PaGlobal_FairyRegister_All:registEventHandler()
  if nil == Panel_Window_FairyRegister_All then
    return
  end
  if false == _ContentsGroup_UsePadSnapping then
    self._ui_pc.btn_Yes_pc:addInputEvent("Mouse_LUp", "InputMLUp_FairyRegister_RegisterName_All()")
    self._ui_pc.btn_No_pc:addInputEvent("Mouse_LUp", "PaGlobal_FairyRegister_Close_All()")
    self._ui.edit_Name:addInputEvent("Mouse_LUp", "InputMLUp_FairyRegister_SetFocus_All()")
    self._ui.edit_Name:RegistReturnKeyEvent("InputMLUp_FairyRegister_RegisterName_All()")
  else
    Panel_Window_FairyRegister_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "InputMLUp_FairyRegister_RegisterName_All()")
    Panel_Window_FairyRegister_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "InputMLUp_FairyRegister_SetFocus_All()")
    self._ui.edit_Name:setXboxVirtualKeyBoardEndEvent("InputMLUp_FairyRegister_RegisterName_All")
  end
  registerEvent("FromClient_PetAddSealedList", "FromClient_PetAddSealedList")
end
function PaGlobal_FairyRegister_All:prepareOpen(fromWhereType, fromSlotNo)
  if nil == Panel_Window_FairyRegister_All then
    return
  end
  self._ui.txt_StaticIconText:SetShow(false)
  self.tempFromWhereType = fromWhereType
  self.tempFromSlotNo = fromSlotNo
  local itemWrapper = getInventoryItemByType(fromWhereType, fromSlotNo)
  if nil == itemWrapper then
    return
  end
  local characterKey = itemWrapper:getStaticStatus():get()._contentsEventParam1
  local petRegisterPSS = ToClient_getPetStaticStatus(characterKey)
  local petIconPath = petRegisterPSS:getIconPath()
  self._ui.stc_PetIcon:ChangeTextureInfoName(petIconPath)
  self._ui.edit_Name:SetEditText("", true)
  self._ui.edit_Name:SetMaxInput(getGameServiceTypePetNameLength())
  PaGlobal_FairyRegister_All:open()
end
function PaGlobal_FairyRegister_All:open()
  if nil == Panel_Window_FairyRegister_All then
    return
  end
  Panel_Window_FairyRegister_All:SetShow(true)
end
function PaGlobal_FairyRegister_All:prepareClose()
  if nil == Panel_Window_FairyRegister_All then
    return
  end
  ClearFocusEdit()
  PaGlobal_FairyRegister_All:close()
end
function PaGlobal_FairyRegister_All:close()
  if nil == Panel_Window_FairyRegister_All then
    return
  end
  Panel_Window_FairyRegister_All:SetShow(false)
end
function PaGlobal_FairyRegister_All:validate()
  if nil == Panel_Window_FairyRegister_All then
    return
  end
  self._ui.stc_TitleBG:isValidate()
  self._ui_pc.btn_Close_pc:isValidate()
  self._ui.stc_NamingPolicyBG:isValidate()
  self._ui.txt_NamingPolicyDesc:isValidate()
  self._ui.stc_CenterBG:isValidate()
  self._ui.edit_Name:isValidate()
  self._ui_console.stc_KeyGuide_X:isValidate()
  self._ui.stc_PetIconBG:isValidate()
  self._ui.stc_PetIcon:isValidate()
  self._ui.txt_Desc:isValidate()
  self._ui.stc_BottomButtonBG:isValidate()
  self._ui_pc.btn_Yes_pc:isValidate()
  self._ui_pc.btn_No_pc:isValidate()
  self._ui.stc_BottomKeyGuide:isValidate()
  self._ui_console.stc_KeyGuide_A:isValidate()
  self._ui_console.stc_KeyGuide_B:isValidate()
end
function PaGlobal_FairyRegister_All:setFocus()
  if nil == Panel_Window_FairyRegister_All then
    return
  end
  SetFocusEdit(self._ui.edit_Name)
end
function PaGlobal_FairyRegister_All:registerName(str)
  if nil == Panel_Window_FairyRegister_All then
    return
  end
  ClearFocusEdit()
  if nil ~= str then
    self._ui.edit_Name:SetEditText(str, true)
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYREGISTER_WARNING_TITLE")
  local _contenet = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYREGISTER_WARNING_CONTENTS")
  local messageBoxData = {
    title = _title,
    content = _contenet,
    functionYes = PaGlobal_FairyRegister_RegisterYes_All,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_FairyRegister_All:registerNameConfirm()
  if nil == Panel_Window_FairyRegister_All then
    return
  end
  local fromWhereType = PaGlobal_FairyRegister_All.tempFromWhereType
  local fromSlotNo = PaGlobal_FairyRegister_All.tempFromSlotNo
  local petName = PaGlobal_FairyRegister_All._ui.edit_Name:GetEditText()
  ToClient_requestPetRegister(petName, fromWhereType, fromSlotNo)
  self:prepareClose()
end
