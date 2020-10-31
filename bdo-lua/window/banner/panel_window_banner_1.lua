function PaGlobal_Banner:initData()
  self._basicTexture = {
    [self._eBannerType._onAir] = "Combine/CommonIcon/Ingame_Rightpopup_Banner_BDOTV.dds",
    [self._eBannerType._eventBanner] = "Combine/CommonIcon/Ingame_Rightpopup_Banner_EVNET.dds",
    [self._eBannerType._blackFriday] = "Combine/CommonIcon/Ingame_Rightpopup_Banner_BF.dds",
    [self._eBannerType._newProduct] = ""
  }
  self._isEnableWebControl = {
    [self._eBannerType._onAir] = true,
    [self._eBannerType._eventBanner] = false,
    [self._eBannerType._blackFriday] = false,
    [self._eBannerType._newProduct] = true
  }
  self._isDontAgainAutoSave = {
    [self._eBannerType._onAir] = false,
    [self._eBannerType._eventBanner] = true,
    [self._eBannerType._blackFriday] = true,
    [self._eBannerType._newProduct] = false
  }
  self._isFromEventDirect = {
    [self._eBannerType._onAir] = true,
    [self._eBannerType._eventBanner] = false,
    [self._eBannerType._blackFriday] = false,
    [self._eBannerType._newProduct] = false
  }
  self._startAniTime = {
    [self._eBannerType._onAir] = {_start = 2, _end = 2.5},
    [self._eBannerType._eventBanner] = {_start = 3, _end = 3.5},
    [self._eBannerType._blackFriday] = {_start = 3, _end = 3.5},
    [self._eBannerType._newProduct] = {_start = 3, _end = 3.5}
  }
  self._endAniTime = {
    [self._eBannerType._onAir] = {_start = 0, _end = 0.3},
    [self._eBannerType._eventBanner] = {_start = 0, _end = 0.3},
    [self._eBannerType._blackFriday] = {_start = 0, _end = 0.3},
    [self._eBannerType._newProduct] = {_start = 0, _end = 0.3}
  }
  self._viewEndTime = {
    [self._eBannerType._onAir] = 15,
    [self._eBannerType._eventBanner] = 15,
    [self._eBannerType._blackFriday] = 15,
    [self._eBannerType._newProduct] = 15
  }
end
function PaGlobal_Banner:initialize()
  if true == PaGlobal_Banner._initialize then
    return
  end
  self:initData()
  self._ui._stc_bannerArea = UI.getChildControl(Panel_Window_Banner, "Static_BannerArea")
  self._ui._txt_close = UI.getChildControl(self._ui._stc_bannerArea, "StaticText_Close")
  self._ui._webControl = UI.createControl(__ePAUIControl_WebControl, Panel_Window_Banner, "Web_BannerControl")
  self._ui._webControl:SetSize(Panel_Window_Banner:GetSizeX(), Panel_Window_Banner:GetSizeY())
  self._ui._webControl:SetPosX(0)
  self._ui._webControl:SetPosY(0)
  self._ui._webControl:SetShow(false)
  self._currentBanner = self._eBannerType._end
  self:resize()
  PaGlobal_Banner:registEventHandler()
  PaGlobal_Banner:validate()
  PaGlobal_Banner:wholeUpdateBanner()
  PaGlobal_Banner._initialize = true
end
function PaGlobal_Banner:registEventHandler()
  self._ui._stc_bannerArea:addInputEvent("Mouse_LUp", "HandleEventMLUp_Banner_ClickEvent()")
  self._ui._txt_close:addInputEvent("Mouse_LUp", "HandleEventMLUp_Banner_NotShowClose()")
  registerEvent("FromClient_OnAir", "FromClient_Banner_showOnAirBanner")
end
function PaGlobal_Banner:prepareOpen()
  if nil == Panel_Window_Banner then
    return
  end
  PaGlobal_Banner:open()
end
function PaGlobal_Banner:open()
  if nil == Panel_Window_Banner then
    return
  end
  Panel_Window_Banner:SetShow(true)
end
function PaGlobal_Banner:prepareClose()
  if nil == Panel_Window_Banner then
    return
  end
  PaGlobal_Banner:close()
end
function PaGlobal_Banner:close()
  if nil == Panel_Window_Banner then
    return
  end
  Panel_Window_Banner:SetShow(false)
end
function PaGlobal_Banner:validate()
  self._ui._stc_bannerArea:isValidate()
  self._ui._txt_close:isValidate()
end
function PaGlobal_Banner:wholeUpdateBanner()
  self._currentBanner = self._eBannerType._onAir
  self._isWholeState = true
  self:updateBanner(self._currentBanner, false)
end
function PaGlobal_Banner:updateBanner(eBannerType, isRunSingle)
  if eBannerType >= self._eBannerType._end then
    return
  end
  if (false == isRunSingle or false == self._isFromEventDirect[eBannerType]) and false == self:isCheckCondition(eBannerType) then
    self:updatePerSkipNextState()
    return
  end
  if true == self:isOnceClientCheck(eBannerType) then
    self:updatePerSkipNextState()
    return
  else
    self:saveOnceClientCheck(eBannerType)
  end
  if false == self:isDayCheck(eBannerType) then
    self:updatePerSkipNextState()
    return
  end
  self:setRenderTexture(eBannerType)
  self:setURL(eBannerType)
  self:updateControlSetting(eBannerType)
  self:prepareOpen()
  self._currentFrame = self._eFrameState._bannerView
  Panel_Window_Banner:RegisterUpdateFunc("PaGlobal_Banner_UpdatePerframe")
  PaGloabl_Banner_ShowAni()
end
function PaGlobal_Banner:updatePerFrame_bannerView(deltaTime)
  self._updateTime = self._updateTime + deltaTime
  if self._viewEndTime[self._currentBanner] < self._updateTime then
    self:updateCheckBannerViewEnd()
  end
end
function PaGlobal_Banner:updatePerFrame_bannerCheck(deltaTime)
  self._updateTime = self._updateTime + deltaTime
  if false == Panel_Window_Banner:isPlayAnimation() then
    self:updateCheckBannerCheckEnd()
  end
  if self._checkEndTime < self._updateTime then
    _PA_LOG("\236\178\156\235\167\140\234\184\176", "updatePerFrame_bannerCheck Animation TimeOut !!!!!!!!!")
    self:updatePerEndState()
  end
end
function PaGlobal_Banner:updatePerFrame_End(deltaTime)
  Panel_Window_Banner:ClearUpdateLuaFunc()
  self:prepareClose()
end
function PaGlobal_Banner:setRenderTexture(eBannerType)
  if true == self._isEnableWebControl[eBannerType] then
    return
  end
  if nil == self._basicTexture[eBannerType] then
    return
  end
  self._ui._webControl:SetShow(false)
  self._ui._stc_bannerArea:SetShow(true)
  self._ui._stc_bannerArea:ChangeTextureInfoName(self._basicTexture[eBannerType])
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_bannerArea, self._texureUV.x1, self._texureUV.y1, self._texureUV.x2, self._texureUV.y2)
  self._ui._stc_bannerArea:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui._stc_bannerArea:setRenderTexture(self._ui._stc_bannerArea:getBaseTexture())
end
function PaGlobal_Banner:setURL(eBannerType)
  if false == self._isEnableWebControl[eBannerType] then
    return
  end
  local url
  if self._eBannerType._onAir == eBannerType then
    url = PaGloabl_Banner_GetOnAirURL()
  elseif self._eBannerType._eventBanner == eBannerType then
    url = PaGloabl_Banner_GetBloodAltarURL()
  elseif self._eBannerType._newProduct == eBannerType then
    url = PaGlobal_Banner_GetNewProductURL()
  end
  if nil == url then
    return
  end
  self._ui._webControl:SetShow(true)
  self._ui._stc_bannerArea:SetShow(false)
  self._ui._webControl:SetUrl(Panel_Window_Banner:GetSizeX(), Panel_Window_Banner:GetSizeY(), url, false, true)
end
function PaGlobal_Banner:resize()
  Panel_Window_Banner:SetPosXY(getScreenSizeX() - Panel_Window_Banner:GetSizeX() - 10, getScreenSizeY())
end
function PaGlobal_Banner:updateCheckBannerViewEnd()
  self:clearUpdateData()
  PaGloabl_Banner_HideAni()
  self._currentFrame = self._eFrameState._bannerCheck
end
function PaGlobal_Banner:updateCheckBannerCheckEnd()
  if true == self._isWholeState then
    if self._currentBanner < self._eBannerType._end - 1 then
      self:updateCheckAutoSave(self._currentBanner)
      self._currentBanner = self._currentBanner + 1
      self:clearUpdateData()
      self:updateBanner(self._currentBanner, false)
    else
      self:updatePerEndState()
    end
  else
    self:updatePerEndState()
  end
end
function PaGlobal_Banner:updatePerEndState()
  self:clearUpdateData()
  self:updateCheckAutoSave(self._currentBanner)
  self._currentFrame = self._eFrameState._end
end
function PaGlobal_Banner:updatePerSkipNextState()
  if true == Panel_Window_Banner:GetShow() then
    if self._eFrameState._bannerView == self._currentFrame then
      self._currentFrame = self._eFrameState._bannerViewEnd
    end
  else
    self:updateCheckBannerCheckEnd()
  end
end
function PaGlobal_Banner:clearUpdateData()
  self._updateTime = 0
end
function PaGlobal_Banner:isDayCheck(eBannerType)
  local _year = ToClient_GetThisYear()
  local _month = ToClient_GetThisMonth()
  local _day = ToClient_GetToday()
  local saveIndex = self:getSaveIndex(eBannerType)
  if nil == saveIndex then
    return false
  end
  local dayCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListTime(saveIndex)
  if nil ~= dayCheck then
    local savedYear = dayCheck:GetYear()
    local savedMonth = dayCheck:GetMonth()
    local savedDay = dayCheck:GetDay()
    if _year == savedYear and _month == savedMonth and _day == savedDay then
      return false
    end
  end
  return true
end
function PaGlobal_Banner:saveNoShowToDay(eBannerType)
  local _year = ToClient_GetThisYear()
  local _month = ToClient_GetThisMonth()
  local _day = ToClient_GetToday()
  local saveIndex = self:getSaveIndex(eBannerType)
  if nil == saveIndex then
    return
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListTime(saveIndex, _year, _month, _day, 0, 0, 0, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function PaGlobal_Banner:getSaveIndex(eBannerType)
  if self._eBannerType._onAir == eBannerType then
    return __eOnAirBanner
  elseif self._eBannerType._eventBanner == eBannerType then
    return __eBottomIngamecashshopBanner
  elseif self._eBannerType._blackFriday == eBannerType then
    return nil
  elseif self._eBannerType._newProduct == eBannerType then
    return __eBlackFridayBanner
  end
  return nil
end
function PaGlobal_Banner:isCheckCondition(eBannerType)
  if self._eBannerType._onAir == eBannerType then
    local temporaryWrapper = getTemporaryInformationWrapper()
    if nil ~= temporaryWrapper and temporaryWrapper:isOnAir() then
      return true
    end
  elseif self._eBannerType._eventBanner == eBannerType then
    return "" ~= PaGloabl_Banner_GetBloodAltarURL()
  elseif self._eBannerType._blackFriday == eBannerType then
    return false
  elseif self._eBannerType._newProduct == eBannerType then
    return "" ~= PaGlobal_Banner_GetNewProductURL()
  end
  return false
end
function PaGlobal_Banner:isOnceClientCheck(eBannerType)
  local saveIndex = self:getOnceSaveIndex(eBannerType)
  if nil == saveIndex then
    return false
  end
  return ToClient_getGameUIManagerWrapper():getLuaCacheDataListBoolNoSave(saveIndex)
end
function PaGlobal_Banner:saveOnceClientCheck(eBannerType)
  local saveIndex = self:getOnceSaveIndex(eBannerType)
  if nil == saveIndex then
    return
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBoolNoSave(saveIndex, true)
end
function PaGlobal_Banner:getOnceSaveIndex(eBannerType)
  return nil
end
function PaGlobal_Banner:updateCheckAutoSave(eBannerType)
  if false == self._isDontAgainAutoSave[eBannerType] then
    return
  end
  self:saveNoShowToDay(eBannerType)
end
function PaGlobal_Banner:updateControlSetting(eBannerType)
  if true == self._isDontAgainAutoSave[eBannerType] then
    self._ui._txt_close:SetIgnore(true)
    self._ui._txt_close:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BANNER_EVENTPAGEMOVE"))
  else
    self._ui._txt_close:SetIgnore(false)
    self._ui._txt_close:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INGAMEBANNER_TODAYNOSHOW"))
  end
end
function PaGlobal_Banner:runSingleBanner(eBannerType)
  self._currentBanner = eBannerType
  self._isWholeState = false
  self:updateBanner(self._currentBanner, true)
end
