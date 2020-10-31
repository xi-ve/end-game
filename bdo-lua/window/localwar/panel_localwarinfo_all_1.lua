function PaGlobal_LocalWarInfo_All:initialize()
  if true == self._initialize then
    return
  end
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:controlSetShow()
  self:registEventHandler()
  self:validate()
  self:setIconSpanSize()
  self:setDescriptionSizeX()
  self:setDescriptionString()
  self._initialize = true
  FromClient_LocalWarInfo_All_ResizePanel()
end
function PaGlobal_LocalWarInfo_All:controlAll_Init()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  self._ui._stc_titleBG = UI.getChildControl(Panel_LocalWarInfo_All, "Static_TitleBG")
  self._ui._list2_serverList = UI.getChildControl(Panel_LocalWarInfo_All, "List2_ServerList")
  self._ui._stc_leftBG = UI.getChildControl(Panel_LocalWarInfo_All, "Static_LeftBG")
  local iconGroup = UI.getChildControl(self._ui._stc_leftBG, "Static_SubTitleGroup")
  self._ui._icon_Level = UI.getChildControl(iconGroup, "StaticText__M_Limit_Level")
  self._ui._icon_AP = UI.getChildControl(iconGroup, "Static_M_Limit_AP")
  self._ui._icon_DP = UI.getChildControl(iconGroup, "Static_M_Limit_DP")
  self._ui._icon_AD = UI.getChildControl(iconGroup, "Static_M_Limit_AD")
  local myChannelBG = UI.getChildControl(Panel_LocalWarInfo_All, "Static_BottomGroup")
  self._ui._txt_MyLevel = UI.getChildControl(myChannelBG, "StaticText_Limit_Level")
  self._ui._txt_MyAp = UI.getChildControl(myChannelBG, "StaticText_Limit_AP")
  self._ui._txt_MyDp = UI.getChildControl(myChannelBG, "StaticText_Limit_DP")
  self._ui._txt_MyAdSum = UI.getChildControl(myChannelBG, "StaticText_Limit_ADSum")
  self._ui._txt_MyUnLimit = UI.getChildControl(myChannelBG, "StaticText_Limit_Unlimit")
  self._ui._txt_MyChannel = UI.getChildControl(myChannelBG, "StaticText_Channel")
  self._ui._txt_MyJoinMemberCount = UI.getChildControl(myChannelBG, "StaticText_JoinMemberCount")
  self._ui._txt_MyRemainTime = UI.getChildControl(myChannelBG, "StaticText_RemainTime")
  self._ui._btn_MyJoin = UI.getChildControl(myChannelBG, "Button_InmyChannel")
  self._ui._frame_desc = UI.getChildControl(Panel_LocalWarInfo_All, "Frame_Description")
  local content = self._ui._frame_desc:GetFrameContent()
  local vScroll = self._ui._frame_desc:GetVScroll()
  self._ui._rule._txt_title = UI.getChildControl(content, "StaticText_LocalWar_Rule")
  self._ui._rule._stc_background = UI.getChildControl(content, "Static_BG_1")
  for index = 1, self._ruleCount do
    self._ui._rule._txt_content[index - 1] = UI.getChildControl(self._ui._rule._stc_background, "StaticText_Desc_Rule_" .. tostring(index))
  end
  self._ui._reward._txt_title = UI.getChildControl(content, "StaticText_LocalWar_Reward")
  self._ui._reward._stc_background = UI.getChildControl(content, "Static_BG_2")
  for index = 1, self._rewardCount do
    self._ui._reward._txt_content[index - 1] = UI.getChildControl(self._ui._reward._stc_background, "StaticText_Desc_Reward_" .. tostring(index))
  end
  self._ui._explanation._txt_title = UI.getChildControl(content, "StaticText_LocalWar_Explanation")
  self._ui._explanation._stc_background = UI.getChildControl(content, "Static_BG_3")
  for index = 1, self._explanationCount do
    self._ui._explanation._txt_content[index - 1] = UI.getChildControl(self._ui._explanation._stc_background, "StaticText_Desc_Explanation_" .. tostring(index))
  end
end
function PaGlobal_LocalWarInfo_All:controlPc_Init()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  local titleBG = UI.getChildControl(Panel_LocalWarInfo_All, "Static_TitleBG")
  self._ui_pc._btn_close = UI.getChildControl(titleBG, "Button_Win_Close")
  self._ui_pc._btn_help = UI.getChildControl(titleBG, "Button_Question")
end
function PaGlobal_LocalWarInfo_All:controlConsole_Init()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  self._ui_console._stc_keyguideBG = UI.getChildControl(Panel_LocalWarInfo_All, "Static_KeyGuide_Console")
  self._ui_console._stc_keyguideA = UI.getChildControl(self._ui_console._stc_keyguideBG, "StaticText_A_ConsoleUI")
  self._ui_console._stc_keyguideB = UI.getChildControl(self._ui_console._stc_keyguideBG, "StaticText_B_ConsoleUI")
  self._ui_console._stc_keyguideY = UI.getChildControl(self._ui_console._stc_keyguideBG, "StaticText_Y_ConsoleUI")
  self._ui_console._stc_keyguideY:SetShow(false)
  local keyGuides = {
    self._ui_console._stc_keyguideY,
    self._ui_console._stc_keyguideA,
    self._ui_console._stc_keyguideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console._stc_keyguideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_LocalWarInfo_All:controlSetShow()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  self._ui_pc._btn_close:SetShow(not self._isConsole)
  self._ui._frame_desc:SetShow(not self._isConsole)
  self._ui_console._stc_keyguideBG:SetShow(self._isConsole)
  if true == self._isConsole then
    local sizeX = self._ui._stc_leftBG:GetSizeXOrigin()
    Panel_LocalWarInfo_All:SetSize(sizeX, Panel_LocalWarInfo_All:GetSizeY())
    self._ui._stc_titleBG:SetSize(sizeX, self._ui._stc_titleBG:GetSizeY())
    self._ui._stc_titleBG:ComputePosAllChild()
  end
end
function PaGlobal_LocalWarInfo_All:registEventHandler()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_LocalWarInfo_All_ResizePanel")
  registerEvent("FromClient_UpdateLocalWarStatus", "FromClient_LocalWarInfo_All_UpdateLocalWarStatus")
  Panel_LocalWarInfo_All:RegisterUpdateFunc("PaGlobal_LocalWarInfo_All_InformationUpdate")
  Panel_LocalWarInfo_All:RegisterShowEventFunc(true, "PaGlobal_LocalWarInfo_All_ShowAni()")
  Panel_LocalWarInfo_All:RegisterShowEventFunc(false, "PaGlobal_LocalWarInfo_All_HideAni()")
  self._ui._list2_serverList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_LocalWarInfo_All_UpdateServerList")
  self._ui._list2_serverList:createChildContent(__ePAUIList2ElementManagerType_List)
  if true == self._isConsole then
  else
    self._ui_pc._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_LocalWarInfo_All_Close()")
    self._ui._rule._txt_title:addInputEvent("Mouse_LUp", "HandleEventLUp_LocalWarInfo_All_DescriptionCheck(0)")
    self._ui._reward._txt_title:addInputEvent("Mouse_LUp", "HandleEventLUp_LocalWarInfo_All_DescriptionCheck(1)")
    self._ui._explanation._txt_title:addInputEvent("Mouse_LUp", "HandleEventLUp_LocalWarInfo_All_DescriptionCheck(2)")
    self._ui._icon_Level:addInputEvent("Mouse_On", "HandleEventOnOut_LocalWarInfo_All_SimpleTooltip( true, 0 )")
    self._ui._icon_Level:addInputEvent("Mouse_Out", "HandleEventOnOut_LocalWarInfo_All_SimpleTooltip( false, 0 )")
    self._ui._icon_AP:addInputEvent("Mouse_On", "HandleEventOnOut_LocalWarInfo_All_SimpleTooltip( true, 1 )")
    self._ui._icon_AP:addInputEvent("Mouse_Out", "HandleEventOnOut_LocalWarInfo_All_SimpleTooltip( false, 1 )")
    self._ui._icon_DP:addInputEvent("Mouse_On", "HandleEventOnOut_LocalWarInfo_All_SimpleTooltip( true, 2 )")
    self._ui._icon_DP:addInputEvent("Mouse_Out", "HandleEventOnOut_LocalWarInfo_All_SimpleTooltip( false, 2 )")
    self._ui._icon_AD:addInputEvent("Mouse_On", "HandleEventOnOut_LocalWarInfo_All_SimpleTooltip( true, 3 )")
    self._ui._icon_AD:addInputEvent("Mouse_Out", "HandleEventOnOut_LocalWarInfo_All_SimpleTooltip( false, 3 )")
  end
end
function PaGlobal_LocalWarInfo_All:prepareOpen()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  if false == ToClient_IsGrowStepOpen(__eGrowStep_localWar) then
    return
  end
  ToClient_RequestLocalwarStatus()
  if false == self._isConsole then
    audioPostEvent_SystemUi(1, 6)
  else
    _AudioPostEvent_SystemUiForXBOX(1, 18)
  end
  self._ui._rule._txt_title:SetCheck(true)
  self._ui._rule._stc_background:SetShow(false)
  self._ui._rule._stc_background:SetSize(self._ui._rule._stc_background:GetSizeX(), 1)
  self._ui._reward._txt_title:SetCheck(false)
  self._ui._reward._stc_background:SetShow(false)
  self._ui._reward._stc_background:SetSize(self._ui._reward._stc_background:GetSizeX(), 1)
  self._ui._explanation._txt_title:SetCheck(false)
  self._ui._explanation._stc_background:SetShow(false)
  self._ui._explanation._stc_background:SetSize(self._ui._explanation._stc_background:GetSizeX(), 1)
  self:setContent()
  PaGlobal_LocalWarInfo_All:open()
end
function PaGlobal_LocalWarInfo_All:open()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  Panel_LocalWarInfo_All:SetShow(true, true)
end
function PaGlobal_LocalWarInfo_All:prepareClose()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  if false == self._isConsole then
    audioPostEvent_SystemUi(1, 1)
  else
    _AudioPostEvent_SystemUiForXBOX(1, 17)
  end
  self._openDesc = -1
  self._ui._rule._txt_title:SetCheck(false)
  self._ui._reward._txt_title:SetCheck(false)
  self._ui._explanation._txt_title:SetCheck(false)
  self._ui._rule._stc_background:SetShow(false)
  self._ui._reward._stc_background:SetShow(false)
  self._ui._explanation._stc_background:SetShow(false)
  self._ui._rule._stc_background:SetSize(self._ui._rule._stc_background:GetSizeX(), 1)
  self._ui._reward._stc_background:SetSize(self._ui._reward._stc_background:GetSizeX(), 1)
  self._ui._explanation._stc_background:SetSize(self._ui._explanation._stc_background:GetSizeX(), 1)
  TooltipSimple_Hide()
  PaGlobal_LocalWarInfo_All:close()
end
function PaGlobal_LocalWarInfo_All:close()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  Panel_LocalWarInfo_All:SetShow(false, true)
end
function PaGlobal_LocalWarInfo_All:validate()
  if nil == Panel_LocalWarInfo_All then
    return
  end
end
function PaGlobal_LocalWarInfo_All:setIconSpanSize()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  if isGameTypeKorea() or isGameTypeJapan() or isGameTypeRussia() or isGameTypeEnglish() then
    self._ui._icon_Level:SetShow(true)
    self._ui._icon_Level:SetSpanSize(40, 0)
    self._ui._icon_AP:SetSpanSize(80, 0)
    self._ui._icon_DP:SetSpanSize(120, 0)
    self._ui._icon_AD:SetSpanSize(160, 0)
    self._ui._txt_MyLevel:SetShow(true)
    self._ui._txt_MyLevel:SetPosX(45)
    self._ui._txt_MyAp:SetPosX(85)
    self._ui._txt_MyDp:SetPosX(125)
    self._ui._txt_MyAdSum:SetPosX(165)
    self._ui._txt_MyUnLimit:SetSize(140, self._ui._txt_MyUnLimit:GetSizeY())
  else
    self._ui._icon_Level:SetShow(false)
    self._ui._icon_AP:SetSpanSize(40, 0)
    self._ui._icon_DP:SetSpanSize(80, 0)
    self._ui._icon_AD:SetSpanSize(120, 0)
    self._ui._txt_MyLevel:SetShow(false)
    self._ui._txt_MyAp:SetPosX(45)
    self._ui._txt_MyDp:SetPosX(85)
    self._ui._txt_MyAdSum:SetPosX(125)
    self._ui._txt_MyUnLimit:SetSize(110, self._ui._txt_MyUnLimit:GetSizeY())
  end
end
function PaGlobal_LocalWarInfo_All:setDescriptionString()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  if true == self._isConsole then
    return
  end
  for index = 1, self._ruleCount do
    local control = self._ui._rule._txt_content[index - 1]
    control:SetTextMode(__eTextMode_AutoWrap)
    control:SetAutoResize(true)
    control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_DESC_RULETEXT_" .. tostring(index)))
    self._maxRuleSize = self._maxRuleSize + control:GetTextSizeY()
  end
  for index = 1, self._rewardCount do
    local control = self._ui._reward._txt_content[index - 1]
    control:SetTextMode(__eTextMode_AutoWrap)
    control:SetAutoResize(true)
    control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_DESC_RULETEXT_" .. tostring(index)))
    self._maxRewardSize = self._maxRewardSize + control:GetTextSizeY()
  end
  for index = 1, self._explanationCount do
    local control = self._ui._explanation._txt_content[index - 1]
    control:SetTextMode(__eTextMode_AutoWrap)
    control:SetAutoResize(true)
    control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_DESC_EXPLANATION_" .. tostring(index)))
    self._maxExplanationSize = self._maxExplanationSize + control:GetTextSizeY()
  end
  for index = 0, #self._ui._rule._txt_content do
    self._ui._rule._txt_content[index]:SetPosX(5)
  end
  self._ui._rule._txt_content[0]:SetPosY(5)
  self._ui._rule._txt_content[1]:SetPosY(self._ui._rule._txt_content[0]:GetPosY() + self._ui._rule._txt_content[0]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[2]:SetPosY(self._ui._rule._txt_content[1]:GetPosY() + self._ui._rule._txt_content[1]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[3]:SetPosY(self._ui._rule._txt_content[2]:GetPosY() + self._ui._rule._txt_content[2]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[4]:SetPosY(self._ui._rule._txt_content[3]:GetPosY() + self._ui._rule._txt_content[3]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[5]:SetPosY(self._ui._rule._txt_content[4]:GetPosY() + self._ui._rule._txt_content[4]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[6]:SetPosY(self._ui._rule._txt_content[5]:GetPosY() + self._ui._rule._txt_content[5]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[7]:SetPosY(self._ui._rule._txt_content[6]:GetPosY() + self._ui._rule._txt_content[6]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[8]:SetPosY(self._ui._rule._txt_content[7]:GetPosY() + self._ui._rule._txt_content[7]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[9]:SetPosY(self._ui._rule._txt_content[8]:GetPosY() + self._ui._rule._txt_content[8]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[10]:SetPosY(self._ui._rule._txt_content[9]:GetPosY() + self._ui._rule._txt_content[9]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[11]:SetPosY(self._ui._rule._txt_content[10]:GetPosY() + self._ui._rule._txt_content[10]:GetTextSizeY() + 2)
  for index = 0, #self._ui._reward._txt_content do
    self._ui._reward._txt_content[index]:SetPosX(5)
  end
  self._ui._reward._txt_content[0]:SetPosY(5)
  self._ui._reward._txt_content[1]:SetPosY(self._ui._reward._txt_content[0]:GetPosY() + self._ui._reward._txt_content[0]:GetTextSizeY() + 2)
  self._ui._reward._txt_content[2]:SetPosY(self._ui._reward._txt_content[1]:GetPosY() + self._ui._reward._txt_content[1]:GetTextSizeY() + 2)
  for index = 0, #self._ui._explanation._txt_content do
    self._ui._explanation._txt_content[index]:SetPosX(5)
  end
  self._ui._explanation._txt_content[0]:SetPosY(5)
  self._ui._explanation._txt_content[1]:SetPosY(self._ui._explanation._txt_content[0]:GetPosY() + self._ui._explanation._txt_content[0]:GetTextSizeY() + 2)
  self._ui._explanation._txt_content[2]:SetPosY(self._ui._explanation._txt_content[1]:GetPosY() + self._ui._explanation._txt_content[1]:GetTextSizeY() + 2)
  self._ui._explanation._txt_content[3]:SetPosY(self._ui._explanation._txt_content[2]:GetPosY() + self._ui._explanation._txt_content[2]:GetTextSizeY() + 2)
  self._ui._explanation._txt_content[4]:SetPosY(self._ui._explanation._txt_content[3]:GetPosY() + self._ui._explanation._txt_content[3]:GetTextSizeY() + 2)
end
function PaGlobal_LocalWarInfo_All:setDescriptionSizeX()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  if true == self._isConsole then
    return
  end
  local spaceSizeX = 60
  local originTextSizeX = self._ui._rule._txt_title:GetSizeX() - spaceSizeX
  local maxSizeX = originTextSizeX
  maxSizeX = math.max(maxSizeX, self._ui._rule._txt_title:GetTextSizeX())
  maxSizeX = math.max(maxSizeX, self._ui._reward._txt_title:GetTextSizeX())
  maxSizeX = math.max(maxSizeX, self._ui._explanation._txt_title:GetTextSizeX())
  if originTextSizeX == maxSizeX then
    return
  end
  local contentSizeX = maxSizeX + spaceSizeX
  local frameSizeX = contentSizeX + 30
  local panelSizeX = self._ui._stc_leftBG:GetSizeX() + frameSizeX
  self:changeSizeX(self._ui._rule._txt_title, contentSizeX)
  self:changeSizeX(self._ui._rule._stc_background, contentSizeX)
  for index = 0, #self._ui._rule._txt_content do
    self:changeSizeX(self._ui._rule._txt_content[index], contentSizeX)
  end
  self:changeSizeX(self._ui._reward._txt_title, contentSizeX)
  self:changeSizeX(self._ui._reward._stc_background, contentSizeX)
  for index = 0, #self._ui._reward._txt_content do
    self:changeSizeX(self._ui._reward._txt_content[index], contentSizeX)
  end
  self:changeSizeX(self._ui._explanation._txt_title, contentSizeX)
  self:changeSizeX(self._ui._explanation._stc_background, contentSizeX)
  for index = 0, #self._ui._explanation._txt_content do
    self:changeSizeX(self._ui._explanation._txt_content[index], contentSizeX)
  end
  self:changeSizeX(self._ui._frame_desc, frameSizeX)
  self:changeSizeX(self._ui._stc_titleBG, panelSizeX)
  self._ui._stc_titleBG:ComputePosAllChild()
  self._ui._stc_titleBG:SetPosX(0)
  self:changeSizeX(Panel_LocalWarInfo_All, panelSizeX)
end
function PaGlobal_LocalWarInfo_All:changeSizeX(control, sizeX)
  if nil == Panel_LocalWarInfo_All then
    return
  end
  control:SetSize(sizeX, control:GetSizeY())
end
function PaGlobal_LocalWarInfo_All:setContent()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  self._ui._list2_serverList:getElementManager():clearKey()
  local localWarServerCount = ToClient_GetLocalwarStatusCount()
  if 6 < localWarServerCount then
    self._localWarServerCountLimit = 6
  else
    self._localWarServerCountLimit = ToClient_GetLocalwarStatusCount()
  end
  for index = 0, self._localWarServerCountLimit - 1 do
    self._ui._list2_serverList:getElementManager():pushKey(toInt64(0, index))
    self._ui._list2_serverList:requestUpdateByKey(toInt64(0, index))
  end
  local curChannelData = getCurrentChannelServerData()
  if nil == curChannelData then
    return
  end
  local inMyChannelInfo = ToClient_GetLocalwarStatusDataToServer(curChannelData._serverNo)
  if nil == inMyChannelInfo then
    self._ui._txt_MyLevel:SetText("")
    self._ui._txt_MyAp:SetText("")
    self._ui._txt_MyDp:SetText("")
    self._ui._txt_MyAdSum:SetText("")
    self._ui._txt_MyUnLimit:SetShow(true)
    local channelName = getChannelName(curChannelData._worldNo, curChannelData._serverNo)
    self._ui._txt_MyChannel:SetText(channelName)
    self._ui._txt_MyJoinMemberCount:SetText("0")
    self._ui._txt_MyRemainTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_WAITING"))
    self._ui._btn_MyJoin:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_CANTJOIN"))
    self._ui._btn_MyJoin:SetIgnore(true)
  else
    local getServerNo = inMyChannelInfo:getServerNo()
    local getJoinMemberCount = inMyChannelInfo:getTotalJoinCount()
    local getCurrentState = inMyChannelInfo:getState()
    local getRemainTime = inMyChannelInfo:getRemainTime()
    local warTimeMinute = math.floor(Int64toInt32(getRemainTime / toInt64(0, 60)))
    local warTimeSecond = Int64toInt32(getRemainTime) % 60
    local channelName = getChannelName(curChannelData._worldNo, getServerNo)
    local isLimitLocalWar = inMyChannelInfo:isLimitedLocalWar()
    local isWarTime = ""
    if isLimitLocalWar then
      self._ui._txt_MyUnLimit:SetShow(false)
      self._ui._txt_MyLevel:SetText(ToClient_GetLevelForLimitedLocalWar() - 1)
      self._ui._txt_MyAp:SetText(ToClient_GetAttackForLimitedLocalWar() - 1)
      self._ui._txt_MyDp:SetText(ToClient_GetDefenseForLimitedLocalWar() - 1)
      self._ui._txt_MyAdSum:SetText(ToClient_GetADSummaryForLimitedLocalWar() - 1)
    else
      self._ui._txt_MyUnLimit:SetShow(true)
      self._ui._txt_MyLevel:SetText("")
      self._ui._txt_MyAp:SetText("")
      self._ui._txt_MyDp:SetText("")
      self._ui._txt_MyAdSum:SetText("")
    end
    if 0 == getCurrentState then
      isWarTime = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_WAITING")
      self._ui._btn_MyJoin:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_JOIN"))
      self._ui._btn_MyJoin:SetIgnore(false)
    elseif 1 == getCurrentState then
      isWarTime = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_TIME", "warTimeMinute", warTimeMinute, "warTimeSecond", Int64toInt32(warTimeSecond))
      if 10 <= warTimeMinute then
        self._ui._btn_MyJoin:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_JOIN"))
        self._ui._btn_MyJoin:SetIgnore(false)
      else
        self._ui._btn_MyJoin:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_CANTJOIN"))
        self._ui._btn_MyJoin:SetIgnore(true)
      end
    elseif 2 == getCurrentState then
      isWarTime = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_TIME", "warTimeMinute", warTimeMinute, "warTimeSecond", Int64toInt32(warTimeSecond))
      self._ui._btn_MyJoin:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_CANTJOIN"))
      self._ui._btn_MyJoin:SetIgnore(true)
    elseif 3 == getCurrentState then
      isWarTime = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_FINISH")
      self._ui._btn_MyJoin:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_CANTJOIN"))
      self._ui._btn_MyJoin:SetIgnore(true)
    end
    self._ui._txt_MyChannel:SetShow(true)
    self._ui._txt_MyJoinMemberCount:SetShow(true)
    self._ui._txt_MyRemainTime:SetShow(true)
    self._ui._btn_MyJoin:SetShow(true)
    self._ui._txt_MyChannel:SetText(channelName)
    self._ui._txt_MyJoinMemberCount:SetText(getJoinMemberCount)
    self._ui._txt_MyRemainTime:SetText(isWarTime)
    self._ui._btn_MyJoin:addInputEvent("Mouse_LUp", "HandleEventLUp_LocalWarInfo_All_JoinLocalWar( nil, " .. tostring(isLimitLocalWar) .. ", true )")
  end
end
