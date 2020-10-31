function PaGlobal_Raid_All:initialize()
  if true == PaGlobal_Raid_All._initialize then
    return
  end
  PaGlobal_Raid_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Raid_All:ControlAll_Init()
  PaGlobal_Raid_All:ControlPc_Init()
  PaGlobal_Raid_All:ControlSetShow()
  PaGlobal_Raid_All:createControl()
  PaGlobal_Raid_All:registEventHandler()
  PaGlobal_Raid_All:validate()
  PaGlobal_Raid_All._initialize = true
end
function PaGlobal_Raid_All:ControlAll_Init()
  if nil == Panel_Widget_Raid_All then
    return
  end
  self._ui.stc_raidBg = UI.getChildControl(Panel_Widget_Raid_All, "Static_RaidBG")
  self._ui.txt_charInfo = UI.getChildControl(self._ui.stc_raidBg, "StaticText_CharacterInfo")
  self._ui.stc_hpBg = UI.getChildControl(self._ui.stc_raidBg, "Static_HpBG")
  self._ui.progress_hp = UI.getChildControl(self._ui.stc_raidBg, "Progress2_Hp")
  self._ui.stc_deadBg = UI.getChildControl(self._ui.stc_raidBg, "Static_DeadConditionBG")
end
function PaGlobal_Raid_All:ControlPc_Init()
  if nil == Panel_Widget_Raid_All then
    return
  end
  self._ui_pc.btn_orderIcon = UI.getChildControl(self._ui.stc_raidBg, "Button_Order")
  self._ui_pc.btn_leave = UI.getChildControl(Panel_Widget_Raid_All, "Button_Leave")
  self._ui_pc.btn_ordersBg = UI.getChildControl(Panel_Widget_Raid_All, "Static_ButtonBG1")
  self._ui_pc.btn_setLeader = UI.getChildControl(self._ui_pc.btn_ordersBg, "Button_SetLeader")
  self._ui_pc.btn_forceOut = UI.getChildControl(self._ui_pc.btn_ordersBg, "Button_ForceOut")
end
function PaGlobal_Raid_All:createControl()
  if nil == Panel_Widget_Raid_All then
    return
  end
  self._ui.stc_raidBg:SetShow(false)
  for index = 1, self._maxPartyMemberCount do
    local raidMember = {}
    raidMember._base = UI.cloneControl(self._ui.stc_raidBg, Panel_Widget_Raid_All, "Static_RaidMember_" .. index)
    raidMember._name = UI.getChildControl(raidMember._base, "StaticText_CharacterInfo")
    raidMember._hpBG = UI.getChildControl(raidMember._base, "Static_HpBG")
    raidMember._hp = UI.getChildControl(raidMember._base, "Progress2_Hp")
    raidMember._actionBtn = UI.getChildControl(raidMember._base, "Button_Order")
    raidMember._deadConditionBG = UI.getChildControl(raidMember._base, "Static_DeadConditionBG")
    raidMember._platformIcon = UI.getChildControl(raidMember._base, "Static_CrossPlay")
    raidMember._name:SetTextMode(__eTextMode_LimitText)
    if index < 11 then
      raidMember._base:SetPosY((index - 1) * (self._ui.stc_raidBg:GetSizeY() + 10))
    else
      raidMember._base:SetPosX(self._ui.stc_raidBg:GetPosX() + self._ui.stc_raidBg:GetSizeX() + 25)
      raidMember._base:SetPosY((index - 11) * (self._ui.stc_raidBg:GetSizeY() + 10))
    end
    raidMember._base:SetShow(false)
    raidMember._actionBtn:SetShow(false)
    raidMember._base:addInputEvent("Mouse_On", "HanldeEventOnOut_Widget_Raid_All_ButtonAction(true," .. index .. ")")
    raidMember._base:addInputEvent("Mouse_Out", "HanldeEventOnOut_Widget_Raid_All_ButtonAction(false," .. index .. ")")
    raidMember._base:addInputEvent("Mouse_LUp", "HanldeEventLUp_Widget_Raid_All_ClickButtonAction(" .. index .. ")")
    self._uiPartyMemberList[index] = raidMember
  end
end
function PaGlobal_Raid_All:ControlSetShow()
end
function PaGlobal_Raid_All:prepareOpen()
  if nil == Panel_Widget_Raid_All then
    return
  end
  self._ui_pc.btn_leave:SetShow(false)
  self._ui_pc.btn_ordersBg:SetShow(false)
  PaGlobal_Raid_All:open()
  PaGlobal_Raid_All:resize()
end
function PaGlobal_Raid_All:open()
  if nil == Panel_Widget_Raid_All then
    return
  end
  Panel_Widget_Raid_All:SetShow(true)
end
function PaGlobal_Raid_All:prepareClose()
  if nil == Panel_Widget_Raid_All then
    return
  end
  self._ui_pc.btn_ordersBg:SetShow(false)
  PaGlobal_Raid_All:close()
end
function PaGlobal_Raid_All:close()
  if nil == Panel_Widget_Raid_All then
    return
  end
  Panel_Widget_Raid_All:SetShow(false)
end
function PaGlobal_Raid_All:registEventHandler()
  if nil == Panel_Widget_Raid_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Widget_Raid_All_ScreenResize")
  registerEvent("FromClient_ApplyUISettingPanelInfo", "FromClient_Widget_Raid_All_ScreenResize")
  registerEvent("FromClient_GroundMouseClick", "FromClient_Widget_Raid_All_HideOption")
  self._ui_pc.btn_setLeader:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_Raid_All_ChangeLeader()")
  self._ui_pc.btn_forceOut:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_Raid_All_BanishMember()")
  self._ui_pc.btn_leave:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_Raid_All_ExitParty()")
end
function PaGlobal_Raid_All:resize()
  if 0 == RequestParty_getPartyMemberCount() then
    PaGlobal_Raid_All:prepareClose()
  end
  if Panel_Widget_Raid_All:GetRelativePosX() == -1 or Panel_Widget_Raid_All:GetRelativePosY() == -1 then
    local initPosX = 10
    local initPosY = 200
    changePositionBySever(Panel_Widget_Raid_All, CppEnums.PAGameUIType.PAGameUIPanel_LargeParty, false, true, false)
    FGlobal_InitPanelRelativePos(Panel_Widget_Raid_All, initPosX, initPosY)
  elseif Panel_Widget_Raid_All:GetRelativePosX() == 0 or Panel_Widget_Raid_All:GetRelativePosY() == 0 then
    Panel_Widget_Raid_All:SetPosX(10)
    Panel_Widget_Raid_All:SetPosY(200)
  else
    Panel_Widget_Raid_All:SetPosX(getScreenSizeX() * Panel_Widget_Raid_All:GetRelativePosX() - Panel_Widget_Raid_All:GetSizeX() / 2)
    Panel_Widget_Raid_All:SetPosY(getScreenSizeY() * Panel_Widget_Raid_All:GetRelativePosY() - Panel_Widget_Raid_All:GetSizeY() / 2)
  end
  if true == _ContentsGroup_RenewUI then
    if true == PaGlobalFunc_TopIcon_GetShowAllCheck() then
      Panel_Widget_Raid_All:SetPosY(PaGlobalFunc_TopIcon_GetPartyWidgetPosY() + 20)
    else
      Panel_Widget_Raid_All:SetPosY(PaGlobalFunc_TopIcon_GetPartyWidgetPosY() - 50)
    end
  end
  FGlobal_PanelRepostionbyScreenOut(Panel_Widget_Raid_All)
end
function PaGlobal_Raid_All:validate()
  if nil == Panel_Widget_Raid_All then
    return
  end
  self._ui.stc_raidBg:isValidate()
  self._ui.txt_charInfo:isValidate()
  self._ui.stc_hpBg:isValidate()
  self._ui.progress_hp:isValidate()
  self._ui.stc_deadBg:isValidate()
  self._ui_pc.btn_orderIcon:isValidate()
  self._ui_pc.btn_leave:isValidate()
  self._ui_pc.btn_ordersBg:isValidate()
  self._ui_pc.btn_setLeader:isValidate()
  self._ui_pc.btn_forceOut:isValidate()
end
function PaGlobal_Raid_All:limitTextTooptip(isShow, index)
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(self._uiPartyMemberList[index]._name, self._uiPartyMemberList[index]._name:GetText())
end
function PaGlobal_Raid_All:update()
  if nil == Panel_Widget_Raid_All then
    return
  end
  if false == self._initialize then
    return
  end
  self._isMaster = false
  self._partyMemberCount = RequestParty_getPartyMemberCount()
  if 0 == self._partyMemberCount then
    PaGlobal_Raid_All:prepareClose()
    return
  end
  self._partyMemberData = {}
  self._partyMemberData = PaGlobalFunc_Widget_Party_All_SetMemberData(self._partyMemberCount)
  if nil == self._partyMemberData[1] then
    PaGlobal_Raid_All:prepareClose()
    return
  end
  for index = 1, self._maxPartyMemberCount do
    if nil == self._uiPartyMemberList[index] then
      return
    end
    self._uiPartyMemberList[index]._base:SetShow(false)
    if index <= self._partyMemberCount then
      PaGlobal_Raid_All:setInfo(index)
      self._uiPartyMemberList[index]._base:SetShow(true)
      local colorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
      if 1 <= colorBlindMode then
        self._uiPartyMemberList[index]._hp:ChangeTextureInfoName("Combine/Progress/Combine_Progress_ColorBlind_00.dds")
        local xx1, yy1, xx2, yy2 = setTextureUV_Func(self._uiPartyMemberList[index]._hp, 329, 415, 462, 426)
        self._uiPartyMemberList[index]._hp:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
        self._uiPartyMemberList[index]._hp:setRenderTexture(self._uiPartyMemberList[index]._hp:getBaseTexture())
      else
        self._uiPartyMemberList[index]._hp:ChangeTextureInfoName("Renewal/Progress/console_progressbar_03.dds")
        local xx1, yy1, xx2, yy2 = setTextureUV_Func(self._uiPartyMemberList[index]._hp, 329, 415, 462, 426)
        self._uiPartyMemberList[index]._hp:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
        self._uiPartyMemberList[index]._hp:setRenderTexture(self._uiPartyMemberList[index]._hp:getBaseTexture())
      end
    end
  end
end
function PaGlobal_Raid_All:setInfo(index)
  if nil == Panel_Widget_Raid_All then
    return
  end
  self._uiPartyMemberList[index]._name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. self._partyMemberData[index]._level .. " " .. self._partyMemberData[index]._name)
  self._uiPartyMemberList[index]._hp:SetProgressRate(self._partyMemberData[index]._currentHp / self._partyMemberData[index]._maxHp)
  if self._uiPartyMemberList[index]._name:IsLimitText() then
    self._uiPartyMemberList[index]._name:SetIgnore(false)
    self._uiPartyMemberList[index]._name:addInputEvent("Mouse_On", "HandleEventOnOut_Widget_Raid_All_LimitTextTooptip(true, " .. index .. ")")
    self._uiPartyMemberList[index]._name:addInputEvent("Mouse_Out", "HandleEventOnOut_Widget_Raid_All_LimitTextTooptip(false, " .. index .. ")")
  end
  if true == self._partyMemberData[index]._isSelf and true == self._partyMemberData[index]._isMaster then
    self._isMaster = true
  end
  if self._partyMemberData[index]._isMaster then
    self._uiPartyMemberList[index]._name:SetFontColor(Defines.Color.C_FFA3EF00)
  else
    self._uiPartyMemberList[index]._name:SetFontColor(Defines.Color.C_FFFFFFFF)
  end
  local isDead = self._partyMemberData[index]._currentHp <= 0
  self._uiPartyMemberList[index]._hpBG:SetShow(not isDead)
  self._uiPartyMemberList[index]._deadConditionBG:SetShow(isDead)
  self._uiPartyMemberList[index]._base:SetShow(true)
  self._uiPartyMemberList[index]._name:SetShow(true)
  self._uiPartyMemberList[index]._hp:SetShow(true)
  if true == ToClient_isTotalGameClient() then
    PaGlobal_Raid_All:setCrossPlayIcon(self._uiPartyMemberList[index]._platformIcon, self._partyMemberData[index]._platformType)
  end
end
function PaGlobal_Raid_All:showButtonAction(isShow, index)
  if nil == Panel_Widget_Raid_All then
    return
  end
  if self._uiPartyMemberList[index]._actionBtn:GetShow() and index == self._selectIndex then
    return
  end
  if isShow and (true == self._isMaster or true == self._partyMemberData[index]._isSelf) then
    local memberCount = RequestParty_getPartyMemberCount()
    for count = 1, memberCount do
      if count == index then
        self._uiPartyMemberList[count]._actionBtn:SetShow(true)
      else
        self._uiPartyMemberList[count]._actionBtn:SetShow(false)
        self._ui_pc.btn_leave:SetShow(false)
        self._ui_pc.btn_ordersBg:SetShow(false)
      end
    end
  else
    self._uiPartyMemberList[index]._actionBtn:SetShow(false)
  end
end
function PaGlobal_Raid_All:clickButtonAction(index)
  if self._ui_pc.btn_leave:GetShow() or self._ui_pc.btn_ordersBg:GetShow() then
    self._ui_pc.btn_leave:SetShow(false)
    self._ui_pc.btn_ordersBg:SetShow(false)
  end
  if self._selectIndex == self._partyMemberData[index]._index then
    self._ui_pc.btn_leave:SetShow(false)
    self._ui_pc.btn_ordersBg:SetShow(false)
    self._selectIndex = -1
    return
  end
  self._ui_pc.btn_leave:SetPosX(self._uiPartyMemberList[index]._base:GetPosX() + self._uiPartyMemberList[index]._base:GetSizeX() + 5)
  self._ui_pc.btn_ordersBg:SetPosX(self._uiPartyMemberList[index]._base:GetPosX() + self._uiPartyMemberList[index]._base:GetSizeX() + 5)
  self._ui_pc.btn_leave:SetPosY(self._uiPartyMemberList[index]._base:GetPosY())
  self._ui_pc.btn_ordersBg:SetPosY(self._uiPartyMemberList[index]._base:GetPosY())
  if false == self._partyMemberData[index]._isSelf and true == self._isMaster then
    self._ui_pc.btn_ordersBg:SetShow(true)
  elseif true == self._partyMemberData[index]._isSelf then
    self._ui_pc.btn_leave:SetShow(true)
  else
    self._ui_pc.btn_leave:SetShow(false)
    self._ui_pc.btn_ordersBg:SetShow(false)
  end
  Panel_Widget_Raid_All:SetChildIndex(self._ui_pc.btn_leave, 9999)
  Panel_Widget_Raid_All:SetChildIndex(self._ui_pc.btn_ordersBg, 9998)
  self._selectIndex = self._partyMemberData[index]._index
end
function PaGlobal_Raid_All:changeLeader()
  if -1 == self._selectIndex or nil == self._selectIndex then
    return
  end
  RequestParty_changeLeader(self._selectIndex)
  self._ui_pc.btn_leave:SetShow(false)
  self._ui_pc.btn_ordersBg:SetShow(false)
  PaGlobal_Raid_All:update()
end
function PaGlobal_Raid_All:banishMember()
  local withdrawMemberData = RequestParty_getPartyMemberAt(self._selectIndex)
  if nil == withdrawMemberData then
    return
  end
  local withdrawMemberActorKey = withdrawMemberData:getActorKey()
  local withdrawMemberPlayerActor = getPlayerActor(withdrawMemberActorKey)
  local partyType = ToClient_GetPartyType()
  local function messageBox_party_BanishMember()
    RequestParty_withdrawMember(self._selectIndex)
    self._ui_pc.btn_leave:SetShow(false)
    self._ui_pc.btn_ordersBg:SetShow(false)
    PaGlobal_Raid_All:update()
  end
  local contentString = ""
  local titleForceOut = ""
  if 0 == partyType then
    contentString = withdrawMemberData:name() .. PAGetString(Defines.StringSheet_GAME, "PANEL_PARTY_FORCEOUT_QUESTION")
    titleForceOut = PAGetString(Defines.StringSheet_GAME, "PANEL_PARTY_FORCEOUT")
  else
    contentString = withdrawMemberData:name() .. PAGetString(Defines.StringSheet_GAME, "PANEL_LARGEPARTY_FORCEOUT_QUESTION")
    titleForceOut = PAGetString(Defines.StringSheet_GAME, "PANEL_LARGEPARTY_FORCEOUT")
  end
  local messageboxData = {
    title = titleForceOut,
    content = contentString,
    functionYes = messageBox_party_BanishMember,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_Raid_All:exitParty()
  local isPlayingPvPMatch = getSelfPlayer():isDefinedPvPMatch()
  if true == isPlayingPvPMatch then
    RequestParty_withdrawMember(self._selectIndex)
    return
  end
  local function partyOut()
    RequestParty_withdrawMember(self._selectIndex)
    PaGlobal_Raid_All:prepareClose()
  end
  local partyType = ToClient_GetPartyType()
  local messageBoxMemo = ""
  if 0 == partyType then
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_DISTRIBUTION_GETOUTPARTY")
  else
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_LARGEPARTY_DISTRIBUTION_GETOUTPARTY")
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = partyOut,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
  PaGlobal_Raid_All:update()
end
function PaGlobal_Raid_All:setCrossPlayIcon(targetControl, platformType)
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
