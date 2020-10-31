function PaGlobal_GameOption_All:getOptionFromName(optionName)
  for elementName, option in pairs(self._elements) do
    if optionName == elementName then
      return option
    end
  end
end
function PaGlobal_GameOption_All:getOptionValue(optionName)
  local option = self._elements[optionName]
  if nil == option then
    return false
  end
  local value = option._initValue
  if nil ~= option._applyValue then
    value = option._applyValue
  end
  if nil == value then
    _PA_LOG("\237\155\132\236\167\132", "[GameOption][GET] \234\176\146\236\157\132 \236\150\187\236\150\180 \236\152\164\235\138\148\235\141\176 \236\139\164\237\140\168\237\150\136\236\138\181\235\139\136\235\139\164.  Name : " .. optionName)
  end
  return value
end
function PaGlobal_GameOption_All:setOptionValue(optionName, value)
  local option = self._elements[optionName]
  if nil == value or nil == option then
    return false
  end
  if nil == option.set then
    return false
  end
  local executeResult = option:set(value)
  if false == executeResult then
    return false
  end
  option._applyValue = value
  option._curValue = nil
  self:SetControlSetting(option, value)
end
function PaGlobal_GameOption_All:SetControlSetting(option, value)
  if "table" ~= type(option) then
    return
  end
  if nil == option._eventGroup then
    return
  end
  if nil == value then
    return
  end
  if __ePAUIControl_CheckButton == option._controlType then
    local checkButton = UI.getChildControl(option._eventGroup, "CheckButton_Template")
    checkButton:SetCheck(value)
  elseif (nil ~= option.actionInputType or nil ~= option.uiInputType) and __ePAUIControl_RadioButton == option._controlType then
    local button = UI.getChildControl(option._eventGroup, "CheckButton_Template")
    button:SetText(value)
  elseif __ePAUIControl_RadioButton == option._controlType then
    for ii = 0, option._radioButtonMapping._count - 1 do
      local radioButton = UI.getChildControl(option._eventGroup, "RadioButton_" .. tostring(ii))
      radioButton:SetCheck(value == ii)
    end
  elseif __ePAUIControl_Slider == option._controlType then
    local slider = UI.getChildControl(option._eventGroup, "Slider_Template")
    slider:SetControlPos(value * 100)
    local displayButton = UI.getChildControl(slider, "Slider_Button")
    displayButton:SetPosX(slider:GetControlButton():GetPosX())
    displayButton:SetPosY(slider:GetControlButton():GetPosY())
    local displayValue = self:FromSliderValueToRealValue(value, option._sliderValueMin, option._sliderValueMax)
    displayValue = math.floor(displayValue + 0.5)
    local sliderCurrentText = UI.getChildControl(option._eventGroup, "StaticText_Current")
    sliderCurrentText:SetText("<PAColor0xfff5ba3a>" .. displayValue .. "<PAOldColor>")
    if "CropModeScaleX" == option._name then
      sliderCurrentText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_GRAPHIC_WINDOW_CropModeScaleX"))
    elseif "CropModeScaleY" == option._name then
      sliderCurrentText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_GRAPHIC_WINDOW_CropModeScaleY"))
    end
  elseif __ePAUIControl_ComboBox == option._controlType then
    local combobox = UI.getChildControl(option._eventGroup, "Combobox2_1")
    if -1 == value then
      combobox:SetSelectItemIndex(-1)
      combobox:SetText(self._userInitScreenResolution.width .. "x" .. self._userInitScreenResolution.height)
    elseif value ~= combobox:GetSelectIndex() then
      local width = self._availableResolutionList:getDisplayModeWidth(value)
      local height = self._availableResolutionList:getDisplayModeHeight(value)
      combobox:SetText(width .. "x" .. height)
    end
  else
    if __ePAUIControl_Button == option._controlType then
      local currentOption = UI.getChildControl(option._eventGroup, "StaticText_Page")
      local buttonText = option:GetButtonText(value)
      currentOption:SetText(buttonText)
    else
    end
  end
end
function PaGlobal_GameOption_All:ResetControlSetting(option)
  if "table" ~= type(option) then
    return
  end
  if nil == option then
    return
  end
  if nil == option._eventGroup then
    return
  end
  if __ePAUIControl_CheckButton == option._controlType then
    local checkButton = UI.getChildControl(option._eventGroup, "CheckButton_Template")
    checkButton:SetCheck(false)
  elseif (nil ~= option.actionInputType or nil ~= option.uiInputType) and __ePAUIControl_RadioButton == option._controlType then
    local button = UI.getChildControl(option._eventGroup, "CheckButton_Template")
    button:SetCheck(false)
    button:SetText("")
  elseif __ePAUIControl_RadioButton == option._controlType then
    for ii = 0, option._radioButtonMapping._count - 1 do
      local radioButton = UI.getChildControl(option._eventGroup, "RadioButton_" .. tostring(ii))
      radioButton:SetCheck(false)
    end
  elseif __ePAUIControl_Slider == option._controlType then
    local slider = UI.getChildControl(option._eventGroup, "Slider_Template")
    slider:SetControlPos(50)
  elseif __ePAUIControl_ComboBox == option._controlType then
  else
    if __ePAUIControl_Button == option._controlType then
    else
    end
  end
end
function PaGlobal_GameOption_All:SetCurrentValue(controlName, cacheNo, order)
  local strsplit = string.split(controlName, "_")
  if nil == strsplit[1] or nil == strsplit[2] then
    _PA_LOG("\237\155\132\236\167\132", "[EventXXX][ RETURN ] control\236\157\152 \235\178\132\237\138\188 \236\157\180\235\178\164\237\138\184\234\176\128 \236\158\152\235\170\187\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164. ControlName\236\157\132 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. : " .. elementName)
    return
  end
  local controlTypeName = strsplit[1]
  local elementName = strsplit[2]
  local option = self._elements[elementName]
  if "table" ~= type(option) then
    _PA_LOG("\237\155\132\236\167\132", "[EventXXX][ RETURN ] element \234\176\128 \237\133\140\236\157\180\235\184\148\236\157\180 \236\149\132\235\139\153\235\139\136\235\139\164. Header \235\165\188 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148.  : " .. elementName)
    return
  end
  if false == PaGlobal_GameOption_All:isOpen() then
    return
  end
  local beforeValue = option._curValue
  local controlType = self:GetControlTypeByControlName(controlTypeName)
  local groupBg
  if __ePAUIControl_CheckButton == controlType then
    groupBg = self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.CHECKBUTTON][cacheNo]
    local checkButton = UI.getChildControl(groupBg, "CheckButton_Template")
    option._curValue = checkButton:IsCheck()
  elseif nil ~= option.actionInputType or nil ~= option.uiInputType then
    if true == PaGlobal_GameOption_All._confirmKeyCustomizing then
      PaGlobal_GameOption_All._confirmKeyCustomizing = false
      return
    end
    self:SetKeyCustomMode(elementName)
    self:SetControlSetting(elementName, "")
  elseif __ePAUIControl_RadioButton == controlType then
    groupBg = self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOBUTTON][cacheNo]
    option._curValue = order
  elseif __ePAUIControl_Slider == controlType then
    if true == option._isSubSlider then
      groupBg = self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.SUBSLIDER][cacheNo]
    else
      groupBg = self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.SLIDER][cacheNo]
    end
    local slider = UI.getChildControl(groupBg, "Slider_Template")
    option._curValue = slider:GetControlPos()
  elseif __ePAUIControl_ComboBox == controlType then
    groupBg = self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.COMBOBOX][cacheNo]
    local combobox = UI.getChildControl(groupBg, "Combobox2_1")
    option._curValue = combobox:GetSelectIndex()
  elseif __ePAUIControl_Button == controlType then
    local tempindex = option._initValue
    if nil ~= option._applyValue then
      tempindex = option._applyValue
    end
    if nil ~= option._curValue then
      tempindex = option._curValue
    end
    local filterSize = getCameraLUTFilterSize()
    option._curValue = (tempindex + order) % filterSize
  else
    _PA_LOG("\237\155\132\236\167\132", "[EventXXX][ RETURN ] \235\172\180\236\138\168 Control \236\157\184\236\167\128 \235\170\168\235\165\180\234\178\160\236\138\181\235\139\136\235\139\164. : " .. elementName)
    return
  end
  if nil == option._curValue then
    return
  end
  self:SetCurrentValueException(elementName, option._curValue, beforeValue)
  self:SetControlSetting(option, option._curValue)
  if true == option._settingRightNow then
    self:setOptionValue(elementName, option._curValue)
    option._curValue = option:get(ToClient_getGameOptionControllerWrapper())
    option._applyValue = nil
  end
  if nil ~= option._applyValue then
    if option._curValue == option._applyValue then
      option._curValue = nil
    end
  elseif option._curValue == option._initValue and false == option._settingRightNow then
    option._curValue = nil
  end
  local applyButtonEnable = false
  for _, option in pairs(self._elements) do
    if nil ~= option._curValue then
      applyButtonEnable = true
    end
  end
  self:ApplyButtonEnable(applyButtonEnable)
  ClearFocusEdit()
end
function PaGlobal_GameOption_All:SetCurrentValueException(elementName, value, beforeValue)
  if nil == self._elements[elementName].EventException then
    return
  end
  self._elements[elementName]:EventException(value, beforeValue)
end
function PaGlobal_GameOption_All._elements.ShowSpawnableNPC:EventException(value)
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_USESPAWNABLE_RESTART"),
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_GameOption_All._elements.ServiceResourceType:EventException(value)
  local serviceResourceType = PaGlobal_GameOption_All:radioButtonMapping_ServiceResourceType(value)
  local chatChannelType = PaGlobal_GameOption_All._elements.ChatChannelType
  if CppEnums.ServiceResourceType.eServiceResourceType_SP == serviceResourceType then
    chatChannelType._curValue = PaGlobal_GameOption_All:radioButtonMapping_ChatChannelType(CppEnums.LangType.LangType_SP, true)
  else
    chatChannelType._curValue = PaGlobal_GameOption_All:radioButtonMapping_ChatChannelType(serviceResourceType, true)
  end
  PaGlobal_GameOption_All:ResetControlSetting(chatChannelType)
  PaGlobal_GameOption_All:SetControlSetting(chatChannelType, chatChannelType._curValue)
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_LANGUAGESETTING"),
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_GameOption_All._elements.ChatChannelType:EventException(value)
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_LANGUAGESETTING"),
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_GameOption_All._elements.GraphicOption:EventException(value, beforeValue)
  local GraphicEnum = PaGlobal_GameOption_All.GRAPHIC
  local option = PaGlobal_GameOption_All._elements.GraphicOption
  if nil ~= option._curValue then
    if nil == beforeValue then
      beforeValue = option._initValue
    end
    if beforeValue == value then
      PaGlobal_GameOption_All:SetGraphicOption(option._curValue)
    end
    local isIncrease = value > beforeValue
    if GraphicEnum.VeryVeryLow == value then
      isIncrease = false
    end
    if GraphicEnum.VeryVeryLow == beforeValue then
      isIncrease = true
    end
    PaGlobal_GameOption_All:SetGraphicOption(value, isIncrease)
    if GraphicEnum.UltraHigh == value then
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_GRAPHICMODE_ALERTTITLE"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_GRAPHICMODE_ALERTDESC2"),
        functionApply = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    elseif GraphicEnum.UltraLow == value then
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_GRAPHICMODE_ALERTTITLE"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_GRAPHICMODE_ALERTDESC"),
        functionApply = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
  end
end
function PaGlobal_GameOption_All._elements.UIFontType:EventException(value)
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_UIFONTTYPE_RESTART"),
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_GameOption_All._elements.DataOptimize:EventException(value)
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_USEMEMORYOPTI_RESTART"),
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameOption_OptionFunc_All_1.lua")
runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameOption_OptionFunc_All_2.lua")
