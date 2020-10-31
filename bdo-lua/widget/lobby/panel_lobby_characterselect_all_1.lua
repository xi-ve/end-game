function PaGlobal_CharacterSelect_All:initialize()
  if true == PaGlobal_CharacterSelect_All._initialize or nil == Panel_CharacterSelect_All then
    return
  end
  self._ui.stc_BackGroundBg = UI.getChildControl(Panel_CharacterSelect_All, "Static_GradationBG")
  self._ui.stc_RightBg = UI.getChildControl(Panel_CharacterSelect_All, "Static_RightBg")
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_RightBg, "StaticText_CharacterSelect")
  self._ui.txt_CharacterCount = UI.getChildControl(self._ui.stc_RightBg, "StaticText_CharacterCount")
  self._ui.rdo_Normal = UI.getChildControl(self._ui.stc_RightBg, "RadioButton_Normal")
  self._ui.rdo_Special = UI.getChildControl(self._ui.stc_RightBg, "RadioButton_Special")
  self._ui.stc_KeyGuide_LB = UI.getChildControl(self._ui.stc_RightBg, "StaticText_ChangeTab_LB_ConsoleUI")
  self._ui.stc_KeyGuide_RB = UI.getChildControl(self._ui.stc_RightBg, "StaticText_ChangeTab_RB_ConsoleUI")
  self._ui.btn_Delete = UI.getChildControl(self._ui.stc_RightBg, "Button_DeleteCharacter")
  self._ui.btn_ChangePosition = UI.getChildControl(self._ui.stc_RightBg, "Checkbox_CharacterPosChange")
  self._ui.btn_Exit = UI.getChildControl(self._ui.stc_RightBg, "Button_ExitGame")
  self._ui.btn_BackToServer = UI.getChildControl(self._ui.stc_RightBg, "Button_ExitToServerSelect")
  self._ui.chk_Ghost = UI.getChildControl(self._ui.stc_RightBg, "CheckButton_Offline")
  self._ui.stc_SelectLine = UI.getChildControl(self._ui.stc_RightBg, "Static_SelectLine")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_RightBg, "StaticText_Select_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_RightBg, "StaticText_Exit_ConsoleUI")
  self._ui.stc_KeyGuide_X = UI.getChildControl(self._ui.stc_RightBg, "StaticText_ChangeSlotLocation_ConsoleUI")
  self._ui.stc_KeyGuide_Y = UI.getChildControl(self._ui.stc_RightBg, "StaticText_Delete_ConsoleUI")
  self._ui.stc_KeyGuide_LBRB = UI.getChildControl(self._ui.stc_RightBg, "StaticText_ChangeSlotLocation_RB_ConsoleUI")
  self._ui.txt_FamilyName = UI.getChildControl(Panel_CharacterSelect_All, "StaticText_FamilyName")
  self._ui.txt_CharacterName = UI.getChildControl(Panel_CharacterSelect_All, "StaticText_CharacterName")
  self._ui.txt_CharacterStatus = UI.getChildControl(Panel_CharacterSelect_All, "StaticText_Ticket")
  self._ui.list2_Character = UI.getChildControl(Panel_CharacterSelect_All, "List2_CharacterListBG")
  self._ui.stc_RightClick = UI.getChildControl(Panel_CharacterSelect_All, "StaticText_MouseRightClick")
  self._ui.stc_MouseWheel = UI.getChildControl(Panel_CharacterSelect_All, "StaticText_MouseWheel")
  self._ui.stc_Fade = UI.getChildControl(Panel_CharacterSelect_All, "Static_Fade")
  self._ui.txt_version = UI.getChildControl(Panel_CharacterSelect_All, "StaticText_VersionString")
  self._ui.stc_PrimiumBg = UI.getChildControl(Panel_CharacterSelect_All, "Static_Premium")
  self._ui.txt_PrimiumTitle = UI.getChildControl(self._ui.stc_PrimiumBg, "StaticText_Title")
  self._ui.txt_PrimiumDesc = UI.getChildControl(self._ui.stc_PrimiumBg, "StaticText_Desc")
  self._ui.stc_SeasonBg = UI.getChildControl(Panel_CharacterSelect_All, "Static_Season")
  self._ui.txt_SeasonTitle = UI.getChildControl(self._ui.stc_SeasonBg, "StaticText_Title")
  self._ui.txt_SeasonDesc = UI.getChildControl(self._ui.stc_SeasonBg, "StaticText_Desc")
  self._ui.stc_PrimiumBg:SetShow(false)
  if self._ui.txt_PrimiumDesc:GetTextSizeX() >= self._ui.txt_PrimiumDesc:GetSizeX() then
    local gap = self._ui.txt_PrimiumDesc:GetSizeY()
    self._ui.txt_PrimiumDesc:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_PrimiumDesc:SetText(self._ui.txt_PrimiumDesc:GetText())
    self._ui.txt_PrimiumDesc:SetSize(self._ui.txt_PrimiumDesc:GetSizeX(), self._ui.txt_PrimiumDesc:GetTextSizeY() + 5)
    gap = math.abs(self._ui.txt_PrimiumDesc:GetSizeY() - gap)
    self._ui.stc_PrimiumBg:SetSize(self._ui.stc_PrimiumBg:GetSizeX(), self._ui.stc_PrimiumBg:GetSizeY() + gap)
    self._ui.stc_PrimiumBg:ComputePos()
  end
  self._ui.stc_SeasonBg:SetShow(false)
  if self._ui.txt_SeasonDesc:GetTextSizeX() >= self._ui.txt_SeasonDesc:GetSizeX() then
    local gap = self._ui.txt_SeasonDesc:GetSizeY()
    self._ui.txt_SeasonDesc:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_SeasonDesc:SetText(self._ui.txt_SeasonDesc:GetText())
    self._ui.txt_SeasonDesc:SetSize(self._ui.txt_SeasonDesc:GetSizeX(), self._ui.txt_SeasonDesc:GetTextSizeY() + 10)
    gap = math.abs(self._ui.txt_SeasonDesc:GetSizeY() - gap)
    self._ui.stc_SeasonBg:SetSize(self._ui.stc_SeasonBg:GetSizeX(), self._ui.stc_SeasonBg:GetSizeY() + gap)
    self._ui.stc_SeasonBg:ComputePos()
  end
  local list2content = UI.getChildControl(self._ui.list2_Character, "List2_1_Content")
  local seaIcon = UI.getChildControl(list2content, "Static_ServantView_Sea")
  local name = UI.getChildControl(list2content, "StaticText_Name")
  self._ui.stc_Fade:SetShow(false)
  self._ui.chk_Ghost:SetShow(_ContentsGroup_GhostMode)
  self._ui.chk_Ghost:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENTERTOFIELDMODE_OFFLINE"))
  self._ui._originNameSpanX = name:GetSpanSize().x
  self._ui.btn_Delete:SetTextMode(__eTextMode_AutoWrap)
  self._ui.btn_ChangePosition:SetTextMode(__eTextMode_AutoWrap)
  self._ui.btn_Exit:SetTextMode(__eTextMode_AutoWrap)
  self._ui.btn_BackToServer:SetTextMode(__eTextMode_AutoWrap)
  self._list2OriginY = self._ui.list2_Character:GetSizeY()
  self._seaIconOriginX = seaIcon:GetSpanSize().x
  self._ui._rdoTables[self._TABTYPE._NORMAL] = self._ui.rdo_Normal
  if false == self._isSpecialCharacterOpen then
    self._ui._rdoTables[self._TABTYPE._NORMAL]:SetSpanSize(0, self._ui._rdoTables[self._TABTYPE._NORMAL]:GetSpanSize().y)
  else
    self._ui._rdoTables[self._TABTYPE._PREMIUM] = self._ui.rdo_Special
  end
  self._ui.rdo_Special:SetShow(self._isSpecialCharacterOpen)
  self._ui.stc_SelectLine:SetSpanSize(self._ui.rdo_Normal:GetSpanSize().x, self._ui.stc_SelectLine:GetSpanSize().y)
  local list2Content = UI.getChildControl(self._ui.list2_Character, "List2_1_Content")
  self._listContentsCount = getCharacterSlotLimit(false)
  for idx = 0, self._listContentsCount do
    self._listContentsLaunchTimeTable[idx] = (idx - 1) * 0.03
  end
  self._currentTab = self._TABTYPE._NORMAL
  self._ui._rdoTables[self._currentTab]:SetCheck(true)
  self._isConsole = isGameServiceTypeConsole()
  self._isUsePadSnapping = _ContentsGroup_UsePadSnapping
  PaGlobal_CharacterSelect_All:validate()
  PaGlobal_CharacterSelect_All:registEventHandler(self._isUsePadSnapping)
  PaGlobal_CharacterSelect_All:swichPlatform(self._isUsePadSnapping)
  PaGlobal_CharacterSelect_All._initialize = true
end
function PaGlobal_CharacterSelect_All:registEventHandler(isUsePadSnapping)
  self._ui.list2_Character:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_CharacterSelect_All_List2Update")
  self._ui.list2_Character:createChildContent(__ePAUIList2ElementManagerType_List)
  Panel_CharacterSelect_All:RegisterUpdateFunc("PaGlobalFunc_CharacterSelectAll_PerFrameUpdate")
  Panel_CharacterSelect_All:RegisterShowEventFunc(true, "PaGlobalFunc_NPCShop_ALL_SetANI( true )")
  registerEvent("EventChangeLobbyStageToCharacterSelect", "PaGlobalFunc_CharacterSelect_All_Open")
  registerEvent("EventCancelEnterWating", "FromClient_ChracterSelect_All_CancelEnterWating")
  registerEvent("EventReceiveEnterWating", "FromClient_ChracterSelect_All_ReceiveWaiting")
  registerEvent("EventSetEnterWating", "FromClient_ChracterSelect_All_SetWaitingUserCount")
  if true == isUsePadSnapping then
  else
    self._ui.rdo_Normal:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_TabClick(" .. self._TABTYPE._NORMAL .. ")")
    if true == self._isSpecialCharacterOpen then
      self._ui.rdo_Special:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_TabClick(" .. self._TABTYPE._PREMIUM .. ")")
    end
    self._ui.btn_BackToServer:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_BackToServerSelect()")
    self._ui.btn_Delete:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_Deleting()")
    self._ui.btn_ChangePosition:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_ClickChangePosition()")
    self._ui.btn_Exit:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_ExitGame()")
    self._ui.chk_Ghost:addInputEvent("Mouse_On", "HandleEventOn_CharacterSelect_All_OfflineModeTooltip(true)")
    self._ui.chk_Ghost:addInputEvent("Mouse_Out", "HandleEventOn_CharacterSelect_All_OfflineModeTooltip(false)")
    Panel_CharacterSelect_All:addInputEvent("Mouse_On", "HandleEventOnOut_CharacterSelect_All_LobbyCharacterCursor(true)")
    Panel_CharacterSelect_All:addInputEvent("Mouse_Out", "HandleEventOnOut_CharacterSelect_All_LobbyCharacterCursor(false)")
  end
end
function PaGlobal_CharacterSelect_All:swichPlatform(isUsePadSnapping)
  self._ui.btn_Delete:SetShow(not isUsePadSnapping)
  self._ui.btn_ChangePosition:SetShow(not isUsePadSnapping)
  self._ui.btn_Exit:SetShow(not isUsePadSnapping)
  self._ui.btn_BackToServer:SetShow(not isUsePadSnapping)
  self._ui.chk_Ghost:SetShow(not isUsePadSnapping)
  self._ui.stc_KeyGuide_A:SetShow(isUsePadSnapping)
  self._ui.stc_KeyGuide_B:SetShow(isUsePadSnapping)
  self._ui.stc_KeyGuide_X:SetShow(isUsePadSnapping)
  self._ui.stc_KeyGuide_Y:SetShow(isUsePadSnapping)
  self._ui.stc_KeyGuide_LBRB:SetShow(isUsePadSnapping)
  self._ui.stc_RightClick:SetShow(not isUsePadSnapping)
  self._ui.stc_MouseWheel:SetShow(not isUsePadSnapping)
  if true == self._isConsole then
    PaGlobal_CharacterSelect_All:SetGamerTagShow()
    self._ui.txt_version:SetText("ver." .. tostring(ToClient_getVersionString()))
  else
    local posY = getScreenSizeY() - self._ui.stc_RightClick:GetSizeY() - 20
    self._ui.stc_RightClick:SetPosX(20)
    self._ui.stc_RightClick:SetPosY(posY)
    self._ui.stc_RightClick:SetText(self._ui.stc_RightClick:GetText())
    self._ui.stc_MouseWheel:SetPosX(self._ui.stc_RightClick:GetPosX() + self._ui.stc_RightClick:GetTextSizeX() + 60)
    self._ui.stc_MouseWheel:SetPosY(posY)
  end
end
function PaGlobal_CharacterSelect_All:SetGamerTagShow()
  PaGlobal_CheckGamerTag()
  local uiOffset = ToClient_GetConsoleUIOffset()
  local resizedRatioX = getScreenSizeX() * uiOffset
  local resizedRatioY = getScreenSizeY() * uiOffset
  local gap = 0
  if 0 < resizedRatioX then
    gap = gap + 15
  end
  local scaleX = self._ui.txt_CharacterStatus:GetPosX() + gap + resizedRatioX
  local scaleY = self._ui.txt_CharacterStatus:GetPosY() + self._ui.txt_CharacterStatus:GetSizeY() + 30 + resizedRatioY
  Panel_GamerTag:SetPosX(scaleX)
  Panel_GamerTag:SetPosY(scaleY)
end
function PaGlobal_CharacterSelect_All:prepareOpen(charIdx)
  if true == PaGlobal_CharacterSelect_All._isConsole then
    PaGlobalFunc_Customization_Close()
    PaGlobalFunc_Customization_InputName_Close()
    PaGlobal_CharacterSelect_All:SetGamerTagShow()
  elseif false == PaGlobal_CharacterSelect_All._isUsePadSnapping then
    showAllUI(false)
  else
    PaGlobalFunc_Customization_Close()
    PaGlobalFunc_Customization_InputName_Close()
  end
  if -1 == charIdx or charIdx >= self._playerData.haveCount then
    self._selectedCharIdx = 0
  elseif -2 ~= charIdx then
    self._selectedCharIdx = charIdx
  end
  PaGlobal_CharacterSelect_All:open()
  PaGlobalFunc_CharacterSelect_All_OnScreenResize()
  PaGlobal_CharacterSelect_All:update()
  HandleEventLUp_CharacterSelect_All_CharacterSelect(self._selectedCharIdx, true)
  PaGlobal_CharacterSelect_All:SetKeyGuideShow(self._eKeyGuideType.SELECTED)
end
function PaGlobal_CharacterSelect_All:update()
  self._isPrimiumCharacter = self._ui.rdo_Special:IsCheck()
  self._playerData.maxSlot = PaGlobal_CharacterSelect_All:getMaxSlot(self._isPrimiumCharacter)
  self._playerData.haveCount = getCharacterDataCount(self._isPrimiumCharacter)
  self._playerData.useAbleCount = getCharacterSlotLimit(self._isPrimiumCharacter)
  self._ui.txt_FamilyName:SetText(getFamilyName())
  self._ui.txt_CharacterCount:SetText("(" .. self._playerData.haveCount .. " / " .. self._playerData.useAbleCount .. ")")
  self._ui.btn_ChangePosition:SetMonoTone(self._isPrimiumCharacter)
  self._ui.btn_ChangePosition:SetEnable(not self._isPrimiumCharacter)
  if self._isUsePadSnapping and self._isSpecialCharacterOpen and false == self._ui.btn_ChangePosition:IsCheck() then
    Panel_CharacterSelect_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventLBRB_CharacterSelect_All_TabChange(-1)")
    Panel_CharacterSelect_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventLBRB_CharacterSelect_All_TabChange(1)")
    self._ui.stc_KeyGuide_LB:SetShow(true)
    self._ui.stc_KeyGuide_RB:SetShow(true)
  else
    Panel_CharacterSelect_All:registerPadEvent(__eConsoleUIPadEvent_LB, "")
    Panel_CharacterSelect_All:registerPadEvent(__eConsoleUIPadEvent_RB, "")
    self._ui.stc_KeyGuide_LB:SetShow(false)
    self._ui.stc_KeyGuide_RB:SetShow(false)
  end
  self._ui.stc_PrimiumBg:SetShow(self._isPrimiumCharacter)
  if true == _ContentsGroup_SeasonContents then
    if true == self._isPrimiumCharacter then
      PaGlobal_CharacterSelect_All._ui.stc_SeasonBg:SetShow(false)
    else
      local characterData = getCharacterDataByIndex(self._selectedCharIdx, self._isPrimiumCharacter)
      if nil ~= characterData then
        local isSeasonCharacter = characterData._characterSeasonType == __eCharacterSeasonType_Season
        PaGlobal_CharacterSelect_All._ui.stc_SeasonBg:SetShow(isSeasonCharacter)
      end
    end
  else
    PaGlobal_CharacterSelect_All._ui.stc_SeasonBg:SetShow(false)
  end
  self._canMakeSeason = _ContentsGroup_SeasonContents or _ContentsGroup_PreSeason
  if true == self._isConsole then
    if true == PaGlobalFunc_CharacterSelect_All_IsPositionChangeClick() then
      self._ui.list2_Character:requestUpdateVisible()
    else
      local toIndex = self._ui.list2_Character:getCurrenttoIndex()
      local scrollPos = self._ui.list2_Character:GetVScroll():GetControlPos()
      self._ui.list2_Character:getElementManager():clearKey()
      for idx = 0, self._playerData.useAbleCount - 1 do
        self._ui.list2_Character:getElementManager():pushKey(toInt64(0, idx))
      end
      self._ui.list2_Character:setCurrenttoIndex(toIndex)
      self._ui.list2_Character:GetVScroll():SetControlPos(scrollPos)
    end
  else
    local toIndex = self._ui.list2_Character:getCurrenttoIndex()
    local scrollPos = self._ui.list2_Character:GetVScroll():GetControlPos()
    self._ui.list2_Character:getElementManager():clearKey()
    for idx = 0, self._playerData.useAbleCount - 1 do
      local charData = getCharacterDataByIndex(idx, false)
      if nil ~= charData then
        if true == _ContentsGroup_PreSeason and false == _ContentsGroup_SeasonContents then
          if charData._characterSeasonType == __eCharacterSeasonType_Season then
            self._canMakeSeason = false
          end
        elseif true == _ContentsGroup_SeasonContents and (charData._characterSeasonType == __eCharacterSeasonType_Season or charData._characterSeasonType == __eCharacterSeasonType_Graduation) then
          self._canMakeSeason = false
        end
      end
      self._ui.list2_Character:getElementManager():pushKey(toInt64(0, idx))
    end
    self._ui.list2_Character:setCurrenttoIndex(toIndex)
    self._ui.list2_Character:GetVScroll():SetControlPos(scrollPos)
  end
  self._listContentsCount = self._playerData.useAbleCount
  if nil ~= self._selectedCharIdx and -1 ~= self._selectedCharIdx then
    local removeTime = getCharacterDataRemoveTime(self._selectedCharIdx, self._isPrimiumCharacter)
    self._ui.btn_Delete:SetEnable(nil == removeTime)
    self._ui.btn_Delete:SetMonoTone(nil ~= removeTime, nil ~= removeTime)
    if nil ~= removeTime then
      PaGlobalFunc_CharacterSelect_All_UpdateChracterStatus(nil, removeTime)
    else
      local characterData = getCharacterDataByIndex(self._selectedCharIdx, self._isPrimiumCharacter)
      if nil ~= characterData then
        PaGlobalFunc_CharacterSelect_All_UpdateChracterStatus(characterData)
      end
    end
  end
end
function PaGlobal_CharacterSelect_All:getMaxSlot(isCharacterPrimium)
  local maxcount = 0
  if getCharacterDataCount(isCharacterPrimium) <= getCharacterSlotMaxCount(isCharacterPrimium) then
    maxcount = getCharacterSlotLimit(isCharacterPrimium) + 1
  else
    maxcount = getCharacterDataCount(isCharacterPrimium)
  end
  return maxcount
end
function PaGlobal_CharacterSelect_All:enableEnterBtn(isEnable)
  self._ui.btn_Delete:SetEnable(isEnable)
  self._ui.btn_ChangePosition:SetEnable(isEnable)
  self._ui.btn_Exit:SetEnable(isEnable)
  self._ui.btn_BackToServer:SetEnable(isEnable)
  self._ui.rdo_Normal:SetEnable(isEnable)
  self._ui.rdo_Special:SetEnable(isEnable)
  for idx = 0, #self._ui._btn_EnterTable do
    self._ui._btn_EnterTable[idx]._enter:SetEnable(isEnable)
    self._ui._btn_EnterTable[idx]._delete:SetEnable(isEnable)
    self._ui._btn_EnterTable[idx]._slot:SetEnable(isEnable)
  end
  if true == self._isUsePadSnapping then
    if true == isEnable then
      Panel_CharacterSelect_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventLBRB_CharacterSelect_All_TabChange(-1)")
      Panel_CharacterSelect_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventLBRB_CharacterSelect_All_TabChange(1)")
    else
      Panel_CharacterSelect_All:registerPadEvent(__eConsoleUIPadEvent_LB, "")
      Panel_CharacterSelect_All:registerPadEvent(__eConsoleUIPadEvent_RB, "")
    end
  end
end
function PaGlobal_CharacterSelect_All:open()
  if nil == Panel_CharacterSelect_All then
    return
  end
  Panel_CharacterSelect_All:SetShow(true)
end
function PaGlobal_CharacterSelect_All:prepareClose()
  TooltipSimple_Hide()
  if true == self._isConsole then
    Panel_GamerTag:ComputePos()
  end
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  PaGlobal_CharacterSelect_All:close()
end
function PaGlobal_CharacterSelect_All:close()
  Panel_CharacterSelect_All:SetShow(false)
end
function PaGlobal_CharacterSelect_All:setClassIcon(control, classType)
  control:ChangeTextureInfoName("renewal/ui_icon/console_classsymbol.dds")
  local x1, y1, x2, y2 = 0, 0, 0, 0
  if classType == __eClassType_Warrior then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 172, 57, 228)
  elseif classType == __eClassType_ElfRanger then
    x1, y1, x2, y2 = setTextureUV_Func(control, 58, 172, 114, 228)
  elseif classType == __eClassType_Sorcerer then
    x1, y1, x2, y2 = setTextureUV_Func(control, 115, 172, 171, 228)
  elseif classType == __eClassType_Giant then
    x1, y1, x2, y2 = setTextureUV_Func(control, 172, 172, 228, 228)
  elseif classType == __eClassType_Tamer then
    x1, y1, x2, y2 = setTextureUV_Func(control, 229, 172, 285, 228)
  elseif classType == __eClassType_BladeMaster then
    x1, y1, x2, y2 = setTextureUV_Func(control, 286, 172, 342, 228)
  elseif classType == __eClassType_BladeMasterWoman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 400, 172, 456, 228)
  elseif classType == __eClassType_Valkyrie then
    x1, y1, x2, y2 = setTextureUV_Func(control, 343, 172, 399, 228)
  elseif classType == __eClassType_WizardMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 229, 57, 285)
  elseif classType == __eClassType_WizardWoman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 58, 229, 114, 285)
  elseif classType == __eClassType_Kunoichi then
    x1, y1, x2, y2 = setTextureUV_Func(control, 115, 229, 171, 285)
  elseif classType == __eClassType_NinjaMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 172, 229, 228, 285)
  elseif classType == __eClassType_DarkElf then
    x1, y1, x2, y2 = setTextureUV_Func(control, 229, 229, 285, 285)
  elseif classType == __eClassType_Combattant then
    x1, y1, x2, y2 = setTextureUV_Func(control, 286, 229, 342, 285)
  elseif classType == __eClassType_Mystic then
    x1, y1, x2, y2 = setTextureUV_Func(control, 343, 229, 399, 285)
  elseif classType == __eClassType_Lhan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 400, 229, 456, 285)
  elseif classType == __eClassType_RangerMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 286, 57, 342)
  elseif classType == __eClassType_ShyWaman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 58, 115, 114, 171)
  elseif classType == __eClassType_Hashashin then
    x1, y1, x2, y2 = setTextureUV_Func(control, 172, 286, 228, 342)
  elseif classType == __eClassType_Guardian then
    x1, y1, x2, y2 = setTextureUV_Func(control, 115, 115, 171, 171)
  end
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobal_CharacterSelect_All:setCharacterView(charIdx, classType, isPrimiumCharacter, isChangeSpecialTab)
  if classType == __eClassType_Warrior then
    viewCharacter(charIdx, -50, -40, -65, 0.15, isPrimiumCharacter, isChangeSpecialTab)
    viewCharacterPitchRoll(0, 0)
    viewCharacterFov(0.75)
    setWeatherTime(8, 1)
  elseif classType == __eClassType_ElfRanger then
    viewCharacter(charIdx, -40, -10, -40, 0.45, isPrimiumCharacter, isChangeSpecialTab)
    viewCharacterPitchRoll(-0.05, 0)
    viewCharacterFov(0.55)
    setWeatherTime(8, 0)
  elseif classType == __eClassType_Sorcerer then
    viewCharacter(charIdx, -40, -30, -75, 0.55, isPrimiumCharacter, isChangeSpecialTab)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(8, 9)
    viewCharacterFov(0.55)
  elseif classType == __eClassType_Giant then
    viewCharacter(charIdx, -50, -25, -94, -0.6, isPrimiumCharacter, isChangeSpecialTab)
    viewCharacterPitchRoll(0.2, 0)
    setWeatherTime(8, 3)
    viewCharacterFov(0.85)
  elseif classType == __eClassType_Tamer then
    viewCharacter(charIdx, -30, -50, -94, -0.1, isPrimiumCharacter, isChangeSpecialTab)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(8, 17)
    viewCharacterFov(0.55)
  elseif classType == __eClassType_BladeMaster then
    viewCharacter(charIdx, -20, -45, -94, -0.1, isPrimiumCharacter, isChangeSpecialTab)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(8, 21)
    viewCharacterFov(0.75)
  elseif classType == __eClassType_BladeMasterWoman then
    viewCharacter(charIdx, -20, -25, -114, -0.1, isPrimiumCharacter, isChangeSpecialTab)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(8, 23)
    viewCharacterFov(0.75)
  elseif classType == __eClassType_Valkyrie then
    viewCharacter(charIdx, -20, -20, -94, 1.1, isPrimiumCharacter, isChangeSpecialTab)
    viewCharacterPitchRoll(0, 0)
    viewCharacterFov(0.65)
    setWeatherTime(8, 20)
  elseif classType == __eClassType_WizardMan then
    viewCharacter(charIdx, -20, -20, -94, 1.1, isPrimiumCharacter, isChangeSpecialTab)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(8, 19)
    viewCharacterFov(0.55)
  elseif classType == __eClassType_WizardWoman then
    viewCharacter(charIdx, -20, -20, -94, 1.1, isPrimiumCharacter, isChangeSpecialTab)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(8, 21)
    viewCharacterFov(0.55)
  elseif classType == __eClassType_Kunoichi then
    viewCharacter(charIdx, -25, -25, -94, 1.1, isPrimiumCharacter, isChangeSpecialTab)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(8, 18)
    viewCharacterFov(0.55)
  elseif classType == __eClassType_NinjaMan then
    viewCharacter(charIdx, -20, -20, -100, 1.1, isPrimiumCharacter, isChangeSpecialTab)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(8, 18)
    viewCharacterFov(0.55)
  elseif classType == __eClassType_ShyWaman then
    viewCharacter(charIdx, -18, -54, -178, -0.1, isPrimiumCharacter, isChangeSpecialTab)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(7, 7)
    viewCharacterFov(0.75)
  elseif classType == __eClassType_ShyMan then
  elseif classType == __eClassType_BladeMaster_Reserved1 then
    viewCharacter(charIdx, -20, -45, -114, -0.1, isPrimiumCharacter, isChangeSpecialTab)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(8, 23)
    viewCharacterFov(0.75)
  elseif classType == __eClassType_KunoichiOld then
  elseif classType == __eClassType_DarkElf then
    viewCharacter(charIdx, -20, -45, -114, -0.1, isPrimiumCharacter, isChangeSpecialTab)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(7, 7)
    viewCharacterFov(0.75)
  elseif classType == __eClassType_Combattant then
    viewCharacter(charIdx, -50, -40, -65, 0.15, isPrimiumCharacter, isChangeSpecialTab)
    viewCharacterPitchRoll(0, 0)
    viewCharacterFov(0.75)
    setWeatherTime(7, 16)
  elseif classType == __eClassType_Mystic then
    viewCharacter(charIdx, -20, -25, -114, -0.1, isPrimiumCharacter, isChangeSpecialTab)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(7, 17)
    viewCharacterFov(0.75)
  elseif classType == __eClassType_Lhan then
    viewCharacter(charIdx, -20, -20, -94, -0.4, isPrimiumCharacter, isChangeSpecialTab)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(8, 17)
    viewCharacterFov(0.55)
  elseif classType == __eClassType_RangerMan then
    viewCharacter(charIdx, -20, -30, -94, -0.4, isPrimiumCharacter, isChangeSpecialTab)
    viewCharacterPitchRoll(0, 0)
    viewCharacterFov(0.75)
    setWeatherTime(8, 8)
  elseif classType == __eClassType_Guardian then
    viewCharacter(charIdx, -20, 0, -94, -0.4, isPrimiumCharacter, isChangeSpecialTab)
    viewCharacterPitchRoll(0, 0)
    viewCharacterFov(0.75)
    setWeatherTime(8, 8)
  elseif classType == __eClassType_Hashashin then
    viewCharacter(charIdx, -30, -11, -120, 0.1, isPrimiumCharacter, isChangeSpecialTab)
    viewCharacterPitchRoll(0, 0)
    viewCharacterFov(0.8)
    setWeatherTime(8, 16)
  else
    viewCharacter(charIdx, 0, 0, 0, 0, isPrimiumCharacter, isChangeSpecialTab)
    viewCharacterPitchRoll(0, 0)
  end
end
function PaGlobal_CharacterSelect_All:playListComponentsAni(deltaT)
  self._listContentsLaunchElapsed = self._listContentsLaunchElapsed + deltaT
  local content = self._listContents[_listContentsLaunchedCount]
  if self._playerData.useAbleCount <= self._listContentsLaunchedCount + 1 or nil == self._listContentsLaunchTimeTable[self._listContentsLaunchedCount] then
    self._listContentsShowAniFlag = false
    for ii = 1, #self._listContents do
      self._listContents[ii]:SetShow(true)
      self._listContentsAlphaFlag[ii] = true
      self._listContentsAlphaTarget[ii] = 1
    end
    return
  else
    if nil ~= content and nil ~= content.SetShow and self._listContentsLaunchElapsed >= self._listContentsLaunchTimeTable[self._listContentsLaunchedCount] then
      content:SetShow(true)
      self._listContentsAlphaFlag[self._listContentsLaunchedCount] = true
      self._listContentsAlphaTarget[self._listContentsLaunchedCount] = 1
    end
    self._listContentsLaunchedCount = self._listContentsLaunchedCount + 1
  end
end
function PaGlobal_CharacterSelect_All:animateListComponentsSlide(deltaT, index)
  local content = PaGlobal_CharacterSelect_All._listContents[index]
  if nil == content or nil == PaGlobal_CharacterSelect_All._listContentsSlideTarget[index] then
    return
  end
  local currentPos = content:GetPosX()
  local distance = PaGlobal_CharacterSelect_All._listContentsSlideTarget[index] - currentPos
  local acc = distance / 100 * deltaT * 10
  if -1 < acc and acc < 0 then
    acc = -1
  elseif acc < 1 and 0 < acc then
    acc = 1
  end
  if 1 < math.abs(distance) then
    content:SetPosX(currentPos + acc)
  else
    content:SetPosX(PaGlobal_CharacterSelect_All._listContentsSlideTarget[index])
    PaGlobal_CharacterSelect_All._listContentsSlideFlag[index] = false
  end
end
function PaGlobal_CharacterSelect_All:animateListComponentsAlpha(deltaT, index)
  local content = self._listContents[index]
  if nil == content or nil == self._listContentsAlphaTarget[index] then
    return
  end
  local currentAlpha = content:GetAlpha()
  local distance = self._listContentsAlphaTarget[index] - currentAlpha
  local acc = distance * deltaT * 5
  if 0.01 < math.abs(distance) then
    local nextAlpha = currentAlpha + acc
    content:SetAlphaExtraChild(nextAlpha)
  else
    content:SetAlphaExtraChild(self._listContentsAlphaTarget[index])
    self._listContentsAlphaFlag[index] = false
  end
end
function PaGlobal_CharacterSelect_All:SetKeyGuideShow(type)
  if false == self._isUsePadSnapping then
    return
  end
  self._curKeyGuideIdx = type
  self._ui.stc_KeyGuide_B:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTER_SELECT_BTN_TOSERVER"))
  if self._eKeyGuideType.NOT_SELECT == type then
    self._ui.stc_KeyGuide_LBRB:SetShow(false)
    self._ui.stc_KeyGuide_Y:SetShow(false)
    self._ui.stc_KeyGuide_X:SetShow(self._currentTab == self._TABTYPE._NORMAL)
    self._ui.stc_KeyGuide_A:SetShow(true)
    self._ui.stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_EXCHANGE_SELECT"))
  elseif self._eKeyGuideType.SELECTED == type then
    self._ui.stc_KeyGuide_LBRB:SetShow(false)
    self._ui.stc_KeyGuide_X:SetShow(self._currentTab == self._TABTYPE._NORMAL)
    self._ui.stc_KeyGuide_A:SetShow(true)
    self._ui.stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTER_SELECT_BTN_CONNECT"))
    self._ui.stc_KeyGuide_Y:SetShow(true)
    self._ui.stc_KeyGuide_Y:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_CHANGESKILL_DELETE"))
  elseif self._eKeyGuideType.DELETING == type then
    self._ui.stc_KeyGuide_LBRB:SetShow(false)
    self._ui.stc_KeyGuide_A:SetShow(false)
    self._ui.stc_KeyGuide_X:SetShow(false)
    self._ui.stc_KeyGuide_Y:SetShow(true)
    self._ui.stc_KeyGuide_Y:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTER_SELECT_BTN_DELETECANCEL"))
  elseif self._eKeyGuideType.CHANGEINGSLOT_NOT_SELECTED == type then
    self._ui.stc_KeyGuide_Y:SetShow(false)
    self._ui.stc_KeyGuide_LBRB:SetShow(true)
    self._ui.stc_KeyGuide_X:SetShow(false)
    self._ui.stc_KeyGuide_A:SetShow(true)
    self._ui.stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_EXCHANGE_SELECT"))
    self._ui.stc_KeyGuide_B:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
  elseif self._eKeyGuideType.CHANGEINGSLOT_SELECTED == type then
    self._ui.stc_KeyGuide_A:SetShow(false)
    self._ui.stc_KeyGuide_Y:SetShow(false)
    self._ui.stc_KeyGuide_X:SetShow(false)
    self._ui.stc_KeyGuide_LBRB:SetShow(true)
    self._ui.stc_KeyGuide_B:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
  elseif self._eKeyGuideType.ADD_NEWCHARACTER == type then
    if true == PaGlobalFunc_CharacterSelect_All_IsPositionChangeClick() then
      self._ui.stc_KeyGuide_LBRB:SetShow(false)
      self._ui.stc_KeyGuide_Y:SetShow(false)
      self._ui.stc_KeyGuide_X:SetShow(false)
      self._ui.stc_KeyGuide_A:SetShow(true)
      self._ui.stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_EXCHANGE_SELECT"))
      self._ui.stc_KeyGuide_B:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
    else
      self._ui.stc_KeyGuide_LBRB:SetShow(false)
      self._ui.stc_KeyGuide_Y:SetShow(false)
      self._ui.stc_KeyGuide_X:SetShow(false)
      self._ui.stc_KeyGuide_A:SetShow(true)
      self._ui.stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_EXCHANGE_SELECT"))
    end
  end
  PaGlobal_CharacterSelect_All:keyguideAlign()
end
function PaGlobal_CharacterSelect_All:keyguideAlign()
  PaGlobalFunc_ConsoleKeyGuide_SetAlign({
    self._ui.stc_KeyGuide_X
  }, self._ui.stc_RightBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign({
    self._ui.stc_KeyGuide_B
  }, self._ui.stc_RightBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  local keyguide = {}
  if true == self._ui.btn_ChangePosition:IsCheck() then
    keyguide = {
      self._ui.stc_KeyGuide_LBRB,
      self._ui.stc_KeyGuide_A
    }
  else
    keyguide = {
      self._ui.stc_KeyGuide_Y,
      self._ui.stc_KeyGuide_A
    }
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui.stc_RightBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_CharacterSelect_All:SetMsgDataAndShow(_title, _content, _funcYes, _funcNo, _funcApply, _priority)
  local messageboxData = {}
  messageboxData.title = ""
  messageboxData.content = ""
  messageboxData.priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  messageboxData.functionYes = MessageBox_Empty_function
  messageboxData.functionNo = MessageBox_Empty_function
  messageboxData.functionApply = MessageBox_Empty_function
  if nil ~= _title then
    messageboxData.title = _title
  end
  if nil ~= _content then
    messageboxData.content = _content
  end
  if nil ~= _priority then
    messageboxData.priority = _priority
  end
  if nil ~= _funcYes or nil ~= _funcNo then
    if nil ~= _funcYes then
      messageboxData.functionYes = _funcYes
    end
    if nil ~= _funcNo then
      messageboxData.functionNo = _funcNo
    end
    messageboxData.functionApply = nil
  else
    if nil ~= _funcApply then
      messageboxData.functionApply = _funcApply
    end
    messageboxData.functionYes = nil
    messageboxData.functionNo = nil
  end
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_CharacterSelect_All:validate()
  self._ui.stc_BackGroundBg:isValidate()
  self._ui.stc_RightBg:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.txt_CharacterCount:isValidate()
  self._ui.rdo_Normal:isValidate()
  self._ui.rdo_Special:isValidate()
  self._ui.btn_Delete:isValidate()
  self._ui.btn_ChangePosition:isValidate()
  self._ui.btn_Exit:isValidate()
  self._ui.btn_BackToServer:isValidate()
  self._ui.chk_Ghost:isValidate()
  self._ui.stc_SelectLine:isValidate()
  self._ui.stc_KeyGuide_A:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
  self._ui.stc_KeyGuide_X:isValidate()
  self._ui.stc_KeyGuide_Y:isValidate()
  self._ui.stc_KeyGuide_LBRB:isValidate()
  self._ui.txt_FamilyName:isValidate()
  self._ui.txt_CharacterName:isValidate()
  self._ui.txt_CharacterStatus:isValidate()
  self._ui.list2_Character:isValidate()
  self._ui.stc_RightClick:isValidate()
  self._ui.stc_MouseWheel:isValidate()
  self._ui.stc_Fade:isValidate()
  self._ui.stc_PrimiumBg:isValidate()
  self._ui.txt_PrimiumTitle:isValidate()
  self._ui.txt_PrimiumDesc:isValidate()
  self._ui.stc_SeasonBg:isValidate()
  self._ui.txt_SeasonTitle:isValidate()
  self._ui.txt_SeasonDesc:isValidate()
end
