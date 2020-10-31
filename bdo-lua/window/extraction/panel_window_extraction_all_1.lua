function PaGlobal_Extraction_All:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:SetUiSetting()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Extraction_All:controlAll_Init()
  if nil == Panel_Window_Extraction_All then
    return
  end
  self._ui.btn_exit = UI.getChildControl(Panel_Window_Extraction_All, "RadioButton_Exit")
  self._ui.btn_system = UI.getChildControl(Panel_Window_Extraction_All, "RadioButton_System")
  self._ui.btn_cloth = UI.getChildControl(Panel_Window_Extraction_All, "RadioButton_Cloth")
  self._ui.btn_crystal = UI.getChildControl(Panel_Window_Extraction_All, "RadioButton_Crystal")
  self._ui.btn_caphras = UI.getChildControl(Panel_Window_Extraction_All, "RadioButton_Caphras")
  self._ui.btn_enchantStone = UI.getChildControl(Panel_Window_Extraction_All, "RadioButton_EnchantStone")
  self._ui.stc_selectLine = UI.getChildControl(Panel_Window_Extraction_All, "Static_SelectedLine")
  self._ui.btn_exit:SetTextMode(__eTextMode_AutoWrap)
  self._ui.btn_system:SetTextMode(__eTextMode_AutoWrap)
  self._ui.btn_cloth:SetTextMode(__eTextMode_AutoWrap)
  self._ui.btn_crystal:SetTextMode(__eTextMode_AutoWrap)
  self._ui.btn_caphras:SetTextMode(__eTextMode_AutoWrap)
  self._ui.btn_enchantStone:SetTextMode(__eTextMode_AutoWrap)
  self._ui.btn_exit:SetText(self._ui.btn_exit:GetText())
  self._ui.btn_system:SetText(self._ui.btn_system:GetText())
  self._ui.btn_cloth:SetText(self._ui.btn_cloth:GetText())
  self._ui.btn_crystal:SetText(self._ui.btn_crystal:GetText())
  self._ui.btn_caphras:SetText(self._ui.btn_caphras:GetText())
  self._ui.btn_enchantStone:SetText(self._ui.btn_enchantStone:GetText())
end
function PaGlobal_Extraction_All:controlPc_Init()
  if nil == Panel_Window_Extraction_All then
    return
  end
end
function PaGlobal_Extraction_All:controlConsole_Init()
  if nil == Panel_Window_Extraction_All then
    return
  end
  self._ui_console.btn_LB = UI.getChildControl(Panel_Window_Extraction_All, "Button_LB_ConsoleUI")
  self._ui_console.btn_RB = UI.getChildControl(Panel_Window_Extraction_All, "Button_RB_ConsoleUI")
  self._ui_console.btn_A = UI.getChildControl(Panel_Window_Extraction_All, "Button_A_ConsoleUI")
end
function PaGlobal_Extraction_All:SetUiSetting()
  if nil == Panel_Window_Extraction_All then
    return
  end
  if false == PaGlobal_Extraction_All._isConsole then
    self._ui_console.btn_LB:SetShow(false)
    self._ui_console.btn_RB:SetShow(false)
    self._ui_console.btn_A:SetShow(false)
  else
    self._ui_console.btn_LB:SetShow(true)
    self._ui_console.btn_RB:SetShow(true)
    self._ui_console.btn_A:SetShow(true)
  end
  FromClient_PaGlobal_Extraction_All_ReSizePanel()
end
function PaGlobal_Extraction_All:registEventHandler()
  if nil == Panel_Window_Extraction_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_PaGlobal_Extraction_All_ReSizePanel()")
  if true == self._isConsole then
    Panel_Window_Extraction_All:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_Extraction_All_MoveTab(-1)")
    Panel_Window_Extraction_All:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobal_Extraction_All_MoveTab(1)")
    Panel_Window_Extraction_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_Extraction_All_SelectCurrentTab()")
  end
  self._ui.btn_enchantStone:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_All_Button_ExtractionEnchantStone_Click()")
  self._ui.btn_caphras:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_All_Button_ExtractionCaphras_Click()")
  self._ui.btn_crystal:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_All_Button_ExtractionCrystal_Click()")
  self._ui.btn_cloth:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_All_Button_ExtractionCloth_Click()")
  self._ui.btn_system:addInputEvent("Mouse_LUp", "HandleEventLUp_Extraction_All_Button_ExtractionSystem_Click()")
  self._ui.btn_exit:addInputEvent("Mouse_LUp", "PaGlobal_Extraction_All_Close()")
end
function PaGlobal_Extraction_All:prepareOpen()
  if nil == Panel_Window_Extraction_All then
    return
  end
  self:openUiSetting()
  PaGlobal_Extraction_All:open()
end
function PaGlobal_Extraction_All:open()
  if nil == Panel_Window_Extraction_All then
    return
  end
  Panel_Window_Extraction_All:SetShow(true, false)
end
function PaGlobal_Extraction_All:prepareClose()
  if nil == Panel_Window_Extraction_All then
    return
  end
  self:closeUiSetting()
  PaGlobal_Extraction_All:close()
end
function PaGlobal_Extraction_All:close()
  if nil == Panel_Window_Extraction_All then
    return
  end
  Panel_Window_Extraction_All:SetShow(false, false)
end
function PaGlobal_Extraction_All:update()
  if nil == Panel_Window_Extraction_All then
    return
  end
end
function PaGlobal_Extraction_All:validate()
  if nil == Panel_Window_Extraction_All then
    return
  end
  self:allValidate()
  self:pcValidate()
  self:consoleValidate()
end
function PaGlobal_Extraction_All:allValidate()
  if nil == Panel_Window_Extraction_All then
    return
  end
  self._ui.btn_exit:isValidate()
  self._ui.btn_system:isValidate()
  self._ui.btn_cloth:isValidate()
  self._ui.btn_crystal:isValidate()
  self._ui.btn_caphras:isValidate()
  self._ui.btn_enchantStone:isValidate()
  self._ui.stc_selectLine:isValidate()
end
function PaGlobal_Extraction_All:pcValidate()
  if nil == Panel_Window_Extraction_All then
    return
  end
end
function PaGlobal_Extraction_All:consoleValidate()
  if nil == Panel_Window_Extraction_All then
    return
  end
  self._ui_console.btn_LB:isValidate()
  self._ui_console.btn_RB:isValidate()
  self._ui_console.btn_A:isValidate()
end
function PaGlobal_Extraction_All:openUiSetting()
  if nil == Panel_Window_Extraction_All then
    return
  end
  self:extraction_BtnResize()
  PaGlobal_TutorialManager:handleOpenExtractionPanel(true)
  self:BottomButtonPosition()
  self._ui.btn_enchantStone:SetCheck(false)
  self._ui.btn_caphras:SetCheck(false)
  self._ui.btn_crystal:SetCheck(false)
  self._ui.btn_cloth:SetCheck(false)
  self._ui.btn_system:SetCheck(false)
  self._ui.btn_exit:SetCheck(false)
  self._ui.stc_selectLine:SetShow(false)
  if true == self._isConsole then
    self._currentTabIndex = self._funcButtonCount
    PaGlobal_Extraction_All_MoveTab(1)
  end
end
function PaGlobal_Extraction_All:closeUiSetting()
  if nil == Panel_Window_Extraction_All then
    return
  end
  self:extraction_BtnResize()
  PaGlobal_TutorialManager:handleOpenExtractionPanel(false)
  self:BottomButtonPosition()
end
function PaGlobal_Extraction_All:extraction_BtnResize()
  if nil == Panel_Window_Extraction_All then
    return
  end
  local padding = 23
  local textSpanY = 5
  local btnEnchantStoneSizeX = self._ui.btn_enchantStone:GetSizeX() + padding
  local btnEnchantStoneTextPosX = btnEnchantStoneSizeX - btnEnchantStoneSizeX * 0.5 - self._ui.btn_enchantStone:GetTextSizeX() * 0.5
  local btnCrystalSizeX = self._ui.btn_crystal:GetSizeX() + padding
  local btnCrystalTextPosX = btnCrystalSizeX - btnCrystalSizeX * 0.5 - self._ui.btn_crystal:GetTextSizeX() * 0.5
  local btnClothSizeX = self._ui.btn_cloth:GetSizeX() + padding
  local btnClothTextPosX = btnClothSizeX - btnClothSizeX * 0.5 - self._ui.btn_cloth:GetTextSizeX() * 0.5
  local btnSystemPosX = self._ui.btn_system:GetSizeX() + padding
  local btnSystemTextPosX = btnSystemPosX - btnSystemPosX * 0.5 - self._ui.btn_system:GetTextSizeX() * 0.5
  local btnExitSizeX = self._ui.btn_exit:GetSizeX() + padding
  local btnExitTextPosX = btnExitSizeX - btnExitSizeX * 0.5 - self._ui.btn_exit:GetTextSizeX() * 0.5
  self._ui.btn_enchantStone:SetTextSpan(btnEnchantStoneTextPosX, textSpanY)
  self._ui.btn_crystal:SetTextSpan(btnCrystalTextPosX, textSpanY)
  self._ui.btn_cloth:SetTextSpan(btnClothTextPosX, textSpanY)
  self._ui.btn_system:SetTextSpan(btnSystemTextPosX, textSpanY)
  self._ui.btn_exit:SetTextSpan(btnExitTextPosX, textSpanY)
end
function PaGlobal_Extraction_All:BottomButtonPosition()
  local btnCount = 0
  local btnTable = {}
  local funcTable = {}
  if self._ui.btn_enchantStone:GetShow() then
    btnTable[btnCount] = self._ui.btn_enchantStone
    funcTable[btnCount] = HandleEventLUp_Extraction_All_Button_ExtractionEnchantStone_Click
    btnCount = btnCount + 1
  end
  if self._ui.btn_caphras:GetShow() then
    btnTable[btnCount] = self._ui.btn_caphras
    funcTable[btnCount] = HandleEventLUp_Extraction_All_Button_ExtractionCaphras_Click
    btnCount = btnCount + 1
  end
  if self._ui.btn_crystal:GetShow() then
    btnTable[btnCount] = self._ui.btn_crystal
    funcTable[btnCount] = HandleEventLUp_Extraction_All_Button_ExtractionCrystal_Click
    btnCount = btnCount + 1
  end
  if self._ui.btn_cloth:GetShow() then
    btnTable[btnCount] = self._ui.btn_cloth
    funcTable[btnCount] = HandleEventLUp_Extraction_All_Button_ExtractionCloth_Click
    btnCount = btnCount + 1
  end
  if self._ui.btn_system:GetShow() then
    btnTable[btnCount] = self._ui.btn_system
    funcTable[btnCount] = HandleEventLUp_Extraction_All_Button_ExtractionSystem_Click
    btnCount = btnCount + 1
  end
  if self._ui.btn_exit:GetShow() then
    btnTable[btnCount] = self._ui.btn_exit
    funcTable[btnCount] = PaGlobal_Extraction_All_Close
    btnCount = btnCount + 1
  end
  local sizeX = getScreenSizeX()
  self._funcButtonCount = btnCount
  self._btnTable = btnTable
  self._funcTable = funcTable
  local buttonSize = btnTable[0]:GetSizeX()
  local buttonGap = 10
  local startPosX = (sizeX - (buttonSize * btnCount + buttonGap * (btnCount - 1))) / 2
  local posX = 0
  local jindex = 0
  for index = 0, btnCount - 1 do
    if true == btnTable[index]:GetShow() then
      posX = startPosX + (buttonSize + buttonGap) * jindex
      jindex = jindex + 1
    end
    btnTable[index]:SetPosX(posX)
  end
  if true == self._isConsole then
    local gap = 20
    self._ui_console.btn_LB:SetPosX(btnTable[0]:GetPosX() - self._ui_console.btn_LB:GetSizeX() - gap)
    self._ui_console.btn_RB:SetPosX(btnTable[btnCount - 1]:GetPosX() + btnTable[btnCount - 1]:GetSizeX() + gap)
  end
end
