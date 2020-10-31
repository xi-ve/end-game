function PaGlobal_Login_All:initialize()
  if true == PaGlobal_Login_All._initialize then
    return
  end
  self._ui._stc_webUI = UI.getChildControl(Panel_Lobby_Login_All, "Static_WebParent")
  self._ui._stc_bi = UI.getChildControl(Panel_Lobby_Login_All, "Static_BI")
  self._ui._btn_login = UI.getChildControl(Panel_Lobby_Login_All, "Button_Login")
  self._ui._btn_exit = UI.getChildControl(Panel_Lobby_Login_All, "Button_Exit")
  self._ui._btn_option = UI.getChildControl(Panel_Lobby_Login_All, "Button_GameOption_Login")
  self._ui._btn_changeAccount = UI.getChildControl(Panel_Lobby_Login_All, "Button_ChangeAccount")
  self._ui._edit_id = UI.getChildControl(Panel_Lobby_Login_All, "Edit_ID")
  self._ui._txt_inputID = UI.getChildControl(Panel_Lobby_Login_All, "StaticText_InputTxt")
  self._ui._stc_blackLine = UI.getChildControl(Panel_Lobby_Login_All, "Static_Blackline_down")
  self._ui._stc_pearlabyssCI = UI.getChildControl(Panel_Lobby_Login_All, "Static_CI")
  self._ui._stc_daumCI = UI.getChildControl(Panel_Lobby_Login_All, "Static_DaumCI")
  self._isConsole = isGameServiceTypeConsole()
  if false == isLoginIDShow() then
    self._ui._edit_id:SetShow(false)
    self._ui._txt_inputID:SetShow(false)
  else
    self._ui._edit_id:SetShow(true)
    self._ui._txt_inputID:SetShow(true)
    self._ui._edit_id:SetEditText(getLoginID())
  end
  if true == self._isConsole then
    self._ui._btn_option:SetShow(false)
  else
    self._ui._btn_changeAccount:SetShow(false)
  end
  if true == ToClient_isPS4() then
    self._ui._btn_changeAccount:SetShow(false)
    self._ui._btn_exit:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DEADMESSAGE_BACK"))
  end
  self._currentMovieIndex = 1
  self:shuffleOrder(self._movieOrder)
  if true == ToClient_IsContentsGroupOpen("7") then
    self._movieURL = {
      "coui://UI_Movie/O_01.webm",
      "coui://UI_Movie/O_02.webm",
      "coui://UI_Movie/O_03.webm"
    }
    self._movieLength = {
      8000,
      7000,
      5000
    }
  end
  self:initLoginMovie()
  setPresentLock(true)
  PaGlobal_Login_All:registEventHandler()
  PaGlobal_Login_All:validate()
  PaGlobal_Login_All:prepareOpen()
  PaGlobal_Login_All:onScreenResize()
  PaGlobal_Login_All._initialize = true
end
function PaGlobal_Login_All:registEventHandler()
  if nil == Panel_Lobby_Login_All then
    return
  end
  self._ui._btn_login:addInputEvent("Mouse_LUp", "HandleEventLUp_Login_All_LoginStart()")
  self._ui._btn_exit:addInputEvent("Mouse_LUp", "HandleEventLUp_Login_All_GameExit()")
  self._ui._btn_changeAccount:addInputEvent("Mouse_LUp", "HandleEventLUp_Login_All_ChangeAccount()")
  self._ui._btn_option:addInputEvent("Mouse_LUp", "HandleEventLUp_Login_All_GameOption()")
  registerEvent("ToClient_EndGuideMovie", "FromClient_Login_All_OnMovieEvent")
  registerEvent("onScreenResize", "FromClient_Login_All_onScreenResize")
  if true == self._isConsole then
    registerEvent("FromClient_ClickToLogin", "FromClient_Login_All_ClickToLogin")
  end
end
function PaGlobal_Login_All:prepareOpen()
  if nil == Panel_Lobby_Login_All then
    return
  end
  PaGlobal_Login_All:open()
end
function PaGlobal_Login_All:open()
  if nil == Panel_Lobby_Login_All then
    return
  end
  Panel_Lobby_Login_All:SetShow(true)
end
function PaGlobal_Login_All:prepareClose()
  if nil == Panel_Lobby_Login_All then
    return
  end
  PaGlobal_Login_All:close()
end
function PaGlobal_Login_All:close()
  if nil == Panel_Lobby_Login_All then
    return
  end
  Panel_Lobby_Login_All:SetShow(false)
end
function PaGlobal_Login_All:update()
  if nil == Panel_Lobby_Login_All then
    return
  end
end
function PaGlobal_Login_All:validate()
  if nil == Panel_Lobby_Login_All then
    return
  end
  self._ui._stc_webUI:isValidate()
  self._ui._stc_bi:isValidate()
  self._ui._btn_login:isValidate()
  self._ui._btn_exit:isValidate()
  self._ui._btn_option:isValidate()
  self._ui._btn_changeAccount:isValidate()
  self._ui._edit_id:isValidate()
  self._ui._txt_inputID:isValidate()
  self._ui._stc_blackLine:isValidate()
  self._ui._stc_pearlabyssCI:isValidate()
  self._ui._stc_daumCI:isValidate()
end
function PaGlobal_Login_All:initLoginMovie()
  if nil == self._ui._web_loginMovie then
    self._ui._web_loginMovie = UI.createControl(__ePAUIControl_WebControl, self._ui._stc_webUI, "Static_BgMovie")
  end
  if self._isConsole then
    Panel_Lobby_Login_All:SetSize(getScreenSizeX(), getScreenSizeY())
    Panel_Lobby_Login_All:SetHorizonCenter()
    Panel_Lobby_Login_All:SetVerticalMiddle()
    self._ui._stc_webUI:SetHorizonCenter()
    self._ui._stc_webUI:SetVerticalMiddle()
    self._ui._web_loginMovie:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
    self._ui._web_loginMovie:SetHorizonCenter()
    self._ui._web_loginMovie:SetVerticalMiddle()
  else
    local uiScale = getGlobalScale()
    local sizeX = getResolutionSizeX()
    local sizeY = getResolutionSizeY()
    sizeX = sizeX / uiScale
    sizeY = sizeY / uiScale
    local movieSizeX = sizeX
    local movieSizeY = sizeX * 1080 / 1920
    local posX = 0
    local posY = 0
    if sizeY >= movieSizeY then
      posY = (sizeY - movieSizeY) * 0.5
    else
      movieSizeX = sizeY * 1920 / 1080
      movieSizeY = sizeY
      posX = (sizeX - movieSizeX) * 0.5
    end
    Panel_Lobby_Login_All:SetPosX(0)
    Panel_Lobby_Login_All:SetPosY(0)
    Panel_Lobby_Login_All:SetSize(sizeX, sizeY)
    local marginX = movieSizeX * 0.013
    local marginY = movieSizeY * 0.013
    self._ui._web_loginMovie:SetPosX(posX - marginX * 0.5)
    self._ui._web_loginMovie:SetPosY(posY - marginY * 0.5)
    self._ui._web_loginMovie:SetSize(movieSizeX + marginX, movieSizeY + marginY)
  end
  self._ui._web_loginMovie:SetUrl(1920, 1080, "coui://UI_Data/UI_Html/LobbyBG_Movie.html")
end
function PaGlobal_Login_All:shuffleOrder(table)
  if nil == table or nil == #table then
    return
  end
  if #table <= 1 then
    return
  end
  for ii = 1, #table do
    local temp = table[ii]
    local posToShuffle = getRandomValue(1, #table)
    table[ii] = table[posToShuffle]
    table[posToShuffle] = temp
  end
end
function PaGlobal_Login_All:onMovieEvent(param)
  if 1 == param then
    if nil ~= self._ui._web_loginMovie then
      self._ui._web_loginMovie:TriggerEvent("PlayMovie", self._movieURL[self._movieOrder[self._currentMovieIndex]])
    end
  elseif 2 == param then
    self._currentMovieIndex = self._currentMovieIndex + 1
    if nil == self._movieOrder[self._currentMovieIndex] then
      local count = #self._movieOrder
      self._currentMovieIndex = getRandomValue(1, count)
    end
    self._ui._web_loginMovie:TriggerEvent("PlayMovie", self._movieURL[self._movieOrder[self._currentMovieIndex]])
  end
end
function PaGlobal_Login_All:onScreenResize()
  if self._isConsole then
    Panel_Lobby_Login_All:SetSize(getScreenSizeX(), getScreenSizeY())
    Panel_Lobby_Login_All:SetSpanSize(0, 0)
    Panel_Lobby_Login_All:SetHorizonCenter()
    Panel_Lobby_Login_All:SetVerticalMiddle()
    if nil ~= self._ui._web_loginMovie then
      self._ui._web_loginMovie:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
      self._ui._web_loginMovie:SetSpanSize(0, 0)
      self._ui._web_loginMovie:SetHorizonCenter()
      self._ui._web_loginMovie:SetVerticalMiddle()
    end
  else
    local uiScale = getGlobalScale()
    local sizeX = getResolutionSizeX()
    local sizeY = getResolutionSizeY()
    sizeX = sizeX / uiScale
    sizeY = sizeY / uiScale
    local movieSizeX = sizeX
    local movieSizeY = sizeX * 1080 / 1920
    local posX = 0
    local posY = 0
    if sizeY >= movieSizeY then
      posY = (sizeY - movieSizeY) * 0.5
    else
      movieSizeX = sizeY * 1920 / 1080
      movieSizeY = sizeY
      posX = (sizeX - movieSizeX) * 0.5
    end
    Panel_Lobby_Login_All:SetPosX(0)
    Panel_Lobby_Login_All:SetPosY(0)
    Panel_Lobby_Login_All:SetSize(sizeX, sizeY)
    local marginX = movieSizeX * 0.013
    local marginY = movieSizeY * 0.013
    if nil ~= self._ui._web_loginMovie then
      self._ui._web_loginMovie:SetPosX(posX - marginX * 0.5)
      self._ui._web_loginMovie:SetPosY(posY - marginY * 0.5)
      self._ui._web_loginMovie:SetSize(movieSizeX + marginX, movieSizeY + marginY)
    end
  end
  self._ui._btn_login:ComputePos()
  self._ui._btn_exit:ComputePos()
  self._ui._btn_option:ComputePos()
  self._ui._btn_changeAccount:ComputePos()
  self._ui._edit_id:ComputePos()
  self._ui._txt_inputID:ComputePos()
  self._ui._stc_blackLine:SetShow(false)
  if isGameTypeEnglish() then
    self._ui._stc_daumCI:SetSize(144, 26)
    self._ui._stc_daumCI:ChangeTextureInfoName("new_ui_common_forlua/window/lobby/login_CI_Daum.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_daumCI, 0, 0, 144, 26)
    self._ui._stc_daumCI:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_daumCI:setRenderTexture(self._ui._stc_daumCI:getBaseTexture())
    self._ui._stc_pearlabyssCI:SetSpanSize(self._ui._stc_daumCI:GetSizeX() + 30, (self._ui._stc_blackLine:GetSizeY() - self._ui._stc_pearlabyssCI:GetSizeY()) * 0.5)
  elseif isGameTypeKorea() or isGameTypeTaiwan() or isGameTypeGT() or isGameTypeTR() or isGameTypeTH() or isGameTypeID() or true == self._isConsole or isGameTypeRussia() or isGameTypeJapan() then
    self._ui._stc_daumCI:SetShow(false)
    if false == self._isConsole then
      self._ui._stc_pearlabyssCI:SetSpanSize(10, (self._ui._stc_blackLine:GetSizeY() - self._ui._stc_pearlabyssCI:GetSizeY()) * 0.5)
    else
      local getConsoleUIOffset = ToClient_GetConsoleUIOffset()
      if 0 < getConsoleUIOffset then
        local uiOffsetX = getOriginScreenSizeX() * ToClient_GetConsoleUIOffset()
        local uiOffsetY = getOriginScreenSizeY() * ToClient_GetConsoleUIOffset()
        self._ui._stc_pearlabyssCI:SetSpanSize(Panel_Lobby_Login_All:GetPosX() + uiOffsetX, (self._ui._stc_blackLine:GetSizeY() - self._ui._stc_pearlabyssCI:GetSizeY()) * 0.5 + uiOffsetY)
      else
        self._ui._stc_pearlabyssCI:SetSpanSize(Panel_Lobby_Login_All:GetPosX() + 40, (self._ui._stc_blackLine:GetSizeY() - self._ui._stc_pearlabyssCI:GetSizeY()) * 0.5)
      end
    end
  elseif isGameTypeSA() then
    self._ui._stc_daumCI:SetSize(136, 50)
    self._ui._stc_daumCI:ChangeTextureInfoName("new_ui_common_forlua/window/lobby/login_CI_Daum.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_daumCI, 0, 0, 136, 50)
    self._ui._stc_daumCI:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_daumCI:setRenderTexture(self._ui._stc_daumCI:getBaseTexture())
    self._ui._stc_pearlabyssCI:SetSpanSize(self._ui._stc_daumCI:GetSizeX() + 30, (self._ui._stc_blackLine:GetSizeY() - self._ui._stc_pearlabyssCI:GetSizeY()) * 0.5)
  elseif isGameTypeKR2() then
    self._ui._stc_daumCI:SetSize(95, 53)
    self._ui._stc_daumCI:ChangeTextureInfoName("new_ui_common_forlua/window/lobby/login_CI_Daum.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_daumCI, 0, 0, 95, 53)
    self._ui._stc_daumCI:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_daumCI:setRenderTexture(self._ui._stc_daumCI:getBaseTexture())
    self._ui._stc_pearlabyssCI:SetSpanSize(self._ui._stc_daumCI:GetSizeX() + 30, (self._ui._stc_blackLine:GetSizeY() - self._ui._stc_pearlabyssCI:GetSizeY()) * 0.5)
  else
    self._ui._stc_daumCI:SetSize(144, 26)
    self._ui._stc_daumCI:ChangeTextureInfoName("new_ui_common_forlua/window/lobby/login_CI_Daum.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_daumCI, 0, 0, 144, 26)
    self._ui._stc_daumCI:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_daumCI:setRenderTexture(self._ui._stc_daumCI:getBaseTexture())
    self._ui._stc_pearlabyssCI:SetSpanSize(self._ui._stc_daumCI:GetSizeX() + 30, (self._ui._stc_blackLine:GetSizeY() - self._ui._stc_pearlabyssCI:GetSizeY()) * 0.5)
  end
  self._ui._stc_daumCI:SetSpanSize(20, (self._ui._stc_blackLine:GetSizeY() - self._ui._stc_daumCI:GetSizeY()) * 0.5)
  self._ui._stc_bi:ComputePos()
  self._ui._stc_pearlabyssCI:ComputePos()
  self._ui._stc_daumCI:ComputePos()
  self._ui._stc_blackLine:ComputePos()
  self._ui._stc_bi:SetPosY(getScreenSizeY() * 0.14)
  if self._isConsole then
    self._ui._stc_pearlabyssCI:SetSpanSize(30, 12)
  end
  PaGlobal_CheckGamerTag()
end
function PaGlobal_Login_All:enterLogin()
  connectToGame(self._ui._edit_id:GetEditText(), "\234\178\128\236\157\128\236\160\132\236\130\172\235\185\132\235\178\136")
end
function PaGlobal_Login_All:updateButtonDisable(isDisable)
  if true == isDisable then
    self._ui._btn_login:SetEnable(false)
    self._ui._btn_login:SetMonoTone(true)
    self._ui._btn_login:SetIgnore(true)
    self._ui._btn_exit:SetEnable(false)
    self._ui._btn_exit:SetMonoTone(true)
    self._ui._btn_exit:SetIgnore(true)
    self._ui._btn_option:SetEnable(false)
    self._ui._btn_option:SetMonoTone(true)
    self._ui._btn_option:SetIgnore(true)
    self._ui._btn_changeAccount:SetEnable(false)
    self._ui._btn_changeAccount:SetMonoTone(true)
    self._ui._btn_changeAccount:SetIgnore(true)
  else
    self._ui._btn_login:SetEnable(true)
    self._ui._btn_login:SetMonoTone(false)
    self._ui._btn_login:SetIgnore(false)
    self._ui._btn_exit:SetEnable(true)
    self._ui._btn_exit:SetMonoTone(false)
    self._ui._btn_exit:SetIgnore(false)
    self._ui._btn_option:SetEnable(true)
    self._ui._btn_option:SetMonoTone(false)
    self._ui._btn_option:SetIgnore(false)
    self._ui._btn_changeAccount:SetEnable(true)
    self._ui._btn_changeAccount:SetMonoTone(false)
    self._ui._btn_changeAccount:SetIgnore(false)
  end
end
