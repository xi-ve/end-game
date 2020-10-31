function PaGlobalFunc_ChannelSelect_All_Open()
  if nil == Panel_ChannelSelect_All or true == Panel_ChannelSelect_All:GetShow() then
    return
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoingAlterOfBlood"))
    return
  end
  if isDeadInWatchingMode() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHANNELCHANGEOPENALERT_INDEAD"))
    return
  end
  local rv = ToClient_CheckToMoveChannel()
  if 0 ~= rv then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoRestrictedToMoveChannelOnBossSpawnPeriod"))
    return
  end
  if true == _ContentsGroup_RenewUI and false == ToClient_isCrossNetworkPlayAllowed() then
    setSamePlatformOnly(false)
  end
  PaGlobal_ChannelSelect_All:prepareOpen()
end
function PaGlobalFunc_ChannelSelect_All_OnScreenResize()
  if nil == Panel_ChannelSelect_All then
    return
  end
  if false == _ContentsGroup_RenewUI then
    PaGlobal_ChannelSelect_All._ui.stc_blockBG:SetSize(getScreenSizeX() + 500, getScreenSizeY() + 500)
  else
    PaGlobal_ChannelSelect_All._ui.stc_blockBG:SetSize(getScreenSizeX(), getScreenSizeY())
  end
  PaGlobal_ChannelSelect_All._ui.stc_blockBG:SetHorizonCenter()
  PaGlobal_ChannelSelect_All._ui.stc_blockBG:SetVerticalMiddle()
  Panel_ChannelSelect_All:ComputePos()
end
function PaGlobalFunc_ChannelSelect_All_Update()
  if false == Panel_ChannelSelect_All:GetShow() then
    return
  end
  PaGlobal_ChannelSelect_All:update()
end
function PaGlobalFunc_ChannelSelect_All_Close()
  if nil == Panel_ChannelSelect_All or false == Panel_ChannelSelect_All:GetShow() then
    return
  end
  PaGlobal_ChannelSelect_All:prepareClose()
end
function PaGlobalFunc_ChannelSelect_All_ShowAni()
  if nil == Panel_ChannelSelect_All then
    return
  end
  audioPostEvent_SystemUi(1, 0)
  Panel_ChannelSelect_All:SetAlpha(0)
  UIAni.AlphaAnimation(1, Panel_ChannelSelect_All, 0, 0.3)
end
function PaGlobalFunc_ChannelSelect_All_HideAni()
  if nil == Panel_ChannelSelect_All then
    return
  end
  audioPostEvent_SystemUi(1, 1)
  local ani1 = UIAni.AlphaAnimation(0, Panel_ChannelSelect_All, 0, 0.2)
  ani1:SetHideAtEnd(true)
end
function PaGlobalFunc_ChannelSelect_All_UpdatePerFrame(deltaT)
  if nil == Panel_ChannelSelect_All or false == Panel_ChannelSelect_All:GetShow() then
    return
  end
  if PaGlobal_ChannelSelect_All._useFrameDesc then
    PaGlobal_ChannelSelect_All:updateServerDescFrame(deltaT)
  end
  if true == PaGlobal_ChannelSelect_All._ui.txt_Icon_Time:GetShow() then
    PaGlobal_ChannelSelect_All._elapsedTime = PaGlobal_ChannelSelect_All._elapsedTime + deltaT
    if PaGlobal_ChannelSelect_All._elapsedTime > 1 then
      PaGlobal_ChannelSelect_All._elapsedTime = 0
      local curChannelData = getCurrentChannelServerData()
      if nil == curChannelData then
        return
      end
      local curWorldData = getGameWorldServerDataByWorldNo(curChannelData._worldNo)
      local channelMoveableRemainTime = getChannelMoveableRemainTime(curWorldData._worldNo)
      local changeRealChannelTime = convertStringFromDatetime(channelMoveableRemainTime)
      if "" ~= changeRealChannelTime then
        PaGlobal_ChannelSelect_All._ui.txt_Icon_Time:SetText(changeRealChannelTime)
      else
        PaGlobal_ChannelSelect_All._ui.txt_Icon_Time:SetShow(false)
        if false == PaGlobal_ChannelSelect_All._ui.txt_Icon_SeasonCoolTime:GetShow() then
          PaGlobal_ChannelSelect_All._ui.txt_Status:SetShow(false)
        end
      end
    end
  end
  if true == PaGlobal_ChannelSelect_All._ui.txt_Icon_SeasonCoolTime:GetShow() then
    PaGlobal_ChannelSelect_All._elapsedTime = PaGlobal_ChannelSelect_All._elapsedTime + deltaT
    if PaGlobal_ChannelSelect_All._elapsedTime > 1 then
      PaGlobal_ChannelSelect_All._elapsedTime = 0
      local curChannelData = getCurrentChannelServerData()
      if nil == curChannelData then
        return
      end
      local curWorldData = getGameWorldServerDataByWorldNo(curChannelData._worldNo)
      local specialChannelMoveableRemainTime = getSpecialChannelMoveableRemainTime(curWorldData._worldNo)
      local specialChangeRealChannelTime = convertStringFromDatetime(specialChannelMoveableRemainTime)
      if "" ~= specialChangeRealChannelTime then
        PaGlobal_ChannelSelect_All._ui.txt_Icon_SeasonCoolTime:SetText(specialChangeRealChannelTime)
      else
        PaGlobal_ChannelSelect_All._ui.txt_Icon_SeasonCoolTime:SetShow(false)
        if false == PaGlobal_ChannelSelect_All._ui.txt_Icon_Time:GetShow() then
          PaGlobal_ChannelSelect_All._ui.txt_Status:SetShow(false)
        end
      end
    end
  end
  PaGlobal_ChannelSelect_All:computeServerCoolTimePosition()
end
function HandleEventLUp_ChannelSelect_All_ToggleDesc()
  local isShow = true
  if PaGlobal_ChannelSelect_All._useFrameDesc then
    isShow = PaGlobal_ChannelSelect_All._ui.frame_Desc:GetShow()
    PaGlobal_ChannelSelect_All._ui.frame_Desc:SetShow(not isShow)
  else
    isShow = PaGlobal_ChannelSelect_All._ui.stc_DescPanel:GetShow()
    PaGlobal_ChannelSelect_All._ui.stc_DescPanel:SetShow(not isShow)
  end
  local x1, y1, x2, y2 = 0, 0, 0, 0
  local onX1, onY1, onX2, onY2 = 0, 0, 0, 0
  local clickX1, clickY1, clickX2, clickY2 = 0, 0, 0, 0
  if false == isShow then
    PaGlobal_ChannelSelect_All._ui.chk_ShowDesc:SetCheck(true)
    x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_ChannelSelect_All._ui.chk_ShowDesc, 89, 434, 117, 462)
    onX1, onY1, onX2, onY2 = setTextureUV_Func(PaGlobal_ChannelSelect_All._ui.chk_ShowDesc, 118, 434, 146, 462)
    clickX1, clickY1, clickX2, clickY2 = setTextureUV_Func(PaGlobal_ChannelSelect_All._ui.chk_ShowDesc, 147, 434, 175, 462)
  else
    PaGlobal_ChannelSelect_All._ui.chk_ShowDesc:SetCheck(false)
    x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_ChannelSelect_All._ui.chk_ShowDesc, 117, 434, 89, 462)
    onX1, onY1, onX2, onY2 = setTextureUV_Func(PaGlobal_ChannelSelect_All._ui.chk_ShowDesc, 146, 434, 118, 462)
    clickX1, clickY1, clickX2, clickY2 = setTextureUV_Func(PaGlobal_ChannelSelect_All._ui.chk_ShowDesc, 175, 434, 147, 462)
  end
  PaGlobal_ChannelSelect_All._ui.chk_ShowDesc:getBaseTexture():setUV(x1, y1, x2, y2)
  PaGlobal_ChannelSelect_All._ui.chk_ShowDesc:getOnTexture():setUV(onX1, onY1, onX2, onY2)
  PaGlobal_ChannelSelect_All._ui.chk_ShowDesc:getClickTexture():setUV(clickX1, clickY1, clickX2, clickY2)
  PaGlobal_ChannelSelect_All._ui.chk_ShowDesc:setRenderTexture(PaGlobal_ChannelSelect_All._ui.chk_ShowDesc:getBaseTexture())
  local isDescChecked = PaGlobal_ChannelSelect_All._ui.chk_ShowDesc:IsCheck()
  if true == isDescChecked then
    PaGlobal_ChannelSelect_All._ui.chk_ShowDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_DESC_NOSHOW"))
    PaGlobal_ChannelSelect_All._ui.stc_ShowDescText_PadUI:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_DESC_NOSHOW"))
  else
    PaGlobal_ChannelSelect_All._ui.chk_ShowDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHANNELSELECT_TOGGLE_INFO_REMASTER"))
    PaGlobal_ChannelSelect_All._ui.stc_ShowDescText_PadUI:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHANNELSELECT_TOGGLE_INFO_REMASTER"))
  end
end
function HandleEventOnOut_ChannelSelect_All_NewbieServerJoinDateDesc(isShow, idx)
  if false == isShow or nil == idx or nil == PaGlobal_ChannelSelect_All._channelSelectUIPool[idx] then
    TooltipSimple_Hide()
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  local newbieTime = temporaryWrapper:getSpeedServerExpiration()
  local isAdmission = temporaryWrapper:getMyAdmissionToSpeedServer()
  local name, desc, control
  name = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXITSERVERSELECT_NEWBIE_TOOLTIP_TITLE")
  desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXITSERVERSELECT_NEWBIE_TOOLTIP_DESC", "newbieTime", getTimeYearMonthDayHourMinSecByTTime64(newbieTime))
  control = PaGlobal_ChannelSelect_All._channelSelectUIPool[idx]._bg
  if 0 ~= isAdmission and nil ~= control then
    TooltipSimple_Show(control, name, desc)
  end
end
function HandleEventOnOut_ChannelSelect_All_CoolTimeIconToolTip(isShow, isNormal)
  if false == isShow or nil == PaGlobal_ChannelSelect_All._ui.txt_Icon_SeasonCoolTime or nil == PaGlobal_ChannelSelect_All._ui.txt_Icon_Time then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if true == isNormal then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHANNELSELECT_NORMALCOOLTIME")
    desc = nil
    control = PaGlobal_ChannelSelect_All._ui.txt_Icon_Time
  else
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHANNELSELECT_SEASONCOOLTIME")
    desc = nil
    control = PaGlobal_ChannelSelect_All._ui.txt_Icon_SeasonCoolTime
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_ChannelSelect_All_SelectChannel(ch_idx)
  if nil == ch_idx then
    return
  end
  audioPostEvent_SystemUi(0, 0)
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local channelSlot = PaGlobal_ChannelSelect_All._channelSelectUIPool[ch_idx - 1]
  if nil == channelSlot then
    return
  end
  if true == isChannelMoveOnlySafe() then
    local regionInfo = getRegionINfoByPosition(selfPlayer:get():getPostition())
    if not regionInfo:get():isSafeZone() and false == ToClient_SelfPlayerIsGM() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXITSERVERSELECT_SAFEREGION"))
      channelSlot._bg:SetCheck(false)
      return
    end
  end
  if nil ~= PaGlobal_TutorialManager and true == PaGlobal_TutorialManager:isDoingTutorial() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoPlayerIsDoingTutorial"))
    channelSlot._bg:SetCheck(false)
    return
  end
  if true == ToClient_SelfPlayerCheckAction("READ_BOOK") then
    PaGlobal_ChannelSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXITSERVERSELECT_READBOOK_WARNNING"), nil, nil, MessageBox_Empty_function, nil)
    channelSlot._bg:SetCheck(false)
    return
  end
  local selectedChannelIdx = PaGlobal_ChannelSelect_All._serverIndexTable[ch_idx]
  if nil == selectedChannelIdx then
    UI.ASSERT(false, "PaGlobal_ChannelSelect_All._serverIndexTable[ ch_idx ] is nil  / ch_idx =  " .. tostring(ch_idx))
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CASH_CUSTOMIZATION_NOSELECT"))
    channelSlot._bg:SetCheck(false)
    return
  end
  local curChannelData = getCurrentChannelServerData()
  local curWorldData = getGameWorldServerDataByWorldNo(curChannelData._worldNo)
  local channelCount = getGameChannelServerDataCount(curWorldData._worldNo)
  local selectedChannel = getGameChannelServerDataByWorldNo(curChannelData._worldNo, selectedChannelIdx)
  if nil == selectedChannel then
    UI.ASSERT(false, "selectedChannel is nil ")
    channelSlot._bg:SetCheck(false)
    return
  end
  local busyState = selectedChannel._busyState
  local isSpecialCharacter = getTemporaryInformationWrapper():isSpecialCharacter()
  if 0 == busyState then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_DONTJOIN"))
    channelSlot._bg:SetCheck(false)
    return
  elseif true == selfPlayer:get():isBattleGroundDefine() and true == selectedChannel._isSiegeChannel or true == selectedChannel._isSiegeChannel and true == isSpecialCharacter then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_BATTLEGROURND"))
    channelSlot._bg:SetCheck(false)
    return
  end
  if true == ToClient_isTotalGameClient() then
    local gamePlatformType = ToClient_getGamePlatformType()
    local servicePlatformType = selectedChannel._servicePlatformType
    if gamePlatformType ~= servicePlatformType then
      local canCrossPlay = ToClient_getGameOptionControllerWrapper():getSamePlatformOnly()
      if __ePlatformType_COUNT == servicePlatformType and false == canCrossPlay then
        PaGlobal_ChannelSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"), PAGetString(Defines.StringSheet_GAME, "LUA_CROSSPLAY_CANT_SELECTSERVER"), nil, nil, MessageBox_Empty_function, nil)
        return
      elseif __ePlatformType_COUNT ~= servicePlatformType then
        PaGlobal_ChannelSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"), PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_CANT_CONNECTABLE_PLATFORM"), nil, nil, MessageBox_Empty_function, nil)
        return
      end
    end
  end
  if true == _ContentsGroup_SeasonContents and true == selectedChannel._isSeasonChannel and false == selfPlayer:get():isSeasonCharacter() and false == ToClient_SelfPlayerIsGM() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SEASONCONTENT_CANNOT_ACCESS"))
    return
  end
  local function localFunc_MoveChannel()
    if true == _ContentsGroup_NewUI_GameExit then
      PaGlobal_GameExit_ALL_SaveCurrentData()
    elseif false == _ContentsGroup_RenewUI_ExitGame then
      FGlobal_gameExit_saveCurrentData()
    else
      PaGlobalFunc_GameExit_SaveCurrentData()
    end
    gameExit_MoveChannel(selectedChannelIdx)
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_TITLE_MSG"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELWAIT_MSG"),
      functionYes = nil,
      functionClose = nil,
      exitButton = true,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
  local function localFunc_UnCheckBtn()
    channelSlot._bg:SetCheck(false)
    PaGlobalFunc_ChannelSelect_All_Update()
  end
  local channelName = getChannelName(selectedChannel._worldNo, selectedChannel._serverNo)
  local changeChannelTime = getChannelMoveableRemainTime(curChannelData._worldNo)
  local changeRealChannelTime = convertStringFromDatetime(changeChannelTime)
  local changeSpecialChannelTime = getSpecialChannelMoveableRemainTime(curChannelData._worldNo)
  local changeRealSpecialChannelTime = convertStringFromDatetime(changeSpecialChannelTime)
  local isSeigeBeing = deadMessage_isSiegeBeingMyChannel()
  local isInSiegeBattle = deadMessage_isInSiegeBattle()
  if true == isSeigeBeing and false == isInSiegeBattle then
    PaGlobal_ChannelSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_TITLE_MSG"), PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_MSG", "channelName", tostring(channelName)), localFunc_MoveChannel, localFunc_UnCheckBtn, nil, nil)
  elseif changeChannelTime > toInt64(0, 0) and false == selectedChannel._isSeasonChannel then
    PaGlobal_ChannelSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_TITLE_MSG"), PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANGECHANNEL_PENALTY", "changeRealChannelTime", changeRealChannelTime), nil, nil, localFunc_UnCheckBtn, nil)
  elseif changeSpecialChannelTime > toInt64(0, 0) and true == selectedChannel._isSeasonChannel then
    PaGlobal_ChannelSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_TITLE_MSG"), PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANGECHANNEL_PENALTY", "changeRealChannelTime", changeRealSpecialChannelTime), nil, nil, localFunc_UnCheckBtn, nil)
  else
    PaGlobal_ChannelSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_TITLE_MSG"), PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_MSG", "channelName", tostring(channelName)), localFunc_MoveChannel, localFunc_UnCheckBtn, nil, nil)
  end
end
function HandleEventOnOut_ChannelSelect_All_ServerSlotIcon_Tooltip(idx, ch_idx)
  if nil == idx or nil == ch_idx or nil == PaGlobal_ChannelSelect_All._channelSelectUIPool[ch_idx] then
    TooltipSimple_Hide()
    return
  end
  local control, name
  control = PaGlobal_ChannelSelect_All._channelSelectUIPool[ch_idx]._IconTable[idx]
  if nil == PaGlobal_ChannelSelect_All._string_IconTooltip[idx] then
    UI.ASSERT(false, " tooltip type is nil " .. TooltipSimple_Show(idx))
    return
  end
  name = PaGlobal_ChannelSelect_All._string_IconTooltip[idx]
  if nil == control then
    UI.ASSERT(false, " control  is nil " .. TooltipSimple_Show(ch_idx))
    return
  end
  TooltipSimple_Show(control, name, nil)
end
function EventUpdateServerInformation_Exit()
  if nil == PaGlobal_ChannelSelect_All then
    return
  end
  PaGlobal_ChannelSelect_All:update()
end
function FromClient_ChannelSelect_All_ShowXboxInviteMessage(worldIdx, serverIdx, userName, channelName)
  if false == _ContentsGroup_RenewUI or nil == Panel_ChannelSelect_All then
    return
  end
  PaGlobal_ChannelSelect_All._friendInviteWorldIdx = worldIdx
  PaGlobal_ChannelSelect_All._friendInviteServerIdx = serverIdx
  PaGlobal_ChannelSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_CHANNELMOVE_TITLE_MSG"), PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WINDOW_XBOXCHANNELINVITE", "userName", tostring(userName), "channelName", tostring(channelName)), PaGlobalFunc_ChannelSelect_All_AcceptInvite_XBOX, PaGlobalFunc_ChannelSelect_All_DeclinetInvite_XBOX, nil, nil)
end
function PaGlobalFunc_ChannelSelect_All_AcceptInvite_XBOX()
  if false == _ContentsGroup_RenewUI then
    return
  end
  close_attacked_WindowPanelList(true)
  PaGlobalFunc_ChannelSelect_All_Open()
end
function PaGlobalFunc_ChannelSelect_All_DeclinetInvite_XBOX()
  if false == _ContentsGroup_RenewUI then
    return
  end
  PaGlobal_ChannelSelect_All._friendInviteWorldIdx = nil
  PaGlobal_ChannelSelect_All._friendInviteServerIdx = nil
end
