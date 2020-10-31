function PaGlobal_PowerGauge_All:initialize()
  if true == PaGlobal_PowerGauge_All._initialize then
    return
  end
  self._ui._progress_gauge = UI.getChildControl(Panel_Widget_PowerGauge_All, "Progress2_Gauge")
  self._ui._txt_gaugeValue = UI.getChildControl(Panel_Widget_PowerGauge_All, "StaticText_GaugeValue")
  PaGlobal_PowerGauge_All:registEventHandler()
  PaGlobal_PowerGauge_All:validate()
  PaGlobal_PowerGauge_All._initialize = true
end
function PaGlobal_PowerGauge_All:registEventHandler()
  if nil == Panel_Widget_PowerGauge_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_PowerGauge_All_Resize")
end
function PaGlobal_PowerGauge_All:prepareOpen()
  if nil == Panel_Widget_PowerGauge_All then
    return
  end
  if true == Panel_Widget_PowerGauge_All:GetShow() then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  self._wpValue = selfPlayer:getWp()
  if 0 == self._wpValue then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_POWERGAUGE_NOPOWER"))
  end
  self._ui._progress_gauge:SetProgressRate(0)
  self._ui._progress_gauge:SetCurrentProgressRate(0)
  self._ui._txt_gaugeValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_POWERGAUGE_READY"))
  PaGlobal_PowerGauge_All:reposition()
  PaGlobal_PowerGauge_All:open()
end
function PaGlobal_PowerGauge_All:open()
  if nil == Panel_Widget_PowerGauge_All then
    return
  end
  Panel_Widget_PowerGauge_All:SetShow(true)
end
function PaGlobal_PowerGauge_All:prepareClose()
  if nil == Panel_Widget_PowerGauge_All then
    return
  end
  if false == Panel_Widget_PowerGauge_All:GetShow() then
    return
  end
  Panel_Widget_PowerGauge_All:ClearUpdateLuaFunc()
  PaGlobal_PowerGauge_All:close()
end
function PaGlobal_PowerGauge_All:close()
  if nil == Panel_Widget_PowerGauge_All then
    return
  end
  Panel_Widget_PowerGauge_All:SetShow(false)
end
function PaGlobal_PowerGauge_All:validate()
  if nil == Panel_Widget_PowerGauge_All then
    return
  end
  self._ui._progress_gauge:isValidate()
  self._ui._txt_gaugeValue:isValidate()
end
function PaGlobal_PowerGauge_All:startUpdateFrame()
  Panel_Widget_PowerGauge_All:RegisterUpdateFunc("PaGlobal_PowerGauge_All_UpdatePerFrame")
end
function PaGlobal_PowerGauge_All:updatePerFrame(deltaTime)
  local nowPower = ToClient_getCommonGauge()
  local maxPower = ToClient_getMaxCommonGauge()
  local percent = nowPower / maxPower * 100
  if self._wpValue < math.floor(nowPower) or math.floor(nowPower) > 10 and math.floor(nowPower) < 0 then
    return
  end
  self._ui._txt_gaugeValue:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_POWERGAUGE_PROGRESSVALUE", "percent", string.format("%d", math.floor(nowPower))))
  self._ui._progress_gauge:SetProgressRate(percent)
  self._ui._progress_gauge:SetCurrentProgressRate(percent)
end
function PaGlobal_PowerGauge_All:reposition()
  if nil == Panel_Widget_PowerGauge_All then
    return
  end
  Panel_Widget_PowerGauge_All:SetPosX(getScreenSizeX() * 0.5 - Panel_Widget_PowerGauge_All:GetSizeX() * 1.9)
  Panel_Widget_PowerGauge_All:SetPosY(getScreenSizeY() * 0.5 - Panel_Widget_PowerGauge_All:GetSizeY() / 1.8)
end
