function PaGlobal_ButtonShortcuts_All:initialize()
  if true == PaGlobal_ButtonShortcuts_All._initialize then
    return
  end
  PaGlobal_ButtonShortcuts_All:controlAll_Init()
  PaGlobal_ButtonShortcuts_All:registEventHandler()
  PaGlobal_ButtonShortcuts_All:validate()
  PaGlobal_ButtonShortcuts_All._initialize = true
end
function PaGlobal_ButtonShortcuts_All:controlAll_Init()
  if nil == Panel_Window_ButtonShortcuts_All then
    return
  end
  self._ui.stc_titleBg = UI.getChildControl(Panel_Window_ButtonShortcuts_All, "Static_Title_BG")
  self._ui.stc_markIcon = UI.getChildControl(Panel_Window_ButtonShortcuts_All, "Static_ButtonShortcuts_MarkIcon")
  self._ui.stc_curSetBg = UI.getChildControl(Panel_Window_ButtonShortcuts_All, "Static_Current_KeySetting")
  self._ui.txt_curSetTitle = UI.getChildControl(self._ui.stc_curSetBg, "StaticText_Current_Key_Title")
  self._ui.txt_curSetName = UI.getChildControl(self._ui.stc_curSetBg, "StaticText_Current_Key_Name")
  self._ui.radio_curSetKey = UI.getChildControl(self._ui.stc_curSetBg, "Radiobutton_Current_Key")
  self._ui.stc_allListBg = UI.getChildControl(Panel_Window_ButtonShortcuts_All, "Static_KeySetting_AllList")
  self._ui.edit_search = UI.getChildControl(self._ui.stc_allListBg, "Edit_SearchButtonShortcut")
  self._ui.btn_search = UI.getChildControl(self._ui.edit_search, "Button_SearchIcon")
  self._ui.chk_all = UI.getChildControl(self._ui.stc_allListBg, "CheckButton_AllView")
  self._ui.chk_all:SetTextMode(__eTextMode_Limit_AutoWrap)
  self._ui.chk_all:SetText(self._ui.chk_all:GetText())
  self._ui.list2_keySet = UI.getChildControl(self._ui.stc_allListBg, "List2_KeySetting_BG")
  self._ui.stc_bottomDescBg = UI.getChildControl(Panel_Window_ButtonShortcuts_All, "Static_BottomDescBG")
  self._ui.txt_bottomDesc = UI.getChildControl(self._ui.stc_bottomDescBg, "StaticText_BottomDesc")
  self._ui.txt_bottomDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_bottomDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_BUTTONSHORTCUT_BOTTOM_DESC"))
  self._ui.btn_close = UI.getChildControl(Panel_Window_ButtonShortcuts_All, "Button_Close")
  self._ui.btn_reset = UI.getChildControl(Panel_Window_ButtonShortcuts_All, "Button_Reset")
  self._ui.btn_allView = UI.getChildControl(Panel_Window_ButtonShortcuts_All, "Button_ButtonShortcuts_AllView")
  self._ui.btn_confirm = UI.getChildControl(Panel_Window_ButtonShortcuts_All, "Button_Confirm")
  self._ui.btn_question = UI.getChildControl(Panel_Window_ButtonShortcuts_All, "Button_Question")
  self._altString = "Alt + "
  self._bottomBgOriginSizeY = self._ui.stc_bottomDescBg:GetSizeY()
  self._UIMODE.Current.size = Panel_Window_ButtonShortcuts_All:GetSizeY() - self._ui.stc_allListBg:GetSizeY() - 10
  self._UIMODE.List.size = Panel_Window_ButtonShortcuts_All:GetSizeY() - self._ui.stc_allListBg:GetSizeY() - 10 + self._ui.stc_allListBg:GetSizeY() + 10
  self._UIMODE.ListOnly.size = Panel_Window_ButtonShortcuts_All:GetSizeY() - self._ui.stc_curSetBg:GetSizeY() - 10
  self._UIMODE.ListOnly.offset = self._ui.stc_curSetBg:GetSizeY() + 10
  self._listOriginPos = self._ui.stc_allListBg:GetPosY()
  self._buttonPos[self._UIMODE.Current.index] = self._ui.btn_reset:GetPosY() - self._ui.stc_allListBg:GetSizeY() - 10
  self._buttonPos[self._UIMODE.List.index] = self._ui.btn_reset:GetPosY()
  self._buttonPos[self._UIMODE.ListOnly.index] = self._ui.btn_reset:GetPosY() - (self._ui.stc_curSetBg:GetSizeY() + 10)
end
function PaGlobal_ButtonShortcuts_All:prepareOpen(index)
  if nil == Panel_Window_ButtonShortcuts_All then
    return
  end
  audioPostEvent_SystemUi(1, 0)
  _AudioPostEvent_SystemUiForXBOX(1, 0)
  self._ui.chk_all:SetCheck(true)
  self._ui.edit_search:SetEditText(self._defaultEditTxt)
  local isCurrentMode = nil ~= index
  if true == isCurrentMode then
    self._curId = index
    self._openButtonsShortcuts = ToClent_getButtonShortcutsEventAt(index)
    self._ui.txt_curSetName:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_curSetName:SetText(self._openButtonsShortcuts:getButtonString())
    self._ui.radio_curSetKey:SetText(self:GetKeyCodeText(self._openButtonsShortcuts:getKeyCode()))
    self._currentSetId = index
    self._ui.chk_all:SetCheck(false)
    self._ePanelType = self._eOpenType.currentSet
  else
    self._ePanelType = self._eOpenType.allSet
  end
  PaGlobal_ButtonShortcuts_All:resize()
  PaGlobal_ButtonShortcuts_All:open()
  PaGlobal_ButtonShortcuts_All:uiRefresh(index)
end
function PaGlobal_ButtonShortcuts_All:open(index)
  if nil == Panel_Window_ButtonShortcuts_All then
    return
  end
  Panel_Window_ButtonShortcuts_All:SetShow(true)
end
function PaGlobal_ButtonShortcuts_All:prepareClose()
  if nil == Panel_Window_ButtonShortcuts_All then
    return
  end
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
  self._openButtonsShortcuts = nil
  self._curId = -1
  self._currentSetId = -1
  self._searchText = ""
  setKeyCustomizing(false)
  PaGlobal_ButtonShortcuts_All:uiRefresh()
  PaGlobal_ButtonShortcuts_All:close()
end
function PaGlobal_ButtonShortcuts_All:close()
  if nil == Panel_Window_ButtonShortcuts_All then
    return
  end
  Panel_Window_ButtonShortcuts_All:SetShow(false)
end
function PaGlobal_ButtonShortcuts_All:registEventHandler()
  if nil == Panel_Window_ButtonShortcuts_All then
    return
  end
  ToClent_setButtonShortcutsMarkIcon(UI.getChildControl(Panel_Window_ButtonShortcuts_All, "Static_ButtonShortcuts_MarkIcon"))
  registerEvent("FromClient_OpenButtonShortcuts", "FromClient_ButtonShortcuts_All_OpenButtonShortcuts")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_ButtonShorcuts_All_Close()")
  self._ui.btn_confirm:addInputEvent("Mouse_LUp", "PaGlobalFunc_ButtonShorcuts_All_Close()")
  self._ui.btn_reset:addInputEvent("Mouse_LUp", "HandleEventLUp_ButtonShortcuts_All_SetDefault()")
  self._ui.btn_allView:addInputEvent("Mouse_LUp", "HandleEventLUp_ButtonShortcuts_All_ChangeAllViewMode()")
  self._ui.chk_all:addInputEvent("Mouse_LUp", "HandleEventLUp_ButtonShortcuts_All_ToggleAllView()")
  self._ui.btn_allView:addInputEvent("Mouse_On", "HandleEventOnOut_ButtonShortcuts_All_SimpleTooltips(true, 0)")
  self._ui.btn_allView:addInputEvent("Mouse_Out", "HandleEventOnOut_ButtonShortcuts_All_SimpleTooltips(false)")
  self._ui.btn_reset:addInputEvent("Mouse_On", "HandleEventOnOut_ButtonShortcuts_All_SimpleTooltips(true, 1)")
  self._ui.btn_reset:addInputEvent("Mouse_Out", "HandleEventOnOut_ButtonShortcuts_All_SimpleTooltips(false)")
  self._ui.chk_all:addInputEvent("Mouse_On", "HandleEventOnOut_ButtonShortcuts_All_SimpleTooltips(true, 2)")
  self._ui.chk_all:addInputEvent("Mouse_Out", "HandleEventOnOut_ButtonShortcuts_All_SimpleTooltips(false)")
  self._ui.radio_curSetKey:addInputEvent("Mouse_LUp", "HandleEventLUp_ButtonShortcuts_All_ClickedChangeShortcuts()")
  self._ui.btn_search:addInputEvent("Mouse_LUp", "HandleEventLUp_ButtonShortcuts_All_ApplySearch()")
  self._ui.edit_search:addInputEvent("Mouse_LUp", "HandleEventLUp_ButtonShortcuts_All_EditSearch()")
  self._ui.list2_keySet:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ButtonShorcuts_All_ListControlCreate")
  self._ui.list2_keySet:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_ButtonShortcuts_All:validate()
  if nil == Panel_Window_ButtonShortcuts_All then
    return
  end
  self._ui.stc_titleBg:isValidate()
  self._ui.stc_markIcon:isValidate()
  self._ui.stc_curSetBg:isValidate()
  self._ui.txt_curSetTitle:isValidate()
  self._ui.txt_curSetName:isValidate()
  self._ui.radio_curSetKey:isValidate()
  self._ui.stc_allListBg:isValidate()
  self._ui.edit_search:isValidate()
  self._ui.btn_search:isValidate()
  self._ui.chk_all:isValidate()
  self._ui.list2_keySet:isValidate()
  self._ui.stc_bottomDescBg:isValidate()
  self._ui.txt_bottomDesc:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.btn_reset:isValidate()
  self._ui.btn_allView:isValidate()
  self._ui.btn_confirm:isValidate()
  self._ui.btn_question:isValidate()
end
function PaGlobal_ButtonShortcuts_All:resize()
  local descSizeY = self._ui.txt_bottomDesc:GetTextSizeY() + 10
  if self._ui.stc_bottomDescBg:GetSizeY() < descSizeY + 10 then
    local addSizeY = descSizeY - self._bottomBgOriginSizeY
    self._ui.stc_bottomDescBg:SetSize(self._ui.stc_bottomDescBg:GetSizeX(), self._bottomBgOriginSizeY + addSizeY)
    local panel = Panel_Window_ButtonShortcuts_All
    Panel_Window_ButtonShortcuts_All:SetSize(panel:GetSizeX(), panel:GetSizeY() + addSizeY)
    self._ui.stc_bottomDescBg:ComputePos()
    self._ui.txt_bottomDesc:ComputePos()
    self._ui.btn_confirm:ComputePos()
    self._ui.btn_reset:ComputePos()
    self._ui.btn_allView:ComputePos()
  end
end
function PaGlobal_ButtonShortcuts_All:register(VirtualKeyCode)
  if true == self:IsExhibitKey(VirtualKeyCode) then
    PaGlobal_ButtonShortcuts_All:uiRefresh(self._curId)
    self._curButtonsShortcuts = nil
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BUTTONSHORTCUTS_DISAVAILABLE_REGISTER"))
    return
  end
  if nil == self._curButtonsShortcuts then
    PaGlobal_ButtonShortcuts_All:uiRefresh()
    return
  end
  if true == ToClent_hasKeyButtonShortcuts(VirtualKeyCode) then
    self._registerKey = VirtualKeyCode
    local messageBoxMemo = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BUTTONSHORTCUTS_ALEADY_KEYCODE")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = PaGlobalFunc_ButtonShorcuts_All_RegisterOk,
      functionNo = PaGlobal_ButtonShortcuts_All_CurrentRefresh,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  ToClent_addButtonShortcutsEvent(self._curButtonsShortcuts, VirtualKeyCode)
  PaGlobal_ButtonShortcuts_All:uiRefresh(self._curId)
  self._curButtonsShortcuts = nil
  FGlobal_NewShortCut_Close()
end
function PaGlobal_ButtonShortcuts_All:remove()
  ToClent_removeAtButtonShortcutsEvent(self._curButtonsShortcuts)
  PaGlobal_ButtonShortcuts_All:uiRefresh(self._curId)
end
function PaGlobal_ButtonShortcuts_All:changeUI(mode)
  TooltipSimple_Hide()
  if nil == mode then
    return
  end
  self._curMode = mode
  self._ui.stc_allListBg:SetPosY(self._listOriginPos)
  self._ui.btn_reset:SetPosY(self._buttonPos[mode])
  self._ui.btn_confirm:SetPosY(self._buttonPos[mode])
  self._ui.btn_allView:SetPosY(self._buttonPos[mode])
  if mode == self._UIMODE.Current.index then
    self._ui.stc_allListBg:SetShow(false)
    self._ui.stc_curSetBg:SetShow(true)
    self._ui.stc_bottomDescBg:SetPosY(135)
    self._ui.btn_allView:SetShow(true)
    Panel_Window_ButtonShortcuts_All:SetSize(Panel_Window_ButtonShortcuts_All:GetSizeX(), self._UIMODE.Current.size)
  elseif mode == self._UIMODE.List.index then
    self._ui.stc_allListBg:SetShow(true)
    self._ui.stc_curSetBg:SetShow(true)
    self._ui.stc_bottomDescBg:SetPosY(486)
    self._ui.btn_allView:SetShow(false)
    Panel_Window_ButtonShortcuts_All:SetSize(Panel_Window_ButtonShortcuts_All:GetSizeX(), self._UIMODE.List.size)
    PaGlobal_ButtonShortcuts_All:uiRefresh()
  elseif mode == self._UIMODE.ListOnly.index then
    self._ui.stc_allListBg:SetShow(true)
    self._ui.stc_curSetBg:SetShow(false)
    self._ui.btn_allView:SetShow(false)
    self._ui.stc_bottomDescBg:SetPosY(396)
    self._ui.stc_allListBg:SetPosY(self._ui.stc_allListBg:GetPosY() - self._UIMODE.ListOnly.offset)
    Panel_Window_ButtonShortcuts_All:SetSize(Panel_Window_ButtonShortcuts_All:GetSizeX(), self._UIMODE.ListOnly.size)
  end
end
function PaGlobal_ButtonShortcuts_All:uiRefresh(index)
  if nil ~= self._openButtonsShortcuts then
    self._ui.txt_curSetName:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_curSetName:SetText(self._openButtonsShortcuts:getButtonString())
    self._ui.radio_curSetKey:SetText(PaGlobal_ButtonShortcuts_All:GetKeyCodeText(self._openButtonsShortcuts:getKeyCode()))
    self._ui.radio_curSetKey:SetCheck(false)
  end
  self._curId = -1
  if nil ~= index then
    self._ui.list2_keySet:requestUpdateByKey(toInt64(0, index))
  else
    PaGlobal_ButtonShortcuts_All:listRefresh()
  end
  ClearFocusEdit()
end
function PaGlobal_ButtonShortcuts_All:listRefresh()
  self._ui.list2_keySet:getElementManager():clearKey()
  local count = ToClent_getButtonShortcutsEventCount()
  for idx = 0, count - 1 do
    local isShow = true
    local data = ToClent_getButtonShortcutsEventAt(idx)
    if "" ~= self._searchText and nil == string.find(data:getButtonString(), self._searchText) then
      isShow = false
    end
    if false == self._ui.chk_all:IsCheck() and 0 == data:getKeyCode() then
      isShow = false
    end
    if true == isShow then
      self._ui.list2_keySet:getElementManager():pushKey(toInt64(0, idx))
    end
  end
end
function PaGlobal_ButtonShortcuts_All:listControlCreate(content, key)
  local key32 = Int64toInt32(key)
  local buttonShortcuts = ToClent_getButtonShortcutsEventAt(key32)
  local buttonName = UI.getChildControl(content, "StaticText_ListKeySetting_Name")
  local shortcuts = UI.getChildControl(content, "Radiobutton_ListKeySetting")
  local isShow = true
  buttonName:SetShow(true)
  shortcuts:SetShow(true)
  buttonName:setNotImpactScrollEvent(true)
  shortcuts:setNotImpactScrollEvent(true)
  buttonName:SetTextMode(__eTextMode_AutoWrap)
  buttonName:SetText(buttonShortcuts:getButtonString())
  shortcuts:SetTextMode(__eTextMode_AutoWrap)
  shortcuts:SetText(PaGlobal_ButtonShortcuts_All:GetKeyCodeText(buttonShortcuts:getKeyCode()))
  if nil ~= self._curId and key32 == self._curId then
    shortcuts:SetText("")
  end
  shortcuts:SetCheck(key32 == self._curId)
  shortcuts:addInputEvent("Mouse_LUp", "HandleEventLUp_ButtonShortcuts_All_ChangeShortcuts(" .. key32 .. ")")
  shortcuts:addInputEvent("Mouse_RUp", "HandleEventLUp_ButtonShortcuts_All_DeleteShortcuts(" .. key32 .. ")")
end
function PaGlobal_ButtonShortcuts_All:GetKeyCodeText(keyCode)
  if 0 == keyCode then
    return self._nothingTxt
  else
    if nil == self._keyString[keyCode] then
      return self._nothingTxt
    end
    local keystring = "<PAColor0xffd8ad70>" .. self._altString .. self._keyString[keyCode] .. "<PAOldColor>"
    return keystring
  end
end
function PaGlobal_ButtonShortcuts_All:IsExhibitKey(keyCode)
  local ExhibitKeys = {
    CppEnums.VirtualKeyCode.KeyCode_SHIFT,
    CppEnums.VirtualKeyCode.KeyCode_TAB,
    CppEnums.VirtualKeyCode.KeyCode_BACK,
    CppEnums.VirtualKeyCode.KeyCode_CAPITAL,
    CppEnums.VirtualKeyCode.KeyCode_CONTROL,
    CppEnums.VirtualKeyCode.KeyCode_SPACE,
    CppEnums.VirtualKeyCode.KeyCode_OEM_7,
    CppEnums.VirtualKeyCode.KeyCode_OEM_2,
    CppEnums.VirtualKeyCode.KeyCode_OEM_3
  }
  for idx = 0, #ExhibitKeys do
    if keyCode == ExhibitKeys[idx] then
      return true
    end
  end
  if self._nothingTxt == PaGlobal_ButtonShortcuts_All:GetKeyCodeText(keyCode) then
    return true
  end
  return false
end
function PaGlobal_ButtonShortcuts_All:setDefault()
  TooltipSimple_Hide()
  local messageBoxMemo = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BUTTONSHORTCUTS_ALLRESETMESSAGE")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = messageBoxMemo,
    functionYes = PaGlobalFunc_ButtonShorcuts_All_SetDefault,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_ButtonShortcuts_All:clickedChangeShortcuts()
  self._curButtonsShortcuts = self._openButtonsShortcuts
  self._ui.radio_curSetKey:SetCheck(true)
  self._ui.radio_curSetKey:SetText("")
  ClearFocusEdit()
  PaGlobal_NewShortCut_SetEasyShortCut(self._currentSetId)
end
