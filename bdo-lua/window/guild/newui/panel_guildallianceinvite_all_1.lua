function PaGlobal_GuildAllianceInvite_All:initialize()
  if true == PaGlobal_GuildAllianceInvite_All._initialize or nil == Panel_GuildAllianceInvite_All then
    return
  end
  local topArea = UI.getChildControl(Panel_GuildAllianceInvite_All, "Static_TopArea")
  self._ui.txt_miniDesc = UI.getChildControl(topArea, "StaticText_MiniDesc")
  self._ui.edit_searchGuild = UI.getChildControl(topArea, "Edit_Search_Guild")
  self._ui.edit_searchGuild:SetMaxInput(getGameServiceTypeGuildNameLength())
  if false == isGameTypeKorea() then
    local title = UI.getChildControl(topArea, "StaticText_AlianceNameTitle")
    local gap = math.abs(title:GetSizeX() - title:GetTextSizeX())
    self._ui.edit_searchGuild:SetSize(self._ui.edit_searchGuild:GetSizeX() - gap, self._ui.edit_searchGuild:GetSizeY())
    self._ui.edit_searchGuild:ComputePos()
  end
  self._ui.btn_reset = UI.getChildControl(Panel_GuildAllianceInvite_All, "Button_Reset")
  self._ui.btn_createAlliance = UI.getChildControl(Panel_GuildAllianceInvite_All, "Button_CreateAliance")
  self._ui.btn_cancel = UI.getChildControl(Panel_GuildAllianceInvite_All, "Button_CancelInvite")
  self._ui.stc_mainArea = UI.getChildControl(Panel_GuildAllianceInvite_All, "Static_MainArea")
  self._ui.stc_listArea = UI.getChildControl(self._ui.stc_mainArea, "Static_ListArea")
  self._ui.stc_guildTemplate = UI.getChildControl(self._ui.stc_listArea, "Radiobutton_Temp")
  self._ui.stc_guildTemplate:SetShow(false)
  self._ui.stc_descBG = UI.getChildControl(Panel_GuildAllianceInvite_All, "Static_BottomDescArea")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_descBG, "StaticText_Desc")
  self._changePanelSizeY = Panel_GuildMain_All:GetSizeY()
  self._defaultAllianceName = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDALLIANCEINFO_ALLIANCENAMETIP_TEXT")
  self:validate()
  self:registEventHandler()
  for index = 1, self._minMemberCount do
    self:createGuildInfo(index)
  end
  self._initialize = true
end
function PaGlobal_GuildAllianceInvite_All:registEventHandler()
  self._ui.btn_reset:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildAllianceInvite_All_ReSet()")
  self._ui.btn_createAlliance:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildAllianceInvite_All_CreateAlliance()")
  self._ui.btn_cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildAllianceInvite_All_CancelInvite()")
  self._ui.edit_searchGuild:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildAllianceInvite_All_FocusAllianceName()")
  self._ui.edit_searchGuild:RegistReturnKeyEvent("PaGlobalFunc_GuildAllianceInvite_All_RegistAllianceName()")
  self._ui.edit_searchGuild:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_GuildAllianceInvite_All_End_VirtualKey_AllianceName")
  registerEvent("FromClient_CreateGuildAlliance", "FromClient_GuildAllianceInvite_All_DoneAlliance")
end
function PaGlobal_GuildAllianceInvite_All:update()
  self:setNotice()
  self:reSetGuildInfo()
end
function PaGlobal_GuildAllianceInvite_All:reSetGuildInfo()
  if true == self._isInvite then
    return
  end
  TooltipSimple_Hide()
  self._curAddGuildInfo = 1
  self._curMemberCount = 0
  self._curTaxRate = 0
  self._selectedGuildInfoIdx = -1
  self._allianceName = ""
  self._allianceMemberName = {}
  for index = 1, #self._memberCount do
    self._memberCount[index] = 0
    self._taxRate[index] = 0
  end
  self._ui.edit_searchGuild:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDALLIANCEINFO_ALLIANCENAMETIP_TEXT"))
  for index = self._minGuildInfoCnt + 1, #self._ui.guildInfo do
    if nil ~= self._ui.guildInfo[index] then
      self._ui.guildInfo[index].stc_guildInfoBg:SetShow(false)
    end
  end
  self:setMyGuildInfo()
  self:setGuildInfo(true, self._minGuildInfoCnt)
  self:changeMiniDesc()
end
function PaGlobal_GuildAllianceInvite_All:createGuildInfo(index)
  if nil ~= self._ui.guildInfo[index] then
    return
  end
  local guildInfo = {
    stc_guildInfoBg = nil,
    txt_guildName = nil,
    edit_guildName = nil,
    stc_memberCount = nil,
    stc_rate = nil,
    stc_addIcon = nil,
    btn_close = nil
  }
  guildInfo.stc_guildInfoBg = UI.cloneControl(self._ui.stc_guildTemplate, self._ui.stc_listArea, "Radiobutton_AllyInvite_" .. index)
  guildInfo.txt_guildName = UI.getChildControl(guildInfo.stc_guildInfoBg, "StaticText_GuildName")
  guildInfo.edit_guildName = UI.getChildControl(guildInfo.stc_guildInfoBg, "Edit_GuildName")
  guildInfo.stc_memberCount = UI.getChildControl(guildInfo.stc_guildInfoBg, "Static_Member")
  guildInfo.stc_rate = UI.getChildControl(guildInfo.stc_guildInfoBg, "Static_Rate")
  guildInfo.stc_addIcon = UI.getChildControl(guildInfo.stc_guildInfoBg, "Static_Add")
  guildInfo.btn_close = UI.getChildControl(guildInfo.stc_guildInfoBg, "Button_Close")
  guildInfo.edit_guildName:SetMaxInput(getGameServiceTypeGuildNameLength())
  guildInfo.edit_guildName:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildAllianceInvite_All_FocusGuildName(" .. index .. ")")
  guildInfo.edit_guildName:RegistReturnKeyEvent("PaGlobalFunc_GuildAllianceInvite_All_RegistGuildName(" .. index .. ")")
  guildInfo.stc_rate:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildAllianceInvite_All_TaxRateClick(" .. index .. ")")
  guildInfo.stc_memberCount:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildAllianceInvite_All_MemberCountClick(" .. index .. ")")
  guildInfo.btn_close:SetShow(not _ContentsGroup_UsePadSnapping)
  if false == _ContentsGroup_UsePadSnapping then
    guildInfo.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildAllianceInvite_All_ClearGuildInfo(" .. index .. ")")
  elseif 1 ~= index then
    guildInfo.edit_guildName:registerPadEvent(__eConsoleUIPadEvent_RSClick, "HandleEventLUp_GuildAllianceInvite_All_ClearGuildInfo(" .. index .. ")")
    guildInfo.edit_guildName:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_GuildAllianceInvite_All_End_VirtualKey_MemberName")
    guildInfo.stc_memberCount:registerPadEvent(__eConsoleUIPadEvent_RSClick, "HandleEventLUp_GuildAllianceInvite_All_ClearGuildInfo(" .. index .. ")")
    guildInfo.stc_rate:registerPadEvent(__eConsoleUIPadEvent_RSClick, "HandleEventLUp_GuildAllianceInvite_All_ClearGuildInfo(" .. index .. ")")
  end
  self._ui.guildInfo[index] = guildInfo
  self:setPositionGuildInfo(index)
end
function PaGlobal_GuildAllianceInvite_All:setPositionGuildInfo(index)
  if 0 == index % 2 then
    self._ui.guildInfo[index].stc_guildInfoBg:SetHorizonRight()
  else
    self._ui.guildInfo[index].stc_guildInfoBg:SetHorizonLeft()
  end
  local padding = 5
  local spanSizeY = math.floor((index - 1) / 2) * (self._ui.guildInfo[index].stc_guildInfoBg:GetSizeY() + padding) + 10
  self._ui.guildInfo[index].stc_guildInfoBg:SetSpanSize(10, spanSizeY)
end
function PaGlobal_GuildAllianceInvite_All:setMyGuildInfo()
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == guildWrapper then
    UI.ASSERT_NAME(nil ~= index, "PaGlobal_GuildAllianceInvite_All:setMyGuildInfo guildWrapper is nil ", "\234\185\128\236\156\164\236\167\128")
    return
  end
  if nil == self._ui.guildInfo[1] then
    self:createGuildInfo(1)
  end
  self._ui.guildInfo[1].stc_guildInfoBg:SetShow(true)
  self._ui.guildInfo[1].stc_guildInfoBg:SetIgnore(true)
  self._ui.guildInfo[1].txt_guildName:SetShow(true)
  self._ui.guildInfo[1].txt_guildName:SetFontColor(4294294074)
  self._ui.guildInfo[1].txt_guildName:SetText(guildWrapper:getName())
  self:setMemberCount(1, 10)
  self:setRate(1, 100)
  self._ui.guildInfo[1].edit_guildName:SetShow(false)
  self._ui.guildInfo[1].btn_close:SetShow(false)
  self._ui.guildInfo[1].stc_addIcon:SetShow(false)
end
function PaGlobal_GuildAllianceInvite_All:setMemberCount(index, count)
  if nil == self._ui.guildInfo[index] then
    return
  end
  self._curMemberCount = self._curMemberCount + count
  self._memberCount[index] = count
  self._ui.guildInfo[index].stc_memberCount:SetShow(true)
  self._ui.guildInfo[index].stc_memberCount:SetText(count .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCEINFO_INFO_MEMBERCOUNT_TEXT"))
  self._ui.guildInfo[index].stc_guildInfoBg:SetCheck(false)
end
function PaGlobal_GuildAllianceInvite_All:setRate(index, count)
  if nil == self._ui.guildInfo[index] then
    return
  end
  self._curTaxRate = self._curTaxRate + count
  self._taxRate[index] = count
  self._ui.guildInfo[index].stc_rate:SetShow(true)
  self._ui.guildInfo[index].stc_rate:SetText(count .. "%")
  self._ui.guildInfo[index].stc_guildInfoBg:SetCheck(false)
end
function PaGlobal_GuildAllianceInvite_All:changeTaxConstRate()
  if self._maxTaxRate < self._curTaxRate + self._taxRate_Default[self._curAddGuildInfo] then
    self._curTaxRate = 0
    for ii = 1, self._curAddGuildInfo do
      self:setRate(ii, self._taxRate_Default[self._curAddGuildInfo])
    end
  else
    self:setRate(self._curAddGuildInfo, self._taxRate_Default[self._curAddGuildInfo])
  end
end
function PaGlobal_GuildAllianceInvite_All:setGuildInfo(isAddType, index)
  if nil == self._ui.guildInfo[index] then
    self:createGuildInfo(index)
  end
  TooltipSimple_Hide()
  self._ui.guildInfo[index].stc_guildInfoBg:SetShow(true)
  self._ui.guildInfo[index].txt_guildName:SetShow(not isAddType)
  self._ui.guildInfo[index].edit_guildName:SetShow(not isAddType)
  self._ui.guildInfo[index].stc_memberCount:SetShow(not isAddType)
  self._ui.guildInfo[index].stc_rate:SetShow(not isAddType)
  self._ui.guildInfo[index].btn_close:SetShow(not isAddType and not _ContentsGroup_UsePadSnapping)
  self._ui.guildInfo[index].stc_addIcon:SetShow(isAddType)
  if true == isAddType then
    if false == _ContentsGroup_UsePadSnapping then
      self._ui.guildInfo[index].stc_guildInfoBg:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildAllianceInvite_All_AddGuildInfo(" .. index .. ")")
      self._ui.guildInfo[index].stc_guildInfoBg:addInputEvent("Mouse_On", "HandleEventOnOut_GuildAllianceInvite_All_ShowToolTip(true," .. index .. ")")
      self._ui.guildInfo[index].stc_guildInfoBg:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildAllianceInvite_All_ShowToolTip(false)")
      self._ui.guildInfo[index].stc_guildInfoBg:SetIgnore(false)
    else
      PaGlobal_GuildMain_All._ui.stc_AllianceInvite_Bg:registerPadEvent(__eConsoleUIPadEvent_LSClick, "HandleEventLUp_GuildAllianceInvite_All_AddGuildInfo(" .. index .. ")")
    end
  else
    if 1 ~= index then
      self._ui.guildInfo[index].txt_guildName:SetShow(false)
      self._ui.guildInfo[index].edit_guildName:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCEINFO_INPUTMEMBERNAME_TEXT"))
      if false == _ContentsGroup_UsePadSnapping then
        self._ui.guildInfo[index].btn_close:addInputEvent("Mouse_On", "HandleEventOnOut_GuildAllianceInvite_All_ShowToolTip(true," .. index .. ")")
        self._ui.guildInfo[index].btn_close:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildAllianceInvite_All_ShowToolTip(false)")
        self._ui.guildInfo[index].stc_guildInfoBg:SetIgnore(true)
      end
    end
    self:setMemberCount(index, 10)
    self._ui.guildInfo[index].stc_guildInfoBg:removeInputEvent("Mouse_LUp")
    self._ui.guildInfo[index].stc_guildInfoBg:removeInputEvent("Mouse_On")
    self._ui.guildInfo[index].stc_guildInfoBg:removeInputEvent("Mouse_Out")
  end
end
function PaGlobal_GuildAllianceInvite_All:computeMemberCount()
  self._curMemberCount = 0
  for index = 1, #self._memberCount do
    self._curMemberCount = self._curMemberCount + self._memberCount[index]
  end
end
function PaGlobal_GuildAllianceInvite_All:computTaxRate()
  self._curTaxRate = 0
  for index = 1, #self._memberCount do
    self._curTaxRate = self._curTaxRate + self._taxRate[index]
  end
end
function PaGlobal_GuildAllianceInvite_All:changeGuildInfoIndex(clearIdx)
  for index = clearIdx, self._curAddGuildInfo - 1 do
    self._ui.guildInfo[index].edit_guildName:SetEditText(self._ui.guildInfo[index + 1].edit_guildName:GetEditText())
    self:setMemberCount(index, self._memberCount[index + 1])
    self:setRate(index, self._taxRate[index + 1])
  end
end
function PaGlobal_GuildAllianceInvite_All:changeMiniDesc()
  local maxMember = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDALLIANCEINFO_GUILD_LIMIT_MEMBER_COUNT_TITLE_TEXT") .. " (" .. self._curMemberCount .. "/" .. self._maxMemberCount .. ")  "
  local maxTax = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDALLIANCEINFO_GUILD_TAX_CONST_TITLE_TEXT") .. " (" .. self._curTaxRate .. "/" .. self._maxTaxRate .. ")  "
  self._ui.txt_miniDesc:SetText(maxMember .. maxTax)
  PaGlobalFunc_GuildMain_All_KeyGuideResize()
end
function PaGlobal_GuildAllianceInvite_All:notInputMessage(index)
  local _info = ""
  if 0 == index then
    _info = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCEINFO_WARNING_NONE_ALLIANCENAME")
  elseif 1 == index then
    _info = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCEINFO_WARNING_NONE_GUILDNAME")
  elseif 2 == index then
    _info = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCEINFO_WARNING_NONE_TAX_CONST")
  end
  local messageBoxData = {
    title = "",
    content = _info,
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_1m
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_GuildAllianceInvite_All:createAlliance()
  ToClient_RequestClearAllianceJoinQueue()
  for ii = 1, self._curAddGuildInfo do
    ToClient_RequestAddAllianceJoinQueue(self._allianceMemberName[ii], self._taxRate[ii], self._memberCount[ii])
  end
  ToClient_CreateGuildAlliance(self._allianceName, 0)
end
function PaGlobal_GuildAllianceInvite_All:setNotice()
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDALLIANCEINFO_GUILDALLIANCE_RULES_TEXT"))
  if self._ui.txt_desc:GetTextSizeY() > self._ui.txt_desc:GetSizeY() then
    self._changePanelSizeY = Panel_GuildMain_All:GetSizeYOrigin() + (self._ui.txt_desc:GetTextSizeY() - self._ui.txt_desc:GetSizeY())
    local padding = 20
    self._ui.stc_descBG:SetSize(self._ui.stc_descBG:GetSizeX(), self._ui.txt_desc:GetTextSizeY() + padding)
    self._ui.txt_desc:SetSize(self._ui.txt_desc:GetSizeX(), self._ui.txt_desc:GetTextSizeY())
  end
  PaGlobal_GuildMain_All_ChangePanelSize(self._changePanelSizeY)
  self._ui.stc_mainArea:SetSize(self._ui.stc_mainArea:GetSizeX(), self._changePanelSizeY)
end
function PaGlobal_GuildAllianceInvite_All:validate()
  self._ui.txt_miniDesc:isValidate()
  self._ui.edit_searchGuild:isValidate()
  self._ui.btn_reset:isValidate()
  self._ui.btn_createAlliance:isValidate()
  self._ui.btn_cancel:isValidate()
  self._ui.stc_listArea:isValidate()
  self._ui.stc_guildTemplate:isValidate()
  self._ui.stc_descBG:isValidate()
  self._ui.txt_desc:isValidate()
end
