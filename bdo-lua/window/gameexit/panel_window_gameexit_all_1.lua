function PaGlobal_GameExit_All:initialize()
  if true == PaGlobal_GameExit_All._initialize then
    return
  end
  local stc_titleBar = UI.getChildControl(Panel_Window_GameExit_All, "Static_TitleBar")
  local stc_mainBg = UI.getChildControl(Panel_Window_GameExit_All, "Static_MainBg")
  self._ui._stc_block = UI.getChildControl(Panel_Window_GameExit_All, "Static_BlackBG")
  self._ui._stc_mainBg = stc_mainBg
  self._ui._stc_functionGroup = UI.getChildControl(Panel_Window_GameExit_All, "Static_FunctionBTN")
  self._ui._pc._btn_close = UI.getChildControl(stc_titleBar, "Button_Close_PCUI")
  self._ui._pc._btn_qeustion = UI.getChildControl(stc_titleBar, "Button_Qeustion_PCUI")
  self._ui._pc._chk_listToggle = UI.getChildControl(stc_titleBar, "CheckButton_ListToggle")
  self._ui._pc._btn_tray = UI.getChildControl(self._ui._stc_functionGroup, "Button_Tray_PCUI")
  self._ui._pc._btn_leftArrow = UI.getChildControl(stc_mainBg, "Button_Left_PCUI")
  self._ui._pc._btn_rightArrow = UI.getChildControl(stc_mainBg, "Button_Right_PCUI")
  self._ui._console._btn_LB = UI.getChildControl(stc_mainBg, "Button_LB_ConsoleUI")
  self._ui._console._btn_RB = UI.getChildControl(stc_mainBg, "Button_RB_ConsoleUI")
  self._ui._console._btn_changeAccount = UI.getChildControl(self._ui._stc_functionGroup, "Button_ChangeAccount_ConsoleUI")
  self._ui._console._stc_keyGuideBg = UI.getChildControl(Panel_Window_GameExit_All, "Static_KeyGuideBg_ConsoleUI")
  self._ui._console._rdo_X = UI.getChildControl(self._ui._console._stc_keyGuideBg, "Radiobutton_X_ConsoleUI")
  self._ui._console._rdo_Y = UI.getChildControl(self._ui._console._stc_keyGuideBg, "Radiobutton_Y_ConsoleUI")
  self._ui._console._rdo_A = UI.getChildControl(self._ui._console._stc_keyGuideBg, "Radiobutton_A_ConsoleUI")
  self._ui._console._rdo_B = UI.getChildControl(self._ui._console._stc_keyGuideBg, "Radiobutton_B_ConsoleUI")
  self._ui._console._rdo_X:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_TOGGLE_SHOW"))
  self._ui._btn_gameExit = UI.getChildControl(self._ui._stc_functionGroup, "Button_GameExit")
  self._ui._btn_serverChange = UI.getChildControl(self._ui._stc_functionGroup, "Button_ServerChange")
  self._ui._btn_selectCharacter = UI.getChildControl(self._ui._stc_functionGroup, "Button_SelectCharacter")
  self._ui._stc_connectedCharLine = UI.getChildControl(stc_mainBg, "Static_ConnectedCharLine")
  local stc_characterSlot = UI.getChildControl(stc_mainBg, "RadioButton_SlotTemplate")
  self._ui._copyUICharacterSlot._stc_characterSlot = stc_characterSlot
  self._ui._copyUICharacterSlot._stc_picture = UI.getChildControl(stc_characterSlot, "Static_Picture")
  self._ui._copyUICharacterSlot._stc_charSlotShadow = UI.getChildControl(stc_characterSlot, "Static_CharSoltShadow")
  self._ui._copyUICharacterSlot._stc_charSlotUnderLine = UI.getChildControl(stc_characterSlot, "Static_CharSoltUnderLine")
  self._ui._copyUICharacterSlot._txt_level = UI.getChildControl(stc_characterSlot, "StaticText_Lv")
  self._ui._copyUICharacterSlot._txt_name = UI.getChildControl(stc_characterSlot, "StaticText_Name")
  self._ui._copyUICharacterSlot._txt_location = UI.getChildControl(stc_characterSlot, "StaticText_Location")
  self._ui._copyUICharacterSlot._txt_enchantFailCount = UI.getChildControl(stc_characterSlot, "StaticText_EnchantFailCount")
  self._ui._copyUICharacterSlot._txt_energy = UI.getChildControl(stc_characterSlot, "StaticText_Energy")
  self._ui._copyUICharacterSlot._txt_changePicture_console = UI.getChildControl(stc_characterSlot, "StaticText_ChangePicture_ConsoleUI")
  self._ui._copyUICharacterSlot._txt_contidion = UI.getChildControl(stc_characterSlot, "StaticText_Contidion")
  self._ui._copyUICharacterSlot._txt_remindTime = UI.getChildControl(stc_characterSlot, "StaticText_RemindTime")
  self._ui._copyUICharacterSlot._btn_change_pc = UI.getChildControl(stc_characterSlot, "Button_Change_PCUI")
  self._ui._copyUICharacterSlot._btn_takePicture_pc = UI.getChildControl(stc_characterSlot, "Button_TakePicture_PCUI")
  self._ui._copyUICharacterSlot._stc_photoIcon = UI.getChildControl(self._ui._copyUICharacterSlot._btn_takePicture_pc, "Static_PhotoIcon")
  self._ui._copyUICharacterSlot._btn_move_pc = UI.getChildControl(stc_characterSlot, "Button_Move_PCUI")
  self._ui._copyUICharacterSlot._btn_inven_pc = UI.getChildControl(stc_characterSlot, "Button_Inven_PCUI")
  self._ui._copyUICharacterSlot._stc_invenIcon = UI.getChildControl(self._ui._copyUICharacterSlot._btn_inven_pc, "Static_InvenIcon")
  self._ui._copyUICharacterSlot._txt_servantIcon = UI.getChildControl(stc_characterSlot, "StaticText_ServantIcon")
  self._ui._copyUICharacterSlot._stc_classIcon = UI.getChildControl(stc_characterSlot, "StaticText_ClassIcon")
  self._ui._copyUICharacterSlot._stc_seasonIcon = UI.getChildControl(stc_characterSlot, "StaticText_Season")
  self._ui._copyUICharacterSlot._stc_seasonIcon:SetShow(false)
  local stc_bottom = UI.getChildControl(Panel_Window_GameExit_All, "Static_Bottom")
  self._stc_bottomBg = stc_bottom
  self._ui._stc_questIcon = UI.getChildControl(stc_bottom, "StaticText_QuestIcon")
  self._ui._txt_questTitle = UI.getChildControl(stc_bottom, "StaticText_QuestTitle")
  self._ui._txt_questList = UI.getChildControl(stc_bottom, "StaticText_QuestList")
  self._ui._txt_questList2 = UI.getChildControl(stc_bottom, "StaticText_QuestList2")
  self._ui._stc_logIcon = UI.getChildControl(stc_bottom, "StaticText_LogIcon")
  self._ui._txt_logTitle = UI.getChildControl(stc_bottom, "StaticText_LogTitle")
  self._ui._frame_todayMyChallenge = UI.getChildControl(stc_bottom, "Frame_TodayMyChallenge")
  self._ui._frame_contents = UI.getChildControl(self._ui._frame_todayMyChallenge, "Frame_1_Content")
  self._ui._scroll_frame = UI.getChildControl(self._ui._frame_todayMyChallenge, "Frame_Scroll_TodayMyChallenge")
  self._ui._txt_frameContents = UI.getChildControl(stc_bottom, "StaticText_TodayMyChallenge_Contents")
  self._ui._frame_todayMyChallenge:SetIgnore(not self._isConsole)
  self._ui._stc_allCharList = UI.getChildControl(Panel_Window_GameExit_All, "Static_AllCharList")
  self._ui._stc_charInfo = UI.getChildControl(self._ui._stc_allCharList, "Static_CharInfo")
  self._ui._charInfo._stc_classMarkIcon = UI.getChildControl(self._ui._stc_charInfo, "Static_ClassMarkIcon")
  self._ui._charInfo._txt_level = UI.getChildControl(self._ui._stc_charInfo, "StaticText_Lv")
  self._ui._charInfo._txt_name = UI.getChildControl(self._ui._stc_charInfo, "StaticText_Name")
  self._ui._charInfo._txt_location = UI.getChildControl(self._ui._stc_charInfo, "StaticText_Location")
  self._ui._charInfo._txt_contidion = UI.getChildControl(self._ui._stc_charInfo, "StaticText_Contidion")
  self._ui._charInfo._txt_remindTime = UI.getChildControl(self._ui._stc_charInfo, "StaticText_RemindTime")
  self._ui._charInfo._btn_takePicture_pc = UI.getChildControl(self._ui._stc_charInfo, "Button_TakePicture_PCUI")
  self._ui._charInfo._btn_move_pc = UI.getChildControl(self._ui._stc_charInfo, "Button_Move_PCUI")
  self._ui._charInfo._btn_inven_pc = UI.getChildControl(self._ui._stc_charInfo, "Button_Inven_PCUI")
  self._ui._charInfo._btn_change_pc = UI.getChildControl(self._ui._stc_charInfo, "Button_Change_PCUI")
  if self._isConsole then
    local posX = self._ui._stc_charInfo:GetSizeX() - self._ui._charInfo._txt_contidion:GetSizeX() - 20
    self._ui._charInfo._txt_contidion:SetPosX(posX)
    self._ui._charInfo._txt_remindTime:SetPosX(posX)
  end
  self._ui._stc_charList = UI.getChildControl(self._ui._stc_allCharList, "Static_CharList")
  self._ui._charList._stc_characterSlot = UI.getChildControl(self._ui._stc_charList, "RadioButton_SlotTemplate")
  self._ui._charList._stc_picture = UI.getChildControl(self._ui._charList._stc_characterSlot, "Static_Picture")
  self._ui._charList._stc_charSlotShadow = UI.getChildControl(self._ui._charList._stc_characterSlot, "Static_CharSoltShadow")
  self._ui._charList._txt_enchantFailCount = UI.getChildControl(self._ui._charList._stc_characterSlot, "StaticText_EnchantFailCount")
  self._ui._charList._txt_energy = UI.getChildControl(self._ui._charList._stc_characterSlot, "StaticText_Energy")
  self._ui._charList._txt_servantIcon = UI.getChildControl(self._ui._charList._stc_characterSlot, "StaticText_ServantIcon")
  self._ui._charList._stc_emptyIcon = UI.getChildControl(self._ui._charList._stc_characterSlot, "Static_Empty")
  self._ui._charList._stc_seasonIcon = UI.getChildControl(self._ui._charList._stc_characterSlot, "Static_SeasonIcon")
  self._ui._charList._stc_seasonIcon:SetShow(false)
  self._ui._stc_connectedCharList = UI.getChildControl(self._ui._stc_charList, "Static_ConnectedCharLine")
  self._ui._stc_selectImage = UI.getChildControl(self._ui._stc_charList, "Static_Select")
  if false == self._isConsole and false == _ContentsGroup_NewUI_TrayConfirm_All then
    self._ui._tray._txt_title = UI.getChildControl(Panel_ExitConfirm_Old, "StaticText_Title")
    self._ui._tray._btn_confirm = UI.getChildControl(Panel_ExitConfirm_Old, "Button_Confirm")
    self._ui._tray._btn_cancel = UI.getChildControl(Panel_ExitConfirm_Old, "Button_Cancle")
    self._ui._tray._chk_tray = UI.getChildControl(Panel_ExitConfirm_Old, "CheckButton_Tray")
    self._ui._tray._txt_trayString = UI.getChildControl(Panel_ExitConfirm_Old, "StaticText_TrayHelp")
    self._ui._tray._txt_contentsString = UI.getChildControl(Panel_ExitConfirm_Old, "StaticText_GameExit")
    self._ui._tray._txt_contentsString:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GAMEEXIT_TRAY_ASK"))
    self._ui._tray._txt_trayString:SetTextMode(__eTextMode_AutoWrap)
    self._ui._tray._txt_trayString:SetAutoResize(true)
    self._ui._tray._txt_trayString:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXITTRAY_TRAYHELP"))
    self._ui._tray._chk_tray:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXITTRAY_CHKTRAY"))
    self._ui._tray._chk_tray:SetEnableArea(0, 0, self._ui._tray._chk_tray:GetSizeX() + self._ui._tray._chk_tray:GetTextSizeX(), self._ui._tray._chk_tray:GetSizeY())
    self._ui._tray._chk_tray:SetPosX(Panel_ExitConfirm_Old:GetSizeX() * 0.5 - self._ui._tray._chk_tray:GetTextSizeX() * 0.5 - 20)
    Panel_ExitConfirm_Old:setMaskingChild(true)
    Panel_ExitConfirm_Old:ActiveMouseEventEffect(true)
    Panel_ExitConfirm_Old:setGlassBackground(true)
    Panel_ExitConfirm_Old:SetShow(false)
  end
  self._ui._frame_contents:AddChild(self._ui._txt_frameContents)
  stc_bottom:RemoveControl(self._ui._txt_frameContents)
  self._ui._txt_frameContents:SetAutoResize(true)
  self._ui._txt_frameContents:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_frameContents:SetPosX(0)
  self._ui._txt_frameContents:SetPosY(0)
  self._panelSizeY = Panel_Window_GameExit_All:GetSizeY()
  self._GroupSpanSizeY = self._ui._stc_functionGroup:GetSpanSize().y
  self._config.slotSizeX = self._ui._charList._stc_characterSlot:GetSizeX()
  self._config.slotSizeY = self._ui._charList._stc_characterSlot:GetSizeY()
  self._isValksContensOption = ToClient_IsContentsGroupOpen("47")
  local isValue = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eGameExitCharacterListWindow)
  if false == isValue then
    self._eViewType = self._eType._basic
  else
    self._eViewType = self._eType._all
  end
  PaGlobal_GameExit_All:initShowHide()
  PaGlobal_GameExit_All:createCopySlot_basic()
  PaGlobal_GameExit_All:createCopySlot_all()
  self:initCharacterInfo()
  self:alignKeyGuides()
  if true == self._isConsole then
    self:updateCharacterSlot_all()
  end
  PaGlobal_GameExit_All:registEventHandler()
  PaGlobal_GameExit_All:validate()
  PaGlobal_GameExit_All._initialize = true
end
function PaGlobal_GameExit_All:registEventHandler()
  if nil == Panel_Window_GameExit_All then
    return
  end
  Panel_Window_GameExit_All:RegisterShowEventFunc(true, "PaGlobal_GameExit_ALL_ShowAni()")
  Panel_Window_GameExit_All:RegisterShowEventFunc(false, "PaGlobal_GameExit_ALL_HideAni()")
  registerEvent("EventGameWindowClose", "FromClient_GameExit_All_WindowClose")
  registerEvent("FromClient_RecentJournal_Update", "FromClient_GameExit_All_RecentJournalUpdate")
  registerEvent("EventReceiveEnterWating", "FromClient_GameExit_All_UpdateSlot")
  registerEvent("FromClient_TrayIconMessageBox", "FromClient_GameExit_All_TrayIconMessageBox")
  registerEvent("FromClient_ResponseEnchantFailCountOfMyCharacters", "FromClient_GameExit_All_UpdateSlot")
  registerEvent("onScreenResize", "FromClient_GameExit_All_OnScreenResize")
  self._ui._btn_gameExit:addInputEvent("Mouse_LUp", "HandleEventLUp_GameExit_All_GameExit()")
  self._ui._btn_serverChange:addInputEvent("Mouse_LUp", "HandleEventLUp_GameExit_All_ServerChange()")
  self._ui._btn_selectCharacter:addInputEvent("Mouse_LUp", "HandleEventLUp_GameExit_All_CharacterSelect()")
  self._ui._pc._btn_tray:addInputEvent("Mouse_LUp", "HandleEventLUp_GameExit_All_Tray()")
  if false == self._isConsole then
    self._ui._charInfo._btn_takePicture_pc:addInputEvent("Mouse_LUp", "HandleEventLUp_GameExit_All_ForFacePhoto()")
    self._ui._charInfo._btn_move_pc:addInputEvent("Mouse_LUp", "HandleEventLUp_GameExit_All_Move()")
    self._ui._charInfo._btn_inven_pc:addInputEvent("Mouse_On", "HandleEventOnOut_GameExit_All_ShowSimpleInventoryTooltip(true)")
    self._ui._charInfo._btn_inven_pc:addInputEvent("Mouse_Out", "HandleEventOnOut_GameExit_All_ShowSimpleInventoryTooltip(false)")
    self._ui._charInfo._btn_inven_pc:addInputEvent("Mouse_LUp", "HandleEventLUp_GameExit_All_SimpleInventory()")
    self._ui._charInfo._btn_change_pc:addInputEvent("Mouse_LUp", "HandleEventLUp_GameExit_All_ChangeCharacter()")
    self._ui._pc._chk_listToggle:addInputEvent("Mouse_On", "HandleEventOn_GameExit_All_listToggleTooltip()")
    self._ui._pc._chk_listToggle:addInputEvent("Mouse_Out", "HandleEventOut_GameExit_All_listToogleTooltipHide()")
    self._ui._pc._btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_GameExit_All_Close()")
    self._ui._pc._btn_qeustion:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelGameExit\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui._pc._btn_qeustion, "\"PanelGameExit\"")
    self._ui._pc._chk_listToggle:addInputEvent("Mouse_LUp", "HandleEventLUp_GameExit_All_listToggle()")
    self._ui._pc._btn_tray:addInputEvent("Mouse_On", "HandleEventOnOut_GameExit_All_SimpleTooltip(true, 0, 2)")
    self._ui._pc._btn_tray:addInputEvent("Mouse_Out", "HandleEventOnOut_GameExit_All_SimpleTooltip(false)")
    self._ui._pc._btn_tray:setButtonShortcuts("PANEL_GAMEEXIT_TRAYWINDOW")
    if false == _ContentsGroup_NewUI_TrayConfirm_All then
      self._ui._tray._btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_GameExit_All_TrayConfirm()")
      self._ui._tray._btn_cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_GameExit_All_TrayCancel()")
    end
  else
    self._ui._console._btn_changeAccount:addInputEvent("Mouse_LUp", "HandleEventLUp_GameExit_All_ChangeAccount()")
    Panel_Window_GameExit_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_GameExit_All_listToggle()")
    Panel_Window_GameExit_All:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "PaGlobal_GameExit_All_SetChallengeScroll(true)")
    Panel_Window_GameExit_All:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "PaGlobal_GameExit_All_SetChallengeScroll(false)")
    self._ui._btn_gameExit:addInputEvent("Mouse_On", "HandleEventOn_GameExit_All_UpdateKeyGuide(true, false)")
    self._ui._btn_serverChange:addInputEvent("Mouse_On", "HandleEventOn_GameExit_All_UpdateKeyGuide(true, false)")
    self._ui._btn_selectCharacter:addInputEvent("Mouse_On", "HandleEventOn_GameExit_All_UpdateKeyGuide(true, false)")
    self._ui._console._btn_changeAccount:addInputEvent("Mouse_On", "HandleEventOn_GameExit_All_UpdateKeyGuide(true, false)")
  end
end
function PaGlobal_GameExit_All:prepareOpen()
  if nil == Panel_Window_GameExit_All then
    return
  end
  if true == Panel_Window_GameExit_All:GetShow() then
    return
  end
  self._prevUIMode = GetUIMode()
  SetUIMode(Defines.UIMode.eUIMode_GameExit)
  PaGlobal_GameExit_All:open()
  local sizeX = getScreenSizeX() + 500
  local sizeY = getScreenSizeY() + 500
  self._ui._stc_block:SetSize(sizeX, sizeY)
  self._ui._stc_block:ComputePos()
  sendWaitingListOfMyCharacters()
  if true == self._isExitPhoto then
    self:updateCharacterSlot(self._photoIndex + 1)
  else
    self:updateCharacterSlot(0)
  end
  self:updateCharacterSlot_all()
  self._isExitPhoto = false
  self:selectCharacter_all(0)
  self:initListToggle()
  self:updateListToggle()
  ToClient_RequestRecentJournalByCount(5)
  ToClient_RequestCharacterEnchantFailCount()
  self:updateLastCompleteQuest()
  local selfProxy = getSelfPlayer()
  local characterNo_64 = toInt64(0, 0)
  if nil ~= selfProxy then
    characterNo_64 = selfProxy:getCharacterNo_64()
  end
  local uiCount = 0
  self._ui._stc_connectedCharLine:SetShow(false)
  for index = 0, self._totalCharacterSlot - 1 do
    local characterData = getCharacterDataByIndex(index)
    if nil == characterData then
      return
    end
    if characterNo_64 == characterData._characterNo_s64 then
      self._ui._stc_connectedCharLine:SetShow(true)
      self._ui._stc_connectedCharLine:SetPosX(self._basic._stc_characterSlotPool[index]:GetPosX())
      self._ui._stc_connectedCharLine:SetPosY(self._basic._stc_characterSlotPool[index]:GetPosY())
    else
      self._basic._stc_picturePool[index]:ResetVertexAni()
      if false == self._isConsole then
        self._basic._btn_invenPool[index]:SetShow(false)
        self._basic._btn_change_pcPool[index]:SetShow(false)
      end
    end
    if 4 == uiCount then
      break
    end
    uiCount = uiCount + 1
  end
end
function PaGlobal_GameExit_All:open()
  if nil == Panel_Window_GameExit_All then
    return
  end
  Panel_Window_GameExit_All:SetShow(true, true)
end
function PaGlobal_GameExit_All:prepareClose()
  if nil == Panel_Window_GameExit_All then
    return
  end
  if false == Panel_Window_GameExit_All:GetShow() then
    return
  end
  if nil ~= Panel_Window_SimpleInventory and true == Panel_Window_SimpleInventory:IsShow() then
    PaGlobal_SimpleInventory:close()
    return
  end
  TooltipSimple_Hide()
  SetUIMode(self._prevUIMode)
  if -1 ~= self._exitMode then
    self:sendGameDelayExitCancel()
  end
  if false == self._isConsole then
    PaGlobal_ExitConfirm_All_Close()
  end
  PaGlobal_GameExit_All:close()
end
function PaGlobal_GameExit_All:close()
  if nil == Panel_Window_GameExit_All then
    return
  end
  Panel_Window_GameExit_All:SetShow(false, true)
end
function PaGlobal_GameExit_All:validate()
  if nil == Panel_Window_GameExit_All then
    return
  end
  self._ui._pc._btn_close:isValidate()
  self._ui._pc._btn_qeustion:isValidate()
  self._ui._pc._chk_listToggle:isValidate()
  self._ui._pc._btn_tray:isValidate()
  self._ui._pc._btn_leftArrow:isValidate()
  self._ui._pc._btn_rightArrow:isValidate()
  self._ui._console._btn_LB:isValidate()
  self._ui._console._btn_RB:isValidate()
  self._ui._console._btn_changeAccount:isValidate()
  self._ui._console._stc_keyGuideBg:isValidate()
  self._ui._console._rdo_X:isValidate()
  self._ui._console._rdo_Y:isValidate()
  self._ui._console._rdo_A:isValidate()
  self._ui._console._rdo_B:isValidate()
  self._ui._btn_gameExit:isValidate()
  self._ui._btn_serverChange:isValidate()
  self._ui._btn_selectCharacter:isValidate()
  self._ui._stc_connectedCharLine:isValidate()
  self._ui._copyUICharacterSlot._stc_characterSlot:isValidate()
  self._ui._copyUICharacterSlot._stc_picture:isValidate()
  self._ui._copyUICharacterSlot._stc_charSlotShadow:isValidate()
  self._ui._copyUICharacterSlot._stc_charSlotUnderLine:isValidate()
  self._ui._copyUICharacterSlot._txt_level:isValidate()
  self._ui._copyUICharacterSlot._txt_name:isValidate()
  self._ui._copyUICharacterSlot._txt_location:isValidate()
  self._ui._copyUICharacterSlot._txt_enchantFailCount:isValidate()
  self._ui._copyUICharacterSlot._txt_energy:isValidate()
  self._ui._copyUICharacterSlot._txt_changePicture_console:isValidate()
  self._ui._copyUICharacterSlot._txt_contidion:isValidate()
  self._ui._copyUICharacterSlot._txt_remindTime:isValidate()
  self._ui._copyUICharacterSlot._btn_change_pc:isValidate()
  self._ui._copyUICharacterSlot._btn_takePicture_pc:isValidate()
  self._ui._copyUICharacterSlot._stc_photoIcon:isValidate()
  self._ui._copyUICharacterSlot._btn_move_pc:isValidate()
  self._ui._copyUICharacterSlot._btn_inven_pc:isValidate()
  self._ui._copyUICharacterSlot._stc_invenIcon:isValidate()
  self._ui._copyUICharacterSlot._txt_servantIcon:isValidate()
  self._ui._copyUICharacterSlot._stc_seasonIcon:isValidate()
  self._ui._stc_questIcon:isValidate()
  self._ui._txt_questTitle:isValidate()
  self._ui._txt_questList:isValidate()
  self._ui._txt_questList2:isValidate()
  self._ui._stc_logIcon:isValidate()
  self._ui._txt_logTitle:isValidate()
  self._ui._frame_todayMyChallenge:isValidate()
  self._ui._frame_contents:isValidate()
  self._ui._scroll_frame:isValidate()
  self._ui._txt_frameContents:isValidate()
  self._ui._stc_allCharList:isValidate()
  self._ui._stc_charInfo:isValidate()
  self._ui._charInfo._stc_classMarkIcon:isValidate()
  self._ui._charInfo._txt_level:isValidate()
  self._ui._charInfo._txt_name:isValidate()
  self._ui._charInfo._txt_location:isValidate()
  self._ui._charInfo._txt_contidion:isValidate()
  self._ui._charInfo._txt_remindTime:isValidate()
  self._ui._charInfo._btn_takePicture_pc:isValidate()
  self._ui._charInfo._btn_move_pc:isValidate()
  self._ui._charInfo._btn_inven_pc:isValidate()
  self._ui._charInfo._btn_change_pc:isValidate()
  self._ui._stc_charList:isValidate()
  self._ui._charList._stc_characterSlot:isValidate()
  self._ui._charList._stc_picture:isValidate()
  self._ui._charList._stc_charSlotShadow:isValidate()
  self._ui._charList._txt_enchantFailCount:isValidate()
  self._ui._charList._txt_energy:isValidate()
  self._ui._charList._txt_servantIcon:isValidate()
  self._ui._charList._stc_emptyIcon:isValidate()
  self._ui._stc_connectedCharList:isValidate()
  self._ui._stc_selectImage:isValidate()
end
function PaGlobal_GameExit_All:alignKeyGuides()
  if true == self._isConsole then
    local keyGuides = {
      self._ui._console._rdo_X,
      self._ui._console._rdo_Y,
      self._ui._console._rdo_A,
      self._ui._console._rdo_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._console._stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
end
function PaGlobal_GameExit_All:updateKeyGuide(isNormalButton, isCurrentCharacter)
  self._ui._console._rdo_A:SetShow(true)
  if true == isNormalButton then
    self._ui._console._rdo_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CONFIRM"))
    self._ui._console._rdo_Y:SetShow(false)
  elseif true == isCurrentCharacter then
    self._ui._console._rdo_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "GAMEEXIT_MOVECHARACTER"))
    self._ui._console._rdo_Y:SetShow(false)
  else
    self._ui._console._rdo_A:SetText(PAGetString(Defines.StringSheet_GAME, "GAMEEXIT_SWAP_CHARACTER_TITLE"))
    self._ui._console._rdo_Y:SetShow(true)
  end
  PaGlobal_GameExit_All:alignKeyGuides()
end
function PaGlobal_GameExit_All:alignFucntionButtons()
end
function PaGlobal_GameExit_All:initShowHide()
  local isConsoleShow = true == self._isConsole
  local isPcShow = not isConsoleShow
  local isPS4 = ToClient_isPS4()
  self._ui._console._btn_LB:SetShow(isConsoleShow)
  self._ui._console._btn_RB:SetShow(isConsoleShow)
  self._ui._console._stc_keyGuideBg:SetShow(isConsoleShow)
  self._ui._charInfo._btn_takePicture_pc:SetShow(isPcShow)
  self._ui._charInfo._btn_move_pc:SetShow(isPcShow)
  self._ui._charInfo._btn_inven_pc:SetShow(isPcShow)
  self._ui._charInfo._btn_change_pc:SetShow(isPcShow)
  self._ui._pc._btn_close:SetShow(isPcShow)
  self._ui._pc._btn_qeustion:SetShow(isPcShow)
  self._ui._pc._chk_listToggle:SetShow(isPcShow)
  self._ui._pc._btn_tray:SetShow(not _ContentsGroup_RenewUI)
  self._ui._pc._btn_leftArrow:SetShow(isPcShow)
  self._ui._pc._btn_rightArrow:SetShow(isPcShow)
  self._ui._console._btn_changeAccount:SetShow(not isPS4 and _ContentsGroup_RenewUI)
  if true == isPS4 then
    self._ui._btn_selectCharacter:SetSpanSize(-230, 0)
    self._ui._btn_serverChange:SetSpanSize(0, 0)
    self._ui._btn_gameExit:SetSpanSize(230, 0)
  end
end
function PaGlobal_GameExit_All:createCopySlot_basic()
  local copySlot = self._ui._copyUICharacterSlot
  local startPos = copySlot._stc_characterSlot:GetPosX()
  for idx = 0, self._totalCharacterSlot - 1 do
    local slotMain = UI.createControl(__ePAUIControl_RadioButton, self._ui._stc_mainBg, "Static_Slot_" .. idx)
    CopyBaseProperty(copySlot._stc_characterSlot, slotMain)
    slotMain:SetShow(true)
    slotMain:SetPosX(startPos + idx * (slotMain:GetSizeX() + 5))
    self._basic._stc_characterSlotPool[idx] = slotMain
    local charImage = UI.createControl(__ePAUIControl_Static, slotMain, "Static_CharImage_" .. idx)
    CopyBaseProperty(copySlot._stc_picture, charImage)
    charImage:SetShow(false)
    self._basic._stc_picturePool[idx] = charImage
    local slotShadow = UI.createControl(__ePAUIControl_Static, slotMain, "Static_SlotShadow_" .. idx)
    CopyBaseProperty(copySlot._stc_charSlotShadow, slotShadow)
    slotShadow:SetShow(false)
    self._basic._stc_charSlotShowPool[idx] = slotShadow
    local slotUnderLine = UI.createControl(__ePAUIControl_Static, slotMain, "Static_SlotUnderLine_" .. idx)
    CopyBaseProperty(copySlot._stc_charSlotUnderLine, slotUnderLine)
    slotUnderLine:SetShow(false)
    self._basic._stc_charSlotUnderLinePool[idx] = slotUnderLine
    local charLevel = UI.createControl(__ePAUIControl_StaticText, slotMain, "StaticText_CharLevel_" .. idx)
    CopyBaseProperty(copySlot._txt_level, charLevel)
    charLevel:SetShow(false)
    self._basic._txt_levelPool[idx] = charLevel
    local charName = UI.createControl(__ePAUIControl_StaticText, slotMain, "StaticText_CharName_" .. idx)
    CopyBaseProperty(copySlot._txt_name, charName)
    charName:SetShow(false)
    charName:SetTextMode(__eTextMode_AutoWrap)
    self._basic._txt_namePool[idx] = charName
    local location = UI.createControl(__ePAUIControl_StaticText, slotMain, "StaticText_Location_" .. idx)
    CopyBaseProperty(copySlot._txt_location, location)
    location:SetShow(false)
    self._basic._txt_locationPool[idx] = location
    local enchantFailCount = UI.createControl(__ePAUIControl_StaticText, slotMain, "StaticText_EnchantFail_" .. idx)
    CopyBaseProperty(copySlot._txt_enchantFailCount, enchantFailCount)
    enchantFailCount:SetShow(false)
    self._basic._txt_enchantFailCountPool[idx] = enchantFailCount
    local energy = UI.createControl(__ePAUIControl_StaticText, slotMain, "StaticText_Energy_" .. idx)
    CopyBaseProperty(copySlot._txt_energy, energy)
    energy:SetShow(false)
    self._basic._txt_energyPool[idx] = energy
    if true == self._isConsole then
      local changePicture = UI.createControl(__ePAUIControl_Button, slotMain, "StaticText_ChangePicture_" .. idx)
      CopyBaseProperty(copySlot._txt_changePicture_console, changePicture)
      changePicture:SetShow(false)
      self._basic._txt_changePicture_consolePool[idx] = changePicture
      local x1, y1, x2, y2 = setTextureUV_Func(slotMain, 307, 1, 357, 51)
      slotMain:getOnTexture():setUV(x1, y1, x2, y2)
      local x1, y1, x2, y2 = setTextureUV_Func(slotMain, 358, 1, 408, 51)
      slotMain:getClickTexture():setUV(x1, y1, x2, y2)
    else
      local changeButton = UI.createControl(__ePAUIControl_Button, slotMain, "Button_Change_" .. idx)
      CopyBaseProperty(copySlot._btn_change_pc, changeButton)
      changeButton:SetShow(false)
      self._basic._btn_change_pcPool[idx] = changeButton
      local takePicture = UI.createControl(__ePAUIControl_Button, slotMain, "Button_TakePicture_" .. idx)
      CopyBaseProperty(copySlot._btn_takePicture_pc, takePicture)
      takePicture:SetShow(false)
      self._basic._btn_takePicture_pcPool[idx] = takePicture
      local photoIcon = UI.createControl(__ePAUIControl_Static, takePicture, "Static_PhotoIcon_" .. idx)
      CopyBaseProperty(copySlot._stc_photoIcon, photoIcon)
      photoIcon:SetShow(true)
      local moveButton = UI.createControl(__ePAUIControl_Button, slotMain, "Button_Move_" .. idx)
      CopyBaseProperty(copySlot._btn_move_pc, moveButton)
      moveButton:SetShow(false)
      self._basic._btn_move_pcPool[idx] = moveButton
      local inven = UI.createControl(__ePAUIControl_Button, slotMain, "Button_Inven_" .. idx)
      CopyBaseProperty(copySlot._btn_inven_pc, inven)
      inven:SetShow(false)
      self._basic._btn_invenPool[idx] = inven
      local invenIcon = UI.createControl(__ePAUIControl_Static, inven, "Static_InvenIcon_" .. idx)
      CopyBaseProperty(copySlot._stc_invenIcon, invenIcon)
      invenIcon:SetShow(true)
    end
    local contidion = UI.createControl(__ePAUIControl_StaticText, slotMain, "StaticText_Contidion_" .. idx)
    CopyBaseProperty(copySlot._txt_contidion, contidion)
    contidion:SetShow(false)
    contidion:SetIgnore(self._isConsole)
    self._basic._txt_contidionPool[idx] = contidion
    local remindTime = UI.createControl(__ePAUIControl_StaticText, slotMain, "StaticText_RemindTime_" .. idx)
    CopyBaseProperty(copySlot._txt_remindTime, remindTime)
    remindTime:SetShow(false)
    self._basic._txt_remindTimePool[idx] = remindTime
    local classIcon = UI.createControl(__ePAUIControl_StaticText, slotMain, "Static_ClassIcon_" .. idx)
    CopyBaseProperty(copySlot._stc_classIcon, classIcon)
    classIcon:SetShow(false)
    classIcon:SetIgnore(true)
    self._basic._stc_classIconPool[idx] = classIcon
    if true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason then
      local seasonIcon = UI.createControl(__ePAUIControl_StaticText, slotMain, "StaticText_SeasonIcon_.." .. idx)
      CopyBaseProperty(copySlot._stc_seasonIcon, seasonIcon)
      seasonIcon:SetShow(false)
      self._basic._stc_seasonIconPool[idx] = seasonIcon
    end
    if nil == self._basic._txt_servantIconPool[idx] then
      self._basic._txt_servantIconPool[idx] = {}
    end
    for servantIdx = 0, self._eServantView.max do
      local servantView = UI.createControl(__ePAUIControl_StaticText, slotMain, "Static_ServantView_" .. idx .. servantIdx)
      CopyBaseProperty(copySlot._txt_servantIcon, servantView)
      servantView:SetShow(false)
      servantView:ComputePos()
      servantView:SetPosY(servantView:GetSizeY() * servantIdx)
      self._basic._txt_servantIconPool[idx][servantIdx] = servantView
    end
  end
  for _, value in pairs(copySlot) do
    value:SetShow(false)
  end
  self._ui._stc_mainBg:SetChildIndex(self._ui._stc_connectedCharLine, 9999)
end
function PaGlobal_GameExit_All:createCopySlot_all()
  local copySlot = self._ui._charList
  local totalCount = self._config.slotCols * self._config.slotRows
  for idx = 0, totalCount - 1 do
    local row = math.floor(idx / self._config.slotCols)
    local col = math.floor(idx % self._config.slotCols)
    local slotMain = UI.createControl(__ePAUIControl_RadioButton, self._ui._stc_charList, "Static_Slot_" .. idx)
    CopyBaseProperty(copySlot._stc_characterSlot, slotMain)
    slotMain:SetShow(true)
    slotMain:SetPosX(self._config.slotStartX + col * (self._config.slotSizeX + self._config.slotGapX))
    slotMain:SetPosY(self._config.slotStartY + row * (self._config.slotSizeY + self._config.slotGapY))
    ToClient_padSnapRefreshTarget(slotMain)
    self._all._stc_characterSlotPool[idx] = slotMain
    local charImage = UI.createControl(__ePAUIControl_Static, slotMain, "Static_CharImage_" .. idx)
    CopyBaseProperty(copySlot._stc_picture, charImage)
    charImage:SetShow(false)
    self._all._stc_picturePool[idx] = charImage
    local slotShadow = UI.createControl(__ePAUIControl_Static, slotMain, "Static_SlotShadow_" .. idx)
    CopyBaseProperty(copySlot._stc_charSlotShadow, slotShadow)
    slotShadow:SetShow(false)
    self._all._stc_charSlotShowPool[idx] = slotShadow
    local enchantFailCount = UI.createControl(__ePAUIControl_StaticText, slotMain, "StaticText_EnchantFail_" .. idx)
    CopyBaseProperty(copySlot._txt_enchantFailCount, enchantFailCount)
    enchantFailCount:SetShow(false)
    self._all._txt_enchantFailCountPool[idx] = enchantFailCount
    local energy = UI.createControl(__ePAUIControl_StaticText, slotMain, "StaticText_Energy_" .. idx)
    CopyBaseProperty(copySlot._txt_energy, energy)
    energy:SetShow(false)
    self._all._txt_energyPool[idx] = energy
    if nil == self._all._txt_servantIconPool[idx] then
      self._all._txt_servantIconPool[idx] = {}
    end
    for servantIdx = 0, self._eServantView.max do
      local servantView = UI.createControl(__ePAUIControl_StaticText, slotMain, "Static_ServantView_" .. idx .. servantIdx)
      CopyBaseProperty(copySlot._txt_servantIcon, servantView)
      servantView:SetShow(false)
      servantView:ComputePos()
      servantView:SetPosY(servantView:GetSizeY() * servantIdx)
      self._all._txt_servantIconPool[idx][servantIdx] = servantView
    end
    local emptyIcon = UI.createControl(__ePAUIControl_Static, slotMain, "Static_Empty_" .. idx)
    CopyBaseProperty(copySlot._stc_emptyIcon, emptyIcon)
    emptyIcon:SetShow(true)
    self._all._stc_emptyIconPool[idx] = emptyIcon
    if true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason then
      local seasonIcon = UI.createControl(__ePAUIControl_Static, slotMain, "Static_SeasonIcon" .. idx)
      CopyBaseProperty(copySlot._stc_seasonIcon, seasonIcon)
      seasonIcon:SetShow(false)
      self._all._stc_seasonIconPool[idx] = seasonIcon
    end
  end
  for _, value in pairs(copySlot) do
    value:SetShow(false)
  end
  self._ui._stc_charList:SetChildIndex(self._ui._stc_connectedCharList, 9999)
  self._ui._stc_charList:SetChildIndex(self._ui._stc_selectImage, 9999)
end
function PaGlobal_GameExit_All:showToggle(isAttacked)
  if isDeadInWatchingMode() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXITOPENALERT_INDEAD"))
    return
  end
  if CppEnums.EProcessorInputMode.eProcessorInputMode_ChattingInputMode == UI.Get_ProcessorInputMode() then
    return
  end
  local currentUIMode = GetUIMode()
  if currentUIMode == Defines.UIMode.eUIMode_Gacha_Roulette or currentUIMode == Defines.UIMode.eUIMode_DeadMessage then
    return
  end
  if ToClient_cutsceneIsPlay() then
    return
  end
  if isFlushedUI() then
    return
  end
  if isAttacked then
    return
  end
  if isGameTypeRussia() and isAttacked then
    local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
    if regionInfo:get():isSafeZone() then
      return
    end
  end
  local isShow = Panel_Window_GameExit_All:IsShow()
  if true == isShow then
    self:prepareClose()
  else
    self:prepareOpen()
  end
  if false == self._isConsole then
    PaGlobal_ExitConfirm_All_SetNextReward()
  end
end
function PaGlobal_GameExit_All:sendGameDelayExitCancel()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local regionInfo = getRegionInfoByPosition(selfPlayer:get():getPosition())
  local cancelAble = true
  if self._eExitMode._backCharacter == self._exitMode and true == regionInfo:get():isSafeZone() or self._prevTime < 2 then
    cancelAble = false
  end
  if true == cancelAble then
    sendGameDelayExitCancel()
  end
  self._ui._stc_functionGroup:SetShow(true)
  self._exit_Time = 0
  self._exitMode = self._eExitMode._non
end
function PaGlobal_GameExit_All:updateCharacterSlot(startIdx)
  local selfProxy = getSelfPlayer()
  local characterNo_64 = toInt64(0, 0)
  if nil == startIdx or startIdx < 0 then
    startIdx = 0
  end
  if nil ~= selfProxy then
    characterNo_64 = selfProxy:getCharacterNo_64()
  end
  self._photoIndex = startIdx - 1
  local slotCount = 4
  local endIdx = startIdx + slotCount
  if false == Panel_Window_GameExit_All:IsShow() then
    return
  end
  local uiCount = 0
  local characterDatacount = getCharacterDataCount()
  local serverUtc64 = getServerUtc64()
  local familyCount = getEnchantInformation():ToClient_getBonusStackCount()
  self._nowPlayCharaterSlotNo = nil
  local eventArray = {
    self._basic._stc_picturePool,
    self._basic._stc_characterSlotPool,
    self._basic._txt_enchantFailCountPool,
    self._basic._txt_energyPool,
    self._basic._btn_change_pcPool,
    self._basic._btn_takePicture_pcPool,
    self._basic._btn_move_pcPool,
    self._basic._btn_invenPool
  }
  if true == self._isConsole then
    for index = 0, 3 do
      self._basic._stc_picturePool[index]:SetIgnore(true)
      self._basic._stc_characterSlotPool[index]:SetIgnore(true)
      self._basic._stc_characterSlotPool[index]:SetCheck(false)
    end
  end
  self._ui._stc_connectedCharLine:SetShow(false)
  for idx = startIdx, characterDatacount - 1 do
    if true == self._isConsole then
      self._basic._stc_picturePool[uiCount]:SetIgnore(false)
      self._basic._stc_characterSlotPool[uiCount]:SetIgnore(false)
    end
    local characterData = getCharacterDataByIndex(idx)
    local char_Type = getCharacterClassType(characterData)
    local char_Level = string.format("%d", characterData._level)
    local char_Name = getCharacterName(characterData)
    local char_wp = ToClient_getWpInCharacterDataList(idx)
    local defaultCount = characterData._enchantFailCount
    local valksCount = characterData._valuePackCount
    local char_No_s64 = characterData._characterNo_s64
    local char_TextureName = getCharacterFaceTextureByIndex(idx)
    local char_WorkTxt = ""
    local pcDeliveryRemainTimeText = ""
    local pcDeliveryRegionKey = characterData._arrivalRegionKey
    local isSeasonCharacter = characterData._characterSeasonType == __eCharacterSeasonType_Season
    for i = 0, self._eServantView.max do
      self._basic._txt_servantIconPool[uiCount][i]:SetShow(false)
    end
    local servantIdx = 0
    for eServantIdx = self._eServantView.vehicle, self._eServantView.max do
      local briefServantInfo = ToClient_GetBriefServantInfoByCharacter(characterData, eServantIdx)
      if nil ~= briefServantInfo then
        self:updateServantTexture(self._basic._txt_servantIconPool[uiCount][servantIdx], idx, uiCount, eServantIdx)
        self:addInputEventSlotScroll(self._basic._txt_servantIconPool[uiCount][servantIdx], startIdx, endIdx, characterDatacount)
        servantIdx = servantIdx + 1
      end
    end
    if 0 ~= pcDeliveryRegionKey:get() and serverUtc64 < characterData._arrivalTime then
      char_WorkTxt = PAGetString(Defines.StringSheet_GAME, "CHARACTER_WORKING_TEXT_DELIVERY")
      local remainTime = characterData._arrivalTime - serverUtc64
      pcDeliveryRemainTimeText = convertStringFromDatetime(remainTime)
    else
      char_WorkTxt = PaGlobal_GameExit_All_GetWorkTypeString(characterData._pcWorkingType)
    end
    local regionInfo = getRegionInfoByPosition(characterData._currentPosition)
    self._basic._stc_picturePool[uiCount]:SetShow(true)
    self._basic._stc_charSlotShowPool[uiCount]:SetShow(true)
    local isCaptureExist = self._basic._stc_picturePool[uiCount]:ChangeTextureInfoNameNotDDS(char_TextureName, char_Type, self._isExitPhoto)
    if isCaptureExist == true then
      self._basic._stc_picturePool[uiCount]:getBaseTexture():setUV(0, 0, 1, 1)
    else
      local DefaultFace = CppEnums.ClassType_DefaultFaceTexture[char_Type]
      self._basic._stc_picturePool[uiCount]:ChangeTextureInfoName(DefaultFace[1])
      local x1, y1, x2, y2 = setTextureUV_Func(self._basic._stc_picturePool[uiCount], DefaultFace[2], DefaultFace[3], DefaultFace[4], DefaultFace[5])
      self._basic._stc_picturePool[uiCount]:getBaseTexture():setUV(x1, y1, x2, y2)
    end
    self._basic._stc_picturePool[uiCount]:setRenderTexture(self._basic._stc_picturePool[uiCount]:getBaseTexture())
    self._basic._txt_levelPool[uiCount]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. char_Level)
    self._basic._txt_levelPool[uiCount]:SetEnableArea(0, 0, self._basic._txt_levelPool[uiCount]:GetTextSizeX() + self._basic._txt_levelPool[uiCount]:GetSizeX() + 10, 30)
    self._basic._txt_namePool[uiCount]:SetText(char_Name)
    self._basic._txt_locationPool[uiCount]:SetTextMode(__eTextMode_LimitText)
    if 0 == characterData._currentPosition.x and 0 == characterData._currentPosition.y and 0 == characterData._currentPosition.z then
      self._basic._txt_locationPool[uiCount]:SetText("")
    elseif 0 ~= pcDeliveryRegionKey:get() and serverUtc64 > characterData._arrivalTime then
      local retionInfoArrival = getRegionInfoByRegionKey(pcDeliveryRegionKey)
      self._basic._txt_locationPool[uiCount]:SetText(retionInfoArrival:getAreaName())
    else
      self._basic._txt_locationPool[uiCount]:SetText(regionInfo:getAreaName())
    end
    self._basic._txt_enchantFailCountPool[uiCount]:SetShow(true)
    self._basic._txt_energyPool[uiCount]:SetShow(true)
    self._basic._txt_energyPool[uiCount]:SetText(char_wp)
    if ToClient_IsReceivedEnchantFailCount() then
      self._basic._txt_enchantFailCountPool[uiCount]:SetText(defaultCount + valksCount + familyCount)
    else
      self._basic._txt_enchantFailCountPool[uiCount]:SetText("-")
    end
    local enchantFailCountSpanX = self._basic._txt_enchantFailCountPool[uiCount]:GetTextSizeX() + 10
    self._basic._txt_enchantFailCountPool[uiCount]:SetSpanSize(enchantFailCountSpanX, self._basic._txt_enchantFailCountPool[uiCount]:GetSpanSize().y)
    self._basic._txt_enchantFailCountPool[uiCount]:ComputePos()
    if false == self._isConsole then
      self._basic._txt_enchantFailCountPool[uiCount]:addInputEvent("Mouse_On", "HandleEventOnOut_GameExit_All_SimpleTooltip( true, " .. uiCount .. ", 0," .. defaultCount .. "," .. valksCount .. ", " .. familyCount .. " )")
      self._basic._txt_enchantFailCountPool[uiCount]:addInputEvent("Mouse_Out", "HandleEventOnOut_GameExit_All_SimpleTooltip( false, " .. uiCount .. ", 0 )")
      self._basic._txt_energyPool[uiCount]:addInputEvent("Mouse_On", "HandleEventOnOut_GameExit_All_SimpleTooltip( true, " .. uiCount .. ", 1 )")
      self._basic._txt_energyPool[uiCount]:addInputEvent("Mouse_Out", "HandleEventOnOut_GameExit_All_SimpleTooltip( false, " .. uiCount .. ", 1 )")
      self._basic._stc_picturePool[uiCount]:addInputEvent("Mouse_On", "HandleEventOn_GameExit_All_SlotMouseOver(" .. uiCount .. ")")
      self._basic._stc_characterSlotPool[uiCount]:addInputEvent("Mouse_On", "HandleEventOn_GameExit_All_SlotMouseOver(" .. uiCount .. ")")
      self._basic._stc_characterSlotPool[uiCount]:addInputEvent("Mouse_LDClick", "HandleEventLDClick_GameExit_All_ChangeCharacter_slot(" .. uiCount .. "," .. idx .. ")")
    end
    self._basic._txt_contidionPool[uiCount]:SetShow(true)
    self._basic._txt_remindTimePool[uiCount]:SetShow(true)
    self._basic._txt_levelPool[uiCount]:SetShow(true)
    self._basic._txt_namePool[uiCount]:SetShow(true)
    self._basic._txt_locationPool[uiCount]:SetShow(true)
    self._basic._stc_picturePool[uiCount]:SetIgnore(true)
    self._basic._stc_classIconPool[uiCount]:SetShow(true)
    PaGlobalFunc_Util_ChangeTextureClass(self._basic._stc_classIconPool[uiCount], char_Type)
    local isSeasonCharacter = characterData._characterSeasonType == __eCharacterSeasonType_Season
    if true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason then
      self._basic._stc_seasonIconPool[uiCount]:SetShow(isSeasonCharacter)
      self._basic._stc_seasonIconPool[uiCount]:addInputEvent("Mouse_On", "HandleEventLUp_GameExit_All_SeasonIconTooltip(" .. uiCount .. ", false)")
      self._basic._stc_seasonIconPool[uiCount]:addInputEvent("Mouse_Out", "HandleEventLUp_GameExit_All_SeasonIconTooltip()")
      self._basic._stc_seasonIconPool[uiCount]:SetIgnore(false)
    end
    local isCurrentCharacter = characterNo_64 == characterData._characterNo_s64
    if true == isCurrentCharacter then
      self._basic._txt_contidionPool[uiCount]:SetText("")
      self._basic._txt_contidionPool[uiCount]:SetFontColor(Defines.Color.C_FF6DC6FF)
      self._basic._txt_locationPool[uiCount]:SetShow(false)
      self._basic._txt_remindTimePool[uiCount]:SetText("")
      self:setShowPhoto(uiCount, true)
      self._nowPlayCharaterSlotNo = uiCount
    else
      self._basic._txt_contidionPool[uiCount]:SetText(char_WorkTxt)
      self._basic._txt_contidionPool[uiCount]:SetFontColor(Defines.Color.C_FFE7E7E7)
      self._basic._txt_remindTimePool[uiCount]:SetText(pcDeliveryRemainTimeText)
      local removeTime = getCharacterDataRemoveTime(idx)
      if nil ~= removeTime then
        self._basic._txt_contidionPool[uiCount]:SetText(PAGetString(Defines.StringSheet_GAME, "CHARACTER_DELETING"))
        self._basic._txt_locationPool[uiCount]:SetShow(false)
      else
        self._basic._txt_contidionPool[uiCount]:SetText(char_WorkTxt)
      end
      self:setShowPhoto(uiCount, false)
    end
    self:updateSlot_pc(uiCount, idx, isCurrentCharacter, removeTime)
    self:updateSlot_console(uiCount, idx, isCurrentCharacter, removeTime)
    if true == self._isConsole then
      local snapPlayCharacter = false
      if self._nowPlayCharaterSlotNo == self._nowSnapSlotNo then
        snapPlayCharacter = true
      end
      self:updateKeyGuide(false, snapPlayCharacter)
    end
    for k, v in pairs(eventArray) do
      self:addInputEventSlotScroll(v[uiCount], startIdx, endIdx, characterDatacount)
    end
    uiCount = uiCount + 1
    if slotCount == uiCount then
      break
    end
  end
  if false == self._isConsole then
    if endIdx > characterDatacount - 1 then
      self._ui._pc._btn_rightArrow:addInputEvent("Mouse_LUp", "")
      self._ui._stc_mainBg:addInputEvent("Mouse_DownScroll", "")
      self._ui._pc._btn_rightArrow:SetShow(false)
    else
      self._ui._pc._btn_rightArrow:addInputEvent("Mouse_LUp", "HandleEvent_GameExit_All_UpdateSlot(" .. startIdx + 1 .. ")")
      self._ui._stc_mainBg:addInputEvent("Mouse_DownScroll", "HandleEvent_GameExit_All_UpdateSlot(" .. startIdx + 1 .. " )")
      self._ui._pc._btn_rightArrow:SetShow(true)
    end
    if 0 < startIdx then
      self._ui._pc._btn_leftArrow:addInputEvent("Mouse_LUp", "HandleEvent_GameExit_All_UpdateSlot(" .. startIdx - 1 .. ")")
      self._ui._stc_mainBg:addInputEvent("Mouse_UpScroll", "HandleEvent_GameExit_All_UpdateSlot(" .. startIdx - 1 .. " )")
      self._ui._pc._btn_leftArrow:SetShow(true)
    else
      self._ui._pc._btn_leftArrow:addInputEvent("Mouse_LUp", "")
      self._ui._stc_mainBg:addInputEvent("Mouse_UpScroll", "")
      self._ui._pc._btn_leftArrow:SetShow(false)
    end
  else
    if endIdx > characterDatacount - 1 then
      Panel_Window_GameExit_All:registerPadEvent(__eConsoleUIPadEvent_RB, "")
      self._ui._console._btn_RB:SetShow(false)
    else
      Panel_Window_GameExit_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEvent_GameExit_All_UpdateSlot(" .. startIdx + 1 .. ")")
      self._ui._console._btn_RB:SetShow(true)
    end
    if 0 < startIdx then
      Panel_Window_GameExit_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEvent_GameExit_All_UpdateSlot(" .. startIdx - 1 .. ")")
      self._ui._console._btn_LB:SetShow(true)
    else
      Panel_Window_GameExit_All:registerPadEvent(__eConsoleUIPadEvent_LB, "")
      self._ui._console._btn_LB:SetShow(false)
    end
  end
end
function PaGlobal_GameExit_All:addInputEventSlotScroll(content, startIdx, endIdx, characterDatacount)
  if nil == content then
    _PA_LOG("\236\132\156\234\184\176\236\155\144", "PaGlobal_GameExit_All:addInputEventSlotScroll \237\149\168\236\136\152\236\157\152 content\234\176\128 nil\236\158\133\235\139\136\235\139\164.")
    return
  end
  if endIdx <= characterDatacount - 1 then
    content:addInputEvent("Mouse_DownScroll", "HandleEvent_GameExit_All_UpdateSlot(" .. startIdx + 1 .. ")")
  else
    content:addInputEvent("Mouse_DownScroll", "")
  end
  if 0 < startIdx then
    content:addInputEvent("Mouse_UpScroll", "HandleEvent_GameExit_All_UpdateSlot(" .. startIdx - 1 .. " )")
  else
    content:addInputEvent("Mouse_UpScroll", "")
  end
end
function PaGlobal_GameExit_All:updateCharacterSlot_all()
  local selfProxy = getSelfPlayer()
  local characterNo_64 = toInt64(0, 0)
  if nil ~= selfProxy then
    characterNo_64 = selfProxy:getCharacterNo_64()
  end
  local characterDatacount = getCharacterDataCount()
  local familyCount = getEnchantInformation():ToClient_getBonusStackCount()
  local maxIndex = self._config.slotCols * self._config.slotRows
  for index = 0, maxIndex - 1 do
    self._all._stc_picturePool[index]:SetIgnore(true)
    self._all._stc_characterSlotPool[index]:SetIgnore(true)
  end
  for idx = 0, characterDatacount - 1 do
    self._all._stc_picturePool[idx]:SetIgnore(false)
    self._all._stc_characterSlotPool[idx]:SetIgnore(false)
    local characterData = getCharacterDataByIndex(idx)
    local char_Type = getCharacterClassType(characterData)
    local char_wp = ToClient_getWpInCharacterDataList(idx)
    local defaultCount = characterData._enchantFailCount
    local valksCount = characterData._valuePackCount
    local char_No_s64 = characterData._characterNo_s64
    local char_TextureName = getCharacterFaceTextureByIndex(idx)
    local isCurrentCharacter = characterNo_64 == char_No_s64
    if true == self._isConsole then
      if true == isCurrentCharacter then
        self._all._stc_picturePool[idx]:addInputEvent("Mouse_LUp", "HandleEventLUp_GameExit_All_Move()")
        self._all._stc_characterSlotPool[idx]:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      else
        self._all._stc_picturePool[idx]:addInputEvent("Mouse_LUp", "HandleEventLUp_GameExit_All_ChangeCharacter(" .. idx .. ")")
        self._all._stc_characterSlotPool[idx]:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_GameExit_All_SimpleInventory(" .. idx .. ")")
      end
      self._all._stc_picturePool[idx]:addInputEvent("Mouse_On", "HandleEventLUp_GameExit_All_SelectCharacter_all(" .. idx .. ", " .. tostring(isCurrentCharacter) .. ")")
    else
      self._all._stc_picturePool[idx]:addInputEvent("Mouse_LUp", "HandleEventLUp_GameExit_All_SelectCharacter_all(" .. idx .. ")")
      self._all._stc_picturePool[idx]:addInputEvent("Mouse_LDClick", "HandleEventLDClick_GameExit_All_ChangeCharacter_all(" .. idx .. ")")
    end
    self._all._stc_picturePool[idx]:SetShow(true)
    self._all._stc_charSlotShowPool[idx]:SetShow(true)
    self._all._stc_emptyIconPool[idx]:SetShow(false)
    if true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason then
      self._all._stc_seasonIconPool[idx]:SetShow(false)
    end
    local isCaptureExist = self._all._stc_picturePool[idx]:ChangeTextureInfoNameNotDDS(char_TextureName, char_Type, self._isExitPhoto)
    if isCaptureExist == true then
      self._all._stc_picturePool[idx]:getBaseTexture():setUV(0, 0, 1, 1)
    else
      local DefaultFace = CppEnums.ClassType_DefaultFaceTexture[char_Type]
      self._all._stc_picturePool[idx]:ChangeTextureInfoName(DefaultFace[1])
      local x1, y1, x2, y2 = setTextureUV_Func(self._all._stc_picturePool[idx], DefaultFace[2], DefaultFace[3], DefaultFace[4], DefaultFace[5])
      self._all._stc_picturePool[idx]:getBaseTexture():setUV(x1, y1, x2, y2)
    end
    self._all._stc_picturePool[idx]:setRenderTexture(self._all._stc_picturePool[idx]:getBaseTexture())
    self._all._txt_enchantFailCountPool[idx]:SetShow(true)
    self._all._txt_energyPool[idx]:SetShow(true)
    self._all._txt_energyPool[idx]:SetText(char_wp)
    if ToClient_IsReceivedEnchantFailCount() then
      self._all._txt_enchantFailCountPool[idx]:SetText(defaultCount + valksCount + familyCount)
    else
      self._all._txt_enchantFailCountPool[idx]:SetText("-")
    end
    if false == self._isConsole then
      self._all._txt_enchantFailCountPool[idx]:addInputEvent("Mouse_On", "HandleEventOnOut_GameExit_All_SimpleTooltip( true, " .. idx .. ", 0," .. defaultCount .. "," .. valksCount .. ", " .. familyCount .. " )")
      self._all._txt_enchantFailCountPool[idx]:addInputEvent("Mouse_Out", "HandleEventOnOut_GameExit_All_SimpleTooltip( false, " .. idx .. ", 0 )")
      self._all._txt_energyPool[idx]:addInputEvent("Mouse_On", "HandleEventOnOut_GameExit_All_SimpleTooltip( true, " .. idx .. ", 1 )")
      self._all._txt_energyPool[idx]:addInputEvent("Mouse_Out", "HandleEventOnOut_GameExit_All_SimpleTooltip( false, " .. idx .. ", 1 )")
    end
    for i = 0, self._eServantView.max do
      self._all._txt_servantIconPool[idx][i]:SetShow(false)
    end
    local servantIdx = 0
    for eServantIdx = self._eServantView.vehicle, self._eServantView.max do
      local briefServantInfo = ToClient_GetBriefServantInfoByCharacter(characterData, eServantIdx)
      if nil ~= briefServantInfo then
        self:updateServantTexture(self._all._txt_servantIconPool[idx][servantIdx], idx, idx, eServantIdx)
        servantIdx = servantIdx + 1
      end
    end
    if true == isCurrentCharacter then
      self._ui._stc_connectedCharList:SetShow(true)
      self._ui._stc_connectedCharList:SetPosX(self._all._stc_characterSlotPool[idx]:GetPosX())
      self._ui._stc_connectedCharList:SetPosY(self._all._stc_characterSlotPool[idx]:GetPosY())
    end
    if true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason then
      self._all._stc_seasonIconPool[idx]:SetShow(characterData._characterSeasonType == __eCharacterSeasonType_Season)
      self._all._stc_seasonIconPool[idx]:addInputEvent("Mouse_On", "HandleEventLUp_GameExit_All_SeasonIconTooltip(" .. idx .. ", true)")
      self._all._stc_seasonIconPool[idx]:addInputEvent("Mouse_Out", "HandleEventLUp_GameExit_All_SeasonIconTooltip()")
      self._all._stc_seasonIconPool[idx]:SetIgnore(false)
    end
  end
end
function PaGlobal_GameExit_All:updateSlot_pc(uiCount, idx, isCurrentCharacter, removeTime)
  if true == self._isConsole then
    return
  end
  local currentMousePosX = getMousePosX()
  local currentMousePosY = getMousePosY()
  if false == isInPostion(self._basic._stc_characterSlotPool[uiCount], currentMousePosX, currentMousePosY) then
    self._basic._btn_invenPool[uiCount]:SetShow(false)
    self._basic._btn_change_pcPool[uiCount]:SetShow(false)
  else
    self._basic._btn_invenPool[uiCount]:SetShow(true)
    self._basic._btn_change_pcPool[uiCount]:SetShow(true)
  end
  if true == isCurrentCharacter then
    self._basic._btn_invenPool[uiCount]:SetShow(false)
    self._basic._btn_invenPool[uiCount]:SetIgnore(true)
    self._basic._btn_invenPool[uiCount]:SetEnable(false)
    self._basic._btn_change_pcPool[uiCount]:SetShow(false)
    self._basic._btn_change_pcPool[uiCount]:SetIgnore(true)
    self._basic._btn_change_pcPool[uiCount]:SetEnable(false)
    self._basic._btn_move_pcPool[uiCount]:SetShow(true)
    self._basic._btn_move_pcPool[uiCount]:addInputEvent("Mouse_LUp", "HandleEventLUp_GameExit_All_Move()")
    self._ui._stc_connectedCharLine:SetShow(true)
    self._ui._stc_connectedCharLine:SetPosX(self._basic._stc_characterSlotPool[uiCount]:GetPosX())
    self._ui._stc_connectedCharLine:SetPosY(self._basic._stc_characterSlotPool[uiCount]:GetPosY())
    self:setShowPhoto(uiCount, true)
  else
    self._basic._btn_invenPool[uiCount]:SetIgnore(false)
    self._basic._btn_invenPool[uiCount]:SetEnable(true)
    self._basic._btn_change_pcPool[uiCount]:SetIgnore(false)
    self._basic._btn_change_pcPool[uiCount]:SetEnable(true)
    self._basic._btn_takePicture_pcPool[uiCount]:SetShow(false)
    self._basic._btn_move_pcPool[uiCount]:SetShow(false)
    self._basic._btn_invenPool[uiCount]:addInputEvent("Mouse_On", "HandleEventOnOut_GameExit_All_ShowSimpleInventoryTooltip(true, " .. idx .. ", " .. uiCount .. ")")
    self._basic._btn_invenPool[uiCount]:addInputEvent("Mouse_Out", "HandleEventOnOut_GameExit_All_ShowSimpleInventoryTooltip(false, " .. idx .. ", " .. uiCount .. ")")
    self._basic._btn_invenPool[uiCount]:addInputEvent("Mouse_LUp", "HandleEventLUp_GameExit_All_SimpleInventory(" .. idx .. ")")
    self._basic._btn_change_pcPool[uiCount]:addInputEvent("Mouse_LUp", "HandleEventLUp_GameExit_All_ChangeCharacter(" .. idx .. ")")
    if nil ~= removeTime then
      self._basic._btn_invenPool[uiCount]:SetEnable(false)
      self._basic._btn_change_pcPool[uiCount]:SetEnable(false)
    end
    self:setShowPhoto(uiCount, false)
  end
end
function PaGlobal_GameExit_All:updateSlot_console(uiCount, idx, isCurrentCharacter, removeTime)
  if false == self._isConsole then
    return
  end
  if true == isCurrentCharacter then
    self._ui._stc_connectedCharLine:SetShow(true)
    self._ui._stc_connectedCharLine:SetPosX(self._basic._stc_characterSlotPool[uiCount]:GetPosX())
    self._ui._stc_connectedCharLine:SetPosY(self._basic._stc_characterSlotPool[uiCount]:GetPosY())
    self:setShowPhoto(uiCount, true)
    self._basic._stc_characterSlotPool[uiCount]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_GameExit_All_Move()")
    self._basic._stc_characterSlotPool[uiCount]:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  else
    self:setShowPhoto(uiCount, false)
    self._basic._stc_characterSlotPool[uiCount]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_GameExit_All_ChangeCharacter(" .. idx .. ")")
    self._basic._stc_characterSlotPool[uiCount]:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_GameExit_All_SimpleInventory(" .. idx .. ")")
  end
  self._basic._stc_characterSlotPool[uiCount]:addInputEvent("Mouse_On", "HandleEventOn_GameExit_All_UpdateKeyGuide(false, " .. tostring(isCurrentCharacter) .. "," .. tostring(uiCount) .. ")")
end
function PaGlobal_GameExit_All:setShowPhoto(index, isShow)
  if true == self._isConsole then
  else
    self._basic._btn_takePicture_pcPool[index]:SetShow(isShow)
    if true == isShow then
      self._basic._btn_takePicture_pcPool[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_GameExit_All_ForFacePhoto()")
    end
  end
end
function PaGlobal_GameExit_All:updateServantTexture(control, idx, uiCount, eServantIdx)
  local textureUV = self._servantTextureUV[eServantIdx]
  local textureOnUV = self._servantOverTextureUV[eServantIdx]
  local textureClickUV = self._servantClickTextureUV[eServantIdx]
  control:SetShow(true)
  local x1, y1, x2, y2 = setTextureUV_Func(control, textureUV.x1, textureUV.y1, textureUV.x2, textureUV.y2)
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
  x1, y1, x2, y2 = setTextureUV_Func(control, textureOnUV.x1, textureOnUV.y1, textureOnUV.x2, textureOnUV.y2)
  control:getOnTexture():setUV(x1, y1, x2, y2)
  x1, y1, x2, y2 = setTextureUV_Func(control, textureClickUV.x1, textureClickUV.y1, textureClickUV.x2, textureClickUV.y2)
  control:getClickTexture():setUV(x1, y1, x2, y2)
  if false == self._isConsole then
    control:addInputEvent("Mouse_On", "HandleEventOnOut_GameExit_All_ServantInfoTooltip(true, " .. idx .. ", " .. uiCount .. ", " .. eServantIdx .. ")")
    control:addInputEvent("Mouse_Out", "HandleEventOnOut_GameExit_All_ServantInfoTooltip(false)")
  end
end
function PaGlobal_GameExit_All:setShowHideBottomButton()
  self._ui._stc_functionGroup:SetShow(false)
end
function PaGlobal_GameExit_All:updateRecentJournal()
  self._ui._txt_frameContents:SetText("")
  self._ui._txt_frameContents:SetTextVerticalTop()
  local journal_Count = ToClient_GetRecentJournalCount()
  if 0 < journal_Count then
    for journal_Idx = 0, journal_Count - 1 do
      local journalWrapper = ToClient_GetRecentJournalByIndex(journal_Idx)
      if nil ~= journalWrapper then
        local stringData = "[" .. string.format("%.02d", journalWrapper:getJournalHour()) .. ":" .. string.format("%.02d", journalWrapper:getJournalMinute()) .. "] " .. journalWrapper:getName()
        if 0 == journal_Idx then
          self._ui._txt_frameContents:SetTextMode(__eTextMode_AutoWrap)
          self._ui._txt_frameContents:SetText(stringData)
        else
          self._ui._txt_frameContents:SetTextMode(__eTextMode_AutoWrap)
          self._ui._txt_frameContents:SetText(self._ui._txt_frameContents:GetText() .. "\n" .. stringData)
        end
      else
        self._ui._txt_frameContents:SetTextMode(__eTextMode_AutoWrap)
        self._ui._txt_frameContents:SetText(self._ui._txt_frameContents:GetText() .. "\n" .. stringData)
      end
      self._ui._frame_contents:SetSize(self._ui._frame_contents:GetSizeX(), self._ui._txt_frameContents:GetTextSizeY())
    end
  else
    self._ui._txt_frameContents:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_JOURNALCONTENTS"))
  end
  self._ui._txt_frameContents:ComputePos()
  if self._ui._frame_todayMyChallenge:GetSizeY() < self._ui._frame_contents:GetSizeY() then
    self._ui._scroll_frame:SetShow(true)
  else
    self._ui._scroll_frame:SetShow(false)
  end
  self._ui._frame_todayMyChallenge:UpdateContentScroll()
  self._ui._frame_todayMyChallenge:UpdateContentPos()
end
function PaGlobal_GameExit_All:updateLastCompleteQuest()
  local questWrapper
  local questNo0 = getSelfPlayer():get():getLastCompleteQuest(0)
  questWrapper = ToClient_getQuestWrapper(questNo0)
  if nil ~= questWrapper then
    self._ui._txt_questList:SetText(questWrapper:getTitle())
    UI.setLimitTextAndAddTooltip(self._ui._txt_questList)
  else
    self._ui._txt_questList:SetText("-")
  end
  local questNo1 = getSelfPlayer():get():getLastCompleteQuest(1)
  questWrapper = ToClient_getQuestWrapper(questNo1)
  if nil ~= questWrapper then
    self._ui._txt_questList2:SetText(questWrapper:getTitle())
    UI.setLimitTextAndAddTooltip(self._ui._txt_questList2)
  else
    self._ui._txt_questList2:SetText("")
  end
end
function PaGlobal_GameExit_All:initListToggle()
  if self._eType._basic == self._eViewType then
    self._ui._pc._chk_listToggle:SetCheck(false)
  elseif self._eType._all == self._eViewType then
    self._ui._pc._chk_listToggle:SetCheck(true)
  end
end
function PaGlobal_GameExit_All:updateListToggle()
  if false == self._ui._pc._chk_listToggle:IsCheck() then
    self._eViewType = self._eType._basic
    PaGlobal_GameExit_All:updateBasicList()
  else
    self._eViewType = self._eType._all
    PaGlobal_GameExit_All:updateAllList()
  end
  self:saveCurrentViewType()
  if self._isConsole then
    Panel_Window_GameExit_All:ComputePos()
    self._ui._console._stc_keyGuideBg:ComputePos()
    ToClient_padSnapResetControl()
  end
end
function PaGlobal_GameExit_All:updateBasicList()
  Panel_Window_GameExit_All:SetSize(Panel_Window_GameExit_All:GetSizeX(), self._panelSizeY)
  self._ui._stc_mainBg:SetShow(true)
  self._stc_bottomBg:SetShow(true)
  self._ui._stc_allCharList:SetShow(false)
  self._ui._stc_functionGroup:SetSpanSize(self._ui._stc_functionGroup:GetSpanSize().x, self._GroupSpanSizeY)
  self._ui._stc_functionGroup:ComputePos()
end
function PaGlobal_GameExit_All:updateAllList()
  Panel_Window_GameExit_All:SetSize(Panel_Window_GameExit_All:GetSizeX(), self._panelSizeY + 35)
  self._ui._stc_mainBg:SetShow(false)
  self._stc_bottomBg:SetShow(false)
  self._ui._stc_allCharList:SetShow(true)
  self._ui._stc_functionGroup:SetSpanSize(self._ui._stc_functionGroup:GetSpanSize().x, 10)
  self._ui._stc_functionGroup:ComputePos()
end
function PaGlobal_GameExit_All:selectCharacter_all(idx)
  if false == Panel_Window_GameExit_All:IsShow() then
    return
  end
  if idx == self._selectCharacterIdx then
    return
  end
  self._selectCharacterIdx = idx
  local selfProxy = getSelfPlayer()
  local characterNo_64 = toInt64(0, 0)
  if nil ~= selfProxy then
    characterNo_64 = selfProxy:getCharacterNo_64()
  end
  local serverUtc64 = getServerUtc64()
  local characterData = getCharacterDataByIndex(idx)
  if nil == characterData then
    return
  end
  local char_Type = getCharacterClassType(characterData)
  local char_Level = string.format("%d", characterData._level)
  local char_Name = getCharacterName(characterData)
  local regionInfo = getRegionInfoByPosition(characterData._currentPosition)
  local pcDeliveryRegionKey = characterData._arrivalRegionKey
  local char_WorkTxt = ""
  local pcDeliveryRemainTimeText = ""
  local isSeasonCharacter = characterData._characterSeasonType == __eCharacterSeasonType_Season
  self._ui._charInfo._stc_classMarkIcon:SetShow(true)
  PaGlobalFunc_Util_ChangeTextureClass(self._ui._charInfo._stc_classMarkIcon, char_Type)
  self._ui._charInfo._txt_level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. char_Level)
  self._ui._charInfo._txt_name:SetText(char_Name)
  self._ui._charInfo._txt_location:SetShow(true)
  self._ui._charInfo._txt_contidion:SetShow(true)
  self._ui._charInfo._txt_remindTime:SetShow(true)
  self._ui._charInfo._txt_location:SetTextMode(__eTextMode_LimitText)
  if 0 == characterData._currentPosition.x and 0 == characterData._currentPosition.y and 0 == characterData._currentPosition.z then
    self._ui._charInfo._txt_location:SetText("")
  elseif 0 ~= pcDeliveryRegionKey:get() and serverUtc64 > characterData._arrivalTime then
    local retionInfoArrival = getRegionInfoByRegionKey(pcDeliveryRegionKey)
    self._ui._charInfo._txt_location:SetText(retionInfoArrival:getAreaName())
  else
    self._ui._charInfo._txt_location:SetText(regionInfo:getAreaName())
  end
  if 0 ~= pcDeliveryRegionKey:get() and serverUtc64 < characterData._arrivalTime then
    char_WorkTxt = PAGetString(Defines.StringSheet_GAME, "CHARACTER_WORKING_TEXT_DELIVERY")
    local remainTime = characterData._arrivalTime - serverUtc64
    pcDeliveryRemainTimeText = convertStringFromDatetime(remainTime)
  else
    char_WorkTxt = PaGlobal_GameExit_All_GetWorkTypeString(characterData._pcWorkingType)
  end
  local isCurrentCharacter = characterNo_64 == characterData._characterNo_s64
  local isPcShow = false == self._isConsole
  if true == isCurrentCharacter then
    self._ui._charInfo._txt_contidion:SetText("")
    self._ui._charInfo._txt_contidion:SetFontColor(Defines.Color.C_FF6DC6FF)
    self._ui._charInfo._txt_remindTime:SetText("")
    self._ui._charInfo._btn_takePicture_pc:SetShow(isPcShow)
    self._ui._charInfo._btn_move_pc:SetShow(isPcShow)
    self._ui._charInfo._btn_inven_pc:SetShow(false)
    self._ui._charInfo._btn_change_pc:SetShow(false)
  else
    self._ui._charInfo._txt_contidion:SetText(char_WorkTxt)
    self._ui._charInfo._txt_contidion:SetFontColor(Defines.Color.C_FFE7E7E7)
    local removeTime = getCharacterDataRemoveTime(idx)
    if nil ~= removeTime then
      self._ui._charInfo._txt_contidion:SetText(PAGetString(Defines.StringSheet_GAME, "CHARACTER_DELETING"))
      self._ui._charInfo._txt_location:SetShow(false)
    else
      self._ui._charInfo._txt_contidion:SetText(char_WorkTxt)
    end
    self._ui._charInfo._txt_remindTime:SetText(pcDeliveryRemainTimeText)
    self._ui._charInfo._btn_takePicture_pc:SetShow(false)
    self._ui._charInfo._btn_move_pc:SetShow(false)
    self._ui._charInfo._btn_inven_pc:SetShow(isPcShow)
    if true == _ContentsGroup_SeasonContents then
      self._ui._charInfo._btn_change_pc:SetShow(isPcShow)
    else
      if true == _ContentsGroup_PreSeason and characterData._characterSeasonType == __eCharacterSeasonType_Season then
        self._ui._charInfo._btn_change_pc:SetMonoTone(true, true)
        self._ui._charInfo._btn_change_pc:SetIgnore(true)
        self._ui._charInfo._btn_inven_pc:SetIgnore(true)
        self._ui._charInfo._btn_inven_pc:SetMonoTone(true, true)
      else
        self._ui._charInfo._btn_change_pc:SetMonoTone(false, false)
        self._ui._charInfo._btn_change_pc:SetIgnore(false)
        self._ui._charInfo._btn_inven_pc:SetIgnore(false)
        self._ui._charInfo._btn_inven_pc:SetMonoTone(false, false)
      end
      self._ui._charInfo._btn_change_pc:SetShow(isPcShow)
    end
  end
  self._ui._stc_selectImage:SetPosX(self._all._stc_characterSlotPool[idx]:GetPosX())
  self._ui._stc_selectImage:SetPosY(self._all._stc_characterSlotPool[idx]:GetPosY())
  if nil ~= Panel_Window_SimpleInventory and true == Panel_Window_SimpleInventory:GetShow() and false == isCurrentCharacter then
    HandleEventLUp_GameExit_All_SimpleInventory()
  end
end
function PaGlobal_GameExit_All:saveCurrentViewType()
  if self._eType._basic == self._eViewType then
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eGameExitCharacterListWindow, false, CppEnums.VariableStorageType.eVariableStorageType_User)
  elseif self._eType._all == self._eViewType then
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eGameExitCharacterListWindow, true, CppEnums.VariableStorageType.eVariableStorageType_User)
  end
end
function PaGlobal_GameExit_All:initCharacterInfo()
  self._ui._charInfo._stc_classMarkIcon:SetShow(false)
  self._ui._charInfo._txt_level:SetText("")
  self._ui._charInfo._txt_name:SetText("")
  self._ui._charInfo._txt_location:SetText("")
  self._ui._charInfo._txt_contidion:SetText("")
  self._ui._charInfo._txt_remindTime:SetText("")
end
