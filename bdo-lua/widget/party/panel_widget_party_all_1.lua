function PaGlobal_Party_All:initialize()
  if true == PaGlobal_Party_All._initialize then
    return
  end
  PaGlobal_Party_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Party_All:ControlAll_Init()
  PaGlobal_Party_All:ControlPc_Init()
  PaGlobal_Party_All:createControl()
  PaGlobal_Party_All:initData()
  PaGlobal_Party_All:setPositionByServer()
  PaGlobal_Party_All:ControlSetShow()
  PaGlobal_Party_All:registEventHandler()
  PaGlobal_Party_All:validate()
  PaGlobal_Party_All._initialize = true
end
function PaGlobal_Party_All:ControlAll_Init()
  if nil == Panel_Widget_Party_All then
    return
  end
  Panel_Widget_Party_All:ActiveMouseEventEffect(true)
  PaGlobal_Party_All:setPositionByServer()
  self._ui.stc_memberTemplate = UI.getChildControl(Panel_Widget_Party_All, "Static_PartyMember_Template")
end
function PaGlobal_Party_All:ControlPc_Init()
  if nil == Panel_Widget_Party_All then
    return
  end
  self._ui_pc.stc_OptionBg = UI.getChildControl(Panel_Widget_Party_All, "Static_OptionBg")
  self._ui_pc.btn_specialItem = UI.getChildControl(self._ui_pc.stc_OptionBg, "Button_SpecialItem")
  self._ui_pc.btn_marketOption = UI.getChildControl(self._ui_pc.stc_OptionBg, "Button_MarketOption")
  self._ui_pc.chk_dropItem = UI.getChildControl(self._ui_pc.stc_OptionBg, "CheckButton_DropItem")
  self._ui_pc.stc_dropSetBg = UI.getChildControl(self._ui_pc.stc_OptionBg, "Static_StettingBG")
  self._ui_pc.radio_free = UI.getChildControl(self._ui_pc.stc_dropSetBg, "RadioButton_Free")
  self._ui_pc.radio_turn = UI.getChildControl(self._ui_pc.stc_dropSetBg, "RadioButton_Turn")
  self._ui_pc.radio_rando = UI.getChildControl(self._ui_pc.stc_dropSetBg, "RadioButton_Random")
  self._ui_pc.radio_onlyLeader = UI.getChildControl(self._ui_pc.stc_dropSetBg, "RadioButton_Leader")
  self._ui_pc.radio_free:SetTextMode(__eTextMode_AutoWrap)
  self._ui_pc.radio_turn:SetTextMode(__eTextMode_AutoWrap)
  self._ui_pc.radio_rando:SetTextMode(__eTextMode_AutoWrap)
  self._ui_pc.radio_onlyLeader:SetTextMode(__eTextMode_AutoWrap)
  self._ui_pc.radio_free:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_FREE"))
  self._ui_pc.radio_turn:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_TURN"))
  self._ui_pc.radio_rando:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_RANDOM"))
  self._ui_pc.radio_onlyLeader:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_LEADERONLY"))
  self._ui_pc.stc_marketOptionBg = UI.getChildControl(Panel_Widget_Party_All, "Static_MarketOptionBg")
  self._ui_pc.stc_mainBg = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "Static_MainBG")
  self._ui_pc.btn_apply = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "Button_Admin")
  self._ui_pc.txt_marketOptionTitle = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "StaticText_Title")
  self._ui_pc.btn_close = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "Button_Close")
  self._ui_pc.txt_minCostTitle = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "StaticText_Title_MinCost")
  self._ui_pc.txt_minCostValue = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "StaticText_Value_MinCost")
  self._ui_pc.txt_minGradeTitle = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "StaticText_Title_Grade")
  self._ui_pc.txt_minGradeValue = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "StaticText_Value_Grade")
  self._ui_pc.btn_minCost = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "Button_MinCost")
  self._ui_pc.btn_Grade = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "Button_Grade")
  self._ui_pc.chk_minCost = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "CheckButton_MinCost")
  self._ui_pc.chk_grade = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "CheckButton_Grade")
  self._ui_pc.stc_gradeOptionBg = UI.getChildControl(self._ui_pc.stc_marketOptionBg, "Static_StettingBG")
  self._ui_pc.btn_grades[0] = UI.getChildControl(self._ui_pc.stc_gradeOptionBg, "Button_NoSet")
  self._ui_pc.btn_grades[1] = UI.getChildControl(self._ui_pc.stc_gradeOptionBg, "Button_Green")
  self._ui_pc.btn_grades[2] = UI.getChildControl(self._ui_pc.stc_gradeOptionBg, "Button_Blue")
  self._ui_pc.btn_grades[3] = UI.getChildControl(self._ui_pc.stc_gradeOptionBg, "Button_Yellow")
  self._ui_pc.btn_grades[4] = UI.getChildControl(self._ui_pc.stc_gradeOptionBg, "Button_Orenge")
  UI.setLimitTextAndAddTooltip(self._ui_pc.txt_minCostTitle)
  UI.setLimitTextAndAddTooltip(self._ui_pc.txt_minGradeTitle)
end
function PaGlobal_Party_All:createControl()
  if nil == Panel_Widget_Party_All then
    return
  end
  self._ui.stc_memberTemplate:SetShow(false)
  local startPosY = self._ui.stc_memberTemplate:GetPosY()
  for index = 1, self._config.maxPartyCnt do
    local info = {}
    info.control = UI.cloneControl(self._ui.stc_memberTemplate, Panel_Widget_Party_All, "Static_PartyMember_" .. index)
    info.control:SetPosY(startPosY + (info.control:GetSizeY() + self._config.gapY) * index)
    info._stc_progressBg = UI.getChildControl(info.control, "Static_ProgressBg")
    info._progress_hp = UI.getChildControl(info.control, "Progress2_Hp")
    info._progress_mp = UI.getChildControl(info.control, "Progress2_Mp")
    info._stc_classIconBg = UI.getChildControl(info.control, "Static_ClassIconBg")
    info._stc_classIconLeaderBg = UI.getChildControl(info.control, "Static_ClassIconLeaderBg")
    info._stc_classIcon = UI.getChildControl(info.control, "Static_ClassIcon")
    info._txt_level = UI.getChildControl(info.control, "StaticText_CharacterLevelValue")
    info._txt_name = UI.getChildControl(info.control, "StaticText_CharacterNameValue")
    info._stc_deadState = UI.getChildControl(info.control, "Static_DeadState")
    info._stc_distanceWifi = UI.getChildControl(info.control, "Static_DistanceWifi")
    info._stc_rootInfo = UI.getChildControl(info.control, "Static_RootInfoIcon")
    info._stc_follow = UI.getChildControl(info.control, "Static_Follow")
    info._btn_option = UI.getChildControl(info.control, "Button_Option")
    info._btn_leave = UI.getChildControl(info.control, "Button_Leave")
    info._stc_setMemberBg = UI.getChildControl(info.control, "Static_ButtonBG1")
    info._btn_setLeader = UI.getChildControl(info._stc_setMemberBg, "Button_SetLeader")
    info._btn_forceOut = UI.getChildControl(info._stc_setMemberBg, "Button_ForceOut")
    info._stc_platformIcon = UI.getChildControl(info.control, "Static_CrossPlay")
    info._btn_leave:SetTextMode(__eTextMode_AutoWrap)
    info._btn_setLeader:SetTextMode(__eTextMode_AutoWrap)
    info._btn_forceOut:SetTextMode(__eTextMode_AutoWrap)
    info._btn_leave:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_LEAVE"))
    info._btn_setLeader:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_AUTORIZE"))
    info._btn_forceOut:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_KICKOUT"))
    local colorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
    if 1 <= colorBlindMode then
      info._progress_hp:ChangeTextureInfoName("Combine/Progress/Combine_Progress_ColorBlind_00.dds")
      local xx1, yy1, xx2, yy2 = setTextureUV_Func(info._progress_hp, 330, 273, 508, 282)
      info._progress_hp:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
      info._progress_hp:setRenderTexture(info._progress_hp:getBaseTexture())
      info._progress_mp:ChangeTextureInfoName("Combine/Progress/Combine_Progress_ColorBlind_00.dds")
      local xx1, yy1, xx2, yy2 = setTextureUV_Func(info._progress_mp, 331, 290, 504, 294)
      info._progress_mp:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
      info._progress_mp:setRenderTexture(info._progress_mp:getBaseTexture())
    end
    self._ui.stc_members[index] = info
  end
end
function PaGlobal_Party_All:initData()
  self._isMainChannel = getCurrentChannelServerData()._isMain
  self._isDevServer = ToClient_IsDevelopment()
  self._partyInfo.partyMemCnt = 0
  self._partyData = {}
end
function PaGlobal_Party_All:resetData()
  if nil == self._initialize or false == self._initialize then
    return
  end
  self._partyInfo.partyType = ToClient_GetPartyType()
  self._refuseName = nil
  self._withdrawMember = nil
  self._partyInfo.partyMemCnt = RequestParty_getPartyMemberCount()
  self._partyData = {}
  self._ui_pc.stc_marketOptionBg:SetShow(false)
  self._ui_pc.stc_dropSetBg:SetShow(false)
  self:showLootingType()
  self._ui_pc.chk_minCost:SetCheck(false)
  self._ui_pc.chk_grade:SetCheck(false)
  self._currentMoney = self._config.baseMoney
  self._ui_pc.txt_minCostValue:SetText("<PAColor0xffe7d583>" .. makeDotMoney(self._currentMoney) .. "<PAOldColor>")
  self._firstCheck = 0
  self._lastSelectUser = nil
  self._inviteReqList = {}
  self._preLootType = nil
  self._prevPrice = nil
  self._prevGrade = nil
end
function PaGlobal_Party_All:setPositionByServer()
  if nil == Panel_Widget_Party_All then
    return
  end
  changePositionBySever(Panel_Widget_Party_All, CppEnums.PAGameUIType.PAGameUIPanel_Party, false, true, false)
end
function PaGlobal_Party_All:ControlSetShow()
  if nil == Panel_Widget_Party_All then
    return
  end
  if true == self._isConsole then
    self._ui_pc.stc_gradeOptionBg:SetShow(false)
    self._ui_pc.stc_OptionBg:SetShow(false)
  else
    self._ui_pc.stc_OptionBg:SetShow(true)
  end
end
function PaGlobal_Party_All:prepareOpen()
  if nil == Panel_Widget_Party_All then
    return
  end
  if true == Panel_Widget_Party_All:GetShow() then
    return
  end
  PaGlobal_Party_All:open()
  PaGlobal_Party_All:update()
  PaGlobal_Party_All:resize()
end
function PaGlobal_Party_All:open()
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_OthilitaDungeon) then
    return
  elseif true == _ContentsGroup_OthilitaDungeon and nil ~= Panel_Widget_ThornCastle_Member then
    PaGlobal_ThornCastle_Member:prepareClose()
  end
  if nil == Panel_Widget_Party_All then
    return
  end
  Panel_Widget_Party_All:SetShow(true)
  PaGlobal_Party_All:ControlSetShow()
end
function PaGlobal_Party_All:prepareClose()
  if nil == Panel_Widget_Party_All then
    return
  end
  self._ui_pc.stc_OptionBg:SetShow(false)
  self._ui_pc.stc_gradeOptionBg:SetShow(false)
  PaGlobal_Party_All:close()
end
function PaGlobal_Party_All:close()
  if nil == Panel_Widget_Party_All then
    return
  end
  Panel_Widget_Party_All:SetShow(false)
end
function PaGlobal_Party_All:update()
  if nil == Panel_Widget_Party_All then
    return
  end
  PaGlobal_Party_All:createPartyList()
  PaGlobal_Party_All:updatePartyList()
end
function PaGlobal_Party_All:registEventHandler()
  if nil == Panel_Widget_Party_All then
    return
  end
  Panel_Widget_Party_All:addInputEvent("Mouse_LUp", "ResetPos_WidgetButton()")
  registerEvent("ResponseParty_createPartyList", "FromClient_Party_All_createPartyList")
  registerEvent("ResponseParty_updatePartyList", "FromClient_Party_All_updatePartyList")
  registerEvent("ResponseParty_invite", "FromClient_Party_All_Invite")
  registerEvent("ResponseParty_refuse", "FromClient_Party_All_Refuse")
  registerEvent("ResponseParty_changeLeader", "FromClient_Party_All_ChangeLeader")
  registerEvent("ResponseParty_withdraw", "FromClient_Party_All_Withdraw")
  registerEvent("FromClient_GroundMouseClick", "FromClient_Party_All_PartyOption_Hide")
  registerEvent("onScreenResize", "FromClient_Party_All_OnScreenResize")
  registerEvent("FromClient_ApplyUISettingPanelInfo", "FromClient_Party_All_OnScreenResize")
  registerEvent("FromClient_NotifyPartyMemberPickupItem", "FromClient_Party_All_NotifyPartyMemberPickupItem")
  registerEvent("FromClient_NotifyPartyMemberPickupItemFromPartyInventory", "FromClient_Party_All_NotifyPartyMemberPickupItemFromPartyInventory")
  registerEvent("FromClient_RenderModeChangeState", "FromClient_Party_All_RenderModeChange")
  for index = 1, self._config.maxPartyCnt do
    local control = self._ui.stc_members[index]
    control._stc_follow:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_SelectPartyFollow(" .. index .. ")")
    control._stc_follow:addInputEvent("Mouse_On", "HandleEventOnOut_Party_All_ShowSimpleTooltip(true, 0, " .. index .. ")")
    control._stc_follow:addInputEvent("Mouse_Out", "HandleEventOnOut_Party_All_ShowSimpleTooltip(false, 0, " .. index .. ")")
    control._stc_distanceWifi:addInputEvent("Mouse_On", "HandleEventOnOut_Party_All_ShowSimpleTooltip(true, 1, " .. index .. ")")
    control._stc_distanceWifi:addInputEvent("Mouse_Out", "HandleEventOnOut_Party_All_ShowSimpleTooltip(false, 1, " .. index .. ")")
    control._btn_option:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_SelectPartyOption(" .. index .. ")")
    control._stc_rootInfo:addInputEvent("Mouse_On", "HandleEventOnOut_Party_All_ShowSimpleTooltip(true, 4, " .. index .. ")")
    control._stc_rootInfo:addInputEvent("Mouse_Out", "HandleEventOnOut_Party_All_ShowSimpleTooltip(false, 4, " .. index .. ")")
  end
  self._ui_pc.btn_marketOption:addInputEvent("Mouse_On", "HandleEventOnOut_Party_All_ShowSepcialGoodsToolTip( 1, true )")
  self._ui_pc.btn_marketOption:addInputEvent("Mouse_Out", "HandleEventOnOut_Party_All_ShowSepcialGoodsToolTip( 1, false )")
  self._ui_pc.btn_marketOption:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_ShowMarketOptionToggle()")
  self._ui_pc.radio_free:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_SelectLootingType(" .. CppEnums.PartyLootType.LootType_Free .. ")")
  self._ui_pc.radio_turn:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_SelectLootingType(" .. CppEnums.PartyLootType.LootType_Shuffle .. ")")
  self._ui_pc.radio_rando:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_SelectLootingType(" .. CppEnums.PartyLootType.LootType_Random .. ")")
  self._ui_pc.radio_onlyLeader:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_SelectLootingType(" .. CppEnums.PartyLootType.LootType_Master .. ")")
  self._ui_pc.chk_dropItem:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_SetLootingOption()")
  self._ui_pc.btn_Grade:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_ShowGradeListToggle()")
  self._ui_pc.btn_minCost:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_ChangeMoney()")
  self._ui_pc.btn_apply:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_SetRegistItem()")
  self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_ShowMarketOptionToggle(false)")
  for index = 0, #self._ui_pc.btn_grades do
    local control = self._ui_pc.btn_grades[index]
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_SetGrade(" .. index .. ")")
  end
end
function PaGlobal_Party_All:validate()
  if nil == Panel_Widget_Party_All then
    return
  end
  self._ui_pc.stc_OptionBg:isValidate()
  self._ui_pc.btn_specialItem:isValidate()
  self._ui_pc.btn_marketOption:isValidate()
  self._ui_pc.chk_dropItem:isValidate()
  self._ui_pc.stc_dropSetBg:isValidate()
  self._ui_pc.radio_free:isValidate()
  self._ui_pc.radio_turn:isValidate()
  self._ui_pc.radio_rando:isValidate()
  self._ui_pc.radio_onlyLeader:isValidate()
  self._ui_pc.stc_marketOptionBg:isValidate()
  self._ui_pc.stc_mainBg:isValidate()
  self._ui_pc.btn_apply:isValidate()
  self._ui_pc.txt_marketOptionTitle:isValidate()
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.txt_minCostTitle:isValidate()
  self._ui_pc.txt_minCostValue:isValidate()
  self._ui_pc.txt_minGradeTitle:isValidate()
  self._ui_pc.txt_minGradeValue:isValidate()
  self._ui_pc.btn_minCost:isValidate()
  self._ui_pc.btn_Grade:isValidate()
  self._ui_pc.stc_gradeOptionBg:isValidate()
  self._ui_pc.btn_grades[0]:isValidate()
  self._ui_pc.btn_grades[1]:isValidate()
  self._ui_pc.btn_grades[2]:isValidate()
  self._ui_pc.btn_grades[3]:isValidate()
  self._ui_pc.btn_grades[4]:isValidate()
end
function PaGlobal_Party_All:onScreenSize()
  if nil == self._initialize or false == self._initialize then
    return
  end
  if 0 == RequestParty_getPartyMemberCount() then
    PaGlobal_Party_All:resetData()
    PaGlobal_Party_All:prepareClose()
  else
    if not isFlushedUI() and nil ~= Panel_Widget_Arsha_Party_All and false == Panel_Widget_Arsha_Party_All:GetShow() then
      PaGlobalFunc_Widget_Party_All_Open()
    end
    PaGlobal_Party_All:updatePartyList()
  end
  PaGlobal_Party_All:resize()
end
function PaGlobal_Party_All:resize()
  if nil == self._initialize or false == self._initialize then
    return
  end
  local initPosX = 10
  local initPosY = 200
  if nil ~= PaGlobal_AreaOfHadum_IsDefaultPos and true == PaGlobal_AreaOfHadum_IsDefaultPos() and nil ~= Panel_Widget_AreaOfHadum and true == Panel_Widget_AreaOfHadum:GetShow() then
    initPosY = Panel_Widget_AreaOfHadum:GetPosY() + Panel_Widget_AreaOfHadum:GetSizeY() + 10
  end
  if Panel_Widget_Party_All:GetRelativePosX() == -1 or Panel_Widget_Party_All:GetRelativePosY() == -1 then
    changePositionBySever(Panel_Widget_Party_All, CppEnums.PAGameUIType.PAGameUIPanel_Party, false, true, false)
    FGlobal_InitPanelRelativePos(Panel_Widget_Party_All, initPosX, initPosY)
  elseif Panel_Widget_Party_All:GetRelativePosX() == 0 or Panel_Widget_Party_All:GetRelativePosY() == 0 then
    Panel_Widget_Party_All:SetPosX(initPosX)
    Panel_Widget_Party_All:SetPosY(initPosY)
  else
    Panel_Widget_Party_All:SetPosX(getScreenSizeX() * Panel_Widget_Party_All:GetRelativePosX() - Panel_Widget_Party_All:GetSizeX() / 2)
    Panel_Widget_Party_All:SetPosY(getScreenSizeY() * Panel_Widget_Party_All:GetRelativePosY() - Panel_Widget_Party_All:GetSizeY() / 2)
  end
  if true == _ContentsGroup_RenewUI then
    if true == PaGlobalFunc_TopIcon_GetShowAllCheck() then
      Panel_Widget_Party_All:SetPosY(PaGlobalFunc_TopIcon_GetPartyWidgetPosY() - self._ui_pc.stc_OptionBg:GetSizeY() + 20)
    else
      Panel_Widget_Party_All:SetPosY(PaGlobalFunc_TopIcon_GetPartyWidgetPosY() - self._ui_pc.stc_OptionBg:GetSizeY() - 50)
    end
  end
  self._ui_pc.stc_OptionBg:ComputePos()
  FGlobal_PanelRepostionbyScreenOut(Panel_Widget_Party_All)
end
function PaGlobal_Party_All:renderModeChange(prevRenderModeList, nextRenderModeList)
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  if 0 == RequestParty_getPartyMemberCount() then
    self:resetData()
    self:prepareClose()
  else
    PaGlobalFunc_Widget_Party_All_Open()
  end
end
function PaGlobal_Party_All:showSpecialGoodsTooltip(btnType, isShow)
  local itemCount = ToClient_requestGetMySellInfoCount()
  local msg = ""
  local control
  if 1 == btnType then
    local grade = RequestParty_getDistributionGrade()
    local price = RequestParty_getDistributionPrice()
    control = self._ui_pc.btn_marketOption
    if 0 < Int64toInt32(price) then
      if 0 < grade and grade < 5 then
        msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PARTY_DISTRIBUTION_HIGHSILVER", "getDistributionPrice", makeDotMoney(price)) .. ", " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PARTY_DISTRIBUTION_HIGHGRADE", "getDistributionGrade", self._itemGradeString[grade])
      else
        msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PARTY_DISTRIBUTION_HIGHSILVER", "getDistributionPrice", makeDotMoney(price))
      end
    elseif 0 < grade and grade < 5 then
      msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PARTY_DISTRIBUTION_HIGHGRADE2", "getDistributionGrade", self._itemGradeString[grade])
    else
      msg = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_DISTRIBUTION_NOT_OPTION_SETTING")
    end
  end
  if true == isShow then
    TooltipSimple_Show(control, msg, nil)
  else
    TooltipSimple_Hide()
  end
end
function PaGlobal_Party_All:showSimpleTooltip(isShow, tipType, index)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "INTERACTION_BTN_FOLLOW_ACTOR")
    control = self._ui.stc_members[index]._stc_follow
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_SIMPLETOOLTIP_DISTANCE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_SIMPLETOOLTIP_DISTANCE_DESC")
    control = self._ui.stc_members[index]._stc_distanceWifi
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_SIMPLETOOLTIP_PENALTY_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_SIMPLETOOLTIP_PENALTY_DESC")
  elseif 4 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_SIMPLETOOLTIP_PENALTY_ROOTNAME_NO")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_SIMPLETOOLTIP_PENALTY_ROOTDESC")
    control = self._ui.stc_members[index]._stc_rootInfo
  end
  TooltipSimple_Show(control, name, desc)
end
function PaGlobal_Party_All:createPartyList()
  if nil == Panel_Widget_Party_All then
    return
  end
  if false == self._initialize then
    return
  end
  local partyMemberCount = RequestParty_getPartyMemberCount()
  if 0 < partyMemberCount then
    self._partyInfo.partyType = ToClient_GetPartyType()
    if CppEnums.PartyType.ePartyType_Normal == self._partyInfo.partyType then
      if not isFlushedUI() and false == Panel_Widget_Arsha_Party_All:GetShow() then
        PaGlobal_Party_All:open()
      end
      PaGlobal_Party_All:updatePartyList(true)
      PaGlobal_Party_All:showRegistItem(false)
      self._partyInfo.partyMemCnt = partyMemberCount
      ToClient_requestListMySellInfo()
      PaGlobalFunc_Widget_Raid_All_Close()
    elseif CppEnums.PartyType.ePartyType_Large == self._partyInfo.partyType then
      PaGlobalFunc_Widget_Raid_All_Open()
      PaGlobalFunc_Widget_Raid_All_Update()
      PaGlobalFunc_Widget_Party_All_Close()
    end
  end
end
function PaGlobal_Party_All:showRegistItem(isShow)
  if nil == isShow then
    self._ui_pc.stc_marketOptionBg:SetShow(not self._ui_pc.stc_marketOptionBg:GetShow())
  else
    self._ui_pc.stc_marketOptionBg:SetShow(isShow)
  end
  if false == self._ui_pc.stc_marketOptionBg:GetShow() then
    return
  end
  local isPartyLeader = RequestParty_isLeader()
  self._ui_pc.btn_minCost:SetEnable(isPartyLeader)
  self._ui_pc.btn_Grade:SetEnable(isPartyLeader)
  local posY = self._ui.stc_members[self._partyMemberCount].control:GetPosY() + self._ui_pc.stc_marketOptionBg:GetSizeY() * 0.8
  self._ui_pc.stc_marketOptionBg:SetPosY(posY)
  self._currentMoney = RequestParty_getDistributionPrice()
  if toInt64(0, 0) ~= self._currentMoney then
    self._ui_pc.txt_minCostValue:SetText("<PAColor0xffe7d583>" .. makeDotMoney(self._currentMoney) .. "<PAOldColor>")
    self._ui_pc.chk_minCost:SetCheck(true)
  else
    self._ui_pc.txt_minCostValue:SetText("<PAColor0xffe7d583>" .. makeDotMoney(self._config.baseMoney) .. "<PAOldColor>")
    self._ui_pc.chk_minCost:SetCheck(false)
  end
  self._currentGrade = RequestParty_getDistributionGrade()
  if 0 < self._currentGrade and self._currentGrade <= #self._itemGradeString then
    HandleEventLUp_Party_All_SetGrade(self._currentGrade)
    self._ui_pc.chk_grade:SetCheck(true)
  else
    HandleEventLUp_Party_All_SetGrade(0)
    self._ui_pc.chk_grade:SetCheck(false)
  end
end
function PaGlobal_Party_All:updatePartyList(isCreate)
  if nil == Panel_Widget_Party_All then
    return
  end
  if false == self._initialize then
    return
  end
  if true == PaGlobalFunc_Widget_Raid_All_GetShow() and CppEnums.PartyType.ePartyType_Large == self._partyInfo.partyType then
    PaGlobal_Party_All:prepareClose()
    PaGlobalFunc_Widget_Raid_All_Update()
    return
  end
  local partyMemberCount = RequestParty_getPartyMemberCount()
  if false == Panel_Widget_Party_All:GetShow() and 0 < partyMemberCount and not isCreate and false == Panel_Widget_Arsha_Party_All:GetShow() then
    PaGlobal_Party_All:createPartyList()
    PaGlobal_Party_All:open()
    return
  end
  if false == Panel_Widget_Party_All:GetShow() or CppEnums.PartyType.ePartyType_Normal ~= self._partyInfo.partyType then
    return
  end
  PaGlobal_Party_All:resetPartyData()
  PaGlobal_Party_All:setPartyMember(partyMemberCount)
  PaGlobal_Party_All:setMemberTexture(partyMemberCount)
  local lootType = RequestParty_getPartyLootType()
  local currentLootTypeString = CppEnums.PartyLootType2String[lootType]
  if self._preLootType ~= nil and self._preLootType ~= currentLootTypeString then
    local rottingMsg = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_PARTY_CHANGE_LOOTING_RULE1", "plt2s_lootType", currentLootTypeString)
    Proc_ShowMessage_Ack(rottingMsg)
    self._ui_pc.chk_dropItem:SetText(currentLootTypeString)
  elseif self._preLootType == nil then
    self._ui_pc.chk_dropItem:SetText(currentLootTypeString)
  end
  self._preLootType = currentLootTypeString
  if 0 == partyMemberCount then
    PaGlobal_Party_All:prepareClose()
  end
  self._partyMemberCount = partyMemberCount
  if partyMemberCount > self._firstCheck then
    self._firstCheck = self._firstCheck + 1
  else
    local currentPrice = RequestParty_getDistributionPrice()
    local currentGrade = RequestParty_getDistributionGrade()
    if self._prevPrice ~= currentPrice or self._prevGrade ~= currentGrade then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_DISTRIBUTION_CHANGE_OPTION"))
      self._prevPrice = currentPrice
      self._prevGrade = currentGrade
    end
  end
end
function PaGlobal_Party_All:resetPartyData()
  if false == self._initialize then
    return
  end
  self._partyData = {}
  for index = 1, self._config.maxPartyCnt do
    self._ui.stc_members[index].control:SetShow(false)
  end
end
function PaGlobal_Party_All:setPartyMember(partyMemberCount)
  if partyMemberCount <= 0 then
    return
  end
  self._minPartyMemberLevel = 999
  self._maxPartyMemberLevel = 0
  self._partyData = {}
  for index = 0, partyMemberCount - 1 do
    local memberData = RequestParty_getPartyMemberAt(index)
    if nil == memberData then
      return
    end
    local memberInfo = {}
    memberInfo._index = index
    memberInfo._isMaster = memberData._isMaster
    memberInfo._isSelf = RequestParty_isSelfPlayer(index)
    memberInfo._name = memberData:name()
    memberInfo._class = memberData:classType()
    memberInfo._level = memberData._level
    memberInfo._currentHp = memberData._hp * 100
    memberInfo._maxHp = memberData._maxHp
    memberInfo._currentMp = memberData._mp * 100
    memberInfo._maxMp = memberData._maxMp
    memberInfo._distance = memberData:getExperienceGrade()
    memberInfo._platformType = memberData:getPlatformType()
    table.insert(self._partyData, memberInfo)
    if self._maxPartyMemberLevel < memberData._level then
      self._maxPartyMemberLevel = memberData._level
    end
    if self._minPartyMemberLevel > memberData._level then
      self._minPartyMemberLevel = memberData._level
    end
  end
  local sortFunc = function(a, b)
    return a._isSelf
  end
  table.sort(self._partyData, sortFunc)
end
function PaGlobal_Party_All:setMemberTexture(partyMemberCount)
  local isSelfMaster = RequestParty_isLeader()
  for index = 1, partyMemberCount do
    local member = self._ui.stc_members[index]
    if nil == member then
      return
    end
    local partyData = self._partyData[index]
    if nil == partyData then
      return
    end
    member.control:SetShow(true)
    member._progress_hp:SetProgressRate(partyData._currentHp / partyData._maxHp)
    member._progress_mp:SetProgressRate(partyData._currentMp / partyData._maxMp)
    PaGlobal_Party_All:setClassIcon(member._stc_classIcon, partyData._class)
    PaGlobal_Party_All:setClassMpBar(member._progress_mp, partyData._class)
    if true == partyData._isSelf then
      PaGlobal_Party_All:setRootInfo(member._stc_rootInfo, partyData)
    end
    PaGlobal_Party_All:setStateIcon(member, partyData)
    member._txt_level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. partyData._level)
    local showCheck = {
      member._btn_option,
      member._stc_follow,
      member._stc_distanceWifi
    }
    local template = self._ui.stc_memberTemplate
    local originNameSizeX = UI.getChildControl(template, "StaticText_CharacterNameValue"):GetSizeX()
    local originIconSizeX = UI.getChildControl(template, "Static_Follow"):GetSizeX()
    local showIconNum = #showCheck
    for index = 1, #showCheck do
      if true == showCheck[index]:GetShow() then
        showIconNum = showIconNum - 1
      end
    end
    member._txt_name:SetPosX(member._txt_level:GetPosX() + member._txt_level:GetTextSizeX() + 3)
    if true == partyData._isSelf and true == member._stc_rootInfo:GetShow() then
      local gapSizeX = member._stc_rootInfo:GetPosX() - member._txt_name:GetPosX()
      member._txt_name:SetSize(gapSizeX, member._txt_name:GetSizeY())
    else
      member._txt_name:SetSize(originNameSizeX + originIconSizeX * showIconNum, member._txt_name:GetSizeY())
    end
    member._txt_name:SetTextMode(__eTextMode_LimitText)
    member._txt_name:SetText(partyData._name)
    if true == member._txt_name:IsLimitText() then
      member._txt_name:SetIgnore(false)
      member._txt_name:addInputEvent("Mouse_On", "HandleEventOnOut_Party_All_ShowNameTooltip(true," .. index .. ")")
      member._txt_name:addInputEvent("Mouse_Out", "HandleEventOnOut_Party_All_ShowNameTooltip(false," .. index .. ")")
    else
      member._txt_name:SetIgnore(true)
      member._txt_name:addInputEvent("Mouse_On", "")
      member._txt_name:addInputEvent("Mouse_Out", "")
    end
    if true == ToClient_isTotalGameClient() then
      PaGlobal_Party_All:setCrossPlayIcon(member._stc_platformIcon, partyData._platformType)
    end
  end
end
function PaGlobal_Party_All:setClassIcon(control, class)
  if nil == control then
    return
  end
  local iconTexture = self._textureClassSymbol[class]
  if nil == iconTexture then
    return
  end
  control:ChangeTextureInfoName(self._textureClassSymbol.path)
  local x1, y1, x2, y2 = setTextureUV_Func(control, iconTexture.x1, iconTexture.x2, iconTexture.y1, iconTexture.y2)
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobal_Party_All:setClassMpBar(control, class)
  if nil == control then
    return
  end
  local colorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
  if 0 == colorBlindMode then
    local mpBarTexture = self._textureMPBar[class]
    if nil == mpBarTexture then
      return
    end
    control:ChangeTextureInfoName(self._textureMPBar.path)
    local x1, y1, x2, y2 = setTextureUV_Func(control, mpBarTexture[1], mpBarTexture[2], mpBarTexture[3], mpBarTexture[4])
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
  elseif 1 <= colorBlindMode then
    control:ChangeTextureInfoName("Combine/Progress/Combine_Progress_ColorBlind_00.dds")
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(control, 331, 290, 504, 294)
    control:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
    control:setRenderTexture(control:getBaseTexture())
  end
end
function PaGlobal_Party_All:setRootInfo(control, partyData)
  if false == partyData._isSelf then
    return
  end
  local rootInfoTexture
  if self._maxPartyMemberLevel - self._minPartyMemberLevel >= 10 then
    control:ChangeTextureInfoName("renewal/etc/console_etc_00.dds")
    rootInfoTexture = self._textureRootInfo[2]
    local x1, y1, x2, y2 = setTextureUV_Func(control, rootInfoTexture[1], rootInfoTexture[2], rootInfoTexture[3], rootInfoTexture[4])
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
    control:SetShow(true)
  else
    if true == self._isRootShowFlag then
      self._isRootShowFlag = false
      TooltipSimple_Hide()
    end
    control:SetShow(false)
  end
end
function PaGlobal_Party_All:setStateIcon(member, partyData)
  if nil == member then
    return
  end
  local control = member._stc_distanceWifi
  local wifiTexture = self._textureWifi[partyData._distance + 1]
  if nil == wifiTexture then
    return
  end
  control:ChangeTextureInfoName(self._textureWifi.path)
  local x1, y1, x2, y2 = setTextureUV_Func(control, wifiTexture[1], wifiTexture[2], wifiTexture[3], wifiTexture[4])
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
  local isDead = partyData._currentHp <= 0
  control = member._stc_deadState
  control:SetShow(isDead)
  control = member._progress_mp
  control:SetShow(not isDead)
  control = member._progress_hp
  control:SetShow(not isDead)
  control = member._stc_classIconLeaderBg
  control:SetShow(partyData._isMaster)
  control = member._btn_option
  control:SetShow((RequestParty_isLeader() or partyData._isSelf) and false == self._isConsole)
  control = member._stc_follow
  control:SetShow(not partyData._isSelf and false == self._isConsole)
  control = member._stc_distanceWifi
  control:SetShow(not partyData._isSelf)
  local posX = member._txt_name:GetPosX()
  posX = posX + member._txt_name:GetTextSizeX() + 10
  control:SetPosX(posX)
  local posX = member._btn_option:GetPosX()
  if true == member._btn_option:GetShow() then
    member._stc_follow:SetPosX(posX - 21)
    if true == member._stc_follow:GetShow() then
      posX = posX - 48
    end
    member._stc_distanceWifi:SetPosX(posX)
  else
    member._stc_follow:SetPosX(posX)
    if true == member._stc_follow:GetShow() then
      posX = posX - 25
    else
      posX = posX - 5
    end
    member._stc_distanceWifi:SetPosX(posX)
  end
end
function PaGlobal_Party_All:setLootingType()
  PaGlobal_Party_All:closePartyOption()
  self._lastSelectUser = nil
  if false == RequestParty_isLeader() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_ONLYLEADERCHANGE"))
    self._ui_pc.chk_dropItem:SetCheck(false)
    return
  end
  PaGlobal_Party_All:showLootingType()
end
function PaGlobal_Party_All:showLootingType()
  local lootType = RequestParty_getPartyLootType()
  local setShow = self._ui_pc.chk_dropItem:IsCheck()
  self._ui_pc.stc_dropSetBg:SetShow(setShow)
  if true == setShow then
    self:changeLootingType(lootType)
  end
end
function PaGlobal_Party_All:changeLootingType(lootType)
  self._ui_pc.radio_free:SetCheck(false)
  self._ui_pc.radio_turn:SetCheck(false)
  self._ui_pc.radio_rando:SetCheck(false)
  self._ui_pc.radio_onlyLeader:SetCheck(false)
  if lootType == CppEnums.PartyLootType.LootType_Free then
    self._ui_pc.radio_free:SetCheck(true)
  elseif lootType == CppEnums.PartyLootType.LootType_Shuffle then
    self._ui_pc.radio_turn:SetCheck(true)
  elseif lootType == CppEnums.PartyLootType.LootType_Random then
    self._ui_pc.radio_rando:SetCheck(true)
  elseif lootType == CppEnums.PartyLootType.LootType_Master then
    self._ui_pc.radio_onlyLeader:SetCheck(true)
  end
end
function PaGlobal_Party_All:selectLootingType(lootType)
  RequestParty_changeLooting(lootType)
  local showString
  if lootType == CppEnums.PartyLootType.LootType_Free then
    showString = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_LOOTTYPE_FREE")
  elseif lootType == CppEnums.PartyLootType.LootType_Shuffle then
    showString = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_LOOTTYPE_SHUFFLE")
  elseif lootType == CppEnums.PartyLootType.LootType_Random then
    showString = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_LOOTTYPE_RANDOM")
  elseif lootType == CppEnums.PartyLootType.LootType_Master then
    showString = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_LOOTTYPE_MASTER")
  end
  self._ui_pc.chk_dropItem:SetText(showString)
  self._ui_pc.chk_dropItem:SetCheck(false)
  self:showLootingType()
end
function PaGlobal_Party_All:closePartyOption(index)
  if nil ~= index then
    local control = self._ui.stc_members[index]
    control._btn_leave:SetShow(false)
    control._stc_setMemberBg:SetShow(false)
  else
    for index = 1, self._config.maxPartyCnt do
      local control = self._ui.stc_members[index]
      control._btn_leave:SetShow(false)
      control._stc_setMemberBg:SetShow(false)
    end
  end
end
function PaGlobal_Party_All:selectPartyOption(index)
  local partyData = self._partyData[index]
  local control = self._ui.stc_members[index]
  self:closePartyOption()
  self._ui_pc.chk_dropItem:SetCheck(false)
  self:showLootingType()
  if self._lastSelectUser == index then
    self._lastSelectUser = nil
  else
    if partyData._isSelf == true then
      control._btn_leave:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_SelectWithdrawMemeber(" .. partyData._index .. ")")
      control._btn_leave:SetShow(true)
    elseif RequestParty_isLeader() == true then
      control._btn_forceOut:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_SelectBanishMember(" .. partyData._index .. ")")
      control._btn_setLeader:addInputEvent("Mouse_LUp", "HandleEventLUp_Party_All_SelectChangeLeader(" .. partyData._index .. ")")
      control._stc_setMemberBg:SetShow(true)
    end
    self._lastSelectUser = index
  end
end
function PaGlobal_Party_All:selectWithdrawMember(index)
  local isPlayingPvPMatch = getSelfPlayer():isDefinedPvPMatch()
  if true == isPlayingPvPMatch then
    RequestParty_withdrawMember(index)
    return
  end
  local function partyOut()
    RequestParty_withdrawMember(index)
    self:closePartyOption()
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_DISTRIBUTION_GETOUTPARTY")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = partyOut,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_Party_All:banishMemeber(index)
  self._withdrawMember = index
  local withdrawMemberData = RequestParty_getPartyMemberAt(self._withdrawMember)
  local withdrawMemberActorKey = withdrawMemberData:getActorKey()
  local withdrawMemberPlayerActor = getPlayerActor(withdrawMemberActorKey)
  local contentString = ""
  local titleForceOut = ""
  if CppEnums.PartyType.ePartyType_Normal == self._partyInfo.partyType then
    contentString = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_PARTY_FORCEOUT_QUESTION", "member_name", withdrawMemberData:name())
    titleForceOut = PAGetString(Defines.StringSheet_GAME, "PANEL_PARTY_FORCEOUT")
  else
    contentString = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_LARGEPARTY_FORCEOUT_QUESTION", "member_name", withdrawMemberData:name())
    titleForceOut = PAGetString(Defines.StringSheet_GAME, "PANEL_LARGEPARTY_FORCEOUT")
  end
  local function messageBox_party_withdrawMember()
    local memberData = RequestParty_getPartyMemberAt(self._withdrawMember)
    RequestParty_withdrawMember(self._withdrawMember)
    if true == getSelfPlayer():isDefinedPvPMatch() then
      return
    end
  end
  local messageboxData = {
    title = titleForceOut,
    content = contentString,
    functionYes = messageBox_party_withdrawMember,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
  self:closePartyOption()
end
function PaGlobal_Party_All:selectChangeLeader(index)
  RequestParty_changeLeader(index)
  self:closePartyOption()
end
function PaGlobal_Party_All:setGrade(index)
  if nil == index or index > #self._itemGradeString then
    return
  end
  self._currentGrade = index
  self._ui_pc.txt_minGradeValue:SetText(self._itemGradeString[index])
  self:showGradeListToggle(false)
end
function PaGlobal_Party_All:showGradeListToggle(isShow)
  if false == isShow or true == self._ui_pc.stc_gradeOptionBg:GetShow() then
    self._ui_pc.stc_gradeOptionBg:SetShow(false)
    return
  end
  self._ui_pc.stc_gradeOptionBg:SetShow(true)
end
function PaGlobal_Party_All:showMarketOptionToggle(isShow)
  if false == isShow or true == self._ui_pc.stc_marketOptionBg:GetShow() then
    self._ui_pc.stc_marketOptionBg:SetShow(false)
    return
  end
  self._ui_pc.stc_marketOptionBg:SetShow(true)
  PaGlobal_Party_All:showRegistItem(true)
end
function PaGlobal_Party_All:setMoney(inputNum)
  local _inputNum
  if Int64toInt32(self._config.maxMoney) < Int64toInt32(inputNum) then
    _inputNum = self._config.maxMoney
  elseif Int64toInt32(inputNum) < 1000000 then
    _inputNum = self._config.baseMoney
  else
    _inputNum = inputNum
  end
  self._currentMoney = _inputNum
  self._ui_pc.txt_minCostValue:SetText("<PAColor0xffe7d583>" .. makeDotMoney(_inputNum) .. "<PAOldColor>")
end
function PaGlobal_Party_All:setRegistItem()
  local price = toInt64(0, 0)
  local grade = 5
  if true == self._ui_pc.chk_minCost:IsCheck() then
    price = toInt64(0, math.max(Int64toInt32(self._currentMoney), Int64toInt32(self._config.baseMoney)))
  end
  if true == self._ui_pc.chk_grade:IsCheck() then
    grade = self._currentGrade
    if 0 == grade then
      grade = 5
    end
  end
  RequestParty_changeDistributionOption(price, grade)
  self:showMarketOptionToggle(false)
end
function PaGlobal_Party_All:selectPartyFollow(index)
  local idx = self._partyData[index]._index
  local selfPlayer = getSelfPlayer()
  local memberData = RequestParty_getPartyMemberAt(idx)
  if nil ~= memberData then
    local actorKey = memberData:getActorKey()
    selfPlayer:setFollowActor(actorKey)
  end
end
function PaGlobal_Party_All:invite(hostName, invitePartyType)
  if true == self._inviteReqList[hostName] then
    return
  end
  local function messageBox_party_accept()
    if nil == self._currentPartyType then
      return
    end
    self._inviteReqList = {}
    if true == ToClient_IsInstanceRandomMatching() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_RAMDOMMATCH_FAILBYPARTY"))
      RequestParty_refuseInvite()
    else
      RequestParty_acceptInvite(self._currentPartyType)
    end
  end
  local function messageBox_party_refuse()
    RequestParty_refuseInvite()
    if true == self._inviteReqList[self._refuseName] then
      self._inviteReqList[self._refuseName] = nil
    end
  end
  self._partyInfo.partyType = invitePartyType
  self._refuseName = hostName
  self._currentPartyType = invitePartyType
  self._inviteReqList[hostName] = true
  local messageboxMemo = ""
  local messageboxData = ""
  if 0 == invitePartyType then
    messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_PARTY_INVITE_ACCEPT", "host_name", hostName)
    messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "PARTY_INVITE_MESSAGEBOX_TITLE"),
      content = messageboxMemo,
      functionYes = messageBox_party_accept,
      functionNo = messageBox_party_refuse,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
  else
    messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LARGEPARTY_INVITE_ACCEPT", "host_name", hostName)
    messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_LARGEPARTY_INVITE_MESSAGEBOX_TITLE"),
      content = messageboxMemo,
      functionYes = messageBox_party_accept,
      functionNo = messageBox_party_refuse,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
  end
  MessageBox.showMessageBox(messageboxData, "top", false, true, 0)
end
function PaGlobal_Party_All:refuse(reason)
  local contentString = reason
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = contentString,
    functionYes = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_Party_All:changeLeader(actorKey)
  local actorProxyWrapper = getActor(actorKey)
  if nil == actorProxyWrapper then
    return
  end
  local textName = actorProxyWrapper:getName()
  if CppEnums.PartyType.ePartyType_Normal == self._partyInfo.partyType then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_PARTY_CHANGE_PARTY_LEADER", "text_name", tostring(textName)))
  else
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_LARGEPARTY_CHANGE_PARTY_LEADER", "text_name", tostring(textName)))
  end
  self:updatePartyList()
  self:showRegistItem(false)
end
function PaGlobal_Party_All:withdraw(withdrawType, actorKey, isMe)
  if ToClient_IsRequestedPvP() or ToClient_IsMyselfInEntryUser() then
    return
  end
  local partyType = self._partyInfo.partyType
  local message = ""
  if 0 == withdrawType then
    if isMe then
      if 0 == partyType then
        message = PAGetString(Defines.StringSheet_GAME, "PANEL_PARTY_LEAVE_PARTY_SELF")
      else
        message = PAGetString(Defines.StringSheet_GAME, "PANEL_LARGEPARTY_LEAVE_PARTY_SELF")
      end
    else
      local actorProxyWrapper = getActor(actorKey)
      if nil ~= actorProxyWrapper then
        local textName = actorProxyWrapper:getOriginalName()
        if 0 == partyType then
          message = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_PARTY_LEAVE_PARTY_MEMBER", "text_name", tostring(textName))
        else
          message = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_LARGEPARTY_LEAVE_PARTY_MEMBER", "text_name", tostring(textName))
        end
      end
    end
  elseif 1 == withdrawType then
    if isMe then
      if 0 == partyType then
        message = PAGetString(Defines.StringSheet_GAME, "PANEL_PARTY_FORCEOUT_SELF")
      else
        message = PAGetString(Defines.StringSheet_GAME, "PANEL_LARGEPARTY_FORCEOUT_SELF")
      end
    else
      local actorProxyWrapper = getActor(actorKey)
      if nil ~= actorProxyWrapper then
        local textName = actorProxyWrapper:getOriginalName()
        if 0 == partyType then
          message = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_PARTY_FORCEOUT_MEMBER", "text_name", tostring(textName))
        else
          message = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_LARGEPARTY_FORCEOUT_MEMBER", "text_name", tostring(textName))
        end
      end
    end
  elseif 2 == withdrawType then
    if 0 == partyType then
      message = PAGetString(Defines.StringSheet_GAME, "PANEL_PARTY_DISPERSE")
    else
      message = PAGetString(Defines.StringSheet_GAME, "PANEL_LARGEPARTY_DISPERSE")
    end
  end
  NakMessagePanel_Reset()
  if "" ~= message and nil ~= message then
    Proc_ShowMessage_Ack(message)
  end
end
function PaGlobal_Party_All:partyConditionalShow()
  if 0 == RequestParty_getPartyMemberCount() then
    PaGlobal_Party_All:prepareClose()
    self:resetData()
  else
    self:open()
    self:updatePartyList()
  end
end
function PaGlobal_Party_All:setCrossPlayIcon(targetControl, platformType)
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
