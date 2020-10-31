PaGlobal_EnchantStackConfirm_All = {
  _ui = {
    stc_blockBg = nil,
    stc_bg = nil,
    btn_EnchantGo = nil,
    btn_Close = nil,
    txt_Desc = nil,
    edit_inputMyStack = nil,
    stc_KeyGuide_X = nil,
    stc_Bottom_KeyGuide = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil
  },
  _initilize = false,
  _isConsole = false,
  _enchantInfo = nil,
  _totalStack = nil,
  _MAXINPUT = 5,
  _NUMBER_KEYCODE = {
    CppEnums.VirtualKeyCode.KeyCode_0,
    CppEnums.VirtualKeyCode.KeyCode_1,
    CppEnums.VirtualKeyCode.KeyCode_2,
    CppEnums.VirtualKeyCode.KeyCode_3,
    CppEnums.VirtualKeyCode.KeyCode_4,
    CppEnums.VirtualKeyCode.KeyCode_5,
    CppEnums.VirtualKeyCode.KeyCode_6,
    CppEnums.VirtualKeyCode.KeyCode_7,
    CppEnums.VirtualKeyCode.KeyCode_8,
    CppEnums.VirtualKeyCode.KeyCode_9,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD0,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD1,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD2,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD3,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD4,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD5,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD6,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD7,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD8,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD9
  }
}
registerEvent("FromClient_luaLoadComplete", "FromClient_EnchantStackConfirm_All")
function FromClient_EnchantStackConfirm_All()
  PaGlobal_EnchantStackConfirm_All:initialize()
end
function PaGlobal_EnchantStackConfirm_All:initialize()
  if true == PaGlobal_EnchantStackConfirm_All._initilize then
    return
  end
  self._ui.stc_blockBg = UI.getChildControl(Panel_Window_EnchantStackConfirm_All, "Static_BlockBG")
  self._ui.stc_bg = UI.getChildControl(Panel_Window_EnchantStackConfirm_All, "Static_Bg")
  self._ui.btn_EnchantGo = UI.getChildControl(Panel_Window_EnchantStackConfirm_All, "Button_EnchantGoGo")
  self._ui.btn_Close = UI.getChildControl(Panel_Window_EnchantStackConfirm_All, "Button_Close")
  self._ui.txt_Desc = UI.getChildControl(Panel_Window_EnchantStackConfirm_All, "StaticText_Content")
  self._ui.edit_inputMyStack = UI.getChildControl(Panel_Window_EnchantStackConfirm_All, "Edit_InputStackCount")
  self._ui.stc_KeyGuide_X = UI.getChildControl(self._ui.edit_inputMyStack, "Static_KeyX_Console")
  self._ui.stc_Bottom_KeyGuide = UI.getChildControl(Panel_Window_EnchantStackConfirm_All, "Static_BottomBg_ConsoleUI")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_Bottom_KeyGuide, "StaticText_A_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_Bottom_KeyGuide, "StaticText_B_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  local textSize = self._ui.txt_Desc:GetTextSizeY()
  local textBGSize = self._ui.txt_Desc:GetSizeY()
  if textSize > textBGSize then
    local gap = textSize - textBGSize
    Panel_Window_EnchantStackConfirm_All:SetSize(Panel_Window_EnchantStackConfirm_All:GetSizeX(), Panel_Window_EnchantStackConfirm_All:GetSizeY() + gap)
    self._ui.stc_bg:SetSize(self._ui.stc_bg:GetSizeX(), self._ui.stc_bg:GetSizeY() + gap)
    self._ui.txt_Desc:SetSize(self._ui.txt_Desc:GetSizeX(), textBGSize + 10)
    Panel_Window_EnchantStackConfirm_All:ComputePos()
    self._ui.txt_Desc:ComputePos()
    self._ui.stc_bg:ComputePos()
    self._ui.btn_Close:ComputePos()
    self._ui.btn_EnchantGo:ComputePos()
    self._ui.edit_inputMyStack:ComputePos()
  end
  PaGlobal_EnchantStackConfirm_All:validate()
  PaGlobal_EnchantStackConfirm_All:SwitchUI(self._isConsole)
  PaGlobal_EnchantStackConfirm_All:registerEvent(self._isConsole)
end
function PaGlobal_EnchantStackConfirm_All:validate()
  if true == PaGlobal_EnchantStackConfirm_All._initilize then
    return
  end
  self._ui.stc_blockBg:isValidate()
  self._ui.stc_bg:isValidate()
  self._ui.btn_EnchantGo:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.txt_Desc:isValidate()
  self._ui.edit_inputMyStack:isValidate()
  self._ui.stc_KeyGuide_X:isValidate()
  self._ui.stc_Bottom_KeyGuide:isValidate()
  self._ui.stc_KeyGuide_A:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
  self._initilize = true
end
function PaGlobal_EnchantStackConfirm_All:SwitchUI(isConsole)
  self._ui.btn_EnchantGo:SetShow(not isConsole)
  self._ui.btn_Close:SetShow(not isConsole)
  self._ui.stc_KeyGuide_A:SetShow(isConsole)
  self._ui.stc_KeyGuide_B:SetShow(isConsole)
  self._ui.stc_KeyGuide_X:SetShow(isConsole)
  self._ui.stc_Bottom_KeyGuide:SetShow(isConsole)
  if true == isConsole then
    local minus_btnSizeY = self._ui.btn_EnchantGo:GetSizeY() + 10
    self._ui.stc_bg:SetSize(self._ui.stc_bg:GetSizeX(), self._ui.stc_bg:GetSizeY() - minus_btnSizeY)
    Panel_Window_EnchantStackConfirm_All:SetSize(Panel_Window_EnchantStackConfirm_All:GetSizeX(), Panel_Window_EnchantStackConfirm_All:GetSizeY() - minus_btnSizeY)
    self._ui.stc_Bottom_KeyGuide:ComputePos()
    local tempBtnGroup = {
      self._ui.stc_KeyGuide_A,
      self._ui.stc_KeyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, self._ui.stc_Bottom_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_EnchantStackConfirm_All:registerEvent(isConsole)
  Panel_Window_EnchantStackConfirm_All:ignorePadSnapMoveToOtherPanel()
  registerEvent("onScreenResize", "PaGlobalFunc_EnchantStackConfirm_All_BlockBGResize()")
  if true == isConsole then
    Panel_Window_EnchantStackConfirm_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_EnchantStackConfirm_All_ShowNumberPad()")
    Panel_Window_EnchantStackConfirm_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_EnchantStackConfirm_All_isValidateText()")
    self._ui.edit_inputMyStack:setXboxVirtualKeyBoardEndEvent("HandleEventKeyBoard_EnchantStackConfirm_All")
  else
    self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_EnchantStackConfirm_All_Close()")
    self._ui.edit_inputMyStack:SetNumberMode(true)
    self._ui.edit_inputMyStack:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantStackConfirm_All_ClearEdit()")
    self._ui.edit_inputMyStack:RegistReturnKeyEvent("HandleEventLUp_EnchantStackConfirm_All_isValidateText()")
    self._ui.btn_EnchantGo:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantStackConfirm_All_isValidateText()")
  end
end
function PaGlobalFunc_EnchantStackConfirm_All_Open()
  if nil == Panel_Window_EnchantStackConfirm_All or true == Panel_Window_EnchantStackConfirm_All:GetShow() then
    return
  end
  ClearFocusEdit()
  PaGlobal_EnchantStackConfirm_All._totalStack = nil
  PaGlobal_EnchantStackConfirm_All._ui.edit_inputMyStack:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANTSTACKCONFIRM_EDIT"), true)
  PaGlobal_EnchantStackConfirm_All._enchantInfo = nil
  PaGlobal_EnchantStackConfirm_All._enchantInfo = getEnchantInformation()
  Panel_Window_EnchantStackConfirm_All:SetShow(true)
  PaGlobalFunc_EnchantStackConfirm_All_BlockBGResize()
  ToClient_padSnapSetTargetPanel(Panel_Window_EnchantStackConfirm_All)
end
function PaGlobalFunc_EnchantStackConfirm_All_Close()
  if nil == Panel_Window_EnchantStackConfirm_All or false == Panel_Window_EnchantStackConfirm_All:GetShow() then
    return
  end
  Panel_Window_EnchantStackConfirm_All:SetShow(false)
end
function PaGlobalFunc_EnchantStackConfirm_All_BlockBGResize()
  if nil ~= Panel_Window_EnchantStackConfirm_All or false == Panel_Window_EnchantStackConfirm_All:GetShow() then
    return
  end
  PaGlobal_EnchantStackConfirm_All._ui.stc_blockBg:SetSize(getScreenSizeX(), getScreenSizeY())
end
function HandleEventLUp_EnchantStackConfirm_All_ClearEdit()
  PaGlobal_EnchantStackConfirm_All._ui.edit_inputMyStack:SetEditText("", true)
  SetFocusEdit(PaGlobal_EnchantStackConfirm_All._ui.edit_inputMyStack)
end
function HandleEventLUp_EnchantStackConfirm_All_ShowNumberPad()
  local failCount = PaGlobal_EnchantStackConfirm_All._enchantInfo:ToClient_getFailCount()
  local valksCount = PaGlobal_EnchantStackConfirm_All._enchantInfo:ToClient_getValksCount()
  local bonusStackCount = PaGlobal_EnchantStackConfirm_All._enchantInfo:ToClient_getBonusStackCount()
  PaGlobal_EnchantStackConfirm_All._totalStack = failCount + valksCount + bonusStackCount
  Panel_NumberPad_Show(true, toInt64(0, PaGlobal_EnchantStackConfirm_All._totalStack), 0, HandleEventLUp_EnchantStackConfirm_All_SetEditTotalStackText)
end
function HandleEventLUp_EnchantStackConfirm_All_SetEditTotalStackText(count)
  if nil ~= count then
    PaGlobal_EnchantStackConfirm_All._ui.edit_inputMyStack:SetEditText(tostring(count))
  end
end
function HandleEventLUp_EnchantStackConfirm_All_isValidateText()
  local userInput = PaGlobal_EnchantStackConfirm_All._ui.edit_inputMyStack:GetEditText()
  if "" == userInput then
    return
  end
  local failCount = PaGlobal_EnchantStackConfirm_All._enchantInfo:ToClient_getFailCount()
  local valksCount = PaGlobal_EnchantStackConfirm_All._enchantInfo:ToClient_getValksCount()
  local bonusCount = PaGlobal_EnchantStackConfirm_All._enchantInfo:ToClient_getBonusStackCount()
  local myStack = tostring(failCount + valksCount + bonusCount)
  if userInput == myStack then
    HandleEventLUp_SpiritEnchant_All_EnchantApplyWithMyStackCount()
    PaGlobalFunc_EnchantStackConfirm_All_Close()
  end
end
function PaGlobalFunc_EnchantStackConfirm_All_PressKey()
  if nil ~= Panel_Window_EnchantStackConfirm_All and false == Panel_Window_EnchantStackConfirm_All then
    return
  end
  if true == PaGlobal_EnchantStackConfirm_All._ui.edit_inputMyStack:GetFocusEdit() then
    local editControl = PaGlobal_EnchantStackConfirm_All._ui.edit_inputMyStack
    for idx, val in ipairs(PaGlobal_EnchantStackConfirm_All._NUMBER_KEYCODE) do
      if true == isKeyPressed(val) then
        local curStr = tostring(editControl:GetEditText())
        if nil ~= curStr and "" ~= curStr then
          local length = string.len(curStr)
          if length > PaGlobal_EnchantStackConfirm_All._MAXINPUT then
            local newStr = string.sub(curStr, 0, length - 1)
            editControl:SetEditText(newStr)
          end
        end
      end
    end
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_BACK) then
      if "" ~= editControl:GetEditText() and nil ~= editControl:GetEditText() then
        local str = tostring(editControl:GetEditText())
        local length = string.len(str)
        local newStr = ""
        if 0 < length then
          newStr = string.sub(str, 0, length)
          editControl:SetEditText(tostring(newStr), true)
        end
      else
        PaGlobal_EnchantStackConfirm_All._ui.edit_inputMyStack:SetEditText("")
      end
    end
  end
end
function HandleEventKeyBoard_EnchantStackConfirm_All(str)
  PaGlobal_EnchantStackConfirm_All._ui.edit_inputMyStack:SetEditText(str)
  ClearFocusEdit()
end
