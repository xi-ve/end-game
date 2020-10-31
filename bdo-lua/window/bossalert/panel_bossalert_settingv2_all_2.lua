function PaGlobal_BossAlert_SettingV2_All_Open()
  if false == _ContetnsGroup_BossAlert or false == ToClient_IsGrowStepOpen(__eGrowStep_bossAlert) then
    return
  end
  local isAlert = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eBossAlertOnOff)
  if 0 == isAlert then
    PaGlobal_BossAlert_SettingV2_All._ui.btn_alertOn:SetCheck(false)
    PaGlobal_BossAlert_SettingV2_All._ui.btn_alertOff:SetCheck(true)
  else
    PaGlobal_BossAlert_SettingV2_All._ui.btn_alertOn:SetCheck(true)
    PaGlobal_BossAlert_SettingV2_All._ui.btn_alertOff:SetCheck(false)
  end
  local isAlertKeep = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eBossAlertKeep)
  if 0 == isAlertKeep then
    PaGlobal_BossAlert_SettingV2_All._ui.btn_alertKeep:SetCheck(true)
    PaGlobal_BossAlert_SettingV2_All._ui.btn_alertNone:SetCheck(false)
  else
    PaGlobal_BossAlert_SettingV2_All._ui.btn_alertKeep:SetCheck(false)
    PaGlobal_BossAlert_SettingV2_All._ui.btn_alertNone:SetCheck(true)
  end
  Panel_BossAlert_SettingV2_All:SetPosX(getScreenSizeX() / 2 - Panel_BossAlert_SettingV2_All:GetSizeX() / 2)
  Panel_BossAlert_SettingV2_All:SetPosY(getScreenSizeY() / 2 - Panel_BossAlert_SettingV2_All:GetSizeY() / 2)
  PaGlobal_BossAlert_SettingV2_All:prepareOpen()
end
function PaGlobal_BossAlert_SettingV2_All_Close()
  PaGlobal_BossAlert_SettingV2_All:prepareClose()
end
function HandleEventLUp_SettingV2_All_CheckMinutes()
  local checkValue = 0
  if PaGlobal_BossAlert_SettingV2_All._ui.btn_30Minutes:IsCheck() then
    checkValue = checkValue + 10
  end
  if PaGlobal_BossAlert_SettingV2_All._ui.btn_15Minutes:IsCheck() then
    checkValue = checkValue + 100
  end
  if PaGlobal_BossAlert_SettingV2_All._ui.btn_5Minutes:IsCheck() then
    checkValue = checkValue + 1000
  end
  PaGlobal_BossAlert_SettingV2_All.savedPointSum = checkValue
end
function HandleEventLUp_SettingV2_All_SetSetting()
  if true == PaGlobal_BossAlert_SettingV2_All._isConsole then
    HandleEventLUp_SettingV2_All_CheckMinutes()
  end
  if PaGlobal_BossAlert_SettingV2_All._ui.btn_alertOff:IsCheck() then
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eBossAlertOnOff, 0, CppEnums.VariableStorageType.eVariableStorageType_User)
  elseif PaGlobal_BossAlert_SettingV2_All._ui.btn_alertOn:IsCheck() then
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eBossAlertOnOff, 1, CppEnums.VariableStorageType.eVariableStorageType_User)
  end
  if PaGlobal_BossAlert_SettingV2_All._ui.btn_alertKeep:IsCheck() then
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eBossAlertKeep, 0, CppEnums.VariableStorageType.eVariableStorageType_User)
  elseif PaGlobal_BossAlert_SettingV2_All._ui.btn_alertNone:IsCheck() then
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eBossAlertKeep, 1, CppEnums.VariableStorageType.eVariableStorageType_User)
  end
  PaGlobal_BossAlert_SettingV2_All_SetTime()
  PaGlobal_BossAlert_SettingV2_All_Close()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BOSSALERT_SET_CONFIRM"))
end
function FromClient_BossAlert_SettingV2_All_ReSizePanel()
  if false == PaGlobal_BossAlert_SettingV2_All._isConsole then
    PaGlobal_BossAlert_SettingV2_All._ui_pc.btn_close:ComputePos()
    PaGlobal_BossAlert_SettingV2_All._ui_pc.btn_setting:ComputePos()
    PaGlobal_BossAlert_SettingV2_All._ui_pc.btn_bossTime:ComputePos()
  else
  end
  PaGlobal_BossAlert_SettingV2_All._ui.stc_alertOnOffBG:ComputePos()
  PaGlobal_BossAlert_SettingV2_All._ui.btn_alertOn:ComputePos()
  PaGlobal_BossAlert_SettingV2_All._ui.btn_alertOff:ComputePos()
  PaGlobal_BossAlert_SettingV2_All._ui.stc_alertBG:ComputePos()
  PaGlobal_BossAlert_SettingV2_All._ui.btn_30Minutes:ComputePos()
  PaGlobal_BossAlert_SettingV2_All._ui.btn_15Minutes:ComputePos()
  PaGlobal_BossAlert_SettingV2_All._ui.btn_5Minutes:ComputePos()
  PaGlobal_BossAlert_SettingV2_All._ui.stc_alertKeepBG:ComputePos()
  PaGlobal_BossAlert_SettingV2_All._ui.btn_alertKeep:ComputePos()
  PaGlobal_BossAlert_SettingV2_All._ui.btn_alertNone:ComputePos()
  PaGlobal_BossAlert_SettingV2_All._ui.stc_bottomBG:ComputePos()
  PaGlobal_BossAlert_SettingV2_All._ui.txt_desc:ComputePos()
  PaGlobal_BossAlert_SettingV2_All:setNotice()
end
function PaGlobal_BossAlert_SettingV2_All_SetTime()
  local isCheckCount = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eBossAlertTime)
  if PaGlobal_BossAlert_SettingV2_All.savedPointSum ~= isCheckCount then
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eBossAlertTime, PaGlobal_BossAlert_SettingV2_All.savedPointSum, CppEnums.VariableStorageType.eVariableStorageType_User)
  end
end
function PaGlobal_BossAlert_SettingV2_All_GetIsShowBossAlert()
  if false == _ContetnsGroup_BossAlert then
    return false
  end
  if false == ToClient_IsGrowStepOpen(__eGrowStep_bossAlert) then
    return false
  end
  local onoffSetting = __eBossAlertOnOff
  if nil == __eBossAlertOnOff then
    onoffSetting = 65
  end
  if 0 == ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(onoffSetting) then
    return false
  end
  return true
end
function PaGlobal_BossAlert_SettingV2_All_ReturnTimeAfterAlertEnd()
  if false == Panel_BossAlert_SettingV2_All:GetShow() then
    return
  end
  local currentHour = tonumber(os.date("%H"))
  local currentMinute = tonumber(os.date("%M"))
  for ii = 1, PaGlobal_BossAlert_SettingV2_All.bossRaidCount do
    local bossHour = PaGlobal_BossAlert_SettingV2_All.bossAlert[PaGlobal_BossAlert_SettingV2_All.currentNation]._alertTime[ii][1]
    local bossMinute = PaGlobal_BossAlert_SettingV2_All.bossAlert[PaGlobal_BossAlert_SettingV2_All.currentNation]._alertTime[ii][2] + 30
    if 60 <= bossMinute then
      bossMinute = bossMinute - 60
      bossHour = bossHour + 1
      if 24 == bossHour then
        bossHour = 0
      end
    end
    if currentHour == bossHour and currentMinute == bossMinute then
      PaGlobal_BossAlert_NewAlarmClose()
    end
  end
end
function PaGlobal_BossAlert_SettingV2_All_ReturnTimeBeforeAlert()
  local bossTime = "unknown"
  local currentHour = tonumber(os.date("%H"))
  local currentMinute = tonumber(os.date("%M"))
  local alertEnd = false
  local lastMinute = 0
  PaGlobal_BossAlert_SettingV2_All.bossRaidTime = -1
  PaGlobal_BossAlert_SettingV2_All.weekly = tonumber(os.date("*t").wday)
  PaGlobal_BossAlert_SettingV2_All:setCheckUpdate()
  for ii = 1, PaGlobal_BossAlert_SettingV2_All.bossRaidCount do
    local bossHour = PaGlobal_BossAlert_SettingV2_All.bossAlert[PaGlobal_BossAlert_SettingV2_All.currentNation]._alertTime[ii][1]
    if 23 == currentHour and 0 == bossHour then
      if 0 == PaGlobal_BossAlert_SettingV2_All.weekly % 7 then
        PaGlobal_BossAlert_SettingV2_All.weekly = 1
      else
        PaGlobal_BossAlert_SettingV2_All.weekly = PaGlobal_BossAlert_SettingV2_All.weekly % 7 + 1
      end
    else
      PaGlobal_BossAlert_SettingV2_All.weekly = tonumber(os.date("*t").wday)
    end
    if 0 == bossHour and 0 ~= currentHour then
      bossHour = 24
    end
    local bossMinute = PaGlobal_BossAlert_SettingV2_All.bossAlert[PaGlobal_BossAlert_SettingV2_All.currentNation]._alertTime[ii][2]
    lastMinute = (bossHour - currentHour) * 60 + bossMinute - currentMinute
    if 0 == lastMinute then
      bossTime = ""
      PaGlobal_BossAlert_SettingV2_All.bossRaidTime = ii
      break
    end
    if 30 == lastMinute and PaGlobal_BossAlert_SettingV2_All._ui.btn_30Minutes:IsCheck() or 15 == lastMinute and PaGlobal_BossAlert_SettingV2_All._ui.btn_15Minutes:IsCheck() or 5 == lastMinute and PaGlobal_BossAlert_SettingV2_All._ui.btn_5Minutes:IsCheck() then
      bossTime = PAGetString(Defines.StringSheet_GAME, "LUA_BOSSALERT_SETTING_BEFORE" .. lastMinute)
      PaGlobal_BossAlert_SettingV2_All.bossRaidTime = ii
      break
    end
  end
  if -1 == PaGlobal_BossAlert_SettingV2_All.bossRaidTime then
    return bossTime
  end
  local bossName = PaGlobal_BossAlert_SettingV2_All_ReturnNameAlert()
  return bossTime, bossName, lastMinute
end
function PaGlobal_BossAlert_SettingV2_All_ReturnNameAlert()
  local rv = ""
  if 0 == PaGlobal_BossAlert_SettingV2_All.bossAlert[PaGlobal_BossAlert_SettingV2_All.currentNation]._bossAppearOrder[PaGlobal_BossAlert_SettingV2_All.weekly][PaGlobal_BossAlert_SettingV2_All.bossRaidTime][1] then
    return rv
  else
    for ii = 1, #PaGlobal_BossAlert_SettingV2_All.bossAlert[PaGlobal_BossAlert_SettingV2_All.currentNation]._bossAppearOrder[PaGlobal_BossAlert_SettingV2_All.weekly][PaGlobal_BossAlert_SettingV2_All.bossRaidTime] do
      if "" == rv then
        rv = PaGlobal_BossAlert_SettingV2_All.bossName[PaGlobal_BossAlert_SettingV2_All.bossAlert[PaGlobal_BossAlert_SettingV2_All.currentNation]._bossAppearOrder[PaGlobal_BossAlert_SettingV2_All.weekly][PaGlobal_BossAlert_SettingV2_All.bossRaidTime][1]]
      else
        rv = rv .. ", " .. PaGlobal_BossAlert_SettingV2_All.bossName[PaGlobal_BossAlert_SettingV2_All.bossAlert[PaGlobal_BossAlert_SettingV2_All.currentNation]._bossAppearOrder[PaGlobal_BossAlert_SettingV2_All.weekly][PaGlobal_BossAlert_SettingV2_All.bossRaidTime][ii]]
      end
    end
    return rv
  end
end
function PaGlobal_BossAlert_SettingV2_All_ReturnKeep()
  local isAlertKeep = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eBossAlertKeep)
  if 0 == isAlertKeep then
    isAlertKeep = true
  else
    isAlertKeep = false
  end
  return isAlertKeep
end
function PaGlobal_BossAlert_SettingV2_All_ShowAni()
  if nil == Panel_BossAlert_SettingV2_All then
    return
  end
  audioPostEvent_SystemUi(0, 22)
  _AudioPostEvent_SystemUiForXBOX(0, 22)
  UIAni.fadeInSCR_Down(Panel_BossAlert_SettingV2_All)
  local aniInfo1 = Panel_BossAlert_SettingV2_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.2)
  aniInfo1.AxisX = Panel_BossAlert_SettingV2_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_BossAlert_SettingV2_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_BossAlert_SettingV2_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.2)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_BossAlert_SettingV2_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_BossAlert_SettingV2_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobal_BossAlert_SettingV2_All_HideAni()
  if nil == Panel_BossAlert_SettingV2_All then
    return
  end
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
  Panel_BossAlert_SettingV2_All:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_BossAlert_SettingV2_All, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
