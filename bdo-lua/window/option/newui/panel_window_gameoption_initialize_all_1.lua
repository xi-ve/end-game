function PaGlobal_GameOption_All:CreateFrame(category, detail, searchElement)
  local isKeyCustom = false
  local comboBoxCreated = false
  local searchPos = 0
  local radioButtonCacheNo = 0
  local radioButtonVerticalCacheNo = 0
  local checkButtonCacheNo = 0
  local sliderCacheNo = 0
  local keyCustomizeCacheNo = 0
  local comboboxCacheNo = 0
  local pageButtonCacheNo = 0
  local keyCustomTitleCacheNo = 0
  local subSliderCacheNo = 0
  local subTitlecacheNo = 0
  for index, cacheGroup in pairs(self._controlCache) do
    for index2, cacheControl in pairs(self._controlCache[index]) do
      cacheControl:SetShow(false)
    end
  end
  local offset = self:CreateFrameException(category, detail)
  if nil ~= self._currentFrame then
    for index, option in ipairs(self._currentFrame) do
      option._element._eventGroup = nil
    end
  end
  local frameInfo = PaGlobal_GameOption_All._frames[category][detail]
  self._currentFrame = frameInfo
  local titleSizeY = PaGlobal_GameOption_All:CreateAndSetPageTitle()
  local tempPosY = offset + titleSizeY
  for index, option in ipairs(frameInfo) do
    if nil ~= option._element then
      if (true == option._element._isShow or nil == option._element._isShow) and (true == option._contentsOption or nil == option._contentsOption) then
        local eventGroup
        if nil ~= option._element.uiInputType or nil ~= option._element.actionInputType then
          eventGroup = self:CreateControl_KeyCustomizeButton(keyCustomizeCacheNo, index, option._element)
          keyCustomizeCacheNo = keyCustomizeCacheNo + 1
          isKeyCustom = true
        elseif __ePAUIControl_RadioButton == option._element._controlType then
          if true == option._element._alignVertical then
            eventGroup = self:CreateControl_RadioButtonVertical(radioButtonVerticalCacheNo, index, option._element)
            radioButtonVerticalCacheNo = radioButtonVerticalCacheNo + 1
          elseif true == option._element._use2option then
            eventGroup = self:CreateControl_RadioButton2(0, index, option._element)
          else
            eventGroup = self:CreateControl_RadioButton(radioButtonCacheNo, index, option._element)
            radioButtonCacheNo = radioButtonCacheNo + 1
          end
        elseif __ePAUIControl_Slider == option._element._controlType then
          if true == option._element._isSubSlider then
            eventGroup = self:CreateControl_SubSlider(subSliderCacheNo, index, option._element)
            subSliderCacheNo = subSliderCacheNo + 1
          else
            eventGroup = self:CreateControl_Slider(sliderCacheNo, index, option._element)
            sliderCacheNo = sliderCacheNo + 1
          end
        elseif __ePAUIControl_CheckButton == option._element._controlType then
          eventGroup = self:CreateControl_CheckButton(checkButtonCacheNo, index, option._element)
          checkButtonCacheNo = checkButtonCacheNo + 1
        elseif __ePAUIControl_ComboBox == option._element._controlType then
          eventGroup = self:CreateControl_ComboBox(comboboxCacheNo, index, option._element)
          comboboxCacheNo = comboboxCacheNo + 1
          comboBoxCreated = true
        else
          if __ePAUIControl_Button == option._element._controlType then
            eventGroup = self:CreateControl_PageButton(pageButtonCacheNo, index, option._element)
            pageButtonCacheNo = pageButtonCacheNo + 1
          else
          end
        end
        if nil == eventGroup then
          _PA_LOG("\237\155\132\236\167\132", "caching \236\157\180 \236\158\152\235\170\187\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
        end
        if nil ~= searchElement and searchElement == option._element._name and true ~= ToClient_isUsePadSnapping() then
          searchPos = tempPosY + 20
        end
        self:SetTitleAndDescription(eventGroup, option._element)
        self:SetPictureToolTip(eventGroup, option._element)
        eventGroup:SetShow(true)
        eventGroup:SetPosY(tempPosY)
        tempPosY = tempPosY + eventGroup:GetSizeY()
        local value = option._element._initValue
        if nil ~= option._element._curValue then
          value = option._element._curValue
        elseif nil ~= option._element._applyValue then
          value = option._element._applyValue
        end
        option._element._eventGroup = eventGroup
        if nil ~= value then
          self:SetControlSetting(option._element, value)
        end
      end
    elseif nil ~= option._subTitle then
      local eventGroup = self:CreateControl_SubTitle(subTitlecacheNo)
      subTitlecacheNo = subTitlecacheNo + 1
      if nil == eventGroup then
        _PA_LOG("\237\155\132\236\167\132", "caching \236\157\180 \236\158\152\235\170\187\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
      end
      self:SetSubTitle(eventGroup, option)
      eventGroup:SetShow(true)
      eventGroup:SetPosY(tempPosY)
      tempPosY = tempPosY + eventGroup:GetSizeY()
    elseif nil ~= option._keyTitle1 then
      local eventGroup = self:CreateControl_KeyCustomizeTitle(keyCustomTitleCacheNo)
      keyCustomTitleCacheNo = keyCustomTitleCacheNo + 1
      if nil == eventGroup then
        _PA_LOG("\237\155\132\236\167\132", "caching \236\157\180 \236\158\152\235\170\187\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
      end
      self:SetKeyCustomTitle(eventGroup, option)
      eventGroup:SetShow(true)
      eventGroup:SetPosY(tempPosY)
      tempPosY = tempPosY + eventGroup:GetSizeY()
    end
  end
  if true == comboBoxCreated then
    self._ui._frameContent:SetChildIndex(self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.COMBOBOX][0], 9999)
  end
  self:AfterFixFrameException(category, detail)
  self._ui._frameContent:SetSize(self._ui._frameContent:GetSizeX(), tempPosY + self._pageBottomSpan)
  self._ui._frame:UpdateContentScroll()
  self._ui._frame:GetVScroll():SetControlTop()
  self._ui._frame:UpdateContentPos()
  UIScroll.SetButtonSize(self._ui._frameScroll, self._ui._frame:GetSizeY(), tempPosY + 10)
  if nil ~= searchElement and 0 ~= searchPos then
    self._ui._frame:GetVScroll():SetControlPos(searchPos / tempPosY)
    self._ui._frame:UpdateContentScroll()
    self._ui._frame:UpdateContentPos()
  end
  if true == isKeyCustom then
    self:ResetKeyCustomString()
  end
  if true == _ContentsGroup_UsePadSnapping then
    ToClient_padSnapRefreshTarget(self._ui._frameContent)
    ToClient_padSnapSetTargetGroup(self._ui._frame)
    ToClient_padSnapResetControl()
  end
end
function PaGlobal_GameOption_All:CreateAndSetPageTitle()
  local titleGroup = self:CreateControl_PageTitle(0)
  titleGroup:SetShow(true)
  local title = UI.getChildControl(titleGroup, "StaticText_Title")
  title:SetText(PAGetString(Defines.StringSheet_RESOURCE, self._currentFrame._title))
  local resetFrame = UI.getChildControl(titleGroup, "Button_ResetFrame")
  if false == isNeedGameOptionFromServer() then
    resetFrame:SetIgnore(true)
    resetFrame:SetMonoTone(true)
  else
    resetFrame:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:ClickedResetFrame()")
    resetFrame:addInputEvent("Mouse_On", "PaGlobal_GameOption_All_ShowResetTooltip( true )")
    resetFrame:addInputEvent("Mouse_Out", "PaGlobal_GameOption_All_ShowResetTooltip( false )")
  end
  return titleGroup:GetSizeY()
end
function PaGlobal_GameOption_All:CreateFrameException(category, detail)
  local selfPlayer = getSelfPlayer()
  self._elements.EnableSimpleUI._isShow = false
  if nil ~= selfPlayer and 5 < selfPlayer:get():getLevel() then
    self._elements.EnableSimpleUI._isShow = true
  end
  return 0
end
function PaGlobal_GameOption_All:AfterFixFrameException(category, detail)
  if "GraphicQuality" == detail or "Quality" == detail then
    local curGraphicOption
    if nil ~= self._elements.GraphicOption._curValue then
      curGraphicOption = self._elements.GraphicOption._curValue
    elseif nil ~= self._elements.GraphicOption._applyValue then
      curGraphicOption = self._elements.GraphicOption._applyValue
    else
      curGraphicOption = self._elements.GraphicOption._initValue
    end
    if nil ~= self._elements.Tessellation._eventGroup then
      local button = UI.getChildControl(self._elements.Tessellation._eventGroup, "CheckButton_Template")
      local title = UI.getChildControl(self._elements.Tessellation._eventGroup, "StaticText_Title")
      local desc = UI.getChildControl(self._elements.Tessellation._eventGroup, "StaticText_Desc")
      if nil ~= button and nil ~= title and nil ~= desc then
        if self.GRAPHIC.VeryVeryLow == curGraphicOption or self.GRAPHIC.VeryLow == curGraphicOption or self.GRAPHIC.Low == curGraphicOption or self.GRAPHIC.Medium == curGraphicOption or self.GRAPHIC.High == curGraphicOption then
          button:SetIgnore(true)
          title:SetMonoTone(true)
          desc:SetMonoTone(true)
        elseif self.GRAPHIC.VeryHigh == curGraphicOption or self.GRAPHIC.VeryVeryHigh == curGraphicOption or self.GRAPHIC.UltraHigh == curGraphicOption or self.GRAPHIC.UltraLow == curGraphicOption then
          button:SetIgnore(false)
          title:SetMonoTone(false)
          desc:SetMonoTone(false)
        end
      end
      if self.GRAPHIC.UltraHigh == curGraphicOption or self.GRAPHIC.UltraLow == curGraphicOption then
        self:SetAntiAliasingLevel2EnableSetting(true)
      else
        self:SetAntiAliasingLevel2EnableSetting(false)
      end
    end
  end
end
function PaGlobal_GameOption_All:SetSubTitle(groupBg, option)
  if nil == groupBg then
    _PA_LOG("\237\155\132\236\167\132", "caching \236\157\180 \236\158\152\235\170\187\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    return
  end
  local title = UI.getChildControl(groupBg, "StaticText_Title")
  title:SetText(PAGetString(Defines.StringSheet_RESOURCE, option._subTitle))
end
function PaGlobal_GameOption_All:SetKeyCustomTitle(groupBg, option)
  if nil == groupBg then
    _PA_LOG("\237\155\132\236\167\132", "caching \236\157\180 \236\158\152\235\170\187\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    return
  end
  local title1 = UI.getChildControl(groupBg, "StaticText_Title")
  local title2 = UI.getChildControl(groupBg, "StaticText_Title2")
  local title3 = UI.getChildControl(groupBg, "StaticText_Title3")
  local titleSizeX = 220
  if nil == option._keyTitle3 then
    title2:SetShow(false)
    title1:SetSize(titleSizeX * 2 + 10, title1:GetSizeY())
    title1:SetText(PAGetString(Defines.StringSheet_RESOURCE, option._keyTitle1))
    title3:SetText(PAGetString(Defines.StringSheet_RESOURCE, option._keyTitle2))
  else
    title2:SetShow(true)
    title1:SetSize(titleSizeX, title1:GetSizeY())
    title1:SetText(PAGetString(Defines.StringSheet_RESOURCE, option._keyTitle1))
    title2:SetText(PAGetString(Defines.StringSheet_RESOURCE, option._keyTitle2))
    title3:SetText(PAGetString(Defines.StringSheet_RESOURCE, option._keyTitle3))
  end
end
function PaGlobal_GameOption_All:SetTitleAndDescription(groupBg, option)
  if nil == groupBg then
    _PA_LOG("\237\155\132\236\167\132", "caching \236\157\180 \236\158\152\235\170\187\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.")
    return
  end
  local line = UI.getChildControl(groupBg, "Static_Line")
  local title = UI.getChildControl(groupBg, "StaticText_Title")
  local desc = UI.getChildControl(groupBg, "StaticText_Desc")
  line:SetShow(true)
  title:SetShow(true)
  desc:SetShow(true)
  if nil ~= option._title then
    title:SetText(PAGetString(Defines.StringSheet_RESOURCE, option._title))
    if "UIScale" == option._name and getResolutionSizeY() < self._recommendUIScaleBase then
      local recommendUIScale = self:getRecommendUIScale()
      title:SetText(title:GetText() .. " (" .. PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_RECOMMANDATION") .. " : <PAColor0xffddcd82>" .. recommendUIScale .. "<PAOldColor>)")
    end
  else
    title:SetShow(false)
  end
  if nil == title:GetText() or "" == title:GetText() then
    if true == option._isSystemChat then
      title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_SYSTEM_TITLE") .. " - " .. PAGetString(Defines.StringSheet_GAME, option._title))
    else
      title:SetText(PAGetString(Defines.StringSheet_GAME, option._title))
    end
  end
  if nil ~= option._desc then
    desc:SetTextMode(__eTextMode_AutoWrap)
    desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, option._desc))
    if nil == desc:GetText() or "" == desc:GetText() then
      desc:SetTextMode(__eTextMode_AutoWrap)
      desc:SetText(PAGetString(Defines.StringSheet_GAME, option._desc))
    end
  else
    desc:SetShow(false)
  end
  if option._controlType == __ePAUIControl_RadioButton then
    if nil ~= option.uiInputType or nil ~= option.actionInputType then
      line:SetShow(false)
      local title1 = UI.getChildControl(groupBg, "StaticText_Title1")
      local title2 = UI.getChildControl(groupBg, "StaticText_Title2")
      title1:SetShow(false)
      title2:SetShow(false)
      if nil ~= option._title1 then
        title1:SetShow(true)
        title1:SetText((PAGetString(Defines.StringSheet_RESOURCE, option._title1)))
      end
      if nil ~= option._title2 then
        title2:SetShow(true)
        title2:SetText((PAGetString(Defines.StringSheet_RESOURCE, option._title2)))
      end
    else
      local biggestTextSizeX = 0
      for ii = 0, option._radioButtonMapping._count - 1 do
        local radioButton = UI.getChildControl(groupBg, "RadioButton_" .. tostring(ii))
        if nil == option._radioButtonMapping[ii] then
          _PA_LOG("\237\155\132\236\167\132", " \235\157\188\235\148\148\236\152\164 \235\178\132\237\138\188 \236\132\184\237\140\133\236\157\132 \237\153\149\236\157\184\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164.")
          radioButton:SetText("button_" .. tostring(ii))
        elseif nil ~= option._radioButtonMapping[ii]._string then
          radioButton:SetText(PAGetString(Defines.StringSheet_RESOURCE, option._radioButtonMapping[ii]._string))
        elseif nil ~= option._radioButtonMapping[ii]._gameString then
          radioButton:SetText(PAGetString(Defines.StringSheet_GAME, option._radioButtonMapping[ii]._gameString))
        elseif nil ~= option._radioButtonMapping[ii]._fixedString then
          radioButton:SetText(option._radioButtonMapping[ii]._fixedString)
        end
        local textSize = radioButton:GetTextSizeX()
        if true == option._alignVertical and biggestTextSizeX < textSize then
          biggestTextSizeX = textSize
        end
      end
      local titleSizeY = title:GetTextSizeY()
      local descSizeY = desc:GetTextSizeY()
      local gap = 9
      local gapCount = 4
      local buttonSizeY = 50
      local buttonLineCount = 0
      if nil == option._alignVertical or false == option._alignVertical then
        if nil == option._title then
          titleSizeY = 0
          gapCount = gapCount - 1
          for ii = 0, option._radioButtonMapping._count - 1 do
            local radioButton = UI.getChildControl(groupBg, "RadioButton_" .. tostring(ii))
            radioButton:SetPosY(radioButton:GetPosY() - 30)
          end
        end
        if nil == option._desc then
          descSizeY = 0
          gapCount = gapCount - 1
          for ii = 0, option._radioButtonMapping._count - 1 do
            local radioButton = UI.getChildControl(groupBg, "RadioButton_" .. tostring(ii))
            radioButton:SetPosY(radioButton:GetPosY() - 30)
          end
        end
        buttonLineCount = math.floor((option._radioButtonMapping._count - 1) / 3)
      else
        descSizeY = 0
        gapCount = 3
        buttonLineCount = option._radioButtonMapping._count - 1
        for ii = 0, option._radioButtonMapping._count - 1 do
          local radioButton = UI.getChildControl(groupBg, "RadioButton_" .. tostring(ii))
          local gap = 60
          if isGameServiceTypeDev() or isGameTypeTaiwan() or isGameTypeKorea() or isGameTypeJapan() then
            gap = 80
          end
          radioButton:SetSize(biggestTextSizeX + gap, radioButton:GetSizeY())
        end
      end
      for ii = 0, option._radioButtonMapping._count - 1 do
        local radioButton = UI.getChildControl(groupBg, "RadioButton_" .. tostring(ii))
        local textSize = radioButton:GetTextSizeX()
        local defaultTextSpan = 30
        if isGameServiceTypeDev() or isGameTypeTaiwan() or isGameTypeKorea() or isGameTypeJapan() then
          defaultTextSpan = 0
        end
        local startPosX = defaultTextSpan + (radioButton:GetSizeX() - defaultTextSpan - textSize) * 0.5
        radioButton:SetTextSpan(startPosX, 0)
      end
      groupBg:SetSize(groupBg:GetSizeX(), titleSizeY + descSizeY + gap * gapCount + buttonSizeY * (buttonLineCount + 1))
      if true == option._use2option then
        local fps = UI.getChildControl(groupBg, "StaticText_FPS")
        fps:SetShow(true)
        self._fpsTextControl = fps
        local line2 = UI.getChildControl(groupBg, "Static_Line2")
        local title2 = UI.getChildControl(groupBg, "StaticText_Title2")
        local desc2 = UI.getChildControl(groupBg, "StaticText_Desc2")
        if true == ToClinet_isGraphicUltraAvailable() then
          line2:SetShow(true)
          line2:SetPosY(groupBg:GetSizeY() + 5)
          title2:SetShow(true)
          title2:SetPosY(line2:GetPosY() + 20)
          desc2:SetShow(true)
          desc2:SetPosY(title2:GetPosY() + 20)
          title2:SetText(PAGetString(Defines.StringSheet_RESOURCE, option._title2))
          desc2:SetText(PAGetString(Defines.StringSheet_RESOURCE, option._desc2))
          local radioButtonSizeX = 230
          local radioButtonSizeY = 50
          local startPosY = desc2:GetPosY() + 35
          for ii = 7, option._radioButtonMapping._count - 1 do
            local xIndex = (ii - 7) % 3
            local yIndex = math.floor((ii - 7) / 3)
            local radioButton = UI.getChildControlNoneAssert(groupBg, "RadioButton_" .. tostring(ii))
            radioButton:SetPosX(20 + xIndex * radioButtonSizeX)
            radioButton:SetPosY(startPosY + yIndex * radioButtonSizeY)
          end
          groupBg:SetSize(groupBg:GetSizeX(), groupBg:GetSizeY() + titleSizeY + descSizeY + gap * gapCount + buttonSizeY + 5)
        else
          line2:SetShow(false)
          title2:SetShow(false)
          desc2:SetShow(false)
        end
      end
      if "WatermarkPosition" == option._name or "ShowNavPathEffectType" == option._name or "WorldMapOpenType" == option._name then
        local radioButtonSizeX = 230
        local radioButtonSizeY = 50
        local radioButtonTemplate = UI.getChildControl(groupBg, "RadioButton_0")
        local startPosY = radioButtonTemplate:GetPosY()
        for ii = 0, option._radioButtonMapping._count - 1 do
          local radioButton = UI.getChildControl(groupBg, "RadioButton_" .. tostring(ii))
          local xIndex = ii % 2
          local yIndex = math.floor(ii / 2)
          radioButton:SetPosX(20 + xIndex * radioButtonSizeX)
          radioButton:SetPosY(startPosY + yIndex * radioButtonSizeY)
        end
      end
    end
  elseif option._controlType == __ePAUIControl_CheckButton then
    local defaultSizeY = PaGlobal_GameOption_All:getDefaultGroupSizeY(option._controlType)
    groupBg:SetSize(groupBg:GetSizeX(), defaultSizeY)
    groupBg:ComputePosAllChild()
    if desc:GetTextSizeY() > 20 then
      groupBg:SetSize(groupBg:GetSizeX(), 50 + desc:GetTextSizeY() + 2)
    end
    local checkButton = UI.getChildControl(groupBg, "CheckButton_Template")
    checkButton:SetEnableArea(-20, -20, groupBg:GetSizeX() - 20, groupBg:GetSizeY() - 20)
  elseif option._controlType == __ePAUIControl_Slider then
    if true == option._isSubSlider then
      local areaBG = UI.getChildControl(groupBg, "Static_SmallArea")
      if nil == option._title then
        groupBg:SetSize(groupBg:GetSizeX(), 60)
        areaBG:SetSize(areaBG:GetSizeX(), 60)
      else
        groupBg:SetSize(groupBg:GetSizeX(), 80)
        areaBG:SetSize(areaBG:GetSizeX(), 80)
      end
      groupBg:ComputePosAllChild()
      line:SetShow(false)
      desc:SetShow(false)
    else
      local titleSizeY = title:GetTextSizeY()
      local descSizeY = desc:GetTextSizeY()
      local sliderSizeY = 50
      local gap = 7
      local gapCount = 4
      if nil == option._title then
        titleSizeY = 0
        gapCount = 3
      elseif nil == option._desc then
        descSizeY = 0
        gapCount = 3
      end
      groupBg:SetSize(groupBg:GetSizeX(), titleSizeY + descSizeY + sliderSizeY + gap * gapCount)
      groupBg:ComputePosAllChild()
      if nil == option._title and nil == option._desc then
        line:SetShow(false)
        title:SetShow(false)
        desc:SetShow(false)
        groupBg:SetSize(groupBg:GetSizeX(), 50)
        groupBg:ComputePosAllChild()
      end
    end
    local min = UI.getChildControl(groupBg, "StaticText_Min")
    local max = UI.getChildControl(groupBg, "StaticText_Max")
    local current = UI.getChildControl(groupBg, "StaticText_Current")
    if nil ~= option._sliderValueMin and nil ~= option._sliderValueMax then
      min:SetText(tostring(option._sliderValueMin))
      max:SetText(tostring(option._sliderValueMax))
    end
    min:SetShow(true)
    max:SetShow(true)
    current:SetShow(true)
    if "EffectFrameOptimization" == option._name then
      min:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_PERFORMANCE_OPTIMIZEBETA_UseEffectFrameOptimization_0"))
      max:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_PERFORMANCE_OPTIMIZEBETA_UseEffectFrameOptimization_1"))
      current:SetShow(false)
    elseif "CropModeScaleX" == option._name or "CropModeScaleY" == option._name then
      min:SetShow(false)
      max:SetShow(false)
    end
  elseif option._controlType == __ePAUIControl_Button then
    local button1 = UI.getChildControl(groupBg, "Button_Template1")
    local button2 = UI.getChildControl(groupBg, "Button_Template2")
    button1:SetText(PAGetString(Defines.StringSheet_RESOURCE, option._buttonTitle1))
    button2:SetText(PAGetString(Defines.StringSheet_RESOURCE, option._buttonTitle2))
  elseif option._controlType == __ePAUIControl_ComboBox then
    local titleSizeY = title:GetTextSizeY()
    local descSizeY = desc:GetTextSizeY()
    local comboSizeY = 50
    local gap = 7
    local gapCount = 4
    if nil == option._desc then
      descSizeY = 0
      gapCount = 3
    end
    groupBg:SetSize(groupBg:GetSizeX(), titleSizeY + descSizeY + comboSizeY + gap * gapCount)
    groupBg:ComputePosAllChild()
    if "ScreenResolution" == option._name then
      local comboBox = UI.getChildControl(groupBg, "Combobox2_1")
      comboBox:SetText(self._userInitScreenResolution.width .. "x" .. self._userInitScreenResolution.height)
    end
  end
end
function PaGlobal_GameOption_All:getDefaultGroupSizeY(controlType)
  local groupTemplate
  if __ePAUIControl_RadioButton == controlType then
    groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateRadioBtnGroup")
  elseif __ePAUIControl_CheckButton == controlType then
    groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateCheckBtnGroup")
  elseif __ePAUIControl_Slider == controlType then
    groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateSliderGroup")
  elseif __ePAUIControl_ComboBox == controlType then
    groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateComboboxGroup")
  elseif __ePAUIControl_Button == controlType then
    groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplatePageBtnGroup")
  else
    return 0
  end
  return groupTemplate:GetSizeY()
end
function PaGlobal_GameOption_All:getDefaultRadioSizeX()
  local groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateRadioBtnGroup")
  local radioBtn = UI.getChildControl(groupTemplate, "RadioButton_Template")
  if nil == radioBtn then
    return 220
  else
    return radioBtn:GetSizeX()
  end
end
function PaGlobal_GameOption_All:SetPictureToolTip(groupBg, option)
  if option._controlType == __ePAUIControl_RadioButton then
    if nil == option.uiInputType and nil == option.actionInputType then
      for ii = 0, option._radioButtonMapping._count do
        local control = UI.getChildControlNoneAssert(groupBg, "RadioButton_" .. tostring(ii))
        if nil ~= control then
          if true == option._isPictureTooltipOn then
            control:addInputEvent("Mouse_On", "PaGlobal_GameOption_All_ShowPictureToolTip(true, \"" .. option._name .. "\")")
            control:addInputEvent("Mouse_Out", "PaGlobal_GameOption_All_ShowPictureToolTip(false, \"" .. option._name .. "\")")
          elseif "ScreenShotQuality" ~= option._name and "GraphicOption" ~= option._name then
            control:addInputEvent("Mouse_On", "")
            control:addInputEvent("Mouse_Out", "")
          end
        end
      end
    end
  elseif option._controlType == __ePAUIControl_CheckButton then
    local control = UI.getChildControl(groupBg, "CheckButton_Template")
    if nil ~= control then
      if true == option._isPictureTooltipOn then
        control:addInputEvent("Mouse_On", "PaGlobal_GameOption_All_ShowPictureToolTip(true, \"" .. option._name .. "\")")
        control:addInputEvent("Mouse_Out", "PaGlobal_GameOption_All_ShowPictureToolTip(false, \"" .. option._name .. "\")")
      else
        control:addInputEvent("Mouse_On", "")
        control:addInputEvent("Mouse_Out", "")
      end
    end
  end
end
function PaGlobal_GameOption_All:CreateControl_PageTitle(cacheNo)
  if nil == self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.PAGETITLE][cacheNo] then
    local groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplatePageTitleGroup")
    local group = UI.cloneControl(groupTemplate, self._ui._frameContent, "Static_PageTitleGroup" .. tostring(cacheNo))
    self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.PAGETITLE][cacheNo] = group
  end
  return self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.PAGETITLE][cacheNo]
end
function PaGlobal_GameOption_All:CreateControl_SubTitle(cacheNo)
  if nil == self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.SUBTITLE][cacheNo] then
    local groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateSubTitleGroup")
    local group = UI.cloneControl(groupTemplate, self._ui._frameContent, "Static_SubTitleGroup" .. tostring(cacheNo))
    self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.SUBTITLE][cacheNo] = group
  end
  return self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.SUBTITLE][cacheNo]
end
function PaGlobal_GameOption_All:CreateControl_KeyCustomizeTitle(cacheNo)
  if nil == self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.KEYCUSTOMETITLE][cacheNo] then
    local groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateKeyCustomTitleGroup")
    local group = UI.cloneControl(groupTemplate, self._ui._frameContent, "Static_KeyCustomizeTitleGroup" .. tostring(cacheNo))
    self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.KEYCUSTOMETITLE][cacheNo] = group
  end
  return self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.KEYCUSTOMETITLE][cacheNo]
end
function PaGlobal_GameOption_All:CreateControl_RadioButton(cacheNo, order, option)
  if nil == self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOBUTTON][cacheNo] then
    local groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateRadioBtnGroup")
    local group = UI.cloneControl(groupTemplate, self._ui._frameContent, "Static_RadioButtonGroup" .. tostring(cacheNo))
    self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOBUTTON][cacheNo] = group
  end
  local groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateRadioBtnGroup")
  local radioButtonTemplate = UI.getChildControl(groupTemplate, "RadioButton_Template")
  local MaxRadioButton = 20
  local lastYIndex = 0
  for ii = 0, MaxRadioButton do
    if ii < option._radioButtonMapping._count then
      local xIndex = ii % 3
      local yIndex = math.floor(ii / 3)
      lastYIndex = yIndex
      local radioButton = UI.getChildControlNoneAssert(self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOBUTTON][cacheNo], "RadioButton_" .. tostring(ii))
      if nil == radioButton then
        radioButton = UI.cloneControl(radioButtonTemplate, self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOBUTTON][cacheNo], "RadioButton_" .. tostring(ii))
      end
      radioButton:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:SetCurrentValue( \"" .. tostring("RadioButton_" .. option._name) .. "\", " .. tostring(cacheNo) .. ", " .. tostring(ii) .. ")")
      local radioButtonSizeX = 220
      local radioButtonSizeY = 50
      local gap = 10
      if 2 == option._radioButtonMapping._count then
        radioButtonSizeX = 335
      end
      radioButton:SetSize(radioButtonSizeX, radioButtonTemplate:GetSizeY())
      radioButton:SetPosX(radioButtonTemplate:GetPosX() + xIndex * (radioButtonSizeX + gap))
      radioButton:SetPosY(radioButtonTemplate:GetPosY() + yIndex * radioButtonSizeY)
      radioButton:SetShow(true)
      radioButton:SetEnable(true)
      radioButton:SetMonoTone(false)
      radioButton:SetIgnore(false)
      radioButton:SetGroup(cacheNo)
      if "ScreenShotQuality" == option._name then
        radioButton:addInputEvent("Mouse_On", "PaGlobal_GameOption_All:ScreenShotQualityTooltip(true," .. tostring(cacheNo) .. "," .. tostring(ii) .. ", \"" .. option._name .. "\")")
        radioButton:addInputEvent("Mouse_Out", "PaGlobal_GameOption_All:ScreenShotQualityTooltip(false," .. tostring(cacheNo) .. "," .. tostring(ii) .. ", \"" .. option._name .. "\")")
      end
    else
      local radioButton = UI.getChildControlNoneAssert(self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOBUTTON][cacheNo], "RadioButton_" .. tostring(ii))
      if nil == radioButton then
        break
      else
        radioButton:SetShow(false)
      end
    end
  end
  self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOBUTTON][cacheNo]:SetSize(groupTemplate:GetSizeX(), groupTemplate:GetSizeY() + 50 * lastYIndex)
  return self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOBUTTON][cacheNo]
end
function PaGlobal_GameOption_All:CreateControl_RadioButtonVertical(cacheNo, order, option)
  if nil == self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOVERTICAL][cacheNo] then
    local groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateRadioBtnVerticalGroup")
    local group = UI.cloneControl(groupTemplate, self._ui._frameContent, "Static_RadioButtonVerticalGroup" .. tostring(cacheNo))
    self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOVERTICAL][cacheNo] = group
  end
  local groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateRadioBtnVerticalGroup")
  local radioButtonTemplate = UI.getChildControl(groupTemplate, "RadioButton_Template")
  local MaxRadioButton = 20
  local lastYIndex = 0
  for ii = 0, MaxRadioButton do
    if ii < option._radioButtonMapping._count then
      local radioButton = UI.getChildControlNoneAssert(self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOVERTICAL][cacheNo], "RadioButton_" .. tostring(ii))
      if nil == radioButton then
        radioButton = UI.cloneControl(radioButtonTemplate, self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOVERTICAL][cacheNo], "RadioButton_" .. tostring(ii))
      end
      radioButton:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:SetCurrentValue( \"" .. tostring("RadioButton_" .. option._name) .. "\", " .. tostring(cacheNo) .. ", " .. tostring(ii) .. ")")
      local radioButtonSizeY = 50
      radioButton:SetPosY(radioButtonTemplate:GetPosY() + ii * radioButtonSizeY)
      radioButton:SetShow(true)
      radioButton:SetEnable(true)
      radioButton:SetMonoTone(false)
      radioButton:SetIgnore(false)
      radioButton:SetGroup(10 + cacheNo)
    else
      local radioButton = UI.getChildControlNoneAssert(self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOVERTICAL][cacheNo], "RadioButton_" .. tostring(ii))
      if nil == radioButton then
        break
      else
        radioButton:SetShow(false)
      end
    end
  end
  self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOVERTICAL][cacheNo]:SetSize(groupTemplate:GetSizeX(), groupTemplate:GetSizeY() + 50 * (option._radioButtonMapping._count - 1))
  return self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOVERTICAL][cacheNo]
end
function PaGlobal_GameOption_All:CreateControl_RadioButton2(cacheNo, order, option)
  if nil == self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOBUTTON2][cacheNo] then
    local groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateRadioBtnGroup2")
    local group = UI.cloneControl(groupTemplate, self._ui._frameContent, "Static_RadioButtonGroup2_" .. tostring(cacheNo))
    self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOBUTTON2][cacheNo] = group
  end
  local groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateRadioBtnGroup2")
  local radioButtonTemplate = UI.getChildControl(groupTemplate, "RadioButton_Template")
  local MaxRadioButton = 20
  local lastYIndex = 0
  for ii = 0, MaxRadioButton do
    if ii < option._radioButtonMapping._count then
      local xIndex = ii % 3
      local yIndex = math.floor(ii / 3)
      lastYIndex = yIndex
      local radioButton = UI.getChildControlNoneAssert(self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOBUTTON2][cacheNo], "RadioButton_" .. tostring(ii))
      if nil == radioButton then
        radioButton = UI.cloneControl(radioButtonTemplate, self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOBUTTON2][cacheNo], "RadioButton_" .. tostring(ii))
      end
      radioButton:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:SetCurrentValue( \"" .. tostring("RadioButton_" .. option._name) .. "\", " .. tostring(cacheNo) .. ", " .. tostring(ii) .. ")")
      local radioButtonSizeX = 230
      local radioButtonSizeY = 50
      radioButton:SetPosX(radioButtonTemplate:GetPosX() + xIndex * radioButtonSizeX)
      radioButton:SetPosY(radioButtonTemplate:GetPosY() + yIndex * radioButtonSizeY)
      radioButton:SetShow(true)
      radioButton:SetEnable(true)
      radioButton:SetMonoTone(false)
      radioButton:SetIgnore(false)
      radioButton:SetGroup(20 + cacheNo)
      if "GraphicOption" == option._name and self.GRAPHIC.UltraHigh == ii then
        radioButton:addInputEvent("Mouse_On", "PaGlobal_GameOption_All:UltraModeTooltip(true, " .. tostring(cacheNo) .. ", \"" .. option._name .. "\")")
        radioButton:addInputEvent("Mouse_Out", "PaGlobal_GameOption_All:UltraModeTooltip(false, " .. tostring(cacheNo) .. ", \"" .. option._name .. "\")")
      end
    else
      local radioButton = UI.getChildControlNoneAssert(self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOBUTTON2][cacheNo], "RadioButton_" .. tostring(ii))
      if nil == radioButton then
        break
      else
        radioButton:SetShow(false)
      end
    end
  end
  self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOBUTTON2][cacheNo]:SetSize(groupTemplate:GetSizeX(), groupTemplate:GetSizeY() + 50 * lastYIndex)
  return self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.RADIOBUTTON2][cacheNo]
end
function PaGlobal_GameOption_All:CreateControl_Slider(cacheNo, order, option)
  if nil == self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.SLIDER][cacheNo] then
    local groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateSliderGroup")
    local group = UI.cloneControl(groupTemplate, self._ui._frameContent, "Static_SliderGroup" .. tostring(cacheNo))
    self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.SLIDER][cacheNo] = group
  end
  local sliderTemplate = UI.getChildControl(self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.SLIDER][cacheNo], "Slider_Template")
  sliderTemplate:addInputEvent("Mouse_LPress", "PaGlobal_GameOption_All:SetCurrentValue(\"" .. tostring("Slider_" .. tostring(option._name)) .. "\" ," .. tostring(cacheNo) .. ")")
  local sliderButton = UI.getChildControl(sliderTemplate, "Slider_Button")
  sliderButton:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:SetCurrentValue(\"" .. tostring("Slider_" .. tostring(option._name)) .. "\" ," .. tostring(cacheNo) .. ")")
  sliderButton:addInputEvent("Mouse_LPress", "PaGlobal_GameOption_All:SetCurrentValue(\"" .. tostring("Slider_" .. tostring(option._name)) .. "\" ," .. tostring(cacheNo) .. ")")
  sliderTemplate:SetShow(true)
  return self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.SLIDER][cacheNo]
end
function PaGlobal_GameOption_All:CreateControl_SubSlider(cacheNo, order, option)
  if nil == self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.SUBSLIDER][cacheNo] then
    local groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateSliderSmallGroup")
    local group = UI.cloneControl(groupTemplate, self._ui._frameContent, "Static_SubSliderGroup" .. tostring(cacheNo))
    self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.SUBSLIDER][cacheNo] = group
  end
  local sliderTemplate = UI.getChildControl(self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.SUBSLIDER][cacheNo], "Slider_Template")
  sliderTemplate:addInputEvent("Mouse_LPress", "PaGlobal_GameOption_All:SetCurrentValue(\"" .. tostring("Slider_" .. tostring(option._name)) .. "\" ," .. tostring(cacheNo) .. ")")
  local sliderButton = UI.getChildControl(sliderTemplate, "Slider_Button")
  sliderButton:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:SetCurrentValue(\"" .. tostring("Slider_" .. tostring(option._name)) .. "\" ," .. tostring(cacheNo) .. ")")
  sliderButton:addInputEvent("Mouse_LPress", "PaGlobal_GameOption_All:SetCurrentValue(\"" .. tostring("Slider_" .. tostring(option._name)) .. "\" ," .. tostring(cacheNo) .. ")")
  sliderTemplate:SetShow(true)
  return self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.SUBSLIDER][cacheNo]
end
function PaGlobal_GameOption_All:CreateControl_CheckButton(cacheNo, order, option)
  if nil == self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.CHECKBUTTON][cacheNo] then
    local groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateCheckBtnGroup")
    local group = UI.cloneControl(groupTemplate, self._ui._frameContent, "Static_CheckButtonGroup" .. tostring(cacheNo))
    self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.CHECKBUTTON][cacheNo] = group
  end
  local checkButtonTemplate = UI.getChildControl(self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.CHECKBUTTON][cacheNo], "CheckButton_Template")
  checkButtonTemplate:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:SetCurrentValue(\"" .. tostring("CheckButton_" .. tostring(option._name)) .. "\" ," .. tostring(cacheNo) .. ")")
  checkButtonTemplate:SetShow(true)
  checkButtonTemplate:SetEnable(true)
  checkButtonTemplate:SetIgnore(false)
  local title = UI.getChildControl(self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.CHECKBUTTON][cacheNo], "StaticText_Title")
  local desc = UI.getChildControl(self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.CHECKBUTTON][cacheNo], "StaticText_Desc")
  title:SetMonoTone(false)
  desc:SetMonoTone(false)
  return self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.CHECKBUTTON][cacheNo]
end
function PaGlobal_GameOption_All:CreateControl_KeyCustomizeButton(cacheNo, order, option)
  if nil == self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.KEYCUSTOMIZE][cacheNo] then
    local groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateKeyCustomBtnGroup")
    local group = UI.cloneControl(groupTemplate, self._ui._frameContent, "Static_KeyCustomizeButtonGroup" .. tostring(cacheNo))
    self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.KEYCUSTOMIZE][cacheNo] = group
  end
  local buttonTemplate = UI.getChildControl(self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.KEYCUSTOMIZE][cacheNo], "CheckButton_Template")
  buttonTemplate:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:SetCurrentValue(\"" .. tostring("KeyCustomize_" .. tostring(option._name)) .. "\" ," .. tostring(cacheNo) .. ")")
  buttonTemplate:SetShow(true)
  return self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.KEYCUSTOMIZE][cacheNo]
end
function PaGlobal_GameOption_All:CreateControl_ComboBox(cacheNo, order, option)
  if nil == self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.COMBOBOX][cacheNo] then
    local groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplateComboboxGroup")
    local group = UI.cloneControl(groupTemplate, self._ui._frameContent, "Static_ComboboxGroup" .. tostring(cacheNo))
    self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.COMBOBOX][cacheNo] = group
  end
  local comboboxTemplate = UI.getChildControl(self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.COMBOBOX][cacheNo], "Combobox2_1")
  comboboxTemplate:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:OpenCombobox(" .. tostring(cacheNo) .. ")")
  comboboxTemplate:setListTextHorizonCenter()
  comboboxTemplate:SetShow(true)
  if nil ~= option._comboBoxListCount then
    comboboxTemplate:DeleteAllItem()
    for index = 0, option._comboBoxListCount - 1 do
      comboboxTemplate:AddItem(option._comboBoxList[index])
    end
  end
  comboboxTemplate:GetListControl():AddSelectEvent("PaGlobal_GameOption_All:SetCurrentValue(\"" .. tostring("ComboBox_" .. tostring(option._name)) .. "\"," .. tostring(cacheNo) .. ")")
  return self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.COMBOBOX][cacheNo]
end
function PaGlobal_GameOption_All:CreateControl_PageButton(cacheNo, order, option)
  if nil == self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.BUTTON][cacheNo] then
    local groupTemplate = UI.getChildControl(self._ui._frameContent, "Static_TemplatePageBtnGroup")
    local group = UI.cloneControl(groupTemplate, self._ui._frameContent, "Static_PageButtonGroup" .. tostring(cacheNo))
    self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.BUTTON][cacheNo] = group
  end
  local leftButton = UI.getChildControl(self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.BUTTON][cacheNo], "Button_LeftArrow")
  leftButton:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:SetCurrentValue(\"" .. tostring("PageButton_" .. tostring(option._name)) .. "\" ," .. tostring(cacheNo) .. ", -1)")
  leftButton:SetShow(true)
  local rightButton = UI.getChildControl(self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.BUTTON][cacheNo], "Button_RightArrow")
  rightButton:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:SetCurrentValue(\"" .. tostring("PageButton_" .. tostring(option._name)) .. "\" ," .. tostring(cacheNo) .. ", 1)")
  rightButton:SetShow(true)
  local buttonTemplate1 = UI.getChildControl(self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.BUTTON][cacheNo], "Button_Template1")
  buttonTemplate1:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:SetRecommandationLUT2()")
  buttonTemplate1:SetShow(true)
  local buttonTemplate2 = UI.getChildControl(self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.BUTTON][cacheNo], "Button_Template2")
  buttonTemplate2:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All:SetRecommandationLUT()")
  buttonTemplate2:SetShow(true)
  return self._controlCache[PaGlobal_GameOption_All.OPTION_TYPE.BUTTON][cacheNo]
end
