PaGlobal_PersonalBattle = {
  _ui = {
    _blackBG = nil,
    _stcTitleBG = nil,
    _btnClose = nil,
    _list2 = nil,
    _frameDesc = nil,
    _frameVScroll = nil,
    _desc_Rule_Title = nil,
    _desc_rule = nil,
    desc_Rule = {},
    _desc_Reward_Title = nil,
    _desc_Reward = nil,
    desc_Reward = {},
    _desc_Explanation_Title = nil,
    _desc_Explanation = nil,
    desc_Explanation = {},
    _RankInfo = nil
  },
  _DESCINDEX = {
    _rule = 0,
    _reward = 1,
    _explanation = 2,
    _totalCount = 3
  },
  _createListCount = 14,
  _startIndex = 0,
  _listPool = {},
  _maxDescRuleSize = 40,
  _maxDescRewardSize = 20,
  _maxDescExplanationSize = 30,
  _ruleCount = 8,
  _rewardCount = 3,
  _explanationCount = 5,
  _initialize = false
}
function PaGlobal_PersonalBattle:initialize()
  if true == self._initialize then
    return
  end
  self._ui._blackBG = UI.getChildControl(Panel_Window_PersonalBattle, "Static_BlackBG")
  self._ui._stcTitleBG = UI.getChildControl(Panel_Window_PersonalBattle, "StaticText_TitleArea")
  self._ui._btnClose = UI.getChildControl(self._ui._stcTitleBG, "Button_Win_Close")
  self._ui._list2 = UI.getChildControl(Panel_Window_PersonalBattle, "List2_PersonalBattleList")
  self._ui._frameDesc = UI.getChildControl(Panel_Window_PersonalBattle, "Frame_Description")
  self._ui._frameVScroll = UI.getChildControl(self._ui._frameDesc, "Frame_1_VerticalScroll")
  local content = self._ui._frameDesc:GetFrameContent()
  self._ui._desc_Rule_Title = UI.getChildControl(content, "StaticText_PersonalBattle_Rule")
  self._ui._desc_rule = UI.getChildControl(content, "Static_BG_1")
  for index = 1, self._ruleCount do
    self._ui.desc_Rule[index - 1] = UI.getChildControl(self._ui._desc_rule, "StaticText_Desc_Rule_" .. index)
    self._ui.desc_Rule[index - 1]:SetTextMode(__eTextMode_AutoWrap)
    self._ui.desc_Rule[index - 1]:SetAutoResize(true)
    local descText
    if 7 == index then
      descText = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_PERSONALBATTLE_DESC_RULETEXT_7", "time", 5, "count", 3)
    else
      descText = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALBATTLE_DESC_RULETEXT_" .. index)
    end
    self._ui.desc_Rule[index - 1]:SetText(descText)
    self._maxDescRuleSize = self._maxDescRuleSize + self._ui.desc_Rule[index - 1]:GetTextSizeY()
  end
  self._ui._desc_Reward_Title = UI.getChildControl(content, "StaticText_PersonalBattle_Reward")
  self._ui._desc_Reward = UI.getChildControl(content, "Static_BG_2")
  self._ui._desc_Reward_Title:SetShow(false)
  self._ui._desc_Reward:SetShow(false)
  for index = 1, self._rewardCount do
    self._ui.desc_Reward[index - 1] = UI.getChildControl(self._ui._desc_Reward, "StaticText_Desc_Reward_" .. index)
    self._ui.desc_Reward[index - 1]:SetShow(false)
  end
  self._ui._desc_Explanation_Title = UI.getChildControl(content, "StaticText_PersonalBattle_Explanation")
  self._ui._desc_Explanation = UI.getChildControl(content, "Static_BG_3")
  for index = 1, self._explanationCount do
    self._ui.desc_Explanation[index - 1] = UI.getChildControl(self._ui._desc_Explanation, "StaticText_Desc_Explanation_" .. index)
    self._ui.desc_Explanation[index - 1]:SetTextMode(__eTextMode_AutoWrap)
    self._ui.desc_Explanation[index - 1]:SetAutoResize(true)
    local descText = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALBATTLE_DESC_EXPLANATION_" .. index)
    self._ui.desc_Explanation[index - 1]:SetText(descText)
    self._maxDescExplanationSize = self._maxDescExplanationSize + self._ui.desc_Explanation[index - 1]:GetTextSizeY()
  end
  local Static_InfoBg = UI.getChildControl(Panel_Window_PersonalBattle, "Static_InfoBg")
  self._ui._RankInfo = UI.getChildControl(Static_InfoBg, "StaticText_RankInfo")
  self:validate()
  self._ui._list2:changeAnimationSpeed(10)
  self._ui._list2:registEvent(__ePAUIList2EventType_LuaChangeContent, "FGlobal_PersonalBattle_ListUpdate")
  self._ui._list2:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._desc_Explanation_Title:SetPosY(85)
  for index = 1, self._ruleCount do
    self._ui.desc_Rule[index - 1]:SetPosX(5)
  end
  self._ui.desc_Rule[0]:SetPosY(5)
  self._ui.desc_Rule[1]:SetPosY(self._ui.desc_Rule[0]:GetPosY() + self._ui.desc_Rule[0]:GetTextSizeY() + 2)
  self._ui.desc_Rule[2]:SetPosY(self._ui.desc_Rule[1]:GetPosY() + self._ui.desc_Rule[1]:GetTextSizeY() + 2)
  self._ui.desc_Rule[3]:SetPosY(self._ui.desc_Rule[2]:GetPosY() + self._ui.desc_Rule[2]:GetTextSizeY() + 2)
  self._ui.desc_Rule[4]:SetPosY(self._ui.desc_Rule[3]:GetPosY() + self._ui.desc_Rule[3]:GetTextSizeY() + 2)
  self._ui.desc_Rule[5]:SetPosY(self._ui.desc_Rule[4]:GetPosY() + self._ui.desc_Rule[4]:GetTextSizeY() + 2)
  self._ui.desc_Rule[6]:SetPosY(self._ui.desc_Rule[5]:GetPosY() + self._ui.desc_Rule[5]:GetTextSizeY() + 2)
  self._ui.desc_Rule[7]:SetPosY(self._ui.desc_Rule[6]:GetPosY() + self._ui.desc_Rule[6]:GetTextSizeY() + 2)
  for index = 1, self._explanationCount do
    self._ui.desc_Explanation[index - 1]:SetPosX(5)
  end
  self._ui.desc_Explanation[0]:SetPosY(5)
  self._ui.desc_Explanation[1]:SetPosY(self._ui.desc_Explanation[0]:GetPosY() + self._ui.desc_Explanation[0]:GetTextSizeY() + 2)
  self._ui.desc_Explanation[2]:SetPosY(self._ui.desc_Explanation[1]:GetPosY() + self._ui.desc_Explanation[1]:GetTextSizeY() + 2)
  self._ui.desc_Explanation[3]:SetPosY(self._ui.desc_Explanation[2]:GetPosY() + self._ui.desc_Explanation[2]:GetTextSizeY() + 2)
  self._ui._blackBG:SetSize(getScreenSizeX() + 250, getScreenSizeY() + 250)
  self._ui._blackBG:SetHorizonCenter()
  self._ui._blackBG:SetVerticalMiddle()
  self._ui._blackBG:ComputePos()
  if true == _ContentsGroup_UsePadSnapping then
    self._ui._btnClose:SetShow(false)
  else
    self._ui._btnClose:addInputEvent("Mouse_LUp", "PaGlobal_PersonalBattle:close()")
  end
  self._ui._desc_Rule_Title:addInputEvent("Mouse_LUp", "HandleEventLUp_PersonalBattle_DescriptionCheck(" .. self._DESCINDEX._rule .. ")")
  self._ui._desc_Reward_Title:addInputEvent("Mouse_LUp", "HandleEventLUp_PersonalBattle_DescriptionCheck(" .. self._DESCINDEX._reward .. ")")
  self._ui._desc_Explanation_Title:addInputEvent("Mouse_LUp", "HandleEventLUp_PersonalBattle_DescriptionCheck(" .. self._DESCINDEX._explanation .. ")")
  FGlobal_PersonalBattle_InformationOpen(0)
  HandleEventLUp_PersonalBattle_DescriptionCheck(self._DESCINDEX._rule)
  self._initialize = true
end
function PaGlobal_PersonalBattle:validate()
  self._ui._blackBG:isValidate()
  self._ui._stcTitleBG:isValidate()
  self._ui._btnClose:isValidate()
  self._ui._list2:isValidate()
  self._ui._frameDesc:isValidate()
  self._ui._frameVScroll:isValidate()
  self._ui._desc_Rule_Title:isValidate()
  self._ui._desc_rule:isValidate()
  for index = 1, self._ruleCount do
    self._ui.desc_Rule[index - 1]:isValidate()
  end
  self._ui._desc_Reward_Title:isValidate()
  self._ui._desc_Reward:isValidate()
  for index = 1, self._rewardCount do
    self._ui.desc_Reward[index - 1]:isValidate()
  end
  self._ui._desc_Explanation_Title:isValidate()
  self._ui._desc_Explanation:isValidate()
  for index = 1, self._explanationCount do
    self._ui.desc_Explanation[index - 1]:isValidate()
  end
  self._ui._RankInfo:isValidate()
end
function PaGlobal_PersonalBattle:open()
  if true == ToClient_IsInstanceRandomMatching() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_RANDOMMATCH_FAILACK"))
    return
  end
  local rv = ToClient_CheckToJoinBattle()
  if 0 ~= rv then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoRestrictedToJoinBattle"))
    return
  end
  audioPostEvent_SystemUi(1, 18)
  _AudioPostEvent_SystemUiForXBOX(1, 18)
  if true == ToClient_getJoinGuildBattle() then
    if false == ToClient_isPersonalBattle() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantattendGuildBattle"))
    else
      PaGlobal_PersonalBattle:unJoin()
    end
    return
  end
  ToClient_GuildBattleStatusRefreshReq()
  ToClient_getPersonalBattleRankInfo()
end
function PaGlobal_PersonalBattle:close()
  audioPostEvent_SystemUi(1, 17)
  _AudioPostEvent_SystemUiForXBOX(1, 17)
  Panel_Window_PersonalBattle:SetShow(false)
end
function PaGlobal_PersonalBattle:update()
  local serverCount = ToClient_GuildBattleStatusCount()
  self._ui._list2:getElementManager():clearKey()
  for idx = 0, serverCount - 1 do
    self._ui._list2:getElementManager():pushKey(toInt64(0, idx))
  end
end
function PaGlobal_PersonalBattle:join(idx)
  local curChannelData = getCurrentChannelServerData()
  local getLevel = getSelfPlayer():get():getLevel()
  if nil == curChannelData then
    return
  end
  local personalBattleStatusData = ToClient_getGuildBattleStatusData(idx)
  local getServerNo = personalBattleStatusData:getServerNo()
  local channelName = getChannelName(curChannelData._worldNo, getServerNo)
  local isGameMaster = ToClient_SelfPlayerIsGM()
  local channelMemo = ""
  local tempChannel = getGameChannelServerDataByWorldNo(curChannelData._worldNo, idx)
  local isBalanceServer = tempChannel._isBalanceChannel
  local function joinPersonalBattle()
    local playerWrapper = getSelfPlayer()
    local player = playerWrapper:get()
    local hp = player:getHp()
    local maxHp = player:getMaxHp()
    if player:doRideMyVehicle() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_NOT_RIDEHORSE"))
    elseif ToClient_IsMyselfInArena() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCompetitionAlreadyIn"))
      return
    end
    local appliedBuff = getSelfPlayer():getAppliedBuffBegin(true)
    if appliedBuff ~= nil then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CANNOTJOIN_DEBUFF"))
      return
    end
    if IsSelfPlayerWaitAction() then
      if hp == maxHp then
        if getServerNo == curChannelData._serverNo then
          ToClient_joinPersonalBattle()
        else
          ToClient_RequestGuildBattleJoinToAnotherChannel(getServerNo)
        end
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_MAXHP_CHECK"))
      end
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_NOTUSEALERT"))
    end
  end
  if getServerNo == curChannelData._serverNo then
    channelMemo = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALBATTLE_CURRENTCHANNELJOIN")
  else
    channelMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PERSONALBATTLE_CHANNELMOVE", "channelName", channelName)
  end
  local changeChannelTime = getChannelMoveableRemainTime(curChannelData._worldNo)
  local changeRealChannelTime = convertStringFromDatetime(changeChannelTime)
  if changeChannelTime > toInt64(0, 0) and getServerNo ~= curChannelData._serverNo then
    local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANGECHANNEL_PENALTY", "changeRealChannelTime", changeRealChannelTime)
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_TITLE_MSG"),
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_TITLE_MSG"),
      content = channelMemo,
      functionYes = joinPersonalBattle,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
  PaGlobal_GuildBattlePoint:clearAttendName()
end
function PaGlobal_PersonalBattle:unJoin()
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_MENU_PERSONALBATTLE_UNJOIN")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = ToClient_GuildBattle_UnjoinGuildBattle,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FGlobal_PersonalBattle_ListUpdate(contents, key)
  local self = PaGlobal_PersonalBattle
  local idx = Int64toInt32(key)
  local personalBattleListBG = UI.getChildControl(contents, "StaticText_ListBG")
  personalBattleListBG:SetShow(true)
  local personalBattleListServer = UI.getChildControl(personalBattleListBG, "StaticText_Channel")
  personalBattleListServer:SetShow(true)
  local personalBattleListJoinMember = UI.getChildControl(personalBattleListBG, "StaticText_JoinMemberCount")
  personalBattleListJoinMember:SetShow(true)
  local personalBattleListStatus = UI.getChildControl(personalBattleListBG, "StaticText_PersonalBattleStatus")
  personalBattleListStatus:SetShow(true)
  local personalBattleListJoinBtn = UI.getChildControl(personalBattleListBG, "Button_Join")
  personalBattleListJoinBtn:SetShow(true)
  local curChannelData = getCurrentChannelServerData()
  local worldServerData = getGameWorldServerDataByWorldNo(curChannelData._worldNo)
  local restrictedServerNo = worldServerData._restrictedServerNo
  local changeChannelTime = getChannelMoveableRemainTime(curChannelData._worldNo)
  local isAdmission = true
  if restrictedServerNo ~= 0 then
    if restrictedServerNo == curChannelData._serverNo then
      isAdmission = true
    elseif changeChannelTime > toInt64(0, 0) then
      isAdmission = false
    else
      isAdmission = true
    end
  end
  if nil ~= curChannelData then
    local personalBattleStatusData = ToClient_getGuildBattleStatusData(idx)
    local getServerNo = personalBattleStatusData:getServerNo()
    local getJoinMemberCount = personalBattleStatusData:getTotalJoinCount()
    local getIsFull = personalBattleStatusData:isFull()
    local isPersonalMode = personalBattleStatusData:isPersonalMode()
    local channelName = getChannelName(curChannelData._worldNo, getServerNo)
    local getIsStopByGM = personalBattleStatusData:isStopByGM()
    if getJoinMemberCount < 0 then
      getJoinMemberCount = 0
    end
    if false == isPersonalMode or true == getIsStopByGM then
      isCurrentState = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_FINISH")
      personalBattleListJoinBtn:SetFontColor(Defines.Color.C_FFF26A6A)
      personalBattleListJoinBtn:SetOverFontColor(Defines.Color.C_FFF26A6A)
      personalBattleListJoinBtn:SetClickFontColor(Defines.Color.C_FFF26A6A)
      personalBattleListJoinBtn:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_CANTJOIN"))
      personalBattleListJoinBtn:SetIgnore(true)
    elseif true == personalBattleStatusData:isReadyState() then
      if true == getIsFull then
        isCurrentState = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_WAITING")
        personalBattleListJoinBtn:SetFontColor(Defines.Color.C_FFF0EF9D)
        personalBattleListJoinBtn:SetOverFontColor(Defines.Color.C_FFF0EF9D)
        personalBattleListJoinBtn:SetClickFontColor(Defines.Color.C_FFF0EF9D)
        personalBattleListJoinBtn:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_CANTJOIN"))
        personalBattleListJoinBtn:SetIgnore(true)
      else
        isCurrentState = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_JOIN_WAITING")
        personalBattleListJoinBtn:SetFontColor(Defines.Color.C_FF3B8BBE)
        personalBattleListJoinBtn:SetOverFontColor(Defines.Color.C_FF3B8BBE)
        personalBattleListJoinBtn:SetClickFontColor(Defines.Color.C_FF3B8BBE)
        personalBattleListJoinBtn:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_JOIN"))
        personalBattleListJoinBtn:SetIgnore(false)
      end
    elseif true == personalBattleStatusData:isGamingState() then
      isCurrentState = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_ING")
      personalBattleListJoinBtn:SetFontColor(Defines.Color.C_FFF0EF9D)
      personalBattleListJoinBtn:SetOverFontColor(Defines.Color.C_FFF0EF9D)
      personalBattleListJoinBtn:SetClickFontColor(Defines.Color.C_FFF0EF9D)
      personalBattleListJoinBtn:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_CANTJOIN"))
      personalBattleListJoinBtn:SetIgnore(true)
    elseif true == personalBattleStatusData:isEndState() then
      isCurrentState = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_SOONFINISH")
      personalBattleListJoinBtn:SetFontColor(Defines.Color.C_FFF26A6A)
      personalBattleListJoinBtn:SetOverFontColor(Defines.Color.C_FFF26A6A)
      personalBattleListJoinBtn:SetClickFontColor(Defines.Color.C_FFF26A6A)
      personalBattleListJoinBtn:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SAVAGEDEFENCEINFO_GAMING"))
      personalBattleListJoinBtn:SetIgnore(true)
    end
    if not isAdmission then
      personalBattleListJoinBtn:SetFontColor(Defines.Color.C_FFF26A6A)
      personalBattleListJoinBtn:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_ISADMISSION_LIMIT"))
      personalBattleListJoinBtn:SetIgnore(true)
    end
    personalBattleListServer:SetText(channelName)
    personalBattleListJoinMember:SetText(getJoinMemberCount)
    personalBattleListStatus:SetText(isCurrentState)
    personalBattleListJoinBtn:addInputEvent("Mouse_LUp", "PaGlobal_PersonalBattle:join(" .. idx .. ")")
  end
end
local rule_ani_SpeedTime = 5
local _desc_Rule_TitleSize = 0
function FGlobal_PersonalBattle_InformationOpen(deltaTime)
  local self = PaGlobal_PersonalBattle
  local content = self._ui._frameDesc:GetFrameContent()
  local testSize = content:GetSizeY()
  local contentSize = self._ui._desc_Rule_Title:GetSizeY() + self._ui._desc_Explanation_Title:GetSizeY()
  if self._ui._desc_Rule_Title:IsCheck() then
    local value = self._ui._desc_rule:GetSizeY() + (self._maxDescRuleSize - self._ui._desc_rule:GetSizeY()) * deltaTime * rule_ani_SpeedTime
    if value < 10 then
      value = 10
    end
    self._ui._desc_rule:SetSize(self._ui._desc_rule:GetSizeX(), value)
    self._ui._desc_rule:SetShow(true)
    contentSize = contentSize + self._maxDescRuleSize
  else
    local value = self._ui._desc_rule:GetSizeY() - (self._maxDescRuleSize + self._ui._desc_rule:GetSizeY()) * deltaTime * rule_ani_SpeedTime
    if value < 10 then
      value = 10
    end
    self._ui._desc_rule:SetSize(self._ui._desc_rule:GetSizeX(), value)
    if self._ui._desc_rule:GetSizeY() <= 10 then
      self._ui._desc_rule:SetShow(false)
    end
  end
  if self._ui._desc_Explanation_Title:IsCheck() then
    local value = self._ui._desc_Explanation:GetSizeY() + (self._maxDescExplanationSize - self._ui._desc_Explanation:GetSizeY()) * deltaTime * rule_ani_SpeedTime
    if value < 10 then
      value = 10
    end
    self._ui._desc_Explanation:SetSize(self._ui._desc_Explanation:GetSizeX(), value)
    self._ui._desc_Explanation:SetShow(true)
    contentSize = contentSize + self._maxDescExplanationSize
  else
    local value = self._ui._desc_Explanation:GetSizeY() - (self._maxDescExplanationSize + self._ui._desc_Explanation:GetSizeY()) * deltaTime * rule_ani_SpeedTime
    if value < 10 then
      value = 10
    end
    self._ui._desc_Explanation:SetSize(self._ui._desc_Explanation:GetSizeX(), value)
    if 10 >= self._ui._desc_Explanation:GetSizeY() then
      self._ui._desc_Explanation:SetShow(false)
    end
  end
  self._ui._desc_rule:SetPosY(self._ui._desc_Rule_Title:GetPosY() + self._ui._desc_Rule_Title:GetSizeY())
  if self._ui._desc_rule:GetShow() then
    self._ui._desc_Explanation_Title:SetPosY(self._ui._desc_rule:GetPosY() + self._ui._desc_rule:GetSizeY() + 10)
  else
    self._ui._desc_Explanation_Title:SetPosY(self._ui._desc_Rule_Title:GetPosY() + self._ui._desc_Rule_Title:GetSizeY() + 5)
  end
  self._ui._desc_Explanation:SetPosY(self._ui._desc_Explanation_Title:GetPosY() + self._ui._desc_Explanation_Title:GetSizeY())
  for _, control in pairs(self._ui.desc_Rule) do
    control:SetShow(control:GetPosY() + control:GetSizeY() < self._ui._desc_rule:GetSizeY())
  end
  for _, control in pairs(self._ui.desc_Explanation) do
    control:SetShow(control:GetPosY() + control:GetSizeY() < self._ui._desc_Explanation:GetSizeY())
  end
  content:SetSize(content:GetSizeX(), contentSize)
  PaGlobal_PersonalBattle._ui._frameDesc:UpdateContentScroll()
  PaGlobal_PersonalBattle._ui._frameDesc:UpdateContentPos()
end
function FromClient_PersonalBattle_StartSoon()
  local msg = {
    main = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALBATTLE_SELECTED_MASTER"),
    sub = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALBATTLE"),
    addMsg = ""
  }
  if false == ToClient_GuildBattle_AmIMasterForThisBattle() then
    msg.main = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALBATTLE_STARTSOON")
  end
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, 78, false)
end
function FromClient_PersonalBattleRankInfoResult(winCount, loseCount, rating, ranking)
  local self = PaGlobal_PersonalBattle
  local msg = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_PERSONALBATTLE_RANKINFO", "winCount", tostring(winCount), "loseCount", tostring(loseCount), "rating", tostring(rating), "ranking", tostring(ranking))
  self._ui._RankInfo:SetText(msg)
end
function FromClient_UpdateGuildBattleStatus()
  local self = PaGlobal_PersonalBattle
  Panel_Window_PersonalBattle:SetShow(true)
  self._ui._desc_Rule_Title:SetCheck(true)
  self._ui._desc_Explanation_Title:SetCheck(false)
  self._ui._desc_rule:SetShow(false)
  self._ui._desc_Explanation:SetShow(false)
  self._ui._desc_rule:SetSize(self._ui._desc_rule:GetSizeX(), 1)
  self._ui._desc_Explanation:SetSize(self._ui._desc_Explanation:GetSizeX(), 1)
  self:update()
end
function FromClient_luaLoadComplete_PersonalBattleWindow()
  PaGlobal_PersonalBattle:initialize()
end
function HandleEventLUp_PersonalBattle_DescriptionCheck(index)
  local self = PaGlobal_PersonalBattle
  local content = self._ui._frameDesc:GetFrameContent()
  local contentSize = self._ui._desc_Rule_Title:GetSizeY() + self._ui._desc_Explanation_Title:GetSizeY()
  if nil == content then
    return
  end
  if index == self._DESCINDEX._rule then
    contentSize = contentSize + self._maxDescRuleSize
  elseif self._DESCINDEX._explanation then
    contentSize = contentSize + self._maxDescExplanationSize
  end
  content:SetSize(content:GetSizeX(), contentSize)
  PaGlobal_PersonalBattle._ui._frameVScroll:SetControlTop()
  PaGlobal_PersonalBattle._ui._frameDesc:UpdateContentScroll()
  PaGlobal_PersonalBattle._ui._frameDesc:UpdateContentPos()
end
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_PersonalBattleWindow")
registerEvent("FromClient_PersonalBattleRankInfoResult", "FromClient_PersonalBattleRankInfoResult")
registerEvent("FromClient_UpdateGuildBattleStatus", "FromClient_UpdateGuildBattleStatus")
registerEvent("FromClient_PersonalBattle_StartSoon", "FromClient_PersonalBattle_StartSoon")
Panel_Window_PersonalBattle:RegisterUpdateFunc("FGlobal_PersonalBattle_InformationOpen")
