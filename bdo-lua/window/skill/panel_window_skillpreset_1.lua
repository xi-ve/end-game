function PaGlobal_SkillPreset:initialize()
  if true == PaGlobal_SkillPreset._initialize then
    return
  end
  self._ui.stc_Block = UI.getChildControl(Panel_Window_SkillPreset, "Static_Block")
  self._ui.stc_BG = UI.getChildControl(Panel_Window_SkillPreset, "Static_BG")
  self._ui.stc_title = UI.getChildControl(Panel_Window_SkillPreset, "Static_TitleArea")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_title, "StaticText_Title")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_title, "Button_Win_Close")
  self._ui.btn_Close2 = UI.getChildControl(Panel_Window_SkillPreset, "Button_Close")
  self._ui.stc_Desc = UI.getChildControl(Panel_Window_SkillPreset, "StaticText_Desc")
  self._ui.stc_Save = UI.getChildControl(Panel_Window_SkillPreset, "Button_Save")
  self._maxSlotCount = ToClient_getSkillPresetSlotMaxCount()
  for index = 0, self._maxSlotCount - 1 do
    self._ui.btn_Slot[index] = UI.getChildControl(Panel_Window_SkillPreset, "RadioButton_" .. tostring(index + 1))
    self._ui.btn_Slot[index]:SetShow(false)
  end
  self._ui.stc_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLPRESET_DESC"))
  PaGlobal_SkillPreset:registEventHandler()
  PaGlobal_SkillPreset:validate()
  PaGlobal_SkillPreset._initialize = true
end
function PaGlobal_SkillPreset:registEventHandler()
  if nil == Panel_Window_SkillPreset then
    return
  end
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_SkillPreset_Close()")
  self._ui.btn_Close2:addInputEvent("Mouse_LUp", "PaGlobal_SkillPreset_Close()")
  for index = 0, self._maxSlotCount - 1 do
    self._ui.btn_Slot[index]:addInputEvent("Mouse_LUp", "PaGlobal_SkillPreset_selectButton(" .. index .. ")")
    self._ui.btn_Slot[index]:addInputEvent("Mouse_Out", "PaGlobal_SkillPreset_TextureSetting(" .. index .. ")")
  end
  self._ui.stc_Save:addInputEvent("Mouse_LUp", "PaGlobal_SkillPreset_saveSkillPresetConfirm()")
end
function PaGlobal_SkillPreset:prepareOpen(count)
  if nil == Panel_Window_SkillPreset then
    return
  end
  PaGlobal_SkillPreset_ButtonSetting(count)
  PaGlobal_SkillPreset:open()
end
function PaGlobal_SkillPreset:open()
  if nil == Panel_Window_SkillPreset then
    return
  end
  self._selectSlot = -1
  self._ui.stc_Save:SetEnable(false)
  Panel_Window_SkillPreset:SetShow(true)
end
function PaGlobal_SkillPreset:prepareClose()
  if nil == Panel_Window_SkillPreset then
    return
  end
  self._selectSlot = -1
  self._ui.stc_Save:SetEnable(false)
  PaGlobal_SkillPreset:close()
end
function PaGlobal_SkillPreset:close()
  if nil == Panel_Window_SkillPreset then
    return
  end
  Panel_Window_SkillPreset:SetShow(false)
end
function PaGlobal_SkillPreset:update()
  if nil == Panel_Window_SkillPreset then
    return
  end
end
function PaGlobal_SkillPreset:validate()
  if nil == Panel_Window_SkillPreset then
    return
  end
  self._ui.stc_Block:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.stc_Desc:isValidate()
end
function PaGlobal_SkillPreset:saveSkillPresetConfirm()
  if self._selectSlot < 0 then
    return
  end
  local isEmpty = Toclient_getSkillPresetSlotEmpty(self._selectSlot)
  if false == isEmpty then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_ALEADY_CONFIRM")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = messageBoxMemo,
      functionYes = PaGlobal_SkillPreset_saveSkillPreset,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    PaGlobal_SkillPreset_saveSkillPreset()
  end
end
function PaGlobal_SkillPreset:saveSkillPreset()
  if self._selectSlot < 0 then
    return
  end
  ToClient_requestSaveSkillPreset(self._selectSlot)
  self._selectSlot = -1
  PaGlobal_SkillPreset_Close()
end
function PaGlobal_SkillPreset:applySkillPreset()
  if self._selectSlot < 0 then
    return
  end
  ToClient_requestApplySkillPreset(self._selectSlot)
  self._selectSlot = -1
end
function PaGlobal_SkillPreset:selectButton(slotNo)
  self._selectSlot = slotNo
  self._ui.stc_Save:SetEnable(true)
end
function PaGlobal_SkillPreset:applyConfirmMessageBox()
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_APPLY")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = messageBoxMemo,
    functionYes = PaGlobal_SkillPreset_applySkillPreset,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_SkillPreset:buttonSetting(count)
  local sizeX = self._ui.stc_BG:GetSizeX()
  local spanSizeX = 10
  local posX = self._ui.stc_BG:GetPosX()
  local centerBtnPos = posX + sizeX / 2 - spanSizeX
  local tmp = self._ui.btn_Slot[0]:GetSizeX() + spanSizeX
  for index = 0, count - 1 do
    if index >= self._maxSlotCount then
      return
    end
    self._ui.btn_Slot[index]:SetPosX(spanSizeX + centerBtnPos - tmp * (count / 2 - index))
    self._ui.btn_Slot[index]:SetShow(true)
    PaGlobal_SkillPreset:textureSetting(index)
  end
end
function PaGlobal_SkillPreset:textureSetting(slotNo)
  if slotNo >= self._maxSlotCount then
    return
  end
  if slotNo == self._selectSlot then
    return
  end
  local control = self._ui.btn_Slot[slotNo]
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobal_SkillPreset:confirmMessageBox()
  local maxBaseSlotCount = ToClient_getSkillPresetSlotMaxCount()
  local currCashSlotCount = ToClient_getSkillPresetCashSlotCount()
  local currBaseSlotCount = ToClient_getSkillPresetSlotCount()
  if maxBaseSlotCount > currBaseSlotCount then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_BUY_CONFIRM")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = messageBoxMemo,
      functionYes = HandleMLUp_SkillWindow_SkillPresetEasyBuy,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  elseif maxBaseSlotCount > currBaseSlotCount then
    HandleMLUp_SkillWindow_SkillPresetEasyBuy()
    return
  else
    return
  end
end
