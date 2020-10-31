function PaGlobal_LocalWarInfo_All_Open()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  PaGlobal_LocalWarInfo_All:prepareOpen()
end
function PaGlobal_LocalWarInfo_All_Close()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  PaGlobal_LocalWarInfo_All:prepareClose()
end
function PaGlobal_LocalWarInfo_All_ShowAni()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  Panel_LocalWarInfo_All:SetAlpha(0)
  UIAni.AlphaAnimation(1, Panel_LocalWarInfo_All, 0, 0.3)
end
function PaGlobal_LocalWarInfo_All_HideAni()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  local hideAni = UIAni.AlphaAnimation(0, Panel_LocalWarInfo_All, 0, 0.2)
  hideAni:SetHideAtEnd(true)
end
function PaGlobal_LocalWarInfo_All_UpdateServerList(list_content, key)
  if nil == Panel_LocalWarInfo_All then
    return
  end
  local id = Int64toInt32(key)
  local curChannelData = getCurrentChannelServerData()
  if nil == curChannelData then
    return
  end
  local localWarStatusData = ToClient_GetLocalwarStatusData(id)
  if nil == localWarStatusData then
    return
  end
  local getServerNo = localWarStatusData:getServerNo()
  local getJoinMemberCount = localWarStatusData:getTotalJoinCount()
  local getCurrentState = localWarStatusData:getState()
  local getRemainTime = localWarStatusData:getRemainTime()
  local warTimeMinute = math.floor(Int64toInt32(getRemainTime / toInt64(0, 60)))
  local warTimeSecond = Int64toInt32(getRemainTime) % 60
  local channelName = getChannelName(curChannelData._worldNo, getServerNo)
  local isLimitLocalWar = localWarStatusData:isLimitedLocalWar()
  local txt_level = UI.getChildControl(list_content, "StaticText_Limit_Level")
  local txt_ap = UI.getChildControl(list_content, "StaticText_Limit_AP")
  local txt_dp = UI.getChildControl(list_content, "StaticText_Limit_DP")
  local txt_adSum = UI.getChildControl(list_content, "StaticText_Limit_ADSum")
  local txt_unLimit = UI.getChildControl(list_content, "StaticText_Limit_Unlimit")
  local txt_channel = UI.getChildControl(list_content, "StaticText_Channel")
  local txt_joinMemberCount = UI.getChildControl(list_content, "StaticText_JoinMemberCount")
  local txt_remainTime = UI.getChildControl(list_content, "StaticText_RemainTime")
  local btn_join = UI.getChildControl(list_content, "Button_Join")
  if isGameTypeKorea() or isGameTypeJapan() or isGameTypeRussia() or isGameTypeEnglish() then
    txt_level:SetShow(true)
    txt_level:SetPosX(45)
    txt_ap:SetPosX(85)
    txt_dp:SetPosX(125)
    txt_adSum:SetPosX(165)
    txt_unLimit:SetSize(140, txt_unLimit:GetSizeY())
  else
    txt_level:SetShow(false)
    txt_ap:SetPosX(45)
    txt_dp:SetPosX(85)
    txt_adSum:SetPosX(125)
    txt_unLimit:SetSize(110, txt_unLimit:GetSizeY())
  end
  if isLimitLocalWar then
    txt_unLimit:SetShow(false)
    txt_level:SetText(ToClient_GetLevelForLimitedLocalWar() - 1)
    txt_ap:SetText(ToClient_GetAttackForLimitedLocalWar() - 1)
    txt_dp:SetText(ToClient_GetDefenseForLimitedLocalWar() - 1)
    txt_adSum:SetText(ToClient_GetADSummaryForLimitedLocalWar() - 1)
  else
    txt_unLimit:SetShow(true)
    txt_level:SetText("")
    txt_ap:SetText("")
    txt_dp:SetText("")
    txt_adSum:SetText("")
  end
  txt_unLimit:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LOCALWARINFO_UNLIMIT"))
  if 0 == getCurrentState then
    isCurrentState = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_JOIN_WAITING")
    isWarTime = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_WAITING")
    btn_join:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_JOIN"))
    btn_join:SetIgnore(false)
  elseif 1 == getCurrentState then
    isCurrentState = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_ING")
    isWarTime = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_TIME", "warTimeMinute", warTimeMinute, "warTimeSecond", Int64toInt32(warTimeSecond))
    if 10 <= warTimeMinute then
      btn_join:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_JOIN"))
      btn_join:SetIgnore(false)
    else
      btn_join:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_CANTJOIN"))
      btn_join:SetIgnore(true)
    end
  elseif 2 == getCurrentState then
    isCurrentState = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_SOONFINISH")
    isWarTime = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_TIME", "warTimeMinute", warTimeMinute, "warTimeSecond", Int64toInt32(warTimeSecond))
    btn_join:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_CANTJOIN"))
    btn_join:SetIgnore(true)
  elseif 3 == getCurrentState then
    isCurrentState = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_FINISH")
    isWarTime = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_FINISH")
    btn_join:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_CANTJOIN"))
    btn_join:SetIgnore(true)
  end
  txt_channel:SetShow(true)
  txt_joinMemberCount:SetShow(true)
  txt_remainTime:SetShow(true)
  btn_join:SetShow(true)
  txt_channel:SetText(channelName)
  txt_joinMemberCount:SetText(getJoinMemberCount)
  txt_remainTime:SetText(isWarTime)
  btn_join:addInputEvent("Mouse_LUp", "HandleEventLUp_LocalWarInfo_All_JoinLocalWar( " .. id .. "," .. tostring(isLimitLocalWar) .. ", false )")
end
function PaGlobal_LocalWarInfo_All_InformationUpdate(deltaTime)
  if nil == Panel_LocalWarInfo_All then
    return
  end
  local ruleControl = PaGlobal_LocalWarInfo_All._ui._rule
  local ruleMaxSize = PaGlobal_LocalWarInfo_All._maxRuleSize
  local rewardControl = PaGlobal_LocalWarInfo_All._ui._reward
  local rewardMaxSize = PaGlobal_LocalWarInfo_All._maxRewardSize
  local explanationControl = PaGlobal_LocalWarInfo_All._ui._explanation
  local explanationMaxSize = PaGlobal_LocalWarInfo_All._maxExplanationSize
  local frame = PaGlobal_LocalWarInfo_All._ui._frame_desc
  local vScroll = frame:GetVScroll()
  local content = frame:GetFrameContent()
  local SpeedTime = PaGlobal_LocalWarInfo_All._rule_ani_SpeedTime
  if ruleControl._txt_title:IsCheck() then
    local value = ruleControl._stc_background:GetSizeY() + (ruleMaxSize - ruleControl._stc_background:GetSizeY()) * deltaTime * SpeedTime
    if value < 10 then
      value = 10
    end
    vScroll:SetShow(frame:GetSizeY() < value + 170)
    content:SetSize(content:GetSizeX(), value + 170)
    ruleControl._stc_background:SetSize(ruleControl._stc_background:GetSizeX(), value)
    ruleControl._stc_background:SetShow(true)
  else
    local value = ruleControl._stc_background:GetSizeY() - (ruleMaxSize + ruleControl._stc_background:GetSizeY()) * deltaTime * SpeedTime
    if value < 10 then
      value = 10
    end
    ruleControl._stc_background:SetSize(ruleControl._stc_background:GetSizeX(), value)
    if ruleControl._stc_background:GetSizeY() <= 10 then
      ruleControl._stc_background:SetShow(false)
    end
  end
  if rewardControl._txt_title:IsCheck() then
    local value = rewardControl._stc_background:GetSizeY() + (rewardMaxSize - rewardControl._stc_background:GetSizeY()) * deltaTime * SpeedTime
    if value < 10 then
      value = 10
    end
    vScroll:SetShow(frame:GetSizeY() < value + 170)
    content:SetSize(content:GetSizeX(), value + 170)
    rewardControl._stc_background:SetSize(rewardControl._stc_background:GetSizeX(), value)
    rewardControl._stc_background:SetShow(true)
  else
    local value = rewardControl._stc_background:GetSizeY() - (rewardMaxSize + rewardControl._stc_background:GetSizeY()) * deltaTime * SpeedTime
    if value < 10 then
      value = 10
    end
    rewardControl._stc_background:SetSize(rewardControl._stc_background:GetSizeX(), value)
    if rewardControl._stc_background:GetSizeY() <= 10 then
      rewardControl._stc_background:SetShow(false)
    end
  end
  if explanationControl._txt_title:IsCheck() then
    local value = explanationControl._stc_background:GetSizeY() + (explanationMaxSize - explanationControl._stc_background:GetSizeY()) * deltaTime * SpeedTime
    if value < 10 then
      value = 10
    end
    vScroll:SetShow(frame:GetSizeY() < value + 170)
    content:SetSize(content:GetSizeX(), value + 170)
    explanationControl._stc_background:SetSize(explanationControl._stc_background:GetSizeX(), value)
    explanationControl._stc_background:SetShow(true)
  else
    local value = explanationControl._stc_background:GetSizeY() - (explanationMaxSize + explanationControl._stc_background:GetSizeY()) * deltaTime * SpeedTime
    if value < 10 then
      value = 10
    end
    explanationControl._stc_background:SetSize(explanationControl._stc_background:GetSizeX(), value)
    if explanationControl._stc_background:GetSizeY() <= 10 then
      explanationControl._stc_background:SetShow(false)
    end
  end
  ruleControl._stc_background:SetPosY(ruleControl._txt_title:GetPosY() + ruleControl._txt_title:GetSizeY())
  if ruleControl._stc_background:GetShow() then
    rewardControl._txt_title:SetPosY(ruleControl._stc_background:GetPosY() + ruleControl._stc_background:GetSizeY() + 10)
  else
    rewardControl._txt_title:SetPosY(ruleControl._txt_title:GetPosY() + ruleControl._txt_title:GetSizeY() + 5)
  end
  rewardControl._stc_background:SetPosY(rewardControl._txt_title:GetPosY() + rewardControl._txt_title:GetSizeY())
  if rewardControl._stc_background:GetShow() then
    explanationControl._txt_title:SetPosY(rewardControl._stc_background:GetPosY() + rewardControl._stc_background:GetSizeY() + 10)
  else
    explanationControl._txt_title:SetPosY(rewardControl._txt_title:GetPosY() + rewardControl._txt_title:GetSizeY() + 5)
  end
  explanationControl._stc_background:SetPosY(explanationControl._txt_title:GetPosY() + explanationControl._txt_title:GetSizeY())
  for _, control in pairs(ruleControl._txt_content) do
    control:SetShow(control:GetPosY() + control:GetSizeY() < ruleControl._stc_background:GetSizeY())
  end
  for _, control in pairs(rewardControl._txt_content) do
    control:SetShow(control:GetPosY() + control:GetSizeY() < rewardControl._stc_background:GetSizeY())
  end
  for _, control in pairs(explanationControl._txt_content) do
    control:SetShow(control:GetPosY() + control:GetSizeY() < explanationControl._stc_background:GetSizeY())
  end
end
function PaGlobal_LocalWarInfo_All_GetOut()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  if IsSelfPlayerWaitAction() then
    ToClient_UnJoinLocalWar()
    if nil ~= Panel_LocalWarTeam and Panel_LocalWarTeam:GetShow() then
      Panel_LocalWarTeam:SetShow(false)
    end
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_WAITPOSITION_POSSIBLE"))
  end
end
function PaGlobal_LocalWarInfo_All_ESCMenuFunc()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  if true == ToClient_IsInstanceRandomMatching() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_RANDOMMATCH_FAILACK"))
    return
  end
  local playerWrapper = getSelfPlayer()
  if nil == playerWrapper then
    return
  end
  local player = playerWrapper:get()
  if nil == player then
    return
  end
  local hp = player:getHp()
  local maxHp = player:getMaxHp()
  local isGameMaster = ToClient_SelfPlayerIsGM()
  if 0 == ToClient_GetMyTeamNoLocalWar() then
    if Panel_LocalWarInfo_All:GetShow() then
      PaGlobal_LocalWarInfo_All_Close()
    else
      PaGlobal_LocalWarInfo_All_Open()
    end
  elseif hp == maxHp or isGameMaster then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_LOCALWAR_GETOUT_MEMO"),
      functionYes = PaGlobal_LocalWarInfo_All_GetOut,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData, "middle")
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_MAXHP_CHECK"))
  end
end
function HandleEventLUp_LocalWarInfo_All_DescriptionCheck(descType)
  if nil == Panel_LocalWarInfo_All then
    return
  end
  local frame = PaGlobal_LocalWarInfo_All._ui._frame_desc
  local vScroll = frame:GetVScroll()
  vScroll:SetControlTop()
  frame:UpdateContentScroll()
  frame:UpdateContentPos()
  if 0 == descType then
    PaGlobal_LocalWarInfo_All._openDesc = descType
    PaGlobal_LocalWarInfo_All._ui._rule._stc_background:SetShow(true)
  elseif 1 == descType then
    PaGlobal_LocalWarInfo_All._openDesc = descType
    PaGlobal_LocalWarInfo_All._ui._reward._stc_background:SetShow(true)
  elseif 2 == descType then
    PaGlobal_LocalWarInfo_All._openDesc = descType
    PaGlobal_LocalWarInfo_All._ui._explanation._stc_background:SetShow(true)
  else
    PaGlobal_LocalWarInfo_All._openDesc = -1
  end
end
function HandleEventOnOut_LocalWarInfo_All_SimpleTooltip(isShow, tipType)
  if nil == Panel_LocalWarInfo_All then
    return
  end
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_LIMIT_TOOLTIP_LEVEL_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_LIMIT_TOOLTIP_LEVEL_DESC")
    control = PaGlobal_LocalWarInfo_All._ui._icon_Level
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_LIMIT_TOOLTIP_AP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_LIMIT_TOOLTIP_AP_DESC")
    control = PaGlobal_LocalWarInfo_All._ui._icon_AP
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_LIMIT_TOOLTIP_DP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_LIMIT_TOOLTIP_DP_DESC")
    control = PaGlobal_LocalWarInfo_All._ui._icon_DP
  elseif 3 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_LIMIT_TOOLTIP_ADSUM_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_LIMIT_TOOLTIP_ADSUM_DESC")
    control = PaGlobal_LocalWarInfo_All._ui._icon_AD
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_LocalWarInfo_All_JoinLocalWar(index, isLimitLocalWar, isCurChannel)
  if nil == Panel_LocalWarInfo_All then
    return
  end
  local curChannelData = getCurrentChannelServerData()
  local getLevel = getSelfPlayer():get():getLevel()
  if nil == curChannelData then
    return
  end
  local litmitLevel = ToClient_GetLevelForLimitedLocalWar()
  local limitAttack = ToClient_GetAttackForLimitedLocalWar()
  local limitDefence = ToClient_GetDefenseForLimitedLocalWar()
  local limitADSum = ToClient_GetADSummaryForLimitedLocalWar()
  local isMineADSum = ToClient_getOffence() + ToClient_getDefence()
  if not isLimitLocalWar and getLevel < 50 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_LEVELLIMIT"))
    return
  end
  if isLimitLocalWar then
    if getLevel >= litmitLevel then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_LEVEL_LIMIT"))
    elseif limitAttack <= ToClient_getOffence() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_ATTACK_LIMIT"))
    elseif limitDefence <= ToClient_getDefence() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_DEFENCE_LIMIT"))
    elseif limitADSum <= isMineADSum then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_ADSUM_LIMIT"))
    end
  end
  local getServerNo
  if nil == index and true == isCurChannel then
    getServerNo = curChannelData._serverNo
  else
    local localWarStatusData = ToClient_GetLocalwarStatusData(index)
    if nil == localWarStatusData then
      local msg = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_NOTOPENWAR")
      Proc_ShowMessage_Ack(msg)
      return
    end
    local maxPlayer = ToClient_GetMaxLocalWarPlayer()
    local getJoinMemberCount = localWarStatusData:getTotalJoinCount()
    if getJoinMemberCount >= maxPlayer * 2 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_MESSAGE_FULLJOIN"))
      return
    end
    getServerNo = localWarStatusData:getServerNo()
  end
  local channelName = getChannelName(curChannelData._worldNo, getServerNo)
  local isGameMaster = ToClient_SelfPlayerIsGM()
  local noticeTitle = ""
  if getServerNo == curChannelData._serverNo then
    noticeTitle = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_JOIN")
    channelMemo = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_CURRENTCHANNELJOIN")
  else
    noticeTitle = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_TITLE_MSG")
    channelMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_CHANNELMOVE", "channelName", channelName)
  end
  local function joinLocalWar()
    local playerWrapper = getSelfPlayer()
    local player = playerWrapper:get()
    local hp = player:getHp()
    local maxHp = player:getMaxHp()
    if true == self._isConsole then
      _AudioPostEvent_SystemUiForXBOX(50, 1)
    end
    if player:doRideMyVehicle() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_NOT_RIDEHORSE"))
    elseif ToClient_IsMyselfInArena() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCompetitionAlreadyIn"))
      return
    end
    if IsSelfPlayerWaitAction() then
      if hp == maxHp or isGameMaster then
        if getServerNo == curChannelData._serverNo then
          ToClient_JoinLocalWar()
        else
          ToClient_RequestLocalwarJoinToAnotherChannel(getServerNo)
        end
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_MAXHP_CHECK"))
      end
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_LOCALWARINFO"))
    end
  end
  local changeChannelTime = getChannelMoveableRemainTime(curChannelData._worldNo)
  local changeRealChannelTime = convertStringFromDatetime(changeChannelTime)
  if changeChannelTime > toInt64(0, 0) and getServerNo ~= curChannelData._serverNo then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_TITLE_MSG"),
      content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANGECHANNEL_PENALTY", "changeRealChannelTime", changeRealChannelTime),
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    local messageBoxData = {
      title = noticeTitle,
      content = channelMemo,
      functionYes = joinLocalWar,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function HandleEventLUp_LocalWarInfo_All_JoinMyChannelLocalWar()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  local playerWrapper = getSelfPlayer()
  if nil == playerWrapper then
    return
  end
  local curChannelData = getCurrentChannelServerData()
  if nil == curChannelData then
    return
  end
  local player = playerWrapper:get()
  local hp = player:getHp()
  local maxHp = player:getMaxHp()
  local isGameMaster = ToClient_SelfPlayerIsGM()
  local getLevel = playerWrapper:get():getLevel()
  local inMyChannelInfo = ToClient_GetLocalwarStatusDataToServer(curChannelData._serverNo)
  local isLimitLocalWar = inMyChannelInfo:isLimitedLocalWar()
  if not isLimitLocalWar and getLevel < 50 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_LEVELLIMIT"))
    return
  end
  if hp == maxHp or isGameMaster then
    ToClient_JoinLocalWar()
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_MAXHP_CHECK"))
  end
end
function FromClient_LocalWarInfo_All_ResizePanel()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  Panel_LocalWarInfo_All:SetPosX((screenSizeX - Panel_LocalWarInfo_All:GetSizeX()) / 2)
  Panel_LocalWarInfo_All:SetPosY((screenSizeY - Panel_LocalWarInfo_All:GetSizeY()) / 2)
end
function FromClient_LocalWarInfo_All_UpdateLocalWarStatus()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  PaGlobal_LocalWarInfo_All:setContent()
end
