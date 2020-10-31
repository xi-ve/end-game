function PaGlobal_BloodAltarRetry_All:initialize()
  if true == PaGlobal_BloodAltarRetry_All._initialize then
    return
  end
  self._ui.stc_title = UI.getChildControl(Panel_Window_BloodAltar_Retry_All, "Static_TitleArea")
  self._ui.stc_backBG = UI.getChildControl(Panel_Window_BloodAltar_Retry_All, "Static_BackGround")
  self._ui.stc_descBG = UI.getChildControl(Panel_Window_BloodAltar_Retry_All, "Static_DescArea")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_descBG, "StaticText_Desc")
  self._ui.stc_bottomBtnBG = UI.getChildControl(Panel_Window_BloodAltar_Retry_All, "Static_BottomButtonArea")
  self._ui.btn_retry = UI.getChildControl(self._ui.stc_bottomBtnBG, "Button_Retry")
  self._ui.txt_hasItem = UI.getChildControl(self._ui.btn_retry, "StaticText_HasItemName")
  self._ui.btn_cancel = UI.getChildControl(self._ui.stc_bottomBtnBG, "Button_Cancel")
  self._ui.stc_keyGuideBg = UI.getChildControl(Panel_Window_BloodAltar_Retry_All, "Static_Console_Buttons")
  self._originPanelSizeY = Panel_Window_BloodAltar_Retry_All:GetSizeY()
  self._originBackSizeY = self._ui.stc_backBG:GetSizeY()
  PaGlobal_BloodAltarRetry_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_BloodAltarRetry_All:registerEventHandler()
  PaGlobal_BloodAltarRetry_All:validate()
  PaGlobal_BloodAltarRetry_All:switchPlatform()
  PaGlobal_BloodAltarRetry_All._initialize = true
end
function PaGlobal_BloodAltarRetry_All:registerEventHandler()
  if nil == Panel_Window_BloodAltar_Retry_All then
    return
  end
  if false == PaGlobal_BloodAltarRetry_All._isConsole then
    self._ui.btn_retry:addInputEvent("Mouse_LUp", "PaGlobalFunc_BlooaAltarRetry_RetryCheck(true)")
    self._ui.btn_cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_BlooaAltarRetry_RetryCheck(false)")
  else
    Panel_Window_BloodAltar_Retry_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_BlooaAltarRetry_RetryCheck(true)")
    Panel_Window_BloodAltar_Retry_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_HandleClicked_BloodAltar_Open()")
  end
end
function PaGlobal_BloodAltarRetry_All:switchPlatform()
  self._ui.btn_cancel:SetShow(not self._isConsole)
  self._ui.btn_retry:SetShow(not self._isConsole)
  self._ui.stc_keyGuideBg:SetShow(self._isConsole)
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(self._ui.txt_desc:GetText())
  if true == PaGlobal_BloodAltarRetry_All._isConsole then
    local panelY = Panel_Window_BloodAltar_Retry_All:GetSizeY() - (PaGlobal_BloodAltarRetry_All._ui.btn_retry:GetSizeY() + 10)
    self._ui.stc_keyGuideBg:SetPosY(panelY)
    self._ui.stc_keyGuideBg:ComputePos()
    self._ui.stc_backBG:ComputePos()
    local keyY = UI.getChildControl(self._ui.stc_keyGuideBg, "Button_Y_ConsoleUI")
    local keyA = UI.getChildControl(self._ui.stc_keyGuideBg, "Button_A_ConsoleUI")
    local keyB = UI.getChildControl(self._ui.stc_keyGuideBg, "Button_B_ConsoleUI")
    local keyguide = {
      keyY,
      keyA,
      keyB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
    self._ui.txt_desc:SetText(self._ui.txt_desc:GetText() .. [[




]])
    local txtSizeY = self._ui.txt_desc:GetTextSizeY()
    local gap = 40
    local panelY = self._ui.stc_title:GetSizeY() + txtSizeY + gap
    Panel_Window_BloodAltar_Retry_All:SetSize(Panel_Window_BloodAltar_Retry_All:GetSizeX(), panelY)
    self._ui.stc_backBG:SetSize(self._ui.stc_backBG:GetSizeX(), Panel_Window_BloodAltar_Retry_All:GetSizeY() - self._ui.stc_title:GetSizeY())
    self._ui.stc_keyGuideBg:SetPosY(Panel_Window_BloodAltar_Retry_All:GetSizeY())
    self._ui.stc_keyGuideBg:ComputePos()
  else
    local pcPanelY = self._ui.stc_title:GetSizeY() + self._ui.txt_desc:GetTextSizeY() + self._ui.stc_bottomBtnBG:GetSizeY() + 50
    Panel_Window_BloodAltar_Retry_All:SetSize(Panel_Window_BloodAltar_Retry_All:GetSizeX(), pcPanelY)
    self._ui.stc_backBG:SetSize(self._ui.stc_backBG:GetSizeX(), Panel_Window_BloodAltar_Retry_All:GetSizeY() - (self._ui.stc_title:GetSizeY() + self._ui.stc_bottomBtnBG:GetSizeY() + 5))
    self._ui.stc_descBG:SetSize(self._ui.txt_desc:GetSizeX(), self._ui.txt_desc:GetTextSizeY() + 10)
    self._ui.stc_bottomBtnBG:ComputePos()
  end
end
function PaGlobal_BloodAltarRetry_All:update()
  if nil == Panel_Window_BloodAltar_Retry_All then
    return
  end
  local itemCount = 0
  local itemCount2 = 0
  if nil ~= getSelfPlayer() then
    local normalInven = getSelfPlayer():get():getInventory()
    local cachInven = getSelfPlayer():get():getCashInventory()
    if nil ~= normalInven then
      itemCount = normalInven:getItemCount_s64(ItemEnchantKey(296))
    end
    if nil ~= cachInven then
      itemCount2 = cachInven:getItemCount_s64(ItemEnchantKey(18498))
    end
  end
  self._ui.txt_hasItem:SetShow(not PaGlobal_BloodAltarRetry_All._isConsole)
  if true == PaGlobal_BloodAltarRetry_All._isConsole then
    self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BLOODALTAR_RETRY_DESC") .. [[


]] .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BLOODALTAR_RETRYBUTTON_REMAINCOUNT", "count", tostring(itemCount), "count2", tostring(itemCount2)))
  else
    self._ui.txt_hasItem:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BLOODALTAR_RETRYBUTTON_REMAINCOUNT", "count", tostring(itemCount), "count2", tostring(itemCount2)))
  end
end
function PaGlobal_BloodAltarRetry_All:prepareOpen()
  if nil == Panel_Window_BloodAltar_Retry_All then
    return
  end
  PaGlobal_BloodAltarRetry_All:update()
  PaGlobal_BloodAltarRetry_All:open()
end
function PaGlobal_BloodAltarRetry_All:open()
  if nil == Panel_Window_BloodAltar_Retry_All then
    return
  end
  Panel_Window_BloodAltar_Retry_All:SetShow(true)
end
function PaGlobal_BloodAltarRetry_All:prepareClose()
  if nil == Panel_Window_BloodAltar_Retry_All then
    return
  end
  PaGlobal_BloodAltarRetry_All:close()
end
function PaGlobal_BloodAltarRetry_All:close()
  if nil == Panel_Window_BloodAltar_Retry_All then
    return
  end
  Panel_Window_BloodAltar_Retry_All:SetShow(false)
end
function PaGlobal_BloodAltarRetry_All:validate()
  if nil == Panel_Window_BloodAltar_Retry_All then
    return
  end
  self._ui.stc_backBG:isValidate()
  self._ui.stc_descBG:isValidate()
  self._ui.txt_desc:isValidate()
  self._ui.stc_bottomBtnBG:isValidate()
  self._ui.btn_retry:isValidate()
  self._ui.txt_hasItem:isValidate()
  self._ui.btn_cancel:isValidate()
  self._ui.stc_title:isValidate()
  self._ui.stc_keyGuideBg:isValidate()
end
