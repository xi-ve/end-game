function PaGlobal_ShipSpeedGauge:initialize()
  if true == PaGlobal_ShipSpeedGauge._initialize then
    return
  end
  self._ui._stc_progressBG = UI.getChildControl(Panel_Widget_ShipSpeedGauge, "Static_ProgressBar_BG")
  self._ui._stc_progressBar = UI.getChildControl(Panel_Widget_ShipSpeedGauge, "Progress2_SpeedGauge")
  PaGlobal_ShipSpeedGauge:registEventHandler()
  PaGlobal_ShipSpeedGauge:validate()
  PaGlobal_ShipSpeedGauge._initialize = true
  if true == ToClient_isConsole() and nil ~= Panel_HorseHp then
    Panel_Widget_ShipSpeedGauge:SetVerticalMiddle()
    local newSpan = Panel_HorseHp:GetSpanSize().y - Panel_Widget_ShipSpeedGauge:GetSizeY()
    Panel_Widget_ShipSpeedGauge:SetSpanSize(Panel_Widget_ShipSpeedGauge:GetSpanSize().x, newSpan)
    Panel_Widget_ShipSpeedGauge:ComputePos()
  end
end
function PaGlobal_ShipSpeedGauge:registEventHandler()
  if nil == Panel_Widget_ShipSpeedGauge then
    return
  end
  registerEvent("EventSelfPlayerRideOn", "FromClient_ShipSpeedGauge_PlayerRideOn")
  registerEvent("EventSelfPlayerRideOff", "FromClient_ShipSpeedGauge_PlayerRideOff")
  registerEvent("EventSelfPlayerCarrierChanged", "FromClient_ShipSpeedGauge_CarriageChange")
  Panel_Widget_ShipSpeedGauge:RegisterUpdateFunc("UpdateFunc_ShipSpeedGauge_UpdateSpeedGauge")
end
function PaGlobal_ShipSpeedGauge:prepareOpen()
  if nil == Panel_Widget_ShipSpeedGauge then
    return
  end
  if false == _ContentsGroup_OceanCurrent then
    return
  end
  local seatPosition = getSelfPlayer():get():getVehicleSeatIndex()
  if 0 ~= seatPosition then
    return
  end
  PaGlobal_ShipSpeedGauge:open()
end
function PaGlobal_ShipSpeedGauge:open()
  if nil == Panel_Widget_ShipSpeedGauge then
    return
  end
  Panel_Widget_ShipSpeedGauge:SetShow(true)
end
function PaGlobal_ShipSpeedGauge:prepareClose()
  if nil == Panel_Widget_ShipSpeedGauge then
    return
  end
  PaGlobal_ShipSpeedGauge:close()
end
function PaGlobal_ShipSpeedGauge:close()
  if nil == Panel_Widget_ShipSpeedGauge then
    return
  end
  Panel_Widget_ShipSpeedGauge:SetShow(false)
end
function PaGlobal_ShipSpeedGauge:validate()
  if nil == Panel_Widget_ShipSpeedGauge then
    return
  end
  PaGlobal_ShipSpeedGauge._ui._stc_progressBG:isValidate()
  PaGlobal_ShipSpeedGauge._ui._stc_progressBar:isValidate()
end
