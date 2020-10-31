PaGlobal_SocialMenu = {
  _ui = {
    _stc_titlebg = nil,
    _btn_winClose = nil,
    _stc_mainBg = nil,
    _frameSocialAction = nil,
    _edit_command = nil,
    _edit_keyword_1 = nil,
    _edit_keyword_2 = nil,
    _edit_keyword_3 = nil,
    _conditionText = nil,
    _descArea = nil,
    _btnApply = nil,
    _btnReset = nil,
    _btnCancel = nil,
    _keyTitle = nil,
    _descBG = nil,
    _name = nil,
    _icon = nil,
    _keyGuideBG = nil,
    _keyGuideY = nil,
    _keyGuideA = nil,
    _keyGuideX = nil,
    _keyGuideB = nil
  },
  _socialIconSlot = {},
  _socialIconSlotBG = {},
  _selectedSlotBG = nil,
  _panelSizeY = 0,
  _mainBgSizeY = 0,
  _keyTitlePosY = 0,
  _keywordPosY = 0,
  _descPosY = 0,
  _maxColumnCount = 6,
  _selectIndex = -1,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "SocialAction_Icon_Initialize")
function SocialAction_Icon_Initialize()
  PaGlobal_SocialMenu:Initialize()
end
function PaGlobal_SocialMenu:Initialize()
  if true == self._initialize then
    return
  end
  self._ui._stc_titlebg = UI.getChildControl(Panel_Chat_SocialMenu, "Static_TitleBg")
  self._ui._btn_winClose = UI.getChildControl(self._ui._stc_titlebg, "Button_WinClose")
  self._ui._stc_mainBg = UI.getChildControl(Panel_Chat_SocialMenu, "Static_MainBg")
  self._ui._frameSocialAction = UI.getChildControl(Panel_Chat_SocialMenu, "Frame_SocialAction")
  self._ui._edit_command = UI.getChildControl(Panel_Chat_SocialMenu, "Edit_Command")
  self._ui._edit_keyword_1 = UI.getChildControl(Panel_Chat_SocialMenu, "Edit_Keyword_1")
  self._ui._edit_keyword_2 = UI.getChildControl(Panel_Chat_SocialMenu, "Edit_Keyword_2")
  self._ui._edit_keyword_3 = UI.getChildControl(Panel_Chat_SocialMenu, "Edit_Keyword_3")
  self._ui._descArea = UI.getChildControl(Panel_Chat_SocialMenu, "Static_DescArea")
  self._ui._btnApply = UI.getChildControl(Panel_Chat_SocialMenu, "Button_Apply")
  self._ui._btnReset = UI.getChildControl(Panel_Chat_SocialMenu, "Button_Reset")
  self._ui._btnCancel = UI.getChildControl(Panel_Chat_SocialMenu, "Button_Cancel")
  self._ui._keyTitle = UI.getChildControl(Panel_Chat_SocialMenu, "StaticText_Key_Title")
  self._ui._descBG = UI.getChildControl(Panel_Chat_SocialMenu, "Static_DescBG")
  self._ui._name = UI.getChildControl(Panel_Chat_SocialMenu, "StaticText_SocialName")
  self._ui._conditionText = UI.getChildControl(Panel_Chat_SocialMenu, "StaticText_ConditionMessage")
  self._ui._icon = UI.getChildControl(Panel_Chat_SocialMenu, "Static_SelectedIcon")
  self._ui._keyGuideBG = UI.getChildControl(Panel_Chat_SocialMenu, "Static_KeyGuide_ConsoleUI")
  self._ui._keyGuideY = UI.getChildControl(self._ui._keyGuideBG, "StaticText_Y_ConsoleUI")
  self._ui._keyGuideA = UI.getChildControl(self._ui._keyGuideBG, "StaticText_A_ConsoleUI")
  self._ui._keyGuideX = UI.getChildControl(self._ui._keyGuideBG, "StaticText_X_ConsoleUI")
  self._ui._keyGuideB = UI.getChildControl(self._ui._keyGuideBG, "StaticText_B_ConsoleUI")
  self:validate()
  self:registEventHandler()
  Panel_Chat_SocialMenu:setGlassBackground(true)
  Panel_Chat_SocialMenu:SetDragEnable(true)
  Panel_Chat_SocialMenu:SetDragAll(true)
  Panel_Chat_SocialMenu:SetPosX(getScreenSizeX() / 2 + Panel_Chat_SocialMenu:GetSizeX() / 2)
  Panel_Chat_SocialMenu:SetPosY(getScreenSizeY() / 2 - Panel_Chat_SocialMenu:GetSizeY() / 2)
  Panel_Chat_SocialMenu:SetChildIndex(self._ui._icon, 9999)
  self._ui._conditionText:SetTextMode(__eTextMode_AutoWrap)
  local descText = UI.getChildControl(self._ui._descArea, "StaticText_Desc")
  local originalTextSize = descText:GetSizeY()
  descText:SetTextMode(__eTextMode_AutoWrap)
  descText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SOCIALACTION_DESC"))
  descText:SetSize(descText:GetSizeX(), descText:GetTextSizeY())
  local changedTextSize = descText:GetSizeY()
  self._ui._descArea:SetSize(self._ui._descArea:GetSizeX(), self._ui._descArea:GetSizeY() + (changedTextSize - originalTextSize))
  self._ui._stc_mainBg:SetSize(self._ui._stc_mainBg:GetSizeX(), self._ui._stc_mainBg:GetSizeY() + (changedTextSize - originalTextSize))
  Panel_Chat_SocialMenu:SetSize(Panel_Chat_SocialMenu:GetSizeX(), Panel_Chat_SocialMenu:GetSizeY() + (changedTextSize - originalTextSize))
  descText:ComputePos()
  if true == _ContentsGroup_UsePadSnapping then
    self._ui._btn_winClose:SetShow(false)
    self._ui._btnApply:SetShow(false)
    self._ui._btnReset:SetShow(false)
    self._ui._btnCancel:SetShow(false)
    Panel_Chat_SocialMenu:SetSize(Panel_Chat_SocialMenu:GetSizeX(), Panel_Chat_SocialMenu:GetSizeY() - self._ui._btnApply:GetSizeY())
    local keyGuide = {
      self._ui._keyGuideY,
      self._ui._keyGuideA,
      self._ui._keyGuideX,
      self._ui._keyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  else
  end
  self._panelSizeY = Panel_Chat_SocialMenu:GetSizeY()
  self._mainBgSizeY = self._ui._stc_mainBg:GetSizeY()
  self._keyTitlePosY = self._ui._keyTitle:GetPosY()
  self._keywordPosY = self._ui._edit_keyword_1:GetPosY()
  self._descPosY = self._ui._descArea:GetPosY()
  self._initialize = true
end
function PaGlobal_SocialMenu:registEventHandler()
  if false == _ContentsGroup_UsePadSnapping then
    self._ui._btn_winClose:addInputEvent("Mouse_LUp", "HandleClicked_Button(1,0)")
    self._ui._edit_command:addInputEvent("Mouse_LUp", "HandleClicked_EditBox(" .. 0 .. ")")
    self._ui._edit_keyword_1:addInputEvent("Mouse_LUp", "HandleClicked_EditBox(" .. 1 .. ")")
    self._ui._edit_keyword_2:addInputEvent("Mouse_LUp", "HandleClicked_EditBox(" .. 2 .. ")")
    self._ui._edit_keyword_3:addInputEvent("Mouse_LUp", "HandleClicked_EditBox(" .. 3 .. ")")
    self._ui._btnApply:addInputEvent("Mouse_LUp", "HandleClicked_Apply()")
    self._ui._btnReset:addInputEvent("Mouse_LUp", "HandleClicked_Button(" .. 0 .. ")")
    self._ui._btnCancel:addInputEvent("Mouse_LUp", "HandleClicked_Button(" .. 1 .. ")")
  else
    self._ui._edit_command:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleClicked_EditBox(" .. 0 .. ")")
    self._ui._edit_keyword_1:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleClicked_EditBox(" .. 1 .. ")")
    self._ui._edit_keyword_2:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleClicked_EditBox(" .. 2 .. ")")
    self._ui._edit_keyword_3:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleClicked_EditBox(" .. 3 .. ")")
    Panel_Chat_SocialMenu:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleClicked_Apply()")
    Panel_Chat_SocialMenu:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleClicked_Button(" .. 0 .. ")")
  end
  if true == _ContentsGroup_RenewUI then
    self._ui._edit_command:setXboxVirtualKeyBoardEndEvent("PaGlobal_SocialMenu_EndInputEvent")
    self._ui._edit_keyword_1:setXboxVirtualKeyBoardEndEvent("PaGlobal_SocialMenu_EndInputEvent")
    self._ui._edit_keyword_2:setXboxVirtualKeyBoardEndEvent("PaGlobal_SocialMenu_EndInputEvent")
    self._ui._edit_keyword_3:setXboxVirtualKeyBoardEndEvent("PaGlobal_SocialMenu_EndInputEvent")
  else
    self._ui._edit_command:RegistReturnKeyEvent("PaGlobal_SocialMenu_EndInputEvent()")
    self._ui._edit_keyword_1:RegistReturnKeyEvent("PaGlobal_SocialMenu_EndInputEvent()")
    self._ui._edit_keyword_2:RegistReturnKeyEvent("PaGlobal_SocialMenu_EndInputEvent()")
    self._ui._edit_keyword_3:RegistReturnKeyEvent("PaGlobal_SocialMenu_EndInputEvent()")
  end
end
function PaGlobal_SocialMenu:validate()
  if nil == Panel_Chat_SocialMenu then
    return
  end
  self._ui._stc_titlebg:isValidate()
  self._ui._btn_winClose:isValidate()
  self._ui._stc_mainBg:isValidate()
  self._ui._frameSocialAction:isValidate()
  self._ui._edit_command:isValidate()
  self._ui._edit_keyword_1:isValidate()
  self._ui._edit_keyword_2:isValidate()
  self._ui._edit_keyword_3:isValidate()
  self._ui._descArea:isValidate()
  self._ui._btnApply:isValidate()
  self._ui._btnReset:isValidate()
  self._ui._btnCancel:isValidate()
  self._ui._keyTitle:isValidate()
  self._ui._descBG:isValidate()
  self._ui._name:isValidate()
  self._ui._conditionText:isValidate()
  self._ui._icon:isValidate()
  self._ui._keyGuideBG:isValidate()
  self._ui._keyGuideY:isValidate()
  self._ui._keyGuideA:isValidate()
  self._ui._keyGuideX:isValidate()
  self._ui._keyGuideB:isValidate()
end
function PaGlobal_SocialMenu:prepareOpen()
  if true == Panel_Chat_SocialMenu:GetShow() then
    return
  end
  PaGlobal_SocialMenu:setSocialAction()
  HandleClicked_SocialIcon(0)
  self:Open()
end
function PaGlobal_SocialMenu:Open()
  Panel_Chat_SocialMenu:SetShow(true)
end
function PaGlobal_SocialMenu:prepareClose()
  if false == Panel_Chat_SocialMenu:GetShow() then
    return
  end
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
  FGlobal_SocialAction_SetCHK(false)
  TooltipSimple_Hide()
  self:Close()
end
function PaGlobal_SocialMenu:Close()
  Panel_Chat_SocialMenu:SetShow(false)
end
function PaGlobal_SocialMenu:setSocialAction()
  local socialIconSlotBG = UI.getChildControl(Panel_Chat_SocialMenu, "Static_C_IconBG")
  local socialIconSlot = UI.getChildControl(Panel_Chat_SocialMenu, "Static_C_SocialIcon")
  local selectedSlotBG = UI.getChildControl(Panel_Chat_SocialMenu, "Static_C_IconSelect")
  local socialIconCount = ToClient_getSocialActionInfoList()
  local iconGap = 55
  local _columnCount = 0
  local _rowCount = 0
  local frameContent = self._ui._frameSocialAction:GetFrameContent()
  frameContent:DestroyAllChild()
  for index = 0, socialIconCount do
    self._socialIconSlotBG[index] = {}
    self._socialIconSlot[index] = {}
    self._socialIconSlotBG[index] = createControl(__ePAUIControl_Static, frameContent, "Static_SocialIconSlotBG_" .. index)
    self._socialIconSlot[index] = createControl(__ePAUIControl_Static, frameContent, "Static_SocialIconSlot_" .. index)
    local slotBG = self._socialIconSlotBG[index]
    local slot = self._socialIconSlot[index]
    CopyBaseProperty(socialIconSlotBG, slotBG)
    CopyBaseProperty(socialIconSlot, slot)
    frameContent:SetChildIndex(slot, 3000)
    if 0 == index % self._maxColumnCount then
      _columnCount = 0
      _rowCount = _rowCount + 1
    else
      _columnCount = _columnCount + 1
    end
    slotBG:SetPosX(socialIconSlotBG:GetPosX() + iconGap * _columnCount)
    slotBG:SetPosY(socialIconSlotBG:GetPosY() + iconGap * (_rowCount - 1))
    slot:SetPosX(socialIconSlot:GetPosX() + iconGap * _columnCount)
    slot:SetPosY(socialIconSlot:GetPosY() + iconGap * (_rowCount - 1))
    slotBG:SetShow(true)
    slot:SetShow(true)
    if socialIconCount ~= index then
      local socialActionInfo = ToClient_getSocialActionInfoByIndex(index)
      local sASS = socialActionInfo:getStaticStatus()
      local socialKey = sASS:getKey()
      if true == ToClient_isUsableSocialAction(socialKey) then
        slot:ActiveMouseEventEffect(true)
        slot:SetMonoTone(false)
        slot:addInputEvent("Mouse_LUp", "HandleClicked_SocialIcon(" .. index .. ")")
        slot:addInputEvent("Mouse_RUp", "HandleClicked_DoAction(" .. index .. ")")
        slot:addInputEvent("Mouse_On", "Show_Condition_SocialIcon(" .. index .. ", true )")
        slot:addInputEvent("Mouse_Out", "Show_Condition_SocialIcon()")
      else
        slot:ActiveMouseEventEffect(false)
        slot:SetMonoTone(true)
        slot:addInputEvent("Mouse_On", "Show_Condition_SocialIcon(" .. index .. ")")
        slot:addInputEvent("Mouse_Out", "Show_Condition_SocialIcon()")
      end
      slot:ChangeTextureInfoName("Icon/" .. sASS:getIconPath())
      slot:SetAlpha(1)
    else
      slot:ChangeTextureInfoName("Icon/New_Icon/03_ETC/item_unknown.dds")
      slot:SetAlpha(1)
      slot:SetIgnore(true)
      slotBG:SetIgnore(true)
    end
  end
  self._selectedSlotBG = createControl(__ePAUIControl_Static, frameContent, "Static_SelectedSlot")
  CopyBaseProperty(selectedSlotBG, self._selectedSlotBG)
  frameContent:SetSize(frameContent:GetSizeX(), self._socialIconSlot[socialIconCount - 1]:GetPosY() + iconGap - 10)
  self._ui._frameSocialAction:UpdateContentScroll()
end
function PaGlobal_SocialMenu:Description_Setting(index)
  ToClient_getSocialActionInfoList()
  local socialActionInfo = ToClient_getSocialActionInfoByIndex(index)
  local sASS = socialActionInfo:getStaticStatus()
  local socialKey = sASS:getKey()
  local allKeyword = socialActionInfo:getKeywordBuffer()
  local conditionGap = 0
  self._ui._name:SetText(sASS:getName())
  UI.setLimitTextAndAddTooltip(self._name)
  self._ui._conditionText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SOCIALACTION_CONDITIONTEXT") .. sASS:getConditionMessage())
  self._ui._icon:ChangeTextureInfoName("Icon/" .. sASS:getIconPath())
  self._ui._icon:addInputEvent("Mouse_LUp", "ToClient_requestStartSocialAction(" .. socialKey .. ")")
  self._ui._edit_command:SetEditText(socialActionInfo:getCommand())
  if "" ~= sASS:getConditionMessage() then
    if self._ui._conditionText:GetSizeY() < self._ui._conditionText:GetTextSizeY() then
      conditionGap = self._ui._conditionText:GetTextSizeY() + 10
    else
      conditionGap = 30
    end
  end
  self._ui._conditionText:SetShow(0 ~= conditionGap)
  Panel_Chat_SocialMenu:SetSize(Panel_Chat_SocialMenu:GetSizeX(), self._panelSizeY + conditionGap)
  self._ui._stc_mainBg:SetSize(self._ui._stc_mainBg:GetSizeX(), self._mainBgSizeY + conditionGap)
  self._ui._btnApply:ComputePos()
  self._ui._btnReset:ComputePos()
  self._ui._btnCancel:ComputePos()
  self._ui._keyGuideBG:ComputePos()
  self._ui._keyTitle:SetPosY(self._keyTitlePosY + conditionGap)
  self._ui._edit_keyword_1:SetPosY(self._keywordPosY + conditionGap)
  self._ui._edit_keyword_2:SetPosY(self._keywordPosY + conditionGap)
  self._ui._edit_keyword_3:SetPosY(self._keywordPosY + conditionGap)
  self._ui._descArea:SetPosY(self._descPosY + conditionGap)
  local stringren = string.len(allKeyword)
  local semicolonCount = 0
  local locationSemicolon = 0
  local stringStartIndex = 1
  local keyWord = {}
  while true do
    locationSemicolon = string.find(allKeyword, ";", locationSemicolon + 1)
    if locationSemicolon == nil then
      break
    end
    local string = string.sub(allKeyword, stringStartIndex, locationSemicolon - 1)
    if nil == string then
      string = ""
    end
    keyWord[semicolonCount] = string
    stringStartIndex = locationSemicolon + 1
    semicolonCount = semicolonCount + 1
  end
  if semicolonCount < 3 then
    local string = string.sub(allKeyword, stringStartIndex, string.len(allKeyword))
    if nil == string then
      string = ""
    end
    keyWord[semicolonCount] = string
  end
  if nil == keyWord[2] then
    keyWord[2] = ""
  end
  self._ui._edit_keyword_1:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_SOCIALACTION_KEYWORD_1"))
  self._ui._edit_keyword_2:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_SOCIALACTION_KEYWORD_2"))
  self._ui._edit_keyword_3:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_SOCIALACTION_KEYWORD_3"))
  if "" ~= keyWord[0] then
    self._ui._edit_keyword_1:SetEditText(keyWord[0])
  end
  self._ui._edit_keyword_2:SetEditText(keyWord[1])
  self._ui._edit_keyword_3:SetEditText(keyWord[2])
  UI.setLimitTextAndAddTooltip(self._ui._name)
end
function PaGlobal_SocialMenu_EndInputEvent()
  ClearFocusEdit()
end
function HandleClicked_Button(number)
  if 0 == number then
    ToClient_resetSocialActionInfo()
  elseif 1 == number then
    ToClient_cancelSocialActionInfo()
    FGlobal_SocialAction_ShowToggle()
    if false == CheckChattingInput() then
      ClearFocusEdit()
    end
  end
  PaGlobal_SocialMenu:Description_Setting(PaGlobal_SocialMenu._selectIndex)
end
function HandleClicked_Apply()
  local self = PaGlobal_SocialMenu
  local _command = self._ui._edit_command:GetEditText()
  local keyword_1 = self._ui._edit_keyword_1:GetEditText()
  local keyword_2 = self._ui._edit_keyword_2:GetEditText()
  local keyword_3 = self._ui._edit_keyword_3:GetEditText()
  local keyWordValue = ""
  local keyword1 = PAGetString(Defines.StringSheet_GAME, "LUA_SOCIALACTION_KEYWORD_1")
  local keyword2 = PAGetString(Defines.StringSheet_GAME, "LUA_SOCIALACTION_KEYWORD_2")
  local keyword3 = PAGetString(Defines.StringSheet_GAME, "LUA_SOCIALACTION_KEYWORD_3")
  if keyword1 ~= keyword_1 then
    keyWordValue = keyword_1
    if keyword2 ~= keyword_2 then
      keyWordValue = keyWordValue .. ";" .. keyword_2
      if keyword3 ~= keyword_3 then
        keyWordValue = keyWordValue .. ";" .. keyword_3
      end
    end
  end
  local socialActionInfo = ToClient_getSocialActionInfoByIndex(self._selectIndex)
  if nil == socialActionInfo then
    return
  end
  local sASS = socialActionInfo:getStaticStatus()
  if nil == sASS then
    return
  end
  ToClient_setSocialActionCommand(sASS:getKey(), _command)
  ToClient_setSocialActionKeyword(sASS:getKey(), keyWordValue)
  ToClient_applySocialActionInfo()
  self:Description_Setting(self._selectIndex)
end
function HandleClicked_EditBox(editControlNo)
  if 0 == editControlNo then
    SetFocusEdit(PaGlobal_SocialMenu._ui._edit_command)
  elseif 1 == editControlNo then
    SetFocusEdit(PaGlobal_SocialMenu._ui._edit_keyword_1)
  elseif 2 == editControlNo then
    SetFocusEdit(PaGlobal_SocialMenu._ui._edit_keyword_2)
  elseif 3 == editControlNo then
    SetFocusEdit(PaGlobal_SocialMenu._ui._edit_keyword_3)
  end
end
function HandleClicked_SocialIcon(iconIndex)
  local self = PaGlobal_SocialMenu
  if iconIndex == self._selectIndex then
    return
  end
  local socialIconCount = ToClient_getSocialActionInfoList()
  if 0 == socialIconCount or iconIndex >= socialIconCount then
    return
  end
  audioPostEvent_SystemUi(0, 0)
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  if self._selectIndex >= 0 then
    self._socialIconSlot[self._selectIndex]:ResetVertexAni()
    self._socialIconSlot[self._selectIndex]:SetVertexAniRun("Ani_Color_Reset", true)
  end
  self._socialIconSlot[iconIndex]:ResetVertexAni()
  self._socialIconSlot[iconIndex]:SetVertexAniRun("Ani_Color", true)
  self._selectedSlotBG:SetPosX(self._socialIconSlotBG[iconIndex]:GetPosX())
  self._selectedSlotBG:SetPosY(self._socialIconSlotBG[iconIndex]:GetPosY())
  self._selectedSlotBG:SetShow(true)
  self:Description_Setting(iconIndex)
  HandleClicked_DoAction(iconIndex)
  self._selectIndex = iconIndex
end
function HandleClicked_DoAction(iconIndex)
  local socialActionInfo = ToClient_getSocialActionInfoByIndex(iconIndex)
  if nil == socialActionInfo then
    return
  end
  local sASS = socialActionInfo:getStaticStatus()
  if nil == sASS then
    return
  end
  local socialKey = sASS:getKey()
  ToClient_requestStartSocialAction(socialKey)
end
function Show_Condition_SocialIcon(iconIndex, conditionCheck)
  if nil == iconIndex then
    TooltipSimple_Hide()
    return
  end
  local socialActionInfo = ToClient_getSocialActionInfoByIndex(iconIndex)
  if nil == socialActionInfo then
    return
  end
  local sASS = socialActionInfo:getStaticStatus()
  if nil == sASS then
    return
  end
  if true == conditionCheck then
    local name = sASS:getName()
    TooltipSimple_Show(PaGlobal_SocialMenu._socialIconSlot[iconIndex], name)
  else
    local conditionText = sASS:getConditionMessage()
    if "" == conditionText then
      return
    end
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_SOCIALACTION_CONDITIONTEXT")
    TooltipSimple_Show(PaGlobal_SocialMenu._socialIconSlot[iconIndex], name, conditionText)
  end
end
function FGlobal_SocialAction_ShowToggle()
  if Panel_Chat_SocialMenu:GetShow() then
    PaGlobal_SocialMenu:prepareClose()
    return false
  elseif Panel_Chatting_Macro:IsShow() then
    Panel_Chatting_Macro:SetShow(false, false)
    PaGlobal_SocialMenu:prepareOpen()
    return true
  else
    audioPostEvent_SystemUi(1, 0)
    _AudioPostEvent_SystemUiForXBOX(1, 0)
    PaGlobal_SocialMenu:prepareOpen()
    return true
  end
  return false
end
