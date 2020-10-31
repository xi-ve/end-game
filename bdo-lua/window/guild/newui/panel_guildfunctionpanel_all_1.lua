function PaGlobal_GuildFunctionPanel_All:initialize()
  if nil == Panel_GuildInfo_All or nil == Panel_GuildFunctionPanel_All or false == _ContentsGroup_UsePadSnapping then
    return
  end
  self._ui.stc_TitleBg = UI.getChildControl(Panel_GuildFunctionPanel_All, "Static_TitleArea")
  self._ui.stc_MainBg = UI.getChildControl(Panel_GuildFunctionPanel_All, "Static_MainArea")
  self._ui.btn_FucntionTemp = UI.getChildControl(self._ui.stc_MainBg, "Button_FunctionButton_Temp")
  self._ui.stc_ConsoleKeyGuide = UI.getChildControl(Panel_GuildFunctionPanel_All, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_ConsoleKeyGuide, "StaticText_A_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_ConsoleKeyGuide, "StaticText_B_ConsoleUI")
  self._originPanelSize = Panel_GuildFunctionPanel_All:GetSizeY()
  self._ui.btn_FucntionTemp:SetShow(false)
  self._ui.stc_ConsoleKeyGuide:SetShow(_ContentsGroup_UsePadSnapping)
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobalFunc_ConsoleKeyGuide_SetAlign({
      self._ui.stc_KeyGuide_A,
      self._ui.stc_KeyGuide_B
    }, self._ui.stc_ConsoleKeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
  PaGlobal_GuildFunctionPanel_All:registerEvent()
  PaGlobal_GuildFunctionPanel_All:validate()
  PaGlobal_GuildFunctionPanel_All:createMenuBtn()
end
function PaGlobal_GuildFunctionPanel_All:validate()
  self._ui.stc_MainBg:isValidate()
  self._ui.btn_FucntionTemp:isValidate()
  self._ui.stc_ConsoleKeyGuide:isValidate()
  self._ui.stc_KeyGuide_A:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
end
function PaGlobal_GuildFunctionPanel_All:registerEvent()
end
function PaGlobal_GuildFunctionPanel_All:createMenuBtn()
  local startPosY = self._ui.btn_FucntionTemp:GetPosY()
  for idx = 0, self._menuCount - 1 do
    local btn = UI.cloneControl(self._ui.btn_FucntionTemp, self._ui.stc_MainBg, "Static_FuncBtn_" .. idx)
    btn:SetPosY(startPosY + (self._ui.btn_FucntionTemp:GetSizeY() + 10) * idx)
    btn:SetShow(true)
    self._funcBtnTable[idx] = btn
  end
end
function PaGlobal_GuildFunctionPanel_All:dataClear()
  if nil ~= self._funcBtnTable then
    for idx = 0, self._menuCount - 1 do
      self._funcBtnTable[idx]:SetText("")
      self._funcBtnTable[idx]:SetShow(false)
      self._funcBtnTable[idx]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
    end
  end
  self._enabledBtnCount = 0
end
function PaGlobal_GuildFunctionPanel_All:prepareOpen()
  PaGlobal_GuildFunctionPanel_All:dataClear()
  if nil == self._openType then
    return
  end
  if self._eOpenType.INFO == self._openType then
    PaGlobal_GuildFunctionPanel_All:SetGuildInfoBtn()
  elseif self._eOpenType.LIST == self._openType then
    PaGlobal_GuildFunctionPanel_All:SetGuildMemberBtn()
  elseif self._eOpenType.ALLYINFO == self._openType then
    PaGlobal_GuildFunctionPanel_All:SetAllyInfoBtn()
  end
  local titleSizeY = self._ui.stc_TitleBg:GetSizeY()
  local btnSize = (self._enabledBtnCount + 1) * (self._ui.btn_FucntionTemp:GetSizeY() + 10)
  local panelY = math.max(self._originPanelSize, btnSize)
  Panel_GuildFunctionPanel_All:SetSize(Panel_GuildFunctionPanel_All:GetSizeX(), panelY)
  self._ui.stc_MainBg:SetSize(self._ui.stc_MainBg:GetSizeX(), panelY - titleSizeY)
  self._ui.stc_ConsoleKeyGuide:ComputePos()
  Panel_GuildFunctionPanel_All:ComputePos()
  PaGlobal_GuildFunctionPanel_All:open()
end
function PaGlobal_GuildFunctionPanel_All:open()
  Panel_GuildFunctionPanel_All:SetShow(true)
end
function PaGlobal_GuildFunctionPanel_All:SetGuildInfoBtn()
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  local memberCount = myGuildListInfo:getMemberCount()
  local isTakableSiegeReward = false
  local delegable = toInt64(0, -1) == myGuildListInfo:getGuildMasterUserNo()
  for ii = 1, memberCount do
    local memberInfo = myGuildListInfo:getMember(ii - 1)
    if true == memberInfo:isSelf() then
      isTakableSiegeReward = memberInfo:isTakableSiegeReward()
      self._ui._isSiegeParticipant = memberInfo:isSiegeParticipant()
      break
    end
  end
  if true == isGuildMaster then
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.guildNotice)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.guildIntro)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.declareWar)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.guildMark)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.disperseGuild)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.joinMemberCount)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.protectionIncrease)
  elseif true == isGuildSubMaster then
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.guildNotice)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.guildIntro)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.declareWar)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.guildMark)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.leaveGuild)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.protectionIncrease)
    if true == delegable then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.mandateMaster)
    elseif ToClient_IsAbleChangeMaster() then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.mandateMaster)
    end
  else
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.leaveGuild)
    if true == delegable then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.mandateMaster)
    end
  end
  if true == PaGlobalFunc_GuildInfo_All_CheckAdminArsha() then
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.arshaAdminGet)
  end
  if false == PaGlobalFunc_GuildMain_All_CheckIsMecernary() then
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.guildWareHouse)
  end
  if true == isTakableSiegeReward then
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.joinReward)
  end
  local accumulateTax_s64 = myGuildListInfo:getAccumulateTax()
  local accumulateCost_s64 = myGuildListInfo:getAccumulateGuildHouseCost()
  local businessFunds_s64 = myGuildListInfo:getGuildBusinessFunds_s64()
  if accumulateTax_s64 > toInt64(0, 0) or accumulateCost_s64 > toInt64(0, 0) and (isGuildMaster or isGuildSubMaster) then
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.payGuildTax)
  end
end
function PaGlobal_GuildFunctionPanel_All:SetGuildMemberBtn()
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  local selectMemberIdx = PaGlobalFunc_GuildMemberList_All_GetSelectMemeberIdx()
  local guildMember = myGuildListInfo:getMember(selectMemberIdx)
  local memberGrade = guildMember:getGrade()
  local isOnline = true == guildMember:isOnline() and false == guildMember:isGhostMode()
  if true == guildMember:isSelf() then
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.showInfo)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.participation)
    if true == guildMember:isCollectableBenefit() and false == guildMember:isFreeAgent() and toInt64(0, 0) < guildMember:getContractedBenefit() then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.recvPay)
    end
    if true == isGuildMaster and 0 == memberGrade then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.incentive)
    end
    local isTakableSiegeReward = guildMember:isTakableSiegeReward()
    if true == isTakableSiegeReward and false == PaGlobalFunc_GuildMain_All_CheckIsMecernary() then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.joinReward)
    end
  elseif true == isGuildMaster then
    if __eGuildMemberGradeSubMaster == memberGrade then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.showInfo)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.deportation)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.appointSupply)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.cancelCommander)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.changeMaster)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.inviteParty)
      if true == _ContentsGroup_LargeParty then
        PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.inviteLargeParty)
      end
    elseif __eGuildMemberGradeNormal == memberGrade then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.showInfo)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.deportation)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.appointCommander)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.appointSupply)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.inviteParty)
      if true == _ContentsGroup_LargeParty then
        PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.inviteLargeParty)
      end
      if guildMember:isProtectable() then
        PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.cancelProtection)
      else
        PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.protection)
      end
    elseif __eGuildMemberGradeSupplyOfficer == memberGrade then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.showInfo)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.deportation)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.appointCommander)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.cancelCommander)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.inviteParty)
      if true == _ContentsGroup_LargeParty then
        PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.inviteLargeParty)
      end
    elseif __eGuildMemberGradeJunior == memberGrade then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.showInfo)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.deportation)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.inviteParty)
      if true == _ContentsGroup_LargeParty then
        PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.inviteLargeParty)
      end
      if guildMember:isProtectable() then
        PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.cancelProtection)
      else
        PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.protection)
      end
    end
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.funding)
    if true == isOnline and _ContentsGroup_isXBOXUI then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.voiceOption)
    end
  else
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.showInfo)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.inviteParty)
    if true == _ContentsGroup_LargeParty then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.inviteLargeParty)
    end
    if true == isOnline and _ContentsGroup_isXBOXUI then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.voiceOption)
    end
  end
  local accumulateTax_s64 = myGuildListInfo:getAccumulateTax()
  local accumulateCost_s64 = myGuildListInfo:getAccumulateGuildHouseCost()
  local businessFunds_s64 = myGuildListInfo:getGuildBusinessFunds_s64()
  if accumulateTax_s64 > toInt64(0, 0) or accumulateCost_s64 > toInt64(0, 0) then
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.payGuildTaxAllMember)
  end
  PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.showContract)
end
function PaGlobal_GuildFunctionPanel_All:SetAllyInfoBtn()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isChairman = selfPlayer:get():isGuildAllianceChair()
  local isGuildMaster = selfPlayer:get():isGuildMaster()
  if not isChairman and not isGuildMaster then
    return
  end
  if true == isChairman then
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.allyNotice)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.allyMarkChange)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.allydisperse)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.allyNoticeReset)
  else
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.allydisperse)
  end
end
function PaGlobal_GuildFunctionPanel_All:SetButton(btnType)
  if nil == self._funcBtnTable then
    return
  end
  self._funcBtnTable[self._enabledBtnCount]:SetText(self._btnString[btnType])
  self._funcBtnTable[self._enabledBtnCount]:SetShow(true)
  if self._eOpenType.INFO == PaGlobal_GuildFunctionPanel_All._openType then
    self._funcBtnTable[self._enabledBtnCount]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventPadPress_GuildFunctionPanel_All_PressGuildInfoFunc(" .. btnType .. ")")
  elseif self._eOpenType.LIST == PaGlobal_GuildFunctionPanel_All._openType then
    self._funcBtnTable[self._enabledBtnCount]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventPadPress_GuildFunctionPanel_All_PressMemberInfoFunc(" .. btnType .. ")")
  elseif self._eOpenType.ALLYINFO == PaGlobal_GuildFunctionPanel_All._openType then
    self._funcBtnTable[self._enabledBtnCount]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventPadPress_GuildFunctionPanel_All_PressAllyInfoFunc(" .. btnType .. ")")
  end
  self._enabledBtnCount = self._enabledBtnCount + 1
end
function PaGlobal_GuildFunctionPanel_All:prepareClose()
  Panel_GuildFunctionPanel_All:close()
end
function Panel_GuildFunctionPanel_All:close()
  Panel_GuildFunctionPanel_All:SetShow(false)
end
