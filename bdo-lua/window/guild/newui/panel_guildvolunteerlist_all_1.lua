function PaGlobal_GuildVolunteerList_All:initialize()
  if true == PaGlobal_GuildVolunteerList_All._initialize then
    return
  end
  PaGlobal_GuildVolunteerList_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_GuildVolunteerList_All:ControlAll_Init()
  PaGlobal_GuildVolunteerList_All:ControlPc_Init()
  PaGlobal_GuildVolunteerList_All:ControlConsole_Init()
  PaGlobal_GuildVolunteerList_All:ControlSetShow()
  PaGlobal_GuildVolunteerList_All:CreateControl()
  PaGlobal_GuildVolunteerList_All:registEventHandler()
  PaGlobal_GuildVolunteerList_All:validate()
  PaGlobal_GuildVolunteerList_All._initialize = true
end
function PaGlobal_GuildVolunteerList_All:ControlAll_Init()
  if nil == Panel_GuildVolunteerList_All then
    return
  end
  self._ui.stc_listTitleBg = UI.getChildControl(Panel_GuildVolunteerList_All, "Static_ListTitle")
  self._ui._title.txt_grade = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_Grade")
  self._ui._title.txt_level = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_Level")
  self._ui._title.txt_class = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_Class")
  self._ui._title.txt_name = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_CharName")
  self._ui._title.txt_activity = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_Activity")
  self._ui._title.txt_contribute = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_ContributedTendency")
  self._ui._title.txt_voice = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_Voice")
  self._ui._title.txt_warGrade = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_WarGrade")
  self._ui._title.txt_contract = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_M_Contract")
  self._ui.stc_framelistBg = UI.getChildControl(Panel_GuildVolunteerList_All, "Static_ListArea")
  self._ui.frame_list = UI.getChildControl(self._ui.stc_framelistBg, "Frame_List")
  self._ui.frame_content = UI.getChildControl(self._ui.frame_list, "Frame_1_Content")
  self._ui.frame_vScroll = UI.getChildControl(self._ui.frame_list, "Frame_1_VerticalScroll")
  self._ui.frame_vScrollCtrl = UI.getChildControl(self._ui.frame_vScroll, "Frame_1_VerticalScroll_CtrlButton")
  self._ui.stc_listContent = UI.getChildControl(self._ui.frame_content, "Static_List_Temp")
  self._ui.stc_bottomBg = UI.getChildControl(Panel_GuildVolunteerList_All, "Static_BottomArea")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_bottomBg, "StaticText_Desc")
  self._ui.btn_hire = UI.getChildControl(self._ui.stc_bottomBg, "Button_Hire")
  self._ui._titleList[0] = self._ui._title.txt_grade
  self._ui._titleList[1] = self._ui._title.txt_level
  self._ui._titleList[2] = self._ui._title.txt_class
  self._ui._titleList[3] = self._ui._title.txt_name
  self._ui._titleList[4] = self._ui._title.txt_activity
  self._ui._titleList[5] = self._ui._title.txt_contract
  self._ui._titleList[6] = self._ui._title.txt_contribute
  self._ui._titleList[7] = self._ui._title.txt_warGrade
  self._ui._titleList[8] = self._ui._title.txt_voice
end
function PaGlobal_GuildVolunteerList_All:ControlPc_Init()
  if nil == Panel_GuildVolunteerList_All then
    return
  end
  self._ui_pc.stc_funcBg = UI.getChildControl(Panel_GuildVolunteerList_All, "Static_FunctionBG")
  self._ui_pc.btn_activityCost = UI.getChildControl(self._ui_pc.stc_funcBg, "Button_AcivityCost")
  self._ui_pc.stc_setVolumBg = UI.getChildControl(Panel_GuildVolunteerList_All, "Static_Listening_VolumeBG")
  self._ui_pc.slider_listenVol = UI.getChildControl(self._ui_pc.stc_setVolumBg, "Slider_ListeningVolume")
  self._ui_pc.slider_listenVolBtn = UI.getChildControl(self._ui_pc.slider_listenVol, "Slider_MicVol_Button")
  self._ui_pc.chk_listenIcon = UI.getChildControl(self._ui_pc.stc_setVolumBg, "Checkbox_SpeakerIcon")
  self._ui_pc.txt_volumVal = UI.getChildControl(self._ui_pc.stc_setVolumBg, "StaticText_SpeakerVolumeValue")
  self._ui_pc.btn_setVolumClose = UI.getChildControl(self._ui_pc.stc_setVolumBg, "Button_VolumeSetClose")
end
function PaGlobal_GuildVolunteerList_All:ControlConsole_Init()
  if nil == Panel_GuildVolunteerList_All then
    return
  end
end
function PaGlobal_GuildVolunteerList_All:CreateControl()
  if nil == Panel_GuildVolunteerList_All then
    return
  end
  local listStartY = self._ui.frame_content:GetPosY()
  local function createListInfo(pIndex)
    local tempMember = {}
    tempMember._memberBg = UI.createAndCopyBasePropertyControl(self._ui.frame_content, "Static_List_Temp", self._ui.frame_content, "volunteerlist_MemberBg_" .. pIndex)
    tempMember._grade = UI.createAndCopyBasePropertyControl(self._ui.stc_listContent, "StaticText_C_Grade", tempMember._memberBg, "volunteerlist_Grade_" .. pIndex)
    tempMember._level = UI.createAndCopyBasePropertyControl(self._ui.stc_listContent, "StaticText_C_Level", tempMember._memberBg, "volunteerlist_Level_" .. pIndex)
    tempMember._class = UI.createAndCopyBasePropertyControl(self._ui.stc_listContent, "StaticText_C_Class", tempMember._memberBg, "volunteerlist_Class_" .. pIndex)
    tempMember._charName = UI.createAndCopyBasePropertyControl(self._ui.stc_listContent, "StaticText_C_CharName", tempMember._memberBg, "volunteerlist_CharName_" .. pIndex)
    tempMember._activity = UI.createAndCopyBasePropertyControl(self._ui.stc_listContent, "StaticText_C_Activity", tempMember._memberBg, "volunteerlist_Activity_" .. pIndex)
    tempMember._contributedTendency = UI.createAndCopyBasePropertyControl(self._ui.stc_listContent, "StaticText_C_ContributedTendency", tempMember._memberBg, "volunteerlist_Contribute_" .. pIndex)
    tempMember._contractBtn = UI.createAndCopyBasePropertyControl(self._ui.stc_listContent, "Button_C_Contract", tempMember._memberBg, "volunteerlist_Contract_" .. pIndex)
    tempMember._guard = UI.createAndCopyBasePropertyControl(self._ui.stc_listContent, "Static_C_GuardHim", tempMember._memberBg, "volunteerlist_GuardHim_" .. pIndex)
    tempMember._voiceListen = UI.createAndCopyBasePropertyControl(self._ui.stc_listContent, "StaticText_C_Voice_Listening", tempMember._memberBg, "volunteerlist_Voice_Listening_" .. pIndex)
    tempMember._voiceTalk = UI.createAndCopyBasePropertyControl(self._ui.stc_listContent, "StaticText_C_Voice_Saying", tempMember._memberBg, "volunteerlist_Voice_Saying_" .. pIndex)
    tempMember._warState = UI.createAndCopyBasePropertyControl(self._ui.stc_listContent, "Button_WarState", tempMember._memberBg, "volunteerlist_WarState_" .. pIndex)
    tempMember._warGrade = UI.createAndCopyBasePropertyControl(self._ui.stc_listContent, "Button_WarGrade", tempMember._memberBg, "volunteerlist_WarGrade_" .. pIndex)
    for _, var in pairs(tempMember) do
      var:ComputePos()
      var:addInputEvent("Mouse_UpScroll", "HandleEventScroll_GuildVolunteerList_All_Scroll(true)")
      var:addInputEvent("Mouse_DownScroll", "HandleEventScroll_GuildVolunteerList_All_Scroll(false)")
    end
    tempMember._grade:SetIgnore(false)
    tempMember._level:SetIgnore(false)
    tempMember._class:SetIgnore(false)
    tempMember._charName:SetIgnore(false)
    tempMember._activity:SetIgnore(false)
    tempMember._contributedTendency:SetIgnore(false)
    tempMember._voiceTalk:SetAutoDisableTime(2)
    tempMember._voiceTalk:DoAutoDisableTime()
    tempMember._voiceListen:SetAutoDisableTime(2)
    tempMember._voiceListen:DoAutoDisableTime()
    tempMember._voiceTalk:SetIgnore(false)
    tempMember._voiceListen:SetIgnore(false)
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
    if false == isGameTypeKorea() then
      tempMember._contributedTendency:SetShow(false)
    end
    tempMember._memberBg:SetShow(false)
    tempMember._memberBg:SetPosY(listStartY + tempMember._memberBg:GetSizeY() * pIndex)
    return tempMember
  end
  for index = 0, self._listMaxCount do
    self._ui._volunteerList[index] = createListInfo(index)
  end
end
function PaGlobal_GuildVolunteerList_All:FrameUpdate()
  self._ui.frame_list:UpdateContentScroll()
  self._ui.frame_list:UpdateContentPos()
  self._ui.frame_vScroll:SetInterval(self._ui.frame_content:GetSizeY() / 100 * 1.1)
end
function PaGlobal_GuildVolunteerList_All:ControlSetShow()
  if nil == Panel_GuildVolunteerList_All then
    return
  end
  if false == self._contentOpen.voice then
    self._ui._title.txt_voice:SetShow(false)
  end
  if false == self._contentOpen.warGrade then
    self._ui._title.txt_warGrade:SetShow(false)
  end
  if false == isGameTypeKorea() then
    self._ui._title.txt_contribute:SetShow(false)
  end
  self._ui.btn_hire:SetShow()
  self._ui_pc.stc_funcBg:SetShow(false)
  self._ui_pc.stc_setVolumBg:SetShow(false)
end
function PaGlobal_GuildVolunteerList_All:prepareOpen()
  if nil == Panel_GuildVolunteerList_All then
    return
  end
  self._ui_pc.stc_funcBg:SetShow(false)
  self._ui_pc.stc_setVolumBg:SetShow(false)
  self._ui.frame_vScroll:SetControlPos(0)
  if nil ~= getSelfPlayer() then
    self._isGuildMaster = getSelfPlayer():get():isGuildMaster()
    self._isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
    if true == self._isGuildMaster or true == self._isGuildSubMaster then
      self._ui.btn_hire:SetShow(false == self._isConsole)
    else
      self._ui.btn_hire:SetShow(false)
    end
  else
    self._ui.btn_hire:SetShow(false)
  end
  PaGlobal_GuildVolunteerList_All:open()
  PaGlobal_GuildVolunteerList_All:update()
  PaGlobal_GuildVolunteerList_All:resize()
end
function PaGlobal_GuildVolunteerList_All:open()
  if nil == Panel_GuildVolunteerList_All then
    return
  end
  Panel_GuildVolunteerList_All:SetShow(true)
end
function PaGlobal_GuildVolunteerList_All:prepareClose()
  if nil == Panel_GuildVolunteerList_All then
    return
  end
  PaGlobal_GuildVolunteerList_All:close()
end
function PaGlobal_GuildVolunteerList_All:close()
  if nil == Panel_GuildVolunteerList_All then
    return
  end
  Panel_GuildVolunteerList_All:SetShow(false)
end
function PaGlobal_GuildVolunteerList_All:update()
  if nil == Panel_GuildVolunteerList_All then
    return
  end
  self:updateListInfo()
  self:FrameUpdate()
end
function PaGlobal_GuildVolunteerList_All:registEventHandler()
  if nil == Panel_GuildVolunteerList_All then
    return
  end
  registerEvent("FromClient_ResponseGuildUpdate", "FromClient_GuildVolunteerList_All_ResponseGuildUpdate")
  registerEvent("FromClient_ResponseParticipateSiege", "FromClient_GuildVolunteerList_All_ResponseGuildUpdate")
  registerEvent("FromClient_ResponseChangeGuildMemberGrade", "FromClient_GuildVolunteerList_All_ResponseGuildUpdate")
  UIScroll.InputEvent(self._ui.frame_vScroll, "HandleEventScroll_GuildVolunteerList_All_Scroll")
  self._ui.frame_content:addInputEvent("Mouse_UpScroll", "HandleEventScroll_GuildVolunteerList_All_Scroll(true)")
  self._ui.frame_content:addInputEvent("Mouse_DownScroll", "HandleEventScroll_GuildVolunteerList_All_Scroll(false)")
  for index = 0, self._SortType.COUNT - 1 do
    if true == self._isConsole then
      self._ui._titleList[index]:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventOnOut_GuildVolunteerList_All_TitleTooltip(true, " .. index .. ")")
    else
      self._ui._titleList[index]:addInputEvent("Mouse_On", "HandleEventOnOut_GuildVolunteerList_All_TitleTooltip(true, " .. index .. ")")
    end
    self._ui._titleList[index]:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildVolunteerList_All_TitleTooltip(false, " .. index .. ")")
  end
  if true == self._isConsole then
    PaGlobal_GuildMain_All._ui.stc_Mercenary_Bg:registerPadEvent(__eConsoleUIPadEvent_A, "HandleClicked_GuildVolunteerList_All_Recruite()")
  else
    self._ui.btn_hire:addInputEvent("Mouse_LUp", "HandleClicked_GuildVolunteerList_All_Recruite()")
  end
  self._ui_pc.btn_activityCost:addInputEvent("Mouse_LUp", "HandleClicked_GuildVolunteerList_All_ActivityButton()")
end
function PaGlobal_GuildVolunteerList_All:validate()
  if nil == Panel_GuildVolunteerList_All then
    return
  end
end
function PaGlobal_GuildVolunteerList_All:resize()
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MARCENARY) then
    return
  end
  self._ui.stc_listTitleBg:ComputePos()
  self._ui.stc_framelistBg:ComputePos()
end
function PaGlobal_GuildVolunteerList_All:getClassText(classType)
  if nil == classType then
    return
  end
  return CppEnums.ClassType2String[classType]
end
function PaGlobal_GuildVolunteerList_All:updateListInfo()
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MARCENARY) then
    return
  end
  for index = 0, self._listMaxCount do
    self._ui._volunteerList[index]._memberBg:SetShow(false)
  end
  local curGuildInfoWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == curGuildInfoWrapper then
    return
  end
  local volunteerCount = curGuildInfoWrapper:getVolunteerMemberCount()
  if 0 == volunteerCount then
    return
  end
  local contentSizeY = 0
  for index = 0, volunteerCount - 1 do
    local volunteerMemberInfo = curGuildInfoWrapper:getVolunteerMember(index)
    if nil == volunteerMemberInfo then
      _PA_ASSERT(false, "\235\169\164\235\178\132 \235\141\176\236\157\180\237\132\176\234\176\128 \236\151\134\236\157\132 \236\136\152 \236\158\136\235\130\152? \237\153\149\236\157\184 \235\176\148\235\158\141\235\139\136\235\139\164.")
      return
    end
    self:updateListMemeber(volunteerMemberInfo, index)
    contentSizeY = contentSizeY + self._ui._volunteerList[index]._charName:GetSizeY()
  end
  self._ui.frame_content:SetSize(self._ui.frame_list:GetSizeX(), contentSizeY)
end
function PaGlobal_GuildVolunteerList_All:updateListMemeber(member, index)
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MARCENARY) then
    return
  end
  local guildMemberControl = self._ui._volunteerList[index]
  if nil == guildMemberControl then
    return
  end
  guildMemberControl._memberBg:SetShow(true)
  guildMemberControl._grade:SetText("")
  guildMemberControl._grade:SetSize(43, 26)
  guildMemberControl._grade:ChangeTextureInfoName("Renewal/PcRemaster/Remaster_ETC_Guild.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(guildMemberControl._grade, 227, 17, 270, 43)
  guildMemberControl._grade:getBaseTexture():setUV(x1, y1, x2, y2)
  guildMemberControl._grade:setRenderTexture(guildMemberControl._grade:getBaseTexture())
  guildMemberControl._grade:SetIgnore(false)
  guildMemberControl._grade:addInputEvent("Mouse_On", "HandleOnOut_GuildVolunteerList_All_GradeTooltip(true, " .. index .. ")")
  guildMemberControl._grade:addInputEvent("Mouse_Out", "HandleOnOut_GuildVolunteerList_All_GradeTooltip(false, " .. index .. ")")
  local volunteerLevel = member:getLevel()
  guildMemberControl._level:SetText(volunteerLevel)
  local volunteerClass = self:getClassText(member:getClassType())
  guildMemberControl._class:SetText(volunteerClass)
  local volunteerName = member:getName() .. " (" .. member:getCharacterName() .. ")"
  guildMemberControl._charName:SetText(volunteerName)
  if false == member:isSelf() and nil ~= getSelfPlayer() then
    if true == self._isGuildMaster or true == self._isGuildSubMaster then
      guildMemberControl._charName:SetIgnore(false)
      guildMemberControl._charName:addInputEvent("Mouse_LUp", "HandleClicked_GuildVolunteerList_All_Menu(" .. index .. ")")
    end
  else
    guildMemberControl._charName:SetIgnore(true)
  end
  guildMemberControl._activity:SetText("-")
  local maxWp = member:getMaxWp()
  if 0 == maxWp or true == member:isGhostMode() then
    maxWp = "-"
  end
  local explorationPoint = member:getExplorationPoint()
  guildMemberControl._contributedTendency:SetText(maxWp .. "/" .. explorationPoint)
  local participantText = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGE_PARTICIPANT")
  local nonparticipantText = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGE_NONPARTICIPANT")
  local padding = 10
  if true == member:isSelf() or true == self._isGuildMaster or true == self._isGuildSubMaster then
    guildMemberControl._warGrade:SetShow(self._contentOpen.warGrade)
    guildMemberControl._warState:SetShow(false)
    if member:isSiegeParticipant() then
      guildMemberControl._warGrade:SetText(participantText)
      guildMemberControl._warGrade:SetSize(guildMemberControl._warGrade:GetTextSizeX() + padding, guildMemberControl._warGrade:GetSizeY())
      guildMemberControl._warGrade:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMemberList_All_RequestParticipateAtSiege( false )")
    else
      guildMemberControl._warGrade:SetText(nonparticipantText)
      guildMemberControl._warGrade:SetSize(guildMemberControl._warGrade:GetTextSizeX() + padding, guildMemberControl._warGrade:GetSizeY())
      guildMemberControl._warGrade:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMemberList_All_RequestParticipateAtSiege( true )")
    end
  else
    guildMemberControl._warGrade:SetShow(false)
    guildMemberControl._warState:SetShow(self._contentOpen.warGrade)
    guildMemberControl._warState:SetIgnore(true)
    if false == isRealServiceMode() then
      guildMemberControl._warState:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMemberList_All_RequestParticipateAtSiegeFromMaster( " .. tostring(member:getUserNo()) .. " )")
    end
    if member:isSiegeParticipant() then
      guildMemberControl._warState:SetText(participantText)
    else
      guildMemberControl._warState:SetText(nonparticipantText)
    end
  end
  local isOnline = true == member:isOnline() and false == member:isGhostMode()
  if false == isOnline then
    guildMemberControl._level:SetText("-")
    guildMemberControl._level:SetFontColor(Defines.Color.C_FF515151)
    guildMemberControl._class:SetText("-")
    guildMemberControl._class:SetFontColor(Defines.Color.C_FF515151)
    guildMemberControl._charName:SetText(member:getName() .. " ( - )")
    guildMemberControl._charName:SetFontColor(Defines.Color.C_FF515151)
    guildMemberControl._activity:SetFontColor(Defines.Color.C_FF515151)
    guildMemberControl._contributedTendency:SetFontColor(Defines.Color.C_FF515151)
  else
    guildMemberControl._level:SetFontColor(Defines.Color.C_FFC4BEBE)
    guildMemberControl._class:SetFontColor(Defines.Color.C_FFC4BEBE)
    if true == member:isSelf() then
      guildMemberControl._charName:SetFontColor(Defines.Color.C_FFEF9C7F)
    else
      guildMemberControl._charName:SetFontColor(Defines.Color.C_FFC4BEBE)
    end
    guildMemberControl._activity:SetFontColor(Defines.Color.C_FFC4BEBE)
    guildMemberControl._contributedTendency:SetFontColor(Defines.Color.C_FFC4BEBE)
  end
  if true == self._isGuildMaster or true == self._isGuildSubMaster or true == member:isSelf() then
    guildMemberControl._contractBtn:SetMonoTone(false)
    guildMemberControl._contractBtn:SetIgnore(false)
    if true == member:isSelf() then
      guildMemberControl._contractBtn:addInputEvent("Mouse_LUp", "HandleClicked_GuildVolunteerList_All_ContractButton( true, " .. index .. ")")
    else
      guildMemberControl._contractBtn:addInputEvent("Mouse_LUp", "HandleClicked_GuildVolunteerList_All_ContractButton( false, " .. index .. ")")
    end
  else
    guildMemberControl._contractBtn:SetMonoTone(true)
    guildMemberControl._contractBtn:addInputEvent("Mouse_LUp", "")
  end
  guildMemberControl._contractBtn:addInputEvent("Mouse_On", "HandleOnOut_GuildVolunteerList_All_ContractTooltipShow(true, " .. index .. ")")
  guildMemberControl._contractBtn:addInputEvent("Mouse_Out", "HandleOnOut_GuildVolunteerList_All_ContractTooltipShow(false, " .. index .. ")")
end
