function FGlobal_Option_GetShow()
  return Panel_Window_GameOption_All:GetShow()
end
function PaGlobal_GameOption_All:isOpen()
  return Panel_Window_GameOption_All:GetShow()
end
function PaGlobal_GameOption_All:Open()
  ClearFocusEdit()
  if isNeedGameOptionFromServer() == true then
    keyCustom_StartEdit()
  end
  local tree2 = self._ui.list2_category
  for key, value in pairs(self._list2._tree2IndexMap) do
    if value._isMain then
      local keyElement = tree2:getElementManager():getByKey(toInt64(0, key), false)
      keyElement:setIsOpen(false)
    end
  end
  tree2:getElementManager():refillKeyList()
  tree2:moveTopIndex()
  if true == isNeedGameOptionFromServer() then
    self:movePage(self.PAGE.Main)
  else
    self:movePage(self.PAGE.Category)
    if true == isGameTypeKR2() then
      self:SelectOptionFrame("Performance", "GraphicQuality")
    else
      self:SelectOptionFrame("Function", "Nation")
    end
  end
  if _ContentsGroup_isConsolePadControl then
    self:movePage(self.PAGE.Category)
    self:SelectOptionFrame("Function", "Alert")
  end
  if false == isNeedGameOptionFromServer() then
    self._ui.btn_home:SetIgnore(true)
    self._ui.btn_home:SetMonoTone(true)
    self._ui.btn_saveSetting:SetIgnore(true)
    self._ui.btn_saveSetting:SetMonoTone(true)
    self._ui.btn_resetAll:SetIgnore(true)
    self._ui.btn_resetAll:SetMonoTone(true)
    self._ui.btn_resetCache:SetIgnore(true)
    self._ui.btn_resetCache:SetMonoTone(true)
    self._ui.edit_search:SetIgnore(true)
    self._ui.edit_search:SetMonoTone(true)
    self._ui.btn_search:SetIgnore(true)
    self._ui.btn_search:SetMonoTone(true)
  end
  Panel_Window_GameOption_All:SetShow(true)
  Panel_Window_GameOption_All:SetIgnore(false)
  self._ui.btn_apply:setRenderTexture(self._ui.btn_apply:getBaseTexture())
  self._ui.btn_confirm:setRenderTexture(self._ui.btn_confirm:getBaseTexture())
  audioPostEvent_SystemUi(1, 0)
  _AudioPostEvent_SystemUiForXBOX(1, 0)
  self:ApplyButtonEnable(false)
end
function PaGlobal_GameOption_All:Close()
  self._isExit = true
  self._list2._selectedKey = -1
  self:movePage(self.PAGE.Main)
  for elemeneName, option in pairs(self._elements) do
    if true == option._settingRightNow and nil == option._applyValue and nil ~= option._curValue then
      self:setOptionValue(elemeneName, option._initValue)
    end
    option._curValue = nil
  end
  keyCustom_RollBack()
  setKeyCustomizing(false)
  SetUIMode(Defines.UIMode.eUIMode_Default)
  Panel_Window_GameOption_All:SetShow(false, true)
  if Panel_Tooltip_SimpleText:GetShow() then
    TooltipSimple_Hide()
  end
  if true == self._ui.stc_pictureTooltip:GetShow() then
    self._ui.stc_pictureTooltip:SetShow(false)
  end
  audioPostEvent_SystemUi(1, 0)
  _AudioPostEvent_SystemUiForXBOX(1, 0)
end
function GameOption_Cancel()
  PaGlobal_GameOption_All:Close()
end
function PaGlobal_GameOption_All:movePage(value)
  self._ui._currentPage = value
  if self.PAGE.Category == value then
    self._ui._frame:SetShow(true)
    self._ui.stc_rightBG:SetShow(false)
    self._ui.list2_search:SetShow(false)
    self._ui.stc_bottomBg:SetShow(false)
    self._ui.stc_verticalLine:SetSize(self._ui.stc_verticalLine:GetSizeX(), self._ui._frame:GetSizeY())
    self._ui.btn_resetCache:SetShow(false)
    self._ui.btn_saveCustom1:SetShow(true)
    self._ui.btn_saveCustom2:SetShow(true)
  elseif self.PAGE.Main == value then
    self._ui._frame:SetShow(false)
    self._ui.stc_rightBG:SetShow(true)
    self._ui.list2_search:SetShow(false)
    self._ui.stc_bottomBg:SetShow(true)
    self._ui.stc_verticalLine:SetSize(self._ui.stc_verticalLine:GetSizeX(), self._ui.stc_rightBG:GetSizeY())
    self:ResetListToggleState()
    self._ui.btn_resetCache:SetShow(true)
    self._ui.btn_saveCustom1:SetShow(false)
    self._ui.btn_saveCustom2:SetShow(false)
    self._list2._selectedKey = nil
    self._list2._selectedSubKey = nil
  elseif self.PAGE.Search == value then
    self._ui._frame:SetShow(false)
    self._ui.stc_rightBG:SetShow(false)
    self._ui.list2_search:SetShow(true)
    self._ui.stc_bottomBg:SetShow(false)
    self._ui.stc_verticalLine:SetSize(self._ui.stc_verticalLine:GetSizeX(), self._ui._frame:GetSizeY())
    self._ui.btn_resetCache:SetShow(false)
    self._ui.btn_saveCustom1:SetShow(true)
    self._ui.btn_saveCustom2:SetShow(true)
  end
  self._ui.edit_search:SetEditText("")
  ClearFocusEdit()
end
function PaGlobal_GameOption_All:SelectOptionFrame(category, detail, moveElement)
  self:movePage(PaGlobal_GameOption_All.PAGE.Category)
  self:CreateFrame(category, detail, moveElement)
  self._list2._curCategory = category
  self._list2._curDetail = detail
end
function PaGlobal_GameOption_All:GoCategory(clickCategory, clickDetail, moveElement)
  local isPrevCategory = false
  for key, table in pairs(self._list2._tree2IndexMap) do
    if clickCategory == table._category then
      if key == self._list2._selectedKey then
        isPrevCategory = true
      end
      self:ClickedMainCategory(key, table._category)
      break
    end
  end
  for key, table in pairs(self._list2._tree2IndexMap) do
    if nil == clickDetail then
      if clickCategory == table._category and nil ~= table._detail then
        if false == isPrevCategory then
          self:ClickedSubCategory(key, table._category, table._detail)
          break
        elseif key == self._list2._selectedSubKey then
          self:ClickedSubCategory(key, table._category, table._detail)
          break
        end
      end
    elseif clickCategory == table._category and clickDetail == table._detail then
      self:ClickedSubCategory(key, table._category, table._detail, moveElement)
      break
    end
  end
  self:movePage(self.PAGE.Category)
end
function FGlobal_GameOptionOpen()
  if false == PaGlobal_GameOption_All:isOpen() then
    showGameOption()
  end
  PaGlobal_GameOption_All:movePage(PaGlobal_GameOption_All.PAGE.Category)
  PaGlobal_GameOption_All:GoCategory("Function", "Nation")
end
function PaGlobal_GameOption_All:OpenCombobox(cacheNo)
  local groupBg = self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.COMBOBOX][cacheNo]
  local combobox = UI.getChildControl(groupBg, "Combobox2_1")
  combobox:ToggleListbox()
end
function PaGlobal_GameOption_All:ApplyButtonEnable(enable)
  self._ui.btn_apply:SetEnable(enable)
  self._ui.btn_apply:SetMonoTone(not enable)
end
function FromClient_GameOption_All_RefreshGameOption(gameOptionSetting)
  PaGlobal_GameOption_All._resetCheck = false
  FromClient_GameOption_All_InitializeOption(gameOptionSetting)
end
function FromClient_GameOption_All_InitializeOption(gameOptionSetting)
  PaGlobal_GameOption_All:InitValue(gameOptionSetting)
  PaGlobal_GameOption_All:InitSetting()
  if true == PaGlobal_GameOption_All._resetCheck then
    for elementName, option in pairs(PaGlobal_GameOption_All._elements) do
      option._curValue = nil
      option._applyValue = nil
      PaGlobal_GameOption_All:setOptionValue(elementName, option._initValue)
    end
    PaGlobal_GameOption_All._resetCheck = nil
  end
end
function PaGlobal_GameOption_All:InitValue(gameOptionSetting)
  for name, option in pairs(self._elements) do
    option._curValue = nil
    option._applyValue = nil
    option._name = name
    if nil ~= option.get then
      option._initValue = option:get(gameOptionSetting)
    end
  end
  self:ScreenResolutionComboBoxInit()
  self._userInitScreenResolution.width = gameOptionSetting:getScreenResolutionWidth()
  self._userInitScreenResolution.height = gameOptionSetting:getScreenResolutionHeight()
  local ultraResolutionWidth = 3840
  local ultraResolutionHeight = 2160
  if ultraResolutionWidth <= gameOptionSetting:getScreenResolutionWidth() and ultraResolutionHeight <= gameOptionSetting:getScreenResolutionHeight() then
    self._elements.UltraHighDefinition._initValue = true
  else
    self._elements.UltraHighDefinition._initValue = false
  end
  self._contrastValue = self._elements.ContrastValue:get(gameOptionSetting)
  if 1 == self._elements.LUT:get(gameOptionSetting) then
    self._isContrast = true
  end
  self._keyCustomPadMode = gameOptionSetting:getGamePadEnable() or ToClient_isUsePadSnapping()
  self._elements.KeyCustomMode._initValue = self._elements.KeyCustomMode:get(gameOptionSetting)
  for name, option in pairs(self._elements) do
    if nil ~= option.actionInputType or nil ~= option.uiInputType then
      option._initValue = self:KeyCustomGetString(option)
    end
  end
  FromClient_GameOption_All_RefreshMaidOptionInfo(gameOptionSetting)
  self:SetSkillCommandPanel(gameOptionSetting:getShowSkillCmd())
  setRotateRadarMode(self._elements.RotateRadarMode:get(gameOptionSetting))
  setAutoRunCamera(self._elements.AutoRunCamera:get(gameOptionSetting))
  setAutoRunCameraRotation(self._elements.AutoRunCameraRotation:get(gameOptionSetting))
end
function PaGlobal_GameOption_All:InitSetting()
  for name, option in pairs(self._elements) do
    if type(option) ~= "table" then
      _PA_LOG("\237\155\132\236\167\132", "[ InitSetting ] option \236\157\180 table\236\157\180 \236\149\132\235\139\153\235\139\136\235\139\164.")
    elseif option._initValue == nil then
      _PA_LOG("\237\155\132\236\167\132", "element init value\234\176\128 Null \236\158\133\235\139\136\235\139\164. " .. name)
    else
      self:ResetControlSetting(option)
      self:SetControlSetting(name, option._initValue)
    end
  end
end
function FromClient_GameOption_All_InitializeScreenResolution(availableScreenResolution)
  PaGlobal_GameOption_All._availableResolutionList = availableScreenResolution
end
function PaGlobal_GameOption_All:ScreenResolutionComboBoxInit()
  local option = self._elements.ScreenResolution
  option._comboBoxList = {}
  option._comboBoxListCount = self._availableResolutionList:getDisplayModeListSize()
  for ii = 0, option._comboBoxListCount - 1 do
    option._comboBoxList[ii] = tostring(self._availableResolutionList:getDisplayModeWidth(ii)) .. "x" .. tostring(self._availableResolutionList:getDisplayModeHeight(ii))
  end
end
function PaGlobal_GameOption_All_ShowTooltip(isShow, tooltipName)
  local tooltipData = PaGlobal_GameOption_All._tooltip[tooltipName]
  if nil == tooltipData then
    return
  end
  if true == isShow then
    TooltipSimple_Show(tooltipData.control, "", tooltipData.desc)
  else
    TooltipSimple_Hide()
  end
end
function PaGlobal_GameOption_All_ShowHomeTooltip(isShow, tooltipName)
  local tooltipData = PaGlobal_GameOption_All._homeTooltip[tooltipName]
  if nil == tooltipData then
    return
  end
  if true == isShow then
    TooltipSimple_Show(tooltipData.control, tooltipData.name)
  else
    TooltipSimple_Hide()
  end
end
function PaGlobal_GameOption_All_ShowResetTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local group = PaGlobal_GameOption_All._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.PAGETITLE][0]
  if nil == group then
    return
  end
  local control = UI.getChildControl(group, "Button_ResetFrame")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEWGAMEOPTION_TOOLTIPDESC_RESETBUTTON")
  TooltipSimple_Show(control, "", desc)
end
function PaGlobal_GameOption_All_ShowPictureToolTip(isShow, elementName)
  if false == isShow then
    PaGlobal_GameOption_All._ui.stc_pictureTooltip:SetShow(false)
    return
  end
  PaGlobal_GameOption_All:SetPictureTooltip(elementName)
  PaGlobal_GameOption_All._ui.stc_pictureTooltip:SetShow(true)
  local posX = getMousePosX() - Panel_Window_GameOption_All:GetPosX()
  local posY = getMousePosY() - Panel_Window_GameOption_All:GetPosY()
  PaGlobal_GameOption_All._ui.stc_pictureTooltip:SetPosX(posX)
  PaGlobal_GameOption_All._ui.stc_pictureTooltip:SetPosY(posY)
end
function PaGlobal_GameOption_All:SetPictureTooltip(elementName)
  local control = self._ui.stc_pictureTooltip
  local textureName = self._elements[elementName]._tooltipTexture
  control:ChangeTextureInfoNameDefault(textureName)
  control:getBaseTexture():setUV(0, 0, 1, 1)
  control:setRenderTexture(control:getBaseTexture())
  local tooltipSize = self._elements[elementName]._tooltipSize
  if nil ~= tooltipSize then
    control:SetSize(tooltipSize.x, tooltipSize.y)
  end
end
function PaGlobal_GameOption_All:ScreenShotQualityTooltip(isShow, cacheNo, idx, elementName)
  if false == isShow or nil == isShow or 0 == idx then
    TooltipSimple_Hide()
    return
  end
  if "ScreenShotQuality" ~= elementName then
    TooltipSimple_Hide()
    return
  end
  local groupBg = self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOBUTTON][cacheNo]
  local control = UI.getChildControlNoneAssert(groupBg, "RadioButton_" .. tostring(idx))
  if nil == control then
    return
  end
  local name = ""
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_HIGHRESOLUTION_SCREENSHOT_ALERT")
  TooltipSimple_Show(control, name, desc)
end
function PaGlobal_GameOption_All:UltraModeTooltip(isShow, cacheNo, elementName)
  if false == isShow or nil == isShow then
    TooltipSimple_Hide()
    return
  end
  if "GraphicOption" ~= elementName then
    TooltipSimple_Hide()
    return
  end
  local groupBg = self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOBUTTON2][cacheNo]
  local ultraModeIndex = self.GRAPHIC.UltraHigh
  local control = UI.getChildControlNoneAssert(groupBg, "RadioButton_" .. tostring(ultraModeIndex))
  if nil == control then
    return
  end
  local name = ""
  local desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_GRAPHIC_QUALITY_GraphicUltraHigh_Tooltip")
  TooltipSimple_Show(control, name, desc)
end
function FromClient_GameOption_All_OnScreenResize()
  local screenSizeX = getOriginScreenSizeX()
  local screenSizeY = getOriginScreenSizeY()
  Panel_Window_GameOption_All:SetPosX((screenSizeX - Panel_Window_GameOption_All:GetSizeX()) / 2)
  Panel_Window_GameOption_All:SetPosY((screenSizeY - Panel_Window_GameOption_All:GetSizeY()) / 2)
  local uiScale = PaGlobal_GameOption_All:getOptionValue("UIScale")
  if nil == uiScale then
    return
  end
  uiScale = uiScale + 0.002
  PaGlobal_GameOption_All:SetControlSetting("UIScale", uiScale)
end
function FromClient_GameOption_All_TogglePanel()
  if CppEnums.EProcessorInputMode.eProcessorInputMode_ChattingInputMode == UI.Get_ProcessorInputMode() then
    return
  end
  if GetUIMode() == Defines.UIMode.eUIMode_Gacha_Roulette then
    return
  end
  if false == PaGlobal_GameOption_All:isOpen() then
    PaGlobal_GameOption_All:Open()
  else
    PaGlobal_GameOption_All:Close()
  end
end
function FromClient_GameOption_All_ChangeScreenMode()
  reloadGameUI()
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_CHANGESCREENMODE_FULL")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = messageBoxMemo,
    functionYes = ToClient_ChangePreScreenMode,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_GameOption_All_CanChangeOptionAfterSec(sec)
  if false == _ContentsGroup_StatTierIcon then
    return
  end
  local msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CANTCHANGE_TIERICONOPTION_COOLTIME", "sec", sec)
  if nil ~= msg and "" ~= msg then
    Proc_ShowMessage_Ack(msg)
  end
end
function FromClient_GameOption_All_RefreshMaidOptionInfo(gameOptionSetting)
  local elems_ = PaGlobal_GameOption_All._elements
  local curValue = PaGlobal_GameOption_All:getOptionValue("MaidView") * elems_.MaidView._sliderValueMax
  elems_.MaidView._sliderValueMax = gameOptionSetting:getMaidMaxCount()
  elems_.MaidView._initValue = PaGlobal_GameOption_All:FromRealValueToSliderValue(curValue, 0, gameOptionSetting:getMaidMaxCount())
  PaGlobal_GameOption_All:setOptionValue("MaidView", PaGlobal_GameOption_All._elements.MaidView._initValue)
end
function FromClient_GameOption_All_OtherPlayerUpdate(isEnable, isOption)
  if true == isOption then
    isEnable = not isEnable
  else
    PaGlobal_GameOption_All:SetControlSetting("UseOtherPlayerUpdate", not isEnable)
  end
  setUseOtherPlayerUpdate(isEnable)
  if isEnable then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TOOLTIP_PLAYERHIDEOFF"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TOOLTIP_PLAYERHIDEON"))
  end
end
function FGlobal_GetCurrentLUT()
  local gameOptionSetting = ToClient_getGameOptionControllerWrapper()
  return PaGlobal_GameOption_All._elements.LUT:get(gameOptionSetting)
end
function GameOption_GetHideWindow()
  local gameOptionSetting = ToClient_getGameOptionControllerWrapper()
  return PaGlobal_GameOption_All._elements.HideWindowByAttacked:get(gameOptionSetting)
end
function GameOption_ShowGuildLoginMessage()
  local gameOptionSetting = ToClient_getGameOptionControllerWrapper()
  return PaGlobal_GameOption_All._elements.ShowGuildLoginMessage:get(gameOptionSetting)
end
function GameOption_GetShowStackHp()
  local gameOptionSetting = ToClient_getGameOptionControllerWrapper()
  return PaGlobal_GameOption_All._elements.ShowStackHp:get(gameOptionSetting)
end
function FGlobal_SpiritGuide_IsShow()
  local gameOptionSetting = ToClient_getGameOptionControllerWrapper()
  return PaGlobal_GameOption_All._elements.ShowComboGuide:get(gameOptionSetting)
end
function getUiFontSize()
  local gameOptionSetting = ToClient_getGameOptionControllerWrapper()
  return PaGlobal_GameOption_All._elements.UIFontSizeType:get(gameOptionSetting)
end
function GameOption_SetUIMode(uiScale)
  local uiScaleOption = PaGlobal_GameOption_All._elements.UIScale
  uiScaleOption._initValue = PaGlobal_GameOption_All:FromRealValueToSliderValue(uiScale, 0.5, 2)
end
function SimpleUI_Check(simpleUI_Check)
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer and 6 == selfPlayer:get():getLevel() then
    PaGlobal_GameOption_All:setOptionValue("EnableSimpleUI", simpleUI_Check)
  end
end
function FGlobal_GameOption_OpenByMenu(index)
  showGameOption()
  if 0 == index then
    PaGlobal_Option:MoveUi(PaGlobal_Option.UIMODE.Category)
    PaGlobal_Option:GoCategory("Graphic", "Quality")
  elseif 1 == index then
    PaGlobal_Option:MoveUi(PaGlobal_Option.UIMODE.Category)
    PaGlobal_Option:GoCategory("Sound", "OnOff")
  elseif 2 == index then
    PaGlobal_Option:MoveUi(PaGlobal_Option.UIMODE.Category)
    PaGlobal_Option:GoCategory("Function", "Convenience")
  elseif 3 == index then
    PaGlobal_Option:MoveUi(PaGlobal_Option.UIMODE.Category)
    PaGlobal_Option:GoCategory("Interface", "Action")
  elseif 4 == index then
    PaGlobal_Option:MoveUi(PaGlobal_Option.UIMODE.Category)
    PaGlobal_Option:GoCategory("Interface", "UI")
  elseif 5 == index then
    PaGlobal_Option:MoveUi(PaGlobal_Option.UIMODE.Category)
    PaGlobal_Option:GoCategory("Performance", "Optimize")
  end
end
function GameOption_UpdateOptionChanged()
end
runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameOption_Main_All_1.lua")
runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameOption_Main_All_2.lua")
