function PaGlobal_GuildIncentiveOption_All:initialize()
  if true == PaGlobal_GuildIncentiveOption_All._initialize then
    return
  end
  PaGlobal_GuildIncentiveOption_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_GuildIncentiveOption_All:ControlAll_Init()
  PaGlobal_GuildIncentiveOption_All:ControlPc_Init()
  PaGlobal_GuildIncentiveOption_All:ControlConsole_Init()
  PaGlobal_GuildIncentiveOption_All:ControlSetShow()
  PaGlobal_GuildIncentiveOption_All:CreateControl()
  PaGlobal_GuildIncentiveOption_All:FrameUpdate()
  PaGlobal_GuildIncentiveOption_All:registEventHandler()
  PaGlobal_GuildIncentiveOption_All:validate()
  PaGlobal_GuildIncentiveOption_All._initialize = true
end
function PaGlobal_GuildIncentiveOption_All:ControlAll_Init()
  if nil == Panel_GuildIncentiveOption_All then
    return
  end
  self._ui.stc_titleBg = UI.getChildControl(Panel_GuildIncentiveOption_All, "Static_TitleArea")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_titleBg, "StaticText_Title")
  self._ui.stc_backBg = UI.getChildControl(Panel_GuildIncentiveOption_All, "Static_BackBG")
  self._ui.stc_listTitleBg = UI.getChildControl(Panel_GuildIncentiveOption_All, "Static_ListTitle")
  self._ui._title.txt_grade = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_Grade")
  self._ui._title.txt_name = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_CharName")
  self._ui._title.txt_activity = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_Activity")
  self._ui._title.txt_incentive = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_IncentiveValue")
  self._ui._title.txt_rade = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_Rate")
  self._ui.stc_listBg = UI.getChildControl(Panel_GuildIncentiveOption_All, "Static_ListArea")
  self._ui.frame_list = UI.getChildControl(self._ui.stc_listBg, "Frame_List")
  self._ui.frame_content = UI.getChildControl(self._ui.frame_list, "Frame_1_Content")
  self._ui.frame_vScroll = UI.getChildControl(self._ui.frame_list, "Frame_1_VerticalScroll")
  self._ui.frame_vScrollCtrl = UI.getChildControl(self._ui.frame_vScroll, "Frame_1_VerticalScroll_CtrlButton")
  self._ui.stc_listTemp = UI.getChildControl(self._ui.frame_content, "Static_List_Temp")
  self._ui.stc_bottomBg = UI.getChildControl(Panel_GuildIncentiveOption_All, "Static_BottomArea")
  self._ui.stc_guildFundBg = UI.getChildControl(self._ui.stc_bottomBg, "Static_BG")
  self._ui.txt_guildFund = UI.getChildControl(self._ui.stc_guildFundBg, "StaticText_GuildFunds")
  self._ui.txt_fundDesc = UI.getChildControl(self._ui.stc_bottomBg, "StaticText_Desc")
  self._ui.txt_fundDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_fundDesc:SetText(self._ui.txt_fundDesc:GetText())
end
function PaGlobal_GuildIncentiveOption_All:ControlPc_Init()
  if nil == Panel_GuildIncentiveOption_All then
    return
  end
  self._ui_pc.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Close")
  self._ui_pc.btn_getFunds = UI.getChildControl(self._ui.stc_bottomBg, "Button_GetFunds")
end
function PaGlobal_GuildIncentiveOption_All:ControlConsole_Init()
  if nil == Panel_GuildIncentiveOption_All then
    return
  end
  self._ui_console.stc_keyGuideBg = UI.getChildControl(Panel_GuildIncentiveOption_All, "Static_KeyGuide_ConsoleUI")
  self._ui_console.stc_keyGuideY = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Y_ConsoleUI")
  self._ui_console.stc_keyGuideA = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_A_ConsoleUI")
  self._ui_console.stc_keyGuideX = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_X_ConsoleUI")
  self._ui_console.stc_keyGuideB = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_B_ConsoleUI")
end
function PaGlobal_GuildIncentiveOption_All:ControlSetShow()
  if nil == Panel_GuildIncentiveOption_All then
    return
  end
  if true == self._isConsole then
    self._ui.stc_listTemp:SetIgnore(false)
    self._ui_pc.btn_close:SetShow(false)
    self._ui_pc.btn_getFunds:SetShow(false)
    self._ui_console.stc_keyGuideBg:SetShow(true)
  else
    self._ui.stc_listTemp:SetIgnore(true)
    self._ui.stc_listTemp:ChangeTextureInfoName("")
    self._ui_pc.btn_close:SetShow(true)
    self._ui_pc.btn_getFunds:SetShow(true)
    self._ui_console.stc_keyGuideBg:SetShow(false)
  end
  self._configSize.panelY = Panel_GuildIncentiveOption_All:GetSizeY()
  self._configSize.bottomY = self._ui.stc_bottomBg:GetSizeY()
  self._configSize.descY = self._ui.txt_fundDesc:GetSizeY()
end
function PaGlobal_GuildIncentiveOption_All:CreateControl()
  if nil == Panel_GuildIncentiveOption_All then
    return
  end
  local gapY = 5
  local listStartY = self._ui.frame_content:GetPosY()
  local function createListInfo(pIndex)
    local tempMember = {}
    tempMember._memberBg = UI.createAndCopyBasePropertyControl(self._ui.frame_content, "Static_List_Temp", self._ui.frame_content, "incentiveMemeberlist_MemberBg_" .. pIndex)
    tempMember._grade = UI.createAndCopyBasePropertyControl(self._ui.stc_listTemp, "StaticText_C_Grade", tempMember._memberBg, "incentiveMemeberlist_Grade_" .. pIndex)
    tempMember._charName = UI.createAndCopyBasePropertyControl(self._ui.stc_listTemp, "StaticText_C_CharName", tempMember._memberBg, "incentiveMemeberlist_CharName_" .. pIndex)
    tempMember._activity = UI.createAndCopyBasePropertyControl(self._ui.stc_listTemp, "StaticText_C_Activity", tempMember._memberBg, "incentiveMemeberlist_Activity_" .. pIndex)
    tempMember._incentiveValue = UI.createAndCopyBasePropertyControl(self._ui.stc_listTemp, "StaticText_C_IncentiveValue", tempMember._memberBg, "incentiveMemeberlist_Value_")
    tempMember._radio_All = UI.createAndCopyBasePropertyControl(self._ui.stc_listTemp, "RadioButton_All", tempMember._memberBg, "incentiveMemeberlist_RadioAll_" .. pIndex)
    tempMember._radio_Personal = UI.createAndCopyBasePropertyControl(self._ui.stc_listTemp, "RadioButton_Personal", tempMember._memberBg, "incentiveMemeberlist_RadioPersonal_" .. pIndex)
    tempMember._btn_IncentiveLevel = UI.createAndCopyBasePropertyControl(self._ui.stc_listTemp, "StaticText_Grade", tempMember._memberBg, "incentiveMemeberlist_IncentiveLevel_" .. pIndex)
    for _, var in pairs(tempMember) do
      var:ComputePos()
      var:SetIgnore(false and false == self._isConsole)
      var:addInputEvent("Mouse_UpScroll", "HandleEventScroll_GuildIncentiveOption_All_Scroll(true)")
      var:addInputEvent("Mouse_DownScroll", "HandleEventScroll_GuildIncentiveOption_All_Scroll(false)")
    end
    tempMember._radio_All:SetCheck(true)
    tempMember._radio_Personal:SetCheck(false)
    tempMember._radio_All:SetEnableArea(0, 0, tempMember._radio_All:GetSizeX() + tempMember._radio_All:GetTextSizeX() + 5, tempMember._radio_All:GetSizeY())
    tempMember._radio_Personal:SetEnableArea(0, 0, tempMember._radio_Personal:GetSizeX() + tempMember._radio_Personal:GetTextSizeX() + 5, tempMember._radio_Personal:GetSizeY())
    tempMember._radio_Personal:SetPosX(tempMember._radio_All:GetPosX() + tempMember._radio_All:GetSizeX() + tempMember._radio_All:GetTextSizeX() + 10)
    if true == self._isConsole then
      tempMember._radio_All:SetIgnore(true)
      tempMember._radio_Personal:SetIgnore(true)
      tempMember._btn_IncentiveLevel:SetIgnore(true)
      tempMember._btn_IncentiveLevel:ChangeTextureInfoName("")
    else
      tempMember._memberBg:ChangeTextureInfoName("")
    end
    tempMember._memberBg:SetShow(false)
    tempMember._memberBg:SetPosY(listStartY + (tempMember._memberBg:GetSizeY() + gapY) * pIndex)
    return tempMember
  end
  for index = 0, self._listMaxCount do
    self._ui._memberlist[index] = createListInfo(index)
  end
end
function PaGlobal_GuildIncentiveOption_All:FrameUpdate()
  self._ui.frame_list:UpdateContentScroll()
  self._ui.frame_list:UpdateContentPos()
  self._ui.frame_vScroll:SetInterval(self._ui.frame_content:GetSizeY() / 100 * 1.1)
end
function PaGlobal_GuildIncentiveOption_All:prepareOpen(editMoney)
  if nil == Panel_GuildIncentiveOption_All then
    return
  end
  self._moneyValue = editMoney
  self._ui.frame_vScroll:SetControlTop()
  PaGlobalFunc_GuildIncentiveOption_All_TitleLineReset()
  PaGlobal_GuildIncentiveOption_All:update()
  PaGlobal_GuildIncentiveOption_All:open()
  PaGlobal_GuildIncentiveOption_All:resize()
end
function PaGlobal_GuildIncentiveOption_All:open()
  if nil == Panel_GuildIncentiveOption_All then
    return
  end
  Panel_GuildIncentiveOption_All:SetShow(true)
end
function PaGlobal_GuildIncentiveOption_All:prepareClose()
  if nil == Panel_GuildIncentiveOption_All then
    return
  end
  PaGlobal_GuildIncentiveOption_All:close()
end
function PaGlobal_GuildIncentiveOption_All:close()
  if nil == Panel_GuildIncentiveOption_All then
    return
  end
  Panel_GuildIncentiveOption_All:SetShow(false)
end
function PaGlobal_GuildIncentiveOption_All:update()
  if nil == Panel_GuildIncentiveOption_All then
    return
  end
  self:setGuildMemberData()
  self:updateBottomInfo()
  self:updateSort()
  self:updateListInfo()
  self:FrameUpdate()
end
function PaGlobal_GuildIncentiveOption_All:registEventHandler()
  if nil == Panel_GuildIncentiveOption_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_GuildIncentiveOption_All_Resize")
  for index = 0, self._listMaxCount do
    self._ui._memberlist[index]._btn_IncentiveLevel:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildIncentiveOption_All_Grade(" .. index .. ")")
  end
  if true == self._isConsole then
    Panel_GuildIncentiveOption_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_GuildIncentiveOption_All_GiveIncentive()")
  else
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildIncentiveOption_All_Close()")
    self._ui_pc.btn_getFunds:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildIncentiveOption_All_GiveIncentive()")
    self._ui._title.txt_name:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildIncentiveOption_All_ListSort(0)")
    self._ui._title.txt_activity:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildIncentiveOption_All_ListSort(1)")
  end
end
function PaGlobal_GuildIncentiveOption_All:validate()
  if nil == Panel_GuildIncentiveOption_All then
    return
  end
end
function PaGlobal_GuildIncentiveOption_All:resize()
  if nil == Panel_GuildIncentiveOption_All then
    return
  end
  if self._configSize.descY < self._ui.txt_fundDesc:GetTextSizeY() then
    local addSizeY = self._ui.txt_fundDesc:GetTextSizeY() - self._configSize.descY
    self._ui.txt_fundDesc:SetSize(self._ui.txt_fundDesc:GetSizeX(), self._configSize.descY + addSizeY)
    self._ui.stc_bottomBg:SetSize(self._ui.stc_bottomBg:GetSizeX(), self._configSize.bottomY + addSizeY)
    Panel_GuildIncentiveOption_All:SetSize(Panel_GuildIncentiveOption_All:GetSizeX(), self._configSize.panelY + addSizeY)
    self._ui.txt_fundDesc:ComputePos()
    self._ui.stc_bottomBg:ComputePos()
    self._ui.stc_guildFundBg:ComputePos()
    self._ui_pc.btn_getFunds:ComputePos()
  end
  Panel_GuildIncentiveOption_All:ComputePos()
  if true == self._isConsole then
    local keyGuides = {
      self._ui_console.stc_keyGuideY,
      self._ui_console.stc_keyGuideA,
      self._ui_console.stc_keyGuideX,
      self._ui_console.stc_keyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_GuildIncentiveOption_All:setGuildMemberData()
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  self._memberlistData = {}
  local memberCount = ToClient_getGuildIncentiveListCount()
  for index = 1, memberCount do
    local tempGuildIncentive = {}
    local myGuildMemberInfo = ToClient_getMemberGuildIncentiveListByIndex(index - 1)
    tempGuildIncentive = {
      idx = index - 1,
      online = myGuildMemberInfo:isOnline(),
      grade = myGuildMemberInfo:getGrade(),
      level = myGuildMemberInfo:getLevel(),
      class = myGuildMemberInfo:getClassType(),
      name = myGuildMemberInfo:getName(),
      ap = Int64toInt32(myGuildMemberInfo:getTotalActivity()),
      expiration = myGuildMemberInfo:getContractedExpirationUtc(),
      wp = myGuildMemberInfo:getMaxWp(),
      kp = myGuildMemberInfo:getExplorationPoint(),
      userNo = myGuildMemberInfo:getUserNo(),
      isAll = true
    }
    local userNoStr = tostring(tempGuildIncentive.userNo)
    if nil == self._isAllButton[userNoStr] then
      self._isAllButton[userNoStr] = true
      tempGuildIncentive.isAll = true
    else
      tempGuildIncentive.isAll = self._isAllButton[userNoStr]
    end
    self._memberlistData[index] = tempGuildIncentive
  end
end
function PaGlobal_GuildIncentiveOption_All:updateBottomInfo()
  if nil == Panel_GuildIncentiveOption_All then
    return
  end
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local businessFunds = myGuildListInfo:getGuildBusinessFunds_s64()
  local totalMoney64 = ToClient_getGuildTotalIncentiveMoney_s64()
  local guildFund = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_INCENTIVE_FOUNDATIONVALUE", "businessFunds", makeDotMoney(businessFunds), "totalMoney64", makeDotMoney(totalMoney64))
  self._ui.txt_guildFund:SetText(guildFund)
  self._ui.stc_guildFundBg:SetSize(self._ui.txt_guildFund:GetTextSizeX() + 20, self._ui.stc_guildFundBg:GetSizeY())
end
function PaGlobal_GuildIncentiveOption_All:updateSort()
  if 0 == self._selectSortType then
    table.sort(self._memberlistData, guildIncentiveCompareName)
  elseif 1 == self._selectSortType then
    table.sort(self._memberlistData, guildIncentiveCompareAp)
  end
end
function PaGlobal_GuildIncentiveOption_All:updateListInfo()
  if nil == Panel_GuildIncentiveOption_All then
    return
  end
  for index = 0, self._listMaxCount do
    self._ui._memberlist[index]._memberBg:SetShow(false)
  end
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local memberCount = ToClient_getGuildIncentiveListCount()
  for i = 1, memberCount do
    local index = i - 1
    local dataIdx = self._memberlistData[i].idx
    self._ui._memberlist[index]._memberBg:SetShow(true)
    local guildMemberInfo = ToClient_getMemberGuildIncentiveListByIndex(dataIdx)
    local gradeType = guildMemberInfo:getGrade()
    self._ui._memberlist[index]._grade:ChangeTextureInfoName("Renewal/PcRemaster/Remaster_ETC_Guild.dds")
    if __eGuildMemberGradeMaster == gradeType then
      local x1, y1, x2, y2 = setTextureUV_Func(self._ui._memberlist[index]._grade, 224, 227, 267, 253)
      self._ui._memberlist[index]._grade:getBaseTexture():setUV(x1, y1, x2, y2)
    elseif __eGuildMemberGradeSubMaster == gradeType then
      local x1, y1, x2, y2 = setTextureUV_Func(self._ui._memberlist[index]._grade, 224, 200, 267, 226)
      self._ui._memberlist[index]._grade:getBaseTexture():setUV(x1, y1, x2, y2)
    elseif __eGuildMemberGradeNormal == gradeType then
      local x1, y1, x2, y2 = setTextureUV_Func(self._ui._memberlist[index]._grade, 224, 146, 267, 172)
      self._ui._memberlist[index]._grade:getBaseTexture():setUV(x1, y1, x2, y2)
    elseif __eGuildMemberGradeSupplyOfficer == gradeType then
      local x1, y1, x2, y2 = setTextureUV_Func(self._ui._memberlist[index]._grade, 224, 173, 267, 199)
      self._ui._memberlist[index]._grade:getBaseTexture():setUV(x1, y1, x2, y2)
    elseif __eGuildMemberGradeJunior == gradeType then
      self._ui._memberlist[index]._grade:ChangeTextureInfoName("Renewal/PcRemaster/Remaster_ETC_Guild01.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(self._ui._memberlist[index]._grade, 1, 1, 44, 27)
      self._ui._memberlist[index]._grade:getBaseTexture():setUV(x1, y1, x2, y2)
      self._ui._memberlist[index]._grade:SetSpanSize(self._ui._memberlist[index]._grade:GetSpanSize().x - 1, 0)
    end
    self._ui._memberlist[index]._grade:setRenderTexture(self._ui._memberlist[index]._grade:getBaseTexture())
    if true == guildMemberInfo:isOnline() then
      self._ui._memberlist[index]._charName:SetText(guildMemberInfo:getName() .. " (" .. guildMemberInfo:getCharacterName() .. ")")
      local usableActivity = guildMemberInfo:getUsableActivity()
      if 10000 < usableActivity then
        usableActivity = 10000
      end
      local tempActivityText = tostring(guildMemberInfo:getTotalActivity()) .. "(<PAColor0xfface400>+" .. tostring(usableActivity) .. "<PAOldColor>)"
      self._ui._memberlist[index]._activity:SetText(tempActivityText)
    else
      self._ui._memberlist[index]._charName:SetText(guildMemberInfo:getName() .. " ( - )")
      local tempActivityText = tostring(guildMemberInfo:getTotalActivity()) .. "(+" .. tostring(guildMemberInfo:getUsableActivity()) .. ")"
      self._ui._memberlist[index]._activity:SetText(tempActivityText)
    end
    local grade = ToClient_getGuildMemberIncentiveGrade(dataIdx)
    self._ui._memberlist[index]._btn_IncentiveLevel:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_INCENTIVE_GRADE_FOR_WHAT", "grade", tostring(grade)))
    local incentive = ToClient_getGuildMemberIncentiveMoney_s64(dataIdx)
    local incentiveAfterTax = ToClient_getGuildMemberIncentiveMoneyAfterTax_s64(dataIdx)
    local rate = ToClient_GetCalculateRate(incentiveAfterTax, incentive)
    rate = 1 - rate
    rate = rate * 100
    rate = math.ceil(rate)
    if 1.0E-5 < rate then
      self._ui._memberlist[index]._incentiveValue:SetText(makeDotMoney(incentive) .. "(<PAColor0xFFD20000>-" .. tostring(rate) .. "%<PAOldColor>)")
      self._ui._memberlist[index]._incentiveValue:SetIgnore(false)
      self._ui._memberlist[index]._incentiveValue:addInputEvent("Mouse_On", "HandleEventOnOut_GuildIncentiveOption_All_TaxSimpleTooltip(true ," .. tostring(index) .. ")")
      self._ui._memberlist[index]._incentiveValue:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildIncentiveOption_All_TaxSimpleTooltip(false ," .. tostring(index) .. ")")
    else
      self._ui._memberlist[index]._incentiveValue:SetText(makeDotMoney(incentive))
      self._ui._memberlist[index]._incentiveValue:SetIgnore(true)
    end
    local isAll = self._memberlistData[i].isAll
    if true == isAll then
      self._ui._memberlist[index]._radio_All:SetCheck(true)
      self._ui._memberlist[index]._radio_Personal:SetCheck(false)
    else
      self._ui._memberlist[index]._radio_All:SetCheck(false)
      self._ui._memberlist[index]._radio_Personal:SetCheck(true)
    end
    if true == self._isConsole then
      local toggle = not isAll
      self._ui._memberlist[index]._memberBg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_GuildIncentiveOption_All_UpdateIncentiveRadio(" .. tostring(index) .. "," .. tostring(toggle) .. ")")
      self._ui._memberlist[index]._memberBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_GuildIncentiveOption_All_Grade(" .. index .. ")")
    else
      self._ui._memberlist[index]._radio_All:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildIncentiveOption_All_UpdateIncentiveRadio(" .. tostring(index) .. ",true)")
      self._ui._memberlist[index]._radio_Personal:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildIncentiveOption_All_UpdateIncentiveRadio(" .. tostring(index) .. ",false)")
    end
  end
end
