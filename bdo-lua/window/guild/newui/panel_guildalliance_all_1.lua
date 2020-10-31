function PaGlobal_GuildAlliance_All:initialize()
  if true == PaGlobal_GuildAlliance_All._initialize or nil == Panel_GuildAlliance_All then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_Left = UI.getChildControl(Panel_GuildAlliance_All, "Static_LeftArea")
  self._ui.stc_MarkBg = UI.getChildControl(self._ui.stc_Left, "Static_MarkBG")
  self._ui.stc_Mark = UI.getChildControl(self._ui.stc_MarkBg, "Static_Mark")
  self._ui.txt_Name = UI.getChildControl(self._ui.stc_Left, "StaticText_AlianceName")
  self._ui.txt_Master = UI.getChildControl(self._ui.stc_Left, "StaticText_AlianceMaster")
  self._ui.txt_Member = UI.getChildControl(self._ui.stc_Left, "StaticText_AlianceMember")
  self._ui.btn_Mark = UI.getChildControl(self._ui.stc_Left, "Button_GuildMarkChange")
  self._ui.btn_Exit = UI.getChildControl(self._ui.stc_Left, "Button_AlianceExit")
  self._ui.list2_AlliList = UI.getChildControl(self._ui.stc_Left, "List2_GuildList")
  self._ui.stc_Right = UI.getChildControl(Panel_GuildAlliance_All, "Static_RightArea")
  self._ui.btn_SaveNotice = UI.getChildControl(self._ui.stc_Right, "Button_Notice")
  self._ui.btn_Reset = UI.getChildControl(self._ui.stc_Right, "Button_NoticeInitialize")
  self._ui.edit_Notice = UI.getChildControl(self._ui.stc_Right, "MultilineEdit_Introduce")
  self._ui.stc_DescBg = UI.getChildControl(Panel_GuildAlliance_All, "Static_BottomDescArea")
  self._ui.txt_Desc = UI.getChildControl(self._ui.stc_DescBg, "StaticText_Desc")
  self._ui.origin_DescBgY = self._ui.stc_DescBg:GetSizeY()
  self._ui.origin_DescTxtY = self._ui.txt_Desc:GetSizeY()
  self._originPanelY = Panel_GuildMain_All:GetSizeY()
  self._ui.btn_Mark:SetShow(not self._isConsole and not isGameTypeKR2())
  self._ui.btn_Exit:SetShow(not self._isConsole)
  self._ui.btn_SaveNotice:SetShow(not self._isConsole)
  self._ui.btn_Reset:SetShow(not self._isConsole)
  self._ui.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Desc:SetText(self._ui.txt_Desc:GetText())
  PaGlobal_GuildAlliance_All:validate()
  PaGlobal_GuildAlliance_All:registEventHandler()
  PaGlobal_GuildAlliance_All._initialize = true
end
function PaGlobal_GuildAlliance_All:registEventHandler()
  if nil == Panel_GuildAlliance_All then
    return
  end
  registerEvent("EventChangeGuildInfo", "FromClient_GuildAlliance_All_InfoChanged")
  registerEvent("FromClient_ResponseGuildNotice", "FromClient_GuildAlliance_All_NoticeChanged")
  registerEvent("FromClient_DestroyGuildAlliance", "FromClient_GuildAlliance_All_DisbandAlliance")
  self._ui.list2_AlliList:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_GuildAlliance_All_List2Update")
  self._ui.list2_AlliList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.edit_Notice:SetMaxInput(300)
  self._ui.edit_Notice:SetMaxEditLine(16)
  PaGlobal_GuildAlliance_All:registerInputEvent_PC()
  PaGlobal_GuildAlliance_All:registerInputEvent_Console()
end
function PaGlobal_GuildAlliance_All:registerInputEvent_PC()
  self._ui.btn_Exit:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildAlliance_All_DisbandAlliance()")
  self._ui.btn_Exit:addInputEvent("Mouse_On", "HandleEventOnOut_GuildAlliance_All_Tooltip(1)")
  self._ui.btn_Exit:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildAlliance_All_Tooltip()")
  self._ui.btn_Reset:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildAlliance_All_ResetNotice()")
  self._ui.btn_SaveNotice:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildAlliance_All_SaveNotice()")
  self._ui.btn_Mark:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildAlliance_All_MarkChange()")
  self._ui.btn_Mark:addInputEvent("Mouse_On", "HandleEventOnOut_GuildAlliance_All_Tooltip(0)")
  self._ui.btn_Mark:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildAlliance_All_Tooltip()")
  self._ui.edit_Notice:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildAlliance_All_SetEditText()")
  self._ui.edit_Notice:RegistReturnKeyEvent("Mouse_LUp", "HandleEventLUp_GuildAlliance_All_SaveNotice()")
end
function PaGlobal_GuildAlliance_All:registerInputEvent_Console()
  PaGlobal_GuildMain_All._ui.stc_Alliance_Bg:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_GuildFunctionPanel_All_OpenByAllyInfo()")
  PaGlobal_GuildAlliance_All._ui.edit_Notice:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_GuildAlliance_All_EndVirtualKeyboard")
  PaGlobal_GuildAlliance_All._ui.edit_Notice:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_GuildAlliance_All_SaveNotice()")
end
function PaGlobal_GuildAlliance_All:update()
  if nil == Panel_GuildAlliance_All then
    return
  end
  local myAllianceWrapper = ToClient_GetMyGuildAllianceWrapper()
  if nil == myAllianceWrapper then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  PaGlobal_GuildAlliance_All:buttonCheck()
  PaGlobal_GuildAlliance_All:AllianceInfoUpdate(myAllianceWrapper)
  PaGlobal_GuildAlliance_All:updateNotice(myAllianceWrapper)
  self._ui.txt_Desc:SetSize(self._ui.txt_Desc:GetSizeX(), self._ui.origin_DescBgY)
  self._ui.stc_DescBg:SetSize(self._ui.stc_DescBg:GetSizeX(), self._ui.origin_DescTxtY)
  PaGlobal_GuildAlliance_All:setDescSize()
end
function PaGlobal_GuildAlliance_All:buttonCheck()
  if true == self._isConsole then
    return
  end
  local selfPlayer = getSelfPlayer()
  local isChairman = selfPlayer:get():isGuildAllianceChair()
  local isGuildMaster = selfPlayer:get():isGuildMaster()
  self._ui.btn_Mark:SetShow(isChairman and not isGameTypeKR2())
  self._ui.btn_SaveNotice:SetShow(isChairman)
  self._ui.btn_Reset:SetShow(isChairman)
  self._ui.btn_Reset:SetIgnore(not isChairman)
  self._ui.btn_Exit:SetShow(isChairman or isGuildMaster)
  self._ui.edit_Notice:SetIgnore(not isChairman)
end
function PaGlobal_GuildAlliance_All:updateNotice(myAllianceWrapper)
  local allianceWrapper = myAllianceWrapper
  if nil == allianceWrapper then
    allianceWrapper = ToClient_GetMyGuildAllianceWrapper()
    if nil == allianceWrapper then
      return
    end
  end
  local notice = allianceWrapper:getNotice()
  self._ui.edit_Notice:SetEditText(notice)
end
function PaGlobal_GuildAlliance_All:AllianceInfoUpdate(myAllianceWrapper)
  local isSet = setGuildTextureByAllianceNo(myAllianceWrapper:guildAllianceNo_s64(), self._ui.stc_Mark)
  local x1, y1, x2, y2 = 0, 0, 1, 1
  if false == isSet then
    self._ui.stc_Mark:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_Mark, 183, 1, 188, 6)
  end
  self._ui.stc_Mark:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.stc_Mark:setRenderTexture(self._ui.stc_Mark:getBaseTexture())
  self._ui.txt_Master:SetText(myAllianceWrapper:getGuildAllianceChairName())
  self._ui.txt_Name:SetText(myAllianceWrapper:getRepresentativeName())
  local memberCount = tostring(myAllianceWrapper:getUserCount()) .. " / 100"
  self._ui.txt_Member:SetText(memberCount)
  local myGuildAllianceCache = ToClient_GetMyGuildAlliancChairGuild()
  local guildCount = myAllianceWrapper:getMemberCount()
  self._ui.list2_AlliList:getElementManager():clearKey()
  for index = 0, guildCount - 1 do
    self._ui.list2_AlliList:getElementManager():pushKey(toInt64(0, index))
  end
end
function PaGlobal_GuildAlliance_All:list2Update(content, key)
  local key32 = Int64toInt32(key)
  local txt_Name = UI.getChildControl(content, "StaticText_GuildName")
  local stc_ChairmanIcon = UI.getChildControl(txt_Name, "Static_Icon")
  local txt_MemberCount = UI.getChildControl(content, "StaticText_GuildMember")
  local txt_rate = UI.getChildControl(content, "StaticText_GuildRate")
  content:SetShow(true)
  stc_ChairmanIcon:SetShow(false)
  local allianceWrapper = ToClient_GetMyGuildAllianceWrapper()
  if nil == allianceWrapper then
    return
  end
  local chairName = allianceWrapper:getGuildAllianceChairName()
  local allianceNameInfo = allianceWrapper:getRepresentativeName()
  local allianceMemberCount = allianceWrapper:getMemberCount()
  local allianceMember = allianceWrapper:getMemberGuild(key32)
  local guildName = allianceMember:getName()
  local guildNo = allianceMember:getGuildNo_s64()
  local currentGuildMemberCount = allianceMember:getMemberCount()
  local guildLimitMemberCount = allianceWrapper:getLimitMemberCountOfMemberGuild(guildNo)
  local guildTaxConst = allianceWrapper:getTaxRateOfMemberGuild(guildNo)
  if chairName == guildName then
    stc_ChairmanIcon:SetShow(true)
  end
  txt_Name:SetText(guildName)
  txt_MemberCount:SetText(currentGuildMemberCount .. "/" .. guildLimitMemberCount)
  txt_rate:SetText(guildTaxConst / CppDefine.e1Percent .. "%")
end
function PaGlobal_GuildAlliance_All:setDescSize()
  local gap = 0
  if self._ui.txt_Desc:GetTextSizeY() >= self._ui.txt_Desc:GetSizeY() then
    gap = self._ui.txt_Desc:GetTextSizeY() - self._ui.origin_DescTxtY
    self._ui.txt_Desc:SetSize(self._ui.txt_Desc:GetSizeX(), self._ui.txt_Desc:GetTextSizeY())
    self._ui.stc_DescBg:SetSize(self._ui.stc_DescBg:GetSizeX(), self._ui.txt_Desc:GetSizeY() + 10)
  else
    self._ui.txt_Desc:SetSize(self._ui.txt_Desc:GetSizeX(), self._ui.origin_DescTxtY)
    self._ui.stc_DescBg:SetSize(self._ui.stc_DescBg:GetSizeX(), self._ui.origin_DescBgY)
  end
  PaGlobalFunc_GuildAlliance_All_ChangeBGSize(PaGlobal_GuildMain_All._eTABINDEX._ALLIANCE, gap)
  PaGlobal_GuildMain_All_ChangePanelSize(self._originPanelY + gap)
end
function PaGlobal_GuildAlliance_All:validate()
  if nil == Panel_GuildAlliance_All then
    return
  end
  self._ui.stc_Left:isValidate()
  self._ui.stc_MarkBg:isValidate()
  self._ui.stc_Mark:isValidate()
  self._ui.txt_Name:isValidate()
  self._ui.txt_Master:isValidate()
  self._ui.txt_Member:isValidate()
  self._ui.btn_Mark:isValidate()
  self._ui.btn_Exit:isValidate()
  self._ui.list2_AlliList:isValidate()
  self._ui.stc_Right:isValidate()
  self._ui.btn_SaveNotice:isValidate()
  self._ui.btn_Reset:isValidate()
  self._ui.stc_DescBg:isValidate()
  self._ui.txt_Desc:isValidate()
  self._ui.edit_Notice:isValidate()
end
