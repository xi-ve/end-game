function HandleEventLUp_Fishing_All_SelectGrade(grade)
  if nil == getSelfPlayer() then
    return
  end
  local discardFishingItemGrade = getSelfPlayer():ToClient_GetDiscardFishingItemGrade()
  if grade > discardFishingItemGrade + 1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_FISHGRADE_UNABLE_SELECT"))
    return
  end
  local isSelect = false
  for i = 0, PaGlobal_Fishing_All._eGradeList._count - 1 do
    if nil ~= PaGlobal_Fishing_All._ui._chk_fishGradeList[i] then
      isSelect = grade == i
      PaGlobal_Fishing_All._ui._chk_fishGradeList[i]:SetCheck(isSelect)
      PaGlobal_Fishing_All._ui._stc_gradeSelectList[i]:SetShow(isSelect)
    end
  end
  getSelfPlayer():setFishingAutoItemGrade(grade)
  PaGlobal_Fishing_All._currentSelectGrade = grade
end
function HandleEventOn_Fishing_All_ShowGradeTooltip(grade)
  local name = PaGlobal_Fishing_All._gradeString[grade]
  local control = PaGlobal_Fishing_All._ui._chk_fishGradeList[grade]
  TooltipSimple_Show(control, name)
end
function HandleEventOut_Fishing_All_HideGradeTooltip()
  TooltipSimple_Hide()
end
function HandleEventLUp_Fishing_All_AbdPreventionCheck()
  PaGlobal_Fishing_All:settingAbduction()
end
function HandleEventOn_Fishing_All_ShowHelpTooltip()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local name = PaGlobal_Fishing_All._helpText
  if false == PaGlobal_Fishing_All._stateValue._isFishing_2 and true == selfPlayer:get():isAutoFishingable() then
    local leftTimeForAuto = math.floor(Int64toInt32(selfPlayer:get():getFishingAutoLeftTime()) * 0.001)
    local leftMinute
    if 0 < math.floor(leftTimeForAuto / 60) then
      leftMinute = " (" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTY_MATCH_TIME") .. " " .. PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_MINUTE", "time_minute", math.floor(leftTimeForAuto / 60)) .. ")"
    else
      leftMinute = " (" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTY_MATCH_TIME") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_AUCTION_UNDER_ONEMINUTE") .. ")"
    end
    name = name .. "\n" .. leftMinute
  end
  local control = PaGlobal_Fishing_All._ui._stc_help
  TooltipSimple_Show(control, name)
end
function HandleEventOut_Fishing_All_HideHelpTooltip()
  TooltipSimple_Hide()
end
function HandleEventLUp_Fishing_All_Spread()
  PaGlobal_Fishing_All._isSpreading = not PaGlobal_Fishing_All._isSpreading
  PaGlobal_Fishing_All:updateSpread()
end
function PaGloabl_Fishing_All_ShowAni()
  if nil == Panel_Widget_Fishing_All then
    return
  end
  Panel_Widget_Fishing_All:SetAlpha(0)
  UIAni.AlphaAnimation(1, Panel_Widget_Fishing_All, 0, 0.22)
end
function PaGlobal_Fishing_All_GetShowPanel()
  return Panel_Widget_Fishing_All:GetShow()
end
function PaGlobal_Fishing_All_UpdateFishingResourceText()
  PaGlobal_Fishing_All:updateFishingResourceText(true)
end
function PaGlobal_Fishing_All_FishingCheck()
  PaGlobal_Fishing_All._ui._txt_purpose:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_FISHING_2"))
  PaGlobal_Fishing_All._ui._stc_spaceImage:SetShow(false)
end
function PaGlobal_Fishing_All_Fishing_Start()
  PaGlobal_Fishing_All:fishing_Start()
end
function PaGlobal_Fishing_All_Fishing_0()
  PaGlobal_Fishing_All:fishing_0()
end
function PaGlobal_Fishing_All_Fishing_1()
  PaGlobal_Fishing_All:fishing_1()
end
function PaGlobal_Fishing_All_Fishing_2()
  PaGlobal_Fishing_All:fishing_2()
end
function PaGlobal_Fishing_All_Fishing_Auto()
  PaGlobal_Fishing_All:fishing_auto()
end
function PaGlobal_Fishing_All_Jaksal_0()
  PaGlobal_Fishing_All:jaksal_0()
end
function PaGlobal_Fishing_All_Jaksal_1()
  PaGlobal_Fishing_All:jaksal_1()
end
function PaGlobal_Fishing_All_Jaksal_2()
  PaGlobal_Fishing_All:jaksal_2()
end
function PaGlobal_Fishing_All_Jaksal_3()
  PaGlobal_Fishing_All:jaksal_3()
end
function PaGlobal_Fishing_All_Jaksal_4()
  PaGlobal_Fishing_All:jaksal_4()
end
function PaGlobal_Fishing_All_Jaksal_5()
  PaGlobal_Fishing_All:jaksal_5()
end
function PaGlobal_Fishing_All_Fishing_Wait()
  PaGlobal_PowerGauge_All_Open()
end
function PaGlobal_Fishing_All_CommonGaugeOpen()
  PaGloabl_PowerGauge_All_startUpdateFrame()
end
function PaGlobal_Fishing_All_CannonGaugeOpen()
  if false == Panel_Stamina:GetShow() then
    FGlobal_CannonGauge_Open()
  end
end
function PaGlobal_Fishing_All_FishingEnd(actorKeyRaw, isSelf)
  if false == isSelf then
    return
  end
  PaGlobal_Fishing_All:prepareClose()
  PaGlobal_Fishing_All:initStateValue()
  PaGlobal_Fishing_All._isFishingStart = false
  if Panel_Widget_PowerGauge_All:GetShow() then
    PaGlobal_PowerGauge_All_Close()
  end
  if Panel_CannonGauge:GetShow() then
    FGlobal_CannonGauge_Close()
  end
end
function PaGlobal_Fishing_All_GetFishingStart()
  return PaGlobal_Fishing_All._isFishingStart
end
function PaGlobal_Fishing_All_UpdatePerFrameFunc(deltaTime)
  if false == PaGlobal_Fishing_All._isConsole then
    return
  end
  if nil == Panel_Widget_Fishing_All or false == Panel_Widget_Fishing_All:GetShow() then
    return
  end
  if nil ~= ToClient_getSnappedControl() or true == ToClient_padSnapIsUse() then
    return
  end
  local uiMode = GetUIMode()
  local isHideFishingGame = getCustomizingManager():isShow() or uiMode == Defines.UIMode.eUIMode_NpcDialog or uiMode == Defines.UIMode.eUIMode_InGameCashShop or uiMode == Defines.UIMode.eUIMode_Mental or uiMode == Defines.UIMode.eUIMode_DyeNew
  if true == isHideFishingGame then
    return
  end
  if isPadUp(__eJoyPadInputType_LeftTrigger) then
    HandleEventLUp_Fishing_All_Spread()
  end
  if true == PaGlobal_Fishing_All._isSpreading then
    if isPadUp(__eJoyPadInputType_X) then
      PaGlobal_Fishing_All._currentSelectGrade = PaGlobal_Fishing_All._currentSelectGrade + 1
      if PaGlobal_Fishing_All._eGradeList._count <= PaGlobal_Fishing_All._currentSelectGrade then
        PaGlobal_Fishing_All._currentSelectGrade = 0
      end
      HandleEventLUp_Fishing_All_SelectGrade(PaGlobal_Fishing_All._currentSelectGrade)
    elseif isPadUp(__eJoyPadInputType_Y) then
      PaGlobal_Fishing_All._ui._chk_abdPrevention:SetCheck(not PaGlobal_Fishing_All._ui._chk_abdPrevention:IsCheck())
      HandleEventLUp_Fishing_All_AbdPreventionCheck()
    end
  end
end
