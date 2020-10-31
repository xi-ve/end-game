function PaGlobal_FairyChoiceTheReset_All:initialize()
  if true == PaGlobal_FairyChoiceTheReset_All._initialize then
    return
  end
  self._ui.stc_TitleBG = UI.getChildControl(Panel_Window_FairyChoiceTheReset_All, "Static_TitleBG")
  self._ui_pc.btn_Close_pc = UI.getChildControl(self._ui.stc_TitleBG, "Button_Close_PC")
  self._ui.stc_MainBG = UI.getChildControl(Panel_Window_FairyChoiceTheReset_All, "Static_InsideBg")
  self._ui.rdo_Skill = UI.getChildControl(self._ui.stc_MainBG, "RadioButton_Skill")
  self._ui.rdo_Voice = UI.getChildControl(self._ui.stc_MainBG, "RadioButton_Voice")
  self._ui.stc_BottomButtonBG = UI.getChildControl(Panel_Window_FairyChoiceTheReset_All, "StaticText_ButtonGroup_PC")
  self._ui_pc.btn_Select_pc = UI.getChildControl(self._ui.stc_BottomButtonBG, "Button_Select")
  self._ui_pc.btn_Cancel_pc = UI.getChildControl(self._ui.stc_BottomButtonBG, "Button_Cancel")
  self._ui.stc_BottomKeyGuide = UI.getChildControl(Panel_Window_FairyChoiceTheReset_All, "Static_KeyGuide_Console")
  self._ui_console.stc_KeyGuide_Y = UI.getChildControl(self._ui.stc_BottomKeyGuide, "StaticText_Confirm_Console")
  self._ui_console.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_BottomKeyGuide, "StaticText_Select_Console")
  self._ui_console.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_BottomKeyGuide, "StaticText_Exit_Console")
  self._keyguide = {
    self._ui_console.stc_KeyGuide_A,
    self._ui_console.stc_KeyGuide_B
  }
  PaGlobal_FairyChoiceTheReset_All:SetUiSetting()
  PaGlobal_FairyChoiceTheReset_All:AlignKeyGuide()
  PaGlobal_FairyChoiceTheReset_All:registEventHandler()
  PaGlobal_FairyChoiceTheReset_All:validate()
  PaGlobal_FairyChoiceTheReset_All._initialize = true
end
function PaGlobal_FairyChoiceTheReset_All:SetUiSetting()
  if nil == Panel_Window_FairyChoiceTheReset_All then
    return
  end
  for _, value in pairs(self._ui_pc) do
    value:SetShow(not _ContentsGroup_UsePadSnapping)
  end
  for _, value in pairs(self._ui_console) do
    value:SetShow(_ContentsGroup_UsePadSnapping)
  end
  self._ui.stc_BottomButtonBG:SetShow(not _ContentsGroup_UsePadSnapping)
  self._ui.stc_BottomKeyGuide:SetShow(_ContentsGroup_UsePadSnapping)
  self._ui.rdo_Skill:SetPosX(self._ui.stc_MainBG:GetSizeX() - (self._ui.stc_MainBG:GetSizeX() / 2 + self._ui.rdo_Skill:GetSizeX() + self._ui.rdo_Skill:GetTextSizeX() / 2))
  self._ui.rdo_Voice:SetPosX(self._ui.stc_MainBG:GetSizeX() - (self._ui.stc_MainBG:GetSizeX() / 2 + self._ui.rdo_Voice:GetSizeX() + self._ui.rdo_Voice:GetTextSizeX() / 2))
  self._ui.rdo_Skill:SetEnableArea(0, 0, self._ui.rdo_Skill:GetSizeX() + self._ui.rdo_Skill:GetTextSizeX(), 25)
  self._ui.rdo_Voice:SetEnableArea(0, 0, self._ui.rdo_Voice:GetSizeX() + self._ui.rdo_Voice:GetTextSizeX(), 25)
end
function PaGlobal_FairyChoiceTheReset_All:AlignKeyGuide()
  if nil == Panel_Window_FairyChoiceTheReset_All or false == _ContentsGroup_UsePadSnapping then
    return
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign({
    self._ui_console.stc_KeyGuide_Y
  }, Panel_Window_FairyChoiceTheReset_All, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_CENTER)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyguide, self._ui.stc_BottomKeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_FairyChoiceTheReset_All:registEventHandler()
  if nil == Panel_Window_FairyChoiceTheReset_All then
    return
  end
  self._ui_pc.btn_Close_pc:addInputEvent("Mouse_LUp", "PaGlobal_FairyChoiceTheReset_Close_All()")
  self._ui_pc.btn_Cancel_pc:addInputEvent("Mouse_LUp", "PaGlobal_FairyChoiceTheReset_Close_All()")
  self._ui_pc.btn_Select_pc:addInputEvent("Mouse_LUp", "InputMLClick_FairyChoiceTheReset_RequestRebirth()")
  self._ui.rdo_Skill:addInputEvent("Mouse_On", "InputMOn_FairyChoiceTheReset_ShowTooltip_All(true, 0)")
  self._ui.rdo_Skill:addInputEvent("Mouse_Out", "InputMOn_FairyChoiceTheReset_ShowTooltip_All(false)")
  self._ui.rdo_Voice:addInputEvent("Mouse_On", "InputMOn_FairyChoiceTheReset_ShowTooltip_All(true, 1)")
  self._ui.rdo_Voice:addInputEvent("Mouse_Out", "InputMOn_FairyChoiceTheReset_ShowTooltip_All(false)")
  Panel_Window_FairyChoiceTheReset_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "InputMLClick_FairyChoiceTheReset_RequestRebirth()")
end
function PaGlobal_FairyChoiceTheReset_All:clear()
  if nil == Panel_Window_FairyChoiceTheReset_All then
    return
  end
  self._isClearSkill = true
  self._fairyAttr = false
  self._ui.rdo_Skill:SetCheck(true)
  self._ui.rdo_Voice:SetCheck(false)
end
function PaGlobal_FairyChoiceTheReset_All:prepareOpen()
  if nil == Panel_Window_FairyChoiceTheReset_All then
    return
  end
  if PaGlobal_FairyInfo_isUnseal_All() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNeedSealFairy"))
    return
  end
  PaGlobal_FairyPanel_ALL_Close()
  self:clear()
  self:update()
  self:open()
end
function PaGlobal_FairyChoiceTheReset_All:open()
  if nil == Panel_Window_FairyChoiceTheReset_All then
    return
  end
  Panel_Window_FairyChoiceTheReset_All:SetShow(true)
end
function PaGlobal_FairyChoiceTheReset_All:prepareClose()
  if nil == Panel_Window_FairyChoiceTheReset_All then
    return
  end
  PaGlobal_FairyChoiceTheReset_All:close()
end
function PaGlobal_FairyChoiceTheReset_All:close()
  if nil == Panel_Window_FairyChoiceTheReset_All then
    return
  end
  Panel_Window_FairyChoiceTheReset_All:SetShow(false)
end
function PaGlobal_FairyChoiceTheReset_All:update()
  if nil == Panel_Window_FairyChoiceTheReset_All then
    return
  end
  self:clear()
  self._fairyNo = PaGlobal_FairyInfo_GetFairyNo_All()
end
function PaGlobal_FairyChoiceTheReset_All:validate()
  if nil == Panel_Window_FairyChoiceTheReset_All then
    return
  end
  self._ui.stc_TitleBG:isValidate()
  self._ui_pc.btn_Close_pc:isValidate()
  self._ui.stc_MainBG:isValidate()
  self._ui.rdo_Skill:isValidate()
  self._ui.rdo_Voice:isValidate()
  self._ui.stc_BottomButtonBG:isValidate()
  self._ui_pc.btn_Select_pc:isValidate()
  self._ui_pc.btn_Cancel_pc:isValidate()
  self._ui.stc_BottomKeyGuide:isValidate()
  self._ui_console.stc_KeyGuide_Y:isValidate()
  self._ui_console.stc_KeyGuide_A:isValidate()
  self._ui_console.stc_KeyGuide_B:isValidate()
end
function PaGlobal_FairyChoiceTheReset_All:SimpleTooltip(isShow, idx)
  if nil == Panel_Window_FairyChoiceTheReset_All then
    return
  end
  local name, desc, uiControl
  if 0 == idx then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_RESET_NAME1")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_RESET_DESC1")
    uiControl = self._ui.rdo_Skill
  elseif 1 == idx then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_RESET_NAME2")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_RESET_DESC2")
    uiControl = self._ui.rdo_Voice
  end
  if isShow == true then
    if false == _ContentsGroup_RenewUI then
      TooltipSimple_Show(uiControl, name, desc)
    else
      local pos = {}
      pos.x = Panel_Window_FairyChoiceTheReset_All:GetPosX() + Panel_Window_FairyChoiceTheReset_All:GetSizeX() + 5
      pos.y = Panel_Window_FairyChoiceTheReset_All:GetPosY() + self._ui.stc_MainBG:GetPosY() + uiControl:GetPosY()
      TooltipSimple_ShowSetSetPos_Console(pos, name, desc)
    end
  else
    TooltipSimple_Hide()
  end
end
function PaGlobal_FairyChoiceTheReset_All:RequestRebirth()
  if nil == Panel_Window_FairyChoiceTheReset_All then
    return
  end
  self._isClearSkill = self._ui.rdo_Skill:IsChecked()
  self._fairyAttr = self._ui.rdo_Voice:IsChecked()
  local FunctionYes = function()
    local self = PaGlobal_FairyChoiceTheReset_All
    if nil == self._fairyNo then
      return
    end
    if PaGlobal_FairyInfo_GetLevel_All() < 10 and true == self._isClearSkill then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrCantRebirthLessLevel"))
      return
    end
    ToClient_FairyRebirth(self._fairyNo, self._isClearSkill, self._fairyAttr)
    self:prepareClose()
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING")
  local _contenet = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_REBIRTH_ALERT")
  if true == self._fairyAttr then
    _contenet = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_REBIRTH_ALERT_CHANGE_VOICE")
  end
  local messageBoxData = {
    title = _title,
    content = _contenet,
    functionYes = FunctionYes,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
