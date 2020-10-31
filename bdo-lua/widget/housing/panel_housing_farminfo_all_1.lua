function PaGlobal_FarmInfo_All:initialize()
  if true == PaGlobal_FarmInfo_All._initialize then
    return
  end
  self._ui._txt_title = UI.getChildControl(Panel_Housing_FarmInfo_All, "StaticText_Title")
  self._ui._btn_close = UI.getChildControl(self._ui._txt_title, "Button_Win_Close")
  self._ui._btn_question = UI.getChildControl(self._ui._txt_title, "Button_Question")
  local stc_topBg = UI.getChildControl(Panel_Housing_FarmInfo_All, "Static_TopBg")
  self._ui._txt_remainTime = UI.getChildControl(stc_topBg, "StaticText_RemainTime_Value")
  local stc_farmInfoBg = UI.getChildControl(Panel_Housing_FarmInfo_All, "Static_FarmInfoBG")
  self._ui._txt_spaceValue = UI.getChildControl(stc_farmInfoBg, "StaticText_SpaceValue")
  self._ui._stc_temperatureBg = UI.getChildControl(stc_farmInfoBg, "Static_TemperatureBG")
  self._ui._stc_temperatureProgressBg = UI.getChildControl(stc_farmInfoBg, "Static_TemperatureProgressBg")
  self._ui._stc_temperatureHighLight = UI.getChildControl(stc_farmInfoBg, "Static_TemperatureHighlight")
  self._ui._stc_temperatureArrow = UI.getChildControl(stc_farmInfoBg, "Static_Temperature_Arrow")
  self._ui._slider_temperature = UI.getChildControl(stc_farmInfoBg, "Slider_Temperature")
  self._ui._txt_temperatureValue = UI.getChildControl(stc_farmInfoBg, "StaticText_Temperature_Value")
  self._ui._stc_humidityBg = UI.getChildControl(stc_farmInfoBg, "Static_HumidityBG")
  self._ui._stc_humidityProgressBg = UI.getChildControl(stc_farmInfoBg, "Static_HumidityProgressBg")
  self._ui._stc_humidityHighLight = UI.getChildControl(stc_farmInfoBg, "Static_HumidityHighlight")
  self._ui._stc_humidityArrow = UI.getChildControl(stc_farmInfoBg, "Static_Humidity_Arrow")
  self._ui._slider_humidity = UI.getChildControl(stc_farmInfoBg, "Slider_Humidity")
  self._ui._txt_humidityValue = UI.getChildControl(stc_farmInfoBg, "StaticText_Humidity_Value")
  self._ui._progress_undergroundWaterBack = UI.getChildControl(stc_farmInfoBg, "Progress2_UndergroundWater1")
  self._ui._progress_undergroundWaterFront = UI.getChildControl(stc_farmInfoBg, "Progress2_UndergroundWater2")
  self._ui._txt_undergroundWaterValue = UI.getChildControl(stc_farmInfoBg, "StaticText_UndergroundWater_Value")
  self._ui._txt_compostTitle = UI.getChildControl(stc_farmInfoBg, "StaticText_Compost")
  self._ui._progress_compost = UI.getChildControl(stc_farmInfoBg, "Progress2_Compost")
  self._ui._stc_compostBg = UI.getChildControl(stc_farmInfoBg, "Static_CompostBG")
  self._ui._stc_compostAdd = UI.getChildControl(stc_farmInfoBg, "Static_CompostAdd")
  self._ui._stc_scarecrowIcon = UI.getChildControl(stc_farmInfoBg, "Static_FarmIcon_Scarecrow")
  self._ui._txt_scarecrowDesc = UI.getChildControl(stc_farmInfoBg, "StaticText_FarmIcon_ScarecrowDesc")
  self._ui._stc_waterwayIcon = UI.getChildControl(stc_farmInfoBg, "Static_FarmIcon_Waterway")
  self._ui._txt_waterwayDesc = UI.getChildControl(stc_farmInfoBg, "StaticText_FarmIcon_WaterWayDesc")
  local stc_cropsInfoBg = UI.getChildControl(Panel_Housing_FarmInfo_All, "Static_CropsInfoBG")
  self._ui._progress_growing = UI.getChildControl(stc_cropsInfoBg, "Progress_Growing")
  self._ui._txt_growingValue = UI.getChildControl(stc_cropsInfoBg, "StaticText_Growing_Value")
  self._ui._progress_helth = UI.getChildControl(stc_cropsInfoBg, "Progress_Helth")
  self._ui._txt_helthValue = UI.getChildControl(stc_cropsInfoBg, "StaticText_Helth_Value")
  self._ui._progress_needWater = UI.getChildControl(stc_cropsInfoBg, "Progress_NeedWater")
  self._ui._txt_needWaterValue = UI.getChildControl(stc_cropsInfoBg, "StaticText_NeedWater_Value")
  self._ui._stc_pruningIcon = UI.getChildControl(stc_cropsInfoBg, "Static_CropsIcon_Pruning")
  self._ui._txt_pruningDesc = UI.getChildControl(stc_cropsInfoBg, "StaticText_CropsIcon_PruningDesc")
  self._ui._stc_insectDamegeIcon = UI.getChildControl(stc_cropsInfoBg, "Static_CropsIcon_InsectDamege")
  self._ui._txt_insectDamegeDesc = UI.getChildControl(stc_cropsInfoBg, "StaticText_CropsIcon_InsectDamegeDesc")
  self._ui._txt_tooltipTitles[self._eTooltipType.temperature] = UI.getChildControl(stc_farmInfoBg, "StaticText_Temperature_Title")
  self._ui._txt_tooltipTitles[self._eTooltipType.humidity] = UI.getChildControl(stc_farmInfoBg, "StaticText_Humidity_Title")
  self._ui._txt_tooltipTitles[self._eTooltipType.undergroundWater] = UI.getChildControl(stc_farmInfoBg, "StaticText_UndergroundWater")
  self._ui._txt_tooltipTitles[self._eTooltipType.compost] = UI.getChildControl(stc_farmInfoBg, "StaticText_Compost")
  self._ui._txt_tooltipTitles[self._eTooltipType.growing] = UI.getChildControl(stc_cropsInfoBg, "StaticText_Growing")
  self._ui._txt_tooltipTitles[self._eTooltipType.helth] = UI.getChildControl(stc_cropsInfoBg, "StaticText_Helth")
  self._ui._txt_tooltipTitles[self._eTooltipType.needWater] = UI.getChildControl(stc_cropsInfoBg, "StaticText_NeedWater")
  self:initIconUV()
  if not isGameTypeKorea() then
    self._ui._txt_pruningDesc:SetTextMode(__eTextMode_Limit_AutoWrap)
    self._ui._txt_insectDamegeDesc:SetTextMode(__eTextMode_Limit_AutoWrap)
    self._ui._txt_pruningDesc:setLineCountByLimitAutoWrap(2)
    self._ui._txt_insectDamegeDesc:setLineCountByLimitAutoWrap(2)
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  if true == self._isConsole then
    self._ui._btn_question:SetShow(false)
    self._ui._btn_close:SetShow(false)
  end
  PaGlobal_FarmInfo_All:registEventHandler()
  PaGlobal_FarmInfo_All:validate()
  PaGlobal_FarmInfo_All._initialize = true
end
function PaGlobal_FarmInfo_All:registEventHandler()
  if nil == Panel_Housing_FarmInfo_All then
    return
  end
  if false == self._isConsole then
    self._ui._btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_FarmInfo_All_Close()")
    self._ui._btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowTent\" )")
  end
  for k, value in pairs(self._ui._txt_tooltipTitles) do
    value:addInputEvent("Mouse_On", "HandleEventOn_FarmInfo_All_Tooltip(" .. k .. ")")
    value:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  end
  registerEvent("FromClient_InterActionHarvestInformation", "FromClient_FarmInfo_All_InterActionHarvestInformation")
end
function PaGlobal_FarmInfo_All:prepareOpen(ePopupType, actorKeyRaw)
  if nil == Panel_Housing_FarmInfo_All then
    return
  end
  self._popupType = ePopupType
  if self._ePopupType.installation == ePopupType then
    self:setInstallationMode(actorKeyRaw)
  elseif self._ePopupType.interaction == ePopupType then
    self:setInteractionMode(actorKeyRaw)
  end
  self:update(true)
  Panel_Housing_FarmInfo_All:RegisterUpdateFunc("FromClient_FarmInfo_All_UpdatePerFrame")
  PaGlobal_FarmInfo_All:open()
end
function PaGlobal_FarmInfo_All:open()
  if nil == Panel_Housing_FarmInfo_All then
    return
  end
  Panel_Housing_FarmInfo_All:SetShow(true)
end
function PaGlobal_FarmInfo_All:prepareClose()
  if nil == Panel_Housing_FarmInfo_All then
    return
  end
  Panel_Housing_FarmInfo_All:ClearUpdateLuaFunc()
  PaGlobal_FarmInfo_All:close()
end
function PaGlobal_FarmInfo_All:close()
  if nil == Panel_Housing_FarmInfo_All then
    return
  end
  Panel_Housing_FarmInfo_All:SetShow(false)
end
function PaGlobal_FarmInfo_All:update(isRePosition)
  if nil == Panel_Housing_FarmInfo_All then
    return
  end
  if true == self._isShowOnlyGround then
    local actorKeyRaw = toClient_GetHousingSelectInstallationActorKey()
    if toClient_GetHousingSelectInstallationActorKeyIsSet() then
      self._currentActorKeyRaw = actorKeyRaw
      self._isShowOnlyGround = false
    end
  end
  self:updateUseFarm()
  if true == self._isShowOnlyGround then
    local itemEnchantSSW = housing_getItemEnchantStaticStatus()
    if nil == itemEnchantSSW then
      return
    end
    local characterSSW = itemEnchantSSW:getCharacterStaticStatus()
    if nil == characterSSW then
      return
    end
    self:updateTitle(characterSSW:getName())
    local growingRate = housing_getGrowingRate(itemEnchantSSW:get())
    local remainingTime = 1000000 / growingRate * 5 * 60
    self:updateRemainTime(convertStringFromDatetime(toInt64(0, remainingTime)), Defines.Color.C_FFEFEFEF)
    local ownerHouseHoldNo = housing_getInstallmodeHouseHoldNo()
    local cultivationWeatherSSW = characterSSW:getObjectStaticStatus():getCultivationWeatherStaticStatusWrapper()
    self:updateData(isRePosition, ownerHouseHoldNo, cultivationWeatherSSW, nil)
  else
    if nil == self._currentActorKeyRaw then
      return
    end
    local installationActorProxyWrapper = getInstallationActor(self._currentActorKeyRaw)
    if nil == installationActorProxyWrapper then
      PaGlobal_FarmInfo_All_Close()
      return
    end
    local installationSSW = installationActorProxyWrapper:getStaticStatusWrapper()
    if nil == installationSSW then
      PaGlobal_FarmInfo_All_Close()
      return
    end
    self:updateTitle(installationSSW:getName())
    local progressingInfo = installationActorProxyWrapper:get():getInstallationProgressingInfo()
    local serverUtc64Time = getServerUtc64()
    if nil == progressingInfo then
      PaGlobal_FarmInfo_All_Close()
      return
    end
    if progressingInfo:isGrowingStop() then
      self:updateRemainTime(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_STOP"), Defines.Color.C_FFF26A6A)
    else
      self:updateRemainTime(convertStringFromDatetime(progressingInfo:getCompleteTime(serverUtc64Time)), Defines.Color.C_FFEFEFEF)
    end
    local ownerHouseHoldNo = installationActorProxyWrapper:get():getOwnerHouseholdNo_s64()
    local cultivationWeatherSSW = installationSSW:getObjectStaticStatus():getCultivationWeatherStaticStatusWrapper()
    self:updateData(isRePosition, ownerHouseHoldNo, cultivationWeatherSSW, progressingInfo, serverUtc64Time)
  end
end
function PaGlobal_FarmInfo_All:validate()
  if nil == Panel_Housing_FarmInfo_All then
    return
  end
end
function PaGlobal_FarmInfo_All:updateTitle(name)
  self._ui._txt_title:SetText(name)
end
function PaGlobal_FarmInfo_All:updateRemainTime(remainTime, fontColor)
  self._ui._txt_remainTime:SetText(remainTime)
  self._ui._txt_remainTime:SetFontColor(fontColor)
end
function PaGlobal_FarmInfo_All:updateData(isRePosition, ownerHouseHoldNo, cultivationWeatherSSW, progressingInfo, serverUtc64Time)
  if nil == ownerHouseHoldNo or nil == cultivationWeatherSSW then
    return
  end
  if true == isRePosition then
    self._tempPercent = housing_getInstallationMenuHarvestTempRate(ownerHouseHoldNo)
    self._humidityPercent = housing_getInstallationMenuHarvestHumidity(ownerHouseHoldNo)
    self:setSliderAndStatic("_slider_temperature", "_stc_temperatureArrow", "_txt_temperatureValue", self._tempPercent, cultivationWeatherSSW:getRateByWeather(CppEnums.WeatherKind.WeatherKind_Temperature, self._tempPercent) * 1.0E-4, true)
    self:setSliderAndStatic("_slider_humidity", "_stc_humidityArrow", "_txt_humidityValue", self._humidityPercent, cultivationWeatherSSW:getRateByWeather(CppEnums.WeatherKind.WeatherKind_Humidity, self._humidityPercent) * 1.0E-4, false)
  else
    self:setSliderAndStatic("_slider_temperature", "_stc_temperatureArrow", "_txt_temperatureValue", nil, cultivationWeatherSSW:getRateByWeather(CppEnums.WeatherKind.WeatherKind_Temperature, self._tempPercent) * 1.0E-4, true)
    self:setSliderAndStatic("_slider_humidity", "_stc_humidityArrow", "_txt_humidityValue", nil, cultivationWeatherSSW:getRateByWeather(CppEnums.WeatherKind.WeatherKind_Humidity, self._humidityPercent) * 1.0E-4, false)
  end
  local groundWaterRate = housing_getInstallationMenuHarvestWaterRate(ownerHouseHoldNo)
  local farmWaterRate = housing_getGrowingRateValue(ownerHouseHoldNo, CppEnums.HarvestGrowRateKind.HarvestGrowRateKind_Water) * 1.0E-4
  local totalWaterRate = math.max(math.min(groundWaterRate + farmWaterRate, 100), 0)
  self:setProgressBarOnly("_progress_undergroundWaterBack", totalWaterRate)
  self:setProgressBarOnly("_progress_undergroundWaterFront", groundWaterRate)
  self:setProgressBarOnly("_progress_compost", housing_getGrowingRateValue(ownerHouseHoldNo, CppEnums.HarvestGrowRateKind.HarvestGrowRateKind_Nutrient) * 1.0E-4)
  local plusValue = cultivationWeatherSSW:getRateByWeather(CppEnums.WeatherKind.WeatherKind_Water, totalWaterRate) * 1.0E-4
  if 0 ~= plusValue then
    plusValue = -plusValue
  end
  self._ui._txt_undergroundWaterValue:SetText(string.format("%.2f%%", plusValue))
  self:setSliderHighlight("_stc_temperatureBg", "_stc_temperatureHighLight", cultivationWeatherSSW:getTopValue(CppEnums.WeatherKind.WeatherKind_Temperature))
  self:setSliderHighlight("_stc_humidityBg", "_stc_humidityHighLight", cultivationWeatherSSW:getBottomValue(CppEnums.WeatherKind.WeatherKind_Humidity))
  self:updateIcon("_stc_scarecrowIcon", housing_hasInstallationByType(ownerHouseHoldNo, CppEnums.InstallationType.eType_Scarecrow))
  self:updateIcon("_stc_waterwayIcon", housing_hasInstallationByType(ownerHouseHoldNo, CppEnums.InstallationType.eType_Waterway))
  if nil ~= progressingInfo then
    self:setProgressBar("_progress_growing", "_txt_growingValue", math.floor(progressingInfo:getCurrentProgress(serverUtc64Time) * 1.0E-4))
    self:setProgressBar("_progress_helth", "_txt_helthValue", 100 - progressingInfo:getDecreaseYieldsRate() * 1.0E-4)
    self:setProgressBar("_progress_needWater", "_txt_needWaterValue", 100 - progressingInfo:getNeedWater() * 1.0E-4)
    self:updateIcon("_stc_pruningIcon", progressingInfo:getNeedLop())
    self:updateIcon("_stc_insectDamegeIcon", progressingInfo:getNeedPestControl())
  else
    self:setProgressBar("_progress_growing", "_txt_growingValue", 0)
    self:setProgressBar("_progress_helth", "_txt_helthValue", 100)
    self:setProgressBar("_progress_needWater", "_txt_needWaterValue", 100)
    self:updateIcon("_stc_pruningIcon", false)
    self:updateIcon("_stc_insectDamegeIcon", false)
  end
end
function PaGlobal_FarmInfo_All:setSliderAndStatic(sliderKey, staticKey, textKey, value, textRate, viewDetail)
  local sliderUI = self._ui[sliderKey]
  local staticUI = self._ui[staticKey]
  local textUI = self._ui[textKey]
  if nil == sliderUI or nil == staticUI or nil == textUI then
    return
  end
  if nil ~= value then
    sliderUI:SetControlPos(value)
    staticUI:SetPosX(sliderUI:GetControlButton():GetParentPosX() - Panel_Housing_FarmInfo_All:GetPosX())
  end
  if viewDetail then
    textUI:SetText(string.format("%.2f%%", textRate))
  else
    textUI:SetText(string.format("%.0f%%", textRate))
  end
end
function PaGlobal_FarmInfo_All:setProgressBarOnly(sliderKey, value)
  local sliderUI = self._ui[sliderKey]
  if nil == sliderUI then
    return
  end
  if nil ~= value then
    sliderUI:SetProgressRate(value)
  end
end
function PaGlobal_FarmInfo_All:setSliderHighlight(maxStaticKey, staticKey, valuePair)
  local staticUI = self._ui[staticKey]
  local maxSizeStaticUI = self._ui[maxStaticKey]
  local rate = 0
  if nil == staticUI or nil == maxSizeStaticUI then
    return
  end
  if nil ~= valuePair then
    rate = (valuePair.y - valuePair.x) * 0.01
  end
  if 0 == rate then
    staticUI:SetShow(false)
    return
  end
  staticUI:SetShow(true)
  staticUI:SetSize(rate * maxSizeStaticUI:GetSizeX(), staticUI:GetSizeY())
  staticUI:SetPosX(valuePair.x * 0.01 * maxSizeStaticUI:GetSizeX() + maxSizeStaticUI:GetPosX())
end
function PaGlobal_FarmInfo_All:setProgressBar(progressBarKey, textKey, value)
  local progressBarUI = self._ui[progressBarKey]
  local textUI = self._ui[textKey]
  if nil == progressBarUI or nil == textUI then
    return
  end
  progressBarUI:SetProgressRate(value)
  textUI:SetText(string.format("%.0f%%", value))
end
function PaGlobal_FarmInfo_All:updateUseFarm()
  local houseWrapper = housing_getHouseholdActor_CurrentPosition()
  if nil == houseWrapper then
    return
  end
  local css = houseWrapper:getStaticStatusWrapper():get()
  self._ui._txt_spaceValue:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TEXT_INSTALLOBJECTCOUNT", "sum", houseWrapper:getInstallationCountSum(), "maxCount", css:getInstallationMaxCount()))
end
function PaGlobal_FarmInfo_All:updateCursor()
  local tempPercent = self._ui._slider_temperature:GetControlPos()
  local humidityPercent = self._ui._slider_humidity:GetControlPos()
  self._tempPercent = tempPercent * 100
  self._humidityPercent = humidityPercent * 100
  self:update(false)
end
function PaGlobal_FarmInfo_All:updateIcon(key, isOn)
  local targetUI = self._ui[key]
  local uvGroup = self._uiIconUV[self._plantType][key]
  if nil == targetUI or nil == uvGroup then
    return
  end
  targetUI:ChangeTextureInfoName(uvGroup.url)
  local x1, y1, x2, y2 = setTextureUV_Func(targetUI, uvGroup[isOn].x1, uvGroup[isOn].y1, uvGroup[isOn].x2, uvGroup[isOn].y2)
  targetUI:getBaseTexture():setUV(x1, y1, x2, y2)
  targetUI:setRenderTexture(targetUI:getBaseTexture())
  targetUI:SetShow(true)
end
function PaGlobal_FarmInfo_All:initIconUV()
  self._uiIconUV[self._ePlantType.crops] = {
    _stc_scarecrowIcon = {
      url = "combine/etc/combine_etc_housing_00.dds",
      [true] = {
        x1 = 471,
        y1 = 266,
        x2 = 511,
        y2 = 306
      },
      [false] = {
        x1 = 430,
        y1 = 266,
        x2 = 470,
        y2 = 306
      }
    },
    _stc_waterwayIcon = {
      url = "combine/etc/combine_etc_housing_00.dds",
      [true] = {
        x1 = 471,
        y1 = 307,
        x2 = 511,
        y2 = 347
      },
      [false] = {
        x1 = 430,
        y1 = 307,
        x2 = 470,
        y2 = 347
      }
    },
    _stc_pruningIcon = {
      url = "combine/etc/combine_etc_housing_00.dds",
      [true] = {
        x1 = 471,
        y1 = 471,
        x2 = 511,
        y2 = 511
      },
      [false] = {
        x1 = 430,
        y1 = 471,
        x2 = 470,
        y2 = 511
      }
    },
    _stc_insectDamegeIcon = {
      url = "combine/etc/combine_etc_housing_00.dds",
      [true] = {
        x1 = 471,
        y1 = 430,
        x2 = 511,
        y2 = 470
      },
      [false] = {
        x1 = 430,
        y1 = 430,
        x2 = 470,
        y2 = 470
      }
    }
  }
  self._uiIconUV[self._ePlantType.livestock] = {
    _stc_scarecrowIcon = {
      url = "combine/etc/combine_etc_housing_00.dds",
      [true] = {
        x1 = 471,
        y1 = 266,
        x2 = 511,
        y2 = 306
      },
      [false] = {
        x1 = 430,
        y1 = 266,
        x2 = 470,
        y2 = 306
      }
    },
    _stc_waterwayIcon = {
      url = "combine/etc/combine_etc_housing_00.dds",
      [true] = {
        x1 = 471,
        y1 = 307,
        x2 = 511,
        y2 = 347
      },
      [false] = {
        x1 = 430,
        y1 = 307,
        x2 = 470,
        y2 = 347
      }
    },
    _stc_pruningIcon = {
      url = "combine/etc/combine_etc_housing_00.dds",
      [true] = {
        x1 = 471,
        y1 = 348,
        x2 = 511,
        y2 = 388
      },
      [false] = {
        x1 = 430,
        y1 = 348,
        x2 = 470,
        y2 = 388
      }
    },
    _stc_insectDamegeIcon = {
      url = "combine/etc/combine_etc_housing_00.dds",
      [true] = {
        x1 = 471,
        y1 = 389,
        x2 = 511,
        y2 = 429
      },
      [false] = {
        x1 = 430,
        y1 = 389,
        x2 = 470,
        y2 = 429
      }
    }
  }
end
function PaGlobal_FarmInfo_All:showCompost(isShow)
  self._ui._txt_compostTitle:SetShow(isShow)
  self._ui._progress_compost:SetShow(isShow)
  self._ui._stc_compostBg:SetShow(isShow)
  self._ui._stc_compostAdd:SetShow(isShow)
end
function PaGlobal_FarmInfo_All:setInstallationMode(actorKeyRaw)
  self._isShowOnlyGround = true
  self._currentActorKeyRaw = toClient_GetHousingSelectInstallationActorKey()
  if nil == self._currentActorKeyRaw then
    return
  end
  self._plantType = self._ePlantType.crops
  self._ui._txt_pruningDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HOUSEING_FARMINFO_NEW_PRUNINGDESC"))
  self._ui._txt_insectDamegeDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HOUSEING_FARMINFO_NEW_INSECTDAMEGEDESC"))
  self:showCompost(true)
end
function PaGlobal_FarmInfo_All:setInteractionMode(actorKeyRaw)
  self._isShowOnlyGround = false
  self._currentActorKeyRaw = actorKeyRaw
  local installationActorProxyWrapper = getInstallationActor(self._currentActorKeyRaw)
  if nil == installationActorProxyWrapper then
    return
  end
  local installationType = installationActorProxyWrapper:getStaticStatusWrapper():getObjectStaticStatus():getInstallationType()
  if CppEnums.InstallationType.eType_LivestockHarvest == installationType then
    self._plantType = self._ePlantType.livestock
    self._ui._txt_pruningDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FARMINFO_NEEDFEEDING"))
    self._ui._txt_insectDamegeDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FARMINFO_NEEDKILLBUG"))
    self:showCompost(false)
  else
    self._plantType = self._ePlantType.crops
    self._ui._txt_pruningDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HOUSEING_FARMINFO_NEW_PRUNINGDESC"))
    self._ui._txt_insectDamegeDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HOUSEING_FARMINFO_NEW_INSECTDAMEGEDESC"))
    self:showCompost(true)
  end
end
