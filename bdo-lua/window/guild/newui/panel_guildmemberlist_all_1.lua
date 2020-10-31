function PaGlobal_GuildMemberList_All:initialize()
  if true == PaGlobal_GuildMemberList_All._initialize then
    return
  end
  PaGlobal_GuildMemberList_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_GuildMemberList_All:ControlAll_Init()
  PaGlobal_GuildMemberList_All:ControlPc_Init()
  PaGlobal_GuildMemberList_All:ControlConsole_Init()
  PaGlobal_GuildMemberList_All:ControlSetShow()
  PaGlobal_GuildMemberList_All:CreateControl()
  PaGlobal_GuildMemberList_All:FrameUpdate()
  PaGlobal_GuildMemberList_All:registEventHandler()
  PaGlobal_GuildMemberList_All:validate()
  PaGlobal_GuildMemberList_All._initialize = true
end
function PaGlobal_GuildMemberList_All:ControlAll_Init()
  if nil == Panel_GuildMemeberList_All then
    return
  end
  self._ui.stc_listTitleBg = UI.getChildControl(Panel_GuildMemeberList_All, "Static_ListTitle")
  self._ui._title.txt_grade = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_Grade")
  self._ui._title.txt_level = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_Level")
  self._ui._title.txt_class = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_Class")
  self._ui._title.txt_name = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_CharName")
  self._ui._title.txt_activity = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_Activity")
  self._ui._title.txt_contribute = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_ContributedTendency")
  self._ui._title.txt_voice = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_Voice")
  self._ui._title.txt_warGrade = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_WarGrade")
  self._ui._title.txt_contract = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_Contract")
  self._ui.stc_listAreaBg = UI.getChildControl(Panel_GuildMemeberList_All, "Static_ListArea")
  self._ui.frame_list = UI.getChildControl(self._ui.stc_listAreaBg, "Frame_List")
  self._ui.frame_content = UI.getChildControl(self._ui.frame_list, "Frame_1_Content")
  self._ui.stc_listMember = UI.getChildControl(self._ui.frame_content, "Static_List_Temp")
  self._ui.scroll_vs = UI.getChildControl(self._ui.frame_list, "Frame_1_VerticalScroll")
  self._ui.scroll_vsCtrl = UI.getChildControl(self._ui.scroll_vs, "Frame_1_VerticalScroll_CtrlButton")
  self._ui.stc_bottomAreaBg = UI.getChildControl(Panel_GuildMemeberList_All, "Static_BottomArea")
  self._ui.stc_guildFundBg = UI.getChildControl(self._ui.stc_bottomAreaBg, "Static_BG")
  self._ui.txt_guildFund = UI.getChildControl(self._ui.stc_guildFundBg, "StaticText_GuildFunds")
  self._ui.btn_getFund = UI.getChildControl(self._ui.stc_bottomAreaBg, "Button_GetFunds")
  self._ui.btn_deposit = UI.getChildControl(self._ui.stc_bottomAreaBg, "Button_Deposit")
  self._ui.btn_warReward = UI.getChildControl(self._ui.stc_bottomAreaBg, "Button_WarReward")
  self._ui.btn_guildFundManage = UI.getChildControl(self._ui.stc_bottomAreaBg, "Button_GuildFundsManage")
  self._ui.btn_guildLifeFund = UI.getChildControl(self._ui.stc_bottomAreaBg, "Button_GuildLifeFunds")
  self._ui._titlelist[0] = self._ui._title.txt_grade
  self._ui._titlelist[1] = self._ui._title.txt_level
  self._ui._titlelist[2] = self._ui._title.txt_class
  self._ui._titlelist[3] = self._ui._title.txt_name
  self._ui._titlelist[4] = self._ui._title.txt_activity
  self._ui._titlelist[5] = self._ui._title.txt_contract
  self._ui._titlelist[6] = self._ui._title.txt_contribute
  self._ui._titlelist[7] = self._ui._title.txt_warGrade
  self._ui._titlelist[8] = self._ui._title.txt_voice
  if true == self._contentOpen.voice then
    self._ui._title.txt_voice:SetShow(true)
  else
    self._ui._title.txt_voice:SetShow(false)
  end
  if true == self._contentOpen.warGrade then
    self._ui._title.txt_warGrade:SetShow(true)
    if true == self._contentOpen.newSiegeRule then
      self._ui._title.txt_warGrade:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDLIST_WARPARTICIPANT_TITLE"))
    else
      self._ui._title.txt_warGrade:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDLIST_WARGRADETITLE"))
    end
  else
    self._ui._title.txt_warGrade:SetShow(false)
  end
  if false == _ContentsGroup_Siege then
    self._ui._title.txt_warGrade:SetShow(false)
  end
end
function PaGlobal_GuildMemberList_All:ControlPc_Init()
  if nil == Panel_GuildMemeberList_All then
    return
  end
  self._ui_pc.stc_funcBg = UI.getChildControl(Panel_GuildMemeberList_All, "Static_FunctionBG")
  self._ui_pc.btn_func = UI.getChildControl(Panel_GuildMemeberList_All, "Button_Function_Temp")
  self._menuButtonSize.x = self._ui_pc.btn_func:GetSizeX()
  self._menuButtonSize.y = self._ui_pc.btn_func:GetSizeY()
  self._ui_pc.stc_setVolumBg = UI.getChildControl(Panel_GuildMemeberList_All, "Static_Listening_VolumeBG")
  self._ui_pc.slider_listenVol = UI.getChildControl(self._ui_pc.stc_setVolumBg, "Slider_ListeningVolume")
  self._ui_pc.slider_listenVolBtn = UI.getChildControl(self._ui_pc.slider_listenVol, "Slider_MicVol_Button")
  self._ui_pc.chk_listenIcon = UI.getChildControl(self._ui_pc.stc_setVolumBg, "Checkbox_SpeakerIcon")
  self._ui_pc.txt_volumVal = UI.getChildControl(self._ui_pc.stc_setVolumBg, "StaticText_SpeakerVolumeValue")
  self._ui_pc.btn_setVolumClose = UI.getChildControl(self._ui_pc.stc_setVolumBg, "Button_VolumeSetClose")
end
function PaGlobal_GuildMemberList_All:ControlConsole_Init()
  if nil == Panel_GuildMemeberList_All then
    return
  end
end
function PaGlobal_GuildMemberList_All:ControlSetShow()
  if nil == Panel_GuildMemeberList_All then
    return
  end
  if true == self._isConsole then
    self._ui.stc_listMember:SetIgnore(false)
    self._ui.btn_getFund:SetShow(false)
    self._ui.btn_deposit:SetShow(false)
    self._ui.btn_warReward:SetShow(false)
    self._ui.btn_guildFundManage:SetShow(false)
    self._ui.btn_guildLifeFund:SetShow(false)
  else
    self._ui.stc_listMember:SetIgnore(true)
    self._ui.stc_listMember:ReleaseTexture()
    self._ui.btn_getFund:SetShow(true)
    self._ui.btn_deposit:SetShow(true)
    self._ui.btn_warReward:SetShow(true)
    self._ui.btn_guildFundManage:SetShow(true)
    self._ui.btn_guildLifeFund:SetShow(true)
  end
  if false == _ContentsGroup_Siege then
    self._ui.btn_warReward:SetShow(false)
  end
end
function PaGlobal_GuildMemberList_All:CreateControl()
  if nil == Panel_GuildMemeberList_All then
    return
  end
  local listStartY = self._ui.frame_content:GetPosY()
  local gabY = 3
  local function createListInfo(pIndex)
    local tempMember = {}
    tempMember._memberBg = UI.createAndCopyBasePropertyControl(self._ui.frame_content, "Static_List_Temp", self._ui.frame_content, "guildMemeberlist_MemberBg_" .. pIndex)
    tempMember._grade = UI.createAndCopyBasePropertyControl(self._ui.stc_listMember, "StaticText_C_Grade", tempMember._memberBg, "guildMemeberlist_Grade_" .. pIndex)
    tempMember._level = UI.createAndCopyBasePropertyControl(self._ui.stc_listMember, "StaticText_C_Level", tempMember._memberBg, "guildMemeberlist_Level_" .. pIndex)
    tempMember._class = UI.createAndCopyBasePropertyControl(self._ui.stc_listMember, "StaticText_C_Class", tempMember._memberBg, "guildMemeberlist_Class_" .. pIndex)
    tempMember._charName = UI.createAndCopyBasePropertyControl(self._ui.stc_listMember, "StaticText_C_CharName", tempMember._memberBg, "guildMemeberlist_CharName_" .. pIndex)
    tempMember._activity = UI.createAndCopyBasePropertyControl(self._ui.stc_listMember, "StaticText_C_Activity", tempMember._memberBg, "guildMemeberlist_Activity_" .. pIndex)
    tempMember._contributedTendency = UI.createAndCopyBasePropertyControl(self._ui.stc_listMember, "StaticText_C_ContributedTendency", tempMember._memberBg, "guildMemeberlist_Contribute_" .. pIndex)
    tempMember._contractBtn = UI.createAndCopyBasePropertyControl(self._ui.stc_listMember, "Button_C_Contract", tempMember._memberBg, "guildMemeberlist_Contract_" .. pIndex)
    tempMember._guard = UI.createAndCopyBasePropertyControl(self._ui.stc_listMember, "Static_C_GuardHim", tempMember._memberBg, "guildMemeberlist_GuardHim_" .. pIndex)
    tempMember._voiceListen = UI.createAndCopyBasePropertyControl(self._ui.stc_listMember, "StaticText_C_Voice_Listening", tempMember._memberBg, "guildMemeberlist_Voice_Listening_" .. pIndex)
    tempMember._voiceTalk = UI.createAndCopyBasePropertyControl(self._ui.stc_listMember, "StaticText_C_Voice_Saying", tempMember._memberBg, "guildMemeberlist_Voice_Saying_" .. pIndex)
    tempMember._warState = UI.createAndCopyBasePropertyControl(self._ui.stc_listMember, "Button_WarState", tempMember._memberBg, "guildMemeberlist_WarState_" .. pIndex)
    tempMember._warGrade = UI.createAndCopyBasePropertyControl(self._ui.stc_listMember, "Button_WarGrade", tempMember._memberBg, "guildMemeberlist_WarGrade_" .. pIndex)
    tempMember._platformIcon = UI.createAndCopyBasePropertyControl(self._ui.stc_listMember, "Static_CrossPlay", tempMember._memberBg, "guildMemeberlist_PlatformIcon_" .. pIndex)
    for _, var in pairs(tempMember) do
      var:ComputePos()
      var:addInputEvent("Mouse_UpScroll", "HandleEventScroll_GuildMemeberList_All_Scroll(true)")
      var:addInputEvent("Mouse_DownScroll", "HandleEventScroll_GuildMemeberList_All_Scroll(false)")
    end
    if false == self._isConsole then
      tempMember._memberBg:ChangeTextureInfoName("")
    end
    tempMember._grade:SetIgnore(self._isConsole)
    tempMember._level:SetIgnore(self._isConsole)
    tempMember._class:SetIgnore(self._isConsole)
    tempMember._charName:SetIgnore(self._isConsole)
    tempMember._activity:SetIgnore(self._isConsole)
    tempMember._contributedTendency:SetIgnore(self._isConsole)
    tempMember._voiceTalk:SetAutoDisableTime(2)
    tempMember._voiceTalk:DoAutoDisableTime()
    tempMember._voiceListen:SetAutoDisableTime(2)
    tempMember._voiceListen:DoAutoDisableTime()
    tempMember._voiceTalk:SetIgnore(self._isConsole)
    tempMember._voiceListen:SetIgnore(self._isConsole)
    tempMember._guard:SetShow(false)
    tempMember._warGrade:SetShow(false)
    if false == self._contentOpen.voice then
      tempMember._voiceListen:SetShow(false)
      tempMember._voiceTalk:SetShow(false)
    end
    if false == self._contentOpen.warGrade then
      tempMember._warState:SetShow(false)
      tempMember._warGrade:SetShow(false)
    end
    if false == _ContentsGroup_Siege then
      tempMember._warState:SetShow(false)
      tempMember._warGrade:SetShow(false)
    end
    tempMember._memberBg:SetShow(false)
    tempMember._memberBg:SetPosY(listStartY + (tempMember._memberBg:GetSizeY() + gabY) * pIndex)
    tempMember._platformIcon:SetShow(false)
    self._config.gradeSpanX = tempMember._grade:GetSpanSize().x
    return tempMember
  end
  local function createMenuButton(pIndex)
    if nil == self._MenuButtonStr[pIndex] then
      return
    end
    local tempButton = {}
    local tempButton = UI.createAndCopyBasePropertyControl(Panel_GuildMemeberList_All, "Button_Function_Temp", self._ui_pc.stc_funcBg, "guildMemeberList_MenuButton_" .. pIndex)
    tempButton:SetPosX(5)
    tempButton:SetShow(false)
    if true == isGameTypeTH() or true == isGameTypeID() then
      tempButton:SetSize(self._menuButtonSize.x + 10, self._menuButtonSize.y)
    else
      tempButton:SetSize(self._menuButtonSize.x, self._menuButtonSize.y)
    end
    tempButton:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMemberList_All_SelectMenuButton(" .. pIndex .. ")")
    tempButton:SetText(self._MenuButtonStr[pIndex])
    return tempButton
  end
  for index = 0, self._config.listMaxCount do
    self._ui._memberlist[index] = createListInfo(index)
  end
  for index = 0, self._MenuButtonType.COUNT do
    self._ui._buttonlist[index] = createMenuButton(index)
  end
end
function PaGlobal_GuildMemberList_All:FrameUpdate()
  self._ui.frame_list:UpdateContentScroll()
  self._ui.frame_list:UpdateContentPos()
  self._ui.scroll_vs:SetInterval(self._ui.frame_content:GetSizeY() / 100 * 1.1)
end
function PaGlobal_GuildMemberList_All:prepareOpen()
  self._ui_pc.stc_setVolumBg:SetShow(false)
  self._ui_pc.stc_funcBg:SetShow(false)
  ToClient_RequestWarehouseInfo()
  self._ui.scroll_vs:SetControlPos(0)
  PaGlobal_GuildMemberList_All:guildListSortSet()
  PaGlobal_GuildMemberList_All:open()
  PaGlobal_GuildMemberList_All:update()
  PaGlobal_GuildMemberList_All:resize()
end
function PaGlobal_GuildMemberList_All:open()
  Panel_GuildMemeberList_All:SetShow(true)
end
function PaGlobal_GuildMemberList_All:prepareClose()
  PaGlobal_GuildMemberList_All:close()
end
function PaGlobal_GuildMemberList_All:close()
  Panel_GuildMemeberList_All:SetShow(false)
end
function PaGlobal_GuildMemberList_All:update()
  self:setGuildMemberData()
  self:updateBottomInfo()
  self:updateSort()
  self:updateListInfo()
  self:FrameUpdate()
  self:resize()
end
function PaGlobal_GuildMemberList_All:registEventHandler()
  if nil == Panel_GuildMemeberList_All then
    return
  end
  registerEvent("FromClient_ResponseGuildUpdate", "")
  registerEvent("FromClient_GuildListUpdate", "FromClient_GuildMemberList_All_UpdateMemberList")
  registerEvent("FromClient_ResponseGuildMasterChange", "FromClient_GuildMemberList_All_ResponseGuildMasterChange")
  registerEvent("FromClient_ResponseChangeGuildMemberGrade", "FromClient_GuildMemberList_All_ResponseChangeGuildMemberGrade")
  registerEvent("FromClient_RequestExpelMemberFromGuild", "FromClient_GuildMemberList_All_RequestExpelMemberFromGuild")
  registerEvent("FromClient_RequestChangeGuildMemberGrade", "FromClient_GuildMemberList_All_RequestChangeGuildMemberGrade")
  registerEvent("FromClient_ResponseChangeProtectGuildMember", "FromClient_GuildMemberList_All_ResponseChangeProtectGuildMember")
  registerEvent("FromClient_ChangedSiegeGrade", "FromClient_GuildMemberList_All_ChangedSiegeGrade")
  registerEvent("FromClient_ResponseParticipateSiege", "FromClient_GuildMemberList_All_ResponseParticipateSiege")
  registerEvent("FromClient_ResponseTakableSiegeReward", "FromClient_GuildMemberList_All_ResponseTakableSiegeReward")
  UIScroll.InputEvent(self._ui.scroll_vs, "HandleEventScroll_GuildMemeberList_All_Scroll")
  self._ui.frame_content:addInputEvent("Mouse_UpScroll", "HandleEventScroll_GuildMemeberList_All_Scroll(true)")
  self._ui.frame_content:addInputEvent("Mouse_DownScroll", "HandleEventScroll_GuildMemeberList_All_Scroll(false)")
  for index = 0, self._SortType.COUNT - 1 do
    if false == self._isConsole then
      self._ui._titlelist[index]:addInputEvent("Mouse_On", "HandleEventOnOut_GuildMemeberList_All_TitleTooltip(true, " .. index .. ")")
      self._ui._titlelist[index]:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildMemeberList_All_TitleTooltip(false," .. index .. " )")
      self._ui._titlelist[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMemeberList_All_ListSort(" .. index .. ")")
    end
  end
  if true == __Guild_LimitPrice then
    self._ui.btn_guildFundManage:addInputEvent("Mouse_LUp", "PaGlobal_Guild_ChoiseTheMoney:Open()")
  else
    self._ui.btn_guildFundManage:SetText(PAGetString(Defines.StringSheet_RESOURCE, "FRAME_GUILD_LIST_BTN_INCENTIVE"))
    self._ui.btn_guildFundManage:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMemberList_All_IncentiveOption()")
  end
  self._ui.btn_warReward:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMemberList_All_TakeSiegeReward()")
  self._ui.btn_guildLifeFund:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMemberList_All_WelfareRequest()")
  self._ui.btn_getFund:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMemberList_All_TakeFund()")
  self._ui.btn_deposit:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMemberList_All_Deposit()")
  self._ui.txt_guildFund:addInputEvent("Mouse_On", "HandleEventOnOut_GuildMemeberList_All_GuildFundTooltip(true)")
  self._ui.txt_guildFund:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildMemeberList_All_GuildFundTooltip(false)")
  self._ui.btn_guildLifeFund:addInputEvent("Mouse_On", "HandleEventOnOut_GuildMemberList_All_GuildLifeFundTooltip(true)")
  self._ui.btn_guildLifeFund:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildMemberList_All_GuildLifeFundTooltip(false)")
  if true == self._contentOpen.voice then
    self._ui_pc.btn_setVolumClose:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMemberList_All_VolumeClose()")
    self._ui_pc.chk_listenIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMemberList_All_VolumeListenCheck()")
    self._ui_pc.slider_listenVol:addInputEvent("Mouse_LUp", "HandleEventLPress_GuildMemberList_All_VolumeListenSet()")
    self._ui_pc.slider_listenVolBtn:addInputEvent("Mouse_LPress", "HandleEventLPress_GuildMemberList_All_VolumeListenSet()")
  end
end
function PaGlobal_GuildMemberList_All:validate()
  if nil == Panel_GuildMemeberList_All then
    return
  end
end
function PaGlobal_GuildMemberList_All:resize()
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  if true == self._contentOpen.voice then
    if 0 < ToClient_getGameOptionControllerWrapper():getUIFontSizeType() then
    else
    end
  else
    self._ui._titlelist[self._SortType.NAME]:SetSpanSize(250, 0)
    self._ui._titlelist[self._SortType.NAME]:ComputePos()
    self._ui._titlelist[self._SortType.APOINT]:SetSpanSize(550, 0)
    self._ui._titlelist[self._SortType.APOINT]:ComputePos()
    self._ui._titlelist[self._SortType.WPOINT]:SetSpanSize(350, 0)
    self._ui._titlelist[self._SortType.WPOINT]:ComputePos()
    self._ui._titlelist[self._SortType.WGRADE]:SetSpanSize(170, 0)
    self._ui._titlelist[self._SortType.WGRADE]:ComputePos()
    for index = 0, self._config.listMaxCount - 1 do
      local memberlistControl = self._ui._memberlist[index]
      memberlistControl._charName:SetSpanSize(230, 0)
      memberlistControl._activity:SetSpanSize(520, 0)
      memberlistControl._contributedTendency:SetSpanSize(660, 0)
    end
  end
  local gabX = 10
  for index = 0, self._config.listMaxCount - 1 do
    local memberlistControl = self._ui._memberlist[index]
    for k, v in ipairs(memberlistControl) do
      if nil ~= v and true == v:GetShow() then
        v:ComputePos()
      end
    end
    if true == self._contentOpen.warGrade then
      local titleCenterPosX = self._ui._title.txt_warGrade:GetPosX() + self._ui._title.txt_warGrade:GetSizeX() / 2
      memberlistControl._warGrade:SetPosX(titleCenterPosX - memberlistControl._warGrade:GetSizeX() / 2 - gabX)
      memberlistControl._warState:SetPosX(titleCenterPosX - memberlistControl._warState:GetSizeX() / 2 - gabX)
    end
  end
  if false == self._isConsole then
    local bottomBtnList = {
      [1] = self._ui.btn_getFund,
      [2] = self._ui.btn_deposit,
      [3] = self._ui.btn_warReward,
      [4] = self._ui.btn_guildFundManage,
      [5] = self._ui.btn_guildLifeFund
    }
    local rightSpanSizeX = 10
    for ii = 1, #bottomBtnList do
      if nil ~= bottomBtnList[ii] and true == bottomBtnList[ii]:GetShow() then
        bottomBtnList[ii]:SetSpanSize(rightSpanSizeX, bottomBtnList[ii]:GetSpanSize().y)
        rightSpanSizeX = rightSpanSizeX + bottomBtnList[ii]:GetSizeX() + 5
      end
    end
  end
end
function PaGlobal_GuildMemberList_All:setGradeInfo(control, index, grade, isVacation)
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  if nil == control then
    return
  end
  control:ChangeTextureInfoName("Renewal/PcRemaster/Remaster_ETC_Guild.dds")
  if __eGuildMemberGradeMaster == grade then
    local x1, y1, x2, y2 = setTextureUV_Func(control, 224, 227, 267, 253)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif __eGuildMemberGradeSubMaster == grade then
    local x1, y1, x2, y2 = setTextureUV_Func(control, 224, 200, 267, 226)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif __eGuildMemberGradeNormal == grade then
    local x1, y1, x2, y2 = setTextureUV_Func(control, 224, 146, 267, 172)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif __eGuildMemberGradeSupplyOfficer == grade then
    local x1, y1, x2, y2 = setTextureUV_Func(control, 224, 173, 267, 199)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif __eGuildMemberGradeJunior == grade then
    control:ChangeTextureInfoName("Renewal/PcRemaster/Remaster_ETC_Guild01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 1, 1, 44, 27)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:SetSpanSize(self._config.gradeSpanX - 1, 0)
  end
  control:setRenderTexture(control:getBaseTexture())
  if true == isVacation then
    control:SetMonoTone(true)
    control:addInputEvent("Mouse_On", "HandleEventOnOut_GuildMemeberList_All_VacationTooltip( true, " .. index .. " )")
    control:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildMemeberList_All_VacationTooltip( false, " .. index .. " )")
  else
    control:SetMonoTone(false)
    control:addInputEvent("Mouse_On", "HandleEventOnOut_GuildMemeberList_All_GradeTooltip( true, " .. index .. ", " .. grade .. " )")
    control:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildMemeberList_All_GradeTooltip( false, " .. index .. ", " .. grade .. " )")
  end
end
function PaGlobal_GuildMemberList_All:getClassText(classType)
  return CppEnums.ClassType2String[classType]
end
function PaGlobal_GuildMemberList_All:setVoiceButton(index, guildMember, control)
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  if true == self._contentOpen.voice then
    if guildMember:isVoiceChatSpeak() then
      if guildMember:isVoiceSpeaking() then
        control._voiceTalk:SetMonoTone(false, true)
      else
        control._voiceTalk:SetMonoTone(true, true)
      end
    else
      control._voiceTalk:SetMonoTone(true, true)
    end
    control._voiceListen:SetMonoTone(not guildMember:isVoiceChatListen(), true)
    control._voiceTalk:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMemberList_All_VoiceChatTalkingSet(" .. index .. ")")
    control._voiceTalk:addInputEvent("Mouse_On", "HandleEventOnOut_GuildMemeberList_All_VoiceIconTooltip( true, " .. index .. "," .. 0 .. ")")
    control._voiceTalk:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildMemeberList_All_VoiceIconTooltip( false, " .. index .. "," .. 0 .. ")")
    control._voiceListen:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMemberList_All_VoiceChatListeningOpen(" .. index .. ")")
    control._voiceListen:addInputEvent("Mouse_On", "HandleEventOnOut_GuildMemeberList_All_VoiceIconTooltip( true, " .. index .. "," .. 1 .. ")")
    control._voiceListen:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildMemeberList_All_VoiceIconTooltip( false, " .. index .. "," .. 1 .. ")")
  end
end
function PaGlobal_GuildMemberList_All:setOnline(isOnline, guildMemberInfo, elementControl, index, dataIdx)
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  if nil == guildMemberInfo or nil == elementControl then
    return
  end
  if true == isOnline then
    local usableActivity = guildMemberInfo:getUsableActivity()
    if 10000 < usableActivity then
      usableActivity = 10000
    end
    local textActivity = tostring(guildMemberInfo:getTotalActivity()) .. "(<PAColor0xfface400>+" .. tostring(usableActivity) .. "<PAOldColor>)"
    elementControl._activity:SetText(textActivity)
    elementControl._activity:SetFontColor(Defines.Color.C_FFDDC39E)
    elementControl._level:SetFontColor(Defines.Color.C_FFDDC39E)
    elementControl._class:SetFontColor(Defines.Color.C_FFDDC39E)
    elementControl._contributedTendency:SetFontColor(Defines.Color.C_FFDDC39E)
    if true == guildMemberInfo:isSelf() then
      elementControl._charName:SetFontColor(Defines.Color.C_FFEF9C7F)
    else
      elementControl._charName:SetFontColor(Defines.Color.C_FFDDC39E)
    end
    local gamerTag = ""
    if true == _ContentsGroup_RenewUI then
      if true == ToClient_isPS4() then
        if nil ~= ToClient_getSelfPlayerOnlineId() then
          gamerTag = " / ( " .. tostring(ToClient_getOnlineId(guildMemberInfo:getUserNo())) .. " )"
        end
      elseif nil ~= ToClient_getXboxGuildUserGamerTag(guildMemberInfo:getUserNo()) then
        gamerTag = " / ( " .. tostring(ToClient_getXboxGuildUserGamerTag(guildMemberInfo:getUserNo())) .. " )"
      end
    end
    local selfPlayerPlatform = ToClient_getGamePlatformType()
    if guildMemberInfo:getPlatformType() ~= selfPlayerPlatform then
      gamerTag = "/ ( - )"
    end
    elementControl._charName:addInputEvent("Mouse_On", "")
    elementControl._charName:addInputEvent("Mouse_Out", "")
    elementControl._charName:SetText(guildMemberInfo:getName() .. " (" .. guildMemberInfo:getCharacterName() .. ")" .. gamerTag)
    elementControl._charName:SetTextMode(__eTextMode_LimitText)
    elementControl._charName:SetText(elementControl._charName:GetText())
    if 0 < ToClient_getGameOptionControllerWrapper():getUIFontSizeType() then
      elementControl._charName:SetText(guildMemberInfo:getName())
      elementControl._charName:addInputEvent("Mouse_On", "HandleEventOnOut_GuildMemberList_All_CharacterNameTooltip(true, " .. dataIdx .. "," .. index .. ")")
      elementControl._charName:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildMemberList_All_CharacterNameTooltip(false)")
    else
      UI.setLimitTextAndAddTooltip(elementControl._charName)
    end
    if true == self._contentOpen.voice then
      elementControl._voiceListen:SetIgnore(false)
      elementControl._voiceTalk:SetIgnore(false)
    end
  else
    local textActivity = tostring(guildMemberInfo:getTotalActivity()) .. "(+" .. tostring(guildMemberInfo:getUsableActivity()) .. ")"
    elementControl._activity:SetText(textActivity)
    elementControl._contributedTendency:SetFontColor(Defines.Color.C_FF5A5A5A)
    elementControl._activity:SetFontColor(Defines.Color.C_FF5A5A5A)
    elementControl._level:SetFontColor(Defines.Color.C_FF5A5A5A)
    elementControl._class:SetFontColor(Defines.Color.C_FF5A5A5A)
    elementControl._charName:SetFontColor(Defines.Color.C_FF5A5A5A)
    elementControl._charName:SetText(guildMemberInfo:getName() .. " ( - )")
    elementControl._charName:addInputEvent("Mouse_On", "")
    elementControl._charName:addInputEvent("Mouse_Out", "")
    elementControl._level:SetText("-")
    elementControl._class:SetText("-")
    if true == self._contentOpen.voice then
      elementControl._voiceListen:SetIgnore(true)
      elementControl._voiceTalk:SetIgnore(true)
    end
  end
end
function PaGlobal_GuildMemberList_All:setContractButton(index, guildMember, contractButton)
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  local contractAble = guildMember:getContractableUtc()
  local expiration = guildMember:getContractedExpirationUtc()
  local isContractState = self._ContractType.recontactable
  if 0 < Int64toInt32(getLeftSecond_TTime64(expiration)) then
    isContractState = self._ContractType.contacting
    if 0 >= Int64toInt32(getLeftSecond_TTime64(contractAble)) then
      isContractState = self._ContractType.recontactable
    end
  else
    isContractState = self._ContractType.expiration
  end
  self:changeTextureContactBtn(contractButton, isContractState)
  contractButton:addInputEvent("Mouse_On", "HandleEventOnOut_GuildMemeberList_All_ContractTooltip( true, " .. isContractState .. ", " .. index .. ")")
  contractButton:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildMemeberList_All_ContractTooltip( false, " .. isContractState .. ", " .. index .. ")")
  contractButton:setTooltipEventRegistFunc("HandleEventOnOut_GuildMemeberList_All_ContractTooltip( true, " .. isContractState .. ", " .. index .. ")")
  contractButton:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMemberList_All_ContractClick( " .. index .. " )")
  if 0 == ToClient_GetMyGuildInfoWrapper():getGuildGrade() then
    contractButton:SetIgnore(true)
    contractButton:SetMonoTone(true)
  else
    contractButton:SetIgnore(false)
    contractButton:SetMonoTone(false)
  end
end
function PaGlobal_GuildMemberList_All:changeTextureContactBtn(control, state)
  control:ChangeTextureInfoName("combine/etc/combine_etc_guild_00.dds")
  if self._ContractType.expiration == state then
    local x1, y1, x2, y2 = setTextureUV_Func(control, 201, 116, 223, 138)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
    local x1, y1, x2, y2 = setTextureUV_Func(control, 201, 139, 223, 161)
    control:getOnTexture():setUV(x1, y1, x2, y2)
    local x1, y1, x2, y2 = setTextureUV_Func(control, 201, 162, 223, 184)
    control:getClickTexture():setUV(x1, y1, x2, y2)
  elseif self._ContractType.recontactable == state then
    local x1, y1, x2, y2 = setTextureUV_Func(control, 201, 47, 223, 69)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
    local x1, y1, x2, y2 = setTextureUV_Func(control, 201, 70, 223, 92)
    control:getOnTexture():setUV(x1, y1, x2, y2)
    local x1, y1, x2, y2 = setTextureUV_Func(control, 201, 93, 223, 115)
    control:getClickTexture():setUV(x1, y1, x2, y2)
  elseif self._ContractType.contacting == state then
    local x1, y1, x2, y2 = setTextureUV_Func(control, 201, 185, 223, 207)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
    local x1, y1, x2, y2 = setTextureUV_Func(control, 201, 208, 223, 230)
    control:getOnTexture():setUV(x1, y1, x2, y2)
    local x1, y1, x2, y2 = setTextureUV_Func(control, 201, 231, 223, 253)
    control:getClickTexture():setUV(x1, y1, x2, y2)
  end
end
function PaGlobal_GuildMemberList_All:setSiegeParticipant(index, guildMember, control)
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  local buttonSizeGapX = 15
  local buttonSizeGapY = 0
  local participantText = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGE_PARTICIPANT")
  local nonparticipantText = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGE_NONPARTICIPANT")
  if true == self._isConsole then
    participantText = "O"
    nonparticipantText = "X"
  end
  if false == _ContentsGroup_Siege then
    control._warGrade:SetShow(false)
    control._warState:SetShow(false)
    return
  end
  if true == guildMember:isSelf() then
    control._warGrade:SetShow(true)
    control._warState:SetShow(false)
    if guildMember:isSiegeParticipant() then
      if true == _ContentsGroup_SiegeCost then
        if true == ToClient_getSiegeParticipant() then
          participantText = participantText .. ":" .. tostring(ToClient_getSiegeMercenaryMaxCost())
        else
          participantText = participantText .. ":-"
        end
      end
      control._warGrade:SetText(participantText)
      if false == self._isConsole then
        control._warGrade:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMemberList_All_RequestParticipateAtSiege(false)")
      end
    else
      if true == _ContentsGroup_SiegeCost then
        nonparticipantText = nonparticipantText .. ":" .. tostring(ToClient_getSiegeMercenaryCost())
      end
      control._warGrade:SetText(nonparticipantText)
      if false == self._isConsole then
        control._warGrade:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMemberList_All_RequestParticipateAtSiege(true)")
      end
    end
  else
    control._warGrade:SetShow(false)
    control._warState:SetShow(true)
    if false == isRealServiceMode() then
      control._warState:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMemberList_All_RequestParticipateAtSiegeFromMaster( " .. tostring(guildMember:getUserNo()) .. " )")
    end
    if guildMember:isSiegeParticipant() then
      if true == _ContentsGroup_SiegeCost then
        participantText = participantText .. ":" .. tostring(guildMember:getMercenaryCost())
      end
      control._warState:SetText(participantText)
    else
      control._warState:SetText(nonparticipantText)
    end
  end
  if true == guildMember:isVacation() then
    control._warGrade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MEMBER_LIST_WAR_JOINBUTTON_VACATION"))
    control._warState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MEMBER_LIST_WAR_JOINBUTTON_VACATION"))
    control._warGrade:addInputEvent("Mouse_LUp", "")
    control._warState:addInputEvent("Mouse_LUp", "")
    control._warGrade:SetFontColor(Defines.Color.C_FF5A5A5A)
    control._warState:SetFontColor(Defines.Color.C_FF5A5A5A)
  else
    control._warGrade:SetFontColor(Defines.Color.C_FFDDC39E)
    control._warState:SetFontColor(Defines.Color.C_FFDDC39E)
  end
  control._warGrade:SetSize(control._warGrade:GetTextSizeX() + buttonSizeGapX, control._warGrade:GetTextSizeY() + buttonSizeGapY)
  control._warGrade:SetSize(control._warGrade:GetTextSizeX() + buttonSizeGapX, control._warGrade:GetTextSizeY() + buttonSizeGapY)
end
function PaGlobal_GuildMemberList_All:getGuildLogOutTimeConvert(s64_datetime)
  local s64_dayCycle = toInt64(0, 86400)
  local s64_hourCycle = toInt64(0, 3600)
  local s64_day = s64_datetime / s64_dayCycle
  local s64_hour = (s64_datetime - s64_dayCycle * s64_day) / s64_hourCycle
  local strDate = ""
  if s64_day > Defines.s64_const.s64_0 then
    strDate = tostring(s64_day) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY")
  elseif s64_hour > Defines.s64_const.s64_0 then
    strDate = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY_IN")
  else
    strDate = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY_IN")
  end
  return strDate
end
function PaGlobal_GuildMemberList_All:titleLineReset()
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  self._ui._title.txt_grade:SetText(PAGetString(Defines.StringSheet_RESOURCE, "GUILD_TEXT_POSITION"))
  self._ui._title.txt_level:SetText(PAGetString(Defines.StringSheet_RESOURCE, "GUILD_TEXT_LEVEL"))
  self._ui._title.txt_class:SetText(PAGetString(Defines.StringSheet_RESOURCE, "GUILD_TEXT_CLASS"))
  self._ui._title.txt_name:SetText(PAGetString(Defines.StringSheet_RESOURCE, "GUILD_TEXT_CHARNAME"))
  self._ui._title.txt_activity:SetText(PAGetString(Defines.StringSheet_RESOURCE, "GUILD_TEXT_ACTIVITY"))
  self._ui._title.txt_contract:SetText(PAGetString(Defines.StringSheet_RESOURCE, "GUILD_TEXT_HIRE"))
  self._ui._title.txt_contribute:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_LIST_CONTRIGUTED"))
  self._ui._title.txt_warGrade:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDLIST_WARPARTICIPANT_TITLE"))
  if true == _ContentsGroup_RenewUI then
    self._ui._title.txt_name:SetText(self._ui._title.txt_name:GetText() .. " / (" .. ToClient_ConsoleUserNameString() .. ")")
    for index = 0, self._SortType.COUNT - 1 do
      local msgDataLen = string.len(self._ui._titlelist[index]:GetText())
      local targetIdx = string.find(self._ui._titlelist[index]:GetText(), "<PAColor")
      if nil ~= targetIdx then
        local msgData = string.sub(self._ui._titlelist[index]:GetText(), 1, targetIdx - 2)
        self._ui._titlelist[index]:SetText(msgData)
      end
    end
  end
end
function PaGlobal_GuildMemberList_All:updateSort()
  if self._SortType.GRADE == self._selectSortType then
    table.sort(self._memberlistData, guildListCompareGrade)
  elseif self._SortType.LEVEL == self._selectSortType then
    table.sort(self._memberlistData, guildListCompareLev)
  elseif self._SortType.CLASS == self._selectSortType then
    table.sort(self._memberlistData, guildListCompareClass)
  elseif self._SortType.NAME == self._selectSortType then
    table.sort(self._memberlistData, guildListCompareName)
  elseif self._SortType.APOINT == self._selectSortType then
    table.sort(self._memberlistData, guildListCompareAp)
  elseif self._SortType.CONTACT == self._selectSortType then
    table.sort(self._memberlistData, guildListCompareExpiration)
  elseif self._SortType.WPOINT == self._selectSortType then
    table.sort(self._memberlistData, guildListCompareWp)
  elseif self._SortType.WGRADE == self._selectSortType then
    table.sort(self._memberlistData, guildListSiegeGrade)
  end
end
function PaGlobal_GuildMemberList_All:guildListSortSet()
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  self._selectSortType = self._SortType.GRADE
  self._listSort[self._selectSortType] = true
  self:titleLineReset()
end
function PaGlobal_GuildMemberList_All:setGuildMemberData()
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local memberCount = myGuildListInfo:getMemberCount()
  for index = 1, memberCount do
    local tempGuildList = {}
    local myGuildMemberInfo = myGuildListInfo:getMember(index - 1)
    if nil == myGuildMemberInfo then
      return
    end
    local prevLevel = myGuildMemberInfo:getLevel()
    local prevWp = myGuildMemberInfo:getMaxWp()
    local prevClass = myGuildMemberInfo:getClassType()
    if false == myGuildMemberInfo:isOnline() or true == myGuildMemberInfo:isGhostMode() then
      prevLevel = 0
      prevWp = 0
      prevClass = __eClassType_Count
    end
    tempGuildList = {
      idx = index - 1,
      online = myGuildMemberInfo:isOnline(),
      grade = myGuildMemberInfo:getGrade(),
      level = prevLevel,
      class = prevClass,
      name = myGuildMemberInfo:getName(),
      ap = Int64toInt32(myGuildMemberInfo:getTotalActivity()),
      expiration = myGuildMemberInfo:getContractedExpirationUtc(),
      wp = prevWp,
      kp = myGuildMemberInfo:getExplorationPoint(),
      userNo = myGuildMemberInfo:getUserNo(),
      siegegrade = myGuildMemberInfo:getSiegeCombatantGrade(),
      siegeParticipant = myGuildMemberInfo:isSiegeParticipant()
    }
    self._memberlistData[index] = tempGuildList
  end
end
function PaGlobal_GuildMemberList_All:updateBottomInfo()
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local guildGrade = myGuildInfo:getGuildGrade()
  local businessFunds_s64 = myGuildInfo:getGuildBusinessFunds_s64()
  self._ui.txt_guildFund:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_GUILDMONEY", "getGuildMoney", makeDotMoney(businessFunds_s64)))
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
  if (true == isGuildMaster or true == isGuildSubMaster) and self._GuildGrade.GUILD == guildGrade then
    self._ui.btn_guildLifeFund:SetShow(false == self._isConsole)
  else
    self._ui.btn_guildLifeFund:SetShow(false)
  end
  self._ui.btn_guildFundManage:SetShow(false)
  if true == isGuildMaster then
    self._ui.btn_guildFundManage:SetShow(false == self._isConsole)
  end
  local accumulateTax_s64 = myGuildInfo:getAccumulateTax()
  local accumulateCost_s64 = myGuildInfo:getAccumulateGuildHouseCost()
  self._ui.btn_deposit:SetShow(false == self._isConsole)
  self._ui.btn_deposit:SetMonoTone(true)
  if accumulateTax_s64 > toInt64(0, 0) or accumulateCost_s64 > toInt64(0, 0) then
    if businessFunds_s64 < accumulateTax_s64 or businessFunds_s64 < accumulateCost_s64 then
      self._ui.btn_deposit:SetMonoTone(false)
      self._ui.btn_deposit:SetEnable(true)
    else
      self._ui.btn_deposit:SetMonoTone(true)
      self._ui.btn_deposit:SetEnable(false)
    end
  else
    self._ui.btn_deposit:SetMonoTone(true)
    self._ui.btn_deposit:SetEnable(false)
  end
  self._ui.btn_warReward:SetMonoTone(true)
  self._ui.btn_warReward:SetEnable(false)
  self._ui.btn_getFund:SetMonoTone(true)
  self._ui.btn_getFund:SetIgnore(true)
  local memberCount = myGuildInfo:getMemberCount()
  for index = 0, memberCount - 1 do
    local dataIdx = self._memberlistData[index + 1].idx
    local myGuildMemberInfo = myGuildInfo:getMember(dataIdx)
    if nil == myGuildInfo then
      return
    end
    local userNo = myGuildMemberInfo:getUserNo()
    local myUserNo = getSelfPlayer():get():getUserNo()
    self._memberUserNolist = userNo
    if true == myGuildMemberInfo:isSelf() or userNo == myUserNo then
      local isTakableSiegeReward = myGuildMemberInfo:isTakableSiegeReward()
      self._ui.btn_warReward:SetMonoTone(not isTakableSiegeReward)
      self._ui.btn_warReward:SetEnable(isTakableSiegeReward)
      if myGuildMemberInfo:isCollectableBenefit() and false == myGuildMemberInfo:isFreeAgent() and toInt64(0, 0) < myGuildMemberInfo:getContractedBenefit() then
        if nil ~= PaGlobal_AgreementGuildMaster_GetShow and true == PaGlobal_AgreementGuildMaster_GetShow() then
          self._ui.btn_getFund:SetMonoTone(true)
          self._ui.btn_getFund:SetIgnore(true)
        else
          self._ui.btn_getFund:SetMonoTone(false)
          self._ui.btn_getFund:SetIgnore(false)
        end
        if toInt64(0, 0) == businessFunds_s64 then
          self._ui.btn_getFund:SetFontColor(Defines.Color.C_FFF26A6A)
          break
        end
        self._ui.btn_getFund:SetFontColor(Defines.Color.C_FFEDEDEE)
      end
      break
    end
  end
  if true == PaGlobalFunc_GuildMain_All_CheckIsMecernary() then
    self._ui.btn_deposit:SetShow(false)
    self._ui.btn_getFund:SetShow(false)
    self._ui.btn_warReward:SetShow(false)
  else
    self._ui.btn_deposit:SetShow(false == self._isConsole)
    self._ui.btn_getFund:SetShow(false == self._isConsole)
    self._ui.btn_warReward:SetShow(false == self._isConsole and true == _ContentsGroup_Siege)
  end
end
function PaGlobal_GuildMemberList_All:updateListInfo()
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  for index = 0, self._config.listMaxCount do
    self._ui._memberlist[index]._memberBg:SetShow(false)
  end
  self._siegeGradeCount.grade1 = 0
  self._siegeGradeCount.grade2 = 0
  self._siegeGradeCount.grade3 = 0
  self._siegeGradeCount.grade4 = 0
  self._siegeGradeCount.grade5 = 0
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local contentSizeY = 0
  local memberCount = myGuildInfo:getMemberCount()
  for index = 0, memberCount - 1 do
    local dataIdx = self._memberlistData[index + 1].idx
    local myGuildMemberInfo = myGuildInfo:getMember(dataIdx)
    if nil == myGuildMemberInfo then
      _PA_ASSERT(false, "\235\169\164\235\178\132 \235\141\176\236\157\180\237\132\176\234\176\128 \236\151\134\236\157\132 \236\136\152 \236\158\136\235\130\152? \237\153\149\236\157\184 \235\176\148\235\158\141\235\139\136\235\139\164.")
      return
    end
    self:updateListMemeber(myGuildMemberInfo, index, dataIdx)
    contentSizeY = contentSizeY + self._ui._memberlist[index]._charName:GetSizeY()
  end
  self._ui.frame_content:SetSize(self._ui.frame_list:GetSizeX(), contentSizeY)
end
function PaGlobal_GuildMemberList_All:updateListMemeber(guildMember, index, dataIdx)
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  local guildMemberControl = self._ui._memberlist[index]
  if nil == guildMemberControl then
    return
  end
  guildMemberControl._memberBg:SetShow(true)
  local gradeType = guildMember:getGrade()
  local isVacation = guildMember:isVacation()
  self:setGradeInfo(guildMemberControl._grade, index, gradeType, isVacation)
  guildMemberControl._level:SetText(guildMember:getLevel())
  local classTypeName = self:getClassText(guildMember:getClassType())
  if nil ~= classTypeName then
    guildMemberControl._class:SetText(classTypeName)
  end
  local maxWp = guildMember:getMaxWp()
  if 0 == maxWp or true == guildMember:isGhostMode() then
    maxWp = "-"
  end
  local explorationPoint = guildMember:getExplorationPoint()
  guildMemberControl._contributedTendency:SetText(maxWp .. "/" .. explorationPoint)
  self:setVoiceButton(index, guildMember, guildMemberControl)
  local isOnline = true == guildMember:isOnline() and false == guildMember:isGhostMode()
  self:setOnline(isOnline, guildMember, guildMemberControl, index, dataIdx)
  guildMemberControl._charName:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMemberList_All_MenuButtonToggle(" .. index .. ")")
  self:setContractButton(index, guildMember, guildMemberControl._contractBtn)
  self:setSiegeParticipant(index, guildMember, guildMemberControl)
  guildMemberControl._guard:SetShow(guildMember:isProtectable())
  if true == PaGlobalFunc_GuildMain_All_CheckIsMecernary() then
    guildMemberControl._contractBtn:SetMonoTone(true)
    guildMemberControl._contractBtn:addInputEvent("Mouse_On", "")
    guildMemberControl._contractBtn:addInputEvent("Mouse_Out", "")
    guildMemberControl._contractBtn:addInputEvent("Mouse_LUp", "")
    guildMemberControl._warGrade:addInputEvent("Mouse_LUp", "")
    guildMemberControl._warState:addInputEvent("Mouse_LUp", "")
  end
  local userNo = guildMember:getUserNo()
  local myUserNo = getSelfPlayer():get():getUserNo()
  local isSelf = guildMember:isSelf()
  if true == isSelf or userNo == myUserNo then
    self._myGuildIndex = index
    local isTakableSiegeReward = guildMember:isTakableSiegeReward()
    self._ui.btn_warReward:SetMonoTone(not isTakableSiegeReward)
    self._ui.btn_warReward:SetEnable(isTakableSiegeReward)
  end
  if true == self._isConsole then
    guildMemberControl._memberBg:registerPadEvent(__eConsoleUIPadEvent_LT, "PaGlobal_GuildWarfareDesc_Open()")
    guildMemberControl._memberBg:addInputEvent("Mouse_LUp", "HandlePadEvent_GuildMemberlist_All_Click(" .. index .. ")")
    local eMemberStateColor = 0
    if true == isSelf then
      eMemberStateColor = 0
    elseif true == isOnline then
      eMemberStateColor = 1
    else
      eMemberStateColor = 2
    end
    guildMemberControl._memberBg:addInputEvent("Mouse_On", "HandlePadEvent_GuildMemberlist_All_FontColorChange(" .. index .. "," .. eMemberStateColor .. ", " .. dataIdx .. ",true)")
    guildMemberControl._memberBg:addInputEvent("Mouse_Out", "HandlePadEvent_GuildMemberlist_All_FontColorChange(" .. index .. "," .. eMemberStateColor .. "," .. dataIdx .. ",false)")
  end
  if true == ToClient_isTotalGameClient() then
    self:setCrossPlayIcon(guildMemberControl._platformIcon, guildMember:getPlatformType())
  end
end
function PaGlobal_GuildMemberList_All:setCrossPlayIcon(targetControl, platformType)
  targetControl:SetShow(false)
  if nil == platformType then
    return
  end
  if true == _ContentsGroup_ConsoleIntegration then
    targetControl:SetShow(true)
    local selfPlayerPlatform = ToClient_getGamePlatformType()
    if selfPlayerPlatform == platformType then
      if __eGAME_PLATFORM_TYPE_PS == selfPlayerPlatform then
        targetControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_ps.dds")
      elseif __eGAME_PLATFORM_TYPE_XB == selfPlayerPlatform then
        targetControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_xb.dds")
      end
    else
      targetControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_other.dds")
    end
  end
end
function PaGlobal_GuildMemberList_All:updateVoiceDataByUserNo(userNo)
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local memberCount = myGuildListInfo:getMemberCount()
  local uiIndex
  for index = 0, memberCount - 1 do
    if userNo == PaGlobal_GuildMemberList_All._memberlistData[index + 1].userNo then
      uiIndex = index
    end
  end
  if nil == uiIndex then
    return
  end
  local myGuildMemberInfo = myGuildListInfo:getMemberByUserNo(userNo)
  if nil == myGuildMemberInfo then
    return
  end
  if myGuildMemberInfo:isVoiceChatSpeak() then
    if myGuildMemberInfo:isVoiceSpeaking() then
      self._ui._memberlist[uiIndex]._voiceTalk:SetMonoTone(false, true)
    else
      self._ui._memberlist[uiIndex]._voiceTalk:SetMonoTone(true, true)
    end
  else
    self:checkVoiceChatMicTexture(uiIndex, false)
  end
end
function PaGlobal_GuildMemberList_All:checkVoiceChatMicTexture(idx, onOff)
  if nil == Panel_Guild_List then
    return
  end
  local sayControl = self._ui._memberlist[idx]._voiceTalk
  if onOff then
    sayControl:SetMonoTone(false, true)
  else
    sayControl:SetMonoTone(true, true)
  end
end
