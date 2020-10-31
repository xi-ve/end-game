function FGlobal_IsChecked_SkillCommand()
  return PaGlobal_GameOption_All._isChecked_SkillCommand
end
function PaGlobal_GameOption_All_SetSkillCommandPanel(check)
  PaGlobal_GameOption_All:SetSkillCommandPanel(check)
end
function PaGlobal_GameOption_All:SetSkillCommandPanel(check)
  self._isChecked_SkillCommand = check
  if nil ~= Panel_SkillCommand then
    if true == check then
      local pcPosition = getSelfPlayer():get():getPosition()
      local regionInfo = getRegionInfoByPosition(pcPosition)
      if false == regionInfo:get():isSafeZone() then
        FGlobal_SkillCommand_Show(true)
      end
    else
      Panel_SkillCommand:SetShow(false)
    end
  end
end
function PaGlobal_GameOption_All:getRecommendUIScale()
  return math.floor(getResolutionSizeY() / self._recommendUIScaleBase * 100)
end
function PaGlobal_GameOption_All:optimizationUIScale()
  local messageboxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_UISCALE_MESSAGEBOX_DESC")
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_UISCALE_MESSAGEBOX_TITLE"),
    content = messageboxMemo,
    functionYes = PaGlobal_GameOption_All_OptimizationUIScaleYes,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData, nil, false, true, 3)
end
function PaGlobal_GameOption_All_OptimizationUIScaleYes()
  local option = PaGlobal_GameOption_All:getOptionFromName("UIScale")
  if nil == option then
    return
  end
  local recommendUIScale = PaGlobal_GameOption_All:getRecommendUIScale()
  local sliderValue = PaGlobal_GameOption_All:FromRealValueToSliderValue(recommendUIScale, option._sliderValueMin, option._sliderValueMax)
  option._curValue = sliderValue
  PaGlobal_GameOption_All:setOptionValue("UIScale", sliderValue)
end
function FGlobal_getUIScale()
  local option = PaGlobal_GameOption_All:getOptionFromName("UIScale")
  if nil == option then
    return
  end
  local uiScale = {}
  uiScale.min = option._sliderValueMin
  uiScale.max = option._sliderValueMax
  return uiScale
end
function FGlobal_returnUIScale()
  local interval = PaGlobal_GameOption_All._elements.UIScale._sliderValueMax - PaGlobal_GameOption_All._elements.UIScale._sliderValueMin
  local convertedValue = (PaGlobal_GameOption_All._elements.UIScale._sliderValueMin + interval * PaGlobal_GameOption_All:getOptionValue("UIScale")) * 0.01
  convertedValue = math.floor((convertedValue + 0.002) * 100) / 100
  return convertedValue
end
function FGlobal_saveUIScale(scale)
  local option = PaGlobal_GameOption_All:getOptionFromName("UIScale")
  if nil == option then
    return
  end
  local sliderValue = PaGlobal_GameOption_All:FromRealValueToSliderValue(scale * 100, option._sliderValueMin, option._sliderValueMax)
  if 1 <= sliderValue then
    return
  end
  PaGlobal_GameOption_All:SetControlSetting("UIScale", PaGlobal_GameOption_All:FromRealValueToSliderValue(scale, option._sliderValueMin, option._sliderValueMax))
end
function ResetKeyCustombyAttacked()
  if Panel_Window_GameOption_All:GetShow() then
    setKeyCustomizing(false)
    SetUIMode(Defines.UIMode.eUIMode_Default)
  end
end
function PaGlobal_GameOption_All:GetKeyCustomInputType()
  if nil == self._keyCustomInputType then
    _PA_LOG("\237\155\132\236\167\132", "[GetKeyCustomInputType][ RETURN ] \236\157\180\236\131\129\237\149\152\235\139\164....")
    return
  end
  return self._keyCustomInputType[2] or nil
end
function PaGlobal_GameOption_All:SetKeyCustomMode(elementName)
  setKeyCustomizing(false)
  SetUIMode(Defines.UIMode.eUIMode_Default)
  self:ResetKeyCustomString()
  local option = self._elements[elementName]
  if nil ~= option.actionInputType then
    self._keyCustomInputType = {
      elementName,
      option.actionInputType
    }
    if "PadFunction1" == option.actionInputType then
      SetUIMode(Defines.UIMode.eUIMode_KeyCustom_ActionPadFunc1)
      return
    elseif "PadFunction2" == option.actionInputType then
      SetUIMode(Defines.UIMode.eUIMode_KeyCustom_ActionPadFunc2)
      return
    end
    if true == self._keyCustomPadMode then
      SetUIMode(Defines.UIMode.eUIMode_KeyCustom_ActionPad)
    else
      SetUIMode(Defines.UIMode.eUIMode_KeyCustom_ActionKey)
    end
    setKeyCustomizing(true)
  elseif nil ~= option.uiInputType then
    self._keyCustomInputType = {
      elementName,
      option.uiInputType
    }
    if true == self._keyCustomPadMode then
      SetUIMode(Defines.UIMode.eUIMode_KeyCustom_UiPad)
    else
      SetUIMode(Defines.UIMode.eUIMode_KeyCustom_UiKey)
    end
    setKeyCustomizing(true)
  end
end
function PaGlobal_GameOption_All:ResetKeyCustomString()
  if nil == self._currentFrame then
    return
  end
  for frame, frameElement in pairs(self._currentFrame) do
    local option = frameElement._element
    if nil ~= option and (nil ~= option.actionInputType or nil ~= option.uiInputType) and nil ~= option._eventGroup then
      self:SetControlSetting(option, self:KeyCustomGetString(option))
    end
  end
end
function PaGlobal_GameOption_All:CompleteKeyCustomMode()
  if nil == self._keyCustomInputType then
    _PA_LOG("\237\155\132\236\167\132", "[CompleteKeyCustomMode][ RETURN ] \234\184\176\236\161\180 Option \236\176\189 \236\149\132\235\139\136\235\157\188\235\169\180 \236\157\180\236\131\129\237\149\152\235\139\164")
    return
  end
  local elementName = self._keyCustomInputType[1] or nil
  if nil == elementName then
    _PA_LOG("\237\155\132\236\167\132", "[CompleteKeyCustomMode][ RETURN ] \236\157\180\236\131\129\237\149\152\235\139\164")
    return
  end
  self._elements[elementName]._keyCustomInputType = nil
  self._elements[elementName]._curValue = ""
  self:ApplyButtonEnable(true)
  self:ResetControlSetting(self._elements[elementName])
  self:ResetKeyCustomString()
end
function PaGlobal_GameOption_All:KeyCustomGetString(option)
  local keyCustomString
  if nil ~= option.uiInputType then
    if true == self._keyCustomPadMode then
      keyCustomString = keyCustom_GetString_UiPad(option.uiInputType)
    else
      keyCustomString = keyCustom_GetString_UiKey(option.uiInputType)
    end
  elseif nil ~= option.actionInputType then
    if "PadFunction1" == option.actionInputType then
      return keyCustom_GetString_ActionPadFunc1()
    end
    if "PadFunction2" == option.actionInputType then
      return keyCustom_GetString_ActionPadFunc2()
    end
    if true == self._keyCustomPadMode then
      if true == _ContentsGroup_RenewUI then
        keyCustomString = keyCustom_GetWSymbol_ActionPad(option.actionInputType)
      else
        keyCustomString = keyCustom_GetString_ActionPad(option.actionInputType)
      end
    else
      keyCustomString = keyCustom_GetString_ActionKey(option.actionInputType)
    end
  end
  return keyCustomString
end
function PaGlobal_GameOption_All:setKeyCustomizingConfirm(isSet)
  PaGlobal_GameOption_All._keyCustomizingConfirm = isSet
end
function PaGlobal_GameOption_All:getKeyCustomizingConfirm()
  return PaGlobal_GameOption_All._keyCustomizingConfirm
end
function PaGlobal_GameOption_All:DisplayChanged()
  local messageboxData = {
    title = "changeDisplay",
    content = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_DISPLAYCOMMIT_COMMENT"),
    functionApply = PaGlobal_GameOption_All_ChangeDisplayApply,
    functionCancel = PaGlobal_GameOption_All_ChangeDisplayCancel,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW,
    isTimeCount = true,
    countTime = 10,
    timeString = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_DISPLAYCOMMIT_TIMELEFT"),
    isStartTimer = true,
    afterFunction = PaGlobal_GameOption_All_ChangeDisplayTimeOut
  }
  allClearMessageData()
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_GameOption_All_ChangeDisplayTimeOut()
  if true == MessageBox.isPopUp() then
    messageBox_CancelButtonUp()
  end
end
function PaGlobal_GameOption_All_ChangeDisplayApply()
  if isNeedGameOptionFromServer() == true then
    FGlobal_QuestWindowRateSetting()
  end
  keyCustom_applyChange()
  keyCustom_StartEdit()
  PaGlobal_GameOption_All:ApplyButtonEnable(false)
  saveGameOption(true)
  reloadGameUI()
end
function PaGlobal_GameOption_All_ChangeDisplayCancel()
  PaGlobal_GameOption_All:setOptionValue("ScreenResolution", PaGlobal_GameOption_All._elements.ScreenResolution._initValue)
  PaGlobal_GameOption_All:setOptionValue("UIScale", PaGlobal_GameOption_All._elements.UIScale._initValue)
  PaGlobal_GameOption_All:setOptionValue("ScreenMode", PaGlobal_GameOption_All._elements.ScreenMode._initValue)
end
function PaGlobal_GameOption_All_PerFrameFPSTextUpdate()
  if nil == PaGlobal_GameOption_All._fpsTextControl or false == PaGlobal_GameOption_All._fpsTextControl:GetShow() then
    return
  end
  local value = math.floor(ToClient_getFPS())
  if value < 20 then
    PaGlobal_GameOption_All._fpsTextControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_FPS") .. ": " .. "<PAColor0xfff25221>" .. tostring(value) .. "<PAOldColor>")
  else
    PaGlobal_GameOption_All._fpsTextControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_FPS") .. ": " .. "<PAColor0xff00f281>" .. tostring(value) .. "<PAOldColor>")
  end
end
