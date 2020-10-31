function PaGlobal_FarmingTimer:initialize()
  if true == PaGlobal_FarmingTimer._initialize then
    return
  end
  self._ui.txt_Time = UI.getChildControl(Panel_Widget_FarmingTimer_All, "StaticText_Time")
  self._ui.chk_Start = UI.getChildControl(Panel_Widget_FarmingTimer_All, "CheckButton_Start")
  self._ui.btn_Stop = UI.getChildControl(Panel_Widget_FarmingTimer_All, "Button_Stop")
  self._ui.btn_Reset = UI.getChildControl(Panel_Widget_FarmingTimer_All, "Button_Reset")
  self._ui.txt_SlotCount = UI.getChildControl(Panel_Widget_FarmingTimer_All, "StaticText_SlotCount")
  self._ui.btn_Report = UI.getChildControl(Panel_Widget_FarmingTimer_All, "Button_Report")
  self._ui.btn_Close = UI.getChildControl(Panel_Widget_FarmingTimer_All, "Button_Close")
  self._ui.btn_Popup = UI.getChildControl(Panel_Widget_FarmingTimer_All, "Button_Popup")
  self:validate()
  self:registEventHandler()
  local SizeX = Panel_Widget_Function:GetSizeX()
  local RadarPosX = FGlobal_Panel_Radar_GetPosX() - FGlobal_Panel_Radar_GetSizeX() / 2 - Panel_Widget_FarmingTimer_All:GetSizeX() / 2
  local RadarPosY = FGlobal_Panel_Radar_GetPosY() + Panel_Widget_FarmingTimer_All:GetSizeY() / 2
  Panel_Widget_FarmingTimer_All:SetPosX(RadarPosX)
  Panel_Widget_FarmingTimer_All:SetPosY(RadarPosY)
  Panel_Widget_FarmingTimer_All:SetShow(false)
  self._ui.btn_Popup:SetShow(false)
  self._ui.chk_Start:SetCheck(false)
  PaGlobal_FarmingTimerReport:initialize()
  PaGloabl_FarmingTimer_Reset()
  if true == ToClient_getFarmingTimerOpen() then
    PaGlobal_FarmingTimer:prepareOpen()
  end
  self._initialize = true
end
function PaGlobal_FarmingTimer:registEventHandler()
  self._ui.chk_Start:addInputEvent("Mouse_LUp", "PaGloabl_FarmingTimer_StartToggle()")
  self._ui.chk_Start:addInputEvent("Mouse_On", "PaGloabl_FarmingTimer_ShowIconToolTip(true, 0)")
  self._ui.chk_Start:addInputEvent("Mouse_Out", "PaGloabl_FarmingTimer_ShowIconToolTip(false, 0)")
  self._ui.btn_Stop:addInputEvent("Mouse_LUp", "PaGloabl_FarmingTimer_Stop()")
  self._ui.btn_Stop:addInputEvent("Mouse_On", "PaGloabl_FarmingTimer_ShowIconToolTip(true, 2)")
  self._ui.btn_Stop:addInputEvent("Mouse_Out", "PaGloabl_FarmingTimer_ShowIconToolTip(false, 2)")
  self._ui.btn_Reset:addInputEvent("Mouse_LUp", "PaGloabl_FarmingTimer_Reset()")
  self._ui.btn_Reset:addInputEvent("Mouse_On", "PaGloabl_FarmingTimer_ShowIconToolTip(true, 3)")
  self._ui.btn_Reset:addInputEvent("Mouse_Out", "PaGloabl_FarmingTimer_ShowIconToolTip(false, 3)")
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGloabl_FarmingTimer_Close()")
  self._ui.btn_Popup:addInputEvent("Mouse_LUp", "PaGloabl_FarmingTimer_Popup()")
  self._ui.btn_Popup:addInputEvent("Mouse_On", "PaGloabl_FarmingTimer_ShowIconToolTip(true, 5)")
  self._ui.btn_Popup:addInputEvent("Mouse_Out", "PaGloabl_FarmingTimer_ShowIconToolTip(false, 5)")
  self._ui.btn_Report:addInputEvent("Mouse_LUp", "PaGloabl_FarmingTimer_Report()")
  self._ui.btn_Report:addInputEvent("Mouse_On", "PaGloabl_FarmingTimer_ShowIconToolTip(true, 4)")
  self._ui.btn_Report:addInputEvent("Mouse_Out", "PaGloabl_FarmingTimer_ShowIconToolTip(false, 4)")
end
function PaGlobal_FarmingTimer:prepareOpen()
  ToClient_setFarmingTimerOpen(true)
  self._isStart = ToClient_getFarmingStart()
  self._lastUpdateTime = 0
  self._timer = self._lastUpdateTime
  self:timeSetting(self._lastUpdateTime)
  PaGloabl_FarmingTimerReport_CalculationAllMarketPrice()
  PaGlobal_FarmingTimer:open()
end
function PaGlobal_FarmingTimer:open()
  Panel_Widget_FarmingTimer_All:SetShow(true)
end
function PaGlobal_FarmingTimer:prepareClose()
  Panel_Widget_FarmingTimer_All:CloseUISubApp()
  self._ui.btn_Popup:SetCheck(false)
  ToClient_setFarmingTimerOpen(false)
  PaGloabl_FarmingTimerReport_Close()
  PaGloabl_FarmingTimer_Reset()
  PaGlobal_FarmingTimer:close()
end
function PaGlobal_FarmingTimer:close()
  Panel_Widget_FarmingTimer_All:SetShow(false)
end
function PaGlobal_FarmingTimer:update(deltatime)
  if false == self._isStart then
    return
  end
  self._timer = self._timer + deltatime
  if self._timer < self._lastUpdateTime + 1 then
    return
  end
  self:timeSetting(math.floor(self._timer))
end
function PaGlobal_FarmingTimer:timeSetting(lastUpdateTime)
  self._lastUpdateTime = lastUpdateTime
  if 0 == self._lastUpdateTime % 3600 then
    PaGloabl_FarmingTimerReport_CalculationAllMarketPrice()
  end
  local tmpTime = PaGlobal_FarmingTimer._lastUpdateTime
  local hours = math.floor(tmpTime / 3600)
  tmpTime = tmpTime % 3600
  local minutes = math.floor(tmpTime / 60)
  local seconds = tmpTime % 60
  local hoursText = ""
  local minutesText = ""
  local secondsText = ""
  if hours < 10 then
    hoursText = minutesText .. "0" .. tostring(hours)
  else
    hoursText = minutesText .. tostring(hours)
  end
  if minutes < 10 then
    minutesText = minutesText .. "0" .. tostring(minutes)
  else
    minutesText = minutesText .. tostring(minutes)
  end
  if seconds < 10 then
    secondsText = secondsText .. "0" .. tostring(seconds)
  else
    secondsText = secondsText .. tostring(seconds)
  end
  self._ui.txt_Time:SetText(hoursText .. ":" .. minutesText .. ":" .. secondsText)
end
function PaGlobal_FarmingTimer:validate()
  self._ui.chk_Start:isValidate()
  self._ui.btn_Stop:isValidate()
  self._ui.btn_Reset:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.btn_Popup:isValidate()
  self._ui.btn_Report:isValidate()
end
function PaGlobal_FarmingTimer:startToggle()
  self._isStart = self._ui.chk_Start:IsCheck()
  self._isReportOpenPossible = false
  ToClient_setFarmingStart(self._isStart)
  self._timer = self._lastUpdateTime
  PaGloabl_FarmingTimerReport_Close()
end
function PaGlobal_FarmingTimer:stopBtn()
  self._ui.chk_Start:SetCheck(false)
  self._isStart = self._ui.chk_Start:IsCheck()
  self._isReportOpenPossible = true
  ToClient_setFarmingStart(self._isStart)
  self._timer = self._lastUpdateTime
end
function PaGlobal_FarmingTimer:resetBtn()
  self._ui.chk_Start:SetCheck(false)
  self._isStart = self._ui.chk_Start:IsCheck()
  self._isReportOpenPossible = true
  self._lastUpdateTime = 0
  self._timer = self._lastUpdateTime
  self._ui.txt_Time:SetText("00:00:00")
  ToClient_setFarmingStart(self._isStart)
  ToClient_resetFarmingList()
  PaGloabl_FarmingTimerReport_Reset()
end
function PaGlobal_FarmingTimer:reportBtn()
  if true == self._isReportOpenPossible then
    PaGloabl_FarmingTimerReport_Open()
  end
end
function PaGlobal_FarmingTimer:popUp()
  if true == self._ui.btn_Popup:IsCheck() then
    Panel_Widget_FarmingTimer_All:OpenUISubApp()
  else
    Panel_Widget_FarmingTimer_All:CloseUISubApp()
  end
end
function PaGlobal_FarmingTimer:showIconToolTip(isShow, idx)
  if true == isShow then
    local name = ""
    local desc = ""
    if self._config._eStart == idx then
      if false == self._ui.chk_Start:IsCheck() then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_FARMING_START")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_FARMING_START_DESC")
      else
        name = PAGetString(Defines.StringSheet_GAME, "LUA_FARMING_PAUSE")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_FARMING_PAUSE_DESC")
      end
    elseif self._config._eStop == idx then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_FARMING_STOP")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_FARMING_STOP_DESC")
    elseif self._config._eReset == idx then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_FARMING_RESET")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_FARMING_RESET_DESC")
    elseif self._config._eReport == idx then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_FARMING_REPORT")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_FARMING_REPORT_DESC")
    elseif self._config._ePopup == idx then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
      if self._ui.btn_Popup:IsCheck() then
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
      else
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
      end
    end
    TooltipSimple_Show(self._ui.btn_Popup, name, desc)
  else
    TooltipSimple_Hide()
  end
end
