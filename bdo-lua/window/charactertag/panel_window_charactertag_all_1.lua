function PaGlobal_CharacterTag_All:initialize()
  if true == PaGlobal_CharacterTag_All._initialize or nil == Panel_CharacterTag_All then
    return
  end
  self._ui.stc_titleBg = UI.getChildControl(Panel_CharacterTag_All, "StaticText_Title")
  self._ui_pc.chk_popup = UI.getChildControl(self._ui.stc_titleBg, "CheckButton_PopUp")
  self._ui_pc.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Close")
  self._ui.stc_topBg = UI.getChildControl(Panel_CharacterTag_All, "Static_TopBg")
  self._ui.topDeco.stc_bg = UI.getChildControl(self._ui.stc_topBg, "Static_TopDeco_BG")
  self._ui.topDeco.stc_deco = UI.getChildControl(self._ui.stc_topBg, "Static_TopDeco_1")
  self._ui.topEXP.stc_bg = UI.getChildControl(self._ui.stc_topBg, "Static_TransferEXP_BG")
  self._ui.topEXP.stc_right = UI.getChildControl(self._ui.stc_topBg, "Static_TransferEXP_Right")
  self._ui.topEXP.stc_left = UI.getChildControl(self._ui.stc_topBg, "Static_TransferEXP_Left")
  self._ui.mainImg1.stc_bg = UI.getChildControl(self._ui.stc_topBg, "Static_MainImageBorder_1")
  self._ui.mainImg1.stc_img = UI.getChildControl(self._ui.mainImg1.stc_bg, "Static_MainImage_1")
  self._ui.mainImg1.txt_name = UI.getChildControl(self._ui.mainImg1.stc_bg, "StaticText_Name_1")
  self._ui.mainImg1.txt_lv = UI.getChildControl(self._ui.mainImg1.stc_bg, "StaticText_CharacterLv1")
  self._ui.mainImg1.stc_state = UI.getChildControl(self._ui.mainImg1.stc_bg, "Static_StateIcon")
  self._ui.mainImg1.txt_getExp = UI.getChildControl(self._ui.mainImg1.stc_bg, "StaticText_getEXP_Left")
  self._ui.mainImg1.txt_getSkillExp = UI.getChildControl(self._ui.mainImg1.stc_bg, "StaticText_getSkillEXP_Left")
  self._ui.mainImg2.stc_bg = UI.getChildControl(self._ui.stc_topBg, "Static_MainImageBorder_2")
  self._ui.mainImg2.stc_img = UI.getChildControl(self._ui.mainImg2.stc_bg, "Static_MainImage_2")
  self._ui.mainImg2.txt_name = UI.getChildControl(self._ui.mainImg2.stc_bg, "StaticText_Name_2")
  self._ui.mainImg2.txt_lv = UI.getChildControl(self._ui.mainImg2.stc_bg, "StaticText_CharacterLv2")
  self._ui.mainImg2.stc_state = UI.getChildControl(self._ui.mainImg2.stc_bg, "Static_StateIcon2")
  self._ui.mainImg2.txt_getExp = UI.getChildControl(self._ui.mainImg2.stc_bg, "StaticText_getEXP_Right")
  self._ui.mainImg2.txt_getSkillExp = UI.getChildControl(self._ui.mainImg2.stc_bg, "StaticText_getSkillEXP_Right")
  self._ui.mainImg2.stc_addIcon = UI.getChildControl(self._ui.mainImg2.stc_bg, "Static_AddIcon")
  self._ui.txt_tagAreaTitle = UI.getChildControl(self._ui.stc_topBg, "StaticText_TagAreaTitle")
  self._ui.txt_tagAreaValue = UI.getChildControl(self._ui.stc_topBg, "StaticText_TagAreaValue")
  self._ui.chk_tagState = UI.getChildControl(self._ui.stc_topBg, "CheckButton_TagState")
  self._ui.chk_tagStateExp = UI.getChildControl(self._ui.stc_topBg, "CheckButton_TagStateExp")
  self._ui.btn_takeEXP = UI.getChildControl(Panel_CharacterTag_All, "Button_TakeEXP")
  self._ui.btn_charTAG = UI.getChildControl(Panel_CharacterTag_All, "Button_CharTag")
  self._ui.btn_ItemCopy = UI.getChildControl(Panel_CharacterTag_All, "Button_ItemCopy")
  self._ui.stc_eventDescBg = UI.getChildControl(Panel_CharacterTag_All, "Static_EventDescBG")
  self._ui.txt_eventDesc = UI.getChildControl(self._ui.stc_eventDescBg, "StaticText_EventDesc")
  self._ui.stc_midBg = UI.getChildControl(Panel_CharacterTag_All, "Static_MidBg")
  self._ui.stc_template = UI.getChildControl(self._ui.stc_midBg, "Static_CharacterImageBorderTemplate")
  self._ui.stc_templateBorder = UI.getChildControl(self._ui.stc_template, "Static_BG")
  self._ui.stc_templateImage = UI.getChildControl(self._ui.stc_template, "Static_CharacterImage")
  self._ui.stc_templateSelect = UI.getChildControl(self._ui.stc_template, "Static_Select")
  self._ui.txt_templateLevel = UI.getChildControl(self._ui.stc_template, "StaticText_Level")
  self._ui.txt_templateState = UI.getChildControl(self._ui.stc_template, "StaticText_State")
  self._ui.stc_templateOnline = UI.getChildControl(self._ui.stc_template, "Static_Online")
  self._ui.stc_scrollBg = UI.getChildControl(self._ui.stc_midBg, "Scroll_Tag")
  self._ui.stc_descBg = UI.getChildControl(Panel_CharacterTag_All, "Static_DescBg")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_descBg, "StaticText_Desc")
  self._ui_console.stc_keyGuideBg = UI.getChildControl(Panel_CharacterTag_All, "Static_KeyGuide_Console")
  self._ui_console.stc_keyConfirm = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Select_Console")
  self._ui_console.stc_keyCancle = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Close_Console")
  self._ui_pc.chk_popup:SetShow(_ContentsGroup_PopUp)
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_DESC"))
  self._ui.txt_desc:SetShow(true)
  local txtSizeY = self._ui.txt_desc:GetTextSizeY()
  local sumSizeY = txtSizeY + 10 - self._ui.stc_descBg:GetSizeY()
  self._ui.stc_descBg:SetSize(self._ui.stc_descBg:GetSizeX(), txtSizeY + 10)
  Panel_CharacterTag_All:SetSize(Panel_CharacterTag_All:GetSizeX(), Panel_CharacterTag_All:GetSizeY() + sumSizeY)
  self._ui.stc_descBg:ComputePos()
  self._ui.txt_desc:ComputePos()
  self._ui.chk_tagState:SetIgnore(false)
  self._ui.chk_tagStateExp:SetIgnore(false)
  self._ui.btn_takeEXP:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_BUTTON_TAKEEXP"))
  self._ui.mainImg1.txt_getExp:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_GETEXP"))
  self._ui.mainImg1.txt_getSkillExp:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_GETSKILLEXP"))
  self._ui.mainImg2.txt_getExp:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_GETEXP"))
  self._ui.mainImg2.txt_getSkillExp:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_GETSKILLEXP"))
  self._ui.stc_eventDescBg:SetShow(false)
  local gabY = 10
  self._ui.stc_topBg:SetSpanSize(self._ui.stc_topBg:GetSpanSize().x, self._ui.stc_titleBg:GetSizeY())
  Panel_CharacterTag_All:SetSize(Panel_CharacterTag_All:GetSizeX(), Panel_CharacterTag_All:GetSizeY() - self._ui.stc_eventDescBg:GetSizeY())
  self._ui.stc_midBg:SetSpanSize(self._ui.stc_midBg:GetSpanSize().x, self._ui.stc_descBg:GetSizeY() + 20)
  self._ui.btn_charTAG:SetSpanSize(self._ui.btn_charTAG:GetSpanSize().x, self._ui.stc_titleBg:GetSizeY() + self._ui.stc_topBg:GetSizeY() - self._ui.btn_charTAG:GetSizeY())
  self._ui.btn_takeEXP:SetSpanSize(self._ui.btn_takeEXP:GetSpanSize().x, self._ui.stc_titleBg:GetSizeY() + self._ui.stc_topBg:GetSizeY() - self._ui.btn_takeEXP:GetSizeY())
  self._ui.btn_ItemCopy:SetSpanSize(self._ui.btn_ItemCopy:GetSpanSize().x, self._ui.stc_titleBg:GetSizeY() + self._ui.stc_topBg:GetSizeY() - self._ui.btn_ItemCopy:GetSizeY())
  self._ui.stc_topBg:ComputePos()
  self._ui.btn_takeEXP:ComputePos()
  self._ui.btn_charTAG:ComputePos()
  self._ui.stc_descBg:ComputePos()
  self._ui.stc_midBg:ComputePos()
  self._ui.stc_scrollBg:ComputePos()
  self._ui_console.stc_keyGuideBg:ComputePos()
  self._isPadSnap = _ContentsGroup_UsePadSnapping
  self._maxCharacterCount = getCharacterDataCount()
  for index = 0, 5 do
    self._ui.characterList[index] = UI.createControl(__ePAUIControl_Static, Panel_CharacterTag_All, "Static_CharacterList_" .. index)
    CopyBaseProperty(self._ui.stc_template, self._ui.characterList[index])
    local stc_image = UI.createControl(__ePAUIControl_Static, self._ui.characterList[index], "Static_CharacterImage")
    CopyBaseProperty(self._ui.stc_templateImage, stc_image)
    local stc_state = UI.createControl(__ePAUIControl_StaticText, self._ui.characterList[index], "StaticText_State")
    CopyBaseProperty(self._ui.txt_templateState, stc_state)
    local txt_level = UI.createControl(__ePAUIControl_StaticText, self._ui.characterList[index], "StaticText_Level")
    CopyBaseProperty(self._ui.txt_templateLevel, txt_level)
    local stc_border = UI.createControl(__ePAUIControl_Static, self._ui.characterList[index], "Static_BG")
    CopyBaseProperty(self._ui.stc_templateBorder, stc_border)
    local stc_select = UI.createControl(__ePAUIControl_Static, self._ui.characterList[index], "Static_Select")
    CopyBaseProperty(self._ui.stc_templateSelect, stc_select)
    local stc_online = UI.createControl(__ePAUIControl_Static, self._ui.characterList[index], "Static_Online")
    CopyBaseProperty(self._ui.stc_templateOnline, stc_online)
    stc_border:SetShow(false)
    self._ui.characterList[index]:SetShow(false)
    self._ui.characterList[index]:addInputEvent("Mouse_UpScroll", "HandleEventScroll_CharacterTag_All_ScrollEvent(true)")
    self._ui.characterList[index]:addInputEvent("Mouse_DownScroll", "HandleEventScroll_CharacterTag_All_ScrollEvent(false)")
    stc_border:addInputEvent("Mouse_UpScroll", "HandleEventScroll_CharacterTag_All_ScrollEvent(true)")
    stc_border:addInputEvent("Mouse_DownScroll", "HandleEventScroll_CharacterTag_All_ScrollEvent(false)")
    self._ui.btn_ItemCopy:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterTag_All_ItemCopy()")
    self._ui.characterList[index]:SetPosX(self._ui.stc_midBg:GetPosX() + 10 + self._ui.characterList[index]:GetSizeX() * (index % self.LOCAL_DEFINE.CHARSLOTCOLMAX))
    self._ui.characterList[index]:SetPosY(self._ui.stc_midBg:GetPosY() + 5 + math.floor(index / self.LOCAL_DEFINE.CHARSLOTCOLMAX) * self._ui.characterList[index]:GetSizeY())
  end
  self._ui.stc_template:SetShow(false)
  self._ui.stc_template:SetIgnore(not self._isPadSnap)
  UIScroll.SetButtonSize(self._ui.stc_scrollBg, 1, math.ceil(self._maxCharacterCount / 6))
  UIScroll.InputEvent(self._ui.stc_scrollBg, "HandleEventScroll_CharacterTag_All_ScrollEvent")
  PaGlobal_CharacterTag_All:validate()
  PaGlobal_CharacterTag_All:registEventHandler()
  PaGlobal_CharacterTag_All:swichPlatform(self._isPadSnap)
  PaGlobal_CharacterTag_All._initialize = true
end
function PaGlobal_CharacterTag_All:swichPlatform(isPadSnap)
  if true == isPadSnap then
    self._ui_pc.chk_popup:SetShow(false)
    self._ui_pc.btn_close:SetShow(false)
    self._ui_console.stc_keyGuideBg:SetShow(true)
  else
    self._ui_pc.chk_popup:SetShow(true)
    self._ui_pc.btn_close:SetShow(true)
    self._ui_console.stc_keyGuideBg:SetShow(false)
  end
end
function PaGlobal_CharacterTag_All:prepareOpen()
  if nil == Panel_CharacterTag_All then
    return
  end
  if false == _ContentsGroup_CharacterTag then
    return
  end
  if -1 == ToClient_GetMyCharacterIndex() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_PREMIUMCHARACTER"))
    return
  end
  self:WindowPosition()
  self:dataclear()
  PaGlobal_CharacterTag_All:update()
  PaGlobal_CharacterTag_All:open()
end
function PaGlobal_CharacterTag_All:WindowPosition()
  if nil == Panel_CharacterTag_All then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local panelSizeX = Panel_CharacterTag_All:GetSizeX()
  local panelSizeY = Panel_CharacterTag_All:GetSizeY()
  Panel_CharacterTag_All:SetPosX(screenSizeX / 2 - panelSizeX / 2)
  Panel_CharacterTag_All:SetPosY(math.max(0, (screenSizeY - panelSizeY) / 2))
end
function PaGlobal_CharacterTag_All:dataclear()
  if nil == Panel_CharacterTag_All then
    return
  end
  self._ui.chk_tagState:SetIgnore(false)
  self._ui.chk_tagState:SetMonoTone(false)
  self._ui.chk_tagStateExp:SetIgnore(false)
  self._ui.chk_tagStateExp:SetMonoTone(false)
  self._ui.mainImg2.stc_img:SetShow(true)
  self._ui.mainImg2.stc_addIcon:SetShow(true)
  self._ui.mainImg2.stc_img:ChangeTextureInfoName("")
  self._ui.mainImg2.stc_img:setRenderTexture(self._ui.mainImg2.stc_img:getBaseTexture())
  self._requestCharacterKey = -1
  for ii = 0, 5 do
    self._ui.characterList[ii]:SetShow(false)
  end
end
function PaGlobal_CharacterTag_All:open()
  if nil == Panel_CharacterTag_All then
    return
  end
  Panel_CharacterTag_All:SetShow(true)
end
function PaGlobal_CharacterTag_All:prepareClose()
  if nil == Panel_CharacterTag_All then
    return
  end
  Panel_CharacterTag_All:CloseUISubApp()
  self._ui_pc.chk_popup:SetCheck(false)
  PaGlobal_CharacterTag_All:close()
end
function PaGlobal_CharacterTag_All:close()
  if nil == Panel_CharacterTag_All then
    return
  end
  Panel_CharacterTag_All:SetShow(false)
end
function PaGlobal_CharacterTag_All:update()
  self:loadMainFace()
  self:loadList()
  self:expInfoShow()
end
function PaGlobal_CharacterTag_All:loadMainFace()
  local selfPlayer = getSelfPlayer()
  local duelCharIndex = ToClient_GetMyDuelCharacterIndex()
  local selfCharIndex = ToClient_GetMyCharacterIndex()
  local isSetLeft = false
  local isSetRight = false
  local selfPlayerChar_No_s64 = selfPlayer:getCharacterNo_64()
  local selfPos = float3(selfPlayer:get():getPositionX(), selfPlayer:get():getPositionY(), selfPlayer:get():getPositionZ())
  local characterCount = getCharacterDataCount() - 1
  self._ui.txt_tagAreaValue:SetText(getRegionInfoByPosition(selfPos):getAreaName())
  if self.LOCAL_DEFINE.NODUEL == duelCharIndex then
    self._selfCharTag = false
    for idx = 0, characterCount do
      local characterData = getCharacterDataByIndex(idx)
      local duelChar_No_s64 = characterData._duelCharacterNo
      local duelChar_No_s32 = Int64toInt32(duelChar_No_s64)
      if self.LOCAL_DEFINE.NODUEL ~= duelChar_No_s32 then
        if false == isSetLeft then
          self:setLeftFace(idx)
          isSetLeft = true
          self._ui.chk_tagState:SetCheck(true)
          self._ui.chk_tagStateExp:SetCheck(true)
        else
          self:setRightFace(idx)
          isSetRight = true
          self._currentTagState = true
          self._ui.mainImg2.stc_addIcon:SetShow(false)
        end
      end
    end
    if false == isSetLeft or false == isSetRight then
      isSetLeft = true
      self:setLeftFace(selfCharIndex, false)
      self._ui.chk_tagState:SetCheck(false)
      self._ui.chk_tagStateExp:SetCheck(false)
      self._ui.mainImg2.stc_img:ChangeTextureInfoName("")
      self._ui.mainImg2.txt_name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_SETTING_TARGET"))
      self._selfCharTag = true
      self._currentTagState = false
      self._ui.mainImg2.stc_addIcon:SetShow(true)
      if false == isSetRight then
        self._ui.mainImg2.txt_lv:SetShow(false)
        self._ui.mainImg2.stc_state:SetShow(false)
      end
    end
  else
    isSetLeft = true
    self:setLeftFace(selfCharIndex)
    self:setRightFace(duelCharIndex)
    self._currentTagState = true
    self._ui.chk_tagStateExp:SetCheck(true)
    self._ui.chk_tagState:SetCheck(true)
    self._selfCharTag = true
    self._ui.mainImg2.stc_addIcon:SetShow(false)
  end
  if false == self._selfCharTag then
    self._ui.chk_tagState:SetMonoTone(true)
    self._ui.chk_tagState:SetIgnore(true)
    self._ui.chk_tagStateExp:SetMonoTone(true)
    self._ui.chk_tagStateExp:SetIgnore(true)
  end
end
function PaGlobal_CharacterTag_All:loadList()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isSetLeft = false
  local selfPlayerIndex = ToClient_GetMyCharacterIndex()
  local selfPlayerChar_No_s64 = selfPlayer:getCharacterNo_64()
  local selfPos = float3(selfPlayer:get():getPositionX(), selfPlayer:get():getPositionY(), selfPlayer:get():getPositionZ())
  local selfPlayerRegionInfoKey = getRegionInfoByPosition(selfPos):getRegionKey()
  local duelCharIndex = ToClient_GetMyDuelCharacterIndex()
  local characterListMax = getCharacterDataCount()
  for jj = 0, 5 do
    self._ui.characterList[jj]:SetShow(false)
  end
  for idx = 0, 5 do
    local ii = idx + self._pageIndex * 6
    if ii > characterListMax - 1 then
      return
    end
    local targetUI = self._ui.characterList[idx]
    local targetImage = UI.getChildControl(targetUI, "Static_CharacterImage")
    local targetLevel = UI.getChildControl(targetUI, "StaticText_Level")
    local targetState = UI.getChildControl(targetUI, "StaticText_State")
    local targetSelect = UI.getChildControl(targetUI, "Static_Select")
    local targetOnline = UI.getChildControl(targetUI, "Static_Online")
    local characterData = getCharacterDataByIndex(ii)
    local char_Type = getCharacterClassType(characterData)
    local char_Level = string.format("%d", characterData._level)
    local char_Name = getCharacterName(characterData)
    local char_No_s64 = characterData._characterNo_s64
    local char_TextureName = getCharacterFaceTextureByIndex(ii)
    local pcDeliveryRegionKey = characterData._arrivalRegionKey
    local char_float3_position = characterData._currentPosition
    local duelChar_No_s64 = characterData._duelCharacterNo
    local duelRegion_Key = characterData._duelRegionKey
    local currentChar_Tag = false
    targetUI:SetShow(true)
    self:setMonoToneIgnore(targetUI, targetImage, false)
    targetState:SetTextMode(__eTextMode_AutoWrap)
    targetState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_CANDO"))
    targetState:SetShow(true)
    local isExitPhoto = false
    if true == _ContentsGroup_NewUI_GameExit then
      isExitPhoto = PaGlobal_GameExit_All_GetIsExitPhoto()
    else
      isExitPhoto = PaGlobal_getIsExitPhoto()
    end
    local isCaptureExist = targetImage:ChangeTextureInfoNameNotDDS(char_TextureName, char_Type, isExitPhoto)
    if isCaptureExist == true then
      targetImage:getBaseTexture():setUV(0, 0, 1, 1)
    else
      self:faceSetting(targetImage, char_Type)
    end
    targetImage:setRenderTexture(targetImage:getBaseTexture())
    targetLevel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. char_Level)
    targetImage:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterTag_All_ClickCharacterList(" .. tostring(ii) .. ")")
    targetImage:addInputEvent("Mouse_UpScroll", "HandleEventScroll_CharacterTag_All_ScrollEvent(true)")
    targetImage:addInputEvent("Mouse_DownScroll", "HandleEventScroll_CharacterTag_All_ScrollEvent(false)")
    if true == _ContentsGroup_UsePadSnapping then
      targetUI:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "HandleEventScroll_CharacterTag_All_ScrollEvent(true)")
      targetUI:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "HandleEventScroll_CharacterTag_All_ScrollEvent(false)")
      targetUI:SetIgnore(false)
    else
      targetUI:SetIgnore(true)
    end
    local regionInfo = getRegionInfoByPosition(char_float3_position)
    local serverUtc64 = getServerUtc64()
    local workingText
    if false == _ContentsGroup_RenewUI_ExitGame then
      if true == _ContentsGroup_NewUI_GameExit then
        workingText = PaGlobal_GameExit_All_GetWorkTypeString(characterData._pcWorkingType)
      else
        workingText = global_workTypeToStringSwap(characterData._pcWorkingType)
      end
    else
      workingText = PaGlobalFunc_GameExit_workTypeToStringSwap(characterData._pcWorkingType)
    end
    targetSelect:SetShow(false)
    if 0 ~= pcDeliveryRegionKey:get() and serverUtc64 < characterData._arrivalTime then
      self:setMonoToneIgnore(targetUI, targetImage, true)
      targetState:SetText(PAGetString(Defines.StringSheet_GAME, "CHARACTER_WORKING_TEXT_DELIVERY"))
    elseif selfPlayerRegionInfoKey ~= pcDeliveryRegionKey:get() and 0 ~= pcDeliveryRegionKey:get() and serverUtc64 > characterData._arrivalTime then
      local retionInfoArrival = getRegionInfoByRegionKey(pcDeliveryRegionKey)
      self:setMonoToneIgnore(targetUI, targetImage, true)
      targetState:SetText(tostring(retionInfoArrival:getAreaName()))
    elseif "" ~= workingText then
      targetState:SetText(workingText)
      self:setMonoToneIgnore(targetUI, targetImage, true)
    elseif self.LOCAL_DEFINE.NODUEL ~= Int64toInt32(duelChar_No_s64) then
      self:setMonoToneIgnore(targetUI, targetImage, true)
      targetState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_ALREADY_TAG"))
      if ii ~= selfPlayerIndex then
        targetSelect:SetShow(true)
      end
    elseif selfPlayerRegionInfoKey ~= regionInfo:getRegionKey() or false == regionInfo:get():isMainOrMinorTown() then
      self:setMonoToneIgnore(targetUI, targetImage, true)
      targetState:SetText(tostring(regionInfo:getAreaName()))
    end
    if selfPlayerRegionInfoKey == pcDeliveryRegionKey:get() and 0 ~= pcDeliveryRegionKey:get() and serverUtc64 > characterData._arrivalTime then
      self:setMonoToneIgnore(targetUI, targetImage, false)
      targetState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_CANDO"))
    end
    local removeTime = getCharacterDataRemoveTime(idx)
    if nil ~= removeTime then
      self:setMonoToneIgnore(targetUI, targetImage, true)
      targetState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTER_DELETE"))
    end
    targetOnline:SetShow(false)
    if ii == selfPlayerIndex then
      targetState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_LASTONLINETIME"))
      targetOnline:SetShow(true)
      self:setMonoToneIgnore(targetUI, targetImage, true)
    end
    if true == self._currentTagState then
      self:setMonoToneIgnore(targetUI, targetImage, true)
      targetState:SetText(tostring(regionInfo:getAreaName()))
    end
  end
end
function PaGlobal_CharacterTag_All:setLeftFace(idx, isRegionKey)
  local characterData = getCharacterDataByIndex(idx)
  local char_Type = getCharacterClassType(characterData)
  local char_Level = string.format("%d", characterData._level)
  local char_Name = getCharacterName(characterData)
  local char_TextureName = getCharacterFaceTextureByIndex(idx)
  local duelChar_No_s64 = characterData._duelCharacterNo
  local duelRegion_Key = characterData._duelRegionKey
  local isExitPhoto = false
  if true == _ContentsGroup_NewUI_GameExit then
    isExitPhoto = PaGlobal_GameExit_All_GetIsExitPhoto()
  else
    isExitPhoto = PaGlobal_getIsExitPhoto()
  end
  local isCaptureExist = self._ui.mainImg1.stc_img:ChangeTextureInfoNameNotDDS(char_TextureName, char_Type, isExitPhoto)
  if true == isCaptureExist then
    self._ui.mainImg1.stc_img:getBaseTexture():setUV(0, 0, 1, 1)
  else
    self:faceSetting(self._ui.mainImg1.stc_img, char_Type)
  end
  self._ui.mainImg1.stc_img:setRenderTexture(self._ui.mainImg1.stc_img:getBaseTexture())
  self._ui.mainImg1.txt_lv:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. char_Level)
  self._ui.mainImg1.txt_name:SetText(char_Name)
  local RegionInfo = getRegionInfoByRegionKey(duelRegion_Key)
  if nil ~= RegionInfo then
    self._ui.txt_tagAreaValue:SetText(getRegionInfoByRegionKey(duelRegion_Key):getAreaName())
  end
end
function PaGlobal_CharacterTag_All:setRightFace(idx)
  local characterData = getCharacterDataByIndex(idx)
  local char_Type = getCharacterClassType(characterData)
  local char_Level = string.format("%d", characterData._level)
  local char_Name = getCharacterName(characterData)
  local char_TextureName = getCharacterFaceTextureByIndex(idx)
  local duelChar_No_s64 = characterData._duelCharacterNo
  local duelRegion_Key = characterData._duelRegionKey
  local isExitPhoto = false
  if true == _ContentsGroup_NewUI_GameExit then
    isExitPhoto = PaGlobal_GameExit_All_GetIsExitPhoto()
  else
    isExitPhoto = PaGlobal_getIsExitPhoto()
  end
  local isCaptureExist = self._ui.mainImg2.stc_img:ChangeTextureInfoNameNotDDS(char_TextureName, char_Type, isExitPhoto)
  if true == isCaptureExist then
    self._ui.mainImg2.stc_img:getBaseTexture():setUV(0, 0, 1, 1)
  else
    self:faceSetting(self._ui.mainImg2.stc_img, char_Type)
  end
  self._ui.mainImg2.stc_img:setRenderTexture(self._ui.mainImg2.stc_img:getBaseTexture())
  self._ui.mainImg2.txt_lv:SetShow(true)
  self._ui.mainImg2.txt_lv:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. char_Level)
  self._ui.mainImg2.txt_name:SetText(char_Name)
  self._requestCharacterKey = characterData._characterNo_s64
  self._selectCharaterSlot._Lv = characterData._level
  self._selectCharaterSlot._ClassType = char_Type
end
function PaGlobal_CharacterTag_All:setMonoToneIgnore(UIControl, ImageControl, value)
  ImageControl:SetMonoTone(value)
  ImageControl:SetIgnore(value)
  if false == self._isPadSnap then
    UIControl:SetIgnore(value)
  end
end
function PaGlobal_CharacterTag_All:expInfoShow()
  local showType = self.SHOW_TYPE.NORMAL
  local subCharacter = getCharacterDataByIndex(ToClient_GetMyDuelCharacterIndex())
  local subCharacterLV = 0
  if true == ToClient_isDuelCharacterExpClass(getSelfPlayer():getClassType()) then
    showType = self.SHOW_TYPE.ARCHER_TAG
  end
  if nil ~= subCharacter then
    local subType = getCharacterClassType(subCharacter)
    if true == ToClient_isDuelCharacterExpClass(subType) then
      showType = self.SHOW_TYPE.TAKE_EXP
    end
    subCharacterLV = subCharacter._level
  end
  self:showManager(showType, subCharacterLV)
end
function PaGlobal_CharacterTag_All:showManager(showModeNum, CharLV)
  self._ui.btn_takeEXP:SetShow(false)
  self._ui.btn_charTAG:SetShow(true)
  self._ui.mainImg1.txt_getExp:SetShow(false)
  self._ui.mainImg1.txt_getSkillExp:SetShow(false)
  self._ui.mainImg2.txt_getExp:SetShow(false)
  self._ui.mainImg2.txt_getSkillExp:SetShow(false)
  if -1 == ToClient_GetMyDuelCharacterIndex() and true == self._currentTagState then
    self._ui.btn_charTAG:SetShow(false)
  end
  if false == _ContentsGroup_AddExpEvent_TagCharacter and false == ToClient_doHaveDuelExp() then
    showModeNum = 0
  end
  for idx = 0, 5 do
    local targetUI = self._ui.characterList[idx]
    local Static_BG = UI.getChildControl(targetUI, "Static_BG")
    Static_BG:SetShow(false)
    self._sideImg._page = -1
    self._sideImg._index = -1
  end
  if true == ToClient_doHaveDuelExp() then
    self._ui.btn_takeEXP:SetShow(true)
    self._ui.btn_charTAG:SetShow(false)
  else
    self._ui.btn_takeEXP:SetShow(false)
    self._ui.btn_charTAG:SetShow(true)
  end
  if self.SHOW_TYPE.NORMAL == showModeNum or -1 == ToClient_GetMyDuelCharacterIndex() then
    self._ui.topDeco.stc_bg:SetShow(true)
    self._ui.topDeco.stc_deco:SetShow(true)
    self._ui.topEXP.stc_bg:SetShow(false)
    self._ui.topEXP.stc_right:SetShow(false)
    self._ui.topEXP.stc_left:SetShow(false)
    self._ui.chk_tagState:SetShow(true)
    self._ui.chk_tagStateExp:SetShow(false)
    self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_DESC"))
  elseif showModeNum >= self.SHOW_TYPE.ARCHER_TAG then
    self._ui.topDeco.stc_bg:SetShow(false)
    self._ui.topDeco.stc_deco:SetShow(false)
    self._ui.topEXP.stc_bg:SetShow(true)
    self._ui.topEXP.stc_right:SetShow(true)
    self._ui.topEXP.stc_left:SetShow(false)
    self._ui.chk_tagState:SetShow(true)
    self._ui.chk_tagStateExp:SetShow(true)
    self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TAKEEXP_DESC"))
    self:changeExpBG()
  end
  if true == self._currentTagState then
    self._ui.btn_charTAG:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_DELETEDUEL"))
    self._ui.mainImg2.stc_state:SetShow(true)
    if true == _ContentsGroup_DuelCharacterCopyEquip then
      self._ui.btn_charTAG:SetSpanSize(-140, self._ui.stc_titleBg:GetSizeY() + self._ui.stc_topBg:GetSizeY() - self._ui.btn_charTAG:GetSizeY())
      self._ui.btn_ItemCopy:SetShow(true)
    end
  else
    self._ui.btn_charTAG:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_REQUESTDUEL"))
    if true == _ContentsGroup_DuelCharacterCopyEquip then
      self._ui.btn_charTAG:SetSpanSize(0, self._ui.stc_titleBg:GetSizeY() + self._ui.stc_topBg:GetSizeY() - self._ui.btn_charTAG:GetSizeY())
      self._ui.btn_ItemCopy:SetShow(false)
    end
  end
end
function PaGlobal_CharacterTag_All:changeExpBG()
  if -1 == ToClient_GetMyDuelCharacterIndex() then
    return
  end
  local characterData = getCharacterDataByIndex(ToClient_GetMyDuelCharacterIndex())
  local char_Type = getCharacterClassType(characterData)
  local CharLV = characterData._level
  if true == ToClient_isDuelCharacterExpClass(char_Type) and false == ToClient_isDuelCharacterExpClass(getSelfPlayer():getClassType()) then
    self._ui.mainImg1.txt_getExp:SetShow(true)
    self._ui.mainImg1.txt_getSkillExp:SetShow(true)
    self._ui.mainImg2.txt_getExp:SetShow(false)
    self._ui.mainImg2.txt_getSkillExp:SetShow(false)
    self._ui.topEXP.stc_right:SetShow(false)
    self._ui.topEXP.stc_left:SetShow(true)
    CharLV = getSelfPlayer():get():getLevel()
  else
    self._ui.mainImg1.txt_getExp:SetShow(false)
    self._ui.mainImg1.txt_getSkillExp:SetShow(false)
    self._ui.mainImg2.txt_getExp:SetShow(true)
    self._ui.mainImg2.txt_getSkillExp:SetShow(true)
    self._ui.topEXP.stc_right:SetShow(true)
    self._ui.topEXP.stc_left:SetShow(false)
  end
  if nil ~= CharLV and 0 < CharLV and CharLV >= ToClient_getSubDuelCharacterLimitLevel() then
    self._ui.mainImg1.txt_getExp:SetShow(false)
    self._ui.mainImg2.txt_getExp:SetShow(false)
  end
end
function PaGlobal_CharacterTag_All:faceSetting(targetImage, char_Type)
  if _ContentsGroup_isUsedNewCharacterInfo == false then
    if char_Type == __eClassType_Warrior then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 1, 1, 156, 201)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == __eClassType_ElfRanger then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 157, 1, 312, 201)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == __eClassType_Sorcerer then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 313, 1, 468, 201)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == __eClassType_Giant then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 1, 202, 156, 402)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == __eClassType_Tamer then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 157, 202, 312, 402)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == __eClassType_BladeMaster then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 313, 202, 468, 402)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == __eClassType_Valkyrie then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_01.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 1, 1, 156, 201)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == __eClassType_BladeMasterWoman then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_01.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 157, 1, 312, 201)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == __eClassType_WizardMan then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_01.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 313, 1, 468, 201)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == __eClassType_WizardWoman then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_01.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 1, 202, 156, 402)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == __eClassType_Kunoichi then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_01.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 157, 202, 312, 402)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == __eClassType_NinjaMan then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_01.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 313, 202, 468, 402)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == __eClassType_DarkElf then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_02.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 1, 1, 156, 201)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == __eClassType_Combattant then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_02.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 157, 1, 312, 201)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    elseif char_Type == __eClassType_Mystic then
      targetImage:ChangeTextureInfoName("New_UI_Common_forLua/Window/GameExit/GameExit_CharSlot_02.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(targetImage, 313, 1, 468, 201)
      targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
      targetImage:setRenderTexture(targetImage:getBaseTexture())
    end
  else
    local DefaultFace = CppEnums.ClassType_DefaultFaceTexture[char_Type]
    targetImage:ChangeTextureInfoName(DefaultFace[1])
    local x1, y1, x2, y2 = setTextureUV_Func(targetImage, DefaultFace[2], DefaultFace[3], DefaultFace[4], DefaultFace[5])
    targetImage:getBaseTexture():setUV(x1, y1, x2, y2)
  end
end
function PaGlobal_CharacterTag_All:registEventHandler()
  if nil == Panel_CharacterTag_All then
    return
  end
  self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterTag_All_Close()")
  self._ui_pc.chk_popup:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterTag_All_PopUpUI()")
  self._ui_pc.chk_popup:addInputEvent("Mouse_On", "HandleEventOnOut_CharacterTag_All_PopUpTooltip(true)")
  self._ui_pc.chk_popup:addInputEvent("Mouse_Out", "HandleEventOnOut_CharacterTag_All_PopUpTooltip(false)")
  self._ui.mainImg2.stc_img:addInputEvent("Mouse_RUp", "HandleEventRUp_CharacterTag_All_DeleteTagCharacter()")
  self._ui.chk_tagState:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterTag_All_ClickRequestTag()")
  self._ui.chk_tagState:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterTag_All_ClickRequestTag()")
  self._ui.btn_charTAG:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterTag_All_ClickRequestTag()")
  self._ui.btn_takeEXP:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterTag_All_CharacterTagButton()")
  self._ui.stc_midBg:addInputEvent("Mouse_UpScroll", "HandleEventScroll_CharacterTag_All_ScrollEvent(true)")
  self._ui.stc_midBg:addInputEvent("Mouse_DownScroll", "HandleEventScroll_CharacterTag_All_ScrollEvent(false)")
  registerEvent("FromClient_SuccessRequest", "FromClient_CharacterTag_All_SuccessRequest")
  registerEvent("FromClient_SuccessDelete", "FromClient_CharacterTag_All_SuccessDelete")
  registerEvent("FromClient_NotifyUpdateDuelCharacterExp", "FromClient_CharacterTag_All_NotifyUpdateDuelCharacterExp")
  registerEvent("EventSelfPlayerLevelUp", "FromClient_CharacterTag_All_SelfPlayerLevelUp")
end
function PaGlobal_CharacterTag_All:validate()
  if nil == Panel_CharacterTag_All then
    return
  end
  self._ui.stc_titleBg:isValidate()
  self._ui_pc.chk_popup:isValidate()
  self._ui_pc.btn_close:isValidate()
  self._ui.stc_topBg:isValidate()
  self._ui.topDeco.stc_bg:isValidate()
  self._ui.topDeco.stc_deco:isValidate()
  self._ui.topEXP.stc_bg:isValidate()
  self._ui.topEXP.stc_right:isValidate()
  self._ui.topEXP.stc_left:isValidate()
  self._ui.mainImg1.stc_bg:isValidate()
  self._ui.mainImg1.stc_img:isValidate()
  self._ui.mainImg1.txt_name:isValidate()
  self._ui.mainImg1.txt_lv:isValidate()
  self._ui.mainImg1.stc_state:isValidate()
  self._ui.mainImg1.txt_getExp:isValidate()
  self._ui.mainImg1.txt_getSkillExp:isValidate()
  self._ui.mainImg2.stc_bg:isValidate()
  self._ui.mainImg2.stc_img:isValidate()
  self._ui.mainImg2.txt_name:isValidate()
  self._ui.mainImg2.txt_lv:isValidate()
  self._ui.mainImg2.stc_state:isValidate()
  self._ui.mainImg2.txt_getExp:isValidate()
  self._ui.mainImg2.txt_getSkillExp:isValidate()
  self._ui.mainImg2.stc_addIcon:isValidate()
  self._ui.txt_tagAreaTitle:isValidate()
  self._ui.txt_tagAreaValue:isValidate()
  self._ui.chk_tagState:isValidate()
  self._ui.chk_tagStateExp:isValidate()
  self._ui.btn_takeEXP:isValidate()
  self._ui.btn_charTAG:isValidate()
  self._ui.btn_ItemCopy:isValidate()
  self._ui.stc_eventDescBg:isValidate()
  self._ui.txt_eventDesc:isValidate()
  self._ui.stc_midBg:isValidate()
  self._ui.stc_template:isValidate()
  self._ui.stc_templateBorder:isValidate()
  self._ui.stc_templateImage:isValidate()
  self._ui.stc_templateSelect:isValidate()
  self._ui.txt_templateLevel:isValidate()
  self._ui.txt_templateState:isValidate()
  self._ui.stc_templateOnline:isValidate()
  self._ui.stc_scrollBg:isValidate()
  self._ui.stc_descBg:isValidate()
  self._ui.txt_desc:isValidate()
  self._ui_console.stc_keyGuideBg:isValidate()
  self._ui_console.stc_keyConfirm:isValidate()
  self._ui_console.stc_keyCancle:isValidate()
end
